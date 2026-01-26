Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BB6CF65CF
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 10:11:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4ECBA434B5
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1769422314;
	bh=+4m8YG1iRHz0Xfy1eofVfDUmEXxlqgjcfG9cv3ureLI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gTsAL4gk51b+X0cbKDTRcER+Ggp6Z62/O9J0AkcjGlL1Vics2+pCfoM7N+lsUjGPF
	 JVdulvQXRIREizIOQunDhWI0fwHdouR6YtwO5r4guDmR+K/PtAhTNQ1l4oqMBzquNM
	 3SBugDBG6cXs8V4fBkUb8zOrwfJsMF5XeErNwGtYwbHWZv4IjuuS7df2ZdUjJThmkX
	 JdcKtzUV7BiyqVdKZTjJUwzQUiCXX3nuqVaW3jUfcW8pxj/Yj66nt4vWRxS1PlNc/W
	 EXpTvP5dv1R2tix+ve7LhGASyXpFUjA36MUYQ5XX2skOwdAGYbBv+30DihWU0/j0Si
	 u9NU5+nk2/L9Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 40724434B5
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Jan 2026 10:11:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mf1eZCmD;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7AD1E439AF;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5473DC19421;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769422287;
	bh=+4m8YG1iRHz0Xfy1eofVfDUmEXxlqgjcfG9cv3ureLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mf1eZCmDO0IykqCu0Un4XXkZha/i9i7Oeuwdh4C1i2+InJdmQhr9XYmgRXrTLFxAX
	 +AAI35LhiJwmyvpBlTwQiEl4InnRIohnKpOKBxlqU13xfc0xQHdPA5W4UJhwcDHDKD
	 Htmxv4AuI1/R+w/W4hhp7rzGBQNQEvxy5qs6vw8l5hvgXcSTkJerNWoUViWsoA5rRL
	 NUsSOBlS8pE9Ctqp6CQ01BYdwSXrg5Sjn3Fu6OhZma9avYLY3eQD99Msc5TJ5UvrkB
	 CKLFjCLDs9WHQwxNmK++JlAYblMdg5EWg/jlvaHu6dYV785sdOTAhVe1IE1E+WJAVi
	 Jl5oPQjNfw5hQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44407CF65CF;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
Date: Mon, 26 Jan 2026 11:11:25 +0100
Subject: [PATCH 2/3] hwrng: optee - simplify OP-TEE context match
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-optee-simplify-context-match-v1-2-d4104e526cb6@linaro.org>
References: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
In-Reply-To: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769422286; l=861;
 i=rouven.czerwinski@linaro.org; s=20260126; h=from:subject:message-id;
 bh=p8tI6pIIO66aDTefRkzTZEFHyvfeutsw1Mqx0QvEoOA=;
 b=w71sU40i09QokWYwJWAdlVOsG4IjN2I8j5C8Ww9Fftf9OH0IWe17S9e/wXmjnVsFhwtLjaki0
 kJSE0pdWVFeBTQP7QfbhvGIAmYJDnQRiExywcM4VZd7fda4is6Vo0f2
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
X-Rspamd-Queue-Id: 40724434B5
X-Spamd-Bar: --
Message-ID-Hash: YP24X4PKXFVP7L4TH7VW3QQTNJCF5T35
X-Message-ID-Hash: YP24X4PKXFVP7L4TH7VW3QQTNJCF5T35
X-MailFrom: devnull+rouven.czerwinski.linaro.org@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YP24X4PKXFVP7L4TH7VW3QQTNJCF5T35/>
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
 drivers/char/hw_random/optee-rng.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index 96b5d546d136..1cb741a6d112 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -205,10 +205,7 @@ static int get_optee_rng_info(struct device *dev)
 
 static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 {
-	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
-		return 1;
-	else
-		return 0;
+	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
 }
 
 static int optee_rng_probe(struct device *dev)

-- 
2.52.0


