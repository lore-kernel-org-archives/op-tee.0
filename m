From: Ulf Hansson <ulf.hansson@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Mon, 25 Mar 2024 14:33:48 +0100
Message-ID: 
 <CAPDyKFqzy9Tz9rC0gLbY5zyaGtLX6F_Le4bNzMb3=BhCoexGvg@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPH7PR11MB76054BC0C863E5947C7B2DAFE5362=40PH7PR11MB?=
 =?utf-8?q?7605=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7321580712452532117=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7321580712452532117==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 at 09:23, Winkler, Tomas <tomas.winkler@intel.com> wrot=
e:
>
>
> > > > +struct rpmb_frame {
> > > > +       u8     stuff[196];
> > > > +       u8     key_mac[32];
> > > > +       u8     data[256];
> > > > +       u8     nonce[16];
> > > > +       __be32 write_counter;
> > > > +       __be16 addr;
> > > > +       __be16 block_count;
> > > > +       __be16 result;
> > > > +       __be16 req_resp;
> > > > +} __packed;
> > >
> > > I haven't looked at the NVME or the UFS spec in detail. Although, I
> > > assume the above frame makes sense for those types of
> > interfaces/protocols too?
> > The rpmb implementation in ufs, has drifted apart from eMMC. E.g. in
> > UFS4.0:
> >  -  the frame is different - see struct ufs_arpmb_meta in
> > include/uapi/scsi/scsi_bsg_ufs.h,
> >  - Additional extended header was added,
> >  - the frame size is no longer 512Bytes (256Bytes meta info + 256Bytes da=
ta)
> > but 4k,
> >  - there are 9 rpmb operations instead of 7,
> >  - The atomicity requirement of the command sequence was waved, And
> > probably more differences that I forgot.
> > This is why it is better to designated this as an eMMC-only implementatio=
n?
>
> As  I wrote previously the original implementation has already resolved pro=
tocol differences
>  (NVMe have also different byte ordering) for closed usecase of storing dat=
a (not the configuration)
> I believe the whole point here is to let TEE driver to store the data, rega=
rdless of the technology.

Yes, I also agree. It makes sense to have a generic way to manage RPMB
partitions, even if there are some specific parts that must be managed
differently based on the underlying technology.

That said, I tend to think that we actually want the UFS and NVMe
implementation being included in the $subject series too. To get the
complete picture. Otherwise, we may just end up having to redesign a
lot of things, if we just start with eMMC.

>  In addition I might be wrong but I don't see much value in eMMC as the UFS=
 and NVMe are currently leading technologies.

Even if UFS and NVMe have been taking over some of the earlier eMMC
product segments, I think it's too soon to declare eMMC dead. :-)

Moreover, we also have older platforms that we want to get supported
upstream and allowing them to move away from downstream-hacks, is also
a very good reason to add eMMC support.

> Thanks
> Tomas
>

Kind regards
Uffe

--===============7321580712452532117==--

