Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB7FC55174
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:16:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AC824452F7
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:16:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=OqeDwoJP;
	dkim-atps=neutral
Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 94E8944DE0
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 15:11:54 +0000 (UTC)
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-4489b7aa0e7so130571fac.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783005114; x=1783609914; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUoKcMNp1i0OsjwBDMTVKkf2BV13qPTJjkx+a7eS6X8=;
        b=OqeDwoJP99tbrz3b2bfu4062MbsBeyY7OaAGOXUKGBb7Prq69rQ/jBkqwz1ENm89Ni
         6+O1bsPvCW5sqAInEsDr2c/j4b/LNxxC/3coeevN83s4T0bFeH9yGrtWyQoxPMKbEWS2
         I43PfJ8QO0KXOXMZrAdMjR0duk0i5FHkKHj0Cv7fsnE9yN60IA4JiGq7d5Q1LNSM5brj
         Epb+GxunmNyipQhFCr+YwkrGpr8Dgc8KTG3QAUjEeIpYgG2WQSp+D/uoc1GSHdNADgh0
         rqlqgaFK3iRd83WUSn2KbDPPJWsH7jNNqZuEmqFq7tPC7596uGfWRS6ii5M5H1XzBfts
         viXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005114; x=1783609914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gUoKcMNp1i0OsjwBDMTVKkf2BV13qPTJjkx+a7eS6X8=;
        b=nUIUWghPQt0To96Tg3SNc694rMgXFEJzpJGdxX29fxYXtUm2qJBacIBb75HCh0kxUq
         xg4MMAz3OUnWUfrffI6kenFVdKggHuzIY0SKV7rp905K/OQdAXhAs1sRoyyPbsPoAdrc
         B+FFM2KKPeONwMlmOdsXxAR1oBjXY/1rgLv/vtrJdkU/kG1B+KUtDUyowiqQx8H+s5ME
         OJQ+Y4wVb/eNwdEaWhviJW2jmMAdk1FGtohgoXFVA2jEXEX7VRTC/j9VNkKrDCw/PL8l
         X8tERl6JkpBXr/Hnq2HOTDB0yIW4ssWifmfN0uLzjSoHnzmQzwYHthjiwkQX0asIH/rP
         3aiQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8hGkKlkb6rkiBlVureglS6DpILbb3icC8G6fmQBtuQ5mO7RmuPYUze8sySFOwbmCrbsSUS4o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwW6FPHcS3pIpDM4WhBr4NwSdncKHMfZdsks9/644y09Ey0m9/b
	bAsEkLOwRpznmZAhqmZTetoOVcu3t4CLxlx5i1c2m7uxJCT1mLs3rW21
X-Gm-Gg: AfdE7cny7HDK8kNbr/WMI/FfOduaa3XrZaDVOBg00FwIdRd0yrvXOA/LgQxwSt+tfyb
	va4nkyIHhG1A7jvg6IvM3U5iF9KgdWSm0VYnDA7l0RxYmY7rkcCor5/f7N++/AFlFpqnjQHP8MD
	gDKbQZRZ+alg+MBxuQF1ajcgrOm0Wlxsokd7pIAynDfeCHSMU4RWrgCvB3iD9PEg2HqEVZVg27B
	4kvqRBucBEne9pKylP/ZHo+WvazrRCpxeH68zbixvDUDqly6AJUwmcZveGGHBslIaqpLFoIk4iz
	TYin1zdEJ+lgIcUq/vaVyfz7OotoRBp2x+tpsrWT5nPmTvK/JiwWDAIZpf7wuQdRZmcrGg/lk74
	EnCa4fjkerhz8ZYiXDDsQpnj9CjCCjlFQeqqL1xPE1FKqk4+bFeSGg9Nnh/vMNl/hoEqyH3kfNO
	wtNKBoXQHzrl0hScMQORg90dTDWjMh6y/BU+LqoBoxcoW+rXZA0xGPG/I=
X-Received: by 2002:a05:6871:d3:b0:447:3be4:44d with SMTP id 586e51a60fabf-44cabc00880mr4009842fac.33.1783005113834;
        Thu, 02 Jul 2026 08:11:53 -0700 (PDT)
Received: from ubuntu24.. (dsl092-249-254.sfo4.dsl.speakeasy.net. [66.92.249.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec9a113sm3094561fac.9.2026.07.02.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:11:53 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v2 0/3] tee: add MbedTEE driver
Date: Thu,  2 Jul 2026 23:11:12 +0800
Message-ID: <20260702151115.544016-1-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701132514.186953-1-xing.xl.loong@gmail.com>
References: <20260701132514.186953-1-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org,gmail.com];
	DNSWL_BLOCKED(0.00)[74.125.231.65:from];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.231.65:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 94E8944DE0
X-Spamd-Bar: -
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: GBKZD7GQPUL4C42GXD2XX3FIZZKDS4DG
X-Message-ID-Hash: GBKZD7GQPUL4C42GXD2XX3FIZZKDS4DG
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:13:17 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GBKZD7GQPUL4C42GXD2XX3FIZZKDS4DG/>
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
Changes in v2:
- 0002: Fix DT binding review comments from Krzysztof Kozlowski:
  - Drop $nodename, "YAML devicetree binding" wording, property descriptions
  - Rename compatible string to mbedtee,tee
  - Rename memory regions: rpc-t2r-ring -> t2r-ring, rpc-t2r-shm -> t2r-shm,
    rpc-r2t-ring -> r2t-ring
  - Add memory-region / memory-region-names to required
  - Simplify allOf constraints (drop redundant else-branch items)
  - Rewrite description to describe hardware/firmware, not the binding or driver
  - Drop all irrelevant platform nodes (gic, cpus, reserved-memory
    containers, reg addresses, riscv wrapper); the ARM example now
    uses bare interrupts (matching arm,sbsa-gwdt.yaml precedent)
    with only phandle-required stubs (imsic, t2r-ring, r2t-ring)
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

 .../bindings/firmware/mbedtee,tee.yaml        | 132 ++++
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
 22 files changed, 3190 insertions(+), 1 deletion(-)
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

