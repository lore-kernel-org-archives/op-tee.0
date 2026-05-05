Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1657CD342C
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 06:50:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E2FEB43E8A
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 06:50:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BvTnlQbH;
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 46DA843719
	for <op-tee@lists.trustedfirmware.org>; Tue,  5 May 2026 15:09:02 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8244105fa96so223158b3a.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 05 May 2026 08:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777993741; cv=none;
        d=google.com; s=arc-20240605;
        b=DICgxDdqDXWqZStIQY1gPZnOjC37yaflEg9xbwuU6UYkhUmSteFIPSkgvqDwKb3lpX
         hbCa6hkgVm8daut/p1EuICv7mkkH226t94GDSobho7OeoFVgjaC4AOtqLOZBv3JBZTXT
         BgvSPrzm6IALRmKnpNQKI7ds6eTYjPc+EKIosR2CQ6h7KKB5/hUmIAswy+plnIzdIt2S
         F9vC3H8w/Ffx7Lr6KvRGt9l9e48/wHgHU5Yr0mYLIDdpRFzMyzAfJnnuM6c0MkwRqH5W
         dlnbbEn3MSBvf6dWXftcnpZtCO+DAeRhhZhYWD62igyb/l7U6UBWA9X87SprG1oeuvOf
         NJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WFLu/MrxCCBgoaOgaM41gN26RjdDkqHXm8iJaHm0dUA=;
        fh=D7OJ7U+CULad1wFc6N7wFEOXQQ0wzv03e+n8t5XMx7s=;
        b=I0IDx2Jd9rzDn4e0ANamqIkS9MAg2h/hMdC3/PNeCbUIbsfWAZUr53UJZFASrWtxTT
         cZVl8rUxWkw8y9ztETZ/2sXOnhw/DzOiEmSdl8JG+LI0fT6mItszCCcQ8UeGsjWb4sDe
         pk7uaMwifoDix0VH2tyQRTbiYtJFKQjXdxhewcx4szd+bEaBhIBK6r+swszAvGb2lzRz
         m+W8ftP0envigFaeSlrNpdq+dap9B/SJx3+pYgVcWQCLgaZBHszeOolfB1WZKzl2D5qO
         qKh3j5+gpbKWKNmQLGDjUzZ9u9TZXH478YJQekyTho/r0MBshQKMFwN2T7sQVKLGDFD0
         teDA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777993741; x=1778598541; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFLu/MrxCCBgoaOgaM41gN26RjdDkqHXm8iJaHm0dUA=;
        b=BvTnlQbHX66u/WFnDrSdIzmKHwx4eragLSySLd3ToBOOrUvPz4l+Zako0iwPQTO2EF
         6alIe1OKbXCFvqkoWkOOa7CxDBhYPOtsyCUqWIghNQNk5Eh5C+A87MHXmYfieMbmRnYC
         0imFIvctWF1kKR+FdtzDba46jwLiZmuepzS3llsjaJByn5vWJW5D/mLxTjj2Vr8Kc6ah
         7JiI8TEMkwdJ31UkGYpc7EPlIYYlxeUcuxXJgY6e0LVUf/Th9b8nyrQO58UOTtX9QjMa
         fFHzeNbwSmGKaEbKh+Hxe+L34D8frlscnTeTDKGrQ2jiOSYd/a6kVhCiEoFQUl8OkF9Q
         AI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993741; x=1778598541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFLu/MrxCCBgoaOgaM41gN26RjdDkqHXm8iJaHm0dUA=;
        b=KZEiuGD7yd5siPPBk5ttThD7/jcc2LZNdPEZYVTF5tGKwICa7wffCZbPscFU3ZiQdT
         XHoQLPXhTgZ4a/YVrDjF0U7ukDIumQwMr86ypMM7OunFw3c00j5H/uRAT5X2fU921VzV
         SMgE87Nb/1eMhjTVo4K6Mx2HvjcPyrhInU5Txu0N0qHNxmIp/AwAY6mI2BUCQ8kxeJlU
         93vcfWsR/YmEWrZJkAFGznGnuG0jrSe9vyqeuv9XxhkjZpnmRs0l0PF2ZszhF/JC074p
         qWnlac3yH5aloO7jflB1TFIrPJK7O8YuiA9DtUOP+qOhlQBxw4ihi3ns5kThtUAq607J
         6ASg==
