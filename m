Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFDFD5B16C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:25:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A61A84FEB7
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:25:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=PxE1/Fmk;
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6A0654FEDF
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:53 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1530995a12.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808272; x=1766413072; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfzDwdLQJZM+QWaZp429a9MEMQ68gzEG7kbM26+AAC8=;
        b=PxE1/Fmk4L53rpiR/QYhu9Mo4B8FGulb5vZ/h0x7QyCjwAVHhkaXJSD5p0xFGeWS++
         5+We1X2A8S9AekOcJRI6hgsAFjxs0myLFQPEIYQcOpivseGBsHtdcYFnErGsrw8UH/FS
         Rx8tEVS/cNF5JzjPqFxUAhEm226lGZW/WJ4HIXV+M207O9fLKanVBOy7tUJulH0QrUU0
         MonWCVp6oXAlRwR8ee0ScoN8rLJcD77VG5Vi9Q7kBdVOuqd0qtYmIVWqbSwq3mRSZFSK
         rJz/Gh7w4LmKfmWGG1olhid0Dtk3Uns1YdJnGH3UaZu7ngF4VK3vgN/11qWFRlGWkTdL
         hSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808272; x=1766413072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sfzDwdLQJZM+QWaZp429a9MEMQ68gzEG7kbM26+AAC8=;
        b=N975LpXAOFNKuABKH06aMNhwMR7e57C1xB/MHDaG2/Hqqt4Fg0HgEg7umiUA797DSP
         EWUVpc+zU0MgomCy3DhnL44RL9v0/FvSB2ey2UYVwLw08PxnJjipRpPBuPGlZj6VX9o1
         xrskgsjbI9yJZQv7Ja/3cFMCu14StoOGxMzeNpP5PyOCRhR6wvvlxXOJQ4bwcXlJGGYz
         h+EhRo8d8gDP+0t3ChioenfyEXYdGkZkdqt2//um4b/8Ut9JCxfTCT0i9FyfpGyCXQeO
         2hnuod2YHA4hF8GJptLASXk3m0FRoJO/ARtRzvUDnDZ51UPD6tMuG/520+ejAwyGiCih
         3qtg==
X-Forwarded-Encrypted: i=1; AJvYcCXj+Pur6h3J+vZiJg22ZuOrJGadVfnk2eawPEDDg8yufKsHDPxjPfPMz8faeYQkQv9d6ng+dzM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzaem6YBna1p6wkkFFQOdal5V77UucamxDwfLhkIuT7SDt3uYzG
	gtRBJ+4gP4iFmaf9cnmfNYLbk5+bho5PtooRaXcW+KO18+oV8ljoHcC2hopOKsYH3wU=
X-Gm-Gg: AY/fxX4oFfT/MexP8ynS0fvfbymbQZdmRA61MjL8XUpxJQRUHIhxCZL7RbkSO56NmPz
	eRaP8tqE5ZULYfyQKFR46K/D5IQ2gkKCW+T/d/v66ypjpmdow16Vz8/TsOlZ4orD8Xies00orWz
	NnuB1MTLDuaJiMrVDg8RTcw4SOAEzn4Yajr4UGeT4yPftpm/m4mrUfrpVTKMe9U7J6AGSbKAnfI
	yp608wOG/D17NRRTaNR30VyIlDjwF3xPBSAlnQs35MSxF4WB5Qv21OEb3699OTYsK8koNbuLHkk
	FtMX81xfj1brMKlLJYZ2GoutD20LX0N182KCENF5ozYP1bD2QD6sEaRNnN5R7gbhx2GBSvwTk6u
	QR6JjWwoDI2DrpSiNyBcLjCLGn7iZegkh6yoMyT3ruRpMgzcXqb7LJb2z9m5ZTSXO5vortyeMXa
	H9bRzhK+vkFD94CPWd2rRokN/hBVXQEF34Q+VZupi3peQQPEQNY61QugBit3uFvJzOqwOK
