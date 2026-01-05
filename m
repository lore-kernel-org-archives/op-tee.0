Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DFDC2A062
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 07:37:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AC8084FF2E
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767598653;
	bh=pHGrI6fqGE8ii1dzACrcYbuMIS2TOBU9vLk5NgsP/kc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ZbZpcKCWShdL+1Qr3lYMLOZY3VPD0DRB8PPEYKLhbaNf27b6zWlJeRszkliKB4HNJ
	 /hHfE99J+GCM+YvgALSLhqcTm9eDv7NTUGxdEH2oLYq5Qk/MLBXJ8RAmtisEIygiWv
	 XAGRXD6KRNQRAcP7ynOAWzx7ph8cdDRzw1fcaCSCudYc7yew91TpbmWFIphGPARBXu
	 JyGC5+GcmRQX46rBO1XC+xD2cIRHdCqz2kswRprt2Dam8fN5sxx9sMpRSuYnJLwCVR
	 z7VXURNm+aDcMnGGx50bbP2GZ8cHJS5DDnJT8X93d0DvAIoqcW6BYi1rtwgI+RCocv
	 veYzYVP5KA2ZA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2D8D0418F9
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 07:37:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AQARnNlf;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E3CF6000A;
	Mon,  5 Jan 2026 07:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126D3C116D0;
	Mon,  5 Jan 2026 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767598634;
	bh=xZXhNGf8vmrb3CmFuHN4pbqIFbluYGuFSRI363D+f+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQARnNlfezTetrzJA3Ray5fzyIVC7UjBIgH+mtbm6iAII3CHO5cPZ/tTo2CFVCyR+
	 DVcS7Kf+SULOiiEUwHK+zBr3c6t2RDNvqWFx0g8IMhzcLPIxBvGTxj9LSdH7/gQfnh
	 jg3ZcE+6SAgF8GcJTDyHVjo6e6aizljBqBpNZrOSUX2A01xZv6E2RPv86uFsE4ADdl
	 kUccWGdUJQp9rs4iGzgVns76/lKBxKlJRY6rmVuu6woz1a+lXQYu8T8a+HSihzBCuG
	 esf0xbDHDWkpCIoxrL3ngYar990BhCFJs0hiZlu6koA1zN0bTHNUeoFavPAK2Yl9i9
	 T+Zhy5zaQHyZg==
Date: Mon, 5 Jan 2026 13:07:05 +0530
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v20 1/6] dt-bindings: firmware: Add TEE remoteproc
 service binding
Message-ID: <aVtqITUxy--E8HJt@sumit-xelite>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
 <20251229232530.GA2753472-robh@kernel.org>
 <aVOzHWmlJ-eneS-2@sumit-xelite>
 <CAL_Jsq+_S8UY7s7WQg9jXuBXCYMBWVCy=kVDMdkKTx6RctqQJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAL_Jsq+_S8UY7s7WQg9jXuBXCYMBWVCy=kVDMdkKTx6RctqQJA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2D8D0418F9
