Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB5EE6748D
	for <op-tee@archiver.kernel.org>; Mon, 22 Dec 2025 08:34:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0404345292
	for <op-tee@archiver.kernel.org>; Mon, 22 Dec 2025 08:34:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zfh8ybPz;
	dkim-atps=neutral
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E304D41A37
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Dec 2025 08:34:36 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3ec46e3c65bso2960467fac.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Dec 2025 00:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766392476; x=1766997276; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OEJRCaW9uFFjbYJsKynwdsjjo1KKLNIhFHEXXpnuyo=;
        b=zfh8ybPz/E6udecBWW94xoTDJZuYv2YvuWfBfin3GMf6cd8EfWWPHRy9sPTktbeHk3
         h+R3wS90jz2Ed1Wgijt9HRK/l8eNhelqhvhq8JK/FV5q1MCrg6nwmz+PfkkTYw7i+yON
         D2burin7kKlYHpMPekgh0PRXnKhUw0L0SKE2FqLQXg2c2Ye+m8X8w451mnFExXQX1ntE
         JPJUvWVReCdqWbkXwr4u/DV2+VbPM7iF1mDvxeQmipUyzSNGV3X6BoUTnVGVpPnFvPOu
         vh8qJ7LrIeRrz506tZAK8Xgaamzfseb0HXXc06wMyw0uFn3aP+m/jreEDwHRBTzHklE6
         PXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766392476; x=1766997276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OEJRCaW9uFFjbYJsKynwdsjjo1KKLNIhFHEXXpnuyo=;
        b=G2R71Le8nQ5hhecQ1WlDr2mn8RIrzf+ZTeZ1RA2ISUvuo3CTV02qcsP+E5+CIYBmrX
         2F8z47PMSdiHd0ehuAkui8Nu73uzq87JJe8BnWYAefzpnUJXWwqXTGfryQJIO5VTlBKf
         gs6yB1/A6RXsVRLIeowuWf02kheFdPPsNRkqAukypLfZHtR7myJ/h8tW+8kkztA19F1o
         jR5hY/YL2qUVn2VAXAgkTt8dqoyHXpjTLOJe1/09Jyhcj+hodSEXqcSqJz/BmKDDxm3Q
         Y4E0QTHE66LW5rXLg7e9OkTk0RnxIShks9SuLcF7BVlJhNcdMC99NokGNCXnfn6m/O1H
         Wy/A==
X-Forwarded-Encrypted: i=1; AJvYcCWU6uYAKO/3S2zyAylVHsCYH8laIS3T4wDlG/7myEgXQYp+GZcRuYmB3XbqbTbZjm1gfBLqrpA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwH9k1+4I35MoKXrs3LwKgfeegOeCbKhh19lHmy+d3wiXUAU3UY
	v3iwlLekUSO0/SvBtodSBRHYDV/atTWERD9nL5MBFnSSBpb8xaboYZ9TXGZWFWETUo2+bmV4ptq
	iIzPn/MC27wF/0YUjyOUzYEM32NfP3rM0gkGCNIWQwrZV
X-Gm-Gg: AY/fxX78peH6wWzUeF7TQdVpwy62nzUGd9AxUd4NMpUC1cvZJlo4NiJrLZjTy/N0SyI
	/+UcwkT/WJBDDyJyJrpeDNs86o1lxPSwC1UOCz9UnGF8jnkrDCzv4SZXqlLkA/vUP5t0y8gk3iG
	+iUl81TAh/Q5f9kKDp332IIDMzZeaKgp5FJqXtqBWRgDXV0T+kcTMCTGcRqQWQqzN+GfiI0OxAN
	3+ojrzKeeJ5keOw4+cG+vihCpIfBWoc+s5rctL6Ydv3DgJPkq0XUQVA4A2gD8MzL9gLrHAW6pnn
	orhV08yZ331hX8qLtIPFDdqMYg==
