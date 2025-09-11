Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF89ECAC587
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 13:52:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4C7AD4FE0D
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 13:52:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l7LPUFvN;
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 94A854FD6F
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 13:50:26 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-723960ded6bso5115137b3.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757598626; x=1758203426; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMt0VPE9nsvTEazWH1lgiwsk3x9NY1aluOH28YbXegk=;
        b=l7LPUFvN46DwsDuewOxNAmPg/nZUzHYXUMHy2XgfCVDCcqHOR436f6WMAkVLReK8+Q
         VxW7uWh3fAfvAagpD9KkzmJEuchXb4tLwJKpR9pMNRcXk6J8P94AtTIGcc1R2S9HGNke
         qg8ciHfRT/A6tDJLdKPf2ZVJNAhy89JHuis0E1erVRNoi7I22y3Gc45CtxUPMX/9Ni9D
         TPkMyTAl+aa0fw/rF1CevWmwJF9JrzPe2VBw2wpgVH1vh+ZGSzTbFavxSC5zuWid2z5H
         kLkSidxOsHrA5Q1baCx82NFzpL2Xy+cqIqqW2VNXcqXgNWc8lYcyA+eRcXY1IO6JwYd8
         EXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598626; x=1758203426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMt0VPE9nsvTEazWH1lgiwsk3x9NY1aluOH28YbXegk=;
        b=ERp8JJVM9cx9PzSV8MgnhwUH0Oo/4LgGpBWYsr4CQN2CgAj+P17PPWc7Z0KHusUjAq
         fU3h/x9s1EN/tUIfJaF6T3qvuY8flKMB9Qf9+qbTZQNWhFLYy23tKoqcsN++xoq6aPZR
         eDheF2vLvYK8exYAugpkbiqJvV9EAnf+xYbs8eDdbU2wogFq0fMSEpR+oguW6cvGyIDL
         zVlcHjj/vTd/vQu4jXxoFhR3cXxE9VaYCL4RoBuXMxEeUJDIiDw2lfTvNuDbqVvT9Ugi
         poIAiUdUFhrKp6l43WFt54o522FbnDGzXsUNx7bmZeyqqxDbNRqpYhsehbkifDJKQFiI
         Gpgw==
X-Forwarded-Encrypted: i=1; AJvYcCW9yW+mcggnjiJ5VMyS+3QN+ge72B2f+s8W1CrL0FCBFuy2d/EZ8+WJA2Y4A11XYVv8fxVQhgc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxz2np1rZ9zmkrtT3k14kNdaD0S0T4tv18o0hAq0j1QkteuF9eh
	uINWk+Tgb8uetqXvp5CPKy91ugpsMgv4bqlU7SO7SKGfwcvJ3cmcI9GS9NIDDPSf2ex9Bw==
X-Gm-Gg: ASbGncvIKEXypFvhcZnyArxzngFGGp3W1Ar8Wjd7lyEQ/5qtSTqDhq/4kZtWWjMrWBC
	yXF5CahPqL7mBAvHMKZ2VLj9RpVcEDKclyu7R9sdiqHyOP14Zthjtu4489jKEeoAGAyT2a4sO5b
	z9dX8vD31Ye7NQIHyHsJ7COhkkRPyQvxvVD3cbEFELSkEII+fNOHTXFBL4M1uSsgZ3k8DUc5cJb
	jJPMdKcl7k3Ao8Xyneya8Bm0zOW9ZYVObmybo4iIT57ALBgUDDM/dC7d8kFA+P/ed/dUDqXvejC
	nfLWwo1ezCBdyHzEXZVwSX+R33MILobaF3myEZZC6O4EfvqcY4/ezlzCzEoLGw3IZxih7dn1RlQ
	T9lp1YB+P/GX9a5hQPsTMkclhDDteK0GHmxO7g4kmn4QfZtzM09Mxfv4MdBAKt0zPz7ThsgqWdp
	w=
X-Google-Smtp-Source: AGHT+IG0oRMoou++RsxpxUsUtwpzC5AT+90eCVdw6DARCJFWQoizSSi/Z2eS8ssSBxttr2gzHNfb5w==
X-Received: by 2002:a05:690c:7506:b0:72a:6e48:d7a9 with SMTP id 00721157ae682-72a6e49273amr160447507b3.10.1757598625802;
        Thu, 11 Sep 2025 06:50:25 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7623434csm3526257b3.11.2025.09.11.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:50:24 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
Date: Thu, 11 Sep 2025 15:49:43 +0200
Message-ID: <20250911135007.1275833-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911135007.1275833-1-jens.wiklander@linaro.org>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 94A854FD6F
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[37.123.177.177:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.171:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.171:from];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: R64N2I2YWRPLTNVAF523GNUKF5UXDXF5
X-Message-ID-Hash: R64N2I2YWRPLTNVAF523GNUKF5UXDXF5
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/R64N2I2YWRPLTNVAF523GNUKF5UXDXF5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Export the dma-buf heap functions to allow them to be used by the OP-TEE
driver. The OP-TEE driver wants to register and manage specific secure
DMA heaps with it.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/dma-buf/dma-heap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 3cbe87d4a464..8ab49924f8b7 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -11,6 +11,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/list.h>
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
@@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
 {
 	return heap->priv;
 }
+EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
 
 /**
  * dma_heap_get_name - get heap name
@@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *heap)
 {
 	return heap->name;
 }
+EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
 
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
@@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	kfree(heap);
 	return err_ret;
 }
+EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");
 
 static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
 {
-- 
2.43.0

