From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v16 2/6] remoteproc: Add TEE support
Date: Tue, 25 Mar 2025 10:58:29 +0100
Message-ID: <20250325095833.3059895-3-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20250325095833.3059895-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0041821564014506362=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0041821564014506362==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add a remoteproc TEE (Trusted Execution Environment) driver that will be
probed by the TEE bus. If the associated Trusted application is supported
on the secure part, this driver offers a client interface to load firmware
by the secure part.
This firmware could be authenticated by the secure trusted application.

A specificity of the implementation is that the firmware has to be
authenticated and optionally decrypted to access the resource table.

Consequently, the boot sequence is:

1) rproc_parse_fw --> rproc_tee_parse_fw
   remoteproc TEE:
   - Requests the TEE application to authenticate and load the firmware
     in the remote processor memories.
   - Requests the TEE application for the address of the resource table.
   - Creates a copy of the resource table stored in rproc->cached_table.

2) rproc_load_segments --> rproc_tee_load_fw
   remoteproc TEE:
   - Requests the TEE application to load the firmware. Nothing is done
     at the TEE application as the firmware is already loaded.
   - In case of recovery, the TEE application has to reload the firmware.

3) rproc_tee_get_loaded_rsc_table
   remoteproc TEE requests the TEE application for the address of the
   resource table.

4) rproc_start --> rproc_tee_start
   - Requests the TEE application to start the remote processor.


The shutdown sequence is:

5) rproc_stop --> rproc_tee_stop
   - Requests the TEE application to stop the remote processor.

6) rproc_tee_release_fw
   This function is used to request the TEE application to perform actions
   to return to the initial state on stop or on error during the boot
   sequence.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Updates vs previous version:
- Come back to v13 managing a load in rproc_tee_parse_fw().
- Replace IS_REACHABLE with IS_ENABLED in remoteproc_tee.h, remoteproc_tee
  is not supported as module
- update REMOTEPROC_TEE config description in Kconfig
- manage unbind sequence of the consumer rproc drivers using devlink
- remove TA_RPROC_FW_CMD_GET_COREDUMP as not use ( to be treated in a
  separate thread)
- define a static `rproc_tee_ctx` variable instead of allocating it
- add spinlock to protect `rproc_tee_ctx` accesses.
- add exported function doumentation
---
 drivers/remoteproc/Kconfig          |  10 +
 drivers/remoteproc/Makefile         |   1 +
 drivers/remoteproc/remoteproc_tee.c | 619 ++++++++++++++++++++++++++++
 include/linux/remoteproc_tee.h      |  90 ++++
 4 files changed, 720 insertions(+)
 create mode 100644 drivers/remoteproc/remoteproc_tee.c
 create mode 100644 include/linux/remoteproc_tee.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 83962a114dc9..e39265d249d9 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -23,6 +23,16 @@ config REMOTEPROC_CDEV
=20
 	  It's safe to say N if you don't want to use this interface.
=20
+config REMOTEPROC_TEE
+	bool "Remoteproc support by a TEE application"
+	depends on OPTEE
+	help
+	  Support a remote processor that is managed by an application running in a=
 Trusted
+	  Execution Environment (TEE). This application is responsible for loading =
the remote
+	  processor firmware image and managing its lifecycle.
+
+	  It's safe to say N if the remote processor is not managed by a TEE.
+
 config IMX_REMOTEPROC
 	tristate "i.MX remoteproc support"
 	depends on ARCH_MXC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 5ff4e2fee4ab..f77e0abe8349 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -11,6 +11,7 @@ remoteproc-y				+=3D remoteproc_sysfs.o
 remoteproc-y				+=3D remoteproc_virtio.o
 remoteproc-y				+=3D remoteproc_elf_loader.o
 obj-$(CONFIG_REMOTEPROC_CDEV)		+=3D remoteproc_cdev.o
+obj-$(CONFIG_REMOTEPROC_TEE)		+=3D remoteproc_tee.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+=3D imx_rproc.o
 obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+=3D imx_dsp_rproc.o
 obj-$(CONFIG_INGENIC_VPU_RPROC)		+=3D ingenic_rproc.o
