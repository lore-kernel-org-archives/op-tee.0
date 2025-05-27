Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254A2C54ED1
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 15:07:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5391443E2E
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 15:07:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IDDjAX7A;
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DDB9242F06
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 15:07:32 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-605ff8aa9d2so726122eaf.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748358452; x=1748963252; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HvNpqBKFOVDi+Mx9KGaepBPynHnQJMRXklI5JhKtbg=;
        b=IDDjAX7APo9iS0m2pLsMpGrRZH0ZzBfM91QCkgqemBsHyUDoeGXw+jp+9ESHXSiWIi
         RyJCwq22SuRlQHpc+4ZrXfXvxvGzfN4A/RX7UWVc9Wjc7WWFYgnx0FbOVWU2GEEMirLc
         UjyryJ5zlLklnKQsAMTjiUq2ndy5DsruV5GateBrSq661yXNkRs9wlK4k8wyAejC2z6T
         VXmL+lMd9U0vwEIpAmQbcZjkFAwuYzk8DmBMh5GOpTvcguW1ubsAuYa2UZBm/Jxi/WWT
         ZGsuzNEBXojyJO1WQtwFdkkoDzXApqg3tpJ39RfYSN78Rw9G4R/JISB8FIIFRLYbni2N
         GtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748358452; x=1748963252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HvNpqBKFOVDi+Mx9KGaepBPynHnQJMRXklI5JhKtbg=;
        b=pASZByTdDI+Okezt2a8sE5xAx7LrnJhOQYqpUmMgjso5e3+MN3K9zJgv2ve66eFM8u
         we4WtN3xBY3ym1vDTdDr93yXjsNuv7o81OGAEicnsrOM0l1+zGUUqywPABXY31vqG29V
         K2cenDMMweS7gvqlyzT+t75qUcANCg2APIv5XIvyADvA5iOFloJZxauhzRi9JcjSkmSr
         bDt7zPh+DQ34AfY8Tufu1ieZUHdwX3R1VJGGU3YGULRImDamBFHS6Ke1b52ALaKu8eEW
         CC7AtkXm5DPmUoAjV7pCBIHK1bO6S5c50ESHBGC8qIjRRzac21+SUxowYG4C3NF9Iiyy
         0gmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwxMgAZYISdJ2t2KQRvVaf1WKGSqIDHniXSH6WLJqD+J3x+e47RcuCIb0XXeUUCqCQIjlq9S8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyKNMtMdM3xe6abG8JXRN/PAFqR/SPsygp6WxDpRp4g5c3vuX3g
	0MbgX+wDPXWtT3ylrdXfXW4m7oRlfc5VKC9v6dj5I7J/eORPlX44CpCE71MW9Qxu3INo26uWro/
	I68mpc67jCpLZ3qo0wOH0bFjfXNxaL3/2brGWTQkEa9Ze
X-Gm-Gg: ASbGncv8ZRsqufGnu57A2X1sXn98oyEIngU2xE4a492ZXEtxyjm5TLGms9sm0PMgpTT
	FNS2dZEoL095/b2GFyh0uwBMpR3f6jF7ENxDGe78gAKkf730sUueXlUPlkyjmT0IXajVGZPdWgX
	CnKSq1ZAExIsQTeLnXy2cWGmu99/hX88IX5A==
X-Google-Smtp-Source: AGHT+IHcnwyoLk78Sdyqna09vDLwno8N4DKtCoMRIDEgmxMn5EJ8+I+135oFuaEbt0jukPgDX+G63PqFO04gyL6xVSo=
X-Received: by 2002:a05:6820:2610:b0:5fe:9edb:eafe with SMTP id
 006d021491bc7-60b9fba1696mr6694046eaf.5.1748358452253; Tue, 27 May 2025
 08:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-9-jens.wiklander@linaro.org> <aDQhn9_fezC42GwS@sumit-X1>
