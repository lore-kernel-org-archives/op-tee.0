From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [RFC PATCH 3/4] dt-bindings: reserved-memory: add linaro,restricted-heap
Date: Fri, 30 Aug 2024 09:03:50 +0200
Message-ID: <20240830070351.2855919-4-jens.wiklander@linaro.org>
In-Reply-To: <20240830070351.2855919-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6168933258751629864=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6168933258751629864==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Olivier Masse <olivier.masse@nxp.com>

DMABUF reserved memory definition for OP-TEE secure data path feature.

Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../linaro,restricted-heap.yaml               | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/linaro,=
restricted-heap.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/linaro,restric=
ted-heap.yaml b/Documentation/devicetree/bindings/reserved-memory/linaro,rest=
ricted-heap.yaml
new file mode 100644
index 000000000000..0ab87cf02775
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/linaro,restricted-hea=
p.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/linaro,restricted-heap.ya=
ml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linaro Secure DMABUF Heap
+
+maintainers:
+  - Olivier Masse <olivier.masse@nxp.com>
+
+description:
+  Linaro OP-TEE firmware needs a reserved memory for the
+  Secure Data Path feature (aka SDP).
+  The purpose is to provide a restricted memory heap which allow
+  the normal world OS (REE) to allocate/free restricted buffers.
+  The TEE is reponsible for protecting the SDP memory buffers.
+  TEE Trusted Application can access restricted memory references
+  provided as parameters (DMABUF file descriptor).
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    const: linaro,restricted-heap
+
+  reg:
+    description:
+      Region of memory reserved for OP-TEE SDP feature
+
+  no-map:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Avoid creating a virtual mapping of the region as part of the OS'
+      standard mapping of system memory.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - no-map
+
+examples:
+  - |
+  reserved-memory {
+    #address-cells =3D <2>;
+    #size-cells =3D <2>;
+
+    sdp(a)3e800000 {
+      compatible =3D "linaro,restricted-heap";
+      no-map;
+      reg =3D <0 0x3E800000 0 0x00400000>;
+    };
+  };
--=20
2.34.1


--===============6168933258751629864==--

