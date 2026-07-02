Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C2CC43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:39:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2B9E444E65
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782988770;
	bh=cqpqWComKRWiCpCFlRr5CCe1UaqVwupCKxUEyOVLkh0=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=j3cpsMfArYnwrZghNiPxMpmvc2aOGnzF8Xdv3hIo71M2DhuLl7zPc8Pf96/H32g8G
	 gDsR/Pp5WZ1PMjUj+bO9dZLbGKWAiZqBjCHyTBUoJ7B/gkvPIfiXGlSedFOL1PAN6M
	 xBl3lt8R6n0W8Tyl5SWah+3WfyD2jF5vn4shqk2Z/vbVXuPL+4pTdXb7I+udnT8TLl
	 eu8R/fMWVa1TZQPZQD2T2mKFCFueqeQmqNZAe4n2WZVmBPgMoBh7YIbeG5cg4noQMu
	 LMcHipOupIwt49yRs9McpJhR+z6kgRc4BGPD3Da6jfKo1k4huKFhnVtZJ2QR3SjbZV
	 Vnz15dicXmMEw==
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4A09844EA2
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 10:39:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=o66L9bkB;
	dkim-atps=neutral
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493b0fe95b6so12380925e9.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988740; x=1783593540; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3srY3du6pUShZyOw/nlifUO0efjUMM7goX5s1Ul3bUU=;
        b=o66L9bkBHpVw4O9r25MJGgYGmiy/frST5u1OUMAbpuDtruHDEvLz/LykfVHPl9g+Mg
         Z4tJZq1FKF4r1bCqQ7VvLg5oMKELhW3i85OsbLuA1zv1xkJ5/IUM6tZUN1u4wzXKqAWn
         +LcygUiA7AjKZ5BRWOKLZ+Bd7tMTUy1dHAkY5tgE+IwykzrK3HgXE8U3WN7vcetjiwj0
         QKJPsDmKppbHKgL7Uwzbggw3BzUVP0cDlNJZxwD+556Id7NZZfWG8HuvECz4l9AMbFxg
         cC3ahP74jmOgHgcBhsOvvpNPR+PxzHq5M2NSTtcPcazVqacp1NRY6lovaMg7objoIs4F
         xDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988740; x=1783593540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3srY3du6pUShZyOw/nlifUO0efjUMM7goX5s1Ul3bUU=;
        b=Fus17RUffwvSbze1kJh6U9Tzej+p3oIhr/JYbWi6ZE8rHzvC2AjJNGlxG+Hau3st+n
         7tFPn3A8dfavQCJmpj5E4LWlpNez7sxbxqPbH/IFiVVT38ToUXgna9PHWJe75WNTAkfY
         9V4m5IkxC2g3uP+RM4gFYRWR28Dd7iJ3pW/kmvq9VdzoWXbRnUp24Gjthv86OD7R4pvo
         lf5c0pWmyfF29BgC6Hq+Xuqk32nKTXzbfO9knRpv0JmULRwbGXKdqTN0Tg6F3Wct0r8c
         OW1YOnzsT3IEHl96sjXa6UIQSpvTDEREeNKj7ONHq1x1shixXHgfSqEscQShdpDO8+rM
         UYVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QQLOooNXh8iItSEgXI5yqEeslKf5dU+EOVXHgbTDjj0bgpD+CFMuXMpye9FShrr4FBWrOsFI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxEC1mKfarvju1tZGkBVQMdtLANl+7HG0hR3P7smRBA4+mpWfqt
	bZu2j1Czps6/wgXTmrHjDcWaVen8YTslI17nkPJP3K+ISiPENqpwTFch9F0E/8PxJEbdGDBZmh9
	qp4tvdxWuu8CLG/uuoDLsvM9hct5KKw==
X-Received: from wmpf36.prod.google.com ([2002:a05:600c:4924:b0:493:b275:289d])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6087:b0:492:1eed:3e67 with SMTP id 5b1f17b1804b1-493c2b96d7emr80737895e9.26.1782988739807;
 Thu, 02 Jul 2026 03:38:59 -0700 (PDT)
Date: Thu,  2 Jul 2026 10:38:38 +0000
In-Reply-To: <20260702103848.1647249-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260702103848.1647249-1-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702103848.1647249-2-sebastianene@google.com>
Subject: [PATCH v9 1/6] firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3wz9gagwkalqmyvumncuhyhyaiiafy.wig@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3wz9gagwkalqmyvumncuhyhyaiiafy.wig@flex--sebastianene.bounces.google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.73:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.73:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4A09844EA2
X-Spamd-Bar: /
Message-ID-Hash: 5WIVQATJKPBIUIEYVR2TENTGBNU2I5IV
X-Message-ID-Hash: 5WIVQATJKPBIUIEYVR2TENTGBNU2I5IV
X-MailFrom: 3wz9GagwKALQmYVUmncUhYhYaiiafY.Wig@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5WIVQATJKPBIUIEYVR2TENTGBNU2I5IV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

From: Mostafa Saleh <smostafa@google.com>

Sashiko (locally) reports multiple out-of-bound issues in
ffa_setup_and_transmit:
1) Writing ep_mem_access->reserved can write out of bounds for FFA
   versions < 1.2 as ffa_emad_size_get() returns 16 bytes in that case
   while reserved has an offset of 24.
   Instead of zeroing fields, memset the struct to zero first based on
   the FFA version.

2) Make sure there is enough size to write constituents.

While at it, convert the only sizeof() in the driver that uses a
type instead of variable.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Fixes: 111a833dc5cb ("firmware: arm_ffa: Set reserved/MBZ fields to zero in the memory descriptors")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/firmware/arm_ffa/driver.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 0f468362c288..01301213896a 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -725,11 +725,10 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	for (idx = 0; idx < args->nattrs; idx++) {
 		ep_mem_access = buffer +
 			ffa_mem_desc_offset(buffer, idx, drv_info->version);
+		memset(ep_mem_access, 0, ffa_emad_size_get(drv_info->version));
 		ep_mem_access->receiver = args->attrs[idx].receiver;
 		ep_mem_access->attrs = args->attrs[idx].attrs;
 		ep_mem_access->composite_off = composite_offset;
-		ep_mem_access->flag = 0;
-		ep_mem_access->reserved = 0;
 		ffa_emad_impdef_value_init(drv_info->version,
 					   ep_mem_access->impdef_val,
 					   args->attrs[idx].impdef_val);
@@ -769,7 +768,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 			constituents = buffer;
 		}
 
-		if ((void *)constituents - buffer > max_fragsize) {
+		if ((void *)constituents + sizeof(*constituents) - buffer > max_fragsize) {
 			pr_err("Memory Region Fragment > Tx Buffer size\n");
 			return -EFAULT;
 		}
@@ -778,7 +777,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		constituents->pg_cnt = args->sg->length / FFA_PAGE_SIZE;
 		constituents->reserved = 0;
 		constituents++;
-		frag_len += sizeof(struct ffa_mem_region_addr_range);
+		frag_len += sizeof(*constituents);
 	} while ((args->sg = sg_next(args->sg)));
 
 	return ffa_transmit_fragment(func_id, addr, buf_sz, frag_len,
-- 
2.55.0.rc0.799.gd6f94ed593-goog

