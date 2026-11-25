Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D7606A32A
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=vrW2RY5M;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsAtUa/G
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 830D950351
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 12:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795609534;
	bh=uWaPTDnqzYvbs30hsFpV8WdSLXz8Pvz3FDIsrfI2x7g=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=vrW2RY5MGAh7l0w4hTo39ALuYxLc5l3Fpv74mGuLsnH4M0CBTvtQAQXBqEEtGjHEQ
	 wcx3TbkbJ6KppLhXYJl9mnvO04DjyIZi8ZKxL7q1HriZLm3NQXHptm7x9DaC/ns2Gc
	 Zg4/BM5Ddn7I6PbWXAY7ncIPLNEL7EgiI7psI1nW/2rvX5fS91pgn6CuEP6vGFjzzc
	 d489+NDU5GZjizgIbUtYJkJ6y2j2YRdqR992jlHBbfHTtWslaWlXPMsJ2ibki8f11e
	 ON1uaNDgaO4uGdpNY7r7QC946NwXIppm6ts2FlJ6JTC8vYxtlCqhsW4QHk9vDpkIf/
	 56nsqknYrKmCw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 29A8B44E87
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Nov 2026 12:25:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsAtUa/G;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 695E7414CC;
	Wed, 25 Nov 2026 12:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0A01F000C4;
	Wed, 25 Nov 2026 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795609529;
	bh=3cweuxzJfLVp8WrEgRssiB6rvSwpbNFQB7nXvM8QjKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fsAtUa/GQdQKpLbKezuab3FKplO/4Br2NkD1n89RJ3iMTdAoahkjWcJPXxsWSi8Wn
	 nog33ezhVCvuu48Sy1UIvbrcI+h0DITF0u6TB6jjgYt6AREaUSjDecjOli1Y9HGfQL
	 MizGA3CxHe+oYjhf93JzEMDPhBDu12qXci6pRTgNGKFjoRGFQvHEXrj9CzPd6deYZv
	 WOyqwuXcpUGVFE1RR2X2B3qcgZX6xWSlR5aZ47sRkqXMDnVGACkc2FQ1yquoI5VcaV
	 FhkVHdWU5mUUi5C5qR8Yn7i8/rjxYcdBzVCmcIeoxKzjpBTTtWoQP5oOPlov7b5yNy
	 4+ey9tleeRBCg==
Date: Wed, 25 Nov 2026 17:55:23 +0530
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Subject: Re: [PATCH] tee: shm: sync DMA memory for the device before it is
 lent
Message-ID: <awbTs4Ad041c1AjO@sumit-xelite>
References: <20261113-tee-shm-dma-sync-v1-1-19d4efdfb4cd@oss.qualcomm.com>
 <CAGgiveWm-xH_SjA5QrBJx6NtQhWyQWMw2FvfSd9SfG-wghpwmw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAGgiveWm-xH_SjA5QrBJx6NtQhWyQWMw2FvfSd9SfG-wghpwmw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 29A8B44E87
X-Spamd-Bar: ---------
Message-ID-Hash: FANUZ7PFX3GF2PVXLKLD7KSMXLWAYTBY
X-Message-ID-Hash: FANUZ7PFX3GF2PVXLKLD7KSMXLWAYTBY
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Tyler Baker <tyler.baker@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FANUZ7PFX3GF2PVXLKLD7KSMXLWAYTBY/>
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

