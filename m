Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7687FCD3442
	for <op-tee@archiver.kernel.org>; Thu,  7 May 2026 07:47:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B6AA444DA6
	for <op-tee@archiver.kernel.org>; Thu,  7 May 2026 07:47:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UnZaoOfS;
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DB68643ECE
	for <op-tee@lists.trustedfirmware.org>; Thu,  7 May 2026 07:47:32 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dd73b7c757so314306a34.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 07 May 2026 00:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778140052; cv=none;
        d=google.com; s=arc-20240605;
        b=BMXxcvgs7CFXqnBLKhiiBxmvr3JzA0SnnstoKJsW302BuhLq4pesws6w4jvFNvZe8j
         Xx0JLCrP2LZMEMwLAxDPVW6GYQdC41mjcXbWRWyXOE1g4iQA23MdfXudTnFNrgNLuq7h
         V9D1Nbf0rLZOg3qq2NP8Ay2VcsI2+AjXGHXw0K/hX3S+JgV4kd6RKtJuVGwNIJew12EQ
         8Lw7CBf65dQ8xfBGnabzeWcl9AVO/3+NgF95P4CT4hmYOeh/ZVx5qvo1Kp+1Lc0jnHv2
         QyOMF3BAJsUSMHfZixhjuqWMvqaXfmVz0r9yXfIc9oto+HxhcW8gY+ltYr8wTNQjL6XK
         dXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rq2ok0aSlKnK84NFw1V+oWhftvLjgXlYehWfM4IqKd8=;
        fh=qtz08ZPdSgc+7RNghRvxWcyM7X9yd+j+C+1cIzkItaA=;
        b=dwI1czHqgTYHXcq6siLAEVwZCXEE6ZVKj+lHck/HVyn45NNb7GAjYrhgJhfO5bQdKV
         mczICedylZrucEJghJfxUwCuX5FB1b0/Rhvc/dPmy5VNqTMa2CJZytnETYiCB9NMMsrd
         8thY1pco9+UGyI5DfQ7/fTBQvLKoA43lZcT7/VHkoaosA8U7aMuwzQBcmsRaXMlC0kxy
         EaFL/Fjo9iFY6onHkrIBUte9b6CzEp4Cd03N9MYCb18D8bBZsPVTMgxHdPpo3OV80bRT
         yr7G3gLTe/nrvtWDJTNbo5x5sPfDH1kKjvJgM5g+PRBVww/9NorJdp02D+7AV94NIMUY
         YurA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778140052; x=1778744852; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq2ok0aSlKnK84NFw1V+oWhftvLjgXlYehWfM4IqKd8=;
        b=UnZaoOfSOXVDTLdqQVLFl6A3SocC8TP0q3AJc+v1WFLVm82u9xB+rOvKmWs5Axo9LI
         1A24A1XobdoAUGXl7sqXrztiH9/rkchivcm17RkM5/S0gL05VY/IsaQ6D78xm+km8trL
         VHqBVqEbYG3R63ZmgQ7s2W3Ci4m+7h/kYcMlkKcgzvq4bsoGYoIuImNhsXEd3foWi8h9
         W0lr3vrrwdbdrqMrLipxv0orftmrNfSDsTDhrQNxygpJUzuGdehpkaCLeHgnYJI7S8sk
         ZUA10+MYYUQrTG1eOVFVsifvoY18bVLwLU/X1MoiWbZoLkoMBAhDJEWKcnrwGo36pdqv
         9mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778140052; x=1778744852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rq2ok0aSlKnK84NFw1V+oWhftvLjgXlYehWfM4IqKd8=;
        b=Uo+wuY9da0g4mviM3rVXiQfHkLHeMOhSmubkyKcZOE+C5GV7/3JdFcWL63ggXbiwge
         HivTDZ7XhgIQqgR1aqyRDnWXGKfDmd6Y+8qMHllfENjw+W81zhFA5zRpYNvd46NTLIs/
         TFYGQrZ6pxRXqLgz5TlU9vwQxtgwYg6R4tZkRpQmdDHQlKP8oiSQttLe7pi9NxTWCoA6
         MYugJzoBmCdr2TKA57CuPL4L5eier7Xeq4y3aGxdWt2eZ59GbmFUZnc4jfE+RsWNMIEb
         7S27RCdkxrdHvGjMICnBwFFc8poHqWWkUex0JSs6xMqM0I4QJs84YQlGHXSuqJ/jGPyg
         NfiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DNEKR1DX4VzdfV4wTC7Z9Fn0DE5TZ6l9mlnIRDsuOFSCd9XRsM+dtz1wVu7pVjuYEfxfw9jM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwcqU4nkXpaiGIgK6nfG1s6UAn9vul3aV7GllMVsuU7JEL3q+ed
	NlRIFnn0FmChFOMzp55ohlhhXTHQmzH6uJJJCAMUnxYK/7Z53DlB22kjBOLPzpcuLooefxEgl24
	+D9HyrHwGVKtwylUxHuTKA/osJNU9f7em6LgZPUa+Jd13
