Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B38CA0EDC
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 06:42:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 76B334FBAC
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755758572;
	bh=5/W1q/oF93I2dN+jdcD6SZyHRmqY5GIjXkDSUap6axY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0JDHwOiibNhgNUnu0qUBHADVNthG9JhopIxjAilC7HzvVFLjHcuB4zYuRW3ytskNJ
	 1SNMt1qJxZT7Ey7yylifBxm+MFwdwGnWqAG8KpPTwTUZFQ8+iWKypA5s0feVRdFxbG
	 NiVEcpPOI7tjSex0o9nrmsndQFF2+jJ5eDpHxwOzvHjcsvcmJTK9LmG5n8kQ/JMmn6
	 nvPEZGotly2H95zmgRNE3D+78qxIZxL/3uutSAVTlBF5EFJ5LfFCH9hKeRJSThcdaK
	 /pW3QHTS8PW58vhYUoSwQZMrgN80Jz+omBzOHDEbuq1HTfaRFdy4IaMASqVaUwPQGO
	 9MHLr8ELWlfEw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 87DCE42D3C
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 Aug 2025 06:42:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WULT5QM0;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CFC39419DF;
	Thu, 21 Aug 2025 06:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CBCC4CEED;
	Thu, 21 Aug 2025 06:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755758556;
	bh=/e0UOydb4IGLZ04lRtAHn+o+96vZEyQkGumPIBg+me8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WULT5QM08FJCkWYXz17jEV/iqp+e4yKdAQcJQ8hQBbi5eglFK5EXiAW0jQMgQMe6A
	 jikwnFMkTEw5QIykPjoygM1R78J9NjiQdmVO1+2yNY/vqb1px1lZm3qD/0NKjjVYhB
	 eEX7IlfNI3DmrP01D44WTzLfI23ofRQdFLxMmYUxIY2yckEMX1sL0AKzvKpIHoTgYD
	 RPTx8jJmYulsGPKe7/45xp45NuTev23fSHYy4E9Y9rvDLG9Swi+qKHJXFhLfrfyNd7
	 TyCkL4SZBL+qwkyuo6jhsKfjp0b3luTEfiNq3sR67dBWNk24/+1cdGb7tvvYi2/gra
	 QW04cdMDvwu2g==
