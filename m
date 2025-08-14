Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FA3CA0EE3
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 07:18:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B8ADD4FC90
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 07:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755155920;
	bh=P/pra3A2jQyMTDm6/q1QZIKU+BD6OOJNpMLthUUgBog=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=P5XYEKb9dbS6yZOm13TwQfrzE8dwxVPo2lkNiPcP7pUP9LiA4c5LXrpleheLaQPjP
	 Vmc6DPjFrKqFcDc6Fl7k/bd+WoWo/diAzMCXnirtiVPUCYSQAYA/8w10Olss3U2B5u
	 ytggG+oWqK9uiQmkt/tFo8vB8k5Q92Q+c5B+u0W+e7ifuInmyFpGcv3c/V5c+KLn70
	 zsrv9FEizF8A2Bn6IFtHbdEHJzCo6jae1s0oPZD7nPWXmnMsA8wYPw5g/CqUrueAzD
	 1Jv7de/EeQpc4cOvRs3koEg2FNs6Dlmwk1J50laEG2RNCPMJuN9odN7/3SNKCpTjnj
	 KKeVFkYJhG1zQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0790441B47
	for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 07:18:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Elut8q4g;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 68777601DD;
	Thu, 14 Aug 2025 07:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539AFC4CEEF;
	Thu, 14 Aug 2025 07:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755155906;
	bh=dimKx23huTNq7ndUo5JXI5Ve5ilX+nFkk6o+pI2E0Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Elut8q4gK/DQnVF2FTu3JSUuMHfdp5tASCwvQDMXk+I2sjuMCH2k7HKXw1uymxgoh
	 CtiucKFzY/s70niahonbQtlc1w67bqX70HaADHkFK4TnWSR1Y0dQS7YVJuNvbwEPsK
	 bbuk3AE1PyL1bXAbZM1zytiELb923yQ8yxCKaobfwwPkLiADA76QggCYGYT/k13550
	 WrvfK2I9Gc3VUDUazB5PfRpyeBI0S2uJZgJ4CkMm/a7i56408y0+1Kl0nLxCYzRk+C
	 quycfUywHu25bGb9PiuGkRbwSs4dMoZZ8p9t4nMEvD7zQdJl4zCGf49ZXn00IumOcc
	 0BsCbvN4Cdkcw==
Date: Thu, 14 Aug 2025 12:47:58 +0530
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: Re: [PATCH v19 2/6] remoteproc: Add TEE support
Message-ID: <aJ2Npmru9RLPTj7c@sumit-X1>
References: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
 <20250625094028.758016-3-arnaud.pouliquen@foss.st.com>
 <aJzAkk-k4nfXY7Ux@e130802.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <aJzAkk-k4nfXY7Ux@e130802.arm.com>
X-Rspamd-Queue-Id: 0790441B47
X-Spamd-Bar: -
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: ZP7NEI22D3LEFYUZ2WJ5RJIVHSHFA5C4
X-Message-ID-Hash: ZP7NEI22D3LEFYUZ2WJ5RJIVHSHFA5C4
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Srinivas Kalaga <Srinivas.Kalaga2@arm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZP7NEI22D3LEFYUZ2WJ5RJIVHSHFA5C4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

