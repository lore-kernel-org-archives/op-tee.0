Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8824FED9EF
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 18:07:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 162C143AAA
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 18:07:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=LTvl82aw;
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6475C43AA4
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Mar 2026 18:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyUheXOeuSe6Rqr4mrMsyiwwyAGqxWiYLOc9noLqggJGkbuAMTydKF5UWxx3M+Avr7i5Gh/wCdgAhOfYuHDwU9mLM7nBooZPoaPw8AvxO3pM4IXjFRILDoY6iC6Q5tAhjLc6bQoDPldzAEwS7By/f7C75ffffwugtQbJx30HfVw5mbBDDE3fEQkts+TmWPwWfdWEvQsnUL+l/XbEucLpo0LQgn+FLZdt+j3myiJVNsuW+T8jygar1PhQf/RxlCqVvBOIlEAtbYu1kcYgWtQvYj0lSGlZ5i2rucpVLvOav7sYdtEgIPxpID5NA3l+hTokBK23Q0xxt6xVSnnZeCWlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TZZKXH3zcoOGrlmPW4gNeQepDcefN+mAwoMli0xcdA=;
 b=sYz0VPoDdATp6kjxO8vTxtbcgz/x04hDJRZDEDirL6QhYxB4sbzhr/MonuC53rx3baCTPQwGdEkbPHv7lhRd1p3mUGk2vQnNTInUiQZH1o+Uzkp6lzCyQ385a6lMuUvY+ZYwCb/NpO/qi7gCC9OpIM+Z68VuHY0xjxKkjK8h/Sv/pr3N/zgratenuBJ8IDNzQuus+Q3SzzQJp+4GtRWOWX78OPNXrlcoLj1okpBFKx4uA935z32P8MV5Inu8eHmle3zAUs55IZp5O3L1TwIbVPdc53KcraJxPfIfieRI2WlWpuYjRW38WYVoYxbIJORt8gdupXEyIDSGgZzL9/+sRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TZZKXH3zcoOGrlmPW4gNeQepDcefN+mAwoMli0xcdA=;
 b=LTvl82awny0dgGiOaEz17VJnEy0wSoL+jRov1zNthlrvPwSEU1GYBqgweUHb0WV7en6ZMGeKRR+9m+zRm6mWxQvUNcR4U8LFNqGl75omgEbIvhNxQiqwF+/k1kHmDG0fkYHA7KNu5s4GTCrU4h310VwTswSbjls4TwXfIQ0A+m2WjMzHpooaWSac3J5uI6W3mkW/pKDTl0mRH+lq71h7d+CPpu1Gwsrp4JCSzULKgpKHYimC0zpJIuf28jYX0L5NX3tdaSi3t78yMooySVIY+E9Yfem3tvL9HlMy8qfNJ+dEaGBokZbpHKSpgnFfJsGE0+1nBK9nGdkCRRX2aQERhA==
