Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE95D3CCAF
	for <op-tee@archiver.kernel.org>; Thu, 15 Jan 2026 06:18:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3EEF343234
	for <op-tee@archiver.kernel.org>; Thu, 15 Jan 2026 06:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768457912;
	bh=ut/eVazHT7/L7ZBosCM6/wzokVAK77+sfc4cfThSwjY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Vn1cVonWYV5dsIWzTjb0wjy1kgAx3ttOX7VOXlLssE2xXa5NrmvUMJmnZYF7Boekc
	 2m6tquuqmnVQsTPeqd3zkP74fyDS+gA59jjSQww1xRCMlKDPmm8I4KzRHirbx9ovyd
	 bPvPulwjIDMNgVWH9LQCf/22IZNw/JzVGS+NJsHngq1VBz3rWvuU0XVWg4dVtae8Vj
	 /ZnHv9d+DlzyH1/rpUkUCX/DqIMDlsCmxvwIsHuhBQSAS1gB7Jwa3zFvUPvUxwvW8k
	 lXW+biO/xiA9XgWeA/uKkitO+sEgX23uZN07BtDWXRSRcyugbcM5t8VY5OnbazG847
	 EN2kESMI04Mqg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B2D5D43234
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Jan 2026 06:18:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z0uizSzi;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C55960153;
	Thu, 15 Jan 2026 06:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F930C19423;
	Thu, 15 Jan 2026 06:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768457892;
	bh=ut/eVazHT7/L7ZBosCM6/wzokVAK77+sfc4cfThSwjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0uizSziP4CO5N1PTa3V3MRoMjvxQ9cijAaCxQ23yjAmAasj6uehxCdc4Wn9+6/U8
	 4l8V2j9gXUFq0cJwsg4BEYCd5/4KLOF8woj9oOLX3Xx7d3fhGE0Q/djlQBspAMlj5L
	 YIZSPVWCeEphh6l+dy2sCQNin7eogBJMUhfMIuvr3iSoV3acY8wUEcN/+RWymsHNiq
	 gcYpkaBJwXnwh+tlZrGxfCFHGiwxbK4sg7A80OSDX2dfqljtsUT2+EW+z2V/zlOAGl
	 54zykhAT01x90Cl+MViRCEbVPPFiUuNwFJAWDiw5D5c7S1e0v0kU7vHa4oSKn614H4
	 SrByOihQUDUWQ==
Date: Thu, 15 Jan 2026 11:48:06 +0530
To: Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v7 2/2] tee: optee: store OS revision for TEE core
Message-ID: <aWiGnhMdLxZsRakx@sumit-xelite>
References: <20260108064517.13854-1-aristo.chen@canonical.com>
 <20260112154833.78546-1-aristo.chen@canonical.com>
 <20260112154833.78546-2-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112154833.78546-2-aristo.chen@canonical.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B2D5D43234
X-Spamd-Bar: --
Message-ID-Hash: C5ZSWDINONTTPE56Q3ZLB4JCYGXPMJ6I
X-Message-ID-Hash: C5ZSWDINONTTPE56Q3ZLB4JCYGXPMJ6I
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/C5ZSWDINONTTPE56Q3ZLB4JCYGXPMJ6I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, Jan 12, 2026 at 11:48:30PM +0800, Aristo Chen wrote:
> Collect OP-TEE OS revision from secure world for both SMC and FF-A
> ABIs, store it in the OP-TEE driver, and expose it through the
> generic get_tee_revision() callback.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  drivers/tee/optee/core.c          | 23 +++++++++++++
>  drivers/tee/optee/ffa_abi.c       | 54 +++++++++++++++++++++++--------
>  drivers/tee/optee/optee_private.h | 19 +++++++++++
>  drivers/tee/optee/smc_abi.c       | 15 +++++++--
>  4 files changed, 94 insertions(+), 17 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
> index bf8390789ecf..8fc72aa95722 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -775,6 +775,39 @@ static int optee_ffa_reclaim_protmem(struct optee *optee,
>   * with a matching configuration.
>   */
>  
> +static bool optee_ffa_get_os_revision(struct ffa_device *ffa_dev,
> +				      const struct ffa_ops *ops,
> +				      struct optee_revision *revision)
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
> +	if (data.data2)
> +		pr_info("revision %lu.%lu (%08lx)",
> +			data.data0, data.data1, data.data2);
> +	else
> +		pr_info("revision %lu.%lu", data.data0, data.data1);
> +
> +	return true;
> +}
> +
>  static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
>  					const struct ffa_ops *ops)
>  {
> @@ -798,20 +831,6 @@ static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
>  		return false;
>  	}
>  
> -	data = (struct ffa_send_direct_data){
> -		.data0 = OPTEE_FFA_GET_OS_VERSION,
> -	};
> -	rc = msg_ops->sync_send_receive(ffa_dev, &data);
> -	if (rc) {
> -		pr_err("Unexpected error %d\n", rc);
> -		return false;
> -	}
> -	if (data.data2)
> -		pr_info("revision %lu.%lu (%08lx)",
> -			data.data0, data.data1, data.data2);
> -	else
> -		pr_info("revision %lu.%lu", data.data0, data.data1);
> -
>  	return true;
>  }
>  
> @@ -900,6 +919,7 @@ static int optee_ffa_open(struct tee_context *ctx)
>  
>  static const struct tee_driver_ops optee_ffa_clnt_ops = {
>  	.get_version = optee_ffa_get_version,
> +	.get_tee_revision = optee_get_revision,
>  	.open = optee_ffa_open,
>  	.release = optee_release,
>  	.open_session = optee_open_session,
> @@ -918,6 +938,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
>  
>  static const struct tee_driver_ops optee_ffa_supp_ops = {
>  	.get_version = optee_ffa_get_version,
> +	.get_tee_revision = optee_get_revision,
>  	.open = optee_ffa_open,
>  	.release = optee_release_supp,
>  	.supp_recv = optee_supp_recv,
> @@ -1060,6 +1081,11 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	if (!optee)
>  		return -ENOMEM;
>  
> +	if (!optee_ffa_get_os_revision(ffa_dev, ffa_ops, &optee->revision)) {
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
