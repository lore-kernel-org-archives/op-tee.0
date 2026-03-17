Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EE1FED9FD
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 18:06:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A289B43AAB
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 18:06:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RC9tDNRu;
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EBB8243A9D
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Mar 2026 18:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVxK2GmIC2Hiy+Ic1OMiXl4sI64Di/q92vx9yltwLuoFMPv8VpD20IfaLYA2QRlRK09oO/uQXI0H0XKrbvzN3dyvOgfDKcgwEcUoJwq8Nyk9P20J7GrJphuqOOPXomvs/LLLks6bollMZH+PNJl89ak7F8BDFh+DoeQmTaplAf4v2usaZL0LFI7eBBDGYOhd/wuJ7if5ctL0G5fwXhTaOT42/lVQ0AhgosNapfZXKJtwrO0Jwu6Q7quketMMUPRm+DsJvKEzoZ/pQ9LPV1Gtrl+ceQvmwO0FTOAYJjGxfhVUdnpkZXv+M5f1DLHB488yldpBeG9mMn82FkvW5jS51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmoFW7AW1ts8pQm2OeeMK1W6aYEUZbml9AF8+fhKeuQ=;
 b=RJNew9npiVNRDdz/hadCW5vvWpljlhpLnEw727X7zsJDdZxZJ8axxcBbo5kr2svOiv38pcWcPpTZIVQTTe61Xk9qtAcSYGL6ywXsqc1IDQUkONBvKnMb7aL6/MmgMBZtSY4GN96VkacwPaZ/H4hoIpjEGlnTY5wwPTQUBVTvBE+Y0Eav/7rGsGJlcv/wVq5B+kJnO+yk6sCejhceLcyJ5704SXKpWwjUJ3xt0eZc3ZDaZTQJutOP4eI2nsMu10sC1uF/+u+Gm0g76pyDIf5F4VZetIoP4QlTxGfkBb3QynMfjD+RdG1VUTDRe9pcZQUiyt1TfyBmAX9mukiACHzV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmoFW7AW1ts8pQm2OeeMK1W6aYEUZbml9AF8+fhKeuQ=;
 b=RC9tDNRuzEsd9rlg6NTxFYO7gECW+lUDBixI9m/ed+io2MSfID3TTjxqdIf+aAtXlTZSsrQfIEjC6bxt+2NKmAPWEULqiKZlucL9yojB7/092Z6Zk7faT6EIF1kDXlrfoeKeSS/ncep16gTP7TPRQUUjSs8/tZucJsvnI0xzpByab5rhlpLMVCFWBV560whjxRwKpo07Hu3WQsvAiYYlpSrTw1sewK9I4ylCRuJDUeO1PMbX+ROscbcO2kBkL8wiRR81DrGFTADCz2OIyZWCs7S3bG3LL0bzhSBG+ua3I91GgpCEhM1XBLo8LqMYgb8ZmWbDeH+joYz+3hZSnjKJhA==
