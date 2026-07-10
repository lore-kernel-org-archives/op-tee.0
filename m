Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621FBC55174
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:18:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A11FF45295
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:18:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CYWc2XMP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=zkjkvLix;
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 570B043AD8
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 07:31:50 +0000 (UTC)
Date: Fri, 10 Jul 2026 09:31:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783668708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JneN2M9JbJqKy6qgUPNItB4lcaDHbu64RY5+o9oIB6c=;
	b=CYWc2XMP2kSKRhOqDExn2t5iOXHPKvWWyfoW0a/ze3JYCZ5vMi4FDPWwqUMQJ8/ls5rI9t
	Y6Sh03ZTfPt2czfIo/cFlYooQxO//Lxgj/5e0psGv+3tSOvph6UeW82CAhaI3j5mljprsu
	BldCShDzu1wd/eyS6Ol6IYrJEKqKkYsWOr0Ml3Ekkxzp5nIKzWRjGvi4aXfka6i3A6uSVi
	Y4Inty2gqa/naFDDlqJ1H/n42Jrset+NK18LImANbATiDgId3ZX0RTSqjlEUIyRAPDnbnk
	bad8x5VHi8Lno0MQnH0cbYzkMO+Dd/LS9J5crKezaviuSkRutX/5w0mfKtGZ9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783668708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JneN2M9JbJqKy6qgUPNItB4lcaDHbu64RY5+o9oIB6c=;
	b=zkjkvLixw+0vNVj1P8Y/gayysL+dJb4IuUxB5JvbUshMLYJ87X5OIZgQyRmbn7tYArod5m
	K11MxyLDpE7zzFDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
Message-ID: <20260710073147.XJAJbIwc@linutronix.de>
References: <20260701091226.7SWW4TrT@linutronix.de>
 <CAC_iWj+xDErhPeKGtsLK=nvPB7P8cQE3g9XCkaWf-d_j85FxCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAC_iWj+xDErhPeKGtsLK=nvPB7P8cQE3g9XCkaWf-d_j85FxCQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+mx];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	ONCE_RECEIVED(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:48314, ipnet:193.142.43.0/24, country:DE];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 570B043AD8
X-Spamd-Bar: ---
X-MailFrom: bigeasy@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: HRBDRUX7HZHORLTF2AKAWZ7OXCNRVDHK
X-Message-ID-Hash: HRBDRUX7HZHORLTF2AKAWZ7OXCNRVDHK
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:07 +0000
CC: "jenswi@kernel.org" <jenswi@kernel.org>, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HRBDRUX7HZHORLTF2AKAWZ7OXCNRVDHK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On 2026-07-10 09:29:55 [+0300], Ilias Apalodimas wrote:
> Hi Sebastian!
Hi Ilias,

> > +++ b/Documentation/core-api/real-time/hardware.rst
> > @@ -130,3 +130,95 @@ https://github.com/Linutronix/RTC-Testbench.
>=20
> [...]
>=20
> > +
> > +OP-TEE (ARM)
> > +~~~~~~~~~~~~
>=20
> That's RISC-V as well nowadays

I did not find much here. Their architecture isn't the same as on ARM is
it? But the overall concept is the same, right?

> > +
> > +OP=E2=80=91TEE uses a global serialization mechanism (the "big lock"),=
 ensuring that on
> > +each core only one OP=E2=80=91TEE thread executes secure=E2=80=91world=
 code at a time.
> > +
> > +Execution flows from the normal world (Linux) into the secure world (O=
P=E2=80=91TEE)
> > +through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot dis=
able or mask each
> > +other=E2=80=99s interrupts because both run at EL1 in different securi=
ty states.
>=20
> That's not always true. It depends on a combination of OP-TEE and TF-A
> configs iirc.
> The most common though is that IRQs and FIQs are directly delivered to
> S-EL1, in which case OP-TEE can mask IRQs.
> There's also a difference between GICv2 and GICv3 in the way
> interrupts are delivered.

You are saying that OP-TEE can mask Linux' interrupts or if OP-TEE
instructs TF-A to do so (via config)?

> > +
> > +Architecturally, the secure monitor can mask or reroute normal=E2=80=
=91world interrupts
> > +before entering the secure world. In a correct OP=E2=80=91TEE/ TF=E2=
=80=91A implementation, it
> > +does not do this for the duration of secure calls. Normal=E2=80=91worl=
d interrupts
> > +remain deliverable, and a normal=E2=80=91world IRQ will preempt OP=E2=
=80=91TEE via EL3 and
> > +return control to Linux.
>=20
> The 'sane' case is indeed where IRQs are delivered to OP-TEE which
> exits back to Linux immediately.
>=20
> > +
> > +Secure=E2=80=91world interrupts (FIQs) are possible if the SoC routes =
a device's
> > +interrupt as secure. Such a secure FIQ will preempt Linux immediately,=
 trap
> > +into EL3, and transfer control to OP=E2=80=91TEE's secure interrupt ha=
ndler. Linux
> > +cannot mask or preempt this. Secure FIQ handlers must therefore be ext=
remely
> > +short to avoid introducing noticeable latency.
>=20
> There are also 'fast SMCs', which run with IRQs disabled for their
> entire duration.

can their be distinguished somehow from normal SMC invocations or is
just a consequence that the secure monitor does not enable interrupts
during transition for some of the "functions"?

> > +
> > +The transition from normal world -> secure monitor -> OP=E2=80=91TEE a=
nd back introduces
> > +additional latency due to world switching and context save/ restore. T=
his
> > +overhead is typically a few microseconds and usually remains in the no=
ise
> > +floor.
>=20
> That's correct.
>=20
> > +
> > +If the secure monitor masks normal=E2=80=91world interrupts during OP=
=E2=80=91TEE invocations,
> > +or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers, th=
en OP=E2=80=91TEE can introduce
> > +measurable latency spikes.
> > --
> > 2.53.0
> >
>=20
> Overall I think this is worth documenting, but infortunately there's a
> wider range of configs and corner cases we have to describe.

Okay.

> Cheers
> /Ilias

Sebastian
