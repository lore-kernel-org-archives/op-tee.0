Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE6CCD4F3D
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:52:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BC0A54449C
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779310335;
	bh=tuPvZGzF0btmcEj/P7IKTetF6rM2heeP6hTxQ5GodVw=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ek28kbJEB7kU43va0MIsPztnlKxUr2ofB+4bevhbrwt/EQO2bNjiiihxktmNYetx/
	 9URWV7r0492oCFHwGjNvB7Wi3HFa8tJ6b1qVdnoh0Av1/aWw41HCGBglEW9xuiNkaK
	 B5A7tMrqDNbXnSs7HMWIN0OfRyl6yfxk8+2HoRdxB8LuzUQ1PRlSuSsKDc2ggudDMy
	 Kd/vooIV2YIm7Q96CRlyvVy9v7Qx2+hlfQ+CvS3ksDFM3eKESDCCwFpAVNh2i1MSGy
	 iIbKI1p+P3oZINmOwRA46yF/AYCny67vVVcvup8YMlqB9xuCTfY/g3cM40V3vlKr2+
	 tnWaQ21miHtcg==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8A51A44D95
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 20:49:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I5lb3vEB;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fd64c32e8so35303135e9.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779310198; x=1779914998; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdxg0o2btss9qMTZzYA98i+uvFmpv+cRF90VMWdHIeA=;
        b=I5lb3vEBs1dpj5YsjjCV2WF8YlhV8XWIe9NnindZNRr9ix7b4APi8Yofn4oHetD2C+
         90JXYwDrTDZEV2qCSrjIcQasKr79a1icAolfYXA33VMxsG2rGCQaskVfFoZQZWpUtjOe
         99psPd8K7OOaBKsqns0fNuY4YBinoEt/uO8w/EbNg/ZjJ1eRCqw2/Zdcz0kyK1JPY0br
         voEUmS5UrE9cm9Xv9MpyuxKdAXSlepeQGF0Qw4gbVy4GIVgjYX/s3pTQgpQopRxGra/a
         yenI5+NOXPNL+zKAcRnbQd/6qK4Yq4fB5VxQli8gaX1YsMcCVrdPa2yZxgHHLi5cQYts
         1c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310198; x=1779914998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdxg0o2btss9qMTZzYA98i+uvFmpv+cRF90VMWdHIeA=;
        b=SiXnKyR3CQxDaj2cSAX330shRKqZHbWqsajGwOuXVX3zT+7cUbyCdb2qp118AapPQd
         dg4ntUKRTrWRFFw/iTRRZ/JpQFrEiQ1KtmU/rf2PuqH/6BdVeclu1ulkn3+fIEg5q0aZ
         +htZpFETB/z6CFZMlkJF8S253NOIhjNYgWDMyoSYMZW9aZEvnIeRZ3oh74q4U9daoDmm
         o70FyQUkSFokcf0MxoL8QN09FvFGarq+aL9oQ2T+CqOlO6X7DX/RVwPludQAlJiRNgJo
         5rpKGKuVFNz8G4onzW8NcJhelFT4LxcpqxaCkRRzGt2HAbQw3uoEgGEOHqMwlBpkEbSK
         Xlbw==
X-Gm-Message-State: AOJu0YwyF+qDXsnRsIAb6bM6P0hvbJ8n71pqYFz1RQ+hnIr3zKJRnyb1
	LZu5LC3sq3Li2yphUBgFIw4K01KjDL4zhvmghmx7kk68Q5y5vk9v31fboLK/0L2mOKwbYw3swnd
	1Hvj4Vi/qnhgf5u4yG4rNvV0O6mNhWIBKn7uNu/NB9+VLpR5TLItAJC+dw4S6DvUGQEU9lBJZrX
	W2jE6kfpb/af3a8VvWRU6RhHb8V9o/2xcFBJkFv9xt669BQSH1zAB5t7i2Yv5M
X-Received: from wmxb16-n1.prod.google.com ([2002:a05:600d:8450:10b0:48f:e53a:e4bf])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e53:b0:490:1640:8269 with SMTP id 5b1f17b1804b1-490164089c7mr213656225e9.18.1779310198457;
 Wed, 20 May 2026 13:49:58 -0700 (PDT)
Date: Wed, 20 May 2026 20:49:48 +0000
In-Reply-To: <20260520204948.2440882-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260520204948.2440882-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520204948.2440882-6-smostafa@google.com>
Subject: [PATCH v4 5/5] KVM: arm64: Validate the offset to the mem access descriptor
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3dh4oaggkbkmxrtxyfkflttlqj.htrtu-yjjqnxyx.ywzxyjiknwr1fwj.twl@flex--smostafa.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3dh4oaggkbkmxrtxyfkflttlqj.htrtu-yjjqnxyx.ywzxyjiknwr1fwj.twl@flex--smostafa.bounces.google.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8A51A44D95
X-Spamd-Bar: --
Message-ID-Hash: UJP4APUOWH5F7MNCWCBVB4FP4OL7X5V5
X-Message-ID-Hash: UJP4APUOWH5F7MNCWCBVB4FP4OL7X5V5
X-MailFrom: 3dh4OaggKBkMxrtxyfkflttlqj.htrtu-yjjqnxyx.ywzxyjiknwr1fwj.twl@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UJP4APUOWH5F7MNCWCBVB4FP4OL7X5V5/>
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

[@Mostafa, Add missing call to ffa_rx_release() and use fraglen
 as the max buffer size as it is the only intialised part]

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index e6aa2bfa63b1..38f35887e846 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -479,7 +479,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
-	u32 offset, nr_ranges, checked_offset;
+	u32 offset, nr_ranges, checked_offset, em_mem_access_off;
 	int ret = 0;
 
 	if (addr_mbz || npages_mbz || fraglen > len ||
@@ -508,8 +508,13 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	buf = hyp_buffers.tx;
 	memcpy(buf, host_buffers.tx, fraglen);
 
-	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
+	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
+	if (em_mem_access_off + sizeof(struct ffa_mem_region_attributes) > fraglen) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out_unlock;
+	}
+
+	ep_mem_access = (void *)buf + em_mem_access_off;
 	offset = ep_mem_access->composite_off;
 	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
 		ret = FFA_RET_INVALID_PARAMETERS;
@@ -576,7 +581,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 	DECLARE_REG(u32, flags, ctxt, 3);
 	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
-	u32 offset, len, fraglen, fragoff;
+	u32 offset, len, fraglen, fragoff, em_mem_access_off;
 	struct ffa_mem_region *buf;
 	int ret = 0;
 	u64 handle;
@@ -599,8 +604,14 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 	len = res->a1;
 	fraglen = res->a2;
 
-	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
+	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
+	if (em_mem_access_off + sizeof(struct ffa_mem_region_attributes) > fraglen) {
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
2.54.0.669.g59709faab0-goog