diff --git a/drivers/remoteproc/remoteproc_tee.c b/drivers/remoteproc/remotep=
roc_tee.c
new file mode 100644
index 000000000000..cf50de7eb952
--- /dev/null
+++ b/drivers/remoteproc/remoteproc_tee.c
@@ -0,0 +1,619 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) STMicroelectronics 2024
+ * Author: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
+ */
+
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+#include <linux/remoteproc_tee.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+
+#define MAX_TEE_PARAM_ARRAY_MEMBER	4
+
+/*
+ * Authentication and load of the firmware image in the remote processor mem=
ories by the TEE.
+ * After this step the firmware is loaded in destination memories, which can=
 then be locked to
+ * prevent access by Linux.
+ *
+ * [in]  params[0].value.a:	remote processor identifier
+ * [in]	 params[1].memref:	buffer containing a temporary copy of the signed =
image to load.
+ */
+#define TA_RPROC_FW_CMD_LOAD_FW		1
+
+/*
+ * Start the remote processor by the TEE
+ *
+ * [in]  params[0].value.a:	remote processor identifier
+ */
+#define TA_RPROC_FW_CMD_START		2
+
+/*
+ * Stop the remote processor by the TEE
+ *
+ * [in]  params[0].value.a:	remote processor identifier
+ */
+#define TA_RPROC_FW_CMD_STOP		3
+
+/*
+ * Return the address of the resource table, or 0 if not found.
+ *
+ * [in]  params[0].value.a:	remote processor identifier
+ * [out]  params[1].value.a:	32bit LSB resource table memory address
+ * [out]  params[1].value.b:	32bit MSB resource table memory address
+ * [out]  params[2].value.a:	32bit LSB resource table memory size
+ * [out]  params[2].value.b:	32bit MSB resource table memory size
+ */
+#define TA_RPROC_FW_CMD_GET_RSC_TABLE	4
+
+/*
+ * Release remote processor firmware images and associated resources.
+ * This command should be used in case an error occurs between the loading of
+ * the firmware images (TA_RPROC_CMD_LOAD_FW) and the starting of the remote
+ * processor (TA_RPROC_CMD_START_FW) or after stopping the remote processor
+ * to release associated resources (TA_RPROC_CMD_STOP_FW).
+ *
+ * [in]  params[0].value.a: Unique 32-bit remote processor identifier
+ */
+#define TA_RPROC_CMD_RELEASE_FW		6
+
+struct rproc_tee_context {
+	struct list_head	sessions;
+	struct tee_context	*tee_ctx;
+	struct device		*dev;
+};
+
+/**
+ * struct rproc_tee - TEE remoteproc structure
+ * @node:		Reference in list
+ * @rproc:		Remoteproc reference
+ * @rproc_id:		Identifier of the target firmware
+ * @session_id:		TEE session identifier
+ */
+struct rproc_tee {
+	struct list_head node;
+	struct rproc *rproc;
+	u32 rproc_id;
+	u32 session_id;
+};
+
+static struct rproc_tee_context rproc_tee_ctx;
+static DEFINE_SPINLOCK(ctx_lock);
+
+static struct rproc_tee *rproc_to_trproc(struct rproc *rproc)
+{
+	struct rproc_tee *trproc;
+
+	list_for_each_entry(trproc, &rproc_tee_ctx.sessions, node)
+		if (trproc->rproc =3D=3D rproc)
+			return trproc;
+
+	return NULL;
+}
+
+static void rproc_tee_prepare_args(struct rproc_tee *trproc, int cmd,
+				   struct tee_ioctl_invoke_arg *arg,
+				   struct tee_param *param,
+				   unsigned int num_params)
+{
+	memset(arg, 0, sizeof(*arg));
+	memset(param, 0, MAX_TEE_PARAM_ARRAY_MEMBER * sizeof(*param));
+
+	arg->func =3D cmd;
+	arg->session =3D trproc->session_id;
+	arg->num_params =3D num_params + 1;
+
+	param[0] =3D (struct tee_param) {
+		.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a =3D trproc->rproc_id,
+	};
+}
+
+/**
+ * rproc_tee_release_fw - Release the firmware for a TEE-based remote proces=
sor
+ *
+ * This function invokes the TA_RPROC_CMD_RELEASE_FW TEE client function to =
release the firmware.
+ * It should only be called when the remoteproc state is RPROC_OFFLINE or RP=
ROC_DETACHED.
+ * The function requests the TEE remoteproc application to release the firmw=
are loaded by
+ * rproc_tee_load_fw(). The request is ignored if the rproc state is RPROC_D=
ETACHED as the
+ * remote processor is still running.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ */
+void rproc_tee_release_fw(struct rproc *rproc)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc =3D rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	if (!rproc_tee_ctx.dev)
+		return;
+
+	if (!trproc)
+		return;
+
+	/*
+	 * If the remote processor state is RPROC_DETACHED, just ignore the
+	 * request, as the remote processor is still running.
+	 */
+	if (rproc->state =3D=3D RPROC_DETACHED)
+		return;
+
+	if (rproc->state !=3D RPROC_OFFLINE) {
+		dev_err(rproc_tee_ctx.dev, "unexpected rproc state: %d\n", rproc->state);
+		return;
+	}
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_RELEASE_FW, &arg, param, 0);
+
+	ret =3D tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret !=3D 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_CMD_RELEASE_FW invoke failed TEE err: %#x, ret:%d\n",
+			arg.ret, ret);
+		ret =3D -EIO;
+	}
+}
+EXPORT_SYMBOL_GPL(rproc_tee_release_fw);
+
+/**
+ * rproc_tee_load_fw - Load firmware from TEE application
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and s=
ize
+ *
+ * This function invokes the TA_RPROC_FW_CMD_LOAD_FW TEE client function to =
load the firmware.
+ * It registers the fw->data as a shared memory region with the TEE, and req=
uest the TEE to load
+ * the firmware. This function can be called twice during the remote process=
or boot, considering
+ * that the TEE application ignores the command if the firmware is already l=
oaded.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and s=
ize
+ *
+ * Return: 0 on success, or an error code on failure
+ */
+int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc =3D rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_shm *fw_shm;
+	int ret;
+
+	if (!rproc_tee_ctx.dev)
+		return -ENODEV;
+
+	if (!trproc)
+		return -EINVAL;
+
+	fw_shm =3D tee_shm_register_kernel_buf(rproc_tee_ctx.tee_ctx, (void *)fw->d=
ata, fw->size);
+	if (IS_ERR(fw_shm))
+		return PTR_ERR(fw_shm);
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_LOAD_FW, &arg, param, 1);
+
+	/* Provide the address of the firmware image */
+	param[1] =3D (struct tee_param) {
+		.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
+		.u.memref =3D {
+			.shm =3D fw_shm,
+			.size =3D fw->size,
+			.shm_offs =3D 0,
+		},
+	};
+
+	ret =3D tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret !=3D 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_FW_CMD_LOAD_FW invoke failed TEE err: %#x, ret:%d\n",
+			arg.ret, ret);
+		if (!ret)
+			ret =3D -EIO;
+	}
+
+	tee_shm_free(fw_shm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_load_fw);
+
+static int rproc_tee_get_loaded_rsc_table(struct rproc *rproc, phys_addr_t *=
rsc_pa,
+					  size_t *table_sz)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc =3D rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	if (!rproc_tee_ctx.dev)
+		return -ENODEV;
+
+	if (!trproc)
+		return -EINVAL;
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, =
2);
+
+	param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+	param[2].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	ret =3D tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret !=3D 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %#x, ret:%d\n",
+			arg.ret, ret);
+		return -EIO;
+	}
+
+	*table_sz =3D param[2].u.value.a;
+
+	if (*table_sz)
+		*rsc_pa =3D param[1].u.value.a;
+	else
+		*rsc_pa  =3D 0;
+
+	return 0;
+}
+
+/**
+ * rproc_tee_parse_fw - Get the resource table from TEE application
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and s=
ize
+ *
+ * This function retrieves the loaded resource table and creates a cached_ta=
ble copy. Since the
+ * firmware image is signed and potentially encrypted, the firmware must be =
loaded first to
+ * access the loaded resource table.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and s=
ize
+ *
+ * Return: 0 on success, or an error code on failure
+ */
+int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	phys_addr_t rsc_table;
+	void __iomem *rsc_va;
+	size_t table_sz;
+	int ret;
+
+	if (!rproc)
+		return -EINVAL;
+
+	/* We need first to Load the firmware, to be able to get the resource table=
. */
+	ret =3D rproc_tee_load_fw(rproc, fw);
+	if (ret)
+		return ret;
+
+	ret =3D rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
+	if (ret)
+		goto release_fw;
+
+	/*
+	 * We assume here that the memory mapping is the same between the TEE and L=
inux kernel
+	 * contexts. Else a new TEE remoteproc service could be needed to get a cop=
y of the
+	 * resource table
+	 */
+	rsc_va =3D ioremap_wc(rsc_table, table_sz);
+	if (!rsc_va) {
+		dev_err(rproc_tee_ctx.dev, "Unable to map memory region: %pa+%zx\n",
+			&rsc_table, table_sz);
+		ret =3D -ENOMEM;
+		goto release_fw;
+	}
+
+	/*
+	 * Create a copy of the resource table to have the same behavior as the ELF=
 loader.
+	 * This cached table will be used by the remoteproc core after the remotepr=
oc stops
+	 * to free resources and for crash recovery to reapply the settings.
+	 * The cached table will be freed by the remoteproc core.
+	 */
+	rproc->cached_table =3D kmemdup((__force void *)rsc_va, table_sz, GFP_KERNE=
L);
+	iounmap(rsc_va);
+
+	if (!rproc->cached_table) {
+		ret =3D -ENOMEM;
+		goto release_fw;
+	}
+
+	rproc->table_ptr =3D rproc->cached_table;
+	rproc->table_sz =3D table_sz;
+
+	return 0;
+
+release_fw:
+	rproc_tee_release_fw(rproc);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_parse_fw);
+
+/**
+ * rproc_tee_find_loaded_rsc_table - Find the loaded resource table loaded b=
y the TEE application
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and s=
ize
+ *
+ * This function retrieves the physical address and size of the resource tab=
le loaded by the TEE
+ * application.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and s=
ize
+ *
+ * Return:  pointer to the resource table if found, or NULL if not found or =
size is 0
+ */
+struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
+						       const struct firmware *fw)
+{
+	phys_addr_t rsc_table;
+	size_t table_sz;
+	int ret;
+
+	ret =3D rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
+	if (ret)
+		return NULL;
+
+	rproc->table_sz =3D table_sz;
+	if (!table_sz)
+		return NULL;
+
+	/*
+	 * At this step the memory area that contains the resource table should hav=
e been registered
+	 * by the remote proc platform driver and allocated by rproc_alloc_register=
ed_carveouts().
+	 */
+	return (struct resource_table *)rproc_pa_to_va(rproc, rsc_table, table_sz, =
NULL);
+}
+EXPORT_SYMBOL_GPL(rproc_tee_find_loaded_rsc_table);
+
+/**
+ * rproc_tee_start - Request the TEE application to start the remote process=
or
+ *
+ * This function invokes the TA_RPROC_FW_CMD_START command to start the remo=
te processor.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * Return: Returns 0 on success, -EINVAL or -EIO on failure
+ */
+int rproc_tee_start(struct rproc *rproc)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc =3D rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	int ret =3D 0;
+
+	if (!trproc)
+		return -EINVAL;
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_START, &arg, param, 0);
+
+	ret =3D tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret !=3D 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_FW_CMD_START invoke failed TEE err: %#x, ret:%d\n", arg.ret, re=
t);
+		if (!ret)
+			return  -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_start);
+
+/**
+ * rproc_tee_stop - Request the TEE application to start the remote processor
+ *
+ * This function invokes the TA_RPROC_FW_CMD_STOP command to stop the remote=
 processor.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * Return: Returns 0 on success, -EINVAL or -EIO on failure
+ */
+int rproc_tee_stop(struct rproc *rproc)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc =3D rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	if (!trproc)
+		return -EINVAL;
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_STOP, &arg, param, 0);
+
+	ret =3D tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret !=3D 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_FW_CMD_STOP invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret=
);
+		if (!ret)
+			ret =3D -EIO;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_stop);
+
+static const struct tee_client_device_id rproc_tee_id_table[] =3D {
+	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905, 0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, =
0x1a, 0x08)},
+	{}
+};
+
+/**
+ * rproc_tee_register - Register a remote processor controlled by a TEE appl=
ication.
+ *
+ * This function registers a remote processor that will be managed by a TEE =
application,by opening
+ * a session with the TEE client.
+ *
+ * @dev: Pointer to client rproc device
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @rproc_id: ID of the remote processor
+ *
+ * Return: Returns 0 on success, or an error code on failure
+ */
+int rproc_tee_register(struct device *dev, struct rproc *rproc, unsigned int=
 rproc_id)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct tee_ioctl_open_session_arg sess_arg;
