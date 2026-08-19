Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F68C5DF6D
	for <op-tee@archiver.kernel.org>; Wed, 19 Aug 2026 08:38:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1F88F4530A
	for <op-tee@archiver.kernel.org>; Wed, 19 Aug 2026 08:38:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ks6pTczh;
	dkim-atps=neutral
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 31E6D44EA7
	for <op-tee@lists.trustedfirmware.org>; Wed, 19 Aug 2026 08:36:23 +0000 (UTC)
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca92f36c4acso183450a12.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 19 Aug 2026 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128582; x=1787733382; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OOhYCONyOlLqZ7Th3lMilNB9DV3vW0wUhGS0m5kXWkU=;
        b=ks6pTczhRu/m4YP0cnY4XXqzFjTdqozDLQfTpDpuOQ9hy8VFCUxGmGm5oo6t13rydE
         uBKCxdkBS7etZobGsM6068udNIp/HEswiq0svVgZinDSCpYQJ7Eyzq5ocu/IT5rXcqiJ
         Fjrla+QKOtIGeh4fd/rlHo2DFDjWf272qcQNmDGultoWZkVRqcdKTsjAckk0UYL0ibjl
         BpWJG3YXrMsUFFpE44etk45UrQDpPhVMt9XnJwXdl++E40uycl2LDxMsO5AfWxb8+ijp
         zUTpWpELlfpEWfRZt97RZxKlapdFr65c6LINYlZnPWVlOkJ2DmHZp5Jfsz5jLianKPKw
         s1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128582; x=1787733382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OOhYCONyOlLqZ7Th3lMilNB9DV3vW0wUhGS0m5kXWkU=;
        b=CYFCOMM/02KA/Zpjw1s/5kOzH+gEII6xJMSHzw0t7wylM/nTr9hU2uPzGonXMuMEHc
         BknsgoluYHE/bXrEcR6WF5hcx//tgs4CxPRjLKmbrzzM7A+rTAkNt4JYK4mzgejGjjAE
         /xkKeO5Cc3e45mZV6sS4xbPTSSRj560mB01Ilx5lfWwqjdwmAdRd+3ngXA3O2/szAL8u
         PWnJiTHel8yjQBb4UZHcTKdx1TZx2uBGxGOczVBgDOFj99VjnN5cXCenaaxfeKAuyA8/
         fMse1ODoohFn8YLau09owdG3cUx29FOnG8XrxlGOGF81SPdko7igGSaFEQ8+nOsKW732
         X+1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqCEm4embzrXCc9lRNKxYda5aiX0uEvGPDJdzSALaI5IfTAVPBih80IUl/O7ANxU1mOdAIYVoc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwFu4ba9izGdWRPKAJf/tM42aOu49WyPhby7OgSa7Px4OKNL/3d
	gghtbEGk1LzllnHBBkAbe+V0vNwI8xqeB/d82FzE8qGvHwGSr9HWEydq
X-Gm-Gg: AR+sD10b1Wn554OunXwXmRTrD+HF2Eh0vIZraA36IL28YEwpuOfz7k+NC+RrhswVpiW
	hirbjn4yFOFCBsNeo6E6ZufCKds9cIN7ChJs1Vx20KNsBH6sz10EJTEZotyLMBRQFCXq4NwWRtp
	ADpykoVoGsPTP4RAoI0CFv87uMRiZLV/jGCFcVoQsW+UX0HDkt4iVdyoFPpRb6aGJVlFBLnvojs
	BCe7CiWncHsYs9gI/LHYk0v7CIMmVuyeysjYrW8/hxqIcXaXufue70AwYKZ4mXYvrGh+nKe/tCK
	lN7PWS+p71T9ejbBkhwlptFEryWJtMcQTwfS5NYSxj6wQ1b2WWYY/I3rXF4Y+oq1rKvoBlpNZ0y
	unKrZtLZK2bq+cQsWcFmg4EHaSAfvOIaEZ4y6txVWBE9GZZKvdi0wbJbU5Lyn2tto+bgm64i8O7
	tliRuLIQ9GooEcVtxsA2fK2Tq9Q74rlUsfnl8/GbV6mlEVevzzThoiqmYf/LtYm1c=
