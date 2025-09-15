Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98578CAC59A
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 16:44:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CB5FC41A46
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 16:44:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yQxt5Haq;
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 803EA40AD7
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Sep 2025 16:44:20 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0428b537e5so610255266b.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Sep 2025 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757954659; x=1758559459; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fxAhSsMDGNnMgBD5McDp4/uZmqqHc3OE6kQMHu7kZTE=;
        b=yQxt5HaqFfBiSNa46gNvWP7KThPwfU1cQIUNf2pilQ5yaZUdS/rtDYOUUbyR0Bxp6O
         RcTQNLg2m13iFECyg3GegTsgUUuAsTfDEiXX5T/2UcCrS5hpo8xjLIavjlGc3iiTZ7W7
         WjIwxn4dHcV4C/q0la/ibsLhV67kezTsGOGbZ5BbXZgKjzWfXDWJQPOLTV/PpP8Safpx
         DlJnXDKRx9Uq1IaROXCRCpW16rhmsBnyredNoGSwm50HzhFK5+NKhv/wLBrN7qkbYFQh
         Zodr7gFOWDbFKbmNNfPr0tv8lJIxHPgm/zpkliqwV28amVgG8gxIX04snP9DejEGMGmi
         P3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954659; x=1758559459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxAhSsMDGNnMgBD5McDp4/uZmqqHc3OE6kQMHu7kZTE=;
        b=P9wkZ87m0q9YMH936lgJnBSsveBgNGzI+Zg4mKZg77ZjkA+bMIvQ5jvNmgsTOZ3qSg
         2LeGVbYSjUo/G0PGGNtrZSPDJnXGiHaQDrnyt7+NXvFMxC5hx5sgGeYZGGKNA/DwlQJA
         X5js/qSOkJ0nMSQYv6bsYBIJa8ufSU+EegxryTsQAQZKljvb5dFFLc4M2qRVhu0OPFb9
         j+b9YDkAvgfSKcCxr9ExZ9U9KukFBY5q77kULL15i53jB/XAxmTeGFz7XwRFsQsZItmO
         eV622N5cTP/IGlKw5STErDm5ozu87pAC10N1nbA9VHEklCs13s6sUb5GMBQ+ONRyAs6f
         3uqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjJCIuzLvt698DYAY1Zo9sHWDIXMk+0QiiVrfuhjaOZ5DtKtzcBA5KF4wwSdOIVtmMj3qOzd4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy8loErsxQm2fZ500Ul5SAd0pE2ATEEoAD6OhGFC2Aq70GuK1fD
	8WBS5+RSEuFXxCR0bn7cLsLVB7oFx9LCMhJMmSIxBBoGcA/KRVY9/rqcSs7KZmfOEttvX33Acnu
	1LTOST5uV8+n9/YWlZfePXsa0g/9aCsUKFdTtvRwEJ5Og
X-Gm-Gg: ASbGnctXSyEWM41VJ0M7skU9squCNRFfjc5lvvDkRIPvBJGf7tzQN7iHzLGc8bQ6u4j
	S25ey8wlxZHb1V7m9cVqzlXPuS1M7/Vr6rUCV0uHN+XEAfslSZFDXpi5mublr59SYBWEFka8r7I
	51/6NnpPI5QaKbojcheUMAs0Z4B9K/9MFGIaZwAZSD/sqd/BdmchsbyJWZ727Mhhv6kcmPZeP1x
	YRjuCR8ovRgzjLjv4tU4BLLEFCzk2Zl61r34ERuK7eUk2W2qq/yO2U5k7tAfnFtOrrLr4/oPssq
	cjR7Lv10Mu6g/l2XpET/j1jaPURe8w3ISp8M10pvUFW879zkjQ==
X-Google-Smtp-Source: AGHT+IGf97ggS/MfiEI88/iSLTqU3Qf0DD2i0f3tt8LPvU4vPPl8/glKU6zOH4FCiUjaVG28MlFFNsrhziUP+FCI8y8=
X-Received: by 2002:a17:907:60d0:b0:b04:48c5:340 with SMTP id
 a640c23a62f3a-b07c354e86bmr1171558466b.9.1757954659264; Mon, 15 Sep 2025
 09:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com> <cc53b15e-f0a4-413d-95cb-174996344d64@foss.st.com>
