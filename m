Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56374CD4F26
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 06:20:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9129B43743
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 06:20:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BRURgu20;
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CD62343743
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 06:19:02 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b613a17bso42858175e9.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 23:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782195542; x=1782800342; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttb0vndayQPBHq5FeTFAtk0xMP7FeTgoJMwq5FxS4mk=;
        b=BRURgu20VD7bEJ9+2jjw7ejfzg1XX2f/e/0NcwdvrxMS79ZQ8sFb/h5huo9A1DPRe8
         8y41g9wZJQiFXTLnR1aBTt0GiG+aJKQ7BIOdSQzwti4qovUayYwqlILDlrg8fn9lzKqx
         kR1OiC8uZcLUdGxbPj3o7078L+Nsc7Q26Vyd0JPb5JZvWRxlGoqci9PxgQ/Y6H+5pDK1
         nkmt7ARGnZHMC+nx1uMCdAfEoehjCieqNJViN4fg4y8Mq/uFoDXwlAXO9sDwOpWRCIao
         qnRlit72fRuq3txd9Q6LiR7zfLKs/qg5egp+AEWnajP1kFGeuk4XXaxTh2n5dnQHKQ7I
         6D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195542; x=1782800342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttb0vndayQPBHq5FeTFAtk0xMP7FeTgoJMwq5FxS4mk=;
        b=LyVptlMEtxRU7OSqCbVoW3/dOr4mj4miZxkgfB3TQYkefJEPq4t779OVlJbQ0xibal
         w89Y6nOfp4yYHFgX91mEA+yMPeeAbgbdp6RuWl4yTcCg/MqfGJOxF0yCWuPQA7gsf0EX
         6JTlllAsROZ1vJVsKYPgX2m3qUT8gJNWOOJHeqQxwgLfe5BV7c9zaL7zrWiC5ZkQzp7f
         lHMzoUvCkefXgZLDtfzddCIvura/tdkk23OAJVeXNdtvHMjg/E+LT30DyGCfkV2wbXLb
         QRpEo3ck/2PiVtlsGhrrjIUMcRFZEyLyVUxLvG0QkkkIVbIyenXjw1RxG/x9Ac1s+h8H
         R5KQ==
X-Gm-Message-State: AOJu0YxlhqG2qAQY7HkJjuPeFIXM2cnQLjoARnaoi/1et6JbfnAIVHK+
	e0hWVp8crU2x+wFcm7kfYrTpnjiUdOLkkEsjpX0Z0/E4DwmTkY5YHN4FAcIqIvbDaI7a5ghgnGo
	A43WmOw8=
X-Gm-Gg: AfdE7cmbY8dIlBrV16c6dcH18BQVajmck8QbgagF+ARMYaHxKwJse6vMq/8vBQ1/C/f
	sr11imJoawb3b+R0bp93oUZ4qEX/KIM6pmU7MTU0yAMP3HhkdduUcohVx6GmfK1TmHT2bhANuX3
	4cQLMXQXPAYrujU/xc6CRnwLR/Pr6rKs3fUvAbNz2657W3XtL/d5fCGGdx4XFoQzCzJZNOIhBCX
	TE2sypeYmVc/9OBWwC4QvRXZg89mSDCZAU/ek1WvlLJDjsO9VhLn8LcyXLjHIQDx4EdxUdjr72c
	ej7k4FEZTT4B49FPZwhIxjvzE7l4sW6AwHEVIggvQQMwmGaBk7tSiTQkrfPU4s6M9yc0cT9eQPo
	YSWbKxxDErKMWfC7iV1IOvHgiW4fwOW0vaT4VvLOGEvLJdLpymRjT3jCc4EzbiyjSik/SHL9vHZ
	U2Df1YMnyutV9blEJFOU18q52cov5ztc+KQni4t1p/JBX+QXjviodfQv7kxO7ylXPpe/I=
X-Received: by 2002:a05:600c:500d:b0:492:37b7:6080 with SMTP id 5b1f17b1804b1-49249083ccamr206221055e9.7.1782195541044;
        Mon, 22 Jun 2026 23:19:01 -0700 (PDT)
