Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E90CA0EDC
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 09:33:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6E1C0459F9
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 09:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755164036;
	bh=E277F3EVsaI5cup694VzoG1/jp7hxBv/bdiAgeIXKpw=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Atbz89RvaDdtup5l1UEAuGWzWwIknFxk9hb4NIJbR3dfHvuevJxTauSLUC+k+WRUM
	 6EkEejpVGc6Szi5pT07ZCzRxD5OeDqEpvVOLZXLKAr5zZPtX/bFHzlGrDCRQgFM7XN
	 yuHO7a/taJKEliIiRQyNnL5z2IfVSP+r5A65rlH7Y0wNyZuyzZuI8b7Q7hXNBJnpHt
	 HF+NfG3ZmYgxLDA5Dghu4zrVbQIqmS52Tq/UwJunQ4nbdSJkBQIPpffXo4PAyVaI7a
	 TX73EwnfNwumtQKjeYsOnICCGMzQV/AUWk0Ik5GkBHBChbR3dGobAZ0tcCttL43vP7
	 7LVgkO2l6AMAg==
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4FE2D42E3D
	for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 07:25:31 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=payter.nl header.i=@payter.nl header.a=rsa-sha256 header.s=google header.b=LHjhXxsG;
	dkim-atps=neutral
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-333f91526bcso4461651fa.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=payter.nl; s=google; t=1755156330; x=1755761130; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4QoXh+40Fi6X+cC58zvHljFFZqHzILb623Tf1FSKoh0=;
        b=LHjhXxsGTONarj2Vz/cvtVvXIlgHzKnUTpHq4g7b4nyPFADNRgSBmRf4BHWs0h4N09
         vrQfm/hqyuRH3MngQMTJ8wT9WUlGD2Rt78Pz+fBvDkUKSBtacTp+SgtK415q8GOBeXXb
         PjgSGKI+ZMINN9bFmdQTY9mYOe1GF4TGOCxUDboYsSBFGXRu0U2l+07VRrFrKYjbSAFc
         bJiwa8U0RFcIbTZcOqwq3BKejeWh3IsYUIsdeR8Wr/Q596GRziaq2qV3eSZ9kPaoQN1+
         ZLiEgA9IaA+x/Ofrvs0RKsIJRQOM3PsGrxMvfAt+mFdMmKIAYTVCxNP3k4DJwCOL97OW
         wm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156330; x=1755761130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QoXh+40Fi6X+cC58zvHljFFZqHzILb623Tf1FSKoh0=;
        b=gCBATdje+66tSYTDDJ82rZ7/TeIThZDb4wAAxrC/b6UPNLoEEE3cl7VnF+OlfvK/lt
         1DlgIhLqUZUEnEH1GWhoRkpKI1JFfrIE8nbugrRt1Er9XbKORRYH0/45z9FgSJpIX6gU
         K1P2Iw0Lr4G4SVTCKKzkkhXr4scfKsVvPp5aNKERynVnPbbUaBLkGPeHvjaLv4+j/dZv
         Dr57tgakQY9MFlj+N1eulpncTpn+FF5CcBpnqWUN+9t5GYMaJ9tSeZx5mvPpBCguBGZN
         cua6DnIaJck6HBUSXyubY40wcfSDTPCL+wd/jVYoVdVH/ZYD62LfpHXfiy5XNn7Y6JUZ
         SYzw==
X-Gm-Message-State: AOJu0Yx/WWz0RtUzbdpZpK6HO4xgL+F9zBQyN2V/ZKtPE4eTxd3ShCNQ
	X632Y7D62TO4fp5UfJTj/xPQ5tmkWoMqbkTMm0d1+BIDXqiLo0GFbCGdmaE2w2J/DCWkMoJUh1P
	5nCIlN5bWCKxWOMKMitPsIVmiworVb+Q8hiSit0/8Yldam6kHqdgDlY93uEWsQkK5+gv2uxqM6n
	jQ1AxNWkS9O6cYHmkjb5gdIMslSHtFPikXUquiKH8=
