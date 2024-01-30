From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Tue, 30 Jan 2024 09:14:05 +0000
Message-ID: <7ec6c9e8-9267-4e7c-81a4-abcdb2ab4239@foss.st.com>
In-Reply-To: <ZbPnsJm67G10+HQ3@p14s>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7035670335434702945=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7035670335434702945==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 1/26/24 18:11, Mathieu Poirier wrote:
> On Thu, Jan 18, 2024 at 11:04:33AM +0100, Arnaud Pouliquen wrote:
>> The new TEE remoteproc device is used to manage remote firmware in a
>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
>> introduced to delegate the loading of the firmware to the trusted
>> execution context. In such cases, the firmware should be signed and
>> adhere to the image format defined by the TEE.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> V1 to V2 update:
>> - remove the select "TEE_REMOTEPROC" in STM32_RPROC config as detected by
>>   the kernel test robot:
>>      WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
>>      Depends on [n]: REMOTEPROC [=3Dy] && OPTEE [=3Dn]
>>      Selected by [y]:
>>      - STM32_RPROC [=3Dy] && (ARCH_STM32 || COMPILE_TEST [=3Dy]) && REMOTE=
PROC [=3Dy]
>> - Fix initialized trproc variable in  stm32_rproc_probe
>> ---
>>  drivers/remoteproc/stm32_rproc.c | 149 +++++++++++++++++++++++++++++--
>>  1 file changed, 144 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_r=
proc.c
>> index fcc0001e2657..cf6a21bac945 100644
>> --- a/drivers/remoteproc/stm32_rproc.c
>> +++ b/drivers/remoteproc/stm32_rproc.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/remoteproc.h>
>>  #include <linux/reset.h>
>>  #include <linux/slab.h>
>> +#include <linux/tee_remoteproc.h>
>>  #include <linux/workqueue.h>
>> =20
>>  #include "remoteproc_internal.h"
>> @@ -49,6 +50,9 @@
>>  #define M4_STATE_STANDBY	4
>>  #define M4_STATE_CRASH		5
>> =20
>> +/* Remote processor unique identifier aligned with the Trusted Execution =
Environment definitions */
>> +#define STM32_MP1_M4_PROC_ID    0
>> +
>>  struct stm32_syscon {
>>  	struct regmap *map;
>>  	u32 reg;
>> @@ -90,6 +94,8 @@ struct stm32_rproc {
>>  	struct stm32_mbox mb[MBOX_NB_MBX];
>>  	struct workqueue_struct *workqueue;
>>  	bool hold_boot_smc;
>> +	bool fw_loaded;
>> +	struct tee_rproc *trproc;
>>  	void __iomem *rsc_va;
>>  };
>> =20
>> @@ -257,6 +263,91 @@ static int stm32_rproc_release(struct rproc *rproc)
>>  	return err;
>>  }
>> =20
>> +static int stm32_rproc_tee_elf_sanity_check(struct rproc *rproc,
>> +					    const struct firmware *fw)
>> +{
>> +	struct stm32_rproc *ddata =3D rproc->priv;
>> +	unsigned int ret =3D 0;
>> +
>> +	if (rproc->state =3D=3D RPROC_DETACHED)
>> +		return 0;
>> +
>> +	ret =3D tee_rproc_load_fw(ddata->trproc, fw);
>> +	if (!ret)
>> +		ddata->fw_loaded =3D true;
>> +
>> +	return ret;
>> +}
>> +
>> +static int stm32_rproc_tee_elf_load(struct rproc *rproc,
>> +				    const struct firmware *fw)
>> +{
>> +	struct stm32_rproc *ddata =3D rproc->priv;
>> +	unsigned int ret;
>> +
>> +	/*
>> +	 * This function can be called by remote proc for recovery
>> +	 * without the sanity check. In this case we need to load the firmware
>> +	 * else nothing done here as the firmware has been preloaded for the
>> +	 * sanity check to be able to parse it for the resource table.
>> +	 */
>=20
> This comment is very confusing - please consider refactoring. =20
>=20
>> +	if (ddata->fw_loaded)
>> +		return 0;
>> +
>=20
> I'm not sure about keeping a flag to indicate the status of the loaded firm=
ware.
> It is not done for the non-secure method, I don't see why it would be neede=
d for
> the secure one.
>=20

The difference is on the sanity check.
- in rproc_elf_sanity_check we  parse the elf file to verify that it is
valid.
- in stm32_rproc_tee_elf_sanity_check we have to do the same, that means to
authenticate it. the authentication is done during the load.

So this flag is used to avoid to reload it twice time.
refactoring the comment should help to understand this flag


An alternative would be to bypass the sanity check. But this lead to same
limitation.
Before loading the firmware in remoteproc_core, we call rproc_parse_fw() that=
 is
used to get the resource table address. To get it from tee we need to
authenticate the firmware so load it...


>> +	ret =3D tee_rproc_load_fw(ddata->trproc, fw);
>> +	if (ret)
>> +		return ret;
>> +	ddata->fw_loaded =3D true;
>> +
>> +	/* Update the resource table parameters. */
>> +	if (rproc_tee_get_rsc_table(ddata->trproc)) {
>> +		/* No resource table: reset the related fields. */
>> +		rproc->cached_table =3D NULL;
>> +		rproc->table_ptr =3D NULL;
>> +		rproc->table_sz =3D 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct resource_table *
>> +stm32_rproc_tee_elf_find_loaded_rsc_table(struct rproc *rproc,
>> +					  const struct firmware *fw)
>> +{
>> +	struct stm32_rproc *ddata =3D rproc->priv;
>> +
>> +	return tee_rproc_get_loaded_rsc_table(ddata->trproc);
>> +}
>> +
>> +static int stm32_rproc_tee_start(struct rproc *rproc)
>> +{
>> +	struct stm32_rproc *ddata =3D rproc->priv;
>> +
>> +	return tee_rproc_start(ddata->trproc);
>> +}
>> +
>> +static int stm32_rproc_tee_attach(struct rproc *rproc)
>> +{
>> +	/* Nothing to do, remote proc already started by the secured context. */
>> +	return 0;
>> +}
>> +
>> +static int stm32_rproc_tee_stop(struct rproc *rproc)
>> +{
>> +	struct stm32_rproc *ddata =3D rproc->priv;
>> +	int err;
>> +
>> +	stm32_rproc_request_shutdown(rproc);
>> +
>> +	err =3D tee_rproc_stop(ddata->trproc);
>> +	if (err)
>> +		return err;
>> +
>> +	ddata->fw_loaded =3D false;
>> +
>> +	return stm32_rproc_release(rproc);
>> +}
>> +
>>  static int stm32_rproc_prepare(struct rproc *rproc)
>>  {
>>  	struct device *dev =3D rproc->dev.parent;
>> @@ -319,7 +410,14 @@ static int stm32_rproc_prepare(struct rproc *rproc)
>> =20
>>  static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmwar=
e *fw)
>>  {
>> -	if (rproc_elf_load_rsc_table(rproc, fw))
>> +	struct stm32_rproc *ddata =3D rproc->priv;
>> +	int ret;
>> +
>> +	if (ddata->trproc)
>> +		ret =3D rproc_tee_get_rsc_table(ddata->trproc);
>> +	else
>> +		ret =3D rproc_elf_load_rsc_table(rproc, fw);
>> +	if (ret)
>>  		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
>> =20
>>  	return 0;
>> @@ -693,8 +791,22 @@ static const struct rproc_ops st_rproc_ops =3D {
>>  	.get_boot_addr	=3D rproc_elf_get_boot_addr,
>>  };
>> =20
>> +static const struct rproc_ops st_rproc_tee_ops =3D {
>> +	.prepare	=3D stm32_rproc_prepare,
>> +	.start		=3D stm32_rproc_tee_start,
>> +	.stop		=3D stm32_rproc_tee_stop,
>> +	.attach		=3D stm32_rproc_tee_attach,
>> +	.kick		=3D stm32_rproc_kick,
>> +	.parse_fw	=3D stm32_rproc_parse_fw,
>> +	.find_loaded_rsc_table =3D stm32_rproc_tee_elf_find_loaded_rsc_table,
>> +	.get_loaded_rsc_table =3D stm32_rproc_get_loaded_rsc_table,
>> +	.sanity_check	=3D stm32_rproc_tee_elf_sanity_check,
>> +	.load		=3D stm32_rproc_tee_elf_load,
>> +};
>> +
>>  static const struct of_device_id stm32_rproc_match[] =3D {
>> -	{ .compatible =3D "st,stm32mp1-m4" },
>> +	{.compatible =3D "st,stm32mp1-m4",},
>> +	{.compatible =3D "st,stm32mp1-m4-tee",},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
>> @@ -853,6 +965,7 @@ static int stm32_rproc_probe(struct platform_device *p=
dev)
>>  	struct device *dev =3D &pdev->dev;
>>  	struct stm32_rproc *ddata;
>>  	struct device_node *np =3D dev->of_node;
>> +	struct tee_rproc *trproc =3D NULL;
>>  	struct rproc *rproc;
>>  	unsigned int state;
>>  	int ret;
>> @@ -861,11 +974,31 @@ static int stm32_rproc_probe(struct platform_device =
*pdev)
>>  	if (ret)
>>  		return ret;
>> =20
>> -	rproc =3D rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata)=
);
>> -	if (!rproc)
>> -		return -ENOMEM;
>> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
>> +		trproc =3D tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
>> +		if (IS_ERR(trproc)) {
>> +			dev_err_probe(dev, PTR_ERR(trproc),
>> +				      "signed firmware not supported by TEE\n");
>> +			return PTR_ERR(trproc);
>> +		}
>> +		/*
>> +		 * Delegate the firmware management to the secure context.
>> +		 * The firmware loaded has to be signed.
>> +		 */
>> +		dev_info(dev, "Support of signed firmware only\n");
>=20
> Not sure what this adds.  Please remove.

This is used to inform the user that only a signed firmware can be loaded, not
an ELF file.
I have a patch in my pipe to provide the supported format in the debugfs. In a
first step, I can suppress this message and we can revisit the issue when I p=
ush
the debugfs proposal.

Thanks,
Arnaud

>=20
>> +	}
>> +	rproc =3D rproc_alloc(dev, np->name,
>> +			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
>> +			    NULL, sizeof(*ddata));
>> +	if (!rproc) {
>> +		ret =3D -ENOMEM;
>> +		goto free_tee;
>> +	}
>> =20
>>  	ddata =3D rproc->priv;
>> +	ddata->trproc =3D trproc;
>> +	if (trproc)
>> +		trproc->rproc =3D rproc;
>> =20
>>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>> =20
>> @@ -916,6 +1049,10 @@ static int stm32_rproc_probe(struct platform_device =
*pdev)
>>  		device_init_wakeup(dev, false);
>>  	}
>>  	rproc_free(rproc);
>> +free_tee:
>> +	if (trproc)
>> +		tee_rproc_unregister(trproc);
>> +
>>  	return ret;
>>  }
>> =20
>> @@ -937,6 +1074,8 @@ static void stm32_rproc_remove(struct platform_device=
 *pdev)
>>  		device_init_wakeup(dev, false);
>>  	}
>>  	rproc_free(rproc);
>> +	if (ddata->trproc)
>> +		tee_rproc_unregister(ddata->trproc);
>>  }
>> =20
>>  static int stm32_rproc_suspend(struct device *dev)
>> --=20
>> 2.25.1
>>

--===============7035670335434702945==--

