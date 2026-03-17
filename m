Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F7CFD8764
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 12:53:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 11A8E43AA2
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 12:53:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4769B43822
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Mar 2026 12:53:28 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1w2Tv8-0008Au-6G; Tue, 17 Mar 2026 13:53:14 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1w2Tv7-000kBv-2O;
	Tue, 17 Mar 2026 13:53:13 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1w2Tv7-00000007Ixy-2edw;
	Tue, 17 Mar 2026 13:53:13 +0100
Date: Tue, 17 Mar 2026 13:53:13 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [GIT PULL] TEE shared memory fix for 7.0
Message-ID: <dfidrflp5p637dqnn2e6sqr6gbp47gimjlkechjjtlbr7re2e4@kgwofxcumhes>
References: <20260316074150.GA2474723@rayden>
 <20260317-illustrious-finicky-frog-90a86c@quoll>
 <CAHUa44HXjrPbPv0sBxzrW6o1iQVWdp2p-1-jroukZ8dxSvPmMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44HXjrPbPv0sBxzrW6o1iQVWdp2p-1-jroukZ8dxSvPmMg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: op-tee@lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	FORGED_SENDER(0.30)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[2a0a:edc0:0:c01:1d::a2:received];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:209379, ipnet:185.203.200.0/22, country:DE];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.750];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	R_DKIM_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[185.203.201.7:from];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4769B43822
X-Spamd-Bar: --
Message-ID-Hash: Q3YB5KPABPYLNEXZSDNE3ZIKJ4T6MHK5
X-Message-ID-Hash: Q3YB5KPABPYLNEXZSDNE3ZIKJ4T6MHK5
X-MailFrom: mfe@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzk@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Matthew Wilcox <willy@infradead.org>, arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Q3YB5KPABPYLNEXZSDNE3ZIKJ4T6MHK5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

T24gMjYtMDMtMTcsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIFR1ZSwg
TWFyIDE3LCAyMDI2IGF0IDk6NTHigK9BTSBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBNYXIgMTYsIDIwMjYgYXQgMDg6NDE6NTBB
TSArMDEwMCwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+ID4gPiBIZWxsbyBhcm0tc29jIG1haW50
YWluZXJzLA0KPiA+ID4NCj4gPiA+IFBsZWFzZSBwdWxsIHRoaXMgcGF0Y2ggcmVtb3ZpbmcgdGhl
IHJlZmNvdW50aW5nIG9mIGtlcm5lbCBwYWdlcyB3aXRoaW4NCj4gPiA+IHRoZSBURUUgc2hhcmVk
IG1lbW9yeSBoZWxwZXIuDQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gSmVucw0KPiA+ID4N
Cj4gPiA+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNmRlMjNmODFhNWUwOGJl
OGZiZjVlOGQ3ZTlmZWJjNzJhNWI1ZjI3ZjoNCj4gPiA+DQo+ID4gPiAgIExpbnV4IDcuMC1yYzEg
KDIwMjYtMDItMjIgMTM6MTg6NTkgLTA4MDApDQo+ID4gPg0KPiA+ID4gYXJlIGF2YWlsYWJsZSBp
biB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQo+ID4gPg0KPiA+ID4gICBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvamVuc3dpL2xpbnV4LXRlZS5naXQgdGFncy90
ZWUtZml4LWZvci12Ny4wDQo+ID4gPg0KPiA+ID4gZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIDA4ZDlhNDU4MGY3MTEyMGJlM2M1YjIyMWFmMzJkY2EwMGE0OGNlYjA6DQo+ID4gPg0KPiA+
ID4gICB0ZWU6IHNobTogUmVtb3ZlIHJlZmNvdW50aW5nIG9mIGtlcm5lbCBwYWdlcyAoMjAyNi0w
My0wMyAwOTowMzowNCArMDEwMCkNCj4gPiA+DQo+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiBURUUgc2hh
cmVkIG1lbW9yeSB1cGRhdGUgZm9yIDcuMA0KPiA+ID4NCj4gPiA+IFJlbW92ZSByZWZjb3VudGlu
ZyBvZiBrZXJuZWwgcGFnZXMgaW4gcmVnaXN0ZXJfc2htX2hlbHBlcigpIHRvIHN1cHBvcnQNCj4g
PiA+IHNsYWIgYWxsb2NhdGlvbnMuDQo+ID4NCj4gPiBUaGF0J3MgYSBzdXBwb3NlZCBmaXggZm9y
IGEgeWVhciBvbGQgY29tbWl0LCBub3QgY3VycmVudCBSQywgYW5kIHRoZQ0KPiA+IGNvbW1pdCBt
c2cgZG9lcyBub3QgZXhwbGFpbiB3aGF0IGlzIHRoZSBidWcgYmVpbmcgZml4ZWQgaGVyZS4gTG9v
a3MgbGlrZQ0KPiA+IGl0IGlzIGRvaW5nIGltcHJvdmVtZW50LCBub3QgYSBmaXguIENhbiB5b3Ug
cHJvdmlkZSBoZXJlIG1vcmUNCj4gPiBleHBsYW5hdGlvbiBvZiB0aGUgYWN0dWFsIGJ1ZyBiZWlu
ZyBmaXhlZCB0byBqdXN0aWZ5IHRoaXMgZ29pbmcgdG8NCj4gPiBjdXJyZW50IFJDIGZpeGVzPw0K
PiANCj4gSSdtIHVuZGVyIHRoZSBpbXByZXNzaW9uIHRoYXQgaXQgaXMgYSBmaXggcmF0aGVyIHRo
YW4gYW4gaW1wcm92ZW1lbnQuDQo+IEhvd2V2ZXIsIHNpbmNlIGl0IGhhcyBiZWVuIHN0ZXdpbmcg
Zm9yIGEgd2hpbGUsIGl0J3MgY2xlYXJseSBub3QNCj4gdXJnZW50LiBJIGRvbid0IGhhdmUgYW55
dGhpbmcgc3BlY2lmaWMgb24gdGhlIGJ1ZyBmaXgsIG90aGVyIHRoYW4gdGhhdA0KPiB3ZSdyZSBz
dXBwb3NlZCB0byBzdG9wIHRha2luZyB0aG9zZSByZWZjb3VudHMuIFBlcmhhcHMgU3VtaXQsIE1h
cmNvLA0KPiBvciBNYXR0aGV3IGNhbiBhZGQgc29tZXRoaW5nPw0KDQpJdCdzIGEgbG9uZyBvdXRz
dGFuZGluZyBmaXggcmVnYXJkaW5nIG1lbW9yeSBwYWdlIG1hbmFnZW1lbnQuIFRoZQ0KdXNlcnNw
YWNlIGdldHMgaW5mb3JtZWQgYWJvdXQgdGhpcyBtZW1vcnkgQVBJIG1pc3VzZSB2aWEgYSB3YXJu
aW5nIHByaW50DQppbmNsLiBhIGJhY2t0cmFjZS4gVGhpcyBnZXRzIHRyaWdnZXJlZCBvbmx5IGlm
IHVzZXJzcGFjZSB1c2VzIE9QLVRFRQ0KdHJ1c3RlZC1rZXlzIG9yIHRoZSBPUC1URUUgRUZJIHZh
cmlhYmxlcy4gVGhlcmVmb3JlIEkgd291bGQgbGlrZSB0byBnZXQNCml0IGludG8gNy4wIGJ1dCA3
LjEgZmluZSB0b28uDQoNClJlZ2FyZHMsDQogIE1hcmNvDQoNCj4gDQo+IENoZWVycywNCj4gSmVu
cw0KPiANCg0KLS0gDQojZ2VybnBlckR1IA0KI0NhbGxNZUJ5TXlGaXJzdE5hbWUNCg0KUGVuZ3V0
cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwNClN0ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAgICAgICAgICB8
IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlLyB8DQozMTEzNyBIaWxkZXNoZWltLCBHZXJtYW55
ICAgICAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTAgICAgfA0KQW10c2dl
cmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4OiAgICs0OS01MTIxLTIw
NjkxNy05ICAgIHwNCg==
