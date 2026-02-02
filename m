Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C61E7315B
	for <op-tee@archiver.kernel.org>; Mon,  2 Feb 2026 11:36:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B89BD436FA
	for <op-tee@archiver.kernel.org>; Mon,  2 Feb 2026 11:36:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qmTkYagj;
	dkim-atps=neutral
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8D350431AF
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Feb 2026 11:36:19 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40423dbe98bso1936583fac.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Feb 2026 03:36:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770032179; cv=none;
        d=google.com; s=arc-20240605;
        b=QIbh/lq7Fnb3Wqupw8lCRuwJSeFUBDHdt+KetPz3gd+rBix+Mfg6/pPhulFIOwTOGr
         GthX+POoH7EcTlJcw8Zm4/ef206cGcz42g/x3UH6c4WPZSMNS3LuTBnXBhh9QiqSw/ci
         AsWQ1cPJMWPEtW/eTTrKYClIMvSjc1jMNdAKtFKZ0rGG94/bz+Kn9HFPi517/ZB8OD/7
         B1XTSgkf8/tg67lxCh+DJr7aojQ3PxbB2LcPmji2g/t/VwuxImWzWL+vJsuVIF9EQVgM
         40J30loszkYDfxriWoFmf18jEi+kaaupy3XIceWwY23GWU1R4Gjhye4gSBZ9xN1PnK52
         0zLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dOXYzDQiQdPBTZLhCvuKodoTlB7hy579/On5uDSXb8=;
        fh=E6cSqfS7WviG0GvCeXHEcHeNaiXjOSse0q+2HLWHuLM=;
        b=FQNTvSuirSTLTd/zit/MHu+UVmJz+W+LD+JIJJN+ZDPsoakMrKMJ9T8ZzmFu2m1LUN
         z0Z92yzGi8Nz6zmOKMmLsyvaQm98ASrX4pXXx8frcnrR3nBPayp51emETEMneuujjrmD
         b0DcR0/DjK5NGbV3uqFHuSpLTTrxvWQ0dSmRMtpqtlPyr0DO7kw4egB7yF8TCyPWeXNA
         157SUoAnSy1GhlvGJfIxvyCemeq912mR+Oy5acgv1E2Et15uFsBck3tmx9Y4YsXHARdv
         6d4Jv1CATiyYFaUJxV5dmFiHVeY946uX6VFr5I84cGFPv7O2pu/J3twCN22kKWVi1PRI
         wT/g==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770032179; x=1770636979; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dOXYzDQiQdPBTZLhCvuKodoTlB7hy579/On5uDSXb8=;
        b=qmTkYagjidps6PNd4z2hKI9svUoxd/0ni99ZOUcSG82g/mX4w3K1UXbjMceAHAf7j6
         8olCFbpvJ6lbUw6nVp03KBNSc5lW00ouxRUsCOyXpYf580rE0iOt6ZsLUpPmoLORBZZG
         ku5r5JtPUSfppQE4D4ASri8445Oyme3bQ4XAyOxWQC0Y0vWV9RqyOM/SDTHr8UV9pJcL
         faVqJkf6G07XAi55ThNyb700lMhJRZt1YIRbM1sll90OdR/koIufKfMgGStTpegRIYPd
         URIFSJHa2GBtt/xLG4YT2lsOq20D8tmVN0E78N5K/HXLpdNPfRQNBFUEqBB1I05EvbSD
         kb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770032179; x=1770636979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dOXYzDQiQdPBTZLhCvuKodoTlB7hy579/On5uDSXb8=;
        b=DrGH/5ByZMfHA86soc3QeRzRAYTF4/MMMEb60z1P5EhGzndvGYUqnnXCMPmG4CiBHI
         C4T3pOfIuDTMIeb4/hjiogFBDeRXOalNQ/55GHpNwnTTUeic0YQAY9ZWhacSv3bnRRNL
         Qo9WbaGa/cOmZZecMiofpJ1FA8CYlfFMX3uPmsHQYvNsps2Yx3/VIekDtUbcK0TxwcZi
         IPHLQ1E/RevN4t/cg2xPB/eSX4IKLz0aqq9MO6lXISXHhoc0GXO84k02OPFqVXhv1aGB
         sMXWLmw7nVITDsBTmIypqQfO00JkR6hlidIgW13rxZMVD0Z28qM15WmxLR6y3pweH/pS
         BBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2jUmVFcT/+GJyZc2F4x8OviGdazEwYtjm9dQdtilc9W0IDY9UxPUbnPOA2/Z8LIzr4SeoaGU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxbuWE9GHNgZgdNGjJUrYY5uEKlWuOyXUge/1KPnjsTCRLl7UjE
	E2fjeLFB1k0brld76vcAI9ZJ1zOzO1gkLWra75NSRb6dH5ojDowu+FCxDSh/sDIWFnEInB4xNEI
	W9VKfAFaHTX+qvU61Xnpo9xolKihnD+FIaVJvikw+RgvS
