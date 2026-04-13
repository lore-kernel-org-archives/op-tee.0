Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26924EBFD23
	for <op-tee@archiver.kernel.org>; Mon, 13 Apr 2026 09:30:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5AA264326E
	for <op-tee@archiver.kernel.org>; Mon, 13 Apr 2026 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1776072623;
	bh=5rux/5nTnAHNMgVq/dvnhrOy51w5xiF0v4jBUlpcnRA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Wi1fTvLeyhVhLFbvLzlNExdQKwWQo2Sm9iZb5+q9ARoIDY+6hYMO/5BvrNnozw76c
	 91o11d/dFs5Ax9dW8ZCcahJOfXEkujp8QDuAC4DLZaN6A3cpKx94IPZhBzE/4EVR10
	 cBc7dufrt7gI/m6RDtaltdPTFT73IuFIdVuxvf+fvqYKJ4zhT+2Tqd/Y4MyXEna/Ng
	 hHBr8R4P23DdPJsYN1WrQxcEVqImLiyhGqvzkLsaraTILWcp8eUz0FoD6VAeuDapfq
	 bVAO/sjunJHHRSRZULJ6npAtXoDINBY7xxi+7TDuSM+RcRgdi8lD7LvICqWIpDGwi5
	 zuHz1AkvjLMTA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 776E64326E
	for <op-tee@lists.trustedfirmware.org>; Mon, 13 Apr 2026 09:30:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XRa9Xu/0;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D8DAD44115;
	Mon, 13 Apr 2026 09:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11A8C116C6;
	Mon, 13 Apr 2026 09:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776072616;
	bh=5rux/5nTnAHNMgVq/dvnhrOy51w5xiF0v4jBUlpcnRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRa9Xu/0YSVDvRPlwhltJhX6eMn9jmHg9dRuZpZKAqfleavcnoLZNdc5z2ewTPeL4
	 Bxks139+8hPzq8tIYv28Lq881Q1/NUMJJkj4pxNhZkT6fUh/pv16Ct5T8XgXjKaFpa
	 Gk/WNZSdZEWcqAtGMTeldzzPJswjiYOq09/d2HDHdNpISrm9VbVEjNmmZgxXgnnqq1
	 /cBGJkGodB5d7tWPevcbrM2/i19jACqb3S/WZK6Iv28kKqXHuHUpvL/yblvXKvO5vu
	 7FcoknPnJL0UxQ2h8PaNBtrL9VjInzMFDls+XaRFkjTkCpyzI5+3qmAhMvpd+zQrbv
	 AIyKcoGwDCqTQ==
Date: Mon, 13 Apr 2026 15:00:11 +0530
To: Rodrigo Zaiden <rodrigoffzz@gmail.com>
Subject: Re: [PATCH] tee: optee: fix kernel-doc warnings
Message-ID: <ady3o0i3YDmTehfK@sumit-xelite>
References: <20260322163114.17233-1-rodrigoffzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322163114.17233-1-rodrigoffzz@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 776E64326E
X-Spamd-Bar: ----
Message-ID-Hash: I2FH5WFMY3TPEVJR43IUS3RAPGM3SEPI
X-Message-ID-Hash: I2FH5WFMY3TPEVJR43IUS3RAPGM3SEPI
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, Shuah Khan <skhan@linuxfoundation.org>, Brigham Campbell <me@brighamcampbell.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I2FH5WFMY3TPEVJR43IUS3RAPGM3SEPI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Sun, Mar 22, 2026 at 01:31:14PM -0300, Rodrigo Zaiden wrote:
> Fix kernel-doc issues in optee_private.h and optee_msg.h:
> 
> - Add missing documentation for struct members: optee_msg_param_value,
>   optee_msg_param, optee_msg_arg, optee, and optee_ffa;
> - Ensure member descriptions follow the order of declaration;
> - Use consistent formatting (lowercase descriptions and ':' after
>   member names);
> - Adjust indentation for better alignment;
> 
> This resolves kernel-doc warnings such as missing member descriptions
> and incorrect prototype documentation.
> No functional changes.
> 
> Signed-off-by: Rodrigo Zaiden <rodrigoffzz@gmail.com>
> ---
>  drivers/tee/optee/optee_msg.h     |  50 +++++++------
>  drivers/tee/optee/optee_private.h | 120 ++++++++++++++++--------------
>  2 files changed, 92 insertions(+), 78 deletions(-)

