Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33641C982ED
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 12:25:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4D75445386
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789993513;
	bh=Y5U2M0IMBc45XTMcbO64QLv1LrJr5qtSmRYz5xM4BsQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Al3Dc564GQm4liU/NbpN8WFJLZ3nNYIv8d93YM1bxq+8FrqGYfTbu7rrrW33F59/i
	 6udqeb6J70TEix3I2yzmgnC4AHg3RTgXrAZa1JBwd7MZCuYdawMMguZZ7mcLFYhWSI
	 ag/uQB5IGVJNP/Ijek0m12v3bNJReavo29hZB3pfHxvGe9HcKtR07YmHEKFDIGsrYX
	 G6zwes1Ni9T2KCuH15dTn2fdM7ZQWMM810oK7gqzK8DnflNY3XcJmfSQWbNNZTjvbn
	 zTlyAGRRItgQKuHLkMbrJdJ+lYaztRjzO8ATmewneinZeioyj16Oyotjlwz6M3Tutt
	 fl3Z4hi+sUr3g==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F2C744449D
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 12:25:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNj6P50U;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D40B600C8;
	Mon, 21 Sep 2026 12:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD7A1F000FF;
	Mon, 21 Sep 2026 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993505;
	bh=1M6p5SOy+SM0nOL2SmY16j3B6xH1lik+zLKQU4/iFH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iNj6P50UtRgQl2RU7gqsAGidmnThd6QdCIOvkbBRbf/0BE6OIZbomw4twQQLLngqD
	 P7lpuahOvCgxP8soBxNKczoacZ+EFeAgzvxVhBt32IRjBsO0PtRyyR/N5I08ozroKm
	 VvLogotQf7osq6E+/NWiXZ56nqljL2IBMhC5cnf2LMhwWHfunbfHh5OC+bXC4Zt5Us
	 +uxXmWX1m8g7mI/9piFMSd+RquSont/e8ZEJV2GDjO60IXL58wZemyMZRbSldqHxcC
	 XA4KZrvSeV/mCrC+J05Jrnb9TmvnQz6vTf0OkXjmvbSiWhXTgQD9LLKDekoO0kVqaN
	 ynpT0Ib1KJpcg==
Date: Mon, 21 Sep 2026 17:55:00 +0530
To: Mahantesh Salimath <mahantesh@nvidia.com>
Subject: Re: [PATCH v2] tee: optee: ffa: support shared memory offsets on
 large-page kernels
Message-ID: <arEiHFtNB3p6g4WB@sumit-xelite>
Mail-Followup-To: Mahantesh Salimath <mahantesh@nvidia.com>,
	Jens Wiklander <jenswi@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20260904134732.1072541-1-mahantesh@nvidia.com>
 <20260910161124.1561170-1-mahantesh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260910161124.1561170-1-mahantesh@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F2C744449D