+	struct tee_client_device *tee_device;
+	struct rproc_tee *trproc;
+	struct device_link *link;
+	int ret;
+
+	spin_lock(&ctx_lock);
+	/*
+	 * Test if the device has been probed by the TEE bus. In case of failure, w=
e ignore the
+	 * reason. The bus could be not yet probed or the service not available in =
the secure
+	 * firmware.The assumption in such a case is that the TEE remoteproc is not=
 probed.
+	 */
+	if (!rproc_tee_ctx.dev) {
+		ret =3D  -EPROBE_DEFER;
+		goto out;
+	}
+
+	trproc =3D  kzalloc(sizeof(*trproc), GFP_KERNEL);
+	if (!trproc) {
+		ret =3D  -ENOMEM;
+		goto out;
+	}
+
+	tee_device =3D to_tee_client_device(rproc_tee_ctx.dev);
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
+	memcpy(sess_arg.uuid, tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
+
+	sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
+	sess_arg.num_params =3D 1;
+
+	param[0] =3D (struct tee_param) {
+		.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a =3D rproc_id,
+	};
+
+	ret =3D tee_client_open_session(rproc_tee_ctx.tee_ctx, &sess_arg, param);
+	if (ret < 0 || sess_arg.ret !=3D 0) {
+		dev_err(dev, "tee_client_open_session failed, err: %#x\n", sess_arg.ret);
+		ret =3D -EINVAL;
+		goto free_tproc;
+	}
+
+	trproc->rproc_id =3D rproc_id;
+	trproc->session_id =3D sess_arg.session;
+
+	trproc->rproc =3D rproc;
+
+	/* Create device link between the rproc device and the TEE device */
+	link =3D device_link_add(dev, rproc_tee_ctx.dev, DL_FLAG_AUTOREMOVE_CONSUME=
R);
+	if (!link) {
+		ret =3D -ENOMEM;
+		goto close_tee;
+	}
+	list_add_tail(&trproc->node, &rproc_tee_ctx.sessions);
+
+	goto out;
+
+close_tee:
+	if (tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id))
+		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed\n");
+free_tproc:
+	kfree(trproc);
+out:
+	spin_unlock(&ctx_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_register);
+
+/**
+ * rproc_tee_unregister - Register a remote processor controlled by a TEE ap=
plication.
+ *
+ * This function unregisters a remote processor previously registered by the=
 rproc_tee_register()
+ * function.
+ *
+ * @dev: Pointer to client rproc device
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * Return: Returns 0 on success, or an error code on failure
+ */
+int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
+{
+	struct rproc_tee *trproc =3D rproc_to_trproc(rproc);
+	int ret;
+
+	if (!trproc)
+		return -EINVAL;
+
+	spin_lock(&ctx_lock);
+
+	ret =3D tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id);
+	if (ret < 0)
+		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed, err: %#x\n", =
ret);
+
+	spin_unlock(&ctx_lock);
+
+	list_del(&trproc->node);
+	kfree(trproc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_unregister);
+
+static int rproc_tee_ctx_match(struct tee_ioctl_version_data *ver, const voi=
d *data)
+{
+	/* Today we support only the OP-TEE, could be extend to other tees */
+	return (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE);
+}
+
+static int rproc_tee_probe(struct device *dev)
+{
+	struct tee_context *tee_ctx;
+
+	/* Open context with TEE driver */
+	tee_ctx =3D tee_client_open_context(NULL, rproc_tee_ctx_match, NULL, NULL);
+	if (IS_ERR(tee_ctx))
+		return PTR_ERR(tee_ctx);
+
+	spin_lock(&ctx_lock);
+	rproc_tee_ctx.dev =3D dev;
+	rproc_tee_ctx.tee_ctx =3D tee_ctx;
+	INIT_LIST_HEAD(&rproc_tee_ctx.sessions);
+	spin_unlock(&ctx_lock);
+
+	return 0;
+}
+
+static int rproc_tee_remove(struct device *dev)
+{
+	spin_lock(&ctx_lock);
+	tee_client_close_context(rproc_tee_ctx.tee_ctx);
+	rproc_tee_ctx.dev =3D NULL;
+	rproc_tee_ctx.tee_ctx =3D NULL;
+	spin_unlock(&ctx_lock);
+
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(tee, rproc_tee_id_table);
+
+static struct tee_client_driver rproc_tee_fw_driver =3D {
+	.id_table	=3D rproc_tee_id_table,
+	.driver		=3D {
+		.name		=3D KBUILD_MODNAME,
+		.bus		=3D &tee_bus_type,
+		.probe		=3D rproc_tee_probe,
+		.remove		=3D rproc_tee_remove,
+	},
+};
+
+static int __init rproc_tee_fw_mod_init(void)
+{
+	return driver_register(&rproc_tee_fw_driver.driver);
+}
+
+static void __exit rproc_tee_fw_mod_exit(void)
+{
+	driver_unregister(&rproc_tee_fw_driver.driver);
+}
+
+module_init(rproc_tee_fw_mod_init);
+module_exit(rproc_tee_fw_mod_exit);
+
+MODULE_DESCRIPTION(" remote processor TEE module");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/remoteproc_tee.h b/include/linux/remoteproc_tee.h
new file mode 100644
index 000000000000..659bd77a4f12
--- /dev/null
+++ b/include/linux/remoteproc_tee.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright(c) 2024 STMicroelectronics
+ */
+
+#ifndef REMOTEPROC_TEE_H
+#define REMOTEPROC_TEE_H
+
+#include <linux/tee_drv.h>
+#include <linux/firmware.h>
+#include <linux/remoteproc.h>
+
+struct rproc;
+struct rproc_tee;
+
+#if IS_ENABLED(CONFIG_REMOTEPROC_TEE)
+
+int rproc_tee_register(struct device *dev, struct rproc *rproc, unsigned int=
 rproc_id);
+int rproc_tee_unregister(struct device *dev, struct rproc *rproc);
+int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw);
+int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw);
+void rproc_tee_release_fw(struct rproc *rproc);
+struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
+						       const struct firmware *fw);
+int rproc_tee_start(struct rproc *rproc);
+int rproc_tee_stop(struct rproc *rproc);
+
+#else
+
+static inline int rproc_tee_register(struct device *dev, struct rproc *rproc=
, unsigned int rproc_id)
+{
+	return -ENODEV;
+}
+
+static inline int rproc_tee_parse_fw(struct rproc *rproc, const struct firmw=
are *fw)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int rproc_tee_unregister(struct device *dev, struct rproc *rpr=
oc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int rproc_tee_load_fw(struct rproc *rproc,  const struct firmw=
are *fw)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int rproc_tee_start(struct rproc *rproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int rproc_tee_stop(struct rproc *rproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline void rproc_tee_release_fw(struct rproc *rproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+}
+
+static inline struct resource_table *
+rproc_tee_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *=
fw)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return NULL;
+}
+#endif /* CONFIG_REMOTEPROC_TEE */
+#endif /* REMOTEPROC_TEE_H */
--=20
2.25.1


--===============0041821564014506362==--

