Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24510CD37BE
	for <op-tee@archiver.kernel.org>; Mon, 11 May 2026 13:19:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 539C0444BA
	for <op-tee@archiver.kernel.org>; Mon, 11 May 2026 13:19:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LAGHVPLv;
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E585A43719
	for <op-tee@lists.trustedfirmware.org>; Mon, 11 May 2026 13:19:06 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479d593a0c3so3681495b6e.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 11 May 2026 06:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505546; cv=none;
        d=google.com; s=arc-20240605;
        b=EwXiGE+ZBUw2XKO6nvrxwrXcgsirKX5c8aHaj06OTQGU9GGg9UM4PMVDYF4WtJMeh5
         VqJP42lDAwjNG4X+vIAVX0K3F+lDBzkmNyI/J2DDO3Esc2+bkEcwwNxCFpqKkcAKtu7z
         ywBdt6dBim05ZiGvTll7Y5r1u20QZ2l264ULSaTj42hy2n085orP014NhscIR5tj9vW5
         vr3ptcI6nBVnHXrkAvCB1n923+pd0Ijdx2sAkrtPkOkh660tm569yZ7IXepqc5dmPO1u
         HmZyRQYLxhFfiyPPVBSX5lgNtGgWyS4MhJxDKmasP/YYxWFVOEStAu5LANnnDQCCJc7E
         mtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EnzLbaDveWDWnmtgjIFjSTeXIi3Y5au+zzO+xbdWUgs=;
        fh=VWMfr/JTSKx+75NkcUZr+gM/RHkdZM9DP6PHBGKGO4A=;
        b=jTEoUs6THrMddRbshzzzzUwDzmcmb97X4mIV9YavuUhvHTIlAI6hMHSy4J0TmUgcYZ
         dXj4QO9afHXrlys2JeInXf7x1pkoM50mX6AWGkekqu/pW+PsMt7Z3rB87AVYLBgua158
         kjWBAqq4gr13s8/BK0Py1O18Eaghc4xFOk8Wf7ZFE4kBNTceT5JbqJMGUDGepSKQx+uE
         6DNeM6QqRRToxvJ0z71JoXQeExD+01fe49BTKhVmYs5OTb/Kg6SVH2vHd0+lgi6Gn25e
         qDR9494gn5LujeXfBYAvOx3TCe5va2LtB5hagA4uH00VbLmZKMY8qYu6/2MlnLJaJYfJ
         LPrw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778505546; x=1779110346; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnzLbaDveWDWnmtgjIFjSTeXIi3Y5au+zzO+xbdWUgs=;
        b=LAGHVPLvCyWbQxWst0EwWCXewurXLl271pEMCJq93s5mlbMKbGpn16PRxj8Hjh5yB8
         2H7tEV401ZSXN6BpcESPQ250DcZxVRpfNyYYDW6xneadF1CcxwW1JfXh9UWAT/rCRj4l
         PwrF05rme7aAwRZiS3YAQoJM/kzsuy/Ix7BVaZC6+XqFLI0HbVT25hLFrjZcIa4PEu4m
         dUkfjkGKmxrjbPVuTHIE61r1lUi9h2QAtQvleM4tnBhiU79uTgVXI+gqFXZGP9G12bKa
         r2iDMAG5/3bUtA6rWKo4RR7fVx981b39f4XVihImbnNX33STpQf/mRI6vtkRFkMH8/Ti
         rhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505546; x=1779110346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EnzLbaDveWDWnmtgjIFjSTeXIi3Y5au+zzO+xbdWUgs=;
        b=J6M3r5NzCmJhPhDLEYBE9x+tFqNUp5lXV48fsKV1WM1Sp5takdZF5JxCTxiaK1IUXW
         lyjS3PwBvp+e9x4NzSbBwNb4M7TycTM/bVpkCreQaGy080YqtPbgwrxBnXIMBlrySle2
         eEsAf5aqCrSyAfFH+s7FYsKvdD9ZsKmZbENbmpkUF9Ri41GO04KAyX/dxzQXuQE6w2JQ
         IBKMfl8EJIQDN2ztcPETHGleNbKKDazQCAle3ol/b+T64FBInOMkJMiTvGMrlt81WAMr
         aS2JFVnT3XKO+w5sLYb2kcP9ThZgD/EMX4dFawjdj7B+yBj8sq55yH1cd6oVj5FgADjl
         EqVA==
X-Forwarded-Encrypted: i=1; AFNElJ+ys9TJumeklk+gGkRyg3YGo+q8Xxeneq8ufNQYgV4P1glJO0LbApt9rYZqW80biVgkjDq8PlI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwdSDqqnrsnvg378H+YKSN1UVv4Ygj+ISw2UND9PFyoA918WaSk
	ES8tYjg1zFUrccAR2i7fdx20tHBffvOmFEUC62GCQ5Xf/QnmVuICKRX//p/mTb36F1Zl/sZwVXI
	FYsMboTFrKIof8MutJdKXyy2lUmBWiJvbE31C1GscdBXo
