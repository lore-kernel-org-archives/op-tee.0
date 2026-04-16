Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74125F8DFCF
	for <op-tee@archiver.kernel.org>; Thu, 16 Apr 2026 22:18:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9581943EB1
	for <op-tee@archiver.kernel.org>; Thu, 16 Apr 2026 22:18:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AA0jws8y;
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 70A4843B5B
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Apr 2026 22:18:47 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2dee127b3c5so41480eec.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 16 Apr 2026 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776377926; x=1776982726; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETUqTcAAGDZvh6++jzq/8BgukrlaAAJSB7rABTQ68Ak=;
        b=AA0jws8yzI0RbrYQ7SHQLqV4+iUdxFHmb9xV8LKj6tNxT5/nwvKsWsZuA+DTarK+s1
         30D/PUCkFkf/ic44/hRbP8vv3svHbwuje8jqtoltIsnsqg1Q0gPQmTqD4j1Zf9M/Mguo
         520d93/tHJbTfUjMsMEvSESoYjFxwn1iCQI64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776377926; x=1776982726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETUqTcAAGDZvh6++jzq/8BgukrlaAAJSB7rABTQ68Ak=;
        b=WmeXxjHre/P8sGdvlY+tnYQu3X1YE0xSgaF56brjKbBfg/w3GK+wL/BSOoQJfAQXft
         qkFhzQtcaiGYKpcy2umKeIKUWdSQX2LXFozGJB2TNHX0z8GY3DAOwUSG1IIu2jJPH8UA
         tnpXkyIr9WNf2lfA0jDQoBaoFOWEq8RTp+8ogWc5TYuEr2JFfOQOOZ+CWTS6jNFx/WnM
         fPxa5YpMjir6FA04Jyic27ilfe4+jdBlzZgX5d5EJqzgq7E5u2ws1cNrKoZG4KlCxZh9
         PWdAh0R2LQ9EbJkOTA4o3QPBwTiNo+DUYHPja2a17TzOhl1bQex4bySZSwjcWPQmlFqG
         0e+w==
X-Forwarded-Encrypted: i=1; AFNElJ8J79+s4VU+TC9mVLttF3hDjhhf0mP5ptCHayykQPpBIjEFG8ktWakH5y5Mzn7IICcCf+ExTrg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwIQddjL/71U0QkcevNC1Vh9IWBLfSayepu0w7lhUukhA1SFKXs
	yjVBZt5HqvyTPiAfsIXHJMbui58nUxPxGO4l7NHPWJzI2BGESpxLQ7aayPF04pOXEg==
X-Gm-Gg: AeBDietKGU3ZHkLj+c8uzVOPbAUe+V9Dx93svWo0L7K+xlC1ElXwDPxPcvUFo6kunWY
	+KmdReqibo+ePnIoDpCjMk5GRDNtXWupmxQjuXqeQ8b+uAN+rhJ/kTl7JerxvZ0URxmcYMY57KA
	6mTyuxTH8SZaqs3MXXzWQqvVU1/qLOwaYxLazCHSKLjc5IgILyvITjWDdI6CMeGWsq8NXYPPler
	e9qv+ckB+nHdpWq/yLvI99f6lbKY1lgmCFq0ftWOdBF7A/SZ16DTuHxwnJ52Gjt/H44KWqR3jyu
	lKq3MTVhfZ0koRIS2Hvmvkq8Ge5oSkUr0oY8PtnDg4Yy2u3V2j1If1p0g2zWIRyOKrYc5hTvZO2
	q+FhFqnfJuxH2DSMtQWLpIlNrSewVbTxcFS7/phrW/vblNtWvrjlu6Ok6JlBZEeRtcX+SpRbv5M
	//7W6E6LRCrb0P87HfEtNjlPBEBCZt8//4ykU1iCKTlU2apjflLGUbf09JdDQ8FE41pWY7HmZdz
	1rEDghvJ8f3ELDqwvrbzA==
X-Received: by 2002:a05:7301:168d:b0:2c5:50fe:c771 with SMTP id 5a478bee46e88-2e47930a618mr62220eec.29.1776377926473;
        Thu, 16 Apr 2026 15:18:46 -0700 (PDT)
Received: from hiroh.sjc.corp.google.com ([2a00:79e0:2ebe:8:54eb:de69:cfbc:c959])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c606925sm11642876eec.12.2026.04.16.15.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:18:45 -0700 (PDT)
From: Hirokazu Honda <hiroh@chromium.org>
X-Google-Original-From: Hirokazu Honda <hiroh@google.com>
To: jens.wiklander@linaro.org
Subject: [PATCH] tee: optee: Allow MT_NORMAL_TAGGED shared memory
Date: Thu, 16 Apr 2026 15:18:19 -0700
Message-ID: <20260416221819.3600289-1-hiroh@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	RWL_MAILSPIKE_GOOD(-0.10)[74.125.82.175:from];
	MIME_GOOD(-0.10)[text/plain];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.175:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[chromium.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 70A4843B5B
X-Spamd-Bar: ---
Message-ID-Hash: BHGCKEYSSZRXZD2DWYDM2MKR3KFGLW3J
X-Message-ID-Hash: BHGCKEYSSZRXZD2DWYDM2MKR3KFGLW3J
X-MailFrom: hiroh@chromium.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, hiroh@chromium.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BHGCKEYSSZRXZD2DWYDM2MKR3KFGLW3J/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Hirokazu Honda <hiroh@chromium.org>

On ARM64, shared memory can have MT_NORMAL_TAGGED attribute when using
the Memory Tagging Extension (MTE). The OP-TEE driver needs to
recognize this as normal memory to allow sharing such buffers with the
Secure World.

Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
---
 drivers/tee/optee/call.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 9effe88049e9..e046aff61828 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -602,7 +602,8 @@ static bool is_normal_memory(pgprot_t p)
 	return (((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC) ||
 		((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEBACK));
 #elif defined(CONFIG_ARM64)
-	return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
+	return ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL)) ||
+	       ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED));
 #else
 #error "Unsupported architecture"
 #endif
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

