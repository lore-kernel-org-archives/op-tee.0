From: Krzysztof Kozlowski <krzk@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 07/10] dt-bindings: arm: qcomtee: add QTEE driver
 devicetree binding for TEE subsystem
Date: Tue, 03 Dec 2024 08:55:05 +0100
Message-ID: <ccaff25d-d757-4b0a-851b-8f6c2dd9fb4b@kernel.org>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?7-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4926484285958707811=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4926484285958707811==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/12/2024 05:19, Amirreza Zarrabi wrote:
> Introduce qcom,tee compatible string.

Why? What is it for? You have entire commit msg for this, instead of
repeating subject.

A nit, subject: drop second/last, redundant "devicetree binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bin=
dings/submitting-patches.rst#L18

Also drop driver, bindings are not for drivers.

>=20
> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> ---
>  .../devicetree/bindings/arm/firmware/qcom,tee.yaml | 34 ++++++++++++++++++=
++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/firmware/qcom,tee.yaml b=
/Documentation/devicetree/bindings/arm/firmware/qcom,tee.yaml
> new file mode 100644
> index 000000000000..43b7e8ac944e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/firmware/qcom,tee.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/firmware/qcom,tee.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm TEE
> +
> +maintainers:
> +  - Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  QTEE is a piece of software provide a Trusted Execution Environment usin=
g ARM
> +  TrustZone for Qualcomm SoC.
> +
> +properties:
> +  $nodename:
> +    const: qcom_tee

No, first it is not correct (see coding style), second is not even
needed. Drop.

> +
> +  compatible:
> +    const: qcom,tee

One, same interface for all devices? Nothing SoC specific? You are
making now a contract, so please carefully analyze it internally what it
means.

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {

Drop

> +        qcom_tee {

See DTS coding style.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree=
-basics.html#generic-names-recommendation


> +            compatible =3D "qcom,tee";

No resources? Nothing here? What is the point except of instantiating
your driver?

> +        };
> +    };
>=20


Best regards,
Krzysztof

--===============4926484285958707811==--

