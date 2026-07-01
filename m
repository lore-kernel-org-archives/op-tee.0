Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86CCC55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:14:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EBBAB4524B
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:14:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=nLGFaoWA;
	dkim-atps=neutral
Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9E5E344DD0
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Jul 2026 13:25:53 +0000 (UTC)
Received: by mail-oo2-f3.google.com with SMTP id 006d021491bc7-6a0e145caeeso53788eaf.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 01 Jul 2026 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782912353; x=1783517153; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9ly6ZTzLYLZx8yS4TUkxxmSHINnr8BKtUdkBSO+x1w=;
        b=nLGFaoWAxaJAgPJlhfPGg1bxWXXeTpOy0XJZxThqqDqoMkvDCdQsvi1yMmoTb55HX7
         W0j/edMhM0lgSnNcJOjXwoldDZzPWwxoTJxAXLBXUpib0p7AAEKqWSOtTFsokwbIYbjT
         4tJVbCVnlwZ1KRxCU99NBEthac/9qxsEwHqM/e/EwMHtxoopb2Hm8pbL+OAtBb2oYzX6
         9I6K8e4GHz3um774rTY0GSEnAasMzZMpKhg1Qa2ApEt1KGGv0tMst6DYD9p5KX3HdJBz
         DFTy/zcBgNhh5iHhfiyiwLQJFY9d6Z5JCBMOgA+VG0Rk+pqxX+uZWORBMECeyWFPLDiA
         R+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912353; x=1783517153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9ly6ZTzLYLZx8yS4TUkxxmSHINnr8BKtUdkBSO+x1w=;
        b=hP5yB2MPFPw5D0N+bSN1Uzo6uQ5b0hpKcz7P4sEr78WdwTYDOLK0+2lr62RVsruG0T
         /2hKtSwarzLg+Dty4AzV0c3yPBWLXmrSJxFuPfFMV706mAH9TnkUhnrNgrxwRXhizwnN
         UVPNjORLJz5zrivODX8KV+Z1forz9WgIgYctxZGYPAjuj+mJMJTscTKwEPrwG/ppII0K
         Jx6o/zkYNw6Da1BuKk/gVOmGIwjIBJ7mItJJw4KnBNT5gZpPVJDXkx2VSYCFWgw1b8mh
         ixFFsFLB8aB6IPKTUtV9U9zZNpVc8J0lW9qVM5Ibgqiuj+Cmc1GHFFO0pi4NbV0tJlOc
         eyOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8l3nH50nS4tF3eHYeHqyVR5YBF2UH+zZ9DorfXVUekiJZOZNuUdygOqlubkNuCXvXqDaOj3VI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzKjYWdm8KZxR1Rp8BeR8OgLP17ONqKlLHqb2lj5pn4UR8Ki3kB
	5plgSdBxabG32Mr/eX6kyyoDTI6ggjgLyfOCfpGoShJLFec0soqqdZ6l
X-Gm-Gg: AfdE7cnxEjXkydXWpgkwCPedSdwhw1OkFEyGon+XLm9r0jL5oEcQJlv0x/clM7+9Yl/
	L6iDmebeqpPMknY95X3I11etHu6BS0pB9oCYHIrMRGryyj/ySNiLM92F5O9HE0s45rdgvwkS2F5
	1GPt4zKkHcRdpuNU7QDgomfgNTR0avkJTv/IRb8Gk5enA1ytbylO4cdVfmuGHT9w+x1hIT8cR/S
	Yq7AxEmxay6ua+kEovcshzdjI+I2m12vTwyKO76Jpr+Em7FzsAU5f3C2MRfUEtGaB6rUjsnvaRS
	MBF2jX1lavVnGn58ZAA/I4oE+6wYHLSjiW9iTVBdEaYFDpovVbvdZPoy6rip/VaY9U7HYcSTYIo
	c1Mj+swvUsaUKQNsJYJaG6+QpbYeApT8+Dck4PDnCQSuS+kpXNASjPOFM+9e4TbzFL+cyHi/amz
	QP0LEmFeDaq5MxsQmu1S80xWzkSqDd+KezY0SDp6bzTcbkr2ai88qb9WLVjZGxvEaPOw==
X-Received: by 2002:a05:6820:4b09:b0:6a1:5756:10d3 with SMTP id 006d021491bc7-6a30d79e230mr365118eaf.22.1782912352999;
        Wed, 01 Jul 2026 06:25:52 -0700 (PDT)
Received: from ubuntu24.. (dsl092-249-254.sfo4.dsl.speakeasy.net. [66.92.249.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec34f898sm4938144a34.27.2026.07.01.06.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:25:52 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add mbedtee
Date: Wed,  1 Jul 2026 21:25:12 +0800
Message-ID: <20260701132514.186953-2-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701132514.186953-1-xing.xl.loong@gmail.com>
References: <20260701132514.186953-1-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.90 / 15.00];
	BAYES_HAM(-1.90)[94.46%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org,gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.231.131:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.231.131:from];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9E5E344DD0
X-Spamd-Bar: /
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: YDWK7CPUUYWEAZIXCE4HN244NGJLZULH
X-Message-ID-Hash: YDWK7CPUUYWEAZIXCE4HN244NGJLZULH
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:13:16 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YDWK7CPUUYWEAZIXCE4HN244NGJLZULH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Register the "mbedtee" vendor prefix for the MbedTEE Trusted
Execution Environment project (https://github.com/mbedtee).

Signed-off-by: Xing Loong <xing.xl.loong@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d6..fd032a3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1011,6 +1011,8 @@ patternProperties:
     description: Maxtor Corporation
   "^mayqueen,.*":
     description: Mayqueen Technologies Ltd.
+  "^mbedtee,.*":
+    description: MbedTEE Trusted Execution Environment project
   "^mbvl,.*":
     description: Mobiveil Inc.
   "^mcube,.*":
-- 
2.43.0

