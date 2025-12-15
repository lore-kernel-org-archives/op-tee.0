Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2B8D5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:22:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3CE5F4FECE
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:22:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=P4MXkiLa;
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 909654FE8C
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:46 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7636c96b9aso581940766b.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808265; x=1766413065; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DstP1u05CPAHjOAUetfVzJW1wXxCkT+pjUtyyoYANxU=;
        b=P4MXkiLa8RMbSTnVhfNeBQW4D6b96IDratWr4H4KJpHy68bRNvQXNax7svMCrmwaRk
         5f0TxaEEeQ1W6c4lZvcspYXUlIvPbXW88hntJKpWFCwb38mt0XPSFCdd0BB3YoonLN8Y
         eLp+dQ/gudLmGVVn8GwC7oz6fMq/xGoPAMtiPQIcyKCiF5s9HXWK0cnv1ndJW/SrQ6iw
         MjeypUvYT7V2ZtcRkNhS73JNP9SVZD96ajgjPgHCik7jwx4Q2SgA4pd/kZEJvsafmVR+
         L++J6OxSakLZqubkS0JjA5cVb7Zk2eg37KP7cBRETB/f6V+uYkZDC8xl0KTf+3iiA4U8
         IOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808265; x=1766413065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DstP1u05CPAHjOAUetfVzJW1wXxCkT+pjUtyyoYANxU=;
        b=lwGq97VKkXOpb3h0LxGqAX2IujnVXhlMUOcyOK2+iQJyeWzJ+uPFrK/aaOzqscH4Ze
         IZxrgad5d4J/LfHyFg2eEhTOmgLS30JpjfwvGE5StiDdkpEVndRGBlC9LnklEWvEPQY0
         vWiydxCT1lYmwjffeWtkjGEmQM0VlzCcbG8/uz2XCpc/7eJeJ6EJQ5w2PQOde+ANmVzt
         zgCYcUNeT9V6HMxrqoYO7k33CtTw6a7Ty7puq0hvZuTM/mfXUbWu8v46bUNCGS32tla/
         t6LLlRRO0Ztg8Ch763UBPDTn/3ZL0wEa5sJHRfT2CwkmQJL9HlMDwTTiuywbqDUqicVe
         FJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi/Qahbjc8JxfnXRj3vh3S5S5ctz1xST1s7Z0Q39oXAwhNay0Vpf8leVxtJz+f118a8c1p1pc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YySX++MgMlu9r/ru/P4yeebwI6HU6n3iUuSXfQM9JRJ1Y3IlPWy
	15lbAVIDhjPflt/cZ4d0t/sYeGXuquS/8t5VlI69ipqlwlX81HAVuvKticI3yXKTxSx4n16y2eq
	z7Ny+
X-Gm-Gg: AY/fxX56HbCDyoWZ3KrID/dHAMxL/ETki6pONNC4lRSunLmME99EVwaQye9GKRE4vK0
	wEBAZynAETpQAQ4zXoLV06TQuOOoaGZNbKiEFXjFO0O6yo/yWI/g7IFys0TFM0P5Ixr7S7yJ6cF
	PD9IaebEHWz29l6MwkKqYrd/IG+Zya/ZZzDkFAqNv+SAF0Oz2pcnf1UQgseD9YGQ0OraloXY227
	QEDKC172LU+v5FhROK6MoM4KMBmMLGddEfbakjMfic/Pp5fg5OVu/lz5wWe6YYb3reNq5khJG0E
	H45X+nl4PDp/x7OGVynLUS0MFS8GYxnIgiApeLYLqf0Q7f+wnqOvF/btK6ZFLEfguBDXWpugGKu
	eQ5+ltLio86Gun0dnBVha2ENAdbTG3R6uE1lzwrTTb4FpfYlWJRZMe/JJi30clETka8QrPsb4ew
	OJELeJ60UFCIk4tZq45nD6tV26BDkL70dsxT8Ri4Xy4MOuy/BIdJRcSSUgKg==
X-Google-Smtp-Source: AGHT+IG0aR1aVYo2hR9RY9GcMGEh3RQBWvatdAkF4IYLW7cEYQ+IwII2kbMYm7+RM3tx3GVb8FNltA==
X-Received: by 2002:a17:907:3c89:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b7d236b62a1mr1080879566b.28.1765808265489;
        Mon, 15 Dec 2025 06:17:45 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa29f6cbsm1438920266b.5.2025.12.15.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:45 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 07/17] rtc: optee: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:37 +0100
