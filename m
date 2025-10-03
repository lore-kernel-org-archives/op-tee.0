Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C32ACCA471
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 13:23:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5C11E41B41
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 13:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1759497826;
	bh=dsc0ppfIPY/8mXhi22n4Pmr2Qi2oy/rvVbX2avU6HNI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=u+9oO2MB/bESmSh+YQde9gvyW1Ecw9vxBMsNJjd66c5FxJ0qQUD/oAdn3TgyoP5B1
	 qIPQZ4WZWNIlr2RxoCbTUGDKvdy9OyZ9/z2PKyWGcqq29D2Y4w5Jx5EkylVVywbP+4
	 zSeWjY1m823rU9m2A5kZR90L1l5AyJLaw/lMyfZ4tib2s1hZGGWNvp7puOLEqxz9Lx
	 0Anv+EOiAS2UWNvD8NeZO2GiSym0ARaQk8QpfAZGQTJAh/oXawCYnqZmAbCvdnwxLj
	 ctFkK1iscC0fl0KfRB5HEYXfmETJs3eTi76Fepneuhr/6kDJMJNfjEFVOCGgXcZabS
	 oqCvNNFdR0nIw==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C57604185E
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Oct 2025 13:23:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E5wwArvQ;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759497810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3OgrM6kqtp8r+T8wasXEeO2qtaqUyEZzjkjuxIwoHg=;
	b=E5wwArvQ06M0oeU3aLaTOOZd0g+h64AlYmrj8wYYsA78jaBEns2X+ir1C8YoFwaDhYaxd5
	rzxdBcGWD4cXZFp8Wy50C+RMjlzHQfOkyf42IfFl+LkuI7SZ5x4ymEfF35cfjT7FGZzegj
	lm1bwD3TNEniFUAOyhCzBgDKZgdx0EY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-h5XM6FW9MsGxGWXFEEd85g-1; Fri, 03 Oct 2025 09:23:28 -0400
X-MC-Unique: h5XM6FW9MsGxGWXFEEd85g-1
X-Mimecast-MFC-AGG-ID: h5XM6FW9MsGxGWXFEEd85g_1759497808
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so15534835e9.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Oct 2025 06:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759497807; x=1760102607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3OgrM6kqtp8r+T8wasXEeO2qtaqUyEZzjkjuxIwoHg=;
        b=fq1FRiFkD9bwQxI31WtR/yAFVXkKUiFIMBDFx44sqFZwpyuVT9vJjKamXvhRoGRTnG
         tquFWqeWn/U4q5AhjNcOOomHEBc8gHCiDoMrRnhcpxV6jr3U6WajXV/E83Tu0oUbNESm
         QvMXaXqn/LgRuDbsrJUnW1slUMZtbrDlT0tmiXseI0yPxLY/BGp1iSjlsMjkn9ypEmY8
         FS9O6VJEpuWSQvHPbSmWHXe4enFsRP5rqk8cGNesq66SoPr4Ohk0cIZV+nqa736C5bO+
         7Ovk8ejztb15BF9FMNxulDhNBJ8gWE5ro2VxFez+ECWpEN1yeNefxiGh9djLJnmmZx4M
         Jl1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpJ48cw2Q2rgbc2T6ZWeC2Vm+ncARsb0wEnWS6y/9hBZ1UNLzU3B+B56f+Kl606oGrKF1mtfs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxK5ExuMJgEJj6jUvlObyKSLuz1tF1w7ryvYhwN1bQ06GRsEW2L
	FHny84t41taOTS5+AVP97Ajj1VdcZMMLeYoRBW5iuVqj/rnD9XZWLl1S/GVA8vNlijr7Lyexhzd
	9HK3rlVkHULgg1+P7MvKa60csnxhKNacV9cPh7lfCv1n/R4nIPa2QqqO/2IbBdwb997JNO/Y=
X-Gm-Gg: ASbGncsMVjPGbS14rroExOPBkWzA0DKGI8Cuhglyqdw28gklXzBSX/YDI98VG7Ptqwx
	mKxBrKNDapCeXmBXmXl35ZoYROpOdhNCKcLjTNFjco+ilxKbrgYS4yuEtmtV7QUq0GNVJabgZH5
	/6vuLMYIAzUATV+GE3N0bQ3qhc0BuloM2+dGyotItGzsFND3+Jv1wg9FOFh8HyyebjQDFLDMzFX
	BaeEy1r6qc8/kTsXlYrAiA9NF7EdgZMlX7KRqAMBtBx7UY1LEf7BzecAGjSCsg4jkfYg/IufJCn
	mq0j8Fr9LtEmD4FFBvyNrg==
