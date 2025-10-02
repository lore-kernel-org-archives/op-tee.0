Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9348CAC5B0
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 07:48:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D091F41BA9
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 07:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1759391279;
	bh=o5Ski1KE2v6C3aWnVPjLwK3jMJPNXrvIgg9TOn5sZUg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=1j9sEpdgitRqOUIzVj7Dez/8ayzzY0SsC9vdGm7vDS6bO2E7oizEuhvB76/du777W
	 jKlpYX4UMNElRcpGxFlj27o6LdLM0VuQFangUNNjVLqnKrgyRREROlEtH6SOpRJFBy
	 H3CQlhNc5xxhEm5u/2+I4jGT5GBISrvw970qUkwIaN2FRNNjup2T/xOLcb3fQPAXC1
	 JnEgHpDcC0T8MVY7+nV+xO1rBo6oW8PPskAkagZgo5BSoLwWNz2ev3Bph6CpI2t7PH
	 vKSlBGoSduIjGhc9qWfcBXTscE0GJOX/IqKPRmcrU3DcUIJ/uY8htiKd+IXknWAyI9
	 KbzU6ZHnWDUPg==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 684954187E
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Oct 2025 07:47:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Feo45RUn;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759391265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgVDpIUaXbRIFaGTvmSsiE/BFfaSBmSlnmsfDON0gMA=;
	b=Feo45RUn5sJEzBNX3IBbDb+Dn/lix3vmjA9pySojguy1Xop7mYMj2yN/yH3iotbrD+CLYp
	KGKsRwvEd4Lw8k6ChnnJZA74ttDxHnRzWI28FdehjaPQkR8S0uJL1q89R9wmOL2g8sdXq9
	L2gGBuYL8nIrR5OUBrVPlz6Rs27zsfM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-n6foCJgLM0qXqALeeOS7rg-1; Thu, 02 Oct 2025 03:47:43 -0400
X-MC-Unique: n6foCJgLM0qXqALeeOS7rg-1
X-Mimecast-MFC-AGG-ID: n6foCJgLM0qXqALeeOS7rg_1759391262
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f42b54d159so442799f8f.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Oct 2025 00:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759391262; x=1759996062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgVDpIUaXbRIFaGTvmSsiE/BFfaSBmSlnmsfDON0gMA=;
        b=U1RqitNRkjNquG5p0Or/Rcy1//64GE0DyKS8HP1h4VolDYzFptGWCu9gEYax6cijim
         YuXwWJmIoCCXK97tTsWuKaMB7BPcNHrPscLq80hLhZHgpynH/+pX3Y5y4X31h0XL/IYg
         Sdy2w5RX/qTcERhnZ75W7tAkkXCM69Tbn2uR4fW3dsdkQEfU35zDjKqP7uwZdzLZZJ6U
         fgbc4chX8bxLHMy+ZRZIrb8l2OhsuAXYTBZ3J3KVjRTVpjxymXUY9np5qD1J34mx1X3E
         twbwMrg7iTXFMjHgFWXJRe40+2KFKivUIykOWgtm4Il2LSfNOtXJ7rFaGveVHD/sOIkp
         AlVA==
X-Forwarded-Encrypted: i=1; AJvYcCUd/xJe20y9stfcY818O/aqjyO1Mot9RMwRwl9VWPcWq6yUkosJ0WFRDf7AVrT9PTw5Pd0XSEY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzS6TTs+YhZz22xjalB8nNeeEgQBagCThxNtV3OEnYWPELYT5iX
	3bn8KU1dETBiyFjPzcw/CMFh3WpywXVY6KxQuycX8rcfpeGlpdzj7018juFCHY3DGzXtevHFkbk
	0jOw/qtnpOoszo6DjiwBW6jDjXVJ/XZo2LAK1iHM9A8ayrDQ/ev5l59c0rm3Gu2Mc54tBCpA=
