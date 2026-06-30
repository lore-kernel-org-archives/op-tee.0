Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941CBC43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:22:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DDE2A44973
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782814941;
	bh=9TOnq1jD0pgHaO1v5HJoXAFTZmNdtts5+PujmRUbv1g=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=e5qFkva2W0qROyOOpcXg8UzO45CHZ+9hPnh2tQ+yRFwuhPnxotsrffSXOgume7801
	 F59lrWbpfgPedKJbkL25PFZJ+4iV+m7MeaRaEHjIWyeKZpgcer+rIBNaWKE2evA8AJ
	 5/xvm7ihOXZGMt2l9s2lTvGmBhpkpIqF3OBIMjCWGarAMKe31Hf5hE+2R3ikBSZInH
	 Nfk3WyCrgZL0ocDN+fHuLjVlsa4A3nIcvtTY8DF3bs8zWwhjI85l5o0gvkCojqWlLC
	 EI8vL+4URbTX5fWt+qkUipz1h6JBGDH4xfr03ZUTSamxOgMuK2b+FmgvqdtAucWI7C
	 WwUPfljGDnXaQ==
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BF14E44973
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 10:21:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ff4fJP6v;
	dkim-atps=neutral
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-39b1937b6d6so4759541fa.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 03:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782814883; x=1783419683; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMc7IH1jEIo7aTQO6+OKWeTUOGgdg0YUEMVyYCucVMQ=;
        b=Ff4fJP6vm6Kw+e/1CqnIXvOeJu/knO34xq3kFb2USM9sMFBRiJUh44gz6p6kKYWaPA
         VTYlHn4APblCY/pfKbzpmMyLWlxPcoN0CW7viFKM67ACVp1VEdPq9HlUzTEhhHo1EI+H
         knIpNprSbWgI2NYC8ZgLTz4osx4J7BdxfbxLOMdDitYLHkXBlCIqSouMj8f3OqMFJAl3
         7MYM8TvDyvIHrAIUSXuRj+zH2kvCXIB4OMfHgk70QnD6nLpC7PCw/g5Px7ZRW6sh/jCf
         6c6n0ClQ3TcJzrKywWxK5aKCB9NI7CnUEjxXOseeg5CjkLxQ/KCeo4UuJjaAPVtNpPzF
         soLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814883; x=1783419683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMc7IH1jEIo7aTQO6+OKWeTUOGgdg0YUEMVyYCucVMQ=;
        b=EfRi/vAM/cVeWmXXBOj7vUpKqwR0nhEGzR/GK50leW2GVpmcf1GKXeUigw8EcVjQRE
         f4/Y6Up9/pl16AMRI0F0WpvM+9Ef2+xyCDT/n9hltGbHl3P2WIhZQekj0fQgnIHBFDCV
         Lwmx/b5rwwhHnbZAv2hDsocxk5pk0+ThYcA9ZDKBUwNG41s7T3+cr75s5cwe+mX22ooF
         ZZlqdpU8zTzfKCQbAms6EaNi+4hCFwKwm5ic050V84Pi71WuoZs9mlmjIjzcn/KRmkrC
         meTRe3FlsnurgcdviP1E+fLIZmKdTHXNENpFAjMQWVoS0u5UKaFj7eq3Mmf2XDihZp/H
         4vsA==
X-Forwarded-Encrypted: i=1; AHgh+Rohrx4TeRC6QIh/k5a087pDQrVwsCVkFC3gXbIf67iCZxsPF132VUWBt/BUZL5z0ew4w8dOGKQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwDNQz1wWmtuvvUiG2OZc1/c/4UOvuNtQzvnxakPdhp08+BxEur
	lyqOrKZfsgDixca6HuniqIsTJaZIRdtko98TCvCvVWlL/SXrB6jYsOq2uHlLQzX1O42A4lqKFpl
	DjuUbC4LhjBLUaVHQgcvDprwR9vwThw==
X-Received: from ljvg16-n1.prod.google.com ([2002:a05:651c:2550:10b0:39b:23be:9b9d])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:651c:1603:b0:39b:f64:1af3 with SMTP id 38308e7fff4ca-39b28d2233fmr386661fa.8.1782814882959;
 Tue, 30 Jun 2026 03:21:22 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:20:55 +0000
