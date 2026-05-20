Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB81CD4F3D
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:51:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A505C44DE9
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779310282;
	bh=yEi7Y+sVV03MbE//ByLa4jBWlRzkala7BxfSNn0p1q4=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=pqCXczFONZ/RYtxwBMhc+AQpaohX7d7CuLDyW0/S8osFrRWe+PVmXu0RUW9/W2n1V
	 4Wnd79GKib0Gt6YyZ5fQHC5h/KaXIKtKb5cplUA9d0Isf5iHUCyzRx8DPM3P0G3Q/C
	 UxutURlAQebGdgm6CRn5Rw34Q7/YXcJPYjEfn/bWWypcrcsJfrOMZJrgw6YUGVle3s
	 C2474lqCyU+0GspKNwnaahheTBLcVTJAV6AspQHqVWC6qdfmkE6WD2BQ4y6XkEeVXH
	 G9UwIZSWTPbLARQHER/1iM1zyu9wjF0Hqus+pXyR1zVmFfNajohpKZ6/baZE3z1E7P
	 aj3oIsgN007Ew==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3460E44E79
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 20:49:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vZqalxaq;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so19272355e9.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779310196; x=1779914996; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6pS+fRCyL3l4ecLcUFyDog+3129i4iHhu9NlGGm/nY=;
        b=vZqalxaqqgXuLa/XwzYeBQ3SPtvalVHIjsD8ChW5jMn+fVfNd4pVNGNJahT44xrcpd
         czt5FuH1IPlQ1LwhGA9gWngndk+Ws7IEmJ1l3N29xyswC536EQVYoobTcb52rI2LdGOI
         +dEQXcKJuCamURUUCcP+XgDObPutrCdsFpC3cDDqMrFPRKY3ExBq1Rw11qUma5tVOdfH
         96+9J2xVgFB06sTY2TohpBoEGmRcZGI/pMYf+3HixmrNUC6r8w2WtqHGRAxVG/pmJxiG
         2r5N/oWZgbbA6HdNXiGgpVLas08X+5MZx3KOZOnjNduhPLqeSCMiiU1mImvl48sHlYLc
         uy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310196; x=1779914996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6pS+fRCyL3l4ecLcUFyDog+3129i4iHhu9NlGGm/nY=;
        b=BXkzeBQ9KZ7zAokM6DJVY3EVYOrdYxw3mSM4OjW2FvkMeWNySrYC2Gz15TaEQaYi6p
         SywWsjWO2W/ba2f2YDafBeD6Hlpkj/SaoCuVZeZYcnvP/8cPJDJeTgLrOwv1EigS5r+9
         xFgfBXmGTF8/Y8/moYPTzDQ1Ft/xcEpP07TRapwVkJUpGZAbF5deo0a06pGmflRp6vQy
         VUpRflVlRcomkF91s9yKwUe6ttWIrvxBBD0+pgYVrLufSSBB5KhQNAqO0VWImH1QKh80
         BmnGio3nuRzKhje0/qDAVToJRDvqnxvaao27H2zZtE6c/mG+x3kEpln9uj5IcBn207m3
         kHwg==
X-Gm-Message-State: AOJu0YxqYe7xKMMkA4sMVjLET279O9nr91y7ONx10NxbOVREa8WrJjiT
	jvp1opN4pHmIQVRiXorEErf8OAaP85nW2UbVMI5HtgfNANzi3nwgIzw6cQpxFtsNl16fAPQE0js
	7a/Wo6mwgLITgIYjtuWz0xD1V+DJZktHANAhPZKSeyaEH7zbCJS8pbbPPJ/IIjVD5rCcv3Fl/I8
	/ngPm/bNFoox/L1lW2oAdIU39YOPNRz2K3iREU5sscS+c+fflUHRrHP8IbakVP
X-Received: from wmfo22.prod.google.com ([2002:a05:600c:2e16:b0:489:d74d:f20])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c08b:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-49035f37f95mr624375e9.7.1779310196037;
 Wed, 20 May 2026 13:49:56 -0700 (PDT)
Date: Wed, 20 May 2026 20:49:46 +0000
In-Reply-To: <20260520204948.2440882-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260520204948.2440882-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520204948.2440882-4-smostafa@google.com>
Subject: [PATCH v4 3/5] firmware: arm_ffa: Fix Endpoint Memory Access
 Descriptor offset calculation
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3db4oaggkbkevprvwdidjrrjoh.frprs-whholvwv.wuxvwhgilupzduh.ruj@flex--smostafa.bounces.google.com];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3db4oaggkbkevprvwdidjrrjoh.frprs-whholvwv.wuxvwhgilupzduh.ruj@flex--smostafa.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3460E44E79
X-Spamd-Bar: --
Message-ID-Hash: U46OHS632RKLF26JE7RZ7HZUYUH73KNL
X-Message-ID-Hash: U46OHS632RKLF26JE7RZ7HZUYUH73KNL
X-MailFrom: 3dB4OaggKBkEvprvwdidjrrjoh.frprs-whholvwv.wuxvwhgilupzduh.ruj@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U46OHS632RKLF26JE7RZ7HZUYUH73KNL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

From: Sebastian Ene <sebastianene@google.com>

Use the descriptor's `ep_mem_offset` to calculate the start of the endpoint
memory access array and to comply with the FF-A spec instead of defaulting
to `sizeof(struct ffa_mem_region)`.
This requires moving `ffa_mem_region_additional_setup()` earlier in the setup
flow.
Also, add sanity checks to ensure the calculated descriptor offsets do not
exceed `max_fragsize`.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/firmware/arm_ffa/driver.c | 16 +++++++++++-----
 include/linux/arm_ffa.h           |  2 +-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b700b2e93e72..8573a7a6556e 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -685,19 +685,26 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	struct ffa_composite_mem_region *composite;
 	struct ffa_mem_region_addr_range *constituents;
 	struct ffa_mem_region_attributes *ep_mem_access;
-	u32 idx, frag_len, length, buf_sz = 0, num_entries = sg_nents(args->sg);
+	u32 idx, frag_len, length, buf_sz = 0, num_entries = sg_nents(args->sg), ep_offset;
+	u32 emad_size = ffa_emad_size_get(drv_info->version);
 
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
+		if (ep_offset + emad_size > max_fragsize)
+			return -ENXIO;
+		ep_mem_access = buffer + ep_offset;
+		memset(ep_mem_access, 0, emad_size);
 		ep_mem_access->receiver = args->attrs[idx].receiver;
 		ep_mem_access->attrs = args->attrs[idx].attrs;
 		ep_mem_access->composite_off = composite_offset;
@@ -707,7 +714,6 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	}
 	mem_region->handle = 0;
 	mem_region->ep_count = args->nattrs;
-	ffa_mem_region_additional_setup(drv_info->version, mem_region);
 
 	composite = buffer + composite_offset;
 	composite->total_pg_cnt = ffa_get_num_pages_sg(args->sg);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 81e603839c4a..62d67dae8b70 100644
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
2.54.0.669.g59709faab0-goog

