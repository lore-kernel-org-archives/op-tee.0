Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039FDCA0EDC
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 23:30:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 316DF4FCAA
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755214258;
	bh=OvsVxJJrFGITa8UZyrCAXbsERpjYWiqbGEh4KJfUBUY=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jpX2O5FFoL2EN7Tlyx3DGnyLtsfoVoGLJbKqh5sj0nRcQJTlCGta641IrqscQ3kOq
	 KIOHnIeFDKbdZN5Lsm2XkCLQWoBzr2742VYgRfPe0L1wevb6DcudxdpkI+iCW2Gp1I
	 fCAdMLKXUeiTsc4CxuEpg+zKV306L/AHCteQDoD9LWVchrcGZv/hujTpj8fY8XSEPc
	 ji+u7+pR15/BRa+p2atsiq6J7aZZl2FayWX5G/crMKDIjuxEv37WYeHP2sC4AJjLQu
	 RNnvC/0cb+aBwxQZTYnT6cDoLsOSknxpajm1VY9OMcqQ4HRjXq6dvINbE0D8HZHfhU
	 T1CoHU+vYohWw==
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 664C641B47
	for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 23:30:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=ZRDS7b5S;
	dkim-atps=neutral
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459fbca0c95so29635e9.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755214242; x=1755819042; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0JmiFdlp9ZkN1fxeZfgjKK4+EMYxMKsgyQh0URM5ec=;
        b=ZRDS7b5SCjK0nu/HHLWrVWouU4Wlx7MWhLO7snaD3qHIR17f7ts3wDWHfTDTFtB759
         d7/rRNPym9KQIHGvvU1zxon36T67wqx66sgkrThSayUchlqM5DUhqnBFkn+Q8DrXa6cA
         5XdZz7MZhQVZRAge4F2r7RCM1oX5QR14fTKgpzW8ysSLLguPW4WlyPjl1fsjW4udWaJx
         JIhMPVnno8DGysbEM/n+jhJ8ScVU/bprt8m8wnq684OLcFek19IT8sCmVi+tJe3IMyU1
         jXxmsBAJJN0haCAKmhuwbggbVfms0+93t4jqCZLBdvgLlrv+vNBJt8Qbj+hQGh8btKGc
         S3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755214242; x=1755819042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0JmiFdlp9ZkN1fxeZfgjKK4+EMYxMKsgyQh0URM5ec=;
        b=RqcgMsJzfp1Z1u9dAWmKRmAIS4UQhVmb3cQSPWLpZyslvmb6iXFvHk/mkI970R+rJF
         5sam0NOsAIqd+C7ZRNlzl4vdzqYYoSpBdfVEKLJXvrRmXTlBH37U7GDhyQ1qfziCue1n
         jRWxOz09eF2KmFijhHrPz1S/gPQkgzZirnqfIDDSy11hpJ8jNTxuZiHcamHDcu5RcYO0
         4FoqTIC7E/aJnECAlKsYaVx1KYVnMvnlKtXYdHVpmklI4CTtEvLMinKaBMPFlr6vb9lY
         zokBjZxOo4/GJFK1poZE6djI/d3MNbVop2bOwHhPdlt0IrSJVVVsPIYMVnr4pAuFyreW
         rM6g==
X-Forwarded-Encrypted: i=1; AJvYcCVGlaFjNRrNfO48ejAYCST9WL5tzVJb/9lZ7LNo6qUjrY4U273sySaI8psu0hrqZQ/KC6Utxhg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy5cDvq+hYqiIqivhKYPXxi78HhT/cUBV6t5UsWxnNxcbjIqNPu
	/zNYGL8N74DXE0RxLLdpArRKEmwNk9c2uNgcHezjvMlFjO2fJL0IkXUtDpORRPCoOdAUeW0MB6S
	+LhVBui+XgaYnEtPnvCeC8zeHVGBi65xjA+oxnp1V
X-Gm-Gg: ASbGncvFGfLLw1fMnZmlw9F9U2dt+MRyF5wka2Q+iX6SGPZqAVXhGvADJvDXn4EKmeG
	GhNr+1Ap2/ei1z60e+5dheKRyZm9XzrwStTt2mcHzCl1smCqPzrREwwzD2rrGrC6tbHtPwY/8Ou
	SGKtGmP/CbPec8Vzc2AHkGDDCxGQrtweCLEdr5nvO7HyekGzjsdqPm2/iQCQ8OLMLOKOh1GVIPi
	Y2bd6nkojFsfNstuOIbIbRHX6PU0PVQhyaUQh3YHEI=
X-Google-Smtp-Source: AGHT+IEEw+uzXS2i8WjnVSg7+M8YgE/PH0qtNvR3RZRshlFOrW4DkRzKM58Y1imbSzgGPptKIKq3mUjkWcuT38ZrZFk=
X-Received: by 2002:a05:600c:8909:b0:453:5ffb:e007 with SMTP id
 5b1f17b1804b1-45a20af818amr346105e9.4.1755214242237; Thu, 14 Aug 2025
 16:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
 <20250813060339.2977604-3-jens.wiklander@linaro.org> <aJ1-YpgvGt4_6CFU@sumit-X1>
In-Reply-To: <aJ1-YpgvGt4_6CFU@sumit-X1>
Date: Thu, 14 Aug 2025 16:30:30 -0700
X-Gm-Features: Ac12FXzYk8vQFwHlmYOx6GVXgELj4N91iOPnVrtkJq0EeS5aTQuf7I4LnzwBN-c
Message-ID: <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 664C641B47
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.46:from];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,collabora.com,arm.com,google.com,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.46:from];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: ON5OTTKGYJZVP5FFLC4ZUBCRWBQBKBOX
X-Message-ID-Hash: ON5OTTKGYJZVP5FFLC4ZUBCRWBQBKBOX
X-MailFrom: tjmercier@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ON5OTTKGYJZVP5FFLC4ZUBCRWBQBKBOX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: "T.J. Mercier via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "T.J. Mercier" <tjmercier@google.com>

On Wed, Aug 13, 2025 at 11:13=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Wed, Aug 13, 2025 at 08:02:51AM +0200, Jens Wiklander wrote:
> > Export the dma-buf heap functions to allow them to be used by the OP-TE=
E
> > driver. The OP-TEE driver wants to register and manage specific secure
> > DMA heaps with it.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/dma-buf/dma-heap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
>
> Can we get an ack from DMAbuf maintainers here? With that we should be
> able to queue this patch-set for linux-next targetting the 6.18 merge
> window.
>
> -Sumit

Reviewed-by: T.J. Mercier <tjmercier@google.com>

Sorry I haven't been able to participate much upstream lately.
>
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 3cbe87d4a464..cdddf0e24dce 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> >  {
> >       return heap->priv;
> >  }
> > +EXPORT_SYMBOL(dma_heap_get_drvdata);
> >
> >  /**
> >   * dma_heap_get_name - get heap name
> > @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap *heap=
)
> >  {
> >       return heap->name;
> >  }
> > +EXPORT_SYMBOL(dma_heap_get_name);
> >
> >  /**
> >   * dma_heap_add - adds a heap to dmabuf heaps
> > @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap=
_export_info *exp_info)
> >       kfree(heap);
> >       return err_ret;
> >  }
> > +EXPORT_SYMBOL(dma_heap_add);
> >
> >  static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
> >  {
> > --
> > 2.43.0
> >
