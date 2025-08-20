Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF978CA0EE4
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 16:04:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 25B7B430F1
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 16:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755705873;
	bh=ckOeY/cgUxsGD5kAtz2nXTEMvp5u53P441V5MP1RAQw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=fWgVe/LS6D+ASsSMk0D83EW/X9UuPcDI5UiYqMwYJg+ru/Rd5P5z+wYMmnvvoYqTm
	 FraFedRO3JreEbNdNvIVRzhMt7E6iFnKPWUZJcFpp/kDqi/0eSdrHOpB4zDsNLdjSg
	 nt18tuJWf7qslagJuZAy1fZ7lYkaVg77NRN4edvT7stKQ+qsI9cf+6G0E90Yjc895I
	 1A96SJamD3e0GcVrgh1pwRc4IXAf5FPy49fJ216tbpYX7Q1/BJ1OyVBD3rIPf3roVa
	 Y5ib3UbiStb4ZEizMrpYWxosK/u07MRxSgzgxHRtPGtGkfYaOdnIuSbL62pTXX/b7I
	 cYGX6M0QeUFZw==
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EBE11430DC
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 16:04:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=ti-com-17Q1 header.b=A1SMbe6B;
	dkim-atps=neutral
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57KG4Gm93233169
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 11:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755705856;
	bh=1E3VxRnnktSfQOTtDAlp0cOYAPKU04O7QvL5EbLMB6Q=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=A1SMbe6BDv6z7MQIK/pjUDERlr6rNM+CCMVYA71jLmBEOdvWvEk/qkDll74litQUW
	 EqqTJ0xb8bO3aa4Hjx7Vtg9S3JxzbzTCYAZAjdJMWkhRKocnp1f2Xyi4oD1cCwUKar
	 Wz3d/9Kuhfez5egD4cZexpItB4lN0DK3n9u2pIgs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57KG4Gaw1898978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 11:04:16 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 11:04:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 11:04:15 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57KG4F8x475642
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 11:04:16 -0500
Message-ID: <41817afd-110a-4dd8-b16e-c753347be31f@ti.com>
Date: Wed, 20 Aug 2025 11:04:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
To: <op-tee@lists.trustedfirmware.org>
References: <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
 <AS8PR03MB7189020F4559D0F821C4502B8A33A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44G2gG2mMGXEVLvR_C6SsxZuH+gQ5004xXYcgqTEEiDLbw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44G2gG2mMGXEVLvR_C6SsxZuH+gQ5004xXYcgqTEEiDLbw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Rspamd-Queue-Id: EBE11430DC
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.99 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	DWL_DNSWL_LOW(-1.00)[ti.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:198.47.23.224/27];
	R_DKIM_ALLOW(-0.20)[ti.com:s=ti-com-17Q1];
	MIME_GOOD(-0.10)[text/plain];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:161, ipnet:198.47.23.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 7LVLWURZ3HIRVXSRHCW54NUCUPNFJSH4
X-Message-ID-Hash: 7LVLWURZ3HIRVXSRHCW54NUCUPNFJSH4
X-MailFrom: afd@ti.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7LVLWURZ3HIRVXSRHCW54NUCUPNFJSH4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Andrew Davis via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Andrew Davis <afd@ti.com>

