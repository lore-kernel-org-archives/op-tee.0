Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9766C677C4
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 12:36:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D48CC459E6
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1749645389;
	bh=DrBUTn44Zt4i4j2IzfBX9fV1hFit3GAeNfb3pYs26DY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=lgHZDUo78tubYPQExERBR3XnT0BggivRZHfjfQTbERLckJ2cSdEIOEosuLIhAawQ0
	 /CL1fzGbEuD3ollCRbNn++UjWVS/hucqb2RmNQZBJyl0/71sSne6lS4WfUIHCUFk0V
	 1KF+c4LFQ+2GyB20bMIJWXsSZNexUCJ4SEYKqg6M6tOJYuP7pLZCcZOfv6unQLTLb1
	 z5dzDie8n3J/s/VqaVm20TZ/DrfKk4cXM3jlNRTgPlx18RxZn1GYUBW0xUT/SziffL
	 jlAh5stbmvOlWjieWe8+FUslgVuFoJMLLbdZ0c0h/szePZ4ucdV4mrGFZ9iFxA9Q4G
	 tvGfIVSiCrE6Q==
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1E79F40928
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Jun 2025 12:36:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OWrfTS+V;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A4A8C5C576C;
	Wed, 11 Jun 2025 12:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D95C4CEEE;
	Wed, 11 Jun 2025 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645369;
	bh=DrBUTn44Zt4i4j2IzfBX9fV1hFit3GAeNfb3pYs26DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWrfTS+VIlBMUJjfxDheQ8gP/iGRNOF8GhLfUBIqzar3HF2vaB5C+UODE33eP2sGv
	 9xO38o770X9mWUpRoi0mfc8QFpRVH54wwRtMkhKfCOF1hf1VSySHd8nqGWINEk7f5Q
	 +3n0/bwSzUH1Di7AXaa69pZ37b+m9uzyjpe6Rl/hbGYeH5uksfgtg6BDIcHXre0IOa
	 Qv6Ox54/6XQU4AKlNW2hMd+5ybRRQm8JvdSpbhNORX7oPgut0O5RQLX1UTwXY0eDmm
	 l//FLaP0FrskCNoHf5QiILg0ysK0yGoxbYlC5VRoJjqKdXibfKVVmRO4gj6YYcYCRf
	 TwJTpTC587wVw==
Date: Wed, 11 Jun 2025 18:06:03 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH] optee: ffa: fix sleep in atomic context
Message-ID: <aEl4M0-xig8DbJvI@sumit-X1>
References: <20250602120452.2507084-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602120452.2507084-1-jens.wiklander@linaro.org>
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_IN_DNSWL_HI(-0.50)[139.178.84.217:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:139.178.84.217];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:54825, ipnet:139.178.80.0/21, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1E79F40928
Message-ID-Hash: ETDNBVQUIFAVNNG5EG4W6GOCPR56FDZG
X-Message-ID-Hash: ETDNBVQUIFAVNNG5EG4W6GOCPR56FDZG
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Jerome Forissier <jerome.forissier@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ETDNBVQUIFAVNNG5EG4W6GOCPR56FDZG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, Jun 02, 2025 at 02:04:35PM +0200, Jens Wiklander wrote:
> The OP-TEE driver registers the function notif_callback() for FF-A
> notifications. However, this function is called in an atomic context
> leading to errors like this when processing asynchronous notifications:
> 
>  | BUG: sleeping function called from invalid context at kernel/locking/mutex.c:258
>  | in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9, name: kworker/0:0
>  | preempt_count: 1, expected: 0
>  | RCU nest depth: 0, expected: 0
>  | CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.14.0-00019-g657536ebe0aa #13
>  | Hardware name: linux,dummy-virt (DT)
>  | Workqueue: ffa_pcpu_irq_notification notif_pcpu_irq_work_fn
>  | Call trace:
>  |  show_stack+0x18/0x24 (C)
>  |  dump_stack_lvl+0x78/0x90
>  |  dump_stack+0x18/0x24
>  |  __might_resched+0x114/0x170
>  |  __might_sleep+0x48/0x98
>  |  mutex_lock+0x24/0x80
>  |  optee_get_msg_arg+0x7c/0x21c
>  |  simple_call_with_arg+0x50/0xc0
>  |  optee_do_bottom_half+0x14/0x20
>  |  notif_callback+0x3c/0x48
>  |  handle_notif_callbacks+0x9c/0xe0
>  |  notif_get_and_handle+0x40/0x88
>  |  generic_exec_single+0x80/0xc0
>  |  smp_call_function_single+0xfc/0x1a0
>  |  notif_pcpu_irq_work_fn+0x2c/0x38
>  |  process_one_work+0x14c/0x2b4
>  |  worker_thread+0x2e4/0x3e0
>  |  kthread+0x13c/0x210
>  |  ret_from_fork+0x10/0x20
> 
> Fix this by adding work queue to process the notification in a
> non-atomic context.
> 
> Fixes: d0476a59de06 ("optee: ffa_abi: add asynchronous notifications")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/ffa_abi.c       | 41 ++++++++++++++++++++++++-------
>  drivers/tee/optee/optee_private.h |  2 ++
>  2 files changed, 34 insertions(+), 9 deletions(-)

