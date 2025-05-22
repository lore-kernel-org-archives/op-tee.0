Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3EBC54E65
	for <op-tee@archiver.kernel.org>; Thu, 22 May 2025 12:37:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7092542F23
	for <op-tee@archiver.kernel.org>; Thu, 22 May 2025 12:37:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qvIHtmks;
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4682840932
	for <op-tee@lists.trustedfirmware.org>; Thu, 22 May 2025 12:36:52 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3fa6c54cc1aso5302145b6e.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 22 May 2025 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747917411; x=1748522211; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/nM7ohI+OhW9Q09hMJxUkW/sk0nV2AyhKtXe2v8eEc=;
        b=qvIHtmksIVF0YelGvaCYk2LEAG8BoBvyRBeG1Vis9b8Tt/mUzdVYD0KvZE+7U1ZroX
         0tkZwq4OUjeLC2GYh/oFxp+Uh6PmrauSu2B0EV/lPcdFmpNOQQ2vcyoZtOw4347npuFh
         YGIEp8EB09dMGXIJ4uwvrDUSLTBXhPr8UfS5mYGIvSOtGd7UwZEqmeAI9sdPfo6HbiZY
         RWAvbwZt5SQQbbwVh/yMTiIb0MTfLFZ+znDaBdX6G90nCaFCjahBmUSWfH7KmnT5QXj6
         CajTYTEag2kx2YJrL/q4WffblCD1EsD37UUDrgaLEjkIdDsdBNOcov04tgUHzssAPTuK
         df2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747917411; x=1748522211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/nM7ohI+OhW9Q09hMJxUkW/sk0nV2AyhKtXe2v8eEc=;
        b=pkCoq/SK3zxjwwL57V1gY16oPAmJsQE3aeFvy9Hbp/8b3sGXgEulvI3q8uEOPOvr9/
         aRHd2mzb3/7XiuX5hNuh4AUMUrqqzESzULNWzG1EhsAf5vzCFyC9sWwtS3CjB/fhhfeY
         iro70OeXFCwO+8VIB+G9S4vq1tX/b01G1rtJEBTge3R8kqgf8r77ShbEC5LRAkFFF6yu
         G07lrvFbUwPHEk+v25IJmojtscxl3uMDBqPRx6FBYcHJBtqp4IkizP449CP+mhhrMaou
         eU8jcOgH9Mxm92eGHPeMg6q8ere7fF9PjGDV+lqP5SgQ8aIsoCgZ2LuZzPrMGYSCKAPV
         vJQg==
X-Forwarded-Encrypted: i=1; AJvYcCWug6iVtGFkiuHjo0ufpSfKyN+QSGwUgCy+OQMZik+jENdtzSopGECZvspx7gZrByMk7TAqFSo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywv2Q3rfPInfk80N0c53R796p0Gz99PBeLD1WuyBP/wScJcGxNV
	dcS2oMj6+2WE17Qe5H/Me1wRaiehJhilJOfO6qT5hVFGfDxD150KnB1VhhRvBvaLfxu+Bf6m4vv
	2C+MzPTqNo2rpRo7S45F9DRMkU9RVDU0bbekGVfdAb4MK
X-Gm-Gg: ASbGncveP6OV0cMn00idDNysGc/xSeA/srGGQmV5Xmvxdd0+XkQ9tWZ6e9wFIE/BK8N
	AdAtTXCNbZ4dluZqZ2CIbGGH4PSuw4nx5sE7b31tjNYGPhHmpKu51GQnAq6aFHnrtmKE4U4+hKu
	qX5/ZzdheqVUGjfxmeaQ//rRs+MjQ6BSaHUA==
X-Google-Smtp-Source: AGHT+IFaxfBHByqapVV2RXkEPTMYtDPJFaizTF3QtPLs+N+jP8G9GyXQ9nHLQfE3byrCa1MQmfMacM+snhhkwuWXSyE=
X-Received: by 2002:a05:6808:338a:b0:3f6:a9d4:b7e4 with SMTP id
 5614622812f47-404d86f3f18mr17232381b6e.20.1747917411552; Thu, 22 May 2025
 05:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-3-jens.wiklander@linaro.org> <dffbd709-def0-47af-93ff-a48686f04153@amd.com>
 <CAHUa44Ec0+GPoDkcEG+Vg9_TY1NC=nh3yr0F=ezHMbaeX_A0Bg@mail.gmail.com> <1a65f370-2df2-4169-85f9-c45e7c537447@amd.com>
In-Reply-To: <1a65f370-2df2-4169-85f9-c45e7c537447@amd.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 22 May 2025 14:36:39 +0200
X-Gm-Features: AX0GCFtomK6Kj4MbJdPbWNPCFM5pduAepClCBqfPEiiU97RKWiikvixpOO2yK1w
Message-ID: <CAHUa44Hgu9DnmeGXAoFKkRBt6jFCAb6Mi5zzuuvVVSgsxDZQWA@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] dma-buf: dma-heap: export declared functions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.50 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[22];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.181:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.181:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.167.181:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4682840932
Message-ID-Hash: M73LRFYDWMP64VGHGNQFIWQLWJO2Q5S4
X-Message-ID-Hash: M73LRFYDWMP64VGHGNQFIWQLWJO2Q5S4
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/M73LRFYDWMP64VGHGNQFIWQLWJO2Q5S4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, May 22, 2025 at 1:52=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/22/25 08:56, Jens Wiklander wrote:
> > On Wed, May 21, 2025 at 9:13=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/20/25 17:16, Jens Wiklander wrote:
> >>> Export the dma-buf heap functions declared in <linux/dma-heap.h>.
> >>
> >> That is what this patch does and that should be obvious by looking at =
it. You need to explain why you do this.
> >>
> >> Looking at the rest of the series it's most likely ok, but this commit=
 message should really be improved.
> >
> > I'm considering something like this for the next version:
> > Export the dma-buf heap functions declared in <linux/dma-heap.h> to all=
ow
> > them to be used by kernel modules. This will enable drivers like the OP=
-TEE
> > driver, to utilize these interfaces for registering and managing their
> > specific DMA heaps.
>
> Works for me, but it doesn't needs to be so detailed.
>
> Something like this here would be optimal I think:
>
> Export the dma-buf heap functions to allow them to be used by the OP-TEE =
driver.
> The OP-TEE driver wants to register and manage specific secure DMA heaps =
with it.

Great, I'll use that.

Thanks,
Jens

>
> Regards,
> Christian.
>
> >
> > Thanks,
> > Jens
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> >>> ---
> >>>  drivers/dma-buf/dma-heap.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> >>> index 3cbe87d4a464..cdddf0e24dce 100644
> >>> --- a/drivers/dma-buf/dma-heap.c
> >>> +++ b/drivers/dma-buf/dma-heap.c
> >>> @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> >>>  {
> >>>       return heap->priv;
> >>>  }
> >>> +EXPORT_SYMBOL(dma_heap_get_drvdata);
> >>>
> >>>  /**
> >>>   * dma_heap_get_name - get heap name
> >>> @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap *he=
ap)
> >>>  {
> >>>       return heap->name;
> >>>  }
> >>> +EXPORT_SYMBOL(dma_heap_get_name);
> >>>
> >>>  /**
> >>>   * dma_heap_add - adds a heap to dmabuf heaps
> >>> @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> >>>       kfree(heap);
> >>>       return err_ret;
> >>>  }
> >>> +EXPORT_SYMBOL(dma_heap_add);
> >>>
> >>>  static char *dma_heap_devnode(const struct device *dev, umode_t *mod=
e)
> >>>  {
> >>
>
