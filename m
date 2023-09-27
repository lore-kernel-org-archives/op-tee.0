From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Wed, 27 Sep 2023 17:21:46 +0200
Message-ID: <20230927152145.111777-1-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2024756907610866002=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2024756907610866002==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The Trusted Services project provides a framework for developing and
deploying device Root Of Trust services in FF-A Secure Partitions. The
FF-A SPs are accessible through the FF-A driver, but this doesn't
provide a user space interface. The goal of this TEE driver is to make
Trusted Services SPs accessible for user space clients.

All TS SPs have the same FF-A UUID, it identifies the RPC protocol used
by TS. A TS SP can host one or more services, a service is identified by
its service UUID. The same type of service cannot be present twice in
the same SP. During SP boot each service in the SP gets assigned an
interface ID, this is just a short ID to simplify message addressing.
There is 1:1 mapping between TS SPs and TEE devices, i.e. a TEE device
gets registered for each Trusted Services compatible FF-A device found
on the FF-A bus. Opening the SP corresponds to opening the TEE dev and
creating a TEE context. A TS SP hosts one or more services, opening a
service corresponds to opening a session in the given tee_context.

Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
---

Hi All,

This is an initial TEE driver implementation for Trusted Services [1].
Trusted Services is a TrustedFirmware.org project that provides a
framework for developing and deploying device Root Of Trust services in
FF-A Secure Partitions. The project hosts the reference implementation
of Arm Platform Security Architecture [2] for Arm A-profile devices.

The FF-A Secure Partitions (SPs) are accessible through the FF-A driver
in Linux. However, the FF-A driver doesn't have a user space interface
so user space clients currently cannot access Trusted Services. The goal
of this TEE driver is to bridge this gap and make Trusted Services
functionality accessible from user space.

The predecessor of this driver is an out-of-tree kernel module that we
have been using for prototyping [3]. An integration of Trusted Services,
OP-TEE as a S-EL1 SPMC, TF-A, Linux and this out-of-tree module is
available as part of the OP-TEE project, please find the manifest file
at [4].

Some key points about the structure of Trusted Services (for more
details please see the documentation at [5]):
- A Trusted Services SP can host one or multiple services. All TS SPs
  have the same FF-A UUID, it identifies the RPC protocol used by TS.
  The protocol's register ABI definition is available at [6] and is
  implemented in tstee_private.h.
- A service hosted by an SP is identified by its service UUID. The
  same type of service can be present in multiple SPs, but not twice in
  the same SP. During SP boot each service in the SP gets assigned an
  interface ID, this is just a short ID to simplify message addressing.
- There is 1:1 mapping between TS SPs and TEE devices, i.e. a TEE device
  gets registered for each Trusted Services compatible FF-A device found
  on the FF-A bus.
- Opening the SP corresponds to opening the TEE dev and creating a TEE
  context. A TS SP hosts one or more services, opening a service
  corresponds to opening a session in the given tee_context.

Regards,
Balint

[1] https://www.trustedfirmware.org/projects/trusted-services/
[2] https://www.arm.com/architecture/security-features/platform-security
[3] https://gitlab.arm.com/linux-arm/linux-trusted-services
[4] https://github.com/OP-TEE/manifest/blob/master/fvp-ts.xml
[5] https://trusted-services.readthedocs.io
[6] https://trusted-services.readthedocs.io/en/integration/developer/service-=
access-protocols.html#abi

 drivers/tee/Kconfig               |   1 +
 drivers/tee/Makefile              |   1 +
 drivers/tee/tstee/Kconfig         |  11 +
 drivers/tee/tstee/Makefile        |   3 +
 drivers/tee/tstee/core.c          | 473 ++++++++++++++++++++++++++++++
 drivers/tee/tstee/shm_pool.c      |  91 ++++++
 drivers/tee/tstee/tstee_private.h |  97 ++++++
 include/uapi/linux/tee.h          |   1 +
 8 files changed, 678 insertions(+)
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/shm_pool.c
 create mode 100644 drivers/tee/tstee/tstee_private.h

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 73a147202e88..61b507c18780 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -15,5 +15,6 @@ if TEE

 source "drivers/tee/optee/Kconfig"
 source "drivers/tee/amdtee/Kconfig"
+source "drivers/tee/tstee/Kconfig"

 endif
diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index 68da044afbfa..5488cba30bd2 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -5,3 +5,4 @@ tee-objs +=3D tee_shm.o
 tee-objs +=3D tee_shm_pool.o
 obj-$(CONFIG_OPTEE) +=3D optee/
 obj-$(CONFIG_AMDTEE) +=3D amdtee/
+obj-$(CONFIG_ARM_TSTEE) +=3D tstee/
diff --git a/drivers/tee/tstee/Kconfig b/drivers/tee/tstee/Kconfig
new file mode 100644
index 000000000000..cd8d32586a77
--- /dev/null
+++ b/drivers/tee/tstee/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config ARM_TSTEE
+	tristate "Arm Trusted Services TEE driver"
+	depends on ARM_FFA_TRANSPORT
+	default n
+	help
+	  The Trusted Services project provides a framework for developing and
+	  deploying device Root Of Trust services in FF-A Secure Partitions.
+	  This driver provides an interface to make Trusted Services Secure
+	  Partitions accessible for user space clients, since the FF-A driver
+	  doesn't implement a user space interface directly.
diff --git a/drivers/tee/tstee/Makefile b/drivers/tee/tstee/Makefile
new file mode 100644
index 000000000000..dd54b1f88652
--- /dev/null
+++ b/drivers/tee/tstee/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+arm-tstee-objs :=3D core.o shm_pool.o
+obj-$(CONFIG_ARM_TSTEE) =3D arm-tstee.o
diff --git a/drivers/tee/tstee/core.c b/drivers/tee/tstee/core.c
new file mode 100644
index 000000000000..c0194638b7da
--- /dev/null
+++ b/drivers/tee/tstee/core.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Arm Limited
+ */
+
+#define DRIVER_NAME "Arm TSTEE"
+#define pr_fmt(fmt) DRIVER_NAME ": " fmt
+
+#include <linux/arm_ffa.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/tee_drv.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#include "tstee_private.h"
+
+#define FFA_INVALID_MEM_HANDLE U64_MAX
+
+static void arg_list_to_ffa_data(const u32 *args, struct ffa_send_direct_dat=
a *data)
+{
+	data->data0 =3D args[0];
+	data->data1 =3D args[1];
+	data->data2 =3D args[2];
+	data->data3 =3D args[3];
+	data->data4 =3D args[4];
+}
+
+static void arg_list_from_ffa_data(const struct ffa_send_direct_data *data, =
u32 *args)
+{
+	args[0] =3D lower_32_bits(data->data0);
+	args[1] =3D lower_32_bits(data->data1);
+	args[2] =3D lower_32_bits(data->data2);
+	args[3] =3D lower_32_bits(data->data3);
+	args[4] =3D lower_32_bits(data->data4);
+}
+
+static void tstee_get_version(struct tee_device *teedev, struct tee_ioctl_ve=
rsion_data *vers)
+{
+	struct tstee *tstee =3D tee_get_drvdata(teedev);
+	struct tee_ioctl_version_data v =3D {
+		.impl_id =3D TEE_IMPL_ID_TSTEE,
+		.impl_caps =3D tstee->ffa_dev->vm_id,
+		.gen_caps =3D 0,
+	};
+
+	*vers =3D v;
+}
+
+static int tstee_open(struct tee_context *ctx)
+{
+	struct ts_context_data *ctxdata;
+
+	ctxdata =3D kzalloc(sizeof(*ctxdata), GFP_KERNEL);
+	if (!ctxdata)
+		return -ENOMEM;
+
+	mutex_init(&ctxdata->mutex);
+	idr_init(&ctxdata->sess_ids);
+	INIT_LIST_HEAD(&ctxdata->sess_list);
+
+	ctx->data =3D ctxdata;
+
+	return 0;
+}
+
+static void tstee_release(struct tee_context *ctx)
+{
+	struct ts_context_data *ctxdata =3D ctx->data;
+	struct ts_session *sess, *sess_tmp;
+
+	if (!ctxdata)
+		return;
+
+	list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list, list_node) {
+		list_del(&sess->list_node);
+		idr_remove(&ctxdata->sess_ids, sess->session_id);
+		kfree(sess);
+	}
+
+	idr_destroy(&ctxdata->sess_ids);
+	mutex_destroy(&ctxdata->mutex);
+
+	kfree(ctxdata);
+	ctx->data =3D NULL;
+}
+
+static struct ts_session *find_session(struct ts_context_data *ctxdata, u32 =
session_id)
+{
+	struct ts_session *sess;
+
+	list_for_each_entry(sess, &ctxdata->sess_list, list_node)
+		if (sess->session_id =3D=3D session_id)
+			return sess;
+
+	return NULL;
+}
+
+static int tstee_open_session(struct tee_context *ctx, struct tee_ioctl_open=
_session_arg *arg,
+			      struct tee_param *param __always_unused)
+{
+	struct tstee *tstee =3D tee_get_drvdata(ctx->teedev);
+	struct ffa_device *ffa_dev =3D tstee->ffa_dev;
+	struct ts_context_data *ctxdata =3D ctx->data;
+	struct ffa_send_direct_data ffa_data;
+	struct ts_session *sess =3D NULL;
+	u32 ffa_args[5] =3D {};
+	int sess_id;
+	int rc;
+
+	ffa_args[TS_RPC_CTRL_REG] =3D TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFA=
CE_ID,
+								  TS_RPC_OP_SERVICE_INFO);
+
+	memcpy((u8 *)(ffa_args + TS_RPC_SERVICE_INFO_UUID0), arg->uuid, UUID_SIZE);
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	rc =3D ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
+	if (rc)
+		return rc;
+
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	if (ffa_args[TS_RPC_SERVICE_INFO_RPC_STATUS] !=3D TS_RPC_OK)
+		return -ENODEV;
+
+	if (ffa_args[TS_RPC_SERVICE_INFO_IFACE] > U8_MAX)
+		return -EINVAL;
+
+	sess =3D kzalloc(sizeof(*sess), GFP_KERNEL);
+	if (!sess)
+		return -ENOMEM;
+
+	sess_id =3D idr_alloc(&ctxdata->sess_ids, sess, 1, 0, GFP_KERNEL);
+	if (sess_id < 0) {
+		kfree(sess);
+		return sess_id;
+	}
+
+	sess->session_id =3D sess_id;
+	sess->iface_id =3D ffa_args[TS_RPC_SERVICE_INFO_IFACE];
+
+	mutex_lock(&ctxdata->mutex);
+	list_add(&sess->list_node, &ctxdata->sess_list);
+	mutex_unlock(&ctxdata->mutex);
+
+	arg->session =3D sess_id;
+	arg->ret =3D 0;
+
+	return 0;
+}
+
+static int tstee_close_session(struct tee_context *ctx, u32 session)
+{
+	struct ts_context_data *ctxdata =3D ctx->data;
+	struct ts_session *sess;
+
+	mutex_lock(&ctxdata->mutex);
+	sess =3D find_session(ctxdata, session);
+	if (sess)
+		list_del(&sess->list_node);
+
+	mutex_unlock(&ctxdata->mutex);
+
+	if (!sess)
+		return -EINVAL;
+
+	idr_remove(&ctxdata->sess_ids, sess->session_id);
+	kfree(sess);
+
+	return 0;
+}
+
+static int tstee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invok=
e_arg *arg,
+			     struct tee_param *param)
+{
+	struct tstee *tstee =3D tee_get_drvdata(ctx->teedev);
+	struct ffa_device *ffa_dev =3D tstee->ffa_dev;
+	struct ts_context_data *ctxdata =3D ctx->data;
+	struct ffa_send_direct_data ffa_data;
+	struct tee_shm *shm =3D NULL;
+	struct ts_session *sess;
+	u32 req_len, ffa_args[5] =3D {};
+	int shm_id, rc;
+	u8 iface_id;
+	u64 handle;
+	u16 opcode;
+
+	mutex_lock(&ctxdata->mutex);
+	sess =3D find_session(ctxdata, arg->session);
+
+	/* Do this while holding the mutex to make sure that the session wasn't clo=
sed meanwhile */
+	if (sess)
+		iface_id =3D sess->iface_id;
+
+	mutex_unlock(&ctxdata->mutex);
+	if (!sess)
+		return -EINVAL;
+
+	opcode =3D lower_16_bits(arg->func);
+	shm_id =3D lower_32_bits(param[0].u.value.a);
+	req_len =3D lower_32_bits(param[0].u.value.b);
+
+	if (shm_id !=3D 0) {
+		shm =3D tee_shm_get_from_id(ctx, shm_id);
+		if (IS_ERR(shm))
+			return PTR_ERR(shm);
+
+		if (shm->size < req_len) {
+			pr_err("request doesn't fit into shared memory buffer\n");
+			rc =3D -EINVAL;
+			goto out;
+		}
+
+		handle =3D shm->sec_world_id;
+	} else {
+		handle =3D FFA_INVALID_MEM_HANDLE;
+	}
+
+	ffa_args[TS_RPC_CTRL_REG] =3D TS_RPC_CTRL_PACK_IFACE_OPCODE(iface_id, opcod=
e);
+	ffa_args[TS_RPC_SERVICE_MEM_HANDLE_LSW] =3D lower_32_bits(handle);
+	ffa_args[TS_RPC_SERVICE_MEM_HANDLE_MSW] =3D upper_32_bits(handle);
+	ffa_args[TS_RPC_SERVICE_REQ_LEN] =3D req_len;
+	ffa_args[TS_RPC_SERVICE_CLIENT_ID] =3D 0;
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	rc =3D ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
+	if (rc)
+		goto out;
+
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	if (ffa_args[TS_RPC_SERVICE_RPC_STATUS] !=3D TS_RPC_OK) {
+		pr_err("invoke_func rpc status: %d\n", ffa_args[TS_RPC_SERVICE_RPC_STATUS]=
);
+		rc =3D -EINVAL;
+		goto out;
+	}
+
+	arg->ret =3D ffa_args[TS_RPC_SERVICE_STATUS];
+	if (shm && shm->size >=3D ffa_args[TS_RPC_SERVICE_RESP_LEN])
+		param[0].u.value.a =3D ffa_args[TS_RPC_SERVICE_RESP_LEN];
+
+out:
+	if (shm)
+		tee_shm_put(shm);
+
+	return rc;
+}
+
+static int tstee_cancel_req(struct tee_context *ctx __always_unused, u32 can=
cel_id __always_unused,
+			    u32 session __always_unused)
+{
+	return -EINVAL;
+}
+
+int tstee_shm_register(struct tee_context *ctx, struct tee_shm *shm, struct =
page **pages,
+		       size_t num_pages, unsigned long start __always_unused)
+{
+	struct tstee *tstee =3D tee_get_drvdata(ctx->teedev);
+	struct ffa_device *ffa_dev =3D tstee->ffa_dev;
+	struct ffa_mem_region_attributes mem_attr =3D {
+		.receiver =3D tstee->ffa_dev->vm_id,
+		.attrs =3D FFA_MEM_RW,
+		.flag =3D 0,
+	};
+	struct ffa_mem_ops_args mem_args =3D {
+		.attrs =3D &mem_attr,
+		.use_txbuf =3D true,
+		.nattrs =3D 1,
+		.flags =3D 0,
+	};
+	struct ffa_send_direct_data ffa_data;
+	struct sg_table sgt;
+	u32 ffa_args[5] =3D {};
+	int rc;
+
+	rc =3D sg_alloc_table_from_pages(&sgt, pages, num_pages, 0, num_pages * PAG=
E_SIZE,
+				       GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	mem_args.sg =3D sgt.sgl;
+	rc =3D ffa_dev->ops->mem_ops->memory_share(&mem_args);
+	sg_free_table(&sgt);
+	if (rc)
+		return rc;
+
+	shm->sec_world_id =3D mem_args.g_handle;
+
+	ffa_args[TS_RPC_CTRL_REG] =3D TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFA=
CE_ID,
+								  TS_RPC_OP_RETRIEVE_MEM);
+	ffa_args[TS_RPC_RETRIEVE_MEM_HANDLE_LSW] =3D lower_32_bits(shm->sec_world_i=
d);
+	ffa_args[TS_RPC_RETRIEVE_MEM_HANDLE_MSW] =3D upper_32_bits(shm->sec_world_i=
d);
+	ffa_args[TS_RPC_RETRIEVE_MEM_TAG_LSW] =3D 0;
+	ffa_args[TS_RPC_RETRIEVE_MEM_TAG_MSW] =3D 0;
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	rc =3D ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
+	if (rc) {
+		(void)ffa_dev->ops->mem_ops->memory_reclaim(shm->sec_world_id, 0);
+		return rc;
+	}
+
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	if (ffa_args[TS_RPC_RETRIEVE_MEM_RPC_STATUS] !=3D TS_RPC_OK) {
+		pr_err("shm_register rpc status: %d\n", ffa_args[TS_RPC_RETRIEVE_MEM_RPC_S=
TATUS]);
+		ffa_dev->ops->mem_ops->memory_reclaim(shm->sec_world_id, 0);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int tstee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct tstee *tstee =3D tee_get_drvdata(ctx->teedev);
+	struct ffa_device *ffa_dev =3D tstee->ffa_dev;
+	struct ffa_send_direct_data ffa_data;
+	u32 ffa_args[5] =3D {};
+	int rc;
+
+	ffa_args[TS_RPC_CTRL_REG] =3D TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFA=
CE_ID,
+								  TS_RPC_OP_RELINQ_MEM);
+	ffa_args[TS_RPC_RELINQ_MEM_HANDLE_LSW] =3D lower_32_bits(shm->sec_world_id);
+	ffa_args[TS_RPC_RELINQ_MEM_HANDLE_MSW] =3D upper_32_bits(shm->sec_world_id);
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	rc =3D ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
+	if (rc)
+		return rc;
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	if (ffa_args[TS_RPC_RELINQ_MEM_RPC_STATUS] !=3D TS_RPC_OK) {
+		pr_err("shm_unregister rpc status: %d\n", ffa_args[TS_RPC_RELINQ_MEM_RPC_S=
TATUS]);
+		return -EINVAL;
+	}
+
+	rc =3D ffa_dev->ops->mem_ops->memory_reclaim(shm->sec_world_id, 0);
+
+	return rc;
+}
+
+static const struct tee_driver_ops tstee_ops =3D {
+	.get_version =3D tstee_get_version,
+	.open =3D tstee_open,
+	.release =3D tstee_release,
+	.open_session =3D tstee_open_session,
+	.close_session =3D tstee_close_session,
+	.invoke_func =3D tstee_invoke_func,
+	.cancel_req =3D tstee_cancel_req,
+	.shm_register =3D tstee_shm_register,
+	.shm_unregister =3D tstee_shm_unregister,
+};
+
+static const struct tee_desc tstee_desc =3D {
+	.name =3D "tstee-clnt",
+	.ops =3D &tstee_ops,
+	.owner =3D THIS_MODULE,
+};
+
+static bool tstee_check_rpc_compatible(struct ffa_device *ffa_dev)
+{
+	struct ffa_send_direct_data ffa_data;
+	u32 ffa_args[5] =3D {};
+
+	ffa_args[TS_RPC_CTRL_REG] =3D TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFA=
CE_ID,
+								  TS_RPC_OP_GET_VERSION);
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	if (ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data))
+		return false;
+
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	return ffa_args[TS_RPC_GET_VERSION_RESP] =3D=3D TS_RPC_PROTOCOL_VERSION;
+}
+
+static void tstee_deinit_common(struct tstee *tstee)
+{
+	tee_device_unregister(tstee->teedev);
+	if (tstee->pool)
+		tee_shm_pool_free(tstee->pool);
+
+	kfree(tstee);
+}
+
+static int tstee_probe(struct ffa_device *ffa_dev)
+{
+	struct tstee *tstee;
+	int rc;
+
+	ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
+
+	if (!tstee_check_rpc_compatible(ffa_dev))
+		return -EINVAL;
+
+	tstee =3D kzalloc(sizeof(*tstee), GFP_KERNEL);
+	if (!tstee)
+		return -ENOMEM;
+
+	tstee->ffa_dev =3D ffa_dev;
+
+	tstee->pool =3D tstee_create_shm_pool();
+	if (IS_ERR(tstee->pool)) {
+		rc =3D PTR_ERR(tstee->pool);
+		tstee->pool =3D NULL;
+		goto err;
+	}
+
+	tstee->teedev =3D tee_device_alloc(&tstee_desc, NULL, tstee->pool, tstee);
+	if (IS_ERR(tstee->teedev)) {
+		rc =3D PTR_ERR(tstee->teedev);
+		tstee->teedev =3D NULL;
+		goto err;
+	}
+
+	rc =3D tee_device_register(tstee->teedev);
+	if (rc)
+		goto err;
+
+	ffa_dev_set_drvdata(ffa_dev, tstee);
+
+	pr_info("driver initialized for endpoint 0x%x\n", ffa_dev->vm_id);
+
+	return 0;
+
+err:
+	tstee_deinit_common(tstee);
+	return rc;
+}
+
+static void tstee_remove(struct ffa_device *ffa_dev)
+{
+	tstee_deinit_common(ffa_dev->dev.driver_data);
+}
+
+static const struct ffa_device_id tstee_device_ids[] =3D {
+	/* TS RPC protocol UUID: bdcd76d7-825e-4751-963b-86d4f84943ac */
+	{ TS_RPC_UUID },
+	{}
+};
+
+static struct ffa_driver tstee_driver =3D {
+	.name =3D "arm_tstee",
+	.probe =3D tstee_probe,
+	.remove =3D tstee_remove,
+	.id_table =3D tstee_device_ids,
+};
+
+static int __init mod_init(void)
+{
+	return ffa_register(&tstee_driver);
+}
+module_init(mod_init)
+
+static void __exit mod_exit(void)
+{
+	ffa_unregister(&tstee_driver);
+}
+module_exit(mod_exit)
+
+MODULE_ALIAS("arm-tstee");
+MODULE_AUTHOR("Balint Dobszay <balint.dobszay@arm.com>");
+MODULE_DESCRIPTION("Arm Trusted Services TEE driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tee/tstee/shm_pool.c b/drivers/tee/tstee/shm_pool.c
new file mode 100644
index 000000000000..518c10dd0735
--- /dev/null
+++ b/drivers/tee/tstee/shm_pool.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Arm Limited
+ */
+
+#include <linux/arm_ffa.h>
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+
+#include "tstee_private.h"
+
+static int pool_op_alloc(struct tee_shm_pool *pool __always_unused, struct t=
ee_shm *shm,
+			 size_t size, size_t align __always_unused)
+{
+	unsigned int order, nr_pages, i;
+	struct page *page, **pages;
+	int rc;
+
+	if (size =3D=3D 0)
+		return -EINVAL;
+
+	order =3D get_order(size);
+	nr_pages =3D 1 << order;
+
+	page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!page)
+		return -ENOMEM;
+
+	shm->kaddr =3D page_address(page);
+	shm->paddr =3D page_to_phys(page);
+	shm->size =3D PAGE_SIZE << order;
+
+	pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
+		rc =3D -ENOMEM;
+		goto err;
+	}
+
+	for (i =3D 0; i < nr_pages; i++)
+		pages[i] =3D page + i;
+
+	rc =3D tstee_shm_register(shm->ctx, shm, pages, nr_pages, (unsigned long)sh=
m->kaddr);
+	kfree(pages);
+	if (rc)
+		goto err;
+
+	return 0;
+
+err:
+	__free_pages(page, order);
+	return rc;
+}
+
+static void pool_op_free(struct tee_shm_pool *pool __always_unused, struct t=
ee_shm *shm)
+{
+	int rc;
+
+	rc =3D tstee_shm_unregister(shm->ctx, shm);
+	if (rc)
+		pr_err("shm id 0x%llx unregister rc %d\n", shm->sec_world_id, rc);
+
+	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	shm->kaddr =3D NULL;
+}
+
+static void pool_op_destroy_pool(struct tee_shm_pool *pool)
+{
+	kfree(pool);
+}
+
+static const struct tee_shm_pool_ops pool_ops =3D {
+	.alloc =3D pool_op_alloc,
+	.free =3D pool_op_free,
+	.destroy_pool =3D pool_op_destroy_pool,
+};
+
+struct tee_shm_pool *tstee_create_shm_pool(void)
+{
+	struct tee_shm_pool *pool;
+
+	pool =3D kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->ops =3D &pool_ops;
+
+	return pool;
+}
diff --git a/drivers/tee/tstee/tstee_private.h b/drivers/tee/tstee/tstee_priv=
ate.h
new file mode 100644
index 000000000000..2ea266804ccf
--- /dev/null
+++ b/drivers/tee/tstee/tstee_private.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Arm Limited
+ */
+
+#ifndef TSTEE_PRIVATE_H
+#define TSTEE_PRIVATE_H
+
+#include <linux/arm_ffa.h>
+#include <linux/bitops.h>
+#include <linux/idr.h>
+#include <linux/tee_drv.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+/* UUID of this protocol */
+#define TS_RPC_UUID UUID_INIT(0xbdcd76d7, 0x825e, 0x4751, \
+			      0x96, 0x3b, 0x86, 0xd4, 0xf8, 0x49, 0x43, 0xac)
+
+/* Protocol version*/
+#define TS_RPC_PROTOCOL_VERSION		(1)
+
+/* Status codes */
+#define TS_RPC_OK			(0)
+
+/* RPC control register */
+#define TS_RPC_CTRL_REG			(0)
+#define OPCODE_MASK			GENMASK(15, 0)
+#define IFACE_ID_MASK			GENMASK(23, 16)
+#define TS_RPC_CTRL_OPCODE(x)		((u16)(FIELD_GET(OPCODE_MASK, (x))))
+#define TS_RPC_CTRL_IFACE_ID(x)		((u8)(FIELD_GET(IFACE_ID_MASK, (x))))
+#define TS_RPC_CTRL_PACK_IFACE_OPCODE(i, o)	\
+	(FIELD_PREP(IFACE_ID_MASK, (i)) | FIELD_PREP(OPCODE_MASK, (o)))
+#define TS_RPC_CTRL_SAP_RC		BIT(30)
+#define TS_RPC_CTRL_SAP_ERR		BIT(31)
+
+/* Interface ID for RPC management operations */
+#define TS_RPC_MGMT_IFACE_ID		(0xff)
+
+/* Management calls */
+#define TS_RPC_OP_GET_VERSION		(0x0000)
+#define TS_RPC_GET_VERSION_RESP		(1)
+
+#define TS_RPC_OP_RETRIEVE_MEM		(0x0001)
+#define TS_RPC_RETRIEVE_MEM_HANDLE_LSW	(1)
+#define TS_RPC_RETRIEVE_MEM_HANDLE_MSW	(2)
+#define TS_RPC_RETRIEVE_MEM_TAG_LSW	(3)
+#define TS_RPC_RETRIEVE_MEM_TAG_MSW	(4)
+#define TS_RPC_RETRIEVE_MEM_RPC_STATUS	(1)
+
+#define TS_RPC_OP_RELINQ_MEM		(0x0002)
+#define TS_RPC_RELINQ_MEM_HANDLE_LSW	(1)
+#define TS_RPC_RELINQ_MEM_HANDLE_MSW	(2)
+#define TS_RPC_RELINQ_MEM_RPC_STATUS	(1)
+
+#define TS_RPC_OP_SERVICE_INFO		(0x0003)
+#define TS_RPC_SERVICE_INFO_UUID0	(1)
+#define TS_RPC_SERVICE_INFO_UUID1	(2)
+#define TS_RPC_SERVICE_INFO_UUID2	(3)
+#define TS_RPC_SERVICE_INFO_UUID3	(4)
+#define TS_RPC_SERVICE_INFO_RPC_STATUS	(1)
+#define TS_RPC_SERVICE_INFO_IFACE	(2)
+
+/* Service call */
+#define TS_RPC_SERVICE_MEM_HANDLE_LSW	(1)
+#define TS_RPC_SERVICE_MEM_HANDLE_MSW	(2)
+#define TS_RPC_SERVICE_REQ_LEN		(3)
+#define TS_RPC_SERVICE_CLIENT_ID	(4)
+#define TS_RPC_SERVICE_RPC_STATUS	(1)
+#define TS_RPC_SERVICE_STATUS		(2)
+#define TS_RPC_SERVICE_RESP_LEN		(3)
+
+struct tstee {
+	struct ffa_device *ffa_dev;
+	struct tee_device *teedev;
+	struct tee_shm_pool *pool;
+};
+
+struct ts_session {
+	struct list_head list_node;
+	u32 session_id;
+	u8 iface_id;
+};
+
+struct ts_context_data {
+	struct list_head sess_list;
+	struct idr sess_ids;
+	/* Serializes access to this struct */
+	struct mutex mutex;
+};
+
+struct tee_shm_pool *tstee_create_shm_pool(void);
+int tstee_shm_register(struct tee_context *ctx, struct tee_shm *shm, struct =
page **pages,
+		       size_t num_pages, unsigned long start);
+int tstee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm);
+
+#endif /* TSTEE_PRIVATE_H */
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 23e57164693c..d0430bee8292 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -56,6 +56,7 @@
  */
 #define TEE_IMPL_ID_OPTEE	1
 #define TEE_IMPL_ID_AMDTEE	2
+#define TEE_IMPL_ID_TSTEE	3

 /*
  * OP-TEE specific capabilities
--
2.34.1

--===============2024756907610866002==--

