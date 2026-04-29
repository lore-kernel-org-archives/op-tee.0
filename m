Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C41FF886F
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 12:28:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A30B6434BC
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 12:28:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J6WlKOL4;
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3B68043AD6
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 11:32:26 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36132967e9bso1969882a91.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 04:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777462345; x=1778067145; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JA98kbaF7ZCUMxffJsHJMIKUESlBJZU7smNLRVDdx8=;
        b=J6WlKOL4Qmn3qPvoXQA98SfCEmprcbJTsQlNOcQcjCF0VoI9k1LOPwELRP3xYf1W1+
         +iAWGY90BHt9c12/sFr4+vQawCfPoPUYxtQ3dHZYjxZkYKGT0fss7jyUrULPdt+Icjco
         onXT5oQze28r4aV+Q87/CF5lqf+vRKnY/aPzzYte1JXw+Tk0VAgwa7Cj2QeaUOjbZNC0
         o2An/9HapacJQW2lS25yQOFWd5n5HlIShZs/PYynrplEUjengWj0bYH2oPR1s3Y1Ipmf
         EPrSSpyVG7y94U2eq74WOmFtL08Cw30sdaKqZjXjqpjgrJmX2KKmQocZdQEXQOWis0Gw
         5V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777462345; x=1778067145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JA98kbaF7ZCUMxffJsHJMIKUESlBJZU7smNLRVDdx8=;
        b=JgMG4bjAVaUCyDc84Ad1mGcsxP86lipg8bNQg3qkP2mpbXgHtmPPuVl2Umnptn3j39
         qHS45VCnbS7Hrc+p0O8zPZ21ymtzYxYvoo5t/+efftvbbeOfQXf0261KGh5PV+U4MEEQ
         YulYAmb8Fmfm+6p7dYNkXVh/wPhGv6oHKMorcvxUyuuueEXKau0Hbw0Ax4OJCAQux5p8
         YwIXOusQ5Q9m5hhGzwzqlAkuycRuyhbYIZlrOblTFOr7VjE3U2Y80eq2nS4qaGNKK8EK
         pQAUrkIFgYr5SnNPKqfFN4Rg38kUZcKqbzyK14TTI5Tu4Kjx9z9giuysQiVIrxfnMFFf
         0tRw==
X-Forwarded-Encrypted: i=1; AFNElJ/kGQ6swsXjgTLDBCOiBUUAgFK93LM0E8ItSmyPRDr5pCHIQPWAawNUXO0/BHU1deWSymBevN4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw2eYrR9Mxfidf5X4uGMmwa0fpp1tw3a43vVyBrWtWASAnIXEkn
	9j98EmLGyDUfJr12IcLWMQoTUZOZI+olJAZL597pTRL8/UUZlRJepXLA
X-Gm-Gg: AeBDietYDSQaM7ADh/FE/FemVq3fgo8ZNSqMYobrMKB9kLY27LtToz+m1bX+Y5XqQ/0
	63/Mh7JRoiaICxKPy/jLa/ug5cM3PUJNX9gV0ZUu0paxnohqOXGU5rdMGRK3I/sddIE+/jN65dV
	RlmhHQvNl2OEITFqge3VOQktzsapZlH0XJ5Y0s/mW+LZg6SavK6F1HPH6aO+Ca6ZJ+f7hJu30Ao
	UQZ4pC/+94t7Rg2rbylUINEFGk15efB+PGLl1tY/B1ypV3YUGv2F/u/Y4tNJwEZQ6+/O7xGOMnn
	41oJ97DtRs7KzwxZdC6viefjP0hpM9FXrqXHUNDW30S8tlUGVdXbVtYUcAQdpFm2cYYYgb70ifZ
	PITLXAEfdsG/Li9ySszgywaIzqR/yC+rBpiuJfyJ19iccoPP7xbpejw5TyJK701vI0bFaIcY9Ez
	q0SruoJntGry4f/ATNe6hsy+ZoA9hRxST78+irre4yVU5mtjxab7MK+rddV7vzBSfA
X-Received: by 2002:a17:90b:3fcf:b0:362:be3b:c8d4 with SMTP id 98e67ed59e1d1-36490ca796emr4239946a91.3.1777462345223;
        Wed, 29 Apr 2026 04:32:25 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a01818adsm3642281a91.7.2026.04.29.04.32.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Apr 2026 04:32:24 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: jens.wiklander@linaro.org
Subject: [PATCH] tee: fix missing shm reference cleanup in tee_ioctl_supp_recv
Date: Wed, 29 Apr 2026 19:32:19 +0800
Message-Id: <20260429113219.88452-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAHUa44E+b9SmT++XrrzSansAjMMhgxQLwCA-LmS-GMEugSmhSw@mail.gmail.com>
References: <CAHUa44E+b9SmT++XrrzSansAjMMhgxQLwCA-LmS-GMEugSmhSw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.54:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.54:from];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3B68043AD6
X-Spamd-Bar: --
X-MailFrom: q.h.hack.winter@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: WF5XTURH2Y3L7N3UZFACJMDK3CRMLESJ
X-Message-ID-Hash: WF5XTURH2Y3L7N3UZFACJMDK3CRMLESJ
X-Mailman-Approved-At: Mon, 04 May 2026 12:28:12 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, Qihang <q.h.hack.winter@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WF5XTURH2Y3L7N3UZFACJMDK3CRMLESJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

params_from_user() acquires tee_shm references for MEMREF parameters and
expects the caller to release those references with tee_shm_put() during
cleanup.

tee_ioctl_open_session(), tee_ioctl_invoke(), and
tee_ioctl_object_invoke() all do this, but tee_ioctl_supp_recv() only
frees the parameter array and does not drop any acquired shared-memory
references.

Fix this by using a common helper to release MEMREF references before
freeing the parameter array, and apply it to tee_ioctl_supp_recv() as
well.

Since supp_recv backends may update num_params, preserve the original
allocated parameter count for cleanup.

Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 drivers/tee/tee_core.c | 49 +++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index ef9642d72672..adad1ea8e31b 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -530,6 +530,21 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
 	return 0;
 }
 
+static void params_free_decref(struct tee_param *params, size_t num_params)
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
+	params_free_decref(params, arg.num_params);
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
+	params_free_decref(params, arg.num_params);
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
+	params_free_decref(params, arg.num_params);
 	return rc;
 }
 
@@ -822,6 +814,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
 	struct tee_iocl_supp_recv_arg __user *uarg;
 	struct tee_param *params;
 	u32 num_params;
+	u32 alloc_num_params;
 	u32 func;
 
 	if (!ctx->teedev->desc->ops->supp_recv)
@@ -838,6 +831,8 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
 	if (get_user(num_params, &uarg->num_params))
 		return -EFAULT;
 
+	alloc_num_params = num_params;
+
 	if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) != buf.buf_len)
 		return -EINVAL;
 
@@ -861,7 +856,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
 
 	rc = params_to_supp(ctx, uarg->params, num_params, params);
 out:
-	kfree(params);
+	params_free_decref(params, alloc_num_params);
 	return rc;
 }
 
-- 
2.39.5 (Apple Git-154)

