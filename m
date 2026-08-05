Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39478C55838
	for <op-tee@archiver.kernel.org>; Thu,  6 Aug 2026 07:28:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5E08F451E9
	for <op-tee@archiver.kernel.org>; Thu,  6 Aug 2026 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1786001294;
	bh=3Fe7TjICK6EhGtEemNKJb2wFuI6Y1kd6HDQ3C9IPGCc=;
	h=Subject:To:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mkhARgaXAjK9RBQfj6keqVD1XG+YMnNnwQHbCFLSVdilpc18V6xt5nL0N5dyv/gUn
	 hXwZ3xftNkqbRiRey+7JUksS3y7A0g5zbKWV6XfwgTU4Ob36L5J9bS7TfyEqCP0XCJ
	 sGRd8OQ3W2euq89Vy1s3IYvaEcKc2bX89/rT32w+JYz50FYqXcugkOnVZo9G4PnwrS
	 oJnwgd9tDsMyPM/9whmFCMaCJ/Upt0uXdufEqX9XdBHfrsP66cztnF6qekXo4gEvLy
	 Aa3+foti7hMOTb2pdsBcPkzcStU7jVOdjyqftxXgTluSe6oLHrJPLOWotZNqvqRVzD
	 zYRn2R+IztP5w==
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 56B1743E53
	for <op-tee@lists.trustedfirmware.org>; Wed,  5 Aug 2026 16:50:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=iokpp.de header.i=@iokpp.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MsIm95Bc;
	dkim=pass header.d=iokpp.de header.i=@iokpp.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eb2DsBCB;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; t=1785948596; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gNH6yR0AH6whQzlTq8VU4IZNUFpq/sQ0FNlULJ45IZ/XyEnWZa37haFE5/o9F0jU8z
    gBqaXh4ZaOFFmQ/6Y+qYV8tipSOc4PMErrOx+xEdV5QNbRxAdCdm/9Yc6pvoo4914+6v
    27q8Q3LKnKDyUQKR5ItRWcH/bAnRWz402BIHdPK3A87drF/fx+FXtYKsQU75EL65BZ/E
    PscSoIopxfxAp+WvGW2Ch1Njw3kl/oMOvGj8O9qFuTHSe98dA0NKpO56/kwQ8NS/O2Pb
    g9JoBAcdv2yzCqW9/MSQj5n2SIIByonql17XNiGq8Y0i5OPnz6WLdoW+ixpRmYN3VfdT
    cBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785948596;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3Fe7TjICK6EhGtEemNKJb2wFuI6Y1kd6HDQ3C9IPGCc=;
    b=Zu1wtMg39hUH/0deR19/gZ+o8dfjAT/HuqJLoNAvoEGsGfilPgC/yXx2p50B9HmksX
    bjsZXXm7Y/AGj4i6XgWnKhs5QHSUNu/alTXpyAbOc+9CL/4snh19xrCksAJ+lnF0Q81v
    KeTb2rk3Z4orjqOQlQH/iB2ImSHQuK6PhfGWZRJUt//o/fR+UXLzYxjQd4Qpbk6Lbs82
    ek8jCOwrZig5kgOTGzuaVjqFtfFh2k61C06PotTRot8y+2c2VqKGjd4mtHJ45DWbR2C0
    ovHYzAI6P+gd3qg7KRG7s85KjG8COLuFVk5aWNHID9ho9HG0QnyrhSipLGgY/RsrCt+B
    QKGA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785948596;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3Fe7TjICK6EhGtEemNKJb2wFuI6Y1kd6HDQ3C9IPGCc=;
    b=MsIm95BcmpAOBMJrahFJlf7bPU2KkTP4tQyyqzvhKGOstokSTWCb8YNzlTslUJ7bgR
    O/0E550o3PEyK8BQYyKmagsn8cu5q8MaZvf2Jf4HzgBqfLtEZewc8V3226hVCnWl/Os7
    OOxk+FN2FSoxFV6fQ6TVZh+RBzgsoG1JHp2FXyArCVodskpFrXFq27LxQ0vHNVaLHvUO
    iPSLyLE/r2YB1u71Xm04r8uRVs6hF9KJ+2x/qDP7IRBDEy4XmMN7ZVqsILKd3FCNFpUO
    03fKCGZbmvBzk2gsT4uas4zUcthZ3HMIJ7+kxdSnOQAHqoBz2Eb40dyLZkasrZCVg7Ss
    1CpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785948596;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3Fe7TjICK6EhGtEemNKJb2wFuI6Y1kd6HDQ3C9IPGCc=;
    b=eb2DsBCBQ0Ods2FQmjM1uAeyfl66kcZYZWTnO8lKcOhMk8/ybpX0CUE8Fm7tHVWxlA
    Q/l2LjfCkzfkZRHF7HDQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0DBslXBtZUxPOub3IZik"
