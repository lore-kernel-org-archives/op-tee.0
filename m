Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C56CAC5B0
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 09:56:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 43B3D431E1
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 09:56:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mdwlKyuC;
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DDBDE41BB9
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 09:56:36 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e29d65728so4751825e9.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758707796; x=1759312596; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PRSL/1nJSQ5kI07UrUanYwK66jzdWfPHTpIh5wL8rXk=;
        b=mdwlKyuCz9v9XuRNEKs3EThUZfX8nDwvel6ucdHzsRSLYPE7m+OGcOS6akWkCJBewk
         MpecwH3hsx/LZ/uC1IuW6RqlyleyBd+nwuTU05FoQzJkIXCBEuvzcBuE0xz9p7h9v0bf
         +mY/q74lApHxH6BHU/dyykgKcJpJ9NAeTPRbTqQ0JpCCeZQyXFK9Gm6A1Jz8kfd4hXUg
         vBffatIPiDkgK9gX+BVy7zCihdIoPPxTMNGDHxHcAJtqjzGti+3xfDWSt9mT61ISm+03
         incFmliosRA6xhBNthUC/uYcuVsdoVkQeMueSzSXb0otQgCSJs1fkKSVPOjUNx6UHWDH
         WN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707796; x=1759312596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRSL/1nJSQ5kI07UrUanYwK66jzdWfPHTpIh5wL8rXk=;
        b=FZIypBMrgl5Ag2h99DGksIoYndUfYDqBLFqPb4ADYIcSGEG8XeuUGdYAn1fVKcE+RL
         yYzINOOeFAf15bGFSEIQdYt/I1lc0IgJLuS3KpXEpc1w4gbJ4/OyG/O8xXrtOojw1WdL
         45wQGfmb3hZgHis8MX576Ji/xC3S0VzsN4EsD+rbiun8maUaQPeS/02KednzHmx8Yn6X
         tMHvQlUMpjE1K1IDqElf97KsmaIcPmMOOM9LW2PVMdQhNur2wmKWKOoobXhTzmQ88jn4
         WHkKuTHqSNjpI3QSZCbSXmFus/1vdx4/EcDrO79X5i8s+6U1UkfNRnI1A9y6NM5nszsz
         yRfg==
X-Forwarded-Encrypted: i=1; AJvYcCVH9eRpmmTETE4LQsdGnVDfdvRyxZCLHymbOZzwj+5D7CYOWx4zDUlf/ManT2i6tg20nPDCcN0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwH/xHXc/T/qCZ1QdXgYO/QLb5poqwltrXsuvaP/wwQN8nRxFjA
	rZa555/puSznwkR0rtOntfzDNdnXHcgPXgMDvnDTOezCVQ3qc7GL5ooYhvPnWHA0ERJ8jA==
X-Gm-Gg: ASbGnctU8NxR5HLp4Itr+xiG1OfqCjQXFGIcJm84gowZ2E0NViH8SU8rSmCpMdiDjUM
	s2MomvXNQmdBSwNtLMM4u3gHYSES7kc5J64PCTBnxx16gsRAm43JDnXLNJ1sad6/k1IHJ7C/fm4
	p855YVRWJPGjuCoNJ7qtLDWABvYouS76PI2zJ/mjTx2RcrGqo06etVWdiIhGf5L4cv20aRMRAaC
	78Zk7m0jb0BTP06SyoCn9prhZV8SlAAPOCAvKbJSIBnaiYs+Q9nd9Wz7IdL0/xgpXmLI/NWUPcn
	qslfMVNrB5wjPzAorJ76buixSRgCyRzzFPuGr/QiWrsbis6yD1BIeX7lBxArNHGGfKY6I+i6nec
	umQ0XB41GyXkGU9n/HxQ2EVA9Ye74BL3xwJlHMBg=
