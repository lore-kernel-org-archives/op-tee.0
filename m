Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556D2CCFA05
	for <op-tee@archiver.kernel.org>; Thu,  6 Nov 2025 11:03:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 876AD4FEB4
	for <op-tee@archiver.kernel.org>; Thu,  6 Nov 2025 11:03:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eNWRhiWG;
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1335843077
	for <op-tee@lists.trustedfirmware.org>; Wed,  5 Nov 2025 14:20:36 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so6571350b3a.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 05 Nov 2025 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762352435; x=1762957235; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKHHVea8wTIQH463SPis4pm7eX04G+ekedJN9dG7siI=;
        b=eNWRhiWGL7aLUQjray/s33gn3ZEG5Ktio7tts3v+2JFgfDN7tWPoaflFlX4Z2I6/1+
         48R80hNAVGH1bxgvCFPuzADajLkvI/o1JNlbPCGv1P4bZ/r79groqxPrzO5uG1oT3hLH
         JSPDP8lkEb8lBQnl2sca4aY/sesMqRCE2IPXut7TAEoRCQkWobFwESIsUiSu7qlIgO67
         EVl87FbWGtBffLhBGGcUJk/LDtKxIWyruzR6E5wJzmwF6A+3qrWTiXrY6Lna0weajCZp
         5KZM3jddmRzIY7m1w+xcrvP3g3c8ICe6OGewnCuqXnssy4PDG83XH2GxBJ1KmJJMQ1t2
         COKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352435; x=1762957235;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKHHVea8wTIQH463SPis4pm7eX04G+ekedJN9dG7siI=;
        b=UIQFLkA3hB5GerpSMEGtMIgjTJvZkXyBBeV9/tK0pvpjBEkZKUEkQ37s1qxsWMtKtT
         Z3ZLVbJ/FJPD9K7iXOLCun+aiQdTXSllDmhwqKNaoQRhhgC0yZHSlS+w7YGeR2jP5XQ8
         bDdfm8qFROqwtghpiVS3EaKNaXuaytLVkZ4nYWmEiFTx7bQpPV8ywj9Uz9bfst2uySPv
         rVVLmiifUwdz2ZJoYtAhso3Im2cOdF4s1VrDCTSw6UvRQY+/2CWlNl61muDwseM00Vvi
         0h7R8GGQfJemFEDwlTy89QXZ7bQjc0UK5WYdsbkeS/bqF6dbZa3qMkOcI+vNO13NSCsI
         IfKg==
X-Forwarded-Encrypted: i=1; AJvYcCWnsIJIACEdh+gWeD0aB/Qs/7N5LLlMNdr5KtgAgOnVqNLdC2yT50Ke2/Dw2Y1ZPkpjkKq0TuQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw82EmVfOz07RFAQFQQOoODuBgff3u1yscO2f/0oQHnxtcKF/BW
	0Tqi+twz2Ds+YgaJcCF+jCvBnNpv8CfpLNGnoS8VbZP9EtiFZqzlRjkn
X-Gm-Gg: ASbGnct6fdyO71QGegOBNjwYIFFBtTrRla/UcMySS0P75mY1LZJALWy2z7sO08l/l+Q
	uyYv/hpRGMQjxDUVsNaLwWLy53fcG5d5uYq0EgKxWeFdODn27HcQyNAtNwsAk5u5FyUqqa0fCkl
	pvIhKzO1PbRPUmSK0+XX86T5x3/U6JbEnwmAot2kcN6+tqB+mfX5uAqUYl5OZcIK1YyCbHeZxn9
	Ut2hQUZd+d8mvKWZ8f1neUh5kTjmarmn95XAAHrVzEepgLVyq+fZERmpyQFqD1QEhq4Od+f+T/m
	VR2sgn9eFhLae4bJqmM4Y9huq1H/5TWAAl/O5nZyLaArfEaJQOD45XdmgvVV+OLFkQEjrXHA54m
	t1rfPzjtAOB+pHY13lnOFH/V5JqmFXGbv07aZqvtcHnOumNIf3ShuxPnguUkinId6BKKdm8bBxv
	E=
X-Google-Smtp-Source: AGHT+IHzTTnPsxUzWsrmGxTIjfu7iWPk+D21UhbLo2AmmafmiFkrQxFxAHL2VAWLOH/Cs1o9hs8q3A==
X-Received: by 2002:a05:6a20:3d23:b0:342:1aab:4c71 with SMTP id adf61e73a8af0-34f839f5a40mr4658333637.4.1762352434947;
        Wed, 05 Nov 2025 06:20:34 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:1d39:8dd:58db:2cee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a67e2f82sm3198879a91.0.2025.11.05.06.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:20:34 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Wed, 05 Nov 2025 19:50:28 +0530
Subject: [PATCH] tee: fix uninitialized pointers with free attr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com>
X-B4-Tracking: v=1; b=H4sIACtdC2kC/x2NwQqDMBAFf0X27EKyNJf+inhY9FkXSpRNKkXx3
 xt6m7nMXFTghkLP7iLHYcW23CT2HU2r5hfY5uYkQVKMIbGuwMGfbNmq6dtOzLw4wFqrc20QRCI
 eCVNSodbZHYt9/49hvO8fhMJ3o3MAAAA=
X-Change-ID: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=2bydY0FEOcssCU3jumasSDa5bWFLWCHjfTYBtgqnKTk=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDK5Y/WKKr4yXPn5c0ZQ2G3bhTJfr3T2H+FlvFrzm+2UY
 VRb8fQlHaUsDGJcDLJiiiyMolJ+epukJsQdTvoGM4eVCWQIAxenAEzk9wuGfyZ8RXmOCltyiua1
 Kr+MjrH/93OBS71P8p2b2r2nLl7d4cjIsPy2e3PVJPuES6Zzd3rm5T5IvbZZXNVg/eerInc03p/
 2ZgYA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C
X-Rspamd-Queue-Id: 1335843077
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.177:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.trustedfirmware.org,linaro.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.177:from]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: allyheev@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: BU7JSFCGWW4J6HVXLIFQOJGXZIVPEOQJ
X-Message-ID-Hash: BU7JSFCGWW4J6HVXLIFQOJGXZIVPEOQJ
X-Mailman-Approved-At: Thu, 06 Nov 2025 11:03:01 +0000
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BU7JSFCGWW4J6HVXLIFQOJGXZIVPEOQJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Uninitialized pointers with `__free` attribute can cause undefined
behaviour as the memory assigned(randomly) to the pointer is freed
automatically when the pointer goes out of scope

tee doesn't have any bugs related to this as of now, but
it is better to initialize and assign pointers with `__free` attr
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 drivers/tee/qcomtee/call.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index ac134452cc9cfd384c28d41547545f2c5748d86c..8b7b4decddd8d1811dc0a7cc46a4a4fbada45526 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -645,12 +645,13 @@ static void qcomtee_get_version(struct tee_device *teedev,
 static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 					  u32 *version)
 {
-	struct qcomtee_object_invoke_ctx *oic __free(kfree);
 	struct qcomtee_object *client_env, *service;
 	struct qcomtee_arg u[3] = { 0 };
 	int result;
 
-	oic = qcomtee_object_invoke_ctx_alloc(ctx);
+	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
+		qcomtee_object_invoke_ctx_alloc(ctx);
+
 	if (!oic)
 		return;
 

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2

Best regards,
-- 
Ally Heev <allyheev@gmail.com>

