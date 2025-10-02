Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4587CAC5B0
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 12:59:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1820641B8E
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 12:59:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=W1BRzTT6;
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7FD7A41835
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Oct 2025 12:40:39 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85d5cd6fe9fso91972285a.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Oct 2025 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1759408839; x=1760013639; darn=lists.trustedfirmware.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tG3CglHbeY/0AI4Rz2tx44tc/toPYUH7TVppo+t14c=;
        b=W1BRzTT62IA+a6hPEnbkva+Cj6G0xkkWwKMNK58Gcute0bpOvl9lbI8Mg+siw6Z/Cv
         8/PCs+qBgW8SfKz/XYriYXNfc3eo4vjkl2LmkqAfg61VvoJHBc9hevzQpq/pf7b/iviZ
         eawgCMnZHxO0glbLuK2TY6fPbyBmGdaiuztF6d0dgJHBAdPIAtMcw/kx+C1YrTwbxCJX
         YHjCvisKldHPeBQT9YAjLYgpDJ2yHLYLNKPTIx158OYh8jzegPTOSxelBuqUVhruyxzG
         bsOuPFfQgiD36CK/S8quCKoXfoaRBa8xNSKtsFFCSRCI7Nw6B+7fqlpQBljxMIJsQ4Bj
         uZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408839; x=1760013639;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tG3CglHbeY/0AI4Rz2tx44tc/toPYUH7TVppo+t14c=;
        b=rUAc7ixRfQ5a83pgyjnOtj+kkLRMkD+rtGd7T7jfLSZjgp5VDG8rwkTRWDYSoXxdcq
         bob3+Hbs6NTNeR2m0IJ5NUhjf8ag5AcmhWNbqcol1XXjn6qThij+2Ktpe1L6+jzXEnoZ
         Q0hAmfnvXuAykdxBUZlpt4D+1m4QHU0aN9Ie+WXl2KvPGYOo/KT5lWUCrEQIcGr2SE62
         Of5tJlhHESz/SXtxNvj3LT8W9IcF3CWP7VqS2SiZ7nkm3TGRyFBm7TKuoUkf4W5y0/wE
         w8/y3EHhoLRreohX/pNa5uQxWisZwUOklQv7ij6vxa3zF2RX3D2JHLJNWClZp5+Ocjcy
         qk4A==
X-Forwarded-Encrypted: i=1; AJvYcCWOLRTZnJX37hy8E60Yvd7xvGbqI+5EXb4qokVBP95HnroPgMu8V29ThGYqg6t7CK+JXneeTTs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxNyKBQEOPz1FjE2auHTeLGO6/Mma1WmoBXgztUR71hjs0LOm8d
	gYdFcRkzj+siTTX9Y2wX2NSlMNRovxgZx2K5BrcDc7VWZH5UPyQgFYHputgQdBlT4xQ=
X-Gm-Gg: ASbGnctqtC3ng1gtuLK4hN6FpmsG1QK+Y0IghZp05Oz7lUXsWp/OIE5oNtFs1BEKpkY
	JTmGH7BZqYj5boVpSmObSL2B4Zb1Vie79DAr9fMEJJAi78dt2AQewRiz7mUv1NE7hXQmZI7QpBS
	UUiJDGerGSoxjZfdc3CtUCrRiV4hE7frdItF2/+BRQQGZ+J/ZO4mnz2DOdgyWzGNji1EMjyOakK
	btObj1MooKmUplcmzpvQKHEeUalnR5358M3cJt3z+ANF7MF33HmxVlxDMRYd9dhm9D3rAqD5qHr
	sEc4gFKux/AJZyie2WCQ/kcF3Yd+UmOvC73wfwvM+CHiuzmw8cfCEgZh6bIUKckqrYXN8YINnHf
	ZH9ry1m+klbK+seSj4tjuunBZ4ojdqq/PzP55J5iQ61a81eLI/bKvqFNOs37+3/w=
