Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1BDCAC5BB
	for <op-tee@archiver.kernel.org>; Wed,  1 Oct 2025 08:05:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 67BF14320A
	for <op-tee@archiver.kernel.org>; Wed,  1 Oct 2025 08:05:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lSkgYmn5;
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 609FF4184D
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Oct 2025 08:05:41 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-378aa12c13dso1946609fac.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 01 Oct 2025 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759305941; x=1759910741; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U31HGlpwBoWnZHhQQnAISdXA2vo/iclZv4+sjsk6T9w=;
        b=lSkgYmn5EXZctFtTiiv1bSXSka1r+RzBwsGOYUKLX7Z5lMXacXuf5MnK2ZJjSCNsex
         1H5zPF0A9LTB5qtStrDsvhXVFK6LSN7SnI4XVXsPyX5Rpobg6jyTeZILN2bdVhQHRp1E
         ZD2X8q5TzLM55I1k77v0uwXNkXeq4XEDjHwvuzhSwzAghq2O5yB3DN9wXs5aNsOW7DWf
         WIynt2vQ9AnWbZXgEXDAdxEAk+ZYKarka55rM+6IOuI3QuwtPzXoqWJyIAf2eOCWLLHi
         nphw9Rue9nCUSjzq6GZUL8GM2n/qNIc18iO7hJzlr8fuJP+522idkYQFLLvnR+IObT8y
         Kthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759305941; x=1759910741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U31HGlpwBoWnZHhQQnAISdXA2vo/iclZv4+sjsk6T9w=;
        b=Q9hyRqIrUmqKt7cHn1pRrAWt+rhgASTcyvkLm+32JPd+aZQ7dk7trTdSIqkFW06I6I
         CtrQVemP1iw/OjwlR39Ii+Gq/Z7agDu1B60kcvmWI20W6fAaOxIfzSKcSSOvLRiF/M1L
         irdYk0OLkvIisbSyzElDtVq8QJoEIbebYZ8qisgi2qZB0rcn1rQI7eVUfY2pIquE0x1Y
         sbrwGJIK4kpB2i0kDsij+7XeOoG7ekAVfl4brpufKcHy6Ppc+UVK4OCAbRWLbeEhktuJ
         5kC/AUWmp0LvHv7w7hWThA4laxdW20sOCW0epMp+i/PFZjVksqWkoBRPPgvKQAKNGRlV
         gFwA==
X-Forwarded-Encrypted: i=1; AJvYcCVp/R9geyQ7iuKWfVA0rvkH6Mk9+Dt63SBWk0DX3c8d7XRUIH3lEk4ek2mIR/qcQ3VRobzu5pc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwtMG4sA9unSrxGKTjRhe4/eSeOE8gkT3NrEqjRi0n4YU/AIcUt
	0beM5eTL9CoTO2Yz57bbjZEpsoIM1VBFNj4rQOAgX5UMTKfwLOwbXYYaNeBR66NmbeHBLx9Nvqd
	yYnW3p1h76i+76v4HX8hLvL46vR5xzSDRLOPanz5MS2ka
X-Gm-Gg: ASbGnctvkMOuMnlehdsSt6pya6dOxMmOQirUCqB/NUMgJSn6k+evhaIb58oUtoDE5Dn
	k3bvZI64x9qJAi6EkSP9zGxRLreFq2rzrxLKbSejNyaJlshmavgIWrNmJGRjFwTnOX0Ram+L3Fq
	0dcqFP9jjYy0nBDK0/bSoRRwdjPcBXe/M1HzGS5qAUjUGsZ3gpUVdJZNc+40PRBZVgia9B8ZdpY
	0SqvBw1LP64oM61NGKrN8cy5zrPhGka
X-Google-Smtp-Source: AGHT+IEnvNyeLgqgVpt3I3Dj4/Br/sYFCjuE4NNApKeQiVhbUXzgxGO8IoaTn4yl4sB198Mov8VILc/VsJoL/DAQbKo=
X-Received: by 2002:a05:6870:918b:b0:346:865e:d044 with SMTP id
 586e51a60fabf-39b9017c114mr1383746fac.11.1759305940736; Wed, 01 Oct 2025
 01:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <cc9862625abc5b923c5e7c5de20c6f7c797771d6.1759243993.git.geert+renesas@glider.be>
In-Reply-To: <cc9862625abc5b923c5e7c5de20c6f7c797771d6.1759243993.git.geert+renesas@glider.be>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 1 Oct 2025 10:05:29 +0200
X-Gm-Features: AS18NWDrhGkuTq0B-a7sVS3VPWWlOlrt2LtpHlRBB9y80O6Ny_378_esQq5odTg
Message-ID: <CAHUa44EVMO1nR18HqY+PyOJhAcGjgemU9TJdZ16vHbcNERsaUg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Mark the OP-TEE mailing list moderated
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 609FF4184D
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.43:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.160.43:from];
	TAGGED_RCPT(0.00)[renesas];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 3Y2QPAB6VTVMQLXRSAMO5RTESQ67OI3T
X-Message-ID-Hash: 3Y2QPAB6VTVMQLXRSAMO5RTESQ67OI3T
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3Y2QPAB6VTVMQLXRSAMO5RTESQ67OI3T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Sep 30, 2025 at 4:55=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> After sending a patch to op-tee@lists.trustedfirmware.org, I got the
> typical response for a moderated list:
>
>     Your mail to 'op-tee@lists.trustedfirmware.org' with the subject
>
>         [...]
>
>     Is being held until the list moderator can review it for approval.
>
>     The message is being held because:
>
>         The message is not from a list member
>
>     Either the message will get posted to the list, or you will receive
>     notification of the moderator's decision.
>
> Mark this mailing list moderated in MAINTAINERS.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc755a50fb150498..5aa2e501231f2aa6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19115,14 +19115,14 @@ F:    drivers/net/phy/ncn*
>
>  OP-TEE DRIVER
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> -L:     op-tee@lists.trustedfirmware.org
> +L:     op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-bus-optee-devices
>  F:     drivers/tee/optee/
>
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>  M:     Sumit Garg <sumit.garg@kernel.org>
> -L:     op-tee@lists.trustedfirmware.org
> +L:     op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/char/hw_random/optee-rng.c
>
> @@ -25116,7 +25116,7 @@ F:      include/media/i2c/tw9910.h
>  TEE SUBSYSTEM
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
>  R:     Sumit Garg <sumit.garg@kernel.org>
> -L:     op-tee@lists.trustedfirmware.org
> +L:     op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-class-tee
>  F:     Documentation/driver-api/tee.rst
> --
> 2.43.0
>
