Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C31DD5B16C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:24:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B4B644FE93
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:24:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=qcjDnNhO;
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 022A04FEDA
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:52 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6499159273dso4304716a12.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808271; x=1766413071; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKbJnfJE7xkWU00mrWTEhz/b//1iCTobbbTcn9iMvYI=;
        b=qcjDnNhONLrRTNx/iCjGCqiLeSlTd8ddO0Wwoi4UvzXqUKWkfLt9s3PdtgdlnPLbIW
         sMJ9Ga0xY1AhbLIiWC2lkx9VJTlqXevWOPYQXHRLqQn8Y80N+Dmbm4lyQlqK7XHu3IJS
         CXtDz19ZbAhrwQhLbONvNA7+qluhSSXMOzRo8JWCJ/hq/7I3vjCq2BZfV82N2SKICbnY
         AZ6SKuijTIwuPhamqW8ejBpVqpfdm89g0ff1UwXJ6nqJfY6IYifPQBVwtIiAWuwiMIE3
         542PdqggnXQuHVqLMOBoXC1N2MMkRVHkNGS9LizCjNYSF1yaaYs13znUS2vPyf19poNe
         OxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808271; x=1766413071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZKbJnfJE7xkWU00mrWTEhz/b//1iCTobbbTcn9iMvYI=;
        b=inYPYdoAXi5pO5qw1Oit9mZZnPZMbOyZWgJMtMifXr9P/bQ1L8nCIkr1BHsE34i62h
         jjvYg1EYkfsnzcY5G0AhLu0qLkETKUXYcuVglRTl8XNJEgoM/7xVuAW1H3ZOm5fxaEPz
         OvxWc/zcHevoq1gpl1zB5LXDEEADa8j4DcarWHED+d0sLvC0M1AWznIQW1x/4SajxXVr
         WLtXM8gSqCFLlsxwrrVWYMypgExW0M0WuMgjgSWQIO+negM5JkBj+Ec3zwX2Cz1IN2XL
         XMdywGM/v6dyLItbKZYdi3QAZGA3cr/AfuAcKBZcZbjAtgfcqX9YJJ41tVpmcCcrboz0
         SFvw==
X-Forwarded-Encrypted: i=1; AJvYcCUjoPWpeMRbVcynKLARpG4NYRSBbonsocGDbFo+G0TLUlUsy8sbOQphMDH7nlCUWw5vUqVvtCs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yze7MgwjK4HjcMuTVAei5oIrC5pVAcFuVtQPZ/3EOBzWTlj0qtg
	A/R9RfqworFOzdv/dZwT9jeY3AW84JaMeQn1yPjp3jGzaTPXtYA39/lhx9djfJcx41U=
X-Gm-Gg: AY/fxX7u9reP1Ye9hRSO3fuyQbDaOoCrTITJ6dW7lAoa1hixtf54AtMb1DjewqzhYAu
	PiR0iw76/oglKlpxKTjSQVRI4K/5wk0y/m6qO60yQmGRXv/KwlrYsoX3MyuYyfdooWzYypX7Y6B
	RZ/v6SDkpo0QJICpUxzquicCOYrUfjCz1rAGshjcqKrhSzjKmra2N7gDBsBGDzvfOmh9SH8Y5xj
	zkAdXxHqTWVCwgANryDLXV2A5i1u7Bxs3C8nYxnQ+gP8vX6H1HeafTfIgqmzUJse5buoBo5kCn7
	UbMBPzbaO4w39PeAzMxAebIZO0jGRhz63/be9aODzkenXAak8lww0kgCSC9hPPoqLe6TIdJ1PgP
	J73/6hOVZtjG4l2X7jbYn7EoJeUeUrAskJSidcsZ/3vPmq7uhXKSrh4S4kTLvHMeh5AG9ylpZ+P
	LnCdXf+D18EP4qQebd66OAjBx+txJXovAl+Deg4vF1KIOcj8crJi1/bG3YEg==
X-Google-Smtp-Source: AGHT+IEeSJVfJZs2amYWw+KLmEmBNVhUpqN/6+ZL8YgyOFyTuCX5haEwqwHXINz3XjvZu+mkawojpw==
X-Received: by 2002:a05:6402:5190:b0:649:cafc:2656 with SMTP id 4fb4d7f45d1cf-649cafc26c4mr4434360a12.11.1765808270921;
        Mon, 15 Dec 2025 06:17:50 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6498204fbb3sm13523660a12.8.2025.12.15.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:50 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 10/17] firmware: arm_scmi: optee: Make use of module_tee_client_driver()
