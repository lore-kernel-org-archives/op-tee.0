Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B79C43602
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:21:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A8B1A44A27
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782814913;
	bh=cqpqWComKRWiCpCFlRr5CCe1UaqVwupCKxUEyOVLkh0=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Xlxd/5/P9c5z14YHqtDTJqbb+b4DVNApezKlw/yAaDBLeoATDT0CDbeyNr5xw0wLk
	 vN56BAeJVaIpKbQClO+B2RaLWmZPHwrw6E6bFAU/tFHIP4f0OvOlkSYbxWhl44b/u3
	 nW/2/4Bkc7P2ogn57gBBA8HNdxRHdU51PMFg7PtEjB8Uaa3fQ3lDWr01ceQMwP6fbS
	 mwQrFdLTSL61+eQbFD7P/zlAzsELv4dAT/Q2eTPhMWFpbqSQvKsrcoHcFBVMvBgBGQ
	 f0D5o5wfNqY7cMMPzm7fo7fd1ZdSzg2c3iBZ78uh2xodV1rH5nk86TaXQ3pNSfL44e
	 20WjABIX55E0w==
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 447AD44D84
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 10:21:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ERGySOLV;
	dkim-atps=neutral
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c1265eb65e9so205427666b.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782814881; x=1783419681; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3srY3du6pUShZyOw/nlifUO0efjUMM7goX5s1Ul3bUU=;
        b=ERGySOLV2qaC/4OJNIULdZqUbjz6etmJuzYPk8ag58dW4AKTzOzU8KaS5EAPIyJ55C
         mHrO2m/J3XmBEbXnWMQs2oI4R/Tu8mxsqSNnnc+yjWBfSy84h0wYh7WNKnVmTV7RvzYk
         X+bxzEGumZckTQIQNxM9ibgYcG9kSWzgDJMoDcHXE9M/v4OQ6sQ66DsTQxOWUqZU316O
         Z5LdUYPVIAy5iezZmCxCX4HhpvnDFPaTor2OV/PIxjAg9nsHtH04B2OAFgPKsAZHcshd
         Gl4U7x9QVK6TDIZBywgZuhcHuzzXyePGN0fTmv1KIM9pk6dxRhDSdhqdv4aCKW/kttXc
         Nb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814881; x=1783419681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3srY3du6pUShZyOw/nlifUO0efjUMM7goX5s1Ul3bUU=;
        b=PwBZMvwYZZfpwCM5QVZOeZDdC0goULHUXxv1KIvrD1lYprXORWnKmngWFDFvgB9DiR
         rUkYk/EfXkhHnYteHUtge+ySBCzYhex8SBl7JUG8C8gRU/Ceu+puYweyEODXnhHzq92E
         SHHt1pbNXCi3gx6Ir17AMFtbIu1fWY/hInEy+Vyhbv4CChOnDTPHbuq5MFWQSV7AujfJ
         P5rs7C2Z0p/zuB2mHN3Y9KwQGwhqOsCFI4Twg0s5UakGM4dTSLA0EKB0ZSn36JiIo9Nd
         ubhJHBuBiJ46x3skIx6mmYm4cgOuoLNOJGFATT24zDHh9D+ryjk9Qo7TVQKD0vy5GuyB
         gzyA==
X-Forwarded-Encrypted: i=1; AHgh+Rosl89sswZr2UZ6jhCdT95khYWCvwmn6yto/CkoUU5dAWv6Xd7qc9+ltIwpsvDVXFhSxl3Jco4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzJmtWnvSmIVvEyO/pBOPgRiAu893tLCVIvunTSWp8R06toHKkf
	jz8XP/Vw1ifIDbRoDf9W0/iIt65i+4kMNYOd+O59Wi8+zd7Z7lQkXSb4gcpK648OVAxQ4mX+8Z/
	S1HFa3ZrRSZycx+zJ7tFI9fuUeSemKg==
X-Received: from ejbgw23.prod.google.com ([2002:a17:906:f157:b0:c12:5da6:868c])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:fe46:b0:c12:8d49:48cd with SMTP id a640c23a62f3a-c128d4953fbmr93701066b.37.1782814880689;
 Tue, 30 Jun 2026 03:21:20 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:20:54 +0000
In-Reply-To: <20260630102058.3219867-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20260630102058.3219867-2-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630102058.3219867-3-sebastianene@google.com>
Subject: [PATCH v8 1/6] firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,3ojhdagwkadknzwvnodvizizbjjbgz.xjh@flex--sebastianene.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3ojhdagwkadknzwvnodvizizbjjbgz.xjh@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.73:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 447AD44D84
X-Spamd-Bar: /
Message-ID-Hash: H5S47PUMH2VQVRXVVFZONL62ASUSKDV2
X-Message-ID-Hash: H5S47PUMH2VQVRXVVFZONL62ASUSKDV2
X-MailFrom: 3oJhDagwKADknZWVnodViZiZbjjbgZ.Xjh@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/H5S47PUMH2VQVRXVVFZONL62ASUSKDV2/>
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

