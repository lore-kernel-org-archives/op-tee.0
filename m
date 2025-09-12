Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F39CAC582
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 10:18:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0509A42EA5
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 10:18:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hC9B0uCD;
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0F63342EA5
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 10:17:56 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b04271cfc3eso212485166b.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757672275; x=1758277075; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTzuzrwSKIoy0QCORxUKogHZpcF/Bu7LDHHnirDhYR8=;
        b=hC9B0uCDaNw+NmsgyCXMiLZG4BAOzoP623R0rGQPqp//oMtBwp0AhqvQp1uCLLgCr2
         a+uqqAvPQeuLjwihqzzZ5KRhQCWjnlQGc+CK7dXg5H1uetjGjACXKvKOpDEpYxCMQdZk
         R6C4n9BCA6H3kb7iU4ENzlGAnc93zE2+vX8ZidCfjd3Sm1AZJDSOM2AKJ1cyea2vXh7z
         WWJdzUpUJp9MGbdpqusF4x3gu6qx/0/vC1RHR4sGgNXwIZTd0MJVjyYCYMXCNt/OY3hT
         cejwBmrGmHHwjdPiiL+O3a0p4gLXNOd9ie/4hsLgqOmTavQGz0uTYbZJudlYPcd0ktzZ
         ct5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672275; x=1758277075;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTzuzrwSKIoy0QCORxUKogHZpcF/Bu7LDHHnirDhYR8=;
        b=Dbx6tGBtp63+ezn1qXytmAN0qQFbtkR4W5n6RYfeVkR+kornCNXejKrHxFIJWxGuwg
         sN4qa4XglnSyuPOu1svdPVrrRVG6+idiXlKRIc6CKQcUoUolyEkgMSnCye/pgBoHhfFX
         9bB9YokYkYv1bpm1vImWLs0uM1sqoL6XFSDuPPkBodxX0IQWt/6X9ZWiZVtg0uEUcQp1
         6FdVhU08SVL+9WVaIypOSJ3mwS4s84QOpBbJ5fpm/BiVBXXuVYLuumzYOTQwekC9Udjx
         PoyZHf9adttkNZDifnwOt4tns+tK/U8Y0YW96GvbP8JHYrkN9ykF0nIvc1itjdv0elum
         JhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSgFarOZQCv1BRVLml9biKz9sUIECSLAcVdg8MJEdPBdjDBjQTtz+GnsO+ykOGHxFYlloIzR0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx82l3+1RXzqmG+JsfRBH/CctciUV+lF1HENpZSr6jhj3YTbTaR
	tHQZzTl4NpN/1Y4YlyYLeZyr7zsGZX8HUNgfkWU4TIGGRUggsyMi87/Dqqd/0agdPSdCqA==
X-Gm-Gg: ASbGncuh6kpFobvnjivPZiq/TpDqfxs1QxNK1Y6OvnRNEvKiN0cOxj/JvTvPBYvracn
	Pzjmlj6NTmVEhQQiHTjeT9KqJUDe38zzi+xR1VyypXFgw8nebGoQu4ZQkvDSTljtKcbAmbKgx6C
	wm4b7ts1/VUuY5CVktf9SHUmhE5iiv35QKOOCYiqn9AjHmRFhY19LmUhM0vMRQ0rXppuKXxoGv+
	d7huuNzWFNQ3bYDCSbxYrgERjsAzFG+ZkGE5h7x6f47/wMHEKaJdh+Qr6XfjcrP5LHywAGbBtm4
	rztiIA/6X2TWhkSNzw0FjOwhTdmJcljeUKFTPn3kvB/4Ia8pYPgyR6rBLa4n7JgTVT6ppPb/Ntn
	KA7h0u6UG5KkppW3jWrS/XEWF4CHuhppwkDp3xD/EswNGvclLMNhTYo4pnWf79pu7BeyUvQI+xZ
	w=
