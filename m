Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85BBD4417C
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:05:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 15E374FD67
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:05:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=M+y5Hpfa;
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 718515002F
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:12 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47790b080e4so2053135e9.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473371; x=1766078171; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBhu1Uqa8RVHn7QCjomFckovl/MFhjzqjW3Qy6nBbgQ=;
        b=M+y5HpfaJ+hKJhxx654AthRib/daINYzSJeNeStwKVGF+XLFRdKCJTJutWzZjqzU4o
         FPlpjKMLn4LcrlMX3a73ash2bJIqScfo5v8lLAdX9n3IDjLcGiVZdZdyVcYGnEy+g2Z/
         K4mhhk4XYzoisoL/tec11u3S7v7t3iC/Ut+iH3Q7m565T5Q1XK3nDvbEABr77CC1izWu
         NJflgwGWBxqCEhs6Kx6LccSyCLB0OqFUKlfSSuAz+5HZV9SJqdPul9fMRhaoq27Tlm9A
         /7FwgPYaWFUsqHZKJLcncALN9jkpG8xs9ERT1+N/QFi9aN9dYCPkhcDwUW5iAdbI1oMu
         nLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473371; x=1766078171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBhu1Uqa8RVHn7QCjomFckovl/MFhjzqjW3Qy6nBbgQ=;
        b=BPsMuyANk/4Z+p3gsIfupWqlemof+MyTIpjRFnVK/sL6cd6nzWyo51AK6UZEdGYQJ6
         G8M2dmRHMIwoHXNfg9z6qzPC9chO7IhkJFgfGtgwYNTJMAogZ8ocpnWnSz8VFOCas9YM
         2Y0quVC7yOuUbD9WsrpVDwv3XCoXS81e5wFbVxZwAQ9tqAWi8CZngE7ftXlQ8XSRkMNH
         KqywsazmHtiWkBn25rrR45zzuQ0DnSie2UrME5VXqBLykT5xXPMsABJ/AI3fzId9ss4R
         ArCpilsDTSnP2DFMXd/4LgcPUcjsh8elCnqVd0Ft7jgoIq0f0k9zk2sb/13uysZpg3gY
         Bfgw==
X-Forwarded-Encrypted: i=1; AJvYcCXA2KfXTwRzHYPjFoPyPujTFAjaQiDkahsPjcE9/S160gRGpZqASjJ2f7Ws8pbhyu0oy70eJxc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwBxOi3nyUcRGV3Jmqm5KMHM37+J4aYdg0RaT5838HiCEA+zbWl
	zUceOcsL2P9xkPWcs4vetQL9ONeNZDVblmY2lk7e1Dp5bNJR8PIOSlFc09ch4tB6eyk=
X-Gm-Gg: AY/fxX5S+IaowX+HSCtYucg+CMbvhPFwyMA+GxNmoOqr2gkd2rpwEmbgk79WbLcQG8u
	NnqLCZalyMCEStzRlKqCKNzj8ltvsbJBtYhPrX1AgfbS+CAQkKtY7LgeNdw1eNDPSRcW9isZTuX
	hGEkzik8YF2136na3TLe1Y565DXn7wY4Ka0fll6PX3DqGAgGHpfzhWVHD0XhDSOWRYBKZtt3zCN
	PwFqZrU9QugcwrEMOcdb1Wpviy5y7RGpKQu7s71MJFVHNxy+nhFxMAOTaxUrAte/S3RPxl8L/eA
	rS7gWykKGt4+4VM9uRwH4pTUV1516dlyo9O9VRgDUFmEGVaSRXo15DLS/qEBDZFVOH2RsQru+Iu
	GIwbVW0MnA2gz4dBQiHtdFNMzXHWY67FrhABjYWhPOBZ1cOH35AzspX8cMxMyh1OfiyGl6m+v8p
	WD4VHGoq2VfOxHF8n4ZXA+BbBt4FiuPEUUVX8v9ent3Sd1P789zsAOkk/TX0yP9qdb75hhh7+Gk
	tY=
X-Google-Smtp-Source: AGHT+IGk45+DhZ6tL02Xp6VckzN+X1jTYMhezBcXnBBMkdftVDcvtciBmncNg6/XCy6IPmPPgrbLng==
X-Received: by 2002:a05:600c:b8a:b0:477:8b2e:aa7d with SMTP id 5b1f17b1804b1-47a83847b05mr75101475e9.30.1765473371412;
        Thu, 11 Dec 2025 09:16:11 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89f8b31bsm48120115e9.13.2025.12.11.09.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:11 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v1 16/17] tpm/tpm_ftpm_tee: Make use of tee specific driver registration
