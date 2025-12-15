Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC461D5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:24:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E98A74FE8C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:24:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=KLyizUm+;
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BC2E34FEBC
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:49 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64979bee42aso5173393a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808269; x=1766413069; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtA7J2/qth5t0PM6hBWIeoPmBTb33drrrwinTXvOw1g=;
        b=KLyizUm+Gf4cWAGIxGeJaghD26To6XURrEyAXebiRolV91xnhTizUp1RiyGIsWUj7q
         yT7CaPuWKxxef9VbY7Vt2m1OqD2hn5rT8LO8e5BmQ/qajAPt4T0uw894GGHwGwVKwS0Y
         gRz/dFO2f2UtCnmkfeJhFnXFCfYQiqI024FPfwDVwiHDq8Vq0ApHPpGklwgt3JEynNGJ
         DlyYchDEqrsnffwIisoWySv2T88SFyzw9DHEzFwKmN/u52RyjOUm3A5QJ0bM0H2MJyjk
         aaGtWCXAyxtevV3/WYTdCQoBkcP3eOgzeduT4OiJvDhfP+DBkZDt7IdYbVgI/aMwbogn
         YlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808269; x=1766413069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jtA7J2/qth5t0PM6hBWIeoPmBTb33drrrwinTXvOw1g=;
        b=uQ+1w3IIV1rPBWO5fAA8JLhgQlwnRbN0/KOkLP5C67CoYbBba/LzPhDM835EUqHueE
         qpeSkgF3EDFUZVBehVcLpjXsgDk5WsKnGGldS5+axym4v0HW3Ju+rRJPtN4xGr0ppoKU
         E5w3jpPGr/cE1/8uSA3rWGuGr3yMLSB4ggnx5ifxne21a3glUAdKYRx++FoqBVC9PlRA
         6w68NHg/yFoC0fhGzRZbPeydD4AA20eCuuN5xFEZd8xWzRtp0Dmyk0IimW5fjss+xKbM
         ZIWrVK2Tt3qKpkAmjqmxNImuKHgbj9NEGgzaIMHGU+3p/6U4tJUboWXQtJ+tyGp/Vl+5
         DHQA==
X-Forwarded-Encrypted: i=1; AJvYcCU6bjJoBll2OLfxrI0qxkWsgPkF5renA2+WS9CVCffWEUAtPyZdhYS2bmJ6u84YLJpxVT22xvI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx7749bkGUV8bsvSJz5VqZBhL1Pveign/KDbI/CMpJMmD1TYyJ4
	k3eIpteN2dhXnn61sWqVlOiNjo3vsmKaOgfoKVxMA17tNmVxGa6W2KECiLwrpjm2gKA=
X-Gm-Gg: AY/fxX7jMBI3yVJjgTMv7kHejoxWY+kMgMC3SlXLztKsJSMxr9KvRxflkZEn0UyMNl1
	a13IWsQfWVpAr9GE/2qu9PKB56kqwCCIt4ekPExgEgyBIdEtSN4EfOKfO1w4YtXAZ4YkYn2mRb6
	mZrJdX5+of+fzYjCiZSwkzGNf/2hEmH0GcWazmlmFOPJNOtWl25Jkj/cA/APnAFScjVXpJ9gdNa
	e0a4UMoH6soOInt0wgzRT+EMz5qfKtay66YsN94pdFe+B1c1llh+8p9uaNc4l7pzaSHRHh5MUSJ
	fT6JK6wfmxwigvdWycSgEDO+JAohiRTOomb6ETcWdAr4WeXJvMDWIIIIOTowmb3zFtaV9fpkQtq
	qqpzH9k1CjblKaA8Op9goTJPhWCJhiHVDBJTC40ou5hliOiwN/f/QbeEYF/Hwp1tVrYlPPUieb6
	Z1Y4G7H0X8U2e+RLsbtjT6SwQ0G/q4cG8YHAH/xavFb1sbXiPQWfXTfh41uw==
X-Google-Smtp-Source: AGHT+IFv/1u5W9CnoFiaYoPlvVQjDIdpfyxbrw8ig3P6eLn1uHC5BYn5sqa+mcQbAnC/+TOxgPrUcw==
X-Received: by 2002:a05:6402:2747:b0:640:abd5:863d with SMTP id 4fb4d7f45d1cf-6499b1c2a09mr11674219a12.20.1765808268604;
        Mon, 15 Dec 2025 06:17:48 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6498210ed32sm13548630a12.29.2025.12.15.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:48 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [PATCH v2 09/17] efi: stmm: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:39 +0100
