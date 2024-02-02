From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Fri, 02 Feb 2024 12:53:34 -0700
Message-ID: <Zb1IPlnbMp9Utu2y@p14s>
In-Reply-To: <a52e00c5-fb60-4a9e-85ff-0f9649850f48@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4229562060358500328=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4229562060358500328==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 07:33:35PM +0100, Arnaud POULIQUEN wrote:
>=20
>=20
> On 2/1/24 17:02, Mathieu Poirier wrote:
> > On Thu, Feb 01, 2024 at 04:06:37PM +0100, Arnaud POULIQUEN wrote:
> >> hello Mathieu,
> >>
> >> On 1/31/24 19:52, Mathieu Poirier wrote:
> >>> On Tue, Jan 30, 2024 at 10:13:48AM +0100, Arnaud POULIQUEN wrote:
> >>>>
> >>>>
> >>>> On 1/26/24 18:11, Mathieu Poirier wrote:
> >>>>> On Thu, Jan 18, 2024 at 11:04:33AM +0100, Arnaud Pouliquen wrote:
> >>>>>> The new TEE remoteproc device is used to manage remote firmware in a
> >>>>>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
> >>>>>> introduced to delegate the loading of the firmware to the trusted
> >>>>>> execution context. In such cases, the firmware should be signed and
> >>>>>> adhere to the image format defined by the TEE.
> >>>>>>
> >>>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >>>>>> ---
> >>>>>> V1 to V2 update:
> >>>>>> - remove the select "TEE_REMOTEPROC" in STM32_RPROC config as detect=
ed by
> >>>>>>   the kernel test robot:
> >>>>>>      WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
> >>>>>>      Depends on [n]: REMOTEPROC [=3Dy] && OPTEE [=3Dn]
> >>>>>>      Selected by [y]:
> >>>>>>      - STM32_RPROC [=3Dy] && (ARCH_STM32 || COMPILE_TEST [=3Dy]) && =
REMOTEPROC [=3Dy]
> >>>>>> - Fix initialized trproc variable in  stm32_rproc_probe
> >>>>>> ---
> >>>>>>  drivers/remoteproc/stm32_rproc.c | 149 ++++++++++++++++++++++++++++=
+--
> >>>>>>  1 file changed, 144 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/s=
tm32_rproc.c
> >>>>>> index fcc0001e2657..cf6a21bac945 100644
> >>>>>> --- a/drivers/remoteproc/stm32_rproc.c
> >>>>>> +++ b/drivers/remoteproc/stm32_rproc.c
> >>>>>> @@ -20,6 +20,7 @@
> >>>>>>  #include <linux/remoteproc.h>
> >>>>>>  #include <linux/reset.h>
> >>>>>>  #include <linux/slab.h>
> >>>>>> +#include <linux/tee_remoteproc.h>
> >>>>>>  #include <linux/workqueue.h>
> >>>>>> =20
> >>>>>>  #include "remoteproc_internal.h"
> >>>>>> @@ -49,6 +50,9 @@
> >>>>>>  #define M4_STATE_STANDBY	4
> >>>>>>  #define M4_STATE_CRASH		5
> >>>>>> =20
> >>>>>> +/* Remote processor unique identifier aligned with the Trusted Exec=
ution Environment definitions */
> >>>>>> +#define STM32_MP1_M4_PROC_ID    0
> >>>>>> +
> >>>>>>  struct stm32_syscon {
> >>>>>>  	struct regmap *map;
> >>>>>>  	u32 reg;
> >>>>>> @@ -90,6 +94,8 @@ struct stm32_rproc {
> >>>>>>  	struct stm32_mbox mb[MBOX_NB_MBX];
> >>>>>>  	struct workqueue_struct *workqueue;
> >>>>>>  	bool hold_boot_smc;
> >>>>>> +	bool fw_loaded;
> >>>>>> +	struct tee_rproc *trproc;
> >>>>>>  	void __iomem *rsc_va;
> >>>>>>  };
> >>>>>> =20
> >>>>>> @@ -257,6 +263,91 @@ static int stm32_rproc_release(struct rproc *rp=
roc)
> >>>>>>  	return err;
> >>>>>>  }
> >>>>>> =20
> >>>>>> +static int stm32_rproc_tee_elf_sanity_check(struct rproc *rproc,
> >>>>>> +					    const struct firmware *fw)
> >>>>>> +{
> >>>>>> +	struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>> +	unsigned int ret =3D 0;
> >>>>>> +
> >>>>>> +	if (rproc->state =3D=3D RPROC_DETACHED)
> >>>>>> +		return 0;
> >>>>>> +
> >>>>>> +	ret =3D tee_rproc_load_fw(ddata->trproc, fw);
> >>>>>> +	if (!ret)
> >>>>>> +		ddata->fw_loaded =3D true;
> >>>>>> +
> >>>>>> +	return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int stm32_rproc_tee_elf_load(struct rproc *rproc,
> >>>>>> +				    const struct firmware *fw)
> >>>>>> +{
> >>>>>> +	struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>> +	unsigned int ret;
> >>>>>> +
> >>>>>> +	/*
> >>>>>> +	 * This function can be called by remote proc for recovery
> >>>>>> +	 * without the sanity check. In this case we need to load the firm=
ware
> >>>>>> +	 * else nothing done here as the firmware has been preloaded for t=
he
> >>>>>> +	 * sanity check to be able to parse it for the resource table.
> >>>>>> +	 */
> >>>>>
> >>>>> This comment is very confusing - please consider refactoring. =20
> >>>>>
> >>>>>> +	if (ddata->fw_loaded)
> >>>>>> +		return 0;
> >>>>>> +
> >>>>>
> >>>>> I'm not sure about keeping a flag to indicate the status of the loade=
d firmware.
> >>>>> It is not done for the non-secure method, I don't see why it would be=
 needed for
> >>>>> the secure one.
> >>>>>
> >>>>
> >>>> The difference is on the sanity check.
> >>>> - in rproc_elf_sanity_check we  parse the elf file to verify that it is
> >>>> valid.
> >>>> - in stm32_rproc_tee_elf_sanity_check we have to do the same, that mea=
ns to
> >>>> authenticate it. the authentication is done during the load.
> >>>>
> >>>> So this flag is used to avoid to reload it twice time.
> >>>> refactoring the comment should help to understand this flag
> >>>>
> >>>>
> >>>> An alternative would be to bypass the sanity check. But this lead to s=
ame
> >>>> limitation.
> >>>> Before loading the firmware in remoteproc_core, we call rproc_parse_fw=
() that is
> >>>> used to get the resource table address. To get it from tee we need to
> >>>> authenticate the firmware so load it...
> >>>>
> >>>
> >>> I spent a long time thinking about this patchset.  Looking at the code =
as it
> >>> is now, request_firmware() in rproc_boot() is called even when the TEE =
is
> >>> responsible for loading the firmware.  There should be some conditional=
 code
> >>> that calls either request_firmware() or tee_rproc_load_fw().  The latte=
r should
> >>> also be renamed to tee_rproc_request_firmware() to avoid confusion.
> >>
> >>
> >> The request_firmware() call is needed in both cases to get the image fro=
m the
> >> filesystem. The tee_rproc_load_fw() gets, as input, the struct firmware =
provided
> >> by request_firmware().
> >=20
> > The cover letter clearly state the secure side is responsible for loading=
 the
> > firmware image but here you're telling me it has to be loaded twice.  Thi=
s is
> > very confusing.
>=20
> Concerning the call of request_firmware()
>=20
> By "both cases" I would say that the call of request_firmware() is needed in
> both modes:
> - the ELF firmware is parsed and loaded by linux (legacy)
> - the binary firmware is parsed and loaded by OP-TEE.
>=20
> The Op-TEE is not able to get the firmware image from the file system.
>
>=20
> Concerning the call of tee_rproc_load_fw twice time
>=20
> There are 2 use cases:
>=20
> - First boot of the remote processor:
>=20
>   1) The Linux rproc gets the binary firmware image from the file system by
>      calling  request_firmware(). A copy is stored in memory.

Right.  And I think tee_rproc_load_fw() should be called right after
request_firmware() if rproc::tee_rproc_interface is valid.  At that point the=
 TEE
app may or may not do the firmware authentication, that is application specif=
ic.

>   2) the linux performs a sanity check on the firmware calling
>      rproc_fw_sanity_check()
> 	=3D> from OP-TEE point of view this means to autenticate the firmware
> 	=3D> let consider in this exemple that we bypass this step
>            (ops->sanity_check =3D NULL)

