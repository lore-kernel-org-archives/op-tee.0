Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4F1FB3CEB
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 09:51:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D4B63443AA
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774864284;
	bh=LzROeYjqa/yN3adlCvD5mSSp3MM2MquA76x8iW7FSQA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JlTTNzHAsJwSZnzJCbzb+RBGbbmAJH9OOuroSuS2C7sMVCHVeC7f96LQ1XQZAt1DT
	 P2DSS4qcMw+BiV4enEIxxDDvNxvCnEz66IH80LtgMXLj/53xSuKJxVRPSy51WkFAVx
	 tzhmi8MaAgx3HQxzeotIpeYB4pk349N0OlbGidDJOJV8kgryer9uzQYED4oUt3kaDF
	 fTKeZ1hEJgJMXQX1xyFeIxssFEkIRgsTMu7M/eBu31bmGk3UTWEZ/jd5CoFAY064Qk
	 4XQhHRZ/SoyRzPu0Z5BPK84Mr7QOZ8Q0jwMHaelPXJM9c3oUBqZZIbH1Uk403I0sSP
	 ooAw3R42s+vFA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5FC1A43A6B
	for <op-tee@lists.trustedfirmware.org>; Mon, 30 Mar 2026 09:51:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d8cNZb5G;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AFB0560128;
	Mon, 30 Mar 2026 09:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38C5C4CEF7;
	Mon, 30 Mar 2026 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864277;
	bh=tgl3dr9aMV5OFKhDYEwEa46R/FsBwkPwWB3ABPXPouo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8cNZb5GQbAi9K0mHDR4X7lvRg2c82HlFOBKX4T6xV/XZ91hxXrBTIlF+sx4cAE2x
	 n8uJyXsV8LCtj9tISvP6fIWXAsJYjaP4yU7UFQYB8d+dBUUGrv8MJsgvNqZv+GzF5O
	 H2yTy3Yk2Ifro4TVq/L9tlUheZ6A6jJm25m95x0BNtw+uDZQLsoo7llhuBPtXHS8si
	 5SzzDKC1pqWzdc14+UewF/rDUOSY3bRyf8VUjLyTEjo/27YoljvYsYkL9bR0MKUv6B
	 FvLK+d1C1uFkwE358PbeXJjnzQLiBq3R4UXDr38tMfY1lsqz6zu7AUzVJh0PhsS0gt
	 AWzH0bDAbGgww==
Date: Mon, 30 Mar 2026 15:21:12 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: Possible race during OP-TEE kernel module device probing
Message-ID: <acpHkOJhmCkMadHj@sumit-xelite>
References: <d9bb3b058dcd0425b18c77120dae225506b079e2.camel@mediatek.com>
 <acZVg6GQQT17r0OG@sumit-xelite>
 <0c8f7f5d4736287c36df973c593b7706fd36220b.camel@mediatek.com>
 <CAHUa44EcGEoBcx2J4dOJOSNjE7E9=qCivdfJtFzgrHmqKKB8Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44EcGEoBcx2J4dOJOSNjE7E9=qCivdfJtFzgrHmqKKB8Fg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5FC1A43A6B
