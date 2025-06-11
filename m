Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D82C61CE7
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 12:46:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8317A4544B
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 12:46:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 813E2413F6
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Jun 2025 12:45:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40AA515A1;
	Wed, 11 Jun 2025 05:45:24 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1D0C3F673;
	Wed, 11 Jun 2025 05:45:42 -0700 (PDT)
Date: Wed, 11 Jun 2025 13:45:39 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH] optee: ffa: fix sleep in atomic context
Message-ID: <20250611-kickass-tasteful-markhor-c6c7ff@sudeepholla>
References: <20250602120452.2507084-1-jens.wiklander@linaro.org>
 <aEl4kWxWexuskLGe@sumit-X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEl4kWxWexuskLGe@sumit-X1>
X-Spamd-Bar: -------
X-Spamd-Result: default: False [-7.40 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[217.140.110.172:from];
	R_SPF_ALLOW(-0.20)[+ip4:217.140.96.0/20];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:28939, ipnet:217.140.110.0/24, country:GB];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.727];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 813E2413F6
Message-ID-Hash: G7J7OYYDPUK5ZT5D77BDLWRXKFYHMKLC
X-Message-ID-Hash: G7J7OYYDPUK5ZT5D77BDLWRXKFYHMKLC
X-MailFrom: sudeep.holla@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Jerome Forissier <jerome.forissier@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G7J7OYYDPUK5ZT5D77BDLWRXKFYHMKLC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, Jun 11, 2025 at 06:07:37PM +0530, Sumit Garg wrote:
> On Mon, Jun 02, 2025 at 02:04:35PM +0200, Jens Wiklander wrote:
> > The OP-TEE driver registers the function notif_callback() for FF-A
> > notifications. However, this function is called in an atomic context
> > leading to errors like this when processing asynchronous notifications:
> > 
> >  | BUG: sleeping function called from invalid context at kernel/locking/mutex.c:258
> >  | in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9, name: kworker/0:0
> >  | preempt_count: 1, expected: 0
> >  | RCU nest depth: 0, expected: 0
> >  | CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.14.0-00019-g657536ebe0aa #13
> >  | Hardware name: linux,dummy-virt (DT)
> >  | Workqueue: ffa_pcpu_irq_notification notif_pcpu_irq_work_fn
> >  | Call trace:
> >  |  show_stack+0x18/0x24 (C)
> >  |  dump_stack_lvl+0x78/0x90
> >  |  dump_stack+0x18/0x24
> >  |  __might_resched+0x114/0x170
> >  |  __might_sleep+0x48/0x98
> >  |  mutex_lock+0x24/0x80
> >  |  optee_get_msg_arg+0x7c/0x21c
> >  |  simple_call_with_arg+0x50/0xc0
> >  |  optee_do_bottom_half+0x14/0x20
> >  |  notif_callback+0x3c/0x48
> >  |  handle_notif_callbacks+0x9c/0xe0
> >  |  notif_get_and_handle+0x40/0x88
> >  |  generic_exec_single+0x80/0xc0
> >  |  smp_call_function_single+0xfc/0x1a0
> >  |  notif_pcpu_irq_work_fn+0x2c/0x38
> >  |  process_one_work+0x14c/0x2b4
> >  |  worker_thread+0x2e4/0x3e0
> >  |  kthread+0x13c/0x210
> >  |  ret_from_fork+0x10/0x20
> > 
> > Fix this by adding work queue to process the notification in a
> > non-atomic context.
> > 
> > Fixes: d0476a59de06 ("optee: ffa_abi: add asynchronous notifications")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> 
> Forgot to mention, let's explicitly CC for stable kernel backport here.

Makes sense.

Jens,

Just FYI:

Here is the FF-A fix PR to Arnd if you need any reference:
https://lore.kernel.org/all/20250609105207.1185570-1-sudeep.holla@arm.com

I haven't tagged it for stable assuming Fixes: tag ones get selected and
also it is not trivial to apply. I do have the backports also ready to
send once merged upstream.

-- 
Regards,
Sudeep
