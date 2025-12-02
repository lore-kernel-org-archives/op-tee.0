Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37828CFD2F6
	for <op-tee@archiver.kernel.org>; Tue,  2 Dec 2025 12:36:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6D73D4319D
	for <op-tee@archiver.kernel.org>; Tue,  2 Dec 2025 12:36:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mTWEVi5E;
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C82504316A
	for <op-tee@lists.trustedfirmware.org>; Tue,  2 Dec 2025 09:54:39 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-559712e8914so3351981e0c.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 02 Dec 2025 01:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764669279; x=1765274079; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NlGQw0v69a+PMqBEGYFKTGBvqplxYlfJNbuM31M3Z4=;
        b=mTWEVi5ED0t1X7lAZU5VgXc4MKL9Al/2TnVGLa0gh244/OvlXCDYIMDH/zMlJjvZt+
         d9Mn/iEIORsM6Djmm539s4u6xNw7GTuVM+dqMQ3bi/kmCi9+933lZFiByKXNzbwkXQZG
         pRopbxzxZSBRxoMhuShTGg6GH0vrKdeLPyGHMwmK4lCHCvkE5gRWHcStoLrkdy96Fc0Z
         qYDL5XciyzzKab5xZNZDYbzd9Rnp7nXOq1ZJP+7trrHRT3fQiRTOT9QTNvwUaFnPDxcW
         dmDTllL42mMNhXtrMzu7ZA6CiRjkRoAKtwZ+64sa5JmTEkUQfgu9tpDcC0iKCyMKikHz
         dl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764669279; x=1765274079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5NlGQw0v69a+PMqBEGYFKTGBvqplxYlfJNbuM31M3Z4=;
        b=arpH8aYGni06QEbDKvmIeP6WMRsS+z/cSOQ0oJxePUjOYgG39JU5MRtA0WLXevz6Oz
         cDkpbbjd/fTp0042rqqws3AYZUfPz5Q7RU6onC3wcetez1+dJLAxdIqLxNKnsPUbat/t
         H3nMnlqIzP31PZmdewhUNqWgqvU3H5CISXWXCsXTGwBhYMbLaL7E6S5uXwIoDhJUXcug
         e53i7bufcrzodw6eJY+shsQpnUnk8ozG/AFG/Lyiga1O8CrvdQdcZj3/ropjNxoHL13y
         mtAeKC6dKLgcBBUOgFlHDukpWf5xkY9RnZf2dlDt6CsrnvqSlSSII5c32mK0uc0L7gSm
         gkgw==
X-Forwarded-Encrypted: i=1; AJvYcCU0i6Qaoewu6qppagLTNBNr4SiwFloPV6cCFwoyISj0icEs8Pb25ehuzjF0kLl17OJIGaUoDus=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxF1euz0l05Q+YSHDM9JwFuRJeKsbZjJKlGi/8WigKQchfS4wIo
	5SpIknYG96FdRG4dL/saiMuA3gygUmdWcTQrJPEdEvi9NPrlHfPlQ2nlChdiwxW6rmN9FYrRQcZ
	MnNbBBEH2oJ+LEsTh8UEm0pbhElTDPBw=
X-Gm-Gg: ASbGncvOgfTo5RVpYB38ATdvLP+K6Eulj5++epMePIRfJOcZmEM1hQw02rLXNhp7JcZ
	nW0C3RrOdL0vgS0rwyX1ZvcjrCAi73ZRVTE05Pd5R9t2iCpir4Et3poe7Yax1ypl7ibz6qKHLPe
	bx1EXGprMskvu4NyTFBKADXd3zKj1OwbaOmrmG9vZNLlGpv29Q1e5xdOMo7AE7IBEdeOojuVeXf
	yqZwe9vrq0o/xTI17vwwMh815lN18QN5SvSfnc/cNu0hi+4MWFVIMKvQdOrN3qq+EABww==
X-Google-Smtp-Source: AGHT+IFZaQ49MbzpzKTDmKfPWCTDQh2J5jQy1RYvR7SXCqDsVY7d7Os/UoIk1P3d2pfFHrJk2G7XKSiJ1mHlSpf4De4=
X-Received: by 2002:a05:6122:a15:b0:55b:1a3d:de28 with SMTP id
 71dfb90a1353d-55cd778c789mr12833923e0c.16.1764669279167; Tue, 02 Dec 2025
 01:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20251121141230.489294-1-jj251510319013@gmail.com>
 <20251122145924.381725-1-jj251510319013@gmail.com> <CAHUa44HFC+BTO3KfaNF1LHiM7frgt2myzZ_85Mbf1t2gUY9iSg@mail.gmail.com>
 <aSVgctqRSy5_vvkN@sumit-X1> <aSVhBn0LR2CwM9p3@sumit-X1> <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
 <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com>
