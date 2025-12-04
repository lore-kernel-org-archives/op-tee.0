Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A6CD20690
	for <op-tee@archiver.kernel.org>; Thu,  4 Dec 2025 13:28:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8FEF650043
	for <op-tee@archiver.kernel.org>; Thu,  4 Dec 2025 13:28:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JBho27Vu;
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 30C8E43075
	for <op-tee@lists.trustedfirmware.org>; Thu,  4 Dec 2025 13:27:58 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-65962c714eeso507749eaf.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 04 Dec 2025 05:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764854877; x=1765459677; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRNI2GngROAbMHhooaeidrwp91WrmVmozMVfUeKXecU=;
        b=JBho27VuHXuSIPIVVtUs5iSn64AozDIHT9puE1+2MGo9gh8sog7pXPYlQfMsf3wTAd
         nQG/kZ60mwZvm+SsDdLmr0IkL6k4h+v6XvE8iX4pYQKrd0Nk/h5uimx7SFEQ/MJODP/i
         uWhnwkgVw/dJ93jCm/wHbdpZFeN4mkaNGJEnoX0x6uwKcBDAT+oGHKpHeMhlXgEzZSpo
         S9rKaZuhnzNYjEeVPNm3Oh0WQdaXEPRe49hrTjh6HMpGaCQj0TZ2XFjzQx5OXkXkZyGn
         mOfaJkg//sJ77kqiwiuNqHkN71hPAySannRXr3sabtpODbIBM2VebjjfEtHrT+SeZjiH
         lJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764854877; x=1765459677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TRNI2GngROAbMHhooaeidrwp91WrmVmozMVfUeKXecU=;
        b=E3hQ9sBqIs4owwUMujGIs9cXG8UmksuhPRtDnwCF9YJkheUTY9aiRjyrVsRenk7dfj
         L9ix8CsgStvX77/5k4DAUz1pCr24vjb6ClXyyc8E8rRxQMb2UjPlQ1iczyWsBT/tOALD
         P7VAfzMq7D26vFjY+K5y4C5KRGzd7kNOsZI+EEBaWUAPd0hwa2bT4luGWWLCSPN8tcCY
         8hr6/NE+tXjFuhoTrM2KK0HATneS3aH3PzmgQbwKUdOBdxVoo3DRryI9XwkrwVcLsm2x
         fy4SxjvxxVY+05lIXY+f03hEl+40Wc4YGzyccTycDEUQQohLB1LX3UV4HGTon2nPxAne
         8RaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2KSpamcIZsX/kaSrAtojiJyCpIjO6Z4ydod/X2fiuYk5uucn/I8+h42BVGobmnquh907ECug=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwAJ4Jx9ZbKFVCI4SEX4fSVyWquh97bDpqzBozuYAPpL2AVAObM
	SoZLJ0QDtfGvFqCh20FDX6e+zQ5ZDS25r9BPGqexSKBp1JX0NBGBhqJJmqeHnGCHWFsVIgLgQY4
	SoY2m2l1z2HWHRlOV408whe89QbrbOX1R9cdvFSOxJXfB
X-Gm-Gg: ASbGncuh6Fpr+b080KyRPRbWl/FS4Qnss2lcGEi/liKkMwNg0y4/Hy7sWI6EWaNIw05
	VvbGzx+Y55qCtWNY63ZGLkPzaZ723+BT0wIk66nGDvhv4OKs1wQk0Ir/NlsJaIFZ/Vukd79hYlq
	yvefH+QR6xqHxp0PU6+Z4L08C3vBErcTMYYhRPr00f1rypGdB19HjveGlx2j1dc15uvM3Ps0yHC
	w3hUZ1sOTn3yEiPgvmvGqrRYzQQgJAQdMLzi/obGum6iT1od35q+cGbJoqUyl3bnrDEPOzCGSrm
	5ZUVnlcNeeFlrWZKs8NFhTt9wCuyYhIM/MW4
X-Google-Smtp-Source: AGHT+IFE0WHEsoH4r/5yGkoBCcbCLiaOv8+DdubyNxb7JgCyTy3EXLKNZPZtGfXilMxcjQUuTBPNLLSzQQGQpDdkiAs=
X-Received: by 2002:a05:6820:2289:b0:657:5f19:55fa with SMTP id
 006d021491bc7-6597b4d8098mr1587072eaf.3.1764854877385; Thu, 04 Dec 2025
 05:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20251204101730.1036671-1-arnd@kernel.org>
In-Reply-To: <20251204101730.1036671-1-arnd@kernel.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 4 Dec 2025 14:27:46 +0100
X-Gm-Features: AWmQ_blmiz1umR-cV_gCGB3wL15iwJgHmYeYQznK94DqSfYPLJnQazL36er0_uo
Message-ID: <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 30C8E43075
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.49:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[mail-oo1-f49.google.com:helo,mail-oo1-f49.google.com:rdns,linaro.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.49:from];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: 7B376CTP3627ADZFGS6PXJCINF6LHZGK
X-Message-ID-Hash: 7B376CTP3627ADZFGS6PXJCINF6LHZGK
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Sumit Garg <sumit.garg@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7B376CTP3627ADZFGS6PXJCINF6LHZGK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Dec 4, 2025 at 11:17=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The tee_ioctl_object_invoke_arg structure has padding on some
> architectures but not on x86-32 and a few others:
>
> include/linux/tee.h:474:32: error: padding struct to align 'params' [-Wer=
ror=3Dpadded]
>
> I expect that all current users of this are on architectures that do
> have implicit padding here (arm64, arm, x86, riscv), so make the padding
> explicit in order to avoid surprises if this later gets used elsewhere.
>
> Fixes: d5b8b0fa1775 ("tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The new interface showed up in 6.18, but I only came across this after
> that was released. Changing it now is technically an ABI change on
> architectures with unusual padding rules, so please consider carefully
> whether we want to do it this way or not.
>
> Working around the ABI differences without an ABI change is possible,
> but adds a lot of complexity for compat handling.

This is currently only used by the recently introduced qcomtee backend
driver. So it's only used on a few arm64 Qualcomm platforms right now.

I think we should take this patch, but let's hear what others think.

Thanks,
Jens

> ---
>  include/uapi/linux/tee.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index cab5cadca8ef..5203977ed35d 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -470,6 +470,7 @@ struct tee_ioctl_object_invoke_arg {
>         __u32 op;
>         __u32 ret;
>         __u32 num_params;
> +       __u32 :32;
>         /* num_params tells the actual number of element in params */
>         struct tee_ioctl_param params[];
>  };
> --
> 2.39.5
>
