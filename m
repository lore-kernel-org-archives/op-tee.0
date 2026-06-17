Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969D0CD98E2
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:53:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E1F6A44DA1
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781708012;
	bh=RYLphXY3qZrHLwVyATq2rz6ULfSNbmNMCCt4D1nRClw=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=DIoAyX0keE3Q/06C1rJpf0kUpVEAgrqgiXoxHN1f+lH/1FlUZWYQvnK1Ds4hHA2fs
	 C2M5CcxryMoIvjKzvz/gFAy4UNQ2kchuLdGJAfAu33C4LvztgtWjC7RpIGIXY6+EkN
	 yarAYYRlTE3KXZM5bbWikzNughA17/+Y0YWeC0Z13hNihXzHjm3bZw5ocErwBK9q5P
	 l4RC8AyJXXcw245oLxyfy2xafrILSkqw8XfnWEWIxc53RqYftsVMjOwwfwTxvFU10M
	 Nk4TJhdQO6ShiKtn6GbSHFtR0KQhHsKj3Hwn625D/XeFYl6xJPYPcVd1XDy4ZuPp3P
	 6sSnbjALs5jNw==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5886744EFB
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 14:51:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LkYOYpOe;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so43422605e9.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707907; x=1782312707; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQFj/8TPJyuneEGc/c18D84EbHbY3hzTyS99LAP/4do=;
        b=LkYOYpOeOff0isJE6cAKp2oU3V1s5yKddaVdYcEQGgZvDyCDl0d9lzA7Y99aZbemnw
         4hSR83H3G2G4ba9PLJbQQv87RlOu+78iUZ3/9fW1w3hr5JPrpiBd9Sd4JPb6eLf1s3VW
         MMjwIkyMomccJ2TkVShMqj5ZzHcJ3WMF2z1W9ltdNXytN0ehzv5XTmsRFPynnJFMtBGe
         vw21Jk295mPKAyRYq7HiXE8tXDxzQ/l75MC2lnszqKeJFYlXzMFdUp2uSGW++CiG0lFX
         7dXcWj90VHM18cf7b1ftSrhS5dZ4S9PMvup4pvpLNwjqYcTV3W8H+qGF/68IO3V2FYvI
         P1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707907; x=1782312707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQFj/8TPJyuneEGc/c18D84EbHbY3hzTyS99LAP/4do=;
        b=ZsNwbTrIopRg3xFbRlP5uWqfi4roNtcYgdl+n5jbbFHYunRSi1iKOhU3BQUyJWpIc4
         iHOUNsgDey/04hDPhXTIA7j/lbEvk6epqttWYsq8erBqcKJiYcmBHoSPSotTIXT1uikp
         SVI/K0qzvllcDpXP8V3d3AzpHB6NA462o1qXYxTU6VQmsSUGyYUHgaWE1ZHWevMI47wu
         F7mIoaG8HJe2Q8zWX2MASadcwjh8LHlSZ004Cs8x75qBnnd5MvhlYKHJ6vPzquAiiMUt
         6cOZ0BXUPzYDIJn1hbp3G/rMsu/Pc/LOah8vjoAb/KtHHBNtir9OPPNWPVOpTAcupCzJ
         lVEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bW1HCtcFHFRMkJ+HDkvuKXk3tNuvGkc9uJulTfe5wHovIwdgS0psZVznXStfXG5k8940mx7A=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwT1m+EumHi6PniMXbNboy3lL6ld0i+J2AbBgX0UBC9Vzwetr4h
	tJZ59YnSnc6ChBhaa8dvrca/ZP2Wl+0+3XrhQ0dr4yBigWvQJWy39qmUUZlZ4bauanCapVylNMp
	IRXk1BmMeWmHEGd/1OjGiIlePr2EBEw==
X-Received: from wmbju24.prod.google.com ([2002:a05:600c:56d8:b0:490:b18a:b4e2])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:828e:b0:492:2e7a:9ba7 with SMTP id 5b1f17b1804b1-4923339fca0mr74090555e9.3.1781707906450;
 Wed, 17 Jun 2026 07:51:46 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:51:27 +0000
In-Reply-To: <20260617145130.3729015-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260617145130.3729015-1-sebastianene@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260617145130.3729015-5-sebastianene@google.com>
Subject: [PATCH v7 4/7] KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3grqyagwkaa87tqp78xp2t2tv33v0t.r31@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3grqyagwkaa87tqp78xp2t2tv33v0t.r31@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5886744EFB
X-Spamd-Bar: /
Message-ID-Hash: NLKBPYKWFX4ADK6DUYBVENOPLOSA3WTP
X-Message-ID-Hash: NLKBPYKWFX4ADK6DUYBVENOPLOSA3WTP
X-MailFrom: 3grQyagwKAA87tqp78xp2t2tv33v0t.r31@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NLKBPYKWFX4ADK6DUYBVENOPLOSA3WTP/>
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
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 1af722771178..2d211661952e 100644
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
@@ -636,11 +636,17 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 		ffa_rx_release(res);
 	}
 
+	reg = (void *)buf + offset;
+	if (offset + CONSTITUENTS_OFFSET(reg->addr_range_cnt) > len) {
+		ret = FFA_RET_ABORTED;
+		ffa_rx_release(res);
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
2.54.0.1136.gdb2ca164c4-goog

