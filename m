Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F995C55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:19:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E620045314
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:19:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OsSzBiRA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SqB0YgUN;
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 714FB44E56
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 16:14:00 +0000 (UTC)
Date: Thu, 16 Jul 2026 18:13:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784218437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqr4tN1JGvsPCmphorpsdltK9YCq4rU4faJZdR9qcJI=;
	b=OsSzBiRA1Z/gX3y2IWVwk8mZtsGZIrLDfxAhugZefES8pnSsoxM65HWeXMRPzSeFVCVYXc
	ES9VS2zDw80kW5D/QBeJ2pRqLDNk7Z/w18Fd7kV6OsZZXY42XrjwIuEMsQ7N+XAge8csZs
	aNSpZkLEleEq5DwZTy4YmzEHWZp7AzPhuh2qBRBMr3GA98BNz6jHWXMMOZif+t0vQTVVtR
	CFxsgBkPcAS6B/IlEievbVyJblmMKVOLOtsEDTf9FNfmKhEZJBI/DOKYVQ3P/S1odMITB1
	31iYTwHOSIiVMxHLMRGp4Noei5dMBcecwvwV/Vo1Hg08RpU53weecYSFriPt4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784218437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqr4tN1JGvsPCmphorpsdltK9YCq4rU4faJZdR9qcJI=;
	b=SqB0YgUNkJnhO66BVHjL1+yHZYUPaVdzPjJcs+OWj3NLDpeIKmXQ/Gy3dMod8S7/QQg7IP
	m1NHvEhBqxOzz7AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
Message-ID: <20260716161355.r2ZIoTxM@linutronix.de>
References: <20260701091226.7SWW4TrT@linutronix.de>
 <CAC_iWj+xDErhPeKGtsLK=nvPB7P8cQE3g9XCkaWf-d_j85FxCQ@mail.gmail.com>
 <20260710073147.XJAJbIwc@linutronix.de>
 <CAC_iWjLO3CAAFXE3s15Xcy3pWFK3ge5sWYmHHRBtcccKM2e1hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAC_iWjLO3CAAFXE3s15Xcy3pWFK3ge5sWYmHHRBtcccKM2e1hw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[linutronix.de:dkim];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+mx];
	RCVD_IN_DNSWL_MED(-0.20)[193.142.43.55:from];
	ONCE_RECEIVED(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:48314, ipnet:193.142.43.0/24, country:DE];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 714FB44E56
X-Spamd-Bar: -----
X-MailFrom: bigeasy@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: YJHOPYRLDGIFU2J5EJ4YCVNKKZX4MRHL
X-Message-ID-Hash: YJHOPYRLDGIFU2J5EJ4YCVNKKZX4MRHL
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:07 +0000
CC: "jenswi@kernel.org" <jenswi@kernel.org>, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YJHOPYRLDGIFU2J5EJ4YCVNKKZX4MRHL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On 2026-07-10 10:53:16 [+0300], Ilias Apalodimas wrote:
> > > > +Execution flows from the normal world (Linux) into the secure worl=
d (OP=E2=80=91TEE)
> > > > +through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot=
 disable or mask each
> > > > +other=E2=80=99s interrupts because both run at EL1 in different se=
curity states.
> > >
> > > That's not always true. It depends on a combination of OP-TEE and TF-A
> > > configs iirc.
> > > The most common though is that IRQs and FIQs are directly delivered to
> > > S-EL1, in which case OP-TEE can mask IRQs.
> > > There's also a difference between GICv2 and GICv3 in the way
> > > interrupts are delivered.
> >
> > You are saying that OP-TEE can mask Linux' interrupts or if OP-TEE
> > instructs TF-A to do so (via config)?
>=20
> OP-TEE can mask Linux IRQs

So what I got so far:
- linux has access to the normal world (not secure group 1)
- OP-TEE has access to the secure world (secure group 1)
This is for routing. And only secure world can manage secure and
non-secure its non-secure.
	https://developer.arm.com/documentation/198123/0302/Configuring-the-Arm-GIC

But then we have ICC_PMR_EL1 to enable/ disable interrupts based on the
priority and non-secure has limited priority range while secure has a
wider range. It can disable non-secure interrupts. And it took me a
while to get the right document and find this section:
| The GIC security model provides Secure and Non-secure accesses to the
| interrupt priority settings.The Non-secure accesses can configure
| interrupts only in the lower priority half of the supported priority
| values. Therefore, if the GIC implements 32 priority values, Non-secure
| accesses see only 16 priority values.

Good. Let me update so it matches the reality more closely=E2=80=A6

Sebastian
