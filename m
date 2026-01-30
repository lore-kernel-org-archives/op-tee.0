Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6065E6BF1B
	for <op-tee@archiver.kernel.org>; Fri, 30 Jan 2026 15:04:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 11A124329F
	for <op-tee@archiver.kernel.org>; Fri, 30 Jan 2026 15:04:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EyjulrUH;
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E76764329F
	for <op-tee@lists.trustedfirmware.org>; Fri, 30 Jan 2026 15:03:43 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso23857085e9.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 30 Jan 2026 07:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769785423; x=1770390223; darn=lists.trustedfirmware.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=thq0kwrsVjkmoBy4Hq4IMi59MV9M0Mi8MaVexvz33lI=;
        b=EyjulrUHJlGIWlRlm59YxlO2Sd+TgVxzoo0iynSEf3W7LieWWdCSOnpihifOpLkj4S
         qNGyMDhwauwFAIVrP8sKEKOl2OsL4/tTIUgh2oaDN9/PMl/ypmCdfTY4m30tpaNOxi49
         uvFppROvqchlhl9jMdag3j0AX7yEophSdf0ySZpXZOsLOmGTGx65BO7rS+tY7x0vmw2w
         Zr3xHPv0uWBbSnMRHGI9BktlLaq/y0pkbJphG2Is1LErcnxw2jWKf2GJUzqRotlKyFUJ
         bVIVwPFbYseddWZnge2SpRkt4XgVdF5d8X/I6yFhUJcoewHYy+vYTvFlmGSVCkqJq7Al
         AuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769785423; x=1770390223;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thq0kwrsVjkmoBy4Hq4IMi59MV9M0Mi8MaVexvz33lI=;
        b=by4o93KJt4BPJrn+S4wUPNmZmvnzO7Nk4KGg+m21vsDVsb7+6xjwblIZxpUrdOb9I0
         Y0tre4Kz5aNt0ZPl4j9RDPdR629fgljcKsEzCsfDpRIXOmPO1WMwyqtXRvgJ3iy8QiY4
         DZGIXoRpjPzrq8ofnpnwvfEHmP2RlORtN0ySvtqsoCpdmqEx63Y3fL7wZd3humfGYPRU
         pbUkXvzMWxfPowAPFy0UvOHUUAgQaOJssKP32Oq3VpD9Z9mI++LJnQXJhj+10ne+Zfgg
         ADEuQ9Z4dFwFTQy8BbTkgVYie6YMmzCBVARixmb/W86+PuQoL2zYU6CM7ZJOT0eFkJPz
         gT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtU4FdaM9NqUuBQjz7OW68eb4zfOrvRjy5KKlGsxQRHBr7HN1P07K6mSWwvzc6Bzp8EqssJr8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzCrCSsQ+0dsn0cAd/pa8xRBZxh21ReMngzQJEGjfyr4IXLc1zv
	vjnhjnECix01T0wpY5Ks4H2TfDbVG7861qITBZn/6FbBWJOm8wp9CTXZvxdrrgZlQhZ5Iw==
X-Gm-Gg: AZuq6aLRb8R6l1RrBWc/k1iT+H3uwmtf9sD4XTiLt0MXFZ32v/JVfYLoYqL5YTfPmfp
	a1RXm7X5nr3zW1q/HBb4a1OdQJQ00pRjqJnVe0RXwm4L3GckjVR51PY5dVNnolkxH9v+9/XZ5bK
	YrSZV1ayuX6kfBlT7OXjzXLiWQp7De4c2qaIyRNYDa8we8N6+VsW4gKsPh1EQz1ocn39JECAr7q
	gd8b05REIb3L+E19Z6buUwwhKZ3p9hb56IykUwBcf9cWO2PCRDULzwy9ypUaNjPtrQFg+YxeZtN
	AmQdT1BrEVLB2pEgD2ZNpE0E4doFv3oT2Tc2rwz3TxL726IeimKC35C1Bejdxd2ViqIyiq2aZbW
	5nOTz9PuPX8L48aUvfMhtY0dpd3waodsK9VpQqF1yuTZRqle+Bu73qmcVDWZIIHDgG+9XbnmEUr
	YKaokaoM4vX8AsxlgHc/K78ErxZZmPsoPovLVcqOB78ZT1xTCfoeedMp1Zsy/8RaUTw1olnAT8n
	xqP+qTAbg==
X-Received: by 2002:a05:600c:1c02:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-482db494df7mr41910225e9.24.1769785422746;
        Fri, 30 Jan 2026 07:03:42 -0800 (PST)
