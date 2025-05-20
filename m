Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CBCC3ABDD
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:26:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1C79F45F04
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:26:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WJUtuZLv;
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 66AF145B2B
	for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 15:24:45 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso1020243066b.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747754684; x=1748359484; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+mAUVqOxIXjZijXnkHFZmAFDQtFJ4Kh5PO6PLUJhLU=;
        b=WJUtuZLvc32o/6KpJuSKjlIHaMr5Zujnwo9GnxWUAm9wQDjGVNrQHbRAxL3s4UsLHC
         4BUkGY6kyJ0ltSUUFbDJQoXUGf9Z6afFdHwfcbpRlkwuo8CA6fTe0hW/YjbzQU3O9gn6
         gkRmwJS7QefYB33eRPdr/6AmFhBr3QhIvTgMv0dlx9QvmfrAtkm3Ow/GKZ/uJCIIFryV
         B+LfeG2oax/hlXbmB+iAUsoVmmytCYRY04CscimIG+0SLdhTLW0KSHkK2gcLIlDbc56m
         XbZhbNP4su84nHM6WDhd2dzLE3QOKseFGIaedHbwbyAD5+cyIbEn05sIkOcAkIjdBM0T
         7dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754684; x=1748359484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+mAUVqOxIXjZijXnkHFZmAFDQtFJ4Kh5PO6PLUJhLU=;
        b=htAtOwNill7ImfsLfOe733BO3nYZ/NOopYB5i0fd3h8LwdgKvqa9kXxM6CNNTZe9gT
         ts6YgTPT/kQpZlKTXNG6tE6iK9eUtMZp8h6+LqhvkAnyEo8WK9FysvfjdIByJ7v9M4Ze
         C19e+F7XWpdNIvUViGg1K+15/M/hm5oI2KIsPMXlprAsBe0FtaWt4t9Dnm0NGj8PJxes
         0Uq7X1CwzF46OJQAD7a+MKbNsGrsV4dud2LgAXVtfz8QXYuGOqOcHdR3fEhMNNjmQkGj
         6J5djPso0hfliPc/7VW2IjhkJrunKt0dAIJ/fyWAbkAagQ38Hp3/RjMFoWK+T2oaudXL
         W/mA==
X-Forwarded-Encrypted: i=1; AJvYcCXVnT4X83KuQtGTTzU6KjJXV8+IGln3RITKNZBR4CjKcvVjIwSUWL4KPnpbtQ7kh22j+BKDG60=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxtHttqZ1LLjoqI5+d03dez7dYo8E2zima36ZvldbsjJ46Bkv5v
	PuBINBCW3FKD2ND0YqiCFiYyV4mPhi2ZNeJ2ENei5iModRu/y22t6KU6uQ1rXcsb/bw5dA==
X-Gm-Gg: ASbGncvelVAOvE2lO2lSakBmKJ+5vZ0Ey/83KthWnF8n3vACpfLfU6uPso0/OwgQG+j
	uDLyZmZ8LeJDZaurgQVt6XHWK2nJdATBu7Tbo8gxtWKhkycp7VyYMCppDNQPQPUpg9UHQmy57Ah
	+TakiZwr3reuaYl/xCW2Mt3xx3+Ai4TJkbMg+uyzlGdrb7PuEvkv0H0maZXmRIg9sqUWG+MHOBo
	PjZy5HmqtVonRPbYd70cAkSQTPtUv4ILBQfJrLFygOkVNSLvtcHJ6/E2eZWAcSrKMfaE28zGFv1
	L+ejv9zGIq4xEvl0DPOeH3GJa7UigOX90RKgaGEuBHv++yZxF2h8X5ozVbCOW8jtMEcA3YPrcu8
	NZSDOAPNajJfgfpN19kHqtHEi2/S2
X-Google-Smtp-Source: AGHT+IHJnNS8PsiFV8EVtrc16G9fq8ki6tRPk/s/IIABC/OTj/P3BcTFh9xpStaXrxgzCYdbyyVt2g==
X-Received: by 2002:a17:906:22d1:b0:ad5:3055:784d with SMTP id a640c23a62f3a-ad53055f81cmr1041003666b.34.1747754684274;
        Tue, 20 May 2025 08:24:44 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278257sm742608766b.82.2025.05.20.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:24:43 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 2/9] dma-buf: dma-heap: export declared functions
Date: Tue, 20 May 2025 17:16:45 +0200
Message-ID: <20250520152436.474778-3-jens.wiklander@linaro.org>
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
X-Rspamd-Queue-Id: 66AF145B2B
Message-ID-Hash: CB6CKI6GPADJZ4HGK3Z4WTYCUXSTUPTG
X-Message-ID-Hash: CB6CKI6GPADJZ4HGK3Z4WTYCUXSTUPTG
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CB6CKI6GPADJZ4HGK3Z4WTYCUXSTUPTG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Export the dma-buf heap functions declared in <linux/dma-heap.h>.

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

