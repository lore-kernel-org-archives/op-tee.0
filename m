Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99DDFF8864
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 06:34:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E54F043E69
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 06:34:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o1qlV4qI;
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2C79243E31
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 06:34:48 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7de7c57b52cso2573908a34.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 23:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777444487; cv=none;
        d=google.com; s=arc-20240605;
        b=h6YyLsA07H46igqgPnkKfVRBu/gOiJcXz5rOjzukh9n2hQ4UC8QNf2L3LXgiVjO5l9
         zsWleDUw3v715VmUmS/DN3kxNSdX6WfJo/qiekO2851Bh1YcfhaWd+6fOFTAcMRfqvm9
         WCiuA+3S9SMujcqSNrQ/x7wEG/s1Ae8eqNjkvtuPzeOsSRfZhbwrTDZHhkLhXCVAABfU
         ANgq5Mxo4EowJmsOl9r9afORyS+Gwuvg5yxlqX+pueanGmY3EJonlZn0fTGIgiMSc66S
         1Lr+rBUk2YGG7ayxpJpkhDmd5FNIkNjB33EV8A5PHAnhVjKICHwhe/Mpbl0h618GpmbW
         y9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HDUPU8onEShdOHYoe2jqa/mvVDLssD4N6nKL5h5/I5Y=;
        fh=19sCu8xeGiYaWUF2ZQNaDDfZpHV2dNM33TjFKGdR8NM=;
        b=I3bz12KNlBzZgcMSyPcdw2KdV0aJqFYIKrHYbsXrsy2EQh7FMaLeIY5gEmMZcNeC+w
         5B7xi5aK2+HGxC6dG2HsswFZWwHKGJ7UcOUwO9+aKgRUH5ZW3/Bx5qF0G/OrO1NdoqZs
         sU9p4yqrZRmfJ7JydC7y3x6reVoN9iNptyDDNHbJ8tHcV/N3dx5gGtTGZd666Cg2OGnt
         jFTLTlIzm+3h3h/ImVm2NIeaaWavvIAD6wa3drxvxFMR3I9zhAaGIzRgooqnnAU3lliB
         ifIChWHttUOE7D/1148eJb9os8/o5EBKtemGHvA2pqhbXzT/eVYM3wmuC25cNIZpW2pM
         sWWw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777444487; x=1778049287; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDUPU8onEShdOHYoe2jqa/mvVDLssD4N6nKL5h5/I5Y=;
        b=o1qlV4qIa7QqD3NB+peGAs0oXjCjN3SvNvY4s2yIOBziPaKi/NonHc3UySwDg7fB9Z
         7QcG+sKO1s5mPFDOZ5T3Gauuoy/EVILKM0y/fYSCtOBbQs2deQ+4f8NoVfA/pvCLIfPl
         6MsSR36V4UVsntDF6IA55+OKFgSi1452RNljdXjzzwf0DOeLiMz8hgqYvhum+xJaW7Fq
         nmjNx63+jtOVe18813D3Y7qUiqc16c9tuS0uvwHjsaLJY/pax+wy15L4rM4QbSuSzrik
         MuF5j2AhlCxGzqF5vGKdNP8tsbogcmKnA/Vlrqtq6C1qTzt1g/EV2bcswV8BDwTfiuQC
         uyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777444487; x=1778049287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDUPU8onEShdOHYoe2jqa/mvVDLssD4N6nKL5h5/I5Y=;
        b=nePXu6tpQDnS6n5jU9Bn1ieEyITRO4GIO9HbC+gTFOrcjSPM8AWOTb4Sw1YEvUgxVA
         rMQ3oLlDo2S7vvpyUlFaGHNPLKt2GDDnEGXk7EYwmlmZXhqHBYO83EjQZZts3v1pU0Nx
         r0RtlwTw1uYcszFqs4nAzxfnA+JF2S1GJRhhd6tA0o8+0eW+5DT/V88ifRdxlTXFac03
         Oz/UTtH4jodnjXDwZO/Kfn31rRzWxjDHskZY+9hT6W36il0jaIZzaJpHaTQREi5OjVSH
         O7lM3cW4Nj5Ku0KGla+9PIQRRratj0DtD+treOhfHUDvfPsIvpjWgILOtEc0P+iKD4rW
         oaEw==
X-Forwarded-Encrypted: i=1; AFNElJ9JrtRR4L8uiTbVHM+ewHF3AHfoNwt9e6hc/kBx/IzOTsDkCXnvTMpVnWWp7Q4Ks5dFqKAabwI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywb5S8Pbz7siBGZcMMivXssFZqtGOEEzUHHTu80vDlpg/L2oKK6
	fqMp7sdtknV6ehrnJRhZm5/7nD0Jez6edmUKMgzd9UTCkPARms0WI9XvqZz1GfG/9HyT6NhvOjf
	Y1AziYxD6xGVd/rLq0NSA/EW5oAcvxAWhcKEg9bG80wNZ
