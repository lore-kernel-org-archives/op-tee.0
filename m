Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD35CA0EF8
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 09:20:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7D8654FCA0
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 09:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755768004;
	bh=xeBnqWEhJz3t0unYUN7ogOew6uuGxwpF7/4+2gdMz6g=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=saZEXpiJHD0DbnnRJDicizaFINkgH3XUM4apj1/fNmiakrq03uylzSAJedTmvXBrT
	 GyWPA235W/fjLbvxYtGb4Z0C/A+c6PCPydajV2DvnN5rZipgqPqSgyVa37/K04CC6B
	 jdZZuoTgOIL/kOgyOtktrlMLN/wPym3CIbuuwxYBKNrSWTU6lvWJki9CGE5c4nKGQ1
	 xUsnvZgaluXHOLP2JHjGGSzpBnxvzOiRF2WFWvATcQYzZ8s34IJwbryWCUDf3HzKKX
	 d+XZIKaI/QhDggLI1qFnHhD0VzJ6vrXzWzvGaas6xKXCT7D32VgWVqruSLq71Uieei
	 tBAh0n9gdpYXA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B5C3542E02
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 Aug 2025 09:19:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AVzFdF3+;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E462560200;
	Thu, 21 Aug 2025 09:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3BBC4CEEB;
	Thu, 21 Aug 2025 09:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755767989;
	bh=LHmWowhGBf5yTqXEebyzfoGTUTFGMxnIKRPihMbg3Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVzFdF3+LrFVilgrJbRD4Z51000CAclDJhdp2IKC9XpAzXOIAEhcMkxxbOOK4yzVY
	 CeMEJXPDLZS6S0mNAD5it0+HWhDzBWy5OoZqdUfLmrAki1LXDA7GgJVGxyUVzQ+ayC
	 m/hhX7Idly7p8y/+VBKCBHrKkD7DI2cjLtp5FtNlOeLa0Gk3+uYpQ3Gycdpub7wzAv
	 EeMFt7BsESBNnXolTpAFH0+0yizpeNRCx9pAZ3jHHzFMlyP4tYSXwxRrmMYVlRmr8l
	 aDM6CJNIKPDNpAQEY+CszatFRcbO03/z8lwt35o1o5Au/kPYZfyVpaRbAmGOSf4091
	 +5N2RZ2xar0mw==
Date: Thu, 21 Aug 2025 14:49:44 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
Message-ID: <aKbksCa7Eh9DAFoM@sumit-X1>
References: <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
 <AS8PR03MB7189020F4559D0F821C4502B8A33A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44G2gG2mMGXEVLvR_C6SsxZuH+gQ5004xXYcgqTEEiDLbw@mail.gmail.com>
 <CAHUa44HJXAR=Hy6K8du-FmoPuMqddq6cnOQe=uK=et9Hnn+e2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44HJXAR=Hy6K8du-FmoPuMqddq6cnOQe=uK=et9Hnn+e2A@mail.gmail.com>
