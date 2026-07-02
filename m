Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69501C55174
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:17:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B997F452F9
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:17:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=ZCRsrsyk;
	dkim-atps=neutral
Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EF49144DE0
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 15:12:26 +0000 (UTC)
Received: by mail-oo2-f4.google.com with SMTP id 006d021491bc7-6a17a8423e8so226746eaf.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783005146; x=1783609946; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KpbVhUXPAR7yYiukM4xOT6R76MLGcxXpNGYBYk7mmg=;
        b=ZCRsrsykgDsEZux5AcAq+NOUmFddZpjf919gHQ8diqcxrawVZnSZZX366aabVRf4YZ
         DnerfvjK8plVXyO3M0RMm/s0X0ILhg9nH8nAWVfXlF9VMzA8x016iQ1Wwel0H558fRhB
         EsQ0yguA2EL9EuXnNqlxO99sDKY+2ScCNdbrrUp8OUnBohHT+CkrhfkPR3uAEWexa4a1
         jkQqUu/VB2CEV8fXdyloOqCBmTeC/xzzyMFoAS9xKEdSKQ2mT2qSaPkdvN9ytWmxOX8w
         5cnijqda0+3zNAHIedWnHZvMA1w2lkHGgL/mKEmFTMEif+510IokgdHtu06frPtvpwvT
         mvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005146; x=1783609946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KpbVhUXPAR7yYiukM4xOT6R76MLGcxXpNGYBYk7mmg=;
        b=J8Kw/BGIBJHYHs2ZCiufnlZie7EEQAfxmzxf7p9d4LFQ0kYRernGhwvNltj6N7OsrH
         +QH1O1QcKcP7qWJkfCpJZF+DEGK59igHcnPubUvoRMXQt7bqACLRC+FZHKI8w5TlQXSg
         KncoK22fFeKoi1nf2pCC7hqfmCelKglznpBTx0cdKl/bHIF2hF0jfFDdALrv4XH3lR6a
         pnS0JF1h4/M2JDwiG0Eke3/IzMJkRI1uXVAjnWb6LH+p67lfQ0Tt95w6bHjo5PTqlltt
         moWaC5aci+mm78W/oOfbwme7/aVZxIKkG7Q3wTNn72rXiI2OMe0ahpHBa3oSG0n2PjnU
         9WDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9h3TnkgBxmfrlGzYT9gxbSajoSvvZSmvTYxXShKyjID6Ekb+OK52m0bKeCtEjlQ4TYo+nbuMo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwoAiDb+lLIlvkRU857Pcy8Miiof2pSU6Y5jCxxyYqaLOB+VMP3
	i3eSfFSDL01yxuJwXtRdugiNoOlgx8RQBjJCIKsUVWnGFKwn37mHLFse
X-Gm-Gg: AfdE7cnvZW8fctQmlkvYsA6+sM7tKXc7UiXLw66L5cjbTN87jPbmmshJFiGpToW6lJ6
	YH5tbVc/Zvhbm9LPNM4UZ8Aklms4UCPJbEmB0upF5nDtfeQL2oikEWR10JGYE54WTOHcDXksRBX
	9awhxjMD3kxWMXrhq7/hzMEj/MibqZN954t1T/03ti7TQzeUi33bsCKLygpUYiZgYFpytFnrDex
	ZVYeqpvP3rPMItN00uhOGc2gcoHt7eQQ0q5I5Bk+st/54ikOYiZEOICbu6w59AAmgTJAZ12GCc+
	iwt8rFvialF92REYVbmf6wQgPl2pY432LUO7/J2prcNVtwhA8waEQqSzwFsGkE0Mk/LOFBkC9gQ
	QGZC/nmOeS5VibKGRGoaBzbA+lrtcHNnAdwrgRNNwdt4kLHvxrk7TK11q/1/IB7J6UF6gqJrEUH
	aRAfwroR99uJlp/LO+jkHON1mHp/4N5vSyS+ozRNQxnqTSrwjm6j0BmaM=
X-Received: by 2002:a05:6820:179a:b0:6a1:50e9:d589 with SMTP id 006d021491bc7-6a309c2ed2cmr3774675eaf.70.1783005145528;
        Thu, 02 Jul 2026 08:12:25 -0700 (PDT)
