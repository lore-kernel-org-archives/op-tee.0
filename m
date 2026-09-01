Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6F1C61DD3
	for <op-tee@archiver.kernel.org>; Tue,  1 Sep 2026 13:46:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D693345360
	for <op-tee@archiver.kernel.org>; Tue,  1 Sep 2026 13:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788270389;
	bh=Kfs4IGINgfMoEqeRrskcjInH/FLuetnfbTVttMMzGaU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=dMso4rmWoICFchrX4gH5X6WKwlkYly/IK26Bp6gjr31mFhuRt/kUkucBNGxF1EgXG
	 jB09GK78PWhOTJHejMSEze6Kg3HahKMAI+eFkX3xntLwKsuzw69srZKN+50bPUg9AV
	 8modT7r+sxJApo2trbb6eLLq0OPdMxJVsg6bRxlg3KwjCuQCF9a6qKv+62qDJikumU
	 gcf3X+Z1LyvNjQcRB+MjuCMfovb9S1HK0L2WIC+KJU1pAFZFW/soQDBOGaJmV7MEB7
	 2qDVnl/JzKUB26IPmD8uNGN3whfYvVeogHCWFLfh+xRHbSWFWJUP70m0g56BGLqj94
	 t++iZjdS5e1Ag==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id 9ACF643814
	for <op-tee@lists.trustedfirmware.org>; Tue,  1 Sep 2026 13:46:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiueAZgL;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id DCD9D403BB;
	Tue,  1 Sep 2026 13:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 328C91F000E9;
	Tue,  1 Sep 2026 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788270381;
	bh=YNqzvMfecN/wUhv7JKOMy+7NSH0F2db1v55mL1/kjQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jiueAZgLw8JY7Et8PDBQux6uFIA6fErBJzTnnkVIdot6J2fDLYX8gUgt7oCb55p7k
	 htCXaV3Phk/tGc1YQjhbeESV8D6bhYAV+QtJmBUg6w7zFuY5OQwuG4cEwDRM546l2v
	 DLJVJBpUk6Hw98cbC95r35EriA/mipiw2xBYCziI5g5dLvc4qGAQ8ebmT1jOB5Tf3B
	 K25Mbg+jazzTrhw+AJvyawbkJc+AO65MmSSYJFVCGfoQ2TsZcxYZS2nhGiBV7uDDEW
	 N1WXHsi4K67dQcDSfPGS6U/Oq+IYKTlhzo7iq2mPcE/R5+bumDKsyEPp+kwLT9lc8C
	 iqUjfxGZAcM+w==
Date: Tue, 1 Sep 2026 16:46:17 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
Message-ID: <apbXKZrjFdK1vrny@kernel.org>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
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
X-Rspamd-Queue-Id: 9ACF643814
X-Spamd-Bar: ---------
Message-ID-Hash: XPP4NY4P6XPLOPA4TG5LCSLOWU7Z7FUP
X-Message-ID-Hash: XPP4NY4P6XPLOPA4TG5LCSLOWU7Z7FUP
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XPP4NY4P6XPLOPA4TG5LCSLOWU7Z7FUP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

Short summary has a different driver name that is implemented i.e.,
it should has "tpm_qcom", not "tpm-qcom".

On Mon, Aug 31, 2026 at 03:13:01PM +0530, Kuldeep Singh wrote:
> Add a TPM chip driver for platforms where a TPM 2.0 instance is
> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
> transport.
> 
> The driver discovers the qcom.tz.tpm TEE-bus device, opens a session
> with the TPM TA, and register with tpm interface. This exposes the TA
> through the standard /dev/tpm interface and the existing tpm2 command
> layer. OS need not be aware underlying TPM instance is dTPM or fTPM.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  MAINTAINERS                 |   7 +
>  drivers/char/tpm/Kconfig    |   9 ++
>  drivers/char/tpm/Makefile   |   1 +
>  drivers/char/tpm/tpm_qcom.c | 371 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_qcom.h |  82 ++++++++++

Rename it as tpm_qcom_tee just to be aligned on how Microsoft's fTPM
driver is named.

