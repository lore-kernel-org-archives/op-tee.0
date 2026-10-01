Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F1BCA5FCB
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:48:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CD89E44A49
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790858880;
	bh=C/a+BCNKjiJqGxIvspHg8Oa9sIw0CltanatdAqCPbuo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JBqj8QA/9TT3g4zIO4ZrzdngRdG5bKTO5drWnRoYLFlPDKzYgvEGMfB+PZ1FQa6OR
	 C+9E05Df1uG5DRKh47zRVZq67GwLVbnpznoAsWtzeLF+zGFGc9rytBlqzhBr//LmUX
	 hMJf9GLyaCEfHExu7XTgmikZGpZD/+UM5uqeI+qS4VTVe8Z8Zm0lCqk4rE3hnSvBOD
	 Di7ETxOsG/a4plZPU9iC/xuLgSLpBN30PiZMgIWiYnNq+ghcqnr+Y7veXaCjiM/2qn
	 zw5VLlR6HpzfqCczHxIdbIf/oT25QENAalIZ/J7S/sMnD0uzUNgxOV+Vxu+jX++9No
	 xaiMh7S6vD1MQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 505223E882
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 12:47:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yfqn/mBu;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BE70F60A55;
	Thu,  1 Oct 2026 12:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031961F000FF;
	Thu,  1 Oct 2026 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858873;
	bh=HM9xaKm75iHB1jueHcwqdbWn6Lp/O/gNvxajH9JPnTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yfqn/mBuWdeWEsetuiGqwLPvVWz//IiDPGDY3lR30HJk86SG//Zq56vprY9rv5PiA
	 CUeFTPzjwQqQl4yp7apsr72dK3a2C4jdPpFQeOTW7MWxp7z3XMP+DDK7v6y+oR2HjN
	 NmdR1LN6b7m8Cf1mr7LVjsUw7m9Ok0Opfv6RN2yK3MZoGbTOMGE1gld85gJbW5yPsE
	 MoSqGS06yKOl2743R/CDYQEki8DTdHmIhQlLd3/as/ABRb1RejWA6SGVUx/DZInJyt
	 tX2YNw9NrRANrw9V2LsqVxxKG4xm2nwTupAstRwflxJ1agEl/soQZRb1r1a7ecbrod
	 NSSrraJqfesCA==
Date: Thu, 1 Oct 2026 18:17:46 +0530
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/6] tee: qcomtee: Allow object invokes from kernel
 clients
Message-ID: <ar5Wcpom0Ex29Sl5@sumit-xelite>
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
 <20261001-qcom_uefisecapp_migrate_qcomtee-v3-3-13df5c20c2e3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-3-13df5c20c2e3@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 505223E882
