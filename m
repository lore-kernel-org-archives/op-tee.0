Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F1EC77B7C
	for <op-tee@archiver.kernel.org>; Wed,  2 Jul 2025 13:08:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4556C41A91
	for <op-tee@archiver.kernel.org>; Wed,  2 Jul 2025 13:08:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fhLz74fJ;
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 07D5740B58
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Jul 2025 13:08:32 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60d666804ebso3972968eaf.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Jul 2025 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751461711; x=1752066511; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9g/akK8tC5Ob9tqibjJ8d6KYMjr8nrD3tCzvJ5fMPAo=;
        b=fhLz74fJLG3uZQ/Ixe/Kye6+tkZeKL172RJL8yKQAgdrtmrEafq6Bfo4nnEndGWmVX
         X5vwWDzswNuZUbDHOczk4yu+EOqeHW7IuRdqcU4XgF6NCv2+noW+uMrNbqLba7Y+Yfur
         gZrYPQOInAbt8Mrk/044bf3IOpd9SF/+3YZYw+u9T4YKRT9C7UBFaQexvlBV6P5SjQgo
         GkGGfSoqGVKj85xUSQyd46vyfGtkJ4odzra6gva9bgyBCGyanBAHrdfOJYsR0fK0MZHy
         zcUqXrezARen95y6KZPCeQwT/0uke3xok6b1hWXsyQECllzT+bUG1LH7GjrmyLQmBVt4
         O+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751461711; x=1752066511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9g/akK8tC5Ob9tqibjJ8d6KYMjr8nrD3tCzvJ5fMPAo=;
        b=ZghMnjIxyKcMqx/Z31j4X1v4IuYBlhLpj3U4Hnr4kdHnjIrIbGIFyzuh+vmMOjcaIx
         EyG28tZEpgjooJ/9QLKDTt//IifpR3wZgQfAhUlz/n1h+bLR3laap2PUxuapt06OxfSa
         Fvfe77+CS4bc0A8n6FcvR1GQ6atAh3BwiBIE+HXdMEj4aQisl8jKo4Fc1RgM+Ts+LWrX
         mGWJLWzyunPzbKrnUH5yFwbGIlxZcZUZfbQ2qxvs9DSoOsufaUOCFW3ZTBwVSTn1AKC2
         Ci5wbOKiEqa4FlXEEinZExvuPrXBUP7Tdh0Z16MANCs+U2MM8EIhAkEd5sLc51ytirPk
         FrGQ==
X-Gm-Message-State: AOJu0YzPKNg1eOdy360wTTZDUIzpEYHFlw1d1J9xeAHrq1pdVTJoJH0i
	pCcYRV81M7uFMmH8xLSH2nKi7y0hL7U7tip9SSo/wvn/LBrQOVj7WTwoO3jLmJOsytMnww6QFI/
	fvQuiOwHebfqOpfyhw3eoP++P+1OY5W7QLQtDdP62AUrB
X-Gm-Gg: ASbGncuMHYVzu3NtQaAyWpy/kL0bnMEIj97Dqy08YcsmqSBdSKHqhRcSa/iIh2fO9jC
	hrSaLzD5IFKgl1V90VFHGQSQDmI2XsO9E6aLAFFQMmBVhWJpG+IvE/kJAddeB4GwPuZGbFIUoNU
	Io15nXsBy4z6apR2LYj2Vbi6FKOKCILlamHlB9f8UW/lcV
X-Google-Smtp-Source: AGHT+IH7mVx7n4gOp+ElRuuvON7AgSn6bXyUp4s84Eqikg9b4ZwlpL8hvxE4N+ttqvw4E3+mhD+hOWpH0rRIE6a+tTc=
X-Received: by 2002:a05:6808:1b90:b0:406:70bb:f25 with SMTP id
 5614622812f47-40b8989b39fmr2045413b6e.4.1751461710108; Wed, 02 Jul 2025
 06:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-4-jens.wiklander@linaro.org> <bf2c4e0d-d6f7-4ee6-aec0-bf502bae2e4f@oss.qualcomm.com>
