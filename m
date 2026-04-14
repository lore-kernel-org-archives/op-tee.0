Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5B9F9D0D5
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:44:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 18B0E44A2B
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:44:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Gz5ag2Dj;
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5796A44402
	for <op-tee@lists.trustedfirmware.org>; Tue, 14 Apr 2026 15:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqqjPBbAFx9d0p8cV7bcxPCrIEDYAMI2gycPsz+hv03oyDEE+PNNkI+yps/j5lDD1xOG1aSIKg7ToLIhTWtRDTMsnDHKGmLy9wi/I87oMooRPDNwGkMW3LZ5yhYQj9ojWWJEANdvcU2ru6d2B5lTzNkoU9hknYalWX9eDBp7VC+H+CKr8euysWzavhvV2xKYVfO8bJa65aQE02c9aTXNj9MiHgAxLvmMPqGd5mkqfy338FWFegM0Q4Xgevjm6pB9Vv7E2VJHuPL1VXAF/P5nQ5VcCzwDH2YJXFWaBLgKVhRj2x5Lo5KodLkg9Fx6BMWmwDupv8+8Y8yAO1qIx3q9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsZA2EnshfnaacFfzKboi8kXs1ZJm3gOYoQM5LUOrKY=;
 b=NGZRjFFeUYFfpO2nD3Z969jYQhSrn02H3/OoE9jr+vy7y7IkmUu3m3EFJlJ/I0V8blLkL/Bi826DrlI1GpifDuqQS0SWiIMiktFGV/uPCI1lO7Zn+99/C6bkFk5uSNCUQROlYaDquJhswUjyB4QzMv1AjXu9AzaykJuDajRQc+JTl76tRtBtkx7qynYqqTQkWtOcNNLn5iLdGXnWvHvVJvYzdxh1ZhfpVZBL2nvlfaIhKbQSmF3AmJbHPWM7/5WncBEzpygc8piiFp/mSas9I9EM2H0C/cpW3A/EvVyq+lMyD24FUerYOiULDeDqDBpWpoVn3NIRaMsXEjihEuCu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsZA2EnshfnaacFfzKboi8kXs1ZJm3gOYoQM5LUOrKY=;
 b=Gz5ag2DjWxxCdeqxG/GmKegEzRXY5lXntusxpfwyGpa4VMmhl52zWkSLaUGRCiSDO28tgNgoAwnDnZhT4r9DJXpNZQwCffOnq1KSpQ+h5SWGXw5WYs3qJRpmFF7ijDPMX4CrqZ45nxVXOgSyq0IxpjkRVb16ca4yeiW2upryasF3cZLUht3kDn1wWdRKOn+mCKcTJ+6t7c3hNgdViQ8h3rxQySg6FluGMOahsvFPGsyxIx6VY/rOevWd7sBg5s8mbM6HwayC2f7wpGUv1ogHIvAXkCKz1+SNmhac7ABbxWx0IMMOm2T3jjjwh429qp5olmEdAHM4OHpsmVVfGHxRxQ==
Received: from DU2P250CA0021.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::26)
 by DU0PR10MB6020.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:29:19 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::2a) by DU2P250CA0021.outlook.office365.com
 (2603:10a6:10:231::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 15:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 15:29:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:32:28 +0200
Received: from localhost (10.252.12.46) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:29:18 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v22 4/7] remoteproc: Introduce optional release_fw operation
Date: Tue, 14 Apr 2026 17:28:59 +0200
Message-ID: <20260414152904.1679724-5-arnaud.pouliquen@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|DU0PR10MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 362f149b-3e26-41a0-a58e-08de9a3a98cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	iyZTotZBS/maypsy/w9+gwU1cyxPCHjBEOA93tWDznNStAiXyeall3F+aAz305En57a0v73HNO2UCSc67T24Gndgmw9ZNvTJ3dmE29jPzyOQ2NPUjmeqDNpBkuWHhKgxWzeaUMa5ChxHgZlCebfR/DUx6filZ5SF2XM1Q5oiJ+QBwrSNnv31Zd2zrMOdY/TUUPv0i+V9SnOAuCGzTCsHfL59z58eSCPDbI0PFEcxeT43wpjDZkmDgNJh714RlH4FTc2PxxeAC/SibloCZMedOp7bqyECMVxfBZNeHMZb9ksrT8CnewWV1yH3wFchYYMLpSqLAIdhRJnxkZCJAlR0hl0UjvRHdss/77WQ+8UPOePnoHtz+VYDlJsWZAgxx5OZwWVvIyIrcK2zB7Dt+pPshS1RabBRUPK/JadtK+akKOVstdQDU103k6uu4TIqbHsWwzzbxeBwBEeHIHdebCodOLqRJRPVUKQgNoObkXC2PQptpLf0Zlw+XIrsH56fc6guL4mjmzzWd6O11tKE+uivw0K8Cng02N3jKPln3NAtkY0uqJPNa5YpY98zjwRo/XuyBxZ+g4Vb94XE9Ai8vuSfjOal96MSSmDn384KKZH510nyuMyLlxGu6/wYUYHAKjjMxT1cv7ubVCaKotiR55UiSuNU19llYs2rVTrzPbpuNeFdfnlqHeJkwiQhNTMboNiV1aWigXemjQxtJnwve3ps2UvdfXxA/jYncahwZ0OWPJ/VRCF4rmNOP/rHFaSxzMT+I1nBfDFxSlg8qd8J0GTzCw==
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	1ClBhaudzeOhcoIMDD8O8j/GrONHdJXPCdlvztLiUsp8jU8jDVRXgqc5E+42OyP9KZgg2iiGWXg6hGPukTjzqjoukLDCjfH53SBAdiF3H8w6pe9gXzdlT7WZSaMeHZs2vUk++H94IuEXzhSQPKNYh4LlX76C+6Uc3xa95mSc245J+FB4XwZ1GQZJheOshG1vu0lzEc+ujSaJPQLmPYQ/n0muLLA7wGlvuRztRvo8BagzPrRgd3nHL46+fF4irN9Mqeg4guoRfdeCcRgcOyklLPJ7NbNVotwtAq8SbvhxH35ctdXUPQFs+qQ3MicaW3NtP2JlgCLhMdWvpiTLwFGppSea2QZAOuaxT5S45eirMKji2sGkdkypxQJ9Y63pMZrJ5um7f95X4Mj5/umcbOYqlsrYgpq4w2pBxEO+lA06Lm0TUIYdIIJ9AyLlRs+uFdWT
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:29:19.4550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362f149b-3e26-41a0-a58e-08de9a3a98cf
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6020
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.65.41:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:10:231::26:received];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.65.41:from];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5796A44402
X-Spamd-Bar: --
Message-ID-Hash: U7A2WY47KYURQB722SRXSZDT43XACPQ5
X-Message-ID-Hash: U7A2WY47KYURQB722SRXSZDT43XACPQ5
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U7A2WY47KYURQB722SRXSZDT43XACPQ5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

