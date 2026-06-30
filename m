Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658CCC43602
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:24:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AB71544DA1
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782815047;
	bh=mJH6zKl+wPnI8Gh9eK/dhD8a6MoXLFehdUoz/1vLpUI=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=H3k4qYhjoY4Ib4EzBWx6O/MkfHQQjMhtppsy1CJvQ+Jc00LFqNkWEnp2xwmvP0jOb
	 7ay7hcfwQGiL9gGNMEi/8je+qm7Oe4D7iT1UE3G27ktsl2F4hp9HpW/XntokoDFS2r
	 vC8dfMCjtDp9dJdoTXv8Xx8SpbtX4lnx4DyjpMuAkhvBD8JFYoA38GX6KQG71ua78H
	 nAXwGaAGPNtsnO0OR0G2N0KgIM+tQM54kbp8h+YUa8LrQKPgDggvqKKAKNIIyJpCtM
	 Ww5lI40tk9l9c8vzJGMJrqYc5mdtR9k8wQ1Yw8n5VWOGazsv88Rqw4zMgG4Aee8iuB
	 v1x22Db9DV7Ew==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DE29444FB2
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 10:21:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uLtmquuN;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490a767b782so33694715e9.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782814892; x=1783419692; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b11GVtladPRwtAnrqyMBKjVI7QEbzNXpHeXS1BWCw8Q=;
        b=uLtmquuNSy3VFc4sdfgXyQ0D5gKnbyW3EK7fn63fZA3AA3YR1go+ZdTZ48TKIZmBKs
         bYac4mgq3YYKICsFKAiXDdI/XKPEDeviVoh5gCsRe4iG0T1zFXORWmClpZVAQrzOEyQa
         G6kCdaYIfLdzZF+09PGdb67a74AtIQ0LHSt2jC3S1pMO6DvLvFovfC2V7ucnMILxrEMd
         dLapD83ccidWGfP/iWk8ueEVqVMgi+eKl0Ggb0InrZadlc5848XuYTzSuH6IfqIYeed+
         daSNTh2ZxeYjVzDyYPdsH2DJnw97HB3LmMPqIklRC01b7zzJ9MAhlvJ/oD0enuv5hY/m
         e0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814892; x=1783419692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b11GVtladPRwtAnrqyMBKjVI7QEbzNXpHeXS1BWCw8Q=;
        b=c59HT+qPNWyIJ3gMYXbqQHqC3CRiwT6fxpnriQRfZLp3CwwMlVXa+z0+EHdRUIUskF
         Vc7m9DqqPAP17Oh/gQmHGaVN9JZ0vGP9MTAeBIC5JOM56Ux1ng6WpIq7s/yFpIGjsQsQ
         3Y10mbWS3T10ab3RCjbWnA4vdB1IAWD0qazWCxrgjQfgA9sAJVmh4m79fAFqSHrUXMWF
         Vso5Um4n8BGhvD+WW1gMul/PWUpiiWNfTD6j8uzu5DaC45MjzffF1v1xDessFwWaBFrD
         bilRyUymxKhVNxEP2ID2gDTXoTbFsanGh3+jHKZjSYu59nAkDkKbKcWeleO3TBcuosXi
         oSfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lIj2f9/ztnOfBImvZowhxd/9x17FeFPQnqj3QETdPGcb01za/pYucyi9SIpMl5jsu7XrPWPU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyG2KbVqggFJRJiUTD5Cik3XruIqNti47tTyAkApnHnDYF9BY1M
	k2M7ARkLOS1MqNNHSj4giwP1bNdjrDIw8WI72KMi69fJ99rS852YNaC8B0xvXNu0rlkNoo6h7Qq
	frmHIuAgRrvc1ZkmkTe1cfqzk4foK0w==
X-Received: from wrbdt17.prod.google.com ([2002:a05:6000:d11:b0:470:f736:b5d4])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a7b:cd15:0:b0:493:bd4f:510 with SMTP id 5b1f17b1804b1-493bd4f0530mr3477925e9.19.1782814891385;
 Tue, 30 Jun 2026 03:21:31 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:20:59 +0000
In-Reply-To: <20260630102058.3219867-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20260630102058.3219867-2-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630102058.3219867-8-sebastianene@google.com>
Subject: [PATCH v8 6/6] KVM: arm64: Zero out the stack initialized data in the
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3q5hdagwkaeqykhgyzogtktkmuumrk.ius@flex--sebastianene.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3q5hdagwkaeqykhgyzogtktkmuumrk.ius@flex--sebastianene.bounces.google.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DE29444FB2
X-Spamd-Bar: /
Message-ID-Hash: SWH4CNON2CGUGPPAVQKYFSTHVNEKNL23
X-Message-ID-Hash: SWH4CNON2CGUGPPAVQKYFSTHVNEKNL23
X-MailFrom: 3q5hDagwKAEQykhgyzogtktkmuumrk.ius@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com, Sashiko AI <sashiko-bot@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SWH4CNON2CGUGPPAVQKYFSTHVNEKNL23/>
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
index bb01d8f83056..7407bc4b547a 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -881,7 +881,7 @@ static void do_ffa_part_get(struct arm_smccc_1_2_regs *res,
 
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 {
-	struct arm_smccc_1_2_regs res;
+	struct arm_smccc_1_2_regs res = {0};
 
 	/*
 	 * There's no way we can tell what a non-standard SMC call might
-- 
2.55.0.rc0.799.gd6f94ed593-goog

