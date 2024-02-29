From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Thu, 29 Feb 2024 18:17:20 +0000
Message-ID: <429d5df5-ab41-408b-a50a-2388f2efc92b@foss.st.com>
In-Reply-To: <Zdjl6Z2ktTwi+oWp@p14s>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5075619079965525263=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5075619079965525263==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 2/23/24 19:37, Mathieu Poirier wrote:
> On Fri, Feb 23, 2024 at 02:54:13PM +0100, Arnaud POULIQUEN wrote:
>> Hello Mathieu,
>>
>> On 2/22/24 20:02, Mathieu Poirier wrote:
>>> Hi,
>>>
>>> On Wed, Feb 14, 2024 at 06:21:27PM +0100, Arnaud Pouliquen wrote:
>>>> The new TEE remoteproc device is used to manage remote firmware in a
>>>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
>>>> introduced to delegate the loading of the firmware to the trusted
>>>> execution context. In such cases, the firmware should be signed and
>>>> adhere to the image format defined by the TEE.
>>>>
>>>> A new "to_attach" field is introduced to differentiate the use cases
>>>> "firmware loaded by the boot stage" and "firmware loaded by the TEE".
>>>>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>> ---
>>>> V2 to V3 update:
>>>> - remove stm32_rproc_tee_elf_sanity_check(), stm32_rproc_tee_elf_load()
>>>>   stm32_rproc_tee_elf_find_loaded_rsc_table() and  stm32_rproc_tee_start=
() that are bnow unused
>>>> - use new rproc::alt_boot field to sepcify that the alternate fboot meth=
od is used
>>>> - use stm32_rproc::to_attach field to differenciate attch mode from remo=
teproc tee boot mode.
>>>> - remove the used of stm32_rproc::fw_loaded
>>>> ---
>>>>  drivers/remoteproc/stm32_rproc.c | 85 +++++++++++++++++++++++++++++---
>>>>  1 file changed, 79 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32=
_rproc.c
>>>> index fcc0001e2657..9cfcf66462e0 100644
>>>> --- a/drivers/remoteproc/stm32_rproc.c
>>>> +++ b/drivers/remoteproc/stm32_rproc.c
>>>> @@ -20,6 +20,7 @@
>>>>  #include <linux/remoteproc.h>
>>>>  #include <linux/reset.h>
>>>>  #include <linux/slab.h>
>>>> +#include <linux/tee_remoteproc.h>
>>>>  #include <linux/workqueue.h>
>>>> =20
>>>>  #include "remoteproc_internal.h"
>>>> @@ -49,6 +50,9 @@
>>>>  #define M4_STATE_STANDBY	4
>>>>  #define M4_STATE_CRASH		5
>>>> =20
>>>> +/* Remote processor unique identifier aligned with the Trusted Executio=
n Environment definitions */
>>>> +#define STM32_MP1_M4_PROC_ID    0
>>>> +
>>>>  struct stm32_syscon {
>>>>  	struct regmap *map;
>>>>  	u32 reg;
>>>> @@ -90,6 +94,8 @@ struct stm32_rproc {
>>>>  	struct stm32_mbox mb[MBOX_NB_MBX];
>>>>  	struct workqueue_struct *workqueue;
>>>>  	bool hold_boot_smc;
>>>> +	bool to_attach;
>>>> +	struct tee_rproc *trproc;
>>>>  	void __iomem *rsc_va;
>>>>  };
>>>> =20
>>>> @@ -253,10 +259,30 @@ static int stm32_rproc_release(struct rproc *rproc)
>>>>  			return err;
>>>>  		}
>>>>  	}
>>>> +	ddata->to_attach =3D false;
>>>> =20
>>>>  	return err;
>>>>  }
>>>> =20
>>>> +static int stm32_rproc_tee_attach(struct rproc *rproc)
>>>> +{
>>>> +	/* Nothing to do, remote proc already started by the secured context. =
*/
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int stm32_rproc_tee_stop(struct rproc *rproc)
>>>> +{
>>>> +	int err;
>>>> +
>>>> +	stm32_rproc_request_shutdown(rproc);
>>>> +
>>>> +	err =3D tee_rproc_stop(rproc);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>> +	return stm32_rproc_release(rproc);
>>>> +}
>>>> +
>>>>  static int stm32_rproc_prepare(struct rproc *rproc)
>>>>  {
>>>>  	struct device *dev =3D rproc->dev.parent;
>>>> @@ -637,10 +663,14 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rpr=
oc, size_t *table_sz)
>>>>  {
>>>>  	struct stm32_rproc *ddata =3D rproc->priv;
>>>>  	struct device *dev =3D rproc->dev.parent;
>>>> +	struct tee_rproc *trproc =3D ddata->trproc;
>>>>  	phys_addr_t rsc_pa;
>>>>  	u32 rsc_da;
>>>>  	int err;
>>>> =20
>>>> +	if (trproc && !ddata->to_attach)
>>>> +		return tee_rproc_get_loaded_rsc_table(rproc, table_sz);
>>>> +
>>>
>>> Why do we need a flag at all?  Why can't st_rproc_tee_ops::get_loaded_rsc=
_table
>>> be set to tee_rproc_get_loaded_rsc_table()?
>>
>>
>> This function is used to retrieve the address of the resource table in 3 c=
ases
>> - attach to a firmware started by the boot loader (U-boot).
>> - load of the firmware by OP-TEE.
>> - crash recovery on a signed firmware started by the boot loader.
>>
>> The flag is used to differentiate the attch from the other uses cases
>> For instance we support this use case.
>> 1) attach to the firmware on boot
>> 2) crash during runtime
>>   2a) stop the firmware by OP-TEE( ddata->to_attach set to 0)
>>   2b) load the firmware by OP-TEE
>>   2c) get the loaded resource table from OP-TEE (we can not guaranty
>>       that the firmware loaded on recovery is the same)
>>   2d) restart the firmware by OP-TEE
>=20
> This is not maintainable and needs to be broken down into smaller
> building blocks.  The introduction of tee_rproc_parse_fw() should help deal=
ing
> with some of the complexity.

