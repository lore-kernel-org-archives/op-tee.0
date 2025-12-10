Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DFFD3B9A9
	for <op-tee@archiver.kernel.org>; Wed, 10 Dec 2025 05:20:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 18F56500CC
	for <op-tee@archiver.kernel.org>; Wed, 10 Dec 2025 05:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765344026;
	bh=X1MX/8pNYn2Vb0lJbLWoL1M0SdUxVP8zOB3QRuw38Ws=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=NyZzzoAk32hX+XUEMvcUAQ7SWn+adkLgkuPNhKAgFBvLE4Y07ONYseRsoliRv9NH6
	 M6/WAoWUijtZrcExPsR12+0RO4uBbDr/U3N8deAS4KMERnvSxu2dGXDUrazIPaKpBi
	 jbjC9jeTKxuUlcfAaxcXW+56TVtXMpUgIFnwul5iWIL1vd1nt0+iIE1GAlNX0uviDf
	 0iNLPRfnD7cYC3k8J6z1W2pF+5niqj6PINF4+dQD7L9A2MjDeWMmHrmmM45OL3W9U/
	 8UTjpNBivpRmFd7NIfMK5+oahu6aEaCr5hJWsV+FUfhcqUOpsfWVpKc0ASrVOHkdex
	 QWqS3+W8rSBZQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 09F20431BF
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Dec 2025 05:20:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SsfZKs1Z;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4802F442DF;
	Wed, 10 Dec 2025 05:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17BEC4CEF1;
	Wed, 10 Dec 2025 05:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765344014;
	bh=duyP/pNcSFV92zMHIv11+7o95Ig9HFi0n0cFQcF1pMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SsfZKs1ZoO75kYg0STDW20p1c/BYzSSXS4UOyOz2rm9s+53q6Pi9vRbzOuPWaEyXO
	 w1wrE9TEBQJYLVdeEdRA8v1ch6YMOLuFt/4aeLrbWMM4jsbAFzWtJHNsOSyDpRfIC0
	 QaaMNHLfWWENN7+T8DQIQyuDh9V9Eth3+M0kLt3S8uFzxbikKhdQRs+hoTTp9yo+m1
	 HGvlUiCQwnWhW5Q2g95HPsfgKZdRhs7fcF1hsc9A5bGfkt/EoLoE5YVZZYybv/FEqA
	 dMHvx639cCj4dL8KAeiKxNGKB+ofeFaKdQIRBFmbGt2QWe66aZ2bzJ6YxcdQoykVOO
	 oiAwAipxQtHTw==
Message-ID: <74a5319a-2801-4789-a3fe-fafaaa15cee1@kernel.org>
Date: Wed, 10 Dec 2025 06:20:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 09F20431BF
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: UIMH4WTRQURG3NCOTUGBDQ5OCKMR5VKN
X-Message-ID-Hash: UIMH4WTRQURG3NCOTUGBDQ5OCKMR5VKN
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <harshal.dev@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UIMH4WTRQURG3NCOTUGBDQ5OCKMR5VKN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

