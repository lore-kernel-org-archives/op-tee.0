Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A306CD5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:20:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E47B04FECD
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:20:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Gl5NY1PE;
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9E00E4FE8C
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:40 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so618739166b.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808259; x=1766413059; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkiTD4px65dM2skIdFl/J9dVCQORv+uwK+yX/RVP6Rc=;
        b=Gl5NY1PEtBDA0aRvlQ8S6jr79AGnnTDnVDU6CYfEKk5qEb8Ij9yt3sEqqavEVNJb0c
         oT4uisMH8VKfyDXVvWCGxerzloFyKx1TXGbSux1+4QqObFnlgeK1mP4CwF/3SVY4Di3M
         94XRVcoFKFAruR88TNtWszGdJ/wG8aaVx3J4hFpf+J3wGfurovuiFha66FgWOSGaiPVT
         sFQSCfiPV5qzwFfVjVWFrQCY56fH4moRH7KwCOuNI2tkWMmmjnLCxe9ZKju79xJrZJjR
         PqSyA2anloT3q5RdB6I3mDr9DforqPUI0uXGbZyBa7a/j62zAeapDgvNDP9Lbyl4x5l6
         2s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808259; x=1766413059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jkiTD4px65dM2skIdFl/J9dVCQORv+uwK+yX/RVP6Rc=;
        b=Q8HUPVMzL/mGVrC8pQJ0jzLWOUAbG3F5/7sWkD8694CtF2KzxVNmJ6WyJ9evEeqyDm
         T9RNxo3bnuyyd/i4o3IwpipECF7ihZ6zUSSl6N2tMpzvGV5tc/ioR0+2xKhUrwfHH5sA
         LK49vY21wqkxcfjvNXMZxs/zrBSpGPC0fAxcEXmK1+H2GlBqPDmj/WGGH5UMuVlHIe1C
         PDfNbJE+VQ3VOrudGG3xOTNa2nCk20I3rGS5tVqh3waMw9rG8NvwpWoOqT9ReXQ5AKD6
         VWRJ/jGiImbYt8xlQ5gbX3RlWN2TyWDDqEnZw5TpQ0RdcpKkY23dukuWTWX0krZ/FH1C
         /yyw==
X-Forwarded-Encrypted: i=1; AJvYcCUk4wur3Wkzup9yM7t3Y42Ove9vdLFWM8KOa+WCusMmkd0jPOJ7KaVBx+dTEBD25o0zy27oIOo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyQCzDHocd3ZZiif678OHtcI+vfhBZ/DNCUfz4e1vQAgZb0Fi8u
	EYxYbV8Kaa1dWbTvmwMvoVAN+7ra014eSoKOl0G37VczHuiB8Q0IbSVG4S85ZzJlmO0=
X-Gm-Gg: AY/fxX5NZo3tqgYt2GyFZynwQXK22N82tQ17rpeZSwvGJu87oxSpPxVyAmZH7aXAY9E
	ZZb8c4JZrZ5tD7YA2rGsqfqZ7ndjSk7sw6d374gxpEGdeB3IjbpPhYUl07RJZsTwS5mQNYm2o8M
	p0UGj8LF3PoWwlWAwG1AgUTbFyD9xDewPOS829VSECo9D5PdQ4K3Wui0HAjU28R7tdKFcXs/lsC
	tzUsY3XYoYYPbKnN0wxHWDOjZdA44/yG+mIQJWp1QgkBjh35wVwwZnQZ2RZl6DF10LMqnfvWPSx
	VDExq0e0Kk4ZTmkcj1EW0KjFguoqGyx8qf/r0iXfb/ox6DK3/QEc4TKpVnr60Liz3wZs/520eVY
	rkEOiC/3yYSRx3c4K1ts8/rVwzIYCHwTddwgfz6kb6Uf6pzfJYuHFrXhfS69k3NdBSV9ShfwsJl
	t3yFXc7TC5E59iRiJtmxwG7nSrN19RKODv4sPXQSQ1RbeTtCFhwYxAvimDOw==
X-Google-Smtp-Source: AGHT+IHKV4igaHwn7+K2vwYBtyQFxVpzIQraC3kpQm7Azogd0RTCY38G5wp3SBzUcJ46GS6qptq6qA==
X-Received: by 2002:a17:907:db03:b0:b73:1634:6d71 with SMTP id a640c23a62f3a-b7d23693326mr1093680166b.26.1765808259567;
        Mon, 15 Dec 2025 06:17:39 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5c9d22sm1435302666b.61.2025.12.15.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:39 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 03/17] tee: Adapt documentation to cover recent additions
