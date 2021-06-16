From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 2/7] dt-bindings: arm: Convert optee binding to json-schema
Date: Wed, 16 Jun 2021 12:36:44 +0200
Message-ID: <20210616103649.2662395-3-jens.wiklander@linaro.org>
In-Reply-To: <20210616103649.2662395-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4394408521546805173=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4394408521546805173==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Converts the optee binding to use DT schema format.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ------------
 .../arm/firmware/linaro,optee-tz.yaml         | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,opt=
ee-tz.txt
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,opt=
ee-tz.yaml

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.t=
xt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
deleted file mode 100644
index d38834c67dff..000000000000
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-OP-TEE Device Tree Bindings
-
-OP-TEE is a piece of software using hardware features to provide a Trusted
-Execution Environment. The security can be provided with ARM TrustZone, but
-also by virtualization or a separate chip.
-
-We're using "linaro" as the first part of the compatible property for
-the reference implementation maintained by Linaro.
-
-* OP-TEE based on ARM TrustZone required properties:
-
-- compatible     : should contain "linaro,optee-tz"
-
-- method         : The method of calling the OP-TEE Trusted OS. Permitted
-                   values are:
-
-                   "smc" : SMC #0, with the register assignments specified
-		           in drivers/tee/optee/optee_smc.h
-
-                   "hvc" : HVC #0, with the register assignments specified
-		           in drivers/tee/optee/optee_smc.h
-
-
-
-Example:
-	firmware {
-		optee {
-			compatible =3D "linaro,optee-tz";
-			method =3D "smc";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.y=
aml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
new file mode 100644
index 000000000000..c931b030057f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/firmware/linaro,optee-tz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OP-TEE Device Tree Bindings
+
+maintainers:
+  - Jens Wiklander <jens.wiklander@linaro.org>
+
+description: |
+  OP-TEE is a piece of software using hardware features to provide a Trusted
+  Execution Environment. The security can be provided with ARM TrustZone, but
+  also by virtualization or a separate chip.
+
+properties:
+  $nodename:
+    const: optee
+  compatible:
+      oneOf:
+        - description:
+            We're using "linaro" as the first part of the compatible property
+            for the reference implementation maintained by Linaro.
+          const: linaro,optee-tz
+
+  method:
+    description: The method of calling the OP-TEE Trusted OS.
+    $ref: /schemas/types.yaml#/definitions/string-array
+    oneOf:
+      - description: |
+          SMC #0, with the register assignments specified in
+          in drivers/tee/optee/optee_smc.h
+        const: smc
+      - description: |
+          HVC #0, with the register assignments specified in
+          in drivers/tee/optee/optee_smc.h
+        const: hvc
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      optee {
+        compatible =3D "linaro,optee-tz";
+        method =3D "smc";
+      };
+    };
--=20
2.31.1


--===============4394408521546805173==--

