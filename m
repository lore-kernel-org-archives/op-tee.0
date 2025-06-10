Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0C9C5B552
	for <op-tee@archiver.kernel.org>; Tue, 10 Jun 2025 13:16:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5A26A46460
	for <op-tee@archiver.kernel.org>; Tue, 10 Jun 2025 13:16:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dztBLQ6Y;
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 584F83E987
	for <op-tee@lists.trustedfirmware.org>; Tue, 10 Jun 2025 13:16:10 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ade48b24c97so449327366b.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 10 Jun 2025 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749561369; x=1750166169; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri4++88KyCAFFBsQpRdzKdsThABD6WsDtwqnK7XpHl8=;
        b=dztBLQ6Y0OKP+LYX1l4XPkljXqXRLObqp8UdfctRQ6GP5jpzG/CgtVNg/4rZ43OtpL
         hOtOxCItTlwyYGGnzeqDQu9tdz6mlq2QSUilrJtzlb6iaPVsXfAkN8A+KRXuXfVBPA7j
         agbKLSlhdNYpNTExHfCH0BZR9i/GbNIyYng488l0IavPRpjUy0V/BCPvR3dYxgxgkVN1
         e3sqRBp2xo2abAqCPtSygoLKN9EuUyHl2J94AspvS32yxTOM1LfTL02nc5QQqs3+XZBC
         CvKnfY7WRJpkPKUyPEzyigLfW5WL/uNbqJxCgkwp+JDfj6ldqkqYlq7hPXmpYOPHT/pM
         iBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561369; x=1750166169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ri4++88KyCAFFBsQpRdzKdsThABD6WsDtwqnK7XpHl8=;
        b=j7Cq0WxBL/gXU1frHJxm2I5OWEwO6/ZjGNmLRatVYTiapekGsYtB27oxXminKL/5B6
         R3DkID6H63rROUHSsaG6Fgt6B6xp+VM8vFVPZQ2qnMCO3Icsvw3gLYqZAoBqoj8V8lkm
         emhAHnt74gyM+t2rODCfvkU6gWsY4s4DMhpxj+SSEADZ2SWRwruqaQw2gCFze1nHmiT9
         XFf0W+wDGaQWhnL7ZzEU61XnDHYeYaz9x7kP6RtuiidAoueVelaO4RyHbgwcjcpG9rdg
         /3rI1OqJcpJeueu4qL8XXS4AoEBEjCupeKkBtcq6QGgYn+VT6nz88JcZRU6n9gbzDs9A
         Jb6A==
X-Forwarded-Encrypted: i=1; AJvYcCUW7sUWDWc09moAn+GLDbV0BgKLaNHihHHkOCaRzsDkJliVAm7xB8Zf2Kh0c93Yey4vHcf+Llg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwJfQlToPfpTX4dmLmA7TaJ/tmaFZ58qIr6gkA6L5AoXmNWgsGK
	fXSKomlKnH3O9Ag/rK0N1+zbF5R0Aky9A4y+phc8s9iAjtij/bK4EicXRWTIAmCuCM2XBA==
X-Gm-Gg: ASbGnctzg/o6qcfapYqkzspukF7xL85iG9bvLhjNGrYIq5bbsJsLSZc+TW/1b7SSih/
	M7kpT/cxcoObodlH4v4nwZtVt76sVx9o0WctdxiLZ2LQpKT69q9M/zSd46kIrNKJaWQhR4lR6/N
	wdQxiIXp7SgWbyzp2wzFeRPcYiCErtaxka77JVO5MYNjvqeCICRa1FsmedIkSqHgaW2dCna1iAO
	7h+bbK1wtqnfjRWgkgEhvoimdGC+/KZ372Qb625ja6mObGfrKruEEWwT8mdZGYW1e6c0DgZykBP
	JfhrGQmgLv2fPIkFj4PeNMVnEqK0w2Vu917nCJwsW0rWUWDKl8h43dnWYv28pAWfa49qaiwtwtJ
	vsBcc+0PLyfA56MTxffv5vYekR6e1RY3iYRIkS/w=
