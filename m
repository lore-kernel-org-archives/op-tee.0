Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C454606A32A
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=ZNYwqj7W;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCGACtfj
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E280A4553D
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795137204;
	bh=HPMyAG+qNaJVDKdur4aqEAcgKR/IJArFbpyzF9kyIkc=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=ZNYwqj7W/DsnMRH4gjzil9x4Lh/UngrJPGI1bL+4rF8XrQQlU4wZkbpTtN6fZxJV0
	 nwMx5ajkeHNo7uayTPBlbEE1311eDpbbiAQWmzqPAZbmqhxItTLwEWOxTGctJGHb+s
	 uR+mWTGaSjA/d/pGTb1ZYUWS8r2BrSCQr2MRlChae4xG3lAgMKwxuKlxc6i4oaZHrB
	 Q6o71ApCTFHVD2UXvPpv9BPpF9yTY8cq6qDoJggASjNwSz8Qsngz0YziQqUAr8ex/W
	 tCXQ0lI4RevfSlyUmprV9Inchx1z5whlJxazkCWdDtU2rLkczcTs7YwXLW1a2UZREz
	 yfFcYGOya1wZw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 15E3C44F11
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 01:13:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCGACtfj;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4984F40284;
	Fri, 20 Nov 2026 01:13:17 +0000 (UTC)
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795137197;
	b=fmi+w6w1aSQzn1OBN+5yVKl1uPURvWhd3A5KxPUpdKNxh+ToOnJAglhNGIIQCWfh+5nV
	 zb6NN8Qox838nCcAd+GXp0+rcpya6jJb83vl9tdVWugMGVx5N4gIW3J3+lwdg0iFFBSLH
	 fuZY3C4giJxPErjwKZNWRfHV+ASsDW6xweE3jW0DUbm9E1yz7h+kVmT+r1WzMB0MO0ogT
	 cMe33vEEZN8Xm9HwOSdS+9fzPz13rhnhpSHrxLMUMkeXMXvIsgAqbEqWrxmPnjw9XejzN
	 ucRLmk4zIM+kXGaQ5dVbRoj4GSm1VbAnoXujeGssGsuntNrNQCpmmZ0AlumpGHelHkQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795137197;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0Sd6i+zrFVYtSL2eAJrD9qXfzhUKkx6ndMdVVrjruSY=;
	b=O8X6A2ivBp6IV3R4UTJB7BpelsF2RmvFUb5RfXmcA5VEU5xBxw/3OaCibdP+OqKkpLUR
	 7gXypJJu6emXUfhVvJpZiYYkHH9TyvYpil5y7XnKIWV6vFbcrcWYTFCaY4uq3p+RLWuZR
	 j1fDMDc76pYndIBz18YHuEVilzZ8OhrX2TmG8RDeEHrCIdsh5V3YrTi0A/EGRtmow0AFM
	 XQATnpwwoAy73Pwb9mXcwwGcfXTExtLtHIHbO1tZVKWkDy1fZGJw86SENrfgIQFoJ4xIM
	 GGt82m/6MMimdI+MrvjcaJ9IF4w6bO8rzxWNBZ3vC1+qBveljUjfbi201L2Eh/rskJw==
ARC-Authentication-Results: i=1; smtp.kernel.org;
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A6E191F000CA;
	Fri, 20 Nov 2026 01:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795137197;
	bh=0Sd6i+zrFVYtSL2eAJrD9qXfzhUKkx6ndMdVVrjruSY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=PCGACtfjOqN3uwAUMZzTjIZWG4ks71DtrR2Eg/nclQynWhFw13N2w07rADvWsOLtg
	 fJjEUGhcANDq1z87sNaFQIovYe9vZteQ9ZTNIjZJe/+OqbwzCurZfEXsZ5mUOcbDKh
	 QCRHEnCguLFh6nTmDgZotI7cES8S/u949PFXt/v3rlXcoKGGZuZidK7IxIgLBas2JZ
	 iMA0Jg/JC68SFlNzswhzBKmBuSgLj47144YGSMn2ed2tgrCOALDECdrCrVUr1O0a0r
	 E3IN1tIekCYCOwbtBlYJliQ8jAcyPjPVsuwe79raiFdf27fvoK17NHkoJdewpcPE15
	 eNOldK/quj9AA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A217425FF;
	Fri, 20 Nov 2026 01:13:16 +0000 (UTC)
