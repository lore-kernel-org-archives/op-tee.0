Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC13CD4F54
	for <op-tee@archiver.kernel.org>; Thu, 28 May 2026 13:11:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8F74644DCC
	for <op-tee@archiver.kernel.org>; Thu, 28 May 2026 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779973887;
	bh=DRxY+IRB0IqAgofhsecYlxPFiYO6P8tDS1HNVNN3odI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=N9Gqr7HdRTZ1Thxj4ZlsjfWG4aHupMYP27qeNuSX4tdY/E9GFZpiyAHei0FJSaraW
	 ub9zgIpkGGh6MGs7QQqggtiVXWc58xXhBvIorAKywGm6GRUHFnRVF+Y4VvQwvn7K4d
	 GbEXRx0eXwaiSgdR3OUx8PIIhZd6qb5I3h9VrrreQ5Z70dgNY8e7V3MYMC4L/otqox
	 FgX3ONhnY5cL/m8QUNaAQe+mcJOpRY0JqOljcFfu+Vasz5eI351mFn/47KzsRPXfsw
	 pje43BFF7diNoko8YAmoBvVj41jazJ815AHiViPnJQ0tuLsgBOkmk4SKritFTplT7L
	 XTC8xuUWwQl0A==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BA12D434B9
	for <op-tee@lists.trustedfirmware.org>; Thu, 28 May 2026 13:11:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2UHAKvV;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CF1240869;
	Thu, 28 May 2026 13:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4393B1F000E9;
	Thu, 28 May 2026 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779973880;
	bh=iDEo0j2nHsYSJgSqy1z8dWMjD802zHIig7qC3EKAx/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2UHAKvVDwz9Q8zDeG5+gjEzAwHGNvWPrhFQu4UWecZMGU9oLFnYEUppHdL1JG96W
	 ZyKfXbFlZkxgErlkIJ9vEDjHqhgkZYeEglVfzfyl1vwgy5OcQX/ILvYNtAw+Fw/u/n
	 7Rf4HO5aTgBsh8Qrexyv+asWzwUvPXiN0B/LUktlwpZ7GWwIh5oxpK5VedspSPx+Bn
	 nl+HsmBpJmBcRweXxwoqgm9Olo+josivuYToc2QW7vazCQsXTqNoHWp1knQYF/ENFG
	 jtLGo1SiiASszWS5aZ18I7jEX0fOy1BKxNFyaZVCVtMBYw8PPdiTBmqYLjDYvMKN77
	 k31LndrsIUjKg==
Date: Thu, 28 May 2026 18:41:07 +0530
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH v7 02/15] firmware: qcom: Add a generic PAS service
Message-ID: <ahg-6-eLus-J7tC8@sumit-xelite>
References: <20260522115936.201208-1-sumit.garg@kernel.org>
 <20260522115936.201208-3-sumit.garg@kernel.org>
 <37fb075c-3f48-4a7c-b05d-090b0b09e04a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37fb075c-3f48-4a7c-b05d-090b0b09e04a@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_TLS_LAST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BA12D434B9
X-Spamd-Bar: ---
Message-ID-Hash: PAGDYRXJT5E6HUVZKTNU5W3TPF7I4DX3
X-Message-ID-Hash: PAGDYRXJT5E6HUVZKTNU5W3TPF7I4DX3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.
 qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PAGDYRXJT5E6HUVZKTNU5W3TPF7I4DX3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

Hi Amir,

On Thu, May 28, 2026 at 10:45:32AM +1000, Amirreza Zarrabi wrote:
> Hi Sumit,
> 
> On 5/22/2026 9:59 PM, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Qcom platforms has the legacy of using non-standard SCM calls
> > splintered over the various kernel drivers. These SCM calls aren't
> > compliant with the standard SMC calling conventions which is a
> > prerequisite to enable migration to the FF-A specifications from Arm.
> > 
> > OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> > support these non-standard SCM calls. And even for newer architectures
> > using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> > calls either with FF-A requirements coming in. And with both OP-TEE
> > and QTEE drivers well integrated in the TEE subsystem, it makes further
> > sense to reuse the TEE bus client drivers infrastructure.
> > 
> > The added benefit of TEE bus infrastructure is that there is support
> > for discoverable/enumerable services. With that client drivers don't
> > have to manually invoke a special SCM call to know the service status.
> > 
> > So enable the generic Peripheral Authentication Service (PAS) provided
> > by the firmware. It acts as the common layer with different TZ
> > backends plugged in whether it's an SCM implementation or a proper
> > TEE bus based PAS service implementation.
> > 
> > Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> > Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> > Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/Kconfig          |   8 +
> >  drivers/firmware/qcom/Makefile         |   1 +
> >  drivers/firmware/qcom/qcom_pas.c       | 291 +++++++++++++++++++++++++
> >  drivers/firmware/qcom/qcom_pas.h       |  50 +++++
> >  include/linux/firmware/qcom/qcom_pas.h |  43 ++++
> >  5 files changed, 393 insertions(+)
> >  create mode 100644 drivers/firmware/qcom/qcom_pas.c
> >  create mode 100644 drivers/firmware/qcom/qcom_pas.h
> >  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> > 
> > diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> > index b477d54b495a..9f66cc774508 100644
> > --- a/drivers/firmware/qcom/Kconfig
> > +++ b/drivers/firmware/qcom/Kconfig
> > @@ -6,6 +6,14 @@
> >  
> >  menu "Qualcomm firmware drivers"
> >  
> > +config QCOM_PAS
> > +	tristate "Qualcomm generic PAS interface driver"
> > +	help
> > +	  Enable the generic Peripheral Authentication Service (PAS) provided
> > +	  by the firmware. It acts as the common layer with different TZ
> > +	  backends plugged in whether it's an SCM implementation or a proper
> > +	  TEE bus based PAS service implementation.
> > +
> >  config QCOM_SCM
> >  	select QCOM_TZMEM
> >  	tristate
> > diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> > index 0be40a1abc13..dc5ab45f906a 100644
> > --- a/drivers/firmware/qcom/Makefile
> > +++ b/drivers/firmware/qcom/Makefile
> > @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> >  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
> >  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
> >  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> > +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o

