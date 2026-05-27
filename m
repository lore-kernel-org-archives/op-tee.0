Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391CECD5BD5
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:04:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9E84E44E7C
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779894274;
	bh=15nq+W4QtQnuAmCVcxh2XcM8fl+7JmCCyFIX1NGjd4w=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=W1FhhSphQh2WnBVSHwkl64awYmqLprG9/m2JF76LE830+vsD/9wyKGSjuYww7ZC70
	 ZHyxd7A8GgNDF+Kw2egOGGVxLrkD6h/+k7zI2fT0hjc6y1QlV0kFvHVx+6pzod0AXb
	 4/9MOTZOyvcQ3DGQ4L40V2NEVT3FejUtciHOPnPutNJnQH7tTP4vI+olooG4EAK1N9
	 a9490uygA2v3xij4uuYYXZJIsxrjpB01mvUnghSj/TDogUOsu8P+mcIaHD21R1IxRo
	 pRqAWjlSXhrmbnFdC96WcYQedQEZa1UFDnH+lkts3Y4XHGWx6TrHrCMFJ8UjlIZ31T
	 RI0NBorgVNk5g==
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6A48444E33
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 15:02:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=T5KRYJxX;
	dkim-atps=neutral
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fdad6cce4so59317595e9.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894165; x=1780498965; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKy2nPJ+cV4SO6crenI0U9khbA/AjfYfGtFJYOFvACc=;
        b=T5KRYJxXizlSH7MwX8STF+MI7EaMPi9/wyp/sTGbVUm69O6tsAzVRnJ2vJzK0sEi3Y
         9zn1V4AWy+HGB73efHILLXjOVELm0evlMknutxzjjft/MV7b5a+haZF0lzEHwiVbLuf9
         X5rMzb1L/IdaANZ0HmVJWtApa8LWXd9vmVUiKkB7xQVg/pFrqYrSsv1ks8JRVo9V9Q06
         ucVPa8EeAbYqxh0iqDGmsqO4MF9Wmwyfy/qoBvABZEUDwosJCQDyUCMVOfDVUXIMq0kp
         eix6aD/eaKEr68wmcGjWJ+v2yZozTze73QU4uebuxqDoUHdxY9XmGNl/fkzw5iq5OdIs
         mYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894165; x=1780498965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKy2nPJ+cV4SO6crenI0U9khbA/AjfYfGtFJYOFvACc=;
        b=TLuNrTZU3IHj7rDhjo58+WrJoZ2VbXPehi50Vnl3oCpVTPhZ0saZSbqTEvBKk/5PUn
         p46zLj8ZzGdGHeZq7TSnD9weYSlviKq5j6iuJ/Ris5gm1Li4gX4tpWKEkfR5jc1YZAVq
         sMjX2CdRLGfVX11JcIlt4RyRvxngjXdzCsqyEU8o/fJYTTnOLN3VHe5+KdkhlIWOmT/a
         KH8pJwV9+/+9qOfWsDXWBgen/6sVsBT/Dofs8NBoX6G9PZCqieeN8N5JGauv6yWn80jt
         4AFrNYsTd8NZIccFyT216RHU/XmjwgUPnf9wt+octL8Gzm85rnbO0mrY+HtMrYSmRkMn
         cX8w==
X-Gm-Message-State: AOJu0YwqtvPzGKHcIDryiwr61WDe5BIzCKfkZ5l+G2JMt5n/HRvhjVdo
	5Js2nFHDwk0H0uqm7QccyUkJQ5at7JZPBdOCzZ2+qznOcsvCPnYCdktaJCvFml1wnorH0NQprzh
	fT6C171IuC7Rkm6N+6GhybZnfDe48taZCLURf85VCW/UdtUIFANqrkh/W36cOYiHDG2EqD0dr18
	iYOKtzZ+BpQMQGSINq/TXCCupvXc+8FsNib7MkFjFvuEWfjRdnEMPaI8cEXYoI
X-Received: from wmon5.prod.google.com ([2002:a05:600c:4645:b0:489:1b1b:132])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:2a8b:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-4904226d9camr214273595e9.5.1779894165174;
 Wed, 27 May 2026 08:02:45 -0700 (PDT)
Date: Wed, 27 May 2026 15:02:34 +0000
In-Reply-To: <20260527150236.1978655-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260527150236.1978655-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260527150236.1978655-5-smostafa@google.com>
Subject: [PATCH v6 4/6] KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3lqcxaggkblgiceij0506ee6b4.2ecef-j44b8iji.jhkij4358hcm0h4.eh6@flex--smostafa.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	NEURAL_HAM(-0.00)[-0.990];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.73:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3lqcxaggkblgiceij0506ee6b4.2ecef-j44b8iji.jhkij4358hcm0h4.eh6@flex--smostafa.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.73:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6A48444E33
X-Spamd-Bar: --
Message-ID-Hash: 6KAQS463SDBDIDXMLA3DAIFARMVBGVW4
X-Message-ID-Hash: 6KAQS463SDBDIDXMLA3DAIFARMVBGVW4
X-MailFrom: 3lQcXaggKBlgICEIJ0506EE6B4.2ECEF-J44B8IJI.JHKIJ4358HCM0H4.EH6@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6KAQS463SDBDIDXMLA3DAIFARMVBGVW4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

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
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 1af722771178..b6cf9ad82e12 100644
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
@@ -641,6 +641,11 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 		goto out_unlock;
 
 	reg = (void *)buf + offset;
+	if (offset + CONSTITUENTS_OFFSET(reg->addr_range_cnt) > len) {
+		ret = FFA_RET_ABORTED;
+		goto out_unlock;
+	}
+
 	/* If the SPMD was happy, then we should be too. */
 	WARN_ON(ffa_host_unshare_ranges(reg->constituents,
 					reg->addr_range_cnt));
-- 
2.54.0.746.g67dd491aae-goog

