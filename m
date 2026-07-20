Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A20C55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:21:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DBC5444E6B
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:21:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=SOijbrKk;
	dkim-atps=neutral
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2ECDC43B63
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 07:36:35 +0000 (UTC)
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381086b2ec2so690991a91.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 00:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532994; x=1785137794; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bSGBn4Ublx73sYl2HPbFN0xtoAs6LbPrdTcJddm5B3g=;
        b=SOijbrKky8E2FcV+RRptKYb2oafIUSiTcRJ8Gkujd1mMFD9XwuSDkvmXKaHzbA2YYO
         4+5+kmhlZ5IK25ZpZjRHSKEKHlSMsTYtSh8vI8tedIJxeAw3sBLKKRseImPRUEYqlAf9
         jROLwpkbXFYE26NOG1AXZnoxamepTer4SJbX+8vAdtu7FklLAfYnS1cliFpyFJTkZrs+
         cu/gbXk65RVk44JFGc0NtzOtblmwzAB/iAGd/y2BZNjO4stzc2pDdK6kBFvikSX3fUgP
         AuABTnHGGIJWSlSv+5zOWx2Hl73aOmo8uLgLp7ODz28QoPYN58rTP1IfpKeR2KWdV+Mc
         hvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532994; x=1785137794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bSGBn4Ublx73sYl2HPbFN0xtoAs6LbPrdTcJddm5B3g=;
        b=UNev9xIZZXbkwdd00R3/ESFgCkfF6mPHKO1eoa0Kja0tkZLGS4+mDF7HnXqkzh7wc8
         uZqoECtMEuR7Mo9YOUaeUpnwIZuQ9gW4wqDtQDPr4MmC4MQ9dpAcFuPzvCfv1na1vZsj
         fp6IwKwOQpish9+kQLP8dYIxcbGfzsQrGDm94GSJzVTsbpeoiuRXJV6avoKSc5MoLF/E
         BqBpgTDAgNb6bd3kU0BLQ92wTgN7JOBGzydw9rqqflml5QiFuIw+KW/xq+QKXGLJ2fEe
         ygQbkQJ6D+4+ocMitkEt49C++M2/MbhaKG94w85+5d0tiN1f/sgqTRYzNv9/ppzDOJQ0
         h36Q==
X-Forwarded-Encrypted: i=1; AHgh+RqQgJ0cMKXpjWzBi5tXEKJcuzyZHIP5SoHoMfQttIUM6fJnYExw2BPCMEwPWzQt2SURxd9r5nU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyEAy1j8yh/5Jl42Q1orB28wbVD2j7YCg8gSewTNT5np6ZUfsEG
	aMD+x8UkZFrdYwXUzetgYIRbbioRZFVc62o8hotOjtB7mpMAYqYgorhW
X-Gm-Gg: AfdE7cm2q4SgOtTV3Md/S+EMpEPdqAN3snkbnS7jogKqLjqYjrPdgpCqTozsqNyO1a6
	uSrh3DTjjj2G4TUaO1awpp9sSX71fF+5DvBuPbUwu2nuVsj1HRGSLjNl6yS+nEws9VXvvMv5Wwi
	9vXvoFGW8FEWnfMcZ92rpEByx4qLVonMqy7Zlknxwcw84pTAv3gFmoMLbCEC2yNL36ii1ASW1pm
	u0fibhib8QyJBs3BiQJi3I6pPKuLExqq0s1YzRCHCU1ucmoNrTgGpnQFAoKUFrq2c6+d32W5ved
	vlgvkTzaEB7oFT+Iifyb77AmX5J9fSQUwkECMagqsQPOGqd2L+vRXNSy+Tnq1FDntgxl/Z1R+WH
	+72Cdqd/VIeIqI/O2u1zRhPSQvCGnfshqCn7d0PThdc6g+0SpYhvsDM8rcLhSrEfUu+MZauD/0z
	1QbzA=
X-Received: by 2002:a05:6a00:2289:b0:848:2ef5:50d8 with SMTP id d2e1a72fcca58-84c28c2daa4mr13302524b3a.32.1784532993870;
        Mon, 20 Jul 2026 00:36:33 -0700 (PDT)
Received: from ubuntu24.. ([216.23.123.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcaa0bsm5210536b3a.20.2026.07.20.00.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:36:33 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v3 0/3] tee: add MbedTEE driver
Date: Mon, 20 Jul 2026 15:35:54 +0800
Message-ID: <20260720073558.799755-1-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
	ASN(0.00)[asn:15169, ipnet:74.125.227.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.227.129:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.227.129:from];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2ECDC43B63
X-Spamd-Bar: -
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 6WZB2KWQXTCHPED4AOZDVDEYZ3D5R7VM
X-Message-ID-Hash: 6WZB2KWQXTCHPED4AOZDVDEYZ3D5R7VM
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:07 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6WZB2KWQXTCHPED4AOZDVDEYZ3D5R7VM/>
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

 .../bindings/firmware/mbedtee,tee.yaml        | 109 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/tee/index.rst                   |   1 +
 Documentation/tee/mbedtee.rst                 | 155 +++++
 MAINTAINERS                                   |   9 +
 drivers/tee/Kconfig                           |   3 +-
 drivers/tee/Makefile                          |   1 +
 drivers/tee/mbedtee/Kconfig                   |  20 +
 drivers/tee/mbedtee/Makefile                  |  11 +
 drivers/tee/mbedtee/core.c                    | 236 +++++++
 drivers/tee/mbedtee/mbedtee_drv.h             | 269 ++++++++
 drivers/tee/mbedtee/mbedtee_msg.h             | 219 +++++++
 drivers/tee/mbedtee/rpc_callee.c              | 618 ++++++++++++++++++
 drivers/tee/mbedtee/rpc_callee_arm.c          |  91 +++
 drivers/tee/mbedtee/rpc_callee_riscv.c        | 203 ++++++
 drivers/tee/mbedtee/rpc_caller.c              | 532 +++++++++++++++
 drivers/tee/mbedtee/rpc_caller_arm.c          |  66 ++
 drivers/tee/mbedtee/rpc_caller_riscv.c        | 192 ++++++
 drivers/tee/mbedtee/shm_pool.c                | 105 +++
 drivers/tee/mbedtee/shm_pool.h                |  15 +
 drivers/tee/mbedtee/supp.c                    | 310 +++++++++
 include/uapi/linux/tee.h                      |   1 +
 22 files changed, 3167 insertions(+), 1 deletion(-)
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

