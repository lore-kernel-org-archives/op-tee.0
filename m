Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BBBCD4F26
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 06:19:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 97BAF44E67
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 06:19:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BLiPMdeU;
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2864043743
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 06:19:02 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b9318997so35562865e9.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 23:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782195541; x=1782800341; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BF/aQGorWF2+PS3TTIw50ztvIBzjfiaJCqXGTJT8zo=;
        b=BLiPMdeUkjgoEuxMHM4qu4ldNhAqaQ+7X6+XPILpWLvSCeQQfRjHVH1BlRQdiDSLKI
         5uEXIfiIiasP1USU8CLTjJXXwPRihYmTBUGEYOpShDgKVg85eC2bthm+YjxYZ1mS6s0a
         2zFkOpjWfoOLKkmCZSLeYCG28ebYkyytytbUHfYVhQfznL+yX1esNb3bFE0/coMdknKv
         sVF1bSAiIjAiY21Cw4tmRS3gW/CeL0KtJzBhLTglh0BT10XR//9cS6HbH+uLeVZ0hRhm
         AlE2QjnCtl9qw+Pv1VVDYyWogKb+xnPVITTLtGU78xjRacI9KCooNYruCGIJqz1SUtWd
         wF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195541; x=1782800341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BF/aQGorWF2+PS3TTIw50ztvIBzjfiaJCqXGTJT8zo=;
        b=q71yKAc74swtn8DVhq878d2cW5ZkdcFbzbUy7fohpRBie/64g5Qo2BRhz775rnHUB1
         k/Cw5woEnxxan4b/4bcoZlLB5fvi2vH8gEsICLYCjQ9vnTOCAUUF00+PgDO+jKWjMZ3N
         9n9hP56cbTuAkWBTxTZDFOLgHhAAxZ83ZSjp+xC+3po2n/IGJ7eEBMbEuWY59zTxNZAj
         jt3J42hY3nKYUVRFI4U1WH5NSV1Ti7FXwdDrv2KEB8TwMGacsmhqOlFz1IXnFwzZ5Xql
         W1bABE/iMkHSMyq+9Y82PNQUB/1fs1Df8jHar045XHwSaPOKIkOFkdePRGbMkeM84AII
         wEzw==
X-Gm-Message-State: AOJu0YzwxTV+O89v/GIlfcjPKXm01hnKsQ2O5mCQqBysJZKobPGL+MVq
	X1PAFAR0KDLjcm3M/gQt6GyCVSRS9V1SFTvwghQzbFmF3EJ71MZ1EDlVQtaXjLZbLABr6dn4hSX
	asRODc04=
X-Gm-Gg: AfdE7cklEs+PuxjWG1zA3lfBx1tDnnj5OmGAT6PJQGCVK2zGW4HL97EX2Er+uJEwEOL
	DogwhQAOyYcDorw7Jmx3JQH3vVCF5Mpm7sNUZ1Nda9+vWZewbrYKFpo4E0DfPLQcvUralAMG58M
	Jvo0+i72CHcFkvuQ20dLoQL9DWUhgqrgHM2FlwaVKkv61vQTLgTKyj4bQR3/GSgzwXMJg0u8KcO
	VtMno4ROeGAQtQtR0+RnwYWrwlIyXxSSGUPghYSyItv4w+Zx7a9/Zzt21zsKAUSZhT5mQOxIm8J
	7T8Qx84FisKCD6QMtgsZ7y2P+U2N1MXAEI22gDl69Ot+lNFTp8u0ouxx3o75ZDrEwJcb12ltTq1
	6zUIbP/VO/WJHc7HAwk3j5jKKbZEwiuwSwySw98CRb3wkC8WLlKDznDCG378r5LalR9QxBdvxw6
	OwK8n44N/kmEcGa66XHdDoYt6Kz81mVoics0IBawyy8HhIhlUKx8TlC1Wa
X-Received: by 2002:a05:600c:6288:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-4925b389b78mr16856305e9.6.1782195540303;
        Mon, 22 Jun 2026 23:19:00 -0700 (PDT)