>  5 files changed, 470 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47b04968e79a..cfa5b66823c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22636,6 +22636,13 @@ S:	Maintained
>  F:	Documentation/tee/qtee.rst
>  F:	drivers/tee/qcomtee/
>  
> +QUALCOMM TPM DRIVER
> +M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/char/tpm/tpm_qcom.c
> +F:	drivers/char/tpm/tpm_qcom.h
> +
>  QUALCOMM TRUST ZONE MEMORY ALLOCATOR
>  M:	Bartosz Golaszewski <brgl@kernel.org>
>  L:	linux-arm-msm@vger.kernel.org

this change should be a separate patch.

> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 5f672f2c01b0..05d704ed3632 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -243,6 +243,15 @@ config TCG_FTPM_TEE
>  	help
>  	  This driver proxies for firmware TPM running in TEE.
>  
> +config TCG_QCOM
> +	tristate "Qualcomm TEE based TPM Interface"
> +	depends on QCOMTEE
> +	help
> +	  This driver provides interface to run TPM instances with Trustzone
> +	  having Qualcomm TPM TA running in Qualcomm TEE.
> +	  The mechanism uses the object-IPC based transport provided by
> +	  QCOMTEE.
> +
>  config TCG_SVSM
>  	tristate "SNP SVSM vTPM interface"
>  	depends on AMD_MEM_ENCRYPT
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 5b5cdc0d32e4..471cbf49afd2 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -45,5 +45,6 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_QCOM) += tpm_qcom.o
>  obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>  obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> diff --git a/drivers/char/tpm/tpm_qcom.c b/drivers/char/tpm/tpm_qcom.c
> new file mode 100644
> index 000000000000..00ee61204056
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_qcom.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/tpm.h>
> +#include <linux/uuid.h>
> +
> +#include "tpm.h"
> +#include "tpm_qcom.h"
> +
> +/* UUID of the QTEE-bus device representing the TPM TA. */
> +static const uuid_t tpm_qcom_uuid =
> +	UUID_INIT(0xaabcb593, 0x7083, 0x5536,
> +		  0xac, 0x27, 0x3d, 0x2d, 0x89, 0x41, 0x9d, 0xdb);
> +
> +static void tpm_qcom_release_object(struct tee_context *ctx,
> +				    struct tee_param_objref object)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	inv_arg.id = object.id;
> +	inv_arg.op = QCOMTEE_MSG_OBJECT_OP_RELEASE;
> +	inv_arg.num_params = 0;
> +
> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
> +}
> +
> +static int tpm_qcom_get_client_env_obj(struct tee_context *ctx,
> +				       struct tee_param_objref *client_env_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	struct tee_param param[2];
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	inv_arg.id = TEE_OBJREF_NULL;
> +	inv_arg.op = QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS;
> +	inv_arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT;
> +	param[0].u.objref.id = TEE_OBJREF_NULL;
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0)
> +		return ret ?: inv_arg.ret;
> +
> +	*client_env_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +static int tpm_qcom_get_svc_obj(struct tee_context *ctx,
> +				struct tee_param_objref client_env_obj,
> +				struct tee_param_objref *tpm_svc_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	struct tee_param param[2];
> +	u32 tpm_uid = QCOMTEE_TPM_UID;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	inv_arg.id = client_env_obj.id;
> +	inv_arg.op = QCOMTEE_OP_CLIENT_ENV_OPEN;
> +	inv_arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &tpm_uid,
> +						    .size = sizeof(tpm_uid) };
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0)
> +		return ret ?: inv_arg.ret;
> +
> +	*tpm_svc_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +static int tpm_qcom_send_command(struct tpm_qcom_private *pvt_data,
> +				 void *req, size_t req_len,
> +				 void *rsp, size_t *rsp_len)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	struct tee_param param[2];
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	inv_arg.id = pvt_data->tpm_svc_obj.id;
> +	inv_arg.op = QCOMTEE_TPM_OP_SEND_COMMAND;
> +	inv_arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = req, .size = req_len };
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT;
> +	param[1].u.ubuf = (struct tee_param_ubuf){ .addr = rsp, .size = *rsp_len };
> +
> +	print_hex_dump_debug("tpm_qcom req: ", DUMP_PREFIX_OFFSET,
> +			     16, 1, req, req_len, true);

Please don't do this. It can put production systems at risk.

