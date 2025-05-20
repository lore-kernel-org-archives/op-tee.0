Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC3CC3ABDD
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:29:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0D93445AA1
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:29:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sqczqIC6;
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DF20C45B2B
	for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 15:24:54 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad51ba0af48so897855266b.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747754694; x=1748359494; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bld2F8yZ54kGs1+iy6D0HdLuVG17oYynXY/XfJVpzy4=;
        b=sqczqIC67/KHq+vQCiCqSx2t+iacFy5bsza2NFTTUF+ddY7pyy70UFZF9AQSkFeV8Q
         UZu/jENByBgr7RMrusat9JpXjj3CEEKgBMksCsGS2wBuchd7Ebnndx6vS3oBxEloFChP
         H98/F95res5Yr7Nxm1Gev7VAlBEjG0s+5l5l/VA9tGNCxG71dxOw5rISodwimFjWt+lA
         yMCwphyFqnT/1UHsBdL40KhkUVLumzBLi5pJ97X8/toAbmUXVHlHT5cyIG7g85bZVZg1
         PuXeUtrW1lMbyVr+ul/5k6U7xu2mkJInZ3JoZEI45zTY0IUkIoQbo4OM8qpQfVKImhW4
         nPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754694; x=1748359494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bld2F8yZ54kGs1+iy6D0HdLuVG17oYynXY/XfJVpzy4=;
        b=YVc+WI+R5DYpKPJ83EClYi4QHKH0JLgomwz/ioNiVphMSrroi2fyqvWEdiaDVwmkbt
         lW9M+0rFTNR0T2C7I8/9eQsAJEYFdRMXqg9NacH7XlzDmjhM7QGg9UFw7kHPKfhk/wWy
         Yulp+vC0xy0oAJq2jLhQwfH0dBOQ77+neCBpadlAtbHSzEakYwop6UGj7OtBEI686btT
         Ld6XKGNKrynKmqqKWxZrJnz7cE9s6ifS6fxS0f/u9ReXZIt47MQjjZvB5c5RHPkXe6k3
         tkGfWNgkGJwmSPuQLV7Dr/l2JfXl6fAgtRn4wCZly40ce90Mk6ISGsGD3LtJSPSscPWG
         S8WA==
X-Forwarded-Encrypted: i=1; AJvYcCXOuwJ2ujksV0jY/G2ddSFyqUbKhSQBMd3qRbJym12OvjhyTDz4nI1u4qIJX+HtRCVjR9ORFRw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwpIQDa4YubXB47bX6Sxjw7LJE5DjO82aSsIEWLa931WJU71GgW
	Nqc7yghXEOhnos3hCZ58iJkwpSSof/+JAhwWsIS6//X5LnfLM8mm3AOuhzeJCeVYMtH3iw==
X-Gm-Gg: ASbGncuEavwOuH2/WBo8WxZwxMLp4k67Z4QQbY8e2q3IKLK+yDh2MI+mMd5kym7pq9+
	4l7b+tpEM8/GJ5htOUz5xKF5OA99At7Ekg3C32djdSgAeWET9yBrt6OeZMx/jOevFQoRBvKYswg
	SN9QxWGuzWkHTG44asJ4nfcACrBT33zrHbqda6/58rRIbV/JrCYRhpeQuM7q5AU7mJ8teeH/PuI
	7buM2XNvgDh+aq+Tzg51Wh6EBgsi74/S60EHaJD/Zf9E9Gdy96jNmfBVyXE85bU9VB+7itedjTf
	YG9pIkr9k1ELm6qhMSXWFM+8zs/Ai+N9fL0ARbmkd2i0th9sJMKsNYs9pMDu3XTRgcPZ9Ob5Vuu
	27Z+RfkAs81Cy/J6fgHnQL4ojsugr
X-Google-Smtp-Source: AGHT+IE+oU//7EkaWaSVnBEAmENTiykO6EjOUBrIKYl9jX9zjcRr0m/0LP96+ZckH975FqdkGFgQKA==
X-Received: by 2002:a17:907:3e28:b0:ad5:2d5d:206f with SMTP id a640c23a62f3a-ad52fa567ccmr1750869866b.19.1747754693784;
        Tue, 20 May 2025 08:24:53 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278257sm742608766b.82.2025.05.20.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:24:53 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 7/9] optee: support protected memory allocation
