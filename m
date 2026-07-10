Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE034C43458
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 06:30:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C2EE644E25
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 06:30:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u/6kd7dm;
	dkim-atps=neutral
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EE00343259
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 06:30:31 +0000 (UTC)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66771ded50aso976971d50.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 09 Jul 2026 23:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783665031; cv=none;
        d=google.com; s=arc-20260327;
        b=GGqXsS2TVIhQ0jszYksD0SdHxJNx6aBGC6EqYMbSYmxuKaOC5DVfsks12tB4CW5kdx
         +uH0kEDLTNMjJudbrdvaNxlhnDR1FmrNdh6rjAc1ZPHargi5uKcl38X9nJg0Q2lYvqEz
         wzAx/okJ9gGqyIPNS3KNnvq2ZVYCtNa+dhmdLg4vAsDybuMmaa0y5zR0s88crtUQrtRm
         DDY89Z0pS1bAOtCLVQgOjIW0MzM0bjE5uVcpEQTf9A8eihHahrSIqwHqAz2iVafzPLCP
         2jg510hZ4+IHx/25+j8VM65SHHfANjC0WnFlEgKjis4tvIQVPs1mSrydgI+sKtuFQKDU
         H+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZT819g/Oq6qSvxizAhqmr/HnAVYEmomTbXe1mM2C/vA=;
        fh=9dOv4lIYwseV5KBJStd2ylhQ+rMJ4zIY8Ekv3Las6e4=;
        b=HeEpqOtVMziqyj1/BbP3IrkZQvfZ/ZD7odR+/RI2KmJIHHfQs8FWX8tteK9dI/TEEo
         mZo4qKan1mVML7MhJjuLKTCMe6fXasqh+wMKJ5xLIDWpnaraSuG3vpRFXchLSzfPGBdh
         qTfqAYuyuY1Yf+0LA8ZfJ/hIS8I1GejuaX1fxUfDHOMpqnGrTP3lbCoDwYqRSNIgqUIV
         kiK/M68NOzIBKvNFdN0jmcwe+FerdzAPhIWW2hY2LYw/wKT2m9QCGRQ4UOSk7aHjnEzu
         iG91yTgTih/pdmqeEjEHDBoHWOsridJITqH9yS+9deSTTzRp7gfVQd8zJGCObMJl9Zbp
         09sA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783665031; x=1784269831; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZT819g/Oq6qSvxizAhqmr/HnAVYEmomTbXe1mM2C/vA=;
        b=u/6kd7dmdic3TdUYjZqbR/OG0tTbPmwOe020VOavPvgw3eZcWEBJnaSzT6ZQBfj1K4
         uJN2eOGqZUgr609z18aY8+DIYkNO2uzmy1CzhdpOAvbpsgXAA0P7tglutjbHf10r9HnI
         VkP6BxyRnuzn74sNEoGysLo2GFo+1LbHOjNduz+N3nyu9nRHO3mGrRV13zxiAg6MvNMM
         eMgCloUTf1bKqx6K1ojCg/0j8+ioLXGrtRt9i5ZgZDlwCiR14UWdpLVo0A3UI2mgFid2
         Tz/o6rdqbSuS/hdZ09FKz312gYbQFIocegndoBrFfT2g2Bk7cdG07o+60Nd1vWZb+EG9
         qZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783665031; x=1784269831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZT819g/Oq6qSvxizAhqmr/HnAVYEmomTbXe1mM2C/vA=;
        b=bsq+VW1NGGsJ5bJGnaIZv5wEKXfcr67kTibV93cxi1ua0gpBV1VacXlCQwZ+eex/Ai
         6W4N6dzxoZHDU1mjp2PAJ/ursE16SaCYyO4Tlu28xMjj6JUlOpJrG+rBM1yPglzICtdl
         EHQcxxpM1CsxlqZGAP3YJIYGrEtoQOmbKLnXMfBSNXn/MLe5/lSG584le2aeoN9mVh9x
         HWMBBb+6oWijiWykNwZF25kMTnrQoSCwfufGfrTHbxb53NLTJCgvgcDyDFdm3vh5R4hE
         pThiYo+tvMmusV618Kz3OZFr9lBLkcfu79zww+YlYUM25X6g06QVN+8WCwf9O/Vn8Uj+
         1ucg==
