Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CF110ED640
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 10:01:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0E14244405
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774605717;
	bh=Cv0pm6HImAAvh6XMUaLaMj4M7LXqdQvshkBfz8Dr4iI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BVXDwUAcsM1/sKHTSVhDI3ZWY+ZygK4VhiouPmbA6rhOlzymC5mUhyjo2iVL/jmcK
	 T3R4mc2Xo6x/gZhc9Dcto29ssBomRs1dCfE1kMsVX+LlIEfdPqwEDBENaPMZKJu7WK
	 ngThzH0NKPazuvFuZzeyk9xOQVLPB1/nhI5n+zfGLxn0Jj4wjcn2AgV235ckY/iUb8
	 JWmlIYEHYTQtB5HAEFQLQGdIZ9A53HnPcGIzhRUflzzE1D7aQvvRPL9ggxlUeYXsmH
	 O1jcA5HV2US5jhUjMoPD8Vz08WImplIRIUoZSKBXvhxUQ0buNqHDrS7AhEfN7NiyiG
	 9D1P/+dP/BeEg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DECF94394A
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 10:01:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nhJg5fn0;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5814760133;
	Fri, 27 Mar 2026 10:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B7C19423;
	Fri, 27 Mar 2026 10:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774605703;
	bh=iejeqc3JP2vSzgt4y0x/PwrbQN67lppLyjsQumGcTX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhJg5fn0eMbHHR35z+HzYf4ju0d7gED+aWm3xaG3jTMndWxquk4Jc094VhhmzX/bQ
	 Y8pa0Uo9s8iGO5b+xCLcAFoIfK6O5G1SqGIxVfnGHX8l39/Zi6gzFlRYyH2IWK5309
	 TJ4iJr7tSiCFSjZnSOO4Wrs297lbG5uBY/mLG/ov0Rrot5XwuJY2d4Ufra+Km2qSqi
	 ZIx8OzEhsNJVGdG1+V4h4odUfmlUAUv5trQwwdNVKwk1s2MvoCEBi0WWdLAEea81ZC
	 Np+pb34nN8ya8YAjBqp2+qx0t67bet7GPXCkyb+ZwTaVhWIxMAOPk0+VQUIc5zOwUo
	 X7SRZXRheXS5w==
Date: Fri, 27 Mar 2026 15:31:39 +0530
To: Shf Chen =?utf-8?B?KOmZs+WwkeeUqyk=?= <Shf.Chen@mediatek.com>
Subject: Re: Possible race during OP-TEE kernel module device probing
Message-ID: <acZVg6GQQT17r0OG@sumit-xelite>
References: <d9bb3b058dcd0425b18c77120dae225506b079e2.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <d9bb3b058dcd0425b18c77120dae225506b079e2.camel@mediatek.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN_FAIL(0.00)[254.4.105.172.asn.rspamd.com:query timed out];
	ARC_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DECF94394A
