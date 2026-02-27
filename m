Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D00FEFB5A
	for <op-tee@archiver.kernel.org>; Fri, 27 Feb 2026 15:16:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5174743860
	for <op-tee@archiver.kernel.org>; Fri, 27 Feb 2026 15:16:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0C0B741B6F
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Feb 2026 15:15:48 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1vvzZC-0007is-Qz; Fri, 27 Feb 2026 16:15:46 +0100
Message-ID: <c8bd88c3-a878-40f6-840f-9d779a585ad8@pengutronix.de>
Date: Fri, 27 Feb 2026 16:15:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2] tee: shm: Remove refcounting of kernel pages
To: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
References: <20260220084959.1966771-1-sumit.garg@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
In-Reply-To: <20260220084959.1966771-1-sumit.garg@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.pueschel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: op-tee@lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	R_SPF_ALLOW(-0.20)[+mx];
	ONCE_RECEIVED(0.20)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[2a0a:edc0:0:900:1d::77:received];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:209379, ipnet:185.203.200.0/22, country:DE];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.916];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[185.203.201.7:from];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0C0B741B6F
X-Spamd-Bar: ---
Message-ID-Hash: GCCWID7IOCL7WXEFJZN4LLC3FCXBIZ3C
X-Message-ID-Hash: GCCWID7IOCL7WXEFJZN4LLC3FCXBIZ3C
X-MailFrom: s.pueschel@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: vbabka@suse.cz, akpm@linux-foundation.org, willy@infradead.org, m.felsch@pengutronix.de, Sumit Garg <sumit.garg@oss.qualcomm.com>, kernel@pengutronix.de
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GCCWID7IOCL7WXEFJZN4LLC3FCXBIZ3C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

