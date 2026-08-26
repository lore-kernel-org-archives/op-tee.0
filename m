Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4C5C61DBD
	for <op-tee@archiver.kernel.org>; Wed, 26 Aug 2026 14:40:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C8E964528B
	for <op-tee@archiver.kernel.org>; Wed, 26 Aug 2026 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787755253;
	bh=QvKF5mld8eVJdis1fhEPFCmryqDF0T0VDaffLARmBjw=;
	h=Subject:To:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=z+zqveU1AQYow6/mL+mvB9k8jutOVu9TxWu16iqcChsTmwNfBKEM8SljysgfXBu8D
	 ro5nqUvGR1XayZSkCdAll120IORbHe/CgyjfP0elz6WQ9rqAqBPBDnPLtwCu2IM1+2
	 33n8zPd12kGYOtTXLBMo0N8sUZ5EvddoFOWbK3nfZzAuJUDjOdOr8rcKjgpkiKiSwt
	 StavXWSkAoiNs9H5z1OIEbNyai1X9OFJcN9f200OeOsB1jgaHSPKp+94wBRSoqPAg0
	 8NRXdx5ntjqCotwgboMZmx13eGgAmAOMgZTwYvmNCBOUwzReVUGSALxr6nvuo5hcdJ
	 42m1Ae29ohn+Q==
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ADDC144DA1
	for <op-tee@lists.trustedfirmware.org>; Wed, 26 Aug 2026 14:33:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=iokpp.de header.i=@iokpp.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=tTMgJUKQ;
	dkim=pass header.d=iokpp.de header.i=@iokpp.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=+YO4xrWf;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; t=1787754768; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ky1y4V0NfpLFynWYs67/Djxdkm5nTyMlj0s7/yBT3SOzuF5WTYi/EFbPq3EBH6vQQC
    NXRrGfOrV/1I7vvG1ObQPCMiCcrps9v/UW4noSQUc1oPZu9zM4xkU3vf6fPhIJ5qsDrb
    Jtu1qjyDRWhwd9Rb0E5D9VYGXaU1jJ3PZv3wiEf4MkNO4xul0oROoYsB5Q6wZfNEeoeq
    oCURF3zbDa6V0xiM5fssHnhITnzJcZyKcRvsYVOAiZN+SjmLfs4k3gnJqS5DYlHbfZzA
    W1FltzORwFYYT3vw1ZCjSk10OElFVNEhWxcLX4Ntf76r62+DjoiLvPQiVrU2FL5zDyI7
    ao9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787754768;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QvKF5mld8eVJdis1fhEPFCmryqDF0T0VDaffLARmBjw=;
    b=VvqsIGpYqpQ041FuNDsXxBh/2dXbWvS+ZlDnxvRZgxbMM+BRTocQzafSwmf2anVoJn
    q/pzxMcGrRKFBRag8gLFTBB++Q7oRznk+eFQRcfDu82XvauV5rGLwa7ZhToXr9NdIO8U
    1BcxIa3AE27SFac9ErqLgWfgGwWnPiuUhvGJaTk2rPLQNs53hjF88NNwxx0FMKl9Qaxk
    rFvOx19BX/b3ZKi0sYPLExNzQVlG+igaBI2P5AqX1QCRBiRpPDNFURIP5g4dB/u+3hQ8
    wKRPa0rJNCDuq2wvI01oTqfkn1yLv/qgHKdHf7oW0FbXpM1+FNcX+BootVYa/gUe88lv
    w71A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787754768;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QvKF5mld8eVJdis1fhEPFCmryqDF0T0VDaffLARmBjw=;
    b=tTMgJUKQMTabq/YW6iUeiy67UqhVu90ul6VTIjklRDxwnKpznqgbxiWAcL4VrfDfPa
    MBR288o/340q5MCgkUMIbd0h3rDAw4ZeZ/dnjHZF72Olp+CvO1bQyTt51cfCBnqYXSt/
    rlvKOS+Gj+3A4TOu4HSj7kNslbJkhojspnsIn1upLRq+9Yn0PTAhPpBiXc/PelohTEhJ
    WBQHIoCUgqQ0WHsKw8hvXPhZjwygRt4FWVLai3ZLAb13b/qM6VZWEO/m3MvHV1gKE6gU
    wka8GS5V719k4ND/yn+BTo9Y96Z8KPBOoSMV0xypk5nHh0adxfzagtB8k48fgUAwhzSE
    cPUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787754768;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QvKF5mld8eVJdis1fhEPFCmryqDF0T0VDaffLARmBjw=;
    b=+YO4xrWfR9DJIxYw+svCkXeofq+oz1c4fE/TUsLok6uCfAC4zGctyxwNuvadARirOH
    o4biC6lVsnETeAqoH4BA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0DBslXBtZUxPOub3IZik"
