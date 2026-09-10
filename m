Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F405C79FB9
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 12:28:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3B24744FB8
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789043295;
	bh=o/DEm6hhOHxEiFxAOUmJzF/UqfDcU9pW2ZrALDBOWm0=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=4lx90jgouphNR+azUpu0U7pJTaoyNAObpX3cSaSxaQ8qbxmpWofaVh6/iAakCTG5p
	 yec4OOaURFRBfi0BH/Q9M+H8UY/SchtwE+sarduZg9irTGsBkC+uUYlfuF+A/5cWic
	 vWCI0AxW1KOFiPgNN4k+5L8vTdm0OneLZc1mQx63FD8rnfRgGvHmqWE6oFhaVa6vKy
	 ISFYQePbr9DKvrsOnAGQaX/5T2kmYv5sp2WZUExX/ojmbheibfjNiQ5JMUyqKYHbHC
	 2gGpIvRDb8H7S4M4qTgQHjkMvg7MAHO+NpeNGe3AtvEwNT1OkPkroKlQ4bMhLQH6we
	 1y6EUSjwk5dBw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 81002438BD
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 12:28:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rl49pUJs;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EC52D601EF;
	Thu, 10 Sep 2026 12:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DC31F000FF;
	Thu, 10 Sep 2026 12:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789043286;
	bh=Q4bEjgbDb1gv1JLReYYbY4ojuS+Q+1rIOLGJ2NmcYXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rl49pUJsVzyQA8U1Z+ZMUoVTDgcSij0YNm8p40enI061R8nMbyWSzGdGPUn5NLC6Z
	 82Zi5rYBwU4xP7IfFfv+8nJerbSjQ86wn4d7z0c2/AYv2XV3whr5WlN+j/GTjQtAR3
	 0Bk99bcPaTj2nWp592BBSVp+et02gxreJnTGgPt109knrXKbcqXUD3iy4QTCQY0KUy
	 iLhrg8fO+beH6aU4UtRKpMtzRoUm3jK9t21mvIXFy4WLNE2q0cjP2wbXFVL+NsSjSj
	 e8ZT3Fzt3K0PpuBgdYAC6Ixsx1oSXH3j3qhX7W3+GlLGR8dbIaIA0hepcXim+ygIDa
	 tB2urKdwrsDIg==
Date: Thu, 10 Sep 2026 17:58:02 +0530
To: Mahantesh Salimath <mahantesh@nvidia.com>
Subject: Re: [PATCH] tee: optee: ffa: support shared memory offsets on
 large-page kernels
Message-ID: <aqKiUthQ-swgP5q7@sumit-xelite>
Mail-Followup-To: Mahantesh Salimath <mahantesh@nvidia.com>,
	Jens Wiklander <jenswi@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20260904134732.1072541-1-mahantesh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260904134732.1072541-1-mahantesh@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 81002438BD
