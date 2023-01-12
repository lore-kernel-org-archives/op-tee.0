From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 2/3] dt-bindings: arm: optee: add interrupt controller properties
Date: Thu, 12 Jan 2023 15:54:23 +0100
Message-ID: <20230112145424.3791276-3-etienne.carriere@linaro.org>
In-Reply-To: <20230112145424.3791276-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0439840847297206798=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0439840847297206798==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds optional interrupt controller properties used when OP-TEE generates
interrupt events optee driver shall notified to its registered
interrupt consumer. The example shows how OP-TEE can trigger a wakeup
interrupt event consumed by a gpio-keys compatible device.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 .../arm/firmware/linaro,optee-tz.yaml         | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.y=
aml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index d4dc0749f9fd..42874ca21b7e 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -40,6 +40,11 @@ properties:
       HVC #0, register assignments
       register assignments are specified in drivers/tee/optee/optee_smc.h
=20
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
 required:
   - compatible
   - method
@@ -48,12 +53,24 @@ additionalProperties: false
=20
 examples:
   - |
+    #include <dt-bindings/input/input.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     firmware  {
-        optee  {
+        optee: optee {
             compatible =3D "linaro,optee-tz";
             method =3D "smc";
             interrupts =3D <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
+            interrupt-controller;
+            #interrupt-cells =3D <1>;
+        };
+    };
+
+    wake_up {
+        compatible =3D "gpio-keys";
+
+        button {
+            linux,code =3D <KEY_WAKEUP>;
+            interrupts-extended =3D <&optee 0>;
         };
     };
=20
--=20
2.25.1


--===============0439840847297206798==--