X-Google-Smtp-Source: AGHT+IGE8OzMPdJM7VouVOjZaIUURhNjpOpAcB8uh49gw7gs8VJ8va2jF94X1SLbQccxkP5pJ/BwWQv5bc56zlwYCJU=
X-Received: by 2002:a05:6820:1c9f:b0:65d:141d:9e0b with SMTP id
 006d021491bc7-65d141da063mr3600606eaf.41.1766392476053; Mon, 22 Dec 2025
 00:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20251121141230.489294-1-jj251510319013@gmail.com>
 <20251122145924.381725-1-jj251510319013@gmail.com> <CAHUa44HFC+BTO3KfaNF1LHiM7frgt2myzZ_85Mbf1t2gUY9iSg@mail.gmail.com>
 <aSVgctqRSy5_vvkN@sumit-X1> <aSVhBn0LR2CwM9p3@sumit-X1> <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
 <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com>
 <CAJwFiGLRVZyr7Hb3PtGyA319hCYEJh9t8XY_amyjhUgqnrZycQ@mail.gmail.com>
 <CAHUa44GPuP+qdw2HPBgtrQNXovA7e5+yskrPRgh4D4OMutEJTA@mail.gmail.com>
 <CAJwFiGLNh-qu9ezQOmTBh3Dujf=mPRyzKBVXLV-A=GxhwcH-0w@mail.gmail.com>
 <CAHUa44Eq=P5G4vKSq5TyJx5qF9E5q=+pHexMg41X85NCX4SpHA@mail.gmail.com> <CAJwFiGKw8+T3v3H+=bBtWzV1kuXKBq9gRTWGpS4iS4ictWOAtA@mail.gmail.com>
In-Reply-To: <CAJwFiGKw8+T3v3H+=bBtWzV1kuXKBq9gRTWGpS4iS4ictWOAtA@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 22 Dec 2025 09:34:24 +0100
X-Gm-Features: AQt7F2qDkaXHJQh-ay_C_EaVR0xPvhQC51crA6US4tcgDwWFGDnV5yWBk2VKehc
Message-ID: <CAHUa44ELXMv+e8dkZ=NwYjg=YoH=1=4JGze89BK+Db8ERozPLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Aristo Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.50:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	BLOCKLISTDE_FAIL(0.00)[209.85.160.50:server fail];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.50:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E304D41A37
X-Spamd-Bar: --
Message-ID-Hash: RPN4GV3IAHVKPM2Y4V5AESPHWJRLIYD6
X-Message-ID-Hash: RPN4GV3IAHVKPM2Y4V5AESPHWJRLIYD6
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RPN4GV3IAHVKPM2Y4V5AESPHWJRLIYD6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Aristo,

On Fri, Dec 19, 2025 at 4:39=E2=80=AFPM Aristo Chen <jj251510319013@gmail.c=
om> wrote:
>
> Hi Jens
>
> Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=
=9C=889=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:31=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi Aristo,
> >
> > On Sun, Dec 7, 2025 at 3:01=E2=80=AFPM Aristo Chen <jj251510319013@gmai=
l.com> wrote:
> > >
> > > Hi Jens,
> > >
> > > Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=
=E6=9C=883=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:51=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Dec 2, 2025 at 10:54=E2=80=AFAM Aristo Chen <jj251510319013=
@gmail.com> wrote:
> > > > >
> > > > > Hi Jens
> > > > >
> > > > > Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=
=B412=E6=9C=881=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:06=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Mon, Dec 1, 2025 at 12:48=E2=80=AFPM Aristo Chen <jj25151031=
9013@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2025=E5=B9=B411=
=E6=9C=8825=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:55=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > On Tue, Nov 25, 2025 at 01:23:22PM +0530, Sumit Garg via OP=
-TEE wrote:
> > > > > > > > > On Mon, Nov 24, 2025 at 08:15:04AM +0100, Jens Wiklander =
wrote:
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > On Sat, Nov 22, 2025 at 4:00=E2=80=AFPM Wei Ming Chen <=
jj251510319013@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > From: Aristo Chen <aristo.chen@canonical.com>
> > > > > > > > > > >
> > > > > > > > > > > Today the only way to read the OP-TEE OS version is f=
rom dmesg/journal
> > > > > > > > > > > logs, which can be lost as buffers roll over. Capture=
 the OS revision
> > > > > > > > > > > (major/minor/build_id) from secure world for both SMC=
 and FF-A ABIs, store
