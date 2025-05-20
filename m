Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EF2C3DA6D
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:30:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 25BAF42E3C
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:30:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sKH2Dl0d;
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A430345B33
	for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 15:24:58 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so340881666b.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747754698; x=1748359498; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sws8LggPb3Nr4WEIwk49/i4GQcd2qsiJjDBUK0g1c0s=;
        b=sKH2Dl0dGvMGxw5TooO/EjA/7RdkgSUDUNj9ituvidJ/nLTYvmY198u69maYsZEGrw
         kTobg9hEEklPa0gfbdIBPmT2NdHDKxvKP9yAzu3hAHOQQClBviftKC12pLzRrWVEh8zo
         AYkp9jMTkofkxXPLK/odLKn2wVXfK4yCQqIH+2RSkcf3VpLuzN5ClG3sC5wOb8Ongu4/
         ku1AF5Q96HV5cN3bK7DZrBVnOpfJPRcI3cbhEgcO+KdDktXaKm2D44gY0/3Zc1qaHDFj
         2mvcTM8FAjFKUqz0lxYf6Ih+kXHTDbOcl1v5qS0mFj3rGRW4MYTXmA+FD3ilALQxiQLu
         zS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754698; x=1748359498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sws8LggPb3Nr4WEIwk49/i4GQcd2qsiJjDBUK0g1c0s=;
        b=hHv1zIb4SHsdAeQC52xNkg4btLDyQiFFCa4NOz7EwDXGO4MGtkN1c49TZo+D08acFJ
         kgMjZQ8M7CMyWtA1AMhrDR9LJxQj5a5Nl+ATZoMEDZoWx5K2YwYZkpzwNZY6mElCdDIa
         Z86/OSoWCigokymx8MYVrkD5wLY18bzwBAuF/jvZ8oa0SOzmtv5PleSxYNg3EEwj8ZRJ
         qmjDAo8e8w3A/mC0FFg38CVeo1O58kXvITZVcCaBMQ258oCUpMolt6hm+4aGsApJSJAk
         +MbaJ3zmX96mgbUfg7GtqHPwY97KjEacWMT6XwR378+XGk2mesft44nJVeWXZcM7i3z5
         Zlsg==
X-Forwarded-Encrypted: i=1; AJvYcCV7EQ8uozauT6huwpoUwztf1eZ2PbQTXk716JlfWJtJteZbvr3sLYN8jh/cY+B4iaKdWmJOYew=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzNZzHSzPxlsGuUqaBgP6MNyBHQ8zoYTxrYQaFomCX2+jP8CfkO
	aFxhQyXDdMO/Lb9kuAbzKcqEOQP9qNyDQZVaJ2O3udvz5QGlmeLQ0KnVEg70mX/afCj6Ow==
X-Gm-Gg: ASbGncv7O/WFTTXOzo1mWN3pUpx5e/vYY/w04l9WARlDMU4ZvjASQL1suNg5NCPrjdT
	XJSRcQE8u7LS2hvgPfuGJ7YBNAChTm++KX5U16ImQc3spoDS0KmSGhdkxMoLWz+oErfMlN6a6lf
	q9YVcQGt/tOEgRZtf4t+5hpHPUgqrMXvBiFhhXFlaJaYYtWf0ZXwz0yMRXq6WIPVWap4IbBrC/T
	DCxHsHk23xcp+mCdKwaNV+pprJDTL5Dr7jEscoyra0qdsSr9Z4zNJ+b9Jp6mcEC8nW4oXyBWVBI
	ohCfC/hV0FZ9TJd/xo/ePNklloub6S2B6DqoRZT80KvCr5W6+JU4Ee15q0oduu2L3zV33uVEcDD
	0tToD6PG8iURiDAYmCAavqp6XDFp6rXDimFJOIs0=
X-Google-Smtp-Source: AGHT+IFajjrVIsC7kJISaAObbiybAYfu3AaUSsn1KJ4AT03AxVtsB+czB4nAf85bGG6wnrUQQg0qnQ==
X-Received: by 2002:a17:907:7f08:b0:ac7:3817:d8da with SMTP id a640c23a62f3a-ad52d609170mr1346626366b.52.1747754697525;
        Tue, 20 May 2025 08:24:57 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278257sm742608766b.82.2025.05.20.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:24:56 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 9/9] optee: smc abi: dynamic protected memory allocation
