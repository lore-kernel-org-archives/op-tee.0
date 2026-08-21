Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12C9C5DF8C
	for <op-tee@archiver.kernel.org>; Mon, 24 Aug 2026 05:14:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B537244F8E
	for <op-tee@archiver.kernel.org>; Mon, 24 Aug 2026 05:14:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ONHXtcmb;
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C448043EBE
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 05:03:26 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso732824a91.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 20 Aug 2026 22:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787288606; x=1787893406; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FAQIFeKdsDioxUGJtAjD1TEqdlw3Fo0BSbJ+hyxm5bA=;
        b=ONHXtcmbyQljJG3cY7e32uZHjPOiqzBkuyNyXqgBl1fINEroEXqGJKyAD0tyw5Xh8L
         fSwq4vqIdMeE/wMtChvHYB4alc5pa7fSi/ClIKo0QPwW5QGGAmzHojz4gkoldsiimfGM
         APOXYZ1IBKeheDHMgX69UmOhJ8nkc5hjBK5eReGOQAXVgjADTQ+SEId7w/lOLnROA8aJ
         3iRT7/NFs5n6oBSf3BwwyI+7ZW4RGJ8n63Hc2Pq8Hrru2tfyx81UpYhhlXDF3d1KWj5p
         uiFuQEIm9/JJY/CYfdmewv1Lc/+4fiX02pBf2bDrgmaY7UL2Vh0l/yI7DRZrsJn+lWub
         SFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787288606; x=1787893406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAQIFeKdsDioxUGJtAjD1TEqdlw3Fo0BSbJ+hyxm5bA=;
        b=Lf9ceq+4Sv5Bq9GB7SiY3RS8xkQH5MyLlQbz0Q1UPe+nY5dlZXxJSPcWdHtEKOwNsa
         myQlNHrHYWZ/hvXYVqioSV/gJm55riz0jANtYP2KbGD/7BddHHQu7qHeB3oxhsK2sr5D
         eY3S0QXcOOsrs8YXYw2BF4FyE0Kwr2T3lQ39xx1s5P3/E/LCLi25AaG9ticz82FC/C7D
         YPbb5H9pHRNM6b2oSUuBORiuGQSAP0UD27jlSrukHBJwI3mdCIHXTjbfy87vrHiscBqF
         yv51DEcvf52fluUaMtC5i6XZAJwsHgnTxs9U9ahVgtvNbxzHJTFOgVUDjQ6dU+y2eR6d
         ykXw==
X-Forwarded-Encrypted: i=1; AHgh+Rqk1YOlqxQ2uTq6pFHU20839Z4i49HNpPOp788fuAm0NE+IW2u710EXlMjSIjfncQy99qmqmRA=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++l8/9wN1a044u3rI4VEkpDIDD3WX9TK9SmVlznHQVlQfJKPEVqA
	0pBflmXGDTn1TYlozh8IOVP42W1EbuY9WL210jcL+J7zwL5Qc58R5onl
X-Gm-Gg: AR+sD13xRU5u9B7pZUVHDgmOfTVjsBFr5MiMAZSiROQiI/3iguZJkkdQMf1YqFM1JEW
	GW6FnzHEA1uhGjGIQBGkUvriScmMt4Xf3O+VVqFfQ3yia+YYHOgU3+wkvIfGGZU4FQaBupQ73yL
	o12bRVIyhFXqEZk/FlwGJ3jaTPELrG2Z4aHb8r0jHd8o/NR/XN9XXf+gUvzxsd4CEEfLLoJ3W8c
	9zEGmrl/54aI/GfOiViwubZv4MVSloUgMcRGdep9qhsj/+q/ZJAST8iFf7AgBD8SNElIL+ENJLP
	3nwHbT/bWxlVfnL6bmy2jzLQt7NGKAth8sLLajrRggIihWmLd4dbFcdGOtsFBcfh1XWfO9qntGd
	GBeMtKPa4eBUtDqi9HnDnFKE7siKllI9QF/veNaB/DPbF/kNB0vLj0KP62xWWUwG+cFLBfQkuoG
	hYxCARD8TQirA6e+A/a8R1RITBgTtoa0bv53FXvT1e03nsthHBHCMj1oUOcQQwdg==
