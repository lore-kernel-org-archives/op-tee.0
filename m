Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AAAD4417C
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:00:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AD20D4FB8B
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:00:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=YCHh+2aK;
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5EDB34FFF8
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:02 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477563e28a3so2971355e9.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473361; x=1766078161; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi5/UGBTaIFNW77cWN4A+BHUVzdoSL5Par1+AonNNpI=;
        b=YCHh+2aKs04oRxD/fPdk7ux0QsXw0nAfdczVvUWskM0hbHWhKlsDMuhkMDmCXT2HM/
         DlUFXHk5YAo8AHSudMTxq7kMtaAl9AriwVG5bVkRk1CJxUxWgIq7CuO2MTqQqj+FiZ3d
         QBtzcGNpNRxMGcmCGboZ/pa6jmh9cC1OvzVrPe8UsiwhWwtJje59oD6xw1zf/w2x1Su8
         FqwLe+wg3elkOpBRPV4f03ce42TX80gxUffb73PFTEpygahj6f5XPxBkMxNXUsR1Mhkp
         cklG3Xa07Ilj31N4eGcaqeGCDM0eCA3QyAY6MvIdZll0RluNc2kjkdFXTvW04ZcvYsaB
         LYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473361; x=1766078161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hi5/UGBTaIFNW77cWN4A+BHUVzdoSL5Par1+AonNNpI=;
        b=NItWUano6DjxZ2glOixFeu3qoEsalaKHJuEk3+csIZ2CHqtiMYqAQJiWuVAm2h+3jW
         Gv7tZYUuRSqUW9EptPM1aY2WDeeIgXNkZO7htB2vXsJ8vDQumE9J8Vq3KYKvwSEKn8ko
         KZ4I8rAX4o/zhYcXE0Uu89Q3B50ae9QAAFKx7xhAA5/+mgCSVCtAZdPuJj1ciSS/BGwy
         eMFnILgFIw14akL+TJufJ5emZJC8+lS01tqiA2HqdWhtL5G81JPTOfyS6REie2NafiBw
         sF7NRqj72H2xB3MldEkxIIqixzB87kQvfuabuBgJ7apuEsruPiE+QetMVyZvd94q5HED
         8POw==
X-Forwarded-Encrypted: i=1; AJvYcCV82nrLVhp0zMhHt5+bmPeYWyyuSo5bBQL4x5HL1pqSZG9jnkjEqLqB2VcGFGfpdu0LWl1A5nA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwB5SzbiWjUdsPIVno0ACyaQieoJZayJhsppKvJ2l/8Mxzpt/RL
	SKsp3pyI6xurSsQfJgPwglqJNowIWcKbIufx+Y/PKheZ19CeTXMioUneDMKlE8Ek+tM=
X-Gm-Gg: AY/fxX7qtn7UdLkw5wMlTIuTqUz4TqryspITFNI26Al/7TlS2aBLpBziAbD92uob3++
	ikU9kq1ytDNGGUpAk6HHKwoTNfi34ALsJ0GVxtGsdkCf+n0xZpn5yDRZbpu3zjBLoCdQMj2ofHR
	CzgHC8tx0ef97zzHK/FA1tsHBvHFK7STus85ojXEG5pyRMEP/XJ4cQGb7jy6HqS91JukSabvsL0
	kJxyQJaL1NjAJmInr6AtkC73k/k5XeCduetRXWIxmZLR4klEpNscvNa6StlUwCG+qELoCCSjXM8
	iV4go0QiTRDqY+pZv3ZM5w9NMQtegNtxrXkvfxpyBoYNjEFSJ7brmQ17qMaV/spMUSQ9oeFCS0u
	XN5T/4z2yZaTHqgzU4cMu005XfTf8EjZa0retqfh7dzf461MDlnGbeStU/ha6MDxIS0xmH/WmOK
	QaIN5szoreGoaRZfghZXHMU+YF2H652LvMyzOw/pruYg6Oco37mZru3WaSNX+jQr/Rc+f/LApLu
	oT2ivJvpgFtJA==
X-Google-Smtp-Source: AGHT+IHY5a2mEHV1AlyouwF5+8ViaviivoNCaFkw1PgSwNyXbPnlUyEvOyVbTypMN1j/t55IMaGQ6g==
X-Received: by 2002:a05:600c:190c:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47a8d746f10mr9774955e9.17.1765473361369;
        Thu, 11 Dec 2025 09:16:01 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89f35ae6sm43759865e9.6.2025.12.11.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:01 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 07/17] rtc: optee: Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:15:01 +0100