X-Google-Smtp-Source: AGHT+IEV83QRdmbsMqgiTy+g6mdP+Mx8Vek5R5nQm/u5KqDUFtolGSlsI9sVken95Qe9w/ozF+U6xg==
X-Received: by 2002:a05:600c:3b11:b0:46d:1046:d356 with SMTP id 5b1f17b1804b1-46e1dac2e1cmr45790995e9.27.1758707795692;
        Wed, 24 Sep 2025 02:56:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3f70b47ca57sm16940084f8f.0.2025.09.24.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:56:35 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:56:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
Message-ID: <aNPAT_uf-JFvBvkV@stanley.mountain>
References: <aMvV4kK386Sni10i@stanley.mountain>
 <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
 <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>
 <aNOfXlG21HIBR18E@stanley.mountain>
 <CAHUa44G2yaB28sd0FjkjyCNJKXjx2Jg9j-9HXytyvsmiQ3ThAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44G2yaB28sd0FjkjyCNJKXjx2Jg9j-9HXytyvsmiQ3ThAA@mail.gmail.com>
X-Rspamd-Queue-Id: DDBDE41BB9
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.47:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.47:from];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: HZDTDNSL2MO6OWLVJSUJZE2TXEPDH74L
X-Message-ID-Hash: HZDTDNSL2MO6OWLVJSUJZE2TXEPDH74L
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HZDTDNSL2MO6OWLVJSUJZE2TXEPDH74L/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

