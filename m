Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDCAC87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 16:43:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5B1F14FC89
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 16:43:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9142E42E12
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 16:43:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCEFB12FC;
	Wed, 13 Aug 2025 09:43:25 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.33.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0D923F5A1;
	Wed, 13 Aug 2025 09:43:30 -0700 (PDT)
Date: Wed, 13 Aug 2025 17:42:58 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v19 2/6] remoteproc: Add TEE support
Message-ID: <aJzAkk-k4nfXY7Ux@e130802.arm.com>
References: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
 <20250625094028.758016-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <20250625094028.758016-3-arnaud.pouliquen@foss.st.com>
X-Rspamd-Queue-Id: 9142E42E12
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.40 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:217.140.96.0/20];
	RCVD_IN_DNSWL_MED(-0.20)[217.140.110.172:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:28939, ipnet:217.140.110.0/24, country:GB];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 6KCDXIR4BOO42DYPDELNXK6GN3HLC6BM
X-Message-ID-Hash: 6KCDXIR4BOO42DYPDELNXK6GN3HLC6BM
X-MailFrom: abdellatif.elkhlifi@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Srinivas Kalaga <Srinivas.Kalaga2@arm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6KCDXIR4BOO42DYPDELNXK6GN3HLC6BM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgQXJuYXVkLA0KDQo+IEFkZCBhIHJlbW90ZXByb2MgVEVFIChUcnVzdGVkIEV4ZWN1dGlvbiBF
bnZpcm9ubWVudCkgZHJpdmVyIHRoYXQgd2lsbCBiZQ0KPiBwcm9iZWQgYnkgdGhlIFRFRSBidXMu
IElmIHRoZSBhc3NvY2lhdGVkIFRydXN0ZWQgYXBwbGljYXRpb24gaXMgc3VwcG9ydGVkDQo+IG9u
IHRoZSBzZWN1cmUgcGFydCwgdGhpcyBkcml2ZXIgb2ZmZXJzIGEgY2xpZW50IGludGVyZmFjZSB0
byBsb2FkIGZpcm13YXJlDQo+IGJ5IHRoZSBzZWN1cmUgcGFydC4NCj4gVGhpcyBmaXJtd2FyZSBj
b3VsZCBiZSBhdXRoZW50aWNhdGVkIGJ5IHRoZSBzZWN1cmUgdHJ1c3RlZCBhcHBsaWNhdGlvbi4N
Cj4gDQo+IEEgc3BlY2lmaWNpdHkgb2YgdGhlIGltcGxlbWVudGF0aW9uIGlzIHRoYXQgdGhlIGZp
cm13YXJlIGhhcyB0byBiZQ0KPiBhdXRoZW50aWNhdGVkIGFuZCBvcHRpb25hbGx5IGRlY3J5cHRl
ZCB0byBhY2Nlc3MgdGhlIHJlc291cmNlIHRhYmxlLg0KPiANCj4gQ29uc2VxdWVudGx5LCB0aGUg
Ym9vdCBzZXF1ZW5jZSBpczoNCj4gDQo+IDEpIHJwcm9jX3BhcnNlX2Z3IC0tPiBycHJvY190ZWVf
cGFyc2VfZncNCj4gICAgcmVtb3RlcHJvYyBURUU6DQo+ICAgIC0gUmVxdWVzdHMgdGhlIFRFRSBh
cHBsaWNhdGlvbiB0byBhdXRoZW50aWNhdGUgYW5kIGxvYWQgdGhlIGZpcm13YXJlDQo+ICAgICAg
aW4gdGhlIHJlbW90ZSBwcm9jZXNzb3IgbWVtb3JpZXMuDQo+ICAgIC0gUmVxdWVzdHMgdGhlIFRF
RSBhcHBsaWNhdGlvbiBmb3IgdGhlIGFkZHJlc3Mgb2YgdGhlIHJlc291cmNlIHRhYmxlLg0KPiAg
ICAtIENyZWF0ZXMgYSBjb3B5IG9mIHRoZSByZXNvdXJjZSB0YWJsZSBzdG9yZWQgaW4gcnByb2Mt
PmNhY2hlZF90YWJsZS4NCj4gDQo+IDIpIHJwcm9jX2xvYWRfc2VnbWVudHMgLS0+IHJwcm9jX3Rl
ZV9sb2FkX2Z3DQo+ICAgIHJlbW90ZXByb2MgVEVFOg0KPiAgICAtIFJlcXVlc3RzIHRoZSBURUUg
YXBwbGljYXRpb24gdG8gbG9hZCB0aGUgZmlybXdhcmUuIE5vdGhpbmcgaXMgZG9uZQ0KPiAgICAg
IGF0IHRoZSBURUUgYXBwbGljYXRpb24gYXMgdGhlIGZpcm13YXJlIGlzIGFscmVhZHkgbG9hZGVk
Lg0KPiAgICAtIEluIGNhc2Ugb2YgcmVjb3ZlcnksIHRoZSBURUUgYXBwbGljYXRpb24gaGFzIHRv
IHJlbG9hZCB0aGUgZmlybXdhcmUuDQo+IA0KPiAzKSBycHJvY190ZWVfZ2V0X2xvYWRlZF9yc2Nf
dGFibGUNCj4gICAgcmVtb3RlcHJvYyBURUUgcmVxdWVzdHMgdGhlIFRFRSBhcHBsaWNhdGlvbiBm
b3IgdGhlIGFkZHJlc3Mgb2YgdGhlDQo+ICAgIHJlc291cmNlIHRhYmxlLg0KPiANCj4gNCkgcnBy
b2Nfc3RhcnQgLS0+IHJwcm9jX3RlZV9zdGFydA0KPiAgICAtIFJlcXVlc3RzIHRoZSBURUUgYXBw
bGljYXRpb24gdG8gc3RhcnQgdGhlIHJlbW90ZSBwcm9jZXNzb3IuDQo+IA0KPiBUaGUgc2h1dGRv
d24gc2VxdWVuY2UgaXM6DQo+IA0KPiA1KSBycHJvY19zdG9wIC0tPiBycHJvY190ZWVfc3RvcA0K
PiAgICAtIFJlcXVlc3RzIHRoZSBURUUgYXBwbGljYXRpb24gdG8gc3RvcCB0aGUgcmVtb3RlIHBy
b2Nlc3Nvci4NCj4gDQo+IDYpIHJwcm9jX3RlZV9yZWxlYXNlX2Z3DQo+ICAgIFRoaXMgZnVuY3Rp
b24gaXMgdXNlZCB0byByZXF1ZXN0IHRoZSBURUUgYXBwbGljYXRpb24gdG8gcGVyZm9ybSBhY3Rp
b25zDQo+ICAgIHRvIHJldHVybiB0byB0aGUgaW5pdGlhbCBzdGF0ZSBvbiBzdG9wIG9yIG9uIGVy
cm9yIGR1cmluZyB0aGUgYm9vdA0KPiAgICBzZXF1ZW5jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFybmF1ZCBQb3VsaXF1ZW4gPGFybmF1ZC5wb3VsaXF1ZW5AZm9zcy5zdC5jb20+DQouLi4NCj4g
Kw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZV9pZCBycHJvY190ZWVf
aWRfdGFibGVbXSA9IHsNCj4gKwl7VVVJRF9JTklUKDB4ODBhNGMyNzUsIDB4MGE0NywgMHg0OTA1
LCAweDgyLCAweDg1LCAweDE0LCAweDg2LCAweGE5LCAweDc3LCAweDFhLCAweDA4KX0sDQo+ICsJ
e30NCj4gK307DQoNCk90aGVyIGltcGxlbWVudGF0aW9ucyBtYXkgdXNlIGRpZmZlcmVudCBVVUlE
cy4NCldoYXQgYWJvdXQgYWRkaW5nIGEga2VybmVsIGNvbmZpZ3VyYXRpb24gb3B0aW9uIHdoaWNo
LCB3aGVuIGVuYWJsZWQsIGFsbG93cw0KYWx0ZXJuYXRpdmUgaW1wbGVtZW50YXRpb25zIHRvIG92
ZXJyaWRlIHRoaXMgdGFibGU/DQoNCj4gKy8qKg0KPiArICogcnByb2NfdGVlX3JlZ2lzdGVyKCkg
LSBSZWdpc3RlciBhIHJlbW90ZSBwcm9jZXNzb3IgY29udHJvbGxlZCBieSB0aGUgVEVFIGFwcGxp
Y2F0aW9uLg0KLi4uDQo+ICsNCj4gK3N0YXRpYyBpbnQgcnByb2NfdGVlX2N0eF9tYXRjaChzdHJ1
Y3QgdGVlX2lvY3RsX3ZlcnNpb25fZGF0YSAqdmVyLCBjb25zdCB2b2lkICpkYXRhKQ0KPiArew0K
PiArCS8qIFRvZGF5IHdlIHN1cHBvcnQgb25seSB0aGUgT1AtVEVFLCBjb3VsZCBiZSBleHRlbmQg
dG8gb3RoZXIgdGVlcyAqLw0KPiArCXJldHVybiAodmVyLT5pbXBsX2lkID09IFRFRV9JTVBMX0lE
X09QVEVFKTsNCj4gK30NCg0KQ291bGQgd2UgbWFrZSB2ZXItPmltcGxfaWQgdXNlci1jb25maWd1
cmFibGUgcGxlYXNlID8gZm9yIGV4YW1wbGUsIGJ5IHJlYWRpbmcNCml0IGZyb20gdGhlIGRldmlj
ZSB0cmVlIHNpbmNlIGl0IGlzbuKAmXQgZGlzY292ZXJhYmxlIGF0IHJ1bnRpbWU/IEluIG91ciBz
ZXR1cCwgd2XigJlkIHNldA0KaXQgdG8gVEVFX0lNUExfSURfVFNURUUuDQoNCj4gKw0KPiArc3Rh
dGljIGludCBycHJvY190ZWVfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0
cnVjdCB0ZWVfY29udGV4dCAqdGVlX2N0eDsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJLyogT3Bl
biBjb250ZXh0IHdpdGggVEVFIGRyaXZlciAqLw0KPiArCXRlZV9jdHggPSB0ZWVfY2xpZW50X29w
ZW5fY29udGV4dChOVUxMLCBycHJvY190ZWVfY3R4X21hdGNoLCBOVUxMLCBOVUxMKTsNCj4gKwlp
ZiAoSVNfRVJSKHRlZV9jdHgpKQ0KPiArCQlyZXR1cm4gUFRSX0VSUih0ZWVfY3R4KTsNCj4gKw0K
PiArCXJldCA9IG11dGV4X2xvY2tfaW50ZXJydXB0aWJsZSgmY3R4X2xvY2spOw0KPiArCWlmIChy
ZXQpDQo+ICsJCXJldHVybiByZXQ7DQoNCkluIHNvbWUgVEVFcywgdGhlIGNsaWVudCBkcml2ZXIg
bWlnaHQgbmVlZCB0byBwZXJmb3JtIGV4dHJhIHdvcmsgZHVyaW5nIHByb2JpbmcuDQpGb3IgZXhh
bXBsZSwgd2hlbiB1c2luZyBUUyBURUUsIGNhbGxpbmcgdGVlX3NobV9hbGxvY19rZXJuZWxfYnVm
KCkgaXMgcmVxdWlyZWQuDQpDb3VsZCB3ZSBpbnRyb2R1Y2UgYW4gcnByb2NfdGVlX29wcyBhbmQg
YWRkIGEgVEVFIHByb2JlIG9wZXJhdGlvbiBjYWxsZWQgYnkgdGhlDQpyZW1vdGVwcm9jIGRyaXZl
ciBmb3IgcGVyZm9ybWluZyBjdXN0b20gVEVFIHNldHVwID8NCg0KS2luZCByZWdhcmRzLA0KQWJk
ZWxsYXRpZg0K
