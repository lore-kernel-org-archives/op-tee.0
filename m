From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 1/7] remoteproc: Add TEE support
Date: Thu, 29 Feb 2024 09:19:25 -0700
Message-ID: <ZeCujRgH/odzU9og@p14s>
In-Reply-To: <74b7a8a4-20e4-4210-8de5-0282ab3fbd9c@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7462553143568208902=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7462553143568208902==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Good morning,

On Wed, Feb 28, 2024 at 09:20:28AM +0100, Arnaud POULIQUEN wrote:
> Hello Mathieu,
>=20
>=20
> On 2/23/24 19:27, Mathieu Poirier wrote:
> > On Wed, Feb 14, 2024 at 06:21:21PM +0100, Arnaud Pouliquen wrote:
> >> From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >>
> >> Add a remoteproc TEE (Trusted Execution Environment) driver
> >> that will be probed by the TEE bus. If the associated Trusted
> >> application is supported on secure part this device offers a client
> >> interface to load a firmware in the secure part.
> >> This firmware could be authenticated and decrypted by the secure
> >> trusted application.
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> ---
> >> update from V2
> >> - Use 'tee_rproc' prefix for all functions
> >> - rename tee_rproc_get_loaded_rsc_table to tee_rproc_find_loaded_rsc_tab=
le
> >> - redefine fonction to better match with the rproc_ops structure format
> >> 	- replace 'struct tee_rproc' parameter by 'struct rproc' parameter
> >> 	- rename 'rproc_tee_get_rsc_table()' to tee_rproc_get_loaded_rsc_table()
> >> 	  and rework it to remove the cached_table management.
> >> 	- introduce tee_rproc_get_context() to get the tee_rproc struct from the
> >>           rproc struct
> >> 	- rename tee_rproc_get_loaded_rsc_table() to tee_rproc_find_loaded_rsc_=
table()
> >> - remove useless check on tee_rproc_ctx structure in tee_rproc_register()
> >>   and tee_rproc_unregister()
> >> - fix test on the return of tee_rproc_ctx =3D devm_kzalloc()
> >> - remove useless includes and unused tee_rproc_mem structure.
> >> ---
> >>  drivers/remoteproc/Kconfig          |   9 +
> >>  drivers/remoteproc/Makefile         |   1 +
> >>  drivers/remoteproc/tee_remoteproc.c | 397 ++++++++++++++++++++++++++++
> >>  include/linux/tee_remoteproc.h      | 102 +++++++
> >>  4 files changed, 509 insertions(+)
> >>  create mode 100644 drivers/remoteproc/tee_remoteproc.c
> >>  create mode 100644 include/linux/tee_remoteproc.h
> >>
> >> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >> index 48845dc8fa85..85299606806c 100644
> >> --- a/drivers/remoteproc/Kconfig
> >> +++ b/drivers/remoteproc/Kconfig
> >> @@ -365,6 +365,15 @@ config XLNX_R5_REMOTEPROC
> >> =20
> >>  	  It's safe to say N if not interested in using RPU r5f cores.
> >> =20
> >> +
> >> +config TEE_REMOTEPROC
> >> +	tristate "trusted firmware support by a TEE application"
> >> +	depends on OPTEE
> >> +	help
> >> +	  Support for trusted remote processors firmware. The firmware
> >> +	  authentication and/or decryption are managed by a trusted applicatio=
n.
> >> +	  This can be either built-in or a loadable module.
> >> +
> >>  endif # REMOTEPROC
> >> =20
> >>  endmenu
> >> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> >> index 91314a9b43ce..fa8daebce277 100644
> >> --- a/drivers/remoteproc/Makefile
> >> +++ b/drivers/remoteproc/Makefile
> >> @@ -36,6 +36,7 @@ obj-$(CONFIG_RCAR_REMOTEPROC)		+=3D rcar_rproc.o
> >>  obj-$(CONFIG_ST_REMOTEPROC)		+=3D st_remoteproc.o
> >>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+=3D st_slim_rproc.o
> >>  obj-$(CONFIG_STM32_RPROC)		+=3D stm32_rproc.o
> >> +obj-$(CONFIG_TEE_REMOTEPROC)		+=3D tee_remoteproc.o
> >>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+=3D ti_k3_dsp_remoteproc.o
> >>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+=3D ti_k3_r5_remoteproc.o
> >>  obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+=3D xlnx_r5_remoteproc.o
> >> diff --git a/drivers/remoteproc/tee_remoteproc.c b/drivers/remoteproc/te=
e_remoteproc.c
> >> new file mode 100644
> >> index 000000000000..ac727e062d00
> >> --- /dev/null
> >> +++ b/drivers/remoteproc/tee_remoteproc.c
> >> @@ -0,0 +1,397 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
> >> + * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> + */
> >> +
> >> +#include <linux/firmware.h>
> >> +#include <linux/io.h>
> >> +#include <linux/module.h>
> >> +#include <linux/remoteproc.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/tee_drv.h>
> >> +#include <linux/tee_remoteproc.h>
> >> +
> >> +#include "remoteproc_internal.h"
> >> +
> >> +#define MAX_TEE_PARAM_ARRY_MEMBER	4
> >> +
> >> +/*
> >> + * Authentication of the firmware and load in the remote processor memo=
ry
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote proce=
ssor
> >> + * [in]	 params[1].memref:	buffer containing the image of the buffer
> >> + */
> >> +#define TA_RPROC_FW_CMD_LOAD_FW		1
> >> +
> >> +/*
> >> + * Start the remote processor
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote proce=
ssor
> >> + */
> >> +#define TA_RPROC_FW_CMD_START_FW	2
> >> +
> >> +/*
> >> + * Stop the remote processor
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote proce=
ssor
> >> + */
> >> +#define TA_RPROC_FW_CMD_STOP_FW		3
> >> +
> >> +/*
> >> + * Return the address of the resource table, or 0 if not found
> >> + * No check is done to verify that the address returned is accessible by
> >> + * the non secure context. If the resource table is loaded in a protect=
ed
> >> + * memory the access by the non secure context will lead to a data abor=
t.
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote proce=
ssor
> >> + * [out]  params[1].value.a:	32bit LSB resource table memory address
> >> + * [out]  params[1].value.b:	32bit MSB resource table memory address
> >> + * [out]  params[2].value.a:	32bit LSB resource table memory size
> >> + * [out]  params[2].value.b:	32bit MSB resource table memory size
> >> + */
> >> +#define TA_RPROC_FW_CMD_GET_RSC_TABLE	4
> >> +
> >> +/*
> >> + * Return the address of the core dump
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote proce=
ssor
> >> + * [out] params[1].memref:	address of the core dump image if exist,
> >> + *				else return Null
> >> + */
> >> +#define TA_RPROC_FW_CMD_GET_COREDUMP	5
> >> +
> >> +struct tee_rproc__context {
> >> +	struct list_head sessions;
> >> +	struct tee_context *tee_ctx;
> >> +	struct device *dev;
> >> +};
> >> +
> >> +static struct tee_rproc__context *tee_rproc_ctx;
> >> +
> >> +static void prepare_args(struct tee_rproc *trproc, int cmd,
> >> +			 struct tee_ioctl_invoke_arg *arg,
> >> +			 struct tee_param *param, unsigned int num_params)
> >> +{
> >> +	memset(arg, 0, sizeof(*arg));
> >> +	memset(param, 0, MAX_TEE_PARAM_ARRY_MEMBER * sizeof(*param));
> >> +
> >> +	arg->func =3D cmd;
> >> +	arg->session =3D trproc->session_id;
> >> +	arg->num_params =3D num_params + 1;
> >> +
> >> +	param[0] =3D (struct tee_param) {
> >> +		.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> >> +		.u.value.a =3D trproc->rproc_id,
> >> +	};
> >> +}
> >> +
> >> +static struct tee_rproc *tee_rproc_get_context(struct rproc *rproc)
> >> +{
> >> +	struct tee_rproc *entry, *tmp;
> >> +
> >> +	list_for_each_entry_safe(entry, tmp, &tee_rproc_ctx->sessions, node) {
> >> +		if (entry->rproc =3D=3D rproc)
> >> +			return entry;
> >> +	}
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >> +int tee_rproc_load_fw(struct rproc *rproc, const struct firmware *fw)
> >> +{
> >> +	struct tee_ioctl_invoke_arg arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	struct tee_rproc *trproc =3D tee_rproc_get_context(rproc);
> >> +	struct tee_shm *fw_shm;
> >> +	int ret;
> >> +
> >> +	if (!trproc)
> >> +		return -EINVAL;
> >> +
> >> +	fw_shm =3D tee_shm_register_kernel_buf(tee_rproc_ctx->tee_ctx, (void *=
)fw->data, fw->size);
> >> +	if (IS_ERR(fw_shm))
> >> +		return PTR_ERR(fw_shm);
> >> +
> >> +	prepare_args(trproc, TA_RPROC_FW_CMD_LOAD_FW, &arg, param, 1);
> >> +
> >> +	/* Provide the address of the firmware image */
> >> +	param[1] =3D (struct tee_param) {
> >> +		.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> >> +		.u.memref =3D {
> >> +			.shm =3D fw_shm,
> >> +			.size =3D fw->size,
> >> +			.shm_offs =3D 0,
> >> +		},
> >> +	};
> >> +
> >> +	ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
> >> +	if (ret < 0 || arg.ret !=3D 0) {
> >> +		dev_err(tee_rproc_ctx->dev,
> >> +			"TA_RPROC_FW_CMD_LOAD_FW invoke failed TEE err: %x, ret:%x\n",
> >> +			arg.ret, ret);
> >> +		if (!ret)
> >> +			ret =3D -EIO;
> >> +	}
> >> +
> >> +	tee_shm_free(fw_shm);
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_load_fw);
> >> +
> >> +struct resource_table *tee_rproc_get_loaded_rsc_table(struct rproc *rpr=
oc, size_t *table_sz)
> >> +{
> >> +	struct tee_ioctl_invoke_arg arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	struct tee_rproc *trproc =3D tee_rproc_get_context(rproc);
> >> +	int ret;
> >> +
> >> +	if (!trproc)
> >> +		return ERR_PTR(-EINVAL);
> >> +
> >> +	prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
> >> +
> >> +	param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> >> +	param[2].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> >> +
> >> +	ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
> >> +	if (ret < 0 || arg.ret !=3D 0) {
> >> +		dev_err(tee_rproc_ctx->dev,
> >> +			"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %x, ret:%x\n",
> >> +			arg.ret, ret);
> >> +		return ERR_PTR(-EIO);
> >> +	}
> >> +
> >> +	*table_sz =3D param[2].u.value.a;
> >> +
> >> +	/* If the size is null no resource table defined in the image */
> >> +	if (!*table_sz)
> >> +		return NULL;
> >> +
> >> +	/* Store the resource table address that would be updated by the remot=
e core. */
> >> +	trproc->rsc_table =3D ioremap_wc(param[1].u.value.a, *table_sz);
> >> +	if (IS_ERR_OR_NULL(trproc->rsc_table)) {
> >> +		dev_err(tee_rproc_ctx->dev, "Unable to map memory region: %lld+%zx\n",
> >> +			param[1].u.value.a, *table_sz);
> >> +		return ERR_PTR(-ENOMEM);
> >> +	}
> >> +
> >> +	return trproc->rsc_table;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_get_loaded_rsc_table);
> >=20
> > Here we are missing:
> >=20
> > tee_rproc_parse_fw()
>=20
> Please tell me if I'm wrong but the aim of this ops is to parse the firmware
> before loading it in case of some resources shoukd be needed before.
> but here to parse it we load. I'm not sure that this function makes sense h=
ere.
>=20

The documentation for rproc_ops::parse_fw [1] indicate the operation
is to extract the resource table from the firmware image, something that is
echoed in by the implementation of rproc_elf_load_rsc_table().  No matter what
the secure side needs or how it does it, this function should return the addr=
ess
of the resource table. =20

[1]. https://elixir.bootlin.com/linux/v6.8-rc6/source/include/linux/remotepro=
c.h#L370

> > {
> >         tee_rproc_load_fw()
> >         resource_table =3D tee_rproc_get_loaded_rsc_table()
> >=20
> >         //check error conditions here
> >=20
> >         rproc->cached_table =3D resource_table;
> >         rproc->table_ptr =3D resource_table;
>=20
> This seems to me that it is not possible regarding
> the "memcpy(loaded_table, rproc->cached_table, rproc->table_sz)"[1] in
> rproc_start() and the kfree(rproc->cached_table) [2] in rproc_shutdown(). We
> would copy with the same source and destibnation address.
> In this case a memory should be allocated for the rproc->cached_table.
>=20

I touched base on how to fix the handling of the resource table in rproc_star=
t()
in an earlier reply, but because of the kfree() in rproc_shutdown, I agree
rproc->cached_table should be set to NULL.  That said, there needs to be a
detailed explanation of what is happening in rproc_start().

>=20
> > }
> >=20
> > This is essentially the same as rproc_elf_load_rsc_table(). That way we d=
on't
> > need rproc_alt_fw_boot() and rproc_load_segments() doesn't have to be mov=
ed
> > around.=20
>=20
> The trusted application simply needs to know that if the firmware is
> > already loaded, it has to return.=20
>=20
> Today trying to load twice time is considered as an error in OP-TEE [3].

That can be fixed.

> As it is a constraint introduced by Linux, I would prefer treated it  in th=
e Linux.

Things in the remoteproc subsystem have been working just fine for well over a
decade.  I'd say this is introduced by contraints from an image that is handl=
ed
by the secure world.

>=20
> What about introduce a "fw_loaded" flag in tee_rproc__context?

I'd like to avoid that since the flag is associated with the specific way the
trusted application works.  That flag surely won't apply, or new flags will be
introduced, when another trusted application to handle the remote processor's
firmware is introduced.

>=20
>=20
> [1]
> https://elixir.bootlin.com/linux/v6.8-rc6/source/drivers/remoteproc/remotep=
roc_core.c#L1289
> [2]
> https://elixir.bootlin.com/linux/v6.8-rc6/source/drivers/remoteproc/remotep=
roc_core.c#L2024
> [3]
> https://elixir.bootlin.com/op-tee/latest/source/ta/remoteproc/src/remotepro=
c_core.c#L896
>=20
>=20
> Regards,
> Arnaud
>=20
> >=20
> >> +
> >> +struct resource_table *tee_rproc_find_loaded_rsc_table(struct rproc *rp=
roc,
> >> +						       const struct firmware *fw)
> >> +{
> >> +	struct tee_rproc *trproc =3D tee_rproc_get_context(rproc);
> >> +	size_t table_sz;
> >> +
> >> +	if (!trproc)
> >> +		return ERR_PTR(-EINVAL);
> >> +
> >> +	if (!trproc->rsc_table)
> >> +		trproc->rsc_table =3D tee_rproc_get_loaded_rsc_table(rproc, &table_sz=
);
> >> +
> >> +	return trproc->rsc_table;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_find_loaded_rsc_table);
> >> +
> >> +int tee_rproc_start(struct rproc *rproc)
> >> +{
> >> +	struct tee_ioctl_invoke_arg arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	struct tee_rproc *trproc =3D tee_rproc_get_context(rproc);
> >> +	int ret;
> >> +
> >> +	if (!trproc)
> >> +		return -EINVAL;
> >> +
> >> +	prepare_args(trproc, TA_RPROC_FW_CMD_START_FW, &arg, param, 0);
> >> +
> >> +	ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
> >> +	if (ret < 0 || arg.ret !=3D 0) {
> >> +		dev_err(tee_rproc_ctx->dev,
> >> +			"TA_RPROC_FW_CMD_START_FW invoke failed TEE err: %x, ret:%x\n",
> >> +			arg.ret, ret);
> >> +		if (!ret)
> >> +			ret =3D -EIO;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_start);
> >> +
> >> +int tee_rproc_stop(struct rproc *rproc)
> >> +{
> >> +	struct tee_ioctl_invoke_arg arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	struct tee_rproc *trproc =3D tee_rproc_get_context(rproc);
> >> +	int ret;
> >> +
> >> +	if (!trproc)
> >> +		return -EINVAL;
> >> +
> >> +	prepare_args(trproc, TA_RPROC_FW_CMD_STOP_FW, &arg, param, 0);
> >> +
> >> +	ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
> >> +	if (ret < 0 || arg.ret !=3D 0) {
> >> +		dev_err(tee_rproc_ctx->dev,
> >> +			"TA_RPROC_FW_CMD_STOP_FW invoke failed TEE err: %x, ret:%x\n",
> >> +			arg.ret, ret);
> >> +		if (!ret)
> >> +			ret =3D -EIO;
> >> +	}
> >> +	if (trproc->rsc_table)
> >> +		iounmap(trproc->rsc_table);
> >> +	trproc->rsc_table =3D NULL;
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_stop);
> >> +
> >> +static const struct tee_client_device_id stm32_tee_rproc_id_table[] =3D=
 {
> >> +	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905,
> >> +		   0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
> >> +	{}
> >> +};
> >> +
> >> +struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int r=
proc_id)
> >> +{
> >> +	struct tee_client_device *tee_device;
> >> +	struct tee_ioctl_open_session_arg sess_arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	struct tee_rproc *trproc;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * The device is not probed by the TEE bus. We ignore the reason (bus =
could be not yet
> >> +	 * probed or service not available in the secure firmware)
> >> +	 * Assumption here is that the TEE bus is not probed.
> >> +	 */
> >> +	if (!tee_rproc_ctx)
> >> +		return ERR_PTR(-EPROBE_DEFER);
> >> +
> >> +	trproc =3D  devm_kzalloc(dev, sizeof(*trproc), GFP_KERNEL);
> >> +	if (!trproc)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	tee_device =3D to_tee_client_device(tee_rproc_ctx->dev);
> >> +	memset(&sess_arg, 0, sizeof(sess_arg));
> >> +
> >> +	/* Open session with rproc_tee load the OP-TEE Trusted Application */
> >> +	memcpy(sess_arg.uuid, tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> >> +
> >> +	sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> >> +	sess_arg.num_params =3D 1;
> >> +
> >> +	param[0] =3D (struct tee_param) {
> >> +		.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> >> +		.u.value.a =3D rproc_id,
> >> +	};
> >> +
> >> +	ret =3D tee_client_open_session(tee_rproc_ctx->tee_ctx, &sess_arg, par=
am);
> >> +	if (ret < 0 || sess_arg.ret !=3D 0) {
> >> +		dev_err(dev, "tee_client_open_session failed, err: %x\n", sess_arg.re=
t);
> >> +		return ERR_PTR(-EINVAL);
> >> +	}
> >> +
> >> +	trproc->parent =3D  dev;
> >> +	trproc->rproc_id =3D rproc_id;
> >> +	trproc->session_id =3D sess_arg.session;
> >> +
> >> +	list_add_tail(&trproc->node, &tee_rproc_ctx->sessions);
> >> +
> >> +	return trproc;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_register);
> >> +
> >> +int tee_rproc_unregister(struct tee_rproc *trproc)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret =3D tee_client_close_session(tee_rproc_ctx->tee_ctx, trproc->sessi=
on_id);
> >> +	if (ret < 0)
> >> +		dev_err(trproc->parent,	"tee_client_close_session failed, err: %x\n",=
 ret);
> >> +
> >> +	list_del(&trproc->node);
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_unregister);
> >> +
> >> +static int tee_rproc_ctx_match(struct tee_ioctl_version_data *ver, cons=
t void *data)
> >> +{
> >> +	/* Today we support only the OP-TEE, could be extend to other tees */
> >> +	return (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE);
> >> +}
> >> +
> >> +static int tee_rproc_probe(struct device *dev)
> >> +{
> >> +	struct tee_context *tee_ctx;
> >> +	int ret;
> >> +
> >> +	/* Open context with TEE driver */
> >> +	tee_ctx =3D tee_client_open_context(NULL, tee_rproc_ctx_match, NULL, N=
ULL);
> >> +	if (IS_ERR(tee_ctx))
> >> +		return PTR_ERR(tee_ctx);
> >> +
> >> +	tee_rproc_ctx =3D devm_kzalloc(dev, sizeof(*tee_ctx), GFP_KERNEL);
> >> +	if (!tee_rproc_ctx) {
> >> +		ret =3D -ENOMEM;
> >> +		goto err;
> >> +	}
> >> +
> >> +	tee_rproc_ctx->dev =3D dev;
> >> +	tee_rproc_ctx->tee_ctx =3D tee_ctx;
> >> +	INIT_LIST_HEAD(&tee_rproc_ctx->sessions);
> >> +
> >> +	return 0;
> >> +err:
> >> +	tee_client_close_context(tee_ctx);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int tee_rproc_remove(struct device *dev)
> >> +{
> >> +	struct tee_rproc *entry, *tmp;
> >> +
> >> +	list_for_each_entry_safe(entry, tmp, &tee_rproc_ctx->sessions, node) {
> >> +		tee_client_close_session(tee_rproc_ctx->tee_ctx, entry->session_id);
> >> +		list_del(&entry->node);
> >> +		kfree(entry);
> >> +	}
> >> +
> >> +	tee_client_close_context(tee_rproc_ctx->tee_ctx);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +MODULE_DEVICE_TABLE(tee, stm32_tee_rproc_id_table);
> >> +
> >> +static struct tee_client_driver tee_rproc_fw_driver =3D {
> >> +	.id_table	=3D stm32_tee_rproc_id_table,
> >> +	.driver		=3D {
> >> +		.name		=3D KBUILD_MODNAME,
> >> +		.bus		=3D &tee_bus_type,
> >> +		.probe		=3D tee_rproc_probe,
> >> +		.remove		=3D tee_rproc_remove,
> >> +	},
> >> +};
> >> +
> >> +static int __init tee_rproc_fw_mod_init(void)
> >> +{
> >> +	return driver_register(&tee_rproc_fw_driver.driver);
> >> +}
> >> +
> >> +static void __exit tee_rproc_fw_mod_exit(void)
> >> +{
> >> +	driver_unregister(&tee_rproc_fw_driver.driver);
> >> +}
> >> +
> >> +module_init(tee_rproc_fw_mod_init);
> >> +module_exit(tee_rproc_fw_mod_exit);
> >> +
> >> +MODULE_DESCRIPTION(" TEE remote processor control driver");
> >> +MODULE_LICENSE("GPL");
> >> diff --git a/include/linux/tee_remoteproc.h b/include/linux/tee_remotepr=
oc.h
> >> new file mode 100644
> >> index 000000000000..7c9e91e989ba
> >> --- /dev/null
> >> +++ b/include/linux/tee_remoteproc.h
> >> @@ -0,0 +1,102 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +/*
> >> + * Copyright(c) 2023 STMicroelectronics - All Rights Reserved
> >> + */
> >> +
> >> +#ifndef TEE_REMOTEPROC_H
> >> +#define TEE_REMOTEPROC_H
> >> +
> >> +#include <linux/tee_drv.h>
> >> +#include <linux/firmware.h>
> >> +#include <linux/remoteproc.h>
> >> +
> >> +struct rproc;
> >> +
> >> +/**
> >> + * struct tee_rproc - TEE remoteproc structure
> >> + * @node:		Reference in list
> >> + * @rproc:		Remoteproc reference
> >> + * @parent:		Parent device
> >> + * @rproc_id:		Identifier of the target firmware
> >> + * @session_id:		TEE session identifier
> >> + * @rsc_table:		Resource table virtual address.
> >> + */
> >> +struct tee_rproc {
> >> +	struct list_head node;
> >> +	struct rproc *rproc;
> >> +	struct device *parent;
> >> +	u32 rproc_id;
> >> +	u32 session_id;
> >> +	struct resource_table *rsc_table;
> >> +};
> >> +
> >> +#if IS_ENABLED(CONFIG_TEE_REMOTEPROC)
> >> +
> >> +struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int r=
proc_id);
> >> +int tee_rproc_unregister(struct tee_rproc *trproc);
> >> +
> >> +int tee_rproc_load_fw(struct rproc *rproc, const struct firmware *fw);
> >> +struct resource_table *tee_rproc_get_loaded_rsc_table(struct rproc *rpr=
oc, size_t *table_sz);
> >> +struct resource_table *tee_rproc_find_loaded_rsc_table(struct rproc *rp=
roc,
> >> +						       const struct firmware *fw);
> >> +int tee_rproc_start(struct rproc *rproc);
> >> +int tee_rproc_stop(struct rproc *rproc);
> >> +
> >> +#else
> >> +
> >> +static inline struct tee_rproc *tee_rproc_register(struct device *dev, =
unsigned int rproc_id)
> >> +{
> >> +	return ERR_PTR(-ENODEV);
> >> +}
> >> +
> >> +static inline int tee_rproc_unregister(struct tee_rproc *trproc)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline int tee_rproc_load_fw(struct rproc *rproc,  const struct =
firmware *fw)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline int tee_rproc_start(struct rproc *rproc)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline int tee_rproc_stop(struct rproc *rproc)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline struct resource_table *
> >> +tee_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >> +static inline struct resource_table *
> >> +tee_rproc_find_loaded_rsc_table(struct rproc *rproc, const struct firmw=
are *fw)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return NULL;
> >> +}
> >> +#endif /* CONFIG_TEE_REMOTEPROC */
> >> +#endif /* TEE_REMOTEPROC_H */
> >> --=20
> >> 2.25.1
> >>

--===============7462553143568208902==--

