Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A61C43327
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:40:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EECF64502F
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782988849;
	bh=RVonFDWpygT8oBcy9USOgqohMRqC4xEQf3kgUS7+Kzs=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Icvb2l/f4uzFgeqOxBxuZk9QaLBIzv8cMVko+7Hdqs0SiTbZckr7K37dJBjSKJym8
	 3AjyMHAmdgaGz40c4WyRyMahSkmPjaAfdnr6UselmDME4A0Sw7N4fRcDgIDxqWv3pa
	 8ysBDDMJTwALCpSf3U9+Irrh63qrzyg3H5jLzU4GSWez19PM307s4XJ7iP60ub5xeq
	 N/HLNCXhnEmRt+tVSdKfkw+6e4wFR8FFxvmI8xosCZMbJCk7YgR5uebKKRcDBnOnoQ
	 F4Tq0joO5GEit4NJmY1G3A6tk294cCEwZOrm8IZG7JO2NLp2I1YG00gpN9J9lI7tGJ
	 tXC49SU4eQ5xQ==
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C669744E65
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 10:39:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OlOGwKdp;
	dkim-atps=neutral
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c126f9928f6so172027966b.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 03:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988753; x=1783593553; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvvBZVAHxjCca8xpuD4vg6YCLTc80qN7YLXWi5qiQXY=;
        b=OlOGwKdp9gd8xayODYSn8vRHrei1vdSs+/a776Bgm3CjbehwDim1krLqToihk9jDJr
         QodVB3tyJbZgk3g02zfqa4I9UaRoa2AudHSPZB8ytmUSpiYor3PsixgaiLb9H6+DDlj5
         olUBwFZAnCMYzXopXIAm9dizoVB3oCiBPbt5zBWRCm4LEAmyYwp5yHeQitLm45djY0to
         U13+W2DpOpZoinJRcbtIe2GhLhAIJ1dHk78WbpPLKZKOg67YLnIqwUYfpXpdqe9hIOBF
         Tw7N9CVRrMVYxqsS7SEw4DC2mnr8xuOJwI6Yttvx1kLKsscT8MNNDSEYhHV6VKGoLO6y
         aPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988753; x=1783593553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvvBZVAHxjCca8xpuD4vg6YCLTc80qN7YLXWi5qiQXY=;
        b=qEyH1wMOwIp/Jb4+WiLP0uV6HB1JdrlngrAZ6iQk/ZCMWYJqhi4H5/SJf388BRW573
         z/a2DBqen7unS2l7T07DmQdVC+1Agk4wwFhccuOD7AGnDi8ssmu8KPWz+UFK2touFxJp
         /dKlfqfXycU0+33ZbItvR4HjUuQVxfewyAxv3isq/FD6dfwGarcEIA530ntLt8LsaFWa
         t8EBopWlKFRN27u4QdiCtP3usSi0OlMDXLC8yCgz0Kg+kCuc79O9WyHcTNmmDUHgphHn
         eVnXmW8jbxaCQ8gj0jBIuFXJWASkd0OX+yHEVGjJCIYz/hMK0ubF0tEJsZ6v7xWq6T1G
         KR8w==
X-Forwarded-Encrypted: i=1; AHgh+RpQJzYU34CibBFT7RYEmXsu/KrfXDFm2AbpvCuP0WSapfc0WTSi+N6B9dd/dOwzxAGeBYBfKdI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxS5kBhqs0dDgAQkxth8dVdiwV/YcM/Q+thVehoWdbUoLnVfo7j
	IxMrJujAw/VLKdlzsC9FDkF0o1UqvhG6LPGS2iTGn6U/tAo5MKmkQEGkT2vueHiUnys9hgONkkd
	n4f6hKWS6UdhTjo6orOGDk+wMUWSxEw==
X-Received: from ejcxl38.prod.google.com ([2002:a17:907:d866:b0:c12:69ca:c04d])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:6290:b0:c12:34ed:e0fc with SMTP id a640c23a62f3a-c12aa1d60f1mr264254366b.58.1782988752409;
 Thu, 02 Jul 2026 03:39:12 -0700 (PDT)
Date: Thu,  2 Jul 2026 10:38:41 +0000
In-Reply-To: <20260702103848.1647249-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260702103848.1647249-1-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702103848.1647249-5-sebastianene@google.com>
Subject: [PATCH v9 4/6] KVM: arm64: Validate the offset to the mem access descriptor
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,30d9gagwkamezlihz0phululnvvnsl.jvt@flex--sebastianene.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,30d9gagwkamezlihz0phululnvvnsl.jvt@flex--sebastianene.bounces.google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.73:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C669744E65
X-Spamd-Bar: /
Message-ID-Hash: ZUTSCSD53RUANMY5PVOXBOKN3TVBJGCD
X-Message-ID-Hash: ZUTSCSD53RUANMY5PVOXBOKN3TVBJGCD
X-MailFrom: 30D9GagwKAMEzlihz0phululnvvnsl.jvt@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZUTSCSD53RUANMY5PVOXBOKN3TVBJGCD/>
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
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 27 +++++++++++++++++++--------
 include/linux/arm_ffa.h       |  7 +++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 41cc4c1bafeb..2e7ab7e3319d 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -476,11 +476,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	DECLARE_REG(u32, fraglen, ctxt, 2);
 	DECLARE_REG(u64, addr_mbz, ctxt, 3);
 	DECLARE_REG(u32, npages_mbz, ctxt, 4);
+	u32 offset, nr_ranges, checked_offset, em_mem_access_off;
 	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
-	u32 offset, nr_ranges, checked_offset;
 	int ret = 0;
+	size_t mem_region_len = FFA_MEM_REGION_SZ(hyp_ffa_version);
 
 	if (addr_mbz || npages_mbz || fraglen > len ||
 	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
@@ -488,8 +489,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 		goto out;
 	}
 
-	if (fraglen < sizeof(struct ffa_mem_region) +
-		      sizeof(struct ffa_mem_region_attributes)) {
+	if (fraglen < mem_region_len + ffa_emad_size_get(hyp_ffa_version)) {
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
@@ -574,9 +579,9 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
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
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 033c630b271b..e71d83ee0aef 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -421,6 +421,13 @@ struct ffa_mem_region {
 #define FFA_EMAD_HAS_IMPDEF_FIELD(version)	((version) >= FFA_VERSION_1_2)
 #define FFA_MEM_REGION_HAS_EP_MEM_OFFSET(version) ((version) > FFA_VERSION_1_0)
 
+/* The layout changed from FFA_VERSION_1_0 and the region includes an
+ * ep_mem_offset.
+ */
+#define FFA_MEM_REGION_SZ(version)		(!FFA_MEM_REGION_HAS_EP_MEM_OFFSET((version)) ?\
+						 offsetof(struct ffa_mem_region, ep_mem_offset) :\
+						 sizeof(struct ffa_mem_region))
+
 static inline u32 ffa_emad_size_get(u32 ffa_version)
 {
 	u32 sz;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

