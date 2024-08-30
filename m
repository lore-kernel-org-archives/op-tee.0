From: Krzysztof Kozlowski <krzk@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 3/4] dt-bindings: reserved-memory: add linaro,restricted-heap
Date: Fri, 30 Aug 2024 10:20:17 +0200
Message-ID: <3bqb6mktkvbdl6h4eekad4mpjhyvzx7mjidhnanboygbwu2asz@6ros56bp6isd>
In-Reply-To: <20240830070351.2855919-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8025579772959058814=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8025579772959058814==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 09:03:50AM +0200, Jens Wiklander wrote:
> From: Olivier Masse <olivier.masse@nxp.com>
>=20
> DMABUF reserved memory definition for OP-TEE secure data path feature.
>=20
> Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../linaro,restricted-heap.yaml               | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/linar=
o,restricted-heap.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/reserved-memory/linaro,restr=
icted-heap.yaml b/Documentation/devicetree/bindings/reserved-memory/linaro,re=
stricted-heap.yaml
> new file mode 100644
> index 000000000000..0ab87cf02775
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/linaro,restricted-h=
eap.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/linaro,restricted-heap.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linaro Secure DMABUF Heap
> +
> +maintainers:
> +  - Olivier Masse <olivier.masse@nxp.com>
> +
> +description:
> +  Linaro OP-TEE firmware needs a reserved memory for the
> +  Secure Data Path feature (aka SDP).
> +  The purpose is to provide a restricted memory heap which allow
> +  the normal world OS (REE) to allocate/free restricted buffers.
> +  The TEE is reponsible for protecting the SDP memory buffers.
> +  TEE Trusted Application can access restricted memory references
> +  provided as parameters (DMABUF file descriptor).

And what is the difference from regular reserved memory? Why it cannot
be used?

> +
> +allOf:
> +  - $ref: "reserved-memory.yaml"

It does not look like you tested the bindings, at least after quick
look. Please run  (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> +
> +properties:
> +  compatible:
> +    const: linaro,restricted-heap
> +
> +  reg:
> +    description:
> +      Region of memory reserved for OP-TEE SDP feature
> +
> +  no-map:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Avoid creating a virtual mapping of the region as part of the OS'
> +      standard mapping of system memory.
> +
> +unevaluatedProperties: false

This goes after "required:" block.

> +
> +required:
> +  - compatible
> +  - reg
> +  - no-map
> +
> +examples:
> +  - |
> +  reserved-memory {
> +    #address-cells =3D <2>;
> +    #size-cells =3D <2>;
> +
> +    sdp(a)3e800000 {
> +      compatible =3D "linaro,restricted-heap";
> +      no-map;
> +      reg =3D <0 0x3E800000 0 0x00400000>;

lowercase hex

Best regards,
Krzysztof


--===============8025579772959058814==--

