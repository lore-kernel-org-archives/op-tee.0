From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v5 1/2] dt-bindings: arm: optee: add interrupt controller properties
Date: Sat, 06 May 2023 09:32:34 +0200
Message-ID: <20230506073235.2770292-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6646148163304120870=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6646148163304120870==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds an optional interrupt controller property to optee firmware node
in the DT bindings. Optee driver may embeds an irqchip exposing
OP-TEE interrupt events notified by the TEE world. Optee registers up
to 1 interrupt controller and identifies each line with a line
number from 0 to UINT16_MAX.

The identifiers and meaning of the interrupt line number are specific
to the platform and shall be found in the OP-TEE platform documentation.

In the example shown in optee DT binding documentation, the platform SCMI
device controlled by Linux scmi driver uses optee interrupt irq 5 as
signal to trigger processing of an asynchronous incoming SCMI message
in the scope of a CPU DVFS control. A platform can have several SCMI
channels driven this way. Optee irqs also permit small embedded devices
to share e.g. a gpio expander, a group of wakeup sources, etc... between
OP-TEE world (for sensitive services) and Linux world (for non-sensitive
services). The physical controller is driven from the TEE which exposes
some controls to Linux kernel.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v4:
- Removed empty line between Cc: tags and S-o-b tags.

No changes since v3

Changes since v2:
- Added a sentence on optee irq line number values and meaning, in
  DT binding doc and commit message.
- Updated example in DT binding doc from comment, fixed misplaced
  interrupt-parent property and removed gic and sram shm nodes.

Changes since v1:
- Added a description to #interrupt-cells property.
- Changed of example. Linux wakeup event was subject to discussion and
  i don't know much about input events in Linux. So move to SCMI.
  In the example, an SCMI server in OP-TEE world raises optee irq 5
  so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
  SCMI message in the scmi device for liekly later processing in threaded
  context. The example includes all parties: optee, scmi, sram, gic.
- Obviously rephrased the commit message.
---
 .../arm/firmware/linaro,optee-tz.yaml         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.y=
aml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index 5d033570b57b..9d9a797a6b2f 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -41,6 +41,16 @@ properties:
       HVC #0, register assignments
       register assignments are specified in drivers/tee/optee/optee_smc.h
=20
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description: |
+      OP-TEE exposes irq for irp chip controllers from OP-TEE world. Each
+      irq is assigned a single line number identifier used as first argument.
+      Line number identifiers and their meaning shall be found in the OP-TEE
+      firmware platform documentation.
+
 required:
   - compatible
   - method
@@ -65,3 +75,31 @@ examples:
             method =3D "hvc";
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    firmware  {
+        optee: optee {
+            compatible =3D "linaro,optee-tz";
+            method =3D "smc";
+            interrupt-parent =3D <&gic>;
+            interrupts =3D <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
+            interrupt-controller;
+            #interrupt-cells =3D <1>;
+        };
+
+        scmi {
+            compatible =3D "linaro,scmi-optee";
+            linaro,optee-channel-id =3D <0>;
+            shmem =3D <&scmi_shm_tx>, <&scmi_shm_rx>;
+            interrupts-extended =3D <&optee 5>;
+            interrupt-names =3D "a2p";
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            scmi_cpu_dvfs: protocol(a)13 {
+                reg =3D <0x13>;
+                #clock-cells =3D <1>;
+            };
+        };
+    };
--=20
2.25.1


--===============6646148163304120870==--

