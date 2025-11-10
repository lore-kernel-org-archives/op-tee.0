Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2166CCFA1A
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 07:03:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2A2A85001E
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 07:03:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gqlEMOP0;
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DCBBF431B1
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 07:03:33 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4501e8152d7so374381b6e.2
        for <op-tee@lists.trustedfirmware.org>; Sun, 09 Nov 2025 23:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762758213; x=1763363013; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZH9HBphOAagtoFjePNpMdaPRYh83TbkuAlXlrLr400=;
        b=gqlEMOP0eDhSNrcYBUCQUohtWhaZQgk6Am4UJ6KDu0h7iH3jbdFMI89jOunyPqSpvr
         3rGS/eIxix+tM9K6A6uJGMzc3qb5wfRSjWSqF8uAUsi8hsMQSY0WQPH6uEovCEE/mPP/
         W10HH5lnt2LOHPigoCqMYDErY55uv/CQ4eKDzaxbxjny2LhZ4uSe1paQlAGLTYdaoPbt
         89uexP2XMzInsvo/KO23rBE9EjGVpyuo7akdXUnrwJIgluoe+q+DqdJLhJ+tvEWOi3p3
         Pd0wn8mczFQb8tDVDhLWT0cJviviqe0RjHeT0dIZlo6MuY13BSfvX7swnCvDhCp0xChR
         HUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762758213; x=1763363013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZH9HBphOAagtoFjePNpMdaPRYh83TbkuAlXlrLr400=;
        b=tGMzBEExB44p47xAwz9n+YFqPvEhsLx9t16TZZfkaUwG4E4iC3x/EZ/Wj4r7KuHFTF
         hsz0Q4DYWyki0AeduOlwemBdIDid4//1GmWhyBNTzzJX6A3ChqgBPljKii9gpVoREX5T
         7oaTXI/yqu6b+JvbIDl8XroItxEhSH14kgKTitZ2aPhzYpe2OSdeJhQROU4/h5R1D1pV
         /6Se+GgFBPsr1Nodo6ANTE3lc1tNldiBdWX4L2boaMbB6/0iYklnLGUsxIFk0kLCvvxZ
         aY1LLHHGxvrUmNi2wxv4fQvfif5cl9zhlZ9HiKFTT3RXEuMpS6cfWdX9/JbVd9+D7thC
         sd8Q==
X-Gm-Message-State: AOJu0Yzo5B0HGLJSA1d/D6eheG2zGayqKO0ePkK/P4xEU84qz++Rh3JM
	G9jt0bmJ3t1Npp7vLQe7jqKpXiIJhnp4xIqowevL4vCP7LpGmnOVNKIJLOrgluOjG/OeiOm0axw
	qXAtt0r4V0TdYaDGNwfnXg5J79LXTzsYt0HF5xiHUYFQg
X-Gm-Gg: ASbGncsfvkjA6AnmWm2E8X8lWVJQYa7kbCDbNfPwJLxKLA3hC+TQwTEFiw2x7EOLG5O
	RWTaoGEi9pCQeAwgLwSu7NgY8rpIrPsCspNkkFp5XEeu3tQyCf1WKP0R4h4/kRm+e3KdvWnPwB7
	vspO3RBxBRyID1GBjsOBuwSv1CCUVNobuSWtFJxF7MCEpPQlPD5rR3k+2Kf/XhS+JhN+NC7DlJM
	hsym/tPFYlsYYjHY/rXMa4ke9wy13UnkL+ZlQ5Cd+RdidSVbcoVHKdVd+rTc+hjNXYRmCpu6W8H
	5euD
X-Google-Smtp-Source: AGHT+IGfcMCh8A+6KX8WwI3t/ZpN/O6TB7L+kmvdmryqmExFqyiRM6QCUcw0qA75XS8PzWEIgZCQDItmCsRNchsPauU=
X-Received: by 2002:a05:6808:3006:b0:450:9f5:dcbb with SMTP id
 5614622812f47-4502a1ba355mr3085976b6e.22.1762758213078; Sun, 09 Nov 2025
 23:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20251106102008.1310234-1-yangzhao@kylinos.cn> <CAHUa44FAUyQNBKmzugu-_gv_Jy_AftZqq=RSbKUnK1QQbL8Z9A@mail.gmail.com>
 <900f69d4-6ef9-fe1e-d664-e248e41da752@kylinos.cn>
