Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14606C71157
	for <op-tee@archiver.kernel.org>; Wed, 18 Jun 2025 07:03:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 40A0C42FC9
	for <op-tee@archiver.kernel.org>; Wed, 18 Jun 2025 07:03:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YSQei0fc;
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8B4983E957
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Jun 2025 07:03:12 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-735a9e65471so4097435a34.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 18 Jun 2025 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750230192; x=1750834992; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8SFTx5dPQSfu8ZL7Jn6th2YUqqrMFvLWLfJm2Kbj0c=;
        b=YSQei0fcUY3riifvATgF/jiIb2ThVRQr4OrWG8oiW5jSdpyNMBK/wWKYJ8ELb5fF7Y
         t0qJ4CdaVyQLHxXc5dDHIg7Vi/z4HzbjrCF9EjCW2Lwuu3wVcJdawwmJ3xaJGb9EbWGU
         dJGpOZXIYlg3gFj+r89KHmFXDd833oo2jL4XcnqBAQhX7ouKWt0SraLRs4ff0oFbjttJ
         kp745e5IPyPmXngsatRhDeY4CW5+nelOM78Iaq5JKLlBi4UUrL3twuJYbqLfe+vK9YwM
         E4RQJy+i5GwwrFmtDj8nlIVZDUxoh9ZAe79tebPnoC5Ku3pH2IkJTC9M6YcddPsB/mtj
         dyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750230192; x=1750834992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8SFTx5dPQSfu8ZL7Jn6th2YUqqrMFvLWLfJm2Kbj0c=;
        b=Gj/ie8+EyFrVNfRXQDefqdDQieCzhwyhfK/+0OfvrLNFR4C4+Cif8JsGRveOGK4/XC
         fGbwAtqDu/Iz7cHTD4dyX3aoC2FzSQ3nFyvhpVW4DHM1sOeXgcFFjbdedogPD89B0iiE
         Gx4oWVnf/LHxWGans/XSxOa0XJvz8QhDXxsrW/rQ8W/ZAc7JYwkGCLqmZoQUG8pLOgCP
         NrA7yGacxJ4oAbXwtXDKLKZdC7cVmBDTyOYn2U8kZo1QvHeBHepkrP2OWcNnWjV5tOks
         q9YQ2DeTGfN50dJU6Oamgsvd/eX4WpgH/TKus2OSg9Rip/pZb+KqnANEXmjXNOq7tkGu
         ZO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSGHL35jI3hTbuS5MP4Zhmkrsy4Dx7wUqjclCtK2TX4LXzq2dFeK5L0Gtp5x6fFumNuxwKNvU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxnG0PxJ8iLl1lA+datPZgpMEowqB/FmS6WFPR3EIdoSKDZounI
	9YRjeWI7Vgj1iMVY3mdiMK3n/5fUY5LoqhFnGiXFgto30vOQ5v5Qq57BNTbgmsi8mr8v1OO3yfo
	s5y+evnnuIVhjYo01BrWajH5Jx83T/ST1Vg4+SzJgukDy
X-Gm-Gg: ASbGncsU/uPPxY3Sco1XZrf8XisIFw9DmKw+gmIcPuzcqwCuZTqyGuhRNmzDfyRsDqX
	sEsQNvE0Dn1PmQ0LwGvFzctsrGpPBW1ftuEf6mhnviD1rLCiz0Yh93c6oYbSaPa/x92PKux/3ol
	0F/Gh7UgOY5xiUgsTzHuZsRnxooO8p3rEtkd93Fv3n+i0=
X-Google-Smtp-Source: AGHT+IEYIeVC/jTVYCSxf/dGhqeDr1KHxYiJwAAX/5hmURj3RcHrh9D5I5KutnxKn6tUumkHdJ/1wa42+SytUsf+26I=
X-Received: by 2002:a05:6830:40c4:b0:72b:946e:ccc7 with SMTP id
 46e09a7af769-73a36091cbemr11291390a34.0.1750230191671; Wed, 18 Jun 2025
 00:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-7-jens.wiklander@linaro.org> <aFFSWDiVsxA1CbCX@sumit-X1>
