Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B403FED2F4
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 09:05:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A298643958
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773306327;
	bh=m4uDAtFZFQ07189ElyBwtchCQM82UDykc/E8xZsG8zE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=i+SGYvKRwKTWX+yFn0EqKxIpePOyp3hPjeD3wDnJfpRA7ev91YRO+ylKpWUg7FKT7
	 rN5UtKn5ooap2wY5VypUQk+nYNxJy84H3qeCnR5nRcZE/JmCQTKv/7JNTu4MCh1Lj9
	 9g45cREBcEN76meK+KqWRxrohD7sgMAyex4gcUpzZY8FA7XRapHQji9rEfE1cf+oow
	 64EnhQMER0Cj6holuNLRhUYfAJmEtTyXtIofkjeMgeFtD+P6MCEp9dJvzeZam2twYs
	 0WMhtO5AUSRkmxE4FAkhMkcDy6LAP1/1BSK3QkxLMfwmvbgyRV7Qj+mInj3Wh7Af9L
	 Mgc6TOXqPbamA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CA06A43229
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Mar 2026 09:05:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=saxLpcJi;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A50D60054;
	Thu, 12 Mar 2026 09:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8128AC4CEF7;
	Thu, 12 Mar 2026 09:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773306305;
	bh=m4uDAtFZFQ07189ElyBwtchCQM82UDykc/E8xZsG8zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saxLpcJipPNfAN7OE8uDNd2jTB6qyb5c5byk6mwDtRrYfSzjdnCNeLhG5mkhO/PY+
	 cmY6tnZao0IijjxX2ZE83pw4+JXjzQGDXPHTwy9eUNLjtvEUA1hVR0lrWwneM+XVU5
	 Yp9BywUXXZ9qy9j5TW2R22zjEr4bP90+eT7LATtXNMsJLl0cpZaMG3bFBkcrE4ThfV
	 xdG13ZisvDNBMLDOtbEi6ZtydLsOBJHNRult7ph1RdZ+LrVEwJQF6H0zZcJgvTukWH
	 PZkAMby+DMtZ3SAymGUcXq+O7ZpSvjmyn4jMRdtkim6/TlCkF1GEVHCEyT6AIMApCo
	 mAdF/S7h19vaw==
Date: Thu, 12 Mar 2026 14:35:00 +0530
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] tee: clean up tee_core.h kernel-doc
Message-ID: <abKBvHRsJkeAm_Hq@sumit-xelite>
References: <20260311052953.313121-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311052953.313121-1-rdunlap@infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CA06A43229
X-Spamd-Bar: ---
Message-ID-Hash: 2CSDIUVKORTUUUNS4OEG5XKTSXJX76DZ
X-Message-ID-Hash: 2CSDIUVKORTUUUNS4OEG5XKTSXJX76DZ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2CSDIUVKORTUUUNS4OEG5XKTSXJX76DZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Mar 10, 2026 at 10:29:53PM -0700, Randy Dunlap wrote:
> Use the correct struct member name and function parameter name in
> kernel-doc comments.
> Move a macro that was between a struct's documentation and its
> declaration.
> These eliminate the following kernel-doc warnings:
> 
> Warning: include/linux/tee_core.h:73 struct member 'c_no_users' not
>  described in 'tee_device'
> Warning: include/linux/tee_core.h:132 #define TEE_DESC_PRIVILEGED
>      0x1; error: Cannot parse struct or union!
> Warning: include/linux/tee_core.h:257 function parameter 'connection_data'
>  not described in 'tee_session_calc_client_uuid'
> Warning: include/linux/tee_core.h:320 function parameter 'teedev'
>  not described in 'tee_get_drvdata'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: op-tee@lists.trustedfirmware.org
> 
>  include/linux/tee_core.h |   30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)

