Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640E7F9D0D5
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:44:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B898644A2B
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:44:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RB0yKKbA;
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8193344B10
	for <op-tee@lists.trustedfirmware.org>; Tue, 14 Apr 2026 15:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro+6cFCnzubnzn2HDYhevXwc+YsgsJPG6fZlV5RKpY8yqV/zkig+k3bpe18HpZOOAHCt0TVaznKsq1qWbOVEIMX0kQh5ZC8h4V3LrnJnmxRJ64B0E+llzO/FkDDois9tqnBpBLnItZ7Q8dOPxyFed4NUxSQVHvbxZuhmTy2iHNFUdjVVYAnBFh4JiYe+29qLjjzaIKyZiIwhEUSQ3iCQvDwdrOux/60DbA4jQnB4lH4b9weZXUxc840hERBvMfepjT19UarVOVv70LsyltObducsKxuXQS6NJc5O0BFn0xVkD9aR4jFZN4C6FwQGLv7qOKM9Uzti1LU030VpMbtp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v1BKn4m0w5IBXYvMyQCy1dPiGTZV2n/1sA15+aXp0A=;
 b=FUwdx6LLhHNjFr/uYP9uRz+z1K/L9Fb4M8U/LF/NpIxgPsyjmgm+pwbrTaBwKAhval19487CTtVO1TgOdNxYGfLY8hrreHhGaSbpVRktLgIBVAaf9eTh6vzLOobsa75PCV+LEgE8EQFeuTZesJyE8e+wF7mQ4qsPIXvBbU5hBblJFNW6ZKU9v3OwvCxHmTUiKh3NBf0yYtVRbPwV0CcdgDkog+Csn5XUJHi/sY/fBx0CTQ1v4lRABcHV0jgeL0JlJ7WM0lf50VJeQeU1vrKiMoaKrnYc7XcLqthkMQRaPFUo+mM+nJwfIVvgTAMEO3S3d3zgiv/f1CFs9xbRtSqPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v1BKn4m0w5IBXYvMyQCy1dPiGTZV2n/1sA15+aXp0A=;
 b=RB0yKKbAN75v5bThHNN3CKkJuor0ARZdXyvn1ZWy/XW8W28RWePinNm7hcMV+g0QwUJHW9wK++YJrHnJlHGQxqS8JtGlUFDSRtK9lSM7GPHHGR/FfSjNDHd5uThL7QMNjddRdK4KXCi7Ek3sS+3Jjcfcsv0nkdM00nmRRuHbXjKHdbPLRabB08CLQ1SCAGGc5SeXAy1i9fsp7AAoJAL0FKEfMQVRNcRixdFDIEuSwjld/y/Ds5KKq3u4VQ7VE4wFnqncpg655rwJc6DfqQZu6iq+bsGiJzcs6udKfmAWomA5p3pV6XGq5Mn1UG0+mMdZzdSBjMmQ0LmK10XyJuogtw==
Received: from DB9PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::19) by GV2PR10MB6984.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:29:22 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::11) by DB9PR01CA0014.outlook.office365.com
 (2603:10a6:10:1d8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 15:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 15:29:22 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:32:10 +0200
Received: from localhost (10.252.12.46) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:29:21 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v22 7/7] remoteproc: stm32: add OP-TEE backend support
Date: Tue, 14 Apr 2026 17:29:02 +0200
Message-ID: <20260414152904.1679724-8-arnaud.pouliquen@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|GV2PR10MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ebd6cc-32bc-49f4-d588-08de9a3a9a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
 OYdFlAirwSxnw/YprOHRkaRNlohk1HzjXuryitTJz/EzQ012eHQSi4qju54OJnLD1ahsoRtaJuhRWbIOgZSrv5uDqKXEqRODxVceRzs4EYtHmUvPSyM9Cjv4Gf8Ju08zq6m0usX5cqLD3Q4+68fKagoIkdviZ+qXLK7jQOXEWsszxUj9EV/pKgh3SR5Fep5HDVy5fo3h7D6loaIBRep546V/6pSLVAvk6YzHh+bwhlQLTkGZT1BAX5FaCV4fNRXvKROHw73Ong4a42la6HpaZhjFqx0l4n1JE0S9F5w9VmVCW9z7sTTuXkUySlYEZ12MeV7CY6GoDg/9wXNLEW68JCjm2+bpJsDRxfYk7mTKAd/3t03E97yH+ceSob+a01FAhVqM+cVukwZJoKRB3tM6vtbuvLQNNV/kUnSHRiVK/HNBUsJvOE9lTwjRNyQAs9OTmtpeglu17Pl0VNLOJmGFOZwu2J+HEfEZkI7LuMwsZWElY/gPdKVCobKKnI68l6FROB0cXrshxEh7IqcesqJ0ODlwia6tmR7vPvloHxYBKGwa0s4xnIcoLnF649/a0QZhkvAZ+dX1T+tMMN8UZnGvmBttfbxgKR+Mg6WWYcS8ym2G1VhRyga5mqwzCzk+mzBlEKDgIc8g11Z+SgMoT6NFApCyZL10MCDYgzDwlxCoei7jT53fAHEXWER7cMCnab1WiXwnNPDg+hc9G9eYi4eirLvlQicMWpe821pVN3t3uYIeQ78TKu6JXBBAXBYEGQAs5GHMtVERPXbyk2p/1lwAjg==
