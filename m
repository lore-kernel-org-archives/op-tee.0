Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57491C43458
	for <op-tee@archiver.kernel.org>; Thu,  9 Jul 2026 17:03:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 829194152C
	for <op-tee@archiver.kernel.org>; Thu,  9 Jul 2026 17:03:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S62oUJZu;
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E87373F690
	for <op-tee@lists.trustedfirmware.org>; Thu,  9 Jul 2026 17:03:36 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664b05d408bso10410d50.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 09 Jul 2026 10:03:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783616616; cv=none;
        d=google.com; s=arc-20260327;
        b=p35LB96Mp2a/6LTE6Md5pChRv9ozYcJtSgI8CLf8zh37Oi6Q8jqygspdXqCO7D1aSV
         S/D60xGs1igiHcenLjXixKf3i5gPPDcOdCevO6hqYoxtmVf9+MhfYenskpcqUsqehyL1
         VyEi9YWwnm4F+Ux4OxJ1Qqf2pMt37jNeGvA2yQRlHCjJ50H7H1wx6ZwStDnavVqWKXZk
         wbMeAO0UN+hpwigIADIKv3fJQjK5D7ycLBHDTGlhCyJIHjtlwmGSegD3jdnyeEPYsiqh
         edksThuolOI+dS4ZA+fIMY9CAvdUeDje8ffNCDII/ogrezM5qgKXusLn61SM6p1espkO
         f8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yR14oOjUi6OI2bUfX4NS8nwAQpf3oK/jBWo0jGsJb5s=;
        fh=xz91SHCJQ87Op0kO3pyNV24qyD774cH15di7Y6/y7HM=;
        b=C0/TOfXC5koKJ+VCncKfh0CWuH7fTbvyqpW03JorHW2N96gOoOFwlIq4btYQMVqMEV
         FW3Xh3FOm4iMJfRwwlZ1J3G6fmqS+YYeJF+9tIMpjKf6D++yh9pr91so+PcRhRJ26rdy
         ll3nmEX598ht3n0wDloFS4hSg5dylbCvZegv04VehWKr5C0eQ/3056USycogblUy1iMz
         AMlirNxilVJo+IK85P6Q6/g7pxDV8l46842EFItLm+5BMn6EJyFEMv8V+rtlAAGUOBbs
         2Gj9QqbOPRmNBj7urQBaIRm9nbQ9P4sDD+7mEnuUtKPy010RKbDvhVGq3HTVzxxDDMMJ
         mysQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783616616; x=1784221416; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yR14oOjUi6OI2bUfX4NS8nwAQpf3oK/jBWo0jGsJb5s=;
        b=S62oUJZuMr9JTItRv1AD3pkI/Pi0TXaPAYPcqpwemkYC3baQyfurJ7fsmF+Dkw4GGL
         bWk1gvH705QaN1kcoahgbt08cERlNVwoQq9HYIyBwglCgmLfMCm778z2ZZYAEL5pomgB
         X3JFjwkGau0DoyjBkcKGKsBdrVxQEbdjl/Q3NYBKID7g4iaT9INiBaqzqVuvh0LsP5Vh
         Gk3vMZ7E0RDZdqcjY8wIXXj69jQk4oSWLIYZYDrL8dNb3uvgGSTB97GNHgqbSIrHtt9q
         LHpVpdtIxGc4i9hR7TS9iUjZNr55nvKiqGfgVrU3g+xl/ywBneDRElwmOxS3Xtg0M8Hi
         E4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616616; x=1784221416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yR14oOjUi6OI2bUfX4NS8nwAQpf3oK/jBWo0jGsJb5s=;
        b=RhgVXDSqm05KBowjEUsasN2AssVuIWYbvruOP1ca2NISmC35D7xT9oHxwR7bXEM1vJ
         UMV84C9tPsseLF/rgRNL1BQO3sRGPwtHlIIzC4d15yuUkOW1XCQ1mqc3rz3D9Q1DW/BN
         cm5mKQU7l28LGlCp1p6Vzza6mvzZrTma5HMdYBqpfGq5SrYPxDar8G8Y4QgL20VeB0gm
         f2a1miTlwNvGvdvlOuw13eRuoyIaDcv8HP7AY6sN2NQyp7l8LvE1/d+wCfkGpylq0L/j
         67AaCEsfDcRPhVlRJpPffqXOd7qD2Gg9DLPixmF2wlBva0+ZKFRUosQAcRfijy0I2Lfu
         xFqg==