Message-ID: <c4f7d5f1aac1af2b11a520b409b0c22366be84d3.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ikmzIlbOd+LEhbyDv3j+DT9OAKYhGjQzZlQGjQMpYL8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBheMbvEqJBwhAhTqzRRzs/PHvyCJQxdPljAW tHVglfhLtOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYXgAKCRCPgPtYfRL+ TutZB/wIvA2FIQU9tGTYvprs23GCWKp5tv902PnEn1WRPNA2wqjSj8Et20EmH8sojRdzzDJRsSa QNyyrBuRRrXRk+hnLGBnG5qTINCrKGW6TpoBHjLH5oDpUe9MoqbkKi4dLGxYIMTV7DNp7ANGg50 qdv6a7E3IcMB2qYuhJzPC4b1uQ/PiQcd0xej78j8Y1CY+fCPH1i0kLC3Hk5nHsHd/zftj/dBn56 DEd0WTmplWXVg9eMG/rwS8Q9+9ROV3yQ4+Jxcm4TfSpezTMHurNx0RFJxPWzBxWtblzX3tXFZsT 14C1B+SHAWvizy9CoqaogXbeS/QgQaxL+lyhvYrb9UaRJMjL
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.52:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.52:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 909654FE8C
X-Spamd-Bar: --
Message-ID-Hash: KD7L6V6UP2UARFQ6LLZFC2EZ6ZUZNZHU
X-Message-ID-Hash: KD7L6V6UP2UARFQ6LLZFC2EZ6ZUZNZHU
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KD7L6V6UP2UARFQ6LLZFC2EZ6ZUZNZHU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBidXMgZ290IGRlZGljYXRlZCBjYWxsYmFja3MgZm9yIHByb2JlIGFuZCByZW1vdmUu
IE1ha2UgdXNlIG9mDQp0aGVzZS4gVGhpcyBmaXhlcyBhIHJ1bnRpbWUgd2FybmluZyBhYm91dCB0
aGUgZHJpdmVyIG5lZWRpbmcgdG8gYmUNCmNvbnZlcnRlZCB0byB0aGUgYnVzIG1ldGhvZHMuDQoN
ClJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQpB
Y2tlZC1ieTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29t
Pg0KU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BiYXls
aWJyZS5jb20+DQotLS0NCiBkcml2ZXJzL3J0Yy9ydGMtb3B0ZWUuYyB8IDEzICsrKysrKy0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLW9wdGVlLmMgYi9kcml2ZXJzL3J0Yy9ydGMtb3B0
ZWUuYw0KaW5kZXggZjkyNGE3MjllYWQwLi5lZWZkZTc4OWQxOTQgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3J0Yy9ydGMtb3B0ZWUuYw0KKysrIGIvZHJpdmVycy9ydGMvcnRjLW9wdGVlLmMNCkBAIC01
NDcsOSArNTQ3LDkgQEAgc3RhdGljIGludCBvcHRlZV9jdHhfbWF0Y2goc3RydWN0IHRlZV9pb2N0
bF92ZXJzaW9uX2RhdGEgKnZlciwgY29uc3Qgdm9pZCAqZGF0YSkNCiAJCXJldHVybiAwOw0KIH0N
CiANCi1zdGF0aWMgaW50IG9wdGVlX3J0Y19wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorc3Rh
dGljIGludCBvcHRlZV9ydGNfcHJvYmUoc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICpydGNfZGV2
aWNlKQ0KIHsNCi0Jc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICpydGNfZGV2aWNlID0gdG9fdGVl
X2NsaWVudF9kZXZpY2UoZGV2KTsNCisJc3RydWN0IGRldmljZSAqZGV2ID0gJnJ0Y19kZXZpY2Ut
PmRldjsNCiAJc3RydWN0IHRlZV9pb2N0bF9vcGVuX3Nlc3Npb25fYXJnIHNlc3MyX2FyZyA9IHsw
fTsNCiAJc3RydWN0IHRlZV9pb2N0bF9vcGVuX3Nlc3Npb25fYXJnIHNlc3NfYXJnID0gezB9Ow0K
IAlzdHJ1Y3Qgb3B0ZWVfcnRjICpwcml2Ow0KQEAgLTY4Miw4ICs2ODIsOSBAQCBzdGF0aWMgaW50
IG9wdGVlX3J0Y19wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCXJldHVybiBlcnI7DQogfQ0K
IA0KLXN0YXRpYyBpbnQgb3B0ZWVfcnRjX3JlbW92ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorc3Rh
dGljIHZvaWQgb3B0ZWVfcnRjX3JlbW92ZShzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2UgKnJ0Y19k
ZXZpY2UpDQogew0KKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcnRjX2RldmljZS0+ZGV2Ow0KIAlz
dHJ1Y3Qgb3B0ZWVfcnRjICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogDQogCWlmIChw
cml2LT5mZWF0dXJlcyAmIFRBX1JUQ19GRUFUVVJFX0FMQVJNKSB7DQpAQCAtNjk2LDggKzY5Nyw2
IEBAIHN0YXRpYyBpbnQgb3B0ZWVfcnRjX3JlbW92ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCXRl
ZV9zaG1fZnJlZShwcml2LT5zaG0pOw0KIAl0ZWVfY2xpZW50X2Nsb3NlX3Nlc3Npb24ocHJpdi0+
Y3R4LCBwcml2LT5zZXNzaW9uX2lkKTsNCiAJdGVlX2NsaWVudF9jbG9zZV9jb250ZXh0KHByaXYt
PmN0eCk7DQotDQotCXJldHVybiAwOw0KIH0NCiANCiBzdGF0aWMgaW50IG9wdGVlX3J0Y19zdXNw
ZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCkBAIC03MjQsMTAgKzcyMywxMCBAQCBNT0RVTEVfREVW
SUNFX1RBQkxFKHRlZSwgb3B0ZWVfcnRjX2lkX3RhYmxlKTsNCiANCiBzdGF0aWMgc3RydWN0IHRl
ZV9jbGllbnRfZHJpdmVyIG9wdGVlX3J0Y19kcml2ZXIgPSB7DQogCS5pZF90YWJsZQk9IG9wdGVl
X3J0Y19pZF90YWJsZSwNCisJLnByb2JlCQk9IG9wdGVlX3J0Y19wcm9iZSwNCisJLnJlbW92ZQkJ
PSBvcHRlZV9ydGNfcmVtb3ZlLA0KIAkuZHJpdmVyCQk9IHsNCiAJCS5uYW1lCQk9ICJvcHRlZV9y
dGMiLA0KLQkJLnByb2JlCQk9IG9wdGVlX3J0Y19wcm9iZSwNCi0JCS5yZW1vdmUJCT0gb3B0ZWVf
cnRjX3JlbW92ZSwNCiAJCS5wbQkJPSBwbV9zbGVlcF9wdHIoJm9wdGVlX3J0Y19wbV9vcHMpLA0K
IAl9LA0KIH07DQotLSANCjIuNDcuMw0KDQo=
