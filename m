Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3241BE8FDB1
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 08:10:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6EE9D41B7C
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 08:10:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20230601 header.b=d8vG12g+;
	dkim-atps=neutral
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C64F643035
	for <op-tee@lists.trustedfirmware.org>; Fri, 19 Dec 2025 15:39:26 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5e19e72c2a7so521510137.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 19 Dec 2025 07:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766158766; x=1766763566; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/aJnS2QpjVLEwYFQ1j8nyWzB7EVHFnNgKX5jGUe5fA=;
        b=d8vG12g+DFPGVwZtBDqHrUsJ1IIkxgg9PNaEmMWKFUx+u8LtczlRy4RBOH6dZMuyuH
         msmFFOAbbS2RX3T2c9sbGoS+W4+rqMD6kzIf2JU8bn9gPEzG0xmmXNoPxpEasrLVk7Q4
         YyAwMOAZW7OMy5gfWRisddQs+nO+zIZqGsF/Mjivlp83d3nrpCzIQqUfUByydWwJpCNJ
         +6DoSygGDNWXo4qHf9Ai+wIyhj9YQE6m/RbJNm7w7X+V3CepitzpvZqAUptmZZ7SOySE
         UL6OUDf84fqTYmvHjZfE1NgHAa+Y6Oc3LNhxJJ96JDr92sxMau/AcJz2TU3v18UyEIrr
         jppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766158766; x=1766763566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/aJnS2QpjVLEwYFQ1j8nyWzB7EVHFnNgKX5jGUe5fA=;
        b=TamN21C3Muib6AcprxG4o8E/Y4VBtZ3mFWhBS+xUcDR+IdYVBTRjyCT4sUq6dRAJOa
         hpdvNJ0ez5Jzgf98sFha7ag1m8zSOhBnTxIrgnXYvKai0uleYp+C2hX8dPSCudtGdK0B
         59EF7zCKc/q1HFYzyV7+A1jArVperpJiktulNsviJcg/bdb6xETJ74aGpozyr0sqo7tt
         e8MQkB+RNsOLXz//SVZOQptvnV/8ptCIoW7Es9udkqpsDN5vxKEEIynAq+N9BF+Sc4N2
         2cdTcRmSA7akDvpxO9v6ipVOHC/NJlMOY6wfKFE8PGF5zrgX37vONQKrr0CoUEZ+mViY
         CERQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI2yYt18g3u7Sr3hh0iMrj3DqCCMhpv/M3vxMV1fak23XTMGlbiBHQ8kblSdg3DKldGkghVIQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxO6Vi8/7W4XleK5+2HM8aodz0Gk6Eo3bIoOhMXcB2Ud2QHcDxW
	LU8TfcqyomJF1wPL9OEeDHB+G5FkKs1CJKn8LSy3PyJRPvEpHz1Ivbs1tlYGAVtZ6t6Z78APPjw
	rJLTp3t7rAggWS+Jcixnhjukpik2axYc=
X-Gm-Gg: AY/fxX56VRddpcN6EUfz0VNBZY+6JlFDqGMNEyPA/Yt1eK29LtXr6vGCLldvKmySh6x
	qvOlHjQfornoZdqxBiKw/Ap/7JegfD0J6doXqtPjKYsV/7FfgalXQdH5OBb0ovbVH35UGAiph9k
	W8VR8atGFFnMqXEushhllei5WhkLi/ca+PyKGQA9GUjx6DRwNH7+NNWOrltjjCukSZwo6E/CjfF
	5mzBpPT+XcLSmH3JKdBYeb2jiH2Jp5wRGQBonBp+6oR1Vl8nraWeqNdIU5HOT3LsuUy0PU=
