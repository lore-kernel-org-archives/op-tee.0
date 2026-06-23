Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A16CCD98F0
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 06:20:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5A4F144E68
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 06:20:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=GLntggOl;
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0DF3F44E61
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 06:19:03 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45fd464d51fso3072033f8f.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 23:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782195542; x=1782800342; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i8jO0J0WuKQyGXjHq2PRQYuspFqucX+zmWFkCgYeSo=;
        b=GLntggOl0jgA8C+1kq2Mza4OVp9LOO0mj0Ul89MgDOq6y7lM5mRaZd0ED08YWHB1LY
         H9BhQUhNV9qZLFN4KxVzdizHIRDmkNyGiSNQ1EjRVQwCgKquszrUsUsv3v+rs6wf2zd1
         M12HDxrAQ05IcAAZF3MFJ3z3lqToPtmdwDj5qGPX9J3NXL7IreZ6BGvIt9W17JWXSUQ4
         paIlXlc3mX6cWJ8AOmPIjWcnUYfP1x67Gi7v/puocFhgcjnVp806uV1zmjaUrrdPIqNW
         4kusycfbAZmCYiX3HKU95DwIua7DnpKIsDdI52E03eHObBsACD5LqkXKXqQTMqo1ZeEJ
         DFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195542; x=1782800342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1i8jO0J0WuKQyGXjHq2PRQYuspFqucX+zmWFkCgYeSo=;
        b=ZMlllpyPazzasK1M1XUTwE67JGLXgK9C2VwAWnH/pGf/lmuMj7Tq4bWi+tnrI7ntPo
         xdJYVCvfarKO2aC8/6bd3LZsCrgrBDRjw2GSlvGsZDkUBZYSIhPw6T5mRKbXlm3B8f67
         DbZSg3LZZAezSAFzzbGyR1LxvcnhwxaBnrHjqVKgq5xlwHFJ4sne3R/hx+Xeiad9ezCV
         VWv326qFe72Zb7OJ3OftYIc7ORX9W7lMKkwflwtvw4fV2iNMql1ITc/CM6WJgDd5J6m7
         CxFlpFuhQ9SEqsM5yaLXJD5FUtDJ8O18R43jF8b+YWFCi7DcjgPmjKwpcpNrpgr0DvxS
         Rt/g==
X-Gm-Message-State: AOJu0YzMZQEFeKh9wl8NOSbhwaXmBGZz3ti3cC236kutZDNa++IV4wv9
	RmUlR+98hvWmFS+B7GLTuDT48Vt1zEhQ9N81MxJAwc9NcxtrrCQAxTG+HagaJJGRN36quGaPvCa
	y/AeAgpQ=
X-Gm-Gg: AfdE7cmaKpAY0likD0IJOE3eKUPeNF+bSavQqMZIRov8fpJd3/C0HLR7zFhmyfgoKsd
	yoJxMF4mgfZsLzZmr4v3CMFOC+/X4GcrbI2TjLo45PHWdmFWWc73owgxvHYkalf+ILhTOEYY2lv
	DmC7HTvkyNXOI3FOlgBkmluOv9zne+oPJ6SMH1K5bkUnrVDJs6JSIX424GFT6Re+7dfsDJZDz9r
	EYXIvvHYY2+jGceP0++XIZL/sn/Po/9roCEpy+ANUyTrQrIasvrdcCEO1OjCZGRUk4K27ObpZ74
	Dq+pxZBXeZlggmYIdmH3CeK5AWnIhAyOjOEKXqEo6T2mtBdZMR1KR618fxX8fRBlTXfdk9C2GCB
	cpQsCX/u+hO1OPC6/UkweSMmxRv/N/RWfkR+1F5A1pIGZzjAgHR3zMFmyQNPfDTXyy7KM+n9SH9
	6eTOtJquTe+PuQSItGDW+KkbtxqmVOHqjkXBtDX4WdjI37K+Q/AKhecmvh
X-Received: by 2002:a5d:4604:0:b0:466:6ed8:1e1b with SMTP id ffacd0b85a97d-46add36e391mr1508165f8f.21.1782195541811;
        Mon, 22 Jun 2026 23:19:01 -0700 (PDT)