Received: from AS4P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::16)
 by DU0PR10MB6978.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:416::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 18:03:53 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::ba) by AS4P191CA0009.outlook.office365.com
 (2603:10a6:20b:5d5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 18:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 18:03:53 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:06:26 +0100
Received: from localhost (10.252.21.194) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:03:52 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v21 4/6] remoteproc: Introduce optional release_fw operation
Date: Tue, 17 Mar 2026 19:03:25 +0100
Message-ID: <20260317180329.1207625-5-arnaud.pouliquen@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|DU0PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fbeece-454b-43d3-9ca8-08de844f8cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	+CSrcfEx/g/CT9AaMZcJOn7Yra0EFy5N73r9kE7Orddij44gIhhgu8YpxE8hQXGGJATTE9dAAwC6km/NmIpqd5Da1dnBBPXQHPHGbB3d+NQyhH/CjXUlMm4iXkT23QNVUYsF8/wOrqJirhqmjwvJnwFRci547VR3bZFH+wd1jvKPgUJcUA1rkqUjyHIU/TW2kYW1G4nuGwsTUg1WSqR8fFHZFZDa1WxYy8wqf8zN2F4L6umDZH2fkuGGadkTpnlKgfLQvfNITaTYJUtwUCQLQWg94T2xB/VKscfZ8L9P+3gy7HnCmSKKWS6JJbTwRXezlMGptOfHo4sprwv/NNU63oeCU0et5HJ7DXCIwjnaUurWyRb5Ak0Bzd+rQQmOgmxVD+GON5R5KweKnH+7hjbQ3+VmwtqYel0fBDIs0566Koj4jyYoWvMoRCjXvuSjjDl9KxHpnZK7sdLCUJS3lR10S+hA/5Hg0CbUo9Imin/kVsFj0DWeeEKT62cmIhs9BTW7t2yqTgFHnBqI/x1/SK800L7qV8z8kmwTg1vj1f4mZuFkEtS44dNRXOdv38xZUFbqo7Gh4ewHrl1OzxJ7oFTBEDSKLqWZsrSVDugjh6VN0wW4yKK5LoUP0LdQ7l0BeVWQzxMaJjsG8peBiJYLbPDGrWxNHf378mv+9V4Vh7t9LCk3wUPesQWVNkkY99TQA30aSueRVYfWnF2xFeVILLAggeFYMEBJatm+zGy1eKHUFqfxfNQtDhrrXbXh3d8kZwzTgztP4xQa0KPCcxEwUR3sPQ==
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	TrZi7hgLM68SuqgHz2arJLBuGbCM15Cb+z5EFjtBVdcnFoeRVk1nQPXQwYO013marHlkzqiUMxjZPv4T598wnodV3e4uriAuIpxaoU5vu5yTVBOsFjKDMZOcknbBYlvzcUSq8q6L0cpRkQvbPYvmEGswKG8g0WlPN/UDCKLJJKgU5C4TQEXECMvV4QJ7po0RJzW8DxE+FCnv8yoEVXxN8fUDc5bb009HrYimE9XzdlSxJfpwpdLwJvj8lTlxjRR9pmEeUDTMbu/q1EvBAwTYLlrLqnlezg4mw8GAsqTFfdwBz3UIhyuRG0ih+VJS+LJBAt1AyY1MsOaWPgQU9LdRnH+K5rJLlt6U2DA/WXgccGgpNX4hHhgpUtI8F4P/bh3EWwkojQmy3BjzhfUD/lS5jqQq+H2Ik/uYQYkuH+tBGwyQrx4oPfXrbIgAhDx0eqjj
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:03:53.2150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fbeece-454b-43d3-9ca8-08de844f8cd0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6978
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
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.70.55:from];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.70.55:from];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6475C43AA4
X-Spamd-Bar: --
Message-ID-Hash: X4UHJJL2UWX6U6WZIAVUBM7D2UZ4ZLQO
X-Message-ID-Hash: X4UHJJL2UWX6U6WZIAVUBM7D2UZ4ZLQO
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X4UHJJL2UWX6U6WZIAVUBM7D2UZ4ZLQO/>
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
index a44c8039449d..a0760ad76b13 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1852,6 +1852,8 @@ static int rproc_boot_recovery(struct rproc *rproc)
 
 	/* boot the remote processor up again */
 	ret = rproc_start(rproc, firmware_p);
+	if (ret)
+		rproc_release_fw(rproc);
 
 	release_firmware(firmware_p);
 
@@ -1993,6 +1995,8 @@ int rproc_boot(struct rproc *rproc)
 		}
 
 		ret = rproc_fw_boot(rproc, firmware_p);
+		if (ret)
+			rproc_release_fw(rproc);
 
 		release_firmware(firmware_p);
 	}
@@ -2062,6 +2066,8 @@ int rproc_shutdown(struct rproc *rproc)
 
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