X-Gm-Gg: ASbGncuMm6pL3BvyIOZQM1mXWNEaD1jwSBa4uzOieV0ZF6tw+jUZjzs0wZk4XyGawNK
	VcZwLBTXtfbZE/aolpffLHGC7Tv+RndYCsgXYxF5fAUkuBKK6Zc1KhtZPLbLrQHSZ+ipSH1ZFKR
	HYurBGAIABNHHVVfgjUJPjRf0E/4szgtpHctfl+gAUsvxtbYE1yHcqw1k2tpO2WIIpu6kS0lKac
	ZsocQU=
X-Google-Smtp-Source: AGHT+IHl5DfGYbfXE0gJ+dJ7cIgP20OQRH4qn/mvvMpZab5+oX+k7aaz5UCqcQr5u4PbAEZ3qIprcUxqp7TdIok89EU=
X-Received: by 2002:a2e:a550:0:b0:32b:5272:38eb with SMTP id
 38308e7fff4ca-333fa9277eemr5496291fa.40.1755156329896; Thu, 14 Aug 2025
 00:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEhEOQn9TYvdUnf39UOOenydg1Xh1SZYbKrbbprnf5nnXeCBtw@mail.gmail.com>
 <CAHUa44E=8GGVr6CdQT5pDR=HmjVJPqzdnNz93i+k1a-=2B51vw@mail.gmail.com>
