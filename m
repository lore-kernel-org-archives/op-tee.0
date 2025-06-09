Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA33C5B552
	for <op-tee@archiver.kernel.org>; Mon,  9 Jun 2025 15:23:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 56F5043009
	for <op-tee@archiver.kernel.org>; Mon,  9 Jun 2025 15:23:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kTovAfS4;
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4EC674092C
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Jun 2025 15:23:13 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so2301664a12.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 09 Jun 2025 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749482592; x=1750087392; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+Mg6PW+/K0QnsP+hIHi7hEEWjzJrekcG6Ta5Fzf3T0=;
        b=kTovAfS4AaoRtNdVkwVS71CHbrMmEAFPQXIwnAF1bhwF9xKRC0myjFkDaa5NWmAKLY
         QI5zVqjBk3Waexcp1sUkR39qem97aeHYay7f2NF78nXu+f8O3rGCqdSQt3X3I3r7ZiGx
         n96pjizSylGpPX1/f/TCD0jMwvwUb6KMTPZy5Vk9iSb2zRmE5Ukn9x/UvV53Cwpz832M
         htrC2FeVJUOLhgijem2Ae3BOKpnicRxmF3aXuLr/PrYpbTbI83USHSA1D6R1yB4a7Yeb
         qimCrnaNCHJ9VPpUs7MI7wVyxY2RO0BnF6xaa+2rmzFsGNgybsbKDDAbA0yfIINvu8q3
         UioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749482592; x=1750087392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+Mg6PW+/K0QnsP+hIHi7hEEWjzJrekcG6Ta5Fzf3T0=;
        b=bL38x2rgKV3vcwv6njusSuqiXIB210rtEfKJVTnqkOd5gmZCSJhB4eVQWROR67uefM
         Bx8J0j26gPyoh6IGBIAvPU+TdNUnqQ+MusGUW2FUOUeRP1cbw+PKcQDJ+AJuHuAMBUOq
         SWz+7CWVwJ6DJf++KjEWEsXVXi5UpR/zoa13dp82QQCPAi0RQoP72qWp0HeRpZ8xpDiY
         TWsIyyr9CBoNgpQl7IC2ifLuKDH4qqQDswMVpGgbS6o1rqxfMk6icVi+PFA5VT5H8RC+
         RlZTiuCDewC7VTFJt+Zwn7hcwXmdFR6ZGH7OGw0nXUWgpyyZ7+wkWdrGqbDU5Nyxm6pE
         Zf5A==
X-Forwarded-Encrypted: i=1; AJvYcCVOA4gLcZo12hyb1n8N0Y4XGSCn5ObVNKCQvXJOlIOruop2LVIIoCcQzDgNNXeydjmVjjDBusI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw5oPfsfgl4MFWIGtIn7F/aN/sqKieNZha1iy6hEgQN35itE2Ki
	X0AD1qoMFjAI+KGJj7kCFBFPagZ6UhEQJjMAQIVAHHm7N9Pu3t2Tdux5N5qsH5aR7ZS5qQ==
X-Gm-Gg: ASbGnctsqGJkyECpBS1jsEGmezqbBk3KBIkwpq0L6Lua8qd4tu2WS8r+Bq4f5kq6MXg
	KMj54E+UshE6w7Ew2GTGZW6/UEbHxvXwKbcJ3ezzg/gj44pfFvKe7Xx0deWREs/ujJbFRZabHw0
	FLp4noDNUGl+BsQfg2sCIfOwTByp/CcmQPKCOvKqXu5QBEUky01yNONObFLhIpi9FgYE1eVydyj
	dduqqxUhARYPdZa7Pr1od9shueWyugMCms81+mUdKRtJA0oi5ep2ygfXTiKbYm+qdZ+ZmSSTO1n
	ZZXcJP33YKc/ro4kd9or2Y/efb9GRJ087F0Pm1fa0PkX8dG2jDfj67URIQAqwVcfebQXinfT+/D
	I
X-Google-Smtp-Source: AGHT+IEHQs24xS7vzskFJPPr8eh6p9W8ZrujNawhU2iz0AreagkiHluW65S1z22AdhoPCthNzNJd4g==
X-Received: by 2002:a17:90b:3891:b0:312:26d9:d5b4 with SMTP id 98e67ed59e1d1-3134740b55cmr21132387a91.17.1749482592330;
        Mon, 09 Jun 2025 08:23:12 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1329:68ff:ffeb:cd9c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fc374asm5791390a91.29.2025.06.09.08.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 08:23:11 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:23:09 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [RESEND PATCH v16 0/6] Introduction of a remoteproc tee to load
 signed firmware
