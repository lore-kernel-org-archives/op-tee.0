Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F146C87FCF
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 15:50:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B11E54FCD4
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 15:50:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZSHdGb6I;
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E2F0B42F64
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 Aug 2025 15:49:40 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-619a915c65fso596190eaf.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 04 Aug 2025 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754322580; x=1754927380; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwpsU/1XQKoqUW4t4lntajLzcj7nckiR82+0joEUMlw=;
        b=ZSHdGb6IZxO0G87aQPno3ClO7b1W6TKSx2a8vWBXbSLEVve1HIwTCY1URMaT3zQEZG
         lDbCXdB7ZqzuremsKqUBXrprxW0+R6orsBMXoPx8S7LEHuXM2h1mFWg6yoxFtwi9H68X
         uEQCuhaN8yP0Q/KUZm3r72+aQWzxFCdbMFsRjF1IU1kIGYVhd6vUhHH/jYa5gG9RraXR
         JEueWABF6u2vApFp7B/v/GIDOCNaQC3+RxVv2IP28Nw4RNbIicZzAQIz0mOYGQyVEYYG
         RRH9aQ0D9HsLaFZg+VedsroaCDQxA8MraieEq9Of3P3i+iorVlkU44FIHE6BOEjxvgGD
         jxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322580; x=1754927380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwpsU/1XQKoqUW4t4lntajLzcj7nckiR82+0joEUMlw=;
        b=Te5xgnj+zS4YEQ24RyH+UGs4AY7bvgIPP+ZFJivRzqbXks3L494X4H8oETdTiqc/3+
         qnDO7ndZ9xvMpYQc9a5nAHMnMd5b4vl5BrqpH+iLPvzmK1My2ZXzKUFFSsYtWl7ofMFm
         KRqwzQl3JZ+blQRfhL9A9wMjti03nEsqrLL3xS/YN+4z0xykXfUgQkz/UFNdIdMUcUvW
         ryTtqN9XivaTn7vksuGAnycWlZIouLioWdG00Twsb+7araupa5Ubij46ivSNjJbQbkRT
         TV0VqV9IAvkzPfDBVgBnoIJDRR9u1vzP7TfQlQXVPziheMxLK1zRE8HFx4ckHWe/GYyk
         +FfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3gZ1Cn2B9HqqC6L77/waLMYgm/JuqhU9c3iLSHZWBU4DheG0Wo/XVkj+VRSWM+tf0PMO4oLE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywvx0qtMMlKbQzAzhXnwd6njSklRL9SB8EpnBY2DTjzaMzKSESj
	egmehK8OUexyPFMD3kRZXfChzrZW3n0oDtlVrObiwRQE4YHCGlZHEzuk4DqbEsAqZyIVEBUEwkt
	IyodVmc9QJwYJG1oOkZv5Mj1zkLr0mQA1y8dULULbNe6X
X-Gm-Gg: ASbGnct+A7VYMawfdg906AP+tmyFobX8AiaQ8n/4reFNJlZjnzQKPOS05Qkz5FKT4Em
	d3u1ibehxaWDlATw6c9drxN/W+AGPWA44Cy4CJC8vGrKB4NjOuODU8dfWbJEEdmBSO7RMg7/Fka
	ksHfawDNHfQaPyYGWve733pfcFdOBiTLldqbiIyAT4dx1QFn8SAr2Pb8HF2pezOI7u07KlidQmK
	oH50a+Q
X-Google-Smtp-Source: AGHT+IHgaQgk3f6H/3KX12vfUec7jykjb6GJaLe3Edl/bXtGP6RofdteZULNw3f7ts3w5DkzL66APzyZelnJi9ZiEQg=
X-Received: by 2002:a05:6820:1e88:b0:619:a040:a61b with SMTP id
 006d021491bc7-619a040a962mr3008362eaf.8.1754322579949; Mon, 04 Aug 2025
 08:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
 <aIiUEGt2uVF9yi1W@sumit-X1>
In-Reply-To: <aIiUEGt2uVF9yi1W@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 4 Aug 2025 17:49:27 +0200
X-Gm-Features: Ac12FXxloQhDa4UWHLtUmaDy4W6OWJWZEYbGK0Nr6i7EzpGH5yulks4fivp9qnc
Message-ID: <CAHUa44ExoWcNXVDiwUA02qEhiCFF0obeXYJY4_NEVUTzEvkUng@mail.gmail.com>
Subject: Re: [PATCH] tee: fix memory leak in tee_dyn_shm_alloc_helper
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E2F0B42F64
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.54:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.54:from];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: I7ULP5KA5NKVQU5EA2YG7WVSBX5XQFFB
X-Message-ID-Hash: I7ULP5KA5NKVQU5EA2YG7WVSBX5XQFFB
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Pei Xiao <xiaopei01@kylinos.cn>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I7ULP5KA5NKVQU5EA2YG7WVSBX5XQFFB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Jul 29, 2025 at 11:27=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Wed, Jul 23, 2025 at 02:22:41PM +0800, Pei Xiao wrote:
> > When shm_register() fails in tee_dyn_shm_alloc_helper(), the pre-alloca=
ted
> > pages array is not freed, resulting in a memory leak.
> >
> > Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
> > Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> > ---
> >  drivers/tee/tee_shm.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 915239b033f5..2a7d253d9c55 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -230,7 +230,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, s=
ize_t size, size_t align,
> >       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> >       if (!pages) {
> >               rc =3D -ENOMEM;
> > -             goto err;
> > +             goto err_pages;
> >       }
> >
> >       for (i =3D 0; i < nr_pages; i++)
> > @@ -243,11 +243,13 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm,=
 size_t size, size_t align,
> >               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> >                                 (unsigned long)shm->kaddr);
> >               if (rc)
> > -                     goto err;
> > +                     goto err_kfree;
> >       }
> >
> >       return 0;
> > -err:
> > +err_kfree:
> > +     kfree(pages);
> > +err_pages:
> >       free_pages_exact(shm->kaddr, shm->size);
> >       shm->kaddr =3D NULL;
> >       return rc;
> > --
> > 2.25.1
> >
