Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8A4CD343F
	for <op-tee@archiver.kernel.org>; Fri, 15 May 2026 21:10:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1229643707
	for <op-tee@archiver.kernel.org>; Fri, 15 May 2026 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1778879430;
	bh=q+QlBhKzWzTeybhUUlTyZDSq/P/BTtweqHyw8vJCWjQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=R8Nz1RfjaBhm9nPFKJ18ibQdIrvSU6ACsn5/4xrLonxeXk/Ac2hoeUMl8m0Tu84Sd
	 TBPiGPjcSfFUJmszZTuhF27qlTC0hnlJttcbLFV2Obc2HSt9tZNk+2poXkCgJLbsFi
	 Lx/4xNmKyqEoj35fMlAf/BK6vnKglIiJKq2cfCkoldTUKb67ZVAWkwhn1LvULF74pv
	 maRLAQ5sWz69twSQJiRizZCaVNgcpISfP4RG0/aOSQYN3TVin7S2yLMjmNZJkAZCdL
	 2kaLoDrxPtL0JsZi5pS8dspK5mMXGR2P5iEExGiQez4p/fMgowLUOphZqzYGNLvSQR
	 y3OK4oll8ahRQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6A5E343707
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 21:10:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lQ57Bx9O;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D10F143856;
	Fri, 15 May 2026 21:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C263C2BCB0;
	Fri, 15 May 2026 21:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778879422;
	bh=w+3teP2/HohrpI2HRWYBxqQiTtE1OuSjTSTdwM0Bhvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQ57Bx9OXcq0K1NpqVIadVtXZmw4Z94gZ20HxBtDSaArJY5aa7Xyz8dRK0JDHS6yr
	 0sw11RStpRlxk2ea0J5hyFXWxuB16eXk5PF2URw5qq2mqzBlJ+HCcPOUph+7/oT0qn
	 /fhi+VfNHCUt9HuQ/KFpmYfyiuk/qsbZ0eFaesarIyMiVgcte6d2xQSBjBkQ9PC4VI
	 ZC6WZ+4zf3sZ2ooZWMRwwfeNtKb+jUij3k8tXDVPo76vPx3NY/hKL6Jo5jRU678OGA
	 DK9Rq4p3mbdC7v6frQUTkPwXv2GzmGq2RcaO3qNZ5R0+znuEAr+Ag2oNsD4HcQnlmx
	 URZJrdTWA3wLw==
