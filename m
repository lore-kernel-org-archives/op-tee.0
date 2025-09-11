Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E010ECAC587
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 07:50:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 221834FDB4
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 07:50:31 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=phXDpH09;
	dkim-atps=neutral
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 13AB142D6D
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 07:50:16 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-62189987b47so214876eaf.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757577015; x=1758181815; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ6E6bW5eiC9q7CDA3LI31bAgUOE0PZhjrPZI2/QSuQ=;
        b=phXDpH094ug7SRHwoxp754a9l+2HRwaiKAVmd1fwNA5XsKfLssglmy5mKMk49pzwX0
         vkFivyLvdtwZEu5F4Icp8Tfpmg0G4HzETEFb2dLky3AP7eKbV3aVRN4U2l132sdsTkRr
         NgU6j8fbH/L34C1++yNJ37dInGUnJRMCxkYYWiKKwCDEvWej/+czX/w/jiL5CIP+aJn3
         FUcm+0AO1vHmwuKdEZL/OyzuWg/he9YhLNWq22RK3+q1f3yxmasZ05FzEO7choo34ipq
         O5ijKuXCezuCA2et5CU/1AApLwCsLjcnZSxHLi1FNKYM3EnP+xm3lb2mGb4qX7S+Y4nI
         Ck/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577015; x=1758181815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZ6E6bW5eiC9q7CDA3LI31bAgUOE0PZhjrPZI2/QSuQ=;
        b=pQHPZU4iBozM33vHURGfGJW3jsCCQb0yvb0IeGu0fiDj0AJwqFzn9ZdgCVvZb+TqEl
         ucMQU2ssabaHpXtgAv5cHVeLsD/k2N+2S/KU8ugpLvHIh0BaTMcUhBWND3epVIxXXPre
         sqsFTFd8Rf+/xv0dUnzk8XrEihOV9sqkooFG4SeFW4NoHI11zp44Mqvk0t/hMDnccTE2
         yQEW+ct4TbSxQFPWw9sSUxgXOv5+1YoOEj99q9lgUjo6vUB+/DQio4Rm5fW6ztnA9lGR
         bEjh3JO3m7wBgbQuiZtu42rnStMPRzdMBHeGsd8TnZGfpsnGfi6nh3eMUVcYOJrrYdxt
         mvNA==
X-Forwarded-Encrypted: i=1; AJvYcCXNKBaozs9zE+uMpRlur/WCuVPWQHBjn5hhnWL8uKLE64S6rLTabw2NmnAOhtDMgmRRFr2MkmA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz/VbuGaGnLI2mIT9V62ACMIIAinVeqjbnyKdG42xfTKrbKWGIq
	hOFHPR0vYdIkB5Yw4qRdEmj9GA4MQVybMf9minhY8bPZtu+Hc5ZJrLDN6ZQLWvysugEC5JB3c4e
	W7csN9MqOO2uOowebpjgYeQBbhMfQFKgXkLUvtvZkh6uX
X-Gm-Gg: ASbGncvu3Z82S2zlAL3Cuz5mL/kz/PSJPDY3RHp9ZxuoQrT4rAMhVS6aUH1mJgTCtzK
	xdThGhtVPa/mNfy3jU/nMGIjUnf0HgX/Iv/0zqB3jgUR+EX+f68RZrrJtmfnyXv1BU26mk5SGMi
	JWqJ+YDZrmjoytrrsnX6GRRPWkOwjQDA2ZhrEU5SQ+BUqZaI110DSOYk+o8JuHr0iQOjmyHjY2S
	qihJuxy
X-Google-Smtp-Source: AGHT+IHM+qomPa7mkwPaxbF4J0ZwMvmQZ4r3i08spiXwqRdColY0ofOiN+xC4zPpK9pKKDVK1an+zwdrKVe+3sc2KLA=
X-Received: by 2002:a05:6820:1518:b0:620:ea78:ceb4 with SMTP id
 006d021491bc7-6217897a730mr7686244eaf.0.1757577015334; Thu, 11 Sep 2025
 00:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
 <20250813060339.2977604-3-jens.wiklander@linaro.org> <aJ1-YpgvGt4_6CFU@sumit-X1>
 <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com> <CAO_48GEqkf_Jm8kSTPEDZkZy-YmT56Zs1Jx9zCvzETPsCzrkEg@mail.gmail.com>
