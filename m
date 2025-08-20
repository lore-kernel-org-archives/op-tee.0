Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D797CA0EE4
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 13:14:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9C2504FC6F
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 13:14:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SrabkPtL;
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2ACA143141
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 13:14:03 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30ccec928f6so1862195fac.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755695642; x=1756300442; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ1sBMcg0O/rSNOthhedTIX9zysu4TCLsvU0iRvUfeU=;
        b=SrabkPtLYkNkZowbcUeD1HoU1JhBQ3DQOWAo0RmNkf0Spm75OOYgHGz5e+dzkAzI2B
         rEhB9HH1cx/xSV05AUUG6FW4zLtl62pxxe2ecv6Gp+yRqE2jp9/KzL9J7L/532vsO//f
         mXFCB6uyp3EKdWULxRwyj9t7bLPqGzIzzXWNGPTbPLN87kH2NShq/zDtX3EIaq8h7ukE
         skDNSUNKfqMa/p8TKSFPC2Qp0Gd7bhWvrcyzrPES9dc6Rrd+AwQa2Ezs7H2tlKsyrNR9
         gE2t4qU9NqR8r8k50qa0xk/sA6PO5AvomHG52iC0paejr7T9GeeZfS8BOuN+SB5Ao7cS
         sLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695642; x=1756300442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ1sBMcg0O/rSNOthhedTIX9zysu4TCLsvU0iRvUfeU=;
        b=bAsyVFIicuYBL7BNk7aRAHxuSZCpGv8JOr3KxkqlVFxn/rD1512JlenkaTgg0f1SQF
         kLWIQLPGhNt88bjOHHcdLltmhtxf5XeX4RVQW7oOcJdlvPClGTsoiYahtPvQsDONJgy8
         PEjJrqbAq2WlOINJncTMLCil8q2WxHhCGokyXX/nmPBVPRjdXKUtzmMEfflMLq2gEITW
         tvtn7wVSFgp5uGFU+p2N/zzOkg7QPt947CU/N+0QWUTWt6OuZ4Q/t8DUhsaQBrH5HMuK
         UG4NMTXX/6OUfQThJgXlFrabx/4FMXtok95DywN+Kt7Fh5DfyJAALJB6ZL2q6MaGzXEu
         TMqw==
X-Forwarded-Encrypted: i=1; AJvYcCUyu592j6/AMkjCaSvyIda2ryQlIICm0sOyZGV7RPyS2YwYBj8SRH9uePWWETOPdtoVIJhc5XI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx0zQ2C4aCPMiobQpSVqxWF9IYayXCVcm0q+920Q47CXUZNO3Qh
	xCgHVuJeJ1Nz5HqCXCuDgWYxRzP1KY1/K1Pcxa2qKfHKISZz6WTq8wYkWGf0IR0aOsrL3UGW+ES
	6rqPzTEG+haYyiK/XCElVfD5AJGJshRsAreHC8oDQr1Bs
X-Gm-Gg: ASbGncvaLh0X1xuOuhy1xG/mBREOBj2fs+KPZ6dsVER+Au6ZAs/gjDHQTEQ3lwWXde+
	9hooMyHKPct6ZKu8odSLeoiE4pzbaFTHSaJ5ZUVlahO5/CD+/CejBO5T06QlrS+4+TANlNlflx4
	ZSQAtexk6JfS4U+BCojilBg9x1VKu3DdpXM9dvlZ9fdYacwMAOFrdnQW0b6xy60UB+MaoGJpgf/
	dFOETBo
X-Google-Smtp-Source: AGHT+IHapS7xJL/QyKbhceX8KPHPhiJZ7cGLVyOABcGdQhzDCXYTFvWkJ9AfqItf+61oshKQUCCnNPVsjY3J0q6cerM=
X-Received: by 2002:a05:6870:5ba8:b0:2ff:9aee:1793 with SMTP id
 586e51a60fabf-3112274fe42mr1475836fac.1.1755695642378; Wed, 20 Aug 2025
 06:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com> <AS4PR02MB10357C57036D58BA7E1878D1AF233A@AS4PR02MB10357.eurprd02.prod.outlook.com>
