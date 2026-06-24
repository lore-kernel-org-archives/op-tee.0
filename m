Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EC2CDB47F
	for <op-tee@archiver.kernel.org>; Wed, 24 Jun 2026 08:03:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4CC0C44F84
	for <op-tee@archiver.kernel.org>; Wed, 24 Jun 2026 08:03:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AaGp4htb;
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5D44A44F03
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Jun 2026 08:03:16 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a0b1edbe32so559277eaf.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 24 Jun 2026 01:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782288196; cv=none;
        d=google.com; s=arc-20240605;
        b=Sw+ojQwZnxAwHr642/Yf+kQUKts6ksOY3t4BvQUKpfZ+hw86TdxkyQCwvnZtXIEX/n
         hPMo8c50VSbkS9wJ+klK4J+ybvbygUOO2uJ5OEB7Rn+LLmpgeaB7lCuXk+xIdomtPOGA
         0b82Wd0JRR5YixH4mfMQC9BOgsqdbWGiW/YRC/y8859pZpq/So+wsuyNEdYCJfZDO6ER
         E94/jYpBbWtGYYSPw/uevBEWW9y0wDGvvUz0yVC2wgkAjAT7erfcUqyzpz6XHroiwlT4
         s42pHgGkPpHa+aXBI0/JekCpOTk1lVdzxhqBGo66/z4w1giJqyxEEYb3k70QZ2ZaA8x/
         baAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HgZgvKzIS0X1k0GaHdYC/ry9SjhDRdOIBPCZtjprOBU=;
        fh=w2Xh67r03IOs7AT9izhb+i4KpxJMkvh4S0xdgLa5EcQ=;
        b=P+5cgSHsScyDr8xg+YJb94brjDHFGj0JQALR3J/oa74zTLtT2MD0Roeerr8Dw0R9D4
         4kYRKb0k73nsqX6WVERgY5fIUJ02TsLDQA/S+3O471UR9t7e9B6ouBz5F5B4e4O/mDN9
         csD05TAHvNgCzQBkdTTZoBTcCLikifWXnfrn7GNUhYDo2JBA0slgWCsNWsi7d06g0GK9
         5A7pdv5p7D4nUCaNXGtgpIshzg4lq736WvkJi2tiHlXAyi5mDYykQvf/eKPAGZiT8m4V
         kGxMupqfGwnEDfFeGsC+KLCsVKopoI0x4sInBjil0YODoB9IHTZA6AdP2nbLfaO70loA
         xDOQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782288196; x=1782892996; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgZgvKzIS0X1k0GaHdYC/ry9SjhDRdOIBPCZtjprOBU=;
        b=AaGp4htbWraNEIdVvvlu2nnfPR8Cs5hqh7VaL7pRLdSNui5Zez9+izYhUWFZDDAasE
         HdsVjjKKoe1wRonYfKUSEhzdIr60oP3ZaG19RF7RgU0MnXGFdqpQNnqUBb4EIDZACSsN
         O9LRgUUDPI0K04/8D/ewiKi28nR4TsyWz0ijcnGeZfFId5No4/86XcDB98p32oi+P5xW
         H+4ond9J4eIYRzTEMvL0nfjRsBYVTV3IBw68t0OAvQrNTZOHXtYN350vcogKzQtKPqhO
         yKJYxJiXxtwYga9Z/HI1WuRoZuj0Sx9RodIWWPvz4PD8R4NoAFFE1rRm8UhFduhP/7nS
         hSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782288196; x=1782892996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgZgvKzIS0X1k0GaHdYC/ry9SjhDRdOIBPCZtjprOBU=;
        b=DbfMgYLTjE29O/6S2mBi+PgqcMLbzJO38GPFfczecxNA/6km5pjeeYgtBifT/kzEuf
         6vLIv6+a8unecxB4NwzzHI6bYrD2pZUXVd0xq3alFY5xMupjhJd/aNiPpthI4gS/xB7i
         Pv2KUWEofsBhHV75IiD/TTk08O+WvMBQRVLU23/HxM2VHfeN+DerinyNcez1t420Yqoz
         1XkWRrIy4MK4Ueoc9oJPPFJtJ5K+6vPR6bKfEnlt7RgXELezNb2n2e1LmgGy344AhbnX
         Tjq9weWhcdOnWmvZb+EjXmRlmkoGqY+ohKg9MeNmnQvR7PBkiM8A35Zx4xs60HXevlzq
         xWuw==
