Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DC9C61DB9
	for <op-tee@archiver.kernel.org>; Thu, 27 Aug 2026 06:03:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 54FCD4527E
	for <op-tee@archiver.kernel.org>; Thu, 27 Aug 2026 06:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787810612;
	bh=7TimULhYK4Q/vDyDhA4QIg1dUsow0FpgWnuFD1qPrvw=;
	h=Subject:To:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yl2Hj2uRp7DrArrB0k2U1sPNUGM0mLcQ09DFdJ/MxdD0EwS12rUKtR6VibOBLOwtq
	 /tMTHhGAldzY3Dg1pSh3wjOXI+a4JswWZg5UycxylbINp3Gagkt2jGmPBvsdOmdx7T
	 0+ohZwHOaDAj06nP227I/rMfhZVPHPvvOgzj93nh0YOzKgGLukMYaZnE1uJ2YXpH0Z
	 qQEWfPd2RL1IJnf5ycnk0tey7Pib27oebckAE+R2DgtKtWYofyeMVdqABSuw2S29gC
	 fKla+u4kSYuP9kbY2oVMIMl7/uAnxgzdhVH+cEo0n3t/6wmrcJK8AzLAz/q0oOzn8D
	 0rV7PXJOb/C6g==
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 77EC244F5B
	for <op-tee@lists.trustedfirmware.org>; Wed, 26 Aug 2026 20:59:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=iokpp.de header.i=@iokpp.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ouKJtkks;
	dkim=pass header.d=iokpp.de header.i=@iokpp.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=RNA4YzA0;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; t=1787777948; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hx3gHhNe5JnoZ0oHLDRpkwvyukEAbWIoeYD/SyWTo/QdJrO8/MuZh1uv5ucMzXBHxM
    K3z7odOPnQIiofYoRdyc1gmHHicN+2HQMBrJ8dTZwkJJ73BkNUeuBv/Qsy3auDo6cyrI
    YpAblI/IfcUlqI3sSA0Ny4dlYNIaPRQNeCCSj8aWC5JQVzyTCtK+Au1Apl422upIfCZQ
    S9txYWTruma3rCJ++IWMzDDEKyhDhdHHBbICWjVsmtAiYnzDHwZGgVCNDrLcALzMpsUA
    jOP8GiVdgL28c7XLjwbiP4xv84av3BuzvKBAn6QvAOFlIFd04ZrqPs+rSFuzwgIdYTUT
    gCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787777948;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7TimULhYK4Q/vDyDhA4QIg1dUsow0FpgWnuFD1qPrvw=;
    b=ZKSLZN9BQWb8uRB8WGYbyRj6DctuOAP9/ZUdzttfxgHxN03OhnXpR8OsoRdw1keQpi
    TZR3UCEo6awPzy6nxjNx2BHKY6Q0TO2p2CJFO6r9QYLz5SBbQbGuA5sW3GcrHrOOvek9
    lGTrIqOxKRHsQGEGInUfr3wEm0jcOnv627zYpTFqTpMJcu7MaBnFxvq3A1gMt/ePGS/2
    MU5AEoyDUjf4658UB6FSHsn+bYf7U/eRPZTHQnsOgg0yUsopwmAHvvKuQKybcqFP57jO
    y1qDcNWxqqNrowtDrTRZF8d5oUZw4Z3HCKfv5OIibGzMmyhWBJrzWJpeaYsoHCtFnwDW
    DdqQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787777948;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7TimULhYK4Q/vDyDhA4QIg1dUsow0FpgWnuFD1qPrvw=;
    b=ouKJtkksG0W0UQN0fNCa/0uOUQXYyTnzO9+AWSDsBwa5z616OxNcAZluBGyq+0W9Ew
    ++MI7G//EAJYArAOZ7i1mtjS9V9Y11P70ZTXGXcpfbEzPzZJSYNAd2QDc/PxYJYI3WYg
    rjvFmS36XxjIZZvrXXMZ4Tmp1tbHBD6sHa7euUnokom55Bm5qQ2J7iWyBHX8o8C7KB6Y
    bDsC/OctzG1IfgUXPfkHphPfPIygU4a7OzQEXtXqKOQz4JLRg40gLemXXM2zipqNHPvO
    LkWAYUrBqmGSPlA281thprv+rVc+0/eI2j+jXq0yJzkg5g4xXcz3OSU9H38IK3tZrUKB
    LX9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787777948;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7TimULhYK4Q/vDyDhA4QIg1dUsow0FpgWnuFD1qPrvw=;
    b=RNA4YzA0zmSJkdGF7xUN6nGBxQMMSklmB5HcVyP3ateEoLZh7DQOU+kRlAADOJK17p
    JZO9h7KgDr5R9pym0hBQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0zNriHg+YfT0rGaZpI+/4nexcz3kdO/c/hqkiDQr7/41mCC1SnA="
