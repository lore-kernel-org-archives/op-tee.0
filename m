Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1622CD4F2C
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 08:42:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D1CD344E07
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 08:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781253729;
	bh=kVonTVnrPXhyLN2X9k9vGzJ0Da3SgfHio/hahPcmDkQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=p+rLW7hhgHwypvuIELtub6yCLfu600NSylXYjgIgkjKqOuTFoEOW+AYNHmtKU1NWJ
	 cevCGOjqsWtilIUQCP6UMMygJLuMsPlmA50JlgvZgDCi3419LRMwdsTesZsH4rzNlm
	 FlQDg9JvQr3XF2jEOBN7r094LEku8BJOZE19erbNbfWYqPBRQc3aFLKpzshVUs7wHT
	 q4o3fz4CYT5KRW5+3/JBUOk2z9v6BrExHl6fwe3I+mcKgNfYTydBCowerbCOkb3Xd0
	 YAKS0qnvUJUIbRLNNXX3imRmePeUs8Pqm4+ii7KjvKQ3HllK0u2pkKNlc2zN+Kko8U
	 MbKBEyATZDsHQ==
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6BFFD43837
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 08:42:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=q6NdTEDL;
	dkim-atps=neutral
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b23c828aso34735e9.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781253721; x=1781858521; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h8kiyJfpS4AJieM5GN1HD0Jnn9d/pspH0taYDU8KwA8=;
        b=q6NdTEDLWltouAqRCsyBvqoVbsgKrPDNKdKI7H8Rri4MPeJCgMGAeoIAJqdesaX/5L
         q+2N2tBtlQwWPRh2ah+Q9d1y528S3XzpJuL4n8aI9ZCQr/Ck2H1xWASdsb7AJcVADpm3
         dwGjduKkP2Ipz2nwudPpHdRuFDQw5jx+GOO2b/KGx45hls3K/lrrjrHpHZgIKiOfFFfU
         MUzHYRcnnteOks7e+MYY51vjVxbSvBazl9t8nEs0RqCH9vRSHJly2tNNPcmBfpCl2Xbb
         6aNWNXx2SS9KJutehq/HO09dPKucVTPipy1EujYC9e0MTGjy2AwwS6c2Efzt3EIrL49t
         om0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781253721; x=1781858521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8kiyJfpS4AJieM5GN1HD0Jnn9d/pspH0taYDU8KwA8=;
        b=V85ZZHO8xIMax45fm22tNz7NX0jr/lZRaPdWSmsRSm47QzIgX3xs4x5VRPkYY4HoKy
         ACErGXbisVm4Ka6DCwSjdaphLummdAoeqOnnriVm9qSQ5b0kJPqgKDQyj2ddUbvImYnT
         tkyo0AhIwU5r9P1KQh07Q0opl+WxiR6cqAJ28kNJ7RwiF2v0lox2HxkoryCBZgqKfnds
         M8tsU9v2hzELKKp7/blq1g3yRf7ZBdWCRQPQ+HQHtNeOEdypLUDir+tgt9FjulyyuUnH
         L+UR6ue22vkMCV+kfGakFodRTY1wtsFz9+PxN1pr+r4Nm+1apyRmSZoAdGWP2T0QvpUM
         ok1g==
X-Forwarded-Encrypted: i=1; AFNElJ82iNgX9iJTYeR8YRRgulba/EBO5ioc0j7y7k8nCPPCbgUWFc71CXur3rN3Ciuzobj/qtrd30A=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzkRj+JPc9sqwYqce3X0SY1HPSynHTg6mS9CW5HfO1/ZuU3ZkgA
	WioKWCA0EyQc5k4i1mXu8Iva2l74xdKV5OlgVXjrKpl2ZbuXsO+YSsOcK2QCYAKB3A==
X-Gm-Gg: Acq92OH0DELMzoUhgOqWqNKkbEDVuJ2w9FbCL8B4bY5PhgXUqCHeCLXDqr5PVRlSGv0
	3u7dEgzYwhA71s18FvEBlPz8XCfdW+EigYIEBThmaJ7CfCS/g8R9Cgz+Fy+vKv0/geTtrn72xSC
	3cdhW3uKIoN9DD4KcKwh2gqF3iFM13o8LVMPsw/o9ON5vcUjkys/7dyVo3AK7Qnwn0grxtu44Q7
	r2A5lg75zv4zPrFlLmt14DrFOT3h00WOZFcAJ/fUFja5n8sTER9Jp9+El5ze840LGO8buc9OXQt
	Tp107ck+RS3RldLA/Z4T5ClYu7aPG0sDfiHs+z5qYsJssEJ0cUPxCA/0fkwyUSnOZCGySRRMYl9
	1BNkPEbTV6rl4AC3tTYLLkocCftuLYpC/lvrh4qgW2Rt8wSTh/hI9SZGMp6fhXLHTdZQOfyVJxI
	a/3XLbEVXMp8AHQO3UKN04d0AdOoJDndRKBhkQjOkZR5lUTXzLaUWiLNthdIOgkfT2NvdiDRG/
X-Received: by 2002:a05:600d:4452:20b0:490:b2ae:44e1 with SMTP id 5b1f17b1804b1-490eabf94bcmr544755e9.5.1781253721001;
        Fri, 12 Jun 2026 01:42:01 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2cf5537sm158942595e9.9.2026.06.12.01.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:42:00 -0700 (PDT)
Date: Fri, 12 Jun 2026 08:41:55 +0000
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v5 1/6] optee: ffa: Add NULL check in
 optee_ffa_lend_protmem