Message-ID: <aEb8XbhY5dR__GM-@p14s>
References: <20250603100808.1074812-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603100808.1074812-1-arnaud.pouliquen@foss.st.com>
X-Spamd-Bar: -
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.215.172:from];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.172:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4EC674092C
Message-ID-Hash: ZDP2F7Z4RLRVJO22KMF3SA23GXTRGYI5
X-Message-ID-Hash: ZDP2F7Z4RLRVJO22KMF3SA23GXTRGYI5
X-MailFrom: mathieu.poirier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZDP2F7Z4RLRVJO22KMF3SA23GXTRGYI5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Jun 03, 2025 at 12:08:02PM +0200, Arnaud Pouliquen wrote:
> Hello Bjorn and Mathieu,
> 
> I am resending this series after waiting for over two months for Bjorn's
> feedback, despite a prior reminder.
> 
> Please could you coordinate between yourselves to determine who will continue
> reviewing this series? It would be greatly appreciated if the review could
> proceed within a more reasonable timeframe.
> 
> Thanks in advance and best regards,
> Arnaud
> 
> 
> Main updates from version V15[1]:
> - Removed the rproc_ops:load_fw() operation introduced in the previous version.
> - Returned to managing the remoteproc firmware loading in rproc_tee_parse_fw to
>   load and authenticate the firmware before getting the resource table.
> - Added spinlock and dev_link mechanisms in remoteproc TEE to better manage
>   bind/unbind.
>

Have all pending issues been resolved or is there still questions about some
aspects of the design?
 
> More details are available in each patch commit message.
> 
> [1] https://lore.kernel.org/linux-remoteproc/20241128084219.2159197-7-arnaud.pouliquen@foss.st.com/T/
> 
> Tested-on: commit 0ff41df1cb26 ("Linux 6.15")
> 
> Description of the feature:
> --------------------------
> This series proposes the implementation of a remoteproc tee driver to
> communicate with a TEE trusted application responsible for authenticating
> and loading the remoteproc firmware image in an Arm secure context.
> 
> 1) Principle:
> 
> The remoteproc tee driver provides services to communicate with the OP-TEE
> trusted application running on the Trusted Execution Context (TEE).
> The trusted application in TEE manages the remote processor lifecycle:
> 
> - authenticating and loading firmware images,
> - isolating and securing the remote processor memories,
> - supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
> - managing the start and stop of the firmware by the TEE.
> 
> 2) Format of the signed image:
> 
> Refer to:
> https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/src/remoteproc_core.c#L18-L57
> 
> 3) OP-TEE trusted application API:
> 
> Refer to:
> https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/include/ta_remoteproc.h
> 
> 4) OP-TEE signature script
> 
> Refer to:
> https://github.com/OP-TEE/optee_os/blob/master/scripts/sign_rproc_fw.py
> 
> Example of usage:
> sign_rproc_fw.py --in <fw1.elf> --in <fw2.elf> --out <signed_fw.sign> --key ${OP-TEE_PATH}/keys/default.pem
> 
> 
> 5) Impact on User space Application
> 
> No sysfs impact. The user only needs to provide the signed firmware image
> instead of the ELF image.
> 
> 
> For more information about the implementation, a presentation is available here
> (note that the format of the signed image has evolved between the presentation
> and the integration in OP-TEE).
> 
> https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds
> 
> Arnaud Pouliquen (6):
>   remoteproc: core: Introduce rproc_pa_to_va helper
>   remoteproc: Add TEE support
>   remoteproc: Introduce release_fw optional operation
>   dt-bindings: remoteproc: Add compatibility for TEE support
>   remoteproc: stm32: Create sub-functions to request shutdown and
>     release
>   remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
> 
>  .../bindings/remoteproc/st,stm32-rproc.yaml   |  58 +-
>  drivers/remoteproc/Kconfig                    |  10 +
>  drivers/remoteproc/Makefile                   |   1 +
>  drivers/remoteproc/remoteproc_core.c          |  52 ++
>  drivers/remoteproc/remoteproc_internal.h      |   6 +
>  drivers/remoteproc/remoteproc_tee.c           | 619 ++++++++++++++++++
>  drivers/remoteproc/stm32_rproc.c              | 139 +++-
>  include/linux/remoteproc.h                    |   4 +
>  include/linux/remoteproc_tee.h                |  90 +++
>  9 files changed, 935 insertions(+), 44 deletions(-)
>  create mode 100644 drivers/remoteproc/remoteproc_tee.c
>  create mode 100644 include/linux/remoteproc_tee.h
> 
> 
> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
> -- 
> 2.25.1
> 
