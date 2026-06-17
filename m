Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D00CD98E2
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:53:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EC42843730
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781707985;
	bh=aN8Nyn9ckrh0MM/LzHi6OOLo2IpLuaUhgYlQz9xxDvk=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Sjli9QrsGVMPfHKlXCb003m9IoiTnTf6ZA5AjguxJ0TRq4kpiPDYr6ZRaSYiqXN1i
	 vJs+Z/jA665OrPInW4gS0feEZnwoEHcaPQTlqY6yXSe/tAz1zwy7JtPOg/HsxPFAtl
	 n/BejyvI2w/p5qRioGErnQ3AEg6IANouMbN3QocqE2F4aMDQsMmW8mVjXTeIU/h5Sm
	 HNOQRVQYffC62B4pUTz9+7q+bOuJzxBu9UL5whPS6T/lgcinKfTj5kGzmjWKqlLI1I
	 qJRKvD5ccCphS78CxohJv7G2WUHXLA41Ah+zMqhHvtxTWo72rU4KqmraseA9yyQMoI
	 c520MajcpLtbQ==
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D95FB44EE0
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 14:51:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ck4fPOiO;
	dkim-atps=neutral
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so4103284f8f.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707905; x=1782312705; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSPN5hE9gskxSS4lEDSt/fOL7Hb/rZVNl7XMRMHJyec=;
        b=Ck4fPOiOSvHaTJFwyfj+uZC3I7YUMNKiuE+Qkhta7oBRsAntttNTPNODHMZr67Mv17
         kSJZYPiAK0+LGCf/yoUzkNQIgbdzbTqs0GDZV+/fVS7FHmSsdZqqMCP0UihVUFKFyB2W
         h4CQB7qIy8gL3CAVwRaV5na/pJSvBdNv6iGQ6p7hD8GwrEmkZuV//fLC4JRMNt2WkOuL
         2v3+INDE1CsGwKKZHNnjM3k6LLnVpjLTAH1mJRFwZBZH70uIygvPnvjDF0ixfITquyll
         JWLYui9+xdGNGtsoR2CuBOMKhZn3nxT+ppgT0pCbAj0na6i4k8EPLdOK00+znywzaEbd
         Kl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707905; x=1782312705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSPN5hE9gskxSS4lEDSt/fOL7Hb/rZVNl7XMRMHJyec=;
        b=Bo0vR0GgYDN6hnQZ1WvBwIwB06MfaqFrNkWxXLTyTaPNG4OLjJ49P/c0ZtTHmWL/gh
         WfrYSVFY63YNDNFP0iAKh+Tayuus1JhXQehyGVn4v84SZwryMaTsdgNrDbNsVaBgmq/w
         OMZXU+F83/Q49DuizwfysIOk8uJc2Plb5afRlfIq6B4qA6gdCgVSuUKdLRuHKhy+0nH3
         yKed5dczE6MBalTaKmoPXtmsWHNdjQ7rjc5WDQnm2n/LqQ/WxtmNOHigC9D75bpsq1ti
         Dubi9A51yjx7UzxbGHR4+10AsAG4OyyfU9wBgsMubnMchZETL6xNS3ACVyuu7C2jZP68
         1miA==
X-Forwarded-Encrypted: i=1; AFNElJ8sZbNq06Bw+ZWeJDVgyNTjTUBZ289DYko3sOU4vpfgguAd7NO1A19VG2G+axULXeUU3LH0v8k=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YymDWBt4+uAfk1iajfGLE7KmwmT0KR77X01IKbJ8pfwX6oSc6XI
	d75C/66ldynq8aOrZ/1krAQoactf2cRtHKrqksVrk38iv+M6acOjz/WDpv0+xNwQ10FEKuX06a9
	DtmGGATvQA04wDZLzbPZ9TCujj+d1rg==
X-Received: from wmbgx24.prod.google.com ([2002:a05:600c:8598:b0:490:b0f1:3417])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f8f:b0:492:3670:85a7 with SMTP id 5b1f17b1804b1-4923677d803mr26521325e9.35.1781707904134;
 Wed, 17 Jun 2026 07:51:44 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:51:26 +0000
In-Reply-To: <20260617145130.3729015-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260617145130.3729015-1-sebastianene@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260617145130.3729015-4-sebastianene@google.com>
Subject: [PATCH v7 3/7] firmware: arm_ffa: Fix Endpoint Memory Access
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3glqyagwkaa05ron56vn0r0rt11tyr.p1z@flex--sebastianene.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3glqyagwkaa05ron56vn0r0rt11tyr.p1z@flex--sebastianene.bounces.google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.221.73:from];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.73:from];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_NONE(0.00)[google.com:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D95FB44EE0
X-Spamd-Bar: /
Message-ID-Hash: B3QUVLRZJRRKUOOLOBPERMQWTKGAPUPI
X-Message-ID-Hash: B3QUVLRZJRRKUOOLOBPERMQWTKGAPUPI
X-MailFrom: 3gLQyagwKAA05ron56vn0r0rt11tyr.p1z@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B3QUVLRZJRRKUOOLOBPERMQWTKGAPUPI/>
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
Signed-off-by: Sebastian Ene <sebastianene@google.com>
Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/firmware/arm_ffa/driver.c | 20 +++++++++++++++-----
 include/linux/arm_ffa.h           |  2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 059e2aae7ca0..92edf397bcd2 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -703,19 +703,30 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
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
@@ -725,7 +736,6 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
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
2.54.0.1136.gdb2ca164c4-goog