X-Gm-Gg: AeBDiev54dghO+BaAIr6+4uwWuKlM0ent7djcgAP9WYfE5d+dMj+rbA0GAZniykNRNn
	taFjG+oayGcT3FDe0ZrHFBaw9pIYepXc2My4oi15og3QlUhZHvHMTKleN2qfYoQMQsJ7b0izpL8
	EfUbl8hb8aeE5zSdfEZ5J3ejxRaxOf/o2q9Fe/2ACYmiXCZwSLlIfq0pAd6jc5ipJPBN0cAA+/s
	UGziTRg9ya7vzIGgRMy1CQb99+jzMcLAkSAkWWnI58OexPYoKeYp6wRR8uE18SdEle/SwN0lmI9
	FokWtlLT3e96D3FihFSTnlS8kPERA0T7oKb7bclBpKpr+pTcHDxeGvTHC2tHDUUtGdlmig==
X-Received: by 2002:a05:6820:f0c:b0:696:1262:2ac5 with SMTP id
 006d021491bc7-69998c8d2e1mr3513403eaf.2.1778140052107; Thu, 07 May 2026
 00:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <afS5XzaeLUx1ngAl@sumit-xelite> <20260505153041.17794-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260505153041.17794-1-q.h.hack.winter@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 7 May 2026 09:47:19 +0200
X-Gm-Features: AVHnY4I3eBtv3D8rGkhC1wCK_ZWQmYetzUxgOXDCTF-kqlSTGtCM8cm09k-GAHQ
Message-ID: <CAHUa44FYNJQp5PRijQ9i3w8h0aOcaWeF=AcVzF7qb9+G6WoFJA@mail.gmail.com>
Subject: Re: [PATCH v2] tee: fix missing shm reference cleanup in tee_ioctl_supp_recv
To: Qihang <q.h.hack.winter@gmail.com>
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
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.47:from];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.47:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DB68643ECE
X-Spamd-Bar: -----
Message-ID-Hash: IQYTZVCICEH4SOEPW53RAHS65QJ7BCHX
X-Message-ID-Hash: IQYTZVCICEH4SOEPW53RAHS65QJ7BCHX
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IQYTZVCICEH4SOEPW53RAHS65QJ7BCHX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Qihang,

On Tue, May 5, 2026 at 5:30=E2=80=AFPM Qihang <q.h.hack.winter@gmail.com> w=
rote:
>
> params_from_user() acquires tee_shm references for MEMREF parameters and
> expects the caller to release those references with tee_shm_put() during
> cleanup.
>
> tee_ioctl_open_session(), tee_ioctl_invoke(), and
> tee_ioctl_object_invoke() all do this, but tee_ioctl_supp_recv() only
> frees the parameter array and does not drop any acquired shared-memory
> references.
>
> Fix this by using a common helper to release MEMREF references before
> freeing the parameter array, and apply it to tee_ioctl_supp_recv() as
> well.
>
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
> v2:
> - rename helper to free_params()
> - drop alloc_num_params and use num_params directly
>
>  drivers/tee/tee_core.c | 46 +++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index ef9642d72672..8cdf2ec7e74f 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -530,6 +530,21 @@ static int params_to_user(struct tee_ioctl_param __u=
ser *uparams,
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
> +               if (tee_param_is_memref(params + n) &&
> +                   params[n].u.memref.shm)
> +                       tee_shm_put(params[n].u.memref.shm);
> +
> +       kfree(params);
> +}
> +
>  static int tee_ioctl_open_session(struct tee_context *ctx,
>                                   struct tee_ioctl_buf_data __user *ubuf)
>  {
> @@ -595,16 +610,7 @@ static int tee_ioctl_open_session(struct tee_context=
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
> @@ -657,14 +663,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
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
> @@ -716,14 +715,7 @@ static int tee_ioctl_object_invoke(struct tee_contex=
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
> @@ -861,7 +853,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ct=
x,
>
>         rc =3D params_to_supp(ctx, uarg->params, num_params, params);
>  out:
> -       kfree(params);
> +       free_params(params, num_params);

This doesn't work. The supp_recv() callback is special compared to
open_session(), invoke_func(), and object_invoke_func() callbacks.
supp_recv() replaces the supplied parameters with other parameters.
Eventually inserted memrefs are reference-counted separately, and
adding it here too would only add unnecessary updates (supp_recv()
would need to increase them, only so they can be decreased here).
However, I think a comment before the call to supp_recv() to remind us
of that would be nice.

However, there's a bug that needs to be fixed if params_from_user()
fails. One way of dealing with that is:
        rc =3D params_from_user(ctx, params, num_params, uarg->params);
        if (rc) {
                free_params(params, num_params);
                return rc;
        }

and then keep the end of tee_ioctl_supp_recv() unchanged.

Cheers,
Jens

>         return rc;
>  }
>
> --
> 2.39.5 (Apple Git-154)
>