> > > > > > > > > > > it in the OP-TEE driver, and expose a stable userspac=
e readout via
> > > > > > > > > > > /sys/class/tee/tee*/optee_os_revision.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com=
>
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/tee/optee/core.c          | 19 +++++++++++++=
++++++
> > > > > > > > > > >  drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
> > > > > > > > > > >  drivers/tee/optee/optee_private.h | 17 +++++++++++++=
++++
> > > > > > > > > > >  drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
> > > > > > > > > > >  4 files changed, 58 insertions(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > This appears to be a feature that could be useful for a=
ll TEEs.
> > > > > > > > >
> > > > > > > > > True, it is something that TEE core should support. Altho=
ugh I would
> > > > > > > > > have preferred to extend TEE_IOC_VERSION since that's the=
 common way the
> > > > > > > > > user-space library get's TEE implementation specific info=
rmation. But
> > > > > > > > > since it being already a user-space ABI which doesn't off=
er extension.
> > > > > > > > > Maybe we can consider adding TEE_IOC_REVERSION instead of=
 sysfs.
> > > > > > > >
> > > > > > > > Ah, typo here:
> > > > > > > >
> > > > > > > > s/TEE_IOC_REVERSION/TEE_IOC_REVISION/
> > > > > > > >
> > > > > > > > -Sumit
> > > > > > > >
> > > > > > > > >
> > > > > > > > > But before doing that we need to know who is the actual c=
onsumer here
> > > > > > > > > from user-space perspective? Will the client applications=
 also depend on
> > > > > > > > > the TEE implementation revision?
> > > > > > > My current thinking is that if the TEE revision is exposed, u=
sers can write a
> > > > > > > script to capture the platform state and record the exact sec=
ure OS revision
> > > > > > > even after the dmesg/journalctl logs have rolled over. This w=
ould significantly
> > > > > > > improve bug triage and regression tracking.
> > > > > > >
> > > > > > > In my case, I have a package with precompiled xtest binaries =
for multiple
> > > > > > > releases (from 3.14 to 4.6), and I work with different platfo=
rms that run
> > > > > > > different OP-TEE OS versions. Having a reliable way to obtain=
 the TEE
> > > > > > > revision would help a lot, as it would allow me to select the=
 correct xtest
> > > > > > > version when running tests.
> > > > > >
> > > > > > I'm concerned that the ABI might be misused to be part of what =
the
> > > > > > client expects from the TEE. You even express that as a use cas=
e. I'd
> > > > > > rather fix the problem with xtest.
> > > > >
> > > > > Thanks for the feedback! To clarify: currently, the OP-TEE OS rev=
ision
> > > > > I expose in
> > > > > sysfs is the same value already printed in dmesg at boot
> > > > >  (e.g., =E2=80=9Coptee: revision 4.8 (XXXXXX)=E2=80=9D).
> > > > >
> > > > > Are your concerns specifically about clients inferring capabiliti=
es
> > > > > from a revision
> > > > > string (=E2=80=9Crev X.Y implies feature Z=E2=80=9D)? If so, I ag=
ree that=E2=80=99s fragile
> > > > > and not the intent.
> > > >
> > > > Yes
> > >
> > > Thanks for clarifying the concern!
> > >
> > > >
> > > > > I=E2=80=99m happy to add a short note in the doc that this is inf=
ormational
> > > > > only and that
> > > > > feature detection must use proper capability queries.
> > > > >
> > > > > Please let me know if that addresses the worry, or if there=E2=80=
=99s another
> > > > > concern I=E2=80=99m
> > > > > missing.
> > > >
> > > > Adding APIs that aren't supposed to be used seems odd. Do you know =
if
> > > > there are examples in the kernel for this kind of thing?
> > > I=E2=80=99ve done some research and, as far as I can tell, the TEE co=
re already
> > > provides an informational-only file at /sys/class/tee/tee0/implementa=
tion_id.
> > > My understanding is that it was introduced roughly 10 years ago. Howe=
ver,
> > > I haven=E2=80=99t found any documentation clarifying its intended pur=
pose, so I=E2=80=99m
> > > assuming this may be a similar situation. I=E2=80=99d appreciate it i=
f you could correct
> > > me if I=E2=80=99m wrong.
> >
> > That one is for a quick way for a client to tell the different TEE
> > device implementations apart. You're right, it resembles your case,
> > except that this is part of a well-defined ABI.
> >
> > >
> > > Also, here are some files with similiar purposes:
> > > - /sys/devices/system/cpu/cpu*/microcode/version
> > > - /sys/devices/virtual/dmi/id/{bios_date,bios_release,bios_vendor,bio=
s_version}
> > > - /sys/kernel/security/apparmor/revision
> >
> > Thanks, this is good background information.
> >
> > We have a BoF session on the TEE subsystem at LPC on Friday [1]. We'll
> > take the opportunity to discuss it there.
>
> Just a quick follow-up on this patch, has there been any decision or
> direction from that discussion?
> I=E2=80=99m happy to rework the patch in whatever direction the group pre=
fers.

No one was against it. We didn't discuss the details, but here's what
I'd like to see:
- The callback name should be get_tee_revision() or get_tee_fw_version()
- The FW version is returned as a string for flexibility
- A note that the FW version is not intended to be used to determine
what features, etc, are available, TEE_IOC_VERSION should cover that.

Sumit, what do you think?

Cheers,
Jens
