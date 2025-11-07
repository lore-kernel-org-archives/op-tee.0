Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA37CCF9E3
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 06:59:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9D9524FF88
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 06:59:56 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 38BE241BB2
	for <op-tee@lists.trustedfirmware.org>; Fri,  7 Nov 2025 06:14:36 +0000 (UTC)
X-UUID: 04a739dabba111f0a38c85956e01ac42-20251107
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:717e5da2-3c3b-4bab-b8af-984e191e9646,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:a46f60b23166b366801f7e82fd989115,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 04a739dabba111f0a38c85956e01ac42-20251107
X-User: yangzhao@kylinos.cn
Received: from [10.42.8.181] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yangzhao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1200331251; Fri, 07 Nov 2025 14:14:29 +0800
Message-ID: <900f69d4-6ef9-fe1e-d664-e248e41da752@kylinos.cn>
Date: Fri, 7 Nov 2025 14:14:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tee: fix illegal pointer dereference in tee_shm_put()
Content-Language: en-US
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <20251106102008.1310234-1-yangzhao@kylinos.cn>
 <CAHUa44FAUyQNBKmzugu-_gv_Jy_AftZqq=RSbKUnK1QQbL8Z9A@mail.gmail.com>
From: yangzhao <yangzhao@kylinos.cn>
In-Reply-To: <CAHUa44FAUyQNBKmzugu-_gv_Jy_AftZqq=RSbKUnK1QQbL8Z9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 38BE241BB2
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	R_SPF_ALLOW(-0.20)[+ip4:124.126.103.232];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:4847, ipnet:124.126.0.0/16, country:CN];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_SPAM(0.00)[0.722];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: yangzhao@kylinos.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: I4BVXAHFMPIKWQX7L56BESTK76ECJSAS
X-Message-ID-Hash: I4BVXAHFMPIKWQX7L56BESTK76ECJSAS
X-Mailman-Approved-At: Mon, 10 Nov 2025 06:59:47 +0000
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I4BVXAHFMPIKWQX7L56BESTK76ECJSAS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGnvvIwNCg0KVGhpcyBpc3N1ZSBpcyBpbmRlZWQgY2F1c2VkIGJ5IHRoZSBtaXNtYXRjaCBiZXR3
ZWVuIHRoZSBURUUgdmVyc2lvbiBhbmQgDQp0aGUga2VybmVsIHZlcnNpb24uIEN1cnJlbnRseSwg
dGhpcyBwYXRjaCBpcyBvbmx5IGRlc2lnbmVkIHRvIGFkZHJlc3MgDQp0aGUgcHJvYmxlbSBvZiBl
bnN1cmluZyB0aGF0IHRoZSBrZXJuZWwgZG9lcyBub3QgcGFuaWMgd2hlbiB0aGUgVEVFIA0KdmVy
c2lvbiBpcyBpbmNvcnJlY3QuDQoNClRoZSB2aXJ0X2FkZHJfdmFsaWQoKSBpcyB1c2VkIHRvIGNo
ZWNrIHRoZSB2YWxpZGl0eSBvZiB0aGUgcG9pbnRlciANCmFkZHJlc3MsIGJlY2F1c2UgZHVyaW5n
IHRoZSB0ZXN0LCBpdCBkaWQgb2NjdXIgdGhhdCB0aGUgc2htLT5jdHggcG9pbnRlciANCmFkZHJl
c3MgaXMgdGhlIGFkZHJlc3MgYmV0d2VlbiB0aGUgdXNlciBzcGFjZSBhbmQgdGhlIGtlcm5lbCBz
cGFjZS4gQXQgDQp0aGlzIHBvaW50LCB1c2luZyBJU19FUlJfT1JfTlVMTCBjYW5ub3QgZGV0ZWN0
IHRoZSBsZWdpdGltYWN5IG9mIHRoZSANCnBvaW50ZXIgYWRkcmVzcy4NCg0KVGhlIHByb2JsZW0g
Y2FuIGJlIHZpZXdlZCBhdCB0aGUgbGluazogDQpodHRwczovL2dpdGh1Yi5jb20vT1AtVEVFL29w
dGVlX29zL2lzc3Vlcy83NTc1DQoNClRoYW5rcy4NCg0KT24gMjAyNS8xMS82IDE5OjMxLCBKZW5z
IFdpa2xhbmRlciB3cm90ZToNCj4gSGksDQo+DQo+IE9uIFRodSwgTm92IDYsIDIwMjUgYXQgMTE6
MjDigK9BTSB5YW5nemhhbyA8eWFuZ3poYW9Aa3lsaW5vcy5jbj4gd3JvdGU6DQo+PiBJbiB0ZWVf
c2htX3B1dCgpLCB0aGVyZSBpcyBub3Qgb25seSB0aGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
LA0KPj4gYnV0IGFsc28gdGhlIGlsbGVnYWwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4+DQo+PiBz
aHV0ZG93bigpIC0tLT4NCj4+ICAgICAgX19vcHRlZV9kaXNhYmxlX3NobV9jYWNoZSAtLT4NCj4+
ICAgICAgICAgIHNobSA9IHJlZ19wYWlyX3RvX3B0ciguLi4pOw0KPj4gICAgICAgICAgdGVlX3No
bV9mcmVlKHNobSk7IC0tPg0KPj4gICAgICAgICAgICAgIHRlZV9zaG1fcHV0KHNobSk7IC8vY3Jh
c2g6IHNobS0+Y3R4IG1heWJlIE5VTEwgcG9pbnRlciBvciBpbGxlZ2FsIHBvaW50ZXINCj4+DQo+
PiBDaGVjayB3aGV0aGVyIHRoZSBwb2ludGVyIGlzIE5VTEwgYW5kIHdoZXRoZXIgdGhlIHBvaW50
ZXIgYWRkcmVzcyBpcyB2YWxpZC4NCj4+DQo+PiBUaGlzIGlzc3VlIG9jY3VycyB3aGVuIHJpY2gg
d29ybGQgdXNlcyB0aGUgNi54IHZlcnNpb24gb2YgdGhlIGtlcm5lbCBhbmQNCj4+IG9wdGVlIHNl
Y3VyZSB3b3JsZCB1c2VzIGEgbG93ZXIgdmVyc2lvbiAoc3VjaCBhcyB2ZXJzaW9uIDMuMiksIGFu
ZCBpdCBpcw0KPj4gaGlnaGx5IGxpa2VseSB0byB0cmlnZ2VyIGEga2VybmVsIHBhbmljIHdoZW4g
Y29uZHVjdGluZyBoaWJlcm5hdGUgdGVzdHMuDQo+IEl0IHNvdW5kcyBsaWtlIHRoZSByb290IG9m
IHRoZSBwcm9ibGVtIGlzIGluIHRoZSBURUUgcmF0aGVyIHRoYW4gaW4NCj4gdGhlIGtlcm5lbC4g
SG93IGFib3V0IGZpeGluZyB0aGUgVEVFIHRvIGF2b2lkIHN1cHBseWluZyBnYXJiYWdlDQo+IHBv
aW50ZXJzPw0KPg0KPj4gRml4ZXM6IGU0YTcxOGEzYTQ3ZSAoInRlZTogZml4IE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSBpbiB0ZWVfc2htX3B1dCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiB5YW5nemhh
byA8eWFuZ3poYW9Aa3lsaW5vcy5jbj4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3RlZS90ZWVfc2ht
LmMgfCA5ICsrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL3RlZV9zaG0uYyBi
L2RyaXZlcnMvdGVlL3RlZV9zaG0uYw0KPj4gaW5kZXggNGE0N2RlNGJiMmU1Li5kZTAxZDE2NDA5
YzEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3RlZS90ZWVfc2htLmMNCj4+ICsrKyBiL2RyaXZl
cnMvdGVlL3RlZV9zaG0uYw0KPj4gQEAgLTcyMiw3ICs3MjIsMTQgQEAgdm9pZCB0ZWVfc2htX3B1
dChzdHJ1Y3QgdGVlX3NobSAqc2htKQ0KPj4gICAgICAgICAgc3RydWN0IHRlZV9kZXZpY2UgKnRl
ZWRldjsNCj4+ICAgICAgICAgIGJvb2wgZG9fcmVsZWFzZSA9IGZhbHNlOw0KPj4NCj4+IC0gICAg
ICAgaWYgKCFzaG0gfHwgIXNobS0+Y3R4IHx8ICFzaG0tPmN0eC0+dGVlZGV2KQ0KPj4gKyAgICAg
ICAvKiBjaGVja2luZyBwb2ludGVyICovDQo+PiArICAgICAgIGlmIChJU19FUlJfT1JfTlVMTChz
aG0pIHx8ICF2aXJ0X2FkZHJfdmFsaWQoc2htKSkNCj4gVGhlIElTX0VSUl9PUl9OVUxMKCkgY2hl
Y2sgbWlnaHQgbWFrZSBzZW5zZSwgYnV0IHRoZSB2aXJ0X2FkZHJfdmFsaWQoKQ0KPiBkb2VzIG5v
dC4gdmlydF9hZGRyX3ZhbGlkKCkgbWlnaHQgY2F0Y2ggYSBmZXcgZ2FyYmFnZSBwb2ludGVycywg
YnV0DQo+IHRoZSByZWFsIHByb2JsZW0gaXMgdGhhdCBzb21lb25lIGlzIHN1cHBseWluZyBnYXJi
YWdlIHBvaW50ZXJzLg0KPg0KPj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4+ICsNCj4+ICsg
ICAgICAgaWYgKElTX0VSUl9PUl9OVUxMKHNobS0+Y3R4KSB8fCAhdmlydF9hZGRyX3ZhbGlkKHNo
bS0+Y3R4KSkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiArDQo+PiArICAgICAgIGlm
IChJU19FUlJfT1JfTlVMTChzaG0tPmN0eC0+dGVlZGV2KSB8fCAhdmlydF9hZGRyX3ZhbGlkKHNo
bS0+Y3R4LT50ZWVkZXYpKQ0KPj4gICAgICAgICAgICAgICAgICByZXR1cm47DQo+IHNobS0+Y3R4
IG9yIHNobS0+Y3R4LT50ZWVkZXYgc2hvdWxkIG5ldmVyIGJlIGFuIEVSUiBwb2ludGVyLiBUaGUN
Cj4gdmlydF9hZGRyX3ZhbGlkKCkgdGVzdCBkb2Vzbid0IG1ha2Ugc2Vuc2UuDQo+DQo+IENoZWVy
cywNCj4gSmVucw0KPg0KPj4gICAgICAgICAgdGVlZGV2ID0gc2htLT5jdHgtPnRlZWRldjsNCj4+
IC0tDQo+PiAyLjI1LjENCj4+DQo=
