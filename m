Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A46CA0EF8
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 07:09:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C233D4FC40
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755760141;
	bh=RDeE1ZRuSST2B7iOXOigS8+HNuHXZ3d5S94z9RNdHig=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=A9QnqXGAKccxqxUUlWRJgNc8/D+a3L8EqsXPKHQmDEsozQ9zw1yROds/ie37HCfuP
	 ZTeFsHPgQyqD5707joF0uD7q6h0SA1iNKkne8cJPHSPBsLq/oRgowMUT4zPiVUh95y
	 dZ8uHLrn4vF7Oie4IWT0rVey6TBl8FpoLnBu7W8E6bV0OYgBYzaNyLzOjFA+pMvn6M
	 Rz/MZY8BQy/2QkjgTyb75ObOHgjAKvofCOXU2dmxRR10EXtZJX+n2OqaEyJqUw/vDi
	 uBkX4ggFJJdPwvvsV/VU8PLboUOMgBXSRZl4r3R+rJ8nzpdeLulIMkArYcx8HsLMI0
	 XKa798C0TPpUw==
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 92F5D42F49
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 Aug 2025 07:08:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jdbzNiRw;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 19BF15C6214;
	Thu, 21 Aug 2025 07:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F081C4CEED;
	Thu, 21 Aug 2025 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755760127;
	bh=K2psJOjjH7QeiHXE3ZA6oajoTtBVvu+p4yYeDfhzLkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdbzNiRw6q2c2C7saEifG+fBnXHYz4oKeSbsBZSlXb2nx6KAVfSwBejgOy22wB41b
	 ugIOacVjf8mXJ41cyd01DCzydiyTc5fbWtT7mPwwNFEhuswNpjlWLtJCbaTI+3NcCZ
	 pei9hztmN3K3iJ1r36E/mPpsWed4j52Bww7tk2gxEAkHASGDxVo50pDYc34xK3uUYt
	 0oAq5GusAagypBiG90LrkmFcwX+DQYbousKZ3sVMvzP/9vCHEG0cJISdGrJicQxIPT
	 t39i3Ri3ChCLJxcqo98AIsfY5pq/xYcYPBIUB3m/YybUe85FB5aOP757i6D7uv3X8I
	 YGhOjOZqaRxBQ==
Date: Thu, 21 Aug 2025 12:38:42 +0530
To: Andrew Davis <afd@ti.com>
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
Message-ID: <aKbF-gaSYOREE-bA@sumit-X1>
References: <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
 <AS8PR03MB7189020F4559D0F821C4502B8A33A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44G2gG2mMGXEVLvR_C6SsxZuH+gQ5004xXYcgqTEEiDLbw@mail.gmail.com>
 <41817afd-110a-4dd8-b16e-c753347be31f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <41817afd-110a-4dd8-b16e-c753347be31f@ti.com>
