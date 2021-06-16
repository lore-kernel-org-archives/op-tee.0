From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 3/7] dt-bindings: arm: optee: add interrupt property
Date: Wed, 16 Jun 2021 12:36:45 +0200
Message-ID: <20210616103649.2662395-4-jens.wiklander@linaro.org>
In-Reply-To: <20210616103649.2662395-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3963951860042423985=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3963951860042423985==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds an optional interrupt property to the optee binding.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.y=
aml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index c931b030057f..3efbe11b637d 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -24,6 +24,9 @@ properties:
             for the reference implementation maintained by Linaro.
           const: linaro,optee-tz
=20
+  interrupts:
+    maxItems: 1
+
   method:
     description: The method of calling the OP-TEE Trusted OS.
     $ref: /schemas/types.yaml#/definitions/string-array
@@ -37,6 +40,10 @@ properties:
           in drivers/tee/optee/optee_smc.h
         const: hvc
=20
+required:
+  - compatible
+  - method
+
 additionalProperties: false
=20
 examples:
@@ -45,5 +52,6 @@ examples:
       optee {
         compatible =3D "linaro,optee-tz";
         method =3D "smc";
+        interrupts =3D <0 187 4>;
       };
     };
--=20
2.31.1


--===============3963951860042423985==--