Thanks for doc fixes, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 838e1d4a22f0..7d9b12e71c03 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -103,9 +103,9 @@
>  
>  /**
>   * struct optee_msg_param_tmem - temporary memory reference parameter
> - * @buf_ptr:	Address of the buffer
> - * @size:	Size of the buffer
> - * @shm_ref:	Temporary shared memory reference, pointer to a struct tee_shm
> + * @buf_ptr:	address of the buffer
> + * @size:	size of the buffer
> + * @shm_ref:	temporary shared memory reference, pointer to a struct tee_shm
>   *
>   * Secure and normal world communicates pointers as physical address
>   * instead of the virtual address. This is because secure and normal world
> @@ -122,9 +122,9 @@ struct optee_msg_param_tmem {
>  
>  /**
>   * struct optee_msg_param_rmem - registered memory reference parameter
> - * @offs:	Offset into shared memory reference
> - * @size:	Size of the buffer
> - * @shm_ref:	Shared memory reference, pointer to a struct tee_shm
> + * @offs:	offset into shared memory reference
> + * @size:	size of the buffer
> + * @shm_ref:	shared memory reference, pointer to a struct tee_shm
>   */
>  struct optee_msg_param_rmem {
>  	u64 offs;
> @@ -134,12 +134,12 @@ struct optee_msg_param_rmem {
>  
>  /**
>   * struct optee_msg_param_fmem - FF-A memory reference parameter
> - * @offs_lower:	   Lower bits of offset into shared memory reference
> - * @offs_upper:	   Upper bits of offset into shared memory reference
> - * @internal_offs: Internal offset into the first page of shared memory
> - *		   reference
> - * @size:	   Size of the buffer
> - * @global_id:	   Global identifier of the shared memory
> + * @offs_low:		lower bits of offset into shared memory reference
> + * @offs_high:		higher bits of offset into shared memory reference
> + * @internal_offs:	internal offset into the first page of shared memory
> + *			reference
> + * @size:		size of the buffer
> + * @global_id:		global identifier of the shared memory
>   */
>  struct optee_msg_param_fmem {
>  	u32 offs_low;
> @@ -151,6 +151,9 @@ struct optee_msg_param_fmem {
>  
>  /**
>   * struct optee_msg_param_value - opaque value parameter
> + * @a: first opaque value
> + * @b: second opaque value
> + * @c: third opaque value
>   *
>   * Value parameters are passed unchecked between normal and secure world.
>   */
> @@ -168,6 +171,7 @@ struct optee_msg_param_value {
>   * @fmem:	parameter by FF-A registered memory reference
>   * @value:	parameter by opaque value
>   * @octets:	parameter by octet string
> + * @u:		union holding OP-TEE msg parameter
>   *
>   * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is used in
>   * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value or octets,
> @@ -189,16 +193,18 @@ struct optee_msg_param {
>  
>  /**
>   * struct optee_msg_arg - call argument
> - * @cmd: Command, one of OPTEE_MSG_CMD_* or OPTEE_MSG_RPC_CMD_*
> - * @func: Trusted Application function, specific to the Trusted Application,
> - *	     used if cmd == OPTEE_MSG_CMD_INVOKE_COMMAND
> - * @session: In parameter for all OPTEE_MSG_CMD_* except
> - *	     OPTEE_MSG_CMD_OPEN_SESSION where it's an output parameter instead
> - * @cancel_id: Cancellation id, a unique value to identify this request
> - * @ret: return value
> - * @ret_origin: origin of the return value
> - * @num_params: number of parameters supplied to the OS Command
> - * @params: the parameters supplied to the OS Command
> + * @cmd:	command, one of OPTEE_MSG_CMD_* or OPTEE_MSG_RPC_CMD_*
> + * @func:	Trusted Application function, specific to the Trusted
> + *		Application, used if cmd == OPTEE_MSG_CMD_INVOKE_COMMAND
> + * @session:	in parameter for all OPTEE_MSG_CMD_* except
> + *		OPTEE_MSG_CMD_OPEN_SESSION where it's an output parameter
> + *		instead
> + * @cancel_id:	cancellation id, a unique value to identify this request
> + * @pad:	padding for alignment
> + * @ret:	return value
> + * @ret_origin:	origin of the return value
> + * @num_params:	number of parameters supplied to the OS Command
> + * @params:	the parameters supplied to the OS Command
>   *
>   * All normal calls to Trusted OS uses this struct. If cmd requires further
>   * information than what these fields hold it can be passed as a parameter
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index acd3051c4879..aefe1e6f5689 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -47,11 +47,11 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
>  				unsigned long, unsigned long,
>  				struct arm_smccc_res *);
>  
> -/*
> +/**
>   * struct optee_call_waiter - TEE entry may need to wait for a free TEE thread
> - * @list_node		Reference in waiters list
> - * @c			Waiting completion reference
> - * @sys_thread		True if waiter belongs to a system thread
> + * @list_node:	reference in waiters list
> + * @c:		waiting completion reference
> + * @sys_thread:	true if waiter belongs to a system thread
>   */
>  struct optee_call_waiter {
>  	struct list_head list_node;
> @@ -59,13 +59,13 @@ struct optee_call_waiter {
>  	bool sys_thread;
>  };
>  
> -/*
> +/**
>   * struct optee_call_queue - OP-TEE call queue management
> - * @mutex			Serializes access to this struct
> - * @waiters			List of threads waiting to enter OP-TEE
> - * @total_thread_count		Overall number of thread context in OP-TEE or 0
> - * @free_thread_count		Number of threads context free in OP-TEE
> - * @sys_thread_req_count	Number of registered system thread sessions
> + * @mutex:			serializes access to this struct
> + * @waiters:			list of threads waiting to enter OP-TEE
> + * @total_thread_count:		overall number of thread context in OP-TEE or 0
> + * @free_thread_count:		number of threads context free in OP-TEE
> + * @sys_thread_req_count:	number of registered system thread sessions
>   */
>  struct optee_call_queue {
>  	/* Serializes access to this struct */
> @@ -96,17 +96,17 @@ struct optee_shm_arg_cache {
>  
>  /**
>   * struct optee_supp - supplicant synchronization struct
> - * @ctx			the context of current connected supplicant.
> - *			if !NULL the supplicant device is available for use,
> - *			else busy
> - * @mutex:		held while accessing content of this struct
> - * @req_id:		current request id if supplicant is doing synchronous
> - *			communication, else -1
> - * @reqs:		queued request not yet retrieved by supplicant
> - * @idr:		IDR holding all requests currently being processed
> - *			by supplicant
> - * @reqs_c:		completion used by supplicant when waiting for a
> - *			request to be queued.
> + * @mutex:	held while accessing content of this struct
> + * @ctx:	the context of current connected supplicant.
> + *		if !NULL the supplicant device is available for use,
> + *		else busy
> + * @req_id:	current request id if supplicant is doing synchronous
> + *		communication, else -1
> + * @reqs:	queued request not yet retrieved by supplicant
> + * @idr:	IDR holding all requests currently being processed
> + *		by supplicant
> + * @reqs_c:	completion used by supplicant when waiting for a
> + *		request to be queued.
>   */
>  struct optee_supp {
>  	/* Serializes access to this struct */
> @@ -119,25 +119,25 @@ struct optee_supp {
>  	struct completion reqs_c;
>  };
>  
> -/*
> +/**
>   * struct optee_pcpu - per cpu notif private struct passed to work functions
> - * @optee		optee device reference
> + * @optee:	optee device reference
>   */
>  struct optee_pcpu {
>  	struct optee *optee;
>  };
>  
> -/*
> +/**
>   * struct optee_smc - optee smc communication struct
> - * @invoke_fn		handler function to invoke secure monitor
> - * @memremaped_shm	virtual address of memory in shared memory pool
> + * @invoke_fn:		handler function to invoke secure monitor
> + * @memremaped_shm:	virtual address of memory in shared memory pool
>   * @sec_caps:		secure world capabilities defined by
>   *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
> - * @notif_irq		interrupt used as async notification by OP-TEE or 0
> - * @optee_pcpu		per_cpu optee instance for per cpu work or NULL
> - * @notif_pcpu_wq	workqueue for per cpu asynchronous notification or NULL
> - * @notif_pcpu_work	work for per cpu asynchronous notification
> - * @notif_cpuhp_state   CPU hotplug state assigned for pcpu interrupt management
> + * @notif_irq:		interrupt used as async notification by OP-TEE or 0
> + * @optee_pcpu:		per_cpu optee instance for per cpu work or NULL
> + * @notif_pcpu_wq:	workqueue for per cpu asynchronous notification or NULL
> + * @notif_pcpu_work:	work for per cpu asynchronous notification
> + * @notif_cpuhp_state:	CPU hotplug state assigned for pcpu interrupt management
>   */
>  struct optee_smc {
>  	optee_invoke_fn *invoke_fn;
> @@ -151,13 +151,15 @@ struct optee_smc {
>  };
>  
>  /**
> - * struct optee_ffa_data -  FFA communication struct
> - * @ffa_dev		FFA device, contains the destination id, the id of
> + * struct optee_ffa -  FFA communication struct
> + * @ffa_dev:		FFA device, contains the destination id, the id of
>   *			OP-TEE in secure world
> - * @bottom_half_value	Notification ID used for bottom half signalling or
> + * @bottom_half_value:	notification ID used for bottom half signalling or
>   *			U32_MAX if unused
> - * @mutex		Serializes access to @global_ids
> - * @global_ids		FF-A shared memory global handle translation
> + * @mutex:		serializes access to @global_ids
> + * @global_ids:		FF-A shared memory global handle translation
> + * @notif_wq:		workqueue for FF-A asynchronous notification
> + * @notif_work:		work for FF-A asynchronous notification
>   */
>  struct optee_ffa {
>  	struct ffa_device *ffa_dev;
> @@ -222,26 +224,32 @@ struct optee_ops {
>  
>  /**
>   * struct optee - main service struct
> - * @supp_teedev:	supplicant device
> - * @teedev:		client device
> - * @ops:		internal callbacks for different ways to reach secure
> - *			world
> - * @ctx:		driver internal TEE context
> - * @smc:		specific to SMC ABI
> - * @ffa:		specific to FF-A ABI
> - * @call_queue:		queue of threads waiting to call @invoke_fn
> - * @notif:		notification synchronization struct
> - * @supp:		supplicant synchronization struct for RPC to supplicant
> - * @pool:		shared memory pool
> - * @mutex:		mutex protecting @rpmb_dev
> - * @rpmb_dev:		current RPMB device or NULL
> - * @rpmb_scan_bus_done	flag if device registation of RPMB dependent devices
> - *			was already done
> - * @rpmb_scan_bus_work	workq to for an RPMB device and to scan optee bus
> - *			and register RPMB dependent optee drivers
> - * @rpc_param_count:	If > 0 number of RPC parameters to make room for
> - * @scan_bus_done	flag if device registation was already done.
> - * @scan_bus_work	workq to scan optee bus and register optee drivers
> + * @supp_teedev:		supplicant device
> + * @teedev:			client device
> + * @ops:			internal callbacks for different ways to reach
> + *				secure world
> + * @ctx:			driver internal TEE context
> + * @smc:			specific to SMC ABI
> + * @ffa:			specific to FF-A ABI
> + * @shm_arg_cache:		shared memory cache argument
> + * @call_queue:			queue of threads waiting to call @invoke_fn
> + * @notif:			notification synchronization struct
> + * @supp:			supplicant synchronization struct for RPC to
> + *				supplicant
> + * @pool:			shared memory pool
> + * @rpmb_dev_mutex:		mutex protecting @rpmb_dev
> + * @rpmb_dev:			current RPMB device or NULL
> + * @rpmb_intf:			RPMB notifier block
> + * @rpc_param_count:		if > 0 number of RPC parameters to make room for
> + * @scan_bus_done:		flag if device registation was already done
> + * @rpmb_scan_bus_done:		flag if device registation of RPMB dependent
> + *				devices was already done
> + * @in_kernel_rpmb_routing:	flag if OP-TEE supports in-kernel RPMB routing
> + * @scan_bus_work:		workq to scan optee bus and register optee
> + *				drivers
> + * @rpmb_scan_bus_work:		workq to for an RPMB device and to scan optee
> + *				bus and register RPMB dependent optee drivers
> + * @revision:			OP-TEE OS revision
>   */
>  struct optee {
>  	struct tee_device *supp_teedev;
> -- 
> 2.43.0
> 
