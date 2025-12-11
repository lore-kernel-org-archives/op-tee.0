Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDDCD4417D
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:01:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 074D24FC38
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:01:31 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=mbIUNMlb;
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7D7845002A
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:03 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47118259fd8so4286415e9.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473362; x=1766078162; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a4wMDZK2ViUHeY8ITMBosr5lNb7hmzarN7W0g0+DF8=;
        b=mbIUNMlb0AORtpYHpVoai1RwQvHyu1Mkg3+Ll6cMt+dyfiCXQTSme9+W9fwEV7iO3n
         vfYrnm93iTaCQq6hkUAhsle6Cqxzyxj6YkS+wkWRSML/wPBDHhSSgOPVTNR/j/sEVAy5
         WYEBwApfiLYE6An2wZovwABHWFoPoBsYGyDiPV8xPX+rsLsk5wFQbpzmHVknZZftr+xJ
         zeB6IrMwmQsjfA3w8xyEDDvJ3NiUBZZYowt3NVFYxqrb4Tq7ygcYrCSWi/iL88SBJ6nf
         7vOBKtOfB0FN8wxrr0dQEeI6EH2PzW3XjANyzJjkudqMu5PR8qkd6DjFLBzewd0nt706
         5OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473362; x=1766078162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5a4wMDZK2ViUHeY8ITMBosr5lNb7hmzarN7W0g0+DF8=;
        b=cD0HwMHD2jIkDWPDUn7m8e94+lvDMw3b5P/ybfOV3anXSJKEYPLQeSU4XSsLjFKDJv
         5TsZ4A1L/T7qF2SwRwoOsQrywg/eAwLaweAZp4flCbArrjzCVE30xmdpfuwBn86Yf9nJ
         EKyftJ3eA9g0mojGHf8PomDYxJ8Vj01lzp20c3Ip8Ke4SJZoLxVTd6wZDBlez5cuYf+C
         747ryvwAGIUc43PNQ41iHQ2Ql2rqP1wmBYaqzqREdJNq9bTb6/pXw1Z7I5ssL7+niggC
         2yNoa/fuketiPP0jzH4yq8Gf8uRhmP5KZ8Ys7M0+iI/CP9Zq29BP0XjLZZCjS9ORuMOl
         nJFA==
X-Gm-Message-State: AOJu0Yxhbgmk7Nbit2MpXCq01okHCZ4vpywm2n+NRzQHWYl643Yxh+ll
	sEDEzrU4/SU2huFxcPR0v+toRTnioQMDoMx1SCAfrEfNc3P6GwXXyJwXguIlJ9WUwKk=
X-Gm-Gg: AY/fxX6YAjTpXzAampJMdS55g6M6yhYuq95H5WWk9uRTLJt/OjBMVbhwPjM56JJbaFa
	fLp5q8ueD0MJ5T2nWf6PKgJVsURS8Mk4w34qU8Nj0VAEmR4VYjVhbbH4RhqWOac8DRfpMLbe+2Z
	vvgf78JHNcUtu19LFUChhJAhG2lSY9cyw/F94gjF9E7sNAYxkqUOjUfMBapZKkMoyn/ZnqJZv9j
	9JdSXOyuIeCZV2flbV/g+y9+K41ZQ+Z+GAE4OJe4oEDryjsqbEsJTqS+4W9yKmmR5Rx6//QI9VQ
	eKbSBTeuJE403bzw5uoZhBRWvifKZtr8tXClZiHBT+al8QfuCO4WcK33yXxxHWvSGlSbNfFACPq
	AIlYcLyPACPyzWtBY4Vk1pkA1CYajFrAA7WL+p7Sfb9EWVlkRPFNWJu8ScOt84ZX1YQTBK4qIRZ
	CcV5H3ZwpOIYPCMSrKYBTMPohiHhc4I9C4VuQdll1yDA6+gSl2bODNPAHNsEPRzawhyQ4fJKt0S
	7w=
X-Google-Smtp-Source: AGHT+IE+X9wMDaoG4Q+goEXvBdmDRMpx3iuUbrVTqUSpfRdjag7tAC9TsJa1xQ5gBIFCyk9gG0Z+Bw==
X-Received: by 2002:a05:600c:4705:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-47a8377b8bemr79943275e9.10.1765473362428;
        Thu, 11 Dec 2025 09:16:02 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a8be549d0sm37688665e9.1.2025.12.11.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:02 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v1 08/17] efi: stmm: Make use of module_tee_client_driver()
