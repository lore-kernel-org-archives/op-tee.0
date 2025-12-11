Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE03D4417C
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:00:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7F6E44FCB9
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:00:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=i/BItLz+;
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4D24843248
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:01 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47790b080e4so2051965e9.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473360; x=1766078160; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JeA5gq6kRi4Lyd+VAOvX0wqPm9BAkVnCbcQJTu0Rxw=;
        b=i/BItLz+h/R4zUq6Ep0pS/amANOMs6Ry7eHaFvQ6yFXKz/iHSG+lMXMUc4pWsZeeZc
         rzXJ9loXiFN5IvnQiMhwz8z9/G3Xh+wD2HWHSzmAM5diKOVBp5Pux1b1c0rak+9RwEqO
         Sc2mGitVXEsN7ves37ScZ6NbbQ+4qx6bMr4kHFF9gpYKxfTm8xeDTSPkwKnCe+Ob1nJg
         WMTNc5fuLd4FszWM6A+UZ20k8x+WRmu8AH3wv1xQW6PZ2/7jbpnFepuvCTKpLAJ2MZJf
         zjiGPvMycKHzxnpq48p1r+GWZJKXsMijjnDgcGtwUqH0nfDeV1Ow/7103MUwAmgRHaRt
         +krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473360; x=1766078160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JeA5gq6kRi4Lyd+VAOvX0wqPm9BAkVnCbcQJTu0Rxw=;
        b=ecrUnf9MGbtjLRNWywqFLyLQVEO+s7aHRjgAgl/5PMfYOgTZi2bGT0h+XzpIh7h7OQ
         vir6WcrTymOdsnZOu/TrrXWpOdv9HWZPIJkOzGtvYlr5yk+WAaZ4xfqaWwcBnm0lH1OC
         UJMcJ2122l6/7ZyEo8p3yDHRp1yX406lUeYGBBesZ+RqpKSGIAQaoOerdX7ocVZIbLrZ
         emvyQfYDicuW1AjJueeXHSmqtV6gzr4TUC19PqXkfGIxRns/HJDzbWUd1gNNu3vFPl12
         E9Ts5hPSyPzxrcHnSVhRN3x1HE8KtjxP36d1gpd8ql5URONWhHBtTJcndDALd7FrPLZw
         PIbw==
X-Forwarded-Encrypted: i=1; AJvYcCWVW1ZG+wEjHmY9uvaxqEwj8Tl0PSM81Dx+RJ+c3GwdLb7JGHZNykjRgppOE2uKjZ/Wm90x25M=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxKVrUXquwHn98I77NPfx4o1CbHLYEeO6P1o5Qv0Bj294xPHnU5
	Zbk+qc/ROzsXtdpQT1Dn492ukTFQfbpoTWmijdFU4vcwPSpVwmdgzm4hWtUIgOeRcbM=
X-Gm-Gg: AY/fxX5BcDeTTcdwVpl4BDG9XfCKhOwmzboBlgjjLFTeN2z40w8YS96Nf9RPf5vCxeT
	a4z0dpcUcQ1wU3QCdk7c7gainrg5YqeFL14oF1aJNGrlTILwsym37N995wG4WDwDQZmWSYVsVW0
	1SLIiQQYPg3Q9iO5L/uxT0lTf1S3GYDT7Iq4P32ztU8rL8EvxqMOtd77U9pz27UZsCq8jJGJ3U0
	EQOW1Jn24iUvkrtoV7qJf+ceyDh2DVqOStui1SphM8eTetFZlXu27ljes6SFzwJjFdCF6zT/E7/
	95dW7ozOj5IoM4Uh8/LaZSlySEkYQgqEXiDddnY+Ei4NIFkt4d3rw8c7z3+cLgEX8elHTW528cw
	zO8ScgpsAAvgxFRvqqKVdD/6wDQ04opWtStij+bjkTJo4wJGDCGId4F3VrKkJVKsEe2ITs6CF0x
	Q4Suj7Gu79zre1TD0B4kGHl9igW/HLR1Gw1uJx8lf4kV4oH8m+Bf76bhUxWhkBgB1ntDfO2Z0Cb
	VYdA8BGsNmvcg==
X-Google-Smtp-Source: AGHT+IG/NQc3Y5Xt3abMDqEbPYOZHmotYsONgdb/bGoMIyIIzzMZ1acDR16pUEw26tEqcueZJ6sXRQ==
X-Received: by 2002:a05:600c:8207:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-47a83804375mr67687815e9.13.1765473360269;
        Thu, 11 Dec 2025 09:16:00 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89ef954asm47349765e9.10.2025.12.11.09.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:15:59 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 06/17] rtc: optee: Migrate to use tee specific driver registration function
