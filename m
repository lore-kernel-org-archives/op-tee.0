Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23E0E8305A
	for <op-tee@archiver.kernel.org>; Tue,  3 Feb 2026 06:59:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D7F1643726
	for <op-tee@archiver.kernel.org>; Tue,  3 Feb 2026 06:59:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fHoCGPcm;
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A87F0431E5
	for <op-tee@lists.trustedfirmware.org>; Tue,  3 Feb 2026 06:59:28 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6611cab8ca3so3352640eaf.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Feb 2026 22:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770101968; cv=none;
        d=google.com; s=arc-20240605;
        b=IgBOleNV5lRlWMz4aZLtvqEPQLpAqQnbOICmKt+nyjIjyGDwxHPQeqI5XKPmRpgoFn
         tuUzsexT1L9CzpcyUFrSgnBInKMWhoxkipMhTRpcwUpZxUvvqGlh42VGdAWI8l1UJ2at
         YDZdrjZpQ72wVehcFG/JicRfm+J6j771GzWiJCWM/6FEQuPjH1BkxP8+oe59q1xf88Oo
         xtmc/otRMkRG2NCkhiK8as0/nysc9NXOE0qO2++jCizw3ZJkZe12V7Ei3XPjjD7BALiK
         9nnTXxPsRaRf43xTxklEj0VPhFx2u3K4A6CsLlIpu0J58DkZ6I4tT1ghhN2IBFOBnqmQ
         eItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lAyjKnU+7aaJ1xd9n4DKEiUdS8vWgH1sM330Ox4WJ00=;
        fh=CyAZg0+XhdHeLv8HP2QX6DyjVLmllh5Ul65YGImVnJU=;
        b=HuyWGWE5JF0UfqgU8YqxGxBqhavxucB9ZIBPagJEMbdpwpMBloNMV12GzXwVBkpBFA
         O+vKZylc3b+v07HIc7UoZqKZJ73lPecvtX9U1yk0SbEbkbftfVTfXbc/DVS6ThKKUsrU
         1QSj28gAXVNVIZzKKQk0UV0jbKWqDrvaZlr6Esf13J6JPiE/86WYMMb0DjBLJwsNybS0
         AjUDywH7lEMqKR2WbPa067vVL3y9IIVH2q9UV8ar512W2+zUtXizsDAeiEheU4X5EGSM
         bPo8GRtwESebpaWutgAGV4v/h6paxZEzYcgtVRR5c4H6wwDontiloEAs/2/DocaFZ34D
         Y8Jw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770101968; x=1770706768; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAyjKnU+7aaJ1xd9n4DKEiUdS8vWgH1sM330Ox4WJ00=;
        b=fHoCGPcmieN1s/72H8pDGqOpvdfnd7IwqQajesIT/An4S+tS7of7NLvgbpYeNXBEg2
         T3gLvnKu42cw4sQ4NzzKBLCKQyVIRJTubL7r4UgH1jwjSTzXbqXpKHnXM+1BmpeC6rRz
         DhnOnv1w/v6UckZYlAwSvOwScVeUIcKDaRrt3zvf2cbhJKkKsfQirYM2DOA5F27kEiJc
         KODEAGGg2L+47EONNAXXysox/6bHu2trqkgo4C+HYLW2qVYpe4YbtIAgpHP55P+jFn/M
         N8QZuCwHTuyUAvgUSdmYjx4SVpm0bJ7fBT3O4bsm12TpSZzUj4uUB3SMHU7Y6eVTS3rI
         Lx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770101968; x=1770706768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lAyjKnU+7aaJ1xd9n4DKEiUdS8vWgH1sM330Ox4WJ00=;
        b=eJ3+3ErRG4Y64JNWUP8lLZCxztkTIjoP4KS5uYA/3cqLJmxDzlcWVVJKG+Z3vXXv9x
         wqcYMKZnSOYcGs2xezqZ1szmlsefUD3TuJvq7m6mW76LpsJSUKc5mNIbziyljXPSLVL6
         8sF8rB+4vvO6iEyaLDo8jT/ELKTp8jJ+QOnx0SBwfMOso5DjJPZ8KBYJq8pyRdPmJ/T6
         b9fFPWGMcf1GdrVXbhYgU+Fv22zxWNse9eMxjn1MKvt9iZlbgcVAbSGW/Bp5M4aTrbyj
         CjBor7Boe8Hrn+flo7p1wnDtadDMXZfs2mC0VL36jwt4esbANnz4muwxIlfLSbnRMtpB
         dvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwYFEwwnANnyUZvVJSCgfKqvBHZ+0ksvQIYJJ1cE0EYzpo8pjBt3nWLITPVEvS5ZSE8ozpOeE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy5zeTI8YZMbXw/WcBwBLIsDnUFqKbBzwaFKYcCJIbkfg3u0Qed
	QXdgxqiMmJ82Cv8hX/JgZrRfin+988medeAvTMEgjZJeEFcj7bEcxehSZASKxm52b/IyMXJOUN4
	p8hjSYTTOnjstwLNrDAc7V7L8bZ1Tf6H2awvA1hUMQwVw
X-Gm-Gg: AZuq6aIpfKxutetn5WSg9vc7RlXfsaUqJAvwFMJpkq6zhe9Os049dnlTd7HQaBpO7mg
	sg1AvqjJvTNlZhS2dZciuS0WMFS9vW3hKMEE9/BJtKkk3NuvXtnmyirbNkPbDk69SxjUgnXXCCj
	NYHWEChN3/YIhhOL4YXHF4w+4EepMSq7DOnvuyQLRgyfqPes92cypVvay+ZYVJTh+uN/NkAEIdJ
	y+z3WrLHghRPBYn4ma6DUIqNyFaPMUrxE8S80c2LYQXL/E7VFYJJctjchhLeukrIyJsv4AT3X7q
	791e3H9RYcjPKaChgMzloTKDjg==
X-Received: by 2002:a4a:de08:0:b0:663:1239:9ec3 with SMTP id
 006d021491bc7-6631239a26amr4774214eaf.18.1770101967700; Mon, 02 Feb 2026
 22:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20260128-fix-use-after-free-v3-1-b0786670d927@oss.qualcomm.com>
 <CAHUa44E4Htg9zEMY9XtkMsPRJq+13mq6kSd8RUznHTRvXVXKVQ@mail.gmail.com> <55546b03-cbe6-40dd-b794-b2e81efde33a@oss.qualcomm.com>
In-Reply-To: <55546b03-cbe6-40dd-b794-b2e81efde33a@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 3 Feb 2026 07:59:16 +0100
X-Gm-Features: AZwV_QhvDuGw7UvZDogMCoyveNi3imEaiJA2LmSGKXYqbKXg9ynGggk_PMr_ibY
Message-ID: <CAHUa44FfowG=GpgLcq=sp_TqRArJtf0_V-tsJY11HH+FEA6u+w@mail.gmail.com>
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
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.46:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.46:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A87F0431E5
X-Spamd-Bar: -----
Message-ID-Hash: HOVMIULHUPNLSBLYFTTST2F7VYFBOWWH
X-Message-ID-Hash: HOVMIULHUPNLSBLYFTTST2F7VYFBOWWH
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Wu <michael@allwinnertech.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HOVMIULHUPNLSBLYFTTST2F7VYFBOWWH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Tue, Feb 3, 2026 at 3:09=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi Jens,
>
> On 2/2/2026 10:36 PM, Jens Wiklander wrote:
> > Hi Amir,
> >
> > On Thu, Jan 29, 2026 at 4:22=E2=80=AFAM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>
> >> Commit 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop") made the
> >> client wait as killable so it can be interrupted during shutdown or
> >> after a supplicant crash. This changes the original lifetime expectati=
ons:
> >> the client task can now terminate while the supplicant is still proces=
sing
> >> its request.
> >>
> >> If the client exits first it removes the request from its queue and
> >> kfree()s it, while the request ID remains in supp->idr. A subsequent
> >> lookup on the supplicant path then dereferences freed memory, leading =
to
> >> a use-after-free.
> >>
> >> Serialise access to the request with supp->mutex:
> >>
> >>   * Hold supp->mutex in optee_supp_recv() and optee_supp_send() while
> >>     looking up and touching the request.
> >>   * Let optee_supp_thrd_req() notice that the client has terminated an=
d
> >>     signal optee_supp_send() accordingly.
> >>
> >> With these changes the request cannot be freed while the supplicant st=
ill
> >> has a reference, eliminating the race.
> >>
> >> Fixes: 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop")
> >> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >> ---
> >> Changes in v3:
> >> - Introduce processed flag instead of -1 for req->id.
> >> - Update optee_supp_release() as reported by Michael Wu.
> >> - Use mutex instead of guard.
> >> - Link to v2: https://lore.kernel.org/r/20250617-fix-use-after-free-v2=
-1-1fbfafec5917@oss.qualcomm.com
> >>
> >> Changes in v2:
> >> - Replace the static variable with a sentinel value.
> >> - Fix the issue with returning the popped request to the supplicant.
> >> - Link to v1: https://lore.kernel.org/r/20250605-fix-use-after-free-v1=
-1-a70d23bff248@oss.qualcomm.com
> >> ---
> >>  drivers/tee/optee/supp.c | 122 +++++++++++++++++++++++++++++++++-----=
---------
> >>  1 file changed, 86 insertions(+), 36 deletions(-)
> >
> > I had forgotten about this. I'd like to prioritize getting this fixed
> > soon. By the way, how did you test this?
> >
>
> Thanks for the update. I currently don't have access to the setup require=
d to run
> the tests myself. My plan is to finalize the design and implementation, t=
hen
> ask Michael Wu to run his use case. Based on his earlier feedback, the pa=
tch
> appears to be working as expected.
>
> https://lore.kernel.org/all/292653ba-3836-00f1-acd4-a28b1c54388c@allwinne=
rtech.com/

OK

>
> >>
> >> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> >> index d0f397c90242..0ec66008df19 100644
> >> --- a/drivers/tee/optee/supp.c
> >> +++ b/drivers/tee/optee/supp.c
> >> @@ -10,7 +10,11 @@
> >>  struct optee_supp_req {
> >>         struct list_head link;
> >>
> >> +       int id;
> >> +
> >>         bool in_queue;
> >> +       bool processed;
> >> +
> >>         u32 func;
> >>         u32 ret;
> >>         size_t num_params;
> >> @@ -19,6 +23,9 @@ struct optee_supp_req {
> >>         struct completion c;
> >>  };
> >>
> >> +/* It is temporary request used for invalid pending request in supp->=
idr. */
> >> +#define INVALID_REQ_PTR ((struct optee_supp_req *)ERR_PTR(-ENOENT))
> >> +
> >>  void optee_supp_init(struct optee_supp *supp)
> >>  {
> >>         memset(supp, 0, sizeof(*supp));
> >> @@ -46,6 +53,10 @@ void optee_supp_release(struct optee_supp *supp)
> >>         /* Abort all request retrieved by supplicant */
> >>         idr_for_each_entry(&supp->idr, req, id) {
> >>                 idr_remove(&supp->idr, id);
> >> +               /* Skip if request was already marked invalid */
> >> +               if (IS_ERR(req))
> >> +                       continue;
> >> +
> >>                 req->ret =3D TEEC_ERROR_COMMUNICATION;
> >>                 complete(&req->c);
> >>         }
> >> @@ -102,6 +113,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u=
32 func, size_t num_params,
> >>         mutex_lock(&supp->mutex);
> >>         list_add_tail(&req->link, &supp->reqs);
> >>         req->in_queue =3D true;
> >> +       req->processed =3D false;
> >>         mutex_unlock(&supp->mutex);
> >>
> >>         /* Tell an eventual waiter there's a new request */
> >> @@ -117,21 +129,40 @@ u32 optee_supp_thrd_req(struct tee_context *ctx,=
 u32 func, size_t num_params,
> >>         if (wait_for_completion_killable(&req->c)) {
> >>                 mutex_lock(&supp->mutex);
> >>                 if (req->in_queue) {
> >> +                       /* Supplicant has not seen this request yet. *=
/
> >>                         list_del(&req->link);
> >>                         req->in_queue =3D false;
> >> +
> >> +                       ret =3D TEEC_ERROR_COMMUNICATION;
> >> +               } else if (req->processed) {
> >> +                       /*
> >> +                        * Supplicant has processed this request. Igno=
re the
> >> +                        * kill signal for now and submit the result.
> >> +                        */
> >> +                       ret =3D req->ret;
> >> +               } else {
> >> +                       /*
> >> +                        * Supplicant is in the middle of processing t=
his
> >> +                        * request. Replace req with INVALID_REQ_PTR s=
o that
> >> +                        * the ID remains busy, causing optee_supp_sen=
d() to
> >> +                        * fail on the next call to supp_pop_req() wit=
h this ID.
> >> +                        */
> >> +                       idr_replace(&supp->idr, INVALID_REQ_PTR, req->=
id);
> >> +                       ret =3D TEEC_ERROR_COMMUNICATION;
> >>                 }
> >> +
> >>                 mutex_unlock(&supp->mutex);
> >> -               req->ret =3D TEEC_ERROR_COMMUNICATION;
> >> +       } else {
> >> +               ret =3D req->ret;
> >>         }
> >>
> >> -       ret =3D req->ret;
> >>         kfree(req);
> >>
> >>         return ret;
> >>  }
> >>
> >>  static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp=
,
> >> -                                             int num_params, int *id)
> >> +                                             int num_params)
> >>  {
> >>         struct optee_supp_req *req;
> >>
> >> @@ -153,8 +184,8 @@ static struct optee_supp_req  *supp_pop_entry(stru=
ct optee_supp *supp,
> >>                 return ERR_PTR(-EINVAL);
> >>         }
> >>
> >> -       *id =3D idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
> >> -       if (*id < 0)
> >> +       req->id =3D idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
> >> +       if (req->id < 0)
> >>                 return ERR_PTR(-ENOMEM);
> >
> > Since we're now storing the supplicant request ID, wouldn't it make
> > sense to pre-allocate the ID when allocating the request to avoid this
> > error case?
> >
>
> True, but allocating the ID at this stage has one advantage.
> If an ID is not available, the request can remain on the request list,
> allowing the supplicant to retry later when resources become available.
> If ID allocation fails during request creation, I have no choice but
> to drop the request and report an error to optee.

We're allocating in the range 1..INT_MAX, and not more than a handful
are expected to be active at a time. If we run out of IDs, we have
bigger problems.

>
> >>
> >>         list_del(&req->link);
> >> @@ -214,7 +245,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *=
func, u32 *num_params,
> >>         struct optee *optee =3D tee_get_drvdata(teedev);
> >>         struct optee_supp *supp =3D &optee->supp;
> >>         struct optee_supp_req *req =3D NULL;
> >> -       int id;
> >>         size_t num_meta;
> >>         int rc;
> >>
> >> @@ -224,15 +254,48 @@ int optee_supp_recv(struct tee_context *ctx, u32=
 *func, u32 *num_params,
> >>
> >>         while (true) {
> >>                 mutex_lock(&supp->mutex);
> >> -               req =3D supp_pop_entry(supp, *num_params - num_meta, &=
id);
> >> -               mutex_unlock(&supp->mutex);
> >>
> >> -               if (req) {
> >> -                       if (IS_ERR(req))
> >> -                               return PTR_ERR(req);
> >> -                       break;
> >> +               req =3D supp_pop_entry(supp, *num_params - num_meta);
> >> +               if (!req) {
> >> +                       mutex_unlock(&supp->mutex);
> >> +                       goto wait_for_request;
> >> +               }
> >> +
> >> +               if (IS_ERR(req)) {
> >> +                       rc =3D PTR_ERR(req);
> >> +                       mutex_unlock(&supp->mutex);
> >> +
> >> +                       return rc;
> >>                 }
> >>
> >> +               /*
> >> +                * Process the request while holding the lock, so that
> >> +                * optee_supp_thrd_req() doesn't pull the request from=
 under us.
> >> +                */
> >> +
> >> +               if (num_meta) {
> >> +                       /*
> >> +                        * tee-supplicant support meta parameters ->
> >> +                        * requests can be processed asynchronously.
> >> +                        */
> >> +                       param->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALU=
E_INOUT |
> >> +                                     TEE_IOCTL_PARAM_ATTR_META;
> >> +                       param->u.value.a =3D req->id;
> >> +                       param->u.value.b =3D 0;
> >> +                       param->u.value.c =3D 0;
> >> +               } else {
> >> +                       supp->req_id =3D req->id;
> >> +               }
> >> +
> >> +               *func =3D req->func;
> >> +               *num_params =3D req->num_params + num_meta;
> >> +               memcpy(param + num_meta, req->param,
> >> +                      sizeof(struct tee_param) * req->num_params);
> >> +
> >> +               mutex_unlock(&supp->mutex);
> >> +               return 0;
> >
> > Do we really need to move this into the loop? The structure of the
> > function becomes a bit unusual and harder to read.
> >
>
> Ack. I'll reorganize this function.
>
> >> +
> >> +wait_for_request:
> >>                 /*
> >>                  * If we didn't get a request we'll block in
> >>                  * wait_for_completion() to avoid needless spinning.
> >> @@ -243,29 +306,10 @@ int optee_supp_recv(struct tee_context *ctx, u32=
 *func, u32 *num_params,
> >>                  */
> >>                 if (wait_for_completion_interruptible(&supp->reqs_c))
> >>                         return -ERESTARTSYS;
> >> -       }
> >>
> >> -       if (num_meta) {
> >> -               /*
> >> -                * tee-supplicant support meta parameters -> requsts c=
an be
> >> -                * processed asynchronously.
> >> -                */
> >> -               param->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT =
|
> >> -                             TEE_IOCTL_PARAM_ATTR_META;
> >> -               param->u.value.a =3D id;
> >> -               param->u.value.b =3D 0;
> >> -               param->u.value.c =3D 0;
> >> -       } else {
> >> -               mutex_lock(&supp->mutex);
> >> -               supp->req_id =3D id;
> >> -               mutex_unlock(&supp->mutex);
> >> +               /* Check for the next request in the queue. */
> >>         }
> >>
> >> -       *func =3D req->func;
> >> -       *num_params =3D req->num_params + num_meta;
> >> -       memcpy(param + num_meta, req->param,
> >> -              sizeof(struct tee_param) * req->num_params);
> >> -
> >>         return 0;
> >>  }
> >>
> >> @@ -297,12 +341,18 @@ static struct optee_supp_req *supp_pop_req(struc=
t optee_supp *supp,
> >>         if (!req)
> >>                 return ERR_PTR(-ENOENT);
> >>
> >> +       /* optee_supp_thrd_req() already returned to optee. */
> >> +       if (IS_ERR(req))
> >> +               goto failed_req;
> >> +
> >>         if ((num_params - nm) !=3D req->num_params)
> >>                 return ERR_PTR(-EINVAL);
> >>
> >> +       *num_meta =3D nm;
> >> +failed_req:
> >>         idr_remove(&supp->idr, id);
> >>         supp->req_id =3D -1;
> >> -       *num_meta =3D nm;
> >> +
> >>
> >>         return req;
> >>  }
> >> @@ -328,9 +378,8 @@ int optee_supp_send(struct tee_context *ctx, u32 r=
et, u32 num_params,
> >>
> >>         mutex_lock(&supp->mutex);
> >>         req =3D supp_pop_req(supp, num_params, param, &num_meta);
> >> -       mutex_unlock(&supp->mutex);
> >> -
> >>         if (IS_ERR(req)) {
> >> +               mutex_unlock(&supp->mutex);
> >
> > We need a way to tell the difference between an id not found and an id
> > removed because of a killed requester.
> > How about storing NULL for revoked requests instead of an err-pointer?
> >
>
> Not sure I'm following correctly. Are you expecting supp_pop_req()
> to return NULL instead of an err-pointer when a request has been revoked?

I was looking at it again, and storing an err-pointer as you do in
this patch has the advantage that we can tell whether the ID has been
revoked or was never supplied. In the latter case, it suggests that
the supplicant is doing something wrong and might as well restart in
an attempt to recover. So, please keep using an err-pointer as a
placeholder, but we must be able to distinguish a revoked request from
other errors to make sure that the supplicant doesn't restart due to a
revoked request.

Cheers,
Jens

>
> Best Rearads,
> Amir
>
> > Cheers,
> > Jens
> >
> >>                 /* Something is wrong, let supplicant restart. */
> >>                 return PTR_ERR(req);
> >>         }
> >> @@ -355,9 +404,10 @@ int optee_supp_send(struct tee_context *ctx, u32 =
ret, u32 num_params,
> >>                 }
> >>         }
> >>         req->ret =3D ret;
> >> -
> >> +       req->processed =3D true;
> >>         /* Let the requesting thread continue */
> >>         complete(&req->c);
> >> +       mutex_unlock(&supp->mutex);
> >>
> >>         return 0;
> >>  }
> >>
> >> ---
> >> base-commit: 3f24e4edcd1b8981c6b448ea2680726dedd87279
> >> change-id: 20250604-fix-use-after-free-8ff1b5d5d774
> >>
> >> Best regards,
> >> --
> >> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >>
>
