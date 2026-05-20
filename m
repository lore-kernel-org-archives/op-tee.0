Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3777DCD4F3D
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:50:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 620D344E84
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779310228;
	bh=9CAsfM7KLu52yrdWqJdHkcolcfG9V6vCGTohj393onM=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=g74eE9RX/wYFMQcFvBsudLO5HO/DnmRsk+mQieMr1IlDbLhhTKcf3ptycwP/7hGgL
	 DlqUj4nQvdhPHv0IRDSxSmDFE+NEMC6T5tmfi9HzCrqMirGXELIsnklHIzurZ6OWtT
	 aZdmbDwksFwSu+Gkq3N+MOGx72j9cb3VEGrsuYEtz39qI6UmrD2JHRrvSR+kQEnsVV
	 zmOFizgj8/zgUS+MHQeJNOEh1ns6KVUI41NeUDc7a1Wr+6XO6cHX/xDf4Dbxt/gH+X
	 sN1p+oGj2rbOcG22H3kxr0sgt1scaPgDB+HvOGXhrwHT1R1aKLGacyART9mKq2cr7G
	 /5q7fqAkP/Djw==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F1943432A9
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 20:49:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=e72UjwyS;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fed2519daso28301995e9.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779310194; x=1779914994; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkaEL0dtEh5vLkhnum12HiGQZEgLNqcEhlclJBj/jfs=;
        b=e72UjwySIZNfkIC6uuvpEIslBB+QIvpVW2a5gm1rtIxrDL2WaMVTn/i676bv52vJID
         4ikHWjfiVkOrNZtZB41QlEBN6OCkpno43OSD1J4jymoWA+/TV9BynUGoAbp1jYhP4/1b
         TF3yjlIjJ0X7YZ9lrUI9MIL/b8fG/lcINShMZGFYe9FLAyOleE/sj8yb0axHpsWfN9s6
         Z8PkcRDSjuSFIEFHFo3B5TONa3zZtXusg42dr1k0P4VW6zQyxMN11oSnt2SWzJk58qzD
         lyw7lMgAg9QsH2iFioNFqCmkMtEQuxcJFr8wD7lB1p0BsX51xrU0vESSk5t8u7sHLfzz
         akpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310194; x=1779914994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkaEL0dtEh5vLkhnum12HiGQZEgLNqcEhlclJBj/jfs=;
        b=gp5RIWfjLG82aHGfBLN5Gk4gSlypnb6u/bgqroKHboyZ0XsNhYBkv09rU+8R/0rrQg
         zj4dJtSetMFdxwBP6XQdLJ4Z64fUjNc75iDjtOZ0OdOYOXYFaTMDaAnP+r3HgumY9LGh
         VHVFcOILIrtMKF5uDLRn5EL7W32Ki+o0Jwir/76b11isGHa//h+hVgbs8hk4rXmdvbKB
         TxCTADOIMHXGFbx+ewcuyyJme94at+mJE5XNMZAnj0lDccVNIJdb/ZrHrNQcDiom8/bo
         OMVT3wGyHjw3l71aAXFNspww8Z4dWt1GOQ96IA+raEfcpy8gI6s1/LQzYCod8RkkymgG
         NIcw==
X-Gm-Message-State: AOJu0YysWaorsUI2lABe/p2ouE/hggtiY1z6LFdGpcPTuXegI0XuRvnn
	NPN7ACaqCsgFaYnThwQWCiLpwfsYAIGGT9DkJHOALpqrr5VV6rtIiuEKuv/qt7P0RoC/ZqUGMCW
	Bsz6ZkcexoAe32QuuYA4a4JTQ6AeAeIa6JM7t7OG5WDjIFxzPrW/rrChSubYuLzC9lzLxk8QSfi
	yp8xgYzluc64IG30bbgxBbBLv6lB8IbhHIhWGwBd+msHJg9YRpMcwyBBQmA4qD
X-Received: from wmoj17.prod.google.com ([2002:a05:600c:4851:b0:488:af7f:772a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a00f:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-48fe63263dfmr421319785e9.16.1779310193872;
 Wed, 20 May 2026 13:49:53 -0700 (PDT)
Date: Wed, 20 May 2026 20:49:44 +0000
In-Reply-To: <20260520204948.2440882-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260520204948.2440882-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520204948.2440882-2-smostafa@google.com>
Subject: [PATCH v4 1/5] optee: ffa: Add NULL check in optee_ffa_lend_protmem
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3cr4oaggkbj4xrtxyfkflttlqj.htrtu-yjjqnxyx.ywzxyjiknwr1fwj.twl@flex--smostafa.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3cr4oaggkbj4xrtxyfkflttlqj.htrtu-yjjqnxyx.ywzxyjiknwr1fwj.twl@flex--smostafa.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F1943432A9
X-Spamd-Bar: --
Message-ID-Hash: JTNJWKWP7B5BZZ2OSK476JWTWVHH3TMJ
X-Message-ID-Hash: JTNJWKWP7B5BZZ2OSK476JWTWVHH3TMJ
X-MailFrom: 3cR4OaggKBj4xrtxyfkflttlqj.htrtu-yjjqnxyx.ywzxyjiknwr1fwj.twl@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JTNJWKWP7B5BZZ2OSK476JWTWVHH3TMJ/>
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
2.54.0.669.g59709faab0-goog