In-Reply-To: <aFFSWDiVsxA1CbCX@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 18 Jun 2025 09:03:00 +0200
X-Gm-Features: AX0GCFvrA5yXpBPMnqH5JcYKZyhNKjMM65-tKAnroIXskFJp4M6WI4XH2u_9JeE
Message-ID: <CAHUa44HP5EbURyLCmawMLc0d5jz1oTQZ53V1w2h0-ngUC2hbEw@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] tee: add tee_shm_alloc_dma_mem()
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8B4983E957
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.46:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.210.46:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.46:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: INW5TSC6ICV7RDJQCY6SUF3E5V66LL3L
X-Message-ID-Hash: INW5TSC6ICV7RDJQCY6SUF3E5V66LL3L
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/INW5TSC6ICV7RDJQCY6SUF3E5V66LL3L/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Jun 17, 2025 at 1:32=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Tue, Jun 10, 2025 at 03:13:50PM +0200, Jens Wiklander wrote:
> > Add tee_shm_alloc_dma_mem() to allocate DMA memory. The memory is
> > represented by a tee_shm object using the new flag TEE_SHM_DMA_MEM to
> > identify it as DMA memory. The allocated memory will later be lent to
> > the TEE to be used as protected memory.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_shm.c    | 85 +++++++++++++++++++++++++++++++++++++++-
> >  include/linux/tee_core.h |  5 +++
> >  2 files changed, 88 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index e63095e84644..60b0f3932cee 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -5,6 +5,8 @@
> >  #include <linux/anon_inodes.h>
> >  #include <linux/device.h>
> >  #include <linux/dma-buf.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/highmem.h>
> >  #include <linux/idr.h>
> >  #include <linux/io.h>
> >  #include <linux/mm.h>
> > @@ -13,9 +15,14 @@
> >  #include <linux/tee_core.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/uio.h>
> > -#include <linux/highmem.h>
> >  #include "tee_private.h"
> >
> > +struct tee_shm_dma_mem {
> > +     struct tee_shm shm;
> > +     dma_addr_t dma_addr;
> > +     struct page *page;
> > +};
> > +
> >  static void shm_put_kernel_pages(struct page **pages, size_t page_coun=
t)
> >  {
> >       size_t n;
> > @@ -48,7 +55,16 @@ static void tee_shm_release(struct tee_device *teede=
v, struct tee_shm *shm)
> >  {
> >       void *p =3D shm;
> >
> > -     if (shm->flags & TEE_SHM_DMA_BUF) {
> > +     if (shm->flags & TEE_SHM_DMA_MEM) {
> > +#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
>
> nit: this config check can be merged into the above if check.

No, because dma_free_pages() is only defined if
CONFIG_TEE_DMABUF_HEAPS is enabled.

>
> > +             struct tee_shm_dma_mem *dma_mem;
> > +
> > +             dma_mem =3D container_of(shm, struct tee_shm_dma_mem, shm=
);
> > +             p =3D dma_mem;
> > +             dma_free_pages(&teedev->dev, shm->size, dma_mem->page,
> > +                            dma_mem->dma_addr, DMA_BIDIRECTIONAL);
> > +#endif
> > +     } else if (shm->flags & TEE_SHM_DMA_BUF) {
>
> Do we need a similar config check for this flag too?

No, because DMA_SHARED_BUFFER is selected, so the dma_buf functions are def=
ined.

Cheers,
Jens


>
> With these addressed, feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>
> -Sumit
>
> >               struct tee_shm_dmabuf_ref *ref;
> >
> >               ref =3D container_of(shm, struct tee_shm_dmabuf_ref, shm)=
;
> > @@ -303,6 +319,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_=
context *ctx, size_t size)
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
> >
> > +#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
> > +/**
> > + * tee_shm_alloc_dma_mem() - Allocate DMA memory as shared memory obje=
ct
> > + * @ctx:     Context that allocates the shared memory
> > + * @page_count:      Number of pages
> > + *
> > + * The allocated memory is expected to be lent (made inaccessible to t=
he
> > + * kernel) to the TEE while it's used and returned (accessible to the
> > + * kernel again) before it's freed.
> > + *
> > + * This function should normally only be used internally in the TEE
> > + * drivers.
> > + *
> > + * @returns a pointer to 'struct tee_shm'
> > + */
> > +struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
> > +                                   size_t page_count)
> > +{
> > +     struct tee_device *teedev =3D ctx->teedev;
> > +     struct tee_shm_dma_mem *dma_mem;
> > +     dma_addr_t dma_addr;
> > +     struct page *page;
> > +
> > +     if (!tee_device_get(teedev))
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     page =3D dma_alloc_pages(&teedev->dev, page_count * PAGE_SIZE,
> > +                            &dma_addr, DMA_BIDIRECTIONAL, GFP_KERNEL);
> > +     if (!page)
> > +             goto err_put_teedev;
> > +
> > +     dma_mem =3D kzalloc(sizeof(*dma_mem), GFP_KERNEL);
> > +     if (!dma_mem)
> > +             goto err_free_pages;
> > +
> > +     refcount_set(&dma_mem->shm.refcount, 1);
> > +     dma_mem->shm.ctx =3D ctx;
> > +     dma_mem->shm.paddr =3D page_to_phys(page);
> > +     dma_mem->dma_addr =3D dma_addr;
> > +     dma_mem->page =3D page;
> > +     dma_mem->shm.size =3D page_count * PAGE_SIZE;
> > +     dma_mem->shm.flags =3D TEE_SHM_DMA_MEM;
> > +
> > +     teedev_ctx_get(ctx);
> > +
> > +     return &dma_mem->shm;
> > +
> > +err_free_pages:
> > +     dma_free_pages(&teedev->dev, page_count * PAGE_SIZE, page, dma_ad=
dr,
> > +                    DMA_BIDIRECTIONAL);
> > +err_put_teedev:
> > +     tee_device_put(teedev);
> > +
> > +     return ERR_PTR(-ENOMEM);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_alloc_dma_mem);
> > +#else
> > +struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
> > +                                   size_t page_count)
> > +{
> > +     return ERR_PTR(-EINVAL);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_alloc_dma_mem);
> > +#endif
> > +
> >  int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t =
align,
> >                            int (*shm_register)(struct tee_context *ctx,
> >                                                struct tee_shm *shm,
> > diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> > index f17710196c4c..e46a53e753af 100644
> > --- a/include/linux/tee_core.h
> > +++ b/include/linux/tee_core.h
> > @@ -29,6 +29,8 @@
> >  #define TEE_SHM_POOL         BIT(2)  /* Memory allocated from pool */
> >  #define TEE_SHM_PRIV         BIT(3)  /* Memory private to TEE driver *=
/
> >  #define TEE_SHM_DMA_BUF              BIT(4)  /* Memory with dma-buf ha=
ndle */
> > +#define TEE_SHM_DMA_MEM              BIT(5)  /* Memory allocated with =
*/
> > +                                     /* dma_alloc_pages() */
> >
> >  #define TEE_DEVICE_FLAG_REGISTERED   0x1
> >  #define TEE_MAX_DEV_NAME_LEN         32
> > @@ -310,6 +312,9 @@ void *tee_get_drvdata(struct tee_device *teedev);
> >   */
> >  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t=
 size);
> >
> > +struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
> > +                                   size_t page_count);
> > +
> >  int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t =
align,
> >                            int (*shm_register)(struct tee_context *ctx,
> >                                                struct tee_shm *shm,
> > --
> > 2.43.0
> >