X-Google-Smtp-Source: AGHT+IH+NqfO0eRJpBwx+OETPzlNHnv9dU7aYJP1gt7nx8Svz410+PQMt4+K+Y+L3GHIBYSzGjaBVg==
X-Received: by 2002:a17:907:60d1:b0:adb:2462:d921 with SMTP id a640c23a62f3a-ade1a9160c3mr1613066266b.5.1749561369005;
        Tue, 10 Jun 2025 06:16:09 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade3206a1efsm643651666b.67.2025.06.10.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:16:08 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 0/9] TEE subsystem for protected dma-buf allocations
Date: Tue, 10 Jun 2025 15:13:44 +0200
Message-ID: <20250610131600.2972232-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.54:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	TAGGED_RCPT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.54:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 584F83E987
Message-ID-Hash: UITEG2UXVGKOJXE7TD7SNVOPIKMI6X6P
X-Message-ID-Hash: UITEG2UXVGKOJXE7TD7SNVOPIKMI6X6P
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UITEG2UXVGKOJXE7TD7SNVOPIKMI6X6P/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

This patch set allocates the protected DMA-bufs from a DMA-heap
instantiated from the TEE subsystem.

The TEE subsystem handles the DMA-buf allocations since it is the TEE
(OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QTEE) which sets up the
protection for the memory used for the DMA-bufs.

The DMA-heap uses a protected memory pool provided by the backend TEE
driver, allowing it to choose how to allocate the protected physical
memory.

The allocated DMA-bufs must be imported with a new TEE_IOC_SHM_REGISTER_FD
before they can be passed as arguments when requesting services from the
secure world.

Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
Recording) have been identified so far to serve as examples of what can be
expected. The use-cases have predefined DMA-heap names,
"protected,secure-video", "protected,trusted-ui", and
"protected,secure-video-record". The backend driver registers protected
memory pools for the use-cases it supports.

Each use-case has its own protected memory pool since different use-cases
require isolation from different parts of the system. A protected memory
pool can be based on a static carveout instantiated while probing the TEE
backend driver, or dynamically allocated from CMA (dma_alloc_pages()) and
made protected as needed by the TEE.

This can be tested on a RockPi 4B+ with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m rockpi4.xml \
        -b prototype/sdp-v10
repo sync -j8
cd build
make toolchains -j$(nproc)
make all -j$(nproc)
# Copy ../out/rockpi4.img to an SD card and boot the RockPi from that
# Connect a monitor to the RockPi
# login and at the prompt:
gst-launch-1.0 videotestsrc ! \
        aesenc key=1f9423681beb9a79215820f6bda73d0f \
                iv=e9aa8e834d8d70b7e0d254ff670dd718 serialize-iv=true ! \
        aesdec key=1f9423681beb9a79215820f6bda73d0f ! \
        kmssink

The aesdec module has been hacked to use an OP-TEE TA to decrypt the stream
into protected DMA-bufs which are consumed by the kmssink.

The primitive QEMU tests from previous patch sets can be tested on RockPi
in the same way using:
xtest --sdp-basic

The primitive tests are tested on QEMU with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml \
        -b prototype/sdp-v10
repo sync -j8
cd build
make toolchains -j$(nproc)
make SPMC_AT_EL=1 all -j$(nproc)
make SPMC_AT_EL=1 run-only
# login and at the prompt:
xtest --sdp-basic

The SPMC_AT_EL=1 parameter configures the build with FF-A and an SPMC at
S-EL1 inside OP-TEE. The parameter can be changed to SPMC_AT_EL=n to test
without FF-A using the original SMC ABI instead. Please remember to do
%make arm-tf-clean
for TF-A to be rebuilt properly using the new configuration.

