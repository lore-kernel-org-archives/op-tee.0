Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93342CA0FE7
	for <op-tee@archiver.kernel.org>; Tue, 26 Aug 2025 15:56:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D6E874FC1C
	for <op-tee@archiver.kernel.org>; Tue, 26 Aug 2025 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756223770;
	bh=7D1gRpLyK2KWpavVC/GDGqLHUTmC2s3yYbsERqNk5is=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QFQ7Fdx1d3TG1Jjk9EfI7Xhc8682l9uPvVtt1zws1w4+tAbyXFRD+AQJMeitE1vB+
	 P5iQvIy8Ca60C0BdlodgUXYRsEIEyjixXCWsCSy2fpzXP37hmdJslWQmu1JD9aCIwr
	 Q5+7hVeaWe+r4BhvxVQKI7YI7yVOJERyQJaXT0LuS687kRY65ptr2h2K9hwVC+nyUK
	 7xQsDyA503/b/pqaH4JhndLv6GWTPxIbj2INw+rDUxZDrURfp27P/J5VL2tArU/SU9
	 +EKh5/zfR3vId9B5b7iw5SFCnM5yacexu70uoCDTxy98RYeHkGfHlhJ6pXmxvpEMnX
	 qxGSRXUZBoAvg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A10C0459FF
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 Aug 2025 15:55:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lWrLwiyZ;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 04F30406A8;
	Tue, 26 Aug 2025 15:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803CBC4CEF1;
	Tue, 26 Aug 2025 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756223753;
	bh=7D1gRpLyK2KWpavVC/GDGqLHUTmC2s3yYbsERqNk5is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWrLwiyZzcyORghQyM1Dmlwptz6xFlfKujYzcNYF43ww95Vl3j5CsSDBwZxv5/o9l
	 dvNcj5p4QpQYUPLZ7A73wQqhU6Y7Ua0DQI4YqDY4VtYyxk3lFNGTAItm04j1Zn5Qso
	 Os0o+00S6/H+96fgyctfUN+kbLtIsnU3sQJR42vpEoQ7rdIRqWXCUo2izZQ7OagZZN
	 QbV0+v2NHqv7e8lo/7KhJ7kahFaq7LkdDa1vCnIJ6KtaYoXfAvi4kJbCrO0EbgEs9E
	 KMI71QC/4JBaMSo3ujPmADmp7oKT3bh+fEVAb4DT5rbSd8QuS08WNvbenpmec4RwJR
	 F4fhtQI2tcLSw==
Date: Tue, 26 Aug 2025 10:55:50 -0500
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH v8 09/11] qcomtee: add primordial object
Message-ID: <4rbfpubsaxgv2buksonfigbdkw6geas6l7pycxuukdymqfohga@ohd4hqzvra3w>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
 <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-9-7066680f138a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-9-7066680f138a@oss.qualcomm.com>
X-Rspamd-Queue-Id: A10C0459FF
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: OY4MOSCTUHA2BRPFD2COOHG47YZ5P4JU
X-Message-ID-Hash: OY4MOSCTUHA2BRPFD2COOHG47YZ5P4JU
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OY4MOSCTUHA2BRPFD2COOHG47YZ5P4JU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>

On Wed, Aug 20, 2025 at 04:38:56PM -0700, Amirreza Zarrabi wrote:

Looking at other commits in drivers/tee/ I'd expect the subject prefix
to be "tee: qcom: ".

