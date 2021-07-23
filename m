From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 2/6] dt-bindings: arm: optee: add interrupt property
Date: Fri, 23 Jul 2021 11:44:18 +0200
Message-ID: <20210723094422.2150313-3-jens.wiklander@linaro.org>
In-Reply-To: <20210723094422.2150313-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1382540168624421035=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1382540168624421035==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds an optional interrupt property to the optee binding.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.y=
aml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index c24047c1fdd5..73811a5d1714 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -24,6 +24,9 @@ properties:
   compatible:
     const: linaro,optee-tz
=20
+  interrupts:
+    maxItems: 1
+
   method:
     enum: [smc, hvc]
     description: |
@@ -46,6 +49,7 @@ examples:
         optee  {
             compatible =3D "linaro,optee-tz";
             method =3D "smc";
+            interrupts =3D <0 187 4>;
         };
     };
=20
--=20
2.31.1


--===============1382540168624421035==--

