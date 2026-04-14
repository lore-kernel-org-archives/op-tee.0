Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE67F9D0D3
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:29:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1EC0E44A29
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:29:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hys56DtJ;
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 315674326E
	for <op-tee@lists.trustedfirmware.org>; Tue, 14 Apr 2026 15:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZfacEsZ0/tc2pguecsRjSRuoXvFT0/IfhXrjkc/q+8wuOkKTQl5vMhMbiZoo/YNrGNx2uypofeux1bRtvuoo6JLnnDqLHzVvJMZPnyd00hD7BwMv7f07sO5DYzUSO1or9UKX/t6HC5fLg9uqhhvLYwK3QfqZybSNh+8H7X+oJw63WGBHOoMKwbijKE+wFjSP1HGmX4N5DH8Ef1VeRDtEqAUUVfnHyjJ0qd6NXVgMhC/6E26PHb5lET1a2beqwwTRYagXj5n2OlRteV9TCtptSj2jBT4xuGLod+avCGCyzsExIShy3oOnsz6IpDsl7og3W8g+Mng4kDmqMWFhnM8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LxG/8R8/DSUM5+srOguxfAA0jx8iuRv3/EZ7ZTHSYc=;
 b=KSz79/uym+3PncS3rieowmIKw9DGSkoKfSB4236ekMMC0NG1V3UL5AcYvOHCA+8/TfntxamAOkGuNAno6+jwyxzPbfWf7pDQI1KwVIHnao5Cg5g0kk6uSgWJtUX6cSMFS5nKdX3A0A19pVEZ4WW/JtWFKA86EZtRS0KPfuvEhKeCAWSOqxzvZoj3M5X5IDT6m9VNvShbBYlf+udWZGEwrFyKLSfoS06K2TyWTIe/AwUH30R1OgR8KO8mplu5ddS+/VgHlCHBSwiJ8lLOlFvHybRVLW5LdZbFVCVJC/gEpym3RICugnWPfY+t+uuSTp36J+vKd6V1kfPRKDivjJ3/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LxG/8R8/DSUM5+srOguxfAA0jx8iuRv3/EZ7ZTHSYc=;
 b=hys56DtJDwd3f6PWKIZkqmy3iYkKa6/U5s5y5OFNioexPMOGxRYYPvrpTzCsrVXYaZfK5lr8EIS3vgeTUGwV3PnrfYxEZz9gWaHzIFnHszRqaWO4n7bz8VnlC35VNc5UPrj7urDOEDMVPwJU7Jd+YKRCodrDAZ3yGQ89cZTEefPsBazaIjtAPVh20ljnXW3Q1uIbKvLmBqCzxECVfzhz8Kry3jWWKGkdT4btwF41M6rUvD8xYQoHZIdp02q2QB8mVbDIjhWvSri9WepqWiXz4ICKCkSKAxZlax94lDp5TBoq8UvKZ4/nZ0AM8GJ7q/bkMCr0h51wwGZSgxAtsRSCSw==
Received: from DU7PR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::25) by PAXPR10MB5352.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:281::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:29:22 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::73) by DU7PR01CA0020.outlook.office365.com
 (2603:10a6:10:50f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 15:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 14 Apr 2026 15:29:21 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:32:30 +0200
Received: from localhost (10.252.12.46) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:29:20 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v22 6/7] remoteproc: stm32: Create sub-functions to request shutdown and release
Date: Tue, 14 Apr 2026 17:29:01 +0200
Message-ID: <20260414152904.1679724-7-arnaud.pouliquen@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|PAXPR10MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9854d8-0253-4a4a-2a59-08de9a3a9a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	oa2Q8IRywOqjgJtYbPSYh1Y6hoha3j5cyo5AXP7e1hC86aRUyNwRvijGRkWgZlApvqlGCHkhd6KgORwjRS8HlEr7YiKSsm3GaMBAEnmCOGmJj6BeemwiRSOrdZvfMI9lZ5XsK5Lz3DFNZAGH/EdAOfSG2ecb+JHo153G7diVkmFMSKKzv0lo1/onCOdhvi1C3kL+ODT7uvaRo6EqFNargOiPzPhgKkZEdIdAnzIKtHI0ubYfhRGa+ShMAMTQsOgqn6NCaaQMCZcbH9UwLlmu7DENBmhqDfISFAhmSUWrqtdZbfh/+qMwevIlLAvmOeiucT7rqMbpq2Hu5TQ8elL3qY9PmzkwZj7+MX+OFbIDNhavHQkELVgSJzX91Xt557eeqKM6Ki+z0HqJgDwdUiERmIw8gNOoGpILBl0g5i34h2bfndrSfFBVvTU6Xkj6dEF1yTquH0zHEm8CKM46TvvOGVBw7aEfFAShfoZAZ4T3cyf3Hg42vZxDnBz15qS1P5b/GD6pizmEKLpQXFhaYCG2bi6nxGm8MLn54Vijf9Jv6wZtW8etBAX8lBvhHQKRaYHz0wTM1FSkWZkJq5mYM0+WYgJPyvir1YofOeRkwIrRKjWZJXzLiwM+HUAwfMQcStidvKPfyvGeVPTTpoWdmb/32i/uJJ2gT52dA0Z6FxKG7nTNLn5BxUjpSvMm1kmRSCwb0EDH2pc8UGCJ/TDbX599XHlPIg+jy2GR6IBtOVvgATE0AQ8k/AzjoKfc7e/x1R5TCTh88xjVo4PGIszrwXtGcg==
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JIMjUqM7q/oNBptcKmQ84H/AwEkIg6zjv8nYhYPsYLknN6Ks8rwoYe1g32aZxTJ1IDDUIsgM0dSheCzi5gCtSQZzlS0/wsq2dtTgAEar4OfKFK6PKKzI1hwH9QQ0qDnvKTkeWCqAuf4WP5q4zGAnIZAFOgs/ZJLlbTHi514wa17FYthyIwrqBDrNiNjMVCKz89mAAlYtGoMlFe9Z95FmpeDIKFLtvr4pwBSFfo8vIID3ilq1diDJbYMD8oWs3zJSPeyEgOut32r33EPdP0hFF5dXmRK8nM5sWkVjw2FgAk8pgW0XgerDxfFgYP/22ZLdel4MAAazIdBMV2C4SHKjFmNMqX9fi+ouWrJFg5sIefJwx3rEMd6Lfx4dAcvVip8J4qv724xWD3N1ydWYAMzR3mIXoJNDk+bLbgzA50qp0e4nKCE+PNpfHIESRBgro19o
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:29:21.5907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9854d8-0253-4a4a-2a59-08de9a3a9a16
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5352
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16:c];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.162.53:from];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 315674326E
X-Spamd-Bar: -
Message-ID-Hash: OY4A2SQRJUHANIVB6VXLDYWMVGYL5UZT
X-Message-ID-Hash: OY4A2SQRJUHANIVB6VXLDYWMVGYL5UZT
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OY4A2SQRJUHANIVB6VXLDYWMVGYL5UZT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