X-Google-Smtp-Source: AGHT+IHfFbRDc0lxQJHEnEb/USvJWquapfe/e1sD30gNrrrl/FzbGv+DojWArzyJNLJRhyT1vMSzeQ==
X-Received: by 2002:a05:620a:1a0c:b0:85e:5022:33b7 with SMTP id af79cd13be357-8737780ae60mr1022559585a.72.1759408837081;
        Thu, 02 Oct 2025 05:40:37 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:ebd3::5ac? ([2606:6d00:17:ebd3::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129fcdsm200898385a.13.2025.10.02.05.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:40:36 -0700 (PDT)
Message-ID: <9ca0e8b7b644637101f8bbc3f69cb71f20665f04.camel@ndufresne.ca>
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Maxime Ripard <mripard@redhat.com>, Jens Wiklander
	 <jens.wiklander@linaro.org>
Date: Thu, 02 Oct 2025 08:40:35 -0400
In-Reply-To: <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
	 <20250911135007.1275833-3-jens.wiklander@linaro.org>
	 <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-45N4bvp/oD9a6lFdlKUD"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7FD7A41835
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ndufresne.ca,none];
	R_DKIM_ALLOW(-0.20)[ndufresne-ca.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[ndufresne-ca.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.222.174:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2606:6d00:17:ebd3::5ac:received];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.174:from]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: nicolas@ndufresne.ca
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: G57SAMMBZZDZWQPA2QCSDEJFR6JSHEQ7
X-Message-ID-Hash: G57SAMMBZZDZWQPA2QCSDEJFR6JSHEQ7
X-Mailman-Approved-At: Thu, 02 Oct 2025 12:58:46 +0000
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G57SAMMBZZDZWQPA2QCSDEJFR6JSHEQ7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>


--=-45N4bvp/oD9a6lFdlKUD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 02 octobre 2025 =C3=A0 09:47 +0200, Maxime Ripard a =C3=A9crit=C2=
=A0:
> Hi,
>=20
> On Thu, Sep 11, 2025 at 03:49:43PM +0200, Jens Wiklander wrote:
> > Export the dma-buf heap functions to allow them to be used by the OP-TE=
E
> > driver. The OP-TEE driver wants to register and manage specific secure
> > DMA heaps with it.
> >=20
> > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> > =C2=A0drivers/dma-buf/dma-heap.c | 4 ++++
> > =C2=A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 3cbe87d4a464..8ab49924f8b7 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -11,6 +11,7 @@
> > =C2=A0#include <linux/dma-buf.h>
> > =C2=A0#include <linux/dma-heap.h>
> > =C2=A0#include <linux/err.h>
> > +#include <linux/export.h>
> > =C2=A0#include <linux/list.h>
> > =C2=A0#include <linux/nospec.h>
> > =C2=A0#include <linux/syscalls.h>
> > @@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> > =C2=A0{
> > =C2=A0	return heap->priv;
> > =C2=A0}
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * dma_heap_get_name - get heap name
> > @@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *heap=
)
> > =C2=A0{
> > =C2=A0	return heap->name;
> > =C2=A0}
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * dma_heap_add - adds a heap to dmabuf heaps
> > @@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct
> > dma_heap_export_info *exp_info)
> > =C2=A0	kfree(heap);
> > =C2=A0	return err_ret;
> > =C2=A0}
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");
>=20
> It's not clear to me why we would need to export those symbols.
>=20
> As far as I know, heaps cannot be removed, and compiling them as module
> means that we would be able to remove them.
>=20
> Now, if we don't expect the users to be compiled as modules, then we
> don't need to export these symbols at all.

Maybe I'm getting out of topic, sorry if its the case, but making that a ha=
rd
rule seems very limiting. Didn't we said that a heap driver could be made t=
o
represent memory region on a remote device such as an eGPU ?

Nicolas

>=20
> Am I missing something?
>=20
> Maxime

--=-45N4bvp/oD9a6lFdlKUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaN5ywwAKCRDZQZRRKWBy
9KyVAP0e+zNS/qwzQzV67XRNZS/HR4iYLotJyohgk+o985wA0gD/cUs7EW6a2cas
LUv2nPsRzhxVleDso0vC+2RD1vBV7wE=
=kgiD
-----END PGP SIGNATURE-----

--=-45N4bvp/oD9a6lFdlKUD--
