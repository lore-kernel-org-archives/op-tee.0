Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66501C677C4
	for <op-tee@archiver.kernel.org>; Tue, 10 Jun 2025 17:37:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 85E8D43047
	for <op-tee@archiver.kernel.org>; Tue, 10 Jun 2025 17:37:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hwDWEFIM;
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5A757413C7
	for <op-tee@lists.trustedfirmware.org>; Tue, 10 Jun 2025 17:36:42 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acbb85ce788so948006766b.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 10 Jun 2025 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749577001; x=1750181801; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QNLtRYl8Q0eOmLpDGjVlOH3U6XH8t2IuXLhDXftAH7c=;
        b=hwDWEFIMIcOoplki3OaPwMURRpE+6hZIyjt7cU3E/v91aURVKQU0rPDjkruMVpGC7s
         ss6sNHcerShzXshlksSxHsP7zat/NAOlBmJo5kOf0FkVSlKWgTmZkeXSjuHXjqe0aHsU
         iliZBTmEHZFaz/rwwYgcDf3RioFL7ZuD3oXliQV9t1bgYdVSkUJ0uwHJ1l8qWZ/1+gBr
         wcRrj+DLNe41kcoJb9QzBGTnuJAyd1IKDcvZVPcDCBGshU3Z3R7PcO2ohUljsUVlHTRR
         oOGEBgum0Mxet580tHrQQJKItsP+tCY6sLaD7rfYIyV6gU9CljOqGUb/YOFmpKkkLrN+
         CIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749577001; x=1750181801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNLtRYl8Q0eOmLpDGjVlOH3U6XH8t2IuXLhDXftAH7c=;
        b=qLR2yeGjLN5VNVK7CzlcmDdlYg93nZumJUZLbzMxI4hprQR1EbN2WNfcvL1TLB6Nqb
         K0+gquI+nKAkAb6e89vmEV0Xq9cAWX/8ScJpicEfMHxLJwFY1R+D+LNZc8AeUZIwLzQA
         SoKpIYd0Y1qvELUnhzXuXGOJAIrtbsTBfc7SbZMAFAmuWAn2/XnBJJ4h7e56lJnmGnnG
         8Ytq8f4zmvCe3iAWBJaEZAQP5QY6lsuuM3WtEU3ioYY8mt6hM48FbzWc7lwcQwaeWJPc
         4vVfIM6L7uS1kzlpnDZ0hgmuiJUGYY9ml5enq/n/ap8WFHrwGEVrRXOx/fgFuCRydXpK
         dpxg==
X-Forwarded-Encrypted: i=1; AJvYcCUZqMD4HLCX8kypQE8hRowR2uBmKrERgi9DQEwNLdcP1cGdcZp0Xchl88kb0Xk8jyAfd0TDV/c=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzxor+NnoiG88b9tQPVFBOEUoxwwEnEpzU7FAJdA6oXb9Re435D
	oUMnfJ4dDA891QBVsryzOBYVt23Fl5DJIFNUAU9QPIa0814RB81Ud/CyvqA8w6fF3/t77nqI7Mm
	oK1zBNAsjN2FhnxvvO1eLCrb2dSVZuPU1wJQzFfefLcQb
X-Gm-Gg: ASbGncvjsi6xum2V4oK19bp4g/+H+ENDOArC3xTM7GVoDEYSl9hBYlaNPJA/8EOpVbZ
	ifTF9QyApkqCEWd2i/eobickYAfCPsSvFpe0gBcxq5shUC5B1y1a1PTx2svwiycAtAF7yfx1ETg
	nJdi1VDIa/3DiMFVp+1KnKQ5H0iySKNxnJtRdxnro1m7t7mdg6j0FvmchaMCIeGWfllMOrZSyhW
	4GKGA==
X-Google-Smtp-Source: AGHT+IGnpxZ/kYqFsSq4j6qp84vLjWxNulzEhZc0i1z/5c6tyzkSQMkPM59ws5hVqdCe/nWfEYyFEbx1JOZa0jQG5i8=
X-Received: by 2002:a17:907:948d:b0:ad2:4c38:5a22 with SMTP id
 a640c23a62f3a-ade897f338cmr25361966b.51.1749577001063; Tue, 10 Jun 2025
 10:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250603100808.1074812-1-arnaud.pouliquen@foss.st.com>
 <aEb8XbhY5dR__GM-@p14s> <7850c6f4-6a6f-4934-895d-9ec0688cda2a@foss.st.com>
