Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26664CD6E41
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:05:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 76BB444E2F
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779894299;
	bh=t39kgrMOHIHzsvf+eHb06eEnxgvz7gZgtivjOJ2TDw0=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ymA4Hg+S4NtuRlefXUpOE1jNY1rWdEMlF1/xPBhD115UBExE5G4ZQG4BnQlql/lhe
	 i8TZ71/O1RTU6j/24b6O7FMaw+IEz231WHIMobiteACsZ1DfOTqzqzQi6zgAJ1oCl+
	 P3mFRlAIWsjvZNw5ZYQKpq9p/D2fXplZQH+PLi/bWsWZsZAULo/Dvsq63pn4v+5mjs
	 +gDaCO2u6E3zO8VppKBveRXCng0LaZ4gcZNi8+rIsKBgPZdUUd8yhnJ+WBoZ5+adph
	 0cYvRxyVw4n7ag9e0kuUPcjnRQGRdpDytisj7HSmAzjamIR+oZKjyrNIZlYxFun9dC
	 ZRFJ9TTMamoBQ==
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 13FA444E2F
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 15:02:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qORszNkF;
	dkim-atps=neutral
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-44a71109b94so7994762f8f.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894167; x=1780498967; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BckYBENK6hhz+ff2bUCfdnEivIY8LabEaYEeFq/XAWw=;
        b=qORszNkFTzrcTn3aBNuRm1t/SHVt0hi/ATIs1wAlbnH71Yrer61kOjYc4RcNMM1/g7
         pOM/lcMPL/ZneHXOrnyQgZYfogmiH2x8Isj9Mxnrb9aVJmmKyTv4UZgzEAtXKzxyHXp5
         O3QyF9/s/RAriSMN+wFTc30+PZxpR+8vj7mu+dwbAI3/DQgCwvhSRsGJdxKSjlFrnbmY
         rHJWF3zFz7f41y7qiO7sJtFq4OUs5d+pTGZnQQP0ydh0WcwCdf4l6oceiRIKVpgNUGTL
         3Oy1nQtQUnSa2BK/3IFymdXFov5pPVLZMmPdPf9QuTkpTMmtUUqXdi6cnMseFeByEXK0
         18dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894167; x=1780498967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BckYBENK6hhz+ff2bUCfdnEivIY8LabEaYEeFq/XAWw=;
        b=pN9Fsm961JH69cFr76zr0RudT0hNBmOjOiNXPmjs5W7mcfI3NKbeaaBPTHuqd8USkh
         R0lYt9uCxhXqGBmd/qW1t8Qm45mVkNQoI7ikJRZS2tnqKMkr3U2vL8zLr6QQFhYvJkt7
         knHSd6j/K+fd6i1KanFGKS0yNJT77sApKete7TkKxvkodp0o/RsmCKGbwCAwUKaOrxGb
         7oECdrbdM0wn4oByFOl9Naedu9Zk2zFoy5ZrDFjxL7zRV9ndNt5IRNhQ+7gQrrGkAY+w
         tQQ47yKPzWOKBI1slu+gx+SixgWZZQd/HMqm8/H2t1ikC9iSyXVUPIxKZN9vR/nK7YtG
         wEaQ==
X-Gm-Message-State: AOJu0YwUMFcXG8kHPSHt/xkURnEnwTqPeXJmAwjJ0S1zYIBcRT2nKWfU
	eIXphwPfU9auAClkz+FJICu2YPhYGkvDq2/6vhaWEMN/s5ynSHUapCpmlHnxWGSlr+tFW05mIKP
	0VaeINss84d4RT4aULkYALDOm5fIN3Sgvenixx6zhCihmyx10bIhx6Ur5Jq0MZu6RM5rf1ldyRR
	1Vps4U0ky47XV5e62HIO2g1YDIiT84zd5+kP+xULQcJLCao6eQIE8g2Uy5iY/3
