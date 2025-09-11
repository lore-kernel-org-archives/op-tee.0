Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C603CAC58D
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 08:35:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B12CB4FDF6
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 08:35:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yoqmQfPT;
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C3AA242E9B
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 08:35:07 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-746c0ee5d77so368611a34.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757579707; x=1758184507; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3kQgAiwPfvEAAOGUV7iUTri/K2HtvbKjHs1xtQRX0U=;
        b=yoqmQfPTCIpAyoc7qGDgaKmg4WBzxh089F33RKfUE554PNrUzrbuojLH1VLiYkU2rU
         GNIQ62bbnLEkXVnpcbpyqyXcJxk3ss/tAb2KLO8mZFj77EamFm+M4SJart5WSsuG9A8n
         FmONhp0ZTdcbVWtz0Q/+rbdGL4e7g7mD+nC/RgoFotVjMsjx7W9i/lqniAOLqe2fWaXt
         gfBQ4ZYyvMKxL66KXaFSshfFTCn7thTbp1Ba3nCXpffoeQ9F/2lb3vWYZjKfYl/mmP/X
         CwCS492sGQW4wdfTAYazR5TwZ5b3Unyqz3Mhd2ABJGxjRp3aQ/pEu99KiNkfPjtKv3Vl
         8+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579707; x=1758184507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3kQgAiwPfvEAAOGUV7iUTri/K2HtvbKjHs1xtQRX0U=;
        b=vYVn2fUwEyWFhisa28ot7P2v2nsPKvsuWu9rSx2S8u857ycoK7MBWg83YvWev+jYDH
         DPvHBi0w6nQL0ddW5naQ8fQKmW2d0nowHZDdwTh0R3kFDXWJ01wW1vkZXhIdS5Q8pQbc
         VLKSG5H5o5Szud2rfzZ7bUqnyrPeq1majodYWTP/q81KtR9+Ql6cv07myM2NNvfG0S9H
         15QOYDNCLAWOBgL+WFLx4Mh9pO5xKnJJ3CJeHoyXmXHwVZZ4mNLt3i8H/nekjW9mIsO2
         ZbYRzL/S30ldiKqaCKkmQikwmv7IGtcBe79Wa/LvxffE54QK5rLdEwxn/BXHxg/cMVza
         zsGA==
X-Forwarded-Encrypted: i=1; AJvYcCWcJH+sVtpyxqTKtFWZK0q6mxYAN1WIUpRatSZOfsbT6PrAV9Gn+HivpHu5g+O4XVbH14Dgsn0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxcpv6Gfg3+GPwDysd9QOpyad+bOaBWgeMh/WRz8/HAQlMteH57
	jh6GuAB1pMpO1VQEMk+AU3SRe23+ceS57k1RAN9xceGVU428hGpK834ET2ToOQQ5Z2ZqAZfEbce
	wXfoSm7RH71b1nrYDaAQ84132oDtb/Qiskc8PgxMz5fEF
X-Gm-Gg: ASbGnct38/EjE6lrxUlncstcGVNjQZnnH9YT7ewz4HHFtl+qFzD1wfnayvTjhRN7TN6
	5NCPKCi80OIzp/DrwNd8NUaP2l/SnU4RLmq6pyQMWty4BrtRerMjwPqyWyX9meVAY8/SZA+Pzyu
	4g4qeMWfkVVWMYik0r3WMsO3L55QORBzbQ0kas8jl1lrn11PvdC5lPp1j5ypSy3LH2rOK/PpDUO
	5/PIjQ8I4r9YaW+W+A=
X-Google-Smtp-Source: AGHT+IFeh9GhwJV0/BRbDqXK1301VOv+yaAADE4wRS2wEzztzMHQXFq1Ue2WE8k5BTs1i0e0aU2GdBSeES8eqZ6R/tc=
X-Received: by 2002:a05:6830:348e:b0:74b:3422:f33d with SMTP id
 46e09a7af769-74c66acfea9mr10389569a34.0.1757579706886; Thu, 11 Sep 2025
 01:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
 <20250813060339.2977604-3-jens.wiklander@linaro.org> <aJ1-YpgvGt4_6CFU@sumit-X1>
 <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com>
 <CAO_48GEqkf_Jm8kSTPEDZkZy-YmT56Zs1Jx9zCvzETPsCzrkEg@mail.gmail.com>
 <CAHUa44HHSKwiBYPMSY5hj6wyWc9-uvtQVx+JLx4M5yjD5AwyTg@mail.gmail.com> <CAO_48GE=FHaNzybUxjY=igyOO1oasKb9yu_yAjJEdjTQXicaJA@mail.gmail.com>
