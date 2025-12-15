Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA93DD5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:21:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 093994FEDC
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:21:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ubrgRDej;
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8AB734FEBB
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:43 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so5506258a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808262; x=1766413062; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIUQR9A1vYIw9QlcE/Qa0VTdIdcn5aCO46D96t68m0E=;
        b=ubrgRDejGTI58QrFQ+DZb20i7HZC2QSJeuPgrb0HwmrRabQDHi6WdytzWBGZMd4GRl
         QbBRqNP4PL/bLlenvtkfhEfKex9s5YbrDV/m0iCw81ZP9SAFRzD8YYUJmcIG1MFRYL7P
         8AJZNl5HpKd+KgMO3xptzst0C89PDw1MrErflSnnPCuY6Z/3V2BtH4k2t1+m4a/XhNLh
         3DafxXmLp/O4T0g1iRj1NrPbf6OrcgY7FCjjYziIx2xrua98vuaCNumsnCf8klabX+qx
         A44scSq72gUmmWvYkWRErGpMY8tyd3gVhVFwrFYtcclV7rluWAgIL/WACFacdjqQ1+2x
         HEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808262; x=1766413062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QIUQR9A1vYIw9QlcE/Qa0VTdIdcn5aCO46D96t68m0E=;
        b=SrMDP/pkxMewyYCdwtU6NwtNichpLYBASxpg44kmWjqtHMZMMgWct6n35Gx5lnYSx7
         62hGutyDaDm8EydEWeJGKbcoyXdXk32HRrNxmkYjy106lffztP+5D8MtlH4j9A6VJAKS
         Oh1pO73v+mejaCF9ZWxS/VZZv93CIt5I/w4gmBBCDeQtOw+UY7up7OhP0+pTdcveCM0c
         icdDpR2jSHDgLRusM4/VRz0LgLTKRgivj///X0Ettvwa3bdrvC4zQ3xfU8iS9Tu+sOFb
         7HXEQE8dGjdas6YXBYyqnEicyhlwFWqGp/L6aXrku7wxSU4wYWwG21TtaEN1yLp0jFNy
         61ow==
X-Gm-Message-State: AOJu0YxCWDtrQUwnB8ld4VepIvGjcSbFZZNkIDkoyv+HdI1RHW0lJpPa
	tUImakZ2w32gx+fnK0Z6j2halx0OlhHtx5h3z2k4090pY0KXjEnQ9gav13xTsiAoI+5uNCj68WS
	56/nj
X-Gm-Gg: AY/fxX5nJyu5sMjMshA/8z5KUq/Ptj4iZHZuNSFxrQp0Cj8y/0641dQAHCo5v/4dD2d
	e+rTXV187kSjPCDzQQWFHenbHBngc70DXWYMmoMiGliHxy/hI6TgPBAaKzRx9QcuHmbCwWcE5po
	B19/+d1bRvDy10V1uVMq/3AxFPzF9+y7lUKxNdgrf/JBK3oY8Ew6Z7q+Nyl27TwxofWhN9TmyiM
	29kANEJqEaJBnOTLmkgEGBYZXfW6LTxTOgpTRc+7LpHS6DUKbkvbv8aNMYe02hM/cwugF3syR2m
	QZ18Nod0bSHzdxA4mDdrvb9x8X0u4ECEeWlq+rxHJQJZW/3RtrLzZJyIKn8JdaZBSDS40pcIaBc
	w4f+eW7O+PHID8Ys4qNk7mMWdq0qB/MLlmiITvSG0EW8OoD5sLeMvG5QDkXmMakt+ZOsRL+bcCk
	roBV5J3DpHyYG6SSXCjZSpEtDB336kyfeh0PgI5cm2dz9TUQkxA54tHi2lDA==
X-Google-Smtp-Source: AGHT+IGgNV09AuYgsqnGmm65Wezv684KCpS+08Dd8VMBIrTAAoyAJyvM9gNMVpz7WAarxXBPjKme+g==
X-Received: by 2002:a17:907:1c0b:b0:b7a:1be1:984 with SMTP id a640c23a62f3a-b7d23a912c7mr1001442866b.64.1765808262516;
        Mon, 15 Dec 2025 06:17:42 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6498204fbb3sm13523420a12.8.2025.12.15.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:42 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2 05/17] hwrng: optee - Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:35 +0100
