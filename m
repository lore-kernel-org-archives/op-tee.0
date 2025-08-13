Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4913EC87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 06:05:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 871254FCDC
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 06:05:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G2cVZyms;
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 456FD43096
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 06:03:54 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61592ff5df8so7819227a12.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 12 Aug 2025 23:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755065033; x=1755669833; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9RDpqZGncYw4GV9WsRoAupSSI2K1DVKB1tocQmYgMc=;
        b=G2cVZyms6SHkp+T5FfvoKtUTHRe5dGMAP/lv7NIg+nw5gxZkKPV2LGn9tOawQ1Zc3U
         MMcHPm2IZEtLk2DUv4oPQ1/FUP05to9irN27121uIel3LZqgYz7wxzfgoDdErIeiXc7n
         rdRU6RMQz9i4Izes/TI3uEcZqP+DnRXQlL6tYiOM0CioM0JoOR8U5TgLkP7HCYFT+sB6
         YX7GEwl64Wtc3n/c2Ld8kYwYZmiI0BbahJvnQssKtLAnfL2twxwfQRH/Jm3m0UScqX7+
         1EXh2u5xxoGO6au52KyYNYaM3jfi5qkOV+sD0rAeQRR4w1Bt+rEDnzA41RKTMi/kvtMf
         c5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755065033; x=1755669833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9RDpqZGncYw4GV9WsRoAupSSI2K1DVKB1tocQmYgMc=;
        b=lU+ox4d3rLeiHGN7cBWBpAs0fjHVFtZ55+HJHZxTa+LIgbNdFBikZjvZzEEUFQ2f2A
         HnWcxTumH+7XETbnooUIv1bR/XKDxwqz+u6WYpA3RJhkbiwDJSm4MGwtASK+hdYdZ6KJ
         1VeTP5EkqqH9E/s7KEUwtykPNzOl/LCdwe2uwD0t6LQ0VJ+d2JOUNmSMsrtTSjgrYP8a
         mnpTZT62x/+4LTdRy2be/BtNs7lcF7Fy964yvm4FSwC3rAjKu/iE8ay2fAasaqQgOlba
         awUMfXBQXNAApx9jcKKlHrdsxbvub2z8ffIM9xtswoHo9Cagc0mKP9LIc325kuqazjsL
         Wdcw==
X-Forwarded-Encrypted: i=1; AJvYcCVhLUkmbI69brqYu6hHAa1V+GIsa7GdXHbeCcWvhdluA5uoRAZtJRSV96c5bBLAoLcgdHHoGMs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyq8CzXEzMOhGakeyN/GJiT4yRNWRMBTwYNmRFvYlbHMUSeb7A2
	cG6bepVRfDGFl5LWCfKbYwWe9Cl0xneVig3ETm2ZzykoPmh8Vud0vvgYT2IjYiNICXnJ8g==
X-Gm-Gg: ASbGncvjqBGBhdQ5ETA0/Ct7sk+bkq36xAkfQtg6k23JD+bnKAOjjAysPGVDEbktwuV
	6DxX6TS+JKuz9MhA3dfKJi3e1eeSE9/nOkMAXETEJ9cyFyEiO6Kh2XMHr3xN7Ot7xTd7Ka4B0us
	RE3ugGEcZ7MuPfeNLY8zBL6TY72LP/w7Wnv0IUlbn49AwoJ5xb7P1lRglSOkhyx70P7kWhd9DmX
	qNFIQb6AIiDL128/udpUD/wouvcgwVmqW9XLdZyHWDhFBVQbQAO+eKDXAualJMuyi38fTCNPabR
	Ffk5EN+JLZCkW89PGk4f9BlHb3aEzpcre8D5yPsLcJY9YfvGdKU5ctIKWhlFcxkBX8xhWMkQmuX
	qqBGJbmtt7OOSdJQH8sDKreX5XGN0VqBuRTX2fs4NAm/SRiV9pHGJg5LDqeKO3mHGT6jkenu3M9
	E=
X-Google-Smtp-Source: AGHT+IHPDW4Qxib/c3fl/QvNCJB64Z5YGN/d1oTyw+2Hx0fudTx9zXp/j1zq+pONC9zrU1nldBcONA==
X-Received: by 2002:a05:6402:22cc:b0:618:534:550a with SMTP id 4fb4d7f45d1cf-6186c000f03mr916573a12.24.1755065033114;
        Tue, 12 Aug 2025 23:03:53 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm21498679a12.25.2025.08.12.23.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:03:52 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
Date: Wed, 13 Aug 2025 08:02:51 +0200
Message-ID: <20250813060339.2977604-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813060339.2977604-1-jens.wiklander@linaro.org>
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 456FD43096
X-Spamd-Bar: /
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.45:from];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.45:from];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: WUHEPT36LN457ZWEJRUMN7IHFBPJXCAN
X-Message-ID-Hash: WUHEPT36LN457ZWEJRUMN7IHFBPJXCAN
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WUHEPT36LN457ZWEJRUMN7IHFBPJXCAN/>
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
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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

