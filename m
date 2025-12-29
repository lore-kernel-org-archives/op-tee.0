Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3ABD3B7E5
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 05:51:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 93D814184A
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 05:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1766987478;
	bh=ykKeUDnYZrJxDEhkAICgRFnl1W7qGguuej+4QjavPfU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zeNATndYMK44vUrC3VnuSTwR5MvVz0LPstEBlhORaM2bDoQQDjVd77jJ2hHjWbfZv
	 j9KX5PF60NSbhwTNA5AvSoYRowxH2pmISqOVT+DjOuWL28pSTJL3ePS1fU7EyI9yNv
	 fppsqGvsW45aKJ8ZzBZSo2lIvd/A5PGpXlheGcbj1IuyP9ZPA37lshpVZ7E+xcW5Qm
	 xGSXWswMHQgtuaQ6qqk0mnVZGQPCzfmDimlQBx/Y2zbHWMUY6THY1nz2BM5WJWmy7L
	 5MGByymp5OjriLVxrHxzSwNZ1zDqO7GL7marnBlv3RaM10zI015guQBe/XWEXGR4N7
	 yQnwNQ6+N5XVg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C6FEA4184A
	for <op-tee@lists.trustedfirmware.org>; Mon, 29 Dec 2025 05:50:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BepUoBKG;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1282E6000A;
	Mon, 29 Dec 2025 05:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DCFC4CEF7;
	Mon, 29 Dec 2025 05:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766987457;
	bh=ykKeUDnYZrJxDEhkAICgRFnl1W7qGguuej+4QjavPfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BepUoBKGJDnfvcSU0lLP56MnFRmu1Ny47cfaKfEYBjKoMqO0WQzW6aXhiaoeLpk0M
	 VIYNpotiwVY1L5NK2sOP0WZgf2kBqOCNxMugUGs2UmTUHWnTpYe6kU99BlXnZZ9QeR
	 EdiZ2rn5qnryktg5GIjAZ7Qz4BQvDFZsNBuK1K9NnQtO5QXQX0gTH77J9FXoVfOf7G
	 KRTcHrqTrZyvq31oeekpTzyKoLyyMYH3mYCyh1ilFgIFfVPhdZJaKLJOonzRwZQIBu
	 C0ecFSPslViLlXKzJeIL/EppINa5s8sWM+oNWgsnp7xExDUNGEeD22OL9GLdVJuzrH
	 zKc1y4tyaWWiQ==
