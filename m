Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AF2C8303C
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 12:37:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 093F2430CC
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1751891850;
	bh=nBjQJ5Wn0ehY32llVPcBxlYv0tJwRb5+rabu0BAiQEo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Kwng6WDsK7WgZety2ivTNzHe4x8GBTqsMJoyofLT11J5XNr7qbMZTzePkKf2D1p3s
	 eJ9SmArhYRuhqVgnQ8GDtY6y5vSOnztQZhdnEvHLE4gEiHEoi9msVJ6qVRp2Mxudg/
	 BtD6m30Z2EogK1g4FBpIHzH7Udh/pgmFBNC2l+SftpCq2GSGTLWlHtCVnlJ8/Pq9NF
	 cP9dI0W/m6UFsBCmvzEKvRr8/ftudz9ie+lZbRQG/jHff7DYaNrJ+5JF4seGmaL30U
	 /UuyZzHSZxLEtd20V3l2KpFYnP5119TMcOEqosRLsya+q/gTiJJxO9kIpXyzr7bv2I
	 0wGqx5xgz2ynQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AC0323F6B0
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Jul 2025 12:37:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eNQI3tqy;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F0D2545059;
	Mon,  7 Jul 2025 12:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7B2C4CEE3;
	Mon,  7 Jul 2025 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751891826;
	bh=aXefSW8u73uhesaby/quxrwQtn0umxAwODIuttM0MfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNQI3tqy+5/Gxraoq67KEs1JIuhnAPkqesxyrE/kXrVlYH5iIOvarGHR38hRTNS4U
	 AHEPLJjK9mxWZ6ADoZ5k9ewhBGSkWJOP6V3UKAlcmIiZget+0zLk3RijNkJTZINoym
	 7Fimjm6vPcdNjyGo7poz3lOpTGA1o0yurHf0KVOVHo3h4chNzHPEmOqbQlLog8EaJY
	 F+bLcysHgB4NCQ3V7hk9T5OOYZ8HWtKXz0sjsxZcEILKCJgMgmuwqS98UraYZEXLPC
	 Wsi1lEsSdzDbl98HuSsjWAgzjfDb7KeZ4IP9zBlUy4I7DVEOePgRRZI9xWsJTipJVl
	 kohjI7Yovb7TQ==