T24gMi8yMC8yNiA5OjQ5IEFNLCBTdW1pdCBHYXJnIHdyb3RlOg0KDQo+IEZyb206IE1hdHRoZXcg
V2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPg0KPiBFYXJsaWVyIFRFRSBzdWJzeXN0ZW0g
YXNzdW1lZCB0byByZWZjb3VudCBhbGwgdGhlIG1lbW9yeSBwYWdlcyB0byBiZQ0KPiBzaGFyZWQg
d2l0aCBURUUgaW1wbGVtZW50YXRpb24gdG8gYmUgcmVmY291bnRlZC4gSG93ZXZlciwgdGhlIHNs
YWINCj4gYWxsb2NhdGlvbnMgd2l0aGluIHRoZSBrZXJuZWwgZG9uJ3QgYWxsb3cgcmVmY291bnRp
bmcga2VybmVsIHBhZ2VzLg0KPg0KPiBJdCBpcyByYXRoZXIgYmV0dGVyIHRvIHRydXN0IHRoZSBr
ZXJuZWwgY2xpZW50cyB0byBub3QgZnJlZSBwYWdlcyB3aGlsZQ0KPiBiZWluZyBzaGFyZWQgd2l0
aCBURUUgaW1wbGVtZW50YXRpb24uIEhlbmNlLCByZW1vdmUgcmVmY291bnRpbmcgb2Yga2VybmVs
DQo+IHBhZ2VzIGZyb20gcmVnaXN0ZXJfc2htX2hlbHBlcigpIEFQSS4NCj4NCj4gRml4ZXM6IGI5
YzBlNDlhYmZjYSAoIm1tOiBkZWNsaW5lIHRvIG1hbmlwdWxhdGUgdGhlIHJlZmNvdW50IG9uIGEg
c2xhYiBwYWdlIikNCj4gUmVwb3J0ZWQtYnk6IE1hcmNvIEZlbHNjaCA8bS5mZWxzY2hAcGVuZ3V0
cm9uaXguZGU+DQo+IFJlcG9ydGVkLWJ5OiBTdmVuIFDDvHNjaGVsIDxzLnB1ZXNjaGVsQHBlbmd1
dHJvbml4LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFk
ZWFkLm9yZz4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5x
dWFsY29tbS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3Nz
LnF1YWxjb21tLmNvbT4NCg0KVGVzdGVkLWJ5OiBTdmVuIFDDvHNjaGVsIDxzLnB1ZXNjaGVsQHBl
bmd1dHJvbml4LmRlPg0KDQp0ZXN0ZWQgd2l0aCBhMzBiMzYxNDNhNDEgKCJMaW51eCA2LjE5LjQi
KSBhbmQgcmVtb3ZlZCBteSByZXBvcnRlZCANCndhcm5pbmcgc3RhY2t0cmFjZS4NCg0KU2luY2Vy
ZWx5DQogwqAgwqAgU3Zlbg0KDQo+IC0tLQ0KPg0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEF0dHJp
YnV0ZSBNYXR0aGV3IGFzIHRoZSBhdXRob3Igb2YgdGhpcyBwYXRjaC4NCj4gLSBGaXggY2hlY2sg
Zm9yIHVzZXIgcGFnZXMuDQo+DQo+ICAgZHJpdmVycy90ZWUvdGVlX3NobS5jIHwgMjcgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI3IGRlbGV0aW9ucygt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvdGVlX3NobS5jIGIvZHJpdmVycy90ZWUv
dGVlX3NobS5jDQo+IGluZGV4IDRhNDdkZTRiYjJlNS4uODk4NzA3Y2EyMWE4IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3RlZS90ZWVfc2htLmMNCj4gKysrIGIvZHJpdmVycy90ZWUvdGVlX3NobS5j
DQo+IEBAIC0yMywyOSArMjMsMTEgQEAgc3RydWN0IHRlZV9zaG1fZG1hX21lbSB7DQo+ICAgCXN0
cnVjdCBwYWdlICpwYWdlOw0KPiAgIH07DQo+ICAgDQo+IC1zdGF0aWMgdm9pZCBzaG1fcHV0X2tl
cm5lbF9wYWdlcyhzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCBzaXplX3QgcGFnZV9jb3VudCkNCj4gLXsN
Cj4gLQlzaXplX3QgbjsNCj4gLQ0KPiAtCWZvciAobiA9IDA7IG4gPCBwYWdlX2NvdW50OyBuKysp
DQo+IC0JCXB1dF9wYWdlKHBhZ2VzW25dKTsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIHZvaWQgc2ht
X2dldF9rZXJuZWxfcGFnZXMoc3RydWN0IHBhZ2UgKipwYWdlcywgc2l6ZV90IHBhZ2VfY291bnQp
DQo+IC17DQo+IC0Jc2l6ZV90IG47DQo+IC0NCj4gLQlmb3IgKG4gPSAwOyBuIDwgcGFnZV9jb3Vu
dDsgbisrKQ0KPiAtCQlnZXRfcGFnZShwYWdlc1tuXSk7DQo+IC19DQo+IC0NCj4gICBzdGF0aWMg
dm9pZCByZWxlYXNlX3JlZ2lzdGVyZWRfcGFnZXMoc3RydWN0IHRlZV9zaG0gKnNobSkNCj4gICB7
DQo+ICAgCWlmIChzaG0tPnBhZ2VzKSB7DQo+ICAgCQlpZiAoc2htLT5mbGFncyAmIFRFRV9TSE1f
VVNFUl9NQVBQRUQpDQo+ICAgCQkJdW5waW5fdXNlcl9wYWdlcyhzaG0tPnBhZ2VzLCBzaG0tPm51
bV9wYWdlcyk7DQo+IC0JCWVsc2UNCj4gLQkJCXNobV9wdXRfa2VybmVsX3BhZ2VzKHNobS0+cGFn
ZXMsIHNobS0+bnVtX3BhZ2VzKTsNCj4gICANCj4gICAJCWtmcmVlKHNobS0+cGFnZXMpOw0KPiAg
IAl9DQo+IEBAIC00NzcsMTMgKzQ1OSw2IEBAIHJlZ2lzdGVyX3NobV9oZWxwZXIoc3RydWN0IHRl
ZV9jb250ZXh0ICpjdHgsIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwgdTMyIGZsYWdzLA0KPiAgIAkJ
Z290byBlcnJfcHV0X3NobV9wYWdlczsNCj4gICAJfQ0KPiAgIA0KPiAtCS8qDQo+IC0JICogaW92
X2l0ZXJfZXh0cmFjdF9rdmVjX3BhZ2VzIGRvZXMgbm90IGdldCByZWZlcmVuY2Ugb24gdGhlIHBh
Z2VzLA0KPiAtCSAqIGdldCBhIHJlZmVyZW5jZSBvbiB0aGVtLg0KPiAtCSAqLw0KPiAtCWlmIChp
b3ZfaXRlcl9pc19rdmVjKGl0ZXIpKQ0KPiAtCQlzaG1fZ2V0X2tlcm5lbF9wYWdlcyhzaG0tPnBh
Z2VzLCBudW1fcGFnZXMpOw0KPiAtDQo+ICAgCXNobS0+b2Zmc2V0ID0gb2ZmOw0KPiAgIAlzaG0t
PnNpemUgPSBsZW47DQo+ICAgCXNobS0+bnVtX3BhZ2VzID0gbnVtX3BhZ2VzOw0KPiBAQCAtNDk5
LDggKzQ3NCw2IEBAIHJlZ2lzdGVyX3NobV9oZWxwZXIoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgs
IHN0cnVjdCBpb3ZfaXRlciAqaXRlciwgdTMyIGZsYWdzLA0KPiAgIGVycl9wdXRfc2htX3BhZ2Vz
Og0KPiAgIAlpZiAoIWlvdl9pdGVyX2lzX2t2ZWMoaXRlcikpDQo+ICAgCQl1bnBpbl91c2VyX3Bh
Z2VzKHNobS0+cGFnZXMsIHNobS0+bnVtX3BhZ2VzKTsNCj4gLQllbHNlDQo+IC0JCXNobV9wdXRf
a2VybmVsX3BhZ2VzKHNobS0+cGFnZXMsIHNobS0+bnVtX3BhZ2VzKTsNCj4gICBlcnJfZnJlZV9z
aG1fcGFnZXM6DQo+ICAgCWtmcmVlKHNobS0+cGFnZXMpOw0KPiAgIGVycl9mcmVlX3NobToNCg==
