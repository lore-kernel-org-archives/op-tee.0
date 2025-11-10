Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3228FCCF9E3
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 08:58:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 203065001D
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 08:58:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MzTQ4zv1;
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D7A5F43147
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 08:57:50 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e2d1477b9cso1569450fac.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 00:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762765070; x=1763369870; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+DU4bC9oY8isR66wkaZVD1cgl7C2T/3TuAVsgHOOjs=;
        b=MzTQ4zv1jEWuZkb/dhV6VvI0Mi0BrzekaVR0QTYcPUkG/rSFqhgWEyVpg5MB0cDPgD
         iUp4PkcFLVVJDN0l7srekNHd3GykWbH9Dt/LF/z3JsZApHX76pkv7WAY+glhfBnk8dwj
         WNSlTo4GlCS/jCH8OmHq9kyHsV70GGpcKeT2oPkkoaoqyWG73jYNdBSd0Pby1G7FZ4V0
         KAxhExsFfIX2XAZF4Y5SdjBJ5e4adyIDy6b22ABcAWGIYtX8R3kU0YnisbIaFQL/NnR7
         nXX2ZNdag8O7dRPDUhyPr1Nuic5rbLQPVtixPfltZNbruLITjzkTM0gpthYCdY52DBMU
         TRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765070; x=1763369870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+DU4bC9oY8isR66wkaZVD1cgl7C2T/3TuAVsgHOOjs=;
        b=g2s2Gesax9UOFikK2xNwFZKQt83qfoBrtrDK+e3sGqu0rPA6YlYcWSj5cOTacG+OPu
         /S7bGK2aXOAcETIKS0KHukCUKKd/wEe+1bS9HvuSOPgApKF4Vk5zEgVBThl/MiCMD9lJ
         dcv9bQR1EYPDGmZTYMKxU6mpovQXA/ZYS6hYq/rKkdP6A7jlPDbbHaNmB7XG/SXJ5oZ6
         GwuMVlO/Tcp/xQv/5qRVQmXBeWQrcPF5DtQgQ7cYTKK66wmZ2KfXFhxGOwevyKGkR5PU
         ZnEYaE+GbTZpH57iWPjjOWoo5Lyizux6ugk91rdd283w5sYd9pNP0iOLLHk8Qy/iIKul
         bfAw==
X-Forwarded-Encrypted: i=1; AJvYcCUKgix/an35i414cZhC+kBzHjqNTiHALtn+geapX8FgQ5uAO+FQO0TpsSU64G3u/jsiZFJ6G6k=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyFLygg73zF1ceX+J5Ls9GAGa+WUgO75JfEhSYo9QLUIYqE7YJE
	//k6vgPflTSsyqwnAY+WnRlKBoPy8p2DiZlqMokW5+BfH9iOBm3H4jizdaKVv7CwPF41m2/HV6s
	v1QVr3McUjsE4N+ur2b/p29BtCaCt45OdMeTlrBSLK925
X-Gm-Gg: ASbGncvd8OI9Bqo8YmvhZgJWBDADldpv1xG3ciJbnf1nQPHmZ1f2ra1UiZ8l6qJ2f41
	NtcQfF/YnyhXFxIH0jFJvP34ySYK5i0Em26VdmCv+7+LfCQIDc1XmGb1LOrUWA/V1uCKIQ3Ssih
	M0HqYh9w5TtNW4fDog2CafO4vk7VZOsPMLTrIOf3vP7on50vNESKqhMXl/gYmcD+YSILwo6qWQF
	U/LJX+0uVEX7EY02MxoqK6ZqDSwPTSub24tyf7HnkLyuJ7jlcoRivaOPsk9X8GEX1fqeSYRVW6O
	iR96
X-Google-Smtp-Source: AGHT+IEvNSWQF8V50WXZvHvTh5vdg6c1kYKSH5fDM/Ta6RUD/FEZDy3lz08IzLZFRWp24NzfBrjEWgoxjvYDKgubZn0=
X-Received: by 2002:a05:6870:899a:b0:3d4:760f:544b with SMTP id
 586e51a60fabf-3e7c294ab31mr5259236fac.46.1762765070045; Mon, 10 Nov 2025
 00:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com>
In-Reply-To: <20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 10 Nov 2025 09:57:38 +0100
X-Gm-Features: AWmQ_bmbfwlbuD27u393tcu35e2C0scPDS3Uy66i-DK7aOy74DFrH1rStFwJq9A
Message-ID: <CAHUa44GYnZFaZQBNbV0=RSR7r61+ErYdQtEsRObNALz2CwT_Gg@mail.gmail.com>
Subject: Re: [PATCH] tee: fix uninitialized pointers with free attr
To: Ally Heev <allyheev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D7A5F43147
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.41:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.41:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: HBP52TMJMYQNT7SE5FRPEQEXEPAOFYDY
X-Message-ID-Hash: HBP52TMJMYQNT7SE5FRPEQEXEPAOFYDY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HBP52TMJMYQNT7SE5FRPEQEXEPAOFYDY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Wed, Nov 5, 2025 at 3:20=E2=80=AFPM Ally Heev <allyheev@gmail.com> wrote=
:
>
> Uninitialized pointers with `__free` attribute can cause undefined
> behaviour as the memory assigned(randomly) to the pointer is freed
> automatically when the pointer goes out of scope
>
> tee doesn't have any bugs related to this as of now, but
> it is better to initialize and assign pointers with `__free` attr
> in one statement to ensure proper scope-based cleanup
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
>  drivers/tee/qcomtee/call.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index ac134452cc9cfd384c28d41547545f2c5748d86c..8b7b4decddd8d1811dc0a7cc4=
6a4a4fbada45526 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -645,12 +645,13 @@ static void qcomtee_get_version(struct tee_device *=
teedev,
>  static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 i=
d,
>                                           u32 *version)
>  {
> -       struct qcomtee_object_invoke_ctx *oic __free(kfree);
>         struct qcomtee_object *client_env, *service;
>         struct qcomtee_arg u[3] =3D { 0 };
>         int result;
>
> -       oic =3D qcomtee_object_invoke_ctx_alloc(ctx);
> +       struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D
> +               qcomtee_object_invoke_ctx_alloc(ctx);

Can we zero-initialize oic at its original location instead? Doing it
here looks messy.

Thanks,
Jens

> +
>         if (!oic)
>                 return;
>
>
> ---
> base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
>
> Best regards,
> --
> Ally Heev <allyheev@gmail.com>
>
