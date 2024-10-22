From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v11 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Tue, 22 Oct 2024 09:52:09 -0600
Message-ID: <ZxfKKe5C/O16x+J4@p14s>
In-Reply-To: <20241009080108.4170320-8-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8749482146313504002=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8749482146313504002==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 10:01:08AM +0200, Arnaud Pouliquen wrote:
> The new TEE remoteproc driver is used to manage remote firmware in a
> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
> introduced to delegate the loading of the firmware to the trusted
> execution context. In such cases, the firmware should be signed and
> adhere to the image format defined by the TEE.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> updates vs v9 revision:
> - rename tee_interface to tee_rproc_itf
> - in stm32_rproc_probe(), test and use rproc->tee_rproc_itf instead of
>   trproc in the tee_rproc_unregister() call
> - initialize release_fw ops
> ---
>  drivers/remoteproc/stm32_rproc.c | 63 ++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rp=
roc.c
> index 288bd70c7861..cb7093de41df 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_wakeirq.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
> +#include <linux/remoteproc_tee.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> @@ -255,6 +256,19 @@ static int stm32_rproc_release(struct rproc *rproc)
>  	return 0;
>  }
> =20
> +static int stm32_rproc_tee_stop(struct rproc *rproc)
> +{
> +	int err;
> +
> +	stm32_rproc_request_shutdown(rproc);
> +
> +	err =3D tee_rproc_stop(rproc);
> +	if (err)
> +		return err;
> +
> +	return stm32_rproc_release(rproc);
> +}
> +
>  static int stm32_rproc_prepare(struct rproc *rproc)
>  {
>  	struct device *dev =3D rproc->dev.parent;
> @@ -691,8 +705,20 @@ static const struct rproc_ops st_rproc_ops =3D {
>  	.get_boot_addr	=3D rproc_elf_get_boot_addr,
>  };
> =20
> +static const struct rproc_ops st_rproc_tee_ops =3D {
> +	.prepare	=3D stm32_rproc_prepare,
> +	.start		=3D tee_rproc_start,
> +	.stop		=3D stm32_rproc_tee_stop,
> +	.kick		=3D stm32_rproc_kick,
> +	.load		=3D tee_rproc_load_fw,
> +	.parse_fw	=3D tee_rproc_parse_fw,
> +	.find_loaded_rsc_table =3D tee_rproc_find_loaded_rsc_table,
> +	.release_fw	=3D tee_rproc_release_fw,
> +};
> +
>  static const struct of_device_id stm32_rproc_match[] =3D {
>  	{ .compatible =3D "st,stm32mp1-m4" },
> +	{ .compatible =3D "st,stm32mp1-m4-tee" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
> @@ -851,17 +877,42 @@ static int stm32_rproc_probe(struct platform_device *=
pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct stm32_rproc *ddata;
>  	struct device_node *np =3D dev->of_node;
> +	struct tee_rproc *trproc =3D NULL;

The cleaner this patchset get, the more obvious it is (at least to me) that
struct tee_rproc needs to be changed to struct rproc_tee.  Otherwise I keep
wondering if this is coming from the TEE subsystem or the remoteproc subsyste=
m.

>  	struct rproc *rproc;
>  	unsigned int state;
> +	u32 proc_id;
>  	int ret;
> =20
>  	ret =3D dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		return ret;
> =20
> -	rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*dd=
ata));
> -	if (!rproc)
> -		return -ENOMEM;
> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
> +		/*
> +		 * Delegate the firmware management to the secure context.
> +		 * The firmware loaded has to be signed.
> +		 */
> +		ret =3D of_property_read_u32(np, "st,proc-id", &proc_id);
> +		if (ret) {
> +			dev_err(dev, "failed to read st,rproc-id property\n");
> +			return ret;
> +		}
> +
> +		rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_tee_ops, NULL, sizeo=
f(*ddata));
> +		if (!rproc)
> +			return -ENOMEM;
> +
> +		trproc =3D tee_rproc_register(dev, rproc, proc_id);

This should return an integer rather than a struct tee_rproc * since the latt=
er
is available through rproc->tee_rproc_itf.

In line with my comment above, this should be changed to rproc_tee_register()
since it belongs to the remoteproc subsystem.  Before when I asked for
tee_remoteproc.c to be changed to remoteproc_tee.c, I thought we could get by
without changing the inside but now I think it is clear that we can't - this
needs to be addressed. =20

> +		if (IS_ERR(trproc)) {
> +			dev_err_probe(dev, PTR_ERR(trproc),
> +				      "signed firmware not supported by TEE\n");
> +			return PTR_ERR(trproc);

                        return dev_err_probe(...);
> +		}
> +	} else {
> +		rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*d=
data));
> +		if (!rproc)
> +			return -ENOMEM;
> +	}
> =20
>  	ddata =3D rproc->priv;
> =20
> @@ -913,6 +964,9 @@ static int stm32_rproc_probe(struct platform_device *pd=
ev)
>  		dev_pm_clear_wake_irq(dev);
>  		device_init_wakeup(dev, false);
>  	}
> +	if (rproc->tee_rproc_itf)
> +		tee_rproc_unregister(rproc->tee_rproc_itf);
> +

If I read Bjorn's comment properly, this should probably be:

                rproc_tee_unregister(rproc);

with the if() inside the function.

>  	return ret;
>  }
> =20
> @@ -933,6 +987,9 @@ static void stm32_rproc_remove(struct platform_device *=
pdev)
>  		dev_pm_clear_wake_irq(dev);
>  		device_init_wakeup(dev, false);
>  	}
> +	if (rproc->tee_rproc_itf)
> +		tee_rproc_unregister(rproc->tee_rproc_itf);
> +

Same here.

I am done reviewing this set.

Thanks,
Mathieu

>  }
> =20
>  static int stm32_rproc_suspend(struct device *dev)
> --=20
> 2.25.1
>=20

--===============8749482146313504002==--

