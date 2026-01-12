Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D63D26D97
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 09:55:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E012B4327C
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 09:55:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y6gHaNkn;
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C0EF043273
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 09:55:06 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b72a1e2f0so5868040e87.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 01:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768211705; x=1768816505; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=If/0F4Dgd4go54V02toMplYt72r7M7684FwIgzepZlg=;
        b=Y6gHaNknTMu6MoiGzjV9oFWLoz5tIJNRN9NDR8e8yxEqtTM7DQ5VBjS2NuroylvjI+
         Lxz1Q+KAjNl+0FDuCc9VQry2n4GCOqCOBKFkg0ViV+xgWG7JcEUlfm2oatyiTdif+pyX
         L9PAY65vYvQhEVEKf0PQFbL0gEA6uniN7Tl8huIzNswA77ZxiL0+NJ6bCuAo0N64xi13
         r51mq9TXK0tusifcrz24/ec8kivmvFEFzicYByA5lPqRrxPziH79oVzub+Qg9LWjJjMN
         YEc4tGA6jUpPnhi3iYgLu71isV3hJpyb/ECEUgIPWEC9N44bz2j5wA77Uubp48EVn3K2
         E0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768211705; x=1768816505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If/0F4Dgd4go54V02toMplYt72r7M7684FwIgzepZlg=;
        b=iznn4Qj9Kha4ASuwCSRiWo6ReQxZLOd3gfrv1gJQMPyNEyQKeGTUE0BmXxKqaElWMo
         d822sibTK8zp/PcNjVA1H70RbuUjgpiPvzYsVuUneK+gcp39Q/eVIIx2Kw6d4btVDWI1
         gHX7xbkYewA6MUDP4vlcPDLd6fGW6B0kQ1kNnduvQZTVC9c751ZBprM7w0VsZTTOjIxB
         gf8ihirGQKigJlk2VS2dYDI3PZoR2Cexs50Vp3124u6JBdZFYzaWwXj1gazgUZRr5vhs
         lo5D6gRgic08V8mD51Fnp4aRt6VpvQrrF4uhECfn2BvDPpEVpJjWsN3/p1IvFbeeDKbS
         7FTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWJ1IgyzBFozlG677ygwrAhd77mc5YQprfjF5Qxt63E04G+R9gUGmplDYyqfIB4xYnECCFC/o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywwx4tdk1Xth9iwcLgJlRikELGOVqiOU6q4T//0r6UShMiJibvD
	yHMNCjo5oAbfldLe25mh5ICBM1PREIoDjnwBIWP+AarA6aUN+s9HZ9JCvk8TCAxB26GCOA==
X-Gm-Gg: AY/fxX6TAEUQ0sLB9l18rnMHWYd4h7syLZVnpUhRZuABW62ocZe9wwRv2rY9PTWWARz
	F9pGyI6bSM4fSDmUrOytxAxZk1W+CIkJOsfsUTcHq35m9Jy5DHJQvQ0Tkd/nDIvzpPGsvywewmx
	rovzywxNnalsOP0FxkR2MZkROhsBbl7+JCiZ0HvrRaoAkWBfHen0WWv5pZ7P6mpjwRcDoN5q7Jj
	YKN4gW3UT+wdhBbG12GrttZol+aXVetdPPFYkJsI1emF/lKlWcvTKMjhquxihkUmqqLVk34hT5j
	k5qyQpD2Yi9J7ko9QFirR1S1Iz3oITCP9XeYmm1RLBr/bhko4IpWM+fcuYjct1PghJ2ILYFMnCN
	fU4ygBUCti079OnhlbF+rEfSS9rZtYD+x60vReYpAxWM8qqYOU2/YYbd+oVFAH5Ax6r2q7j59O7
	IrC3iiRqyhYaIqDfekeaYMgWIZ73ta69RaAOY0wvoLI4URV2kX9KeimzyauWVKg3+wNi6iod9Lz
	kOsJpA=
X-Google-Smtp-Source: AGHT+IE/luQK6ZRZ24KHDfr++nGrZL/HCaks/LIfYd5i4OLAWSGOiXtxyw0tX0h7gVf9kbEkeI4nIQ==
X-Received: by 2002:a05:6512:3ba6:b0:59b:8465:b44e with SMTP id 2adb3069b0e04-59b8465b640mr2372867e87.41.1768211705418;
        Mon, 12 Jan 2026 01:55:05 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b73132ff8sm3604441e87.70.2026.01.12.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:55:04 -0800 (PST)
Date: Mon, 12 Jan 2026 10:55:03 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: Aristo Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH v6 2/2] tee: optee: store OS revision for TEE core
Message-ID: <20260112095503.GA2835866@rayden>
References: <20260107152607.902735-1-aristo.chen@canonical.com>
 <20260108064517.13854-1-aristo.chen@canonical.com>
 <20260108064517.13854-2-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108064517.13854-2-aristo.chen@canonical.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.50:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.50:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C0EF043273
