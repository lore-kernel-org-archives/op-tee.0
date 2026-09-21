Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C3DC982ED
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:05:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2559A4533C
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789988701;
	bh=B/oP32fYVEgL/ZkWtwoP3dz6NpLmlUOmCKj3v/0F8co=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Qxm4m/RADb7FiIa9m4pueW3k+LwMhwvebdZAhTJTJEELRvj5ml6Bgm0/fEirx0X0N
	 LFXdY66r8k43wHjPJWNfGLydWs5HGI3wdCzPInnU9cGZZIhgZaUCSL5F3Qt8pax6m/
	 eOtv8mTJW0OmOQZ12fYUDDJOlpv7hezHc6BQuyJpdAdq4skkI2sMv86lS80zAV1zlu
	 xInAQbSi9sfJkj0EM6QH6tVa7yYCXBCcXEUi0jG5nq3QZBccFgmJJ3uGUK5MRIkoSQ
	 vSbPml3HPKsqB7F8DKqHMqHogIrLq264KLrST7+l6h0HB9+1jmI3XPs3xSpTaOAF8K
	 mMTd5zaA73k2Q==
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D9949454C1
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 11:01:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XEM5Ejbf;
	dkim-atps=neutral
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e745d5dabso32361315e9.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789988466; x=1790593266; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oCrcI7igLaQUil9vBYjywYIs9hdqlrNEBSUMKWJIUV4=;
        b=XEM5EjbfmwgppRdMSl8KjevsvvoPPDc+6KmJIdGVzHuDDUJdSIzbgetjXTHALz1BEU
         nBLqQ67UrCCqu4CbaGL/JYljIWVpoionVaM2nNe/mcEOBKpjvLOd1CR+mI/wKZMEGNQU
         4hRtf7nzUPBhnK94FHDrg4ocD5TQBFDWZbYtoaQ0RowcCpI6V2fCIqFjIwCD31rB5r8n
         RISOEW4HxbSNOyCCSj3Ls3b6FpfTZzau28ur2teNlebnMNt0ur0d91u6nfG5HhWlDxst
         5iAaF2s6oGuHv/RcsjUAa2DPDNzMF8NVN9VpvTlxDEQYm0TJrfJ9a0aQdx7FnCQ7wWNu
         1ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988466; x=1790593266;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCrcI7igLaQUil9vBYjywYIs9hdqlrNEBSUMKWJIUV4=;
        b=kttzZYi7kykcpVhV2gWSeMAlrprC3s62QtQ2nLZudmERKF1tsDe5z5+nZHme1sze27
         dA7AXLpirwR9W+VhKS3TFnPNnExO7UUj+pxuc6JSK5DToRvuw1/AFFg2OLJBormZaL0R
         thvwnayyFUFfmot6bZP6A8clF7Aovw0ZDYj0/SaYgHbWGYq3FE8JyjHgzIt5MFdzmm+m
         137EbgFQK6DdM/FwovJpSPuDfEG3ddhWUrNLzinXzRDsFGe4ii8NN2Bc5l73Jc/GqrE2
         D0qvnSkSAmoBIPQuGqqg5GtpcWKUprcT7r2lEJxhe6DUYhQXlR9ZIPvxJL1Qi4ifc/JU
         Ykzw==
X-Forwarded-Encrypted: i=1; AKwUvByRyudIw/opnX7U6ueCT40Ec/m2GtikgvI5tqO15OYwpkqw1spIwIAFm7YhhDqttLWd0apbX0g=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++l0zoPj+b7On4R9mAzuxYefeJpvbagNKzSrv7oN6VkZm3xCt8/g
	uC0SJmduyTgbPMiZzYdDyByuOPRPCn7O/Utw3z+UhxKi3/mOlpeTBKsmeOze1VyMx13nwOoEymW
	4Rma+xjX63psWB51Jouc4kw==
X-Received: from wrbeh15.prod.google.com ([2002:a05:6000:410f:b0:487:2514:733])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:290d:b0:487:27f9:829 with SMTP id ffacd0b85a97d-48727f90a8cmr8269596f8f.30.1789988465393;
 Mon, 21 Sep 2026 04:01:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:00:50 +0100
In-Reply-To: <20260921110050.3977591-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260921110050.3977591-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921110050.3977591-9-vdonnefort@google.com>
Subject: [PATCH v2 8/8] dt-bindings: firmware: optee: Add memory-region property
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.19 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3cq6xagokbq4jrcbbstcfhuccuzs.qcacd-hsszwghg.hfighsrtwfakofs.cfu@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.69:from];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.69:from];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3cq6xagokbq4jrcbbstcfhuccuzs.qcacd-hsszwghg.hfighsrtwfakofs.cfu@flex--vdonnefort.bounces.google.com];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D9949454C1
X-Spamd-Bar: --
Message-ID-Hash: CRANY3Y5NEPXGU5UW5EIGLTDHSRKDIY2
X-Message-ID-Hash: CRANY3Y5NEPXGU5UW5EIGLTDHSRKDIY2
X-MailFrom: 3cQ6xagoKBq4jRcbbSTcfhUccUZS.Qcacd-hSSZWghg.hfighSRTWfakOfS.cfU@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CRANY3Y5NEPXGU5UW5EIGLTDHSRKDIY2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

Allow reserved-memory via memory-region to support the arm,ffa-lend-pool.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index 26ebcf4565f3..7fddea9cfdbc 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -41,6 +41,11 @@ properties:
       HVC #0, register assignments
       register assignments are specified in drivers/tee/optee/optee_smc.h
 
+  memory-region:
+    maxItems: 1
+    description: |
+      Phandle to a reserved-memory node for the OP-TEE lend pool.
+
 required:
   - compatible
   - method
-- 
2.55.0.1082.g2b9226bbc0-goog