Received: from Dev-EliteBook.Home (97e782b0.skybroadband.com. [151.231.130.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788547sm34521147f8f.18.2026.06.22.23.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:19:01 -0700 (PDT)
From: dave.patel@riscstar.com
To: op-tee@lists.trustedfirmware.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Peter Lin <peter.lin@sifive.com>
Subject: [RFC 3/3] Thread changes for RISCV floating point and vector changes
Date: Tue, 23 Jun 2026 07:18:55 +0100
Message-ID: <20260623061855.17863-4-dave.patel@riscstar.com>
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.43:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.43:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0DF3F44E61
X-Spamd-Bar: --
Message-ID-Hash: 5WZCRUDT27NXULYJWOA3BSJNHG2V4GA7
X-Message-ID-Hash: 5WZCRUDT27NXULYJWOA3BSJNHG2V4GA7
X-MailFrom: dave.patel@riscstar.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Robin Randhawa <robin.randhawa@sifive.com>, Scott Bambrough <scott@riscstar.com>, Dave Patel <dave.patel@riscstar.com>, Ray Mao <raymond.mao@riscstar.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5WZCRUDT27NXULYJWOA3BSJNHG2V4GA7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Dave Patel <dave.patel@riscstar.com>

Signed-off-by: Dave Patel <dave.patel@riscstar.com>
---
 core/arch/riscv/kernel/thread_vfp.c | 142 ++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 core/arch/riscv/kernel/thread_vfp.c

diff --git a/core/arch/riscv/kernel/thread_vfp.c b/core/arch/riscv/kernel/thread_vfp.c
new file mode 100644
index 000000000..9eaf20ad1
--- /dev/null
+++ b/core/arch/riscv/kernel/thread_vfp.c
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * Copyright (c) 2026, RISCStar Limited
+ */
+
+#include <kernel/thread.h>
+#include <kernel/riscv_fp.h>
+#include <kernel/riscv_vector.h>
+#include <assert.h>
+
+void __asm_save_fp_state(struct riscv_fp_state *ctx);
+void __asm_restore_fp_state(struct riscv_fp_state *ctx);
+
+#define STATE_TOKEN_FP     SHIFT_U32(1, 0)
+#define STATE_TOKEN_VEC    SHIFT_U32(1, 1)
+
+struct thread_riscv_ext_state {
+	struct riscv_fp_state fp_ctx;
+	struct riscv_vector_state v_ctx;
+	bool fp_saved;
+	bool vec_saved;
+};
+
+static struct thread_riscv_ext_state cpu_ctx_states[CFG_NUM_THREADS];
+
+static inline unsigned long read_sstatus(void)
+{
+	unsigned long val;
+	asm volatile("csrr %0, sstatus" : "=r"(val));
+	return val;
+}
+
+static inline void write_sstatus(unsigned long val)
+{
+	asm volatile("csrw sstatus, %0" :: "r"(val));
+}
+
+uint32_t thread_kernel_enable_vfp(void)
+{
+	unsigned long sstatus = read_sstatus();
+	uint32_t active_token = 0;
+
+	if ((sstatus & SSTATUS_FS_MASK) != SSTATUS_FS_CLEAN) {
+		sstatus &= ~SSTATUS_FS_MASK;
+		sstatus |= SSTATUS_FS_CLEAN;
+		active_token |= STATE_TOKEN_FP;
+	}
+
+	if ((sstatus & SSTATUS_VS_MASK) != SSTATUS_VS_CLEAN) {
+		sstatus &= ~SSTATUS_VS_MASK;
+		sstatus |= SSTATUS_VS_CLEAN;
+		active_token |= STATE_TOKEN_VEC;
+	}
+
+	write_sstatus(sstatus);
+	return active_token;
+}
+
+void thread_kernel_disable_vfp(uint32_t state_value)
+{
+	unsigned long sstatus = read_sstatus();
+
+	if (state_value & STATE_TOKEN_FP) {
+		sstatus &= ~SSTATUS_FS_MASK;
+		sstatus |= SSTATUS_FS_OFF;
+	}
+	if (state_value & STATE_TOKEN_VEC) {
+		sstatus &= ~SSTATUS_VS_MASK;
+		sstatus |= SSTATUS_VS_OFF;
+	}
+	write_sstatus(sstatus);
+}
+
+void thread_kernel_save_vfp(void)
+{
+	unsigned long sstatus = read_sstatus();
+	uint32_t tid = thread_get_id();
+	struct thread_riscv_ext_state *state = &cpu_ctx_states[tid];
+
+	if ((sstatus & SSTATUS_FS_MASK) == SSTATUS_FS_DIRTY) {
+		__asm_save_fp_state(&state->fp_ctx);
+		state->fp_saved = true;
+		sstatus = (sstatus & ~SSTATUS_FS_MASK) | SSTATUS_FS_CLEAN;
+	}
+
+	if ((sstatus & SSTATUS_VS_MASK) == SSTATUS_VS_DIRTY) {
+		assert(state->v_ctx.vregs != NULL);
+		riscv_vector_save_internal(&state->v_ctx);
+		state->vec_saved = true;
+		sstatus = (sstatus & ~SSTATUS_VS_MASK) | SSTATUS_VS_CLEAN;
+	}
+	write_sstatus(sstatus);
+}
+
+void thread_kernel_restore_vfp(void)
+{
+	unsigned long sstatus = read_sstatus();
+	uint32_t tid = thread_get_id();
+	struct thread_riscv_ext_state *state = &cpu_ctx_states[tid];
+
+	if (state->fp_saved) {
+		sstatus = (sstatus & ~SSTATUS_FS_MASK) | SSTATUS_FS_CLEAN;
+		write_sstatus(sstatus);
+		__asm_restore_fp_state(&state->fp_ctx);
+		state->fp_saved = false;
+	}
+
+	if (state->vec_saved) {
+		sstatus = (sstatus & ~SSTATUS_VS_MASK) | SSTATUS_VS_CLEAN;
+		write_sstatus(sstatus);
+		riscv_vector_restore_internal(&state->v_ctx);
+		state->vec_saved = false;
+	}
+}
+
+void thread_user_enable_vfp(struct thread_user_vfp_state *uvfp __unused)
+{
+	unsigned long sstatus = read_sstatus();
+	sstatus = (sstatus & ~SSTATUS_FS_MASK) | SSTATUS_FS_INITIAL;
+	sstatus = (sstatus & ~SSTATUS_VS_MASK) | SSTATUS_VS_INITIAL;
+	write_sstatus(sstatus);
+}
+
+void thread_user_save_vfp(struct thread_user_vfp_state *uvfp __unused)
+{
+	thread_kernel_save_vfp();
+}
+
+void thread_user_clear_vfp(struct thread_user_vfp_state *uvfp __unused)
+{
+	unsigned long sstatus = read_sstatus();
+	uint32_t tid = thread_get_id();
+	struct thread_riscv_ext_state *state = &cpu_ctx_states[tid];
+
+	state->fp_saved = false;
+	state->vec_saved = false;
+
+	sstatus &= ~(SSTATUS_FS_MASK | SSTATUS_VS_MASK);
+	sstatus |= (SSTATUS_FS_OFF | SSTATUS_VS_OFF);
+	write_sstatus(sstatus);
+}
+
-- 
2.43.0

