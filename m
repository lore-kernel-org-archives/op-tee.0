Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D38EE67801
	for <op-tee@archiver.kernel.org>; Mon, 22 Dec 2025 16:56:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C86EE41A36
	for <op-tee@archiver.kernel.org>; Mon, 22 Dec 2025 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1766422584;
	bh=BeOojRyvMMksqaacMLkRoQnnDCjxkB+vKf7N+16AMNE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0YEXLQOC8kvTsIcfbJNQjh+hMq1m3/tVz1mGz0NYHFO2e1hIeC/M8LJjPXpyB7ZXv
	 ODEbivHeWFXye2vF0bgvNqUW20oB0ccEtQrZz0hjluAxULCbHWnuqEVvrLVb06WAKs
	 VZ13uD3fW6GCqePfYUTH2wM2u1HsgSrC1rC7UvT3yGXVz96rIA0WdgVosC91bj+LJy
	 MB3L1O4SfBfu2V3eUedCFUuWzRd09jXhWlcOuNgJ+qXiWtL9Lur+JNH+HGgP8jJohK
	 o5PXMbB0qv8KXT03DacCAPeTwI7KVuF4qa6XLvBGzBqMOVSEdcfhr+S+/Av47ubXOq
	 dygP9uJWaC76w==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 16A8841855
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Dec 2025 16:56:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kreVB2St;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 72DF66014C;
	Mon, 22 Dec 2025 16:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8997C4CEF1;
	Mon, 22 Dec 2025 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766422565;
	bh=JxAADdyyQ7ctATL4DltTwVQbvm24Y6J8JBJy85MNs+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kreVB2StV6WmihcqLEgBGTNDhSwld/Td8kdjd5QSOyyVby2IhyS8NeeL6nQbwydmB
	 hdLtDizFQNbxegbGgvLP2Vu7laAX2WauQILayhLXSELchzW7FrorAuWvtUsS0WQv+y
	 beLrrsFY6heCUJN2LBC7ygNr5jJQfklcLHCd0D6NfSCryl7y+fImy6vEaVKbqlHHEh
	 KN77fIZRTf/Mo5cLt1Jy0aKI6YpTXTsHo7fR9Bktsz3+JiVJ+7g4vC0i1qnbs0ZGLe
	 ilPGuJh9yLz2UmacJcigZ7ltGnysCGf/13bsG3Ff+F6Ebje2yA/EwDDiuzxtDQP+FP
	 Q7ilK1FT7ZhCA==
Date: Mon, 22 Dec 2025 10:56:01 -0600
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
Message-ID: <cr5ryvw2zblk44zxb3cbwqglhqs5gq4iy6gcfjrofdal5khvsr@g6txeiqgoneu>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
 <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
 <aTtvHYDOny33yeOD@sumit-X1>
 <0a4368bf-40a2-42bb-b538-6e64c11598e3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <0a4368bf-40a2-42bb-b538-6e64c11598e3@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 16A8841855
X-Spamd-Bar: ---
Message-ID-Hash: AJMU62RIATUKI6E5XUL2AWTNQZNVQ24A
X-Message-ID-Hash: AJMU62RIATUKI6E5XUL2AWTNQZNVQ24A
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AJMU62RIATUKI6E5XUL2AWTNQZNVQ24A/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>

