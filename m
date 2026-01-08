Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E6AD14897
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 03:02:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3156C4FF9C
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 03:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767841320;
	bh=Z+XcflATdHf7Lv+0lkQCtp7hl4qa9ORKiw0ydlIeufI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BxV5SGVPT/944GSIlKgEBdBTvxzTAfzT474KA8ixEwoEgnQ2TtTtcRdQLefK1CRiJ
	 zBX+KbPA/+v1AJj/xB6IqO24+88im7tEu1B2nlxjEAn/lVzKn1hFcbxkhNpnJhB0pY
	 BvWDcWz2RLa4HbWD4F4XaSHTwPnDOQKVAq2Vacen636ZfsXzrDvIj0RkECSFan+/m4
	 BGwceF19TYoyPLa4T4rZDoHwNvLPqmtaODYpBSssw9+Qa25CDqvIsQAfnXRfiYmsDE
	 mGEnJrdGUaRjYsvFNcm47Dzwfe4fiyNJvrs/Eqd/cAaoMNlcIMXZbIBdUH390HZfWy
	 A2QzFKRAQ8Xyg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EBE2C41A43
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Jan 2026 03:01:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cLqCrsBS;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 58BBF6000A;
	Thu,  8 Jan 2026 03:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EE4C4CEF1;
	Thu,  8 Jan 2026 03:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767841302;
	bh=h6fiBmn3kgiXJASgqnUpEHC6/S3AHMHkcpmkj0+Ht5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cLqCrsBSuhIBNhnxJHC2AQXc84sLS0NPuvTXVj9eDsvWdBPr95Qj4wTohB7ETwjiD
	 WuZ+3ikfAgzu9p0pgOWE1v3YEpMfIERKSsDEgoj0spb8+qHbANUUoTg5/PBSjJ4b3E
	 AUx2AtJF0N7Us2mqZom+pNGX3CtCVUTGlYwwtLLg2s5Vi42UMfesc2srdXtwQiw2pP
	 VEZKY0k9gha3xyeMsE98X8CVG1H5EsIW6SIX3tRNc3KJchUGIoG7d/tAHIG7z9Q9oG
	 exvoljrTtdWpsrUhKDx71ks5TnnzEzFf3XY8C3emkvFJsLWtl1UTg/BYMHUBUTX5B1
	 gD739gR9bxkKw==
Message-ID: <b429613e-f543-41f4-bb7f-bbd22de7f0f0@kernel.org>
Date: Wed, 7 Jan 2026 21:01:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] tee: add revision sysfs attribute
To: Aristo Chen <jj251510319013@gmail.com>
References: <20251230051804.6230-1-aristo.chen@canonical.com>
 <20260107152607.902735-1-aristo.chen@canonical.com>
 <2f4b30fd-8e0a-4482-9bab-a90e32e69839@kernel.org>
 <CAJwFiGLJVOsu_=H-y82pVE92ZDpVZyqjB=We9ioLqjBsQx8Y5g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJwFiGLJVOsu_=H-y82pVE92ZDpVZyqjB=We9ioLqjBsQx8Y5g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EBE2C41A43
X-Spamd-Bar: --
Message-ID-Hash: S4PTT6SNKKV2B46CSRFFTSWO5R6ZJPWL
X-Message-ID-Hash: S4PTT6SNKKV2B46CSRFFTSWO5R6ZJPWL
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/S4PTT6SNKKV2B46CSRFFTSWO5R6ZJPWL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: "Mario Limonciello (AMD) (kernel.org) via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>

