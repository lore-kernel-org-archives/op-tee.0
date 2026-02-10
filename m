Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB60EA3F0D
	for <op-tee@archiver.kernel.org>; Tue, 10 Feb 2026 06:38:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C485436FB
	for <op-tee@archiver.kernel.org>; Tue, 10 Feb 2026 06:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770705488;
	bh=1JiESdNl6hA/KpSPNXftLlPNBImdRMt7BKPhuHuXo5M=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=lbvG0Ib0NG3uXDZUgCpk/HQ+2QR9sFLdQzpLqTGYlwg89jASdu+d0/7xw39rw/ypT
	 KH0lshriOE36Y8/tsPBn1UBTUIYi2GeVlxh0iWlOKz5nJ0p6D6uDXGpA9dohR5eiJ4
	 ChV9E9D/+nONcrwgSOLxX1qpScae+BY0Ioayswy1ijYRvScEBq1gnW2eMSIiiyuDdS
	 STkkPaS779IZ9oGriRP8WncPpMfHNlCqomOkv/hnDVCxeSHaNYXGQMHWhxLzWRCKrG
	 rgMoVy5A9//A+fI9Bytjh84hH/sCcFUxAPQ6fo38OqEFx9dVhdUr6pK3e8mQOL3LTu
	 cBW37xI7NIQFQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CC3F542D86
	for <op-tee@lists.trustedfirmware.org>; Tue, 10 Feb 2026 06:23:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nyF7BGSO;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CA4F843ADF;
	Tue, 10 Feb 2026 06:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8796C116C6;
	Tue, 10 Feb 2026 06:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770704047;
	bh=NOoZ/TSgvmHM8MvVRv66uYCD2q1u3i1JerRCuxg/nYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyF7BGSOacd8nQFeoyK69yTrIr6WEkiceyw4AmLFO/LBQGkpzoYRL1Vq5peFNPXe5
	 2GRB93lvaDKY5I95NdSIEuSaoLOw+lFX62Vn/TwPEa9Foqr2ip4DHypDXObc0s47hm
	 l9cluPBg1t1rZcpe3oVwhndSnk7Fq7d/VVseZG6N4sgGTylUK45zCAX5cliiSo6+jt
	 Mo91W1qf9xn5E1n3sp/ZH6wUnhHCefuLoo6zDX0kFRKpBbjJCABmCXEKRONaCkbyhB
	 bkeUykXpi+rRobG0QkSxwlMXFlViarS0V5Xg7DPijQAOTHtIPVfinRdmfJPm9O0Ipa
	 SjUbczIUskKLg==
Date: Tue, 10 Feb 2026 11:43:59 +0530
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Subject: Re: [Linux-stm32] [PATCH v20 1/6] dt-bindings: firmware: Add TEE
 remoteproc service binding
Message-ID: <aYrMp9wqk91-tQXn@sumit-xelite>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
 <20251229232530.GA2753472-robh@kernel.org>
 <aVOzHWmlJ-eneS-2@sumit-xelite>
 <CAL_Jsq+_S8UY7s7WQg9jXuBXCYMBWVCy=kVDMdkKTx6RctqQJA@mail.gmail.com>
 <aVtqITUxy--E8HJt@sumit-xelite>
 <49f1808d-1e08-4f47-ac3a-5f2274086060@foss.st.com>
 <a17c017a-15f5-4ebc-9dd0-baab718dbe0a@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <a17c017a-15f5-4ebc-9dd0-baab718dbe0a@foss.st.com>
X-Rspamd-Action: add header
X-Spamd-Result: default: False [5.00 / 15.00];
	URL_BACKSLASH_PATH(4.00)[0.0.0.0];
	URL_NUMERIC_IP(3.00)[0.0.0.0];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	GREYLIST(0.00)[pass,body];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CC3F542D86
X-Spamd-Bar: +++++
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Hits: header-match-op-tee.lists.trustedfirmware.org-0
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Message-ID-Hash: FQXWSMGSYHFOBKIZKXEBQZLK6BBNUNAN
X-Message-ID-Hash: FQXWSMGSYHFOBKIZKXEBQZLK6BBNUNAN
X-Mailman-Approved-At: Tue, 10 Feb 2026 06:37:48 +0000
CC: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, op-tee@lists.trustedfirmware.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FQXWSMGSYHFOBKIZKXEBQZLK6BBNUNAN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>
X-Spam: Yes

