Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74469CAC587
	for <op-tee@archiver.kernel.org>; Tue,  9 Sep 2025 07:27:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A74554FD98
	for <op-tee@archiver.kernel.org>; Tue,  9 Sep 2025 07:27:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xg-auto.20200927.dkim.feishu.cn header.i=@xg-auto.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=Afg4aNuv;
	dkim-atps=neutral
Received: from sg-1-36.ptr.blmpb.com (sg-1-36.ptr.blmpb.com [118.26.132.36])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BE3AD4313D
	for <op-tee@lists.trustedfirmware.org>; Tue,  9 Sep 2025 07:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=xg-auto.20200927.dkim.feishu.cn; t=1757402384;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=G5XGEkyG8pibu63a9Xj2bQc+I3vtdWqA/fTMKjUSAYY=;
 b=Afg4aNuvNnaVnJEBpsht6pJ5z+a611RLpUkWWJwEYA5cMagR2XLgqVtH182mwXS+0sXGzm
 /Go1nLqRL+dtixYE+YwLuxNL7Pc+7c5m6muguXXfvLF+X85pyFnDxtXKoIEwW3jV520ngB
 zUwem88+Q+h/930Z4F/wyO8LZ5/0vr70GYn4SvyytbHvC5CsZCmdOcxHt5s6F0ZJD2ECsB
 oLvSTMXi9LB8AnBebPGMcRrWK6T+mSE7GDbjJTdwCFuWxE03cyUcUr2aspODfPyAd0r/49
 G3r8TkqZwJom0kMWUzFCv6TlUbV5bEofzhkOx7HgBeA0Yon1jb4vKvQjD97z7Q==
Subject: Re: [BUG] mobj_ffa_get_by_cookie() fails with 16K/64K kernel page size
In-Reply-To: <aL_TRb9wCnCAYDdW@sumit-X1>
Message-Id: <eb57f0258749e983b3423f1620c8d6876113f7cc.c2322d50.059d.4ff5.80b7.4faaae8d0edc@feishu.cn>
To: "Sumit Garg" <sumit.garg@kernel.org>
From: =?utf-8?q?=E6=88=B4=E7=9D=BF?= <rui.dai@xg.auto>
Mime-Version: 1.0
References: <eb57f0258749e983b3423f1620c8d6876113f7cc.953132d2.6e78.4432.8309.0d0d57874c64@feishu.cn>
	<aL_TRb9wCnCAYDdW@sumit-X1>
