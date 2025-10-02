Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40FACAC5B8
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 12:17:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C68E142F77
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 12:17:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bkxdMWP/;
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 91AC241853
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Oct 2025 12:17:39 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7bcfafec537so666182a34.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Oct 2025 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759407459; x=1760012259; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGsaoeFP4OZoz2ETAlY65ICprHno78vJEjUPKXAIoTc=;
        b=bkxdMWP/67TQj6LymNSIi2MHr/Vf1ZhfqyCsqbRXrEY4Ue0EDMywGHeVG5LYcpZ6So
         XkQXaqs7ewnQsazsyt+NoiQuiFpbEjGcvid54lYW3h74EFhAA0RADlA0gounQp5vbLAI
         yUtfy5K5Mjk64CSob3oxFkq903yuJOPPcms/gnLcBcewDB1BTBF3iufGmTGfJ55GUWK/
         RRVGvQVF8QNOXZjS9BOKzvNPPe4ZtJfirBGH9NMW+X2/bEILhbH2CFAKKIj4lKEPV5pT
         ux/vmWdfifE0e+4rSnMj2tCPnijAr+O3tBnjHQudJMzybiZdAdi5uQ1+YbQ5ID0gIwWk
         smRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759407459; x=1760012259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGsaoeFP4OZoz2ETAlY65ICprHno78vJEjUPKXAIoTc=;
        b=p3ipic3LLH7AypJV2G1pLPOae4142N7CvgQt+5QURQghUwbwfXlU1aK5PyisMU4O69
         VCiXRfH4g1+UY+H7A8w6YwYThFPvRd9i4dXi7fMfpPh/sSPNjZhpzo4MLyMlPUKNWNBi
         YGk9atiA6XibeqW8WWywMDaPTnhdtGU8aC32C8EXeX8PmbxLoK8u8KJzGv/9AXPXi6dO
         MMnas2/ouMmwuuwD0G5NwMSErMxhLFL3Se4dGexgp0LU7Xnh1dOLUyv2GKJfqXyZ+afc
         HBbUJ/Sh2kFNrETmam0j32+NeBYjz+fSYQFfIkg9+uBsbx90ZYVtbr8lOA+0gaiJC646
         ri3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKMoeQCtBuDPD9ZIipZ1b/EOx5CpTQrAo2BKQztuO+vFAboVmeXsVsaI68EHeCf5IuCqw31bk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzZvi/F+AFOBBsxQ8lO1Vnrcddz5jKFCSL+VKvGiZQqWmbmr2TG
	fIIxxm+G8Zi+Z4dBsVluI3I6+CXc/MaDCqstHh0wfUZUaItAM/1l1Cfl+xCPCJMVVu2Sagr7Mtq
	vIqv8Kfpl0iZfTe3/OQgkLJ+9ARed+pr8yTntSMQc2DET
X-Gm-Gg: ASbGnctyQojVeWxQjMiyivBNRxOuYvaAbNpuiz1yzloDGC+AKi0Dh2wVlZXgP+g9TQE
	3XEqdm9ZZfnzl+YnalcbBfwxzx+5WcyIjDyf2BsjjYSOwh+xm9gtA5ORFUMzitGfZBd6INBaXyo
	JJHBxpXDSmDOObNjE3euOMVsVDrLxerD9A1uaz9TJlKdcoN37+t7qltmJP1f3fhjK2knwpX56W2
	42PVn82KO/DrIoeX2mgXrpfJkgdJMzEy2b1DZZiQfSdv1M=
X-Google-Smtp-Source: AGHT+IEfetTH6APo2ttHfmQ/HD9OGM73G7JSFHlGpVInBdI/YWyuV7C6xZbIUTpTHqoh4vyg+PN0N+hbiXUnxi0n74U=
X-Received: by 2002:a05:6808:6f92:b0:43f:7287:a5de with SMTP id
 5614622812f47-43fa41ccaafmr3695885b6e.41.1759407458820; Thu, 02 Oct 2025
 05:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-3-jens.wiklander@linaro.org> <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
In-Reply-To: <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 2 Oct 2025 14:17:27 +0200
X-Gm-Features: AS18NWAi5-v--TYVxyZOnQiOgWgAxWVYCjBvI6uxhCSDTvPtA0sa1z_it1UPtE8
Message-ID: <CAHUa44GtAY7=r_bA7ETOsBq+K4w6r1CtY7T9rFn224mshA5GYg@mail.gmail.com>
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
To: Maxime Ripard <mripard@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 91AC241853
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.45:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: EHH2VSPHBC43TOGNIQVOFFLEZB7XI7IA
X-Message-ID-Hash: EHH2VSPHBC43TOGNIQVOFFLEZB7XI7IA
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EHH2VSPHBC43TOGNIQVOFFLEZB7XI7IA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Oct 2, 2025 at 9:47=E2=80=AFAM Maxime Ripard <mripard@redhat.com> w=
rote:
>
> Hi,
>
> On Thu, Sep 11, 2025 at 03:49:43PM +0200, Jens Wiklander wrote:
> > Export the dma-buf heap functions to allow them to be used by the OP-TE=
E
> > driver. The OP-TEE driver wants to register and manage specific secure
> > DMA heaps with it.
> >
> > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/dma-buf/dma-heap.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 3cbe87d4a464..8ab49924f8b7 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-heap.h>
> >  #include <linux/err.h>
> > +#include <linux/export.h>
> >  #include <linux/list.h>
> >  #include <linux/nospec.h>
> >  #include <linux/syscalls.h>
> > @@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> >  {
> >       return heap->priv;
> >  }
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
> >
> >  /**
> >   * dma_heap_get_name - get heap name
> > @@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *heap=
)
> >  {
> >       return heap->name;
> >  }
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> >
> >  /**
> >   * dma_heap_add - adds a heap to dmabuf heaps
> > @@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap=
_export_info *exp_info)
> >       kfree(heap);
> >       return err_ret;
> >  }
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");
>
> It's not clear to me why we would need to export those symbols.
>
> As far as I know, heaps cannot be removed, and compiling them as module
> means that we would be able to remove them.
>
> Now, if we don't expect the users to be compiled as modules, then we
> don't need to export these symbols at all.
>
> Am I missing something?

In this case, it's the TEE module that _might_ need to instantiate a
DMA heap. Whether it will be instantiated depends on the TEE backend
driver and the TEE firmware. If a heap is instantiated, then it will
not be possible to unload the TEE module. That might not be perfect,
but in my opinion, it's better than other options, such as always
making the TEE subsystem built-in or disabling DMA-heap support when
compiled as a module.

Thanks,
Jens
