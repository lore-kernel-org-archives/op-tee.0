Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D59CD5BD0
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:20:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D1FBF44E8D
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779808818;
	bh=pt0ml956E7763pNtpKBWBD6NZdNOiJbp6LvAL3RA/Qg=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=LRYHHUugviaa9H9jBj8hDzRL1JNqP5ukwrf2wi+lJ6ZBokoIZ6Nadgi+PN47Mbztl
	 WmGAS2U8lWpzzzg4lkgnWPVM4ixg5ShM3wa811yX4lgRBGHVglyPmDlMuvRF7ylLQY
	 BdiWRw0C0wK76x2AtZ1l3hjaLuP3IY9tNR5S3sXAdO2eXBzM05tBDy2c+LPtJSJA0l
	 6Wv4hnb4C7lX/fCugccCA40ap+0ItkBUbujuZ8qpbveuIF0uprKIl+XRX5sOm1FNwD
	 LnQyFbUYCB8yA+2TH3aEDhNERJj2J0ooBiAYfxl8CzHw6hW8cLpCHA6RHlIv4Wwj5m
	 nUWbf8Tz6nVgA==
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4E8AA4326C
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 15:19:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=o8A030Z/;
	dkim-atps=neutral
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bdb96f6cb84so214011666b.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779808786; x=1780413586; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYSPuJSk3QuKc7sf14ipiOObeqdt7tBHKRBi5y5X6HQ=;
        b=o8A030Z/2aJxIXi7cT+9Rns9C7UGl/83wBguRVMkE09Zhp5EbemxNvF+cLC2t2UGQR
         t7qV/9vNJI9HPd7uabFTk60eURUW8lVvKbQpkze1cEPWYLSHYTU67u8UH4v+snCXWfTm
         ufLqSo1jEPoGyJPjGS+v15kcjbLk9mPzjUgQm67VJFlgmMwOZCBkXHB3czMWz+JY9Pi4
         Pt7rg4cy3blmRkEsbHmdb72iW7H0Oer9VlLvxpFxgZ4rwKm3dxesSx7KqQUWSoTzpdI9
         sLDIfeCjBp2Swm70AX90dwCkx9Uk8MAuTeC9rA+gOAxmsohoV7K3n62ZVRpOaX2xeI6o
         YBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808786; x=1780413586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYSPuJSk3QuKc7sf14ipiOObeqdt7tBHKRBi5y5X6HQ=;
        b=DnvQODVCf5Sr/xzjbbumZdCwW2AB0pqPI0hvVOYVwp42iB3/1bRMBzUGl7l1hhIj2T
         7OwUcsrsP5QMmTT5ZeuhLwBuTZp3a7R/2C9lziM/HWM9HTMIdOSe5WdMXjczM93HKL2E
         8eTjxrzfLZBb3KKZK9+zZnNuhwoIcP9kgpYDDbnCvJYAQ+AHxDM/r1/shWhBvUhfpG9m
         cNeApcjHwrIUvBXS5tbZigkXagWHtMRtgJvcrpBdLcOCTgDz12wrdsbLiFs4xsR6pHse
         M2eUds61LIGAwLb2deAE9rphAUbLHoN4lRlKjDry+8+s1b/nkEfXA8HR5oDqjwiEObf9
         +LcQ==
X-Gm-Message-State: AOJu0YwakG3yqVJp1NMWu27o4rkgaIzRawjBT8hJCf4bFBazcXG+fp4W
	OQrPALCHw2CaF2YwdghwG+mnSreBeTzmBCHgKUY9t2xObXgOgfrNFpoQcRQerx67+cEfZxLMRWC
	iQH2IXG5WyUe9cUj5MpUflr5dUKCmhm29LL6Oa1XLFDl1eNgrpduvqpwRGeXTOm5tK6xCHcW6SP
	Yy2FV7Ckg2rG/FKYgNgJ/D6p9ZPWCRacWNvYFAjbTasJU038A6+66s9us1/0OZ
X-Received: from ejki2.prod.google.com ([2002:a17:906:71c2:b0:bb7:b0ba:e7e2])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f1b:b0:bd3:6ec5:f141 with SMTP id a640c23a62f3a-bdd25ce1b65mr1107073466b.30.1779808785644;
 Tue, 26 May 2026 08:19:45 -0700 (PDT)
Date: Tue, 26 May 2026 15:19:29 +0000
In-Reply-To: <20260526151934.3783707-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260526151934.3783707-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526151934.3783707-2-smostafa@google.com>
Subject: [PATCH v5 1/6] optee: ffa: Add NULL check in optee_ffa_lend_protmem
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3ebovaggkbjqiceijqvqweewbu.secef-juubyiji.jhkijutvyhcmqhu.ehw@flex--smostafa.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.74:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.74:from];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3ebovaggkbjqiceijqvqweewbu.secef-juubyiji.jhkijutvyhcmqhu.ehw@flex--smostafa.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4E8AA4326C
X-Spamd-Bar: --
Message-ID-Hash: SF2Q3RYTDPEKNBBZZGXVSDF2KUDKQXSP
X-Message-ID-Hash: SF2Q3RYTDPEKNBBZZGXVSDF2KUDKQXSP
X-MailFrom: 3EboVaggKBjQiceijQVQWeeWbU.Secef-jUUbYiji.jhkijUTVYhcmQhU.ehW@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SF2Q3RYTDPEKNBBZZGXVSDF2KUDKQXSP/>
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