DQoNCk9uIDEvNy8yMDI2IDg6NTUgUE0sIEFyaXN0byBDaGVuIHdyb3RlOg0KPiBIaSBNYXJpbywN
Cj4gDQo+IE1hcmlvIExpbW9uY2llbGxvIDxzdXBlcm0xQGtlcm5lbC5vcmc+IOaWvCAyMDI25bm0
MeaciDfml6XpgLHkuIkg5LiL5Y2IMTE6Mjjlr6vpgZPvvJoNCj4+DQo+PiBPbiAxLzcvMjYgOToy
NiBBTSwgQXJpc3RvIENoZW4gd3JvdGU6DQo+Pj4gQWRkIGEgZ2VuZXJpYyBURUUgcmV2aXNpb24g
c3lzZnMgYXR0cmlidXRlIGJhY2tlZCBieSBhIG5ldw0KPj4+IG9wdGlvbmFsIGdldF90ZWVfcmV2
aXNpb24oKSBjYWxsYmFjay4gVGhlIHJldmlzaW9uIHN0cmluZyBpcw0KPj4+IGRpYWdub3N0aWMt
b25seSBhbmQgbXVzdCBub3QgYmUgdXNlZCB0byBpbmZlciBmZWF0dXJlIHN1cHBvcnQuDQo+Pj4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBcmlzdG8gQ2hlbiA8YXJpc3RvLmNoZW5AY2Fub25pY2FsLmNv
bT4NCj4+PiAtLS0NCj4+PiAgICBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWNsYXNz
LXRlZSB8IDEwICsrKysrDQo+Pj4gICAgZHJpdmVycy90ZWUvdGVlX2NvcmUuYyAgICAgICAgICAg
ICAgICAgICAgfCA1MSArKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+ICAgIGluY2x1ZGUvbGlu
dXgvdGVlX2NvcmUuaCAgICAgICAgICAgICAgICAgIHwgIDkgKysrKw0KPj4+ICAgIDMgZmlsZXMg
Y2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtY2xhc3MtdGVlIGIvRG9jdW1l
bnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1jbGFzcy10ZWUNCj4+PiBpbmRleCBjOTE0NGQxNjAw
M2UuLjZlNzgzMjEwMTA0ZSAxMDA2NDQNCj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0
aW5nL3N5c2ZzLWNsYXNzLXRlZQ0KPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcv
c3lzZnMtY2xhc3MtdGVlDQo+Pj4gQEAgLTEzLDMgKzEzLDEzIEBAIERlc2NyaXB0aW9uOg0KPj4+
ICAgICAgICAgICAgICAgIHNwYWNlIGlmIHRoZSB2YXJpYWJsZSBpcyBhYnNlbnQuIFRoZSBwcmlt
YXJ5IHB1cnBvc2UNCj4+PiAgICAgICAgICAgICAgICBvZiB0aGlzIHZhcmlhYmxlIGlzIHRvIGxl
dCBzeXN0ZW1kIGtub3cgd2hldGhlcg0KPj4+ICAgICAgICAgICAgICAgIHRlZS1zdXBwbGljYW50
IGlzIG5lZWRlZCBpbiB0aGUgZWFybHkgYm9vdCB3aXRoIGluaXRyYW1mcy4NCj4+PiArDQo+Pj4g
K1doYXQ6ICAgICAgICAgICAgICAgIC9zeXMvY2xhc3MvdGVlL3RlZXsscHJpdn1YL3JldmlzaW9u
DQo+Pj4gK0RhdGU6ICAgICAgICAgICAgICAgIERlYyAyMDI1DQo+Pj4gK0tlcm5lbFZlcnNpb246
ICAgICAgIDYuMTgNCj4+DQo+PiBUaGlzIG5lZWRzIHRvIGJlIGJ1bXBlZCB1cCBhbmQgZGF0ZXMg
cHVzaGVkIG91dC4NCj4gDQo+IEkgd2lsbCBmaXggdGhpcyBpbiB0aGUgdjYgcGF0Y2gsIHRoYW5r
cyENCj4gDQo+Pg0KPj4+ICtDb250YWN0OiAgICAgb3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2Fy
ZS5vcmcNCj4+PiArRGVzY3JpcHRpb246DQo+Pj4gKyAgICAgICAgICAgICBSZWFkLW9ubHkgcmV2
aXNpb24gc3RyaW5nIHJlcG9ydGVkIGJ5IHRoZSBURUUgZHJpdmVyLiBUaGlzIGlzDQo+Pj4gKyAg
ICAgICAgICAgICBmb3IgZGlhZ25vc3RpY3Mgb25seSBhbmQgbXVzdCBub3QgYmUgdXNlZCB0byBp
bmZlciBmZWF0dXJlDQo+Pj4gKyAgICAgICAgICAgICBzdXBwb3J0LiBVc2UgVEVFX0lPQ19WRVJT
SU9OIGZvciBjYXBhYmlsaXR5IGFuZCBjb21wYXRpYmlsaXR5DQo+Pj4gKyAgICAgICAgICAgICBj
aGVja3MuDQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMgYi9kcml2ZXJz
L3RlZS90ZWVfY29yZS5jDQo+Pj4gaW5kZXggZDY1ZDQ3Y2MxNTRlLi4wYTAwNDk5ODExYzEgMTAw
NjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy90ZWUvdGVlX2NvcmUuYw0KPj4+ICsrKyBiL2RyaXZlcnMv
dGVlL3RlZV9jb3JlLmMNCj4+PiBAQCAtMTE0Niw3ICsxMTQ2LDU2IEBAIHN0YXRpYyBzdHJ1Y3Qg
YXR0cmlidXRlICp0ZWVfZGV2X2F0dHJzW10gPSB7DQo+Pj4gICAgICAgIE5VTEwNCj4+PiAgICB9
Ow0KPj4+DQo+Pj4gLUFUVFJJQlVURV9HUk9VUFModGVlX2Rldik7DQo+Pj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHRlZV9kZXZfZ3JvdXAgPSB7DQo+Pj4gKyAgICAgLmF0
dHJzID0gdGVlX2Rldl9hdHRycywNCj4+PiArfTsNCj4+PiArDQo+Pj4gK3N0YXRpYyBzc2l6ZV90
IHJldmlzaW9uX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQo+Pj4g
K3sNCj4+PiArICAgICBzdHJ1Y3QgdGVlX2RldmljZSAqdGVlZGV2ID0gY29udGFpbmVyX29mKGRl
diwgc3RydWN0IHRlZV9kZXZpY2UsIGRldik7DQo+Pj4gKyAgICAgY2hhciB2ZXJzaW9uW1RFRV9S
RVZJU0lPTl9TVFJfU0laRV07DQo+Pj4gKyAgICAgaW50IHJldDsNCj4+PiArDQo+Pj4gKyAgICAg
aWYgKCF0ZWVkZXYtPmRlc2MtPm9wcy0+Z2V0X3RlZV9yZXZpc2lvbikNCj4+PiArICAgICAgICAg
ICAgIHJldHVybiAtRU5PREVWOw0KPj4+ICsNCj4+PiArICAgICByZXQgPSB0ZWVkZXYtPmRlc2Mt
Pm9wcy0+Z2V0X3RlZV9yZXZpc2lvbih0ZWVkZXYsIHZlcnNpb24sDQo+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHZlcnNpb24pKTsNCj4+
PiArICAgICBpZiAocmV0KQ0KPj4+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+PiArDQo+
Pj4gKyAgICAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXNcbiIsIHZlcnNpb24pOw0KPj4+ICt9
DQo+Pj4gK3N0YXRpYyBERVZJQ0VfQVRUUl9STyhyZXZpc2lvbik7DQo+Pj4gKw0KPj4+ICtzdGF0
aWMgc3RydWN0IGF0dHJpYnV0ZSAqdGVlX3JldmlzaW9uX2F0dHJzW10gPSB7DQo+Pj4gKyAgICAg
JmRldl9hdHRyX3JldmlzaW9uLmF0dHIsDQo+Pj4gKyAgICAgTlVMTA0KPj4+ICt9Ow0KPj4+ICsN
Cj4+PiArc3RhdGljIHVtb2RlX3QgdGVlX3JldmlzaW9uX2F0dHJfaXNfdmlzaWJsZShzdHJ1Y3Qg
a29iamVjdCAqa29iaiwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYXR0cmlidXRlICphdHRyLCBpbnQgbikNCj4+PiArew0KPj4+ICsgICAgIHN0
cnVjdCBkZXZpY2UgKmRldiA9IGtvYmpfdG9fZGV2KGtvYmopOw0KPj4+ICsgICAgIHN0cnVjdCB0
ZWVfZGV2aWNlICp0ZWVkZXYgPSBjb250YWluZXJfb2YoZGV2LCBzdHJ1Y3QgdGVlX2RldmljZSwg
ZGV2KTsNCj4+PiArDQo+Pj4gKyAgICAgaWYgKHRlZWRldi0+ZGVzYy0+b3BzLT5nZXRfdGVlX3Jl
dmlzaW9uKQ0KPj4+ICsgICAgICAgICAgICAgcmV0dXJuIGF0dHItPm1vZGU7DQo+Pj4gKw0KPj4+
ICsgICAgIHJldHVybiAwOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IGF0dHJpYnV0ZV9ncm91cCB0ZWVfcmV2aXNpb25fZ3JvdXAgPSB7DQo+Pj4gKyAgICAgLmF0dHJz
ID0gdGVlX3JldmlzaW9uX2F0dHJzLA0KPj4+ICsgICAgIC5pc192aXNpYmxlID0gdGVlX3Jldmlz
aW9uX2F0dHJfaXNfdmlzaWJsZSwNCj4+PiArfTsNCj4+PiArDQo+Pj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgYXR0cmlidXRlX2dyb3VwICp0ZWVfZGV2X2dyb3Vwc1tdID0gew0KPj4+ICsgICAgICZ0
ZWVfZGV2X2dyb3VwLA0KPj4+ICsgICAgICZ0ZWVfcmV2aXNpb25fZ3JvdXAsDQo+Pj4gKyAgICAg
TlVMTA0KPj4+ICt9Ow0KPj4+DQo+Pj4gICAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGFzcyB0ZWVf
Y2xhc3MgPSB7DQo+Pj4gICAgICAgIC5uYW1lID0gInRlZSIsDQo+Pj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvdGVlX2NvcmUuaCBiL2luY2x1ZGUvbGludXgvdGVlX2NvcmUuaA0KPj4+IGlu
ZGV4IDFmM2U1ZGFkNmQwZC4uZWU1ZjBiZDQxZjQzIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUv
bGludXgvdGVlX2NvcmUuaA0KPj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdGVlX2NvcmUuaA0KPj4+
IEBAIC03Niw2ICs3Niw5IEBAIHN0cnVjdCB0ZWVfZGV2aWNlIHsNCj4+PiAgICAvKioNCj4+PiAg
ICAgKiBzdHJ1Y3QgdGVlX2RyaXZlcl9vcHMgLSBkcml2ZXIgb3BlcmF0aW9ucyB2dGFibGUNCj4+
PiAgICAgKiBAZ2V0X3ZlcnNpb246ICAgIHJldHVybnMgdmVyc2lvbiBvZiBkcml2ZXINCj4+PiAr
ICogQGdldF90ZWVfcmV2aXNpb246ICAgICAgICByZXR1cm5zIHJldmlzaW9uIHN0cmluZyAoZGlh
Z25vc3RpYyBvbmx5KTsNCj4+DQo+PiBXaHkgaXMgdGhpcyBjb21tZW50IGhlcmUgYWJvdXQgaXQg
YmVpbmcgZm9yIGRpYWdub3N0aWNzIG9ubHk/ICBJIGZlZWwNCj4+IGl0J3MgdXAgdG8gdGhlIGlt
cGxlbWVudGF0aW9uIGhvdyBpdCB3b3VsZCBiZSB1c2VkLg0KPiANCj4gQWNjb3JkaW5nIHRvIHRo
ZSBwcmV2aW91cyBkaXNjdXNzaW9uLCB3ZSB3b3VsZCBsaWtlIHRvIHByZXZlbnQgdXNlcg0KPiB0
aGlua2luZyBhYm91dCBvcHRlZSBvcyB2ZXJzaW9uIHgueSBtZWFucyB6IGZlYXR1cmUsIGFuZCB3
ZSBzaG91bGQNCj4gYWx3YXlzIHVzZSBURUVfSU9DX1ZFUlNJT04gZm9yIGNhcGFiaWxpdHkgYW5k
IGNvbXBhdGliaWxpdHkNCj4gY2hlY2suDQo+IA0KPiBJcyB0aGVyZSBhbnkgb3RoZXIgc3BlY2lm
aWMgdXNlIGNhc2UgdGhhdCBtYWtlcyB5b3UgdGhpbmsgcmVtb3ZpbmcNCj4gdGhlIHdvcmRpbmcg
aXMgcmVxdWlyZWQ/DQoNCkFoIEkgZGlkbid0IHJlYWxpemUgdGhlcmUgd2FzIHByZXZpb3VzIGRp
c2N1c3Npb24gdGhhdCBsZWFkIHRvIHRoaXMsIEkgDQpzYXcgc29tZSBlYXJsaWVyIHZlcnNpb25z
IGluIG15IGhvbGlkYXkgbWFpbGJveCBnbHV0IGJ1dCBpZ25vcmVkIHRoZW0gDQp3aGVuIEkgc2F3
IHRoZSBuZXcgb25lLg0KDQpMZWF2ZSBpdCBhcyBpcyB0aGVuLg0KDQo+IA0KPj4NCj4+PiArICog
ICAgICAgICAgICAgICAgICAgZG8gbm90IGluZmVyIGZlYXR1cmUgc3VwcG9ydCBmcm9tIHRoaXMs
IHVzZQ0KPj4+ICsgKiAgICAgICAgICAgICAgICAgICBURUVfSU9DX1ZFUlNJT04gaW5zdGVhZA0K
Pj4+ICAgICAqIEBvcGVuOiAgICAgICAgICAgY2FsbGVkIGZvciBhIGNvbnRleHQgd2hlbiB0aGUg
ZGV2aWNlIGZpbGUgaXMgb3BlbmVkDQo+Pj4gICAgICogQGNsb3NlX2NvbnRleHQ6ICBjYWxsZWQg
d2hlbiB0aGUgZGV2aWNlIGZpbGUgaXMgY2xvc2VkDQo+Pj4gICAgICogQHJlbGVhc2U6ICAgICAg
ICAgICAgICAgIGNhbGxlZCB0byByZWxlYXNlIHRoZSBjb250ZXh0DQo+Pj4gQEAgLTk1LDkgKzk4
LDEyIEBAIHN0cnVjdCB0ZWVfZGV2aWNlIHsNCj4+PiAgICAgKiBjbGllbnQgY2xvc2VzIHRoZSBk
ZXZpY2UgZmlsZSwgZXZlbiBpZiB0aGVyZSBhcmUgZXhpc3RpbmcgcmVmZXJlbmNlcyB0byB0aGUN
Cj4+PiAgICAgKiBjb250ZXh0LiBUaGUgVEVFIGRyaXZlciBjYW4gdXNlIEBjbG9zZV9jb250ZXh0
IHRvIHN0YXJ0IGNsZWFuaW5nIHVwLg0KPj4+ICAgICAqLw0KPj4+ICsNCj4+PiAgICBzdHJ1Y3Qg
dGVlX2RyaXZlcl9vcHMgew0KPj4+ICAgICAgICB2b2lkICgqZ2V0X3ZlcnNpb24pKHN0cnVjdCB0
ZWVfZGV2aWNlICp0ZWVkZXYsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHRlZV9pb2N0bF92ZXJzaW9uX2RhdGEgKnZlcnMpOw0KPj4+ICsgICAgIGludCAoKmdldF90ZWVf
cmV2aXNpb24pKHN0cnVjdCB0ZWVfZGV2aWNlICp0ZWVkZXYsDQo+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY2hhciAqYnVmLCBzaXplX3QgbGVuKTsNCj4+PiAgICAgICAgaW50ICgq
b3Blbikoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgpOw0KPj4+ICAgICAgICB2b2lkICgqY2xvc2Vf
Y29udGV4dCkoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgpOw0KPj4+ICAgICAgICB2b2lkICgqcmVs
ZWFzZSkoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgpOw0KPj4+IEBAIC0xMjMsNiArMTI5LDkgQEAg
c3RydWN0IHRlZV9kcml2ZXJfb3BzIHsNCj4+PiAgICAgICAgaW50ICgqc2htX3VucmVnaXN0ZXIp
KHN0cnVjdCB0ZWVfY29udGV4dCAqY3R4LCBzdHJ1Y3QgdGVlX3NobSAqc2htKTsNCj4+PiAgICB9
Ow0KPj4+DQo+Pj4gKy8qIFNpemUgZm9yIFRFRSByZXZpc2lvbiBzdHJpbmcgYnVmZmVyIHVzZWQg
YnkgZ2V0X3RlZV9yZXZpc2lvbigpLiAqLw0KPj4+ICsjZGVmaW5lIFRFRV9SRVZJU0lPTl9TVFJf
U0laRSAgICAgICAgMTI4DQo+Pj4gKw0KPj4+ICAgIC8qKg0KPj4+ICAgICAqIHN0cnVjdCB0ZWVf
ZGVzYyAtIERlc2NyaWJlcyB0aGUgVEVFIGRyaXZlciB0byB0aGUgc3Vic3lzdGVtDQo+Pj4gICAg
ICogQG5hbWU6ICAgbmFtZSBvZiBkcml2ZXINCj4+DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEFy
aXN0bw0KDQo=