X-Rspamd-Queue-Id: B5C3542E02
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
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
Message-ID-Hash: CS67B5KEQSTAAI532JLKHZYQRT3R4OWO
X-Message-ID-Hash: CS67B5KEQSTAAI532JLKHZYQRT3R4OWO
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Lars Persson <lars.persson@axis.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CS67B5KEQSTAAI532JLKHZYQRT3R4OWO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgMDQ6NDY6MDZQTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IEZZSSwgaGVyZSdzIHRoZSBwYXRjaA0KPiBodHRwczovL3Jldmlldy50cnVzdGVk
ZmlybXdhcmUub3JnL2MvVEYtQS90cnVzdGVkLWZpcm13YXJlLWEvKy80MjA3OA0KPiANCg0KVGhh
bmtzIEplbnMsIGJ1dCBhcyB3ZSBkaXNjdXNzZWQgb24gcmV2aWV3IG9mIHRoaXMgcGF0Y2gsIEkg
aGF2ZSBwb3N0ZWQNCmEgbW9yZSBjb21wbGV0ZSBmaXggaGVyZSBbMV0gZm9yIE9QLVRFRSBmdHJh
Y2UgdG8gd29yayBhbG9uZyB3aXRoIHJlbW92aW5nDQpjb250ZXh0IG1hbmFnZW1lbnQgb2Ygbm9u
LXNlY3VyZSBFTDEgcGh5c2ljYWwgdGltZXIgcmVnaXN0ZXIuDQoNClsxXSBodHRwczovL3Jldmll
dy50cnVzdGVkZmlybXdhcmUub3JnL2MvVEYtQS90cnVzdGVkLWZpcm13YXJlLWEvKy80MjA4NQ0K
DQotU3VtaXQNCg0KPiANCj4gT24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgMzo1MOKAr1BNIEplbnMg
V2lrbGFuZGVyDQo+IDxqZW5zLndpa2xhbmRlckBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPg0KPiA+
IEhpIFRob21hcywNCj4gPg0KPiA+IE9uIFdlZCwgQXVnIDIwLCAyMDI1IGF0IDM6MDnigK9QTSBT
dGF1ZmZlciBUaG9tYXMgTVRBTkEgdmlhIE9QLVRFRQ0KPiA+IDxvcC10ZWVAbGlzdHMudHJ1c3Rl
ZGZpcm13YXJlLm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGkgSmVucywNCj4gPiA+DQo+ID4g
PiBJIGFuYWx5emVkIHRoaXMgYSBsaXR0bGUgYml0IGZ1cnRoZXIgc2luY2UgbGFzdCB0aW1lIEkg
d3JvdGUuIEhlcmUgd2hhdCBteSAiYmVsaWV2ZSIgYXQgdGhlIG1vbWVudCBpcw0KPiA+ID4NCj4g
PiA+DQo+ID4gPiAgICoNCj4gPiA+IExpbnV4IHVzZXMgdGhlIG5vbiBzZWN1cmUgdGltZXIgaW4g
YXJjaF90aW1lciAocGh5c2ljYWwvdmlydHVhbCkgLT4gdGhpcyBpcyBjb3JyZWN0DQo+ID4gPiAg
ICoNCj4gPiA+IE9QLVRFRSB1c2VzIHRoZSBzZWN1cmUgdGltZXIgKHBoeXNpY2FsL3ZpcnR1YWwp
IC0+IHRoaXMgaXMgY29ycmVjdA0KPiA+DQo+ID4gVGhhbmtzIGZvciBjb25maXJtaW5nLg0KPiA+
DQo+ID4gPiAgICoNCj4gPiA+IEFSTSBUcnVzdGVkIEZpcm13YXJlIGJ5IGRlZmF1bHQgZW5hYmxl
cyBOU19USU1FUl9TV0lUQ0g9MSB3aXRoIG9wdGVlZCwgdGhpcyBJTUhPIHVubmVjZXNzYXJpbHkg
c3RvcmVzL3Jlc3RvcmVzIHRpbWUgcmVnaXN0ZXJzLCBzZXR0aW5nIE5TX1RJTUVSX1NXSVRDSD0w
IHNlZW1zIHRvIHNvbHZlIHRoZSBpc3N1ZSwgbXkgcGVyc29uYWwgdGVzdHMgYW5kIGFsc28geHRl
c3QgZGlkIG5vdCBzaG93IG1lIGFueSBpc3N1ZSBzbyBmYXINCj4gPiA+DQo+ID4gPiBBbGwgdGhp
cyB3aXRoIHNvbWUgdW5jZXJ0YWludHksIEkgcmVhZCB0aHJvdWdoIHF1aXRlIHNvbWUgY29kZSwg
YnV0IEkgY291bGQgaGF2ZSBtaXNzZWQgYSBjYXNlLCB3aGVyZSBzb21ldGhpbmcgbWF5IGdvIHdy
b25nIEkgZGlkIG5vdCBzZWUuDQo+ID4gPg0KPiA+ID4gTGF0ZW5jaWVzIEkgdGVzdGVkIHdpdGgg
Y3ljbGV0ZXN0LiBXaXRoIE5TX1RJTUVSX1NXSVRDSD0xIHRoaXMgc2t5cm9ja2V0cyAoYW5kIGV4
cGxhaW5zIGFsbCB0aGUgb3RoZXIgbmVnYXRpdmUgY29uc2VxdWVuY2VzKSB3aXRoIE5TX1RJTUVS
X1NXSVRDSD0wLCBldmVyeXRoaW5nIGlzIGJhY2sgdG8gbm9ybWFsLCBldmVuIGRvaW5nICJoZWF2
eSIgb3BlcmF0aW9uIGxpa2UgY3JlYXRpbmcgNDA5NiBiaXQgUlNBIGtleXMgd2l0aCBPUC1URUUu
DQo+ID4NCj4gPiBUaGlzIGFuZCBMYXJzJ3MgZmluZGluZ3MgY2xlYXJseSBpbmRpY2F0ZSB0aGF0
IHdlIHNob3VsZG4ndCBzZXQNCj4gPiBOU19USU1FUl9TV0lUQ0g9MS4gSSdsbCBwcm9wb3NlIGEg
cGF0Y2guDQo+ID4NCj4gPiBDaGVlcnMsDQo+ID4gSmVucw0K
