Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636C3FED9FD
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 18:05:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AF7F543AAB
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 18:05:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Bjv7Q3zz;
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011020.outbound.protection.outlook.com [40.107.130.20])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B4EA643A9C
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Mar 2026 18:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PopqGaoA7vUSLdJ6S6QBdb4qWY1fCFrFFwe27kXbk1seaoR5Jx1prZgHVN3KdDue+loY2ZaZHTzdHL5Ji2UHBou9e/fYnOx6GqtfhZEBfijLqujntUPZTHG+LwfI+60wSyfHP6+Ep1AqfZWck9ZmAoNfrMc5+KCHO0lmSKDWbrMKy/MzV0NlijObDcMUGSSCQyX9mCKa6NOgQS4w+moZHBSxJ8bTJCEe+HfTgJCO+N1TZT6gxSvNAQmBk74D9agLAd50z0lj4SY0/V928GvKUZt2K2AsPSsQvzhBBDBC6MT1wke07g9scl2g8jJcZ4S56GmUMgq+c7yvf8QtA2q4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgnVwRlxRSPUXE57wgU1chu8ufbLCT0pkwC8P3udG/Q=;
 b=No0vupvHOIJfkXSRIfPtjC0Z3fdQATmqyhgGxQ2F+xMtMeANyz6mWxJD4lU2PWR/s/Z4FsvJy0DHWeVk5gPFb5gFVFjc8SLnSPS7qhEnmBpYnMKmzo7nxkAdygNGl/N4CbAW8hiZUpmKpAJYZKHI1DwGktbafZMWS3oZ1tn+S16ycBtj/SxdJRj7pi+JsGchf6r/K/yqs7P4D7zvW0Ju6BEmlGG+uTIe+4KVXDsSr9kypfUa8GUIwgoVQInrmayVmIYTLk6rXy4XGLozzFJexxIosnkhAD1EFD5oF7YDJ4OgMDoHshVA4RDcOxAyxbKCclfChuHL7bwAE8c1lMHT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgnVwRlxRSPUXE57wgU1chu8ufbLCT0pkwC8P3udG/Q=;
 b=Bjv7Q3zzSGK3SG5evGeyBiZYElV1QYCGwgCjbRRuYh9yx1TGuXUQRCO6TDPIEDkWACBTfMdM486zdDHucDiWhlG5lD7ammTwFs1DHT+8cS0OWuyBaU0i0KxnYDIXMViJ03aHWHoyQJZOB0cKxEtxv1JdqawCxmnzEBbeU3nG87i2IvNMblfJoxwlhs5bVUtv7hsWTGQXNt1YLSTX+DAT0NKmLfwa8iOL2axlueOw+etyhMwkM8YFJX0ej+UQBe30g6TRadTC/YNNbI1vBhftWsKom1/29WXDb8D/477GCTg9pMUHdBo2xLD5YIDUHchS6YZX+pMBYC+vIsurFOm00A==
Received: from AS4P250CA0030.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::20)
 by PAVPR10MB7281.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 18:03:51 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::68) by AS4P250CA0030.outlook.office365.com
 (2603:10a6:20b:5e3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 18:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 18:03:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:06:25 +0100
Received: from localhost (10.252.21.194) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:03:50 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v21 2/6] dt-bindings: remoteproc: Add STM32 TEE-controlled rproc binding
Date: Tue, 17 Mar 2026 19:03:23 +0100
Message-ID: <20260317180329.1207625-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317180329.1207625-1-arnaud.pouliquen@foss.st.com>
References: <20260317180329.1207625-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.21.194]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|PAVPR10MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b197fc-9bcc-4db6-c737-08de844f8b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	qMFYeoJPhalPpemjvB4+5oTDyg3MrzznWAC7F3O8CzDaWBWv7PNaLgXc2o9V0kyy7kpm3lulFTazyhpnJcBVjVDZK+IFIrOJa/tEJWHUSH0QXN7+4UG6/QacPHN+D2bnPDEpvvo71BQ/xZ+KD6XVueZW7klUiHqG+N+iBc+xMuDBAWkj6Gh1eIu9m8olpelxwAS7T3khcTE7jKxfZiIKkNa1OukVsqnZL4sVs7rzZ5XH7AUpFhuFTAhmQHu+kRZ0uA0luFsxDBrGy3y448SSPXYh/OedImEcXuHFYVeiLnWwNmuFLCKoxyZCBh/3NcNT1hpJJQ2MtkJ/+/27B/+jQEA8qfxYS4IX9LCbivaFwX9+1/262th1eJ98WkZdXLFbp8AQSF1KCPTopSsJ1CUfi7EcR9M9xqofN4KiYcunf8wFsqkDJCAbbUETcH1Z9xqtI2FN/k7rW41tvm3dGPAtVFI78zjenNSLXfYpvzNngQvS2L2fDr9thUHgtDVbRpjgsZzgsMs/i1lsGt60UkOk3QvnwdJ51jOoZ+fyhmJfGhTihll5Fg6cja7m0qzKrj+vRquY8UguZvVzKKaMQhznAjfRr1m4wHuegLG4iFlZLK6UasmZgSOzwHTIJuqfpsIuBDAGfUuiONaXO5K0AqtBIjlrNzIiD6oX6/Aad327zBHWSKUnk2Te8irQa3cEFv3mONJoI+EFuZeK1gBukdXculZbP7ghGofzl0zdYknMZVg=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	t3bMtmmjgZ/0hoow+ttfisDHaxHj+qMUO+Kzx1jOWE9V03hxTO2V6Ua6ffZQB3v2HRGRcVATrkCNr3hAVnuzf6TXHsvmidFDieS+7MLNsZ3R5f8VyphQxIPMGJ4oHmoBUrZPBuePaYiIQHAETfK+3iIiKxxD/3NxN+d2KB3kotBLIxUzgnEUd59p7F3yWbpRhithBYvMhFb2F9O93OpHSaAYp/ccrk6YVi3wibqNTwkyRvUWzI+Bc9HFkKsEfwvqOO3AVxaD+x2S4kqfKN+LY8vIExL2JvLsxzdvelIbHS/r1yOXf+9wtaIQkf3QVdm79JKEFB0rV2TY5CwTGs0LLFaPYixNf9W3HEc4ylLoCDh4ape/AGXlGrziRt1VuRfQLORc9q6IV47Zu+JXrY43ED2kQINXgflnjfRdEfLijf/De0tDb1p2zPSrHvbb74+d
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:03:51.0278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b197fc-9bcc-4db6-c737-08de844f8b82
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7281
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.50 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	URL_BACKSLASH_PATH(2.00)[0.0.0.0];
	URL_NUMERIC_IP(1.50)[0.0.0.0];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.130.20:from];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.130.20:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B4EA643A9C