X-Received: from wrjb1.prod.google.com ([2002:adf:e301:0:b0:44c:f833:f80e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e011:0:20b0:43f:e9ee:5610 with SMTP id ffacd0b85a97d-45eb38b0408mr28581235f8f.43.1779894166481;
 Wed, 27 May 2026 08:02:46 -0700 (PDT)
Date: Wed, 27 May 2026 15:02:35 +0000
In-Reply-To: <20260527150236.1978655-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260527150236.1978655-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260527150236.1978655-6-smostafa@google.com>
Subject: [PATCH v6 5/6] KVM: arm64: Validate the offset to the mem access descriptor
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3lgcxaggkblkjdfjk1617ff7c5.3fdfg-k55c9jkj.kiljk5469idn1i5.fi7@flex--smostafa.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	NEURAL_HAM(-0.00)[-0.991];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3lgcxaggkblkjdfjk1617ff7c5.3fdfg-k55c9jkj.kiljk5469idn1i5.fi7@flex--smostafa.bounces.google.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.74:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.74:from];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 13FA444E2F
X-Spamd-Bar: --
Message-ID-Hash: 72SEYOCA622NUWFSB56A53N5E3EMFF65
X-Message-ID-Hash: 72SEYOCA622NUWFSB56A53N5E3EMFF65
X-MailFrom: 3lgcXaggKBlkJDFJK1617FF7C5.3FDFG-K55C9JKJ.KILJK5469IDN1I5.FI7@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/72SEYOCA622NUWFSB56A53N5E3EMFF65/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

From: Sebastian Ene <sebastianene@google.com>

Prevent the pKVM hypervisor from making assumptions that the
endpoint memory access descriptor (EMAD) comes right after the
FF-A memory region header.
Prior to FF-A version 1.1 the header of the memory region
didn't contain an offset to the endpoint memory access descriptor.
The layout of a memory transaction looks like this from 1.1 onward:
Type | Field name | Offset
[ Header | ffa_mem_region  | 0
  EMAD 1 | ffa_mem_region_attributes) | ffa_mem_region.ep_mem_offset
]
Verify that the offset to the first endpoint memory access descriptor
is within the mailbox buffer bounds.

Also, fix one hardcoded sizeof(struct ffa_mem_region_attributes) that
should be replaced ffa_emad_size_get() for compatibility with FFA v1.0.

[@Mostafa, Add missing call to ffa_rx_release() and use fraglen
 as the max buffer size as it is the only intialised part]

Fixes: 42fb33dde42b ("KVM: arm64: Use FF-A 1.1 with pKVM")
Signed-off-by: Sebastian Ene <sebastianene@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index b6cf9ad82e12..a12e01883314 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -476,10 +476,10 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	DECLARE_REG(u32, fraglen, ctxt, 2);
 	DECLARE_REG(u64, addr_mbz, ctxt, 3);
 	DECLARE_REG(u32, npages_mbz, ctxt, 4);
+	u32 offset, nr_ranges, checked_offset, em_mem_access_off;
 	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
-	u32 offset, nr_ranges, checked_offset;
 	int ret = 0;
 
 	if (addr_mbz || npages_mbz || fraglen > len ||
@@ -489,7 +489,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	}
 
 	if (fraglen < sizeof(struct ffa_mem_region) +
-		      sizeof(struct ffa_mem_region_attributes)) {
+		      ffa_emad_size_get(hyp_ffa_version)) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out;
 	}
@@ -508,8 +508,13 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	buf = hyp_buffers.tx;
 	memcpy(buf, host_buffers.tx, fraglen);
 
-	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
+	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
+	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out_unlock;
+	}
+
+	ep_mem_access = (void *)buf + em_mem_access_off;
 	offset = ep_mem_access->composite_off;
 	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
 		ret = FFA_RET_INVALID_PARAMETERS;
@@ -574,9 +579,9 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 	DECLARE_REG(u32, handle_lo, ctxt, 1);
 	DECLARE_REG(u32, handle_hi, ctxt, 2);
 	DECLARE_REG(u32, flags, ctxt, 3);
+	u32 offset, len, fraglen, fragoff, em_mem_access_off;
 	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
-	u32 offset, len, fraglen, fragoff;
 	struct ffa_mem_region *buf;
 	int ret = 0;
 	u64 handle;
@@ -599,8 +604,14 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 	len = res->a1;
 	fraglen = res->a2;
 
-	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
+	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
+	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		ffa_rx_release(res);
+		goto out_unlock;
+	}
+
+	ep_mem_access = (void *)buf + em_mem_access_off;
 	offset = ep_mem_access->composite_off;
 	/*
 	 * We can trust the SPMD to get this right, but let's at least
-- 
2.54.0.746.g67dd491aae-goog

