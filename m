Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92984CAC587
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 13:53:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C90B64FD90
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 13:53:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SO1eCIMp;
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4BD9B4FD81
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 13:50:37 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-72ce9790aceso5397027b3.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757598637; x=1758203437; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yi0r5nq64oj31QVOjln422OWaHa6DWnYy7B2T1z3rUg=;
        b=SO1eCIMpn919g+pVvbVOWwMREcnjMZbsgqnpWCXpMypK0FV2VprJS3mVhKYwCHk8ht
         wxm0pC5LwzPZd2KYmJJjR7/O3u158Tdpu+Gp9Yt5jYJewVyoFP7cRKKQiJx1fZS6VS25
         ZptVNSWM/wBFDAJW/tKNVondIKkRVhLtNCjEikcE5blOjhSjPxvko6MKhDWVSnEzMdV5
         IoeOkzxXG8IKP2QJMQJP+z9Xm31+5uGzXGrnThhFHJEpmtpyAnbDWTktLXNKUK7PMNbU
         5s2iIaVhgkSMGCeoGOogJ/izABx5Xurh1wPh0PlKa53NktB9o5lWEcpMTeBQIBVzakcW
         khBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598637; x=1758203437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi0r5nq64oj31QVOjln422OWaHa6DWnYy7B2T1z3rUg=;
        b=Oh+V1okR+PBsswpT2uPXfM4UQdGEn/TBU4y/+YOAcX73o1h2bClZbxojzEBAWXFJhv
         sMfcdrCpw5+lMf8V+eAJOJ7mP7GFWPAdw6ph1A4UERTakuRoxtPic8RYpW0YYHtubjqm
         tR6tLvPilh73K/d5PY2Be0uyzVNUGmElfqcN+kmi3O/wDIngow9QF37xD57ydil3xYbe
         O0lP5kcXD+p4faUydAHBm34P9TqXcEQ4hs1Ni0ly+OEtX95D8R0EWXWhzeBGWEUBHXZp
         WM0ZC3FKy2IuAKRjoyx+8BAQAY5XMkp9XeXbJlJIv8tIel3f4QmYecJiM8sQesJsQY37
         OFag==
X-Forwarded-Encrypted: i=1; AJvYcCV3fMAk2cBi1S7k91xlOlohuf0VweInl7mO8W1SQTlfxr6QwJEyy5nWDOZWF2AW3Oh+bqa5sFk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzIi5Up1rBlL99/baHAFYxc883QqUUn3uZbzz5d+CzatdvnIs7M
	WvJNMLavbaEZTs1qL63NQE/0tg99yRaQgZxCW+4/713ZbFadF5aSzOT2uBS1XCR3F7qzCw==
X-Gm-Gg: ASbGncvMU1v/918i5J7MvVyMXlT+MX79apWhC9kiF5xAiK2rzu9v7OTqV5snGhCstH9
	Z7mOVPDI4PsaEsxG6sUAmES5VBxfOdLkOCt96Uy9yrhgj/PTKBscvmax8iERha/pPWQPpZrrwbH
	FKpCWFZ4DOYh0F8l+PDtUwWTz+IZ4Mq87Z5my/m+GqP0VAkeTMP3JWdeBpDPGb9ulDILzOK08zg
	tNwBfWMkBPXMvCfHjEtsjqEO6j6cE++M7Bg5HYulX8hxcGWD+HlQgVs5JGh5laV26FW4FNU1O5x
	b9MGekzZLsr8En/py5rX3YyderOEAb97SiWAr1bg73ZCSCxUfy01l2eFhxjiAZ6cFBPh18paX9G
	7N7xDWzRo5j2dVXyNbHc3cLce4qBCjMpNtesb5AnwkDSviKkeedMVmYGcMPUEOw7gdzgV0/x9D4
	mzVp9caHGDZA==
X-Google-Smtp-Source: AGHT+IFhFq5K/L+li5E/fnG6u0IEPzqvQNG67ywCbR49sqE1DlYxZ0kS6UjsMtnPo2ezjd7bDqomGA==
X-Received: by 2002:a05:690c:62c1:b0:726:76f0:4b89 with SMTP id 00721157ae682-727f505434fmr181457897b3.22.1757598636586;
        Thu, 11 Sep 2025 06:50:36 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7623434csm3526257b3.11.2025.09.11.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:50:35 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v12 4/9] tee: refactor params_from_user()
