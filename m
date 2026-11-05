Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAED606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=klbWDwDs;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxcQTFTe
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 10F6245493
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793880999;
	bh=tvuMwwcgS1QzfJUIQm7JGoHjHryh43cIKN76uiG3bGs=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=klbWDwDsTCGSNU5Qs9z6m2GUrgTW9XwL5zcRd5JpO8QUNRUGWiMQ7yD9LswN4TOCI
	 EDBBL1uF3tJ2P3F9nyap9R3j7znNbckBOYJeOZ97PdMXnBrcQozEveCDWsBUhL4WFW
	 c43USyKYwfm8P6kHl8VhfqFuCcco7GDmwk8ELIprOTdixPFAd5PC59iCXUOlAhN92C
	 rzQOpZNLpC0NqyuuQoXrpx8HjNBeLnPxXZxYR+Nam3YP2yjbpNSP47VJEllTFN3vqt
	 Tw6jJ48Ga71owiSJfj9eQJpB9OVLJZHJe8xWzTX6LgD1IuCPCfcskSBVfd7niOjU0I
	 T62V5y0/MuvAA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9A06845462
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 12:16:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxcQTFTe;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F1E0C43C0D;
	Thu,  5 Nov 2026 12:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA011F00919;
	Thu,  5 Nov 2026 12:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880978;
	bh=ATKenzrH4aHLGg+Gz/30nbgsHYXLMAm97uKz3BQEpq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dxcQTFTemS9uQTJPXISYTQtN/OxyWxw4ps5fPRhMNikorWbVIxo2+rpVvdR6AChVC
	 o9C/iwEuoZyk6h9rwuSksrwUB7Q8jf/F1M+nagBpzPYd7fnlc6V/B6j44Yj12TNuLK
	 x7IZCKvFZh3uR8vegTGzs8VqPCwryEPpDR4yLRJuoabluTNCWuOtFL6ZeKvdFL199+
	 RaedfrdzvQAQwvozFg/bwy3iO6nwJjnbP6QGGp2bgRJTqOYH6kd82pOcttb2Vvffzb
	 uVLZn62KJkJFQIklzDpZMx7PuM8bFBgBgFNSFvyeEJmt+UkVgdGQQkXNmVeUPKNjQ/
	 SAaWlSE9bHDAQ==
Date: Thu, 5 Nov 2026 17:46:13 +0530
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Subject: Re: [PATCH 1/1] tee: fix page count in register_shm_helper() error
 path
Message-ID: <auxzjSfifbLjPasI@sumit-xelite>
References: <20260831105824.3141687-1-shukai.ni@kuleuven.be>
 <20260831105824.3141687-2-shukai.ni@kuleuven.be>
 <CAGgiveUQ9_uZLL=KgGtV0PNiBRbHhRVMqKxWwE3jww2asW98VA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAGgiveUQ9_uZLL=KgGtV0PNiBRbHhRVMqKxWwE3jww2asW98VA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9A06845462
X-Spamd-Bar: --------
Message-ID-Hash: IQMSIPCLNBR64NSZ5TTS3NBIGRWRIWT4
X-Message-ID-Hash: IQMSIPCLNBR64NSZ5TTS3NBIGRWRIWT4
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Shukai Ni <shukai.ni@kuleuven.be>, Sumit Garg <sumit.garg@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IQMSIPCLNBR64NSZ5TTS3NBIGRWRIWT4/>
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

