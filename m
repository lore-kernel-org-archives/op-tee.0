Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD597C2A062
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 05:20:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 099714FF33
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 05:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767590453;
	bh=MGWLyAzs3XL3xB15xnwOevvpI3yV67UdzZWSsRLo94A=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=WjWv4gUsqAzem5JzuvzpFkSD5WW2ZMcl4Rrl3dXIB/bVwrCqrmp4RaNy4x7m0e01v
	 RQitqVMQ516Lf0eWHGcanQACLd0fxG84qfOLYRAAsf0GvbUPMiQcmKirxOOu1X0Ls4
	 NN22fHWJDyhmo/lJRHcvroQb6q8gpwsW5/vuw3u1lqR3u2PT5YHAYH0OIjBsidzh2h
	 UgHFwocKTler2W3H+0l60T1nrWyBAOZZROvocC+ymlabuX2fX57ujUSE2DJSxKsMzj
	 KR4/faPQinyQglAEMtAMi6i1UN9F9mwJr3LGx2GmIt8qrc/N6cDL0fc2E5W98Nstny
	 j7X5cWxFyCmjw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8CFC141B30
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 05:20:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KQTZPfqk;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E60DC416C7;
	Mon,  5 Jan 2026 05:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16FEC116D0;
	Mon,  5 Jan 2026 05:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767590434;
	bh=MGWLyAzs3XL3xB15xnwOevvpI3yV67UdzZWSsRLo94A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQTZPfqkV8kXp664t412s+AwbTU1CQIHqYCRTkw7SA1q1VpHTr0EjJTzTlTQKlOnM
	 OgREDde8omq+8U2GWsmRV+/bW6b0lEZxu8GVt8W3+6Pqr12wVTIG3oNTqtVDCq7O5F
	 Xm9xTBmBhbBO7ndtzNH0VXWyVdBCaLg5S5HcAB6vTdAbcPLg287NpwZLh+Nk5HaSVo
	 SFxqkS/qdCyLhIx4keuaxWjEE351Wivng61kKL7FpkaEDvW0AsNlyHBGSfAtAN8nLz
	 MW/DS5O9YxBITsKpFlXbrahCMwe0TN72SpXvRWPnwZZrBeRPq08w5oRz4wNeHA1N0M
	 fC+3/rPCeEosw==
Date: Mon, 5 Jan 2026 10:50:28 +0530
To: Aristo Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH v4 2/2] tee: optee: store OS revision for TEE core
Message-ID: <aVtKHF3krwJWiCth@sumit-xelite>
References: <20251226131920.64582-1-aristo.chen@canonical.com>
 <20251230051804.6230-1-aristo.chen@canonical.com>
 <20251230051804.6230-2-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230051804.6230-2-aristo.chen@canonical.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8CFC141B30
X-Spamd-Bar: --
Message-ID-Hash: 52OZD66HK2QTJKMJOQYL55LDNCP3PQIJ
X-Message-ID-Hash: 52OZD66HK2QTJKMJOQYL55LDNCP3PQIJ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/52OZD66HK2QTJKMJOQYL55LDNCP3PQIJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Dec 30, 2025 at 01:17:59PM +0800, Aristo Chen wrote:
> Collect OP-TEE OS revision from secure world for both SMC and FF-A ABIs,
> store it in the OP-TEE driver, and expose it through the generic
> get_tee_revision() callback.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  drivers/tee/optee/core.c          | 23 +++++++++++++++++++++++
>  drivers/tee/optee/ffa_abi.c       | 14 ++++++++++++--
>  drivers/tee/optee/optee_private.h | 19 +++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       | 15 +++++++++++++--
>  4 files changed, 67 insertions(+), 4 deletions(-)
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
> index bf8390789ecf..d67ca1ec9506 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -776,7 +776,8 @@ static int optee_ffa_reclaim_protmem(struct optee *optee,
>   */
>  
>  static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
> -					const struct ffa_ops *ops)
> +					const struct ffa_ops *ops,
> +					struct optee_revision *revision)
>  {
>  	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
>  	struct ffa_send_direct_data data = {
> @@ -806,6 +807,11 @@ static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
>  		pr_err("Unexpected error %d\n", rc);
>  		return false;
>  	}
> +	if (revision) {
> +		revision->os_major = data.data0;
> +		revision->os_minor = data.data1;
> +		revision->os_build_id = data.data2;
> +	}
>  	if (data.data2)
>  		pr_info("revision %lu.%lu (%08lx)",
>  			data.data0, data.data1, data.data2);
> @@ -900,6 +906,7 @@ static int optee_ffa_open(struct tee_context *ctx)
>  
>  static const struct tee_driver_ops optee_ffa_clnt_ops = {
>  	.get_version = optee_ffa_get_version,
> +	.get_tee_revision = optee_get_revision,
>  	.open = optee_ffa_open,
>  	.release = optee_release,
>  	.open_session = optee_open_session,
> @@ -918,6 +925,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
>  
>  static const struct tee_driver_ops optee_ffa_supp_ops = {
>  	.get_version = optee_ffa_get_version,
> +	.get_tee_revision = optee_get_revision,
>  	.open = optee_ffa_open,
>  	.release = optee_release_supp,
>  	.supp_recv = optee_supp_recv,
> @@ -1034,6 +1042,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  {
>  	const struct ffa_notifier_ops *notif_ops;
>  	const struct ffa_ops *ffa_ops;
> +	struct optee_revision revision = { };

No need for this redundant variable on stack when...

>  	unsigned int max_notif_value;
>  	unsigned int rpc_param_count;
>  	struct tee_shm_pool *pool;
> @@ -1047,7 +1056,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	ffa_ops = ffa_dev->ops;
>  	notif_ops = ffa_ops->notifier_ops;
>  
> -	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
> +	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &revision))

...you can just invoke this API as rather:

	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &optee->revision))

>  		return -EINVAL;
>  
>  	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> @@ -1059,6 +1068,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
>  	if (!optee)
>  		return -ENOMEM;
> +	optee->revision = revision;
>  
>  	pool = optee_ffa_shm_pool_alloc_pages();
>  	if (IS_ERR(pool)) {
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
> index 0be663fcd52b..0baaf7986a35 100644
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
> @@ -1727,6 +1736,7 @@ static int optee_probe(struct platform_device *pdev)
>  	unsigned int thread_count;
>  	struct tee_device *teedev;
>  	struct tee_context *ctx;
> +	struct optee_revision revision = { };

Ditto here.

-Sumit

>  	u32 max_notif_value;
>  	u32 arg_cache_flags;
>  	u32 sec_caps;
> @@ -1745,7 +1755,7 @@ static int optee_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	optee_msg_get_os_revision(invoke_fn);
> +	optee_msg_get_os_revision(invoke_fn, &revision);
>  
>  	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
>  		pr_warn("api revision mismatch\n");
> @@ -1837,6 +1847,7 @@ static int optee_probe(struct platform_device *pdev)
>  		goto err_unreg_teedev;
>  	}
>  	optee->supp_teedev = teedev;
> +	optee->revision = revision;
>  
>  	optee_set_dev_group(optee);
>  
> -- 
> 2.43.0
> 
