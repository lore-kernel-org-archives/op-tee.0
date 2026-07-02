Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8645FC55174
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:16:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CA98645087
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:16:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=iff8TSiW;
	dkim-atps=neutral
Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 620CE44DE0
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 15:12:02 +0000 (UTC)
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-443e4074a7fso725726fac.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783005122; x=1783609922; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9ly6ZTzLYLZx8yS4TUkxxmSHINnr8BKtUdkBSO+x1w=;
        b=iff8TSiWXzteiaHtaiS7RQXm5wGRnybeaMWJvlBWce1qCc/EE5tS5lVMsKgCWN5Ciw
         K+zz/MSbC2Bj4/zaLKFNJtso3Mfh71ejhjBpQ7dFpsnxPZdmPqn1rbjkDwhsSGF9omkN
         PQb3PqzgHttx/Sk+H+kbW1WokqzXp+tU5Kb2eY0snILjBIPDz3L81bVbXLKkJUrbuJvt
         zxV3h2YqEieOXvK/CXjZaJ5M62kiq4HgfRRnkpoOH8siWkLRSsolBDsVCFA3Iz+By0BX
         OE7umRYpriKCmUHyNWoPzVkP8MoB4k6vbgEmB540YyObG+qtnRvIYlJfyZQk3WyIhi86
         QzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005122; x=1783609922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9ly6ZTzLYLZx8yS4TUkxxmSHINnr8BKtUdkBSO+x1w=;
        b=SP3wAtd4PN0XPJpAtA+O3f9vu8BNhrnNfx3HHPXUiw8NRJQBbQkXfO/HPAYnW8T+jU
         loxri1MWvrvoam0Iy2valtnGKuBGiwKmeH30oWWkdNp0hRTkVJ6H+kaLJsZaxdqiQZd3
         n//OUxcPh8TERbYSQTjUBiAjNzRQDcfJFHI6gCQKUng7pCnYIyurEWEtpqiLgNyJTt2i
         JekWWefYAZlkJCWQ7kKbxMJ/GW3+F7/+x3oKgtWdmWzf7J/cfUu59ReRmnNxvV/9tbSq
         8qLlRe6QuHavbXfTCJ9ZBWIZAhLf0agm+Qy53lz3JtKd6zLeRVJ6+LtAxtw55vyYBf+q
         vw9g==
X-Forwarded-Encrypted: i=1; AHgh+RpNFeoPzzRyF7RgKrDHou0XLKWlvmHyDmelypcVxCDBISh3sV2gP+W06lkKKOd0bk/3pS2MKDI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzHn5GL9F5gkMK5ovvhhfhwkpIpbisiGm0vX8BneKS/jvYjHbOU
	QdAz+aFNpSrSlIYRtyZntWk5EZni9g4PI0oBplBALFbodNsJl/YkSuc5
X-Gm-Gg: AfdE7clHSS2KXNMOw8paHxkpW+nqw/tngw1oAPqZRvmQ9XAN2D2OQOqvt+ZvKae0Eo7
	waWH9eHiZpyz8IfiNWLIbbqvonNY7z/ZKwlp/i3ba+4KazLm4hcN23ZPr1lOhQhfzNQFceyLlR+
	hAfgQe49yNgmUi1fcp4SA+fNIyOs+ZCCP68t6yOxubRVHLNn/2ip7bUvynNx4KKDdUpb6Ty+X1g
	lW5dWKSFj/QE2ltzh2tcWJdA8k3gp5WNA/dxbAVkhIGPYys5pnRs33wHEADjZKLjPUzRTHfXHXP
	SCuCeCS/JXjOisMcwPpKcZiHJ/L5Gl+Cdbko6FYeXXm2lqhwDEaIxqLWYi40CK1y9NFsoUe/f6B
	ByXNHy2Y6J85bZsBZCaOKMUjmpjPyQLrvv1ljh6x2Iz5cbTNQcku9PGA8wuw3H3FfeR9bnUsU1T
	y5dOXQKvi0s8WnPj6qhSOclC6XgM/ayAJesAxC6G21oLkR1DuphrqyUnc=
X-Received: by 2002:a05:6870:7055:20b0:43d:31dc:a6e2 with SMTP id 586e51a60fabf-44cad5682a5mr3142542fac.24.1783005121718;
        Thu, 02 Jul 2026 08:12:01 -0700 (PDT)
Received: from ubuntu24.. (dsl092-249-254.sfo4.dsl.speakeasy.net. [66.92.249.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec9a113sm3094561fac.9.2026.07.02.08.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:12:01 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add mbedtee
Date: Thu,  2 Jul 2026 23:11:13 +0800
Message-ID: <20260702151115.544016-2-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702151115.544016-1-xing.xl.loong@gmail.com>
References: <20260701132514.186953-1-xing.xl.loong@gmail.com>
 <20260702151115.544016-1-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.90 / 15.00];
	BAYES_HAM(-1.90)[94.47%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.231.64:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.231.64:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 620CE44DE0
X-Spamd-Bar: /
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: PFHL3GXZNKWSJDDDC4B33ZVCI47SWKX6
X-Message-ID-Hash: PFHL3GXZNKWSJDDDC4B33ZVCI47SWKX6
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:13:17 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PFHL3GXZNKWSJDDDC4B33ZVCI47SWKX6/>
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

