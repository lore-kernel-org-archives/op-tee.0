Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABE1C54FB3
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 09:33:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EDD334312F
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 09:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748252037;
	bh=ZObWrXSs2zKdhB5RTRtMNiXzuSGd8EGI0qxhejVLBBg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=HI3+MRDKIkT8TC9pOT+iu+QKoT+MacgoKpd9mHPNBMiFdCiemfrzKm1iC1vL8nKQo
	 slsEyXS8IIYv5IsRK6hdkDU3Z4hZuMWc2HHWufv1Yc4Esw5sik5aNBsw+bDRpcD1C4
	 JQsoV9iCSYloErsXufQVvN3qEAig+w2qzUSTEd6FL4OpU/sC+hf2vi2xcvW1JgqaLi
	 M4V9PP15NV4qYHTMAnyQQgJ/PsBrbeKSq86fQuJeCGeLiU5KVDgrkgCIFm7kjSLhu6
	 IzDCr2V4011MrOKwmrd92JPU1EJbYKfGGxCkihoEJZohCMHyoKST3kcSRJT0uSy3s/
	 pz8mQUVOUHWbg==
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A755442C5D
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 09:33:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CFHrONzK;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4B67CA4DF12;
	Mon, 26 May 2025 09:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F021BC4CEEE;
	Mon, 26 May 2025 09:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748252017;
	bh=j5u6GeKfGRt01uKZ1DWq/krRDd3IxYawjOABhTomJIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFHrONzKTbnwow4S3bzcO7VcXUvND1JG7WNzhUwiL/79/1EFCNY4mOro9s/dAOOXO
	 hpVqP+S3ihCrM5yUwGl4inEqAqShAvKpwH6gcaELHHRLfpGZnvfglnq4negLhrSDKj
	 ffkH4Qp4Hh3QuQV7kVC7Yz/qmmu6EVJTUJFKckrQ9WaEcL1hwpLVAribKGZw+s3NDe
	 mmB7/TD8aHKtOl4M5LS8l1JVI2KWIad8fxJO2lXBXPqWThHnCooVYmdP77Ad1IIHCL
	 PMxuD73WteTm6D+j0tW0mJb8+4bEfg3y0CxP7uTSudEQoCtCzK8GonUTWkvTEwdDHM
	 gDU8BP68rKMyQ==
Date: Mon, 26 May 2025 15:03:21 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v9 6/9] tee: add tee_shm_alloc_dma_mem()
Message-ID: <aDQ1YR5jbcOFctty@sumit-X1>
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-7-jens.wiklander@linaro.org>
 <aDQWt5Ck1Bo01Z_4@sumit-X1>
 <CAHUa44E4-z7-7DQjyGXYRiZDf6mRBKYZDuxWFGy+3JxtWO1ocg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44E4-z7-7DQjyGXYRiZDf6mRBKYZDuxWFGy+3JxtWO1ocg@mail.gmail.com>
