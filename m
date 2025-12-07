Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2F8D3B7DD
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 08:46:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7DB2350014
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 08:46:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DHW305T9;
	dkim-atps=neutral
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3204B4FD0D
	for <op-tee@lists.trustedfirmware.org>; Sun,  7 Dec 2025 14:01:46 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93720298f86so2154249241.2
        for <op-tee@lists.trustedfirmware.org>; Sun, 07 Dec 2025 06:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765116106; x=1765720906; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGDK6gptuxdR+4EqmnbewGtNRveWZo14T6W6zGbna6A=;
        b=DHW305T9LK044TlboD/8VB0BNOx+EkqyoxLHpYhueCzN/W4cp8gdyqDKyFJDFwSAJT
         TsdlW185n7wbBFg9JNecQIsRiwv0YTc7ONHCXOXQUJukYSPiKGXlN+ZxN6gXD9PkvQYU
         sfdgP96xu/BCQ+MQBGAF0RhWPlLJ2nuqaxTGBA8kwFhLZ9wMYGb1unX/M+N1CbWGeGaW
         BuCk090/8t3AvNtHn8WBajD2ZH2nK20znRDCP+2YBR4tNKE69nYSCMcWd54yC0Yg40hS
         wTlzxlfF5RdlqnEnDzSERygycjjHzDOXbtsOIrDhKKspeLCmAhvqecdzXfGE83lWK5v9
         H9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765116106; x=1765720906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gGDK6gptuxdR+4EqmnbewGtNRveWZo14T6W6zGbna6A=;
        b=K4fyWGVxnDng7cXys9I5kcqIYohQdwgeMFDO9ZEaSEUK4p5J7+6zWNtuu8KhMgUKSm
         BhwBLwgGvHow0lWlevvHyfIjLO28NaglBgC4MWWj5DQJG2A7P3TyftpzHGaIf5bR22Uo
         meNP7eFdTH6Wiyf328p7tm1yCojubHCHocpO9jOzHYXh+VNUUGm2qCEsQXPPDBjgaHLs
         HXxEW8I5ZBqVLkvIo7W6XmrxXJnIZyIp2NGeMFK3ezu9SZ4rXOtTTn45s+sNf35CsJTg
         Jp7fMcaO7GCaOsb3L1RlHtz0b5q56s20bHShslyH7bPHPZuFj9UQL0UWLh57LBzgWYR2
         i2dw==
X-Forwarded-Encrypted: i=1; AJvYcCU5U5WAlz9ymbo3K/f/dzk4pVvZasp+BqejQZbrgXKMh62itV7FLfCa4a3OaTOUtlMmBM+H16o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzYSqvH3rafD4hhpyOEqKh6AMdYdgkNfLAtpQOE/fgHrG6rdyvx
	FZXd6/eq96B8Qy5PbDQ8wKZO+WFrrjmdsE/SQGTYctxN4KnbS1++fH+SiFJHFuBiwu+jud7QybF
	m67DZ5JLlElStWb2C0oeO2rlXtVkXUFg=
X-Gm-Gg: ASbGncsUEFBfCqlunp0iQCO2fLFY+3jltfbv/8p7wWRXBhfOrlvDAh66F14qBwM+iiT
	iTz5Av4cbpv4gAZpcsvC/QKOfEH0Hok0HnZ/BP6K/mEnMRQa36KSYIc27eKc29y/mpqwhh1to6f
	qNcdi84xCegvfvmR/WzCO5CQqWdmpX4m4TZ03KK38sQjZ/XfJFN+tlbPi4zfz6IkCfKoZlueBlq
	pxk1l5vm/vmy1g+5sSiiNTCwz1cmcGwzZD0eKaQXEz7EM9FybZWtPvI8sZ5khJs1kUE7f8+
X-Google-Smtp-Source: AGHT+IE3IG9MLbbzq+AUuYF5RJT24EXTFCdqd8BF63Fiml09MAYI/eMC6e9LQCX1yxKSxe40TncH+rGaA4Ws/MKt2dQ=
X-Received: by 2002:a05:6102:32d3:b0:5dd:b0e6:c4cb with SMTP id
 ada2fe7eead31-5e52c999d7fmr1485428137.9.1765116105525; Sun, 07 Dec 2025
 06:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20251121141230.489294-1-jj251510319013@gmail.com>
 <20251122145924.381725-1-jj251510319013@gmail.com> <CAHUa44HFC+BTO3KfaNF1LHiM7frgt2myzZ_85Mbf1t2gUY9iSg@mail.gmail.com>
 <aSVgctqRSy5_vvkN@sumit-X1> <aSVhBn0LR2CwM9p3@sumit-X1> <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
 <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com>
 <CAJwFiGLRVZyr7Hb3PtGyA319hCYEJh9t8XY_amyjhUgqnrZycQ@mail.gmail.com> <CAHUa44GPuP+qdw2HPBgtrQNXovA7e5+yskrPRgh4D4OMutEJTA@mail.gmail.com>