In-Reply-To: <AS4PR02MB10357C57036D58BA7E1878D1AF233A@AS4PR02MB10357.eurprd02.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 20 Aug 2025 15:13:51 +0200
X-Gm-Features: Ac12FXwS5v-mYj_NwBwjMhOMy6e3_Vx0v3CLFpS96C5a-J9fjfjM6NjcC3uTUos
Message-ID: <CAHUa44FM30xYYveT-xL7DzrB7mN8m0t=V=G9Uo8Xch-eTO2Cng@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
To: Lars Persson <Lars.Persson@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2ACA143141
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.52:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.52:from];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: Q3X7XN62DQK2YHGE4SMC7OAM4ILOO5US
X-Message-ID-Hash: Q3X7XN62DQK2YHGE4SMC7OAM4ILOO5US
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>, Sumit Garg <sumit.garg@kernel.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Ferreira Joao MTANA <Joao.Ferreira@mt.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Q3X7XN62DQK2YHGE4SMC7OAM4ILOO5US/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Lars,

On Wed, Aug 20, 2025 at 2:39=E2=80=AFPM Lars Persson <Lars.Persson@axis.com=
> wrote:
>
> Hi
>
>
>
> One reason for not seeing this issue more is that the NXP SDK ships with =
the NS_TIMER_SWITCH=3D1 patch reverted.
>
>
>
> The current SDK for example has this commit (it was there already 2020 on=
 older branches):
>
> https://github.com/nxp-imx/imx-atf/commit/c73b052c4d57a10b9bfcd9002e87300=
88d854583

Thanks, that's good to know.

Cheers,
Jens

>
>
>
> /Lars
>
>
>
> From: Jens Wiklander <jens.wiklander@linaro.org>
> Date: Wednesday, 20 August 2025 at 13:10
> To: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>, Sumit Garg <sumit.gar=
g@kernel.org>
> Cc: op-tee@lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>, =
Ferreira Joao MTANA <Joao.Ferreira@mt.com>
> Subject: Re: rcu_preempt detected stalls on CPUs/tasks
>
> Hi Thomas,
>
> On Mon, Aug 4, 2025 at 7:09=E2=80=AFPM Stauffer Thomas MTANA via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
> >
> > Hi,
> >
> > I'm running OP-TEE 4.5 with PKCS11TA and ATF lts-v2.12.4 on an iMX8MP. =
When I create new rsa 4096 bit keypair with OP-TEE, I often get
> >
> > rcu_preempt detected stalls on CPUs/tasks
> >
> > from Linux 6.6.90 (mainline)
> >
> > Also PID 0 is sometimes blocked for more than 30 seconds. When I create=
 a RT task with even higher priority, this process is also blocked up to 2 =
seconds. For a test I disabled saving/restoring the NS timer register in AT=
F (arm-trusted-firmware/lib/el3_runtime/aarch64/context_mgmt.c), this seems=
 to get completely rid of the problem. Neither creating nor signing leads t=
o any issue anymore. This hack may lead to other problems I do not fully un=
derstand yet. I "believe" that at least since ARMv8, the CPU have their own=
 timers for secure/non-secure world, but I would assume that ATF implements=
 this correctly already.
>
> I'm starting to suspect that we're setting NS_TIMER_SWITCH to 1 in
> services/spd/opteed/opteed.mk based on a misunderstanding. OP-TEE can
> use timers, but then it's using the EL3 physical timer. So OP-TEE
> should stay off the EL1 physical timer. Sumit, what's your view?
>
> >
> > Maybe I'm completely wrong here (assuming that it cannot be I'm the fir=
st person having this issue on this platform). Hint in any direction would =
be helpful.
>
> I'm surprised we haven't seen more of this issue.
>
> Cheers,
> Jens
>
> >
> > Regards
> >
> > Thomas
> >
