Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F298AD116F9
	for <op-tee@archiver.kernel.org>; Mon,  1 Dec 2025 13:06:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 41B025007B
	for <op-tee@archiver.kernel.org>; Mon,  1 Dec 2025 13:06:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uy7AML/O;
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E1A4243154
	for <op-tee@lists.trustedfirmware.org>; Mon,  1 Dec 2025 13:06:19 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6579872f00dso1655303eaf.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 01 Dec 2025 05:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764594379; x=1765199179; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXgYSo9DDqXry8M/Vh0opQUukTDcLEBMhcfDTzUT1bc=;
        b=uy7AML/OeWpJErqwR0pyKy6hySUhteLV3dWUXvwY8FDqHu1FkfCS4mHRbDvqgIRxLs
         duB24ZFxCCAR5fEE/OjXghcBjBQO4TmcUbfdG4ldRp+mvrbkhN+G80XQur1SDPao2Iyj
         bcCFwg15tl55FGL3tWhivGhCJMBgSDMBN9yNx6PA6u47lYaSQmCofK918vUVcgov3ZRk
         wqK1nhr8+Qb7GqHqWdEJobG7jVqS59rD+oZkNlUCMmgZ4+fLbvLA0wjvcmBzcIm1aR7F
         WkVxFLx0LFbAkjUrJvl+J+wDZxuXNbDhbH3CpBBriFfm2w11LjUlwgpbQTBYiyhbjsGb
         MCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764594379; x=1765199179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pXgYSo9DDqXry8M/Vh0opQUukTDcLEBMhcfDTzUT1bc=;
        b=PxDiyLCkGlvm0q2OhQ+3zzj83Ewm6pUoHGNUp8JV4QbadJRF+UXCbwYPSHlcnLG1uJ
         aVcdPJrOBEEYkZU2MFPL9WZYQyPTaNTMoJt4fLDZ9ZGdm0xuaSQ0Otp2hZGooYuSnvdg
         UEmd0y+oSa3BJcOxJqtoBtpBf7sbNYtcmNFu3yYyESoEidwabYhc5NgjrGgDfp/NAEe0
         G/fD/JlNeWDH8Eraox1G194wNU3EvZNV7R9sboVRrZb3QBVGUTq2uBWEAua99MxPMz/Y
         2wxYqMmx2op8xBa5IAM5BvExlKrEK1zBqt2WF7/cqCmLDPtErMNJgsEoJlC7YLfPUQuA
         9mgA==
X-Forwarded-Encrypted: i=1; AJvYcCU1a25gMP9uI62TvYlgZj8cKdQCd4OSurJAlzXyGnD3KkGzwfV+15Ljog0tqRiiSYs0nq+oVRg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx9d1neGdutl2ZRDpOTUltmKuS6wrWDA0l0yK+i0sLiodLf29Ni
	6tQ3QRN4pwG/LXTzQzKDCeR9fYL1acsMYKiXRi2vguFmmeiXaLQVHTsgbZT6ipn0W//J1/pFhnu
	y2rm5yOiRaP62nREB28C5DV/xNteNk8WJStkPby8B3DX1
X-Gm-Gg: ASbGncuL47KM968p5a+rpYAuN6xzOOs5Xy+LRkmZCWexZZTwlVSz9WUDB51aDsgFl7e
	YQX+2KFGe0btw2mm1636ckTC3pktt020bddvbhyJzQE272D5lf099jXhTX9pPD9XTFfRmym2SFh
	zZWFdssRFvdNd2fX/g8G9fh55CogewzWILRYi8Q8OwZLswQZ3M8PKjz64kUGDWdy8n2z3BdHTq0
	6iv9uJJP+GlOBvZuHDgcNSVeJYZrR7UcsyfkfDHqyDCOONvtstyDSXa8Qy9MsOqUP/a1MZYeI/r
	CAv8PrEK7V5H67S+6C9L8igRDw==
