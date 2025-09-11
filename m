Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3467FCAC587
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 08:01:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3FEAF4FDF6
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 08:01:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A2WtBrC9;
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1CF9C4E14D
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 08:00:48 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b02c719a117so73911466b.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757577647; x=1758182447; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1PODi6H2K7+3LlGxoQuwHZt3UE/qkC9ZdWrwkyFJNM=;
        b=A2WtBrC9jl9rgneB4AUBce5c55lU0So+Ognh5b3QTVRK+iDOCI4MeinklNZREAcTa1
         CoYglPUi+nidRb/6YUR2iyENudHQ72rdDM95hglM4mX2Copx/b9gY3DQiZRu1QsXWFwb
         B86pdYH2qvp4mYvZlSKQyT1lNLs+Q+A9TNgZqDVRc+uFQmIxGA2bYsR/lI7tekZAwzzG
         qtK8EHpgdYyOy27f4uwi0/n7dw7zcKBqTdPFuV7KHMwYuVI+ZndlB9DdukobtISz1emf
         mVeQLiSRnxzFgSo6IcnpcwJvbUx6+hGdzwnrZIh6Sd/+9a7AE9XukxDpJsaJzVvXR876
         Ywfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577647; x=1758182447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1PODi6H2K7+3LlGxoQuwHZt3UE/qkC9ZdWrwkyFJNM=;
        b=id8JYSMmTpV6C/6Zg9ABDUyCAx2BvhGk+iCcX4y5IwoQ38/kcda1ymy668Ul1Yl98O
         yg8FLy9Qu2/AWC737rA1OG5Y42dfHNJTPwKSMDcRdl5ki57Vwtwgc18ASqyJPlE0+2xc
         /Zgc1Bsk2VYbEyC1A6kBNijoGfEvuyB6ummzKoN3YGj3HgH7mzZHziRonwdAgWXwlqP5
         Bb1+T1wvyBF2K9RdUn5tR4G0c/5UAysIWvOpW+fAuoICF9WMA7c3AE0W/DIqYH4Rq+tM
         XI/Ck2D5ItAr5jjBU+YxxZryEE3Xnob+RTg6Tz7ZXynYKmqtG6YjqY98zW6Jrk9ezXue
         XGhA==
X-Forwarded-Encrypted: i=1; AJvYcCX8TUpSiq5A0qCchYk5I26AhvnbuT1T2kzGWaNgfadLpMAE/Ob2mXYWKVQB1E7/sbE+tsobNEM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxQ8DuD53uegqFCx+T2jiwVmD/pC8V7hK2zbCY+gNoqf8gU86jm
	Lovo0t+bsbpFZ6Plj4DykxPxaVzRXY9OQI47SYNAgw1kG3wIITODmWqkatW4eKlV/9rhmaa7vm3
	At3F1O4yu3wPs+cBSca7tYZAQxFlE9UZWv+pkfN5WeMWS
X-Gm-Gg: ASbGncuRzIKTN2rkRwTzBQ1R5rRw0bPx99zJpqAy6ChmN/g4hxnk0bEokVR2Iytac/w
	pBuSXyzctR6aKSkNvYgyLPlrwcZYBWFtFaX4TU8WE0vz7TqsUNSBvUo64iRh7fj8+BvYqO9NY/7
	QVQu0truUHOrbBtxxrTz+MbrccdS/z666M/2NdcBtull+kt9QTf/b3P3/HdA24xEtkRiGLnL0+p
	Qfggw6r/3eBLogxiJw1yhMekrmjueQN0JipXpFvQplccePedA==
X-Google-Smtp-Source: AGHT+IGzEzYwQLiPc3IcgYMCTY8qsO9y3WwakWS4JOu30bLWGh1BqDh6LLf50f7d7Tw863clhJFa4G2RQKg6ioIUUPY=
X-Received: by 2002:a17:907:d16:b0:b04:568b:8a42 with SMTP id
 a640c23a62f3a-b04b14bbbf0mr1838289166b.29.1757577646906; Thu, 11 Sep 2025
 01:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
 <20250813060339.2977604-3-jens.wiklander@linaro.org> <aJ1-YpgvGt4_6CFU@sumit-X1>
 <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com>
 <CAO_48GEqkf_Jm8kSTPEDZkZy-YmT56Zs1Jx9zCvzETPsCzrkEg@mail.gmail.com> <CAHUa44HHSKwiBYPMSY5hj6wyWc9-uvtQVx+JLx4M5yjD5AwyTg@mail.gmail.com>
