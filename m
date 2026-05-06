Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A01CD342C
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 06:51:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D3CD743706
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 06:51:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d/lOdVts;
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DE9E44326C
	for <op-tee@lists.trustedfirmware.org>; Wed,  6 May 2026 02:18:56 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fb262f92cso1361810a91.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 05 May 2026 19:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778033936; cv=none;
        d=google.com; s=arc-20240605;
        b=SRoVcIq9DiA2eGaYqo8L6FdUnW6u+CSMIJgYSyD+NzraOQUvqvj+Ux2rEnOs4ia58z
         b/W93Ra/nYo8dL9Cq5IerUFIsyDkzXNUiTMAxtoVE1S01X1wkZp8t00Tqp0kIzLbTDvh
         RXoVcSXqD+SfdOAFysXqtUxcLDeRPxGeh46PhN9Y1VDYDgK+AqHCX/4iCNfYT1cB9afw
         ntsUjEqJ2bfhNLJKTMDuRqZPys3wDRVmNA1RIUzSmBxkw3+Els3kOLzAH+UCre6n9cIt
         Kh1+aP+MCYC9h45RBvNzUQIb1DSGJ3HTFI48M3VryrPesabmUvmJyKARrWYTyDXsDbdS
         HWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftUCIuzyxf8AvRFd+x3vBuG4AdGrfGWJ06tcJEm0EyU=;
        fh=t+pzlStlKYxX3ZvXKrKxWVxnrs3OvcRFPGXkwE0nXnw=;
        b=cAtKI+YHeTc2CCdeNW0YhOFBXqWV1QOk6Nyt0N92xW0Se9XLg0J0W8LgHMNLFS0vTL
         EK4iTqY7hnxfiM9zE1NNAD6OUP2jDeAzoIG/rby0SKTIGaYO9HxEWCulPrO7fJActdMq
         WRdwD09GGgFXoU3yXOFLT0SQp4EVib+FTaXs1lMVRgOUs9Lw3ZGNmjE6JpXEVf+Nd+5L
         cQwk3j/JkUDc82SIXO4M3blnYDyhBzDjePnS2gjtzNvkCCsMtknN19prxNImcLOJG4EU
         aGNMM/BMHskfIWteZZiooOD78WUcb8SzJVzT8vPmH8h9DW3WJwtzX2rjqFZddmQ16VV5
         M53A==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778033936; x=1778638736; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftUCIuzyxf8AvRFd+x3vBuG4AdGrfGWJ06tcJEm0EyU=;
        b=d/lOdVtsFo01/LjHO3nyCYO+qUuZtiAA5Pe8bXdDE6btCgWMcI+VA+JEdHKaTuXpSq
         8RkUTuEIpopoOkD7FUEzCIDEWkNRFNAIup0L1V+atlJnXkvBfksIz+Wb4L27Jikyr8ck
         n/RL3+Nl3pTAGQbJWFMDcouoqIZRda4yJ2S7H0Ssy6GPyma+KeGra4nPsY5mxduFSsJb
         qxinqnOo4bYuIj8cSb3XbA0XiTVebHs+0pSO0XcVjnzBRBZyF0l40/L6n8ftZAy3zVXn
         JKD9peeuij80rr4PP03Uid2VLMUjKoHYRaFAt5jHMUcDsxAri3rS7z3iTQ5NUbFOux19
         QlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778033936; x=1778638736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftUCIuzyxf8AvRFd+x3vBuG4AdGrfGWJ06tcJEm0EyU=;
        b=U4jftJFFdX9sEt+V3NFo+tSut88ggyG103JNXNOsBGQLFjbWoVooTJXY0CvRlLxBbH
         r7WAER1IIRFUhyA56Fxis+u2GpRdFRLvrw20ni4BsYNGPIIQI/2SWfdgVGDJ2jTzg/4m
         RYseHyLpRu6SQnWT1D6t0vkv70vhy0dF2uw5z+8WYk3BRNrTzc69N9qQ1MgfEUOn9yWF
         UxGkFeOxud75tDM8bbf81l+Jf0GR/VN1oIbCuKPBFdHESXnIFgVzV7wAyp9idtngSG1y
         Qbz+/a0VzUIUez9AzY6+X9D37HbrwyORP0Aj1tdM7gcqm/VbiTuWnLYimMxcx8GEfx5t
         CHwQ==
X-Gm-Message-State: AOJu0YyyQ2e+dFAltAYx38WRHpmwXt7nEdJ7yhq+7WuTe2uRGs3Px0IU
	MgfMuvcQUWTAqHl6uhYBi93JKCkBYF2FyGEJzEnp4oQJ/+GKAaR6di1yiY1SW2lu3IADnNJiVuL
	wdYcPMF2VfzeY8BlvaM7uUbZ1PdcTGaw=
X-Gm-Gg: AeBDietiNW7JbEJDbnupRhRc68fV7fxD1okmOQcCgHonDIQwkhemhlEpESvtwFxT3dn
	Z9UvxYJm7bSBKus/RIUpyQ+FXCkXwDSy7NkHLz+oBim/Hla3aroCee0yy5Xu9OiyWQcJhSSHC11
	Sp1nkpgSJLXRABtoaBR6jSM+VqieL8DlY9+9wEc/tCDckgEJaO1CTT/TqrUcOiUooetfiH8S7oM
	cJsmh7QiOn6T/KOL09uto7erU9QQYO/Wtp9bhDWPnGk99wiTItirl+L7gUlwFC3V3qrV65wtrn8
	dfyblUBeIPXdn+sf3Yw=