X-Forwarded-Encrypted: i=1; AFNElJ8sb4KjfpBjLEVJDZd1CHOj8P1/TCJtmHkaFtHb9Lev7uZml6DZaSxas9kMGcj1avTjATOptrU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzTHMeRUfWAV+vJHcFoKUk/30QtSEfY4hZuAZ6sSb8vWmmYLzE/
	rF0BGpjCAe1SIKveDGIhSyDtePp/lwZjzVBsJ89pSVBJfcGhQ20Ox8jWUtNGvJE9eFhkg4h4Odu
	Oy6NmCqKc9jh7JpYFdZ7kxU/PoPM0Y28=
X-Gm-Gg: AeBDies6zeyzcrWAzxgySRAni9L0FNo9WcqFT6B3Y80bhfa+5ZJRyKoQoTeK1wOKzpS
	KYohSLTTo2/1AnhOXBBFRsd/nIVgVGh97X6VeDBxTfjwQeC5gRr42WREQ1Yd6k6KFg5VD2UEo2t
	6rV+hWKzGTg2RnQUa96MeYMXpXVvFCvQD1HnhMTJIJmMuB/BsV8821hXC0TdWzYhZbh7znIa6AW
	QR+JpnPudUAvHvc0TJ3iO5FiDhUbNwN6bN/2Q34qbKm+z6+A5PEuW41qCRjteiMNrSUu7PqwSuq
	GJcyMfACHig6Sq9y
X-Received: by 2002:a05:6a00:1f17:b0:82d:1faf:775f with SMTP id
 d2e1a72fcca58-8393e36240bmr1517149b3a.5.1777993741117; Tue, 05 May 2026
 08:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHUa44E+b9SmT++XrrzSansAjMMhgxQLwCA-LmS-GMEugSmhSw@mail.gmail.com>
 <20260429113219.88452-1-q.h.hack.winter@gmail.com> <afS5XzaeLUx1ngAl@sumit-xelite>
In-Reply-To: <afS5XzaeLUx1ngAl@sumit-xelite>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Tue, 5 May 2026 23:08:49 +0800
X-Gm-Features: AVHnY4IB4bLxMECzVTsn7hVK-3lykdJPcSugaGO8bkP_uNQa_Ulxgd_hEQgrMBs
Message-ID: <CAH78GvtkW8RBmzY1y=n-RzTy-At947-TVFYQae5J95xyvVPncw@mail.gmail.com>
Subject: Re: [PATCH] tee: fix missing shm reference cleanup in tee_ioctl_supp_recv
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.182:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.182:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FREEMAIL_ENVFROM(0.00)[gmail.com]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 46DA843719
X-Spamd-Bar: -----
X-MailFrom: q.h.hack.winter@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: EWMAWNECRLTS3CLB5JSCOGIJGCSTHKJB
X-Message-ID-Hash: EWMAWNECRLTS3CLB5JSCOGIJGCSTHKJB
X-Mailman-Approved-At: Wed, 06 May 2026 06:50:50 +0000
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EWMAWNECRLTS3CLB5JSCOGIJGCSTHKJB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Sumit,

Thanks, that makes sense.

I had been conservative about the possibility of num_params being updated
by supp_recv backends, but looking again at the current paths, I agree
that alloc_num_params is unnecessary here.

I'll drop that, rename the helper to free_params(), and send a v2.

Thanks,
Qihang

