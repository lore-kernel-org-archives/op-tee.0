Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A65CA0FF2
	for <op-tee@archiver.kernel.org>; Wed,  3 Sep 2025 14:36:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 47B6D4FC5A
	for <op-tee@archiver.kernel.org>; Wed,  3 Sep 2025 14:36:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zres8FKy;
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 65A4943039
	for <op-tee@lists.trustedfirmware.org>; Wed,  3 Sep 2025 14:35:47 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b042cc39551so501999466b.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 03 Sep 2025 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756910146; x=1757514946; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4shK9EBnP1XTLra0+voq+VDSiZ3w8vJk2bGPz8ooVso=;
        b=zres8FKyHSh31nst93E2GB9QTS6mkCFagjEwbq5tye6bMUnDtTmhytoNVjsGHq3RLF
         wwuSLF8KOeHxZ6EhS2RFOQjbOalQErpgw8LAYpbg++tIzLSo2b/dSATh1ycuh0kbpT01
         0jiSazZlGtN7RraGvev5M+iBIqrng8lUxOL6kE/XNf5EEkWAGl4jyEgUrjJFoO35vO++
         Yq+XCJXOD8y0KYi58kQ0ZuAEykCBVd6NHmonF8iGDP8sMaYVszTX4kZRrgIJRAn+YVIt
         um8jkfvF84XsbLVSnE/wt4wTYFJ/+QkgrpiYy6p5U7TWfG0vT7laCk2d1ExwAFSaL2Rv
         2UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910146; x=1757514946;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4shK9EBnP1XTLra0+voq+VDSiZ3w8vJk2bGPz8ooVso=;
        b=HQH6gKyzitgfmOr+4kVccIUs/yXcuBYVWYnND+Q26nTxEy0ocqJ7jfi6LyxPIJKSi+
         1n/YxorGWXe2nuF8EMlcfVA8CxOqTtbNyVdXTLDaOUiXE7m34TuXY5WKPhOCrVWiqdGZ
         kJyRGx2VU5dJLiyYu2BxPgmAtq4aYKjyfyJuI4omN7tPr6HPcnG8OyZ0YZNz18lj03yp
         U4v7zT35gqgLLRunFcR/ODFYL8qvcmCNW1QkmX4YU4/wEI8KjRHfdfjNgIlXsHqt54xR
         mzZ5VkWsPUF0IDI2N9supk8lyZ5Og8PVylsIsWW3kYr6Gkse2eLNJEUy3CdKvhNoXPgD
         MmFg==
X-Forwarded-Encrypted: i=1; AJvYcCVPFCtciIiyZBZ5PyXZ8NNvWOnTp09hXpccU4MRTnTiTmlZvuBa6PV/tSbgngi5VqW20axnlIE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx4WfCbD8x/yrhKn1PpVEVp2T5GPAV9y1HNwwrMpCjdLp7vV1e/
	U9eNSVOwFi3Xo4T/BNIO0fQKbyYTsWLww/jG7NvJuEfO1T5uMkMYb1n655CVLu5fd7fcAw==
X-Gm-Gg: ASbGnctsJI0xA2MoT/82paI2tMLz23akpVVlqnSzFm9zutFcEz8W+9o93WLFg8xu7l0
	CgpH+du0FAdsX0U9J/PtKLsq9YhS5pp5nNgBcRCNDtFm37p85LrEP39wHUw4MElISmvEyucCQHF
	ANBr5tTB9Nn71lg9hQu/24wDnWsUhAaTD+dkHH/ed+bO6AFliKlnpVVCoOfMR4YbJ7hehuvLaRL
	eLr3Pt1ppUtAyugjBjQzkyVyf7UG9GV16ldGfI8N3AyzMU0AvEhCZ2vREEQuTnDFWHBXf0aEiRz
	Xz3Vy4p2+ZfaSmZOGZhEyC7nGZx3rKIX7V2VGjrL6gs4TD3Su/XTk2paP3dnneaCM6ipdehn5lA
	YeiEyNlfcGyWa7iuuPPQ+A6GFvPtFIo91gHGensSbrd7h8ag23Ka6ReVm2QYwn3lAwnRiXXD9Nl
	o=
