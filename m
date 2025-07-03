Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60111C77B7C
	for <op-tee@archiver.kernel.org>; Thu,  3 Jul 2025 06:28:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AAA3141AB9
	for <op-tee@archiver.kernel.org>; Thu,  3 Jul 2025 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1751524115;
	bh=Jc03KsCHP5MFa5apY6Qa5F8RoT3/6jVGgO+mXnqC/tE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GTSjjJsQRxBggFiXWBFOtpkzHlkI9wz/1DybaMiDN9my6NJVLRdZBk/O4uZHk/jGQ
	 zD4i+07xj/a1Rl7zI/PSNi8UYlWwctbxVvgF1cw4niLn6C2rKBDdyEUbYjSWEzA0Tp
	 P+6ix02DmcCMKN21cy0xSlmpk6ReufmSKTJG0h9hk5CPyzJZrYdpNypz9xxXUtzsj4
	 l3EFMt9Z4aPI24XbYicaQhNRGbEt1iyelhsE65/2C674ElPY47t9ueuzmjhfKeZEKa
	 QhzZG9tZc3/a22RI61cGh2IRpxypGBI0tEEKXR0Vj2f4PuRDOpuOqMSjUoWaRFW/4s
	 wcL/oHjJKLR+Q==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6FE18409AA
	for <op-tee@lists.trustedfirmware.org>; Thu,  3 Jul 2025 06:28:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uL70UOkq;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C1C3D61142;
	Thu,  3 Jul 2025 06:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16EEC4CEEB;
	Thu,  3 Jul 2025 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751524091;
	bh=T72yXCmWdX5uoyXouBY6LyB4JVY9V6cpBLUYnY5mazQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uL70UOkq3bTbtQc6sV0B15O2BmBs+JKSMF5sViA6FpL5BEFxDRZ2EMCCuGe1EvaaM
	 APZWQiXwZQJcn56XDKHVuOI7rLGD+Xs1E9FreeF9wIQa/PhwbDmEI2TrrmyJAXfJPW
	 Z4SP060V1akKVI83GrwoWWlMtTY2fI8hb8AaPKjyYUNuOivHvr7vDLpkkSxtsGGVQq
	 BsI2UOgEyyShfWxVYe1VW8CodBSutQeeW7mRVA5n+7s/A9ym5TU6fkXMS4V6/NfxKK
	 81RwZTsLAY8ADwAK5VkoPb9oT0b5ELh2S5CI7coneJ4PeHDrPqfaJHCSJxbm9ZVGci
	 O5fq+JWp5PBQA==
