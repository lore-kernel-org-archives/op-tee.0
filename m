Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5040AC77B7C
	for <op-tee@archiver.kernel.org>; Thu,  3 Jul 2025 07:14:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 853B043134
	for <op-tee@archiver.kernel.org>; Thu,  3 Jul 2025 07:14:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=guoesXoH;
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 30B703F6B0
	for <op-tee@lists.trustedfirmware.org>; Thu,  3 Jul 2025 07:13:41 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6113e68da82so3068366eaf.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 03 Jul 2025 00:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751526820; x=1752131620; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dr0G0HPuVKXln/Mnb/5UY0SQE5MginO3Nb336jQ6YM=;
        b=guoesXoHeq9F4+HS80l5N9g1+ket9AAa8QfAHENBuaSYMaIt29IPLBC5144ERTYuzw
         CyWUVWfdKCozrx/POe6Sn4F98KqikWiyz2uxTEjOL6QvFKbjCCPugNauecBKm3Wef08G
         IzFvgEo5RQBYlUyS7OMq9WzvNVYRCgjhLq/CVMD3bzzf3lxsCCIvypOSviceo/J55qjj
         1M6otS8s+tDHEJEWLlPSGvfW3seG8BCYePIEZ2WEOX9N7cIc6fs2POCVveRpevAhSb7j
         ZNkCBw4C0dW+gIuf5BtN+SgSntlr3Cs7C1vr61C0HLPk83ZBQEIjYx4M1ktgP00A7BQo
         E1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751526820; x=1752131620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dr0G0HPuVKXln/Mnb/5UY0SQE5MginO3Nb336jQ6YM=;
        b=aup3NwyFdNPVZs1Xb0rh6RSU6cTZrNl4OyGq+UwDuzNWF7vOofpel1CooA/QWD9J5W
         Pm9TTQE8CxNMmvTkLYBeKxnY1ML46PagF6ijHXw8PBhUwfnlOjIHiMG5e4yX7RDYraWx
         aeLijOJDb7Ug4p99yTZmBIBM1amR9BTrLG1U/51wBFhkUvzZhPtqPTep//Wty0s8mXaw
         tjc9UIikx0Mqd9b+wIhBMu9wPBtCFZ/ZAPn24UyNByjRVkgH2kO3MRslA62T+PIHjBCJ
         3/aUAAR+ts/pzzOkPgteoIqmt4286SeAEA8gNQ/wRwI7Cr7xg6tarP3zS2fL+OarAgWG
         iyQw==
X-Forwarded-Encrypted: i=1; AJvYcCWGyN+EcDrK3UMKn1sVVWYXIheO36HCsSieFhUwJKXoXjho/QbNukyab54h4a/vpb+zJBdaN1o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxDGUUzpOyqSEe8gn6utkgvcoCXl6Lr2cQR8wdtZE9Q9HtMSFfl
	M7eExDYYin2BIkspcVqh6B7tIz0TZMg3M01es/4MwsPazn/tTbi7gy5dLjeso8bUKHA1UMDi/v4
	jDpC86Vnis/sRnA2V9N1Yr75fiTV1a9DHR54NKmKJsWhn
X-Gm-Gg: ASbGnctYgxj9btzCoyHC7oW9QYeIUx/fpRdk5IO5gEwztC+a6HaqniAvIstplt04r//
	bTSfWPjR6IpKCMSXBYRKkxCwsnJMpCAudV85K7MvbBkeh6OhDeq4VOaAS1NWnmDT5X/B8mWr9MZ
	mPbimxchdArhre3o6O4JPpHvIdYpE4EyJfFY44toNCo+Tm
X-Google-Smtp-Source: AGHT+IGzumX+zMN3Zsc0frMnoZjTbrKq52LE81xJcdL6f0gu7EmyIA9p7bwSTX/LNs7SEM2NnBBBJP0kpnIk//vZz6Q=
X-Received: by 2002:a05:6820:198d:b0:611:e30a:fa1c with SMTP id
 006d021491bc7-61200f7034bmr3538676eaf.1.1751526820429; Thu, 03 Jul 2025
 00:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-7-jens.wiklander@linaro.org> <aFFSWDiVsxA1CbCX@sumit-X1>
 <CAHUa44HP5EbURyLCmawMLc0d5jz1oTQZ53V1w2h0-ngUC2hbEw@mail.gmail.com> <aGYi8QkgI3WyeN59@sumit-X1>
