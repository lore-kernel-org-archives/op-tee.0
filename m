Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BBBD43362
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 01:26:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4BD7346612
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765502767;
	bh=mtZdc270sn1pgL4P7ntlICfyiBTdVx0xTavj4tqUU8s=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0LLYDKK4KVcsCY9y1iYC/vsPi/5TG2GXneK8uNWYE71RdC+eXDKhj53x39IMI+9Sq
	 TlUt6TQ53Wc8tKTCgqZ4rNll7fRJqr65aGZivYsraluCa6y8AtSh5UtoHUzc3EhqMs
	 +eAPTA/11e3Xg1W/OsrQHDfK3kDTuhdIOTFZYOh+Kr6CyVw9bQI+Nd1ZXEPaA17mwV
	 FfhPzMLmbYfN58VdoNpZIoM5bUEKaZtN3k3d2xByRgLL+Miz6pcjtmjzfDjzNSgdEq
	 BLiuK2ZivpEfn0hfMUx88YJfovgQ5OopEJhgVQ9Z8Bvfu1Xv9NkbCF/nJlGMqEVUHU
	 VjGHLTB69nTkA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B57EC4322B
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Dec 2025 01:25:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fI9l9Sly;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1D99060121;
	Fri, 12 Dec 2025 01:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F535C4CEF7;
	Fri, 12 Dec 2025 01:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765502753;
	bh=l5HU4AzXUTIAQUEXRHuFG3bNUT9HEsPvQxLuphArnhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fI9l9SlySNx8iR5uvACz/XwUg7NdjFf4NFQteK1tB3dIl7tCJ3Mxo6oNVCno7Gzu+
	 Nsgx8Kw4ERKNc7hTi9S/NGK+ktcAVv2gNvQ5xNDlcSy0s+NNuAFw0LteIJl7Bzs/WS
	 gnW3KRmPimYrLHQATTezuhTrfkMaXOeB2fKOH7Iy0XynNT6X0tfc8vXkRf5IEmqRfl
	 QF4UM7yqj43fq1lvP2suWqMtW2hmE6PtQrTaawMzKuiwUfBAjysucLkDyvqcKLWGCO
	 GVcMJd9hUtstUNqBz4sV6Tf04t+9QmsepjxzNhpIPp0lAc8ctgmKxtpsSan1VGvRFs
	 hi1GqnuL8yQpQ==
Date: Fri, 12 Dec 2025 10:25:49 +0900
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
Message-ID: <aTtvHYDOny33yeOD@sumit-X1>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
 <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[renesas];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B57EC4322B
