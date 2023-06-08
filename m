From: Rob Herring <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: optee: add interrupt controller
 properties
Date: Thu, 08 Jun 2023 11:43:26 -0600
Message-ID: <20230608174326.GA2791381-robh@kernel.org>
In-Reply-To: <20230506073235.2770292-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4703755535229964515=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4703755535229964515==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+Sudeep, again...

Sudeep, you may want to look at v2 again.

On Sat, May 06, 2023 at 09:32:34AM +0200, Etienne Carriere wrote:
> Adds an optional interrupt controller property to optee firmware node
> in the DT bindings. Optee driver may embeds an irqchip exposing
> OP-TEE interrupt events notified by the TEE world. Optee registers up

optee, Optee, or OP-TEE?

> to 1 interrupt controller and identifies each line with a line
> number from 0 to UINT16_MAX.
>=20
> The identifiers and meaning of the interrupt line number are specific
> to the platform and shall be found in the OP-TEE platform documentation.

Why can't you standardize the interrupt numbering for standard events=20
like SCMI?


I think there's still concern as to why this can't all be discoverable.=20
The Optee driver should know or discover from Optee that it is an=20
interrupt controller and can register itself as such. Likewise, the=20
SCMI driver knows for scmi-optee, the interrupt comes from the Optee=20
node. It can find that node (by compatible) and then find the=20
irqchip/domain provider for that node.

OTOH, SCMI already supports interrupts in the binding, so this isn't=20
too big of a deal. I'm more concerned that once you have Optee=20
interrupts, then you are going to want a node for every Optee=20
sub-function with an interrupt. Then we're back to the very first Optee=20
binding with a child node for every sub-function. Using it for gpio-keys=20
as you did in the first version for example.

If Sudeep is okay with this from an SCMI perspective and Marc is from an=20
irqchip perspective, then I'm okay with it too.

> In the example shown in optee DT binding documentation, the platform SCMI
> device controlled by Linux scmi driver uses optee interrupt irq 5 as
> signal to trigger processing of an asynchronous incoming SCMI message
> in the scope of a CPU DVFS control. A platform can have several SCMI
> channels driven this way. Optee irqs also permit small embedded devices
> to share e.g. a gpio expander, a group of wakeup sources, etc... between
> OP-TEE world (for sensitive services) and Linux world (for non-sensitive
> services). The physical controller is driven from the TEE which exposes
> some controls to Linux kernel.
>=20
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v4:
> - Removed empty line between Cc: tags and S-o-b tags.
>=20
> No changes since v3
>=20
> Changes since v2:
> - Added a sentence on optee irq line number values and meaning, in
>   DT binding doc and commit message.
> - Updated example in DT binding doc from comment, fixed misplaced
>   interrupt-parent property and removed gic and sram shm nodes.
>=20
> Changes since v1:
> - Added a description to #interrupt-cells property.
> - Changed of example. Linux wakeup event was subject to discussion and
>   i don't know much about input events in Linux. So move to SCMI.
>   In the example, an SCMI server in OP-TEE world raises optee irq 5
>   so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
>   SCMI message in the scmi device for liekly later processing in threaded
>   context. The example includes all parties: optee, scmi, sram, gic.
> - Obviously rephrased the commit message.
> ---
>  .../arm/firmware/linaro,optee-tz.yaml         | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz=
.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index 5d033570b57b..9d9a797a6b2f 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -41,6 +41,16 @@ properties:
>        HVC #0, register assignments
>        register assignments are specified in drivers/tee/optee/optee_smc.h
> =20
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +    description: |
> +      OP-TEE exposes irq for irp chip controllers from OP-TEE world. Each
> +      irq is assigned a single line number identifier used as first argume=
nt.
> +      Line number identifiers and their meaning shall be found in the OP-T=
EE
> +      firmware platform documentation.
> +
>  required:
>    - compatible
>    - method
> @@ -65,3 +75,31 @@ examples:
>              method =3D "hvc";
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    firmware  {
> +        optee: optee {
> +            compatible =3D "linaro,optee-tz";
> +            method =3D "smc";
> +            interrupt-parent =3D <&gic>;
> +            interrupts =3D <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-controller;
> +            #interrupt-cells =3D <1>;
> +        };
> +
> +        scmi {
> +            compatible =3D "linaro,scmi-optee";
> +            linaro,optee-channel-id =3D <0>;
> +            shmem =3D <&scmi_shm_tx>, <&scmi_shm_rx>;
> +            interrupts-extended =3D <&optee 5>;
> +            interrupt-names =3D "a2p";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            scmi_cpu_dvfs: protocol(a)13 {
> +                reg =3D <0x13>;
> +                #clock-cells =3D <1>;
> +            };
> +        };
> +    };
> --=20
> 2.25.1
>=20

--===============4703755535229964515==--

