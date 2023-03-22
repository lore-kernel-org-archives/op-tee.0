From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v6 1/2] dt-bindings: optee driver interrupt can be a per-cpu interrupt
Date: Wed, 22 Mar 2023 14:22:11 +0100
Message-ID: <20230322132212.3646972-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8745844738830132558=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8745844738830132558==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Explicit in optee firmware device tree bindings that the interrupt
used by optee driver for async notification can be a peripheral
interrupt or a per-cpu interrupt.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
No change since v5

No change since v4

Changes since v3:
- Patch added in this v4 to address review comments.
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.y=
aml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index d4dc0749f9fd..5d033570b57b 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -28,7 +28,8 @@ properties:
     maxItems: 1
     description: |
       This interrupt which is used to signal an event by the secure world
-      software is expected to be edge-triggered.
+      software is expected to be either a per-cpu interrupt or an
+      edge-triggered peripheral interrupt.
=20
   method:
     enum: [smc, hvc]
--=20
2.25.1


--===============8745844738830132558==--

