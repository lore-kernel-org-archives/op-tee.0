Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F890CCFA18
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 13:58:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E507250040
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 13:58:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=I8IZ6Bhu;
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A065350017
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 15:17:51 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b62e7221351so2600824a12.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 07:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762787870; x=1763392670; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=proAMupxnU1cqn8ppHXktvWmCFOk0d+KB4vZ0hwkHKs=;
        b=I8IZ6BhuJCRzeO5N7AGJ7fOHN6PgF5TCgFZ+xpxdRe1GR8H6jQXMnpFqZi/3xvU7VW
         2AcnW/+xTz7NX6xQUHy+k4Y5ByRztcazcbiZgmoWn86bZFQK2ixXBD7tXqqGBR0o7i+I
         sd8XHtXkK7/0OfRyNpjbBWgKDLfN42p6yqzsz+73kAlPgY+ZP/rQEpNwusQTPdhnNY+U
         QSnSUIO9Qsm6b3pJ2jYbhDZEc24C4rpAj/kpo+3QI+EwH8DH0aBo4W8nt0nwnhktl6X/
         bK9cZXEQvZxVxy1+5OHu4gpv64n1ksJboNCE3U9IjtvPF6YWxN1k6BUhRpLX3D6KA8zO
         cOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787870; x=1763392670;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=proAMupxnU1cqn8ppHXktvWmCFOk0d+KB4vZ0hwkHKs=;
        b=cp01VNvM26gnQWxCkmcuVR7edpDLVIRykKmPpqsjLPqcBuUBe6ADWjv2NUhCdAfQ/g
         bi3Fymwv26v872qso+z8cQ2Ohfjj+XE7szgWo0SqPreLTFTrSnYfUxu4LmxDALmzLXXV
         AmU0kjjQDa8Y2vCbscLrMCF/Ly13oPth53JAl4uSxXV9KLUMMVqBcDqMp6AqTqv8e/LK
         K/x5/s25ZcPYCS0S2jEGj9TP1/58h9h0ctymp3gsLDZ/uB6OVuVurs8nBV8LDWG++EkG
         VCQqri/072B9LYYZCWMuXlC5zXPbxvC2S3Fd8bM+YHE49D2DUBioMS2K0FE504FDv6j7
         Bl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVE/kWgMpl/NDvRZqpyz2spm8p2qOVqbHxeNnpS3n5sxjYMxdsBEdFAf1UB3a+gAKkHhkGvyUE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxOeidbKbDo9GJ9uB1nd7er9gPrS+mVDzf/m+/tXT1YR3rhyA/B
	W4C/hpGAJVbneRcWTgIS0Y8Rt9LtKOeRfhUZlOr88BEL5qj+Nei//Xk2L3eHamCg
X-Gm-Gg: ASbGncvSrgcd2HXjF9/IVrexO7U6ebTnrw67eU03vK1HKpp9lWfEMN64YuGuvY9QdHw
	fbuyuC9RcB+5X7sI7C0nArdiR17QzEw3p1rchL0uWr4f2UjVcbH4EuPcJcrKUFt59alQ0r7DR3N
	kq9lpQ3JaR9ztNWvxqqYpL509ys+3GAqv4YM/eBPrcNQZNliWY4cTC2dO8z0w0XBgeZn7BZo61B
	czBn4KuaMX06q/0R2yt7wsEHdViVsurhTHhHxRfZskVhdL0ySQcnKMdBQn4xhJcSO/pdWVlkomM
	meyI26wG6s5RJPi0lHhfzHnxoZ/8gULafkbs1RwKKKswlic/eXBvCwL0tKSG9kso45iG7AtRYv5
	Ymv3CnOq0QwA9kW0rme4+KDtTs1kvw3eAiYOc75s8z/zfUo9AffL2prN4Dk5KvWMQVJvKBhPksI
	EgMOUFsCd0rw==
X-Google-Smtp-Source: AGHT+IFColOTEFc+YKuJfWoz7iYZVyQkHiGnmwgGT/THEbSZlWqrZVd6iPqWGf0bCjSVP6LSnEfm3g==
X-Received: by 2002:a17:902:dace:b0:297:e59c:63cc with SMTP id d9443c01a7336-297e59c644dmr114215475ad.35.1762787870219;
        Mon, 10 Nov 2025 07:17:50 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c6b3sm147976145ad.24.2025.11.10.07.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:17:49 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Mon, 10 Nov 2025 20:47:30 +0530
Subject: [PATCH v2] tee: fix uninitialized pointers with free attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-aheev-uninitialized-free-attr-tee-v2-1-023ffba9ea0f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAkCEmkC/5WNQQ6CMBBFr2Jm7RhaaUJceQ/DopYPTALFtLVRC
 Xe3cgN3//3FeytFBEGky2GlgCxRFl9AHw/kRusHsHSFSVfaKFUZtiOQ+enFSxI7yQcd9wFgm1L
 gVEaltUJt4IzVVDyPgF5ee+PWFh4lpiW892RWv/cfe1asWEMBTd2c785ch9nKdHLLTO22bV9A+
 ZMd0gAAAA==
X-Change-ID: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=ngcsiD/ajXiiBpABsVazTz+tJLwYwSvVxHi2KUe+7xI=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDKFmMTyPKQjFeOe379RKLJCf2GU64vwyMLnUfwcPRkvp
 i2R17PrKGVhEONikBVTZGEUlfLT2yQ1Ie5w0jeYOaxMIEMYuDgFYCIqMxj+is02uvih40zJtqz9
 X4yntCVqKjb2i1pu0bqkrdmyy+OQKCPDgeg1WYmx74ScDp3h2WN48kMOh/jCRfwdxfJ/djJyp3/
 lAgA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A065350017
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.215.177:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.trustedfirmware.org,linaro.org,gmail.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.177:from];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[gmail.com:+]
X-MailFrom: allyheev@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: XDUZPURKI7TUIBKRHG6QS4HONBAHJ6XQ
X-Message-ID-Hash: XDUZPURKI7TUIBKRHG6QS4HONBAHJ6XQ
X-Mailman-Approved-At: Tue, 11 Nov 2025 13:58:05 +0000
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XDUZPURKI7TUIBKRHG6QS4HONBAHJ6XQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

tee doesn't have any bugs related to this as of now, but
it is better to initialize and assign pointers with `__free`
attribute in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v2:
- initializing variables to NULL at the declaration
- Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com
---
 drivers/tee/qcomtee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index ac134452cc9cfd384c28d41547545f2c5748d86c..65f9140d4e1f8909d072004fd24730543e320d74 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -645,7 +645,7 @@ static void qcomtee_get_version(struct tee_device *teedev,
 static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 					  u32 *version)
 {
-	struct qcomtee_object_invoke_ctx *oic __free(kfree);
+	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
 	struct qcomtee_object *client_env, *service;
 	struct qcomtee_arg u[3] = { 0 };
 	int result;

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2

Best regards,
-- 
Ally Heev <allyheev@gmail.com>

