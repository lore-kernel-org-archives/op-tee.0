Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F397B10ED675
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:17:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 536D844464
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774617438;
	bh=MHGkZG5QV7bRaXYbxLAbQlzxv69ufJaE6S12MObcdak=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=VH6vrkEjmHZywlXQ1RhLhUFV3CalGrkijowzoLkExThCQ9JVoYvhUaPpPSnwurmJg
	 Gx74jvMioeK+xJyyFYoAuVSPFiimP0fp0xpqUcUSQK1uHYo0pbb8+nYUmxpVdAp2Ss
	 o4gohlkY3H7JBc8fiVTx8s9NJaMqsVqZu14qAOH36zM6/DUs15JoeZ8uCCVYZOIuED
	 WLY5IT3arfa03YC8zIROUUaBs4u5ooXOFcFaCKoQSg9sz0dFSbNXfbbMrgQvHJNTz1
	 1jk8rxBZ5cl/7oDU5rxmaVjLvctDx5zH/tzVk11Rh+NJJEmKui4SSwGdCh7n48qwhG
	 GjBrvV/tSYtdg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6442944472
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 13:14:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BkPqkNR2;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AB15543805;
	Fri, 27 Mar 2026 13:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872B0C19423;
	Fri, 27 Mar 2026 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617258;
	bh=MHGkZG5QV7bRaXYbxLAbQlzxv69ufJaE6S12MObcdak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkPqkNR2lQHybUjZZFbuDm5jEye2AX4e3z9IW3dJ/NSuIt31S3iBqChcYhgUK5e85
	 XqpVe82Utgu61ue9wEDwd4NRkQ/bLW5ICI7hS45QL1LNtbCycI1bh1/4TmVx0ZnCEk
	 Yu5y90mrvPva2YaijqGLjZjCRGtDxbIMZ1lkJhHmuGyGJVxhoxYJ3eKK8n/pVrad1g
	 +7nutCSfYWQZBBDjfcaTCFOik0xwvLKxqhMFRT9yFH9HDyPqRj8rPL052+ZQztWjjd
	 2DTwH1jB88Pbnp07JLOIn2y7cocQ4YzYKJ9X64YHhBAeQ6c3CblLjO1kArviFuiKN3
	 0osXdr9J4Bn4g==
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v3 12/15] net: ipa: Switch to generic PAS TZ APIs
Date: Fri, 27 Mar 2026 18:40:40 +0530
Message-ID: <20260327131043.627120-13-sumit.garg@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DNSWL_BLOCKED(0.00)[172.234.252.31:from,100.75.92.58:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6442944472
X-Spamd-Bar: -
Message-ID-Hash: TLZGESC5FQVHL2YZOBNI2FM4T5SZOY2D
X-Message-ID-Hash: TLZGESC5FQVHL2YZOBNI2FM4T5SZOY2D
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com, linux-kernel@vger.kernel.org, Sum
 it Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TLZGESC5FQVHL2YZOBNI2FM4T5SZOY2D/>
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
index edead9c48d1f..8feb8493d5b5 100644
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
@@ -754,7 +757,7 @@ static enum ipa_firmware_loader ipa_firmware_loader(struct device *dev)
 		return IPA_LOADER_INVALID;
 out_self:
 	/* We need Trust Zone to load firmware; make sure it's available */
-	if (qcom_scm_is_available())
+	if (qcom_pas_is_available())
 		return IPA_LOADER_SELF;
 
 	return IPA_LOADER_DEFER;
-- 
2.51.0