Message-ID: <b70ad65c88a82cf56c93cf17cf326213f8273e37.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=U2aCK4CwX4oX996AKQXtxl/fnEvZCMh7YIAYyx6fXTo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhiuTDaNseAt3EsBljDKzQwacM+pSRuQiPAQ arTLi9z4TCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYYgAKCRCPgPtYfRL+ TnPbB/93KOuWIwDOJ283H+/wb1IIrgxqlC+DspRkdayu/Cjo2Z3TLbCwKyVMa5P6gZTnCDpH9Si 8rY5VZw8XaCqtqlLyVXjKit0WM5xeWDSRTlO+Q9WpokHiBxGfYIyP6YwTr+uo5OUlZshddxiDMz 2SQfGZcAHDksHjUDaPeVnlK7IUY6b0gcAmXFtPxNMEs4g1V8A58bIiOWqeAH6qjmW/P1Cxu7xac jYyR+lv+iCEhcIfMPVN9z2+RE8RmB7GbwgvuIPvs3GJJEULWKqdkcmdpkMlwQ48qO2LpQPvrvw2 Iu45H6xt8WaFrlDiRp+l+5sICtpI1uY89HTZulc2m2fYD7tb
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com,baylibre.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.48:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.48:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BC2E34FEBC
X-Spamd-Bar: /
Message-ID-Hash: 7MRVOZRBP4QKNWL56TTEPC4REXFEFEHH
X-Message-ID-Hash: 7MRVOZRBP4QKNWL56TTEPC4REXFEFEHH
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7MRVOZRBP4QKNWL56TTEPC4REXFEFEHH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBidXMgZ290IGRlZGljYXRlZCBjYWxsYmFja3MgZm9yIHByb2JlIGFuZCByZW1vdmUu
DQpNYWtlIHVzZSBvZiB0aGVzZS4gVGhpcyBmaXhlcyBhIHJ1bnRpbWUgd2FybmluZyBhYm91dCB0
aGUgZHJpdmVyIG5lZWRpbmcNCnRvIGJlIGNvbnZlcnRlZCB0byB0aGUgYnVzIG1ldGhvZHMuDQoN
ClJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQGJheWxpYnJl
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZmlybXdhcmUvZWZpL3N0bW0vdGVlX3N0bW1fZWZpLmMgfCAx
MSArKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9zdG1tL3RlZV9zdG1t
X2VmaS5jIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvc3RtbS90ZWVfc3RtbV9lZmkuYw0KaW5kZXgg
NTkwMzgxMTg1OGI2Li43YjA0ZGQ2NDk2MjkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Zpcm13YXJl
L2VmaS9zdG1tL3RlZV9zdG1tX2VmaS5jDQorKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9zdG1t
L3RlZV9zdG1tX2VmaS5jDQpAQCAtNTIwLDggKzUyMCw5IEBAIHN0YXRpYyB2b2lkIHRlZV9zdG1t
X3Jlc3RvcmVfZWZpdmFyc19nZW5lcmljX29wcyh2b2lkKQ0KIAllZml2YXJzX2dlbmVyaWNfb3Bz
X3JlZ2lzdGVyKCk7DQogfQ0KIA0KLXN0YXRpYyBpbnQgdGVlX3N0bW1fZWZpX3Byb2JlKHN0cnVj
dCBkZXZpY2UgKmRldikNCitzdGF0aWMgaW50IHRlZV9zdG1tX2VmaV9wcm9iZShzdHJ1Y3QgdGVl
X2NsaWVudF9kZXZpY2UgKnRlZV9kZXYpDQogew0KKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmdGVl
X2Rldi0+ZGV2Ow0KIAlzdHJ1Y3QgdGVlX2lvY3RsX29wZW5fc2Vzc2lvbl9hcmcgc2Vzc19hcmc7
DQogCWVmaV9zdGF0dXNfdCByZXQ7DQogCWludCByYzsNCkBAIC01NzEsMjEgKzU3MiwxOSBAQCBz
dGF0aWMgaW50IHRlZV9zdG1tX2VmaV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCXJldHVy
biAwOw0KIH0NCiANCi1zdGF0aWMgaW50IHRlZV9zdG1tX2VmaV9yZW1vdmUoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KK3N0YXRpYyB2b2lkIHRlZV9zdG1tX2VmaV9yZW1vdmUoc3RydWN0IHRlZV9jbGll
bnRfZGV2aWNlICpkZXYpDQogew0KIAl0ZWVfc3RtbV9yZXN0b3JlX2VmaXZhcnNfZ2VuZXJpY19v
cHMoKTsNCi0NCi0JcmV0dXJuIDA7DQogfQ0KIA0KIE1PRFVMRV9ERVZJQ0VfVEFCTEUodGVlLCB0
ZWVfc3RtbV9lZmlfaWRfdGFibGUpOw0KIA0KIHN0YXRpYyBzdHJ1Y3QgdGVlX2NsaWVudF9kcml2
ZXIgdGVlX3N0bW1fZWZpX2RyaXZlciA9IHsNCiAJLmlkX3RhYmxlCT0gdGVlX3N0bW1fZWZpX2lk
X3RhYmxlLA0KKwkucHJvYmUJCT0gdGVlX3N0bW1fZWZpX3Byb2JlLA0KKwkucmVtb3ZlCQk9IHRl
ZV9zdG1tX2VmaV9yZW1vdmUsDQogCS5kcml2ZXIJCT0gew0KIAkJLm5hbWUJCT0gInRlZS1zdG1t
LWVmaSIsDQotCQkucHJvYmUJCT0gdGVlX3N0bW1fZWZpX3Byb2JlLA0KLQkJLnJlbW92ZQkJPSB0
ZWVfc3RtbV9lZmlfcmVtb3ZlLA0KIAl9LA0KIH07DQogDQotLSANCjIuNDcuMw0KDQo=