In-Reply-To: <20260630102058.3219867-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20260630102058.3219867-2-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630102058.3219867-4-sebastianene@google.com>
Subject: [PATCH v8 2/6] firmware: arm_ffa: Fix Endpoint Memory Access
 Descriptor offset calculation
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3ophdagwkadspbyxpqfxkbkbdlldib.zlj@flex--sebastianene.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3ophdagwkadspbyxpqfxkbkbdlldib.zlj@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.201:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BF14E44973
X-Spamd-Bar: /
Message-ID-Hash: IWMA6S5OCG7VSEVLJFKZLAVJQZDDRWGX
X-Message-ID-Hash: IWMA6S5OCG7VSEVLJFKZLAVJQZDDRWGX
X-MailFrom: 3ophDagwKADspbYXpqfXkbkbdlldib.Zlj@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IWMA6S5OCG7VSEVLJFKZLAVJQZDDRWGX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

Use the descriptor's `ep_mem_offset` to calculate the start of the endpoint
memory access array and to comply with the FF-A spec instead of defaulting
to `sizeof(struct ffa_mem_region)`.
This requires moving `ffa_mem_region_additional_setup()` earlier in the setup
flow.
Also, add sanity checks to ensure the calculated descriptor offsets do not
exceed `max_fragsize`.

Fixes: 113580530ee7 ("firmware: arm_ffa: Update memory descriptor to support v1.1 format")
Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/firmware/arm_ffa/driver.c | 20 +++++++++++++++-----
 include/linux/arm_ffa.h           |  2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 01301213896a..7c1b747797b4 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -713,19 +713,30 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	struct ffa_composite_mem_region *composite;
 	struct ffa_mem_region_addr_range *constituents;
 	struct ffa_mem_region_attributes *ep_mem_access;
-	u32 idx, frag_len, length, buf_sz = 0, num_entries = sg_nents(args->sg);
+	u32 idx, frag_len, length, buf_sz = 0, num_entries = sg_nents(args->sg), ep_offset;
+	u32 emad_end, emad_size = ffa_emad_size_get(drv_info->version);
 
 	mem_region->tag = args->tag;
 	mem_region->flags = args->flags;
 	mem_region->sender_id = drv_info->vm_id;
 	mem_region->attributes = ffa_memory_attributes_get(func_id);
+
+	ffa_mem_region_additional_setup(drv_info->version, mem_region);
 	composite_offset = ffa_mem_desc_offset(buffer, args->nattrs,
 					       drv_info->version);
+	if (composite_offset + sizeof(*composite) > max_fragsize)
+		return -ENXIO;
 
 	for (idx = 0; idx < args->nattrs; idx++) {
-		ep_mem_access = buffer +
-			ffa_mem_desc_offset(buffer, idx, drv_info->version);
-		memset(ep_mem_access, 0, ffa_emad_size_get(drv_info->version));
+		ep_offset = ffa_mem_desc_offset(buffer, idx, drv_info->version);
+		if (check_add_overflow(ep_offset, emad_size, &emad_end))
+			return -ENXIO;
+
+		if (emad_end > max_fragsize)
+			return -ENXIO;
+
+		ep_mem_access = buffer + ep_offset;
+		memset(ep_mem_access, 0, emad_size);
 		ep_mem_access->receiver = args->attrs[idx].receiver;
 		ep_mem_access->attrs = args->attrs[idx].attrs;
 		ep_mem_access->composite_off = composite_offset;
@@ -735,7 +746,6 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	}
 	mem_region->handle = 0;
 	mem_region->ep_count = args->nattrs;
-	ffa_mem_region_additional_setup(drv_info->version, mem_region);
 
 	composite = buffer + composite_offset;
 	composite->total_pg_cnt = ffa_get_num_pages_sg(args->sg);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 17eca3dfc59e..033c630b271b 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -445,7 +445,7 @@ ffa_mem_desc_offset(struct ffa_mem_region *buf, int count, u32 ffa_version)
 	if (!FFA_MEM_REGION_HAS_EP_MEM_OFFSET(ffa_version))
 		offset += offsetof(struct ffa_mem_region, ep_mem_offset);
 	else
-		offset += sizeof(struct ffa_mem_region);
+		offset += buf->ep_mem_offset;
 
 	return offset;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