X-Received: by 2002:a05:600c:4510:b0:46e:59bb:63cf with SMTP id 5b1f17b1804b1-46e71140be1mr25355445e9.24.1759497807556;
        Fri, 03 Oct 2025 06:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOjaj75XO52nWI2I6UTsKjmFKM3jXrNLUe3y6zOumiOqPFkEXqNu9rSWvZBXSmGhaUe3KVg==
X-Received: by 2002:a05:600c:4510:b0:46e:59bb:63cf with SMTP id 5b1f17b1804b1-46e71140be1mr25355005e9.24.1759497807018;
        Fri, 03 Oct 2025 06:23:27 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b5csm7942733f8f.5.2025.10.03.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:23:26 -0700 (PDT)
Date: Fri, 3 Oct 2025 15:23:26 +0200
To: John Stultz <jstultz@google.com>
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
Message-ID: <20251003-brilliant-golden-lion-fbedc9@houat>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-3-jens.wiklander@linaro.org>
 <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
 <CANDhNCqS+WKhTWjeC7yBL+x4erK4S4bievTxdneaCu1haA8=hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bmweveq2oxpjd6s2"
Content-Disposition: inline
In-Reply-To: <CANDhNCqS+WKhTWjeC7yBL+x4erK4S4bievTxdneaCu1haA8=hA@mail.gmail.com>
X-Rspamd-Queue-Id: C57604185E
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	RWL_MAILSPIKE_GOOD(-0.10)[170.10.129.124:from];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	DNSWL_BLOCKED(0.00)[209.85.128.71:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[redhat.com:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[170.10.129.124:from]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: I4LZFOICHQZX6I434RKCCKT7P5LCDGXE
X-Message-ID-Hash: I4LZFOICHQZX6I434RKCCKT7P5LCDGXE
X-MailFrom: mripard@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I4LZFOICHQZX6I434RKCCKT7P5LCDGXE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Maxime Ripard via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Maxime Ripard <mripard@redhat.com>


--bmweveq2oxpjd6s2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
MIME-Version: 1.0

On Thu, Oct 02, 2025 at 12:45:41PM -0700, John Stultz wrote:
> On Thu, Oct 2, 2025 at 12:47=E2=80=AFAM Maxime Ripard <mripard@redhat.com=
> wrote:
> > On Thu, Sep 11, 2025 at 03:49:43PM +0200, Jens Wiklander wrote:
> > > Export the dma-buf heap functions to allow them to be used by the OP-=
TEE
> > > driver. The OP-TEE driver wants to register and manage specific secure
> > > DMA heaps with it.
> > >
> > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/dma-buf/dma-heap.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > > index 3cbe87d4a464..8ab49924f8b7 100644
> > > --- a/drivers/dma-buf/dma-heap.c
> > > +++ b/drivers/dma-buf/dma-heap.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/dma-buf.h>
> > >  #include <linux/dma-heap.h>
> > >  #include <linux/err.h>
> > > +#include <linux/export.h>
> > >  #include <linux/list.h>
> > >  #include <linux/nospec.h>
> > >  #include <linux/syscalls.h>
> > > @@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> > >  {
> > >       return heap->priv;
> > >  }
> > > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
> > >
> > >  /**
> > >   * dma_heap_get_name - get heap name
> > > @@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *he=
ap)
> > >  {
> > >       return heap->name;
> > >  }
> > > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> > >
> > >  /**
> > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > @@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> > >       kfree(heap);
> > >       return err_ret;
> > >  }
> > > +EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");
> >
> > It's not clear to me why we would need to export those symbols.
> >
> > As far as I know, heaps cannot be removed, and compiling them as module
> > means that we would be able to remove them.
> >
> > Now, if we don't expect the users to be compiled as modules, then we
> > don't need to export these symbols at all.
> >
> > Am I missing something?
>=20
> For things like distro kernels (or in Android's case, the GKI),
> there's a benefit for modules that can be loaded permanently (not
> having a module_exit hook).
> One doesn't have to bloat the base kernel image/memory usage for
> everyone, while still not having to necessarily deal with
> complications from module unloading issues.

Ack. We should at least document it then.

Maxime

--bmweveq2oxpjd6s2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaN/OTQAKCRAnX84Zoj2+
dtj+AX9Z6mfBBmJxP6k0eTgjg+qG1U5U8jSi9QuHw6zfKnsmrcwgrOYtur1R6Pew
cpDvn3QBfR0GnE+hRXWrYWoFPItAzGGTqManWkqHoYmL3MvlOwO7ECQmeIAe8L4a
Hi/ZAVgLUQ==
=rb0f
-----END PGP SIGNATURE-----

--bmweveq2oxpjd6s2--

