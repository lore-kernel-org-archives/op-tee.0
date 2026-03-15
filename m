Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F15ED58B0E
	for <op-tee@archiver.kernel.org>; Sun, 15 Mar 2026 05:02:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CE8D943959
	for <op-tee@archiver.kernel.org>; Sun, 15 Mar 2026 05:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773550961;
	bh=xQ6MZVB/3zExDREkvTUaajHokVFRDIvOoon2dBy4krY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XiHib360Jv641y45KMAIJN6IOVn4QsDq6qqdxbfQjlrS/mW0lxpFaAbr47xI1n7XP
	 KkONEf+04W4kABssc+6jsKbqJkI6mz6E8qhSHBwXM0XEbXbz8gxm6vEJ+FlEc7L9aF
	 YGGxVouAUzq+REEnXNr+zxxC6WLz7BWqTEqyTmcZOoaA0gNZVbtszgYfwQ/tgme0V1
	 GPNMDLyS+yfZ6W51Tjcvu8Y7v6F9E9mc09ImlZECsID0LK4krVUwpVMtGACPli70rf
	 EO7QRTxz2UzXS0x5zgzCdkniCcyr2AJeJxF1rhIAEgzfkymdna+IN7iIlPDYpo8qjK
	 EImQZntP3mADg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 477754373C
	for <op-tee@lists.trustedfirmware.org>; Sun, 15 Mar 2026 05:02:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u7ZgeCv9;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C1F1960018;
	Sun, 15 Mar 2026 05:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427FDC4CEF7;
	Sun, 15 Mar 2026 05:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773550941;
	bh=y/qPg1BOLvx4bG6IThJrAhMyZd/utCNU//A3HXcgTNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7ZgeCv9fBLbkIaWg5hUsa9LZLq5L/z1fCEpaPAZJ31/l9L1EpVWk40Brbyxt+E9W
	 gm9Ipp3yLCKFsp2J8f0A1XWN4UyQ7q9V5rhTr8eXtCyatOQd3bVjieTLpcEDaZCU06
	 JZbqDPbLL10cqYKB+gIZNk09jCK5A29Hj2r7gDo71q16hZkMk9+60JADwYc2OuK3RU
	 5j5yizvjsVRcE8Fv+wKKlU51D5O2RnHZS69kWLaL1SBSaSb+QP2HeqIhM3k+pMNnWq
	 Nuhj35OewMqm00DrASH6FJ1RCImdvC1JrjDO7d+0J+LasAjUz2mB0F5+K3i+BHtoN7
	 qDp/QszNKmyfw==
Date: Sun, 15 Mar 2026 10:32:16 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH] optee: Check return value of tee_shm_get_va()
Message-ID: <abY9WIm2z29SvJeG@sumit-xelite>
References: <20260305083312.1040969-1-nichen@iscas.ac.cn>
 <2e15b2b8-7dd4-4e63-b9a9-a664323ebb36@web.de>
 <abKEdk6MpkVHBlfi@sumit-xelite>
 <CAHUa44GkZ3jgJg=s+a4RnvMggCxu+mVhU=0z3BKWGkHqDKGaSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44GkZ3jgJg=s+a4RnvMggCxu+mVhU=0z3BKWGkHqDKGaSQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[web.de,iscas.ac.cn,lists.trustedfirmware.org,vger.kernel.org,linaro.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from,100.75.92.58:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 477754373C
X-Spamd-Bar: --
Message-ID-Hash: GPK3TSKHCBHVQHAWWOI4BJT3PQFHM65N
X-Message-ID-Hash: GPK3TSKHCBHVQHAWWOI4BJT3PQFHM65N
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Markus Elfring <Markus.Elfring@web.de>, Chen Ni <nichen@iscas.ac.cn>, op-tee@lists.trustedfirmware.org, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GPK3TSKHCBHVQHAWWOI4BJT3PQFHM65N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gVGh1LCBNYXIgMTIsIDIwMjYgYXQgMTI6MTY6MTFQTSArMDEwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IE9uIFRodSwgTWFyIDEyLCAyMDI2IGF0IDEwOjE24oCvQU0gU3VtaXQgR2FyZyA8
c3VtaXQuZ2FyZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgTWFyIDA2LCAy
MDI2IGF0IDEyOjUyOjM5UE0gKzAxMDAsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOg0KPiA+ID4g4oCm
DQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL3JwYy5jDQo+ID4gPiA+IEBAIC0zOTMs
NiArMzkzLDExIEBAIHN0YXRpYyB2b2lkIGhhbmRsZV9ycGNfZnVuY19ycG1iX2ZyYW1lcyhzdHJ1
Y3QgdGVlX2NvbnRleHQgKmN0eCwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcGFy
YW1zWzBdLnUubWVtcmVmLnNobV9vZmZzKTsNCj4gPiA+ID4gICAgIHAxID0gdGVlX3NobV9nZXRf
dmEocGFyYW1zWzFdLnUubWVtcmVmLnNobSwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgcGFyYW1zWzFdLnUubWVtcmVmLnNobV9vZmZzKTsNCj4gPiA+ID4gKyAgIGlmIChJU19FUlIo
cDApIHx8IElTX0VSUihwMSkpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgYXJnLT5yZXQgPSBURUVD
X0VSUk9SX0JBRF9QQVJBTUVURVJTOw0KPiA+ID4gPiArICAgICAgICAgICBnb3RvIG91dDsNCj4g
PiA+ID4gKyAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiAgICAgaWYgKHJwbWJfcm91dGVfZnJhbWVz
KHJkZXYsIHAwLCBwYXJhbXNbMF0udS5tZW1yZWYuc2l6ZSwgcDEsDQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcGFyYW1zWzFdLnUubWVtcmVmLnNpemUpKSB7DQo+ID4gPiA+ICAg
ICAgICAgICAgIGFyZy0+cmV0ID0gVEVFQ19FUlJPUl9CQURfUEFSQU1FVEVSUzsNCj4gPiA+IOKA
pg0KPiA+ID4NCj4gPiA+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gdXNlIGFuIGFkZGl0aW9u
YWwgbGFiZWwgZm9yIHRoZSBzaG93bg0KPiA+ID4gZXJyb3IgY29kZSBhc3NpZ25tZW50Pw0KPiA+
ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFs
ZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5yc3Q/
aD12Ny4wLXJjMiNuNTI2DQo+ID4gPg0KPiA+DQo+ID4gSSBzdXBwb3NlIGhlcmUgeW91IG1lYW50
IHRvIHVwZGF0ZSB0aGUgbGFiZWwgbmFtZSBzaW5jZSBpdCdzIHRoZSBzYW1lDQo+ID4gZXJyb3Ig
dHlwZSB1c2VkIGJ5IG90aGVyIGNvZGUgcGF0aHMgdG9vLiBTbyBmb2xsb3dpbmcgbGFiZWwgcmVu
YW1lDQo+ID4gc2hvdWxkIGJlIGZpbmUgSSB0aGluayBhcyBwZXIgY29kaW5nIGd1aWRlbGluZXM6
DQo+ID4NCj4gPiBzL291dC9lcnJfZGV2X3B1dC8NCj4gDQo+IFdvdWxkbid0IHRoZSBuYW1lIGVy
cl9kZXZfcHV0IHN1Z2dlc3QgdGhpcyBvbmx5IG9jY3VycyBpbiB0aGUgZXJyb3IgcGF0aD8NCj4g
DQoNCk9rYXksIGxldCByYXRoZXIgcmVuYW1lIGl0IHRvIG91dF9kZXZfcHV0Lg0KDQotU3VtaXQN
Cg==
