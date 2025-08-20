Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E27CA0EE4
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 14:46:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 212894FBA5
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 14:46:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kAmuiI8m;
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 66F7842D3C
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 14:46:19 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381ffff9fso2804509a34.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755701179; x=1756305979; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxU7332taixNGD2C6uN/nPv6N37qO4ptiKSM6A/kVt8=;
        b=kAmuiI8mETzBjNwKAt4YISwprOZebjOTOrDrQEeqXuNR7LGNexHax08toEn8iLTJpo
         PiTDQ3UKy/mEINwfIp6aQvDYiEFeu4hrnkko0QuuN1LyFC97XOvcWwqn+gRncXL31v50
         Ve2KHRtzvi2bxLwDmhJ7VVMxC/l+H5cWqV5Ii7TEARH1OGRjJ5doVQLMIVB13Sm5pAPc
         jW7b+pI9fVlYfs3nrh32Tce2Epi2TvQy9p9Y+cGFbhtki4Ebg/QGs1CA3SOPx9mI8gnA
         kC3c8UbAbmjRt2c92yOw0dmhs3KIS6idnBqtTZYuAgthS0M8na/VKFoBblxf1lZk3gv0
         8NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755701179; x=1756305979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxU7332taixNGD2C6uN/nPv6N37qO4ptiKSM6A/kVt8=;
        b=luET/uKMXDWRYa5dUMYA0b/vrRo+CdiBbnb2ZexJwz/pV+f7SQFkg3fpeLR7rWqn+g
         O5tSaYUvOcVctnryMDEepX9RleciMrKw4iL+jgWbBaoo544IdHTi5KgKrshPE40xNJYr
         /YZjmFYpGotbMtOXBeVUlfE1xz2ldIbc8GPzCWKf0cHq9wYfkUW8pfdTNu2NEubPnTJY
         upaNlGhMI2r63tEtAcJ84t2rNLmNlomyuXHiCaOQhIhyNdeZI9Y3wyObCW+X06y+R2WS
         C7YGlIOvt92S8YmCN3RLX1bNa3OquLbHMYaZx92yw/ryDxQpfhemOQNunHylnZgiH7DP
         KIiA==
X-Forwarded-Encrypted: i=1; AJvYcCWjkdt3kaAE+ErLdPiwWWjUIH1QP0yMLnMYIjYTpD18iUqfVjfLfJI4jbS+sxj3cv+39VFY19w=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyCcQe6RB99ZiZuRQoKcznVy8Kcd9Qu4a27/GkdT+P1jl9UyD78
	CMnNNH8xfyfG6K8i8NV3+e/ryipO+d9+A1VBh74GTQ1syc+p34ZT9NcSfvXV42meBJEUfZOEEBD
	fqHsIkmqIkND3RFcs5fjgD05Xx6hIYTYo7O4G7fIDipV7
X-Gm-Gg: ASbGncucn2i+L/DcPxIyPQvtcsL8GXfdgtwBXftp6LFL4+XjctbIhOfp3JSgEVh80lH
	YGHHrZVA6FVRe3btnfnYDFOUlKPVPCmX4fFGUr9QiYBE/pRpnLurUXd4CcL4N9FZuaGtPDmmQPq
	jF2AJdG+TaPkvJLKlOFv5KDUrVi+D6LXvpAHLqeNwtMD+KmPKSLkRnCxFGhNkUg9lsghAETRpKh
	sqXiU6k
X-Google-Smtp-Source: AGHT+IFUurn65PTgOS0CgFEwwvRbejuU5xXVS7fNCZAtHyu4m9kInPA6RorIcPjYKFVnimA/71FiphB5gAGbr8bIgL0=
X-Received: by 2002:a05:6830:4197:b0:743:8df6:3279 with SMTP id
 46e09a7af769-744ebba5c56mr2054858a34.14.1755701178709; Wed, 20 Aug 2025
 07:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
 <AS8PR03MB7189020F4559D0F821C4502B8A33A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44G2gG2mMGXEVLvR_C6SsxZuH+gQ5004xXYcgqTEEiDLbw@mail.gmail.com>
In-Reply-To: <CAHUa44G2gG2mMGXEVLvR_C6SsxZuH+gQ5004xXYcgqTEEiDLbw@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 20 Aug 2025 16:46:06 +0200
X-Gm-Features: Ac12FXz2e8VOIQc7nluKQ2CSmhfsZiedaIq4ObgCITkJnKrTDzB7uNrx7zfuPnI
Message-ID: <CAHUa44HJXAR=Hy6K8du-FmoPuMqddq6cnOQe=uK=et9Hnn+e2A@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
To: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 66F7842D3C
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.45:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.45:from];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: WYGMNYNIMOT4GUVIMQFCQL7YQPNVFQAT
X-Message-ID-Hash: WYGMNYNIMOT4GUVIMQFCQL7YQPNVFQAT
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Lars Persson <lars.persson@axis.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WYGMNYNIMOT4GUVIMQFCQL7YQPNVFQAT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

FYI, here's the patch
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/42078

Thanks,
Jens

On Wed, Aug 20, 2025 at 3:50=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi Thomas,
>
> On Wed, Aug 20, 2025 at 3:09=E2=80=AFPM Stauffer Thomas MTANA via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
> >
> > Hi Jens,
> >
> > I analyzed this a little bit further since last time I wrote. Here what=
 my "believe" at the moment is
> >
> >
> >   *
> > Linux uses the non secure timer in arch_timer (physical/virtual) -> thi=
s is correct
> >   *
> > OP-TEE uses the secure timer (physical/virtual) -> this is correct
>
> Thanks for confirming.
>
> >   *
> > ARM Trusted Firmware by default enables NS_TIMER_SWITCH=3D1 with opteed=
, this IMHO unnecessarily stores/restores time registers, setting NS_TIMER_=
SWITCH=3D0 seems to solve the issue, my personal tests and also xtest did n=
ot show me any issue so far
> >
> > All this with some uncertainty, I read through quite some code, but I c=
ould have missed a case, where something may go wrong I did not see.
> >
> > Latencies I tested with cycletest. With NS_TIMER_SWITCH=3D1 this skyroc=
kets (and explains all the other negative consequences) with NS_TIMER_SWITC=
H=3D0, everything is back to normal, even doing "heavy" operation like crea=
ting 4096 bit RSA keys with OP-TEE.
>
> This and Lars's findings clearly indicate that we shouldn't set
> NS_TIMER_SWITCH=3D1. I'll propose a patch.
>
> Cheers,
> Jens
