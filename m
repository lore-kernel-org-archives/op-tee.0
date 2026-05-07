Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8BBCD3427
	for <op-tee@archiver.kernel.org>; Thu,  7 May 2026 10:38:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D16A24499F
	for <op-tee@archiver.kernel.org>; Thu,  7 May 2026 10:38:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=egHZ6y8v;
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 55CAA43ECE
	for <op-tee@lists.trustedfirmware.org>; Thu,  7 May 2026 09:46:02 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-365f36d7b88so72268a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 07 May 2026 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778147161; x=1778751961; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23OKRGfJpGC2rilzuYD7D7RjEgXuSqZNvkx+S5yC1z0=;
        b=egHZ6y8vULrXGR4epclwei+f1Bdz52TbdSB/NJ3ELBD6RWrdt9v/BUsP38iVOKsOBF
         OtBAMRdCRBnCqo0MwFGGFiH5TyLPEPr+o0npaNxKTOHMzYdc7rlLyoB9eT3X1ehkCxz0
         Od3XS44sRbJ0PtYpMctrHR0qBUit/OuwkiENxrrD0Uboj+JfvyNGfEM1mVrenLizGjeE
         XpBsN+cSmmUm988g8bgStGtJPBdw5FVn3rbu44wkRJ5z3bICr6n4t/6Ons2aU2M3YhQE
         9bTftjFdEfw+bZKInH/PuAIpJyDAkQoA0prdx8uuszld8jUfpaTWouf8CmEbO19JXzTE
         nLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778147161; x=1778751961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=23OKRGfJpGC2rilzuYD7D7RjEgXuSqZNvkx+S5yC1z0=;
        b=NCXaE4cIMBn9v5e3TUFzt/Fok4RqSX94+hgxc8bArWGXKY3Bp+gmxQzjU8u21DmM3Q
         HsqfFJIOBHf+1MLiIhpb8gUc7bdx+NCxjRRwSDaP5XxjsIZKgsT5Z8BN2RWebApy69HC
         o34HzBx1gX4DvFzJPwDtBpZ9nnRG1Rzcd9MwV+W4ui1FGCQUvfYzK3IMXg8Mr7me1SIX
         ROny8cQiCE8XBIoN8sp11Hhc+o5tiMJN2x6yTP2Z2OA6zOhkJLfO5sLIdr85wpOuN/4k
         3ahVeN+joD3s9jPEGsgI8hlmZZ3TeNXhoWOuJIaiU7x0a3CBlnOd2Clo5y5OTVHz1HLw
         bI0w==
X-Forwarded-Encrypted: i=1; AFNElJ99Ytihc0pKJ4p4vGnatgSadt7yPR66UxX7s7fFVoLOnMF4k+gEEcj51ZVt74zbt/LTS1P41c0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwG1UpeYBoG+ekhWyCAG4sXm42ZsODmZLZ68oufj7iEOq8JBU+A
	1bItft+4phMRLbk40kne2Hxb3VFbzbz/D5t2JHB0rJglBd3NZRs6UPjb
X-Gm-Gg: AeBDievZLhmZ1JXVW4CuFqg/cIR+c3L0hWKWnubU2Nbbcthh8Jn2qSPuOpo5d6qZhKk
	7YQ/EUmXTT+Nufk35CcSepmEtLzVIiE8NXpaghWoTUNVxCWVGRK71U+0J9JG2jKXFmBv3hBikII
	MI5GntUclFxDQqvzkJ/rNU9/XnCBe2IzI4ytW/avwQPNIxJ7aRQGNpK3S5q+iw7cUfWP9Jtn8N1
	8KBw1ZPtBDDGWcs749bFjIhL9/TCgGftW2fmWQcoIqsQEaZ51xwgRwn3Kkv+rTHFTRcYlKVBSWA
	iY1j5ONI2GFcjRUKDxgG87bg71deaZNu8wLeGk/blAfSprQOoppajUK16kisaomC3liUBzquPLh
	y1+f3aOf1JYChJvfRZ5u55q+l6Kiv0LJApegagghW7uzaMp+z6MTT8qJrqLfi2iy+xUQ7DHkua9
	p15Zy9EkGc12txj6S5TSWbMAQw1nXl43QUjb97cV9ioaNf5yCwhLZNfLj9rP/IMqiH
X-Received: by 2002:a17:90b:3805:b0:362:bc7c:55cf with SMTP id 98e67ed59e1d1-365b4f8b04emr3727715a91.8.1778147161317;
        Thu, 07 May 2026 02:46:01 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3661d326f33sm657342a91.2.2026.05.07.02.45.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 May 2026 02:46:01 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3] tee: fix params_from_user() error path in tee_ioctl_supp_recv
Date: Thu,  7 May 2026 17:45:54 +0800
Message-Id: <20260507094554.66926-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260505153041.17794-1-q.h.hack.winter@gmail.com>
References: <20260505153041.17794-1-q.h.hack.winter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.48:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.48:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 55CAA43ECE
X-Spamd-Bar: --
X-MailFrom: q.h.hack.winter@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: P32GYPNWU5C7S5NF45GTOW6COMV5MMMR
X-Message-ID-Hash: P32GYPNWU5C7S5NF45GTOW6COMV5MMMR
X-Mailman-Approved-At: Thu, 07 May 2026 10:37:59 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, Qihang <q.h.hack.winter@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/P32GYPNWU5C7S5NF45GTOW6COMV5MMMR/>
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
v3:
- only free MEMREF references when params_from_user() fails
- keep tee_ioctl_supp_recv() final cleanup unchanged
- follow Jens' review on supp_recv() parameter ownership semantics

v2:
- rename helper to free_params()
- drop alloc_num_params and use num_params directly

 drivers/tee/tee_core.c | 54 ++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index ef9642d72672..2fd3a00b47c7 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -530,6 +530,21 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
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
+		if (tee_param_is_memref(params + n) &&
+		    params[n].u.memref.shm)
+			tee_shm_put(params[n].u.memref.shm);
+
+	kfree(params);
+}
+
 static int tee_ioctl_open_session(struct tee_context *ctx,
 				  struct tee_ioctl_buf_data __user *ubuf)
 {
@@ -595,16 +610,7 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
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
 
@@ -657,14 +663,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
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
 
@@ -716,14 +715,7 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
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
 
@@ -846,9 +838,15 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
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