In-Reply-To: <CAHUa44HHSKwiBYPMSY5hj6wyWc9-uvtQVx+JLx4M5yjD5AwyTg@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 11 Sep 2025 13:30:35 +0530
X-Gm-Features: Ac12FXxwSUSxE1PNcza1ZTKnBgiGX0FqXLDfvqSE4P5WPQr00OaAEtYCSrcigho
Message-ID: <CAO_48GE=FHaNzybUxjY=igyOO1oasKb9yu_yAjJEdjTQXicaJA@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
To: Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1CF9C4E14D
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.52:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.52:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 7272EEUO2OAIWSHOVYNZWSK4TOD56ILQ
X-Message-ID-Hash: 7272EEUO2OAIWSHOVYNZWSK4TOD56ILQ
X-MailFrom: sumit.semwal@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "T.J. Mercier" <tjmercier@google.com>, Sumit Garg <sumit.garg@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7272EEUO2OAIWSHOVYNZWSK4TOD56ILQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens,

On Thu, 11 Sept 2025 at 13:20, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
>
> Hi Sumit,
>
> On Thu, Sep 11, 2025 at 9:15=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro=
.org> wrote:
> >
> > Hello Jens,
> >
> > On Fri, 15 Aug 2025 at 05:00, T.J. Mercier <tjmercier@google.com> wrote=
:
> > >
> > > On Wed, Aug 13, 2025 at 11:13=E2=80=AFPM Sumit Garg <sumit.garg@kerne=
l.org> wrote:
> > > >
> > > > On Wed, Aug 13, 2025 at 08:02:51AM +0200, Jens Wiklander wrote:
> > > > > Export the dma-buf heap functions to allow them to be used by the=
 OP-TEE
> > > > > driver. The OP-TEE driver wants to register and manage specific s=
ecure
> > > > > DMA heaps with it.
> > Thank you for the series.
> >
> > Could you please use EXPORT_SYMBOL_GPL_NS instead of EXPORT_SYMBOL for =
these?
>
> Sure, what namespace do you want in the argument for
> EXPORT_SYMBOL_GPL_NS()? "DMA_BUF"?

I think "DMA_BUF_HEAP" may be better?
>
> >
> > With that change, please feel free to use my
> > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> Thanks,
> Jens
>
> > > > >
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/dma-buf/dma-heap.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > >
> > > > Can we get an ack from DMAbuf maintainers here? With that we should=
 be
> > > > able to queue this patch-set for linux-next targetting the 6.18 mer=
ge
> > > > window.
> > > >
> > > > -Sumit
> > >
> > > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > >
> > > Sorry I haven't been able to participate much upstream lately.
> > > >
> > > > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-hea=
p.c
> > > > > index 3cbe87d4a464..cdddf0e24dce 100644
> > > > > --- a/drivers/dma-buf/dma-heap.c
> > > > > +++ b/drivers/dma-buf/dma-heap.c
> > > > > @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *h=
eap)
> > > > >  {
> > > > >       return heap->priv;
> > > > >  }
> > > > > +EXPORT_SYMBOL(dma_heap_get_drvdata);
> > > > >
> > > > >  /**
> > > > >   * dma_heap_get_name - get heap name
> > > > > @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap=
 *heap)
> > > > >  {
> > > > >       return heap->name;
> > > > >  }
> > > > > +EXPORT_SYMBOL(dma_heap_get_name);
> > > > >
> > > > >  /**
> > > > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > > > @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dm=
a_heap_export_info *exp_info)
> > > > >       kfree(heap);
> > > > >       return err_ret;
> > > > >  }
> > > > > +EXPORT_SYMBOL(dma_heap_add);
> > > > >
> > > > >  static char *dma_heap_devnode(const struct device *dev, umode_t =
*mode)
> > > > >  {
> > > > > --
> > > > > 2.43.0
> > > > >
> >
> > Best,
> > Sumit.



--=20
Thanks and regards,

Sumit Semwal (he / him)
Senior Tech Lead - Android, Platforms and Virtualisation
Linaro.org =E2=94=82 Arm Solutions at Light Speed
