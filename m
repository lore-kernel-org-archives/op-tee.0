Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB7BFED9EF
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 18:07:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 082E043AAA
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 18:07:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=LuX2MRDG;
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B398F43AA7
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Mar 2026 18:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jyl0Z3RfBV6aV7v08oj6ACNkFHLpg6kIs6bwUpTslX2EE86GnEfiXqj7IdwQUPNQ6Xw14mXASQEmn29zvRYaX71F7eCWc/lNPg2ghwcefsLQCGF6E5xYQosXWMc8N3ZceBX7YDDVXhkiRurgCxZPZsiUeecWdPBzrTm6eIjoZtVjfmRIjJZ7GwDJPcMydADMPHcX69pKVSqolE7eRHKjt+7XvTA1EfVG5zLsedwUTO6DHTMHm8obTikeQjZLWH2zGTEW/cPTW/fiJLE5ZxzM1mvJYTGZBnJxrlFHvRouXcamol4yZQYHTW6JiNa3uE7nPvYfdCv4A5s6vu4MLU461Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYUrr8jz9oVCqWAYFTgKtT8hJYyTAVaoGz6ikhSJ+yE=;
 b=Ue+7l7ipcQ1TVXdEs6l7MAUByee4xtXf5qcBrlTWZFxsTtpDMzMDIxD2xkKtKRZQQ3IHWZ+PElJX2NUQhCUgBaEJKkUiMic0qa1kuA3CdIvi402HVmkmX0IOYx20aMORnL3vIQI284qIJXMeQsE/d/+1JpnReS4rrnWpPSNaq7DwwDTJVE14xv1BljD9GN5eGfI4jtMATkTf4NGbe16jP4i5pII1dgly60hhUPcpA+TO3MUHcvETSNkuKIblfzAktz+RITrWwAjz6MrrJQfYjYg1Qs7vRCTzlOCOQkqA9TNwBbent9yZugpcUAivktszkTxDXLysXcxjEg16YXw+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYUrr8jz9oVCqWAYFTgKtT8hJYyTAVaoGz6ikhSJ+yE=;
 b=LuX2MRDGWOP8h92taDTW82IRR3ly6BPKrINmX6qlTBWIjYKTbmBlO+eK7h9HeHyEpR88CRzdYsiq61n6rn6QarHqIaRM4XLFbi0nEl9cm8FZ4KB7n2JLQbOJ22kr7OhmzLzVG7zblgZiCwdJ0R4FEjTo7DPplz3XYf/rowJfyqZ8eJ7uwZiET76xOaXWquk97J6C7I1Qy3QUscxD9AaA+jwRsJ5Mdj/F84rFEA//TGr9t7vntu7+KCv/j5PF3Lr1FpgD+pvQCrWj7Z08I/mb28d6gloLr7AKMW/F/XolYGy/cegNdES+JDBbqa0ngozkW5l2oYGleJnhMEcm+z6hbw==
