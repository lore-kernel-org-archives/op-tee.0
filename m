Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFFBD4417C
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:03:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5FE0A4FEAF
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:03:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ExviQCqS;
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BFEFD43190
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:05 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42e2e167067so186407f8f.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473365; x=1766078165; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jsu33z0wmycD38Ck1lob20P1g6o+zkut+jonvSWb/k=;
        b=ExviQCqSINjoGheAb5/BN4KbTLms0n37N7LAdiS7n5uGw3ayH7732axKa1Y8SDGVcW
         fhGsRJ3zr/MQwcGwgQ0s25KmU4Y7M2uNwzKcbFATs7HVUmN+l65UD2K7cTeinZLLq3q5
         256iaTpbsIL7qDHFY03DdHfGz7io2Zhz/Da21a/GgZq0hXZeZNwkGkyLv/0bk5VRavl7
         jiENseVJNUuis06e/PmvdwiULNxiCeO4SebQ78o9VRHgBZ/24LCKT2A9tHW9ChQzpFnX
         0aO1M+WUH1zuu136GWEFrQRBQGqiO7ooOMu1iVZ0lJp8hxhTnsKQqUVqto4jB4wkQtbu
         +Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473365; x=1766078165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Jsu33z0wmycD38Ck1lob20P1g6o+zkut+jonvSWb/k=;
        b=AJ4Us4OcDG30VlIfHfIta5m9JoWLg7RNxzqLYQtzBp2xn0j8POAQm7Y+PuNyVMJnf2
         9LZ6qyKt3lu8v0OhuKRAtii3tMlhYe1Z09j+dJwgHKUvZLpmqtMK6igJeDUYQScZH18R
         VSoSM+MLrJL9H+PB75QGTSTHujshTnfIhd6qxANr4xfxdl+FTQR6dzhspLUr/Gvu68wx
         bvsXcu2tsua/lGNA8QdmaIpANNwVUVrgtHYaeDKClVLLsjs1SEps8JgVy5VZkp8LXmB1
         b7nKfKaQKf2pBFBAr1YMUFGVeoRPkQuvK7GIfKHO2zaIZcGDZjBabj7Ry2fyCYGxg18a
         /c+A==
X-Forwarded-Encrypted: i=1; AJvYcCWAH0DqiefEdZUT0qtUs74PhnvisE5DGGd8/5+MtxceFlFYCWl+ICuIo111FRkmYlYwlfsfk7A=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxnthZXgziG1nioAM6ho8O5uwj8oQxjZ3S56NXag9PwsWOq3z/G
	PpJmDOJcoA3lqDENr0R2VP4wAmKhVAfYRJfjCZHVutV1ysXvqS9N1BZqSMXL7+cvH3A=
X-Gm-Gg: AY/fxX7TXHF6yqICpKH7hcu4MKfqyoKlfyW9KeS/3dltOA3tPkAlz0xUnt2/bww/JsQ
	FsMnTKdHeybiKKAqimoyfqv8NgcCthIgdhMBAfhsAS08fGTNMFTFSVOvXfQtldyVRnglTbdrUA6
	tznw+UYvjxax5olZ7C/flsZRFrNIArU2s4+oD2qquAXiw9Tf6Wc5ScELOFdpstWfouMkkOITwRF
	uT3adno5xZhhTHIo614UFqRksvf/xxV+VjYzc8OyN3UIgCUApWTxTLHEOHsesMSow+/x/fjF0pa
	/41OYL4ZkGnWM6Dr15U52krjaXik1SVExToF52gzd5twt6afL7OpREBvuPB/8/nq0YFwkZqk+NR
	Gz6MndiNI4/wvnpf5W+OtmPfS4EbMVTUriyuLV9re9qGablCeaTytLgPuHWBt4HXt64tz2tsfrp
	qghx4JLAhtaTC2538dEpRnA4ZkCJknQX8DCY4nSHIthJjDEPV4AYj2eVwVS7VKuCsPBiFXDTtP5
	YM=
X-Google-Smtp-Source: AGHT+IHT/47lM8U2n9kb0yO2qNfCYTAMiiikeGIeIkkmwYtl5yfApNSyt+GvQrmmfeRCuqCiWdtNfQ==
X-Received: by 2002:a05:6000:2008:b0:42b:3c8d:1932 with SMTP id ffacd0b85a97d-42fa39dff34mr7462013f8f.23.1765473364680;
        Thu, 11 Dec 2025 09:16:04 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8b9b20dsm6977919f8f.38.2025.12.11.09.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:04 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v1 10/17] firmware: arm_scmi: optee: Make use of module_tee_client_driver()