https://optee.readthedocs.io/en/latest/building/prerequisites.html
list dependencies required to build the above.

The primitive tests are pretty basic, mostly checking that a Trusted
Application in the secure world can access and manipulate the memory. There
are also some negative tests for out of bounds buffers, etc.

Thanks,
Jens

Changes since V9:
* Adding Sumit's R-B to "optee: sync secure world ABI headers"
* Update commit message as requested for "dma-buf: dma-heap: export
  declared functions".
* In "tee: implement protected DMA-heap":
  - add the hidden config option TEE_DMABUF_HEAPS to tell if the TEE
    subsystem can support DMA heaps
  - add a pfn_valid() to check that the passed physical address can be
    used by __pfn_to_page() and friends
  - remove the memremap() call, the caller is should do that instead if
    needed
* In "tee: add tee_shm_alloc_dma_mem()" guard the calls to
  dma_alloc_pages() and dma_free_pages() with TEE_DMABUF_HEAPS to avoid
  linking errors in some configurations
* In "optee: support protected memory allocation":
  - add the hidden config option OPTEE_STATIC_PROTMEM_POOL to tell if the
    driver can support a static protected memory pool
  - optee_protmem_pool_init() is slightly refactored to make the patches
    that follow easier
  - Call devm_memremap() before calling tee_protmem_static_pool_alloc()

Changes since V8:
* Using dma_alloc_pages() instead of cma_alloc() so the direct dependency on
  CMA can be removed together with the patches
  "cma: export cma_alloc() and cma_release()" and
  "dma-contiguous: export dma_contiguous_default_area". The patch
* Renaming the patch "tee: add tee_shm_alloc_cma_phys_mem()" to
  "tee: add tee_shm_alloc_dma_mem()"
* Setting DMA mask for the OP-TEE TEE device based on input from the secure
  world instead of relying on the parent device so following patches are
  removed: "tee: tee_device_alloc(): copy dma_mask from parent device" and
  "optee: pass parent device to tee_device_alloc()".
* Adding Sumit Garg's R-B to "tee: refactor params_from_user()"
* In the patch "tee: implement protected DMA-heap", map the physical memory
  passed to tee_protmem_static_pool_alloc().

Changes since V7:
* Adding "dma-buf: dma-heap: export declared functions",
  "cma: export cma_alloc() and cma_release()", and
  "dma-contiguous: export dma_contiguous_default_area" to export the symbols
  needed to keep the TEE subsystem as a load module.
* Removing CONFIG_TEE_DMABUF_HEAP and CONFIG_TEE_CMA since they aren't
  needed any longer.
* Addressing review comments in "optee: sync secure world ABI headers"
* Better align protected memory pool initialization between the smc-abi and
  ffa-abi parts of the optee driver.
* Removing the patch "optee: account for direction while converting parameters"

Changes since V6:
* Restricted memory is now known as protected memory since to use the same
  term as https://docs.vulkan.org/guide/latest/protected.html. Update all
  patches to consistently use protected memory.
* In "tee: implement protected DMA-heap" add the hidden config option
  TEE_DMABUF_HEAP to tell if the DMABUF_HEAPS functions are available
  for the TEE subsystem
* Adding "tee: refactor params_from_user()", broken out from the patch
  "tee: new ioctl to a register tee_shm from a dmabuf file descriptor"
* For "tee: new ioctl to a register tee_shm from a dmabuf file descriptor":
  - Update commit message to mention protected memory
  - Remove and open code tee_shm_get_parent_shm() in param_from_user_memref()
* In "tee: add tee_shm_alloc_cma_phys_mem" add the hidden config option
  TEE_CMA to tell if the CMA functions are available for the TEE subsystem
* For "tee: tee_device_alloc(): copy dma_mask from parent device" and
  "optee: pass parent device to tee_device_alloc", added
  Reviewed-by: Sumit Garg <sumit.garg@kernel.org>

