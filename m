Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EFED29FED
	for <op-tee@archiver.kernel.org>; Wed, 14 Jan 2026 10:59:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E63E2432A3
	for <op-tee@archiver.kernel.org>; Wed, 14 Jan 2026 10:59:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Cu4AVKWZ;
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B254F4329F
	for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 10:59:26 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b86f69bbe60so488825066b.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 02:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768388366; x=1768993166; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFps+v9jazCASBDOU/OxQDkMTtNaPUhLd3nvA/hGw5w=;
        b=Cu4AVKWZnl6HEVHx52FyQPbCsd0cvX1Xgtbv+3vFQJ3RJWEOHnxyNlNxQLBWC/gmDP
         yUOSH65NUXuIwr9ZTh++YFjwDafNDOzFyYZA6V4VWwGwSnWQM5CTqgP0n013h90R7Vul
         zoxMfp0JDeWe0pFORQUv9YEy7fCRHK5rYBPn8T1btPok/dxKA2zNKgRAqfN+A0BKVIjN
         qkpyfnzjcf3hOmkIxf+4ge5noJZ6fkBHfqBhZ0CS5RoDVK3VfFV71t0OIbJZWaufMP2L
         TAUtidvNweHcSDiNMMLJm9VXYxWnMpHG6JNROmAwC4BgqivZ4JSYXP3q+uEO7oC6ZbBv
         uSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768388366; x=1768993166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFps+v9jazCASBDOU/OxQDkMTtNaPUhLd3nvA/hGw5w=;
        b=hEzidZO9S2p8YOHwr0tFqqsOOZPIcwGhiTEOlDN/IYG1tAFT5VR+SfYoH4spcboe+a
         YS4XStGM5f9RNI2YOhpDMIgW2azcDWzu3wAIkSx0sLTDs+etMgA4x/8eJXMCVMP994zR
         v99BS9gTZTmsZgIi/HveCCaGsG1pdFiXvL/VPK7dgthV5652ZTv7cpZqia1p+KQRlR9i
         G588yu2kCZ3ZM5LLd7yMNfBKOKlqTvIlQCcHdK+7ng7ssNBD9Xr8ktib1xjh8cxYH9wd
         U820YFY6VGbBQEyAXBjjIOgJmub0lwviuzWQRflZeiZhG8TRV/3CFWL8HfDoL4rSOPFj
         bDzA==
X-Forwarded-Encrypted: i=1; AJvYcCWgGIN+b+kpRbF+ls5FH84ETd/VtKKLwxTNsBSzaZATQPvEfZydmiKTu/6UtZQeNQ12QxKX2r4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwqaNw7qJvOyQzgw808C67S+nVzGisGTIh2JL9QoYAquKK7u4kK
	SFUTOyhnKxBMwnR2Izj7+TF11YpBQZVxAmgXBbSGkbgLJF8Dw044SnntZKr6uQejp5v7EHZiHeL
	4VN18uMgueKBE3ZzI3MFLSr/BArZTwo4zot4Bwqu9FEv+
X-Gm-Gg: AY/fxX4Ny0F0S3NLz8nn/Rm30gzdH0TffsOKADv5bXu1/yTHHQVyGiSOdFhtJvCiJ0e
	QfEpEZejlLJODlfe54z/yPYzNm1gqxelEpMHPHes7ooCzcJV09bHqYA4puOSswZ2i+LizeUzMKP
	xv8RZ4GJMKEi0G+GOqcfysiXr28DdoiBktdXginhduLzlIfnAeB+2G078s/U+TjW0p3h62N5V2o
	SJeYqscTgmdALMTZ1YdcCamHDrXDBu4DDRd4ES+XjXh9a8kI4WQoK036Hxzw8bILNB7en8Fd/FU
	+cXMqMUwkY//eM1k1/XntNYdripeR1lZ3jx6
X-Received: by 2002:a17:907:1c13:b0:b84:365f:10b9 with SMTP id
 a640c23a62f3a-b8761080f8emr180065766b.29.1768388365597; Wed, 14 Jan 2026
 02:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20260105124944.47817-2-thorsten.blum@linux.dev>
In-Reply-To: <20260105124944.47817-2-thorsten.blum@linux.dev>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 14 Jan 2026 11:59:12 +0100
X-Gm-Features: AZwV_Qg_vZEa7ZPCPuT0LFzNYDP4QHrxuetBEDHQnnqeG2atfy3TwZiZj9srNns
Message-ID: <CAHUa44GMsDXL6OOc8nx4OH86-U5MizURW-2bpFnz_kp3+tKHNw@mail.gmail.com>
Subject: Re: [PATCH] tee: amdtee: Remove unused return variables
To: Thorsten Blum <thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.218.47:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.218.47:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B254F4329F
X-Spamd-Bar: ----
Message-ID-Hash: PB6YZGER5A2GL3RAGA7NQ3VM6LCPJK4G
X-Message-ID-Hash: PB6YZGER5A2GL3RAGA7NQ3VM6LCPJK4G
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PB6YZGER5A2GL3RAGA7NQ3VM6LCPJK4G/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Jan 5, 2026 at 1:50=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> In tee_params_to_amd_params() and amd_params_to_tee_params(), return 0
> directly and remove the unused return variables.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/tee/amdtee/call.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Looks good. I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index 4c21b02be4af..460b0c9e511f 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -15,7 +15,7 @@
>  static int tee_params_to_amd_params(struct tee_param *tee, u32 count,
>                                     struct tee_operation *amd)
>  {
> -       int i, ret =3D 0;
> +       int i;
>         u32 type;
>
>         if (!count)
> @@ -66,13 +66,13 @@ static int tee_params_to_amd_params(struct tee_param =
*tee, u32 count,
>                                  i, amd->params[i].val.b);
>                 }
>         }
> -       return ret;
> +       return 0;
>  }
>
>  static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
>                                     struct tee_operation *amd)
>  {
> -       int i, ret =3D 0;
> +       int i;
>         u32 type;
>
>         if (!count)
> @@ -118,7 +118,7 @@ static int amd_params_to_tee_params(struct tee_param =
*tee, u32 count,
>                                  i, amd->params[i].val.b);
>                 }
>         }
> -       return ret;
> +       return 0;
>  }
>
>  static DEFINE_MUTEX(ta_refcount_mutex);
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>
