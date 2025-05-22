Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8660BC54ED0
	for <op-tee@archiver.kernel.org>; Thu, 22 May 2025 06:57:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A941240940
	for <op-tee@archiver.kernel.org>; Thu, 22 May 2025 06:57:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sa9KtRh6;
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C7D2E4093C
	for <op-tee@lists.trustedfirmware.org>; Thu, 22 May 2025 06:56:43 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3feb3f54339so8004588b6e.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 21 May 2025 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747897003; x=1748501803; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeKMC6ZBMvoz5mZGPjKGgi0Ohr2T8fh1E4A0BZHhyCM=;
        b=sa9KtRh6XVblV0xGkxFAmvbpR3VRK4efm8Z2mqOTI34Yy7hCsBV4+oFwhwM1DWKgae
         75/Br6yLDFNC301MZ8GBVfjswbPiQo/6uFGyZC018dIJ3m8EONpUb8f/l2OLDV3saCSm
         DuVC8qxu+4dMa2UvzNzz7q9J4eZuLm2ICd+bQSSOi+14frF4Zuc/SVtdfDpl1qIW9iJ5
         dEYPB8lq/bXFLhngynpEc0yN4yu69M1MGaL79a86VseJgmJAJxlt2ZQ7Tr+ugIG2wFSC
         FiftUVz58QhpM5Co50cybqOnjY582jj+CgvyPK1eNWOKuvWxRTEF4ZY/VboP+oi2tqmf
         JPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747897003; x=1748501803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeKMC6ZBMvoz5mZGPjKGgi0Ohr2T8fh1E4A0BZHhyCM=;
        b=G0rkxJHs9EIuEItuCrR1e9fKIPFLEhHRDQowX4OrWZH3UE3vEtxcOIDFMJBi4gPk9N
         VkFU9ZTey1bvmf3hpY/ZskI65a4M1jOC1XIKusM1HxBhx7V4p/GoXCd9xBazGbVrFJsi
         W/DedvHA351O+4bX0WIxpJckcCM6wXoYJuejXVWbNRcNqqc2D5BfZ8g12K3QssFV6REg
         nyp48mP9mgZECyeX9o4RWXT+4QZwr7u/3eSRCGqLE9VasiTxNNxBPjrnlhtWjMcYzI+Z
         PuAuJvU2c3K48U94fM7OcvawwZdoVUDjklaTwlsFgf02b5ID/iQBTIZZWzgt1J7qObx+
         aP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlA4jshTjnaLqP1iPKKkX7QADWnqtMoGSyb2zspTMuuJNbirEemm2krwpsf87E/usOy19aXv8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzK3EnAh78mrf3VRlGSQJtjOzK2He7u058dr1VKQnvUd98HxzWI
	JktOS5b0lMEsgZS549q6HS1uFYc3xCuaXBKZ7yL9VBb8cADupOMo/7iI5tWvS+NImKNLYLGM6gS
	gypovGc0FUNnYcE5a98oD4+9UzrurOBkBc07+mEbCM/eN
X-Gm-Gg: ASbGncv9dCYz81qeTRg6VbG978ZZ3MWcVOzNbKSRTtMqynIYZkImI25JkLsgJ2eJljt
	Y4tkajEe8FA8Af2+hfKZb73hZ/loMnsXImeiN+5+5DBeEqOM84j7O5WUSku7DnyTImqESSieqcY
	rPqMr0NZFtn6QeYfGP6IUWeaYp/VOd7uDS0A==
X-Google-Smtp-Source: AGHT+IHkFUemf1YsBa7Ra5vRLLSyYkClMUJvfuEYqOo7C5Q/HY7RUEskcqp+LiC0Z8m9NvJveoTaK0UdZlaYOd03Who=
X-Received: by 2002:a05:6808:6410:b0:3f7:ff67:1d8c with SMTP id
 5614622812f47-404d88d532amr14478281b6e.36.1747897003075; Wed, 21 May 2025
 23:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-3-jens.wiklander@linaro.org> <dffbd709-def0-47af-93ff-a48686f04153@amd.com>
In-Reply-To: <dffbd709-def0-47af-93ff-a48686f04153@amd.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 22 May 2025 08:56:31 +0200
X-Gm-Features: AX0GCFsuHYqDh1JYpWH8r8xDir4J3V2XXHJjiARqLynYHFcDQxMIIZpQ5oYhZd4
Message-ID: <CAHUa44Ec0+GPoDkcEG+Vg9_TY1NC=nh3yr0F=ezHMbaeX_A0Bg@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] dma-buf: dma-heap: export declared functions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.50 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	RBL_SENDERSCORE_REPUT_8(0.00)[209.85.167.172:from];
	RCVD_COUNT_ONE(0.00)[1];
	TAGGED_RCPT(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.172:from];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.172:from];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C7D2E4093C
Message-ID-Hash: MDBN4IQUUYHLLOOZ6XV5JWRSZMTP54U2
X-Message-ID-Hash: MDBN4IQUUYHLLOOZ6XV5JWRSZMTP54U2
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MDBN4IQUUYHLLOOZ6XV5JWRSZMTP54U2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, May 21, 2025 at 9:13=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/20/25 17:16, Jens Wiklander wrote:
> > Export the dma-buf heap functions declared in <linux/dma-heap.h>.
>
> That is what this patch does and that should be obvious by looking at it.=
 You need to explain why you do this.
>
> Looking at the rest of the series it's most likely ok, but this commit me=
ssage should really be improved.

I'm considering something like this for the next version:
Export the dma-buf heap functions declared in <linux/dma-heap.h> to allow
them to be used by kernel modules. This will enable drivers like the OP-TEE
driver, to utilize these interfaces for registering and managing their
specific DMA heaps.

Thanks,
Jens

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/dma-buf/dma-heap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
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
>
