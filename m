From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v3 2/3] mmc: block: register RPMB partition with the RPMB subsystem
Date: Tue, 27 Feb 2024 16:31:31 +0100
Message-ID: <20240227153132.2611499-3-jens.wiklander@linaro.org>
In-Reply-To: <20240227153132.2611499-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9010244693626977289=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9010244693626977289==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Register eMMC RPMB partition with the RPMB subsystem and provide
an implementation for the RPMB access operations abstracting
the actual multi step process.

Add a callback to extract the needed device information at registration
to avoid accessing the struct mmc_card at a later stage as we're not
holding a reference counter for this struct.

Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
instead of in mmc_rpmb_chrdev_open(). This is needed by the
route_frames() function pointer in struct rpmb_ops.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/mmc/core/block.c | 153 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32d49100dff5..f35c99638eb2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -33,6 +33,7 @@
 #include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
+#include <linux/string.h>
 #include <linux/string_helpers.h>
 #include <linux/delay.h>
 #include <linux/capability.h>
@@ -40,6 +41,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/idr.h>
 #include <linux/debugfs.h>
+#include <linux/rpmb.h>
=20
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -163,6 +165,7 @@ struct mmc_rpmb_data {
 	int id;
 	unsigned int part_index;
 	struct mmc_blk_data *md;
+	struct rpmb_dev *rdev;
 	struct list_head node;
 };
=20
@@ -2672,7 +2675,6 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, st=
ruct file *filp)
=20
 	get_device(&rpmb->dev);
 	filp->private_data =3D rpmb;
-	mmc_blk_get(rpmb->md->disk);
=20
 	return nonseekable_open(inode, filp);
 }
@@ -2682,7 +2684,6 @@ static int mmc_rpmb_chrdev_release(struct inode *inode,=
 struct file *filp)
 	struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cdev,
 						  struct mmc_rpmb_data, chrdev);
=20
-	mmc_blk_put(rpmb->md);
 	put_device(&rpmb->dev);
=20
 	return 0;
@@ -2703,10 +2704,147 @@ static void mmc_blk_rpmb_device_release(struct devic=
e *dev)
 {
 	struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
=20
+	rpmb_dev_unregister(rpmb->rdev);
+	mmc_blk_put(rpmb->md);
 	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
 	kfree(rpmb);
 }
