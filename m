Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942A710ED675
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:15:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EF22841A38
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774617331;
	bh=xYlvJO+JflPgYH7lV81mrAxzP35EX+W421jGEAyidpM=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=d53CNfArUdsTdMMAahxOkrkns6SJbFI16x3HfLP4CpVHFWLHLIxkTfpBe5LgE6XIx
	 4tzXFZtvIFCBshugYRgQCu0iH6G2W1BJwwzNkaPazYi/zyWvexeKAf/MyZxsm92Jrw
	 SRdEBYbcLMD7OkYnTOtpTgR26UwqqMvJpRA9lfg2T6ETAe7J4PsirMbsb5wm3GC0rn
	 AaUdxnQqYkg2ueSIHquNDeargCKfdJhwCVFjyaumLFMq7/ZUSYEuutMUtJOWZdJZZj
	 wsJAm23Fef9Jpv2e5paPDp8JDNNUrdr/l5JQpLMnkGXGDR9pvCAsigB4RSfO+E/po9
	 IYr3H3vh9XD2w==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 22E63444E4
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 13:13:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ATyfvKGU;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A125060103;
	Fri, 27 Mar 2026 13:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21E6C2BC87;
	Fri, 27 Mar 2026 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617212;
	bh=xYlvJO+JflPgYH7lV81mrAxzP35EX+W421jGEAyidpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATyfvKGUmnv1kKnubs6IiLKUN4mUdaYjdI2G6QVAhehE1B+B5pM968CUWnh79vDZV
	 qbcMBvWPgvwiD8IfqILDBYLus+CdHaP+aJHmLJBKSqCtSir41Tl5Cpm4QMkTkCPgTJ
	 b9WmzcQzgu7PJzM9xxBssGMWIrteWCePRPk4eTjtAldyIv3ebIFX+S8Ie6RXbp4OjN
	 Yflewz9fGgFda2MnKV3CQPSSMoHW6V2p9ESaCH5pfAyW5XIkeUOvRYnxzgO3JlOP9l
	 7BiDeSrZZmh7v6bzIKiRDOEHfDZu1fbPpNxk1WA8p2wrioLUAppV1dth3AKcUL5HIw
	 Qp3sRJpgPNQHQ==
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v3 09/15] remoteproc: qcom: Select QCOM_PAS generic service
Date: Fri, 27 Mar 2026 18:40:37 +0530
Message-ID: <20260327131043.627120-10-sumit.garg@kernel.org>
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
X-Rspamd-Queue-Id: 22E63444E4
X-Spamd-Bar: -
Message-ID-Hash: ID5U57E4Y7MSCY7V5P7COBU3PAT7DDX4
X-Message-ID-Hash: ID5U57E4Y7MSCY7V5P7COBU3PAT7DDX4
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com, linux-kernel@vger.kernel.org, Sum
 it Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ID5U57E4Y7MSCY7V5P7COBU3PAT7DDX4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Select PAS generic service driver to enable support for multiple PAS
backends like OP-TEE in addition to SCM.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/remoteproc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index ee54436fea5a..da3c5d9562ea 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -230,6 +230,7 @@ config QCOM_Q6V5_PAS
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
+	select QCOM_PAS
 	help
 	  Say y here to support the TrustZone based Peripheral Image Loader for
 	  the Qualcomm remote processors. This is commonly used to control
-- 
2.51.0

