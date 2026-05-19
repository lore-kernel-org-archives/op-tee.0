Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E8DCD4F5B
	for <op-tee@archiver.kernel.org>; Tue, 19 May 2026 14:36:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2113B44358
	for <op-tee@archiver.kernel.org>; Tue, 19 May 2026 14:36:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VIZP8Azs;
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A81AA4328D
	for <op-tee@lists.trustedfirmware.org>; Tue, 19 May 2026 02:05:35 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bccb978bd9so23385875ad.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 18 May 2026 19:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779156335; x=1779761135; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XFGMV7mqlPtrUKnFCz1Two2EamH1z04Y7KnQTcbEHDs=;
        b=VIZP8Azskqdft4QgnYOTiurtwlQ1Ch+nJ30O16vViMsYAx0+simJits31ajxN8kbKw
         1wnZ/X4JA1AuWmYhGQ+sOh+Va3gYK0ytmrY5OhwfmUDfhIGL4Z3m9eGmShfu/UbzMcv0
         G6N7bO+DkeAKuXTPBCyt+/YrVZ53P3FPFmPZtneUeLf0dtPIPnlIWy26levIT/Fj3Q3l
         ZId3YQkSs9g7bMjJpJ/x2Asdzeb286ZyuRcD4XbfD8+kjAfJC+2geLs7xoQyxrHmvliV
         /lA+PhciTngWF2q1r1p9cG3h40/psUbPc8Dprn5pzOrBWBmUxCuun7aBKi5NPH4CdNvC
         WY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779156335; x=1779761135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFGMV7mqlPtrUKnFCz1Two2EamH1z04Y7KnQTcbEHDs=;
        b=cccEfuK4oClGvd8S9o7kpiE/FuEh7Y0IH9N5/F8fXSKGWnsJZbqLHwS35nH7hxzKZ2
         CX1gZH3EW2dNDnBvQl5W2dQ/6APtRmjYuCU8dUQzvF3OrlD1HIiV/LAAUJRj4EI2f8u+
         P739pALPf5gTLMZ2A31i/1BZINtX7uCqrEQ357Z+a4N8naSh5JsDYGZ1Mtssg8oib7Pe
         YERdkLSgozqa4uCN+K4XLt/LHzQObqL/ZaGRUFmfjI66KzHmtgY6UpfRhHmJ1ntnEgYi
         BtXUyiFt896TGWgeqyWmxfSqyqwEBxWgP4YCP5zDQ9fExjRzNGgZOiV+L8QuDyJZhTdh
         7RQA==
X-Forwarded-Encrypted: i=1; AFNElJ8vjaDBXK9CxFbefP3kc9hTMpMpQKA8n2vXTUoQABcX4f5cvc13GXaJ4IO14Ik7LMEd+IJm70o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxFVWjkEkQS/Y7tw42ZUto1ZXRG+sKn04BmLoIFQCTSv3rgwXVY
	pXMd3fwYfp0CHLQPBrvqxj8+WZFXxbraDm7PftdVi3bW8i3lRfhmGmwL
X-Gm-Gg: Acq92OHl8Cg3VIg2BxBD9Csb5Jl2iZDwPk+KuBfqXizXYTrSWpeor331iWVu06pn8DC
	DRwiUgxuoe4ZstUj7nVC9laqKsMj9qW8HdWkqm1egzasxRLUfoZ97/EdG656zaIPR6HDz0RF2Qw
	Wd+zirKJc7yKf+lmGGnIVhWBkdPJS5y3VUJCrjmZwsXZa5h7WgbG81noMWCXhc2h9ctkO0MUAz7
	UER1k9pli/EoUyHgWY9s7KAc3Scd+34l9Hq0STRq7K1NcKjve3pESGYjwjTrEJ/1CXh80Mdptdd
	yuF5Jn0sc9qt4wcAf56Dr97RgYzhicxLTWpTbKH0oYOZrlTJg5NjTMkRG9gj1MRhCTxJNcguMT9
	9WLoZvq9sYVi0fpKpBLFeVUn4fILMHXGKAvFvO6pugS+9hK1S89NU2H/ZqCfdekr5TYdT5PLd0u
	LFaJ7udazKJYY85u6P8Rq1qhBbrrk=
X-Received: by 2002:a17:903:388b:b0:2bd:8c03:2efe with SMTP id d9443c01a7336-2bd8c0334f8mr135999395ad.26.1779156334703;
        Mon, 18 May 2026 19:05:34 -0700 (PDT)
Received: from soyboi ([2402:8780:1073:dc10:22f6:2ac0:a51b:5d77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe7270sm163125925ad.50.2026.05.18.19.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 19:05:34 -0700 (PDT)
From: Robertus Diawan Chris <robertusdchris@gmail.com>
To: amirreza.zarrabi@oss.qualcomm.com,
	jens.wiklander@linaro.org,
	sumit.garg@kernel.org
Subject: [PATCH v2] tee: qcomtee: add missing va_end in early return qcomtee_object_user_init()
Date: Tue, 19 May 2026 09:05:28 +0700
Message-ID: <20260519020528.133623-1-robertusdchris@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.214.181:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.181:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[2402:8780:1073:dc10:22f6:2ac0:a51b:5d77:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A81AA4328D
X-Spamd-Bar: --
X-MailFrom: robertusdchris@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: DTCP3JCK3YILBXMTN5O5NZ2L43THE4LF
X-Message-ID-Hash: DTCP3JCK3YILBXMTN5O5NZ2L43THE4LF
X-Mailman-Approved-At: Tue, 19 May 2026 14:36:17 +0000
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, me@brighamcampbell.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DTCP3JCK3YILBXMTN5O5NZ2L43THE4LF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

qcomtee_object_user_init() is a variadic function and when the function
return because there's no dispatch callback in QCOMTEE_OBJECT_TYPE_CB
case, there's no va_end to cleanup "ap" object initialized by va_start
and that can cause undefined behavior. So make sure to use va_end before
returning the error code when there's no dispatch callback.

This is reported by Coverity Scan as "Missing varargs init or cleanup".

Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
v1 -> v2:
- Use "break" statement instead of "goto" statement. There's va_end
  outside of switch-case, so we only need to go out from switch-case
  instead of using a label (suggested by Amirreza Zarrabi).
- Add "Reviewed-by" tag from Amirreza Zarrabi.

v1:
https://lore.kernel.org/all/20260513091031.145826-1-robertusdchris@gmail.com/

I don't have the device, so I am not sure how to test this change.
Thank you.

 drivers/tee/qcomtee/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index b1cb50e434f0..60fe3b5776e3 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -306,8 +306,10 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
 		break;
 	case QCOMTEE_OBJECT_TYPE_CB:
 		object->ops = ops;
-		if (!object->ops->dispatch)
-			return -EINVAL;
+		if (!object->ops->dispatch) {
+			ret = -EINVAL;
+			break;
+		}
 
 		/* If failed, "no-name". */
 		object->name = kvasprintf_const(GFP_KERNEL, fmt, ap);

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.54.0

