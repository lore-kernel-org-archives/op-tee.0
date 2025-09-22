Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E26CAC5A7
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 06:39:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AE5EE43103
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 06:39:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j5Nyx5hz;
	dkim-atps=neutral
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 058CC3F086
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Sep 2025 06:39:22 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74381e2079fso4165591a34.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 21 Sep 2025 23:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758523161; x=1759127961; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3BWzW2J9Z3ytb9T+PalkAt1wTD7VsNe5O2iBqLv+TE=;
        b=j5Nyx5hzQv9stX9YZqFfX5191P+DisywQGJ4qgKx2DIku68W/mZcS3xWbKImbiVoL0
         XTKJilna862S/1mlfrvG0AAT7qG58piOpye5OUg3VV9j6X55Vpme6cENhIXOwK6AlnEp
         prbDwChXPZwjoBhevnVN0ifOq0gMbmHXVkxLhifJzL4BqK1k+yf2AGOu7tNnHsqCLYYK
         q5aVVEsYauHWKkmsK+gFeV9r9hJG2eqAAo093xjKD0KTanxhchJYU2LPOnrlfgUOhpFJ
         c970p79b2jHgtq89i8k6ZFoLHZIrqU5MMagGHB5DKD8gdOJufe0LQ3rOeBVhiqT9o4yH
         Wueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758523161; x=1759127961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3BWzW2J9Z3ytb9T+PalkAt1wTD7VsNe5O2iBqLv+TE=;
        b=IXhEB8km8Y1i0aseGHpaLVrf6fla2cdSxKZfgewAjI5QrbUSqXu7Jk1LjmwAqL+I3/
         pK2GTILqa0ZRvTQWvGmYji8XB5F7GttJdoDWE1FN3q1jLSX5B5RKP481ux3clYtBzuxm
         oWGiT79/rGxVSoBA7ygBnif8MyzHD2HFbOhtE8PrkSdbfr1MNbaZLuV5V80DcP9lKuuH
         ntg38wOKpEW49RernMAFNBoeTN2FhogdUkpIYkC4cfVdUXsoXpOS1VlPfsheq4nHVwKH
         2wRRXlnpHoKGnizLtCJeQJ9YUD4IJNWxBN953DcYcoZ+eZtCYS2OP6lCx85jvXxkxX69
         xVbw==
X-Forwarded-Encrypted: i=1; AJvYcCUxI7uBnunM42rNRpwH0avzy/kpT818QYgWC9CvLYKxVyRdopIvrDS40r/18fEMnXGdBgVT3j8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzhrMZkcoGJXlfQbmkcpl8eydp3Ld42wMa+esYsS8QTylHijaXs
	u+f3qyjXFOuFxr7FAVkqQ21dYDayxpIONKcRVcJ5q1qvLrVtjvk5DTF5Co4PK7zx3RgkU/LF3fK
	yHHxR8yY+VDQyC2b8rIDTVBORYiPLZf+cUU3OJ/oiDyrl
X-Gm-Gg: ASbGncsago5cC6+/KD21+UinFpakuvTEQyPg++IXPqm2vX/uIKAp9S8UoQz5t6AB6D+
	v1asEbgGXU9wRhYZLPkqxejDOyib4CARiCHQHLREp9y1N15690KbzIf6LDlaq2Tj/zuBDl4+TVa
	DU9SnIDV+JwCzJCvTy78O5qm6f4R4Vuiy0w20f3QNXjHrubc+58om/WxODZOHb44xToH5qv42N6
	Y7OdCHd
X-Google-Smtp-Source: AGHT+IFx764zTbdEA6SqVfFUP9+ys/yQKFZFbRR5D83kmZZwWIFqppMGgBDBb4BDrHixxUD9Shg72y/IVcEl/e7S/GI=
X-Received: by 2002:a05:6830:6988:b0:749:77df:c38a with SMTP id
 46e09a7af769-76f6eb4df7dmr6465952a34.2.1758523161170; Sun, 21 Sep 2025
 23:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250919124217.2934718-1-jens.wiklander@linaro.org> <aNDMXvTriEiSLwPb@sumit-X1>
In-Reply-To: <aNDMXvTriEiSLwPb@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 22 Sep 2025 08:39:09 +0200
X-Gm-Features: AS18NWBbLb0VegGkHDcTRrbkfOYIr2ePDSBP0JcyijOcWJqS4-t8BSaLIlBpDKw
Message-ID: <CAHUa44FKBXjteyU=PsVfwdhNXb0msw03WD=5itxx2EKcEDwNTg@mail.gmail.com>
Subject: Re: [PATCH] tee: fix register_shm_helper()
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 058CC3F086
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.51:from];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.51:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.trustedfirmware.org,linaro.org,gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: V6DP64XN26KLVGNH74VVA7BAWFPUT5G7
X-Message-ID-Hash: V6DP64XN26KLVGNH74VVA7BAWFPUT5G7
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org, Masami Ichikawa <masami256@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/V6DP64XN26KLVGNH74VVA7BAWFPUT5G7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Sep 22, 2025 at 6:11=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Fri, Sep 19, 2025 at 02:40:16PM +0200, Jens Wiklander wrote:
> > In register_shm_helper(), fix incorrect error handling for a call to
> > iov_iter_extract_pages(). A case is missing for when
> > iov_iter_extract_pages() only got some pages and return a number larger
> > than 0, but not the requested amount.
> >
> > This fixes a possible NULL pointer dereference following a bad input fr=
om
> > ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Masami Ichikawa <masami256@gmail.com>
> > Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavn=
TjJAvUbEiQfq=3Du9W+-g@mail.gmail.com/
> > Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer=
 registration")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_shm.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index daf6e5cfd59a..6ed7d030f4ed 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -316,7 +316,16 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >
> >       len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_p=
ages, 0,
> >                                    &off);
> > -     if (unlikely(len <=3D 0)) {
> > +     if (DIV_ROUND_UP(len + off, PAGE_SIZE) !=3D num_pages) {
> > +             if (len > 0) {
> > +                     /*
> > +                      * If we only got a few pages, update to release
> > +                      * the correct amount below.
> > +                      */
> > +                     shm->num_pages =3D len / PAGE_SIZE;
> > +                     ret =3D ERR_PTR(-ENOMEM);
> > +                     goto err_put_shm_pages;
> > +             }
> >               ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
> >               goto err_free_shm_pages;
> >       }
>
> Rather than operating directly on "len" without checking for error code
> first doesn't seems appropriate to me. How about following diff instead?

Sure, works for me.

>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..cb52bc51943e 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -319,6 +319,14 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
>         if (unlikely(len <=3D 0)) {
>                 ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>                 goto err_free_shm_pages;
> +       } else if (DIV_ROUND_UP(len + off, PAGE_SIZE) !=3D num_pages) {
> +               /*
> +                * If we only got a few pages, update to release the corr=
ect
> +                * amount below.
> +                */
> +               shm->num_pages =3D len / PAGE_SIZE;
> +               ret =3D ERR_PTR(-ENOMEM);
> +               goto err_put_shm_pages;
>         }
>
>         /*

Thanks,
Jens

>
> -Sumit
>
> > --
> > 2.43.0
> >
