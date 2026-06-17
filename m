Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F44CD98E4
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:54:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 69332438BE
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781708064;
	bh=YPcdEz5k/hYGptLVZPb5hMmpS8SHy17Aj5bLXZLACHQ=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uqop3Am20tz0MkYnJDkqqvAiEZaIyGqjS+XprIyqDmuFPkAQvFMBKP1Ac8ehxnVSJ
	 O8Zu54aX5Q1XkVyTbsciRbFoXdOC9eP1Gu7SzoX/VAcRFS0TbhbWQap6D3PJErahku
	 wLL6XlE0PzXnK4y8a3k1JhPGF6sRdQiGfyAmZT03Gb2huEvO7zM0Q5nZhDOayUzc71
	 tz0ohpzzdB1pM5bZr2M4oIVrJQ2OAkwVu9zSBDP2RLlump87U0dossnD25LOOAPkVX
	 +BgAouksbJUsI+p5Mi+vRPyDY7J9TDsTMMJc1X31lZWUa/KfoQnJQm3wluPS4GYmt8
	 M8X1halexHrpQ==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B286144E21
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 14:51:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=El5ZUm+I;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso32038535e9.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707912; x=1782312712; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw1QEoh+UiZ5XFZdVoOucXmJoUZRDixdHeCpCeuLYa8=;
        b=El5ZUm+IDTa+98DRguykyMj/XQ7ssVXpDFa92bUbrjnDC117hW6vlWgGN3BzZq9yeu
         qM2XN6yNdo60OcGmzh0IaRmLt/EK7cjIJ8rE0NWwh0basNZegFrjE2rDZONnxignYxlG
         AowHRUDRDcpTOjwFIrbuXO0KsoAIVMs/GO3/QkxN9fij8iBl6oGdGJp48Xo+6hBOUOkg
         AUX509Dzgs8haIFMXwXZ1TEdnYJOa+bF9pIQSJV/czz9CQUOQMeZgDMHn5HzJcQd5PAC
         AfPRoGzobZHxP9hjgg+wurW5XBLuW5mpsAHnpHiT5bLI13je0y9Qynq7ytEq6saH0Nkn
         UnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707912; x=1782312712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw1QEoh+UiZ5XFZdVoOucXmJoUZRDixdHeCpCeuLYa8=;
        b=kQ93HZUrexkgJzw5VsoYzV2tk4u8dkqeWspVdZMcJCvELYGGjhfeehEeWdetVfVyHp
         Ss6hktw8mEhuYR+VBccP+Q3fJFIFKzpCAa/CgaNlEv6ZLiEv084G2rbmuxIMFa5sUVco
         kviGk3i0/GHDgKDnqiJLJPMGUh8O7hVfApgDSFW/GmVDuPNB+37CCOi+0E7Q9MHx5w5H
         ohsnOi5AyFzhAkGX4mtYl5ceKNtDoNjD5a9zBmuAFCIAyJLV6LgyYwC/xRN1fLiYN+cO
         l/sePEEHEK4gAz11lf50J/AMNYMLmsEP7/sF5qBe3dlgYx+vvDqTZSh9QuU2dZLVkwT5
         vSdw==
X-Forwarded-Encrypted: i=1; AFNElJ9ns5BuAtt5hbrG03vo8s16TAlH+uAx8IDuSMWKmtrAs+BZiZA0KtzPQCJfWc/d54vxBX3QJ3E=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw/KCvpIhMzcXwuTgg3dhCZuAthYdchhy4Iu+chxWT+bvXARQPF
	wnhfymneczc4lopqxU704vlRZpyxEA6HzS6e+DcTEaL2la+PZ/j4Dwo/KQmlc+yNjVNtDqwc3Y9
	/saYE08XTsa14WuBcDuQQloFuaGyAGA==
X-Received: from wmxb4-n2.prod.google.com ([2002:a05:600d:8444:20b0:490:4477:50d3])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3148:b0:490:b5d0:598e with SMTP id 5b1f17b1804b1-4923412f0e7mr58923595e9.21.1781707910745;
 Wed, 17 Jun 2026 07:51:50 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:51:29 +0000
In-Reply-To: <20260617145130.3729015-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260617145130.3729015-1-sebastianene@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260617145130.3729015-7-sebastianene@google.com>
Subject: [PATCH v7 6/7] KVM: arm64: Ensure FFA ranges are page aligned
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3hrqyagwkabmbxutbc1t6x6xz77z4x.v75@flex--sebastianene.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3hrqyagwkabmbxutbc1t6x6xz77z4x.v75@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B286144E21
X-Spamd-Bar: /
Message-ID-Hash: 5A3656NQKGM6HDIO66DKR6BCX7HUUZTT
X-Message-ID-Hash: 5A3656NQKGM6HDIO66DKR6BCX7HUUZTT
X-MailFrom: 3hrQyagwKABMBxutBC1t6x6xz77z4x.v75@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5A3656NQKGM6HDIO66DKR6BCX7HUUZTT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

From: Mostafa Saleh <smostafa@google.com>

At the moment we only check that the size of the range is page
aligned, and truncate the address to the page boundary.
This make an assumption that TZ will do the same.

However, it might decide to use the extra offset of the neighbour
page at the end, which is valid under FFA if NS is using larger
page size.

Harden this check by also checking that the base address is aligned
and reject it otherwise.

Fixes: 436090001776 ("KVM: arm64: Handle FFA_MEM_SHARE calls from the host")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 1a2abd0154c6..d7c5701d0584 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -352,7 +352,7 @@ static u32 __ffa_host_share_ranges(struct ffa_mem_region_addr_range *ranges,
 		u64 sz = (u64)range->pg_cnt * FFA_PAGE_SIZE;
 		u64 pfn = hyp_phys_to_pfn(range->address);
 
-		if (!PAGE_ALIGNED(sz))
+		if (!PAGE_ALIGNED(sz | range->address))
 			break;
 
 		if (__pkvm_host_share_ffa(pfn, sz / PAGE_SIZE))
@@ -372,7 +372,7 @@ static u32 __ffa_host_unshare_ranges(struct ffa_mem_region_addr_range *ranges,
 		u64 sz = (u64)range->pg_cnt * FFA_PAGE_SIZE;
 		u64 pfn = hyp_phys_to_pfn(range->address);
 
-		if (!PAGE_ALIGNED(sz))
+		if (!PAGE_ALIGNED(sz | range->address))
 			break;
 
 		if (__pkvm_host_unshare_ffa(pfn, sz / PAGE_SIZE))
-- 
2.54.0.1136.gdb2ca164c4-goog

