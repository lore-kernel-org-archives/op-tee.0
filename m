Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07C8D1CDC6
	for <op-tee@archiver.kernel.org>; Tue,  9 Dec 2025 08:31:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EAF7A45451
	for <op-tee@archiver.kernel.org>; Tue,  9 Dec 2025 08:31:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VxwAk6vS;
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 73D0C431F7
	for <op-tee@lists.trustedfirmware.org>; Tue,  9 Dec 2025 08:31:00 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6593155d8d6so3066367eaf.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 09 Dec 2025 00:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765269060; x=1765873860; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3bYHmy/1FuRqn7Bk1xJN8dR4VtAgdavIHl1v3mOju0=;
        b=VxwAk6vSYGQ1BJe/R5PWROVFSfcbHjhBAaDcNd6Gf7f5tPZVOF3lntuONcTR9H0s76
         sDtg7t4eMeZxuKxvPux5ZlF9lBnGBxXh5muVh+VPJ9m8TI2hy3SzKC75VdMT2lYsDgfS
         KvRUrSX66P/5J1JQGw0Gtje5MX5myJNQ8Q1BuNrHSLex1+4iAEZTFjAA1q4pEqYQNjiW
         Dghd1amAKG+uRnsKabB5fNW+FdeXk3plxr/uiKtJp3HiWWB59n68t7Wl9C7hs6eG8U7c
         g7ncKKamRxJo0TyBHw56dq6rLlZJeNDfm/DeCv6pbhul0rbIpsFzEXBU6AxoCbSCoABq
         Ld3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765269060; x=1765873860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3bYHmy/1FuRqn7Bk1xJN8dR4VtAgdavIHl1v3mOju0=;
        b=oNokO136dnDblSyBfDzdQh0pHCzYUqpq3Qif3PNTI7wvlfrr6Z0LQIWaBA7KLBLcl8
         F98Dd6i5uE44XnpflWIxP0HWcirN6xzXrF8rgO00qu1W1M9kIfGwQBNMTCv2+Gg8uhCL
         ZFSkoZYRQzA5uO1Prdnplp1k7oiBIFByEhdWyuIsE36E3ksekl6SBAFdP2AqHJ6QlvOH
         wIFUGzvc76q2afIF2nm81ASWYsXPqGa/IMYnCUl6rpFwi0REUFjdz9VmtNKA7/DVNNlv
         FOx4kxf217++73FFa/LkSQqVdVJkC6zpu0TF9J9tJ/ZILVLIh9mC92X9CfXc4xWbNi6Z
         4y2A==
X-Forwarded-Encrypted: i=1; AJvYcCWIOSQmWW/6x+zLxnMg+SVtCRcS94EPjXN+tdFHJENHaJeIJy2bb2CrD9D0Wgt350jlhracouQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzJ7EgqL/MJhFaxtdEPxtZtETikFakgiOx5kwBQAXkIBwFdW+V2
	HwSkov9z5rDU/JNctL279PP5W1qzxutpVvu2ldYGVdHGXU6UkKmtJBeb+pEtPoDPjOsbbF0Q5Y2
	N8PkSpmx9EsDv23pBBZxxYu1yQGCxNK3tihBHPIm86st7
X-Gm-Gg: ASbGncs8MbSfOdBPljhVNNu6wWKHpOXojXy+OL0dMuIS/YpjY3gWUCUq3wiBgk8jd87
	o9ZT2TcsoI+ZvoVwnDPADMHncjz8q+5ZeUy9vmqKnrRpjUheGMFk8BfLxei1YyXZWXPvm7RPSGk
	l+vfP9iTCxe4gQ9u/CSrKlnWCkloKF4X26h1CZW+6vo6HZw+1263o20lcx5VB+H+D9nucHHF+9w
	Z51Zq148Q2b2aMuCi0BeoSpcprihywSm0Zviabwa0cP0CSnnz4X1Z8KOlS4hGBjgAGFB9fHd2tH
	qtL0aHMytIfbgHAi3ZemOG4qzqr+AV3d0kh7rIzuXVXO5VZST4MXB5eZnak0XOrBtW5008+W