X-Received: by 2002:a17:90b:264e:b0:35e:55fd:1bd0 with SMTP id
 98e67ed59e1d1-365ad0eaae6mr636997a91.1.1778033935832; Tue, 05 May 2026
 19:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <afS5XzaeLUx1ngAl@sumit-xelite> <20260505153041.17794-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260505153041.17794-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 6 May 2026 10:18:43 +0800
X-Gm-Features: AVHnY4KFpwcvKhQgP-EsYge4sED3unBbGtznrgG6J9UCOjUMhN_wHb2hiw97vzE
Message-ID: <CAH78GvvE=wyZz5-LFySytq2=ChOUtj7YtR5dBAY9SLJQARa6Wg@mail.gmail.com>
Subject: Re: [PATCH v2] tee: fix missing shm reference cleanup in tee_ioctl_supp_recv
To: jens.wiklander@linaro.org, sumit.garg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.45:from];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_ONE(0.00)[1];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.45:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DE9E44326C
X-Spamd-Bar: -----
X-MailFrom: q.h.hack.winter@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: TXAK7UNW5JQMSYOQZNUYB26TBAH6FLNC
X-Message-ID-Hash: TXAK7UNW5JQMSYOQZNUYB26TBAH6FLNC
X-Mailman-Approved-At: Wed, 06 May 2026 06:50:50 +0000
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TXAK7UNW5JQMSYOQZNUYB26TBAH6FLNC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens, Sumit,

While reworking this, I noticed that there may be two slightly
different cleanup issues involved here.

One appears to be in tee_ioctl_supp_recv() itself. Another may be in a
qcomtee-specific error path where MEMREF references can already have
been acquired before the backend rejects the parameters.

I am not entirely sure where you would prefer the boundary between the
core fix and any backend-specific fix to be.

Would you prefer that I keep the current patch strictly focused on the
tee_ioctl_supp_recv() cleanup path first, and handle any qcomtee-side
issue separately if needed?

Thanks,
Qihang

On Tue, May 5, 2026 at 11:30=E2=80=AFPM Qihang <q.h.hack.winter@gmail.com> =
wrote:
>
> params_from_user() acquires tee_shm references for MEMREF parameters and
> expects the caller to release those references with tee_shm_put() during
> cleanup.
>
> tee_ioctl_open_session(), tee_ioctl_invoke(), and
> tee_ioctl_object_invoke() all do this, but tee_ioctl_supp_recv() only
> frees the parameter array and does not drop any acquired shared-memory
> references.
>
> Fix this by using a common helper to release MEMREF references before
> freeing the parameter array, and apply it to tee_ioctl_supp_recv() as
> well.
>
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
> v2:
> - rename helper to free_params()
> - drop alloc_num_params and use num_params directly
>
>  drivers/tee/tee_core.c | 46 +++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index ef9642d72672..8cdf2ec7e74f 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -530,6 +530,21 @@ static int params_to_user(struct tee_ioctl_param __u=
ser *uparams,
>         return 0;
>  }
>
> +static void free_params(struct tee_param *params, size_t num_params)
> +{
> +       size_t n;
> +
> +       if (!params)
> +               return;
> +
> +       for (n =3D 0; n < num_params; n++)
> +               if (tee_param_is_memref(params + n) &&
> +                   params[n].u.memref.shm)
> +                       tee_shm_put(params[n].u.memref.shm);
> +
> +       kfree(params);
> +}
> +
>  static int tee_ioctl_open_session(struct tee_context *ctx,
>                                   struct tee_ioctl_buf_data __user *ubuf)
>  {
> @@ -595,16 +610,7 @@ static int tee_ioctl_open_session(struct tee_context=
 *ctx,
>          */
>         if (rc && have_session && ctx->teedev->desc->ops->close_session)
>                 ctx->teedev->desc->ops->close_session(ctx, arg.session);
> -
> -       if (params) {
> -               /* Decrease ref count for all valid shared memory pointer=
s */
> -               for (n =3D 0; n < arg.num_params; n++)
> -                       if (tee_param_is_memref(params + n) &&
> -                           params[n].u.memref.shm)
> -                               tee_shm_put(params[n].u.memref.shm);
> -               kfree(params);
> -       }
> -
> +       free_params(params, arg.num_params);
>         return rc;
>  }
>
> @@ -657,14 +663,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
>         }
>         rc =3D params_to_user(uparams, arg.num_params, params);
>  out:
> -       if (params) {
> -               /* Decrease ref count for all valid shared memory pointer=
s */
> -               for (n =3D 0; n < arg.num_params; n++)
> -                       if (tee_param_is_memref(params + n) &&
> -                           params[n].u.memref.shm)
> -                               tee_shm_put(params[n].u.memref.shm);
> -               kfree(params);
> -       }
> +       free_params(params, arg.num_params);
>         return rc;
>  }
>
> @@ -716,14 +715,7 @@ static int tee_ioctl_object_invoke(struct tee_contex=
t *ctx,
>         }
>         rc =3D params_to_user(uparams, arg.num_params, params);
>  out:
> -       if (params) {
> -               /* Decrease ref count for all valid shared memory pointer=
s */
> -               for (n =3D 0; n < arg.num_params; n++)
> -                       if (tee_param_is_memref(params + n) &&
> -                           params[n].u.memref.shm)
> -                               tee_shm_put(params[n].u.memref.shm);
> -               kfree(params);
> -       }
> +       free_params(params, arg.num_params);
>         return rc;
>  }
>
> @@ -861,7 +853,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ct=
x,
>
>         rc =3D params_to_supp(ctx, uarg->params, num_params, params);
>  out:
> -       kfree(params);
> +       free_params(params, num_params);
>         return rc;
>  }
>
> --
> 2.39.5 (Apple Git-154)
>