Date: Tue, 20 May 2025 17:16:52 +0200
Message-ID: <20250520152436.474778-10-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520152436.474778-1-jens.wiklander@linaro.org>
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.10 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.50:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.50:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A430345B33
Message-ID-Hash: TFQAIZ23STQ5DCALVUYIH6HYYCGBE5A3
X-Message-ID-Hash: TFQAIZ23STQ5DCALVUYIH6HYYCGBE5A3
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TFQAIZ23STQ5DCALVUYIH6HYYCGBE5A3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add support in the OP-TEE backend driver for dynamic protected memory
allocation using the SMC ABI.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/smc_abi.c | 102 ++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 17 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index f3cae8243785..6b3fbe7f0909 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -965,6 +965,70 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 	return rc;
 }
 
+static int optee_smc_lend_protmem(struct optee *optee, struct tee_shm *protmem,
+				  u16 *end_points, unsigned int ep_count,
+				  u32 use_case)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg = optee_get_msg_arg(optee->ctx, 2, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_LEND_PROTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	msg_arg->params[0].u.value.a = use_case;
+	msg_arg->params[1].attr = OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
+	msg_arg->params[1].u.tmem.buf_ptr = protmem->paddr;
+	msg_arg->params[1].u.tmem.size = protmem->size;
+	msg_arg->params[1].u.tmem.shm_ref = (u_long)protmem;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret != TEEC_SUCCESS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	protmem->sec_world_id = (u_long)protmem;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
+static int optee_smc_reclaim_protmem(struct optee *optee,
+				     struct tee_shm *protmem)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg = optee_get_msg_arg(optee->ctx, 1, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_RECLAIM_PROTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+	msg_arg->params[0].u.rmem.shm_ref = (u_long)protmem;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret != TEEC_SUCCESS)
+		rc = -EINVAL;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
 /*
  * 5. Asynchronous notification
  */
@@ -1216,6 +1280,8 @@ static const struct optee_ops optee_ops = {
 	.do_call_with_arg = optee_smc_do_call_with_arg,
 	.to_msg_param = optee_to_msg_param,
 	.from_msg_param = optee_from_msg_param,
+	.lend_protmem = optee_smc_lend_protmem,
+	.reclaim_protmem = optee_smc_reclaim_protmem,
 };
 
 static int enable_async_notif(optee_invoke_fn *invoke_fn)
@@ -1586,11 +1652,14 @@ static inline int optee_load_fw(struct platform_device *pdev,
 
 static int optee_protmem_pool_init(struct optee *optee)
 {
+	bool protm = optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM;
+	bool dyn_protm = optee->smc.sec_caps &
+			 OPTEE_SMC_SEC_CAP_DYNAMIC_PROTMEM;
 	enum tee_dma_heap_id heap_id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
-	struct tee_protmem_pool *pool;
-	int rc;
+	struct tee_protmem_pool *pool = ERR_PTR(-EINVAL);
+	int rc = -EINVAL;
 
-	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM) {
+	if (protm) {
 		union {
 			struct arm_smccc_res smccc;
 			struct optee_smc_get_protmem_config_result result;
@@ -1598,26 +1667,26 @@ static int optee_protmem_pool_init(struct optee *optee)
 
 		optee->smc.invoke_fn(OPTEE_SMC_GET_PROTMEM_CONFIG, 0, 0, 0, 0,
 				     0, 0, 0, &res.smccc);
-		if (res.result.status != OPTEE_SMC_RETURN_OK) {
-			pr_err("Secure Data Path service not available\n");
-			return 0;
-		}
-		rc = optee_set_dma_mask(optee, res.result.pa_width);
+		if (res.result.status == OPTEE_SMC_RETURN_OK)
+			rc = optee_set_dma_mask(optee, res.result.pa_width);
 		if (!rc)
 			pool = tee_protmem_static_pool_alloc(res.result.start,
 							     res.result.size);
-		if (IS_ERR(pool))
-			return PTR_ERR(pool);
+	}
 
+	if (dyn_protm && IS_ERR(pool))
+		pool = optee_protmem_alloc_dyn_pool(optee, heap_id);
+
+	if (!IS_ERR(pool)) {
 		rc = tee_device_register_dma_heap(optee->teedev, heap_id, pool);
 		if (rc)
-			goto err;
+			pool->ops->destroy_pool(pool);
 	}
 
+	if (protm || dyn_protm)
+		return rc;
+
 	return 0;
-err:
-	pool->ops->destroy_pool(pool);
-	return rc;
 }
 
 static int optee_probe(struct platform_device *pdev)
@@ -1788,9 +1857,8 @@ static int optee_probe(struct platform_device *pdev)
 		pr_info("Asynchronous notifications enabled\n");
 	}
 
-	rc = optee_protmem_pool_init(optee);
-	if (rc)
-		goto err_notif_uninit;
+	if (optee_protmem_pool_init(optee))
+		pr_info("Protected memory service not available\n");
 
 	/*
 	 * Ensure that there are no pre-existing shm objects before enabling
-- 
2.43.0

