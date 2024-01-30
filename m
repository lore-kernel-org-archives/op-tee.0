From: Rob Herring <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 2/4] dt-bindings: remoteproc: Add compatibility for TEE support
Date: Tue, 30 Jan 2024 11:51:12 -0600
Message-ID: <20240130175112.GA2040002-robh@kernel.org>
In-Reply-To: <20240118100433.3984196-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2168429655267008681=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2168429655267008681==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:04:31AM +0100, Arnaud Pouliquen wrote:
> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
> (TEE).
> For instance, this compatible is used in both the Linux and OP-TEE
> device-tree:
> - In OP-TEE, a node is defined in the device tree with the
>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>   the firmware.
> - On Linux, when the compatibility is set, the Cortex-M resets should not
>   be declared in the device tree.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> V1 to V2 updates
> - update "st,stm32mp1-m4" compatible description to generalize
> - remove the 'reset-names' requirement in one conditional branch, as the
>   property is already part of the condition test.
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 52 +++++++++++++++----
>  1 file changed, 43 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.ya=
ml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> index 370af61d8f28..6af821b15736 100644
> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> @@ -16,7 +16,12 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: st,stm32mp1-m4
> +    enum:
> +      - st,stm32mp1-m4
> +      - st,stm32mp1-m4-tee
> +    description:
> +      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by non=
-secure context
> +      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by=
 secure context
> =20
>    reg:
>      description:
> @@ -142,21 +147,40 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - resets
> =20
>  allOf:
>    - if:
>        properties:
> -        reset-names:
> -          not:
> -            contains:
> -              const: hold_boot
> +        compatible:
> +          contains:
> +            const: st,stm32mp1-m4
> +    then:
> +      if:
> +        properties:
> +          reset-names:
> +            not:
> +              contains:
> +                const: hold_boot

Note that this is true when 'reset-names' is not present. If that is not=20
desired, then you need 'required: [reset-names]'. Not really a new issue=20
though.

> +      then:
> +        required:
> +          - st,syscfg-holdboot
> +          - resets
> +      else:
> +        properties:
> +          st,syscfg-holdboot: false
> +        required:
> +          - resets

'resets' is always required within the outer 'then' schema, so you can=20
move this up a level.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp1-m4-tee
>      then:
> -      required:
> -        - st,syscfg-holdboot
> -    else:
>        properties:
>          st,syscfg-holdboot: false
> +        reset-names: false
> +        resets: false
> =20
>  additionalProperties: false
> =20
> @@ -188,5 +212,15 @@ examples:
>        st,syscfg-rsc-tbl =3D <&tamp 0x144 0xFFFFFFFF>;
>        st,syscfg-m4-state =3D <&tamp 0x148 0xFFFFFFFF>;
>      };
> +  - |
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    m4(a)10000000 {
> +      compatible =3D "st,stm32mp1-m4-tee";
> +      reg =3D <0x10000000 0x40000>,
> +            <0x30000000 0x40000>,
> +            <0x38000000 0x10000>;
> +      st,syscfg-rsc-tbl =3D <&tamp 0x144 0xFFFFFFFF>;
> +      st,syscfg-m4-state =3D <&tamp 0x148 0xFFFFFFFF>;
> +    };
> =20
>  ...
> --=20
> 2.25.1
>=20

--===============2168429655267008681==--