Date: Thu, 3 Jul 2025 11:58:01 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v10 6/9] tee: add tee_shm_alloc_dma_mem()
Message-ID: <aGYi8QkgI3WyeN59@sumit-X1>
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-7-jens.wiklander@linaro.org>
 <aFFSWDiVsxA1CbCX@sumit-X1>
 <CAHUa44HP5EbURyLCmawMLc0d5jz1oTQZ53V1w2h0-ngUC2hbEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44HP5EbURyLCmawMLc0d5jz1oTQZ53V1w2h0-ngUC2hbEw@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6FE18409AA
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[172.105.4.254:from];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: YDOSVKI4RSFTQRJDLCMVDPAFZIZIFJFY
X-Message-ID-Hash: YDOSVKI4RSFTQRJDLCMVDPAFZIZIFJFY
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YDOSVKI4RSFTQRJDLCMVDPAFZIZIFJFY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gV2VkLCBKdW4gMTgsIDIwMjUgYXQgMDk6MDM6MDBBTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IE9uIFR1ZSwgSnVuIDE3LCAyMDI1IGF0IDE6MzLigK9QTSBTdW1pdCBHYXJnIDxz
dW1pdC5nYXJnQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCBKdW4gMTAsIDIw
MjUgYXQgMDM6MTM6NTBQTSArMDIwMCwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+ID4gPiBBZGQg
dGVlX3NobV9hbGxvY19kbWFfbWVtKCkgdG8gYWxsb2NhdGUgRE1BIG1lbW9yeS4gVGhlIG1lbW9y
eSBpcw0KPiA+ID4gcmVwcmVzZW50ZWQgYnkgYSB0ZWVfc2htIG9iamVjdCB1c2luZyB0aGUgbmV3
IGZsYWcgVEVFX1NITV9ETUFfTUVNIHRvDQo+ID4gPiBpZGVudGlmeSBpdCBhcyBETUEgbWVtb3J5
LiBUaGUgYWxsb2NhdGVkIG1lbW9yeSB3aWxsIGxhdGVyIGJlIGxlbnQgdG8NCj4gPiA+IHRoZSBU
RUUgdG8gYmUgdXNlZCBhcyBwcm90ZWN0ZWQgbWVtb3J5Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRlckBsaW5hcm8ub3JnPg0KPiA+ID4g
LS0tDQo+ID4gPiAgZHJpdmVycy90ZWUvdGVlX3NobS5jICAgIHwgODUgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gIGluY2x1ZGUvbGludXgvdGVlX2NvcmUu
aCB8ICA1ICsrKw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvdGVlX3No
bS5jIGIvZHJpdmVycy90ZWUvdGVlX3NobS5jDQo+ID4gPiBpbmRleCBlNjMwOTVlODQ2NDQuLjYw
YjBmMzkzMmNlZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdGVlL3RlZV9zaG0uYw0KPiA+
ID4gKysrIGIvZHJpdmVycy90ZWUvdGVlX3NobS5jDQo+ID4gPiBAQCAtNSw2ICs1LDggQEANCj4g
PiA+ICAjaW5jbHVkZSA8bGludXgvYW5vbl9pbm9kZXMuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGlu
dXgvZGV2aWNlLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1idWYuaD4NCj4gPiA+ICsj
aW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvaGln
aG1lbS5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9pZHIuaD4NCj4gPiA+ICAjaW5jbHVkZSA8
bGludXgvaW8uaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvbW0uaD4NCj4gPiA+IEBAIC0xMyw5
ICsxNSwxNCBAQA0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC90ZWVfY29yZS5oPg0KPiA+ID4gICNp
bmNsdWRlIDxsaW51eC91YWNjZXNzLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3Vpby5oPg0K
PiA+ID4gLSNpbmNsdWRlIDxsaW51eC9oaWdobWVtLmg+DQo+ID4gPiAgI2luY2x1ZGUgInRlZV9w
cml2YXRlLmgiDQo+ID4gPg0KPiA+ID4gK3N0cnVjdCB0ZWVfc2htX2RtYV9tZW0gew0KPiA+ID4g
KyAgICAgc3RydWN0IHRlZV9zaG0gc2htOw0KPiA+ID4gKyAgICAgZG1hX2FkZHJfdCBkbWFfYWRk
cjsNCj4gPiA+ICsgICAgIHN0cnVjdCBwYWdlICpwYWdlOw0KPiA+ID4gK307DQo+ID4gPiArDQo+
ID4gPiAgc3RhdGljIHZvaWQgc2htX3B1dF9rZXJuZWxfcGFnZXMoc3RydWN0IHBhZ2UgKipwYWdl
cywgc2l6ZV90IHBhZ2VfY291bnQpDQo+ID4gPiAgew0KPiA+ID4gICAgICAgc2l6ZV90IG47DQo+
ID4gPiBAQCAtNDgsNyArNTUsMTYgQEAgc3RhdGljIHZvaWQgdGVlX3NobV9yZWxlYXNlKHN0cnVj
dCB0ZWVfZGV2aWNlICp0ZWVkZXYsIHN0cnVjdCB0ZWVfc2htICpzaG0pDQo+ID4gPiAgew0KPiA+
ID4gICAgICAgdm9pZCAqcCA9IHNobTsNCj4gPiA+DQo+ID4gPiAtICAgICBpZiAoc2htLT5mbGFn
cyAmIFRFRV9TSE1fRE1BX0JVRikgew0KPiA+ID4gKyAgICAgaWYgKHNobS0+ZmxhZ3MgJiBURUVf
U0hNX0RNQV9NRU0pIHsNCj4gPiA+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfVEVFX0RNQUJVRl9I
RUFQUykNCj4gPg0KPiA+IG5pdDogdGhpcyBjb25maWcgY2hlY2sgY2FuIGJlIG1lcmdlZCBpbnRv
IHRoZSBhYm92ZSBpZiBjaGVjay4NCj4gDQo+IE5vLCBiZWNhdXNlIGRtYV9mcmVlX3BhZ2VzKCkg
aXMgb25seSBkZWZpbmVkIGlmDQo+IENPTkZJR19URUVfRE1BQlVGX0hFQVBTIGlzIGVuYWJsZWQu
DQoNCkl0IGxvb2tzIGxpa2UgeW91IG1pc3VuZGVyc3Rvb2QgbXkgYWJvdmUgY29tbWVudCwgSSBy
YXRoZXIgbWVhbnQ6DQoNCglpZiAoSVNfRU5BQkxFRChDT05GSUdfVEVFX0RNQUJVRl9IRUFQUykg
JiYNCgkgICAgKHNobS0+ZmxhZ3MgJiBURUVfU0hNX0RNQV9NRU0pKQ0KDQotU3VtaXQNCg0KPiAN
Cj4gPg0KPiA+ID4gKyAgICAgICAgICAgICBzdHJ1Y3QgdGVlX3NobV9kbWFfbWVtICpkbWFfbWVt
Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICBkbWFfbWVtID0gY29udGFpbmVyX29mKHNo
bSwgc3RydWN0IHRlZV9zaG1fZG1hX21lbSwgc2htKTsNCj4gPiA+ICsgICAgICAgICAgICAgcCA9
IGRtYV9tZW07DQo+ID4gPiArICAgICAgICAgICAgIGRtYV9mcmVlX3BhZ2VzKCZ0ZWVkZXYtPmRl
diwgc2htLT5zaXplLCBkbWFfbWVtLT5wYWdlLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBkbWFfbWVtLT5kbWFfYWRkciwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiA+ID4gKyNl
bmRpZg0KPiA+ID4gKyAgICAgfSBlbHNlIGlmIChzaG0tPmZsYWdzICYgVEVFX1NITV9ETUFfQlVG
KSB7DQo+ID4NCj4gPiBEbyB3ZSBuZWVkIGEgc2ltaWxhciBjb25maWcgY2hlY2sgZm9yIHRoaXMg
ZmxhZyB0b28/DQo+IA0KPiBObywgYmVjYXVzZSBETUFfU0hBUkVEX0JVRkZFUiBpcyBzZWxlY3Rl
ZCwgc28gdGhlIGRtYV9idWYgZnVuY3Rpb25zIGFyZSBkZWZpbmVkLg0KPiANCj4gQ2hlZXJzLA0K
PiBKZW5zDQo+IA0KPiANCj4gPg0KPiA+IFdpdGggdGhlc2UgYWRkcmVzc2VkLCBmZWVsIGZyZWUg
dG8gYWRkOg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3Nz
LnF1YWxjb21tLmNvbT4NCj4gPg0KPiA+IC1TdW1pdA0KPiA+DQo+ID4gPiAgICAgICAgICAgICAg
IHN0cnVjdCB0ZWVfc2htX2RtYWJ1Zl9yZWYgKnJlZjsNCj4gPiA+DQo+ID4gPiAgICAgICAgICAg
ICAgIHJlZiA9IGNvbnRhaW5lcl9vZihzaG0sIHN0cnVjdCB0ZWVfc2htX2RtYWJ1Zl9yZWYsIHNo
bSk7DQo+ID4gPiBAQCAtMzAzLDYgKzMxOSw3MSBAQCBzdHJ1Y3QgdGVlX3NobSAqdGVlX3NobV9h
bGxvY19wcml2X2J1ZihzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwgc2l6ZV90IHNpemUpDQo+ID4g
PiAgfQ0KPiA+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHRlZV9zaG1fYWxsb2NfcHJpdl9idWYpOw0K
PiA+ID4NCj4gPiA+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfVEVFX0RNQUJVRl9IRUFQUykNCj4g
PiA+ICsvKioNCj4gPiA+ICsgKiB0ZWVfc2htX2FsbG9jX2RtYV9tZW0oKSAtIEFsbG9jYXRlIERN
QSBtZW1vcnkgYXMgc2hhcmVkIG1lbW9yeSBvYmplY3QNCj4gPiA+ICsgKiBAY3R4OiAgICAgQ29u
dGV4dCB0aGF0IGFsbG9jYXRlcyB0aGUgc2hhcmVkIG1lbW9yeQ0KPiA+ID4gKyAqIEBwYWdlX2Nv
dW50OiAgICAgIE51bWJlciBvZiBwYWdlcw0KPiA+ID4gKyAqDQo+ID4gPiArICogVGhlIGFsbG9j
YXRlZCBtZW1vcnkgaXMgZXhwZWN0ZWQgdG8gYmUgbGVudCAobWFkZSBpbmFjY2Vzc2libGUgdG8g
dGhlDQo+ID4gPiArICoga2VybmVsKSB0byB0aGUgVEVFIHdoaWxlIGl0J3MgdXNlZCBhbmQgcmV0
dXJuZWQgKGFjY2Vzc2libGUgdG8gdGhlDQo+ID4gPiArICoga2VybmVsIGFnYWluKSBiZWZvcmUg
aXQncyBmcmVlZC4NCj4gPiA+ICsgKg0KPiA+ID4gKyAqIFRoaXMgZnVuY3Rpb24gc2hvdWxkIG5v
cm1hbGx5IG9ubHkgYmUgdXNlZCBpbnRlcm5hbGx5IGluIHRoZSBURUUNCj4gPiA+ICsgKiBkcml2
ZXJzLg0KPiA+ID4gKyAqDQo+ID4gPiArICogQHJldHVybnMgYSBwb2ludGVyIHRvICdzdHJ1Y3Qg
dGVlX3NobScNCj4gPiA+ICsgKi8NCj4gPiA+ICtzdHJ1Y3QgdGVlX3NobSAqdGVlX3NobV9hbGxv
Y19kbWFfbWVtKHN0cnVjdCB0ZWVfY29udGV4dCAqY3R4LA0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHBhZ2VfY291bnQpDQo+ID4gPiArew0KPiA+ID4g
KyAgICAgc3RydWN0IHRlZV9kZXZpY2UgKnRlZWRldiA9IGN0eC0+dGVlZGV2Ow0KPiA+ID4gKyAg
ICAgc3RydWN0IHRlZV9zaG1fZG1hX21lbSAqZG1hX21lbTsNCj4gPiA+ICsgICAgIGRtYV9hZGRy
X3QgZG1hX2FkZHI7DQo+ID4gPiArICAgICBzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gPiA+ICsNCj4g
PiA+ICsgICAgIGlmICghdGVlX2RldmljZV9nZXQodGVlZGV2KSkNCj4gPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4gPiArDQo+ID4gPiArICAgICBwYWdlID0g
ZG1hX2FsbG9jX3BhZ2VzKCZ0ZWVkZXYtPmRldiwgcGFnZV9jb3VudCAqIFBBR0VfU0laRSwNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmRtYV9hZGRyLCBETUFfQklESVJFQ1RJ
T05BTCwgR0ZQX0tFUk5FTCk7DQo+ID4gPiArICAgICBpZiAoIXBhZ2UpDQo+ID4gPiArICAgICAg
ICAgICAgIGdvdG8gZXJyX3B1dF90ZWVkZXY7DQo+ID4gPiArDQo+ID4gPiArICAgICBkbWFfbWVt
ID0ga3phbGxvYyhzaXplb2YoKmRtYV9tZW0pLCBHRlBfS0VSTkVMKTsNCj4gPiA+ICsgICAgIGlm
ICghZG1hX21lbSkNCj4gPiA+ICsgICAgICAgICAgICAgZ290byBlcnJfZnJlZV9wYWdlczsNCj4g
PiA+ICsNCj4gPiA+ICsgICAgIHJlZmNvdW50X3NldCgmZG1hX21lbS0+c2htLnJlZmNvdW50LCAx
KTsNCj4gPiA+ICsgICAgIGRtYV9tZW0tPnNobS5jdHggPSBjdHg7DQo+ID4gPiArICAgICBkbWFf
bWVtLT5zaG0ucGFkZHIgPSBwYWdlX3RvX3BoeXMocGFnZSk7DQo+ID4gPiArICAgICBkbWFfbWVt
LT5kbWFfYWRkciA9IGRtYV9hZGRyOw0KPiA+ID4gKyAgICAgZG1hX21lbS0+cGFnZSA9IHBhZ2U7
DQo+ID4gPiArICAgICBkbWFfbWVtLT5zaG0uc2l6ZSA9IHBhZ2VfY291bnQgKiBQQUdFX1NJWkU7
DQo+ID4gPiArICAgICBkbWFfbWVtLT5zaG0uZmxhZ3MgPSBURUVfU0hNX0RNQV9NRU07DQo+ID4g
PiArDQo+ID4gPiArICAgICB0ZWVkZXZfY3R4X2dldChjdHgpOw0KPiA+ID4gKw0KPiA+ID4gKyAg
ICAgcmV0dXJuICZkbWFfbWVtLT5zaG07DQo+ID4gPiArDQo+ID4gPiArZXJyX2ZyZWVfcGFnZXM6
DQo+ID4gPiArICAgICBkbWFfZnJlZV9wYWdlcygmdGVlZGV2LT5kZXYsIHBhZ2VfY291bnQgKiBQ
QUdFX1NJWkUsIHBhZ2UsIGRtYV9hZGRyLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgRE1B
X0JJRElSRUNUSU9OQUwpOw0KPiA+ID4gK2Vycl9wdXRfdGVlZGV2Og0KPiA+ID4gKyAgICAgdGVl
X2RldmljZV9wdXQodGVlZGV2KTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHJldHVybiBFUlJfUFRS
KC1FTk9NRU0pOw0KPiA+ID4gK30NCj4gPiA+ICtFWFBPUlRfU1lNQk9MX0dQTCh0ZWVfc2htX2Fs
bG9jX2RtYV9tZW0pOw0KPiA+ID4gKyNlbHNlDQo+ID4gPiArc3RydWN0IHRlZV9zaG0gKnRlZV9z
aG1fYWxsb2NfZG1hX21lbShzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwNCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBwYWdlX2NvdW50KQ0KPiA+ID4gK3sN
Cj4gPiA+ICsgICAgIHJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiA+ID4gK30NCj4gPiA+ICtF
WFBPUlRfU1lNQk9MX0dQTCh0ZWVfc2htX2FsbG9jX2RtYV9tZW0pOw0KPiA+ID4gKyNlbmRpZg0K
PiA+ID4gKw0KPiA+ID4gIGludCB0ZWVfZHluX3NobV9hbGxvY19oZWxwZXIoc3RydWN0IHRlZV9z
aG0gKnNobSwgc2l6ZV90IHNpemUsIHNpemVfdCBhbGlnbiwNCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCAoKnNobV9yZWdpc3Rlcikoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgs
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCB0ZWVfc2htICpzaG0sDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC90ZWVf
Y29yZS5oIGIvaW5jbHVkZS9saW51eC90ZWVfY29yZS5oDQo+ID4gPiBpbmRleCBmMTc3MTAxOTZj
NGMuLmU0NmE1M2U3NTNhZiAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdGVlX2Nv
cmUuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC90ZWVfY29yZS5oDQo+ID4gPiBAQCAtMjks
NiArMjksOCBAQA0KPiA+ID4gICNkZWZpbmUgVEVFX1NITV9QT09MICAgICAgICAgQklUKDIpICAv
KiBNZW1vcnkgYWxsb2NhdGVkIGZyb20gcG9vbCAqLw0KPiA+ID4gICNkZWZpbmUgVEVFX1NITV9Q
UklWICAgICAgICAgQklUKDMpICAvKiBNZW1vcnkgcHJpdmF0ZSB0byBURUUgZHJpdmVyICovDQo+
ID4gPiAgI2RlZmluZSBURUVfU0hNX0RNQV9CVUYgICAgICAgICAgICAgIEJJVCg0KSAgLyogTWVt
b3J5IHdpdGggZG1hLWJ1ZiBoYW5kbGUgKi8NCj4gPiA+ICsjZGVmaW5lIFRFRV9TSE1fRE1BX01F
TSAgICAgICAgICAgICAgQklUKDUpICAvKiBNZW1vcnkgYWxsb2NhdGVkIHdpdGggKi8NCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogZG1hX2FsbG9jX3BhZ2Vz
KCkgKi8NCj4gPiA+DQo+ID4gPiAgI2RlZmluZSBURUVfREVWSUNFX0ZMQUdfUkVHSVNURVJFRCAg
IDB4MQ0KPiA+ID4gICNkZWZpbmUgVEVFX01BWF9ERVZfTkFNRV9MRU4gICAgICAgICAzMg0KPiA+
ID4gQEAgLTMxMCw2ICszMTIsOSBAQCB2b2lkICp0ZWVfZ2V0X2RydmRhdGEoc3RydWN0IHRlZV9k
ZXZpY2UgKnRlZWRldik7DQo+ID4gPiAgICovDQo+ID4gPiAgc3RydWN0IHRlZV9zaG0gKnRlZV9z
aG1fYWxsb2NfcHJpdl9idWYoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgsIHNpemVfdCBzaXplKTsN
Cj4gPiA+DQo+ID4gPiArc3RydWN0IHRlZV9zaG0gKnRlZV9zaG1fYWxsb2NfZG1hX21lbShzdHJ1
Y3QgdGVlX2NvbnRleHQgKmN0eCwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVfdCBwYWdlX2NvdW50KTsNCj4gPiA+ICsNCj4gPiA+ICBpbnQgdGVlX2R5bl9z
aG1fYWxsb2NfaGVscGVyKHN0cnVjdCB0ZWVfc2htICpzaG0sIHNpemVfdCBzaXplLCBzaXplX3Qg
YWxpZ24sDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgKCpzaG1fcmVnaXN0
ZXIpKHN0cnVjdCB0ZWVfY29udGV4dCAqY3R4LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdGVlX3NobSAqc2htLA0KPiA+ID4gLS0N
Cj4gPiA+IDIuNDMuMA0KPiA+ID4NCg==
