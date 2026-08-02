Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF22DC55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:23:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0470D44E9C
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:23:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PpSzTQjR;
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F402244491
	for <op-tee@lists.trustedfirmware.org>; Sun,  2 Aug 2026 00:39:58 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38101f85591so2462221a91.1
        for <op-tee@lists.trustedfirmware.org>; Sat, 01 Aug 2026 17:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785631198; x=1786235998; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VqnWyY0IoOHm0/Ecjq9A3hxNF1K5JS+wTtKYz611nCM=;
        b=PpSzTQjRIOmxYxADHh0sng9LpAcxfkJtUR/qq73tu/aLE+9KFJJIuKXCCNp/r0OC65
         Ole/CqHubHuPSx79rXQMWD5yMAvsfmc8WnIs1GHNnDRKLiZnozv5yZ/LDQmsQ3IwJAG0
         dJSqTZUrtNBZLomgiE2cyUfUZ6QWIQ3WXLrVL/ZIaUKCX5HK9SOgmFVcclujH7pRctgF
         uP4stnVEEQ7Y+59aUuG1AN5TbaMaJP+eViQiNII7KdrBoeFKcWoZw0mS696yXkn+ZeCX
         7Gx/nI6HxAGDMPQwkwChx+yjWVsdCagZ+fFVweZnQLmPM6ckgGa/Zojp6QbR+VzJ9PBd
         QoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785631198; x=1786235998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqnWyY0IoOHm0/Ecjq9A3hxNF1K5JS+wTtKYz611nCM=;
        b=QqDrKQ4bQvvIOj+0q8IyyNr7BEkyeOlTIavn+x9dUfTvik+a6HHtwCapgOyhtLk5di
         ROzsHgWlD/7TwQGQqaCbYgQknXpF4O/vJ+xPCxIlqOfBWHYaSSq6cM4Gtw6n3Ody9x8s
         ZnJ7iM7AoUMGyH7KRDYGdqHt9QBlRnOXLzby/0y6f+/BLdXiN3jUyEHMGxeDEDdsu6DO
         LgX6UewEGcHZQDcbRdptfMgfWZcgv1vwq5mcKqYoDqhAi4yQdVAE6gbhuvMfi4RPUU87
         Iz+TwaLWYAY6EU/1LfxybiZxYlOnyYT60bQSS7vjiaBM8xPmLcPEv/i5ckrMEn518eh3
         1HJg==
X-Forwarded-Encrypted: i=1; AHgh+RpoLB+jCHtPS098z0870021kf3gRRbvlzz+XtakFE8Ya8o+uM/a7U7RxdVw8UzFA9AjXPkGJJ4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyW1f+8VKk9YSXr1X5x9j34h22PKijfrmj9EBKKD/KdXS7Vpcy6
	oUnr3qIpi98aDnz2R3Zq05BafNGNWt97lt7rEHrAli+hn4ypbrxzuK7g
X-Gm-Gg: AR+sD13Jc9aswq+uMp0AXFA7SVldWBkilrvX9N0UpYiXMscsrpbD9PhYJWhWhT2k/wk
	LiqlPlRAkBOhNfEpnrLsuT37pjblZHuy4XBBE2IaGfpoxdwE+W6V0DVVV3pt8FyOWoQUWVWQ0EJ
	RGqlZvVGKZ2HtXvydyo+SXUtf/qWuAeV8ik9+NVA+AHq1WyblGoaAPUUw6D8Kpe5KFFWJgpO3/0
	3L+s+gT0KPIGWfnhETnDHxk6ORPiZcNSZzJWrY2p4JeCaAtd/J2O/pXBVwlCSFSP4ORl+aXFIcT
	klrWVa1pEZDJ45Ca48U50JmXc6xrpz2ZwRQ3odp0sQOBoz+Sm3a9IiEEyn2n8mHsddZSjS1bPy/
	D4OKRUnG1wE6SPndtIf9EvSGeLYER444iKLcQ9h2ggFH6sLRb/c1TanwrtWrboX6sdO9IdxLgSX
	Jy2DakMPU68l9Pa3IUwlLM/WmPgK4n/ifgHTuJGLeEnrSaL6/kb5Qao1YjKLkN
X-Received: by 2002:a17:90b:5823:b0:38f:1a29:7a82 with SMTP id 98e67ed59e1d1-38fbca2363emr3552882a91.6.1785631197798;
        Sat, 01 Aug 2026 17:39:57 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2f657a1sm2318904a91.7.2026.08.01.17.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 17:39:57 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH] tee: qcomtee: fix kernel-doc warnings
Date: Sun,  2 Aug 2026 00:39:56 +0000
Message-ID: <20260802003956.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.47:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.trustedfirmware.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.47:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.904];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F402244491
X-Spamd-Bar: --
X-MailFrom: bbnpreetsingh@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: FMGI2WPL6XZ6GKF3PJDCLEFPBILQBREK
X-Message-ID-Hash: FMGI2WPL6XZ6GKF3PJDCLEFPBILQBREK
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:42 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Babanpreet Singh <bbnpreetsingh@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FMGI2WPL6XZ6GKF3PJDCLEFPBILQBREK/>
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

Assisted-by: Claude:claude-opus-5 [kernel-doc]
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
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
-- 
2.43.0