X-Spamd-Bar: ------
Message-ID-Hash: P3WCI4MEQZK3TEVRM3DH6JWLPZCBWPN3
X-Message-ID-Hash: P3WCI4MEQZK3TEVRM3DH6JWLPZCBWPN3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/P3WCI4MEQZK3TEVRM3DH6JWLPZCBWPN3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, 10 Sep 2026 at 16:11:24 +0000, Mahantesh Salimath wrote:
>OP-TEE FF-A memory objects use 4 KiB pages, while the kernel page
>size may be larger. Consequently, tee_shm->offset can be greater than
>or equal to FFA_PAGE_SIZE, but OP-TEE rejects such a value in
>internal_offs.
>
>Do not encode the excess page offset in offs_low/offs_high. Those
>fields describe the logical memref offset and are copied back into
>tee_param->shm_offs on return. Folding the page offset into them breaks
>parameter round trips when a memref is reused. They are also ignored by
>the OPTEE_RPC_CMD_SHM_ALLOC response path, which uses only global_id and
>internal_offs to construct the shared-memory mobj.
>
>Instead, start the FF-A descriptor at the 4 KiB page containing the
>shared buffer, the same approach as optee_fill_pages_list() in the SMC
>ABI. Store the remaining in-page offset in internal_offs and preserve
>shm_offs in offs_low/offs_high. This keeps internal_offs within the
>FF-A page size, maps RPC allocations at the correct address, and
>preserves normal memref offsets across repeated invocations.
>
>Tested on ARMv8-A with 64 KiB PAGE_SIZE. OP-TEE OS ran as a secure
>partition under Hafnium (SPMC) over FF-A. Verified registered shared
>memory with tee_shm->offset >= 4 KiB, memref reuse on the same
>TEEC_Operation, and RPC OPTEE_RPC_CMD_SHM_ALLOC (xtest regression
>6007-6009). optee_hello_world, optee_aes, and xtest regression 1005,
>1007, 1008, 4001-4003 and 6001-6003 also passed.
>
>Fixes: 4615e5a34b95 ("optee: add FF-A support")
>Acked-by: Liming Sun <limings@nvidia.com>
>Acked-by: James Hurley <jahurley@nvidia.com>
>Acked-by: Dave Thompson <davthompson@nvidia.com>
>Signed-off-by: Mahantesh Salimath <mahantesh@nvidia.com>
>---
>v2:
>- Drop helper indirection; mask internal_offs inline (Sumit Garg)
>- Keep a single ffa_offs local in optee_ffa_shm_register()
>
>Link: https://lore.kernel.org/lkml/20260904134732.1072541-1-mahantesh@nvidia.com/
>
> drivers/tee/optee/ffa_abi.c   | 22 ++++++++++++++++++----
> drivers/tee/optee/optee_msg.h |  4 ++--
> 2 files changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
>index 633715b98625..fdedcab50f23 100644
>--- a/drivers/tee/optee/ffa_abi.c
>+++ b/drivers/tee/optee/ffa_abi.c
>@@ -198,7 +198,8 @@ static int to_msg_param_ffa_mem(struct optee_msg_param *mp,
> 	if (shm) {
> 		u64 shm_offs = p->u.memref.shm_offs;
>
>-		mp->u.fmem.internal_offs = shm->offset;
>+		mp->u.fmem.internal_offs = tee_shm_get_page_offset(shm) &
>+					   (FFA_PAGE_SIZE - 1);
>
> 		mp->u.fmem.offs_low = shm_offs;
> 		mp->u.fmem.offs_high = shm_offs >> 32;
>@@ -284,14 +285,26 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> 		.nattrs = 1,
> 	};
> 	struct sg_table sgt;
>+	size_t ffa_offs;
> 	int rc;
>
>+	if (!num_pages)
>+		return -EINVAL;
>+
> 	rc = optee_check_mem_type(start, num_pages);
> 	if (rc)
> 		return rc;
>
>-	rc = sg_alloc_table_from_pages(&sgt, pages, num_pages, 0,
>-				       num_pages * PAGE_SIZE, GFP_KERNEL);
>+	/*
>+	 * Start the FF-A descriptor at the 4 KiB page containing the shared
>+	 * buffer, skipping unused leading 4 KiB pages when PAGE_SIZE is
>+	 * larger. Same approach as optee_fill_pages_list() in the SMC ABI.
>+	 * This leaves only the offset into that 4 KiB page for internal_offs.
>+	 */
>+	ffa_offs = round_down(tee_shm_get_page_offset(shm), FFA_PAGE_SIZE);
>+	rc = sg_alloc_table_from_pages(&sgt, pages, num_pages, ffa_offs,
>+				       num_pages * PAGE_SIZE - ffa_offs,
>+				       GFP_KERNEL);
> 	if (rc)
> 		return rc;
> 	args.sg = sgt.sgl;
>@@ -458,7 +471,8 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> 		.attr = OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT,
> 		.u.fmem.size = tee_shm_get_size(shm),
> 		.u.fmem.global_id = shm->sec_world_id,
>-		.u.fmem.internal_offs = shm->offset,
>+		.u.fmem.internal_offs = tee_shm_get_page_offset(shm) &
>+					(FFA_PAGE_SIZE - 1),
> 	};
>
> 	arg->ret = TEEC_SUCCESS;
>diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
>index 7d9b12e71c03..6c3043f8da33 100644
>--- a/drivers/tee/optee/optee_msg.h
>+++ b/drivers/tee/optee/optee_msg.h
>@@ -136,8 +136,8 @@ struct optee_msg_param_rmem {
>  * struct optee_msg_param_fmem - FF-A memory reference parameter
>  * @offs_low:		lower bits of offset into shared memory reference
>  * @offs_high:		higher bits of offset into shared memory reference
>- * @internal_offs:	internal offset into the first page of shared memory
>- *			reference
>+ * @internal_offs:	offset into the first 4 KiB page of the FF-A shared
>+ *			memory region
>  * @size:		size of the buffer
>  * @global_id:		global identifier of the shared memory
>  */
>-- 
>2.43.0
>