On Fri, May 1, 2026 at 10:32=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Wed, Apr 29, 2026 at 07:32:19PM +0800, Qihang wrote:
> > params_from_user() acquires tee_shm references for MEMREF parameters an=
d
> > expects the caller to release those references with tee_shm_put() durin=
g
> > cleanup.
> >
> > tee_ioctl_open_session(), tee_ioctl_invoke(), and
> > tee_ioctl_object_invoke() all do this, but tee_ioctl_supp_recv() only
> > frees the parameter array and does not drop any acquired shared-memory
> > references.
> >
> > Fix this by using a common helper to release MEMREF references before
> > freeing the parameter array, and apply it to tee_ioctl_supp_recv() as
> > well.
> >
> > Since supp_recv backends may update num_params, preserve the original
> > allocated parameter count for cleanup.
> >
> > Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> > ---
> >  drivers/tee/tee_core.c | 49 +++++++++++++++++++-----------------------
> >  1 file changed, 22 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index ef9642d72672..adad1ea8e31b 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -530,6 +530,21 @@ static int params_to_user(struct tee_ioctl_param _=
_user *uparams,
> >       return 0;
> >  }
> >
> > +static void params_free_decref(struct tee_param *params, size_t num_pa=
rams)
>
> I would rather rename this API as free_params().
>
> > +{
> > +     size_t n;
> > +
> > +     if (!params)
> > +             return;
> > +
> > +     for (n =3D 0; n < num_params; n++)
> > +             if (tee_param_is_memref(params + n) &&
> > +                 params[n].u.memref.shm)
> > +                     tee_shm_put(params[n].u.memref.shm);
> > +
> > +     kfree(params);
> > +}
> > +
> >  static int tee_ioctl_open_session(struct tee_context *ctx,
> >                                 struct tee_ioctl_buf_data __user *ubuf)
> >  {
> > @@ -595,16 +610,7 @@ static int tee_ioctl_open_session(struct tee_conte=
xt *ctx,
> >        */
> >       if (rc && have_session && ctx->teedev->desc->ops->close_session)
> >               ctx->teedev->desc->ops->close_session(ctx, arg.session);
> > -
> > -     if (params) {
> > -             /* Decrease ref count for all valid shared memory pointer=
s */
> > -             for (n =3D 0; n < arg.num_params; n++)
> > -                     if (tee_param_is_memref(params + n) &&
> > -                         params[n].u.memref.shm)
> > -                             tee_shm_put(params[n].u.memref.shm);
> > -             kfree(params);
> > -     }
> > -
> > +     params_free_decref(params, arg.num_params);
> >       return rc;
> >  }
> >
> > @@ -657,14 +663,7 @@ static int tee_ioctl_invoke(struct tee_context *ct=
x,
> >       }
> >       rc =3D params_to_user(uparams, arg.num_params, params);
> >  out:
> > -     if (params) {
> > -             /* Decrease ref count for all valid shared memory pointer=
s */
> > -             for (n =3D 0; n < arg.num_params; n++)
> > -                     if (tee_param_is_memref(params + n) &&
> > -                         params[n].u.memref.shm)
> > -                             tee_shm_put(params[n].u.memref.shm);
> > -             kfree(params);
> > -     }
> > +     params_free_decref(params, arg.num_params);
> >       return rc;
> >  }
> >
> > @@ -716,14 +715,7 @@ static int tee_ioctl_object_invoke(struct tee_cont=
ext *ctx,
> >       }
> >       rc =3D params_to_user(uparams, arg.num_params, params);
> >  out:
> > -     if (params) {
> > -             /* Decrease ref count for all valid shared memory pointer=
s */
> > -             for (n =3D 0; n < arg.num_params; n++)
> > -                     if (tee_param_is_memref(params + n) &&
> > -                         params[n].u.memref.shm)
> > -                             tee_shm_put(params[n].u.memref.shm);
> > -             kfree(params);
> > -     }
> > +     params_free_decref(params, arg.num_params);
> >       return rc;
> >  }
> >
> > @@ -822,6 +814,7 @@ static int tee_ioctl_supp_recv(struct tee_context *=
ctx,
> >       struct tee_iocl_supp_recv_arg __user *uarg;
> >       struct tee_param *params;
> >       u32 num_params;
> > +     u32 alloc_num_params;
> >       u32 func;
> >
> >       if (!ctx->teedev->desc->ops->supp_recv)
> > @@ -838,6 +831,8 @@ static int tee_ioctl_supp_recv(struct tee_context *=
ctx,
> >       if (get_user(num_params, &uarg->num_params))
> >               return -EFAULT;
> >
> > +     alloc_num_params =3D num_params;
>
> Why is this needed? Shouldn't the updated num_params will point to size
> of params array?
>
> -Sumit
>
> > +
> >       if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) !=
=3D buf.buf_len)
> >               return -EINVAL;
> >
> > @@ -861,7 +856,7 @@ static int tee_ioctl_supp_recv(struct tee_context *=
ctx,
> >
> >       rc =3D params_to_supp(ctx, uarg->params, num_params, params);
> >  out:
> > -     kfree(params);
> > +     params_free_decref(params, alloc_num_params);
> >       return rc;
> >  }
> >
> > --
> > 2.39.5 (Apple Git-154)
> >
