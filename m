Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9710AC61CE8
	for <op-tee@archiver.kernel.org>; Thu, 12 Jun 2025 09:59:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AE2B243091
	for <op-tee@archiver.kernel.org>; Thu, 12 Jun 2025 09:59:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SvxxkxiN;
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2FC9D3F762
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Jun 2025 09:58:56 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2ea2fee5471so420156fac.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 12 Jun 2025 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749722335; x=1750327135; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po4IEoRQLPY5l28IDQlv6VRr1krpMVzYLaWwpJlY3yA=;
        b=SvxxkxiNvTWxq554wcBCtR1sYby3cJIPLaUDeEWlSPApMTw1jTw6Hg74yBzbLeEOOq
         bDqcK5dgeNQ7Biw/Xg5UIbT/fsWtDztoiv5JusjUpUq7r8UfylBnjkgh3xUd9hG/ECyz
         exESPjg7IyCtYFJrFsHb44wrklcPuD6DePBOZXDkeLgCMBqmSmwgEHarkbXpfsCw7T2p
         ektBDPpLWvoEMBdRCtpX09onF4eiLrHEQlvB/ZxMe0TZ9pyqfPZL4z3Tj9cvjS1RkjvR
         mIg+n5KrB3jiTGdOhuDMLFWwq9N/zsHy61LkzZ2bqrk8LsEA3QDjd7lcB/nEvxfpXZJl
         ZvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749722335; x=1750327135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Po4IEoRQLPY5l28IDQlv6VRr1krpMVzYLaWwpJlY3yA=;
        b=irQE1VQveEbTYGzuuvMwU8rnJEfBhOGAw96MfsfOEPfrla88mxsypW4Sj2EKTnrkm9
         mFf4h7VZjATVN9jce8fPz+bjr44g23Tcdoxqb1499g1tjkTjC+zPPmSaYhXpW2NXU+Lp
         ooCzx+XZg3nHFGdlju8AuFQrYgbcw24351emxK4NcDY63Va5AA08yX9lPygy0YHzZstd
         prGzjuamYYvnNYsy2zErpEjj8rXEvIufbBzOcGqnstVqtDdxa2MiOP88XE+ClU0PGeWQ
         rmKTMdpJc/4lKzXQnQr44je2V+RAbxafPHdV/YoIXEC1CdOPwYKJ7E/CvNy3RUnIvvBm
         LN8g==
X-Forwarded-Encrypted: i=1; AJvYcCU38rpIocPTnXnBtJhhLaY7xEZbqrvwS2xRPhUnfDbktYzlig1sidNmXtPjw5FIwJHKee5Id9U=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwM/ifG+qYIltt6LE5KGBAZ7x2g0R9jTfNvOo9tZ8xYe8bkg8M1
	TeAhQ/6fvvXEZzbXdELiPDiHB86fk0BpoNNmLbqthDejqgL22H89ELMW+jnm5+G2iD+BDrA0B00
	OKcnrFY8wJlqtQRw2OTAdhFewAXxGVrSLs9JyBUtwcvZd
X-Gm-Gg: ASbGncvGaG8j1Hz7Gu+tnJyJuw9YbUPTZJnjiD8cZoArY+LMIFoqwxIqYZoWoi7VB6o
	XTz1fuE48KtfSwcqLlUzF+uXyq+1sLPqlsagW+eVKn0g2pP1A2cLedwKtM3USV4mWrgLco7/sp5
	EUKcJ24RwZzYGftcVF8kF2ywfzIB2DDH0l3UbHfXYjBh7La/ze7kWBHAg=
X-Google-Smtp-Source: AGHT+IHPbTfaTOnczpg0ZwUWnHd1ERjdedmAN7MWpJ2f9rXZoce1pOJvnqgECVv1SJ7P8usCkFvRVf0PqHAc3v2YtBA=
X-Received: by 2002:a05:6870:9689:b0:2e4:c5c8:707b with SMTP id
 586e51a60fabf-2eab404c0efmr1591234fac.6.1749722335408; Thu, 12 Jun 2025
 02:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250602120452.2507084-1-jens.wiklander@linaro.org>
 <aEl4kWxWexuskLGe@sumit-X1> <20250611-kickass-tasteful-markhor-c6c7ff@sudeepholla>