X-Forwarded-Encrypted: i=1; AHgh+RrLfMplQSB9HjvPeG8pfTcDcndvQL1FgNiS7zZoMtK2vpKzaH5Pyu+ebGr4M5abuKxuTMXsYdk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxuYAeRKyKJ7ak+tKNNDsFkv03rjm+AZQP1vNb5s5Q1pYbXKsHp
	tkc1k5I8oV45WYyyVPnU7gE7hTi9iW7VjWZUj9CgNKEuEYD10Irp60PsqmTF6si76boOPEokP4g
	NXgPKuB7ahYutKSvsHOo88PHIbeMYN5w7i+0kLBDqSIG7
X-Gm-Gg: AfdE7ckThH86TYCRySnQoftMuQvMdweU4E3EXd0VghIq/LRP8eLU9eLP4NzqP/2vaE2
	F/nDA91/rKd35qGjzGkN/SZ8FlOKNNjAiqcbjlvSvuy5orgPQXDiTJGHLu5t9sTjlLdMn5mQBXS
	ejnMHUjbQcHXR6X3IhDB6igjzUKEGwvBJ41hVlqpwuJ+CzyrxYXbUaJmJ+A2mzof35raCkTutly
	k+x4Xb1gXRbhUGgmy/MMfBsPsiZvzHCXeu+cn06Sc4ToDOJLd9OfFAp1r543wrBKXw8vUs6P8fA
	P+UHeZvArCXIaIzp8A32vev+P0hfBuZPgCiL8X4xZtFpfGVEBZc4BAkw+sfQ0wnLm79nMNaosAg
	W8TbKqIT1Oadj3CPXXn2PaQgA4NzKPqsrxMNDwkmFZhD/gFdqlwZ4XU1VO8iXKFlZEn+7BRVQDz
	vUitro/yEg+xlufj8ZhoNNBhg5w6sIC/XT4ARQ6dtZVM2N3+BACIOTNb5j5L7ow+7SmzaD0DbEb
	spepFI0JlYcacQYNApAXStvSqD1WCVeNsc++huhbWkmzxa5/UD9B7v4HuQ2QfD327vW6WriEb2W
	QxDy82C4sqlCtpTYfn0JMvvzR9qzHWzO1HFy0U08kwzMZretgCk9t2a4LIBcrDOVmR4JlNY=
X-Received: by 2002:a05:690e:1609:b0:667:9eb2:8ffd with SMTP id
 956f58d0204a3-6679f25cc74mr4981051d50.90.1783665031305; Thu, 09 Jul 2026
 23:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260701091226.7SWW4TrT@linutronix.de>
In-Reply-To: <20260701091226.7SWW4TrT@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Jul 2026 09:29:55 +0300
X-Gm-Features: AUfX_mxLJVuqDQuycLYMMiskfwdItuud7PupTjy9MFHq6Q3HmuV1dekuQzstXtk
Message-ID: <CAC_iWj+xDErhPeKGtsLK=nvPB7P8cQE3g9XCkaWf-d_j85FxCQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "jenswi@kernel.org" <jenswi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.224.45:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EE00343259
X-Spamd-Bar: ----
Message-ID-Hash: GY33NSVPO522C37HIULIVAYJHGPKCCRG
X-Message-ID-Hash: GY33NSVPO522C37HIULIVAYJHGPKCCRG
X-MailFrom: ilias.apalodimas@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GY33NSVPO522C37HIULIVAYJHGPKCCRG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Sebastian!

I'll let Jens fill in the gaps. Some general comments below.

