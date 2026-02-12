Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFB7EB491D
	for <op-tee@archiver.kernel.org>; Thu, 12 Feb 2026 12:59:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3885243754
	for <op-tee@archiver.kernel.org>; Thu, 12 Feb 2026 12:59:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 550EF43149
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Feb 2026 12:58:42 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vqWHB-0008LE-0f; Thu, 12 Feb 2026 13:58:33 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vqWH7-000PUE-2A;
	Thu, 12 Feb 2026 13:58:31 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vqWH8-00DseC-2p;
	Thu, 12 Feb 2026 13:58:30 +0100
Date: Thu, 12 Feb 2026 13:58:30 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <20260212125830.jfwos3flga2l5uwk@pengutronix.de>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_IN_DNSWL_MED(-0.40)[185.203.201.7:from,2a0a:edc0:0:c01:1d::a2:received];
	FORGED_SENDER(0.30)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:209379, ipnet:185.203.200.0/22, country:DE];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,suse.cz,linux-foundation.org,pengutronix.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com,foss.st.com,linaro.org,siemens.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	DMARC_NA(0.00)[pengutronix.de];
	NEURAL_SPAM(0.00)[0.999]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 550EF43149
X-Spamd-Bar: -
Message-ID-Hash: JK6HYIMGZSKB2RW2RHUGAAWFWVRE5FAB
X-Message-ID-Hash: JK6HYIMGZSKB2RW2RHUGAAWFWVRE5FAB
X-MailFrom: mfe@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz, akpm@linux-foundation.org, kernel@pengutronix.de, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com, masahisa.kojima@linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JK6HYIMGZSKB2RW2RHUGAAWFWVRE5FAB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgU3VtaXQsDQoNClRCSDogSSB3YXMgaG9waW5nIHRoYXQgeW91IHdpbGwgdGFrZSBjYXJlIG9m
IHRoaXMgc2luY2UgeW91J3JlIG1hcmtlZCBhcw0KbWFpbnRhaW5lciBmb3IgdGhlIHRlZS10cnVz
dGVkLWtleSBhbmQgd2Ugbm90aWNlZCB0aGUgd2FybmluZyB3aXRoIDYuMTQNCmFuZCBzdGlsbCBu
byBmaXggYXZhaWxhYmxlIDovDQoNCkhvd2V2ZXIgcGxlYXNlIHNlZSBiZWxvdyBmb3IgZnVydGhl
ciBkaXNjdXNzaW9uLg0KDQpPbiAyNS0wNC0yOCwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+IE9u
IFRodSwgTWFyIDI3LCAyMDI1IGF0IDU6NDLigK9BTSBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBNYXIgMjYsIDIwMjUgYXQgMDI6NDc6
NDZQTSArMDEwMCwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIE1hciAyNiwg
MjAyNSBhdCAxMjowN+KAr1BNIE1hcmNvIEZlbHNjaCA8bS5mZWxzY2hAcGVuZ3V0cm9uaXguZGU+
IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiAyNS0wMy0yNiwgTWF0dGhldyBXaWxjb3ggd3Jv
dGU6DQo+ID4gPiA+ID4gT24gVHVlLCBNYXIgMjUsIDIwMjUgYXQgMDk6MDc6MzlQTSArMDEwMCwg
TWFyY28gRmVsc2NoIHdyb3RlOg0KPiA+ID4gPiA+ID4gU2tpcCBtYW5pcHVsYXRpbmcgdGhlIHJl
ZmNvdW50IGluIGNhc2Ugb2Ygc2xhYiBwYWdlcyBhY2NvcmRpbmcgY29tbWl0DQo+ID4gPiA+ID4g
PiBiOWMwZTQ5YWJmY2EgKCJtbTogZGVjbGluZSB0byBtYW5pcHVsYXRlIHRoZSByZWZjb3VudCBv
biBhIHNsYWIgcGFnZSIpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyBhbG1vc3QgY2VydGFp
bmx5IGlzbid0IHJpZ2h0LiAgSSBrbm93IG5vdGhpbmcgYWJvdXQgVEVFLCBidXQgdGhhdA0KPiA+
ID4gPiA+IHlvdSBhcmUgZG9pbmcgdGhpcyBpbmRpY2F0ZXMgYSBwcm9ibGVtLiAgVGhlIGhhY2sg
dGhhdCB3ZSBwdXQgaW50bw0KPiA+ID4gPiA+IG5ldHdvcmtpbmcgc2hvdWxkIG5vdCBiZSBibGlu
ZGx5IHJlcGxpY2F0ZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaHkgYXJlIHlvdSB0YWtpbmcg
YSByZWZlcmVuY2Ugb24gdGhlIHBhZ2VzIHRvIGJlZ2luIHdpdGg/ICBJcyBpdCBjb3B5DQo+ID4g
PiA+ID4gYW5kIHBhc3RlZCBmcm9tIHNvbWV3aGVyZSBlbHNlLCBvciB3YXMgdGhlcmUgYWN0dWFs
IHRob3VnaHQgcHV0IGludG8gaXQ/DQo+ID4gPiA+DQo+ID4gPiA+IE5vdCBzdXJlLCB0aGlzIGJl
bG9uZ3MgdG8gdGhlIFRFRSBtYWludGFpbmVycy4NCj4gPiA+DQo+ID4gPiBJIGRvbid0IGtub3cu
IFdlIHdlcmUgZ2V0dGluZyB0aGUgdXNlciBwYWdlcyBmaXJzdCwgc28gSSBhc3N1bWUgd2UNCj4g
PiA+IGp1c3QgZGlkIHRoZSBzYW1lIHRoaW5nIHdoZW4gd2UgYWRkZWQgc3VwcG9ydCBmb3Iga2Vy
bmVsIHBhZ2VzLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiBJZiBpdCdzICJwcmV2ZW50IHRo
ZSBjYWxsZXIgZnJvbSBmcmVlaW5nIHRoZSBhbGxvY2F0aW9uIiwgd2VsbCwgaXQgbmV2ZXINCj4g
PiA+ID4gPiBhY2NvbXBsaXNoZWQgdGhhdCB3aXRoIHNsYWIgYWxsb2NhdGlvbnMuICBTbyBmb3Ig
Y2FsbGVycyB0aGF0IGRvIGttYWxsb2MNCj4gPiA+ID4gPiAoZWcgc2V0dXBfbW1faGRyKCkgIGlu
IGRyaXZlcnMvZmlybXdhcmUvZWZpL3N0bW0vdGVlX3N0bW1fZWZpLmMpLCB5b3UNCj4gPiA+ID4g
PiBoYXZlIHRvIHJlbHkgb24gdGhlbSBub3QgZnJlZWluZyB0aGUgYWxsb2NhdGlvbiB3aGlsZSB0
aGUgVEVFIGRyaXZlcg0KPiA+ID4gPiA+IGhhcyBpdC4NCj4gPg0KPiA+IEl0J3Mgbm90IGp1c3Qg
YWJvdXQgdGhlIFRFRSBkcml2ZXIgYnV0IHJhdGhlciBpZiB0aGUgVEVFIGltcGxlbWVudGF0aW9u
DQo+ID4gKGEgdHJ1c3RlZCBPUykgdG8gd2hvbSB0aGUgcGFnZSBpcyByZWdpc3RlcmVkIHdpdGgu
IFdlIGRvbid0IHdhbnQgdGhlDQo+ID4gdHJ1c3RlZCBPUyB0byB3b3JrIG9uIHJlZ2lzdGVyZWQg
a2VybmVsIHBhZ2VzIGlmIHRoZXkgZ2V0cyBmcmVlIHNvbWVob3cNCj4gPiBpbiB0aGUgVEVFIGNs
aWVudCBkcml2ZXIuIEhhdmluZyBhIHJlZmVyZW5jZSBpbiB0aGUgVEVFIHN1YnN5c3RlbQ0KPiA+
IGFzc3VyZWQgdXMgdGhhdCB3b24ndCBoYXBwZW4uIEJ1dCBpZiB5b3Ugc2F5IHNsYWIgYWxsb2Nh
dGlvbnMgYXJlIHN0aWxsDQo+ID4gcHJvbmUgdGhlIGtlcm5lbCBwYWdlcyBnZXR0aW5nIGZyZWVk
IGV2ZW4gYWZ0ZXIgcmVmY291bnQgdGhlbiBjYW4geW91DQo+ID4gc3VnZ2VzdCBob3cgc2hvdWxk
IHdlIGhhbmRsZSB0aGlzIGJldHRlcj8NCj4gPg0KPiA+IEFzIG90aGVyd2lzZSBpdCBjYW4gY2F1
c2UgdmVyeSBoYXJkIHRvIGRlYnVnIHByb2JsZW1zIGlmIHRydXN0ZWQgT1MgY2FuDQo+ID4gbWFu
aXB1bGF0ZSBrZXJuZWwgcGFnZXMgdGhhdCBhcmUgbm8gbG9uZ2VyIGF2YWlsYWJsZS4NCj4gDQo+
IFdlIG11c3QgYmUgYWJsZSB0byByZWx5IG9uIHRoZSBrZXJuZWwgY2FsbGVycyB0byBoYXZlIHRo
ZSBuZWVkZWQNCj4gcmVmZXJlbmNlcyBiZWZvcmUgY2FsbGluZyB0ZWVfc2htX3JlZ2lzdGVyX2tl
cm5lbF9idWYoKSBhbmQgdG8ga2VlcA0KPiB0aG9zZSB1bnRpbCBhZnRlciBjYWxsaW5nIHRlZV9z
aG1fZnJlZSgpLg0KDQpJIGNoZWNrZWQgdGhlIGNvZGUgb25jZSBhZ2FpbiBhbmQgZmlndXJlZCB0
aGF0IHdlIGNvdWxkIGRyb3AvcmVwbGFjZQ0KdGVlX3NobV9yZWdpc3Rlcl9rZXJuZWxfYnVmKCkg
d2l0aCB0ZWVfc2htX2FsbG9jX2tlcm5lbF9idWYoKS4gSSBkb24ndA0Kc2VlIHdoeSBhIGtlcm5l
bCBkcml2ZXIgbmVlZHMgdG8gdGVlX3NobV9yZWdpc3Rlcl9rZXJuZWxfYnVmKCkgaW4gdGhlDQpm
aXJzdCBwbGFjZSwgbWF5YmUgdGhpcyBpcyBsZWdhY3kuIFRoZSBvbmx5IHVzZXJzIG9mDQp0ZWVf
c2htX3JlZ2lzdGVyX2tlcm5lbF9idWYoKSBhcmUgdHJ1c3RlZF90ZWUuYyBhbmQgdGVlX3N0bW1f
ZWZpLmMuDQoNCitDYyB0aGUgZWZpLXN0bW0gZm9sa3Mgc2luY2UgdGhleSB3aWxsIGJlIGFmZmVj
dGVkIGJ5IHRoaXMgY2hhbmdlIGFzDQp3ZWxsLg0KDQpSZWdhcmRzLA0KICBNYXJjbw0KDQoNCj4g
PiA+ID4gPiBBbmQgaWYgdGhhdCdzIHlvdXIgQVBJIGNvbnRyYWN0LCB0aGVuIHRoZXJlJ3Mgbm8g
cG9pbnQgaW4gdGFraW5nDQo+ID4gPiA+ID4gcmVmY291bnRzIG9uIG90aGVyIGtpbmRzIG9mIHBh
Z2VzIGVpdGhlcjsgaXQncyBqdXN0IHVubmVjZXNzYXJ5IGF0b21pYw0KPiA+ID4gPiA+IGluc3Ry
dWN0aW9ucy4gIFNvIHRoZSByaWdodCBwYXRjaCBtaWdodCBiZSBzb21ldGhpbmcgbGlrZSB0aGlz
Og0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy90ZWUvdGVlX3NobS5jDQo+ID4g
PiA+ID4gQEAgLTE1LDI5ICsxNSwxMSBAQA0KPiA+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvaGln
aG1lbS5oPg0KPiA+ID4gPiA+ICAjaW5jbHVkZSAidGVlX3ByaXZhdGUuaCINCj4gPiA+ID4NCj4g
PiA+ID4gSSBoYWQgdGhlIHNhbWUgZGlmZiBidXQgZGlkbid0IHdlbnQgdGhpcyB3YXkgc2luY2Ug
d2UgY2FuJ3QgYmUgc3VyZSB0aGF0DQo+ID4gPiA+IGlvdidzIGFyZSBhbHdheXMgc2xhYiBiYWNr
ZWQuIEFzIGZhciBhcyBJIHVuZGVyc3Rvb2QgSU9Wcy4gSW4NCj4gPiA+ID4gJ3dvcnN0LWNhc2Un
IHNjZW5hcmlvIGFuIGlvdiBjYW4gYmUgYmFja2VkIGJ5IGRpZmZlcmVudCBwYWdlIHR5cGVzIHRv
by4NCj4gPiA+DQo+ID4gPiBXZSdyZSBvbmx5IHVzaW5nIGt2ZWMncy4gQnJpZWZseSwgYmVmb3Jl
IGNvbW1pdCA3YmRlZTQxNTc1OTEgKCJ0ZWU6DQo+ID4gPiBVc2UgaW92X2l0ZXIgdG8gYmV0dGVy
IHN1cHBvcnQgc2hhcmVkIGJ1ZmZlciByZWdpc3RyYXRpb24iKSB3ZSBjaGVja2VkDQo+ID4gPiB3
aXRoIGlzX3ZtYWxsb2NfYWRkcigpIHx8IGlzX2ttYXBfYWRkcigpLiBJIGxpa2UgTWF0dGhldydz
IHN1Z2dlc3Rpb24sDQo+ID4gPiBpdCdzIG5pY2UgdG8gZml4IHByb2JsZW1zIGJ5IGRlbGV0aW5n
IGNvZGUuIDotKQ0KPiA+ID4NCj4gPiA+IFN1bWl0LCB5b3Uga25vdyB0aGUgY2FsbGVycyBiZXR0
ZXIuIFdoYXQgZG8geW91IHRoaW5rPw0KPiA+DQo+ID4gSWYgd2UgZG9uJ3QgaGF2ZSBhIHNhbmUg
d2F5IHRvIHJlZmNvbnQgcmVnaXN0ZXJlZCBrZXJuZWwgcGFnZXMgaW4gVEVFDQo+ID4gc3Vic3lz
dGVtIHRoZW4geWVhaCB3ZSBoYXZlIHRvIHNvbGVseSByZWx5IG9uIHRoZSBjbGllbnQgZHJpdmVy
cyB0bw0KPiA+IGJlaGF2ZSBwcm9wZXJseS4gTmV2ZXJ0aGVsZXNzLCBpdCdzIHN0aWxsIHdpdGhp
biB0aGUga2VybmVsIGJvdW5kYXJpZXMNCj4gPiB3aGljaCB3ZSBjYW4gcmVseSB1cG9uLg0KPiAN
Cj4gWWVzLg0KPiANCj4gQ2hlZXJzLA0KPiBKZW5zDQoNCi0tIA0KI2dlcm5wZXJEdSANCiNDYWxs
TWVCeU15Rmlyc3ROYW1lDQoNClBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQpTdGV1ZXJ3YWxkZXIgU3RyLiAy
MSAgICAgICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZS8gfA0K
MzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01
MTIxLTIwNjkxNy0wICAgIHwNCkFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAg
ICAgICB8IEZheDogICArNDktNTEyMS0yMDY5MTctOSAgICB8DQo=
