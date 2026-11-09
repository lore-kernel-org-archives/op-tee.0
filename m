Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998E606A31C
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=x7aZi8m2;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5wUT9KM
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C0DA7454FC
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 06:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794205666;
	bh=8wi3Y6qkiJMih9oqU0MoIPfoEo2l1xMyFypHqGsFXxw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=x7aZi8m2d1FhCMB9Q9eY43IvMocWdzZp2Pv/jyKm0cM4O1fsMzejt2fUrgA5/fQF2
	 FMchuVKJKIwlSnVtOpucCJ0iS8say8tDfOYL0pvjA0Xlxf0g9rOpqI0BIcTBBqEjOg
	 HOU8L+1jCJYS968dFeJ5aFlJGE9XHI8GxrMFd56rBnDKUoX2rQlwCDw2U/rWUG8NEr
	 bvt7E9tRDMoirAKmXRodph/Bmuku0ulcrolyrRzNOd7xaQKAbobPSyUZRzktE0S4Bi
	 ClgOXhy5dhW4nbyaHDe6FJvDNqDmajjrQEyZZGzu8Ur/QrCsXnCGkMQy28WFI5PIS1
	 a9hLWjCAYD1Gw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7708444DA3
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Nov 2026 06:27:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5wUT9KM;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B2934304A;
	Mon,  9 Nov 2026 06:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0968B1F0089F;
	Mon,  9 Nov 2026 06:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794205647;
	bh=1LuLFUmvB7Uxv5vtQr8Gi7eE2ebp9fpE+myiUoa3eng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I5wUT9KM6pas7Qt3UYvT9E6yOd8Zd7HUkUZoGH90AtOkyPTgw4MVb5WCGe6Sy63xL
	 6qmTrDMoj27dk/d3CV5iC9wOMo46zpeHg6beYoj3zY1Zav1aGHZk6u1iP7N+8nygMI
	 NT8zY9ElkHrEnJqoaSjeCf+nD1gYGuBNKzf2rs/w6368qNzXS8WialmakudKCAZBDR
	 +HvGOI3ez6FVkARBCG5lui2tgoAmbOvJpBftEiscIqwTzPPkVIyhA1MUfAmpbsrV3X
	 tjsYhZdIWbteaToaekBAoAa38sOVgwznY6xVJ5hgacnMb72bE2e+dEj3Sb+DNdrB9X
	 TWLsYVtVloXUw==
Date: Mon, 9 Nov 2026 11:57:21 +0530
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Subject: Re: [PATCH] tee: avoid accessing dma-buf shared memory after put
Message-ID: <avFnybu7UDEdva94@sumit-xelite>
References: <20260806060727.191-1-getshell@seu.edu.cn>
 <CAGgiveVEiVqxVO-B0kxW9uCb43g2ocs1bgEZLWpVq=+AERaevA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAGgiveVEiVqxVO-B0kxW9uCb43g2ocs1bgEZLWpVq=+AERaevA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7708444DA3
X-Spamd-Bar: ---------
Message-ID-Hash: 6JD2KVVD4NPAKTFJWWKXKCSEMTOSCRO4
X-Message-ID-Hash: 6JD2KVVD4NPAKTFJWWKXKCSEMTOSCRO4
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Hongyan Xu <getshell@seu.edu.cn>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Olivier Masse <olivier.masse@nxp.com>, Etienne Carriere <etienne.carriere@foss.st.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6JD2KVVD4NPAKTFJWWKXKCSEMTOSCRO4/>
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

