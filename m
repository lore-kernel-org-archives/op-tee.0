Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A89ACAC582
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 10:17:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 628034FB65
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 10:17:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JtQyUVQe;
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4A15A42EA5
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 10:16:50 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-621bae93444so624495eaf.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757672209; x=1758277009; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np92MCLMIpSqqXYurAjsStWUduzDAztZdMghYtL+tng=;
        b=JtQyUVQeE54Ynz6i/XcJ70nuSPh+YWaait07a29rK87hGMfZ31x6C3IuFgYMH54aGb
         SDw/Ham04j3J6fqDpZhENSuYbBxE1mpz+LBEaeOmalg5dr985ZPejZfHGkFFZZmFH9tK
         bAsBVUwWCwvAaV2sDHaLMCiUzCt5xRkysUDRFkzQF0SGQXA9SjGKvGpaP9WDWZa3bbC1
         DQhjAbt7hcXUfWBW+C7tNpRmhguJ+zewATu1rktd2Cq9uwltTn2fD0FJtlFqsgVrIgKx
         X9jZ9HYJDq+yaW6SoYCGX3z9FohbyTmwaw4/qWIbKNjTJIgKnD/EbUzHS32vyEWwmf6/
         lC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672209; x=1758277009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np92MCLMIpSqqXYurAjsStWUduzDAztZdMghYtL+tng=;
        b=wZXErH+ZGdzwouAIOEcWv6MNuKE0DGy1VKohnKBuLVw1WSBLXWr6RYJazXktES3YUg
         Zo3pRCt+pFlV3TsCHrOtPx8Fx5ylb+TjmYMcDxM+hleF/q7lKuLNLrdo2KBf3mYzYlfc
         8RbFRD+uOX5n8HeK7mnQKdrx6BpU8wrz0J1hUicrWwBJsiuOERs3HVdwsODUIckvlp7m
         P6WbsZDsGqI6k7yoxN0HVggHWYL7olmNk5BRxV+aCTDfs2wohv2JrH6JI3qwcKgWtC2U
         6JaHfCX/6C5Xafph70lI56DcccPSDpXPyMmSJqz+NiszKomLYAYD6j8YZ1SPO0G0N2Xj
         MC+w==
X-Forwarded-Encrypted: i=1; AJvYcCU+0HXH2Ta1xNVl9621VN3EONqf9PKxA3ei/T6nl23B1zaVTt78fH5zJtg36jNvRtEKzJWerOU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyeXus/ArcVGBeMTFrU5LGasFCYAbY005EiFLkg/LIN0dN7V9wd
	FVasl6VycocIE1pTPHh1qDiJgGIXPW2nTo44k2rdjNs98iqR1qM79g+SntMcNGzddJpe4VKAMOh
	76zlOUObXBOzO0hZsmtKKTTbhCCT1L4UwXt3xbJS8wDHA
X-Gm-Gg: ASbGncvee31LBsF672V0qc9fhpf8vJ1JTfXGlujHA+/CRnEVRlpoP3e/CXDTEg3zuA0
	eHOtqwU4KhYC2B35PFZlBhkN12R3jzDomZiwqlIBdGqsQn9BoRKZyRNcI44mApUBTVO5DYCz71h
	LDS3Wdpb4e6HB65J5LA5WEYnOggoFzvB8fp2hJ7SAsAfE8pC+FX4NhCICc3ZF8rtTC5AoPSmJE9
	kSDkcTYTTY+LSq5cwI=
X-Google-Smtp-Source: AGHT+IGS5N1UmLdsuE07lZ/S7H/uqY8ApRRdv9LIa7w7dmIh048yBoif8PGNnuNQoEwhkyX8AMx/1GhdEocCaUPJzjc=
X-Received: by 2002:a05:6820:1508:b0:621:860f:fe6f with SMTP id
 006d021491bc7-621bed6ed43mr1199525eaf.6.1757672209301; Fri, 12 Sep 2025
 03:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
