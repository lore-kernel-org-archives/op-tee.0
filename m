Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E356FF886F
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 13:13:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E773E44436
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777900404;
	bh=cuJVLyHTKM53teKh8tj+VLyVnHsaXPxTB0IJOZNZvtY=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XxEqCZBbiaG6g6vEzcxW6+9nhch4izx4of14LS+Z48dfMC0T369JznfEl4UUcxkaZ
	 C5fkMtApocGtVPlseMkV2CDFzCg8LfUJdMcv8IGXP/GIMZ5qF24gs5cmVcXPwqoNgn
	 mYDkVuG4AaTO2rpaW9bXbTIyGx3QPlEuNure63M5yI6ON2LlnWsv32vYYNFA1SEZz8
	 2SNkUXo1GG8qLpzXH0tJNwYQgnMts/LT+FdiuOdPygmtwUQjaA4qCUSZYtA8H2a+7f
	 QPM52xX6REdVPZDloBQTXe2oRGmIAcxur50E2ejlGseUikdpq8xQMLfCBcrn7izATa
	 OcNNXXuJ1Iw1A==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C02E444E44
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 May 2026 13:10:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nRSU+fFy;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 720CC60132;
	Mon,  4 May 2026 13:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4EAC2BCF5;
	Mon,  4 May 2026 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777900243;
	bh=cuJVLyHTKM53teKh8tj+VLyVnHsaXPxTB0IJOZNZvtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRSU+fFySY/fqxe2zCYNuwmSTTzsKF3itFzmf96037qhdi7D50B50saOUHtuQlI5r
	 yiz9xZgVlSdw33LIyKihgwKmAk/I3/AYozc+kfvONN/K0tY48pyh3RS0bnh54sNNXt
	 93AprMm1wDBPD2xHztAPqK1kDfAJ8zznj5MDttQYG22/9dn38wa3IvUqMZ8Ma40NSb
	 0Lnr2xuhUobWuLJ4Kyn6i/9dapJk3KBH/GUSR4JQgVceaJ1ksXQ+2tahVEvX/NdQhd
	 Ju1oxwD/ZXylE5IjHVv4i66CZAZKZStW8Z+dCm2GevvnlxMfnOluezyDF78YgYKB3a
	 DdYxP8W7dz1ww==
To: andersson@kernel.org,
	konradybcio@kernel.org
Subject: [PATCH v5 15/16] firmware: qcom_scm: Remove SCM PAS wrappers
Date: Mon,  4 May 2026 18:36:02 +0530
Message-ID: <20260504130603.1474043-16-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260504130603.1474043-1-sumit.garg@kernel.org>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C02E444E44
X-Spamd-Bar: --
Message-ID-Hash: IAMN24MV2Z2E2CI3M3MRI3SUUTMOFIQP
X-Message-ID-Hash: IAMN24MV2Z2E2CI3M3MRI3SUUTMOFIQP
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IAMN24MV2Z2E2CI3M3MRI3SUUTMOFIQP/>
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

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 143 +++++--------------------
 include/linux/firmware/qcom/qcom_scm.h |  29 -----
 2 files changed, 29 insertions(+), 143 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index d87a962e93da..2493b200696b 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -553,26 +553,6 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
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
@@ -630,9 +610,9 @@ static int qcom_scm_pas_prep_and_init_image(struct device *dev,
 	return ret ? : res.result[0];
 }
 
