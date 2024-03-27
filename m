From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Wed, 27 Mar 2024 11:14:20 -0600
Message-ID: <ZgRT7PtzIogAWc50@p14s>
In-Reply-To: <a08add21-b8ff-434a-9689-6af8b05b1965@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8428202197908947218=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8428202197908947218==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 08:31:33PM +0100, Arnaud POULIQUEN wrote:
>=20
>=20
> On 3/25/24 17:51, Mathieu Poirier wrote:
> > On Fri, Mar 08, 2024 at 03:47:08PM +0100, Arnaud Pouliquen wrote:
> >> The new TEE remoteproc device is used to manage remote firmware in a
> >> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
> >> introduced to delegate the loading of the firmware to the trusted
> >> execution context. In such cases, the firmware should be signed and
> >> adhere to the image format defined by the TEE.
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >> ---
> >> Updates from V3:
> >> - remove support of the attach use case. Will be addressed in a separate
> >>   thread,
> >> - add st_rproc_tee_ops::parse_fw ops,
> >> - inverse call of devm_rproc_alloc()and tee_rproc_register() to manage c=
ross
> >>   reference between the rproc struct and the tee_rproc struct in tee_rpr=
oc.c.
> >> ---
> >>  drivers/remoteproc/stm32_rproc.c | 60 +++++++++++++++++++++++++++++---
> >>  1 file changed, 56 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32=
_rproc.c
> >> index 8cd838df4e92..13df33c78aa2 100644
> >> --- a/drivers/remoteproc/stm32_rproc.c
> >> +++ b/drivers/remoteproc/stm32_rproc.c
> >> @@ -20,6 +20,7 @@
> >>  #include <linux/remoteproc.h>
> >>  #include <linux/reset.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/tee_remoteproc.h>
> >>  #include <linux/workqueue.h>
> >> =20
> >>  #include "remoteproc_internal.h"
> >> @@ -49,6 +50,9 @@
> >>  #define M4_STATE_STANDBY	4
> >>  #define M4_STATE_CRASH		5
> >> =20
> >> +/* Remote processor unique identifier aligned with the Trusted Executio=
n Environment definitions */
> >=20
> > Why is this the case?  At least from the kernel side it is possible to ca=
ll
> > tee_rproc_register() with any kind of value, why is there a need to be any
> > kind of alignment with the TEE?
>=20
>=20
> The use of the proc_id is to identify a processor in case of multi co-proce=
ssors.
>

That is well understood.

> For instance we can have a system with A DSP and a modem. We would use the =
same
> TEE service, but

That too.

> the TEE driver will probably be different, same for the signature key.

What TEE driver are we talking about here?

> In such case the proc ID allows to identify the the processor you want to a=
ddress.
>=20

That too is well understood, but there is no alignment needed with the TEE, i=
.e
the TEE application is not expecting a value of '0'.  We could set
STM32_MP1_M4_PROC_ID to 0xDEADBEEF and things would work.  This driver won't =
go
anywhere for as long as it is not the case.