X-Lms-Return-Path: <lba+168bfd50f+1f5af3+lists.trustedfirmware.org+rui.dai@xg.auto>
Date: Tue, 09 Sep 2025 15:19:42 +0800
X-Rspamd-Queue-Id: BE3AD4313D
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[xg-auto.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:118.26.132.0/24];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	ONCE_RECEIVED(0.10)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:138699, ipnet:118.26.132.0/24, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[xg.auto];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DNSWL_BLOCKED(0.00)[118.26.132.36:from];
	NEURAL_HAM(-0.00)[-0.958];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[xg-auto.20200927.dkim.feishu.cn:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: rui.dai@xg.auto
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: AMWU3ZCWO2MX3YJR2R4QOIE2YFRRO4TN
X-Message-ID-Hash: AMWU3ZCWO2MX3YJR2R4QOIE2YFRRO4TN
X-Mailman-Approved-At: Tue, 09 Sep 2025 07:27:39 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AMWU3ZCWO2MX3YJR2R4QOIE2YFRRO4TN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhhbmtzIGZvciBjbGFyaWZ5aW5nLiBJIGFncmVlIHRoaXMgaXMgbm90IHJlYWxseSBhIGJ1Zywg
YnV0IHJhdGhlciBhIGZlYXR1cmUgdGhhdCBPUC1URUUgbWF5IG5lZWQgdG8gc3VwcG9ydCBpbiB0
aGUgZnV0dXJlLg0KDQpBcyBJIG1lbnRpb25lZCBlYXJsaWVyLCBHb29nbGUgaXMgYWN0aXZlbHkg
bW92aW5nIHRoZSBBbmRyb2lkIGVjb3N5c3RlbSB0b3dhcmQgMTYgS0IgcGFnZSBzaXplcy4gRm9y
IGV4YW1wbGU6DQotIEFuZHJvaWQgRGV2ZWxvcGVycyBkb2N1bWVudGF0aW9uOiBodHRwczovL2Rl
dmVsb3Blci5hbmRyb2lkLmNvbS9ndWlkZS9wcmFjdGljZXMvcGFnZS1zaXplcz91dG1fc291cmNl
PWNoYXRncHQuY29tKHVwZGF0ZWQgSnVseSAyOCwgMjAyNSkgwqANCi0gQW5kcm9pZCBEZXZlbG9w
ZXJzIEJsb2c6IGh0dHBzOi8vYW5kcm9pZC1kZXZlbG9wZXJzLmdvb2dsZWJsb2cuY29tLzIwMjUv
MDUvcHJlcGFyZS1wbGF5LWFwcHMtZm9yLWRldmljZXMtd2l0aC0xNmtiLXBhZ2Utc2l6ZS5odG1s
P3V0bV9zb3VyY2U9Y2hhdGdwdC5jb23CoChNYXkgOCwgMjAyNSkgwqANCg0KU3RhcnRpbmcgTm92
ZW1iZXIgMSwgMjAyNSwgYWxsIGFwcHMgdGFyZ2V0aW5nIEFuZHJvaWQgMTUrIG9uIEdvb2dsZSBQ
bGF5IG11c3Qgc3VwcG9ydCAxNiBLQiBwYWdlIHNpemVzLiBUaGlzIHNob3dzIHRoYXQgdGhlIGxv
bmctdGVybSB0cmVuZCBpcyBjbGVhcmx5IHRvd2FyZCBsYXJnZXIga2VybmVsIHBhZ2Ugc2l6ZXMu
DQoNCkluIG15IGxvY2FsIHRlc3RpbmcsIEkgbWFkZSBhIHNtYWxsIGFkanVzdG1lbnQgaW4gT1At
VEVFIGJ5IGFkZGluZyBoYW5kbGluZyBmb3IgYGludGVybmFsX29mZnNgIGluIGJvdGggYHNldF9m
bWVtX3BhcmFtKClgIGFuZCBgbW9ial9mZmFfZ2V0X2J5X2Nvb2tpZSgpYC4gVGhpcyByZXNvbHZl
cyB0aGUgaXNzdWUgd2l0aG91dCBjaGFuZ2luZyBgU01BTExfUEFHRV9TSVpFYC4gVXBkYXRpbmcg
YFNNQUxMX1BBR0VfU0laRWAgaXRzZWxmIHdvdWxkIGJlIGEgbXVjaCBtb3JlIGRpZmZpY3VsdCBj
aGFuZ2UsIHNvIGhhbmRsaW5nIHRoZSBvZmZzZXQgc2VlbXMgbGlrZSBhIHByYWN0aWNhbCBjb21w
cm9taXNlLg0KPiBGcm9tOiAiU3VtaXQgR2FyZyI8c3VtaXQuZ2FyZ0BrZXJuZWwub3JnPg0KPiBE
YXRlOiAgVHVlLCBTZXAgOSwgMjAyNSwgMTU6MTINCj4gU3ViamVjdDogIFJlOiBbQlVHXSBtb2Jq
X2ZmYV9nZXRfYnlfY29va2llKCkgZmFpbHMgd2l0aCAxNksvNjRLIGtlcm5lbCBwYWdlIHNpemUN
Cj4gVG86ICLmiLTnnb8iPHJ1aS5kYWlAeGcuYXV0bz4NCj4gQ2M6ICJvcC10ZWVAbGlzdHMudHJ1
c3RlZGZpcm13YXJlLm9yZyI8b3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmc+DQo+IEhp
LA0KDQo+IA0KPiBPbiBNb24sIFNlcCAwOCwgMjAyNSBhdCAwMzozNTowMlBNICswODAwLCDmiLTn
nb8gd3JvdGU6DQoNCj4gPiBIaSBPUC1URUUgbWFpbnRhaW5lcnMsDQoNCj4gPiANCg0KPiA+IEkg
Zm91bmQgYW4gaXNzdWUgaW4gb3B0ZWVfb3MgcmVsYXRlZCB0byBGRkEgbWVtb3J5IGhhbmRsaW5n
IGFjcm9zcyBkaWZmZXJlbnQga2VybmVsIHBhZ2Ugc2l6ZXMuDQoNCj4gPiANCg0KPiA+IEZpbGU6
IGNvcmUvYXJjaC9hcm0vbW0vbW9ial9mZmEuYw0KDQo+ID4gRnVuY3Rpb246IG1vYmpfZmZhX2dl
dF9ieV9jb29raWUoKQ0KDQo+ID4gDQoNCj4gPiBBdCB0aGUgYmVnaW5uaW5nIG9mIHRoaXMgZnVu
Y3Rpb24gdGhlcmUgaXMgYSBjaGVjazoNCg0KPiA+IA0KDQo+ID4gwqDCoMKgIGlmIChpbnRlcm5h
bF9vZmZzID49IFNNQUxMX1BBR0VfU0laRSkNCg0KPiA+IMKgwqAgwqAgwqDCoCByZXR1cm4gTlVM
TDsNCg0KPiA+IA0KDQo+ID4gSGVyZSwgU01BTExfUEFHRV9TSVpFwqBpcyBmaXhlZCB0byA0S0Iu
IFdoZW4gcnVubmluZyB3aXRoIGEgTGludXgga2VybmVsIGJ1aWx0IHdpdGggMTZLIG9yIDY0SyBw
YWdlIHNpemVzDQoNCj4gPiAoQ09ORklHX0FSTTY0XzE2S19QQUdFUyBvciBDT05GSUdfQVJNNjRf
NjRLX1BBR0VTKSwgdGhpcyBjaGVjayBpbmNvcnJlY3RseSByZWplY3RzIHZhbGlkIG9mZnNldHMu
DQoNCj4gPiBBcyBhIHJlc3VsdCwgbW9ial9mZmFfZ2V0X2J5X2Nvb2tpZSgpIHJldHVybnMgTlVM
TCwgd2hpY2ggbGVhZHMgdG8gVEVFX0VSUk9SX0JBRF9QQVJBTUVURVJTIGR1cmluZyBGRkENCg0K
PiA+IGNvbW11bmljYXRpb24gKGZvciBleGFtcGxlIHdoZW4gc2V0X2ZtZW1fcGFyYW0oKSBjYWxs
cyBpdCkuDQoNCj4gPiANCg0KPiA+IEltcGFjdDoNCg0KPiA+IC0gRkZBIGNvbW11bmljYXRpb24g
ZmFpbHMgb24gc3lzdGVtcyB3aGVyZSB0aGUga2VybmVsIHVzZXMgMTZLIG9yIDY0SyBwYWdlcy4N
Cg0KPiA+IC0gV2l0aCAxNksgYmVjb21pbmcgbW9yZSB3aWRlbHkgYWRvcHRlZCAoZS5nLiBHb29n
bGXigJlzIHN0YW5kYXJkaXphdGlvbiksIHRoaXMgcHJvYmxlbSB3aWxsIGJlIG1vcmUgY29tbW9u
Lg0KDQo+ID4gDQoNCj4gPiBFeHBlY3RlZCBiZWhhdmlvcjoNCg0KPiA+IFRoZSBmdW5jdGlvbiBz
aG91bGQgbm90IGFzc3VtZSBhIGZpeGVkIDRLIHBhZ2Ugc2l6ZSwgYnV0IGFkYXB0IHRvIHRoZSBh
Y3R1YWwga2VybmVsIHBhZ2Ugc2l6ZS4NCg0KPiA+IA0KDQo+ID4gRW52aXJvbm1lbnQ6DQoNCj4g
PiAtIE9QLVRFRSB2ZXJzaW9uOiBvYnNlcnZlZCBpbiBtdWx0aXBsZSB2ZXJzaW9ucyBpbmNsdWRp
bmcgbGF0ZXN0IG1hc3Rlcg0KDQo+ID4gLSBQbGF0Zm9ybTogQVJNNjQgd2l0aCBGRkEgZW5hYmxl
ZA0KDQo+ID4gLSBLZXJuZWwgY29uZmlnOiBDT05GSUdfQVJNNjRfMTZLX1BBR0VTIC8gQ09ORklH
X0FSTTY0XzY0S19QQUdFUw0KDQo+ID4gDQoNCj4gPiBQb3NzaWJsZSBmaXg6DQoNCj4gPiAtIFJl
cGxhY2UgdGhlIFNNQUxMX1BBR0VfU0laRSBjaGVjayB3aXRoIGEgZHluYW1pYyBjaGVjayBiYXNl
ZCBvbiB0aGUga2VybmVs4oCZcyBhY3R1YWwgcGFnZSBzaXplLA0KDQo+ID4gwqAgb3IgbWFrZSB0
aGUgdmFsaWRhdGlvbiBjb25maWd1cmFibGUuDQoNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgaXQgaXMg
YW4gT1AtVEVFIGJ1ZyBhcyBvZiBub3cgYnV0IGEgbWlzc2luZyBmZWF0dXJlIGluDQoNCj4gT1At
VEVFIHRvIHN1cHBvcnQgMTZLIGFuZCA2NEsgcGFnZXMuIFdvdWxkIHlvdSBiZSBhYmxlIHRvIGVu
YWJsZSB0aGlzDQoNCj4gZmVhdHVyZSBmb3IgT1AtVEVFPw0KDQo+IA0KPiAtU3VtaXQNCg0KPiAN
Cj4gPiANCg0KPiA+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBtb3JlIGRldGFpbHMu
IEkgYW0gaGFwcHkgdG8gdGVzdCBvciBwcm92aWRlIGEgcGF0Y2ggc3VnZ2VzdGlvbiBpZiB0aGF0
IGhlbHBzLg0KDQo+ID4gDQoNCj4gPiBCZXN0IHJlZ2FyZHMsDQoNCj4gPiBkZHJkdGRuDQo+IA==
