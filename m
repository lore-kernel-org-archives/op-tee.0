Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B2CC71136
	for <op-tee@archiver.kernel.org>; Thu, 12 Jun 2025 10:44:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1DB7C430C9
	for <op-tee@archiver.kernel.org>; Thu, 12 Jun 2025 10:44:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0B09140B62
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Jun 2025 10:44:27 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1uPfPx-0007O1-0q; Thu, 12 Jun 2025 12:44:21 +0200
Message-ID: <88d6ff32-3303-4e66-b886-b2c459913648@pengutronix.de>
Date: Thu, 12 Jun 2025 12:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Firmware Handoff for DT Overlay created by OP-TEE?
To: Manish Pandey2 <Manish.Pandey2@arm.com>
References: <89ad64f2-fbda-48a3-9a27-5eaff5be9292@pengutronix.de>
 <VI1PR08MB1021788AAFA0E6A859BA3C18CC074A@VI1PR08MB10217.eurprd08.prod.outlook.com>
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <VI1PR08MB1021788AAFA0E6A859BA3C18CC074A@VI1PR08MB10217.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: op-tee@lists.trustedfirmware.org
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.50 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.98%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	RCVD_IN_DNSWL_MED(-0.40)[2a0a:edc0:0:900:1d::77:received,185.203.201.7:from];
	R_SPF_ALLOW(-0.20)[+mx];
	ONCE_RECEIVED(0.20)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:209379, ipnet:185.203.200.0/22, country:DE];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	NEURAL_SPAM(0.00)[0.942]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0B09140B62