Received: from ubuntu24.. (dsl092-249-254.sfo4.dsl.speakeasy.net. [66.92.249.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec9a113sm3094561fac.9.2026.07.02.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:12:24 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v2 3/3] tee: add MbedTEE driver
Date: Thu,  2 Jul 2026 23:11:15 +0800
Message-ID: <20260702151115.544016-4-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702151115.544016-1-xing.xl.loong@gmail.com>
References: <20260701132514.186953-1-xing.xl.loong@gmail.com>
 <20260702151115.544016-1-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.231.132:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.231.132:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EF49144DE0
X-Spamd-Bar: --
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: MAXCRS56LG2GQX4VKI7AQWCOXTFDTMXN
X-Message-ID-Hash: MAXCRS56LG2GQX4VKI7AQWCOXTFDTMXN
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:13:17 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MAXCRS56LG2GQX4VKI7AQWCOXTFDTMXN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

This patch adds a Linux TEE driver that communicates with
MbedTEE OS, a Trusted Execution Environment for embedded
systems (https://github.com/mbedtee) via a fixed shared-memory
RPC protocol over architecture-specific transports:

  - ARM/ARM64: SMCCC fast/yield calls for REE-to-TEE requests;
    TEE-to-REE notifications via a GIC SPI edge interrupt.
  - RISC-V: REE submits commands by writing to a shared-memory
    r2t-ring that the TEE polls; the TEE notifies the REE by
    writing to t2r-ring and raising a platform IMSIC MSI.
    No REE-to-TEE interrupt is used.

The driver implements the TEE subsystem interface (tee_driver_ops)
and provides GlobalPlatform TEE Client API support, dynamic shared
memory registration, and tee-supplicant support.

Signed-off-by: Xing Loong <xing.xl.loong@gmail.com>
---
Changes in v2:
- Fix supp_release incorrectly aborting unclaimed requests on close
- Fix potential tee_shm double-free on supp_recv error path
- Fix async RPC ring skip leaving orphaned payload bytes
- Fix COMPLETE_TEE retry to also handle transient -ENOMEM on RISC-V
- Fix session leak on close_session allocation failure:
  release kernel resources before sending RPC

---

 Documentation/tee/index.rst            |   1 +
 Documentation/tee/mbedtee.rst          | 155 +++++++
 MAINTAINERS                            |   9 +
 drivers/tee/Kconfig                    |   3 +-
 drivers/tee/Makefile                   |   1 +
 drivers/tee/mbedtee/Kconfig            |  20 +
 drivers/tee/mbedtee/Makefile           |  11 +
 drivers/tee/mbedtee/core.c             | 236 ++++++++++
 drivers/tee/mbedtee/mbedtee_drv.h      | 269 +++++++++++
 drivers/tee/mbedtee/mbedtee_msg.h      | 219 +++++++++
 drivers/tee/mbedtee/rpc_callee.c       | 618 +++++++++++++++++++++++++
 drivers/tee/mbedtee/rpc_callee_arm.c   |  91 ++++
 drivers/tee/mbedtee/rpc_callee_riscv.c | 203 ++++++++
 drivers/tee/mbedtee/rpc_caller.c       | 532 +++++++++++++++++++++
 drivers/tee/mbedtee/rpc_caller_arm.c   |  66 +++
 drivers/tee/mbedtee/rpc_caller_riscv.c | 192 ++++++++
 drivers/tee/mbedtee/shm_pool.c         | 105 +++++
 drivers/tee/mbedtee/shm_pool.h         |  15 +
 drivers/tee/mbedtee/supp.c             | 310 +++++++++++++
 include/uapi/linux/tee.h               |   1 +
 20 files changed, 3056 insertions(+), 1 deletion(-)
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

diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
index 10c3cec..6415855 100644
--- a/Documentation/tee/index.rst
+++ b/Documentation/tee/index.rst
@@ -12,3 +12,4 @@ TEE Subsystem
    amd-tee
    ts-tee
    qtee
+   mbedtee
diff --git a/Documentation/tee/mbedtee.rst b/Documentation/tee/mbedtee.rst
new file mode 100644
index 0000000..dfb57b8
--- /dev/null
+++ b/Documentation/tee/mbedtee.rst
@@ -0,0 +1,155 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================
+MbedTEE (Trusted Execution Environment)
+==============================================
+
+The MbedTEE driver supports MbedTEE-based TEEs on ARM TrustZone (SMC calls,
+GIC SPI notifications) and RISC-V IMSIC (shared-memory polling, MSI
+notifications) platforms.
+
+The driver requires the REE and TEE CPUs that share the RPC shared memory to
+be hardware coherent. In practice, the REE/TEE CPUs are expected to be in the
+same CPU cluster, with coherent caches and shared visibility for the ring and
+payload buffers.
+
+Communication overview
+======================
+
+The driver communicates with the TEE using a fixed shared-memory RPC protocol
+layered above the architecture-specific call mechanism.
+
+ARM platforms (SMC)
+-------------------
+
+On ARM and AArch64 platforms, the driver uses ARM SMC Calling Convention
+(SMCCC) to issue fast calls and yield calls to the TEE:
+
+- **Fast calls** (MBEDTEE_RPC_OS_VERSION, MBEDTEE_RPC_SUPPORT_YIELD,
+    MBEDTEE_RPC_COMPLETE_TEE) are self-contained SMC calls that do
+  not rely on shared-memory RPC structures.
+
+- **Yield calls** post the physical address of an ``rpc_cmd`` structure
+  in shared memory to the TEE. The TEE may issue RPC requests back to the
+  driver before the call completes; kernel-directed RPCs are handled
+  directly, while supplicant RPCs (filesystem and RPMB) are forwarded to
+  tee-supplicant.
+
+TEE-to-REE notifications on ARM are delivered via a GIC SPI edge interrupt
+specified in the device tree (``interrupts`` property).
+
+RISC-V platforms
+----------------
+
+On RISC-V platforms, SMCCC is not available. Communication is split into two
+directions:
+
+- **REE to TEE (R2T)**: The driver submits commands by writing the physical
+  address of an ``rpc_cmd`` structure to a REE-to-TEE ring buffer
+  (``r2t-ring``). The TEE polls that ring for new commands. No interrupt
+  notification is sent; the protocol relies on TEE-side polling.
+
+- **TEE to REE (T2R)**: The TEE writes an ``rpc_cmd`` into the TEE-to-REE
+  ring and raises an IMSIC MSI to notify the REE driver. The MSI is
+  allocated at runtime via the ``msi-parent`` DT property and its identity
+  is published in ``callee_imsic_id``; ``callee_hartid`` tracks the
+  target hart for migration during CPU hotplug. No SBI ecall is involved.
+
+RISC-V REE-to-TEE polling rationale
+-----------------------------------
+
+The REE-to-TEE direction uses polling-only on RISC-V to avoid direct
+notification interrupt writes from Linux to TEE-owned interrupt files.
+This design is platform-independent and does not require ownership of
+TEE-only hart interrupt files. The TEE-to-REE direction remains fully
+functional via standard Linux MSI notifications and does not depend on
+REE-to-TEE notification latency.
+
+Shared memory regions
+=====================
+
+Two or three fixed shared memory regions are described in the device tree:
+
+``t2r-ring``
+    Ring buffer used by the TEE to post RPC request notifications to the REE
+    driver. Present on all platforms.
+
+``t2r-shm``
+    Shared memory region carrying the actual ``rpc_cmd`` payloads for
+    TEE-to-REE RPCs. Present on all platforms.
+
+``r2t-ring``
+    Ring buffer used by the REE driver to submit commands to the TEE on
+    RISC-V IMSIC platforms.
+
+RPC protocol
+============
+
+The TEE and REE communicate through the ``rpc_cmd`` structure in shared memory
+and ring buffers::
+
+    struct rpc_cmd {
+        u32 id;          /* RPC function ID */
+        u16 size;        /* payload size in bytes */
+        u8  interrupted; /* set if wait was interrupted */
+        u8  reserved;    /* explicit alignment padding */
+        s32 ret;         /* return value */
+        u32 pad;         /* explicit alignment padding */
+        u64 waiter_id;   /* sync RPC request ID echoed on completion */
+        u64 shm;         /* physical address of payload (sync RPC) */
+        u64 data[];      /* inline payload (async RPC) */
+    };
+
+    struct rpc_ringbuf {
+        u32 wr;              /* producer write pointer */
+        u32 rd;              /* consumer read pointer */
+        u32 callee_ready;    /* callee ready flag */
+        u32 callee_imsic_id; /* RISC-V only: IMSIC local interrupt id */
+        u32 callee_hartid;   /* RISC-V only: target hart-id for T2R notification */
+        u32 reserved;        /* padding, must be zero */
+        u8  mem[];
+    };
+
+For RISC-V T2R MSI, one MSI message targets one hart IMSIC file at a time.
+The wire-visible state is split between ``callee_imsic_id`` and
+``callee_hartid`` in the ring header; Linux may retarget the MSI across
+online CPUs via ``irq_set_affinity()``, and the driver updates those fields
+to match the selected hart.
+
+
+
+Architecture diagram::
+
+    User space                 Kernel                    TEE side
+    ~~~~~~~~~~                 ~~~~~~                    ~~~~~~~~~~~~
+  +--------+                                           +--------------+
+  | Client |                                           | Trusted App  |
+  +--------+                                           +--------------+
+     /\                                                      /\
+     || +------------+                                       ||
+     || | MbedTEE-   |                                       \/
+     || | supplicant |                                 +--------------+
+     || +------------+                                 | TEE Internal |
+     \/      /\                                        |     API      |
+  +-------+  ||                                        +--------------+
+  | TEE   |  ||         +---------+---------------+    |   MbedTEE    |
+  | Client|  ||         |  TEE    | MbedTEE       |    |  Trusted OS  |
+  |  API  |  \/         | subsys  | client driver |    +--------------+
+  +-------+-------------+-----+--------+----------+----+              |
+  |    Generic TEE API        |        | RPC (cmd/ring)|              |
+  |    IOCTL (TEE_IOC_*)      |        | SMC / IMSIC   |              |
+  +---------------------------+        +---------------+--------------+
+
+Device tree binding
+===================
+
+See Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml for the
+complete device tree binding specification, including the RISC-V
+``msi-parent`` requirement.
+
+References
+==========
+
+- [1] MbedTEE project: https://github.com/mbedtee
+- [2] ARM SMC Calling Convention: https://developer.arm.com/architectures/system-architectures/software-standards/smccc
+- [3] RISC-V IMSIC specification: https://github.com/riscv/riscv-aia
diff --git a/MAINTAINERS b/MAINTAINERS
index c8d4b91..344b82b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15920,6 +15920,15 @@ F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
 F:	drivers/net/dsa/mxl862xx/
 F:	net/dsa/tag_mxl862xx.c
 
+MBEDTEE TEE DRIVER
+M:	Xing Loong <xing.xl.loong@gmail.com>
+L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
+S:	Maintained
+W:	https://github.com/mbedtee
+F:	Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
+F:	Documentation/tee/mbedtee.rst
+F:	drivers/tee/mbedtee/
+
 MCAN DEVICE DRIVER
 M:	Markus Schneider-Pargmann <msp@baylibre.com>
 L:	linux-can@vger.kernel.org
diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 98c3ad0..3dc3439 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -2,7 +2,7 @@
 # Generic Trusted Execution Environment Configuration
 menuconfig TEE
 	tristate "Trusted Execution Environment support"
-	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
+	depends on HAVE_ARM_SMCCC || RISCV || COMPILE_TEST || CPU_SUP_AMD
 	select CRYPTO_LIB_SHA1
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
@@ -21,5 +21,6 @@ source "drivers/tee/optee/Kconfig"
 source "drivers/tee/amdtee/Kconfig"
 source "drivers/tee/tstee/Kconfig"
 source "drivers/tee/qcomtee/Kconfig"
+source "drivers/tee/mbedtee/Kconfig"
 
 endif
diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index 3239b91..33117ea 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_OPTEE) += optee/
 obj-$(CONFIG_AMDTEE) += amdtee/
 obj-$(CONFIG_ARM_TSTEE) += tstee/
 obj-$(CONFIG_QCOMTEE) += qcomtee/
+obj-$(CONFIG_MBEDTEE) += mbedtee/
diff --git a/drivers/tee/mbedtee/Kconfig b/drivers/tee/mbedtee/Kconfig
new file mode 100644
index 0000000..b1fa38a
--- /dev/null
+++ b/drivers/tee/mbedtee/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# MbedTEE Trusted Execution Environment Configuration
+config MBEDTEE
+	tristate "MbedTEE"
+	depends on MMU && OF
+	depends on ((ARM || ARM64) && HAVE_ARM_SMCCC) || (RISCV && GENERIC_MSI_IRQ)
+	help
+	  This enables the MbedTEE Trusted Execution Environment (TEE)
+	  driver.
+
+	  The driver supports ARM TrustZone (SMC calls, GIC SPI notifications)
+	  and RISC-V IMSIC (shared-memory polling, MSI notifications), with
+	  GlobalPlatform client API via /dev/tee*.
+
+	  The DT node should be under a firmware node and have compatible =
+	  "mbedtee,tee" with the RPC ring buffer addresses and,
+	  for ARM/ARM64, an interrupt property for TEE-to-REE notifications.
+	  See Documentation/tee/mbedtee.rst for protocol details.
+
+	  If unsure, say N.
diff --git a/drivers/tee/mbedtee/Makefile b/drivers/tee/mbedtee/Makefile
new file mode 100644
index 0000000..309eb6d
--- /dev/null
+++ b/drivers/tee/mbedtee/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_MBEDTEE) += mbedtee.o
+
+mbedtee-y += core.o
+mbedtee-y += supp.o
+mbedtee-y += shm_pool.o
+mbedtee-y += rpc_caller.o rpc_callee.o
+mbedtee-$(CONFIG_ARM) += rpc_caller_arm.o rpc_callee_arm.o
+mbedtee-$(CONFIG_ARM64) += rpc_caller_arm.o rpc_callee_arm.o
+mbedtee-$(CONFIG_RISCV) += rpc_caller_riscv.o rpc_callee_riscv.o
diff --git a/drivers/tee/mbedtee/core.c b/drivers/tee/mbedtee/core.c
new file mode 100644
index 0000000..5807a93
--- /dev/null
+++ b/drivers/tee/mbedtee/core.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tee_drv.h>
+#include <linux/types.h>
+
+#include "mbedtee_drv.h"
+#include "shm_pool.h"
+
+int mbedtee_get_resource(struct device_node *node,
+			 const char *name, struct resource *res)
+{
+	struct device_node *rmem;
+	int idx;
+	int ret;
+
+	idx = of_property_match_string(node, "memory-region-names", name);
+	if (idx < 0)
+		return idx;
+
+	rmem = of_parse_phandle(node, "memory-region", idx);
+	if (!rmem)
+		return -ENODEV;
+
+	ret = of_address_to_resource(rmem, 0, res);
+	of_node_put(rmem);
+
+	if (ret)
+		return ret;
+
+	res->name = name;
+	return 0;
+}
+
+static void mbedtee_get_version(struct tee_device *teedev,
+				struct tee_ioctl_version_data *vers)
+{
+	struct tee_ioctl_version_data v = {
+		.impl_id = TEE_IMPL_ID_MBEDTEE,
+		.impl_caps = 0,
+		.gen_caps = TEE_GEN_CAP_GP | TEE_GEN_CAP_REG_MEM |
+			    TEE_GEN_CAP_MEMREF_NULL,
+	};
+
+	*vers = v;
+}
+
+static int mbedtee_open(struct tee_context *ctx)
+{
+	struct mbedtee_context_data *ctxdata;
+
+	ctxdata = kzalloc_obj(*ctxdata, GFP_KERNEL);
+	if (!ctxdata)
+		return -ENOMEM;
+
+	mutex_init(&ctxdata->mutex);
+	INIT_LIST_HEAD(&ctxdata->sess_list);
+
+	ctx->data = ctxdata;
+	ctx->cap_memref_null = true;
+
+	return 0;
+}
+
+static void mbedtee_release(struct tee_context *ctx)
+{
+	struct mbedtee_device *mbedtee = tee_get_drvdata(ctx->teedev);
+	struct mbedtee_context_data *d = ctx->data;
+	struct mbedtee_session *s, *n;
+
+	if (!d)
+		return;
+
+	if (d->is_supp_ctx) {
+		mbedtee_supp_release(&mbedtee->supp, ctx);
+	} else {
+		list_for_each_entry_safe(s, n, &d->sess_list, list_node)
+			mbedtee_close_session(ctx, s->session_id);
+	}
+
+	kfree(d);
+	ctx->data = NULL;
+}
+
+static const struct tee_driver_ops mbedtee_ops = {
+	.get_version	= mbedtee_get_version,
+	.open		= mbedtee_open,
+	.release	= mbedtee_release,
+	.open_session	= mbedtee_open_session,
+	.close_session	= mbedtee_close_session,
+	.invoke_func	= mbedtee_invoke_func,
+	.cancel_req	= mbedtee_cancel_req,
+	.supp_recv	= mbedtee_supp_recv,
+	.supp_send	= mbedtee_supp_send,
+	.shm_register	= mbedtee_shm_register,
+	.shm_unregister	= mbedtee_shm_unregister,
+};
+
+static const struct tee_desc mbedtee_desc = {
+	.name	= "mbedtee",
+	.ops	= &mbedtee_ops,
+	.owner	= THIS_MODULE,
+};
+
+static int mbedtee_probe(struct platform_device *pdev)
+{
+	int ret;
+	long version;
+	long yield;
+	struct tee_shm_pool *pool;
+	struct tee_device *teedev;
+	struct mbedtee_device *mbedtee;
+
+	mbedtee = devm_kzalloc(&pdev->dev, sizeof(*mbedtee), GFP_KERNEL);
+	if (!mbedtee)
+		return -ENOMEM;
+
+	mbedtee->dev = &pdev->dev;
+	xa_init_flags(&mbedtee->rpc_calls, XA_FLAGS_ALLOC1);
+	mbedtee_supp_init(&mbedtee->supp);
+
+	/*
+	 * R2T must be ready before T2R is advertised: synchronous T2R RPC
+	 * work replies with COMPLETE_TEE over the R2T path.
+	 */
+	ret = mbedtee_r2t_init(mbedtee);
+	if (ret != 0)
+		goto err_supp;
+
+	ret = mbedtee_rpc_init(mbedtee);
+	if (ret != 0)
+		goto err_r2t;
+
+	version = mbedtee_rpc_fastcall(mbedtee, MBEDTEE_RPC_OS_VERSION, 0, 0, 0);
+	if (version < 0) {
+		dev_err(&pdev->dev, "MBEDTEE_RPC_OS_VERSION failed: %ld\n", version);
+		ret = version;
+		goto err_rpc;
+	}
+
+	if (!MBEDTEE_VALID_VERSION(version)) {
+		dev_err(&pdev->dev, "mbedtee not present (version=0x%lx)\n",
+			version);
+		ret = -ENODEV;
+		goto err_rpc;
+	}
+
+	yield = mbedtee_rpc_fastcall(mbedtee, MBEDTEE_RPC_SUPPORT_YIELD, 0, 0, 0);
+	dev_info(&pdev->dev, "version: 0x%06lx  yield: %ld\n", version, yield);
+
+	pool = mbedtee_shm_pool_alloc_pages();
+	if (IS_ERR(pool)) {
+		ret = PTR_ERR(pool);
+		goto err_rpc;
+	}
+
+	teedev = tee_device_alloc(&mbedtee_desc, &pdev->dev, pool, mbedtee);
+	if (IS_ERR(teedev)) {
+		ret = PTR_ERR(teedev);
+		goto err_pool;
+	}
+
+	ret = tee_device_register(teedev);
+	if (ret)
+		goto err_teedev;
+
+	mbedtee->teedev = teedev;
+	mbedtee->version = version;
+	mbedtee->yield = !!yield;
+	mbedtee->pool = pool;
+	platform_set_drvdata(pdev, mbedtee);
+
+	dev_dbg(&pdev->dev, "client initialized\n");
+	return 0;
+
+err_teedev:
+	tee_device_unregister(teedev);
+err_pool:
+	tee_shm_pool_free(pool);
+err_rpc:
+	mbedtee_rpc_uninit(mbedtee);
+err_r2t:
+	mbedtee_r2t_uninit(mbedtee);
+err_supp:
+	mbedtee_supp_uninit(&mbedtee->supp);
+	xa_destroy(&mbedtee->rpc_calls);
+	return ret;
+}
+
+static void mbedtee_remove(struct platform_device *pdev)
+{
+	struct mbedtee_device *mbedtee = platform_get_drvdata(pdev);
+
+	tee_device_unregister(mbedtee->teedev);
+	/*
+	 * Drain T2R before tearing down R2T: queued RPC work may still need
+	 * to send COMPLETE_TEE over R2T. Destroy the supplicant mutex only
+	 * after RPC work can no longer enter mbedtee_supp_handler().
+	 */
+	mbedtee_rpc_uninit(mbedtee);
+	mbedtee_r2t_uninit(mbedtee);
+	mbedtee_supp_uninit(&mbedtee->supp);
+	tee_shm_pool_free(mbedtee->pool);
+	xa_destroy(&mbedtee->rpc_calls);
+}
+
+static const struct of_device_id mbedtee_dt_match[] = {
+	{ .compatible = "mbedtee,tee" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mbedtee_dt_match);
+
+static struct platform_driver mbedtee_driver = {
+	.probe	= mbedtee_probe,
+	.remove	= mbedtee_remove,
+	.driver = {
+		.name		= "mbedtee",
+		.of_match_table	= mbedtee_dt_match,
+	},
+};
+module_platform_driver(mbedtee_driver);
+
+MODULE_AUTHOR("Xing Loong <xing.xl.loong@gmail.com>");
+MODULE_DESCRIPTION("MbedTEE Trusted Execution Environment driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tee/mbedtee/mbedtee_drv.h b/drivers/tee/mbedtee/mbedtee_drv.h
new file mode 100644
index 0000000..59b5b27
--- /dev/null
+++ b/drivers/tee/mbedtee/mbedtee_drv.h
@@ -0,0 +1,269 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ */
+#ifndef MBEDTEE_DRV_H
+#define MBEDTEE_DRV_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/atomic.h>
+#include <linux/of.h>
+#include <linux/ioport.h>
+#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/msi.h>
+#include <linux/workqueue.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/xarray.h>
+#include "mbedtee_msg.h"
+#include "shm_pool.h"
+
+/*
+ * GlobalPlatform TEE Client API return codes/origins
+ * used by this driver. Only the codes actually
+ * referenced in the driver are defined here.
+ */
+#define TEEC_SUCCESS				0x00000000
+#define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
+#define TEEC_ERROR_COMMUNICATION	0xFFFF000E
+
+#define TEEC_ORIGIN_COMMS			0x00000002
+
+#define MBEDTEE_VERSION_MAJOR		1
+#define MBEDTEE_VALID_VERSION(x)	(((x) >> 16) == MBEDTEE_VERSION_MAJOR)
+
+/* Maximum payload size for inline (async) RPC data. */
+#define MBEDTEE_ASYNC_RPC_DATA_MAX	256
+
+struct rpc_transport_ops;
+struct mbedtee_rpc_call;
+struct mbedtee_supp_req;
+struct mbedtee_device;
+
+struct rpc_work {
+	struct work_struct work;
+	struct mbedtee_device *mbedtee;
+	u64 waiter_id;
+	size_t size;
+	bool complete_only;
+	/* Points to ctx->rpc_data (async) or into t2r_shm (sync) */
+	void *data;
+	void (*func)(struct mbedtee_device *mbedtee, void *data, size_t size);
+};
+
+struct mbedtee_t2r_ctx {
+	spinlock_t ring_lock; /* protects T2R ring producer/consumer state */
+	void *t2r_shm;
+	phys_addr_t t2r_shm_phys;
+	resource_size_t t2r_shm_sz;
+	struct rpc_ringbuf *t2r_ring;
+	u32 t2r_ring_sz;
+	u32 t2r_ring_rd;
+
+	void (*rpc_handlers[MBEDTEE_RPC_MAX])(struct mbedtee_device *mbedtee,
+					      void *data, size_t size);
+
+	/*
+	 * Inline buffer for async RPC payloads (waiter_id == 0).
+	 * Sync RPC payloads (waiter_id != 0) live in shared memory (t2r_shm).
+	 */
+	u8 rpc_data[MBEDTEE_ASYNC_RPC_DATA_MAX];
+
+	/*
+	 * CPU-hotplug tracking for T2R interrupt delivery.
+	 * callee_cpus: shadow of cpu_online_mask maintained by the core
+	 *   callee layer (rpc_callee.c) for both ARM and RISC-V; used by
+	 *   ARM to feed irq_set_affinity() and by RISC-V as the gate for
+	 *   MSI migration decisions.
+	 * callee_virq: single MSI virq currently pinned to one CPU
+	 *   (RISC-V IMSIC only; 0 for ARM).
+	 * hp_node: per-instance node for cpuhp_setup_state_multi().
+	 */
+	struct cpumask callee_cpus;
+	int callee_virq;
+	struct hlist_node hp_node;
+	bool cpuhp_added;
+	bool complete_work_pending;
+	bool pending_async;
+	u32 pending_size;
+	struct workqueue_struct *rpc_wq;
+	struct rpc_work complete_work;
+	void (*pending_func)(struct mbedtee_device *mbedtee,
+			     void *data, size_t size);
+};
+
+struct mbedtee_r2t_ctx {
+	spinlock_t lock; /* protects R2T ring write-side state */
+	struct rpc_ringbuf *ring;
+	u32 ring_sz;
+	u32 ring_wr;
+};
+
+struct mbedtee_rpc_transport_ctx {
+	int rpc_notify_virq;
+	struct msi_msg rpc_msi_msg;
+};
+
+struct mbedtee_supp {
+	struct mutex mutex; /* serializes supp request queue and active requests */
+	struct tee_context *ctx;
+	bool shutting_down;
+	struct list_head reqs;
+	struct list_head active_reqs;
+	struct completion reqs_c;
+};
+
+struct mbedtee_device {
+	u32 version;
+	bool yield;
+	struct device *dev;
+	struct tee_device *teedev;
+	struct tee_shm_pool *pool;
+	struct mbedtee_supp supp;
+	struct xarray rpc_calls;
+	atomic_long_t rpc_call_seq;
+	const struct rpc_transport_ops *rpc_ops;
+	struct mbedtee_t2r_ctx t2r;
+	struct mbedtee_r2t_ctx r2t;
+	struct mbedtee_rpc_transport_ctx transport;
+};
+
+struct mbedtee_rpc_call {
+	struct completion c;
+	phys_addr_t rpc_phys;
+	u32 state;
+	/*
+	 * Wire-format rpc_cmd with inline data[] payload.
+	 * MUST be the last field: rpc.data[] is a flexible array.
+	 */
+	struct rpc_cmd rpc;
+};
+
+struct mbedtee_session {
+	struct list_head list_node;
+	u32 session_id;
+};
+
+struct mbedtee_context_data {
+	bool is_supp_ctx;
+	struct mutex mutex; /* serializes session list updates */
+	struct list_head sess_list;
+};
+
+static inline phys_addr_t mbedtee_virt_to_phys(void *va)
+{
+	if (is_vmalloc_or_module_addr(va))
+		return page_to_phys(vmalloc_to_page(va)) +
+		       offset_in_page(va);
+
+	return virt_to_phys(va);
+}
+
+int mbedtee_get_resource(struct device_node *node,
+			 const char *name, struct resource *res);
+
+/*
+ * RPC transport operations -- implemented per-architecture.
+ *
+ * Caller (rpc_caller_{arm,riscv}.c) platform differences:
+ *   fastcall:       ARM/ARM64 - direct SMC (arm_smccc_smc), synchronous,
+ *                   never returns -ENOSPC.
+ *                   RISC-V - writes rpc_cmd phys addr to the r2t ring
+ *                   buffer, then waits for TEE completion via the t2r
+ *                   ring.  Despite the "fastcall" name this is a
+ *                   synchronous ring-buffer round-trip; it may return
+ *                   -ENOSPC when the r2t ring is full, and the caller
+ *                   must retry (see rpc_routine() for the
+ *                   MBEDTEE_RPC_COMPLETE_TEE retry loop).
+ *   yieldcall:      ARM/ARM64 - one SMC posting rpc_cmd phys addr, waits
+ *                   for completion.
+ *                   RISC-V - writes rpc_cmd phys addr to r2t ring, waits
+ *                   for completion.
+ * Callee (rpc_callee_{arm,riscv}.c) platform differences:
+ *   notify:         ARM/ARM64 - GIC SPI; the TEE broadcasts via GIC
+ *                   hardware (GICv2 ITARGETS=0xFF, GICv3 IROUTER.IRM=1).
+ *                   Ring metadata unchanged on CPU affinity events.
+ *                   RISC-V - IMSIC MSI; the driver writes callee_hartid
+ *                   and callee_imsic_id into the ring so the TEE knows
+ *                   where to send the MSI. The affinity handler updates
+ *                   both ring fields when the callee CPU goes offline.
+ *
+ * init:             Set up the interrupt delivery mechanism (MSI on RISC-V,
+ *                   GIC/OF-IRQ on ARM/ARM64) and, on RISC-V, write
+ *                   ring->callee_hartid and ring->callee_imsic_id. @handler
+ *                   is the hard-IRQ handler that drains the ring buffer and
+ *                   dispatches RPC commands.
+ * uninit:           Tear down and free all interrupt resources.
+ * update_affinity:  Migrate T2R interrupt delivery to @new_cpu. Called by the
+ *                   common cpuhp handler when the current callee CPU goes
+ *                   offline. On RISC-V IMSIC, must update ring->callee_hartid
+ *                   and ring->callee_imsic_id. ARM uses GIC hardware routing
+ *                   and requires no ring update.
+ *
+ * The getter is implemented per-architecture in rpc_callee_{arm,riscv}.c;
+ * only one is linked per build.
+ */
+struct rpc_transport_ops {
+	int (*init)(struct mbedtee_device *mbedtee, struct rpc_ringbuf *ring,
+		    irq_handler_t handler);
+	void (*uninit)(struct mbedtee_device *mbedtee);
+	int (*update_affinity)(struct mbedtee_device *mbedtee,
+			       unsigned int new_cpu);
+};
+
+const struct rpc_transport_ops *mbedtee_get_rpc_transport_ops(void);
+
+/* rpc-callee.c */
+int mbedtee_rpc_init(struct mbedtee_device *mbedtee);
+void mbedtee_rpc_uninit(struct mbedtee_device *mbedtee);
+irqreturn_t mbedtee_rpc_irq_handler(int irq, void *dev_id);
+
+/* rpc_caller.c */
+int mbedtee_rpc_call_alloc(struct mbedtee_device *mbedtee,
+			   size_t payload_size, struct mbedtee_rpc_call **call);
+void mbedtee_rpc_call_free(struct mbedtee_device *mbedtee,
+			   struct mbedtee_rpc_call *call);
+void mbedtee_rpc_complete_call(struct mbedtee_device *mbedtee,
+			       u64 waiter_id);
+long mbedtee_rpc_wait_for_completion(struct mbedtee_device *mbedtee,
+				     struct mbedtee_rpc_call *call, bool killable);
+int mbedtee_open_session(struct tee_context *ctx,
+			 struct tee_ioctl_open_session_arg *arg,
+			 struct tee_param *param);
+int mbedtee_close_session(struct tee_context *ctx, u32 session);
+int mbedtee_invoke_func(struct tee_context *ctx,
+			struct tee_ioctl_invoke_arg *arg,
+			struct tee_param *param);
+int mbedtee_cancel_req(struct tee_context *ctx, u32 cancel_id,
+		       u32 session);
+int mbedtee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
+			 struct page **pages, size_t num_pages, unsigned long start);
+int mbedtee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm);
+
+/* rpc-caller-{arm,riscv}.c */
+long mbedtee_rpc_yieldcall(struct mbedtee_device *mbedtee,
+			   unsigned long fn, struct mbedtee_rpc_call *call,
+			   bool interruptible);
+long mbedtee_rpc_fastcall(struct mbedtee_device *mbedtee,
+			  unsigned long fn, unsigned long a0,
+			  unsigned long a1, unsigned long a2);
+int mbedtee_r2t_init(struct mbedtee_device *mbedtee);
+void mbedtee_r2t_uninit(struct mbedtee_device *mbedtee);
+
+/* supp.c */
+void mbedtee_supp_init(struct mbedtee_supp *supp);
+void mbedtee_supp_uninit(struct mbedtee_supp *supp);
+void mbedtee_supp_release(struct mbedtee_supp *supp, struct tee_context *ctx);
+void mbedtee_supp_abort_all(struct mbedtee_supp *supp);
+void mbedtee_supp_handler(struct mbedtee_device *mbedtee,
+			  u32 func, void *data, size_t size);
+int mbedtee_supp_recv(struct tee_context *ctx, u32 *func,
+		      u32 *num_params, struct tee_param *param);
+int mbedtee_supp_send(struct tee_context *ctx, u32 ret,
+		      u32 num_params, struct tee_param *param);
+
+#endif /* MBEDTEE_DRV_H */
diff --git a/drivers/tee/mbedtee/mbedtee_msg.h b/drivers/tee/mbedtee/mbedtee_msg.h
new file mode 100644
index 0000000..deb2d8c
--- /dev/null
+++ b/drivers/tee/mbedtee/mbedtee_msg.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ *
+ * MbedTEE RPC wire protocol between REE (Linux) and TEE (MbedTEE OS).
+ *
+ * This header is the Linux-kernel mirror of
+ * mbedtee-os/drivers/rpc/include/rpc/rpc.h. Both copies MUST define
+ * identical struct layouts. The static_assert() checks at the bottom
+ * of this file (and the _Static_assert() checks in rpc.h) enforce this
+ * contract at compile time on every architecture.
+ *
+ * Type mapping (wire -> Linux kernel alias):
+ *   uint8_t   -> u8   -- boolean flag / padding byte
+ *   uint16_t  -> u16  -- byte-count field (< 64 KiB payload limit)
+ *   uint32_t  -> u32  -- 32-bit ID, counter, flag, or enum
+ *   int32_t   -> s32  -- function-defined signed result code
+ *   uint64_t  -> u64  -- physical address, kernel pointer token, or size
+ *
+ * Using u64 for all pointer-sized fields eliminates ABI width mismatches
+ * in mixed-width configurations (e.g. RV64 REE + RV32 TEE, or ARM32-LPAE
+ * REE + ARM32 TEE). It also prevents phys_addr_t/unsigned-long confusion
+ * when CONFIG_PHYS_ADDR_T_64BIT=y on a 32-bit REE kernel.
+ */
+
+#ifndef MBEDTEE_MSG_H
+#define MBEDTEE_MSG_H
+
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/types.h>
+
+/*
+ * Fastcall / yield-call classification
+ */
+#define MBEDTEE_RPC_FASTCALL            BIT(31)
+#define MBEDTEE_RPC_IS_FASTCALL(fn)     ((fn) & MBEDTEE_RPC_FASTCALL)
+
+/*
+ * REE -> TEE fast calls
+ */
+#define MBEDTEE_RPC_OS_VERSION          (0x0100 | MBEDTEE_RPC_FASTCALL)
+#define MBEDTEE_RPC_SUPPORT_YIELD       (0x0101 | MBEDTEE_RPC_FASTCALL)
+#define MBEDTEE_RPC_COMPLETE_TEE        (0x0102 | MBEDTEE_RPC_FASTCALL)
+
+/*
+ * REE -> TEE yield calls
+ */
+#define MBEDTEE_RPC_OPEN_SESSION        1
+#define MBEDTEE_RPC_INVOKE_SESSION      2
+#define MBEDTEE_RPC_CLOSE_SESSION       3
+#define MBEDTEE_RPC_REGISTER_SHM        5
+#define MBEDTEE_RPC_UNREGISTER_SHM      6
+#define MBEDTEE_RPC_CANCEL              7
+
+/*
+ * TEE -> REE RPC calls
+ */
+#define MBEDTEE_RPC_COMPLETE_REE        0
+#define MBEDTEE_RPC_REETIME             1
+#define MBEDTEE_RPC_REEFS               2
+#define MBEDTEE_RPC_RPMB                3
+#define MBEDTEE_RPC_MAX                 4
+
+/*
+ * Supplicant types (TEE -> REE -> tee-supplicant)
+ */
+#define MBEDTEE_SUPP_REEFS              1
+#define MBEDTEE_SUPP_RPMB               2
+
+/* MbedTEE RPC protocol uses 4 KiB page units regardless of host PAGE_SIZE. */
+#define MBEDTEE_PAGE_SIZE           4096UL
+
+/*
+ * REE <-> TEE RPC call command (wire format, 32 bytes fixed header).
+ *
+ * Fixed layout:
+ *   +0   id          u32 - RPC function identifier
+ *   +4   size        u16 - inline payload byte count (0..65535)
+ *   +6   interrupted u8  - set by REE when caller is interrupted
+ *   +7   reserved    u8  - must be zero (explicit alignment pad)
+ *   +8   ret         s32 - return value written by callee
+ *   +12  pad         u32 - must be zero (explicit alignment pad)
+ *   +16  waiter_id   u64 - sync RPC request ID echoed on completion
+ *   +24  shm         u64 - physical address of sync-RPC shared memory
+ *   +32  data[]      u64 - inline payload (waiter_id==0) or empty
+ *
+ * Yield-call contract:
+ *   - Session/control RPCs return GlobalPlatform result codes here.
+ *   - Host-local errno values must be translated before being put on the wire.
+ *   - Fast calls may use function-specific return values.
+ */
+struct rpc_cmd {
+	u32 id;
+	u16 size;
+	u8  interrupted;
+	u8  reserved;
+	s32 ret;
+	u32 pad;
+	u64 waiter_id;
+	u64 shm;
+	u64 data[];
+};
+
+/*
+ * REE -> TEE pages for GP shared memory.
+ *
+ * All fields are u64 so the layout is identical when REE is 64-bit
+ * but TEE is 32-bit (physical addresses, sizes and counts use 64 bits).
+ */
+struct rpc_memref {
+	u64 id;
+	u64 pages;
+	u64 offset;
+	u64 size;
+	u64 cnt;
+};
+
+/*
+ * REE -> TEE parameter entry: value or shared memory reference.
+ */
+union rpc_tee_param {
+	struct rpc_memref memref;
+
+	struct {
+		u32 a;
+		u32 b;
+	} value;
+};
+
+/*
+ * REE -> TEE parameters for RPC session operations
+ * (MBEDTEE_RPC_OPEN_SESSION / MBEDTEE_RPC_INVOKE_SESSION /
+ *  MBEDTEE_RPC_CLOSE_SESSION).
+ */
+struct rpc_param {
+	s32 session_id;
+	u32 cmd_id;
+	u32 ret_origin;
+	u32 params_type;
+	union rpc_tee_param params[4];
+	u8  uuid[16];
+	u8  clnt_uuid[16];
+};
+
+/*
+ * REE -> TEE cancellation request (MBEDTEE_RPC_CANCEL).
+ */
+struct rpc_cancel_req {
+	u32 session_id;
+	u32 cancel_id;
+};
+
+/*
+ * TEE <-> REE supplicant payloads for REEFS and RPMB RPCs.
+ * Only the fixed headers are interpreted in the Linux driver.
+ */
+/*
+ * Common supplicant command header. Both reefs_cmd and rpmb_cmd embed this
+ * as their first member so the kernel can write a status code through a
+ * single cast to (struct supp_cmd_hdr *) without caring about the full
+ * payload type. The wire layout is identical on every architecture.
+ */
+struct supp_cmd_hdr {
+	s32 ret;
+	s32 op;
+};
+
+struct reefs_cmd {
+	struct supp_cmd_hdr hdr;
+	s32 flags;
+	s32 fd;
+	u64 len;
+	u8 data[];
+};
+
+struct rpmb_cmd {
+	struct supp_cmd_hdr hdr;
+	u32 nframes;
+	u8 data[];
+};
+
+/*
+ * TEE <-> REE RPC ring buffer header (24 bytes fixed).
+ */
+struct rpc_ringbuf {
+	u32 wr;              /* producer write pointer */
+	u32 rd;              /* consumer read pointer */
+	u32 callee_ready;    /* callee ready flag */
+	u32 callee_imsic_id; /* RISC-V only: IMSIC local interrupt id */
+	u32 callee_hartid;   /* RISC-V only: target hart-id for T2R notification */
+	u32 reserved;        /* padding, must be zero */
+	u8  mem[];
+};
+
+/*
+ * Compile-time ABI layout assertions.
+ * These must match the _Static_assert() checks in mbedtee-os rpc/rpc.h.
+ */
+static_assert(sizeof(struct rpc_cmd) == 32,
+	      "rpc_cmd wire size mismatch");
+static_assert(offsetof(struct rpc_cmd, ret) == 8,
+	      "rpc_cmd.ret offset mismatch");
+static_assert(offsetof(struct rpc_cmd, waiter_id) == 16,
+	      "rpc_cmd.waiter_id offset mismatch");
+static_assert(offsetof(struct rpc_cmd, shm) == 24,
+	      "rpc_cmd.shm offset mismatch");
+static_assert(offsetof(struct rpc_cmd, data) == 32,
+	      "rpc_cmd.data offset mismatch");
+static_assert(sizeof(struct rpc_memref) == 40,
+	      "rpc_memref wire size mismatch");
+static_assert(sizeof(struct rpc_ringbuf) == 24,
+	      "rpc_ringbuf header size mismatch");
+static_assert(sizeof(struct rpc_param) == 208,
+	      "rpc_param wire size mismatch");
+static_assert(sizeof(struct rpc_cancel_req) == 8,
+	      "rpc_cancel_req wire size mismatch");
+
+#endif /* MBEDTEE_MSG_H */
diff --git a/drivers/tee/mbedtee/rpc_callee.c b/drivers/tee/mbedtee/rpc_callee.c
new file mode 100644
index 0000000..e3373a7
--- /dev/null
+++ b/drivers/tee/mbedtee/rpc_callee.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ * TEE->REE callee-side: handles interrupts from TEE, processes RPC requests.
+ */
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/tee_drv.h>
+#include <linux/workqueue.h>
+
+#include "mbedtee_drv.h"
+
+/*
+ * CPU hotplug state shared across all mbedtee instances (registered once).
+ */
+static int mbedtee_cpuhp_state = -EINVAL;
+static unsigned int mbedtee_cpuhp_instances;
+static DEFINE_MUTEX(mbedtee_cpuhp_mutex);
+/* rpc_routine() runs on workqueue, re-drains ring on completion */
+static void rpc_routine(struct work_struct *work);
+
+/*
+ * Common CPU-online handler: add the new CPU into the eligible T2R
+ * delivery set and let the transport re-apply affinity.
+ */
+static int mbedtee_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct mbedtee_t2r_ctx *ctx =
+		hlist_entry(node, struct mbedtee_t2r_ctx, hp_node);
+	struct mbedtee_device *mbedtee =
+		container_of(ctx, struct mbedtee_device, t2r);
+	unsigned int target_cpu;
+
+	if (!ctx->t2r_ring || cpumask_test_cpu(cpu, &ctx->callee_cpus))
+		return 0;
+
+	cpumask_set_cpu(cpu, &ctx->callee_cpus);
+	target_cpu = cpumask_first(&ctx->callee_cpus);
+
+	if (mbedtee->rpc_ops && mbedtee->rpc_ops->update_affinity)
+		mbedtee->rpc_ops->update_affinity(mbedtee, target_cpu);
+
+	return 0;
+}
+
+/*
+ * Common CPU-offline handler: migrates T2R interrupt delivery to another
+ * online CPU when the current callee CPU is being taken offline.
+ *
+ * The transport-specific update_affinity() callback handles the actual
+ * interrupt migration (e.g. irq_set_affinity + callee_hartid update for
+ * RISC-V IMSIC; irq_set_affinity only for ARM - no ring update needed).
+ */
+static int mbedtee_cpu_offline(unsigned int cpu, struct hlist_node *node)
+{
+	struct mbedtee_t2r_ctx *ctx =
+		hlist_entry(node, struct mbedtee_t2r_ctx, hp_node);
+	struct mbedtee_device *mbedtee =
+		container_of(ctx, struct mbedtee_device, t2r);
+	unsigned int new_cpu;
+
+	if (!ctx->t2r_ring || !cpumask_test_cpu(cpu, &ctx->callee_cpus))
+		return 0;
+
+	/*
+	 * Remove the dying CPU from the eligible set.  If the set is now
+	 * empty (all CPUs going away at once -- highly unlikely but safe),
+	 * fall back to CPU 0 which Linux guarantees to be the last offline.
+	 */
+	cpumask_clear_cpu(cpu, &ctx->callee_cpus);
+	if (cpumask_empty(&ctx->callee_cpus))
+		cpumask_set_cpu(0, &ctx->callee_cpus);
+
+	new_cpu = cpumask_first(&ctx->callee_cpus);
+
+	if (mbedtee->rpc_ops && mbedtee->rpc_ops->update_affinity)
+		mbedtee->rpc_ops->update_affinity(mbedtee, new_cpu);
+	return 0;
+}
+
+static inline size_t t2r_available_size(struct mbedtee_t2r_ctx *ctx)
+{
+	u32 wr;
+	u32 rd;
+	u32 shm_size = ctx->t2r_ring_sz;
+
+	/* Pair with producer release store after writing ring payload. */
+	wr = smp_load_acquire(&ctx->t2r_ring->wr);
+	rd = READ_ONCE(ctx->t2r_ring_rd);
+
+	if (wr > shm_size)
+		return 0;
+
+	if (wr >= rd)
+		return wr - rd;
+	return shm_size + wr - rd;
+}
+
+static void t2r_ring_copy(struct mbedtee_t2r_ctx *ctx,
+			  void *data, size_t size, u32 rd)
+{
+	u32 remain;
+	u32 shm_size = ctx->t2r_ring_sz;
+	struct rpc_ringbuf *shm = ctx->t2r_ring;
+
+	if (rd + size <= shm_size) {
+		memcpy(data, &shm->mem[rd], size);
+	} else {
+		remain = rd + size - shm_size;
+		memcpy(data, &shm->mem[rd], size - remain);
+		memcpy((u8 *)data + size - remain,
+		       &shm->mem[0], remain);
+	}
+}
+
+static void t2r_ring_advance(struct mbedtee_t2r_ctx *ctx, size_t size)
+{
+	u32 rd = READ_ONCE(ctx->t2r_ring_rd);
+	u32 shm_size = ctx->t2r_ring_sz;
+	struct rpc_ringbuf *shm = ctx->t2r_ring;
+
+	if (rd + size > shm_size)
+		rd = rd + size - shm_size;
+	else
+		rd += size;
+
+	WRITE_ONCE(ctx->t2r_ring_rd, rd);
+	/* Publish updated consumer index after command parsing is complete. */
+	smp_store_release(&shm->rd, rd);
+}
+
+/*
+ * Read and consume @size bytes from the TEE-to-REE ring buffer.
+ * Must be called with ctx->ring_lock held.
+ */
+static void t2r_ring_read(struct mbedtee_t2r_ctx *ctx,
+			  void *data, size_t size)
+{
+	t2r_ring_copy(ctx, data, size, READ_ONCE(ctx->t2r_ring_rd));
+	t2r_ring_advance(ctx, size);
+}
+
+static bool rpc_queue_complete_only(struct mbedtee_t2r_ctx *ctx,
+				    u64 waiter_id)
+{
+	if (ctx->complete_work_pending)
+		return false;
+
+	ctx->complete_work_pending = true;
+	ctx->complete_work.waiter_id = waiter_id;
+	queue_work(ctx->rpc_wq, &ctx->complete_work.work);
+
+	return true;
+}
+
+/*
+ * Try to pick the next RPC command from the ring buffer.
+ *
+ * For asynchronous RPCs the data payload follows the cmd header in the
+ * ring.  If the payload has not fully arrived yet the cmd header is still
+ * consumed (it was already read) but the entry is marked incomplete so
+ * that the next IRQ resumes reading the payload instead of re-reading
+ * a header.
+ *
+ * For synchronous RPCs (waiter_id != 0) the work descriptor is allocated
+ * BEFORE the ring header is consumed.  This guarantees that if the
+ * allocator returns NULL the ring entry is left intact so the IRQ
+ * handler will retry on the next wake-up rather than leaving a TEE
+ * thread blocked with no response.
+ *
+ * Returns a work descriptor on success, or NULL when no complete entry
+ * is available.
+ */
+static struct rpc_work *rpc_pick_next(struct mbedtee_device *mbedtee,
+				      struct mbedtee_t2r_ctx *ctx, struct rpc_work *c)
+{
+	struct rpc_cmd cmd;
+	void (*func)(struct mbedtee_device *mbedtee, void *data, size_t size);
+	struct rpc_work *new_work = NULL;
+	resource_size_t off;
+	phys_addr_t shm_phys;
+	u64 shm_wire;
+
+	/* Resume reading payload of a previously incomplete async RPC */
+	if (ctx->pending_async) {
+		if (t2r_available_size(ctx) < ctx->pending_size)
+			return NULL;
+		ctx->pending_async = false;
+		t2r_ring_read(ctx, c->data, ctx->pending_size);
+		c->func = ctx->pending_func;
+		c->size = ctx->pending_size;
+		c->waiter_id = 0;
+		return c;
+	}
+
+	if (t2r_available_size(ctx) < sizeof(cmd))
+		return NULL;
+
+	/*
+	 * Peek at the header without advancing the ring pointer.
+	 * For sync RPCs we must pre-allocate before consuming the entry.
+	 */
+	memset(&cmd, 0, sizeof(cmd));
+	t2r_ring_copy(ctx, &cmd, sizeof(cmd), READ_ONCE(ctx->t2r_ring_rd));
+
+	if (cmd.id >= MBEDTEE_RPC_MAX)
+		goto skip;
+
+	func = ctx->rpc_handlers[cmd.id];
+	if (!func)
+		goto skip;
+
+	if (cmd.waiter_id == 0) {
+		/* Async RPC: payload follows header in the ring */
+		if (cmd.size > sizeof(ctx->rpc_data))
+			goto skip;
+
+		/* Consume the header now that we know it is valid */
+		t2r_ring_advance(ctx, sizeof(cmd));
+
+		if (t2r_available_size(ctx) < cmd.size) {
+			/* Mark as incomplete, resume on next iteration */
+			ctx->pending_async = true;
+			ctx->pending_size = cmd.size;
+			ctx->pending_func = func;
+			return NULL;
+		}
+
+		t2r_ring_read(ctx, c->data, cmd.size);
+	} else {
+		/* Sync RPC: data lives in the shared memory region */
+		shm_wire = cmd.shm;
+		shm_phys = (phys_addr_t)shm_wire;
+		if ((u64)shm_phys != shm_wire)
+			goto skip;
+
+		if (shm_phys < ctx->t2r_shm_phys)
+			goto skip;
+
+		off = shm_phys - ctx->t2r_shm_phys;
+		if (cmd.size == 0 || cmd.size > ctx->t2r_shm_sz)
+			goto skip;
+
+		if (off > ctx->t2r_shm_sz - cmd.size)
+			goto skip;
+
+		new_work = kzalloc_obj(*new_work, GFP_ATOMIC);
+		if (!new_work)
+			return NULL;
+
+		t2r_ring_advance(ctx, sizeof(cmd));
+
+		c = new_work;
+		c->mbedtee = mbedtee;
+		c->data = ctx->t2r_shm + off;
+	}
+
+	c->func = func;
+	c->waiter_id = cmd.waiter_id;
+	c->size = cmd.size;
+
+	return c;
+
+skip:
+	/*
+	 * If this was a sync RPC (waiter_id != 0) we must notify the TEE
+	 * thread so it does not wait forever.  Defer the completion fastcall
+	 * to process context because transport implementations may sleep.
+	 * If the single deferred-completion slot is already in use, leave the
+	 * header in place and retry after the pending completion has drained.
+	 */
+	if (cmd.waiter_id != 0 && !rpc_queue_complete_only(ctx, cmd.waiter_id))
+		return NULL;
+
+	/*
+	 * Bad or unhandled entry: consume header plus any inline payload
+	 * (async RPC payloads follow the header in the ring) to keep the
+	 * ring moving.  For sync RPCs payload is in t2r_shm, not the ring.
+	 */
+	t2r_ring_advance(ctx, sizeof(cmd) + (cmd.waiter_id ? 0 : cmd.size));
+
+	return NULL;
+}
+
+static void rpc_drain_ring(struct mbedtee_device *mbedtee)
+{
+	struct mbedtee_t2r_ctx *ctx = &mbedtee->t2r;
+	struct rpc_work rw = {}, *c = NULL;
+	unsigned long flags;
+
+	if (!ctx->t2r_ring)
+		return;
+
+	spin_lock_irqsave(&ctx->ring_lock, flags);
+	while (READ_ONCE(ctx->t2r_ring_rd) !=
+	    /* Pair with producer store-release after ring write. */
+	    smp_load_acquire(&ctx->t2r_ring->wr)) {
+		rw.data = ctx->rpc_data;
+		c = rpc_pick_next(mbedtee, ctx, &rw);
+		if (!c)
+			break;
+
+		if (c->waiter_id == 0) {
+			c->func(mbedtee, c->data, c->size);
+		} else {
+			INIT_WORK(&c->work, rpc_routine);
+			queue_work(ctx->rpc_wq, &c->work);
+		}
+	}
+	spin_unlock_irqrestore(&ctx->ring_lock, flags);
+}
+
+static void rpc_routine(struct work_struct *work)
+{
+	struct rpc_work *c = container_of(work, struct rpc_work, work);
+	struct mbedtee_t2r_ctx *ctx = &c->mbedtee->t2r;
+	long ret;
+
+	if (!c->complete_only)
+		c->func(c->mbedtee, c->data, c->size);
+
+	/*
+	 * COMPLETE_TEE must reach the TEE thread that issued the sync RPC.
+	 * On RISC-V the notification uses a shared ring buffer that may be
+	 * transiently full when many RPCs are in flight concurrently.
+	 * Keep retrying rather than silently dropping the completion, which
+	 * would leave the TEE thread blocked in rpc_call_sync forever.
+	 * On ARM the fastcall is a direct SMC so -ENOSPC never occurs.
+	 */
+	do {
+		ret = mbedtee_rpc_fastcall(c->mbedtee, MBEDTEE_RPC_COMPLETE_TEE,
+					   (unsigned long)c->waiter_id, 0, 0);
+		if (ret != -ENOSPC && ret != -ENOMEM)
+			break;
+		cond_resched();
+	} while (1);
+
+	if (c != &ctx->complete_work) {
+		kfree(c);
+		return;
+	}
+
+	WRITE_ONCE(ctx->complete_work_pending, false);
+	rpc_drain_ring(c->mbedtee);
+}
+
+/*
+ * Hard IRQ handler -- drains the TEE-to-REE ring buffer.
+ *
+ * Asynchronous RPCs (waiter_id == 0) are handled inline since all async
+ * handlers (complete(), ktime_get_real_ts64()) are non-blocking.
+ *
+ * Synchronous RPCs (waiter_id != 0) may block waiting for the
+ * tee-supplicant, so they are dispatched to a workqueue.
+ */
+irqreturn_t mbedtee_rpc_irq_handler(int irq, void *dev_id)
+{
+	struct mbedtee_device *mbedtee = dev_id;
+
+	if (!mbedtee)
+		return IRQ_NONE;
+
+	rpc_drain_ring(mbedtee);
+
+	return IRQ_HANDLED;
+}
+
+static void mbedtee_rpc_complete(struct mbedtee_device *mbedtee,
+				 void *data, size_t size)
+{
+	u64 waiter_id;
+
+	if (size < sizeof(waiter_id))
+		return;
+
+	memcpy(&waiter_id, data, sizeof(waiter_id));
+	if (!waiter_id)
+		return;
+
+	mbedtee_rpc_complete_call(mbedtee, waiter_id);
+}
+
+static void mbedtee_ree_time(struct mbedtee_device *mbedtee,
+			     void *data, size_t size)
+{
+	struct timespec64 *ts = data;
+
+	if (size < sizeof(*ts))
+		return;
+
+	ktime_get_real_ts64(ts);
+}
+
+static void mbedtee_reefs_supp(struct mbedtee_device *mbedtee,
+			       void *data, size_t size)
+{
+	mbedtee_supp_handler(mbedtee, MBEDTEE_SUPP_REEFS, data, size);
+}
+
+static void mbedtee_rpmb_supp(struct mbedtee_device *mbedtee,
+			      void *data, size_t size)
+{
+	mbedtee_supp_handler(mbedtee, MBEDTEE_SUPP_RPMB, data, size);
+}
+
+static void mbedtee_register_rpc(struct mbedtee_device *mbedtee,
+				 u32 id, void (*func)(struct mbedtee_device *mbedtee,
+					void *data, size_t size))
+{
+	struct mbedtee_t2r_ctx *ctx = &mbedtee->t2r;
+
+	if (WARN_ON(id >= MBEDTEE_RPC_MAX || !func))
+		return;
+
+	ctx->rpc_handlers[id] = func;
+}
+
+int mbedtee_rpc_init(struct mbedtee_device *mbedtee)
+{
+	struct mbedtee_t2r_ctx *ctx = &mbedtee->t2r;
+	struct device_node *node = mbedtee->dev->of_node;
+	struct resource res;
+	bool cpuhp_state_created = false;
+	int ret;
+
+	memset(ctx, 0, sizeof(*ctx));
+	spin_lock_init(&ctx->ring_lock);
+	mbedtee->rpc_ops = mbedtee_get_rpc_transport_ops();
+	if (!mbedtee->rpc_ops)
+		return -EIO;
+
+	ret = mbedtee_get_resource(node, "t2r-ring", &res);
+	if (ret) {
+		dev_err(mbedtee->dev, "t2r-ring not found in DT\n");
+		return ret;
+	}
+
+	ctx->t2r_ring = memremap(res.start, resource_size(&res),
+				 MEMREMAP_WB);
+	if (!ctx->t2r_ring) {
+		dev_err(mbedtee->dev, "failed to map t2r ring\n");
+		return -ENOMEM;
+	}
+	if (resource_size(&res) <= sizeof(struct rpc_ringbuf)) {
+		dev_err(mbedtee->dev, "t2r-ring too small\n");
+		memunmap(ctx->t2r_ring);
+		ctx->t2r_ring = NULL;
+		return -EINVAL;
+	}
+	ctx->t2r_ring_sz = resource_size(&res) - sizeof(struct rpc_ringbuf);
+	/* Observe latest producer index only after ring metadata is visible. */
+	WRITE_ONCE(ctx->t2r_ring_rd, smp_load_acquire(&ctx->t2r_ring->rd));
+
+	dev_dbg(mbedtee->dev, "t2r-ring %pa\n", &res.start);
+
+	ret = mbedtee_get_resource(node, "t2r-shm", &res);
+	if (ret) {
+		dev_err(mbedtee->dev, "t2r-shm not found in DT\n");
+		goto err_ring;
+	}
+
+	ctx->t2r_shm_phys = res.start;
+	ctx->t2r_shm_sz = resource_size(&res);
+	ctx->t2r_shm = memremap(res.start, ctx->t2r_shm_sz,
+				MEMREMAP_WB);
+	if (!ctx->t2r_shm) {
+		dev_err(mbedtee->dev, "failed to map t2r shm\n");
+		ret = -ENOMEM;
+		goto err_ring;
+	}
+
+	dev_dbg(mbedtee->dev, "t2r-shm %pa\n", &res.start);
+
+	ctx->rpc_wq = alloc_workqueue("mbedtee-rpc", WQ_UNBOUND, 0);
+	if (!ctx->rpc_wq) {
+		dev_err(mbedtee->dev, "failed to create rpc workqueue\n");
+		ret = -ENOMEM;
+		goto err_shm;
+	}
+
+	ctx->complete_work.mbedtee = mbedtee;
+	ctx->complete_work.complete_only = true;
+	INIT_WORK(&ctx->complete_work.work, rpc_routine);
+
+	mbedtee_register_rpc(mbedtee, MBEDTEE_RPC_COMPLETE_REE, mbedtee_rpc_complete);
+	mbedtee_register_rpc(mbedtee, MBEDTEE_RPC_REETIME, mbedtee_ree_time);
+	mbedtee_register_rpc(mbedtee, MBEDTEE_RPC_REEFS, mbedtee_reefs_supp);
+	mbedtee_register_rpc(mbedtee, MBEDTEE_RPC_RPMB, mbedtee_rpmb_supp);
+
+	/*
+	 * Register cpuhp instance BEFORE enabling interrupts so that
+	 * T2R delivery migration is in place before the first IRQ fires.
+	 */
+	mutex_lock(&mbedtee_cpuhp_mutex);
+	if (mbedtee_cpuhp_state < 0) {
+		mbedtee_cpuhp_state =
+			cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+						"tee/mbedtee:rpc-callee",
+						mbedtee_cpu_online,
+						mbedtee_cpu_offline);
+		if (mbedtee_cpuhp_state < 0) {
+			ret = mbedtee_cpuhp_state;
+			mutex_unlock(&mbedtee_cpuhp_mutex);
+			goto err_wq;
+		}
+		cpuhp_state_created = true;
+	}
+
+	ret = cpuhp_state_add_instance(mbedtee_cpuhp_state, &ctx->hp_node);
+	if (!ret) {
+		mbedtee_cpuhp_instances++;
+		ctx->cpuhp_added = true;
+	} else if (cpuhp_state_created) {
+		cpuhp_remove_multi_state(mbedtee_cpuhp_state);
+		mbedtee_cpuhp_state = -EINVAL;
+	}
+	mutex_unlock(&mbedtee_cpuhp_mutex);
+	if (ret != 0)
+		goto err_wq;
+
+	ret = mbedtee->rpc_ops->init(mbedtee, ctx->t2r_ring,
+					mbedtee_rpc_irq_handler);
+	if (ret != 0)
+		goto err_cpuhp;
+
+	/* Signal the TEE that the REE callee is ready to receive. */
+	smp_store_release(&ctx->t2r_ring->callee_ready, true);
+
+	return 0;
+
+err_cpuhp:
+	mutex_lock(&mbedtee_cpuhp_mutex);
+	if (mbedtee_cpuhp_state >= 0 && ctx->cpuhp_added) {
+		cpuhp_state_remove_instance_nocalls(mbedtee_cpuhp_state,
+						    &ctx->hp_node);
+		ctx->cpuhp_added = false;
+		if (mbedtee_cpuhp_instances)
+			mbedtee_cpuhp_instances--;
+		if (!mbedtee_cpuhp_instances) {
+			cpuhp_remove_multi_state(mbedtee_cpuhp_state);
+			mbedtee_cpuhp_state = -EINVAL;
+		}
+	}
+	mutex_unlock(&mbedtee_cpuhp_mutex);
+err_wq:
+	destroy_workqueue(ctx->rpc_wq);
+	ctx->rpc_wq = NULL;
+err_shm:
+	memunmap(ctx->t2r_shm);
+	ctx->t2r_shm = NULL;
+err_ring:
+	memunmap(ctx->t2r_ring);
+	ctx->t2r_ring = NULL;
+	return ret;
+}
+
+void mbedtee_rpc_uninit(struct mbedtee_device *mbedtee)
+{
+	struct mbedtee_t2r_ctx *ctx;
+
+	if (!mbedtee)
+		return;
+
+	ctx = &mbedtee->t2r;
+	/* Stop advertising the REE callee before interrupt teardown. */
+	if (ctx->t2r_ring)
+		WRITE_ONCE(ctx->t2r_ring->callee_ready, false);
+
+	mutex_lock(&mbedtee_cpuhp_mutex);
+	if (mbedtee_cpuhp_state >= 0 && ctx->cpuhp_added) {
+		cpuhp_state_remove_instance_nocalls(mbedtee_cpuhp_state,
+						    &ctx->hp_node);
+		ctx->cpuhp_added = false;
+		if (mbedtee_cpuhp_instances)
+			mbedtee_cpuhp_instances--;
+		if (!mbedtee_cpuhp_instances) {
+			cpuhp_remove_multi_state(mbedtee_cpuhp_state);
+			mbedtee_cpuhp_state = -EINVAL;
+		}
+	}
+	mutex_unlock(&mbedtee_cpuhp_mutex);
+
+	if (mbedtee->rpc_ops)
+		mbedtee->rpc_ops->uninit(mbedtee);
+
+	/*
+	 * Work queued before IRQ teardown may be blocked in the supplicant
+	 * path. Abort those requests and reject later ones before draining the
+	 * workqueue. R2T must stay alive until destroy_workqueue() returns
+	 * because rpc_routine() sends COMPLETE_TEE replies over R2T.
+	 */
+	mbedtee_supp_abort_all(&mbedtee->supp);
+
+	if (ctx->rpc_wq) {
+		destroy_workqueue(ctx->rpc_wq);
+		ctx->rpc_wq = NULL;
+	}
+
+	if (ctx->t2r_shm) {
+		memunmap(ctx->t2r_shm);
+		ctx->t2r_shm = NULL;
+	}
+
+	if (ctx->t2r_ring) {
+		memunmap(ctx->t2r_ring);
+		ctx->t2r_ring = NULL;
+	}
+}
diff --git a/drivers/tee/mbedtee/rpc_callee_arm.c b/drivers/tee/mbedtee/rpc_callee_arm.c
new file mode 100644
index 0000000..871bba5
--- /dev/null
+++ b/drivers/tee/mbedtee/rpc_callee_arm.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ * ARM/ARM64 GIC transport for the TEE->REE RPC callee.
+ *
+ * On ARM/ARM64 the TEE raises a rising-edge software-generated interrupt
+ * described by the "interrupts" property of the mbedtee DT node.  This file
+ * obtains that virq via of_irq_get() and registers the hard IRQ handler
+ * supplied by the core callee layer.
+ */
+#include <linux/interrupt.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+
+#include "mbedtee_drv.h"
+
+static int arm_transport_init(struct mbedtee_device *mbedtee,
+			      struct rpc_ringbuf *ring, irq_handler_t handler)
+{
+	struct mbedtee_t2r_ctx *ctx = &mbedtee->t2r;
+	struct mbedtee_rpc_transport_ctx *tctx = &mbedtee->transport;
+	int ret;
+
+	tctx->rpc_notify_virq = of_irq_get(mbedtee->dev->of_node, 0);
+	if (tctx->rpc_notify_virq <= 0)
+		return tctx->rpc_notify_virq ? tctx->rpc_notify_virq : -ENODEV;
+
+	ret = request_irq(tctx->rpc_notify_virq, handler,
+			  0, "mbedtee-rpc", mbedtee);
+	if (ret) {
+		dev_warn(mbedtee->dev, "request_irq %d failed: %d\n",
+			 tctx->rpc_notify_virq, ret);
+		tctx->rpc_notify_virq = 0;
+		return ret;
+	}
+
+	/*
+	 * Spread the T2R SPI across all online CPUs in Linux.
+	 * The TEE needs no CPU information from Linux: it broadcasts
+	 * via GIC hardware (GICv2 ITARGETS=0xFF / GICv3 IROUTER.IRM=1).
+	 */
+	cpumask_copy(&ctx->callee_cpus, cpu_online_mask);
+	if (irq_set_affinity(tctx->rpc_notify_virq, &ctx->callee_cpus))
+		dev_warn(mbedtee->dev, "irq_set_affinity failed\n");
+
+	dev_dbg(mbedtee->dev, "t2r-irq %d\n", tctx->rpc_notify_virq);
+	return 0;
+}
+
+static void arm_transport_uninit(struct mbedtee_device *mbedtee)
+{
+	struct mbedtee_rpc_transport_ctx *tctx = &mbedtee->transport;
+
+	if (tctx->rpc_notify_virq > 0) {
+		free_irq(tctx->rpc_notify_virq, mbedtee);
+		tctx->rpc_notify_virq = 0;
+	}
+}
+
+/*
+ * ARM T2R uses a GIC SPI: the TEE broadcasts it via GIC hardware
+ * (GICv2 ITARGETS=0xFF or GICv3 IROUTER.IRM=1) to any alive CPU.
+ * TrustZone shares physical CPUs -- no ring update is ever needed.
+ *
+ * @new_cpu is ignored: the IRQ is re-affined to ctx->callee_cpus which
+ * the core callee layer keeps in sync (dying CPU already removed before
+ * this callback is invoked, so the mask is always accurate).
+ */
+static int arm_update_affinity(struct mbedtee_device *mbedtee,
+			       unsigned int new_cpu)
+{
+	struct mbedtee_rpc_transport_ctx *tctx = &mbedtee->transport;
+
+	if (tctx->rpc_notify_virq > 0 &&
+	    irq_set_affinity(tctx->rpc_notify_virq, &mbedtee->t2r.callee_cpus))
+		dev_warn(mbedtee->dev, "irq_set_affinity failed\n");
+
+	return 0;
+}
+
+static const struct rpc_transport_ops arm_transport_ops = {
+	.init            = arm_transport_init,
+	.uninit          = arm_transport_uninit,
+	.update_affinity = arm_update_affinity,
+};
+
+const struct rpc_transport_ops *mbedtee_get_rpc_transport_ops(void)
+{
+	return &arm_transport_ops;
+}
diff --git a/drivers/tee/mbedtee/rpc_callee_riscv.c b/drivers/tee/mbedtee/rpc_callee_riscv.c
new file mode 100644
index 0000000..7ac0f8e
--- /dev/null
+++ b/drivers/tee/mbedtee/rpc_callee_riscv.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Xing Loong <xing.xl.loong@gmail.com>
+ * RISC-V MSI transport for the TEE->REE RPC callee.
+ *
+ * On RISC-V the TEE wakes the REE by writing a Message Signalled Interrupt
+ * into the target hart's IMSIC (Incoming MSI Controller).  This file allocates
+ * one platform MSI from the DT-provided MSI parent and registers the hard IRQ
+ * handler supplied by the core callee layer.
+ *
+ * CPU hotplug: the common mbedtee_cpu_offline() callback in rpc_callee.c
+ * detects when the callee CPU goes offline and calls riscv_update_affinity()
+ * to migrate the MSI to another online CPU.
+ */
+#include <linux/interrupt.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/smp.h>
+
+#include "mbedtee_drv.h"
+
+static int mbedtee_ring_set_hartid(struct mbedtee_device *mbedtee,
+				   struct rpc_ringbuf *ring,
+				   unsigned int cpu)
+{
+	long hartid = cpuid_to_hartid_map(cpu);
+
+	if (hartid < 0) {
+		dev_err(mbedtee->dev, "CPU%u has no valid hart-id\n", cpu);
+		return -ERANGE;
+	}
+
+	WRITE_ONCE(ring->callee_hartid, (u32)hartid);
+	return 0;
+}
+
+static void mbedtee_rpc_write_msi_msg(struct msi_desc *desc_msi,
+				      struct msi_msg *msg)
+{
+	struct mbedtee_device *mbedtee = dev_get_drvdata(desc_msi->dev);
+
+	if (mbedtee)
+		mbedtee->transport.rpc_msi_msg = *msg;
+}
+
+static int riscv_transport_init(struct mbedtee_device *mbedtee,
+				struct rpc_ringbuf *ring, irq_handler_t handler)
+{
+	struct mbedtee_t2r_ctx *ctx = &mbedtee->t2r;
+	const struct cpumask *eff;
+	struct mbedtee_rpc_transport_ctx *tctx = &mbedtee->transport;
+	unsigned int cpu;
+	struct device *dev = mbedtee->dev;
+	int virq;
+	int ret;
+
+	/*
+	 * Set a bootstrap callee_hartid (hart 0) so the TEE can poll
+	 * even if MSI setup fails below.
+	 */
+	ret = mbedtee_ring_set_hartid(mbedtee, ring, 0);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, mbedtee);
+
+	/*
+	 * The MSI domain of an OF device is resolved only once, when the
+	 * platform device is created (of_msi_configure() in of/platform.c).
+	 * mbedtee's MSI parent is the IMSIC, whose MSI domain is created
+	 * later, when the IMSIC builtin_platform_driver probes -- typically
+	 * after this device has already been created with a NULL msi.domain.
+	 *
+	 * Deferred probing alone cannot recover from this: the driver core
+	 * re-runs probe() but never re-runs of_msi_configure(), so the stale
+	 * NULL domain would persist across every retry.  Re-resolve it here
+	 * and defer until the IMSIC driver is up.  This mirrors the RISC-V
+	 * APLIC/IOMMU platform-MSI drivers.
+	 */
+	if (!dev_get_msi_domain(dev)) {
+		of_msi_configure(dev, dev->of_node);
+
+		if (!dev_get_msi_domain(dev))
+			return -EPROBE_DEFER;
+	}
+
+	ret = platform_device_msi_init_and_alloc_irqs(dev, 1,
+						      mbedtee_rpc_write_msi_msg);
+	if (ret) {
+		dev_err(mbedtee->dev, "MSI alloc failed: %d\n", ret);
+		return ret;
+	}
+
+	virq = msi_get_virq(dev, 0);
+	if (virq <= 0) {
+		dev_err(mbedtee->dev, "no MSI virq\n");
+		ret = -ENOENT;
+		goto err_msi;
+	}
+
+	ret = request_irq(virq, handler, 0, "mbedtee-rpc", mbedtee);
+	if (ret) {
+		dev_err(mbedtee->dev, "request_irq %d failed: %d\n", virq, ret);
+		goto err_msi;
+	}
+
+	eff = irq_get_effective_affinity_mask(virq);
+	cpu = eff ? cpumask_first(eff) : 0;
+
+	dev_dbg(mbedtee->dev, "MSI addr 0x%x%08x data %d virq %d hart %ld\n",
+		tctx->rpc_msi_msg.address_hi, tctx->rpc_msi_msg.address_lo,
+		tctx->rpc_msi_msg.data, virq, cpuid_to_hartid_map(cpu));
+
+	/* Inform TEE of the IMSIC identity used for T2R notifications. */
+	ret = mbedtee_ring_set_hartid(mbedtee, ring, cpu);
+	if (ret)
+		goto err_irq;
+	/* Ensure callee_hartid is visible before advertising MSI interrupt ID. */
+	smp_store_release(&ring->callee_imsic_id, tctx->rpc_msi_msg.data);
+
+	/* Track the active callee CPU for hotplug migration. */
+	ctx->callee_virq = virq;
+	cpumask_set_cpu(cpu, &ctx->callee_cpus);
+
+	return 0;
+
+err_irq:
+	free_irq(virq, mbedtee);
+
+err_msi:
+	platform_device_msi_free_irqs_all(dev);
+	return ret;
+}
+
+static void riscv_transport_uninit(struct mbedtee_device *mbedtee)
+{
+	struct mbedtee_t2r_ctx *ctx = &mbedtee->t2r;
+	int virq;
+
+	virq = ctx->callee_virq;
+	ctx->callee_virq = 0;
+	if (virq > 0)
+		free_irq(virq, mbedtee);
+
+	platform_device_msi_free_irqs_all(mbedtee->dev);
+}
+
+/*
+ * Migrate the IMSIC MSI delivery to @new_cpu.
+ *
+ * Ordering guarantee for the TEE reader:
+ *   1. Clear callee_imsic_id to 0 -- TEE skips IMSIC path while we migrate.
+ *   2. Call irq_set_affinity() -- triggers mbedtee_rpc_write_msi_msg() which
+ *      updates tctx->rpc_msi_msg with the new IMSIC identity.
+ *   3. Update callee_hartid (WRITE_ONCE inside mbedtee_ring_set_hartid());
+ *      no explicit barrier needed here since the release store on
+ *      callee_imsic_id in step 4 provides the ordering.
+ *   4. Publish new callee_imsic_id with smp_store_release -- TEE's
+ *      smp_load_acquire on callee_imsic_id pairs with this store.
+ */
+static int riscv_update_affinity(struct mbedtee_device *mbedtee,
+				 unsigned int new_cpu)
+{
+	struct mbedtee_t2r_ctx *ctx = &mbedtee->t2r;
+	struct mbedtee_rpc_transport_ctx *tctx = &mbedtee->transport;
+	struct rpc_ringbuf *ring = ctx->t2r_ring;
+	int virq = ctx->callee_virq;
+
+	if (!virq)
+		return -ENODEV;
+
+	/* Step 1: prevent TEE from using the stale IMSIC identity. */
+	smp_store_release(&ring->callee_imsic_id, 0);
+
+	/* Step 2: retarget the MSI; write_msi_msg callback updates rpc_msi_msg. */
+	if (irq_set_affinity(virq, cpumask_of(new_cpu))) {
+		dev_warn(mbedtee->dev, "irq_set_affinity to CPU%u failed\n",
+			 new_cpu);
+		return -EIO;
+	}
+
+	/* Step 3: update callee_hartid. */
+	if (mbedtee_ring_set_hartid(mbedtee, ring, new_cpu))
+		return -ERANGE;
+
+	/* Step 4: publish new IMSIC id with release barrier. */
+	smp_store_release(&ring->callee_imsic_id, tctx->rpc_msi_msg.data);
+
+	dev_dbg(mbedtee->dev, "T2R callee migrated to CPU%u (hart %ld)\n",
+		new_cpu, cpuid_to_hartid_map(new_cpu));
+	return 0;
+}
+
+static const struct rpc_transport_ops riscv_transport_ops = {
+	.init            = riscv_transport_init,
+	.uninit          = riscv_transport_uninit,
+	.update_affinity = riscv_update_affinity,
+};
+
+const struct rpc_transport_ops *mbedtee_get_rpc_transport_ops(void)
+{
+	return &riscv_transport_ops;
+}
diff --git a/drivers/tee/mbedtee/rpc_caller.c b/drivers/tee/mbedtee/rpc_caller.c
new file mode 100644
index 0000000..1ae55db
--- /dev/null
+++ b/drivers/tee/mbedtee/rpc_caller.c
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ * REE->TEE session management and yield-call interface.
+ */
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include "mbedtee_drv.h"
+
+#define MBEDTEE_RPC_CALL_ACTIVE			0
+#define MBEDTEE_RPC_CALL_DONE			1
+#define MBEDTEE_RPC_CALL_INTERRUPTED	2
+
+int mbedtee_rpc_call_alloc(struct mbedtee_device *mbedtee,
+			   size_t payload_size, struct mbedtee_rpc_call **call)
+{
+	struct mbedtee_rpc_call *rcall;
+	unsigned long rpc_index;
+	int ret;
+
+	if (sizeof(*rcall) + payload_size > PAGE_SIZE)
+		return -E2BIG;
+
+	rcall = kzalloc(sizeof(*rcall) + payload_size, GFP_KERNEL);
+	if (!rcall)
+		return -ENOMEM;
+
+	init_completion(&rcall->c);
+	rcall->state = MBEDTEE_RPC_CALL_ACTIVE;
+	rcall->rpc.size = payload_size;
+	rcall->rpc.ret = -EOPNOTSUPP;
+	rcall->rpc_phys = mbedtee_virt_to_phys(&rcall->rpc);
+
+	do {
+		rpc_index = atomic_long_inc_return(&mbedtee->rpc_call_seq);
+	} while (rpc_index == 0);
+
+	ret = xa_insert_irq(&mbedtee->rpc_calls, rpc_index, rcall, GFP_KERNEL);
+	if (ret != 0) {
+		kfree(rcall);
+		return ret;
+	}
+
+	rcall->rpc.waiter_id = rpc_index;
+	*call = rcall;
+
+	return 0;
+}
+
+void mbedtee_rpc_call_free(struct mbedtee_device *mbedtee,
+			   struct mbedtee_rpc_call *call)
+{
+	unsigned long rpc_index;
+
+	if (!call)
+		return;
+
+	rpc_index = (unsigned long)call->rpc.waiter_id;
+
+	/*
+	 * If interrupted/completed, complete_call owns this allocation
+	 * and will xa_erase + kfree when the TEE eventually finishes.
+	 */
+	if (READ_ONCE(call->state) == MBEDTEE_RPC_CALL_INTERRUPTED)
+		return;
+
+	xa_erase_irq(&mbedtee->rpc_calls, rpc_index);
+	kfree(call);
+}
+
+void mbedtee_rpc_complete_call(struct mbedtee_device *mbedtee,
+			       u64 waiter_id)
+{
+	struct mbedtee_rpc_call *call;
+	unsigned long rpc_index;
+	unsigned long flags;
+	unsigned int state;
+
+	rpc_index = (unsigned long)waiter_id;
+	if ((u64)rpc_index != waiter_id)
+		return;
+
+	xa_lock_irqsave(&mbedtee->rpc_calls, flags);
+	call = xa_load(&mbedtee->rpc_calls, rpc_index);
+	if (!call) {
+		xa_unlock_irqrestore(&mbedtee->rpc_calls, flags);
+		return;
+	}
+
+	state = cmpxchg(&call->state, MBEDTEE_RPC_CALL_ACTIVE,
+			MBEDTEE_RPC_CALL_DONE);
+	__xa_erase(&mbedtee->rpc_calls, rpc_index);
+
+	if (state == MBEDTEE_RPC_CALL_INTERRUPTED) {
+		xa_unlock_irqrestore(&mbedtee->rpc_calls, flags);
+		kfree(call);
+		return;
+	}
+
+	complete(&call->c);
+	xa_unlock_irqrestore(&mbedtee->rpc_calls, flags);
+}
+
+long mbedtee_rpc_wait_for_completion(struct mbedtee_device *mbedtee,
+				     struct mbedtee_rpc_call *call, bool killable)
+{
+	long ret;
+	unsigned int state;
+	unsigned long flags;
+	unsigned long rpc_index;
+
+	if (!killable) {
+		wait_for_completion(&call->c);
+		return 0;
+	}
+
+	rpc_index = (unsigned long)call->rpc.waiter_id;
+
+	ret = wait_for_completion_killable(&call->c);
+	if (ret == 0)
+		return 0;
+
+	/*
+	 * Synchronize with mbedtee_rpc_complete_call() via the
+	 * xa_lock. If complete_call already consumed this entry
+	 * before we acquired the lock, the entry is already gone
+	 * from the xarray and the TEE already completed (or freed)
+	 * the call -- treat as success since the RPC is finished.
+	 * If the entry is still present, we hold the lock so
+	 * complete_call cannot race with our state transition.
+	 */
+	xa_lock_irqsave(&mbedtee->rpc_calls, flags);
+	if (xa_load(&mbedtee->rpc_calls, rpc_index) != call) {
+		xa_unlock_irqrestore(&mbedtee->rpc_calls, flags);
+		return 0;
+	}
+
+	state = cmpxchg(&call->state, MBEDTEE_RPC_CALL_ACTIVE,
+			MBEDTEE_RPC_CALL_INTERRUPTED);
+	if (state == MBEDTEE_RPC_CALL_DONE) {
+		xa_unlock_irqrestore(&mbedtee->rpc_calls, flags);
+		return 0;
+	}
+
+	if (state == MBEDTEE_RPC_CALL_ACTIVE)
+		/* Publish interruption state before the TEE waiter reads it. */
+		smp_store_release(&call->rpc.interrupted, true);
+
+	xa_unlock_irqrestore(&mbedtee->rpc_calls, flags);
+	return ret;
+}
+
+/* Local helpers for encoding/decoding the 4-bit-per-parameter type field. */
+static inline u32 mbedtee_param_type_get(u32 types, unsigned int idx)
+{
+	return (types >> (idx * 4)) & 0xF;
+}
+
+static inline u32 mbedtee_param_type_set(u32 type, unsigned int idx)
+{
+	return (type & 0xF) << (idx * 4);
+}
+
+static int mbedtee_param_decode(struct tee_param *params,
+				size_t num_params, const struct rpc_param *rp)
+{
+	size_t n;
+
+	if (num_params > ARRAY_SIZE(rp->params))
+		return -EINVAL;
+
+	for (n = 0; n < num_params; n++) {
+		struct tee_param *p = params + n;
+		const union rpc_tee_param *rtp = rp->params + n;
+		u32 attr = mbedtee_param_type_get(rp->params_type, n);
+
+		switch (attr) {
+		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
+			memset(&p->u, 0, sizeof(p->u));
+			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
+			p->u.value.a = rtp->value.a;
+			p->u.value.b = rtp->value.b;
+			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
+			p->u.memref.size = rtp->memref.size;
+			break;
+		default:
+			return -EINVAL;
+		}
+		p->attr = attr;
+	}
+	return 0;
+}
+
+static int mbedtee_param_encode(struct rpc_param *rp,
+				size_t num_params, const struct tee_param *params)
+{
+	size_t n;
+
+	if (num_params > ARRAY_SIZE(rp->params))
+		return -EINVAL;
+
+	rp->params_type = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
+
+	for (n = 0; n < num_params; n++) {
+		const struct tee_param *p = params + n;
+		union rpc_tee_param *rtp = rp->params + n;
+
+		rp->params_type |= mbedtee_param_type_set(p->attr, n);
+
+		switch (p->attr) {
+		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
+			memset(rtp, 0, sizeof(*rtp));
+			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
+			rtp->value.a = p->u.value.a;
+			rtp->value.b = p->u.value.b;
+			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
+			if (p->u.memref.shm)
+				rtp->memref.id = p->u.memref.shm->sec_world_id;
+			else
+				rtp->memref.id = 0; /* invalid-id @ mbedtee */
+			rtp->memref.size = p->u.memref.size;
+			rtp->memref.offset = p->u.memref.shm_offs;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * cancel_req() and shm_{register,unregister} still return Linux errno to the
+ * kernel TEE core. Preserve any local transport failure in @ret; otherwise
+ * fold a non-success TEE-side GP status into the generic -EIO expected by
+ * these internal-only hooks.
+ */
+static int mbedtee_rpc_gp_ret_to_errno(int ret, s32 gp_ret)
+{
+	if (ret)
+		return ret;
+
+	return gp_ret == TEEC_SUCCESS ? 0 : -EIO;
+}
+
+static struct mbedtee_session *
+mbedtee_find_session_locked(struct mbedtee_context_data *ctxdata,
+			    u32 session_id)
+{
+	struct mbedtee_session *sess;
+
+	list_for_each_entry(sess, &ctxdata->sess_list, list_node)
+		if (sess->session_id == session_id)
+			return sess;
+
+	return NULL;
+}
+
+int mbedtee_open_session(struct tee_context *ctx,
+			 struct tee_ioctl_open_session_arg *arg,
+			 struct tee_param *param)
+{
+	int ret;
+	u32 session_id = 0;
+	struct mbedtee_context_data *ctxdata = ctx->data;
+	struct mbedtee_device *mbedtee = tee_get_drvdata(ctx->teedev);
+	struct mbedtee_rpc_call *call;
+	struct rpc_param *rp;
+	struct mbedtee_session *sess;
+
+	sess = kzalloc_obj(*sess, GFP_KERNEL);
+	if (!sess)
+		return -ENOMEM;
+
+	ret = mbedtee_rpc_call_alloc(mbedtee, sizeof(*rp), &call);
+	if (ret != 0) {
+		kfree(sess);
+		return ret;
+	}
+
+	rp = (struct rpc_param *)call->rpc.data;
+
+	ret = mbedtee_param_encode(rp, arg->num_params, param);
+	if (ret) {
+		kfree(sess);
+		mbedtee_rpc_call_free(mbedtee, call);
+		return ret;
+	}
+
+	memcpy(rp->uuid, arg->uuid, sizeof(arg->uuid));
+	memcpy(rp->clnt_uuid, arg->clnt_uuid, sizeof(arg->clnt_uuid));
+	rp->ret_origin = TEEC_ORIGIN_COMMS;
+
+	ret = mbedtee_rpc_yieldcall(mbedtee, MBEDTEE_RPC_OPEN_SESSION, call, false);
+
+	dev_dbg(mbedtee->dev, "open session ret %d gp_ret %d\n", ret,
+		call->rpc.ret);
+
+	if (ret == 0 && call->rpc.ret == TEEC_SUCCESS) {
+		session_id = rp->session_id;
+		sess->session_id = session_id;
+		mutex_lock(&ctxdata->mutex);
+		list_add(&sess->list_node, &ctxdata->sess_list);
+		mutex_unlock(&ctxdata->mutex);
+	} else {
+		kfree(sess);
+	}
+
+	if (ret != 0) {
+		arg->ret = TEEC_ERROR_COMMUNICATION;
+		arg->ret_origin = TEEC_ORIGIN_COMMS;
+	} else if (mbedtee_param_decode(param, arg->num_params, rp)) {
+		arg->ret = TEEC_ERROR_COMMUNICATION;
+		arg->ret_origin = TEEC_ORIGIN_COMMS;
+		if (call->rpc.ret == TEEC_SUCCESS)
+			mbedtee_close_session(ctx, session_id);
+	} else {
+		arg->session = rp->session_id;
+		arg->ret = (u32)call->rpc.ret;
+		arg->ret_origin = rp->ret_origin;
+	}
+
+	mbedtee_rpc_call_free(mbedtee, call);
+	return 0;
+}
+
+int mbedtee_invoke_func(struct tee_context *ctx,
+			struct tee_ioctl_invoke_arg *arg,
+			struct tee_param *param)
+{
+	int ret;
+	struct mbedtee_context_data *ctxdata = ctx->data;
+	struct mbedtee_device *mbedtee = tee_get_drvdata(ctx->teedev);
+	struct mbedtee_rpc_call *call;
+	struct rpc_param *rp;
+	struct mbedtee_session *sess;
+
+	mutex_lock(&ctxdata->mutex);
+	sess = mbedtee_find_session_locked(ctxdata, arg->session);
+	mutex_unlock(&ctxdata->mutex);
+	if (!sess)
+		return -EINVAL;
+
+	ret = mbedtee_rpc_call_alloc(mbedtee, sizeof(*rp), &call);
+	if (ret != 0)
+		return ret;
+
+	rp = (struct rpc_param *)call->rpc.data;
+
+	rp->session_id = arg->session;
+	rp->cmd_id = arg->func;
+	rp->ret_origin = TEEC_ORIGIN_COMMS;
+
+	ret = mbedtee_param_encode(rp, arg->num_params, param);
+	if (ret) {
+		mbedtee_rpc_call_free(mbedtee, call);
+		return ret;
+	}
+
+	ret = mbedtee_rpc_yieldcall(mbedtee, MBEDTEE_RPC_INVOKE_SESSION, call, true);
+
+	dev_dbg(mbedtee->dev, "invoke session ret %d gp_ret %d\n", ret,
+		call->rpc.ret);
+
+	if (ret != 0) {
+		arg->ret = TEEC_ERROR_COMMUNICATION;
+		arg->ret_origin = TEEC_ORIGIN_COMMS;
+	} else if (mbedtee_param_decode(param, arg->num_params, rp)) {
+		arg->ret = TEEC_ERROR_COMMUNICATION;
+		arg->ret_origin = TEEC_ORIGIN_COMMS;
+	} else {
+		arg->ret = (u32)call->rpc.ret;
+		arg->ret_origin = rp->ret_origin;
+	}
+
+	mbedtee_rpc_call_free(mbedtee, call);
+	return 0;
+}
+
+int mbedtee_close_session(struct tee_context *ctx, u32 session)
+{
+	int ret;
+	struct mbedtee_context_data *ctxdata = ctx->data;
+	struct mbedtee_device *mbedtee = tee_get_drvdata(ctx->teedev);
+	struct mbedtee_rpc_call *call;
+	struct rpc_param *rp;
+	struct mbedtee_session *sess;
+
+	mutex_lock(&ctxdata->mutex);
+	sess = mbedtee_find_session_locked(ctxdata, session);
+	if (!sess) {
+		mutex_unlock(&ctxdata->mutex);
+		return -EINVAL;
+	}
+
+	list_del(&sess->list_node);
+	mutex_unlock(&ctxdata->mutex);
+	kfree(sess);
+
+	ret = mbedtee_rpc_call_alloc(mbedtee, sizeof(*rp), &call);
+	if (ret != 0)
+		return ret;
+
+	rp = (struct rpc_param *)call->rpc.data;
+	rp->session_id = session;
+
+	ret = mbedtee_rpc_yieldcall(mbedtee, MBEDTEE_RPC_CLOSE_SESSION, call, false);
+
+	mbedtee_rpc_call_free(mbedtee, call);
+
+	return ret;
+}
+
+int mbedtee_cancel_req(struct tee_context *ctx,
+		       u32 cancel_id, u32 session)
+{
+	int ret;
+	struct mbedtee_context_data *ctxdata = ctx->data;
+	struct mbedtee_device *mbedtee = tee_get_drvdata(ctx->teedev);
+	struct mbedtee_rpc_call *call;
+	struct rpc_cancel_req *cancel;
+	struct mbedtee_session *sess;
+
+	mutex_lock(&ctxdata->mutex);
+	sess = mbedtee_find_session_locked(ctxdata, session);
+	mutex_unlock(&ctxdata->mutex);
+	if (!sess)
+		return -EINVAL;
+
+	ret = mbedtee_rpc_call_alloc(mbedtee, sizeof(*cancel), &call);
+	if (ret != 0)
+		return ret;
+
+	cancel = (struct rpc_cancel_req *)call->rpc.data;
+	cancel->session_id = session;
+	cancel->cancel_id = cancel_id;
+
+	ret = mbedtee_rpc_yieldcall(mbedtee, MBEDTEE_RPC_CANCEL, call, false);
+	ret = mbedtee_rpc_gp_ret_to_errno(ret, call->rpc.ret);
+
+	mbedtee_rpc_call_free(mbedtee, call);
+
+	return ret;
+}
+
+int mbedtee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
+			 struct page **pages, size_t nr_pages, unsigned long start)
+{
+	int ret;
+	size_t i, j;
+	u64 *pagearray;
+	struct mbedtee_device *mbedtee = tee_get_drvdata(ctx->teedev);
+	struct mbedtee_rpc_call *call;
+	struct rpc_memref *memref;
+	/* Multiple: number of MBEDTEE_PAGE_SIZE pages per Linux page. */
+	const size_t multiple = PAGE_SIZE / MBEDTEE_PAGE_SIZE;
+
+	BUILD_BUG_ON(PAGE_SIZE < MBEDTEE_PAGE_SIZE);
+
+	ret = mbedtee_rpc_call_alloc(mbedtee, sizeof(*memref), &call);
+	if (ret != 0)
+		return ret;
+
+	memref = (struct rpc_memref *)call->rpc.data;
+
+	pagearray = kcalloc(nr_pages * multiple, sizeof(*pagearray), GFP_KERNEL);
+	if (!pagearray) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		for (j = 0; j < multiple; j++)
+			pagearray[i * multiple + j] = MBEDTEE_PAGE_SIZE * j +
+				page_to_phys(pages[i]);
+	}
+
+	memref->size = tee_shm_get_size(shm);
+	memref->offset = tee_shm_get_page_offset(shm);
+	memref->pages = mbedtee_virt_to_phys(pagearray);
+	memref->cnt = nr_pages * multiple;
+	ret = mbedtee_rpc_yieldcall(mbedtee, MBEDTEE_RPC_REGISTER_SHM, call, false);
+	ret = mbedtee_rpc_gp_ret_to_errno(ret, call->rpc.ret);
+
+	if (ret == 0)
+		shm->sec_world_id = memref->id;
+
+	kfree(pagearray);
+
+out:
+	mbedtee_rpc_call_free(mbedtee, call);
+	return ret;
+}
+
+int mbedtee_shm_unregister(struct tee_context *ctx,
+			   struct tee_shm *shm)
+{
+	int ret;
+	struct mbedtee_device *mbedtee = tee_get_drvdata(ctx->teedev);
+	struct mbedtee_rpc_call *call;
+	struct rpc_memref *memref;
+
+	ret = mbedtee_rpc_call_alloc(mbedtee, sizeof(*memref), &call);
+	if (ret != 0)
+		return ret;
+
+	memref = (struct rpc_memref *)call->rpc.data;
+	memref->id = shm->sec_world_id;
+
+	ret = mbedtee_rpc_yieldcall(mbedtee, MBEDTEE_RPC_UNREGISTER_SHM, call, false);
+	ret = mbedtee_rpc_gp_ret_to_errno(ret, call->rpc.ret);
+
+	mbedtee_rpc_call_free(mbedtee, call);
+
+	return ret;
+}
diff --git a/drivers/tee/mbedtee/rpc_caller_arm.c b/drivers/tee/mbedtee/rpc_caller_arm.c
new file mode 100644
index 0000000..1dd665a
--- /dev/null
+++ b/drivers/tee/mbedtee/rpc_caller_arm.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ * ARM RPC calls to TEE - relies on SMC
+ *
+ * Uses arm_smccc_smc() with SMCCC-compatible calling convention:
+ *   Fast call  : r0/x0 = fn (bit 31 set), r1-r3/x1-x3 = args.
+ *   Yield call : r0/x0 = fn (bit 31 clear), r1/x1 = phys(rpc_cmd).
+ *
+ * ARM fast calls are synchronous SMC instructions.
+ */
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/arm-smccc.h>
+#include "mbedtee_drv.h"
+
+long mbedtee_rpc_yieldcall(struct mbedtee_device *mbedtee,
+			   unsigned long fn, struct mbedtee_rpc_call *call,
+			   bool interruptible)
+{
+	long ret;
+	struct arm_smccc_res res;
+
+	if (MBEDTEE_RPC_IS_FASTCALL(fn))
+		return -EINVAL;
+
+	call->rpc.id = fn;
+
+	arm_smccc_smc(fn, call->rpc_phys,
+		      0, 0, 0, 0, 0, 0, &res);
+	ret = res.a0;
+	if (ret != 0)
+		return ret;
+
+	return mbedtee_rpc_wait_for_completion(mbedtee, call, interruptible);
+}
+
+long mbedtee_rpc_fastcall(struct mbedtee_device *mbedtee,
+			  unsigned long fn, unsigned long a0,
+			  unsigned long a1, unsigned long a2)
+{
+	struct arm_smccc_res res;
+
+	if (!MBEDTEE_RPC_IS_FASTCALL(fn))
+		return -EINVAL;
+
+	arm_smccc_smc(fn, a0, a1, a2, 0, 0, 0, 0, &res);
+
+	return (long)res.a0;
+}
+
+/*
+ * ARM uses direct SMC; no caller-side ring buffer initialisation needed.
+ */
+int mbedtee_r2t_init(struct mbedtee_device *mbedtee)
+{
+	return 0;
+}
+
+void mbedtee_r2t_uninit(struct mbedtee_device *mbedtee)
+{
+}
diff --git a/drivers/tee/mbedtee/rpc_caller_riscv.c b/drivers/tee/mbedtee/rpc_caller_riscv.c
new file mode 100644
index 0000000..387d9bb
--- /dev/null
+++ b/drivers/tee/mbedtee/rpc_caller_riscv.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Xing Loong <xing.xl.loong@gmail.com>
+ * REE->TEE RPC calls for RISC-V (IMSIC)
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/sizes.h>
+
+#include "mbedtee_drv.h"
+
+static bool rpc_ring_enough(struct mbedtee_r2t_ctx *ctx, size_t size)
+{
+	u32 wr;
+	u32 rd;
+	u32 remain;
+
+	wr = READ_ONCE(ctx->ring_wr);
+	/* Pair with callee release store when publishing ring->rd */
+	rd = smp_load_acquire(&ctx->ring->rd);
+
+	if (rd > ctx->ring_sz || wr > ctx->ring_sz)
+		return false;
+
+	if (rd <= wr)
+		remain = ctx->ring_sz + rd - wr;
+	else
+		remain = rd - wr;
+
+	return remain > size;
+}
+
+static void rpc_ring_write(struct mbedtee_r2t_ctx *ctx,
+			   void *data, size_t size)
+{
+	struct rpc_ringbuf *shm = ctx->ring;
+	u32 remain;
+	u32 wr = READ_ONCE(ctx->ring_wr);
+
+	if (wr + size > ctx->ring_sz) {
+		remain = wr + size - ctx->ring_sz;
+		memcpy(&shm->mem[wr], data, size - remain);
+		memcpy(&shm->mem[0], (char *)data + size - remain, remain);
+		wr = remain;
+	} else {
+		memcpy(&shm->mem[wr], data, size);
+		wr += size;
+	}
+
+	WRITE_ONCE(ctx->ring_wr, wr);
+	/* Publish writer index after payload bytes become visible. */
+	smp_store_release(&shm->wr, wr);
+}
+
+long mbedtee_rpc_yieldcall(struct mbedtee_device *mbedtee,
+			   unsigned long fn, struct mbedtee_rpc_call *call,
+			   bool interruptible)
+{
+	struct mbedtee_r2t_ctx *ctx = &mbedtee->r2t;
+	unsigned long flags;
+	u64 phys;
+
+	if (!ctx->ring)
+		return -ENXIO;
+
+	if (MBEDTEE_RPC_IS_FASTCALL(fn))
+		return -EINVAL;
+
+	call->rpc.id = fn;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+	if (!rpc_ring_enough(ctx, sizeof(u64))) {
+		dev_err_ratelimited(mbedtee->dev, "rpc ring full\n");
+		spin_unlock_irqrestore(&ctx->lock, flags);
+		return -ENOSPC;
+	}
+
+	phys = call->rpc_phys;
+	rpc_ring_write(ctx, &phys, sizeof(phys));
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	return mbedtee_rpc_wait_for_completion(mbedtee, call, interruptible);
+}
+
+long mbedtee_rpc_fastcall(struct mbedtee_device *mbedtee,
+			  unsigned long fn, unsigned long a0,
+			  unsigned long a1, unsigned long a2)
+{
+	struct mbedtee_r2t_ctx *ctx = &mbedtee->r2t;
+	struct mbedtee_rpc_call *call;
+	unsigned long flags;
+	u64 phys;
+	int ret;
+
+	if (!ctx->ring)
+		return -ENXIO;
+
+	if (!MBEDTEE_RPC_IS_FASTCALL(fn))
+		return -EINVAL;
+
+	ret = mbedtee_rpc_call_alloc(mbedtee, 3 * sizeof(u64), &call);
+	if (ret != 0)
+		return ret;
+
+	call->rpc.id = fn;
+	call->rpc.size = 3 * sizeof(u64);
+	call->rpc.data[0] = a0;
+	call->rpc.data[1] = a1;
+	call->rpc.data[2] = a2;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+	if (!rpc_ring_enough(ctx, sizeof(u64))) {
+		dev_err_ratelimited(mbedtee->dev, "rpc ring full\n");
+		spin_unlock_irqrestore(&ctx->lock, flags);
+		mbedtee_rpc_call_free(mbedtee, call);
+		return -ENOSPC;
+	}
+
+	phys = call->rpc_phys;
+	rpc_ring_write(ctx, &phys, sizeof(phys));
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	ret = mbedtee_rpc_wait_for_completion(mbedtee, call, true);
+	if (ret != 0) {
+		mbedtee_rpc_call_free(mbedtee, call);
+		return ret;
+	}
+
+	ret = call->rpc.ret;
+	mbedtee_rpc_call_free(mbedtee, call);
+
+	return ret;
+}
+
+int mbedtee_r2t_init(struct mbedtee_device *mbedtee)
+{
+	struct mbedtee_r2t_ctx *ctx = &mbedtee->r2t;
+	struct device_node *node = mbedtee->dev->of_node;
+	struct resource res;
+	int ret;
+
+	memset(ctx, 0, sizeof(*ctx));
+	spin_lock_init(&ctx->lock);
+
+	ret = mbedtee_get_resource(node, "r2t-ring", &res);
+	if (ret)
+		return ret;
+
+	if (resource_size(&res) <= sizeof(struct rpc_ringbuf)) {
+		dev_err(mbedtee->dev, "r2t-ring too small\n");
+		return -EINVAL;
+	}
+
+	ctx->ring = memremap(res.start, resource_size(&res),
+			     MEMREMAP_WB);
+	if (!ctx->ring) {
+		dev_err(mbedtee->dev, "failed to map r2t ring at %pa\n",
+			&res.start);
+		return -ENOMEM;
+	}
+	ctx->ring_sz = resource_size(&res) - sizeof(struct rpc_ringbuf);
+	/* Read initial writer index with acquire for coherent ring bootstrap. */
+	WRITE_ONCE(ctx->ring_wr, smp_load_acquire(&ctx->ring->wr));
+
+	dev_dbg(mbedtee->dev, "r2t-ring %pa\n", &res.start);
+
+	return 0;
+}
+
+void mbedtee_r2t_uninit(struct mbedtee_device *mbedtee)
+{
+	struct mbedtee_r2t_ctx *ctx;
+
+	if (!mbedtee)
+		return;
+
+	ctx = &mbedtee->r2t;
+	if (ctx->ring) {
+		memunmap(ctx->ring);
+		ctx->ring = NULL;
+		ctx->ring_sz = 0;
+		ctx->ring_wr = 0;
+	}
+}
diff --git a/drivers/tee/mbedtee/shm_pool.c b/drivers/tee/mbedtee/shm_pool.c
new file mode 100644
index 0000000..708ab24
--- /dev/null
+++ b/drivers/tee/mbedtee/shm_pool.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015, Linaro Limited
+ * Copyright (c) 2017, EPAM Systems
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ */
+#include <linux/device.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+
+#include "mbedtee_drv.h"
+
+static int pool_op_alloc(struct tee_shm_pool *pool,
+			 struct tee_shm *shm, size_t size, size_t align)
+{
+	unsigned int order = get_order(size);
+	struct page *page;
+	int rc = 0;
+
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!page)
+		return -ENOMEM;
+
+	shm->kaddr = page_address(page);
+	shm->paddr = page_to_phys(page);
+	shm->size = PAGE_SIZE << order;
+
+	if (!(shm->flags & TEE_SHM_PRIV)) {
+		struct mbedtee_device *mbedtee = tee_get_drvdata(shm->ctx->teedev);
+
+		if (mbedtee->yield) {
+			unsigned int nr_pages = 1 << order;
+			unsigned int i;
+			struct page **pages;
+
+			pages = kmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
+			if (!pages) {
+				rc = -ENOMEM;
+				goto err_pages;
+			}
+
+			for (i = 0; i < nr_pages; i++)
+				pages[i] = page + i;
+
+			rc = mbedtee_shm_register(shm->ctx, shm, pages,
+						  nr_pages,
+						  (unsigned long)shm->kaddr);
+			kfree(pages);
+			if (rc)
+				goto err_pages;
+		}
+	}
+
+	return 0;
+
+err_pages:
+	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	shm->kaddr = NULL;
+	return rc;
+}
+
+static void pool_op_free(struct tee_shm_pool *pool,
+			 struct tee_shm *shm)
+{
+	if (!(shm->flags & TEE_SHM_PRIV)) {
+		struct mbedtee_device *mbedtee = tee_get_drvdata(shm->ctx->teedev);
+
+		if (mbedtee->yield && shm->sec_world_id)
+			mbedtee_shm_unregister(shm->ctx, shm);
+	}
+
+	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	shm->kaddr = NULL;
+}
+
+static void pool_op_destroy_pool(struct tee_shm_pool *pool)
+{
+	kfree(pool);
+}
+
+static const struct tee_shm_pool_ops pool_ops = {
+	.alloc = pool_op_alloc,
+	.free = pool_op_free,
+	.destroy_pool = pool_op_destroy_pool,
+};
+
+/**
+ * mbedtee_shm_pool_alloc_pages() - create page-based allocator pool
+ *
+ * This pool is used when MbedTEE supports dynamic shared memory. Command
+ * buffers and similar structures are allocated from kernel's own memory.
+ *
+ * Return: pointer to a tee_shm_pool or ERR_PTR on failure
+ */
+struct tee_shm_pool *mbedtee_shm_pool_alloc_pages(void)
+{
+	struct tee_shm_pool *pool = kzalloc_obj(*pool, GFP_KERNEL);
+
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->ops = &pool_ops;
+
+	return pool;
+}
diff --git a/drivers/tee/mbedtee/shm_pool.h b/drivers/tee/mbedtee/shm_pool.h
new file mode 100644
index 0000000..4510676
--- /dev/null
+++ b/drivers/tee/mbedtee/shm_pool.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2015, Linaro Limited
+ * Copyright (c) 2016, EPAM Systems
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ */
+
+#ifndef SHM_POOL_H
+#define SHM_POOL_H
+
+#include <linux/tee_drv.h>
+
+struct tee_shm_pool *mbedtee_shm_pool_alloc_pages(void);
+
+#endif
diff --git a/drivers/tee/mbedtee/supp.c b/drivers/tee/mbedtee/supp.c
new file mode 100644
index 0000000..bc7de22
--- /dev/null
+++ b/drivers/tee/mbedtee/supp.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015, Linaro Limited
+ * Copyright (c) 2020 Xing Loong <xing.xl.loong@gmail.com>
+ */
+#include <linux/device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "mbedtee_drv.h"
+
+struct mbedtee_supp_req {
+	int ret;
+	u32 func;
+
+	struct list_head node;
+	struct task_struct *worker;
+	struct tee_context *ctx;	/* owning supplicant context */
+
+	struct tee_shm *shm;
+	void *data;
+	size_t size;
+
+	struct completion c;
+};
+
+static int mbedtee_supp_check_recv_params(size_t num_params,
+					  struct tee_param *params)
+{
+	if (num_params != 1)
+		return -EINVAL;
+
+	if (!tee_param_is_memref(params) || !params->u.memref.shm)
+		return -EINVAL;
+
+	return 0;
+}
+
+void mbedtee_supp_init(struct mbedtee_supp *supp)
+{
+	memset(supp, 0, sizeof(*supp));
+	mutex_init(&supp->mutex);
+	init_completion(&supp->reqs_c);
+	INIT_LIST_HEAD(&supp->reqs);
+	INIT_LIST_HEAD(&supp->active_reqs);
+}
+
+void mbedtee_supp_uninit(struct mbedtee_supp *supp)
+{
+	mutex_destroy(&supp->mutex);
+}
+
+static void mbedtee_supp_complete_req(struct mbedtee_supp_req *r)
+{
+	list_del_init(&r->node);
+	if (r->shm)
+		tee_shm_put(r->shm);
+	r->shm = NULL;
+	r->ret = TEEC_ERROR_COMMUNICATION;
+	complete(&r->c);
+}
+
+void mbedtee_supp_release(struct mbedtee_supp *supp, struct tee_context *ctx)
+{
+	struct mbedtee_supp_req *r, *n;
+
+	mutex_lock(&supp->mutex);
+
+	/*
+	 * Cancel only requests owned by @ctx.  Unclaimed requests and
+	 * requests owned by other supplicant contexts are left alone.
+	 */
+	list_for_each_entry_safe(r, n, &supp->reqs, node) {
+		if (r->ctx != ctx)
+			continue;
+		mbedtee_supp_complete_req(r);
+	}
+
+	list_for_each_entry_safe(r, n, &supp->active_reqs, node) {
+		if (r->ctx != ctx)
+			continue;
+		mbedtee_supp_complete_req(r);
+	}
+
+	if (supp->ctx == ctx)
+		supp->ctx = NULL;
+
+	mutex_unlock(&supp->mutex);
+}
+
+void mbedtee_supp_abort_all(struct mbedtee_supp *supp)
+{
+	struct mbedtee_supp_req *r, *n;
+
+	mutex_lock(&supp->mutex);
+	supp->shutting_down = true;
+
+	list_for_each_entry_safe(r, n, &supp->reqs, node)
+		mbedtee_supp_complete_req(r);
+
+	list_for_each_entry_safe(r, n, &supp->active_reqs, node)
+		mbedtee_supp_complete_req(r);
+
+	supp->ctx = NULL;
+
+	mutex_unlock(&supp->mutex);
+	complete_all(&supp->reqs_c);
+}
+
+static int supp_enqueue_req(struct mbedtee_supp *supp,
+			    struct mbedtee_supp_req *req)
+{
+	int ret = 0;
+
+	mutex_lock(&supp->mutex);
+	if (supp->shutting_down)
+		ret = -ESHUTDOWN;
+	else
+		list_add_tail(&req->node, &supp->reqs);
+	mutex_unlock(&supp->mutex);
+
+	return ret;
+}
+
+/*
+ * Receive an RPC request from TEE and dispatch it to supplicant.
+ * Blocks until the supplicant sends back the result.
+ */
+void mbedtee_supp_handler(struct mbedtee_device *mbedtee,
+			  u32 func, void *data, size_t size)
+{
+	struct mbedtee_supp *supp = &mbedtee->supp;
+	struct mbedtee_supp_req *req = kzalloc_obj(*req, GFP_KERNEL);
+	struct supp_cmd_hdr *cmd = data;
+	int ret;
+
+	if (!req) {
+		if (cmd && size >= sizeof(*cmd))
+			cmd->ret = TEEC_ERROR_OUT_OF_MEMORY;
+		return;
+	}
+
+	init_completion(&req->c);
+	req->func = func;
+	req->data = data;
+	req->size = size;
+
+	ret = supp_enqueue_req(supp, req);
+	if (ret != 0) {
+		if (cmd && size >= sizeof(*cmd))
+			cmd->ret = TEEC_ERROR_COMMUNICATION;
+		kfree(req);
+		return;
+	}
+
+	/* Wake up the supplicant daemon to handle this request. */
+	complete(&supp->reqs_c);
+
+	wait_for_completion(&req->c);
+
+	kfree(req);
+}
+
+static int supp_pop_req(struct mbedtee_supp *supp,
+			struct mbedtee_supp_req **req)
+{
+	struct mbedtee_supp_req *r = NULL;
+	int ret = 0;
+
+	mutex_lock(&supp->mutex);
+	if (supp->shutting_down) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	r = list_first_entry_or_null(&supp->reqs, struct mbedtee_supp_req, node);
+
+	if (r) {
+		list_del_init(&r->node);
+		r->worker = current;
+		list_add_tail(&r->node, &supp->active_reqs);
+	}
+
+out:
+	mutex_unlock(&supp->mutex);
+	*req = r;
+	return ret;
+}
+
+/*
+ * Called by supplicant to receive the next pending request.
+ */
+int mbedtee_supp_recv(struct tee_context *ctx,
+		      u32 *func, u32 *num_params, struct tee_param *param)
+{
+	struct tee_device *teedev = ctx->teedev;
+	struct mbedtee_device *mbedtee = tee_get_drvdata(teedev);
+	struct mbedtee_supp *supp = &mbedtee->supp;
+	struct mbedtee_supp_req *req;
+	struct mbedtee_context_data *d = ctx->data;
+	struct tee_shm *shm = param->u.memref.shm;
+	int ret;
+
+	ret = mbedtee_supp_check_recv_params(*num_params, param);
+	if (ret != 0)
+		return ret;
+
+	shm = tee_shm_get_from_id(ctx, shm->id);
+	tee_shm_put(param->u.memref.shm);
+	if (IS_ERR(shm)) {
+		param->u.memref.shm = NULL;
+		return PTR_ERR(shm);
+	}
+	param->u.memref.shm = shm;
+
+	d->is_supp_ctx = true;
+
+	while (true) {
+		ret = supp_pop_req(supp, &req);
+		if (ret != 0)
+			goto err;
+		if (req)
+			break;
+
+		if (wait_for_completion_interruptible(&supp->reqs_c)) {
+			ret = -ERESTARTSYS;
+			goto err;
+		}
+	}
+
+	/* Record which supplicant context owns this request. */
+	req->ctx = ctx;
+
+	if (req->size > param->u.memref.size) {
+		/* Return the request to the queue so it isn't lost */
+		mutex_lock(&supp->mutex);
+		list_del(&req->node);
+		list_add(&req->node, &supp->reqs);
+		mutex_unlock(&supp->mutex);
+		ret = -EOVERFLOW;
+		goto err;
+	}
+
+	*func = req->func;
+	req->shm = shm;
+
+	memcpy(shm->kaddr, req->data, req->size);
+	param->u.memref.size = req->size;
+
+	return 0;
+
+err:
+	tee_shm_put(shm);
+	param->u.memref.shm = NULL;
+	return ret;
+}
+
+/*
+ * Called by supplicant to send back the result of a request.
+ */
+int mbedtee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
+		      struct tee_param *param)
+{
+	struct tee_device *teedev = ctx->teedev;
+	struct mbedtee_device *mbedtee = tee_get_drvdata(teedev);
+	struct mbedtee_supp *supp = &mbedtee->supp;
+	struct mbedtee_supp_req *req;
+	struct mbedtee_supp_req *_req;
+
+	if (num_params != 1)
+		return -EINVAL;
+
+	if (!tee_param_is_memref(param))
+		return -EINVAL;
+
+	/*
+	 * Find the active request belonging to this worker thread.
+	 * Each worker is identified by its task_struct pointer, which
+	 * was recorded when supp_pop_req() dispatched the request.
+	 */
+	mutex_lock(&supp->mutex);
+	req = NULL;
+	list_for_each_entry(_req, &supp->active_reqs, node) {
+		if (_req->worker == current) {
+			req = _req;
+			list_del_init(&req->node);
+			break;
+		}
+	}
+	mutex_unlock(&supp->mutex);
+
+	if (!req)
+		return -ENOENT;
+
+	if (param->u.memref.size > req->size) {
+		req->ret = TEEC_ERROR_COMMUNICATION;
+	} else {
+		req->ret = ret;
+		memcpy(req->data, req->shm->kaddr, param->u.memref.size);
+	}
+	if (req->shm)
+		tee_shm_put(req->shm);
+	req->shm = NULL;
+
+	/* Wake up mbedtee_supp_handler(). */
+	complete(&req->c);
+
+	return 0;
+}
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 5203977..2d30296 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -60,6 +60,7 @@
 #define TEE_IMPL_ID_AMDTEE	2
 #define TEE_IMPL_ID_TSTEE	3
 #define TEE_IMPL_ID_QTEE	4
+#define TEE_IMPL_ID_MBEDTEE	5
 
 /*
  * OP-TEE specific capabilities
-- 
2.43.0

