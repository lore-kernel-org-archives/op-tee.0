Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9446EC87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 14:48:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BFB224FB2F
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755096535;
	bh=s+BDvH+o3RFTf++AU9TI/+W0pNIdtnbrfWEbr94/8h4=;
	h=Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=1eaGxJAM+meTZ0OED//bU4aVmeIgLdHTnZDSbhSfppKe4Tjg8zqwaGb19N6ikcSLL
	 y0YWr95ma9MHswaGxDZYSnbfc2AHE2h5bVVHosmcbxQrFFQ6yfWGPr9AjOsVsjooTb
	 kxU5bTv1xyeIaGPCjgbdq5fTubfFtNm94V2sD/b08bGRU8gl4hw+gdSVgeLwuG74WP
	 9QzEkkwZxWPfmVeFwbb+WvJFpY/nXkb+IzxdfS69WvAyXVicK2bd727+Iq6aCpCvlD
	 FwRYeXiL89AX5FwPX8x42W0WZ5lhZPac6daiebVAbTAHzkfAK4mJjf9bTeLERs8ZY0
	 2d7aCeXTFz2NQ==
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6437E42E10
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 10:39:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=payter.nl header.i=@payter.nl header.a=rsa-sha256 header.s=google header.b=isVS0qc+;
	dkim-atps=neutral
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-332426c78a2so51688181fa.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=payter.nl; s=google; t=1755081541; x=1755686341; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uYnTCxP4QmKLEUHrB1jHEnweNOeH6avzWlS8DLaMNBE=;
        b=isVS0qc+8b5te6dhF4d6jCnfzL3r37zhWV0bnaOcHLJnNY2aUYn3wDPdrg0QYAbVrw
         s7AKxMqgbJFAIWSSdaVUUv4Lzs6uDZ7c/LpmPAr58j0WdYCRPRugefJot3SlBfBsTvte
         GnkDAowWKupUyGxxGvsE2vd+k3gi+YXCPU1QWQS49+w8PbgP//F2795C6NE+ttKJWDOz
         zvCDlpfZzYi7SVJlIqL4tzUBSfqKZCQ7H0RHVU1bfQb43uJkWbBHp/kMQDvI1PHNtecT
         qlKC3SlzxmU7oV/Po68Rz/l/xWPo1DJmIUJs2z3IPra/9dn9VLno9tdQbFBxOsTwx4DR
         Z9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081541; x=1755686341;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYnTCxP4QmKLEUHrB1jHEnweNOeH6avzWlS8DLaMNBE=;
        b=eSB5pJhq8xFzr19GYWEHO557eJ+pbYYgbSKHOa9gOcybUj5WvF59S4qZ+7l6swmGhD
         L8kR8ogYGt7M1bJU4KvLmhsR6iN5yTWpBxnuLt0t/JI6q2ObOKlfZdJtfBZM92M1ZaoK
         Ut2qOxhsJeD75vqQsJDSxKCKuKIKnihUq5P92Hg9YV8hHWj3SEYZwY1t8U04dxd9zLmq
         twTQwBQRslQbp5mqJxHbk8qJNRqp6LOHCRSshORxs9scbTtflgp0l+OutbjrWVzI3pN0
         /2qX8KhOE9cQgqzoxRdqoTTZwBikULU3Fh49qr8DCuyWfzwJElsJwok9GxkUkLLaVNts
         rpXg==
X-Gm-Message-State: AOJu0YxjcPeX62A6TGjJBcdCtdFbmUpAmwUnOqPPFsE10m83PQiyvWnW
	eV9UbWZNfQNnkZhjcZWA4sL6GSknsPLvuqqyz0d+CrkZNVzyv2QSwyibYL9DYrqAyMLOSxqqbC2
	YbmXqBUPpnLPrDvJdW2S5E+oRLd45wyvUQ0lnK4QMURdnA66dOi8GjX5RDFXFSsHwVNxZsnEllO
	vQPfkRSdyn9fU0KvSdTnf/pcOaqWruehfl8beG9wYHc61iTB1jfjFW
