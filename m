Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269D3CA0EFA
	for <op-tee@archiver.kernel.org>; Tue, 26 Aug 2025 10:57:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5CE9F4FBAC
	for <op-tee@archiver.kernel.org>; Tue, 26 Aug 2025 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756205852;
	bh=fNe1kp3DfFORbV5dFyXOsCtL2IAoaaqGvHcIUTYO8eg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=25PnPnFZ7EWmp/XyGv2qwMutHdjPwdrzuwC6w05xehX8FPY9PhLeN9MzIEtReQalV
	 Gq6GAwQmFWoia34K0aIXZgiM/TlYOurBGpD7dWjzY52AzL6NkyZlBUAmXRtgiElnFd
	 lTh0UchfsC0eTXxA2ksLUBYTJr83JNypmcmAXVDC5NpLCpKVfhhPLm85USTSrM6Fsg
	 rilgKF8okfzdNme4nrL4ABQD8mQ/nNAo79yvNDYrgCRpVNl2sA6+zBjqNLHKLNBg2r
	 bkSBBYjF6wn/hDQPxBvMAkuAHBeMQo6+JC/S5CTHlpOCtyHvLs6nOpqkviZGJKBnfy
	 TIEERhFIhepCg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CD54142ED9
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 Aug 2025 10:57:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PW48y6bA;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F20E960287;
	Tue, 26 Aug 2025 10:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9602C4CEF1;
	Tue, 26 Aug 2025 10:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756205835;
	bh=4ukNHbVqCi+yqAnyQiQahFz02Zt7qNQ8VPyfouRTSbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PW48y6bAdLNKYkpa/WJ6dI3/RdwL9wd3EOpfUEWyoT9l+NV7GixTER0W+fBl3yJkS
	 9SKGu9QbyJQlxdxKvmwbW/9B9dDGWctSwtR59CUIxXf2zDBxUmpBgFHmYaVMJX3Icq
	 PRhKEl4De5d6fRFGZQ4PddvEM3ZmYyKzgQMGIHGXoTUsiax5HDtgAMAzcd2y/GfIC+
	 3+glRWiMUyPT+76CpodzFB7+nc4DUT0bRG110NuFYUGDDWlDt3JTm9ZRsic2gcxo+Y
	 Xh6aRYv/zH2TmF/Gp/9sUpEcMDec1bwxElGSd2dfLyALgbE7i0UuLRhYDs9kp/bDgn
	 ljTeiWWpt4/6Q==
Date: Tue, 26 Aug 2025 16:27:10 +0530
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 0/8] sd: Add RPMB emulation to eMMC model
Message-ID: <aK2TBkzW7nDobJ5O@sumit-X1>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
X-Rspamd-Queue-Id: CD54142ED9
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 7F22TZ3XA2GNJYH6TTUJRXWOKKG7KGM3
X-Message-ID-Hash: 7F22TZ3XA2GNJYH6TTUJRXWOKKG7KGM3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, cip-dev <cip-dev@lists.cip-project.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7F22TZ3XA2GNJYH6TTUJRXWOKKG7KGM3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Sun, Aug 24, 2025 at 09:41:06AM +0200, Jan Kiszka via OP-TEE wrote:
> FYI: QEMU model is working fine, upstreaming started, feedback welcome.

Thanks Jan for sharing, it really enhances the testing capability around
RPMB based secure storage.

>=20
> Jan
>=20
> On 24.08.25 09:18, Jan Kiszka wrote:
> > This closes an old gap in system integration testing for the very
> > complex ARM firmware stacks by adding fairly advanced Replay Protected
> > Memory Block (RPMB) emulation to the eMMC device model. Key programming
> > and message authentication are working, so is the write counter. Known
> > users are happy with the result. What is missing, but not only for RPMB-
> > related registers, is state persistence across QEMU restarts. This is OK
> > at this stage for most test scenarios, though, and could still be added
> > later on.
> >=20
> > What can already be done with it is demonstrated in the WIP branch of
> > isar-cip-core at [1]: TF-A + OP-TEE + StandaloneMM TA + fTPM TA, used by
> > U-Boot and Linux for UEFI variable storage and TPM scenarios. If you
> > want to try: build qemu-arm64 target for trixie with 6.12-cip *head*
> > kernel, enable secure boot and disk encryption, then run
> >=20
> > $ QEMU_PATH=3D/path/to/qemu-build/ ./start-qemu.sh
> >=20
> > Deploy snakeoil keys into PK, KEK and db after first boot to enable
> > secure booting:
> >=20
> > root@demo:~# cert-to-efi-sig-list PkKek-1-snakeoil.pem PK.esl
> > root@demo:~# sign-efi-sig-list -k PkKek-1-snakeoil.key -c PkKek-1-snake=
oil.pem PK PK.esl PK.auth
> > root@demo:~# efi-updatevar -f PK.auth db
> > root@demo:~# efi-updatevar -f PK.auth KEK
> > root@demo:~# efi-updatevar -f PK.auth PK
> >=20
> > Note that emulation is a bit slow in general, and specifically the
> > partition encryption on first boot is taking 20 min. - we should
> > probably reduce its size or understand if there is still something to
> > optimize.

Can you try with KVM enabled? I suppose that should allow you to use
Armv8 CPU Crypto Extensions. However, do you host a Qemu branch with
these patches applied? I think that would enable folks to use that in
OP-TEE build setup.

-Sumit

> >=20
> > Jan
> >=20
> > [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip=
/qemu-rpmb
> >=20
> > Cc: "Daniel P. Berrang=E9" <berrange@redhat.com>
> >=20
> > Jan Kiszka (8):
> >   hw/sd/sdcard: Fix size check for backing block image
> >   hw/sd/sdcard: Add validation for boot-partition-size
> >   hw/sd/sdcard: Allow user-instantiated eMMC
> >   hw/sd/sdcard: Refactor sd_bootpart_offset
> >   hw/sd/sdcard: Add basic support for RPMB partition
> >   crypto/hmac: Allow to build hmac over multiple
> >     qcrypto_gnutls_hmac_bytes[v] calls
> >   hw/sd/sdcard: Handle RPMB MAC field
> >   scripts: Add helper script to generate eMMC block device images
> >=20
> >  crypto/hmac-gcrypt.c   |   4 +-
> >  crypto/hmac-glib.c     |   4 +-
> >  crypto/hmac-gnutls.c   |   4 +-
> >  crypto/hmac-nettle.c   |   4 +-
> >  hw/sd/sd.c             | 314 ++++++++++++++++++++++++++++++++++++++---
> >  hw/sd/sdmmc-internal.h |  24 +++-
> >  hw/sd/trace-events     |   2 +
> >  include/crypto/hmac.h  |  12 ++
> >  scripts/mkemmc.sh      | 185 ++++++++++++++++++++++++
> >  9 files changed, 530 insertions(+), 23 deletions(-)
> >  create mode 100755 scripts/mkemmc.sh
> >=20
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
