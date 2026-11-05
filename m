Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C8606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=Y7uVZ/jK;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7YPv1U1
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 80D3B4548F
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793880855;
	bh=yiM2RvUYqep3sIGcLMsIdEoVqHkybw6KibiH2nPo4G8=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Y7uVZ/jKokPWkoG/QBiiKNMiC3pm7b9B4tV20EEPEUjZy2cF/MeH+55yZISJ71kVE
	 4kZAYJo2GJDA/fueqHAPhfi2CCZIdP7agrCa3VRUlVxRWS75I4AGQ461+ce6G/5dG2
	 iVMYGpi1MELzDaIow9bKHsX/Nllwpch3AZViEm9SIM6ArRrZp4XRDlCBfzKSomog0S
	 XthJ2nxFC2WS6+r8D9ZmGWoxUMbvoBzgwHlh9P2IGMg5+FB0KDcJh2EP0MEoAJPf2m
	 LR1QJg6B1HUY5ydrJlHAyBFc2IlKH+4XhRN1DqGlNhATVmw5U0+kArjgiPtfeI2f4g
	 fHOmhWVgBedXA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E497945462
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 12:13:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7YPv1U1;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7296B60267;
	Thu,  5 Nov 2026 12:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E5C1F000C1;
	Thu,  5 Nov 2026 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880836;
	bh=DsqgM0QBvrYpfH6mPkHRfI27cBP6lloybws40MK/kXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y7YPv1U168Z/wd7J4xYpngNS5hX7ML71bjwp3Izn2bQqqQ4obuvA3rmaFa03VMkzw
	 L4RbiRYzrnFiAguLYnitjWD0QX1Vh42s/IFGaKaf9flEThRcJNI5arvUARepwpnIIL
	 qZXToYJLvw9vnhQItEMfWSVB5wd+GcHH55TpZCVHWNq3RAUKCb3iJRh6rBj6qWP5QH
	 k0F5mvzZcvmCtlrDPf4LQDBRHGr6Cy3d7e1H7/nSPsn0F1xxhb8ths0yNEWYD/j4xS
	 kVAdgEoyNEZjUha53+CI0InOFE/L69Zz2KFw+Bi0az2nj1zD4it3f/YMw2Z+0tNeQq
	 cdQO2ASRQjqxQ==
Date: Thu, 5 Nov 2026 17:43:50 +0530
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Subject: Re: [PATCH] tee: shm: don't warn on an oversized page array in
 register_shm_helper()
Message-ID: <auxy_pv57awSTf2m@sumit-xelite>
References: <20261023210238.551855-1-g.osokin@auroraos.dev>
 <CAGgiveXkWxrdeRYCxBC9X0eQSUAAxF5N+ioe3iM6GZ=pSqHHeg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAGgiveXkWxrdeRYCxBC9X0eQSUAAxF5N+ioe3iM6GZ=pSqHHeg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E497945462