X-Spamd-Bar: --
Message-ID-Hash: 2HXXPNYO6H6JYFRQG67DNNPBPPBS5I2D
X-Message-ID-Hash: 2HXXPNYO6H6JYFRQG67DNNPBPPBS5I2D
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2HXXPNYO6H6JYFRQG67DNNPBPPBS5I2D/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, Jan 08, 2026 at 02:45:09PM +0800, Aristo Chen wrote:
> Collect OP-TEE OS revision from secure world for both SMC and FF-A
> ABIs, store it in the OP-TEE driver, and expose it through the
> generic get_tee_revision() callback.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  drivers/tee/optee/core.c          | 23 +++++++++++++
>  drivers/tee/optee/ffa_abi.c       | 57 ++++++++++++++++++++++++-------
>  drivers/tee/optee/optee_private.h | 19 +++++++++++
>  drivers/tee/optee/smc_abi.c       | 15 ++++++--
>  4 files changed, 99 insertions(+), 15 deletions(-)

Checkpatch complains with:
CHECK: Alignment should match open parenthesis
#62: FILE: drivers/tee/optee/ffa_abi.c:779:
+static bool optee_ffa_get_os_revision(struct ffa_device *ffa_dev,
+					const struct ffa_ops *ops,

CHECK: Alignment should match open parenthesis
#142: FILE: drivers/tee/optee/ffa_abi.c:1091:
+	if (!optee_ffa_get_os_revision(ffa_dev, ffa_ops, &optee->revision,
+					 false)) {

WARNING: From:/Signed-off-by: email address mismatch: 'From: Aristo Chen <jj251510319013@gmail.com>' != 'Signed-off-by: Aristo Chen <aristo.chen@canonical.com>'

total: 0 errors, 1 warnings, 2 checks, 199 lines checked

Cheers,
Jens

> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 5b62139714ce..2d807bc748bc 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -63,6 +63,29 @@ int optee_set_dma_mask(struct optee *optee, u_int pa_width)
>  	return dma_coerce_mask_and_coherent(&optee->teedev->dev, mask);
>  }
>  
> +int optee_get_revision(struct tee_device *teedev, char *buf, size_t len)
> +{
> +	struct optee *optee = tee_get_drvdata(teedev);
> +	u64 build_id;
> +
> +	if (!optee)
> +		return -ENODEV;
> +	if (!buf || !len)
> +		return -EINVAL;
> +
> +	build_id = optee->revision.os_build_id;
> +	if (build_id)
> +		scnprintf(buf, len, "%u.%u (%016llx)",
> +			  optee->revision.os_major,
> +			  optee->revision.os_minor,
> +			  (unsigned long long)build_id);
> +	else
> +		scnprintf(buf, len, "%u.%u", optee->revision.os_major,
> +			  optee->revision.os_minor);
> +
> +	return 0;
> +}
> +
>  static void optee_bus_scan(struct work_struct *work)
>  {
>  	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index bf8390789ecf..82dbed1c87e5 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -775,6 +775,42 @@ static int optee_ffa_reclaim_protmem(struct optee *optee,
>   * with a matching configuration.
>   */
>  
> +static bool optee_ffa_get_os_revision(struct ffa_device *ffa_dev,
> +					const struct ffa_ops *ops,
> +					struct optee_revision *revision,
> +					bool log)
> +{
> +	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
> +	struct ffa_send_direct_data data = {
> +		.data0 = OPTEE_FFA_GET_OS_VERSION,
> +	};
> +	int rc;
> +
> +	msg_ops->mode_32bit_set(ffa_dev);
> +
> +	rc = msg_ops->sync_send_receive(ffa_dev, &data);
> +	if (rc) {
> +		pr_err("Unexpected error %d\n", rc);
> +		return false;
> +	}
> +
> +	if (revision) {
> +		revision->os_major = data.data0;
> +		revision->os_minor = data.data1;
> +		revision->os_build_id = data.data2;
> +	}
> +
> +	if (log) {
> +		if (data.data2)
> +			pr_info("revision %lu.%lu (%08lx)",
> +				data.data0, data.data1, data.data2);
> +		else
> +			pr_info("revision %lu.%lu", data.data0, data.data1);
> +	}
> +
> +	return true;
> +}
> +
>  static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
>  					const struct ffa_ops *ops)
>  {
> @@ -798,19 +834,8 @@ static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
>  		return false;
>  	}
>  
> -	data = (struct ffa_send_direct_data){
> -		.data0 = OPTEE_FFA_GET_OS_VERSION,
> -	};
> -	rc = msg_ops->sync_send_receive(ffa_dev, &data);
> -	if (rc) {
> -		pr_err("Unexpected error %d\n", rc);
> +	if (!optee_ffa_get_os_revision(ffa_dev, ops, NULL, true))
>  		return false;
> -	}
> -	if (data.data2)
> -		pr_info("revision %lu.%lu (%08lx)",
> -			data.data0, data.data1, data.data2);
> -	else
> -		pr_info("revision %lu.%lu", data.data0, data.data1);
>  
>  	return true;
>  }
> @@ -900,6 +925,7 @@ static int optee_ffa_open(struct tee_context *ctx)
>  
>  static const struct tee_driver_ops optee_ffa_clnt_ops = {
>  	.get_version = optee_ffa_get_version,
> +	.get_tee_revision = optee_get_revision,
>  	.open = optee_ffa_open,
>  	.release = optee_release,
>  	.open_session = optee_open_session,
> @@ -918,6 +944,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
>  
>  static const struct tee_driver_ops optee_ffa_supp_ops = {
>  	.get_version = optee_ffa_get_version,
> +	.get_tee_revision = optee_get_revision,
>  	.open = optee_ffa_open,
>  	.release = optee_release_supp,
>  	.supp_recv = optee_supp_recv,
> @@ -1060,6 +1087,12 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	if (!optee)
>  		return -ENOMEM;
>  
> +	if (!optee_ffa_get_os_revision(ffa_dev, ffa_ops, &optee->revision,
> +					 false)) {
> +		rc = -EINVAL;
> +		goto err_free_optee;
> +	}
> +
>  	pool = optee_ffa_shm_pool_alloc_pages();
>  	if (IS_ERR(pool)) {
>  		rc = PTR_ERR(pool);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index db9ea673fbca..acd3051c4879 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -171,6 +171,24 @@ struct optee_ffa {
>  
>  struct optee;
>  
> +/**
> + * struct optee_revision - OP-TEE OS revision reported by secure world
> + * @os_major:		OP-TEE OS major version
> + * @os_minor:		OP-TEE OS minor version
> + * @os_build_id:	OP-TEE OS build identifier (0 if unspecified)
> + *
> + * Values come from OPTEE_SMC_CALL_GET_OS_REVISION (SMC ABI) or
> + * OPTEE_FFA_GET_OS_VERSION (FF-A ABI); this is the trusted OS revision, not an
> + * FF-A ABI version.
> + */
> +struct optee_revision {
> +	u32 os_major;
> +	u32 os_minor;
> +	u64 os_build_id;
> +};
> +
> +int optee_get_revision(struct tee_device *teedev, char *buf, size_t len);
> +
>  /**
>   * struct optee_ops - OP-TEE driver internal operations
>   * @do_call_with_arg:	enters OP-TEE in secure world
> @@ -249,6 +267,7 @@ struct optee {
>  	bool in_kernel_rpmb_routing;
>  	struct work_struct scan_bus_work;
>  	struct work_struct rpmb_scan_bus_work;
> +	struct optee_revision revision;
>  };
>  
>  struct optee_session {
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 0be663fcd52b..51fae1ab8ef8 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1242,6 +1242,7 @@ static int optee_smc_open(struct tee_context *ctx)
>  
>  static const struct tee_driver_ops optee_clnt_ops = {
>  	.get_version = optee_get_version,
> +	.get_tee_revision = optee_get_revision,
>  	.open = optee_smc_open,
>  	.release = optee_release,
>  	.open_session = optee_open_session,
> @@ -1261,6 +1262,7 @@ static const struct tee_desc optee_clnt_desc = {
>  
>  static const struct tee_driver_ops optee_supp_ops = {
>  	.get_version = optee_get_version,
> +	.get_tee_revision = optee_get_revision,
>  	.open = optee_smc_open,
>  	.release = optee_release_supp,
>  	.supp_recv = optee_supp_recv,
> @@ -1323,7 +1325,8 @@ static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invoke_fn)
>  }
>  #endif
>  
> -static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> +static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
> +				      struct optee_revision *revision)
>  {
>  	union {
>  		struct arm_smccc_res smccc;
> @@ -1337,6 +1340,12 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
>  	invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
>  		  &res.smccc);
>  
> +	if (revision) {
> +		revision->os_major = res.result.major;
> +		revision->os_minor = res.result.minor;
> +		revision->os_build_id = res.result.build_id;
> +	}
> +
>  	if (res.result.build_id)
>  		pr_info("revision %lu.%lu (%0*lx)", res.result.major,
>  			res.result.minor, (int)sizeof(res.result.build_id) * 2,
> @@ -1745,8 +1754,6 @@ static int optee_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	optee_msg_get_os_revision(invoke_fn);
> -
>  	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
>  		pr_warn("api revision mismatch\n");
>  		return -EINVAL;
> @@ -1815,6 +1822,8 @@ static int optee_probe(struct platform_device *pdev)
>  		goto err_free_shm_pool;
>  	}
>  
> +	optee_msg_get_os_revision(invoke_fn, &optee->revision);
> +
>  	optee->ops = &optee_ops;
>  	optee->smc.invoke_fn = invoke_fn;
>  	optee->smc.sec_caps = sec_caps;
> -- 
> 2.43.0
> 