X-Forefront-Antispam-Report: 
 CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 LP4OvrTADXMWAbkkbC+EfZsPYiCe7fRpsRpj/vptf9OFP42vymYIqv1Owym0LBmHyVr9c5eDDrejraAUeo/TsJ+q06Jdp3pxxTGtc4D6wfytRR268DGEtb18SX3++oa6pDtAC9C7fP85h96mjJCZaWythgvT4Cxdc8JbmuH23OehIz4FRF1z2RBTROZEXEzG8t7kG0rykRq16VWG6vNdw/zn7w9f5xYpETCb7893rvpVllpAsKbzokl0UI1OzUbhqEljUI1Wypn2Gh+0JbHcgpSTazxonwXMHNLvfnmZxboct3B0yoEFjG3lNqipuuTM6RjfygK44AXAaMeEI2gFKrQAqNFL264GUXSHGvpx937CA+O+sXufL1beas/WZKs9S47Hlc0llFc5zxvua6fnTFUZoZbCHo3qrdV5L6S4NduiRdJXzRf2AP1Ec2NlyDIS
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:29:22.2910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ebd6cc-32bc-49f4-d588-08de9a3a9a7f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6984
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
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.72.65:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.72.65:from];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8193344B10
X-Spamd-Bar: --
Message-ID-Hash: GFV6GBDYLRPXENTUDXDB2RC73LTA5MXF
X-Message-ID-Hash: GFV6GBDYLRPXENTUDXDB2RC73LTA5MXF
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GFV6GBDYLRPXENTUDXDB2RC73LTA5MXF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Integrate OP-TEE-controlled firmware loading into stm32_rproc
adding support for the st,rproc-tee devicetree property.

When st,rproc-tee is present, the driver:
- parses the backend phandle + ID from DT and validates it
- uses the remoteproc_tee operation set and registration path
- keeps reset/holdboot handling only for the non-TEE case
- uses a TEE-specific flow.

Notice that the attach/detach is not yet supported and should be part
of a separate patchset.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
V21 updates:
- reapply the V19 patch as the stm32_rproc-tee  driver can no more
  be used.
- update v19 patch to support the st,rproc-tee phandle.
- rework the commit message.
---
 drivers/remoteproc/stm32_rproc.c | 167 +++++++++++++++++++++++--------
 1 file changed, 123 insertions(+), 44 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 4bcd6a784935..61d89f3a78b1 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -18,6 +18,7 @@
 #include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
+#include <linux/remoteproc_tee.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
@@ -89,6 +90,7 @@ struct stm32_rproc {
 	struct stm32_rproc_mem *rmems;
 	struct stm32_mbox mb[MBOX_NB_MBX];
 	struct workqueue_struct *workqueue;
+	struct of_phandle_args tee_phandle;
 	bool hold_boot_smc;
 	void __iomem *rsc_va;
 };
@@ -255,6 +257,19 @@ static int stm32_rproc_release(struct rproc *rproc)
 	return 0;
 }
 
