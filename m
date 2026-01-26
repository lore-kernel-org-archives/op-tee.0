Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB2FCF65CE
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 10:13:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E4081436F1
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 10:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1769422393;
	bh=tDYIhxiz36gjJoQl3PD4STiraGAmWfjSN46yy4QfZ70=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=SSJnBMfsqWSSkInXOhHFq8+dmnSu5koTVccsXoSUjhbwBehP4yeJsq8bIngEPlric
	 1ZrsD8xe1XeGFgzrtZDUXHfakxNYUlNxUfRK/TFWb84cRq0ITcDztSSgYeqX7thZ8T
	 5H8yfsBkWImpl5do/yPRnp4iTszwWYM17mpD+LEnedoIPfc78UgnSJN9B+pwwglLuj
	 s2FKrrUevxs3c1af29cr+7CQvQdbD4ixL9mUNp7whScu6p3IG1jkqcEka82yph7WvZ
	 2CEebw1Or6yyHVgWS7aQUNEAqAFHJ5v4/8aRmuKW9XQ/xgp0TZ/Vat+AMXvpzWy0yH
	 qas76vWPMZ6Iw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3DA9B432A6
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Jan 2026 10:11:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=euzudDIz;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 87DB16011E;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35A74C19422;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769422287;
	bh=tDYIhxiz36gjJoQl3PD4STiraGAmWfjSN46yy4QfZ70=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=euzudDIzFHKOG14xvGZR1bpJcSZQndTyFmKDxgBq6/fADZAJh1pOeQsMZ2SxPZ9ht
	 kgv9qcrIlEPpE0idwiDyR5+IVQ3ZaNRW6lZjRyJNDizVMwCdwUBzWbMVZrC8mVSm96
	 eoivGoopL3uwlmjmKuyFDYuh/hYZcBxjKFo27fxZEv4O6Z+HDPuSth5rk3aiOrldPm
	 4qm/pPUNn1fYm9gEMpopAPClgg95xeSB5nGENUMJCj4g4MRQAqAGZjiCNAaICpy17i
	 gnlwkFiYfl1h9HO5mT4GosjBqF4haH8Q/9TCTeAaIvKDKsrhZaUVEx+qHJYnzmijDm
	 N/zx85Xk8DEww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2482FCF65D0;
	Mon, 26 Jan 2026 10:11:27 +0000 (UTC)
Subject: [PATCH 0/3] OP-TEE/OP-TEE drivers: simplify context matches
Date: Mon, 26 Jan 2026 11:11:23 +0100
Message-Id: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMs9d2kC/x3MwQqEIBAA0F+JOTdQVgb7K0sHm8YaKBWVpSX69
 6Tju7wLEkfhBJ/qgsg/SeJdQVtXQJtxK6MsxaAapZtWafQhM2OSI+xi/0jeZT4zHibThsswd70
 eZ2uIoBQhspXz7b/TfT8vP92GbgAAAA==
X-Change-ID: 20260126-optee-simplify-context-match-d5b3467bfacc
To: Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769422286; l=722;
 i=rouven.czerwinski@linaro.org; s=20260126; h=from:subject:message-id;
 bh=tDYIhxiz36gjJoQl3PD4STiraGAmWfjSN46yy4QfZ70=;
 b=6UdZd8aIRGT4L/9vrsiyrk5kkRQCa4+9u0QApVUg2I2zC/EDJOMyYlB50+svgmeaLWEmtkJB8
 cbObPWCi6L2AZqhKJIzHXabmOpA+4OgmlhEeAmksR98tL2uaWZkEYXL
X-Developer-Key: i=rouven.czerwinski@linaro.org; a=ed25519;
 pk=/5pmUK/XIAIIo8JA0axgfy1k8NRhRTQkxVwZYa1ga7U=
X-Endpoint-Received: by B4 Relay for rouven.czerwinski@linaro.org/20260126
 with auth_id=616
X-Original-From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.99 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
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
X-Rspamd-Queue-Id: 3DA9B432A6
X-Spamd-Bar: --
Message-ID-Hash: 2COJF6JTZ5CMXS5HQ2V6UYMWBSD5U5QE
X-Message-ID-Hash: 2COJF6JTZ5CMXS5HQ2V6UYMWBSD5U5QE
X-MailFrom: devnull+rouven.czerwinski.linaro.org@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2COJF6JTZ5CMXS5HQ2V6UYMWBSD5U5QE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Rouven Czerwinski via B4 Relay via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: rouven.czerwinski@linaro.org, Rouven Czerwinski via B4 Relay <devnull+rouven.czerwinski.linaro.org@kernel.org>

Both the OP-TEE core and some OP-TEE drivers use an if/else expression
to check a boolean which can instead be returned directly. Implement
this change.

---
Rouven Czerwinski (3):
      optee: simplify OP-TEE context match
      hwrng: optee - simplify OP-TEE context match
      rtc: optee: simplify OP-TEE context match

 drivers/char/hw_random/optee-rng.c | 5 +----
 drivers/rtc/rtc-optee.c            | 5 +----
 drivers/tee/optee/device.c         | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)
---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260126-optee-simplify-context-match-d5b3467bfacc

Best regards,
-- 
Rouven Czerwinski <rouven.czerwinski@linaro.org>


