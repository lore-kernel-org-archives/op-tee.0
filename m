From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RESEND PATCH v5 2/7] dt-bindings: remoteproc: Add compatibility for
 TEE support
Date: Tue, 21 May 2024 14:24:53 +0200
Message-ID: <20240521122458.3517054-3-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240521122458.3517054-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5091462485338555766=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5091462485338555766==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
where the Cortex-M4 firmware is loaded by the Trusted execution Environment
(TEE).
For instance, this compatible is used in both the Linux and OP-TEE
device-tree:
- In OP-TEE, a node is defined in the device tree with the
  st,stm32mp1-m4-tee to support signed remoteproc firmware.
  Based on DT properties, OP-TEE authenticates, loads, starts, and stops
  the firmware.
- On Linux, when the compatibility is set, the Cortex-M resets should not
  be declared in the device tree.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/remoteproc/st,stm32-rproc.yaml   | 51 ++++++++++++++++---
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml=
 b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index 370af61d8f28..36ea54016b76 100644
--- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -16,7 +16,12 @@ maintainers:
=20
 properties:
   compatible:
-    const: st,stm32mp1-m4
+    enum:
+      - st,stm32mp1-m4
+      - st,stm32mp1-m4-tee
+    description:
+      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by non-s=
ecure context
+      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by s=
ecure context
=20
   reg:
     description:
@@ -142,21 +147,41 @@ properties:
 required:
   - compatible
   - reg
-  - resets
=20
 allOf:
   - if:
       properties:
-        reset-names:
-          not:
-            contains:
-              const: hold_boot
+        compatible:
+          contains:
+            const: st,stm32mp1-m4
     then:
+      if:
+        properties:
+          reset-names:
+            not:
+              contains:
+                const: hold_boot
+      then:
+        required:
+          - st,syscfg-holdboot
+      else:
+        properties:
+          st,syscfg-holdboot: false
+        required:
+          - reset-names
       required:
-        - st,syscfg-holdboot
-    else:
+        - resets
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp1-m4-tee
+    then:
       properties:
         st,syscfg-holdboot: false
+        reset-names: false
+        resets: false
=20
 additionalProperties: false
=20
@@ -188,5 +213,15 @@ examples:
       st,syscfg-rsc-tbl =3D <&tamp 0x144 0xFFFFFFFF>;
       st,syscfg-m4-state =3D <&tamp 0x148 0xFFFFFFFF>;
     };
+  - |
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    m4(a)10000000 {
+      compatible =3D "st,stm32mp1-m4-tee";
+      reg =3D <0x10000000 0x40000>,
+            <0x30000000 0x40000>,
+            <0x38000000 0x10000>;
+      st,syscfg-rsc-tbl =3D <&tamp 0x144 0xFFFFFFFF>;
+      st,syscfg-m4-state =3D <&tamp 0x148 0xFFFFFFFF>;
+    };
=20
 ...
--=20
2.25.1


--===============5091462485338555766==--