SGkgQWJkZWxsYXRpZiwNCg0KT24gV2VkLCBBdWcgMTMsIDIwMjUgYXQgMDU6NDI6NThQTSArMDEw
MCwgQWJkZWxsYXRpZiBFbCBLaGxpZmkgd3JvdGU6DQo+IEhpIEFybmF1ZCwNCj4gDQo+ID4gQWRk
IGEgcmVtb3RlcHJvYyBURUUgKFRydXN0ZWQgRXhlY3V0aW9uIEVudmlyb25tZW50KSBkcml2ZXIg
dGhhdCB3aWxsIGJlDQo+ID4gcHJvYmVkIGJ5IHRoZSBURUUgYnVzLiBJZiB0aGUgYXNzb2NpYXRl
ZCBUcnVzdGVkIGFwcGxpY2F0aW9uIGlzIHN1cHBvcnRlZA0KPiA+IG9uIHRoZSBzZWN1cmUgcGFy
dCwgdGhpcyBkcml2ZXIgb2ZmZXJzIGEgY2xpZW50IGludGVyZmFjZSB0byBsb2FkIGZpcm13YXJl
DQo+ID4gYnkgdGhlIHNlY3VyZSBwYXJ0Lg0KPiA+IFRoaXMgZmlybXdhcmUgY291bGQgYmUgYXV0
aGVudGljYXRlZCBieSB0aGUgc2VjdXJlIHRydXN0ZWQgYXBwbGljYXRpb24uDQo+ID4gDQo+ID4g
QSBzcGVjaWZpY2l0eSBvZiB0aGUgaW1wbGVtZW50YXRpb24gaXMgdGhhdCB0aGUgZmlybXdhcmUg
aGFzIHRvIGJlDQo+ID4gYXV0aGVudGljYXRlZCBhbmQgb3B0aW9uYWxseSBkZWNyeXB0ZWQgdG8g
YWNjZXNzIHRoZSByZXNvdXJjZSB0YWJsZS4NCj4gPiANCj4gPiBDb25zZXF1ZW50bHksIHRoZSBi
b290IHNlcXVlbmNlIGlzOg0KPiA+IA0KPiA+IDEpIHJwcm9jX3BhcnNlX2Z3IC0tPiBycHJvY190
ZWVfcGFyc2VfZncNCj4gPiAgICByZW1vdGVwcm9jIFRFRToNCj4gPiAgICAtIFJlcXVlc3RzIHRo
ZSBURUUgYXBwbGljYXRpb24gdG8gYXV0aGVudGljYXRlIGFuZCBsb2FkIHRoZSBmaXJtd2FyZQ0K
PiA+ICAgICAgaW4gdGhlIHJlbW90ZSBwcm9jZXNzb3IgbWVtb3JpZXMuDQo+ID4gICAgLSBSZXF1
ZXN0cyB0aGUgVEVFIGFwcGxpY2F0aW9uIGZvciB0aGUgYWRkcmVzcyBvZiB0aGUgcmVzb3VyY2Ug
dGFibGUuDQo+ID4gICAgLSBDcmVhdGVzIGEgY29weSBvZiB0aGUgcmVzb3VyY2UgdGFibGUgc3Rv
cmVkIGluIHJwcm9jLT5jYWNoZWRfdGFibGUuDQo+ID4gDQo+ID4gMikgcnByb2NfbG9hZF9zZWdt
ZW50cyAtLT4gcnByb2NfdGVlX2xvYWRfZncNCj4gPiAgICByZW1vdGVwcm9jIFRFRToNCj4gPiAg
ICAtIFJlcXVlc3RzIHRoZSBURUUgYXBwbGljYXRpb24gdG8gbG9hZCB0aGUgZmlybXdhcmUuIE5v
dGhpbmcgaXMgZG9uZQ0KPiA+ICAgICAgYXQgdGhlIFRFRSBhcHBsaWNhdGlvbiBhcyB0aGUgZmly
bXdhcmUgaXMgYWxyZWFkeSBsb2FkZWQuDQo+ID4gICAgLSBJbiBjYXNlIG9mIHJlY292ZXJ5LCB0
aGUgVEVFIGFwcGxpY2F0aW9uIGhhcyB0byByZWxvYWQgdGhlIGZpcm13YXJlLg0KPiA+IA0KPiA+
IDMpIHJwcm9jX3RlZV9nZXRfbG9hZGVkX3JzY190YWJsZQ0KPiA+ICAgIHJlbW90ZXByb2MgVEVF
IHJlcXVlc3RzIHRoZSBURUUgYXBwbGljYXRpb24gZm9yIHRoZSBhZGRyZXNzIG9mIHRoZQ0KPiA+
ICAgIHJlc291cmNlIHRhYmxlLg0KPiA+IA0KPiA+IDQpIHJwcm9jX3N0YXJ0IC0tPiBycHJvY190
ZWVfc3RhcnQNCj4gPiAgICAtIFJlcXVlc3RzIHRoZSBURUUgYXBwbGljYXRpb24gdG8gc3RhcnQg
dGhlIHJlbW90ZSBwcm9jZXNzb3IuDQo+ID4gDQo+ID4gVGhlIHNodXRkb3duIHNlcXVlbmNlIGlz
Og0KPiA+IA0KPiA+IDUpIHJwcm9jX3N0b3AgLS0+IHJwcm9jX3RlZV9zdG9wDQo+ID4gICAgLSBS
ZXF1ZXN0cyB0aGUgVEVFIGFwcGxpY2F0aW9uIHRvIHN0b3AgdGhlIHJlbW90ZSBwcm9jZXNzb3Iu
DQo+ID4gDQo+ID4gNikgcnByb2NfdGVlX3JlbGVhc2VfZncNCj4gPiAgICBUaGlzIGZ1bmN0aW9u
IGlzIHVzZWQgdG8gcmVxdWVzdCB0aGUgVEVFIGFwcGxpY2F0aW9uIHRvIHBlcmZvcm0gYWN0aW9u
cw0KPiA+ICAgIHRvIHJldHVybiB0byB0aGUgaW5pdGlhbCBzdGF0ZSBvbiBzdG9wIG9yIG9uIGVy
cm9yIGR1cmluZyB0aGUgYm9vdA0KPiA+ICAgIHNlcXVlbmNlLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFybmF1ZCBQb3VsaXF1ZW4gPGFybmF1ZC5wb3VsaXF1ZW5AZm9zcy5zdC5jb20+DQo+
IC4uLg0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZV9p
ZCBycHJvY190ZWVfaWRfdGFibGVbXSA9IHsNCj4gPiArCXtVVUlEX0lOSVQoMHg4MGE0YzI3NSwg
MHgwYTQ3LCAweDQ5MDUsIDB4ODIsIDB4ODUsIDB4MTQsIDB4ODYsIDB4YTksIDB4NzcsIDB4MWEs
IDB4MDgpfSwNCj4gPiArCXt9DQo+ID4gK307DQo+IA0KPiBPdGhlciBpbXBsZW1lbnRhdGlvbnMg
bWF5IHVzZSBkaWZmZXJlbnQgVVVJRHMuDQo+IFdoYXQgYWJvdXQgYWRkaW5nIGEga2VybmVsIGNv
bmZpZ3VyYXRpb24gb3B0aW9uIHdoaWNoLCB3aGVuIGVuYWJsZWQsIGFsbG93cw0KPiBhbHRlcm5h
dGl2ZSBpbXBsZW1lbnRhdGlvbnMgdG8gb3ZlcnJpZGUgdGhpcyB0YWJsZT8NCg0KWW91IGRvbid0
IG5lZWQgYW55IG90aGVyIGtlcm5lbCBjb25maWd1cmF0aW9uIG9wdGlvbiBmb3IgdGFibGUgb3Zl
cnJpZGUNCmJ1dCByYXRoZXIgeW91IGV4dGVuZCB0aGlzIHRhYmxlIHdpdGggVVVJRCBmb3Igc2Vy
dmljZSBwcm92aWRlZCBieQ0KVFMtVEVFLg0KDQo+IA0KPiA+ICsvKioNCj4gPiArICogcnByb2Nf
dGVlX3JlZ2lzdGVyKCkgLSBSZWdpc3RlciBhIHJlbW90ZSBwcm9jZXNzb3IgY29udHJvbGxlZCBi
eSB0aGUgVEVFIGFwcGxpY2F0aW9uLg0KPiAuLi4NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgcnBy
b2NfdGVlX2N0eF9tYXRjaChzdHJ1Y3QgdGVlX2lvY3RsX3ZlcnNpb25fZGF0YSAqdmVyLCBjb25z
dCB2b2lkICpkYXRhKQ0KPiA+ICt7DQo+ID4gKwkvKiBUb2RheSB3ZSBzdXBwb3J0IG9ubHkgdGhl
IE9QLVRFRSwgY291bGQgYmUgZXh0ZW5kIHRvIG90aGVyIHRlZXMgKi8NCj4gPiArCXJldHVybiAo
dmVyLT5pbXBsX2lkID09IFRFRV9JTVBMX0lEX09QVEVFKTsNCj4gPiArfQ0KPiANCj4gQ291bGQg
d2UgbWFrZSB2ZXItPmltcGxfaWQgdXNlci1jb25maWd1cmFibGUgcGxlYXNlID8gZm9yIGV4YW1w
bGUsIGJ5IHJlYWRpbmcNCj4gaXQgZnJvbSB0aGUgZGV2aWNlIHRyZWUgc2luY2UgaXQgaXNu4oCZ
dCBkaXNjb3ZlcmFibGUgYXQgcnVudGltZT8gSW4gb3VyIHNldHVwLCB3ZeKAmWQgc2V0DQo+IGl0
IHRvIFRFRV9JTVBMX0lEX1RTVEVFLg0KDQpJbiBjYXNlIHRoZSBUUy1URUUgc2VydmljZSBnZXRz
IGVudW1lcmF0ZWQgb24gVEVFIGJ1cyB0aGVuIHRoZQ0KdmVyLT5pbXBsX2lkIHdpbGwgZ2V0IGF1
dG9tYXRpY2FsbHkgY29uZmlndXJlZCB0byBURUVfSU1QTF9JRF9UU1RFRS4gSXQNCmlzIGhvdyB0
aGUgZHJpdmVyIHdpbGwgZ2V0IHRvIGtub3cgaWYgaXQgaXMgY29tbXVuaWNhdGluZyB3aXRoIGFu
IE9QLVRFRQ0KYmFzZWQgc2VydmljZSBvZiBUUy1URUUgYmFzZWQgc2VydmljZS4NCg0KPiANCj4g
PiArDQo+ID4gK3N0YXRpYyBpbnQgcnByb2NfdGVlX3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gPiArew0KPiA+ICsJc3RydWN0IHRlZV9jb250ZXh0ICp0ZWVfY3R4Ow0KPiA+ICsJaW50IHJl
dDsNCj4gPiArDQo+ID4gKwkvKiBPcGVuIGNvbnRleHQgd2l0aCBURUUgZHJpdmVyICovDQo+ID4g
Kwl0ZWVfY3R4ID0gdGVlX2NsaWVudF9vcGVuX2NvbnRleHQoTlVMTCwgcnByb2NfdGVlX2N0eF9t
YXRjaCwgTlVMTCwgTlVMTCk7DQo+ID4gKwlpZiAoSVNfRVJSKHRlZV9jdHgpKQ0KPiA+ICsJCXJl
dHVybiBQVFJfRVJSKHRlZV9jdHgpOw0KPiA+ICsNCj4gPiArCXJldCA9IG11dGV4X2xvY2tfaW50
ZXJydXB0aWJsZSgmY3R4X2xvY2spOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0
Ow0KPiANCj4gSW4gc29tZSBURUVzLCB0aGUgY2xpZW50IGRyaXZlciBtaWdodCBuZWVkIHRvIHBl
cmZvcm0gZXh0cmEgd29yayBkdXJpbmcgcHJvYmluZy4NCj4gRm9yIGV4YW1wbGUsIHdoZW4gdXNp
bmcgVFMgVEVFLCBjYWxsaW5nIHRlZV9zaG1fYWxsb2Nfa2VybmVsX2J1ZigpIGlzIHJlcXVpcmVk
Lg0KPiBDb3VsZCB3ZSBpbnRyb2R1Y2UgYW4gcnByb2NfdGVlX29wcyBhbmQgYWRkIGEgVEVFIHBy
b2JlIG9wZXJhdGlvbiBjYWxsZWQgYnkgdGhlDQo+IHJlbW90ZXByb2MgZHJpdmVyIGZvciBwZXJm
b3JtaW5nIGN1c3RvbSBURUUgc2V0dXAgPw0KDQpTdXJlLCBhcyBJIG1lbnRpb25lZCBhYm92ZSB0
aGUgZHJpdmVyIHdpbGwgYmUgYWJsZSB0byBrbm93IGlmIGl0J3MNCmNvbW11bmljYXRpbmcgd2l0
aCBUUy1URUUgdGhlbiB0aGUgYWRkaXRpb25hbCBmdW5jdGlvbmFsaXR5IG5lZWRlZCBjYW4NCmJl
IGNvbmRpdGlvbmFsbHkgaW1wbGVtZW50ZWQgZHVyaW5nIHByb2JlLg0KDQpJIHRoaW5rIGl0IGlz
IHJlYWxseSB0aGUgbmV4dCBzdGVwIGFmdGVyIHRoaXMgcGF0Y2gtc2V0IGxhbmRzIHdoZXJlIHdl
DQpoYXZlIHRvIHN1cHBvcnQgdGhlIHJlbW90ZXByb2Mgc2VydmljZSBob3N0ZWQgdW5kZXIgZGlm
ZmVyZW50IFRFRQ0KaW1wbGVtZW50YXRpb25zIGxpa2UgT1AtVEVFLCBUUy1URUUgb3IgUVRFRSBl
dGMuDQoNCi1TdW1pdA0K