Date: Tue, 20 May 2025 17:16:50 +0200
Message-ID: <20250520152436.474778-8-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520152436.474778-1-jens.wiklander@linaro.org>
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.10 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.52:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.52:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DF20C45B2B
Message-ID-Hash: ZQPCGAEOGW2ENID5NBW47DNCNZNPOGKZ
X-Message-ID-Hash: ZQPCGAEOGW2ENID5NBW47DNCNZNPOGKZ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZQPCGAEOGW2ENID5NBW47DNCNZNPOGKZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add support in the OP-TEE backend driver for protected memory
allocation. The support is limited to only the SMC ABI and for secure
video buffers.

OP-TEE is probed for the range of protected physical memory and a
memory pool allocator is initialized if OP-TEE have support for such
memory.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c          | 10 +++++++
 drivers/tee/optee/optee_private.h |  2 ++
 drivers/tee/optee/smc_abi.c       | 45 +++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index c75fddc83576..4b14a7ac56f9 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -56,6 +56,15 @@ int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long action,
 	return 0;
 }
 
+int optee_set_dma_mask(struct optee *optee, u_int pa_width)
+{
+	u64 mask = DMA_BIT_MASK(min(64, pa_width));
+
+	optee->teedev->dev.dma_mask = &optee->teedev->dev.coherent_dma_mask;
+
+	return dma_set_mask_and_coherent(&optee->teedev->dev, mask);
+}
+
 static void optee_bus_scan(struct work_struct *work)
 {
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
@@ -181,6 +190,7 @@ void optee_remove_common(struct optee *optee)
 	tee_device_unregister(optee->supp_teedev);
 	tee_device_unregister(optee->teedev);
 
+	tee_device_unregister_all_dma_heaps(optee->teedev);
 	tee_shm_pool_free(optee->pool);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index dc0f355ef72a..5e3c34802121 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -272,6 +272,8 @@ struct optee_call_ctx {
 
 extern struct blocking_notifier_head optee_rpmb_intf_added;
 
+int optee_set_dma_mask(struct optee *optee, u_int pa_width);
+
 int optee_notif_init(struct optee *optee, u_int max_key);
 void optee_notif_uninit(struct optee *optee);
 int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index f0c3ac1103bb..f3cae8243785 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1584,6 +1584,42 @@ static inline int optee_load_fw(struct platform_device *pdev,
 }
 #endif
 
+static int optee_protmem_pool_init(struct optee *optee)
+{
+	enum tee_dma_heap_id heap_id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
+	struct tee_protmem_pool *pool;
+	int rc;
+
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM) {
+		union {
+			struct arm_smccc_res smccc;
+			struct optee_smc_get_protmem_config_result result;
+		} res;
+
+		optee->smc.invoke_fn(OPTEE_SMC_GET_PROTMEM_CONFIG, 0, 0, 0, 0,
+				     0, 0, 0, &res.smccc);
+		if (res.result.status != OPTEE_SMC_RETURN_OK) {
+			pr_err("Secure Data Path service not available\n");
+			return 0;
+		}
+		rc = optee_set_dma_mask(optee, res.result.pa_width);
+		if (!rc)
+			pool = tee_protmem_static_pool_alloc(res.result.start,
+							     res.result.size);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+
+		rc = tee_device_register_dma_heap(optee->teedev, heap_id, pool);
+		if (rc)
+			goto err;
+	}
+
+	return 0;
+err:
+	pool->ops->destroy_pool(pool);
+	return rc;
+}
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -1679,7 +1715,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee) {
 		rc = -ENOMEM;
-		goto err_free_pool;
+		goto err_free_shm_pool;
 	}
 
 	optee->ops = &optee_ops;
@@ -1752,6 +1788,10 @@ static int optee_probe(struct platform_device *pdev)
 		pr_info("Asynchronous notifications enabled\n");
 	}
 
+	rc = optee_protmem_pool_init(optee);
+	if (rc)
+		goto err_notif_uninit;
+
 	/*
 	 * Ensure that there are no pre-existing shm objects before enabling
 	 * the shm cache so that there's no chance of receiving an invalid
@@ -1787,6 +1827,7 @@ static int optee_probe(struct platform_device *pdev)
 		optee_disable_shm_cache(optee);
 	optee_smc_notif_uninit_irq(optee);
 	optee_unregister_devices();
+	tee_device_unregister_all_dma_heaps(optee->teedev);
 err_notif_uninit:
 	optee_notif_uninit(optee);
 err_close_ctx:
@@ -1803,7 +1844,7 @@ static int optee_probe(struct platform_device *pdev)
 	tee_device_unregister(optee->teedev);
 err_free_optee:
 	kfree(optee);
-err_free_pool:
+err_free_shm_pool:
 	tee_shm_pool_free(pool);
 	if (memremaped_shm)
 		memunmap(memremaped_shm);
-- 
2.43.0

