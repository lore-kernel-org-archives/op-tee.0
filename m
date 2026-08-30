Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599EBC61DF0
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 05:12:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 84B5D4522C
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 05:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788153145;
	bh=/AK2pwbuFrAO5t6+Sofph1O7MYFXlwSHtqydgrNy/bE=;
	h=Subject:To:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=UI3Zo9PN9TxB14fbWxEM3BZrxZ2z09Nh1Nr25dpVmyEeGN7zzg3aUdnq0PJmmcJx1
	 OCFpfsJGXdOQbU3NL3lcNtmjUKgI/UTdsDiKJZgvxKUnHfEBiwxQ5vG56Wg3vPR7Uu
	 KEzZn8xHrKlVEPy6PmcgjcYfKLpQfVRErMc279mgHhQ6DxcRzpN+0aMtgH4oP5Yf+t
	 bs4FJxrQTF0UaxgDKMhyW+H4R1zoDLuj2tNVHuuAwtjFZwKDfgsPso21mzMfMpEkpb
	 g/IFMbS0sEVuH2Xhe4Gteb5eyXvrep3Z7DrcOwqHqtfl4MU46k8zEcwk2T0Lye51uS
	 eJGpTH2QBHCGQ==
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CB26944229
	for <op-tee@lists.trustedfirmware.org>; Sun, 30 Aug 2026 16:05:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=iokpp.de header.i=@iokpp.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RpBA0sfv;
	dkim=pass header.d=iokpp.de header.i=@iokpp.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=WUXZ8F2Q;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; t=1788105943; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ca+u/j8uOQbDAlxSYgIpQDr4Xe5pFULvOFnVXM2w4A0zxmHvWCg7RNRYvj728Aza0p
    GpiqmAX/E8hs0kk9tsZHQY5/AH0dRQmEPD+CRU080BCkMeCqn+cKIJXHrzgAF3EVI5dE
    q3zGV5LYj6QNFh3/1Qe3v0/5A6muqZ6AJcHHI3V4Tn7oHYMDphkVfaXT8kGfVtVYj5Ik
    H09UkBbp7SgTweakDYd+V3QzWgy6mL6uV2SdQNiAFpzwQK0nnXJ8FOr7luHTfMwKyCZ1
    jLJ9YQkQXOmUkMmyjUz6ZCsIr0XDA3nvmqkk5/plDHTSUY8oWMWhUA66anO0L91lLAFl
    e7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788105943;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/AK2pwbuFrAO5t6+Sofph1O7MYFXlwSHtqydgrNy/bE=;
    b=PhwFuVftFTcZjTCErImauo/j59j7o/JzFuqBd2QvlTZsz4AK++VrhRHV8iIDF2sHVY
    jYt0RV48mPn3ZgJd4Yvj4y/dtU0ushkvmoOW+20L76N3gWczdlIiPNhGRdAPqUQPbW2+
    jUq7JXCskNuXRc6atGd2dVxB54gdxRh8aOBozynHMx1mP5JumicnalX8AL1/sfNguJaB
    jlwd6XbTwzrGrDuRf5x4YJNABIHFUbgU8kBQXoXfUouYQwR3qyBDcQGXzCDg0CpRIVJI
    MyqRe5IpK+/8FD7ZEB+IFpGJ/lBgl3+13D/OJllyPzo89vjXOjY/BvMs1VSdv0EAMgyM
    ivTQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788105943;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/AK2pwbuFrAO5t6+Sofph1O7MYFXlwSHtqydgrNy/bE=;
    b=RpBA0sfvOIPSlooflLqEo6vIKaTRZDQZja2aX9m9JsxB0m0IxCsSw+1N+4eJlS4idq
    m+2mZ8+BuAG2HP6PxOu6YI9UODeHdcaNpfVz5l7TzKlRmg+E3cpbaGCOQdRu6fh/lB24
    +ev21eC/rUulKZwM3U5gOst3TmGGrWmIyJfCI57q9/3L2GPg8b0e2foNY8kLJ+82ckBP
    PdXcGpUGPL4M4/St7oYQCtuWk/emuQ0traSN7O+LHJG08YQeA/yozeULtk7zgQyYJcIB
    PYUOJVq6Cl4ZhE4oZPpJsMZkOeeLuv6H9MndNQRKddKQiA7OVmNxUevhMGvOZWDimTHB
    R3ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788105943;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/AK2pwbuFrAO5t6+Sofph1O7MYFXlwSHtqydgrNy/bE=;
    b=WUXZ8F2Qq+adkPA/Pwn4Tt9JfMMNzU9Q8SgdTGqdMJnOdwkKIzaS7+PleFTA36Z3Xm
    gdewr4CLM8kjx5vYNcBg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0zNriHg+YfT0rGaZpI+/4y2xJGqxKO/71WLEX+9Og/eiUqko/dE="