X-Google-Smtp-Source: AGHT+IFO+RpoNDZDN3/Z2Q/ZzZyWrScI4EVlu0146kiXmqLHsakT+qYD/TevzC4mH7dAzQE/7rGbYgKrz+bwhKKWgdE=
X-Received: by 2002:a05:6102:5684:b0:5e5:6eee:8ae7 with SMTP id
 ada2fe7eead31-5eb1a60bf0dmr1006969137.2.1766158765998; Fri, 19 Dec 2025
 07:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20251121141230.489294-1-jj251510319013@gmail.com>
 <20251122145924.381725-1-jj251510319013@gmail.com> <CAHUa44HFC+BTO3KfaNF1LHiM7frgt2myzZ_85Mbf1t2gUY9iSg@mail.gmail.com>
 <aSVgctqRSy5_vvkN@sumit-X1> <aSVhBn0LR2CwM9p3@sumit-X1> <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
 <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com>
 <CAJwFiGLRVZyr7Hb3PtGyA319hCYEJh9t8XY_amyjhUgqnrZycQ@mail.gmail.com>
 <CAHUa44GPuP+qdw2HPBgtrQNXovA7e5+yskrPRgh4D4OMutEJTA@mail.gmail.com>
 <CAJwFiGLNh-qu9ezQOmTBh3Dujf=mPRyzKBVXLV-A=GxhwcH-0w@mail.gmail.com> <CAHUa44Eq=P5G4vKSq5TyJx5qF9E5q=+pHexMg41X85NCX4SpHA@mail.gmail.com>
