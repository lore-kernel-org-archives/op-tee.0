Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C69D3B7E5
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 04:59:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CECE14FDB0
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 04:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1766984377;
	bh=EQJFW7a+Y5zpfFGguXRxIZ5a0E7CT4822cKjt5oLYBo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eWJBcLuvG+4e2JOoL1bkJ6/ORCyGz4SrnJ1jaLPrir91JS4/JYPhGFmHF1hYODBDr
	 kybS/lfE+b6jKItw1caamdfASD9xPgyLSsViZa473/D6AZhqzAS3VV/gafjVObghaP
	 sGLoRjlffRAxIofcGYk8j7xYDYenlf7O//cU86ZjGdJrWYid67fZkB51HXSxUq7RX0
	 FmJYFCUz+4nkWScmgbQiIzi1zEK8YbHl57yVNqysy7uY5VTUTboYd6wkvZCypn39FY
	 v73xPU6EgHa/3mZ+Af10pm0tXoKi4xOuYJhrgioLV8L+uUzA5cSo7pen8X3ej8DCVw
	 8Tc1eERQjmdKA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C036740B29
	for <op-tee@lists.trustedfirmware.org>; Mon, 29 Dec 2025 04:59:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ipumCXEC;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 30EF143FFE;
	Mon, 29 Dec 2025 04:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D654C4CEF7;
	Mon, 29 Dec 2025 04:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766984358;
	bh=EQJFW7a+Y5zpfFGguXRxIZ5a0E7CT4822cKjt5oLYBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipumCXECnTHI4Qg6lPdtUkfAHDcGIdHHq/+pNwpAXqb0+wLXUAIMslDY9ioUPyM5L
	 PJ95/7V8O6uiS//3BbVED2z8cBQhliWs0H+jK+ku95vwZzV+hV0pPzIpIHdHpOHSdw
	 eSqxyf4pA25Ow4I9HQsHnngwkJB60x3fDhMeGT3DhHJUq/bkVnC3c8btj4bkpYaqnJ
	 qSNZGr9WyQMeWlNLoqKzQ9Cbdo8Ewm1CDbm5Gh+Zilz0Ud1uV4tVny2l7SEvuYOegW
	 uatYXrhYHmzeD+Z1xE7npLDziNLiqdRm0JLwY98BswuxnZdnUaCZu/l7sgd1JfGcZY
	 J3kTZ8Hilyjyw==
Date: Mon, 29 Dec 2025 10:29:11 +0530
To: Aristo Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH v3 1/1] tee: optee: expose OS revision via sysfs
Message-ID: <aVIKn4HgmCFZOcn8@sumit-xelite>
References: <20251122145924.381725-1-jj251510319013@gmail.com>
 <20251226131920.64582-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226131920.64582-1-aristo.chen@canonical.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C036740B29
X-Spamd-Bar: ---
Message-ID-Hash: KTLOICI4SV6CHPPYVIACYVLVPLHNUK3U
X-Message-ID-Hash: KTLOICI4SV6CHPPYVIACYVLVPLHNUK3U
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KTLOICI4SV6CHPPYVIACYVLVPLHNUK3U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

Hi Aristo,

On Fri, Dec 26, 2025 at 09:19:13PM +0800, Aristo Chen wrote:
> Today the only way to read the OP-TEE OS version is from dmesg/journal
> logs, which can be lost as buffers roll over. Capture the OS revision
> (major/minor/build_id) from secure world for both SMC and FF-A ABIs, store
> it in the OP-TEE driver, and expose a stable userspace readout via
> /sys/class/tee/tee*/revision.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  Documentation/ABI/testing/sysfs-class-tee | 10 +++++
>  drivers/tee/optee/core.c                  | 22 ++++++++++
>  drivers/tee/optee/ffa_abi.c               | 25 ++++++++++-
>  drivers/tee/optee/optee_private.h         | 19 +++++++++
>  drivers/tee/optee/smc_abi.c               | 25 ++++++++++-
>  drivers/tee/tee_core.c                    | 52 ++++++++++++++++++++++-
>  include/linux/tee_core.h                  |  5 +++
>  include/linux/tee_drv.h                   |  3 ++
>  8 files changed, 156 insertions(+), 5 deletions(-)

Please split up this patch properly as to what goes into the generic TEE
driver vs the OP-TEE changes.

> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
> index c9144d16003e..6e783210104e 100644
> --- a/Documentation/ABI/testing/sysfs-class-tee
> +++ b/Documentation/ABI/testing/sysfs-class-tee
> @@ -13,3 +13,13 @@ Description:
>  		space if the variable is absent. The primary purpose
>  		of this variable is to let systemd know whether
>  		tee-supplicant is needed in the early boot with initramfs.
> +
> +What:		/sys/class/tee/tee{,priv}X/revision
> +Date:		Dec 2025
> +KernelVersion:	6.18
> +Contact:	op-tee@lists.trustedfirmware.org
> +Description:
> +		Read-only revision string reported by the TEE driver. This is
> +		for diagnostics only and must not be used to infer feature
> +		support. Use TEE_IOC_VERSION for capability and compatibility
> +		checks.
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 5b62139714ce..58ee9ac0e467 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -63,6 +63,28 @@ int optee_set_dma_mask(struct optee *optee, u_int pa_width)
>  	return dma_coerce_mask_and_coherent(&optee->teedev->dev, mask);
>  }
>  
> +int optee_get_revision(struct optee *optee, char *buf, size_t len)
> +{
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
> index bf8390789ecf..0a2990c2491e 100644
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
> @@ -806,6 +807,12 @@ static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
>  		pr_err("Unexpected error %d\n", rc);
>  		return false;
>  	}
> +	if (revision) {
> +		revision->os_major = data.data0;
> +		revision->os_minor = data.data1;
> +		revision->os_build_id = data.data2;
> +	}
> +
>  	if (data.data2)
>  		pr_info("revision %lu.%lu (%08lx)",
>  			data.data0, data.data1, data.data2);
> @@ -898,8 +905,12 @@ static int optee_ffa_open(struct tee_context *ctx)
>  	return optee_open(ctx, true);
>  }
>  
> +static int optee_ffa_get_tee_revision(struct tee_device *teedev,
> +				      char *buf, size_t len);

I don't think you need a wrapper here but insted you can just use the
generic optee_get_revision() callback.

