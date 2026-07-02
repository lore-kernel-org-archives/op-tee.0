Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D446C43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:40:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4FEE14502A
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782988822;
	bh=idCz1yZ2loil4GmAl0CYJHHspFZFLVjff200Ae6fHNk=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=N3f5o8bC8kvwp3I4rL5vGyrQFtLs58jkv50/NtajILRuQjLFQ7N2NQhJRjOol+ELf
	 BOKLP66I4H7K/Uqb9EsotGFRwQq31dviSw0lDLiG4cIujoGPYjHU7pKpsS7QViR+7f
	 BQZ73NokSyCFlLiQfuMVPfwol22Ka5pkoec6vsGTmSskymQfuvFZuFFbg7Ua7GHB+0
	 0TrpImdKDFHVSbG7KNfziS5mKwEUKbdmAkosAujf948vTSh3IMO9Vhw+D4PWg+G/7v
	 XbtFdVygPbUBRm80JoMSW6sCGMRJyD3qgycyoiqhCieNJMpN0wuhcUz1sJaOC4Z7XE
	 bFLtruXlXEbMw==
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B71B445051
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 10:39:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZyNRe76k;
	dkim-atps=neutral
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c1237547c18so177195366b.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 03:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988748; x=1783593548; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5pW2X8dLODkLCHijpyvtLxcjR3119nmpK6U2x+j3Ok=;
        b=ZyNRe76k53XsV+9gnHZJWkDdGn/zpQD4mRwlakmOcczV342K468PL/e6oO/Uc/M2s6
         LxupuuSu9AoeyugR54oKDEuzYA8zRg+Ewek7aEgXs1hiqJzD/T1AhX+ahxQay/aUUHRt
         5HO8pyOBdcuMxUo9kXPy4iA9Ds3NmvXxulOHGsOhGcFstUVRmlm6eAjEXbow6SI+vc2/
         YU4Z3sKtPfGu9m3yqgFOmZrHBfQlsvjrz7JLudIfOR3dfojoCT0w66Q66totfs60D/9W
         uKtBpZlWLudboaZ5saiXOE16ol2cO3jGCFXLnFpleBN9s7I2SFI5ghbK/tN+mo6kNdS0
         ZrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988748; x=1783593548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5pW2X8dLODkLCHijpyvtLxcjR3119nmpK6U2x+j3Ok=;
        b=Gt3PExJx0bbDaW8bhT8h1dqjOZPSumqvsAhaGrvK4CYvP11YGXH41YZ0lRbRaYYN4+
         /Pp6Fu+a1fU7x56Z7gFt1pWuMH0j1yNWtBeBlBgU5Ys4/Msx15ZujIidTB4OhHT2Rx03
         h1NM/ASiaS/SilkXkegn/TbYsQA0V/UKar9+FSVbeG5/28EViKJtkr1UQ3D8yBEnJbMU
         Mmt61NozIjpM8p8QzO28q6B7y5BUaweHY7V2CjkhlotKbEQMVb8+/VQqLZPks8T5DHG8
         NbUim7LlR/eiVBhrpbfph9QF2RnMiiMjFgqpgBy2HttarvXfGP5JS2VUjY9JI0BvvIXP
         cmAA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6A0qw55GdY75pfgGfOQU1iA2Fp08I6Ljcg1Fhi13zML0i5br+5s3mEkiUFWyR8BvEXmvIfyI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzyvtoOJknGdWPlQA/G39d023bRwrTiThVrMMF4EiCWK3nMPknb
	ZG8hgaPLO7a4ReDoN15akFO12tc2cMBhk3gX+V2T4nfxhD916NuNxJn6bx9oUniPTBktXlgJJFS
	4+E1hIujp0fHGeMs1by6UiE0F90r+MQ==
X-Received: from ejbec17.prod.google.com ([2002:a17:906:b6d1:b0:c06:bd7:70c6])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f112:b0:c12:951b:7f1c with SMTP id a640c23a62f3a-c12a9d7a733mr196967366b.21.1782988748201;
 Thu, 02 Jul 2026 03:39:08 -0700 (PDT)
Date: Thu,  2 Jul 2026 10:38:40 +0000
In-Reply-To: <20260702103848.1647249-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260702103848.1647249-1-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702103848.1647249-4-sebastianene@google.com>
Subject: [PATCH v9 3/6] KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,3zd9gagwkal0vhedvwldqhqhjrrjoh.frp@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.73:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3zd9gagwkal0vhedvwldqhqhjrrjoh.frp@flex--sebastianene.bounces.google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.73:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B71B445051
X-Spamd-Bar: /
Message-ID-Hash: WNLRFP2W2HPIXXPKGXX6ARQBZLDTSTRN
X-Message-ID-Hash: WNLRFP2W2HPIXXPKGXX6ARQBZLDTSTRN
X-MailFrom: 3zD9GagwKAL0vhedvwldqhqhjrrjoh.frp@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WNLRFP2W2HPIXXPKGXX6ARQBZLDTSTRN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

From: Mostafa Saleh <smostafa@google.com>

Sashiko (locally) reports out of bound write possiblity if SPMD
returns an invalid data.

While SPMD is considered trusted, pKVM does some basic checks,
for offset to be less than or equal len.

However, that is incorrect as even if the offset is smaller than
len pKVM can still access out of bound memory in the next
ffa_host_unshare_ranges().

Split this check into 2:
1- Check that the fixed portion of the descriptor fits.
2- After getting reg, check the variable array size addr_range_cnt
   fits.

Also, drop the WARN_ONs as that will panic the kernel and in the
next checks there are no WARNs, so that makes it consistent.

Fixes: 0a9f15fd5674 ("KVM: arm64: pkvm: Add support for fragmented FF-A descriptors")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 1af722771178..41cc4c1bafeb 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -607,8 +607,8 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 	 * check that we end up with something that doesn't look _completely_
 	 * bogus.
 	 */
-	if (WARN_ON(offset > len ||
-		    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE)) {
+	if (offset + CONSTITUENTS_OFFSET(0) > len ||
+	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
 		ret = FFA_RET_ABORTED;
 		ffa_rx_release(res);
 		goto out_unlock;
@@ -636,11 +636,16 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 		ffa_rx_release(res);
 	}
 
+	reg = (void *)buf + offset;
+	if (offset + CONSTITUENTS_OFFSET(reg->addr_range_cnt) > len) {
+		ret = FFA_RET_ABORTED;
+		goto out_unlock;
+	}
+
 	ffa_mem_reclaim(res, handle_lo, handle_hi, flags);
 	if (res->a0 != FFA_SUCCESS)
 		goto out_unlock;
 
-	reg = (void *)buf + offset;
 	/* If the SPMD was happy, then we should be too. */
 	WARN_ON(ffa_host_unshare_ranges(reg->constituents,
 					reg->addr_range_cnt));
-- 
2.55.0.rc0.799.gd6f94ed593-goog