The use cases I mentioned are supported by the legacy, if firmware is not
authenticated by a Trusted Application.
No problem to addressed this in a second step.
I will remove this constrain from this series in next version.

Regards,
Arnaud

>=20
>>
>>>
>>>>  	/* The resource table has already been mapped, nothing to do */
>>>>  	if (ddata->rsc_va)
>>>>  		goto done;
>>>> @@ -693,8 +723,20 @@ static const struct rproc_ops st_rproc_ops =3D {
>>>>  	.get_boot_addr	=3D rproc_elf_get_boot_addr,
>>>>  };
>>>> =20
>>>> +static const struct rproc_ops st_rproc_tee_ops =3D {
>>>> +	.prepare	=3D stm32_rproc_prepare,
>>>> +	.start		=3D tee_rproc_start,
>>>> +	.stop		=3D stm32_rproc_tee_stop,
>>>> +	.attach		=3D stm32_rproc_tee_attach,
>>>> +	.kick		=3D stm32_rproc_kick,
>>>> +	.get_loaded_rsc_table =3D stm32_rproc_get_loaded_rsc_table,
>>>> +	.find_loaded_rsc_table =3D tee_rproc_find_loaded_rsc_table,
>>>> +	.load		=3D tee_rproc_load_fw,
>>>> +};
>>>> +
>>>>  static const struct of_device_id stm32_rproc_match[] =3D {
>>>> -	{ .compatible =3D "st,stm32mp1-m4" },
>>>> +	{.compatible =3D "st,stm32mp1-m4",},
>>>> +	{.compatible =3D "st,stm32mp1-m4-tee",},
>>>>  	{},
>>>>  };
>>>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
>>>> @@ -853,6 +895,7 @@ static int stm32_rproc_probe(struct platform_device =
*pdev)
>>>>  	struct device *dev =3D &pdev->dev;
>>>>  	struct stm32_rproc *ddata;
>>>>  	struct device_node *np =3D dev->of_node;
>>>> +	struct tee_rproc *trproc =3D NULL;
>>>>  	struct rproc *rproc;
>>>>  	unsigned int state;
>>>>  	int ret;
>>>> @@ -861,12 +904,33 @@ static int stm32_rproc_probe(struct platform_devic=
e *pdev)
>>>>  	if (ret)
>>>>  		return ret;
>>>> =20
>>>> -	rproc =3D rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddat=
a));
>>>> -	if (!rproc)
>>>> -		return -ENOMEM;
>>>
>>> This patch doesn't apply to rproc-next - please rebase.
>>
>> Yes, sure. I forgot to mention in my cover letter that my series has been
>> applied and tested on 841c35169323 (Linux 6.8-rc4).
>>
>>>
>>>
>>>> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
>>>> +		/*
>>>> +		 * Delegate the firmware management to the secure context.
>>>> +		 * The firmware loaded has to be signed.
>>>> +		 */
>>>> +		trproc =3D tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
>>>> +		if (IS_ERR(trproc)) {
>>>> +			dev_err_probe(dev, PTR_ERR(trproc),
>>>> +				      "signed firmware not supported by TEE\n");
>>>> +			return PTR_ERR(trproc);
>>>> +		}
>>>> +	}
>>>> =20
>>>> -	ddata =3D rproc->priv;
>>>> +	rproc =3D rproc_alloc(dev, np->name,
>>>> +			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
>>>> +			    NULL, sizeof(*ddata));
>>>> +	if (!rproc) {
>>>> +		ret =3D -ENOMEM;
>>>> +		goto free_tee;
>>>> +	}
>>>> =20
>>>> +	ddata =3D rproc->priv;
>>>> +	ddata->trproc =3D trproc;
>>>
>>> My opinion hasn't changed from the previous patchet, i.e tee_rproc should=
 be