Ok

> 	=09
>   3) the linux rproc call rproc_parse_fw() to get the resource table
> 	=3D> From OP-TEE point of view the resource table is available only when
>            the firmware is loaded

Right, and it should have been loaded already.  If it is not then the TEE sho=
uld
return an error.

> 	=3D> We need to call tee_rproc_load_fw() to be able then to get the
>            address of the resource table.

See my comment above - at this point the TEE should already have the firmware.
As such the only thing left is to get the address of the resource table, which
you already do in rproc_tee_get_rsc_table().  The upper part of that function
should be spun off in a new static function to deal with the TEE API, somethi=
ng
like _rproc_tee_get_rsc_table().  The new function should also be called in
tee_rproc_get_loaded_rsc_table() rather than keeping a cache value in
trproc->rsc_va.

>   4) The Linux rproc calls rproc_handle_resources() to parse the resource t=
able.
>   5) The linux rproc calls rproc_start()
> 	- load the firrmware calling rproc_load_segments()
> 		=3D> we don't want to call tee_rproc_load_fw() it a second time

And that is fine if the TEE app has already placed the program segments in
memory.

> 	- start the firmware calling ops->start()
>=20
> - Reboot on crash recovery using rproc_boot_recovery()
>=20
>   1)  The Linux rproc gets the binary firmware image from the file system by
>      calling request_firmware(). A copy is stored in memory.
>   5) The linux rproc calls rproc_start()
> 	- load the firrmware calling rproc_load_segments()
> 		=3D> we have to call tee_rproc_load_fw() to reload the firmware

