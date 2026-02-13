Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB7CEDF150
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 11:42:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 32EEB4380F
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 11:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770982935;
	bh=GSlgafn5tOqfdfgT4y2AB1Bzu4VSNslqoTjyG5BL2dA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Pzs/FCa0lNQyh7rQL0dwtctGSuXmZHiqCWlsEmDfqT7FeZa36GE7QzEJD85jQrKxc
	 J6PduEJKc+rb/puNV2qFdvQb3t2lz+OcgAiKIrIGBf7sdYCfcgJeWBIn7IPHvie8jO
	 L70u/yLWeqZpRkFD8hHNf5TA6O4wmts8XrXLl274sChtTa05Mv5SlrgPADn4f+g6WB
	 HuPiL0d6gBlNjjodpnEgXJAYKyoSYpqxG7kvMhncVk8QyTu5sRCIGjIsT2FUUeIKks
	 LaZkI1zy5tXmISx68J7HU911joqT7/HIw4zs/lnsgc+TEU5flt4YsMC+lOWXWzWwvZ
	 pN7uImTteoaeA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 860A743149
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 11:41:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KQTI1b3u;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EBDC76001A;
	Fri, 13 Feb 2026 11:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6D6C116C6;
	Fri, 13 Feb 2026 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770982914;
	bh=//FUPQtiHgkA6+8ggCTux5TUR6pLkT0fZp0gFDq5xRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQTI1b3u0Q4pyuXy0AQhK+daoEjRVYcgNTOfFMrdfdZ/HhxV617xG2c28/P8pq1D9
	 iD6Nks4akO4w62sa5jNdbS1F3SbFTTRPizMUdXq1cLYFHPAp4bKBlvjlTaRgILYdoP
	 yr2bOqqRtlh5pbgCIlnuOlrak4uvTjq6VUbgw+bWGAJs7gDbZSS9Oz80rWkzus5pmr
	 LQ9t52v1iig1a0ANoVlL58TPaRATwVW6B4fAuR0VCVM7Pqsk8YrSNBf9BzttKJ4j+v
	 UDPatfhhstyabt8VHBDQo07Uu8TWw2eXjm5ROfA4Slm+pmClEI6C7f5EzgQt3ZOw6D
	 zYN4e8eHOIZ7w==
Date: Fri, 13 Feb 2026 17:11:43 +0530
To: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <aY8N90jMp25bBZhi@sumit-xelite>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
 <20260212125830.jfwos3flga2l5uwk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <20260212125830.jfwos3flga2l5uwk@pengutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,infradead.org,suse.cz,linux-foundation.org,pengutronix.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com,foss.st.com,siemens.com];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 860A743149
X-Spamd-Bar: -
Message-ID-Hash: Q4UJLQVJDO4QYOGFLYYH762IFM5DIE4N
X-Message-ID-Hash: Q4UJLQVJDO4QYOGFLYYH762IFM5DIE4N
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz, akpm@linux-foundation.org, kernel@pengutronix.de, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com, masahisa.kojima@linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Q4UJLQVJDO4QYOGFLYYH762IFM5DIE4N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