SGkgQXJuYXVkLA0KDQpPbiBUdWUsIEZlYiAwMywgMjAyNiBhdCAwODo0MjozNEFNICswMTAwLCBB
cm5hdWQgUE9VTElRVUVOIHdyb3RlOg0KPiANCj4gSGVsbG8gUm9iLCBTdW1pdCwNCj4gDQo+IEp1
c3QgYSBnZW50bGUgcmVtaW5kZXIuIENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB5b3VyIGFkdmlj
ZSBvciBhIGNvbmNsdXNpb24NCj4gb24gdGhlIGRpcmVjdGlvbiB3ZSBzaG91bGQgdGFrZSBmb3Ig
dGhlIERUIGRlY2xhcmF0aW9uPyBJIG5lZWQgeW91ciBpbnB1dCB0bw0KPiBiZSBhYmxlIHRvIG1v
dmUgZm9yd2FyZC4NCj4gDQo+IFRoYW5rcyBhbmQgcmVnYXJkcywNCj4gQXJuYXVkDQo+IA0KPiBP
biAxLzEzLzI2IDEwOjIwLCBBcm5hdWQgUE9VTElRVUVOIHdyb3RlOg0KPiA+IEhlbGxvLA0KPiA+
IA0KPiA+IE9uIDEvNS8yNiAwODozNywgU3VtaXQgR2FyZyB3cm90ZToNCj4gPiA+IE9uIEZyaSwg
SmFuIDAyLCAyMDI2IGF0IDA0OjE3OjI3UE0gLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+
ID4gPiBPbiBUdWUsIERlYyAzMCwgMjAyNSBhdCA1OjEw4oCvQU0gU3VtaXQgR2FyZw0KPiA+ID4g
PiA8c3VtaXQuZ2FyZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBP
biBNb24sIERlYyAyOSwgMjAyNSBhdCAwNToyNTozMFBNIC0wNjAwLCBSb2IgSGVycmluZyB3cm90
ZToNCj4gPiA+ID4gPiA+IE9uIFdlZCwgRGVjIDE3LCAyMDI1IGF0IDA0OjM5OjEyUE0gKzAxMDAs
IEFybmF1ZCBQb3VsaXF1ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEFkZCBhIGRldmljZSB0cmVl
IGJpbmRpbmcgZm9yIHRoZSBURUUtYmFzZWQgcmVtb3RlIHByb2Nlc3NvciBjb250cm9sDQo+ID4g
PiA+ID4gPiA+IHNlcnZpY2UgaW1wbGVtZW50ZWQgYXMgYW4gT1AtVEVFIFRydXN0ZWQgQXBwbGlj
YXRpb24gaWRlbnRpZmllZCBieQ0KPiA+ID4gPiA+ID4gPiBVVUlEIDgwYTRjMjc1LTBhNDctNDkw
NS04Mjg1LTE0ODZhOTc3MWEwOC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFRoZSBU
RUUgc2VydmljZSBub2RlIGlzIGEgY2hpbGQgb2YgdGhlDQo+ID4gPiA+ID4gPiA+ICJsaW5hcm8s
b3B0ZWUtdHoiIGZpcm13YXJlIG5vZGUgYW5kDQo+ID4gPiA+ID4gPiA+IGFjdHMgYXMgYSBjb250
YWluZXIgZm9yIHJlbW90ZXByb2MgZGV2aWNlcyB0aGF0IGFyZQ0KPiA+ID4gPiA+ID4gPiBjb250
cm9sbGVkIHZpYSBURUUuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElzIHRoaXMgZ2VuZXJp
YyBmb3IgYW55IHJlbW90ZXByb2MgZGV2aWNlIG9yIGp1c3QgU1Qncw0KPiA+ID4gPiA+ID4gcmVt
b3RlcHJvYy4gTG9va3MNCj4gPiA+ID4gPiA+IGxpa2UgdGhlIGxhdHRlciB0byBtZS4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBUaGF0J3MgdHJ1ZSwgdGhlIERUIGRlc2NyaXB0aW9uIG9mIHRoZSBy
ZW1vdGVwcm9jIHN1Ym5vZGUgaXMgdmVyeQ0KPiA+ID4gPiA+IHNwZWNpZmljIHRvIHRoZSB2ZW5k
b3Igd2hpY2ggaW4gdGhpcyBjYXNlIGlzIFNULg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+IEluIGFkZGl0aW9uLCB0aGUgImxpbmFybyxvcHRlZS10eiIgYmluZGluZyBp
cyB1cGRhdGVkIHRvIHNwZWNpZnkgdGhlDQo+ID4gPiA+ID4gPiA+ICcjYWRkcmVzcy1jZWxscycg
YW5kICcjc2l6ZS1jZWxscycgdmFsdWVzIHVzZWQgZm9yIGNoaWxkIFRFRSBzZXJ2aWNlDQo+ID4g
PiA+ID4gPiA+IG5vZGVzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJJ20gcHJldHR5IHN1
cmUgSSBhbHJlYWR5IHJlamVjdGVkIHBlciBzZXJ2aWNlL2FwcCBjaGlsZCBub2RlcyBmb3INCj4g
PiA+ID4gPiA+IE9QLVRFRSB3aGVuIGl0cyBiaW5kaW5nIHdhcyBzdWJtaXR0ZWQuDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gVGhhdCB3YXMgdGhlIHJlYXNvbiB0byBoYXZlIGRpc2NvdmVyYWJsZSBU
RUUgYnVzIGluIGZpcnN0IHBsYWNlIGFuZCBJDQo+ID4gPiA+ID4gaGF2ZSBiZWVuIG1vdGl2YXRp
bmcgcGVvcGxlIHRvIGR5bmFtaWNhbGx5IGRpc2NvdmVyIGZpcm13YXJlIHByb3BlcnRpZXMNCj4g
PiA+ID4gPiByYXRoZXIgdGhhbiBoYXJkY29kaW5nIGluIHRoZSBEVC4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IElmIHdlIGRvIG5lZWQgc29tZXRoaW5nIGluIERUDQo+ID4gPiA+ID4gPiB0byBk
ZWZpbmUgc29tZSByZXNvdXJjZXMsIHRoZW4gY2FuJ3Qgd2UgaGF2ZSBzb21lIHNvcnQgb2YNCj4g
PiA+ID4gPiA+IHN0YW5kYXJkL2NvbW1vbiBjb21tdW5pY2F0aW9ucyBjaGFubmVsPyBJIGRvbid0
IGNhcmUgdG8NCj4gPiA+ID4gPiA+IHNlZSBzb21lIHNvcnQgb2YNCj4gPiA+ID4gPiA+IGZyZWUt
Zm9yLWFsbCB3aGVyZSB3ZSBoYXZlIGV2ZXJ5IHZlbmRvciBkb2luZyB0aGVpciBvd24gdGhpbmcu
IE9QLVRFRQ0KPiA+ID4gPiA+ID4gbmVlZHMgdG8gc3RhbmRhcml6ZSB0aGlzLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IEkgc3VwcG9zZSB0aGlzIHJlcXVpcmVzIGEgd2lkZXIgc2NvcGUgd29yayBh
cyB5b3UgY2FuIHNlZQ0KPiA+ID4gPiA+IHRoZSBEVCByZXNvdXJjZQ0KPiA+ID4gPiA+IGRlcGVu
ZGVuY2UgZnJvbSBoZXJlIFsxXS4gQnkgc3RhbmRhcmRpemUgY29tbXVuaWNhdGlvbiBjaGFubmVs
LCBkbyB5b3UNCj4gPiA+ID4gPiBtZWFuIHRvIHNheSBpZiBhZGRpbmcgYW4gYWx0ZXJuYXRpdmUg
YmFja2VuZCB0byBmd25vZGUgZm9yIFRFRSBpbg0KPiA+ID4gPiA+IHBhcmFsbGVsIHRvIERULCBB
Q1BJIG9yIHN3bm9kZSBpcyB0aGUgd2F5IHRvIGdvIGZvciBkaXNjb3ZlcmluZyBmdw0KPiA+ID4g
PiA+IHByb3BlcnRpZXM/DQo+ID4gPiA+IA0KPiA+ID4gPiBObywgbm90IGF0IGFsbC4NCj4gPiA+
ID4gDQo+ID4gPiA+ID4gT3IgZG8geW91IGhhdmUgYW55IG90aGVyIHN1Z2dlc3Rpb24gaGVyZT8N
Cj4gPiA+ID4gDQo+ID4gPiA+IFdoYXQgSSBtZWFuIGlzIHdoeSBkb2Vzbid0IHRoZSBURUUgZGVm
aW5lIHRoZSBjb21tdW5pY2F0aW9uIGNoYW5uZWwNCj4gPiA+ID4gKG1haWxib3grc2htZW0gYW5k
IG5vdGlmaWNhdGlvbiBpbnRlcnJ1cHQpIHJhdGhlciB0aGFuIGVhY2ggVEVFIGFwcD8NCj4gPiA+
IA0KPiA+ID4gVGhlIHN5bmNocm9ub3VzIGNvbW11bmljYXRpb24gY2hhbm5lbCBpcyBhbHJlYWR5
IHRoZXJlIGZvciBlYWNoIFRFRSBhcHANCj4gPiA+IGJhc2VkIG9uIChpbnZva2UgY29tbWFuZHMg
KyBURUUgc2hhcmVkIG1lbW9yeSkuIE9QLVRFRSBkb2VzIHN1cHBvcnQNCj4gPiA+IG5vdGlmaWNh
dGlvbiBpbnRlcnJ1cHRzIHRvbyBidXQgdGhvc2UgaGF2ZW4ndCBiZWVuIGV4cG9zZWQgdG8gVEVF
IGNsaWVudA0KPiA+ID4gZHJpdmVycyB5ZXQuIEkgc3VwcG9zZSB0aGlzIHJlbW90ZXByb2MgdXNl
LWNhc2UgY2FuIGJlIGEgZ29vZCBleGFtcGxlIHRvDQo+ID4gPiBleHBvc2UgdGhhdCBhcyBhIGdl
bmVyaWMgVEVFIG5vdGlmaWNhdGlvbiBpbnRlcmZhY2UgdG9vLg0KPiA+IA0KPiA+IEluIHRoZSBT
VE0zMk1QIHNlcmllcywgdGhlIG1haWxib3hlcyBhbmQgc2hhcmVkIFJBTSBhcmUgdXNlZCBmb3Ig
UlBNc2cNCj4gPiBjb21tdW5pY2F0aW9uIGJldHdlZW4gTGludXggYW5kIHRoZSByZW1vdGUgcHJv
Y2Vzc29yLiBNeSBjb25jZXJuIGlzIHRoYXQNCj4gPiB1c2luZyBub3RpZmljYXRpb24gaW4gT1At
VEVFIGNvdWxkIGltcGFjdCBwZXJmb3JtYW5jZSBieSBpbnRyb2R1Y2luZw0KPiA+IGxhdGVuY3ku
IEFkZGl0aW9uYWxseSwgdGhpcyBtaWdodCByZXF1aXJlIGEgRE1BIGFsbG9jYXRvciBpbiBPUC1U
RUUgdG8NCj4gPiBtYW5hZ2UgdGhlIHNoYXJlZCBtZW1vcnkuIE9uZSBSUE1zZyB2aXJ0aW8gcmVx
dWlyZXMgdGhlIGRlY2xhcmF0aW9uIG9mDQo+ID4gYXQgbGVhc3QgdGhyZWUgY2FydmVvdXRzLiBN
YW5hZ2luZyB0aGVzZSBhcyBtZW1vcnkgcmVnaW9ucyBpbiBPUC1URUUNCj4gPiB3b3VsZCBiZSBj
b21wbGV4IChkdWUgdG8gbGltaXRlZCBudW1iZXIgb2YgbWVtb3J5IGFyZWEgZGVjbGFyYXRpb24g
b24NCj4gPiBTVE0zMk1QMikuDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE1vcmUgZ2VuZXJh
bGx5LCBpcyBoYXZpbmcgVEVFIGFwcHMgZGVwZW5kaW5nIG9uIHJhbmRvbSBEVCByZXNvdXJjZXMN
Cj4gPiA+ID4gcmVhbGx5IGEgYm94IHdlIHdhbnQgdG8gb3Blbj8gSXMgdGhlIG5leHQgdGhpbmcg
Z29pbmcgdG8gYmUgYSBURUUNCj4gPiA+ID4gY2xvY2svcmVzZXQvZ3Bpby9wb3dlciBwcm92aWRl
cj8gV2hlcmUgZG8gd2UgZHJhdyB0aGUgbGluZT8NCj4gPiA+IA0KPiA+ID4gVGhpcyBpcyByZWFs
bHkgYSBoYXJkIGxpbmUgdG8gZHJhdyBzaW5jZSBzaWxpY29uL09FTSB2ZW5kb3JzIGJhc2VkDQo+
ID4gPiBvbiB0aGVpcg0KPiA+ID4gaGFyZHdhcmUgc2VjdXJpdHkgYXJjaGl0ZWN0dXJlIHBhcnRp
dGlvbiB2YXJpb3VzIHJlc291cmNlcyBhbW9uZyBURUUgYW5kDQo+ID4gPiB0aGUgTGludXggd29y
bGQuIEFuZCBvbmUgZ2VuZXJhbCBwcmluY2lwbGUgd2UgdHJ5IHRvIGZvbGxvdyBmb3IgdGhlIFRF
RQ0KPiA+ID4gaXMgdG8ga2VlcCBpdCdzIFRydXN0ZWQgQ29tcHV0aW5nIEJhc2UgKFRDQikgdG8g
YSBtaW5pbWFsIHRvby4NCj4gPiA+IA0KPiA+ID4gSU1ITywgaWYgdGhlIHRocmVhdCBtb2RlbCBp
cyB3ZWxsIHVuZGVyc3Rvb2QgdGhlbiB3ZSBzaG91bGQgYWxsb3cgZm9yDQo+ID4gPiB0aGlzIGhl
dHJvZ2Vub3VzIHBhcnRpdGlvbmluZyBvZiBzeXN0ZW0gcmVzb3VyY2VzLg0KPiA+IA0KPiA+IEhl
cmUgYXJlIHNvbWUgYWRkaXRpb25hbCByZXNvdXJjZXMgd2UgbmVlZCB0byBtYW5hZ2UgdGhlIHJl
bW90ZQ0KPiA+IHByb2Nlc3Nvciwgd2hpY2ggc2VlbSBjb21wbGV4IHRvIGhhbmRsZSB3aXRob3V0
IERldmljZSBUcmVlIChEVCk6DQo+ID4gDQo+ID4gLSBDbG9ja3M6IE9uIFNUTTMyTVAsIHdlIG1h
bmFnZSBjbG9ja3MgdGhyb3VnaCB0aGUgT1AtVEVFIFNDTUkgc2VydmljZQ0KPiA+ICDCoCBbMV0u
IFRoZSBTQ01JIE9QLVRFRSBjbG9jay9yZXNldCBzZXJ2aWNlIGFscmVhZHkgZXhpc3RzIGFuZCBz
aG91bGQgYmUNCj4gPiAgwqAgcmV1c2VkLg0KPiA+IC0gUG93ZXIgZG9tYWlucw0KPiA+IC0gUmVt
b3RlcHJvYyBXYXRjaGRvZyBpbnRlcnJ1cHQ6IENhbm5vdCBiZSBjYXVnaHQgYnkgT1AtVEVFIG9u
DQo+ID4gIMKgIHN0bTMybXAxNS4NCj4gPiAtIEdyYWNlZnVsIHNodXRkb3duIG9mIHRoZSByZW1v
dGUgcHJvY2Vzc29yOiBUaGlzIGludm9sdmVzIHNlbmRpbmcgYQ0KPiA+ICDCoCBtYWlsYm94IG5v
dGlmaWNhdGlvbiB0byByZXF1ZXN0IHNodXRkb3duIGFuZCB3YWl0aW5nIHVwIHRvIDUwMCBtcyBm
b3INCj4gPiAgwqAgdGhlIHJlbW90ZXByb2MgdG8gZGVpbml0aWFsaXplIGl0cyByZXNvdXJjZXMu
IFdhaXRpbmcgdGhpcyBsb25nIGluIHRoZQ0KPiA+ICDCoCBzZWN1cmUgY29udGV4dCBzZWVtcyBp
bmVmZmljaWVudC4NCj4gPiAtIGNvbXBhdGliaWxpdHkgd2l0aCBzb21lIGNvbWluZyBJUEMgbWVj
aGFuaXNtczogU3VjaCBhcyBycG1zZ19JMkMgb3INCj4gPiAgwqAgdmlydGlvLW1zZyBtaWdodCBy
ZXF1aXJlIHJlbW90ZXByb2Mgc3Vibm9kZSBkZXNjcmlwdGlvbnMgaW4gdGhlDQo+ID4gIMKgIGZ1
dHVyZS4NCj4gPiANCj4gPiBJZiB0aGUgcHJvcG9zZWQgdG9wb2xvZ3kgZG9lcyBub3QgZ2FpbiBj
b25zZW5zdXMsIHdoYXQgYWJvdXQgYW4NCj4gPiBhbHRlcm5hdGl2ZSBhcHByb2FjaCB0aGF0IG1h
bmFnZXMgdGhlIHJlbW90ZXByb2MgVEVFIHNpbWlsYXJseSB0byBTQ01JLA0KPiA+IGJ5IGludHJv
ZHVjaW5nIGEgcmVtb3RlcHJvYy1iYWNrZW5kIHdpdGggdGhlIHByb2MgSUQgYXMgYSBwYXJhbWV0
ZXI/DQo+ID4gDQo+ID4gDQo+ID4gJmZpcm13YXJlIHsNCj4gPiAgwqDCoMKgIG9wdGVlOiBvcHRl
ZSB7DQo+ID4gIMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAibGluYXJvLG9wdGVlLXR6IjsN
Cj4gPiAgwqDCoMKgwqDCoMKgwqAgbWV0aG9kID0gInNtYyI7DQo+ID4gIMKgwqDCoMKgwqDCoMKg
IHNwcm9jOiBzcHJvYyB7DQo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9
ICI4MGE0YzI3NS0wYTQ3LTQ5MDUtODI4NS0xNDg2YTk3NzFhMDgiOw0KPiA+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICDCoMKgwqDCoMKgwqDCoCAj
c2l6ZS1jZWxscyA9IDwwPjsNCj4gPiAgwqDCoMKgwqDCoMKgwqAgfTsNCj4gPiAgwqDCoMKgIH07
DQo+ID4gfTsNCj4gPiANCj4gPiBycHJvYzE6IG0zM0AwIHsNCj4gPiAgwqAgWy4uLl0NCj4gPiAN
Cj4gPiAgwqAgcmVtb3RlcHJvYy1iYWNrZW5kID0gPCAmc3Byb2MgMD4NCj4gPiB9Ow0KPiA+IA0K
PiA+IA0KPiA+IHJwcm9jMjogbTBAMCB7DQo+ID4gIMKgIFsuLi5dDQo+ID4gDQo+ID4gIMKgIHJl
bW90ZXByb2MtYmFja2VuZCA9IDwgJnNwcm9jIDE+DQo+ID4gfTsNCg0KVXNpbmcgYSBwaGFuZGxl
IGxpa2UgdGhpcyBtYWtlcyBpdCBhIGJpdCBtb3JlIGNsZWFuZXIgYnV0IEkgd291bGQgZGVmZXIN
CnRvIFJvYiBzaW5jZSBoZSBoYXMgdGhlIGZpbmFsIHNheSBoZXJlLg0KDQotU3VtaXQNCg0KPiA+
IA0KPiA+IA0KPiA+IFsxXWh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE4LjQv
c291cmNlL2RyaXZlcnMvY2xrL2Nsay1zY21pLmMNCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gQXJu
YXVkDQo+ID4gDQo+ID4gPiANCj4gPiA+IC1TdW1pdA0KPiA+IA0KPiA+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gTGludXgtc3RtMzIgbWFpbGlu
ZyBsaXN0DQo+ID4gTGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbQ0KPiA+
IGh0dHBzOi8vc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbS9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXN0bTMyDQo+IA0K
