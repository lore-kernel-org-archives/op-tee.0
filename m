Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71751D4A615
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 09:15:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B3631432B3
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768554910;
	bh=439ys0tA7v/Wri1N7VIcjHGAxch5DgT/FtvxqTRbQHM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uKUT9fwPdEXTtX2e+51RP0LgUevo9iiQH7atzSnkE2L5lVMZ6rb6TxncPeThAdWeP
	 piVDbZAwknGSQlH/JM7oxINopFZl7AqkULvk/sPTkEy4/GK6xG3SW/cg90egCtWfSB
	 3SFcgsnvIJLsxAQPdAQA1lGgRVUl3zp/MeHRBbG/2V6e/LZKHcYsfd0koiS89zOeio
	 0KmcKr5BZQyW5h5U+oP0FOh+mOBJRM93DbcsAMbaxJG4JKcad6QdLa6lVkJJWYvAR6
	 O/f2IMyDQj7zn5WTKki0dYDQM3Cf0CuhcgV0IFJ0KUJLxKYVMjBOOTd3/O9WHwTvci
	 mos3TAY8Joxeg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6FD7943295
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Jan 2026 09:14:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GBOSwZ5/;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C118D6016B;
	Fri, 16 Jan 2026 09:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E00C116C6;
	Fri, 16 Jan 2026 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768554888;
	bh=3SamNIJ/Are+C/I+gqv+kznrE4CPCwmYFAwFwqjSDhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBOSwZ5/znT4C3v7d3val0FA0srjWpwq2c1lnkV9kPW4CdGeKGAOWHSHL0dAD3hKW
	 lnMvkezyjk00lbbHQ2VCEGKaD6Zlr0JFsv8Nv3LkZ6YT4oFh0JpluhmMIk7Kfq/8Ry
	 gzNCPFVyqYOcPSKT6E3LtbUx7pRwFIJh3iAA8QP9ybnMj9sdWc89n9CQ67vB+ZLP0T
	 X4gIr8FHD/LhcNOzZ/uf05vxH5NahwftBDSoffvzms4lIxLyn+VeAhauLnjtuqgr7q
	 pE5FzMT+6CR3EBSGUAqS257iwqVowOak41fCjWOLj088GXxELM7JklDWaRx0/P1FPY
	 KcncNqSygFH5w==
Date: Fri, 16 Jan 2026 14:44:42 +0530
To: Colin King <coking@nvidia.com>
Subject: Re: [PATCH][next] optee: make read-only array attr static const
Message-ID: <aWoBgt66shtVTovl@sumit-xelite>
References: <20260109154442.421248-1-coking@nvidia.com>
 <aWTaUvGu9dlvnJO9@sumit-xelite>
 <CAHtS329G-H8vVVr==DZUAetzVNc4couN2OV3tH7qH_7YDGe8xA@mail.gmail.com>
 <DS0PR12MB8294F8C07E39842AC16CBA21AF81A@DS0PR12MB8294.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <DS0PR12MB8294F8C07E39842AC16CBA21AF81A@DS0PR12MB8294.namprd12.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,lists.trustedfirmware.org,vger.kernel.org];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6FD7943295
