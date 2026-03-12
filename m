Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB33FED2F6
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 09:17:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6DB154395C
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773307024;
	bh=IErW45dnTmgcfI2OIFOqwwgUCJNfTNNsPmuh2sOodXs=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=equ0yie2WgxeESG8ONQwgwe/Cn4+l0C7vCLMUnn++uAEjeGVjAaShO3ATy0bgw8WR
	 F8V8sR71y1MiV+dnicx5bTluJP0aZ3+b+ZwBXbsSSRAdBhWjf3unYt/cF3kV/0AiAH
	 8/hiCBcHRTpGqdxSOGzf8Kpso3O1fIAHVPL0J5r4pHgEGxy388UBqwi+Q9tSnCIMeu
	 v9RutAGixT/4YwugJGNUb74rNXi1RWAGCk/Ckg4xTghT3uXY5obafvgDX45j7fYf/3
	 Aut+LlckjTX6LeLnNG+imNDWs9q2egwbb56OeVOE+cxWWAJRzISZdcyRyJvmGZrBwE
	 RytzcMC1T2lMQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7D1364394D
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Mar 2026 09:16:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gGE4GMI6;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B354443DD4;
	Thu, 12 Mar 2026 09:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4259DC4CEF7;
	Thu, 12 Mar 2026 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773307004;
	bh=lyfvvM077w9le67FnkByCAl9dIhHMIvU1tUOdujHQuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGE4GMI6HyITs1CHJ96YXS8e/cVHS8+qIhbhZQ2SStvDWQb8Mpr12XN/Mz2J0h7eB
	 pZu7VAMqjDup1MmxUPSlr+rK6O047C/2v1UY2oSpcgnZutAjtXVvg4xKgD0aKZZ+ZZ
	 Xx/BXbLCLdZuQrNfmMxAbKx7Ix1l2SAb0Nj5/H+0T1heUhNS1Ol9986B2nxl5S1Yq2
	 bhxVkA+ngm0Mg14v8V5TIr1USTw7nzWOxDm+JdZ06lxKPy+ytYpN9FBYc2Ir/8NASO
	 /7pRR7bq+mGpE7U63tLe/iyaOg/MKStCb0aX9pgS9c+jGCuxKaJJMi+I+ulgG5BzsF
	 A73bKM2SXT3lw==
Date: Thu, 12 Mar 2026 14:46:38 +0530
To: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] optee: Check return value of tee_shm_get_va()
Message-ID: <abKEdk6MpkVHBlfi@sumit-xelite>
References: <20260305083312.1040969-1-nichen@iscas.ac.cn>
 <2e15b2b8-7dd4-4e63-b9a9-a664323ebb36@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <2e15b2b8-7dd4-4e63-b9a9-a664323ebb36@web.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7D1364394D
X-Spamd-Bar: -
Message-ID-Hash: R3WWVX6UAU3UJOGBZVJA2P6WWBKHBID6
X-Message-ID-Hash: R3WWVX6UAU3UJOGBZVJA2P6WWBKHBID6
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Chen Ni <nichen@iscas.ac.cn>, op-tee@lists.trustedfirmware.org, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/R3WWVX6UAU3UJOGBZVJA2P6WWBKHBID6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gRnJpLCBNYXIgMDYsIDIwMjYgYXQgMTI6NTI6MzlQTSArMDEwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6DQo+IOKApg0KPiA+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL3JwYy5jDQo+ID4gQEAg
LTM5Myw2ICszOTMsMTEgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3JwY19mdW5jX3JwbWJfZnJhbWVz
KHN0cnVjdCB0ZWVfY29udGV4dCAqY3R4LA0KPiA+ICAJCQkgICAgcGFyYW1zWzBdLnUubWVtcmVm
LnNobV9vZmZzKTsNCj4gPiAgCXAxID0gdGVlX3NobV9nZXRfdmEocGFyYW1zWzFdLnUubWVtcmVm
LnNobSwNCj4gPiAgCQkJICAgIHBhcmFtc1sxXS51Lm1lbXJlZi5zaG1fb2Zmcyk7DQo+ID4gKwlp
ZiAoSVNfRVJSKHAwKSB8fCBJU19FUlIocDEpKSB7DQo+ID4gKwkJYXJnLT5yZXQgPSBURUVDX0VS
Uk9SX0JBRF9QQVJBTUVURVJTOw0KPiA+ICsJCWdvdG8gb3V0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiAgCWlmIChycG1iX3JvdXRlX2ZyYW1lcyhyZGV2LCBwMCwgcGFyYW1zWzBdLnUubWVtcmVmLnNp
emUsIHAxLA0KPiA+ICAJCQkgICAgICBwYXJhbXNbMV0udS5tZW1yZWYuc2l6ZSkpIHsNCj4gPiAg
CQlhcmctPnJldCA9IFRFRUNfRVJST1JfQkFEX1BBUkFNRVRFUlM7DQo+IOKApg0KPiANCj4gSG93
IGRvIHlvdSB0aGluayBhYm91dCB0byB1c2UgYW4gYWRkaXRpb25hbCBsYWJlbCBmb3IgdGhlIHNo
b3duDQo+IGVycm9yIGNvZGUgYXNzaWdubWVudD8NCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRh
dGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5yc3Q/aD12Ny4wLXJjMiNuNTI2DQo+DQoNCkkgc3Vw
cG9zZSBoZXJlIHlvdSBtZWFudCB0byB1cGRhdGUgdGhlIGxhYmVsIG5hbWUgc2luY2UgaXQncyB0
aGUgc2FtZQ0KZXJyb3IgdHlwZSB1c2VkIGJ5IG90aGVyIGNvZGUgcGF0aHMgdG9vLiBTbyBmb2xs
b3dpbmcgbGFiZWwgcmVuYW1lDQpzaG91bGQgYmUgZmluZSBJIHRoaW5rIGFzIHBlciBjb2Rpbmcg
Z3VpZGVsaW5lczoNCg0Kcy9vdXQvZXJyX2Rldl9wdXQvDQoNCi1TdW1pdA0K
