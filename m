From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/4] remoteproc: Add TEE support
Date: Tue, 30 Jan 2024 08:16:10 +0000
Message-ID: <5d16c30b-0e30-4435-8d82-f731a52d39c5@foss.st.com>
In-Reply-To: <Zbf0iRITbLEsrHWq@p14s>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4971105796209741065=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4971105796209741065==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 1/29/24 19:55, Mathieu Poirier wrote:
> On Thu, Jan 18, 2024 at 11:04:30AM +0100, Arnaud Pouliquen wrote:
>> From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>
>> Add a remoteproc TEE (Trusted Execution Environment) device
>> that will be probed by the TEE bus. If the associated Trusted
>> application is supported on secure part this device offers a client
>> interface to load a firmware in the secure part.
>> This firmware could be authenticated and decrypted by the secure
>> trusted application.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  drivers/remoteproc/Kconfig          |   9 +
>>  drivers/remoteproc/Makefile         |   1 +
>>  drivers/remoteproc/tee_remoteproc.c | 393 ++++++++++++++++++++++++++++
>>  include/linux/tee_remoteproc.h      |  99 +++++++
>>  4 files changed, 502 insertions(+)
>>  create mode 100644 drivers/remoteproc/tee_remoteproc.c
>>  create mode 100644 include/linux/tee_remoteproc.h
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 48845dc8fa85..85299606806c 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -365,6 +365,15 @@ config XLNX_R5_REMOTEPROC
>> =20
>>  	  It's safe to say N if not interested in using RPU r5f cores.
>> =20
>> +
>> +config TEE_REMOTEPROC
>> +	tristate "trusted firmware support by a TEE application"
>> +	depends on OPTEE
>> +	help
>> +	  Support for trusted remote processors firmware. The firmware
>> +	  authentication and/or decryption are managed by a trusted application.
>> +	  This can be either built-in or a loadable module.
>> +
>>  endif # REMOTEPROC
>> =20
>>  endmenu
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index 91314a9b43ce..fa8daebce277 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -36,6 +36,7 @@ obj-$(CONFIG_RCAR_REMOTEPROC)		+=3D rcar_rproc.o
>>  obj-$(CONFIG_ST_REMOTEPROC)		+=3D st_remoteproc.o
>>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+=3D st_slim_rproc.o
>>  obj-$(CONFIG_STM32_RPROC)		+=3D stm32_rproc.o
>> +obj-$(CONFIG_TEE_REMOTEPROC)		+=3D tee_remoteproc.o
>>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+=3D ti_k3_dsp_remoteproc.o
>>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+=3D ti_k3_r5_remoteproc.o
>>  obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+=3D xlnx_r5_remoteproc.o
>> diff --git a/drivers/remoteproc/tee_remoteproc.c b/drivers/remoteproc/tee_=
remoteproc.c
>> new file mode 100644
>> index 000000000000..49e1e0caf889
>> --- /dev/null
>> +++ b/drivers/remoteproc/tee_remoteproc.c
>> @@ -0,0 +1,393 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
>> + * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> + */
>> +
>> +#include <linux/firmware.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/remoteproc.h>
>> +#include <linux/slab.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/tee_remoteproc.h>
>> +
>> +#include "remoteproc_internal.h"
>> +
>> +#define MAX_TEE_PARAM_ARRY_MEMBER	4
>> +
>> +/*
>> + * Authentication of the firmware and load in the remote processor memory
>> + *
>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote process=
or
>> + * [in]	 params[1].memref:	buffer containing the image of the buffer
>> + */
>> +#define TA_RPROC_FW_CMD_LOAD_FW		1
>> +
>> +/*
>> + * Start the remote processor
>> + *
>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote process=
or
>> + */
>> +#define TA_RPROC_FW_CMD_START_FW	2
>> +
>> +/*
>> + * Stop the remote processor
>> + *
>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote process=
or
>> + */
>> +#define TA_RPROC_FW_CMD_STOP_FW		3
>> +
>> +/*
>> + * Return the address of the resource table, or 0 if not found
>> + * No check is done to verify that the address returned is accessible by
>> + * the non secure context. If the resource table is loaded in a protected
>> + * memory the access by the non secure context will lead to a data abort.
>> + *
>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote process=
or
>> + * [out]  params[1].value.a:	32bit LSB resource table memory address
>> + * [out]  params[1].value.b:	32bit MSB resource table memory address
>> + * [out]  params[2].value.a:	32bit LSB resource table memory size
>> + * [out]  params[2].value.b:	32bit MSB resource table memory size
>> + */
>> +#define TA_RPROC_FW_CMD_GET_RSC_TABLE	4
>> +
>> +/*
>> + * Return the address of the core dump
>> + *
>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote process=
or
>> + * [out] params[1].memref:	address of the core dump image if exist,
>> + *				else return Null
>> + */
>> +#define TA_RPROC_FW_CMD_GET_COREDUMP	5
>> +
>> +struct tee_rproc_mem {
>> +	char name[20];
>> +	void __iomem *cpu_addr;
>> +	phys_addr_t bus_addr;
>> +	u32 dev_addr;
>> +	size_t size;
>> +};
>> +
>> +struct tee_rproc_context {
>> +	struct list_head sessions;
>> +	struct tee_context *tee_ctx;
>> +	struct device *dev;
>> +};
>> +
>> +static struct tee_rproc_context *tee_rproc_ctx;
>> +
>> +static void prepare_args(struct tee_rproc *trproc, int cmd, struct tee_io=
ctl_invoke_arg *arg,
>> +			 struct tee_param *param, unsigned int num_params)
>> +{
>> +	memset(arg, 0, sizeof(*arg));
>> +	memset(param, 0, MAX_TEE_PARAM_ARRY_MEMBER * sizeof(*param));
>> +
>> +	arg->func =3D cmd;
>> +	arg->session =3D trproc->session_id;
>> +	arg->num_params =3D num_params + 1;
>> +
>> +	param[0] =3D (struct tee_param) {
>> +		.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>> +		.u.value.a =3D trproc->rproc_id,
>> +	};
>> +}
>> +
>> +int tee_rproc_load_fw(struct tee_rproc *trproc, const struct firmware *fw)
>> +{
>> +	struct tee_ioctl_invoke_arg arg;
>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>> +	struct tee_shm *fw_shm;
>> +	int ret;
>> +
>> +	fw_shm =3D tee_shm_register_kernel_buf(tee_rproc_ctx->tee_ctx, (void *)f=
w->data, fw->size);
>> +	if (IS_ERR(fw_shm))
>> +		return PTR_ERR(fw_shm);
>> +
>> +	prepare_args(trproc, TA_RPROC_FW_CMD_LOAD_FW, &arg, param, 1);
>> +
>> +	/* Provide the address of the firmware image */
>> +	param[1] =3D (struct tee_param) {
>> +		.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
>> +		.u.memref =3D {
>> +			.shm =3D fw_shm,
>> +			.size =3D fw->size,
>> +			.shm_offs =3D 0,
>> +		},
>> +	};
>> +
>> +	ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret !=3D 0) {
>> +		dev_err(tee_rproc_ctx->dev,
>> +			"TA_RPROC_FW_CMD_LOAD_FW invoke failed TEE err: %x, ret:%x\n",
>> +			arg.ret, ret);
>> +		if (!ret)
>> +			ret =3D -EIO;
>> +	}
>> +
>> +	tee_shm_free(fw_shm);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_rproc_load_fw);
>> +
>> +int rproc_tee_get_rsc_table(struct tee_rproc *trproc)
>> +{
>> +	struct tee_ioctl_invoke_arg arg;
>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>> +	struct rproc *rproc =3D trproc->rproc;
>> +	size_t rsc_size;
>> +	int ret;
>> +
>> +	prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
>> +
>> +	param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
>> +	param[2].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
>> +
>> +	ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret !=3D 0) {
>> +		dev_err(tee_rproc_ctx->dev,
>> +			"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %x, ret:%x\n",
>> +			arg.ret, ret);
>> +		return -EIO;
>> +	}
>> +
>> +	rsc_size =3D param[2].u.value.a;
>> +
>> +	/* If the size is null no resource table defined in the image */
>> +	if (!rsc_size)
>> +		return 0;
>> +
>> +	/* Store the resource table address that would be updated by the remote =
core . */
>> +	trproc->rsc_va =3D ioremap_wc(param[1].u.value.a, rsc_size);
>> +	if (IS_ERR_OR_NULL(trproc->rsc_va)) {
>> +		dev_err(tee_rproc_ctx->dev, "Unable to map memory region: %lld+%zx\n",
>> +			param[1].u.value.a, rsc_size);
>> +		trproc->rsc_va =3D NULL;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/*
>> +	 * A cached table is requested as the physical address is not mapped yet
>> +	 * but remoteproc needs to parse the table for resources.
>> +	 */
>> +	rproc->cached_table =3D kmemdup((__force void *)trproc->rsc_va, rsc_size=
, GFP_KERNEL);
>> +	if (!rproc->cached_table)
>> +		return -ENOMEM;
>> +
>> +	rproc->table_ptr =3D rproc->cached_table;
>> +	rproc->table_sz =3D rsc_size;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_get_rsc_table);
>> +
>> +struct resource_table *tee_rproc_get_loaded_rsc_table(struct tee_rproc *t=
rproc)
>=20
> Please change this to tee_rproc_find_loaded_rsc_table().  That way we know =
it
> should be correlated with ops::find_loaded_rsc_table() rather than
> ops::get_loaded_rsc_table().
>=20
>> +{
>> +	return (__force struct resource_table *)trproc->rsc_va;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_rproc_get_loaded_rsc_table);
>> +
>> +int tee_rproc_start(struct tee_rproc *trproc)
>> +{
>> +	struct tee_ioctl_invoke_arg arg;
>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>> +	int ret;
>> +
>> +	prepare_args(trproc, TA_RPROC_FW_CMD_START_FW, &arg, param, 0);
>> +
>> +	ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret !=3D 0) {
>=20
> Please split the conditions of this if() statement to make it easier to und=
erstand
> the correlation with the other if() below.  Same for tee_rproc_stop().

Regarding other references to tee_client_invoke_func(), it is the common way =
to
test the returns.

If it is okay for you I would prefer to keep this implementation


>=20
>> +		dev_err(tee_rproc_ctx->dev,
>> +			"TA_RPROC_FW_CMD_START_FW invoke failed TEE err: %x, ret:%x\n",
>> +			arg.ret, ret);
>> +		if (!ret)
>> +			ret =3D -EIO;
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_rproc_start);
>> +
>> +int tee_rproc_stop(struct tee_rproc *trproc)
>> +{
>> +	struct tee_ioctl_invoke_arg arg;
>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>> +	int ret;
>> +
>> +	prepare_args(trproc, TA_RPROC_FW_CMD_STOP_FW, &arg, param, 0);
>> +
>> +	ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret !=3D 0) {
>> +		dev_err(tee_rproc_ctx->dev,
>> +			"TA_RPROC_FW_CMD_STOP_FW invoke failed TEE err: %x, ret:%x\n",
>> +			arg.ret, ret);
>> +		if (!ret)
>> +			ret =3D -EIO;
>> +	}
>> +	if (trproc->rsc_va)
>> +		iounmap(trproc->rsc_va);
>> +	trproc->rsc_va =3D NULL;
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_rproc_stop);
>> +
>> +static const struct tee_client_device_id stm32_tee_rproc_id_table[] =3D {
>> +	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905,
>> +		   0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
>> +	{}
>> +};
>> +
>> +struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int rpr=
oc_id)
>> +{
>> +	struct tee_client_device *rproc_tee_device;
>> +	struct tee_ioctl_open_session_arg sess_arg;
>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>> +	struct tee_rproc *trproc;
>> +	int ret;
>> +
>> +	/*
>> +	 * The device is not probed by the TEE bus. We ignore the reason (bus co=
uld be not yet
>> +	 * probed or service not available in the secure firmware)
>> +	 * Assumption here is that the TEE bus is not probed.
>> +	 */
>> +	if (!tee_rproc_ctx)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	trproc =3D  devm_kzalloc(dev, sizeof(*trproc), GFP_KERNEL);
>> +	if (!trproc)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	rproc_tee_device =3D to_tee_client_device(tee_rproc_ctx->dev);
>> +	memset(&sess_arg, 0, sizeof(sess_arg));
>> +
>> +	/* Open session with rproc_tee load the OP-TEE Trusted Application */
>> +	memcpy(sess_arg.uuid, rproc_tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
>> +
>> +	sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
>> +	sess_arg.num_params =3D 1;
>> +
>> +	param[0] =3D (struct tee_param) {
>> +		.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>> +		.u.value.a =3D rproc_id,
>> +	};
>> +
>> +	ret =3D tee_client_open_session(tee_rproc_ctx->tee_ctx, &sess_arg, param=
);
>> +	if (ret < 0 || sess_arg.ret !=3D 0) {
>> +		dev_err(dev, "tee_client_open_session failed, err: %x\n", sess_arg.ret);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	trproc->parent =3D  dev;
>> +	trproc->rproc_id =3D rproc_id;
>> +	trproc->session_id =3D sess_arg.session;
>> +
>> +	list_add_tail(&trproc->node, &tee_rproc_ctx->sessions);
>> +
>> +	return trproc;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_rproc_register);
>> +
>> +int tee_rproc_unregister(struct tee_rproc *trproc)
>> +{
>> +	int ret;
>> +
>> +	if (!tee_rproc_ctx)
>> +		return -ENODEV;
>=20
> Not sure this check is needed since we can't be here if memory allocation f=
or
> @tee_rproc_ctx failed in tee_rproc_probe().
>=20
>> +
>> +	ret =3D tee_client_close_session(tee_rproc_ctx->tee_ctx, trproc->session=
_id);
>> +	if (ret < 0)
>> +		dev_err(trproc->parent,	"tee_client_close_session failed, err: %x\n", r=
et);
>> +
>> +	list_del(&trproc->node);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_rproc_unregister);
>> +
>> +static int tee_ctx_match(struct tee_ioctl_version_data *ver, const void *=
data)
>> +{
>> +	/* Today we support only the OP-TEE, could be extend to other tees */
>> +	return (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE);
>> +}
>> +
>> +static int tee_rproc_probe(struct device *dev)
>> +{
>> +	struct tee_context *tee_ctx;
>> +	int ret;
>> +
>> +	/* Only one RPROC OP-TEE device allowed */
>> +	if (tee_rproc_ctx) {
>> +		dev_err(dev, "An RPROC OP-TEE device was already initialized: only one =
allowed\n");
>> +		return -EBUSY;
>> +	}
>=20
> Is this check needed? How can @tee_rproc_ctx be initialized twice?


Right, this kind of check makes sense in OP-TEE, here it is probably over che=
ck.
I will clean it.


Thanks,
Arnaud

>=20
> More comments tomorrow.
>=20
> Thanks,
> Mathieu
>=20
>> +
>> +	/* Open context with TEE driver */
>> +	tee_ctx =3D tee_client_open_context(NULL, tee_ctx_match, NULL, NULL);
>> +	if (IS_ERR(tee_ctx))
>> +		return PTR_ERR(tee_ctx);
>> +
>> +	tee_rproc_ctx =3D devm_kzalloc(dev, sizeof(*tee_ctx), GFP_KERNEL);
>> +	if (!tee_ctx) {
>> +		ret =3D -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	tee_rproc_ctx->dev =3D dev;
>> +	tee_rproc_ctx->tee_ctx =3D tee_ctx;
>> +	INIT_LIST_HEAD(&tee_rproc_ctx->sessions);
>> +
>> +	return 0;
>> +err:
>> +	tee_client_close_context(tee_ctx);
>> +
>> +	return ret;
>> +}
>> +
>> +static int tee_rproc_remove(struct device *dev)
>> +{
>> +	struct tee_rproc *entry, *tmp;
>> +
>> +	list_for_each_entry_safe(entry, tmp, &tee_rproc_ctx->sessions, node) {
>> +		tee_client_close_session(tee_rproc_ctx->tee_ctx, entry->session_id);
>> +		list_del(&entry->node);
>> +		kfree(entry);
>> +	}
>> +
>> +	tee_client_close_context(tee_rproc_ctx->tee_ctx);
>> +
>> +	return 0;
>> +}
>> +
>> +MODULE_DEVICE_TABLE(tee, stm32_tee_rproc_id_table);
>> +
>> +static struct tee_client_driver tee_rproc_fw_driver =3D {
>> +	.id_table	=3D stm32_tee_rproc_id_table,
>> +	.driver		=3D {
>> +		.name		=3D KBUILD_MODNAME,
>> +		.bus		=3D &tee_bus_type,
>> +		.probe		=3D tee_rproc_probe,
>> +		.remove		=3D tee_rproc_remove,
>> +	},
>> +};
>> +
>> +static int __init tee_rproc_fw_mod_init(void)
>> +{
>> +	return driver_register(&tee_rproc_fw_driver.driver);
>> +}
>> +
>> +static void __exit tee_rproc_fw_mod_exit(void)
>> +{
>> +	driver_unregister(&tee_rproc_fw_driver.driver);
>> +}
>> +
>> +module_init(tee_rproc_fw_mod_init);
>> +module_exit(tee_rproc_fw_mod_exit);
>> +
>> +MODULE_DESCRIPTION(" TEE remote processor control driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/tee_remoteproc.h b/include/linux/tee_remoteproc=
.h
>> new file mode 100644
>> index 000000000000..537d6dc3b858
>> --- /dev/null
>> +++ b/include/linux/tee_remoteproc.h
>> @@ -0,0 +1,99 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright(c) 2023 STMicroelectronics - All Rights Reserved
>> + */
>> +
>> +#ifndef TEE_REMOTEPROC_H
>> +#define TEE_REMOTEPROC_H
>> +
>> +#include <linux/remoteproc.h>
>> +#include <linux/tee_drv.h>
>> +
>> +/**
>> + * struct tee_rproc - TEE remoteproc structure
>> + * @node:		Reference in list
>> + * @rproc:		Remoteproc reference
>> + * @parent:		Parent device
>> + * @rproc_id:		Identifier of the target firmware
>> + * @session_id:		TEE session identifier
>> + * @rsc_va:		Resource table virtual address.
>> + */
>> +struct tee_rproc {
>> +	struct list_head node;
>> +	struct rproc *rproc;
>> +	struct device *parent;
>> +	u32 rproc_id;
>> +	u32 session_id;
>> +	void __iomem *rsc_va;
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_TEE_REMOTEPROC)
>> +
>> +struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int rpr=
oc_id);
>> +int tee_rproc_unregister(struct tee_rproc *trproc);
>> +
>> +int tee_rproc_load_fw(struct tee_rproc *trproc, const struct firmware *fw=
);
>> +int rproc_tee_get_rsc_table(struct tee_rproc *trproc);
>> +struct resource_table *tee_rproc_get_loaded_rsc_table(struct tee_rproc *t=
rproc);
>> +int tee_rproc_start(struct tee_rproc *trproc);
>> +int tee_rproc_stop(struct tee_rproc *trproc);
>> +
>> +#else
>> +
>> +static inline struct tee_rproc *tee_rproc_register(struct device *dev, un=
signed int rproc_id)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline int tee_rproc_unregister(struct tee_rproc *trproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int tee_rproc_load_fw(struct tee_rproc *trproc,
>> +				    const struct firmware *fw)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int tee_rproc_start(struct tee_rproc *trproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int tee_rproc_stop(struct tee_rproc *trproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_tee_get_rsc_table(struct tee_rproc *trproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline struct resource_table *
>> +	tee_rproc_get_loaded_rsc_table(struct tee_rproc *trproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return NULL;
>> +}
>> +
>> +#endif /* CONFIG_TEE_REMOTEPROC */
>> +#endif /* TEE_REMOTEPROC_H */
>> --=20
>> 2.25.1
>>

--===============4971105796209741065==--

