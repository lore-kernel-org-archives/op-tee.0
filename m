Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226EDC43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:39:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 598A64502A
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782988796;
	bh=9TOnq1jD0pgHaO1v5HJoXAFTZmNdtts5+PujmRUbv1g=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qsj4f/mK9yF9AMjrd43tQvR3WdxAx40gKSruVjpJnNsTWB1YkAlAUL1YA/wnNvDzx
	 uxCDp90ixWwGZOzu6OJSkAzyIaaKlpRnzxN5XZ3BUv/KWQ4gMvTEKWKTghlCRCqk6w
	 A/DielaphkUEiRMACn80sJNhD6Nqh+x56OuJYL7HD0X4KyyihCRsjnBoBrEVq3Mdfi
	 SWYLiA3ge3NRAccitWAUA0LDfBR7IcLMJche+lj5vlSFDln1Gsnt4//ZKFdtm1N5nj
	 fUzjNHwpET4gRvrxw3O45uIzHPOMR97KYGMTJUZnH4itkbkvDJPlUhPYkjek+DME8Z
	 CBXuzhI6NOQ3w==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 868DE44E9C
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 10:39:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jrlejJed;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49244130073so12878745e9.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988744; x=1783593544; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMc7IH1jEIo7aTQO6+OKWeTUOGgdg0YUEMVyYCucVMQ=;
        b=jrlejJedyJ+xKRaTttzUXFf8vnQRQMyvUyVP8tf/7runM2Y17G3rzDPpmH7AJxAKzg
         j1z2VcPGvTn1kmmH/VTgV6GdGoTEAvFdhaI0LO7qeLdhYBELvyqcbFEox7+JZwf8sCkj
         p4ILcUno2SHP5NcAtcqeMEqZuLOCqdJfaBNkyJ/DJo25/ortuJ0gexqY/E9C3X8LSwe+
         jp72aAoSWyTMrnZXXqTjsUasmzPyfp3VF7l9f5zXFdfFdhp8KygeryyAEYpUtId11GGU
         +sTNmT5wicTz4InRNVEfTKdBDCSgUDU+aexl9Afql282QUjvMURAo518iHpgiRf+/x9A
         4OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988744; x=1783593544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMc7IH1jEIo7aTQO6+OKWeTUOGgdg0YUEMVyYCucVMQ=;
        b=b6LDGbGBJI+xmHXdPKkOgRR61+itkiDGxNtxXDaUZINXpHJMlUafSoICmrR2B4uyON
         TTpw8VU9u9mKmmYWBRIgeC/6FzbavaIsfIqXLUIsCTok9bGgINVk4h+3LbZuTTbM/lPe
         i4QQ7LPSVM8iMslN6TiOb0L7IHc6m+v6c5m/cTIPYt9/5Pzq0mgAzT1NQgx4lgL8RR35
         L8O/SlHJo8jJd6g/XtjRHg2QzcgVkk/lWCl7gL9mOmdsv0G12ylIdWKc2oR57qbQM6m/
         hSHnzsUqPL6Q3+f80lJ+bA6QhpS+pVrinU/9ItrksG9Kve7twWMA3G2sUO24UcT1//69
         ntfA==
X-Forwarded-Encrypted: i=1; AFNElJ+VqQknJqLH7B+k2SG7nykyUt/i7CJO5s6dq0TOBlVhNXGJ8RWKfqwnwafAWljotfa83/VpGSw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzfDtDVLr9+wBd5wAPh0HM0xtjhC95C+/9miNcDXVVuygUokQmn
	pBV0UN6NB/4zo4ZiuzOfMDljXx+QhJl+wPpnCQVZDThaMNuY5zxMx2dLv0EGPCuNn9ATVkpOwu5
	sKe1YkOgSo1Rec0BRfomb2S8wl7pUFQ==
X-Received: from wmbf13.prod.google.com ([2002:a05:600c:594d:b0:493:b636:4ee9])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5010:b0:493:c453:600f with SMTP id 5b1f17b1804b1-493c453616emr44043235e9.6.1782988744277;
 Thu, 02 Jul 2026 03:39:04 -0700 (PDT)
Date: Thu,  2 Jul 2026 10:38:39 +0000
In-Reply-To: <20260702103848.1647249-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260702103848.1647249-1-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702103848.1647249-3-sebastianene@google.com>
Subject: [PATCH v9 2/6] firmware: arm_ffa: Fix Endpoint Memory Access
 Descriptor offset calculation
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3yd9gagwkalkrdazrshzmdmdfnnfkd.bnl@flex--sebastianene.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3yd9gagwkalkrdazrshzmdmdfnnfkd.bnl@flex--sebastianene.bounces.google.com];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.128.74:from];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[21]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 868DE44E9C
X-Spamd-Bar: /
Message-ID-Hash: HAKP53O4T7NFMMG762645F7R5LVT3EVQ
X-Message-ID-Hash: HAKP53O4T7NFMMG762645F7R5LVT3EVQ
X-MailFrom: 3yD9GagwKALkrdaZrshZmdmdfnnfkd.bnl@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HAKP53O4T7NFMMG762645F7R5LVT3EVQ/>
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