X-Gm-Gg: AeBDievXsTqaFVnhIMKhqVQ8IgLl5mcHfBOlgVDvfRjjLGvu3p9whDs74Jrry34yxDf
	+4ETNLxUnzYsahV6b5lLS+Jj6EcJg6z7iUiuS+fQbJVrobZc6C8SuuZfg891mVgX69rL0IV1EOe
	y6ox8tH5QiAob65R5FCp4ZdRhRDUHyh/Wb7kyopbDLQjq6n4FRdM3OxQR0zFfkH9vbZj/GJp+ff
	vShso/416QcX2Q8h+awGIXLxWuMtXAEd2GXDlBTczapJl6ebkef/MQDjvJIP6yxXAB51LQgktwV
	DWILbGhbXhOA65N01QscDjZbUKzrAbrNwg+GctEluL5ebFnp
X-Received: by 2002:a05:6830:81f1:b0:7dc:cadd:f95d with SMTP id
 46e09a7af769-7dea65c55cdmr1723382a34.2.1777444487524; Tue, 28 Apr 2026
 23:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAH78Gvtd_reUt1mCasR=grZuLWWHcn4-ox3bXWXNEvbTOV3UGA@mail.gmail.com>
In-Reply-To: <CAH78Gvtd_reUt1mCasR=grZuLWWHcn4-ox3bXWXNEvbTOV3UGA@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 29 Apr 2026 08:34:36 +0200
X-Gm-Features: AVHnY4ILDTKr-2vOi3afYFvIMLYeZCifZoFDopO91prc_f2K01F8v0wnMiPRaRA
Message-ID: <CAHUa44E+b9SmT++XrrzSansAjMMhgxQLwCA-LmS-GMEugSmhSw@mail.gmail.com>
Subject: Re: [REPORT] tee: tee_ioctl_supp_recv() missing tee_shm_put() cleanup
 for memref params
To: Qihang <q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
X-Rspamd-Queue-Id: 2C79243E31
X-Spamd-Bar: -----
Message-ID-Hash: 4N43QWXQMFAMZQRXZWRBYRZOV3C4EOIR
X-Message-ID-Hash: 4N43QWXQMFAMZQRXZWRBYRZOV3C4EOIR
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4N43QWXQMFAMZQRXZWRBYRZOV3C4EOIR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Qihang,

On Wed, Apr 29, 2026 at 5:07=E2=80=AFAM Qihang <q.h.hack.winter@gmail.com> =
wrote:
>
> Hi,
>
> I would like to report a likely shared-memory reference leak in
> drivers/tee/tee_core.c, in tee_ioctl_supp_recv().
>
> The issue is that tee_ioctl_supp_recv() calls params_from_user(), which
> acquires references for MEMREF-type parameters via tee_shm_get_from_id(),
> but the cleanup path only frees the params array and does not drop the
> acquired shm references.
>
> Relevant code in tee_ioctl_supp_recv():
>
>   rc =3D params_from_user(ctx, params, num_params, uarg->params);
>   if (rc)
>           goto out;
>
>   rc =3D ctx->teedev->desc->ops->supp_recv(ctx, &func, &num_params, param=
s);
>   if (rc)
>           goto out;
>   ...
> out:
>   kfree(params);
>   return rc;
>
> By contrast, other callers of params_from_user() in tee_core.c do release
> MEMREF references on cleanup, for example:
> - tee_ioctl_open_session()
> - tee_ioctl_invoke()
> - tee_ioctl_object_invoke()
>
> The helper comment in param_from_user_memref() also states that the calle=
r
> is responsible for calling tee_shm_put() on all resolved pointers.
>
> Reachability / trigger paths:
>
> 1. qcomtee backend:
>    qcomtee registers .supp_recv =3D qcomtee_supp_recv on a non-privileged
>    tee device path. qcomtee_supp_recv() rejects any non-meta parameter
>    after the first one:
>      for (i =3D 1; i < *num_params; i++)
>              if (params[i].attr)
>                      return -EINVAL;
>    This allows a path where params_from_user() has already acquired a shm
>    reference for a MEMREF parameter, then qcomtee_supp_recv() returns an
>    error, and tee_ioctl_supp_recv() exits without tee_shm_put().
>
> 2. Partial failure before backend callback:
>    if params_from_user() successfully resolves an earlier MEMREF paramete=
r
>    and then fails on a later parameter, tee_ioctl_supp_recv() still goes
>    to the same cleanup path without dropping already acquired shm refs.
>
> This means the issue is not just a backend-specific quirk: the core ioctl
> cleanup path itself is missing tee_shm_put() handling.
>
> Impact:
> - leaked shared-memory references
> - shared-memory objects may remain pinned and never reach final release
> - repeated triggering can cause resource exhaustion / DoS
>
> This does not appear to be a UAF, since refcount_t saturation prevents
> wraparound. The impact looks limited to resource leakage and availability=
.
>
> If useful, I can also prepare a patch.

Thanks for the detailed report. If possible, please prepare a patch to fix =
this.

Cheers,
Jens

>
> Thanks,
> Qihang