=20
+static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int cmd_cou=
nt)
+{
+	unsigned int n;
+
+	for (n =3D 0; n < cmd_count; n++)
+		kfree(idata[n]);
+	kfree(idata);
+}
+
+static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpmb,
+					     unsigned int cmd_count)
+{
+	struct mmc_blk_ioc_data **idata;
+	unsigned int n;
+
+	idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
+	if (!idata)
+		return NULL;
+
+	for (n =3D 0; n < cmd_count; n++) {
+		idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KERNEL);
+		if (!idata[n]) {
+			free_idata(idata, n);
+			return NULL;
+		}
+		idata[n]->rpmb =3D rpmb;
+	}
+
+	return idata;
+}
+
+static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
+		      int write_flag, u8 *buf, unsigned int buf_bytes)
+{
+	idata->ic.opcode =3D opcode;
+	idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
+	idata->ic.write_flag =3D write_flag;
+	idata->ic.blksz =3D sizeof(struct rpmb_frame);
+	idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
+	idata->buf =3D buf;
+	idata->buf_bytes =3D buf_bytes;
+}
+
+static int rpmb_op_mmc_route_frames(struct device *dev, bool write, u8 *req,
+				    unsigned int req_len, u8 *resp,
+				    unsigned int resp_len)
+{
+	struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
+	struct mmc_blk_data *md =3D rpmb->md;
+	struct mmc_blk_ioc_data **idata;
+	unsigned int cmd_count;
+	struct request *rq;
+	int ret;
+
+	if (write)
+		cmd_count =3D 3;
+	else
+		cmd_count =3D 2;
+
+	if (IS_ERR(md->queue.card))
+		return PTR_ERR(md->queue.card);
+
+	idata =3D alloc_idata(rpmb, cmd_count);
+	if (!idata)
+		return -ENOMEM;
+
+	if (write) {
+		struct rpmb_frame *frm =3D (struct rpmb_frame *)resp;
+
+		/* Send write request frame(s) */
+		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
+			  1 | MMC_CMD23_ARG_REL_WR, req, req_len);
+
+		/* Send result request frame */
+		memset(frm, 0, sizeof(*frm));
+		frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
+		set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
+			  resp_len);
+
+		/* Read response frame */
+		set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
+	} else {
+		/* Send write request frame(s) */
+		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req, req_len);
+
+		/* Read response frame */
+		set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
+	}
+
+	rq =3D blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT, 0);
+	if (IS_ERR(rq)) {
+		ret =3D PTR_ERR(rq);
+		goto out;
+	}
+
+	req_to_mmc_queue_req(rq)->drv_op =3D MMC_DRV_OP_IOCTL_RPMB;
+	req_to_mmc_queue_req(rq)->drv_op_result =3D -EIO;
+	req_to_mmc_queue_req(rq)->drv_op_data =3D idata;
+	req_to_mmc_queue_req(rq)->ioc_count =3D cmd_count;
+	blk_execute_rq(rq, false);
+	ret =3D req_to_mmc_queue_req(rq)->drv_op_result;
+
+	blk_mq_free_request(rq);
+
+out:
+	free_idata(idata, cmd_count);
+	return ret;
+}
+
+static int rpmb_op_mmc_set_dev_info(struct device *dev, struct rpmb_dev *rde=
v)
+{
+	struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
+	struct mmc_card *card =3D rpmb->md->queue.card;
+	unsigned int n;
+	u32 cid[4];
+
+	for (n =3D 0; n < 4; n++)
+		cid[n] =3D be32_to_cpu(card->raw_cid[n]);
+
+	rdev->dev_id =3D kmemdup(cid, sizeof(cid), GFP_KERNEL);
+	if (!rdev->dev_id)
+		return -ENOMEM;
+	rdev->dev_id_len =3D sizeof(cid);
+	rdev->reliable_wr_count =3D card->ext_csd.raw_rpmb_size_mult;
+	rdev->capacity =3D card->ext_csd.rel_sectors;
+
+	return 0;
+}
+
+static struct rpmb_ops rpmb_mmc_ops =3D {
+	.type =3D RPMB_TYPE_EMMC,
+	.route_frames =3D rpmb_op_mmc_route_frames,
+	.set_dev_info =3D rpmb_op_mmc_set_dev_info,
+};
+
 static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 				   struct mmc_blk_data *md,
 				   unsigned int part_index,
@@ -2741,6 +2879,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *car=
d,
 	rpmb->dev.release =3D mmc_blk_rpmb_device_release;
 	device_initialize(&rpmb->dev);
 	dev_set_drvdata(&rpmb->dev, rpmb);
+	mmc_blk_get(md->disk);
 	rpmb->md =3D md;
=20
 	cdev_init(&rpmb->chrdev, &mmc_rpmb_fileops);
@@ -2751,6 +2890,14 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *ca=
rd,
 		goto out_put_device;
 	}
=20
+	rpmb->rdev =3D rpmb_dev_register(&rpmb->dev, &rpmb_mmc_ops);
+	if (IS_ERR(rpmb->rdev)) {
+		pr_err("%s: could not register RPMB device\n", rpmb_name);
+		ret =3D PTR_ERR(rpmb->rdev);
+		rpmb->rdev =3D NULL;
+		goto out_cdev_device_del;
+	}
+
 	list_add(&rpmb->node, &md->rpmbs);
=20
 	string_get_size((u64)size, 512, STRING_UNITS_2,
@@ -2762,6 +2909,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *car=
d,
=20
 	return 0;
=20
+out_cdev_device_del:
+	cdev_device_del(&rpmb->chrdev, &rpmb->dev);
 out_put_device:
 	put_device(&rpmb->dev);
 	return ret;
--=20
2.34.1


--===============9010244693626977289==--