In-Reply-To: <aDQhn9_fezC42GwS@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 27 May 2025 17:07:18 +0200
X-Gm-Features: AX0GCFv4xwxS381XBNqHvZmFreXW7Y4SbgNJb3O8wPMOP2rKatTJj8xDdz14iuA
Message-ID: <CAHUa44HFPu87JCHDxu6HWAp6YaXrHFwi55JHTb9X=JvTz30XpA@mail.gmail.com>
Subject: Re: [PATCH v9 8/9] optee: FF-A: dynamic protected memory allocation
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.42:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.42:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DDB9242F06
Message-ID-Hash: 5W4IOJL3WCIBKRQXWFLZWEMPS7P7EDRU
X-Message-ID-Hash: 5W4IOJL3WCIBKRQXWFLZWEMPS7P7EDRU
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5W4IOJL3WCIBKRQXWFLZWEMPS7P7EDRU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, May 26, 2025 at 10:09=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Tue, May 20, 2025 at 05:16:51PM +0200, Jens Wiklander wrote:
> > Add support in the OP-TEE backend driver dynamic protected memory
> > allocation with FF-A.
> >
> > The protected memory pools for dynamically allocated protected memory
> > are instantiated when requested by user-space. This instantiation can
> > fail if OP-TEE doesn't support the requested use-case of protected
> > memory.
> >
> > Restricted memory pools based on a static carveout or dynamic allocatio=
n
> > can coexist for different use-cases. We use only dynamic allocation wit=
h
> > FF-A.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
[...]
> > +static int optee_ffa_protmem_pool_init(struct optee *optee, u32 sec_ca=
ps)
> > +{
> > +     enum tee_dma_heap_id id =3D TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
> > +     struct tee_protmem_pool *pool;
> > +     int rc =3D 0;
> > +
> > +     if (sec_caps & OPTEE_FFA_SEC_CAP_PROTMEM) {
> > +             pool =3D optee_protmem_alloc_dyn_pool(optee, id);
> > +             if (IS_ERR(pool))
> > +                     return PTR_ERR(pool);
> > +
> > +             rc =3D tee_device_register_dma_heap(optee->teedev, id, po=
ol);
> > +             if (rc)
> > +                     pool->ops->destroy_pool(pool);
> > +     }
> > +
> > +     return rc;
> > +}
> > +
> >  static int optee_ffa_probe(struct ffa_device *ffa_dev)
> >  {
> >       const struct ffa_notifier_ops *notif_ops;
> > @@ -918,7 +1057,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_=
dev)
> >                                 optee);
> >       if (IS_ERR(teedev)) {
> >               rc =3D PTR_ERR(teedev);
> > -             goto err_free_pool;
> > +             goto err_free_shm_pool;
> >       }
> >       optee->teedev =3D teedev;
> >
> > @@ -965,6 +1104,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_=
dev)
> >                              rc);
> >       }
> >
> > +     if (optee_ffa_protmem_pool_init(optee, sec_caps))
>
> Let's add a Kconfig check for DMABUF heaps support here as well.

I prefer complaining in the log if there's something wrong with the
configuration.

>
> > +             pr_info("Protected memory service not available\n");
> > +
[...]
> > +static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
> > +{
> > +     int rc;
> > +
> > +     rp->protmem =3D tee_shm_alloc_dma_mem(rp->optee->ctx, rp->page_co=
unt);
> > +     if (IS_ERR(rp->protmem)) {
> > +             rc =3D PTR_ERR(rp->protmem);
> > +             goto err_null_protmem;
> > +     }
> > +
> > +     /*
> > +      * TODO unmap the memory range since the physical memory will
> > +      * become inaccesible after the lend_protmem() call.
>
> Let's ellaborate this comment to also say that unmap isn't strictly
> needed here in case a platform supports hypervisor in EL2 which can
> perform unmapping as part for memory lending to secure world as that
> will avoid any cache pre-fetch of memory lent to secure world.
>
> With that I can live with this as a ToDo in kernel which can be
> implemented once we see platforms requiring this change to happen.

OK, I'll add something.

[...]
> > +
> > +struct tee_protmem_pool *optee_protmem_alloc_dyn_pool(struct optee *op=
tee,
> > +                                                   enum tee_dma_heap_i=
d id)
> > +{
> > +     struct optee_protmem_dyn_pool *rp;
> > +     u32 use_case =3D id;
>
> Here we can get rid of redundant extra variable with s/id/use_case/.

OK, I'll update.

Cheers,
Jens