X-Google-Smtp-Source: AGHT+IHFwPpvM0RAZ0u7rHWSik54d2YaYUorN19OUt5HDkQV06Xun9QOHOryJK4lnOZ1tS+U/f++PA==
X-Received: by 2002:a17:907:7fa0:b0:aff:17a2:629 with SMTP id a640c23a62f3a-b07c353eb39mr226343866b.3.1757672274881;
        Fri, 12 Sep 2025 03:17:54 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e4fesm343087566b.106.2025.09.12.03.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:17:54 -0700 (PDT)
Date: Fri, 12 Sep 2025 12:17:52 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE protected DMA-bufs for v6.18
Message-ID: <20250912101752.GA1453408@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 0F63342EA5
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.50:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.50:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: REPGICF7HANJZUKK64SLKTR2IT2SUPGZ
X-Message-ID-Hash: REPGICF7HANJZUKK64SLKTR2IT2SUPGZ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org, Sumit Semwal <sumit.semwal@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/REPGICF7HANJZUKK64SLKTR2IT2SUPGZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this set of patches enabling protected DMA-bufs in the TEE
subsystem. There's a brief desciption in the tag below. All patches but
"dma-buf: dma-heap: export declared functions" are withing the TEE
subsystem. The dma-heap maintainer, Sumit Semwal, has acked the dma-heap
patch to be merged via my tree.

I believe I've addressed all comments from the reviews including providing
a demo as described in [1].

[1] https://lore.kernel.org/op-tee/20250911135007.1275833-1-jens.wiklander@linaro.org/

Thanks,
Jens

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-prot-dma-buf-for-v6.18

for you to fetch changes up to dbc2868b7b57fb4caa8e44a69e882dcf8e8d59bf:

  optee: smc abi: dynamic protected memory allocation (2025-09-11 11:22:43 +0200)

----------------------------------------------------------------
TEE protected DMA-bufs for v6.18

- Allocates protected DMA-bufs from a DMA-heap instantiated from the TEE
  subsystem.
- The DMA-heap uses a protected memory pool provided by the backend TEE
  driver, allowing it to choose how to allocate the protected physical
  memory.
- Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
  Recording) have been identified so far to serve as examples of what
  can be expected.
- The use-cases have predefined DMA-heap names,
  "protected,secure-video", "protected,trusted-ui", and
  "protected,secure-video-record". The backend driver registers protected
  memory pools for the use-cases it supports.

----------------------------------------------------------------
Etienne Carriere (1):
      tee: new ioctl to a register tee_shm from a dmabuf file descriptor

Jens Wiklander (8):
      optee: sync secure world ABI headers
      dma-buf: dma-heap: export declared functions
      tee: implement protected DMA-heap
      tee: refactor params_from_user()
      tee: add tee_shm_alloc_dma_mem()
      optee: support protected memory allocation
      optee: FF-A: dynamic protected memory allocation
      optee: smc abi: dynamic protected memory allocation

 drivers/dma-buf/dma-heap.c        |   4 +
 drivers/tee/Kconfig               |   5 +
 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/Kconfig         |   5 +
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/core.c          |   7 +
 drivers/tee/optee/ffa_abi.c       | 146 ++++++++++-
 drivers/tee/optee/optee_ffa.h     |  27 +-
 drivers/tee/optee/optee_msg.h     |  84 ++++++-
 drivers/tee/optee/optee_private.h |  15 +-
 drivers/tee/optee/optee_smc.h     |  37 ++-
 drivers/tee/optee/protmem.c       | 335 +++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 141 ++++++++++-
 drivers/tee/tee_core.c            | 158 +++++++++---
 drivers/tee/tee_heap.c            | 500 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/tee_private.h         |  14 ++
 drivers/tee/tee_shm.c             | 157 +++++++++++-
 include/linux/tee_core.h          |  59 +++++
 include/linux/tee_drv.h           |  10 +
 include/uapi/linux/tee.h          |  31 +++
 20 files changed, 1670 insertions(+), 67 deletions(-)
 create mode 100644 drivers/tee/optee/protmem.c
 create mode 100644 drivers/tee/tee_heap.c