In-Reply-To: <7850c6f4-6a6f-4934-895d-9ec0688cda2a@foss.st.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 10 Jun 2025 11:36:30 -0600
X-Gm-Features: AX0GCFtaU9fLocUtXIXHBOEkqczV71_1sopLG6zbwgW4ITB5pILObesRDc6IzW8
Message-ID: <CANLsYky=AAnQ3P6J9E9R1=ufVKpGniiVTkfSeaq5J_7E=qN65g@mail.gmail.com>
Subject: Re: [RESEND PATCH v16 0/6] Introduction of a remoteproc tee to load
 signed firmware
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.45:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.45:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5A757413C7
Message-ID-Hash: NT4OSEEWRPGBHEWGGJZBNVLU56ZOAVHQ
X-Message-ID-Hash: NT4OSEEWRPGBHEWGGJZBNVLU56ZOAVHQ
X-MailFrom: mathieu.poirier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NT4OSEEWRPGBHEWGGJZBNVLU56ZOAVHQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, 9 Jun 2025 at 10:33, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hello Mathieu,
>
> On 6/9/25 17:23, Mathieu Poirier wrote:
> > On Tue, Jun 03, 2025 at 12:08:02PM +0200, Arnaud Pouliquen wrote:
> >> Hello Bjorn and Mathieu,
> >>
> >> I am resending this series after waiting for over two months for Bjorn's
> >> feedback, despite a prior reminder.
> >>
> >> Please could you coordinate between yourselves to determine who will continue
> >> reviewing this series? It would be greatly appreciated if the review could
> >> proceed within a more reasonable timeframe.
> >>
> >> Thanks in advance and best regards,
> >> Arnaud
> >>
> >>
> >> Main updates from version V15[1]:
> >> - Removed the rproc_ops:load_fw() operation introduced in the previous version.
> >> - Returned to managing the remoteproc firmware loading in rproc_tee_parse_fw to
> >>   load and authenticate the firmware before getting the resource table.
> >> - Added spinlock and dev_link mechanisms in remoteproc TEE to better manage
> >>   bind/unbind.
> >>
> >
> > Have all pending issues been resolved or is there still questions about some
> > aspects of the design?
> >
>
> No pending issues on my side.
>
> In terms of design, I resend an equivalent of the V13 design incorporating
> Bjorn's comments on V15.
> The pending questions are:
> - is that V13/V16 is aligned with Bjorn's expectations[1].
> - are you also aligned on this design even if you proposed an alternative that
>   implemented in V14 and V15
> Few details on the V13/V16 design:
>
> The main point of discussion is the rproc_tee_parse_fw() implementation.
> In V13, this function loaded the firmware and then parses the resource table.
>
> You proposed an alternative, to add a new rproc->load ops
> in the remoteproc core instead (implemented in V14 and V15).
> Bjorn expressed concerns about this and proposed a solution that, from my
> understanding, is equivalent to the V13 implementation.
>

As far as I can tell, the only difference in this revision is the
loading of the firmware as part of rproc_tee_parse_fw().  I haven't
followed the thread but I am sure Bjorn had a good reason for that and
I am in agreement with this approach.

> Thanks,
> Arnaud
>
>
> [1] https://lkml.org/lkml/2025/3/5/906
>
> >> More details are available in each patch commit message.
> >>
> >> [1] https://lore.kernel.org/linux-remoteproc/20241128084219.2159197-7-arnaud.pouliquen@foss.st.com/T/
> >>
> >> Tested-on: commit 0ff41df1cb26 ("Linux 6.15")
> >>
> >> Description of the feature:
> >> --------------------------
> >> This series proposes the implementation of a remoteproc tee driver to
> >> communicate with a TEE trusted application responsible for authenticating
> >> and loading the remoteproc firmware image in an Arm secure context.
> >>
> >> 1) Principle:
> >>
> >> The remoteproc tee driver provides services to communicate with the OP-TEE
> >> trusted application running on the Trusted Execution Context (TEE).
> >> The trusted application in TEE manages the remote processor lifecycle:
> >>
> >> - authenticating and loading firmware images,
> >> - isolating and securing the remote processor memories,
> >> - supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
> >> - managing the start and stop of the firmware by the TEE.
> >>
> >> 2) Format of the signed image:
> >>
> >> Refer to:
> >> https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/src/remoteproc_core.c#L18-L57
> >>
> >> 3) OP-TEE trusted application API:
> >>
> >> Refer to:
> >> https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/include/ta_remoteproc.h
> >>
> >> 4) OP-TEE signature script
> >>
> >> Refer to:
> >> https://github.com/OP-TEE/optee_os/blob/master/scripts/sign_rproc_fw.py
> >>
> >> Example of usage:
> >> sign_rproc_fw.py --in <fw1.elf> --in <fw2.elf> --out <signed_fw.sign> --key ${OP-TEE_PATH}/keys/default.pem
> >>
> >>
> >> 5) Impact on User space Application
> >>
> >> No sysfs impact. The user only needs to provide the signed firmware image
> >> instead of the ELF image.
> >>
> >>
> >> For more information about the implementation, a presentation is available here
> >> (note that the format of the signed image has evolved between the presentation
> >> and the integration in OP-TEE).
> >>
> >> https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds
> >>
> >> Arnaud Pouliquen (6):
> >>   remoteproc: core: Introduce rproc_pa_to_va helper
> >>   remoteproc: Add TEE support
> >>   remoteproc: Introduce release_fw optional operation
> >>   dt-bindings: remoteproc: Add compatibility for TEE support
> >>   remoteproc: stm32: Create sub-functions to request shutdown and
> >>     release
> >>   remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
> >>
> >>  .../bindings/remoteproc/st,stm32-rproc.yaml   |  58 +-
> >>  drivers/remoteproc/Kconfig                    |  10 +
> >>  drivers/remoteproc/Makefile                   |   1 +
> >>  drivers/remoteproc/remoteproc_core.c          |  52 ++
> >>  drivers/remoteproc/remoteproc_internal.h      |   6 +
> >>  drivers/remoteproc/remoteproc_tee.c           | 619 ++++++++++++++++++
> >>  drivers/remoteproc/stm32_rproc.c              | 139 +++-
> >>  include/linux/remoteproc.h                    |   4 +
> >>  include/linux/remoteproc_tee.h                |  90 +++
> >>  9 files changed, 935 insertions(+), 44 deletions(-)
> >>  create mode 100644 drivers/remoteproc/remoteproc_tee.c
> >>  create mode 100644 include/linux/remoteproc_tee.h
> >>
> >>
> >> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
> >> --
> >> 2.25.1
> >>
