Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA685CA0EEB
	for <op-tee@archiver.kernel.org>; Fri, 22 Aug 2025 10:15:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E89544FC9C
	for <op-tee@archiver.kernel.org>; Fri, 22 Aug 2025 10:15:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F2F1A4544C
	for <op-tee@lists.trustedfirmware.org>; Fri, 22 Aug 2025 10:15:31 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1upOns-0004Vk-Hx; Fri, 22 Aug 2025 12:15:24 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1upOnq-001YrU-0r;
	Fri, 22 Aug 2025 12:15:22 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1upOnq-00A6Ga-0S;
	Fri, 22 Aug 2025 12:15:22 +0200
Date: Fri, 22 Aug 2025 12:15:22 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <20250822101522.wlwmdal5f4sqydjq@pengutronix.de>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
 <20250821174124.b6pco3izkns4qt2r@pengutronix.de>
 <aKgvywfzQsi7b1wW@sumit-X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <aKgvywfzQsi7b1wW@sumit-X1>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: op-tee@lists.trustedfirmware.org
X-Rspamd-Queue-Id: F2F1A4544C
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	RCVD_IN_DNSWL_MED(-0.60)[185.203.201.7:from,2a0a:edc0:2:b01:1d::c5:received,2a0a:edc0:0:c01:1d::a2:received];
	FORGED_SENDER(0.30)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:209379, ipnet:185.203.200.0/22, country:DE];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: I3K3YNUBX56W4P5MCFX6XNQS7DZHWJYZ
X-Message-ID-Hash: I3K3YNUBX56W4P5MCFX6XNQS7DZHWJYZ
X-MailFrom: mfe@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz, akpm@linux-foundation.org, kernel@pengutronix.de, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I3K3YNUBX56W4P5MCFX6XNQS7DZHWJYZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

