Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286FBC7115A
	for <op-tee@archiver.kernel.org>; Thu, 19 Jun 2025 14:08:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 625CB42FC7
	for <op-tee@archiver.kernel.org>; Thu, 19 Jun 2025 14:08:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VUocbqHa;
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1067742CB3
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Jun 2025 14:07:47 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-606668f8d51so485900eaf.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 19 Jun 2025 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750342066; x=1750946866; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxQn0+UwCZdB8+kuRED9SDCjWsgD3/vNPAfkKZAahSg=;
        b=VUocbqHaRaEbaFtoQgZUUXRiBuauJ1hGEzW61cNwVvimEAF+5mQeRYeGMZ9iFBC63w
         Y/JnQvVsGDIDMHyFEqT5OCqQD/cDsJdjF1u6TgHGsWReA6hBCB5lPJMGzceG2TZN3Zdn
         NxrJF/vzzhONBn75vey5z/+W1XOToloEExMMk0bQ9xKG44DQLf64EWJDQquwamaHt+oc
         cDhKHbYDm1qn0vml/OuG+ZlETGM8ZokMVQIYY8U6XBrcrXymeMkANtGGGNjj8GZNAGDU
         ESkaJtNfURG+uuKHA4kWTJdTnK3UbPqtK54b3sPjmUH+rUS97sHtN7eSnwF0sPOGOJVS
         V3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750342066; x=1750946866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxQn0+UwCZdB8+kuRED9SDCjWsgD3/vNPAfkKZAahSg=;
        b=Qg2P+Ar6yhnv3iqf4sR6aaPLkt3RZq0e15G4crum2Mx0UvdPiTKZPujMTvMQn5dC0Y
         ptvg/RE3x+isIWHd/T8IdgMLHdV4ZyFI24bnltdk3ItlF7iN59XmzNtA5/nm09TY740d
         bM9lxJc1t0F7e/d9A6TN2lVG6huHrRRhJ9/RYt+6dHS86Up9WV+KS6UOxNjwRQgHDVLm
         kq6yLOLWy9KOm5gpvCLqw5oX/p0DSjy4Wj9FCibBJMYSrT3tlRJRCcd3NHsITtibO7Rh
         y7CLxw0v+6LhiufUBNE8ifL2Tz9kJxBc70VVYIlISaaGPkpRcvvjJRmeXrvRmk06NAyN
         aOiA==
X-Forwarded-Encrypted: i=1; AJvYcCW70L/oH06z8lnRKNlpawRrHEC333ZuGEDHTGc/EQogO76Y6xFh0hoFQC0s91Zfodb1K0GFEUE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxYD3ySbO9pSVP8O2mw1iBbYJ0/9EOYO+1RzaJmekwZIRloF63+
	h3okVfPW5KGl4cMUQK0L3loY+9hMMmfOoSGKGy1s220RAXKKq4mWgUZ1dVfG/IJ30uRx8BLtND2
	iPVNhQo5IsLuULlrXEu++YMeZX6y+8rsEquBjY6bTg7U9
X-Gm-Gg: ASbGncu2hALCrLYaJ2XfgzoHmGhS82WbjZS4y/7aCFWaePxD3Q1QuioRER5iBL+X8iT
	umBecQAepLSSHsKXrZSFlEEyO7MiXouID4QREh/vsawDSXtEgC3UXRlPlpN2DhqXqld0jav19ra
	ZiCdLnbpgY47FC4reUSlsMrGnFUb3+WnTR2lKbBEMmNh7u
X-Google-Smtp-Source: AGHT+IGXvZ40hrmZiYJZZCcwbXjy8PSiCyt1BH44mnuhNKLI3QY7O7yjY4Y/tPOUIIPpC3COlra1CDMJTvdJt5Aazrs=
X-Received: by 2002:a05:6820:2089:b0:609:f8f1:ce61 with SMTP id
 006d021491bc7-6114ea7afd9mr2141277eaf.4.1750342066211; Thu, 19 Jun 2025
 07:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250617-fix-use-after-free-v2-1-1fbfafec5917@oss.qualcomm.com>
In-Reply-To: <20250617-fix-use-after-free-v2-1-1fbfafec5917@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 19 Jun 2025 16:07:34 +0200
X-Gm-Features: AX0GCFv0FVByDiAsjF2r8aN4tNzKDWhpFJ_NCybzIrg5KRsxpfcfjo2wwISMV-k
Message-ID: <CAHUa44Ew0nhw4xW_K==x-9RU9VU1YzEkOghVreae11b1H4_aGQ@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: prevent use-after-free when the client
 exits before the supplicant
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1067742CB3
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.49:from];
	MIME_GOOD(-0.10)[text/plain];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.49:from];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: JDCCACKN3KACX7YXNMQ4W37ZCKS7QKW3
