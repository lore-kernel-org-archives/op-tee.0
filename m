From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 2/3] dt-bindings: arm: optee: add interrupt controller properties
Date: Tue, 17 Jan 2023 03:19:09 +0100
Message-ID: 
 <CAN5uoS9MrKXUrmR1Y=c9J8D03muBKPJcQk64YFHwOwBO_GX5jw@mail.gmail.com>
In-Reply-To: <20230113204231.GA2873887-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2862198473165461921=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2862198473165461921==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jan 2023 at 21:42, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jan 12, 2023 at 03:54:23PM +0100, Etienne Carriere wrote:
> > Adds optional interrupt controller properties used when OP-TEE generates
> > interrupt events optee driver shall notified to its registered
> > interrupt consumer. The example shows how OP-TEE can trigger a wakeup
> > interrupt event consumed by a gpio-keys compatible device.
>
> Why do we need this in DT? It's not a GPIO key, but an abuse of the
> binding. It looks like unnecessary abstraction to me.

This is when for example OP-TEE world controller a IOs controller
device. When some IOs are relate to OP-TEE feature, the controller
route to OP-TEE handler.
When the IO detection relates to Linux irqs it is routed to Linux,
using optee driver irqchip.
As Linux uses DT for device drivers to get their interrupt (controler
phandle + arg), defining the irqchip in the DT of the platform running
that OP-TEE firmware make sense to me.

The same way OP-TEE can be in charge of the wakeup source controllers
and notify Linxu of event for the wakeup that relate to Linux
services.

>
>
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> >  .../arm/firmware/linaro,optee-tz.yaml         | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-=
tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > index d4dc0749f9fd..42874ca21b7e 100644
> > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > @@ -40,6 +40,11 @@ properties:
> >        HVC #0, register assignments
> >        register assignments are specified in drivers/tee/optee/optee_smc.h
> >
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
> >  required:
> >    - compatible
> >    - method
> > @@ -48,12 +53,24 @@ additionalProperties: false
> >
> >  examples:
> >    - |
> > +    #include <dt-bindings/input/input.h>
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> >      firmware  {
> > -        optee  {
> > +        optee: optee {
> >              compatible =3D "linaro,optee-tz";
> >              method =3D "smc";
> >              interrupts =3D <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> > +            interrupt-controller;
> > +            #interrupt-cells =3D <1>;
> > +        };
> > +    };
> > +
> > +    wake_up {
> > +        compatible =3D "gpio-keys";
> > +
> > +        button {
> > +            linux,code =3D <KEY_WAKEUP>;
> > +            interrupts-extended =3D <&optee 0>;
>
> In the end, you just need optee IRQ #0 to generate KEY_WAKEUP. Does
> either the optee interrupt number or the key code need to be
> configurable? If so, why? Why isn't #0 just wakeup and the driver can
> send KEY_WAKEUP?

The OP-TEE driver is a generic firmware driver. Platforms do not have
specific hooks in it.
A generic DT definition of the irqs exposed by opte driver irqchip
allows consumers to get their irq resource.
I even think 'allows' above could be replaced by is-required-by.

Here, binding KEY_WAKEUP to the OP-TEE firmware related irq line from
the platform DT reuses existing drivers and bindings to get a irq
wkaeup source, signaling KEY_WAKEUP even, when wakeup stouce
controller is assigned to (controller by) OP-TEE world.
This is an example. Maybe the binding are miss used, but I don't see
why. Another example I plan to post is building an mailbox for SMCI
notification from a SCMI service host in OP-TEE. OP-TEE would use this
optee irqchip to get the interrupt related to the SCMI notification
channel. In embedded system, limited resources can be shared by
subsystems.

>
> DT is for non-discoverable hardware that we can't fix. Why repeat that
> for software interfaces to firmware?

Do you mean the optee driver should enumerate the interrupt lines
exposed by OP-TEE and register each line accordingly?
This is doable I guess. But that would not prevent Linux kernel DT to
define a interrupt controller consumer device nodes can refer to for
their need.

BR,
Etienne

>
> Rob

--===============2862198473165461921==--