X-Google-Smtp-Source: AGHT+IFOJgC5Ya2iL64i8Tv4dTF8QQYDLC4+J0wActxyot5OM2vMJCd/KcUe/O38HWI5lnvavkRPtA==
X-Received: by 2002:a05:6402:345b:b0:640:abb1:5eff with SMTP id 4fb4d7f45d1cf-6498745b430mr10332378a12.8.1765808272372;
        Mon, 15 Dec 2025 06:17:52 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64981fa5514sm13619843a12.0.2025.12.15.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:52 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 11/17] firmware: arm_scmi: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:41 +0100
Message-ID: <859339714ce238c34fdc4832fa23d6d6abec6ba1.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4A/9VAHmTaZWnv8JgiT7H1qCJuRsg+ML7SSaVfNtUv0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhkwHiXSzA2c6kuc0awa3zu+SCZ668nFKvHWuQ19u+6RrV +fOP2TSyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBELnWw/7OWWaMvsKvlGqeJ z1e9vfb6bD16p1Yo+j3aH1+h4WE+cR+rYGip+ZscsVOCdsvEzzEe/2OuPX1C0dzONVfenBSXdO6 e1BtrkaJnFXTX9qFbVku81gGHfJl9i7dtXOw37fxuLncN9+t2MjZ9TFN03JkW/zSd8+Hcdrf3Yu pCDWLba9+rzpdm/bDznlWxX63nqrDMdlVjC6bdwWea7PgbbQsaD3usDXjRmnko2+n6OT7dn1PuK vutPc98QFulL1RplW5+csjilybqX3IPKcRm3Xw5LW/Jft5d9ns+zE+5xtCrPjX07ZFLfxQsBcSi Jt3TWi4c4RbgyGilb3ldI3iztf2EVXo9Fy6eZON4E9APAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.52:from];
	DMARC_NA(0.00)[baylibre.com];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FREEMAIL_TO(0.00)[linaro.org,arm.com,oss.qualcomm.com,baylibre.com,wanadoo.fr];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received,209.85.208.52:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6A0654FEDF
