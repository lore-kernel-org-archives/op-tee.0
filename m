Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF099CCFA1A
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 13:58:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3A4F750041
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 13:58:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Y7CfyVK4;
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 90F7841BB7
	for <op-tee@lists.trustedfirmware.org>; Tue, 11 Nov 2025 07:57:06 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34361025290so2674704a91.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 23:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762847826; x=1763452626; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx/V++xyadOUZoH/bSkYK6cIm5d5YSgG1Ih7qmUz09M=;
        b=Y7CfyVK4eSBlxQ+a/FigHSlD6jxmn221jnXi1VlU1NWnKhl5S7rVWrRspKBPTzWehB
         tzBWhXO7m4Sqw3noDvndToqpPSaq6Ne5xDYVajMwQHTUKrFRmOqYf/67ki9QQ7M6C+qV
         mio1ggDAXJVfKjzUc+hl0pGp6tyM83XfRD4ggefYwacjSKuOWw0D7OQQxPupeNx1qHg4
         8oKeQT5BFE9/PpPx6VPoU3Jpvn/TY8B54PeN6jjqLvWFTcHQvJ/1Q7o/BSNF+A5dRd0Z
         sE2UOm7JTqxI90jgjuKdrUzqw1XvOFPMKSJt8eyYXH1w4/gNzHZbDp1Ufgvj2u3/Yd1Y
         V6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762847826; x=1763452626;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx/V++xyadOUZoH/bSkYK6cIm5d5YSgG1Ih7qmUz09M=;
        b=oXuL4E9VkRBHqFywNsHSzqmpIzMWvkDp2nqKQMnNDMMkXPKMFoFR8kUQee3ziotsHe
         hiIl8wIS1F6cLsNVKvciGwraqhb5sM6fhs0SQ5M8OPDmnvwBFssE9dsD18OfYj9KymwP
         mhVRyXQo0Xp/k0/7SU34cU/nXt0Zu/jmNuRWiwrEFed6NIJq5IOzqdjGRr60J/a0C/bG
         NZHNzbrg/e9XwoRCL5lQwULvv9rGuzioDb6xAp02ToZoI6koUHbFPBAm9ZqTol5yQGJp
         VeCKi8OwZx6d6/xRPXzmrWveKS4Q87M+MIlawl37JdwJKBTtI0fViXgfq+Gd3vpxJex1
         hmkg==
X-Forwarded-Encrypted: i=1; AJvYcCVJct0DsalH352XfNFbL81PoekorrgVnzV1dB+2JxJtRRkckzuo1DweIrTQG7DSd3m3rv+ByGI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwIjk6xLE9oerjAQPcFi9T6jxIppQuTsja2lFDdCwBOUWm209TE
	5B/1bpeCkKi5u6TvE0BW2tHDisUm12aEX1E6H0zL9S2wEkOYH+jd8Hde
X-Gm-Gg: ASbGncsbGrY4o5NOUIKPHMPG1ADKiEYESvxMb1+vGCEGN5v9gjYit6/zFabr+fQSCSW
	PlLWPWAsy3kaDUjwCDXGLwaP9mX7eaUQMavH0SXYjkutc6DHPMqX7zxh4/is+genluA4UyV2/lQ
	BdFdDVO3C5lUFaDSv60n/P6jrEnQ5wBHq0MJByRFwX8hzE0EUP7UPfSf669atHdxgs6/CPkuJ7m
	PluT3obxVVvyg2DVOmr821C93dZrv/0MCcxm6aXuJqOrq3qtiBAqiTO9Z912M/c87HawogthkJr
	cXgZkkwSZCH9WfzVQ/0xjE/5gKjiHa+rCj5fjf0ED2J8QOIA+EcwF9E6GRU222a1wPcCT0Ulqd4
	qo/aRSFkZ74knsJ2hzLzBjgzXhfEqAbml7qpqA/O7o4+H1jgHw6OBlCQfO5n4FKX5TBNNHxqIvu
	8=
X-Google-Smtp-Source: AGHT+IHlgCsPGufic8ljFUM/F3tgYW1VFs7jgyf3xF1GaO+oK0dfmfAL1LcwALg8bAVga+ecAJtk8g==
X-Received: by 2002:a17:90b:3c87:b0:341:124f:4746 with SMTP id 98e67ed59e1d1-3436cd0bd38mr11876908a91.31.1762847825598;
        Mon, 10 Nov 2025 23:57:05 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a7a62sm20318454a91.2.2025.11.10.23.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:57:05 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 11 Nov 2025 13:26:42 +0530
Subject: [PATCH v3] tee: qcomtee: fix uninitialized pointers with free
 attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-aheev-uninitialized-free-attr-tee-v3-1-57905b913359@gmail.com>
X-B4-Tracking: v=1; b=H4sIADnsEmkC/5XNPQ7CMAyG4augzATFbiMVJu6BGNLUaS31ByUhA
 qrenbRTR9j8eni+WQTyTEFcDrPwlDjwNOYojgdhOzO2JLnJLVChBlBamo4oyefII0c2PX+okc4
 TSROjlzEfChGo1GS1QZGdhyfHr23jds/dcYiTf2+TCdbvP3oCCRIJiKqyKmqrr+1guD/ZaRCrn
 nAngvpFxCwqLJyrzZmMcntxWZYvCxm82CQBAAA=
X-Change-ID: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=DjujQ4Ip3o0Fr7W1bLZTv2QT33O7HU1A7IoeReKU2rE=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDKF3rhu2LG09/gzQZP8axXa7j0R6UG1515US927qBTuI
 McXluzbUcrCIMbFICumyMIoKuWnt0lqQtzhpG8wc1iZQIYwcHEKwESOsDD8r/X3m9BS3uzHO6nw
 mtQKjc3noi/8+tcb9n3iXpduFseZLAz/FPpfBaZFPTK5eayTs0uq/E63+JnotNdvzULy/ZiM3vN
 yAAA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 90F7841BB7
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.44:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.44:from];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[gmail.com:+]
X-MailFrom: allyheev@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: YS74RWCMGLYYM6SFGBYSWVNMEBFAFCUH
X-Message-ID-Hash: YS74RWCMGLYYM6SFGBYSWVNMEBFAFCUH
X-Mailman-Approved-At: Tue, 11 Nov 2025 13:58:05 +0000
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YS74RWCMGLYYM6SFGBYSWVNMEBFAFCUH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

qcomtee doesn't have any bugs related to this as of now, but
it is better to initialize and assign pointers with `__free`
attribute in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v3:
- fixed commit message and description
- Link to v2: https://lore.kernel.org/r/20251110-aheev-uninitialized-free-attr-tee-v2-1-023ffba9ea0f@gmail.com

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