X-Gm-Gg: AZuq6aK32QTJT34kERDBpa5tke0NJns/F9hiX+48P+DyhCG0GvISR8QSQApRgaBDKlK
	kpNZQX8G1Jv8dr0h28xorq+/YHjBPOOcjoS1Qm+XbpAD0UmugNEqSSvFBcAwsh8YhxN9kRKonSE
	Znuad7XrTaUrIB0dppKOlmdTc+Kn1+dK+K+2iOULLZYAPPdojkwcrGz5QQgyBkCPNgNm2hBB+vC
	K/3zt9zsuikv1SASeRwmZeOvQSAIo8gEog/AF7JKd1/qzvYtW3fe0sPFXJTq3E+Ml+cMBaRGzX/
	5+rI6Ll6MAbixeh/CnLjOuDpWQ==
X-Received: by 2002:a05:6870:f603:b0:403:fde8:ee9d with SMTP id
 586e51a60fabf-409a6b271famr5560255fac.17.1770032178744; Mon, 02 Feb 2026
 03:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20260128-fix-use-after-free-v3-1-b0786670d927@oss.qualcomm.com>
In-Reply-To: <20260128-fix-use-after-free-v3-1-b0786670d927@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 2 Feb 2026 12:36:06 +0100
X-Gm-Features: AZwV_QidVLzgAx-njwpKRe7qqHjFVfha6zhlz3U9qGFzTueyoAaugssIMPkwzfk
Message-ID: <CAHUa44E4Htg9zEMY9XtkMsPRJq+13mq6kSd8RUznHTRvXVXKVQ@mail.gmail.com>
Subject: Re: [PATCH v3] tee: optee: prevent use-after-free when the client
 exits before the supplicant
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.45:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.45:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8D350431AF
X-Spamd-Bar: -----
Message-ID-Hash: XLWESGXV6EVMAKWB7RRQC43DFKETYDTF
X-Message-ID-Hash: XLWESGXV6EVMAKWB7RRQC43DFKETYDTF
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Wu <michael@allwinnertech.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XLWESGXV6EVMAKWB7RRQC43DFKETYDTF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Thu, Jan 29, 2026 at 4:22=E2=80=AFAM Amirreza Zarrabi
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
> Changes in v3:
> - Introduce processed flag instead of -1 for req->id.
> - Update optee_supp_release() as reported by Michael Wu.
> - Use mutex instead of guard.
> - Link to v2: https://lore.kernel.org/r/20250617-fix-use-after-free-v2-1-=
1fbfafec5917@oss.qualcomm.com
>
> Changes in v2:
> - Replace the static variable with a sentinel value.
> - Fix the issue with returning the popped request to the supplicant.
> - Link to v1: https://lore.kernel.org/r/20250605-fix-use-after-free-v1-1-=
a70d23bff248@oss.qualcomm.com
> ---
>  drivers/tee/optee/supp.c | 122 +++++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 86 insertions(+), 36 deletions(-)

I had forgotten about this. I'd like to prioritize getting this fixed
soon. By the way, how did you test this?

