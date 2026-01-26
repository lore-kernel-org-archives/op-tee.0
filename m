Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D435CF65CE
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 10:12:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C0444436EF
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 10:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1769422353;
	bh=iOcjZhzgQVcuWp44oRjS0h3QZ3gyXy6Xzg50V1b0oeQ=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=T81NvhBtIhqWi+7xlvCj2OGTBhDpwnA5xvQCLpXIm3M8zSPxocUKzRImzVQaIyv5R
	 BD47pLtvoiISvG+BvpcqDhbktQBYk/xbyZijxC+aVMx97Lb762lLf6VwHX13fg7fPN
	 la4qUdjWlw8EBdLRCAV3lwrxbXSsK7D3L+rFONNz11n4qYCCDK7m1efpLSsSUG2YQd
	 iEYr2aqoi1gUlHuiigbTpJGzzyTOIl0GrOw+POWlUjYDgIkswm5REZDko2CzKqjqSC
	 0jALZzIszeJXJX83BmEIqzrbB+7gKPNITgEFXYCCjqMPCI5GogqefSrJLwUWpcgxJj
	 d130TjmHRjF9w==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 386B641A33
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Jan 2026 10:11:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UVYmsn5U;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 967D660130;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 465AEC19425;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769422287;
	bh=iOcjZhzgQVcuWp44oRjS0h3QZ3gyXy6Xzg50V1b0oeQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UVYmsn5UReRAkoPpQBUx6Au2VSA/xm4N0yJJGhGGgW+BOp8yI3CiPdAS+O1KXY+4D
	 s5xXBWtitIVT0rKwO/adQZjoAq2n29llcIeVrGYKB2nDftpTl7PvVk5JSHsL97wWIl
	 h8zEewbn+KRa1y+svnxFp8legvB/rrNA3b9W5Fk348F/bOucIzcyYt9JOCxofBQf3a
	 bnX9G7kJl7FOHflu4slFcxTiOhJWXeVuvFsnxX3IpJRDKEj6fljT0qYgWCyWh3KmAb
	 +f1C4Sm3DBhFQFO3993lbHpfW/YEjrKI9eBuFyeEfT1PR8Cw6YZj08SYL9zrinzxuc
	 sDKRHEkfdkmsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EBECF65CE;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
Date: Mon, 26 Jan 2026 11:11:24 +0100
Subject: [PATCH 1/3] optee: simplify OP-TEE context match
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-optee-simplify-context-match-v1-1-d4104e526cb6@linaro.org>
References: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
In-Reply-To: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769422286; l=783;
 i=rouven.czerwinski@linaro.org; s=20260126; h=from:subject:message-id;
 bh=Lim3HY4VT+Sv8kk77StbxRDzEmFNkh04aSoGtueluXg=;
 b=4Kb4IcXJ/tJ1NPTBhb4ailO8WqWg3gIUy0bYahni2O14sARl12J5KJprLVVfhvb0EsXQhEbSV
 mI7kZiXHlNaCzM9PBik4ckocZG7s57F3uXKm0n7pHLUBJmQXtTloS6G
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[rouven.czerwinski@linaro.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[rouven.czerwinski.linaro.org];
	ALIAS_RESOLVED(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 386B641A33
X-Spamd-Bar: --
Message-ID-Hash: DQOZTOS3PJSTAGHRQTPYILIERFZ6GZZE
X-Message-ID-Hash: DQOZTOS3PJSTAGHRQTPYILIERFZ6GZZE
X-MailFrom: devnull+rouven.czerwinski.linaro.org@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DQOZTOS3PJSTAGHRQTPYILIERFZ6GZZE/>
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
 drivers/tee/optee/device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 950b4661d5df..4c85b04d6004 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -13,10 +13,7 @@
 
 static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 {
-	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
-		return 1;
-	else
-		return 0;
+	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
 }
 
 static int get_devices(struct tee_context *ctx, u32 session,

-- 
2.52.0