Date: Mon, 15 Dec 2025 15:16:40 +0100
Message-ID: <983988a9020a2829bbedfd599fb6a52f8867e37b.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=djoazKNFNWBpRKVOu8VgnZQUMBy5m2efHrrhLCTajBI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhlaY2qxCEcyR8weby9a0kZHvfdpLdOH2fIH cLAkAUU1SWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYZQAKCRCPgPtYfRL+ Tm8KCACFX8eQzR1FU1YYCPyj7bjkaPb1IJMAne74xoK4zA3MizdDdnVj2jg38iTR72qB2ShDcYl m5G5Mnl8h4+UfOlGR5qzEmCbu89xesxDd20Sw95hoAUVz0pmelASWucFk/Jd6VnV3rG/n7NZo22 +3EQyvtFlSVGKdWFk2qXUJxXteCmVDN7EZGLLs0sR9tZ1VSESx2gPy+4AKC1jd7FYaliy79sV53 VKQyVvFcddYJFYjP6hQxEvlwnEScer6VulhTzAxgkG2lUsElYoPUmoSnEu0FQInj+ge7ThPx9HV g+mRx396gQ39PUOMdWVo9ck0W7i0qCVcz3/vA9UQ+E7jL/UP
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.45:from];
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
	DNSWL_BLOCKED(0.00)[46.5.122.62:received,209.85.208.45:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 022A04FEDA
X-Spamd-Bar: --
Message-ID-Hash: YN35IB6VBYSGBY77M7M44TUMQDSJX63A
X-Message-ID-Hash: YN35IB6VBYSGBY77M7M44TUMQDSJX63A
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YN35IB6VBYSGBY77M7M44TUMQDSJX63A/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

UmVkdWNlIGJvaWxlcnBsYXRlIGJ5IHVzaW5nIHRoZSBuZXdseSBpbnRyb2R1Y2VkIG1vZHVsZV90
ZWVfY2xpZW50X2RyaXZlcigpLg0KVGhhdCB0YWtlcyBjYXJlIG9mIGFzc2lnbmluZyB0aGUgZHJp
dmVyJ3MgYnVzLCBzbyB0aGUgZXhwbGljaXQgYXNzaWduaW5nDQppbiB0aGlzIGRyaXZlciBjYW4g
YmUgZHJvcHBlZC4NCg0KUmV2aWV3ZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1
YWxjb21tLmNvbT4NClJldmlld2VkLWJ5OiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0u
Y29tPg0KU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0Bi
YXlsaWJyZS5jb20+DQotLS0NCiBkcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL3RyYW5zcG9ydHMv
b3B0ZWUuYyB8IDEzICstLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9hcm1f
c2NtaS90cmFuc3BvcnRzL29wdGVlLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL3RyYW5z
cG9ydHMvb3B0ZWUuYw0KaW5kZXggZGMwZjQ2MzQwMTUzLi44ZmRiODBkM2ZhYmQgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL3RyYW5zcG9ydHMvb3B0ZWUuYw0KKysrIGIv
ZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS90cmFuc3BvcnRzL29wdGVlLmMNCkBAIC02MTIsMjMg
KzYxMiwxMiBAQCBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIHNjbWlfb3B0ZWVfc2Vy
dmljZV9kcml2ZXIgPSB7DQogCS5pZF90YWJsZQk9IHNjbWlfb3B0ZWVfc2VydmljZV9pZCwNCiAJ
LmRyaXZlcgkJPSB7DQogCQkubmFtZSA9ICJzY21pLW9wdGVlIiwNCi0JCS5idXMgPSAmdGVlX2J1
c190eXBlLA0KIAkJLnByb2JlID0gc2NtaV9vcHRlZV9zZXJ2aWNlX3Byb2JlLA0KIAkJLnJlbW92
ZSA9IHNjbWlfb3B0ZWVfc2VydmljZV9yZW1vdmUsDQogCX0sDQogfTsNCiANCi1zdGF0aWMgaW50
IF9faW5pdCBzY21pX3RyYW5zcG9ydF9vcHRlZV9pbml0KHZvaWQpDQotew0KLQlyZXR1cm4gZHJp
dmVyX3JlZ2lzdGVyKCZzY21pX29wdGVlX3NlcnZpY2VfZHJpdmVyLmRyaXZlcik7DQotfQ0KLW1v
ZHVsZV9pbml0KHNjbWlfdHJhbnNwb3J0X29wdGVlX2luaXQpOw0KLQ0KLXN0YXRpYyB2b2lkIF9f
ZXhpdCBzY21pX3RyYW5zcG9ydF9vcHRlZV9leGl0KHZvaWQpDQotew0KLQlkcml2ZXJfdW5yZWdp
c3Rlcigmc2NtaV9vcHRlZV9zZXJ2aWNlX2RyaXZlci5kcml2ZXIpOw0KLX0NCi1tb2R1bGVfZXhp
dChzY21pX3RyYW5zcG9ydF9vcHRlZV9leGl0KTsNCittb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIo
c2NtaV9vcHRlZV9zZXJ2aWNlX2RyaXZlcik7DQogDQogTU9EVUxFX0FVVEhPUigiRXRpZW5uZSBD
YXJyaWVyZSA8ZXRpZW5uZS5jYXJyaWVyZUBmb3NzLnN0LmNvbT4iKTsNCiBNT0RVTEVfREVTQ1JJ
UFRJT04oIlNDTUkgT1BURUUgVHJhbnNwb3J0IGRyaXZlciIpOw0KLS0gDQoyLjQ3LjMNCg0K
