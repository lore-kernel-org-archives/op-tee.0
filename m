Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B372C55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:21:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 67D634532C
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:21:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=Lk8UaJA3;
	dkim-atps=neutral
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AAF7344E96
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 07:36:41 +0000 (UTC)
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c001628so6169159a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 00:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784533000; x=1785137800; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9ly6ZTzLYLZx8yS4TUkxxmSHINnr8BKtUdkBSO+x1w=;
        b=Lk8UaJA3GK9GEIxI46lzY2Vxzk0AMqFO8DbNLDP5uHVJQUg0+lOgFBVskD1SlyqNC/
         b1/dXfUfTaAHFmMkRT+Xv/IHI6cqPsq2EmGOJIHVZJhrrq+BTFK6NCVE9OPZ3MdPDF2z
         cxMt/dfLnGf5cgHS1EfHOkAUIGnABLdhKbGKOUHIAtYt0Pc+Cg6JwLlp9/Jviggxm5d3
         FkJY0m6VmYmODviB3FXghUc5VPIPpFrMtL927xf+OJQIOTuZMuzNGgk7kKH/EsWaQuzR
         dp9KXdmk9gpnKFfiA2QAmc/DIcePCqU4W5B9L1nQFXyQ/qlIDKcooosv5LS6dHm/6Toz
         5zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784533000; x=1785137800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P9ly6ZTzLYLZx8yS4TUkxxmSHINnr8BKtUdkBSO+x1w=;
        b=Rl771N44OSbxkySxcVuSWcnwjiF48R2V7eIFPA8a0wYtc3yuc1fK6DGLYYMjdWs8uA
         phxyBU/SBhprza7Yi2+wDoUkWoCyuavBYxp2ONRNYkXYRQOSq4TSGrMbvf3rpWQk6vAV
         Gb4rgaSuZR3jjnY/rT5i2sFAPDx9YH8cnVaIPpODXNbsnlhdDJ1KQgYh7RF5zfsgcb0F
         5ayN2ACxADjV7a9we1YIneJCr4Rp4i+n2WI4D37qLm3+aiyS7keWfxB13mBdJW6jKfP8
         ns7eLHwV1F/1ZHq6taXMBm7IgvNUsVHuW65UsscAEdx7gyZMkIWqbrhrRlPg5Q78ZnCm
         +P/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq1ChfV+On5GU953neCZw/L0hmC0VzZNA/p9FhV667gDeBy6V4DA6NTXwlp98Egf+Q2xHHgNFc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxZTAthgH3WWLECvNdU45PNWL/3ST/MCxs2tPTwxRRErlcsGfSH
	0eu0f2IGrMj37fPlUl7SPPv15uzgroaanC8Gzgz+ocX65aCi3MPA53Lt
X-Gm-Gg: AfdE7cm/O43ZXw9eQWuZhvKM/Dr02UIDQgKJeIZwGdON3qd3C5lob7fCl/+aVD8qaV8
	ua3jKdK7XQCFDejq2cks6dP+G66s5V1+PxqQ0EUi/SW7PqRqESgQ3aU2bVnq4tjhka6Km8Cj9zg
	0cEHGhaKaRBNR/2rfu9orLSOANaBf1XfqHxAuMr5ZuODew79u5ZLLUqmzQX9HL0a6/gHqt6uhQd
	9CJlVXu3rZeDu5yCIHFv2JxHqk2nlaq5Ug6vKJmcop2nYwCEcYI4N9TIPguBrSgj706kFHdu1ai
	Jc2MzWKAw+PayCBvPdSHeSj8v2nK0q5uuI92s3DVeZa83bfb+/SI0SiRbgENKa6nbSphmPQIZxb
	l5WjGM3oxrdOopIC4+R+xsz+FkezaTS3C8teN7K4DyPF4CtBCqTwIZlWrmnCt2H1kWuENt2xMNo
	g4/Bg=
X-Received: by 2002:a05:6a00:278a:b0:848:2f84:f42e with SMTP id d2e1a72fcca58-84c294d4dd5mr11703273b3a.71.1784533000555;
        Mon, 20 Jul 2026 00:36:40 -0700 (PDT)
Received: from ubuntu24.. ([216.23.123.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcaa0bsm5210536b3a.20.2026.07.20.00.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:36:40 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add mbedtee
Date: Mon, 20 Jul 2026 15:35:55 +0800
Message-ID: <20260720073558.799755-2-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720073558.799755-1-xing.xl.loong@gmail.com>
References: <20260720073558.799755-1-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.50 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.50)[91.67%];
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
	ASN(0.00)[asn:15169, ipnet:74.125.228.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.228.0:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[74.125.228.0:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[dt];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AAF7344E96
X-Spamd-Bar: /
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: CHEGPD76KXQ2TU6BIQSSQEIUPYNRIGMY
X-Message-ID-Hash: CHEGPD76KXQ2TU6BIQSSQEIUPYNRIGMY
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:08 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CHEGPD76KXQ2TU6BIQSSQEIUPYNRIGMY/>
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

