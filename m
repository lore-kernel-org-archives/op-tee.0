Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4BACD37B7
	for <op-tee@archiver.kernel.org>; Mon, 11 May 2026 06:22:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1AD6343EBC
	for <op-tee@archiver.kernel.org>; Mon, 11 May 2026 06:22:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jb0ztwN1;
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3A3B643EAF
	for <op-tee@lists.trustedfirmware.org>; Thu,  7 May 2026 15:39:30 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-365cad57764so133421a91.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 07 May 2026 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778168369; x=1778773169; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tWvywBrF1EYh8x1X84gr6TDP4fPRzp9joH89hLUW9U=;
        b=jb0ztwN14ZOdZsa2fkVmVC4R8KeJr3pjlMZt65dfouN8PVx9J5klJ0fCzxV2jpttSY
         P1536CSakrB5ayMj7qOpElsTl8rMcDmcN3rtSPKbhquozhfx83RMLGvq2DteQvD19YAw
         r4X4K6VM2zqht5MXRrOU0UsxK1WcKeq0HeTo1H1qiQbc1FHUdbPt9iJGtfVkRyTnYTg5
         Cz3g8o8zDwnbga5Iu4KB+SLrqkLdOHAJ0wG23YRwsiCytwRWmujGYzTrDGG8dICRzv0t
         MJ427TzDu1m7YxzecUvCs9Mo8E22A6ZWocBPuW3bjQ5lglzyiClBP4dWCxLhN9iITaCT
         mAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168369; x=1778773169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0tWvywBrF1EYh8x1X84gr6TDP4fPRzp9joH89hLUW9U=;
        b=o9ieWZ4Vfz5zlLWTBiniV2UB3Risu9l4gyZe8CzmVc56EgV8p9upau5iTChyIXTPSb
         KUvmFaCnXfdaDWqpElhVG5QF3J37SFtHMjDhFNAVtl/uu8mvtR27PpbcE48JQMpMWXUC
         63tRKnpXhU6z2utx1xg+eL59N27kAKHNX6/0CeV8bkRah3PUn3N12EYq59B7T/5jZOnS
         yzdO4yFPir77JmnK2jmLO3JBSKAIS3LAVx2n/t5hYzbyvPDdHA4LbTsihkPCzFa6WR1q
         M7If0xmpATE3INpRm/+akGlOnAPeeRip5xPq6DRrh9BH3scK98ZsDPHKxiM6KOXehXuY
         eiJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FZB55PBTcxFwVwhlEqthbpF4dx+iYo8df1y3HZxDXQGZsfIyv/jHgVxtUCCVaHWPHfJKrx1Q=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yywa9FkppVwdUdrqlFUUXnB7gNtoE+/zAeBis5X/k5k5W23YYOu
	YJjKbiK4jtw4icLorCS0+qwoFiRsnIZ0+TYnAseTCKjr7cR4tzWmYAKS
X-Gm-Gg: AeBDiev4hj8s4oPHlIMjaGvZd2JyveVz+f4yaZXyuYhtdLwf/+2nO/Wwkzbmf/eBb/7
	6rDUmNcq8p14dnlf81sA/u83jc+iWyTYIvfwg3zEA10Mlj3JClNUhJSq/nMcBhMnOBtG5GIx6br
	TLT6ElfRxZBeIzAHX2sA5JIl6J7Zvw/2L9GqacEKFgnlGKcTyY0BSJlX9aod3NuQhAHX2yD1O6r
	m1n1S3P3HK+wq4jZDtSoFNXNf7Lz7mxlrxOLGy9Xm1fN/N5d96AUNyfPP5U1dhUeVgrRJgsG2hg
	d5mL07IBsK+DQXVoe8kqHSSDnZXMrADmEQdU144UX36HlM3eZ9185YbX6e4Y/z/hqMlvwZSpRps
	OysGn5BgyKH/QZ/4+qIxPOJlGA1fktHrwKVoa8WVaspHUP54zhBU5VTKdNRVJqLbb2DjsxEKbIL
	GJnBhLs1pfI4EmCByel3bvnU8FJCFVHNcFSuNiEXWePf73ZI7G7JxFlu5lCcZe82BDj3l3G0PKK
	+w=
X-Received: by 2002:a17:90b:e0f:b0:366:1149:5d42 with SMTP id 98e67ed59e1d1-36611496604mr1082447a91.3.1778168369163;
        Thu, 07 May 2026 08:39:29 -0700 (PDT)
Received: from localhost.localdomain ([240e:47c:d8d0:4133:acaf:669d:2caa:f1cf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b12a1eddsm4043797a91.6.2026.05.07.08.39.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 May 2026 08:39:28 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4] tee: fix params_from_user() error path in tee_ioctl_supp_recv
Date: Thu,  7 May 2026 23:39:17 +0800
Message-Id: <20260507153917.73532-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260507094554.66926-1-q.h.hack.winter@gmail.com>
References: <20260507094554.66926-1-q.h.hack.winter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.49:from];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.49:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3A3B643EAF
X-Spamd-Bar: --
X-MailFrom: q.h.hack.winter@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: L5XOFGWSZMHQWXDWED6FXWENO4SFWEL4
X-Message-ID-Hash: L5XOFGWSZMHQWXDWED6FXWENO4SFWEL4
X-Mailman-Approved-At: Mon, 11 May 2026 06:21:56 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, Qihang <q.h.hack.winter@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/L5XOFGWSZMHQWXDWED6FXWENO4SFWEL4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

