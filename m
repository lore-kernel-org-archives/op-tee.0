Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FAFC982D0
	for <op-tee@archiver.kernel.org>; Fri, 18 Sep 2026 01:46:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1D2CC44402
	for <op-tee@archiver.kernel.org>; Fri, 18 Sep 2026 01:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789695978;
	bh=bJFvNAg7H5agM1HactVxJzTKNHcBmhLKpanpE3FgISU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=l/wa7/bHIMN6T7CNj0eLeDhXMwsk9MUN6KxgZIrYZrG19LV5BHZu2Y1Lgq9VPYDIb
	 XsDtYZ+ki9zU3z+BamDfgPwOJPDYOPMGLmZYKWm1FT1sZTfT42EONGCPDwbnW7Yvmi
	 jTPHnhG3L8qCm4qJVk/Q3jMDZnelxdsEKgDPBxVm4DAXTRx5c7QAqdFN8azCIcDg2w
	 zD/cTziZ6Igq8dynrNmMeiq8JIJ4BRVyasx51xlsuvhuteALiC0UmJUSY1KBqSe+rs
	 bf0aHP9MFxEiTEUQvUPkJEl/vK4eE60RJd+Xhi9kDY+Ha3mBuFTb/Db9mLfaJheelt
	 iw4MaMEpICw8g==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id 7E1B444402
	for <op-tee@lists.trustedfirmware.org>; Fri, 18 Sep 2026 01:46:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpWJjZvg;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id C3D0741AC2;
	Fri, 18 Sep 2026 01:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 23E541F000FF;
	Fri, 18 Sep 2026 01:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789695969;
	bh=2u3meNWxQYQ1Mt8YuVLeCNZ0cRyM5LGDc5fnxMCWsPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpWJjZvgev0voVijt5EhAzd26FhX3J3ELiKBsFwqM4I/TDe+RnQYO9DBdMx/Fkm95
	 IJfCB0pnIxrQ2ZK1sgzd7QCtdBb0WdXtppnwsHOMBERVPd8Ch1ql3r+exPKrbhyEAf
	 w6+98Hk4TMi+0AbTv0t3p7wuigvzFf7h3GkC+T4MQDzq9jgGU7D4LB1TmgFPfoqzUz
	 YoGOroCCccBPRGvWgIOub8fSH2m9C1e8kpDJ1AE1gUqApDGMeegX6ys61G+ArQSQUT
	 kQFxzQJC7ev4cq5GO4xURz4EbpCjMWg55/z2Ru1N6G3y9pAHCwZa0hy3j/snJHK7B8
	 Co/rNZL9zzzWg==
Date: Fri, 18 Sep 2026 04:46:06 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
Message-ID: <aqyX3lJ1eNBmzbSP@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7E1B444402
X-Spamd-Bar: --------
Message-ID-Hash: 2K3YXBCAMXY45O6APTEXIDDQVSMA2FJM
X-Message-ID-Hash: 2K3YXBCAMXY45O6APTEXIDDQVSMA2FJM
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2K3YXBCAMXY45O6APTEXIDDQVSMA2FJM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Mon, Sep 07, 2026 at 02:58:41PM +0530, Kuldeep Singh wrote:
> Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
> is enumerated as a TEE-bus device, allowing a client driver to bind to
> it via its generated UUID.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/call.c        | 4 +++-
>  drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index 4212572ff54b..aca4e8c6e37b 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -753,7 +753,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
>  
>  static const struct qtee_service qtee_services[] = {
>  	{ "qcom.tz.uefisecapp",
> -	   QCOMTEE_UEFI_SEC_UID }
> +	   QCOMTEE_UEFI_SEC_UID },
> +	{ "qcom.tz.tpm",
> +	   QCOMTEE_TPM_UID }
>  };
>  
>  static void qtee_release_service(struct device *dev)
> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
> index ecaf8db67d45..87f1c257a877 100644
> --- a/drivers/tee/qcomtee/qcomtee_msg.h
> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
> @@ -106,6 +106,8 @@ union qcomtee_msg_arg {
>  #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>  
>  #define QCOMTEE_UEFI_SEC_UID            413
> +#define QCOMTEE_TPM_UID			81
> +
>  /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
>  
>  /* The message contains a callback request. */
> 
> -- 
> 2.34.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
