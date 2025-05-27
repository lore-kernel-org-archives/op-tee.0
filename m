Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53B0C54ED1
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 14:21:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D487642F23
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 14:21:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SD8tSC06;
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6BEB642E82
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 14:21:39 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-404a5f4cdedso638829b6e.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748355699; x=1748960499; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwr1gpmj/Y5xrm528qSwLq/tkBaVoA9zaC9zXNPG4sg=;
        b=SD8tSC069JUelLYsY2U07jyRZ1m2frMozZB5jdOZms89VxP8rDUOQ+G6xQEixYlcJ2
         9qIgNyBbxCkmSFJbDTjdon9+u9RcJAUncqfHxhaApeNEa3EpSkc2izoQ4hJlKo1o8tOg
         WI0KzWU3Go+MNB378lGueExvg0AieWMoqjNU1wtuRL84H2Qywkw76KK97+emAQq4M50y
         zbTpfrwYDxoVjwjxrvG1LoMR/sxUhzuk1K7IMbv78isyFe2ZVXvY/gbMwdNAwdiAxQ6/
         QiuM1xzpf9dhM0S6+0ibX0fxcIxs44ZRIJkbD1Hk+vZFr3+E9+0O7fL8zih/PVN/H3TA
         B+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355699; x=1748960499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwr1gpmj/Y5xrm528qSwLq/tkBaVoA9zaC9zXNPG4sg=;
        b=nll/gNjT8vwzG8zmfCDQu8M7X0tBRMCvOVJ6mTVWiCm67lNqvtuz0nPxq1DRaUdNBD
         grler8dAHMux0yL102M2OmwM+gxgGf47Aeg2Zjc/vOP3TI2EFOEkkY9n8a6a8k48YiF6
         cU77iabyED839bhbctCGnPriiOZO3RiBZNsjZVV+NU1NJafXiI/klIPKScaRwXm8Jkte
         XFIU/x+RG1fJeBDn+QAq0B9V9Wa9w1X3FTWuEdhXht9wb6I4yb1WgohSmdMMerFQP7jL
         umkt76p1igYLyfjNfdn9JSL7lZz/IPXapr+l6RBcITAIwRYXjGAH5tUOs3kk1E1l2/vs
         L0og==
X-Forwarded-Encrypted: i=1; AJvYcCVOTjwfBwS/We4S5YbLDGSjMVhukWxpxxP1LAsdJHY9S1cQ8hdA/8eessMD92IqgTsxLKXE5c8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzdVWxwgSJ14xROwIjVSnfzCfFdu01/3lsO06MnD9+zh4wREOr9
	q5YzJUt5AIWdP3F+VJwNIX4M08jG7IFUnTtj4MJ4Kl/SO8adYso33E+GvFOoVcOW1QZ/Qpg7efE
	+7TNojGHef3mg4/BsJHtezHGN8c75S5RWJY3hwiDpsKlW
X-Gm-Gg: ASbGncuLe0XsXqoryev8LVnAJJ/ucYAkyE++rKzGE8uNkVIE8vwSHID7X5LFRzr3vle
	3X0lj0zZWGpCKJYMG/x0xEyNrVX945On2Yh0/bNU8gN7+ozmt0ggCBAPWzX1fJoWgKUYp7JOuie
	wMfSsBfvD47Ji+Lqvz267E9LZXsRQXX6+azg==
X-Google-Smtp-Source: AGHT+IHSldvXeMA/elq5GvdUeZXIE9U2qVSq25l+1UuvJ7nlZ4QemLu8hmu4wkxm84jlPfHrWshtHT5sVpyeKj3x5HU=
X-Received: by 2002:a05:6808:1b85:b0:402:ebf9:b770 with SMTP id
 5614622812f47-40646855c6dmr6484125b6e.28.1748355698671; Tue, 27 May 2025
 07:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-7-jens.wiklander@linaro.org> <aDQWt5Ck1Bo01Z_4@sumit-X1>
 <CAHUa44E4-z7-7DQjyGXYRiZDf6mRBKYZDuxWFGy+3JxtWO1ocg@mail.gmail.com> <aDQ1YR5jbcOFctty@sumit-X1>