Message-ID-Hash: OIKD2JPH2KZY5NNSTZUMEKEYKOWDTI4P
X-Message-ID-Hash: OIKD2JPH2KZY5NNSTZUMEKEYKOWDTI4P
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OIKD2JPH2KZY5NNSTZUMEKEYKOWDTI4P/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gV2VkLCBEZWMgMTAsIDIwMjUgYXQgMDI6MzU6MTlQTSArMDUzMCwgSGFyc2hhbCBEZXYgd3Jv
dGU6DQo+IEhpIEJqb3JuLA0KPiANCj4gT24gMTIvMTAvMjAyNSA5OjIxIEFNLCBCam9ybiBBbmRl
cnNzb24gd3JvdGU6DQo+ID4gT24gTW9uLCBEZWMgOCwgMjAyNSBhdCAxMDoxNOKAr1BNIERtaXRy
eSBCYXJ5c2hrb3YNCj4gPiA8ZG1pdHJ5LmJhcnlzaGtvdkBvc3MucXVhbGNvbW0uY29tPiB3cm90
ZToNCj4gPj4gT24gVHVlLCA5IERlYyAyMDI1IGF0IDA3OjU4LCBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+Pj4NCj4gPj4+IE9uIDA4LzEyLzIwMjUgMTM6
MTgsIEhhcnNoYWwgRGV2IHdyb3RlOg0KPiA+Pj4+IEVuYWJsZSBRQ09NVEVFIGRyaXZlciBvbiBR
dWFsY29tbSBTTTg2NTArIFNvQ3MgdG8gZmFjaWxpdGF0ZSBjb21tdW5pY2F0aW9uDQo+ID4+Pj4g
d2l0aCB0aGUgUXVhbGNvbW0gVHJ1c3RlZCBFeGVjdXRpb24gRW52aXJvbm1lbnQgKFFURUUpLg0K
PiA+Pj4+IChObyBlbmFibGVtZW50IHJlcXVpcmVkIGluIERUUyBmaWxlcyBzaW5jZSBRQ09NVEVF
IGRldmljZSBpcyBkeW5hbWljYWxseQ0KPiA+Pj4+IHJlZ2lzdGVyZWQgYnkgdGhlIFFDT01fU0NN
IGZpcm13YXJlIGRyaXZlcikNCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEhhcnNoYWwg
RGV2IDxoYXJzaGFsLmRldkBvc3MucXVhbGNvbW0uY29tPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+IENo
YW5nZXMgaW4gdjM6DQo+ID4+Pj4gLSBVcGRhdGVkIHRoZSBjb21taXQgbWVzc2FnZSB0byByZWZs
ZWN0IHRoZSBzdXBwb3J0ZWQgUXVhbGNvbW0gcGxhdGZvcm1zLg0KPiA+Pj4+IC0gTGluayB0byB2
MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MTIwNS1xY29tX3Fjb210ZWVfZGVmY29u
ZmlnLXYyLTEtYzkyNTYwYjAzNDZlQHF0aS5xdWFsY29tbS5jb20NCj4gPj4+Pg0KPiA+Pj4NCj4g
Pj4+IEkgZ2F2ZSB5b3UgdGhlIGV4YWN0IGV4YW1wbGUgdG8gZm9sbG93LiBNYXliZSBpdCBpcyBu
b3QgdGhhdCBpbXBvcnRhbnQNCj4gPj4+IGZvciBvdGhlcnMsIHNvIEkgd2lsbCBub3Qgb2JqZWN0
LCBidXQgT1RPSCBpdCBpcyBpbXBvcnRhbnQgZm9yIG1lLCB0aHVzDQo+ID4+PiBJIHdpbGwgbm90
IGdpdmUgcmV2aWV3ZWQgYnkuIEkgZGFtbiBhc2tlZCBWRVJZIENMRUFSTFk6DQo+ID4+Pg0KPiA+
Pj4gIkp1c3QgbWVudGlvbiB3aGljaCBVUFNUUkVBTSBib2FyZHMgKHdoaWNoIHlvdSBjYWxsZWQg
UXVhbGNvbW0NCj4gPj4+IHBsYXRmb3JtcykgdXNlIHRoaXMgZHJpdmVyLiINCj4gPj4NCj4gPj4g
KzEgSGVyZS4gRGVmY29uZmlnIGNoYW5nZXMgbWVudGlvbiBkZXZpY2VzLCBub3QgU29DIGZhbWls
aWVzLg0KPiA+Pg0KPiA+IA0KPiA+IEkgZG9uJ3QgYWdyZWUgdGhhdCB5b3UgaGF2ZSB0byBtZW50
aW9uIGEgc3BlY2lmaWMgYm9hcmQsIGlmIHRoZQ0KPiA+IGZlYXR1cmUgaXMgdXNlZCBieSBhbGwg
Ym9hcmRzLiBCdXQgSSB0aGluayB0aGUgY29tbWl0IG1lc3NhZ2Ugc2hvdWxkDQo+ID4gbWFrZSBf
dGhhdF8gY2xlYXIuDQo+ID4gDQo+IA0KPiBUaGFua3MgZm9yIHRoaXMgaW5wdXQgQmpvcm4uIEkg
Z2F0aGVyIHdlIGFyZSBub3cgYWxpZ25lZCB0aGF0IHRoZSBib2FyZA0KPiBpbmZvcm1hdGlvbiBp
cyBub3QgcmVxdWlyZWQuDQo+IA0KPiBUaGVuIHRoZSBvdGhlciBwYXJ0IHRvIHRoaXMgaXMgaG93
IHRvIHByb3ZpZGUgaW5mb3JtYXRpb24gb24gdGhlIHBhcnRpY3VsYXINCj4gU29DcyB1c2luZyB0
aGlzLg0KPiANCj4gPiBPbiB0aGUgY29udHJhcnksIHRoZSBjb21taXQgbWVzc2FnZSBzYXlzIHRo
YXQgd2UncmUgZW5hYmxpbmcNCj4gPiBDT05GSUdfUUNPTVRFRSBiZWNhdXNlIGl0J3MgdXNlZCBv
biAiU004NTYwKyIuIFdoYXQgZG9lcyB0aGUgcGx1cw0KPiA+IG1lYW4/DQo+IA0KPiBJIHRvb2sg
cmVmZXJlbmNlIGZyb20gc2ltaWxhciBjb21taXRzIG1lcmdlZCBlYXJsaWVyIHdoZXJlIHRoZSBw
bHVzIHNlZW1lZA0KPiB0byBpbmRpY2F0ZSB0aGF0IGFsbCBRdWFsY29tbSBTb0NzIGZyb20gJ1NN
ODY1MCcgb24td2FyZHMsIHRoYXQgaXMsIFNNODc1MCwNCj4gU004ODUwIGFuZCBzbyBvbi4gSXQg
ZmVsdCB0aGF0IHRoZSBwbHVzIHNpZ24gaXMgc2VsZi1leHBsYW5hdG9yeSBzaW5jZSBpdA0KPiBo
YXMgYmVlbiB1c2VkIGFscmVhZHkuIEJ1dCBzdXJlLCBtYXliZSB3ZSBjYW4gYmUgZXhwbGljaXQg
ZnJvbSBub3cgb24gYW5kIHNheQ0KPiBmcm9tICdRdWFsY29tbSBTTTg2NTAgb253YXJkcycuDQo+
IA0KPiBjb21taXQgYzVkMDJiYmFhMjE3YjI0NTRiYTFjZTc1MjgxMTNhYTJlY2YxNGYzYw0KPiAN
Cj4gPiBBbHNvLCB0aGUgZHJpdmVyIGlzbid0IGVuYWJsZWQgIm9uIFF1YWxjb21tIFNNODY1MCsi
LCBpdCdzIGVuYWJsZWQgaW4NCj4gPiB0aGUgQW02NCBkZWZjb25maWcsIGkuZS4gaXQncyBlbmFi
bGVkIG9uIGFsbCBBcm02NCBib2FyZHMgLSB0aGUNCj4gPiBxdWVzdGlvbiB0aGF0IHNob3VsZCBi
ZSBhbnN3ZXJlZCBieSB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgIndoeT8iLg0KPiA+IA0KPiANCj4g
RXZlbiB0aG91Z2ggd2UgYXJlIGVuYWJsaW5nIHRoaXMgdmlhIHRoZSBhcm02NCBkZWZjb25maWcs
IGl0IGlzIG5vdCB0cnVlIHRoYXQNCj4gdGhlIGRyaXZlciBpcyBhcHBsaWNhYmxlIGZvciBhbGwg
YXJtNjQgYm9hcmRzLiBUaGUgc2ltcGxlIHJlYXNvbiBiZWluZyB0aGF0DQo+IHRoZSBRVEVFIGZp
cm13YXJlIE9TIHRoYXQgdGhlIGRyaXZlciBjb21tdW5pY2F0ZXMgd2l0aCBydW5zIG9ubHkgb24g
UXVhbGNvbW0NCj4gU29DcyB1c2luZyBhcm02NCBDUFVzIHdpdGggQVJNIFRydXN0Wm9uZSB0ZWNo
bm9sb2d5Lg0KPiANCj4gVGhpcyBpcyB3aHkgSSB3b3VsZCB0cnkgdG8gYXZvaWQgYSBjb21taXQg
bWVzc2FnZSB3aGljaCBjbGFpbXMgdGhlIHRoZSBkcml2ZXINCj4gaXMgYXBwbGljYWJsZSB0byBh
bGwgYXJtNjQgYm9hcmRzLg0KPiANCj4gQmFzZWQgb24gYWxsIHRoaXMsIEkgYW0gdGhpbmtpbmcg
cGVyaGFwcyBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gc2F5IHRoYXQgdGhlDQo+IHBhdGNoIGVuYWJs
ZXMgUUNPTVRFRSBkcml2ZXIgZm9yIFF1YWxjb21tIFNvQ3Mgd2l0aCBhcm02NCBDUFVzPyBXZSBj
b3VsZCBkcm9wDQo+IG1lbnRpb25zIG9mIHNwZWNpZmljIFNNOHg1MCBtb2RlbHMgd2l0aCBIREsv
TVRQIGJvYXJkcyBzaW5jZSB0aGUgZmVhdHVyZSBpcw0KPiBhZ25vc3RpYyB0byB0aG9zZT8NCg0K
QUZBSUssIHRoZSBRQ09NVEVFIGRyaXZlciB3b3JrcyBvbiB0aGUgUWNvbSBTb0NzIGJhc2VkIG9u
IGFybTY0IHdoaWNoIHN1cHBvcnRzDQp0aGUgU01DSW52b2tlIHByb3RvY29sLiBTbyB3ZSBzaG91
bGQgYmUgZXhwbGljaXQgYWJvdXQgaXQuIFJlZ2FyZGluZw0KbWVudGlvbiBvZiByZWZlcmVuY2Ug
cHVibGljbHkgYXZhaWxhYmxlIGJvYXJkcywgSSBjYW4gc2VlIGhvdyBpdCBjYW4gYmUgdXNlZnVs
DQpmb3IgdGhlIGNvbW11bml0eSB0byB0ZXN0IFFURUUgYmFzZWQgYXBwcy4gSWYgeW91IGNhbiBt
ZW50aW9uIHNheQ0KZXhhbXBsZSBSQjNHZW4yIHN1cHBvcnRzIFFURUUgZHJpdmVyIGF0IGxlYXN0
IHRoZW4gaXQgd2lsbCBiZSBoZWxwZnVsLg0KDQotU3VtaXQNCg0KWy4uLl0NCg==
