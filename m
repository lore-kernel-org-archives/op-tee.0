Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BC9CD5BD0
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:04:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E2B6E44E2F
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779894250;
	bh=frvPG4wGt4lYWaI0hU8auAfAfo8N17uXOLvBwGNEh+o=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=nO/IIMBysJHTHfB1kPdaH03641VS6oDupWoJ0mqUr2Jv3WnLhK4HA237aIslbvVAs
	 JLtvdL49SlWDMNozIALceVRas3zGF+VG6HoFWW0q2SYDkBMSBHgRhXq8vZD+/rUo+t
	 JDCEGyewojdzs9G4nWADaYdMOqcxhk33GTjdcKiQWPGdXry64rtIYMiVDqsB//RzuJ
	 VdF9U5bS8woe7DPfx75x01ukrBGWJZ6/zZCpEekmPcvE9OFb5FObdeZxYo2zaFi4+Y
	 aTY8a2WatFIgcTlZj/JkkLWGk4aueZdjPM12iTaHoaP7UOhGRnMm+6NNw+eMhQnCmz
	 RLKUSm4/t58og==
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EB7414380A
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 15:02:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Jxl+WZ0d;
	dkim-atps=neutral
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so39939045e9.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894164; x=1780498964; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8YigvBWVl26/ICnVgR3tTUB4GzAA0/sj9E2gFe9QwE=;
        b=Jxl+WZ0dRPmtQZ399HCuvA6afhnqxdJ65FbVXQfwpQgA+E7rc9z3W2o00HDtGZ4bcu
         /yNLVnk8ehE0HYL6j/njekzcKz86i/fjLr5rM93KztpKXfWCcdiqFu7mHGprUD5MO1VX
         rCdTgLUxVrtVj2FxC4w+iqFtucrNg0hgEQB+EZRacxzUoiTRMTxKYeQPSV78BWJdZ9bi
         DzdgfW/MXccjbcTUsMUNjQ6x2uuKxE66DRnyIznw+oBSQ2j7kPG1eY7cQMkWBLZoV2NH
         pRQnNXxcOlc/knR7LqMn0EUJvn2bLunwTgSh4l+h8pO+kc/8mJpdDp5PBDp2Tv/dUyHQ
         OJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894164; x=1780498964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8YigvBWVl26/ICnVgR3tTUB4GzAA0/sj9E2gFe9QwE=;
        b=Ij6S+o09Sz4kaLt61EhdCQA2HT5MTmoD2J7lE5SRQDDCILNAKiFvtCWpvTW5wUGHjF
         MqleMhaixXa51HvtWw/lir5TwAifSwH3onVB1uP5rPUCvv8S7i6ksZio758xtzUg56Kn
         4BbTepMZhcq0xAnZ2WkRGxLvvpJCQr4Ox5YXj4uO0TuvrPu7/sMkFhq2R9jIAW+NdpOp
         Mljeo18t3//ctKQe0lYz2aOTeIFjRVodhURJecktTB2A2+qfN0dypU11dC2Ekkr9W6Ek
         gRahyGLTCO0VokZS+jVkdNyji6+ljHD5jFrf/7tDMviNl/Gu6728HASoO3JmpE9VZ3qk
         MeMQ==
X-Gm-Message-State: AOJu0YyxT9kAyuSmlp2gBN5jvAaCSjSvCUfc/+wIBTmANKgff1iCSUvH
	u0VJEBJC8SRaewu06ooZVbB3RALhpFVnE5neCxpm6H0ainBBCESPuLJQKkElH4bJjgyHy4pLlzK
	GtsW9bKv9VeRS282OUxX0SSJn8v15gKCPkrXpQ2arIxNTcYqNu58ypsWinNiW/cJ9WEzFb2rwTJ
	k2T6Xq7a0n2dgqsepbcmsZ9pIgApcXSnQuDGEsxIdpInRg4Kw1yQNQHl10Wih0
X-Received: from wrnc9.prod.google.com ([2002:adf:e749:0:b0:43c:fa78:503f])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e0c:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49042489c30mr450538145e9.5.1779894163610;
 Wed, 27 May 2026 08:02:43 -0700 (PDT)
Date: Wed, 27 May 2026 15:02:33 +0000
In-Reply-To: <20260527150236.1978655-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260527150236.1978655-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260527150236.1978655-4-smostafa@google.com>
Subject: [PATCH v6 3/6] firmware: arm_ffa: Fix Endpoint Memory Access
 Descriptor offset calculation
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[smostafa@google.com,3kwcxaggkblygacghy3y4cc492.0cacd-h2296ghg.hfigh2136fakyf2.cf4@flex--smostafa.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[sebastianene.google.com:server fail];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.73:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3kwcxaggkblygacghy3y4cc492.0cacd-h2296ghg.hfigh2136fakyf2.cf4@flex--smostafa.bounces.google.com];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.73:from];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EB7414380A
X-Spamd-Bar: --
Message-ID-Hash: A737IXPB3PYBJB6ZXQ6CEGA3J35M2QYI
X-Message-ID-Hash: A737IXPB3PYBJB6ZXQ6CEGA3J35M2QYI
X-MailFrom: 3kwcXaggKBlYGACGHy3y4CC492.0CACD-H2296GHG.HFIGH2136FAKyF2.CF4@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/A737IXPB3PYBJB6ZXQ6CEGA3J35M2QYI/>
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

Fixes: 113580530ee7 ("firmware: arm_ffa: Update memory descriptor to support v1.1 format")
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

