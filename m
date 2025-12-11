Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6578D4417D
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:04:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 06B0F4FB8C
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:04:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=IwW1gvT5;
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D53EF4FF3F
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:06 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso4850665e9.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473366; x=1766078166; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJvuh2zJXk/iXDELpMIpnq6ZsR0QR0lcnSQ7RpEarGA=;
        b=IwW1gvT5jGntqyM+BIwam0tV+RHI05vxFwnxIDOmHsfTFmA/WcEJSch5nzDJdCAvyr
         DXHaaW52BCfrgmxQBsfhTuEiHDHoGhQvwpMaUfndcqo8JZ+/d+P6+XxZ4czIp0aGjhUw
         DwkolZv2NRnd4SwR11N7AJpZVi8Sp+qcQURdhxvQQwoaIcncOfWbxDHQIYtB2JOY3oWg
         FLSaUy1I2VPcdtsi3K7dSLLtYIoqV08QyciftOUtKO9gwOoyPcpTR5PEwGgCzpiqOZgG
         EvFIlZe3WmM+dlZo39qFmmQftjHL0lXLjVA6iIBKWGOav8zKMzCQlB5jeqMrYSWv04Wh
         bxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473366; x=1766078166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJvuh2zJXk/iXDELpMIpnq6ZsR0QR0lcnSQ7RpEarGA=;
        b=EbSLTIii3RiCCpaupj3uDYY/6Gb9O8qZSgduT/dIuLiG+sckMRRgirkaothDcl9dee
         rGn9OUWBuL9eJrdRBNLOYGg5+KOPRKoOruzj6CHwtAGec4m7gmCFV1Oo4R/4g2BmlPRC
         kQ4gWEEiZd2KreW70eiyocdeM4g01tICpW3wFc7n5dFjXhdGbJVmh2VuEXbtcsbcnr4Q
         OzDaRUEwoJzhENrf1HEuvkbZqLFhQ73ogUtgu9/tWLpQIKmRtz0yP0+ICBpj5vEOMlZ6
         QBjOU6ry5n2afFonOhNi4PDjgSZiadkKWyikibjh73LnXZa5fTIlRlmyQgRH5REyKKne
         P3vw==
X-Forwarded-Encrypted: i=1; AJvYcCXczYUDghCqxCO6XPLzYXnEHw6tRrKfdU9EKGYL8Bao+LSOfB+jnUSH3yvpMSjW4KZJ7s9xrBc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwDZZ+sevreX8tkeNaHAB7++Odi2M/AdMNgqpwUdgVGcNQS1kVt
	VtPhynUFmPHhIQMJEhDHF6hgqisNnUswZQ0gbUhMXLYJ8GrVaLp9nJDN/IDQBUvp010=
X-Gm-Gg: AY/fxX4q5ZpJ5TArX3NL+/3qgNGdPxlF1QJ6+PRMFiCfrW8jYQjOEkaKqcXW6PeW7BM
	T5ymI+EDQBw/ANSgTcHdT3cGLVoNCpv7A1hudbYsqTFoE32WguFt2zrCE29SSUL2LhSSn6K3PYd
	XLylRxYwNvgPyhvxlK4NYYsvIBQtxKh7OAK/ogQaT67MVCYhZ/qCVbQQDKtNzkOEQDmpPIdXjd0
	pBSdvuD8iZWDQ8SL+GD5+W9H9RKonIV3REPQauXPGmaHKibUzjl7EHTpQaCYhyKWwByOjwh6kAP
	Vr1RRMGMNg9PWxYI3HQis3I0f5kDHQisa9Bt0exocFI+FpDvSEVvF2U2kSqvimB+qk6ziMNVTaM
	6AfVoQ18top2cXokXoyDUNaUo4MZaf2+oeyReK2H5vWPHdyXlYJZyWSYgH6PNXTdNtmXeFFmvRm
	mKezu8toWT/sE87Mg9B8qPNUJKvmaTCzU8oR/Kr62g+A0q5rmDC90tNjDw1ovAHkyD8TJMKQCDN
	aM=
