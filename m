From: Rob Herring <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 2/3] dt-bindings: arm: optee: add interrupt controller properties
Date: Fri, 13 Jan 2023 14:42:31 -0600
Message-ID: <20230113204231.GA2873887-robh@kernel.org>
In-Reply-To: <20230112145424.3791276-3-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8907838357457725143=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8907838357457725143==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 03:54:23PM +0100, Etienne Carriere wrote:
> Adds optional interrupt controller properties used when OP-TEE generates
> interrupt events optee driver shall notified to its registered
> interrupt consumer. The example shows how OP-TEE can trigger a wakeup
> interrupt event consumed by a gpio-keys compatible device.

Why do we need this in DT? It's not a GPIO key, but an abuse of the=20
binding. It looks like unnecessary abstraction to me.


>=20
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  .../arm/firmware/linaro,optee-tz.yaml         | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz=
.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index d4dc0749f9fd..42874ca21b7e 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -40,6 +40,11 @@ properties:
>        HVC #0, register assignments
>        register assignments are specified in drivers/tee/optee/optee_smc.h
> =20
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +
>  required:
>    - compatible
>    - method
> @@ -48,12 +53,24 @@ additionalProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/input/input.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      firmware  {
> -        optee  {
> +        optee: optee {
>              compatible =3D "linaro,optee-tz";
>              method =3D "smc";
>              interrupts =3D <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-controller;
> +            #interrupt-cells =3D <1>;
> +        };
> +    };
> +
> +    wake_up {
> +        compatible =3D "gpio-keys";
> +
> +        button {
> +            linux,code =3D <KEY_WAKEUP>;
> +            interrupts-extended =3D <&optee 0>;

In the end, you just need optee IRQ #0 to generate KEY_WAKEUP. Does=20
either the optee interrupt number or the key code need to be=20
configurable? If so, why? Why isn't #0 just wakeup and the driver can=20
send KEY_WAKEUP?

DT is for non-discoverable hardware that we can't fix. Why repeat that=20
for software interfaces to firmware?

Rob

--===============8907838357457725143==--

