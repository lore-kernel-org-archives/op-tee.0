Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF04BD37E51
	for <op-tee@archiver.kernel.org>; Wed, 14 Jan 2026 15:44:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 39C68432AA
	for <op-tee@archiver.kernel.org>; Wed, 14 Jan 2026 15:44:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p8Pi2rS7;
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CF55B434A8
	for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 15:43:27 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4511f736011so596565b6e.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768405407; x=1769010207; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wMjDfcfs+IBbY/GhNO+cfTG6sERqqYeHjGRwRJkVQI=;
        b=p8Pi2rS7X7UDVqM7L/QH605pGllQqMH2M+Y4qCwJ2W6SM5FCwTTxiOw7P3kWDDcjtl
         DE0Ce13U2+8w6wfdMFnUFroV0M8WWzfhBHH6HcOwnuPxWNtGM3KOxY6mEiMWbQCJHJFQ
         QbUjy/RCXAlwrCX4FEJx415QOkvrzLgn++eec9KTI2WhWQDDc4CJlo09A0zI+/Tw918j
         BFKeJKMQPnqlDhu7WmFyViBgeQ3VitzEISMtAXaaCS7ijDQBtM/blSzCUGPrkJUD5uWD
         apIilugsSeE9RPRkfqLNNtpEONG9qjUQozSwlDmo6gL6ZriVY3cO3KBe1xTBZ4xzpS4f
         br1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405407; x=1769010207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/wMjDfcfs+IBbY/GhNO+cfTG6sERqqYeHjGRwRJkVQI=;
        b=nwMIoIVMuWNRpGDAt8E5RBCrkIfCs3kiEPSXTKJkAQhKpQMd6GesUD0WNxHdyQrAUG
         mT/N8y4ZUf7NehyZiRR69o0BPki5fSYlLYNh/Agz6GCMOSRaBPPHfd/CQP+xQKphpasK
         1UCKNJnTwyAx/uywSuSrvNA+aLv4RbGreNFsOD9rkfNwK4k5O8lb02wz5q+Fh9bYcPTO
         1uMAY7/a7Wp0kLuYOlF/tTx22JdCO8EJ5UTn9HX9ARpEXTb/wxGkVRJ5OizHfw8FnoAD
         M8lJh3m/9zWeSrUgOEFl2Lw+tmV5EY7A6YceHUj9a3nyGxFFOZYoUqQH87F6Uq6Q5IUb
         kQzg==
X-Forwarded-Encrypted: i=1; AJvYcCX6sPuodCyxPGAUcc4eFC1c25b9kvHZlUVM4cEvnWZi6M+OyI9w3j6u3u/6gOOZWMb8RPXPJ9Q=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxBMyDRADRxeWhhy2Gpx/xn/goGtr+D5OI8DlElwJn3w+58ALH9
	gq4oGcajPLj2ZC9O9oeGhmB8FSot+4hi8YnNsENIYmtYxcoRTP2b5DfVYgP1emHKfFjkuiV9S4Y
	ejaxyyTkaFUjkhr5ZbjVt2/7JN2McgSR3d/mpZhqdN+1n
X-Gm-Gg: AY/fxX5bqV2/roiKpp8CGn8k9GLmc6nSuf7YmOqrSLwqxEVsMySlk1xLO/qeSC09qCg
	hBhMAdMTw/tR53YksbiZ8l79hOq95tDxRWAAmGr/sWmYc2DyyzGElSqDUuEDGpGexiu5HE0JsZN
	kMrR+BSNXFQY9XwW/fwh1Z5wZC6Wj1OR7j0uber9iX8MUP/FbeCDmz4O+V5887U9g5jGwN85cil
	ulb7OxsQeSA2pNMTqpfaE2SP3tn77vVFqvhOCUNt3vfgGZdqPn8I8rAqnKzdUtYrkwdDTlKYpra
	7gHv/awqFUwQ2xe+ddX/pxRqLw==
X-Received: by 2002:a05:6808:138b:b0:44f:f5de:5519 with SMTP id
 5614622812f47-45c71418d21mr2615649b6e.18.1768405407124; Wed, 14 Jan 2026
 07:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20260108064517.13854-1-aristo.chen@canonical.com>
 <20260112154833.78546-1-aristo.chen@canonical.com> <20260112154833.78546-2-aristo.chen@canonical.com>