X-Gm-Gg: Acq92OE5oYuCDKt3O7vo3f7aMB2oTQP1pv4UWqKHvipQX6dSCDBOVmFiB08ruRz8Pv8
	X0IVRVu9xdDiac28xuy2ggZq1+w9F8nhdAwupdgUjyBPs63BpcPsYWvJ3z4/RxoiBBFSNZHVjvd
	0lM1EtmufUK3xUt4g4ALzBhQ9qnTeHTbgHVJQB66zuxRK+lQT+17+Rk6A8NhNh4n/yykNBAWypY
	y7NoeXoyI3L5Rh9x23t+G2F3npJypPCVkyH44UxwYuhJL4AFzxnUARGxG3pyNFEGB6BG9/9zs2m
	Zqej1OV5kW18I895rF+uTV9paUT6mMc3By7YGktR4+GAp+Zx
X-Received: by 2002:a05:6808:1305:b0:47c:17b1:e69e with SMTP id
 5614622812f47-48061b249femr9775946b6e.11.1778505546269; Mon, 11 May 2026
 06:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260507094554.66926-1-q.h.hack.winter@gmail.com> <20260507153917.73532-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260507153917.73532-1-q.h.hack.winter@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 11 May 2026 15:18:53 +0200
X-Gm-Features: AVHnY4JZQuFH31E32o4X1xkwqm7BNTcQD3ekqTZwvGkxewMMk435-AfdOZyYwUQ
Message-ID: <CAHUa44Fq=i5FAM4HOgxpPGVW2sC0Fg9KB_xMKSSvp1zZYd=fmQ@mail.gmail.com>
Subject: Re: [PATCH v4] tee: fix params_from_user() error path in tee_ioctl_supp_recv
To: Qihang <q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.180:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.180:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E585A43719
X-Spamd-Bar: -----
Message-ID-Hash: EPJX3WREDTS3TBF7UPUJQT5CSH45VLAR
X-Message-ID-Hash: EPJX3WREDTS3TBF7UPUJQT5CSH45VLAR
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EPJX3WREDTS3TBF7UPUJQT5CSH45VLAR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, May 7, 2026 at 5:39=E2=80=AFPM Qihang <q.h.hack.winter@gmail.com> w=
rote:
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
> v4:
> - fold free_params() memref check onto one line
> - remove unused local variables left behind by the cleanup refactoring
>
> v3:
> - only free MEMREF references when params_from_user() fails
> - keep tee_ioctl_supp_recv() final cleanup unchanged
> - follow Jens' review on supp_recv() parameter ownership semantics
>
> v2:
> - rename helper to free_params()
> - drop alloc_num_params and use num_params directly
>
>  drivers/tee/tee_core.c | 56 +++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 31 deletions(-)

Looks good. I'm picking up this.

Cheers,
Jens

>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index ef9642d72672..1aac50c7c1de 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -530,11 +530,24 @@ static int params_to_user(struct tee_ioctl_param __=
user *uparams,
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
> +               if (tee_param_is_memref(params + n) && params[n].u.memref=
.shm)
> +                       tee_shm_put(params[n].u.memref.shm);
> +
> +       kfree(params);
> +}
> +
>  static int tee_ioctl_open_session(struct tee_context *ctx,
>                                   struct tee_ioctl_buf_data __user *ubuf)
>  {
>         int rc;
> -       size_t n;
>         struct tee_ioctl_buf_data buf;
>         struct tee_ioctl_open_session_arg __user *uarg;
>         struct tee_ioctl_open_session_arg arg;
> @@ -595,16 +608,7 @@ static int tee_ioctl_open_session(struct tee_context=
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
> @@ -612,7 +616,6 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
>                             struct tee_ioctl_buf_data __user *ubuf)
>  {
>         int rc;
> -       size_t n;
>         struct tee_ioctl_buf_data buf;
>         struct tee_ioctl_invoke_arg __user *uarg;
>         struct tee_ioctl_invoke_arg arg;
> @@ -657,14 +660,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
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
> @@ -672,7 +668,6 @@ static int tee_ioctl_object_invoke(struct tee_context=
 *ctx,
>                                    struct tee_ioctl_buf_data __user *ubuf=
)
>  {
>         int rc;
> -       size_t n;
>         struct tee_ioctl_buf_data buf;
>         struct tee_ioctl_object_invoke_arg __user *uarg;
>         struct tee_ioctl_object_invoke_arg arg;
> @@ -716,14 +711,7 @@ static int tee_ioctl_object_invoke(struct tee_contex=
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
> @@ -846,9 +834,15 @@ static int tee_ioctl_supp_recv(struct tee_context *c=
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
