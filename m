Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418CECA5FCB
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:46:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7143245416
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790858798;
	bh=ZVo574l+B2ceBlnyUHqv3njhm8W0ZsI/TflcQGJ2gg8=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Te9Ae4q1bWzOQTfkAzStkEph9nGaflVBBOICqKoHaeoss3aHlnwp60uX95hTQrDqt
	 KtD/glsJ91+l0WkFutKYu3ALlVYqWKl6pKTUHSLCm1N9DOCYTvxxp0D65L6MvpP1PB
	 UichRg5kez7aAfsn02e2nvva6FYZ3gnzcOxUd7K1mRepIlRZZ3QzTQQApcp8aIRUtz
	 m+JTc0F+9Dndp2EJ3K0VRLJy6FbjPaKdAxIyIuHJfHmNbj8CYYDEd3kfX8AGHCNJY1
	 u7htu6BzfI05e4SYQUER3CowK3kCIBikMfp1xB+qeXWFCc74AfwUuRibk3y11XVsk4
	 M9Ozcu8LlRJDw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7B18F3E882
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 12:46:31 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IE3+OzXl;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BEB7F41591;
	Thu,  1 Oct 2026 12:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4132B1F000FF;
	Thu,  1 Oct 2026 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858790;
	bh=h6t6ly3RWQcrMYeDssmderTujtT/pnC/r0uUggP8a0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IE3+OzXlxssqlUXJy3f3XyvVBeIF6LlPosZQIpOvJ9YDuW4w/Nz3lcatySRd/lRcF
	 B3RJpZmZi8T1b020q4OcKwnDOVFshX4RbOzBXejKudHqCOj8Y4ldAvZp8UPkmNPSxf
	 AKiXKKdn+doqFh1cWtez7ofwQbgXTY3DQVIlgLBoPpjWU7/nEr4db2d7rEawZbYGmW
	 ROIedk2JRzzQOirYBcKaotRG266CCGAt0aG00A7lLnqYNhmliRYyv4S3zAXIfxQU/q
	 6AiYewQTufYDqbvcNNfo5T+KrcE4VMya+qLL/S+Og+Ud9ZpGTgGs5ZWdfI0uiE7vbK
	 NPWjuaQtn0p5w==
Date: Thu, 1 Oct 2026 18:16:22 +0530
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/6] tee: Export uuidv5 generation for TEE backends
Message-ID: <ar5WHsyKFhIn_L4m@sumit-xelite>
Mail-Followup-To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
	Basant Kumar <basantk@qti.qualcomm.com>,
	Apurupa Pattapu <apurupa@qti.qualcomm.com>,
	Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
References: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
 <20261001-qcom_uefisecapp_migrate_qcomtee-v3-4-13df5c20c2e3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-4-13df5c20c2e3@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received,172.234.252.31:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7B18F3E882
X-Spamd-Bar: ------
Message-ID-Hash: 3OUD5LQDV4F6NGVEAMHKX7RVTXHR3DVT
X-Message-ID-Hash: 3OUD5LQDV4F6NGVEAMHKX7RVTXHR3DVT
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3OUD5LQDV4F6NGVEAMHKX7RVTXHR3DVT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, 01 Oct 2026 at 16:32:36 +0530, Harshal Dev wrote:
>Export the uuidv5() function defined in the TEE core to all TEE backends.
>This enables the TEE backend drivers to generate a UUID for identifying
>and registering their secure services on the TEE bus.
>
>Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>---
> drivers/tee/tee_core.c   |  9 +++++----
> include/linux/tee_core.h | 15 +++++++++++++++
> 2 files changed, 20 insertions(+), 4 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>index a03a3d645dd1..2cfd302d1393 100644
>--- a/drivers/tee/tee_core.c
>+++ b/drivers/tee/tee_core.c
>@@ -135,7 +135,7 @@ static int tee_release(struct inode *inode, struct file *filp)
> }
>
> /**
>- * uuid_v5() - Calculate UUIDv5
>+ * tee_generate_uuid_v5() - Calculate UUIDv5
>  * @uuid: Resulting UUID
>  * @ns: Name space ID for UUIDv5 function
>  * @name: Name for UUIDv5 function
>@@ -146,8 +146,8 @@ static int tee_release(struct inode *inode, struct file *filp)
>  * This implements section (for SHA-1):
>  * 4.3.  Algorithm for Creating a Name-Based UUID
>  */
>-static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>-		    size_t size)
>+void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>+			  size_t size)
> {
> 	unsigned char hash[SHA1_DIGEST_SIZE];
> 	struct sha1_ctx ctx;
>@@ -163,6 +163,7 @@ static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> 	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
> 	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
> }
>+EXPORT_SYMBOL_GPL(tee_generate_uuid_v5);
>
> int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> 				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
>@@ -228,7 +229,7 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> 		goto out_free_name;
> 	}
>
>-	uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
>+	tee_generate_uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> out_free_name:
> 	kfree(name);
>
>diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>index bcb5418d6fdc..a3f4f88b8423 100644
>--- a/include/linux/tee_core.h
>+++ b/include/linux/tee_core.h
>@@ -272,6 +272,21 @@ void tee_device_set_dev_groups(struct tee_device *teedev,
> int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> 				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
>
>+/**
>+ * tee_generate_uuid_v5() - Calculate UUIDv5
>+ * @uuid: Resulting UUID
>+ * @ns: Name space ID for UUIDv5 function
>+ * @name: Name for UUIDv5 function
>+ * @size: Size of name
>+ *
>+ * UUIDv5 is specific in RFC 4122.
>+ *
>+ * This implements section (for SHA-1):
>+ * 4.3.  Algorithm for Creating a Name-Based UUID
>+ */
>+void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>+			  size_t size);
>+
> /**
>  * struct tee_shm_pool - shared memory pool
>  * @ops:		operations
>
>-- 
>2.34.1
>
