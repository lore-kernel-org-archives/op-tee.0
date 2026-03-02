Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA1EE9B36F
	for <op-tee@archiver.kernel.org>; Mon,  2 Mar 2026 13:05:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CB3E34386D
	for <op-tee@archiver.kernel.org>; Mon,  2 Mar 2026 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1772456715;
	bh=VUD80GCLZWaIk8q1ZYJs9nUPuZNe/lRvLAS3/y6NEfY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=VCUX6jGzjHKeQBCqaU/MQwnomiOxKLYPPzHpeW8SL5OJcGnidghxomPLXvT2TNM5C
	 J7ntftNhreYoYHEW3c1gXUQ1iUfGuuhKI3XidII1EvbMbRnemO4C1NzJGeKULgeu5/
	 eKk/+uA1eLSQqMe8bBC+pyJSTy1XZikLZdOVEokR8dgecxizDOrLRZCS8JyPxnKIFP
	 bS0pMdHsb85Lmn+NAXsf/8hK4SFvpVZfMHZtP1n25bV011Zr0lSd4fkrM4pWlFyzYR
	 51g2D6TBxMOgddoIy2KW9sOgKEU4vsIlhgkG+sn41Xy6Vab1FRofaigoLpmUGrjbDE
	 AFQDemmdCUHsA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 78CCC43178
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Mar 2026 13:04:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F6Xnd2gX;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CF7C944001;
	Mon,  2 Mar 2026 13:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC6EC19423;
	Mon,  2 Mar 2026 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772456692;
	bh=M0WQBqseyx5qx3EwAlpm/MCx5gek3DawXxYpduhxF6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6Xnd2gXXMChe8qxLs5kysLnh3nS1qpExMiQaFuFCabfzz1sBZ4dO5aRcMNv2As0L
	 RkntbCRUnEoO7tm94Vr47JB12BBsT8QydXsuHhhlvm7/k3T4de437UXhoLwfRzMBrG
	 8Wy+12hbP1lrPJaVoYGQ3bfXmtQBUT6Fao9q3CCG65lQNm2qLGzxsjqWTsO3NCEM9J
	 tFURJ0JlUjkGEK92fCXX5FWJh1g4MBMteNUuGwqc4nIn32XKTV0k5iXRdMwop1SnfI
	 w6SlXDj372bwIxVwa/v3ZWr5rfW5NWPYsAoUBPLFDixY9pD0fag3HNsaDugQy9g5Lh
	 hxI6rnO2tLCWg==
Date: Mon, 2 Mar 2026 18:34:48 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v5] tee: optee: prevent use-after-free when the client
 exits before the supplicant
Message-ID: <aaWK8EqeAZN7SIdc@sumit-xelite>
References: <CABcfEOfmr+xL_uOmmXfQkvZiME0-Mk3-KK1xSS5kCW-ervTTHQ@mail.gmail.com>
 <CAHUa44EcHjWqJXNgKG=9Pb2yX9k11+8RkjJA=LE3GfqC=qkb-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44EcHjWqJXNgKG=9Pb2yX9k11+8RkjJA=LE3GfqC=qkb-g@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.trustedfirmware.org,oss.qualcomm.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 78CCC43178
X-Spamd-Bar: -
Message-ID-Hash: I5MQGGTWT6OU3FJ5VROXJC675W6DNBE3
X-Message-ID-Hash: I5MQGGTWT6OU3FJ5VROXJC675W6DNBE3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I5MQGGTWT6OU3FJ5VROXJC675W6DNBE3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gTW9uLCBNYXIgMDIsIDIwMjYgYXQgMDE6NTk6MzVQTSArMDEwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IEhpLA0KPiANCj4gT24gV2VkLCBGZWIgMjUsIDIwMjYgYXQgODo1NOKAr0FNIFl1
YW5qaWEgWWVoIDx5ZWgub294eEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgYWxsLA0K
PiA+DQo+ID4gV2UgY2FuIHJlcHJvZHVjZSB0aGUgcmVwb3J0ZWQgdXNlLWFmdGVyLWZyZWUgaXNz
dWUgb24gb3VyIHBsYXRmb3JtIHZpYSBhbg0KPiA+IG92ZXJuaWdodCByZWJvb3QgdGVzdA0KPiA+
DQo+ID4gVGhlIHZlcmlmaWNhdGlvbnMgYXJlIGxpc3RlZCBhcyB0aGUgZm9sbG93aW5nDQo+ID4N
Cj4gPiAtIFdpdGggdjIgKyBNaWNoYWVsIFd1J3MgcGF0Y2g6IElzc3VlIHJlc29sdmVkLg0KPiA+
IC0gV2l0aCB2NDogUmFjZSBjb25kaXRpb24gb2JzZXJ2YXRpb24gYW5kIGFscmVhZHkgcmVwb3J0
IHRvIEFtaXINCj4gPiAtIFdpdGggdjU6IFJhY2UgZml4ZWQuIFN0YWJsZSBpbiBvdXIgdGVzdHMs
IGluY2x1ZGluZzoNCj4gPiAgICAgICB4dGVzdCArIHJlYm9vdCBsb29wICgzMDAgY3ljbGVzKQ0K
PiA+ICAgICAgIGNvbnRpbnVvdXMgcmVib290IHRlc3QgKDEwMDAgY3ljbGVzKQ0KPiA+DQo+ID4g
ICBObyByZWdyZXNzaW9ucyBvYnNlcnZlZCB3aXRoIHY1Lg0KPiA+DQo+ID4gSWYgdGhlcmUgYXJl
IG5vIG90aGVyIGNvbmNlcm5zLCB3ZSByZWNvbW1lbmQgYWRvcHRpbmcgdjUuDQo+ID4NCj4gPiBJ
ZiBuZWVkZWQsIHBsZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWc6DQo+ID4gVGVzdGVkLWJ5OiBP
eCBZZWggPG94LnllaEBtZWRpYXRlay5jb20+DQo+ID4NCj4gPiBZdWFuamlhIFllaA0KPiANCj4g
VGhhbmtzIGZvciB0ZXN0aW5nLiBTdW1pdCwgd2l0aCB0aGlzIFRlc3RlZC1ieSBhcmUsIHlvdSBP
SyB3aXRoIHRoZQ0KPiBwYXRjaD8gSSd2ZSB0ZXN0ZWQgaXQgbG9jYWxseSBhbmQgaXQgZG9lc24n
dCBicmVhayBhbnl0aGluZyBmb3IgbWUuDQoNClllYWgsIGZlZWwgZnJlZSB0byBhZGQ6DQoNClJl
dmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQoNCi1T
dW1pdA0K
