Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF578CAC5B8
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 12:57:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DC5AC41B9B
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 12:57:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BtB/+/ay;
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 591F841853
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Oct 2025 12:57:38 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-43f8911522cso1290546b6e.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Oct 2025 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759409858; x=1760014658; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ9DvIz4r5smSG4dSA4CIzbwRw8riJPhilOOGaBUqN0=;
        b=BtB/+/ayUJMVBK5R967hzq7CBkhxGGEYy9Mk/4WaIma8A0uHFi2ajqkAymvOaNRUl8
         rpmMtrOZKlTCH61qSqPSXLI89WHIAOoCHjaMc+B2XuqJ/iK/ofwb9LVDNUOrrrNpmW5j
         YBIz0V7AdG+4bApKT9HpD7DgkoupSpgpP77wMX8aLSODgCz5i5F3/gVoSbrslD5RNcyb
         l2eBDCd1W2HHIBIt4Bn1KD/BWYaOd+9xPKB7UhmpXcQtgtXPMfsVzRg4XqrzCL+jXDsg
         JHcNMHicjgDrI5h3r/Z02H4pSGDoW70bEmPZof0+hEz/EUpLibjvVCXxKbL64shHNEfA
         5Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409858; x=1760014658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ9DvIz4r5smSG4dSA4CIzbwRw8riJPhilOOGaBUqN0=;
        b=lfDD8R3p/Jn0VqiDsDz4bplbhxgMjUvoUwTvXLXtT6mFnHeQ4jMEOmYglsbJi5unpI
         dWpRBKHaZVKj8gNGtv2Y/gtQvxhy9PxUkw+nZ06rfcYDuoo4eu6qOxSEPR3KGmqQpXLm
         NbAAYBaGaxansWy6FTneHxa3mF4tXw0zmj8c/T6X6xCtl8dG0iICVvPH/32k9cEkMbzm
         t7j+RFvh3t9uytNEXn77Wy4sdpvYKCIEA8V+V41b+7ejBpKFCTnI0OyjhwuSASUUFJFZ
         uKI6965nRoNraZo40PIdKo/3mnTZ0toejBucCJIXFKC8EUVHPCr8oKNLbb6JSHiyDR6n
         djag==
X-Forwarded-Encrypted: i=1; AJvYcCV5YheOGwFFB59mzSOcXNTxtjWdIvKyo7WYk9fH5WOdNtligfcEXxeZnpIgLwvRMvxDnPkkDmg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwW3iuBZEZUnKZlo/Wxol8+29TskMvXgVGAAJsT38TvVZ4+WQiA
	PlYo9e8wzRSpPJD/fWNVVDM/asGJyWHlJq9xjmeuyRbKJ9Uqc9iJ+VVM5K3pdMuYPXZxDv3Od7h
	ojlS+yQ4GGnF3pNMQbzuSi5xDFaW5tPUZxwVgbA/IQdAQ
X-Gm-Gg: ASbGncttYT+4+btmKibzR5pD7TMkvhFPSKUsVlqiDZazRsK5avZr6t5WA6lRrjzQnKg
	4JxmQzYW+kYhIqXCTI3vXo0XEi10mGJvikcemnvHDlobo4abybGLGZYUhGJp1AvLPOZsVq6ka/D
	gX9kMtxS7aGi2QpsSoat8usdz7RVnmu0IZWaUOVPEQfcdmWbV14aYJ5pnbjsyaLqPdZ54Bg1QG1
	NPrIz09d4UF+OQcIXwXWd8sEJGe9Dycmle3
X-Google-Smtp-Source: AGHT+IHYX7pg60feCJITkUMOxMprgz6P5nDIrUPJazgK/QAWeqrWOagX4EH5hYzH12fx7NdLiTURGQeRt8nyhXDnw20=
X-Received: by 2002:a05:6808:2385:b0:438:23ad:5dbc with SMTP id
 5614622812f47-43fb15cb75cmr1662193b6e.20.1759409857632; Thu, 02 Oct 2025
 05:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-4-jens.wiklander@linaro.org> <20251002-sceptical-goose-of-fame-7b33d6@houat>
In-Reply-To: <20251002-sceptical-goose-of-fame-7b33d6@houat>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 2 Oct 2025 14:57:25 +0200
X-Gm-Features: AS18NWB-MzLg3sZZl_om3Nb3U3T2KFc8NTfBmABGN9BozXUUDdedKeLjWJJE67A
Message-ID: <CAHUa44H3nGgY9q68YRRp5A7Q6Ku3P_URuv+L7H8chYzLAKd8mQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/9] tee: implement protected DMA-heap
To: Maxime Ripard <mripard@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 591F841853
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.182:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.167.182:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: TJBE2RQMRIPQGWM2ZJU2YQXU7LCMY7CT
X-Message-ID-Hash: TJBE2RQMRIPQGWM2ZJU2YQXU7LCMY7CT
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TJBE2RQMRIPQGWM2ZJU2YQXU7LCMY7CT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Oct 2, 2025 at 9:54=E2=80=AFAM Maxime Ripard <mripard@redhat.com> w=
rote:
>
> On Thu, Sep 11, 2025 at 03:49:44PM +0200, Jens Wiklander wrote:
> > +static const char *heap_id_2_name(enum tee_dma_heap_id id)
> > +{
> > +     switch (id) {
> > +     case TEE_DMA_HEAP_SECURE_VIDEO_PLAY:
> > +             return "protected,secure-video";
> > +     case TEE_DMA_HEAP_TRUSTED_UI:
> > +             return "protected,trusted-ui";
> > +     case TEE_DMA_HEAP_SECURE_VIDEO_RECORD:
> > +             return "protected,secure-video-record";
> > +     default:
> > +             return NULL;
> > +     }
> > +}
>
> We've recently agreed on a naming guideline (even though it's not merged =
yet)
>
> https://lore.kernel.org/r/20250728-dma-buf-heap-names-doc-v4-1-f73f71cf0d=
fd@kernel.org

I wasn't aware of that (or had forgotten it), but during the revisions
of this patch set, we changed to use "protected".

>
> Secure and trusted should be defined I guess, because secure and
> protected at least seem redundant to me.

Depending on the use case, the protected buffer is only accessible to
a specific set of devices. This is typically configured by the TEE
firmware based on which heap we're using. To distinguish between the
different heaps, I've simply added the name of the use case after the
comma. So the name of the heap for the Trusted-UI use case is
"protected,trusted-ui". What would a heap called "protected,ui"
represent? Protected buffers for a UI use case? What kind of UI use
case? If the name of the heap is too generic, it might cover more than
one use case with conflicting requirements for which devices should be
able to access the protected memory.

Thanks,
Jens