Received: from p200300c58729688cd608b20553b67495.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze37e127QKx7VEc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Aug 2026 22:59:07 +0200 (CEST)
Message-ID: <6ae9f526476cfce73c118c946f005753dd2d00b0.camel@iokpp.de>
Subject: Re: [PATCH v3 1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the
 RPMB WLUN
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	beanhuo@micron.com, can.guo@oss.qualcomm.com
Date: Wed, 26 Aug 2026 22:59:07 +0200
In-Reply-To: <20260821150612.3944782-2-jorge.ramirez@oss.qualcomm.com>
References: <20260821150612.3944782-1-jorge.ramirez@oss.qualcomm.com>
	 <20260821150612.3944782-2-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[strato.com:s=strato-dkim-0002:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iokpp.de,reject];
	R_DKIM_ALLOW(-0.20)[iokpp.de:s=strato-dkim-0002,iokpp.de:s=strato-dkim-0003];
	ONCE_RECEIVED(0.20)[];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:6724, ipnet:85.215.255.0/24, country:DE];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	R_SPF_NA(0.00)[no SPF record];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[85.215.255.50:from];
	DKIM_TRACE(0.00)[iokpp.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 77EC244F5B
X-Spamd-Bar: --
X-MailFrom: beanhuo@iokpp.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 4IVFZ7UFZIJYOHTH3XZ3PQIBO6ZBPF7J
X-Message-ID-Hash: 4IVFZ7UFZIJYOHTH3XZ3PQIBO6ZBPF7J
X-Mailman-Approved-At: Thu, 27 Aug 2026 06:03:26 +0000
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4IVFZ7UFZIJYOHTH3XZ3PQIBO6ZBPF7J/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bean Huo via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bean Huo <beanhuo@iokpp.de>

T24gRnJpLCAyMDI2LTA4LTIxIGF0IDE3OjA2ICswMjAwLCBKb3JnZSBSYW1pcmV6LU9ydGl6IHdy
b3RlOgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1ycG1iLmMgYi9kcml2ZXJz
L3Vmcy9jb3JlL3Vmcy1ycG1iLmMKPiBpbmRleCBmZmFkMDQ5ODcyYjkuLmQwYzdlYTdhMzZmNCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1ycG1iLmMKPiArKysgYi9kcml2ZXJz
L3Vmcy9jb3JlL3Vmcy1ycG1iLmMKPiBAQCAtNDAsNiArNDAsMjMgQEAgc3RydWN0IHVmc19ycG1i
X2RldiB7Cj4gwqBzdGF0aWMgaW50IHVmc19zZWNfc3VibWl0KHN0cnVjdCB1ZnNfaGJhICpoYmEs
IHUxNiBzcHNwLCB2b2lkICpidWZmZXIsIHNpemVfdAo+IGxlbiwgYm9vbCBzZW5kKQo+IMKgewo+
IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2NzaV9kZXZpY2UgKnNkZXYgPSBoYmEtPnVmc19ycG1i
X3dsdW47Cj4gK8KgwqDCoMKgwqDCoMKgLyogUmV0cnkgdGhlIHBvd2VyLW9uIFVOSVQgQVRURU5U
SU9OIChBU0MgMHgyOSk7IHRoZSBTQ1NJIGNvcmUgZG9lcwo+IG5vdC4gKi8KPiArwqDCoMKgwqDC
oMKgwqBzdHJ1Y3Qgc2NzaV9mYWlsdXJlIGZhaWx1cmVfZGVmc1tdID0gewo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAuc2Vuc2UgPSBVTklUX0FUVEVOVElPTiwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hc2MgPSAweDI5LAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmFzY3EgPSBTQ01EX0ZBSUxVUkVf
QVNDUV9BTlksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAuYWxsb3dlZCA9IDMsCgoKLmFsbG93ZWQgPSAzIGlzIGEgZmluZSB2YWx1ZSwgSSBjaGVja2Vk
IGNoLmMgKzE5NyB1c2VzIDMsIGFuZCBzZC5jIHVzZXMgNSwgc28gbm8KY29tcGxhaW50IGFib3V0
IHRoZSBudW1iZXIgaXRzZWxmLiBCdXQgdGhlIG90aGVyIGFzYyA9IDB4MjkgdXNlcnMgZ2l2ZSBp
dCBhCm1lYW5pbmdmdWwgbmFtZToKCmZvciBleGFtcGxlLCBzZXMuYyBoYXMgU0VTX1JFVFJJRVMg
YW5kIHNkLmMgaGFzIFJFQURfQ0FQQUNJVFlfUkVUUklFU19PTl9SRVNFVC4KYSBVRlNfUlBNQl9V
QV9SRVRSSUVTIChvciBvdGhlcikgd291bGQgbWF0Y2ggdGhhdCBtZWFuaW5nZnVsLgoKCm90aGVy
cyBsb29rIGdvb2QgdG8gbWUuCgpLaW5kIHJlZ2FyZHMsCkJlYW4KCg==

