Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FE1CA5FCB
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:44:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4D69B4545F
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790858650;
	bh=t+0B/sAQ3S+l9NYVbZtcH2UUvZ95WL4OO/xfo3lJYEY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=F0wDh//jJ8Li2pKDML3TghUwfjkrq+KXuaUK9v9JQ4ag/+7KHyDyJfQrpdZwuW6ju
	 Zs6gZKBkZ5P6zCPLctdS4tUwm9yQXgi0hHZPKd+LVIfLeyx6RC1b3ZtJeWEmLUmwLf
	 GASnNgSIfbIAuDSs4LnCh0vyXysSUvwqM4TZpXRN/B5lX4lbzxavbmTDrmmo70Goc8
	 GgNybxCeKpTgGJZwUtaGKXyJuGl5/6ULi0g/BG1n1E5L415GnVK8tlqBfuc6vABzjZ
	 0JmB8Lvsink9DDqbRUk/duOU9xAkebzZOwzcFgLRAbBp+U2u+aaWEotQrOqLPdEt3k
	 5IthC8DdkhfQw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3CE6443716
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 12:44:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lw3yNYuW;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A2AD34183F;
	Thu,  1 Oct 2026 12:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DDA1F00899;
	Thu,  1 Oct 2026 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858642;
	bh=rXN5Orvh6wcqwDgLUoyOl8q44kbcCZ04cp0WYtrNd28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lw3yNYuWneYsXq36Dz0QRT4eJVGomNCaXLPibAKzTAn2zplZLxvZhtownDL11Arzq
	 YJ2bV3rgHjWp0l25u9LdG5xUHC1ZihTOylnvjhNXwZm0OOETpCnislnIaF/aEksuKu
	 9K8dO+LztHyXmnyYyeqLJXDTYvR4ZhtTp9Gjin5SJR0e3oZhnG5BL46U2b3VriEsxr
	 msd8lUUmlIvGcLXQqFIetvfqRUvSHiFnvXtsjfN1GKz95wNgOqNz9Wsexl3ViGlX/r
	 9odGos4HXVs5aMy4692DLEdP3acrLIs9GHpZedmF+WA5LWpsTM/mRsQJ/Iham3wXY8
	 gx47hXTX8hnGQ==
Date: Thu, 1 Oct 2026 18:13:55 +0530
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/6] tee: Add kernel client object invoke helper
Message-ID: <ar5Vi8ccysSh4fQ1@sumit-xelite>
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
 <20261001-qcom_uefisecapp_migrate_qcomtee-v3-2-13df5c20c2e3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-2-13df5c20c2e3@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
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
X-Rspamd-Queue-Id: 3CE6443716
X-Spamd-Bar: ------
Message-ID-Hash: OZ6COE2DXXS6GPPASECRWMTTOSSGR6PL
X-Message-ID-Hash: OZ6COE2DXXS6GPPASECRWMTTOSSGR6PL
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OZ6COE2DXXS6GPPASECRWMTTOSSGR6PL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, 01 Oct 2026 at 16:32:34 +0530, Harshal Dev wrote:
>From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>
>Kernel clients can open a TEE context and invoke regular TA commands
>through tee_client_invoke_func(). However, there is currently no
>equivalent helper for invoking TEE objects.
>
>Add tee_client_object_invoke_func() as a kernel client API for issuing
>object invocation requests. The helper checks that the backend provides
>object_invoke_func() before forwarding the request by setting the origin
>as TEE_OBJECT_INVOKE_KERNEL. This allows TEE backends to support
>privileged object-based calls from the kernel-space.
>
>Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>---
> drivers/tee/tee_core.c  | 12 ++++++++++++
> include/linux/tee_drv.h | 13 +++++++++++++
> 2 files changed, 25 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>index 30901390149c..a03a3d645dd1 100644
>--- a/drivers/tee/tee_core.c
>+++ b/drivers/tee/tee_core.c
>@@ -1404,6 +1404,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
> }
> EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>
>+int tee_client_object_invoke_func(struct tee_context *ctx,
>+				  struct tee_ioctl_object_invoke_arg *arg,
>+				  struct tee_param *param)
>+{
>+	if (!ctx->teedev->desc->ops->object_invoke_func)
>+		return -EINVAL;
>+
>+	return ctx->teedev->desc->ops->object_invoke_func(ctx, arg, param,
>+							  TEE_OBJECT_INVOKE_KERNEL);
>+}
>+EXPORT_SYMBOL_GPL(tee_client_object_invoke_func);
>+
> int tee_client_cancel_req(struct tee_context *ctx,
> 			  struct tee_ioctl_cancel_arg *arg)
> {
>diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>index f3c5e106d853..369c87ad0205 100644
>--- a/include/linux/tee_drv.h
>+++ b/include/linux/tee_drv.h
>@@ -283,6 +283,19 @@ int tee_client_invoke_func(struct tee_context *ctx,
> 			   struct tee_ioctl_invoke_arg *arg,
> 			   struct tee_param *param);
>
>+/**
>+ * tee_client_object_invoke_func() - Invoke a TEE object from kernel space
>+ * @ctx:    TEE Context
>+ * @arg:    Invoke arguments, see description of
>+ *          struct tee_ioctl_object_invoke_arg
>+ * @param:  Parameters for the object invocation
>+ *
>+ * Return: On success, returns 0; on failure, returns < 0.
>+ */
>+int tee_client_object_invoke_func(struct tee_context *ctx,
>+				  struct tee_ioctl_object_invoke_arg *arg,
>+				  struct tee_param *param);
>+
> /**
>  * tee_client_cancel_req() - Request cancellation of the previous open-session
>  * or invoke-command operations in a Trusted Application
>
>-- 
>2.34.1
>