In-Reply-To: <bf2c4e0d-d6f7-4ee6-aec0-bf502bae2e4f@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 2 Jul 2025 15:08:17 +0200
X-Gm-Features: Ac12FXyJfvwW4z1DnBDNiuyN30pxsZFwE1v4LRpR7CLrF8Ftfwfd7W-EB-SbxS0
Message-ID: <CAHUa44HykzsSQQcM6PrGn1hTwL0+XUisdNeMyO65jJXcdyGUiQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/9] tee: implement protected DMA-heap
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 07D5740B58
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.41:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RBL_SENDERSCORE_REPUT_8(0.00)[209.85.161.41:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.41:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: ENELKYIKZZPRMRKDCGAYVHBXNW2MWILY
X-Message-ID-Hash: ENELKYIKZZPRMRKDCGAYVHBXNW2MWILY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ENELKYIKZZPRMRKDCGAYVHBXNW2MWILY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Wed, Jul 2, 2025 at 2:23=E2=80=AFAM Amirreza Zarrabi via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi jens,
>
> On 6/10/2025 11:13 PM, Jens Wiklander wrote:
> > Implement DMA heap for protected DMA-buf allocation in the TEE
> > subsystem.
> >
> > Protected memory refers to memory buffers behind a hardware enforced
> > firewall. It is not accessible to the kernel during normal circumstance=
s
> > but rather only accessible to certain hardware IPs or CPUs executing in
> > higher or differently privileged mode than the kernel itself. This
> > interface allows to allocate and manage such protected memory buffers
> > via interaction with a TEE implementation.
> >
> > The protected memory is allocated for a specific use-case, like Secure
> > Video Playback, Trusted UI, or Secure Video Recording where certain
> > hardware devices can access the memory.
> >
> > The DMA-heaps are enabled explicitly by the TEE backend driver. The TEE
> > backend drivers needs to implement protected memory pool to manage the
> > protected memory.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/Kconfig       |   5 +
> >  drivers/tee/Makefile      |   1 +
> >  drivers/tee/tee_heap.c    | 472 ++++++++++++++++++++++++++++++++++++++
> >  drivers/tee/tee_private.h |   6 +
> >  include/linux/tee_core.h  |  65 ++++++
> >  5 files changed, 549 insertions(+)
> >  create mode 100644 drivers/tee/tee_heap.c
> >
> > diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> > index 61b507c18780..90600607a9d8 100644
> > --- a/drivers/tee/Kconfig
> > +++ b/drivers/tee/Kconfig
> > @@ -13,6 +13,11 @@ menuconfig TEE
> >
> >  if TEE
> >
> > +config TEE_DMABUF_HEAPS
> > +     bool
> > +     depends on HAS_DMA && DMABUF_HEAPS
> > +     default y
> > +
> >  source "drivers/tee/optee/Kconfig"
> >  source "drivers/tee/amdtee/Kconfig"
> >  source "drivers/tee/tstee/Kconfig"
> > diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
> > index 5488cba30bd2..949a6a79fb06 100644
> > --- a/drivers/tee/Makefile
> > +++ b/drivers/tee/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_TEE) +=3D tee.o
> >  tee-objs +=3D tee_core.o
> > +tee-objs +=3D tee_heap.o
> >  tee-objs +=3D tee_shm.o
> >  tee-objs +=3D tee_shm_pool.o
> >  obj-$(CONFIG_OPTEE) +=3D optee/
> > diff --git a/drivers/tee/tee_heap.c b/drivers/tee/tee_heap.c
> > new file mode 100644
> > index 000000000000..7788381a76cb
> > --- /dev/null
> > +++ b/drivers/tee/tee_heap.c
> > @@ -0,0 +1,472 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2025, Linaro Limited
> > + */
> > +
> > +#include <linux/dma-buf.h>
> > +#include <linux/dma-heap.h>
> > +#include <linux/genalloc.h>
> > +#include <linux/module.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/slab.h>
> > +#include <linux/tee_core.h>
> > +#include <linux/xarray.h>
> > +
> > +#include "tee_private.h"
> > +
> > +struct tee_dma_heap {
> > +     struct dma_heap *heap;
> > +     enum tee_dma_heap_id id;
> > +     struct tee_protmem_pool *pool;
> > +     struct tee_device *teedev;
> > +     /* Protects pool and teedev above */
> > +     struct mutex mu;
> > +};
> > +
> > +struct tee_heap_buffer {
> > +     struct tee_protmem_pool *pool;
> > +     struct tee_device *teedev;
> > +     size_t size;
> > +     size_t offs;
> > +     struct sg_table table;
> > +};
> > +
> > +struct tee_heap_attachment {
> > +     struct sg_table table;
> > +     struct device *dev;
> > +};
> > +
> > +struct tee_protmem_static_pool {
> > +     struct tee_protmem_pool pool;
> > +     struct gen_pool *gen_pool;
> > +     phys_addr_t pa_base;
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
> > +static DEFINE_XARRAY_ALLOC(tee_dma_heap);
> > +
> > +static int copy_sg_table(struct sg_table *dst, struct sg_table *src)
> > +{
> > +     struct scatterlist *dst_sg;
> > +     struct scatterlist *src_sg;
> > +     int ret;
> > +     int i;
> > +
> > +     ret =3D sg_alloc_table(dst, src->orig_nents, GFP_KERNEL);
> > +     if (ret)
> > +             return ret;
> > +
> > +     dst_sg =3D dst->sgl;
> > +     for_each_sgtable_sg(src, src_sg, i) {
> > +             sg_set_page(dst_sg, sg_page(src_sg), src_sg->length,
> > +                         src_sg->offset);
> > +             dst_sg =3D sg_next(dst_sg);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int tee_heap_attach(struct dma_buf *dmabuf,
> > +                        struct dma_buf_attachment *attachment)
> > +{
> > +     struct tee_heap_buffer *buf =3D dmabuf->priv;
> > +     struct tee_heap_attachment *a;
> > +     int ret;
> > +
> > +     a =3D kzalloc(sizeof(*a), GFP_KERNEL);
> > +     if (!a)
> > +             return -ENOMEM;
> > +
> > +     ret =3D copy_sg_table(&a->table, &buf->table);
> > +     if (ret) {
> > +             kfree(a);
> > +             return ret;
> > +     }
> > +
> > +     a->dev =3D attachment->dev;
> > +     attachment->priv =3D a;
> > +
> > +     return 0;
> > +}
> > +
> > +static void tee_heap_detach(struct dma_buf *dmabuf,
> > +                         struct dma_buf_attachment *attachment)
> > +{
> > +     struct tee_heap_attachment *a =3D attachment->priv;
> > +
> > +     sg_free_table(&a->table);
> > +     kfree(a);
> > +}
> > +
>
> Considering that this memory is assumed to be protected -- whatever that =
means
> for each use case - does it make sense to implement map/unmap as callback=
s
> and let the backend define what 'map' actually entails?

It's not needed in this patchset. For the sake of the patchset, I
think it's better to wait with that until it's needed. This is
supposed to be mostly internal to the TEE subsystem and the backend
drivers, so it should be easy to add later.

Cheers,
Jens

>
> Regards,
> Amir
>
> > +static struct sg_table *
> > +tee_heap_map_dma_buf(struct dma_buf_attachment *attachment,
> > +                  enum dma_data_direction direction)
> > +{
> > +     struct tee_heap_attachment *a =3D attachment->priv;
> > +     int ret;
> > +
> > +     ret =3D dma_map_sgtable(attachment->dev, &a->table, direction,
> > +                           DMA_ATTR_SKIP_CPU_SYNC);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     return &a->table;
> > +}
> > +
> > +static void tee_heap_unmap_dma_buf(struct dma_buf_attachment *attachme=
nt,
> > +                                struct sg_table *table,
> > +                                enum dma_data_direction direction)
> > +{
> > +     struct tee_heap_attachment *a =3D attachment->priv;
> > +
> > +     WARN_ON(&a->table !=3D table);
> > +
> > +     dma_unmap_sgtable(attachment->dev, table, direction,
> > +                       DMA_ATTR_SKIP_CPU_SYNC);
> > +}
> > +
> > +static void tee_heap_buf_free(struct dma_buf *dmabuf)
> > +{
> > +     struct tee_heap_buffer *buf =3D dmabuf->priv;
> > +     struct tee_device *teedev =3D buf->teedev;
> > +
> > +     buf->pool->ops->free(buf->pool, &buf->table);
> > +     tee_device_put(teedev);
> > +}
> > +
> > +static const struct dma_buf_ops tee_heap_buf_ops =3D {
> > +     .attach =3D tee_heap_attach,
> > +     .detach =3D tee_heap_detach,
> > +     .map_dma_buf =3D tee_heap_map_dma_buf,
> > +     .unmap_dma_buf =3D tee_heap_unmap_dma_buf,
> > +     .release =3D tee_heap_buf_free,
> > +};
> > +
> > +static struct dma_buf *tee_dma_heap_alloc(struct dma_heap *heap,
> > +                                       unsigned long len, u32 fd_flags=
,
> > +                                       u64 heap_flags)
> > +{
> > +     struct tee_dma_heap *h =3D dma_heap_get_drvdata(heap);
> > +     DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +     struct tee_device *teedev =3D NULL;
> > +     struct tee_heap_buffer *buf;
> > +     struct tee_protmem_pool *pool;
> > +     struct dma_buf *dmabuf;
> > +     int rc;
> > +
> > +     mutex_lock(&h->mu);
> > +     if (tee_device_get(h->teedev)) {
> > +             teedev =3D h->teedev;
> > +             pool =3D h->pool;
> > +     }
> > +     mutex_unlock(&h->mu);
> > +
> > +     if (!teedev)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     buf =3D kzalloc(sizeof(*buf), GFP_KERNEL);
> > +     if (!buf) {
> > +             dmabuf =3D ERR_PTR(-ENOMEM);
> > +             goto err;
> > +     }
> > +     buf->size =3D len;
> > +     buf->pool =3D pool;
> > +     buf->teedev =3D teedev;
> > +
> > +     rc =3D pool->ops->alloc(pool, &buf->table, len, &buf->offs);
> > +     if (rc) {
> > +             dmabuf =3D ERR_PTR(rc);
> > +             goto err_kfree;
> > +     }
> > +
> > +     exp_info.ops =3D &tee_heap_buf_ops;
> > +     exp_info.size =3D len;
> > +     exp_info.priv =3D buf;
> > +     exp_info.flags =3D fd_flags;
> > +     dmabuf =3D dma_buf_export(&exp_info);
> > +     if (IS_ERR(dmabuf))
> > +             goto err_protmem_free;
> > +
> > +     return dmabuf;
> > +
> > +err_protmem_free:
> > +     pool->ops->free(pool, &buf->table);
> > +err_kfree:
> > +     kfree(buf);
> > +err:
> > +     tee_device_put(h->teedev);
> > +     return dmabuf;
> > +}
> > +
> > +static const struct dma_heap_ops tee_dma_heap_ops =3D {
> > +     .allocate =3D tee_dma_heap_alloc,
> > +};
> > +
> > +static const char *heap_id_2_name(enum tee_dma_heap_id id)
> > +{
> > +     switch (id) {
> > +     case TEE_DMA_HEAP_SECURE_VIDEO_PLAY:
> > +             return "protected,secure-video";
> > +     case TEE_DMA_HEAP_TRUSTED_UI:
> > +             return "protected,trusted-ui";
> > +     case TEE_DMA_HEAP_SECURE_VIDEO_RECORD:
> > +             return "protected,secure-video-record";
> > +     default:
> > +             return NULL;
> > +     }
> > +}
> > +
> > +static int alloc_dma_heap(struct tee_device *teedev, enum tee_dma_heap=
_id id,
> > +                       struct tee_protmem_pool *pool)
> > +{
> > +     struct dma_heap_export_info exp_info =3D {
> > +             .ops =3D &tee_dma_heap_ops,
> > +             .name =3D heap_id_2_name(id),
> > +     };
> > +     struct tee_dma_heap *h;
> > +     int rc;
> > +
> > +     if (!exp_info.name)
> > +             return -EINVAL;
> > +
> > +     if (xa_reserve(&tee_dma_heap, id, GFP_KERNEL)) {
> > +             if (!xa_load(&tee_dma_heap, id))
> > +                     return -EEXIST;
> > +             return -ENOMEM;
> > +     }
> > +
> > +     h =3D kzalloc(sizeof(*h), GFP_KERNEL);
> > +     if (!h)
> > +             return -ENOMEM;
> > +     h->id =3D id;
> > +     h->teedev =3D teedev;
> > +     h->pool =3D pool;
> > +     mutex_init(&h->mu);
> > +
> > +     exp_info.priv =3D h;
> > +     h->heap =3D dma_heap_add(&exp_info);
> > +     if (IS_ERR(h->heap)) {
> > +             rc =3D PTR_ERR(h->heap);
> > +             kfree(h);
> > +
> > +             return rc;
> > +     }
> > +
> > +     /* "can't fail" due to the call to xa_reserve() above */
> > +     return WARN_ON(xa_is_err(xa_store(&tee_dma_heap, id, h, GFP_KERNE=
L)));
> > +}
> > +
> > +int tee_device_register_dma_heap(struct tee_device *teedev,
> > +                              enum tee_dma_heap_id id,
> > +                              struct tee_protmem_pool *pool)
> > +{
> > +     struct tee_dma_heap *h;
> > +     int rc;
> > +
> > +     h =3D xa_load(&tee_dma_heap, id);
> > +     if (h) {
> > +             mutex_lock(&h->mu);
> > +             if (h->teedev) {
> > +                     rc =3D -EBUSY;
> > +             } else {
> > +                     h->teedev =3D teedev;
> > +                     h->pool =3D pool;
> > +                     rc =3D 0;
> > +             }
> > +             mutex_unlock(&h->mu);
> > +     } else {
> > +             rc =3D alloc_dma_heap(teedev, id, pool);
> > +     }
> > +
> > +     if (rc)
> > +             dev_err(&teedev->dev, "can't register DMA heap id %d (%s)=
\n",
> > +                     id, heap_id_2_name(id));
> > +
> > +     return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_device_register_dma_heap);
> > +
> > +void tee_device_unregister_all_dma_heaps(struct tee_device *teedev)
> > +{
> > +     struct tee_protmem_pool *pool;
> > +     struct tee_dma_heap *h;
> > +     u_long i;
> > +
> > +     xa_for_each(&tee_dma_heap, i, h) {
> > +             if (h) {
> > +                     pool =3D NULL;
> > +                     mutex_lock(&h->mu);
> > +                     if (h->teedev =3D=3D teedev) {
> > +                             pool =3D h->pool;
> > +                             h->teedev =3D NULL;
> > +                             h->pool =3D NULL;
> > +                     }
> > +                     mutex_unlock(&h->mu);
> > +                     if (pool)
> > +                             pool->ops->destroy_pool(pool);
> > +             }
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
> > +
> > +int tee_heap_update_from_dma_buf(struct tee_device *teedev,
> > +                              struct dma_buf *dmabuf, size_t *offset,
> > +                              struct tee_shm *shm,
> > +                              struct tee_shm **parent_shm)
> > +{
> > +     struct tee_heap_buffer *buf;
> > +     int rc;
> > +
> > +     /* The DMA-buf must be from our heap */
> > +     if (dmabuf->ops !=3D &tee_heap_buf_ops)
> > +             return -EINVAL;
> > +
> > +     buf =3D dmabuf->priv;
> > +     /* The buffer must be from the same teedev */
> > +     if (buf->teedev !=3D teedev)
> > +             return -EINVAL;
> > +
> > +     shm->size =3D buf->size;
> > +
> > +     rc =3D buf->pool->ops->update_shm(buf->pool, &buf->table, buf->of=
fs, shm,
> > +                                     parent_shm);
> > +     if (!rc && *parent_shm)
> > +             *offset =3D buf->offs;
> > +
> > +     return rc;
> > +}
> > +#else
> > +int tee_device_register_dma_heap(struct tee_device *teedev __always_un=
used,
> > +                              enum tee_dma_heap_id id __always_unused,
> > +                              struct tee_protmem_pool *pool __always_u=
nused)
> > +{
> > +     return -EINVAL;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_device_register_dma_heap);
> > +
> > +void
> > +tee_device_unregister_all_dma_heaps(struct tee_device *teedev __always=
_unused)
> > +{
> > +}
> > +EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
> > +
> > +int tee_heap_update_from_dma_buf(struct tee_device *teedev __always_un=
used,
> > +                              struct dma_buf *dmabuf __always_unused,
> > +                              size_t *offset __always_unused,
> > +                              struct tee_shm *shm __always_unused,
> > +                              struct tee_shm **parent_shm __always_unu=
sed)
> > +{
> > +     return -EINVAL;
> > +}
> > +#endif
> > +
> > +static struct tee_protmem_static_pool *
> > +to_protmem_static_pool(struct tee_protmem_pool *pool)
> > +{
> > +     return container_of(pool, struct tee_protmem_static_pool, pool);
> > +}
> > +
> > +static int protmem_pool_op_static_alloc(struct tee_protmem_pool *pool,
> > +                                     struct sg_table *sgt, size_t size=
,
> > +                                     size_t *offs)
> > +{
> > +     struct tee_protmem_static_pool *stp =3D to_protmem_static_pool(po=
ol);
> > +     phys_addr_t pa;
> > +     int ret;
> > +
> > +     pa =3D gen_pool_alloc(stp->gen_pool, size);
> > +     if (!pa)
> > +             return -ENOMEM;
> > +
> > +     ret =3D sg_alloc_table(sgt, 1, GFP_KERNEL);
> > +     if (ret) {
> > +             gen_pool_free(stp->gen_pool, pa, size);
> > +             return ret;
> > +     }
> > +
> > +     sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);
> > +     *offs =3D pa - stp->pa_base;
> > +
> > +     return 0;
> > +}
> > +
> > +static void protmem_pool_op_static_free(struct tee_protmem_pool *pool,
> > +                                     struct sg_table *sgt)
> > +{
> > +     struct tee_protmem_static_pool *stp =3D to_protmem_static_pool(po=
ol);
> > +     struct scatterlist *sg;
> > +     int i;
> > +
> > +     for_each_sgtable_sg(sgt, sg, i)
> > +             gen_pool_free(stp->gen_pool, sg_phys(sg), sg->length);
> > +     sg_free_table(sgt);
> > +}
> > +
> > +static int protmem_pool_op_static_update_shm(struct tee_protmem_pool *=
pool,
> > +                                          struct sg_table *sgt, size_t=
 offs,
> > +                                          struct tee_shm *shm,
> > +                                          struct tee_shm **parent_shm)
> > +{
> > +     struct tee_protmem_static_pool *stp =3D to_protmem_static_pool(po=
ol);
> > +
> > +     shm->paddr =3D stp->pa_base + offs;
> > +     *parent_shm =3D NULL;
> > +
> > +     return 0;
> > +}
> > +
> > +static void protmem_pool_op_static_destroy_pool(struct tee_protmem_poo=
l *pool)
> > +{
> > +     struct tee_protmem_static_pool *stp =3D to_protmem_static_pool(po=
ol);
> > +
> > +     gen_pool_destroy(stp->gen_pool);
> > +     kfree(stp);
> > +}
> > +
> > +static struct tee_protmem_pool_ops protmem_pool_ops_static =3D {
> > +     .alloc =3D protmem_pool_op_static_alloc,
> > +     .free =3D protmem_pool_op_static_free,
> > +     .update_shm =3D protmem_pool_op_static_update_shm,
> > +     .destroy_pool =3D protmem_pool_op_static_destroy_pool,
> > +};
> > +
> > +struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t pad=
dr,
> > +                                                    size_t size)
> > +{
> > +     const size_t page_mask =3D PAGE_SIZE - 1;
> > +     struct tee_protmem_static_pool *stp;
> > +     int rc;
> > +
> > +     /* Check it's page aligned */
> > +     if ((paddr | size) & page_mask)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     if (!pfn_valid(PHYS_PFN(paddr)))
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     stp =3D kzalloc(sizeof(*stp), GFP_KERNEL);
> > +     if (!stp)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     stp->gen_pool =3D gen_pool_create(PAGE_SHIFT, -1);
> > +     if (!stp->gen_pool) {
> > +             rc =3D -ENOMEM;
> > +             goto err_free;
> > +     }
> > +
> > +     rc =3D gen_pool_add(stp->gen_pool, paddr, size, -1);
> > +     if (rc)
> > +             goto err_free_pool;
> > +
> > +     stp->pool.ops =3D &protmem_pool_ops_static;
> > +     stp->pa_base =3D paddr;
> > +     return &stp->pool;
> > +
> > +err_free_pool:
> > +     gen_pool_destroy(stp->gen_pool);
> > +err_free:
> > +     kfree(stp);
> > +
> > +     return ERR_PTR(rc);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_protmem_static_pool_alloc);
> > diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> > index 9bc50605227c..6c6ff5d5eed2 100644
> > --- a/drivers/tee/tee_private.h
> > +++ b/drivers/tee/tee_private.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/cdev.h>
> >  #include <linux/completion.h>
> >  #include <linux/device.h>
> > +#include <linux/dma-buf.h>
> >  #include <linux/kref.h>
> >  #include <linux/mutex.h>
> >  #include <linux/types.h>
> > @@ -24,4 +25,9 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_con=
text *ctx, size_t size);
> >  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> >                                         unsigned long addr, size_t leng=
th);
> >
> > +int tee_heap_update_from_dma_buf(struct tee_device *teedev,
> > +                              struct dma_buf *dmabuf, size_t *offset,
> > +                              struct tee_shm *shm,
> > +                              struct tee_shm **parent_shm);
> > +
> >  #endif /*TEE_PRIVATE_H*/
> > diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> > index a38494d6b5f4..22e03d897dc3 100644
> > --- a/include/linux/tee_core.h
> > +++ b/include/linux/tee_core.h
> > @@ -8,9 +8,11 @@
> >
> >  #include <linux/cdev.h>
> >  #include <linux/device.h>
> > +#include <linux/dma-buf.h>
> >  #include <linux/idr.h>
> >  #include <linux/kref.h>
> >  #include <linux/list.h>
> > +#include <linux/scatterlist.h>
> >  #include <linux/tee.h>
> >  #include <linux/tee_drv.h>
> >  #include <linux/types.h>
> > @@ -30,6 +32,12 @@
> >  #define TEE_DEVICE_FLAG_REGISTERED   0x1
> >  #define TEE_MAX_DEV_NAME_LEN         32
> >
> > +enum tee_dma_heap_id {
> > +     TEE_DMA_HEAP_SECURE_VIDEO_PLAY =3D 1,
> > +     TEE_DMA_HEAP_TRUSTED_UI,
> > +     TEE_DMA_HEAP_SECURE_VIDEO_RECORD,
> > +};
> > +
> >  /**
> >   * struct tee_device - TEE Device representation
> >   * @name:    name of device
> > @@ -116,6 +124,36 @@ struct tee_desc {
> >       u32 flags;
> >  };
> >
> > +/**
> > + * struct tee_protmem_pool - protected memory pool
> > + * @ops:             operations
> > + *
> > + * This is an abstract interface where this struct is expected to be
> > + * embedded in another struct specific to the implementation.
> > + */
> > +struct tee_protmem_pool {
> > +     const struct tee_protmem_pool_ops *ops;
> > +};
> > +
> > +/**
> > + * struct tee_protmem_pool_ops - protected memory pool operations
> > + * @alloc:           called when allocating protected memory
> > + * @free:            called when freeing protected memory
> > + * @update_shm:              called when registering a dma-buf to upda=
te the @shm
> > + *                   with physical address of the buffer or to return =
the
> > + *                   @parent_shm of the memory pool
> > + * @destroy_pool:    called when destroying the pool
> > + */
> > +struct tee_protmem_pool_ops {
> > +     int (*alloc)(struct tee_protmem_pool *pool, struct sg_table *sgt,
> > +                  size_t size, size_t *offs);
> > +     void (*free)(struct tee_protmem_pool *pool, struct sg_table *sgt)=
;
> > +     int (*update_shm)(struct tee_protmem_pool *pool, struct sg_table =
*sgt,
> > +                       size_t offs, struct tee_shm *shm,
> > +                       struct tee_shm **parent_shm);
> > +     void (*destroy_pool)(struct tee_protmem_pool *pool);
> > +};
> > +
> >  /**
> >   * tee_device_alloc() - Allocate a new struct tee_device instance
> >   * @teedesc: Descriptor for this driver
> > @@ -154,6 +192,11 @@ int tee_device_register(struct tee_device *teedev)=
;
> >   */
> >  void tee_device_unregister(struct tee_device *teedev);
> >
> > +int tee_device_register_dma_heap(struct tee_device *teedev,
> > +                              enum tee_dma_heap_id id,
> > +                              struct tee_protmem_pool *pool);
> > +void tee_device_unregister_all_dma_heaps(struct tee_device *teedev);
> > +
> >  /**
> >   * tee_device_set_dev_groups() - Set device attribute groups
> >   * @teedev:  Device to register
> > @@ -229,6 +272,28 @@ static inline void tee_shm_pool_free(struct tee_sh=
m_pool *pool)
> >       pool->ops->destroy_pool(pool);
> >  }
> >
> > +/**
> > + * tee_protmem_static_pool_alloc() - Create a protected memory manager
> > + * @paddr:   Physical address of start of pool
> > + * @size:    Size in bytes of the pool
> > + *
> > + * @returns pointer to a 'struct tee_protmem_pool' or an ERR_PTR on fa=
ilure.
> > + */
> > +struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t pad=
dr,
> > +                                                    size_t size);
> > +
> > +/**
> > + * tee_protmem_pool_free() - Free a protected memory pool
> > + * @pool:    The protected memory pool to free
> > + *
> > + * There must be no remaining protected memory allocated from this poo=
l
> > + * when this function is called.
> > + */
> > +static inline void tee_protmem_pool_free(struct tee_protmem_pool *pool=
)
> > +{
> > +     pool->ops->destroy_pool(pool);
> > +}
> > +
> >  /**
> >   * tee_get_drvdata() - Return driver_data pointer
> >   * @returns the driver_data pointer supplied to tee_register().
>