> After booting, the kernel provides a static object known as the
> primordial object. This object is utilized by QTEE for native
> kernel services such as yield or privileged operations.
> 
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/Makefile         |  1 +
>  drivers/tee/qcomtee/core.c           | 19 ++++++++---
>  drivers/tee/qcomtee/primordial_obj.c | 66 ++++++++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/qcomtee.h        |  3 ++
>  4 files changed, 84 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
> index 600af2b8f1c1..78f8e899d143 100644
> --- a/drivers/tee/qcomtee/Makefile
> +++ b/drivers/tee/qcomtee/Makefile
> @@ -3,5 +3,6 @@ obj-$(CONFIG_QCOMTEE) += qcomtee.o
>  qcomtee-objs += async.o
>  qcomtee-objs += call.o
>  qcomtee-objs += core.o
> +qcomtee-objs += primordial_obj.o
>  qcomtee-objs += shm.o
>  qcomtee-objs += user_obj.o
> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> index 578299a3eabc..561a48319f91 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -31,10 +31,12 @@ int qcomtee_next_arg_type(struct qcomtee_arg *u, int i,
>  }
>  
>  /*
> - * QTEE expects IDs with the QCOMTEE_MSG_OBJECT_NS_BIT set for objects
> - * of the QCOMTEE_OBJECT_TYPE_CB type.
> + * QTEE expects IDs with QCOMTEE_MSG_OBJECT_NS_BIT set for objects of
> + * QCOMTEE_OBJECT_TYPE_CB type. The first ID with QCOMTEE_MSG_OBJECT_NS_BIT
> + * set is reserved for the primordial object.
>   */
> -#define QCOMTEE_OBJECT_ID_START (QCOMTEE_MSG_OBJECT_NS_BIT + 1)
> +#define QCOMTEE_OBJECT_PRIMORDIAL (QCOMTEE_MSG_OBJECT_NS_BIT)
> +#define QCOMTEE_OBJECT_ID_START (QCOMTEE_OBJECT_PRIMORDIAL + 1)
>  #define QCOMTEE_OBJECT_ID_END (U32_MAX)
>  
>  #define QCOMTEE_OBJECT_SET(p, type, ...) \
> @@ -157,7 +159,9 @@ static void qcomtee_object_release(struct kref *refcount)
>   */
>  int qcomtee_object_get(struct qcomtee_object *object)
>  {
> -	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
> +	if (object != &qcomtee_primordial_object &&
> +	    object != NULL_QCOMTEE_OBJECT &&
> +	    object != ROOT_QCOMTEE_OBJECT)
>  		return kref_get_unless_zero(&object->refcount);
>  
>  	return 0;
> @@ -169,7 +173,9 @@ int qcomtee_object_get(struct qcomtee_object *object)
>   */
>  void qcomtee_object_put(struct qcomtee_object *object)
>  {
> -	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
> +	if (object != &qcomtee_primordial_object &&
> +	    object != NULL_QCOMTEE_OBJECT &&
> +	    object != ROOT_QCOMTEE_OBJECT)
>  		kref_put(&object->refcount, qcomtee_object_release);
>  }
>  
> @@ -261,6 +267,9 @@ qcomtee_local_object_get(struct qcomtee_object_invoke_ctx *oic,
>  	struct qcomtee *qcomtee = tee_get_drvdata(oic->ctx->teedev);
>  	struct qcomtee_object *object;
>  
> +	if (object_id == QCOMTEE_OBJECT_PRIMORDIAL)
> +		return &qcomtee_primordial_object;
> +
>  	guard(rcu)();
>  	object = xa_load(&qcomtee->xa_local_objects, object_id);
>  	/* It already checks for %NULL_QCOMTEE_OBJECT. */
> diff --git a/drivers/tee/qcomtee/primordial_obj.c b/drivers/tee/qcomtee/primordial_obj.c
> new file mode 100644
> index 000000000000..df94fbf5f141
> --- /dev/null
> +++ b/drivers/tee/qcomtee/primordial_obj.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

I don't see any pr_*() functions in this file, please drop this.

Regards,
Bjorn

> +
> +#include <linux/delay.h>
> +
> +#include "qcomtee.h"
> +
> +/**
> + * DOC: Primordial Object
> + *
> + * After boot, the kernel provides a static object of type
> + * %QCOMTEE_OBJECT_TYPE_CB called the primordial object. This object is used
> + * for native kernel services or privileged operations.
> + *
> + * We support:
> + *  - %QCOMTEE_OBJECT_OP_YIELD to yield by the thread running in QTEE.
> + *  - %QCOMTEE_OBJECT_OP_SLEEP to wait for a period of time.
> + */
> +
> +#define QCOMTEE_OBJECT_OP_YIELD 1
> +#define QCOMTEE_OBJECT_OP_SLEEP 2
> +
> +static int
> +qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
> +				struct qcomtee_object *primordial_object_unused,
> +				u32 op, struct qcomtee_arg *args)
> +{
> +	int err = 0;
> +
> +	switch (op) {
> +	case QCOMTEE_OBJECT_OP_YIELD:
> +		cond_resched();
> +		/* No output object. */
> +		oic->data = NULL;
> +		break;
> +	case QCOMTEE_OBJECT_OP_SLEEP:
> +		/* Check message format matched QCOMTEE_OBJECT_OP_SLEEP op. */
> +		if (qcomtee_args_len(args) != 1 ||
> +		    args[0].type != QCOMTEE_ARG_TYPE_IB ||
> +		    args[0].b.size < sizeof(u32))
> +			return -EINVAL;
> +
> +		msleep(*(u32 *)(args[0].b.addr));
> +		/* No output object. */
> +		oic->data = NULL;
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +static struct qcomtee_object_operations qcomtee_primordial_obj_ops = {
> +	.dispatch = qcomtee_primordial_obj_dispatch,
> +};
> +
> +struct qcomtee_object qcomtee_primordial_object = {
> +	.name = "primordial",
> +	.object_type = QCOMTEE_OBJECT_TYPE_CB,
> +	.ops = &qcomtee_primordial_obj_ops
> +};
> diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
> index f34be992e68b..084b3882017e 100644
> --- a/drivers/tee/qcomtee/qcomtee.h
> +++ b/drivers/tee/qcomtee/qcomtee.h
> @@ -140,4 +140,7 @@ int qcomtee_user_object_submit(struct tee_context *ctx,
>  			       struct tee_param *params, int num_params,
>  			       int req_id, int errno);
>  
> +/* (2) Primordial Object. */
> +extern struct qcomtee_object qcomtee_primordial_object;
> +
>  #endif /* QCOMTEE_H */
> 
> -- 
> 2.34.1
> 
