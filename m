Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB50CD98F0
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 06:19:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4D49344EDE
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 06:19:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=DTbu9SS8;
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 99AE743743
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 06:19:00 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490cdae130cso25263395e9.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 23:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782195539; x=1782800339; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/gFkQ/sS58Os6ymRfzW1PflBLVEsdy6rsHQOddwAsM=;
        b=DTbu9SS84K95hZKWCfjI8rwa2TfhLzC68fLBMTLtH0pRow+13VBlDoo4YC3IlRglkn
         EaKYoQoxMMis+1pmOrr6helVRf3TxczdJxFQ1sVyeKDRex9rtVcs9nMsiRD3a7ggdsHV
         n7wJpz7cpP5CUKxHlxIlhUl2hlfB/BrbTUohrSrttrVzLl/StVy5fLEL15qLyRdsBopQ
         n2ytgoOisCY/D0dmQ3w8RIG+zoHko5RUAiEGAADeZKmClYU5mzI6JXPMfNRUIs838ZoV
         4s+MYf0FhC90FGpJwF7s7nMfkVrAbiL5K7foJLDYNRjyS9WkMo5yxQOvAMy2Au+GvcqA
         dfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195539; x=1782800339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/gFkQ/sS58Os6ymRfzW1PflBLVEsdy6rsHQOddwAsM=;
        b=JDPwDelFDPuVBN9fSp42A/QQDUGOiS8lBojA803kfVpuKuI0lEGZoUMfvOCpLFbI5o
         UfCIEMAKyd2T2JeLESG6tjHIuyKucPqwOlePPRdQIAx8FNuCA/syORC8uL7A4i/8JcVR
         wR0j6F7O8gqBOadjOcnD8kEtBbyDKvdmLHMriCbrUHlWzSbe0vVjskaNtTpCr4ZCBpBW
         r/8INBkH+v6gwvapg3Ywbir34yc6xHR7tHPpmFX4aNBBa2uGLh3XLMw845i7dK5c48SN
         JM6LXGAY0XXLNeHkt5hjL5/9J3xD5m5igfEOQzaJ3hwH4BqM9JP6xLb0/xtJgiPdNqN7
         788Q==
X-Gm-Message-State: AOJu0YyofqfsD/wQoRu9DaKdaO+geaA31IyaU7cU2B/LGN2SYSJHyNYJ
	jTxwTVMLyxdiIKTwOpKStm3Lyknq0f59vijlnL5stHm78bIVQS2FXGd6FogO1Kb/7xfXqQXuTgi
	vsaoN2MY=
X-Gm-Gg: AfdE7cnzJnXpY/Lx4tFiSYkFpo6xA1DtdmJBsYwIhlyxOoufjaUE58kyKQD4+TSDR85
	9U4/KZfen0qboBg0KdgXMtCTZca7tJUEJy/Mvbr6bBImhlJLjmG9y5xrllAXnydBE2UU3CgvBWl
	N/iooPl3slZnF5zGcY8kCcGB6UAyvowsKhV5Z/pELSk1kk6XjTDxsuoftzj/60USL/rvjoToxYz
	NdA/zEHAEda+W0HhA5RdTdG5xL9XwStsot1ARTGG8qgsJ95TC+rg2jE6Y+icX5a7PdY90NyJlP6
	gq8NwNilgH07CYIIwDjhH2HsCuFsCj/HJFZIdbjQBoDAaOdW9TT+Q7i75wyat6UW3ir1ZbehnEr
	nCfslpypSWaZ+aNHXxA7FnfnfcqSyqZapp1gUhQuuYyVZmPu1dE+6G1ylYQ62EZ2piSqvATU8xx
	B1JcKRuf+wOlenQ0sXfvMvfaUeTbxs8Jg8zLqYBusy3HD9oj7bHZ78MkZFnTtGxGleNJY=
X-Received: by 2002:a05:600c:c177:b0:492:48dc:3d0d with SMTP id 5b1f17b1804b1-4925b38cdb5mr17586425e9.12.1782195539451;
        Mon, 22 Jun 2026 23:18:59 -0700 (PDT)
