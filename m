Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B204BCA0EEB
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 17:41:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DF1204FCC5
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 17:41:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2937642F0C
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 Aug 2025 17:41:30 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1up9Hw-0004PJ-RP; Thu, 21 Aug 2025 19:41:24 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1up9Hw-001Rpf-0k;
	Thu, 21 Aug 2025 19:41:24 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1up9Hw-0086R5-0L;
	Thu, 21 Aug 2025 19:41:24 +0200
Date: Thu, 21 Aug 2025 19:41:24 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <20250821174124.b6pco3izkns4qt2r@pengutronix.de>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: op-tee@lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2937642F0C
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
Message-ID-Hash: KBWHTJUBE2YIWTGKKYE53NV4QJ4G6ZBI
X-Message-ID-Hash: KBWHTJUBE2YIWTGKKYE53NV4QJ4G6ZBI
X-MailFrom: mfe@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz, akpm@linux-foundation.org, kernel@pengutronix.de, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KBWHTJUBE2YIWTGKKYE53NV4QJ4G6ZBI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgYWxsLA0KDQppcyB0aGlzIGlzc3VlIGZpeGVkIHdpdGggNi4xNz8gSSByYW46DQoNCiAgZ2l0
IGxvZyB2Ni4xNC4uLnY2LjE3LXJjMSBkcml2ZXJzL3RlZS90ZWVfc2htLmMNCg0KYW5kIHNhdyBu
byBjaGFuZ2VzLg0KDQpSZWdhcmRzLA0KICBNYXJjbw0KDQpPbiAyNS0wNC0yOCwgSmVucyBXaWts
YW5kZXIgd3JvdGU6DQo+IE9uIFRodSwgTWFyIDI3LCAyMDI1IGF0IDU6NDLigK9BTSBTdW1pdCBH
YXJnIDxzdW1pdC5nYXJnQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBNYXIg
MjYsIDIwMjUgYXQgMDI6NDc6NDZQTSArMDEwMCwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+ID4g
PiBPbiBXZWQsIE1hciAyNiwgMjAyNSBhdCAxMjowN+KAr1BNIE1hcmNvIEZlbHNjaCA8bS5mZWxz
Y2hAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiAyNS0wMy0yNiwg
TWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVlLCBNYXIgMjUsIDIwMjUgYXQg
MDk6MDc6MzlQTSArMDEwMCwgTWFyY28gRmVsc2NoIHdyb3RlOg0KPiA+ID4gPiA+ID4gU2tpcCBt
YW5pcHVsYXRpbmcgdGhlIHJlZmNvdW50IGluIGNhc2Ugb2Ygc2xhYiBwYWdlcyBhY2NvcmRpbmcg
Y29tbWl0DQo+ID4gPiA+ID4gPiBiOWMwZTQ5YWJmY2EgKCJtbTogZGVjbGluZSB0byBtYW5pcHVs
YXRlIHRoZSByZWZjb3VudCBvbiBhIHNsYWIgcGFnZSIpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
VGhpcyBhbG1vc3QgY2VydGFpbmx5IGlzbid0IHJpZ2h0LiAgSSBrbm93IG5vdGhpbmcgYWJvdXQg
VEVFLCBidXQgdGhhdA0KPiA+ID4gPiA+IHlvdSBhcmUgZG9pbmcgdGhpcyBpbmRpY2F0ZXMgYSBw
cm9ibGVtLiAgVGhlIGhhY2sgdGhhdCB3ZSBwdXQgaW50bw0KPiA+ID4gPiA+IG5ldHdvcmtpbmcg
c2hvdWxkIG5vdCBiZSBibGluZGx5IHJlcGxpY2F0ZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBX
aHkgYXJlIHlvdSB0YWtpbmcgYSByZWZlcmVuY2Ugb24gdGhlIHBhZ2VzIHRvIGJlZ2luIHdpdGg/
ICBJcyBpdCBjb3B5DQo+ID4gPiA+ID4gYW5kIHBhc3RlZCBmcm9tIHNvbWV3aGVyZSBlbHNlLCBv
ciB3YXMgdGhlcmUgYWN0dWFsIHRob3VnaHQgcHV0IGludG8gaXQ/DQo+ID4gPiA+DQo+ID4gPiA+
IE5vdCBzdXJlLCB0aGlzIGJlbG9uZ3MgdG8gdGhlIFRFRSBtYWludGFpbmVycy4NCj4gPiA+DQo+
ID4gPiBJIGRvbid0IGtub3cuIFdlIHdlcmUgZ2V0dGluZyB0aGUgdXNlciBwYWdlcyBmaXJzdCwg
c28gSSBhc3N1bWUgd2UNCj4gPiA+IGp1c3QgZGlkIHRoZSBzYW1lIHRoaW5nIHdoZW4gd2UgYWRk
ZWQgc3VwcG9ydCBmb3Iga2VybmVsIHBhZ2VzLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiBJ
ZiBpdCdzICJwcmV2ZW50IHRoZSBjYWxsZXIgZnJvbSBmcmVlaW5nIHRoZSBhbGxvY2F0aW9uIiwg
d2VsbCwgaXQgbmV2ZXINCj4gPiA+ID4gPiBhY2NvbXBsaXNoZWQgdGhhdCB3aXRoIHNsYWIgYWxs
b2NhdGlvbnMuICBTbyBmb3IgY2FsbGVycyB0aGF0IGRvIGttYWxsb2MNCj4gPiA+ID4gPiAoZWcg
c2V0dXBfbW1faGRyKCkgIGluIGRyaXZlcnMvZmlybXdhcmUvZWZpL3N0bW0vdGVlX3N0bW1fZWZp
LmMpLCB5b3UNCj4gPiA+ID4gPiBoYXZlIHRvIHJlbHkgb24gdGhlbSBub3QgZnJlZWluZyB0aGUg
YWxsb2NhdGlvbiB3aGlsZSB0aGUgVEVFIGRyaXZlcg0KPiA+ID4gPiA+IGhhcyBpdC4NCj4gPg0K
PiA+IEl0J3Mgbm90IGp1c3QgYWJvdXQgdGhlIFRFRSBkcml2ZXIgYnV0IHJhdGhlciBpZiB0aGUg
VEVFIGltcGxlbWVudGF0aW9uDQo+ID4gKGEgdHJ1c3RlZCBPUykgdG8gd2hvbSB0aGUgcGFnZSBp
cyByZWdpc3RlcmVkIHdpdGguIFdlIGRvbid0IHdhbnQgdGhlDQo+ID4gdHJ1c3RlZCBPUyB0byB3
b3JrIG9uIHJlZ2lzdGVyZWQga2VybmVsIHBhZ2VzIGlmIHRoZXkgZ2V0cyBmcmVlIHNvbWVob3cN
Cj4gPiBpbiB0aGUgVEVFIGNsaWVudCBkcml2ZXIuIEhhdmluZyBhIHJlZmVyZW5jZSBpbiB0aGUg
VEVFIHN1YnN5c3RlbQ0KPiA+IGFzc3VyZWQgdXMgdGhhdCB3b24ndCBoYXBwZW4uIEJ1dCBpZiB5
b3Ugc2F5IHNsYWIgYWxsb2NhdGlvbnMgYXJlIHN0aWxsDQo+ID4gcHJvbmUgdGhlIGtlcm5lbCBw
YWdlcyBnZXR0aW5nIGZyZWVkIGV2ZW4gYWZ0ZXIgcmVmY291bnQgdGhlbiBjYW4geW91DQo+ID4g
c3VnZ2VzdCBob3cgc2hvdWxkIHdlIGhhbmRsZSB0aGlzIGJldHRlcj8NCj4gPg0KPiA+IEFzIG90
aGVyd2lzZSBpdCBjYW4gY2F1c2UgdmVyeSBoYXJkIHRvIGRlYnVnIHByb2JsZW1zIGlmIHRydXN0
ZWQgT1MgY2FuDQo+ID4gbWFuaXB1bGF0ZSBrZXJuZWwgcGFnZXMgdGhhdCBhcmUgbm8gbG9uZ2Vy
IGF2YWlsYWJsZS4NCj4gDQo+IFdlIG11c3QgYmUgYWJsZSB0byByZWx5IG9uIHRoZSBrZXJuZWwg
Y2FsbGVycyB0byBoYXZlIHRoZSBuZWVkZWQNCj4gcmVmZXJlbmNlcyBiZWZvcmUgY2FsbGluZyB0
ZWVfc2htX3JlZ2lzdGVyX2tlcm5lbF9idWYoKSBhbmQgdG8ga2VlcA0KPiB0aG9zZSB1bnRpbCBh
ZnRlciBjYWxsaW5nIHRlZV9zaG1fZnJlZSgpLg0KPiANCj4gDQo+ID4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IEFuZCBpZiB0aGF0J3MgeW91ciBBUEkgY29udHJhY3QsIHRoZW4gdGhlcmUncyBubyBw
b2ludCBpbiB0YWtpbmcNCj4gPiA+ID4gPiByZWZjb3VudHMgb24gb3RoZXIga2luZHMgb2YgcGFn
ZXMgZWl0aGVyOyBpdCdzIGp1c3QgdW5uZWNlc3NhcnkgYXRvbWljDQo+ID4gPiA+ID4gaW5zdHJ1
Y3Rpb25zLiAgU28gdGhlIHJpZ2h0IHBhdGNoIG1pZ2h0IGJlIHNvbWV0aGluZyBsaWtlIHRoaXM6
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3RlZS90ZWVfc2htLmMNCj4gPiA+
ID4gPiBAQCAtMTUsMjkgKzE1LDExIEBADQo+ID4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9oaWdo
bWVtLmg+DQo+ID4gPiA+ID4gICNpbmNsdWRlICJ0ZWVfcHJpdmF0ZS5oIg0KPiA+ID4gPg0KPiA+
ID4gPiBJIGhhZCB0aGUgc2FtZSBkaWZmIGJ1dCBkaWRuJ3Qgd2VudCB0aGlzIHdheSBzaW5jZSB3
ZSBjYW4ndCBiZSBzdXJlIHRoYXQNCj4gPiA+ID4gaW92J3MgYXJlIGFsd2F5cyBzbGFiIGJhY2tl
ZC4gQXMgZmFyIGFzIEkgdW5kZXJzdG9vZCBJT1ZzLiBJbg0KPiA+ID4gPiAnd29yc3QtY2FzZScg
c2NlbmFyaW8gYW4gaW92IGNhbiBiZSBiYWNrZWQgYnkgZGlmZmVyZW50IHBhZ2UgdHlwZXMgdG9v
Lg0KPiA+ID4NCj4gPiA+IFdlJ3JlIG9ubHkgdXNpbmcga3ZlYydzLiBCcmllZmx5LCBiZWZvcmUg
Y29tbWl0IDdiZGVlNDE1NzU5MSAoInRlZToNCj4gPiA+IFVzZSBpb3ZfaXRlciB0byBiZXR0ZXIg
c3VwcG9ydCBzaGFyZWQgYnVmZmVyIHJlZ2lzdHJhdGlvbiIpIHdlIGNoZWNrZWQNCj4gPiA+IHdp
dGggaXNfdm1hbGxvY19hZGRyKCkgfHwgaXNfa21hcF9hZGRyKCkuIEkgbGlrZSBNYXR0aGV3J3Mg
c3VnZ2VzdGlvbiwNCj4gPiA+IGl0J3MgbmljZSB0byBmaXggcHJvYmxlbXMgYnkgZGVsZXRpbmcg
Y29kZS4gOi0pDQo+ID4gPg0KPiA+ID4gU3VtaXQsIHlvdSBrbm93IHRoZSBjYWxsZXJzIGJldHRl
ci4gV2hhdCBkbyB5b3UgdGhpbms/DQo+ID4NCj4gPiBJZiB3ZSBkb24ndCBoYXZlIGEgc2FuZSB3
YXkgdG8gcmVmY29udCByZWdpc3RlcmVkIGtlcm5lbCBwYWdlcyBpbiBURUUNCj4gPiBzdWJzeXN0
ZW0gdGhlbiB5ZWFoIHdlIGhhdmUgdG8gc29sZWx5IHJlbHkgb24gdGhlIGNsaWVudCBkcml2ZXJz
IHRvDQo+ID4gYmVoYXZlIHByb3Blcmx5LiBOZXZlcnRoZWxlc3MsIGl0J3Mgc3RpbGwgd2l0aGlu
IHRoZSBrZXJuZWwgYm91bmRhcmllcw0KPiA+IHdoaWNoIHdlIGNhbiByZWx5IHVwb24uDQo+IA0K
PiBZZXMuDQo+IA0KPiBDaGVlcnMsDQo+IEplbnMNCg==