In-Reply-To: <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Tue, 2 Dec 2025 17:54:02 +0800
X-Gm-Features: AWmQ_bkkce-lO3Z81UB9QZUV7SoY8ZWRaO36KcSLFWkNCVsrYg9dbxm0yOXLFKk
Message-ID: <CAJwFiGLRVZyr7Hb3PtGyA319hCYEJh9t8XY_amyjhUgqnrZycQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ---
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C82504316A
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.182:from];
	BLOCKLISTDE_FAIL(0.00)[209.85.221.182:server fail];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.182:from]
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: NLSHKQPWZT2EQWLQHQHX27JT4G3DOWHD
X-Message-ID-Hash: NLSHKQPWZT2EQWLQHQHX27JT4G3DOWHD
X-Mailman-Approved-At: Tue, 02 Dec 2025 12:36:13 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NLSHKQPWZT2EQWLQHQHX27JT4G3DOWHD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens

Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=9C=
=881=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:06=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> On Mon, Dec 1, 2025 at 12:48=E2=80=AFPM Aristo Chen <jj251510319013@gmail=
.com> wrote:
> >
> > Hi,
> >
> > Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=9C=8825=
=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:55=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Tue, Nov 25, 2025 at 01:23:22PM +0530, Sumit Garg via OP-TEE wrote=
:
> > > > On Mon, Nov 24, 2025 at 08:15:04AM +0100, Jens Wiklander wrote:
> > > > > Hi,
> > > > >
> > > > > On Sat, Nov 22, 2025 at 4:00=E2=80=AFPM Wei Ming Chen <jj25151031=
9013@gmail.com> wrote:
> > > > > >
> > > > > > From: Aristo Chen <aristo.chen@canonical.com>
> > > > > >
> > > > > > Today the only way to read the OP-TEE OS version is from dmesg/=
journal
> > > > > > logs, which can be lost as buffers roll over. Capture the OS re=
vision
> > > > > > (major/minor/build_id) from secure world for both SMC and FF-A =
ABIs, store
> > > > > > it in the OP-TEE driver, and expose a stable userspace readout =
via
> > > > > > /sys/class/tee/tee*/optee_os_revision.
> > > > > >
> > > > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > > > > ---
> > > > > >  drivers/tee/optee/core.c          | 19 +++++++++++++++++++
> > > > > >  drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
> > > > > >  drivers/tee/optee/optee_private.h | 17 +++++++++++++++++
> > > > > >  drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
> > > > > >  4 files changed, 58 insertions(+), 4 deletions(-)
> > > > >
> > > > > This appears to be a feature that could be useful for all TEEs.
> > > >
> > > > True, it is something that TEE core should support. Although I woul=
d
> > > > have preferred to extend TEE_IOC_VERSION since that's the common wa=
y the
> > > > user-space library get's TEE implementation specific information. B=
ut
> > > > since it being already a user-space ABI which doesn't offer extensi=
on.
> > > > Maybe we can consider adding TEE_IOC_REVERSION instead of sysfs.
> > >
> > > Ah, typo here:
> > >
> > > s/TEE_IOC_REVERSION/TEE_IOC_REVISION/
> > >
> > > -Sumit
> > >
> > > >
> > > > But before doing that we need to know who is the actual consumer he=
re
> > > > from user-space perspective? Will the client applications also depe=
nd on
> > > > the TEE implementation revision?
> > My current thinking is that if the TEE revision is exposed, users can w=
rite a
> > script to capture the platform state and record the exact secure OS rev=
ision
> > even after the dmesg/journalctl logs have rolled over. This would signi=
ficantly
> > improve bug triage and regression tracking.
> >
> > In my case, I have a package with precompiled xtest binaries for multip=
le
> > releases (from 3.14 to 4.6), and I work with different platforms that r=
un
> > different OP-TEE OS versions. Having a reliable way to obtain the TEE
> > revision would help a lot, as it would allow me to select the correct x=
test
> > version when running tests.
>
> I'm concerned that the ABI might be misused to be part of what the
> client expects from the TEE. You even express that as a use case. I'd
> rather fix the problem with xtest.

Thanks for the feedback! To clarify: currently, the OP-TEE OS revision
I expose in
sysfs is the same value already printed in dmesg at boot
 (e.g., =E2=80=9Coptee: revision 4.8 (XXXXXX)=E2=80=9D).

Are your concerns specifically about clients inferring capabilities
from a revision
string (=E2=80=9Crev X.Y implies feature Z=E2=80=9D)? If so, I agree that=
=E2=80=99s fragile
and not the intent.
I=E2=80=99m happy to add a short note in the doc that this is informational
only and that
feature detection must use proper capability queries.

Please let me know if that addresses the worry, or if there=E2=80=99s anoth=
er
concern I=E2=80=99m
missing.

Thanks,
Aristo
>
> Cheers,
> Jens
