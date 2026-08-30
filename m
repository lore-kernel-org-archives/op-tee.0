Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2B6C61DD3
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 05:11:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B64584438F
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 05:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788153117;
	bh=z2m01tKlkKHlaM/0IXx3sQbwCS88IIrV5vJiFQBhVbI=;
	h=Subject:To:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OWDiNXQ9peLvII/6nO3Fw31EzMMpgRmup+56nyc9uIomI9R5366B59lMCVHPTF4nA
	 45kfgO/TMxX4Qz73NYemXJ8z3svFhErz3uer8OHXnUfAUeOxckkmhDZ6gG6gR+KFvt
	 MjNehMAdiWbzE68tXKXfn+WCCXhupV98TtAzeS9cFSg4cytIzhXSnTWmbvLJ/vSozZ
	 LcqxNgzp5fw1KbTFZ6ICKkrtJyI1aAPGuKjxqdQhxFF5yFXPAIrtYXLFI26+W0cX1c
	 fRzdWD75dkEkpO0792PcLwp9Ck9gASuP0PiQ8yo4FpLu0B5971SHk1AX7G1eYbjbaF
	 577oVRr7R3/ng==
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F319844229
	for <op-tee@lists.trustedfirmware.org>; Sun, 30 Aug 2026 15:44:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=iokpp.de header.i=@iokpp.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ngkf2WV/;
	dkim=pass header.d=iokpp.de header.i=@iokpp.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=h6Z8MQty;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; t=1788104656; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UYmDnMqEHTl4rYDHkmoO6PdkWPzzGACfMgsSbl/R4tNwjr1G5h2H8aWoQa1M9yKkYu
    UCTrQTF0jD1GCPQCluzI3nbg1T/vhZaLSYRPXpb3i7dNNWmg3aT2/EOoveD0cBJ9FaMu
    2FfEQGasrvCDZpD/CMl0gF8nRrbwBrGMg7boflqswvs90tPdTEGIKVnhbv6n/s4Ryaph
    lDRSnCOYe0mZoUNLQJ3dk+mAnfUvZc2kI32+yRfax71qJS3WG+y5CB1XFAjWQyAhZue0
    H55l8/ddkJr2ATvolB0IcHkmqTMuqkdvdErgBiHv4WYAdGbPzmxXqeCP1mBGQM/jpA22
    vBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788104656;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=z2m01tKlkKHlaM/0IXx3sQbwCS88IIrV5vJiFQBhVbI=;
    b=mDUdXC5CFE/R137N7liXkn839asvGfEE3lMidgqTsNrOFY/7bXSjsVGHJY0l81hgmK
    JGkls59WEzgi9TxbSRKtoEdgbByFjifQ7nc3hXv1kFb4PR8QOXqVqcbtf7MXB3x6ZcOd
    LIG1E2dm9HZbU8pFbhz4PeruuN7wkUu0aeoK7VdAqfZvQUPcevx7UMDHm5/NU25Zd0O4
    SbsZJVXl9NudETKhQ+IARZsrrGGdgHeAxuBAxS8ATmUFOVp6ycVt9/CDrbEphped+2gB
    N3jdTfZbsPLt/n79AoZPNGsg4fqZ5rl0Z7RIfkT4b3xP635TaRacVsBYekMcL5tz9iBL
    M8QA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788104656;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=z2m01tKlkKHlaM/0IXx3sQbwCS88IIrV5vJiFQBhVbI=;
    b=ngkf2WV/1/liM7L66IfArmEQHa2SGESNiHkMA9RleyNmSf/otueoq6bnalT8LWc/DS
    i/yByp83JLOrbru74+7Ir9lHvqbAet3BF8jr4ahvofX6z/GV/9lOtDhexniSDbkl+1f9
    ZLwL3kyT3/rjMNhey087teemy3MOA7gpsNpiBscYQWt3tAtWtMEb40jjoTNQXD0LuoJL
    aAm6/qF/3mCgNKLfkvdze7W/xojszEqkKhULO45TsDG+iTg096srvHiUUvOXPesCHMsK
    OcrQW9zPrO6otmWC85XoRQZqxvhtMI2+73b0Y7wWuAEHPQjQhwDwZcwJuSz1pFyml4UD
    GDfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788104656;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=z2m01tKlkKHlaM/0IXx3sQbwCS88IIrV5vJiFQBhVbI=;
    b=h6Z8MQtyHGi9/ITjy3HNgiSPnYk/Xim/QJBCZ9XlGuV4LgMmzfz7vtkNVyYn7jNu6v
    G2+OPqaABV5CPhbTpPAw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0zNriHg+YfT0rGaZpI+/4y2xJGqxKO/71WLEX+9Og/eiUqko/dE="
Received: from p200300c5872968993aedd1469d684940.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze37e127UFiFgif
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 30 Aug 2026 17:44:15 +0200 (CEST)
Message-ID: <3e9b0d90733b6fdee6da3f1acb7c91c320ac2179.camel@iokpp.de>
Subject: Re: [PATCH v4 1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the
 RPMB WLUN
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	beanhuo@micron.com, can.guo@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
	jenswi@kernel.org
Date: Sun, 30 Aug 2026 17:44:15 +0200
In-Reply-To: <20260827070345.2853821-2-jorge.ramirez@oss.qualcomm.com>
References: <20260827070345.2853821-1-jorge.ramirez@oss.qualcomm.com>
	 <20260827070345.2853821-2-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.23 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[strato.com:s=strato-dkim-0002:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iokpp.de,reject];
	R_DKIM_ALLOW(-0.20)[iokpp.de:s=strato-dkim-0002,iokpp.de:s=strato-dkim-0003];
	ONCE_RECEIVED(0.20)[];
	RWL_MAILSPIKE_GOOD(-0.10)[85.215.255.51:from];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.03)[56.04%];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:6724, ipnet:85.215.255.0/24, country:DE];
	RCVD_TLS_ALL(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[85.215.255.51:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_NA(0.00)[no SPF record];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[iokpp.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F319844229
X-Spamd-Bar: /
X-MailFrom: beanhuo@iokpp.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: MQA66OQXAMDRLRT25V7VYA3JOICPZ7E5
X-Message-ID-Hash: MQA66OQXAMDRLRT25V7VYA3JOICPZ7E5
X-Mailman-Approved-At: Mon, 31 Aug 2026 05:11:51 +0000
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MQA66OQXAMDRLRT25V7VYA3JOICPZ7E5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bean Huo via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bean Huo <beanhuo@iokpp.de>

On Thu, 2026-08-27 at 09:03 +0200, Jorge Ramirez-Ortiz wrote:
> After a power cycle, the first command sent to any UFS logical unit
> completes with CHECK CONDITION reporting a power-on UNIT ATTENTION.
> The SCSI core surfaces this condition to the caller rather than
> retrying it.
>=20
> For the RPMB well-known LU the first command after boot is the first
> RPMB frame, and RPMB has no earlier, guaranteed access that could clear
> the condition beforehand. The power-on UNIT ATTENTION therefore reaches
> RPMB and fails that first frame, breaking RPMB on every cold boot.
>=20
> The RPMB WLUN needs the power-on UNIT ATTENTION to be retried so that
> RPMB works from the very first access after a power cycle.
>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>