X-Spamd-Bar: --
Message-ID-Hash: BYP6U3VJ4TNRVVUINT7CZLFYDAD6INY3
X-Message-ID-Hash: BYP6U3VJ4TNRVVUINT7CZLFYDAD6INY3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ryan foster <foster.ryan.r@gmail.com>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BYP6U3VJ4TNRVVUINT7CZLFYDAD6INY3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gTW9uLCBKYW4gMTIsIDIwMjYgYXQgMDM6MjQ6NDlQTSArMDAwMCwgQ29saW4gS2luZyB3cm90
ZToNCj4gSSBhZGRlZCB0aGlzIGNoYW5nZSBmb3Igc2V2ZXJhbCByZWFzb25zLCBpdCdzIHJlYWQt
b25seSBzbyBtYWtpbmcgaXQgY29uc3QgaXMgYWx3YXlzIHNlbnNpYmxlLiAgTWFraW5nIGl0IHN0
YXRpYyBtZWFucyB3ZSBkb24ndCBnZXQgdGhlIGNvbXBpbGVyIHRvIGdlbmVyYXRlIG9iamVjdCBj
b2RlIHRoYXQgc3RvcmVzIHRoZSBhcnJheSBvbiB0aGUgc3RhY2sgKGVhY2ggdGltZSBpdCdzIGNh
bGxlZCkgYW5kIHRoZW4gaW5kZXggaW50byBpdCwgaW5zdGVhZCB0aGUgZGF0YSBpcyBwdXQgaW50
byBhIHJlYWQtb25seSBkYXRhIHNlY3Rpb24gYXQgY29tcGlsZSB0aW1uZSBhbmQgdGhlIG9iamVj
dCBjb2RlIGp1c3QgZmV0Y2hlZCBkYXRhIGZyb20gdGhpcyBhcnJheS4NCj4gDQo+IEJhc2ljYWxs
eSwgaWYgaXQncyByZWFkLW9ubHkgaXQncyBnb29kIHRvIG1ha2UgaXQgY29uc3QgYW5kIGl0J3Mg
bm90IGluIGFuIF9faW5pdCBzZWN0aW9uIHRoZW4geW91IG1heSBhcyB3ZWxsIG1ha2UgaXQgc3Rh
dGljIGNvbnN0LiBJdCdzIHNjb3BlZCBpbnNpZGUgdGhlIGZ1bmN0aW9uLCBldmVuIHRob3VnaCBp
dCdzIGluIHRoZSBkYXRhIHNlY3Rpb24uDQo+IA0KDQpUaGF0J3MgZmFpci4gSSBkb24ndCBoYXZl
IGEgc3RyaWN0IHByZWZlcmVuY2UgaGVyZS4gRmVlbCBmcmVlIHRvIGFkZDoNCg0KUmV2aWV3ZWQt
Ynk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNvbT4NCg0KLVN1bWl0DQoN
Cj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IEZyb206IHJ5YW4gZm9z
dGVyIDxmb3N0ZXIucnlhbi5yQGdtYWlsLmNvbT4NCj4gU2VudDogMTIgSmFudWFyeSAyMDI2IDE0
OjQ2DQo+IFRvOiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGtlcm5lbC5vcmc+DQo+IENjOiBDb2xp
biBLaW5nIDxjb2tpbmdAbnZpZGlhLmNvbT47IEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRl
ckBsaW5hcm8ub3JnPjsgb3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmcgPG9wLXRlZUBs
aXN0cy50cnVzdGVkZmlybXdhcmUub3JnPjsga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9y
ZyA8a2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdW25leHRdIG9wdGVlOiBtYWtlIHJlYWQtb25seSBhcnJheSBhdHRyIHN0YXRpYyBjb25z
dA0KPiANCj4gVGhpcyBsb29rcyBsaWtlIGEgbWljcm8tb3B0aW1pemF0aW9uLCBjb25zdCBtYWtl
cyB0aGUgbG9va3VwIGFycmF5DQo+IGV4cGxpY2l0bHkgaW1tdXRhYmxlLCBhbmQgc3RhdGljIGtl
ZXBzIGl0IG91dCBvZiB0aGUgc3RhY2sgZnJhbWUsDQo+IGF2b2lkaW5nIHBlci1jYWxsIGluaXRp
YWxpemF0aW9uLg0KPiANCj4gSXMgdGhlcmUgYSBzdHlsZSBwcmVmZXJlbmNlIGZvciByZWFkIG9u
bHkgbG9va3VwIGFycmF5cyBoZXJlLCBlLmcuDQo+IFNob3VsZCB0aGVzZSB2YXJpYWJsZXMgcmVt
YWluIGxvY2FsIGJ1dCBub3Qgc3RhdGljLCBvciBzaG91bGQgdGhleSBiZQ0KPiBtb3ZlZCB0byBm
aWxlIHNjb3BlIHN0YXRpYyBjb25zdD8NCj4gDQo+IE9uIE1vbiwgSmFuIDEyLCAyMDI2IGF0IDM6
MjbigK9BTSBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+
ID4gT24gRnJpLCBKYW4gMDksIDIwMjYgYXQgMDM6NDQ6NDJQTSArMDAwMCwgQ29saW4gSWFuIEtp
bmcgd3JvdGU6DQo+ID4gPiBEb24ndCBwb3B1bGF0ZSB0aGUgcmVhZC1vbmx5IGFycmF5IGF0dHIg
b24gdGhlIHN0YWNrIGF0IHJ1bg0KPiA+ID4gdGltZSwgaW5zdGVhZCBtYWtlIGl0IHN0YXRpYyBj
b25zdC4NCj4gPg0KPiA+IElzIHRoZXJlIGFueSB2YWx1ZSBhZGQgdG8gZG8gdGhpcz8gQUZBSUss
IHRoZSBzdGF0aWMgbG9jYWwgdmFyaWFibGVzDQo+ID4gYXJlbid0IHByZWZmZXJlZC4NCj4gPg0K
PiA+IC1TdW1pdA0KPiA+DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtp
bmcgPGNva2luZ0BudmlkaWEuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy90ZWUvb3B0
ZWUvcnBjLmMgfCAyICstDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL29wdGVl
L3JwYy5jIGIvZHJpdmVycy90ZWUvb3B0ZWUvcnBjLmMNCj4gPiA+IGluZGV4IDk3ZmM1YjE0ZGIw
Yy4uMTc1OGViN2U2ZThiIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy90ZWUvb3B0ZWUvcnBj
LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL3JwYy5jDQo+ID4gPiBAQCAtNDMsNyAr
NDMsNyBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfcnBjX2Z1bmNfY21kX2kyY190cmFuc2ZlcihzdHJ1
Y3QgdGVlX2NvbnRleHQgKmN0eCwNCj4gPiA+ICAgICAgIHN0cnVjdCBpMmNfbXNnIG1zZyA9IHsg
fTsNCj4gPiA+ICAgICAgIHNpemVfdCBpOw0KPiA+ID4gICAgICAgaW50IHJldCA9IC1FT1BOT1RT
VVBQOw0KPiA+ID4gLSAgICAgdTggYXR0cltdID0gew0KPiA+ID4gKyAgICAgc3RhdGljIGNvbnN0
IHU4IGF0dHJbXSA9IHsNCj4gPiA+ICAgICAgICAgICAgICAgVEVFX0lPQ1RMX1BBUkFNX0FUVFJf
VFlQRV9WQUxVRV9JTlBVVCwNCj4gPiA+ICAgICAgICAgICAgICAgVEVFX0lPQ1RMX1BBUkFNX0FU
VFJfVFlQRV9WQUxVRV9JTlBVVCwNCj4gPiA+ICAgICAgICAgICAgICAgVEVFX0lPQ1RMX1BBUkFN
X0FUVFJfVFlQRV9NRU1SRUZfSU5PVVQsDQo+ID4gPiAtLQ0KPiA+ID4gMi41MS4wDQo+ID4gPg0K
PiA+DQo=
