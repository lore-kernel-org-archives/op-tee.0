Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF267CAC597
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 17:49:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id ED55D43171
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 17:49:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eFXedD7L;
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CDD1440AF0
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Sep 2025 17:49:37 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74ee68bd763so1315068a34.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Sep 2025 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757958577; x=1758563377; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAZioqHrTQ+AevT9cWxUPizrYYw+CkCC2DIwykw40jU=;
        b=eFXedD7L72UbdWvkHuLCzRDrASRLGnlSLodG13g3sh5DD3B3JosO5UkpcG2+xBuybn
         SgVzSspXbWLiiaHzIMIUVntftGFbST+nxQa77KOdB3u0qmOqc7xZo8Ybrsl8yba7izDp
         FPcmWUZKsKpiatxQL/6TVVzca2FDeLwpl3HisuWW47SSJpTyx6OItQu7Mps0tx6RV4tN
         i8Zfwnyk4oN9wHD2PiOzHvoZgh/2R2JVv/UDSQG9hq4gpensLhmNcXigMNm4OJO3GK1/
         QFJe6HrCF+Gg6NiWw8Uuip/BkX4XcuVSaVuXCa7OlEYhWJp0dcnc0ixttfTlUTiqHw6G
         dDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757958577; x=1758563377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAZioqHrTQ+AevT9cWxUPizrYYw+CkCC2DIwykw40jU=;
        b=SXgO5wCc4oOU1y/4xa7V9RH7oDg4zcoWgWJIHAi6zJ4crisKhNlq0mC+AL49X2r1XJ
         ytPZanhACSyaWApI4icO1Vue4dUz7NsqnDIlYNiIUGTXWeWtVnq93ykpyXhAvad7ulyM
         dt04qvrII27IWwqy8DQcBX0xB9H0OQur34lOFp9m7Ww7gmP0/uadEQf/UxxtQ5nUuSm5
         kSNW82p34pVDtuNsvQ7qnJ+a/BxBWizuwTiQKyiXaoLaxQEArJQGxr/Ow4JKk9gRNSpa
         W8hdoCZDErh7t+LJEcXD95b9zJjB3m7xYeiiA+3ZfD0+/7oHP6Dejg7NAhwJELs1+lCI
         GalQ==
X-Forwarded-Encrypted: i=1; AJvYcCVguFcdo/VcD0Ty/tbKJTsrCGfZGudwKOKg2AzwgjYjTzYO9lc0QWGOvmxC8QIXL7kmi3awtS8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw14uoBCNtc8NFX1ystLkPNcCZPC5/PWtEOv+Fekz8VHjDl93hs
	2Agw8U8EkvRip/AqB57kEUQ+FFmYDR99zmu45QPuYEeKY3K5KNM1C2u2iL6lNG1tRu5JAjbCthg
	5q0O3mwfmx9TpIWZzVy/vg8sHdpVYIH9Gf0BV/w+TXosv
X-Gm-Gg: ASbGncuH+R5k4dn3uiq6KXkoX7xPVYmKnzJxCRnwFFfqFatSethwgizbj6V/EUwOR3M
	gUKO44DG7pAwYT+FjqiNvSXBNHiy2kfwNCC2hn50zhL9fdQXWfFijFPC61gN/QRf4gcdsPFg+jk
	tun/2V5E/PJq+XYhI6ZNjBr7dilh7oQuzSek+NtePvkjeCEvzouKuhxXEbT/SZ+52DJZY+JixOd
	Xz5nR/5
X-Google-Smtp-Source: AGHT+IFH2g34vEwZJetBbwvZ3SomF8yWsdtaRubWzROFmfV7fPJWquu4ln8JWGnCxhfWDa7z7TN6AkCfw2+pHb5lOKU=
X-Received: by 2002:a05:6830:6ac2:b0:745:a1d8:9deb with SMTP id
 46e09a7af769-753529994cemr6368252a34.1.1757958577063; Mon, 15 Sep 2025
 10:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
 <CAHUa44Fow6BhkdTki=rt2psOC=dq99cRgwXsVagmQU7fttXyCw@mail.gmail.com> <mir6lhkj456ra3i6w7def4rrtzw663f66l66cz4s3gxxvueeqk@ils2hjklbp4y>
In-Reply-To: <mir6lhkj456ra3i6w7def4rrtzw663f66l66cz4s3gxxvueeqk@ils2hjklbp4y>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 15 Sep 2025 19:49:25 +0200
X-Gm-Features: AS18NWAR-VBm4g9R0EH1G3hbl6PkG8dirAOCNZkRJpCTr8DYOgGvR9V6YWQJ574
Message-ID: <CAHUa44Hb1NMCmqbquuQ=f=2kxPL5ik_2m_EiwvoRSew3niXBfg@mail.gmail.com>
Subject: Re: [PATCH v12 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CDD1440AF0
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.50:from];
	MIME_GOOD(-0.10)[text/plain];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[209.85.210.50:from];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: DPWCUFBV5RZOKDWIHCAUSFAKGQPH23UK
