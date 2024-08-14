From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 5/7] firmware: arm_ffa: Add support for
 FFA_MSG_SEND_DIRECT_{REQ,RESP}2
Date: Wed, 14 Aug 2024 14:48:54 +0100
Message-ID: <20240814-ffa_v1-2-v1-5-9e9abef69b21@arm.com>
In-Reply-To: <20240814-ffa_v1-2-v1-0-9e9abef69b21@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1063551435865255328=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1063551435865255328==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

FFA_MSG_SEND_DIRECT_{REQ,RESP} supported only x3-x7 to pass implementation
defined values as part of the message. This may not be sufficient sometimes
and also it would be good to use all the registers supported by SMCCC v1.2
(x0-x17) for such register based communication.

Also another limitation with the FFA_MSG_SEND_DIRECT_{REQ,RESP} is the
ability to target a specific service within the partition based on it's
UUID.

In order to address both of the above limitation, FF-A v1.2 introduced
FFA_MSG_SEND_DIRECT_{REQ,RESP}2 which has the ability to target the
message to a specific service based on its UUID within a partition as
well as utilise all the available registers(x4-x17 specifically) for
the communication.

This change adds support for FFA_MSG_SEND_DIRECT_REQ2 and
FFA_MSG_SEND_DIRECT_RESP2.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 49 +++++++++++++++++++++++++++++++++++++=
--
 include/linux/arm_ffa.h           |  7 ++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index e28cbfe9a801..8af41be4b1c1 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -99,6 +99,7 @@ struct ffa_drv_info {
 	void *rx_buffer;
 	void *tx_buffer;
 	bool mem_ops_native;
+	bool msg_direct_req2_supp;
 	bool bitmap_created;
 	bool notif_enabled;
 	unsigned int sched_recv_irq;
@@ -468,6 +469,35 @@ static int ffa_msg_send2(u16 src_id, u16 dst_id, void *b=
uf, size_t sz)
 	return retval;
 }
=20
+static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uu=
id,
+				    struct ffa_send_direct_data2 *data)
+{
+	u32 src_dst_ids =3D PACK_TARGET_INFO(src_id, dst_id);
+	ffa_value_t ret, args =3D {
+		.a0 =3D FFA_MSG_SEND_DIRECT_REQ2, .a1 =3D src_dst_ids,
+	};
+
+	export_uuid((u8 *)&args.a2, uuid);
+	memcpy(&args.a4, data, sizeof(*data));
+
+	invoke_ffa_fn(args, &ret);
+
+	while (ret.a0 =3D=3D FFA_INTERRUPT)
+		invoke_ffa_fn((ffa_value_t){
+			      .a0 =3D FFA_RUN, .a1 =3D ret.a1,
+			      }, &ret);
+
+	if (ret.a0 =3D=3D FFA_ERROR)
+		return ffa_to_linux_errno((int)ret.a2);
+
+	if (ret.a0 =3D=3D FFA_MSG_SEND_DIRECT_RESP2) {
+		memcpy(data, &args.a4, sizeof(*data));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int ffa_mem_first_frag(u32 func_id, phys_addr_t buf, u32 buf_sz,
 			      u32 frag_len, u32 len, u64 *handle)
 {
@@ -923,11 +953,15 @@ static int ffa_run(struct ffa_device *dev, u16 vcpu)
 	return 0;
 }
=20
-static void ffa_set_up_mem_ops_native_flag(void)
+static void ffa_drvinfo_flags_init(void)
 {
 	if (!ffa_features(FFA_FN_NATIVE(MEM_LEND), 0, NULL, NULL) ||
 	    !ffa_features(FFA_FN_NATIVE(MEM_SHARE), 0, NULL, NULL))
 		drv_info->mem_ops_native =3D true;
+
+	if (!ffa_features(FFA_MSG_SEND_DIRECT_REQ2, 0, NULL, NULL) ||
+	    !ffa_features(FFA_MSG_SEND_DIRECT_RESP2, 0, NULL, NULL))
+		drv_info->msg_direct_req2_supp =3D true;
 }
=20
 static u32 ffa_api_version_get(void)
@@ -973,6 +1007,16 @@ static int ffa_indirect_msg_send(struct ffa_device *dev=
, void *buf, size_t sz)
 	return ffa_msg_send2(drv_info->vm_id, dev->vm_id, buf, sz);
 }
=20
+static int ffa_sync_send_receive2(struct ffa_device *dev, const uuid_t *uuid,
+				  struct ffa_send_direct_data2 *data)
+{
+	if (!drv_info->msg_direct_req2_supp)
+		return -EOPNOTSUPP;
+
+	return ffa_msg_send_direct_req2(drv_info->vm_id, dev->vm_id,
+					uuid, data);
+}
+
 static int ffa_memory_share(struct ffa_mem_ops_args *args)
 {
 	if (drv_info->mem_ops_native)
@@ -1256,6 +1300,7 @@ static const struct ffa_msg_ops ffa_drv_msg_ops =3D {
 	.mode_32bit_set =3D ffa_mode_32bit_set,
 	.sync_send_receive =3D ffa_sync_send_receive,
 	.indirect_send =3D ffa_indirect_msg_send,
+	.sync_send_receive2 =3D ffa_sync_send_receive2,
 };
=20
 static const struct ffa_mem_ops ffa_drv_mem_ops =3D {
@@ -1708,7 +1753,7 @@ static int __init ffa_init(void)
 	mutex_init(&drv_info->rx_lock);
 	mutex_init(&drv_info->tx_lock);
=20
-	ffa_set_up_mem_ops_native_flag();
+	ffa_drvinfo_flags_init();
=20
 	ffa_notifications_setup();
=20
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index b34f0c0dc2c5..a28e2a6a13d0 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -270,6 +270,11 @@ struct ffa_indirect_msg_hdr {
 	u32 size;
 };
=20
+/* For use with FFA_MSG_SEND_DIRECT_{REQ,RESP}2 which pass data via register=
s */
+struct ffa_send_direct_data2 {
+	unsigned long data[14]; /* x4-x17 */
+};
+
 struct ffa_mem_region_addr_range {
 	/* The base IPA of the constituent memory region, aligned to 4 kiB */
 	u64 address;
@@ -431,6 +436,8 @@ struct ffa_msg_ops {
 	int (*sync_send_receive)(struct ffa_device *dev,
 				 struct ffa_send_direct_data *data);
 	int (*indirect_send)(struct ffa_device *dev, void *buf, size_t sz);
+	int (*sync_send_receive2)(struct ffa_device *dev, const uuid_t *uuid,
+				  struct ffa_send_direct_data2 *data);
 };
=20
 struct ffa_mem_ops {

--=20
2.46.0


--===============1063551435865255328==--