X-Google-Smtp-Source: AGHT+IG0s21RD5xZevbEnRCRTE7dSd1xq3a60tl4/3CVlMBvBhYeUyMRW7tqqGJDP4St5aDzgiXgE32tb6HA0jWrmoY=
X-Received: by 2002:a05:6820:4c09:b0:657:61da:5089 with SMTP id
 006d021491bc7-65790b6080fmr13558965eaf.7.1764594379052; Mon, 01 Dec 2025
 05:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20251121141230.489294-1-jj251510319013@gmail.com>
 <20251122145924.381725-1-jj251510319013@gmail.com> <CAHUa44HFC+BTO3KfaNF1LHiM7frgt2myzZ_85Mbf1t2gUY9iSg@mail.gmail.com>
 <aSVgctqRSy5_vvkN@sumit-X1> <aSVhBn0LR2CwM9p3@sumit-X1> <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
In-Reply-To: <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 1 Dec 2025 14:06:07 +0100
X-Gm-Features: AWmQ_bl9RXhEdnLAZcxF5QHjZiNA8ySjAy9b7eIh-WctpwaiCBwIlim_h70BQVQ
Message-ID: <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Aristo Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E1A4243154
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.46:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[linaro.org:dkim];
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
Message-ID-Hash: PDFG3PQIMRSJ3M3RFDEMXTTLSSDP2QES
X-Message-ID-Hash: PDFG3PQIMRSJ3M3RFDEMXTTLSSDP2QES
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PDFG3PQIMRSJ3M3RFDEMXTTLSSDP2QES/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Mon, Dec 1, 2025 at 12:48=E2=80=AFPM Aristo Chen <jj251510319013@gmail.c=
om> wrote:
>
> Hi,
>
> Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=9C=8825=
=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:55=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Tue, Nov 25, 2025 at 01:23:22PM +0530, Sumit Garg via OP-TEE wrote:
> > > On Mon, Nov 24, 2025 at 08:15:04AM +0100, Jens Wiklander wrote:
> > > > Hi,
> > > >
> > > > On Sat, Nov 22, 2025 at 4:00=E2=80=AFPM Wei Ming Chen <jj2515103190=
13@gmail.com> wrote:
> > > > >
> > > > > From: Aristo Chen <aristo.chen@canonical.com>
> > > > >
> > > > > Today the only way to read the OP-TEE OS version is from dmesg/jo=
urnal
> > > > > logs, which can be lost as buffers roll over. Capture the OS revi=
sion
> > > > > (major/minor/build_id) from secure world for both SMC and FF-A AB=
Is, store
> > > > > it in the OP-TEE driver, and expose a stable userspace readout vi=
a
> > > > > /sys/class/tee/tee*/optee_os_revision.
> > > > >
> > > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > > > ---
> > > > >  drivers/tee/optee/core.c          | 19 +++++++++++++++++++
> > > > >  drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
> > > > >  drivers/tee/optee/optee_private.h | 17 +++++++++++++++++
> > > > >  drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
> > > > >  4 files changed, 58 insertions(+), 4 deletions(-)
> > > >
> > > > This appears to be a feature that could be useful for all TEEs.
> > >
> > > True, it is something that TEE core should support. Although I would
> > > have preferred to extend TEE_IOC_VERSION since that's the common way =
the
> > > user-space library get's TEE implementation specific information. But
> > > since it being already a user-space ABI which doesn't offer extension=
.
> > > Maybe we can consider adding TEE_IOC_REVERSION instead of sysfs.
> >
> > Ah, typo here:
> >
> > s/TEE_IOC_REVERSION/TEE_IOC_REVISION/
> >
> > -Sumit
> >
> > >
> > > But before doing that we need to know who is the actual consumer here
> > > from user-space perspective? Will the client applications also depend=
 on
> > > the TEE implementation revision?
> My current thinking is that if the TEE revision is exposed, users can wri=
te a
> script to capture the platform state and record the exact secure OS revis=
ion
> even after the dmesg/journalctl logs have rolled over. This would signifi=
cantly
> improve bug triage and regression tracking.
>
> In my case, I have a package with precompiled xtest binaries for multiple
> releases (from 3.14 to 4.6), and I work with different platforms that run
> different OP-TEE OS versions. Having a reliable way to obtain the TEE
> revision would help a lot, as it would allow me to select the correct xte=
st
> version when running tests.

I'm concerned that the ABI might be misused to be part of what the
client expects from the TEE. You even express that as a use case. I'd
rather fix the problem with xtest.

Cheers,
Jens