Received: from Dev-EliteBook.Home (97e782b0.skybroadband.com. [151.231.130.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788547sm34521147f8f.18.2026.06.22.23.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:18:58 -0700 (PDT)
From: dave.patel@riscstar.com
To: op-tee@lists.trustedfirmware.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Peter Lin <peter.lin@sifive.com>
Subject: [RFC 0/3] core: riscv: Implement Floating-Point and Vector extension context tracking
Date: Tue, 23 Jun 2026 07:18:52 +0100
Message-ID: <20260623061855.17863-1-dave.patel@riscstar.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.46 / 15.00];
	BAYES_HAM(-2.96)[99.84%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[riscstar.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.53:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.53:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 99AE743743
X-Spamd-Bar: --
Message-ID-Hash: DQNOSG6F67QNPRHBEOVQ2OO3KERA7524
X-Message-ID-Hash: DQNOSG6F67QNPRHBEOVQ2OO3KERA7524
X-MailFrom: dave.patel@riscstar.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Robin Randhawa <robin.randhawa@sifive.com>, Scott Bambrough <scott@riscstar.com>, Dave Patel <dave.patel@riscstar.com>, Ray Mao <raymond.mao@riscstar.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DQNOSG6F67QNPRHBEOVQ2OO3KERA7524/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Dave Patel <dave.patel@riscstar.com>

Dear OP-TEE Developers,

This proposal introduces architectural runtime context management structures and
tracking mechanisms for standard scalar Floating-Point (F/D) and Vector (V) ISA
extensions on RISC-V platforms.

### 1. Architectural Alignment and Shift

Currently, the thread scheduling layer in OP-TEE OS implements a tightly coupled
VFP model specific to the ARM architecture (e.g., thread_kernel_enable_vfp). This
model relies heavily on a software driven "lazy context trap" mechanism, where
the kernel disables the FPU to catch subsequent execution faults.

On RISC-V architectures, context tracking cannot rely on software initiated lazy
traps via execution faults due to structural opcode overlap across custom extensions
and the severe pipeline execution penalties of traps. Instead, RISC-V provides
native hardware status state machines managed via the `sstatus.FS` (Floating-Point)
and `sstatus.VS` (Vector) bitfields.

To map seamlessly into OP-TEE's existing `thread_*_vfp` thread scheduling, we
utilize these hardware flags to implement "eager-on-dirty" context saving. The
kernel leaves extensions enabled during active execution and only write at context
switch if the hardware reports a `Dirty` status.

### 2. Implementation Subsystem Architecture

To maintain modular design the implementation explicitly divides scalar processing
from scalable vector configurations:

1. Modularity & Headers:
   - <kernel/riscv_fp.h> specifies bitmasks and structures (`struct riscv_fp_state`)
     for scalar execution.
   - <kernel/riscv_vector.h> encapsulates scalable vector parameter state layouts
     (`struct riscv_vector_state`). This allows devices missing a vector unit to completely
     omit vector footprints or dependency.

2. Bitwidth and Layout Adaptability:
   - Scalar Low-Level Assembly (`fp_asm.S`): Natively adapts to both 32-bit (`rv32`)
     and 64-bit (`rv64`) width configurations via compiler `__riscv_xlen` preprocessing directives.
   - Vector Extension Optimization (`riscv_vector.c`): Fully isolated from primary thread files.
     Instead of storing vector registers sequentially, it adopts whole-register block
     transfer instructions (`vs8r.v` and `vl8r.v`). Grouping elements into blocks of
     eight compresses the save/restore pipeline into four core operational chunks
     (`v0`, `v8`, `v16`, `v24`).

3. Unified Scheduling Abstraction (`thread_vfp.c`):
   Unified top-level implementation (`thread_kernel_save_vfp`, `thread_user_enable_vfp`,
   etc.) are used for context routing.


### 3. Feedback Requested

We are seeking early design feedback from the community regarding:
- Structural Convention: Should we keep the universal "vfp" naming scheme within the global
  `thread.h` header interfaces for structural backward compatibility, or is an explicit upstream
  refactoring toward a generic name (e.g., `thread_kernel_enable_coproc_regs`) preferred?
- Vector Bounds Memory Allocation: What is the preferred approach for safely managing the dynamic
  heap footprint for vector register states (`vregs`) which scale based on runtime CPU `VLENB` bounds?
- Eager Context switching has been proposed, hence are there any reservations on
this ?


Looking forward to your suggestions and design critiques.

Dave Patel (3):
  Floating Point changes
  RISCV Vector changes
  Thread changes for RISCV floating point and vector changes

 core/arch/riscv/include/riscv_fp.h     |  30 +++++
 core/arch/riscv/include/riscv_vector.h |  32 +++++
 core/arch/riscv/kernel/riscv_fp.S      | 159 +++++++++++++++++++++++++
 core/arch/riscv/kernel/riscv_vector.c  |  77 ++++++++++++
 core/arch/riscv/kernel/thread_vfp.c    | 142 ++++++++++++++++++++++
 5 files changed, 440 insertions(+)
 create mode 100644 core/arch/riscv/include/riscv_fp.h
 create mode 100644 core/arch/riscv/include/riscv_vector.h
 create mode 100644 core/arch/riscv/kernel/riscv_fp.S
 create mode 100644 core/arch/riscv/kernel/riscv_vector.c
 create mode 100644 core/arch/riscv/kernel/thread_vfp.c

--
2.43.0