Received: from [10.176.237.62]
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id zeddc9275Gnt544
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 5 Aug 2026 18:49:55 +0200 (CEST)
Message-ID: <e83a4cdc8f2361d7be16358ef501b4d017078ac0.camel@iokpp.de>
Subject: Re: [PATCH 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	beanhuo@micron.com, can.guo@oss.qualcomm.com
Date: Wed, 05 Aug 2026 18:49:54 +0200
In-Reply-To: <20260715214327.1933560-3-jorge.ramirez@oss.qualcomm.com>
References: <20260715214327.1933560-1-jorge.ramirez@oss.qualcomm.com>
	 <20260715214327.1933560-3-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.18 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[strato.com:s=strato-dkim-0002:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iokpp.de,reject];
	R_DKIM_ALLOW(-0.20)[iokpp.de:s=strato-dkim-0002,iokpp.de:s=strato-dkim-0003];
	ONCE_RECEIVED(0.20)[];
	BAYES_HAM(-0.18)[70.12%];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:6724, ipnet:85.215.255.0/24, country:DE];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.886];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[85.215.255.80:from];
	R_SPF_NA(0.00)[no SPF record];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[85.215.255.80:from];
	DKIM_TRACE(0.00)[iokpp.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 56B1743E53
X-Spamd-Bar: /
X-MailFrom: beanhuo@iokpp.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: VK4ZCQIFM6VPRQSS3P2ZCCEWKV76XO2J
X-Message-ID-Hash: VK4ZCQIFM6VPRQSS3P2ZCCEWKV76XO2J
X-Mailman-Approved-At: Thu, 06 Aug 2026 07:28:08 +0000
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VK4ZCQIFM6VPRQSS3P2ZCCEWKV76XO2J/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bean Huo via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bean Huo <beanhuo@iokpp.de>

T24gV2VkLCAyMDI2LTA3LTE1IGF0IDIzOjM5ICswMjAwLCBKb3JnZSBSYW1pcmV6LU9ydGl6IHdy
b3RlOgo+IEBAIC0xNTYsNiArMTU4LDcgQEAgaW50IHVmc19ycG1iX3Byb2JlKHN0cnVjdCB1ZnNf
aGJhICpoYmEpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB1ZnNfcnBtYl9kZXYgKnVm
c19ycG1iLCAqaXQsICp0bXA7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBycG1iX2RldiAqcmRl
djsKPiArwqDCoMKgwqDCoMKgwqBjaGFyICpkZXZfaWQgPSBOVUxMOwo+IMKgwqDCoMKgwqDCoMKg
wqBjaGFyICpjaWQgPSBOVUxMOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmVnaW9uOwo+IMKgwqDC
oMKgwqDCoMKgwqB1MzIgY2FwOwo+IEBAIC0yMTUsOCArMjE4LDE3IEBAIGludCB1ZnNfcnBtYl9w
cm9iZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyX291dDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH0KPiDCoAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXNjci5k
ZXZfaWQgPSBjaWQ7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlc2NyLmRldl9p
ZF9sZW4gPSBzdHJsZW4oY2lkKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2
X2lkID0ga3phbGxvYyhVRlNfUlBNQl9JRF9MRU4sIEdGUF9LRVJORUwpOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWRldl9pZCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2aWNlX3VucmVnaXN0ZXIoJnVmc19ycG1iLT5k
ZXYpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
ID0gLUVOT01FTTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdvdG8gZXJyX291dDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQoKCnNp
bmNlIHJwbWJfZGV2X3JlZ2lzdGVyKCkga21lbWR1cHMgZGV2X2lkLCBjYW4gd2UgdXNlIHRoaXM6
IAoKCiAgICAgICAgdTggZGV2X2lkW1VGU19SUE1CX0lEX0xFTl07CiAgICAgICAgYmxha2UyYihO
VUxMLCAwLCBjaWQsIHN0cmxlbihjaWQpLCBkZXZfaWQsIFVGU19SUE1CX0lEX0xFTik7CiAgICAg
ICAgZGVzY3IuZGV2X2lkID0gZGV2X2lkOwogICAgICAgIGRlc2NyLmRldl9pZF9sZW4gPSBVRlNf
UlBNQl9JRF9MRU47CgrCoAp0aGVuIHlvdSBjb3VsZCBkcm9wIGFsbG9jYXRpb24gYW5kIGl0cyBl
cnJvciBicmFuY2ggYW5kIGJvdGgga2ZyZWUoKT8KCgpLaW5kIHJlZ2FyZHMsIApCZWFuCgoK

