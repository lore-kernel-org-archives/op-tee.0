Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CF3C9EC76
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 11:22:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E89664327A
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 11:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768216966;
	bh=UB1NDRU7kQyhZmdaknDdQkqLRF9fzkOpC62lwXs+YNY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JK2iu3FZRs6EWbYgJ5NwupdFZFzemUSdXWLulCENv12QOAsvdrC7blW4LJp9JsAvr
	 4pQL+8CJTn8v78drHFl3Jy4fVPQjJgPnF1oFuGw0TAqO3sSMTcUzGwuTSR7rKkH3Tv
	 +M9BkyVd5SsXSJ8s8rnQrVdN+qkLupj0/rrO3nGZbLIw7MT7L7OH/EbsCAXgHTUKRt
	 Ga0dYdFgq+l4RSrZ0JRSQFVRXFSwg5oN2nya9K53+M24ipTfvCqspzSJ+aFI1j+kaO
	 wryiQmwCmxdUa08lN4KZ/uRXLI4B62NDOaxl8JZV/EAikT1mVeGPrpKX5iarfwCSar
	 bfqK3bbVAjgFQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8BBD243252
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 11:22:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aZ0GmMFJ;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DA20C409A1;
	Mon, 12 Jan 2026 11:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC44C16AAE;
	Mon, 12 Jan 2026 11:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768216946;
	bh=ZNhUJoEkfFZHV8lEIh9qAH7JsrlKQ0N3Vtt30fWOdh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZ0GmMFJxammjEZzzQZRjD0eX4IF5kT9fvCTEfaPCBo7lQYrnCQpiUrBd3aOyyAmO
	 RfKzh4D1frgE4GgAeCE0O/qI4gEQSiuirqhyfbmPTDRBQBP2aycPIKPFjLUg0CfyUN
	 7MSL/vgYZeHOnVnKQQH3Pk/3qlx/j+9GXwYuZEEBmeIbsMAub/5VC8oZ1/c6IVjgHi
	 Ynq0s3nWT5OWN0eLNvVIVh0ozWfJ/VdEtdOIE2AZ8wfAy8u/+8LslxwathysQD3OzO
	 noJ4XFIQdADkPDy20AnisIn1uiZEBTXPIsoLpqB08xc42ZIrS+nP9Q3Peh8iCfJE+U
	 Bv34aHXRTfIdQ==
Date: Mon, 12 Jan 2026 16:52:20 +0530
To: Aristo Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH v6 2/2] tee: optee: store OS revision for TEE core
Message-ID: <aWTZbH3G-PgOz4cz@sumit-xelite>
References: <20260107152607.902735-1-aristo.chen@canonical.com>
 <20260108064517.13854-1-aristo.chen@canonical.com>
 <20260108064517.13854-2-aristo.chen@canonical.com>
 <aWDrejFoUtKy6wdE@sumit-xelite>
 <CAJwFiG+GKKa-vYwWzY8Dyw7GsaTq90kAyHWz1NJ28Bni43-nTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAJwFiG+GKKa-vYwWzY8Dyw7GsaTq90kAyHWz1NJ28Bni43-nTQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8BBD243252
