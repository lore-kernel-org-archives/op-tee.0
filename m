Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118E2CFA466
	for <op-tee@archiver.kernel.org>; Mon, 24 Nov 2025 07:15:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 45C1D4FED0
	for <op-tee@archiver.kernel.org>; Mon, 24 Nov 2025 07:15:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V3EZmuRj;
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DECDB42F17
	for <op-tee@lists.trustedfirmware.org>; Mon, 24 Nov 2025 07:15:16 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-656bb297e31so564355eaf.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 23 Nov 2025 23:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763968516; x=1764573316; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQSDkfE9qXickrcWyKKiC/+eUpyyEJOtRt9evNMah2c=;
        b=V3EZmuRjiSfSqltuajUcMPCeneEAIFDHuTjRWShqZFQv2mp3DB19D5IhOyLl7rsRGf
         da44F5xIgtJtPVNxjpgZjF0WfhkBLRfCQe7hR8pis/pv16hOwEZT+ixa0D+KeiHsT3LZ
         lT5e3568xpKj+YMZ5pXIuphj+q/r2g5/5xXG/NfvXARlKr4kDOHhH0q5fHF516cjSw+7
         3zPjqR9uHgf+f/+1UjgVJmJfZgQ/uGPV+BMpkTC5G8AwjJE2NrbU8R5Lc/zGcUERVqK1
         SIifaMrqHO4QOkuSgd3sBJG5Lha205TwE2x5BgOBGPh9/APoNBrMnZvtw2F8x1qnMKaW
         iKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763968516; x=1764573316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jQSDkfE9qXickrcWyKKiC/+eUpyyEJOtRt9evNMah2c=;
        b=bmQ0k+O6CtvthUHyD68AfKjreAL+9ZdOdd1JCWDSuP+9EDozmRGu84gPKr+R1FSb1M
         GhkelaS2fP2GfAXv1F5h9Paod8/Dfm2m4HsdbCA0bTdBUCWrvx9nLRNTLxZILDgjMD9t
         n+lrZYTKlHZmTNpDlRzswgNSzeZniZnSCQjhLfgK+n73cdCFt7sBSnWWrRhKzFd5rVgD
         VvP5E+1/AmwNcMBhKZq31K48pt0X1s9Unq5FGhq67iOiibPnBfSz+5Fq2NbP9RrUONUp
         NbsRKh+9cG6BdLruVy7ow2XZZCD48uqdPiBFZoTcCtpx3gZxG3rA/Z0oLPPT5+WBx9sM
         C68g==
X-Forwarded-Encrypted: i=1; AJvYcCWpioPT0R0X054G0dt5JNGNxqW0AGQQxSzdWUwNRa0SjTlMzixtuzIX0j0JEpGudLeeqsXbqvk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw9TKNFWsdOTgzQzBekiES0VbBZGYwEKViZrTYnlpdFM7DWhYXp
	mwlU8f3n+TF45IUxuXrzJDAjh2RAnms99SHgowTuikLi4VuU4t8HtpJ95nz6jQp9Apteh3V2XiT
	GwXZpaPzCap+LkJYhfCq91WdqfRTTaDFONbMgIKBMlqIw
X-Gm-Gg: ASbGnctSJReTj+DVfY/VuTPNubPYOVRJNftG+OLR3xkWiKG9RluQgRDUqygWYVySPCS
	9AcvHhKT67N6afcvxUlIqPxsyPzdC2YF+zBU6C0X6qrCNylC1zbmV6oqsji+FngfoNY/jNcXuc5
	ZBsi4V7HiVJIZZq/2TAAJoO5Yk8/e4l4/TXdwmCIj/s/9Vq7YUGF0ZdRC5Zv/bbRKDf9l7+pbtP
	AGIvNcMR15BHYFP7HT1Mho/edsch199AXh1L7Ft4vklDS2z047h9/kZyzWFUpTtVfgQug==
X-Google-Smtp-Source: AGHT+IETx+US5uDnN/47nQ1FKYcWkyAg+R/enn30tv8CJfot66eE3RcUgP0Ce6exnhQn+vdoNEJwU0rbXgLdAEeNe/Y=
X-Received: by 2002:a05:6820:6ac1:b0:656:735e:9eff with SMTP id
 006d021491bc7-65790bd8434mr3778090eaf.7.1763968516101; Sun, 23 Nov 2025
 23:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20251121141230.489294-1-jj251510319013@gmail.com> <20251122145924.381725-1-jj251510319013@gmail.com>