T24gV2VkLCBTZXAgMjQsIDIwMjUgYXQgMTE6MjE6MzRBTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IE9uIFdlZCwgU2VwIDI0LCAyMDI1IGF0IDk6MzbigK9BTSBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBTZXAg
MjQsIDIwMjUgYXQgMDg6NTg6NDVBTSArMTAwMCwgQW1pcnJlemEgWmFycmFiaSB3cm90ZToNCj4g
PiA+DQo+ID4gPg0KPiA+ID4gT24gOS8yNC8yMDI1IDg6NDggQU0sIEFtaXJyZXphIFphcnJhYmkg
d3JvdGU6DQo+ID4gPiA+IE9uIDkvMTgvMjAyNSA3OjUwIFBNLCBEYW4gQ2FycGVudGVyIHdyb3Rl
Og0KPiA+ID4gPj4gUmUtb3JkZXIgdGhlc2UgY2hlY2tzIHRvIGNoZWNrIGlmICJpIiBpcyBhIHZh
bGlkIGFycmF5IGluZGV4IGJlZm9yZSB1c2luZw0KPiA+ID4gPj4gaXQuICBUaGlzIHByZXZlbnRz
IGEgcG90ZW50aWFsIG9mZiBieSBvbmUgcmVhZCBhY2Nlc3MuDQo+ID4gPiA+Pg0KPiA+ID4gPj4g
Rml4ZXM6IGQ2ZTI5MDgzN2U1MCAoInRlZTogYWRkIFF1YWxjb21tIFRFRSBkcml2ZXIiKQ0KPiA+
ID4gPj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8u
b3JnPg0KPiA+ID4gPj4gLS0tDQo+ID4gPiA+PiAgZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMg
fCAyICstDQo+ID4gPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gPiA+Pg0KPiA+ID4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL3Fjb210
ZWUvY2FsbC5jIGIvZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMNCj4gPiA+ID4+IGluZGV4IGNj
MTdhNDhkMGFiNy4uYWMxMzQ0NTJjYzljIDEwMDY0NA0KPiA+ID4gPj4gLS0tIGEvZHJpdmVycy90
ZWUvcWNvbXRlZS9jYWxsLmMNCj4gPiA+ID4+ICsrKyBiL2RyaXZlcnMvdGVlL3Fjb210ZWUvY2Fs
bC5jDQo+ID4gPiA+PiBAQCAtMzA4LDcgKzMwOCw3IEBAIHN0YXRpYyBpbnQgcWNvbXRlZV9wYXJh
bXNfZnJvbV9hcmdzKHN0cnVjdCB0ZWVfcGFyYW0gKnBhcmFtcywNCj4gPiA+ID4+ICAgIH0NCj4g
PiA+ID4+DQo+ID4gPiA+PiAgICAvKiBSZWxlYXNlIGFueSBJTyBhbmQgT08gb2JqZWN0cyBub3Qg
cHJvY2Vzc2VkLiAqLw0KPiA+ID4gPj4gLSAgZm9yICg7IHVbaV0udHlwZSAmJiBpIDwgbnVtX3Bh
cmFtczsgaSsrKSB7DQo+ID4gPiA+PiArICBmb3IgKDsgaSA8IG51bV9wYXJhbXMgJiYgdVtpXS50
eXBlOyBpKyspIHsNCj4gPiA+ID4+ICAgICAgICAgICAgaWYgKHVbaV0udHlwZSA9PSBRQ09NVEVF
X0FSR19UWVBFX09PIHx8DQo+ID4gPiA+PiAgICAgICAgICAgICAgICB1W2ldLnR5cGUgPT0gUUNP
TVRFRV9BUkdfVFlQRV9JTykNCj4gPiA+ID4+ICAgICAgICAgICAgICAgICAgICBxY29tdGVlX29i
amVjdF9wdXQodVtpXS5vKTsNCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBpcyBub3QgcmVxdWlyZWQs
IGNvbnNpZGVyaW5nIHRoZSBzZXF1ZW5jZSBvZiBjbGVhbiB1cCwgdGhpcw0KPiA+ID4gPiB3b3Vs
ZCBuZXZlciBoYXBwZW4uIGBpYCBhdCBsZWFzdCBoYXZlIGJlZW4gYWNjZXNzZWQgb25jZSBpbiB0
aGUNCj4gPiA+ID4gc3dpdGNoIGFib3ZlLg0KPiA+ID4gPg0KPiA+ID4gPiBSZWdhcmRzLA0KPiA+
ID4gPiBBbWlyDQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gQWxzbywgc2l6ZSBvZiB1
IGlzIGFsd2F5cyBudW1fcGFyYW1zICsgMSBmb3IgdGhlIGVuZGluZyAwLg0KPiA+ID4gKGJhc2lj
YWxseSBtZWFucyBgaSA8IG51bV9wYXJhbXNgIGNhbiBiZSByZW1vdmVkKS4NCj4gPiA+DQo+ID4N
Cj4gPiBZZXMuICBUaGlzIGlzIHRydWUuDQo+IA0KPiBTbyB0aGlzIHBhdGNoIGlzbid0IG5lZWRl
ZC4gSSdsbCBkcm9wIGl0IGlmIG5vIG9uZSBvYmplY3RzLg0KDQpUaGUgcGF0Y2ggbWFrZXMgdGhl
IGNvZGUgYmV0dGVyIHRob3VnaC4uLiAgSXQgbmV2ZXIgcmVhbGx5IG1ha2VzIHNlbnNlDQp0byB1
c2UgYSB2YXJpYWJsZSBmaXJzdCBhbmQgdGhlbiBjaGVjayBpZiBpdCdzIHZhbGlkIGxhdGVyLiAg
SW4gdGhpcw0KY2FzZSB0aGUgY2hlY2sgaXNuJ3QgcmVxdWlyZWQuDQoNCklkZWFsbHkgdGhlIGNv
ZGUgd291bGQgb25seSBoYXZlIG9uZSBsaW1pdC4gIFdlIGNvdWxkIGVpdGhlciBkbzoNCg0KCWZv
ciAoOyBpIDwgbnVtX3BhcmFtczsgaSsrKSB7DQpPcjoNCglmb3IgKDsgdVtpXS50eXBlICE9IFFD
T01URUVfQVJHX1RZUEVfSU5WOyBpKyspIHsNCg0KRWl0aGVyIHdheSB3b3Jrcy4uLg0KDQpyZWdh
cmRzLA0KZGFuIGNhcnBlbnRlcg0KDQo=
