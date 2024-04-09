From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Date: Tue, 09 Apr 2024 14:00:01 +0200
Message-ID: 
 <CAHUa44EfLjZkeS0HFTf4gvBiwZj3682t0JSWx_=rb9xfagbWLQ@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPH7PR11MB76050B745987B7169C8EDA0EE5022=40PH7PR11MB?=
 =?utf-8?q?7605=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5583892822570684915=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5583892822570684915==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 5:31=E2=80=AFPM Winkler, Tomas <tomas.winkler@intel.=
com> wrote:
>
> >
> >
> > > +
> > > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication
> > You expect the key to be already programmed - so you don't really need th=
is
> > operation?
> Depends in what manufacturing flow you program the device,  second I believ=
e in the original series was also a simulation device,
> This is important as the real device can be programmed only once.

This isn't strictly needed, this is the only "nice to have" feature
I've kept because it's easy enough and can be useful. I can remove it
if it's important.

> >
> > > Key */
> > > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter
> > */
> > > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition =
*/
> > > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition
> > */
> > > +#define RPMB_RESULT_READ       0x5    /* Read result request  (Interna=
l)
> > */
> > > +
> > >  static DEFINE_MUTEX(block_mutex);
> > >
> > >  /*
> > > @@ -163,6 +205,7 @@ struct mmc_rpmb_data {
> > >         int id;
> > >         unsigned int part_index;
> > >         struct mmc_blk_data *md;
> > > +       struct rpmb_dev *rdev;
> > >         struct list_head node;
> > >  };
> > >
> > > @@ -2672,7 +2715,6 @@ static int mmc_rpmb_chrdev_open(struct inode
> > > *inode, struct file *filp)
> > >
> > >         get_device(&rpmb->dev);
> > >         filp->private_data =3D rpmb;
> > > -       mmc_blk_get(rpmb->md->disk);
> > Maybe add a comment that this has moved to mmc_blk_alloc_rpmb_part?
> > For those who will look for it.

Such a comment seems odd. Those looking for mmc_blk_get() should be
able to find it easily. I'll add the comment if it's important.

> >
> > >
> > >         return nonseekable_open(inode, filp);  } @@ -2682,7 +2724,6 @@
> > > static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *fi=
lp)
> > >         struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cdev,
> > >                                                   struct
> > > mmc_rpmb_data, chrdev);
> > >
> > > -       mmc_blk_put(rpmb->md);
> > Ditto.

See my answer above.

> >
> > >         put_device(&rpmb->dev);
> > >
> > >         return 0;
> > > @@ -2703,10 +2744,157 @@ static void
> > > mmc_blk_rpmb_device_release(struct
> > > device *dev)  {
> > >         struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > >
> > > +       rpmb_dev_unregister(rpmb->rdev);
> > > +       mmc_blk_put(rpmb->md);
> > >         ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> > >         kfree(rpmb);
> > >  }
> > >
> > > +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int
> > > +cmd_count) {
> > > +       unsigned int n;
> > > +
> > > +       for (n =3D 0; n < cmd_count; n++)
> > > +               kfree(idata[n]);
> > > +       kfree(idata);
> > > +}
> > > +
> > > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data
> > *rpmb,
> > > +                                            unsigned int cmd_count) {
> > > +       struct mmc_blk_ioc_data **idata;
> > > +       unsigned int n;
> > > +
> > > +       idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> > > +       if (!idata)
> > > +               return NULL;
> > > +
> > > +       for (n =3D 0; n < cmd_count; n++) {
> > > +               idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KERNEL);
> > > +               if (!idata[n]) {
> > > +                       free_idata(idata, n);
> > > +                       return NULL;
> > > +               }
> > > +               idata[n]->rpmb =3D rpmb;
> > > +       }
> > > +
> > > +       return idata;
> > > +}
> > > +
> > > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> > > +                     int write_flag, u8 *buf, unsigned int buf_bytes) {
> > > +       idata->ic.opcode =3D opcode;
> > > +       idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> > > +       idata->ic.write_flag =3D write_flag;
> > > +       idata->ic.blksz =3D sizeof(struct rpmb_frame);
> > blksz =3D 512, so maybe add a compile-time check on sizeof(struct
> > rpmb_frame)?

That makes sense, I'll add it.

> >
> > > +       idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> > > +       idata->buf =3D buf;
> > > +       idata->buf_bytes =3D buf_bytes;
> > > +}
> > > +
> > > +static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
> > > +                                unsigned int req_len, u8 *resp,
> > > +                                unsigned int resp_len) {
> > > +       struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
> > > +       struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > > +       struct mmc_blk_data *md =3D rpmb->md;
> > > +       struct mmc_blk_ioc_data **idata;
> > > +       unsigned int cmd_count;
> > > +       struct request *rq;
> > > +       u16 req_type;
> > > +       bool write;
> > > +       int ret;
> > > +
> > > +       if (IS_ERR(md->queue.card))
> > > +               return PTR_ERR(md->queue.card);
> > > +
> > > +       if (req_len < sizeof(*frm))
> > > +               return -EINVAL;
> > > +
> > > +       req_type =3D be16_to_cpu(frm->req_resp);
> > > +       switch (req_type) {
> > > +       case RPMB_PROGRAM_KEY:
> > > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > > +                   resp_len !=3D sizeof(struct rpmb_frame))
> > > +                       return -EINVAL;
> > > +               write =3D true;
> > > +               break;
> > > +       case RPMB_GET_WRITE_COUNTER:
> > > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > > +                   resp_len !=3D sizeof(struct rpmb_frame))
> > > +                       return -EINVAL;
> > > +               write =3D false;
> > > +               break;
> > > +       case RPMB_WRITE_DATA:
> > > +               if (req_len % sizeof(struct rpmb_frame) ||
> > > +                   resp_len !=3D sizeof(struct rpmb_frame))
> > > +                       return -EINVAL;
> > > +               write =3D true;
> > > +               break;
> > > +       case RPMB_READ_DATA:
> > > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > > +                   resp_len % sizeof(struct rpmb_frame))
> > > +                       return -EINVAL;
> > > +               write =3D false;
> > > +               break;
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > Looks like the above input validation section can be reduced to is
> > RPMB_WRITE_DATA and default?

RPMB_GET_WRITE_COUNTER and RPMB_READ_DATA have different checks for resp_len.

> >
> > > +
> > > +       if (write)
> > > +               cmd_count =3D 3;
> > > +       else
> > > +               cmd_count =3D 2;
> > > +
> > > +       idata =3D alloc_idata(rpmb, cmd_count);
> > > +       if (!idata)
> > > +               return -ENOMEM;
> > > +
> > > +       if (write) {
> > > +               struct rpmb_frame *frm =3D (struct rpmb_frame *)resp;
> > > +
> > > +               /* Send write request frame(s) */
> > > +               set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
> > > +                         1 | MMC_CMD23_ARG_REL_WR, req, req_len);
> > > +
> > > +               /* Send result request frame */
> > > +               memset(frm, 0, sizeof(*frm));
> > > +               frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
> > > +               set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
> > > +                         resp_len);
> > > +
> > > +               /* Read response frame */
> > > +               set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp,
> > > resp_len);
> > It is confusing to me that your response is holding 2 frame types:
> > The status frame and the response frame.
> Refer to the spec.
>
> >
> >
> > > +       } else {
> > > +               /* Send write request frame(s) */
> > > +               set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req,
> > > + req_len);
> > > +
> > > +               /* Read response frame */
> > > +               set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp,
> > > resp_len);
> > > +       }
> > > +
> > > +       rq =3D blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT,
> > 0);
> > > +       if (IS_ERR(rq)) {
> > > +               ret =3D PTR_ERR(rq);
> > > +               goto out;
> > > +       }
> > > +
> > > +       req_to_mmc_queue_req(rq)->drv_op =3D
> > MMC_DRV_OP_IOCTL_RPMB;
> > > +       req_to_mmc_queue_req(rq)->drv_op_result =3D -EIO;
> > > +       req_to_mmc_queue_req(rq)->drv_op_data =3D idata;
> > > +       req_to_mmc_queue_req(rq)->ioc_count =3D cmd_count;
> > Maybe have an additional struct mmc_queue_req *mq_rq =3D
> > req_to_mmc_queue_req(rq);

