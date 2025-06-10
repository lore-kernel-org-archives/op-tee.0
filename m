Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D330EC5B543
	for <op-tee@archiver.kernel.org>; Tue, 10 Jun 2025 13:18:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2A1584645A
	for <op-tee@archiver.kernel.org>; Tue, 10 Jun 2025 13:18:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LtweLRC0;
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A4E684043B
	for <op-tee@lists.trustedfirmware.org>; Tue, 10 Jun 2025 13:16:14 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ade5ca8bc69so311931266b.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 10 Jun 2025 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749561374; x=1750166174; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BDcE4876d7+lQswV9isKuNGeIH7ZLPwvjK7CukY8ng=;
        b=LtweLRC0kn1xstHIKlUETCPDeCnsbopQIHxdmt/cCok33MLiLBHDPjmk76FD0G1Jfb
         kgiPKN5DSvQrJ8wGjK6tMwUekHK+88GeMzpxLZW1rszonL6b73+6co10/LKu3Fhg1JJb
         ULGHvhxge6JBkJUAnGSjGKur7+NyFAi7H/Zf0utVm0EA3hD95CwpyOe6mLVWM5IKUkeX
         LD6OqgX7HAkef3CAGvt4PNAyEi3jLMfsbFiRSpapgb/6bu00QafN6aEu2XlTSLRJB0Gc
         TL6EKejqHaR7/NGo/H/CjwcA0RlMWFQa6RjnG9B0cx9MZdhbVsTM5zZdc5cQp9DgN1rZ
         wBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561374; x=1750166174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BDcE4876d7+lQswV9isKuNGeIH7ZLPwvjK7CukY8ng=;
        b=nSUqclLBc1PARqxg9IB9NwDQWPDbwew6oYFu6xT07hKCnIV44pb00ftIJFDAl/52XG
         tTeTQeOFm9MDM8wQRQvXdjvLS5SwJp3p4GGZfY/zw1u6ZxzxXZ3FLsXu9M8OLOkAUOdR
         5nhDG9gvLnW3ABjrGOj0j0xIGXAH5wVuukSM0Z32VD3dTAZOVYn2YGiXz/gwCUjheh82
         4GaDOcGUMXfvA+vJO8ErQS0sqyZ6YlAMwI5SJFNpRNvubJPggtMtlOO8qidtV50MdmpY
         DVqrQ5FaJxRbx0NKarv+ssA9Y+GUg+KjU0S+/cGSSAXSWOzlKpACSBRQNSYgsQubsnfz
         sX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3RxKjprHyHQf9iEOHrnGfdZcEiLN852SX0Tn0j0ViqTqw3g+ZtN1Vrd8DPmD+PMINDy92ppA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YypdcFeb/5lvcLAt4xd/IuYQJUBbO51nJWcSYZCKhA6jxAMGnod
	xRjNqYrxRMCLO90Ywlq5RVCJs5HWO99013CP04lEBBhzYixOn6DWuWqJCfW79PQaSiuehQ==
X-Gm-Gg: ASbGncuMpBobos6fJummW1/MEW8BVyKypnCu9E+QCv1hMOrlfcENXhHHD7zmrhgHAyf
	hGrzgRzK8jdZIqj7E2cENfK4CSMG0ACs/4pWehzzRzkDDGcNjmfYHezrlJFMNd/K5/2zSq5elec
	0XK8+83nzgUB1570mnfcA/QLYugWICHGQF0rudX2gE9+Xv+EF64L2HNBMcGFMIEQpZ5hS4VFVh0
	kU/7xsfuPToiMkaHqgaW1Np2batINy4KglTStMyAOGcxSxlNTu1nqzBZIHmq8rfzyVeP1syRli8
	HG+LSVr8/k1PulgpQgMsF1a8ZOElR/wcQBdFD/F0kjqcIKcg3FElQT5aqjsnrLPFPI5nhH9Ew6e
	/xNoMuFEuqjzV5EY8imxXXu2cvRJ1O1AF/cOEf5Q=
X-Google-Smtp-Source: AGHT+IFOBF4P1tAbssgL5dehUIWLuQRa8S7VHpp+Y5ehx9RZ7YktqSDlhzjcJArhhbW8+ISbCVgNJQ==
X-Received: by 2002:a17:907:9720:b0:adb:413e:2a2f with SMTP id a640c23a62f3a-ade1aa0fbdbmr1346195566b.9.1749561373268;
        Tue, 10 Jun 2025 06:16:13 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade3206a1efsm643651666b.67.2025.06.10.06.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:16:12 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 2/9] dma-buf: dma-heap: export declared functions
Date: Tue, 10 Jun 2025 15:13:46 +0200
Message-ID: <20250610131600.2972232-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610131600.2972232-1-jens.wiklander@linaro.org>
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.54:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	TAGGED_RCPT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.54:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A4E684043B
Message-ID-Hash: UZILXAUOU5L7UFOQYKYHZJDOHG7QLAXE
X-Message-ID-Hash: UZILXAUOU5L7UFOQYKYHZJDOHG7QLAXE
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UZILXAUOU5L7UFOQYKYHZJDOHG7QLAXE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Export the dma-buf heap functions to allow them to be used by the OP-TEE
driver. The OP-TEE driver wants to register and manage specific secure
DMA heaps with it.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/dma-buf/dma-heap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 3cbe87d4a464..cdddf0e24dce 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
 {
 	return heap->priv;
 }
+EXPORT_SYMBOL(dma_heap_get_drvdata);
 
 /**
  * dma_heap_get_name - get heap name
@@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap *heap)
 {
 	return heap->name;
 }
+EXPORT_SYMBOL(dma_heap_get_name);
 
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
@@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	kfree(heap);
 	return err_ret;
 }
+EXPORT_SYMBOL(dma_heap_add);
 
 static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
 {
-- 
2.43.0

