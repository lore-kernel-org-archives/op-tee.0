Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C44F9D0D5
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:43:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 24CE2443F7
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:43:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=OYbQrftP;
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 005A043247
	for <op-tee@lists.trustedfirmware.org>; Tue, 14 Apr 2026 15:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLYAxrmh5MFb2EiblkN3PmvkGHuz4k8ObWFMXyYJ1m+yhv4uHwxkW1xRSiK4TbbMQB/YcZ2EY/jkT/TSKHgSQc3QYmoohS8srs50Dr1V2EH4JgboueCbXFEZqG4gKjxZwZ+GYWHrhstQorKzi1gMA5KP2zq4MmyLbanM/vAlaPuq6VY7HhFsFyI2U+dV20uSkMqWpcH5B1aR42usU79FqpDidl7oLpfwKWy7Y6ADUnN6ZeZjddcF3fbAnnFa44XbQj0akA8midMGrl9hLBPMmeNRlBFKLjG6FDUKTPCT8UiU58mRcoj6wtSD5+XkcjG3mU8cRR1nMVP5f+Hin/CAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reO8FkVOSCmvh6cNS+XOBBthpeRomlgGJxelQnXGf7c=;
 b=BdyJ4JiCY/5kj9sYFaO25fCGVrUfeJ1gUkLwuCg3TwypxFLV40NWU9N2q6L69PDt9jjdysjHnWSvIYjTUZ9WgoSAOl8yoKxq7BSVkGLnC9vI7Ve4psnfS3/K6WjF/0tIeS1uRfpeGzINt4sS0onedV1mEFQiBq2Z9dVRvA94F/PQK2hR/VmU6mcsQJyVpI27bR+Iz/bh2ZpcUr/HSdeq5+iqrzh2MxFMDcdLSRIIZni9iju1k2mb56CfkSsW0rKUPdDDMDxHNBi2Fbh0EUHyINK96H3qPBYcuYdiF6WGSdCnCUpCt0kqxvGIq/x/fmEDGiu0OuUjS/EpFdoUWkNDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reO8FkVOSCmvh6cNS+XOBBthpeRomlgGJxelQnXGf7c=;
 b=OYbQrftPixs49tSY4a6AbbXSkrbrODcvKcAXgDAoGCaNZspy9CmgaNXJOIXACVdqQlW67eeCVNOAN7tigoYBtqA1YxNk7+ty+jwDfbZCfflTqepga915py0oe6GdeJkee8Fcgqr48CkjICvuF9odWwyZWb3J5Wh4NhVwKbCrJ5qMEc39pF0Wzh8vLJh2+FvFU/Li1XwH8czlFZ32ngk1sahWRgs/FoiXrbB+HxYSeSGuVimh0RiwL5xENPw15ETLO0UOt+prJRFi6SpZGyFXHhl6x6PEV052jT9LtLf+JnXptYeeSvafn+/wvKUqbEWQhe8YAuL41llatOUvc3UjAA==
