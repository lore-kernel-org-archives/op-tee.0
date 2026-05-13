Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AE5CD4851
	for <op-tee@archiver.kernel.org>; Wed, 13 May 2026 15:20:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A894644B07
	for <op-tee@archiver.kernel.org>; Wed, 13 May 2026 15:20:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gsLMJEd2;
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AC3444443C
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 May 2026 09:10:37 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3664df32e91so5266213a91.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 May 2026 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778663437; x=1779268237; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDkyCdkfOQyq4nl3ME+VrFeCYaGPzyVj4zyQTMVwELs=;
        b=gsLMJEd2rR0RP+1iZ1yANz5p3nX2jfI2L0K19CuEw+/7cmY/aw+a5aMDJtTwVaWaGw
         6sgek8Rwo3EzyFFvIQorw0pVT1sxtJIJNeoJxLnUdRee/IwIN4QGJMWllGxklQZh8hps
         E5gEyzEyqjWsxFs0Cz04tOba3et2P4lQf67JBQ4QLl03SNYu62cuNG1L4brqkXbvBsP0
         7M3DtgI+Imh9v1AMlFLSb7W/CB/YlcrYOrwtRrEeLIYBoBYCJmasmW7HkrUYslR4yX+3
         8WmU6DP76b6Q+vUCkWeobnrgeTdwZvB8rOWqQul7DzSx67o7zurLxeVFC7I56XFGFhMY
         r7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663437; x=1779268237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDkyCdkfOQyq4nl3ME+VrFeCYaGPzyVj4zyQTMVwELs=;
        b=QosiopYMEXXpsGpdi+9E3Jc51mLLogtHagSJOIoG0cCb0uKDcOgcwjN97Bv7vAR7pn
         N09Bv1bZ7ZrmfFAstpLPGB11J8HZyTHURG6POf0EvkatfcuM/G/r5TK2pyi97EqzUl4t
         zkQmnapEliSsTInEjoT2vVZpcAzW3q2OL30dmck97VY/ummCybi5N68O7/moNJmno8Pf
         aZNhBmEX42e9IsbIaT6FVrWH0gUsApauWZCSBm3IXRfh1FbPXgQ168duXq/KtMgk2wwV
         lck9MoniG9dzQbfP5TT+2ezDCQCtrNg/WngSyOnM1rG5s6q8qhv7EPP4qc5n5KrYBqwe
         ZNmA==
X-Forwarded-Encrypted: i=1; AFNElJ9nJDjLKZNWL3Jg9/i54yTJPdkFdnc4wgoXm8AhvzlCbdW0Jk1rf3Sefdir3proqjNUxiPj2CE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx7qJXv8X1M0BJnJFYZl+eWm30L3xI/tk/IPjk8wrMHaaiBenJs
	PbGtZT7zD0r9HvETAZpwVy/2UYZGSV/IYwYlZuQWAuIPlP/BJAf4UYw5
X-Gm-Gg: Acq92OGK61pXtjRvpS9niytXh3lIzUURkgQupa8Gzq1Cb8XNnGZcA6jrRrxV1i255Y2
	D566A7UuIlKJTKUbiY1TteSrBdj8LIIeu1EmrQZuMkVDyaqj4GdqaWEk8OixbGqE8+X6gmnbR/4
	mrDAiXeuylISpmB703dkTNHmuETOz1KxC/Lb83BsbRIvlVhtfqd1xMEQHXmMflA3fXQxaZF0sXB
	CUKjIB0nAWL9ZedqwDrHz9PTqBlHGp/T5W1M06PRWcK/BJ3RL3VcciJu0fB5TEwRhU3dhvdceFb
	71ERhBgh+xHgH0eQq9fX1ZJ30V9sXrEovDe+vBgzGbdD5xyd9UBDHmgAAgBOYqZRjBzmVjGDBKd
	fmJKhQ+8PHGyJJtD6mlPgFg1XRGsTsQ0VtINf6S1xKpqwZSGBaXbStEARGTiUO97lM+IavuQUiL
	mUi71G1vZww6D+xBDe8POHWt1NW1EiU/6I48StNw==
X-Received: by 2002:a17:903:3e25:b0:2b0:6a22:5165 with SMTP id d9443c01a7336-2bd2718bf33mr20560465ad.7.1778663436624;
        Wed, 13 May 2026 02:10:36 -0700 (PDT)
Received: from soyboi ([2402:8780:1073:dc10:22f6:2ac0:a51b:5d77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e66970sm160480945ad.56.2026.05.13.02.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:10:36 -0700 (PDT)
From: Robertus Diawan Chris <robertusdchris@gmail.com>
To: amirreza.zarrabi@oss.qualcomm.com,
	jens.wiklander@linaro.org,
	sumit.garg@kernel.org
Subject: [PATCH] tee: qcomtee: add missing va_end in early return qcomtee_object_user_init()
Date: Wed, 13 May 2026 16:10:31 +0700
Message-ID: <20260513091031.145826-1-robertusdchris@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.49:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.49:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AC3444443C
X-Spamd-Bar: --
X-MailFrom: robertusdchris@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: Q5TSLVPJB6R4GWN3H2F7GMWDB2X3IWXM
X-Message-ID-Hash: Q5TSLVPJB6R4GWN3H2F7GMWDB2X3IWXM
X-Mailman-Approved-At: Wed, 13 May 2026 15:20:38 +0000
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, me@brighamcampbell.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Q5TSLVPJB6R4GWN3H2F7GMWDB2X3IWXM/>
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
---
I don't have the device, so I am not sure how to test this change.
Thank you.

 drivers/tee/qcomtee/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index b1cb50e434f0..901a31e8201f 100644
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
+			goto out;
+		}
 
 		/* If failed, "no-name". */
 		object->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
@@ -320,6 +322,8 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
 	default:
 		ret = -EINVAL;
 	}
+
+out:
 	va_end(ap);
 
 	return ret;

base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.54.0

