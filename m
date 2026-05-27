Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A038CD5BD5
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:03:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BF892436FD
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779894196;
	bh=nVHQfEBe5Y36t7KgHNwVV7teEKw/67gXK02IHth2zZI=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BEVl/zyZySAbCX2P3cIAyJapRh1t1dPyJhf/tNpvjm+XXy2chPNIPc6dKkL/himsA
	 ptT2F76zGeChbc0Kg77bRLqD3x/fxACP67fA5DyQFjrGsnIu3vJrnX1YOfBZPCTQOb
	 fR5JXbAeq5tRxOoCbWTcnlv46O0JXc7kFRl2RAbvDUNR6/QDYO15ysgcEhjbQIobeR
	 XmmpkhP6ETQIOWQc6qlUFazZi+BUe/gSXU4Dgm3JI11Qg2RuTw38cniGqORNVT1yq7
	 tiJi2nDN4yW5rKnfG0Knt50Vn5KQu8p9k71lB112VY7e5aCtOclRsX2UDVxlnDNFu8
	 3LGTFr1naFLDg==
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7F1EB443EB
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 15:02:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=D0m+2f16;
	dkim-atps=neutral
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fd396daedso65385795e9.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894162; x=1780498962; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uj7BV8+9rgP0MrIxwz4V0ep9E/T0g3B6x2bWAPAPVY=;
        b=D0m+2f16hTYbSKnQGk0xEFDZGcQVfhHYH/CmZdj8To9QgGHL4lZp4DtZbB0OzDBzTy
         UZk1nCHQqBUkCNS5EeMoBc5OTr2pcPM6HAVnm/btVdXaW68FPm4UshvnQQsF0rTbSNpz
         C2qim1txstEtTw9EdoDQJ1cpbBv+5jovbdS7aQvkgxSveKwYcOi+ECtLA8od6QyMNwic
         Xk/yjkpZsJidy3nIjUKLIJdbLMiFeaAg8hdxurLzyHSMCbQMMxDHiZ+CseU9BkUkafgh
         //S99+9rBMdqgULhTnZ/CgelI6NvHAcWa4NJPZHrCGE1pQbHSmE3vLcxSEc9RCWJ4aXC
         YKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894162; x=1780498962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uj7BV8+9rgP0MrIxwz4V0ep9E/T0g3B6x2bWAPAPVY=;
        b=Usx47ZH9x+cc9kGp6EAsA6WFXwY7px+ESvdjhjI9wO68AIntSeIq0g9ycPVchuEXUc
         /G8+Qba5EHnWbziX14oP/3gpJyXfGRsIoE9YoRMiRANO0dvdinL059wTou5L3lGt+KRj
         eRdzFSrN1KswIS1v8AYaJX5FOqwNr023KHZTfwLblxaZ+WS1JQ/i5jHYm/bK51OCQPN6
         CGIk59b4jQdJ/TcFKc+DQRJ5FgDeJWi+haYQqGdbDVRseLUDXPDuz6TF5xZhcEXHXV39
         ZpGr7r0BdZtJBYcRN2Twvbya20i9vxYXQNVk5U9wlaAKlv2g2faGjRpAZLYD9lne1eeV
         qPSQ==
X-Gm-Message-State: AOJu0YxhK5ojM4sFcFml/AXB7Z7n5Jbz6yEr631TK7xk5913uY82xnSK
	HUKEcuE/g1asaoMgacZVH0lZryBT7YIhFJCAkUANiWKx87CrJKRsypjmkvjruZeZW5UsCoe/50I
	fS4c6toJ4gEk7O+pZGXxCNXA7jR2bs5a4bRd0KivnhnnoeQ3hfMmNl1xxLJHphWQY1sIDrAON+u
	utST5Wu+lw+fwiXpEyfRlcWxkvi9wc/Iy3o5GcqmSiJpLv3CwHdYEmcYfYaEff
X-Received: from wmmu10.prod.google.com ([2002:a05:600c:ca:b0:490:5e18:ff1c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8499:20b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-4904248ad4cmr298003375e9.4.1779894162134;
 Wed, 27 May 2026 08:02:42 -0700 (PDT)
Date: Wed, 27 May 2026 15:02:32 +0000
In-Reply-To: <20260527150236.1978655-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260527150236.1978655-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260527150236.1978655-3-smostafa@google.com>
Subject: [PATCH v6 2/6] firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3kgcxaggkbluf9bfgx2x3bb381.zb9bc-g1185fgf.gehfg1025e9jxe1.be3@flex--smostafa.bounces.google.com];
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
	NEURAL_HAM(-0.00)[-0.990];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.73:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3kgcxaggkbluf9bfgx2x3bb381.zb9bc-g1185fgf.gehfg1025e9jxe1.be3@flex--smostafa.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.73:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7F1EB443EB
X-Spamd-Bar: --
Message-ID-Hash: YRHN2OZMPKY33O5HEDYQYYHVNEKHS2TO
X-Message-ID-Hash: YRHN2OZMPKY33O5HEDYQYYHVNEKHS2TO
X-MailFrom: 3kgcXaggKBlUF9BFGx2x3BB381.zB9BC-G1185FGF.GEHFG1025E9JxE1.BE3@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YRHN2OZMPKY33O5HEDYQYYHVNEKHS2TO/>
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
Fixes: 111a833dc5cb ("firmware: arm_ffa: Set reserved/MBZ fields to zero in the memory descriptors")
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

