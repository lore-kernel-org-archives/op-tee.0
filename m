Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63E0CD5BB1
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:21:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 441A944E66
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779808868;
	bh=Lnu2EVY7kGgMFYCr5nzfpDHkYvIQQ8dedbk4JRz62MQ=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=r+DpDM9mRfvhp2xMm2sUX84cF6QyjpWGO8Y0QUMP7Flv1uEwXplR0t8cSwgXYAgru
	 dqbx1Fe/gCcuLRCC8Z/BElRK63sUEaiG8KnHdxYZ/rVMPsLEAHeeD/4DCrS1ifve12
	 +i5bOnyAVT7HDq18oeyB2uHqBQdgrycBATl9S/GwDv5kWS9sl6v+hRj77JCPVT/ZdA
	 m8tVNEs+jgl4iBOL7RZrtik8aoMyBJY+9r2LV0K/rBiIAwlIUw5fG75KnTOnaBc2x2
	 o2ltFMtG4Y5B/mSfxe9tMZA189ycQzrBgKJc5N2KVF8HYBzM7mDsRNZpZFt3cq3VBO
	 QxixHyxYbsUIQ==
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1B44844D9E
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 15:19:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vVH9xmAv;
	dkim-atps=neutral
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-49045243094so62019585e9.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779808789; x=1780413589; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUC6GCpgb9EEQ0qn5/HP42C7vK2niyP/8gA1+StmENE=;
        b=vVH9xmAvo6LfSjoHb68MUtrRVFOkO++rfCtyphDxIhz4+HIraoiYT0DpJOGM9SA+/l
         pBbHIOjZrXGk7kZkZGbYNIqeIqKa1pAIQdtZsmZQ9BToO7/1yb4ofAz/M6intBvgZWi+
         /nzE58eNfnjlOYrHYDl7Mr1U6pYoVGv+IW+mbsvWgT9E885vpCxxPkU4ip5MqkoYCbqb
         3VvyxjUmCToEa/DGEsYO4PgcF46WydOk/I9nfD4hMKRI0ahrJ+bp1qCdZj8p51KomNLu
         e6DNtJgholf6cag8PQjDhefRSvUybLLDbdrcDF2WQDh20xVh5wS/k35IdrJl2XXGSFFh
         vRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808789; x=1780413589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUC6GCpgb9EEQ0qn5/HP42C7vK2niyP/8gA1+StmENE=;
        b=bCDXzlwj15GD3sJsUtnuMyuDzukR5eOyRtU8u8XkDN/xLmYaVY+AS+u4mknTk0X0ol
         4T7BQrYdVFDQNA/kut3dbcgcPIQP3kf+MkE2dDOtgI1/KhxF+oEU9Kjlo2MIOZoFRTum
         AVH1DdaoCCfi4Q2GC+ZmSpyKdJZQl9TCFpWd0HNSdoBJB8eiPth+4/gcFVQBhM7YystO
         TVVR/MD++4jIB8dC9ZptTOgVr7C6OeuARDLRfsvnZFwCA9UvpYwmuopcr0PnUBdK+tHP
         vqbF3wacINpAhiRciNtQQOOtqfMWeHEz5G6D7X5k8t8GxWnsSKdE1ptpIEoHcjV+UA4Y
         CNvQ==
X-Gm-Message-State: AOJu0YwnLVwukHWyJG+ieyzyb1IAwTu8mkXRMTukJvm6uMiptIjCnR3T
	c3iyblxHBi10u13t15RWEglCp93XWiQFSB6mO9OdElJueJiTQiOlKLZnoj1QcZykPvEnlD8VN0w
	4hNXaNcSLd/YMmsbeeR4MioO5+BH+vYaNzqYgYptr3nw2tU63U9Ero5SlCjBJoa/kEyn3DSA/zB
	RLL3mmQNQjq6BMSQrUq+Uz0XJ8WANFMsq1ytvCI7yqexyu0UK2+6Qvg4yYvyR7
X-Received: from wmgb20.prod.google.com ([2002:a05:600c:1514:b0:48f:de5b:469b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3488:b0:490:6869:7d8b with SMTP id 5b1f17b1804b1-49068697e08mr140072435e9.15.1779808788818;
 Tue, 26 May 2026 08:19:48 -0700 (PDT)
Date: Tue, 26 May 2026 15:19:31 +0000
In-Reply-To: <20260526151934.3783707-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260526151934.3783707-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526151934.3783707-4-smostafa@google.com>
Subject: [PATCH v5 3/6] firmware: arm_ffa: Fix Endpoint Memory Access
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
	FORGED_SENDER(0.30)[smostafa@google.com,3flovaggkbjclfhlmtytzhhzex.vhfhi-mxxeblml.mknlmxwybkfptkx.hkz@flex--smostafa.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.833];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.73:from];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3flovaggkbjclfhlmtytzhhzex.vhfhi-mxxeblml.mknlmxwybkfptkx.hkz@flex--smostafa.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.73:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1B44844D9E
X-Spamd-Bar: --
Message-ID-Hash: SLKRL2DYCMD3J5PDSCTMHWEXI3QRZPVC
X-Message-ID-Hash: SLKRL2DYCMD3J5PDSCTMHWEXI3QRZPVC
X-MailFrom: 3FLoVaggKBjclfhlmTYTZhhZeX.Vhfhi-mXXeblml.mknlmXWYbkfpTkX.hkZ@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SLKRL2DYCMD3J5PDSCTMHWEXI3QRZPVC/>
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
[@Mostafa Harden error checking]

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/firmware/arm_ffa/driver.c | 16 +++++++++++-----
 include/linux/arm_ffa.h           |  2 +-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 059e2aae7ca0..bed4bd48963f 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -703,19 +703,26 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
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
@@ -725,7 +732,6 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
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
2.54.0.746.g67dd491aae-goog