X-Spamd-Bar: -
Message-ID-Hash: RJDREG4TXURNBTGF7MQ3UNN4YUTXV6B2
X-Message-ID-Hash: RJDREG4TXURNBTGF7MQ3UNN4YUTXV6B2
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RJDREG4TXURNBTGF7MQ3UNN4YUTXV6B2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gRnJpLCBKYW4gMDksIDIwMjYgYXQgMTE6MDc6NDBQTSArMDgwMCwgQXJpc3RvIENoZW4gd3Jv
dGU6DQo+IEhpIFN1bWl0DQo+IA0KPiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGtlcm5lbC5vcmc+
IOaWvCAyMDI25bm0MeaciDnml6XpgLHkupQg5LiL5Y2INzo1MOWvq+mBk++8mg0KPiA+DQo+ID4g
T24gVGh1LCBKYW4gMDgsIDIwMjYgYXQgMDI6NDU6MDlQTSArMDgwMCwgQXJpc3RvIENoZW4gd3Jv
dGU6DQo+ID4gPiBDb2xsZWN0IE9QLVRFRSBPUyByZXZpc2lvbiBmcm9tIHNlY3VyZSB3b3JsZCBm
b3IgYm90aCBTTUMgYW5kIEZGLUENCj4gPiA+IEFCSXMsIHN0b3JlIGl0IGluIHRoZSBPUC1URUUg
ZHJpdmVyLCBhbmQgZXhwb3NlIGl0IHRocm91Z2ggdGhlDQo+ID4gPiBnZW5lcmljIGdldF90ZWVf
cmV2aXNpb24oKSBjYWxsYmFjay4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBcmlzdG8g
Q2hlbiA8YXJpc3RvLmNoZW5AY2Fub25pY2FsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZl
cnMvdGVlL29wdGVlL2NvcmUuYyAgICAgICAgICB8IDIzICsrKysrKysrKysrKysNCj4gPiA+ICBk
cml2ZXJzL3RlZS9vcHRlZS9mZmFfYWJpLmMgICAgICAgfCA1NyArKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tDQo+ID4gPiAgZHJpdmVycy90ZWUvb3B0ZWUvb3B0ZWVfcHJpdmF0ZS5oIHwg
MTkgKysrKysrKysrKysNCj4gPiA+ICBkcml2ZXJzL3RlZS9vcHRlZS9zbWNfYWJpLmMgICAgICAg
fCAxNSArKysrKystLQ0KPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKSwg
MTUgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL29w
dGVlL2NvcmUuYyBiL2RyaXZlcnMvdGVlL29wdGVlL2NvcmUuYw0KPiA+ID4gaW5kZXggNWI2MjEz
OTcxNGNlLi4yZDgwN2JjNzQ4YmMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3RlZS9vcHRl
ZS9jb3JlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL2NvcmUuYw0KPiA+ID4gQEAg
LTYzLDYgKzYzLDI5IEBAIGludCBvcHRlZV9zZXRfZG1hX21hc2soc3RydWN0IG9wdGVlICpvcHRl
ZSwgdV9pbnQgcGFfd2lkdGgpDQo+ID4gPiAgICAgICByZXR1cm4gZG1hX2NvZXJjZV9tYXNrX2Fu
ZF9jb2hlcmVudCgmb3B0ZWUtPnRlZWRldi0+ZGV2LCBtYXNrKTsNCj4gPiA+ICB9DQo+ID4gPg0K
PiA+ID4gK2ludCBvcHRlZV9nZXRfcmV2aXNpb24oc3RydWN0IHRlZV9kZXZpY2UgKnRlZWRldiwg
Y2hhciAqYnVmLCBzaXplX3QgbGVuKQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgIHN0cnVjdCBvcHRl
ZSAqb3B0ZWUgPSB0ZWVfZ2V0X2RydmRhdGEodGVlZGV2KTsNCj4gPiA+ICsgICAgIHU2NCBidWls
ZF9pZDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIGlmICghb3B0ZWUpDQo+ID4gPiArICAgICAgICAg
ICAgIHJldHVybiAtRU5PREVWOw0KPiA+ID4gKyAgICAgaWYgKCFidWYgfHwgIWxlbikNCj4gPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4gPiArICAgICBidWls
ZF9pZCA9IG9wdGVlLT5yZXZpc2lvbi5vc19idWlsZF9pZDsNCj4gPiA+ICsgICAgIGlmIChidWls
ZF9pZCkNCj4gPiA+ICsgICAgICAgICAgICAgc2NucHJpbnRmKGJ1ZiwgbGVuLCAiJXUuJXUgKCUw
MTZsbHgpIiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG9wdGVlLT5yZXZpc2lvbi5v
c19tYWpvciwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG9wdGVlLT5yZXZpc2lvbi5v
c19taW5vciwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICh1bnNpZ25lZCBsb25nIGxv
bmcpYnVpbGRfaWQpOw0KPiA+ID4gKyAgICAgZWxzZQ0KPiA+ID4gKyAgICAgICAgICAgICBzY25w
cmludGYoYnVmLCBsZW4sICIldS4ldSIsIG9wdGVlLT5yZXZpc2lvbi5vc19tYWpvciwNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIG9wdGVlLT5yZXZpc2lvbi5vc19taW5vcik7DQo+ID4g
PiArDQo+ID4gPiArICAgICByZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAgc3Rh
dGljIHZvaWQgb3B0ZWVfYnVzX3NjYW4oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ID4g
IHsNCj4gPiA+ICAgICAgIFdBUk5fT04ob3B0ZWVfZW51bWVyYXRlX2RldmljZXMoUFRBX0NNRF9H
RVRfREVWSUNFU19TVVBQKSk7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvb3B0ZWUv
ZmZhX2FiaS5jIGIvZHJpdmVycy90ZWUvb3B0ZWUvZmZhX2FiaS5jDQo+ID4gPiBpbmRleCBiZjgz
OTA3ODllY2YuLjgyZGJlZDFjODdlNSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdGVlL29w
dGVlL2ZmYV9hYmkuYw0KPiA+ID4gKysrIGIvZHJpdmVycy90ZWUvb3B0ZWUvZmZhX2FiaS5jDQo+
ID4gPiBAQCAtNzc1LDYgKzc3NSw0MiBAQCBzdGF0aWMgaW50IG9wdGVlX2ZmYV9yZWNsYWltX3By
b3RtZW0oc3RydWN0IG9wdGVlICpvcHRlZSwNCj4gPiA+ICAgKiB3aXRoIGEgbWF0Y2hpbmcgY29u
ZmlndXJhdGlvbi4NCj4gPiA+ICAgKi8NCj4gPiA+DQo+ID4gPiArc3RhdGljIGJvb2wgb3B0ZWVf
ZmZhX2dldF9vc19yZXZpc2lvbihzdHJ1Y3QgZmZhX2RldmljZSAqZmZhX2RldiwNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGZmYV9vcHMg
Km9wcywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IG9wdGVlX3JldmlzaW9uICpyZXZpc2lvbiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYm9vbCBsb2cpDQo+ID4gPiArew0KPiA+ID4gKyAgICAgY29uc3Qgc3Ry
dWN0IGZmYV9tc2dfb3BzICptc2dfb3BzID0gb3BzLT5tc2dfb3BzOw0KPiA+ID4gKyAgICAgc3Ry
dWN0IGZmYV9zZW5kX2RpcmVjdF9kYXRhIGRhdGEgPSB7DQo+ID4gPiArICAgICAgICAgICAgIC5k
YXRhMCA9IE9QVEVFX0ZGQV9HRVRfT1NfVkVSU0lPTiwNCj4gPiA+ICsgICAgIH07DQo+ID4gPiAr
ICAgICBpbnQgcmM7DQo+ID4gPiArDQo+ID4gPiArICAgICBtc2dfb3BzLT5tb2RlXzMyYml0X3Nl
dChmZmFfZGV2KTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHJjID0gbXNnX29wcy0+c3luY19zZW5k
X3JlY2VpdmUoZmZhX2RldiwgJmRhdGEpOw0KPiA+ID4gKyAgICAgaWYgKHJjKSB7DQo+ID4gPiAr
ICAgICAgICAgICAgIHByX2VycigiVW5leHBlY3RlZCBlcnJvciAlZFxuIiwgcmMpOw0KPiA+ID4g
KyAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiArICAgICB9DQo+ID4gPiArDQo+ID4g
PiArICAgICBpZiAocmV2aXNpb24pIHsNCj4gPiA+ICsgICAgICAgICAgICAgcmV2aXNpb24tPm9z
X21ham9yID0gZGF0YS5kYXRhMDsNCj4gPiA+ICsgICAgICAgICAgICAgcmV2aXNpb24tPm9zX21p
bm9yID0gZGF0YS5kYXRhMTsNCj4gPiA+ICsgICAgICAgICAgICAgcmV2aXNpb24tPm9zX2J1aWxk
X2lkID0gZGF0YS5kYXRhMjsNCj4gPiA+ICsgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICsgICAgIGlm
IChsb2cpIHsNCj4gPiA+ICsgICAgICAgICAgICAgaWYgKGRhdGEuZGF0YTIpDQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgcHJfaW5mbygicmV2aXNpb24gJWx1LiVsdSAoJTA4bHgpIiwNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEuZGF0YTAsIGRhdGEuZGF0YTEs
IGRhdGEuZGF0YTIpOw0KPiA+ID4gKyAgICAgICAgICAgICBlbHNlDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgcHJfaW5mbygicmV2aXNpb24gJWx1LiVsdSIsIGRhdGEuZGF0YTAsIGRhdGEu
ZGF0YTEpOw0KPiA+ID4gKyAgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgcmV0dXJuIHRydWU7
DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gIHN0YXRpYyBib29sIG9wdGVlX2ZmYV9hcGlfaXNf
Y29tcGF0aWJsZShzdHJ1Y3QgZmZhX2RldmljZSAqZmZhX2RldiwNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGZmYV9vcHMgKm9wcykNCj4g
PiA+ICB7DQo+ID4gPiBAQCAtNzk4LDE5ICs4MzQsOCBAQCBzdGF0aWMgYm9vbCBvcHRlZV9mZmFf
YXBpX2lzX2NvbXBhdGlibGUoc3RydWN0IGZmYV9kZXZpY2UgKmZmYV9kZXYsDQo+ID4gPiAgICAg
ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiAtICAg
ICBkYXRhID0gKHN0cnVjdCBmZmFfc2VuZF9kaXJlY3RfZGF0YSl7DQo+ID4gPiAtICAgICAgICAg
ICAgIC5kYXRhMCA9IE9QVEVFX0ZGQV9HRVRfT1NfVkVSU0lPTiwNCj4gPiA+IC0gICAgIH07DQo+
ID4gPiAtICAgICByYyA9IG1zZ19vcHMtPnN5bmNfc2VuZF9yZWNlaXZlKGZmYV9kZXYsICZkYXRh
KTsNCj4gPiA+IC0gICAgIGlmIChyYykgew0KPiA+ID4gLSAgICAgICAgICAgICBwcl9lcnIoIlVu
ZXhwZWN0ZWQgZXJyb3IgJWRcbiIsIHJjKTsNCj4gPiA+ICsgICAgIGlmICghb3B0ZWVfZmZhX2dl
dF9vc19yZXZpc2lvbihmZmFfZGV2LCBvcHMsIE5VTEwsIHRydWUpKQ0KPiA+DQo+ID4gV2h5IGRv
IHlvdSBuZWVkIHRvIGludm9rZSBvcHRlZV9mZmFfZ2V0X29zX3JldmlzaW9uKCkgaGVyZT8NCj4g
DQo+IEnigJltIGNhbGxpbmcgb3B0ZWVfZmZhX2dldF9vc19yZXZpc2lvbigpIGhlcmUgdG8gYXZv
aWQgZHVwbGljYXRpbmcgdGhlDQo+IEdFVF9PU19WRVJTSU9OIGNhbGwvcHJpbnRpbmcgbG9naWMu
IFRoZSBvcmlnaW5hbCBjb2RlIGluDQo+IG9wdGVlX2ZmYV9hcGlfaXNfY29tcGF0aWJsZSgpIGFs
cmVhZHkgZGlkIHRoZSBPUyB2ZXJzaW9uIHF1ZXJ5IGFuZA0KPiBwcmludGVkIGl0OyBhZnRlciBm
YWN0b3JpbmcgaXQgb3V0LCB0aGUgaGVscGVyIGtlZXBzIHRoYXQgYmVoYXZpb3IgaW4gb25lDQo+
IHBsYWNlLiBJZiB3ZSBkb27igJl0IGNhbGwgaXQgdGhlcmUsIHdl4oCZZCBlaXRoZXIgbG9zZSB0
aGUgZXhpc3RpbmcgZG1lc2cgbG9nDQo+IG9yIHJl4oCRaW1wbGVtZW50IHRoZSBzYW1lIE9T4oCR
dmVyc2lvbiBxdWVyeS9wcmludCBibG9jayBhZ2Fpbiwgd2hpY2ggSeKAmW0NCj4gdHJ5aW5nIHRv
IGF2b2lkLg0KPiANCj4gSWYgeW914oCZZCByYXRoZXIgYXZvaWQgdGhlIGV4dHJhIGNhbGwgYXQg
dGhpcyBzdGFnZSwgbWF5YmUgd2UgY2FuIGFsd2F5cw0KPiBwcmludCB0aGUgbG9nIGluIHRoZSBv
cHRlZV9mZmFfZ2V0X29zX3JldmlzaW9uKCkgYW5kIHJlbW92ZSB0aGUgY2FsbA0KPiBmcm9tIG9w
dGVlX2ZmYV9hcGlfaXNfY29tcGF0aWJsZSgpIGVudGlyZWx5Lg0KDQpZZWFoIG1vdmUgdGhlIHBy
aW50IHRvIG9wdGVlX2ZmYV9nZXRfb3NfcmV2aXNpb24oKSBhbmQgZHJvcCB0aGUgZXh0cmENCmNh
bGwuDQoNCi1TdW1pdA0K
