Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A664D5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:19:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CEADE4FEDD
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:19:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bQuhhVv4;
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B88FB45294
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:37 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so5506078a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808257; x=1766413057; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKLIW1Otm/CvIibORJ3xOD9U+OAfBBsE0DeO8Ciovak=;
        b=bQuhhVv4mX8uRwXXqJdI3kFXzt4+zIItfZtdsbw/LOVgsX2XJfmuyrWCg9g0BucF9G
         RA1QZYWWQgpAEobDyc1r3RI9vYGBu/rpD3VstwMcyBzJ9zdvG3ibcRbeOhf6fN6tX0s7
         P6tsPlaR+8zIHyTr1LHMvbhzzmMNDodNEKBnMn0xCj4udGrph44d9+U4LgPVDPf7O+Vz
         2zM9aMSNkqyaROP5D2qW9HAWUB0e7/F2v7qMxuHXP8JNPyrPL/0dry8Exzs2HrRMP2NN
         ZYjrX1q5JvY9/7xFmvdOS55Xtms4hI8mvmOBS4J3jaNW1e5etDfy9pB1XZz05bP0bsPx
         ROfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808257; x=1766413057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKLIW1Otm/CvIibORJ3xOD9U+OAfBBsE0DeO8Ciovak=;
        b=k9s0FiaXwDKEI7ODcdt7MiJG158p37T8RVABY4L4PakXKwWyYznMOb+CNqtK6g9Upx
         kxoUNHXRdSy62ALavUmK6P8/pazB578CiY7VwXz9IcxArZAeYeWbTY9kgbpuqDof9nqu
         y/s/NmxwdVLV3woXrGi6CtLjAnVN/UnXkHc7WK4boHRJ0VcwQEsWzbdLnkahNdqq2RMS
         YfaNokCyYJ0rdEtnV7A31RIGtaWNtl4L87PXqZ7hrxE2J8D/CqHV/pBw/+upAip/jgwK
         64mrOoDncOdkdsz3kHCvVLO+Jp551zGZ1gvUH/IYk8AAmgzGlHM9n517jm5xT2JN5EEe
         NFug==
X-Forwarded-Encrypted: i=1; AJvYcCUxE3Q3oKrTAInFyKyDjkpNztfOB0aKdORhtVCsOlAl7rUMsVhzkx/n/bz5kNoVQs4DvpX3gkk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyH6DivFuHY+v83YKULOcRTx+RnIEdWifJlWbPko3Tn/2mnpzmX
	/oyhvmrYxvnEc58V70VmKtj9gvF783xnWgvQnQV7dLOopq3E/vQ2EzcpKU4ge8vpZL4=
X-Gm-Gg: AY/fxX4hwnUSBNhrERHk4lJ++rRwAAMiD4lllboHsnf4YvghceSOPyUCe/bQbMujcrz
	KvHrY45IB1KFYGpTn6bEY1GalbJenSTHD6+2lk59bx1Lg4xBLS06T1Gqnv2cAMoT1m6dc9mX89h
	D5Jlbku3Yn1/TzrAzNznM4obPLmXPow0WprByxAGJOKaB8rEPExOmF4OdvrZ9J4C/41nwU6MzqF
	aSeFdl7zastA75zC8LcV7vZLGwpIcKF+M5z72pACaMhkWrsQviHNu9L/Dlu51PeFvk2/pkEZ7pe
	HeXvP4MeipbEkuLENK13cya7+exdoBAmjsp+ecgzTgVH4tYFh1gv+6EXK6JgPn0i1nIBOOGGHV7
	S31pQ9ycDqJOBLhZVPyOY6cENuvrXntadRk/01GNBRm4P5v4DoeguAmhFzgPVdMs3yTKZ+yoq1o
	+PuDJTyDnhmGU97umbodoUtttXeJMGIUIA3ywR5naaZkrz0ZXtdCUviPEi5g==
X-Google-Smtp-Source: AGHT+IGnIW9OB19xF3q3JCaHg3DeUHqEK/cfaz7GtvANmTVQUUPZGevLylhKSJajUN3cRj/4ocKrGg==
X-Received: by 2002:a17:907:7f29:b0:b76:da45:e3d6 with SMTP id a640c23a62f3a-b7d2361d3b5mr1127857966b.16.1765808256517;
        Mon, 15 Dec 2025 06:17:36 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa2eb9c6sm1427881866b.20.2025.12.15.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:36 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 01/17] tee: Add some helpers to reduce boilerplate for tee client drivers
Date: Mon, 15 Dec 2025 15:16:31 +0100
Message-ID: <563931b951a69d579fa9a00134b09354c346789e.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=xC2ltYeeueP5vlvmDoWPRSRk09PJusQKgFR+Yv8ms48=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhOzSbait71TPEiQwqVv/v5kQMZpHFWXZ8Ps k02jYgJGruJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYTgAKCRCPgPtYfRL+ TuA/B/91zsgbTlCB7AYsgezO8lNhWEqaKK+g6H4HGG/FHRWFJvHBuk4oEa++o0ppXtSFIhcrpLu X+oc2qjhsVTOj4eut2/IV2ryLVx+oYslFdhfwC6OgNY/46OzseFbHS6Hwxd/+X8SaB3y79Bq0mX jrK7V9egowQMft8t3TAN3lnrFq089sC3DSXFQto1+CNaw/RS3FXJ4MgVNUNY3jhu9ahxkB823Xh m7fplwCrqnwJ4UZi/5ZOUYQBLxxlhiHWvwycF3PEBZSn4F3oIfaDQumyGnbxf88klKXlhxl74c6 jkO8jPGoTfvRCKtX6KfA5rR5RiOU7uLq4JKcZt9CFKOhnMn4
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.45:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received,209.85.208.45:from];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B88FB45294
X-Spamd-Bar: --
Message-ID-Hash: L6WMWVQC3552PNQO2X67TO5BYWFUYMKS
X-Message-ID-Hash: L6WMWVQC3552PNQO2X67TO5BYWFUYMKS
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/L6WMWVQC3552PNQO2X67TO5BYWFUYMKS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

