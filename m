Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEFACD5BC8
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:21:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F0D6944DA6
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779808917;
	bh=cWAWGazl9y0NCQE6boUFtmipRD653SY/f3mBGb2AlJ8=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=RIpUbUyP+Go7R0UB6K/fpgubWIoF4mUWrWjMWS6gWPOdCJqwk+mwGlWpGo78V1RG8
	 rGHLojDD6QIwJ3UdPLtbS8da2gVFE0gs+hx1XLQ94pRvzCPhTU5YPRUbXpFmgkQLZf
	 hOErAQ5Qmg5QLFMFbK09QEmyIot1j8ccslSfatUJIu1fg9xobHXiO+wPl+tGDVkWkI
	 jTzWh3rq9zdDXnAN2gF0rqvEyYY2CrEN+IRqJmpevsn4DxhLcBShqKMoWst13q/p6N
	 r+4baqaP+qeReFTvQoFcKwpwcPE9O9KcARszv7uKomfCWIjUfRcpYmyKELzORWzGM7
	 vZdHCNc4Diw6Q==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D77C244D9E
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 15:19:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VJvUYjkG;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490402ae2c1so45516945e9.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779808792; x=1780413592; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e46ed4u5Cv0I3gq+GXl599KXwFIbkYlwQRCW4+ScRKU=;
        b=VJvUYjkG43m5BtE/qA3rw07fwd4Fj5OZWQKZvHtupEGOZJCRYWJh4u6dAXqJhj76tg
         DhJLpsWGAps/0ZaaoVjYb/WNS2xbuynb6LSk/UoIDvs0RHNf2osYeyUnz/WvUDlMmPEG
         yqEE8Je+l5WhQ+NDNcfMPGgJItoIXBJPKzeLSWbLzpOLvSd8jo6nG0AdZE6J9qq3Aqwv
         qP/3n/YLUEO+CPa2eCYZwLQgOx97abu8xq03u6VU1quAHIgCFcHyM0SRniXcMZ782HHV
         40woLNN4KBtu1R/cEkSta6a2ger2F6hFJYxRC3pUvcJbXKtHLTCycjszjg2IZtkh01DR
         ZImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808792; x=1780413592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e46ed4u5Cv0I3gq+GXl599KXwFIbkYlwQRCW4+ScRKU=;
        b=FjTiGVp4BDICAwZkfNhnb0jqH9spAGeKbT/yInPwlkE0LhQ7rTFYe5DBnfbtkn/uBU
         f0fcv4zBS2iupE2gOIkP6BmdofnyKGeaNxCT8ZMhDXidclwOqhovgHzT7ntjb905ZsJF
         x1fLwQZtDlSgNnn4wl1B9IWdak2Q+ZFzguqCnEAHQzNw3bF/Lura8B0gFiBzG1uFoXAu
         bvydQynvveJHTWSctQiOPjWaDf2lswJrWGNa+Y5Pnp3KVJq0ej9YRkTD7nwlSjPfOmdy
         yf5nR2YIWVz1/fefpE6wwkX9fLfXIGucuY6pDOswkAt/IMFKKvD7+EzIgc88FkvH7F99
         NrNw==
X-Gm-Message-State: AOJu0YwUx8+SbVv1vIFsXUl9G1IzGAwCR+N70nM4jvI3+TmAJNyzmj2H
	k7Q62IfqfCWFGAMQNsDyJa+ujgxJFi89s75yxRprLXKR7a3csr6CoQJLO9/GaYCj9Q3Tg7UUx/M
	xh4zlzYUDmNRQtz2CSdGdQUWzUaff3Yv7nk2rJeMHHzgo83NWSe/GWfFdW+tU12bWgKPR816IZw
	PJB577yDHS3wb81vTwVUXKIlp2zxQVN+tSi+HbsDp929k1ER34QsgGfg/QzsWf
X-Received: from wrpj7.prod.google.com ([2002:adf:f547:0:b0:45e:75ad:a480])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5681:b0:486:fcc7:6811 with SMTP id 5b1f17b1804b1-49035f53c64mr252846105e9.10.1779808791592;
 Tue, 26 May 2026 08:19:51 -0700 (PDT)
Date: Tue, 26 May 2026 15:19:33 +0000
In-Reply-To: <20260526151934.3783707-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260526151934.3783707-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526151934.3783707-6-smostafa@google.com>
Subject: [PATCH v5 5/6] KVM: arm64: Validate the offset to the mem access descriptor
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3f7ovaggkbjooikopwbwckkcha.ykikl-paaheopo.pnqopazbeniswna.knc@flex--smostafa.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.845];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3f7ovaggkbjooikopwbwckkcha.ykikl-paaheopo.pnqopazbeniswna.knc@flex--smostafa.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D77C244D9E
X-Spamd-Bar: --
Message-ID-Hash: AYG6RVQCYMMNJYOFMVJLHEQ5ULDALTJD
X-Message-ID-Hash: AYG6RVQCYMMNJYOFMVJLHEQ5ULDALTJD
X-MailFrom: 3F7oVaggKBjooikopWbWckkcha.Ykikl-paaheopo.pnqopaZbenisWna.knc@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AYG6RVQCYMMNJYOFMVJLHEQ5ULDALTJD/>
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

Also, fix one hardcoded sizeof(struct ffa_mem_region_attributes) that
should be replaced ffa_emad_size_get() for compatibility with FFA v1.0.

[@Mostafa, Add missing call to ffa_rx_release() and use fraglen
 as the max buffer size as it is the only intialised part]

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index b6cf9ad82e12..79de358333e4 100644
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
@@ -489,7 +489,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	}
 
 	if (fraglen < sizeof(struct ffa_mem_region) +
-		      sizeof(struct ffa_mem_region_attributes)) {
+		      ffa_emad_size_get(hyp_ffa_version)) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out;
 	}
@@ -508,8 +508,13 @@ static void __do_ffa_mem_xfer(const u64 func_id,
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
2.54.0.746.g67dd491aae-goog

