Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5AACA0EEB
	for <op-tee@archiver.kernel.org>; Fri, 22 Aug 2025 08:52:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 19C8842E23
	for <op-tee@archiver.kernel.org>; Fri, 22 Aug 2025 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755852778;
	bh=GXYoHgJ4ud0i3ws3Zo9/JcMJhGKpVUI3Pi7odH/Lbng=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XFCG0ByS4RZhMJnFtY3DFV1vzvoamCqLzKSuGNV+Py4jLqF4CCKg9x4Z578+FSNCG
	 Lx8ZJqQlmB/mozD9dbf949+LSqrUJJf3beLwJCaMTcjZBrwkTMxEuLiPm3Wti4BxxM
	 ceXsm7CpbLZadBkGiopbLA9LB9cWSK13gsw1oDYAQT8uqX897VnSbysBD69lM2q9to
	 SFu5e9zYgXMyUHF5qYs36fI82PskIl4wG46BDZK5ubBFhozX/81lW7hrfUxvzpvqI4
	 E0jOVm4flI/6qn6FvUzLZ/0Kcc3LNDDRzv2hdNWNbk5BZ0JxpkY6wI/nLh0did3B8O
	 g3whjj/heMqtg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3443A42E23
	for <op-tee@lists.trustedfirmware.org>; Fri, 22 Aug 2025 08:52:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RAGnySQ7;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 851366026A;
	Fri, 22 Aug 2025 08:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DA8C4CEF1;
	Fri, 22 Aug 2025 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755852764;
	bh=3jx+mcX+m+7XdDw9j1KCm1DfU1GXzaRIrU87PKiRUzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAGnySQ7M3XLL8PtyxO+OaqEEdWTRQgqDiSrl+QXcspMKh/fsD8G6c0njDV7J0Azn
	 BFkHXpRDvr/Fbr/eGk+SvzZYmGvPHMOdzVjj9N4PBAZFKEVUGBCVoc7zKjQfXbElcH
	 u6WGaXpePSiNYN9/yAesrlaVHM42Rb9og/Ppjxuo9XEX8Yn9B5xLzV3qSgXB4ycxrq
	 7VmIyifCOFmLTn/5vH+Zu1wt1+5bVHUTE0LZdIXyDNNHZL4UO88X2NytulMKDQM4cA
	 UoV9NDMbTBIRgSaVpCgs3OO033m2n8REvE0C0bUiPGNHn9AQ2RQAjrT1ffofKVdPlH
	 GsXTiChAAKXug==
Date: Fri, 22 Aug 2025 14:22:27 +0530
To: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <aKgvywfzQsi7b1wW@sumit-X1>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
 <20250821174124.b6pco3izkns4qt2r@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <20250821174124.b6pco3izkns4qt2r@pengutronix.de>
