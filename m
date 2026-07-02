Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4324AC43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:41:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8BE7644E08
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782988900;
	bh=mZQwFtKmuv9JtN9Z5Z7PUOwhh+Ry/isHxQ86Gbb1Aoc=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OYiE/MGbs8RSSVfGV4y2TkoXvtfHm6uRCfxPFlB61m2RumdD5MczjXDcKokacKUZp
	 8tSl7y64F52KVsxDYO1VL2vnN/I03DP6zGqBb29qw+15dYXWfMCoVthAZkOHYDvXAX
	 j9r4CEvbED7PVmfjKPfBHSNFV6SkbTlX3AV1rEgto6xxRTRvakm5izZZKMzzlJ2Pre
	 ZzmZMRiImujLoxBJerkK5TvrtC+tCBI7v8K6or7iddmILn6lTVJr6DbSLzJB7XNkUm
	 Fc3ccLu+mkoqqAsq3anqoOe0W1z95aqxgNAyFGL9liNskQszEobPs1b25gsBDbDmd7
	 zU4g5769+2Tqw==
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0686744E14
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 10:39:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iuwwu+AF;
	dkim-atps=neutral
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4744b72f90bso1164568f8f.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988761; x=1783593561; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Un4RsCE8ClG46waU3EoWIfi0gOM5MfO/J2aFh49A2VQ=;
        b=iuwwu+AFyjpfKbFpIa1GWxh6YgsOCQc6QgmSSA5dIg4+AogG/zKZiZIanwUA2I0Sad
         huOlUsySjbqauF/0FTxydw4HaGFb8PM8toSyyAXAFtCFaZcikkgaGfObc5+HXQyhlIPQ
         QMn0qmmGjJHUzJ7i81pwj/h2kctZZtEPbdvLh4L6RtX4xT3Fa8Y19mKO+1C0XHHoTcWu
         yZvIWsA/9zuIxlYF2OfjIuwCAf7VWKt99JrZ8wxQGJ5mlJ6myPdSnrmaza8Ps1eDvg3j
         H4AFZUQq5zjbaX0Rub9hwZ03ayGLX5cK9VMVvVJJrZiGGkPqUJ+3CdPOfse+oTMdjaq+
         XLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988761; x=1783593561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Un4RsCE8ClG46waU3EoWIfi0gOM5MfO/J2aFh49A2VQ=;
        b=CnKqbGswbN6rmfTVWcr8DHhkiVWNbrlCqiW6dGZBrDbIvLuRVUniumvhPSxZ41njUn
         v6K9tQ70iDUOFO6XevfvQyhvwDKV0tp9GoVATg7i0xw2pLPasvgQL8D/PD2wWBMWLCy7
         +5wcLuGAtCNds/GzKOfXUF+TIZVzZ7+9fbj3p2hG1krsh7XZgGsyxQVp1bn//OnwV2KR
         FNTlHTTzaCmyUoLSgbulS1HTVRO7UopRLpFngAGDZ8++Vg9L7XGuoNpT7Cb9Q2nzGTVi
         aNrkHSXcBCvLtWQQkpaelUOPI7jDBTwl24br8XZ5smpXOgtsyhntZFsHhf0poQqFz0pl
         8IZA==
X-Forwarded-Encrypted: i=1; AFNElJ8RQo0GGsUwQslqiGesvNAdzp2rRYOJbG8RobXzKf7DtttVj3s7H2aWajtuI1teqQF/3MzTfgE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwEcT+jU+Nnm3jczisMrFcJNobORzzzRuEluZZnKCtizVhODscY
	+bEY44IsUrkGp4qWmP0MBzbx32VS3vDcxn30j+iIea5KWilzWTLnKhRs3voUoJ12lWOu+Un3HZe
	3Ws5v53dV1sOwH1K2b5oyJOEBSqFwbw==
X-Received: from wmbjp19.prod.google.com ([2002:a05:600c:5593:b0:493:c562:3fc6])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1594:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-493c2b7dc45mr45687565e9.20.1782988760577;
 Thu, 02 Jul 2026 03:39:20 -0700 (PDT)
Date: Thu,  2 Jul 2026 10:38:43 +0000
In-Reply-To: <20260702103848.1647249-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260702103848.1647249-1-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702103848.1647249-7-sebastianene@google.com>
Subject: [PATCH v9 6/6] KVM: arm64: Zero out the stack initialized data in the
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
	FORGED_SENDER(0.30)[sebastianene@google.com,32d9gagwkamk7tqp78xp2t2tv33v0t.r31@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,32d9gagwkamk7tqp78xp2t2tv33v0t.r31@flex--sebastianene.bounces.google.com];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0686744E14
X-Spamd-Bar: /
Message-ID-Hash: PD42Z5ZTG6NBYD6BGSMHMHCENYGBNQBR
X-Message-ID-Hash: PD42Z5ZTG6NBYD6BGSMHMHCENYGBNQBR
X-MailFrom: 32D9GagwKAMk7tqp78xp2t2tv33v0t.r31@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com, Sashiko AI <sashiko-bot@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PD42Z5ZTG6NBYD6BGSMHMHCENYGBNQBR/>
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

Closes:
https://lore.kernel.org/all/20260616160016.C62C81F000E9@smtp.kernel.org/

Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Fixes: c9c012625e12 ("KVM: arm64: Trap FFA_VERSION host call in pKVM")
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/all/20260616160016.C62C81F000E9@smtp.kernel.org/
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 9c96e72e522e..a327c2bbb6b6 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -880,7 +880,7 @@ static void do_ffa_part_get(struct arm_smccc_1_2_regs *res,
 
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 {
-	struct arm_smccc_1_2_regs res;
+	struct arm_smccc_1_2_regs res = {0};
 
 	/*
 	 * There's no way we can tell what a non-standard SMC call might
-- 
2.55.0.rc0.799.gd6f94ed593-goog