X-Spamd-Bar: --
Message-ID-Hash: VJ7DD2DEEJ3X2HOGN2ZURTF65RRSWK77
X-Message-ID-Hash: VJ7DD2DEEJ3X2HOGN2ZURTF65RRSWK77
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VJ7DD2DEEJ3X2HOGN2ZURTF65RRSWK77/>
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
dGhlIGVycm9yIHJldHVybnMuDQoNClJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJn
QG9zcy5xdWFsY29tbS5jb20+DQpSZXZpZXdlZC1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9s
bGFAYXJtLmNvbT4NClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1r
b2VuaWdAYmF5bGlicmUuY29tPg0KLS0tDQogZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS90cmFu
c3BvcnRzL29wdGVlLmMgfCAxOSArKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Zpcm13YXJlL2FybV9zY21pL3RyYW5zcG9ydHMvb3B0ZWUuYyBiL2RyaXZlcnMvZmlybXdhcmUv
YXJtX3NjbWkvdHJhbnNwb3J0cy9vcHRlZS5jDQppbmRleCA4ZmRiODBkM2ZhYmQuLjA3YWUxOGQ1
Mjc5ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZmlybXdhcmUvYXJtX3NjbWkvdHJhbnNwb3J0cy9v
cHRlZS5jDQorKysgYi9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL3RyYW5zcG9ydHMvb3B0ZWUu
Yw0KQEAgLTUyOSw4ICs1MjksOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBz
Y21pX29mX21hdGNoW10gPSB7DQogREVGSU5FX1NDTUlfVFJBTlNQT1JUX0RSSVZFUihzY21pX29w
dGVlLCBzY21pX29wdGVlX2RyaXZlciwgc2NtaV9vcHRlZV9kZXNjLA0KIAkJCSAgICAgc2NtaV9v
Zl9tYXRjaCwgY29yZSk7DQogDQotc3RhdGljIGludCBzY21pX29wdGVlX3NlcnZpY2VfcHJvYmUo
c3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyBpbnQgc2NtaV9vcHRlZV9zZXJ2aWNlX3Byb2Jl
KHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqc2NtaV9wdGEpDQogew0KKwlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSAmc2NtaV9wdGEtPmRldjsNCiAJc3RydWN0IHNjbWlfb3B0ZWVfYWdlbnQgKmFnZW50
Ow0KIAlzdHJ1Y3QgdGVlX2NvbnRleHQgKnRlZV9jdHg7DQogCWludCByZXQ7DQpAQCAtNTc4LDI0
ICs1NzksMjIgQEAgc3RhdGljIGludCBzY21pX29wdGVlX3NlcnZpY2VfcHJvYmUoc3RydWN0IGRl
dmljZSAqZGV2KQ0KIAlyZXR1cm4gcmV0Ow0KIH0NCiANCi1zdGF0aWMgaW50IHNjbWlfb3B0ZWVf
c2VydmljZV9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyB2b2lkIHNjbWlfb3B0
ZWVfc2VydmljZV9yZW1vdmUoc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICpzY21pX3B0YSkNCiB7
DQogCXN0cnVjdCBzY21pX29wdGVlX2FnZW50ICphZ2VudCA9IHNjbWlfb3B0ZWVfcHJpdmF0ZTsN
CiANCiAJaWYgKCFzY21pX29wdGVlX3ByaXZhdGUpDQotCQlyZXR1cm4gLUVJTlZBTDsNCisJCXJl
dHVybjsNCiANCiAJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJnNjbWlfb3B0ZWVfZHJpdmVy
KTsNCiANCiAJaWYgKCFsaXN0X2VtcHR5KCZzY21pX29wdGVlX3ByaXZhdGUtPmNoYW5uZWxfbGlz
dCkpDQotCQlyZXR1cm4gLUVCVVNZOw0KKwkJcmV0dXJuOw0KIA0KIAkvKiBFbnN1cmUgY2xlYXJl
ZCByZWZlcmVuY2UgaXMgdmlzaWJsZSBiZWZvcmUgcmVzb3VyY2VzIGFyZSByZWxlYXNlZCAqLw0K
IAlzbXBfc3RvcmVfbWIoc2NtaV9vcHRlZV9wcml2YXRlLCBOVUxMKTsNCiANCiAJdGVlX2NsaWVu
dF9jbG9zZV9jb250ZXh0KGFnZW50LT50ZWVfY3R4KTsNCi0NCi0JcmV0dXJuIDA7DQogfQ0KIA0K
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2VfaWQgc2NtaV9vcHRlZV9zZXJ2
aWNlX2lkW10gPSB7DQpAQCAtNjA5LDExICs2MDgsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB0
ZWVfY2xpZW50X2RldmljZV9pZCBzY21pX29wdGVlX3NlcnZpY2VfaWRbXSA9IHsNCiBNT0RVTEVf
REVWSUNFX1RBQkxFKHRlZSwgc2NtaV9vcHRlZV9zZXJ2aWNlX2lkKTsNCiANCiBzdGF0aWMgc3Ry
dWN0IHRlZV9jbGllbnRfZHJpdmVyIHNjbWlfb3B0ZWVfc2VydmljZV9kcml2ZXIgPSB7DQotCS5p
ZF90YWJsZQk9IHNjbWlfb3B0ZWVfc2VydmljZV9pZCwNCi0JLmRyaXZlcgkJPSB7DQorCS5wcm9i
ZSA9IHNjbWlfb3B0ZWVfc2VydmljZV9wcm9iZSwNCisJLnJlbW92ZSA9IHNjbWlfb3B0ZWVfc2Vy
dmljZV9yZW1vdmUsDQorCS5pZF90YWJsZSA9IHNjbWlfb3B0ZWVfc2VydmljZV9pZCwNCisJLmRy
aXZlciA9IHsNCiAJCS5uYW1lID0gInNjbWktb3B0ZWUiLA0KLQkJLnByb2JlID0gc2NtaV9vcHRl
ZV9zZXJ2aWNlX3Byb2JlLA0KLQkJLnJlbW92ZSA9IHNjbWlfb3B0ZWVfc2VydmljZV9yZW1vdmUs
DQogCX0sDQogfTsNCiANCi0tIA0KMi40Ny4zDQoNCg==