X-Google-Smtp-Source: AGHT+IFuYndYRhiNtifygt/U5bQVpxC5ebDv5H82BiBwWTT15bmLlfmcGqNjl+f5Ce8qZD4LiWOlq0BPpv9gwacOASI=
X-Received: by 2002:a05:6820:200f:b0:659:9a49:8fc6 with SMTP id
 006d021491bc7-6599a973d3fmr4244993eaf.63.1765269059638; Tue, 09 Dec 2025
 00:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20251121141230.489294-1-jj251510319013@gmail.com>
 <20251122145924.381725-1-jj251510319013@gmail.com> <CAHUa44HFC+BTO3KfaNF1LHiM7frgt2myzZ_85Mbf1t2gUY9iSg@mail.gmail.com>
 <aSVgctqRSy5_vvkN@sumit-X1> <aSVhBn0LR2CwM9p3@sumit-X1> <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
 <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com>
 <CAJwFiGLRVZyr7Hb3PtGyA319hCYEJh9t8XY_amyjhUgqnrZycQ@mail.gmail.com>
 <CAHUa44GPuP+qdw2HPBgtrQNXovA7e5+yskrPRgh4D4OMutEJTA@mail.gmail.com> <CAJwFiGLNh-qu9ezQOmTBh3Dujf=mPRyzKBVXLV-A=GxhwcH-0w@mail.gmail.com>