Received: from [10.176.237.62]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze37e127QEWlUSo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Aug 2026 16:32:47 +0200 (CEST)
Message-ID: <c041d409bf6f564c6743a0d03e0c851ce3afa6d5.camel@iokpp.de>
Subject: Re: [PATCH v3 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	beanhuo@micron.com, can.guo@oss.qualcomm.com
Date: Wed, 26 Aug 2026 16:32:45 +0200
In-Reply-To: <20260821150612.3944782-3-jorge.ramirez@oss.qualcomm.com>
References: <20260821150612.3944782-1-jorge.ramirez@oss.qualcomm.com>
	 <20260821150612.3944782-3-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.44)[91.26%];
	ARC_ALLOW(-1.00)[strato.com:s=strato-dkim-0002:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iokpp.de,reject];
	ONCE_RECEIVED(0.20)[];
	R_DKIM_ALLOW(-0.20)[iokpp.de:s=strato-dkim-0002,iokpp.de:s=strato-dkim-0003];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[85.215.255.51:from];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:6724, ipnet:85.215.255.0/24, country:DE];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_NA(0.00)[no SPF record];
	DNSWL_BLOCKED(0.00)[85.215.255.51:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[iokpp.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ADDC144DA1
X-Spamd-Bar: -
X-MailFrom: beanhuo@iokpp.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: ZXJY563ESC3COSTVGPCGY3PXFFEUOJRI
X-Message-ID-Hash: ZXJY563ESC3COSTVGPCGY3PXFFEUOJRI
X-Mailman-Approved-At: Wed, 26 Aug 2026 14:40:48 +0000
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZXJY563ESC3COSTVGPCGY3PXFFEUOJRI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bean Huo via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bean Huo <beanhuo@iokpp.de>

On Fri, 2026-08-21 at 17:06 +0200, Jorge Ramirez-Ortiz wrote:
> The RPMB authentication key is derived from the dev_id handed to the
> RPMB subsystem. OP-TEE implements the eMMC RPMB flow, where the dev_id
> is the eMMC CID, a fixed 16-byte value, and it derives the key on that
> assumption.
>=20
> The UFS RPMB id built here is "<device_id>-R<region>", which is variable
> length and longer than 16 bytes. Passing it verbatim would tie the
> derived key to a length OP-TEE does not expect and diverge from the
> fixed-CID eMMC ABI, requiring OP-TEE to be taught about variable-length
> UFS ids.
>=20
> Hash the UFS id into a fixed 16-byte dev_id with blake2b instead. This
> keeps the derived key stable and unique per region while matching the
> eMMC CID layout OP-TEE relies on, so the key-derivation ABI stays
> identical and no OP-TEE change is needed. blake2b is used because it is
> already available in bootloaders such as U-Boot that must derive the
> same dev_id, avoiding the need to add a blake2s implementation there.
>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

Looks good to me!

Reviewed-by: Bean Huo <beanhuo@micron.com>