X-Spamd-Bar: -------
Message-ID-Hash: 7EMO7G2L4THNTAKEEIG2OZLE3AO3Q6AA
X-Message-ID-Hash: 7EMO7G2L4THNTAKEEIG2OZLE3AO3Q6AA
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7EMO7G2L4THNTAKEEIG2OZLE3AO3Q6AA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, 01 Oct 2026 at 16:32:35 +0530, Harshal Dev wrote:
>From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>
>QCOMTEE currently treats UBUF parameters as userspace addresses and
>applies userspace restrictions when invoking the root object. This is
>not suitable for object invocation requests issued by kernel clients.
>
>Use the kernel_ctx flag to distinguish kernel client requests from
>userspace requests. For kernel contexts, do not mark UBUF parameters as
>user addresses, and allow permitted root-object operations to proceed
>without applying the userspace-only checks.
>
>This allows in-kernel users of tee_client_object_invoke_func() to issue
>object invocation requests through the qcomtee backend.
>
>Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>---
> drivers/tee/qcomtee/call.c           | 34 +++++++++++++++++++++++-----------
> drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
> include/linux/tee_drv.h              |  5 ++++-
> 3 files changed, 30 insertions(+), 14 deletions(-)

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>index a0f2992c0611..b361d9c04de0 100644
>--- a/drivers/tee/qcomtee/call.c
>+++ b/drivers/tee/qcomtee/call.c
>@@ -202,7 +202,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
>  */
> static int qcomtee_params_to_args(struct qcomtee_arg *u,
> 				  struct tee_param *params, int num_params,
>-				  struct tee_context *ctx)
>+				  struct qcomtee_object_invoke_ctx *oic)
> {
> 	int i;
>
>@@ -210,8 +210,14 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
> 		switch (params[i].attr) {
> 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
> 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
>-			u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
>-			u[i].b.uaddr = params[i].u.ubuf.uaddr;
>+			if (oic->kernel_ctx) {
>+				u[i].flags = 0;
>+				u[i].b.addr = params[i].u.ubuf.addr;
>+			} else {
>+				u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
>+				u[i].b.uaddr = params[i].u.ubuf.uaddr;
>+			}
>+
> 			u[i].b.size = params[i].u.ubuf.size;
>
> 			if (params[i].attr ==
>@@ -223,7 +229,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
> 			break;
> 		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
> 			u[i].type = QCOMTEE_ARG_TYPE_IO;
>-			if (qcomtee_objref_to_arg(&u[i], &params[i], ctx))
>+			if (qcomtee_objref_to_arg(&u[i], &params[i], oic->ctx))
> 				goto out_failed;
>
> 			break;
>@@ -270,7 +276,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>  */
> static int qcomtee_params_from_args(struct tee_param *params,
> 				    struct qcomtee_arg *u, int num_params,
>-				    struct tee_context *ctx)
>+				    struct qcomtee_object_invoke_ctx *oic)
> {
> 	int i, np;
>
>@@ -288,7 +294,8 @@ static int qcomtee_params_from_args(struct tee_param *params,
> 			break;
> 		case QCOMTEE_ARG_TYPE_OO:
> 			/* TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT */
>-			if (qcomtee_objref_from_arg(&params[np], &u[np], ctx))
>+			if (qcomtee_objref_from_arg(&params[np], &u[np],
>+						    oic->ctx))
> 				goto out_failed;
>
> 			break;
>@@ -304,7 +311,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
> 	/* Undo qcomtee_objref_from_arg(). */
> 	for (i = 0; i < np; i++) {
> 		if (params[i].attr == TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT)
>-			qcomtee_context_del_qtee_object(&params[i], ctx);
>+			qcomtee_context_del_qtee_object(&params[i], oic->ctx);
> 	}
>
> 	/* Release any IO and OO objects not processed. */
>@@ -357,7 +364,8 @@ static int qcomtee_params_check(struct tee_param *params, int num_params)
> }
>
> /* Check if an operation on ROOT_QCOMTEE_OBJECT from userspace is permitted. */
>-static int qcomtee_root_object_check(u32 op, struct tee_param *params,
>+static int qcomtee_root_object_check(struct qcomtee_object_invoke_ctx *oic,
>+				     u32 op, struct tee_param *params,
> 				     int num_params)
> {
> 	/* Some privileged operations recognized by QTEE. */
>@@ -366,6 +374,9 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
> 	    op == QCOMTEE_ROOT_OP_ADCI_SHUTDOWN)
> 		return -EINVAL;
>
>+	if (oic->kernel_ctx)
>+		return 0;
>+
> 	/*
> 	 * QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS is to register with QTEE
> 	 * by passing a credential object as input OBJREF. TEE_OBJREF_NULL as a
>@@ -429,7 +440,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
> 	/* Get an object to invoke. */
> 	if (arg->id == TEE_OBJREF_NULL) {
> 		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
>-		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
>+		if (qcomtee_root_object_check(oic, arg->op, params,
>+					      arg->num_params))
> 			return -EINVAL;
>
> 		object = ROOT_QCOMTEE_OBJECT;
>@@ -437,7 +449,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
> 		return -EINVAL;
> 	}
>
>-	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
>+	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
> 	if (ret)
> 		goto out;
>
>@@ -455,7 +467,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>
> 	if (!result) {
> 		/* Assume service is UNAVAIL if unable to process the result. */
>-		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
>+		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
> 			result = QCOMTEE_MSG_ERROR_UNAVAIL;
> 	} else {
> 		/*
>diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
>index 5f40617361fc..d3740099fae0 100644
>--- a/drivers/tee/qcomtee/qcomtee_object.h
>+++ b/drivers/tee/qcomtee/qcomtee_object.h
>@@ -113,8 +113,9 @@ struct qcomtee_buffer {
>  * @b: address and size if the type of argument is a buffer.
>  * @o: object instance if the type of argument is an object.
>  *
>- * &qcomtee_arg.flags only accepts %QCOMTEE_ARG_FLAGS_UADDR for now, which
>- * states that &qcomtee_arg.b contains a userspace address in uaddr.
>++ * If %QCOMTEE_ARG_FLAGS_UADDR is set in &qcomtee_arg.flags then it implies
>++ * that &qcomtee_arg.b contains a userspace address in uaddr.
>++ * Otherwise, &qcomtee_arg.b contains a kernel address in addr.
>  */
> struct qcomtee_arg {
> 	enum qcomtee_arg_type type;
>diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>index 369c87ad0205..367208210a32 100644
>--- a/include/linux/tee_drv.h
>+++ b/include/linux/tee_drv.h
>@@ -83,7 +83,10 @@ struct tee_param_memref {
> };
>
> struct tee_param_ubuf {
>-	void __user *uaddr;
>+	union {
>+		void *addr;
>+		void __user *uaddr;
>+	};
> 	size_t size;
> };
>
>
>-- 
>2.34.1
>