T24gMjUtMDgtMjIsIFN1bWl0IEdhcmcgd3JvdGU6DQo+IE9uIFRodSwgQXVnIDIxLCAyMDI1IGF0
IDA3OjQxOjI0UE0gKzAyMDAsIE1hcmNvIEZlbHNjaCB3cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4g
DQo+ID4gaXMgdGhpcyBpc3N1ZSBmaXhlZCB3aXRoIDYuMTc/IEkgcmFuOg0KPiA+IA0KPiA+ICAg
Z2l0IGxvZyB2Ni4xNC4uLnY2LjE3LXJjMSBkcml2ZXJzL3RlZS90ZWVfc2htLmMNCj4gPiANCj4g
PiBhbmQgc2F3IG5vIGNoYW5nZXMuDQo+IA0KPiBDYXJlIHRvIHNlbmQgYSBwcm9wZXIgcGF0Y2gg
cmVnYXJkaW5nIHdoYXQgTWF0dGhldyBwcm9wb3NlZCBpbiB0aGlzDQo+IHRocmVhZD8NCg0KSSdt
IHN0aWxsIG5vdCBzdXJlIGlmIHRoZSBJT1ZzIGNhbiBiZSBiYWNrZWQgYnkgb3RoZXIgYWxsb2Nh
dG9ycyB0b28NCmJlY2F1c2UgdGhlIE9QLVRFRSBBUEkgYWxsb3dzIGFyYml0cmFyeSBzaXplcy4g
VGhlcmVmb3JlIG15IGhvcGUgd2FzDQp0aGF0IG9uZSBvZiB0aGUgT1AtVEVFIG1haW50YWluZXJz
IGlzIHRha2luZyBjYXJlIG9mIHRoaXMgcHJvYmxlbS4NCg0KSSBhbHNvIHdvbmRlciB3aHkgbm8g
b25lIHNwb3R0ZWQvcmVwb3J0ZWQgdGhpcyBpc3N1ZSB0b28uDQoNClJlZ2FyZHMsDQogIE1hcmNv
DQoNCg0KPiANCj4gLVN1bWl0DQo+IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gICBNYXJjbw0K
PiA+IA0KPiA+IE9uIDI1LTA0LTI4LCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gPiA+IE9uIFRo
dSwgTWFyIDI3LCAyMDI1IGF0IDU6NDLigK9BTSBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBXZWQsIE1hciAyNiwgMjAyNSBhdCAw
Mjo0Nzo0NlBNICswMTAwLCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQs
IE1hciAyNiwgMjAyNSBhdCAxMjowN+KAr1BNIE1hcmNvIEZlbHNjaCA8bS5mZWxzY2hAcGVuZ3V0
cm9uaXguZGU+IHdyb3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9uIDI1LTAzLTI2LCBN
YXR0aGV3IFdpbGNveCB3cm90ZToNCj4gPiA+ID4gPiA+ID4gT24gVHVlLCBNYXIgMjUsIDIwMjUg
YXQgMDk6MDc6MzlQTSArMDEwMCwgTWFyY28gRmVsc2NoIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+
IFNraXAgbWFuaXB1bGF0aW5nIHRoZSByZWZjb3VudCBpbiBjYXNlIG9mIHNsYWIgcGFnZXMgYWNj
b3JkaW5nIGNvbW1pdA0KPiA+ID4gPiA+ID4gPiA+IGI5YzBlNDlhYmZjYSAoIm1tOiBkZWNsaW5l
IHRvIG1hbmlwdWxhdGUgdGhlIHJlZmNvdW50IG9uIGEgc2xhYiBwYWdlIikuDQo+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+IFRoaXMgYWxtb3N0IGNlcnRhaW5seSBpc24ndCByaWdodC4gIEkg
a25vdyBub3RoaW5nIGFib3V0IFRFRSwgYnV0IHRoYXQNCj4gPiA+ID4gPiA+ID4geW91IGFyZSBk
b2luZyB0aGlzIGluZGljYXRlcyBhIHByb2JsZW0uICBUaGUgaGFjayB0aGF0IHdlIHB1dCBpbnRv
DQo+ID4gPiA+ID4gPiA+IG5ldHdvcmtpbmcgc2hvdWxkIG5vdCBiZSBibGluZGx5IHJlcGxpY2F0
ZWQuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFdoeSBhcmUgeW91IHRha2luZyBhIHJl
ZmVyZW5jZSBvbiB0aGUgcGFnZXMgdG8gYmVnaW4gd2l0aD8gIElzIGl0IGNvcHkNCj4gPiA+ID4g
PiA+ID4gYW5kIHBhc3RlZCBmcm9tIHNvbWV3aGVyZSBlbHNlLCBvciB3YXMgdGhlcmUgYWN0dWFs
IHRob3VnaHQgcHV0IGludG8gaXQ/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gTm90IHN1cmUs
IHRoaXMgYmVsb25ncyB0byB0aGUgVEVFIG1haW50YWluZXJzLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gSSBkb24ndCBrbm93LiBXZSB3ZXJlIGdldHRpbmcgdGhlIHVzZXIgcGFnZXMgZmlyc3QsIHNv
IEkgYXNzdW1lIHdlDQo+ID4gPiA+ID4ganVzdCBkaWQgdGhlIHNhbWUgdGhpbmcgd2hlbiB3ZSBh
ZGRlZCBzdXBwb3J0IGZvciBrZXJuZWwgcGFnZXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IElmIGl0J3MgInByZXZlbnQgdGhlIGNhbGxlciBmcm9tIGZyZWVpbmcgdGhl
IGFsbG9jYXRpb24iLCB3ZWxsLCBpdCBuZXZlcg0KPiA+ID4gPiA+ID4gPiBhY2NvbXBsaXNoZWQg
dGhhdCB3aXRoIHNsYWIgYWxsb2NhdGlvbnMuICBTbyBmb3IgY2FsbGVycyB0aGF0IGRvIGttYWxs
b2MNCj4gPiA+ID4gPiA+ID4gKGVnIHNldHVwX21tX2hkcigpICBpbiBkcml2ZXJzL2Zpcm13YXJl
L2VmaS9zdG1tL3RlZV9zdG1tX2VmaS5jKSwgeW91DQo+ID4gPiA+ID4gPiA+IGhhdmUgdG8gcmVs
eSBvbiB0aGVtIG5vdCBmcmVlaW5nIHRoZSBhbGxvY2F0aW9uIHdoaWxlIHRoZSBURUUgZHJpdmVy
DQo+ID4gPiA+ID4gPiA+IGhhcyBpdC4NCj4gPiA+ID4NCj4gPiA+ID4gSXQncyBub3QganVzdCBh
Ym91dCB0aGUgVEVFIGRyaXZlciBidXQgcmF0aGVyIGlmIHRoZSBURUUgaW1wbGVtZW50YXRpb24N
Cj4gPiA+ID4gKGEgdHJ1c3RlZCBPUykgdG8gd2hvbSB0aGUgcGFnZSBpcyByZWdpc3RlcmVkIHdp
dGguIFdlIGRvbid0IHdhbnQgdGhlDQo+ID4gPiA+IHRydXN0ZWQgT1MgdG8gd29yayBvbiByZWdp
c3RlcmVkIGtlcm5lbCBwYWdlcyBpZiB0aGV5IGdldHMgZnJlZSBzb21laG93DQo+ID4gPiA+IGlu
IHRoZSBURUUgY2xpZW50IGRyaXZlci4gSGF2aW5nIGEgcmVmZXJlbmNlIGluIHRoZSBURUUgc3Vi
c3lzdGVtDQo+ID4gPiA+IGFzc3VyZWQgdXMgdGhhdCB3b24ndCBoYXBwZW4uIEJ1dCBpZiB5b3Ug
c2F5IHNsYWIgYWxsb2NhdGlvbnMgYXJlIHN0aWxsDQo+ID4gPiA+IHByb25lIHRoZSBrZXJuZWwg
cGFnZXMgZ2V0dGluZyBmcmVlZCBldmVuIGFmdGVyIHJlZmNvdW50IHRoZW4gY2FuIHlvdQ0KPiA+
ID4gPiBzdWdnZXN0IGhvdyBzaG91bGQgd2UgaGFuZGxlIHRoaXMgYmV0dGVyPw0KPiA+ID4gPg0K
PiA+ID4gPiBBcyBvdGhlcndpc2UgaXQgY2FuIGNhdXNlIHZlcnkgaGFyZCB0byBkZWJ1ZyBwcm9i
bGVtcyBpZiB0cnVzdGVkIE9TIGNhbg0KPiA+ID4gPiBtYW5pcHVsYXRlIGtlcm5lbCBwYWdlcyB0
aGF0IGFyZSBubyBsb25nZXIgYXZhaWxhYmxlLg0KPiA+ID4gDQo+ID4gPiBXZSBtdXN0IGJlIGFi
bGUgdG8gcmVseSBvbiB0aGUga2VybmVsIGNhbGxlcnMgdG8gaGF2ZSB0aGUgbmVlZGVkDQo+ID4g
PiByZWZlcmVuY2VzIGJlZm9yZSBjYWxsaW5nIHRlZV9zaG1fcmVnaXN0ZXJfa2VybmVsX2J1Zigp
IGFuZCB0byBrZWVwDQo+ID4gPiB0aG9zZSB1bnRpbCBhZnRlciBjYWxsaW5nIHRlZV9zaG1fZnJl
ZSgpLg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4gQW5kIGlmIHRoYXQncyB5b3VyIEFQSSBjb250cmFjdCwgdGhlbiB0aGVyZSdzIG5vIHBvaW50
IGluIHRha2luZw0KPiA+ID4gPiA+ID4gPiByZWZjb3VudHMgb24gb3RoZXIga2luZHMgb2YgcGFn
ZXMgZWl0aGVyOyBpdCdzIGp1c3QgdW5uZWNlc3NhcnkgYXRvbWljDQo+ID4gPiA+ID4gPiA+IGlu
c3RydWN0aW9ucy4gIFNvIHRoZSByaWdodCBwYXRjaCBtaWdodCBiZSBzb21ldGhpbmcgbGlrZSB0
aGlzOg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3RlZS90ZWVf
c2htLmMNCj4gPiA+ID4gPiA+ID4gQEAgLTE1LDI5ICsxNSwxMSBAQA0KPiA+ID4gPiA+ID4gPiAg
I2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0uaD4NCj4gPiA+ID4gPiA+ID4gICNpbmNsdWRlICJ0ZWVf
cHJpdmF0ZS5oIg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkgaGFkIHRoZSBzYW1lIGRpZmYg
YnV0IGRpZG4ndCB3ZW50IHRoaXMgd2F5IHNpbmNlIHdlIGNhbid0IGJlIHN1cmUgdGhhdA0KPiA+
ID4gPiA+ID4gaW92J3MgYXJlIGFsd2F5cyBzbGFiIGJhY2tlZC4gQXMgZmFyIGFzIEkgdW5kZXJz
dG9vZCBJT1ZzLiBJbg0KPiA+ID4gPiA+ID4gJ3dvcnN0LWNhc2UnIHNjZW5hcmlvIGFuIGlvdiBj
YW4gYmUgYmFja2VkIGJ5IGRpZmZlcmVudCBwYWdlIHR5cGVzIHRvby4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IFdlJ3JlIG9ubHkgdXNpbmcga3ZlYydzLiBCcmllZmx5LCBiZWZvcmUgY29tbWl0IDdi
ZGVlNDE1NzU5MSAoInRlZToNCj4gPiA+ID4gPiBVc2UgaW92X2l0ZXIgdG8gYmV0dGVyIHN1cHBv
cnQgc2hhcmVkIGJ1ZmZlciByZWdpc3RyYXRpb24iKSB3ZSBjaGVja2VkDQo+ID4gPiA+ID4gd2l0
aCBpc192bWFsbG9jX2FkZHIoKSB8fCBpc19rbWFwX2FkZHIoKS4gSSBsaWtlIE1hdHRoZXcncyBz
dWdnZXN0aW9uLA0KPiA+ID4gPiA+IGl0J3MgbmljZSB0byBmaXggcHJvYmxlbXMgYnkgZGVsZXRp
bmcgY29kZS4gOi0pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTdW1pdCwgeW91IGtub3cgdGhlIGNh
bGxlcnMgYmV0dGVyLiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gPiA+ID4NCj4gPiA+ID4gSWYgd2Ug
ZG9uJ3QgaGF2ZSBhIHNhbmUgd2F5IHRvIHJlZmNvbnQgcmVnaXN0ZXJlZCBrZXJuZWwgcGFnZXMg
aW4gVEVFDQo+ID4gPiA+IHN1YnN5c3RlbSB0aGVuIHllYWggd2UgaGF2ZSB0byBzb2xlbHkgcmVs
eSBvbiB0aGUgY2xpZW50IGRyaXZlcnMgdG8NCj4gPiA+ID4gYmVoYXZlIHByb3Blcmx5LiBOZXZl
cnRoZWxlc3MsIGl0J3Mgc3RpbGwgd2l0aGluIHRoZSBrZXJuZWwgYm91bmRhcmllcw0KPiA+ID4g
PiB3aGljaCB3ZSBjYW4gcmVseSB1cG9uLg0KPiA+ID4gDQo+ID4gPiBZZXMuDQo+ID4gPiANCj4g
PiA+IENoZWVycywNCj4gPiA+IEplbnMNCg==
