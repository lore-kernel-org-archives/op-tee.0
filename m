Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59BFFF886F
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 13:12:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 298CC42F1B
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777900354;
	bh=at1C8YDY/wGOzV+ETAwWHh61G+w+aU1TRFLVXFmiWus=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=RTrIxHgxFeZti1Mk7Fe968oplA4IA/zf65kmd1l/qM6cxr46i7ncUefgFZ3eyN0GB
	 NxjJbbw+HZs0OmH3AfYOymVV6TCtvb5O+vXWW35lY7/UDwaZPsBDsTa01/CEGgux+m
	 fytgdXRaXZgMUK8MBvDwXaBpLtEMErPXI7Pv2btFBYbypEdpEPcpuHrm2+4yxSOxRF
	 fEHAu83R6ystfqyPDvUC0QlHhg/HnIYk0uVFkvlbz3v/98nveDSJKJfmBvnMQN8zA6
	 8c3F4n3qQyd6VFLPhB7O/d5eB5HBa9gBPORICc5QgwybZYiYt4DhF3Nj/3uQ1DAntc
	 4F3cbN89ZFcNQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9D35844E3F
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 May 2026 13:10:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FBG+CLKu;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 128B4417CA;
	Mon,  4 May 2026 13:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BECC2BCB9;
	Mon,  4 May 2026 13:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777900212;
	bh=at1C8YDY/wGOzV+ETAwWHh61G+w+aU1TRFLVXFmiWus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBG+CLKuWTPPOErRmdZQmq22CXWb+2SJUADPp/Z00Nx9RWXBdousJm+MYagR96SFz
	 CD/HAdYTXidMJp9dLIlRctvcrquifZb2fRYansp+tpTy8j2RD7vvQgIaLRUpQT72uX
	 mJ39N9vvNtdJNPmjOFegFc42xdL+9lFn0zWd2KZXxo1DyTCzru/6VeZnQojP1pWkNX
	 8nVqSI8l3qaG47h7oSu7/a2dmpmRSEVKCk4PbjFpAgvbJbceDgwAUebaG0bIosioPF
	 22BvtvjQqRIwp1dWFCa7OFS/cysuLYyIPpdpqH5W3sS4hEcMLchQKxmwjGcn/tQryW
	 QD5ZuSpkFylGQ==
To: andersson@kernel.org,
	konradybcio@kernel.org
Subject: [PATCH v5 13/16] net: ipa: Switch to generic PAS TZ APIs
Date: Mon,  4 May 2026 18:36:00 +0530
Message-ID: <20260504130603.1474043-14-sumit.garg@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,riscstar.com];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.234.252.31:from];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9D35844E3F
X-Spamd-Bar: -
Message-ID-Hash: FJCHBXT52HV3DH7V5MLMQZ43FUF23ITR
X-Message-ID-Hash: FJCHBXT52HV3DH7V5MLMQZ43FUF23ITR
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Alex Elder <elder@riscstar.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FJCHBXT52HV3DH7V5MLMQZ43FUF23ITR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/net/ipa/Kconfig    |  2 +-
 drivers/net/ipa/ipa_main.c | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
index 01d219d3760c..a9aff1b7977d 100644
--- a/drivers/net/ipa/Kconfig
+++ b/drivers/net/ipa/Kconfig
@@ -6,7 +6,7 @@ config QCOM_IPA
 	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
 	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
 	select QCOM_MDT_LOADER
-	select QCOM_SCM
+	select QCOM_PAS
 	select QCOM_QMI_HELPERS
 	help
 	  Choose Y or M here to include support for the Qualcomm
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 788dd99af2a4..3cd9e44680e9 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -14,7 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
 
-#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/soc/qcom/mdt_loader.h>
 
 #include "ipa.h"
@@ -624,10 +624,13 @@ static int ipa_firmware_load(struct device *dev)
 	}
 
 	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
-	else if ((ret = qcom_scm_pas_auth_and_reset(IPA_PAS_ID)))
-		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
+	} else {
+		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
+		if (ret)
+			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
+	}
 
 	memunmap(virt);
 out_release_firmware:
@@ -758,7 +761,7 @@ static enum ipa_firmware_loader ipa_firmware_loader(struct device *dev)
 		return IPA_LOADER_INVALID;
 out_self:
 	/* We need Trust Zone to load firmware; make sure it's available */
-	if (qcom_scm_is_available())
+	if (qcom_pas_is_available())
 		return IPA_LOADER_SELF;
 
 	return IPA_LOADER_DEFER;
-- 
2.51.0

