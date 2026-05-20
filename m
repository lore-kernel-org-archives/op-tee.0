Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FBACD4F54
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:51:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 12DAC44E84
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779310309;
	bh=yDqwfpq2LumKo+eR1zTPgnIkRGiNvFK7fJiI/Swmg4c=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=VNJpNirbsrQTb65Eg1sSNu2i4wSpynPZdSa5biCBpxJEoLK/QsrhxZBnzee26laz2
	 pxrnM9OB1ayeawbtij6BmakRtRruVDrLU3hd9oen/CIzJzZL3Li/LtZokihsRS642k
	 7Z+yVRpA7ggbv/S7RvPyVpNiR/FB82dAXkuFW+xUr1wlpX7+7RR112guYj2lg+2AMi
	 PIilUoLu1Vyx238Kj4c+TEI88ksNf5Q1ZobYk0UbvxjkfcOe68GgOiWlYzD4RUNKKv
	 32PvRNm+mtiSL25KPl7ybilg/MrDR3PyWo0x4F5u/Iv3iTQDb7Yk+Or4IN9AHP/g1i
	 4rR/zTRipl/lQ==
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B5B3944EA5
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 20:49:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sgThrO8b;
	dkim-atps=neutral
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso31557215e9.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779310198; x=1779914998; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5sFw8Sj0s1wSBlDG0qQA5R+qSlafViNaiQqa98n5zM=;
        b=sgThrO8byNxbVOnCKXyhNZUtDGIMmnLIRc4GhuPnZli8AHirI8Nb02Cx+HziFEG9W+
         WPVu7LwlJ75JlhBU/g4NChGlfshjjr7mm7l/pLm6o22Um0CUAR8OjaIElt5mJq8PLFQe
         8wp0i+cb50N76EEXbia0A2d4nwE2qJk26dKAxpr6Pi3RUXMWTcDJ/FeEpYvVMcIgsMlL
         OaixgebMV5p7no19Aq9Ne9tPY+/TeLOwoiyG5X67GXaBvyxFuqSRSj5d55HPiYal6uN4
         1C6d86EqQtpx4UX43Zx1EKBi5/YtiYqmE2WgC1AXvyOlBle5kzXRY0Ta61R1E4C8ScQh
         9jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310198; x=1779914998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5sFw8Sj0s1wSBlDG0qQA5R+qSlafViNaiQqa98n5zM=;
        b=qak1TOiXT6Daunt1vk1v+qvHW3426Qjg4h1FnyNp5eBXKMwfxd5W/XzYmIAdDFnIUq
         exUSLW6OHS4zgNOae2xXMEhfURsXda8reYUpg7jbKSnreQxxZWv8sk7sHLGSglpTZ8bH
         UNnarohdEwAC+hqe2HHHFB5jgms1OqsRJah2/r62tlKBinOOVHanfiYgajtvGZIFiP+j
         p9LN154FU7mMg+BkJGmfj6WHLtTamAtUX6hvLZ/Q0Gl4PVZYKDXxZI+2OG7cCQANgj3v
         cQwV/GNynzeWLD2QmJSf32+UThkEfpzf4t21jcltWOx0AiSz78uUOeo4qt7TI2ImifUP
         eYVQ==
X-Gm-Message-State: AOJu0YzSuYdv/RnVsJXtT5K+Y348yEbIJfZL84TRJCdhiIt4VfTDvb5s
	EpA9cCb/YI/Mq36PnG8A+awFk4M93TgoeimFOp05VJzqeXG9TxFsHSfBgdxnrUGEnhZIPWx27eU
	tJqLVILeD3Rs3nJGfFxpntDrftOzev7RJdEaY60VjttLY0RbIzqbF9JxH9CXmb87+qzgpQzaLlV
	apUHXV0gJpCRD7dvT6ivbFrWTka9VAiitJ+YW4TmMYx64H1lnLH3RkfEwfIfgE
X-Received: from wmlf11.prod.google.com ([2002:a7b:c8cb:0:b0:488:c011:ff58])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8189:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48fe632374fmr370978765e9.20.1779310197436;
 Wed, 20 May 2026 13:49:57 -0700 (PDT)
Date: Wed, 20 May 2026 20:49:47 +0000
In-Reply-To: <20260520204948.2440882-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260520204948.2440882-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520204948.2440882-5-smostafa@google.com>
Subject: [PATCH v4 4/5] KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3dr4oaggkbkiwqswxejeksskpi.gsqst-xiipmwxw.xvywxihjmvq0evi.svk@flex--smostafa.bounces.google.com];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.73:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3dr4oaggkbkiwqswxejeksskpi.gsqst-xiipmwxw.xvywxihjmvq0evi.svk@flex--smostafa.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.73:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B5B3944EA5
X-Spamd-Bar: --
Message-ID-Hash: B44KC36QO6KAVLFMSZQ2ZJPDOQPX2ZPI
X-Message-ID-Hash: B44KC36QO6KAVLFMSZQ2ZJPDOQPX2ZPI
X-MailFrom: 3dR4OaggKBkIwqswxejeksskpi.gsqst-xiipmwxw.xvywxihjmvq0evi.svk@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B44KC36QO6KAVLFMSZQ2ZJPDOQPX2ZPI/>
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

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 1af722771178..e6aa2bfa63b1 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -607,7 +607,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 	 * check that we end up with something that doesn't look _completely_
 	 * bogus.
 	 */
-	if (WARN_ON(offset > len ||
+	if (WARN_ON(offset + CONSTITUENTS_OFFSET(0) > len ||
 		    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE)) {
 		ret = FFA_RET_ABORTED;
 		ffa_rx_release(res);
@@ -641,6 +641,11 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 		goto out_unlock;
 
 	reg = (void *)buf + offset;
+	if (WARN_ON(offset + CONSTITUENTS_OFFSET(reg->addr_range_cnt) > len)) {
+		ret = FFA_RET_ABORTED;
+		goto out_unlock;
+	}
+
 	/* If the SPMD was happy, then we should be too. */
 	WARN_ON(ffa_host_unshare_ranges(reg->constituents,
 					reg->addr_range_cnt));
-- 
2.54.0.669.g59709faab0-goog

