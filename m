From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 07/10] dt-bindings: arm: qcomtee: add QTEE driver devicetree
 binding for TEE subsystem
Date: Mon, 02 Dec 2024 20:19:23 -0800
Message-ID: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-7-f502ef01e016@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?0-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8209037477274096304=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8209037477274096304==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Introduce qcom,tee compatible string.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 .../devicetree/bindings/arm/firmware/qcom,tee.yaml | 34 ++++++++++++++++++++=
++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/qcom,tee.yaml b/D=
ocumentation/devicetree/bindings/arm/firmware/qcom,tee.yaml
new file mode 100644
index 000000000000..43b7e8ac944e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/firmware/qcom,tee.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/firmware/qcom,tee.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm TEE
+
+maintainers:
+  - Amirreza Zarrabi <quic_azarrabi@quicinc.com>
+
+description: |
+  QTEE is a piece of software provide a Trusted Execution Environment using =
ARM
+  TrustZone for Qualcomm SoC.
+
+properties:
+  $nodename:
+    const: qcom_tee
+
+  compatible:
+    const: qcom,tee
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+        qcom_tee {
+            compatible =3D "qcom,tee";
+        };
+    };

--=20
2.34.1


--===============8209037477274096304==--

