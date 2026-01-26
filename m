Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F316CF65CE
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 10:13:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B3E15436D9
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 10:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1769422430;
	bh=fBZcq8cvRjheDHCvLXxrccPqA24+Mola9mvDT4gcPLU=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yflUZ/bqvGKy1QJgEc6qeqEo2K9uQlGZ2HD2aRONilVpm4NMQxha+MjSnyrgGD93Y
	 YnkeSDC7nh1430QRdHawhfKY83Hm4SDmV5brpMM6YlvMIqvUJOJSGzGkArZ/JIZ0xu
	 F8H0grQsvH/yZdutbqOhyBt0HNHirJoT8ad1u4NrAeVQzeuajEWI7YkdJv9hVgBN33
	 KkXKUvi1tVCzor55u/4FnbAWH9RUPwtXe2A52eJueoax7LrJ1qljEoKgjwzyYjLiKR
	 RrPZ3NS2J6zv89VRTQv6QeBC7BzMsgUZQ3mBTT94IPHQM0JeTtjAi8/qdpWSi9IqwG
	 J0+gM+MYIydAQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3B1CE4329E
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Jan 2026 10:11:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H7dAxoKr;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 89BCF43C7B;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E179C2BC9E;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769422287;
	bh=fBZcq8cvRjheDHCvLXxrccPqA24+Mola9mvDT4gcPLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H7dAxoKrWDx/HdgM+UecgdSNqUzTLvhYkqidiceXqRYRaRhvMvIo0rJRR+buw45cc
	 3sht/20iEKBI3IT8JAYmXfHbshRl13FdO/KCXRQVF+Aq21f3/ybE9D0RgpsBa8hebJ
	 Fgimn0F2UJzo/hCEOgqsh8vi17Kh9nvVbWDjqT9WQwFnQuhnYKPSZKWUgZaSbjeOiH
	 RcXwTRSwPHn3UGHx7SD8aum7ueTjgZS75ar32/6iQGY5eI3wOhbzd1mlE5QlWCZC/s
	 O59pC5JdRPdVH/M0hZia7Rmca29prhqeTQUGUdOBZZX96/dQ1JLFKRCTiBJLTNaWLY
	 gPaSXrVwjZATg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C9CF65D2;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
Date: Mon, 26 Jan 2026 11:11:26 +0100
Subject: [PATCH 3/3] rtc: optee: simplify OP-TEE context match
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-optee-simplify-context-match-v1-3-d4104e526cb6@linaro.org>
References: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
In-Reply-To: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769422286; l=831;
 i=rouven.czerwinski@linaro.org; s=20260126; h=from:subject:message-id;
 bh=QLdJDajsDAHZ5Jp/WvnfqKpNSpcj2i8eHxM4elD1BXk=;
 b=hUChSt/PerjC7blQ6RZipCBKxqnlwex+ECe8CfZ0Wb6SYUNshrn+Zn+ndFsgEjw9ve3jh9TQk
 BW08OOTuUhyCZjXixJ0Uk91h8vNM070X6eNfQyVTmMuXGcKhVgSHyg8
X-Developer-Key: i=rouven.czerwinski@linaro.org; a=ed25519;
 pk=/5pmUK/XIAIIo8JA0axgfy1k8NRhRTQkxVwZYa1ga7U=
X-Endpoint-Received: by B4 Relay for rouven.czerwinski@linaro.org/20260126
 with auth_id=616
X-Original-From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	TAGGED_FROM(0.00)[rouven.czerwinski.linaro.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	HAS_REPLYTO(0.00)[rouven.czerwinski@linaro.org];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3B1CE4329E
X-Spamd-Bar: --
Message-ID-Hash: FOSY2IL6IKHN5XANCGHG6FKZIF5KLAMX
X-Message-ID-Hash: FOSY2IL6IKHN5XANCGHG6FKZIF5KLAMX
X-MailFrom: devnull+rouven.czerwinski.linaro.org@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FOSY2IL6IKHN5XANCGHG6FKZIF5KLAMX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Rouven Czerwinski via B4 Relay via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: rouven.czerwinski@linaro.org, Rouven Czerwinski via B4 Relay <devnull+rouven.czerwinski.linaro.org@kernel.org>

From: Rouven Czerwinski <rouven.czerwinski@linaro.org>

Simplify the TEE implementor ID match by returning the boolean
expression directly instead of going through an if/else.

Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
---
 drivers/rtc/rtc-optee.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-optee.c b/drivers/rtc/rtc-optee.c
index 184c6d142801..2f18be3de684 100644
--- a/drivers/rtc/rtc-optee.c
+++ b/drivers/rtc/rtc-optee.c
@@ -541,10 +541,7 @@ static int optee_rtc_read_info(struct device *dev, struct rtc_device *rtc,
 
 static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 {
-	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
-		return 1;
-	else
-		return 0;
+	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
 }
 
 static int optee_rtc_probe(struct device *dev)

-- 
2.52.0


