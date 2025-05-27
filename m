Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2B1C54ED1
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 14:33:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 09ABB43079
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 14:33:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n3SH+rke;
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7EDB842E82
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 14:33:04 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-afc857702d1so2308069a12.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748356383; x=1748961183; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRDZ/LCrpqxKUX7yBP1lPoeGMYrX58ozdV1M2xTcqr0=;
        b=n3SH+rkeP68uABTZKNJMydunJ7P62oKRAfBoZB2ENu4KZ9UC57hpC+aCPqVUb0xWqV
         ztE3Jh33NuPhrAwmtbheW/ccYTFrAaBQGzOR9923dedjAsDHsj7ZxNoC2G0p3zZgntUS
         f/aoIOheAxChLGHTB4FgrtSorKphTPEMsyznPAK2oFycGizgvLI4ACbIIfKOZlXodwoj
         s5YgngD7mGkuiCp7+kM7+5IU8VyZD57gcsovOIqxXGJB/4f+eaz6yC7bIEJX/HBmT7KI
         OsnRIM9Ykj6mip7n2HJn2Oau0Sp/1acz4NQ/ND/RW1GgZCefvIon4DEoY+RJRt5YayVx
         zHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748356383; x=1748961183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRDZ/LCrpqxKUX7yBP1lPoeGMYrX58ozdV1M2xTcqr0=;
        b=m1yw/3ZBkprdlCffH8OjESQZIqDopEwwQNCI3NLKNLE2abcaV1GUkt7CGZTbsIyagE
         xHF02K2z0qTYl9pnpAXAEReae9OgvXFua0+mdwb5cM8cDGMphoSsdSTYExhEEr0xKmjh
         2noAeXy7Nyxa6CGRXD+iBRxBIsvEcQrkwUVMIRCCb5HdDdLvz7XJcGHY2tRjOMURuqRH
         R7Mg/JJqrUduPIy4EkteU238BBCBJcYgSKALaR0foIgS7pNpe19BfZHzl3day5Qto/UE
         f4J8G3jpX9dp9TSHhSqNVJAL73bjaeQ+j2ksD+QzwSsLOHuT2+J8kNdtvTLqWG1mAvBy
         DbLw==
X-Forwarded-Encrypted: i=1; AJvYcCUVmlAiV0eqoUN2vizTQfWLFqvWGpl4TH2yf3DwFPrCtwIOQQ0+YuVegvCR77fYlobt38YKiXk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyL7K1wFsNl2ItVIIxhVvGr9zYbcv7ZSR9yvPIIdjbUyyXi4RGM
	0231camrsbebHt0tD2bfsifQ9TgI7fPhH/cwhEGQg4LAITgQYdImeCfQubqCWIa764XeV7NZ2x+
	wpZUrxe8TQWrHtH4B/gdNF0LvLlYe5HuOKfdMdSPJDyOLPEUMt6hDEro=
X-Gm-Gg: ASbGncuEPrguFIqDAon3w8Pmdw5egZCVCmpDpYLY02u8JlcNyZ7iF6RXJCBaAGbvXs5
	05oN9+Yjg/9T9LumRjAwUh9/aw74k4adUqLHdCqLMkjYBbpiheHDioUNMTMzi/XhyGGOxoy1dn5
	ZxclvNd4ooRfl4+xYjQRRMyLmLIbtZWdbF+g==
X-Google-Smtp-Source: AGHT+IG+kMuaBsaWSffxs+4dopBi6c2UidFw8vqj94comKMts1HGzvEPJpkPt4sT0Oi5flOvsO/w4xlAVEH4ZILhoBI=
X-Received: by 2002:a05:6808:6c93:b0:403:35ba:f91a with SMTP id
 5614622812f47-406468ba8c7mr7824256b6e.34.1748356373410; Tue, 27 May 2025
 07:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-8-jens.wiklander@linaro.org> <aDQZN-frPnr1_N5I@sumit-X1>