X-Gm-Gg: ASbGncua5BB8c3FuIpXXjAPSbMU6k2AWm/Jr9wfG7dDtP1NnKxhd+2Cx7gWU6FYMwkl
	YOz5x0JyAYmsU3ZEB/v5NTvPkI1km+NWChzb5hu6nqPn2lPpAoLlkpZTEl0dBLFA/rbPuXZ7m/a
	ECjm3f9axTTwvgR9i0KYgrttyed56q0NxeeLtY1V7WOFGFhB1O4Wl9ny7rD8ewy0Yly478/00dh
	sUc7GWCqM3Shs3UxJTmqoItF3CBbhjhgTNLBgOA2C1etzk4TQIy50r1xL8NlH2xt2HgVcFOraDS
	unklEHP0Ym3cA236iSB1ww==
X-Received: by 2002:a05:6000:615:b0:3eb:4e88:585 with SMTP id ffacd0b85a97d-4255780bf79mr4246073f8f.29.1759391262072;
        Thu, 02 Oct 2025 00:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP/KnwbkkSVeQQvgR4f/j6yP7T3XyqaNDmBwlBCTQIJSAplcQo89U5KExVEQ0LiNnNhN8Wxw==
X-Received: by 2002:a05:6000:615:b0:3eb:4e88:585 with SMTP id ffacd0b85a97d-4255780bf79mr4246043f8f.29.1759391261558;
        Thu, 02 Oct 2025 00:47:41 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b5csm2470879f8f.5.2025.10.02.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 00:47:41 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:47:40 +0200
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
Message-ID: <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="gqzh2ah3mmdu76ac"
Content-Disposition: inline
In-Reply-To: <20250911135007.1275833-3-jens.wiklander@linaro.org>
X-Rspamd-Queue-Id: 684954187E
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[redhat.com:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	RWL_MAILSPIKE_GOOD(-0.10)[170.10.129.124:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a01:e0a:b25:f902::ff:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[170.10.129.124:from,209.85.221.72:received]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: UDWJJMVBDID5H7AJJF2F5WRG3OPMSVLS
X-Message-ID-Hash: UDWJJMVBDID5H7AJJF2F5WRG3OPMSVLS
X-MailFrom: mripard@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UDWJJMVBDID5H7AJJF2F5WRG3OPMSVLS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Maxime Ripard via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Maxime Ripard <mripard@redhat.com>


--gqzh2ah3mmdu76ac
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
MIME-Version: 1.0

Hi,

On Thu, Sep 11, 2025 at 03:49:43PM +0200, Jens Wiklander wrote:
> Export the dma-buf heap functions to allow them to be used by the OP-TEE
> driver. The OP-TEE driver wants to register and manage specific secure
> DMA heaps with it.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/dma-buf/dma-heap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 3cbe87d4a464..8ab49924f8b7 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -11,6 +11,7 @@
>  #include <linux/dma-buf.h>
>  #include <linux/dma-heap.h>
>  #include <linux/err.h>
> +#include <linux/export.h>
>  #include <linux/list.h>
>  #include <linux/nospec.h>
>  #include <linux/syscalls.h>
> @@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
>  {
>  	return heap->priv;
>  }
> +EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
> =20
>  /**
>   * dma_heap_get_name - get heap name
> @@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *heap)
>  {
>  	return heap->name;
>  }
> +EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> =20
>  /**
>   * dma_heap_add - adds a heap to dmabuf heaps
> @@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_e=
xport_info *exp_info)
>  	kfree(heap);
>  	return err_ret;
>  }
> +EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");

It's not clear to me why we would need to export those symbols.

As far as I know, heaps cannot be removed, and compiling them as module
means that we would be able to remove them.

Now, if we don't expect the users to be compiled as modules, then we
don't need to export these symbols at all.

Am I missing something?

Maxime

--gqzh2ah3mmdu76ac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaN4uFwAKCRAnX84Zoj2+
dgXFAYCRqMeTP57unkLdOGOydUleXNO4Hyw5XxsQDOrGvzMhBXOO+wkmNxAyspbp
Ufq67PMBfjTtOUKXQIyMWncxOakNOIj4KKpCcpuXU8G+m0dpGkCeFoK4Z85nhhK9
lbC1byfHEQ==
=wMRm
-----END PGP SIGNATURE-----

--gqzh2ah3mmdu76ac--

