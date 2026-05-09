Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ACACD3447
	for <op-tee@archiver.kernel.org>; Sat,  9 May 2026 15:18:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3785444984
	for <op-tee@archiver.kernel.org>; Sat,  9 May 2026 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1778339916;
	bh=86f/ghYuVCRtteIlJAGb8CXTxT5t9UYu4fqpecu+kCk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gp3Amn+AEBnELLrd0pYMPGKxv8XdoCXX81OZStXqvJXYr1lilvHo2DyYJMqEN4b2J
	 rNPcmBIj8/bl7YX2n1j4wognODP1swGh1AKYBu11FAGALtpBMuWoh72q7PbTQ22CPQ
	 UGL5cLiPIFt6SQbQZuHGgFwhTLr/f6IDxW6ChhjZ699usiRvmmyyKHflBGc+IPUnNI
	 zMa3cnlSMYpqEtgG1uZHSirM0G8nivRVjH54wyOqUZ49bqgFt+8sd/Fr54YnaSIaO7
	 K8fL2Nz0ev51ey58iKEMS10cVu84HxfsDIi/RZu3JLi+Q16N7Z6rTksvCwfX00lFU5
	 Le2ZAc4ZtYDmw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BB3C343ECF
	for <op-tee@lists.trustedfirmware.org>; Sat,  9 May 2026 15:18:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ak4zh1Ya;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F0C960120;
	Sat,  9 May 2026 15:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BD6C2BCB2;
	Sat,  9 May 2026 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778339908;
	bh=/ACUJvZGGTfgk7qwE+CEQ+Q/6FZhULEY3LJDvaunTIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ak4zh1YayxVoIa7LXt8iqHF5BoUHQisuRChzVwMaiNo750MwM4+MdtjKC58dGPpfj
	 BM+SXNBsRIbdtlMRj/b9xSpkhIIYTaT2XAWyY5tmD+P60x86PkKLPCUde2AVghaYji
	 vffaYs1tLvqjPhTvoVMrtmwiJLY2vNKLWD8i/CVHp0sF+IxgwpbkjfFS7AlLzVRmbq
	 c0AYDKFVA0/8Rd6bCSRmjK02fkUi1y8APdtOrxSXIRQ+ydOauosFvg1R4044fFzSht
	 rf/nlbGGILgZevQ4WWI3/his1uW6ky7job4ba4A6Dbtk+cS36NEFWR1J/BjRx0Z6+p
	 4rb67D4aAkLjQ==