In-Reply-To: <aDQ1YR5jbcOFctty@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 27 May 2025 16:21:27 +0200
X-Gm-Features: AX0GCFufndHj8dMt0PaaB1DfiHys-ZIzTuXpul-y9wKknnwSsO_zDsCVnQgE3aw
Message-ID: <CAHUa44HUzfWXEdLeAVimDM0DTFaTbCa4SSTcy8YPhDjWHR352Q@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] tee: add tee_shm_alloc_dma_mem()
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.169:from];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.169:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6BEB642E82
Message-ID-Hash: ALNFV5RGVKOCJCMNB3CEONQJT3PH67MJ
X-Message-ID-Hash: ALNFV5RGVKOCJCMNB3CEONQJT3PH67MJ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ALNFV5RGVKOCJCMNB3CEONQJT3PH67MJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, May 26, 2025 at 11:33=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Mon, May 26, 2025 at 11:21:47AM +0200, Jens Wiklander wrote:
> > On Mon, May 26, 2025 at 9:22=E2=80=AFAM Sumit Garg <sumit.garg@kernel.o=
rg> wrote:
> > >
> > > On Tue, May 20, 2025 at 05:16:49PM +0200, Jens Wiklander wrote:
> > > > Add tee_shm_alloc_dma_mem() to allocate DMA memory. The memory is
> > > > represented by a tee_shm object using the new flag TEE_SHM_DMA_MEM =
to
> > > > identify it as DMA memory. The allocated memory will later be lent =
to
> > > > the TEE to be used as protected memory.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/tee/tee_shm.c    | 74 ++++++++++++++++++++++++++++++++++++=
++--
> > > >  include/linux/tee_core.h |  5 +++
> > > >  2 files changed, 77 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > > > index e1ed52ee0a16..92a6a35e1a1e 100644
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
> > > > @@ -49,7 +56,14 @@ static void tee_shm_release(struct tee_device *t=
eedev, struct tee_shm *shm)
> > > >       struct tee_shm *parent_shm =3D NULL;
> > > >       void *p =3D shm;
> > > >
> > > > -     if (shm->flags & TEE_SHM_DMA_BUF) {
> > > > +     if (shm->flags & TEE_SHM_DMA_MEM) {
> > > > +             struct tee_shm_dma_mem *dma_mem;
> > > > +
> > > > +             dma_mem =3D container_of(shm, struct tee_shm_dma_mem,=
 shm);
> > > > +             p =3D dma_mem;
> > > > +             dma_free_pages(&teedev->dev, shm->size, dma_mem->page=
,
> > > > +                            dma_mem->dma_addr, DMA_BIDIRECTIONAL);
> > >
> > > Although the kernel bot already found a randconfig issue, it looks li=
ke
> > > we need to add Kconfig dependencies like HAS_DMA, DMA_CMA etc.
> > >
> > > Also, I was thinking if we should rather add a new TEE subsystem
> > > specific Kconfig option like: TEE_DMABUF_HEAPS which can then be used=
 to
> > > select whatever dependency is needed as well as act as a gating Kconf=
ig
> > > for relevant features.
> >
> > You mean something like this?
> >
> > --- a/drivers/tee/Kconfig
> > +++ b/drivers/tee/Kconfig
> > @@ -13,6 +13,14 @@ menuconfig TEE
> >
> >  if TEE
> >
> > +config TEE_DMABUF_HEAPS
> > +       bool
> > +       depends on HAS_DMA && DMABUF_HEAPS
>
> Yeah this looks fine to me but needs to be tested if DMA_CMA is a
> dependency here too.

Why? It can work without CMA for small allocations.

>
> > +
> > +config TEE_STATIC_PROTMEM_POOL
> > +       bool
> > +       depends on HAS_IOMEM && TEE_DMABUF_HEAPS
>
> The static and dynamic protected memory pools should get auto enabled if
> TEE_DMABUF_HEAPS is enabled since they are pre-requisite to provide the
> protected heaps support. Something like:
>
> +config TEE_STATIC_PROTMEM_POOL
> +       bool
> +       default y if TEE_DMABUF_HEAPS
> +       depends on HAS_IOMEM

Right, I'll update as needed.

Cheers,
Jens
