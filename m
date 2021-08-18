From: Marc Zyngier <maz@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 2/6] dt-bindings: arm: optee: add interrupt property
Date: Wed, 18 Aug 2021 19:24:20 +0100
Message-ID: <87a6lesjaj.wl-maz@kernel.org>
In-Reply-To: <20210818101849.602257-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0840094727765277966=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0840094727765277966==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Aug 2021 11:18:45 +0100,
Jens Wiklander <jens.wiklander@linaro.org> wrote:
>=20
> Adds an optional interrupt property to the optee binding.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz=
.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index c24047c1fdd5..40c9f1901e3f 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -24,6 +24,12 @@ properties:
>    compatible:
>      const: linaro,optee-tz
> =20
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      This interrupt which is used to signal an event by the secure world
> +      software is expected to be edge-triggered.
> +
>    method:
>      enum: [smc, hvc]
>      description: |
> @@ -46,6 +52,7 @@ examples:
>          optee  {
>              compatible =3D "linaro,optee-tz";
>              method =3D "smc";
> +            interrupts =3D <0 187 1>;
>          };
>      };
> =20

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

--=20
Without deviation from the norm, progress is not possible.

--===============0840094727765277966==--

