Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FD010ED676
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:14:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 78AE142EBC
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774617250;
	bh=O/qqg75bvo/5OO7i3M1MAcQa5DhYCAeNyUlzMs2EbZQ=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eTxAstL7uaE7X4T+g6Foh6TO0+yhqyr4G+zwX/WCSI1/n6zwRF2ouWoKclHC4KWeq
	 VHVPzQuA2bLnwfh8pPgJ+/1gB+nRnXBPBAE2Rzy+sr4+H0/q74Dx6f3T45syYsrlu+
	 LuK/m+/LxG5LdhIR9sgdL9bnZcQ/UzDPI0ZppIgP24MludhMC0keR3j5jZsoPS9kTh
	 Fabw37ZCwAj84IUnLVVNOrLwNOkVljOHsfxHS4/6UyptUzv65yUV4tL4AG4IZ9r+1Z
	 ye8q1LMeJp57evUvzw9i8mkXJQwOpDFlb8OJxqcLYFTsC+uDU7r5zgzIuU29Asz53D
	 EXnGhTmvFSlLw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 34C7244464
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 13:12:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DivMUCig;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CD30660103;
	Fri, 27 Mar 2026 13:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF8C19423;
	Fri, 27 Mar 2026 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617166;
	bh=O/qqg75bvo/5OO7i3M1MAcQa5DhYCAeNyUlzMs2EbZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DivMUCigPNJBZfco3mya5h6DmhRIjSlYAhIjkmbmlbicBco43iLodLW0mG5Zcj+42
	 EZdJYh9KSTsuvEn5iCOisqYhoNRBLhloflBGA3KlXAWfDaeZcjvZ5Pk2hyeoXu7SB/
	 fYNPCjd/MLzwnw+0nHM4qt629fjeyvTU8GcOH7tb1ibvJ/2aurVTYILiV9OiH95DN1
	 F2jB3qdrp9+/0FWSuMGHwoJw90u2fJnltDk9el2KWN51bR77k1if2O8Ofx9POL+/l9
	 aXe4CAUf0bO8U+BCGEUVudGUC/e0TOhz7/awFGqfHWZyyzA+U3YjeuRONhECWLaEp4
	 0t6riJt7oGPew==
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v3 06/15] remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
Date: Fri, 27 Mar 2026 18:40:34 +0530
Message-ID: <20260327131043.627120-7-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327131043.627120-1-sumit.garg@kernel.org>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 34C7244464
X-Spamd-Bar: -
Message-ID-Hash: 7NBXN4SYKAA4PXJTE4NB2226T7QGHM6L
X-Message-ID-Hash: 7NBXN4SYKAA4PXJTE4NB2226T7QGHM6L
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com, linux-kernel@vger.kernel.org, Sum
 it Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7NBXN4SYKAA4PXJTE4NB2226T7QGHM6L/>
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

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 91940977ca89..4d81b4af097f 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -34,6 +34,7 @@
 #include "qcom_pil_info.h"
 #include "qcom_q6v5.h"
 
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 
 #define MPSS_CRASH_REASON_SMEM		421
@@ -1442,7 +1443,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	}
 
 	if (qproc->version == MSS_MSM8953) {
-		ret = qcom_scm_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
+		ret = qcom_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
 		if (ret) {
 			dev_err(qproc->dev,
 				"setting up mpss memory failed: %d\n", ret);
@@ -2039,7 +2040,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
-	if (desc->need_mem_protection && !qcom_scm_is_available())
+	if (desc->need_mem_protection && !qcom_pas_is_available())
 		return -EPROBE_DEFER;
 
 	mba_image = desc->hexagon_mba_image;
-- 
2.51.0