X-Message-ID-Hash: DPWCUFBV5RZOKDWIHCAUSFAKGQPH23UK
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DPWCUFBV5RZOKDWIHCAUSFAKGQPH23UK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Mon, Sep 15, 2025 at 4:05=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Fri, Sep 12, 2025 at 10:21:55AM +0200, Jens Wiklander wrote:
> > Hi,
> >
> > On Fri, Sep 12, 2025 at 6:07=E2=80=AFAM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> > >
> > > This patch series introduces a Trusted Execution Environment (TEE)
> > > driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TA=
s)
> > > and services to run securely. It uses an object-based interface, wher=
e
> > > each service is an object with sets of operations. Clients can invoke
> > > these operations on objects, which can generate results, including ot=
her
> > > objects. For example, an object can load a TA and return another obje=
ct
> > > that represents the loaded TA, allowing access to its services.
> > >
> > [snip]
> >
> > I'm OK with the TEE patches, Sumit and I have reviewed them.
> >
>
> Happy to hear that.
>
> > There were some minor conflicts with other patches I have in the pipe
> > for this merge window, so this patchset is on top of what I have to
> > avoid merge conflicts.
> >
> > However, the firmware patches are for code maintained by Bj=C3=B6rn.
> > Bj=C3=B6rn, how would you like to do this? Can I take them via my tree,=
 or
> > what do you suggest?
> >
>
> Please pull:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20250911-q=
com-tee-using-tee-ss-without-mem-obj-v12-2-17f07a942b8d@oss.qualcomm.com

I've pulled from you're tree. I'm picking up the remaining patches
from this patch set.

Thanks,
Jens

>
> Regards,
> Bjorn
>
> > It's urgent to get this patchset into linux-next if it's to make it
> > for the coming merge window. Ideally, I'd like to send my pull request
> > to arm-soc during this week.
> >
> > Cheers,
> > Jens
> >
> > >
> > > ---
> > > Amirreza Zarrabi (11):
> > >       firmware: qcom: tzmem: export shm_bridge create/delete
> > >       firmware: qcom: scm: add support for object invocation
> > >       tee: allow a driver to allocate a tee_device without a pool
> > >       tee: add close_context to TEE driver operation
> > >       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
> > >       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
> > >       tee: increase TEE_MAX_ARG_SIZE to 4096
> > >       tee: add Qualcomm TEE driver
> > >       tee: qcom: add primordial object
> > >       tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
> > >       Documentation: tee: Add Qualcomm TEE driver
> > >
> > >  Documentation/tee/index.rst              |   1 +
> > >  Documentation/tee/qtee.rst               |  96 ++++
> > >  MAINTAINERS                              |   7 +
> > >  drivers/firmware/qcom/qcom_scm.c         | 119 ++++
> > >  drivers/firmware/qcom/qcom_scm.h         |   7 +
> > >  drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
> > >  drivers/tee/Kconfig                      |   1 +
> > >  drivers/tee/Makefile                     |   1 +
> > >  drivers/tee/qcomtee/Kconfig              |  12 +
> > >  drivers/tee/qcomtee/Makefile             |   9 +
> > >  drivers/tee/qcomtee/async.c              | 182 ++++++
> > >  drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++=
++++++
> > >  drivers/tee/qcomtee/core.c               | 915 +++++++++++++++++++++=
++++++++++
> > >  drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
> > >  drivers/tee/qcomtee/primordial_obj.c     | 113 ++++
> > >  drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
> > >  drivers/tee/qcomtee/qcomtee_msg.h        | 304 ++++++++++
> > >  drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
> > >  drivers/tee/qcomtee/shm.c                | 150 +++++
> > >  drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++=
++
> > >  drivers/tee/tee_core.c                   | 127 ++++-
> > >  drivers/tee/tee_private.h                |   6 -
> > >  include/linux/firmware/qcom/qcom_scm.h   |   6 +
> > >  include/linux/firmware/qcom/qcom_tzmem.h |  15 +
> > >  include/linux/tee_core.h                 |  54 +-
> > >  include/linux/tee_drv.h                  |  12 +
> > >  include/uapi/linux/tee.h                 |  56 +-
> > >  27 files changed, 4410 insertions(+), 28 deletions(-)
> > > ---
> > > base-commit: 8b8aefa5a5c7d4a65883e5653cf12f94c0b68dbf
> > > change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c6634052=
7
> > >
> > > Best regards,
> > > --
> > > Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> > >