Date: Sat, 16 May 2026 00:10:18 +0300
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
Message-ID: <ageLuuuq0HkF3ARm@kernel.org>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
 <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
 <af9QQah4QN5VD-4P@kernel.org>
 <2d00dd26-9190-4e25-bda2-b2ac9bcd5180@siemens.com>
 <ea79fd5021c0bf069746b3b450e5b2c20ba90805.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ea79fd5021c0bf069746b3b450e5b2c20ba90805.camel@HansenPartnership.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.48 / 15.00];
	BAYES_HAM(-2.98)[99.92%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[siemens.com,gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_WP_URI(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6A5E343707
X-Spamd-Bar: ---
Message-ID-Hash: NX7ELTCNMTWIPL75PXOO5275JMEY7HBK
X-Message-ID-Hash: NX7ELTCNMTWIPL75PXOO5275JMEY7HBK
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jan Kiszka <jan.kiszka@siemens.com>, "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>, Peter Huewe <peterhuewe@gmx.de>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Bauer, Sven" <svenbauer@siemens.com>, "Zeschg, Thomas" <thomas.zeschg@siemens.com>, "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NX7ELTCNMTWIPL75PXOO5275JMEY7HBK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Sun, May 10, 2026 at 11:31:12PM -0400, James Bottomley wrote:
> On Sun, 2026-05-10 at 22:42 +0200, Jan Kiszka wrote:
> > On 09.05.26 17:18, Jarkko Sakkinen wrote:
> > > On Wed, Apr 29, 2026 at 02:33:20PM +0000, Niedermayr, BENEDIKT
> > > wrote:
> > > > On 10/27/25 20:51, Jarkko Sakkinen wrote:
> > > > > On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
> > > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > >=20
> > > > > > As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM
> > > > > > may write the current time epoch to its NV storage every 4
> > > > > > seconds if there are commands sent to it. The 60 seconds
> > > > > > periodic update of the entropy pool that the hwrng kthread
> > > > > > does triggers this, causing about 4 writes per requests.
> > > > > > Makes 2 millions per year for a 24/7 device, and that is a
> > > > > > lot for its backing NV storage.
> > > > > >=20
> > > > > > It is therefore better to make the user intentionally enable
> > > > > > this, providing a chance to read the warning.
> > > > > >=20
> > > > > > [1] https://github.com/Microsoft/ms-tpm-20-ref
> > > > > >=20
> > > > > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > > >=20
> > > > > Looking at DRBG_* from [1] I don't see anything you describe.
> > > > > If OPTEE writes NVRAM,=A0 then the implementation is broken.
> > > > >=20
> > > > > Also AFAIK, it is pre-seeded per power cycle. There's nothing
> > > > > that even distantly relates on using NVRAM.
> > > > >=20
> > > > > [1]
> > > > > https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83=
-Part-4-Supporting-Routines-Code.pdf
> > > >=20
> > > > Hi all,
> > > >=20
> > > > we recently also stumbled over this issue which led me here to
> > > > this thread and maybe adding our observations helps to clarify
> > > > things here a bit (hopefully) or at least augments the
> > > > information related to firmware TPM based implementation based on
> > > > ms-tpm-20-ref.
> > > >=20
> > > > Based on the optee_ftpm repo, as Jan already described, which
> > > > currently references commit 98b60a44aba7 of [1] suffers this
> > > > exact issue because of the NV_CLOCK_UPDATE_INTERVAL [2] which is
> > > > set to "12" and issues a write for each command after ~4 seconds
> > > > have passed.
>=20
> You keep quoting this to us, and other parts of the spec.  However, you
> forgot to quote from the Section 7 compliance statement in the same
> spec which says:
>=20
>    the NV subsystem of the reference implementation is not
>    representative of the actual implementation of most physical NV
>    implementations but is a crude analog.
>=20
> I get that the the optee people failed to realize this and only just
> corrected the mistake, but the fact is that all other TPM
> implementations, both physical and firmware don't have this wear
> problem you've given yourselves because they noticed.

I guess a quirk could be considered, if there was a specific commercial
chip product or firmware TPM using optee but of course that would not be
"optee fix". It would be applied on when that particular device would
be identified i.e., not across the board.

Just mentioning this for completeness, fully agree what you said :-)

>=20
> > > > This config has been changed to "22" (on current master branch
> > > > [3]) which is the allowed maximum when following the TPM spec
> > > > (chapter 36.3.2 in [4]) which leads to round about 70 minutes,
> > > > but optee_ftpm didn't move ahead to this commit, yet.
> > > > This config exists for being able to adapt the write cycles to
> > > > the specific wear conditions of the hardware.
> > > >=20
> > > > Moreover the ms-tpm-20-ref repo seems to not be maintained
> > > > anymore and one should rather switch to [6].
> > > >=20
> > > > So there are currently firmware TPM implementations out there
> > > > that lead to these frequent writes.
>=20
> Yours is the only one I've ever come across.
>=20
> > > Really this would need a product and official bug bulletin for it
> > > to even consider a workaround. Speculation does not count.
> > >=20
> >=20
> > The key point Benedikt tries to make here is that the TPM 2 spec
> > forces any vendor to do something about persisting the last seen time
> > at  least every 70 min. If they didn't do that, then they would
> > violate the space=A0
>=20
> That's correct, but a red herring: if the optee TPM had done this 70
> minute flush ab initio you wouldn't have the wear problem because the
> seed writes would be much less frequent.
>=20
> > - arguably a bug.
>=20
> Well, not following the spec is a bug, yes, but it's not a bug in the
> kernel ...
>=20
> Regards,
>=20
> James
>=20

BR, Jarkko