Date: Mon, 7 Jul 2025 18:07:02 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v10 3/9] tee: implement protected DMA-heap
Message-ID: <aGu_bgKuSDJUKUoP@sumit-X1>
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-4-jens.wiklander@linaro.org>
 <b1a71f06-901e-47fb-9e27-9d401d26f7fc@oss.qualcomm.com>
 <CAHUa44FV_maNF1Xx0hnqGT3=DnM3zEnLj6CLcz7pZvxEPmiGJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44FV_maNF1Xx0hnqGT3=DnM3zEnLj6CLcz7pZvxEPmiGJw@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AC0323F6B0
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RBL_SENDERSCORE_REPUT_9(-1.00)[172.234.252.31:from];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.234.252.31:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: 7HOABNTEVMCTQGWQHWQE3R7T76LJRZPC
X-Message-ID-Hash: 7HOABNTEVMCTQGWQHWQE3R7T76LJRZPC
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7HOABNTEVMCTQGWQHWQE3R7T76LJRZPC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gTW9uLCBKdWwgMDcsIDIwMjUgYXQgMDE6MjI6MTlQTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IEhpIEFtaXIsDQo+IA0KPiBPbiBNb24sIEp1bCA3LCAyMDI1IGF0IDQ6MjLigK9B
TSBBbWlycmV6YSBaYXJyYWJpIHZpYSBPUC1URUUNCj4gPG9wLXRlZUBsaXN0cy50cnVzdGVkZmly
bXdhcmUub3JnPiB3cm90ZToNCj4gPg0KPiA+IEhpIEplbnMsDQo+ID4NCj4gPiBPbiA2LzEwLzIw
MjUgMTE6MTMgUE0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiA+ID4gSW1wbGVtZW50IERNQSBo
ZWFwIGZvciBwcm90ZWN0ZWQgRE1BLWJ1ZiBhbGxvY2F0aW9uIGluIHRoZSBURUUNCj4gPiA+IHN1
YnN5c3RlbS4NCj4gPiA+DQo+ID4gPiBQcm90ZWN0ZWQgbWVtb3J5IHJlZmVycyB0byBtZW1vcnkg
YnVmZmVycyBiZWhpbmQgYSBoYXJkd2FyZSBlbmZvcmNlZA0KPiA+ID4gZmlyZXdhbGwuIEl0IGlz
IG5vdCBhY2Nlc3NpYmxlIHRvIHRoZSBrZXJuZWwgZHVyaW5nIG5vcm1hbCBjaXJjdW1zdGFuY2Vz
DQo+ID4gPiBidXQgcmF0aGVyIG9ubHkgYWNjZXNzaWJsZSB0byBjZXJ0YWluIGhhcmR3YXJlIElQ
cyBvciBDUFVzIGV4ZWN1dGluZyBpbg0KPiA+ID4gaGlnaGVyIG9yIGRpZmZlcmVudGx5IHByaXZp
bGVnZWQgbW9kZSB0aGFuIHRoZSBrZXJuZWwgaXRzZWxmLiBUaGlzDQo+ID4gPiBpbnRlcmZhY2Ug
YWxsb3dzIHRvIGFsbG9jYXRlIGFuZCBtYW5hZ2Ugc3VjaCBwcm90ZWN0ZWQgbWVtb3J5IGJ1ZmZl
cnMNCj4gPiA+IHZpYSBpbnRlcmFjdGlvbiB3aXRoIGEgVEVFIGltcGxlbWVudGF0aW9uLg0KPiA+
ID4NCj4gPiA+IFRoZSBwcm90ZWN0ZWQgbWVtb3J5IGlzIGFsbG9jYXRlZCBmb3IgYSBzcGVjaWZp
YyB1c2UtY2FzZSwgbGlrZSBTZWN1cmUNCj4gPiA+IFZpZGVvIFBsYXliYWNrLCBUcnVzdGVkIFVJ
LCBvciBTZWN1cmUgVmlkZW8gUmVjb3JkaW5nIHdoZXJlIGNlcnRhaW4NCj4gPiA+IGhhcmR3YXJl
IGRldmljZXMgY2FuIGFjY2VzcyB0aGUgbWVtb3J5Lg0KPiA+ID4NCj4gPiA+IFRoZSBETUEtaGVh
cHMgYXJlIGVuYWJsZWQgZXhwbGljaXRseSBieSB0aGUgVEVFIGJhY2tlbmQgZHJpdmVyLiBUaGUg
VEVFDQo+ID4gPiBiYWNrZW5kIGRyaXZlcnMgbmVlZHMgdG8gaW1wbGVtZW50IHByb3RlY3RlZCBt
ZW1vcnkgcG9vbCB0byBtYW5hZ2UgdGhlDQo+ID4gPiBwcm90ZWN0ZWQgbWVtb3J5Lg0KPiA+ID4N
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRlckBsaW5h
cm8ub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy90ZWUvS2NvbmZpZyAgICAgICB8ICAg
NSArDQo+ID4gPiAgZHJpdmVycy90ZWUvTWFrZWZpbGUgICAgICB8ICAgMSArDQo+ID4gPiAgZHJp
dmVycy90ZWUvdGVlX2hlYXAuYyAgICB8IDQ3MiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ID4gIGRyaXZlcnMvdGVlL3RlZV9wcml2YXRlLmggfCAgIDYgKw0KPiA+
ID4gIGluY2x1ZGUvbGludXgvdGVlX2NvcmUuaCAgfCAgNjUgKysrKysrDQo+ID4gPiAgNSBmaWxl
cyBjaGFuZ2VkLCA1NDkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3RlZS90ZWVfaGVhcC5jDQo+ID4gPg0KPiBbc25pcF0NCj4gPg0KPiA+IEknbSBoYXZp
bmcgYSBiaXQgb2YgdHJvdWJsZSB1bmRlcnN0YW5kaW5nIHRoZSByYXRpb25hbGUgYmVoaW5kDQo+
ID4gc3VwcG9ydGluZyB0ZWVfZGV2aWNlX3VucmVnaXN0ZXJfYWxsX2RtYV9oZWFwcygpLiBDb25z
aWRlcmluZyB0aGF0DQo+ID4gdGhlIGhlYXAgcmVtYWlucyBhY2Nlc3NpYmxlIGZyb20gdXNlcnNw
YWNlLCB3b3VsZG4ndCB0aGlzIGxlYWQNCj4gPiB0byB1bmRlZmluZWQgYmVoYXZpb3I/IEZvciBl
eGFtcGxlLCB3aGF0IGhhcHBlbnMgaWYgYSB1c2VyIGlzDQo+ID4gaW4gdGhlIG1pZGRsZSBvZiBh
IHRlZV9kbWFfaGVhcF9hbGxvYygpIC0tIHNwZWNpZmljYWxseSBiZWZvcmUNCj4gPiB0ZWVfZGV2
aWNlX2dldCgpIC0tIHdoaWxlIHRoZSBiYWNrZW5kIGNhbGxzIHRlZV9kZXZpY2VfdW5yZWdpc3Rl
cl9hbGxfZG1hX2hlYXBzKCk/DQo+IA0KPiBUaGF0IGNhbid0IGhhcHBlbiBzaW5jZSB0ZWVfZGV2
aWNlX3VucmVnaXN0ZXIoKSBoYXMgYmVlbiBjYWxsZWQNCj4gYmVmb3JlLCBndWFyYW50ZWVpbmcg
dGhhdCBubyBmdXJ0aGVyIGNhbGxzIHRvIHRlZV9kZXZpY2VfZ2V0KCkgY2FuDQo+IHN1Y2NlZWQu
DQo+IA0KPiA+DQo+ID4gSSB1bmRlcnN0YW5kIHRoYXQgeW91IHdhbnQgdG8gdXNlIHRlZWRldiBy
ZWZjb3VudCB0byBwcm90ZWN0IGFnYWluc3QNCj4gPiB0aGUgVEVFIGRyaXZlciB1bmJpbmRpbmcg
aWYgdGhlcmUgaXMgYSBidWZmZXIgYWxsb2NhdGVkLiBCdXQgd2hhdCBhYm91dA0KPiA+IHRoZSBo
ZWFwIGRldmljZT8NCj4gPg0KPiA+IEFkZGl0aW9uYWxseSwgd2hhdCBpZiB0aGUgdXNlciBkZWNp
ZGVzIHRvIHVuYmluZCB0aGUgVEVFIGJhY2tlbmQgZHJpdmVyPw0KPiA+IFdvdWxkIHRoZSBkbWFf
aGVhcCBkZXZpY2Ugc3RpbGwgcGVyc2lzdCB3aXRob3V0IGFueSBhbGxvYyBmdW5jdGlvbj8NCj4g
DQo+IFllcywgdGhlIGRldmljZSB3b3VsZCBzdGlsbCBiZSB0aGVyZSwgYnV0IGFsbG9jIHdvdWxk
IHJldHVybiAtRUlOVkFMDQo+IHVudGlsIGEgbmV3IGhlYXAgaGFzIGJlZW4gcmVnaXN0ZXJlZC4N
Cj4gQnV0IEkgdGhpbmsgeW91J3JlIG9uIHRvIHNvbWV0aGluZywgd2Ugc2hvdWxkIHBlcmhhcHMg
aW5jcmVhc2UgdGhlIFRFRQ0KPiBtb2R1bGUgcmVmY291bnQgd2hlbiBjYWxsaW5nIGRtYV9oZWFw
X2FkZCgpLiBEbyB5b3UgYWdyZWU/DQoNCkJ1dCB0aGF0IHdvbid0IGFsbG93IHRvIGNsZWFubHkg
dW4tYmluZC9iaW5kIE9QLVRFRSBtb2R1bGUuIEl0IGxvb2tzDQpsaWtlIHdlIHJhdGhlciBuZWVk
IHRvIGVuZm9yY2UgdGhlIE9QLVRFRSBkcml2ZXIgdG8gYmUgYnVpbHQtaW4gaW4gY2FzZQ0KaXQg
aXMgdGhlIHByb3ZpZGVyIG9mIERNQSBoZWFwcy4NCg0KPiANCj4gPg0KPiA+IEluIHRoZSBjYXNl
IG9mIHFjb210ZWUsIG15IG9yaWdpbmFsIGlkZWEgd2FzIHRvIGhhdmUgdHdvIHNlcGFyYXRlDQo+
ID4gZHJpdmVycyBsb2FkZWQgYWxvbmdzaWRlIGVhY2ggb3RoZXIuIFRoaXMgc2V0dXAgd291bGQg
YWxsb3cgdGhlDQo+ID4gVEVFIGJhY2tlbmQgZHJpdmVyIHRvIHN1cHBvcnQgdW5iaW5kaW5nLCB3
aGlsZSB0aGUgcHJvdGVjdGVkIG1lbW9yeQ0KPiA+IGJhY2tlbmQgY291bGQgcmVtYWluIGxvYWRl
ZC4gVGhpcyBzZXBhcmF0aW9uIGlzIHBhcnRpY3VsYXJseSB1c2VmdWwNCj4gPiBmb3IgRkZBLCBv
ciBzY2VuYXJpb3Mgd2hlcmUgdGhlIHByb3RlY3RlZCBidWZmZXIgZG9lcyBub3QgbmVlZCB0byBi
ZQ0KPiA+IHRyYW5zZmVyZWQgdG8gVEVFLg0KPiA+DQo+ID4gT3INCj4gPg0KPiA+IEEgcmVmZXJl
bmNlIHRvIHRlZWRldiBjb3VsZCBiZSBvYnRhaW5lZCB3aGVuIHRoZSBoZWFwIGlzIHJlZ2lzdGVy
ZWQsDQo+ID4gcmF0aGVyIHRoYW4gZm9yIGVhY2ggYnVmZmVyIGFsbG9jYXRpb24uIEluIG90aGVy
IHdvcmRzLCBvbmNlIHRoZSBoZWFwDQo+ID4gaXMgcmVnaXN0ZXJlZCwgdGhlIGJhY2tlbmQgbXVz
dCByZW1haW4gYWN0aXZlIGFuZCBjYW5ub3QgYmUgdW5sb2FkZWQuDQo+ID4NCj4gPiBPcg0KPiA+
DQo+ID4gRmluZCBhIHdheSB0byBoYXZlIHNvbWV0aGluZyBsaWtlIGRtYV9oZWFwX3JtKCk/DQo+
IA0KPiBUaGF0IHdvdWxkIGJlIGhlbHBmdWwsIGJ1dCBJJ2QgcHJlZmVyIHRvIGtlZXAgaXQgb3V0
IG9mIHRoZSBzY29wZSBvZg0KPiB0aGUgcGF0Y2hzZXQgaWYgcG9zc2libGUuDQoNClllYWggbGV0
cyBrZWVwIHRoYXQgZm9yIG5leHQgZmVhdHVyZSBwYXRjaC1zZXQuDQoNCi1TdW1pdA0KDQo+IA0K
PiBUaGFua3MsDQo+IEplbnMNCj4gDQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBt
aXMtdW5kZXJzdG9vZCBzb21ldGhpbmc/IG9yIG1pc3Npbmcgc29tZXRoaW5nIDopDQo+ID4NCj4g
PiBSZWdhcmRzLA0KPiA+IEFtaXINCj4gPg0KPiA+ID4gK3ZvaWQgdGVlX2RldmljZV91bnJlZ2lz
dGVyX2FsbF9kbWFfaGVhcHMoc3RydWN0IHRlZV9kZXZpY2UgKnRlZWRldikNCj4gPiA+ICt7DQo+
ID4gPiArICAgICBzdHJ1Y3QgdGVlX3Byb3RtZW1fcG9vbCAqcG9vbDsNCj4gPiA+ICsgICAgIHN0
cnVjdCB0ZWVfZG1hX2hlYXAgKmg7DQo+ID4gPiArICAgICB1X2xvbmcgaTsNCj4gPiA+ICsNCj4g
PiA+ICsgICAgIHhhX2Zvcl9lYWNoKCZ0ZWVfZG1hX2hlYXAsIGksIGgpIHsNCj4gPiA+ICsgICAg
ICAgICAgICAgaWYgKGgpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBwb29sID0gTlVM
TDsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBtdXRleF9sb2NrKCZoLT5tdSk7DQo+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgaWYgKGgtPnRlZWRldiA9PSB0ZWVkZXYpIHsNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvb2wgPSBoLT5wb29sOw0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaC0+dGVlZGV2ID0gTlVMTDsNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGgtPnBvb2wgPSBOVUxMOw0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIH0NCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBtdXRleF91bmxvY2so
JmgtPm11KTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAocG9vbCkNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvb2wtPm9wcy0+ZGVzdHJveV9wb29sKHBvb2wp
Ow0KPiA+ID4gKyAgICAgICAgICAgICB9DQo+ID4gPiArICAgICB9DQo+ID4gPiArfQ0KPiA+ID4g
K0VYUE9SVF9TWU1CT0xfR1BMKHRlZV9kZXZpY2VfdW5yZWdpc3Rlcl9hbGxfZG1hX2hlYXBzKTsN
Cg==