T24gMTAvMTIvMjAyNSAwNDo1MSwgQmpvcm4gQW5kZXJzc29uIHdyb3RlOg0KPiBPbiBNb24sIERl
YyA4LCAyMDI1IGF0IDEwOjE04oCvUE0gRG1pdHJ5IEJhcnlzaGtvdg0KPiA8ZG1pdHJ5LmJhcnlz
aGtvdkBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToNCj4+IE9uIFR1ZSwgOSBEZWMgMjAyNSBhdCAw
Nzo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiB3cm90ZToNCj4+Pg0K
Pj4+IE9uIDA4LzEyLzIwMjUgMTM6MTgsIEhhcnNoYWwgRGV2IHdyb3RlOg0KPj4+PiBFbmFibGUg
UUNPTVRFRSBkcml2ZXIgb24gUXVhbGNvbW0gU004NjUwKyBTb0NzIHRvIGZhY2lsaXRhdGUgY29t
bXVuaWNhdGlvbg0KPj4+PiB3aXRoIHRoZSBRdWFsY29tbSBUcnVzdGVkIEV4ZWN1dGlvbiBFbnZp
cm9ubWVudCAoUVRFRSkuDQo+Pj4+IChObyBlbmFibGVtZW50IHJlcXVpcmVkIGluIERUUyBmaWxl
cyBzaW5jZSBRQ09NVEVFIGRldmljZSBpcyBkeW5hbWljYWxseQ0KPj4+PiByZWdpc3RlcmVkIGJ5
IHRoZSBRQ09NX1NDTSBmaXJtd2FyZSBkcml2ZXIpDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IEhhcnNoYWwgRGV2IDxoYXJzaGFsLmRldkBvc3MucXVhbGNvbW0uY29tPg0KPj4+PiAtLS0NCj4+
Pj4gQ2hhbmdlcyBpbiB2MzoNCj4+Pj4gLSBVcGRhdGVkIHRoZSBjb21taXQgbWVzc2FnZSB0byBy
ZWZsZWN0IHRoZSBzdXBwb3J0ZWQgUXVhbGNvbW0gcGxhdGZvcm1zLg0KPj4+PiAtIExpbmsgdG8g
djI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTEyMDUtcWNvbV9xY29tdGVlX2RlZmNv
bmZpZy12Mi0xLWM5MjU2MGIwMzQ2ZUBxdGkucXVhbGNvbW0uY29tDQo+Pj4+DQo+Pj4NCj4+PiBJ
IGdhdmUgeW91IHRoZSBleGFjdCBleGFtcGxlIHRvIGZvbGxvdy4gTWF5YmUgaXQgaXMgbm90IHRo
YXQgaW1wb3J0YW50DQo+Pj4gZm9yIG90aGVycywgc28gSSB3aWxsIG5vdCBvYmplY3QsIGJ1dCBP
VE9IIGl0IGlzIGltcG9ydGFudCBmb3IgbWUsIHRodXMNCj4+PiBJIHdpbGwgbm90IGdpdmUgcmV2
aWV3ZWQgYnkuIEkgZGFtbiBhc2tlZCBWRVJZIENMRUFSTFk6DQo+Pj4NCj4+PiAiSnVzdCBtZW50
aW9uIHdoaWNoIFVQU1RSRUFNIGJvYXJkcyAod2hpY2ggeW91IGNhbGxlZCBRdWFsY29tbQ0KPj4+
IHBsYXRmb3JtcykgdXNlIHRoaXMgZHJpdmVyLiINCj4+DQo+PiArMSBIZXJlLiBEZWZjb25maWcg
Y2hhbmdlcyBtZW50aW9uIGRldmljZXMsIG5vdCBTb0MgZmFtaWxpZXMuDQo+Pg0KPiANCj4gSSBk
b24ndCBhZ3JlZSB0aGF0IHlvdSBoYXZlIHRvIG1lbnRpb24gYSBzcGVjaWZpYyBib2FyZCwgaWYg
dGhlDQo+IGZlYXR1cmUgaXMgdXNlZCBieSBhbGwgYm9hcmRzLiBCdXQgSSB0aGluayB0aGUgY29t
bWl0IG1lc3NhZ2Ugc2hvdWxkDQo+IG1ha2UgX3RoYXRfIGNsZWFyLg0KDQoNClllcywgdGhhdCB3
b3VsZCBiZSBlbm91Z2ggYW5kIEkgd291bGQgYmUgZmluZSB3aXRoIGl0IGFzIHdlbGwsIGJ1dCBJ
IGRpZA0Kbm90IGhhdmUgdGhhdCBpbXByZXNzaW9uIGZyb20gdGhlIGNvbW1pdCBtc2cuDQoNCg0K
QmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQo=
