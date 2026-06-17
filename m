Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459D4CD98E4
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:54:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9F996438BE
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781708090;
	bh=ekF+EqAqxUIoNHacdJRxFOkqPmHLuXqzXJMGa52578E=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ilhxf7Qc6FLBv1kEVb+3wNA1kPz1iuKSjjBYsJIwtIQqPU80Wt615GYgmz1+s+Woq
	 8KGWIFTBGWGWuAFNAJQYs/z6AzOgTzAY82akamsPN/k33kYXRYhZufCVuJmQPCaWKL
	 KbRDzFqjLDBw0oiFDqAD8f7NYmtYLfhJj+NXKE1IFBcvBKJSx8crqcX5rj/VT8mORi
	 PalKRGTW263jb07OK1H3CCj7d1I0AGf2ZNWbkVC3HcBn3ZTv57htYHY8L1nhG4W837
	 zDiHsmeW6dqeIezx6PxA6dp2F697G05oO9hnrKCJQ40L2LQRHOwHq+OS/xNyFwKYps
	 u89lPK0uWc8RA==
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 875EF44EFF
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 14:51:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Qr0Th90C;
	dkim-atps=neutral
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490ace40f13so26013045e9.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707913; x=1782312713; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y79oPW1dRkbvOFQ/8D6OY6Iq3f4xRjBQw7MgzYvcGaA=;
        b=Qr0Th90CaYJRYm9bI1BhG56TM4NHi62T+8sawrM7OdyFizhn4u+WzN41yR57pt1Kjv
         2qhZgi3XCnMDGxLO8BNuzLChR30xbQ1FtRygj9Ps5BkuwspZw1IgjabLEYF3UoaZmKpw
         VLYHQhQ88KQQ3AoXZm2m57oeX7mJtaSXfxOO53OAVrJ2dSkDoyZw0fJnB+CB6NS0q7z+
         A5n7huGlHXD37KQM+D7xN6fBP/1MdirWKpnDMjb50vfxqAx1le8mL8/I5X26+EzJkE3b
         zPaOD/6rHEw/HGZIhGd9TBQB0Dan7HH65bbQz6VEKFt9Urh/l5hmdZYwb0TfDY//Pyu3
         u5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707913; x=1782312713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y79oPW1dRkbvOFQ/8D6OY6Iq3f4xRjBQw7MgzYvcGaA=;
        b=iOXXAQm4X0v4N7TW3SR3wts1F+kgq1LscI2xKJckjj2c3gxQ38oRFjnCcBeMByomwW
         tZJh10IBiCJMes8THHcAOY1epdO8FvqOkgzg8D7NoFtqsXwDbAj4+s344uZxE8fQDHQi
         5B2gjlBEm8R/7C8yUCYGDTHmUJfjbCUGbreHXls3IcVbKnNU6OpA2ngqf6LdEZR+Gn/a
         wD/KhbTHEwHDvHIDbvtTlQSgUsFIN8fL+0HejxYmz+ScpHi/oMQpPiuTfbrCLqDlDjDI
         nQQA63rdr913mlG2t28/U7qfW1zb8be1V9FFkXKBh5fglOQ5tEepmADKprGqYAAdcsRI
         7o1w==
X-Forwarded-Encrypted: i=1; AFNElJ+VLenYusDRc2xrPnno/o/3APcAV22RZSZ11/50jpoV4qvxv4Ew9F6oJ9sGRGvH6UQ8DJDdj7o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwkBOdjsYi2nuXjXzhxVLsCj9184U9HWDMEyr/6Yn4LmkIibxJf
	YLJLgTUgHONXYgQohIBQP+tr3RoK1dUUogQvyV/98AKMkiATfo+uoQnQ9t33fhq56UvjT4scdqL
	CaNQgCq4g/WpggLH7UAbARmr+SntrwA==
X-Received: from wmxb4-n2.prod.google.com ([2002:a05:600d:8444:20b0:490:4477:50d3])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4743:b0:492:1e36:bb03 with SMTP id 5b1f17b1804b1-492333f829dmr72605705e9.36.1781707912951;
 Wed, 17 Jun 2026 07:51:52 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:51:30 +0000
In-Reply-To: <20260617145130.3729015-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260617145130.3729015-1-sebastianene@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260617145130.3729015-8-sebastianene@google.com>
Subject: [PATCH v7 7/7] KVM: arm64: Zero out the stack initialized data in the
 FFA handler
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,3ilqyagwkabudzwvde3v8z8z19916z.x97@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3ilqyagwkabudzwvde3v8z8z19916z.x97@flex--sebastianene.bounces.google.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.73:from];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.73:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 875EF44EFF
X-Spamd-Bar: /
Message-ID-Hash: LAOUWSWZOOQYIAEJBQPJLF24XGBUZKPQ
X-Message-ID-Hash: LAOUWSWZOOQYIAEJBQPJLF24XGBUZKPQ
X-MailFrom: 3iLQyagwKABUDzwvDE3v8z8z19916z.x97@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com, Sashiko AI <sashiko-bot@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LAOUWSWZOOQYIAEJBQPJLF24XGBUZKPQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

Don't leak hypervisor stack data when using the FFA_VERSION call.
When the compiler doesn't support -ftrivial-auto-var-init=zero option
we need to zero out the stack initialized variable before returning data
to the host caller.

Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes:
https://lore.kernel.org/all/20260616160016.C62C81F000E9@smtp.kernel.org/
Fixes: c9c012625e12 ("KVM: arm64: Trap FFA_VERSION host call in pKVM")
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index d7c5701d0584..b321682ead04 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -883,7 +883,7 @@ static void do_ffa_part_get(struct arm_smccc_1_2_regs *res,
 
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 {
-	struct arm_smccc_1_2_regs res;
+	struct arm_smccc_1_2_regs res = {0};
 
 	/*
 	 * There's no way we can tell what a non-standard SMC call might
-- 
2.54.0.1136.gdb2ca164c4-goog