In-Reply-To: <CAHUa44Eq=P5G4vKSq5TyJx5qF9E5q=+pHexMg41X85NCX4SpHA@mail.gmail.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Fri, 19 Dec 2025 23:38:48 +0800
X-Gm-Features: AQt7F2rav0r9lCfOqs_NRjzMBmp_cEbPgPSoG0P_-7iEY4FF9j8znaiEBcd0TEE
Message-ID: <CAJwFiGKw8+T3v3H+=bBtWzV1kuXKBq9gRTWGpS4iS4ictWOAtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.217.52:from];
	DNSWL_BLOCKED(0.00)[209.85.217.52:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVFROM(0.00)[gmail.com]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C64F643035
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: NGOZUDTQVCGKN5HEB2CIXJUEUML3446M
X-Message-ID-Hash: NGOZUDTQVCGKN5HEB2CIXJUEUML3446M
X-Mailman-Approved-At: Mon, 29 Dec 2025 08:10:27 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NGOZUDTQVCGKN5HEB2CIXJUEUML3446M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens

Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=9C=
=889=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:31=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Aristo,
>
> On Sun, Dec 7, 2025 at 3:01=E2=80=AFPM Aristo Chen <jj251510319013@gmail.=
com> wrote:
> >
> > Hi Jens,
> >
> > Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=
=9C=883=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:51=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > Hi,
> > >
> > > On Tue, Dec 2, 2025 at 10:54=E2=80=AFAM Aristo Chen <jj251510319013@g=
mail.com> wrote:
> > > >
> > > > Hi Jens
> > > >
> > > > Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B41=
2=E6=9C=881=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:06=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Mon, Dec 1, 2025 at 12:48=E2=80=AFPM Aristo Chen <jj2515103190=
13@gmail.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=
=9C=8825=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:55=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > > > > >
> > > > > > > On Tue, Nov 25, 2025 at 01:23:22PM +0530, Sumit Garg via OP-T=
EE wrote:
> > > > > > > > On Mon, Nov 24, 2025 at 08:15:04AM +0100, Jens Wiklander wr=
ote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On Sat, Nov 22, 2025 at 4:00=E2=80=AFPM Wei Ming Chen <jj=
251510319013@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Aristo Chen <aristo.chen@canonical.com>
> > > > > > > > > >
> > > > > > > > > > Today the only way to read the OP-TEE OS version is fro=
m dmesg/journal
> > > > > > > > > > logs, which can be lost as buffers roll over. Capture t=
he OS revision
> > > > > > > > > > (major/minor/build_id) from secure world for both SMC a=
nd FF-A ABIs, store
> > > > > > > > > > it in the OP-TEE driver, and expose a stable userspace =
readout via
> > > > > > > > > > /sys/class/tee/tee*/optee_os_revision.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/tee/optee/core.c          | 19 +++++++++++++++=
++++
> > > > > > > > > >  drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
> > > > > > > > > >  drivers/tee/optee/optee_private.h | 17 +++++++++++++++=
++
> > > > > > > > > >  drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
> > > > > > > > > >  4 files changed, 58 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > This appears to be a feature that could be useful for all=
 TEEs.
> > > > > > > >
> > > > > > > > True, it is something that TEE core should support. Althoug=
h I would
> > > > > > > > have preferred to extend TEE_IOC_VERSION since that's the c=
ommon way the
> > > > > > > > user-space library get's TEE implementation specific inform=
ation. But
> > > > > > > > since it being already a user-space ABI which doesn't offer=
 extension.
> > > > > > > > Maybe we can consider adding TEE_IOC_REVERSION instead of s=
ysfs.
> > > > > > >
> > > > > > > Ah, typo here:
> > > > > > >
> > > > > > > s/TEE_IOC_REVERSION/TEE_IOC_REVISION/
> > > > > > >
> > > > > > > -Sumit
> > > > > > >
> > > > > > > >
> > > > > > > > But before doing that we need to know who is the actual con=
sumer here
> > > > > > > > from user-space perspective? Will the client applications a=
lso depend on
> > > > > > > > the TEE implementation revision?
> > > > > > My current thinking is that if the TEE revision is exposed, use=
rs can write a
> > > > > > script to capture the platform state and record the exact secur=
e OS revision
> > > > > > even after the dmesg/journalctl logs have rolled over. This wou=
ld significantly
> > > > > > improve bug triage and regression tracking.
> > > > > >
> > > > > > In my case, I have a package with precompiled xtest binaries fo=
r multiple
> > > > > > releases (from 3.14 to 4.6), and I work with different platform=
s that run
> > > > > > different OP-TEE OS versions. Having a reliable way to obtain t=
he TEE
> > > > > > revision would help a lot, as it would allow me to select the c=
orrect xtest
> > > > > > version when running tests.
> > > > >
> > > > > I'm concerned that the ABI might be misused to be part of what th=
e
> > > > > client expects from the TEE. You even express that as a use case.=
 I'd
> > > > > rather fix the problem with xtest.
> > > >
> > > > Thanks for the feedback! To clarify: currently, the OP-TEE OS revis=
ion
> > > > I expose in
> > > > sysfs is the same value already printed in dmesg at boot
> > > >  (e.g., =E2=80=9Coptee: revision 4.8 (XXXXXX)=E2=80=9D).
> > > >
> > > > Are your concerns specifically about clients inferring capabilities
> > > > from a revision
> > > > string (=E2=80=9Crev X.Y implies feature Z=E2=80=9D)? If so, I agre=
e that=E2=80=99s fragile
> > > > and not the intent.
> > >
> > > Yes
> >
> > Thanks for clarifying the concern!
> >
> > >
> > > > I=E2=80=99m happy to add a short note in the doc that this is infor=
mational
> > > > only and that
> > > > feature detection must use proper capability queries.
> > > >
> > > > Please let me know if that addresses the worry, or if there=E2=80=
=99s another
> > > > concern I=E2=80=99m
> > > > missing.
> > >
> > > Adding APIs that aren't supposed to be used seems odd. Do you know if
> > > there are examples in the kernel for this kind of thing?
> > I=E2=80=99ve done some research and, as far as I can tell, the TEE core=
 already
> > provides an informational-only file at /sys/class/tee/tee0/implementati=
on_id.
> > My understanding is that it was introduced roughly 10 years ago. Howeve=
r,
> > I haven=E2=80=99t found any documentation clarifying its intended purpo=
se, so I=E2=80=99m
> > assuming this may be a similar situation. I=E2=80=99d appreciate it if =
you could correct
> > me if I=E2=80=99m wrong.
>
> That one is for a quick way for a client to tell the different TEE
> device implementations apart. You're right, it resembles your case,
> except that this is part of a well-defined ABI.
>
> >
> > Also, here are some files with similiar purposes:
> > - /sys/devices/system/cpu/cpu*/microcode/version
> > - /sys/devices/virtual/dmi/id/{bios_date,bios_release,bios_vendor,bios_=
version}
> > - /sys/kernel/security/apparmor/revision
>
> Thanks, this is good background information.
>
> We have a BoF session on the TEE subsystem at LPC on Friday [1]. We'll
> take the opportunity to discuss it there.

Just a quick follow-up on this patch, has there been any decision or
direction from that discussion?
I=E2=80=99m happy to rework the patch in whatever direction the group prefe=
rs.

>
> [1] https://lpc.events/event/19/contributions/2107/
>
> Cheers,
> Jens

Best regards,
Aristo