X-Google-Smtp-Source: AGHT+IEGmS+1LhS4ZsJsEwUzoNuTKqPZKX6sWYZNnchoA1D32F7TBe8hMOH8GOYwpwExY7BjQ6puZw==
X-Received: by 2002:a05:600c:470a:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-47a8384bb93mr65103155e9.22.1765473365857;
        Thu, 11 Dec 2025 09:16:05 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89ed6813sm18027445e9.6.2025.12.11.09.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:05 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v1 11/17] firmware: arm_scmi: Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:15:05 +0100
Message-ID: <46dae3cada663b3a5ae1989881d9e74ef40acce5.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=CThuCWJi4dOQENcO7QkBfz1Ye/Pbs4UbUDXRANvmB2A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvww5Fdhu+aWz2MP7psFnJDaCqSIMI0L6LHTN epd1RJ6lh6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8MAAKCRCPgPtYfRL+ TmkNB/0YKwt4sdh/V0tvwCmGZWV8z4k4PtU5uKfNbIzaUiD6HqBwjSazrEryMHtANr/UGgSXKIY g6wAfPHQ7BBgbU8Vh2aGoY76LpexA4nfFlq68n8Suxao5uRi6oduzNpX8YoMvSsFQKZLFPonVdU tLx7XPSKIBhVdbMadabM2MGwZmSfYe6lCQY5zuKRxzk2CXnwk1Ip8rZMZYq7qqY15E6ysSl1y6a tLiFhXD7hUsGffmgeMlBtuHsXOKqk9k7Os37VByPrcKt1yqVayq6gSWhgzGIFo7P2NiyqakZgf6 l6t7cZBtlhYHU4BluapUDhLu26g/LOWvt+tVlchYsiKw2ESz
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.44:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:server fail,209.85.128.44:query timed out];
	FREEMAIL_TO(0.00)[linaro.org,arm.com,wanadoo.fr];
	RCPT_COUNT_SEVEN(0.00)[9];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.44:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D53EF4FF3F
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: RTNIMVGNK3GTKT5ALSLDJJLT76TMLZ7M
X-Message-ID-Hash: RTNIMVGNK3GTKT5ALSLDJJLT76TMLZ7M
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:57:12 +0000
CC: Cristian Marussi <cristian.marussi@arm.com>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RTNIMVGNK3GTKT5ALSLDJJLT76TMLZ7M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBidXMgZ290IGRlZGljYXRlZCBjYWxsYmFja3MgZm9yIHByb2JlIGFuZCByZW1vdmUu
DQpNYWtlIHVzZSBvZiB0aGVzZS4gVGhpcyBmaXhlcyBhIHJ1bnRpbWUgd2FybmluZyBhYm91dCB0
aGUgZHJpdmVyIG5lZWRpbmcNCnRvIGJlIGNvbnZlcnRlZCB0byB0aGUgYnVzIG1ldGhvZHMuIE5v
dGUgdGhhdCB0aGUgcmV0dXJuIHZhbHVlIG9mIC5yZW1vdmUoKQ0Kd2FzIGFscmVhZHkgaWdub3Jl
ZCBiZWZvcmUsIHNvIHRoZXJlIGlzIG5vIHByb2JsZW0gaW50cm9kdWNlZCBieSBkcm9wcGluZw0K
dGhlIGVycm9yIHJldHVybnMuDQoNClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1
LmtsZWluZS1rb2VuaWdAYmF5bGlicmUuY29tPg0KLS0tDQogZHJpdmVycy9maXJtd2FyZS9hcm1f
c2NtaS90cmFuc3BvcnRzL29wdGVlLmMgfCAxOSArKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL3RyYW5zcG9ydHMvb3B0ZWUuYyBiL2RyaXZlcnMv
ZmlybXdhcmUvYXJtX3NjbWkvdHJhbnNwb3J0cy9vcHRlZS5jDQppbmRleCA4ZmRiODBkM2ZhYmQu
LjA3YWUxOGQ1Mjc5ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZmlybXdhcmUvYXJtX3NjbWkvdHJh
bnNwb3J0cy9vcHRlZS5jDQorKysgYi9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL3RyYW5zcG9y
dHMvb3B0ZWUuYw0KQEAgLTUyOSw4ICs1MjksOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBzY21pX29mX21hdGNoW10gPSB7DQogREVGSU5FX1NDTUlfVFJBTlNQT1JUX0RSSVZF
UihzY21pX29wdGVlLCBzY21pX29wdGVlX2RyaXZlciwgc2NtaV9vcHRlZV9kZXNjLA0KIAkJCSAg
ICAgc2NtaV9vZl9tYXRjaCwgY29yZSk7DQogDQotc3RhdGljIGludCBzY21pX29wdGVlX3NlcnZp
Y2VfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyBpbnQgc2NtaV9vcHRlZV9zZXJ2
aWNlX3Byb2JlKHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqc2NtaV9wdGEpDQogew0KKwlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmc2NtaV9wdGEtPmRldjsNCiAJc3RydWN0IHNjbWlfb3B0ZWVfYWdl
bnQgKmFnZW50Ow0KIAlzdHJ1Y3QgdGVlX2NvbnRleHQgKnRlZV9jdHg7DQogCWludCByZXQ7DQpA
QCAtNTc4LDI0ICs1NzksMjIgQEAgc3RhdGljIGludCBzY21pX29wdGVlX3NlcnZpY2VfcHJvYmUo
c3RydWN0IGRldmljZSAqZGV2KQ0KIAlyZXR1cm4gcmV0Ow0KIH0NCiANCi1zdGF0aWMgaW50IHNj
bWlfb3B0ZWVfc2VydmljZV9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyB2b2lk
IHNjbWlfb3B0ZWVfc2VydmljZV9yZW1vdmUoc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICpzY21p
X3B0YSkNCiB7DQogCXN0cnVjdCBzY21pX29wdGVlX2FnZW50ICphZ2VudCA9IHNjbWlfb3B0ZWVf
cHJpdmF0ZTsNCiANCiAJaWYgKCFzY21pX29wdGVlX3ByaXZhdGUpDQotCQlyZXR1cm4gLUVJTlZB
TDsNCisJCXJldHVybjsNCiANCiAJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJnNjbWlfb3B0
ZWVfZHJpdmVyKTsNCiANCiAJaWYgKCFsaXN0X2VtcHR5KCZzY21pX29wdGVlX3ByaXZhdGUtPmNo
YW5uZWxfbGlzdCkpDQotCQlyZXR1cm4gLUVCVVNZOw0KKwkJcmV0dXJuOw0KIA0KIAkvKiBFbnN1
cmUgY2xlYXJlZCByZWZlcmVuY2UgaXMgdmlzaWJsZSBiZWZvcmUgcmVzb3VyY2VzIGFyZSByZWxl
YXNlZCAqLw0KIAlzbXBfc3RvcmVfbWIoc2NtaV9vcHRlZV9wcml2YXRlLCBOVUxMKTsNCiANCiAJ
dGVlX2NsaWVudF9jbG9zZV9jb250ZXh0KGFnZW50LT50ZWVfY3R4KTsNCi0NCi0JcmV0dXJuIDA7
DQogfQ0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2VfaWQgc2NtaV9v
cHRlZV9zZXJ2aWNlX2lkW10gPSB7DQpAQCAtNjA5LDExICs2MDgsMTEgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZV9pZCBzY21pX29wdGVlX3NlcnZpY2VfaWRbXSA9IHsN
CiBNT0RVTEVfREVWSUNFX1RBQkxFKHRlZSwgc2NtaV9vcHRlZV9zZXJ2aWNlX2lkKTsNCiANCiBz
dGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIHNjbWlfb3B0ZWVfc2VydmljZV9kcml2ZXIg
PSB7DQotCS5pZF90YWJsZQk9IHNjbWlfb3B0ZWVfc2VydmljZV9pZCwNCi0JLmRyaXZlcgkJPSB7
DQorCS5wcm9iZSA9IHNjbWlfb3B0ZWVfc2VydmljZV9wcm9iZSwNCisJLnJlbW92ZSA9IHNjbWlf
b3B0ZWVfc2VydmljZV9yZW1vdmUsDQorCS5pZF90YWJsZSA9IHNjbWlfb3B0ZWVfc2VydmljZV9p
ZCwNCisJLmRyaXZlciA9IHsNCiAJCS5uYW1lID0gInNjbWktb3B0ZWUiLA0KLQkJLnByb2JlID0g
c2NtaV9vcHRlZV9zZXJ2aWNlX3Byb2JlLA0KLQkJLnJlbW92ZSA9IHNjbWlfb3B0ZWVfc2Vydmlj
ZV9yZW1vdmUsDQogCX0sDQogfTsNCiANCi0tIA0KMi40Ny4zDQoNCg==