In-Reply-To: <aDQZN-frPnr1_N5I@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 27 May 2025 16:32:42 +0200
X-Gm-Features: AX0GCFtCRIMnpa06u8yxs_HtV-u6PU01-LbWY3-lo5Z1TuKmqqUniPvzQcB1mdY
Message-ID: <CAHUa44FHav67VAQK7o-S3Xhx-j_VypAX9Ya0dATty7RhdCbgJA@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] optee: support protected memory allocation
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.215.180:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_TWELVE(0.00)[22];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.180:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7EDB842E82
Message-ID-Hash: PCQUB5J7MCJKX7IPK4VCEPAZD7RGSEAH
X-Message-ID-Hash: PCQUB5J7MCJKX7IPK4VCEPAZD7RGSEAH
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PCQUB5J7MCJKX7IPK4VCEPAZD7RGSEAH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, May 26, 2025 at 9:33=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Tue, May 20, 2025 at 05:16:50PM +0200, Jens Wiklander wrote:
> > Add support in the OP-TEE backend driver for protected memory
> > allocation. The support is limited to only the SMC ABI and for secure
> > video buffers.
> >
> > OP-TEE is probed for the range of protected physical memory and a
> > memory pool allocator is initialized if OP-TEE have support for such
> > memory.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/core.c          | 10 +++++++
> >  drivers/tee/optee/optee_private.h |  2 ++
> >  drivers/tee/optee/smc_abi.c       | 45 +++++++++++++++++++++++++++++--
> >  3 files changed, 55 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index c75fddc83576..4b14a7ac56f9 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -56,6 +56,15 @@ int optee_rpmb_intf_rdev(struct notifier_block *intf=
, unsigned long action,
> >       return 0;
> >  }
> >
> > +int optee_set_dma_mask(struct optee *optee, u_int pa_width)
> > +{
> > +     u64 mask =3D DMA_BIT_MASK(min(64, pa_width));
> > +
> > +     optee->teedev->dev.dma_mask =3D &optee->teedev->dev.coherent_dma_=
mask;
> > +
> > +     return dma_set_mask_and_coherent(&optee->teedev->dev, mask);
> > +}
> > +
> >  static void optee_bus_scan(struct work_struct *work)
> >  {
> >       WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > @@ -181,6 +190,7 @@ void optee_remove_common(struct optee *optee)
> >       tee_device_unregister(optee->supp_teedev);
> >       tee_device_unregister(optee->teedev);
> >
> > +     tee_device_unregister_all_dma_heaps(optee->teedev);
> >       tee_shm_pool_free(optee->pool);
> >       optee_supp_uninit(&optee->supp);
> >       mutex_destroy(&optee->call_queue.mutex);
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index dc0f355ef72a..5e3c34802121 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -272,6 +272,8 @@ struct optee_call_ctx {
> >
> >  extern struct blocking_notifier_head optee_rpmb_intf_added;
> >
> > +int optee_set_dma_mask(struct optee *optee, u_int pa_width);
> > +
> >  int optee_notif_init(struct optee *optee, u_int max_key);
> >  void optee_notif_uninit(struct optee *optee);
> >  int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index f0c3ac1103bb..f3cae8243785 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1584,6 +1584,42 @@ static inline int optee_load_fw(struct platform_=
device *pdev,
> >  }
> >  #endif
> >
> > +static int optee_protmem_pool_init(struct optee *optee)
> > +{
> > +     enum tee_dma_heap_id heap_id =3D TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
> > +     struct tee_protmem_pool *pool;
> > +     int rc;
> > +
> > +     if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM) {
> > +             union {
> > +                     struct arm_smccc_res smccc;
> > +                     struct optee_smc_get_protmem_config_result result=
;
> > +             } res;
> > +
> > +             optee->smc.invoke_fn(OPTEE_SMC_GET_PROTMEM_CONFIG, 0, 0, =
0, 0,
> > +                                  0, 0, 0, &res.smccc);
> > +             if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
> > +                     pr_err("Secure Data Path service not available\n"=
);
> > +                     return 0;
> > +             }
> > +             rc =3D optee_set_dma_mask(optee, res.result.pa_width);
> > +             if (!rc)
> > +                     pool =3D tee_protmem_static_pool_alloc(res.result=
.start,
> > +                                                          res.result.s=
ize);
> > +             if (IS_ERR(pool))
> > +                     return PTR_ERR(pool);
> > +
> > +             rc =3D tee_device_register_dma_heap(optee->teedev, heap_i=
d, pool);
> > +             if (rc)
> > +                     goto err;
> > +     }
> > +
> > +     return 0;
> > +err:
> > +     pool->ops->destroy_pool(pool);
> > +     return rc;
> > +}
> > +
> >  static int optee_probe(struct platform_device *pdev)
> >  {
> >       optee_invoke_fn *invoke_fn;
> > @@ -1679,7 +1715,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >       optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
> >       if (!optee) {
> >               rc =3D -ENOMEM;
> > -             goto err_free_pool;
> > +             goto err_free_shm_pool;
> >       }
> >
> >       optee->ops =3D &optee_ops;
> > @@ -1752,6 +1788,10 @@ static int optee_probe(struct platform_device *p=
dev)
> >               pr_info("Asynchronous notifications enabled\n");
> >       }
> >
> > +     rc =3D optee_protmem_pool_init(optee);
>
> Here we should do a Kconfig check for CONFIG_DMABUF_HEAPS so that we
> don't proceed any further with initialization.

Why? If OP-TEE is configured for protected memory but the kernel
isn't, something isn't right, and a print could be useful.

Cheers,
Jens

>
> Rest looks good to me.
>
> -Sumit
>
> > +     if (rc)
> > +             goto err_notif_uninit;
> > +
> >       /*
> >        * Ensure that there are no pre-existing shm objects before enabl=
ing
> >        * the shm cache so that there's no chance of receiving an invali=
d
> > @@ -1787,6 +1827,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >               optee_disable_shm_cache(optee);
> >       optee_smc_notif_uninit_irq(optee);
> >       optee_unregister_devices();
> > +     tee_device_unregister_all_dma_heaps(optee->teedev);
> >  err_notif_uninit:
> >       optee_notif_uninit(optee);
> >  err_close_ctx:
> > @@ -1803,7 +1844,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >       tee_device_unregister(optee->teedev);
> >  err_free_optee:
> >       kfree(optee);
> > -err_free_pool:
> > +err_free_shm_pool:
> >       tee_shm_pool_free(pool);
> >       if (memremaped_shm)
> >               memunmap(memremaped_shm);
> > --
> > 2.43.0
> >