Thanks for the kernel-doc warnings fixes, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> --- linux-next-20260309.orig/include/linux/tee_core.h
> +++ linux-next-20260309/include/linux/tee_core.h
> @@ -50,7 +50,7 @@ enum tee_dma_heap_id {
>   * @dev:	embedded basic device structure
>   * @cdev:	embedded cdev
>   * @num_users:	number of active users of this device
> - * @c_no_user:	completion used when unregistering the device
> + * @c_no_users:	completion used when unregistering the device
>   * @mutex:	mutex protecting @num_users and @idr
>   * @idr:	register of user space shared memory objects allocated or
>   *		registered on this device
> @@ -132,6 +132,7 @@ struct tee_driver_ops {
>  /* Size for TEE revision string buffer used by get_tee_revision(). */
>  #define TEE_REVISION_STR_SIZE	128
>  
> +#define TEE_DESC_PRIVILEGED	0x1
>  /**
>   * struct tee_desc - Describes the TEE driver to the subsystem
>   * @name:	name of driver
> @@ -139,7 +140,6 @@ struct tee_driver_ops {
>   * @owner:	module providing the driver
>   * @flags:	Extra properties of driver, defined by TEE_DESC_* below
>   */
> -#define TEE_DESC_PRIVILEGED	0x1
>  struct tee_desc {
>  	const char *name;
>  	const struct tee_driver_ops *ops;
> @@ -187,7 +187,7 @@ struct tee_protmem_pool_ops {
>   * Allocates a new struct tee_device instance. The device is
>   * removed by tee_device_unregister().
>   *
> - * @returns a pointer to a 'struct tee_device' or an ERR_PTR on failure
> + * @returns: a pointer to a 'struct tee_device' or an ERR_PTR on failure
>   */
>  struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
>  				    struct device *dev,
> @@ -201,7 +201,7 @@ struct tee_device *tee_device_alloc(cons
>   * tee_device_unregister() need to be called to remove the @teedev if
>   * this function fails.
>   *
> - * @returns < 0 on failure
> + * @returns: < 0 on failure
>   */
>  int tee_device_register(struct tee_device *teedev);
>  
> @@ -254,14 +254,14 @@ void tee_device_set_dev_groups(struct te
>   * tee_session_calc_client_uuid() - Calculates client UUID for session
>   * @uuid:		Resulting UUID
>   * @connection_method:	Connection method for session (TEE_IOCTL_LOGIN_*)
> - * @connectuon_data:	Connection data for opening session
> + * @connection_data:	Connection data for opening session
>   *
>   * Based on connection method calculates UUIDv5 based client UUID.
>   *
>   * For group based logins verifies that calling process has specified
>   * credentials.
>   *
> - * @return < 0 on failure
> + * @returns: < 0 on failure
>   */
>  int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
> @@ -295,7 +295,7 @@ struct tee_shm_pool_ops {
>   * @paddr:	Physical address of start of pool
>   * @size:	Size in bytes of the pool
>   *
> - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
> + * @returns: pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
>   */
>  struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
>  						phys_addr_t paddr, size_t size,
> @@ -318,14 +318,16 @@ static inline void tee_shm_pool_free(str
>   * @paddr:	Physical address of start of pool
>   * @size:	Size in bytes of the pool
>   *
> - * @returns pointer to a 'struct tee_protmem_pool' or an ERR_PTR on failure.
> + * @returns: pointer to a 'struct tee_protmem_pool' or an ERR_PTR on failure.
>   */
>  struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t paddr,
>  						       size_t size);
>  
>  /**
>   * tee_get_drvdata() - Return driver_data pointer
> - * @returns the driver_data pointer supplied to tee_register().
> + * @teedev: Pointer to the tee_device
> + *
> + * @returns: the driver_data pointer supplied to tee_register().
>   */
>  void *tee_get_drvdata(struct tee_device *teedev);
>  
> @@ -334,7 +336,7 @@ void *tee_get_drvdata(struct tee_device
>   *                            TEE driver
>   * @ctx:	The TEE context for shared memory allocation
>   * @size:	Shared memory allocation size
> - * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
> + * @returns: a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
>   */
>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
>  
> @@ -354,7 +356,7 @@ void tee_dyn_shm_free_helper(struct tee_
>  /**
>   * tee_shm_is_dynamic() - Check if shared memory object is of the dynamic kind
>   * @shm:	Shared memory handle
> - * @returns true if object is dynamic shared memory
> + * @returns: true if object is dynamic shared memory
>   */
>  static inline bool tee_shm_is_dynamic(struct tee_shm *shm)
>  {
> @@ -370,7 +372,7 @@ void tee_shm_put(struct tee_shm *shm);
>  /**
>   * tee_shm_get_id() - Get id of a shared memory object
>   * @shm:	Shared memory handle
> - * @returns id
> + * @returns: id
>   */
>  static inline int tee_shm_get_id(struct tee_shm *shm)
>  {
> @@ -382,7 +384,7 @@ static inline int tee_shm_get_id(struct
>   * count
>   * @ctx:	Context owning the shared memory
>   * @id:		Id of shared memory object
> - * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
> + * @returns: a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
>   */
>  struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
>  
> @@ -402,7 +404,7 @@ static inline bool tee_param_is_memref(s
>   * teedev_open() - Open a struct tee_device
>   * @teedev:	Device to open
>   *
> - * @return a pointer to struct tee_context on success or an ERR_PTR on failure.
> + * @returns: pointer to struct tee_context on success or an ERR_PTR on failure.
>   */
>  struct tee_context *teedev_open(struct tee_device *teedev);
>  
