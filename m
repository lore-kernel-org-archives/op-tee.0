From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v6 2/6] dt-bindings: arm: optee: add interrupt property
Date: Wed, 06 Oct 2021 09:15:42 +0200
Message-ID: <20211006071546.2540920-3-jens.wiklander@linaro.org>
In-Reply-To: <20211006071546.2540920-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1348409540754670093=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1348409540754670093==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds an optional interrupt property to the optee binding.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.y=
aml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index c24047c1fdd5..40c9f1901e3f 100644
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
@@ -46,6 +52,7 @@ examples:
         optee  {
             compatible =3D "linaro,optee-tz";
             method =3D "smc";
+            interrupts =3D <0 187 1>;
         };
     };
=20
--=20
2.31.1


--===============1348409540754670093==--