Date: Thu, 11 Dec 2025 18:15:10 +0100
Message-ID: <812e5c580599b27d4f752ba8cfc35ad5371ab545.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=5qNJMJD9NKYLkVk7kOpcgd1zMxW4iDtExg+oTk6DzX8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhkyrP7ZRP1fMjFA/WaKg5FDBu+/h0r09x78+ZffZdZXTX K8x3rywk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJ/K5n/x8w65hR5gxFs+/u GzYLL+XpyOWJ+hfn4z9vftb2s2XL1hfeEixpKTt0buWjXDHxXelbk46nXLwyr6poXvT2xtqS9hl T1NyyC3deOH33eYneLyW9bPcF81Yo20hdYTD3mbLAI2qG4Xfn/yvcyzl26umo8Nk1r91sMq2Xsd piJS+/VXiansHLype26+RzmPXOi03Wz6/tW1i+2PjcOlmePwKFhbPYP9isfeKc5agau/VyuUlL/ emWkHg9Ad34ZQZXLqafXHT08r8IrWn8sW0Vmu+mJmmEs096+fBOW7qN5S7GphJeHcPI9zeLGR5s tdyd/pNpd+W7gEgO14dTjq/1jVD3LJzv5hjy+pTq2YcnAA==
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
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.54:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	BLOCKLISTDE_FAIL(0.00)[209.85.128.54:server fail];
	FREEMAIL_TO(0.00)[linaro.org,gmx.de,kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.54:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 718515002F
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: GVXNANCGVA45ZEGORWTGACJNGBOZE2ER
X-Message-ID-Hash: GVXNANCGVA45ZEGORWTGACJNGBOZE2ER
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:57:13 +0000
CC: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GVXNANCGVA45ZEGORWTGACJNGBOZE2ER/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

dGVlX2NsaWVudF9kcml2ZXJfcmVnaXN0ZXIoKSBpcyB0eXBlZCBtb3JlIHN0cm9uZ2x5IGFuZCBj
YXJlcyBhYm91dA0KYXNzaWduaW5nIHRoZSBkcml2ZXIncyBidXMuIFNpbWlsYXIgZm9yIHRlZV9j
bGllbnRfZHJpdmVyX3VucmVnaXN0ZXIoKS4NCg0KTWFrZSB1c2Ugb2YgdGhlc2UgZnVuY3Rpb25z
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQGJh
eWxpYnJlLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2hhci90cG0vdHBtX2Z0cG1fdGVlLmMgfCA1ICsr
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX2Z0cG1fdGVlLmMgYi9kcml2ZXJzL2No
YXIvdHBtL3RwbV9mdHBtX3RlZS5jDQppbmRleCA0ZTYzYzMwYWVhZjEuLmU1ZmJjNzBiMGVjYSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX2Z0cG1fdGVlLmMNCisrKyBiL2RyaXZl
cnMvY2hhci90cG0vdHBtX2Z0cG1fdGVlLmMNCkBAIC0zMzgsNyArMzM4LDYgQEAgc3RhdGljIHN0
cnVjdCB0ZWVfY2xpZW50X2RyaXZlciBmdHBtX3RlZV9kcml2ZXIgPSB7DQogCS5pZF90YWJsZQk9
IG9wdGVlX2Z0cG1faWRfdGFibGUsDQogCS5kcml2ZXIJCT0gew0KIAkJLm5hbWUJCT0gIm9wdGVl
LWZ0cG0iLA0KLQkJLmJ1cwkJPSAmdGVlX2J1c190eXBlLA0KIAkJLnByb2JlCQk9IGZ0cG1fdGVl
X3Byb2JlLA0KIAkJLnJlbW92ZQkJPSBmdHBtX3RlZV9yZW1vdmUsDQogCX0sDQpAQCAtMzUyLDcg
KzM1MSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGZ0cG1fbW9kX2luaXQodm9pZCkNCiAJaWYgKHJj
KQ0KIAkJcmV0dXJuIHJjOw0KIA0KLQlyYyA9IGRyaXZlcl9yZWdpc3RlcigmZnRwbV90ZWVfZHJp
dmVyLmRyaXZlcik7DQorCXJjID0gdGVlX2NsaWVudF9kcml2ZXJfcmVnaXN0ZXIoJmZ0cG1fdGVl
X2RyaXZlcik7DQogCWlmIChyYykgew0KIAkJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmZ0
cG1fdGVlX3BsYXRfZHJpdmVyKTsNCiAJCXJldHVybiByYzsNCkBAIC0zNjQsNyArMzYzLDcgQEAg
c3RhdGljIGludCBfX2luaXQgZnRwbV9tb2RfaW5pdCh2b2lkKQ0KIHN0YXRpYyB2b2lkIF9fZXhp
dCBmdHBtX21vZF9leGl0KHZvaWQpDQogew0KIAlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3Rlcigm
ZnRwbV90ZWVfcGxhdF9kcml2ZXIpOw0KLQlkcml2ZXJfdW5yZWdpc3RlcigmZnRwbV90ZWVfZHJp
dmVyLmRyaXZlcik7DQorCXRlZV9jbGllbnRfZHJpdmVyX3VucmVnaXN0ZXIoJmZ0cG1fdGVlX2Ry
aXZlcik7DQogfQ0KIA0KIG1vZHVsZV9pbml0KGZ0cG1fbW9kX2luaXQpOw0KLS0gDQoyLjQ3LjMN
Cg0K
