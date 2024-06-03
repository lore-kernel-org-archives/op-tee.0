From: Rob Herring <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RESEND PATCH v5 3/7] dt-bindings: remoteproc: Add processor
 identifier property
Date: Mon, 03 Jun 2024 09:35:53 -0500
Message-ID: <20240603143553.GA391578-robh@kernel.org>
In-Reply-To: <20240521122458.3517054-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7686208884825001749=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7686208884825001749==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 02:24:54PM +0200, Arnaud Pouliquen wrote:
> Add the "st,proc-id" property allowing to identify the remote processor.
> This ID is used to define an unique ID, common between Linux, U-boot and
> OP-TEE to identify a coprocessor.
> This ID will be used in request to OP-TEE remoteproc Trusted Application
> to specify the remote processor.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  .../devicetree/bindings/remoteproc/st,stm32-rproc.yaml     | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.ya=
ml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> index 36ea54016b76..409123cd4667 100644
> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> @@ -48,6 +48,10 @@ properties:
>            - description: The offset of the hold boot setting register
>            - description: The field mask of the hold boot
> =20
> +  st,proc-id:
> +    description: remote processor identifier
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>    st,syscfg-tz:
>      deprecated: true
>      description:
> @@ -182,6 +186,8 @@ allOf:
>          st,syscfg-holdboot: false
>          reset-names: false
>          resets: false
> +      required:
> +        - st,proc-id

New required properties are an ABI break. If that is okay, explain why=20
in the commit message.

> =20
>  additionalProperties: false
> =20
> @@ -220,6 +226,7 @@ examples:
>        reg =3D <0x10000000 0x40000>,
>              <0x30000000 0x40000>,
>              <0x38000000 0x10000>;
> +      st,proc-id =3D <0>;
>        st,syscfg-rsc-tbl =3D <&tamp 0x144 0xFFFFFFFF>;
>        st,syscfg-m4-state =3D <&tamp 0x148 0xFFFFFFFF>;
>      };
> --=20
> 2.25.1
>=20

--===============7686208884825001749==--