In-Reply-To: <CAHUa44GPuP+qdw2HPBgtrQNXovA7e5+yskrPRgh4D4OMutEJTA@mail.gmail.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Sun, 7 Dec 2025 22:01:09 +0800
X-Gm-Features: AQt7F2pE8iIZE0U3bo1Erb0nPqq1JWhoVdg_CPO0bzBspM6GZFIoTycBCdgR0Xo
Message-ID: <CAJwFiGLNh-qu9ezQOmTBh3Dujf=mPRyzKBVXLV-A=GxhwcH-0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ---
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3204B4FD0D
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.222.54:from];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[209.85.222.54:server fail];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.54:from];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+]
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 4PVY3FA6YUQDXMI6RMXFYOHXVUBCNW6N
X-Message-ID-Hash: 4PVY3FA6YUQDXMI6RMXFYOHXVUBCNW6N
X-Mailman-Approved-At: Mon, 08 Dec 2025 08:45:53 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4PVY3FA6YUQDXMI6RMXFYOHXVUBCNW6N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens,

Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=9C=
=883=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:51=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> On Tue, Dec 2, 2025 at 10:54=E2=80=AFAM Aristo Chen <jj251510319013@gmail=
.com> wrote:
> >
> > Hi Jens
> >
> > Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=
=9C=881=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:06=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > Hi,
> > >
> > > On Mon, Dec 1, 2025 at 12:48=E2=80=AFPM Aristo Chen <jj251510319013@g=
mail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=9C=
=8825=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:55=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > >
> > > > > On Tue, Nov 25, 2025 at 01:23:22PM +0530, Sumit Garg via OP-TEE w=
rote:
> > > > > > On Mon, Nov 24, 2025 at 08:15:04AM +0100, Jens Wiklander wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Sat, Nov 22, 2025 at 4:00=E2=80=AFPM Wei Ming Chen <jj2515=
10319013@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Aristo Chen <aristo.chen@canonical.com>
> > > > > > > >
> > > > > > > > Today the only way to read the OP-TEE OS version is from dm=
esg/journal
> > > > > > > > logs, which can be lost as buffers roll over. Capture the O=
S revision
> > > > > > > > (major/minor/build_id) from secure world for both SMC and F=
F-A ABIs, store
> > > > > > > > it in the OP-TEE driver, and expose a stable userspace read=
out via
> > > > > > > > /sys/class/tee/tee*/optee_os_revision.
> > > > > > > >
> > > > > > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > > > > > > ---
> > > > > > > >  drivers/tee/optee/core.c          | 19 +++++++++++++++++++
> > > > > > > >  drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
> > > > > > > >  drivers/tee/optee/optee_private.h | 17 +++++++++++++++++
> > > > > > > >  drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
> > > > > > > >  4 files changed, 58 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > This appears to be a feature that could be useful for all TEE=
s.
> > > > > >
> > > > > > True, it is something that TEE core should support. Although I =
would
> > > > > > have preferred to extend TEE_IOC_VERSION since that's the commo=
n way the
> > > > > > user-space library get's TEE implementation specific informatio=
n. But
> > > > > > since it being already a user-space ABI which doesn't offer ext=
ension.
> > > > > > Maybe we can consider adding TEE_IOC_REVERSION instead of sysfs=
.
> > > > >
> > > > > Ah, typo here:
> > > > >
> > > > > s/TEE_IOC_REVERSION/TEE_IOC_REVISION/
> > > > >
> > > > > -Sumit
> > > > >
> > > > > >
> > > > > > But before doing that we need to know who is the actual consume=
r here
> > > > > > from user-space perspective? Will the client applications also =
depend on
> > > > > > the TEE implementation revision?
> > > > My current thinking is that if the TEE revision is exposed, users c=
an write a
> > > > script to capture the platform state and record the exact secure OS=
 revision
> > > > even after the dmesg/journalctl logs have rolled over. This would s=
ignificantly
> > > > improve bug triage and regression tracking.
> > > >
> > > > In my case, I have a package with precompiled xtest binaries for mu=
ltiple
> > > > releases (from 3.14 to 4.6), and I work with different platforms th=
at run
> > > > different OP-TEE OS versions. Having a reliable way to obtain the T=
EE
> > > > revision would help a lot, as it would allow me to select the corre=
ct xtest
> > > > version when running tests.
> > >
> > > I'm concerned that the ABI might be misused to be part of what the
> > > client expects from the TEE. You even express that as a use case. I'd
> > > rather fix the problem with xtest.
> >
> > Thanks for the feedback! To clarify: currently, the OP-TEE OS revision
> > I expose in
> > sysfs is the same value already printed in dmesg at boot
> >  (e.g., =E2=80=9Coptee: revision 4.8 (XXXXXX)=E2=80=9D).
> >
> > Are your concerns specifically about clients inferring capabilities
> > from a revision
> > string (=E2=80=9Crev X.Y implies feature Z=E2=80=9D)? If so, I agree th=
at=E2=80=99s fragile
> > and not the intent.
>
> Yes

Thanks for clarifying the concern!

>
> > I=E2=80=99m happy to add a short note in the doc that this is informati=
onal
> > only and that
> > feature detection must use proper capability queries.
> >
> > Please let me know if that addresses the worry, or if there=E2=80=99s a=
nother
> > concern I=E2=80=99m
> > missing.
>
> Adding APIs that aren't supposed to be used seems odd. Do you know if
> there are examples in the kernel for this kind of thing?
I=E2=80=99ve done some research and, as far as I can tell, the TEE core alr=
eady
provides an informational-only file at /sys/class/tee/tee0/implementation_i=
d.
My understanding is that it was introduced roughly 10 years ago. However,
I haven=E2=80=99t found any documentation clarifying its intended purpose, =
so I=E2=80=99m
assuming this may be a similar situation. I=E2=80=99d appreciate it if you =
could correct
me if I=E2=80=99m wrong.

Also, here are some files with similiar purposes:
- /sys/devices/system/cpu/cpu*/microcode/version
- /sys/devices/virtual/dmi/id/{bios_date,bios_release,bios_vendor,bios_vers=
ion}
- /sys/kernel/security/apparmor/revision

>
> Cheers,
> Jens

Best Regards,
Aristo
