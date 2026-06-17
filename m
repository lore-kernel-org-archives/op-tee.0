Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785EACD98E2
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:53:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C465244D9A
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781708037;
	bh=0Gnoj5mVkYvfotoTTL4oke5ZLGjP0C1k2XZl/76sd5A=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=MDAX3rMnF7tIuS/oMRUp8TWcb3OHb2YNm7cfzF12JIBo6HpEfX7dfdZoStrFcxwrA
	 vTGeiYzGH6wkb+zkD+AwEa3aWipUZ6ZOKVxRtAg8Ptd7WY1OXMmoQqU5ZKzKOflmsT
	 X02Ihtl6T6taQ9C2Aa45FY/I9RTOHcMW2WXJeAi/A4IiYCOK8TG96KLIf3o4NMF2O7
	 SnTYm+yaanEU7/cReE7wd6gt8IR6AODPNu7z9TV5a9O/c8KgY75aSvQbjZ0ZlJG51B
	 3LPxf4QIAn1KcEyZqy/IMOaqWKW0BOpJVIJCrK7PR/rCBgHYjxlAuKKffpA4edfWSz
	 iZK7NTxufM6Lg==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1848744F2E
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 14:51:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K5W2nxIH;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490addd42bbso31591045e9.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707909; x=1782312709; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkRBbhHB4iuN7xSPIITChDuTjwYpXvbOBnslFsQsEpc=;
        b=K5W2nxIHjOUOii6pJHAGnt155ShctowhW47haCOrFjIiEOd/YtTZ1CY0vsjKU2emGt
         B7iJKGwylbK4qdSPAqsj6U8d9Q996cUYztsxsSc3C6ZcvaXKzM/vu3RcjsR6k2Dfo3Jq
         2Ey8f0wXrnXBr2PUkRksEHpTluxOnV18OozeM+ZyqPrO1kjYJiSWDWeRF4jy5R3yLYTe
         ScxCbq3WM2zve3xLS1ZeTPCB2875M0mXGfN9c2jGwBkN2czjym8CkqzbDdYWoEKhpeYJ
         lBfTAgL6ZptxrUrWyYhBft+8eRYHXZua4rKAPf4YWq4WWc6/jdVMaUFWEZ+A1vicH/Lg
         vBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707909; x=1782312709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkRBbhHB4iuN7xSPIITChDuTjwYpXvbOBnslFsQsEpc=;
        b=XLrYGyUT5jz1cjoJMYt/yo6dnE6gcNVuagulAWJSwG0HBGCQSs4Y6j1nNDiZVtNX77
         oCqp9VWKxf6QnzWB3zIKdpY7mpgLf8e/BVKkj2OOmmqWha3aZlzbniRQCPc8JuV+iICT
         d6qr/C7/LQJQ2+oKP6m8iuDWIdorHphpFHYrxIb9QIIaPf+dH6K460YfrhTU0FG728KJ
         cZS54pVh+iSOS92F6wFnp8DY6ogQ5fsSkUx68WwqB42cBfYDRq3JKvbzVab3I+NyVv4G
         KzUZUjcSMOscNMDUE7D5nDLssYUSN22IcGVAP9S0KqBj5hdZcqrqrlcbXUVIf4ABxwUz
         9WwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vKO+YzpCRtmNjOJLrdBZwBuScrD2S0WzDXlWRjdArTvaZDdXHk+rUj9/CFlF80LFawBKrc08=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzaNn1qJDrNx6gA7UhGB78SFegTlSG3Tj+pRS0/uB6TFh+Wr66i
	p/Q3CVYKpldpD8HDriY6V3cqLwJsRk/N/gmYY5fqtVdlYrPh+pFQqBzHpV8Ja7Fq9TXrrQAAco0
	QkAbOJNui+vdffYdEbfbV3JsGhZnyFg==
X-Received: from wmbc22.prod.google.com ([2002:a7b:c016:0:b0:491:41a:40d4])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:37ce:b0:490:bd66:e526 with SMTP id 5b1f17b1804b1-49236791faemr29047845e9.32.1781707908701;
 Wed, 17 Jun 2026 07:51:48 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:51:28 +0000
In-Reply-To: <20260617145130.3729015-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260617145130.3729015-1-sebastianene@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260617145130.3729015-6-sebastianene@google.com>
Subject: [PATCH v7 5/7] KVM: arm64: Validate the offset to the mem access descriptor
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,3hlqyagwkabe9vsr9azr4v4vx55x2v.t53@flex--sebastianene.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3hlqyagwkabe9vsr9azr4v4vx55x2v.t53@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1848744F2E
X-Spamd-Bar: /
Message-ID-Hash: 3W3YV6N3ROZ3TXQLUSET6E2PHAI3HJGH
X-Message-ID-Hash: 3W3YV6N3ROZ3TXQLUSET6E2PHAI3HJGH
X-MailFrom: 3hLQyagwKABE9vsr9Azr4v4vx55x2v.t53@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3W3YV6N3ROZ3TXQLUSET6E2PHAI3HJGH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

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

Fixes: 42fb33dde42b ("KVM: arm64: Use FF-A 1.1 with pKVM")
Signed-off-by: Sebastian Ene <sebastianene@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 2d211661952e..1a2abd0154c6 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -476,11 +476,14 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	DECLARE_REG(u32, fraglen, ctxt, 2);
 	DECLARE_REG(u64, addr_mbz, ctxt, 3);
 	DECLARE_REG(u32, npages_mbz, ctxt, 4);
+	u32 offset, nr_ranges, checked_offset, em_mem_access_off;
 	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
-	u32 offset, nr_ranges, checked_offset;
 	int ret = 0;
+	size_t mem_region_len = !FFA_MEM_REGION_HAS_EP_MEM_OFFSET(hyp_ffa_version) ?
+		offsetof(struct ffa_mem_region, ep_mem_offset) :
+		sizeof(struct ffa_mem_region);
 
 	if (addr_mbz || npages_mbz || fraglen > len ||
 	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
@@ -488,8 +491,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 		goto out;
 	}
 
-	if (fraglen < sizeof(struct ffa_mem_region) +
-		      sizeof(struct ffa_mem_region_attributes)) {
+	if (fraglen < mem_region_len + ffa_emad_size_get(hyp_ffa_version)) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out;
 	}
@@ -508,8 +510,13 @@ static void __do_ffa_mem_xfer(const u64 func_id,
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
@@ -574,9 +581,9 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
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
@@ -599,8 +606,14 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
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
2.54.0.1136.gdb2ca164c4-goog