In-Reply-To: <20250911135007.1275833-1-jens.wiklander@linaro.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 12 Sep 2025 12:16:37 +0200
X-Gm-Features: Ac12FXxeSzrBj0Om7A_DbdAZW0T_dZoOlSetiIHXJL2m-uuUM4A3nBgvnyjvK2w
Message-ID: <CAHUa44H-CrwawWzMMGTG6qndK7iYnHK57ONYbJqMjOE=eiAsqQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/9] TEE subsystem for protected dma-buf allocations
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4A15A42EA5
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.45:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.161.45:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: O2S6OH5F3YFB6XOQCXTMALFJJ3WKUQN7
X-Message-ID-Hash: O2S6OH5F3YFB6XOQCXTMALFJJ3WKUQN7
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/O2S6OH5F3YFB6XOQCXTMALFJJ3WKUQN7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Sep 11, 2025 at 3:50=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> This patch set allocates the protected DMA-bufs from a DMA-heap
> instantiated from the TEE subsystem.
>
> The TEE subsystem handles the DMA-buf allocations since it is the TEE
> (OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QTEE) which sets up the
> protection for the memory used for the DMA-bufs.
>
> The DMA-heap uses a protected memory pool provided by the backend TEE
> driver, allowing it to choose how to allocate the protected physical
> memory.
>
> The allocated DMA-bufs must be imported with a new TEE_IOC_SHM_REGISTER_F=
D
> before they can be passed as arguments when requesting services from the
> secure world.
>
> Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
> Recording) have been identified so far to serve as examples of what can b=
e
> expected. The use-cases have predefined DMA-heap names,
> "protected,secure-video", "protected,trusted-ui", and
> "protected,secure-video-record". The backend driver registers protected
> memory pools for the use-cases it supports.
>
> Each use-case has its own protected memory pool since different use-cases
> require isolation from different parts of the system. A protected memory
> pool can be based on a static carveout instantiated while probing the TEE
> backend driver, or dynamically allocated from CMA (dma_alloc_pages()) and
> made protected as needed by the TEE.

After the small update from v11, I'm picking up this and aiming for
the next merge window.

Thanks,
Jens

>
> This can be tested on a RockPi 4B+ with the following steps:
> repo init -u https://github.com/jenswi-linaro/manifest.git -m rockpi4.xml=
 \
>         -b prototype/sdp-v12
> repo sync -j8
> cd build
> make toolchains -j$(nproc)
> make all -j$(nproc)
> # Copy ../out/rockpi4.img to an SD card and boot the RockPi from that
> # Connect a monitor to the RockPi
> # login and at the prompt:
> gst-launch-1.0 videotestsrc ! \
>         aesenc key=3D1f9423681beb9a79215820f6bda73d0f \
>                 iv=3De9aa8e834d8d70b7e0d254ff670dd718 serialize-iv=3Dtrue=
 ! \
>         aesdec key=3D1f9423681beb9a79215820f6bda73d0f ! \
>         kmssink
>
> The aesdec module has been hacked to use an OP-TEE TA to decrypt the stre=
am
> into protected DMA-bufs which are consumed by the kmssink.
>
> The primitive QEMU tests from previous patch sets can be tested on RockPi
> in the same way using:
> xtest --sdp-basic
>
> The primitive tests are tested on QEMU with the following steps:
> repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml=
 \
>         -b prototype/sdp-v12
> repo sync -j8
> cd build
> make toolchains -j$(nproc)
> make SPMC_AT_EL=3D1 all -j$(nproc)
> make SPMC_AT_EL=3D1 run-only
> # login and at the prompt:
> xtest --sdp-basic
>
> The SPMC_AT_EL=3D1 parameter configures the build with FF-A and an SPMC a=
t
> S-EL1 inside OP-TEE. The parameter can be changed to SPMC_AT_EL=3Dn to te=
st
> without FF-A using the original SMC ABI instead. Please remember to do
> %make arm-tf-clean
> for TF-A to be rebuilt properly using the new configuration.
>
> https://optee.readthedocs.io/en/latest/building/prerequisites.html
> list dependencies required to build the above.
>
> The primitive tests are pretty basic, mostly checking that a Trusted
> Application in the secure world can access and manipulate the memory. The=
re
> are also some negative tests for out of bounds buffers, etc.
>
> Thanks,
> Jens
>
> Changes since V11:
> * In "dma-buf: dma-heap: export declared functions":
>   - use EXPORT_SYMBOL_NS_GPL()
>   - Added TJ's R-B and Sumit's Ack
> * In "tee: implement protected DMA-heap", import the namespaces "DMA_BUF"
>   and "DMA_BUF_HEAP" as needed.
>
> Changes since V10:
> * Changed the new ABI OPTEE_MSG_CMD_GET_PROTMEM_CONFIG to report a list
>   of u32 memory attributes instead of u16 endpoints to make room for both
>   endpoint and access permissions in each entry.
> * In "tee: new ioctl to a register tee_shm from a dmabuf file descriptor"=
,
>   remove the unused path for DMA-bufs allocated by other means than the o=
n
>   in the TEE SS.
> * In "tee: implement protected DMA-heap", handle unloading of the
>   backend driver module implementing the heap. The heap is reference
>   counted and also calls tee_device_get() to guarantee that the module
>   remains available while the heap is instantiated.
> * In "optee: support protected memory allocation", use
>   dma_coerce_mask_and_coherent() instead of open-coding the function.
> * Added Sumit's R-B to
>   - "optee: smc abi: dynamic protected memory allocation"
>   - "optee: FF-A: dynamic protected memory allocation"
>   - "optee: support protected memory allocation"
>   - "tee: implement protected DMA-heap"
>   - "dma-buf: dma-heap: export declared functions"
>
> Changes since V9:
> * Adding Sumit's R-B to "optee: sync secure world ABI headers"
> * Update commit message as requested for "dma-buf: dma-heap: export
>   declared functions".
> * In "tee: implement protected DMA-heap":
>   - add the hidden config option TEE_DMABUF_HEAPS to tell if the TEE
>     subsystem can support DMA heaps
>   - add a pfn_valid() to check that the passed physical address can be
>     used by __pfn_to_page() and friends
>   - remove the memremap() call, the caller is should do that instead if
>     needed
> * In "tee: add tee_shm_alloc_dma_mem()" guard the calls to
>   dma_alloc_pages() and dma_free_pages() with TEE_DMABUF_HEAPS to avoid
>   linking errors in some configurations
> * In "optee: support protected memory allocation":
>   - add the hidden config option OPTEE_STATIC_PROTMEM_POOL to tell if the
>     driver can support a static protected memory pool
>   - optee_protmem_pool_init() is slightly refactored to make the patches
>     that follow easier
>   - Call devm_memremap() before calling tee_protmem_static_pool_alloc()
>
> Changes since V8:
> * Using dma_alloc_pages() instead of cma_alloc() so the direct dependency=
 on