In-Reply-To: <900f69d4-6ef9-fe1e-d664-e248e41da752@kylinos.cn>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 10 Nov 2025 08:03:21 +0100
X-Gm-Features: AWmQ_blYhauiyF-OMkjBxubo-x9ZLpIW-Wp0gXh6FaZH1ZHsThtizotDjFMWNFI
Message-ID: <CAHUa44EXPtdfPogjRirGB=aZ+ex-bD-iRf7m_=1OVk_KAY03_g@mail.gmail.com>
Subject: Re: [PATCH] tee: fix illegal pointer dereference in tee_shm_put()
To: yangzhao <yangzhao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DCBBF431B1
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	DNSWL_BLOCKED(0.00)[209.85.167.170:from];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.170:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: JR4CHBNYISZPDXHV3H3UX22PWIKFDWLW
X-Message-ID-Hash: JR4CHBNYISZPDXHV3H3UX22PWIKFDWLW
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JR4CHBNYISZPDXHV3H3UX22PWIKFDWLW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Fri, Nov 7, 2025 at 7:14=E2=80=AFAM yangzhao <yangzhao@kylinos.cn> wrote=
:
>
> Hi=EF=BC=8C
>
> This issue is indeed caused by the mismatch between the TEE version and
> the kernel version. Currently, this patch is only designed to address
> the problem of ensuring that the kernel does not panic when the TEE
> version is incorrect.
>
> The virt_addr_valid() is used to check the validity of the pointer
> address, because during the test, it did occur that the shm->ctx pointer
> address is the address between the user space and the kernel space. At
> this point, using IS_ERR_OR_NULL cannot detect the legitimacy of the
> pointer address.
>
> The problem can be viewed at the link:
> https://github.com/OP-TEE/optee_os/issues/7575

OK, let's sort out the secure world side of things in that issue.

Cheers,
Jens

>
> Thanks.
>
> On 2025/11/6 19:31, Jens Wiklander wrote:
> > Hi,
> >
> > On Thu, Nov 6, 2025 at 11:20=E2=80=AFAM yangzhao <yangzhao@kylinos.cn> =
wrote:
> >> In tee_shm_put(), there is not only the NULL pointer dereference,
> >> but also the illegal pointer dereference.
> >>
> >> shutdown() --->
> >>      __optee_disable_shm_cache -->
> >>          shm =3D reg_pair_to_ptr(...);
> >>          tee_shm_free(shm); -->
> >>              tee_shm_put(shm); //crash: shm->ctx maybe NULL pointer or=
 illegal pointer
> >>
> >> Check whether the pointer is NULL and whether the pointer address is v=
alid.
> >>
> >> This issue occurs when rich world uses the 6.x version of the kernel a=
nd
> >> optee secure world uses a lower version (such as version 3.2), and it =
is
> >> highly likely to trigger a kernel panic when conducting hibernate test=
s.
> > It sounds like the root of the problem is in the TEE rather than in
> > the kernel. How about fixing the TEE to avoid supplying garbage
> > pointers?
> >
> >> Fixes: e4a718a3a47e ("tee: fix NULL pointer dereference in tee_shm_put=
")
> >> Signed-off-by: yangzhao <yangzhao@kylinos.cn>
> >> ---
> >>   drivers/tee/tee_shm.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> >> index 4a47de4bb2e5..de01d16409c1 100644
> >> --- a/drivers/tee/tee_shm.c
> >> +++ b/drivers/tee/tee_shm.c
> >> @@ -722,7 +722,14 @@ void tee_shm_put(struct tee_shm *shm)
> >>          struct tee_device *teedev;
> >>          bool do_release =3D false;
> >>
> >> -       if (!shm || !shm->ctx || !shm->ctx->teedev)
> >> +       /* checking pointer */
> >> +       if (IS_ERR_OR_NULL(shm) || !virt_addr_valid(shm))
> > The IS_ERR_OR_NULL() check might make sense, but the virt_addr_valid()
> > does not. virt_addr_valid() might catch a few garbage pointers, but
> > the real problem is that someone is supplying garbage pointers.
> >
> >> +               return;
> >> +
> >> +       if (IS_ERR_OR_NULL(shm->ctx) || !virt_addr_valid(shm->ctx))
> >> +               return;
> >> +
> >> +       if (IS_ERR_OR_NULL(shm->ctx->teedev) || !virt_addr_valid(shm->=
ctx->teedev))
> >>                  return;
> > shm->ctx or shm->ctx->teedev should never be an ERR pointer. The
> > virt_addr_valid() test doesn't make sense.
> >
> > Cheers,
> > Jens
> >
> >>          teedev =3D shm->ctx->teedev;
> >> --
> >> 2.25.1
> >>
>