Date: Thu, 11 Dec 2025 18:15:02 +0100
Message-ID: <0896270bc530d1e3b7fbcf5f7e168172dcc05d1e.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=kVl/h/+w7Wr0R904x5vNxSBa3qE7VLiGeImjLkLbd5E=; b=owGbwMvMwMXY3/A7olbonx/jabUkhkyrPxrp7FaL9OXe8ilvWtXDYnnXyuCubaF9/dc/qQ+s2 AX+fO/tZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiS5TY/+dkhfWruk/vtTP0 cL2huff2Oa1DFz4+fvn+Z02QTsTZFcapRusUt3/LZol+FL1N4tx5WUnjj0vO9YtIlius3v/mkau lmEV/hrqgQ5Bo9+Z7c/u0D25JeHz1OU9of+bCC5nxDBrThLKXqna/lbZUSpX+yui1/4fwgVXZpg Vy73eFanE1iS53SWH2/Xa2N0e57UTUw1naEuIVizpdPt++cObS6W8dZyOy/66SXC7sfGmugYKp0 zdbqaeB3W3zTn2K/Z5UGl1h4r6npf6chcnpkA1NKuf+rPvXYhTp+7Q5N+XH7YzNOYd8rGv0i3Pz Fj5qvefCb/9NnHHpBEeFpB98fzf/7Jqp5mXXdlSnzIgPAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.69 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[baylibre.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.128.54:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out,209.85.128.54:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.54:from];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7D7845002A
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: MMWXAJJ6VPZKXUYMWTJ3R5LMFZGPG5R3
X-Message-ID-Hash: MMWXAJJ6VPZKXUYMWTJ3R5LMFZGPG5R3
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:47 +0000
CC: op-tee@lists.trustedfirmware.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MMWXAJJ6VPZKXUYMWTJ3R5LMFZGPG5R3/>
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
LWtvZW5pZ0BiYXlsaWJyZS5jb20+DQotLS0NCiBkcml2ZXJzL2Zpcm13YXJlL2VmaS9zdG1tL3Rl
ZV9zdG1tX2VmaS5jIHwgMTQgKy0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2Fy
ZS9lZmkvc3RtbS90ZWVfc3RtbV9lZmkuYyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL3N0bW0vdGVl
X3N0bW1fZWZpLmMNCmluZGV4IDY1YzBmZTFiYTI3NS4uNTkwMzgxMTg1OGI2IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvc3RtbS90ZWVfc3RtbV9lZmkuYw0KKysrIGIvZHJpdmVy
cy9maXJtd2FyZS9lZmkvc3RtbS90ZWVfc3RtbV9lZmkuYw0KQEAgLTU4NCwyNCArNTg0LDEyIEBA
IHN0YXRpYyBzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgdGVlX3N0bW1fZWZpX2RyaXZlciA9IHsN
CiAJLmlkX3RhYmxlCT0gdGVlX3N0bW1fZWZpX2lkX3RhYmxlLA0KIAkuZHJpdmVyCQk9IHsNCiAJ
CS5uYW1lCQk9ICJ0ZWUtc3RtbS1lZmkiLA0KLQkJLmJ1cwkJPSAmdGVlX2J1c190eXBlLA0KIAkJ
LnByb2JlCQk9IHRlZV9zdG1tX2VmaV9wcm9iZSwNCiAJCS5yZW1vdmUJCT0gdGVlX3N0bW1fZWZp
X3JlbW92ZSwNCiAJfSwNCiB9Ow0KIA0KLXN0YXRpYyBpbnQgX19pbml0IHRlZV9zdG1tX2VmaV9t
b2RfaW5pdCh2b2lkKQ0KLXsNCi0JcmV0dXJuIGRyaXZlcl9yZWdpc3RlcigmdGVlX3N0bW1fZWZp
X2RyaXZlci5kcml2ZXIpOw0KLX0NCi0NCi1zdGF0aWMgdm9pZCBfX2V4aXQgdGVlX3N0bW1fZWZp
X21vZF9leGl0KHZvaWQpDQotew0KLQlkcml2ZXJfdW5yZWdpc3RlcigmdGVlX3N0bW1fZWZpX2Ry
aXZlci5kcml2ZXIpOw0KLX0NCi0NCi1tb2R1bGVfaW5pdCh0ZWVfc3RtbV9lZmlfbW9kX2luaXQp
Ow0KLW1vZHVsZV9leGl0KHRlZV9zdG1tX2VmaV9tb2RfZXhpdCk7DQorbW9kdWxlX3RlZV9jbGll
bnRfZHJpdmVyKHRlZV9zdG1tX2VmaV9kcml2ZXIpOw0KIA0KIE1PRFVMRV9MSUNFTlNFKCJHUEwi
KTsNCiBNT0RVTEVfQVVUSE9SKCJJbGlhcyBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxp
bmFyby5vcmc+Iik7DQotLSANCjIuNDcuMw0KDQo=
