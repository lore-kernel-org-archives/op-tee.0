Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8D4CD5BB0
	for <op-tee@archiver.kernel.org>; Fri, 22 May 2026 12:05:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 00596443B2
	for <op-tee@archiver.kernel.org>; Fri, 22 May 2026 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779451502;
	bh=ELz8UG0Mt3NxaxlOsH4sXk1VvXq7G9YaHBtwCJBufEQ=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AKvZdZgKrgD/Y9fdOd94LWsf2haSQWUib2vfAWas/yAqsQ1rmrbqbsubqdNzcUrAW
	 0uUCvxMThwCldZmGVd0yLuUGvqmXFVwAz1Ri6XZ/k0dM2U3L2hp/SAVvmlKzmGQkxr
	 36XOjEZwVVxDsgkDeA959ZYb43JT9yGGCaJ/woJ3tZ5B2SpdjAeRBW0eS50YSzyLG2
	 UWcv9RICej08j+MbkBdaGDEiuhIvWjCeZBOfRzbHdrPpM1MPQS1O0HTSLK6rj08DsL
	 Hm+tx53jDuyShdyYbvVvfnX/giKabbXAIlswnv37UEDfqTOxPPgbIBfWAWR/BjrpKa
	 2FkvT3aE7vWcg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0C582443EA
	for <op-tee@lists.trustedfirmware.org>; Fri, 22 May 2026 12:03:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omIQXAyo;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 663564034C;
	Fri, 22 May 2026 12:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B611F000E9;
	Fri, 22 May 2026 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779451380;
	bh=u/kEMqShFzt+y5ml+3T0yGQOr4WqkdCyZlIk59GqCQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omIQXAyoc98uS/cwiNPCyfpPoVqArLxPShlrerCXgY5ZYBLVTdBkkcMdPSuaAcThW
	 8YrsLBRW33pPlHKzoVJL9pSV9vkvUECtlePU+J+E6KvMx5MAe62/Y/7/TPDaIFaiaI
	 cY1nF1Ty3Vzz5/m7ibLiI/ReOBJlquVwt1gPRN7xlwHPk8USM8qCZ+wIXnkEv9fqV3
	 k1WIkDcc/gbkHLaStceniK1hDm5yPyrl84TekPR8a1LyhhWwA0zI+JGOQDPKshT7Y3
	 g05yNd3Ml4O84a4tekReYM8Pu/pTlIm8FjjjQgGKLqFbPCZtWdJSKzPy6SaWHFklJz
	 kdGfkoeuI8Y1Q==
To: andersson@kernel.org
Subject: [PATCH v7 11/15] media: qcom: Pass proper PAS ID to set_remote_state API
Date: Fri, 22 May 2026 17:29:32 +0530
Message-ID: <20260522115936.201208-12-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522115936.201208-1-sumit.garg@kernel.org>
References: <20260522115936.201208-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[vikash.garodia.oss.qualcomm.com:server fail];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0C582443EA
X-Spamd-Bar: --
Message-ID-Hash: TW5I4UJC3GTEAH3NXVUNY7NH4WHT6U3X
X-Message-ID-Hash: TW5I4UJC3GTEAH3NXVUNY7NH4WHT6U3X
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.
 viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TW5I4UJC3GTEAH3NXVUNY7NH4WHT6U3X/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

As per testing the SCM backend just ignores it while OP-TEE makes
use of it to for proper book keeping purpose.

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
 drivers/media/platform/qcom/venus/firmware.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index b3c5281aea91..856fa6a79064 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -109,5 +109,5 @@ int iris_fw_unload(struct iris_core *core)
 
 int iris_set_hw_state(struct iris_core *core, bool resume)
 {
-	return qcom_pas_set_remote_state(resume, 0);
+	return qcom_pas_set_remote_state(resume, core->iris_platform_data->pas_id);
 }
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 3a38ff985822..3c0727ea137d 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -59,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	int ret;
 
 	if (core->use_tz) {
-		ret = qcom_pas_set_remote_state(resume, 0);
+		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);
 		if (resume && ret == -EINVAL)
 			ret = 0;
 		return ret;
-- 
2.51.0