X-Spamd-Bar: --------
Message-ID-Hash: WX2W2APHWOCCFK52Z4XKDKOPFIBYYJ5F
X-Message-ID-Hash: WX2W2APHWOCCFK52Z4XKDKOPFIBYYJ5F
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Georgiy Osokin <g.osokin@auroraos.dev>, Sumit Garg <sumit.garg@kernel.org>, Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WX2W2APHWOCCFK52Z4XKDKOPFIBYYJ5F/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAwMyBOb3YgMjAyNiBhdCAxOTozNDowOCArMDEwMCwgSmVucyBXaWtsYW5kZXIgd3Jv
dGU6DQo+SGksDQo+DQo+T24gRnJpLCBPY3QgMjMsIDIwMjYgYXQgMTE6MDPigK9QTSBHZW9yZ2l5
IE9zb2tpbiA8Zy5vc29raW5AYXVyb3Jhb3MuZGV2PiB3cm90ZToNCj4+DQo+PiByZWdpc3Rlcl9z
aG1faGVscGVyKCkgc2l6ZXMgc2htLT5wYWdlcyBmcm9tIHRoZSBsZW5ndGggcGFzc2VkIHRvDQo+
PiBURUVfSU9DX1NITV9SRUdJU1RFUiBhbmQgYWxsb2NhdGVzIGl0IHdpdGgga3phbGxvY19vYmpz
KCkuIEEgbGVuZ3RoIGFib3ZlDQo+PiAyIEdpQiBtYWtlcyB0aGUgYXJyYXkgbGFyZ2VyIHRoYW4g
dGhlIHBhZ2UgYWxsb2NhdG9yIGNhbiBzZXJ2ZSBpbiBvbmUNCj4+IGJsb2NrIChNQVhfUEFHRV9P
UkRFUiksIHNvIGl0IHRyaXBzIGl0cyBvcmRlciB3YXJuaW5nOyBvbiBhIHBhbmljX29uX3dhcm4N
Cj4+IGtlcm5lbCB0aGF0IGlzIGEgcGFuaWMuDQo+Pg0KPj4gVGhlIHNpemUgY29tZXMgZnJvbSB1
c2Vyc3BhY2UgYW5kIHRoZSByZXF1ZXN0IGZhaWxzIHdpdGggLUVOT01FTSBhbnl3YXksDQo+PiBz
byBwYXNzIF9fR0ZQX05PV0FSTi4ga3Z6YWxsb2Nfb2JqcygpIHdvdWxkIG5vdCBoZWxwIHNpbmNl
IGt2bWFsbG9jDQo+PiB3YXJucyBhYm92ZSBJTlRfTUFYIGFzIHdlbGwuDQo+Pg0KPj4gRml4ZXM6
IDAzM2RkZjEyYmNmNSAoInRlZTogYWRkIHJlZ2lzdGVyIHVzZXIgbWVtb3J5IikNCj4+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+PiBDYzogbHZjLXByb2plY3RAbGludXh0ZXN0aW5nLm9y
Zw0KPj4gU2lnbmVkLW9mZi1ieTogR2VvcmdpeSBPc29raW4gPGcub3Nva2luQGF1cm9yYW9zLmRl
dj4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvdGVlL3RlZV9zaG0uYyB8IDMgKystDQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3RlZS90ZWVfc2htLmMgYi9kcml2ZXJzL3RlZS90ZWVfc2htLmMNCj4+IGlu
ZGV4IDY3NDJiMzUuLmQ1Mzk5ODggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3RlZS90ZWVfc2ht
LmMNCj4+ICsrKyBiL2RyaXZlcnMvdGVlL3RlZV9zaG0uYw0KPj4gQEAgLTQzOCw3ICs0MzgsOCBA
QCByZWdpc3Rlcl9zaG1faGVscGVyKHN0cnVjdCB0ZWVfY29udGV4dCAqY3R4LCBzdHJ1Y3QgaW92
X2l0ZXIgKml0ZXIsIHUzMiBmbGFncywNCj4+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9mcmVl
X3NobTsNCj4+ICAgICAgICAgfQ0KPj4NCj4+IC0gICAgICAgc2htLT5wYWdlcyA9IGt6YWxsb2Nf
b2Jqcygqc2htLT5wYWdlcywgbnVtX3BhZ2VzKTsNCj4+ICsgICAgICAgc2htLT5wYWdlcyA9IGt6
YWxsb2Nfb2Jqcygqc2htLT5wYWdlcywgbnVtX3BhZ2VzLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEdGUF9LRVJORUwgfCBfX0dGUF9OT1dBUk4pOw0KPj4gICAgICAgICBp
ZiAoIXNobS0+cGFnZXMpIHsNCj4+ICAgICAgICAgICAgICAgICByZXQgPSBFUlJfUFRSKC1FTk9N
RU0pOw0KPj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfc2htOw0KPj4NCj4+IGJhc2Ut
Y29tbWl0OiA3MmQzZmNmODAyYzQ1ZDAwYjMwMGYyNWI4NDhhOTNjM2EyYmQ3YzdlDQo+PiAtLQ0K
Pj4gMi41NC4wDQo+Pg0KPg0KPkxvb2tzIGdvb2QuIFN1bWl0LCBkbyB5b3UgYWdyZWU/DQoNClll
YWgsIGZlZWwgZnJlZSB0byBhZGQ6DQoNClJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5n
YXJnQG9zcy5xdWFsY29tbS5jb20+DQoNCi1TdW1pdA0K
