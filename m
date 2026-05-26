Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8758FCD5BB1
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:20:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D320E44DAD
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779808842;
	bh=EdC0W0VohOtxX3lnJG6sv4pnvdbySAnfsJeVaWHFx0w=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=nzyp6EGrYk4FLF5jYknqC7K5h4RgUW27+3FCdM8ymrAJzN4mtu75tvsoBB6X5VzJQ
	 0FGWlzLNUAmXxMQ166n4F3eiDuZJRhFtWbKaq9nB2Ch6/FViu7ZcuFQ8PSUDUy+S4F
	 G1j4ZowBxgqTEPna7GkjhVS4jVUfD/bXzoULyKrojAd+gCZ2BErSps+qJMWyBjaQqq
	 5JGYXs8U5sbAZVTmkpUVymzg5Fw0kUE1x4Q8y8XvHvjUbzJvKiGp76Kb6oGeO4Yveh
	 pwAnmESx86E6g9Yq6N+GaVkNaert0KroM3zGSskESxaVC/FwKXdsFu8CM2NskiyOXn
	 BCcARbijs+b+g==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B3C8E44AE9
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 15:19:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pSI2Bx8w;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49050c44bcdso42792115e9.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779808788; x=1780413588; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iM960fEPaAF4GKD2H7L6vb8i4u8uWo0JTw5z3e0opLs=;
        b=pSI2Bx8wlDrHjARkV1YVk7seDAXtBkLAf6nICnXC1CZs+uwhBdP9SXpaN3C+HrUxS7
         2/BHlRPBy/qbkS4gW09bN8GxybZ4dr+KK56TUYCoE6TlFdFRY7vbge00RK8Xb+V8M/K7
         y/iKNEZYge9J7JUcTGfzYs8OuvEVu/w3AYH3Ur9rHf6nMq3lLoN1pH3RpB5Xfh8p6vU8
         BL28abhCuAQu2VvT1ko+5A+JeDiQYMO9eLl9311kquQ6kvgPlg5enNIqnyqhQKcJYm1f
         +Mw7z4rkCHbEUZ+wTpyDY/9PHkA1ZSs/qZCfwvz8rd+5j5URsmrLyvi6BVFLYrFFRa0z
         8H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808788; x=1780413588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iM960fEPaAF4GKD2H7L6vb8i4u8uWo0JTw5z3e0opLs=;
        b=iEANauDNTb7j+yQGAFvZ843yT1w7x03jgDncf1SX7YuPYyAZJwZmXwaMh0nqJRw6Jz
         fXwyC/1qFncnmke5N9iJ1Se0VAk8ids9x3ezCwk7yPAa8zF1rsmh+BOn3mCXqUm9ecDz
         KkA97tRlKgc9iBMzdIQrpSvKO8AKOcHnAt+qgACYhgBxlc9x9WJ77WHzBz1HDl6AEaQx
         clR3HZ3Gi7y2nA3Sq/Fhei1mUNoURzDlsHJEl+gAYb86sMmiOsERXk5K4+F30DolBT9o
         BsPQhg99K0p8ZhKijDuW6nXhs6BSGmmTR+W8I7d1QUf9qikft5isVq5WlXVSmu7JHFgV
         zWcw==
X-Gm-Message-State: AOJu0YzmFVWheUdMqAKz4qYLq9WCHZxzudINcoYKS6xjdWLrrtoj3Mi8
	zkKutiXgT4lUJknhon0R6u+OxS9NOiLPCeCXqqjrr2SOhzG99+pcScCgOq4DmC3NTngv0QeVWRY
	ZVf8HMMiqp0mlC0soWc/eJqZKyrhDMxrl/wImv8Fu94iflmljcmOTaD+efdB+QZXet5Ymvy8JM3
	FeoD7GR8BBtkVsFE25wquK3DsA/GI96+ucUz0r/EAQc+bBW23VYlrhpDP3m2xm
X-Received: from wmni10.prod.google.com ([2002:a05:600c:70a:b0:48a:5334:11e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c8:b0:490:601f:d783 with SMTP id 5b1f17b1804b1-490601fd8f3mr182526495e9.4.1779808787137;
 Tue, 26 May 2026 08:19:47 -0700 (PDT)
Date: Tue, 26 May 2026 15:19:30 +0000
In-Reply-To: <20260526151934.3783707-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260526151934.3783707-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526151934.3783707-3-smostafa@google.com>
Subject: [PATCH v5 2/6] firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3e7ovaggkbjykegklsxsyggydw.ugegh-lwwdaklk.ljmklwvxajeosjw.gjy@flex--smostafa.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.830];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3e7ovaggkbjykegklsxsyggydw.ugegh-lwwdaklk.ljmklwvxajeosjw.gjy@flex--smostafa.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B3C8E44AE9
X-Spamd-Bar: --
Message-ID-Hash: MVZJQQSYETOWBNV3R7FNXTFU6JA4SSO3
X-Message-ID-Hash: MVZJQQSYETOWBNV3R7FNXTFU6JA4SSO3
X-MailFrom: 3E7oVaggKBjYkegklSXSYggYdW.Ugegh-lWWdaklk.ljmklWVXajeoSjW.gjY@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MVZJQQSYETOWBNV3R7FNXTFU6JA4SSO3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

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
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/firmware/arm_ffa/driver.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b9f17fda7243..059e2aae7ca0 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -715,11 +715,10 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
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
@@ -759,7 +758,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 			constituents = buffer;
 		}
 
-		if ((void *)constituents - buffer > max_fragsize) {
+		if ((void *)constituents + sizeof(*constituents) - buffer > max_fragsize) {
 			pr_err("Memory Region Fragment > Tx Buffer size\n");
 			return -EFAULT;
 		}
@@ -768,7 +767,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		constituents->pg_cnt = args->sg->length / FFA_PAGE_SIZE;
 		constituents->reserved = 0;
 		constituents++;
-		frag_len += sizeof(struct ffa_mem_region_addr_range);
+		frag_len += sizeof(*constituents);
 	} while ((args->sg = sg_next(args->sg)));
 
 	return ffa_transmit_fragment(func_id, addr, buf_sz, frag_len,
-- 
2.54.0.746.g67dd491aae-goog