To prepare for the support of TEE remoteproc, create sub-functions
that can be used in both cases, with and without remoteproc TEE support.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/stm32_rproc.c | 82 +++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 632614013dc6..4bcd6a784935 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -209,6 +209,52 @@ static int stm32_rproc_mbox_idx(struct rproc *rproc, const unsigned char *name)
 	return -EINVAL;
 }
 
+static void stm32_rproc_request_shutdown(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+	int err, idx;
+
+	/* Request shutdown of the remote processor */
+	if (rproc->state != RPROC_OFFLINE && rproc->state != RPROC_CRASHED) {
+		idx = stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
+		if (idx >= 0 && ddata->mb[idx].chan) {
+			err = mbox_send_message(ddata->mb[idx].chan, "detach");
+			if (err < 0)
+				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
+		}
+	}
+}
+
+static int stm32_rproc_release(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+	int err = 0;
+
+	/* To allow platform Standby power mode, set remote proc Deep Sleep */
+	if (ddata->pdds.map) {
+		err = regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
+					 ddata->pdds.mask, 1);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set pdds\n");
+			return err;
+		}
+	}
+
+	/* Update coprocessor state to OFF if available */
+	if (ddata->m4_state.map) {
+		err = regmap_update_bits(ddata->m4_state.map,
+					 ddata->m4_state.reg,
+					 ddata->m4_state.mask,
+					 M4_STATE_OFF);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set copro state\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int stm32_rproc_prepare(struct rproc *rproc)
 {
 	struct device *dev = rproc->dev.parent;
@@ -511,17 +557,9 @@ static int stm32_rproc_detach(struct rproc *rproc)
 static int stm32_rproc_stop(struct rproc *rproc)
 {
 	struct stm32_rproc *ddata = rproc->priv;
-	int err, idx;
+	int err;
 
-	/* request shutdown of the remote processor */
-	if (rproc->state != RPROC_OFFLINE && rproc->state != RPROC_CRASHED) {
-		idx = stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
-		if (idx >= 0 && ddata->mb[idx].chan) {
-			err = mbox_send_message(ddata->mb[idx].chan, "detach");
-			if (err < 0)
-				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
-		}
-	}
+	stm32_rproc_request_shutdown(rproc);
 
 	err = stm32_rproc_set_hold_boot(rproc, true);
 	if (err)
@@ -533,29 +571,7 @@ static int stm32_rproc_stop(struct rproc *rproc)
 		return err;
 	}
 
-	/* to allow platform Standby power mode, set remote proc Deep Sleep */
-	if (ddata->pdds.map) {
-		err = regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
-					 ddata->pdds.mask, 1);
-		if (err) {
-			dev_err(&rproc->dev, "failed to set pdds\n");
-			return err;
-		}
-	}
-
-	/* update coprocessor state to OFF if available */
-	if (ddata->m4_state.map) {
-		err = regmap_update_bits(ddata->m4_state.map,
-					 ddata->m4_state.reg,
-					 ddata->m4_state.mask,
-					 M4_STATE_OFF);
-		if (err) {
-			dev_err(&rproc->dev, "failed to set copro state\n");
-			return err;
-		}
-	}
-
-	return 0;
+	return stm32_rproc_release(rproc);
 }
 
 static void stm32_rproc_kick(struct rproc *rproc, int vqid)
-- 
2.43.0

