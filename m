Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7128BCDC19F
	for <op-tee@archiver.kernel.org>; Tue,  6 Jan 2026 13:40:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id ABE6E4FF56
	for <op-tee@archiver.kernel.org>; Tue,  6 Jan 2026 13:40:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 690CB43163
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Jan 2026 13:40:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA5E7497;
	Tue,  6 Jan 2026 05:40:24 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D1043F6A8;
	Tue,  6 Jan 2026 05:40:25 -0800 (PST)
Date: Tue, 6 Jan 2026 13:40:23 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver
 callbacks
Message-ID: <aV0Qx5BOso5co3tm@bogus>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com>
 <20251218135332f323fa91@mail.local>
 <CAHUa44GpW5aO26GDyL9RZub9vVYvVcJ7etwO0yXBN_mUi0W4AA@mail.gmail.com>
 <CAHUa44HqRbCJTXsrTCm0G5iwtkQtq+Si=yOspCjpAn-N2uVSVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44HqRbCJTXsrTCm0G5iwtkQtq+Si=yOspCjpAn-N2uVSVg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	FORGED_SENDER(0.30)[sudeep.holla@arm.com,sudeep.holla@foss.arm.com];
	RCVD_IN_DNSWL_MED(-0.20)[217.140.110.172:from];
	R_SPF_ALLOW(-0.20)[+ip4:217.140.96.0/20];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	ASN(0.00)[asn:28939, ipnet:217.140.110.0/24, country:GB];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,arm.com,baylibre.com,lwn.net,kernel.org,selenic.com,gondor.apana.org.au,gmail.com,foss.st.com,oss.qualcomm.com,linaro.org,siemens.com,wanadoo.fr,broadcom.com,hansenpartnership.com,linux.ibm.com,redhat.com,paul-moore.com,namei.org,hallyn.com,gmx.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,ziepe.ca];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@arm.com,sudeep.holla@foss.arm.com];
	ARC_NA(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 690CB43163
X-Spamd-Bar: -
Message-ID-Hash: S2AF7D2TSNL7VVKBCVOC6TVP5H3U6P7I
X-Message-ID-Hash: S2AF7D2TSNL7VVKBCVOC6TVP5H3U6P7I
X-MailFrom: sudeep.holla@foss.arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Sudeep Holla <sudeep.holla@arm.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul
 @paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/S2AF7D2TSNL7VVKBCVOC6TVP5H3U6P7I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

T24gTW9uLCBKYW4gMDUsIDIwMjYgYXQgMTA6MTY6MDlBTSArMDEwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IEhpLA0KPiANCj4gT24gVGh1LCBEZWMgMTgsIDIwMjUgYXQgNToyOeKAr1BNIEpl
bnMgV2lrbGFuZGVyDQo+IDxqZW5zLndpa2xhbmRlckBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPg0K
PiA+IE9uIFRodSwgRGVjIDE4LCAyMDI1IGF0IDI6NTPigK9QTSBBbGV4YW5kcmUgQmVsbG9uaQ0K
PiA+IDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4g
T24gMTgvMTIvMjAyNSAwODoyMToyNyswMTAwLCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gPiA+
ID4gSGksDQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1vbiwgRGVjIDE1LCAyMDI1IGF0IDM6MTfigK9Q
TSBVd2UgS2xlaW5lLUvDtm5pZw0KPiA+ID4gPiA8dS5rbGVpbmUta29lbmlnQGJheWxpYnJlLmNv
bT4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBIZWxsbywNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IHRoZSBvYmplY3RpdmUgb2YgdGhpcyBzZXJpZXMgaXMgdG8gbWFrZSB0ZWUgZHJpdmVyIHN0
b3AgdXNpbmcgY2FsbGJhY2tzDQo+ID4gPiA+ID4gaW4gc3RydWN0IGRldmljZV9kcml2ZXIuIFRo
ZXNlIHdlcmUgc3VwZXJzZWRlZCBieSBidXMgbWV0aG9kcyBpbiAyMDA2DQo+ID4gPiA+ID4gKGNv
bW1pdCA1OTRjODI4MWY5MDUgKCJbUEFUQ0hdIEFkZCBidXNfdHlwZSBwcm9iZSwgcmVtb3ZlLCBz
aHV0ZG93bg0KPiA+ID4gPiA+IG1ldGhvZHMuIikpIGJ1dCBub2JvZHkgY2FyZWQgdG8gY29udmVy
dCBhbGwgc3Vic3lzdGVtcyBhY2NvcmRpbmdseS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEhlcmUg
dGhlIHRlZSBkcml2ZXJzIGFyZSBjb252ZXJ0ZWQuIFRoZSBmaXJzdCBjb21taXQgaXMgc29tZXdo
YXQNCj4gPiA+ID4gPiB1bnJlbGF0ZWQsIGJ1dCBzaW1wbGlmaWVzIHRoZSBjb252ZXJzaW9uIChh
bmQgdGhlIGRyaXZlcnMpLiBJdA0KPiA+ID4gPiA+IGludHJvZHVjZXMgZHJpdmVyIHJlZ2lzdHJh
dGlvbiBoZWxwZXJzIHRoYXQgY2FyZSBhYm91dCBzZXR0aW5nIHRoZSBidXMNCj4gPiA+ID4gPiBh
bmQgb3duZXIuIChUaGUgbGF0dGVyIGlzIG1pc3NpbmcgaW4gYWxsIGRyaXZlcnMsIHNvIGJ5IHVz
aW5nIHRoZXNlDQo+ID4gPiA+ID4gaGVscGVycyB0aGUgZHJpdmVycyBiZWNvbWUgbW9yZSBjb3Jy
ZWN0LikNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IHYxIG9mIHRoaXMgc2VyaWVzIGlzIGF2YWlsYWJs
ZSBhdA0KPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNzY1NDcy
MTI1LmdpdC51LmtsZWluZS1rb2VuaWdAYmF5bGlicmUuY29tDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIC0gcmViYXNlIHRvIHY2
LjE5LXJjMSAobm8gY29uZmxpY3RzKQ0KPiA+ID4gPiA+ICAtIGFkZCB0YWdzIHJlY2VpdmVkIHNv
IGZhcg0KPiA+ID4gPiA+ICAtIGZpeCB3aGl0ZXNwYWNlIGlzc3VlcyBwb2ludGVkIG91dCBieSBT
dW1pdCBHYXJnDQo+ID4gPiA+ID4gIC0gZml4IHNodXRkb3duIGNhbGxiYWNrIHRvIHNodXRkb3du
IGFuZCBub3QgcmVtb3ZlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBcyBhbHJlYWR5IG5vdGVkIGlu
IHYxJ3MgY292ZXIgbGV0dGVyLCB0aGlzIHNlcmllcyBzaG91bGQgZ28gaW4gZHVyaW5nIGENCj4g
PiA+ID4gPiBzaW5nbGUgbWVyZ2Ugd2luZG93IGFzIHRoZXJlIGFyZSBydW50aW1lIHdhcm5pbmdz
IHdoZW4gdGhlIHNlcmllcyBpcw0KPiA+ID4gPiA+IG9ubHkgYXBwbGllZCBwYXJ0aWFsbHkuIFN1
bWl0IEdhcmcgc3VnZ2VzdGVkIHRvIGFwcGx5IHRoZSB3aG9sZSBzZXJpZXMNCj4gPiA+ID4gPiB2
aWEgSmVucyBXaWtsYW5kZXIncyB0cmVlLg0KPiA+ID4gPiA+IElmIHRoaXMgaXMgZG9uZSB0aGUg
ZGVwZW5kZW5jaWVzIGluIHRoaXMgc2VyaWVzIGFyZSBob25vcmVkLCBpbiBjYXNlIHRoZQ0KPiA+
ID4gPiA+IHBsYW4gY2hhbmdlczogUGF0Y2hlcyAjNCAtICMxNyBkZXBlbmQgb24gdGhlIGZpcnN0
IHR3by4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE5vdGUgdGhpcyBzZXJpZXMgaXMgb25seSBidWls
ZCB0ZXN0ZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBVd2UgS2xlaW5lLUvDtm5pZyAoMTcpOg0K
PiA+ID4gPiA+ICAgdGVlOiBBZGQgc29tZSBoZWxwZXJzIHRvIHJlZHVjZSBib2lsZXJwbGF0ZSBm
b3IgdGVlIGNsaWVudCBkcml2ZXJzDQo+ID4gPiA+ID4gICB0ZWU6IEFkZCBwcm9iZSwgcmVtb3Zl
IGFuZCBzaHV0ZG93biBidXMgY2FsbGJhY2tzIHRvIHRlZV9jbGllbnRfZHJpdmVyDQo+ID4gPiA+
ID4gICB0ZWU6IEFkYXB0IGRvY3VtZW50YXRpb24gdG8gY292ZXIgcmVjZW50IGFkZGl0aW9ucw0K
PiA+ID4gPiA+ICAgaHdybmc6IG9wdGVlIC0gTWFrZSB1c2Ugb2YgbW9kdWxlX3RlZV9jbGllbnRf
ZHJpdmVyKCkNCj4gPiA+ID4gPiAgIGh3cm5nOiBvcHRlZSAtIE1ha2UgdXNlIG9mIHRlZSBidXMg
bWV0aG9kcw0KPiA+ID4gPiA+ICAgcnRjOiBvcHRlZTogTWlncmF0ZSB0byB1c2UgdGVlIHNwZWNp
ZmljIGRyaXZlciByZWdpc3RyYXRpb24gZnVuY3Rpb24NCj4gPiA+ID4gPiAgIHJ0Yzogb3B0ZWU6
IE1ha2UgdXNlIG9mIHRlZSBidXMgbWV0aG9kcw0KPiA+ID4gPiA+ICAgZWZpOiBzdG1tOiBNYWtl
IHVzZSBvZiBtb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIoKQ0KPiA+ID4gPiA+ICAgZWZpOiBzdG1t
OiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCj4gPiA+ID4gPiAgIGZpcm13YXJlOiBhcm1f
c2NtaTogb3B0ZWU6IE1ha2UgdXNlIG9mIG1vZHVsZV90ZWVfY2xpZW50X2RyaXZlcigpDQo+ID4g
PiA+ID4gICBmaXJtd2FyZTogYXJtX3NjbWk6IE1ha2UgdXNlIG9mIHRlZSBidXMgbWV0aG9kcw0K
PiA+ID4gPiA+ICAgZmlybXdhcmU6IHRlZV9ibnh0OiBNYWtlIHVzZSBvZiBtb2R1bGVfdGVlX2Ns
aWVudF9kcml2ZXIoKQ0KPiA+ID4gPiA+ICAgZmlybXdhcmU6IHRlZV9ibnh0OiBNYWtlIHVzZSBv
ZiB0ZWUgYnVzIG1ldGhvZHMNCj4gPiA+ID4gPiAgIEtFWVM6IHRydXN0ZWQ6IE1pZ3JhdGUgdG8g
dXNlIHRlZSBzcGVjaWZpYyBkcml2ZXIgcmVnaXN0cmF0aW9uDQo+ID4gPiA+ID4gICAgIGZ1bmN0
aW9uDQo+ID4gPiA+ID4gICBLRVlTOiB0cnVzdGVkOiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhv
ZHMNCj4gPiA+ID4gPiAgIHRwbS90cG1fZnRwbV90ZWU6IE1ha2UgdXNlIG9mIHRlZSBzcGVjaWZp
YyBkcml2ZXIgcmVnaXN0cmF0aW9uDQo+ID4gPiA+ID4gICB0cG0vdHBtX2Z0cG1fdGVlOiBNYWtl
IHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICBEb2N1bWVudGF0
aW9uL2RyaXZlci1hcGkvdGVlLnJzdCAgICAgICAgICAgICB8IDE4ICstLS0tDQo+ID4gPiA+ID4g
IGRyaXZlcnMvY2hhci9od19yYW5kb20vb3B0ZWUtcm5nLmMgICAgICAgICAgIHwgMjYgKystLS0t
DQo+ID4gPiA+ID4gIGRyaXZlcnMvY2hhci90cG0vdHBtX2Z0cG1fdGVlLmMgICAgICAgICAgICAg
IHwgMzEgKysrKystLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS90cmFu
c3BvcnRzL29wdGVlLmMgfCAzMiArKystLS0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL2Zpcm13YXJl
L2Jyb2FkY29tL3RlZV9ibnh0X2Z3LmMgICAgICB8IDMwICsrLS0tLS0NCj4gPiA+ID4gPiAgZHJp
dmVycy9maXJtd2FyZS9lZmkvc3RtbS90ZWVfc3RtbV9lZmkuYyAgICAgfCAyNSArKy0tLS0NCj4g
PiA+ID4gPiAgZHJpdmVycy9ydGMvcnRjLW9wdGVlLmMgICAgICAgICAgICAgICAgICAgICAgfCAy
NyArKy0tLS0tDQo+ID4gPiA+ID4gIGRyaXZlcnMvdGVlL3RlZV9jb3JlLmMgICAgICAgICAgICAg
ICAgICAgICAgIHwgODQgKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAgaW5jbHVkZS9s
aW51eC90ZWVfZHJ2LmggICAgICAgICAgICAgICAgICAgICAgfCAxMiArKysNCj4gPiA+ID4gPiAg
c2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF90ZWUuYyAgICAgfCAxNyArKy0tDQo+
ID4gPiA+ID4gIDEwIGZpbGVzIGNoYW5nZWQsIDE2NCBpbnNlcnRpb25zKCspLCAxMzggZGVsZXRp
b25zKC0pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBiYXNlLWNvbW1pdDogOGYwYjRjY2U0NDgxZmIy
MjY1MzY5N2NjZWQ4ZDBkMDQwMjdjYjFlOA0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gMi40Ny4z
DQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmsgeW91IGZvciB0aGUgbmljZSBjbGVh
bnVwLCBVd2UuDQo+ID4gPiA+DQo+ID4gPiA+IEkndmUgYXBwbGllZCBwYXRjaCAxLTMgdG8gdGhl
IGJyYW5jaCB0ZWVfYnVzX2NhbGxiYWNrX2Zvcl82LjIwIGluIG15DQo+ID4gPiA+IHRyZWUgYXQg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvamVuc3dpL2xp
bnV4LXRlZS5naXQvDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBicmFuY2ggaXMgYmFzZWQgb24gdjYu
MTktcmMxLCBhbmQgSSdsbCB0cnkgdG8ga2VlcCBpdCBzdGFibGUgZm9yDQo+ID4gPiA+IG90aGVy
cyB0byBkZXBlbmQgb24sIGlmIG5lZWRlZC4gTGV0J3Mgc2VlIGlmIHdlIGNhbiBhZ3JlZSBvbiB0
YWtpbmcNCj4gPiA+ID4gdGhlIHJlbWFpbmluZyBwYXRjaGVzIHZpYSB0aGF0IGJyYW5jaC4NCj4g
PiA+DQo+ID4gPiA2IGFuZCA3IGNhbiBnbyB0aHJvdWdoIHlvdXIgYnJhbmNoLg0KPiA+DQo+ID4g
R29vZCwgSSd2ZSBhZGRlZCB0aGVtIHRvIG15IGJyYW5jaCBub3cuDQo+IA0KPiBUaGlzIGVudGly
ZSBwYXRjaCBzZXQgc2hvdWxkIGdvIGluIGR1cmluZyBhIHNpbmdsZSBtZXJnZSB3aW5kb3cuIEkN
Cj4gd2lsbCBub3Qgc2VuZCBhbnkgcHVsbCByZXF1ZXN0IHVudGlsIEknbSBzdXJlIGFsbCBwYXRj
aGVzIHdpbGwgYmUNCj4gbWVyZ2VkLg0KPiANCj4gU28gZmFyIChpZiBJJ20gbm90IG1pc3Rha2Vu
KSwgb25seSB0aGUgcGF0Y2hlcyBJJ3ZlIGFscmVhZHkgYWRkZWQgdG8NCj4gbmV4dCBoYXZlIGFw
cGVhcmVkIG5leHQuIEkgY2FuIHRha2UgdGhlIHJlc3Qgb2YgdGhlIHBhdGNoZXMsIHRvbywgYnV0
DQo+IEkgbmVlZCBPSyBmb3IgdGhlIGZvbGxvd2luZzoNCj4gDQoNClsuLi5dDQoNCj4gDQo+IFN1
ZGVlcCwgeW91IHNlZW0gaGFwcHkgd2l0aCB0aGUgZm9sbG93aW5nIHBhdGNoZXMNCj4gLSBmaXJt
d2FyZTogYXJtX3NjbWk6IG9wdGVlOiBNYWtlIHVzZSBvZiBtb2R1bGVfdGVlX2NsaWVudF9kcml2
ZXIoKQ0KPiAtIGZpcm13YXJlOiBhcm1fc2NtaTogTWFrZSB1c2Ugb2YgdGVlIGJ1cyBtZXRob2Rz
DQo+IE9LIGlmIEkgdGFrZSB0aGVtIHZpYSBteSB0cmVlLCBvciB3b3VsZCB5b3UgcmF0aGVyIHRh
a2UgdGhlbSB5b3Vyc2VsZj8NCj4NCg0KSSBhbSBoYXBweSBpZiB5b3Ugd2FudCB0byB0YWtlIGFs
bCBvZiB0aGVtIGluIG9uZSBnby4gSSB0aGluayBJIGhhdmUNCmFscmVhZHkgYWNrZWQgaXQuIFBs
ZWFzZSBzaG91dCBpZiB5b3UgbmVlZCBhbnl0aGluZyBlbHNlIGZyb20gbWUsIGhhcHB5IHRvDQpo
ZWxwIGluIGFueXdheSB0byBtYWtlIGl0IGVhc2llciB0byBoYW5kbGUgdGhpcyBjaGFuZ2Ugc2V0
Lg0KDQotLSANClJlZ2FyZHMsDQpTdWRlZXANCg==