>   CMA can be removed together with the patches
>   "cma: export cma_alloc() and cma_release()" and
>   "dma-contiguous: export dma_contiguous_default_area". The patch
> * Renaming the patch "tee: add tee_shm_alloc_cma_phys_mem()" to
>   "tee: add tee_shm_alloc_dma_mem()"
> * Setting DMA mask for the OP-TEE TEE device based on input from the secu=
re
>   world instead of relying on the parent device so following patches are
>   removed: "tee: tee_device_alloc(): copy dma_mask from parent device" an=
d
>   "optee: pass parent device to tee_device_alloc()".
> * Adding Sumit Garg's R-B to "tee: refactor params_from_user()"
> * In the patch "tee: implement protected DMA-heap", map the physical memo=
ry
>   passed to tee_protmem_static_pool_alloc().
>
> Changes since V7:
> * Adding "dma-buf: dma-heap: export declared functions",
>   "cma: export cma_alloc() and cma_release()", and
>   "dma-contiguous: export dma_contiguous_default_area" to export the symb=
ols
>   needed to keep the TEE subsystem as a load module.
> * Removing CONFIG_TEE_DMABUF_HEAP and CONFIG_TEE_CMA since they aren't
>   needed any longer.
> * Addressing review comments in "optee: sync secure world ABI headers"
> * Better align protected memory pool initialization between the smc-abi a=
nd
>   ffa-abi parts of the optee driver.
> * Removing the patch "optee: account for direction while converting param=
eters"
>
> Changes since V6:
> * Restricted memory is now known as protected memory since to use the sam=
e
>   term as https://docs.vulkan.org/guide/latest/protected.html. Update all
>   patches to consistently use protected memory.
> * In "tee: implement protected DMA-heap" add the hidden config option
>   TEE_DMABUF_HEAP to tell if the DMABUF_HEAPS functions are available
>   for the TEE subsystem
> * Adding "tee: refactor params_from_user()", broken out from the patch
>   "tee: new ioctl to a register tee_shm from a dmabuf file descriptor"
> * For "tee: new ioctl to a register tee_shm from a dmabuf file descriptor=
":
>   - Update commit message to mention protected memory
>   - Remove and open code tee_shm_get_parent_shm() in param_from_user_memr=
ef()
> * In "tee: add tee_shm_alloc_cma_phys_mem" add the hidden config option
>   TEE_CMA to tell if the CMA functions are available for the TEE subsyste=
m
> * For "tee: tee_device_alloc(): copy dma_mask from parent device" and
>   "optee: pass parent device to tee_device_alloc", added
>   Reviewed-by: Sumit Garg <sumit.garg@kernel.org>
>
> Changes since V5:
> * Removing "tee: add restricted memory allocation" and
>   "tee: add TEE_IOC_RSTMEM_FD_INFO"
> * Adding "tee: implement restricted DMA-heap",
>   "tee: new ioctl to a register tee_shm from a dmabuf file descriptor",
>   "tee: add tee_shm_alloc_cma_phys_mem()",
>   "optee: pass parent device to tee_device_alloc()", and
>   "tee: tee_device_alloc(): copy dma_mask from parent device"
> * The two TEE driver OPs "rstmem_alloc()" and "rstmem_free()" are replace=
d
>   with a struct tee_rstmem_pool abstraction.
> * Replaced the the TEE_IOC_RSTMEM_ALLOC user space API with the DMA-heap =
API
>
> Changes since V4:
> * Adding the patch "tee: add TEE_IOC_RSTMEM_FD_INFO" needed by the
>   GStreamer demo
> * Removing the dummy CPU access and mmap functions from the dma_buf_ops
> * Fixing a compile error in "optee: FF-A: dynamic restricted memory alloc=
ation"
>   reported by kernel test robot <lkp@intel.com>
>
> Changes since V3:
> * Make the use_case and flags field in struct tee_shm u32's instead of
>   u16's
> * Add more description for TEE_IOC_RSTMEM_ALLOC in the header file
> * Import namespace DMA_BUF in module tee, reported by lkp@intel.com
> * Added a note in the commit message for "optee: account for direction
>   while converting parameters" why it's needed
> * Factor out dynamic restricted memory allocation from
>   "optee: support restricted memory allocation" into two new commits
>   "optee: FF-A: dynamic restricted memory allocation" and
>   "optee: smc abi: dynamic restricted memory allocation"
> * Guard CMA usage with #ifdef CONFIG_CMA, effectively disabling dynamic
>   restricted memory allocate if CMA isn't configured
>
> Changes since the V2 RFC:
> * Based on v6.12
> * Replaced the flags for SVP and Trusted UID memory with a u32 field with
>   unique id for each use case
> * Added dynamic allocation of restricted memory pools
> * Added OP-TEE ABI both with and without FF-A for dynamic restricted memo=
ry
> * Added support for FF-A with FFA_LEND
>
> Changes since the V1 RFC:
> * Based on v6.11
> * Complete rewrite, replacing the restricted heap with TEE_IOC_RSTMEM_ALL=
OC
>
> Changes since Olivier's post [2]:
> * Based on Yong Wu's post [1] where much of dma-buf handling is done in
>   the generic restricted heap
> * Simplifications and cleanup
> * New commit message for "dma-buf: heaps: add Linaro restricted dmabuf he=
ap
>   support"
> * Replaced the word "secure" with "restricted" where applicable
>
> Etienne Carriere (1):
>   tee: new ioctl to a register tee_shm from a dmabuf file descriptor
>
> Jens Wiklander (8):
>   optee: sync secure world ABI headers
>   dma-buf: dma-heap: export declared functions
>   tee: implement protected DMA-heap
>   tee: refactor params_from_user()
>   tee: add tee_shm_alloc_dma_mem()
>   optee: support protected memory allocation
>   optee: FF-A: dynamic protected memory allocation
>   optee: smc abi: dynamic protected memory allocation
>
>  drivers/dma-buf/dma-heap.c        |   4 +
>  drivers/tee/Kconfig               |   5 +
>  drivers/tee/Makefile              |   1 +
>  drivers/tee/optee/Kconfig         |   5 +
>  drivers/tee/optee/Makefile        |   1 +
>  drivers/tee/optee/core.c          |   7 +
>  drivers/tee/optee/ffa_abi.c       | 146 ++++++++-
>  drivers/tee/optee/optee_ffa.h     |  27 +-
>  drivers/tee/optee/optee_msg.h     |  84 ++++-
>  drivers/tee/optee/optee_private.h |  15 +-
>  drivers/tee/optee/optee_smc.h     |  37 ++-
>  drivers/tee/optee/protmem.c       | 335 ++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       | 141 ++++++++-
>  drivers/tee/tee_core.c            | 158 +++++++---
>  drivers/tee/tee_heap.c            | 500 ++++++++++++++++++++++++++++++
>  drivers/tee/tee_private.h         |  14 +
>  drivers/tee/tee_shm.c             | 157 +++++++++-
>  include/linux/tee_core.h          |  59 ++++
>  include/linux/tee_drv.h           |  10 +
>  include/uapi/linux/tee.h          |  31 ++
>  20 files changed, 1670 insertions(+), 67 deletions(-)
>  create mode 100644 drivers/tee/optee/protmem.c
>  create mode 100644 drivers/tee/tee_heap.c
>
>
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> --
> 2.43.0
>
