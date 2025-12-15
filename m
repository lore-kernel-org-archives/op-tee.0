Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB760D5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:28:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1AD974FDB0
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:28:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=qN/MPjKZ;
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3A8564FEB4
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:18:04 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so5506932a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808283; x=1766413083; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrasR7kGrYrWNKAZkndazvg9Pq5KLcOmeoZP0wqwfBQ=;
        b=qN/MPjKZh/2ad/jmz2zibMC1pYLCLPfiRel+1UDF+CR8RgG8frOTLdG3R/x0/U/UVP
         0jj8BaFB4ynav9UnT8tb3y7hCQGX3au3YhbeYnvp2XkxgvQRTus4LV6qSnvreXTTgsSI
         mkDLWoyrB05YiE4+u2ShRGxIRZbC2Vul8FMnghSzs87q4TuzuV8yRYZsIlrQ/WIFGkhG
         2xoBrVKPV/sRVRg9aGYjND8VGxrpBRVzhJaEo166zggoka75S7dpXsKj5PbiImE8F2eR
         zEtyt3t/o0pieLgk1e5ungr/RLXqN+GrI8CGP4vk5IXa/wwJl+OQWqbVUNb+7q6SFok/
         j5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808283; x=1766413083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HrasR7kGrYrWNKAZkndazvg9Pq5KLcOmeoZP0wqwfBQ=;
        b=lkq49aeJSkDAfxwrI0d+DdaBzs/EMCdlx0lypxTR6kZjW0cqpqQn1bQ0OKbumCmXpI
         4vgHQ16k9L59xz8DUyQE46qpdw1IUSOUdGP0tFKDmKVFItaIp4qkPbLR9tjxL3K6BIbf
         4ymkR2t04dWNzssxQ0IECls4Ijg5zpTGxb4w7YaRRhCMGru9c0dKy3ceERX1FM5v9AvI
         VIdyQrfOzxelEvbgTygMpI2CJfyV5FrFr+fuHXqYfXb9PyEhTiGii+XD7MLJ2zRfZWnB
         07P60AwQOLQ4zPskA7LxWUP+gdOffi/w1YgnxX9451WDazfiXlJDytOeHweVVeUrYSqZ
         tmUw==
X-Forwarded-Encrypted: i=1; AJvYcCWg4wPc0mco97eSkPmaXRj8J62fssEIscUYTSz10j57wFj+c/99G6TG3n8MdYlTdqxURbqFVE4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywe1fWR8Nq5yvhztAvMW2/LsUpycEBBZ9MAYGmA3d4RxhBgbPEJ
	AebRmwKiq4RAGkjEr3gHcUJMzAs4KiLQ7tOPVGQYCEzAWYevBULaOJVWwGpIRpmvKniAIHf6SAt
	Taupg
X-Gm-Gg: AY/fxX64kXRgrsl0+0FMU6wCPAd1nrSOavuWxS4I+u74Xfu09FYQ9o9Z49lIJxwpVJw
	RUofXdDkvfOGVqWZ/2nMSlLepcPsbCPk6VrJwjvNRLU+vV5NgM6Tx18BGb2rQww3ChdyxnmwaV3
	i9QWcJhi4AWYVcBFgvGM8L2zZFNtmJpD7LEJ8sQylxgh7pEsEMUvc1zH057zXN5nXDCT4eWU/Sc
	MAYFS4jnziB8O9JMCfMtqVFlQIO6PZfzglGCKLWoz0uGREiPqhzHjVD/FqnNNfeJg+zb8WcdJvV
	hIOQPnJ3IH69XNDaFaXKdETkUxWEms2GKLu2wSlbTq5OfxzyhwnakkO61lQ3mZuXGabtqZuNOuA
	4YiLhKvIHhQ/djEWBtGD66BbJ9phWZIAQFm0Zoq7hYOI/YZptkhK0PVmCJ+OFhzJbWDbD1dPGyN
	CyX4WOwWTodUX3Ro7uyVqFtdVxLdFTZ9j5hXmze49eoNMZXo8SBk/LDmfWlA==
X-Google-Smtp-Source: AGHT+IHX0m7kbMZvY8tope7JC2GsN2BbWZe1dZGY3zQ0k7S4MMiH/CtKoy5x3794CwzbShUzQ3pDRg==
X-Received: by 2002:a17:907:3e12:b0:b73:54b6:f892 with SMTP id a640c23a62f3a-b7d2356a6b5mr1114211066b.4.1765808283065;
        Mon, 15 Dec 2025 06:18:03 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa2e70c2sm1388507066b.15.2025.12.15.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:18:02 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v2 16/17] tpm/tpm_ftpm_tee: Make use of tee specific driver registration
