Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE360A3802
	for <op-tee@archiver.kernel.org>; Tue, 27 Oct 2026 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=bXiJTRi7;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8u6qZc8
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 55DB4452C7
	for <op-tee@archiver.kernel.org>; Tue, 27 Oct 2026 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793102579;
	bh=CwlwIOypZSr2l8BsZqqRXfrwnXHK6kyyaL4erZOkeQ4=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=bXiJTRi7hOXyPGRij5BM/6d03jK3GyCEtlpZziULT5aYh82E+ytFIt0M0+3GqOY2b
	 dC2W9u0tXArnIpQS91kl7h8DYsk/2jwortfeFBcR1JfIgcwnuk466AZPkX7lfDu3Ma
	 SPMggUentV5bWNeWWBr96fLgLhCsG2YpoahpoLcTBQbm1lGwtetdv/XuO5hFdWXAKY
	 RETO26KxYdBLkLDNmD7iDxUHI1LI5TlVjz+uvNwjc+q+jH2w7w6wtRa6kV7rKMsghx
	 WHgC4KKdxy7VZsOs+OVdqyoxZcmP9IknikFX3xY7Pbfwyia5IncJ16ADNkphzrMl4Y
	 YpII9d1ULtzPA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CD8254505C
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 Oct 2026 12:02:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8u6qZc8;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4364760052;
	Tue, 27 Oct 2026 12:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660421F01240;
	Tue, 27 Oct 2026 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793102560;
	bh=n101vkG0N/G/63SBZEld8AZPiXf6J3zncGJX/JaoIzM=;
	h=From:Date:Subject:To:Cc;
	b=J8u6qZc8g069GwgzmnAC3uMDNUnqXvnD9BP7WZKkQIqY99YlrTnV01nehNpCETVoC
	 TXICza2KEl9OXJL7Xu4T7bPReJCUvKGJoWnHllnvrkX2THMnKomoUu5Z1AtXEmdXqI
	 /ntFNLbBuBrzYmctN/c9KEduzA6p8meF8/ME3jsheazi+LrnXiBlC7iJ7zrQkgyxIw
	 orwlNFczG8oigxjVST8Zh8go1StEdu3i+8Svx+hdTSWqXaAqSB2n3FjqoL3SwVd1gP
	 Bv1EqQQHUYa1aoIULQ98SXUrWpbOJwkHGkC4/4TgEy0mCispiGHoT0ZglJMd9bgGyO
	 xt8LDqqDtROJQ==
Date: Tue, 27 Oct 2026 17:32:20 +0530
Subject: [PATCH v10] media: qcom: Pass proper PAS ID to set_remote_state
 API
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-pas-id-media-v10-1-8a5312d3050e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMuS4GoC/x2MQQqAIBAAvyJ7TliFFPpKdBBbaw+ZKEQg/r2l4
 wzMdGhUmRosqkOlhxvfWcDgpCCeIR+keRcBFq0zaL0uoYnSF+0ctI/RY4qzNy6BJKVS4vf/rds
 YH15rRMNfAAAA
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, bod@kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	RCPT_COUNT_GT_50(0.00)[50];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CD8254505C
X-Spamd-Bar: -------
Message-ID-Hash: VCZLTZW4X5MPHX53EPFUNCHAEARTBEKP
X-Message-ID-Hash: VCZLTZW4X5MPHX53EPFUNCHAEARTBEKP
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcom
 m.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, gourav.kumar@oss.qualcomm.com, Eric Dumazet <edumazet@kernel.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VCZLTZW4X5MPHX53EPFUNCHAEARTBEKP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

As per testing the SCM backend just ignores it while OP-TEE makes
use of it to for proper book keeping purpose.

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
Changes in v10:
- Resent standalone, as all the earlier patches of the series are merged.
- Link to v9: https://lore.kernel.org/all/20260702115835.167602-11-sumit.garg@kernel.org/
---
 drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
 drivers/media/platform/qcom/venus/firmware.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 21f57d37da18..ed2bd0e83797 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -262,5 +262,5 @@ int iris_fw_unload(struct iris_core *core)
 
 int iris_set_hw_state(struct iris_core *core, bool resume)
 {
-	return qcom_pas_set_remote_state(resume, 0);
+	return qcom_pas_set_remote_state(resume, IRIS_PAS_ID);
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

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261027-pas-id-media-7cc70fc5716f

Best regards,
-- 
Sumit Garg <sumit.garg@oss.qualcomm.com>