X-Message-ID-Hash: JDCCACKN3KACX7YXNMQ4W37ZCKS7QKW3
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JDCCACKN3KACX7YXNMQ4W37ZCKS7QKW3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Wed, Jun 18, 2025 at 6:26=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Commit 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop") made the
> client wait as killable so it can be interrupted during shutdown or
> after a supplicant crash. This changes the original lifetime expectations=
:
> the client task can now terminate while the supplicant is still processin=
g
> its request.
>
> If the client exits first it removes the request from its queue and
> kfree()s it, while the request ID remains in supp->idr. A subsequent
> lookup on the supplicant path then dereferences freed memory, leading to
> a use-after-free.
>
> Serialise access to the request with supp->mutex:
>
>   * Hold supp->mutex in optee_supp_recv() and optee_supp_send() while
>     looking up and touching the request.
>   * Let optee_supp_thrd_req() notice that the client has terminated and
>     signal optee_supp_send() accordingly.
>
> With these changes the request cannot be freed while the supplicant still
> has a reference, eliminating the race.
>
> Fixes: 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop")
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
> Changes in v2:
> - Replace the static variable with a sentinel value.
> - Fix the issue with returning the popped request to the supplicant.
> - Link to v1: https://lore.kernel.org/r/20250605-fix-use-after-free-v1-1-=
a70d23bff248@oss.qualcomm.com
> ---
>  drivers/tee/optee/supp.c | 110 ++++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 75 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index d0f397c90242..fa39f5f226aa 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -9,6 +9,7 @@
>
>  struct optee_supp_req {
>         struct list_head link;
> +       int id;
>
>         bool in_queue;
>         u32 func;
> @@ -19,6 +20,9 @@ struct optee_supp_req {
>         struct completion c;
>  };
>
> +/* It is temporary request used for invalid pending request in supp->idr=
. */
> +#define INVALID_REQ_PTR ((struct optee_supp_req *)ERR_PTR(-ENOENT))
> +
>  void optee_supp_init(struct optee_supp *supp)
>  {
>         memset(supp, 0, sizeof(*supp));
> @@ -102,6 +106,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 =
func, size_t num_params,
>         mutex_lock(&supp->mutex);
>         list_add_tail(&req->link, &supp->reqs);
>         req->in_queue =3D true;
> +       req->id =3D -1;
>         mutex_unlock(&supp->mutex);
>
>         /* Tell an eventual waiter there's a new request */
> @@ -117,21 +122,40 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u3=
2 func, size_t num_params,
>         if (wait_for_completion_killable(&req->c)) {
>                 mutex_lock(&supp->mutex);
>                 if (req->in_queue) {
> +                       /* Supplicant has not seen this request yet. */
>                         list_del(&req->link);
>                         req->in_queue =3D false;
> +
> +                       ret =3D TEEC_ERROR_COMMUNICATION;
> +               } else if (req->id  =3D=3D -1) {
> +                       /*
> +                        * Supplicant has processed this request. Ignore =
the
> +                        * kill signal for now and submit the result.
> +                        */
> +                       ret =3D req->ret;
> +               } else {
> +                       /*
> +                        * Supplicant is in the middle of processing this
> +                        * request. Replace req with INVALID_REQ_PTR so t=
hat
> +                        * the ID remains busy, causing optee_supp_send()=
 to
> +                        * fail on the next call to supp_pop_req() with t=
his ID.
> +                        */
> +                       idr_replace(&supp->idr, INVALID_REQ_PTR, req->id)=
;
> +                       ret =3D TEEC_ERROR_COMMUNICATION;
>                 }
> +
>                 mutex_unlock(&supp->mutex);
> -               req->ret =3D TEEC_ERROR_COMMUNICATION;
> +       } else {
> +               ret =3D req->ret;
>         }
>
> -       ret =3D req->ret;
>         kfree(req);
>
>         return ret;
>  }
>
>  static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
> -                                             int num_params, int *id)
> +                                             int num_params)
>  {
>         struct optee_supp_req *req;
>
> @@ -153,8 +177,8 @@ static struct optee_supp_req  *supp_pop_entry(struct =
optee_supp *supp,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       *id =3D idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
> -       if (*id < 0)
> +       req->id =3D idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);

I'd prefer only assigning positive values to req->id. Even if
idr_alloc() might never return -1 it's still a bit messy.

Cheers,
Jens

> +       if (req->id < 0)
>                 return ERR_PTR(-ENOMEM);
>
>         list_del(&req->link);
> @@ -214,7 +238,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *fun=
c, u32 *num_params,
>         struct optee *optee =3D tee_get_drvdata(teedev);
>         struct optee_supp *supp =3D &optee->supp;
>         struct optee_supp_req *req =3D NULL;
> -       int id;
>         size_t num_meta;
>         int rc;
>
> @@ -223,16 +246,47 @@ int optee_supp_recv(struct tee_context *ctx, u32 *f=
unc, u32 *num_params,
>                 return rc;
>
>         while (true) {
> -               mutex_lock(&supp->mutex);
> -               req =3D supp_pop_entry(supp, *num_params - num_meta, &id)=
;
> -               mutex_unlock(&supp->mutex);
> +               scoped_guard(mutex, &supp->mutex) {
> +                       req =3D supp_pop_entry(supp, *num_params - num_me=
ta);
> +                       if (!req)
> +                               goto wait_for_request;
>
> -               if (req) {
>                         if (IS_ERR(req))
>                                 return PTR_ERR(req);
> -                       break;
> +
> +                       /*
> +                        * Process the request while holding the lock,
> +                        * so that optee_supp_thrd_req() doesn't pull the
> +                        * request out from under us.
> +                        */
> +
> +                       if (num_meta) {
> +                               /*
> +                                * tee-supplicant support meta parameters=
 ->
> +                                * requests can be processed asynchronous=
ly.
> +                                */
> +                               param->attr =3D
> +                                       TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_I=
NOUT |
> +                                       TEE_IOCTL_PARAM_ATTR_META;
> +                               param->u.value.a =3D req->id;
> +                               param->u.value.b =3D 0;
> +                               param->u.value.c =3D 0;
> +                       } else {
> +                               supp->req_id =3D req->id;
> +                       }
> +
> +                       *func =3D req->func;
> +                       *num_params =3D req->num_params + num_meta;
> +                       memcpy(param + num_meta, req->param,
> +                              sizeof(struct tee_param) * req->num_params=
);
> +
> +                       return 0;
>                 }
>
> +               /* Check for the next request in the queue. */
> +               continue;
> +
> +wait_for_request:
>                 /*
>                  * If we didn't get a request we'll block in
>                  * wait_for_completion() to avoid needless spinning.
> @@ -245,27 +299,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *fu=
nc, u32 *num_params,
>                         return -ERESTARTSYS;
>         }
>
> -       if (num_meta) {
> -               /*
> -                * tee-supplicant support meta parameters -> requsts can =
be
> -                * processed asynchronously.
> -                */
> -               param->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT |
> -                             TEE_IOCTL_PARAM_ATTR_META;
> -               param->u.value.a =3D id;
> -               param->u.value.b =3D 0;
> -               param->u.value.c =3D 0;
> -       } else {
> -               mutex_lock(&supp->mutex);
> -               supp->req_id =3D id;
> -               mutex_unlock(&supp->mutex);
> -       }
> -
> -       *func =3D req->func;
> -       *num_params =3D req->num_params + num_meta;
> -       memcpy(param + num_meta, req->param,
> -              sizeof(struct tee_param) * req->num_params);
> -
>         return 0;
>  }
>
> @@ -297,12 +330,19 @@ static struct optee_supp_req *supp_pop_req(struct o=
ptee_supp *supp,
>         if (!req)
>                 return ERR_PTR(-ENOENT);
>
> +       /* optee_supp_thrd_req() already returned to optee. */
> +       if (IS_ERR(req))
> +               goto failed_req;
> +
>         if ((num_params - nm) !=3D req->num_params)
>                 return ERR_PTR(-EINVAL);
>
> +       req->id =3D -1;
> +       *num_meta =3D nm;
> +failed_req:
>         idr_remove(&supp->idr, id);
>         supp->req_id =3D -1;
> -       *num_meta =3D nm;
> +
>
>         return req;
>  }
> @@ -328,9 +368,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret,=
 u32 num_params,
>
>         mutex_lock(&supp->mutex);
>         req =3D supp_pop_req(supp, num_params, param, &num_meta);
> -       mutex_unlock(&supp->mutex);
> -
>         if (IS_ERR(req)) {
> +               mutex_unlock(&supp->mutex);
>                 /* Something is wrong, let supplicant restart. */
>                 return PTR_ERR(req);
>         }
> @@ -358,6 +397,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret,=
 u32 num_params,
>
>         /* Let the requesting thread continue */
>         complete(&req->c);
> +       mutex_unlock(&supp->mutex);
>
>         return 0;
>  }
>
> ---
> base-commit: 3be1a7a31fbda82f3604b6c31e4f390110de1b46
> change-id: 20250604-fix-use-after-free-8ff1b5d5d774
>
> Best regards,
> --
> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>