X-Spamd-Bar: ----
Message-ID-Hash: 2IJ4NKBO4PCMJ5MXT7IKO6P57MBB72P2
X-Message-ID-Hash: 2IJ4NKBO4PCMJ5MXT7IKO6P57MBB72P2
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2IJ4NKBO4PCMJ5MXT7IKO6P57MBB72P2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gRnJpLCBNYXIgMjcsIDIwMjYgYXQgMDk6MDE6MTVBTSArMDAwMCwgU2hmIENoZW4gKOmZs+Ww
keeUqykgdmlhIE9QLVRFRSB3cm90ZToNCj4gSGksDQo+IA0KPiBXZSBmb3VuZCBhIHBvc3NpYmxl
IHJhY2UgY29uZGl0aW9uIGlzc3VlIGR1cmluZyBPUC1URUUga2VybmVsIGRyaXZlciBwcm9iaW5n
IHRoZSBkZXZpY2UuDQo+IEEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGV4Y2VwdGlvbiBjYW4g
aGFwcGVuIHdoZW4gYW5vdGhlciBrZXJuZWwgZHJpdmVyIG9wZW4gT1AtVEVFIGNvbnRleHQNCj4g
d2l0aCB0ZWVfY2xpZW50X29wZW5fY29udGV4dCgpIHRoZW4gZG8gYSBTTUMgY2FsbCB0byBPUC1U
RUUuDQo+IEJlbG93IGlzIHRoZSBleGNlcHRpb246DQoNCkhvdyBpcyB5b3VyIGtlcm5lbCBkcml2
ZXIgYmVpbmcgcHJvYmVkPyBIYXZlIHlvdSByZWdpc3RlcmVkIGl0IGFzIGENCnByb3BlciBURUUg
YnVzIGRyaXZlcj8gQW55IGN1c3RvbSB3YXlzIHRvIGludm9rZSBURUUga2VybmVsIGNsaWVudCBB
UElzDQphcmUgc3VyZWx5IHN1c2NlcHRpYmxlIHRvIHJhY2VzIGxpa2UgdGhlIG9uZSB5b3UgbWVu
dGlvbmVkIGJlbG93Lg0KDQotU3VtaXQNCg0KPiANCj4gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAw
MDAwDQo+IE1lbSBhYm9ydCBpbmZvOg0KPiDCoCBFU1IgPSAweDAwMDAwMDAwOTYwMDAwMDUNCj4g
wqAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzDQo+IMKgIFNFVCA9
IDAsIEZuViA9IDANCj4gwqAgRUEgPSAwLCBTMVBUVyA9IDANCj4gwqAgRlNDID0gMHgwNTogbGV2
ZWwgMSB0cmFuc2xhdGlvbiBmYXVsdA0KPiBEYXRhIGFib3J0IGluZm86DQo+IMKgIElTViA9IDAs
IElTUyA9IDB4MDAwMDAwMDUsIElTUzIgPSAweDAwMDAwMDAwDQo+IMKgIENNID0gMCwgV25SID0g
MCwgVG5EID0gMCwgVGFnQWNjZXNzID0gMA0KPiDCoCBHQ1MgPSAwLCBPdmVybGF5ID0gMCwgRGly
dHlCaXQgPSAwLCBYcyA9IDANCj4gdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgMzktYml0IFZBcywg
cGdkcD0wMDAwMDAwMTAyNmJiMDAwDQo+IFswMDAwMDAwMDAwMDAwMDAwXSBwZ2Q9MDAwMDAwMDAw
MDAwMDAwMCwgcDRkPTAwMDAwMDAwMDAwMDAwMDAsIHB1ZD0wMDAwMDAwMDAwMDAwMDAwDQo+IElu
dGVybmFsIGVycm9yOiBPb3BzOiAwMDAwMDAwMDk2MDAwMDA1IFsjMV0gUFJFRU1QVCBTTVANCj4g
V29ya3F1ZXVlOiBldmVudHNfdW5ib3VuZCBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMNCj4gcHN0
YXRlOiAwMzQwMDAwNSAobnpjdiBkYWlmICtQQU4gLVVBTyArVENPICtESVQgLVNTQlMgQlRZUEU9
LS0pDQo+IHBjIDogb3B0ZWVfY3Ffd2FpdF9pbml0KzB4NzgvMHgxMjQgW29wdGVlXQ0KPiBsciA6
IG9wdGVlX2NxX3dhaXRfaW5pdCsweDYwLzB4MTI0IFtvcHRlZV0NCj4gc3AgOiBmZmZmZmZjMDgx
ZmNiN2YwDQo+IHgyOTogZmZmZmZmYzA4MWZjYjdmMCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDAgeDI3
OiAwMDAwMDAwMDAwMDAxMDAwDQo+IHgyNjogZmZmZmZmODA4MGU0MmM2MCB4MjU6IGZmZmZmZjgw
ODRkNDYwNDAgeDI0OiAwMDAwMDAwMDAwMDAwMDAwDQo+IHgyMzogMDAwMDAwMDAwMDAwMDAwMCB4
MjI6IGZmZmZmZmMwODFmY2I4YzAgeDIxOiBmZmZmZmZjMDgxZmNiOGE4DQo+IHgyMDogMDAwMDAw
MDAwMDAwMDAwMCB4MTk6IGZmZmZmZjgwODI3NDE1NzAgeDE4OiBmZmZmZmZlNTcyZjhjYTAwDQo+
IHgxNzogMDAwMDAwMDBmYTI4NjUwZiB4MTY6IDAwMDAwMDAwZmEyODY1MGYgeDE1OiBmZmZmZmY4
MDg0ZDQ3MDAwDQo+IHgxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAwMDAwMDAg
eDEyOiAwMDAwMDAwMDg0ZDQ3MDAwDQo+IHgxMTogMDAwMDAwMDAwMDAwMDAwMCB4MTA6IDAwMDAw
MDAwMzIwMDAwMTIgeDkgOiAwNGQ0NjAwMDAwMDAwMDAxDQo+IHg4IDogZmZmZmZmYzA4MWZjYjhj
OCB4NyA6IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiAwMDAwMDAwMDAwMDAwMDNmDQo+IHg1IDogZmZm
ZmZmODNjODY2NDllMCB4NCA6IDAwMDAwMDAwMDAwMDAwMDggeDMgOiAwMDAwMDAwMDAwMDAwMDAw
DQo+IHgyIDogZmZmZmZmODA4Mjc0MTVhMCB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOiBmZmZm
ZmZjMDgxZmNiOGMwDQo+IENhbGwgdHJhY2U6DQo+IMKgb3B0ZWVfY3Ffd2FpdF9pbml0KzB4Nzgv
MHgxMjQgW29wdGVlIGY2ZGJjMzVmOGQ5NmFjYmUxZjNjMzI5ZDcyMDE4MTUxZDc5NjIwOGRdDQo+
IMKgb3B0ZWVfc21jX2RvX2NhbGxfd2l0aF9hcmcrMHgxMmMvMHg5NWMgW29wdGVlIGY2ZGJjMzVm
OGQ5NmFjYmUxZjNjMzI5ZDcyMDE4MTUxZDc5NjIwOGRdDQo+IMKgb3B0ZWVfc2htX3JlZ2lzdGVy
KzB4Mjg0LzB4MzYwIFtvcHRlZSBmNmRiYzM1ZjhkOTZhY2JlMWYzYzMyOWQ3MjAxODE1MWQ3OTYy
MDhkXQ0KPiDCoHJlZ2lzdGVyX3NobV9oZWxwZXIrMHgxYTQvMHgyZjQgW3RlZSBjZGQ4YTBkMDc3
ZDk4NGJkYTFmMzFmOWU4OTAzODM2ZWRiZTQ2NjAzXQ0KPiDCoHRlZV9zaG1fcmVnaXN0ZXJfa2Vy
bmVsX2J1ZisweDYwLzB4OTAgW3RlZSBjZGQ4YTBkMDc3ZDk4NGJkYTFmMzFmOWU4OTAzODM2ZWRi
ZTQ2NjAzXQ0KPiDCoGNtZHFfc2VjX2FsbG9jYXRlX3dzbSsweDU4LzB4YzQgW210a19jbWRxX3Nl
Y19tYm94IGFjODJkYzk1OGUzMjI1MmEyMWM2Y2U1NWJiODgzOWViYjI4ODM4N2FdDQo+IMKgY21k
cV9zZWNfcHJvYmUrMHg4MC8weDRhMCBbbXRrX2NtZHFfc2VjX21ib3ggYWM4MmRjOTU4ZTMyMjUy
YTIxYzZjZTU1YmI4ODM5ZWJiMjg4Mzg3YV0NCj4gDQo+IFdlIGZvdW5kIHRoZSBvcHRlZS0+Y2Fs
bF9xdWV1ZSBoYXNuJ3QgYmVlbiBpbml0aWFsaXplZCB3aGVuIG91ciBkcml2ZXIgY2FsbGVkIE9Q
LVRFRSwNCj4gYW5kIGl0IG1pZ2h0IGhhdmUgc29tZSBpc3N1ZXMgYWJvdXQgdGhlIGRldmljZSBk
YXRhIHN0cnVjdHVyZSBpbml0aWFsaXplIG9yZGVyIGluDQo+IG9wdGVlX3Byb2JlKClbZHJpdmVy
cy90ZWUvb3B0ZWUvc21jX2FiaS5jXToNCj4gDQo+IC0tLQ0KPiByYyA9IHRlZV9kZXZpY2VfcmVn
aXN0ZXIob3B0ZWUtPnRlZWRldik7wqAgLy8gPC0tLS0tIFRFRSBkZXZpY2UgcmVnaXN0ZXIgaGVy
ZQ0KPiBpZiAocmMpDQo+IMKgwqDCoCBnb3RvIGVycl91bnJlZ19zdXBwX3RlZWRldjsNCj4gDQo+
IHJjID0gdGVlX2RldmljZV9yZWdpc3RlcihvcHRlZS0+c3VwcF90ZWVkZXYpOw0KPiBpZiAocmMp
DQo+IMKgwqDCoCBnb3RvIGVycl91bnJlZ19zdXBwX3RlZWRldjsNCj4gDQo+IG9wdGVlX2NxX2lu
aXQoJm9wdGVlLT5jYWxsX3F1ZXVlLCB0aHJlYWRfY291bnQpO8KgIC8vIDwtLS0tLSBTb21lIGRh
dGEgc3RydWN0dXJlcyBhcmUgaW5pdGlhbGl6ZWQgYWZ0ZXJ3YXJkcw0KPiBvcHRlZV9zdXBwX2lu
aXQoJm9wdGVlLT5zdXBwKTsNCj4gb3B0ZWUtPnNtYy5tZW1yZW1hcGVkX3NobSA9IG1lbXJlbWFw
ZWRfc2htOw0KPiBvcHRlZS0+cG9vbCA9IHBvb2w7DQo+IG9wdGVlX3NobV9hcmdfY2FjaGVfaW5p
dChvcHRlZSwgYXJnX2NhY2hlX2ZsYWdzKTsNCj4gbXV0ZXhfaW5pdCgmb3B0ZWUtPnJwbWJfZGV2
X211dGV4KTsNCj4gLS0tDQo+IA0KPiBXZSB3YW50IHRvIGFzayBpZiB0aGUgZGF0YSBzdHJ1Y3R1
cmUgaW5pdGlhbGl6YXRpb24gc2hvdWxkIGJlIGRvbmUgYmVmb3JlIHRoZSB0ZWUgZGV2aWNlIHJl
Z2lzdHJhdGlvbj8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gU2hhby1GdSBDaGVuDQo+IA0KPiAN
Cg==
