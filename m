From: Marc Zyngier <maz@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 3/3] optee core: add irq chip using optee async notification
Date: Sun, 15 Jan 2023 10:13:35 +0000
Message-ID: <87fsccds1c.wl-maz@kernel.org>
In-Reply-To: <
 <CAN5uoS-Q5ePtNcJ2-8BBV+rxUK6xcbU1ywtcRfYf=sRbWShNpg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0000983694113604528=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0000983694113604528==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jan 2023 15:27:22 +0000,
Etienne Carriere <etienne.carriere@linaro.org> wrote:
>=20
> Hello Marc,
>=20
> Thanks for the review.
>=20
>=20
> On Fri, 13 Jan 2023 at 10:22, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Thu, 12 Jan 2023 14:54:24 +0000,
> > Etienne Carriere <etienne.carriere@linaro.org> wrote:
> > >
> > > Adds an irq chip in optee driver to generate interrupts from OP-TEE
> > > notified interrupt events based on optee async notification. Upon such
> > > notification, optee driver invokes OP-TEE to query a pending interrupt
> > > event. If an interrupt notification is pending the invocation return
> > > OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT and optee driver can get the pending
> > > interrupt number with SMC function ID OPTEE_SMC_FUNCID_GET_IT_VALUE.
> > >
> > > SMC function ID OPTEE_SMC_FUNCID_SET_IT_MASK allows Linux to mask/unmask
> > > an interrupt notification services.
> > >
> > > The optee irq_chip if flagged IRQCHIP_SKIP_SET_WAKE to skip set_wake
> > > as optee interrupt notifications doesn't support the set_wake option.
> > > In case a device is using the optee irq and is marked as wakeup source,
> > > this result in an "Unbalanced IRQ xx wake disable" backtrace, since:
> > > - in irq_set_irq_wake(ON), wake_depth gets incremented, then reset due =
to
> > >   set_irq_wake_real() returns an error (irq_set_wake() isn't implemente=
d)
> > > - in irq_set_irq_wake(OFF), wake_depth is always 0, hence the warning
> >
> > Is this relevant information?
>=20
> The description is maybe too specific to the setup used for this feature.
> I'll rephrase that, unless IRQCHIP_SKIP_SET_WAKE flag is not relevant here.

IRQCHIP_SKIP_SET_FLAG is used when the irqchip doesn't provide any
wake-up mechanism, but also isn't *denying* its use (there is a
separate way to wake up from such an interrupt). I don't think you
need to document that something goes wrong when you're doing something
wrong.