X-Spamd-Bar: ----
Message-ID-Hash: 3NY5ACMNT4DCXIK54WP4FN37LHPY3AVE
X-Message-ID-Hash: 3NY5ACMNT4DCXIK54WP4FN37LHPY3AVE
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Shf Chen =?utf-8?B?KOmZs+WwkeeUqyk=?= <Shf.Chen@mediatek.com>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3NY5ACMNT4DCXIK54WP4FN37LHPY3AVE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gTW9uLCBNYXIgMzAsIDIwMjYgYXQgMTE6MTY6NTlBTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IEhpLA0KPiANCj4gT24gTW9uLCBNYXIgMzAsIDIwMjYgYXQgNjowN+KAr0FNIFNo
ZiBDaGVuICjpmbPlsJHnlKspIHZpYSBPUC1URUUNCj4gPG9wLXRlZUBsaXN0cy50cnVzdGVkZmly
bXdhcmUub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgMjAyNi0wMy0yNyBhdCAxNTozMSAr
MDUzMCwgU3VtaXQgR2FyZyB3cm90ZToNCj4gPiA+IE9uIEZyaSwgTWFyIDI3LCAyMDI2IGF0IDA5
OjAxOjE1QU0gKzAwMDAsIFNoZiBDaGVuICjpmbPlsJHnlKspIHZpYSBPUC1URUUgd3JvdGU6DQo+
ID4gPiA+IEhpLA0KPiA+ID4gPg0KPiA+ID4gPiBXZSBmb3VuZCBhIHBvc3NpYmxlIHJhY2UgY29u
ZGl0aW9uIGlzc3VlIGR1cmluZyBPUC1URUUga2VybmVsIGRyaXZlciBwcm9iaW5nIHRoZSBkZXZp
Y2UuDQo+ID4gPiA+IEEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGV4Y2VwdGlvbiBjYW4gaGFw
cGVuIHdoZW4gYW5vdGhlciBrZXJuZWwgZHJpdmVyIG9wZW4gT1AtVEVFIGNvbnRleHQNCj4gPiA+
ID4gd2l0aCB0ZWVfY2xpZW50X29wZW5fY29udGV4dCgpIHRoZW4gZG8gYSBTTUMgY2FsbCB0byBP
UC1URUUuDQo+ID4gPiA+IEJlbG93IGlzIHRoZSBleGNlcHRpb246DQo+ID4gPg0KPiA+ID4gSG93
IGlzIHlvdXIga2VybmVsIGRyaXZlciBiZWluZyBwcm9iZWQ/IEhhdmUgeW91IHJlZ2lzdGVyZWQg
aXQgYXMgYQ0KPiA+ID4gcHJvcGVyIFRFRSBidXMgZHJpdmVyPyBBbnkgY3VzdG9tIHdheXMgdG8g
aW52b2tlIFRFRSBrZXJuZWwgY2xpZW50IEFQSXMNCj4gPiA+IGFyZSBzdXJlbHkgc3VzY2VwdGli
bGUgdG8gcmFjZXMgbGlrZSB0aGUgb25lIHlvdSBtZW50aW9uZWQgYmVsb3cuDQo+ID4gPg0KPiA+
ID4gLVN1bWl0DQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+IE91ciBrZXJuZWwgZHJpdmVyIGRvZXMg
bm90IHJlZ2lzdGVyZWQgYXMgYSBURUUgYnVzIGRyaXZlciBmb3Igc29tZSByZWFzb25zLA0KPiA+
IGFuZCB3ZSBuZWVkIHRvIHVzZSBvdGhlciBBUEkgdG8gZW5zdXJlIHRoZSBPUC1URUUgZHJpdmVy
IGlzIHByb2JlZCB0bw0KPiA+IHdvcmthcm91bmQgdGhpcyBpc3N1ZS4gQnV0LCB3ZSB0aGluayB0
aGlzIGlzIGVycm9yLXByb25lIGZvciBtb2R1bGUgZGV2ZWxvcGVyDQo+ID4gdGhhdCBuZWVkIHRv
IGNhbGwgdG8gT1AtVEVFLg0KDQpUaGUga2VybmVsIG1vZHVsZXMgQVBJIGZvciBPUC1URUUgaXMg
dmlhIFRFRSBidXMgb25seS4NCg0KPiA+DQo+ID4gQWx0aG91Z2ggdGhpcyBpcyBub3QgdGhlIGNh
c2UsIEkgdGhpbmsgdGhhdCBhZnRlciBjYWxsaW5nIHRlZV9kZXZpY2VfcmVnaXN0ZXIoKSwNCj4g
PiB0aGUgb3B0ZWUgZGV2aWNlIGlzIHNob3duIHVuZGVyIGAvZGV2L2AgZmlsZXN5c3RlbS4gVGhl
cmUgaXMgYSB2ZXJ5IHNtYWxsIGNoYW5jZQ0KPiA+IGZvciB1c2Vyc3BhY2UgcHJvZ3JhbSB0byB0
cmlnZ2VyIHRoaXMgcmFjZSBjb25kaXRpb24sIGFuZCB0aGV5IGRvbid0IGhhdmUgY2x1ZSBvbg0K
PiA+IHdoZXRoZXIgdGhlIGRldmljZSBpcyBwcm9wZXJseSBiZWluZyBwcm9iZWQgeWV0Lg0KPiAN
Cj4gSSB0aGluayB5b3UncmUgb24gdG8gc29tZXRoaW5nLiBBZnRlciBjYWxsaW5nIHRlZV9kZXZp
Y2VfcmVnaXN0ZXIoKSwNCj4gdGhlIGRyaXZlciBtdXN0IGJlIGFibGUgdG8gaGFuZGxlIHJlcXVl
c3RzLCBhdCBsZWFzdCB3aXRob3V0IGNyYXNoaW5nLg0KPiBvcHRlZV9lbnVtZXJhdGVfZGV2aWNl
cygpIHJlcXVpcmVzIHRoZSBkZXZpY2VzIHRvIGJlIHJlZ2lzdGVyZWQsIHNvDQo+IHRoYXQgbXVz
dCBoYXBwZW4gYWZ0ZXIgdGhvc2UgY2FsbHMuIEJ1dCBvdGhlciB0aGFuIHRoYXQsIEkgdGhpbmsg
dGhlDQo+IGNhbGxzIHRvICB0ZWVfZGV2aWNlX3JlZ2lzdGVyKCkgc2hvdWxkIGJlIHRoZSBsYXN0
IHRoaW5nIGluIHRoZSBwcm9iZQ0KPiBmdW5jdGlvbi4NCj4gDQo+IFN1bWl0LCBkbyB5b3UgYWdy
ZWU/DQo+IA0KDQpTb3VuZHMgcmVhc29uYWJsZSB0byBtZSBpZiBpdCdzIHNvbWV0aGluZyB0aGF0
IGNhbiBiZSByZXByb2R1Y2VkIHZpYQ0KdGhlIHVzZXItc3BhY2UgY2xpZW50Lg0KDQotU3VtaXQN
Cg==
