Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666A1FED2CC
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 06:38:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BA1E84389E
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 06:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773297486;
	bh=ph2CnyWrkdsg4Xijfgxsxm+iahK50TtAU8/Tx//bQqY=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=aOg4oCyeIAXw00s8qf67APSAsP9/uHwy7+lFiU7H2WDtXiF0IOw9LjuDHSTihbLkz
	 Tfg7ht/33FPRyxOjMLaWkQCYvsPECgPmEGPwS+stwmsUOy2k8iB2MtM9XKMGvujLtf
	 sauMBxw2GXhohZXLCGnJfK63uZ+wA16glFLZOnYOC4juftFeDJdnKRbMho5NDYYH4s
	 FIVyu4oEWxOPoaFygqoUk5i/Gb7ckZ+j0bdXfVVw4NQetGnx/0b6twufKrVeyyS8qi
	 gm4AWlOtAPLZFIl6LadKvD/WTrrdWpTmqhfzce8uft/6VWi7sDLPIk9VcfcUAokB1m
	 zViqFjqqhZ1BA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0606643942
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Mar 2026 06:32:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SGvW+5Fc;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D7344090D;
	Thu, 12 Mar 2026 06:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D9DC116C6;
	Thu, 12 Mar 2026 06:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773297128;
	bh=ph2CnyWrkdsg4Xijfgxsxm+iahK50TtAU8/Tx//bQqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGvW+5FcXGpx1NzGR+7acP61YSEmu93UjNUUCjVHg4HjCCnSYYtfPerCG/JmqQuHs
	 zaaadXjw50U8ZYlMY+P4UGOxlEKuDoCBPOB2Oxz+4OERmgqrlssOzaXmDN1XG4QzRs
	 ahaMfX3w8SWLxsWQgw9QKHwbEI5KGeeRy/+1qx+NIKeH8TfOTTmrdpWtJB8iZfz3aO
	 NGSECktV8vBRT48E+BZVIhj5DBso+JGDHAOggI/99bC1ZSh+3FfWmtpwx8vp60/GvS
	 5AjaeTpv6/uXQEbjwzI6uJZbXgoM+TFji5txKxPqAwD2RJGAfwlVh0SVfTsi3PzjWO
	 cZFcKsEwe3ekQ==
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v2 14/15] firmware: qcom_scm: Remove SCM PAS wrappers
Date: Thu, 12 Mar 2026 11:57:55 +0530
Message-ID: <20260312062756.694390-15-sumit.garg@kernel.org>
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
X-Rspamd-Queue-Id: 0606643942
X-Spamd-Bar: --
Message-ID-Hash: 53F7X4DQAGB5K5G3Q4WFDMLQSW5EC73M
X-Message-ID-Hash: 53F7X4DQAGB5K5G3Q4WFDMLQSW5EC73M
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualco
 mm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/53F7X4DQAGB5K5G3Q4WFDMLQSW5EC73M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Now since all the Qcom SCM client drivers have been migrated over to
generic PAS TZ service, let's drop the exported SCM PAS wrappers.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 84 --------------------------
 include/linux/firmware/qcom/qcom_scm.h | 29 ---------
 2 files changed, 113 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 2d7937ae7c8f..ce68ed294d78 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -554,26 +554,6 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
 		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
 }
 
-struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
-							     u32 pas_id,
-							     phys_addr_t mem_phys,
-							     size_t mem_size)
-{
-	struct qcom_pas_context *ctx;
-
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return ERR_PTR(-ENOMEM);
-
-	ctx->dev = dev;
-	ctx->pas_id = pas_id;
-	ctx->mem_phys = mem_phys;
-	ctx->mem_size = mem_size;
-
-	return (struct qcom_scm_pas_context *)ctx;
-}
-EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_alloc);
-
 static int __qcom_scm_pas_init_image(struct device *dev, u32 pas_id,
 				     dma_addr_t mdata_phys,
 				     struct qcom_scm_res *res)