X-Gm-Message-State: AOJu0YyzFj+xz3EvpI8OvFpSG4s6KcNlmuyEUmzRSpUtcSo/z0zVMnUx
	+ZXQdZn2Vy09Pdv8RyrBZFpbuddBkLfmnauR9y6ZHOsao7/2flcja1JmlIKLcpEc3KHOXjOJW9+
	wA2OnCdm0ZF4Z0iy/koRYCyVTh1gEKyj/cMxLyhLIqyXU
X-Gm-Gg: AfdE7ck1nA1bVca0ybl/slB4IVnIjYWwU+Ovb+qRrLMFjkonyyYvLKz19qo6Z6cVHFW
	7JFniOgq6r8KlAomd2tF3FtEf7sKZEQ5AgYI+zkZCzrllIi2fhVwRVAwO7KXbcOvj2rKomonWaA
	VBbx6mxOQCsmavZ4L16Egm3gpomvSSEwZuF9b3TByJDhF2FszCFIBPYJIWHAdK8mmdJChXvRkih
	erALBMbgPBPwDczkLvCff5hBsx4CgMAAi0l+URgSHDFNmznUJX+77JdHIhJcvKWNLrs0+X67TDk
	xay5PEL+uXmmXeknNG6NUbYaUyvOw6PW51AOlQ==
X-Received: by 2002:a05:6820:f022:b0:68a:f494:e8fc with SMTP id
 006d021491bc7-6a114c291d3mr4477560eaf.33.1782288195611; Wed, 24 Jun 2026
 01:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260623061855.17863-1-dave.patel@riscstar.com>
In-Reply-To: <20260623061855.17863-1-dave.patel@riscstar.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 24 Jun 2026 10:03:04 +0200
X-Gm-Features: AVVi8CfyN8TKonJ0DmJxrXFJFTxfURbeyCDCDRMdsm1jld31frRL4ZHgWV7Y-iM
Message-ID: <CAHUa44EJivE8XwoVO9Tnd6-Jp_F0hyDgwzwO6Gv-TOvgUfo36w@mail.gmail.com>
Subject: Re: [RFC 0/3] core: riscv: Implement Floating-Point and Vector
 extension context tracking