Date: Thu, 11 Sep 2025 15:49:45 +0200
Message-ID: <20250911135007.1275833-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911135007.1275833-1-jens.wiklander@linaro.org>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4BD9B4FD81
X-Spamd-Bar: /
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[37.123.177.177:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.176:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	NEURAL_HAM(-0.00)[-0.999];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.176:from];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: OHXP4WH2OZK2EQSW4GTES7M2O6XYZRV7
X-Message-ID-Hash: OHXP4WH2OZK2EQSW4GTES7M2O6XYZRV7
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OHXP4WH2OZK2EQSW4GTES7M2O6XYZRV7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Break out the memref handling into a separate helper function.
No change in behavior.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c | 94 ++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 2411d1e2aa7a..4996f194cd9e 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -354,6 +354,55 @@ tee_ioctl_shm_register(struct tee_context *ctx,
 	return ret;
 }
 
+static int param_from_user_memref(struct tee_context *ctx,
+				  struct tee_param_memref *memref,
+				  struct tee_ioctl_param *ip)
+{
+	struct tee_shm *shm;
+
+	/*
+	 * If a NULL pointer is passed to a TA in the TEE,
+	 * the ip.c IOCTL parameters is set to TEE_MEMREF_NULL
+	 * indicating a NULL memory reference.
+	 */
+	if (ip->c != TEE_MEMREF_NULL) {
+		/*
+		 * If we fail to get a pointer to a shared
+		 * memory object (and increase the ref count)
+		 * from an identifier we return an error. All
+		 * pointers that has been added in params have
+		 * an increased ref count. It's the callers
+		 * responibility to do tee_shm_put() on all
+		 * resolved pointers.
+		 */
+		shm = tee_shm_get_from_id(ctx, ip->c);
+		if (IS_ERR(shm))
+			return PTR_ERR(shm);
+
+		/*
+		 * Ensure offset + size does not overflow
+		 * offset and does not overflow the size of
+		 * the referred shared memory object.
+		 */
+		if ((ip->a + ip->b) < ip->a ||
+		    (ip->a + ip->b) > shm->size) {
+			tee_shm_put(shm);
+			return -EINVAL;
+		}
+	} else if (ctx->cap_memref_null) {
+		/* Pass NULL pointer to OP-TEE */
+		shm = NULL;
+	} else {
+		return -EINVAL;
+	}
+
+	memref->shm_offs = ip->a;
+	memref->size = ip->b;
+	memref->shm = shm;
+
+	return 0;
+}
+
 static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 			    size_t num_params,
 			    struct tee_ioctl_param __user *uparams)
@@ -361,8 +410,8 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 	size_t n;
 
 	for (n = 0; n < num_params; n++) {
-		struct tee_shm *shm;
 		struct tee_ioctl_param ip;
+		int rc;
 
 		if (copy_from_user(&ip, uparams + n, sizeof(ip)))
 			return -EFAULT;
@@ -385,45 +434,10 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
-			/*
-			 * If a NULL pointer is passed to a TA in the TEE,
-			 * the ip.c IOCTL parameters is set to TEE_MEMREF_NULL
-			 * indicating a NULL memory reference.
-			 */
-			if (ip.c != TEE_MEMREF_NULL) {
-				/*
-				 * If we fail to get a pointer to a shared
-				 * memory object (and increase the ref count)
-				 * from an identifier we return an error. All
-				 * pointers that has been added in params have
-				 * an increased ref count. It's the callers
-				 * responibility to do tee_shm_put() on all
-				 * resolved pointers.
-				 */
-				shm = tee_shm_get_from_id(ctx, ip.c);
-				if (IS_ERR(shm))
-					return PTR_ERR(shm);
-
-				/*
-				 * Ensure offset + size does not overflow
-				 * offset and does not overflow the size of
-				 * the referred shared memory object.
-				 */
-				if ((ip.a + ip.b) < ip.a ||
-				    (ip.a + ip.b) > shm->size) {
-					tee_shm_put(shm);
-					return -EINVAL;
-				}
-			} else if (ctx->cap_memref_null) {
-				/* Pass NULL pointer to OP-TEE */
-				shm = NULL;
-			} else {
-				return -EINVAL;
-			}
-
-			params[n].u.memref.shm_offs = ip.a;
-			params[n].u.memref.size = ip.b;
-			params[n].u.memref.shm = shm;
+			rc = param_from_user_memref(ctx, &params[n].u.memref,
+						    &ip);
+			if (rc)
+				return rc;
 			break;
 		default:
 			/* Unknown attribute */
-- 
2.43.0