Received: from CWLP265CA0440.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::21)
 by GV1PR10MB9089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 18:03:55 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:400:1b7:cafe::20) by CWLP265CA0440.outlook.office365.com
 (2603:10a6:400:1b7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 18:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 18:03:54 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:06:28 +0100
Received: from localhost (10.252.21.194) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:03:53 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v21 6/6] remoteproc: stm32: Add TEE-controlled STM32 driver
Date: Tue, 17 Mar 2026 19:03:27 +0100
Message-ID: <20260317180329.1207625-7-arnaud.pouliquen@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|GV1PR10MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: e98cc13c-f187-4eb8-4f3c-08de844f8db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	s2y8In+5HyhkAkjy5WlqwdIyb26YTKRQJIOSqZjmEIq/p2F710ztXYs1hpghOGGWtiIsz5Bz/W8qZrlORWY/Zye14DAzPedn30DR58IZ1yQpvOV0rqUAmIEtstISagmf3Oy1wBr8vF9Ymd8vtmUEsyHz6cRBw0/RiQ89rMAp6YUjLBgxEgbTC8wmoSO83aJPtNRBppKl1YDV0cnRLK57b2nbnjZzwROVoEClNxMj3eMAYD+hf/JhWBtgGrI5pgl81FOdz+MOrFWbmKQmYKFV3bCYvU9n7UlFQAp1Hpq1SGEdVtppHerzux3PtnK6tZh2kSvYLweRyUSMJZPooqluVxD354wU/FrtWmcXszPc1FDnptnLR55bgqQXUXAx+//H35rN0GE0qYtedTVKr8iAVLpY/nYKgAh/v/4SSberIUVYeA73EbQ4em3s4NMwpE0W6Z7XnMYeSp9JXt3BcI9aYBn6Z9CEie1ve0QFVKQuVRJEti8kv7RFLbwSqIcgfMtz7O42UnLtz65zbzRd7dE0jGo3ZjPmWsBJz8zONuWPgxy539kbJRd5BVh1Mkr6n5WcE+KXrRF3GKa6CTVcEju7f47EPF3I/ekoFI3+UbCTZcFQ1URLOwBEkkR4STDdjsJIcL3vZrDz6yO6mNksEHCtfraF6U4Oro4fZSeW5B/7D1aIEtqyA/xl2Gb8MnsTDNPPSvBcWjQziOCucUs3EN3yorEMbgkgk1CZfzrhsfsQGnNP6jbAilL6weuDNtJ1xCAPPYynbhuWTUVrn2eXTQTWrw==
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7hrDPmPiOlD7TyP7CfhdEvzthK75c+0PS9YB1VQ/bSYxP9R9C7CeQMRBq/9VNYAeQXd9UJo792bbuoJExWEB/ffQkWT/uovlwsDE9aYTcRrcl222DHLaleNbQWaC1b8oi6NOW+VBd01gQYrKw2lgKVELkbaU34LTPHs1bjaImIl+g+xKKUht5iY5smoy8e44x+/2gLCCojS0S1lvUHf6oftXelZefUlYDdSPlvQ1EX8h0mdDtwBJOO19ZqCVn9F513X2yHL2QPiQYC7QbYXMd/bOvbstPx0KxF7BHPXprgsJ8wCPhSfaCzqU93y/W6cFklRxqcutZzH+D9WDDxpuOk6zljin7/B+kC8b0gS4+4hfOCxzlu2RzG4GReXTJmdVyNiqr39y2m+CUhWGOCq2DLTAUgN1pP7zFm6HfMlvPECCuQGrChc5ToR95JxhzJds
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:03:54.6784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98cc13c-f187-4eb8-4f3c-08de844f8db1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.70.30:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:400:1b7:cafe::20:received];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.70.30:from];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B398F43AA7
X-Spamd-Bar: --
Message-ID-Hash: QKLQGQKWTCFHPJO6WABAN7ENYWV7WK7V
X-Message-ID-Hash: QKLQGQKWTCFHPJO6WABAN7ENYWV7WK7V
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QKLQGQKWTCFHPJO6WABAN7ENYWV7WK7V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add a remoteproc platform driver for the STM32MP15 Cortex-M4 core
controlled via a TEE Trusted Application.

The driver integrates with the generic TEE remoteproc layer
(rproc_tee_*) to delegate firmware authentication, loading and
start/stop operations to the TEE, while handling STM32-specific
platform resources on the Linux side:

  - Translation between physical and device addresses using
    SoC-specific DMA ranges.
  - Registration of reserved-memory carveouts from "memory-region"
    phandles (including vdev vrings and buffers).
  - Mailbox-based virtio queue kicks and a shutdown channel using
    the IPCC mailbox controller.
  - Optional watchdog interrupt for crash reporting and wakeup.

This enables secure boot and runtime isolation of the M4 firmware
while still using the standard remoteproc and rpmsg frameworks
on STM32MP15.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
V21 updates:
- use of the rproc-tee-phandle property
---
 drivers/remoteproc/Makefile          |   2 +-
 drivers/remoteproc/stm32_rproc_tee.c | 537 +++++++++++++++++++++++++++
 2 files changed, 538 insertions(+), 1 deletion(-)
 create mode 100644 drivers/remoteproc/stm32_rproc_tee.c

diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index a1a5201982d4..80f0965bac95 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -36,7 +36,7 @@ qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
 obj-$(CONFIG_RCAR_REMOTEPROC)		+= rcar_rproc.o
 obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
 obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
-obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
+obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o stm32_rproc_tee.o
 obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o ti_k3_common.o
 obj-$(CONFIG_TI_K3_M4_REMOTEPROC)	+= ti_k3_m4_remoteproc.o ti_k3_common.o
 obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o ti_k3_common.o
diff --git a/drivers/remoteproc/stm32_rproc_tee.c b/drivers/remoteproc/stm32_rproc_tee.c
new file mode 100644
index 000000000000..7012f0a17a43
--- /dev/null
+++ b/drivers/remoteproc/stm32_rproc_tee.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/remoteproc.h>
+#include <linux/remoteproc_tee.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
+
+#include "remoteproc_internal.h"
+
+#define MBOX_NB_VQ		2
+#define MBOX_NB_MBX		3
+
+#define STM32_MBX_VQ0		"vq0"
+#define STM32_MBX_VQ0_ID	0
+#define STM32_MBX_VQ1		"vq1"
+#define STM32_MBX_VQ1_ID	1
+#define STM32_MBX_SHUTDOWN	"shutdown"
+
+struct stm32_rproc_tee_mem {
+	char name[20];
+	void __iomem *cpu_addr;
+	phys_addr_t phy_addr;
+	u32 dev_addr;
+	size_t size;
+};
+
+struct stm32_rproc_tee_dma_ranges {
+	u32 dev_addr;
+	u32 phy_addr;
+	u32 size;
+};
+
+struct stm32_mbox {
+	const unsigned char name[10];
+	struct mbox_chan *chan;
+	struct mbox_client client;
+	struct work_struct vq_work;
+	int vq_id;
+};
+
+struct stm32_rproc_tee {
+	int wdg_irq;
+	const struct stm32_rproc_tee_dma_ranges *ranges;
+	struct stm32_mbox mb[MBOX_NB_MBX];
+	struct workqueue_struct *workqueue;
+	struct of_phandle_args tee_phandle;
+};
+
+static const struct stm32_rproc_tee_dma_ranges stm32mp15_m4_dma_ranges[] = {
+	/* RETRAM address translation */
+	{ .dev_addr = 0x0, .phy_addr = 0x38000000, .size = 0x10000 },
+	{/* sentinel */}
+};
+
+static int stm32_rproc_tee_pa_to_da(struct rproc *rproc, phys_addr_t pa,
+				    size_t size, u64 *da)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	const struct stm32_rproc_tee_dma_ranges *range;
+	struct device *dev = rproc->dev.parent;
+
+	for (range = ddata->ranges; range->phy_addr; range++) {
+		if (pa < range->phy_addr ||
+		    pa >= range->phy_addr + range->size)
+			continue;
+		if (pa + size > range->phy_addr + range->size) {
+			dev_err(dev, "range too small for %pa+0x%zx\n", &pa, size);
+			return -EINVAL;
+		}
+		*da = pa - range->phy_addr + range->dev_addr;
+		dev_dbg(dev, "pa %pa to da %llx\n", &pa, *da);
+		return 0;
+	}
+
+	*da = pa;
+
+	return 0;
+}
+
+static int stm32_rproc_tee_mem_alloc(struct rproc *rproc,
+				     struct rproc_mem_entry *mem)
+{
+	struct device *dev = rproc->dev.parent;
+	void *va;
+
+	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
+	va = (__force void *)ioremap_wc(mem->dma, mem->len);
+	if (IS_ERR_OR_NULL(va)) {
+		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
+			&mem->dma, mem->len);
+		return -ENOMEM;
+	}
+
+	/* Update memory entry va */
+	mem->va = va;
+
+	return 0;
+}
+
+static int stm32_rproc_tee_mem_release(struct rproc *rproc,
+				       struct rproc_mem_entry *mem)
+{
+	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
+	iounmap((__force __iomem void *)mem->va);
+
+	return 0;
+}
+
+static int stm32_rproc_tee_mbox_idx(struct rproc *rproc, const unsigned char *name)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ddata->mb); i++) {
+		if (!strncmp(ddata->mb[i].name, name, strlen(name)))
+			return i;
+	}
+	dev_err(&rproc->dev, "mailbox %s not found\n", name);
+
+	return -EINVAL;
+}
+
+static void stm32_rproc_tee_request_shutdown(struct rproc *rproc)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	int err, idx;
+
+	/* Request shutdown of the remote processor */
+	if (rproc->state != RPROC_OFFLINE && rproc->state != RPROC_CRASHED) {
+		idx = stm32_rproc_tee_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
+		if (idx >= 0 && ddata->mb[idx].chan) {
+			err = mbox_send_message(ddata->mb[idx].chan, "detach");
+			if (err < 0)
+				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
+		}
+	}
+}
+
+static int stm32_rproc_tee_stop(struct rproc *rproc)
+{
+	stm32_rproc_tee_request_shutdown(rproc);
+
+	return rproc_tee_stop(rproc);
+}
+
+static int stm32_rproc_tee_prepare(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	struct device_node *np = dev->of_node;
+	struct rproc_mem_entry *mem;
+	int index = 0, mr = 0, nph;
+	u64 da;
+
+	nph = of_reserved_mem_region_count(np);
+	if (nph <= 0)
+		return 0;
+
+	/* Register associated reserved memory regions */
+	for (index = 0; index < nph; index++) {
+		struct resource res;
+		int ret;
+
+		ret = of_reserved_mem_region_to_resource(np, mr++, &res);
+		if (ret)
+			return ret;
+
+		if (stm32_rproc_tee_pa_to_da(rproc, res.start,
+					     resource_size(&res), &da) < 0) {
+			dev_err(dev, "memory region not valid %pR\n", &res);
+			return -EINVAL;
+		}
+
+		/* No need to map vdev buffer */
+		if (strstarts(res.name, "vdev0buffer")) {
+			/* Register reserved memory for vdev buffer alloc */
+			mem = rproc_of_resm_mem_entry_init(dev, index,
+							   resource_size(&res),
+							   res.start,
+							   "vdev0buffer");
+		} else {
+			/* Register memory region */
+			mem = rproc_mem_entry_init(dev, NULL,
+						   (dma_addr_t)res.start,
+						   resource_size(&res), da,
+						   stm32_rproc_tee_mem_alloc,
+						   stm32_rproc_tee_mem_release,
+						   "%.*s",
+						   (int)(strchrnul(res.name, '@') - res.name),
+						   res.name);
+			if (mem)
+				rproc_coredump_add_segment(rproc, da,
+							   resource_size(&res));
+		}
+
+		if (!mem)
+			return -ENOMEM;
+
+		rproc_add_carveout(rproc, mem);
+	}
+
+	return 0;
+}
+
+static irqreturn_t stm32_rproc_tee_wdg(int irq, void *data)
+{
+	struct platform_device *pdev = data;
+	struct rproc *rproc = platform_get_drvdata(pdev);
+
+	rproc_report_crash(rproc, RPROC_WATCHDOG);
+
+	return IRQ_HANDLED;
+}
+
+static void stm32_rproc_tee_mb_vq_work(struct work_struct *work)
+{
+	struct stm32_mbox *mb = container_of(work, struct stm32_mbox, vq_work);
+	struct rproc *rproc = dev_get_drvdata(mb->client.dev);
+
+	mutex_lock(&rproc->lock);
+
+	if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_ATTACHED)
+		goto unlock_mutex;
+
+	if (rproc_vq_interrupt(rproc, mb->vq_id) == IRQ_NONE)
+		dev_dbg(&rproc->dev, "no message found in vq%d\n", mb->vq_id);
+
+unlock_mutex:
+	mutex_unlock(&rproc->lock);
+}
+
+static void stm32_rproc_tee_mb_callback(struct mbox_client *cl, void *data)
+{
+	struct rproc *rproc = dev_get_drvdata(cl->dev);
+	struct stm32_mbox *mb = container_of(cl, struct stm32_mbox, client);
+	struct stm32_rproc_tee *ddata = rproc->priv;
+
+	queue_work(ddata->workqueue, &mb->vq_work);
+}
+
+static void stm32_rproc_tee_free_mbox(struct rproc *rproc)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ddata->mb); i++) {
+		if (ddata->mb[i].chan)
+			mbox_free_channel(ddata->mb[i].chan);
+		ddata->mb[i].chan = NULL;
+	}
+}
+
+static const struct stm32_mbox stm32_rproc_tee_mbox[MBOX_NB_MBX] = {
+	{
+		.name = STM32_MBX_VQ0,
+		.vq_id = STM32_MBX_VQ0_ID,
+		.client = {
+			.rx_callback = stm32_rproc_tee_mb_callback,
+			.tx_block = false,
+		},
+	},
+	{
+		.name = STM32_MBX_VQ1,
+		.vq_id = STM32_MBX_VQ1_ID,
+		.client = {
+			.rx_callback = stm32_rproc_tee_mb_callback,
+			.tx_block = false,
+		},
+	},
+	{
+		.name = STM32_MBX_SHUTDOWN,
+		.vq_id = -1,
+		.client = {
+			.tx_block = true,
+			.tx_done = NULL,
+			.tx_tout = 500, /* 500 ms time out */
+		},
+	},
+};
+
+static int stm32_rproc_tee_request_mbox(struct rproc *rproc)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	struct device *dev = &rproc->dev;
+	unsigned int i;
+	int j;
+	const unsigned char *name;
+	struct mbox_client *cl;
+
+	/* Initialise mailbox structure table */
+	memcpy(ddata->mb, stm32_rproc_tee_mbox, sizeof(stm32_rproc_tee_mbox));
+
+	for (i = 0; i < MBOX_NB_MBX; i++) {
+		name = ddata->mb[i].name;
+
+		cl = &ddata->mb[i].client;
+		cl->dev = dev->parent;
+
+		ddata->mb[i].chan = mbox_request_channel_byname(cl, name);
+		if (IS_ERR(ddata->mb[i].chan)) {
+			if (PTR_ERR(ddata->mb[i].chan) == -EPROBE_DEFER) {
+				dev_err_probe(dev->parent,
+					      PTR_ERR(ddata->mb[i].chan),
+					      "failed to request mailbox %s\n",
+					      name);
+				goto err_probe;
+			}
+			dev_info(dev, "mailbox %s mbox not used\n", name);
+			ddata->mb[i].chan = NULL;
+		}
+		if (ddata->mb[i].vq_id >= 0) {
+			INIT_WORK(&ddata->mb[i].vq_work,
+				  stm32_rproc_tee_mb_vq_work);
+		}
+	}
+
+	return 0;
+
+err_probe:
+	for (j = i - 1; j >= 0; j--)
+		if (ddata->mb[j].chan) {
+			mbox_free_channel(ddata->mb[j].chan);
+			ddata->mb[j].chan = NULL;
+		}
+	return -EPROBE_DEFER;
+}
+
+static void stm32_rproc_tee_kick(struct rproc *rproc, int vqid)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	unsigned int i;
+	int err;
+
+	if (WARN_ON(vqid >= MBOX_NB_VQ))
+		return;
+
+	for (i = 0; i < MBOX_NB_MBX; i++) {
+		if (vqid != ddata->mb[i].vq_id)
+			continue;
+		if (!ddata->mb[i].chan)
+			return;
+		err = mbox_send_message(ddata->mb[i].chan, "kick");
+		if (err < 0)
+			dev_err(&rproc->dev, "%s: failed (%s, err:%d)\n",
+				__func__, ddata->mb[i].name, err);
+		return;
+	}
+}
+
+static int stm32_rproc_tee_parse_dt(struct platform_device *pdev,
+				    struct stm32_rproc_tee *ddata,
+				    bool *auto_boot)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int err, irq;
+
+	/*
+	 * remoteproc-backend = <&sproc N>;
+	 *   args.np   : backend node
+	 *   args.args[0] : remote processor identifier used by TEE
+	 */
+	err = of_parse_phandle_with_fixed_args(np, "rproc-tee-phandle",
+					       1, 0, &ddata->tee_phandle);
+	if (err) {
+		dev_err_probe(dev, err,
+			      "failed to parse remoteproc-backend (%d)\n", err);
+		return err;
+	}
+
+	of_node_put(ddata->tee_phandle.np);
+
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
+	if (irq > 0) {
+		err = devm_request_irq(dev, irq, stm32_rproc_tee_wdg, 0,
+				       dev_name(dev), pdev);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "failed to request wdg irq\n");
+
+		ddata->wdg_irq = irq;
+
+		if (of_property_read_bool(np, "wakeup-source")) {
+			device_init_wakeup(dev, true);
+			dev_pm_set_wake_irq(dev, irq);
+		}
+
+		dev_info(dev, "wdg irq registered\n");
+	}
+
+	*auto_boot = of_property_read_bool(np, "st,auto-boot");
+
+	return 0;
+}
+
+static int stm32_rproc_tee_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_rproc_tee *ddata;
+	struct rproc *rproc;
+	bool auto_boot;
+	int ret;
+
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ret = stm32_rproc_tee_parse_dt(pdev, ddata, &auto_boot);
+	if (ret)
+		return ret;
+
+	ret = rproc_tee_register(dev, &rproc, &ddata->tee_phandle, auto_boot);
+	if (ret)
+		return dev_err_probe(dev, ret, "signed firmware not supported by TEE\n");
+
+	rproc->ops->prepare = stm32_rproc_tee_prepare;
+	rproc->ops->stop = stm32_rproc_tee_stop;
+	rproc->ops->kick = stm32_rproc_tee_kick;
+
+	ddata = rproc->priv;
+
+	ddata->ranges = device_get_match_data(&pdev->dev);
+
+	rproc->has_iommu = false;
+	ddata->workqueue = create_workqueue(dev_name(dev));
+	if (!ddata->workqueue) {
+		dev_err(dev, "cannot create workqueue\n");
+		ret = -ENOMEM;
+		goto free_resources;
+	}
+
+	platform_set_drvdata(pdev, rproc);
+
+	ret = stm32_rproc_tee_request_mbox(rproc);
+	if (ret)
+		goto free_wkq;
+
+	return 0;
+
+free_wkq:
+	destroy_workqueue(ddata->workqueue);
+free_resources:
+	rproc_resource_cleanup(rproc);
+	if (device_may_wakeup(dev)) {
+		dev_pm_clear_wake_irq(dev);
+		device_init_wakeup(dev, false);
+	}
+	rproc_tee_unregister(dev, rproc);
+
+	return ret;
+}
+
+static void stm32_rproc_tee_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	struct device *dev = &pdev->dev;
+
+	stm32_rproc_tee_free_mbox(rproc);
+	destroy_workqueue(ddata->workqueue);
+
+	if (device_may_wakeup(dev)) {
+		dev_pm_clear_wake_irq(dev);
+		device_init_wakeup(dev, false);
+	}
+
+	rproc_tee_unregister(dev, rproc);
+}
+
+static int stm32_rproc_tee_suspend(struct device *dev)
+{
+	struct rproc *rproc = dev_get_drvdata(dev);
+	struct stm32_rproc_tee *ddata = rproc->priv;
+
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(ddata->wdg_irq);
+
+	return 0;
+}
+
+static int stm32_rproc_tee_resume(struct device *dev)
+{
+	struct rproc *rproc = dev_get_drvdata(dev);
+	struct stm32_rproc_tee *ddata = rproc->priv;
+
+	if (device_may_wakeup(dev))
+		return disable_irq_wake(ddata->wdg_irq);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_rproc_tee_pm_ops,
+				stm32_rproc_tee_suspend, stm32_rproc_tee_resume);
+
+static const struct of_device_id stm32_rproc_tee_match[] = {
+	{
+		.compatible = "st,stm32mp1-m4-tee",
+		.data = &stm32mp15_m4_dma_ranges,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_rproc_tee_match);
+
+static struct platform_driver stm32_rproc_tee_driver = {
+	.probe = stm32_rproc_tee_probe,
+	.remove = stm32_rproc_tee_remove,
+	.driver = {
+		.name = "stm32-rproc-tee",
+		.pm = pm_ptr(&stm32_rproc_tee_pm_ops),
+		.of_match_table = stm32_rproc_tee_match,
+	},
+};
+module_platform_driver(stm32_rproc_tee_driver);
+
+MODULE_DESCRIPTION("STM32 Remote Processor TEE Control Driver");
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>");
+MODULE_LICENSE("GPL");
+
-- 
2.43.0