Changes since V5:
* Removing "tee: add restricted memory allocation" and
  "tee: add TEE_IOC_RSTMEM_FD_INFO"
* Adding "tee: implement restricted DMA-heap",
  "tee: new ioctl to a register tee_shm from a dmabuf file descriptor",
  "tee: add tee_shm_alloc_cma_phys_mem()",
  "optee: pass parent device to tee_device_alloc()", and
  "tee: tee_device_alloc(): copy dma_mask from parent device"
* The two TEE driver OPs "rstmem_alloc()" and "rstmem_free()" are replaced
  with a struct tee_rstmem_pool abstraction.
* Replaced the the TEE_IOC_RSTMEM_ALLOC user space API with the DMA-heap API

Changes since V4:
* Adding the patch "tee: add TEE_IOC_RSTMEM_FD_INFO" needed by the
  GStreamer demo
* Removing the dummy CPU access and mmap functions from the dma_buf_ops
* Fixing a compile error in "optee: FF-A: dynamic restricted memory allocation"
  reported by kernel test robot <lkp@intel.com>

Changes since V3:
* Make the use_case and flags field in struct tee_shm u32's instead of
  u16's
* Add more description for TEE_IOC_RSTMEM_ALLOC in the header file
* Import namespace DMA_BUF in module tee, reported by lkp@intel.com
* Added a note in the commit message for "optee: account for direction
  while converting parameters" why it's needed
* Factor out dynamic restricted memory allocation from
  "optee: support restricted memory allocation" into two new commits
  "optee: FF-A: dynamic restricted memory allocation" and
  "optee: smc abi: dynamic restricted memory allocation"
* Guard CMA usage with #ifdef CONFIG_CMA, effectively disabling dynamic
  restricted memory allocate if CMA isn't configured

Changes since the V2 RFC:
* Based on v6.12
* Replaced the flags for SVP and Trusted UID memory with a u32 field with
  unique id for each use case
* Added dynamic allocation of restricted memory pools
* Added OP-TEE ABI both with and without FF-A for dynamic restricted memory
* Added support for FF-A with FFA_LEND

Changes since the V1 RFC:
* Based on v6.11
* Complete rewrite, replacing the restricted heap with TEE_IOC_RSTMEM_ALLOC

Changes since Olivier's post [2]:
* Based on Yong Wu's post [1] where much of dma-buf handling is done in
  the generic restricted heap
* Simplifications and cleanup
* New commit message for "dma-buf: heaps: add Linaro restricted dmabuf heap
  support"
* Replaced the word "secure" with "restricted" where applicable




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

 drivers/dma-buf/dma-heap.c        |   3 +
 drivers/tee/Kconfig               |   5 +
 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/Kconfig         |   5 +
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/core.c          |  10 +
 drivers/tee/optee/ffa_abi.c       | 147 +++++++++-
 drivers/tee/optee/optee_ffa.h     |  27 +-
 drivers/tee/optee/optee_msg.h     |  84 +++++-
 drivers/tee/optee/optee_private.h |  15 +-
 drivers/tee/optee/optee_smc.h     |  37 ++-
 drivers/tee/optee/protmem.c       | 335 +++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 142 ++++++++-
 drivers/tee/tee_core.c            | 155 +++++++---
 drivers/tee/tee_heap.c            | 472 ++++++++++++++++++++++++++++++
 drivers/tee/tee_private.h         |  16 +
 drivers/tee/tee_shm.c             | 189 +++++++++++-
 include/linux/tee_core.h          |  71 +++++
 include/linux/tee_drv.h           |  10 +
 include/uapi/linux/tee.h          |  31 ++
 20 files changed, 1689 insertions(+), 67 deletions(-)
 create mode 100644 drivers/tee/optee/protmem.c
 create mode 100644 drivers/tee/tee_heap.c


base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.43.0

