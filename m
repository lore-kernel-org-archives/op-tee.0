Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3395C54ED0
	for <op-tee@archiver.kernel.org>; Fri, 23 May 2025 09:00:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E6BEF4313F
	for <op-tee@archiver.kernel.org>; Fri, 23 May 2025 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1747990851;
	bh=mTpxlzLfOxVD0utOYJ/lK616UQLpk4pGr8aEVscKunw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=e2lB5vtM9feLi1aygOLhST9AF3HjRA9miQX3hZ8tphXAyRHe4jz/mT51iSSMugbEe
	 gbFViwtLJMBYdO8gJAqEKF6zSZO3Mgr3brjCOUgc6qVZwb7A+hjHPcVDR3LJWjEZfp
	 mL7kSitugr0B/V3NEE8CCVty/bIj5bMdYS8anH/R8kQ7g/0Col+znpapzEnqOuOPdH
	 elTWzWFbSASc5lxPoAREEhxHEYVH1QrbCzZsJd4x/P1AG1IFD5YRwvvuUsBaYsKPgu
	 0k9PBFZHhiZfhEJ2BwBmV8mC9i7D40ztVtHwDi7Md/UyoaxSOehjbUEytMndnrBD3z
	 vvM2kxz6fZECw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5653A42E92
	for <op-tee@lists.trustedfirmware.org>; Fri, 23 May 2025 09:00:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fPcckd+B;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 56522629F6;
	Fri, 23 May 2025 09:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37C8C4CEEF;
	Fri, 23 May 2025 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747990831;
	bh=mTpxlzLfOxVD0utOYJ/lK616UQLpk4pGr8aEVscKunw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPcckd+BLil1KAT5UIYjPx03Fh3ZTaEugtxxZElUKqLeUA9XnqsXOv4ajQshd0H1q
	 2QELspOTRsUVpRVzevbwVfXxvM4HiXroUghaQnUUc8KE3ZDHwjs/1coEwu097gZLhy
	 4aKBRwGfn3YcD3qOypMOXVAGws7OmtQKGJx24v2bPo679/vo0Hrikk0SqiquTQyaRH
	 M5GH0ao2pnHZa4ANAt3PC8PKy4qSF7gPbYYdG3yxKni/F5NgTQxj2S5lcqO/b7cP0R
	 NZe6DjeT7IdAgi4GGljMStrUqi+h/92RK3rEyYDY31aSKWPw8291UIh2ltO3pnVGCf
	 5uC2mR9yOENyQ==
