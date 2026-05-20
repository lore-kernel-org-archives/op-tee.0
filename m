Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AACDCD4F3C
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 10:52:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A94C644A40
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 10:52:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AYCl8bC4;
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 540624391D
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 10:52:05 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7de7dc85b74so4644878a34.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 03:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779274324; cv=none;
        d=google.com; s=arc-20240605;
        b=I8lWqGSj69ieA6GugB0DVLsyXdCmmbqmKdUC80nY6CPZLZwP4JNsjbHgWN/qHyyKvY
         g86bYQLv941T5GY9l/nZKz+McGk2L9/gaKOx3Fz5o4Ule1XXOn84QqhidUizpw29YLtk
         392aFOZvh6pQ57s+9PAI/pFDOuQsG56fxM1cLjcPIhg1BTBWCFVUxfMdy+CZDGWpGUEo
         3+kdGJfYoRhVpC/KG2l+L1mzEdpQBekPIS44BaTzxapiC2dIUEd5f7un49mPgfnOC8BN
         He4DlAulLSEnEFa2fHsrRmGAvLMtArSK6qxEbiYMn+uy1M7Gg+jMS0FJQpl79BiRMD+N
         BSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nPOHIcIs6lbXC2xlIAHEKgXOWfGw2NT1g/NXeTKaMwQ=;
        fh=3w6Wz8ZBk2tbcB6hbzM5xfTiKQbTOGp5w+tRyvn0+fo=;
        b=PxrJOUekODXPbrr1T8V4NOy69x/kHVUspeCBGtEBZd/iwfxD8MRGQhkrTW+/3LtDNc
         ubSvjpkc4A+e59TbKEOy7giLUOswL16yRf5DU4jyFJIUKDa1z2nMQcktX1Oke0tXRvdj
         Bw5IBVeg4fvgdt5ZI/efxcuHdTgutX4cCXLA1luDVrclOuHeNb9ftO2i0/t3srIzA50L
         PTgKqSLsQyJjmMN5bxp2yUw+wiZgDqHbWpJuuKeaBoNRj7gVQIUBVUYJDAKiK4OScEcr
         6P8yIL7W5K3bV4Mc2HJn5NP2bRM497m1ec8vp9Bp6F4Re3euwLRsOOVRmB6eR8w4tgxa
         E0/g==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779274324; x=1779879124; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPOHIcIs6lbXC2xlIAHEKgXOWfGw2NT1g/NXeTKaMwQ=;
        b=AYCl8bC4d4KmhFlah6mklG5FU70cZCSuu5/sbGl/jFZVAK64EK/9gb3B7dTb0BwHzY
         PAFhgr10XSfQbBN36AKwR/zjJNuhnkoSe+YTmBep3u0I7cKBofoEGL9MxL//0rpIjEgn
         cs18B6X4XobbNBATDZZyA4XJWAmVJ2CI9PsmtIaQToptU9H7pyeCGV1WQcg+r5QSYQso
         jRTSuBs3Z2hI+FX7UalWW6yHhZUqZqIxY6k5dszza4tgGulBZWG/c0E27262lEaUD10d
         L2HqbgeM8JtWJGVVHhxvWBlpNbB1oyFI2lynmoQn5E/yLHrMfpmlNlgViLOfLHeUsDTs
         13MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274324; x=1779879124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nPOHIcIs6lbXC2xlIAHEKgXOWfGw2NT1g/NXeTKaMwQ=;
        b=lxad+D8U8c4RLUN+OSCBW1eQnl/3b4UxzCz6aWNxR8VZWS2Zxr0CJHxj/GI7k18QDv
         II05qHJmA+ybC2lK7eiicV+tv+ZUPDvJXxsESIRnngRPM9ETG855WgEycRdYn+lGGUUU
         CcgcG9JKOXyIjx1MQ6x1ZLkvT+QuH0m1XV9D/3kSD1J/HUggDYwb6msm8tYyDCjNCXvq
         AtR+8MItp6K6zm3zoIRyI/R4vrH09cZObhm7SOcDsS75zOsH41ceXMulvp3Y24qbmm12
         0ZuYNiIdwh9NaXF4y76xRIYBGytTtAnTHw0Yg00Rci4T/g6XdQQYPumzqGUA5SxvJtgb
         SJwA==
