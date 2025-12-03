Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FABCD116F3
	for <op-tee@archiver.kernel.org>; Wed,  3 Dec 2025 07:51:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 653AD50029
	for <op-tee@archiver.kernel.org>; Wed,  3 Dec 2025 07:51:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jQv9eSzM;
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 786D042CD5
	for <op-tee@lists.trustedfirmware.org>; Wed,  3 Dec 2025 07:51:06 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6597267f6e6so275215eaf.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 02 Dec 2025 23:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764748266; x=1765353066; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rst97Y+r+hZUiW/JYtepQuD8pgz/ysFiOiO4jIY+Wds=;
        b=jQv9eSzMIsxc01Ap5agblpcy/aI0ZNNcNVsbuWeMB+exGG0T0lzZgE5TsxF45prDSy
         qlliU3m5q5ru6NKhpDZ5sKqdyftQ0K+NhNwFqw/jLHbSGF5ionbojstTS2okkt+85AbS
         p+Vn0Zeo3N1SR8ynUF3UOhl8RZwkE9hkx6AOtP/je8j4d6k0r6X0WyqUdQ3ssXttwzow
         tsAdpbCz0DvykdjLDeKQ5rI6YCDh+U3lCy2dp+9Hh2B/0PcltE7ISa+pRv3mBGi5iXgo
         5llgcANo6iByaCAqmMQ6AzU5MerVJiqN9rEchJ92/6ha/IoDM7KwkvIhvtBdC2/GynIp
         /m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764748266; x=1765353066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rst97Y+r+hZUiW/JYtepQuD8pgz/ysFiOiO4jIY+Wds=;
        b=I4ie6XdEY+64KrWfpt2TPnHV7NoJauaSCBvo6P2jJIixysME/vM3Db09bW9AITKBZ2
         pBEfx6Pi5/JdZn9IKald9DIc8W7y7LSEn/ZNUrU/FBysv4165rwlagUnK3e1gvalD/zg
         qENImOgDIn4SuG+8hHVlsvUgi0URhvYbpOiXtrcA/6VPcnb77UHERgKuw3y0ih5CWjh8
         uGfXnelhq/sc/0OkCIRJkzEVHMhR15LW6OF78OW4e9jXDI90hnSshRQZHu6437xoww6y
         sXq+Jh9wqZMtv7TGOwKbHKjluWDDVOLbD4+G7hcs5CpaL3ZaGNa1u6ettZ8qLCbmwQ1g
         rwWg==
X-Forwarded-Encrypted: i=1; AJvYcCXdyf8mVgUo31g5uQj+0ffqO2RNwjSwZT4OTW/Enc3i9o4m/o7h2bEFBrwrfgNXv3CJm+W/ZKI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw6hYNcFsPiqzQir8aIv2owflVG5GuQRj/R17Zf8pRbIuz4e7cd
	KrKDdPk6r+8Qc5VKPA/hYBlQi1dYbTazpPtVNGbAHKovXNdogkXfBU55nPcGRur8VKGjYABQjVE
	m7pdZL07Oeh1FkgKHJ4cLbiB79xdrn3YpTROGydDI3l/b
X-Gm-Gg: ASbGncv/TWzL/p7MzxLLC/6O2syoKHLDNSSt+6KIP+STjwB6Fcr/9nsNSjIO8+hiD24
	rHTAeLRChOIYoAO7bIQv07YnHKYkPPL0BOruX1Fys/4UDKw78O4I5Wih4ZcMI2da8NMpXpyHoR3
	8Nb9HX8jv0J6ORzI24A8jQ+hvylX+W243h8WXSSYBMq6CG2OScFJR0ssSSQaUHuAotzpbY5G/0a
	mWm47Q0RtoQAvj33FcJjnT/1VRewe7xPgvObIo2VpU3NFBsC6voJ9wNRZ4mwGtB7pZwjimFHiGR
	PP5VVDaNzH5DrmlwxFlLYqZIKh6LUfo7m99A
X-Google-Smtp-Source: AGHT+IHB+q+ei9+0EPL+fTFA5Vv7PmfASo4xakl9/wjyu19rfEbOSOvKVQKc8Tfi7ye0I4zlHQqHU3bmTvZ7imkNEWE=
X-Received: by 2002:a05:6820:1522:b0:657:70af:4e21 with SMTP id
 006d021491bc7-659727d2541mr658541eaf.8.1764748265733; Tue, 02 Dec 2025
 23:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20251121141230.489294-1-jj251510319013@gmail.com>
 <20251122145924.381725-1-jj251510319013@gmail.com> <CAHUa44HFC+BTO3KfaNF1LHiM7frgt2myzZ_85Mbf1t2gUY9iSg@mail.gmail.com>
 <aSVgctqRSy5_vvkN@sumit-X1> <aSVhBn0LR2CwM9p3@sumit-X1> <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
 <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com> <CAJwFiGLRVZyr7Hb3PtGyA319hCYEJh9t8XY_amyjhUgqnrZycQ@mail.gmail.com>
