Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F5FC43458
	for <op-tee@archiver.kernel.org>; Mon, 29 Jun 2026 08:52:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1EBB643A64
	for <op-tee@archiver.kernel.org>; Mon, 29 Jun 2026 08:52:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rbvU+bxA;
	dkim-atps=neutral
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5935343A64
	for <op-tee@lists.trustedfirmware.org>; Mon, 29 Jun 2026 08:52:13 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44856d185bcso1038733fac.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 29 Jun 2026 01:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782723132; cv=none;
        d=google.com; s=arc-20260327;
        b=OTvVa4olASBjmdr/ebwmyh5CzhPC09DRIq+WFcWFUs0+yI1k2qnY95b4Je0R489F/Y
         2qotzxWyteB7ZGbFnj1Lbladag4wJqLIWPl+dL6nhWVgjSRasfrctpsDj+6F6ctL5gJa
         hW5jXQfgaSzgm7JRaZ16SBwgsDHDTBdzXLnS4KDvWNbSwSBtHfmb3ccgSg2fhJ0l3E04
         6WdkEAKgUrEbDtlmELjmeb7u2Nsb9qnmlam6eEjO0YqiO0nQf35IZ5fsOBy8QfZwyI5I
         pPOFUZLjRvgyYwaAnuI7IVZLRU0A9LNyEG2ouKNcUmVECu8v5Ij4WhM+a53N4HGh1s1b
         HW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y9ZxLhU2U6aTSHaE5FzsqHEIaPLJ2cfQHxau9k3+eoc=;
        fh=quBjgHnQCyOXr219ALs7C+iFypa8LoqyI6ITZjvqULo=;
        b=LKIkVbuJ6qKLuqIn6+rhsnpH69hiviGVS2d9owcQsZ90W93HO3R6FpSkbzNF6h64du
         46A+nwX2KxQmcXDEfyoqvX8EvSMuv6rdNgXYTQ8cCPU5m6twOE7/2BMk9lJvqYuodL35
         OZnMo4ox2PHDxIKH+eNVbA9L6SRxMCO8i9POf4V151yw9ySgXkkwN4yaNjO6znkz6twW
         YsebyZNG2duIXEopwJGxH4DIm3/cAYnGo8NMFeAprOa80rxqmhN8gxnF4SJwQpBwEN5L
         LByUAD7SWQ9TmdR+62i9Xe4NyCijsH9fMyRTE4hl4wxJ5HRAXRGEOFCdFHNR1qnli3F/
         Qihw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782723132; x=1783327932; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9ZxLhU2U6aTSHaE5FzsqHEIaPLJ2cfQHxau9k3+eoc=;
        b=rbvU+bxAJaXcW/vqnyB9KQsVqSS1l0Z1FwsTH/gCoXDXs6VsCXGxLxkx8hP9Snx8Sy
         8yHvZdqjJrjy2sD22EHIwGZl+aB9vQjC3dG+IJ+6YVlihjQb0ijkhVLHlp65JIcJ8fZh
         rlFARrWvSg/FmNYnvvAsomzIz+Kdo4K9KPCMRxJgMdxstMx1Msrg47gOsWUg08PbIgpN
         4A+D3zwYTQVkH08rbebJ/lDkJvZMrKxJD8HiCm19dHu55d/sA/MaXBYy7fJ/DJEmWflo
         /McIw8yIZvnyRTu+xIJKn1QarcjdcKSlngc73QZ8gyBrTjgP2hLJDeGMUaBnga2aF+kb
         s+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723132; x=1783327932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y9ZxLhU2U6aTSHaE5FzsqHEIaPLJ2cfQHxau9k3+eoc=;
        b=T/oQGldpmIz4FfCOdPvhszlxn7vHzQUFcyWxyzOW5ra5Y5/50fSof3vcFgVkNFnn9E
         Xz+Q8lkFPwPjrSn9NNwnPgtfq3AHE/2bekn9SRtAdet5iHxkNKsa03E3vj7ONVwuNm0x
         ZMOnahibI5c5pr4FUnd2soBdFik8bt5OgsJCWXaGbGDtZZACAJZ2c9cgd4LReXq2bWaV
         unMMrQVcHOlV2b6eISwIYezuSagGWSBzC/3MB4ZedRKCC3ihzcrvo4lTPq78ZF1UeKot
         lma2zCjat42UssFocw3bODZ5TyfRQWGtZVuiD51t3gRNvH4BGKCdmuCufWLOo/ZNubEE
         5tmA==