X-Spamd-Bar: --------
Message-ID-Hash: 7CXCML6M4EO7RACM3RNIE4OSIZTPVMHC
X-Message-ID-Hash: 7CXCML6M4EO7RACM3RNIE4OSIZTPVMHC
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7CXCML6M4EO7RACM3RNIE4OSIZTPVMHC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, 04 Sep 2026 at 13:47:32 +0000, Mahantesh Salimath wrote:
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
> drivers/tee/optee/ffa_abi.c   | 66 +++++++++++++++++++++++++++++------
> drivers/tee/optee/optee_msg.h |  4 +--
> 2 files changed, 57 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
>index 633715b98625..2a37e4899dc6 100644
>--- a/drivers/tee/optee/ffa_abi.c
>+++ b/drivers/tee/optee/ffa_abi.c
>@@ -187,6 +187,40 @@ static int optee_ffa_from_msg_param(struct optee *optee,
> 	return 0;
> }
>
>+/*
>+ * OP-TEE FF-A memory objects use 4 KiB pages while the kernel page size may
>+ * be larger, for example 64 KiB on arm64. The FF-A descriptor is registered
>+ * from the 4 KiB page containing the start of the shared buffer, so
>+ * internal_offs is the offset into that page.
>+ */
>+static void optee_ffa_set_internal_offs(struct optee_msg_param_fmem *fmem,
>+					struct tee_shm *shm)
>+{
>+	size_t page_offs = tee_shm_get_page_offset(shm);
>+
>+	BUILD_BUG_ON(PAGE_SIZE < FFA_PAGE_SIZE);
>+
>+	fmem->internal_offs = page_offs & (FFA_PAGE_SIZE - 1);
>+}
>+
>+/*
>+ * Keep shm_offs unchanged in offs_low/offs_high: it is returned to callers
>+ * and may be reused for a subsequent invocation.
>+ */
>+static int optee_ffa_set_fmem_offsets(struct optee_msg_param_fmem *fmem,
>+				      struct tee_shm *shm, u64 shm_offs)
>+{
>+	optee_ffa_set_internal_offs(fmem, shm);
>+
>+	fmem->offs_low = shm_offs;
>+	fmem->offs_high = shm_offs >> 32;
>+	/* Check that the entire offset could be stored. */
>+	if (fmem->offs_high != shm_offs >> 32)
>+		return -EINVAL;
>+
>+	return 0;
>+}
>+
> static int to_msg_param_ffa_mem(struct optee_msg_param *mp,
> 				const struct tee_param *p)
> {
>@@ -196,14 +230,8 @@ static int to_msg_param_ffa_mem(struct optee_msg_param *mp,
> 		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
>
> 	if (shm) {
>-		u64 shm_offs = p->u.memref.shm_offs;
>-
>-		mp->u.fmem.internal_offs = shm->offset;
>-
>-		mp->u.fmem.offs_low = shm_offs;
>-		mp->u.fmem.offs_high = shm_offs >> 32;
>-		/* Check that the entire offset could be stored. */
>-		if (mp->u.fmem.offs_high != shm_offs >> 32)
>+		if (optee_ffa_set_fmem_offsets(&mp->u.fmem, shm,
>+					       p->u.memref.shm_offs))
> 			return -EINVAL;
>

This all can rather be simplified below, lots of indirection here.

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 633715b98625..b9dcd2e2e28b 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -198,8 +198,8 @@ static int to_msg_param_ffa_mem(struct optee_msg_param *mp,
         if (shm) {
                 u64 shm_offs = p->u.memref.shm_offs;
  
-               mp->u.fmem.internal_offs = shm->offset;
-
+               mp->u.fmem.internal_offs = tee_shm_get_page_offset(shm) &
+                                          (FFA_PAGE_SIZE - 1);
                 mp->u.fmem.offs_low = shm_offs;
                 mp->u.fmem.offs_high = shm_offs >> 32;
                 /* Check that the entire offset could be stored. */

> 		mp->u.fmem.global_id = shm->sec_world_id;
>@@ -284,14 +312,30 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> 		.nattrs = 1,
> 	};
> 	struct sg_table sgt;
>+	size_t page_offs;
>+	size_t ffa_offs;
>+	size_t ffa_size;
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
>+	page_offs = tee_shm_get_page_offset(shm);
>+	ffa_offs = round_down(page_offs, FFA_PAGE_SIZE);
>+	ffa_size = num_pages * PAGE_SIZE - ffa_offs;

Avoid redundant variables which are used only once.

>+
>+	/*
>+	 * Start the FF-A descriptor at the 4 KiB page containing the shared
>+	 * buffer, skipping unused leading 4 KiB pages when PAGE_SIZE is
>+	 * larger. Same approach as optee_fill_pages_list() in the SMC ABI.
>+	 * This leaves only page_offs & (FFA_PAGE_SIZE - 1) for internal_offs.
>+	 */
>+	rc = sg_alloc_table_from_pages(&sgt, pages, num_pages, ffa_offs,
>+				       ffa_size, GFP_KERNEL);
> 	if (rc)
> 		return rc;
> 	args.sg = sgt.sgl;
>@@ -458,8 +502,8 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> 		.attr = OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT,
> 		.u.fmem.size = tee_shm_get_size(shm),
> 		.u.fmem.global_id = shm->sec_world_id,
>-		.u.fmem.internal_offs = shm->offset,
> 	};
>+	optee_ffa_set_internal_offs(&arg->params[0].u.fmem, shm);

Ditto, directly inline the masking here.

-Sumit

>
> 	arg->ret = TEEC_SUCCESS;
> }
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
