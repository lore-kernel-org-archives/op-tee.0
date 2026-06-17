Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D677CD98E4
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:52:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E64D244E1E
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781707959;
	bh=jloxISYPa8ecyFqGXdFDjWOsBC/fPOUeJSLTxLHPu20=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gPpYKPczNEiBY4HdXMxK07byGol+VsFRriokeHw2xAxSCxg5UQossA8s5euzdDPqj
	 vLpm/Slv2fHCOIyc7jkrDXvOke+uZq+90LR2rcehjw1ZDjX8f2i/XJPl40Jp+MKXQo
	 Mw4/9ewt1+zUJymzO5hcLSTXXr5qHNHFxy4xhPzMrRBvVmIWIpQULlP8l2fySCZbmQ
	 45oRtkWeaIj3yC0wwKHQw7pgRDbjtxiVmbUBym9oInXoCA8LlsQellUOtKlAJfnDPx
	 xTqecDWDwpuFe5vlxqwJSE2VMMS5n8EfsKAZoof0zHkojbkX4yxt5t6b4HF+HO37fW
	 Ej8oAOp6rv/Sw==
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CED4C44EF7
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 14:51:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=isxVM+zO;
	dkim-atps=neutral
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bed2f39a2ccso454146166b.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707902; x=1782312702; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fif2f/B/gn5RkPcFE+VYhypuB1774zSDWaedB+gVp/0=;
        b=isxVM+zOv+O4RQyaqE6dMNWEfZqWDjqzgBnsX2aW/0QvP9nQbO4EWrc/IwnVB6/xui
         ugsMSU8Q/PTgxsNuHcXEKEmZQxqLEYXT7sqvscRQkE6n/gzu4NNT8fSNjRjprnN+CTIl
         t81cacs5hDadtuAHh8fQX7l6vpKKeQNOuciBFU/eSywEyr37j+bibj3uY15LH5ejWxzj
         Z2f4xdj+oFzeg60qR+vClaJHZQjnqulEBfJtafJrsoHGiG27UeLqdCWKRS+Fq4Z9+Kgt
         0chD9aV7jCvfBr1nKh/d/843L/vz5s+1lZm2kZ4fnZ8YloyAdYyw+e+BlxOg/0XKZxKG
         6kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707902; x=1782312702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fif2f/B/gn5RkPcFE+VYhypuB1774zSDWaedB+gVp/0=;
        b=KYzccHHod5Nm0HXuPs3XIFJ3kRpBMxH+LZR4qaA5Wr6S+XXAqQlyfuTYdpyGfrUzRI
         bcnNYpW6rxoeSCq/J16ve8LGo3apw+UWuYxoZXL/jNKbZaqJZoLAaGISWEz7tX9PMEg2
         NGYe7AXurixtRZIYYEesnx760qxdjjWVAGuiX6vBaR+QPtjaPNdfM5vAYIz9pTPDHPBt
         DyO4cYzLw1ZsAEZ1lw3ClXL7Pjm9IAPY5La/isSFfJRI8zQ/5mt5jdADOf7ggMqsTAs0
         LAM4XE8lvXbYEwgaYJbv9Ad6hJayOMHqfFXhPyNwXGmorlcWiF8P8Jaff5JO4hVy7QUT
         MTYA==
X-Forwarded-Encrypted: i=1; AFNElJ9kc2rNNuDE1cUrtXdL5rktLnDR6JKWZHmkJUTtWcNfwFK63VGR33vbSVNUGkoT+K+6nEDxzhA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyC7NfT7lXiMQ2WavFVOOzdSlH1ct1lZ0QlrZWw0IQXqikTrT8r
	haAge1TEe8/3zmcpccgGupfZBnTbTSED9z9hA2Ijt24zc4Gmafi513qOtnU9BgW0jbZFZ+pwkXW
	gjx/DpyD7oCP/rlj/2cFGhlTcxyvGzA==
X-Received: from ejbw3.prod.google.com ([2002:a17:906:1303:b0:b9d:975a:28a8])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:209a:b0:bee:ec3b:6a93 with SMTP id a640c23a62f3a-c05d2182e75mr113081366b.2.1781707901976;
 Wed, 17 Jun 2026 07:51:41 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:51:25 +0000
In-Reply-To: <20260617145130.3729015-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260617145130.3729015-1-sebastianene@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260617145130.3729015-3-sebastianene@google.com>
Subject: [PATCH v7 2/7] firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,3fbqyagwkaao2olk23skxoxoqyyqvo.myw@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.73:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3fbqyagwkaao2olk23skxoxoqyyqvo.myw@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.73:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CED4C44EF7
X-Spamd-Bar: /
Message-ID-Hash: 6W6DMOZ7G3YJDHFRN5NBK3JHGA52WF4F
X-Message-ID-Hash: 6W6DMOZ7G3YJDHFRN5NBK3JHGA52WF4F
X-MailFrom: 3fbQyagwKAAo2olk23skxoxoqyyqvo.myw@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6W6DMOZ7G3YJDHFRN5NBK3JHGA52WF4F/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

From: Mostafa Saleh <smostafa@google.com>

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
2.54.0.1136.gdb2ca164c4-goog