X-Forwarded-Encrypted: i=1; AHgh+RopNQb7Z5rGfSuCXnTRofE8071V6S7rHIoP9lnEdL4XPtQs8U672iznoSl+xI5iStlu3t4ltgY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxDmHeyj/jNltGnTJBU9WI3z0laJRXlXlvxW4gWRk6Q3CFixcOE
	9i4Sv7iZW7PUsC1Q/DLAFDyytNTK1lyHPuI6ASqVqBS0X3s9EcVu7ldnMFifQtdsZRB3mEuOYkk
	m8C2StqIPAh/3CTwGbXWnwasBGUSb5Ug6ISr9d2Gq3dls
X-Gm-Gg: AfdE7ckZi05URkrq+XrtBChEGWcVPZoGCfmD84hAZlLWPp+Ky75PNJh0XXan2Qn/4vV
	mPA4/tTxUwi2zu7rs2KgfaCBKMAOMrQU0eeTMUw3bK58kkhwAsablv0PT5zDBB5blDPak5wqYu8
	FNFA1EZQ/JlDvaFjGfih/KtGlP2F7AJhaBuWzcsgsjxOzwxWI6vrmVob1765IfcrjzOf9F/7etH
	W9/wYzFqubLlNiE3WfkwWOedYGwbv6+ImzK4BkDpwaRYHeJ9IzfffIjpvYxpXqeEsPnh/qRnwlX
	j/5iaNbvSvFGn+j92T9qbiHs70Q=
X-Received: by 2002:a05:6871:d69b:20b0:448:94d5:4613 with SMTP id
 586e51a60fabf-44894d57d7cmr2016145fac.21.1782723132556; Mon, 29 Jun 2026
 01:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <c21803b3f2ea1522bb930dc1dcab79c2627f2234.1781620559.git.u.kleine-koenig@baylibre.com>
 <6971c4b5-d091-4fe2-b843-60da8b32d48b@oss.qualcomm.com>
In-Reply-To: <6971c4b5-d091-4fe2-b843-60da8b32d48b@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 29 Jun 2026 10:52:00 +0200
X-Gm-Features: AVVi8Cf9Dg1W2tIxLlKyndn6lwaOcvF8bdsQXMuosnhYqSdzUe5bJ3rxXPwAHhQ
Message-ID: <CAHUa44H-Pu9MMxpFyNPBZHw4gcqczss0AzEXQoaHpLWbetAWJQ@mail.gmail.com>
Subject: Re: [PATCH v1] tee: qcomtee: Drop unused assignment of
 platform_device_id driver data
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.160.48:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.48:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5935343A64
X-Spamd-Bar: ----
Message-ID-Hash: OFSL773BDCLP6FGPLMAKWEYUTGPKN72U
X-Message-ID-Hash: OFSL773BDCLP6FGPLMAKWEYUTGPKN72U
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OFSL773BDCLP6FGPLMAKWEYUTGPKN72U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Wed, Jun 24, 2026 at 5:39=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 6/17/2026 12:38 AM, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> > The driver explicitly sets the .driver_data member of struct
> > platform_device_id to zero without relying on that value. Drop this
> > unused assignment.
> >
> > While touching this array unify spacing and usage of commas and use
> > a named initializer for .name for improved readability.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig=
@baylibre.com>
> > ---
> > Hello,
> >
> > while this is a cleanup that can stand on its own, it is also a
> > preparation for a change to struct platform_device_id that requires tha=
t
> > .driver_data isn't assigned by a list initializer.
> >
> > Best regards
> > Uwe
> >
> >  drivers/tee/qcomtee/call.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > index 0efc5646242a..4a597eeaf174 100644
> > --- a/drivers/tee/qcomtee/call.c
> > +++ b/drivers/tee/qcomtee/call.c
> > @@ -798,7 +798,12 @@ static void qcomtee_remove(struct platform_device =
*pdev)
> >       kfree(qcomtee);
> >  }
> >
> > -static const struct platform_device_id qcomtee_ids[] =3D { { "qcomtee"=
, 0 }, {} };
> > +static const struct platform_device_id qcomtee_ids[] =3D {
> > +     {
> > +             .name =3D "qcomtee",
> > +     },
> > +     { }
> > +};
> >  MODULE_DEVICE_TABLE(platform, qcomtee_ids);
> >
>
> Looks good to me, thanks.
>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

I'm picking up this.

Cheers,
Jens