Message-ID: <a9c8da1b7b2832044129ec9e2616c40e0023ad57.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=AjXr0RnxTKaBv6olXD/4z+FRU9Mi+0TF8cBSgEg6f8g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwlpOdez8ZhYb5hNC93qHUDTTVphLfbIo0cN E8LOH90v7iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8JQAKCRCPgPtYfRL+ Tu6KB/9R/MR/L8dDMQAk3ITRzGaW3NxF1PUGNuhcn+AAeP0p6NBUMyehIjROdQz0/PnL7Zc/QL6 OfGHkdyaP6OArGGH0K0EwPhQPj5RBoJN3L9BZhzwt0V6g536z4sFqL9hcGAuIJTglvMsr6kN3Hg 7qnK+8ufdVV/Ammwt5Uw9Q4BdSiR8b7BitYQoO6kEu3ekvy1Xk/+d9GQ33yjsPk2SAZ/oL76R+o 7nZBEX7iA/9w1OESEQhrM632QEQIv2P+KMl4NBbLVnJ8a+TlnVf7T/Sh+QtGTanBUxVaa7+0He3 3U3AWT0ecAbzOq/jKxvH9fx1I8raUujwbhvQnB+o5VEZPKeB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.49:from];
	DMARC_NA(0.00)[baylibre.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.49:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	BLOCKLISTDE_FAIL(0.00)[209.85.128.49:query timed out,2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5EDB34FFF8
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: GBUNFQPC5K76NRVVH3T2BAA6UWN6CX7J
X-Message-ID-Hash: GBUNFQPC5K76NRVVH3T2BAA6UWN6CX7J
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:47 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GBUNFQPC5K76NRVVH3T2BAA6UWN6CX7J/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBidXMgZ290IGRlZGljYXRlZCBjYWxsYmFja3MgZm9yIHByb2JlIGFuZCByZW1vdmUu
IE1ha2UgdXNlIG9mDQp0aGVzZS4gVGhpcyBmaXhlcyBhIHJ1bnRpbWUgd2FybmluZyBhYm91dCB0
aGUgZHJpdmVyIG5lZWRpbmcgdG8gYmUNCmNvbnZlcnRlZCB0byB0aGUgYnVzIG1ldGhvZHMuDQoN
ClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAYmF5bGli
cmUuY29tPg0KLS0tDQogZHJpdmVycy9ydGMvcnRjLW9wdGVlLmMgfCAxMyArKysrKystLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcnRjL3J0Yy1vcHRlZS5jIGIvZHJpdmVycy9ydGMvcnRjLW9wdGVl
LmMNCmluZGV4IGY5MjRhNzI5ZWFkMC4uZWVmZGU3ODlkMTk0IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ydGMvcnRjLW9wdGVlLmMNCisrKyBiL2RyaXZlcnMvcnRjL3J0Yy1vcHRlZS5jDQpAQCAtNTQ3
LDkgKzU0Nyw5IEBAIHN0YXRpYyBpbnQgb3B0ZWVfY3R4X21hdGNoKHN0cnVjdCB0ZWVfaW9jdGxf
dmVyc2lvbl9kYXRhICp2ZXIsIGNvbnN0IHZvaWQgKmRhdGEpDQogCQlyZXR1cm4gMDsNCiB9DQog
DQotc3RhdGljIGludCBvcHRlZV9ydGNfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRp
YyBpbnQgb3B0ZWVfcnRjX3Byb2JlKHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqcnRjX2Rldmlj
ZSkNCiB7DQotCXN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqcnRjX2RldmljZSA9IHRvX3RlZV9j
bGllbnRfZGV2aWNlKGRldik7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZydGNfZGV2aWNlLT5k
ZXY7DQogCXN0cnVjdCB0ZWVfaW9jdGxfb3Blbl9zZXNzaW9uX2FyZyBzZXNzMl9hcmcgPSB7MH07
DQogCXN0cnVjdCB0ZWVfaW9jdGxfb3Blbl9zZXNzaW9uX2FyZyBzZXNzX2FyZyA9IHswfTsNCiAJ
c3RydWN0IG9wdGVlX3J0YyAqcHJpdjsNCkBAIC02ODIsOCArNjgyLDkgQEAgc3RhdGljIGludCBv
cHRlZV9ydGNfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAlyZXR1cm4gZXJyOw0KIH0NCiAN
Ci1zdGF0aWMgaW50IG9wdGVlX3J0Y19yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRp
YyB2b2lkIG9wdGVlX3J0Y19yZW1vdmUoc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICpydGNfZGV2
aWNlKQ0KIHsNCisJc3RydWN0IGRldmljZSAqZGV2ID0gJnJ0Y19kZXZpY2UtPmRldjsNCiAJc3Ry
dWN0IG9wdGVlX3J0YyAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KIA0KIAlpZiAocHJp
di0+ZmVhdHVyZXMgJiBUQV9SVENfRkVBVFVSRV9BTEFSTSkgew0KQEAgLTY5Niw4ICs2OTcsNiBA
QCBzdGF0aWMgaW50IG9wdGVlX3J0Y19yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAl0ZWVf
c2htX2ZyZWUocHJpdi0+c2htKTsNCiAJdGVlX2NsaWVudF9jbG9zZV9zZXNzaW9uKHByaXYtPmN0
eCwgcHJpdi0+c2Vzc2lvbl9pZCk7DQogCXRlZV9jbGllbnRfY2xvc2VfY29udGV4dChwcml2LT5j
dHgpOw0KLQ0KLQlyZXR1cm4gMDsNCiB9DQogDQogc3RhdGljIGludCBvcHRlZV9ydGNfc3VzcGVu
ZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQpAQCAtNzI0LDEwICs3MjMsMTAgQEAgTU9EVUxFX0RFVklD
RV9UQUJMRSh0ZWUsIG9wdGVlX3J0Y19pZF90YWJsZSk7DQogDQogc3RhdGljIHN0cnVjdCB0ZWVf
Y2xpZW50X2RyaXZlciBvcHRlZV9ydGNfZHJpdmVyID0gew0KIAkuaWRfdGFibGUJPSBvcHRlZV9y
dGNfaWRfdGFibGUsDQorCS5wcm9iZQkJPSBvcHRlZV9ydGNfcHJvYmUsDQorCS5yZW1vdmUJCT0g
b3B0ZWVfcnRjX3JlbW92ZSwNCiAJLmRyaXZlcgkJPSB7DQogCQkubmFtZQkJPSAib3B0ZWVfcnRj
IiwNCi0JCS5wcm9iZQkJPSBvcHRlZV9ydGNfcHJvYmUsDQotCQkucmVtb3ZlCQk9IG9wdGVlX3J0
Y19yZW1vdmUsDQogCQkucG0JCT0gcG1fc2xlZXBfcHRyKCZvcHRlZV9ydGNfcG1fb3BzKSwNCiAJ
fSwNCiB9Ow0KLS0gDQoyLjQ3LjMNCg0K