Sure, I'll add it.

> >
> > > +       blk_execute_rq(rq, false);
> > > +       ret =3D req_to_mmc_queue_req(rq)->drv_op_result;
> > > +
> > > +       blk_mq_free_request(rq);
> > > +
> > > +out:
> > > +       free_idata(idata, cmd_count);
> > > +       return ret;
> > > +}
> > > +
> > >  static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
> > >                                    struct mmc_blk_data *md,
> > >                                    unsigned int part_index, @@ -2741,6
> > > +2929,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
> > >         rpmb->dev.release =3D mmc_blk_rpmb_device_release;
> > >         device_initialize(&rpmb->dev);
> > >         dev_set_drvdata(&rpmb->dev, rpmb);
> > > +       mmc_blk_get(md->disk);
> > >         rpmb->md =3D md;
> > >
> > >         cdev_init(&rpmb->chrdev, &mmc_rpmb_fileops); @@ -3002,6
> > > +3191,41 @@ static void mmc_blk_remove_debugfs(struct mmc_card
> > *card,
> > >
> > >  #endif /* CONFIG_DEBUG_FS */
> > >
> > > +static void mmc_blk_rpmb_add(struct mmc_card *card) {
> > > +       struct mmc_blk_data *md =3D dev_get_drvdata(&card->dev);
> > > +       struct mmc_rpmb_data *rpmb;
> > > +       struct rpmb_dev *rdev;
> > > +       unsigned int n;
> > > +       u32 cid[4];
> > > +       struct rpmb_descr descr =3D {
> > > +               .type =3D RPMB_TYPE_EMMC,
> > > +               .route_frames =3D mmc_route_rpmb_frames,
> > > +               .reliable_wr_count =3D card->ext_csd.raw_rpmb_size_mult,
> > > +               .capacity =3D card->ext_csd.rel_sectors,
> > The capacity is RPMB_SIZE_MULT and also limited to 16MB?

Thanks for noticing this, I'll fix it. Yes, the spec says it's limited to 16M=
B.

> > And you also need the region size you are writing to.
> > If I get your intention regarding reliable_wr_count, AFAIK, rpmb can be
> > written either as a single, double, or 32 frames.
> > And this should be induced from card->ext_csd.rel_param, and not card-
> > >ext_csd.rel_sectors.
> This may change in the spec since this patch was written it was few years a=
go.

Thanks, I'll fix it.

> >
> > > +               .dev_id =3D (void *)cid,
> > > +               .dev_id_len =3D sizeof(cid),
> > > +       };
> > > +
> > > +       /*
> > > +        * Provice CID as an octet array. The CID needs to be interpret=
ed
> > > +        * when used as input to derive the RPMB key since some fields
> > > +        * will change due to firmware updates.
> > > +        */
> > Not sure how the CID register is related to RPMB?
> > Is this something internal to TEE?
> Yes to identify the device.

+1

Thanks,
Jens

> >
> > > +       for (n =3D 0; n < 4; n++)
> > > +               cid[n] =3D be32_to_cpu(card->raw_cid[n]);
> > > +
> > > +       list_for_each_entry(rpmb, &md->rpmbs, node) {
> > > +               rdev =3D rpmb_dev_register(&rpmb->dev, &descr);
> > > +               if (IS_ERR(rdev)) {
> > > +                       pr_warn("%s: could not register RPMB device\n",
> > > +                               dev_name(&rpmb->dev));
> > > +                       continue;
> > > +               }
> > > +               rpmb->rdev =3D rdev;
> > > +       }
> > > +}
> > > +
> >
> > Thanks,
> > Avri

--===============5583892822570684915==--