+static int stm32_rproc_tee_stop(struct rproc *rproc)
+{
+	int err;
+
+	stm32_rproc_request_shutdown(rproc);
+
+	err = rproc_tee_stop(rproc);
+	if (err)
+		return err;
+
+	return stm32_rproc_release(rproc);
+}
+
 static int stm32_rproc_prepare(struct rproc *rproc)
 {
 	struct device *dev = rproc->dev.parent;
@@ -683,6 +698,17 @@ static const struct rproc_ops st_rproc_ops = {
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
 
+static const struct rproc_ops st_rproc_tee_ops = {
+	.prepare	= stm32_rproc_prepare,
+	.start		= rproc_tee_start,
+	.stop		= stm32_rproc_tee_stop,
+	.kick		= stm32_rproc_kick,
+	.load		= rproc_tee_load_fw,
+	.parse_fw	= rproc_tee_parse_fw,
+	.find_loaded_rsc_table = rproc_tee_find_loaded_rsc_table,
+	.release_fw	= rproc_tee_release_fw,
+};
+
 static const struct of_device_id stm32_rproc_match[] = {
 	{ .compatible = "st,stm32mp1-m4" },
 	{},
@@ -716,6 +742,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct of_phandle_args tee_phandle;
 	struct stm32_syscon tz;
 	unsigned int tzen;
 	int err, irq;
@@ -741,51 +768,69 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 		dev_info(dev, "wdg irq registered\n");
 	}
 
-	ddata->rst = devm_reset_control_get_optional(dev, "mcu_rst");
-	if (!ddata->rst) {
-		/* Try legacy fallback method: get it by index */
-		ddata->rst = devm_reset_control_get_by_index(dev, 0);
+	if (of_find_property(np, "st,rproc-tee", NULL)) {
+		err = of_parse_phandle_with_fixed_args(np, "st,rproc-tee",
+						       1, 0, &tee_phandle);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "failed to parse st,rproc-tee\n");
+
+		if (!IS_ENABLED(CONFIG_REMOTEPROC_TEE)) {
+			of_node_put(tee_phandle.np);
+			return dev_err_probe(dev, -ENODEV,
+					     "st,rproc-tee requires REMOTEPROC_TEE support\n");
+		}
+
+		ddata->tee_phandle = tee_phandle;
 	}
-	if (IS_ERR(ddata->rst))
-		return dev_err_probe(dev, PTR_ERR(ddata->rst),
-				     "failed to get mcu_reset\n");
 
-	/*
-	 * Three ways to manage the hold boot
-	 * - using SCMI: the hold boot is managed as a reset
-	 *    The DT "reset-mames" property should be defined with 2 items:
-	 *        reset-names = "mcu_rst", "hold_boot";
-	 * - using SMC call (deprecated): use SMC reset interface
-	 *    The DT "reset-mames" property is optional, "st,syscfg-tz" is required
-	 * - default(no SCMI, no SMC): the hold boot is managed as a syscon register
-	 *    The DT "reset-mames" property is optional, "st,syscfg-holdboot" is required
-	 */
+	if (!ddata->tee_phandle.np) {
+		ddata->rst = devm_reset_control_get_optional(dev, "mcu_rst");
+		if (!ddata->rst) {
+			/* Try legacy fallback method: get it by index */
+			ddata->rst = devm_reset_control_get_by_index(dev, 0);
+		}
+		if (IS_ERR(ddata->rst))
+			return dev_err_probe(dev, PTR_ERR(ddata->rst),
+					"failed to get mcu_reset\n");
 
-	ddata->hold_boot_rst = devm_reset_control_get_optional(dev, "hold_boot");
-	if (IS_ERR(ddata->hold_boot_rst))
-		return dev_err_probe(dev, PTR_ERR(ddata->hold_boot_rst),
-				     "failed to get hold_boot reset\n");
+		/*
+		 * Three ways to manage the hold boot
+		 * - using SCMI: the hold boot is managed as a reset
+		 *    The DT "reset-mames" property should be defined with 2 items:
+		 *        reset-names = "mcu_rst", "hold_boot";
+		 * - using SMC call (deprecated): use SMC reset interface
+		 *    The DT "reset-mames" property is optional, "st,syscfg-tz" is required
+		 * - default(no SCMI, no SMC): the hold boot is managed as a syscon register
+		 *    The DT "reset-mames" property is optional, "st,syscfg-holdboot" is required
+		 */
 
-	if (!ddata->hold_boot_rst && IS_ENABLED(CONFIG_HAVE_ARM_SMCCC)) {
-		/* Manage the MCU_BOOT using SMC call */
-		err = stm32_rproc_get_syscon(np, "st,syscfg-tz", &tz);
-		if (!err) {
-			err = regmap_read(tz.map, tz.reg, &tzen);
-			if (err) {
-				dev_err(dev, "failed to read tzen\n");
-				return err;
+		ddata->hold_boot_rst = devm_reset_control_get_optional(dev, "hold_boot");
+		if (IS_ERR(ddata->hold_boot_rst))
+			return dev_err_probe(dev, PTR_ERR(ddata->hold_boot_rst),
+					"failed to get hold_boot reset\n");
+
+		if (!ddata->hold_boot_rst && IS_ENABLED(CONFIG_HAVE_ARM_SMCCC)) {
+			/* Manage the MCU_BOOT using SMC call */
+			err = stm32_rproc_get_syscon(np, "st,syscfg-tz", &tz);
+			if (!err) {
+				err = regmap_read(tz.map, tz.reg, &tzen);
+				if (err) {
+					dev_err(dev, "failed to read tzen\n");
+					return err;
+				}
+				ddata->hold_boot_smc = tzen & tz.mask;
 			}
-			ddata->hold_boot_smc = tzen & tz.mask;
 		}
-	}
 
-	if (!ddata->hold_boot_rst && !ddata->hold_boot_smc) {
-		/* Default: hold boot manage it through the syscon controller */
-		err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
-					     &ddata->hold_boot);
-		if (err) {
-			dev_err(dev, "failed to get hold boot\n");
-			return err;
+		if (!ddata->hold_boot_rst && !ddata->hold_boot_smc) {
+			/* Default: hold boot manage it through the syscon controller */
+			err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
+						     &ddata->hold_boot);
+			if (err) {
+				dev_err(dev, "failed to get hold boot\n");
+				return err;
+			}
 		}
 	}
 
@@ -857,18 +902,31 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret < 0 && ret != -EINVAL)
 		return ret;
 
-	rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, fw_name, sizeof(*ddata));
+	if (of_find_property(np, "st,rproc-tee", NULL))
+		rproc = devm_rproc_alloc(dev, np->name, &st_rproc_tee_ops, fw_name,
+					 sizeof(*ddata));
+	else
+		rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, fw_name,
+					 sizeof(*ddata));
+
 	if (!rproc)
 		return -ENOMEM;
 
 	ddata = rproc->priv;
-
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
 	ret = stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
 	if (ret)
 		goto free_rproc;
 
+	if (ddata->tee_phandle.np &&
+	    !of_device_is_available(ddata->tee_phandle.np)) {
+		of_node_put(ddata->tee_phandle.np);
+		ddata->tee_phandle.np = NULL;
+		ret = -EPROBE_DEFER;
+		goto free_rproc;
+	}
+
 	ret = stm32_rproc_of_memory_translations(pdev, ddata);
 	if (ret)
 		goto free_rproc;
@@ -877,8 +935,14 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	if (state == M4_STATE_CRUN)
+	if (state == M4_STATE_CRUN) {
+		if (ddata->tee_phandle.np) {
+			dev_err(dev, "TEE support not yet compatible with attached state\n");
+			ret = -EINVAL;
+			goto free_rproc;
+		}
 		rproc->state = RPROC_DETACHED;
+	}
 
 	rproc->has_iommu = false;
 	ddata->workqueue = create_workqueue(dev_name(dev));
@@ -894,10 +958,12 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_wkq;
 
-	ret = rproc_add(rproc);
+	if (ddata->tee_phandle.np)
+		ret = rproc_tee_register(dev, rproc, &ddata->tee_phandle);
+	else
+		ret = rproc_add(rproc);
 	if (ret)
 		goto free_mb;
-
 	return 0;
 
 free_mb:
@@ -911,6 +977,11 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 		dev_pm_clear_wake_irq(dev);
 		device_init_wakeup(dev, false);
 	}