In-Reply-To: <CAHUa44E=8GGVr6CdQT5pDR=HmjVJPqzdnNz93i+k1a-=2B51vw@mail.gmail.com>
Date: Thu, 14 Aug 2025 09:25:19 +0200
X-Gm-Features: Ac12FXzKnlWMj9J-0mpVCwT46wUop-HB0SBtahttdDZyYDN4_TT6077OQ-gIvaI
Message-ID: <CAEhEOQ=8btZ1Bgrj1Lh3+4zqgDSE4XNG7TMWwvErHrurhTGMqw@mail.gmail.com>
Subject: Re: BEE support and TA_RAM usage in Op-Tee 3.10.0
To: Jens Wiklander <jens.wiklander@linaro.org>
X-Rspamd-Queue-Id: 4FE2D42E3D
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[payter.nl,reject];
	R_DKIM_ALLOW(-0.20)[payter.nl:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	DNSWL_BLOCKED(0.00)[209.85.208.179:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.179:from];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[payter.nl:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: r.delien@payter.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: R7H2HM2RK3UBDZ7UR2LUFTB33ERKXZGT
X-Message-ID-Hash: R7H2HM2RK3UBDZ7UR2LUFTB33ERKXZGT
X-Mailman-Approved-At: Thu, 14 Aug 2025 09:33:44 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/R7H2HM2RK3UBDZ7UR2LUFTB33ERKXZGT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Robert Delien via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Robert Delien <r.delien@payter.nl>

SGkgSmVucywNCg0KVGhhbmsgeW91IGZvciB5b3VyIHByb21wdCByZXNwb25zZS4NCg0KPiBZZXMu
IEhvd2V2ZXIsIG9uIHRoZSBsYXRlc3QgcmVsZWFzZXMsIHdlJ3ZlIHN0YXJ0ZWQgdG8gbWVyZ2Ug
dGhlDQo+IHBoeXNpY2FsIG1lbW9yeSBhcmVhcyByZXNlcnZlZCBmb3IgT1AtVEVFIGNvcmUgYW5k
IFRBcy4gU28gdGhlcmUncyBhDQo+IHJpc2sgdGhhdCB0aGluZ3MgbWF5IGJlY29tZSBhIGJpdCBt
b3JlIGNvbXBsaWNhdGVkIGluIHVwc3RyZWFtLg0KDQpUaGFua3MgZm9yIHRoZSBoZWFkcy11cDsg
V2Ugd2lsbCBjcm9zcyB0aGF0IGJyaWRnZSB3aGVuIHdlIGdldCB0aGVyZS4NClVwZGF0aW5nIE9w
LVRlZSB0byBhIG1vcmUgcmVjZW50IHZlcnNpb24gaXMgb24gbXkgbGlzdCB0b28sIGJ1dCBpcyBm
dXJ0aGVyDQpkb3duIGR1ZSB0byBvdXIgbGFyZ2UgbnVtYmVyIG9mIHByb3ByaWV0YXJ5IGRyaXZl
cnMsIGJ1dCBhbHNvIHRvIGhvdyBnb29kDQp2ZXJzaW9uIDMuMTAgaXMuDQoNCkluIG15IGN1cnJl
bnQgdGVzdCBzZXR1cCwgSSBoYXZlIHRoZSBCRUUgY29uZmlndXJlZCBpbiBVLUJvb3QgdG8gdXNl
IG1lbW9yeQ0KYXQgdGhlIG9yaWdpbmFsIFRBX1JBTV9TVEFSVCAoQDB4OGUxMDAwMDApIGFuZCBt
YWtlIGl0IGF2YWlsYWJsZQ0KdW5lbmNyeXB0ZWRseSBhdCAweDEwMDAwMDAwLiBJIGhhdmUgdGVz
dGVkIGl0IGluIFUtQm9vdCBhbmQgaXQgc2VlbXMgdG8NCndvcmsgcHJvcGVybHkuDQoNCkluIE9w
LVRlZSdzIGdlbmVyaWNfcmFtX2xheW91dC5oLCBJIGJhc2ljYWxseSByZW5hbWVkIFRBX1JBTV9T
VEFSVCB0bw0KVEFfUkFNX1NUQVJUKl9CRUUqLCBhbmQgdXNlZCBUQV9SQU1fU1RBUlQqX0JFRSog
aW4gdGhlIG1hY3JvIGNhbGN1bGF0aW5nDQpUQV9SQU1fU0laRS4gVEFfUkFNX1NUQVJUIGl0c2Vs
ZiBoYXMgYmVlbiBoYXJkLWNvZGVkIHRvIDB4MTAwMDAwMDAuIChUaGlzDQppcyBqdXN0IGEgdGVz
dCwgSSB3aWxsIHVzZSB0aGUgRGV2aWNlIFRyZWUgbGF0ZXIpLg0KDQpCZWZvcmU6DQpEL1RDOjAg
ICBhZGRfcGh5c19tZW06NTk3IFRBX1JBTV9TVEFSVCB0eXBlIFRBX1JBTSAqMHg4ZTEwMDAwMCog
c2l6ZQ0KMHgwMTkwMDAwMA0KRC9UQzowICAgZHVtcF9tbWFwX3RhYmxlOjc0NCB0eXBlIFRBX1JB
TSAgICAgICB2YSAweDg5MjAwMDAwLi4weDhhYWZmZmZmIHBhDQoqMHg4ZTEwMDAwMCouLjB4OGY5
ZmZmZmYgc2l6ZSAweDAxOTAwMDAwIChwZ2RpcikNCkQvVEM6MCAwIGNhcnZlX291dF9waHlzX21l
bToyOTcgTm8gbmVlZCB0byBjYXJ2ZSBvdXQgKjB4OGUxMDAwMDAqIHNpemUNCjB4MTkwMDAwMA0K
DQpBZnRlcjoNCkQvVEM6MCAgIGFkZF9waHlzX21lbTo1OTggVEFfUkFNX1NUQVJUIHR5cGUgVEFf
UkFNICoweDEwMDAwMDAwKiBzaXplDQoweDAxOTAwMDAwDQpEL1RDOjAgICBkdW1wX21tYXBfdGFi
bGU6NzQ1IHR5cGUgVEFfUkFNICAgICAgIHZhIDB4ODkyMDAwMDAuLjB4OGFhZmZmZmYgcGENCiow
eDEwMDAwMDAwKi4uMHgxMThmZmZmZiBzaXplIDB4MDE5MDAwMDAgKHBnZGlyKQ0KRC9UQzowIDAg
Y2FydmVfb3V0X3BoeXNfbWVtOjI5OCBObyBuZWVkIHRvIGNhcnZlIG91dCAqMHgxMDAwMDAwMCog
c2l6ZQ0KMHgxOTAwMDAwDQoNCihUaGUgb3JkZXIgaW4gbG9nZ2luZyBiZXR3ZWVuIGRpZmZlcmVu
dCBhcmVhcyBkaWZmZXJzIGJldHdlZW4gYmVmb3JlIGFuZA0KYWZ0ZXIsIGJ1dCBJJ3ZlIGJlZW4g
YXNzdW1pbmcgdGhhdCBkb2VzIG5vdCBtYWtlIGEgZGlmZmVyZW5jZS4pDQoNCkF0IGZpcnN0IGds
YW5jZSBpdCBzZWVtcyB0byB3b3JrLCBidXQgVEFzIGFyZSBwcm9kdWNpbmcgZXJyb3JzIHdpdGgN
CmFueXRoaW5nIHRoZXkgZG8uIEkgcmVhbGl6ZSBUQV9SQU1fU1RBUlQgd2FzIHByb2JhYmx5IG5l
dmVyIGludGVuZGVkIHRvIGJlDQp1c2VkIHRoaXMgd2F5LCBidXQgSSBhbHNvIG1pZ2h0IGJlIGZv
cmdldHRpbmcgc29tZXRoaW5nIG9idmlvdXMuDQoNCkkgaGF2ZSBpbnN0cnVtZW50ZWQgbW9ial9w
aHlzX2FsbG9jKCkgd2l0aCBkZWJ1ZyBwcmludHMgcHJpbnRpbmcgcGh5c2ljYWwNCmFkZHJlc3Nl
cywgd2hlbiBsb2FkaW5nIFRBcywgYnV0IG5vdGhpbmcgZ2V0cyBwcmludGVkIGZvciBiYXR0ciA9
PQ0KQ09SRV9NRU1fVEFfUkFNLiBEbyB5b3UgaGF2ZSBhIHN1Z2dlc3Rpbmcgd2hlcmUgYmV0dGVy
IHRvIHByaW50IFRBX1JBTQ0KYmVpbmcgYWxsb2NhdGVkPw0KDQo+IFdoZXJlIGRvIHlvdSBzZXQg
dGhlc2UgYWNjZXNzIHByaXZpbGVnZXM/DQoNClRoZSBCRUUgcGVyaXBoZXJhbCBoYXMgYSBiaXRm
aWVsZCB0byBzZXQgYWNjZXNzIHByaXZpbGVnZXMgZm9yIGl0cyAyDQphbGlhc2luZyBhcmVhcy4g
SSBleHBlY3QgdGhlIHVuZGVybHlpbmcgUkFNIGlzIHN0aWxsIGNvdmVyZWQgYnkgdGhlIFRaDQpj
b250cm9sbGVyLCBidXQgbWFraW5nIHN1cmUgb2YgdGhhdCBpcyBzdGlsbCBvbiBteSBsaXN0Lg0K
DQo+IFNvdW5kcyBpbnRlcmVzdGluZy4NCg0KSSBtYXkgYmUgYWJsZSB0byBjb252aW5jZSBwZW9w
bGUgaGVyZSB0byBwdXNoIHRoaXMgZHJpdmVyIHVwc3RyZWFtIGlmIHdlDQpnZXQgaXQgdG8gd29y
ay4NCg0KQW55IHN1Z2dlc3Rpb25zIHlvdSBtYXkgaGF2ZSB3aWxsIGJlIGhpZ2hseSBhcHByZWNp
YXRlZC4NCg0KV2l0aCBraW5kIHJlZ2FyZHMsDQoNCiAgICAgICAgUm9iZXJ0Lg0KDQpPbiBXZWQs
IEF1ZyAxMywgMjAyNSBhdCA1OjA34oCvUE0gSmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFuZGVy
QGxpbmFyby5vcmc+DQp3cm90ZToNCg0KPiBIaSBSb2JlcnQsDQo+DQo+IE9uIFdlZCwgQXVnIDEz
LCAyMDI1IGF0IDQ6NDjigK9QTSBSb2JlcnQgRGVsaWVuIHZpYSBPUC1URUUNCj4gPG9wLXRlZUBs
aXN0cy50cnVzdGVkZmlybXdhcmUub3JnPiB3cm90ZToNCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4g
V2Ugd291bGQgbGlrZSB0byBwcm90ZWN0IHRydXN0ZWQgYXBwbGljYXRpb24gaGVhcCBtZW1vcnkg
YWdhaW5zdA0KPiBjcnlvZ2VuaWMNCj4gPiBhdHRhY2tzLiBXZSB0aGluayBhIGdvb2QgbWV0aG9k
IHRvIGFjaGlldmUgdGhpcyBpcyBieSBlbXBsb3lpbmcgdGhlIEJ1cw0KPiA+IEVuY3J5cHRpb24g
RW5naW5lIGhhcmR3YXJlIGluIG91ciBpLk1YNlVMLiBGb3IgdGVzdGluZywgSSBjdXJyZW50bHkN
Cj4gPiBjb25maWd1cmUgdGhlIEJFRSBpbiBVLUJvb3QsIHRvIGVuY3J5cHQgdGhlIE9wLVRlZSBU
QV9SQU0gYXJlYQ0KPiA+ICgweDhlMTAwMDAwLThmOWZmZmZmKSwgYW5kIG1ha2UgaXQgYXZhaWxh
YmxlIHVuZW5jcnlwdGVkbHkNCj4gPiBhdCAweDEwMDAwMDAwLTB4MTE4ZmZmZmYuIFRBX1JBTV9T
VEFSVCBpcyBzZXQgdG8gMHgxMDAwMDAwMCBhbmQgdGhpcw0KPiBzZWVtcw0KPiA+IHRvIHdvcmss
IGJ1dCBJIGhhdmUgYSBmZXcgcXVlc3Rpb25zOg0KPiA+IDEuIERvZXMgYXJlYSBUQV9SQU1fU1RB
UlQ6VEFfUkFNX1NJWkUgaG9sZCBhbGwgVEEgY29kZSwgc3RhY2sgYW5kIGhlYXA/DQo+DQo+IFll
cy4gSG93ZXZlciwgb24gdGhlIGxhdGVzdCByZWxlYXNlcywgd2UndmUgc3RhcnRlZCB0byBtZXJn
ZSB0aGUNCj4gcGh5c2ljYWwgbWVtb3J5IGFyZWFzIHJlc2VydmVkIGZvciBPUC1URUUgY29yZSBh
bmQgVEFzLiBTbyB0aGVyZSdzIGENCj4gcmlzayB0aGF0IHRoaW5ncyBtYXkgYmVjb21lIGEgYml0
IG1vcmUgY29tcGxpY2F0ZWQgaW4gdXBzdHJlYW0uDQo+DQo+ID4gMi4gQWNjZXNzIHByaXZpbGVn
ZXMgdG8gMHgxMDAwMDAwMC0weDExOGZmZmZmIGhhdmUgYmVlbiBzZXQgdG8NCj4gKk5vbi1TZWN1
cmUNCj4gPiBVc2VyIG5vbmUsIE5vbi1TZWN1cmUgU3B2ciBub25lLCBTZWN1cmUgVXNlciBSRCAr
IFdSLCBTZWN1cmUgU3B2ciBSRCArDQo+IFdSKiwNCj4gPiBidXQgbXVjaCB0byBteSBzdXJwcmlz
ZSwgKk5vbi1TZWN1cmUgVXNlciBub25lLCBOb24tU2VjdXJlIFNwdnIgbm9uZSwNCj4gPiBTZWN1
cmUgVXNlciBub25lLCBTZWN1cmUgU3B2ciBSRCArIFdSKiB3b3JrZWQgZXF1YWxseSB3ZWxsLg0K
Pg0KPiBXaGVyZSBkbyB5b3Ugc2V0IHRoZXNlIGFjY2VzcyBwcml2aWxlZ2VzPw0KPg0KPiA+DQo+
ID4gSSBjYW4gcHJvdmlkZSBhIG1lbW9yeSBtYXAgaWYgdXNlZnVsLCBidXQgSSdkIHJhdGhlciBu
b3QgcG9zdCB0aGF0IGF0DQo+ID4gZm9yZWhhbmQuDQo+ID4NCj4gPiBJZiB0aGlzIHdvcmtzIHdl
bGwsIGFjaGlldmVzIG91ciBnb2FsIGFuZCB0aGUgcGVyZm9ybWFuY2UgcGVuYWx0eSBpcw0KPiA+
IGFjY2VwdGFibGUsIHdlIHdpbGwgcm9sbCB0aGlzIGludG8gYW4gT3AtVGVlIGRyaXZlci4NCj4N
Cj4gU291bmRzIGludGVyZXN0aW5nLg0KPg0KPiBDaGVlcnMsDQo+IEplbnMNCj4NCj4gPg0KPiA+
IFdpdGgga2luZCByZWdhcmRzLA0KPiA+DQo+ID4gICAgICAgICBSb2JlcnQuDQo+ID4NCj4gPiAt
LQ0KPiA+IERJU0NMQUlNRVINCj4gPiBEZSBpbmZvcm1hdGllLCB2ZXJ6b25kZW4gaW4gb2YgbWV0
IGRpdCBlLW1haWxiZXJpY2h0LCBpcw0KPiA+IHZlcnRyb3V3ZWxpamsgZW4gdWl0c2x1aXRlbmQg
dm9vciBkZSBnZWFkcmVzc2VlcmRlKG4pIGJlc3RlbWQuIEhldA0KPiBnZWJydWlrDQo+ID4gdmFu
IGRlIGluZm9ybWF0aWUgaW4gZGl0IGJlcmljaHQsIGRlIG9wZW5iYWFybWFraW5nLCB2ZXJtZW5p
Z3Z1bGRpZ2luZywNCj4gPiB2ZXJzcHJlaWRpbmcgZW58b2YgdmVyc3RyZWtraW5nIGRhYXJ2YW4g
YWFuIGRlcmRlbiBpcyBuaWV0IHRvZWdlc3RhYW4uDQo+ID4gR2VicnVpayB2YW4gZGV6ZSBpbmZv
cm1hdGllIGRvb3IgYW5kZXJlbiBkYW4gZ2VhZHJlc3NlZXJkZShuKSBpcyBzdHJpa3QNCj4gPiB2
ZXJib2Rlbi4gQWFuIGRlemUgaW5mb3JtYXRpZSBrdW5uZW4gZ2VlbiByZWNodGVuIHdvcmRlbiBv
bnRsZWVuZC4gVQ0KPiB3b3JkdA0KPiA+IHZlcnpvY2h0IGJpaiBvbmp1aXN0ZSBhZHJlc3Nlcmlu
ZyBkZSBhZnplbmRlciBkaXJlY3QgdGUgaW5mb3JtZXJlbiBkb29yDQo+IGhldA0KPiA+IGJlcmlj
aHQgdGUgcmV0b3VybmVyZW4gZW4gaGV0IGJlcmljaHQgdWl0IHV3IGNvbXB1dGVyc3lzdGVlbSB0
ZQ0KPiB2ZXJ3aWpkZXJlbi4NCj4NCg0KLS0gDQpESVNDTEFJTUVSDQpEZSBpbmZvcm1hdGllLCB2
ZXJ6b25kZW4gaW4gb2YgbWV0IGRpdCBlLW1haWxiZXJpY2h0LCBpcyANCnZlcnRyb3V3ZWxpamsg
ZW4gdWl0c2x1aXRlbmQgdm9vciBkZSBnZWFkcmVzc2VlcmRlKG4pIGJlc3RlbWQuIEhldCBnZWJy
dWlrIA0KdmFuIGRlIGluZm9ybWF0aWUgaW4gZGl0IGJlcmljaHQsIGRlIG9wZW5iYWFybWFraW5n
LCB2ZXJtZW5pZ3Z1bGRpZ2luZywgDQp2ZXJzcHJlaWRpbmcgZW58b2YgdmVyc3RyZWtraW5nIGRh
YXJ2YW4gYWFuIGRlcmRlbiBpcyBuaWV0IHRvZWdlc3RhYW4uIA0KR2VicnVpayB2YW4gZGV6ZSBp
bmZvcm1hdGllIGRvb3IgYW5kZXJlbiBkYW4gZ2VhZHJlc3NlZXJkZShuKSBpcyBzdHJpa3QgDQp2
ZXJib2Rlbi4gQWFuIGRlemUgaW5mb3JtYXRpZSBrdW5uZW4gZ2VlbiByZWNodGVuIHdvcmRlbiBv
bnRsZWVuZC4gVSB3b3JkdCANCnZlcnpvY2h0IGJpaiBvbmp1aXN0ZSBhZHJlc3NlcmluZyBkZSBh
ZnplbmRlciBkaXJlY3QgdGUgaW5mb3JtZXJlbiBkb29yIGhldCANCmJlcmljaHQgdGUgcmV0b3Vy
bmVyZW4gZW4gaGV0IGJlcmljaHQgdWl0IHV3IGNvbXB1dGVyc3lzdGVlbSB0ZSB2ZXJ3aWpkZXJl
bi4NCg==
