Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E665BC83F26
	for <op-tee@archiver.kernel.org>; Tue, 29 Jul 2025 09:28:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2E75C43111
	for <op-tee@archiver.kernel.org>; Tue, 29 Jul 2025 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1753781291;
	bh=+0s+HjDr+e7ICK4hmchmjiUogqHAoKWfG974lL09Jtk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=a4zj1WnfnsEw6tUVdBRS3oCnNWADVdV5FD/0PfG6LO6/oYw9og0swt26+eTfKbCj3
	 4Ca0CrXtEpZMV6NKvR7aA6Um/GIN9LzFJFIfYUPBA0tXLazfNDXpjNaBI5FRC88vJi
	 +ZFsv0G9VQHohIpR7st/yVaGMJHcHkKhAOI++mXFvGxBa5eIljkLTiT44w0uDY6UFR
	 i9XuJuNMTcsWdKeCKXPeWdrKo0ihpcwyzXyfvcWcEY9pobRHU1M9Vwry6QSc3wBTpf
	 UzNj5sVHStYkb/ey6lew81mu8TuDTQE82pvGAlT04wHwpWfZ8lvkjiMrP7RBqtWR9l
	 Gpw1ys/XFFVqQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2A95D40AAD
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Jul 2025 09:27:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MAH4sVpl;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9E00A601F2;
	Tue, 29 Jul 2025 09:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBFFC4CEF5;
	Tue, 29 Jul 2025 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753781270;
	bh=+0s+HjDr+e7ICK4hmchmjiUogqHAoKWfG974lL09Jtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAH4sVplXov3SKYIxe48/h6d9MSUjjOX/iAawbq2KfVInw8ToD6mdIoKPkgz1pWsI
	 a1SjEBCzjOcLahb6qBd9WyD08J3qMQDEENdMLqPEWsKTPNEleqHHm2Xxp9o3SF+o+j
	 jEykkws7jxKIolZmB/Y5do3nLstYHqEIe89c7dG/QHtqqOFgjXITlMCQKSJTNTb8nG
	 yikCB0COrmPh9VK1hmMmnSNYZCTF4EpKIrF9si+Cb3Z1cObFeHO+5XKLRGRWWFxJ8P
	 BmPJHuEDsBHVPGFDiA0Noz6VQRXKLEFx1ERjUrLbW0XgabYqv0nq9x/fEN97MTXQPf
	 Vnw5/5ixomrqA==
Date: Tue, 29 Jul 2025 14:57:44 +0530
To: Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] tee: fix memory leak in tee_dyn_shm_alloc_helper
Message-ID: <aIiUEGt2uVF9yi1W@sumit-X1>
References: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
X-Rspamd-Queue-Id: 2A95D40AAD
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[172.105.4.254:from];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: ZJIG5JIRUXBH3DWZH26UEW3O4Q4KSNOX
X-Message-ID-Hash: ZJIG5JIRUXBH3DWZH26UEW3O4Q4KSNOX
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZJIG5JIRUXBH3DWZH26UEW3O4Q4KSNOX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Jul 23, 2025 at 02:22:41PM +0800, Pei Xiao wrote:
> When shm_register() fails in tee_dyn_shm_alloc_helper(), the pre-allocated
> pages array is not freed, resulting in a memory leak.
> 
> Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/tee/tee_shm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 915239b033f5..2a7d253d9c55 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -230,7 +230,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
>  	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>  	if (!pages) {
>  		rc = -ENOMEM;
> -		goto err;
> +		goto err_pages;
>  	}
>  
>  	for (i = 0; i < nr_pages; i++)
> @@ -243,11 +243,13 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
>  		rc = shm_register(shm->ctx, shm, pages, nr_pages,
>  				  (unsigned long)shm->kaddr);
>  		if (rc)
> -			goto err;
> +			goto err_kfree;
>  	}
>  
>  	return 0;
> -err:
> +err_kfree:
> +	kfree(pages);
> +err_pages:
>  	free_pages_exact(shm->kaddr, shm->size);
>  	shm->kaddr = NULL;
>  	return rc;
> -- 
> 2.25.1
> 
