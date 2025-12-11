Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D86D44166
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:57:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5B11E4FD58
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:57:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=o4DPT8gq;
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9582243248
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:15:55 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477a1c28778so4034865e9.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473354; x=1766078154; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYGrrB8fuS9mG1lO++7R0Er9vYlfUnB8vYICuaIO95U=;
        b=o4DPT8gqMbrtuMuDE2+XXGgK3jLm7CFfuLclLo9mLcpopZvfh14I/i7fy8f9p7dCXh
         grDEbluvXaWU8YG+IK3rFVfbFJNlP+18iO+wtEvsSkvR8fICD2aP30nzxuC8we5AxEc6
         tBZIAmIcAlKS/b+n6/uniqmmz5JHqFqHjUrKi74LpRw9lhJvNfKn8oIfbJLSBAJt5FE3
         5YXKA6NjMHYZ34B+l2t41IxXCvHfLHNls/Lol/MpTSUPAuSC5aMnDbtcumczgrQzWnsy
         Kq7XY9vDdw2vo/jKMgzSQ9ZF2SZno6DR9WXtqS8xWuIaUHNHQc+esbkr7ljJH+kZ0M3G
         GosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473354; x=1766078154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYGrrB8fuS9mG1lO++7R0Er9vYlfUnB8vYICuaIO95U=;
        b=JoWnqebCl1ZIUVUyFU8/lluSTGjnpyGiS0GStFDukMNLtmOr/IAbj7ULC1FnvF6hTc
         k6TNXum2aNnbuSXkbuK/TS0oWF/cEoH9vWveOi6zxmeSfb6PMFlKcUPPFCS3SRYKajze
         tJQy2JkrylcXn8P70I0AG3VSVTFjOTCWZwMizeVrFVPKpHZlFOIVcP0gpV/Fj+UTjcrp
         sdLDPGubCiKK18hvM9a6B1jf/Uw7kKjrxWtGsHBc+ztaL+xHO9EGg2e0JCpzbAFvkuso
         xAx5hv/T7XEPDMBvcoXeDsqiZY1f/AbB8RY8qkToGhm94xNIR6aNYWXRyJ0Wwhw2jnMj
         FJLw==
X-Forwarded-Encrypted: i=1; AJvYcCW05TkDdABoMMvhMfGRR6hZ7I+M7bLCBff8kxibDt2bIw0je1f/WSis9GytlpZc2ctzjy7wlDA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwKCiMamCTT+1PZwV2IYLoCVX/GQw2GGzIx1T8gc+z9rY0FnuIW
	ANQEMdnoezr0by0pTFlFB6UvzYGsmCMmz5dBDxFxd6IBbwH6oD7CmxuavXQR+AzJmRmnLoJP7I5
	itART
X-Gm-Gg: AY/fxX6UvbSN3SUZu80hsF2V+UUI5oamdQrZvVbu6H58XgUfMe3wXiaDKrNPRtkhKDb
	dJMWk9lRBMlEAMKeXRj1wCNq5KhJhxPHNHz+OrDL4SSNQo+QmZoigW4d6PgkIaUjfQSg2sa27Z8
	lHxbQMEeMVExmO96CF+siugVx+sHS9prlJUVveWx5jpg7QymTvVBU7KuNj/z5SD7/30Y1Pflo/a
	aIj80JLoWNh/eG5q1h2YHaqy0NzE7YyPGhF/f5sfW6GmHMFs6ISE4emFM6CBfcyH++XjUDlcrgD
	omQCiR9n4zodCL6u+DaCA2v/37Kq3W9FVjcJAD/3oM5C3wqEdM2F33bUsmTXBmiEgXN3KD0+9U7
	2eGvzJ73ec9XpeoYOlj0tMd1N5IFUTns1ogGQSzWSMmh35YLnSHSkFR1+SKHWulfi4kwsNp8Rig
	6x+sWlDWkpGzlQgv0VVVoSI9FiUDS5s3DW5MYxxc95FOFVuhNuUnbslggBehnjRA93y0LH/u5p+
	SA=