In-Reply-To: <CAO_48GEqkf_Jm8kSTPEDZkZy-YmT56Zs1Jx9zCvzETPsCzrkEg@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 11 Sep 2025 09:50:04 +0200
X-Gm-Features: Ac12FXyvCWRnQD7Gsb8VWVWslCX8Upv9AarUZnTiiQT33HIlYHfy4GNTnaJlFIg
Message-ID: <CAHUa44HHSKwiBYPMSY5hj6wyWc9-uvtQVx+JLx4M5yjD5AwyTg@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
To: Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 13AB142D6D
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.51:from];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,collabora.com,arm.com,qti.qualcomm.com,ffwll.ch,fooishbar.org,linaro.org,oss.qualcomm.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.161.51:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: LXZPQA6RKROOLTZJAK4MYBMSX4SL67SJ
X-Message-ID-Hash: LXZPQA6RKROOLTZJAK4MYBMSX4SL67SJ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "T.J. Mercier" <tjmercier@google.com>, Sumit Garg <sumit.garg@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LXZPQA6RKROOLTZJAK4MYBMSX4SL67SJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Sumit,

On Thu, Sep 11, 2025 at 9:15=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro.o=
rg> wrote:
>
> Hello Jens,
>
> On Fri, 15 Aug 2025 at 05:00, T.J. Mercier <tjmercier@google.com> wrote:
> >
> > On Wed, Aug 13, 2025 at 11:13=E2=80=AFPM Sumit Garg <sumit.garg@kernel.=
org> wrote:
> > >
> > > On Wed, Aug 13, 2025 at 08:02:51AM +0200, Jens Wiklander wrote:
> > > > Export the dma-buf heap functions to allow them to be used by the O=
P-TEE
> > > > driver. The OP-TEE driver wants to register and manage specific sec=
ure
> > > > DMA heaps with it.
> Thank you for the series.
>
> Could you please use EXPORT_SYMBOL_GPL_NS instead of EXPORT_SYMBOL for th=
ese?

Sure, what namespace do you want in the argument for
EXPORT_SYMBOL_GPL_NS()? "DMA_BUF"?

>
> With that change, please feel free to use my
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

Thanks,
Jens

> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > ---
> > > >  drivers/dma-buf/dma-heap.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > >
> > > Can we get an ack from DMAbuf maintainers here? With that we should b=
e
> > > able to queue this patch-set for linux-next targetting the 6.18 merge
> > > window.
> > >
> > > -Sumit
> >
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> >
> > Sorry I haven't been able to participate much upstream lately.
> > >
> > > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.=
c
> > > > index 3cbe87d4a464..cdddf0e24dce 100644
> > > > --- a/drivers/dma-buf/dma-heap.c
> > > > +++ b/drivers/dma-buf/dma-heap.c
> > > > @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *hea=
p)
> > > >  {
> > > >       return heap->priv;
> > > >  }
> > > > +EXPORT_SYMBOL(dma_heap_get_drvdata);
> > > >
> > > >  /**
> > > >   * dma_heap_get_name - get heap name
> > > > @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap *=
heap)
> > > >  {
> > > >       return heap->name;
> > > >  }
> > > > +EXPORT_SYMBOL(dma_heap_get_name);
> > > >
> > > >  /**
> > > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > > @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dma_=
heap_export_info *exp_info)
> > > >       kfree(heap);
> > > >       return err_ret;
> > > >  }
> > > > +EXPORT_SYMBOL(dma_heap_add);
> > > >
> > > >  static char *dma_heap_devnode(const struct device *dev, umode_t *m=
ode)
> > > >  {
> > > > --
> > > > 2.43.0
> > > >
>
> Best,
> Sumit.