SGkgTWFyY28sDQoNCk9uIFRodSwgRmViIDEyLCAyMDI2IGF0IDAxOjU4OjMwUE0gKzAxMDAsIE1h
cmNvIEZlbHNjaCB3cm90ZToNCj4gSGkgU3VtaXQsDQo+IA0KPiBUQkg6IEkgd2FzIGhvcGluZyB0
aGF0IHlvdSB3aWxsIHRha2UgY2FyZSBvZiB0aGlzIHNpbmNlIHlvdSdyZSBtYXJrZWQgYXMNCj4g
bWFpbnRhaW5lciBmb3IgdGhlIHRlZS10cnVzdGVkLWtleSBhbmQgd2Ugbm90aWNlZCB0aGUgd2Fy
bmluZyB3aXRoIDYuMTQNCj4gYW5kIHN0aWxsIG5vIGZpeCBhdmFpbGFibGUgOi8NCg0KTWF0aGV3
IGRpZCBzdWdnZXN0ZWQgYSBmaXggbG9uZyBiYWNrIG9uIHdoaWNoIGV2ZXJ5Ym9keSBhZ3JlZWQg
YnV0DQpkaWRuJ3QgZ290IGVub3VnaCBhdHRlbnRpb24gZnJvbSB5b3UgdG8gdGVzdCBhbmQgcmVw
b3J0IGlmIHRoYXQgZml4ZWQNCnlvdXIgaXNzdWUuIFNpbmNlIHlvdSBpbnNpc3RlZCBmdXJ0aGVy
LCBJIGhhdmUgY3JlYXRlZCBhIGZvcm1hbCBmaXgNCnBhdGNoIGJhc2VkIG9uIHRoYXQgaGVyZSBb
MV0uIENhcmUgdG8gdGVzdCB0aGF0Pw0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjYwMjEzMTEzMzE3LjE3Mjg3NjktMS1zdW1pdC5nYXJnQGtlcm5lbC5vcmcvDQoNCj4gDQo+
IEhvd2V2ZXIgcGxlYXNlIHNlZSBiZWxvdyBmb3IgZnVydGhlciBkaXNjdXNzaW9uLg0KPiANCj4g
T24gMjUtMDQtMjgsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiA+IE9uIFRodSwgTWFyIDI3LCAy
MDI1IGF0IDU6NDLigK9BTSBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGtlcm5lbC5vcmc+IHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgTWFyIDI2LCAyMDI1IGF0IDAyOjQ3OjQ2UE0gKzAxMDAs
IEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIE1hciAyNiwgMjAyNSBhdCAx
MjowN+KAr1BNIE1hcmNvIEZlbHNjaCA8bS5mZWxzY2hAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gMjUtMDMtMjYsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0K
PiA+ID4gPiA+ID4gT24gVHVlLCBNYXIgMjUsIDIwMjUgYXQgMDk6MDc6MzlQTSArMDEwMCwgTWFy
Y28gRmVsc2NoIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBTa2lwIG1hbmlwdWxhdGluZyB0aGUgcmVm
Y291bnQgaW4gY2FzZSBvZiBzbGFiIHBhZ2VzIGFjY29yZGluZyBjb21taXQNCj4gPiA+ID4gPiA+
ID4gYjljMGU0OWFiZmNhICgibW06IGRlY2xpbmUgdG8gbWFuaXB1bGF0ZSB0aGUgcmVmY291bnQg
b24gYSBzbGFiIHBhZ2UiKS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIGFsbW9zdCBj
ZXJ0YWlubHkgaXNuJ3QgcmlnaHQuICBJIGtub3cgbm90aGluZyBhYm91dCBURUUsIGJ1dCB0aGF0
DQo+ID4gPiA+ID4gPiB5b3UgYXJlIGRvaW5nIHRoaXMgaW5kaWNhdGVzIGEgcHJvYmxlbS4gIFRo
ZSBoYWNrIHRoYXQgd2UgcHV0IGludG8NCj4gPiA+ID4gPiA+IG5ldHdvcmtpbmcgc2hvdWxkIG5v
dCBiZSBibGluZGx5IHJlcGxpY2F0ZWQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gV2h5IGFy
ZSB5b3UgdGFraW5nIGEgcmVmZXJlbmNlIG9uIHRoZSBwYWdlcyB0byBiZWdpbiB3aXRoPyAgSXMg
aXQgY29weQ0KPiA+ID4gPiA+ID4gYW5kIHBhc3RlZCBmcm9tIHNvbWV3aGVyZSBlbHNlLCBvciB3
YXMgdGhlcmUgYWN0dWFsIHRob3VnaHQgcHV0IGludG8gaXQ/DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBOb3Qgc3VyZSwgdGhpcyBiZWxvbmdzIHRvIHRoZSBURUUgbWFpbnRhaW5lcnMuDQo+ID4gPiA+
DQo+ID4gPiA+IEkgZG9uJ3Qga25vdy4gV2Ugd2VyZSBnZXR0aW5nIHRoZSB1c2VyIHBhZ2VzIGZp
cnN0LCBzbyBJIGFzc3VtZSB3ZQ0KPiA+ID4gPiBqdXN0IGRpZCB0aGUgc2FtZSB0aGluZyB3aGVu
IHdlIGFkZGVkIHN1cHBvcnQgZm9yIGtlcm5lbCBwYWdlcy4NCj4gPiA+ID4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gSWYgaXQncyAicHJldmVudCB0aGUgY2FsbGVyIGZyb20gZnJlZWluZyB0aGUg
YWxsb2NhdGlvbiIsIHdlbGwsIGl0IG5ldmVyDQo+ID4gPiA+ID4gPiBhY2NvbXBsaXNoZWQgdGhh
dCB3aXRoIHNsYWIgYWxsb2NhdGlvbnMuICBTbyBmb3IgY2FsbGVycyB0aGF0IGRvIGttYWxsb2MN
Cj4gPiA+ID4gPiA+IChlZyBzZXR1cF9tbV9oZHIoKSAgaW4gZHJpdmVycy9maXJtd2FyZS9lZmkv
c3RtbS90ZWVfc3RtbV9lZmkuYyksIHlvdQ0KPiA+ID4gPiA+ID4gaGF2ZSB0byByZWx5IG9uIHRo
ZW0gbm90IGZyZWVpbmcgdGhlIGFsbG9jYXRpb24gd2hpbGUgdGhlIFRFRSBkcml2ZXINCj4gPiA+
ID4gPiA+IGhhcyBpdC4NCj4gPiA+DQo+ID4gPiBJdCdzIG5vdCBqdXN0IGFib3V0IHRoZSBURUUg
ZHJpdmVyIGJ1dCByYXRoZXIgaWYgdGhlIFRFRSBpbXBsZW1lbnRhdGlvbg0KPiA+ID4gKGEgdHJ1
c3RlZCBPUykgdG8gd2hvbSB0aGUgcGFnZSBpcyByZWdpc3RlcmVkIHdpdGguIFdlIGRvbid0IHdh
bnQgdGhlDQo+ID4gPiB0cnVzdGVkIE9TIHRvIHdvcmsgb24gcmVnaXN0ZXJlZCBrZXJuZWwgcGFn
ZXMgaWYgdGhleSBnZXRzIGZyZWUgc29tZWhvdw0KPiA+ID4gaW4gdGhlIFRFRSBjbGllbnQgZHJp
dmVyLiBIYXZpbmcgYSByZWZlcmVuY2UgaW4gdGhlIFRFRSBzdWJzeXN0ZW0NCj4gPiA+IGFzc3Vy
ZWQgdXMgdGhhdCB3b24ndCBoYXBwZW4uIEJ1dCBpZiB5b3Ugc2F5IHNsYWIgYWxsb2NhdGlvbnMg
YXJlIHN0aWxsDQo+ID4gPiBwcm9uZSB0aGUga2VybmVsIHBhZ2VzIGdldHRpbmcgZnJlZWQgZXZl
biBhZnRlciByZWZjb3VudCB0aGVuIGNhbiB5b3UNCj4gPiA+IHN1Z2dlc3QgaG93IHNob3VsZCB3
ZSBoYW5kbGUgdGhpcyBiZXR0ZXI/DQo+ID4gPg0KPiA+ID4gQXMgb3RoZXJ3aXNlIGl0IGNhbiBj
YXVzZSB2ZXJ5IGhhcmQgdG8gZGVidWcgcHJvYmxlbXMgaWYgdHJ1c3RlZCBPUyBjYW4NCj4gPiA+
IG1hbmlwdWxhdGUga2VybmVsIHBhZ2VzIHRoYXQgYXJlIG5vIGxvbmdlciBhdmFpbGFibGUuDQo+
ID4gDQo+ID4gV2UgbXVzdCBiZSBhYmxlIHRvIHJlbHkgb24gdGhlIGtlcm5lbCBjYWxsZXJzIHRv
IGhhdmUgdGhlIG5lZWRlZA0KPiA+IHJlZmVyZW5jZXMgYmVmb3JlIGNhbGxpbmcgdGVlX3NobV9y
ZWdpc3Rlcl9rZXJuZWxfYnVmKCkgYW5kIHRvIGtlZXANCj4gPiB0aG9zZSB1bnRpbCBhZnRlciBj
YWxsaW5nIHRlZV9zaG1fZnJlZSgpLg0KPiANCj4gSSBjaGVja2VkIHRoZSBjb2RlIG9uY2UgYWdh
aW4gYW5kIGZpZ3VyZWQgdGhhdCB3ZSBjb3VsZCBkcm9wL3JlcGxhY2UNCj4gdGVlX3NobV9yZWdp
c3Rlcl9rZXJuZWxfYnVmKCkgd2l0aCB0ZWVfc2htX2FsbG9jX2tlcm5lbF9idWYoKS4gSSBkb24n
dA0KPiBzZWUgd2h5IGEga2VybmVsIGRyaXZlciBuZWVkcyB0byB0ZWVfc2htX3JlZ2lzdGVyX2tl
cm5lbF9idWYoKSBpbiB0aGUNCj4gZmlyc3QgcGxhY2UsIG1heWJlIHRoaXMgaXMgbGVnYWN5LiBU
aGUgb25seSB1c2VycyBvZg0KPiB0ZWVfc2htX3JlZ2lzdGVyX2tlcm5lbF9idWYoKSBhcmUgdHJ1
c3RlZF90ZWUuYyBhbmQgdGVlX3N0bW1fZWZpLmMuDQoNCk5vIGl0J3Mgbm90IGxlZ2FjeSBidXQg
YWxsb3dzIGZvciBlZmZpY2llbnQgbWVtb3J5IHJldXNlIHdpdGhpbiB0aGUNCmtlcm5lbCBhcyB0
byBub3QgY3JlYXRlIGJvdW5jZSBidWZmZXJzIHRvIHNoYXJlIGRhdGEgd2l0aCBURUUuDQoNCi1T
dW1pdA0KDQo+IA0KPiArQ2MgdGhlIGVmaS1zdG1tIGZvbGtzIHNpbmNlIHRoZXkgd2lsbCBiZSBh
ZmZlY3RlZCBieSB0aGlzIGNoYW5nZSBhcw0KPiB3ZWxsLg0KPiANCj4gUmVnYXJkcywNCj4gICBN
YXJjbw0KPiANCj4gDQo+ID4gPiA+ID4gPiBBbmQgaWYgdGhhdCdzIHlvdXIgQVBJIGNvbnRyYWN0
LCB0aGVuIHRoZXJlJ3Mgbm8gcG9pbnQgaW4gdGFraW5nDQo+ID4gPiA+ID4gPiByZWZjb3VudHMg
b24gb3RoZXIga2luZHMgb2YgcGFnZXMgZWl0aGVyOyBpdCdzIGp1c3QgdW5uZWNlc3NhcnkgYXRv
bWljDQo+ID4gPiA+ID4gPiBpbnN0cnVjdGlvbnMuICBTbyB0aGUgcmlnaHQgcGF0Y2ggbWlnaHQg
YmUgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArKysgYi9k
cml2ZXJzL3RlZS90ZWVfc2htLmMNCj4gPiA+ID4gPiA+IEBAIC0xNSwyOSArMTUsMTEgQEANCj4g
PiA+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvaGlnaG1lbS5oPg0KPiA+ID4gPiA+ID4gICNpbmNs
dWRlICJ0ZWVfcHJpdmF0ZS5oIg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBoYWQgdGhlIHNhbWUg
ZGlmZiBidXQgZGlkbid0IHdlbnQgdGhpcyB3YXkgc2luY2Ugd2UgY2FuJ3QgYmUgc3VyZSB0aGF0
DQo+ID4gPiA+ID4gaW92J3MgYXJlIGFsd2F5cyBzbGFiIGJhY2tlZC4gQXMgZmFyIGFzIEkgdW5k
ZXJzdG9vZCBJT1ZzLiBJbg0KPiA+ID4gPiA+ICd3b3JzdC1jYXNlJyBzY2VuYXJpbyBhbiBpb3Yg
Y2FuIGJlIGJhY2tlZCBieSBkaWZmZXJlbnQgcGFnZSB0eXBlcyB0b28uDQo+ID4gPiA+DQo+ID4g
PiA+IFdlJ3JlIG9ubHkgdXNpbmcga3ZlYydzLiBCcmllZmx5LCBiZWZvcmUgY29tbWl0IDdiZGVl
NDE1NzU5MSAoInRlZToNCj4gPiA+ID4gVXNlIGlvdl9pdGVyIHRvIGJldHRlciBzdXBwb3J0IHNo
YXJlZCBidWZmZXIgcmVnaXN0cmF0aW9uIikgd2UgY2hlY2tlZA0KPiA+ID4gPiB3aXRoIGlzX3Zt
YWxsb2NfYWRkcigpIHx8IGlzX2ttYXBfYWRkcigpLiBJIGxpa2UgTWF0dGhldydzIHN1Z2dlc3Rp
b24sDQo+ID4gPiA+IGl0J3MgbmljZSB0byBmaXggcHJvYmxlbXMgYnkgZGVsZXRpbmcgY29kZS4g
Oi0pDQo+ID4gPiA+DQo+ID4gPiA+IFN1bWl0LCB5b3Uga25vdyB0aGUgY2FsbGVycyBiZXR0ZXIu
IFdoYXQgZG8geW91IHRoaW5rPw0KPiA+ID4NCj4gPiA+IElmIHdlIGRvbid0IGhhdmUgYSBzYW5l
IHdheSB0byByZWZjb250IHJlZ2lzdGVyZWQga2VybmVsIHBhZ2VzIGluIFRFRQ0KPiA+ID4gc3Vi
c3lzdGVtIHRoZW4geWVhaCB3ZSBoYXZlIHRvIHNvbGVseSByZWx5IG9uIHRoZSBjbGllbnQgZHJp
dmVycyB0bw0KPiA+ID4gYmVoYXZlIHByb3Blcmx5LiBOZXZlcnRoZWxlc3MsIGl0J3Mgc3RpbGwg
d2l0aGluIHRoZSBrZXJuZWwgYm91bmRhcmllcw0KPiA+ID4gd2hpY2ggd2UgY2FuIHJlbHkgdXBv
bi4NCj4gPiANCj4gPiBZZXMuDQo+ID4gDQo+ID4gQ2hlZXJzLA0KPiA+IEplbnMNCj4gDQo+IC0t
IA0KPiAjZ2VybnBlckR1IA0KPiAjQ2FsbE1lQnlNeUZpcnN0TmFtZQ0KPiANCj4gUGVuZ3V0cm9u
aXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwNCj4gU3RldWVyd2FsZGVyIFN0ci4gMjEgICAgICAgICAgICAgICAgICAgICAgIHwg
aHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUvIHwNCj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFu
eSAgICAgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10
c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4OiAgICs0OS01MTIx
LTIwNjkxNy05ICAgIHwNCg==
