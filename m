Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CFBC5DF6D
	for <op-tee@archiver.kernel.org>; Wed, 19 Aug 2026 08:39:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D28424522E
	for <op-tee@archiver.kernel.org>; Wed, 19 Aug 2026 08:39:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HC9QoNsq;
	dkim-atps=neutral
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9CCEC44EA7
	for <op-tee@lists.trustedfirmware.org>; Wed, 19 Aug 2026 08:36:36 +0000 (UTC)
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc80544c74so2321565ad.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 19 Aug 2026 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128596; x=1787733396; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Rj3sKjI+D/fIhnx0uthKRhFeAN0smVlqCx7Jkpt/N4=;
        b=HC9QoNsqgaURamTYCtxpf1nUkI504HxgN9Bvh/aFJAJFAJ53fduKk3fZuJcGSbmyUe
         bZUkj5rzDlp/4K7avB/UMQ7d+uLHx/LPtTKgzfqHrk+mc0sbTjyH6LBbuVS2ctGtPPaW
         wTcnxhhqCqp43EUhCD5J1I2qLMbHzAtTrVtclYUtiEmdNpnmRG7AvloNjHQbbGCQs20f
         X+mYbIcApw3k/xPByWUcnewWnMugl47QIRiWwGpIdLJ+c69cWzC17WFdjJ8Fv0RKyQN7
         abjzQXqNdK6viMa9iIP1+ie0+4h8JbfSDaxx7CEKyAtZ+1EUuc9Y7kpHubnlE8sDsMg6
         XkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128596; x=1787733396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Rj3sKjI+D/fIhnx0uthKRhFeAN0smVlqCx7Jkpt/N4=;
        b=E1e/H6AsXN1gJvIo2M4DdAlaq38uANM5FoKs5IANvOZarMuCkE96Oie2R4QBqo6Nmv
         3DvKB3RKBFeKCZg4sXsJfsrXDlWb3svTshleBsOiFVp/7MIHVaKzksdtOetQh39LdLHU
         csJKruECeYqRlgOwXfLcA2lZwnswLpzH2+vbNXmzW4+csT+1hdl5Kx6qjiWoODnAbWVw
         mKqsO/0gttA2R3SxZNG4q4wEPiP3Vg1oZqSndVoyQb6Skg50pk2+5CKWTPABB5rGc8uL
         XCtdusRaCbY0Pj+g/c/m+fBfHGQ8cjaUupdVamyphhYDpFF5b5bUigVEmRf/1TSVVlkP
         R7Fg==
X-Forwarded-Encrypted: i=1; AHgh+RpLJte9SlQ8J09v9ogIFy0NABEK5X00f+cTHttNbjEd5PHuKmm+3Bdimcw4MU9NxRgQUTYIekY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxLoEnk9rKd3IZx5bXjwRRiqW6wCo7+TdNZgAeuP/2Yzr5wN1I0
	jzhYOLJVqTX31HvO129lDjCLyoGeKdBZkxQW8nRDiuEpU/BXwcYKEgPr
X-Gm-Gg: AR+sD12vsYDNZ68YEAbE4OXo6W3Y1TyDqg4GllwV8bifuEKQogSzaVlTT1TLZtWZASk
	WI1fmqsC2Aio/ofDiqDReLvWJbOffJ+nGRWMUu12mE4XmnlUiwtKxAy5ESqnwVQZz/D+0cI+5ml
	zjbxO+vGdWXZsjLtTNpTx1DYmfzrUp2z5DHqdyBw5OTQzM4MtZiwmYZn/KCfbO1OhijAaP80dwL
	j2nrpbRXRCr3Ldy0gjZZBTRYxn7v5htphoQ5C+vewfgZhw5kJmNJI6q/N9DbmlKxNKeGWCe8Hpl
	PGbA9RdeCjy2yQcvONg3n3++wAuEiDsQK3EYJMLh6D0erO74IWLCvTc0jHV4N5bqeZrhmw/qd3h
	G38HkNqn6IZSwdbnSJTLyF9/g/qpX4ReqoqWk16G4Fbz3VEcoROiXCBw8V3qsrwFMuluTlrGDdw
	x0gJHYzAS0eI4dcIoFDiYLjDAhgjrbuq1FDk0mSqFutFmVUpK1FOxxQ/KK4kzfr2Q=
X-Received: by 2002:a05:6300:67c8:b0:3c3:76a8:c0f with SMTP id adf61e73a8af0-3cd00dcaa72mr6006921637.4.1787128595459;
        Wed, 19 Aug 2026 01:36:35 -0700 (PDT)
Received: from ubuntu24.. ([85.149.220.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc155464a0asm332268a12.14.2026.08.19.01.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:36:33 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add mbedtee
Date: Wed, 19 Aug 2026 16:35:57 +0800
Message-ID: <20260819083559.1303348-2-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819083559.1303348-1-xing.xl.loong@gmail.com>
References: <20260819083559.1303348-1-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-2.00)[95.06%];
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
	ASN(0.00)[asn:15169, ipnet:74.125.227.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.227.132:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.227.132:from];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9CCEC44EA7
X-Spamd-Bar: -
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: Q6QHXWKJKKERXNLX2NNODG3232QOVM7E
X-Message-ID-Hash: Q6QHXWKJKKERXNLX2NNODG3232QOVM7E
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:38:33 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Q6QHXWKJKKERXNLX2NNODG3232QOVM7E/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Register the "mbedtee" vendor prefix for the MbedTEE Trusted
Execution Environment project (https://github.com/mbedtee).

Signed-off-by: Xing Loong <xing.xl.loong@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

