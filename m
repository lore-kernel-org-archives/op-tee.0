Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE74C43458
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 07:54:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 82C2744B0C
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 07:53:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jSZwGMUH;
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 160AC44B0C
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 07:53:53 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664a09bc459so966807d50.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 00:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783670032; cv=none;
        d=google.com; s=arc-20260327;
        b=U0Oa8xrzEhGXkOf39kV54L9tsHmwGpI3t40MKWdSLjC58lfYJG3xU0dMJS3H5qDuuJ
         EP7hEEVORRF9ed094DUBss878zp2z9UM4VYILRNGMlDNbtWTJOzy/ZlWCDglp/6ppc7R
         KNomrYlSdnWA9EFLuTQk1D1vOnC9dMrpBJY2mmiRbWfwiKwFHWnxUSC8gjS8WxPpeA28
         Nki4zm45NJjUEwNNzJFR/2wBYwLPo4V/hIL7aVwlyvZuUNZ6aEEY7hMnxG81wTLi9XVQ
         phZZ0oGr0uhfZDqkG1HoidciQGB8i7v/UQ7lHJ7uEB8gHAWyACLByflYeJmLcj45fdYj
         jHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOWM6CrABsSE1ZgAmtTX+wv+twEBAQ/PjFUZeWerkIA=;
        fh=8EpxRXrHK/ieEoYHE2JmqrrkxdM68lP8rDt5w4KCqEc=;
        b=Xd/lNPh+enSz70qIOsDG6Wy56noARkV2S0hAef523PzWz4uCGssmF12hi3m30Tngz4
         pAhf1gIw/qxwm7/M6KT8fcICWY4ZVmY6Uh4MfXzMkTnpCwIR0ygYCDLzEjoxO+IrUCRD
         RxnuYrKMoIJzCshzyFbC70NR3HeXOw/GTXGi1bFfofAazft8uPfbugwodAFkANnNdE2w
         MI/+Nk5wFPd8Lp/WRnBpO1/PrU8uK0Qjo+wbzVWt3l0Nd5QiFM2CJobkKFDRLcF167OF
         uKh9GQPuNfqWOBsDgOTAuURhhgV6bNhI4aZfSvNVXMlFxef3FD7RfrRmFdIdWVE204pn
         FBdA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783670032; x=1784274832; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VOWM6CrABsSE1ZgAmtTX+wv+twEBAQ/PjFUZeWerkIA=;
        b=jSZwGMUHDwWFeI0cPdiLs8RsdOZcs+YPdULMz4qX1WNtcm5+37WJtxai9E1k4blnZr
         Qw2ydHSafiMSrt/qBwjGTD7SmA0o/XJ/HbnyO9kW5ug67BiyxsDtbIUz/i9N8vnc1Avj
         xQXUathK2emsjTjV8WlZnCNteFFqjOkNoQpMdO+FezBCzpQUFq8xNf/tsZxZRohFcuvv
         OwNRjGRIvMTK28/iW+McYsj1r3td0D7lzWHsJUuKAGhq4jw1QigTkEBA3FMCXKqGjFm8
         Kty2cHnwrCLRfSdBZJMVOJTHvtq7eMsquTjQnbbxVf+Ey78M2WkgGewVvKA15EjzCzG9
         q3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670032; x=1784274832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOWM6CrABsSE1ZgAmtTX+wv+twEBAQ/PjFUZeWerkIA=;
        b=DLODiJowkH6rtka9zq6TjA7QzkDK5fJXbZgu/IMCjEH7SxaRElGN4O57SZNYbID4wc
         C2Kl/AJFq6I5Jqab3Yv7S3+hISDXFv1fK3f2NZdWW+r2onpxZX7TMbuGYhEX4IhNns7u
         C3eNc3jVdR4XE7kZotrozWXZaMA+D8VDpppdK/qYZ8Dm+U0ihmsWF8QLTFlIvNNw6uFg
         px8w6xuVh02eOf8O5Ef/rmWQKFHk9GY4cnzW7sBmy+lQvATVR2ZoWHkJmcDRUad1bgt7
         6n2fgWdKdxsJQKY5GaHfTFFmvX0EfWPWeRSM9PwUEPTKmWYu0Fg9iF/wzYQY+zjnWFDK
         7HHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDS9ciu1b4mmhzJWNIfqqOe2uK4FK1sPZCYVDZICSuS3/6YTJe4BSAmhrRhmrLQXAIxuocXy0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzf36AuU18M5AV660JI475WaSPW+jZgkzCU4zUbfepTO/3GK1Cn
	+iDs7mTvqe54/b8O0qe3yPfqjtpJbpEcYlThcoH18VzbKCXVxA2XmIglB3FY/0cqFQ1vsBp8Meq
	LZBufBwxfd1XPJc6gn9nv8hZ11Gs7FPU4yR4TZROQS40B