Date: Mon, 15 Dec 2025 15:16:46 +0100
Message-ID: <5c8d6d420338d0d028f785680520d375e8a49673.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=sf0K4iIYSb02rL0mKJ9MRRhFzpLL6kAy33jJ54lqjio=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhzv7fuyRMHA7lEtOeYNZ6CC9fofHw/mF7L7 AvGJoDhvh+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYcwAKCRCPgPtYfRL+ TvL9CACVhcY+gEOTNpIRErp2w/DR0HVcSHlsZUncxxNqkggxg/NdYhINtrPC7TX2L8c7demb+/3 hngi+GznovcCzmDBw4iVI2Dg0un0NfTmRnrgDJkyeDiZ6YfwLRTMLRUUNXbjbR/X4wkxAOBN3gm +UhKQPDnGZ/OFX2n0KDIDFSkD6jm2bWwseMZcWgrX9UV6KqrMa5ruNDfjvi1Zk88xofINe35S4y FpC9jQzdzGcU1qIOrSjQ5/6lEhZQMETearZ0GAS96ED1elqYF4XjLZdtfV+Rw2Yec1AjqscWGf0 YKd7cQr/XDBJ27pKG7mgv0+wsPyUalXZWHOBsd5AN1Ja8QAf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.49:from];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[linaro.org,gmx.de,kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.49:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3A8564FEB4
X-Spamd-Bar: --
Message-ID-Hash: XO6VVGS7BCSEQZMTFWGYDWQ73ASM7OCY
X-Message-ID-Hash: XO6VVGS7BCSEQZMTFWGYDWQ73ASM7OCY
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@kernel.org>, linux-integrity@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XO6VVGS7BCSEQZMTFWGYDWQ73ASM7OCY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

dGVlX2NsaWVudF9kcml2ZXJfcmVnaXN0ZXIoKSBpcyB0eXBlZCBtb3JlIHN0cm9uZ2x5IGFuZCBj
YXJlcyBhYm91dA0KYXNzaWduaW5nIHRoZSBkcml2ZXIncyBidXMuIFNpbWlsYXIgZm9yIHRlZV9j
bGllbnRfZHJpdmVyX3VucmVnaXN0ZXIoKS4NCg0KTWFrZSB1c2Ugb2YgdGhlc2UgZnVuY3Rpb25z
Lg0KDQpSZXZpZXdlZC1ieTogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29t
Pg0KU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BiYXls
aWJyZS5jb20+DQotLS0NCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jIHwgNSArKy0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jIGIvZHJpdmVycy9jaGFy
L3RwbS90cG1fZnRwbV90ZWUuYw0KaW5kZXggNGU2M2MzMGFlYWYxLi5lNWZiYzcwYjBlY2EgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jDQorKysgYi9kcml2ZXJz
L2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jDQpAQCAtMzM4LDcgKzMzOCw2IEBAIHN0YXRpYyBzdHJ1
Y3QgdGVlX2NsaWVudF9kcml2ZXIgZnRwbV90ZWVfZHJpdmVyID0gew0KIAkuaWRfdGFibGUJPSBv
cHRlZV9mdHBtX2lkX3RhYmxlLA0KIAkuZHJpdmVyCQk9IHsNCiAJCS5uYW1lCQk9ICJvcHRlZS1m
dHBtIiwNCi0JCS5idXMJCT0gJnRlZV9idXNfdHlwZSwNCiAJCS5wcm9iZQkJPSBmdHBtX3RlZV9w
cm9iZSwNCiAJCS5yZW1vdmUJCT0gZnRwbV90ZWVfcmVtb3ZlLA0KIAl9LA0KQEAgLTM1Miw3ICsz
NTEsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBmdHBtX21vZF9pbml0KHZvaWQpDQogCWlmIChyYykN
CiAJCXJldHVybiByYzsNCiANCi0JcmMgPSBkcml2ZXJfcmVnaXN0ZXIoJmZ0cG1fdGVlX2RyaXZl
ci5kcml2ZXIpOw0KKwlyYyA9IHRlZV9jbGllbnRfZHJpdmVyX3JlZ2lzdGVyKCZmdHBtX3RlZV9k
cml2ZXIpOw0KIAlpZiAocmMpIHsNCiAJCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZmdHBt
X3RlZV9wbGF0X2RyaXZlcik7DQogCQlyZXR1cm4gcmM7DQpAQCAtMzY0LDcgKzM2Myw3IEBAIHN0
YXRpYyBpbnQgX19pbml0IGZ0cG1fbW9kX2luaXQodm9pZCkNCiBzdGF0aWMgdm9pZCBfX2V4aXQg
ZnRwbV9tb2RfZXhpdCh2b2lkKQ0KIHsNCiAJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmZ0
cG1fdGVlX3BsYXRfZHJpdmVyKTsNCi0JZHJpdmVyX3VucmVnaXN0ZXIoJmZ0cG1fdGVlX2RyaXZl
ci5kcml2ZXIpOw0KKwl0ZWVfY2xpZW50X2RyaXZlcl91bnJlZ2lzdGVyKCZmdHBtX3RlZV9kcml2
ZXIpOw0KIH0NCiANCiBtb2R1bGVfaW5pdChmdHBtX21vZF9pbml0KTsNCi0tIA0KMi40Ny4zDQoN
Cg==