>>> folded in struct rproc as rproc::tee_interface.
>>
>> Sure, I will do it in next version
>>
>>>
>>> More comments to come shortly...
>>>
>>
>> Thanks!
>> Arnaud
>>
>>>> +	if (trproc) {
>>>> +		rproc->alt_boot =3D true;
>>>> +		trproc->rproc =3D rproc;
>>>> +	}
>>>>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>>>> =20
>>>>  	ret =3D stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
>>>> @@ -881,8 +945,10 @@ static int stm32_rproc_probe(struct platform_device=
 *pdev)
>>>>  	if (ret)
>>>>  		goto free_rproc;
>>>> =20
>>>> -	if (state =3D=3D M4_STATE_CRUN)
>>>> +	if (state =3D=3D M4_STATE_CRUN) {
>>>>  		rproc->state =3D RPROC_DETACHED;
>>>> +		ddata->to_attach =3D true;
>>>> +	}
>>>> =20
>>>>  	rproc->has_iommu =3D false;
>>>>  	ddata->workqueue =3D create_workqueue(dev_name(dev));
>>>> @@ -916,6 +982,10 @@ static int stm32_rproc_probe(struct platform_device=
 *pdev)
>>>>  		device_init_wakeup(dev, false);
>>>>  	}
>>>>  	rproc_free(rproc);
>>>> +free_tee:
>>>> +	if (trproc)
>>>> +		tee_rproc_unregister(trproc);
>>>> +
>>>>  	return ret;
>>>>  }
>>>> =20
>>>> @@ -923,6 +993,7 @@ static void stm32_rproc_remove(struct platform_devic=
e *pdev)
>>>>  {
>>>>  	struct rproc *rproc =3D platform_get_drvdata(pdev);
>>>>  	struct stm32_rproc *ddata =3D rproc->priv;
>>>> +	struct tee_rproc *trproc =3D ddata->trproc;
>>>>  	struct device *dev =3D &pdev->dev;
>>>> =20
>>>>  	if (atomic_read(&rproc->power) > 0)
>>>> @@ -937,6 +1008,8 @@ static void stm32_rproc_remove(struct platform_devi=
ce *pdev)
>>>>  		device_init_wakeup(dev, false);
>>>>  	}
>>>>  	rproc_free(rproc);
>>>> +	if (trproc)
>>>> +		tee_rproc_unregister(trproc);
>>>>  }
>>>> =20
>>>>  static int stm32_rproc_suspend(struct device *dev)
>>>> --=20
>>>> 2.25.1
>>>>
>>>

--===============5075619079965525263==--