In-Reply-To: <CAO_48GE=FHaNzybUxjY=igyOO1oasKb9yu_yAjJEdjTQXicaJA@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 11 Sep 2025 10:34:53 +0200
X-Gm-Features: Ac12FXx5ebSInGSvpsrj2pSWY8lp7qtZdsTImt4o0DLikSjOCGD4PzhkPWZzq-g
Message-ID: <CAHUa44HkMNO1ONTGEKHCPXRQwg3zqYf5ZHmxEijW==vbmd1LFw@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
To: Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C3AA242E9B
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.45:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_TWELVE(0.00)[24];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,collabora.com,arm.com,qti.qualcomm.com,ffwll.ch,fooishbar.org,linaro.org,oss.qualcomm.com];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.45:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: H7VPTQ5O57GKASVAENPPCZCGTZYN4E3Q
X-Message-ID-Hash: H7VPTQ5O57GKASVAENPPCZCGTZYN4E3Q
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "T.J. Mercier" <tjmercier@google.com>, Sumit Garg <sumit.garg@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/H7VPTQ5O57GKASVAENPPCZCGTZYN4E3Q/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Sep 11, 2025 at 10:00=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro.=
org> wrote:
>
> Hi Jens,
>
> On Thu, 11 Sept 2025 at 13:20, Jens Wiklander <jens.wiklander@linaro.org>=
 wrote:
> >
> > Hi Sumit,
> >
> > On Thu, Sep 11, 2025 at 9:15=E2=80=AFAM Sumit Semwal <sumit.semwal@lina=
ro.org> wrote:
> > >
> > > Hello Jens,
> > >
> > > On Fri, 15 Aug 2025 at 05:00, T.J. Mercier <tjmercier@google.com> wro=
te:
> > > >
> > > > On Wed, Aug 13, 2025 at 11:13=E2=80=AFPM Sumit Garg <sumit.garg@ker=
nel.org> wrote:
> > > > >
> > > > > On Wed, Aug 13, 2025 at 08:02:51AM +0200, Jens Wiklander wrote:
> > > > > > Export the dma-buf heap functions to allow them to be used by t=
he OP-TEE
> > > > > > driver. The OP-TEE driver wants to register and manage specific=
 secure
> > > > > > DMA heaps with it.
> > > Thank you for the series.
> > >
> > > Could you please use EXPORT_SYMBOL_GPL_NS instead of EXPORT_SYMBOL fo=
r these?
> >
> > Sure, what namespace do you want in the argument for
> > EXPORT_SYMBOL_GPL_NS()? "DMA_BUF"?
>
> I think "DMA_BUF_HEAP" may be better?

I'll use that.

Thanks,
Jens

> >
> > >
> > > With that change, please feel free to use my
> > > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> >
> > Thanks,
> > Jens
> >
> > > > > >
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > > ---
> > > > > >  drivers/dma-buf/dma-heap.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > >
> > > > > Can we get an ack from DMAbuf maintainers here? With that we shou=
ld be
> > > > > able to queue this patch-set for linux-next targetting the 6.18 m=
erge
> > > > > window.
> > > > >
> > > > > -Sumit
> > > >
> > > > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > > >
> > > > Sorry I haven't been able to participate much upstream lately.
> > > > >
> > > > > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-h=
eap.c
> > > > > > index 3cbe87d4a464..cdddf0e24dce 100644
> > > > > > --- a/drivers/dma-buf/dma-heap.c
> > > > > > +++ b/drivers/dma-buf/dma-heap.c
> > > > > > @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap =
*heap)
> > > > > >  {
> > > > > >       return heap->priv;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL(dma_heap_get_drvdata);
> > > > > >
> > > > > >  /**
> > > > > >   * dma_heap_get_name - get heap name
> > > > > > @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_he=
ap *heap)
> > > > > >  {
> > > > > >       return heap->name;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL(dma_heap_get_name);
> > > > > >
> > > > > >  /**
> > > > > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > > > > @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct =
dma_heap_export_info *exp_info)
> > > > > >       kfree(heap);
> > > > > >       return err_ret;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL(dma_heap_add);
> > > > > >
> > > > > >  static char *dma_heap_devnode(const struct device *dev, umode_=
t *mode)
> > > > > >  {
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > >
> > > Best,
> > > Sumit.
>
>
>
> --
> Thanks and regards,
>
> Sumit Semwal (he / him)
> Senior Tech Lead - Android, Platforms and Virtualisation
> Linaro.org =E2=94=82 Arm Solutions at Light Speed