X-Rspamd-Queue-Id: 3443A42E23
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: CJPMMNJLNYQCPPKBNWTMROYLONY3YGGI
X-Message-ID-Hash: CJPMMNJLNYQCPPKBNWTMROYLONY3YGGI
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz, akpm@linux-foundation.org, kernel@pengutronix.de, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CJPMMNJLNYQCPPKBNWTMROYLONY3YGGI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gVGh1LCBBdWcgMjEsIDIwMjUgYXQgMDc6NDE6MjRQTSArMDIwMCwgTWFyY28gRmVsc2NoIHdy
b3RlOg0KPiBIaSBhbGwsDQo+IA0KPiBpcyB0aGlzIGlzc3VlIGZpeGVkIHdpdGggNi4xNz8gSSBy
YW46DQo+IA0KPiAgIGdpdCBsb2cgdjYuMTQuLi52Ni4xNy1yYzEgZHJpdmVycy90ZWUvdGVlX3No
bS5jDQo+IA0KPiBhbmQgc2F3IG5vIGNoYW5nZXMuDQoNCkNhcmUgdG8gc2VuZCBhIHByb3BlciBw
YXRjaCByZWdhcmRpbmcgd2hhdCBNYXR0aGV3IHByb3Bvc2VkIGluIHRoaXMNCnRocmVhZD8NCg0K
LVN1bWl0DQoNCj4gDQo+IFJlZ2FyZHMsDQo+ICAgTWFyY28NCj4gDQo+IE9uIDI1LTA0LTI4LCBK
ZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gPiBPbiBUaHUsIE1hciAyNywgMjAyNSBhdCA1OjQy4oCv
QU0gU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+DQo+ID4g
PiBPbiBXZWQsIE1hciAyNiwgMjAyNSBhdCAwMjo0Nzo0NlBNICswMTAwLCBKZW5zIFdpa2xhbmRl
ciB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCBNYXIgMjYsIDIwMjUgYXQgMTI6MDfigK9QTSBNYXJj
byBGZWxzY2ggPG0uZmVsc2NoQHBlbmd1dHJvbml4LmRlPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IE9uIDI1LTAzLTI2LCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gPiA+ID4gPiA+IE9u
IFR1ZSwgTWFyIDI1LCAyMDI1IGF0IDA5OjA3OjM5UE0gKzAxMDAsIE1hcmNvIEZlbHNjaCB3cm90
ZToNCj4gPiA+ID4gPiA+ID4gU2tpcCBtYW5pcHVsYXRpbmcgdGhlIHJlZmNvdW50IGluIGNhc2Ug
b2Ygc2xhYiBwYWdlcyBhY2NvcmRpbmcgY29tbWl0DQo+ID4gPiA+ID4gPiA+IGI5YzBlNDlhYmZj
YSAoIm1tOiBkZWNsaW5lIHRvIG1hbmlwdWxhdGUgdGhlIHJlZmNvdW50IG9uIGEgc2xhYiBwYWdl
IikuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhpcyBhbG1vc3QgY2VydGFpbmx5IGlzbid0
IHJpZ2h0LiAgSSBrbm93IG5vdGhpbmcgYWJvdXQgVEVFLCBidXQgdGhhdA0KPiA+ID4gPiA+ID4g
eW91IGFyZSBkb2luZyB0aGlzIGluZGljYXRlcyBhIHByb2JsZW0uICBUaGUgaGFjayB0aGF0IHdl
IHB1dCBpbnRvDQo+ID4gPiA+ID4gPiBuZXR3b3JraW5nIHNob3VsZCBub3QgYmUgYmxpbmRseSBy
ZXBsaWNhdGVkLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFdoeSBhcmUgeW91IHRha2luZyBh
IHJlZmVyZW5jZSBvbiB0aGUgcGFnZXMgdG8gYmVnaW4gd2l0aD8gIElzIGl0IGNvcHkNCj4gPiA+
ID4gPiA+IGFuZCBwYXN0ZWQgZnJvbSBzb21ld2hlcmUgZWxzZSwgb3Igd2FzIHRoZXJlIGFjdHVh
bCB0aG91Z2h0IHB1dCBpbnRvIGl0Pw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTm90IHN1cmUsIHRo
aXMgYmVsb25ncyB0byB0aGUgVEVFIG1haW50YWluZXJzLg0KPiA+ID4gPg0KPiA+ID4gPiBJIGRv
bid0IGtub3cuIFdlIHdlcmUgZ2V0dGluZyB0aGUgdXNlciBwYWdlcyBmaXJzdCwgc28gSSBhc3N1
bWUgd2UNCj4gPiA+ID4ganVzdCBkaWQgdGhlIHNhbWUgdGhpbmcgd2hlbiB3ZSBhZGRlZCBzdXBw
b3J0IGZvciBrZXJuZWwgcGFnZXMuDQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IElm
IGl0J3MgInByZXZlbnQgdGhlIGNhbGxlciBmcm9tIGZyZWVpbmcgdGhlIGFsbG9jYXRpb24iLCB3
ZWxsLCBpdCBuZXZlcg0KPiA+ID4gPiA+ID4gYWNjb21wbGlzaGVkIHRoYXQgd2l0aCBzbGFiIGFs
bG9jYXRpb25zLiAgU28gZm9yIGNhbGxlcnMgdGhhdCBkbyBrbWFsbG9jDQo+ID4gPiA+ID4gPiAo
ZWcgc2V0dXBfbW1faGRyKCkgIGluIGRyaXZlcnMvZmlybXdhcmUvZWZpL3N0bW0vdGVlX3N0bW1f
ZWZpLmMpLCB5b3UNCj4gPiA+ID4gPiA+IGhhdmUgdG8gcmVseSBvbiB0aGVtIG5vdCBmcmVlaW5n
IHRoZSBhbGxvY2F0aW9uIHdoaWxlIHRoZSBURUUgZHJpdmVyDQo+ID4gPiA+ID4gPiBoYXMgaXQu
DQo+ID4gPg0KPiA+ID4gSXQncyBub3QganVzdCBhYm91dCB0aGUgVEVFIGRyaXZlciBidXQgcmF0
aGVyIGlmIHRoZSBURUUgaW1wbGVtZW50YXRpb24NCj4gPiA+IChhIHRydXN0ZWQgT1MpIHRvIHdo
b20gdGhlIHBhZ2UgaXMgcmVnaXN0ZXJlZCB3aXRoLiBXZSBkb24ndCB3YW50IHRoZQ0KPiA+ID4g
dHJ1c3RlZCBPUyB0byB3b3JrIG9uIHJlZ2lzdGVyZWQga2VybmVsIHBhZ2VzIGlmIHRoZXkgZ2V0
cyBmcmVlIHNvbWVob3cNCj4gPiA+IGluIHRoZSBURUUgY2xpZW50IGRyaXZlci4gSGF2aW5nIGEg
cmVmZXJlbmNlIGluIHRoZSBURUUgc3Vic3lzdGVtDQo+ID4gPiBhc3N1cmVkIHVzIHRoYXQgd29u
J3QgaGFwcGVuLiBCdXQgaWYgeW91IHNheSBzbGFiIGFsbG9jYXRpb25zIGFyZSBzdGlsbA0KPiA+
ID4gcHJvbmUgdGhlIGtlcm5lbCBwYWdlcyBnZXR0aW5nIGZyZWVkIGV2ZW4gYWZ0ZXIgcmVmY291
bnQgdGhlbiBjYW4geW91DQo+ID4gPiBzdWdnZXN0IGhvdyBzaG91bGQgd2UgaGFuZGxlIHRoaXMg
YmV0dGVyPw0KPiA+ID4NCj4gPiA+IEFzIG90aGVyd2lzZSBpdCBjYW4gY2F1c2UgdmVyeSBoYXJk
IHRvIGRlYnVnIHByb2JsZW1zIGlmIHRydXN0ZWQgT1MgY2FuDQo+ID4gPiBtYW5pcHVsYXRlIGtl
cm5lbCBwYWdlcyB0aGF0IGFyZSBubyBsb25nZXIgYXZhaWxhYmxlLg0KPiA+IA0KPiA+IFdlIG11
c3QgYmUgYWJsZSB0byByZWx5IG9uIHRoZSBrZXJuZWwgY2FsbGVycyB0byBoYXZlIHRoZSBuZWVk
ZWQNCj4gPiByZWZlcmVuY2VzIGJlZm9yZSBjYWxsaW5nIHRlZV9zaG1fcmVnaXN0ZXJfa2VybmVs
X2J1ZigpIGFuZCB0byBrZWVwDQo+ID4gdGhvc2UgdW50aWwgYWZ0ZXIgY2FsbGluZyB0ZWVfc2ht
X2ZyZWUoKS4NCj4gPiANCj4gPiANCj4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQW5k
IGlmIHRoYXQncyB5b3VyIEFQSSBjb250cmFjdCwgdGhlbiB0aGVyZSdzIG5vIHBvaW50IGluIHRh
a2luZw0KPiA+ID4gPiA+ID4gcmVmY291bnRzIG9uIG90aGVyIGtpbmRzIG9mIHBhZ2VzIGVpdGhl
cjsgaXQncyBqdXN0IHVubmVjZXNzYXJ5IGF0b21pYw0KPiA+ID4gPiA+ID4gaW5zdHJ1Y3Rpb25z
LiAgU28gdGhlIHJpZ2h0IHBhdGNoIG1pZ2h0IGJlIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy90ZWUvdGVlX3NobS5jDQo+ID4gPiA+
ID4gPiBAQCAtMTUsMjkgKzE1LDExIEBADQo+ID4gPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2hp
Z2htZW0uaD4NCj4gPiA+ID4gPiA+ICAjaW5jbHVkZSAidGVlX3ByaXZhdGUuaCINCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IEkgaGFkIHRoZSBzYW1lIGRpZmYgYnV0IGRpZG4ndCB3ZW50IHRoaXMgd2F5
IHNpbmNlIHdlIGNhbid0IGJlIHN1cmUgdGhhdA0KPiA+ID4gPiA+IGlvdidzIGFyZSBhbHdheXMg
c2xhYiBiYWNrZWQuIEFzIGZhciBhcyBJIHVuZGVyc3Rvb2QgSU9Wcy4gSW4NCj4gPiA+ID4gPiAn
d29yc3QtY2FzZScgc2NlbmFyaW8gYW4gaW92IGNhbiBiZSBiYWNrZWQgYnkgZGlmZmVyZW50IHBh
Z2UgdHlwZXMgdG9vLg0KPiA+ID4gPg0KPiA+ID4gPiBXZSdyZSBvbmx5IHVzaW5nIGt2ZWMncy4g
QnJpZWZseSwgYmVmb3JlIGNvbW1pdCA3YmRlZTQxNTc1OTEgKCJ0ZWU6DQo+ID4gPiA+IFVzZSBp
b3ZfaXRlciB0byBiZXR0ZXIgc3VwcG9ydCBzaGFyZWQgYnVmZmVyIHJlZ2lzdHJhdGlvbiIpIHdl
IGNoZWNrZWQNCj4gPiA+ID4gd2l0aCBpc192bWFsbG9jX2FkZHIoKSB8fCBpc19rbWFwX2FkZHIo
KS4gSSBsaWtlIE1hdHRoZXcncyBzdWdnZXN0aW9uLA0KPiA+ID4gPiBpdCdzIG5pY2UgdG8gZml4
IHByb2JsZW1zIGJ5IGRlbGV0aW5nIGNvZGUuIDotKQ0KPiA+ID4gPg0KPiA+ID4gPiBTdW1pdCwg
eW91IGtub3cgdGhlIGNhbGxlcnMgYmV0dGVyLiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gPiA+DQo+
ID4gPiBJZiB3ZSBkb24ndCBoYXZlIGEgc2FuZSB3YXkgdG8gcmVmY29udCByZWdpc3RlcmVkIGtl
cm5lbCBwYWdlcyBpbiBURUUNCj4gPiA+IHN1YnN5c3RlbSB0aGVuIHllYWggd2UgaGF2ZSB0byBz
b2xlbHkgcmVseSBvbiB0aGUgY2xpZW50IGRyaXZlcnMgdG8NCj4gPiA+IGJlaGF2ZSBwcm9wZXJs
eS4gTmV2ZXJ0aGVsZXNzLCBpdCdzIHN0aWxsIHdpdGhpbiB0aGUga2VybmVsIGJvdW5kYXJpZXMN
Cj4gPiA+IHdoaWNoIHdlIGNhbiByZWx5IHVwb24uDQo+ID4gDQo+ID4gWWVzLg0KPiA+IA0KPiA+
IENoZWVycywNCj4gPiBKZW5zDQo=
