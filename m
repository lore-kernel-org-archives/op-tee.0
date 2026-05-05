Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24042CD342C
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 06:51:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5E30F44E3B
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 06:51:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YqVcKc2y;
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0E26A43719
	for <op-tee@lists.trustedfirmware.org>; Tue,  5 May 2026 15:30:59 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae1255a90bso3626285ad.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 05 May 2026 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995058; x=1778599858; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFxD4yvGm/drPWf+CyREjTHAf+dc7Z5xe0nazxw0i0g=;
        b=YqVcKc2ynHDSZPnfD2EbqdeAsQZvG+1rsoijc7Bxcc+cJdNRkQs5uoVSzCCYtJ7Qal
         wsNH0VcuZDIMfzlwJ38JV0paVYq4LOORsOX2JtGZJLvOasdbAZ56risfscVOGROXrTBb
         Y2moSWQ689dyuRUJkiOR/pDQzafPX5AztqteutLXcIHPtFWopz1ueH8RylUwzz2G+LFP
         ydIY9SJiEs+J4AgMX5zXT9OuN49qKEwZrGta/zDfr0A9Ze5vEfPBr3o5GW4yFoCtJZgq
         XCrYaHOGa40OMG6wPCVXbe5BjSifpzgqUEYgAclXBv1+tESVtbVtiXkYwSOnmUW/Gmx5
         +dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995058; x=1778599858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EFxD4yvGm/drPWf+CyREjTHAf+dc7Z5xe0nazxw0i0g=;
        b=Da6CpDIKTlG2i9UJeZvnf6n/f0OMUrMcWehmO4h4gB9pjvj8SwZDUD3fgXXo0pYY6X
         lItE51TYT6c+50LRD3gBytyoWEn5OOSfV10a/XLl8iVtPePR6eud3PggswzEJEiNvTd7
         lmuQI3MzendGbHF9L6kgWYcSR/YyWOmvq0sYmpazQNw6YnCVIkV3lgtb9+r6O/4k+Lp3
         +2/DdNnGHlZXSENDhEYP6qPvX1XWBqSx5zKISucUKmun9NFXxUYiXJPzd/v+33CHIH+b
         NdSe6IDNd40+Fn2NZI4NT39nQ2GVD51kJhsDzqtBTZhjviif5coGFFq1IYV340Xjw38b
         0gAg==
X-Forwarded-Encrypted: i=1; AFNElJ9qXEokD3PRlx0Wp98ddGbLBCfeKPMjpxdOVnfTamkQ2ec56b+aZucM0Ryd5tris0IwO1S8FzI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxXKkQOYMP4HumVJYHcoIzH9QSLwNqqhi6PdURrWPDOt+GykOSU
	aUTaXOadyV4iIuaOZqqjNZdP4sMB1x5Nr1iBLh3wpPGnSja9nYYd6kFJxe6oPg+RO5k=
X-Gm-Gg: AeBDievoW28tIzCsUGbtcMRcLmUt7XVCmrMKkhGy8Yh3Wd2c5R/QRJ/t1YWj72sgRlI
	V3NY2U8eLiFzckHd1JuG63r3ZB2oiVrRCYOeMHb2TN8CMJcfHuqvd8TLjf4VOv4b3OpCQPcx08r
	LIdnNlDOasHXR79FD5SIA9q20Y0S7UHfvc5IySTUs15g34iRh1PaUNQc8LaaD4cmFp+dseh8Jvt
	iHTsWV49tqE27+fPQJaUyQ/xMEWu0dQ1n1Wp1lefM7h6u1nGvDfnTh66r/+5FJgMBdcfmBRU69J
	/z/ugN+7Yc43j1DOlwdfm9zNmagovvQBOh9YUgn1+y3lQuNCVSBRKsA2YFyyz2PPP5Ge2I7DBoJ
	Gk7RIE6X4ex0uiQHLBQxDsewcKoPrNWzorEO01qCXrJbIB81r1IFRSusHCwkjm3as8MLUOA9bpC
	xds6FF6ntVQRup6nByQhWqn5iCxXvEYM/BEhD2XKg6ks2Y996xj94XSIzGEqGsFRjukevx
X-Received: by 2002:a17:903:2284:b0:2ba:3376:2354 with SMTP id d9443c01a7336-2ba53e78f73mr17155245ad.5.1777995057856;
        Tue, 05 May 2026 08:30:57 -0700 (PDT)
Received: from localhost.localdomain ([14.150.214.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa91671sm141910895ad.13.2026.05.05.08.30.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 May 2026 08:30:57 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: jens.wiklander@linaro.org
Subject: [PATCH v2] tee: fix missing shm reference cleanup in tee_ioctl_supp_recv
Date: Tue,  5 May 2026 23:30:41 +0800
Message-Id: <20260505153041.17794-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <afS5XzaeLUx1ngAl@sumit-xelite>
References: <afS5XzaeLUx1ngAl@sumit-xelite>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,gmail.com];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[14.150.214.40:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.172:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.214.172:from];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0E26A43719
X-Spamd-Bar: -
X-MailFrom: q.h.hack.winter@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: PG4KMZ7IBS7G4UOXGY3TBLVLSW5GHGXD
X-Message-ID-Hash: PG4KMZ7IBS7G4UOXGY3TBLVLSW5GHGXD
X-Mailman-Approved-At: Wed, 06 May 2026 06:50:50 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, Qihang <q.h.hack.winter@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PG4KMZ7IBS7G4UOXGY3TBLVLSW5GHGXD/>
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

Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
v2:
- rename helper to free_params()
- drop alloc_num_params and use num_params directly

 drivers/tee/tee_core.c | 46 +++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index ef9642d72672..8cdf2ec7e74f 100644
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
 
@@ -861,7 +853,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
 
 	rc = params_to_supp(ctx, uarg->params, num_params, params);
 out:
-	kfree(params);
+	free_params(params, num_params);
 	return rc;
 }
 
-- 
2.39.5 (Apple Git-154)