Date: Fri, 20 Nov 2026 01:13:16 +0000
Subject: [PATCH] tee: optee: check for the supplicant under supp->mutex
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-optee-supp-toctou-v1-1-d9a2bdea1c90@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTsJU6MGrmJcYPnRYUGbTmtMC
 Hen6PJbvLeSISmM+malhI+ahqVCTg3597C8wDpWk2vdVUQ6DjEDbCVGzsHnUHgcnL9MbXfDWah
 2MWHS7+95f/xt5TnD52NE27YDbTJKYnUAAAA=
X-Change-ID: 20261119-optee-supp-toctou-da2c5f097e31
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795137196; l=2397;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=r+DQHxCOjcjVvvLW4z3rrN6VNbrbMcD//gJUMsCvQXA=;
 b=irKeG1tS1xjH2e5wZixMtRgpxVJnRQ42nvZOXhZQvcCjRW+s/qZsKt4qjlzxguZIhsC7zCLaY
 M6C+ScbZGmkAimKTGANjsQOXkqKi7IURLIKJZ756ptsYLTjbLFW2Hkr
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[kernel.org:s=arc20260519:i=1];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[172.234.252.31:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[aiyengar1990.gmail.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FREEMAIL_CC(0.00)[lists.trustedfirmware.org,vger.kernel.org,gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[aiyengar1990@gmail.com]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 15E3C44F11
X-Spamd-Bar: -------
Message-ID-Hash: VUSDXCW65QR6UQI2GDNN6YEGU3APNNCI
X-Message-ID-Hash: VUSDXCW65QR6UQI2GDNN6YEGU3APNNCI
X-MailFrom: devnull+aiyengar1990.gmail.com@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VUSDXCW65QR6UQI2GDNN6YEGU3APNNCI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Arun Iyengar via B4 Relay via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: aiyengar1990@gmail.com, Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_REPLYTO_END_DIGIT,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

optee_supp_thrd_req() checks supp->ctx without supp->mutex. If the
supplicant is released between the check and queueing, a supp_nowait
request is queued after optee_supp_release() aborted the queue and
waits until a new supplicant opens. For in-kernel clients that can
be forever.

Do the check under supp->mutex, together with queueing the request.

Fixes: 42bf4152d8a7 ("tee: add supp_nowait flag in tee_context struct")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Found by Sashiko in its review of [1]; the race is older than that patch.
Tested on an Orange Pi 5 (7.3-based, KASAN and lockdep) with a test-only
2 ms delay between the check and queueing; 1242 of 2000 supp_nowait
requests stranded without this patch, none with it. A real
tee-supplicant was not tested.

Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed it.

[1] https://lore.kernel.org/r/20261115-optee-supp-close-v1-1-4e0b14f3a97c@gmail.com
---
 drivers/tee/optee/supp.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 06747e90c230..fd8d1f363f2f 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -91,13 +91,6 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	struct optee_supp_req *req;
 	u32 ret;
 
-	/*
-	 * Return in case there is no supplicant available and
-	 * non-blocking request.
-	 */
-	if (!supp->ctx && ctx->supp_nowait)
-		return TEEC_ERROR_COMMUNICATION;
-
 	req = kzalloc_obj(*req);
 	if (!req)
 		return TEEC_ERROR_OUT_OF_MEMORY;
@@ -109,6 +102,16 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 
 	/* Insert the request in the request list */
 	mutex_lock(&supp->mutex);
+	/*
+	 * Return in case there is no supplicant available and
+	 * non-blocking request.
+	 */
+	if (!supp->ctx && ctx->supp_nowait) {
+		mutex_unlock(&supp->mutex);
+		kfree(req);
+		return TEEC_ERROR_COMMUNICATION;
+	}
+
 	req->id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
 	if (req->id < 0) {
 		mutex_unlock(&supp->mutex);

---
base-commit: e21989d08e0d6abacfff71387d0cb36dd96a4079
change-id: 20261119-optee-supp-toctou-da2c5f097e31

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


