Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D48CD5BD0
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:02:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 805144380A
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779894172;
	bh=SVvDiffb/nQ6NalN7qs94CnE2E+NZ1sLlPWERmt385M=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zi+dgVfiBg1uBebvcGiuPlCfA5AlaDZop6LHNVR5RyzNN2NIyHxSdvRj4c0I+Hhek
	 Iqxl5XLb7bolKmfFOgJs0Ik699ubSR+muSoR2Gb5L0PvlBA9Jw12MEi5bKihLuQ8VA
	 nBDb5QNFBHk8jAY9/gqKG+IDA8jm6NFE1SiMUVt+5dryqImZQPADQas7mBQWErWkJU
	 CIGzI0sgEN6Y0XRuNxVNGdRt9K/DXADUnk5H+qvqD8W5Z9WyFJ2h2UQ1CVgXLZLTRO
	 yp+tB1aSZCW+Wf56+8hxgb8HdX0Ev/JtuslKz8daflkPaMKveAU1ySKI3O4cH7EnY4
	 0UUkrj9QvKnMg==
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 93B074380A
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 15:02:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VJWqKNvp;
	dkim-atps=neutral
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-49050c44bcdso56486125e9.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894161; x=1780498961; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7J1ztb6Z4HCTvPSQ3KlFjIJDDk9HF6V81J85Mqd8VE=;
        b=VJWqKNvpts6aDNX8yxHEdUtG4CPmzuOnfU0XzEifIgtntfaxoF4UBUe6O/yb9HLsUW
         ubDkzpUarwKWvKfmSgi6ldkGovpJokSYbjUJvpaaH0ApSc2jrra9wv3jLE2TUvdzt+nC
         CABLQpaXTsEUX22/0Bx1rM8gAeisCrY6Bh/61yAEm8h0BZSwe+yf0hGuH0AYFJyeEbXG
         KiIDKpbkucUOqzuD2+iqjoSVk3D5I+oY+0ze921Y/ttXlznOK54L0+T93TJEk9MJrCN7
         FGNV0ebI11d/Azkhg7sz9Aj0eUzpouK7NC5Y12Q0Zo/2rgRrcWiw4uSeT29WceWKpUMl
         Sjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894161; x=1780498961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7J1ztb6Z4HCTvPSQ3KlFjIJDDk9HF6V81J85Mqd8VE=;
        b=A7USvpPK0XNp7gogSG3cdyeDFvspe07MeJfsF7Dh3mrjSNOi2zNc58/T5jKY1hR/Rp
         hKJK5DA8gcq8pa5Hw3zhZgAgcAaLXAX5OvYOLS/f//qiRuSDR6/8x02N3x+tlHBV4SZm
         lawT2I9Kex1MQSj97X1Q85k96saGcwEW//PSPQ3JK45weCcffxVtowSWQF5OKp2TWnZn
         Fd4X/JspFGjZA8GSK1Uk32BvJZ3KMYQuOraCD6yJSvMxmliZwSAPklLcCDhLutL/mLYc
         UphW2KFcHFiyA9kDbzjBqED1m+TEktuMFBoDs3Wj49MpMq8x7iss0lF7VRXRXp4BR5PY
         EYpg==
X-Gm-Message-State: AOJu0Yyb2BmEvhJt6EUQZ0kWPkcKM+sSTq953LOmrZ4XPHNuhLa6KM6a
	M6hm/M+5uEMWYs3K1+78jVlNj4Owprmoj3vP7Tkiq3h7t9OCAmWq9ac+WdC+zHmd+DgUdppdvJU
	SjWqidREPIRQEVGP6512tvtNDJjj15YbwwIDkI1tv0Cfeq072rHya7K657LlYd5VLBPZGb22rlb
	SdG8TsF80KFgG1N4rwYWRipEQTcfDfAhsGZFQQrlme1PHQX373Qs5F24kXOGYN
X-Received: from wrrj16.prod.google.com ([2002:adf:ff90:0:b0:43d:2d2:c03b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:530c:b0:490:5527:3be2 with SMTP id 5b1f17b1804b1-49055273be6mr302305885e9.32.1779894161027;
 Wed, 27 May 2026 08:02:41 -0700 (PDT)
Date: Wed, 27 May 2026 15:02:31 +0000
In-Reply-To: <20260527150236.1978655-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260527150236.1978655-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260527150236.1978655-2-smostafa@google.com>
Subject: [PATCH v6 1/6] optee: ffa: Add NULL check in optee_ffa_lend_protmem
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3kqcxaggkblqe8aefw1w2aa270.ya8ab-f0074efe.fdgef0z14d8iwd0.ad2@flex--smostafa.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3kqcxaggkblqe8aefw1w2aa270.ya8ab-f0074efe.fdgef0z14d8iwd0.ad2@flex--smostafa.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.73:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 93B074380A
X-Spamd-Bar: --
Message-ID-Hash: BZBLALAVEENHANA3WNY76AHSPNLRSO6Z
X-Message-ID-Hash: BZBLALAVEENHANA3WNY76AHSPNLRSO6Z
X-MailFrom: 3kQcXaggKBlQE8AEFw1w2AA270.yA8AB-F0074EFE.FDGEF0z14D8IwD0.AD2@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BZBLALAVEENHANA3WNY76AHSPNLRSO6Z/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

Sashiko (locally) reports a possible null dereference under memory
pressure due to the lack of validation of the allocated pointer.

Fix that by adding the missing check.

Fixes: 2b78d79cdf96 ("optee: FF-A: dynamic protected memory allocation")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/tee/optee/ffa_abi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index b4372fa268d0..633715b98625 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -698,6 +698,9 @@ static int optee_ffa_lend_protmem(struct optee *optee, struct tee_shm *protmem,
 	int rc;
 
 	mem_attr = kzalloc_objs(*mem_attr, ma_count);
+	if (!mem_attr)
+		return -ENOMEM;
+
 	for (n = 0; n < ma_count; n++) {
 		mem_attr[n].receiver = mem_attrs[n] & U16_MAX;
 		mem_attr[n].attrs = mem_attrs[n] >> 16;
-- 
2.54.0.746.g67dd491aae-goog

