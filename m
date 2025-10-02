Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F06CAC5B8
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 19:46:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 786B4430FE
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1759434370;
	bh=aJhwi6rg9jEdvslC8cDKgP1fwXd3hdCc5/+gx2zo1yY=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Bwu//ZJ3+ZN/oHaP2tevai79SyYrmDSqOYrZkFX4uwx3e3kpCjLEHYgC78uBdrSXe
	 vn2OBjkM3RJHFpFLVe6IDyuBx+Y9K0/yxoVtjrtX9rBHTa6m2sDBWXhV0kRD2erVMQ
	 30vFNuvJ4F1/mKqwa3lsOXtvngjTKEb13cnO6IkUurJtq7S3wmKfMo3OoDHFFfL+au
	 cAUqev9cNopE3REGJXajfyhWqy14sfn1MEzv/thSVTJqamBHbk/tSiBSzn6HkytHw1
	 m+oAMXSvb5ombO+O/59FaO9FEhrChw/qRSPyT4zBKH6LkwpFU2268fUGF51EPK8u2b
	 kkFTU9weTfGsg==
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 024003F5C7
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Oct 2025 19:45:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=HrCa49Tj;
	dkim-atps=neutral
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b40f11a1027so274343666b.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Oct 2025 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759434354; x=1760039154; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4gQv0EOz4rGm7+DH/Ll/ylPaIILm6U8HqWQMm5vF7w=;
        b=HrCa49TjsgzdnBVc55wDo6M0ENYwP03WTAXhN2Dp8Id7udPuVgbHPGAE2AzHPORo2y
         hhHVeybPx3yKk3e9w271208juAwmEp09PsBplYkqaKQR63IOaD8i+p3B93eMgm/XUP9E
         QVahzrOYcunHe14jsoE+eonL/A74i+Y4kWO/Mq0iDuOBXmfND+fmUvhbx/Gv5TC6y4Qa
         HrJI+ZHKptFYI3X7smCfOiQA2f2RRwUg9IwIJn5PWzklln8UFvyNCAx2yXlhU4Mjo2Hr
         1lckSDzl7q8Bzy8dYn8J5RExc5rxKG7xc2w51j+GSuiKZM6dOJ0XKRHUPzNdEX3ewvgh
         I3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759434354; x=1760039154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4gQv0EOz4rGm7+DH/Ll/ylPaIILm6U8HqWQMm5vF7w=;
        b=kllmDB3tYWnGGvZCIY8BTXadvpWqPtp/yDiKA5wEVfGOBw5o/wAcJ9TwJccM4Oue+m
         95CjjgO3Gn8SaA6XzH43CYkIJ/YQ0R5DjaL7TmjY5lYIj8a8Kxk/NzziALo31Vib1C7A
         x8ypsYlJXruDnv2jgxcnJnE11DoXik5fNWfhtf1KfqsyUYDcBULFTq5awLXzwnWtnUSK
         I1+41hV8zucqPzlrxNSgdr+xwsHASZ22MF5m1/35G1lbwYZIHTUpFxSHVie96yxv9GKq
         SQ6LisCoD1IpExyOwhy3bKMYMCXh5s398146YRXBtnBmeIZywG5m6D9y/I3IEoHJbcZI
         6jFA==
X-Forwarded-Encrypted: i=1; AJvYcCVwccJPy/gSx5ykrkcNWtOmovWO3dx1jE4gceeIHFUhTzO0dijc8rbpXPVUpr7gx5bG/RtTx+Q=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyr1aqrjxwlKCWSQF3XVudqrSd8WjpQQvEv3aQUsrj02q3kwMVE
	eaVJ0z6j0rwS2w40smmqqFIO45XFsz8QwwpojrB4nGv5VxRFrulQmCnln9paONfQI2KM8nhIMoz
	Z0Xer+2QzBsme05Byymc8mNV8XjG/LE6M2S5Su5w=
X-Gm-Gg: ASbGnctyQG0oAclf1WQJgg6hn8ftdLN72UNVopYP0IF1MevkWMezxNefpVd6nlE8ncX
	iY6uVfKT7EesCBy/9JbFaPS15E9E9Bs3CEW9qEL3QLJi8Nn4QsqiZJhn86196yBkjVjU9L6F89T
	zaktImfMbdHte1bit0zBZK5OmFBThdqeuZKX23ZG1YKwRPcAubNUK5IiWX1tuwwWs/sSf/iK/uT
	dQDIlvSSmyFHN2Im46i6UWytg3yVCOdmcNIxZFXq50LOqdmg73EJ1CSBqG7pg5wKMc=
X-Google-Smtp-Source: AGHT+IHFUMZbxy2/RNA58+rbmrFxgard/FJeBDueJyRahdE9BuRrcf+Nu3HssY90NgcmF3JiiWGdZyfE5Xm8slA6aeE=
X-Received: by 2002:a17:906:dc94:b0:b3b:eb5f:9f1a with SMTP id
 a640c23a62f3a-b49c3933030mr76697066b.38.1759434353566; Thu, 02 Oct 2025
 12:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-3-jens.wiklander@linaro.org> <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
In-Reply-To: <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
Date: Thu, 2 Oct 2025 12:45:41 -0700
X-Gm-Features: AS18NWBdha9LdZ51VIWM4Jj3n7QLoIkRAEzrxrFPUOsILr8-gV57tRYN27CBzqA
Message-ID: <CANDhNCqS+WKhTWjeC7yBL+x4erK4S4bievTxdneaCu1haA8=hA@mail.gmail.com>
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
To: Maxime Ripard <mripard@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 024003F5C7
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.46:from];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: UJZHOXDWI7VJTCYT4LCDF3E4AUNLHBVR
X-Message-ID-Hash: UJZHOXDWI7VJTCYT4LCDF3E4AUNLHBVR
X-MailFrom: jstultz@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UJZHOXDWI7VJTCYT4LCDF3E4AUNLHBVR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: John Stultz via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: John Stultz <jstultz@google.com>

On Thu, Oct 2, 2025 at 12:47=E2=80=AFAM Maxime Ripard <mripard@redhat.com> =
wrote:
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

For things like distro kernels (or in Android's case, the GKI),
there's a benefit for modules that can be loaded permanently (not
having a module_exit hook).
One doesn't have to bloat the base kernel image/memory usage for
everyone, while still not having to necessarily deal with
complications from module unloading issues.

thanks
-john
