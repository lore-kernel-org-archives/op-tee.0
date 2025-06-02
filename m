Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35956C54FB3
	for <op-tee@archiver.kernel.org>; Mon,  2 Jun 2025 13:10:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5586B430F4
	for <op-tee@archiver.kernel.org>; Mon,  2 Jun 2025 13:10:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sR+uTZPn;
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 715733F5C7
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Jun 2025 13:09:48 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6060167af73so2937416eaf.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Jun 2025 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748869788; x=1749474588; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/Jz2vE9PVNcBTZfUPANqH9BqmezRo4SDyod1ybA4Vo=;
        b=sR+uTZPnSDfMoLHVJ1yknCGt2Cg/tpI8y9NBaHlF4yEcOsSlYEjC+YPOyYT5Gj2ASw
         nYOm+YnZzbuEYWRrquvB3JRcK4tL4J78IcJjXLirOxe1ST9+yS5RadWjCYOQ3twZkVCX
         5LxsxUodzenLkx+0RK7LdRTlJfgeqv7KoElUacVchx2C1MZpuj1critQvXqs8p6qqh2R
         3H5Q5F97v51/FGkBC6sNv04YEYE45AFCcYehhgXq0dA2j03WrhIl+v8RBVVYHZUXAIr/
         YTaehwLXOdwiFwCpd0sdvprW52j8RoOvW6Hf9KRm20gYMOaIMv4tHbiXTXljE88rCgst
         XoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748869788; x=1749474588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/Jz2vE9PVNcBTZfUPANqH9BqmezRo4SDyod1ybA4Vo=;
        b=nbNW/V3DYAw7dSse+HLKzdJTzBlMmlOdwKSsj7v8KqETSNJU3LOOicl09ql6XPvOXQ
         /jmOdvTmqiAuYYsTBb9eDlun8ZJrhkjEZkodrAfDqxsivk++0/2leRMVbzs+h+LLT7mD
         YqAtJnAfT3Dl69EY+pGEo+SHUUF1jVpWXNVEfQhIsrcGfaPiekBbiHxhmnlFegvyoqN3
         jmi0fpidqTjJfJZYc60gPHkstHUZ+EiXM5yVWt55XFyupbUlfHL2Kv3QCHVRzBghn+gC
         78ncSJRZ6I9Km10pKXxioxozzeKAJWGrnFNATe/U904YdZ5Sc/QXsiNd4EdKZKydoOFk
         QUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0qUv5U4/Y7LYLz/5N2kbkfvwlj2gWIEodNsbj9rxFkc15yKENFB162jTcIRv9KTjVVyfwOns=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzUCaEK5HjaPlMxgyNtquXirw9bTKLg9ZkuZEbHWOW1J1tsXyQH
	ucVx5mHrMcjIcyJsMwUuz3eviWVGw7aeKQcJ0d4EljpCY+dJ6LOhpShCu2hd7QD9r6mEvLmKpiv
	JShWwKvPEbbxy+qUWuxTSVKus5BoEE6R/MaJgb3lc8tLC
X-Gm-Gg: ASbGncua2wOWm79WndWd4klvvX03bER24TK66XSKao5o4ypivIhb8r/CV5COqCFqADq
	XMNq5bQEJadSQzyS4NnTbd5awQng39WgWUoOJ1PMyDfHkrt35OoGux7DlXhPdGdrYHc3NOM0eta
	fB8doFGSo6adDLJW+vW09abo1WPiB7w/35gM3D9ELQWMFZ
X-Google-Smtp-Source: AGHT+IHTjNSdjeXDfvmEB3lwO3Jgq/sm+fHVDUnof7ctPCj/IJHQJL4Bs6nWj0e4owqqx+Bh20vn5ZIiuDseUBkWHDE=
X-Received: by 2002:a05:6820:1b13:b0:60e:d57b:ecc3 with SMTP id
 006d021491bc7-60ed57c0312mr3586678eaf.0.1748869787784; Mon, 02 Jun 2025
 06:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250602120452.2507084-1-jens.wiklander@linaro.org>
In-Reply-To: <20250602120452.2507084-1-jens.wiklander@linaro.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 2 Jun 2025 15:09:35 +0200
X-Gm-Features: AX0GCFupjJsZcZO2k5M59kOiSK2QNXg0EFsJQ9rIsXUhBmuRxKZl8Nat8RoQym0
Message-ID: <CAHUa44F3a+iWYy2+uKasc7ob-6rbUojQe1GJmmVCtfWrPMTT7Q@mail.gmail.com>
Subject: Re: [PATCH] optee: ffa: fix sleep in atomic context
To: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.46:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.46:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.161.46:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 715733F5C7
Message-ID-Hash: 46SUAJ6F3XZHHBE5IS5L2ARVS3PNGO4N
X-Message-ID-Hash: 46SUAJ6F3XZHHBE5IS5L2ARVS3PNGO4N
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jerome Forissier <jerome.forissier@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Sumit Garg <sumit.garg@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/46SUAJ6F3XZHHBE5IS5L2ARVS3PNGO4N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

