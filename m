Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840FEC3ABDD
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:27:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C845A45B60
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:27:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ovMQ7NgR;
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4026345B75
	for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 15:24:49 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad53a96baf9so617448366b.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747754688; x=1748359488; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8qa5LXunNhsp8X5JiJZg17KZ//sKeVB/2pNQGhvC/I=;
        b=ovMQ7NgR55pfYJVWALmeg6y73JrDleIW7MBhQDlWg3qQrd3Tyh3fdeYHlXV5qRHOmV
         el1+crSjXTG2obLBDpO+M6uZ1AHRd+Jl34YDuADTD9PMuAmQosDeS3QV3LW9j9VngFAG
         8S+EnIBVTmd8NP93rTARLtqhVo0xt564zkNeafip2fcaPtYcikmmqaVbTQbIZS1+zOzY
         2Zrm/JEpZ1cGn0IaEgMoVraPOUAgqBUYeWijSZys5a8NChATik3r0srYyvJihrXpA3a4
         KUF0e0Xg2LEiTnaLoQDcSyp3PhlgoALNKnAIazHga8s1i8kOHEFS9JWqvB65Xoke+S4s
         hdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754688; x=1748359488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8qa5LXunNhsp8X5JiJZg17KZ//sKeVB/2pNQGhvC/I=;
        b=C9jvUbrt+U7WWAB4pB0wCR9COj4/erYIv6+uXr/oJ3p9H0ut8+1/lL6VBZmGoPv3B4
         iKgACWzDrU7y9THt3FZqxhXo/SrhluE/DksULWfwPVspb5/l4YjZmRReTqScr3K7P1Sv
         iDacm0DXr6qweU7Sf3/xyh7y4NyGzDoe1LbF9WimRZXoHhbn8GV/B5IykSxAzcZOkhaJ
         KTXbzWXyX1/idsuzNOUt/cjAkc5q/VimSDR2MIjBPOuAQYCFyZLXRdq+fpVVw7EynNF+
         MQidNRHcGI0HB7kyVOQfeEjK6YxdOyRbx7w38nGsUnl8U0ANrUfXK6OuBZfUz8Hm1NaF
         8cFg==
X-Forwarded-Encrypted: i=1; AJvYcCWbLMb1qVjl3/F/xblsVDDU4ZL7msF5Z3I+PK9/ZaEMVK4JSwIcDX08R7Qorm2Ku9avKGNPGWs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy0u8AXR7rtpofhETLFP62mPjSIoGNhl8S9RhtSyEvYX2cEc3e7
	VohXax4P//D3uu+LJUk+Sr9tm6KvwgZj5AzcbS24CnOnefnDKF5iAEO6bY+NVaM4P7duYQ==
X-Gm-Gg: ASbGncv0to+9tSbbmrGl8rxFMYwk1Xki3EKpU+oY2BWErAUIb1rjozomdYSQAn0b8ET
	hTZlUfXD+5xyTjvR7s5+qN94rwfNOyrphbuOaZozdt8qOs/6D6mqNsszcq2KhD2IXOq8uKHknNQ
	Yu6n+tjM3LlFkl54vJXkkj+90M72l4Yj9g9yDt+Y8Nil2TOjFrXUeFn05lZwAcqKWu0CMtB56by
	S7MmyZC0+aIChPblCyRbAw5uly1OY6bKYozsgXb+gHZ/Rjy3YmDShMf4EaCKJtcR4NvnC62S9Wk
	9XLqMPy7f3YxKxPa44Cuk98xNEdrhy7Pz0kyWJmupPbig5XeMpcCEKglc/MmkPHHvRveq9kkU4G
	6alKlzMZ6ABjNMINmDdTUi6kwRaqN
X-Google-Smtp-Source: AGHT+IEImWs7uqKgqwvSaXfZnMr4lkCq2x7vYsraA2w6nH//5aCKKG0iMBeBMIE3Nx+R/TgNxy5Nsg==
X-Received: by 2002:a17:907:970a:b0:ad5:72d4:85f8 with SMTP id a640c23a62f3a-ad572d5076bmr655367366b.60.1747754688101;
        Tue, 20 May 2025 08:24:48 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278257sm742608766b.82.2025.05.20.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:24:47 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 4/9] tee: refactor params_from_user()
Date: Tue, 20 May 2025 17:16:47 +0200
Message-ID: <20250520152436.474778-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520152436.474778-1-jens.wiklander@linaro.org>
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.10 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.45:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.45:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4026345B75
Message-ID-Hash: 4TK3KFZBJ5ETK7X46CN7MVSBWC3OREDA
X-Message-ID-Hash: 4TK3KFZBJ5ETK7X46CN7MVSBWC3OREDA
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4TK3KFZBJ5ETK7X46CN7MVSBWC3OREDA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Break out the memref handling into a separate helper function.
No change in behavior.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 94 ++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d113679b1e2d..5259b8223c27 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -353,6 +353,55 @@ tee_ioctl_shm_register(struct tee_context *ctx,
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
@@ -360,8 +409,8 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 	size_t n;
 
 	for (n = 0; n < num_params; n++) {
-		struct tee_shm *shm;
 		struct tee_ioctl_param ip;
+		int rc;
 
 		if (copy_from_user(&ip, uparams + n, sizeof(ip)))
 			return -EFAULT;
@@ -384,45 +433,10 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
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