T24gOC8yMC8yNSA4OjUwIEFNLCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gSGkgVGhvbWFzLA0K
PiANCj4gT24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgMzowOeKAr1BNIFN0YXVmZmVyIFRob21hcyBN
VEFOQSB2aWEgT1AtVEVFDQo+IDxvcC10ZWVAbGlzdHMudHJ1c3RlZGZpcm13YXJlLm9yZz4gd3Jv
dGU6DQo+Pg0KPj4gSGkgSmVucywNCj4+DQo+PiBJIGFuYWx5emVkIHRoaXMgYSBsaXR0bGUgYml0
IGZ1cnRoZXIgc2luY2UgbGFzdCB0aW1lIEkgd3JvdGUuIEhlcmUgd2hhdCBteSAiYmVsaWV2ZSIg
YXQgdGhlIG1vbWVudCBpcw0KPj4NCj4+DQo+PiAgICAqDQo+PiBMaW51eCB1c2VzIHRoZSBub24g
c2VjdXJlIHRpbWVyIGluIGFyY2hfdGltZXIgKHBoeXNpY2FsL3ZpcnR1YWwpIC0+IHRoaXMgaXMg
Y29ycmVjdA0KPj4gICAgKg0KPj4gT1AtVEVFIHVzZXMgdGhlIHNlY3VyZSB0aW1lciAocGh5c2lj
YWwvdmlydHVhbCkgLT4gdGhpcyBpcyBjb3JyZWN0DQo+IA0KPiBUaGFua3MgZm9yIGNvbmZpcm1p
bmcuDQo+IA0KPj4gICAgKg0KPj4gQVJNIFRydXN0ZWQgRmlybXdhcmUgYnkgZGVmYXVsdCBlbmFi
bGVzIE5TX1RJTUVSX1NXSVRDSD0xIHdpdGggb3B0ZWVkLCB0aGlzIElNSE8gdW5uZWNlc3Nhcmls
eSBzdG9yZXMvcmVzdG9yZXMgdGltZSByZWdpc3RlcnMsIHNldHRpbmcgTlNfVElNRVJfU1dJVENI
PTAgc2VlbXMgdG8gc29sdmUgdGhlIGlzc3VlLCBteSBwZXJzb25hbCB0ZXN0cyBhbmQgYWxzbyB4
dGVzdCBkaWQgbm90IHNob3cgbWUgYW55IGlzc3VlIHNvIGZhcg0KPj4NCj4+IEFsbCB0aGlzIHdp
dGggc29tZSB1bmNlcnRhaW50eSwgSSByZWFkIHRocm91Z2ggcXVpdGUgc29tZSBjb2RlLCBidXQg
SSBjb3VsZCBoYXZlIG1pc3NlZCBhIGNhc2UsIHdoZXJlIHNvbWV0aGluZyBtYXkgZ28gd3Jvbmcg
SSBkaWQgbm90IHNlZS4NCj4+DQo+PiBMYXRlbmNpZXMgSSB0ZXN0ZWQgd2l0aCBjeWNsZXRlc3Qu
IFdpdGggTlNfVElNRVJfU1dJVENIPTEgdGhpcyBza3lyb2NrZXRzIChhbmQgZXhwbGFpbnMgYWxs
IHRoZSBvdGhlciBuZWdhdGl2ZSBjb25zZXF1ZW5jZXMpIHdpdGggTlNfVElNRVJfU1dJVENIPTAs
IGV2ZXJ5dGhpbmcgaXMgYmFjayB0byBub3JtYWwsIGV2ZW4gZG9pbmcgImhlYXZ5IiBvcGVyYXRp
b24gbGlrZSBjcmVhdGluZyA0MDk2IGJpdCBSU0Ega2V5cyB3aXRoIE9QLVRFRS4NCj4gDQo+IFRo
aXMgYW5kIExhcnMncyBmaW5kaW5ncyBjbGVhcmx5IGluZGljYXRlIHRoYXQgd2Ugc2hvdWxkbid0
IHNldA0KPiBOU19USU1FUl9TV0lUQ0g9MS4gSSdsbCBwcm9wb3NlIGEgcGF0Y2guDQo+IA0KDQpT
YW1lIGNvbmNsdXNpb24gd2UgY2FtZSB0byBsYXN0IHllYXIsIHdlIGRpc2FibGUgaXQgZm9yIG91
cihUSSkgcGxhdGZvcm1zDQpmb3IgdGhlIHNhbWUgcmVhc29uWzBdLCB0byBwcmV2ZW50IHN0YWxs
aW5nIHRoZSBMaW51eCBkdXJpbmcgT1AtVEVFIG9wcy4NCg0KQW5kcmV3DQoNClswXSBodHRwczov
L3Jldmlldy50cnVzdGVkZmlybXdhcmUub3JnL2MvVEYtQS90cnVzdGVkLWZpcm13YXJlLWEvKy8y
NTg5NQ0KDQo+IENoZWVycywNCj4gSmVucw0KDQo=