In-Reply-To: <20251122145924.381725-1-jj251510319013@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 24 Nov 2025 08:15:04 +0100
X-Gm-Features: AWmQ_bkMkFd38DFA4sZs5xvmEnD8MSI7mWtbh_hrtGYzpqH-XvXiyht9yESD2Mc
Message-ID: <CAHUa44HFC+BTO3KfaNF1LHiM7frgt2myzZ_85Mbf1t2gUY9iSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Wei Ming Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DECDB42F17
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.46:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.46:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: IMZM5UYM54XW46BC5NA533QD37F33Z74
X-Message-ID-Hash: IMZM5UYM54XW46BC5NA533QD37F33Z74
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IMZM5UYM54XW46BC5NA533QD37F33Z74/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Sat, Nov 22, 2025 at 4:00=E2=80=AFPM Wei Ming Chen <jj251510319013@gmail=
.com> wrote:
>
> From: Aristo Chen <aristo.chen@canonical.com>
>
> Today the only way to read the OP-TEE OS version is from dmesg/journal
> logs, which can be lost as buffers roll over. Capture the OS revision
> (major/minor/build_id) from secure world for both SMC and FF-A ABIs, stor=
e
> it in the OP-TEE driver, and expose a stable userspace readout via
> /sys/class/tee/tee*/optee_os_revision.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  drivers/tee/optee/core.c          | 19 +++++++++++++++++++
>  drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
>  drivers/tee/optee/optee_private.h | 17 +++++++++++++++++
>  drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
>  4 files changed, 58 insertions(+), 4 deletions(-)

This appears to be a feature that could be useful for all TEEs. If so,
let's take a step back to see what's needed. We can add the sysfs
attribute from drivers/tee/tee_core.c and add another optional
callback to struct tee_driver_ops, such as get_tee_revision(). For
OP-TEE, the specific information we want to share is clear, but other
TEEs might have additional or different data. What do others think?

Cheers,
Jens

>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 5b62139714ce..66409cf5da1c 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -83,8 +83,27 @@ static ssize_t rpmb_routing_model_show(struct device *=
dev,
>  }
>  static DEVICE_ATTR_RO(rpmb_routing_model);
>
> +static ssize_t optee_os_revision_show(struct device *dev,
> +                                     struct device_attribute *attr, char=
 *buf)