X-Spamd-Bar: +
Message-ID-Hash: OUZLK5CCLYNSKZRGQYPBMZFNB5AM6RB7
X-Message-ID-Hash: OUZLK5CCLYNSKZRGQYPBMZFNB5AM6RB7
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OUZLK5CCLYNSKZRGQYPBMZFNB5AM6RB7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add a Device Tree binding for the STM32 remote processor controlled
via a Trusted Application running in OP-TEE.
This binding describes the interface and properties required for STM32MP
remoteproc instances managed by the TEE rproc service, including a
linkage to the TEE backend through the property "rproc-tee-phandle".

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
V21 updates:
- the m4 node is no more declared as a child of the optee-rproc node
- "rproc-tee-phandle" property is introduced to reference the optee-rproc
---
 .../remoteproc/st,stm32-rproc-tee.yaml        | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml
new file mode 100644
index 000000000000..ca4dd1c8e7b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/st,stm32-rproc-tee.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 remote processor controlled via TEE
+
+maintainers:
+  - Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
+
+description: |
+  STM32MP remote processor controlled by a Trusted Application
+  running in OP-TEE. This node is a child of the TEE remoteproc service
+  (UUID 80a4c275-0a47-4905-8285-1486a9771a08) and exposes a remoteproc
+  instance managed by the Linux remoteproc core via the TEE rproc service.
+
+  Firmware loading, authentication and remote processor start/stop are managed
+  by the TEE application. The STM32-specific driver handles platform resources
+  such as the mailboxes and reserved-memory.
+
+properties:
+  compatible:
+    const: st,stm32mp1-m4-tee
+
+  reg:
+    description: |
+      Remote processor identifier used by the TEE service. The <0> value
+      in the example denotes a single instance with ID 0.
+    maxItems: 1
+
+  mboxes:
+    description: |
+      Mailbox channels used for rpmsg/virtio functionality and processor
+      shutdown.
+    maxItems: 3
+
+  mbox-names:
+    items:
+      - const: vq0
+      - const: vq1
+      - const: shutdown
+
+  memory-region:
+    description: |
+      List of phandles to reserved-memory nodes describing the memory layout
+      for the interprocessors communication.
+
+  interrupts:
+    description: |
+      Optional watchdog / status interrupt line used to detect crashes
+      and optionally wake up the system.
+    maxItems: 1
+
+  st,auto-boot:
+    type: boolean
+    description: |
+      If present, the remote processor will be automatically started by
+      the remoteproc core at boot.
+
+  wakeup-source:
+    type: boolean
+    description: |
+      Indicates that the watchdog interrupt can be used as a wakeup source.
+
+  rproc-tee-phandle:
+    description: |
+      Phandle to the remote processor backend node and its identifier. This property
+      is used to link the TEE remoteproc service to the remote processor instance
+      it controls. The value is a phandle reference to the remote processor node,
+      followed by a cell specifying the remote processor identifier used by the TEE.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+required:
+  - compatible
+  - reg
+  - rproc-tee-phandle
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+        tee_rproc: optee-rproc {
+            compatible = "80a4c275-0a47-4905-8285-1486a9771a08";
+        };
+    };
+
+    m4: m4@0 {
+      compatible = "st,stm32mp1-m4-tee";
+      reg = <0 0>;
+
+      mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
+      mbox-names = "vq0", "vq1", "shutdown";
+
+      memory-region = <&vdev0vring0>, <&m_ipc_shm>, <&mcuram2>,
+                      <&vdev0vring1>, <&vdev0buffer>, <&retram>;
+
+      interrupt-parent = <&exti>;
+      interrupts = <68 1>;
+
+      rproc-tee-phandle = <&tee_rproc 0>;
+      st,auto-boot;
+      wakeup-source;
+
+      status = "okay";
+    };
+...
-- 
2.43.0