In-Reply-To: <CAJwFiGLRVZyr7Hb3PtGyA319hCYEJh9t8XY_amyjhUgqnrZycQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 3 Dec 2025 08:50:53 +0100
X-Gm-Features: AWmQ_bnzlF58xOq7YZPmNSO5aOHYjMt30crfD3xmqdAYd27dGu0pLsNOpyTN72k
Message-ID: <CAHUa44GPuP+qdw2HPBgtrQNXovA7e5+yskrPRgh4D4OMutEJTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Aristo Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 786D042CD5
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.46:from];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[mail-oo1-f46.google.com:helo,mail-oo1-f46.google.com:rdns,linaro.org:dkim,linaro.org:email];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	BLOCKLISTDE_FAIL(0.00)[209.85.161.46:server fail];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.46:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: QFCKMHO4JPNMWKTFGRYIO33UPK6IFTRM
X-Message-ID-Hash: QFCKMHO4JPNMWKTFGRYIO33UPK6IFTRM
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QFCKMHO4JPNMWKTFGRYIO33UPK6IFTRM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Tue, Dec 2, 2025 at 10:54=E2=80=AFAM Aristo Chen <jj251510319013@gmail.c=
om> wrote:
>
> Hi Jens
>
> Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=
=9C=881=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:06=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi,
> >
> > On Mon, Dec 1, 2025 at 12:48=E2=80=AFPM Aristo Chen <jj251510319013@gma=
il.com> wrote:
> > >
> > > Hi,
> > >
> > > Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=9C=88=
25=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:55=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > >
> > > > On Tue, Nov 25, 2025 at 01:23:22PM +0530, Sumit Garg via OP-TEE wro=
te:
> > > > > On Mon, Nov 24, 2025 at 08:15:04AM +0100, Jens Wiklander wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Sat, Nov 22, 2025 at 4:00=E2=80=AFPM Wei Ming Chen <jj251510=
319013@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Aristo Chen <aristo.chen@canonical.com>
> > > > > > >
> > > > > > > Today the only way to read the OP-TEE OS version is from dmes=
g/journal
> > > > > > > logs, which can be lost as buffers roll over. Capture the OS =
revision
> > > > > > > (major/minor/build_id) from secure world for both SMC and FF-=
A ABIs, store
> > > > > > > it in the OP-TEE driver, and expose a stable userspace readou=
t via
> > > > > > > /sys/class/tee/tee*/optee_os_revision.
> > > > > > >
> > > > > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > > > > > ---
> > > > > > >  drivers/tee/optee/core.c          | 19 +++++++++++++++++++
> > > > > > >  drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
> > > > > > >  drivers/tee/optee/optee_private.h | 17 +++++++++++++++++
> > > > > > >  drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
> > > > > > >  4 files changed, 58 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > This appears to be a feature that could be useful for all TEEs.
> > > > >
> > > > > True, it is something that TEE core should support. Although I wo=
uld
> > > > > have preferred to extend TEE_IOC_VERSION since that's the common =
way the
> > > > > user-space library get's TEE implementation specific information.=
 But
> > > > > since it being already a user-space ABI which doesn't offer exten=
sion.
> > > > > Maybe we can consider adding TEE_IOC_REVERSION instead of sysfs.
> > > >
> > > > Ah, typo here:
> > > >
> > > > s/TEE_IOC_REVERSION/TEE_IOC_REVISION/
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > > But before doing that we need to know who is the actual consumer =
here
> > > > > from user-space perspective? Will the client applications also de=
pend on
> > > > > the TEE implementation revision?
> > > My current thinking is that if the TEE revision is exposed, users can=
 write a
> > > script to capture the platform state and record the exact secure OS r=
evision
> > > even after the dmesg/journalctl logs have rolled over. This would sig=
nificantly
> > > improve bug triage and regression tracking.
> > >
> > > In my case, I have a package with precompiled xtest binaries for mult=
iple
> > > releases (from 3.14 to 4.6), and I work with different platforms that=
 run
> > > different OP-TEE OS versions. Having a reliable way to obtain the TEE
> > > revision would help a lot, as it would allow me to select the correct=
 xtest
> > > version when running tests.
> >
> > I'm concerned that the ABI might be misused to be part of what the
> > client expects from the TEE. You even express that as a use case. I'd
> > rather fix the problem with xtest.
>
> Thanks for the feedback! To clarify: currently, the OP-TEE OS revision
> I expose in
> sysfs is the same value already printed in dmesg at boot
>  (e.g., =E2=80=9Coptee: revision 4.8 (XXXXXX)=E2=80=9D).
>
> Are your concerns specifically about clients inferring capabilities
> from a revision
> string (=E2=80=9Crev X.Y implies feature Z=E2=80=9D)? If so, I agree that=
=E2=80=99s fragile
> and not the intent.

Yes

> I=E2=80=99m happy to add a short note in the doc that this is information=
al
> only and that
> feature detection must use proper capability queries.
>
> Please let me know if that addresses the worry, or if there=E2=80=99s ano=
ther
> concern I=E2=80=99m
> missing.

Adding APIs that aren't supposed to be used seems odd. Do you know if
there are examples in the kernel for this kind of thing?

Cheers,
Jens
