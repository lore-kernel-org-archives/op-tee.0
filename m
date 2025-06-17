Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C82C71157
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 17:55:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 68F6140960
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 17:55:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector1 header.b=dSlLOiV0;
	dkim-atps=neutral
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0FAE43E957
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Jun 2025 17:55:00 +0000 (UTC)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HFlkeJ000631;
	Tue, 17 Jun 2025 19:54:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	bahKmGl+clBMoS60Jf7w5XzPUlZO9zfV5SEd/J9jsNk=; b=dSlLOiV0edghzHt0
	GT7sb4jToo4JnA//m5MIQsXgYKb1PJgojogO108K95fZfOm6EKlV6vxX6L7h5WcL
	QII2o4qg3msCf7hTel7ERzSUld/4atsq6JesxhCKwNfDKzwMid0MO0Mo0IDRH2a0
	D4cPo21ZbQZc//WAepMxZe5LHiryLxVP/iPGJLwzOch4sC/rMoRLdaAqVpbZzavn
	5TRAdzbBp79SHw3KAMeI/GfyOADdSe3ZJiaVnAu2eUnqJVcH9Mrci5WPFyAu/sPn
	qOF2zNjmhlYKN+jPi96X8YnARx6b6VQAWQbLv1ryjziwXduR2fI7kPheK1yOhcW1
	iYfs/g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 479m1p46b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 19:54:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0E0EB40045;
	Tue, 17 Jun 2025 19:53:37 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E4A2B8B2FD;
	Tue, 17 Jun 2025 19:52:49 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 19:52:49 +0200
