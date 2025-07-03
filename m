Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE18C77B7C
	for <op-tee@archiver.kernel.org>; Thu,  3 Jul 2025 07:35:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C00AA4FC1E
	for <op-tee@archiver.kernel.org>; Thu,  3 Jul 2025 07:35:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M0tkqJ1O;
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B13F93F6B0
	for <op-tee@lists.trustedfirmware.org>; Thu,  3 Jul 2025 07:34:36 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60f0a92391bso2460102eaf.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 03 Jul 2025 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751528076; x=1752132876; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ucwgu55QGLZ6hKl5fIjEVIf2VgExDUhP4Eva3MdE09o=;
        b=M0tkqJ1OCJisztonkJz5ls0qR6Ruh4LhjNDt9VZ11BXTWbfEUs2/nsPRqO3UYxYb/G
         ERPgbaDPSQaQrz62faIaX5VA6xZqyLZoqQTVHViXDsTUej7NR57714tpjHlTQ+lQtKuN
         3rnlIPxD9qx7LZ1wHsX5qQKbpD+a47k3YOlJMdV27Trx6tWyUKmhpxYfaqdRHEewMM/D
         87ENmeAHXTyoan9n0nhuPve1glIl15JBrjHzxeeBAdvqj0iZrd2tga4B+gn1XuTbdjS3
         Pi/DvCjEft+29965qmPkjpeO5sVw4ABwbNd6C5g8Nc4nKjgiDDEjoPSv7fRkNIz/jh3x
         hGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751528076; x=1752132876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ucwgu55QGLZ6hKl5fIjEVIf2VgExDUhP4Eva3MdE09o=;
        b=lqM2KmY/Ss35rWOGFKOLg0czo/cxvbq6GW+4B0BfmFvRuyJ645YC1+DzqvAAlLUvQx
         EzG6gGxcaLugE6SIQo4SBWY3W4btw2gIfJK9uky5BG5EeXdltLeWNynIoPgx6kSSNnTm
         Z5cNOVlfn3kKJERxMJHNYjfGbAShmWA4qia4L1q47o1N8fyl9S3He8bJY7z9yEUgRfis
         IV9oZgcUqiSH+AyFcWyUTc8KJnXa/Qr7wr7EFjI1s0Dx3jWy71N2gzyycChaNBv3x3uM
         qvkE/VzCxSURanarpW6ZBuEQu8ulZf3MonYJmF9ARRRbB5ZgFIyxXssUtVevyC9bI6jf
         5qNg==
X-Forwarded-Encrypted: i=1; AJvYcCV/sHBNIsL/aE/40jRMf5A5yrLpIcciSxggIedemUBBtVKwCmEdgKZZYXDAGXdyfEg1pmTH6YY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyvF7QSjiIpkSCkQ/Sz4SHePIhMFs6x85XNaXU37t5UqP+eE875
	48A/pf+QmaZNdqZPV/LeUM0E78mlVJxsVcFtXMQrkXoBdOLiOOLnbkIKr630v5hoEYnx+GNphgR
	7o26Q+imssIAXnnssQlHUEZGMggPSGzOulysrM0U5h27X
X-Gm-Gg: ASbGncsTOjWZtWTUFWfx+yHvE+5w+qyKBBMMU3/Xv1BsxY/P0AZ0OR0/8h+OXkqvnVS
	G/J0d6zBaphQCR0a/WbBMHJXW8V+YBV54RG9+cff5segxDg+hDpOV5NAazDv6/BzFyWl+sfQ9ye
	7q9Lomv0RMj9oDgNi25XQFjE4//x/B5H6xCd/tjRGM+sR4bUxx7MkA+PY=
X-Google-Smtp-Source: AGHT+IE2ZCgEGfIrkt7r8PkQR4GYt2/+0nWaE1h81qsvFYGMyeA6O+J7BQ0LSF7nIASwgancQR+BLSMFyRPODkVcX8w=
X-Received: by 2002:a05:6808:6807:b0:401:ea47:2c4a with SMTP id
 5614622812f47-40bfde8fceemr1714371b6e.28.1751528075683; Thu, 03 Jul 2025
 00:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-6-jens.wiklander@linaro.org> <aFFIAiU4ZSN1qZXK@sumit-X1>
 <CAHUa44E=nHjLf2guoG6LzTKZwTQGjEReKUF01PL31BfJ22e9EQ@mail.gmail.com> <aGYvwHK2RgIERf_G@sumit-X1>