[CC Sumit Garg <sumit.garg@kernel.org>]

Cheers,
Jens

On Mon, Jun 2, 2025 at 2:05=E2=80=AFPM Jens Wiklander <jens.wiklander@linar=
o.org> wrote:
>
> The OP-TEE driver registers the function notif_callback() for FF-A
> notifications. However, this function is called in an atomic context
> leading to errors like this when processing asynchronous notifications:
>
>  | BUG: sleeping function called from invalid context at kernel/locking/m=
utex.c:258
>  | in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9, name: kworke=
r/0:0
>  | preempt_count: 1, expected: 0
>  | RCU nest depth: 0, expected: 0
>  | CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.14.0-00019-g65753=
6ebe0aa #13
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
>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index f3af5666bb11..f9ef7d94cebd 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -728,12 +728,21 @@ static bool optee_ffa_exchange_caps(struct ffa_devi=
ce *ffa_dev,
>         return true;
>  }
>
> +static void notif_work_fn(struct work_struct *work)
> +{
> +       struct optee_ffa *optee_ffa =3D container_of(work, struct optee_f=
fa,
> +                                                  notif_work);
> +       struct optee *optee =3D container_of(optee_ffa, struct optee, ffa=
);
> +
> +       optee_do_bottom_half(optee->ctx);
> +}
> +
>  static void notif_callback(int notify_id, void *cb_data)
>  {
>         struct optee *optee =3D cb_data;
>
>         if (notify_id =3D=3D optee->ffa.bottom_half_value)
> -               optee_do_bottom_half(optee->ctx);
> +               queue_work(optee->ffa.notif_wq, &optee->ffa.notif_work);
>         else
>                 optee_notif_send(optee, notify_id);
>  }
> @@ -817,9 +826,11 @@ static void optee_ffa_remove(struct ffa_device *ffa_=
dev)
>         struct optee *optee =3D ffa_dev_get_drvdata(ffa_dev);
>         u32 bottom_half_id =3D optee->ffa.bottom_half_value;
>
> -       if (bottom_half_id !=3D U32_MAX)
> +       if (bottom_half_id !=3D U32_MAX) {
>                 ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
>                                                               bottom_half=
_id);
> +               destroy_workqueue(optee->ffa.notif_wq);
> +       }
>         optee_remove_common(optee);
>
>         mutex_destroy(&optee->ffa.mutex);
> @@ -835,6 +846,13 @@ static int optee_ffa_async_notif_init(struct ffa_dev=
ice *ffa_dev,
>         u32 notif_id =3D 0;
>         int rc;
>
> +       INIT_WORK(&optee->ffa.notif_work, notif_work_fn);
> +       optee->ffa.notif_wq =3D create_workqueue("optee_notification");
> +       if (!optee->ffa.notif_wq) {
> +               rc =3D -EINVAL;
> +               goto err;
> +       }
> +
>         while (true) {
>                 rc =3D ffa_dev->ops->notifier_ops->notify_request(ffa_dev=
,
>                                                                 is_per_vc=
pu,
> @@ -851,19 +869,24 @@ static int optee_ffa_async_notif_init(struct ffa_de=
vice *ffa_dev,
>                  * notifications in that case.
>                  */
>                 if (rc !=3D -EACCES)
> -                       return rc;
> +                       goto err_wq;
>                 notif_id++;
>                 if (notif_id >=3D OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE)
> -                       return rc;
> +                       goto err_wq;
>         }
>         optee->ffa.bottom_half_value =3D notif_id;
>
>         rc =3D enable_async_notif(optee);
> -       if (rc < 0) {
> -               ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
> -                                                             notif_id);
> -               optee->ffa.bottom_half_value =3D U32_MAX;
> -       }
> +       if (rc < 0)
> +               goto err_rel;
> +
> +       return 0;
> +err_rel:
> +       ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev, notif_id);
> +err_wq:
> +       destroy_workqueue(optee->ffa.notif_wq);
> +err:
> +       optee->ffa.bottom_half_value =3D U32_MAX;
>
>         return rc;
>  }
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index dc0f355ef72a..9526087f0e68 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -165,6 +165,8 @@ struct optee_ffa {
>         /* Serializes access to @global_ids */
>         struct mutex mutex;
>         struct rhashtable global_ids;
> +       struct workqueue_struct *notif_wq;
> +       struct work_struct notif_work;
>  };
>
>  struct optee;
> --
> 2.43.0
>
