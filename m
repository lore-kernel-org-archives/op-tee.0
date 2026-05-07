Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2929CD3442
	for <op-tee@archiver.kernel.org>; Thu,  7 May 2026 10:40:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1F1AC44411
	for <op-tee@archiver.kernel.org>; Thu,  7 May 2026 10:40:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LXwsVEv3;
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1D8904326C
	for <op-tee@lists.trustedfirmware.org>; Thu,  7 May 2026 10:40:23 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-42ff0576868so291083fac.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 07 May 2026 03:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778150422; cv=none;
        d=google.com; s=arc-20240605;
        b=Phx7ZyvBd28OtIZnjCb2OQxjbE0zW7XK168pZJaUnptzizbnq0e/CH+QpDHIJfuNW8
         psINyxDENEiNXyIL3pFCAqnjAH2kwh/bSnRsXCjJM0eGD6AevEHv7Oo4Cet0eBgVUOkF
         XWMOnVQzGWwvgSqlcmzRYFZX73ZsijTHmk52AuNYgk0JHJvBWPeipdF6v1qDTStUBCL4
         8QSxEODH7hPnMsJ+8iLPFedJns12bksvnNASMm4WP5o3al+NOOWnSXCKKhoiZs5jpXxo
         sqCyao1tgI/wMuSSlMlpW5CjG9r/d388bXDoXd7CBO6GGDr7MOBEz/DXrFVVHi6XnK+9
         TH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PIpz25qQ7yf51AefTUMALv/g3aMmkg34g7VHvrvSen4=;
        fh=PKzu0KhvvJ/vqnQTO+rYciOmlkH8027hUALM03bUBag=;
        b=UVP27BPaYuFw/ARIQZeeMVuAgD7j1v41iblYGiDChqmt29kJpZZxYqVayZ8JdA6rhM
         0kZhBeQg6HyQCY18cA2ZNsmNMu0Za0bgxSjN7YVLsBEA2YywIXruslj+imcblfMM/5zn
         ozVtkJvioH03EShJoXHviKHSocfcjar/YnnUFk5uxoxDlun+zQEkbgK7o0jIoxobDFCq
         GQV+dzB9kVvgOuj1xSwe+Do0n1iqOYxyTBBuenjbIDZnL73FqTr1kwoIwd9rWpxBl/Ov
         rqeAl4U8W65r68O2lDOzUvrbjhS890fKAdRU3CDPkuizmXwrkHzrrjNUu21cwQPJK1eT
         bXLg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778150422; x=1778755222; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIpz25qQ7yf51AefTUMALv/g3aMmkg34g7VHvrvSen4=;
        b=LXwsVEv3NsZQ8um9ALalVTm2JYVYKNqmGC8x2Tfp4NUsSAu9OhRyZQ8dlV4NhkZEOE
         hqIDGEDjBJTfxE4UEW8r1MWvLWu1fkwCn8DY4XLxJNc2Cs49lP423ozriX3d3iDrK1xX
         h8UnxdnaVenWaC900AvBlnfU676m72RzOcpbv3AqUIvsRJ6jcmZl57CCrYIRa2sDdw6B
         +2r0EFor9VeLiu7yN876o4JH2Pdmn0m3UA2vwIFV0+cznhIxFAMfcYbyGgw07NtCQg+v
         Af8+kw36QBP8Kb71oBd1CvwtCuODG9PPVSIVQvnRPiG6XqIS6HHFyZmnyKiv9qxw2YAM
         3xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778150422; x=1778755222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIpz25qQ7yf51AefTUMALv/g3aMmkg34g7VHvrvSen4=;
        b=TyzwNKEmCekdkvIp7MDNg1eS8gXoE8YvP1P2PtAEAdsC2mGim+x+WFNh4Zpo0DlPE2
         tpdPzu9zZ0vepb4LoszUzq2A3XOwRLdn0kPxTxpeKJm5qXLC5QeVYh6EcMJ/Sml/WRP6
         tz4jp5wUcYQjZk2JQhSBQlGdyRkywmMHfZQizHztDIxVxOzzMRk/2rDgMa+bIVCJaEpG
         9p6G07xTB4/1S8RCipBZ66x81eQwlEtEcSAyWuGio/hsX8fUrxnwBQpKbjS+55wIcqIr
         fPac7LrGHK8hz3j7NH/f+d98yvZqvKb8iLZiFUaFL6NZhsKwybuNn9qwl3bvjxiIGZw6
         Xlxw==
X-Forwarded-Encrypted: i=1; AFNElJ/NaQu7bHh3fUKwrS995z+AV2OSk2MVfAtaoqhzHbYKtBHqtD7O1jAPyacRGGRsRs6JurQB3hw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxUtmGfDr6MmdLzzwMylSdynYzsBTPtgYKd8C08/N8LhLui8d00
	XEi+WIOCZx84wrxwohh5hRnUzDqQoVQpO8BQy6qY8/BPa/EpU/1W4XiMIYEgdCuFvJOprVp4RQG
	+Rzp9xKcK8mvQ9c0wOuAHjSaMUx8gNUlsW6p9IEvunV45
