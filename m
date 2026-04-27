Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE64FF885E
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 09:59:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5902E44D9B
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777283946;
	bh=5si9p9X+QdKOUj/kEC+OxqljHo6dif086Up1Mo3twcA=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=K0h0h7DFOdYX+FZtpvsicC7XAVpLbpxZzMwuU3S/IBRCyq4Wp41uY3rDxZg7TyXka
	 +cpMCPSSnNZIRJJ89Pn50PSWIr5d1ykP2WObwYVLFBVBm1kBeKVy6b+3AgIFLwgyB2
	 rLWlHiudA+7f49Q3rBF7x4xCqvIuMFwLptnOC0jtSJ8n3xzAFd0sTPqR2rfVTV5jpA
	 Wvk1ryVJ3zqQQkF7Vb5g6okeVNu12/f7dQRd/h5iRY9NaBmhjF0p669TlfXCHPAlRe
	 16E1KRQMFDadE56IIPPRNJJHPPEZjeItJKvWo8GalzOXvFpv/RCmJY17XRCb7L8Eyc
	 ug97nh+gb1WaQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 615AE44D7B
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 09:57:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aZ9bXcmJ;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1158960138;
	Mon, 27 Apr 2026 09:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FBBC19425;
	Mon, 27 Apr 2026 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283872;
	bh=5si9p9X+QdKOUj/kEC+OxqljHo6dif086Up1Mo3twcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZ9bXcmJU6u6s38rF4Nnjw6SoDEJKoVZH8lE1sqhS0fDzscFXMeSO1kjVR3xRILKl
	 m1PsnyF4zb+1zveZDnnfNPCabApls2FlymUpbpIaQZQtCe0U2bLrB4qVoTUzqjGY+Z
	 pzCRiL0kVtcpgq2S7J5Vplz6vnQO4GZ6oAfna42tHLBOMJdR3l/54iYqLuMmqT94Ho
	 y34bDP5x4w28FrvSsd5nxlKVWQLeDzcE5YMUiuyaTQEg514ouNZB7optAFLtx7xvFP
	 tYlswTDUg72W3VxO34uOVAyv4q5/oZxsXmhzy4oZaf9l8cQYCgbgcWmW/fsQ+GY3EJ
	 BpRtrPMLsj9Bg==
To: andersson@kernel.org,
	konradybcio@kernel.org
Subject: [PATCH v4 06/15] remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
Date: Mon, 27 Apr 2026 15:25:54 +0530
Message-ID: <20260427095603.1157963-7-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427095603.1157963-1-sumit.garg@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.33 / 15.00];
	BAYES_HAM(-1.67)[92.91%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 615AE44D7B
X-Spamd-Bar: /
Message-ID-Hash: XKTEDPB7YEDOS3ZZDBU57MVEBCGHFT3W
X-Message-ID-Hash: XKTEDPB7YEDOS3ZZDBU57MVEBCGHFT3W
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XKTEDPB7YEDOS3ZZDBU57MVEBCGHFT3W/>
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