X-Google-Smtp-Source: AGHT+IFBTJJv/7sjdaQXVSAdJ4KduD6LWhTJFbzo19k/hpnMgGB0FeNaA69nzxx1+gq4eyHGDxdWRA==
X-Received: by 2002:a17:907:7f14:b0:b04:7107:9758 with SMTP id a640c23a62f3a-b047107c8famr141417266b.43.1756910146042;
        Wed, 03 Sep 2025 07:35:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:32e2:48f6:bf2:9a98? ([2a01:e0a:3cb:7bb0:32e2:48f6:bf2:9a98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff138a8d76sm1188241066b.104.2025.09.03.07.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:35:45 -0700 (PDT)
Message-ID: <6879f437-5a5c-4c24-942d-09220d801784@linaro.org>
Date: Wed, 3 Sep 2025 16:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] sd: Add RPMB emulation to eMMC model
To: Jan Kiszka <jan.kiszka@siemens.com>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 65A4943039
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.46:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[209.85.218.46:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: QWRLT4L2CLZMFV22PSAL4OJGXGFLMTKF
X-Message-ID-Hash: QWRLT4L2CLZMFV22PSAL4OJGXGFLMTKF
X-MailFrom: jerome.forissier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QWRLT4L2CLZMFV22PSAL4OJGXGFLMTKF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgSmFuLA0KDQpPbiA4LzI0LzI1IDA5OjQxLCBKYW4gS2lzemthIHZpYSBPUC1URUUgd3JvdGU6
DQo+IEZZSTogUUVNVSBtb2RlbCBpcyB3b3JraW5nIGZpbmUsIHVwc3RyZWFtaW5nIHN0YXJ0ZWQs
IGZlZWRiYWNrIHdlbGNvbWUuDQoNClRoaXMgaXMgYXdlc29tZS4gSSBwdWxsZWQgdGhlIHZhcmlv
dXMgYml0cyAoUUVNVSB2MTAuMS4wICsgeW91ciBwYXRjaGVzLA0KVS1Cb290IG5leHQsIEJ1aWxk
cm9vdCAyMDI1LjEwLXJjMyB3aXRoIG1tYy11dGlscyB2MS4wKSBhbmQgd2FzIGFibGUgdG8NCnJ1
biB0aGUgT1AtVEVFIE9TIHRlc3RzIHN1Y2Nlc3NmdWxseSAoIm1ha2UgY2hlY2siKSwgdXNpbmcg
dGhlIGluLWtlcm5lbA0KUlBNQiByb3V0aW5nLiBUQkggdGhlcmUgaXMgb25lIGZhaWx1cmUgd2l0
aCB0aGUgVFBNIHRlc3QgKHh0ZXN0DQpyZWdyZXNzaW9uXzEwNDEpIHdoaWNoIEkgd2lsbCBuZWVk
IHRvIGZpZ3VyZSBvdXQgaW4gZHVlIHRpbWUgYnV0IEkgYW0NCmFscmVhZHkgdmVyeSBoYXBweSB3
aXRoIHRoZSBzaXR1YXRpb24uIEFzIHNvb24gYXMgZXZlcnl0aGluZyBpcyB1cHN0cmVhbQ0KSSds
bCB1cGRhdGUgdGhlIE9QLVRFRSBkZXYgZW52aXJvbm1lbnQgYW5kIGFkZCBhIGpvYiB0byB0aGUg
b3B0ZWVfb3MgQ0kuDQoNCk1hbnkgdGhhbmtzIGZvciB5b3VyIHdvcmsgYW5kIGZvciBzaGFyaW5n
IGl0IQ0KDQotLSANCkplcm9tZSANCg0KPiANCj4gSmFuDQo+IA0KPiBPbiAyNC4wOC4yNSAwOTox
OCwgSmFuIEtpc3prYSB3cm90ZToNCj4+IFRoaXMgY2xvc2VzIGFuIG9sZCBnYXAgaW4gc3lzdGVt
IGludGVncmF0aW9uIHRlc3RpbmcgZm9yIHRoZSB2ZXJ5DQo+PiBjb21wbGV4IEFSTSBmaXJtd2Fy
ZSBzdGFja3MgYnkgYWRkaW5nIGZhaXJseSBhZHZhbmNlZCBSZXBsYXkgUHJvdGVjdGVkDQo+PiBN
ZW1vcnkgQmxvY2sgKFJQTUIpIGVtdWxhdGlvbiB0byB0aGUgZU1NQyBkZXZpY2UgbW9kZWwuIEtl
eSBwcm9ncmFtbWluZw0KPj4gYW5kIG1lc3NhZ2UgYXV0aGVudGljYXRpb24gYXJlIHdvcmtpbmcs
IHNvIGlzIHRoZSB3cml0ZSBjb3VudGVyLiBLbm93bg0KPj4gdXNlcnMgYXJlIGhhcHB5IHdpdGgg
dGhlIHJlc3VsdC4gV2hhdCBpcyBtaXNzaW5nLCBidXQgbm90IG9ubHkgZm9yIFJQTUItDQo+PiBy
ZWxhdGVkIHJlZ2lzdGVycywgaXMgc3RhdGUgcGVyc2lzdGVuY2UgYWNyb3NzIFFFTVUgcmVzdGFy
dHMuIFRoaXMgaXMgT0sNCj4+IGF0IHRoaXMgc3RhZ2UgZm9yIG1vc3QgdGVzdCBzY2VuYXJpb3Ms
IHRob3VnaCwgYW5kIGNvdWxkIHN0aWxsIGJlIGFkZGVkDQo+PiBsYXRlciBvbi4NCj4+DQo+PiBX
aGF0IGNhbiBhbHJlYWR5IGJlIGRvbmUgd2l0aCBpdCBpcyBkZW1vbnN0cmF0ZWQgaW4gdGhlIFdJ
UCBicmFuY2ggb2YNCj4+IGlzYXItY2lwLWNvcmUgYXQgWzFdOiBURi1BICsgT1AtVEVFICsgU3Rh
bmRhbG9uZU1NIFRBICsgZlRQTSBUQSwgdXNlZCBieQ0KPj4gVS1Cb290IGFuZCBMaW51eCBmb3Ig
VUVGSSB2YXJpYWJsZSBzdG9yYWdlIGFuZCBUUE0gc2NlbmFyaW9zLiBJZiB5b3UNCj4+IHdhbnQg
dG8gdHJ5OiBidWlsZCBxZW11LWFybTY0IHRhcmdldCBmb3IgdHJpeGllIHdpdGggNi4xMi1jaXAg
KmhlYWQqDQo+PiBrZXJuZWwsIGVuYWJsZSBzZWN1cmUgYm9vdCBhbmQgZGlzayBlbmNyeXB0aW9u
LCB0aGVuIHJ1bg0KPj4NCj4+ICQgUUVNVV9QQVRIPS9wYXRoL3RvL3FlbXUtYnVpbGQvIC4vc3Rh
cnQtcWVtdS5zaA0KPj4NCj4+IERlcGxveSBzbmFrZW9pbCBrZXlzIGludG8gUEssIEtFSyBhbmQg
ZGIgYWZ0ZXIgZmlyc3QgYm9vdCB0byBlbmFibGUNCj4+IHNlY3VyZSBib290aW5nOg0KPj4NCj4+
IHJvb3RAZGVtbzp+IyBjZXJ0LXRvLWVmaS1zaWctbGlzdCBQa0tlay0xLXNuYWtlb2lsLnBlbSBQ
Sy5lc2wNCj4+IHJvb3RAZGVtbzp+IyBzaWduLWVmaS1zaWctbGlzdCAtayBQa0tlay0xLXNuYWtl
b2lsLmtleSAtYyBQa0tlay0xLXNuYWtlb2lsLnBlbSBQSyBQSy5lc2wgUEsuYXV0aA0KPj4gcm9v
dEBkZW1vOn4jIGVmaS11cGRhdGV2YXIgLWYgUEsuYXV0aCBkYg0KPj4gcm9vdEBkZW1vOn4jIGVm
aS11cGRhdGV2YXIgLWYgUEsuYXV0aCBLRUsNCj4+IHJvb3RAZGVtbzp+IyBlZmktdXBkYXRldmFy
IC1mIFBLLmF1dGggUEsNCj4+DQo+PiBOb3RlIHRoYXQgZW11bGF0aW9uIGlzIGEgYml0IHNsb3cg
aW4gZ2VuZXJhbCwgYW5kIHNwZWNpZmljYWxseSB0aGUNCj4+IHBhcnRpdGlvbiBlbmNyeXB0aW9u
IG9uIGZpcnN0IGJvb3QgaXMgdGFraW5nIDIwIG1pbi4gLSB3ZSBzaG91bGQNCj4+IHByb2JhYmx5
IHJlZHVjZSBpdHMgc2l6ZSBvciB1bmRlcnN0YW5kIGlmIHRoZXJlIGlzIHN0aWxsIHNvbWV0aGlu
ZyB0bw0KPj4gb3B0aW1pemUuDQo+Pg0KPj4gSmFuDQo+Pg0KPj4gWzFdIGh0dHBzOi8vZ2l0bGFi
LmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vY29tbWl0cy93aXAvcWVt
dS1ycG1iDQo+Pg0KPj4gQ2M6ICJEYW5pZWwgUC4gQmVycmFuZ8OpIiA8YmVycmFuZ2VAcmVkaGF0
LmNvbT4NCj4+DQo+PiBKYW4gS2lzemthICg4KToNCj4+ICAgaHcvc2Qvc2RjYXJkOiBGaXggc2l6
ZSBjaGVjayBmb3IgYmFja2luZyBibG9jayBpbWFnZQ0KPj4gICBody9zZC9zZGNhcmQ6IEFkZCB2
YWxpZGF0aW9uIGZvciBib290LXBhcnRpdGlvbi1zaXplDQo+PiAgIGh3L3NkL3NkY2FyZDogQWxs
b3cgdXNlci1pbnN0YW50aWF0ZWQgZU1NQw0KPj4gICBody9zZC9zZGNhcmQ6IFJlZmFjdG9yIHNk
X2Jvb3RwYXJ0X29mZnNldA0KPj4gICBody9zZC9zZGNhcmQ6IEFkZCBiYXNpYyBzdXBwb3J0IGZv
ciBSUE1CIHBhcnRpdGlvbg0KPj4gICBjcnlwdG8vaG1hYzogQWxsb3cgdG8gYnVpbGQgaG1hYyBv
dmVyIG11bHRpcGxlDQo+PiAgICAgcWNyeXB0b19nbnV0bHNfaG1hY19ieXRlc1t2XSBjYWxscw0K
Pj4gICBody9zZC9zZGNhcmQ6IEhhbmRsZSBSUE1CIE1BQyBmaWVsZA0KPj4gICBzY3JpcHRzOiBB
ZGQgaGVscGVyIHNjcmlwdCB0byBnZW5lcmF0ZSBlTU1DIGJsb2NrIGRldmljZSBpbWFnZXMNCj4+
DQo+PiAgY3J5cHRvL2htYWMtZ2NyeXB0LmMgICB8ICAgNCArLQ0KPj4gIGNyeXB0by9obWFjLWds
aWIuYyAgICAgfCAgIDQgKy0NCj4+ICBjcnlwdG8vaG1hYy1nbnV0bHMuYyAgIHwgICA0ICstDQo+
PiAgY3J5cHRvL2htYWMtbmV0dGxlLmMgICB8ICAgNCArLQ0KPj4gIGh3L3NkL3NkLmMgICAgICAg
ICAgICAgfCAzMTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4+
ICBody9zZC9zZG1tYy1pbnRlcm5hbC5oIHwgIDI0ICsrKy0NCj4+ICBody9zZC90cmFjZS1ldmVu
dHMgICAgIHwgICAyICsNCj4+ICBpbmNsdWRlL2NyeXB0by9obWFjLmggIHwgIDEyICsrDQo+PiAg
c2NyaXB0cy9ta2VtbWMuc2ggICAgICB8IDE4NSArKysrKysrKysrKysrKysrKysrKysrKysNCj4+
ICA5IGZpbGVzIGNoYW5nZWQsIDUzMCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4+
ICBjcmVhdGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9ta2VtbWMuc2gNCj4+DQo+IA0K
