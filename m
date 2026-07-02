Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2E3C43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 12:03:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F28B745076
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782993791;
	bh=0JFtBuB5sjV9sdaGi7v1qgRBqYu1BHJC5zYv1BaKMn8=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2+GHNxu8XlD9jfDCQNciP5s8XyMZePEQ/wbADLjZ3EN9k/+PqDmfGdcsDXPMK113B
	 DVhK3B5Tg0/ZnzmEXg+EnZ0uU2GdbUpXuWVnxCjx4wwAGBj6fbRifntmYRbj1Gj48u
	 Q1ldX2lcdETeJtgCNYdfZntOB0fx8JOPDSXmBLvoRVGv414yyz32BijxPIFVM3PMlm
	 zLnbqy4/XGCaSceaJkkUwgJdlrB5IgHx/x+0pdUZqHF9sEsCVWEhKkNzItAdeaPJPF
	 fS73k7GZv6T1FU7NAAo7pZQ7OI0vGhgjwFFc32lweYa6E/RLjiHx8yilzNk/638qhB
	 X0tBcrJ1Xt0FQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1A8AA45067
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 12:01:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGG1Tw5Y;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 96349439FD;
	Thu,  2 Jul 2026 12:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215241F000E9;
	Thu,  2 Jul 2026 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782993661;
	bh=TJQ+szvJd3RvuPi3UpEIfVNiYJsDF67ub0WT7W9Uctk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CGG1Tw5Y3cX1Ey1MGoULoVo4folY6vibdanBwnXDBdR1dCq3MlTzAl2ckCwW452xQ
	 tXeMFbbbsymoIyA/lEStvwC3hvCRSI+deq+5KtVH0d1L9jufu/ydacNS4ak1ccqpT/
	 jPjhpBK4CAJ+q7QSSmdfzHzf50alhCoSmBCffyV2V020AvwBM1SV5u1Q08tTfzoCXD
	 2TBJwYI22VFS3VZIErRYGd0RDYmq8hwtM9aJt0MlVbBZqHFJfqAqqfkyuFurRxjZU5
	 5rqu1RgoKbJvF979wcoaCJeIFJvtBWOphHY0aCDMuVY32cBLuy6DehReb0nUzetesr
	 AafRl2snQT6NQ==
To: andersson@kernel.org,
	konradybcio@kernel.org
Subject: [PATCH v9 08/14] drm/msm: Switch to generic PAS TZ APIs
Date: Thu,  2 Jul 2026 17:28:24 +0530
Message-ID: <20260702115835.167602-9-sumit.garg@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1A8AA45067
X-Spamd-Bar: -----
Message-ID-Hash: LPTQNCHO3ESC5TKZY4W7CY4AE4H2TYCP
X-Message-ID-Hash: LPTQNCHO3ESC5TKZY4W7CY4AE4H2TYCP
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualc
 omm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LPTQNCHO3ESC5TKZY4W7CY4AE4H2TYCP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Kconfig             |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 250246f81ea9..09469d56513b 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -21,6 +21,7 @@ config DRM_MSM
 	select SHMEM
 	select TMPFS
 	select QCOM_SCM
+	select QCOM_PAS
 	select QCOM_UBWC_CONFIG
 	select WANT_DEV_COREDUMP
 	select SND_SOC_HDMI_CODEC if SND_SOC
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 2c0bbac43c52..57135acc8e2c 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -5,7 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
-#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/pm_opp.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/slab.h>
@@ -653,7 +653,7 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
 	if (adreno_is_a506(adreno_gpu))
 		return 0;
 
-	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
+	ret = qcom_pas_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
 	if (ret)
 		DRM_ERROR("%s: zap-shader resume failed: %d\n",
 			gpu->name, ret);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c62c45bb0ddb..489462065ea9 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -8,6 +8,7 @@
 
 #include <linux/ascii85.h>
 #include <linux/interconnect.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/kernel.h>
 #include <linux/of_reserved_mem.h>
@@ -146,10 +147,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		goto out;
 
 	/* Send the image to the secure world */
-	ret = qcom_scm_pas_auth_and_reset(pasid);
+	ret = qcom_pas_auth_and_reset(pasid);
 
 	/*
-	 * If the scm call returns -EOPNOTSUPP we assume that this target
+	 * If the pas call returns -EOPNOTSUPP we assume that this target
 	 * doesn't need/support the zap shader so quietly fail
 	 */
 	if (ret == -EOPNOTSUPP)
@@ -175,9 +176,9 @@ int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
 	if (!zap_available)
 		return -ENODEV;
 
-	/* We need SCM to be able to load the firmware */
-	if (!qcom_scm_is_available()) {
-		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
+	/* We need PAS to be able to load the firmware */
+	if (!qcom_pas_is_available()) {
+		DRM_DEV_ERROR(&pdev->dev, "PAS is not available\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.53.0

