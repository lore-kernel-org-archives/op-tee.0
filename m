Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F0EC55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:14:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3E08C4528B
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:14:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=XxeWjf2A;
	dkim-atps=neutral
Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E126C44DD0
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Jul 2026 13:25:39 +0000 (UTC)
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-495fbed415dso210696b6e.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 01 Jul 2026 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782912339; x=1783517139; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dk9Opzu24JNP4K9nU0Mr28PXO88jXoMMk5rdIT57/w=;
        b=XxeWjf2Ag55D9c+sBPqgZyT8VmLyqlOdCYzoTQQp3RnUaiEE+1aNWTkzrtMgFYoSi1
         x7yNJR5G/ClaKcrImFVn9axKcgI0+50TGlhBklhUuRy88OKk3AwAhFAU9SCnjnED+gP5
         ZXPzMED2waRYOfEvWShPeDubFOiB8ndjp+yo6pOkpxIkb4YnWflpDMxdM8Z+QGFzdNZ3
         ElXreQXNXdIu8bOpN0uX81U3epiHbYgvWcvL+xZzlADKF4RkY19tcNKhk0ZxWGuTEU3I
         1E7Jre+SB7PPcuRIqevb0Jes0BVKWSa5Y2XIe23GyAEMQ4MIv8Z/W4b8OhUU06wB6TBT
         xZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912339; x=1783517139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dk9Opzu24JNP4K9nU0Mr28PXO88jXoMMk5rdIT57/w=;
        b=rxVOMYKQs+llv2wLHAwiioQrfzt+WywsRyorJ3/B9K1bOEJhj4vQ6S5C2ufNljxSBD
         6i0JwFHpKkuNaDq4X33tS2o2KE3brgUk9N/UHbWu4kiEgmv2yWo2dEPNrQbBK/JtxbtB
         mM25T4aAVUvYbS/fhbbex5yj1HsOQUeuUbqIhMFHLtBhoDmzygBhqaInLy0mux2HQ4J+
         A/89B4kUG39T5KDIvESTarnPd1Zym8lu29QJSOS63WfoTsk2hjLWkqPl8PvbfCgefbaX
         GTqq60X9WLRP6fPhKQuFIzuc+fi9CkUBadLSv/dqsX77miSwdwjtR6PvqwpcErtPO0UH
         3erw==
X-Forwarded-Encrypted: i=1; AFNElJ+QGriNtdT4uUfDqOmO/VfXgbH9Nx1Og6Yel1mwFMYY/UkjXkfgMWNxj+De8V5b4G4cMTDhp34=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwEzs8ntXxyJTtBoG7c+bFXc/fDeVLJ34R6tEAjv8CcC1u8QXiR
	immJ/ZXI/mCoMyUiUe99RWvYFS0wgNs7IPqMkcz7ZNnaNKm69Wa8hNlc
X-Gm-Gg: AfdE7cmAN9vchaRetwQyK/vr3e17X1whJz6mQmc2oQZGgDZsYa/s3xZ6Epwe5pYZCXr
	aF5FZlNm6l9v7te6uT98y60g0QTf8xmInnIbxiCxo0XKL/0ZRJE7eZ9vhPiTt0ulLNFnzPXcwdb
	V+O67Xfy8P0MXROGx3ABrLHPlRAG/bbLQmtgH6ddV4/k0aBPfsZIRgKwcriZdRIp28JdymCe+tS
	QpiGnmREVsxVciN0AupnOxDOz6Emi6VZI2mDbqQVwyKAzdPvYRL/mXsoKIRxhXywrCGZgrWQ1W5
	ibx2aZd9iUyNOQpwUcAEc6c4HtMl58Hape3qzFOJSMsUREHipVf8DTMlMoEdMAD1tFoq7qJb/Rv
	kGAe6qPr7rUkB663TJjNRZzsGvJ/7wgwwB3bmDmK582CGG79lGGcaBN0ifWNWnStEfMtlf3memb
	gd/MMUyaxHKy79UXiPWjnROWk1cn1RNy2U4e3Tx+7qTO2pVcsVZWnD1Dg=
X-Received: by 2002:a05:6830:348a:b0:7e9:e5df:5ee2 with SMTP id 46e09a7af769-7eb3cedcb83mr899113a34.6.1782912339110;
        Wed, 01 Jul 2026 06:25:39 -0700 (PDT)
Received: from ubuntu24.. (dsl092-249-254.sfo4.dsl.speakeasy.net. [66.92.249.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec34f898sm4938144a34.27.2026.07.01.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:25:38 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/3] tee: add MbedTEE driver
Date: Wed,  1 Jul 2026 21:25:11 +0800
Message-ID: <20260701132514.186953-1-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.231.193:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.231.193:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E126C44DD0
X-Spamd-Bar: -
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: M4BO252V7LRA536OOOZ5HEL5TLD4MDRC
X-Message-ID-Hash: M4BO252V7LRA536OOOZ5HEL5TLD4MDRC
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:13:16 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/M4BO252V7LRA536OOOZ5HEL5TLD4MDRC/>
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
  [2/3] dt-bindings: firmware: add mbedtee,rpc binding
  [3/3] tee: add MbedTEE driver

Xing Loong (3):
  dt-bindings: vendor-prefixes: add mbedtee
  dt-bindings: firmware: add mbedtee,rpc binding
  tee: add MbedTEE driver

 .../bindings/firmware/mbedtee,rpc.yaml        | 221 +++++++
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
 drivers/tee/mbedtee/rpc_callee.c              | 609 ++++++++++++++++++
 drivers/tee/mbedtee/rpc_callee_arm.c          |  91 +++
 drivers/tee/mbedtee/rpc_callee_riscv.c        | 203 ++++++
 drivers/tee/mbedtee/rpc_caller.c              | 539 ++++++++++++++++
 drivers/tee/mbedtee/rpc_caller_arm.c          |  66 ++
 drivers/tee/mbedtee/rpc_caller_riscv.c        | 192 ++++++
 drivers/tee/mbedtee/shm_pool.c                | 105 +++
 drivers/tee/mbedtee/shm_pool.h                |  15 +
 drivers/tee/mbedtee/supp.c                    | 310 +++++++++
 include/uapi/linux/tee.h                      |   1 +
 22 files changed, 3277 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml
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