X-Received: by 2002:a05:6a20:a126:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3cd011a0cfbmr5624816637.14.1787128581986;
        Wed, 19 Aug 2026 01:36:21 -0700 (PDT)
Received: from ubuntu24.. ([85.149.220.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc155464a0asm332268a12.14.2026.08.19.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:36:19 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v4 0/3] tee: add MbedTEE driver
Date: Wed, 19 Aug 2026 16:35:56 +0800
Message-ID: <20260819083559.1303348-1-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org,gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:74.125.228.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.228.0:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.228.0:from];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 31E6D44EA7
X-Spamd-Bar: --
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: GEJFZCIEYV2F5P2K5NQYT7U4BVUGXZ7T
X-Message-ID-Hash: GEJFZCIEYV2F5P2K5NQYT7U4BVUGXZ7T
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:38:33 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GEJFZCIEYV2F5P2K5NQYT7U4BVUGXZ7T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

This series adds a Linux TEE driver for MbedTEE, a Trusted
Execution Environment for embedded systems
(https://github.com/mbedtee).

Two RPC transports are provided for systems where platform
firmware or board configuration has already established the
REE/TEE separation before Linux boots:

  - ARM/ARM64: SMC calls and GIC SPI notifications (TrustZone)
  - RISC-V: shared-memory ring buffers and IMSIC MSI notifications

The driver implements the TEE subsystem interface (tee_driver_ops)
and provides GlobalPlatform TEE Client API support, dynamic shared
memory registration, and tee-supplicant support for REE filesystem
and RPMB operations.

The series is structured as follows:
  [1/3] dt-bindings: vendor-prefixes: add mbedtee
  [2/3] dt-bindings: firmware: add mbedtee,tee binding
  [3/3] tee: add MbedTEE driver

---
Changes in v4:
- 0002: Move reserved-memory region descriptions into
  memory-region-names property (Rob)
- 0002: Define memory-region-names item order at top level; keep
  per-branch name count constraints (maxItems: 2 / minItems: 3) (Rob)
- 0003: Harden ring and RPC handling against malformed input:
  - Validate both ring indices; bound async ring skip and resync
    the reader on corrupt framing
  - Enforce RPC handler modes (COMPLETE_REE async-only, supplicant
    commands sync-only)
  - Reference-count rpc_call objects; fix use-after-free on
    interrupted calls; abort and free leftover calls at teardown
  - Add XA_FLAGS_LOCK_IRQ to the rpc_calls xarray
  - Fix supp_recv/supp_abort_all race; malformed supp_send unblocks
    the worker instead of hanging it
  - Reject TEE-changed parameter attributes
  - Report the wire error on failed supplicant requests; fail
    oversized requests instead of requeueing them forever
  - Wait for R2T ring space with a bounded backoff; bound
    COMPLETE_TEE retries and stop them at teardown
  - Match the supplicant context when dispatching supp_send
  - Access complete_work_pending under ring_lock
  - Serialize RPC submission against shutdown and reject new
    calls once teardown starts
  - Quiesce all RPC activity before tee_device_unregister() so
    parked waiters cannot deadlock teardown
  - Bound non-interruptible RISC-V waits so a hung TEE cannot
    block ioctls forever
  - Track closing state on sessions; reject concurrent
    close/invoke/cancel races
  - Quarantine TEE-owned call objects at release instead of
    risking a cross-world use-after-free
- Link to v3: https://lore.kernel.org/r/20260720073558.799755-1-xing.xl.loong@gmail.com/

Changes in v3:
- 0002: Drop all phandle stub nodes from examples.
- 0002: Remove redundant required: - interrupts from then branch.
- 0002: Simplify title and description.
- Link to v2: https://lore.kernel.org/r/20260702151115.544016-1-xing.xl.loong@gmail.com/
- Link to v1: https://lore.kernel.org/r/20260701132514.186953-1-xing.xl.loong@gmail.com/

Changes in v2:
- 0002: Fix DT binding review comments from Krzysztof Kozlowski:
  - Drop $nodename, "YAML devicetree binding" wording, property descriptions
  - Rename compatible string to mbedtee,tee
  - Rename memory regions: rpc-t2r-ring -> t2r-ring, rpc-t2r-shm -> t2r-shm,
    rpc-r2t-ring -> r2t-ring
  - Add memory-region / memory-region-names to required
  - Simplify allOf constraints (drop redundant else-branch items)
  - Rewrite description to describe hardware/firmware, not the binding or driver
  - Drop all irrelevant platform nodes (gic, cpus, reserved-memory)
  - Add maxItems: 1 constraint to interrupts property (Sashiko AI review)
- 0003:
  - Fix supp_release incorrectly aborting unclaimed requests on close
  - Fix potential tee_shm double-free on supp_recv error path
  - Fix async RPC ring skip leaving orphaned payload bytes
  - Fix COMPLETE_TEE retry to also handle transient -ENOMEM on RISC-V
  - Fix session leak on close_session allocation failure:
    release kernel resources before sending RPC

---
Xing Loong (3):
  dt-bindings: vendor-prefixes: add mbedtee
  dt-bindings: firmware: add mbedtee,tee binding
  tee: add MbedTEE driver

 .../bindings/firmware/mbedtee,tee.yaml        | 102 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/tee/index.rst                   |   1 +
 Documentation/tee/mbedtee.rst                 | 155 ++++
 MAINTAINERS                                   |   9 +
 drivers/tee/Kconfig                           |   3 +-
 drivers/tee/Makefile                          |   1 +
 drivers/tee/mbedtee/Kconfig                   |  20 +
 drivers/tee/mbedtee/Makefile                  |  11 +
 drivers/tee/mbedtee/core.c                    | 260 +++++++
 drivers/tee/mbedtee/mbedtee_drv.h             | 289 ++++++++
 drivers/tee/mbedtee/mbedtee_msg.h             | 219 ++++++
 drivers/tee/mbedtee/rpc_callee.c              | 697 ++++++++++++++++++
 drivers/tee/mbedtee/rpc_callee_arm.c          |  91 +++
 drivers/tee/mbedtee/rpc_callee_riscv.c        | 203 +++++
 drivers/tee/mbedtee/rpc_caller.c              | 697 ++++++++++++++++++
 drivers/tee/mbedtee/rpc_caller_arm.c          |  70 ++
 drivers/tee/mbedtee/rpc_caller_riscv.c        | 238 ++++++
 drivers/tee/mbedtee/shm_pool.c                | 105 +++
 drivers/tee/mbedtee/shm_pool.h                |  15 +
 drivers/tee/mbedtee/supp.c                    | 311 ++++++++
 include/uapi/linux/tee.h                      |   1 +
 22 files changed, 3499 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
 create mode 100644 Documentation/tee/mbedtee.rst
 create mode 100644 drivers/tee/mbedtee/Kconfig
 create mode 100644 drivers/tee/mbedtee/Makefile
 create mode 100644 drivers/tee/mbedtee/core.c
 create mode 100644 drivers/tee/mbedtee/mbedtee_drv.h
 create mode 100644 drivers/tee/mbedtee/mbedtee_msg.h
 create mode 100644 drivers/tee/mbedtee/rpc_callee.c
 create mode 100644 drivers/tee/mbedtee/rpc_callee_arm.c
 create mode 100644 drivers/tee/mbedtee/rpc_callee_riscv.c
 create mode 100644 drivers/tee/mbedtee/rpc_caller.c
 create mode 100644 drivers/tee/mbedtee/rpc_caller_arm.c
 create mode 100644 drivers/tee/mbedtee/rpc_caller_riscv.c
 create mode 100644 drivers/tee/mbedtee/shm_pool.c
 create mode 100644 drivers/tee/mbedtee/shm_pool.h
 create mode 100644 drivers/tee/mbedtee/supp.c

base-commit: 03e2778d1f11de9260543f969e9e888a1c2bf830
-- 
2.43.0