Date: Mon, 15 Dec 2025 15:16:33 +0100
Message-ID: <5aeee7a827cf928f1d68b7f680a59685117948df.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=qgIeskizQ6k5pCTS+tBJjIOrZYKzKB9RZLZ3eLktzMA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhS0WoEn4Bdownd57bRxYSl7t13OvpmqNRXW GkJNk6vgCSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYUgAKCRCPgPtYfRL+ TvinB/9EIDFgtID3fmVhXXlk4A/3oeXKOggta0tcV5pJkVVqettorkuMukUos3F64qUG9dfUwdm hIAyJTKLPIyTNxWnxUfuucogoLAJ3adnn3KWUoVgBCcNMsvM5nkve7In9cZ9PJp9TI3b+o+72NC GZD+0Fr35s/FNjF+oZ8Gv0XaxQUoHoX420dzXrvQmpY79p1jcRwnzxtxLBA7GX0zQnMJJotNITC wpv2OVKb2sCXd6sqH8iA3gIECJDYegN1d5JRblp9d7dNDN5lcHd0nh9Oj2USgmDBirXlzgUCczl cOYapG0cgNTwNeI76zy4BsN/x06W6+Noq/qCs+A6WiicD4kt
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.65:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.65:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9E00E4FE8C
X-Spamd-Bar: --
Message-ID-Hash: BVNU47BC46DFE3WL7KYPAX67IZDB7YMC
X-Message-ID-Hash: BVNU47BC46DFE3WL7KYPAX67IZDB7YMC
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BVNU47BC46DFE3WL7KYPAX67IZDB7YMC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHByZXZpb3VzIGNvbW1pdHMgaW50cm9kdWNlZCBzb21lIGhlbHBlcnMgdG8gcmVkdWNlIGJv
aWxlcnBsYXRlDQphbmQgYnVzIHNwZWNpZmljIGNhbGxiYWNrcyBmb3IgcHJvYmUgYW5kIHJlbW92
ZS4NCg0KQWRhcHQgdGhlIHJlZmVyZW5jZSBleGFtcGxlIHRvIG1ha2UgdXNlIG9mIHRoZXNlLg0K
DQpSZXZpZXdlZC1ieTogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29tPg0K
U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJy
ZS5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdGVlLnJzdCB8IDE4ICsrKy0t
LS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDE1IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3RlZS5yc3Qg
Yi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdGVlLnJzdA0KaW5kZXggNWVhZWI4MTAzOTg4Li40
ZDU4YWMwNzEyYzEgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdGVlLnJz
dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3RlZS5yc3QNCkBAIC00MywyNCArNDMs
MTIgQEAgc25pcHBldCB3b3VsZCBsb29rIGxpa2U6Og0KIAlNT0RVTEVfREVWSUNFX1RBQkxFKHRl
ZSwgY2xpZW50X2lkX3RhYmxlKTsNCiANCiAJc3RhdGljIHN0cnVjdCB0ZWVfY2xpZW50X2RyaXZl
ciBjbGllbnRfZHJpdmVyID0gew0KKwkJLnByb2JlCQk9IGNsaWVudF9wcm9iZSwNCisJCS5yZW1v
dmUJCT0gY2xpZW50X3JlbW92ZSwNCiAJCS5pZF90YWJsZQk9IGNsaWVudF9pZF90YWJsZSwNCiAJ
CS5kcml2ZXIJCT0gew0KIAkJCS5uYW1lCQk9IERSSVZFUl9OQU1FLA0KLQkJCS5idXMJCT0gJnRl
ZV9idXNfdHlwZSwNCi0JCQkucHJvYmUJCT0gY2xpZW50X3Byb2JlLA0KLQkJCS5yZW1vdmUJCT0g
Y2xpZW50X3JlbW92ZSwNCiAJCX0sDQogCX07DQogDQotCXN0YXRpYyBpbnQgX19pbml0IGNsaWVu
dF9pbml0KHZvaWQpDQotCXsNCi0JCXJldHVybiBkcml2ZXJfcmVnaXN0ZXIoJmNsaWVudF9kcml2
ZXIuZHJpdmVyKTsNCi0JfQ0KLQ0KLQlzdGF0aWMgdm9pZCBfX2V4aXQgY2xpZW50X2V4aXQodm9p
ZCkNCi0Jew0KLQkJZHJpdmVyX3VucmVnaXN0ZXIoJmNsaWVudF9kcml2ZXIuZHJpdmVyKTsNCi0J
fQ0KLQ0KLQltb2R1bGVfaW5pdChjbGllbnRfaW5pdCk7DQotCW1vZHVsZV9leGl0KGNsaWVudF9l
eGl0KTsNCisJbW9kdWxlX3RlZV9jbGllbnRfZHJpdmVyKGNsaWVudF9kcml2ZXIpOw0KLS0gDQoy
LjQ3LjMNCg0K