In-Reply-To: <20250611-kickass-tasteful-markhor-c6c7ff@sudeepholla>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 12 Jun 2025 11:58:43 +0200
X-Gm-Features: AX0GCFszVanXSrhQjN2aA7WJFvOnpLcTZ6RuvbO4nWsjnpX6MpHRI2Ht2d_1WBI
Message-ID: <CAHUa44E3d0p9r2a3qzJ7Kx7pA07tTJfxur_pKg_5SerCkegfFg@mail.gmail.com>
Subject: Re: [PATCH] optee: ffa: fix sleep in atomic context
To: Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: --------
X-Spamd-Result: default: False [-8.10 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.52:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.52:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2FC9D3F762
Message-ID-Hash: PC64UPOOQPDZDJ22EWBQ3TEJIQUEC5E7
X-Message-ID-Hash: PC64UPOOQPDZDJ22EWBQ3TEJIQUEC5E7
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Jerome Forissier <jerome.forissier@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PC64UPOOQPDZDJ22EWBQ3TEJIQUEC5E7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, Jun 11, 2025 at 2:45=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Wed, Jun 11, 2025 at 06:07:37PM +0530, Sumit Garg wrote:
> > On Mon, Jun 02, 2025 at 02:04:35PM +0200, Jens Wiklander wrote:
> > > The OP-TEE driver registers the function notif_callback() for FF-A
> > > notifications. However, this function is called in an atomic context
> > > leading to errors like this when processing asynchronous notification=
s:
> > >
> > >  | BUG: sleeping function called from invalid context at kernel/locki=
ng/mutex.c:258
> > >  | in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9, name: kw=
orker/0:0
> > >  | preempt_count: 1, expected: 0
> > >  | RCU nest depth: 0, expected: 0
> > >  | CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.14.0-00019-g6=
57536ebe0aa #13
> > >  | Hardware name: linux,dummy-virt (DT)
> > >  | Workqueue: ffa_pcpu_irq_notification notif_pcpu_irq_work_fn
> > >  | Call trace:
> > >  |  show_stack+0x18/0x24 (C)
> > >  |  dump_stack_lvl+0x78/0x90
> > >  |  dump_stack+0x18/0x24
> > >  |  __might_resched+0x114/0x170
> > >  |  __might_sleep+0x48/0x98
> > >  |  mutex_lock+0x24/0x80
> > >  |  optee_get_msg_arg+0x7c/0x21c
> > >  |  simple_call_with_arg+0x50/0xc0
> > >  |  optee_do_bottom_half+0x14/0x20
> > >  |  notif_callback+0x3c/0x48
> > >  |  handle_notif_callbacks+0x9c/0xe0
> > >  |  notif_get_and_handle+0x40/0x88
> > >  |  generic_exec_single+0x80/0xc0
> > >  |  smp_call_function_single+0xfc/0x1a0
> > >  |  notif_pcpu_irq_work_fn+0x2c/0x38
> > >  |  process_one_work+0x14c/0x2b4
> > >  |  worker_thread+0x2e4/0x3e0
> > >  |  kthread+0x13c/0x210
> > >  |  ret_from_fork+0x10/0x20
> > >
> > > Fix this by adding work queue to process the notification in a
> > > non-atomic context.
> > >
> > > Fixes: d0476a59de06 ("optee: ffa_abi: add asynchronous notifications"=
)
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> >
> > Forgot to mention, let's explicitly CC for stable kernel backport here.
>
> Makes sense.

Sure, I'll fix up the commit message before sending the PR.

>
> Jens,
>
> Just FYI:
>
> Here is the FF-A fix PR to Arnd if you need any reference:
> https://lore.kernel.org/all/20250609105207.1185570-1-sudeep.holla@arm.com

Good

Thanks,
Jens

>
> I haven't tagged it for stable assuming Fixes: tag ones get selected and
> also it is not trivial to apply. I do have the backports also ready to
> send once merged upstream.
>
> --
> Regards,
> Sudeep
