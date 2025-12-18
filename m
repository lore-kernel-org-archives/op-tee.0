Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A204CD6D229
	for <op-tee@archiver.kernel.org>; Thu, 18 Dec 2025 13:54:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E1E5B4FF51
	for <op-tee@archiver.kernel.org>; Thu, 18 Dec 2025 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1766066049;
	bh=t3hf3YPTu6zJGKO1gvGW7TV05+IxAjOuZl3GtrCStvI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=4wPQchabRNJT5jvH3B0HHsbFETFaUIGgpVX+DNwHc4hewI0R+rvcYbPM9j8N3XdzP
	 S01dsDE1apXIf9l8hRCe9ikG9pMZ5xpK3/8P8OlmQYfnMcM8D4CeoLBwIEyVB1ePxi
	 MxzfbFmmvn2l4iJ0KQi6eufq8EuT3klor5WSdbgD3J4R21NjNYzWxtHvKVLEbCxUgQ
	 9+RY3Igj3NjoHTQ0iZXhgAODpavM5y2gAyO56k72ObYidCiommTkmxWZJZLM/QFMaq
	 a9GhSw6S2cw1Fb5MDNEdiU4bLqEnONj2AcJew49vZyBUTK9SRr3ux4fqPFRn/q1s/L
	 AEb9jN4u+rzsg==
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 06C0C4FF3D
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Dec 2025 13:53:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qFohZZY8;
	dkim-atps=neutral
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DECB91A22CD;
	Thu, 18 Dec 2025 13:53:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4BEE606B6;
	Thu, 18 Dec 2025 13:53:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66249102F0B2D;
	Thu, 18 Dec 2025 14:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766066026; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RhgSGQYStNGcdPoB3dTlM/CB5TE2tva/NS/z3ptd3wM=;
	b=qFohZZY8adtmwbRo28+tcgXOIuD5T9ZV6GmStiiS0ZAEXQPvVe9Zcnoe53YsCQv7j9c1kT
	pTrvVf3pcUkunP7HW/oQvdBg/Lk3nsGsCiYCx3SHIHn49cINe+SDypYYTUNdpwsJxK0JVh
	ocSroqcU2Nk7str55AMgKkPgbWDRxk2+yhvbttnAqOzQlGRqdP2i4+xde+ODjyK3Zpm5be
	ZSBh2N3dOdtUob6QOjlSHuVExl0oaNjoD8HBgFGaCPqRDPAFBwnRVvZxfM0UXeEISM/0Op
	YG/ULfUWn7tCLkV8LWmaP9dHfiDTFdsnlQ2sM6hNfJi3OczZvwptkZvMOkvVJQ==
Date: Thu, 18 Dec 2025 14:53:32 +0100
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver
 callbacks