X-Gm-Gg: ASbGnctGw/0VsTA8wSIAxjhirFfagN+wiWpnsTdHyi74CPqh4NSv6aRreF6bAhFMkk4
	zkK+bSsEorG6tCXvZQKt0WE+hzZXAq0tT0XhjFkQS8/15AazrpEG9DCt2NjelCJzB49uABHBC4b
	8IYLWHQWJHz9LpGtOskoewlVB0CSDzW3902pS5DNC7NR+0KWIoCvWg4OF0FkgbUYkDtD4iFBjeO
	kS0NzY=
X-Google-Smtp-Source: AGHT+IFT6R9Uvtdl0PwF0ib4n7h+FH7RovzgoZJJKCbzkrVq/08uFqTMYwGzLD88Abthy/BgTNUN47N7Qe7ANaHs1q8=
X-Received: by 2002:a2e:be09:0:b0:32c:a006:29ec with SMTP id
 38308e7fff4ca-333e9b5cbc7mr7254471fa.29.1755081540802; Wed, 13 Aug 2025
 03:39:00 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 13 Aug 2025 12:38:49 +0200
X-Gm-Features: Ac12FXwARqVI6qLJfA6L0VqtCYDJKO2RIZi3si12pcuPuWyAkZNcqQ_3uE-1htU
Message-ID: <CAEhEOQn9TYvdUnf39UOOenydg1Xh1SZYbKrbbprnf5nnXeCBtw@mail.gmail.com>
Subject: BEE support and TA_RAM usage in Op-Tee 3.10.0
To: op-tee@lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6437E42E10
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.00 / 15.00];
	DMARC_POLICY_ALLOW(-0.50)[payter.nl,reject];
	R_DKIM_ALLOW(-0.20)[payter.nl:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	BAYES_HAM(-0.00)[22.74%];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.171:from];
	DWL_DNSWL_BLOCKED(0.00)[payter.nl:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.171:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[payter.nl:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: r.delien@payter.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: MDTHAWLRZQXXYYB6D2RZ7BS2O24QWQXB
X-Message-ID-Hash: MDTHAWLRZQXXYYB6D2RZ7BS2O24QWQXB
X-Mailman-Approved-At: Wed, 13 Aug 2025 14:48:43 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MDTHAWLRZQXXYYB6D2RZ7BS2O24QWQXB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Robert Delien via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Robert Delien <r.delien@payter.nl>

SGksDQoNCldlIHdvdWxkIGxpa2UgdG8gcHJvdGVjdCB0cnVzdGVkIGFwcGxpY2F0aW9uIGhlYXAg
bWVtb3J5IGFnYWluc3QgY3J5b2dlbmljDQphdHRhY2tzLiBXZSB0aGluayBhIGdvb2QgbWV0aG9k
IHRvIGFjaGlldmUgdGhpcyBpcyBieSBlbXBsb3lpbmcgdGhlIEJ1cw0KRW5jcnlwdGlvbiBFbmdp
bmUgaGFyZHdhcmUgaW4gb3VyIGkuTVg2VUwuIEZvciB0ZXN0aW5nLCBJIGN1cnJlbnRseQ0KY29u
ZmlndXJlIHRoZSBCRUUgaW4gVS1Cb290LCB0byBlbmNyeXB0IHRoZSBPcC1UZWUgVEFfUkFNIGFy
ZWENCigweDhlMTAwMDAwLThmOWZmZmZmKSwgYW5kIG1ha2UgaXQgYXZhaWxhYmxlIHVuZW5jcnlw
dGVkbHkNCmF0IDB4MTAwMDAwMDAtMHgxMThmZmZmZi4gVEFfUkFNX1NUQVJUIGlzIHNldCB0byAw
eDEwMDAwMDAwIGFuZCB0aGlzIHNlZW1zDQp0byB3b3JrLCBidXQgSSBoYXZlIGEgZmV3IHF1ZXN0
aW9uczoNCjEuIERvZXMgYXJlYSBUQV9SQU1fU1RBUlQ6VEFfUkFNX1NJWkUgaG9sZCBhbGwgVEEg
Y29kZSwgc3RhY2sgYW5kIGhlYXA/DQoyLiBBY2Nlc3MgcHJpdmlsZWdlcyB0byAweDEwMDAwMDAw
LTB4MTE4ZmZmZmYgaGF2ZSBiZWVuIHNldCB0byAqTm9uLVNlY3VyZQ0KVXNlciBub25lLCBOb24t
U2VjdXJlIFNwdnIgbm9uZSwgU2VjdXJlIFVzZXIgUkQgKyBXUiwgU2VjdXJlIFNwdnIgUkQgKyBX
UiosDQpidXQgbXVjaCB0byBteSBzdXJwcmlzZSwgKk5vbi1TZWN1cmUgVXNlciBub25lLCBOb24t
U2VjdXJlIFNwdnIgbm9uZSwNClNlY3VyZSBVc2VyIG5vbmUsIFNlY3VyZSBTcHZyIFJEICsgV1Iq
IHdvcmtlZCBlcXVhbGx5IHdlbGwuDQoNCkkgY2FuIHByb3ZpZGUgYSBtZW1vcnkgbWFwIGlmIHVz
ZWZ1bCwgYnV0IEknZCByYXRoZXIgbm90IHBvc3QgdGhhdCBhdA0KZm9yZWhhbmQuDQoNCklmIHRo
aXMgd29ya3Mgd2VsbCwgYWNoaWV2ZXMgb3VyIGdvYWwgYW5kIHRoZSBwZXJmb3JtYW5jZSBwZW5h
bHR5IGlzDQphY2NlcHRhYmxlLCB3ZSB3aWxsIHJvbGwgdGhpcyBpbnRvIGFuIE9wLVRlZSBkcml2
ZXIuDQoNCldpdGgga2luZCByZWdhcmRzLA0KDQogICAgICAgIFJvYmVydC4NCg0KLS0gDQpESVND
TEFJTUVSDQpEZSBpbmZvcm1hdGllLCB2ZXJ6b25kZW4gaW4gb2YgbWV0IGRpdCBlLW1haWxiZXJp
Y2h0LCBpcyANCnZlcnRyb3V3ZWxpamsgZW4gdWl0c2x1aXRlbmQgdm9vciBkZSBnZWFkcmVzc2Vl
cmRlKG4pIGJlc3RlbWQuIEhldCBnZWJydWlrIA0KdmFuIGRlIGluZm9ybWF0aWUgaW4gZGl0IGJl
cmljaHQsIGRlIG9wZW5iYWFybWFraW5nLCB2ZXJtZW5pZ3Z1bGRpZ2luZywgDQp2ZXJzcHJlaWRp
bmcgZW58b2YgdmVyc3RyZWtraW5nIGRhYXJ2YW4gYWFuIGRlcmRlbiBpcyBuaWV0IHRvZWdlc3Rh
YW4uIA0KR2VicnVpayB2YW4gZGV6ZSBpbmZvcm1hdGllIGRvb3IgYW5kZXJlbiBkYW4gZ2VhZHJl
c3NlZXJkZShuKSBpcyBzdHJpa3QgDQp2ZXJib2Rlbi4gQWFuIGRlemUgaW5mb3JtYXRpZSBrdW5u
ZW4gZ2VlbiByZWNodGVuIHdvcmRlbiBvbnRsZWVuZC4gVSB3b3JkdCANCnZlcnpvY2h0IGJpaiBv
bmp1aXN0ZSBhZHJlc3NlcmluZyBkZSBhZnplbmRlciBkaXJlY3QgdGUgaW5mb3JtZXJlbiBkb29y
IGhldCANCmJlcmljaHQgdGUgcmV0b3VybmVyZW4gZW4gaGV0IGJlcmljaHQgdWl0IHV3IGNvbXB1
dGVyc3lzdGVlbSB0ZSB2ZXJ3aWpkZXJlbi4NCg==