X-Rspamd-Queue-Id: 92F5D42F49
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	RCVD_IN_DNSWL_HI(-0.50)[139.178.84.217:from];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:139.178.84.217];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15830, ipnet:139.178.80.0/21, country:NL];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: QYY2INCLB4DRZU347P5BPLQE4VRRV5BE
X-Message-ID-Hash: QYY2INCLB4DRZU347P5BPLQE4VRRV5BE
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QYY2INCLB4DRZU347P5BPLQE4VRRV5BE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgMTE6MDQ6MTVBTSAtMDUwMCwgQW5kcmV3IERhdmlzIHZp
YSBPUC1URUUgd3JvdGU6DQo+IE9uIDgvMjAvMjUgODo1MCBBTSwgSmVucyBXaWtsYW5kZXIgd3Jv
dGU6DQo+ID4gSGkgVGhvbWFzLA0KPiA+IA0KPiA+IE9uIFdlZCwgQXVnIDIwLCAyMDI1IGF0IDM6
MDnigK9QTSBTdGF1ZmZlciBUaG9tYXMgTVRBTkEgdmlhIE9QLVRFRQ0KPiA+IDxvcC10ZWVAbGlz
dHMudHJ1c3RlZGZpcm13YXJlLm9yZz4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IEhpIEplbnMsDQo+
ID4gPiANCj4gPiA+IEkgYW5hbHl6ZWQgdGhpcyBhIGxpdHRsZSBiaXQgZnVydGhlciBzaW5jZSBs
YXN0IHRpbWUgSSB3cm90ZS4gSGVyZSB3aGF0IG15ICJiZWxpZXZlIiBhdCB0aGUgbW9tZW50IGlz
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gICAgKg0KPiA+ID4gTGludXggdXNlcyB0aGUgbm9uIHNl
Y3VyZSB0aW1lciBpbiBhcmNoX3RpbWVyIChwaHlzaWNhbC92aXJ0dWFsKSAtPiB0aGlzIGlzIGNv
cnJlY3QNCj4gPiA+ICAgICoNCj4gPiA+IE9QLVRFRSB1c2VzIHRoZSBzZWN1cmUgdGltZXIgKHBo
eXNpY2FsL3ZpcnR1YWwpIC0+IHRoaXMgaXMgY29ycmVjdA0KPiA+IA0KPiA+IFRoYW5rcyBmb3Ig
Y29uZmlybWluZy4NCj4gPiANCj4gPiA+ICAgICoNCj4gPiA+IEFSTSBUcnVzdGVkIEZpcm13YXJl
IGJ5IGRlZmF1bHQgZW5hYmxlcyBOU19USU1FUl9TV0lUQ0g9MSB3aXRoIG9wdGVlZCwgdGhpcyBJ
TUhPIHVubmVjZXNzYXJpbHkgc3RvcmVzL3Jlc3RvcmVzIHRpbWUgcmVnaXN0ZXJzLCBzZXR0aW5n
IE5TX1RJTUVSX1NXSVRDSD0wIHNlZW1zIHRvIHNvbHZlIHRoZSBpc3N1ZSwgbXkgcGVyc29uYWwg
dGVzdHMgYW5kIGFsc28geHRlc3QgZGlkIG5vdCBzaG93IG1lIGFueSBpc3N1ZSBzbyBmYXINCj4g
PiA+IA0KPiA+ID4gQWxsIHRoaXMgd2l0aCBzb21lIHVuY2VydGFpbnR5LCBJIHJlYWQgdGhyb3Vn
aCBxdWl0ZSBzb21lIGNvZGUsIGJ1dCBJIGNvdWxkIGhhdmUgbWlzc2VkIGEgY2FzZSwgd2hlcmUg
c29tZXRoaW5nIG1heSBnbyB3cm9uZyBJIGRpZCBub3Qgc2VlLg0KPiA+ID4gDQo+ID4gPiBMYXRl
bmNpZXMgSSB0ZXN0ZWQgd2l0aCBjeWNsZXRlc3QuIFdpdGggTlNfVElNRVJfU1dJVENIPTEgdGhp
cyBza3lyb2NrZXRzIChhbmQgZXhwbGFpbnMgYWxsIHRoZSBvdGhlciBuZWdhdGl2ZSBjb25zZXF1
ZW5jZXMpIHdpdGggTlNfVElNRVJfU1dJVENIPTAsIGV2ZXJ5dGhpbmcgaXMgYmFjayB0byBub3Jt
YWwsIGV2ZW4gZG9pbmcgImhlYXZ5IiBvcGVyYXRpb24gbGlrZSBjcmVhdGluZyA0MDk2IGJpdCBS
U0Ega2V5cyB3aXRoIE9QLVRFRS4NCj4gPiANCj4gPiBUaGlzIGFuZCBMYXJzJ3MgZmluZGluZ3Mg
Y2xlYXJseSBpbmRpY2F0ZSB0aGF0IHdlIHNob3VsZG4ndCBzZXQNCj4gPiBOU19USU1FUl9TV0lU
Q0g9MS4gSSdsbCBwcm9wb3NlIGEgcGF0Y2guDQo+ID4gDQo+IA0KPiBTYW1lIGNvbmNsdXNpb24g
d2UgY2FtZSB0byBsYXN0IHllYXIsIHdlIGRpc2FibGUgaXQgZm9yIG91cihUSSkgcGxhdGZvcm1z
DQo+IGZvciB0aGUgc2FtZSByZWFzb25bMF0sIHRvIHByZXZlbnQgc3RhbGxpbmcgdGhlIExpbnV4
IGR1cmluZyBPUC1URUUgb3BzLg0KPiANCg0KSSBhbSB1bnN1cmUgd2h5IGZvbGtzIGNob29zZSB0
byBmaXggdGhpcyBwcm9ibGVtIGluIGEgcGxhdGZvcm0gc3BlY2lmaWMNCm1hbm5lciAodXBzdHJl
YW0gb3IgZG93bnN0cmVhbSkgc2luY2UgaXQncyBhIGdlbmVyaWMgcGxhdGZvcm0gYWdub3N0aWMN
CnByb2JsZW0uIEF0bGVhc3QgSSBzaG91bGQgYmUgQ0NlZCBvbiB0aGUgcHJvYmxlbSByZXBvcnQg
YW5kIGZpeA0KcHJvcG9zZWQgc2luY2UgSSBhZGRlZCB0aGF0IE5TX1RJTUVSX1NXSVRDSD0xIGZv
ciBPUC1URUUgaW4gdGhlIGZpcnN0DQpwbGFjZS4gQWxzbywgdGhpcyBtZWFucyBub2JvZHkgaXMg
YWJsZSB0byBlbmFibGUgZnRyYWNlIG9uIE5YUCBhbmQgVEkNCnBsYXRmb3JtcyB1bnRpbCBub3cu
DQoNCi1TdW1pdA0K