X-Forwarded-Encrypted: i=1; AHgh+Roqqw+qOkC1LEuakFDrKxIiA61RXivLCpr8eeZGJGtA9Iq17b5ZX6t0mbIwfVqpKe6EvP03Mvc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxJN7xTxv2zyXXYaFo1sjdV/sQP9KUgUG6bIbbtMJkufNLv8rFF
	VEXCjKHQIwngSVoQqvGquHLz13qc8TmwJsdxUyLolMMy66aZ/VF/FSmPV5VMtduvkm98M4qNSyv
	Kt6SwPziN9/2SHQ089TTPBvl0Pdfp3tdo/ibYYDlvmorL
X-Gm-Gg: AfdE7clDKHYLZM3dxNmvWzb5F/ZPBs+NSxR0G1M2Tv0hjN0pFOjJvsj2xXM2x2C0cN/
	MwUBCiImM2/a8AdOlgxLkHvQtaNLkz158xKakiNY0LIQreYzv/GJ7sx8au2UN6BCK0qKHDq1ByH
	LGEJBk+2Yje++IF0S7SYb54rUWp57/5vSH5wnmU6z5jm9npe8/+m25ioHG2uHKS5lLfjUGZLsfU
	144W04ySBJ1504MPfQBPE1IDJhLwHSp/fFyKLqhiauoGy9/fzyee54We8zjsuczd8Ppehj4otvA
	dtJgD8Fnw4F4MQc+zF8+8V2BFytOs/gxo6O9EdCTc84q/f6sK7PVb2D5yKF0ZBUx4+eIzr+DmmA
	DD7pWiRbySkN86kcYjdNhkdJMau32YiBzA5tnun8ByyQ3TcHTEnRQeksVMxPKDJBD3ed5vB4iwE
	DShWVm0fA6BbxCMZDHTSSM6o7TKbVhDwSriTc/XzoQrwSWYwiUVpRya5aF3p+i7nv0KjVYWpg5E
	aXLhjX6KtNpQi15ox9p7ZFzJoe2tFm9c4J6tpX61hx+mcWrpc7xW3TUiUkJQBlLQ0QI2y8Kj/gd
	6Y7W3c7Yz/iQhYD0H9IPwfQffKDkuL/3cNEpn15Cdd8VvpMKMZ/mXE3ARHw2IXgITgVxaVFQ
X-Received: by 2002:a53:5a08:0:b0:667:8b91:2439 with SMTP id
 956f58d0204a3-6679f26f7a1mr4147877d50.104.1783616616104; Thu, 09 Jul 2026
 10:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260701091226.7SWW4TrT@linutronix.de>
In-Reply-To: <20260701091226.7SWW4TrT@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Jul 2026 20:03:00 +0300
X-Gm-Features: AVVi8CeGWVzdbJXgI7g1MhHGlIvtNbOsamz5SlMClo5-ZNqp3TXp_jMt7pChNFA
Message-ID: <CAC_iWjKEcK8Z2TGCAVNU+pHLO2QvKKTmA01d-EqhE6exaTKcsQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "jenswi@kernel.org" <jenswi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	RBL_VIRUSFREE_BOTNET(2.00)[74.125.224.42:from];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:74.125.0.0/16];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_ALLOW(0.00)[google.com:s=arc-20260327:i=1];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.224.42:from];
	NEURAL_HAM(-0.00)[-0.983];
	R_DKIM_ALLOW(0.00)[linaro.org:s=google];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.224.42:from];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E87373F690