Received: from AM9P250CA0009.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::14)
 by AS8PR10MB7184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 18:03:52 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:21c:cafe::73) by AM9P250CA0009.outlook.office365.com
 (2603:10a6:20b:21c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 18:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 18:03:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:06:09 +0100
Received: from localhost (10.252.21.194) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:03:51 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v21 3/6] remoteproc: core: Introduce rproc_pa_to_va helper
Date: Tue, 17 Mar 2026 19:03:24 +0100
Message-ID: <20260317180329.1207625-4-arnaud.pouliquen@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|AS8PR10MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: efb172cd-1bf4-49ae-83d6-08de844f8c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	VkwYpA+j9Pxq5U0LuNz8FpasyG1G6To0yYCY62+wXTHLHKrl0fHbdrFW+URLDsk6dM7ApTzOa6KBOpoZEL5iYU9i3fv8xe2lVf+UDdeiQ9sGBOz1XLNdOgsyyWocvbI8om4hOMDPzNtV7oAGCif+1GWsFnBt9y67HW+AaEoxdeYPpVG6I6zCVFGve7ItjWYYbgyIC70wYm1migoLF5kF8Lj7ePi2Dpmmwx0PgugXoaSgYr2LsKQDYUeHtV6BnDOpmkqkykpprL9zlK+n8Tl5SVGxL6URFOxWkOlOvN8V4VH4bjJJWi7sW945H7afnLsVdOmU4+WJ8e52Kw1o9S/DhwIrMGZz9DqlbWAaRYap+S8D6n8Ci61RBVk0cmNUrZv44+Qrifi351hKGlU4/919HzkdmoFn1L4ZKKjN/NYnk7mkGACiO07J9648xnlKRXn2OHZ2B8kOZPjCnsFPsY5yfV5hFpCp1nQNbqXgTXg9ogw59YdjPSlc/Zjsqr+8b01Qy8JUlFmqzyyjJ5hWR1az5oTNy+zK8Tk62roI6lJxgoNcs7Rp0Rs3dPtzzE+P2yKS1nV7N3G9Dz9w9sqfyugUp4Ws2BclXAWe3E68MZ63wTfUqwRoNIB6X7yGLKrzdJL+eGUYCK2l0qUZuHD7n2CUGllhdfxDPfCeOX/2RIHxFZInoJy/1sjvkAh7bLasbeUkxdoiLXrC0Y6iwVZepuhCQxEZ+0KfAjhAQL1Z/qBycpKie3XGuEz9FZBLBg0ZxLQgpDPEEhPuIxsuKHYvLQIIjQ==
X-Forefront-Antispam-Report: 
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CXaRWtz9n0YxoHB6hAVzk9TIY5gC34Fj1ohIgNzUmtRSEpaBLIsqNyiTlbEO5Q+A4xCrqGu05ZvGfEFxZ9AzRpy83j5CY38iQ+PZa4CxD7Avkc58R+59YjeLkmQ8aUyKUxYyDYtSoeGzTDxHd2QCamKhC6tkzcXl2cQ9c3qPa0XCITnGwp35TZhNn1tHUy22OG5hSCUcDdI5080RXM2o2oNLniWrqiVYcc/nTY0tS7tBUkci7OsRAaOpe2xQTIaw8x5fqnG7Zfipbzfz6Y2pn1BR7bXu3FRDqxtOWgxxIutxdCkoeDh4LrXkYPx9JzhmYSEaX4S9PTG84NCWA+mYrjmxyuFxtYbwJSgpegsQ+G7TjAp1qjNx31gn+ST2RcqEn1I0Cv41iggfHHGCFPCwzCDeahTbaYtCagySNJs1cT0NfC24wtbpb9uQHnvzcsH6
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:03:51.9693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb172cd-1bf4-49ae-83d6-08de844f8c13
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7184
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
	RCVD_IN_DNSWL_NONE(0.00)[52.101.72.39:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:21c:cafe::73:received];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.72.39:from];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EBB8243A9D
X-Spamd-Bar: --
Message-ID-Hash: NWGXMKPVECL5VGIFO2NFNMOJ4R4L2ZBO
X-Message-ID-Hash: NWGXMKPVECL5VGIFO2NFNMOJ4R4L2ZBO
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NWGXMKPVECL5VGIFO2NFNMOJ4R4L2ZBO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

When a resource table is loaded by an external entity such as U-boot or
OP-TEE, we do not necessarily get the device address(da) but the physical
address(pa).
This helper performs similar translation than the rproc_da_to_va()
but based on a physical address.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 46 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index b087ed21858a..a44c8039449d 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -225,6 +225,52 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 }
 EXPORT_SYMBOL(rproc_da_to_va);
 
+/**
+ * rproc_pa_to_va() - lookup the kernel virtual address for a physical address of a remoteproc
+ * memory
+ *
+ * @rproc: handle of a remote processor
+ * @pa: remoteproc physical address
+ * @len: length of the memory region @pa is pointing to
+ * @is_iomem: optional pointer filled in to indicate if @da is iomapped memory
+ *
+ * This function is a helper function similar to rproc_da_to_va() but it deals with physical
+ * addresses instead of device addresses.
+ *
+ * Return: a valid kernel address on success or NULL on failure
+ */
+void *rproc_pa_to_va(struct rproc *rproc, phys_addr_t pa, size_t len, bool *is_iomem)
+{
+	struct rproc_mem_entry *carveout;
+	void *ptr = NULL;
+
+	list_for_each_entry(carveout, &rproc->carveouts, node) {
+		int offset = pa - carveout->dma;
+
+		/*  Verify that carveout is allocated */
+		if (!carveout->va)
+			continue;
+
+		/* try next carveout if da is too small */
+		if (offset < 0)
+			continue;
+
+		/* try next carveout if da is too large */
+		if (offset + len > carveout->len)
+			continue;
+
+		ptr = carveout->va + offset;
+
+		if (is_iomem)
+			*is_iomem = carveout->is_iomem;
+
+		break;
+	}
+
+	return ptr;
+}
+EXPORT_SYMBOL(rproc_pa_to_va);
+
 /**
  * rproc_find_carveout_by_name() - lookup the carveout region by a name
  * @rproc: handle of a remote processor
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b4795698d8c2..8fd0d7f63c8e 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -690,6 +690,7 @@ int rproc_detach(struct rproc *rproc);
 int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
+void *rproc_pa_to_va(struct rproc *rproc, phys_addr_t pa, size_t len, bool *is_iomem);
 
 /* from remoteproc_coredump.c */
 void rproc_coredump_cleanup(struct rproc *rproc);
-- 
2.43.0