-static int __qcom_scm_pas_init_image2(struct device *dev, u32 pas_id,
-				      const void *metadata, size_t size,
-				      struct qcom_pas_context *ctx)
+static int qcom_scm_pas_init_image(struct device *dev, u32 pas_id,
+				   const void *metadata, size_t size,
+				   struct qcom_pas_context *ctx)
 {
 	struct qcom_scm_res res;
 	dma_addr_t mdata_phys;
@@ -672,16 +652,8 @@ static int __qcom_scm_pas_init_image2(struct device *dev, u32 pas_id,
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
-static void __qcom_scm_pas_metadata_release(struct device *dev,
-					    struct qcom_pas_context *ctx)
+static void qcom_scm_pas_metadata_release(struct device *dev,
+					  struct qcom_pas_context *ctx)
 {
 	if (ctx->use_tzmem)
 		qcom_tzmem_free(ctx->ptr);
@@ -691,15 +663,8 @@ static void __qcom_scm_pas_metadata_release(struct device *dev,
 	ctx->ptr = NULL;
 }
 
-void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
-{
-	__qcom_scm_pas_metadata_release(__scm->dev,
-					(struct qcom_pas_context *)ctx);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
-
-static int __qcom_scm_pas_mem_setup(struct device *dev, u32 pas_id,
-				    phys_addr_t addr, phys_addr_t size)
+static int qcom_scm_pas_mem_setup(struct device *dev, u32 pas_id,
+				  phys_addr_t addr, phys_addr_t size)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -730,12 +695,6 @@ static int __qcom_scm_pas_mem_setup(struct device *dev, u32 pas_id,
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
@@ -789,11 +748,10 @@ static void *__qcom_scm_pas_get_rsc_table(struct device *dev, u32 pas_id,
 	return ret ? ERR_PTR(ret) : output_rt_tzm;
 }
 
-static void *__qcom_scm_pas_get_rsc_table2(struct device *dev,
-					   struct qcom_pas_context *ctx,
-					   void *input_rt,
-					   size_t input_rt_size,
-					   size_t *output_rt_size)
+static void *qcom_scm_pas_get_rsc_table(struct device *dev,
+					struct qcom_pas_context *ctx,
+					void *input_rt, size_t input_rt_size,
+					size_t *output_rt_size)
 {
 	struct resource_table empty_rsc = {};
 	size_t size = SZ_16K;
@@ -864,19 +822,7 @@ static void *__qcom_scm_pas_get_rsc_table2(struct device *dev,
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
-static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
+static int qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -905,14 +851,8 @@ static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_auth_and_reset(u32 pas_id)
-{
-	return __qcom_scm_pas_auth_and_reset(__scm->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
-
-static int __qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
-						 struct qcom_pas_context *ctx)
+static int qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
+					       struct qcom_pas_context *ctx)
 {
 	u64 handle;
 	int ret;
@@ -923,7 +863,7 @@ static int __qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	 * memory region and then invokes a call to TrustZone to authenticate.
 	 */
 	if (!ctx->use_tzmem)
-		return __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+		return qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 
 	/*
 	 * When Linux runs @ EL2 Linux must create the shmbridge itself and then
@@ -933,21 +873,14 @@ static int __qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+	ret = qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 	qcom_tzmem_shm_bridge_delete(handle);
 
 	return ret;
 }
 
-int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
-{
-	return __qcom_scm_pas_prepare_and_auth_reset(__scm->dev,
-						     (struct qcom_pas_context *)ctx);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_prepare_and_auth_reset);
-
-static int __qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
-					   u32 pas_id)
+static int qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
+					 u32 pas_id)
 {
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_BOOT,
@@ -965,13 +898,7 @@ static int __qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_set_remote_state(u32 state, u32 id)
-{
-	return __qcom_scm_pas_set_remote_state(__scm->dev, state, id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
-
-static int __qcom_scm_pas_shutdown(struct device *dev, u32 pas_id)
+static int qcom_scm_pas_shutdown(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -1000,13 +927,7 @@ static int __qcom_scm_pas_shutdown(struct device *dev, u32 pas_id)
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_shutdown(u32 pas_id)
-{
-	return __qcom_scm_pas_shutdown(__scm->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_shutdown);
-
-static bool __qcom_scm_pas_supported(struct device *dev, u32 pas_id)
+static bool qcom_scm_pas_supported(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -1027,23 +948,17 @@ static bool __qcom_scm_pas_supported(struct device *dev, u32 pas_id)
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
-	.supported		= __qcom_scm_pas_supported,
-	.init_image		= __qcom_scm_pas_init_image2,
-	.mem_setup		= __qcom_scm_pas_mem_setup,
-	.get_rsc_table		= __qcom_scm_pas_get_rsc_table2,
-	.auth_and_reset		= __qcom_scm_pas_auth_and_reset,
-	.prepare_and_auth_reset	= __qcom_scm_pas_prepare_and_auth_reset,
-	.set_remote_state	= __qcom_scm_pas_set_remote_state,
-	.shutdown		= __qcom_scm_pas_shutdown,
-	.metadata_release	= __qcom_scm_pas_metadata_release,
+	.supported		= qcom_scm_pas_supported,
+	.init_image		= qcom_scm_pas_init_image,
+	.mem_setup		= qcom_scm_pas_mem_setup,
+	.get_rsc_table		= qcom_scm_pas_get_rsc_table,
+	.auth_and_reset		= qcom_scm_pas_auth_and_reset,
+	.prepare_and_auth_reset	= qcom_scm_pas_prepare_and_auth_reset,
+	.set_remote_state	= qcom_scm_pas_set_remote_state,
+	.shutdown		= qcom_scm_pas_shutdown,
+	.metadata_release	= qcom_scm_pas_metadata_release,
 };
 
 /**
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