Sounds reasonable fix to me, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index f3af5666bb11..f9ef7d94cebd 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -728,12 +728,21 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
>  	return true;
>  }
>  
> +static void notif_work_fn(struct work_struct *work)
> +{
> +	struct optee_ffa *optee_ffa = container_of(work, struct optee_ffa,
> +						   notif_work);
> +	struct optee *optee = container_of(optee_ffa, struct optee, ffa);
> +
> +	optee_do_bottom_half(optee->ctx);
> +}
> +
>  static void notif_callback(int notify_id, void *cb_data)
>  {
>  	struct optee *optee = cb_data;
>  
>  	if (notify_id == optee->ffa.bottom_half_value)
> -		optee_do_bottom_half(optee->ctx);
> +		queue_work(optee->ffa.notif_wq, &optee->ffa.notif_work);
>  	else
>  		optee_notif_send(optee, notify_id);
>  }
> @@ -817,9 +826,11 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
>  	struct optee *optee = ffa_dev_get_drvdata(ffa_dev);
>  	u32 bottom_half_id = optee->ffa.bottom_half_value;
>  
> -	if (bottom_half_id != U32_MAX)
> +	if (bottom_half_id != U32_MAX) {
>  		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
>  							      bottom_half_id);
> +		destroy_workqueue(optee->ffa.notif_wq);
> +	}
>  	optee_remove_common(optee);
>  
>  	mutex_destroy(&optee->ffa.mutex);
> @@ -835,6 +846,13 @@ static int optee_ffa_async_notif_init(struct ffa_device *ffa_dev,
>  	u32 notif_id = 0;
>  	int rc;
>  
> +	INIT_WORK(&optee->ffa.notif_work, notif_work_fn);
> +	optee->ffa.notif_wq = create_workqueue("optee_notification");
> +	if (!optee->ffa.notif_wq) {
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +
>  	while (true) {
>  		rc = ffa_dev->ops->notifier_ops->notify_request(ffa_dev,
>  								is_per_vcpu,
> @@ -851,19 +869,24 @@ static int optee_ffa_async_notif_init(struct ffa_device *ffa_dev,
>  		 * notifications in that case.
>  		 */
>  		if (rc != -EACCES)
> -			return rc;
> +			goto err_wq;
>  		notif_id++;
>  		if (notif_id >= OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE)
> -			return rc;
> +			goto err_wq;
>  	}
>  	optee->ffa.bottom_half_value = notif_id;
>  
>  	rc = enable_async_notif(optee);
> -	if (rc < 0) {
> -		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
> -							      notif_id);
> -		optee->ffa.bottom_half_value = U32_MAX;
> -	}
> +	if (rc < 0)
> +		goto err_rel;
> +
> +	return 0;
> +err_rel:
> +	ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev, notif_id);
> +err_wq:
> +	destroy_workqueue(optee->ffa.notif_wq);
> +err:
> +	optee->ffa.bottom_half_value = U32_MAX;
>  
>  	return rc;
>  }
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index dc0f355ef72a..9526087f0e68 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -165,6 +165,8 @@ struct optee_ffa {
>  	/* Serializes access to @global_ids */
>  	struct mutex mutex;
>  	struct rhashtable global_ids;
> +	struct workqueue_struct *notif_wq;
> +	struct work_struct notif_work;
>  };
>  
>  struct optee;
> -- 
> 2.43.0
> 