>=20
> >=20
> >> +#define STM32_MP1_M4_PROC_ID    0
> >> +
> >>  struct stm32_syscon {
> >>  	struct regmap *map;
> >>  	u32 reg;
> >> @@ -257,6 +261,19 @@ static int stm32_rproc_release(struct rproc *rproc)
> >>  	return 0;
> >>  }
> >> =20
> >> +static int stm32_rproc_tee_stop(struct rproc *rproc)
> >> +{
> >> +	int err;
> >> +
> >> +	stm32_rproc_request_shutdown(rproc);
> >> +
> >> +	err =3D tee_rproc_stop(rproc);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	return stm32_rproc_release(rproc);
> >> +}
> >> +
> >>  static int stm32_rproc_prepare(struct rproc *rproc)
> >>  {
> >>  	struct device *dev =3D rproc->dev.parent;
> >> @@ -693,8 +710,19 @@ static const struct rproc_ops st_rproc_ops =3D {
> >>  	.get_boot_addr	=3D rproc_elf_get_boot_addr,
> >>  };
> >> =20
> >> +static const struct rproc_ops st_rproc_tee_ops =3D {
> >> +	.prepare	=3D stm32_rproc_prepare,
> >> +	.start		=3D tee_rproc_start,
> >> +	.stop		=3D stm32_rproc_tee_stop,
> >> +	.kick		=3D stm32_rproc_kick,
> >> +	.load		=3D tee_rproc_load_fw,
> >> +	.parse_fw	=3D tee_rproc_parse_fw,
> >> +	.find_loaded_rsc_table =3D tee_rproc_find_loaded_rsc_table,
> >> +};
> >> +
> >>  static const struct of_device_id stm32_rproc_match[] =3D {
> >> -	{ .compatible =3D "st,stm32mp1-m4" },
> >> +	{.compatible =3D "st,stm32mp1-m4",},
> >> +	{.compatible =3D "st,stm32mp1-m4-tee",},
> >>  	{},
> >>  };
> >>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
> >> @@ -853,6 +881,7 @@ static int stm32_rproc_probe(struct platform_device =
*pdev)
> >>  	struct device *dev =3D &pdev->dev;
> >>  	struct stm32_rproc *ddata;
> >>  	struct device_node *np =3D dev->of_node;
> >> +	struct tee_rproc *trproc =3D NULL;
> >>  	struct rproc *rproc;
> >>  	unsigned int state;
> >>  	int ret;
> >> @@ -861,9 +890,26 @@ static int stm32_rproc_probe(struct platform_device=
 *pdev)
> >>  	if (ret)
> >>  		return ret;
> >> =20
> >> -	rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(=
*ddata));
> >> -	if (!rproc)
> >> -		return -ENOMEM;
> >> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
> >> +		/*
> >> +		 * Delegate the firmware management to the secure context.
> >> +		 * The firmware loaded has to be signed.
> >> +		 */
> >> +		rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_tee_ops, NULL, si=
zeof(*ddata));
> >> +		if (!rproc)
> >> +			return -ENOMEM;
> >> +
> >> +		trproc =3D tee_rproc_register(dev, rproc, STM32_MP1_M4_PROC_ID);
> >> +		if (IS_ERR(trproc)) {
> >> +			dev_err_probe(dev, PTR_ERR(trproc),
> >> +				      "signed firmware not supported by TEE\n");
> >> +			return PTR_ERR(trproc);
> >> +		}
> >> +	} else {
> >> +		rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof=
(*ddata));
> >> +		if (!rproc)
> >> +			return -ENOMEM;
> >> +	}
> >> =20
> >>  	ddata =3D rproc->priv;
> >> =20
> >> @@ -915,6 +961,9 @@ static int stm32_rproc_probe(struct platform_device =
*pdev)
> >>  		dev_pm_clear_wake_irq(dev);
> >>  		device_init_wakeup(dev, false);
> >>  	}
> >> +	if (trproc)
> >=20
> >         if (rproc->tee_interface)
> >=20
> >=20
> > I am done reviewing this set.
>=20
> Thank for your review!
> Arnaud
>=20
> >=20
> > Thanks,
> > Mathieu
> >=20
> >> +		tee_rproc_unregister(trproc);
> >> +
> >>  	return ret;
> >>  }
> >> =20
> >> @@ -935,6 +984,9 @@ static void stm32_rproc_remove(struct platform_devic=
e *pdev)
> >>  		dev_pm_clear_wake_irq(dev);
> >>  		device_init_wakeup(dev, false);
> >>  	}
> >> +	if (rproc->tee_interface)
> >> +		tee_rproc_unregister(rproc->tee_interface);
> >> +
> >>  }
> >> =20
> >>  static int stm32_rproc_suspend(struct device *dev)
> >> --=20
> >> 2.25.1
> >>

--===============8428202197908947218==--