In-Reply-To: <20260112154833.78546-2-aristo.chen@canonical.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 14 Jan 2026 16:43:15 +0100
X-Gm-Features: AZwV_Qg8xIzZ7TOy_QKBJITrtitPEqSWUD1Vt5ouGKNZnnyOZX9TCEGwbeQaIYA
Message-ID: <CAHUa44F0YH0otzmNnnLBJpeChBR6ZO10_9cERidAobRSOPARMA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] tee: optee: store OS revision for TEE core
To: Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.181:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.181:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CF55B434A8
X-Spamd-Bar: --
Message-ID-Hash: 5L3ZNTSM5IHXSRR2TLZHNQDNEZLQQG5Q
X-Message-ID-Hash: 5L3ZNTSM5IHXSRR2TLZHNQDNEZLQQG5Q
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5L3ZNTSM5IHXSRR2TLZHNQDNEZLQQG5Q/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Jan 12, 2026 at 4:48=E2=80=AFPM Aristo Chen <aristo.chen@canonical.=
com> wrote:
>
> Collect OP-TEE OS revision from secure world for both SMC and FF-A
> ABIs, store it in the OP-TEE driver, and expose it through the
> generic get_tee_revision() callback.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  drivers/tee/optee/core.c          | 23 +++++++++++++
>  drivers/tee/optee/ffa_abi.c       | 54 +++++++++++++++++++++++--------
>  drivers/tee/optee/optee_private.h | 19 +++++++++++
>  drivers/tee/optee/smc_abi.c       | 15 +++++++--
>  4 files changed, 94 insertions(+), 17 deletions(-)