X-Received: by 2002:a17:90b:54d0:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-395c35188fcmr7567404a91.1.1787288605580;
        Thu, 20 Aug 2026 22:03:25 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4baa594sm1511835a91.17.2026.08.20.22.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 22:03:24 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v2] tee: qcomtee: fix kernel-doc warnings
Date: Fri, 21 Aug 2026 05:03:23 +0000
Message-ID: <20260821050323.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.49:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.trustedfirmware.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.216.49:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C448043EBE
X-Spamd-Bar: --
X-MailFrom: bbnpreetsingh@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: NHGNU2APB7L4B2YHQGRTGD4HJQ42BJMP
X-Message-ID-Hash: NHGNU2APB7L4B2YHQGRTGD4HJQ42BJMP
X-Mailman-Approved-At: Mon, 24 Aug 2026 05:14:20 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Babanpreet Singh <bbnpreetsingh@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NHGNU2APB7L4B2YHQGRTGD4HJQ42BJMP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Fix kernel-doc issues present since the driver was added in commit
d6e290837e50 ("tee: add Qualcomm TEE driver"):

- async_release() documents its second parameter as @msg, but the
  parameter is named async_msg (msg is a local variable);
- struct qcomtee_msg_object_invoke documents member @ctx, but the
  member is named cxt;
- enum qcomtee_arg_type leaves QCOMTEE_ARG_TYPE_NR undescribed.

The cxt spelling is part of the QTEE message format and is used
throughout the driver; struct qcomtee_msg_callback in the same header
already documents it as @cxt, so the comment is corrected rather than
the member.

No functional changes.

Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5 [kernel-doc]
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
v2:
- add the Fixes tag Jens asked for; no code changes
- pick up Amirreza's Reviewed-by

v1: https://lore.kernel.org/all/20260802003956.7-1-bbnpreetsingh@gmail.com/

 drivers/tee/qcomtee/async.c          | 4 ++--
 drivers/tee/qcomtee/qcomtee_msg.h    | 2 +-
 drivers/tee/qcomtee/qcomtee_object.h | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/qcomtee/async.c b/drivers/tee/qcomtee/async.c
index 31bff4309e672..5849e51612033 100644
--- a/drivers/tee/qcomtee/async.c
+++ b/drivers/tee/qcomtee/async.c
@@ -97,10 +97,10 @@ static void qcomtee_get_async_buffer(struct qcomtee_object_invoke_ctx *oic,
 /**
  * async_release() - Process QTEE async release requests.
  * @oic: context used for the current invocation.
- * @msg: async message for object release.
+ * @async_msg: async message for object release.
  * @size: size of the async buffer available.
  *
- * Return: Size of the outbound buffer used when processing @msg.
+ * Return: Size of the outbound buffer used when processing @async_msg.
  */
 static size_t async_release(struct qcomtee_object_invoke_ctx *oic,
 			    struct qcomtee_async_msg_hdr *async_msg,
diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
index 878f70178a5b6..5d7b21fdd3688 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -112,7 +112,7 @@ union qcomtee_msg_arg {
 
 /**
  * struct qcomtee_msg_object_invoke - Direct object invocation message.
- * @ctx: object ID hosted in QTEE.
+ * @cxt: object ID hosted in QTEE.
  * @op: operation for the object.
  * @counts: number of different types of arguments in @args.
  * @args: array of arguments.
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index 8b4401ecad48c..d5de02dcef3b9 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -74,6 +74,7 @@ enum qcomtee_object_type {
  * @QCOMTEE_ARG_TYPE_OO: output object (OO).
  * @QCOMTEE_ARG_TYPE_IB: input buffer (IB).
  * @QCOMTEE_ARG_TYPE_IO: input object (IO).
+ * @QCOMTEE_ARG_TYPE_NR: number of argument types.
  *
  * Use the invalid type to specify the end of the argument array.
  */

base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
-- 
2.43.0