X-Spamd-Bar: -
Message-ID-Hash: XDFEHAS42NQ2GIM3XQLQ5DNRA4NDVIBG
X-Message-ID-Hash: XDFEHAS42NQ2GIM3XQLQ5DNRA4NDVIBG
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XDFEHAS42NQ2GIM3XQLQ5DNRA4NDVIBG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gRnJpLCBKYW4gMDIsIDIwMjYgYXQgMDQ6MTc6MjdQTSAtMDYwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6DQo+IE9uIFR1ZSwgRGVjIDMwLCAyMDI1IGF0IDU6MTDigK9BTSBTdW1pdCBHYXJnIDxzdW1p
dC5nYXJnQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBEZWMgMjksIDIwMjUg
YXQgMDU6MjU6MzBQTSAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIERl
YyAxNywgMjAyNSBhdCAwNDozOToxMlBNICswMTAwLCBBcm5hdWQgUG91bGlxdWVuIHdyb3RlOg0K
PiA+ID4gPiBBZGQgYSBkZXZpY2UgdHJlZSBiaW5kaW5nIGZvciB0aGUgVEVFLWJhc2VkIHJlbW90
ZSBwcm9jZXNzb3IgY29udHJvbA0KPiA+ID4gPiBzZXJ2aWNlIGltcGxlbWVudGVkIGFzIGFuIE9Q
LVRFRSBUcnVzdGVkIEFwcGxpY2F0aW9uIGlkZW50aWZpZWQgYnkNCj4gPiA+ID4gVVVJRCA4MGE0
YzI3NS0wYTQ3LTQ5MDUtODI4NS0xNDg2YTk3NzFhMDguDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBU
RUUgc2VydmljZSBub2RlIGlzIGEgY2hpbGQgb2YgdGhlICJsaW5hcm8sb3B0ZWUtdHoiIGZpcm13
YXJlIG5vZGUgYW5kDQo+ID4gPiA+IGFjdHMgYXMgYSBjb250YWluZXIgZm9yIHJlbW90ZXByb2Mg
ZGV2aWNlcyB0aGF0IGFyZSBjb250cm9sbGVkIHZpYSBURUUuDQo+ID4gPg0KPiA+ID4gSXMgdGhp
cyBnZW5lcmljIGZvciBhbnkgcmVtb3RlcHJvYyBkZXZpY2Ugb3IganVzdCBTVCdzIHJlbW90ZXBy
b2MuIExvb2tzDQo+ID4gPiBsaWtlIHRoZSBsYXR0ZXIgdG8gbWUuDQo+ID4NCj4gPiBUaGF0J3Mg
dHJ1ZSwgdGhlIERUIGRlc2NyaXB0aW9uIG9mIHRoZSByZW1vdGVwcm9jIHN1Ym5vZGUgaXMgdmVy
eQ0KPiA+IHNwZWNpZmljIHRvIHRoZSB2ZW5kb3Igd2hpY2ggaW4gdGhpcyBjYXNlIGlzIFNULg0K
PiA+DQo+ID4gPg0KPiA+ID4gPiBJbiBhZGRpdGlvbiwgdGhlICJsaW5hcm8sb3B0ZWUtdHoiIGJp
bmRpbmcgaXMgdXBkYXRlZCB0byBzcGVjaWZ5IHRoZQ0KPiA+ID4gPiAnI2FkZHJlc3MtY2VsbHMn
IGFuZCAnI3NpemUtY2VsbHMnIHZhbHVlcyB1c2VkIGZvciBjaGlsZCBURUUgc2VydmljZQ0KPiA+
ID4gPiBub2Rlcy4NCj4gPiA+DQo+ID4gPiBJJ20gcHJldHR5IHN1cmUgSSBhbHJlYWR5IHJlamVj
dGVkIHBlciBzZXJ2aWNlL2FwcCBjaGlsZCBub2RlcyBmb3INCj4gPiA+IE9QLVRFRSB3aGVuIGl0
cyBiaW5kaW5nIHdhcyBzdWJtaXR0ZWQuDQo+ID4NCj4gPiBUaGF0IHdhcyB0aGUgcmVhc29uIHRv
IGhhdmUgZGlzY292ZXJhYmxlIFRFRSBidXMgaW4gZmlyc3QgcGxhY2UgYW5kIEkNCj4gPiBoYXZl
IGJlZW4gbW90aXZhdGluZyBwZW9wbGUgdG8gZHluYW1pY2FsbHkgZGlzY292ZXIgZmlybXdhcmUg
cHJvcGVydGllcw0KPiA+IHJhdGhlciB0aGFuIGhhcmRjb2RpbmcgaW4gdGhlIERULg0KPiA+DQo+
ID4gPiBJZiB3ZSBkbyBuZWVkIHNvbWV0aGluZyBpbiBEVA0KPiA+ID4gdG8gZGVmaW5lIHNvbWUg
cmVzb3VyY2VzLCB0aGVuIGNhbid0IHdlIGhhdmUgc29tZSBzb3J0IG9mDQo+ID4gPiBzdGFuZGFy
ZC9jb21tb24gY29tbXVuaWNhdGlvbnMgY2hhbm5lbD8gSSBkb24ndCBjYXJlIHRvIHNlZSBzb21l
IHNvcnQgb2YNCj4gPiA+IGZyZWUtZm9yLWFsbCB3aGVyZSB3ZSBoYXZlIGV2ZXJ5IHZlbmRvciBk
b2luZyB0aGVpciBvd24gdGhpbmcuIE9QLVRFRQ0KPiA+ID4gbmVlZHMgdG8gc3RhbmRhcml6ZSB0
aGlzLg0KPiA+DQo+ID4gSSBzdXBwb3NlIHRoaXMgcmVxdWlyZXMgYSB3aWRlciBzY29wZSB3b3Jr
IGFzIHlvdSBjYW4gc2VlIHRoZSBEVCByZXNvdXJjZQ0KPiA+IGRlcGVuZGVuY2UgZnJvbSBoZXJl
IFsxXS4gQnkgc3RhbmRhcmRpemUgY29tbXVuaWNhdGlvbiBjaGFubmVsLCBkbyB5b3UNCj4gPiBt
ZWFuIHRvIHNheSBpZiBhZGRpbmcgYW4gYWx0ZXJuYXRpdmUgYmFja2VuZCB0byBmd25vZGUgZm9y
IFRFRSBpbg0KPiA+IHBhcmFsbGVsIHRvIERULCBBQ1BJIG9yIHN3bm9kZSBpcyB0aGUgd2F5IHRv
IGdvIGZvciBkaXNjb3ZlcmluZyBmdw0KPiA+IHByb3BlcnRpZXM/DQo+IA0KPiBObywgbm90IGF0
IGFsbC4NCj4gDQo+ID4gT3IgZG8geW91IGhhdmUgYW55IG90aGVyIHN1Z2dlc3Rpb24gaGVyZT8N
Cj4gDQo+IFdoYXQgSSBtZWFuIGlzIHdoeSBkb2Vzbid0IHRoZSBURUUgZGVmaW5lIHRoZSBjb21t
dW5pY2F0aW9uIGNoYW5uZWwNCj4gKG1haWxib3grc2htZW0gYW5kIG5vdGlmaWNhdGlvbiBpbnRl
cnJ1cHQpIHJhdGhlciB0aGFuIGVhY2ggVEVFIGFwcD8NCg0KVGhlIHN5bmNocm9ub3VzIGNvbW11
bmljYXRpb24gY2hhbm5lbCBpcyBhbHJlYWR5IHRoZXJlIGZvciBlYWNoIFRFRSBhcHANCmJhc2Vk
IG9uIChpbnZva2UgY29tbWFuZHMgKyBURUUgc2hhcmVkIG1lbW9yeSkuIE9QLVRFRSBkb2VzIHN1
cHBvcnQNCm5vdGlmaWNhdGlvbiBpbnRlcnJ1cHRzIHRvbyBidXQgdGhvc2UgaGF2ZW4ndCBiZWVu
IGV4cG9zZWQgdG8gVEVFIGNsaWVudA0KZHJpdmVycyB5ZXQuIEkgc3VwcG9zZSB0aGlzIHJlbW90
ZXByb2MgdXNlLWNhc2UgY2FuIGJlIGEgZ29vZCBleGFtcGxlIHRvDQpleHBvc2UgdGhhdCBhcyBh
IGdlbmVyaWMgVEVFIG5vdGlmaWNhdGlvbiBpbnRlcmZhY2UgdG9vLg0KDQo+IA0KPiBNb3JlIGdl
bmVyYWxseSwgaXMgaGF2aW5nIFRFRSBhcHBzIGRlcGVuZGluZyBvbiByYW5kb20gRFQgcmVzb3Vy
Y2VzDQo+IHJlYWxseSBhIGJveCB3ZSB3YW50IHRvIG9wZW4/IElzIHRoZSBuZXh0IHRoaW5nIGdv
aW5nIHRvIGJlIGEgVEVFDQo+IGNsb2NrL3Jlc2V0L2dwaW8vcG93ZXIgcHJvdmlkZXI/IFdoZXJl
IGRvIHdlIGRyYXcgdGhlIGxpbmU/DQoNClRoaXMgaXMgcmVhbGx5IGEgaGFyZCBsaW5lIHRvIGRy
YXcgc2luY2Ugc2lsaWNvbi9PRU0gdmVuZG9ycyBiYXNlZCBvbiB0aGVpcg0KaGFyZHdhcmUgc2Vj
dXJpdHkgYXJjaGl0ZWN0dXJlIHBhcnRpdGlvbiB2YXJpb3VzIHJlc291cmNlcyBhbW9uZyBURUUg
YW5kDQp0aGUgTGludXggd29ybGQuIEFuZCBvbmUgZ2VuZXJhbCBwcmluY2lwbGUgd2UgdHJ5IHRv
IGZvbGxvdyBmb3IgdGhlIFRFRQ0KaXMgdG8ga2VlcCBpdCdzIFRydXN0ZWQgQ29tcHV0aW5nIEJh
c2UgKFRDQikgdG8gYSBtaW5pbWFsIHRvby4NCg0KSU1ITywgaWYgdGhlIHRocmVhdCBtb2RlbCBp
cyB3ZWxsIHVuZGVyc3Rvb2QgdGhlbiB3ZSBzaG91bGQgYWxsb3cgZm9yDQp0aGlzIGhldHJvZ2Vu
b3VzIHBhcnRpdGlvbmluZyBvZiBzeXN0ZW0gcmVzb3VyY2VzLg0KDQotU3VtaXQNCg==