> +
>  static const struct tee_driver_ops optee_ffa_clnt_ops = {
>  	.get_version = optee_ffa_get_version,
> +	.get_tee_revision = optee_ffa_get_tee_revision,

This will then become:

        .get_tee_revision = optee_get_revision,

>  	.open = optee_ffa_open,
>  	.release = optee_release,
>  	.open_session = optee_open_session,
> @@ -918,6 +929,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
>  
>  static const struct tee_driver_ops optee_ffa_supp_ops = {
>  	.get_version = optee_ffa_get_version,
> +	.get_tee_revision = optee_ffa_get_tee_revision,

ditto.

>  	.open = optee_ffa_open,
>  	.release = optee_release_supp,
>  	.supp_recv = optee_supp_recv,
> @@ -1034,6 +1046,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  {
>  	const struct ffa_notifier_ops *notif_ops;
>  	const struct ffa_ops *ffa_ops;
> +	struct optee_revision revision = { };
>  	unsigned int max_notif_value;
>  	unsigned int rpc_param_count;
>  	struct tee_shm_pool *pool;
> @@ -1047,7 +1060,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	ffa_ops = ffa_dev->ops;
>  	notif_ops = ffa_ops->notifier_ops;
>  
> -	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
> +	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &revision))
>  		return -EINVAL;
>  
>  	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> @@ -1059,6 +1072,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
>  	if (!optee)
>  		return -ENOMEM;
> +	optee->revision = revision;
>  
>  	pool = optee_ffa_shm_pool_alloc_pages();
>  	if (IS_ERR(pool)) {
> @@ -1194,3 +1208,10 @@ void optee_ffa_abi_unregister(void)
>  	if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
>  		ffa_unregister(&optee_ffa_driver);
>  }
> +static int optee_ffa_get_tee_revision(struct tee_device *teedev,
> +				      char *buf, size_t len)
> +{
> +	struct optee *optee = tee_get_drvdata(teedev);
> +
> +	return optee_get_revision(optee, buf, len);
> +}
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index db9ea673fbca..8d65f8b16b4a 100644
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
> +int optee_get_revision(struct optee *optee, char *buf, size_t len);
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
> index 0be663fcd52b..4dc2c16147ee 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1240,8 +1240,12 @@ static int optee_smc_open(struct tee_context *ctx)
>  	return optee_open(ctx, sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL);
>  }
>  
> +static int optee_get_tee_revision(struct tee_device *teedev,
> +				  char *buf, size_t len);
> +
>  static const struct tee_driver_ops optee_clnt_ops = {
>  	.get_version = optee_get_version,
> +	.get_tee_revision = optee_get_tee_revision,
>  	.open = optee_smc_open,
>  	.release = optee_release,
>  	.open_session = optee_open_session,
> @@ -1261,6 +1265,7 @@ static const struct tee_desc optee_clnt_desc = {
>  
>  static const struct tee_driver_ops optee_supp_ops = {
>  	.get_version = optee_get_version,
> +	.get_tee_revision = optee_get_tee_revision,
>  	.open = optee_smc_open,
>  	.release = optee_release_supp,
>  	.supp_recv = optee_supp_recv,
> @@ -1323,7 +1328,8 @@ static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invoke_fn)
>  }
>  #endif
>  
> -static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> +static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
> +				      struct optee_revision *revision)
>  {
>  	union {
>  		struct arm_smccc_res smccc;
> @@ -1337,6 +1343,12 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
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
> @@ -1727,6 +1739,7 @@ static int optee_probe(struct platform_device *pdev)
>  	unsigned int thread_count;
>  	struct tee_device *teedev;
>  	struct tee_context *ctx;
> +	struct optee_revision revision = { };
>  	u32 max_notif_value;
>  	u32 arg_cache_flags;
>  	u32 sec_caps;
> @@ -1745,7 +1758,7 @@ static int optee_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	optee_msg_get_os_revision(invoke_fn);
> +	optee_msg_get_os_revision(invoke_fn, &revision);
>  
>  	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
>  		pr_warn("api revision mismatch\n");
> @@ -1814,6 +1827,7 @@ static int optee_probe(struct platform_device *pdev)
>  		rc = -ENOMEM;
>  		goto err_free_shm_pool;
>  	}
> +	optee->revision = revision;
>  
>  	optee->ops = &optee_ops;
>  	optee->smc.invoke_fn = invoke_fn;
> @@ -1971,3 +1985,10 @@ void optee_smc_abi_unregister(void)
>  {
>  	platform_driver_unregister(&optee_driver);
>  }
> +static int optee_get_tee_revision(struct tee_device *teedev,
> +				  char *buf, size_t len)

Ditto here, you don't need this extra wrapper here.

> +{
> +	struct optee *optee = tee_get_drvdata(teedev);
> +
> +	return optee_get_revision(optee, buf, len);
> +}
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d65d47cc154e..0ba0e16462b9 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -13,6 +13,7 @@
>  #include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/tee_core.h>
> +#include <linux/tee_drv.h>

This include is rather meant for TEE client drivers, don't include it
here. Instead use linux/tee_core.h.

>  #include <linux/uaccess.h>
>  #include <crypto/sha1.h>
>  #include "tee_private.h"
> @@ -1146,7 +1147,56 @@ static struct attribute *tee_dev_attrs[] = {
>  	NULL
>  };
>  
> -ATTRIBUTE_GROUPS(tee_dev);
> +static const struct attribute_group tee_dev_group = {
> +	.attrs = tee_dev_attrs,
> +};
> +
> +static ssize_t revision_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
> +	char version[TEE_REVISION_STR_SIZE];
> +	int ret;
> +
> +	if (!teedev->desc->ops->get_tee_revision)
> +		return -ENODEV;
> +
> +	ret = teedev->desc->ops->get_tee_revision(teedev, version,
> +						  sizeof(version));
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%s\n", version);
> +}
> +static DEVICE_ATTR_RO(revision);
> +
> +static struct attribute *tee_revision_attrs[] = {
> +	&dev_attr_revision.attr,
> +	NULL
> +};
> +
> +static umode_t tee_revision_attr_is_visible(struct kobject *kobj,
> +					    struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
> +
> +	if (teedev->desc->ops->get_tee_revision)
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
> +static const struct attribute_group tee_revision_group = {
> +	.attrs = tee_revision_attrs,
> +	.is_visible = tee_revision_attr_is_visible,
> +};
> +
> +static const struct attribute_group *tee_dev_groups[] = {
> +	&tee_dev_group,
> +	&tee_revision_group,
> +	NULL
> +};
>  
>  static const struct class tee_class = {
>  	.name = "tee",
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index 1f3e5dad6d0d..de11612afa62 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -76,6 +76,9 @@ struct tee_device {
>  /**
>   * struct tee_driver_ops - driver operations vtable
>   * @get_version:	returns version of driver
> + * @get_tee_revision:	returns revision string (diagnostic only);
> + *			do not infer feature support from this, use
> + *			TEE_IOC_VERSION instead
>   * @open:		called for a context when the device file is opened
>   * @close_context:	called when the device file is closed
>   * @release:		called to release the context
> @@ -98,6 +101,8 @@ struct tee_device {
>  struct tee_driver_ops {
>  	void (*get_version)(struct tee_device *teedev,
>  			    struct tee_ioctl_version_data *vers);
> +	int (*get_tee_revision)(struct tee_device *teedev,
> +				char *buf, size_t len);
>  	int (*open)(struct tee_context *ctx);
>  	void (*close_context)(struct tee_context *ctx);
>  	void (*release)(struct tee_context *ctx);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 88a6f9697c89..e76238d435ce 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -322,4 +322,7 @@ struct tee_client_driver {
>  #define to_tee_client_driver(d) \
>  		container_of_const(d, struct tee_client_driver, driver)
>  
> +/* Size for TEE revision string buffer used by get_tee_revision(). */
> +#define TEE_REVISION_STR_SIZE	128

This should rather go to linux/tee_core.h.

-Sumit

> +
>  #endif /*__TEE_DRV_H*/
> -- 
> 2.43.0
> 
