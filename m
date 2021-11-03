From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v8 2/6] dt-bindings: arm: optee: add interrupt property
Date: Wed, 03 Nov 2021 10:02:51 +0100
Message-ID: <20211103090255.998070-3-jens.wiklander@linaro.org>
In-Reply-To: <20211103090255.998070-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1916451626702679195=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1916451626702679195==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds an optional interrupt property to the optee binding.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.y=
aml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index c24047c1fdd5..9a426110a14a 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -24,6 +24,12 @@ properties:
   compatible:
     const: linaro,optee-tz
=20
+  interrupts:
+    maxItems: 1
+    description: |
+      This interrupt which is used to signal an event by the secure world
+      software is expected to be edge-triggered.
+
   method:
     enum: [smc, hvc]
     description: |
@@ -42,10 +48,12 @@ additionalProperties: false
=20
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     firmware  {
         optee  {
             compatible =3D "linaro,optee-tz";
             method =3D "smc";
+            interrupts =3D <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
         };
     };
=20
--=20
2.31.1


--===============1916451626702679195==--