T24gTW9uLCBEZWMgMTUsIDIwMjUgYXQgMDQ6NTA6MzlQTSArMDUzMCwgSGFyc2hhbCBEZXYgd3Jv
dGU6DQo+IEhpIGFsbCwNCj4gDQo+IE9uIDEyLzEyLzIwMjUgNjo1NSBBTSwgU3VtaXQgR2FyZyB3
cm90ZToNCj4gPiBPbiBXZWQsIERlYyAxMCwgMjAyNSBhdCAwMjozNToxOVBNICswNTMwLCBIYXJz
aGFsIERldiB3cm90ZToNCj4gPj4gSGkgQmpvcm4sDQo+ID4+DQo+ID4+IE9uIDEyLzEwLzIwMjUg
OToyMSBBTSwgQmpvcm4gQW5kZXJzc29uIHdyb3RlOg0KPiA+Pj4gT24gTW9uLCBEZWMgOCwgMjAy
NSBhdCAxMDoxNOKAr1BNIERtaXRyeSBCYXJ5c2hrb3YNCj4gPj4+IDxkbWl0cnkuYmFyeXNoa292
QG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPiA+Pj4+IE9uIFR1ZSwgOSBEZWMgMjAyNSBhdCAw
Nzo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPj4+
Pj4NCj4gPj4+Pj4gT24gMDgvMTIvMjAyNSAxMzoxOCwgSGFyc2hhbCBEZXYgd3JvdGU6DQo+ID4+
Pj4+PiBFbmFibGUgUUNPTVRFRSBkcml2ZXIgb24gUXVhbGNvbW0gU004NjUwKyBTb0NzIHRvIGZh
Y2lsaXRhdGUgY29tbXVuaWNhdGlvbg0KPiA+Pj4+Pj4gd2l0aCB0aGUgUXVhbGNvbW0gVHJ1c3Rl
ZCBFeGVjdXRpb24gRW52aXJvbm1lbnQgKFFURUUpLg0KPiA+Pj4+Pj4gKE5vIGVuYWJsZW1lbnQg
cmVxdWlyZWQgaW4gRFRTIGZpbGVzIHNpbmNlIFFDT01URUUgZGV2aWNlIGlzIGR5bmFtaWNhbGx5
DQo+ID4+Pj4+PiByZWdpc3RlcmVkIGJ5IHRoZSBRQ09NX1NDTSBmaXJtd2FyZSBkcml2ZXIpDQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSGFyc2hhbCBEZXYgPGhhcnNoYWwuZGV2
QG9zcy5xdWFsY29tbS5jb20+DQo+ID4+Pj4+PiAtLS0NCj4gPj4+Pj4+IENoYW5nZXMgaW4gdjM6
DQo+ID4+Pj4+PiAtIFVwZGF0ZWQgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIHJlZmxlY3QgdGhlIHN1
cHBvcnRlZCBRdWFsY29tbSBwbGF0Zm9ybXMuDQo+ID4+Pj4+PiAtIExpbmsgdG8gdjI6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTEyMDUtcWNvbV9xY29tdGVlX2RlZmNvbmZpZy12Mi0x
LWM5MjU2MGIwMzQ2ZUBxdGkucXVhbGNvbW0uY29tDQo+ID4+Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+
PiBJIGdhdmUgeW91IHRoZSBleGFjdCBleGFtcGxlIHRvIGZvbGxvdy4gTWF5YmUgaXQgaXMgbm90
IHRoYXQgaW1wb3J0YW50DQo+ID4+Pj4+IGZvciBvdGhlcnMsIHNvIEkgd2lsbCBub3Qgb2JqZWN0
LCBidXQgT1RPSCBpdCBpcyBpbXBvcnRhbnQgZm9yIG1lLCB0aHVzDQo+ID4+Pj4+IEkgd2lsbCBu
b3QgZ2l2ZSByZXZpZXdlZCBieS4gSSBkYW1uIGFza2VkIFZFUlkgQ0xFQVJMWToNCj4gPj4+Pj4N
Cj4gPj4+Pj4gIkp1c3QgbWVudGlvbiB3aGljaCBVUFNUUkVBTSBib2FyZHMgKHdoaWNoIHlvdSBj
YWxsZWQgUXVhbGNvbW0NCj4gPj4+Pj4gcGxhdGZvcm1zKSB1c2UgdGhpcyBkcml2ZXIuIg0KPiA+
Pj4+DQo+ID4+Pj4gKzEgSGVyZS4gRGVmY29uZmlnIGNoYW5nZXMgbWVudGlvbiBkZXZpY2VzLCBu
b3QgU29DIGZhbWlsaWVzLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gSSBkb24ndCBhZ3JlZSB0aGF0
IHlvdSBoYXZlIHRvIG1lbnRpb24gYSBzcGVjaWZpYyBib2FyZCwgaWYgdGhlDQo+ID4+PiBmZWF0
dXJlIGlzIHVzZWQgYnkgYWxsIGJvYXJkcy4gQnV0IEkgdGhpbmsgdGhlIGNvbW1pdCBtZXNzYWdl
IHNob3VsZA0KPiA+Pj4gbWFrZSBfdGhhdF8gY2xlYXIuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBUaGFu
a3MgZm9yIHRoaXMgaW5wdXQgQmpvcm4uIEkgZ2F0aGVyIHdlIGFyZSBub3cgYWxpZ25lZCB0aGF0
IHRoZSBib2FyZA0KPiA+PiBpbmZvcm1hdGlvbiBpcyBub3QgcmVxdWlyZWQuDQo+ID4+DQo+ID4+
IFRoZW4gdGhlIG90aGVyIHBhcnQgdG8gdGhpcyBpcyBob3cgdG8gcHJvdmlkZSBpbmZvcm1hdGlv
biBvbiB0aGUgcGFydGljdWxhcg0KPiA+PiBTb0NzIHVzaW5nIHRoaXMuDQo+ID4+DQo+ID4+PiBP
biB0aGUgY29udHJhcnksIHRoZSBjb21taXQgbWVzc2FnZSBzYXlzIHRoYXQgd2UncmUgZW5hYmxp
bmcNCj4gPj4+IENPTkZJR19RQ09NVEVFIGJlY2F1c2UgaXQncyB1c2VkIG9uICJTTTg1NjArIi4g
V2hhdCBkb2VzIHRoZSBwbHVzDQo+ID4+PiBtZWFuPw0KPiA+Pg0KPiA+PiBJIHRvb2sgcmVmZXJl
bmNlIGZyb20gc2ltaWxhciBjb21taXRzIG1lcmdlZCBlYXJsaWVyIHdoZXJlIHRoZSBwbHVzIHNl
ZW1lZA0KPiA+PiB0byBpbmRpY2F0ZSB0aGF0IGFsbCBRdWFsY29tbSBTb0NzIGZyb20gJ1NNODY1
MCcgb24td2FyZHMsIHRoYXQgaXMsIFNNODc1MCwNCj4gPj4gU004ODUwIGFuZCBzbyBvbi4gSXQg
ZmVsdCB0aGF0IHRoZSBwbHVzIHNpZ24gaXMgc2VsZi1leHBsYW5hdG9yeSBzaW5jZSBpdA0KPiA+
PiBoYXMgYmVlbiB1c2VkIGFscmVhZHkuIEJ1dCBzdXJlLCBtYXliZSB3ZSBjYW4gYmUgZXhwbGlj
aXQgZnJvbSBub3cgb24gYW5kIHNheQ0KPiA+PiBmcm9tICdRdWFsY29tbSBTTTg2NTAgb253YXJk
cycuDQo+ID4+DQo+ID4+IGNvbW1pdCBjNWQwMmJiYWEyMTdiMjQ1NGJhMWNlNzUyODExM2FhMmVj
ZjE0ZjNjDQo+ID4+DQo+ID4+PiBBbHNvLCB0aGUgZHJpdmVyIGlzbid0IGVuYWJsZWQgIm9uIFF1
YWxjb21tIFNNODY1MCsiLCBpdCdzIGVuYWJsZWQgaW4NCj4gPj4+IHRoZSBBbTY0IGRlZmNvbmZp
ZywgaS5lLiBpdCdzIGVuYWJsZWQgb24gYWxsIEFybTY0IGJvYXJkcyAtIHRoZQ0KPiA+Pj4gcXVl
c3Rpb24gdGhhdCBzaG91bGQgYmUgYW5zd2VyZWQgYnkgdGhlIGNvbW1pdCBtZXNzYWdlIGlzICJ3
aHk/Ii4NCj4gPj4+DQo+ID4+DQo+ID4+IEV2ZW4gdGhvdWdoIHdlIGFyZSBlbmFibGluZyB0aGlz
IHZpYSB0aGUgYXJtNjQgZGVmY29uZmlnLCBpdCBpcyBub3QgdHJ1ZSB0aGF0DQo+ID4+IHRoZSBk
cml2ZXIgaXMgYXBwbGljYWJsZSBmb3IgYWxsIGFybTY0IGJvYXJkcy4gVGhlIHNpbXBsZSByZWFz
b24gYmVpbmcgdGhhdA0KPiA+PiB0aGUgUVRFRSBmaXJtd2FyZSBPUyB0aGF0IHRoZSBkcml2ZXIg
Y29tbXVuaWNhdGVzIHdpdGggcnVucyBvbmx5IG9uIFF1YWxjb21tDQo+ID4+IFNvQ3MgdXNpbmcg
YXJtNjQgQ1BVcyB3aXRoIEFSTSBUcnVzdFpvbmUgdGVjaG5vbG9neS4NCj4gPj4NCj4gPj4gVGhp
cyBpcyB3aHkgSSB3b3VsZCB0cnkgdG8gYXZvaWQgYSBjb21taXQgbWVzc2FnZSB3aGljaCBjbGFp
bXMgdGhlIHRoZSBkcml2ZXINCj4gPj4gaXMgYXBwbGljYWJsZSB0byBhbGwgYXJtNjQgYm9hcmRz
Lg0KPiA+Pg0KPiA+PiBCYXNlZCBvbiBhbGwgdGhpcywgSSBhbSB0aGlua2luZyBwZXJoYXBzIGl0
IHdvdWxkIGJlIGJldHRlciB0byBzYXkgdGhhdCB0aGUNCj4gPj4gcGF0Y2ggZW5hYmxlcyBRQ09N
VEVFIGRyaXZlciBmb3IgUXVhbGNvbW0gU29DcyB3aXRoIGFybTY0IENQVXM/IFdlIGNvdWxkIGRy
b3ANCj4gPj4gbWVudGlvbnMgb2Ygc3BlY2lmaWMgU004eDUwIG1vZGVscyB3aXRoIEhESy9NVFAg
Ym9hcmRzIHNpbmNlIHRoZSBmZWF0dXJlIGlzDQo+ID4+IGFnbm9zdGljIHRvIHRob3NlPw0KPiA+
IA0KPiA+IEFGQUlLLCB0aGUgUUNPTVRFRSBkcml2ZXIgd29ya3Mgb24gdGhlIFFjb20gU29DcyBi
YXNlZCBvbiBhcm02NCB3aGljaCBzdXBwb3J0cw0KPiA+IHRoZSBTTUNJbnZva2UgcHJvdG9jb2wu
IFNvIHdlIHNob3VsZCBiZSBleHBsaWNpdCBhYm91dCBpdC4gUmVnYXJkaW5nDQo+ID4gbWVudGlv
biBvZiByZWZlcmVuY2UgcHVibGljbHkgYXZhaWxhYmxlIGJvYXJkcywgSSBjYW4gc2VlIGhvdyBp
dCBjYW4gYmUgdXNlZnVsDQo+ID4gZm9yIHRoZSBjb21tdW5pdHkgdG8gdGVzdCBRVEVFIGJhc2Vk
IGFwcHMuIElmIHlvdSBjYW4gbWVudGlvbiBzYXkNCj4gPiBleGFtcGxlIFJCM0dlbjIgc3VwcG9y
dHMgUVRFRSBkcml2ZXIgYXQgbGVhc3QgdGhlbiBpdCB3aWxsIGJlIGhlbHBmdWwuDQo+ID4gDQo+
IA0KPiBCYXNlZCBvbiBjb25zb2xpZGF0ZWQgZmVlZGJhY2sgb24gdGhpcyB0aHJlYWQsIEkgYW0g
dGhpbmtpbmcgb2YgdGhlIGZvbGxvd2luZw0KPiBjb21taXQgbWVzc2FnZSwgbGV0IG1lIGtub3cg
aWYgdGhpcyBpcyBhIGdvIGZyb20gZXZlcnlvbmUncyBwZXJzcGVjdGl2ZToNCj4gDQo+ICINCj4g
YXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxlIFFDT01URUUgZm9yIFF1YWxjb21tIFNvQ3MgdXNpbmcg
YXJtNjQgQ1BVcw0KPiANCj4gRW5hYmxlIFFDT01URUUgZHJpdmVyIGFzIGEgbW9kdWxlIGZvciBR
dWFsY29tbSBTb0NzIGJhc2VkIG9uIGFybTY0IENQVXMgYW5kDQo+IHN1cHBvcnRpbmcgdGhlIFNN
Q0ludm9rZSBwcm90b2NvbCBmb3IgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSBRdWFsY29tbSBUcnVz
dGVkDQo+IEV4ZWN1dGlvbiBFbnZpcm9ubWVudCAoUVRFRSkuDQo+IA0KPiBUaGUgZHJpdmVyIGlz
IHRlc3RlZCBvbiBhIFF1YWxjb21tIFJCM0dlbjIgYm9hcmQgYnkgbG9hZGluZyBhbmQgZXhlY3V0
aW5nIGENCj4gVHJ1c3RlZCBBcHBsaWNhdGlvbiB2aWEgdGVzdHMgaG9zdGVkIGF0IHd3dy5naXRo
dWIuY29tL3F1YWxjb21tL21pbmtpcGMuDQo+ICINCg0KSSBkb24ndCB0aGluayB0aGlzIGFuc3dl
cnMgS3J6eXN6dG9mJ3MgcXVlc3Rpb24sIGFuZCBpdCBkb2Vzbid0IGFkZHJlc3MNCm15IGNvbmNl
cm4uDQoNCllvdSdyZSBzYXlpbmcgdGhhdCB5b3UncmUgZW5hYmxpbmcgdGhlIGRyaXZlciBmb3Ig
UXVhbGNvbW0tYmFzZWQgQXJtNjQNClNvQyB3aGljaCBzdXBwb3J0cyBTTUNJbnZva2UuIEJ1dCBh
cyBJIHNhaWQsIHRoYXQncyBub3Qgd2hhdCB5b3UncmUNCmRvaW5nOyB5b3UgYXJlIGVuYWJsaW5n
IHRoZSBkcml2ZXIgZm9yIGFsbCBBcm02NCBib2FyZHMsIGZyb20gYWxsDQp2ZW5kb3JzLCByZWdh
cmRsZXNzIG9mIHRoZW0gaGF2aW5nIFNNQ0ludm9rZSBvciBub3QuDQoNClRoZSBjb21taXQgbWVz
c2FnZSBzaG91bGQgYmUgaW4gdGhlIGZvcm0gb2Y6DQoNCiJBbGwgUVRFRS1iYXNlZCBRdWFsY29t
bSB0YXJnZXRzLCBzaW5jZSBTTTEyMzQsIHByb3ZpZGVzIGFjY2VzcyB0byB0aGUNCnNlY3VyZSB3
b3JsZCB0aHJvdWdoIHRoZSBTTUNJbnZva2UgaW50ZXJmYWNlLCB3aGljaCBpcyBpbXBsZW1lbnRl
ZCBpbg0KdGhlIHFjb210ZWUgZHJpdmVyLiBFbmFibGUgdGhpcyBkcml2ZXIgaW4gb3JkZXIgdG8g
Li4uIg0KDQpSZWdhcmRzLA0KQmpvcm4NCg0KPiANCj4gUmVnYXJkcywNCj4gSGFyc2hhbA0KPiAN
Cj4gPiAtU3VtaXQNCj4gPiANCj4gPiBbLi4uXQ0KPiANCg==