On Wed, 1 Jul 2026 at 12:12, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> I have been reviewing how OP=E2=80=91TEE is implemented and how secure=E2=
=80=91world
> invocations behave. The goal was to determine whether an OP=E2=80=91TEE c=
all can
> delay the Linux side and introduce latency depending on the time spent
> in the secure world.
>
> Similar latency effects are already known for EFI runtime services, but
> this was not documented. To mitigate the impact, EFI runtime invocations
> can be restricted to specific CPUs so that real=E2=80=91time workloads on=
 other
> CPUs remain unaffected. This mechanism, however, is only described in
> the commit that introduced it.
>
> This change adds a firmware section that documents these behaviours
> explicitly. It highlights cases where firmware can delay the kernel,
> information that may be unfamiliar to some users and surprising-or
> concerning-to others.
>
> Assisted-by: Microsoft-Copilot
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> I would appreciate an ACK from the OP-TEE camp that I got my little
> research right.
>
>  Documentation/core-api/real-time/hardware.rst | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/Documentation/core-api/real-time/hardware.rst b/Documentatio=
n/core-api/real-time/hardware.rst
> index 19f9bb3786e03..fb113848c2f70 100644
> --- a/Documentation/core-api/real-time/hardware.rst
> +++ b/Documentation/core-api/real-time/hardware.rst
> @@ -130,3 +130,95 @@ https://github.com/Linutronix/RTC-Testbench.

[...]

> +
> +OP-TEE (ARM)
> +~~~~~~~~~~~~

That's RISC-V as well nowadays

> +
> +OP=E2=80=91TEE uses a global serialization mechanism (the "big lock"), e=
nsuring that on
> +each core only one OP=E2=80=91TEE thread executes secure=E2=80=91world c=
ode at a time.
> +
> +Execution flows from the normal world (Linux) into the secure world (OP=
=E2=80=91TEE)
> +through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot disab=
le or mask each
> +other=E2=80=99s interrupts because both run at EL1 in different security=
 states.

That's not always true. It depends on a combination of OP-TEE and TF-A
configs iirc.
The most common though is that IRQs and FIQs are directly delivered to
S-EL1, in which case OP-TEE can mask IRQs.
There's also a difference between GICv2 and GICv3 in the way
interrupts are delivered.

> +
> +Architecturally, the secure monitor can mask or reroute normal=E2=80=91w=
orld interrupts
> +before entering the secure world. In a correct OP=E2=80=91TEE/ TF=E2=80=
=91A implementation, it
> +does not do this for the duration of secure calls. Normal=E2=80=91world =
interrupts
> +remain deliverable, and a normal=E2=80=91world IRQ will preempt OP=E2=80=
=91TEE via EL3 and
> +return control to Linux.

The 'sane' case is indeed where IRQs are delivered to OP-TEE which
exits back to Linux immediately.

> +
> +Secure=E2=80=91world interrupts (FIQs) are possible if the SoC routes a =
device's
> +interrupt as secure. Such a secure FIQ will preempt Linux immediately, t=
rap
> +into EL3, and transfer control to OP=E2=80=91TEE's secure interrupt hand=
ler. Linux
> +cannot mask or preempt this. Secure FIQ handlers must therefore be extre=
mely
> +short to avoid introducing noticeable latency.

There are also 'fast SMCs', which run with IRQs disabled for their
entire duration.

> +
> +The transition from normal world -> secure monitor -> OP=E2=80=91TEE and=
 back introduces
> +additional latency due to world switching and context save/ restore. Thi=
s
> +overhead is typically a few microseconds and usually remains in the nois=
e
> +floor.

That's correct.

> +
> +If the secure monitor masks normal=E2=80=91world interrupts during OP=E2=
=80=91TEE invocations,
> +or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers, then=
 OP=E2=80=91TEE can introduce
> +measurable latency spikes.
> --
> 2.53.0
>

Overall I think this is worth documenting, but infortunately there's a
wider range of configs and corner cases we have to describe.

Cheers
/Ilias