Message-ID-Hash: CQOUYNCQPOPVF3CHOSE77ZKX376NDAOX
X-Message-ID-Hash: CQOUYNCQPOPVF3CHOSE77ZKX376NDAOX
X-MailFrom: a.fatoum@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: BAREBOX <barebox@lists.infradead.org>, Raymond Mao <raymond.mao@linaro.org>, Jose Marinho <Jose.Marinho@arm.com>, "rouven.czerwinski@linaro.org" <rouven.czerwinski@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Michael Tretter <m.tretter@pengutronix.de>, Dan Handley <Dan.Handley@arm.com>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CQOUYNCQPOPVF3CHOSE77ZKX376NDAOX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGVsbG8gTWFuaXNoLA0KDQpPbiA2LzEyLzI1IDEyOjEzLCBNYW5pc2ggUGFuZGV5MiB3cm90ZToN
Cj4gVGhhbmtzIEFobWFkIGZvciByZWFjaGluZyBvdXQhDQoNClRoYW5rcyBmb3IgdGhlIHF1aWNr
IHJlc3BvbnNlLg0KDQo+IFRoZXJlIGlzIGEgUFIgWzFdIG9uIHRoZSBGaXJtd2FyZSBIYW5kb2Zm
IHNwZWNpZmljYXRpb24gdGhhdCBpcyBzdGlsbA0KPiB1bmRlciBkaXNjdXNzaW9uLiBDb3VsZCB5
b3UgdGFrZSBhIGxvb2sgYW5kIHNlZSBpZiBpdCBjb3VsZCBhY2NvbW1vZGF0ZQ0KPiB5b3VyIHVz
ZSBjYXNlPw0KDQpDb29sLCB0aGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4gSSB3aWxsIGNoZWNr
IGl0IG91dCBpbiBkZXRhaWwuDQoNCj4gVG8gY29uZmlybSBteSB1bmRlcnN0YW5kaW5nLCB3b3Vs
ZCB0aGUgZGVzaXJlZCBmbG93IGJlIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gIDEuDQo+ICAgICAq
QkwzMSBwYXNzZXMgYSByZWFkLW9ubHkgRFQqwqB0byBPUC1URUUgdmlhIHRoZSBUcmFuc2ZlciBM
aXN0IChUTCkNCg0KRFQgY29tZXMgZnJvbSBCTDIgb3JpZ2luYWxseSwgYnV0IHllcywgQkwzMSBw
YXNzZXMgaXQgYWxvbmcuDQoNCj4gIDIuDQo+ICAgICAqT1AtVEVFIGNvbnN1bWVzKsKgdGhlIERU
LCBhZGRzIG1lbW9yeSByZXNlcnZhdGlvbnMgdmlhIGEgKkRUTyosIGFuZA0KPiAgICAgYXBwZW5k
cyB0aGlzIERUTyB0byB0aGUgVEwNCg0KTXkgb3JpZ2luYWwgdGhvdWdodCB3YXMgdGhhdCBCTDIg
KHZpYSBCTDMxKSBhbGxvY2F0ZXMgc29tZSBtZW1vcnkgYW5kDQpwYXNzZXMgaXQgdmlhIHRyYW5z
ZmVyIGxpc3QgZm9yIE9QLVRFRSB0byBmaWxsIG91dC4NCg0KVGhpcyBhbGxvd3MgcmVjbGFpbWlu
ZyB0aGUgc3BhY2UgdXNlZCBieSB0aGUgb3ZlcmxheSwgd2hpY2ggd291bGQNCm90aGVyd2lzZSBu
b3QgYmUgcG9zc2libGU6DQoNCiAgLSBJZiBPUC1URUUgdXNlcyBhcmJpdHJhcnkgbWVtb3J5LCBp
dCBtYXkgdHVybiBvdXQgdG8gYmUgdXNlZA0KICAgIG90aGVyd2lzZQ0KDQogIC0gSWYgT1AtVEVF
IHVzZXMgaXRzIG93biBtZW1vcnkgdGhhdCBpdCByZXNlcnZlcywgdGhlIHNwYWNlIGlzDQogICAg
bmV2ZXIgcmVjbGFpbWVkIGFzIGl0IGRvZXNuJ3Qga25vdyB3aGVuIGl0J3Mgbm8gbG9uZ2VyIG5l
ZWRlZA0KDQo+ICAzLg0KPiAgICAgKkJMMzEgdGhlbiBmb3J3YXJkcyrCoHRoZSB1cGRhdGVkIFRM
IHRvIEJMMzMNCg0KUmlnaHQuDQoNCj4gDQo+IERvZXMgdGhhdCBtYXRjaCB3aGF0IHlvdSBoYWQg
aW4gbWluZD8NCg0KVGhhbmtzLA0KQWhtYWQNCg0KPiANCj4gDQo+IFsxXTogaHR0cHM6Ly9naXRo
dWIuY29tL0Zpcm13YXJlSGFuZG9mZi9maXJtd2FyZV9oYW5kb2ZmL3B1bGwvNzQNCj4gPGh0dHBz
Oi8vZ2l0aHViLmNvbS9GaXJtd2FyZUhhbmRvZmYvZmlybXdhcmVfaGFuZG9mZi9wdWxsLzc0Pg0K
PiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICpGcm9tOirCoEFobWFkIEZhdG91bSA8YS5mYXRvdW1A
cGVuZ3V0cm9uaXguZGU+DQo+ICpTZW50OirCoDExIEp1bmUgMjAyNSAxOTowOQ0KPiAqVG86KsKg
TWFuaXNoIFBhbmRleTIgPE1hbmlzaC5QYW5kZXkyQGFybS5jb20+DQo+ICpDYzoqwqBvcC10ZWVA
bGlzdHMudHJ1c3RlZGZpcm13YXJlLm9yZyA8b3AtDQo+IHRlZUBsaXN0cy50cnVzdGVkZmlybXdh
cmUub3JnPjsgQkFSRUJPWCA8YmFyZWJveEBsaXN0cy5pbmZyYWRlYWQub3JnPjsNCj4gcm91dmVu
LmN6ZXJ3aW5za2lAbGluYXJvLm9yZyA8cm91dmVuLmN6ZXJ3aW5za2lAbGluYXJvLm9yZz47IE1p
Y2hhZWwNCj4gVHJldHRlciA8bS50cmV0dGVyQHBlbmd1dHJvbml4LmRlPjsga2VybmVsQHBlbmd1
dHJvbml4LmRlDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+DQo+ICpTdWJqZWN0OirCoEZpcm13
YXJlIEhhbmRvZmYgZm9yIERUIE92ZXJsYXkgY3JlYXRlZCBieSBPUC1URUU/DQo+IMKgDQo+IEhl
bGxvIE1hbmlzaCwNCj4gDQo+IEluIHlvdXIgcmVjZW50IHRhbGtbMV0gYXQgTGluYXJvQ29ubmVj
dCBhYm91dCB0aGUgRmlybXdhcmUgSGFuZG9mZg0KPiBzcGVjaWZpY2F0aW9uLCB5b3Ugd2VyZSBh
c2tpbmcgYWJvdXQgd2hhdCBvdGhlciB1c2UgY2FzZXMgaXQgY291bGQNCj4gYWRkcmVzcyBmb3Ig
T1AtVEVFLg0KPiANCj4gV2UgcmFuIGludG8gYSBwb3NzaWJsZSB1c2UgY2FzZSB0aGF0IHdlIHdv
dWxkIGxpa2UgdG8gc2hhcmU6DQo+IA0KPiBCTDIgY2FuIHBhc3MgYSBEVCB0byBPUC1URUUsIHdo
aWNoIGl0IHdvdWxkIHVzZSB0byBkaXNjb3ZlciBtZW1vcnkgYW5kDQo+IHRvIGZpeCB1cCB3aXRo
IG1lbW9yeSByZXNlcnZhdGlvbnMgY292ZXJpbmcgdGhlIG1lbW9yeSBpdCBjYXJ2ZXMgb3V0IGZv
cg0KPiBpdHNlbGYuDQo+IA0KPiBPUC1URUUgYWxzbyBzdXBwb3J0cyBwYXNzaW5nIGFsb25nIHRo
ZSByZXNlcnZhdGlvbnMgYXMgYSBkZXZpY2UgdHJlZQ0KPiBvdmVybGF5LiBBRkFJQ1MsIHRoZXJl
IGlzIG5vIHdheSBjdXJyZW50bHkgdG8gaGF2ZSBib3RoOiBBIERUIGZvciBPUC1URUUNCj4gdG8g
cHJvYmUgaGFyZHdhcmUgZnJvbSBhbmQgYSB3YXkgdG8gcGFzcyB0aGUgbm9ybWFsIHdvcmxkIGEg
ZGV2aWNlIHRyZWUNCj4gb3ZlcmxheSBpbiByZXR1cm4uDQo+IA0KPiBJIHRoaW5rIHRoaXMgY291
bGQgYmUgbmVhdGx5IGFkZHJlc3NlZCB3aXRoIEZpcm13YXJlIEhhbmRvZmYgYW5kIHdvdWxkDQo+
IGJlIGEgbW90aXZhdGlvbiBmb3IgdXMgdG8gaW1wbGVtZW50IHN1cHBvcnQgaW4gYmFyZWJveCBC
TDIvQkwzMyB0byB0YWtlDQo+IGFkdmFudGFnZSBvZiB0aGlzLiBUaGUgY3VycmVudCB3YXkgaXMg
c3Vib3B0aW1hbCBhcyB3ZSB3b3VsZCBwcmVmZXIgdGhlDQo+IERUIHBhc3NlZCB0byBPUC1URUUg
dG8gYmUgcmVhZC1vbmx5LiBUaGlzIGF2b2lkcyBlaXRoZXIgaGF2aW5nIHRvIGNvcHkNCj4gaXQg
b3IgdG8gcGFkIGl0IHN1ZmZpY2llbnRseSBpbiBhbnRpY2lwYXRpb24gb2YgaXQgZ3Jvd2luZyB3
aXRoIHRoZQ0KPiBhZGRpdGlvbiBvZiB0aGUgbmV3IG5vZGVzLg0KPiANCj4gWzFdOiBodHRwczov
L3d3dy55b3V0dWJlLmNvbS93YXRjaD92PVJ4VTc5OGg4YWlFIDxodHRwczovLw0KPiB3d3cueW91
dHViZS5jb20vd2F0Y2g/dj1SeFU3OThoOGFpRT4NCj4gDQo+IENoZWVycywNCj4gQWhtYWQNCj4g
DQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8DQo+IFN0ZXVlcndhbGRlciBTdHIuIDIxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlLyA8aHR0cDovLw0KPiB3d3cucGVuZ3V0cm9uaXgu
ZGUvPsKgIHwNCj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFuecKgwqDCoMKgwqDCoMKgwqAgfCBQ
aG9uZTogKzQ5LTUxMjEtMjA2OTE3LTDCoMKgwqAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWlt
LCBIUkEgMjY4NsKgIHwgRmF4OsKgwqAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0KPiANCg0KLS0g
DQpQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KU3RldWVyd2FsZGVyIFN0ci4gMjEgICAgICAgICAgICAgIHwgaHR0cDovL3d3
dy5wZW5ndXRyb25peC5kZS8gIHwNCjMxMTM3IEhpbGRlc2hlaW0sIEdlcm1hbnkgICAgICAgICB8
IFBob25lOiArNDktNTEyMS0yMDY5MTctMCAgICB8DQpBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBI
UkEgMjY4NiAgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0KDQo=