X-Gm-Gg: AfdE7clAlULv1ncDm0JjR/YLatNHH1IRd3OR1tQeniGHQXfnJ4MS7/w3hKXPSTHMr0F
	YtpF5gyuoVFtUtQVELfSxDG9tDw4tvZ5qc+BZ4FiIYEIGphFJztJZ4w4w+WTNEEDqLbOfN6Zraa
	Xlgpzw380ElPWsnMVU7Tvo70wIiRCIK7rVNOhQUW4SwvJatsCprzKUJ1qiCiGQDgATiACLZ/vcQ
	azqwNsNV+c7dDuv1ct1HEBXAm6u6J5oY0trwWNzcugb5jiclVzdaDxZ8LP2A/BngcD3of1Nxm68
	twdDdnZwlEtCd+FjbaL6mmGujHbYezfqYYpALI+Kbx0u2x0HM6TLGUGZeyAFQV794zdMvAi5PCt
	DqOtlE3eO3GNkcwL++qup+n7bDCQH+sekZmcTwNtYBSvTvudzgeu4lYPaVm6cqeqokDvkEHW1kr
	EayFkbheOmzcL4T5IFJOWL7UneMNclCGDun0kCv6P6GQcyKpVraF3yV5zV8+f947jLlyVe9daTS
	/7kMOULZP0zsONWT1WoW0a77w9DYU4pqoc7Usroi/ryYhY9pB5cte1u9frmVNaEG+jKvGKe+ret
	qSd6Xn/Yb5O/GPO1GLHX93isDguACgmzjW7uWzuZUEqNJA9gA7e0+9Yp3ZsvAk6UOZxbGovX1gr
	TMKY8Tw==
X-Received: by 2002:a05:690e:43d4:b0:664:99a3:34a7 with SMTP id
 956f58d0204a3-6679f1ac64amr4926164d50.60.1783670032531; Fri, 10 Jul 2026
 00:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260701091226.7SWW4TrT@linutronix.de> <CAC_iWj+xDErhPeKGtsLK=nvPB7P8cQE3g9XCkaWf-d_j85FxCQ@mail.gmail.com>
 <20260710073147.XJAJbIwc@linutronix.de>
In-Reply-To: <20260710073147.XJAJbIwc@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Jul 2026 10:53:16 +0300
X-Gm-Features: AVVi8CfEoTWISJnCnc9-eLJA2a3H9SubdRhk1-OoqodnM6Xg_e0TDYWFCpSokGU
Message-ID: <CAC_iWjLO3CAAFXE3s15Xcy3pWFK3ge5sWYmHHRBtcccKM2e1hw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.224.53:from];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 160AC44B0C
X-Spamd-Bar: ----
Message-ID-Hash: NVL54UJ5OVTLKTKL6LVEVKRM4DZIYQQZ
X-Message-ID-Hash: NVL54UJ5OVTLKTKL6LVEVKRM4DZIYQQZ
X-MailFrom: ilias.apalodimas@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "jenswi@kernel.org" <jenswi@kernel.org>, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NVL54UJ5OVTLKTKL6LVEVKRM4DZIYQQZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, 10 Jul 2026 at 10:31, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-07-10 09:29:55 [+0300], Ilias Apalodimas wrote:
> > Hi Sebastian!
> Hi Ilias,
>
> > > +++ b/Documentation/core-api/real-time/hardware.rst
> > > @@ -130,3 +130,95 @@ https://github.com/Linutronix/RTC-Testbench.
> >
> > [...]
> >
> > > +
> > > +OP-TEE (ARM)
> > > +~~~~~~~~~~~~
> >
> > That's RISC-V as well nowadays
>
> I did not find much here. Their architecture isn't the same as on ARM is
> it? But the overall concept is the same, right?