Received: from DU2PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:10:234::23)
 by PAWPR10MB7198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:29:17 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::59) by DU2PR04CA0048.outlook.office365.com
 (2603:10a6:10:234::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 15:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 14 Apr 2026 15:29:16 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:32:04 +0200
Received: from localhost (10.252.12.46) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:29:15 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v22 1/7] dt-bindings: firmware: Add TEE remoteproc service binding
Date: Tue, 14 Apr 2026 17:28:56 +0200
Message-ID: <20260414152904.1679724-2-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414152904.1679724-1-arnaud.pouliquen@foss.st.com>
References: <20260414152904.1679724-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.12.46]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0A:EE_|PAWPR10MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 614e3259-31d6-40d2-072e-08de9a3a972e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|18002099003|22082099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info: 
	VmAP85iVx+bvd+XqJMs8KQIefkELkuNuaFXVeSZOhMwS4f3DHU0fWir/esKQUvtvqPl75ha743MDGCNY+lI2tXF/Dfg8zDafA6+pHNH7xFDLZ8Ofsv3eP4Y+HC65mjLpAr7cnVjTGHRZsGY8alQKy4TXwX8QD8XQ1e3OCuJg5AOv/nZM+886hHlaxVAJbM0c1f/ZSZ4S1EM7UqNKDqhvhKlRnBmm9TxyJLbHJ3FfUoM40/73ZJSctu6dZsVMxNfpjs01HbJQgyJnK+0/lwWhR2TbvMfKmQBBdHHs9dvP6hzJ+eXXCL08lZqiQ8FTRao5o3qwdWBHfC0zhYJ0V7W5LME5UIwPoFalt4XRvTbrvAteSWePA+NTplrTZTT26oHpLaJSy9dGAJ/k2nnEjG8bhzzB34Y8WrPmAYLzM4F30Uwl/KHVYcue+ppCDasVGMsc9cez7Exl8f02ph74Exas95k1Mk2Vo9mq4nvGghQbPek6Tf7SHk7qkrZSIeLmfwHXcFCfoepvYmg5VpWhGUKzxSkRRGtO5lVd4JAcz9GFonUrykzSJ/th8vJRm3siVDPSiyGaj0RRTPGW+hanrV6aO5xdAtdGC8c35dz3G1OdOuAU7XZC0YnhDiGJ6z8C5UTR1BXKtkBsZl1Z07jWuYnJoJQfeMvOjBfXCQAfT2iR++oOYvgov8DXxIS4vjXS81gXOrPXo4b6AgK/MJOPrjJC/ZC0TGU5J2OwafTGp1y7mVg=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(18002099003)(22082099003)(13003099007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7Xbfp0B7/V6RVxNjkxj24oyoIJRP334N+gWsm5feRMoUvqkN6aepSb9sJHdrkuPNW8m/HqWsrIMLA2T+UmQn/6i5hUeKqS8fRA6w0+LvgyAAZlvZ9y+I9cUfu1zxMiAkKcHaI47OwexbJzJ0QVvcERH4AFbW24DPgLg9rHJQ9nAdZd5WYPy3mQVezf5xZ9tednFOQD3ZX18hiHIBesslOgxjtzbLGlHOcDmRKRvPYMG0gnbt8HWfodIBASLd8yoXBsjWoQizBKyTwRMoQ2J2tvicfnJND5uNUr7xreqda0ku2aLcNxTVUkSJ60242ni8LVlITIrKO8CxLYa7q5WObnCNW1qWs22aTqCZxRNB/rYC5/2nGXPRbtyZnzLJ1oXsq1t/0V3B/XxvgYJ7m7v3wcp6S3JIkfxm15fjMEG1t8+tOWQFzgo7AdUK/q4WDYaN
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:29:16.7247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614e3259-31d6-40d2-072e-08de9a3a972e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7198
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	BAYES_HAM(-2.16)[95.98%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.84.59:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 005A043247
X-Spamd-Bar: -
Message-ID-Hash: JBWESINBROBJRDN5VWT4RLHB2N4WOTCY
X-Message-ID-Hash: JBWESINBROBJRDN5VWT4RLHB2N4WOTCY
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JBWESINBROBJRDN5VWT4RLHB2N4WOTCY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add a device tree binding for the TEE-based remote processor control
service implemented as an OP-TEE Trusted Application identified by
UUID 80a4c275-0a47-4905-8285-1486a9771a08.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
v21 updates:
- rename compatible to exactly match with the TEE UUID
- the remoteproc device driver is no more declared as a child,
  but use phandle as done for the SCMI.
- remove linaro,optee-tz bindings update are now useless.
---
 .../bindings/remoteproc/remoteproc-tee.yaml   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml
new file mode 100644
index 000000000000..498a7e590905
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/remoteproc-tee.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TEE Remote Processor Control Service (UUID 80a4c275-0a47-4905-8285-1486a9771a08)
+
+maintainers:
+  - Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
+
+description:
+  Node describing a TEE-based remote processor control service implemented as
+  a Trusted Application identified by UUID 80a4c275-0a47-4905-8285-1486a9771a08.
+
+  This binding is intended to define the interface for remoteproc services
+  implemented as TAs running in a TEE, and is used by the a remoteproc driver
+  to bind to such a service and control a remote processor through it.
+
+properties:
+  compatible:
+    const: 80a4c275-0a47-4905-8285-1486a9771a08
+
+required:
+  - compatible
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
+...
-- 
2.43.0

