Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB670C43458
	for <op-tee@archiver.kernel.org>; Mon, 29 Jun 2026 08:53:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 29CDD44495
	for <op-tee@archiver.kernel.org>; Mon, 29 Jun 2026 08:53:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fmTz26bU;
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5693243B61
	for <op-tee@lists.trustedfirmware.org>; Mon, 29 Jun 2026 08:53:45 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-447e3abe5edso2269027fac.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 29 Jun 2026 01:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782723225; cv=none;
        d=google.com; s=arc-20260327;
        b=BX+ZnqweOkzX/JJtn1C9OwDYPGyV2kAcqDSMKOWDjDwhzzAL8J0og5Tgw/hoZqrZAv
         LV3gYEortQXmRLp9aZvzw1jx1lNe0xcRYUc1sq2NBVVYumbCkjBLpTFFp7jRg3YUq3iC
         KgMyN7oSKklmR2hnnl2hE3CsR8+s4mJhMz2XC9lW/xZEp8g2s3WHllj8QDwWOPDK52qm
         9BR0tGcEDZtaI+uI/aUUadSBTylwvT+rsmyngdjtql7zQ9x5kqnJD7kAXEbc/ml20DJ5
         VP3Uka4lXiC5cHUMaQli4lCdqPggVG5iI9ZEPn1Lf8a4j5WgZ63uJ7q18ohYJiz0J1/G
         Yglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kom0ZAk0sd+EvCK6HQibq96i7GIy+t3E/vTkY+JP0bw=;
        fh=8EsRaBNfzpDAqdCXCovfOocDUHXxf9pp23Pk6IkjMjA=;
        b=HCKA+X+ynVvMKUoCEMfF/LK+n7bcFiGFJYVKewg/4dzwS8mrGZFjmUPrqAJH0TTlR5
         j/4ChIJZp2xtKK8a6X52RksvdbADOmduE2ygeubFR+Y/sse3yWLd6dqFe1s+3J5VfGgp
         frNlsdsiV8WUbUlZDTbrES+anXhNffgMPp5Md49SVGb9/IWbeXgij4oqXBzWFIOTlduN
         gqsf/A4HK3gka+7vC8pG7QdgfiR6F19lzk4Vqo4uHRo0YJ6czIHIYiS5H/7SIjb6fyZC
         cCl3XDWAH90/HfS6WHx7kwRoy045fM4iZ6cuZ0I7n6vV5L4y0BdCsmwoqRJuXksSWLnH
         166A==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782723225; x=1783328025; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kom0ZAk0sd+EvCK6HQibq96i7GIy+t3E/vTkY+JP0bw=;
        b=fmTz26bUi0lv6l0JtnNLEIqxv7pCy8t/NlEfSOZPV9vGVhaNT5wwysaxv2Q7s4k+JR
         V0xllyrUWxA/LfU2oAokbD4wCBVMfZLuu/4iA25MrRyqNHJ8L46iKblrxMruFwEm/+oG
         LdsRIw4yqaay1rXzzZVLlrQlTi0gjUQ94FfztEwwvnYnBfvvXBouPLWyCzC2+yOEnErn
         nJyYMZ9cQahDqPZnTjyEpdFGiImL/0pqQdksmpSWMn8BtGnQ9M96IO98kqTsc95AZAGA
         6HH62vQBlNaMq3BxyUTBNEZDcvzRJxrM4GY5VqAGbuafW+K/BlhXxSy1E2bOjSdXR6Ei
         w9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723225; x=1783328025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kom0ZAk0sd+EvCK6HQibq96i7GIy+t3E/vTkY+JP0bw=;
        b=YRrhmljJW5rDUht9ZAj+Sb9f1t5NOYGLz32EBE/ETsCv82fu1NCux9+aNVyTMREesd
         VEW5P2S07cpIKisgCq3X2mlhZGpeYY/SAJZ6Fyq2dgpNegUiao+e/t8KwMagqgBm1LXs
         Q1Th1GuyngjhmJRy97N+or4MW3LwOtOMARgQPqMSaA471aCeDYxZRWDULNK24pHFcpDB
         uA2AGOPGEtY89uq8wx96q+DjF7OuP90gPCpgLfKHM/AXCHoYeXrX9oW+E2nODCqes31k
         CzzHj0l63P9cSrKgNm5AZtUIC9BsqplIMyVT0kwI7Mw1U2KbIKJ7LJ1Bn/tL/IIIyycU
         LEbQ==