X-Google-Smtp-Source: AGHT+IE6M3q2VFu6u/fo4kWRAEIyesdqN/bWPrsvZJM6/G4yT7LeZmkftuZ3Kd0OKFWnEDhUzIzWYA==
X-Received: by 2002:a05:600c:1913:b0:479:3a87:208f with SMTP id 5b1f17b1804b1-47a837a00dbmr65625795e9.36.1765473354545;
        Thu, 11 Dec 2025 09:15:54 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89d70ac4sm17003405e9.2.2025.12.11.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:15:54 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v1 01/17] tee: Add some helpers to reduce boilerplate for tee client drivers
Date: Thu, 11 Dec 2025 18:14:55 +0100
Message-ID: <899e887aa68206155f2fc56ad768cbcf40012fb6.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=wu6oefWKnIU9WzWjX5GOqr1eBeTnbSAfvrahT97CN+M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwWMOUhCGSVbWSQI8W2OOIB53T/WvCJCMowB j2V1XtzRHiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8FgAKCRCPgPtYfRL+ TiOEB/0aR+efhPwiQcZJpUyCAlxHdq4odKrgNo1C7UqmJAxDXlWzQOINASU+YQo+sbx/qoIwQJV ZivxHhlvwCel4aJZqXl2AAYD/CGug/CzJdYzZfiFKruRf/StTkMCMn/HKzOmXSeST/V4uHPJ5Ff DthHEs0aolb+n4BMzMK168CvTRMSpYkO3Pu2DPFefTiDa1qKjWHoAzWXYIGo89E1zwn4vRYdulK XqU9J5Pa0+AU8rmaNysO78WNY4sxE+/95ejeHnkWG38/l+NT0z6vCcxT2Q50UW5AmnS/1wJLRET yMBUnOPpm+xvFCyNRD5x+hClHr8nV5hComdWozHNljx/ZnXE
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.52:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.52:from];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	BLOCKLISTDE_FAIL(0.00)[209.85.128.52:query timed out,2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9582243248
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: EVSLSTVATEKMAORKGVJRQB74RRNDEJJD
X-Message-ID-Hash: EVSLSTVATEKMAORKGVJRQB74RRNDEJJD
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:46 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EVSLSTVATEKMAORKGVJRQB74RRNDEJJD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

U2ltaWxhciB0byBwbGF0Zm9ybSBkcml2ZXJzIChhbmQgb3RoZXJzKSBjcmVhdGUgZGVkaWNhdGVk
IHJlZ2lzdGVyIGFuZA0KdW5yZWdpc3RlciBmdW5jdGlvbnMgYW5kIGEgbWFjcm8gdG8gc2ltcGxp
ZnkgbW9kdWxlcyB0aGF0IG9ubHkgbmVlZCB0bw0KaGFuZGxlIGRyaXZlciByZWdpc3RyYXRpb24g
aW4gdGhlaXIgaW5pdCBhbmQgZXhpdCBoYW5kbGVycy4NCg0KU2lnbmVkLW9mZi1ieTogVXdlIEts
ZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQotLS0NCiBkcml2ZXJz
L3RlZS90ZWVfY29yZS5jICB8IDE2ICsrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L3Rl
ZV9kcnYuaCB8ICA5ICsrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvdGVlX2NvcmUuYyBiL2RyaXZlcnMvdGVlL3Rl
ZV9jb3JlLmMNCmluZGV4IGQ2NWQ0N2NjMTU0ZS4uNTEzNzlmN2ZjNWQ1IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy90ZWUvdGVlX2NvcmUuYw0KKysrIGIvZHJpdmVycy90ZWUvdGVlX2NvcmUuYw0KQEAg
LTE0MDUsNiArMTQwNSwyMiBAQCBjb25zdCBzdHJ1Y3QgYnVzX3R5cGUgdGVlX2J1c190eXBlID0g
ew0KIH07DQogRVhQT1JUX1NZTUJPTF9HUEwodGVlX2J1c190eXBlKTsNCiANCitpbnQgX190ZWVf
Y2xpZW50X2RyaXZlcl9yZWdpc3RlcihzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgKnRlZV9kcml2
ZXIsDQorCQkJCSBzdHJ1Y3QgbW9kdWxlICpvd25lcikNCit7DQorCXRlZV9kcml2ZXItPmRyaXZl
ci5vd25lciA9IG93bmVyOw0KKwl0ZWVfZHJpdmVyLT5kcml2ZXIuYnVzID0gJnRlZV9idXNfdHlw
ZTsNCisNCisJcmV0dXJuIGRyaXZlcl9yZWdpc3RlcigmdGVlX2RyaXZlci0+ZHJpdmVyKTsNCit9
DQorRVhQT1JUX1NZTUJPTF9HUEwoX190ZWVfY2xpZW50X2RyaXZlcl9yZWdpc3Rlcik7DQorDQor
dm9pZCB0ZWVfY2xpZW50X2RyaXZlcl91bnJlZ2lzdGVyKHN0cnVjdCB0ZWVfY2xpZW50X2RyaXZl
ciAqdGVlX2RyaXZlcikNCit7DQorCWRyaXZlcl91bnJlZ2lzdGVyKCZ0ZWVfZHJpdmVyLT5kcml2
ZXIpOw0KK30NCitFWFBPUlRfU1lNQk9MX0dQTCh0ZWVfY2xpZW50X2RyaXZlcl91bnJlZ2lzdGVy
KTsNCisNCiBzdGF0aWMgaW50IF9faW5pdCB0ZWVfaW5pdCh2b2lkKQ0KIHsNCiAJaW50IHJjOw0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdGVlX2Rydi5oIGIvaW5jbHVkZS9saW51eC90ZWVf
ZHJ2LmgNCmluZGV4IDg4YTZmOTY5N2M4OS4uODUwYzAzYjJjZGVhIDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS9saW51eC90ZWVfZHJ2LmgNCisrKyBiL2luY2x1ZGUvbGludXgvdGVlX2Rydi5oDQpAQCAt
MzIyLDQgKzMyMiwxMyBAQCBzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgew0KICNkZWZpbmUgdG9f
dGVlX2NsaWVudF9kcml2ZXIoZCkgXA0KIAkJY29udGFpbmVyX29mX2NvbnN0KGQsIHN0cnVjdCB0
ZWVfY2xpZW50X2RyaXZlciwgZHJpdmVyKQ0KIA0KKyNkZWZpbmUgdGVlX2NsaWVudF9kcml2ZXJf
cmVnaXN0ZXIoZHJ2KSBcDQorICAgICAgICBfX3RlZV9jbGllbnRfZHJpdmVyX3JlZ2lzdGVyKGRy
diwgVEhJU19NT0RVTEUpDQoraW50IF9fdGVlX2NsaWVudF9kcml2ZXJfcmVnaXN0ZXIoc3RydWN0
IHRlZV9jbGllbnRfZHJpdmVyICosIHN0cnVjdCBtb2R1bGUgKik7DQordm9pZCB0ZWVfY2xpZW50
X2RyaXZlcl91bnJlZ2lzdGVyKHN0cnVjdCB0ZWVfY2xpZW50X2RyaXZlciAqKTsNCisNCisjZGVm
aW5lIG1vZHVsZV90ZWVfY2xpZW50X2RyaXZlcihfX3RlZV9jbGllbnRfZHJpdmVyKSBcDQorCW1v
ZHVsZV9kcml2ZXIoX190ZWVfY2xpZW50X2RyaXZlciwgdGVlX2NsaWVudF9kcml2ZXJfcmVnaXN0
ZXIsIFwNCisJCSAgICAgIHRlZV9jbGllbnRfZHJpdmVyX3VucmVnaXN0ZXIpDQorDQogI2VuZGlm
IC8qX19URUVfRFJWX0gqLw0KLS0gDQoyLjQ3LjMNCg0K