The release_fw operation allows releasing remote processor resources
configured during rproc_parse_fw() and rproc_load_segments().
For example, it can release carveouts mapped during these operations.

This operation is invoked in the following cases:
 - When an error occurs during remote processor boot.
 - When an error occurs during remote processor recovery start.
 - After stopping the remote processor.

This operation is required for the remoteproc_tee implementation following
a stop or upon encountering an error. Since the remoteproc image is loaded
during resource table parsing, multiple failure scenarios may occur prior
to remote processor startup, including issues with resource handling and
carveout allocation.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

---

Updates from version 18:
- Rewrite rproc_ops::release_fw documentation
- Improve commit message

Updates from version 16:
- Removed the rproc:load_fw() ops introduced in previous version.
- Removed duplicate calls to rproc_release_fw in rproc_fw_boot and rproc_boot.
---
 drivers/remoteproc/remoteproc_core.c     | 6 ++++++
 drivers/remoteproc/remoteproc_internal.h | 6 ++++++
 include/linux/remoteproc.h               | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ec1860e1cfa9..93ab505ff014 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1856,6 +1856,8 @@ static int rproc_boot_recovery(struct rproc *rproc)
 
 	/* boot the remote processor up again */
 	ret = rproc_start(rproc, firmware_p);
+	if (ret)
+		rproc_release_fw(rproc);
 
 	release_firmware(firmware_p);
 
@@ -1997,6 +1999,8 @@ int rproc_boot(struct rproc *rproc)
 		}
 
 		ret = rproc_fw_boot(rproc, firmware_p);
+		if (ret)
+			rproc_release_fw(rproc);
 
 		release_firmware(firmware_p);
 	}
@@ -2066,6 +2070,8 @@ int rproc_shutdown(struct rproc *rproc)
 
 	rproc_disable_iommu(rproc);
 
+	rproc_release_fw(rproc);
+
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 0cd09e67ac14..c7fb908f8652 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -221,4 +221,10 @@ bool rproc_u64_fit_in_size_t(u64 val)
 	return (val <= (size_t) -1);
 }
 
+static inline void rproc_release_fw(struct rproc *rproc)
+{
+	if (rproc->ops->release_fw)
+		rproc->ops->release_fw(rproc);
+}
+
 #endif /* REMOTEPROC_INTERNAL_H */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 8fd0d7f63c8e..a2bb51a113b1 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -381,6 +381,10 @@ enum rsc_handling_status {
  * @panic:	optional callback to react to system panic, core will delay
  *		panic at least the returned number of milliseconds
  * @coredump:	  collect firmware dump after the subsystem is shutdown
+ * @release_fw:	Optional function to release resources allocated during
+ *		parse_fw() or load() operations. This function is called after
+ *		stopping the remote processor or in case of an error during the
+ *		boot or recovery sequence.
  */
 struct rproc_ops {
 	int (*prepare)(struct rproc *rproc);
@@ -403,6 +407,7 @@ struct rproc_ops {
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
 	unsigned long (*panic)(struct rproc *rproc);
 	void (*coredump)(struct rproc *rproc);
+	void (*release_fw)(struct rproc *rproc);
 };
 
 /**
-- 
2.43.0