X-Forwarded-Encrypted: i=1; AHgh+RorY0fZ7yT0bKsFuHW3ghfzzeuN4307RGn1rFeKsQEoJywCyIlUy63bM6PLBWyO+10qnv06yuM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzVxmNCkN3LKfYbmi6XFh7m62tNLkYTvG4bK29theBjgoe3XrvE
	JCkwRgDUr9FTpaqU38/jpVUih7A5GUY6CZo47RR+JOjrOh3Ny6TUi7iuFmJTqt49GahEBqrEooX
	cP+cSMGaCSq3KWhHhz8Q0/07BryAniLhr8gnUFcHho6OU
X-Gm-Gg: AfdE7cmXVITmuVAvB75eZ43hZ2jR3byBxdKyV3lN2HqgQz9ZrkpbXm7SeokFLsj9Hp6
	wQgJTUk8NWsp/Kfv9Lm+8lG3vcs7Jv1B71mNfp8rvb4MzihVJxj1JD7IZOOVufDw9HcJjFHNukw
	4Zds08ZtcD0tM4LuIYvjdDM6ny0kGTfBQC+9dL7RFeS/tEbLABUl0ugJY3QnR9C71rNsafGffpJ
	u3XPUavJX5gyN7YeQUF1W5t97mWVjUHk7gW5wrnYcHzRho4dP+Xd78C31rp5iqZJKBluTf9Len5
	56384upTGgt8od3iYgV3mNLtFXhUroKVb8ZZBg==
X-Received: by 2002:a05:6870:b3f3:b0:439:b99e:4414 with SMTP id
 586e51a60fabf-447aa7368f0mr16814855fac.6.1782723224733; Mon, 29 Jun 2026
 01:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260617145130.3729015-1-sebastianene@google.com> <20260617145130.3729015-2-sebastianene@google.com>
In-Reply-To: <20260617145130.3729015-2-sebastianene@google.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 29 Jun 2026 10:53:33 +0200
X-Gm-Features: AVVi8CdwEgzZOnIaRh41XK3ftF9jm9u6SUDMnMyJOJvWlzRi07xhGUj8Wp9l8xs
Message-ID: <CAHUa44GST=efeDepEHWs_=ehr7JVnkg+y0ZLebcLAGZXxpNegA@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] optee: ffa: Add NULL check in optee_ffa_lend_protmem
To: Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.51:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ALIAS_RESOLVED(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com,oss.qualcomm.com];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.51:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5693243B61
X-Spamd-Bar: ---
Message-ID-Hash: LLJB22OFKXFJQUIQ7OUVDRKXCLY4F4BL
X-Message-ID-Hash: LLJB22OFKXFJQUIQ7OUVDRKXCLY4F4BL
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LLJB22OFKXFJQUIQ7OUVDRKXCLY4F4BL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Wed, Jun 17, 2026 at 4:51=E2=80=AFPM Sebastian Ene <sebastianene@google.=
com> wrote:
>
> From: Mostafa Saleh <smostafa@google.com>
>
> From: Mostafa Saleh <smostafa@google.com>
>
> Sashiko (locally) reports a possible null dereference under memory
> pressure due to the lack of validation of the allocated pointer.
>
> Fix that by adding the missing check.
>
> Fixes: 2b78d79cdf96 ("optee: FF-A: dynamic protected memory allocation")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 3 +++
>  1 file changed, 3 insertions(+)

I'm picking up this isolated patch from the patchset.

Cheers,
Jens
