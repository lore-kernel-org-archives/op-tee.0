Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AE5CA5FD9
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:43:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2A55A454A4
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790858587;
	bh=sO5aI/K8M680powcm6kqGX/DkNnFH83GrPHWqh0QEBk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eEqdDWVTOfLO9Csp9m/tGTX1DpC3iLAzJeiGJPTD960HSrtdvcJPzN15P3G3RppiS
	 dyrGbnm0dWgmAunWz43ZKpoy3kb63xStOB56UyhGFGZrK046lM5Yxvcyh18BCHqc1d
	 ovTYU2hphjyjDTc/zqiZce23wLDB5nG45CrpxHwAu6NrqjDSuzQSaZ9JU2x3e4QbJW
	 +PN5x802vDTFOwE3feiSh1ooTq3D3oifsbzjxVknc5PBdFIyuF1qHFq716UitV2XXN
	 bJRDJXwloGIIVi+W1Z5XV2IgQ7ndOeGacNL69PUyQeom+YrInV2sbJTvqoSxG1oHO6
	 Cx6ouYc6+/1uA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AB34243716
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 12:42:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNvt7/1W;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0587D43D4F;
	Thu,  1 Oct 2026 12:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ADC1F000FF;
	Thu,  1 Oct 2026 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858578;
	bh=oImXAC/hCNNSH/yW2DrM3EQFhc4FZKaXs24cOv6VKkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FNvt7/1W91O85P7YESs5cKH86YgBzwCazepQWbmrqTtRHqxm32wPtK8H2LBKnlQ0t
	 yQ575Vjeon4yw4AqVerS4PQnJ0zbhRDv/0+UePEiEZl47PqSkcuiNLSezw5UTI2qid
	 3yKcA+ryvpczYcESQicbaS0YXKdnyDtozDoi6ANXyHCe21dhbTy4GedlvgWAmtNj0X
	 Ue1GyGuHpQa/FeoFMK4eWhO3cNlPSZuLSTVg3SZ+xmwf4QjfFkz7fa1MhzbR6pr/FS
	 6PrUFD7Ru+kvdKWWZ/S5vy9BFOf3p0XQ530upfX0QqMxDrFD6+0iP+vVvlutKQ2CNC
	 jGFQEu2zqdLCQ==
Date: Thu, 1 Oct 2026 18:12:50 +0530
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/6] tee: qcomtee: Track the object invocation context
Message-ID: <ar5VSrXGd1nn_xqt@sumit-xelite>
Mail-Followup-To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
	Basant Kumar <basantk@qti.qualcomm.com>,
	Apurupa Pattapu <apurupa@qti.qualcomm.com>,
	Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
References: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
 <20261001-qcom_uefisecapp_migrate_qcomtee-v3-1-13df5c20c2e3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-1-13df5c20c2e3@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from,100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AB34243716
X-Spamd-Bar: ------
Message-ID-Hash: SHAGAL666UW6FWZK4KOALETKBAY7JJKP
X-Message-ID-Hash: SHAGAL666UW6FWZK4KOALETKBAY7JJKP
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SHAGAL666UW6FWZK4KOALETKBAY7JJKP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, 01 Oct 2026 at 16:32:33 +0530, Harshal Dev wrote:
>QCOMTEE needs to distinguish between object invocations arriving from
>kernel clients and user-space clients in order to correctly marshal
>UBUF parameters and decide whether certain operations should be permitted.
>
>Introduce an enum tee_object_invoke_origin to allow clients to indicate
>the context of the TEE object invocation, and add a kernel_ctx flag to the
>QCOMTEE context so the TEE back-end can track it.
>
>Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>---
> drivers/tee/qcomtee/call.c           | 11 ++++++++---
> drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
> drivers/tee/tee_core.c               |  3 ++-
> include/linux/tee_core.h             |  8 +++++++-
> 4 files changed, 23 insertions(+), 7 deletions(-)