X-Spamd-Bar: /
Message-ID-Hash: OAAZIKL4OGHPPUUSSGZTBVLVLEFMWXKK
X-Message-ID-Hash: OAAZIKL4OGHPPUUSSGZTBVLVLEFMWXKK
X-MailFrom: ilias.apalodimas@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OAAZIKL4OGHPPUUSSGZTBVLVLEFMWXKK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

++Cc Jens  on his kernel.org email

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
>  The goal of this project is to validate real-time network communication.=
 It can
>  be thought of as a "cyclictest" for networking and also serves as a star=
ting
>  point for application development.
> +
> +Firmware
> +--------
> +
> +The firmware often plays a significant role in system operation because =
it can
> +perform tasks that the kernel cannot directly access, and in some cases =
it can
> +even preempt or intercept the kernel.
> +
> +A common example of firmware assisting the kernel is when it provides a =
generic
> +interface to a resource. Instead of accessing an RTC chip through an I2C=
 host
> +controller, the kernel may query the firmware for the current time, and =
the
> +firmware then accesses the RTC behind the scenes.
> +
> +Firmware can also intercept kernel execution by providing services that
> +temporarily take control of the system. One example is memory scrubbing,=
 where
> +the firmware periodically pauses the kernel, reads back portions of syst=
em
> +memory, and then returns control. During this time, the kernel is effect=
ively
> +interrupted.
> +In contrast, some systems provide hardware=E2=80=91based memory scrubbin=
g, which
> +operates independently of firmware or software. See
> +Documentation/edac/scrub.rst for details.
> +
> +If the kernel is intercepted for longer periods then these periods can b=
e made
> +visible with the hardware latency detector. See
> +Documentation/trace/hwlat_detector.rst.
> +
> +The kernel can also be intercepted in response to specific events, such =
as
> +overheating. In this case, the firmware may throttle the CPU or shut it =
down
> +immediately to prevent hardware damage.
> +
> +Unless the firmware is well documented, it should be thoroughly tested t=
o
> +uncover any unexpected behaviour.
> +
> +EFI
> +~~~~
> +
> +EFI provides runtime services that act as a communication interface betw=
een the
> +firmware and the operating system. One such service is reading and writi=
ng EFI
> +variables, which are used, for example, to determine the boot source.
> +
> +Invoking a runtime service may require the architecture to disable kerne=
l
> +preemption or interrupts during the call. This means the duration of a s=
ervice
> +invocation directly affects the system=E2=80=99s observable latency. The=
re is also
> +nothing that prevents a service call from disabling interrupts internall=
y while
> +it runs.
> +
> +For these reasons, EFI runtime services are disabled by default on a PRE=
EMPT_RT
> +kernel. They can still be enabled at boot time or via a Kconfig option i=
f
> +required.
> +The native EFI runtime service implementation (where both the EFI servic=
e and
> +the kernel are either 32=E2=80=91bit or 64=E2=80=91bit executables) uses=
 a wrapper mechanism
> +that invokes the service through a dedicated workqueue. This workqueue i=
s named
> +efi_runtime, and it can be restricted to a housekeeping CPU using the
> +``/sys/devices/virtual/workqueue/efi_runtime/cpumask`` sysfs file. Assig=
ning it
> +to a housekeeping CPU ensures that potentially long service invocations =
do not
> +impact the real=E2=80=91time workload which is restricted to other CPUs.
> +
> +It must also be verified that the runtime services behave as expected. S=
ome
> +implementations on the x86 architecture pause all other CPUs while one C=
PU
> +performs the service call. In such cases, the interruption affects all C=
PUs,
> +and restricting the workqueue to a single CPU provides no benefit.
> +
> +OP-TEE (ARM)
> +~~~~~~~~~~~~
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
> +
> +The transition from normal world -> secure monitor -> OP=E2=80=91TEE and=
 back introduces
> +additional latency due to world switching and context save/ restore. Thi=
s
> +overhead is typically a few microseconds and usually remains in the nois=
e
> +floor.
> +
> +If the secure monitor masks normal=E2=80=91world interrupts during OP=E2=
=80=91TEE invocations,
> +or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers, then=
 OP=E2=80=91TEE can introduce
> +measurable latency spikes.
> --
> 2.53.0
>