In-Reply-To: <aGYi8QkgI3WyeN59@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 3 Jul 2025 09:13:28 +0200
X-Gm-Features: Ac12FXzyoTs9Jn3XWoE-_WRgcRKkI1fV8anRZvH7Atzw9NHwCMp1fhg-J6G_50I
Message-ID: <CAHUa44EMtaSw9uMz5WNSMXSfYXwQ-1TwFjd=R1ZfCo02ir2cjw@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] tee: add tee_shm_alloc_dma_mem()
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 30B703F6B0
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	RBL_SENDERSCORE_REPUT_7(0.50)[209.85.161.48:from];
	BAD_REP_POLICIES(0.10)[];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.48:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	R_SPF_ALLOW(0.00)[+ip4:209.85.128.0/17];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.48:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	R_DKIM_ALLOW(0.00)[linaro.org:s=google];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: DQCVYGCJAV4U2W2FLZAJCN7BN7QF6A37
X-Message-ID-Hash: DQCVYGCJAV4U2W2FLZAJCN7BN7QF6A37
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DQCVYGCJAV4U2W2FLZAJCN7BN7QF6A37/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, Jul 3, 2025 at 8:28=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Wed, Jun 18, 2025 at 09:03:00AM +0200, Jens Wiklander wrote:
> > On Tue, Jun 17, 2025 at 1:32=E2=80=AFPM Sumit Garg <sumit.garg@kernel.o=
rg> wrote:
> > >
> > > On Tue, Jun 10, 2025 at 03:13:50PM +0200, Jens Wiklander wrote:
> > > > Add tee_shm_alloc_dma_mem() to allocate DMA memory. The memory is
> > > > represented by a tee_shm object using the new flag TEE_SHM_DMA_MEM =
to
> > > > identify it as DMA memory. The allocated memory will later be lent =
to
> > > > the TEE to be used as protected memory.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/tee/tee_shm.c    | 85 ++++++++++++++++++++++++++++++++++++=
+++-
> > > >  include/linux/tee_core.h |  5 +++
> > > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > > > index e63095e84644..60b0f3932cee 100644
> > > > --- a/drivers/tee/tee_shm.c
> > > > +++ b/drivers/tee/tee_shm.c
> > > > @@ -5,6 +5,8 @@
> > > >  #include <linux/anon_inodes.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/dma-buf.h>
> > > > +#include <linux/dma-mapping.h>
> > > > +#include <linux/highmem.h>
> > > >  #include <linux/idr.h>
> > > >  #include <linux/io.h>
> > > >  #include <linux/mm.h>
> > > > @@ -13,9 +15,14 @@
> > > >  #include <linux/tee_core.h>
> > > >  #include <linux/uaccess.h>
> > > >  #include <linux/uio.h>
> > > > -#include <linux/highmem.h>
> > > >  #include "tee_private.h"
> > > >
> > > > +struct tee_shm_dma_mem {
> > > > +     struct tee_shm shm;
> > > > +     dma_addr_t dma_addr;
> > > > +     struct page *page;
> > > > +};
> > > > +
> > > >  static void shm_put_kernel_pages(struct page **pages, size_t page_=
count)
> > > >  {
> > > >       size_t n;
> > > > @@ -48,7 +55,16 @@ static void tee_shm_release(struct tee_device *t=
eedev, struct tee_shm *shm)
> > > >  {
> > > >       void *p =3D shm;
> > > >
> > > > -     if (shm->flags & TEE_SHM_DMA_BUF) {
> > > > +     if (shm->flags & TEE_SHM_DMA_MEM) {
> > > > +#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
> > >
> > > nit: this config check can be merged into the above if check.
> >
> > No, because dma_free_pages() is only defined if
> > CONFIG_TEE_DMABUF_HEAPS is enabled.
>
> It looks like you misunderstood my above comment, I rather meant:
>
>         if (IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS) &&
>             (shm->flags & TEE_SHM_DMA_MEM))

That depends on the compiler optimizing away the call to
dma_free_pages() if CONFIG_TEE_DMABUF_HEAPS isn't defined. This is
normally the case, but if you compile for debugging, you may get
unresolved symbols.

Cheers,
Jens

>
> -Sumit
>
> >
> > >
> > > > +             struct tee_shm_dma_mem *dma_mem;
> > > > +
> > > > +             dma_mem =3D container_of(shm, struct tee_shm_dma_mem,=
 shm);
> > > > +             p =3D dma_mem;
> > > > +             dma_free_pages(&teedev->dev, shm->size, dma_mem->page=
,
> > > > +                            dma_mem->dma_addr, DMA_BIDIRECTIONAL);
> > > > +#endif
> > > > +     } else if (shm->flags & TEE_SHM_DMA_BUF) {
> > >
> > > Do we need a similar config check for this flag too?
> >
> > No, because DMA_SHARED_BUFFER is selected, so the dma_buf functions are=
 defined.
> >
> > Cheers,
> > Jens
> >
> >
> > >
> > > With these addressed, feel free to add:
> > >
> > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > >
> > > -Sumit
> > >
> > > >               struct tee_shm_dmabuf_ref *ref;
> > > >
> > > >               ref =3D container_of(shm, struct tee_shm_dmabuf_ref, =
shm);
> > > > @@ -303,6 +319,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct =
tee_context *ctx, size_t size)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
> > > >
> > > > +#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
> > > > +/**
> > > > + * tee_shm_alloc_dma_mem() - Allocate DMA memory as shared memory =
object
> > > > + * @ctx:     Context that allocates the shared memory
> > > > + * @page_count:      Number of pages
> > > > + *
> > > > + * The allocated memory is expected to be lent (made inaccessible =
to the
> > > > + * kernel) to the TEE while it's used and returned (accessible to =
the
> > > > + * kernel again) before it's freed.
> > > > + *
> > > > + * This function should normally only be used internally in the TE=
E
> > > > + * drivers.
> > > > + *
> > > > + * @returns a pointer to 'struct tee_shm'
> > > > + */
> > > > +struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
> > > > +                                   size_t page_count)
> > > > +{
> > > > +     struct tee_device *teedev =3D ctx->teedev;
> > > > +     struct tee_shm_dma_mem *dma_mem;
> > > > +     dma_addr_t dma_addr;
> > > > +     struct page *page;
> > > > +
> > > > +     if (!tee_device_get(teedev))
> > > > +             return ERR_PTR(-EINVAL);
> > > > +
> > > > +     page =3D dma_alloc_pages(&teedev->dev, page_count * PAGE_SIZE=
,
> > > > +                            &dma_addr, DMA_BIDIRECTIONAL, GFP_KERN=
EL);
> > > > +     if (!page)
> > > > +             goto err_put_teedev;
> > > > +
> > > > +     dma_mem =3D kzalloc(sizeof(*dma_mem), GFP_KERNEL);
> > > > +     if (!dma_mem)
> > > > +             goto err_free_pages;
> > > > +
> > > > +     refcount_set(&dma_mem->shm.refcount, 1);
> > > > +     dma_mem->shm.ctx =3D ctx;
> > > > +     dma_mem->shm.paddr =3D page_to_phys(page);
> > > > +     dma_mem->dma_addr =3D dma_addr;
> > > > +     dma_mem->page =3D page;
> > > > +     dma_mem->shm.size =3D page_count * PAGE_SIZE;
> > > > +     dma_mem->shm.flags =3D TEE_SHM_DMA_MEM;
> > > > +
> > > > +     teedev_ctx_get(ctx);
> > > > +
> > > > +     return &dma_mem->shm;
> > > > +
> > > > +err_free_pages:
> > > > +     dma_free_pages(&teedev->dev, page_count * PAGE_SIZE, page, dm=
a_addr,
> > > > +                    DMA_BIDIRECTIONAL);
> > > > +err_put_teedev:
> > > > +     tee_device_put(teedev);
> > > > +
> > > > +     return ERR_PTR(-ENOMEM);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(tee_shm_alloc_dma_mem);
> > > > +#else
> > > > +struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
> > > > +                                   size_t page_count)
> > > > +{
> > > > +     return ERR_PTR(-EINVAL);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(tee_shm_alloc_dma_mem);
> > > > +#endif
> > > > +
> > > >  int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, siz=
e_t align,
> > > >                            int (*shm_register)(struct tee_context *=
ctx,
> > > >                                                struct tee_shm *shm,
> > > > diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> > > > index f17710196c4c..e46a53e753af 100644
> > > > --- a/include/linux/tee_core.h
> > > > +++ b/include/linux/tee_core.h
> > > > @@ -29,6 +29,8 @@
> > > >  #define TEE_SHM_POOL         BIT(2)  /* Memory allocated from pool=
 */
> > > >  #define TEE_SHM_PRIV         BIT(3)  /* Memory private to TEE driv=
er */
> > > >  #define TEE_SHM_DMA_BUF              BIT(4)  /* Memory with dma-bu=
f handle */
> > > > +#define TEE_SHM_DMA_MEM              BIT(5)  /* Memory allocated w=
ith */
> > > > +                                     /* dma_alloc_pages() */
> > > >
> > > >  #define TEE_DEVICE_FLAG_REGISTERED   0x1
> > > >  #define TEE_MAX_DEV_NAME_LEN         32
> > > > @@ -310,6 +312,9 @@ void *tee_get_drvdata(struct tee_device *teedev=
);
> > > >   */
> > > >  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, si=
ze_t size);
> > > >
> > > > +struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
> > > > +                                   size_t page_count);
> > > > +
> > > >  int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, siz=
e_t align,
> > > >                            int (*shm_register)(struct tee_context *=
ctx,
> > > >                                                struct tee_shm *shm,
> > > > --
> > > > 2.43.0
> > > >
