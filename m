From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 2/6] dt-bindings: arm: optee: add interrupt property
Date: Wed, 13 Oct 2021 12:38:33 +0530
Message-ID: 
 <CAFA6WYN0ke7YbbJZjA9Hnvy_xSMUg27Y-SOziF1Gjgng+DeZ0Q@mail.gmail.com>
In-Reply-To: <20211006071546.2540920-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3724290000972101269=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3724290000972101269==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Oct 2021 at 12:45, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> Adds an optional interrupt property to the optee binding.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Apart from minor nit below:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz=
.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index c24047c1fdd5..40c9f1901e3f 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -24,6 +24,12 @@ properties:
>    compatible:
>      const: linaro,optee-tz
>
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

nit: It would be better to use macros here:

 +            interrupts =3D <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;

-Sumit

>          };
>      };
>
> --
> 2.31.1
>

--===============3724290000972101269==--