Received: from Dev-EliteBook.Home (97e782b0.skybroadband.com. [151.231.130.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788547sm34521147f8f.18.2026.06.22.23.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:18:59 -0700 (PDT)
From: dave.patel@riscstar.com
To: op-tee@lists.trustedfirmware.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Peter Lin <peter.lin@sifive.com>
Subject: [RFC 1/3] Floating Point changes
Date: Tue, 23 Jun 2026 07:18:53 +0100
Message-ID: <20260623061855.17863-2-dave.patel@riscstar.com>
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.42:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.42:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2864043743
X-Spamd-Bar: --
Message-ID-Hash: EODUN7RPKNHNDJXRST665RKUJIWDOSAX
X-Message-ID-Hash: EODUN7RPKNHNDJXRST665RKUJIWDOSAX
X-MailFrom: dave.patel@riscstar.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Robin Randhawa <robin.randhawa@sifive.com>, Scott Bambrough <scott@riscstar.com>, Dave Patel <dave.patel@riscstar.com>, Ray Mao <raymond.mao@riscstar.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EODUN7RPKNHNDJXRST665RKUJIWDOSAX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Dave Patel <dave.patel@riscstar.com>

Signed-off-by: Dave Patel <dave.patel@riscstar.com>
---
 core/arch/riscv/include/riscv_fp.h |  30 ++++++
 core/arch/riscv/kernel/riscv_fp.S  | 159 +++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 core/arch/riscv/include/riscv_fp.h
 create mode 100644 core/arch/riscv/kernel/riscv_fp.S

diff --git a/core/arch/riscv/include/riscv_fp.h b/core/arch/riscv/include/riscv_fp.h
new file mode 100644
index 000000000..19faf925f
--- /dev/null
+++ b/core/arch/riscv/include/riscv_fp.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * Copyright (c) 2026, RISCStar Limited
+ */
+
+#ifndef __KERNEL_RISCV_FP_H
+#define __KERNEL_RISCV_FP_H
+
+#include <types_ext.h>
+#include <compiler.h>
+
+/* CSR Status Bit Masks for Floating-Point Extensions */
+#define SSTATUS_FS_MASK       SHIFT_U32(3, 13)  /* bits [14:13] */
+#define SSTATUS_FS_OFF        SHIFT_U32(0, 13)
+#define SSTATUS_FS_INITIAL    SHIFT_U32(1, 13)
+#define SSTATUS_FS_CLEAN      SHIFT_U32(2, 13)
+#define SSTATUS_FS_DIRTY      SHIFT_U32(3, 13)
+
+/* Floating-Point Context Struct */
+struct riscv_fp_state {
+#if __riscv_xlen == 64
+	uint64_t fpregs[32];
+#elif __riscv_xlen == 32
+	uint32_t fpregs[32];
+#endif
+	unsigned long fcsr;
+};
+
+#endif /* __KERNEL_RISCV_FP_H */
+
diff --git a/core/arch/riscv/kernel/riscv_fp.S b/core/arch/riscv/kernel/riscv_fp.S
new file mode 100644
index 000000000..4fa53649e
--- /dev/null
+++ b/core/arch/riscv/kernel/riscv_fp.S
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * Copyright (c) 2026, RISCStar Limited
+ */
+
+#include <asm.h>
+
+/* void __asm_save_fp_state */
+FUNC __asm_save_fp_state , :
+#if __riscv_xlen == 64
+	fsd f0,   0(a0)
+	fsd f1,   8(a0)
+	fsd f2,   16(a0)
+	fsd f3,   24(a0)
+	fsd f4,   32(a0)
+	fsd f5,   40(a0)
+	fsd f6,   48(a0)
+	fsd f7,   56(a0)
+	fsd f8,   64(a0)
+	fsd f9,   72(a0)
+	fsd f10,  80(a0)
+	fsd f11,  88(a0)
+	fsd f12,  96(a0)
+	fsd f13,  104(a0)
+	fsd f14,  112(a0)
+	fsd f15,  120(a0)
+	fsd f16,  128(a0)
+	fsd f17,  136(a0)
+	fsd f18,  144(a0)
+	fsd f19,  152(a0)
+	fsd f20,  160(a0)
+	fsd f21,  168(a0)
+	fsd f22,  176(a0)
+	fsd f23,  184(a0)
+	fsd f24,  192(a0)
+	fsd f25,  200(a0)
+	fsd f26,  208(a0)
+	fsd f27,  216(a0)
+	fsd f28,  224(a0)
+	fsd f29,  232(a0)
+	fsd f30,  240(a0)
+	fsd f31,  248(a0)
+	csrr t0, fcsr
+	sd t0, 256(a0)
+#elif __riscv_xlen == 32
+	fsw f0,   0(a0)
+	fsw f1,   4(a0)
+	fsw f2,   8(a0)
+	fsw f3,   12(a0)
+	fsw f4,   16(a0)
+	fsw f5,   20(a0)
+	fsw f6,   24(a0)
+	fsw f7,   28(a0)
+	fsw f8,   32(a0)
+	fsw f9,   36(a0)
+	fsw f10,  40(a0)
+	fsw f11,  44(a0)
+	fsw f12,  48(a0)
+	fsw f13,  52(a0)
+	fsw f14,  56(a0)
+	fsw f15,  60(a0)
+	fsw f16,  64(a0)
+	fsw f17,  68(a0)
+	fsw f18,  72(a0)
+	fsw f19,  76(a0)
+	fsw f20,  80(a0)
+	fsw f21,  84(a0)
+	fsw f22,  88(a0)
+	fsw f23,  92(a0)
+	fsw f24,  96(a0)
+	fsw f25,  100(a0)
+	fsw f26,  104(a0)
+	fsw f27,  108(a0)
+	fsw f28,  112(a0)
+	fsw f29,  116(a0)
+	fsw f30,  120(a0)
+	fsw f31,  124(a0)
+	csrr t0, fcsr
+	sw t0, 128(a0)
+#endif
+	ret
+END_FUNC __asm_save_fp_state
+
+/* void __asm_restore_fp_state */
+FUNC __asm_restore_fp_state , :
+#if __riscv_xlen == 64
+	ld t0, 256(a0)
+	csrw fcsr, t0
+	fld f0,   0(a0)
+	fld f1,   8(a0)
+	fld f2,   16(a0)
+	fld f3,   24(a0)
+	fld f4,   32(a0)
+	fld f5,   40(a0)
+	fld f6,   48(a0)
+	fld f7,   56(a0)
+	fld f8,   64(a0)
+	fld f9,   72(a0)
+	fld f10,  80(a0)
+	fld f11,  88(a0)
+	fld f12,  96(a0)
+	fld f13,  104(a0)
+	fld f14,  112(a0)
+	fld f15,  120(a0)
+	fld f16,  128(a0)
+	fld f17,  136(a0)
+	fld f18,  144(a0)
+	fld f19,  152(a0)
+	fld f20,  160(a0)
+	fld f21,  168(a0)
+	fld f22,  176(a0)
+	fld f23,  184(a0)
+	fld f24,  192(a0)
+	fld f25,  200(a0)
+	fld f26,  208(a0)
+	fld f27,  216(a0)
+	fld f28,  224(a0)
+	fld f29,  232(a0)
+	fld f30,  240(a0)
+	fld f31,  248(a0)
+#elif __riscv_xlen == 32
+	lw t0, 128(a0)
+	csrw fcsr, t0
+	flw f0,   0(a0)
+	flw f1,   4(a0)
+	flw f2,   8(a0)
+	flw f3,   12(a0)
+	flw f4,   16(a0)
+	flw f5,   20(a0)
+	flw f6,   24(a0)
+	flw f7,   28(a0)
+	flw f8,   32(a0)
+	flw f9,   36(a0)
+	flw f10,  40(a0)
+	flw f11,  44(a0)
+	flw f12,  48(a0)
+	flw f13,  52(a0)
+	flw f14,  56(a0)
+	flw f15,  60(a0)
+	flw f16,  64(a0)
+	flw f17,  68(a0)
+	flw f18,  72(a0)
+	flw f19,  76(a0)
+	flw f20,  80(a0)
+	flw f21,  84(a0)
+	flw f22,  88(a0)
+	flw f23,  92(a0)
+	flw f24,  96(a0)
+	flw f25,  100(a0)
+	f_lw f26,  104(a0)
+	flw f27,  108(a0)
+	flw f28,  112(a0)
+	flw f29,  116(a0)
+	flw f30,  120(a0)
+	flw f31,  124(a0)
+#endif
+	ret
+END_FUNC __asm_restore_fp_state
+
-- 
2.43.0