X-Spamd-Bar: --------
X-Spamd-Result: default: False [-8.70 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:147.75.193.91];
	RCVD_IN_DNSWL_MED(-0.20)[147.75.193.91:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:54825, ipnet:147.75.192.0/21, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A755442C5D
Message-ID-Hash: 6I4UF3NKCVC5MSWCGRIITAAHYQI4PVBJ
X-Message-ID-Hash: 6I4UF3NKCVC5MSWCGRIITAAHYQI4PVBJ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6I4UF3NKCVC5MSWCGRIITAAHYQI4PVBJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gTW9uLCBNYXkgMjYsIDIwMjUgYXQgMTE6MjE6NDdBTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IE9uIE1vbiwgTWF5IDI2LCAyMDI1IGF0IDk6MjLigK9BTSBTdW1pdCBHYXJnIDxz
dW1pdC5nYXJnQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCBNYXkgMjAsIDIw
MjUgYXQgMDU6MTY6NDlQTSArMDIwMCwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+ID4gPiBBZGQg
dGVlX3NobV9hbGxvY19kbWFfbWVtKCkgdG8gYWxsb2NhdGUgRE1BIG1lbW9yeS4gVGhlIG1lbW9y
eSBpcw0KPiA+ID4gcmVwcmVzZW50ZWQgYnkgYSB0ZWVfc2htIG9iamVjdCB1c2luZyB0aGUgbmV3
IGZsYWcgVEVFX1NITV9ETUFfTUVNIHRvDQo+ID4gPiBpZGVudGlmeSBpdCBhcyBETUEgbWVtb3J5
LiBUaGUgYWxsb2NhdGVkIG1lbW9yeSB3aWxsIGxhdGVyIGJlIGxlbnQgdG8NCj4gPiA+IHRoZSBU
RUUgdG8gYmUgdXNlZCBhcyBwcm90ZWN0ZWQgbWVtb3J5Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRlckBsaW5hcm8ub3JnPg0KPiA+ID4g
LS0tDQo+ID4gPiAgZHJpdmVycy90ZWUvdGVlX3NobS5jICAgIHwgNzQgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ID4gIGluY2x1ZGUvbGludXgvdGVlX2NvcmUu
aCB8ICA1ICsrKw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvdGVlX3No
bS5jIGIvZHJpdmVycy90ZWUvdGVlX3NobS5jDQo+ID4gPiBpbmRleCBlMWVkNTJlZTBhMTYuLjky
YTZhMzVlMWExZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdGVlL3RlZV9zaG0uYw0KPiA+
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
ID4gPiBAQCAtNDksNyArNTYsMTQgQEAgc3RhdGljIHZvaWQgdGVlX3NobV9yZWxlYXNlKHN0cnVj
dCB0ZWVfZGV2aWNlICp0ZWVkZXYsIHN0cnVjdCB0ZWVfc2htICpzaG0pDQo+ID4gPiAgICAgICBz
dHJ1Y3QgdGVlX3NobSAqcGFyZW50X3NobSA9IE5VTEw7DQo+ID4gPiAgICAgICB2b2lkICpwID0g
c2htOw0KPiA+ID4NCj4gPiA+IC0gICAgIGlmIChzaG0tPmZsYWdzICYgVEVFX1NITV9ETUFfQlVG
KSB7DQo+ID4gPiArICAgICBpZiAoc2htLT5mbGFncyAmIFRFRV9TSE1fRE1BX01FTSkgew0KPiA+
ID4gKyAgICAgICAgICAgICBzdHJ1Y3QgdGVlX3NobV9kbWFfbWVtICpkbWFfbWVtOw0KPiA+ID4g
Kw0KPiA+ID4gKyAgICAgICAgICAgICBkbWFfbWVtID0gY29udGFpbmVyX29mKHNobSwgc3RydWN0
IHRlZV9zaG1fZG1hX21lbSwgc2htKTsNCj4gPiA+ICsgICAgICAgICAgICAgcCA9IGRtYV9tZW07
DQo+ID4gPiArICAgICAgICAgICAgIGRtYV9mcmVlX3BhZ2VzKCZ0ZWVkZXYtPmRldiwgc2htLT5z
aXplLCBkbWFfbWVtLT5wYWdlLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBk
bWFfbWVtLT5kbWFfYWRkciwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiA+DQo+ID4gQWx0aG91Z2gg
dGhlIGtlcm5lbCBib3QgYWxyZWFkeSBmb3VuZCBhIHJhbmRjb25maWcgaXNzdWUsIGl0IGxvb2tz
IGxpa2UNCj4gPiB3ZSBuZWVkIHRvIGFkZCBLY29uZmlnIGRlcGVuZGVuY2llcyBsaWtlIEhBU19E
TUEsIERNQV9DTUEgZXRjLg0KPiA+DQo+ID4gQWxzbywgSSB3YXMgdGhpbmtpbmcgaWYgd2Ugc2hv
dWxkIHJhdGhlciBhZGQgYSBuZXcgVEVFIHN1YnN5c3RlbQ0KPiA+IHNwZWNpZmljIEtjb25maWcg
b3B0aW9uIGxpa2U6IFRFRV9ETUFCVUZfSEVBUFMgd2hpY2ggY2FuIHRoZW4gYmUgdXNlZCB0bw0K
PiA+IHNlbGVjdCB3aGF0ZXZlciBkZXBlbmRlbmN5IGlzIG5lZWRlZCBhcyB3ZWxsIGFzIGFjdCBh
cyBhIGdhdGluZyBLY29uZmlnDQo+ID4gZm9yIHJlbGV2YW50IGZlYXR1cmVzLg0KPiANCj4gWW91
IG1lYW4gc29tZXRoaW5nIGxpa2UgdGhpcz8NCj4gDQo+IC0tLSBhL2RyaXZlcnMvdGVlL0tjb25m
aWcNCj4gKysrIGIvZHJpdmVycy90ZWUvS2NvbmZpZw0KPiBAQCAtMTMsNiArMTMsMTQgQEAgbWVu
dWNvbmZpZyBURUUNCj4gDQo+ICBpZiBURUUNCj4gDQo+ICtjb25maWcgVEVFX0RNQUJVRl9IRUFQ
Uw0KPiArICAgICAgIGJvb2wNCj4gKyAgICAgICBkZXBlbmRzIG9uIEhBU19ETUEgJiYgRE1BQlVG
X0hFQVBTDQoNClllYWggdGhpcyBsb29rcyBmaW5lIHRvIG1lIGJ1dCBuZWVkcyB0byBiZSB0ZXN0
ZWQgaWYgRE1BX0NNQSBpcyBhDQpkZXBlbmRlbmN5IGhlcmUgdG9vLg0KDQo+ICsNCj4gK2NvbmZp
ZyBURUVfU1RBVElDX1BST1RNRU1fUE9PTA0KPiArICAgICAgIGJvb2wNCj4gKyAgICAgICBkZXBl
bmRzIG9uIEhBU19JT01FTSAmJiBURUVfRE1BQlVGX0hFQVBTDQoNClRoZSBzdGF0aWMgYW5kIGR5
bmFtaWMgcHJvdGVjdGVkIG1lbW9yeSBwb29scyBzaG91bGQgZ2V0IGF1dG8gZW5hYmxlZCBpZg0K
VEVFX0RNQUJVRl9IRUFQUyBpcyBlbmFibGVkIHNpbmNlIHRoZXkgYXJlIHByZS1yZXF1aXNpdGUg
dG8gcHJvdmlkZSB0aGUNCnByb3RlY3RlZCBoZWFwcyBzdXBwb3J0LiBTb21ldGhpbmcgbGlrZToN
Cg0KK2NvbmZpZyBURUVfU1RBVElDX1BST1RNRU1fUE9PTA0KKyAgICAgICBib29sDQorICAgICAg
IGRlZmF1bHQgeSBpZiBURUVfRE1BQlVGX0hFQVBTDQorICAgICAgIGRlcGVuZHMgb24gSEFTX0lP
TUVNDQoNCi1TdW1pdA0KDQo+ICsNCj4gDQo+IENoZWVycywNCj4gSmVucw0KPiANCj4gPg0KPiA+
IC1TdW1pdA0KPiA+DQo+ID4gPiArICAgICB9IGVsc2UgaWYgKHNobS0+ZmxhZ3MgJiBURUVfU0hN
X0RNQV9CVUYpIHsNCj4gPiA+ICAgICAgICAgICAgICAgc3RydWN0IHRlZV9zaG1fZG1hYnVmX3Jl
ZiAqcmVmOw0KPiA+ID4NCj4gPiA+ICAgICAgICAgICAgICAgcmVmID0gY29udGFpbmVyX29mKHNo
bSwgc3RydWN0IHRlZV9zaG1fZG1hYnVmX3JlZiwgc2htKTsNCj4gPiA+IEBAIC0zMDYsNiArMzIw
LDYyIEBAIHN0cnVjdCB0ZWVfc2htICp0ZWVfc2htX2FsbG9jX3ByaXZfYnVmKHN0cnVjdCB0ZWVf
Y29udGV4dCAqY3R4LCBzaXplX3Qgc2l6ZSkNCj4gPiA+ICB9DQo+ID4gPiAgRVhQT1JUX1NZTUJP
TF9HUEwodGVlX3NobV9hbGxvY19wcml2X2J1Zik7DQo+ID4gPg0KPiA+ID4gKy8qKg0KPiA+ID4g
KyAqIHRlZV9zaG1fYWxsb2NfZG1hX21lbSgpIC0gQWxsb2NhdGUgRE1BIG1lbW9yeSBhcyBzaGFy
ZWQgbWVtb3J5IG9iamVjdA0KPiA+ID4gKyAqIEBjdHg6ICAgICBDb250ZXh0IHRoYXQgYWxsb2Nh
dGVzIHRoZSBzaGFyZWQgbWVtb3J5DQo+ID4gPiArICogQHBhZ2VfY291bnQ6ICAgICAgTnVtYmVy
IG9mIHBhZ2VzDQo+ID4gPiArICoNCj4gPiA+ICsgKiBUaGUgYWxsb2NhdGVkIG1lbW9yeSBpcyBl
eHBlY3RlZCB0byBiZSBsZW50IChtYWRlIGluYWNjZXNzaWJsZSB0byB0aGUNCj4gPiA+ICsgKiBr
ZXJuZWwpIHRvIHRoZSBURUUgd2hpbGUgaXQncyB1c2VkIGFuZCByZXR1cm5lZCAoYWNjZXNzaWJs
ZSB0byB0aGUNCj4gPiA+ICsgKiBrZXJuZWwgYWdhaW4pIGJlZm9yZSBpdCdzIGZyZWVkLg0KPiA+
ID4gKyAqDQo+ID4gPiArICogVGhpcyBmdW5jdGlvbiBzaG91bGQgbm9ybWFsbHkgb25seSBiZSB1
c2VkIGludGVybmFsbHkgaW4gdGhlIFRFRQ0KPiA+ID4gKyAqIGRyaXZlcnMuDQo+ID4gPiArICoN
Cj4gPiA+ICsgKiBAcmV0dXJucyBhIHBvaW50ZXIgdG8gJ3N0cnVjdCB0ZWVfc2htJw0KPiA+ID4g
KyAqLw0KPiA+ID4gK3N0cnVjdCB0ZWVfc2htICp0ZWVfc2htX2FsbG9jX2RtYV9tZW0oc3RydWN0
IHRlZV9jb250ZXh0ICpjdHgsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzaXplX3QgcGFnZV9jb3VudCkNCj4gPiA+ICt7DQo+ID4gPiArICAgICBzdHJ1Y3QgdGVl
X2RldmljZSAqdGVlZGV2ID0gY3R4LT50ZWVkZXY7DQo+ID4gPiArICAgICBzdHJ1Y3QgdGVlX3No
bV9kbWFfbWVtICpkbWFfbWVtOw0KPiA+ID4gKyAgICAgZG1hX2FkZHJfdCBkbWFfYWRkcjsNCj4g
PiA+ICsgICAgIHN0cnVjdCBwYWdlICpwYWdlOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgaWYgKCF0
ZWVfZGV2aWNlX2dldCh0ZWVkZXYpKQ0KPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gRVJSX1BU
UigtRUlOVkFMKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHBhZ2UgPSBkbWFfYWxsb2NfcGFnZXMo
JnRlZWRldi0+ZGV2LCBwYWdlX2NvdW50ICogUEFHRV9TSVpFLA0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmZG1hX2FkZHIsIERNQV9CSURJUkVDVElPTkFMLCBHRlBfS0VSTkVM
KTsNCj4gPiA+ICsgICAgIGlmICghcGFnZSkNCj4gPiA+ICsgICAgICAgICAgICAgZ290byBlcnJf
cHV0X3RlZWRldjsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIGRtYV9tZW0gPSBremFsbG9jKHNpemVv
ZigqZG1hX21lbSksIEdGUF9LRVJORUwpOw0KPiA+ID4gKyAgICAgaWYgKCFkbWFfbWVtKQ0KPiA+
ID4gKyAgICAgICAgICAgICBnb3RvIGVycl9mcmVlX3BhZ2VzOw0KPiA+ID4gKw0KPiA+ID4gKyAg
ICAgcmVmY291bnRfc2V0KCZkbWFfbWVtLT5zaG0ucmVmY291bnQsIDEpOw0KPiA+ID4gKyAgICAg
ZG1hX21lbS0+c2htLmN0eCA9IGN0eDsNCj4gPiA+ICsgICAgIGRtYV9tZW0tPnNobS5wYWRkciA9
IHBhZ2VfdG9fcGh5cyhwYWdlKTsNCj4gPiA+ICsgICAgIGRtYV9tZW0tPmRtYV9hZGRyID0gZG1h
X2FkZHI7DQo+ID4gPiArICAgICBkbWFfbWVtLT5wYWdlID0gcGFnZTsNCj4gPiA+ICsgICAgIGRt
YV9tZW0tPnNobS5zaXplID0gcGFnZV9jb3VudCAqIFBBR0VfU0laRTsNCj4gPiA+ICsgICAgIGRt
YV9tZW0tPnNobS5mbGFncyA9IFRFRV9TSE1fRE1BX01FTTsNCj4gPiA+ICsNCj4gPiA+ICsgICAg
IHRlZWRldl9jdHhfZ2V0KGN0eCk7DQo+ID4gPiArDQo+ID4gPiArICAgICByZXR1cm4gJmRtYV9t
ZW0tPnNobTsNCj4gPiA+ICsNCj4gPiA+ICtlcnJfZnJlZV9wYWdlczoNCj4gPiA+ICsgICAgIGRt
YV9mcmVlX3BhZ2VzKCZ0ZWVkZXYtPmRldiwgcGFnZV9jb3VudCAqIFBBR0VfU0laRSwgcGFnZSwg
ZG1hX2FkZHIsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICBETUFfQklESVJFQ1RJT05BTCk7
DQo+ID4gPiArZXJyX3B1dF90ZWVkZXY6DQo+ID4gPiArICAgICB0ZWVfZGV2aWNlX3B1dCh0ZWVk
ZXYpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ID4g
PiArfQ0KPiA+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHRlZV9zaG1fYWxsb2NfZG1hX21lbSk7DQo+
ID4gPiArDQo+ID4gPiAgaW50IHRlZV9keW5fc2htX2FsbG9jX2hlbHBlcihzdHJ1Y3QgdGVlX3No
bSAqc2htLCBzaXplX3Qgc2l6ZSwgc2l6ZV90IGFsaWduLA0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW50ICgqc2htX3JlZ2lzdGVyKShzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHRlZV9zaG0gKnNobSwNCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3RlZV9j
b3JlLmggYi9pbmNsdWRlL2xpbnV4L3RlZV9jb3JlLmgNCj4gPiA+IGluZGV4IDAyYzA3ZjY2MTM0
OS4uOTI1NjkwZTEwMjBiIDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC90ZWVfY29y
ZS5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3RlZV9jb3JlLmgNCj4gPiA+IEBAIC0yOSw2
ICsyOSw4IEBADQo+ID4gPiAgI2RlZmluZSBURUVfU0hNX1BPT0wgICAgICAgICBCSVQoMikgIC8q
IE1lbW9yeSBhbGxvY2F0ZWQgZnJvbSBwb29sICovDQo+ID4gPiAgI2RlZmluZSBURUVfU0hNX1BS
SVYgICAgICAgICBCSVQoMykgIC8qIE1lbW9yeSBwcml2YXRlIHRvIFRFRSBkcml2ZXIgKi8NCj4g
PiA+ICAjZGVmaW5lIFRFRV9TSE1fRE1BX0JVRiAgICAgICAgICAgICAgQklUKDQpICAvKiBNZW1v
cnkgd2l0aCBkbWEtYnVmIGhhbmRsZSAqLw0KPiA+ID4gKyNkZWZpbmUgVEVFX1NITV9ETUFfTUVN
ICAgICAgICAgICAgICBCSVQoNSkgIC8qIE1lbW9yeSBhbGxvY2F0ZWQgd2l0aCAqLw0KPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBkbWFfYWxsb2NfcGFnZXMo
KSAqLw0KPiA+ID4NCj4gPiA+ICAjZGVmaW5lIFRFRV9ERVZJQ0VfRkxBR19SRUdJU1RFUkVEICAg
MHgxDQo+ID4gPiAgI2RlZmluZSBURUVfTUFYX0RFVl9OQU1FX0xFTiAgICAgICAgIDMyDQo+ID4g
PiBAQCAtMzEwLDYgKzMxMiw5IEBAIHZvaWQgKnRlZV9nZXRfZHJ2ZGF0YShzdHJ1Y3QgdGVlX2Rl
dmljZSAqdGVlZGV2KTsNCj4gPiA+ICAgKi8NCj4gPiA+ICBzdHJ1Y3QgdGVlX3NobSAqdGVlX3No
bV9hbGxvY19wcml2X2J1ZihzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwgc2l6ZV90IHNpemUpOw0K
PiA+ID4NCj4gPiA+ICtzdHJ1Y3QgdGVlX3NobSAqdGVlX3NobV9hbGxvY19kbWFfbWVtKHN0cnVj
dCB0ZWVfY29udGV4dCAqY3R4LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZV90IHBhZ2VfY291bnQpOw0KPiA+ID4gKw0KPiA+ID4gIGludCB0ZWVfZHluX3No
bV9hbGxvY19oZWxwZXIoc3RydWN0IHRlZV9zaG0gKnNobSwgc2l6ZV90IHNpemUsIHNpemVfdCBh
bGlnbiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCAoKnNobV9yZWdpc3Rl
cikoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB0ZWVfc2htICpzaG0sDQo+ID4gPiAtLQ0K
PiA+ID4gMi40My4wDQo+ID4gPg0K