> +
> +	ret = tee_client_object_invoke_func(pvt_data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(pvt_data->dev,
> +			"send_command invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*rsp_len = param[1].u.ubuf.size;
> +
> +	print_hex_dump_debug("tpm_qcom rsp: ", DUMP_PREFIX_OFFSET,
> +			     16, 1, rsp, *rsp_len, true);
> +
> +	return ret;
> +}
> +
> +static int tpm_qcom_get_ta_details(struct tpm_qcom_private *pvt_data)
> +{
> +	struct tpm_qcom_ta_version_req ver_req = {
> +		.command_id = QCOMTEE_TPM_GET_TA_VERSION_ID,
> +	};
> +	struct tpm_qcom_ta_version_rsp ver_rsp;
> +	size_t ver_rsp_len = sizeof(ver_rsp);
> +	struct tpm_qcom_type_req type_req = {
> +		.command_id = QCOMTEE_TPM_TYPE_ID,
> +	};
> +	struct tpm_qcom_type_rsp type_rsp;
> +	size_t type_rsp_len = sizeof(type_rsp);
> +	int ret;
> +
> +	ret = tpm_qcom_send_command(pvt_data, &ver_req, sizeof(ver_req),
> +				    &ver_rsp, &ver_rsp_len);
> +	if (ret || ver_rsp_len < sizeof(ver_rsp) || ver_rsp.status != 0) {
> +		dev_err(pvt_data->dev,
> +			"failed to query TA version: ret=%d, status=%u\n",
> +			ret, ret ? 0 : ver_rsp.status);
> +		return ret ?: -EIO;
> +	}
> +
> +	dev_info(pvt_data->dev, "TPM TA version %u.%u\n",
> +		 QCOMTEE_TPM_TA_VERSION_GET_MAJOR(ver_rsp.version_num),
> +		 QCOMTEE_TPM_TA_VERSION_GET_MINOR(ver_rsp.version_num));
> +
> +	ret = tpm_qcom_send_command(pvt_data, &type_req, sizeof(type_req),
> +				    &type_rsp, &type_rsp_len);
> +	if (ret || type_rsp_len < sizeof(type_rsp) || type_rsp.status != 0) {
> +		dev_err(pvt_data->dev,
> +			"failed to query TPM type: ret=%d, status=%u\n",
> +			ret, ret ? 0 : type_rsp.status);
> +		return ret ?: -EIO;
> +	}
> +
> +	switch (type_rsp.tpm_type) {
> +	case QCOMTEE_TPM_TYPE_FTPM:
> +		dev_info(pvt_data->dev, "TPM type: fTPM\n");
> +		pvt_data->is_dtpm = false;
> +		break;
> +	case QCOMTEE_TPM_TYPE_DTPM:
> +		dev_info(pvt_data->dev, "TPM type: dTPM\n");
> +		pvt_data->is_dtpm = true;
> +		break;
> +	default:
> +		dev_err(pvt_data->dev, "unsupported TPM type: 0x%08x\n",
> +			type_rsp.tpm_type);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * fTPM does not implement this command, so this is only ever called in case of
> + * dtpm only.
> + */
> +static void tpm_qcom_transfer(struct tpm_qcom_private *pvt_data,
> +			      u32 transfer_state)
> +{
> +	struct tpm_qcom_transfer_req req = {
> +		.command_id = QCOMTEE_TPM_TRANSFER_ID,
> +		.transfer_state = transfer_state,
> +	};
> +	struct tpm_qcom_transfer_rsp rsp;
> +	size_t rsp_len = sizeof(rsp);
> +	int ret;
> +
> +	ret = tpm_qcom_send_command(pvt_data, &req, sizeof(req), &rsp, &rsp_len);
> +	if (ret || rsp_len < sizeof(rsp) || rsp.status != 0)
> +		dev_warn(pvt_data->dev,
> +			 "transfer state=%u hint failed: ret=%d, status=%u\n",
> +			 transfer_state, ret, ret ? 0 : rsp.status);
> +}
> +
> +static int tpm_qcom_cmd_ready(struct tpm_chip *chip)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +
> +	if (pvt_data->is_dtpm)
> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_START);
> +
> +	return 0;
> +}
> +
> +static int tpm_qcom_go_idle(struct tpm_chip *chip)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +
> +	if (pvt_data->is_dtpm)
> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_END);
> +
> +	return 0;
> +}
> +
> +/*
> + * The raw TPM2 command in @buf is sent directly as send_command's UBUF-in
> + * param and the raw TPM2 response is read back from its UBUF-out param.
> + */
> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> +			 size_t cmd_len)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +	size_t rsp_len = PAGE_ALIGN(MAX_RESPONSE_SIZE);
> +	size_t copy_len;
> +	int ret;
> +
> +	if (cmd_len > MAX_COMMAND_SIZE) {
> +		dev_err(&chip->dev,
> +			"%s: len=%zd exceeds MAX_COMMAND_SIZE\n",
> +			__func__, cmd_len);
> +		return -EIO;
> +	}
> +
> +	u8 *response __free(kfree) = kzalloc(rsp_len, GFP_KERNEL);
> +	if (!response)
> +		return -ENOMEM;
> +
> +	ret = tpm_qcom_send_command(pvt_data, buf, cmd_len, response, &rsp_len);
> +	if (ret < 0) {
> +		dev_err(&chip->dev, "%s: failed: ret=%d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	copy_len = min_t(size_t, bufsiz, rsp_len);
> +	memcpy(buf, response, copy_len);
> +
> +	return copy_len;
> +}
> +
> +static const struct tpm_class_ops tpm_qcom_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.send = tpm_qcom_send,
> +	.cmd_ready = tpm_qcom_cmd_ready,
> +	.go_idle = tpm_qcom_go_idle,
> +};
> +
> +static int tpm_qcom_ctx_match(struct tee_ioctl_version_data *ver,
> +			      const void *data)
> +{
> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
> +}
> +
> +static int tpm_qcom_probe(struct tee_client_device *tee_dev)
> +{
> +	struct device *dev = &tee_dev->dev;
> +	struct tpm_qcom_private *pvt_data;
> +	struct tee_param_objref client_env_obj;
> +	struct tee_param_objref tpm_svc_obj;
> +	struct tpm_chip *chip;
> +	int rc, err;
> +
> +	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
> +	if (!pvt_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, pvt_data);
> +
> +	pvt_data->ctx = tee_client_open_context(NULL, tpm_qcom_ctx_match, NULL,
> +						NULL);
> +	if (IS_ERR(pvt_data->ctx))
> +		return -ENODEV;
> +
> +	rc = tpm_qcom_get_client_env_obj(pvt_data->ctx, &client_env_obj);
> +	if (rc) {
> +		err = -EINVAL;
> +		goto out_ctx;
> +	}
> +
> +	rc = tpm_qcom_get_svc_obj(pvt_data->ctx, client_env_obj, &tpm_svc_obj);
> +	if (rc) {
> +		err = -EINVAL;
> +		goto out_client_env;
> +	}
> +	pvt_data->tpm_svc_obj = tpm_svc_obj;
> +	pvt_data->dev = dev;
> +
> +	err = tpm_qcom_get_ta_details(pvt_data);
> +	if (err)
> +		goto out_svc_obj;
> +
> +	chip = tpm_chip_alloc(dev, &tpm_qcom_ops);
> +	if (IS_ERR(chip)) {
> +		dev_err(dev, "%s: tpm_chip_alloc failed\n", __func__);
> +		err = PTR_ERR(chip);
> +		goto out_svc_obj;
> +	}
> +
> +	pvt_data->chip = chip;
> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
> +
> +	err = tpm_chip_register(pvt_data->chip);
> +	if (err) {
> +		dev_err(dev, "%s: tpm_chip_register failed with rc=%d\n",
> +			__func__, err);
> +		goto out_chip;
> +	}
> +
> +	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
> +	return 0;
> +
> +out_chip:
> +	put_device(&pvt_data->chip->dev);
> +out_svc_obj:
> +	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
> +out_client_env:
> +	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
> +out_ctx:
> +	tee_client_close_context(pvt_data->ctx);
> +	return err;
> +}
> +
> +static void tpm_qcom_remove(struct tee_client_device *tee_dev)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(&tee_dev->dev);
> +
> +	tpm_chip_unregister(pvt_data->chip);
> +	put_device(&pvt_data->chip->dev);
> +	tpm_qcom_release_object(pvt_data->ctx, pvt_data->tpm_svc_obj);
> +	tee_client_close_context(pvt_data->ctx);
> +}
> +
> +static const struct tee_client_device_id tpm_qcom_id_table[] = {
> +	{ tpm_qcom_uuid },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, tpm_qcom_id_table);
> +
> +static struct tee_client_driver tpm_qcom_driver = {
> +	.id_table	= tpm_qcom_id_table,
> +	.probe		= tpm_qcom_probe,
> +	.remove		= tpm_qcom_remove,
> +	.driver		= {
> +		.name	= "tpm-qcom",
> +	},
> +};
> +
> +module_tee_client_driver(tpm_qcom_driver);
> +
> +MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
> +MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_qcom.h b/drivers/char/tpm/tpm_qcom.h
> new file mode 100644
> index 000000000000..0f3756944768
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_qcom.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __TPM_QCOM_H__
> +#define __TPM_QCOM_H__
> +
> +#include <linux/bitfield.h>
> +#include <linux/tee_drv.h>
> +#include <linux/tpm.h>
> +#include <linux/uuid.h>
> +
> +#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS	5
> +#define QCOMTEE_OP_CLIENT_ENV_OPEN		0
> +#define QCOMTEE_MSG_OBJECT_OP_MASK		GENMASK(15, 0)
> +#define QCOMTEE_MSG_OBJECT_OP_RELEASE		(QCOMTEE_MSG_OBJECT_OP_MASK - 0)
> +
> +#define QCOMTEE_TPM_OP_SEND_COMMAND		0
> +
> +/* UID of the "qcom.tz.tpm" service */
> +#define QCOMTEE_TPM_UID			489
> +
> +/* Max buffer size supported by TPM TA */
> +#define MAX_COMMAND_SIZE	SZ_4K
> +#define MAX_RESPONSE_SIZE	SZ_4K
> +
> +#define QCOMTEE_TPM_GET_TA_VERSION_ID		0x0001000
> +#define QCOMTEE_TPM_TA_VERSION_GET_MAJOR(ver)	((u32)(ver) >> 16)
> +#define QCOMTEE_TPM_TA_VERSION_GET_MINOR(ver)	((u32)(ver) & 0x0000ffffU)
> +
> +struct tpm_qcom_ta_version_req {
> +	u32 command_id;
> +} __packed;
> +
> +struct tpm_qcom_ta_version_rsp {
> +	u32 status;
> +	u32 command_id;
> +	u32 version_num;
> +} __packed;
> +
> +#define QCOMTEE_TPM_TYPE_ID		0x0080000
> +#define QCOMTEE_TPM_TYPE_DTPM		0x6454504dU
> +#define QCOMTEE_TPM_TYPE_FTPM		0x6654504dU
> +#define QCOMTEE_TPM_TYPE_NONE		0x4e6f6e65U
> +
> +struct tpm_qcom_type_req {
> +	u32 command_id;
> +} __packed;
> +
> +struct tpm_qcom_type_rsp {
> +	u32 command_id;
> +	u32 status;
> +	u32 tpm_type;
> +} __packed;
> +
> +/* dTPM SPI transfer optimization:

Block comments AFAIK should be

/*
 * <TEXT>

> + * TRANSFER_START before a burst of commands, TRANSFER_END once done.
> + */
> +#define QCOMTEE_TPM_TRANSFER_ID		0x0000002
> +#define QCOMTEE_TPM_TRANSFER_END	0
> +#define QCOMTEE_TPM_TRANSFER_START	1
> +
> +struct tpm_qcom_transfer_req {
> +	u32 command_id;
> +	u32 transfer_state;
> +} __packed;
> +
> +struct tpm_qcom_transfer_rsp {
> +	u32 command_id;
> +	u32 status;
> +} __packed;
> +
> +struct tpm_qcom_private {
> +	struct tpm_chip *chip;
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	struct tee_param_objref tpm_svc_obj;
> +	bool is_dtpm;
> +};
> +
> +#endif /* __TPM_QCOM_H__ */
> 
> -- 
> 2.34.1
> 

BR, Jarkko