I haven't checked the IRQ vectors on risc-v, but I assume they have a
similar logic since that's an OP-TEE design decision not a per
architecture one.

>
> > > +
> > > +OP=E2=80=91TEE uses a global serialization mechanism (the "big lock"=
), ensuring that on
> > > +each core only one OP=E2=80=91TEE thread executes secure=E2=80=91wor=
ld code at a time.
> > > +
> > > +Execution flows from the normal world (Linux) into the secure world =
(OP=E2=80=91TEE)
> > > +through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot d=
isable or mask each
> > > +other=E2=80=99s interrupts because both run at EL1 in different secu=
rity states.
> >
> > That's not always true. It depends on a combination of OP-TEE and TF-A
> > configs iirc.
> > The most common though is that IRQs and FIQs are directly delivered to
> > S-EL1, in which case OP-TEE can mask IRQs.
> > There's also a difference between GICv2 and GICv3 in the way
> > interrupts are delivered.
>
> You are saying that OP-TEE can mask Linux' interrupts or if OP-TEE
> instructs TF-A to do so (via config)?

OP-TEE can mask Linux IRQs

>
> > > +
> > > +Architecturally, the secure monitor can mask or reroute normal=E2=80=
=91world interrupts
> > > +before entering the secure world. In a correct OP=E2=80=91TEE/ TF=E2=
=80=91A implementation, it
> > > +does not do this for the duration of secure calls. Normal=E2=80=91wo=
rld interrupts
> > > +remain deliverable, and a normal=E2=80=91world IRQ will preempt OP=
=E2=80=91TEE via EL3 and
> > > +return control to Linux.
> >
> > The 'sane' case is indeed where IRQs are delivered to OP-TEE which
> > exits back to Linux immediately.
> >
> > > +
> > > +Secure=E2=80=91world interrupts (FIQs) are possible if the SoC route=
s a device's
> > > +interrupt as secure. Such a secure FIQ will preempt Linux immediatel=
y, trap
> > > +into EL3, and transfer control to OP=E2=80=91TEE's secure interrupt =
handler. Linux
> > > +cannot mask or preempt this. Secure FIQ handlers must therefore be e=
xtremely
> > > +short to avoid introducing noticeable latency.
> >
> > There are also 'fast SMCs', which run with IRQs disabled for their
> > entire duration.
>
> can their be distinguished somehow from normal SMC invocations or is
> just a consequence that the secure monitor does not enable interrupts
> during transition for some of the "functions"?

They can be identified. There's a function identifier defined in the
SMC calling conventions doc [0].
Bit 31 is always 1 for fast calls and 0 for yielding.

>
> > > +
> > > +The transition from normal world -> secure monitor -> OP=E2=80=91TEE=
 and back introduces
> > > +additional latency due to world switching and context save/ restore.=
 This
> > > +overhead is typically a few microseconds and usually remains in the =
noise
> > > +floor.
> >
> > That's correct.
> >
> > > +
> > > +If the secure monitor masks normal=E2=80=91world interrupts during O=
P=E2=80=91TEE invocations,
> > > +or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers, =
then OP=E2=80=91TEE can introduce
> > > +measurable latency spikes.
> > > --
> > > 2.53.0
> > >
> >
> > Overall I think this is worth documenting, but infortunately there's a
> > wider range of configs and corner cases we have to describe.
>
> Okay.

[0] https://developer.arm.com/documentation/den0028/h/?lang=3Den

Cheers
/Ilias
>
> > Cheers
> > /Ilias
>
> Sebastian
