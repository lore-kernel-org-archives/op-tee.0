Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1798CD98F7
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:52:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 31E8A44ECC
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781707933;
	bh=fmNOj5noDV8FLWJ+KWreCVyhF0Hc+7vAbj6fINFnd0Q=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=WE1ZNgN53bERZ9b5uKydl9f3RGId2EJctL0QiLUcC41Q6vSWPMA+tLodg/FVBlWh6
	 gLIt5BgYCGzxfGOKJSocw5uIcfmgnx1seKGknbZLgka2qidVnZeu8m1jxb4T6BqgNF
	 6+TNeoXTOl46DxI8XOcIbKQmzyy924NLhQFb665Pg24v2GoQOP3t0SCa9T/kmmT7gb
	 VN3CheA/F3l+rsZC9kEe6oJRxJPwEEC8P82tBEVi/nCKM/88q32S4RsNUdVV5X/ktY
	 ojiRVtx3BmUHXBXZOWsQua4Va6XrHiCWDB5pLQVRgJZ2yJneMIxEoj5qTrA68m+sAI
	 RZIK+TB6zygzw==
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 792CD44E1C
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 14:51:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kFVIiLoO;
	dkim-atps=neutral
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4623bdcad2fso748024f8f.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707899; x=1782312699; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDAOdwtxrmt1yvz0cAbxnb4xCO26mPsS8gCJRaVl/Ak=;
        b=kFVIiLoOU5aHEreKrcoejYWwVTNSf1VvB+Pv8EOskgDXJuPzyMPqnL7WRwM3ZQ6JQm
         jtYYtOIAl0Erss87QxPc7Qy6l0mA5End417IYBkxIGvQluOPcQTLc/cIZaqyYWJLqnNc
         Hezx6Q8mLe0/dm3WUAGXsBt83Z68wLQeENaGHMP+OuuYVfFQd1Z9vOcxWldPB/BcxEId
         hq2ZOf01xcjxYKEmpllv0PThl7MHarPz5tfrPlJOIW9Z+RXTwsqHIPlVgL+H04OZPiUB
         N3FjRfPO5BJf+sd+zUYAWyxTuhoFYXPugdaF4fmGCgxul8UHV9i4EyTRkR1dRT+lEdnm
         DtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707899; x=1782312699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDAOdwtxrmt1yvz0cAbxnb4xCO26mPsS8gCJRaVl/Ak=;
        b=Pz2hKuMXAk+2PvkhzGiXdbZtNPZpb0vm0mn0yDchIZM0IPnRama67ZU3rCFg5hF3Zy
         wlr0kaWqZrP6cDbfp/WbHjFoVyG6lrNrTORYBcNhOeupv+QhKoC/EKhoUH5//LzPdf+u
         pea+CIcziqVM3FQJT0+XJiqfw9jG1pZED9mAgmsD5q3pbAYzZ3qbX9faCjqFcOmQ6Ewc
         nuAa8GaMYuyRiWFWRmQhleHlmSfOVguk/2MpoU2rUhATkemoo6qaktdc8DkSSZYC+QiI
         EXQjAS1McEC8FJQk0GClRCLekn9XDnWpNMllFIXMIPxrvRy8XJcgVrKm20auz+EmNKbn
         FbDw==
X-Forwarded-Encrypted: i=1; AFNElJ8JNMXiAJjxFgWa3vuC2yZcxgMU7iZ59+1+Dz6Ms0a/PIr3Sp3lMGZBJfkSih4OWDmYr8vtEtQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzXFXhkBXqy8Sl0LQ8bWnJCg+gz5nOZ0WvvRZjjQKa6r0NPZUYY
	mWlVGhK7vlzSoYC0rdp9v7aojGQFpZA6jPa6eEgokAgbZCEbim8QLFWroilSxjPhQ918NMHXJye
	LVv1MFoNP67+GVq9hg6v2fC+NxWHv0g==
X-Received: from wraz22.prod.google.com ([2002:a05:6000:4696:b0:45e:e4d6:bba4])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:f206:0:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-462374b8285mr5538800f8f.16.1781707898956;
 Wed, 17 Jun 2026 07:51:38 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:51:24 +0000
In-Reply-To: <20260617145130.3729015-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260617145130.3729015-1-sebastianene@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260617145130.3729015-2-sebastianene@google.com>
Subject: [PATCH v7 1/7] optee: ffa: Add NULL check in optee_ffa_lend_protmem
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3erqyagwkaaczlihz0phululnvvnsl.jvt@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3erqyagwkaaczlihz0phululnvvnsl.jvt@flex--sebastianene.bounces.google.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.74:from];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.74:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 792CD44E1C
X-Spamd-Bar: /
Message-ID-Hash: IWS2RVRVV4KMUUV27GWEKY5BWIE5Q2FN
X-Message-ID-Hash: IWS2RVRVV4KMUUV27GWEKY5BWIE5Q2FN
X-MailFrom: 3erQyagwKAAczlihz0phululnvvnsl.jvt@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IWS2RVRVV4KMUUV27GWEKY5BWIE5Q2FN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

From: Mostafa Saleh <smostafa@google.com>

From: Mostafa Saleh <smostafa@google.com>

Sashiko (locally) reports a possible null dereference under memory
pressure due to the lack of validation of the allocated pointer.

Fix that by adding the missing check.

Fixes: 2b78d79cdf96 ("optee: FF-A: dynamic protected memory allocation")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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
2.54.0.1136.gdb2ca164c4-goog