Date: Fri, 23 May 2025 14:30:17 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v9 1/9] optee: sync secure world ABI headers
Message-ID: <aDA5IZ4lBIxNcJQX@sumit-X1>
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520152436.474778-2-jens.wiklander@linaro.org>
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[172.105.4.254:from];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5653A42E92
Message-ID-Hash: U5P2JTI7PRDKEOM42RJTU7AJ3B4FEUES
X-Message-ID-Hash: U5P2JTI7PRDKEOM42RJTU7AJ3B4FEUES
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U5P2JTI7PRDKEOM42RJTU7AJ3B4FEUES/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, May 20, 2025 at 05:16:44PM +0200, Jens Wiklander wrote:
> Update the header files describing the secure world ABI, both with and
> without FF-A. The ABI is extended to deal with protected memory, but as
> usual backward compatible.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/optee_ffa.h | 27 ++++++++---
>  drivers/tee/optee/optee_msg.h | 84 ++++++++++++++++++++++++++++++-----
>  drivers/tee/optee/optee_smc.h | 37 ++++++++++++++-
>  3 files changed, 130 insertions(+), 18 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
> index 257735ae5b56..cc257e7956a3 100644
> --- a/drivers/tee/optee/optee_ffa.h
> +++ b/drivers/tee/optee/optee_ffa.h
> @@ -81,7 +81,7 @@
>   *                   as the second MSG arg struct for
>   *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
>   *        Bit[31:8]: Reserved (MBZ)
> - * w5:	  Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
> + * w5:	  Bitfield of OP-TEE capabilities OPTEE_FFA_SEC_CAP_*
>   * w6:	  The maximum secure world notification number
>   * w7:	  Not used (MBZ)
>   */
> @@ -94,6 +94,8 @@
>  #define OPTEE_FFA_SEC_CAP_ASYNC_NOTIF	BIT(1)
>  /* OP-TEE supports probing for RPMB device if needed */
>  #define OPTEE_FFA_SEC_CAP_RPMB_PROBE	BIT(2)
> +/* OP-TEE supports Protected Memory for secure data path */
> +#define OPTEE_FFA_SEC_CAP_PROTMEM	BIT(3)
>  
>  #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
>  
> @@ -108,7 +110,7 @@
>   *
>   * Return register usage:
>   * w3:    Error code, 0 on success
> - * w4-w7: Note used (MBZ)
> + * w4-w7: Not used (MBZ)
>   */
>  #define OPTEE_FFA_UNREGISTER_SHM	OPTEE_FFA_BLOCKING_CALL(3)
>  
> @@ -119,16 +121,31 @@
>   * Call register usage:
>   * w3:    Service ID, OPTEE_FFA_ENABLE_ASYNC_NOTIF
>   * w4:	  Notification value to request bottom half processing, should be
> - *	  less than OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE.
> + *	  less than OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE
>   * w5-w7: Not used (MBZ)
>   *
>   * Return register usage:
>   * w3:    Error code, 0 on success
> - * w4-w7: Note used (MBZ)
> + * w4-w7: Not used (MBZ)
>   */
>  #define OPTEE_FFA_ENABLE_ASYNC_NOTIF	OPTEE_FFA_BLOCKING_CALL(5)
>  
> -#define OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE 64
> +#define OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE	64
> +
> +/*
> + * Release Protected memory
> + *
> + * Call register usage:
> + * w3:    Service ID, OPTEE_FFA_RECLAIM_PROTMEM
> + * w4:    Shared memory handle, lower bits
> + * w5:    Shared memory handle, higher bits
> + * w6-w7: Not used (MBZ)
> + *
> + * Return register usage:
> + * w3:    Error code, 0 on success
> + * w4-w7: Note used (MBZ)
> + */
> +#define OPTEE_FFA_RELEASE_PROTMEM	OPTEE_FFA_BLOCKING_CALL(8)
>  
>  /*
>   * Call with struct optee_msg_arg as argument in the supplied shared memory
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index e8840a82b983..22130e967dc5 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -133,13 +133,13 @@ struct optee_msg_param_rmem {
>  };
>  
>  /**
> - * struct optee_msg_param_fmem - ffa memory reference parameter
> + * struct optee_msg_param_fmem - FF-A memory reference parameter
>   * @offs_lower:	   Lower bits of offset into shared memory reference
>   * @offs_upper:	   Upper bits of offset into shared memory reference
>   * @internal_offs: Internal offset into the first page of shared memory
>   *		   reference
>   * @size:	   Size of the buffer
> - * @global_id:	   Global identifier of Shared memory
> + * @global_id:	   Global identifier of the shared memory
>   */
>  struct optee_msg_param_fmem {
>  	u32 offs_low;
> @@ -165,7 +165,7 @@ struct optee_msg_param_value {
>   * @attr:	attributes
>   * @tmem:	parameter by temporary memory reference
>   * @rmem:	parameter by registered memory reference
> - * @fmem:	parameter by ffa registered memory reference
> + * @fmem:	parameter by FF-A registered memory reference
>   * @value:	parameter by opaque value
>   * @octets:	parameter by octet string
>   *
> @@ -296,6 +296,18 @@ struct optee_msg_arg {
>   */
>  #define OPTEE_MSG_FUNCID_GET_OS_REVISION	0x0001
>  
> +/*
> + * Values used in OPTEE_MSG_CMD_LEND_PROTMEM below
> + * OPTEE_MSG_PROTMEM_RESERVED		Reserved
> + * OPTEE_MSG_PROTMEM_SECURE_VIDEO_PLAY	Secure Video Playback
> + * OPTEE_MSG_PROTMEM_TRUSTED_UI		Trused UI
> + * OPTEE_MSG_PROTMEM_SECURE_VIDEO_RECORD	Secure Video Recording
> + */
> +#define OPTEE_MSG_PROTMEM_RESERVED		0
> +#define OPTEE_MSG_PROTMEM_SECURE_VIDEO_PLAY	1
> +#define OPTEE_MSG_PROTMEM_TRUSTED_UI		2
> +#define OPTEE_MSG_PROTMEM_SECURE_VIDEO_RECORD	3
> +
>  /*
>   * Do a secure call with struct optee_msg_arg as argument
>   * The OPTEE_MSG_CMD_* below defines what goes in struct optee_msg_arg::cmd
> @@ -337,15 +349,63 @@ struct optee_msg_arg {
>   * OPTEE_MSG_CMD_STOP_ASYNC_NOTIF informs secure world that from now is
>   * normal world unable to process asynchronous notifications. Typically
>   * used when the driver is shut down.
> + *
> + * OPTEE_MSG_CMD_LEND_PROTMEM lends protected memory. The passed normal
> + * physical memory is protected from normal world access. The memory
> + * should be unmapped prior to this call since it becomes inaccessible
> + * during the request.
> + * Parameters are passed as:
> + * [in] param[0].attr			OPTEE_MSG_ATTR_TYPE_VALUE_INPUT
> + * [in] param[0].u.value.a		OPTEE_MSG_PROTMEM_* defined above
> + * [in] param[1].attr			OPTEE_MSG_ATTR_TYPE_TMEM_INPUT
> + * [in] param[1].u.tmem.buf_ptr		physical address
> + * [in] param[1].u.tmem.size		size
> + * [in] param[1].u.tmem.shm_ref		holds protected memory reference
> + *
> + * OPTEE_MSG_CMD_RECLAIM_PROTMEM reclaims a previously lent protected
> + * memory reference. The physical memory is accessible by the normal world
> + * after this function has return and can be mapped again. The information
> + * is passed as:
> + * [in] param[0].attr			OPTEE_MSG_ATTR_TYPE_VALUE_INPUT
> + * [in] param[0].u.value.a		holds protected memory cookie
> + *
> + * OPTEE_MSG_CMD_GET_PROTMEM_CONFIG get configuration for a specific
> + * protected memory use case. Parameters are passed as:
> + * [in] param[0].attr			OPTEE_MSG_ATTR_TYPE_VALUE_INOUT
> + * [in] param[0].value.a		OPTEE_MSG_PROTMEM_*
> + * [in] param[1].attr			OPTEE_MSG_ATTR_TYPE_{R,F}MEM_OUTPUT
> + * [in] param[1].u.{r,f}mem		Buffer or NULL
> + * [in] param[1].u.{r,f}mem.size	Provided size of buffer or 0 for query
> + * output for the protected use case:
> + * [out] param[0].value.a		Minimal size of protected memory
> + * [out] param[0].value.b		Required alignment of size and start of
> + *					protected memory
> + * [out] param[0].value.c               PA width, max 64
> + * [out] param[1].{r,f}mem.size		Size of output data
> + * [out] param[1].{r,f}mem		If non-NULL, contains an array of
> + *					uint16_t holding endpoints that
> + *					must be included when lending
> + *					memory for this use case
> + *
> + * OPTEE_MSG_CMD_ASSIGN_PROTMEM assigns use-case to protected memory
> + * previously lent using the FFA_LEND framework ABI. Parameters are passed
> + * as:
> + * [in] param[0].attr			OPTEE_MSG_ATTR_TYPE_VALUE_INPUT
> + * [in] param[0].u.value.a		holds protected memory cookie
> + * [in] param[0].u.value.b		OPTEE_MSG_PROTMEM_* defined above
>   */
> -#define OPTEE_MSG_CMD_OPEN_SESSION	0
> -#define OPTEE_MSG_CMD_INVOKE_COMMAND	1
> -#define OPTEE_MSG_CMD_CLOSE_SESSION	2
> -#define OPTEE_MSG_CMD_CANCEL		3
> -#define OPTEE_MSG_CMD_REGISTER_SHM	4
> -#define OPTEE_MSG_CMD_UNREGISTER_SHM	5
> -#define OPTEE_MSG_CMD_DO_BOTTOM_HALF	6
> -#define OPTEE_MSG_CMD_STOP_ASYNC_NOTIF	7
> -#define OPTEE_MSG_FUNCID_CALL_WITH_ARG	0x0004
> +#define OPTEE_MSG_CMD_OPEN_SESSION		0
> +#define OPTEE_MSG_CMD_INVOKE_COMMAND		1
> +#define OPTEE_MSG_CMD_CLOSE_SESSION		2
> +#define OPTEE_MSG_CMD_CANCEL			3
> +#define OPTEE_MSG_CMD_REGISTER_SHM		4
> +#define OPTEE_MSG_CMD_UNREGISTER_SHM		5
> +#define OPTEE_MSG_CMD_DO_BOTTOM_HALF		6
> +#define OPTEE_MSG_CMD_STOP_ASYNC_NOTIF		7
> +#define OPTEE_MSG_CMD_LEND_PROTMEM		8
> +#define OPTEE_MSG_CMD_RECLAIM_PROTMEM		9
> +#define OPTEE_MSG_CMD_GET_PROTMEM_CONFIG	10
> +#define OPTEE_MSG_CMD_ASSIGN_PROTMEM		11
> +#define OPTEE_MSG_FUNCID_CALL_WITH_ARG		0x0004
>  
>  #endif /* _OPTEE_MSG_H */
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index 879426300821..accf76a99288 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -264,7 +264,6 @@ struct optee_smc_get_shm_config_result {
>  #define OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM	BIT(0)
>  /* Secure world can communicate via previously unregistered shared memory */
>  #define OPTEE_SMC_SEC_CAP_UNREGISTERED_SHM	BIT(1)
> -
>  /*
>   * Secure world supports commands "register/unregister shared memory",
>   * secure world accepts command buffers located in any parts of non-secure RAM
> @@ -280,6 +279,10 @@ struct optee_smc_get_shm_config_result {
>  #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
>  /* Secure world supports probing for RPMB device if needed */
>  #define OPTEE_SMC_SEC_CAP_RPMB_PROBE		BIT(7)
> +/* Secure world supports protected memory */
> +#define OPTEE_SMC_SEC_CAP_PROTMEM		BIT(8)
> +/* Secure world supports dynamic protected memory */
> +#define OPTEE_SMC_SEC_CAP_DYNAMIC_PROTMEM	BIT(9)
>  
>  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
>  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> @@ -451,6 +454,38 @@ struct optee_smc_disable_shm_cache_result {
>  
>  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
>  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
> +/*
> + * Get protected memory config
> + *
> + * Returns the protected memory config.
> + *
> + * Call register usage:
> + * a0   SMC Function ID, OPTEE_SMC_GET_PROTMEM_CONFIG
> + * a2-6	Not used, must be zero
> + * a7	Hypervisor Client ID register
> + *
> + * Have config return register usage:
> + * a0	OPTEE_SMC_RETURN_OK
> + * a1	Physical address of start of protected memory
> + * a2	Size of protected memory
> + * a3	PA width, max 64
> + * a4-7	Preserved
> + *
> + * Not available register usage:
> + * a0	OPTEE_SMC_RETURN_ENOTAVAIL
> + * a1-3 Not used
> + * a4-7	Preserved
> + */
> +#define OPTEE_SMC_FUNCID_GET_PROTMEM_CONFIG		20
> +#define OPTEE_SMC_GET_PROTMEM_CONFIG \
> +	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_PROTMEM_CONFIG)
> +
> +struct optee_smc_get_protmem_config_result {
> +	unsigned long status;
> +	unsigned long start;
> +	unsigned long size;
> +	unsigned long pa_width;
> +};
>  
>  /*
>   * Resume from RPC (for example after processing a foreign interrupt)
> -- 
> 2.43.0
> 