Looks fine to me.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>index 4a597eeaf174..a0f2992c0611 100644
>--- a/drivers/tee/qcomtee/call.c
>+++ b/drivers/tee/qcomtee/call.c
>@@ -393,15 +393,20 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
>  */
> static int qcomtee_object_invoke(struct tee_context *ctx,
> 				 struct tee_ioctl_object_invoke_arg *arg,
>-				 struct tee_param *params)
>+				 struct tee_param *params,
>+				 enum tee_object_invoke_origin origin)
> {
> 	struct qcomtee_context_data *ctxdata = ctx->data;
> 	struct qcomtee_object *object;
>+	bool kernel_ctx = false;
> 	int i, ret, result;
>
> 	if (qcomtee_params_check(params, arg->num_params))
> 		return -EINVAL;
>
>+	if (origin == TEE_OBJECT_INVOKE_KERNEL)
>+		kernel_ctx = true;
>+
> 	/* First, handle reserved operations: */
> 	if (arg->op == QCOMTEE_MSG_OBJECT_OP_RELEASE) {
> 		del_qtee_object(arg->id, ctxdata);
>@@ -411,7 +416,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>
> 	/* Otherwise, invoke a QTEE object: */
> 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>-		qcomtee_object_invoke_ctx_alloc(ctx);
>+		qcomtee_object_invoke_ctx_alloc(ctx, kernel_ctx);
> 	if (!oic)
> 		return -ENOMEM;
>
>@@ -648,7 +653,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
> 	int result;
>
> 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>-		qcomtee_object_invoke_ctx_alloc(ctx);
>+		qcomtee_object_invoke_ctx_alloc(ctx, true);
> 	if (!oic)
> 		return;
>
>diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
>index d5de02dcef3b..5f40617361fc 100644
>--- a/drivers/tee/qcomtee/qcomtee_object.h
>+++ b/drivers/tee/qcomtee/qcomtee_object.h
>@@ -147,6 +147,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
>  * struct qcomtee_object_invoke_ctx - QTEE context for object invocation.
>  * @ctx: TEE context for this invocation.
>  * @flags: flags for the invocation context.
>+ * @kernel_ctx: flag that indicates this context is owned by a kernel client.
>  * @errno: error code for the invocation.
>  * @object: current object invoked in this callback context.
>  * @u: array of arguments for the current invocation (+1 for ending arg).
>@@ -159,6 +160,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
> struct qcomtee_object_invoke_ctx {
> 	struct tee_context *ctx;
> 	unsigned long flags;
>+	bool kernel_ctx;
> 	int errno;
>
> 	struct qcomtee_object *object;
>@@ -173,13 +175,15 @@ struct qcomtee_object_invoke_ctx {
> };
>
> static inline struct qcomtee_object_invoke_ctx *
>-qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx)
>+qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx, bool kernel_ctx)
> {
> 	struct qcomtee_object_invoke_ctx *oic;
>
> 	oic = kzalloc_obj(*oic);
>-	if (oic)
>+	if (oic) {
> 		oic->ctx = ctx;
>+		oic->kernel_ctx = kernel_ctx;
>+	}
> 	return oic;
> }
>
>diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>index 1aac50c7c1de..30901390149c 100644
>--- a/drivers/tee/tee_core.c
>+++ b/drivers/tee/tee_core.c
>@@ -701,7 +701,8 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
> 			goto out;
> 	}
>
>-	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
>+	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params,
>+							TEE_OBJECT_INVOKE_USERSPACE);
> 	if (rc)
> 		goto out;
>
>diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>index f993d5118edd..bcb5418d6fdc 100644
>--- a/include/linux/tee_core.h
>+++ b/include/linux/tee_core.h
>@@ -73,6 +73,11 @@ struct tee_device {
> 	struct tee_shm_pool *pool;
> };
>
>+enum tee_object_invoke_origin {
>+	TEE_OBJECT_INVOKE_USERSPACE,
>+	TEE_OBJECT_INVOKE_KERNEL,
>+};
>+
> /**
>  * struct tee_driver_ops - driver operations vtable
>  * @get_version:	returns version of driver
>@@ -117,7 +122,8 @@ struct tee_driver_ops {
> 			   struct tee_param *param);
> 	int (*object_invoke_func)(struct tee_context *ctx,
> 				  struct tee_ioctl_object_invoke_arg *arg,
>-				  struct tee_param *param);
>+				  struct tee_param *param,
>+				  enum tee_object_invoke_origin origin);
> 	int (*cancel_req)(struct tee_context *ctx, u32 cancel_id, u32 session);
> 	int (*supp_recv)(struct tee_context *ctx, u32 *func, u32 *num_params,
> 			 struct tee_param *param);
>
>-- 
>2.34.1
>