Message-ID: <170dceec036ffe468a1f9f26fa08ac9e157ada29.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=1uJJpA9Ql9BbSXGSv2HLkK7u07CA6mF+itptx+5e3Xs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhXu4/bwtxASM5yQ5sR2LOaNmcTkAhZ5XaYd riWdpm51lGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYVwAKCRCPgPtYfRL+ TiHYB/0Rn5IqZ2NZ5jNZ7qhs3+bCUIODZ5brLERcCe++79d/CFyEMLoIbkC7IrHhW/w6rf8d5ec P3QZ4XFV36zh0ByWKjm37dnphaan9VGVrf3AOnvcgTNpNtFsFzh70z9s8VN9xvgRW5tbAllBM7f fd6pZoiQz7yXeDj/OkdNa8vtTlSqOpTihSEM6wu3U97yq1lWfdiYBrT8Gjj3IP4VXRlPbVJHG44 3sLs6/eDddZUsq1L/LxYImmr8SVdBeskUGgqQufZsne2BQzMWhpxd2mBDY1olq/Bx/0yevHUr7Z CvGicBaxS9KGPVUHWdtAeD3h/4gmlwcbWLWHtXpWAJX/J/l4
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.48:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.48:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8AB734FEBB
X-Spamd-Bar: --
Message-ID-Hash: 4U3Y5BX43DYAC75QIXNNEVP47MXTX7VF
X-Message-ID-Hash: 4U3Y5BX43DYAC75QIXNNEVP47MXTX7VF
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4U3Y5BX43DYAC75QIXNNEVP47MXTX7VF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBidXMgZ290IGRlZGljYXRlZCBjYWxsYmFja3MgZm9yIHByb2JlIGFuZCByZW1vdmUu
DQpNYWtlIHVzZSBvZiB0aGVzZS4gVGhpcyBmaXhlcyBhIHJ1bnRpbWUgd2FybmluZyBhYm91dCB0
aGUgZHJpdmVyIG5lZWRpbmcNCnRvIGJlIGNvbnZlcnRlZCB0byB0aGUgYnVzIG1ldGhvZHMuDQoN
ClJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQGJheWxpYnJl
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2hhci9od19yYW5kb20vb3B0ZWUtcm5nLmMgfCAxMiArKysr
Ky0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9vcHRlZS1ybmcuYyBiL2Ry
aXZlcnMvY2hhci9od19yYW5kb20vb3B0ZWUtcm5nLmMNCmluZGV4IDZlZTc0OGMwY2Y1Ny4uNWEz
ZmEwYjM4NDk3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9vcHRlZS1ybmcu
Yw0KKysrIGIvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9vcHRlZS1ybmcuYw0KQEAgLTIxMSw5ICsy
MTEsOSBAQCBzdGF0aWMgaW50IG9wdGVlX2N0eF9tYXRjaChzdHJ1Y3QgdGVlX2lvY3RsX3ZlcnNp
b25fZGF0YSAqdmVyLCBjb25zdCB2b2lkICpkYXRhKQ0KIAkJcmV0dXJuIDA7DQogfQ0KIA0KLXN0
YXRpYyBpbnQgb3B0ZWVfcm5nX3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldikNCitzdGF0aWMgaW50
IG9wdGVlX3JuZ19wcm9iZShzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2UgKnJuZ19kZXZpY2UpDQog
ew0KLQlzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2UgKnJuZ19kZXZpY2UgPSB0b190ZWVfY2xpZW50
X2RldmljZShkZXYpOw0KKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcm5nX2RldmljZS0+ZGV2Ow0K
IAlpbnQgcmV0ID0gMCwgZXJyID0gLUVOT0RFVjsNCiAJc3RydWN0IHRlZV9pb2N0bF9vcGVuX3Nl
c3Npb25fYXJnIHNlc3NfYXJnOw0KIA0KQEAgLTI2MSwxMiArMjYxLDEwIEBAIHN0YXRpYyBpbnQg
b3B0ZWVfcm5nX3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJcmV0dXJuIGVycjsNCiB9DQog
DQotc3RhdGljIGludCBvcHRlZV9ybmdfcmVtb3ZlKHN0cnVjdCBkZXZpY2UgKmRldikNCitzdGF0
aWMgdm9pZCBvcHRlZV9ybmdfcmVtb3ZlKHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqdGVlX2Rl
dikNCiB7DQogCXRlZV9jbGllbnRfY2xvc2Vfc2Vzc2lvbihwdnRfZGF0YS5jdHgsIHB2dF9kYXRh
LnNlc3Npb25faWQpOw0KIAl0ZWVfY2xpZW50X2Nsb3NlX2NvbnRleHQocHZ0X2RhdGEuY3R4KTsN
Ci0NCi0JcmV0dXJuIDA7DQogfQ0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVlX2NsaWVudF9k
ZXZpY2VfaWQgb3B0ZWVfcm5nX2lkX3RhYmxlW10gPSB7DQpAQCAtMjc4LDExICsyNzYsMTEgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZV9pZCBvcHRlZV9ybmdfaWRfdGFi
bGVbXSA9IHsNCiBNT0RVTEVfREVWSUNFX1RBQkxFKHRlZSwgb3B0ZWVfcm5nX2lkX3RhYmxlKTsN
CiANCiBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIG9wdGVlX3JuZ19kcml2ZXIgPSB7
DQorCS5wcm9iZQkJPSBvcHRlZV9ybmdfcHJvYmUsDQorCS5yZW1vdmUJCT0gb3B0ZWVfcm5nX3Jl
bW92ZSwNCiAJLmlkX3RhYmxlCT0gb3B0ZWVfcm5nX2lkX3RhYmxlLA0KIAkuZHJpdmVyCQk9IHsN
CiAJCS5uYW1lCQk9IERSSVZFUl9OQU1FLA0KLQkJLnByb2JlCQk9IG9wdGVlX3JuZ19wcm9iZSwN
Ci0JCS5yZW1vdmUJCT0gb3B0ZWVfcm5nX3JlbW92ZSwNCiAJfSwNCiB9Ow0KIA0KLS0gDQoyLjQ3
LjMNCg0K