X-Gm-Gg: AeBDiesC0Wpiv3JoY1oP0oMhekmFWyRSEeKvNnt8Lz4j0QMuDn1ysQD4HUw4ddU3rpe
	DbUS3GSgwuNWclNZWOtt5v3F94Yf5/iecXD/DKS9CTNKhXfoYFD94P8f7WB+4k49E4yNsDvtof1
	Ys5KfhiLtYI8JpILAtkCu9Yuk8vMgAdYKL2u1OLF8ieR2ojH+gTTXVbu6c8zYeu+nD/G/cP3AXC
	xBHm8hoxY3mJhXmJw8x1thsRMmgDcXs8dFwlACOmkc7CA2DCJtNy9xODJAIzSDYBFeZ1VPUH84T
	SaU1l9GD2kWVjqbSduyyuz5caxs/0h63+kgvU/FAKgfC/e6z
X-Received: by 2002:a05:6871:c968:b0:428:6d0d:e61b with SMTP id
 586e51a60fabf-434f58db781mr4800240fac.8.1778150422330; Thu, 07 May 2026
 03:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260505153041.17794-1-q.h.hack.winter@gmail.com> <20260507094554.66926-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260507094554.66926-1-q.h.hack.winter@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 7 May 2026 12:40:10 +0200
X-Gm-Features: AVHnY4JEXSLB10VfeZSMZZtKzqiHH9lj2gsVqqe2YeMtURPh8a7oETuU9NqEL2Q
Message-ID: <CAHUa44FUOst-wDZzCkvWA=V7e+U7eATepKmvSV2YizO11J3opA@mail.gmail.com>
Subject: Re: [PATCH v3] tee: fix params_from_user() error path in tee_ioctl_supp_recv
To: Qihang <q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.53:from];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.53:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1D8904326C
X-Spamd-Bar: -----
Message-ID-Hash: CN4ON37WPBN6DNFXFW6DIAWH5SNCSKGJ
X-Message-ID-Hash: CN4ON37WPBN6DNFXFW6DIAWH5SNCSKGJ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CN4ON37WPBN6DNFXFW6DIAWH5SNCSKGJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, May 7, 2026 at 11:46=E2=80=AFAM Qihang <q.h.hack.winter@gmail.com> =
wrote:
>
> params_from_user() may acquire tee_shm references for MEMREF parameters
> before failing after partially processing the supplied parameter array.
>
> In tee_ioctl_supp_recv(), those references are currently not released on
> that error path.
>
> Fix this by freeing MEMREF references before returning when
> params_from_user() fails.
>
> Keep the final cleanup path in tee_ioctl_supp_recv() unchanged since
> supp_recv() may consume and replace the supplied parameters, unlike the
> other TEE ioctl callback paths.
>
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
> v3:
> - only free MEMREF references when params_from_user() fails
> - keep tee_ioctl_supp_recv() final cleanup unchanged
> - follow Jens' review on supp_recv() parameter ownership semantics
>
> v2:
> - rename helper to free_params()
> - drop alloc_num_params and use num_params directly
>
>  drivers/tee/tee_core.c | 54 ++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index ef9642d72672..2fd3a00b47c7 100644
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

Please fold up. It fits on one line.

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
> @@ -846,9 +838,15 @@ static int tee_ioctl_supp_recv(struct tee_context *c=
tx,
>                 return -ENOMEM;
>
>         rc =3D params_from_user(ctx, params, num_params, uarg->params);
> -       if (rc)
> -               goto out;
> +       if (rc) {
> +               free_params(params, num_params);
> +               return rc;
> +       }
>
> +       /*
> +        * supp_recv() may consume and replace the supplied parameters, s=
o the
> +        * final cleanup cannot use free_params() like the other ioctl pa=
ths.
> +        */
>         rc =3D ctx->teedev->desc->ops->supp_recv(ctx, &func, &num_params,=
 params);
>         if (rc)
>                 goto out;
> --
> 2.39.5 (Apple Git-154)
>

There are a few warnings:
  AR      drivers/base/firmware_loader/built-in.a
  AR      drivers/base/built-in.a
drivers/tee/tee_core.c: In function =E2=80=98tee_ioctl_open_session=E2=80=
=99:
drivers/tee/tee_core.c:552:16: warning: unused variable =E2=80=98n=E2=80=99=
 [-Wunused-variable]
  552 |         size_t n;
      |                ^
drivers/tee/tee_core.c: In function =E2=80=98tee_ioctl_invoke=E2=80=99:
drivers/tee/tee_core.c:622:16: warning: unused variable =E2=80=98n=E2=80=99=
 [-Wunused-variable]
  622 |         size_t n;
      |                ^
drivers/tee/tee_core.c: In function =E2=80=98tee_ioctl_object_invoke=E2=80=
=99:
drivers/tee/tee_core.c:676:16: warning: unused variable =E2=80=98n=E2=80=99=
 [-Wunused-variable]
  676 |         size_t n;
      |                ^

Cheers,
Jens
