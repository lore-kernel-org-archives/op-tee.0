Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C192CCFA13
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 14:32:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5AE2E449B2
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777645931;
	bh=iZ/hJTUpi+aX1WBl7fEGtWMv4Ev94DrYHERV5uFeUQQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=w9fjXuC4kw5Hcoi4/1KVU6E7ZX72dLX90rEcnGtBwLFLoH4r+RmitvkZvSsIH7TpA
	 s/dmM8Cj3iKuNWrss4RTyOvilybWtYXb+lkh8PNsT2BUIR9vvRH1nlgZOz222aj9ln
	 6RDvbRDXyb1hoibS8WvHz+fPMrdZV+zpnXQBpFO2XRxrsKHJ++XCjHkyG7FKB/nsL5
	 9MwR1UOI02t6mjqgGkmB1tRIC7y5Q5EBjZTU3ah5wvGV8wkJXfa4LxsG90ZUKg50MG
	 My2EyPWRhgC3tzyIGgHorRgmlAJDn6Af1dbWdHgVKS8Ax0D30qQfM/8hwF4pCw0ZSy
	 CQazZLcIXkeLA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8EDD843296
	for <op-tee@lists.trustedfirmware.org>; Fri,  1 May 2026 14:32:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eHWDzlOO;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D4C9E6011F;
	Fri,  1 May 2026 14:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB36C2BCC6;
	Fri,  1 May 2026 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777645923;
	bh=iZ/hJTUpi+aX1WBl7fEGtWMv4Ev94DrYHERV5uFeUQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHWDzlOOowbVvVmoAnO7TJwXKG4eHFCykPD63ZptMs/dHWoXw724IAXbvGjB23AOK
	 mbkdkyAyM8OTFEOa4NIQuxVnrzFR9cyOwk0cT6wPHWjYOb94HFLgaJgyAGW8SaT/MY
	 WKF0wkdbgmlEol/lv5fvBK6tZN02IqWLojeaOcOdBQpevTWWEq4MSLJClRj4dL0h5j
	 ZKDEiHR/Kh8Q2XqWkuo4TI2x/8WSrAySuNHgjwIx0bgrCAV3kBmGkeFt0UUQRlkTlV
	 Dr0c4J5fmykpVVGIUq+0tv1iXi7tig686en2BnByGmDdyOzwNFNzBR/9h2HisT1ktB
	 UZmV7O9c2W94w==
Date: Fri, 1 May 2026 20:01:59 +0530
To: Qihang <q.h.hack.winter@gmail.com>
Subject: Re: [PATCH] tee: fix missing shm reference cleanup in
 tee_ioctl_supp_recv
Message-ID: <afS5XzaeLUx1ngAl@sumit-xelite>
References: <CAHUa44E+b9SmT++XrrzSansAjMMhgxQLwCA-LmS-GMEugSmhSw@mail.gmail.com>
 <20260429113219.88452-1-q.h.hack.winter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429113219.88452-1-q.h.hack.winter@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8EDD843296
X-Spamd-Bar: ----
Message-ID-Hash: 6CYVCUKRCLS46SI53ZNZGOAV6GO3ZD3U
X-Message-ID-Hash: 6CYVCUKRCLS46SI53ZNZGOAV6GO3ZD3U
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6CYVCUKRCLS46SI53ZNZGOAV6GO3ZD3U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Apr 29, 2026 at 07:32:19PM +0800, Qihang wrote:
> params_from_user() acquires tee_shm references for MEMREF parameters and
> expects the caller to release those references with tee_shm_put() during
> cleanup.
> 
> tee_ioctl_open_session(), tee_ioctl_invoke(), and
> tee_ioctl_object_invoke() all do this, but tee_ioctl_supp_recv() only
> frees the parameter array and does not drop any acquired shared-memory
> references.
> 
> Fix this by using a common helper to release MEMREF references before
> freeing the parameter array, and apply it to tee_ioctl_supp_recv() as
> well.
> 
> Since supp_recv backends may update num_params, preserve the original
> allocated parameter count for cleanup.
> 
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
>  drivers/tee/tee_core.c | 49 +++++++++++++++++++-----------------------
>  1 file changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index ef9642d72672..adad1ea8e31b 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -530,6 +530,21 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
>  	return 0;
>  }
>  
> +static void params_free_decref(struct tee_param *params, size_t num_params)

I would rather rename this API as free_params().

> +{
> +	size_t n;
> +
> +	if (!params)
> +		return;
> +
> +	for (n = 0; n < num_params; n++)
> +		if (tee_param_is_memref(params + n) &&
> +		    params[n].u.memref.shm)
> +			tee_shm_put(params[n].u.memref.shm);
> +
> +	kfree(params);
> +}
> +
>  static int tee_ioctl_open_session(struct tee_context *ctx,
>  				  struct tee_ioctl_buf_data __user *ubuf)
>  {
> @@ -595,16 +610,7 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
>  	 */
>  	if (rc && have_session && ctx->teedev->desc->ops->close_session)
>  		ctx->teedev->desc->ops->close_session(ctx, arg.session);
> -
> -	if (params) {
> -		/* Decrease ref count for all valid shared memory pointers */
> -		for (n = 0; n < arg.num_params; n++)
> -			if (tee_param_is_memref(params + n) &&
> -			    params[n].u.memref.shm)
> -				tee_shm_put(params[n].u.memref.shm);
> -		kfree(params);
> -	}
> -
> +	params_free_decref(params, arg.num_params);
>  	return rc;
>  }
>  
> @@ -657,14 +663,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
>  	}
>  	rc = params_to_user(uparams, arg.num_params, params);
>  out:
> -	if (params) {
> -		/* Decrease ref count for all valid shared memory pointers */
> -		for (n = 0; n < arg.num_params; n++)
> -			if (tee_param_is_memref(params + n) &&
> -			    params[n].u.memref.shm)
> -				tee_shm_put(params[n].u.memref.shm);
> -		kfree(params);
> -	}
> +	params_free_decref(params, arg.num_params);
>  	return rc;
>  }
>  
> @@ -716,14 +715,7 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
>  	}
>  	rc = params_to_user(uparams, arg.num_params, params);
>  out:
> -	if (params) {
> -		/* Decrease ref count for all valid shared memory pointers */
> -		for (n = 0; n < arg.num_params; n++)
> -			if (tee_param_is_memref(params + n) &&
> -			    params[n].u.memref.shm)
> -				tee_shm_put(params[n].u.memref.shm);
> -		kfree(params);
> -	}
> +	params_free_decref(params, arg.num_params);
>  	return rc;
>  }
>  
> @@ -822,6 +814,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
>  	struct tee_iocl_supp_recv_arg __user *uarg;
>  	struct tee_param *params;
>  	u32 num_params;
> +	u32 alloc_num_params;
>  	u32 func;
>  
>  	if (!ctx->teedev->desc->ops->supp_recv)
> @@ -838,6 +831,8 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
>  	if (get_user(num_params, &uarg->num_params))
>  		return -EFAULT;
>  
> +	alloc_num_params = num_params;

Why is this needed? Shouldn't the updated num_params will point to size
of params array?

-Sumit

> +
>  	if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) != buf.buf_len)
>  		return -EINVAL;
>  
> @@ -861,7 +856,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
>  
>  	rc = params_to_supp(ctx, uarg->params, num_params, params);
>  out:
> -	kfree(params);
> +	params_free_decref(params, alloc_num_params);
>  	return rc;
>  }
>  
> -- 
> 2.39.5 (Apple Git-154)
> 