Date: Thu, 11 Dec 2025 18:15:00 +0100
Message-ID: <a586934215a4971f9920398655cb85fd29d91c9f.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KbP7EtIirsjcRAVahUftVfemTrSz9aRFfaaIcH7+JL8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwiVjxH75Z6V50l5vwIkZOM4q9gf3DvDfDBz Rf+99hzFmyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8IgAKCRCPgPtYfRL+ TsWFB/sETCAgBSQbnWadmTkVaxUsX0RQ9keYFWz9xaj+ZG8EblKQPnZlpyxpCfxRZdba4NgHXCR p4f7Q7PUDE51bxiwpQV1v7pZM53XSF8Yugau8J/vt2j7z04FHsasETvyeLc9k24wy5OERHU/7HD 6kaptYCge7hFfQXdGGciUwf6raZqq5dww2Tkqm3Qv7x4p7mzeql9dW8ydUNN852Rkb9ySfPaYTT a6Q7ZxOqowSsSkidxfXID5+uFyELafRGsTEK7P+OPQzNQkFUebTB8uSE3D9RWWUnmSKo5SKYoK4 uvyChsBQUxiQqtP3K6Hos1EqHSmbdGSvMc78yl2iMymDW94L
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
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.42:from];
	DMARC_NA(0.00)[baylibre.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.42:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out,209.85.128.42:query timed out];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4D24843248
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: QUYLOA2NUDOF7BT3T4NV6YN3GA6OZJON
X-Message-ID-Hash: QUYLOA2NUDOF7BT3T4NV6YN3GA6OZJON
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:47 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QUYLOA2NUDOF7BT3T4NV6YN3GA6OZJON/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBzdWJzeXN0ZW0gcmVjZW50bHkgZ290IGEgc2V0IG9mIGRlZGljYXRlZCBmdW5jdGlv
bnMgdG8gcmVnaXN0ZXINCihhbmQgdW5yZWdpc3RlcikgYSB0ZWUgZHJpdmVyLiBNYWtlIHVzZSBv
ZiB0aGVtLiBUaGVzZSBjYXJlIGZvciBzZXR0aW5nIHRoZQ0KZHJpdmVyJ3MgYnVzIChzbyB0aGUg
ZXhwbGljaXQgYXNzaWdubWVudCBjYW4gYmUgZHJvcHBlZCkgYW5kIHRoZSBkcml2ZXINCm93bmVy
ICh3aGljaCBpcyBhbiBpbXByb3ZlbWVudCB0aGlzIGRyaXZlciBiZW5lZml0cyBmcm9tKS4NCg0K
U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJy
ZS5jb20+DQotLS0NCiBkcml2ZXJzL3J0Yy9ydGMtb3B0ZWUuYyB8IDE0ICstLS0tLS0tLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxMyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcnRjL3J0Yy1vcHRlZS5jIGIvZHJpdmVycy9ydGMvcnRjLW9wdGVl
LmMNCmluZGV4IDE4NGM2ZDE0MjgwMS4uZjkyNGE3MjllYWQwIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ydGMvcnRjLW9wdGVlLmMNCisrKyBiL2RyaXZlcnMvcnRjL3J0Yy1vcHRlZS5jDQpAQCAtNzI2
LDI1ICs3MjYsMTMgQEAgc3RhdGljIHN0cnVjdCB0ZWVfY2xpZW50X2RyaXZlciBvcHRlZV9ydGNf
ZHJpdmVyID0gew0KIAkuaWRfdGFibGUJPSBvcHRlZV9ydGNfaWRfdGFibGUsDQogCS5kcml2ZXIJ
CT0gew0KIAkJLm5hbWUJCT0gIm9wdGVlX3J0YyIsDQotCQkuYnVzCQk9ICZ0ZWVfYnVzX3R5cGUs
DQogCQkucHJvYmUJCT0gb3B0ZWVfcnRjX3Byb2JlLA0KIAkJLnJlbW92ZQkJPSBvcHRlZV9ydGNf
cmVtb3ZlLA0KIAkJLnBtCQk9IHBtX3NsZWVwX3B0cigmb3B0ZWVfcnRjX3BtX29wcyksDQogCX0s
DQogfTsNCiANCi1zdGF0aWMgaW50IF9faW5pdCBvcHRlZV9ydGNfbW9kX2luaXQodm9pZCkNCi17
DQotCXJldHVybiBkcml2ZXJfcmVnaXN0ZXIoJm9wdGVlX3J0Y19kcml2ZXIuZHJpdmVyKTsNCi19
DQotDQotc3RhdGljIHZvaWQgX19leGl0IG9wdGVlX3J0Y19tb2RfZXhpdCh2b2lkKQ0KLXsNCi0J
ZHJpdmVyX3VucmVnaXN0ZXIoJm9wdGVlX3J0Y19kcml2ZXIuZHJpdmVyKTsNCi19DQotDQotbW9k
dWxlX2luaXQob3B0ZWVfcnRjX21vZF9pbml0KTsNCi1tb2R1bGVfZXhpdChvcHRlZV9ydGNfbW9k
X2V4aXQpOw0KK21vZHVsZV90ZWVfY2xpZW50X2RyaXZlcihvcHRlZV9ydGNfZHJpdmVyKTsNCiAN
CiBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQogTU9EVUxFX0FVVEhPUigiQ2zDqW1lbnQgTMOp
Z2VyIDxjbGVtZW50LmxlZ2VyQGJvb3RsaW4uY29tPiIpOw0KLS0gDQoyLjQ3LjMNCg0K