In-Reply-To: <cc53b15e-f0a4-413d-95cb-174996344d64@foss.st.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 15 Sep 2025 10:44:08 -0600
X-Gm-Features: AS18NWCkJjz9GpcWFh1g-R-tsFUtCptD3QVQYJIYkkqkmvYcRqIFsZ3xDtRRAdE
Message-ID: <CANLsYkyLBSbb=LUs9TOPx=cXXon5a_SS1DXmAve_5_7EwwD09g@mail.gmail.com>
Subject: Re: [PATCH v19 0/6] Introduction of a remoteproc tee to load signed firmware
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>, sumit.garg@kernel.org,
	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 803EA40AD7
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.46:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: F3KEEFYLHBBZ2EXX7R35G2IX7KMJVIOY
X-Message-ID-Hash: F3KEEFYLHBBZ2EXX7R35G2IX7KMJVIOY
X-MailFrom: mathieu.poirier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/F3KEEFYLHBBZ2EXX7R35G2IX7KMJVIOY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, 12 Sept 2025 at 10:04, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hello BJorn, Mathieu,
>
> Do you think, you could find time to review this series before the
> next merge window.
>
> Regarding the discussion between Harshal and Sumit, I did not notice any
> comments requesting immediate updates; the conversation focused more
> on potential future extensions for FF-A.
>

I would like to get an RB from Sumit and Harshal before moving forward
with this patchset.


> Thanks and Regards,
> Arnaud.
>
> On 6/25/25 11:40, Arnaud Pouliquen wrote:
> > Main updates from version V18[2]:
> > - rework documentation for the release_fw ops
> > - rework function documentation in remoteproc_tee.c
> > - replace spinlock by mutex and generalize usage in remoteproc_tee.c
> >
> >
> > Main updates from version V17[1]:
> > - Fix:  warning: EXPORT_SYMBOL() is used, but #include <linux/export.h>
> >    is missing
> >
> > More details are available in each patch commit message.
> >
> > [1]https://lore.kernel.org/linux-remoteproc/20250613091650.2337411-1-arnaud.pouliquen@foss.st.com/
> > [2]https://lore.kernel.org/linux-remoteproc/20250616075530.4106090-1-arnaud.pouliquen@foss.st.com/
> >
> > Tested-on: commit 19272b37aa4f ("Linux 6.16-rc1")
> >
> > Description of the feature:
> > --------------------------
> > This series proposes the implementation of a remoteproc tee driver to
> > communicate with a TEE trusted application responsible for authenticating
> > and loading the remoteproc firmware image in an Arm secure context.
> >
> > 1) Principle:
> >
> > The remoteproc tee driver provides services to communicate with the OP-TEE
> > trusted application running on the Trusted Execution Context (TEE).
> > The trusted application in TEE manages the remote processor lifecycle:
> >
> > - authenticating and loading firmware images,
> > - isolating and securing the remote processor memories,
> > - supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
> > - managing the start and stop of the firmware by the TEE.
> >
> > 2) Format of the signed image:
> >
> > Refer to:
> > https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/src/remoteproc_core.c#L18-L57
> >
> > 3) OP-TEE trusted application API:
> >
> > Refer to:
> > https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/include/ta_remoteproc.h
> >
> > 4) OP-TEE signature script
> >
> > Refer to:
> > https://github.com/OP-TEE/optee_os/blob/master/scripts/sign_rproc_fw.py
> >
> > Example of usage:
> > sign_rproc_fw.py --in <fw1.elf> --in <fw2.elf> --out <signed_fw.sign> --key ${OP-TEE_PATH}/keys/default.pem
> >
> >
> > 5) Impact on User space Application
> >
> > No sysfs impact. The user only needs to provide the signed firmware image
> > instead of the ELF image.
> >
> >
> > For more information about the implementation, a presentation is available here
> > (note that the format of the signed image has evolved between the presentation
> > and the integration in OP-TEE).
> >
> > https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds
> >
> > Arnaud Pouliquen (6):
> >    remoteproc: core: Introduce rproc_pa_to_va helper
> >    remoteproc: Add TEE support
> >    remoteproc: Introduce optional release_fw operation
> >    dt-bindings: remoteproc: Add compatibility for TEE support
> >    remoteproc: stm32: Create sub-functions to request shutdown and
> >      release
> >    remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
> >
> >   .../bindings/remoteproc/st,stm32-rproc.yaml   |  58 +-
> >   drivers/remoteproc/Kconfig                    |  10 +
> >   drivers/remoteproc/Makefile                   |   1 +
> >   drivers/remoteproc/remoteproc_core.c          |  52 ++
> >   drivers/remoteproc/remoteproc_internal.h      |   6 +
> >   drivers/remoteproc/remoteproc_tee.c           | 708 ++++++++++++++++++
> >   drivers/remoteproc/stm32_rproc.c              | 139 +++-
> >   include/linux/remoteproc.h                    |   6 +
> >   include/linux/remoteproc_tee.h                |  87 +++
> >   9 files changed, 1023 insertions(+), 44 deletions(-)
> >   create mode 100644 drivers/remoteproc/remoteproc_tee.c
> >   create mode 100644 include/linux/remoteproc_tee.h
> >
> >
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>
