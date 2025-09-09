Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9E3CAC587
	for <op-tee@archiver.kernel.org>; Tue,  9 Sep 2025 07:12:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 038B64313D
	for <op-tee@archiver.kernel.org>; Tue,  9 Sep 2025 07:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757401947;
	bh=jj41ct7tHSAxvf434V0uTUUTiHJIGXY7NQ1O7xp3DdQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Q7wOgUe0dwcXWFiMy3AU7xxnn5RDpnhH8izmihzj1zDb8LC0kYUkyZuO/y8ZnbJiL
	 kHNuWqg1pdrauZOUSPlDAP4wBCrBB6GN6knH14KaD4sfzTHulzkyV6j7D9zfK5LNDj
	 pRnai1sgKtkJdlvjtl8X5FMn6TJ6b60Xzh1VbQjzWpKHM0+Q4RERRj53yH52ImwW2g
	 6IWISPTUAuAqRTpA2BTbr7W0b5/Mu4tQv9q08XURNIWxlhrhbsEgodIhzxrrWjDD1k
	 4QuWLJELH6+/VA4rWxo9JkPQSRLiFEl52qRsj7nF4cWLTIsAWJ+ETcKGCfzkCPTlWr
	 BePBaIBfLY7kQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DCC324313D
	for <op-tee@lists.trustedfirmware.org>; Tue,  9 Sep 2025 07:12:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aspSbeC6;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D0C960193;
	Tue,  9 Sep 2025 07:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D84C4CEF4;
	Tue,  9 Sep 2025 07:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757401932;
	bh=kCIVSZyo8ikDBmtuf491ja5todb9ghm5at0poydlpqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aspSbeC6SSWbAwQpYcKBu+PmAXBfsvZyKj/YxEwK57XHDoB00IceCuGN6wERFSfXx
	 qmKtDnJfFoEMr5s3ipe68ERFxH9BfEETM6tmtFBpfFGrE0CtgBy7z9Gs/T+6kzsboa
	 FDh4f+TiRaZE2tBHvxe83tMaS5f7iEBOxA2otdoX/TlsPboqKN8cXqcyb9kKxgAkkW
	 d2AFufcqgQjntjd2jB9ckFN4cBb/X/vbZmEaG0jgnydfabJZIu0Qw1A2wFag/HYHJe
	 92I4IyTXQ/oQXKGEn33+HJsvz6bE6CfoUCSrX9b725gZZPCnG6Ivtrx0gJOBSz2h3X
	 izkpVzzI/OjoQ==
Date: Tue, 9 Sep 2025 12:42:05 +0530
To: =?utf-8?B?5oi0552/?= <rui.dai@xg.auto>
Subject: Re: [BUG] mobj_ffa_get_by_cookie() fails with 16K/64K kernel page
 size
Message-ID: <aL_TRb9wCnCAYDdW@sumit-X1>
References: <eb57f0258749e983b3423f1620c8d6876113f7cc.953132d2.6e78.4432.8309.0d0d57874c64@feishu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <eb57f0258749e983b3423f1620c8d6876113f7cc.953132d2.6e78.4432.8309.0d0d57874c64@feishu.cn>
X-Rspamd-Queue-Id: DCC324313D
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: XDWSDA26NL5UEVQ2QDDSBSWMVHWBE32B
X-Message-ID-Hash: XDWSDA26NL5UEVQ2QDDSBSWMVHWBE32B
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XDWSDA26NL5UEVQ2QDDSBSWMVHWBE32B/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