T24gVGh1LCAwNSBOb3YgMjAyNiBhdCAxMzo1Njo1MSArMDEwMCwgSmVucyBXaWtsYW5kZXIgd3Jv
dGU6DQo+SGksDQo+DQo+T24gVGh1LCBBdWcgNiwgMjAyNiBhdCA4OjA34oCvQU0gSG9uZ3lhbiBY
dSA8Z2V0c2hlbGxAc2V1LmVkdS5jbj4gd3JvdGU6DQo+Pg0KPj4gcGFyYW1fZnJvbV91c2VyX21l
bXJlZigpIG9idGFpbnMgYSB0ZW1wb3JhcnkgcmVmZXJlbmNlIHRvIHRoZSBkbWEtYnVmDQo+PiB0
ZWVfc2htIHdyYXBwZXIgYnkgSUQuIElmIGNsb3NpbmcgdGhlIHNoYXJlZC1tZW1vcnkgZmlsZSBk
ZXNjcmlwdG9yIHJhY2VzDQo+PiB3aXRoIHRoZSBpb2N0bCwgdGhpcyB0ZW1wb3JhcnkgcmVmZXJl
bmNlIGNhbiBiZSB0aGUgd3JhcHBlcidzIGxhc3Qgb25lLg0KPj4gdGVlX3NobV9wdXQoKSB0aGVu
IGZyZWVzIHRoZSBlbmNsb3NpbmcgdGVlX3NobV9kbWFidWZfcmVmLCBidXQgdGhlIGZ1bmN0aW9u
DQo+PiBzdGlsbCByZWFkcyByZWYtPnBhcmVudF9zaG0gYW5kIHJlZi0+b2Zmc2V0IGFmdGVyd2Fy
ZHMuDQo+Pg0KPj4gU2F2ZSB0aGUgcGFyZW50IHBvaW50ZXIgYW5kIG9mZnNldCBiZWZvcmUgZHJv
cHBpbmcgdGhlIHdyYXBwZXIgcmVmZXJlbmNlLg0KPj4gVGhlIGFkZGl0aW9uYWwgcGFyZW50IHJl
ZmVyZW5jZSBrZWVwcyB0aGUgcGFyZW50IHNoYXJlZCBtZW1vcnkgYWxpdmUgZm9yDQo+PiB0aGUg
cGFyYW1ldGVyIGxpc3QgYXMgYmVmb3JlLg0KPj4NCj4+IEZpeGVzOiAxNDZiZjRlNzVlY2EgKCJ0
ZWU6IG5ldyBpb2N0bCB0byBhIHJlZ2lzdGVyIHRlZV9zaG0gZnJvbSBhIGRtYWJ1ZiBmaWxlIGRl
c2NyaXB0b3IiKQ0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYt
Ynk6IEhvbmd5YW4gWHUgPGdldHNoZWxsQHNldS5lZHUuY24+DQo+PiAtLS0NCj4+ICBkcml2ZXJz
L3RlZS90ZWVfY29yZS5jIHwgOCArKysrKy0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVl
L3RlZV9jb3JlLmMgYi9kcml2ZXJzL3RlZS90ZWVfY29yZS5jDQo+PiBpbmRleCAxYWFjNTBjN2Mx
ZGUuLjQ4OWMzOWQ1YjM1ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMNCj4+IEBAIC0zOTcsNiArMzk3LDcgQEAg
c3RhdGljIGludCBwYXJhbV9mcm9tX3VzZXJfbWVtcmVmKHN0cnVjdCB0ZWVfY29udGV4dCAqY3R4
LA0KPj4gICAgICAgICAgICAgICAgIH0NCj4+DQo+PiAgICAgICAgICAgICAgICAgaWYgKHNobS0+
ZmxhZ3MgJiBURUVfU0hNX0RNQV9CVUYpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCB0ZWVfc2htICpwYXJlbnRfc2htOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHRlZV9zaG1fZG1hYnVmX3JlZiAqcmVmOw0KPj4NCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlZiA9IGNvbnRhaW5lcl9vZihzaG0sIHN0cnVjdCB0ZWVfc2htX2RtYWJ1Zl9yZWYsIHNo
bSk7DQo+PiBAQCAtNDA5LDEwICs0MTAsMTEgQEAgc3RhdGljIGludCBwYXJhbV9mcm9tX3VzZXJf
bWVtcmVmKHN0cnVjdCB0ZWVfY29udGV4dCAqY3R4LA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKiBsaXN0IGluc3RlYWQgb2YgdGhlIHNobSB3ZSBnb3Qgd2l0aA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiB0ZWVfc2htX2dldF9mcm9tX2lkKCkgYWJv
dmUuDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZWZjb3VudF9pbmMoJnJlZi0+cGFyZW50X3NobS0+cmVm
Y291bnQpOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZWVfc2htX3B1dChz
aG0pOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaG0gPSByZWYtPnBhcmVu
dF9zaG07DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9zaG0gPSBy
ZWYtPnBhcmVudF9zaG07DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9mZnMg
PSByZWYtPm9mZnNldDsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVmY291
bnRfaW5jKCZwYXJlbnRfc2htLT5yZWZjb3VudCk7DQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHRlZV9zaG1fcHV0KHNobSk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNobSA9IHBhcmVudF9zaG07DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+
PiAgICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgICB9IGVsc2UgaWYgKGN0eC0+Y2FwX21lbXJl
Zl9udWxsKSB7DQo+PiAtLQ0KPj4gMi41MC4xLndpbmRvd3MuMQ0KPj4NCj4NCj5Mb29rcyBnb29k
LiBTdW1pdCwgZG8geW91IGFncmVlPw0KPg0KDQpTb3VuZHMgcmVhc29uYWJsZSB0byBtZSwgRldJ
VzoNCg0KUmV2aWV3ZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNv
bT4NCg0KLVN1bWl0DQo=