Received: from p200300c5872968993aedd1469d684940.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze37e127UG5ggkD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 30 Aug 2026 18:05:42 +0200 (CEST)
Message-ID: <0993b0a14b17331dff17dd643be56144d0ae267b.camel@iokpp.de>
Subject: Re: [PATCH v4 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	beanhuo@micron.com, can.guo@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
	jenswi@kernel.org
Date: Sun, 30 Aug 2026 18:05:42 +0200
In-Reply-To: <20260827070345.2853821-3-jorge.ramirez@oss.qualcomm.com>
References: <20260827070345.2853821-1-jorge.ramirez@oss.qualcomm.com>
	 <20260827070345.2853821-3-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[strato.com:s=strato-dkim-0002:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iokpp.de,reject];
	R_DKIM_ALLOW(-0.20)[iokpp.de:s=strato-dkim-0002,iokpp.de:s=strato-dkim-0003];
	ONCE_RECEIVED(0.20)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:6724, ipnet:85.215.255.0/24, country:DE];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[85.215.255.80:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_NA(0.00)[no SPF record];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[iokpp.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CB26944229
X-Spamd-Bar: ---
X-MailFrom: beanhuo@iokpp.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: NUFG4F4QU3H2RKC745LNQI3OW3NSN3WM
X-Message-ID-Hash: NUFG4F4QU3H2RKC745LNQI3OW3NSN3WM
X-Mailman-Approved-At: Mon, 31 Aug 2026 05:11:51 +0000
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NUFG4F4QU3H2RKC745LNQI3OW3NSN3WM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bean Huo via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bean Huo <beanhuo@iokpp.de>

On Thu, 2026-08-27 at 09:03 +0200, Jorge Ramirez-Ortiz wrote:
> The RPMB authentication key is derived from the dev_id handed to the
> RPMB subsystem. OP-TEE implements the eMMC RPMB flow, where the dev_id
> is the eMMC CID: a fixed 16-byte value the key derivation depends on.
>=20
> The UFS RPMB id is "<device_id>-R<region>", which is variable length
> and longer than 16 bytes. Handing it to the RPMB subsystem as-is would
> tie the derived key to a length OP-TEE does not expect and diverge from
> the fixed-CID eMMC ABI, forcing OP-TEE to be taught about
> variable-length UFS ids.
>=20
> A fixed 16-byte dev_id is needed so the derived key stays stable and
> unique per region while matching the eMMC CID layout OP-TEE relies on,
> keeping the key-derivation ABI identical with no OP-TEE change. The
> reduction to a fixed 16 bytes must also be reproducible by the
> bootloaders (such as U-Boot) that derive the same dev_id.
>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

I gave my Reviewed-by on v3 2/2 [1], but it seems to have been dropped here=
. If
the patch hasn't changed much, must be picked, add again:


Reviewed-by: Bean Huo <beanhuo@micron.com>


Documentation/process/submitting-patches.rst asks author to carry review ta=
gs
into later versions, and to note it below the '---' when a tag is dropped.

[1]https://lore.kernel.org/all/c041d409bf6f564c6743a0d03e0c851ce3afa6d5.cam=
el@iokpp.de/

Kind regards,
Bean