params_from_user() may acquire tee_shm references for MEMREF parameters
before failing after partially processing the supplied parameter array.

In tee_ioctl_supp_recv(), those references are currently not released on
that error path.

Fix this by freeing MEMREF references before returning when
params_from_user() fails.

Keep the final cleanup path in tee_ioctl_supp_recv() unchanged since
supp_recv() may consume and replace the supplied parameters, unlike the
other TEE ioctl callback paths.

Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
v4:
- fold free_params() memref check onto one line
- remove unused local variables left behind by the cleanup refactoring

v3:
- only free MEMREF references when params_from_user() fails
- keep tee_ioctl_supp_recv() final cleanup unchanged
- follow Jens' review on supp_recv() parameter ownership semantics

v2:
- rename helper to free_params()
- drop alloc_num_params and use num_params directly

 drivers/tee/tee_core.c | 56 +++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index ef9642d72672..1aac50c7c1de 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -530,11 +530,24 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
 	return 0;
 }
 
+static void free_params(struct tee_param *params, size_t num_params)
+{
+	size_t n;
+
+	if (!params)
+		return;
+
+	for (n = 0; n < num_params; n++)
+		if (tee_param_is_memref(params + n) && params[n].u.memref.shm)
+			tee_shm_put(params[n].u.memref.shm);
+
+	kfree(params);
+}
+
 static int tee_ioctl_open_session(struct tee_context *ctx,
 				  struct tee_ioctl_buf_data __user *ubuf)
 {
 	int rc;
-	size_t n;
 	struct tee_ioctl_buf_data buf;
 	struct tee_ioctl_open_session_arg __user *uarg;
 	struct tee_ioctl_open_session_arg arg;
@@ -595,16 +608,7 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
 	 */
 	if (rc && have_session && ctx->teedev->desc->ops->close_session)
 		ctx->teedev->desc->ops->close_session(ctx, arg.session);
-
-	if (params) {
-		/* Decrease ref count for all valid shared memory pointers */
-		for (n = 0; n < arg.num_params; n++)
-			if (tee_param_is_memref(params + n) &&
-			    params[n].u.memref.shm)
-				tee_shm_put(params[n].u.memref.shm);
-		kfree(params);
-	}
-
+	free_params(params, arg.num_params);
 	return rc;
 }
 
@@ -612,7 +616,6 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
 			    struct tee_ioctl_buf_data __user *ubuf)
 {
 	int rc;
-	size_t n;
 	struct tee_ioctl_buf_data buf;
 	struct tee_ioctl_invoke_arg __user *uarg;
 	struct tee_ioctl_invoke_arg arg;
@@ -657,14 +660,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
 	}
 	rc = params_to_user(uparams, arg.num_params, params);
 out:
-	if (params) {
-		/* Decrease ref count for all valid shared memory pointers */
-		for (n = 0; n < arg.num_params; n++)
-			if (tee_param_is_memref(params + n) &&
-			    params[n].u.memref.shm)
-				tee_shm_put(params[n].u.memref.shm);
-		kfree(params);
-	}
+	free_params(params, arg.num_params);
 	return rc;
 }
 
@@ -672,7 +668,6 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
 				   struct tee_ioctl_buf_data __user *ubuf)
 {
 	int rc;
-	size_t n;
 	struct tee_ioctl_buf_data buf;
 	struct tee_ioctl_object_invoke_arg __user *uarg;
 	struct tee_ioctl_object_invoke_arg arg;
@@ -716,14 +711,7 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
 	}
 	rc = params_to_user(uparams, arg.num_params, params);
 out:
-	if (params) {
-		/* Decrease ref count for all valid shared memory pointers */
-		for (n = 0; n < arg.num_params; n++)
-			if (tee_param_is_memref(params + n) &&
-			    params[n].u.memref.shm)
-				tee_shm_put(params[n].u.memref.shm);
-		kfree(params);
-	}
+	free_params(params, arg.num_params);
 	return rc;
 }
 
@@ -846,9 +834,15 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
 		return -ENOMEM;
 
 	rc = params_from_user(ctx, params, num_params, uarg->params);
-	if (rc)
-		goto out;
+	if (rc) {
+		free_params(params, num_params);
+		return rc;
+	}
 
+	/*
+	 * supp_recv() may consume and replace the supplied parameters, so the
+	 * final cleanup cannot use free_params() like the other ioctl paths.
+	 */
 	rc = ctx->teedev->desc->ops->supp_recv(ctx, &func, &num_params, params);
 	if (rc)
 		goto out;
-- 
2.39.5 (Apple Git-154)