Date: Mon, 29 Dec 2025 11:20:47 +0530
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v20 5/6] remoteproc: Add TEE support
Message-ID: <aVIWt5bWP9R9j7nx@sumit-xelite>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-6-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217153917.3998544-6-arnaud.pouliquen@foss.st.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C6FEA4184A
X-Spamd-Bar: --
Message-ID-Hash: N3CPRRD4I5K56PJDD6H2VCHJLEM5Y4SF
X-Message-ID-Hash: N3CPRRD4I5K56PJDD6H2VCHJLEM5Y4SF
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/N3CPRRD4I5K56PJDD6H2VCHJLEM5Y4SF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Dec 17, 2025 at 04:39:16PM +0100, Arnaud Pouliquen wrote:
> Add a remoteproc TEE (Trusted Execution Environment) driver that will be
> probed by the TEE bus. If the associated Trusted application is supported
> on the secure part, this driver offers a client interface to load firmware
> by the secure part.
> This firmware could be authenticated by the secure trusted application.
> 
> A specificity of the implementation is that the firmware has to be
> authenticated and optionally decrypted to access the resource table.
> 
> Consequently, the boot sequence is:
> 
> 1) rproc_parse_fw --> rproc_tee_parse_fw
>    remoteproc TEE:
>    - Requests the TEE application to authenticate and load the firmware
>      in the remote processor memories.
>    - Requests the TEE application for the address of the resource table.
>    - Creates a copy of the resource table stored in rproc->cached_table.
> 
> 2) rproc_load_segments --> rproc_tee_load_fw
>    remoteproc TEE:
>    - Requests the TEE application to load the firmware. Nothing is done
>      at the TEE application as the firmware is already loaded.
>    - In case of recovery, the TEE application has to reload the firmware.
> 
> 3) rproc_tee_get_loaded_rsc_table
>    remoteproc TEE requests the TEE application for the address of the
>    resource table.
> 
> 4) rproc_start --> rproc_tee_start
>    - Requests the TEE application to start the remote processor.
> 
> The shutdown sequence is:
> 
> 5) rproc_stop --> rproc_tee_stop
>    - Requests the TEE application to stop the remote processor.
> 
> 6) rproc_tee_release_fw
>    This function is used to request the TEE application to perform actions
>    to return to the initial state on stop or on error during the boot
>    sequence.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Version 20 updates:
> - rework probe. the remoteproc-tee now probe the remoteproc devices
>   defined in device tree as child.
>   - creation of rproc-service-80a4c275-0a47-4905-8285-1486a9771a08 compatible
>   - use of of_find_compatible_node() to find node in DT
>   - use of of_platform_populate() to probe remoteproc devices
> - remove device_link_add() as now managed by of_platform_populate)
> - add "auto_boot" parameter in rproc_tee_register()
> - rename TA_RPROC_FW_CMD_* TEE CMD in  TA_RPROC_CMD_* command
> - use of DEFINE_MUTEX
> 
> Version 19 updates:
> - rework/fix function headers
> - use memremap instead of ioremap for the resource table.
> - realign comments to 80 chars limit, with few exceptions for readability
> - replace spinlock by mutex and and protect APIs from concurrent access
> - add support of 64-bit address in rproc_tee_get_loaded_rsc_table()
> - update copyright year
> 
> Version 18 updates:
> Fix warning:
> warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> ---
>  drivers/remoteproc/Kconfig          |  10 +
>  drivers/remoteproc/Makefile         |   1 +
>  drivers/remoteproc/remoteproc_tee.c | 771 ++++++++++++++++++++++++++++
>  include/linux/remoteproc_tee.h      |  89 ++++
>  4 files changed, 871 insertions(+)
>  create mode 100644 drivers/remoteproc/remoteproc_tee.c
>  create mode 100644 include/linux/remoteproc_tee.h
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 48a0d3a69ed0..75265f3f5008 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -23,6 +23,16 @@ config REMOTEPROC_CDEV
>  
>  	  It's safe to say N if you don't want to use this interface.
>  
> +config REMOTEPROC_TEE
> +	bool "Remoteproc support by a TEE application"
> +	depends on OPTEE
> +	help
> +	  Support a remote processor that is managed by an application running in a Trusted
> +	  Execution Environment (TEE). This application is responsible for loading the remote
> +	  processor firmware image and managing its lifecycle.
> +
> +	  It's safe to say N if the remote processor is not managed by a TEE.
> +
>  config IMX_REMOTEPROC
>  	tristate "i.MX remoteproc support"
>  	depends on ARCH_MXC
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 1c7598b8475d..a1a5201982d4 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -11,6 +11,7 @@ remoteproc-y				+= remoteproc_sysfs.o
>  remoteproc-y				+= remoteproc_virtio.o
>  remoteproc-y				+= remoteproc_elf_loader.o
>  obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
> +obj-$(CONFIG_REMOTEPROC_TEE)		+= remoteproc_tee.o
>  obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>  obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
>  obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
> diff --git a/drivers/remoteproc/remoteproc_tee.c b/drivers/remoteproc/remoteproc_tee.c
> new file mode 100644
> index 000000000000..081420c35c88
> --- /dev/null
> +++ b/drivers/remoteproc/remoteproc_tee.c
> @@ -0,0 +1,771 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) STMicroelectronics 2025
> + * Author: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> + */
> +
> +#include <linux/firmware.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/mutex.h>
> +#include <linux/remoteproc.h>
> +#include <linux/remoteproc_tee.h>
> +#include <linux/slab.h>
> +#include <linux/tee_drv.h>
> +
> +#include "remoteproc_internal.h"
> +
> +#define MAX_TEE_PARAM_ARRAY_MEMBER	4
> +
> +/*
> + * Authentication and load of the firmware image in the remote processor
> + * memories by the TEE. After this step the firmware is installed in destination
> + * memories, which can then be locked to prevent access by Linux.
> + *
> + * [in]  params[0].value.a: remote processor identifier
> + * [in]  params[1].memref:  buffer containing a temporary copy of the signed
> + *			    image to load.
> + */
> +#define TA_RPROC_CMD_LOAD_FW		1
> +
> +/*
> + * Start the remote processor by the TEE
> + *
> + * [in]  params[0].value.a: remote processor identifier
> + */
> +#define TA_RPROC_CMD_START		2
> +
> +/*
> + * Stop the remote processor by the TEE
> + *
> + * [in]  params[0].value.a: remote processor identifier
> + */
> +#define TA_RPROC_CMD_STOP		3
> +
> +/*
> + * Return the address of the resource table, or 0 if not found.
> + *
> + * [in]  params[0].value.a: remote processor identifier
> + * [out] params[1].value.a: 32bit LSB resource table memory address
> + * [out] params[1].value.b: 32bit MSB resource table memory address
> + * [out] params[2].value.a: 32bit LSB resource table memory size
> + * [out] params[2].value.b: 32bit MSB resource table memory size
> + */
> +#define TA_RPROC_CMD_GET_RSC_TABLE	4
> +
> +/*
> + * Release remote processor firmware images and associated resources.
> + * This command should be used in case an error occurs between the loading of
> + * the firmware images (TA_RPROC_CMD_LOAD_FW) and the starting of the remote
> + * processor (TA_RPROC_CMD_START) or after stopping the remote processor
> + * to release associated resources (TA_RPROC_CMD_STOP).
> + *
> + * [in]  params[0].value.a: remote processor identifier
> + */
> +#define TA_RPROC_CMD_RELEASE_FW		6
> +
> +struct rproc_tee_context {
> +	struct list_head	rproc_list;
> +	struct tee_context	*tee_ctx;
> +	struct device		*dev;
> +};
> +
> +/**
> + * struct rproc_tee - TEE remoteproc structure
> + * @node:       Reference in list
> + * @rproc:      Remoteproc reference
> + * @rproc_id:   remote processor identifier
> + * @session_id: TEE session identifier
> + */
> +struct rproc_tee {
> +	struct list_head node;
> +	struct rproc *rproc;
> +	u32 rproc_id;
> +	u32 session_id;
> +};
> +
> +static struct rproc_tee_context rproc_tee_ctx;
> +static DEFINE_MUTEX(ctx_lock); /* Protects concurrent manipulations of the rproc_tee_ctx*/
> +
> +static struct rproc_tee *rproc_to_trproc(struct rproc *rproc)
> +{
> +	struct rproc_tee *trproc;
> +
> +	list_for_each_entry(trproc, &rproc_tee_ctx.rproc_list, node)
> +		if (trproc->rproc == rproc)
> +			return trproc;
> +	return NULL;
> +}
> +
> +static void rproc_tee_prepare_args(struct rproc_tee *trproc, int cmd,
> +				   struct tee_ioctl_invoke_arg *arg,
> +				   struct tee_param *param,
> +				   unsigned int num_params)
> +{
> +	memset(arg, 0, sizeof(*arg));
> +	memset(param, 0, MAX_TEE_PARAM_ARRAY_MEMBER * sizeof(*param));
> +
> +	arg->func = cmd;
> +	arg->session = trproc->session_id;
> +	arg->num_params = num_params + 1;
> +
> +	param[0] = (struct tee_param) {
> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +		.u.value.a = trproc->rproc_id,
> +	};
> +}
> +
> +/**
> + * rproc_tee_release_fw() - Release the firmware for a TEE-based remote processor
> + * @rproc: Pointer to the struct rproc representing the remote processor
> + *
> + * This function invokes the TA_RPROC_CMD_RELEASE_FW TEE client function to
> + * release the firmware. It should only be called when the remoteproc state is
> + * RPROC_OFFLINE or RPROC_DETACHED. The function requests the TEE remoteproc
> + * application to release the firmware loaded by rproc_tee_load_fw().
> + * The request is ignored if the rproc state is RPROC_DETACHED as the remote
> + * processor is still running.
> + */
> +void rproc_tee_release_fw(struct rproc *rproc)
> +{
> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
> +	struct rproc_tee *trproc;
> +	struct tee_ioctl_invoke_arg arg;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ctx_lock);
> +	if (ret)
> +		return;
> +
> +	if (!rproc_tee_ctx.dev)
> +		goto out;
> +
> +	trproc = rproc_to_trproc(rproc);
> +	if (!trproc)
> +		goto out;
> +
> +	/*
> +	 * If the remote processor state is RPROC_DETACHED, just ignore the
> +	 * request, as the remote processor is still running.
> +	 */
> +	if (rproc->state == RPROC_DETACHED)
> +		goto out;
> +
> +	if (rproc->state != RPROC_OFFLINE) {
> +		dev_err(rproc_tee_ctx.dev, "unexpected rproc state: %d\n", rproc->state);
> +		goto out;
> +	}
> +
> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_RELEASE_FW, &arg, param, 0);
> +
> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
> +	if (ret < 0 || arg.ret != 0) {
> +		dev_err(rproc_tee_ctx.dev,
> +			"TA_RPROC_CMD_RELEASE_FW invoke failed TEE err: %#x, ret:%d\n",
> +			arg.ret, ret);
> +	}
> +
> +out:
> +	mutex_unlock(&ctx_lock);
> +}
> +EXPORT_SYMBOL_GPL(rproc_tee_release_fw);
> +
> +/**
> + * rproc_tee_load_fw() - Load firmware from TEE application
> + * @rproc: Pointer to the struct rproc representing the remote processor
> + * @fw: Pointer to the firmware structure containing the firmware data and size
> + *
> + * This function invokes the TA_RPROC_CMD_LOAD_FW TEE client function to load
> + * the firmware. It registers the fw->data as a shared memory region with the
> + * TEE, and request the TEE to load the firmware. This function can be called
> + * twice during the remote processor boot, a first by rproc_tee_parse_fw() to
> + * parse the resource table , and a second time by rproc_tee_load_fw().
> + * The TEE application should ignores the command if the firmware
> + * is already loaded by rproc_tee_parse_fw().
> + *
> + * Return: 0 on success, or an error code on failure
> + */
> +int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
> +	struct rproc_tee *trproc;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_shm *fw_shm;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ctx_lock);
> +	if (ret)
> +		return ret;
> +
> +	if (!rproc_tee_ctx.dev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	trproc = rproc_to_trproc(rproc);
> +	if (!trproc) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	fw_shm = tee_shm_register_kernel_buf(rproc_tee_ctx.tee_ctx, (void *)fw->data, fw->size);
> +	if (IS_ERR(fw_shm)) {
> +		ret = PTR_ERR(fw_shm);
> +		goto out;
> +	}
> +
> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_LOAD_FW, &arg, param, 1);
> +
> +	/* Provide the address of the firmware image */
> +	param[1] = (struct tee_param) {
> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		.u.memref = {
> +			.shm = fw_shm,
> +			.size = fw->size,
> +			.shm_offs = 0,
> +		},
> +	};
> +
> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
> +	if (ret < 0 || arg.ret != 0) {
> +		dev_err(rproc_tee_ctx.dev,
> +			"TA_RPROC_CMD_LOAD_FW invoke failed TEE err: %#x, ret:%d\n",
> +			arg.ret, ret);
> +		if (!ret)
> +			ret = -EIO;
> +	}
> +
> +	tee_shm_free(fw_shm);
> +
> +out:
> +	mutex_unlock(&ctx_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rproc_tee_load_fw);
> +
> +static int rproc_tee_get_loaded_rsc_table(struct rproc *rproc, phys_addr_t *rsc_pa,
> +					  size_t *table_sz)
> +{
> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
> +	struct rproc_tee *trproc;
> +	struct tee_ioctl_invoke_arg arg;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ctx_lock);
> +	if (ret)
> +		return ret;
> +
> +	if (!rproc_tee_ctx.dev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	trproc = rproc_to_trproc(rproc);
> +	if (!trproc) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_GET_RSC_TABLE, &arg, param, 2);
> +
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> +
> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
> +	if (ret < 0 || arg.ret != 0) {
> +		dev_err(rproc_tee_ctx.dev,
> +			"TA_RPROC_CMD_GET_RSC_TABLE invoke failed TEE err: %#x, ret:%d\n",
> +			arg.ret, ret);
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	*table_sz = param[2].u.value.a;
> +	if (sizeof(phys_addr_t) == sizeof(u64))
> +		*table_sz |= param[2].u.value.b << 32;
> +
> +	if (*table_sz) {
> +		*rsc_pa = param[1].u.value.a;
> +		if (sizeof(phys_addr_t) == sizeof(u64))
> +			*rsc_pa |= param[1].u.value.b << 32;
> +	} else {
> +		*rsc_pa = 0;
> +	}
> +
> +out:
> +	mutex_unlock(&ctx_lock);
> +	return ret;
> +}
> +
> +/**
> + * rproc_tee_parse_fw() - Get the resource table from TEE application
> + * @rproc: Pointer to the struct rproc representing the remote processor
> + * @fw: Pointer to the firmware structure containing the firmware data and size
> + *
> + * This function retrieves the loaded resource table and creates a cached_table
> + * copy. Since the firmware image is signed and potentially encrypted, the
> + * firmware must be loaded first to access the loaded resource table.
> + *
> + * Return: 0 on success, or an error code on failure
> + */
> +int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	phys_addr_t rsc_table;
> +	void *rsc_va;
> +	size_t table_sz;
> +	int ret;
> +
> +	if (!rproc)
> +		return -EINVAL;
> +
> +	/* We need first to Load the firmware, to be able to get the resource table. */
> +	ret = rproc_tee_load_fw(rproc, fw);
> +	if (ret)
> +		return ret;
> +
> +	ret = rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
> +	if (ret)
> +		goto release_fw;
> +
> +	/*
> +	 * We assume here that the memory mapping is the same between the TEE
> +	 * and Linux kernel contexts. Else a new TEE remoteproc service could be
> +	 * needed to get a copy of the resource table.
> +	 */
> +	rsc_va = memremap(rsc_table, table_sz, MEMREMAP_WC);
> +	if (!rsc_va) {
> +		dev_err(rproc_tee_ctx.dev, "Unable to map memory region: %pa+%zx\n",
> +			&rsc_table, table_sz);
> +		ret = -ENOMEM;
> +		goto release_fw;
> +	}
> +
> +	/*
> +	 * Create a copy of the resource table to have the same behavior as the
> +	 * ELF loader. This cached table will be used by the remoteproc core
> +	 * after the remoteproc stops to free resources and for crash recovery
> +	 * to reapply the settings.
> +	 * The cached table will be freed by the remoteproc core.
> +	 */
> +	rproc->cached_table = kmemdup(rsc_va, table_sz, GFP_KERNEL);
> +	memunmap(rsc_va);
> +
> +	if (!rproc->cached_table) {
> +		ret = -ENOMEM;
> +		goto release_fw;
> +	}
> +
> +	rproc->table_ptr = rproc->cached_table;
> +	rproc->table_sz = table_sz;
> +
> +	return 0;
> +
> +release_fw:
> +	rproc_tee_release_fw(rproc);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rproc_tee_parse_fw);
> +
> +/**
> + * rproc_tee_find_loaded_rsc_table() - Find the loaded resource table loaded by
> + *				       the TEE application
> + * @rproc: Pointer to the struct rproc representing the remote processor
> + * @fw: Pointer to the firmware structure containing the firmware data and size
> + *
> + * This function retrieves the physical address and size of the resource table
> + * loaded by the TEE application.
> + *
> + * Return: pointer to the resource table if found, or NULL if not found or size
> + * is 0
> + */
> +struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
> +						       const struct firmware *fw)
> +{
> +	phys_addr_t rsc_table;
> +	size_t table_sz;
> +	int ret;
> +
> +	ret = rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
> +	if (ret)
> +		return NULL;
> +
> +	rproc->table_sz = table_sz;
> +	if (!table_sz)
> +		return NULL;
> +
> +	/*
> +	 * At this step the memory area that contains the resource table should
> +	 * have been registered by the remote proc platform driver and allocated
> +	 * by rproc_alloc_registered_carveouts().
> +	 */
> +	return rproc_pa_to_va(rproc, rsc_table, table_sz, NULL);
> +}
> +EXPORT_SYMBOL_GPL(rproc_tee_find_loaded_rsc_table);
> +
> +/**
> + * rproc_tee_start() - Request the TEE application to start the remote processor
> + * @rproc: Pointer to the struct rproc representing the remote processor
> + *
> + * This function invokes the TA_RPROC_CMD_START command to start the remote
> + * processor.
> + *
> + * Return: Returns 0 on success, -EINVAL or -EIO on failure
> + */
> +int rproc_tee_start(struct rproc *rproc)
> +{
> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
> +	struct rproc_tee *trproc;
> +	struct tee_ioctl_invoke_arg arg;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ctx_lock);
> +	if (ret)
> +		return ret;
> +
> +	if (!rproc_tee_ctx.dev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	trproc = rproc_to_trproc(rproc);
> +	if (!trproc) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_START, &arg, param, 0);
> +
> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
> +	if (ret < 0 || arg.ret != 0) {
> +		dev_err(rproc_tee_ctx.dev,
> +			"TA_RPROC_CMD_START invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
> +		if (!ret)
> +			ret = -EIO;
> +	}
> +
> +out:
> +	mutex_unlock(&ctx_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rproc_tee_start);
> +
> +/**
> + * rproc_tee_stop() - Request the TEE application to start the remote processor
> + * @rproc: Pointer to the struct rproc representing the remote processor
> + *
> + * This function invokes the TA_RPROC_CMD_STOP command to stop the remote
> + * processor.
> + *
> + * Return: Returns 0 on success, -EINVAL or -EIO on failure
> + */
> +int rproc_tee_stop(struct rproc *rproc)
> +{
> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
> +	struct rproc_tee *trproc;
> +	struct tee_ioctl_invoke_arg arg;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ctx_lock);
> +	if (ret)
> +		return ret;
> +
> +	if (!rproc_tee_ctx.dev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	trproc = rproc_to_trproc(rproc);
> +	if (!trproc) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_STOP, &arg, param, 0);
> +
> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
> +	if (ret < 0 || arg.ret != 0) {
> +		dev_err(rproc_tee_ctx.dev,
> +			"TA_RPROC_CMD_STOP invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
> +		if (!ret)
> +			ret = -EIO;
> +	}
> +
> +out:
> +	mutex_unlock(&ctx_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rproc_tee_stop);
> +
> +static const struct rproc_ops rproc_tee_default_ops = {
> +	.start		= rproc_tee_start,
> +	.stop		= rproc_tee_stop,
> +	.load		= rproc_tee_load_fw,
> +	.parse_fw	= rproc_tee_parse_fw,
> +	.find_loaded_rsc_table = rproc_tee_find_loaded_rsc_table,
> +	.release_fw	= rproc_tee_release_fw,
> +};
> +
> +static const struct tee_client_device_id rproc_tee_id_table[] = {
> +	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905, 0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
> +	{ /* sentinel */ }
> +};
> +
> +/**
> + * rproc_tee_register() - Register a remote processor controlled by the TEE application.
> + * @dev: Pointer to client rproc device
> + * @rproc: Pointer to the struct rproc representing the remote processor
> + * @rproc_id: ID of the remote processor
> + * @auto_boot: flag to indicate if remote processor should be auto-started
> + *
> + * This function registers a remote processor that will be managed by a TEE
> + * application, by opening a session with the TEE client.
> + *
> + * Return: Returns 0 on success, or an error code on failure
> + */
> +int rproc_tee_register(struct device *dev, struct rproc **rproc,
> +		       unsigned int rproc_id, bool auto_boot)
> +{
> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	struct device_node *np = dev->of_node;
> +	struct tee_client_device *tee_device;
> +	struct rproc *new_rproc;
> +	struct rproc_tee *trproc;
> +	const char *fw_name;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ctx_lock);
> +	if (ret)
> +		return ret;
> +
> +	if (!rproc_tee_ctx.dev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	trproc = kzalloc(sizeof(*trproc), GFP_KERNEL);
> +	if (!trproc) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Look for an optional firmware name */
> +	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> +	if (ret < 0 && ret != -EINVAL)
> +		goto free_tproc;
> +
> +	new_rproc = rproc_alloc(dev, np->name, &rproc_tee_default_ops,
> +				fw_name, sizeof(*trproc));
> +	if (!new_rproc) {
> +		ret = -ENOMEM;
> +		goto free_tproc;
> +	}
> +
> +	tee_device = to_tee_client_device(rproc_tee_ctx.dev);
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +
> +	memcpy(sess_arg.uuid, tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> +
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> +	sess_arg.num_params = 1;
> +
> +	param[0] = (struct tee_param) {
> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +		.u.value.a = rproc_id,
> +	};
> +
> +	ret = tee_client_open_session(rproc_tee_ctx.tee_ctx, &sess_arg, param);
> +	if (ret < 0 || sess_arg.ret != 0) {
> +		dev_err(dev, "tee_client_open_session failed, err: %#x\n", sess_arg.ret);
> +		ret = -EINVAL;
> +		goto free_rproc;
> +	}
> +
> +	trproc->rproc_id = rproc_id;
> +	trproc->session_id = sess_arg.session;
> +	new_rproc->auto_boot = auto_boot;
> +
> +	ret = rproc_add(new_rproc);
> +	if (ret)
> +		goto close_tee;
> +
> +	trproc->rproc = new_rproc;
> +	*rproc = new_rproc;
> +
> +	list_add_tail(&trproc->node, &rproc_tee_ctx.rproc_list);
> +
> +	mutex_unlock(&ctx_lock);
> +
> +	return 0;
> +
> +close_tee:
> +	if (tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id))
> +		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed\n");
> +free_rproc:
> +	rproc_free(new_rproc);
> +free_tproc:
> +	kfree(trproc);
> +out:
> +	mutex_unlock(&ctx_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rproc_tee_register);
> +
> +/**
> + * rproc_tee_unregister - Unregister a remote processor controlled by the TEE
> + *                        application.
> + * @dev: Pointer to client rproc device
> + * @rproc: Pointer to the struct rproc representing the remote processor
> + *
> + * This function unregisters a remote processor previously registered by the
> + * rproc_tee_register() function.
> + *
> + * Return: Returns 0 on success, or an error code on failure
> + */
> +int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
> +{
> +	struct rproc_tee *trproc;
> +	int ret;
> +
> +	if (!rproc_tee_ctx.dev) {
> +		ret = -ENODEV;
> +		return ret;
> +	}
> +
> +	trproc = rproc_to_trproc(rproc);
> +	if (!trproc) {
> +		ret = -EINVAL;
> +		return ret;
> +	}
> +
> +	rproc_del(rproc);
> +	rproc_free(rproc);
> +
> +	ret = mutex_lock_interruptible(&ctx_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id);
> +	if (ret < 0)
> +		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed, err: %#x\n", ret);
> +	list_del(&trproc->node);
> +	kfree(trproc);
> +	mutex_unlock(&ctx_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rproc_tee_unregister);
> +
> +static int rproc_tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	/* Today we support only the OP-TEE, could be extend to other tees */
> +	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
> +}
> +
> +static const struct of_device_id remoteproc_tee_of_match[] = {
> +	{ .compatible = "rproc-service-80a4c275-0a47-4905-8285-1486a9771a08" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, remoteproc_tee_of_match);

You don't need to define this redundant table but instead...

> +
> +static int rproc_tee_probe(struct device *dev)
> +{
> +	struct tee_context *tee_ctx;
> +	struct device_node *np;
> +	int ret;
> +
> +	pr_err("%s %d", __func__, __LINE__);
> +	np = of_find_compatible_node(NULL, NULL,
> +				     remoteproc_tee_of_match[0].compatible);

...you can get the UUID from device being passed here. With that you
should be able to fetch device specific DT properties.

-Sumit

> +	if (!np) {
> +		dev_err(dev, "Device node not found\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Open context with TEE driver */
> +	tee_ctx = tee_client_open_context(NULL, rproc_tee_ctx_match, NULL, NULL);
> +	if (IS_ERR(tee_ctx)) {
> +		ret = PTR_ERR(tee_ctx);
> +		goto put_node;
> +	}
> +
> +	ret = mutex_lock_interruptible(&ctx_lock);
> +	if (ret)
> +		goto close_ctx;
> +
> +	rproc_tee_ctx.dev = dev;
> +	rproc_tee_ctx.tee_ctx = tee_ctx;
> +	INIT_LIST_HEAD(&rproc_tee_ctx.rproc_list);
> +
> +	mutex_unlock(&ctx_lock);
> +
> +	ret = device_add_of_node(dev, np);
> +	if (ret)
> +		goto clean_ctx;
> +
> +	ret = of_platform_populate(np, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "cannot populate node (%d)\n", ret);
> +		goto clean_ctx;
> +	}
> +
> +	return 0;
> +
> +clean_ctx:
> +	mutex_lock(&ctx_lock);
> +	rproc_tee_ctx.dev = NULL;
> +	rproc_tee_ctx.tee_ctx = NULL;
> +	mutex_unlock(&ctx_lock);
> +
> +close_ctx:
> +	tee_client_close_context(tee_ctx);
> +
> +put_node:
> +	of_node_put(np);
> +	return ret;
> +}
> +
> +static int rproc_tee_remove(struct device *dev)
> +{
> +	of_platform_depopulate(dev);
> +
> +	device_remove_of_node(dev);
> +
> +	mutex_lock(&ctx_lock);
> +	tee_client_close_context(rproc_tee_ctx.tee_ctx);
> +	rproc_tee_ctx.dev = NULL;
> +	rproc_tee_ctx.tee_ctx = NULL;
> +	mutex_unlock(&ctx_lock);
> +
> +	return 0;
> +}
> +
> +MODULE_DEVICE_TABLE(tee, rproc_tee_id_table);
> +
> +static struct tee_client_driver rproc_tee_fw_driver = {
> +	.id_table	= rproc_tee_id_table,
> +	.driver		= {
> +		.name		= KBUILD_MODNAME,
> +		.bus		= &tee_bus_type,
> +		.probe		= rproc_tee_probe,
> +		.remove		= rproc_tee_remove,
> +	},
> +};
> +
> +static int __init rproc_tee_fw_mod_init(void)
> +{
> +	return driver_register(&rproc_tee_fw_driver.driver);
> +}
> +
> +static void __exit rproc_tee_fw_mod_exit(void)
> +{
> +	driver_unregister(&rproc_tee_fw_driver.driver);
> +}
> +
> +module_init(rproc_tee_fw_mod_init);
> +module_exit(rproc_tee_fw_mod_exit);
> +
> +MODULE_DESCRIPTION("remote processor TEE module");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/remoteproc_tee.h b/include/linux/remoteproc_tee.h
> new file mode 100644
> index 000000000000..33150cff7a5a
> --- /dev/null
> +++ b/include/linux/remoteproc_tee.h
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright(c) 2025 STMicroelectronics
> + */
> +
> +#ifndef REMOTEPROC_TEE_H
> +#define REMOTEPROC_TEE_H
> +
> +#include <linux/tee_drv.h>
> +#include <linux/firmware.h>
> +#include <linux/remoteproc.h>
> +
> +#if IS_ENABLED(CONFIG_REMOTEPROC_TEE)
> +
> +int rproc_tee_register(struct device *dev, struct rproc **rproc,
> +		       unsigned int rproc_id, bool auto_boot);
> +int rproc_tee_unregister(struct device *dev, struct rproc *rproc);
> +int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw);
> +int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw);
> +void rproc_tee_release_fw(struct rproc *rproc);
> +struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
> +						       const struct firmware *fw);
> +int rproc_tee_start(struct rproc *rproc);
> +int rproc_tee_stop(struct rproc *rproc);
> +int rproc_tee_pa_to_da(struct rproc *rproc, phys_addr_t pa, size_t size, u64 *da);
> +#else
> +
> +static inline int rproc_tee_register(struct device *dev, struct rproc **rproc,
> +				     unsigned int rproc_id, bool auto_boot)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return 0;
> +}
> +
> +static inline int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return 0;
> +}
> +
> +static inline int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return 0;
> +}
> +
> +static inline int rproc_tee_start(struct rproc *rproc)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return 0;
> +}
> +
> +static inline int rproc_tee_stop(struct rproc *rproc)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return 0;
> +}
> +
> +static inline void rproc_tee_release_fw(struct rproc *rproc)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +}
> +
> +static inline struct resource_table *
> +rproc_tee_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *fw)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return NULL;
> +}
> +#endif /* CONFIG_REMOTEPROC_TEE */
> +#endif /* REMOTEPROC_TEE_H */
> -- 
> 2.43.0
> 