T24gVHVlLCAyNCBOb3YgMjAyNiBhdCAwOTo1MjowMCArMDEwMCwgSmVucyBXaWtsYW5kZXIgd3Jv
dGU6DQo+SGksDQo+DQo+T24gRnJpLCBOb3YgMTMsIDIwMjYgYXQgMjoyMuKAr1BNIFR5bGVyIEJh
a2VyDQo+PHR5bGVyLmJha2VyQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPj4NCj4+IHRlZV9z
aG1fYWxsb2NfZG1hX21lbSgpIHJldHVybnMgZG1hX2FsbG9jX3BhZ2VzKCkgbWVtb3J5IHdpdGhv
dXQgdGhlDQo+PiBkbWFfc3luY19zaW5nbGVfZm9yX2RldmljZSgpIHRoYXQgdGhlIERNQSBBUEkg
cmVxdWlyZXMgYmVmb3JlIGEgZGV2aWNlDQo+PiB1c2VzIGl0LiBkbWFfYWxsb2NfcGFnZXMoKSB6
ZXJvZXMgdGhlIHBhZ2VzIHRocm91Z2ggdGhlIGNhY2hlYWJsZQ0KPj4gbGluZWFyIG1hcCwgc28g
dGhlIHplcm9lcyBjYW4gc3RpbGwgYmUgZGlydHkgaW4gdGhlIGNhY2hlIHdoZW4gdGhlDQo+PiBv
cHRlZSBwcm90ZWN0ZWQgbWVtb3J5IHBvb2wgbGVuZHMgdGhlIHBhZ2VzIGFuZCBhIFNlY3VyZSBE
YXRhIFBhdGggVEENCj4+IHdyaXRlcyB0aGVtIHRocm91Z2ggaXRzIHNlY3VyZSBtYXBwaW5nLiBB
IGxhdGVyIGV2aWN0aW9uIG9mIHRob3NlDQo+PiBsaW5lcyBvdmVyd3JpdGVzIHRoZSBUQSdzIGRh
dGEuDQo+Pg0KPj4gT24gYW4gRWxpemEgRVZLIHdpdGggT1AtVEVFIGFzIHRoZSBGRi1BIFNQTUMs
IGEgVEEgZGVjcnlwdHMgaW50byBhDQo+PiBwcm90ZWN0ZWQgYnVmZmVyLCBhIHJlYWQgb2YgYWxs
IFJBTSB0aHJvdWdoIC9wcm9jL2tjb3JlIGV2aWN0cyB0aGUNCj4+IGxpbmVzLCBhbmQgdGhlIFRB
J3MgZGlnZXN0IG9mIHRoZSBidWZmZXIgbm8gbG9uZ2VyIG1hdGNoZXM6DQo+Pg0KPj4gICBmcmFt
ZSAwOiAwZTUzNGQ4Yy4uLiwgcmVmZXJlbmNlIGQ5OGRkYmExLi4uDQo+Pg0KPj4gU3luYyB0aGUg
YWxsb2NhdGlvbiBmb3IgdGhlIGRldmljZSBiZWZvcmUgcmV0dXJuaW5nIGl0Lg0KPj4NCj4+IEZp
eGVzOiBhYjA5ZGQ2ZDkyMDEgKCJ0ZWU6IGFkZCB0ZWVfc2htX2FsbG9jX2RtYV9tZW0oKSIpDQo+
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogVHlsZXIgQmFr
ZXIgPHR5bGVyLmJha2VyQG9zcy5xdWFsY29tbS5jb20+DQo+PiAtLS0NCj4+IFZpbmNlbnQncyBk
aXJlY3QtbWFwIHNlcmllcyBbMV0gY2xlYW5zIHRoZSByYW5nZSBpbg0KPj4gZG1hX3phcF9kaXJl
Y3RfbWFwKCkgYmVmb3JlIHRoZSBsZW5kLCB3aGljaCBhbHNvIGNvdmVycyB0aGlzIHdoZW4gaXQN
Cj4+IGNhbiB1bm1hcC4gSXQgcmV0dXJucyAtRU5PREVWIHdpdGhvdXQgYW55IGNhY2hlIG1haW50
ZW5hbmNlIHdoZW4gdGhlcmUNCj4+IGlzIG5vIGxlbmRhYmxlIHBvb2wgYW5kIHRoZSBkaXJlY3Qg
bWFwIGNhbm5vdCBjaGFuZ2UgKGFybTY0IHdpdGgNCj4+IHJvZGF0YT1ub2FsaWFzIG9yIHJvZGF0
YT1vZmYpLCBhbmQgaXQgaXMgbm90IGEgc3RhYmxlIGNhbmRpZGF0ZS4NCj4+DQo+PiBPbiBhIGRt
YS1jb2hlcmVudCBURUUgZGV2aWNlIHRoZSBzeW5jIGRvZXMgbm90aGluZy4gdGVlZGV2LT5kZXYg
aXMgbm90DQo+PiBjb25maWd1cmVkIGZyb20gZmlybXdhcmUsIHNvIGl0IGlzIG5vdCBjb2hlcmVu
dCB0b2RheS4NCj4+DQo+PiBXaXRob3V0IHRoZSBmaXggdGhlIFRBJ3MgZGF0YSBpcyBsb3N0Og0K
Pj4gICBodHRwczovL2xhdmEuaW5mcmEuZm91bmRyaWVzLmlvL3NjaGVkdWxlci9qb2IvNTU0NDY3
I0wyMjYyDQo+PiBXaXRoIGl0LCB0aGUgZGF0YSBpcyBpbnRhY3QgYWZ0ZXIgdGhlIHNjYW4gYW5k
IDUwIGxlbmQgcm91bmRzOg0KPj4gICBodHRwczovL2xhdmEuaW5mcmEuZm91bmRyaWVzLmlvL3Nj
aGVkdWxlci9qb2IvNTYzODQwI0wxOTc5DQo+PiAgIGh0dHBzOi8vbGF2YS5pbmZyYS5mb3VuZHJp
ZXMuaW8vc2NoZWR1bGVyL2pvYi81NjM4NDAjTDIwMDgNCj4+DQo+PiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjYxMTExMTEwNzM4Ljg3Mjk0Ny0xLXZkb25uZWZvcnRAZ29vZ2xl
LmNvbS8NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvdGVlL3RlZV9zaG0uYyB8IDMgKysrDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3RlZS90ZWVfc2htLmMgYi9kcml2ZXJzL3RlZS90ZWVfc2htLmMNCj4+IGluZGV4IDVjNDdhMzY5
MTZjNDUuLjcwYTI3M2E0MjVmODggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3RlZS90ZWVfc2ht
LmMNCj4+ICsrKyBiL2RyaXZlcnMvdGVlL3RlZV9zaG0uYw0KPj4gQEAgLTI5Nyw2ICsyOTcsOSBA
QCBzdHJ1Y3QgdGVlX3NobSAqdGVlX3NobV9hbGxvY19kbWFfbWVtKHN0cnVjdCB0ZWVfY29udGV4
dCAqY3R4LA0KPj4gICAgICAgICBpZiAoIXBhZ2UpDQo+PiAgICAgICAgICAgICAgICAgZ290byBl
cnJfcHV0X3RlZWRldjsNCj4+DQo+PiArICAgICAgIGRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNl
KCZ0ZWVkZXYtPmRldiwgZG1hX2FkZHIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHBhZ2VfY291bnQgKiBQQUdFX1NJWkUsIERNQV9CSURJUkVDVElPTkFMKTsNCj4+ICsN
Cj4+ICAgICAgICAgZG1hX21lbSA9IGt6YWxsb2Nfb2JqKCpkbWFfbWVtKTsNCj4+ICAgICAgICAg
aWYgKCFkbWFfbWVtKQ0KPj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfcGFnZXM7DQo+
Pg0KPj4gLS0tDQo+DQo+TG9va3MgZ29vZC4gU3VtaXQsIGRvIHlvdSBhZ3JlZT8NCg0KTG9va3Mg
bGlrZSBhIHJlYXNvbmFibGUgZml4IHRvIG1lLCBmZWVsIGZyZWUgdG8gYWRkOg0KDQpSZXZpZXdl
ZC1ieTogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29tPg0KDQotU3VtaXQN
Cg==
