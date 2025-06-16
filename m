Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26017C71135
	for <op-tee@archiver.kernel.org>; Mon, 16 Jun 2025 08:02:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 68FF742E92
	for <op-tee@archiver.kernel.org>; Mon, 16 Jun 2025 08:02:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector1 header.b=zr82XDFI;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C6CE242E92
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Jun 2025 07:58:35 +0000 (UTC)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7Xpxd029583;
	Mon, 16 Jun 2025 09:58:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Jeq5JI4lCT6ZEy/eg01EjyjLaJrHnzpFREfAtoOf8ec=; b=zr82XDFIJemNGefZ
	scZbCyNeYiLbmKJZFI+0cN+rkV3vdE7GyMh46T6kpU2FR920zOYl5NOnNF2AW6pl
	iwSWlSTBv+4yGgwxBn1GeQp0z093MumsJqCPgVGoguEZQWsfKAid6ULOpFNcYZGo
	5gjQ84JGzJ2u9Bw8gojcnv3ep3huhkl8fjVr6eqAegap482t/aaB/c5j7ycM3f2J
	xbh/suHmB/7pojzHBc1Q1kLnuGMt81mMa0s6eDH1hjesIF2cgRVuGurH87+sLxve
	Nj6YBx6802mwBlQHf5wE+Ks6toHo3Qci9vlU7Bxd+R6N0vBs/XesoSR850CMifxx
	kOQ9IQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4790e1yc80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 09:58:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2E91640046;
	Mon, 16 Jun 2025 09:57:12 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 95EBF4CB033;
	Mon, 16 Jun 2025 09:56:22 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 09:56:22 +0200
Received: from localhost (10.48.86.121) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 09:56:22 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>
Subject: [PATCH v18 4/6] dt-bindings: remoteproc: Add compatibility for TEE support
Date: Mon, 16 Jun 2025 09:55:28 +0200
Message-ID: <20250616075530.4106090-5-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616075530.4106090-1-arnaud.pouliquen@foss.st.com>
References: <20250616075530.4106090-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.121]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_03,2025-06-13_01,2025-03-28_01
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C6CE242E92
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:185.132.182.106:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[185.132.182.106:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ASN(0.00)[asn:52129, ipnet:185.132.182.0/24, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=8262f63a79=arnaud.pouliquen@foss.st.com];
	TO_DN_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	FORGED_SENDER_VERP_SRS(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
Message-ID-Hash: RH4KQCX6RN37L7N4DFPHY5AD5GDQRBH4
X-Message-ID-Hash: RH4KQCX6RN37L7N4DFPHY5AD5GDQRBH4
X-MailFrom: prvs=8262f63a79=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RH4KQCX6RN37L7N4DFPHY5AD5GDQRBH4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
where the Cortex-M4 firmware is loaded by the Trusted Execution Environment
(TEE).

For instance, this compatible is used in both the Linux and OP-TEE device
trees:
- In OP-TEE, a node is defined in the device tree with the
  "st,stm32mp1-m4-tee" compatible to support signed remoteproc firmware.
  Based on DT properties, the OP-TEE remoteproc framework is initiated to
  expose a trusted application service to authenticate and load the remote
  processor firmware provided by the Linux remoteproc framework, as well
  as to start and stop the remote processor.
- In Linux, when the compatibility is set, the Cortex-M resets should not
  be declared in the device tree. In such a configuration, the reset is
  managed by the OP-TEE remoteproc driver and is no longer accessible from
  the Linux kernel.

Associated with this new compatible, add the "st,proc-id" property to
identify the remote processor. This ID is used to define a unique ID,
common between Linux, U-Boot, and OP-TEE, to identify a coprocessor.
This ID will be used in requests to the OP-TEE remoteproc Trusted
Application to specify the remote processor.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/remoteproc/st,stm32-rproc.yaml   | 58 ++++++++++++++++---
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index 843679c557e7..58da07e536fc 100644
--- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -16,7 +16,12 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32mp1-m4
+    enum:
+      - st,stm32mp1-m4
+      - st,stm32mp1-m4-tee
+    description:
+      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by non-secure context
+      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by secure context
 
   reg:
     description:
@@ -43,6 +48,10 @@ properties:
           - description: The offset of the hold boot setting register
           - description: The field mask of the hold boot
 
+  st,proc-id:
+    description: remote processor identifier
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   st,syscfg-tz:
     deprecated: true
     description:
@@ -146,21 +155,43 @@ properties:
 required:
   - compatible
   - reg
-  - resets
 
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
+      required:
+        - st,proc-id
 
 additionalProperties: false
 
@@ -192,5 +223,16 @@ examples:
       st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
       st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
     };
+  - |
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    m4@10000000 {
+      compatible = "st,stm32mp1-m4-tee";
+      reg = <0x10000000 0x40000>,
+            <0x30000000 0x40000>,
+            <0x38000000 0x10000>;
+      st,proc-id = <0>;
+      st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
+      st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
+    };
 
 ...
-- 
2.25.1

