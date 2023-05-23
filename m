From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [RFC PATCH 3/4] dt-bindings: remoteproc: add compatibility for TEE support
Date: Tue, 23 May 2023 09:14:38 +0000
Message-ID: <20230523091350.292221-4-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1902335671916848642=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1902335671916848642==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Rework compatibility description according to the support of
the authenticated firmware relying on OP-TEE authentication.

The expected behavior is:
- with legacy compatible "st,stm32mp1-m4" the Linux kernel loads a
  non-signed (ELF) firmware image,
- with compatible "st,stm32mp1-m4-tee" the Linux kernel load a signed
  firmware image. In this case it calls TEE services to manage the firmware
  loading and the remoteproc life-cycle.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 .../bindings/remoteproc/st,stm32-rproc.yaml   | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml=
 b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index 959a56f1b6c7..1671a90d5974 100644
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
+      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by Linux
+      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by O=
PTEE
=20
   reg:
     description:
@@ -135,8 +140,28 @@ required:
   - compatible
   - reg
   - resets
-  - st,syscfg-holdboot
-  - st,syscfg-tz
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - st,stm32mp1-m4
+    then:
+      required:
+        - memory-region
+        - st,syscfg-holdboot
+        - st,syscfg-tz
+        - resets
+  - if:
+      properties:
+        compatible:
+          enum:
+            - st,stm32mp1-m4-tee
+    then:
+      required:
+        - memory-region
+
=20
 additionalProperties: false
=20
@@ -148,6 +173,8 @@ examples:
       reg =3D <0x10000000 0x40000>,
             <0x30000000 0x40000>,
             <0x38000000 0x10000>;
+      memory-region =3D <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
+                      <&m_ipc_shm>, <&vdev0vring1>, <&vdev0buffer>;
       resets =3D <&rcc MCU_R>;
       st,syscfg-holdboot =3D <&rcc 0x10C 0x1>;
       st,syscfg-tz =3D <&rcc 0x000 0x1>;
--=20
2.25.1


--===============1902335671916848642==--