T24gVHVlLCAwMyBOb3YgMjAyNiBhdCAxOToxMTowNiArMDEwMCwgSmVucyBXaWtsYW5kZXIgd3Jv
dGU6DQo+SGksDQo+DQo+T24gTW9uLCBBdWcgMzEsIDIwMjYgYXQgMTI6NTjigK9QTSBTaHVrYWkg
TmkgPHNodWthaS5uaUBrdWxldXZlbi5iZT4gd3JvdGU6DQo+Pg0KPj4gaW92X2l0ZXJfZXh0cmFj
dF9wYWdlcygpIHJldHVybnMgdGhlIG51bWJlciBvZiBieXRlcyBleHRyYWN0ZWQgYW5kIHNldHMg
b2ZmDQo+PiB0byB0aGUgb2Zmc2V0IGludG8gdGhlIGZpcnN0IHBhZ2UuIEZvciB0aGUgaXRlcmF0
b3IsIHRoZSBudW1iZXIgb2YgcGFnZXMNCj4+IHBpbm5lZCBpcyB0aGVyZWZvcmUgRElWX1JPVU5E
X1VQKGxlbiArIG9mZiwgUEFHRV9TSVpFKS4NCj4+DQo+PiBUaGUgcGFydGlhbC1leHRyYWN0aW9u
IGVycm9yIHBhdGggaW5zdGVhZCByZWNvcmRzIGxlbiAvIFBBR0VfU0laRS4gRm9yIGFuDQo+PiB1
bmFsaWduZWQgYnVmZmVyIHRoaXMgY2FuIHVuZGVyY291bnQgYnkgb25lLCBjYXVzaW5nIHVucGlu
X3VzZXJfcGFnZXMoKSB0bw0KPj4gbGVhdmUgYSBwYWdlIHBpbm5lZC4NCj4+DQo+PiBGaXhlczog
ZDVjZjViMzcwNjRiICgidGVlOiBmaXggcmVnaXN0ZXJfc2htX2hlbHBlcigpIikNCj4+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+PiBDby1kZXZlbG9wZWQtYnk6IEpvIFZhbiBCdWxjayA8
am8udmFuYnVsY2tAY3Mua3VsZXV2ZW4uYmU+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKbyBWYW4gQnVs
Y2sgPGpvLnZhbmJ1bGNrQGNzLmt1bGV1dmVuLmJlPg0KPj4gU2lnbmVkLW9mZi1ieTogU2h1a2Fp
IE5pIDxzaHVrYWkubmlAa3VsZXV2ZW4uYmU+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3RlZS90ZWVf
c2htLmMgfCAyICstDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL3RlZV9zaG0uYyBiL2RyaXZl
cnMvdGVlL3RlZV9zaG0uYw0KPj4gaW5kZXggNjc0MmIzNS4uZmE0NDZlNCAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvdGVlL3RlZV9zaG0uYw0KPj4gKysrIGIvZHJpdmVycy90ZWUvdGVlX3NobS5j
DQo+PiBAQCAtNDU0LDcgKzQ1NCw3IEBAIHJlZ2lzdGVyX3NobV9oZWxwZXIoc3RydWN0IHRlZV9j
b250ZXh0ICpjdHgsIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwgdTMyIGZsYWdzLA0KPj4gICAgICAg
ICAgICAgICAgICAqIElmIHdlIG9ubHkgZ290IGEgZmV3IHBhZ2VzLCB1cGRhdGUgdG8gcmVsZWFz
ZSB0aGUNCj4+ICAgICAgICAgICAgICAgICAgKiBjb3JyZWN0IGFtb3VudCBiZWxvdy4NCj4+ICAg
ICAgICAgICAgICAgICAgKi8NCj4+IC0gICAgICAgICAgICAgICBzaG0tPm51bV9wYWdlcyA9IGxl
biAvIFBBR0VfU0laRTsNCj4+ICsgICAgICAgICAgICAgICBzaG0tPm51bV9wYWdlcyA9IERJVl9S
T1VORF9VUChsZW4gKyBvZmYsIFBBR0VfU0laRSk7DQo+PiAgICAgICAgICAgICAgICAgcmV0ID0g
RVJSX1BUUigtRU5PTUVNKTsNCj4+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9wdXRfc2htX3Bh
Z2VzOw0KPj4gICAgICAgICB9DQo+PiAtLQ0KPj4gMi41NS4wDQo+Pg0KPg0KPkxvb2tzIGdvb2Qu
IFN1bWl0LCBkbyB5b3UgYWdyZWU/DQoNClNvdW5kcyBsaWtlIGEgcmVhc29uYWJsZSBmaXggdG8g
bWUsIGZlZWwgZnJlZSB0byBhZGQ6DQoNClJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5n
YXJnQG9zcy5xdWFsY29tbS5jb20+DQoNCi1TdW1pdA0K