In-Reply-To: <CAJwFiGLNh-qu9ezQOmTBh3Dujf=mPRyzKBVXLV-A=GxhwcH-0w@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 9 Dec 2025 09:30:47 +0100
X-Gm-Features: AQt7F2q3AvsO9Y-jQDVBQIhF_kP-u__p3cO6elzAnITIWeIq9xklthhjM2aInlo
Message-ID: <CAHUa44Eq=P5G4vKSq5TyJx5qF9E5q=+pHexMg41X85NCX4SpHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Aristo Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 73D0C431F7
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.49:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[209.85.161.49:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: SJTKIVSDUFUA7GOAF2VY7ECNLAVKJC5U
X-Message-ID-Hash: SJTKIVSDUFUA7GOAF2VY7ECNLAVKJC5U
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SJTKIVSDUFUA7GOAF2VY7ECNLAVKJC5U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Aristo,

On Sun, Dec 7, 2025 at 3:01=E2=80=AFPM Aristo Chen <jj251510319013@gmail.co=
m> wrote:
>
> Hi Jens,
>
> Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=
=9C=883=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:51=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi,
> >
> > On Tue, Dec 2, 2025 at 10:54=E2=80=AFAM Aristo Chen <jj251510319013@gma=
il.com> wrote:
> > >
> > > Hi Jens
> > >
> > > Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=
=E6=9C=881=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:06=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Dec 1, 2025 at 12:48=E2=80=AFPM Aristo Chen <jj251510319013=
@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=
=9C=8825=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:55=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > > > >
> > > > > > On Tue, Nov 25, 2025 at 01:23:22PM +0530, Sumit Garg via OP-TEE=
 wrote:
> > > > > > > On Mon, Nov 24, 2025 at 08:15:04AM +0100, Jens Wiklander wrot=
e:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Sat, Nov 22, 2025 at 4:00=E2=80=AFPM Wei Ming Chen <jj25=
1510319013@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Aristo Chen <aristo.chen@canonical.com>
> > > > > > > > >
> > > > > > > > > Today the only way to read the OP-TEE OS version is from =
dmesg/journal
> > > > > > > > > logs, which can be lost as buffers roll over. Capture the=
 OS revision
> > > > > > > > > (major/minor/build_id) from secure world for both SMC and=
 FF-A ABIs, store
> > > > > > > > > it in the OP-TEE driver, and expose a stable userspace re=
adout via
> > > > > > > > > /sys/class/tee/tee*/optee_os_revision.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/tee/optee/core.c          | 19 +++++++++++++++++=
++
> > > > > > > > >  drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
> > > > > > > > >  drivers/tee/optee/optee_private.h | 17 +++++++++++++++++
> > > > > > > > >  drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
> > > > > > > > >  4 files changed, 58 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > This appears to be a feature that could be useful for all T=
EEs.
> > > > > > >
> > > > > > > True, it is something that TEE core should support. Although =
I would
> > > > > > > have preferred to extend TEE_IOC_VERSION since that's the com=
mon way the
> > > > > > > user-space library get's TEE implementation specific informat=
ion. But
> > > > > > > since it being already a user-space ABI which doesn't offer e=
xtension.
> > > > > > > Maybe we can consider adding TEE_IOC_REVERSION instead of sys=
fs.
> > > > > >
> > > > > > Ah, typo here:
> > > > > >
> > > > > > s/TEE_IOC_REVERSION/TEE_IOC_REVISION/
> > > > > >
> > > > > > -Sumit
> > > > > >
> > > > > > >
> > > > > > > But before doing that we need to know who is the actual consu=
mer here
> > > > > > > from user-space perspective? Will the client applications als=
o depend on
> > > > > > > the TEE implementation revision?
> > > > > My current thinking is that if the TEE revision is exposed, users=
 can write a
> > > > > script to capture the platform state and record the exact secure =
OS revision
> > > > > even after the dmesg/journalctl logs have rolled over. This would=
 significantly
> > > > > improve bug triage and regression tracking.
> > > > >
> > > > > In my case, I have a package with precompiled xtest binaries for =
multiple
> > > > > releases (from 3.14 to 4.6), and I work with different platforms =
that run
> > > > > different OP-TEE OS versions. Having a reliable way to obtain the=
 TEE
> > > > > revision would help a lot, as it would allow me to select the cor=
rect xtest
> > > > > version when running tests.
> > > >
> > > > I'm concerned that the ABI might be misused to be part of what the
> > > > client expects from the TEE. You even express that as a use case. I=
'd
> > > > rather fix the problem with xtest.
> > >
> > > Thanks for the feedback! To clarify: currently, the OP-TEE OS revisio=
n
> > > I expose in
> > > sysfs is the same value already printed in dmesg at boot
> > >  (e.g., =E2=80=9Coptee: revision 4.8 (XXXXXX)=E2=80=9D).
> > >
> > > Are your concerns specifically about clients inferring capabilities
> > > from a revision
> > > string (=E2=80=9Crev X.Y implies feature Z=E2=80=9D)? If so, I agree =
that=E2=80=99s fragile
> > > and not the intent.
> >
> > Yes
>
> Thanks for clarifying the concern!
>
> >
> > > I=E2=80=99m happy to add a short note in the doc that this is informa=
tional
> > > only and that
> > > feature detection must use proper capability queries.
> > >
> > > Please let me know if that addresses the worry, or if there=E2=80=99s=
 another
> > > concern I=E2=80=99m
> > > missing.
> >
> > Adding APIs that aren't supposed to be used seems odd. Do you know if
> > there are examples in the kernel for this kind of thing?
> I=E2=80=99ve done some research and, as far as I can tell, the TEE core a=
lready
> provides an informational-only file at /sys/class/tee/tee0/implementation=
_id.
> My understanding is that it was introduced roughly 10 years ago. However,
> I haven=E2=80=99t found any documentation clarifying its intended purpose=
, so I=E2=80=99m
> assuming this may be a similar situation. I=E2=80=99d appreciate it if yo=
u could correct
> me if I=E2=80=99m wrong.

That one is for a quick way for a client to tell the different TEE
device implementations apart. You're right, it resembles your case,
except that this is part of a well-defined ABI.

>
> Also, here are some files with similiar purposes:
> - /sys/devices/system/cpu/cpu*/microcode/version
> - /sys/devices/virtual/dmi/id/{bios_date,bios_release,bios_vendor,bios_ve=
rsion}
> - /sys/kernel/security/apparmor/revision

Thanks, this is good background information.

We have a BoF session on the TEE subsystem at LPC on Friday [1]. We'll
take the opportunity to discuss it there.

[1] https://lpc.events/event/19/contributions/2107/

Cheers,
Jens
