Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C7BC5B552
	for <op-tee@archiver.kernel.org>; Mon,  9 Jun 2025 13:01:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EB5CF45437
	for <op-tee@archiver.kernel.org>; Mon,  9 Jun 2025 13:01:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xdJH6fif;
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2C2FC3F598
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Jun 2025 13:00:58 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4067b7d7e52so1013203b6e.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 09 Jun 2025 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749474057; x=1750078857; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYtTd8X3ioZoP4ZqCiRHyNkyAopif3v2teL9bFi+ppk=;
        b=xdJH6fiftCJtAdnHEuh97cSPm6s1v0smlT3pqanPi2kCdP+fzO0Xci23hgK0Q+/LQr
         hn2oxWy6UQnVDbAXAAm/ERdm3a2M6/7qzfrRdjp+Dh5MaZZ759gya+77mv9XAda0w5rq
         M1ji7uTKAjxUL38kTW9Uhr7ZTgMNrf0y0u1SoUXRh6Eh6e/lmPKqbEU1BjUkwuv4A0eu
         7x+mBqpNBmRr+e0bKHlDog4ctKeZZugaa+D8k8CR0R5+8dZU6R8v3bRLJGWQlKBNlhsK
         X+RQ2lxcVIzbmfa4ficeL+Ub94HrReuS+IiDMQj9lTCQjJJ8vxnVSgbf56a9NXQtNhYw
         FVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749474057; x=1750078857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYtTd8X3ioZoP4ZqCiRHyNkyAopif3v2teL9bFi+ppk=;
        b=vJ1sqxTcw+HuzbF7MKAnCuw1BPGYERUB/f/PbeB8GBqdo6EzZTAqo1CwNNdCP5VnQR
         50SRnoTtN//B9pTpZcUAAMh56Ue9R3xeET3abDvzG8k/XT1JUUUr4m481yn1F0z5db34
         tw+Hl8G4COwBC1ZBCl+xTTqCelyBAJWQZ9pjDHUGt99k74ww6ITXBhUzfr026QBo0cSI
         c4eNjY73dOdCyv3rOTka/qJMlWASGGeK1OKNqZ2q+LNqytrB7jPWYazE8iKLXueV4eg8
         4S5HK9FNuFL010M/9vUMG6dDlCzVqw8bmq6xT0/rrYrrD3SvqQT10f8pX4Ljmu4Skd7i
         yBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFc0YP2/thpGoZkkooAUbl1z3pSeErhJYVOKpjGiqY1xOLn2Ba1/OWzDbNfhuLHL7gAvSa2Z4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwwjWnUxfUp+GQjohOx/m5k3AKF/L5fstEVZr+rFxiyyUYV/qKa
	/TXmhtdF6YrlBHmmM74NNFbXCBVZS8iwXyveFWWMoictFDW28UqzRFeok4ukx4M+uOPiKb3A0Z4
	xCNdefs4QRYzqo7m7KWIXVrN1M02jy5IoFDm5T3NoNwJh
X-Gm-Gg: ASbGncvnDRt2XJEDVOr0kyjiDbRCH3b1j22Dwf6ISljGKb3II3t8lagZu00P2TrEPRL
	+iFRGFliNVxKN0U/I6Fw3RS8044mt1aLI7P6jb0AOFIeRVnsbNbD0RhIf8x/Ob+W/mLNOoV+RoT
	vb1U2dr1VCSLTdB1oyv5eT/pbgWiu5YEuNOixZdzmq44zP
X-Google-Smtp-Source: AGHT+IEx5dBBYalreZpgcAi7SiMqb9bdO3lo6yhdnudOtUBVFZ+AX4nRBzDMZ/8OpWtkY6MrxyYR2ncP1ceSLRn0V4Q=
X-Received: by 2002:a05:6808:5086:b0:409:f8e:727f with SMTP id
 5614622812f47-4090f8e7a1cmr6634453b6e.3.1749474057017; Mon, 09 Jun 2025
 06:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250605-fix-use-after-free-v1-1-a70d23bff248@oss.qualcomm.com>
In-Reply-To: <20250605-fix-use-after-free-v1-1-a70d23bff248@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 9 Jun 2025 15:00:45 +0200
X-Gm-Features: AX0GCFs0onTtmhC4kVNMBNJ2gfnQX-I7Oo5EtaFJz3aIdTdjQHDdvJiA4KNJJYM
Message-ID: <CAHUa44EyGXswbYLgdrfH_cMSyadgVUAJDGAMdsPXQVN7V7Nhsw@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: prevent use-after-free when the client exits
 before the supplicant
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.179:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.167.179:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2C2FC3F598
Message-ID-Hash: B7XUXRQEIULSBNIMZWAA4ZIWMQVR7F3W
X-Message-ID-Hash: B7XUXRQEIULSBNIMZWAA4ZIWMQVR7F3W
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B7XUXRQEIULSBNIMZWAA4ZIWMQVR7F3W/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Fri, Jun 6, 2025 at 4:01=E2=80=AFAM Amirreza Zarrabi
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
>  drivers/tee/optee/supp.c | 114 ++++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 77 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index d0f397c90242..62c9c75f48a6 100644
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
> +static struct optee_supp_req invalid_req;

Prefer avoiding global variables where possible.

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
> +                        * request. Replace req with invalid_req so that =
the ID
> +                        * remains busy, causing optee_supp_send() to fai=
l on
> +                        * the next call to supp_pop_req() with this ID.
> +                        */
> +                       idr_replace(&supp->idr, &invalid_req, req->id);
> +                       ret =3D TEEC_ERROR_COMMUNICATION;
>                 }
> +
> +               kfree(req);
>                 mutex_unlock(&supp->mutex);
> -               req->ret =3D TEEC_ERROR_COMMUNICATION;
> +       } else {
> +               ret =3D req->ret;
> +               kfree(req);
>         }
>
> -       ret =3D req->ret;
> -       kfree(req);
> -
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
> @@ -223,16 +246,45 @@ int optee_supp_recv(struct tee_context *ctx, u32 *f=
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
> +                        * Popped a request: process it while holding the=
 lock,
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

This is the point at which this function must break out of the loop
and return the request, or it will be lost.

Cheers,
Jens

>                 }
>
> +               /* Check for the next request in the queue. */
> +               continue;
> +
> +wait_for_request:
>                 /*
>                  * If we didn't get a request we'll block in
>                  * wait_for_completion() to avoid needless spinning.
> @@ -245,27 +297,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *fu=
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
> @@ -297,12 +328,21 @@ static struct optee_supp_req *supp_pop_req(struct o=
ptee_supp *supp,
>         if (!req)
>                 return ERR_PTR(-ENOENT);
>
> +       /* optee_supp_thrd_req() already returned to optee. */
> +       if (req =3D=3D &invalid_req) {
> +               req =3D ERR_PTR(-ENOENT);
> +               goto failed_req;
> +       }
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