X-Forwarded-Encrypted: i=1; AFNElJ+/qqkdl0k7gw4xcUDC/r5he/UTnuSWGMU5pwua9PBDTdcJ5HWpd+mxTzz1QpZQdGG6wldF+PE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwNMBf7m+PvcEUBQpwy646FF+1L4Bjit6NDQS1P5qVZgDdO43C4
	w+1NfEwX1LVSkYJ6r6TObsSwh6N/pUoo5XPOiwBZAC6/OOh1OhKyCmxiHJ6A5/1ilxNiBE4uLO8
	L5bn8T9rYlB3hy1QHZgY+dB8Tz71iywhVp7XwI68MpVJR
X-Gm-Gg: Acq92OEvsJTLZraNtU0/FV02h2KwqUCi1ByzehI+O1j/1bMRJDyMaocYUd5y+Qtunkn
	9nm0iVOMbLk28+MpRhvlhXIb5r15Ur9BHgXq5hBe54dI+9bZRT6KEaGVZklfmV0YTRQMYe0Qexy
	TwCIFBkJl8M+CMVypG/qYdzQzJAPVijDWMNUmiC8kDfHymbqvZ83PmMP4gn4nGB/7NMoIzcJ3iA
	tjtoNEzBKJl/wR0IWNCDKG7wRargqk2xV54S8kFNp3b6izYl3Qh4LaReGRj9MJTiKAWeJH4wzw/
	ILtn+JDEJIALZoXNAlLzxPleceu6JSnPIIvTEw==
X-Received: by 2002:a05:6820:162b:b0:696:7780:477a with SMTP id
 006d021491bc7-69c955c8051mr14017800eaf.46.1779274324551; Wed, 20 May 2026
 03:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260519020528.133623-1-robertusdchris@gmail.com>
In-Reply-To: <20260519020528.133623-1-robertusdchris@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 20 May 2026 12:51:52 +0200
X-Gm-Features: AVHnY4K2o6NLWZCMDLJg6zJVV7wJlcp01Try26nd1v4PCGJvx45IMb0YFHlPtpE
Message-ID: <CAHUa44GqBpYNxV8AHrj_r7u3cbcTA0xTB7Q2Nk=vbpnxDLnrTQ@mail.gmail.com>
Subject: Re: [PATCH v2] tee: qcomtee: add missing va_end in early return qcomtee_object_user_init()
To: Robertus Diawan Chris <robertusdchris@gmail.com>
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
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.48:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.48:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 540624391D
X-Spamd-Bar: -----
Message-ID-Hash: HGIANCFPB4GQ6CVS6TXTI6LZ45LMS7LQ
X-Message-ID-Hash: HGIANCFPB4GQ6CVS6TXTI6LZ45LMS7LQ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: amirreza.zarrabi@oss.qualcomm.com, sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, me@brighamcampbell.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HGIANCFPB4GQ6CVS6TXTI6LZ45LMS7LQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Tue, May 19, 2026 at 4:05=E2=80=AFAM Robertus Diawan Chris
<robertusdchris@gmail.com> wrote:
>
> qcomtee_object_user_init() is a variadic function and when the function
> return because there's no dispatch callback in QCOMTEE_OBJECT_TYPE_CB
> case, there's no va_end to cleanup "ap" object initialized by va_start
> and that can cause undefined behavior. So make sure to use va_end before
> returning the error code when there's no dispatch callback.
>
> This is reported by Coverity Scan as "Missing varargs init or cleanup".
>
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
> v1 -> v2:
> - Use "break" statement instead of "goto" statement. There's va_end
>   outside of switch-case, so we only need to go out from switch-case
>   instead of using a label (suggested by Amirreza Zarrabi).
> - Add "Reviewed-by" tag from Amirreza Zarrabi.
>
> v1:
> https://lore.kernel.org/all/20260513091031.145826-1-robertusdchris@gmail.=
com/
>
> I don't have the device, so I am not sure how to test this change.
> Thank you.
>
>  drivers/tee/qcomtee/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Looks good. I'm picking up this.

Cheers,
Jens


>
> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> index b1cb50e434f0..60fe3b5776e3 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -306,8 +306,10 @@ int qcomtee_object_user_init(struct qcomtee_object *=
object,
>                 break;
>         case QCOMTEE_OBJECT_TYPE_CB:
>                 object->ops =3D ops;
> -               if (!object->ops->dispatch)
> -                       return -EINVAL;
> +               if (!object->ops->dispatch) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
>
>                 /* If failed, "no-name". */
>                 object->name =3D kvasprintf_const(GFP_KERNEL, fmt, ap);
>
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> --
> 2.54.0
>
