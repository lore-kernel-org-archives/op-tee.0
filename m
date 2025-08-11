Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D4FC87FDA
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 06:13:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DFB4D4FC9A
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754892838;
	bh=LnPCD5wQWfe5ewQuYs5Ji2os16OC0uw92HZs4chNN6Y=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=y2QyKx3TLWiurgfEws8lZu49Ecs+LJFe36u2GoPgxghOrgPudR40C+e58nFOpkFGy
	 AHg6xVefRWjuH/mD4K2GFF+8mqXrZyimJkouHsnqtit6V2HVuG+C1nwHR8wj/LexQO
	 hMqueJRJfa1QelcaAtTS/aJ5NZpIqpdCRs0q6mKGHDYxPcreTvRFLWRYN5Er/ex07x
	 BjsHGAjUwZp+SKrj9F0C1oOSaxc5/lLdkCoFufqhTC9PgV4rY8SVEW5U6hnbQAvRr4
	 0Sn43WTB2s+YpVqeRahAn7uiGW+dUEUSFDYbQGieKtw2oDXw4mObCIy2spQyQrh5dR
	 JE5MjJ1p+LeLA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ACFFF3F08F
	for <op-tee@lists.trustedfirmware.org>; Mon, 11 Aug 2025 06:13:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XdExNfS8;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 30A7F601D1;
	Mon, 11 Aug 2025 06:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB26DC4CEED;
	Mon, 11 Aug 2025 06:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754892822;
	bh=LnPCD5wQWfe5ewQuYs5Ji2os16OC0uw92HZs4chNN6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdExNfS82bYgbvYkazYD5Uca3vV525KEhs2Ec9BJUVqX9itC+3aNzhRqI0Na5Q+ym
	 Cna1s1ttn1b/iAFMF5AK8f8uXlPrvEIogzcVxTbyzYY5bNxtYW5u03kY2NHC2QK6Lj
	 D0ad0rPk5i/9ilAtjvCynVZkD46ucAXWSJQ7krj3/gw1FNPg5ibNqX0fQnKx/vWYWI
	 skmBqB7HKQMPq0sopiAHlRXbqAyg27nqBkMNc5QXihGtcPpLCI5PiFeZwqelbHxvmp
	 w97tZxlrXGimx55YtNHf39NI1kKnOLo1qfXeFmuv7zrrbeIoEiJDq5IKDVsXH9+TxF
	 KS+INLsfOw17w==
Date: Mon, 11 Aug 2025 11:43:35 +0530
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] tee: Use SHA-1 library instead of crypto_shash
Message-ID: <aJmKDyD4weX9bR0U@sumit-X1>
References: <20250801235541.14050-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801235541.14050-1-ebiggers@kernel.org>
X-Rspamd-Queue-Id: ACFFF3F08F
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: TMCP4NXZY5YJPWHNMNFHGMS7PWQS6S6P
X-Message-ID-Hash: TMCP4NXZY5YJPWHNMNFHGMS7PWQS6S6P
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TMCP4NXZY5YJPWHNMNFHGMS7PWQS6S6P/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, Aug 01, 2025 at 04:55:41PM -0700, Eric Biggers wrote:
> Use the SHA-1 library functions instead of crypto_shash.  This is
> simpler and faster.
> 
> Change uuid_v5() to return void, since it can no longer fail.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> Note: this patch depends on the SHA-1 library functions that were merged
> in v6.17-rc1.
> 
>  drivers/tee/Kconfig    |  3 +--
>  drivers/tee/tee_core.c | 55 +++++++-----------------------------------
>  2 files changed, 10 insertions(+), 48 deletions(-)

Nice cleanup, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index 61b507c187801..a84767940fbfc 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -1,12 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # Generic Trusted Execution Environment Configuration
>  menuconfig TEE
>  	tristate "Trusted Execution Environment support"
>  	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
> -	select CRYPTO
> -	select CRYPTO_SHA1
> +	select CRYPTO_LIB_SHA1
>  	select DMA_SHARED_BUFFER
>  	select GENERIC_ALLOCATOR
>  	help
>  	  This implements a generic interface towards a Trusted Execution
>  	  Environment (TEE).
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index acc7998758ad8..d079aeee0690a 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -12,11 +12,10 @@
>  #include <linux/module.h>
>  #include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/tee_core.h>
>  #include <linux/uaccess.h>
> -#include <crypto/hash.h>
>  #include <crypto/sha1.h>
>  #include "tee_private.h"
>  
>  #define TEE_NUM_DEVICES	32
>  
> @@ -140,72 +139,36 @@ static int tee_release(struct inode *inode, struct file *filp)
>   * UUIDv5 is specific in RFC 4122.
>   *
>   * This implements section (for SHA-1):
>   * 4.3.  Algorithm for Creating a Name-Based UUID
>   */
> -static int uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> -		   size_t size)
> +static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> +		    size_t size)
>  {
>  	unsigned char hash[SHA1_DIGEST_SIZE];
> -	struct crypto_shash *shash = NULL;
> -	struct shash_desc *desc = NULL;
> -	int rc;
> -
> -	shash = crypto_alloc_shash("sha1", 0, 0);
> -	if (IS_ERR(shash)) {
> -		rc = PTR_ERR(shash);
> -		pr_err("shash(sha1) allocation failed\n");
> -		return rc;
> -	}
> -
> -	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
> -		       GFP_KERNEL);
> -	if (!desc) {
> -		rc = -ENOMEM;
> -		goto out_free_shash;
> -	}
> -
> -	desc->tfm = shash;
> +	struct sha1_ctx ctx;
>  
> -	rc = crypto_shash_init(desc);
> -	if (rc < 0)
> -		goto out_free_desc;
> -
> -	rc = crypto_shash_update(desc, (const u8 *)ns, sizeof(*ns));
> -	if (rc < 0)
> -		goto out_free_desc;
> -
> -	rc = crypto_shash_update(desc, (const u8 *)name, size);
> -	if (rc < 0)
> -		goto out_free_desc;
> -
> -	rc = crypto_shash_final(desc, hash);
> -	if (rc < 0)
> -		goto out_free_desc;
> +	sha1_init(&ctx);
> +	sha1_update(&ctx, (const u8 *)ns, sizeof(*ns));
> +	sha1_update(&ctx, (const u8 *)name, size);
> +	sha1_final(&ctx, hash);
>  
>  	memcpy(uuid->b, hash, UUID_SIZE);
>  
>  	/* Tag for version 5 */
>  	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
>  	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
> -
> -out_free_desc:
> -	kfree(desc);
> -
> -out_free_shash:
> -	crypto_free_shash(shash);
> -	return rc;
>  }
>  
>  int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
>  {
>  	gid_t ns_grp = (gid_t)-1;
>  	kgid_t grp = INVALID_GID;
>  	char *name = NULL;
>  	int name_len;
> -	int rc;
> +	int rc = 0;
>  
>  	if (connection_method == TEE_IOCTL_LOGIN_PUBLIC ||
>  	    connection_method == TEE_IOCTL_LOGIN_REE_KERNEL) {
>  		/* Nil UUID to be passed to TEE environment */
>  		uuid_copy(uuid, &uuid_null);
> @@ -258,11 +221,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  	default:
>  		rc = -EINVAL;
>  		goto out_free_name;
>  	}
>  
> -	rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> +	uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
>  out_free_name:
>  	kfree(name);
>  
>  	return rc;
>  }
> 
> base-commit: 0905809b38bda1fa0b206986c44d846e46f13c1d
> -- 
> 2.50.1
> 