Received: from [10.48.86.121] (10.48.86.121) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 19:52:48 +0200
Message-ID: <c04a7bc8-c25c-44ed-a182-343ced81ba43@foss.st.com>
Date: Tue, 17 Jun 2025 19:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/6] remoteproc: Add TEE support
To: Bjorn Andersson <andersson@kernel.org>
References: <20250616075530.4106090-1-arnaud.pouliquen@foss.st.com>
 <20250616075530.4106090-3-arnaud.pouliquen@foss.st.com>
 <4khzl4tak2whgjjedefc2tmcpooe4w4ajxkvpiijohxoljirol@2or5k4jpbb3x>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <4khzl4tak2whgjjedefc2tmcpooe4w4ajxkvpiijohxoljirol@2or5k4jpbb3x>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.121]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0FAE43E957
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	RBL_SENDERSCORE_REPUT_9(-1.00)[91.207.212.93:from];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:91.207.212.93:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector1];
	RCVD_IN_DNSWL_LOW(-0.10)[91.207.212.93:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:52129, ipnet:91.207.212.0/23, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=8263a07c45=arnaud.pouliquen@foss.st.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_XOIP(0.00)[];
	FORGED_SENDER_VERP_SRS(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_DN_SOME(0.00)[]
Message-ID-Hash: FZD7M4W6JZLZLP2YF3K2524YP4S55ZZG
X-Message-ID-Hash: FZD7M4W6JZLZLP2YF3K2524YP4S55ZZG
X-MailFrom: prvs=8263a07c45=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FZD7M4W6JZLZLP2YF3K2524YP4S55ZZG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On 6/17/25 06:34, Bjorn Andersson wrote:
> On Mon, Jun 16, 2025 at 09:55:26AM +0200, Arnaud Pouliquen wrote:
>> Add a remoteproc TEE (Trusted Execution Environment) driver that will be
>> probed by the TEE bus. If the associated Trusted application is supported
>> on the secure part, this driver offers a client interface to load firmware
>> by the secure part.
>> This firmware could be authenticated by the secure trusted application.
>>
>> A specificity of the implementation is that the firmware has to be

[...]

> 
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_release_fw);
>> +
>> +/**
>> + * rproc_tee_load_fw - Load firmware from TEE application
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @fw: Pointer to the firmware structure containing the firmware data and size
>> + *
>> + * This function invokes the TA_RPROC_FW_CMD_LOAD_FW TEE client function to load the firmware.
>> + * It registers the fw->data as a shared memory region with the TEE, and request the TEE to load
>> + * the firmware. This function can be called twice during the remote processor boot, considering
>> + * that the TEE application ignores the command if the firmware is already loaded.
> 
> "can be called twice"? How does this relate to the TEE application
> ignoring the command? How does the client know if the application
> ignored it?

No need that the client is aware. only needed due to the boot sequence
that calls rproc_tee_parse_fw() then the rproc_tee_load_fw()
I will update the comment to make it more explicit.

> 
>> + *
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @fw: Pointer to the firmware structure containing the firmware data and size
> 
> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> says function name should have () suffix. Then arguments (here you have
> them twice). Then the longer description (for rproc_tee_release_fw() you
> have this before arguments).
> 
> Also, please keep it within 80 characters.
> 
>> + *
>> + * Return: 0 on success, or an error code on failure
>> + */
>> +int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct rproc_tee *trproc = rproc_to_trproc(rproc);
>> +	struct tee_ioctl_invoke_arg arg;
>> +	struct tee_shm *fw_shm;
>> +	int ret;
>> +
>> +	if (!rproc_tee_ctx.dev)
>> +		return -ENODEV;
>> +
>> +	if (!trproc)
>> +		return -EINVAL;
>> +
>> +	fw_shm = tee_shm_register_kernel_buf(rproc_tee_ctx.tee_ctx, (void *)fw->data, fw->size);
>> +	if (IS_ERR(fw_shm))
>> +		return PTR_ERR(fw_shm);
>> +
>> +	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_LOAD_FW, &arg, param, 1);
>> +
>> +	/* Provide the address of the firmware image */
>> +	param[1] = (struct tee_param) {
>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
>> +		.u.memref = {
>> +			.shm = fw_shm,
>> +			.size = fw->size,
>> +			.shm_offs = 0,
>> +		},
>> +	};
>> +
>> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret != 0) {
>> +		dev_err(rproc_tee_ctx.dev,
>> +			"TA_RPROC_FW_CMD_LOAD_FW invoke failed TEE err: %#x, ret:%d\n",
>> +			arg.ret, ret);
>> +		if (!ret)
>> +			ret = -EIO;
> 
> If ret == 0 and arg.ret == <some error>, then this function will print
> an error to the log and return success (0). Same with many of the other
> functions where you have copy pasted this.

If ret == 0 and arg.ret == <some error>, we return -EIO, or I missed something?

> 
>> +	}
>> +
>> +	tee_shm_free(fw_shm);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_load_fw);
>> +
>> +static int rproc_tee_get_loaded_rsc_table(struct rproc *rproc, phys_addr_t *rsc_pa,
>> +					  size_t *table_sz)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct rproc_tee *trproc = rproc_to_trproc(rproc);
>> +	struct tee_ioctl_invoke_arg arg;
>> +	int ret;
>> +
>> +	if (!rproc_tee_ctx.dev)
>> +		return -ENODEV;
>> +
>> +	if (!trproc)
>> +		return -EINVAL;
>> +
>> +	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
>> +
>> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
>> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
>> +
>> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret != 0) {
>> +		dev_err(rproc_tee_ctx.dev,
>> +			"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %#x, ret:%d\n",
>> +			arg.ret, ret);
>> +		return -EIO;
>> +	}
>> +
>> +	*table_sz = param[2].u.value.a;
> 
> What happened to .b?

Not really used for now, but I will add extra code to support addresses and size
in 64-bits testing the sizeof phys_addr_t and size_t.

