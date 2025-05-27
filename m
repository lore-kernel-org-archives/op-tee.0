Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F23C54F30
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 14:44:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9F10742E82
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 14:44:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AhemR6dG;
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7675F42E82
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 14:43:57 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-403407e998eso1989931b6e.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748357037; x=1748961837; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95DgJLZjEvQybIlPP+VCo5ApfOw6ewx9PjK94wls/Kk=;
        b=AhemR6dGfNnq7K9Nh77pFXJfDpPsnH4WS7fgbU7M7ZF8cH92faeMsgayi/Vub3/gbP
         jnsl8CZWuJiqxxWkLCZCdr25SbTSNu89kMUHfs+v5XPyFb+pzi6v3ssgM5KSfZ+2WiGX
         D38QZ/20JFwKrk2cjqoJT9Q7TpPXTBsw8TsKdNlo0lN5z4neFN4z5B6tad8PuFIzuwLV
         eSjGmX3b3ev+yiQa2bhVTnL7j4oCHVH8LqtknCFL1TuJ7SPHrskA3TvRWDrC422xYVam
         bAwRWvLZTLE0ju4vRFjDOLe9/ta1eusCnLHHxJlT1cSqRRjFsJyrIPDq0K/ng6KqxU/I
         xnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748357037; x=1748961837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95DgJLZjEvQybIlPP+VCo5ApfOw6ewx9PjK94wls/Kk=;
        b=a8nTfyu2IEOum8xqql2dhG0YK3LMOFUVxVVbcH6yVbDtrEpXI9nS17cd9aWiTmZ+Sy
         ramLFgRoGUhbHnF+atUwoNhT7Lh6riU/Eb0uOi/9Kl8Yk8cwCC/OOkqISH1/DXiqz9A/
         PPfmbxJHMNG3lvoIxdzgVxtoVgyPfTqM6Nm6QMzSe12xjzVPQOqVinGHVverjCIyyill
         w2j4D72NrBt3fNXdcdky5XOPDnp48PGvoo0AUrZGL9jJMe42u8l9zFlI0PUG1v+NrbCa
         rJqNM53GxS1AY9WkbhVn6ewywC/Kb7cqVOZaXq+gGCynDQBE4dmJtpynBTqFhFQuzhdY
         tGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVnSpe5T8UUG7fh1qPbqWqla6b9OZFJFJc4TmLEpQJHTSzMAivTbUfvpu02AQ3RoY+K30ZyMk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy6HyPNinW7jSjX/2wrx14huohyRxfdv7KoS//3KzdjW3/a7vnA
	kxdPiRbLlQdFd7uosTQyac5cMFPZAW+o4mg4Lydzyvy+FO99hrZ0VYfEDnidVKLxSSi8AXjhE2b
	rtfME/I15mb+3dvt2ucoz0rirCjBRaSxZirKZsxQDeFa6
X-Gm-Gg: ASbGncs4m9im7qmFtt+fWOcjXmVgEary5QCfGB0kbZdQ+zYj0QmqNJIuKd4HODYSuSk
	LiNqcwFsFxtj4pJvMeHGAk4BeRA6pI0eCJK4V0wUhG3QoZKApu2xeODRlj69gbmc+ZFxr1DMu0w
	O5DCQteZT8PPTq1xAx9/NxKp7qMr2uWKOJKw==
X-Google-Smtp-Source: AGHT+IHpSqYMZnJIwMvd/4lAF+O9cYNaktKk9pOe7eLVIejN5m7i3i+I+Kqp9vE8g8yw+eb4yKgrKppgkbkYaaS4u4c=
X-Received: by 2002:a05:6808:3a19:b0:403:3195:58cf with SMTP id
 5614622812f47-406467f6a5emr7481831b6e.1.1748357036861; Tue, 27 May 2025
 07:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-10-jens.wiklander@linaro.org> <aDQitSd27Z4qC0xT@sumit-X1>
