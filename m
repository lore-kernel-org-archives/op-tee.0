Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8A5C79F9F
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 09:23:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4E4F0453B1
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789032222;
	bh=3h6dOaWn9MbzfnZmkrI8RhpI7ycb2SvYmH3VMy/0T0s=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=fcKj8bXPm/xNrzeJ1zqjuNsoqKQ7h5JXMO7wOHkgjDMd2DAZu1NQ4KZbQN6ZDPK7A
	 wuTKpiFHytU+1sSw06zUPr+SrplTFtCoq2dCtt6xYpnQeo2zzNaGOZnoEzNpMs6Hmh
	 e9i2AczG73t6d8PJplcqpqn7CsQC1n7Mz8qF4iWTtmXF0YyC8kVcbydbEYrgRpr/iB
	 pz9wDcmdmXAYy0XJAzH9pn/kSUCGAYvhoDjKdVHXo05r1v9K7TjTCNZKfpOFHpWcp4
	 ka07cZ7UDl8wJ72fhwgG6a6+mtiAjcBEM3wM1hUWri9i1uFrB1SrcbVo6cDq5mRgMW
	 ZU79IOYicitXg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 17CD6438BD
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 09:23:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyTwAc6e;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7E16F43CD2;
	Thu, 10 Sep 2026 09:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75811F000FF;
	Thu, 10 Sep 2026 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789032215;
	bh=CBK8bp8Jw50Wx0Cwsv2CkCMUmnFWUqrGVXgO0hUGIS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KyTwAc6e4cH6wmMAK6Eff7Xf/UtjdaC6WVegf0hPGjlFCvdXAk2PxaTHv/Yt6xf5l
	 g3jFLEwiU0oaNIyLtL+jj/uQfAuS3pE9fYss/H4MQtVC8jTExP7RugNZy/eJtMcNaD
	 ZJYoZ4boZCuxsbH4pkAeGvZzgLpVeMehgecE+b54EtjS0mpaR7fv/3DiDO49nanO0p
	 Kuq56QNnZI0txYJmjY1eVJX/9hyXIT/075/d72MU0g8T8R9dmyl4lzcrDQKrFzSApG
	 1dOgQok6BPDKoC4Lwpmw1bvcQ4Z7/CvLAGxYVdqu7NTTMEfQYZ6uE57sOr0cHITz2h
	 q983vXA6+WzvQ==
Date: Thu, 10 Sep 2026 14:53:31 +0530
To: Andrew Davis <afd@ti.com>
Subject: Re: [PATCH RESEND] tee: move tee_ioctl_shm_register_data to above
 IOCTL definition
Message-ID: <aqJ3E4-vfMWhuQxU@sumit-xelite>
Mail-Followup-To: Andrew Davis <afd@ti.com>,
	Jens Wiklander <jenswi@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20260903181251.1912165-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260903181251.1912165-1-afd@ti.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	RCPT_COUNT_THREE(0.00)[4];
	URIBL_BLOCKED(0.00)[qualcomm.com:email,sea.source.kernel.org:helo,sea.source.kernel.org:rdns,ti.com:email,sumit-xelite:mid];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 17CD6438BD
X-Spamd-Bar: --------
Message-ID-Hash: KICPRLX4ZQXVWXI7IYZQJW5WVAX5FLUX
X-Message-ID-Hash: KICPRLX4ZQXVWXI7IYZQJW5WVAX5FLUX
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KICPRLX4ZQXVWXI7IYZQJW5WVAX5FLUX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>


On Thu, 03 Sep 2026 at 13:12:51 -0500, Andrew Davis wrote:
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
>
>Resending using folks updated emails :)

Ah, I see this update now. FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
> include/uapi/linux/tee.h | 40 ++++++++++++++++++++--------------------
> 1 file changed, 20 insertions(+), 20 deletions(-)
>
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
