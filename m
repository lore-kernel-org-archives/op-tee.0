Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F8FD5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:20:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 430204FEDD
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:20:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=JAC5YQug;
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2869945454
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:42 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b73a9592fb8so756954066b.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808261; x=1766413061; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbC785QpAYQenK85VtICOF43iYYBs1NW0kuyf7DWA0o=;
        b=JAC5YQugQHFMfJruN3zMdToUG25Zfi+e+iESLuas83TRtCzU54VT3Wg/M3dEG8UsMw
         hSkJtcNuBQk99Din/rc5OisqAY9kazAfLcNHH93zG9SgJjXL0A9jI0PRau/xAMqgTw38
         vPDBsCiWhF3jsVeWdcY5j9HcGwU9rygJyK+lU6dZhFhteuFzZp6jj9eSjeqdYdRz4VTF
         uI+LAJKE8LtPTT8h0wWtaeO45RSTIJfTyLVn3Md8TKYVtmtsQgBXDQ0kviuM+TGUUF92
         3YpRG0oRpEGvGEX3FRH34+FuWvbUEgCkONy5KXzjYuIE4WnWvdaxaKu8MKW3L1VUA/4q
         nRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808261; x=1766413061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PbC785QpAYQenK85VtICOF43iYYBs1NW0kuyf7DWA0o=;
        b=pGdaqb68fOFO7GzfQRcb8bsRRSJT5kVkQKU+aPMF2OPSCSTNya/wTVedcswFnPu1Qu
         x1FWYIUl3WXZDpgPYRB/4uCg3I64GMWXCoJUhTitc8OKtbdMOQsgNV03GzJrW8fUmCII
         jEpW4hbAxXRDYUchieOcuh6qJxRWx2ULJpVhPd8+Bcgrm70/Iqd+QURlezYi7xVK6mi9
         mod4Snh5ASdHIr8PJKRQDpDi6qSqxdpc3BqqSkcC6nQPJe1CvTDul+xXdzL1yaskPJkj
         XAymwQ1zsfjYbR0anLSu/pUDkNeSfm6GzRB7k3zN4ZvXbWBJRZUEoBdyKk1PT+2t11DA
         vWVQ==
X-Gm-Message-State: AOJu0Yw7L5ZULgWzitPtRg58IckEp/zNNWaQm4YtFhEkvsB8OcDlnMcH
	UXjLWDAthWMiokU4Q96s2Rk1tc+0QDlPJOmGLuMZRQaSCOIgJD44k0kOdIwH94YxFKo=
X-Gm-Gg: AY/fxX6tIG/1Xdp318vVnt9hXOUjt5xvJNxKNhLQQ94WdMhONHgZ9T0ONNB8Geft5zq
	Z3SbTmoWZYR7opBcm+YeHfbAnPm3dX9FsXGuKVUM0HgcvdZSFe6BJbl5vk/8xJ/HBakgnSF+Gfk
	DD71T1zUNCye/bH5z/oQ4FmzRVgWQHU6ljoMBG4iQQcpBAs2BAbJYaO+pZ3jMQjMZCfTCbMUssy
	+X+MT5ICGg/nsLplE8ul7n7Pvpjc8DwzCZT2rYZwTgwNdEhUPfG9jBuDeIYNQkAGbVTsrIHTkTQ
	u4VyS9h3Tcki5Ex1qnr7IOytXGSWq0aOB1l/WPR0p18Gv9iruOwGWAJcbmqimNT9jmY9pI76okd
	jmtUlCEmOuQkNza/Zd4YT5QFv07W8NetlAeS2YzTYJB8Cg3eII2VGYg7cr2pxff3xL5Jj44BD1O
	z5rTnhCTGqsOV3CWyTiM1O0AiDOghSDZV1blutVnEjbxvLPA7Hv1j864sG8A==
X-Google-Smtp-Source: AGHT+IEZpKvQ+hycfkLhAZU1bkIfs9hjT/nN1SWB48QII7f5RuGpBZd/Ndg22CntlimXslvQkoET6A==
X-Received: by 2002:a17:907:94c6:b0:b7c:cc8d:14f4 with SMTP id a640c23a62f3a-b7d0213705cmr1612870366b.4.1765808261098;
        Mon, 15 Dec 2025 06:17:41 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64982040e2bsm13503641a12.6.2025.12.15.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:40 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2 04/17] hwrng: optee - Make use of module_tee_client_driver()