Loading the firmware in the TEE should be done right after request_firmware()
has been called, the same way it is done in the boot path.  If there isn't a
need to reload the TEE firmware than the TEE application should ignore the
request.

> 	- start the firmware calling ops->start()
>=20
> In first use case we have to load the firmware on rproc_parse_fw(), in seco=
nd
> usecase on rproc_load_segments().
>=20
> This is the point I have tried to solve with the ddata->fw_loaded variable.
>=20
> >=20
> > I'm also confused as to why stm32_rproc_tee_elf_sanity_check() is calling
> > tee_rproc_load_fw().  There should be one call to load the firmware and a=
nother
> > to perform a sanity check on it.  If the sanity check is done at load tim=
e by
> > the secure world then ops::sanity_check() is NULL.
>=20
> Sure, make sense to remove the sanity_check ops
>=20
> Thanks,
> Arnaud
>=20
> >=20
> > Most of what this patchset does makes sense, but some of it needs to be m=
oved
> > around. =20
> >=20
> > Thanks,
> > Mathieu
> >=20
> >>
> >> If we want to integrate in remoteproc_core the solution could probably h=
ave to
> >> create the equivalent of the rproc_fw_boot() to load the firmware with an
> >> external method. Here is an example based on a new rproc_ops ( not teste=
d)
> >>
> >> + static int rproc_fw_ext_boot(struct rproc *rproc, const struct firmwar=
e *fw)
> >> + {
> >> + 	struct device *dev =3D &rproc->dev;
> >> + 	const char *name =3D rproc->firmware;
> >> + 	int ret;
> >> +
> >> +
> >> + 	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
> >> + =09
> >> + 	/* ops to load and start the remoteprocessor */
> >> + 	ret =3D rproc->ops->boot(rproc, fw);
> >> + 	if (ret)
> >> + 		return ret;
> >> +
> >> + 	/*
> >> + 	 * if enabling an IOMMU isn't relevant for this rproc, this is
> >> + 	 * just a nop
> >> + 	 */
> >> + 	ret =3D rproc_enable_iommu(rproc);
> >> + 	if (ret) {
> >> + 		dev_err(dev, "can't enable iommu: %d\n", ret);
> >> + 		return ret;
> >> + 	}
> >> +
> >> + 	/* Prepare rproc for firmware loading if needed */
> >> + 	ret =3D rproc_prepare_device(rproc);
> >> + 	if (ret) {
> >> + 		dev_err(dev, "can't prepare rproc %s: %d\n", rproc->name, ret);
> >> + 		goto disable_iommu;
> >> + 	}
> >> +
> >> + 	ret =3D rproc_set_rsc_table(rproc);
> >> + 	if (ret) {
> >> + 		dev_err(dev, "can't load resource table: %d\n", ret);
> >> + 		goto unprepare_device;
> >> + 	}
> >> +
> >> +
> >> + 	/* reset max_notifyid */
> >> + 	rproc->max_notifyid =3D -1;
> >> +
> >> + 	/* reset handled vdev */
> >> + 	rproc->nb_vdev =3D 0;
> >> +
> >> + 	/* handle fw resources which are required to boot rproc */
> >> + 	ret =3D rproc_handle_resources(rproc, rproc_loading_handlers);
> >> + 	if (ret) {
> >> + 		dev_err(dev, "Failed to process resources: %d\n", ret);
> >> + 		goto clean_up_resources;
> >> + 	}
> >> +
> >> + 	/* Allocate carveout resources associated to rproc */
> >> + 	ret =3D rproc_alloc_registered_carveouts(rproc);
> >> + 	if (ret) {
> >> + 		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
> >> + 			ret);
> >> + 		goto clean_up_resources;
> >> + 	}
> >> +
> >> + 	return 0;
> >> +
> >> + clean_up_resources:
> >> + 	rproc_resource_cleanup(rproc);
> >> + unprepare_rproc:
> >> + 	/* release HW resources if needed */
> >> + 	rproc_unprepare_device(rproc);
> >> + disable_iommu:
> >> + 	rproc_disable_iommu(rproc);
> >> + 	return ret;
> >> + }
> >>
> >>
> >> int rproc_boot(struct rproc *rproc)
> >> {
> >> [...]
> >>
> >> - 		ret =3D rproc_fw_boot(rproc, firmware_p);
> >> + 		if(rproc->ops->boot)
> >> + 			ret =3D rproc_fw_ext_boot(rproc, firmware_p);
> >> + 		else
> >> + 			ret =3D rproc_fw_boot(rproc, firmware_p);
> >>
> >> Another advantage of this solution is that it opens the framework to oth=
er
> >> formats. For instance it could be a way to support dtb format requested =
in [RFC]
> >> Passing device-tree to remoteproc [1].
> >>
> >> [1]
> >> https://lore.kernel.org/linux-remoteproc/f67cd822-4e29-71f2-7c42-e11dbaa=
6cd8c(a)kalrayinc.com/T/#t
> >>
> >> Thanks,
> >> Arnaud
> >>
> >>
> >>
> >>>
> >>> I touched on that before but please rename rproc_tee_get_rsc_table() to
> >>> rproc_tee_elf_load_rsc_table().  I also suggest to introduce a new func=
tion,
> >>> rproc_tee_get_loaded_rsc_table() that would be called from
> >>> rproc_tee_elf_load_rsc_table().  That way we don't need trproc->rsc_va.=
 =20
> >>>
> >>> I also think tee_rproc should be renamed to "rproc_tee_interface" and f=
olded
> >>> under struct rproc. =20
> >>>
> >>> With the above most of the problems with the current implementation sho=
uld
> >>> naturally go away.
> >>>
> >>> Thanks,
> >>> Mathieu
> >>>
> >>>>
> >>>>>> +	ret =3D tee_rproc_load_fw(ddata->trproc, fw);
> >>>>>> +	if (ret)
> >>>>>> +		return ret;
> >>>>>> +	ddata->fw_loaded =3D true;
> >>>>>> +
> >>>>>> +	/* Update the resource table parameters. */
> >>>>>> +	if (rproc_tee_get_rsc_table(ddata->trproc)) {
> >>>>>> +		/* No resource table: reset the related fields. */
> >>>>>> +		rproc->cached_table =3D NULL;
> >>>>>> +		rproc->table_ptr =3D NULL;
> >>>>>> +		rproc->table_sz =3D 0;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static struct resource_table *
> >>>>>> +stm32_rproc_tee_elf_find_loaded_rsc_table(struct rproc *rproc,
> >>>>>> +					  const struct firmware *fw)
> >>>>>> +{
> >>>>>> +	struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>> +
> >>>>>> +	return tee_rproc_get_loaded_rsc_table(ddata->trproc);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int stm32_rproc_tee_start(struct rproc *rproc)
> >>>>>> +{
> >>>>>> +	struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>> +
> >>>>>> +	return tee_rproc_start(ddata->trproc);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int stm32_rproc_tee_attach(struct rproc *rproc)
> >>>>>> +{
> >>>>>> +	/* Nothing to do, remote proc already started by the secured conte=
xt. */
> >>>>>> +	return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int stm32_rproc_tee_stop(struct rproc *rproc)
> >>>>>> +{
> >>>>>> +	struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>> +	int err;
> >>>>>> +
> >>>>>> +	stm32_rproc_request_shutdown(rproc);
> >>>>>> +
> >>>>>> +	err =3D tee_rproc_stop(ddata->trproc);
> >>>>>> +	if (err)
> >>>>>> +		return err;
> >>>>>> +
> >>>>>> +	ddata->fw_loaded =3D false;
> >>>>>> +
> >>>>>> +	return stm32_rproc_release(rproc);
> >>>>>> +}
> >>>>>> +
> >>>>>>  static int stm32_rproc_prepare(struct rproc *rproc)
> >>>>>>  {
> >>>>>>  	struct device *dev =3D rproc->dev.parent;
> >>>>>> @@ -319,7 +410,14 @@ static int stm32_rproc_prepare(struct rproc *rp=
roc)
> >>>>>> =20
> >>>>>>  static int stm32_rproc_parse_fw(struct rproc *rproc, const struct f=
irmware *fw)
> >>>>>>  {
> >>>>>> -	if (rproc_elf_load_rsc_table(rproc, fw))
> >>>>>> +	struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>> +	int ret;
> >>>>>> +
> >>>>>> +	if (ddata->trproc)
> >>>>>> +		ret =3D rproc_tee_get_rsc_table(ddata->trproc);
> >>>>>> +	else
> >>>>>> +		ret =3D rproc_elf_load_rsc_table(rproc, fw);
> >>>>>> +	if (ret)
> >>>>>>  		dev_warn(&rproc->dev, "no resource table found for this firmware\=
n");
> >>>>>> =20
> >>>>>>  	return 0;
> >>>>>> @@ -693,8 +791,22 @@ static const struct rproc_ops st_rproc_ops =3D {
> >>>>>>  	.get_boot_addr	=3D rproc_elf_get_boot_addr,
> >>>>>>  };
> >>>>>> =20
> >>>>>> +static const struct rproc_ops st_rproc_tee_ops =3D {
> >>>>>> +	.prepare	=3D stm32_rproc_prepare,
> >>>>>> +	.start		=3D stm32_rproc_tee_start,
> >>>>>> +	.stop		=3D stm32_rproc_tee_stop,
> >>>>>> +	.attach		=3D stm32_rproc_tee_attach,
> >>>>>> +	.kick		=3D stm32_rproc_kick,
> >>>>>> +	.parse_fw	=3D stm32_rproc_parse_fw,
> >>>>>> +	.find_loaded_rsc_table =3D stm32_rproc_tee_elf_find_loaded_rsc_tab=
le,
> >>>>>> +	.get_loaded_rsc_table =3D stm32_rproc_get_loaded_rsc_table,
> >>>>>> +	.sanity_check	=3D stm32_rproc_tee_elf_sanity_check,
> >>>>>> +	.load		=3D stm32_rproc_tee_elf_load,
> >>>>>> +};
> >>>>>> +
> >>>>>>  static const struct of_device_id stm32_rproc_match[] =3D {
> >>>>>> -	{ .compatible =3D "st,stm32mp1-m4" },
> >>>>>> +	{.compatible =3D "st,stm32mp1-m4",},
> >>>>>> +	{.compatible =3D "st,stm32mp1-m4-tee",},
> >>>>>>  	{},
> >>>>>>  };
> >>>>>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
> >>>>>> @@ -853,6 +965,7 @@ static int stm32_rproc_probe(struct platform_dev=
ice *pdev)
> >>>>>>  	struct device *dev =3D &pdev->dev;
> >>>>>>  	struct stm32_rproc *ddata;
> >>>>>>  	struct device_node *np =3D dev->of_node;
> >>>>>> +	struct tee_rproc *trproc =3D NULL;
> >>>>>>  	struct rproc *rproc;
> >>>>>>  	unsigned int state;
> >>>>>>  	int ret;
> >>>>>> @@ -861,11 +974,31 @@ static int stm32_rproc_probe(struct platform_d=
evice *pdev)
> >>>>>>  	if (ret)
> >>>>>>  		return ret;
> >>>>>> =20
> >>>>>> -	rproc =3D rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*=
ddata));
> >>>>>> -	if (!rproc)
> >>>>>> -		return -ENOMEM;
> >>>>>> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
> >>>>>> +		trproc =3D tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
> >>>>>> +		if (IS_ERR(trproc)) {
> >>>>>> +			dev_err_probe(dev, PTR_ERR(trproc),
> >>>>>> +				      "signed firmware not supported by TEE\n");
> >>>>>> +			return PTR_ERR(trproc);
> >>>>>> +		}
> >>>>>> +		/*
> >>>>>> +		 * Delegate the firmware management to the secure context.
> >>>>>> +		 * The firmware loaded has to be signed.
> >>>>>> +		 */
> >>>>>> +		dev_info(dev, "Support of signed firmware only\n");
> >>>>>
> >>>>> Not sure what this adds.  Please remove.
> >>>>
> >>>> This is used to inform the user that only a signed firmware can be loa=
ded, not
> >>>> an ELF file.
> >>>> I have a patch in my pipe to provide the supported format in the debug=
fs. In a
> >>>> first step, I can suppress this message and we can revisit the issue w=
hen I push
> >>>> the debugfs proposal.
> >>>>
> >>>> Thanks,
> >>>> Arnaud
> >>>>
> >>>>>
> >>>>>> +	}
> >>>>>> +	rproc =3D rproc_alloc(dev, np->name,
> >>>>>> +			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
> >>>>>> +			    NULL, sizeof(*ddata));
> >>>>>> +	if (!rproc) {
> >>>>>> +		ret =3D -ENOMEM;
> >>>>>> +		goto free_tee;
> >>>>>> +	}
> >>>>>> =20
> >>>>>>  	ddata =3D rproc->priv;
> >>>>>> +	ddata->trproc =3D trproc;
> >>>>>> +	if (trproc)
> >>>>>> +		trproc->rproc =3D rproc;
> >>>>>> =20
> >>>>>>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
> >>>>>> =20
> >>>>>> @@ -916,6 +1049,10 @@ static int stm32_rproc_probe(struct platform_d=
evice *pdev)
> >>>>>>  		device_init_wakeup(dev, false);
> >>>>>>  	}
> >>>>>>  	rproc_free(rproc);
> >>>>>> +free_tee:
> >>>>>> +	if (trproc)
> >>>>>> +		tee_rproc_unregister(trproc);
> >>>>>> +
> >>>>>>  	return ret;
> >>>>>>  }
> >>>>>> =20
> >>>>>> @@ -937,6 +1074,8 @@ static void stm32_rproc_remove(struct platform_=
device *pdev)
> >>>>>>  		device_init_wakeup(dev, false);
> >>>>>>  	}
> >>>>>>  	rproc_free(rproc);
> >>>>>> +	if (ddata->trproc)
> >>>>>> +		tee_rproc_unregister(ddata->trproc);
> >>>>>>  }
> >>>>>> =20
> >>>>>>  static int stm32_rproc_suspend(struct device *dev)
> >>>>>> --=20
> >>>>>> 2.25.1
> >>>>>>

--===============4229562060358500328==--

