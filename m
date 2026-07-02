Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6970AC43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 12:02:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A3C1B4507A
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782993727;
	bh=6tRC7tZMAK5eDK5NBOHer6WMu3gt84gQPYX4SCBd0Bw=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ooFgBzu8SJLr34X0EjqGNOdyEUJnKbrVYeYX2BXmK+rS29dqcfMOIePlYFdAVZbRU
	 izmpOwIovm/8NGjOXfVzt9CmMrPpJ6AWGwXGbylG4GxDNxJ1bzjfaeHyy0q06zBF3O
	 EkrUZxZTFBZh88hFroF51KZba1mZbstuhFbyY9YBsFMpYse0mszNbiaIAP9/ock9s8
	 tfydXMtaH8H52p4dIBJcHyQ+aRozlBmU8dXRtfl2m3Be0CuJ+MPfnPL2ge7Zru+1aJ
	 u1ArgWEKwmDqPM9USLN5hEIvg2UOjPzrMSoPGkrXdtF/7peWaiRyUtFBe81qPHrMqj
	 4IeoGfOMTavTw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 68E334507A
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 12:00:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUjbxMfQ;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0721260121;
	Thu,  2 Jul 2026 12:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5976D1F000E9;
	Thu,  2 Jul 2026 12:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782993631;
	bh=g7FpjBIt0YeokSFzLC6S/XCaod58GFwuLHuUF8Xfqag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iUjbxMfQep0Npbs2gHIS0sUTSCCw54soOpfH2nkVrZBh6QQ0x0S74HNHRtpkuwiu+
	 27AwM6fjUMErPybxGHSy30FC//loGNqZKep/0XO4qLvJO3lTls1vwKWRPUqvNC/FNl
	 OFsJIFvBco1mmroKQjN8q/+49y1M7ZBIQYuYjMoYTAxYfLMvaD8ApKysiPO6bGwk8V
	 hZhnfiKCG82xb5CnZNmRFJINqzgFricsfqzAzC0s2CyeLtt1SwnV69jl3jlKpjcGpa
	 +ygWmhygSZ7xrDLiCphUpiMu3tmA3/jZ4c8DVW0e4XD0lP+Qzm3GE/ftNantxESkEx
	 TSp0Rul1rnsHg==
To: andersson@kernel.org,
	konradybcio@kernel.org
Subject: [PATCH v9 06/14] remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
Date: Thu,  2 Jul 2026 17:28:22 +0530
Message-ID: <20260702115835.167602-7-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702115835.167602-1-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt,netdev];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 68E334507A
X-Spamd-Bar: -----
Message-ID-Hash: SPXZDXU4F6GIGR6FNL4A742QRDPCS4OO
X-Message-ID-Hash: SPXZDXU4F6GIGR6FNL4A742QRDPCS4OO
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualc
 omm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SPXZDXU4F6GIGR6FNL4A742QRDPCS4OO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch qcom_wcnss client driver over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_wcnss.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 4add9037dbd5..0dbdd18ab3dd 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
-#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -257,7 +257,7 @@ static int wcnss_start(struct rproc *rproc)
 	wcnss_indicate_nv_download(wcnss);
 	wcnss_configure_iris(wcnss);
 
-	ret = qcom_scm_pas_auth_and_reset(WCNSS_PAS_ID);
+	ret = qcom_pas_auth_and_reset(WCNSS_PAS_ID);
 	if (ret) {
 		dev_err(wcnss->dev,
 			"failed to authenticate image and release reset\n");
@@ -269,7 +269,7 @@ static int wcnss_start(struct rproc *rproc)
 	if (wcnss->ready_irq > 0 && ret == 0) {
 		/* We have a ready_irq, but it didn't fire in time. */
 		dev_err(wcnss->dev, "start timed out\n");
-		qcom_scm_pas_shutdown(WCNSS_PAS_ID);
+		qcom_pas_shutdown(WCNSS_PAS_ID);
 		ret = -ETIMEDOUT;
 		goto disable_iris;
 	}
@@ -311,7 +311,7 @@ static int wcnss_stop(struct rproc *rproc)
 					    0);
 	}
 
-	ret = qcom_scm_pas_shutdown(WCNSS_PAS_ID);
+	ret = qcom_pas_shutdown(WCNSS_PAS_ID);
 	if (ret)
 		dev_err(wcnss->dev, "failed to shutdown: %d\n", ret);
 
@@ -557,10 +557,10 @@ static int wcnss_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	if (!qcom_scm_is_available())
+	if (!qcom_pas_is_available())
 		return -EPROBE_DEFER;
 
-	if (!qcom_scm_pas_supported(WCNSS_PAS_ID)) {
+	if (!qcom_pas_supported(WCNSS_PAS_ID)) {
 		dev_err(&pdev->dev, "PAS is not available for WCNSS\n");
 		return -ENXIO;
 	}
-- 
2.53.0

