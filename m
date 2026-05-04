Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E18FF885A
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 13:09:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9EAD844363
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777900177;
	bh=TMDAtJj8kzYCaRJqzLUmw2YSXg1vJo+ncpJ6dpg5hOs=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rk5COo5nZ5R7Otz220KLvzqzq16eMAwQz38OdIPmdPkAQkfkuQ6lyD8oiKgk8eDaK
	 3x0o7vmofKiw4jYPmcY5EX1sp7pR5htfaBeqV85oT7kGDUFNMpp7qGFU4KX5WZb++Z
	 RAOmXLbuITbKtVS3md90YgoBNy1t5uwSzU4zItrCjOgCkZh0T8kOBX47dePaWrnO7H
	 miKHY1SOC+ra2jlnL5i9KiU8j+wzcnXJgMrm4ugRKEmWOH3R71MzuCnc4XEygzOdb4
	 B5L5bC/6ahd98AXkgzZxToy8eKS+TmrE/ZVwLoKAzECT/LK9qgdzGfEHMkTJjR+kz7
	 UrDQBu7g2+bFQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 46A414425C
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 May 2026 13:08:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W3qfQOiC;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C29A543877;
	Mon,  4 May 2026 13:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AD1C2BCF5;
	Mon,  4 May 2026 13:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777900106;
	bh=TMDAtJj8kzYCaRJqzLUmw2YSXg1vJo+ncpJ6dpg5hOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3qfQOiC8Eq6jDNpVOPWWT1VwWctw7wlhk63DVBw3mMhT9zZCCQA5pSo51cuY3w0M
	 XBbX7JC/C7oNAgD7K0FjY/FJV+yy1i+DgPMyPD75XCjhT15I21AgmXu09YZjNP/vdr
	 Xw/YttkaovtP2mX2hhe798OqqpJFrhnSOCRpnuID4fuDzJCKgZDU/44GMmmLkFEeNZ
	 2URrUhURz9qZ+LlMDQxWTcFdF8R+6g7+6dOsaxC+Nf8pcPjpsxWhuXqn6AfSqBBeq7
	 rpk+V/UP/0TvwUYcgD5BbdQ6sENt5d8tSJsH5HBGDh7R+/cW0d9zT97IQ6mZoijyMt
	 psJ8sSZ0NvEBw==
To: andersson@kernel.org,
	konradybcio@kernel.org
Subject: [PATCH v5 06/16] remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
Date: Mon,  4 May 2026 18:35:53 +0530
Message-ID: <20260504130603.1474043-7-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260504130603.1474043-1-sumit.garg@kernel.org>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.234.252.31:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 46A414425C
X-Spamd-Bar: -
Message-ID-Hash: 5523QHYCMJJYYGH5JZEB7ZY26LZYBLLN
X-Message-ID-Hash: 5523QHYCMJJYYGH5JZEB7ZY26LZYBLLN
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5523QHYCMJJYYGH5JZEB7ZY26LZYBLLN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index ae78f5c7c1b6..96888007faa8 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -34,6 +34,7 @@
 #include "qcom_pil_info.h"
 #include "qcom_q6v5.h"
 
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 
 #define MPSS_CRASH_REASON_SMEM		421
@@ -1480,7 +1481,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	}
 
 	if (qproc->need_pas_mem_setup) {
-		ret = qcom_scm_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
+		ret = qcom_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
 		if (ret) {
 			dev_err(qproc->dev,
 				"setting up mpss memory failed: %d\n", ret);
@@ -2077,7 +2078,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
-	if (desc->need_mem_protection && !qcom_scm_is_available())
+	if (desc->need_mem_protection && !qcom_pas_is_available())
 		return -EPROBE_DEFER;
 
 	mba_image = desc->hexagon_mba_image;
-- 
2.51.0