> 
>> +
>> +	if (*table_sz)
>> +		*rsc_pa = param[1].u.value.a;
> 
> Ditto
> 
>> +	else
>> +		*rsc_pa  = 0;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * rproc_tee_parse_fw - Get the resource table from TEE application
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @fw: Pointer to the firmware structure containing the firmware data and size
>> + *
>> + * This function retrieves the loaded resource table and creates a cached_table copy. Since the
>> + * firmware image is signed and potentially encrypted, the firmware must be loaded first to
>> + * access the loaded resource table.
>> + *
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @fw: Pointer to the firmware structure containing the firmware data and size
> 
> Duplicated arguments list...
> 
>> + *
>> + * Return: 0 on success, or an error code on failure
>> + */
>> +int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	phys_addr_t rsc_table;
>> +	void __iomem *rsc_va;
>> +	size_t table_sz;
>> +	int ret;
>> +
>> +	if (!rproc)
>> +		return -EINVAL;
>> +
>> +	/* We need first to Load the firmware, to be able to get the resource table. */
>> +	ret = rproc_tee_load_fw(rproc, fw);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
>> +	if (ret)
>> +		goto release_fw;
>> +
>> +	/*
>> +	 * We assume here that the memory mapping is the same between the TEE and Linux kernel
>> +	 * contexts. Else a new TEE remoteproc service could be needed to get a copy of the
>> +	 * resource table
>> +	 */
>> +	rsc_va = ioremap_wc(rsc_table, table_sz);
> 
> You're using tee_shm for transferring the image, you don't allow Linux
> access to any part of the firmware (which is the reason why you need to
> load the segments in rproc_parse_fw())...

Right, Linux does not understand the format and could not retrieve the resource
table in case of encryption.

> 
> So just out of curiosity, why is the resource table passed back to Linux
> using a ioremap of some random/undefined chunk of memory?

It is not a random chunck of memory but the address of the table installed in
the remote processor memory. It is the equivalent of get_loaded_rsc_table ops.


> 
>> +	if (!rsc_va) {
>> +		dev_err(rproc_tee_ctx.dev, "Unable to map memory region: %pa+%zx\n",
>> +			&rsc_table, table_sz);
>> +		ret = -ENOMEM;
>> +		goto release_fw;
>> +	}
>> +
>> +	/*
>> +	 * Create a copy of the resource table to have the same behavior as the ELF loader.
>> +	 * This cached table will be used by the remoteproc core after the remoteproc stops
>> +	 * to free resources and for crash recovery to reapply the settings.
>> +	 * The cached table will be freed by the remoteproc core.
>> +	 */
>> +	rproc->cached_table = kmemdup((__force void *)rsc_va, table_sz, GFP_KERNEL);
> 
> Is rsc_va DDR? And if so, wouldn't memremap() be a more accurate choice
> above. If not, why isn't this kzalloc() + memcpy_fromio()?

Here we explicitly want to make a local copy as done in rproc_elf_load_rsc_table().
using  kzalloc() + memcpy_fromio() seems a better implementation
I test your proposal, thanks

