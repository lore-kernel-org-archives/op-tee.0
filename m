Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB025C79F9F
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 09:13:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E6AB4438BD
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789031637;
	bh=nMZBoNXkQlQS/WPoABbPQUqiyJGDCgy6yHUOVaPwAbI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yFzxVI8vodspdq+I7Xk5ISYw+JoRqLb55ge/OsPLQAyJ7Y/n+y/OQ2LuoEY9dKwpN
	 cG0EyYLhmUQ3nFLrx+xRxLkALMlRbzJJi/eAz/JA9us3bcFzDlj0dKq9TGui0RKr8U
	 OVHJts1QrMeWgkG1kW2zm2v02zMMm9EH12Q0nHshlcPfkLrOQNnXIRUBSfdZrvq9ER
	 2G/7xKLqtT32UM0hHPQuOvvy9M8RQ5w+U3kRVbCyc2E/kShtO5n3chEXycpf3xMc73
	 1QsB8Evrx5MfK1x9jLHbyuezEOxvvOrQBMhGq6wNu9kN+QsI1opwSsUJd8GtaN2+ZD
	 miUCJYi7cPGWg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 04F72438BD
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 09:13:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJIptjZR;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 48C74600CB;
	Thu, 10 Sep 2026 09:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2872B1F000FF;
	Thu, 10 Sep 2026 09:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031629;
	bh=56FTR3CNCz14tunVZgA5Dwrb7IctTYvmcWBAPlPQ+CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CJIptjZRuGOqBFRKmUXA4yyCOtMnBCId91HOnDqrpUv04nqO8lkxk9B8AJTz22VAc
	 SpDh/DNy6Y86gzqcP+5WXOiHM4wZJjaZxkMsruEvXPX45o7KXXuBS7g+yMvjJypx6b
	 1KdY/PZ6TIxtVseUMq6hy4Ng2QHgN7Iqq0N+KRQ/MMznqskpZ64kL1yHuSHZVmsWo8
	 a4dzHpjIFThSin9Fg9Ua6WeQ3hgtVGjrJ53swlaBTlLzt5PXOO2mEOK6dy+sVlFnXZ
	 r3T9L4QwKit372bhw+lGxS+LHXF6p4E2Kb6+8HErBMFA6BiB08jFXvt8TIY2YYsDWO
	 bxdJoczzAGvUw==
Date: Thu, 10 Sep 2026 14:43:44 +0530
To: Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] tee: move tee_ioctl_shm_register_data to above IOCTL
 definition
Message-ID: <aqJ0yCHd03ZLsSMT@sumit-xelite>
Mail-Followup-To: Andrew Davis <afd@ti.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20260903175730.1909952-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260903175730.1909952-1-afd@ti.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	URIBL_BLOCKED(0.00)[tor.source.kernel.org:helo,tor.source.kernel.org:rdns,sumit-xelite:mid,qualcomm.com:email];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 04F72438BD
X-Spamd-Bar: --------
Message-ID-Hash: T7XR2YYVXK7A5TFXE76COO2IJYKFBJGR
X-Message-ID-Hash: T7XR2YYVXK7A5TFXE76COO2IJYKFBJGR
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@linaro.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/T7XR2YYVXK7A5TFXE76COO2IJYKFBJGR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, 03 Sep 2026 at 12:57:30 -0500, Andrew Davis via OP-TEE wrote:
>Most of the struct definitions for a given IOCTL definition immediately
>preceded that definition. The struct tee_ioctl_shm_register_data is an
>exception as it is placed above the TEE_IOC_SHM_REGISTER_FD definition,
>not the TEE_IOC_SHM_REGISTER one it is to be used with. Move it down
>to match the others.
>
>This is a non-functional change for consistency and to help prevent
>someone from accidentally using the wrong struct with the wrong IOCTL
>based on the struct's location.
>
>Fix a couple small spelling issues while here.
>
>Signed-off-by: Andrew Davis <afd@ti.com>
>---
> include/uapi/linux/tee.h | 40 ++++++++++++++++++++--------------------
> 1 file changed, 20 insertions(+), 20 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
>index 5203977ed35d1..76815b0f4b665 100644
>--- a/include/uapi/linux/tee.h
>+++ b/include/uapi/linux/tee.h
>@@ -384,24 +384,6 @@ struct tee_iocl_supp_send_arg {
> #define TEE_IOC_SUPPL_SEND	_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE + 7, \
> 				     struct tee_ioctl_buf_data)
>
>-/**
>- * struct tee_ioctl_shm_register_data - Shared memory register argument
>- * @addr:      [in] Start address of shared memory to register
>- * @length:    [in/out] Length of shared memory to register
>- * @flags:     [in/out] Flags to/from registration.
>- * @id:                [out] Identifier of the shared memory
>- *
>- * The flags field should currently be zero as input. Updated by the call
>- * with actual flags as defined by TEE_IOCTL_SHM_* above.
>- * This structure is used as argument for TEE_IOC_SHM_REGISTER below.
>- */
>-struct tee_ioctl_shm_register_data {
>-	__u64 addr;
>-	__u64 length;
>-	__u32 flags;
>-	__s32 id;
>-};
>-
> /**
>  * struct tee_ioctl_shm_register_fd_data - Shared memory registering argument
>  * @fd:		[in] File descriptor identifying dmabuf reference
>@@ -426,13 +408,31 @@ struct tee_ioctl_shm_register_fd_data {
>  * Returns a file descriptor on success or < 0 on failure
>  *
>  * The returned file descriptor refers to the shared memory object in the
>- * kernel. The supplied file deccriptor can be closed if it's not needed
>+ * kernel. The supplied file descriptor can be closed if it's not needed
>  * for other purposes. The shared memory is freed when the descriptor is
>  * closed.
>  */
> #define TEE_IOC_SHM_REGISTER_FD	_IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + 8, \
> 				     struct tee_ioctl_shm_register_fd_data)
>
>+/**
>+ * struct tee_ioctl_shm_register_data - Shared memory register argument
>+ * @addr:      [in] Start address of shared memory to register
>+ * @length:    [in/out] Length of shared memory to register
>+ * @flags:     [in/out] Flags to/from registration.
>+ * @id:                [out] Identifier of the shared memory
>+ *
>+ * The flags field should currently be zero as input. Updated by the call
>+ * with actual flags as defined by TEE_IOCTL_SHM_* above.
>+ * This structure is used as argument for TEE_IOC_SHM_REGISTER below.
>+ */
>+struct tee_ioctl_shm_register_data {
>+	__u64 addr;
>+	__u64 length;
>+	__u32 flags;
>+	__s32 id;
>+};
>+
> /**
>  * TEE_IOC_SHM_REGISTER - Register shared memory argument
>  *
>@@ -440,7 +440,7 @@ struct tee_ioctl_shm_register_fd_data {
>  *
>  * Returns a file descriptor on success or < 0 on failure
>  *
>- * The shared memory is unregisterred when the descriptor is closed.
>+ * The shared memory is unregistered when the descriptor is closed.
>  */
> #define TEE_IOC_SHM_REGISTER   _IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + 9, \
> 				     struct tee_ioctl_shm_register_data)
>-- 
>2.39.2
>
