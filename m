Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD3C43327
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:22:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0A3F944DA1
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782814967;
	bh=0NmZSBhEKcrvtOD/18rEBe2QfhTmQd4sewt8I6RtBBM=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gL7UpZhZDfWWHqIkZTyhYROXMdO+7Rh7HDpDTGAG2Bhft9MPIp3Vq6YDMA44nJTr/
	 gVEcBH2unbgznD19B+XTDHnpTRVtDpL3h1hr0lgTlProFrPUSa+ttew/7draXkhGN5
	 ce3nn/oAL1MBVb9g7OxA5L4eI95Vt+NKUcNS6Wbsn0rQXha2DVmSqerYVyvZVHeLaU
	 egJdzFMQdgUYvaloBSA1brqQPJ1M4GFmnQJBC7J9/XqTbl37NldDkIz5NPMS3Xilpb
	 s51bDoR+dkB773Qufiv57tUoeiLEcCBolEcQvEOzihly2aiyrbVfWCacupjJo5Xfyg
	 T46CNcveHqjUQ==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6D7D544F96
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 10:21:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aopzvjNp;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493b786d550so9923245e9.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782814885; x=1783419685; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsJ5Z8DyAJvdmrOoxOJ7TrWR7XLa3prh+sP2FotAqRo=;
        b=aopzvjNpebsBaRvKicGv4uL83cyYh3jr2gu7O1YMPQ00it3vNY08QaqZTI00TIENyG
         IvszsfdS/pab4MnWVJQWikrMpPkA/wHEkoAyboZ9ECgGe8lQNVuo2Xbg9tsXyXlVcgfd
         XoVkhl8sr8vcJuse+3mM54SrwcwkPtvgCf4sFAZaHqPaxqiZkwnTzbh+ybM26ig2omMB
         7Hb+kFT2r7BxpsF1AOESkSzH+q9+z6l40MtGJZ2Kd0H7O6xs467Q+pEb7FY9JbGyfrMK
         lNCm0TWiec8kzR99eOOho7cY6URJOXD75sPqNSbfxASPdfv/vm+Y5tYJ3V2Rg/AQB1zA
         kkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814885; x=1783419685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsJ5Z8DyAJvdmrOoxOJ7TrWR7XLa3prh+sP2FotAqRo=;
        b=PK8CT0HJqVUdcJ8A3K58mCsZ9ZoEjKJQfRPWldrc6li663xcb+p+OVazN9hs8BQnop
         OVW6H+cz38YSaWn2KAVN4Tw+2fqBM7f8N5ahuer0oPbIOF5nRTQ4Jd+fa8T3D8wGsdkn
         ewVL5VMqPuwq5IGL1oQ5kMqcQXNCloDsKCZ/pX61mTFKEwzsBjWlNMfEMY5o7iLQfXPN
         iLrv13emw13DWbiInVYwARaCiowdU6WOgqMa0O+KJmy0eL+eNeN3MjX/BOEsSJlIeaww
         xVcQllcdL9FJ2Cy0YQ7RoOkKa4+c974sU5NzK8JXfLAD3c4hM5boTBK9ZcHPK+PLAujE
         Ke4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8JKrftIm884nSFPEDw1PrRaMe2fqcgc099gvr25rstVQrPR8QBqgFvgBvpIUSoT8EDGoG2ipI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxHYYBB6FvALhbe8aoPHHhlFAazE6BRMk8mSIxuuAUYJL5jOBCv
	9f2E+qjkWsRjXxX+BRUi7Nsx/9e0qZk5iIn47GvPiG0RpqS/tyXr8aUBSWtOf/P5PjGNwoFPoaI
	FJb/y8IH7kNe3H2uEpOzdas3ek5iZhQ==
X-Received: from wmcn17-n1.prod.google.com ([2002:a05:600c:c0d1:10b0:493:b636:4efb])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6218:b0:493:a7fd:15d6 with SMTP id 5b1f17b1804b1-493b8289c5fmr47379145e9.9.1782814885168;
 Tue, 30 Jun 2026 03:21:25 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:20:56 +0000
In-Reply-To: <20260630102058.3219867-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20260630102058.3219867-2-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630102058.3219867-5-sebastianene@google.com>
Subject: [PATCH v8 3/6] KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3pzhdagwkad4xjgfxynfsjsjlttlqj.htr@flex--sebastianene.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3pzhdagwkad4xjgfxynfsjsjlttlqj.htr@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6D7D544F96
X-Spamd-Bar: /
Message-ID-Hash: TXZ6KZ2E67DVB4NFVG5VREN7DMHXTY4W
X-Message-ID-Hash: TXZ6KZ2E67DVB4NFVG5VREN7DMHXTY4W
X-MailFrom: 3pZhDagwKAD4xjgfxynfsjsjlttlqj.htr@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TXZ6KZ2E67DVB4NFVG5VREN7DMHXTY4W/>
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
2.55.0.rc0.799.gd6f94ed593-goog