Received: from ?IPv6:2a02:3030:667:8639:a801:6b4d:7772:893b? ([2a02:3030:667:8639:a801:6b4d:7772:893b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e2e3bf18sm16546345e9.19.2026.01.30.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:03:42 -0800 (PST)
Message-ID: <e05ccdce1e82b42e837d104922eec1600cce579d.camel@linaro.org>
Subject: Re: [PATCH 3/3] rtc: optee: simplify OP-TEE context match
From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Fri, 30 Jan 2026 16:03:37 +0100
In-Reply-To: <202601291605277bc279f4@mail.local>
References: 
	<20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
	 <20260126-optee-simplify-context-match-v1-3-d4104e526cb6@linaro.org>
	 <202601291605277bc279f4@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.44:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[209.85.128.44:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E76764329F
X-Spamd-Bar: ---
Message-ID-Hash: 4AGCBL2N7UZGTIY4TJLQTWLXTOLWMM55
X-Message-ID-Hash: 4AGCBL2N7UZGTIY4TJLQTWLXTOLWMM55
X-MailFrom: rouven.czerwinski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4AGCBL2N7UZGTIY4TJLQTWLXTOLWMM55/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgQWxleGFuZHJlLAoKT24gVGh1LCAyMDI2LTAxLTI5IGF0IDE3OjA1ICswMTAwLCBBbGV4YW5k
cmUgQmVsbG9uaSB3cm90ZToKPiBPbiAyNi8wMS8yMDI2IDExOjExOjI2KzAxMDAsIFJvdXZlbiBD
emVyd2luc2tpIHZpYSBCNCBSZWxheSB3cm90ZToKPiA+IEZyb206IFJvdXZlbiBDemVyd2luc2tp
IDxyb3V2ZW4uY3plcndpbnNraUBsaW5hcm8ub3JnPgo+ID4gCj4gPiBTaW1wbGlmeSB0aGUgVEVF
IGltcGxlbWVudG9yIElEIG1hdGNoIGJ5IHJldHVybmluZyB0aGUgYm9vbGVhbgo+ID4gZXhwcmVz
c2lvbiBkaXJlY3RseSBpbnN0ZWFkIG9mIGdvaW5nIHRocm91Z2ggYW4gaWYvZWxzZS4KPiA+IAo+
ID4gU2lnbmVkLW9mZi1ieTogUm91dmVuIEN6ZXJ3aW5za2kgPHJvdXZlbi5jemVyd2luc2tpQGxp
bmFyby5vcmc+Cj4gPiAtLS0KPiA+IMKgZHJpdmVycy9ydGMvcnRjLW9wdGVlLmMgfCA1ICstLS0t
Cj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkKPiA+
IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL3J0Yy1vcHRlZS5jIGIvZHJpdmVycy9ydGMv
cnRjLW9wdGVlLmMKPiA+IGluZGV4IDE4NGM2ZDE0MjgwMS4uMmYxOGJlM2RlNjg0IDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9ydGMvcnRjLW9wdGVlLmMKPiA+ICsrKyBiL2RyaXZlcnMvcnRjL3J0
Yy1vcHRlZS5jCj4gPiBAQCAtNTQxLDEwICs1NDEsNyBAQCBzdGF0aWMgaW50IG9wdGVlX3J0Y19y
ZWFkX2luZm8oc3RydWN0IGRldmljZQo+ID4gKmRldiwgc3RydWN0IHJ0Y19kZXZpY2UgKnJ0YywK
PiA+IMKgCj4gPiDCoHN0YXRpYyBpbnQgb3B0ZWVfY3R4X21hdGNoKHN0cnVjdCB0ZWVfaW9jdGxf
dmVyc2lvbl9kYXRhICp2ZXIsCj4gPiBjb25zdCB2b2lkICpkYXRhKQo+ID4gwqB7Cj4gPiAtCWlm
ICh2ZXItPmltcGxfaWQgPT0gVEVFX0lNUExfSURfT1BURUUpCj4gPiAtCQlyZXR1cm4gMTsKPiA+
IC0JZWxzZQo+ID4gLQkJcmV0dXJuIDA7Cj4gPiArCXJldHVybiAodmVyLT5pbXBsX2lkID09IFRF
RV9JTVBMX0lEX09QVEVFKTsKPiAKPiBJIGd1ZXNzIHRoZSBjb3JyZWN0IHdheSB0byBkbyB0aGlz
IHdvdWxkIGJlOgo+IAo+IHJldHVybiAhISh2ZXItPmltcGxfaWQgPT0gVEVFX0lNUExfSURfT1BU
RUUpOwoKQ291bGQgeW91IGV4cGxhaW4gd2h5PyBJZiBJIHJlYWQgdGhlIHN0YW5kYXJkIGNvcnJl
Y3RseSwgYW4gZXF1YWxpdHkKb3BlcmF0aW9uIGFsd2F5cyBwcm9kdWNlcyBlaXRoZXIgMSBvciAw
LCBzbyB0aGVyZSBzaG91bGQgYmUgbm8gbmVlZCBmb3IKISEgaGVyZSBsaWtlIHRoZXJlIGlzIGZv
ciBiaXQgZmxhZyBjb21wYXJpc29ucywgaS5lLiAhIShmbGFnICYKU09NRV9GTEFHX1NFVCkgdG8g
bm9ybWFsaXplIHRvIDEgb3IgMC4gV29uZGVyaW5nIGlmIEkgYW0gbWlzc2luZwpzb21ldGhpbmcu
Cgo+IEJ1dCBpcyB0aGlzIGNoYW5nZSBhY3R1YWxseSBnZW5lcmF0aW5nIGJldHRlciBjb2RlPwo+
IAo+IEJlZm9yZToKPiAKPiBzdGF0aWMgaW50IG9wdGVlX2N0eF9tYXRjaChzdHJ1Y3QgdGVlX2lv
Y3RsX3ZlcnNpb25fZGF0YSAqdmVyLCBjb25zdAo+IHZvaWQgKmRhdGEpCj4gewo+IMKgwqDCoMKg
wqDCoMKgIGlmICh2ZXItPmltcGxfaWQgPT0gVEVFX0lNUExfSURfT1BURUUpCj4gwqDCoMKgwqDC
oMKgIDA6wqDCoMKgwqDCoMKgIGU1OTAwMDAwwqDCoMKgwqDCoMKgwqAgbGRywqDCoMKgwqAgcjAs
IFtyMF0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDE7Cj4gwqDCoMKg
wqDCoMKgwqAgZWxzZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsK
PiB9Cj4gwqDCoMKgwqDCoMKgIDQ6wqDCoMKgwqDCoMKgIGUyNDAwMDAxwqDCoMKgwqDCoMKgwqAg
c3ViwqDCoMKgwqAgcjAsIHIwLCAjMQo+IMKgwqDCoMKgwqDCoCA4OsKgwqDCoMKgwqDCoCBlMTZm
MGYxMMKgwqDCoMKgwqDCoMKgIGNsesKgwqDCoMKgIHIwLCByMAo+IMKgwqDCoMKgwqDCoCBjOsKg
wqDCoMKgwqDCoCBlMWEwMDJhMMKgwqDCoMKgwqDCoMKgIGxzcsKgwqDCoMKgIHIwLCByMCwgIzUK
PiDCoMKgwqDCoMKgIDEwOsKgwqDCoMKgwqDCoCBlMTJmZmYxZcKgwqDCoMKgwqDCoMKgIGJ4wqDC
oMKgwqDCoCBscgo+IAo+IEFmdGVyOgo+IAo+IHN0YXRpYyBpbnQgb3B0ZWVfY3R4X21hdGNoKHN0
cnVjdCB0ZWVfaW9jdGxfdmVyc2lvbl9kYXRhICp2ZXIsIGNvbnN0Cj4gdm9pZCAqZGF0YSkKPiB7
Cj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuICEhKHZlci0+aW1wbF9pZCA9PSBURUVfSU1QTF9JRF9P
UFRFRSk7Cj4gwqDCoMKgwqDCoMKgIDA6wqDCoMKgwqDCoMKgIGU1OTAwMDAwwqDCoMKgwqDCoMKg
wqAgbGRywqDCoMKgwqAgcjAsIFtyMF0KPiB9Cj4gwqDCoMKgwqDCoMKgIDQ6wqDCoMKgwqDCoMKg
IGUyNDAwMDAxwqDCoMKgwqDCoMKgwqAgc3ViwqDCoMKgwqAgcjAsIHIwLCAjMQo+IMKgwqDCoMKg
wqDCoCA4OsKgwqDCoMKgwqDCoCBlMTZmMGYxMMKgwqDCoMKgwqDCoMKgIGNsesKgwqDCoMKgIHIw
LCByMAo+IMKgwqDCoMKgwqDCoCBjOsKgwqDCoMKgwqDCoCBlMWEwMDJhMMKgwqDCoMKgwqDCoMKg
IGxzcsKgwqDCoMKgIHIwLCByMCwgIzUKPiDCoMKgwqDCoMKgIDEwOsKgwqDCoMKgwqDCoCBlMTJm
ZmYxZcKgwqDCoMKgwqDCoMKgIGJ4wqDCoMKgwqDCoCBscgo+IAo+IEknbSBpbiBmYXZvciBvZiBr
ZWVwaW5nIHRoZSBjdXJyZW50IHZlcnNpb24uCgpJIGxpa2UgdGhlIHNob3J0IHZlcnNpb24gYmV0
dGVyLCBidXQgSSBhbSBhbHNvIG5vdCB2ZXJ5IGF0dGFjaGVkIHRvCmdldHRpbmcgdGhpcyBpbiBh
dCBhbGwsIEknbGwgbGV0IHRoZSBtYWludGFpbmVycyBkZWNpZGUuCgpUaGFua3MgYW5kIGJlc3Qg
cmVnYXJkcywKUm91dmVuCgoK