+	if (ddata->tee_phandle.np) {
+		of_node_put(ddata->tee_phandle.np);
+		ddata->tee_phandle.np = NULL;
+	}
+
 	return ret;
 }
 
@@ -919,11 +990,11 @@ static void stm32_rproc_remove(struct platform_device *pdev)
 	struct rproc *rproc = platform_get_drvdata(pdev);
 	struct stm32_rproc *ddata = rproc->priv;
 	struct device *dev = &pdev->dev;
+	struct device_node *tee_np = ddata->tee_phandle.np;
 
 	if (atomic_read(&rproc->power) > 0)
 		rproc_shutdown(rproc);
 
-	rproc_del(rproc);
 	stm32_rproc_free_mbox(rproc);
 	destroy_workqueue(ddata->workqueue);
 
@@ -931,6 +1002,14 @@ static void stm32_rproc_remove(struct platform_device *pdev)
 		dev_pm_clear_wake_irq(dev);
 		device_init_wakeup(dev, false);
 	}
+
+	if (tee_np) {
+		ddata->tee_phandle.np = NULL;
+		rproc_tee_unregister(dev, rproc);
+		of_node_put(tee_np);
+	} else {
+		rproc_del(rproc);
+	}
 }
 
 static int stm32_rproc_suspend(struct device *dev)
-- 
2.43.0