> +{
> +       struct optee *optee =3D dev_get_drvdata(dev);
> +       struct optee_version_info *v;
> +
> +       if (!optee)
> +               return -ENODEV;
> +
> +       v =3D &optee->version_info;
> +       if (v->os_build_id)
> +               return sysfs_emit(buf, "%u.%u (%016llx)\n", v->os_major,
> +                                 v->os_minor, (unsigned long long)v->os_=
build_id);
> +
> +       return sysfs_emit(buf, "%u.%u\n", v->os_major, v->os_minor);
> +}
> +static DEVICE_ATTR_RO(optee_os_revision);
> +
>  static struct attribute *optee_dev_attrs[] =3D {
>         &dev_attr_rpmb_routing_model.attr,
> +       &dev_attr_optee_os_revision.attr,
>         NULL
>  };
>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index bf8390789ecf..3d4f35599dd1 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -776,7 +776,8 @@ static int optee_ffa_reclaim_protmem(struct optee *op=
tee,
>   */
>
>  static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
> -                                       const struct ffa_ops *ops)
> +                                       const struct ffa_ops *ops,
> +                                       struct optee_version_info *versio=
n_info)
>  {
>         const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
>         struct ffa_send_direct_data data =3D {
> @@ -806,6 +807,12 @@ static bool optee_ffa_api_is_compatible(struct ffa_d=
evice *ffa_dev,
>                 pr_err("Unexpected error %d\n", rc);
>                 return false;
>         }
> +       if (version_info) {
> +               version_info->os_major =3D data.data0;
> +               version_info->os_minor =3D data.data1;
> +               version_info->os_build_id =3D data.data2;
> +       }
> +
>         if (data.data2)
>                 pr_info("revision %lu.%lu (%08lx)",
>                         data.data0, data.data1, data.data2);
> @@ -1034,6 +1041,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)
>  {
>         const struct ffa_notifier_ops *notif_ops;
>         const struct ffa_ops *ffa_ops;
> +       struct optee_version_info version_info =3D { };
>         unsigned int max_notif_value;
>         unsigned int rpc_param_count;
>         struct tee_shm_pool *pool;
> @@ -1047,7 +1055,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)
>         ffa_ops =3D ffa_dev->ops;
>         notif_ops =3D ffa_ops->notifier_ops;
>
> -       if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
> +       if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &version_info)=
)
>                 return -EINVAL;
>
>         if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> @@ -1059,6 +1067,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)
>         optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
>         if (!optee)
>                 return -ENOMEM;
> +       optee->version_info =3D version_info;
>
>         pool =3D optee_ffa_shm_pool_alloc_pages();
>         if (IS_ERR(pool)) {
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index db9ea673fbca..3e7bcd44976b 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -19,6 +19,22 @@
>
>  #define OPTEE_MAX_ARG_SIZE     1024
>
> +/**
> + * struct optee_version_info - OP-TEE OS revision reported by secure wor=
ld
> + * @os_major:          OP-TEE OS major version
> + * @os_minor:          OP-TEE OS minor version
> + * @os_build_id:       OP-TEE OS build identifier (0 if unspecified)
> + *
> + * Values come from OPTEE_SMC_CALL_GET_OS_REVISION (SMC ABI) or
> + * OPTEE_FFA_GET_OS_VERSION (FF-A ABI); this is the trusted OS revision,=
 not an
> + * FF-A ABI version.
> + */
> +struct optee_version_info {
> +       u32 os_major;
> +       u32 os_minor;
> +       u64 os_build_id;
> +};
> +
>  /* Some Global Platform error codes used in this driver */
>  #define TEEC_SUCCESS                   0x00000000
>  #define TEEC_ERROR_BAD_PARAMETERS      0xFFFF0006
> @@ -249,6 +265,7 @@ struct optee {
>         bool in_kernel_rpmb_routing;
>         struct work_struct scan_bus_work;
>         struct work_struct rpmb_scan_bus_work;
> +       struct optee_version_info version_info;
>  };
>
>  struct optee_session {
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 0be663fcd52b..07c703609320 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1323,7 +1323,8 @@ static bool optee_msg_api_uid_is_optee_image_load(o=
ptee_invoke_fn *invoke_fn)
>  }
>  #endif
>
> -static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> +static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
> +                                     struct optee_version_info *version_=
info)
>  {
>         union {
>                 struct arm_smccc_res smccc;
> @@ -1337,6 +1338,12 @@ static void optee_msg_get_os_revision(optee_invoke=
_fn *invoke_fn)
>         invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
>                   &res.smccc);
>
> +       if (version_info) {
> +               version_info->os_major =3D res.result.major;
> +               version_info->os_minor =3D res.result.minor;
> +               version_info->os_build_id =3D res.result.build_id;
> +       }
> +
>         if (res.result.build_id)
>                 pr_info("revision %lu.%lu (%0*lx)", res.result.major,
>                         res.result.minor, (int)sizeof(res.result.build_id=
) * 2,
> @@ -1727,6 +1734,7 @@ static int optee_probe(struct platform_device *pdev=
)
>         unsigned int thread_count;
>         struct tee_device *teedev;
>         struct tee_context *ctx;
> +       struct optee_version_info version_info =3D { };
>         u32 max_notif_value;
>         u32 arg_cache_flags;
>         u32 sec_caps;
> @@ -1745,7 +1753,7 @@ static int optee_probe(struct platform_device *pdev=
)
>                 return -EINVAL;
>         }
>
> -       optee_msg_get_os_revision(invoke_fn);
> +       optee_msg_get_os_revision(invoke_fn, &version_info);
>
>         if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
>                 pr_warn("api revision mismatch\n");
> @@ -1814,6 +1822,7 @@ static int optee_probe(struct platform_device *pdev=
)
>                 rc =3D -ENOMEM;
>                 goto err_free_shm_pool;
>         }
> +       optee->version_info =3D version_info;
>
>         optee->ops =3D &optee_ops;
>         optee->smc.invoke_fn =3D invoke_fn;
> --
> 2.43.0
>