In-Reply-To: <aGYvwHK2RgIERf_G@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 3 Jul 2025 09:34:24 +0200
X-Gm-Features: Ac12FXysgTs18zKxnvVCeJnCnf6cHXqQyT2On4ibbHZ0I00ukY1448sMc9nC_hU
Message-ID: <CAHUa44EtthC+f5nvNOP_JEcDrAmBUVyQb0amjMnAYQO_jG2C9Q@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] tee: new ioctl to a register tee_shm from a
 dmabuf file descriptor
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B13F93F6B0
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.52:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.161.52:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.52:from];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org,foss.st.com];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: EHDGVPMEWR7NJTZ7OKF6KBWCANY4AGGR
X-Message-ID-Hash: EHDGVPMEWR7NJTZ7OKF6KBWCANY4AGGR
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Etienne Carriere <etienne.carriere@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EHDGVPMEWR7NJTZ7OKF6KBWCANY4AGGR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, Jul 3, 2025 at 9:22=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Wed, Jun 18, 2025 at 08:47:51AM +0200, Jens Wiklander wrote:
> > On Tue, Jun 17, 2025 at 12:48=E2=80=AFPM Sumit Garg <sumit.garg@kernel.=
org> wrote:
> > >
> > > On Tue, Jun 10, 2025 at 03:13:49PM +0200, Jens Wiklander wrote:
> > > > From: Etienne Carriere <etienne.carriere@foss.st.com>
> > > >
> > > > Add a userspace API to create a tee_shm object that refers to a dma=
buf
> > > > reference.
> > > >
> > > > Userspace registers the dmabuf file descriptor as in a tee_shm obje=
ct.
> > > > The registration is completed with a tee_shm returned file descript=
or.
> > > >
> > > > Userspace is free to close the dmabuf file descriptor after it has =
been
> > > > registered since all the resources are now held via the new tee_shm
> > > > object.
> > > >
> > > > Closing the tee_shm file descriptor will eventually release all
> > > > resources used by the tee_shm object when all references are releas=
ed.
> > > >
> > > > The new IOCTL, TEE_IOC_SHM_REGISTER_FD, supports dmabuf references =
to
> > > > physically contiguous memory buffers. Dmabuf references acquired fr=
om
> > > > the TEE DMA-heap can be used as protected memory for Secure Video P=
ath
> > > > and such use cases. It depends on the TEE and the TEE driver if dma=
buf
> > > > references acquired by other means can be used.
> > > >
> > > > A new tee_shm flag is added to identify tee_shm objects built from =
a
> > > > registered dmabuf, TEE_SHM_DMA_BUF.
> > > >
> > > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > > Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/tee/tee_core.c    |  63 +++++++++++++++++++++-
> > > >  drivers/tee/tee_private.h |  10 ++++
> > > >  drivers/tee/tee_shm.c     | 106 ++++++++++++++++++++++++++++++++++=
++--
> > > >  include/linux/tee_core.h  |   1 +
> > > >  include/linux/tee_drv.h   |  10 ++++
> > > >  include/uapi/linux/tee.h  |  31 +++++++++++
> > > >  6 files changed, 217 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > > > index 5259b8223c27..0e9d9e5872a4 100644
> > > > --- a/drivers/tee/tee_core.c
> > > > +++ b/drivers/tee/tee_core.c
> > > > @@ -353,11 +353,49 @@ tee_ioctl_shm_register(struct tee_context *ct=
x,
> > > >       return ret;
> > > >  }
> > > >
> > > > +static int
> > > > +tee_ioctl_shm_register_fd(struct tee_context *ctx,
> > > > +                       struct tee_ioctl_shm_register_fd_data __use=
r *udata)
> > > > +{
> > > > +     struct tee_ioctl_shm_register_fd_data data;
> > > > +     struct tee_shm *shm;
> > > > +     long ret;
> > > > +
> > > > +     if (copy_from_user(&data, udata, sizeof(data)))
> > > > +             return -EFAULT;
> > > > +
> > > > +     /* Currently no input flags are supported */
> > > > +     if (data.flags)
> > > > +             return -EINVAL;
> > > > +
> > > > +     shm =3D tee_shm_register_fd(ctx, data.fd);
> > > > +     if (IS_ERR(shm))
> > > > +             return -EINVAL;
> > > > +
> > > > +     data.id =3D shm->id;
> > > > +     data.flags =3D shm->flags;
> > > > +     data.size =3D shm->size;
> > > > +
> > > > +     if (copy_to_user(udata, &data, sizeof(data)))
> > > > +             ret =3D -EFAULT;
> > > > +     else
> > > > +             ret =3D tee_shm_get_fd(shm);
> > > > +
> > > > +     /*
> > > > +      * When user space closes the file descriptor the shared memo=
ry
> > > > +      * should be freed or if tee_shm_get_fd() failed then it will
> > > > +      * be freed immediately.
> > > > +      */
> > > > +     tee_shm_put(shm);
> > > > +     return ret;
> > > > +}
> > > > +
> > > >  static int param_from_user_memref(struct tee_context *ctx,
> > > >                                 struct tee_param_memref *memref,
> > > >                                 struct tee_ioctl_param *ip)
> > > >  {
> > > >       struct tee_shm *shm;
> > > > +     size_t offs =3D 0;
> > > >
> > > >       /*
> > > >        * If a NULL pointer is passed to a TA in the TEE,
> > > > @@ -388,6 +426,26 @@ static int param_from_user_memref(struct tee_c=
ontext *ctx,
> > > >                       tee_shm_put(shm);
> > > >                       return -EINVAL;
> > > >               }
> > > > +
> > > > +             if (shm->flags & TEE_SHM_DMA_BUF) {
> > > > +                     struct tee_shm_dmabuf_ref *ref;
> > > > +
> > > > +                     ref =3D container_of(shm, struct tee_shm_dmab=
uf_ref, shm);
> > > > +                     if (ref->parent_shm) {
> > > > +                             /*
> > > > +                              * The shm already has one reference =
to
> > > > +                              * ref->parent_shm so we are clear of=
 0.
> > > > +                              * We're getting another reference si=
nce
> > > > +                              * this shm will be used in the param=
eter
> > > > +                              * list instead of the shm we got wit=
h
> > > > +                              * tee_shm_get_from_id() above.
> > > > +                              */
> > > > +                             refcount_inc(&ref->parent_shm->refcou=
nt);
> > > > +                             tee_shm_put(shm);
> > > > +                             shm =3D ref->parent_shm;
> > > > +                             offs =3D ref->offset;
> > > > +                     }
> > > > +             }
> > > >       } else if (ctx->cap_memref_null) {
> > > >               /* Pass NULL pointer to OP-TEE */
> > > >               shm =3D NULL;
> > > > @@ -395,7 +453,7 @@ static int param_from_user_memref(struct tee_co=
ntext *ctx,
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > -     memref->shm_offs =3D ip->a;
> > > > +     memref->shm_offs =3D ip->a + offs;
> > > >       memref->size =3D ip->b;
> > > >       memref->shm =3D shm;
> > > >
> > > > @@ -841,6 +899,8 @@ static long tee_ioctl(struct file *filp, unsign=
ed int cmd, unsigned long arg)
> > > >               return tee_ioctl_shm_alloc(ctx, uarg);
> > > >       case TEE_IOC_SHM_REGISTER:
> > > >               return tee_ioctl_shm_register(ctx, uarg);
> > > > +     case TEE_IOC_SHM_REGISTER_FD:
> > > > +             return tee_ioctl_shm_register_fd(ctx, uarg);
> > > >       case TEE_IOC_OPEN_SESSION:
> > > >               return tee_ioctl_open_session(ctx, uarg);
> > > >       case TEE_IOC_INVOKE:
> > > > @@ -1300,3 +1360,4 @@ MODULE_AUTHOR("Linaro");
> > > >  MODULE_DESCRIPTION("TEE Driver");
> > > >  MODULE_VERSION("1.0");
> > > >  MODULE_LICENSE("GPL v2");
> > > > +MODULE_IMPORT_NS("DMA_BUF");
> > > > diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> > > > index 6c6ff5d5eed2..308467705da6 100644
> > > > --- a/drivers/tee/tee_private.h
> > > > +++ b/drivers/tee/tee_private.h
> > > > @@ -13,6 +13,16 @@
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/types.h>
> > > >
> > > > +/* extra references appended to shm object for registered shared m=
emory */
> > > > +struct tee_shm_dmabuf_ref {
> > > > +     struct tee_shm shm;
> > > > +     size_t offset;
> > > > +     struct dma_buf *dmabuf;
> > > > +     struct dma_buf_attachment *attach;
> > > > +     struct sg_table *sgt;
> > > > +     struct tee_shm *parent_shm;
> > > > +};
> > > > +
> > > >  int tee_shm_get_fd(struct tee_shm *shm);
> > > >
> > > >  bool tee_device_get(struct tee_device *teedev);
> > > > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > > > index daf6e5cfd59a..e63095e84644 100644
> > > > --- a/drivers/tee/tee_shm.c
> > > > +++ b/drivers/tee/tee_shm.c
> > > > @@ -4,6 +4,7 @@
> > > >   */
> > > >  #include <linux/anon_inodes.h>
> > > >  #include <linux/device.h>
> > > > +#include <linux/dma-buf.h>
> > > >  #include <linux/idr.h>
> > > >  #include <linux/io.h>
> > > >  #include <linux/mm.h>
> > > > @@ -45,7 +46,21 @@ static void release_registered_pages(struct tee_=
shm *shm)
> > > >
> > > >  static void tee_shm_release(struct tee_device *teedev, struct tee_=
shm *shm)
> > > >  {
> > > > -     if (shm->flags & TEE_SHM_POOL) {
> > > > +     void *p =3D shm;
> > > > +
> > > > +     if (shm->flags & TEE_SHM_DMA_BUF) {
> > > > +             struct tee_shm_dmabuf_ref *ref;
> > > > +
> > > > +             ref =3D container_of(shm, struct tee_shm_dmabuf_ref, =
shm);
> > > > +             p =3D ref;
> > > > +             if (ref->attach) {
> > > > +                     dma_buf_unmap_attachment(ref->attach, ref->sg=
t,
> > > > +                                              DMA_BIDIRECTIONAL);
> > > > +
> > > > +                     dma_buf_detach(ref->dmabuf, ref->attach);
> > > > +             }
> > > > +             dma_buf_put(ref->dmabuf);
> > > > +     } else if (shm->flags & TEE_SHM_POOL) {
> > > >               teedev->pool->ops->free(teedev->pool, shm);
> > > >       } else if (shm->flags & TEE_SHM_DYNAMIC) {
> > > >               int rc =3D teedev->desc->ops->shm_unregister(shm->ctx=
, shm);
> > > > @@ -59,7 +74,7 @@ static void tee_shm_release(struct tee_device *te=
edev, struct tee_shm *shm)
> > > >
> > > >       teedev_ctx_put(shm->ctx);
> > > >
> > > > -     kfree(shm);
> > > > +     kfree(p);
> > > >
> > > >       tee_device_put(teedev);
> > > >  }
> > > > @@ -169,7 +184,7 @@ struct tee_shm *tee_shm_alloc_user_buf(struct t=
ee_context *ctx, size_t size)
> > > >   * tee_client_invoke_func(). The memory allocated is later freed w=
ith a
> > > >   * call to tee_shm_free().
> > > >   *
> > > > - * @returns a pointer to 'struct tee_shm'
> > > > + * @returns a pointer to 'struct tee_shm' on success, and ERR_PTR =
on failure
> > > >   */
> > > >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, =
size_t size)
> > > >  {
> > > > @@ -179,6 +194,91 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struc=
t tee_context *ctx, size_t size)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
> > > >
> > > > +struct tee_shm *tee_shm_register_fd(struct tee_context *ctx, int f=
d)
> > > > +{
> > > > +     struct tee_shm_dmabuf_ref *ref;
> > > > +     int rc;
> > > > +
> > > > +     if (!tee_device_get(ctx->teedev))
> > > > +             return ERR_PTR(-EINVAL);
> > > > +
> > > > +     teedev_ctx_get(ctx);
> > > > +
> > > > +     ref =3D kzalloc(sizeof(*ref), GFP_KERNEL);
> > > > +     if (!ref) {
> > > > +             rc =3D -ENOMEM;
> > > > +             goto err_put_tee;
> > > > +     }
> > > > +
> > > > +     refcount_set(&ref->shm.refcount, 1);
> > > > +     ref->shm.ctx =3D ctx;
> > > > +     ref->shm.id =3D -1;
> > > > +     ref->shm.flags =3D TEE_SHM_DMA_BUF;
> > > > +
> > > > +     ref->dmabuf =3D dma_buf_get(fd);
> > > > +     if (IS_ERR(ref->dmabuf)) {
> > > > +             rc =3D PTR_ERR(ref->dmabuf);
> > > > +             goto err_kfree_ref;
> > > > +     }
> > > > +
> > > > +     rc =3D tee_heap_update_from_dma_buf(ctx->teedev, ref->dmabuf,
> > > > +                                       &ref->offset, &ref->shm,
> > > > +                                       &ref->parent_shm);
> > > > +     if (!rc)
> > > > +             goto out;
> > >
> > > One odd thing I find here, why do we bail out on success case here?
> > > Don't we need the DMA buffer attach and map APIs to be invoked on
> > > success case here?
> >
> > No, because if tee_heap_update_from_dma_buf() succeeds, we know
> > everything we need about the buffer. Note that we're returning a valid
> > pointer below to indicate success.
>
> AFAICS, protmem_pool_op_dyn_update_shm() and
> protmem_pool_op_static_update_shm() both return 0 on success case...
>
> > >
> > > > +     if (rc !=3D -EINVAL)
> > > > +             goto err_put_dmabuf;
>
> ...and with this check the below code path is only executed when rc =3D=
=3D
> -EINVAL, is that expected behaviour? Shouldn't we error out when -EINVAL
> is returned?
>
> > > > +
> > > > +     ref->attach =3D dma_buf_attach(ref->dmabuf, &ctx->teedev->dev=
);
> > > > +     if (IS_ERR(ref->attach)) {
> > > > +             rc =3D PTR_ERR(ref->attach);
> > > > +             goto err_put_dmabuf;
> > > > +     }
> > > > +
> > > > +     ref->sgt =3D dma_buf_map_attachment(ref->attach, DMA_BIDIRECT=
IONAL);
> > > > +     if (IS_ERR(ref->sgt)) {
> > > > +             rc =3D PTR_ERR(ref->sgt);
> > > > +             goto err_detach;
> > > > +     }
>
> Given above, have we really tested this code leg?

I haven't tested it in this version of the patchset, but the code path
has been used in the earliest version of the patchset.

The idea was to support DMA-bufs allocated by other means, but it's
not needed in this patchset, so let's remove it.

Cheers,
Jens

>
> -Sumit
>
> > > > +
> > > > +     if (sg_nents(ref->sgt->sgl) !=3D 1) {
> > > > +             rc =3D -EINVAL;
> > > > +             goto err_unmap_attachement;
> > > > +     }
> > > > +
> > > > +     ref->shm.paddr =3D page_to_phys(sg_page(ref->sgt->sgl));
> > > > +     ref->shm.size =3D ref->sgt->sgl->length;
> > > > +
> > > > +out:
> > > > +     mutex_lock(&ref->shm.ctx->teedev->mutex);
> > > > +     ref->shm.id =3D idr_alloc(&ref->shm.ctx->teedev->idr, &ref->s=
hm,
> > > > +                             1, 0, GFP_KERNEL);
> > > > +     mutex_unlock(&ref->shm.ctx->teedev->mutex);
> > > > +     if (ref->shm.id < 0) {
> > > > +             rc =3D ref->shm.id;
> > > > +             if (ref->attach)
> > > > +                     goto err_unmap_attachement;
> > > > +             goto err_put_dmabuf;
> > > > +     }
> > > > +
> > > > +     return &ref->shm;
> > > > +
> > > > +err_unmap_attachement:
> > > > +     dma_buf_unmap_attachment(ref->attach, ref->sgt, DMA_BIDIRECTI=
ONAL);
> > > > +err_detach:
> > > > +     dma_buf_detach(ref->dmabuf, ref->attach);
> > > > +err_put_dmabuf:
> > > > +     dma_buf_put(ref->dmabuf);
> > > > +err_kfree_ref:
> > > > +     kfree(ref);
> > > > +err_put_tee:
> > > > +     teedev_ctx_put(ctx);
> > > > +     tee_device_put(ctx->teedev);
> > > > +
> > > > +     return ERR_PTR(rc);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(tee_shm_register_fd);
> > > > +
> > > >  /**
> > > >   * tee_shm_alloc_priv_buf() - Allocate shared memory for a private=
ly shared
> > > >   *                         kernel buffer
> > > > diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> > > > index 22e03d897dc3..f17710196c4c 100644
> > > > --- a/include/linux/tee_core.h
> > > > +++ b/include/linux/tee_core.h
> > > > @@ -28,6 +28,7 @@
> > > >  #define TEE_SHM_USER_MAPPED  BIT(1)  /* Memory mapped in user spac=
e */
> > > >  #define TEE_SHM_POOL         BIT(2)  /* Memory allocated from pool=
 */
> > > >  #define TEE_SHM_PRIV         BIT(3)  /* Memory private to TEE driv=
er */
> > > > +#define TEE_SHM_DMA_BUF              BIT(4)  /* Memory with dma-bu=
f handle */
> > > >
> > > >  #define TEE_DEVICE_FLAG_REGISTERED   0x1
> > > >  #define TEE_MAX_DEV_NAME_LEN         32
> > > > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > > > index a54c203000ed..824f1251de60 100644
> > > > --- a/include/linux/tee_drv.h
> > > > +++ b/include/linux/tee_drv.h
> > > > @@ -116,6 +116,16 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struc=
t tee_context *ctx, size_t size);
> > > >  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ct=
x,
> > > >                                           void *addr, size_t length=
);
> > > >
> > > > +/**
> > > > + * tee_shm_register_fd() - Register shared memory from file descri=
ptor
> > > > + *
> > > > + * @ctx:     Context that allocates the shared memory
> > > > + * @fd:              Shared memory file descriptor reference
> > > > + *
> > > > + * @returns a pointer to 'struct tee_shm' on success, and ERR_PTR =
on failure
> > > > + */
> > > > +struct tee_shm *tee_shm_register_fd(struct tee_context *ctx, int f=
d);
> > > > +
> > > >  /**
> > > >   * tee_shm_free() - Free shared memory
> > > >   * @shm:     Handle to shared memory to free
> > > > diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> > > > index d0430bee8292..d843cf980d98 100644
> > > > --- a/include/uapi/linux/tee.h
> > > > +++ b/include/uapi/linux/tee.h
> > > > @@ -378,6 +378,37 @@ struct tee_ioctl_shm_register_data {
> > > >       __s32 id;
> > > >  };
> > > >
> > > > +/**
> > > > + * struct tee_ioctl_shm_register_fd_data - Shared memory registeri=
ng argument
> > > > + * @fd:              [in] File descriptor identifying dmabuf refer=
ence
> > > > + * @size:    [out] Size of referenced memory
> > > > + * @flags:   [in] Flags to/from allocation.
> > > > + * @id:              [out] Identifier of the shared memory
> > > > + *
> > > > + * The flags field should currently be zero as input. Updated by t=
he call
> > > > + * with actual flags as defined by TEE_IOCTL_SHM_* above.
> > > > + * This structure is used as argument for TEE_IOC_SHM_REGISTER_FD =
below.
> > > > + */
> > > > +struct tee_ioctl_shm_register_fd_data {
> > > > +     __s64 fd;
> > > > +     __u64 size;
> > > > +     __u32 flags;
> > > > +     __s32 id;
> > > > +};
> > > > +
> > > > +/**
> > > > + * TEE_IOC_SHM_REGISTER_FD - register a shared memory from a file =
descriptor
> > > > + *
> > > > + * Returns a file descriptor on success or < 0 on failure
> > > > + *
> > > > + * The returned file descriptor refers to the shared memory object=
 in the
> > > > + * kernel. The supplied file deccriptor can be closed if it's not =
needed
> > > > + * for other purposes. The shared memory is freed when the descrip=
tor is
> > > > + * closed.
> > > > + */
> > > > +#define TEE_IOC_SHM_REGISTER_FD      _IOWR(TEE_IOC_MAGIC, TEE_IOC_=
BASE + 8, \
> > > > +                                  struct tee_ioctl_shm_register_fd=
_data)
> > > > +
> > > >  /**
> > > >   * TEE_IOC_SHM_REGISTER - Register shared memory argument
> > > >   *
> > > > --
> > > > 2.43.0
> > > >