<snip>

> > diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
> > new file mode 100644
> > index 000000000000..65b1c9564458
> > --- /dev/null
> > +++ b/include/linux/firmware/qcom/qcom_pas.h
> > @@ -0,0 +1,43 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
> > + * Copyright (C) 2015 Linaro Ltd.
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#ifndef __QCOM_PAS_H
> > +#define __QCOM_PAS_H
> > +
> > +#include <linux/err.h>
> > +#include <linux/types.h>
> > +
> > +struct qcom_pas_context {
> > +	struct device *dev;
> > +	u32 pas_id;
> > +	phys_addr_t mem_phys;
> > +	size_t mem_size;
> > +	void *ptr;
> > +	dma_addr_t phys;
> > +	ssize_t size;
> > +	bool use_tzmem;
> > +};
> > +
> > +bool qcom_pas_is_available(void);
> > +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> > +						     u32 pas_id,
> > +						     phys_addr_t mem_phys,
> > +						     size_t mem_size);
> > +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> > +			struct qcom_pas_context *ctx);
> > +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
> > +					      void *input_rt, size_t input_rt_size,
> > +					      size_t *output_rt_size);
> > +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
> > +int qcom_pas_auth_and_reset(u32 pas_id);
> > +int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx);
> > +int qcom_pas_set_remote_state(u32 state, u32 pas_id);
> > +int qcom_pas_shutdown(u32 pas_id);
> > +bool qcom_pas_supported(u32 pas_id);
> > +void qcom_pas_metadata_release(struct qcom_pas_context *ctx);
> > +
> > +#endif /* __QCOM_PAS_H */
> 
> I have a question about the shape of the generic PAS abstraction.
> 
> Looking at the current interface, it seems that pas_id is still treated as
> the primary identity for most PAS operations, while struct qcom_pas_context
> is used as optional extended state for the operations that need it. I can see
> how this maps well to the existing SCM PAS interface and keeps the transition
> simple.
> 
> However, I wonder if this makes the abstraction less generic in the long term.
> Some callbacks in struct qcom_pas_ops receive only pas_id, while others
> receive struct qcom_pas_context *ctx. This works as long as pas_id is
> sufficient for those operations. But if a backend needs per-peripheral
> private state for operations such as auth_and_reset,
> shutdown, or set_remote_state, it would need to reconstruct that state from
> pas_id or maintain a separate pas_id to backend-context mapping.
> 
> Would it be cleaner to make struct qcom_pas_context the common
> per-peripheral object and pass it consistently to all per-peripheral callbacks?
> Existing backends could still use ctx->pas_id, but future backends would not
> need to perform a separate lookup only because the callback was passed a raw
> pas_id.

The common evolution for a generic abstraction comes when it's needed.
So once the client driver or the backend comes up with certain
requirements then the generic PAS layer can be extended as needed. It
should be possible for more APIs to migrate to using PAS context but
there should be corresponding use-case requirements.

> 
> I also wonder whether struct qcom_pas_context is exposing some
> implementation-specific state. Fields such as ptr, phys, size, and
> use_tzmem seem to describe how the current SCM/QTEE implementations manage
> metadata memory, rather than generic PAS state. For another backend, the
> per-operation state might be a tee_shm, an FF-A memory handle, shared or lent
> memory state, or something else transport-specific.
> 
> Would it make sense to keep only the common PAS fields in
> struct qcom_pas_context, such as dev, pas_id, and possibly the firmware
> memory address/size if those are truly generic, and add a backend-private
> pointer for implementation-specific state?

Currently, the 2 backends can re-use parts of the PAS context but I
agree more abstraction can be done as needed for future backends.

> 
> I may be missing a reason why the pas_id-only callbacks are preferred, but if
> this is intended to be the long-term generic PAS layer rather than mainly a
> shim over the existing SCM API shape, using the context consistently and keeping
> backend-specific state private seems easier to extend.

As I mentioned above, the generic PAS layer isn't fixed but it will
surely go through evolution as needed. Current abstraction handles the
existing client driver and backend requirments.

Moreover the subsystem maintainers are already complaining about this
series being too large for the merge to happen.

-Sumit