Received: from Dev-EliteBook.Home (97e782b0.skybroadband.com. [151.231.130.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788547sm34521147f8f.18.2026.06.22.23.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:19:00 -0700 (PDT)
From: dave.patel@riscstar.com
To: op-tee@lists.trustedfirmware.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Peter Lin <peter.lin@sifive.com>
Subject: [RFC 2/3] RISCV Vector changes
Date: Tue, 23 Jun 2026 07:18:54 +0100
Message-ID: <20260623061855.17863-3-dave.patel@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623061855.17863-1-dave.patel@riscstar.com>
References: <20260623061855.17863-1-dave.patel@riscstar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[riscstar.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.47:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.47:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CD62343743
X-Spamd-Bar: --
Message-ID-Hash: UDF3MKQVEV7QDHSZEKECYUNWCO6Q42JR
X-Message-ID-Hash: UDF3MKQVEV7QDHSZEKECYUNWCO6Q42JR
X-MailFrom: dave.patel@riscstar.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Robin Randhawa <robin.randhawa@sifive.com>, Scott Bambrough <scott@riscstar.com>, Dave Patel <dave.patel@riscstar.com>, Ray Mao <raymond.mao@riscstar.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UDF3MKQVEV7QDHSZEKECYUNWCO6Q42JR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Dave Patel <dave.patel@riscstar.com>

Signed-off-by: Dave Patel <dave.patel@riscstar.com>
---
 core/arch/riscv/include/riscv_vector.h | 32 +++++++++++
 core/arch/riscv/kernel/riscv_vector.c  | 77 ++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 core/arch/riscv/include/riscv_vector.h
 create mode 100644 core/arch/riscv/kernel/riscv_vector.c

diff --git a/core/arch/riscv/include/riscv_vector.h b/core/arch/riscv/include/riscv_vector.h
new file mode 100644
index 000000000..2aa3b26db
--- /dev/null
+++ b/core/arch/riscv/include/riscv_vector.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * Copyright (c) 2026, RISCStar Limited
+ */
+
+#ifndef __KERNEL_RISCV_VECTOR_H
+#define __KERNEL_RISCV_VECTOR_H
+
+#include <types_ext.h>
+#include <compiler.h>
+
+/* CSR Status Bit Masks for Vector Extensions */
+#define SSTATUS_VS_MASK       SHIFT_U32(3, 9)   /* bits [10:9] */
+#define SSTATUS_VS_OFF        SHIFT_U32(0, 9)
+#define SSTATUS_VS_INITIAL    SHIFT_U32(1, 9)
+#define SSTATUS_VS_CLEAN      SHIFT_U32(2, 9)
+#define SSTATUS_VS_DIRTY      SHIFT_U32(3, 9)
+
+/* Vector Context Struct */
+struct riscv_vector_state {
+	uint8_t *vregs;
+	unsigned long vtype;
+	unsigned long vl;
+	unsigned long vcsr;
+	unsigned long vstart;
+};
+
+/* Internal context routers instantiated inside riscv_vector.c */
+void riscv_vector_save_internal(struct riscv_vector_state *dst);
+void riscv_vector_restore_internal(const struct riscv_vector_state *src);
+
+#endif /* __KERNEL_RISCV_VECTOR_H */
diff --git a/core/arch/riscv/kernel/riscv_vector.c b/core/arch/riscv/kernel/riscv_vector.c
new file mode 100644
index 000000000..b7f7431fe
--- /dev/null
+++ b/core/arch/riscv/kernel/riscv_vector.c
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * Copyright (c) 2026, RISCStar Limited
+ */
+
+#include <kernel/riscv_vector.h>
+#include <types_ext.h>
+
+void riscv_vector_save_internal(struct riscv_vector_state *dst)
+{
+	unsigned long vlenb;
+	uint8_t *base;
+
+	if (!dst)
+		return;
+
+	asm volatile("csrr %0, vtype" : "=r"(dst->vtype));
+	asm volatile("csrr %0, vl" : "=r"(dst->vl));
+	asm volatile("csrr %0, vcsr" : "=r"(dst->vcsr));
+	asm volatile("csrr %0, vstart" : "=r"(dst->vstart));
+	asm volatile("csrr %0, 0xc22" : "=r"(vlenb)); /* CSR_VLENB = 0xc22 */
+
+	base = dst->vregs;
+
+#define SAVE_VREG_CHUNK(i)					\
+	asm volatile(						\
+		"       .option push\n\t"			\
+		"       .option arch, +v\n\t"			\
+		"       vs8r.v v" #i ", (%0)\n\t"		\
+		"       .option pop\n\t"			\
+		:: "r"(base + (i) * vlenb) : "memory")
+
+	SAVE_VREG_CHUNK(0);
+	SAVE_VREG_CHUNK(8);
+	SAVE_VREG_CHUNK(16);
+	SAVE_VREG_CHUNK(24);
+#undef SAVE_VREG_CHUNK
+}
+
+void riscv_vector_restore_internal(const struct riscv_vector_state *src)
+{
+	unsigned long vlenb;
+	const uint8_t *base;
+
+	if (!src)
+		return;
+
+	asm volatile("csrw vcsr, %0" :: "r"(src->vcsr));
+	asm volatile("csrw vstart, %0" :: "r"(src->vstart));
+
+	/* Re-establish execution parameters prior to block transfer */
+	asm volatile(
+		"       .option push\n\t"
+		"       .option arch, +v\n\t"
+		"       vsetvl zero, %0, %1\n\t"
+		"       .option pop\n\t"
+		:: "r"(src->vl), "r"(src->vtype));
+
+	asm volatile("csrr %0, 0xc22" : "=r"(vlenb));
+	base = src->vregs;
+
+#define RESTORE_VREG_CHUNK(i)					\
+								\
+	asm volatile(						\
+		"       .option push\n\t"			\
+		"       .option arch, +v\n\t"			\
+		"       vl8r.v v" #i ", (%0)\n\t"		\
+		"       .option pop\n\t"			\
+		:: "r"(base + (i) * vlenb) : "memory")
+
+	RESTORE_VREG_CHUNK(0);
+	RESTORE_VREG_CHUNK(8);
+	RESTORE_VREG_CHUNK(16);
+	RESTORE_VREG_CHUNK(24);
+#undef RESTORE_VREG_CHUNK
+}
+
-- 
2.43.0

