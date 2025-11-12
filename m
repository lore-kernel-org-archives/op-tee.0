Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A2BCCFA1A
	for <op-tee@archiver.kernel.org>; Wed, 12 Nov 2025 07:48:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 48C8050011
	for <op-tee@archiver.kernel.org>; Wed, 12 Nov 2025 07:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1762933683;
	bh=N6JCmfYkbQUw1IBVSM3W7jU7epVXNcgM/69afEGP1xM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=4RzW7IrL4H77OKW+DfOGrJ9fgl9PhJC1itI+1j+bjhfLcLHiJA7KN6w8a4CysJDId
	 bVy8T8bMU0aZPezvd+U9QnYWXrsj/rJ7A8Ir10k2RGh6A6nxwjX4OC/gX0kofmGSwQ
	 CIhSpuWA3DjKkEIksMfS5H75drnKkp+nYsNr3/VRLj8boz9BnwDhLmETpiNLOlWnzs
	 sTXutlgPxkGk/FnltsYAiNHD9NybeOXOnZsrxjhV+1xnHSJ+bq8b11o0sitD2vCP50
	 BvUgB6MkcvieplvY5tlQSiEMwzaRmypcEUblWyLeaEbN214qzbi6GiQjj3/5s2aBKi
	 i6Q5sJ+WeJ2Xw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7E48C42F78
	for <op-tee@lists.trustedfirmware.org>; Wed, 12 Nov 2025 07:47:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nhevclJV;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D672043842;
	Wed, 12 Nov 2025 07:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BFFC116B1;
	Wed, 12 Nov 2025 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762933671;
	bh=mgG2cga3vOSOw5eVcByKf/McYLnyjoG+CFxD6KiL1t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhevclJV590a7RcnoXuHHqzi/q/upHhaiKbpulS82dYcEl6z2cgVL1eLF/2UdyDkP
	 Bdf8B21c1Q/YgzpQlIKEP13ZoDR/vYeHNQyG8UnH+W8S1ePeelfXxEAWrz9Ll8UVEu
	 nkau1eBsQ5p0ub5IaC0B3RjR4Xk/N/y/1tmpqndv/8i0B93fOWBHnA5rH/p/CFHDOe
	 1B2K5vMY7et0+DQSmkEX6vY2hDrXO7dTTmNtgQIqT1+slnUVMP2aw6XBMlfPpWC38c
	 1KuoCnsDuORxs+3Uf6bhPMzyVmAZYbfVIgNnDUpIO2Bwg+s0FMKndwpYibYSkVu3X3
	 gsajP5+64AG1A==
Date: Wed, 12 Nov 2025 13:17:46 +0530
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH] tee: qcom: initialize result before use in release worker
Message-ID: <aRQ7osB9rElutHuv@sumit-X1>
References: <20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com>
 <aRLcO7dveqChPNb0@sumit-X1>
 <2ec200e4-cf28-4881-837b-4455da047619@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <2ec200e4-cf28-4881-837b-4455da047619@oss.qualcomm.com>
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7E48C42F78
X-Spamd-Result: default: False [-4.66 / 15.00];
	BAYES_HAM(-2.16)[95.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: CVO3XZWVYJK4FKRFUB3AYWIDSJOVFC6G
X-Message-ID-Hash: CVO3XZWVYJK4FKRFUB3AYWIDSJOVFC6G
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CVO3XZWVYJK4FKRFUB3AYWIDSJOVFC6G/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gV2VkLCBOb3YgMTIsIDIwMjUgYXQgMDY6NDI6MDRBTSArMTEwMCwgQW1pcnJlemEgWmFycmFi
aSB3cm90ZToNCj4gSGkgU3VtaXQsDQo+IA0KPiBPbiAxMS8xMS8yMDI1IDU6NDggUE0sIFN1bWl0
IEdhcmcgd3JvdGU6DQo+ID4gT24gTW9uLCBOb3YgMTAsIDIwMjUgYXQgMDE6Mjg6MzJQTSAtMDgw
MCwgQW1pcnJlemEgWmFycmFiaSB3cm90ZToNCj4gPiANCj4gPiBGb3IgdGhlIHN1YmplY3QgcHJl
Zml4IGxldHMgdHJ5IHRvIGZvbGxvdyB0aGUgZGlyZWN0b3J5IHN0cnVjdHVyZToNCj4gPiANCj4g
PiB0ZWU6IHFjb210ZWU6IC4uLg0KPiA+IA0KPiANCj4gSSBiZWxpZXZlIHdlIHByZXZpb3VzbHkg
YWdyZWVkIG9uIHVzaW5nIHRlZTogcWNvbTogYmFzZWQgb24gdGhlIHJldmlld2Vy4oCZcw0KPiBj
b21tZW50cy4gQ3VycmVudGx5LCB0aGVyZeKAmXMgbm8gY29tbWl0IG1lc3NhZ2Ugd2l0aCBxY29t
dGVlOi4NCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29wLXRlZS80cmJmcHVic2F4Z3Yy
YnVrc29uZmlnYmRrdzZnZWFzNmw3cHljeHV1a2R5bXFmb2hnYUBvaGQ0aHF6dnJhM3cvDQo+IA0K
DQpZZWFoIEkgYWdyZWUgSSBoYXZlbid0IGJlZW4gdG9vIHBpY2t5IGFib3V0IGl0IGVhcmxpZXIg
YnV0IGxldHMgZm9sbG93IGENCmNvbW1vbiBwcmFjdGljZSB3aGljaCBvdGhlciBURUVzIGFsc28g
dXNlcyBiYXNlZCBvbiBkaXJlY3Rvcnkgc3RydWN0dXJlIGxpa2U6DQoNCi0gdGVlOiBvcHRlZToN
Ci0gdGVlOiBhbWR0ZWU6DQotIHRlZTogdHN0ZWU6DQotIHRlZTogcWNvbXRlZToNCg0KLVN1bWl0
DQo=
