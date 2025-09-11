Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDF2CA1016
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 07:16:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5A5EB4FD77
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 07:16:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CcIEH1d4;
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D4F9543076
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 07:15:51 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b045d56e181so55890766b.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 00:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757574951; x=1758179751; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP9NntJ30KfEYObDqnhrL+C6H0K6PogP4x/qLVkNDh8=;
        b=CcIEH1d4AVqh4E2PX3wDCe/K3+8/q/IfzjRR8GMX89zWoE6Sjwj4m5Fp4M8OcM+ana
         Ns/kwbQIdlR6EZsXpRsWGGtbc/w1fFzCuk/iU3l4Z596hlmZUbz6EEvCRr4xWjnJ25S/
         lg+apEiv34cVAk3tkZPwLt1h7I6Eq9hmx7y5IQ+YpMWa+t9WGRqYboPZmdB2NOZ3gvKT
         0Pvql81hUGIO8cwQ9fgZm9yCjS9olPfixLOS739LhYzqId3PU1YVy18mMHnM7vjhM6x9
         MJLUbYlXkKqU6GUynVil7Nkct7Pl9OZfdhS4mlHdGL8TaTYcoi4mP5o+Rzp++B/7UfKJ
         iXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757574951; x=1758179751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP9NntJ30KfEYObDqnhrL+C6H0K6PogP4x/qLVkNDh8=;
        b=tB59qFSiTcVaM4g1dsF14LdRUSgDW7PrcW791E2pgOYwbHgNPf/quHYqRmW3v0SJVg
         AyW5fzQBs//pRY5gelbCuiQvzsYugdkZT3AZixJmTgf99WfJDx+Dcv949ui6sASk2Mca
         +q5YJP9jXV4/5u1kXMt3bFHlqoOMbUetwtHOn9dFOWfjNGdaM9eNZPS/0K5F1eufPN0w
         vDbHVN5vlIBsHiqUdUaibOO7ynVBqOhP8rN4O/7HfLTx5njF/lw+qMR/4bOrEOQgYrxd
         bslds0TYOQzohvQgAvenDlUy3Cc9UHI45R6mWn3MUGtIeIWA9EyPckQ3xvHCnU40TLxc
         fIbA==
X-Forwarded-Encrypted: i=1; AJvYcCWCrg1OR3Ujag32OgA+577u7PboJL1r4TGHp+LBsv4fx0OokJDQsXqD7KsOsFaDTtJfGiiWe0M=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwYkBoRzOXrihTcoLtyR1zqQHbLaeQyz+54obNTtTwANzXK+4QR
	HfPZtd7LVcO2/Z/BRIjUZ+4dSBAI3w9M+WA/qmaaxFcYYSw1eyg4fQHyXaCavMRvd9i7YRFhy7J
	/DWW4xPCW343M8DsFBx+yt2Dq0cL49m4CFe/olfrydEm1
X-Gm-Gg: ASbGncvD4uiNXQzjJ9p1gM+M1pS+uZgg5DaWPOkAfrIQiVZbKTQDFfZ57/vM34Ek/5Q
	LhlrRedjkYEmKXFwqik+xS6m8bVGP8rucSaoD8kCwPO6EyGJI59Z5Hjd1jgzesl3/67jO/rPh1j
	wue0bhE8wmdkqIewnAgRF4Q/lNZ9DpLyQIaxBO7lsURVGbcct2KNWsOyAXpmBl33K01m9oMVGgP
	Q7TBP7kds3vgR/ogljDy66SKU+7tO9IB9s23B0=
X-Google-Smtp-Source: AGHT+IHy2Mv7dBIklAlXQ3z1llA5qfh3QOZdDcp9k/xtxjZUz/DCzy7vfzzhI0hlOYW8883NeAHTA7AVAmb3DRGTR8w=
X-Received: by 2002:a17:906:730e:b0:b04:6546:345a with SMTP id
 a640c23a62f3a-b04b16c733fmr1789866766b.52.1757574950692; Thu, 11 Sep 2025
 00:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
 <20250813060339.2977604-3-jens.wiklander@linaro.org> <aJ1-YpgvGt4_6CFU@sumit-X1>
 <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com>
In-Reply-To: <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 11 Sep 2025 12:45:39 +0530
X-Gm-Features: Ac12FXy7pNPcf0b_CAub_P3Nk83sbsucFa_59lr_vcagvKGZnRZhFr4eESPBY3M
Message-ID: <CAO_48GEqkf_Jm8kSTPEDZkZy-YmT56Zs1Jx9zCvzETPsCzrkEg@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
To: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D4F9543076
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.42:from];
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
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,collabora.com,arm.com,google.com,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.218.42:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: KQ5HEC6QXDWMCLLMXSMXHQXZZWN6JZUI
X-Message-ID-Hash: KQ5HEC6QXDWMCLLMXSMXHQXZZWN6JZUI
X-MailFrom: sumit.semwal@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KQ5HEC6QXDWMCLLMXSMXHQXZZWN6JZUI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello Jens,

On Fri, 15 Aug 2025 at 05:00, T.J. Mercier <tjmercier@google.com> wrote:
>
> On Wed, Aug 13, 2025 at 11:13=E2=80=AFPM Sumit Garg <sumit.garg@kernel.or=
g> wrote:
> >
> > On Wed, Aug 13, 2025 at 08:02:51AM +0200, Jens Wiklander wrote:
> > > Export the dma-buf heap functions to allow them to be used by the OP-=
TEE
> > > driver. The OP-TEE driver wants to register and manage specific secur=
e
> > > DMA heaps with it.
Thank you for the series.

Could you please use EXPORT_SYMBOL_GPL_NS instead of EXPORT_SYMBOL for thes=
e?

With that change, please feel free to use my
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
> > >  drivers/dma-buf/dma-heap.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> >
> > Can we get an ack from DMAbuf maintainers here? With that we should be
> > able to queue this patch-set for linux-next targetting the 6.18 merge
> > window.
> >
> > -Sumit
>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
>
> Sorry I haven't been able to participate much upstream lately.
> >
> > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > > index 3cbe87d4a464..cdddf0e24dce 100644
> > > --- a/drivers/dma-buf/dma-heap.c
> > > +++ b/drivers/dma-buf/dma-heap.c
> > > @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> > >  {
> > >       return heap->priv;
> > >  }
> > > +EXPORT_SYMBOL(dma_heap_get_drvdata);
> > >
> > >  /**
> > >   * dma_heap_get_name - get heap name
> > > @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap *he=
ap)
> > >  {
> > >       return heap->name;
> > >  }
> > > +EXPORT_SYMBOL(dma_heap_get_name);
> > >
> > >  /**
> > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> > >       kfree(heap);
> > >       return err_ret;
> > >  }
> > > +EXPORT_SYMBOL(dma_heap_add);
> > >
> > >  static char *dma_heap_devnode(const struct device *dev, umode_t *mod=
e)
> > >  {
> > > --
> > > 2.43.0
> > >

Best,
Sumit.