Message-ID: <20251218135332f323fa91@mail.local>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:185.246.84.56];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:21409, ipnet:185.246.84.0/22, country:FR];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,lwn.net,kernel.org,selenic.com,gondor.apana.org.au,bootlin.com,gmail.com,foss.st.com,oss.qualcomm.com,linaro.org,siemens.com,arm.com,wanadoo.fr,broadcom.com,hansenpartnership.com,linux.ibm.com,redhat.com,paul-moore.com,namei.org,hallyn.com,gmx.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,ziepe.ca];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[212.83.136.155:received,212.83.139.233:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 06C0C4FF3D
X-Spamd-Bar: --
Message-ID-Hash: MNUOGDZA7UXHOSQM3JO7CPY5JMMCZAWQ
X-Message-ID-Hash: MNUOGDZA7UXHOSQM3JO7CPY5JMMCZAWQ
X-MailFrom: alexandre.belloni@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Sudeep Holla <sudeep.holla@arm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
  "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MNUOGDZA7UXHOSQM3JO7CPY5JMMCZAWQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Alexandre Belloni via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Alexandre Belloni <alexandre.belloni@bootlin.com>

T24gMTgvMTIvMjAyNSAwODoyMToyNyswMTAwLCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gSGks
DQo+IA0KPiBPbiBNb24sIERlYyAxNSwgMjAyNSBhdCAzOjE34oCvUE0gVXdlIEtsZWluZS1Lw7Zu
aWcNCj4gPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGVs
bG8sDQo+ID4NCj4gPiB0aGUgb2JqZWN0aXZlIG9mIHRoaXMgc2VyaWVzIGlzIHRvIG1ha2UgdGVl
IGRyaXZlciBzdG9wIHVzaW5nIGNhbGxiYWNrcw0KPiA+IGluIHN0cnVjdCBkZXZpY2VfZHJpdmVy
LiBUaGVzZSB3ZXJlIHN1cGVyc2VkZWQgYnkgYnVzIG1ldGhvZHMgaW4gMjAwNg0KPiA+IChjb21t
aXQgNTk0YzgyODFmOTA1ICgiW1BBVENIXSBBZGQgYnVzX3R5cGUgcHJvYmUsIHJlbW92ZSwgc2h1
dGRvd24NCj4gPiBtZXRob2RzLiIpKSBidXQgbm9ib2R5IGNhcmVkIHRvIGNvbnZlcnQgYWxsIHN1
YnN5c3RlbXMgYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBIZXJlIHRoZSB0ZWUgZHJpdmVycyBhcmUg
Y29udmVydGVkLiBUaGUgZmlyc3QgY29tbWl0IGlzIHNvbWV3aGF0DQo+ID4gdW5yZWxhdGVkLCBi
dXQgc2ltcGxpZmllcyB0aGUgY29udmVyc2lvbiAoYW5kIHRoZSBkcml2ZXJzKS4gSXQNCj4gPiBp
bnRyb2R1Y2VzIGRyaXZlciByZWdpc3RyYXRpb24gaGVscGVycyB0aGF0IGNhcmUgYWJvdXQgc2V0
dGluZyB0aGUgYnVzDQo+ID4gYW5kIG93bmVyLiAoVGhlIGxhdHRlciBpcyBtaXNzaW5nIGluIGFs
bCBkcml2ZXJzLCBzbyBieSB1c2luZyB0aGVzZQ0KPiA+IGhlbHBlcnMgdGhlIGRyaXZlcnMgYmVj
b21lIG1vcmUgY29ycmVjdC4pDQo+ID4NCj4gPiB2MSBvZiB0aGlzIHNlcmllcyBpcyBhdmFpbGFi
bGUgYXQNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvY292ZXIuMTc2NTQ3MjEyNS5n
aXQudS5rbGVpbmUta29lbmlnQGJheWxpYnJlLmNvbQ0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5jZSB2
MToNCj4gPg0KPiA+ICAtIHJlYmFzZSB0byB2Ni4xOS1yYzEgKG5vIGNvbmZsaWN0cykNCj4gPiAg
LSBhZGQgdGFncyByZWNlaXZlZCBzbyBmYXINCj4gPiAgLSBmaXggd2hpdGVzcGFjZSBpc3N1ZXMg
cG9pbnRlZCBvdXQgYnkgU3VtaXQgR2FyZw0KPiA+ICAtIGZpeCBzaHV0ZG93biBjYWxsYmFjayB0
byBzaHV0ZG93biBhbmQgbm90IHJlbW92ZQ0KPiA+DQo+ID4gQXMgYWxyZWFkeSBub3RlZCBpbiB2
MSdzIGNvdmVyIGxldHRlciwgdGhpcyBzZXJpZXMgc2hvdWxkIGdvIGluIGR1cmluZyBhDQo+ID4g
c2luZ2xlIG1lcmdlIHdpbmRvdyBhcyB0aGVyZSBhcmUgcnVudGltZSB3YXJuaW5ncyB3aGVuIHRo
ZSBzZXJpZXMgaXMNCj4gPiBvbmx5IGFwcGxpZWQgcGFydGlhbGx5LiBTdW1pdCBHYXJnIHN1Z2dl
c3RlZCB0byBhcHBseSB0aGUgd2hvbGUgc2VyaWVzDQo+ID4gdmlhIEplbnMgV2lrbGFuZGVyJ3Mg
dHJlZS4NCj4gPiBJZiB0aGlzIGlzIGRvbmUgdGhlIGRlcGVuZGVuY2llcyBpbiB0aGlzIHNlcmll
cyBhcmUgaG9ub3JlZCwgaW4gY2FzZSB0aGUNCj4gPiBwbGFuIGNoYW5nZXM6IFBhdGNoZXMgIzQg
LSAjMTcgZGVwZW5kIG9uIHRoZSBmaXJzdCB0d28uDQo+ID4NCj4gPiBOb3RlIHRoaXMgc2VyaWVz
IGlzIG9ubHkgYnVpbGQgdGVzdGVkLg0KPiA+DQo+ID4gVXdlIEtsZWluZS1Lw7ZuaWcgKDE3KToN
Cj4gPiAgIHRlZTogQWRkIHNvbWUgaGVscGVycyB0byByZWR1Y2UgYm9pbGVycGxhdGUgZm9yIHRl
ZSBjbGllbnQgZHJpdmVycw0KPiA+ICAgdGVlOiBBZGQgcHJvYmUsIHJlbW92ZSBhbmQgc2h1dGRv
d24gYnVzIGNhbGxiYWNrcyB0byB0ZWVfY2xpZW50X2RyaXZlcg0KPiA+ICAgdGVlOiBBZGFwdCBk
b2N1bWVudGF0aW9uIHRvIGNvdmVyIHJlY2VudCBhZGRpdGlvbnMNCj4gPiAgIGh3cm5nOiBvcHRl
ZSAtIE1ha2UgdXNlIG9mIG1vZHVsZV90ZWVfY2xpZW50X2RyaXZlcigpDQo+ID4gICBod3JuZzog
b3B0ZWUgLSBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCj4gPiAgIHJ0Yzogb3B0ZWU6IE1p
Z3JhdGUgdG8gdXNlIHRlZSBzcGVjaWZpYyBkcml2ZXIgcmVnaXN0cmF0aW9uIGZ1bmN0aW9uDQo+
ID4gICBydGM6IG9wdGVlOiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCj4gPiAgIGVmaTog
c3RtbTogTWFrZSB1c2Ugb2YgbW9kdWxlX3RlZV9jbGllbnRfZHJpdmVyKCkNCj4gPiAgIGVmaTog
c3RtbTogTWFrZSB1c2Ugb2YgdGVlIGJ1cyBtZXRob2RzDQo+ID4gICBmaXJtd2FyZTogYXJtX3Nj
bWk6IG9wdGVlOiBNYWtlIHVzZSBvZiBtb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIoKQ0KPiA+ICAg
ZmlybXdhcmU6IGFybV9zY21pOiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCj4gPiAgIGZp
cm13YXJlOiB0ZWVfYm54dDogTWFrZSB1c2Ugb2YgbW9kdWxlX3RlZV9jbGllbnRfZHJpdmVyKCkN
Cj4gPiAgIGZpcm13YXJlOiB0ZWVfYm54dDogTWFrZSB1c2Ugb2YgdGVlIGJ1cyBtZXRob2RzDQo+
ID4gICBLRVlTOiB0cnVzdGVkOiBNaWdyYXRlIHRvIHVzZSB0ZWUgc3BlY2lmaWMgZHJpdmVyIHJl
Z2lzdHJhdGlvbg0KPiA+ICAgICBmdW5jdGlvbg0KPiA+ICAgS0VZUzogdHJ1c3RlZDogTWFrZSB1
c2Ugb2YgdGVlIGJ1cyBtZXRob2RzDQo+ID4gICB0cG0vdHBtX2Z0cG1fdGVlOiBNYWtlIHVzZSBv
ZiB0ZWUgc3BlY2lmaWMgZHJpdmVyIHJlZ2lzdHJhdGlvbg0KPiA+ICAgdHBtL3RwbV9mdHBtX3Rl
ZTogTWFrZSB1c2Ugb2YgdGVlIGJ1cyBtZXRob2RzDQo+ID4NCj4gPiAgRG9jdW1lbnRhdGlvbi9k
cml2ZXItYXBpL3RlZS5yc3QgICAgICAgICAgICAgfCAxOCArLS0tLQ0KPiA+ICBkcml2ZXJzL2No
YXIvaHdfcmFuZG9tL29wdGVlLXJuZy5jICAgICAgICAgICB8IDI2ICsrLS0tLQ0KPiA+ICBkcml2
ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jICAgICAgICAgICAgICB8IDMxICsrKysrLS0tDQo+
ID4gIGRyaXZlcnMvZmlybXdhcmUvYXJtX3NjbWkvdHJhbnNwb3J0cy9vcHRlZS5jIHwgMzIgKysr
LS0tLS0NCj4gPiAgZHJpdmVycy9maXJtd2FyZS9icm9hZGNvbS90ZWVfYm54dF9mdy5jICAgICAg
fCAzMCArKy0tLS0tDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUvZWZpL3N0bW0vdGVlX3N0bW1fZWZp
LmMgICAgIHwgMjUgKystLS0tDQo+ID4gIGRyaXZlcnMvcnRjL3J0Yy1vcHRlZS5jICAgICAgICAg
ICAgICAgICAgICAgIHwgMjcgKystLS0tLQ0KPiA+ICBkcml2ZXJzL3RlZS90ZWVfY29yZS5jICAg
ICAgICAgICAgICAgICAgICAgICB8IDg0ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1
ZGUvbGludXgvdGVlX2Rydi5oICAgICAgICAgICAgICAgICAgICAgIHwgMTIgKysrDQo+ID4gIHNl
Y3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfdGVlLmMgICAgIHwgMTcgKystLQ0KPiA+
ICAxMCBmaWxlcyBjaGFuZ2VkLCAxNjQgaW5zZXJ0aW9ucygrKSwgMTM4IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gYmFzZS1jb21taXQ6IDhmMGI0Y2NlNDQ4MWZiMjI2NTM2OTdjY2VkOGQwZDA0MDI3
Y2IxZTgNCj4gPiAtLQ0KPiA+IDIuNDcuMw0KPiA+DQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBu
aWNlIGNsZWFudXAsIFV3ZS4NCj4gDQo+IEkndmUgYXBwbGllZCBwYXRjaCAxLTMgdG8gdGhlIGJy
YW5jaCB0ZWVfYnVzX2NhbGxiYWNrX2Zvcl82LjIwIGluIG15DQo+IHRyZWUgYXQgaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvamVuc3dpL2xpbnV4LXRlZS5n
aXQvDQo+IA0KPiBUaGUgYnJhbmNoIGlzIGJhc2VkIG9uIHY2LjE5LXJjMSwgYW5kIEknbGwgdHJ5
IHRvIGtlZXAgaXQgc3RhYmxlIGZvcg0KPiBvdGhlcnMgdG8gZGVwZW5kIG9uLCBpZiBuZWVkZWQu
IExldCdzIHNlZSBpZiB3ZSBjYW4gYWdyZWUgb24gdGFraW5nDQo+IHRoZSByZW1haW5pbmcgcGF0
Y2hlcyB2aWEgdGhhdCBicmFuY2guDQoNCjYgYW5kIDcgY2FuIGdvIHRocm91Z2ggeW91ciBicmFu
Y2guDQoNCi0tIA0KQWxleGFuZHJlIEJlbGxvbmksIGNvLW93bmVyIGFuZCBDT08sIEJvb3RsaW4N
CkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCmh0dHBzOi8vYm9vdGxpbi5j
b20NCg==