> >
> > >
> > > Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> > > Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> > > Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > >  drivers/tee/optee/optee_private.h |   2 +
> > >  drivers/tee/optee/optee_smc.h     |  78 +++++++++++++++-
> > >  drivers/tee/optee/smc_abi.c       | 142 ++++++++++++++++++++++++++++--
> > >  3 files changed, 216 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > > index e5bd3548691f..2a146d884d27 100644
> > > --- a/drivers/tee/optee/optee_private.h
> > > +++ b/drivers/tee/optee/optee_private.h
> > > @@ -112,6 +112,7 @@ struct optee_pcpu {
> > >   * @optee_pcpu               per_cpu optee instance for per cpu work o=
r NULL
> > >   * @notif_pcpu_wq    workqueue for per cpu aynchronous notification or=
 NULL
> > >   * @notif_pcpu_work  work for per cpu asynchronous notification
> > > + * @domain           interrupt domain registered by OP-TEE driver
> > >   */
> > >  struct optee_smc {
> > >       optee_invoke_fn *invoke_fn;
> > > @@ -121,6 +122,7 @@ struct optee_smc {
> > >       struct optee_pcpu __percpu *optee_pcpu;
> > >       struct workqueue_struct *notif_pcpu_wq;
> > >       struct work_struct notif_pcpu_work;
> > > +     struct irq_domain *domain;
> > >  };
> > >
> > >  /**
> > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_sm=
c.h
> > > index 73b5e7760d10..0cf83d5a2931 100644
> > > --- a/drivers/tee/optee/optee_smc.h
> > > +++ b/drivers/tee/optee/optee_smc.h
> > > @@ -226,7 +226,8 @@ struct optee_smc_get_shm_config_result {
> > >   * a3        Bit[7:0]: Number of parameters needed for RPC to be suppl=
ied
> > >   *             as the second MSG arg struct for
> > >   *             OPTEE_SMC_CALL_WITH_ARG
> > > - *   Bit[31:8]: Reserved (MBZ)
> > > + *   Bit[23:8]: The maximum interrupt event notification number
> > > + *   Bit[31:24]: Reserved (MBZ)
> > >   * a4-7      Preserved
> > >   *
> > >   * Error return register usage:
> > > @@ -254,6 +255,11 @@ struct optee_smc_get_shm_config_result {
> > >  #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF                BIT(5)
> > >  /* Secure world supports pre-allocating RPC arg struct */
> > >  #define OPTEE_SMC_SEC_CAP_RPC_ARG            BIT(6)
> > > +/* Secure world supports interrupt events notification to normal world=
 */
> > > +#define OPTEE_SMC_SEC_CAP_IT_NOTIF           BIT(7)
> > > +
> > > +#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_MASK  GENMASK(23, 8)
> > > +#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_SHIFT 8
> > >
> > >  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES       9
> > >  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> > > @@ -416,6 +422,12 @@ struct optee_smc_disable_shm_cache_result {
> > >   */
> > >  #define OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF   0
> > >
> > > +/*
> > > + * Notification that OP-TEE triggers an interrupt event to Linux kernel
> > > + * for an interrupt consumer.
> > > + */
> > > +#define OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT            1
> > > +
> > >  #define OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE       17
> > >  #define OPTEE_SMC_GET_ASYNC_NOTIF_VALUE \
> > >       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE)
> > > @@ -426,6 +438,70 @@ struct optee_smc_disable_shm_cache_result {
> > >  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
> > >  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG  19
> > >
> > > +/*
> > > + * Retrieve the interrupt number of the pending interrupt event notifi=
ed to
> > > + * non-secure world since the last call of this function.
> > > + *
> > > + * OP-TEE keeps a record of all posted interrupt notification events. =
When the
> > > + * async notif interrupt is received by non-secure world, this functio=
n should
> > > + * be called until all pended interrupt events have been retrieved. Wh=
en an
> > > + * interrupt event is retrieved it is cleared from the record in secur=
e world.
> > > + *
> > > + * It is expected that this function is called from an interrupt handl=
er
> > > + * in normal world.
> > > + *
> > > + * Call requests usage:
> > > + * a0        SMC Function ID, OPTEE_SMC_GET_IT_NOTIF_VALUE
> > > + * a1-6      Not used
> > > + * a7        Hypervisor Client ID register
> > > + *
> > > + * Normal return register usage:
> > > + * a0        OPTEE_SMC_RETURN_OK
> > > + * a1        IT_NOTIF interrupt identifier value
> > > + * a2        Bit[0]: OPTEE_SMC_IT_NOTIF_VALID if the value in a1 is
> > > + *           valid, else 0 if no interrupt event were pending
> > > + * a2        Bit[1]: OPTEE_SMC_IT_NOTIF_PENDING if another interrupt e=
vent
> > > + *           value is pending, else 0.
> > > + *   Bit[31:2]: MBZ
> > > + * a3-7      Preserved
> > > + *
> > > + * Not supported return register usage:
> > > + * a0        OPTEE_SMC_RETURN_ENOTAVAIL
> > > + * a1-7      Preserved
> > > + */
> > > +#define OPTEE_SMC_IT_NOTIF_VALID             BIT(0)
> > > +#define OPTEE_SMC_IT_NOTIF_PENDING           BIT(1)
> > > +
> > > +#define OPTEE_SMC_FUNCID_GET_IT_NOTIF_VALUE  20
> > > +#define OPTEE_SMC_GET_IT_NOTIF_VALUE \
> > > +     OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_IT_NOTIF_VALUE)
> > > +
> > > +/*
> > > + * Mask or unmask an interrupt notification event.
> > > + *
> > > + * It is expected that this function is called from an interrupt handl=
er
> > > + * in normal world.
> > > + *
> > > + * Call requests usage:
> > > + * a0        SMC Function ID, OPTEE_SMC_SET_IT_NOTIF_MASK
> > > + * a1        Interrupt identifier value
> > > + * a2        Bit[0]: 1 if interrupt event is to be masked, 0 if it is =
to be unmasked
> > > + * a2   Bit[31:1] MBZ
> > > + * a3-6      Not used
> > > + * a7        Hypervisor Client ID register
> > > + *
> > > + * Normal return register usage:
> > > + * a0        OPTEE_SMC_RETURN_OK
> > > + * a1-7      Preserved
> > > + *
> > > + * Not supdealed ported return register usage:
> > > + * a0        OPTEE_SMC_RETURN_ENOTAVAIL
> > > + * a1-7      Preserved
> > > + */
> > > +#define OPTEE_SMC_FUNCID_SET_IT_NOTIF_MASK   21
> > > +#define OPTEE_SMC_SET_IT_NOTIF_MASK \
> > > +     OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_SET_IT_NOTIF_MASK)
> > > +
> > >  /*
> > >   * Resume from RPC (for example after processing a foreign interrupt)
> > >   *
> > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > > index 8c2d58d605ac..0360afde119f 100644
> > > --- a/drivers/tee/optee/smc_abi.c
> > > +++ b/drivers/tee/optee/smc_abi.c
> > > @@ -977,6 +977,112 @@ static int optee_smc_stop_async_notif(struct tee_=
context *ctx)
> > >   * 5. Asynchronous notification
> > >   */
> > >
> > > +static u32 get_it_value(optee_invoke_fn *invoke_fn, bool *value_valid,
> > > +                     bool *value_pending)
> >
> > What value? If this is supposed to return a set of pending bits, just
> > name the function to reflect that.
>=20
> Communication between Linux kernel and OP-TEE is this case is rather
> basic here, no shared memory used, only few CPU registers can be used
> to shared information. So Linux invokes OP-TEE for each pending optee
> interrupt event: each invocation returns a interrupt event number (an
> integer value) and a status whether another interrupt event is pending
> and shall be retrieved invoking OP-TEE again. In case Linux invoke
> OP-TEE for a pending interrupt and none is pending, a last status is
> also provided: 'value_valid'.
>=20
> I could maybe change the prototype to something like:
> static u32 get_pending_it_number(optee_invoke_fn *invoke_fn, bool
> *it_number_valid, bool *more_pending_it)

What does 'it' mean? Interrupt? Spell it out. Really, this should read as:

	get_pending_irq()


>=20
> >
> > Also, at no point do you explain that each PPI is only a mux interrupt
> > for a bunch of chained interrupts.
>=20
> Sorry, I don't understand your question.
> The "it notif" feature proposed in this change is not straight related a PP=
I.
> Previous patch in this series is indeed related to PPI: it propose
> optee driver can use a single PPI instead of a signle SPI for the
> OP-TEE "asyn notification" feature.
> This change allows to mux interrupts events (from OP-TEE to Linux
> optee driver) over "OP-TEE async notif" means, which is using a single
> SPI or PPI.
> Maybe I should have submitted both changes separately :(

Surely a less cryptic explaination would have helped.

>=20
> >
> > > +{
> > > +     struct arm_smccc_res res;
> > > +
> > > +     invoke_fn(OPTEE_SMC_GET_IT_NOTIF_VALUE, 0, 0, 0, 0, 0, 0, 0, &res=
);
> > > +
> > > +     if (res.a0)
> > > +             return 0;
> > > +
> > > +     *value_valid =3D res.a2 & OPTEE_SMC_IT_NOTIF_VALID;
> > > +     *value_pending =3D res.a2 & OPTEE_SMC_IT_NOTIF_PENDING;
> > > +     return res.a1;
> > > +}
> > > +
> > > +static u32 set_it_mask(optee_invoke_fn *invoke_fn, u32 it_value, bool =
mask)
> > > +{
> > > +     struct arm_smccc_res res;
> > > +
> > > +     invoke_fn(OPTEE_SMC_SET_IT_NOTIF_MASK, it_value, mask, 0, 0, 0, 0=
, 0, &res);
> > > +
> > > +     if (res.a0)
> > > +             return 0;
> > > +
> > > +     return res.a1;
> > > +}
> > > +
> > > +static int handle_optee_it(struct optee *optee)
> > > +{
> > > +     bool value_valid;
> > > +     bool value_pending;
> > > +     u32 it;
> > > +
> > > +     do {
> > > +             struct irq_desc *desc;
> > > +
> > > +             it =3D get_it_value(optee->smc.invoke_fn, &value_valid, &=
value_pending);
> > > +             if (!value_valid)
> > > +                     break;
> > > +
> > > +             desc =3D irq_to_desc(irq_find_mapping(optee->smc.domain, =
it));
> > > +             if (!desc) {
> > > +                     pr_err("no desc for optee IT:%d\n", it);
> > > +                     return -EIO;
> > > +             }
> > > +
> > > +             handle_simple_irq(desc);
> > > +
> >
> > What is this? Please use generic_handle_domain_irq(), like any other
> > driver. Why is the flow handler handle_simple_irq()? You need to
> > explain what the signalling is for the secure-provided interrupts.
>=20
> My fault. I thought handle_simple_irq() would better apply here since
> its description:
>  * Simple interrupts are either sent from a demultiplexing interrupt
>  * handler or come from hardware, where no interrupt hardware control
>  * is necessary.

Why isn't masking necessary? What is the signalling between OPTEE and
NS? Does the "get_it_value" function *consume* the pending bits? You
need to answer and document all of that, and only then pick the flow
that matches these requirements.

>=20
> OP-TEE secure world has already dealt with the HW interrupt resources
> (ack/etc...) before it notifies Linux kernel of the event.
>=20
> >
> > > +     } while (value_pending);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void optee_it_irq_mask(struct irq_data *d)
> > > +{
> > > +     struct optee *optee =3D d->domain->host_data;
> > > +
> > > +     set_it_mask(optee->smc.invoke_fn, d->hwirq, true);
> > > +}
> > > +
> > > +static void optee_it_irq_unmask(struct irq_data *d)
> > > +{
> > > +     struct optee *optee =3D d->domain->host_data;
> > > +
> > > +     set_it_mask(optee->smc.invoke_fn, d->hwirq, false);
> > > +}
> > > +
> > > +static struct irq_chip optee_it_irq_chip =3D {
> > > +     .name =3D "optee-it",
> > > +     .irq_disable =3D optee_it_irq_mask,
> > > +     .irq_enable =3D optee_it_irq_unmask,
> > > +     .flags =3D IRQCHIP_SKIP_SET_WAKE,
> >
> > Is it a mask or a disable? These are different beasts.
>=20
> Indeed, thanks for catching that. I think we need to 4
> (enable/disable/mask/unmask).
> I'll fix.

What does enable do differently from unmask?

>=20
> >
> > > +};
> > > +
> > > +static int optee_it_alloc(struct irq_domain *d, unsigned int virq,
> > > +                       unsigned int nr_irqs, void *data)
> > > +{
> > > +     struct irq_fwspec *fwspec =3D data;
> > > +     irq_hw_number_t hwirq;
> > > +
> > > +     hwirq =3D fwspec->param[0];
> > > +
> > > +     irq_domain_set_hwirq_and_chip(d, virq, hwirq, &optee_it_irq_chip,=
 d->host_data);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct irq_domain_ops optee_it_irq_domain_ops =3D {
> > > +     .alloc =3D optee_it_alloc,
> > > +     .free =3D irq_domain_free_irqs_common,
> > > +};
> > > +
> > > +static int optee_irq_domain_init(struct platform_device *pdev, struct =
optee *optee, u_int max_it)
> > > +{
> > > +     struct device *dev =3D &pdev->dev;
> > > +     struct device_node *np =3D dev->of_node;
> > > +
> > > +     optee->smc.domain =3D irq_domain_add_linear(np, max_it, &optee_it=
_irq_domain_ops, optee);
> > > +     if (!optee->smc.domain) {
> > > +             dev_err(dev, "Unable to add irq domain\n");
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *val=
ue_valid,
> > >                                bool *value_pending)
> > >  {
> > > @@ -1008,13 +1114,15 @@ static irqreturn_t notif_irq_handler(int irq, v=
oid *dev_id)
> > >       }
> > >
> > >       do {
> > > -             value =3D get_async_notif_value(optee->smc.invoke_fn,
> > > -                                           &value_valid, &value_pendin=
g);
> > > +             value =3D get_async_notif_value(optee->smc.invoke_fn, &va=
lue_valid, &value_pending);
> > >               if (!value_valid)
> > >                       break;
> > >
> > >               if (value =3D=3D OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HA=
LF)
> > >                       do_bottom_half =3D true;
> > > +             else if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF=
 &&
> > > +                      value =3D=3D OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT)
> > > +                     handle_optee_it(optee);
> >
> > NAK. This isn't how we deal with chained interrupts. Definitely not in
> > an interrupt handler.
>=20
> My apologies, what is wrong in this sequence. My expectations are:
> 1- Something happens on OP-TEE secure side that should be reported to
> Linux as a software interrupt event

Why? There is nothing Linux-specific in OPTEE. Why should OPTEE be
prescriptive of the way this is handled?

> 2- OP-TEE (secure world) raises an HW interrupt to notify Linux optee
> driver that event(s) are pending
> 3- optee driver threade_irq handler is called and asks OP-TEE which
> are the pending events. This is done event per event until all pending
> event are consumed.

Why is this done in a thread? I'd expect the *handlers* to be
threaded, but not the irqchip part of it (which is crucially missing
here).

	M.

--=20
Without deviation from the norm, progress is not possible.

--===============0000983694113604528==--