Date: Mon, 15 Dec 2025 15:16:34 +0100
Message-ID: <d0074b2e05cfb78ce5e95c875731e784bef52411.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SjEd6VJRjSq6j+23i9dm+VIV1mrWqjZFs7/yjFJu9o0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhVdjM0yUwXxXFzx4aHBLn/Ds+MiNtpCXJ3V 953KZqt7++JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYVQAKCRCPgPtYfRL+ Ts3hB/4rg9tut6lPOPfor6BYQUFfnX83d3OmNYlQfMOEoVlpBiI3dveN+tab1HfLbXvsdJxEYii PuEfVOeX7Lop+gOlexjK7TxmbSY/TFYicwC5P7r7a/LZ7avaYB1HjDktvTueCGtgHLmAXZsmleq ZW/qLiQmVbdCKMqrMp8aUxUI8wslhF5UCZYemgcXHho/CnsHqq90HdqXrY6Hwc4iStBkFZ34HDP MGqmlzs+XukATpnr7RjvVk8a0Nh+eXyUaEyglo/2O/9f6AU+PqUcKc3n7+2qU+LSDUz3egKtOYi xn1KyXoW6Dsw9bXNU8YUAOMXWO7Jj0msC1/mXh+DkgM3UJZg
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
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.50:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.50:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2869945454
X-Spamd-Bar: --
Message-ID-Hash: NHFNKK6CTNDZP5XE6SW2DKMCG34FAAN5
X-Message-ID-Hash: NHFNKK6CTNDZP5XE6SW2DKMCG34FAAN5
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NHFNKK6CTNDZP5XE6SW2DKMCG34FAAN5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

UmVkdWNlIGJvaWxlcnBsYXRlIGJ5IHVzaW5nIHRoZSBuZXdseSBpbnRyb2R1Y2VkIG1vZHVsZV90
ZWVfY2xpZW50X2RyaXZlcigpLg0KVGhhdCB0YWtlcyBjYXJlIG9mIGFzc2lnbmluZyB0aGUgZHJp
dmVyJ3MgYnVzLCBzbyB0aGUgZXhwbGljaXQgYXNzaWduaW5nDQppbiB0aGlzIGRyaXZlciBjYW4g
YmUgZHJvcHBlZC4NCg0KUmV2aWV3ZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1
YWxjb21tLmNvbT4NClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1r
b2VuaWdAYmF5bGlicmUuY29tPg0KLS0tDQogZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9vcHRlZS1y
bmcuYyB8IDE0ICstLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9od19yYW5kb20v
b3B0ZWUtcm5nLmMgYi9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL29wdGVlLXJuZy5jDQppbmRleCA5
NmI1ZDU0NmQxMzYuLjZlZTc0OGMwY2Y1NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2hhci9od19y
YW5kb20vb3B0ZWUtcm5nLmMNCisrKyBiL2RyaXZlcnMvY2hhci9od19yYW5kb20vb3B0ZWUtcm5n
LmMNCkBAIC0yODEsMjQgKzI4MSwxMiBAQCBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVy
IG9wdGVlX3JuZ19kcml2ZXIgPSB7DQogCS5pZF90YWJsZQk9IG9wdGVlX3JuZ19pZF90YWJsZSwN
CiAJLmRyaXZlcgkJPSB7DQogCQkubmFtZQkJPSBEUklWRVJfTkFNRSwNCi0JCS5idXMJCT0gJnRl
ZV9idXNfdHlwZSwNCiAJCS5wcm9iZQkJPSBvcHRlZV9ybmdfcHJvYmUsDQogCQkucmVtb3ZlCQk9
IG9wdGVlX3JuZ19yZW1vdmUsDQogCX0sDQogfTsNCiANCi1zdGF0aWMgaW50IF9faW5pdCBvcHRl
ZV9ybmdfbW9kX2luaXQodm9pZCkNCi17DQotCXJldHVybiBkcml2ZXJfcmVnaXN0ZXIoJm9wdGVl
X3JuZ19kcml2ZXIuZHJpdmVyKTsNCi19DQotDQotc3RhdGljIHZvaWQgX19leGl0IG9wdGVlX3Ju
Z19tb2RfZXhpdCh2b2lkKQ0KLXsNCi0JZHJpdmVyX3VucmVnaXN0ZXIoJm9wdGVlX3JuZ19kcml2
ZXIuZHJpdmVyKTsNCi19DQotDQotbW9kdWxlX2luaXQob3B0ZWVfcm5nX21vZF9pbml0KTsNCi1t
b2R1bGVfZXhpdChvcHRlZV9ybmdfbW9kX2V4aXQpOw0KK21vZHVsZV90ZWVfY2xpZW50X2RyaXZl
cihvcHRlZV9ybmdfZHJpdmVyKTsNCiANCiBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQogTU9E
VUxFX0FVVEhPUigiU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0BsaW5hcm8ub3JnPiIpOw0KLS0gDQoy
LjQ3LjMNCg0K