Date: Thu, 21 Aug 2025 12:12:31 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
Message-ID: <aKa_132R8SSZHywJ@sumit-X1>
References: <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
X-Rspamd-Queue-Id: 87DCE42D3C
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 5KMWJRIPUIV76MF4WL6PLDDXVXUFWY5Q
X-Message-ID-Hash: 5KMWJRIPUIV76MF4WL6PLDDXVXUFWY5Q
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Ferreira Joao MTANA <Joao.Ferreira@mt.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5KMWJRIPUIV76MF4WL6PLDDXVXUFWY5Q/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgMDE6MTA6MDdQTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IEhpIFRob21hcywNCj4gDQo+IE9uIE1vbiwgQXVnIDQsIDIwMjUgYXQgNzowOeKA
r1BNIFN0YXVmZmVyIFRob21hcyBNVEFOQSB2aWEgT1AtVEVFDQo+IDxvcC10ZWVAbGlzdHMudHJ1
c3RlZGZpcm13YXJlLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+IEknbSBydW5u
aW5nIE9QLVRFRSA0LjUgd2l0aCBQS0NTMTFUQSBhbmQgQVRGIGx0cy12Mi4xMi40IG9uIGFuIGlN
WDhNUC4gV2hlbiBJIGNyZWF0ZSBuZXcgcnNhIDQwOTYgYml0IGtleXBhaXIgd2l0aCBPUC1URUUs
IEkgb2Z0ZW4gZ2V0DQo+ID4NCj4gPiByY3VfcHJlZW1wdCBkZXRlY3RlZCBzdGFsbHMgb24gQ1BV
cy90YXNrcw0KPiA+DQo+ID4gZnJvbSBMaW51eCA2LjYuOTAgKG1haW5saW5lKQ0KPiA+DQo+ID4g
QWxzbyBQSUQgMCBpcyBzb21ldGltZXMgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDMwIHNlY29uZHMu
IFdoZW4gSSBjcmVhdGUgYSBSVCB0YXNrIHdpdGggZXZlbiBoaWdoZXIgcHJpb3JpdHksIHRoaXMg
cHJvY2VzcyBpcyBhbHNvIGJsb2NrZWQgdXAgdG8gMiBzZWNvbmRzLiBGb3IgYSB0ZXN0IEkgZGlz
YWJsZWQgc2F2aW5nL3Jlc3RvcmluZyB0aGUgTlMgdGltZXIgcmVnaXN0ZXIgaW4gQVRGIChhcm0t
dHJ1c3RlZC1maXJtd2FyZS9saWIvZWwzX3J1bnRpbWUvYWFyY2g2NC9jb250ZXh0X21nbXQuYyks
IHRoaXMgc2VlbXMgdG8gZ2V0IGNvbXBsZXRlbHkgcmlkIG9mIHRoZSBwcm9ibGVtLiBOZWl0aGVy
IGNyZWF0aW5nIG5vciBzaWduaW5nIGxlYWRzIHRvIGFueSBpc3N1ZSBhbnltb3JlLiBUaGlzIGhh
Y2sgbWF5IGxlYWQgdG8gb3RoZXIgcHJvYmxlbXMgSSBkbyBub3QgZnVsbHkgdW5kZXJzdGFuZCB5
ZXQuIEkgImJlbGlldmUiIHRoYXQgYXQgbGVhc3Qgc2luY2UgQVJNdjgsIHRoZSBDUFUgaGF2ZSB0
aGVpciBvd24gdGltZXJzIGZvciBzZWN1cmUvbm9uLXNlY3VyZSB3b3JsZCwgYnV0IEkgd291bGQg
YXNzdW1lIHRoYXQgQVRGIGltcGxlbWVudHMgdGhpcyBjb3JyZWN0bHkgYWxyZWFkeS4NCj4gDQo+
IEknbSBzdGFydGluZyB0byBzdXNwZWN0IHRoYXQgd2UncmUgc2V0dGluZyBOU19USU1FUl9TV0lU
Q0ggdG8gMSBpbg0KPiBzZXJ2aWNlcy9zcGQvb3B0ZWVkL29wdGVlZC5tayBiYXNlZCBvbiBhIG1p
c3VuZGVyc3RhbmRpbmcuIE9QLVRFRSBjYW4NCj4gdXNlIHRpbWVycywgYnV0IHRoZW4gaXQncyB1
c2luZyB0aGUgRUwzIHBoeXNpY2FsIHRpbWVyLiBTbyBPUC1URUUNCj4gc2hvdWxkIHN0YXkgb2Zm
IHRoZSBFTDEgcGh5c2ljYWwgdGltZXIuIFN1bWl0LCB3aGF0J3MgeW91ciB2aWV3Pw0KDQpJIGhh
ZCB0byByZXNlYXJjaCB0aGUgaGlzdG9yeSB3aHkgSSBhZGRlZCBpdCBpbiB0aGUgZmlyc3QgcGxh
Y2UuIEl0IHdhcw0KYmFzaWNhbGx5IGFkZGVkIHRvIHNhdmUgYW5kIHJlc3RvcmUgY250a2N0bF9l
bDEgcmVnaXN0ZXIgd2hpY2ggaXMgbmVlZGVkDQpmb3IgZnRyYWNlIHRvIHdvcmsgY29ycmVjdGx5
LiBIYXZlIGEgbG9vayBoZXJlIFsxXS4gU28geW91ciBjdXJyZW50DQpwcm9wb3NlZCBwYXRjaCB3
aWxsIGJyZWFrIGZ0cmFjZS4NCg0KSG93ZXZlciwgYXMgYSBzaWRlIGVmZmVjdCBhbGwgdGhlIEVM
MSBwaHlzaWNhbCB0aW1lciByZWdpc3RlcnMgZ290IHNhdmVkDQphbmQgcmVzdG9yZWQgd2hpY2gg
aXMgYSBwcm9ibGVtIGFzIG1lbnRpb25lZCBoZXJlLiBTbyB0aGUgY29ycmVjdCBmaXgNCmhlcmUg
d291bGQgYmUgdG8gbWFrZSBOU19USU1FUl9TV0lUQ0ggbW9yZSBncmFudWxhciB0byBzZXBhcmF0
ZSBvdXQgdGhlDQpjbnRrY3RsX2VsMSByZWdpc3RlciBzYXZlIGFuZCByZXN0b3JlLg0KDQpbMV0g
aHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy9jb21taXQvZWRhZjhjMzhmNTM0NDk3
YTY1YTQ2MGYwMzQ4YTgxZDNlMjZiMzUxOA0KDQotU3VtaXQNCg0KPiANCj4gPg0KPiA+IE1heWJl
IEknbSBjb21wbGV0ZWx5IHdyb25nIGhlcmUgKGFzc3VtaW5nIHRoYXQgaXQgY2Fubm90IGJlIEkn
bSB0aGUgZmlyc3QgcGVyc29uIGhhdmluZyB0aGlzIGlzc3VlIG9uIHRoaXMgcGxhdGZvcm0pLiBI
aW50IGluIGFueSBkaXJlY3Rpb24gd291bGQgYmUgaGVscGZ1bC4NCj4gDQo+IEknbSBzdXJwcmlz
ZWQgd2UgaGF2ZW4ndCBzZWVuIG1vcmUgb2YgdGhpcyBpc3N1ZS4NCj4gDQo+IENoZWVycywNCj4g
SmVucw0KPiANCj4gPg0KPiA+IFJlZ2FyZHMNCj4gPg0KPiA+IFRob21hcw0KPiA+DQo=