Looks good, I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 5b62139714ce..2d807bc748bc 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -63,6 +63,29 @@ int optee_set_dma_mask(struct optee *optee, u_int pa_w=
idth)
>         return dma_coerce_mask_and_coherent(&optee->teedev->dev, mask);
>  }
>
> +int optee_get_revision(struct tee_device *teedev, char *buf, size_t len)
> +{
> +       struct optee *optee =3D tee_get_drvdata(teedev);
> +       u64 build_id;
> +
> +       if (!optee)
> +               return -ENODEV;
> +       if (!buf || !len)
> +               return -EINVAL;
> +
> +       build_id =3D optee->revision.os_build_id;
> +       if (build_id)
> +               scnprintf(buf, len, "%u.%u (%016llx)",
> +                         optee->revision.os_major,
> +                         optee->revision.os_minor,
> +                         (unsigned long long)build_id);
> +       else
> +               scnprintf(buf, len, "%u.%u", optee->revision.os_major,
> +                         optee->revision.os_minor);
> +
> +       return 0;
> +}
> +
>  static void optee_bus_scan(struct work_struct *work)
>  {
>         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index bf8390789ecf..8fc72aa95722 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -775,6 +775,39 @@ static int optee_ffa_reclaim_protmem(struct optee *o=
ptee,
>   * with a matching configuration.
>   */
>
> +static bool optee_ffa_get_os_revision(struct ffa_device *ffa_dev,
> +                                     const struct ffa_ops *ops,
> +                                     struct optee_revision *revision)
> +{
> +       const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
> +       struct ffa_send_direct_data data =3D {
> +               .data0 =3D OPTEE_FFA_GET_OS_VERSION,
> +       };
> +       int rc;
> +
> +       msg_ops->mode_32bit_set(ffa_dev);
> +
> +       rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
> +       if (rc) {
> +               pr_err("Unexpected error %d\n", rc);
> +               return false;
> +       }
> +
> +       if (revision) {
> +               revision->os_major =3D data.data0;
> +               revision->os_minor =3D data.data1;
> +               revision->os_build_id =3D data.data2;
> +       }
> +
> +       if (data.data2)
> +               pr_info("revision %lu.%lu (%08lx)",
> +                       data.data0, data.data1, data.data2);
> +       else
> +               pr_info("revision %lu.%lu", data.data0, data.data1);
> +
> +       return true;
> +}
> +
>  static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
>                                         const struct ffa_ops *ops)
>  {
> @@ -798,20 +831,6 @@ static bool optee_ffa_api_is_compatible(struct ffa_d=
evice *ffa_dev,
>                 return false;
>         }
>
> -       data =3D (struct ffa_send_direct_data){
> -               .data0 =3D OPTEE_FFA_GET_OS_VERSION,
> -       };
> -       rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
> -       if (rc) {
> -               pr_err("Unexpected error %d\n", rc);
> -               return false;
> -       }
> -       if (data.data2)
> -               pr_info("revision %lu.%lu (%08lx)",
> -                       data.data0, data.data1, data.data2);
> -       else
> -               pr_info("revision %lu.%lu", data.data0, data.data1);
> -
>         return true;
>  }
>
> @@ -900,6 +919,7 @@ static int optee_ffa_open(struct tee_context *ctx)
>
>  static const struct tee_driver_ops optee_ffa_clnt_ops =3D {
>         .get_version =3D optee_ffa_get_version,
> +       .get_tee_revision =3D optee_get_revision,
>         .open =3D optee_ffa_open,
>         .release =3D optee_release,
>         .open_session =3D optee_open_session,
> @@ -918,6 +938,7 @@ static const struct tee_desc optee_ffa_clnt_desc =3D =
{
>
>  static const struct tee_driver_ops optee_ffa_supp_ops =3D {
>         .get_version =3D optee_ffa_get_version,
> +       .get_tee_revision =3D optee_get_revision,
>         .open =3D optee_ffa_open,
>         .release =3D optee_release_supp,
>         .supp_recv =3D optee_supp_recv,
> @@ -1060,6 +1081,11 @@ static int optee_ffa_probe(struct ffa_device *ffa_=
dev)
>         if (!optee)
>                 return -ENOMEM;
>
> +       if (!optee_ffa_get_os_revision(ffa_dev, ffa_ops, &optee->revision=
)) {
> +               rc =3D -EINVAL;
> +               goto err_free_optee;
> +       }
> +
>         pool =3D optee_ffa_shm_pool_alloc_pages();
>         if (IS_ERR(pool)) {
>                 rc =3D PTR_ERR(pool);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index db9ea673fbca..acd3051c4879 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -171,6 +171,24 @@ struct optee_ffa {
>
>  struct optee;
>
> +/**
> + * struct optee_revision - OP-TEE OS revision reported by secure world
> + * @os_major:          OP-TEE OS major version
> + * @os_minor:          OP-TEE OS minor version
> + * @os_build_id:       OP-TEE OS build identifier (0 if unspecified)
> + *
> + * Values come from OPTEE_SMC_CALL_GET_OS_REVISION (SMC ABI) or
> + * OPTEE_FFA_GET_OS_VERSION (FF-A ABI); this is the trusted OS revision,=
 not an
> + * FF-A ABI version.
> + */
> +struct optee_revision {
> +       u32 os_major;
> +       u32 os_minor;
> +       u64 os_build_id;
> +};
> +
> +int optee_get_revision(struct tee_device *teedev, char *buf, size_t len)=
;
> +
>  /**
>   * struct optee_ops - OP-TEE driver internal operations
>   * @do_call_with_arg:  enters OP-TEE in secure world
> @@ -249,6 +267,7 @@ struct optee {
>         bool in_kernel_rpmb_routing;
>         struct work_struct scan_bus_work;
>         struct work_struct rpmb_scan_bus_work;
> +       struct optee_revision revision;
>  };
>
>  struct optee_session {
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 0be663fcd52b..51fae1ab8ef8 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1242,6 +1242,7 @@ static int optee_smc_open(struct tee_context *ctx)
>
>  static const struct tee_driver_ops optee_clnt_ops =3D {
>         .get_version =3D optee_get_version,
> +       .get_tee_revision =3D optee_get_revision,
>         .open =3D optee_smc_open,
>         .release =3D optee_release,
>         .open_session =3D optee_open_session,
> @@ -1261,6 +1262,7 @@ static const struct tee_desc optee_clnt_desc =3D {
>
>  static const struct tee_driver_ops optee_supp_ops =3D {
>         .get_version =3D optee_get_version,
> +       .get_tee_revision =3D optee_get_revision,
>         .open =3D optee_smc_open,
>         .release =3D optee_release_supp,
>         .supp_recv =3D optee_supp_recv,
> @@ -1323,7 +1325,8 @@ static bool optee_msg_api_uid_is_optee_image_load(o=
ptee_invoke_fn *invoke_fn)
>  }
>  #endif
>
> -static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> +static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
> +                                     struct optee_revision *revision)
>  {
>         union {
>                 struct arm_smccc_res smccc;
> @@ -1337,6 +1340,12 @@ static void optee_msg_get_os_revision(optee_invoke=
_fn *invoke_fn)
>         invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
>                   &res.smccc);
>
> +       if (revision) {
> +               revision->os_major =3D res.result.major;
> +               revision->os_minor =3D res.result.minor;
> +               revision->os_build_id =3D res.result.build_id;
> +       }
> +
>         if (res.result.build_id)
>                 pr_info("revision %lu.%lu (%0*lx)", res.result.major,
>                         res.result.minor, (int)sizeof(res.result.build_id=
) * 2,
> @@ -1745,8 +1754,6 @@ static int optee_probe(struct platform_device *pdev=
)
>                 return -EINVAL;
>         }
>
> -       optee_msg_get_os_revision(invoke_fn);
> -
>         if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
>                 pr_warn("api revision mismatch\n");
>                 return -EINVAL;
> @@ -1815,6 +1822,8 @@ static int optee_probe(struct platform_device *pdev=
)
>                 goto err_free_shm_pool;
>         }
>
> +       optee_msg_get_os_revision(invoke_fn, &optee->revision);
> +
>         optee->ops =3D &optee_ops;
>         optee->smc.invoke_fn =3D invoke_fn;
>         optee->smc.sec_caps =3D sec_caps;
> --
> 2.43.0
>