Date: Thu, 11 Dec 2025 18:15:04 +0100
Message-ID: <537c48e3db243b5c68c3192179a948efb3a180c7.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=XCE+dl0ldCkIhemm2S2ZeqHCREzROrXlRdPi5igiXsk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwtSZF4Ik75GwqQ+EWV8U0/usd0EXZO6Sryo OtegG9XU8GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8LQAKCRCPgPtYfRL+ TkGsB/4kfZYi859BNNllj8EMK4U0tKtFDeScFfbKa+NwjGXgHVpSR89DKubfoO7V7TXzKxzZvMC v63m9WjAd7iwwwDv5xXNjj1JC1KnscMoyDrKlzKWrZiLuYJHCZrk3Sydo/8FtIfFKhL3/J5Vixg P+q+Yafa9vNA3OaLq/baAtLoPdm17/FoQA8NR4prce1EHo8UMzLvPXuyrpEGvq/WvuDVwpPraxd H88+knoEsk+vtjpVUa1O6A91PsS5YPd1QCPuwaCJ22w3g8vPvCpO+5sOP5c7Yfu4Mf9ShaalcGG QH/pUvOksk9bBlExdPdfrM98AqIk/xJKyHsRfm6/hBZGcaId
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_NA(0.00)[baylibre.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.50:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:server fail,209.85.221.50:query timed out];
	FREEMAIL_TO(0.00)[linaro.org,arm.com,wanadoo.fr];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.50:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BFEFD43190
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: G4AGKWID4F63SWYJHB5ICBQQJHOTAWRX
X-Message-ID-Hash: G4AGKWID4F63SWYJHB5ICBQQJHOTAWRX
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:57:12 +0000
CC: Cristian Marussi <cristian.marussi@arm.com>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G4AGKWID4F63SWYJHB5ICBQQJHOTAWRX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

UmVkdWNlIGJvaWxlcnBsYXRlIGJ5IHVzaW5nIHRoZSBuZXdseSBpbnRyb2R1Y2VkIG1vZHVsZV90
ZWVfY2xpZW50X2RyaXZlcigpLg0KVGhhdCB0YWtlcyBjYXJlIG9mIGFzc2lnbmluZyB0aGUgZHJp
dmVyJ3MgYnVzLCBzbyB0aGUgZXhwbGljaXQgYXNzaWduaW5nDQppbiB0aGlzIGRyaXZlciBjYW4g
YmUgZHJvcHBlZC4NCg0KU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5l
LWtvZW5pZ0BiYXlsaWJyZS5jb20+DQotLS0NCiBkcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL3Ry
YW5zcG9ydHMvb3B0ZWUuYyB8IDEzICstLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJt
d2FyZS9hcm1fc2NtaS90cmFuc3BvcnRzL29wdGVlLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2FybV9z
Y21pL3RyYW5zcG9ydHMvb3B0ZWUuYw0KaW5kZXggZGMwZjQ2MzQwMTUzLi44ZmRiODBkM2ZhYmQg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL3RyYW5zcG9ydHMvb3B0ZWUu
Yw0KKysrIGIvZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS90cmFuc3BvcnRzL29wdGVlLmMNCkBA
IC02MTIsMjMgKzYxMiwxMiBAQCBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIHNjbWlf
b3B0ZWVfc2VydmljZV9kcml2ZXIgPSB7DQogCS5pZF90YWJsZQk9IHNjbWlfb3B0ZWVfc2Vydmlj
ZV9pZCwNCiAJLmRyaXZlcgkJPSB7DQogCQkubmFtZSA9ICJzY21pLW9wdGVlIiwNCi0JCS5idXMg
PSAmdGVlX2J1c190eXBlLA0KIAkJLnByb2JlID0gc2NtaV9vcHRlZV9zZXJ2aWNlX3Byb2JlLA0K
IAkJLnJlbW92ZSA9IHNjbWlfb3B0ZWVfc2VydmljZV9yZW1vdmUsDQogCX0sDQogfTsNCiANCi1z
dGF0aWMgaW50IF9faW5pdCBzY21pX3RyYW5zcG9ydF9vcHRlZV9pbml0KHZvaWQpDQotew0KLQly
ZXR1cm4gZHJpdmVyX3JlZ2lzdGVyKCZzY21pX29wdGVlX3NlcnZpY2VfZHJpdmVyLmRyaXZlcik7
DQotfQ0KLW1vZHVsZV9pbml0KHNjbWlfdHJhbnNwb3J0X29wdGVlX2luaXQpOw0KLQ0KLXN0YXRp
YyB2b2lkIF9fZXhpdCBzY21pX3RyYW5zcG9ydF9vcHRlZV9leGl0KHZvaWQpDQotew0KLQlkcml2
ZXJfdW5yZWdpc3Rlcigmc2NtaV9vcHRlZV9zZXJ2aWNlX2RyaXZlci5kcml2ZXIpOw0KLX0NCi1t
b2R1bGVfZXhpdChzY21pX3RyYW5zcG9ydF9vcHRlZV9leGl0KTsNCittb2R1bGVfdGVlX2NsaWVu
dF9kcml2ZXIoc2NtaV9vcHRlZV9zZXJ2aWNlX2RyaXZlcik7DQogDQogTU9EVUxFX0FVVEhPUigi
RXRpZW5uZSBDYXJyaWVyZSA8ZXRpZW5uZS5jYXJyaWVyZUBmb3NzLnN0LmNvbT4iKTsNCiBNT0RV
TEVfREVTQ1JJUFRJT04oIlNDTUkgT1BURUUgVHJhbnNwb3J0IGRyaXZlciIpOw0KLS0gDQoyLjQ3
LjMNCg0K
