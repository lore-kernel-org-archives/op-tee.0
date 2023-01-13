From: Marc Zyngier <maz@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 3/3] optee core: add irq chip using optee async notification
Date: Fri, 13 Jan 2023 09:22:29 +0000
Message-ID: <86a62mokkq.wl-maz@kernel.org>
In-Reply-To: <20230112145424.3791276-4-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8064708409944286446=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8064708409944286446==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jan 2023 14:54:24 +0000,
Etienne Carriere <etienne.carriere@linaro.org> wrote:
>=20
> Adds an irq chip in optee driver to generate interrupts from OP-TEE
> notified interrupt events based on optee async notification. Upon such
> notification, optee driver invokes OP-TEE to query a pending interrupt
> event. If an interrupt notification is pending the invocation return
> OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT and optee driver can get the pending
> interrupt number with SMC function ID OPTEE_SMC_FUNCID_GET_IT_VALUE.
>=20
> SMC function ID OPTEE_SMC_FUNCID_SET_IT_MASK allows Linux to mask/unmask
> an interrupt notification services.
>=20
> The optee irq_chip if flagged IRQCHIP_SKIP_SET_WAKE to skip set_wake
> as optee interrupt notifications doesn't support the set_wake option.
> In case a device is using the optee irq and is marked as wakeup source,
> this result in an "Unbalanced IRQ xx wake disable" backtrace, since:
> - in irq_set_irq_wake(ON), wake_depth gets incremented, then reset due to
>   set_irq_wake_real() returns an error (irq_set_wake() isn't implemented)
> - in irq_set_irq_wake(OFF), wake_depth is always 0, hence the warning

Is this relevant information?

>
> Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/tee/optee/optee_private.h |   2 +
>  drivers/tee/optee/optee_smc.h     |  78 +++++++++++++++-
>  drivers/tee/optee/smc_abi.c       | 142 ++++++++++++++++++++++++++++--
>  3 files changed, 216 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_pr=
ivate.h
> index e5bd3548691f..2a146d884d27 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -112,6 +112,7 @@ struct optee_pcpu {
>   * @optee_pcpu		per_cpu optee instance for per cpu work or NULL
>   * @notif_pcpu_wq	workqueue for per cpu aynchronous notification or NULL
>   * @notif_pcpu_work	work for per cpu asynchronous notification
> + * @domain		interrupt domain registered by OP-TEE driver
>   */
>  struct optee_smc {
>  	optee_invoke_fn *invoke_fn;
> @@ -121,6 +122,7 @@ struct optee_smc {
>  	struct optee_pcpu __percpu *optee_pcpu;
>  	struct workqueue_struct *notif_pcpu_wq;
>  	struct work_struct notif_pcpu_work;
> +	struct irq_domain *domain;
>  };
> =20
>  /**
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index 73b5e7760d10..0cf83d5a2931 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -226,7 +226,8 @@ struct optee_smc_get_shm_config_result {
>   * a3	Bit[7:0]: Number of parameters needed for RPC to be supplied
>   *		  as the second MSG arg struct for
>   *		  OPTEE_SMC_CALL_WITH_ARG
> - *	Bit[31:8]: Reserved (MBZ)
> + *	Bit[23:8]: The maximum interrupt event notification number
> + *	Bit[31:24]: Reserved (MBZ)
>   * a4-7	Preserved
>   *
>   * Error return register usage:
> @@ -254,6 +255,11 @@ struct optee_smc_get_shm_config_result {
>  #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
>  /* Secure world supports pre-allocating RPC arg struct */
>  #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
> +/* Secure world supports interrupt events notification to normal world */
> +#define OPTEE_SMC_SEC_CAP_IT_NOTIF		BIT(7)
> +
> +#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_MASK	GENMASK(23, 8)
> +#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_SHIFT	8
> =20
>  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
>  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> @@ -416,6 +422,12 @@ struct optee_smc_disable_shm_cache_result {
>   */
>  #define OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF	0
> =20
> +/*
> + * Notification that OP-TEE triggers an interrupt event to Linux kernel
> + * for an interrupt consumer.
> + */
> +#define OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT		1
> +
>  #define OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE	17
>  #define OPTEE_SMC_GET_ASYNC_NOTIF_VALUE \
>  	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE)
> @@ -426,6 +438,70 @@ struct optee_smc_disable_shm_cache_result {
>  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
>  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
> =20
> +/*
> + * Retrieve the interrupt number of the pending interrupt event notified to
> + * non-secure world since the last call of this function.
> + *
> + * OP-TEE keeps a record of all posted interrupt notification events. When=
 the
> + * async notif interrupt is received by non-secure world, this function sh=
ould
> + * be called until all pended interrupt events have been retrieved. When an
> + * interrupt event is retrieved it is cleared from the record in secure wo=
rld.
> + *
> + * It is expected that this function is called from an interrupt handler
> + * in normal world.
> + *
> + * Call requests usage:
> + * a0	SMC Function ID, OPTEE_SMC_GET_IT_NOTIF_VALUE
> + * a1-6	Not used
> + * a7	Hypervisor Client ID register
> + *
> + * Normal return register usage:
> + * a0	OPTEE_SMC_RETURN_OK
> + * a1	IT_NOTIF interrupt identifier value
> + * a2	Bit[0]: OPTEE_SMC_IT_NOTIF_VALID if the value in a1 is
> + *		valid, else 0 if no interrupt event were pending
> + * a2	Bit[1]: OPTEE_SMC_IT_NOTIF_PENDING if another interrupt event
> + *		value is pending, else 0.
> + *	Bit[31:2]: MBZ
> + * a3-7	Preserved
> + *
> + * Not supported return register usage:
> + * a0	OPTEE_SMC_RETURN_ENOTAVAIL
> + * a1-7	Preserved
> + */
> +#define OPTEE_SMC_IT_NOTIF_VALID		BIT(0)
> +#define OPTEE_SMC_IT_NOTIF_PENDING		BIT(1)
> +
> +#define OPTEE_SMC_FUNCID_GET_IT_NOTIF_VALUE	20
> +#define OPTEE_SMC_GET_IT_NOTIF_VALUE \
> +	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_IT_NOTIF_VALUE)
> +
> +/*
> + * Mask or unmask an interrupt notification event.
> + *
> + * It is expected that this function is called from an interrupt handler
> + * in normal world.
> + *
> + * Call requests usage:
> + * a0	SMC Function ID, OPTEE_SMC_SET_IT_NOTIF_MASK
> + * a1	Interrupt identifier value
> + * a2	Bit[0]: 1 if interrupt event is to be masked, 0 if it is to be unmas=
ked
> + * a2   Bit[31:1] MBZ
> + * a3-6	Not used
> + * a7	Hypervisor Client ID register
> + *
> + * Normal return register usage:
> + * a0	OPTEE_SMC_RETURN_OK
> + * a1-7	Preserved
> + *
> + * Not supported return register usage:
> + * a0	OPTEE_SMC_RETURN_ENOTAVAIL
> + * a1-7	Preserved
> + */
> +#define OPTEE_SMC_FUNCID_SET_IT_NOTIF_MASK	21
> +#define OPTEE_SMC_SET_IT_NOTIF_MASK \
> +	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_SET_IT_NOTIF_MASK)
> +
>  /*
>   * Resume from RPC (for example after processing a foreign interrupt)
>   *
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 8c2d58d605ac..0360afde119f 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -977,6 +977,112 @@ static int optee_smc_stop_async_notif(struct tee_cont=
ext *ctx)
>   * 5. Asynchronous notification
>   */
> =20
> +static u32 get_it_value(optee_invoke_fn *invoke_fn, bool *value_valid,
> +			bool *value_pending)

What value? If this is supposed to return a set of pending bits, just
name the function to reflect that.

Also, at no point do you explain that each PPI is only a mux interrupt
for a bunch of chained interrupts.

> +{
> +	struct arm_smccc_res res;
> +
> +	invoke_fn(OPTEE_SMC_GET_IT_NOTIF_VALUE, 0, 0, 0, 0, 0, 0, 0, &res);
> +
> +	if (res.a0)
> +		return 0;
> +
> +	*value_valid =3D res.a2 & OPTEE_SMC_IT_NOTIF_VALID;
> +	*value_pending =3D res.a2 & OPTEE_SMC_IT_NOTIF_PENDING;
> +	return res.a1;
> +}
> +
> +static u32 set_it_mask(optee_invoke_fn *invoke_fn, u32 it_value, bool mask)
> +{
> +	struct arm_smccc_res res;
> +
> +	invoke_fn(OPTEE_SMC_SET_IT_NOTIF_MASK, it_value, mask, 0, 0, 0, 0, 0, &re=
s);
> +
> +	if (res.a0)
> +		return 0;
> +
> +	return res.a1;
> +}
> +
> +static int handle_optee_it(struct optee *optee)
> +{
> +	bool value_valid;
> +	bool value_pending;
> +	u32 it;
> +
> +	do {
> +		struct irq_desc *desc;
> +
> +		it =3D get_it_value(optee->smc.invoke_fn, &value_valid, &value_pending);
> +		if (!value_valid)
> +			break;
> +
> +		desc =3D irq_to_desc(irq_find_mapping(optee->smc.domain, it));
> +		if (!desc) {
> +			pr_err("no desc for optee IT:%d\n", it);
> +			return -EIO;
> +		}
> +
> +		handle_simple_irq(desc);
> +

What is this? Please use generic_handle_domain_irq(), like any other
driver. Why is the flow handler handle_simple_irq()? You need to
explain what the signalling is for the secure-provided interrupts.

> +	} while (value_pending);
> +
> +	return 0;
> +}
> +
> +static void optee_it_irq_mask(struct irq_data *d)
> +{
> +	struct optee *optee =3D d->domain->host_data;
> +
> +	set_it_mask(optee->smc.invoke_fn, d->hwirq, true);
> +}
> +
> +static void optee_it_irq_unmask(struct irq_data *d)
> +{
> +	struct optee *optee =3D d->domain->host_data;
> +
> +	set_it_mask(optee->smc.invoke_fn, d->hwirq, false);
> +}
> +
> +static struct irq_chip optee_it_irq_chip =3D {
> +	.name =3D "optee-it",
> +	.irq_disable =3D optee_it_irq_mask,
> +	.irq_enable =3D optee_it_irq_unmask,
> +	.flags =3D IRQCHIP_SKIP_SET_WAKE,

Is it a mask or a disable? These are different beasts.

> +};
> +
> +static int optee_it_alloc(struct irq_domain *d, unsigned int virq,
> +			  unsigned int nr_irqs, void *data)
> +{
> +	struct irq_fwspec *fwspec =3D data;
> +	irq_hw_number_t hwirq;
> +
> +	hwirq =3D fwspec->param[0];
> +
> +	irq_domain_set_hwirq_and_chip(d, virq, hwirq, &optee_it_irq_chip, d->host=
_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops optee_it_irq_domain_ops =3D {
> +	.alloc =3D optee_it_alloc,
> +	.free =3D irq_domain_free_irqs_common,
> +};
> +
> +static int optee_irq_domain_init(struct platform_device *pdev, struct opte=
e *optee, u_int max_it)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +
> +	optee->smc.domain =3D irq_domain_add_linear(np, max_it, &optee_it_irq_dom=
ain_ops, optee);
> +	if (!optee->smc.domain) {
> +		dev_err(dev, "Unable to add irq domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>  static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_v=
alid,
>  				 bool *value_pending)
>  {
> @@ -1008,13 +1114,15 @@ static irqreturn_t notif_irq_handler(int irq, void =
*dev_id)
>  	}
> =20
>  	do {
> -		value =3D get_async_notif_value(optee->smc.invoke_fn,
> -					      &value_valid, &value_pending);
> +		value =3D get_async_notif_value(optee->smc.invoke_fn, &value_valid, &val=
ue_pending);
>  		if (!value_valid)
>  			break;
> =20
>  		if (value =3D=3D OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF)
>  			do_bottom_half =3D true;
> +		else if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF &&
> +			 value =3D=3D OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT)
> +			handle_optee_it(optee);

NAK. This isn't how we deal with chained interrupts. Definitely not in
an interrupt handler.

	M.

--=20
Without deviation from the norm, progress is not possible.

--===============8064708409944286446==--

