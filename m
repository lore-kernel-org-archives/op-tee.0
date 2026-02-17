Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943F3E6816F
	for <op-tee@archiver.kernel.org>; Tue, 17 Feb 2026 11:02:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D62C943882
	for <op-tee@archiver.kernel.org>; Tue, 17 Feb 2026 11:02:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8E35043868
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Feb 2026 11:01:57 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1vsIq4-0006jY-7q; Tue, 17 Feb 2026 12:01:56 +0100
Message-ID: <7546a4ff-485c-4473-999c-08fdf4e815bc@pengutronix.de>
Date: Tue, 17 Feb 2026 12:01:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH] tee: shm: Remove refcounting of kernel pages
To: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
References: <20260213113317.1728769-1-sumit.garg@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
In-Reply-To: <20260213113317.1728769-1-sumit.garg@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.pueschel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: op-tee@lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.40 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ONCE_RECEIVED(0.20)[];
	RCVD_IN_DNSWL_MED(-0.20)[185.203.201.7:from];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[2a0a:edc0:0:900:1d::77:received];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:209379, ipnet:185.203.200.0/22, country:DE];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_SPAM(0.00)[0.445]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8E35043868
X-Spamd-Bar: ---
Message-ID-Hash: 3CC7ZIBJVZ46GR6A2FKJQUBPD6ULKT5P
X-Message-ID-Hash: 3CC7ZIBJVZ46GR6A2FKJQUBPD6ULKT5P
X-MailFrom: s.pueschel@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: vbabka@suse.cz, akpm@linux-foundation.org, willy@infradead.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Marco Felsch <m.felsch@pengutronix.de>, kernel@pengutronix.de
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3CC7ZIBJVZ46GR6A2FKJQUBPD6ULKT5P/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgU3VtaXQsDQoNCk9uIDIvMTMvMjYgMTI6MzMgUE0sIFN1bWl0IEdhcmcgd3JvdGU6DQo+IEZy
b206IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNvbT4NCj4NCj4gRWFybGll
ciBURUUgc3Vic3lzdGVtIGFzc3VtZWQgdG8gcmVmY291bnQgYWxsIHRoZSBtZW1vcnkgcGFnZXMg
dG8gYmUNCj4gc2hhcmVkIHdpdGggVEVFIGltcGxlbWVudGF0aW9uIHRvIGJlIHJlZmNvdW50ZWQu
IEhvd2V2ZXIsIHRoZSBzbGFiDQo+IGFsbG9jYXRpb25zIHdpdGhpbiB0aGUga2VybmVsIGRvbid0
IGFsbG93IHJlZmNvdW50aW5nIGtlcm5lbCBwYWdlcy4NCj4NCj4gSXQgaXMgcmF0aGVyIGJldHRl
ciB0byB0cnVzdCB0aGUga2VybmVsIGNsaWVudHMgdG8gbm90IGZyZWUgcGFnZXMgd2hpbGUNCj4g
YmVpbmcgc2hhcmVkIHdpdGggVEVFIGltcGxlbWVudGF0aW9uLiBIZW5jZSwgcmVtb3ZlIHJlZmNv
dW50aW5nIG9mIGtlcm5lbA0KPiBwYWdlcyBmcm9tIHJlZ2lzdGVyX3NobV9oZWxwZXIoKSBBUEku
DQo+DQo+IEZpeGVzOiBiOWMwZTQ5YWJmY2EgKCJtbTogZGVjbGluZSB0byBtYW5pcHVsYXRlIHRo
ZSByZWZjb3VudCBvbiBhIHNsYWIgcGFnZSIpDQo+IFJlcG9ydGVkLWJ5OiBNYXJjbyBGZWxzY2gg
PG0uZmVsc2NoQHBlbmd1dHJvbml4LmRlPg0KPiBSZXBvcnRlZC1ieTogU3ZlbiBQw7xzY2hlbCA8
cy5wdWVzY2hlbEBwZW5ndXRyb25peC5kZT4NCj4gU3VnZ2VzdGVkLWJ5OiBNYXR0aGV3IFdpbGNv
eCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogU3VtaXQgR2FyZyA8c3Vt
aXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3RlZS90ZWVfc2ht
LmMgfCAyOSArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMjggZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3RlZS90ZWVfc2htLmMgYi9kcml2ZXJzL3RlZS90ZWVfc2htLmMNCj4gaW5kZXggNGE0N2Rl
NGJiMmU1Li41NGUyYmEzYWZiMjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGVlL3RlZV9zaG0u
Yw0KPiArKysgYi9kcml2ZXJzL3RlZS90ZWVfc2htLmMNCj4gQEAgLTIzLDI5ICsyMywxMSBAQCBz
dHJ1Y3QgdGVlX3NobV9kbWFfbWVtIHsNCj4gICAJc3RydWN0IHBhZ2UgKnBhZ2U7DQo+ICAgfTsN
Cj4gICANCj4gLXN0YXRpYyB2b2lkIHNobV9wdXRfa2VybmVsX3BhZ2VzKHN0cnVjdCBwYWdlICoq
cGFnZXMsIHNpemVfdCBwYWdlX2NvdW50KQ0KPiAtew0KPiAtCXNpemVfdCBuOw0KPiAtDQo+IC0J
Zm9yIChuID0gMDsgbiA8IHBhZ2VfY291bnQ7IG4rKykNCj4gLQkJcHV0X3BhZ2UocGFnZXNbbl0p
Ow0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgdm9pZCBzaG1fZ2V0X2tlcm5lbF9wYWdlcyhzdHJ1Y3Qg
cGFnZSAqKnBhZ2VzLCBzaXplX3QgcGFnZV9jb3VudCkNCj4gLXsNCj4gLQlzaXplX3QgbjsNCj4g
LQ0KPiAtCWZvciAobiA9IDA7IG4gPCBwYWdlX2NvdW50OyBuKyspDQo+IC0JCWdldF9wYWdlKHBh
Z2VzW25dKTsNCj4gLX0NCj4gLQ0KPiAgIHN0YXRpYyB2b2lkIHJlbGVhc2VfcmVnaXN0ZXJlZF9w
YWdlcyhzdHJ1Y3QgdGVlX3NobSAqc2htKQ0KPiAgIHsNCj4gICAJaWYgKHNobS0+cGFnZXMpIHsN
Cj4gICAJCWlmIChzaG0tPmZsYWdzICYgVEVFX1NITV9VU0VSX01BUFBFRCkNCj4gICAJCQl1bnBp
bl91c2VyX3BhZ2VzKHNobS0+cGFnZXMsIHNobS0+bnVtX3BhZ2VzKTsNCj4gLQkJZWxzZQ0KPiAt
CQkJc2htX3B1dF9rZXJuZWxfcGFnZXMoc2htLT5wYWdlcywgc2htLT5udW1fcGFnZXMpOw0KPiAg
IA0KPiAgIAkJa2ZyZWUoc2htLT5wYWdlcyk7DQo+ICAgCX0NCj4gQEAgLTQ3NywxMyArNDU5LDYg
QEAgcmVnaXN0ZXJfc2htX2hlbHBlcihzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwgc3RydWN0IGlv
dl9pdGVyICppdGVyLCB1MzIgZmxhZ3MsDQo+ICAgCQlnb3RvIGVycl9wdXRfc2htX3BhZ2VzOw0K
PiAgIAl9DQo+ICAgDQo+IC0JLyoNCj4gLQkgKiBpb3ZfaXRlcl9leHRyYWN0X2t2ZWNfcGFnZXMg
ZG9lcyBub3QgZ2V0IHJlZmVyZW5jZSBvbiB0aGUgcGFnZXMsDQo+IC0JICogZ2V0IGEgcmVmZXJl
bmNlIG9uIHRoZW0uDQo+IC0JICovDQo+IC0JaWYgKGlvdl9pdGVyX2lzX2t2ZWMoaXRlcikpDQo+
IC0JCXNobV9nZXRfa2VybmVsX3BhZ2VzKHNobS0+cGFnZXMsIG51bV9wYWdlcyk7DQo+IC0NCj4g
ICAJc2htLT5vZmZzZXQgPSBvZmY7DQo+ICAgCXNobS0+c2l6ZSA9IGxlbjsNCj4gICAJc2htLT5u
dW1fcGFnZXMgPSBudW1fcGFnZXM7DQo+IEBAIC00OTcsMTAgKzQ3Miw4IEBAIHJlZ2lzdGVyX3No
bV9oZWxwZXIoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgsIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwg
dTMyIGZsYWdzLA0KPiAgIA0KPiAgIAlyZXR1cm4gc2htOw0KPiAgIGVycl9wdXRfc2htX3BhZ2Vz
Og0KPiAtCWlmICghaW92X2l0ZXJfaXNfa3ZlYyhpdGVyKSkNCj4gKwlpZiAoaXRlcl9pc191dmVj
KGl0ZXIpKQ0KDQpJJ3ZlIHJlcGxhY2VkIChkdWUgdG8gY29tcGlsZSBmYWlsdXJlcyBub3RlZCBi
eSB0aGUga2VybmVsIHRlc3Qgcm9ib3QpIA0KdGhpcyB3aXRoIHRoZSBjb21waWxlciBzdWdnZXN0
ZWQgaXRlcl9pc19pb3ZlYyAuIEkgaGF2ZW4ndCBjaGVja2VkLCBpZiANCnRoaXMgaXMgdGhlIGNv
cnJlY3QgZml4Lg0KDQpXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCAob24gdGhlIHVwc3RyZWFtIGNv
bW1pdCA5NzAyOTY5OTc4NjkpLCBteSANCnJlcG9ydGVkIHN0YWNrdHJhY2Uvd2FybmluZyBkb2Vz
bid0IG9jY3VyIGFueW1vcmUuIEkgZGlkbid0IGRvIGFueSANCmV4dGVuc2l2ZSB0ZXN0aW5nLCBi
dXQgY3JlYXRpbmcgYW5kIHVzaW5nIGEgdHJ1c3RlZCBrZXkgd2l0aCBrZXljdGwgDQp3b3JrZWQg
ZmluZSBpbiBteSBzaG9ydCB0ZXN0Lg0KDQpTaW5jZXJlbHkNCiDCoCDCoCBTdmVuDQoNCj4gICAJ
CXVucGluX3VzZXJfcGFnZXMoc2htLT5wYWdlcywgc2htLT5udW1fcGFnZXMpOw0KPiAtCWVsc2UN
Cj4gLQkJc2htX3B1dF9rZXJuZWxfcGFnZXMoc2htLT5wYWdlcywgc2htLT5udW1fcGFnZXMpOw0K
PiAgIGVycl9mcmVlX3NobV9wYWdlczoNCj4gICAJa2ZyZWUoc2htLT5wYWdlcyk7DQo+ICAgZXJy
X2ZyZWVfc2htOg0K