> 
>> +	iounmap(rsc_va);
>> +
>> +	if (!rproc->cached_table) {
>> +		ret = -ENOMEM;
>> +		goto release_fw;
>> +	}
>> +
>> +	rproc->table_ptr = rproc->cached_table;
>> +	rproc->table_sz = table_sz;
>> +
>> +	return 0;
>> +
>> +release_fw:
>> +	rproc_tee_release_fw(rproc);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_parse_fw);
>> +
>> +/**
>> + * rproc_tee_find_loaded_rsc_table - Find the loaded resource table loaded by the TEE application
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @fw: Pointer to the firmware structure containing the firmware data and size
>> + *
>> + * This function retrieves the physical address and size of the resource table loaded by the TEE
>> + * application.
>> + *
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @fw: Pointer to the firmware structure containing the firmware data and size
> 
> More argument duplication.
> 
>> + *
>> + * Return:  pointer to the resource table if found, or NULL if not found or size is 0
>> + */
>> +struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
>> +						       const struct firmware *fw)
>> +{
>> +	phys_addr_t rsc_table;
>> +	size_t table_sz;
>> +	int ret;
>> +
>> +	ret = rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
>> +	if (ret)
>> +		return NULL;
>> +
>> +	rproc->table_sz = table_sz;
>> +	if (!table_sz)
>> +		return NULL;
>> +
>> +	/*
>> +	 * At this step the memory area that contains the resource table should have been registered
>> +	 * by the remote proc platform driver and allocated by rproc_alloc_registered_carveouts().
>> +	 */
>> +	return (struct resource_table *)rproc_pa_to_va(rproc, rsc_table, table_sz, NULL);
> 
> rproc_pa_to_va() return type is void *, do you really need this explicit
> typecast?
> 
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_find_loaded_rsc_table);
>> +
>> +/**
>> + * rproc_tee_start - Request the TEE application to start the remote processor
>> + *
>> + * This function invokes the TA_RPROC_FW_CMD_START command to start the remote processor.
>> + *
>> + * @rproc: Pointer to the struct rproc representing the remote processor
> 
> kernel-doc ordering...
> 
>> + *
>> + * Return: Returns 0 on success, -EINVAL or -EIO on failure
>> + */
>> +int rproc_tee_start(struct rproc *rproc)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct rproc_tee *trproc = rproc_to_trproc(rproc);
>> +	struct tee_ioctl_invoke_arg arg;
>> +	int ret = 0;
> 
> First access of ret is an assignment, no need to zero-initialize it
> here.
> 
>> +
>> +	if (!trproc)
>> +		return -EINVAL;
> 
> There's an inconsistency in that rproc_tee_ctx.dev is used without first
> checking that it's valid in this function...
> 
>> +
>> +	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_START, &arg, param, 0);
>> +
>> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret != 0) {
>> +		dev_err(rproc_tee_ctx.dev,
>> +			"TA_RPROC_FW_CMD_START invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
>> +		if (!ret)
>> +			return  -EIO;
> 
> Why not assigning ret and falling through, like in most other functions?
> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_start);
>> +
>> +/**
>> + * rproc_tee_stop - Request the TEE application to start the remote processor
>> + *
>> + * This function invokes the TA_RPROC_FW_CMD_STOP command to stop the remote processor.
>> + *
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + *
>> + * Return: Returns 0 on success, -EINVAL or -EIO on failure
>> + */
>> +int rproc_tee_stop(struct rproc *rproc)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct rproc_tee *trproc = rproc_to_trproc(rproc);
>> +	struct tee_ioctl_invoke_arg arg;
>> +	int ret;
>> +
>> +	if (!trproc)
>> +		return -EINVAL;
>> +
>> +	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_STOP, &arg, param, 0);
>> +
>> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret != 0) {
>> +		dev_err(rproc_tee_ctx.dev,
>> +			"TA_RPROC_FW_CMD_STOP invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
>> +		if (!ret)
>> +			ret = -EIO;
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_stop);
>> +
>> +static const struct tee_client_device_id rproc_tee_id_table[] = {
>> +	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905, 0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
>> +	{}
>> +};
>> +
>> +/**
>> + * rproc_tee_register - Register a remote processor controlled by a TEE application.
>> + *
>> + * This function registers a remote processor that will be managed by a TEE application,by opening
>> + * a session with the TEE client.
>> + *
>> + * @dev: Pointer to client rproc device
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @rproc_id: ID of the remote processor
>> + *
>> + * Return: Returns 0 on success, or an error code on failure
>> + */
>> +int rproc_tee_register(struct device *dev, struct rproc *rproc, unsigned int rproc_id)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct tee_ioctl_open_session_arg sess_arg;
>> +	struct tee_client_device *tee_device;
>> +	struct rproc_tee *trproc;
>> +	struct device_link *link;
>> +	int ret;
>> +
>> +	spin_lock(&ctx_lock);
> 
> Why is this a spin_lock?
> 
> To my understanding the purpose of ctx_lock is to ensure mutual
> exclusion of access to rproc_tee_ctx, but this doesn't look like it's
> done from a context that isn't able to tolerate a mutex.
> 
> In particular during boot, if you have multiple remoteprocs being
> registred, you're going to waste precious CPU cycles just spinning here.
> 
> 
> And if it is a spinlock because you might enter here from some interrupt
> context, how do you ensure this won't deadlock?

Right I need to use mutex instead and beter protect all the API from concurrent
access to better manage bind/unbind.
> 
>> +	/*
>> +	 * Test if the device has been probed by the TEE bus. In case of failure, we ignore the
>> +	 * reason. The bus could be not yet probed or the service not available in the secure
>> +	 * firmware.The assumption in such a case is that the TEE remoteproc is not probed.
>> +	 */
>> +	if (!rproc_tee_ctx.dev) {
>> +		ret = -EPROBE_DEFER;
>> +		goto out;
>> +	}
>> +
>> +	trproc = kzalloc(sizeof(*trproc), GFP_KERNEL);
>> +	if (!trproc) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	tee_device = to_tee_client_device(rproc_tee_ctx.dev);
>> +	memset(&sess_arg, 0, sizeof(sess_arg));
>> +
>> +	memcpy(sess_arg.uuid, tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
>> +
>> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
>> +	sess_arg.num_params = 1;
>> +
>> +	param[0] = (struct tee_param) {
>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>> +		.u.value.a = rproc_id,
>> +	};
> 
> I'm not familiar with the details of the tee calling convention, but do
> you really need 4 entries in the param array and if so, would it make
> sense to zero-initialize the other elements - like you do in all other
> functions?


In rproc_tee_prepare_args(), we reinitialize the arguments and parameters
because they may be reused from a previous message. This allow to set
only non zero value.

THere as sess_arg.num_params = 1 only param[0] is valid, other param
should be ignored.
In this context use memeset seems over protection here.


Thanks,
Arnaud
> 
>> +
>> +	ret = tee_client_open_session(rproc_tee_ctx.tee_ctx, &sess_arg, param);
>> +	if (ret < 0 || sess_arg.ret != 0) {
>> +		dev_err(dev, "tee_client_open_session failed, err: %#x\n", sess_arg.ret);
>> +		ret = -EINVAL;
>> +		goto free_tproc;
>> +	}
>> +
>> +	trproc->rproc_id = rproc_id;
>> +	trproc->session_id = sess_arg.session;
>> +
>> +	trproc->rproc = rproc;
>> +
>> +	/* Create device link between the rproc device and the TEE device */
> 
> This comment would be more useful if it documented why the link is
> created - the fact that a link is added between the two devices can be
> read on the next line...
> 
>> +	link = device_link_add(dev, rproc_tee_ctx.dev, DL_FLAG_AUTOREMOVE_CONSUMER);
>> +	if (!link) {
>> +		ret = -ENOMEM;
>> +		goto close_tee;
>> +	}
>> +	list_add_tail(&trproc->node, &rproc_tee_ctx.sessions);
>> +
>> +	goto out;
> 
> Please don't use goto to skip over the error handling. ret is going to
> be 0 here, so unlock and return 0 here to make it clear that this is the
> point of successful return.
> 
>> +
>> +close_tee:
>> +	if (tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id))
>> +		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed\n");
>> +free_tproc:
>> +	kfree(trproc);
>> +out:
>> +	spin_unlock(&ctx_lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_register);
>> +
>> +/**
>> + * rproc_tee_unregister - Register a remote processor controlled by a TEE application.
>> + *
>> + * This function unregisters a remote processor previously registered by the rproc_tee_register()
>> + * function.
>> + *
>> + * @dev: Pointer to client rproc device
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + *
>> + * Return: Returns 0 on success, or an error code on failure
>> + */
>> +int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
>> +{
>> +	struct rproc_tee *trproc = rproc_to_trproc(rproc);
>> +	int ret;
>> +
>> +	if (!trproc)
>> +		return -EINVAL;
>> +
>> +	spin_lock(&ctx_lock);
> 
> This lock is taken after you have traversed the rproc_tee_ctx.session
> list in a racy fashion.
> 
>> +
>> +	ret = tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id);
>> +	if (ret < 0)
>> +		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed, err: %#x\n", ret);
>> +
>> +	spin_unlock(&ctx_lock);
>> +
>> +	list_del(&trproc->node);
> 
> Although, I might misunderstand your locking scheme, because here you're
> modifying the sessions list immediately after leaving the mutual
> exclusion region?
> 
>> +	kfree(trproc);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_unregister);
>> +
>> +static int rproc_tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>> +{
>> +	/* Today we support only the OP-TEE, could be extend to other tees */
>> +	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
>> +}
>> +
>> +static int rproc_tee_probe(struct device *dev)
>> +{
>> +	struct tee_context *tee_ctx;
>> +
>> +	/* Open context with TEE driver */
>> +	tee_ctx = tee_client_open_context(NULL, rproc_tee_ctx_match, NULL, NULL);
>> +	if (IS_ERR(tee_ctx))
>> +		return PTR_ERR(tee_ctx);
>> +
>> +	spin_lock(&ctx_lock);
>> +	rproc_tee_ctx.dev = dev;
>> +	rproc_tee_ctx.tee_ctx = tee_ctx;
>> +	INIT_LIST_HEAD(&rproc_tee_ctx.sessions);
>> +	spin_unlock(&ctx_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rproc_tee_remove(struct device *dev)
>> +{
>> +	spin_lock(&ctx_lock);
>> +	tee_client_close_context(rproc_tee_ctx.tee_ctx);
>> +	rproc_tee_ctx.dev = NULL;
>> +	rproc_tee_ctx.tee_ctx = NULL;
>> +	spin_unlock(&ctx_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +MODULE_DEVICE_TABLE(tee, rproc_tee_id_table);
>> +
>> +static struct tee_client_driver rproc_tee_fw_driver = {
>> +	.id_table	= rproc_tee_id_table,
>> +	.driver		= {
>> +		.name		= KBUILD_MODNAME,
>> +		.bus		= &tee_bus_type,
>> +		.probe		= rproc_tee_probe,
>> +		.remove		= rproc_tee_remove,
>> +	},
>> +};
>> +
>> +static int __init rproc_tee_fw_mod_init(void)
>> +{
>> +	return driver_register(&rproc_tee_fw_driver.driver);
>> +}
>> +
>> +static void __exit rproc_tee_fw_mod_exit(void)
>> +{
>> +	driver_unregister(&rproc_tee_fw_driver.driver);
>> +}
>> +
>> +module_init(rproc_tee_fw_mod_init);
>> +module_exit(rproc_tee_fw_mod_exit);
>> +
>> +MODULE_DESCRIPTION(" remote processor TEE module");
> 
> Why is there a space in the start of the description?
> 
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/remoteproc_tee.h b/include/linux/remoteproc_tee.h
>> new file mode 100644
>> index 000000000000..659bd77a4f12
>> --- /dev/null
>> +++ b/include/linux/remoteproc_tee.h
>> @@ -0,0 +1,90 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright(c) 2024 STMicroelectronics
> 
> Year?
> 
>> + */
>> +
>> +#ifndef REMOTEPROC_TEE_H
>> +#define REMOTEPROC_TEE_H
>> +
>> +#include <linux/tee_drv.h>
>> +#include <linux/firmware.h>
>> +#include <linux/remoteproc.h>
>> +
>> +struct rproc;
>> +struct rproc_tee;
> 
> rproc_tee is not used in the API, so there shouldn't be a need for
> forward declaring it.
> 
> struct rproc is defined in linux/remoteproc.h, so that should be fine to
> omit as well.
> 
>> +
>> +#if IS_ENABLED(CONFIG_REMOTEPROC_TEE)
>> +
>> +int rproc_tee_register(struct device *dev, struct rproc *rproc, unsigned int rproc_id);
>> +int rproc_tee_unregister(struct device *dev, struct rproc *rproc);
>> +int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw);
>> +int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw);
>> +void rproc_tee_release_fw(struct rproc *rproc);
>> +struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
>> +						       const struct firmware *fw);
>> +int rproc_tee_start(struct rproc *rproc);
>> +int rproc_tee_stop(struct rproc *rproc);
>> +
>> +#else
>> +
>> +static inline int rproc_tee_register(struct device *dev, struct rproc *rproc, unsigned int rproc_id)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_tee_load_fw(struct rproc *rproc,  const struct firmware *fw)
> 
> Double space after the ','
> 
> Regards,
> Bjorn
> 
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_tee_start(struct rproc *rproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_tee_stop(struct rproc *rproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void rproc_tee_release_fw(struct rproc *rproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +}
>> +
>> +static inline struct resource_table *
>> +rproc_tee_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return NULL;
>> +}
>> +#endif /* CONFIG_REMOTEPROC_TEE */
>> +#endif /* REMOTEPROC_TEE_H */
>> -- 
>> 2.25.1
>>