U2ltaWxhciB0byBwbGF0Zm9ybSBkcml2ZXJzIChhbmQgb3RoZXJzKSBjcmVhdGUgZGVkaWNhdGVk
IHJlZ2lzdGVyIGFuZA0KdW5yZWdpc3RlciBmdW5jdGlvbnMgYW5kIGEgbWFjcm8gdG8gc2ltcGxp
ZnkgbW9kdWxlcyB0aGF0IG9ubHkgbmVlZCB0bw0KaGFuZGxlIGRyaXZlciByZWdpc3RyYXRpb24g
aW4gdGhlaXIgaW5pdCBhbmQgZXhpdCBoYW5kbGVycy4NCg0KUmV2aWV3ZWQtYnk6IFN1bWl0IEdh
cmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNvbT4NClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVp
bmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAYmF5bGlicmUuY29tPg0KLS0tDQogZHJpdmVycy90
ZWUvdGVlX2NvcmUuYyAgfCAxNiArKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC90ZWVf
ZHJ2LmggfCAgOSArKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMgYi9kcml2ZXJzL3RlZS90ZWVf
Y29yZS5jDQppbmRleCBkNjVkNDdjYzE1NGUuLjUxMzc5ZjdmYzVkNSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdGVlL3RlZV9jb3JlLmMNCisrKyBiL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMNCkBAIC0x
NDA1LDYgKzE0MDUsMjIgQEAgY29uc3Qgc3RydWN0IGJ1c190eXBlIHRlZV9idXNfdHlwZSA9IHsN
CiB9Ow0KIEVYUE9SVF9TWU1CT0xfR1BMKHRlZV9idXNfdHlwZSk7DQogDQoraW50IF9fdGVlX2Ns
aWVudF9kcml2ZXJfcmVnaXN0ZXIoc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyICp0ZWVfZHJpdmVy
LA0KKwkJCQkgc3RydWN0IG1vZHVsZSAqb3duZXIpDQorew0KKwl0ZWVfZHJpdmVyLT5kcml2ZXIu
b3duZXIgPSBvd25lcjsNCisJdGVlX2RyaXZlci0+ZHJpdmVyLmJ1cyA9ICZ0ZWVfYnVzX3R5cGU7
DQorDQorCXJldHVybiBkcml2ZXJfcmVnaXN0ZXIoJnRlZV9kcml2ZXItPmRyaXZlcik7DQorfQ0K
K0VYUE9SVF9TWU1CT0xfR1BMKF9fdGVlX2NsaWVudF9kcml2ZXJfcmVnaXN0ZXIpOw0KKw0KK3Zv
aWQgdGVlX2NsaWVudF9kcml2ZXJfdW5yZWdpc3RlcihzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIg
KnRlZV9kcml2ZXIpDQorew0KKwlkcml2ZXJfdW5yZWdpc3RlcigmdGVlX2RyaXZlci0+ZHJpdmVy
KTsNCit9DQorRVhQT1JUX1NZTUJPTF9HUEwodGVlX2NsaWVudF9kcml2ZXJfdW5yZWdpc3Rlcik7
DQorDQogc3RhdGljIGludCBfX2luaXQgdGVlX2luaXQodm9pZCkNCiB7DQogCWludCByYzsNCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3RlZV9kcnYuaCBiL2luY2x1ZGUvbGludXgvdGVlX2Ry
di5oDQppbmRleCA4OGE2Zjk2OTdjODkuLjg1MGMwM2IyY2RlYSAxMDA2NDQNCi0tLSBhL2luY2x1
ZGUvbGludXgvdGVlX2Rydi5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3RlZV9kcnYuaA0KQEAgLTMy
Miw0ICszMjIsMTMgQEAgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIHsNCiAjZGVmaW5lIHRvX3Rl
ZV9jbGllbnRfZHJpdmVyKGQpIFwNCiAJCWNvbnRhaW5lcl9vZl9jb25zdChkLCBzdHJ1Y3QgdGVl
X2NsaWVudF9kcml2ZXIsIGRyaXZlcikNCiANCisjZGVmaW5lIHRlZV9jbGllbnRfZHJpdmVyX3Jl
Z2lzdGVyKGRydikgXA0KKyAgICAgICAgX190ZWVfY2xpZW50X2RyaXZlcl9yZWdpc3RlcihkcnYs
IFRISVNfTU9EVUxFKQ0KK2ludCBfX3RlZV9jbGllbnRfZHJpdmVyX3JlZ2lzdGVyKHN0cnVjdCB0
ZWVfY2xpZW50X2RyaXZlciAqLCBzdHJ1Y3QgbW9kdWxlICopOw0KK3ZvaWQgdGVlX2NsaWVudF9k
cml2ZXJfdW5yZWdpc3RlcihzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgKik7DQorDQorI2RlZmlu
ZSBtb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIoX190ZWVfY2xpZW50X2RyaXZlcikgXA0KKwltb2R1
bGVfZHJpdmVyKF9fdGVlX2NsaWVudF9kcml2ZXIsIHRlZV9jbGllbnRfZHJpdmVyX3JlZ2lzdGVy
LCBcDQorCQkgICAgICB0ZWVfY2xpZW50X2RyaXZlcl91bnJlZ2lzdGVyKQ0KKw0KICNlbmRpZiAv
Kl9fVEVFX0RSVl9IKi8NCi0tIA0KMi40Ny4zDQoNCg==