Message-ID: <aivGUzU-xxiR-egQ@google.com>
References: <20260526151934.3783707-1-smostafa@google.com>
 <20260526151934.3783707-2-smostafa@google.com>
 <aiK6lgW5YFWSMTxf@google.com>
 <CAHUa44FO02DKqqNeFuRfx8bQjwcNRfPMF2=8MdjMUFp6vYUpNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44FO02DKqqNeFuRfx8bQjwcNRfPMF2=8MdjMUFp6vYUpNw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.45:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.45:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6BFFD43837
X-Spamd-Bar: ---
Message-ID-Hash: TRU2WAPZSW3ETNQZQBNWU3UNRRCDKDHU
X-Message-ID-Hash: TRU2WAPZSW3ETNQZQBNWU3UNRRCDKDHU
X-MailFrom: smostafa@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sebastian Ene <sebastianene@google.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TRU2WAPZSW3ETNQZQBNWU3UNRRCDKDHU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

T24gTW9uLCBKdW4gMDgsIDIwMjYgYXQgMDM6MTY6NDlQTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IE9uIEZyaSwgSnVuIDUsIDIwMjYgYXQgMjowMeKAr1BNIFNlYmFzdGlhbiBFbmUg
PHNlYmFzdGlhbmVuZUBnb29nbGUuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgTWF5IDI2
LCAyMDI2IGF0IDAzOjE5OjI5UE0gKzAwMDAsIE1vc3RhZmEgU2FsZWggd3JvdGU6DQo+ID4gPiBT
YXNoaWtvIChsb2NhbGx5KSByZXBvcnRzIGEgcG9zc2libGUgbnVsbCBkZXJlZmVyZW5jZSB1bmRl
ciBtZW1vcnkNCj4gPiA+IHByZXNzdXJlIGR1ZSB0byB0aGUgbGFjayBvZiB2YWxpZGF0aW9uIG9m
IHRoZSBhbGxvY2F0ZWQgcG9pbnRlci4NCj4gPiA+DQo+ID4gPiBGaXggdGhhdCBieSBhZGRpbmcg
dGhlIG1pc3NpbmcgY2hlY2suDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTW9zdGFmYSBT
YWxlaCA8c21vc3RhZmFAZ29vZ2xlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvdGVl
L29wdGVlL2ZmYV9hYmkuYyB8IDMgKysrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RlZS9vcHRlZS9mZmFf
YWJpLmMgYi9kcml2ZXJzL3RlZS9vcHRlZS9mZmFfYWJpLmMNCj4gPiA+IGluZGV4IGI0MzcyZmEy
NjhkMC4uNjMzNzE1Yjk4NjI1IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy90ZWUvb3B0ZWUv
ZmZhX2FiaS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3RlZS9vcHRlZS9mZmFfYWJpLmMNCj4gPiA+
IEBAIC02OTgsNiArNjk4LDkgQEAgc3RhdGljIGludCBvcHRlZV9mZmFfbGVuZF9wcm90bWVtKHN0
cnVjdCBvcHRlZSAqb3B0ZWUsIHN0cnVjdCB0ZWVfc2htICpwcm90bWVtLA0KPiA+ID4gICAgICAg
aW50IHJjOw0KPiA+ID4NCj4gPiA+ICAgICAgIG1lbV9hdHRyID0ga3phbGxvY19vYmpzKCptZW1f
YXR0ciwgbWFfY291bnQpOw0KPiA+ID4gKyAgICAgaWYgKCFtZW1fYXR0cikNCj4gPiA+ICsgICAg
ICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gPiArDQo+ID4gPiAgICAgICBmb3IgKG4gPSAw
OyBuIDwgbWFfY291bnQ7IG4rKykgew0KPiA+ID4gICAgICAgICAgICAgICBtZW1fYXR0cltuXS5y
ZWNlaXZlciA9IG1lbV9hdHRyc1tuXSAmIFUxNl9NQVg7DQo+ID4gPiAgICAgICAgICAgICAgIG1l
bV9hdHRyW25dLmF0dHJzID0gbWVtX2F0dHJzW25dID4+IDE2Ow0KPiA+ID4gLS0NCj4gPiA+IDIu
NTQuMC43NDYuZzY3ZGQ0OTFhYWUtZ29vZw0KPiA+ID4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgZml4
aW5nIHRoaXMgYW5kIGZvciBpbmNsdWRpbmcgbXkgb3RoZXIgcGF0Y2hlcyBpbiB0aGUgc2VyaWVz
DQo+ID4gUmV2aWV3ZWQtYnk6IFNlYmFzdGlhbiBFbmUgPHNlYmFzdGlhbmVuZUBnb29nbGUuY29t
Pg0KPiANCj4gUGxlYXNlIGFkZCBhIEZpeGVzOiB0YWcuIFRoaXMgcGF0Y2ggaXMgaW5kZXBlbmRl
bnQgb2YgdGhlIG90aGVycyBpbg0KPiB0aGUgcGF0Y2ggc2V0LCBzbyBpZiB5b3Ugc2VuZCBpdCBh
bG9uZSB3aXRoIHRoZSBGaXhlczogdGFnIEknbGwgcGljaw0KPiBpdCB1cC4NCg0KSSBwb3N0ZWQg
YSB2NiBmb3IgdGhpcyBwYXRjaCB3aXRoIHRoZSBGaXhlcyB0YWcgWzFdDQoNClsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MjcxNTAyMzYuMTk3ODY1NS0yLXNtb3N0YWZhQGdv
b2dsZS5jb20vDQoNClRoYW5rcywNCk1vc3RhZmENCg0KPiANCj4gQ2hlZXJzLA0KPiBKZW5zDQo=