@@ -674,14 +654,6 @@ static int __qcom_scm_pas_init_image2(struct device *dev, u32 pas_id,
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
-			    struct qcom_scm_pas_context *ctx)
-{
-	return __qcom_scm_pas_init_image2(__scm->dev, pas_id, metadata, size,
-					  (struct qcom_pas_context *)ctx);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
-
 static void __qcom_scm_pas_metadata_release(struct device *dev,
 					    struct qcom_pas_context *ctx)
 {
@@ -693,13 +665,6 @@ static void __qcom_scm_pas_metadata_release(struct device *dev,
 	ctx->ptr = NULL;
 }
 
-void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
-{
-	__qcom_scm_pas_metadata_release(__scm->dev,
-					(struct qcom_pas_context *)ctx);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
-
 static int __qcom_scm_pas_mem_setup(struct device *dev, u32 pas_id,
 				    phys_addr_t addr, phys_addr_t size)
 {
@@ -732,12 +697,6 @@ static int __qcom_scm_pas_mem_setup(struct device *dev, u32 pas_id,
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
-{
-	return __qcom_scm_pas_mem_setup(__scm->dev, pas_id, addr, size);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_mem_setup);
-
 static void *__qcom_scm_pas_get_rsc_table(struct device *dev, u32 pas_id,
 					  void *input_rt_tzm,
 					  size_t input_rt_size,
@@ -867,18 +826,6 @@ static void *__qcom_scm_pas_get_rsc_table2(struct device *dev,
 	return ret ? ERR_PTR(ret) : tbl_ptr;
 }
 
-struct resource_table *qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx,
-						  void *input_rt,
-						  size_t input_rt_size,
-						  size_t *output_rt_size)
-{
-	return __qcom_scm_pas_get_rsc_table2(__scm->dev,
-					     (struct qcom_pas_context *)ctx,
-					     input_rt, input_rt_size,
-					     output_rt_size);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_get_rsc_table);
-
 static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 {
 	int ret;
@@ -908,12 +855,6 @@ static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_auth_and_reset(u32 pas_id)
-{
-	return __qcom_scm_pas_auth_and_reset(__scm->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
-
 static int __qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 						 struct qcom_pas_context *ctx)
 {
@@ -942,13 +883,6 @@ static int __qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	return ret;
 }
 
-int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
-{
-	return __qcom_scm_pas_prepare_and_auth_reset(__scm->dev,
-						     (struct qcom_pas_context *)ctx);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_prepare_and_auth_reset);
-
 static int __qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
 					   u32 pas_id)
 {
@@ -968,12 +902,6 @@ static int __qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_set_remote_state(u32 state, u32 id)
-{
-	return __qcom_scm_pas_set_remote_state(__scm->dev, state, id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
-
 static int __qcom_scm_pas_shutdown(struct device *dev, u32 pas_id)
 {
 	int ret;
@@ -1003,12 +931,6 @@ static int __qcom_scm_pas_shutdown(struct device *dev, u32 pas_id)
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_shutdown(u32 pas_id)
-{
-	return __qcom_scm_pas_shutdown(__scm->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_shutdown);
-
 static bool __qcom_scm_pas_supported(struct device *dev, u32 pas_id)
 {
 	int ret;
@@ -1030,12 +952,6 @@ static bool __qcom_scm_pas_supported(struct device *dev, u32 pas_id)
 	return ret ? false : !!res.result[0];
 }
 
-bool qcom_scm_pas_supported(u32 pas_id)
-{
-	return __qcom_scm_pas_supported(__scm->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_supported);
-
 static struct qcom_pas_ops qcom_pas_ops_scm = {
 	.drv_name		= "qcom_scm",
 	.supported		= __qcom_scm_pas_supported,
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 5747bd191bf1..a0a6bc0229c4 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -64,35 +64,6 @@ bool qcom_scm_is_available(void);
 int qcom_scm_set_cold_boot_addr(void *entry);
 int qcom_scm_set_warm_boot_addr(void *entry);
 void qcom_scm_cpu_power_down(u32 flags);
-int qcom_scm_set_remote_state(u32 state, u32 id);
-
-struct qcom_scm_pas_context {
-	struct device *dev;
-	u32 pas_id;
-	phys_addr_t mem_phys;
-	size_t mem_size;
-	void *ptr;
-	dma_addr_t phys;
-	ssize_t size;
-	bool use_tzmem;
-};
-
-struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
-							     u32 pas_id,
-							     phys_addr_t mem_phys,
-							     size_t mem_size);
-int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
-			    struct qcom_scm_pas_context *ctx);
-void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx);
-int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
-int qcom_scm_pas_auth_and_reset(u32 pas_id);
-int qcom_scm_pas_shutdown(u32 pas_id);
-bool qcom_scm_pas_supported(u32 pas_id);
-struct resource_table *qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx,
-						  void *input_rt, size_t input_rt_size,
-						  size_t *output_rt_size);
-
-int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
-- 
2.51.0