To: dave.patel@riscstar.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.09 / 15.00];
	BAYES_HAM(-2.99)[99.95%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.54:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.54:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5D44A44F03
X-Spamd-Bar: -----
Message-ID-Hash: 6LBW3H23LVPKPY3N2GQJSXZTQPE3LU4N
X-Message-ID-Hash: 6LBW3H23LVPKPY3N2GQJSXZTQPE3LU4N
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, Samuel Holland <samuel.holland@sifive.com>, Peter Lin <peter.lin@sifive.com>, Robin Randhawa <robin.randhawa@sifive.com>, Scott Bambrough <scott@riscstar.com>, Ray Mao <raymond.mao@riscstar.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6LBW3H23LVPKPY3N2GQJSXZTQPE3LU4N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Dave,

On Tue, Jun 23, 2026 at 8:19=E2=80=AFAM <dave.patel@riscstar.com> wrote:
>
> From: Dave Patel <dave.patel@riscstar.com>
>
> Dear OP-TEE Developers,
>
> This proposal introduces architectural runtime context management structu=
res and
> tracking mechanisms for standard scalar Floating-Point (F/D) and Vector (=
V) ISA
> extensions on RISC-V platforms.
>
> ### 1. Architectural Alignment and Shift
>
> Currently, the thread scheduling layer in OP-TEE OS implements a tightly =
coupled
> VFP model specific to the ARM architecture (e.g., thread_kernel_enable_vf=
p). This
> model relies heavily on a software driven "lazy context trap" mechanism, =
where
> the kernel disables the FPU to catch subsequent execution faults.
>
> On RISC-V architectures, context tracking cannot rely on software initiat=
ed lazy
> traps via execution faults due to structural opcode overlap across custom=
 extensions
> and the severe pipeline execution penalties of traps. Instead, RISC-V pro=
vides
> native hardware status state machines managed via the `sstatus.FS` (Float=
ing-Point)
> and `sstatus.VS` (Vector) bitfields.
>
> To map seamlessly into OP-TEE's existing `thread_*_vfp` thread scheduling=
, we
> utilize these hardware flags to implement "eager-on-dirty" context saving=
. The
> kernel leaves extensions enabled during active execution and only write a=
t context
> switch if the hardware reports a `Dirty` status.
>
> ### 2. Implementation Subsystem Architecture
>
> To maintain modular design the implementation explicitly divides scalar p=
rocessing
> from scalable vector configurations:
>
> 1. Modularity & Headers:
>    - <kernel/riscv_fp.h> specifies bitmasks and structures (`struct riscv=
_fp_state`)
>      for scalar execution.
>    - <kernel/riscv_vector.h> encapsulates scalable vector parameter state=
 layouts
>      (`struct riscv_vector_state`). This allows devices missing a vector =
unit to completely
>      omit vector footprints or dependency.
>
> 2. Bitwidth and Layout Adaptability:
>    - Scalar Low-Level Assembly (`fp_asm.S`): Natively adapts to both 32-b=
it (`rv32`)
>      and 64-bit (`rv64`) width configurations via compiler `__riscv_xlen`=
 preprocessing directives.
>    - Vector Extension Optimization (`riscv_vector.c`): Fully isolated fro=
m primary thread files.
>      Instead of storing vector registers sequentially, it adopts whole-re=
gister block
>      transfer instructions (`vs8r.v` and `vl8r.v`). Grouping elements int=
o blocks of
>      eight compresses the save/restore pipeline into four core operationa=
l chunks
>      (`v0`, `v8`, `v16`, `v24`).
>
> 3. Unified Scheduling Abstraction (`thread_vfp.c`):
>    Unified top-level implementation (`thread_kernel_save_vfp`, `thread_us=
er_enable_vfp`,
>    etc.) are used for context routing.
>
>
> ### 3. Feedback Requested
>
> We are seeking early design feedback from the community regarding:
> - Structural Convention: Should we keep the universal "vfp" naming scheme=
 within the global
>   `thread.h` header interfaces for structural backward compatibility, or =
is an explicit upstream
>   refactoring toward a generic name (e.g., `thread_kernel_enable_coproc_r=
egs`) preferred?
> - Vector Bounds Memory Allocation: What is the preferred approach for saf=
ely managing the dynamic
>   heap footprint for vector register states (`vregs`) which scale based o=
n runtime CPU `VLENB` bounds?
> - Eager Context switching has been proposed, hence are there any reservat=
ions on
> this ?
>
>
> Looking forward to your suggestions and design critiques.
>
> Dave Patel (3):
>   Floating Point changes
>   RISCV Vector changes
>   Thread changes for RISCV floating point and vector changes
>
>  core/arch/riscv/include/riscv_fp.h     |  30 +++++
>  core/arch/riscv/include/riscv_vector.h |  32 +++++
>  core/arch/riscv/kernel/riscv_fp.S      | 159 +++++++++++++++++++++++++
>  core/arch/riscv/kernel/riscv_vector.c  |  77 ++++++++++++
>  core/arch/riscv/kernel/thread_vfp.c    | 142 ++++++++++++++++++++++
>  5 files changed, 440 insertions(+)
>  create mode 100644 core/arch/riscv/include/riscv_fp.h
>  create mode 100644 core/arch/riscv/include/riscv_vector.h
>  create mode 100644 core/arch/riscv/kernel/riscv_fp.S
>  create mode 100644 core/arch/riscv/kernel/riscv_vector.c
>  create mode 100644 core/arch/riscv/kernel/thread_vfp.c
>
> --
> 2.43.0
>

Please create a PR at GitHub with these patches instead. That's the
preferred way of reviewing patches for the OP-TEE repositories.

Cheers,
Jens
