Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F678FED2D1
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 06:36:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 75539430AD
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 06:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773297371;
	bh=D/Vhw6leBBqAFpkgVNj90UXMmK8u4Tind9kuebFv7yY=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tPaVbqpqPSbPW3EM4RAik0IgL00ZgK/mQQaayMbmsLqPmZwKFcbbV9uYKxasDGtJr
	 viLgHt011CVqqsEykjeMiJoP0hZqj1upzk5N62A3NAwjbADnjmDuJDkapdkaZoN3F/
	 J0XBs9jB4mYXPmbH3kekogNQd7nYP3ozs7xFvqh7yZnDqzqsSJf19NN5Ie8KIG4BjL
	 xVFsc4GsVLafWhFGcH1NulRacj96EjFMjJHBXcB5HfaLqI5GZU6+QN7SenwS+KS6Xl
	 46h2lH/dIZ76ycuqovzERyndIBbDQ23XnZQPth/99kqGbbYuzrqhkc0J4l3ZdEpEHE
	 Jobqk9gmOrCQw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8EC1C43955
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Mar 2026 06:31:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Wtyi/+kj;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B3C343444;
	Thu, 12 Mar 2026 06:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA66C4CEF7;
	Thu, 12 Mar 2026 06:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773297079;
	bh=D/Vhw6leBBqAFpkgVNj90UXMmK8u4Tind9kuebFv7yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wtyi/+kjypF2TTn6+FB0hU2PCBr+u+59PsgP65OEtzu0Tw2zcVV9J/dDjgFR0YJ3O
	 VXQdkf0pP17JcZ/e93DShfgy9vyiZCyt0pm1CwCmSPLRFRaLFzsOxRKX8SSIJvwAKb
	 OmY1ieFCLTHPW2KuruU/lEtE4Cxn56I3CwwBKh0a2G2IBmA0GJh/FhTxu/KYCp7Mvn
	 Rs4vSgT7wXB27Mlqv4NCfj9Lhf3+ZChhLN4i2NWNJLhqjbDmnKt7vBR0IapclcpV8t
	 AR2GnmWsAcMRxonOXcsSSNOo8bRazpM0JKpLCR4Q4xZVOXpXOTiYnR27lgZDHrREZF
	 TGhDLcpzLuo0w==
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v2 11/15] media: qcom: Switch to generic PAS TZ APIs
Date: Thu, 12 Mar 2026 11:57:52 +0530
Message-ID: <20260312062756.694390-12-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312062756.694390-1-sumit.garg@kernel.org>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8EC1C43955
X-Spamd-Bar: --
Message-ID-Hash: LTGU72NIQ76AL7HQ2H2NEU334XABHNMJ
X-Message-ID-Hash: LTGU72NIQ76AL7HQ2H2NEU334XABHNMJ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualco
 mm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LTGU72NIQ76AL7HQ2H2NEU334XABHNMJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Along with that pass proper PAS ID to set_remote_state API. As per testing
the SCM backend just ignores it while OP-TEE makes use of it to for proper
book keeping purpose.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_firmware.c |  9 +++++----
 drivers/media/platform/qcom/venus/firmware.c     | 11 ++++++-----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 5f408024e967..856fa6a79064 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
@@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
 		return -ENOMEM;
 	}
 
-	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
+	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
 		return ret;
@@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
 						     cp_config->cp_nonpixel_size);
 		if (ret) {
 			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
-			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
+			qcom_pas_shutdown(core->iris_platform_data->pas_id);
 			return ret;
 		}
 	}
@@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
 
 int iris_fw_unload(struct iris_core *core)
 {
-	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
+	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
 }
 
 int iris_set_hw_state(struct iris_core *core, bool resume)
 {
-	return qcom_scm_set_remote_state(resume, 0);
+	return qcom_pas_set_remote_state(resume, core->iris_platform_data->pas_id);
 }
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 1de7436713ed..3c0727ea137d 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -12,6 +12,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/sizes.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	int ret;
 
 	if (core->use_tz) {
-		ret = qcom_scm_set_remote_state(resume, 0);
+		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);
 		if (resume && ret == -EINVAL)
 			ret = 0;
 		return ret;
@@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
-	    (core->use_tz && !qcom_scm_is_available()))
+	    (core->use_tz && !qcom_pas_is_available()))
 		return -EPROBE_DEFER;
 
 	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
@@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
 	core->fw.mem_phys = mem_phys;
 
 	if (core->use_tz)
-		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
+		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
 	else
 		ret = venus_boot_no_tz(core, mem_phys, mem_size);
 
@@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
 						     res->cp_nonpixel_start,
 						     res->cp_nonpixel_size);
 		if (ret) {
-			qcom_scm_pas_shutdown(VENUS_PAS_ID);
+			qcom_pas_shutdown(VENUS_PAS_ID);
 			dev_err(dev, "set virtual address ranges fail (%d)\n",
 				ret);
 			return ret;
@@ -274,7 +275,7 @@ int venus_shutdown(struct venus_core *core)
 	int ret;
 
 	if (core->use_tz)
-		ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
+		ret = qcom_pas_shutdown(VENUS_PAS_ID);
 	else
 		ret = venus_shutdown_no_tz(core);
 
-- 
2.51.0

