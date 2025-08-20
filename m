Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BBFCA0EDC
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 13:50:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 14F7245A35
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 13:50:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ijUwLHTA;
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F02E64586A
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 13:50:19 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3110269717aso473353fac.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755697819; x=1756302619; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzX/17pyMpa2e6eM2GLdw28Qud8BAqCWhIEZNS4QCh4=;
        b=ijUwLHTATZ78L9RwrH3fjL0T0ju2ciq2iV1AowZvT6buLKq/3TYUcRbwwx4dhr5ck8
         3QxEcv+RWwoBIgrW/rstLgzpkUmFjZV9L6+9OCSuz4+CUKRKl+F4dekxWJABUKIgjeTO
         dioTW/X2IxuvURa25onaocuXeTfNcHJgQVzDk/l1AmVw+LH9PYPUbNpjcPRpFDNas0dE
         KWm2samaZCNHuptCjtD0O5uaVGcDbiNYXdQDGzP/76cN6uH53xHpZFybbo476Lp5gqop
         xj5vQ7kKiPn3ZNOkeOSLAUBlbUEcalf6Qx30xVh7Wh2n2EGd6PwsMQ3Ij5jY2KbOnMFP
         EW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755697819; x=1756302619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzX/17pyMpa2e6eM2GLdw28Qud8BAqCWhIEZNS4QCh4=;
        b=dBzSdD1go1RnAROhUm+nplxR/E9ijEAF0stX2IDGUv9gS/zMptYBWNfQm06MSrxIID
         SjLq+84YRTayZu+c8c5PzL7wZmJs6EDmC7PKZfOVjmAdPexbBskW4S3/BHWL1Mic8drM
         eeNWDiZxq2hIE9v9gOEQn0Vm/Kuvn/ax3gk3lf1akwHsKs9q5Js0xQYmQ75WgXtKI0NA
         WFX6M+IqOaRygaZRRXhadkhrMUL+Vs0yH4fJpRLSSpT3ol5DynhEcTsAz7wUvd7DK5ot
         Jdtb+PDl65d2cmXqSGYFLaglAughnWkztDaj5CJz7AgoUVCxrAtLBVY7lIktLZHm8ufH
         oKpw==
X-Forwarded-Encrypted: i=1; AJvYcCW1cYCMw2n5Yxr3INrEaP5Skp8NC85cvOQ+kDPGVggCVpUIpSkZDAVLsJW+m0gR8wgaFLXYAxw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyilFLQsuk/L1MGkMttktd+Cq2C9J3oXRvAWmGwtEwsWhbRIOKA
	vqTcg7hAC/A54jQRHbH3kKBe/h/+WBL+68n5+nQ4uhSOVIEKK8QCvoyikiXaA1feBM2LuWHaZtU
	ecQJ/+pbx+VwlbxGjdSNVsn0DQ9sdHzOo+S1RDdbwFxTf
X-Gm-Gg: ASbGnctLsTlycPPs5wv2gnzoDQVMs+CXQTuF44FJ4lPIyCcO+pu0CfB5qAQVRvM9fYR
	0yGnZ7uXEa1dV+r0WjmB59aXlc15ZBNmqF4Btugm8TFbhwhMhcNryxxOZDNjTOrYO+CxWlWvmUK
	LZBZwYacgoZl2GJKlEmyJ25AwTBNNonixb2ERDxW+PmScvDxjEw4OeW/NCC+QknW6T22vR9+Tp0
	lBwcL6Q
X-Google-Smtp-Source: AGHT+IF53EPFsX+3+UATYYqAJj/8LhzJm3YmHrT891PtT0GBbz607vnrSqoW232rr7YfWix5QjKI+49YjNugoECGQiU=
X-Received: by 2002:a05:6870:670d:b0:314:9687:6dcb with SMTP id
 586e51a60fabf-31496879229mr1000066fac.21.1755697819242; Wed, 20 Aug 2025
 06:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com> <AS8PR03MB7189020F4559D0F821C4502B8A33A@AS8PR03MB7189.eurprd03.prod.outlook.com>
In-Reply-To: <AS8PR03MB7189020F4559D0F821C4502B8A33A@AS8PR03MB7189.eurprd03.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 20 Aug 2025 15:50:07 +0200
X-Gm-Features: Ac12FXxQY4Ay51T5kJf2PX4lpAC1-HxCTyOwkFyD8JTP-JER2p8BJeBHoI-0aGo
Message-ID: <CAHUa44G2gG2mMGXEVLvR_C6SsxZuH+gQ5004xXYcgqTEEiDLbw@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
To: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F02E64586A
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.09 / 15.00];
	BAYES_HAM(-2.99)[99.93%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.51:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.51:from];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: S6AAAHZ6C4MOBVPTVZQGO6CC2JXT2BKR
X-Message-ID-Hash: S6AAAHZ6C4MOBVPTVZQGO6CC2JXT2BKR
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Lars Persson <lars.persson@axis.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/S6AAAHZ6C4MOBVPTVZQGO6CC2JXT2BKR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Thomas,

On Wed, Aug 20, 2025 at 3:09=E2=80=AFPM Stauffer Thomas MTANA via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi Jens,
>
> I analyzed this a little bit further since last time I wrote. Here what m=
y "believe" at the moment is
>
>
>   *
> Linux uses the non secure timer in arch_timer (physical/virtual) -> this =
is correct
>   *
> OP-TEE uses the secure timer (physical/virtual) -> this is correct

Thanks for confirming.

>   *
> ARM Trusted Firmware by default enables NS_TIMER_SWITCH=3D1 with opteed, =
this IMHO unnecessarily stores/restores time registers, setting NS_TIMER_SW=
ITCH=3D0 seems to solve the issue, my personal tests and also xtest did not=
 show me any issue so far
>
> All this with some uncertainty, I read through quite some code, but I cou=
ld have missed a case, where something may go wrong I did not see.
>
> Latencies I tested with cycletest. With NS_TIMER_SWITCH=3D1 this skyrocke=
ts (and explains all the other negative consequences) with NS_TIMER_SWITCH=
=3D0, everything is back to normal, even doing "heavy" operation like creat=
ing 4096 bit RSA keys with OP-TEE.

This and Lars's findings clearly indicate that we shouldn't set
NS_TIMER_SWITCH=3D1. I'll propose a patch.

Cheers,
Jens