>
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index d0f397c90242..0ec66008df19 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -10,7 +10,11 @@
>  struct optee_supp_req {
>         struct list_head link;
>
> +       int id;
> +
>         bool in_queue;
> +       bool processed;
> +
>         u32 func;
>         u32 ret;
>         size_t num_params;
> @@ -19,6 +23,9 @@ struct optee_supp_req {
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
> @@ -46,6 +53,10 @@ void optee_supp_release(struct optee_supp *supp)
>         /* Abort all request retrieved by supplicant */
>         idr_for_each_entry(&supp->idr, req, id) {
>                 idr_remove(&supp->idr, id);
> +               /* Skip if request was already marked invalid */
> +               if (IS_ERR(req))
> +                       continue;
> +
>                 req->ret =3D TEEC_ERROR_COMMUNICATION;
>                 complete(&req->c);
>         }
> @@ -102,6 +113,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 =
func, size_t num_params,
>         mutex_lock(&supp->mutex);
>         list_add_tail(&req->link, &supp->reqs);
>         req->in_queue =3D true;
> +       req->processed =3D false;
>         mutex_unlock(&supp->mutex);
>
>         /* Tell an eventual waiter there's a new request */
> @@ -117,21 +129,40 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u3=
2 func, size_t num_params,
>         if (wait_for_completion_killable(&req->c)) {
>                 mutex_lock(&supp->mutex);
>                 if (req->in_queue) {
> +                       /* Supplicant has not seen this request yet. */
>                         list_del(&req->link);
>                         req->in_queue =3D false;
> +
> +                       ret =3D TEEC_ERROR_COMMUNICATION;
> +               } else if (req->processed) {
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
> @@ -153,8 +184,8 @@ static struct optee_supp_req  *supp_pop_entry(struct =
optee_supp *supp,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       *id =3D idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
> -       if (*id < 0)
> +       req->id =3D idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
> +       if (req->id < 0)
>                 return ERR_PTR(-ENOMEM);

Since we're now storing the supplicant request ID, wouldn't it make
sense to pre-allocate the ID when allocating the request to avoid this
error case?

>
>         list_del(&req->link);
> @@ -214,7 +245,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *fun=
c, u32 *num_params,
>         struct optee *optee =3D tee_get_drvdata(teedev);
>         struct optee_supp *supp =3D &optee->supp;
>         struct optee_supp_req *req =3D NULL;
> -       int id;
>         size_t num_meta;
>         int rc;
>
> @@ -224,15 +254,48 @@ int optee_supp_recv(struct tee_context *ctx, u32 *f=
unc, u32 *num_params,
>
>         while (true) {
>                 mutex_lock(&supp->mutex);
> -               req =3D supp_pop_entry(supp, *num_params - num_meta, &id)=
;
> -               mutex_unlock(&supp->mutex);
>
> -               if (req) {
> -                       if (IS_ERR(req))
> -                               return PTR_ERR(req);
> -                       break;
> +               req =3D supp_pop_entry(supp, *num_params - num_meta);
> +               if (!req) {
> +                       mutex_unlock(&supp->mutex);
> +                       goto wait_for_request;
> +               }
> +
> +               if (IS_ERR(req)) {
> +                       rc =3D PTR_ERR(req);
> +                       mutex_unlock(&supp->mutex);
> +
> +                       return rc;
>                 }
>
> +               /*
> +                * Process the request while holding the lock, so that
> +                * optee_supp_thrd_req() doesn't pull the request from un=
der us.
> +                */
> +
> +               if (num_meta) {
> +                       /*
> +                        * tee-supplicant support meta parameters ->
> +                        * requests can be processed asynchronously.
> +                        */
> +                       param->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_I=
NOUT |
> +                                     TEE_IOCTL_PARAM_ATTR_META;
> +                       param->u.value.a =3D req->id;
> +                       param->u.value.b =3D 0;
> +                       param->u.value.c =3D 0;
> +               } else {
> +                       supp->req_id =3D req->id;
> +               }
> +
> +               *func =3D req->func;
> +               *num_params =3D req->num_params + num_meta;
> +               memcpy(param + num_meta, req->param,
> +                      sizeof(struct tee_param) * req->num_params);
> +
> +               mutex_unlock(&supp->mutex);
> +               return 0;

Do we really need to move this into the loop? The structure of the
function becomes a bit unusual and harder to read.

> +
> +wait_for_request:
>                 /*
>                  * If we didn't get a request we'll block in
>                  * wait_for_completion() to avoid needless spinning.
> @@ -243,29 +306,10 @@ int optee_supp_recv(struct tee_context *ctx, u32 *f=
unc, u32 *num_params,
>                  */
>                 if (wait_for_completion_interruptible(&supp->reqs_c))
>                         return -ERESTARTSYS;
> -       }
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
> +               /* Check for the next request in the queue. */
>         }
>
> -       *func =3D req->func;
> -       *num_params =3D req->num_params + num_meta;
> -       memcpy(param + num_meta, req->param,
> -              sizeof(struct tee_param) * req->num_params);
> -
>         return 0;
>  }
>
> @@ -297,12 +341,18 @@ static struct optee_supp_req *supp_pop_req(struct o=
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
> +       *num_meta =3D nm;
> +failed_req:
>         idr_remove(&supp->idr, id);
>         supp->req_id =3D -1;
> -       *num_meta =3D nm;
> +
>
>         return req;
>  }
> @@ -328,9 +378,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret,=
 u32 num_params,
>
>         mutex_lock(&supp->mutex);
>         req =3D supp_pop_req(supp, num_params, param, &num_meta);
> -       mutex_unlock(&supp->mutex);
> -
>         if (IS_ERR(req)) {
> +               mutex_unlock(&supp->mutex);

We need a way to tell the difference between an id not found and an id
removed because of a killed requester.
How about storing NULL for revoked requests instead of an err-pointer?

Cheers,
Jens

>                 /* Something is wrong, let supplicant restart. */
>                 return PTR_ERR(req);
>         }
> @@ -355,9 +404,10 @@ int optee_supp_send(struct tee_context *ctx, u32 ret=
, u32 num_params,
>                 }
>         }
>         req->ret =3D ret;
> -
> +       req->processed =3D true;
>         /* Let the requesting thread continue */
>         complete(&req->c);
> +       mutex_unlock(&supp->mutex);
>
>         return 0;
>  }
>
> ---
> base-commit: 3f24e4edcd1b8981c6b448ea2680726dedd87279
> change-id: 20250604-fix-use-after-free-8ff1b5d5d774
>
> Best regards,
> --
> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>