In-Reply-To: <aDQitSd27Z4qC0xT@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 27 May 2025 16:43:44 +0200
X-Gm-Features: AX0GCFsAg3SlBrsMFYU7wBuZbNCOqXi00PEfamwreFmZfzirEP5JjBZls3rnlgg
Message-ID: <CAHUa44E=FKAGWk-pjq176b9ri7kgL8PqN6rpBeoPKgfj5EuWTA@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] optee: smc abi: dynamic protected memory allocation
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.170:from];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.170:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7675F42E82
Message-ID-Hash: U5AOXJDLFRQV3ZWNTXOI2ZYWOTHXU6AL
X-Message-ID-Hash: U5AOXJDLFRQV3ZWNTXOI2ZYWOTHXU6AL
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U5AOXJDLFRQV3ZWNTXOI2ZYWOTHXU6AL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, May 26, 2025 at 10:13=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Tue, May 20, 2025 at 05:16:52PM +0200, Jens Wiklander wrote:
> > Add support in the OP-TEE backend driver for dynamic protected memory
> > allocation using the SMC ABI.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/smc_abi.c | 102 ++++++++++++++++++++++++++++++------
> >  1 file changed, 85 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index f3cae8243785..6b3fbe7f0909 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -965,6 +965,70 @@ static int optee_smc_do_call_with_arg(struct tee_c=
ontext *ctx,
> >       return rc;
> >  }
> >
> > +static int optee_smc_lend_protmem(struct optee *optee, struct tee_shm =
*protmem,
> > +                               u16 *end_points, unsigned int ep_count,
> > +                               u32 use_case)
> > +{
> > +     struct optee_shm_arg_entry *entry;
> > +     struct optee_msg_arg *msg_arg;
> > +     struct tee_shm *shm;
> > +     u_int offs;
> > +     int rc;
> > +
> > +     msg_arg =3D optee_get_msg_arg(optee->ctx, 2, &entry, &shm, &offs)=
;
> > +     if (IS_ERR(msg_arg))
> > +             return PTR_ERR(msg_arg);
> > +
> > +     msg_arg->cmd =3D OPTEE_MSG_CMD_LEND_PROTMEM;
> > +     msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
> > +     msg_arg->params[0].u.value.a =3D use_case;
> > +     msg_arg->params[1].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
> > +     msg_arg->params[1].u.tmem.buf_ptr =3D protmem->paddr;
> > +     msg_arg->params[1].u.tmem.size =3D protmem->size;
> > +     msg_arg->params[1].u.tmem.shm_ref =3D (u_long)protmem;
> > +
> > +     rc =3D optee->ops->do_call_with_arg(optee->ctx, shm, offs, false)=
;
> > +     if (rc)
> > +             goto out;
> > +     if (msg_arg->ret !=3D TEEC_SUCCESS) {
> > +             rc =3D -EINVAL;
> > +             goto out;
> > +     }
> > +     protmem->sec_world_id =3D (u_long)protmem;
> > +
> > +out:
> > +     optee_free_msg_arg(optee->ctx, entry, offs);
> > +     return rc;
> > +}
> > +
> > +static int optee_smc_reclaim_protmem(struct optee *optee,
> > +                                  struct tee_shm *protmem)
> > +{
> > +     struct optee_shm_arg_entry *entry;
> > +     struct optee_msg_arg *msg_arg;
> > +     struct tee_shm *shm;
> > +     u_int offs;
> > +     int rc;
> > +
> > +     msg_arg =3D optee_get_msg_arg(optee->ctx, 1, &entry, &shm, &offs)=
;
> > +     if (IS_ERR(msg_arg))
> > +             return PTR_ERR(msg_arg);
> > +
> > +     msg_arg->cmd =3D OPTEE_MSG_CMD_RECLAIM_PROTMEM;
> > +     msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> > +     msg_arg->params[0].u.rmem.shm_ref =3D (u_long)protmem;
> > +
> > +     rc =3D optee->ops->do_call_with_arg(optee->ctx, shm, offs, false)=
;
> > +     if (rc)
> > +             goto out;
> > +     if (msg_arg->ret !=3D TEEC_SUCCESS)
> > +             rc =3D -EINVAL;
> > +
> > +out:
> > +     optee_free_msg_arg(optee->ctx, entry, offs);
> > +     return rc;
> > +}
> > +
> >  /*
> >   * 5. Asynchronous notification
> >   */
> > @@ -1216,6 +1280,8 @@ static const struct optee_ops optee_ops =3D {
> >       .do_call_with_arg =3D optee_smc_do_call_with_arg,
> >       .to_msg_param =3D optee_to_msg_param,
> >       .from_msg_param =3D optee_from_msg_param,
> > +     .lend_protmem =3D optee_smc_lend_protmem,
> > +     .reclaim_protmem =3D optee_smc_reclaim_protmem,
> >  };
> >
> >  static int enable_async_notif(optee_invoke_fn *invoke_fn)
> > @@ -1586,11 +1652,14 @@ static inline int optee_load_fw(struct platform=
_device *pdev,
> >
> >  static int optee_protmem_pool_init(struct optee *optee)
> >  {
> > +     bool protm =3D optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM;
> > +     bool dyn_protm =3D optee->smc.sec_caps &
> > +                      OPTEE_SMC_SEC_CAP_DYNAMIC_PROTMEM;
> >       enum tee_dma_heap_id heap_id =3D TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
> > -     struct tee_protmem_pool *pool;
> > -     int rc;
> > +     struct tee_protmem_pool *pool =3D ERR_PTR(-EINVAL);
> > +     int rc =3D -EINVAL;
> >
> > -     if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM) {
> > +     if (protm) {
> >               union {
> >                       struct arm_smccc_res smccc;
> >                       struct optee_smc_get_protmem_config_result result=
;
> > @@ -1598,26 +1667,26 @@ static int optee_protmem_pool_init(struct optee=
 *optee)
> >
> >               optee->smc.invoke_fn(OPTEE_SMC_GET_PROTMEM_CONFIG, 0, 0, =
0, 0,
> >                                    0, 0, 0, &res.smccc);
> > -             if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
> > -                     pr_err("Secure Data Path service not available\n"=
);
> > -                     return 0;
> > -             }
> > -             rc =3D optee_set_dma_mask(optee, res.result.pa_width);
> > +             if (res.result.status =3D=3D OPTEE_SMC_RETURN_OK)
> > +                     rc =3D optee_set_dma_mask(optee, res.result.pa_wi=
dth);
>
> This change should be folded in patch 7/9.

OK

>
> >               if (!rc)
> >                       pool =3D tee_protmem_static_pool_alloc(res.result=
.start,
> >                                                            res.result.s=
ize);
> > -             if (IS_ERR(pool))
> > -                     return PTR_ERR(pool);
> > +     }
> >
> > +     if (dyn_protm && IS_ERR(pool))
> > +             pool =3D optee_protmem_alloc_dyn_pool(optee, heap_id);
> > +
> > +     if (!IS_ERR(pool)) {
> >               rc =3D tee_device_register_dma_heap(optee->teedev, heap_i=
d, pool);
> >               if (rc)
> > -                     goto err;
> > +                     pool->ops->destroy_pool(pool);
> >       }
> >
> > +     if (protm || dyn_protm)
> > +             return rc;
> > +
> >       return 0;
> > -err:
> > -     pool->ops->destroy_pool(pool);
> > -     return rc;
> >  }
> >
> >  static int optee_probe(struct platform_device *pdev)
> > @@ -1788,9 +1857,8 @@ static int optee_probe(struct platform_device *pd=
ev)
> >               pr_info("Asynchronous notifications enabled\n");
> >       }
> >
> > -     rc =3D optee_protmem_pool_init(optee);
> > -     if (rc)
> > -             goto err_notif_uninit;
> > +     if (optee_protmem_pool_init(optee))
> > +             pr_info("Protected memory service not available\n");
>
> This change can be folded in patch 7/9.

Yes, that makes sense.

Cheers,
Jens

>
> Rest looks good to me.
>
> -Sumit
>
> >
> >       /*
> >        * Ensure that there are no pre-existing shm objects before enabl=
ing
> > --
> > 2.43.0
> >