SGksDQoNCk9uIE1vbiwgU2VwIDA4LCAyMDI1IGF0IDAzOjM1OjAyUE0gKzA4MDAsIOaItOedvyB3
cm90ZToNCj4gSGkgT1AtVEVFIG1haW50YWluZXJzLA0KPiANCj4gSSBmb3VuZCBhbiBpc3N1ZSBp
biBvcHRlZV9vcyByZWxhdGVkIHRvIEZGQSBtZW1vcnkgaGFuZGxpbmcgYWNyb3NzIGRpZmZlcmVu
dCBrZXJuZWwgcGFnZSBzaXplcy4NCj4gDQo+IEZpbGU6IGNvcmUvYXJjaC9hcm0vbW0vbW9ial9m
ZmEuYw0KPiBGdW5jdGlvbjogbW9ial9mZmFfZ2V0X2J5X2Nvb2tpZSgpDQo+IA0KPiBBdCB0aGUg
YmVnaW5uaW5nIG9mIHRoaXMgZnVuY3Rpb24gdGhlcmUgaXMgYSBjaGVjazoNCj4gDQo+IMKgwqDC
oCBpZiAoaW50ZXJuYWxfb2ZmcyA+PSBTTUFMTF9QQUdFX1NJWkUpDQo+IMKgwqAgwqAgwqDCoCBy
ZXR1cm4gTlVMTDsNCj4gDQo+IEhlcmUsIFNNQUxMX1BBR0VfU0laRcKgaXMgZml4ZWQgdG8gNEtC
LiBXaGVuIHJ1bm5pbmcgd2l0aCBhIExpbnV4IGtlcm5lbCBidWlsdCB3aXRoIDE2SyBvciA2NEsg
cGFnZSBzaXplcw0KPiAoQ09ORklHX0FSTTY0XzE2S19QQUdFUyBvciBDT05GSUdfQVJNNjRfNjRL
X1BBR0VTKSwgdGhpcyBjaGVjayBpbmNvcnJlY3RseSByZWplY3RzIHZhbGlkIG9mZnNldHMuDQo+
IEFzIGEgcmVzdWx0LCBtb2JqX2ZmYV9nZXRfYnlfY29va2llKCkgcmV0dXJucyBOVUxMLCB3aGlj
aCBsZWFkcyB0byBURUVfRVJST1JfQkFEX1BBUkFNRVRFUlMgZHVyaW5nIEZGQQ0KPiBjb21tdW5p
Y2F0aW9uIChmb3IgZXhhbXBsZSB3aGVuIHNldF9mbWVtX3BhcmFtKCkgY2FsbHMgaXQpLg0KPiAN
Cj4gSW1wYWN0Og0KPiAtIEZGQSBjb21tdW5pY2F0aW9uIGZhaWxzIG9uIHN5c3RlbXMgd2hlcmUg
dGhlIGtlcm5lbCB1c2VzIDE2SyBvciA2NEsgcGFnZXMuDQo+IC0gV2l0aCAxNksgYmVjb21pbmcg
bW9yZSB3aWRlbHkgYWRvcHRlZCAoZS5nLiBHb29nbGXigJlzIHN0YW5kYXJkaXphdGlvbiksIHRo
aXMgcHJvYmxlbSB3aWxsIGJlIG1vcmUgY29tbW9uLg0KPiANCj4gRXhwZWN0ZWQgYmVoYXZpb3I6
DQo+IFRoZSBmdW5jdGlvbiBzaG91bGQgbm90IGFzc3VtZSBhIGZpeGVkIDRLIHBhZ2Ugc2l6ZSwg
YnV0IGFkYXB0IHRvIHRoZSBhY3R1YWwga2VybmVsIHBhZ2Ugc2l6ZS4NCj4gDQo+IEVudmlyb25t
ZW50Og0KPiAtIE9QLVRFRSB2ZXJzaW9uOiBvYnNlcnZlZCBpbiBtdWx0aXBsZSB2ZXJzaW9ucyBp
bmNsdWRpbmcgbGF0ZXN0IG1hc3Rlcg0KPiAtIFBsYXRmb3JtOiBBUk02NCB3aXRoIEZGQSBlbmFi
bGVkDQo+IC0gS2VybmVsIGNvbmZpZzogQ09ORklHX0FSTTY0XzE2S19QQUdFUyAvIENPTkZJR19B
Uk02NF82NEtfUEFHRVMNCj4gDQo+IFBvc3NpYmxlIGZpeDoNCj4gLSBSZXBsYWNlIHRoZSBTTUFM
TF9QQUdFX1NJWkUgY2hlY2sgd2l0aCBhIGR5bmFtaWMgY2hlY2sgYmFzZWQgb24gdGhlIGtlcm5l
bOKAmXMgYWN0dWFsIHBhZ2Ugc2l6ZSwNCj4gwqAgb3IgbWFrZSB0aGUgdmFsaWRhdGlvbiBjb25m
aWd1cmFibGUuDQoNCkkgZG9uJ3QgdGhpbmsgaXQgaXMgYW4gT1AtVEVFIGJ1ZyBhcyBvZiBub3cg
YnV0IGEgbWlzc2luZyBmZWF0dXJlIGluDQpPUC1URUUgdG8gc3VwcG9ydCAxNksgYW5kIDY0SyBw
YWdlcy4gV291bGQgeW91IGJlIGFibGUgdG8gZW5hYmxlIHRoaXMNCmZlYXR1cmUgZm9yIE9QLVRF
RT8NCg0KLVN1bWl0DQoNCj4gDQo+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBtb3Jl
IGRldGFpbHMuIEkgYW0gaGFwcHkgdG8gdGVzdCBvciBwcm92aWRlIGEgcGF0Y2ggc3VnZ2VzdGlv
biBpZiB0aGF0IGhlbHBzLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBkZHJkdGRuDQo=
