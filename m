Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3936BE83EE5
	for <op-tee@archiver.kernel.org>; Wed,  4 Feb 2026 07:47:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6B196436FF
	for <op-tee@archiver.kernel.org>; Wed,  4 Feb 2026 07:47:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=we+Hvck5;
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 78128431D1
	for <op-tee@lists.trustedfirmware.org>; Wed,  4 Feb 2026 07:46:56 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4042905015cso4179182fac.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 03 Feb 2026 23:46:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770191216; cv=none;
        d=google.com; s=arc-20240605;
        b=emoVlxhra3cjNJSJASNj8UKLbM0tVM3gnGOTRolMPUxWTDkVD7ghAKzcmNmJMz/ynV
         28SjBL2KCXPcJDDSEZC+Ms1cuLT2KPp35NJivir83bfGONtD78R16gaOeUl12c1tFH0P
         b7GxhMFWFX3kferzJE2vcJZLdwX2liOD0JK9ZjsY7bjeKhoFzTZp6P6+5nkoORHf2bFg
         kQ0OUv7y8mbGZyQSN2/zckgbMmRe+cnd6j4gWp6W/A7AQ02H6NAo7kRvS2LS8OUWraJS
         SAiGdX499v3KcOfykt+Z7kT1AlXrc1kDAfIcJdy5ne/n9lyazS/z/DLjhTnRVo3vOihs
         Y4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/YDYZbWDYfbkMPe16NzUrDn5o+gtsdv1+XemSxwq3k=;
        fh=8HiFQd6XCed5zvot317Hht1DzQaMeMsL7PElrXxrrbE=;
        b=A5878l10TCvTyBWWiDBzsbuL4Jb2SprfmD1t8tIbnlhYhH9WgK/9oIsrva8IbzuupL
         DczKxBu7KWCgA22J0zP0FNw1Svad7aKHMF6ZbLNYIL3dNyGTXQqav/gUPAkZ+xwTK20P
         n5dvBen4iQY0jfApCxASwLzXw5e0/6Wsgu65D4Mv6pK7PDs5emFn++Cgh1X2mfoR5MyJ
         vnGwRRyP9U/f7T2DkQmFsmeqI7g8AwURJzMdsE8gDI3BNuCVn+jKLkmA28L7tGsGq1hZ
         E5LV7EORJY6wdcvnlnuWgskXNjsPityFIGvJ2vDW0u2EnxBOlHqWwb+fVw1kLnKzk4If
         lmAw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770191216; x=1770796016; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/YDYZbWDYfbkMPe16NzUrDn5o+gtsdv1+XemSxwq3k=;
        b=we+Hvck5hQYq/XniUaZK93HNRoOaCKAtE5wOwcbOwHggNjdJufwXj9p5uiyXCDh09J
         v5/5xqUu+pzbBJRX19AnQqDYc3OGMwbe9XWKp8/EHSr0KuyfBj3+Aw4IXLRuR6t60Uo4
         M6QG5YXOMTz9J/e293ugs0GkJMq3A58ah9XipYpLrnjeEWiL9ola88iSZv1oidLpJA+K
         0vOt43xjQqh23yNLsgiTDnxmw5I4peBebrwJxBO3vcpsF+7AZnqmFOjLziiEMkWoYgFx
         wl2vweNhoTVAfTrIOXqL8qGH39eJ2Dq4cSPEuDRBniTezpP17RW7e+j4xxTEnwDSr7EI
         9A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191216; x=1770796016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/YDYZbWDYfbkMPe16NzUrDn5o+gtsdv1+XemSxwq3k=;
        b=mHzlC28WAbKNIYHPcg6EWcVH3eYtlFrQlOugf8y80WtHW71xFEW6bKRE4zVlYLg8En
         nPHELHerjBWxasYvqhcatrDO2kXRMab9AimvzQsOMxNjOr/UCbe4WzwpkGy5BQjn5MhW
         Ymvg/lKk6PzkU97hjjQ3WbIQIUkeMMyHzZLpUL+idxVpgjjx2z5VAiBtQyC08ZK84x4L
         e/95k2RbNW7zHYn+IuiJOc8kTRsJw/HQFcYf/UUgyOojFgL52MNNWQ6Q2AT0RAM42O1I
         ARnUXx3ddBvuX4xZFdJ2kEpO/Bsh5HyPYFMQ9bCLDEeLiMi15OS1Ef1aKmfOh+uqMcqo
         zJog==
X-Forwarded-Encrypted: i=1; AJvYcCWmj6ZKn48GBMNVdlNfDxIAXzUpwwNMlQ66YSwo1aK+v+l6Qfq8DLFKq5vnBXcB5CIUu+h2pbQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw2ghc491MVCIfgS9GkoK/l0gaXoxTpvXDRgN4YzOrOpMaw3itK
	K9S/O5UeZ13MvTWB6JDEQmsGQ4lnm8L1QV4eGs1WImQJ/nFsElhOGa6DRycPtUNbXI9IokO8flV
	6/j/+kF/lhz4v7UBQyjlzhievZnZMNExsG2uDMiwwnROD
X-Gm-Gg: AZuq6aLcTBrGstiHUkvsMKIhQhGEsog3iZA9xg+E5aCYFeGAFDGEZuqGSyE3nLT+yID
	lxJCHGnuUaKsMYNsu2iNeKRjYXZs9MN0bTHGbAP4z8/HD6KY++YG+qNKMJFu173te0uM8D4MLHh
	bKjndhEz9/E5e7mamU0tdsKg7R6r1l3WF3pxFraxQ5v9s+J81kO0ei/1bBR0wRzpNTJQwQgOnKw
	EynflcRIWcaLnvrtwkalUqnLyBcCLXUdn2hQZgL6NZWCNllik/vPcJbN9ilq3aY0xSASh6ZUeAA
	9dmFvZSHYiVrYRzzkzx+PzBF1g==
X-Received: by 2002:a05:6820:4a88:b0:663:f65:1c84 with SMTP id
 006d021491bc7-66a2297a93cmr958593eaf.54.1770191215401; Tue, 03 Feb 2026
 23:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20260128-fix-use-after-free-v3-1-b0786670d927@oss.qualcomm.com>
 <CAHUa44E4Htg9zEMY9XtkMsPRJq+13mq6kSd8RUznHTRvXVXKVQ@mail.gmail.com>
 <55546b03-cbe6-40dd-b794-b2e81efde33a@oss.qualcomm.com> <CAHUa44FfowG=GpgLcq=sp_TqRArJtf0_V-tsJY11HH+FEA6u+w@mail.gmail.com>
 <4c9e4f5f-e0f3-42aa-852f-064f4024af26@oss.qualcomm.com>
In-Reply-To: <4c9e4f5f-e0f3-42aa-852f-064f4024af26@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 4 Feb 2026 08:46:43 +0100
X-Gm-Features: AZwV_QiocpsnKw571g6PMgsLe6qcICiXNLEVB7isDxwzWLoqL0USj8Yxp4EGipw
Message-ID: <CAHUa44EhaztJ+5piu0c-HQbqZFX47uLPJ+VDRp=Bp6BMeeARAQ@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.53:from];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.53:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 78128431D1
X-Spamd-Bar: -----
Message-ID-Hash: LI4T2Q2XR2DQUWP6AKFCORG65MDDQ535
X-Message-ID-Hash: LI4T2Q2XR2DQUWP6AKFCORG65MDDQ535
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Wu <michael@allwinnertech.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LI4T2Q2XR2DQUWP6AKFCORG65MDDQ535/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Tue, Feb 3, 2026 at 11:56=E2=80=AFPM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi Jens,
>
> On 2/3/2026 5:59 PM, Jens Wiklander wrote:
> > Hi,
> >
> > On Tue, Feb 3, 2026 at 3:09=E2=80=AFAM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>
> >> Hi Jens,
> >>
> >> On 2/2/2026 10:36 PM, Jens Wiklander wrote:
> >>> Hi Amir,
> >>>
> >>> On Thu, Jan 29, 2026 at 4:22=E2=80=AFAM Amirreza Zarrabi
> >>> <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>>>
> >>>> Commit 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop") made th=
e
> >>>> client wait as killable so it can be interrupted during shutdown or
> >>>> after a supplicant crash. This changes the original lifetime expecta=
tions:
> >>>> the client task can now terminate while the supplicant is still proc=
essing
> >>>> its request.
> >>>>
> >>>> If the client exits first it removes the request from its queue and
> >>>> kfree()s it, while the request ID remains in supp->idr. A subsequent
> >>>> lookup on the supplicant path then dereferences freed memory, leadin=
g to
> >>>> a use-after-free.
> >>>>
> >>>> Serialise access to the request with supp->mutex:
> >>>>
> >>>>   * Hold supp->mutex in optee_supp_recv() and optee_supp_send() whil=
e
> >>>>     looking up and touching the request.
> >>>>   * Let optee_supp_thrd_req() notice that the client has terminated =
and
> >>>>     signal optee_supp_send() accordingly.
> >>>>
> >>>> With these changes the request cannot be freed while the supplicant =
still
> >>>> has a reference, eliminating the race.
> >>>>
> >>>> Fixes: 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop")
> >>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >>>> ---
> >>>> Changes in v3:
> >>>> - Introduce processed flag instead of -1 for req->id.
> >>>> - Update optee_supp_release() as reported by Michael Wu.
> >>>> - Use mutex instead of guard.
> >>>> - Link to v2: https://lore.kernel.org/r/20250617-fix-use-after-free-=
v2-1-1fbfafec5917@oss.qualcomm.com
> >>>>
> >>>> Changes in v2:
> >>>> - Replace the static variable with a sentinel value.
> >>>> - Fix the issue with returning the popped request to the supplicant.
> >>>> - Link to v1: https://lore.kernel.org/r/20250605-fix-use-after-free-=
v1-1-a70d23bff248@oss.qualcomm.com
> >>>> ---
> >>>>  drivers/tee/optee/supp.c | 122 +++++++++++++++++++++++++++++++++---=
-----------
> >>>>  1 file changed, 86 insertions(+), 36 deletions(-)
> >>>
> >>> I had forgotten about this. I'd like to prioritize getting this fixed
> >>> soon. By the way, how did you test this?
> >>>
> >>
> >> Thanks for the update. I currently don't have access to the setup requ=
ired to run
> >> the tests myself. My plan is to finalize the design and implementation=
, then
> >> ask Michael Wu to run his use case. Based on his earlier feedback, the=
 patch
> >> appears to be working as expected.
> >>
> >> https://lore.kernel.org/all/292653ba-3836-00f1-acd4-a28b1c54388c@allwi=
nnertech.com/
> >
> > OK
> >
> >>
> >>>>
> >>>> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> >>>> index d0f397c90242..0ec66008df19 100644
> >>>> --- a/drivers/tee/optee/supp.c
> >>>> +++ b/drivers/tee/optee/supp.c
> >>>> @@ -10,7 +10,11 @@
> >>>>  struct optee_supp_req {
> >>>>         struct list_head link;
> >>>>
> >>>> +       int id;
> >>>> +
> >>>>         bool in_queue;
> >>>> +       bool processed;
> >>>> +
> >>>>         u32 func;
> >>>>         u32 ret;
> >>>>         size_t num_params;
> >>>> @@ -19,6 +23,9 @@ struct optee_supp_req {
> >>>>         struct completion c;
> >>>>  };
> >>>>
> >>>> +/* It is temporary request used for invalid pending request in supp=
->idr. */
> >>>> +#define INVALID_REQ_PTR ((struct optee_supp_req *)ERR_PTR(-ENOENT))
> >>>> +
> >>>>  void optee_supp_init(struct optee_supp *supp)
> >>>>  {
> >>>>         memset(supp, 0, sizeof(*supp));
> >>>> @@ -46,6 +53,10 @@ void optee_supp_release(struct optee_supp *supp)
> >>>>         /* Abort all request retrieved by supplicant */
> >>>>         idr_for_each_entry(&supp->idr, req, id) {
> >>>>                 idr_remove(&supp->idr, id);
> >>>> +               /* Skip if request was already marked invalid */
> >>>> +               if (IS_ERR(req))
> >>>> +                       continue;
> >>>> +
> >>>>                 req->ret =3D TEEC_ERROR_COMMUNICATION;
> >>>>                 complete(&req->c);
> >>>>         }
> >>>> @@ -102,6 +113,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx,=
 u32 func, size_t num_params,
> >>>>         mutex_lock(&supp->mutex);
> >>>>         list_add_tail(&req->link, &supp->reqs);
> >>>>         req->in_queue =3D true;
> >>>> +       req->processed =3D false;
> >>>>         mutex_unlock(&supp->mutex);
> >>>>
> >>>>         /* Tell an eventual waiter there's a new request */
> >>>> @@ -117,21 +129,40 @@ u32 optee_supp_thrd_req(struct tee_context *ct=
x, u32 func, size_t num_params,
> >>>>         if (wait_for_completion_killable(&req->c)) {
> >>>>                 mutex_lock(&supp->mutex);
> >>>>                 if (req->in_queue) {
> >>>> +                       /* Supplicant has not seen this request yet.=
 */
> >>>>                         list_del(&req->link);
> >>>>                         req->in_queue =3D false;
> >>>> +
> >>>> +                       ret =3D TEEC_ERROR_COMMUNICATION;
> >>>> +               } else if (req->processed) {
> >>>> +                       /*
> >>>> +                        * Supplicant has processed this request. Ig=
nore the
> >>>> +                        * kill signal for now and submit the result=
.
> >>>> +                        */
> >>>> +                       ret =3D req->ret;
> >>>> +               } else {
> >>>> +                       /*
> >>>> +                        * Supplicant is in the middle of processing=
 this
> >>>> +                        * request. Replace req with INVALID_REQ_PTR=
 so that
> >>>> +                        * the ID remains busy, causing optee_supp_s=
end() to
> >>>> +                        * fail on the next call to supp_pop_req() w=
ith this ID.
> >>>> +                        */
> >>>> +                       idr_replace(&supp->idr, INVALID_REQ_PTR, req=
->id);
> >>>> +                       ret =3D TEEC_ERROR_COMMUNICATION;
> >>>>                 }
> >>>> +
> >>>>                 mutex_unlock(&supp->mutex);
> >>>> -               req->ret =3D TEEC_ERROR_COMMUNICATION;
> >>>> +       } else {
> >>>> +               ret =3D req->ret;
> >>>>         }
> >>>>
> >>>> -       ret =3D req->ret;
> >>>>         kfree(req);
> >>>>
> >>>>         return ret;
> >>>>  }
> >>>>
> >>>>  static struct optee_supp_req  *supp_pop_entry(struct optee_supp *su=
pp,
> >>>> -                                             int num_params, int *i=
d)
> >>>> +                                             int num_params)
> >>>>  {
> >>>>         struct optee_supp_req *req;
> >>>>
> >>>> @@ -153,8 +184,8 @@ static struct optee_supp_req  *supp_pop_entry(st=
ruct optee_supp *supp,
> >>>>                 return ERR_PTR(-EINVAL);
> >>>>         }
> >>>>
> >>>> -       *id =3D idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
> >>>> -       if (*id < 0)
> >>>> +       req->id =3D idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
> >>>> +       if (req->id < 0)
> >>>>                 return ERR_PTR(-ENOMEM);
> >>>
> >>> Since we're now storing the supplicant request ID, wouldn't it make
> >>> sense to pre-allocate the ID when allocating the request to avoid thi=
s
> >>> error case?
> >>>
> >>
> >> True, but allocating the ID at this stage has one advantage.
> >> If an ID is not available, the request can remain on the request list,
> >> allowing the supplicant to retry later when resources become available=
.
> >> If ID allocation fails during request creation, I have no choice but
> >> to drop the request and report an error to optee.
> >
> > We're allocating in the range 1..INT_MAX, and not more than a handful
> > are expected to be active at a time. If we run out of IDs, we have
> > bigger problems.
> >
>
> Ack.
>
> >>
> >>>>
> >>>>         list_del(&req->link);
> >>>> @@ -214,7 +245,6 @@ int optee_supp_recv(struct tee_context *ctx, u32=
 *func, u32 *num_params,
> >>>>         struct optee *optee =3D tee_get_drvdata(teedev);
> >>>>         struct optee_supp *supp =3D &optee->supp;
> >>>>         struct optee_supp_req *req =3D NULL;
> >>>> -       int id;
> >>>>         size_t num_meta;
> >>>>         int rc;
> >>>>
> >>>> @@ -224,15 +254,48 @@ int optee_supp_recv(struct tee_context *ctx, u=
32 *func, u32 *num_params,
> >>>>
> >>>>         while (true) {
> >>>>                 mutex_lock(&supp->mutex);
> >>>> -               req =3D supp_pop_entry(supp, *num_params - num_meta,=
 &id);
> >>>> -               mutex_unlock(&supp->mutex);
> >>>>
> >>>> -               if (req) {
> >>>> -                       if (IS_ERR(req))
> >>>> -                               return PTR_ERR(req);
> >>>> -                       break;
> >>>> +               req =3D supp_pop_entry(supp, *num_params - num_meta)=
;
> >>>> +               if (!req) {
> >>>> +                       mutex_unlock(&supp->mutex);
> >>>> +                       goto wait_for_request;
> >>>> +               }
> >>>> +
> >>>> +               if (IS_ERR(req)) {
> >>>> +                       rc =3D PTR_ERR(req);
> >>>> +                       mutex_unlock(&supp->mutex);
> >>>> +
> >>>> +                       return rc;
> >>>>                 }
> >>>>
> >>>> +               /*
> >>>> +                * Process the request while holding the lock, so th=
at
> >>>> +                * optee_supp_thrd_req() doesn't pull the request fr=
om under us.
> >>>> +                */
> >>>> +
> >>>> +               if (num_meta) {
> >>>> +                       /*
> >>>> +                        * tee-supplicant support meta parameters ->
> >>>> +                        * requests can be processed asynchronously.
> >>>> +                        */
> >>>> +                       param->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VA=
LUE_INOUT |
> >>>> +                                     TEE_IOCTL_PARAM_ATTR_META;
> >>>> +                       param->u.value.a =3D req->id;
> >>>> +                       param->u.value.b =3D 0;
> >>>> +                       param->u.value.c =3D 0;
> >>>> +               } else {
> >>>> +                       supp->req_id =3D req->id;
> >>>> +               }
> >>>> +
> >>>> +               *func =3D req->func;
> >>>> +               *num_params =3D req->num_params + num_meta;
> >>>> +               memcpy(param + num_meta, req->param,
> >>>> +                      sizeof(struct tee_param) * req->num_params);
> >>>> +
> >>>> +               mutex_unlock(&supp->mutex);
> >>>> +               return 0;
> >>>
> >>> Do we really need to move this into the loop? The structure of the
> >>> function becomes a bit unusual and harder to read.
> >>>
> >>
> >> Ack. I'll reorganize this function.
> >>
> >>>> +
> >>>> +wait_for_request:
> >>>>                 /*
> >>>>                  * If we didn't get a request we'll block in
> >>>>                  * wait_for_completion() to avoid needless spinning.
> >>>> @@ -243,29 +306,10 @@ int optee_supp_recv(struct tee_context *ctx, u=
32 *func, u32 *num_params,
> >>>>                  */
> >>>>                 if (wait_for_completion_interruptible(&supp->reqs_c)=
)
> >>>>                         return -ERESTARTSYS;
> >>>> -       }
> >>>>
> >>>> -       if (num_meta) {
> >>>> -               /*
> >>>> -                * tee-supplicant support meta parameters -> requsts=
 can be
> >>>> -                * processed asynchronously.
> >>>> -                */
> >>>> -               param->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOU=
T |
> >>>> -                             TEE_IOCTL_PARAM_ATTR_META;
> >>>> -               param->u.value.a =3D id;
> >>>> -               param->u.value.b =3D 0;
> >>>> -               param->u.value.c =3D 0;
> >>>> -       } else {
> >>>> -               mutex_lock(&supp->mutex);
> >>>> -               supp->req_id =3D id;
> >>>> -               mutex_unlock(&supp->mutex);
> >>>> +               /* Check for the next request in the queue. */
> >>>>         }
> >>>>
> >>>> -       *func =3D req->func;
> >>>> -       *num_params =3D req->num_params + num_meta;
> >>>> -       memcpy(param + num_meta, req->param,
> >>>> -              sizeof(struct tee_param) * req->num_params);
> >>>> -
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> @@ -297,12 +341,18 @@ static struct optee_supp_req *supp_pop_req(str=
uct optee_supp *supp,
> >>>>         if (!req)
> >>>>                 return ERR_PTR(-ENOENT);
> >>>>
> >>>> +       /* optee_supp_thrd_req() already returned to optee. */
> >>>> +       if (IS_ERR(req))
> >>>> +               goto failed_req;
> >>>> +
> >>>>         if ((num_params - nm) !=3D req->num_params)
> >>>>                 return ERR_PTR(-EINVAL);
> >>>>
> >>>> +       *num_meta =3D nm;
> >>>> +failed_req:
> >>>>         idr_remove(&supp->idr, id);
> >>>>         supp->req_id =3D -1;
> >>>> -       *num_meta =3D nm;
> >>>> +
> >>>>
> >>>>         return req;
> >>>>  }
> >>>> @@ -328,9 +378,8 @@ int optee_supp_send(struct tee_context *ctx, u32=
 ret, u32 num_params,
> >>>>
> >>>>         mutex_lock(&supp->mutex);
> >>>>         req =3D supp_pop_req(supp, num_params, param, &num_meta);
> >>>> -       mutex_unlock(&supp->mutex);
> >>>> -
> >>>>         if (IS_ERR(req)) {
> >>>> +               mutex_unlock(&supp->mutex);
> >>>
> >>> We need a way to tell the difference between an id not found and an i=
d
> >>> removed because of a killed requester.
> >>> How about storing NULL for revoked requests instead of an err-pointer=
?
> >>>
> >>
> >> Not sure I'm following correctly. Are you expecting supp_pop_req()
> >> to return NULL instead of an err-pointer when a request has been revok=
ed?
> >
> > I was looking at it again, and storing an err-pointer as you do in
> > this patch has the advantage that we can tell whether the ID has been
> > revoked or was never supplied. In the latter case, it suggests that
> > the supplicant is doing something wrong and might as well restart in
> > an attempt to recover. So, please keep using an err-pointer as a
> > placeholder, but we must be able to distinguish a revoked request from
> > other errors to make sure that the supplicant doesn't restart due to a
> > revoked request.
> >
>
> Understood. What if I switch the stored err-pointer to EBADF instead of E=
NOENT
> (which seems more natural), so it doesn't overlap with other supp_pop_req=
() error
> codes and the supplicant can reliably detect it.

Any error returned by TEE_IOC_SUPPL_SEND (or TEE_IOC_SUPPL_RECV) will
cause the tee-supplicant to exit. Even if we update it to ignore
certain codes, we must also consider the installed base. There's not
much tee-supplicant could do with this error, except logging it. But I
don't think that is very useful either. Unless the tee-supplicant does
anything wrong or if the device isn't working any longer, we shouldn't
return an error.

Cheers,
Jens

>
> Best Regards,
> Amir
>
> > Cheers,
> > Jens
> >
> >>
> >> Best Rearads,
> >> Amir
> >>
> >>> Cheers,
> >>> Jens
> >>>
> >>>>                 /* Something is wrong, let supplicant restart. */
> >>>>                 return PTR_ERR(req);
> >>>>         }
> >>>> @@ -355,9 +404,10 @@ int optee_supp_send(struct tee_context *ctx, u3=
2 ret, u32 num_params,
> >>>>                 }
> >>>>         }
> >>>>         req->ret =3D ret;
> >>>> -
> >>>> +       req->processed =3D true;
> >>>>         /* Let the requesting thread continue */
> >>>>         complete(&req->c);
> >>>> +       mutex_unlock(&supp->mutex);
> >>>>
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> ---
> >>>> base-commit: 3f24e4edcd1b8981c6b448ea2680726dedd87279
> >>>> change-id: 20250604-fix-use-after-free-8ff1b5d5d774
> >>>>
> >>>> Best regards,
> >>>> --
> >>>> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >>>>
> >>
>
