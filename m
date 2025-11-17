Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50435CEACEF
	for <op-tee@archiver.kernel.org>; Mon, 17 Nov 2025 09:23:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8776A4FF65
	for <op-tee@archiver.kernel.org>; Mon, 17 Nov 2025 09:23:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fCANWtM8;
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A24CA4322F
	for <op-tee@lists.trustedfirmware.org>; Mon, 17 Nov 2025 09:23:13 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c75fc222c3so307103a34.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 17 Nov 2025 01:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763371393; x=1763976193; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4chC1UhzWHG1RzGT/1Z6xNEi5tzSJCzbJWUJbZLzDE=;
        b=fCANWtM8/jq7cnN7Yu9CGqNcG2G9AVybx0ml6zyRxZlZ/rIMCXsTz0YZF/c1r0qnCu
         KfQaMLzCX8cAJAnekFQgTsgCpNni5ImcOY4LoahEUL14kphEDcek9BoB0NWH2X0EHJxq
         8fQoub+51ImWGGR3cmpWlmJPuVqddHZM5Sb90t1KC/7hU4864JtLeDeUaMADemJ4sntT
         yKN2tueOGrqq28XYSegTJHsICp2qt1P2GULHmnMawHzdUOlEFnhjkMhsKtBw+RHbNDIk
         YHc0mkf7NIABUWDINbovAO7WzpwKPLPypjzQQSg1J6XmITwEKEOE0Ev+3I4rUAqPBa8s
         JodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763371393; x=1763976193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4chC1UhzWHG1RzGT/1Z6xNEi5tzSJCzbJWUJbZLzDE=;
        b=lz0M700jsGcDLfoJgoc3B4Hd2tA3NTXt0Zq/aysBjr600L7/WjMALIkiczatuJVvBw
         wsCR4YlIs2m5idzFUy2NSZ9/Ux5jZHGbKDyxzsuGi/maMtD3tSpZOfrFNzmhtHz3Re2C
         p+3Ok/zQNJISk+8XXulUqbl70EcVRVynNWkUgpphXS2BicZ3U65KCa0Q0a8tL/zOjnJW
         ehkMT8Xa1dJXk1er+zQPwquxRe8fqhI0Qr1g2un5Lunmhtz6d4IbrYNkUziCsPEWDCUr
         q4sgd3LFtndaaSz+9t7uDRTcbwMqMl5XzDn/+ClXQNHcdMssGrSOOWyORzF8LxlpFo6w
         yvBA==
X-Forwarded-Encrypted: i=1; AJvYcCWrI3V6Ln43K0CJRFOFLnJ+BhePo4HETRNFAxLJDTWb7Ok7cbu2diIxSKn956tTK5K9Ub4QDYQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwmjDQogDtNXhfH3/Kd8Fk4+E2kdkfnqKW4c8/DVT1t6j7iMFkl
	35U1cwfZI3+ARM4iYENnFThjsAEhz8mt4SPRG86TR7efFhhAcQGBLRjORuCqudPLKKh1PuZxYKG
	OZnvxy2SmtEh7olMeX0YpwuQ+30NFGgjOIiA95mdrnZIo
X-Gm-Gg: ASbGncu60aw/EOvA0DE/UqA8oqOOtxB8UFs+9r99SfdjLD82EHd/PSUT+JBKwtIzfsh
	cdo8904UwVPRYF8xw8dwil4E4w/aDe+CaR9eXKgfc2DRmlDVV4e5/DKt06LJa9ZcUDftSQC7P+R
	iUgYio6yALfNVmnicDhZPj4UeBKQa4L1b7gatv6DN4pwMw690Tv9r1UN24ip2ubxI9nPIDq5Qgo
	anre4Yz2ztdaTETDpE9W50sgwxUmgVLvgRvYt8jMWypbmqDRuAHaoCdH60KWZUR5lUOzw==
X-Google-Smtp-Source: AGHT+IFx1aobTjTOI8ZRdrI0Bw6ObhW09daX2hM3HwlY057J92B1d/Buq4CAcijX9jS+ZbaU0OkIProQV+z6GMnaMYM=
X-Received: by 2002:a05:6808:2182:b0:43f:5552:1e7a with SMTP id
 5614622812f47-4509743a3f7mr4635755b6e.29.1763371392833; Mon, 17 Nov 2025
 01:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20251113-qcom-tee-fix-warning-v2-1-915a460e7d21@oss.qualcomm.com>
In-Reply-To: <20251113-qcom-tee-fix-warning-v2-1-915a460e7d21@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 17 Nov 2025 10:23:01 +0100
X-Gm-Features: AWmQ_bkPAg3yOV5rQU_WBqbrbqLrRN6sXdiJvxHXUM0qS-Qn2nmmQQu7FERO02M
Message-ID: <CAHUa44G_5jRy8YfDCAFKoR1+ODn3kOJh=XDdjS9=bkXEgxV9-A@mail.gmail.com>
Subject: Re: [PATCH v2] tee: qcomtee: initialize result before use in release worker
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A24CA4322F
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.50:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.50:from];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: KLKQ7MBDWCFHEXRFVH7WZIGPVZS2ZIEP
X-Message-ID-Hash: KLKQ7MBDWCFHEXRFVH7WZIGPVZS2ZIEP
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KLKQ7MBDWCFHEXRFVH7WZIGPVZS2ZIEP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Nov 14, 2025 at 4:38=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Initialize result to 0 so the error path doesn't read it
> uninitialized when the invoke fails. Fixes a Smatch warning.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/op-tee/7c1e0de2-7d42-4c6b-92fe-0e4fe5d650=
b5@oss.qualcomm.com/
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
> Changes in v2:
> - Update subject to tee: qcomtee:.
> - Link to v1: https://lore.kernel.org/r/20251110-qcom-tee-fix-warning-v1-=
1-d962f99f385d@oss.qualcomm.com
> ---
>  drivers/tee/qcomtee/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> index b6715ada7700..ecd04403591c 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -82,7 +82,7 @@ static void qcomtee_do_release_qtee_object(struct work_=
struct *work)
>  {
>         struct qcomtee_object *object;
>         struct qcomtee *qcomtee;
> -       int ret, result;
> +       int ret, result =3D 0;
>
>         /* RELEASE does not require any argument. */
>         struct qcomtee_arg args[] =3D { { .type =3D QCOMTEE_ARG_TYPE_INV =
} };
>
> ---
> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
> change-id: 20251110-qcom-tee-fix-warning-3d58d74a22d8
>
> Best regards,
> --
> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>