Date: Sat, 9 May 2026 18:18:25 +0300
To: "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
Message-ID: <af9QQah4QN5VD-4P@kernel.org>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
 <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[siemens.com,gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org];
	HAS_WP_URI(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BB3C343ECF
X-Spamd-Bar: ----
Message-ID-Hash: DBGPGAR7C7RX3YPQE5DJTCXXU3XFFF7C
X-Message-ID-Hash: DBGPGAR7C7RX3YPQE5DJTCXXU3XFFF7C
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, Peter Huewe <peterhuewe@gmx.de>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Bauer, Sven" <svenbauer@siemens.com>, "Zeschg, Thomas" <thomas.zeschg@siemens.com>, "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DBGPGAR7C7RX3YPQE5DJTCXXU3XFFF7C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

T24gV2VkLCBBcHIgMjksIDIwMjYgYXQgMDI6MzM6MjBQTSArMDAwMCwgTmllZGVybWF5ciwgQkVO
RURJS1Qgd3JvdGU6DQo+IE9uIDEwLzI3LzI1IDIwOjUxLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+ID4gT24gVHVlLCBPY3QgMjEsIDIwMjUgYXQgMDI6NDY6MTVQTSArMDIwMCwgSmFuIEtpc3pr
YSB3cm90ZToNCj4gPj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4N
Cj4gPj4NCj4gPj4gQXMgc2VlbiB3aXRoIG9wdGVlX2Z0cG0sIHdoaWNoIHVzZXMgbXMtdHBtLTIw
LXJlZiBbMV0sIGEgVFBNIG1heSB3cml0ZQ0KPiA+PiB0aGUgY3VycmVudCB0aW1lIGVwb2NoIHRv
IGl0cyBOViBzdG9yYWdlIGV2ZXJ5IDQgc2Vjb25kcyBpZiB0aGVyZSBhcmUNCj4gPj4gY29tbWFu
ZHMgc2VudCB0byBpdC4gVGhlIDYwIHNlY29uZHMgcGVyaW9kaWMgdXBkYXRlIG9mIHRoZSBlbnRy
b3B5IHBvb2wNCj4gPj4gdGhhdCB0aGUgaHdybmcga3RocmVhZCBkb2VzIHRyaWdnZXJzIHRoaXMs
IGNhdXNpbmcgYWJvdXQgNCB3cml0ZXMgcGVyDQo+ID4+IHJlcXVlc3RzLiBNYWtlcyAyIG1pbGxp
b25zIHBlciB5ZWFyIGZvciBhIDI0LzcgZGV2aWNlLCBhbmQgdGhhdCBpcyBhIGxvdA0KPiA+PiBm
b3IgaXRzIGJhY2tpbmcgTlYgc3RvcmFnZS4NCj4gPj4NCj4gPj4gSXQgaXMgdGhlcmVmb3JlIGJl
dHRlciB0byBtYWtlIHRoZSB1c2VyIGludGVudGlvbmFsbHkgZW5hYmxlIHRoaXMsDQo+ID4+IHBy
b3ZpZGluZyBhIGNoYW5jZSB0byByZWFkIHRoZSB3YXJuaW5nLg0KPiA+Pg0KPiA+PiBbMV0gaHR0
cHM6Ly9naXRodWIuY29tL01pY3Jvc29mdC9tcy10cG0tMjAtcmVmDQo+ID4+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+ID4gDQo+ID4g
TG9va2luZyBhdCBEUkJHXyogZnJvbSBbMV0gSSBkb24ndCBzZWUgYW55dGhpbmcgeW91IGRlc2Ny
aWJlLiBJZiBPUFRFRQ0KPiA+IHdyaXRlcyBOVlJBTSwgIHRoZW4gdGhlIGltcGxlbWVudGF0aW9u
IGlzIGJyb2tlbi4NCj4gPiANCj4gPiBBbHNvIEFGQUlLLCBpdCBpcyBwcmUtc2VlZGVkIHBlciBw
b3dlciBjeWNsZS4gVGhlcmUncyBub3RoaW5nIHRoYXQgZXZlbg0KPiA+IGRpc3RhbnRseSByZWxh
dGVzIG9uIHVzaW5nIE5WUkFNLg0KPiA+IA0KPiA+IFsxXSBodHRwczovL3RydXN0ZWRjb21wdXRp
bmdncm91cC5vcmcvd3AtY29udGVudC91cGxvYWRzL1RQTS0yLjAtMS44My1QYXJ0LTQtU3VwcG9y
dGluZy1Sb3V0aW5lcy1Db2RlLnBkZg0KPiANCj4gSGkgYWxsLA0KPiANCj4gd2UgcmVjZW50bHkg
YWxzbyBzdHVtYmxlZCBvdmVyIHRoaXMgaXNzdWUgd2hpY2ggbGVkIG1lIGhlcmUgdG8gdGhpcyAN
Cj4gdGhyZWFkIGFuZCBtYXliZSBhZGRpbmcgb3VyIG9ic2VydmF0aW9ucyBoZWxwcyB0byBjbGFy
aWZ5IHRoaW5ncyBoZXJlIGEgDQo+IGJpdCAoaG9wZWZ1bGx5KSBvciBhdCBsZWFzdCBhdWdtZW50
cyB0aGUgaW5mb3JtYXRpb24gcmVsYXRlZCB0byBmaXJtd2FyZSANCj4gVFBNIGJhc2VkIGltcGxl
bWVudGF0aW9uIGJhc2VkIG9uIG1zLXRwbS0yMC1yZWYuDQo+IA0KPiBCYXNlZCBvbiB0aGUgb3B0
ZWVfZnRwbSByZXBvLCBhcyBKYW4gYWxyZWFkeSBkZXNjcmliZWQsIHdoaWNoIGN1cnJlbnRseSAN
Cj4gcmVmZXJlbmNlcyBjb21taXQgOThiNjBhNDRhYmE3IG9mIFsxXSBzdWZmZXJzIHRoaXMgZXhh
Y3QgaXNzdWUgYmVjYXVzZSANCj4gb2YgdGhlIE5WX0NMT0NLX1VQREFURV9JTlRFUlZBTCBbMl0g
d2hpY2ggaXMgc2V0IHRvICIxMiIgYW5kIGlzc3VlcyBhIA0KPiB3cml0ZSBmb3IgZWFjaCBjb21t
YW5kIGFmdGVyIH40IHNlY29uZHMgaGF2ZSBwYXNzZWQuDQo+IA0KPiBUaGlzIGNvbmZpZyBoYXMg
YmVlbiBjaGFuZ2VkIHRvICIyMiIgKG9uIGN1cnJlbnQgbWFzdGVyIGJyYW5jaCBbM10pIA0KPiB3
aGljaCBpcyB0aGUgYWxsb3dlZCBtYXhpbXVtIHdoZW4gZm9sbG93aW5nIHRoZSBUUE0gc3BlYyAo
Y2hhcHRlciAzNi4zLjIgDQo+IGluIFs0XSkgd2hpY2ggbGVhZHMgdG8gcm91bmQgYWJvdXQgNzAg
bWludXRlcywgYnV0IG9wdGVlX2Z0cG0gZGlkbid0IA0KPiBtb3ZlIGFoZWFkIHRvIHRoaXMgY29t
bWl0LCB5ZXQuDQo+IFRoaXMgY29uZmlnIGV4aXN0cyBmb3IgYmVpbmcgYWJsZSB0byBhZGFwdCB0
aGUgd3JpdGUgY3ljbGVzIHRvIHRoZSANCj4gc3BlY2lmaWMgd2VhciBjb25kaXRpb25zIG9mIHRo
ZSBoYXJkd2FyZS4NCj4gDQo+IE1vcmVvdmVyIHRoZSBtcy10cG0tMjAtcmVmIHJlcG8gc2VlbXMg
dG8gbm90IGJlIG1haW50YWluZWQgYW55bW9yZSBhbmQgDQo+IG9uZSBzaG91bGQgcmF0aGVyIHN3
aXRjaCB0byBbNl0uDQo+IA0KPiBTbyB0aGVyZSBhcmUgY3VycmVudGx5IGZpcm13YXJlIFRQTSBp
bXBsZW1lbnRhdGlvbnMgb3V0IHRoZXJlIHRoYXQgbGVhZCANCj4gdG8gdGhlc2UgZnJlcXVlbnQg
d3JpdGVzLg0KDQpSZWFsbHkgdGhpcyB3b3VsZCBuZWVkIGEgcHJvZHVjdCBhbmQgb2ZmaWNpYWwg
YnVnIGJ1bGxldGluIGZvciBpdCB0bw0KZXZlbiBjb25zaWRlciBhIHdvcmthcm91bmQuIFNwZWN1
bGF0aW9uIGRvZXMgbm90IGNvdW50Lg0KDQo+IA0KPiBBRkFJSyBzaW5jZSB0aGUgdHBtLTIwLXJl
ZiBpbXBsZW1lbnRhdGlvbiBiYXNpY2FsbHkgb25seSBzdXBwb3J0cyBhIGZpbGUgDQo+IG9uIGRp
c2sgb3IgUkFNIGJhY2tpbmcgc3RvcmFnZSwgdGhlIG9wdGVlX2Z0cG0gcmVwbyBbNV0gcHJvdmlk
ZXMgaXQncyANCj4gb3duIF9wbGF0X05WKiBpbXBsZW1lbnRhdGlvbnMgdGhhdCByZXBsYWNlIHRo
ZSBkZWZhdWx0IG9uZXMgYW5kIGZpbmFsbHkgDQo+IGNhbGwgT1AtVEVFJ3MgVEVFXyogc2VjdXJl
IHN0b3JhZ2UgQVBJLCB3aGljaCB0aGVuIHJvdXRlcyB0byB3aGF0ZXZlciANCj4gYmFja2VuZCBP
UC1URUUgaXMgY29uZmlndXJlZCB3aXRoIChSRUUtRlMgb3IgUlBNQikg4oCTIEluIG91ciBjYXNl
IHRoZSBSUE1CLg0KPiANCj4gQmVjYXVzZSB0aGVyZSBhcmUgY3VycmVudGx5IGltcGxlbWVudGF0
aW9ucyBvdXQgdGhlcmUgKGUuZy4gc3RhcnQgdXNpbmcgDQo+IG9wdGVlX2Z0cG0pIGl0IG1heSBt
YWtlIHNlbnNlIHRvIGFkZCB0aGlzIGluZm9ybWF0aW9uIHRvIHRoZSBrZXJuZWwgDQo+IGNvbmZp
ZydzIGhlbHAgdGV4dCBhdCBsZWFzdD8NCg0KWW91ciBmaXJzdCBmb3J1bSB0byByZXBvcnQgc3Vj
aCBpc3N1ZXMgaXMgdGhlIFRQTSB2ZW5kb3IuDQoNCj4gDQo+IFdlIGFyZSBjdXJyZW50bHkgdHJ5
aW5nIHRvIGJ1bXAgb3B0ZWVfZnRwbSB0byB1c2UgdGhlIG1vcmUgcmVjZW50IHYxLjg0LCANCj4g
YnV0IHNpbmNlIHdlJ3JlIG5vIFRDRyBtZW1iZXIgdGhlIFBScyBvbiBnaXRodWIgY291bGQgZ2V0
IGEgYml0IA0KPiBhZHZlbnR1cm91cyAoUFIncyBub3QgdXBzdHJlYW0sIHlldCkuDQo+IFVudGls
IHRoZW4gdGhpcyBpcyBhIHZhbGlkIGlzc3VlIHRoYXQgZXhpc3RzLi4uDQo+IA0KPiANCj4gWzJd
IA0KPiBodHRwczovL2dpdGh1Yi5jb20vbWljcm9zb2Z0L21zLXRwbS0yMC1yZWYvYmxvYi85OGI2
MGE0NGFiYTc5YjE1ZmNjZTFjMGQxZTQ2Y2Y1OTE4NDAwZjZhL1RQTUNtZC90cG0vaW5jbHVkZS9U
cG1Qcm9maWxlLmgjTDE5OSANCj4gDQo+IA0KPiBbM10gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9t
aWNyb3NvZnQvbXMtdHBtLTIwLXJlZi9ibG9iLzk4YjYwYTQ0YWJhNzliMTVmY2NlMWMwZDFlNDZj
ZjU5MTg0MDBmNmEvVFBNQ21kL3RwbS9pbmNsdWRlL1RwbVByb2ZpbGUuaCNMMjAwDQo+IA0KPiBb
NF0gDQo+IGh0dHBzOi8vdHJ1c3RlZGNvbXB1dGluZ2dyb3VwLm9yZy93cC1jb250ZW50L3VwbG9h
ZHMvVFBNLTIuMC0xLjgzLVBhcnQtMS1BcmNoaXRlY3R1cmUucGRmDQo+IA0KPiBbNV0gaHR0cHM6
Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9mdHBtDQo+IA0KPiBbNl0gaHR0cHM6Ly9naXRodWIu
Y29tL1RydXN0ZWRDb21wdXRpbmdHcm91cC9UUE0NCj4gDQo+IEJSLA0KPiBCZW5lZGlrdA0KPiAN
Cg0KQlIsIEphcmtrbw0K
