Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7484EC2A07A
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 09:54:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B11824FC3E
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 09:54:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JIxQaFty;
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EF4D541A35
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 08:14:28 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dbd1421182so11439677137.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Jan 2026 00:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767600868; x=1768205668; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJhLL1h0jOPmf/idWcgZBBmmjqlc+6ZgShiXhAO+z5M=;
        b=JIxQaFty7Z0azLfqC3m+hAJYsZa+/T+AbrKaa47TF44LL/dgk+GMFvnr/3GIHq6/Zx
         jx93Rfa4Xhv8xF8TKQxxdTmAmNbVwDe6SEYte6uyWKPjZHK6siXrM+/hdfaBs1kXxXpr
         V3s/vrJdkCSIL7eUZkCGVidu0OlXcbhGMTpGtz4PhjtE2HoY29oQlW1xtEZBZat7ZMQy
         Ag9pVLSIaU5wOdsAEx5BwNf/NSkR4hZBuSGY+/lrH1mLnJIrmw4emIAVbsUsFUb+oQoT
         XeZ8Cuj+KwJY51OYbQwqEy2cvdhCx3RgLn1Jmfbsw9MI3dSJDnG/rOgxAcTTFvlQGVIk
         opUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767600868; x=1768205668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJhLL1h0jOPmf/idWcgZBBmmjqlc+6ZgShiXhAO+z5M=;
        b=TF7F8QHRDaMTPWfWSrFabhKLAaWQ5IWRdSonnNuK6HnlrK4X2EgpgO+bEDav1R51kn
         /nuEnGmI2CqlsCssZxOhYP8aX2PjIwTvxXuZ7/Kzu6PEBVzpkwow9VWTNyR24sVFDvdD
         bSi+1c+eDXKUET3RTtpaGbXTEebOH+nZlVpEKdIWcBH1fmyBAAqmhA9w0Sr2B4LdemB+
         O4jPoP4pcOlm+lah+UPP9CcNDiQCJJEqFMeoRE6FSnPpOMZqptbdr4kZYmmFMJrPLxT+
         k187HaQxCzhSErvanNeQoHpq2duHVqi9CVBpjFkIkyEwFN2ZknTX528D66YnjHPOOGDI
         r7nA==
X-Forwarded-Encrypted: i=1; AJvYcCVafOGVWqvF4B/Gh1YGn1z4R/xbJEk1eeulD37yY359Phq0N99kID475P4gZIwOJ77RcP4qwmQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzEgHRRZtb3LW6rcAQqBD7R447Pe3h4uOtMFo48QOUkY+KRKXt9
	P3MNpO+9Nnh4WKbdTH1IJ1B9jlSKu4A5O4cLv9fGkEKxBWrBj0A1MPP40vXuqUSwJcmjg0FUmgv
	jJ/6FR7XDnx8RM9gQVQcD4zMghR9LjIY=
X-Gm-Gg: AY/fxX5dgEtUC5SCHPVCnK45W5E4VP4cOF3jDsCh86Q+7/ne0/6YemtE6nEgnrNVdga
	gRf2Hy51plCHIrnDtp7Wu+GH1ZN5hwkM4t6AF6qeDzCgN/jk9p8lfVcHKw8F5X4q5hYNRTcZ234
	FtZs+dKT5tArrH6TLpipzfva9bNW6+aR9HnVejVihtgguX34QTZmM9q7G7Ltq7x8hO+zNt/Ejyd
	iurY8hFbZogXKBFiUTQSSag4dKhCKZNkVLw9eF8llcSw1PFBNkopxcXBw3o5/IP6vTOxjCW
X-Google-Smtp-Source: AGHT+IGO137a6z3FWQIYoryS/5RuFyoMlx97xfvC1Hvk5D3qmvkjbQvCqe5ksitZZHmPxXu+EOy/eK0WCRO8yqsFty0=
X-Received: by 2002:a05:6102:e0e:b0:5e5:5ed7:60ae with SMTP id
 ada2fe7eead31-5eb1a817635mr16851521137.31.1767600868311; Mon, 05 Jan 2026
 00:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20251226131920.64582-1-aristo.chen@canonical.com>
 <20251230051804.6230-1-aristo.chen@canonical.com> <20251230051804.6230-2-aristo.chen@canonical.com>
 <aVtKHF3krwJWiCth@sumit-xelite>
In-Reply-To: <aVtKHF3krwJWiCth@sumit-xelite>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Mon, 5 Jan 2026 16:13:52 +0800
X-Gm-Features: AQt7F2oW1-0O23ELZ5TwC-yulNrmeTk2MooVTxlt1L0ERpXB-stxZtPdLU4JqDo
Message-ID: <CAJwFiGKaKUOvM42BpECMhHqOigT=HFGbaLN1Jg=AC+wgS3Cb+Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] tee: optee: store OS revision for TEE core
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.217.42:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.217.42:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EF4D541A35
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: FOZGRMB74LOOAYKRHQOX3QILQV5OMZEE
X-Message-ID-Hash: FOZGRMB74LOOAYKRHQOX3QILQV5OMZEE
X-Mailman-Approved-At: Mon, 05 Jan 2026 09:54:42 +0000
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FOZGRMB74LOOAYKRHQOX3QILQV5OMZEE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Sumit,

Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2026=E5=B9=B41=E6=9C=885=E6=97=
=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:20=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Dec 30, 2025 at 01:17:59PM +0800, Aristo Chen wrote:
> > Collect OP-TEE OS revision from secure world for both SMC and FF-A ABIs=
,
> > store it in the OP-TEE driver, and expose it through the generic
> > get_tee_revision() callback.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > ---
> >  drivers/tee/optee/core.c          | 23 +++++++++++++++++++++++
> >  drivers/tee/optee/ffa_abi.c       | 14 ++++++++++++--
> >  drivers/tee/optee/optee_private.h | 19 +++++++++++++++++++
> >  drivers/tee/optee/smc_abi.c       | 15 +++++++++++++--
> >  4 files changed, 67 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 5b62139714ce..2d807bc748bc 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -63,6 +63,29 @@ int optee_set_dma_mask(struct optee *optee, u_int pa=
_width)
> >       return dma_coerce_mask_and_coherent(&optee->teedev->dev, mask);
> >  }
> >
> > +int optee_get_revision(struct tee_device *teedev, char *buf, size_t le=
n)
> > +{
> > +     struct optee *optee =3D tee_get_drvdata(teedev);
> > +     u64 build_id;
> > +
> > +     if (!optee)
> > +             return -ENODEV;
> > +     if (!buf || !len)
> > +             return -EINVAL;
> > +
> > +     build_id =3D optee->revision.os_build_id;
> > +     if (build_id)
> > +             scnprintf(buf, len, "%u.%u (%016llx)",
> > +                       optee->revision.os_major,
> > +                       optee->revision.os_minor,
> > +                       (unsigned long long)build_id);
> > +     else
> > +             scnprintf(buf, len, "%u.%u", optee->revision.os_major,
> > +                       optee->revision.os_minor);
> > +
> > +     return 0;
> > +}
> > +
> >  static void optee_bus_scan(struct work_struct *work)
> >  {
> >       WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index bf8390789ecf..d67ca1ec9506 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -776,7 +776,8 @@ static int optee_ffa_reclaim_protmem(struct optee *=
optee,
> >   */
> >
> >  static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
> > -                                     const struct ffa_ops *ops)
> > +                                     const struct ffa_ops *ops,
> > +                                     struct optee_revision *revision)
> >  {
> >       const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
> >       struct ffa_send_direct_data data =3D {
> > @@ -806,6 +807,11 @@ static bool optee_ffa_api_is_compatible(struct ffa=
_device *ffa_dev,
> >               pr_err("Unexpected error %d\n", rc);
> >               return false;
> >       }
> > +     if (revision) {
> > +             revision->os_major =3D data.data0;
> > +             revision->os_minor =3D data.data1;
> > +             revision->os_build_id =3D data.data2;
> > +     }
> >       if (data.data2)
> >               pr_info("revision %lu.%lu (%08lx)",
> >                       data.data0, data.data1, data.data2);
> > @@ -900,6 +906,7 @@ static int optee_ffa_open(struct tee_context *ctx)
> >
> >  static const struct tee_driver_ops optee_ffa_clnt_ops =3D {
> >       .get_version =3D optee_ffa_get_version,
> > +     .get_tee_revision =3D optee_get_revision,
> >       .open =3D optee_ffa_open,
> >       .release =3D optee_release,
> >       .open_session =3D optee_open_session,
> > @@ -918,6 +925,7 @@ static const struct tee_desc optee_ffa_clnt_desc =
=3D {
> >
> >  static const struct tee_driver_ops optee_ffa_supp_ops =3D {
> >       .get_version =3D optee_ffa_get_version,
> > +     .get_tee_revision =3D optee_get_revision,
> >       .open =3D optee_ffa_open,
> >       .release =3D optee_release_supp,
> >       .supp_recv =3D optee_supp_recv,
> > @@ -1034,6 +1042,7 @@ static int optee_ffa_probe(struct ffa_device *ffa=
_dev)
> >  {
> >       const struct ffa_notifier_ops *notif_ops;
> >       const struct ffa_ops *ffa_ops;
> > +     struct optee_revision revision =3D { };
>
> No need for this redundant variable on stack when...
>
> >       unsigned int max_notif_value;
> >       unsigned int rpc_param_count;
> >       struct tee_shm_pool *pool;
> > @@ -1047,7 +1056,7 @@ static int optee_ffa_probe(struct ffa_device *ffa=
_dev)
> >       ffa_ops =3D ffa_dev->ops;
> >       notif_ops =3D ffa_ops->notifier_ops;
> >
> > -     if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
> > +     if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &revision))
>
> ...you can just invoke this API as rather:
>
>         if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &optee->revisi=
on))
>
Thanks for the review. To avoid the temporary struct optee_revision,
I need to move the optee allocation earlier so we can pass
&optee->revision into optee_ffa_api_is_compatible().

AFAICT, there aren=E2=80=99t kernel selftests covering this, the only test =
that
I am aware of is the xtest, so I=E2=80=99m slightly cautious about touching
probe ordering. If you prefer to avoid the early allocation, I can keep
the original order and use a local struct optee_revision instead.

Please let me know which you=E2=80=99d prefer

> >               return -EINVAL;
> >
> >       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> > @@ -1059,6 +1068,7 @@ static int optee_ffa_probe(struct ffa_device *ffa=
_dev)
> >       optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
> >       if (!optee)
> >               return -ENOMEM;
> > +     optee->revision =3D revision;
> >
> >       pool =3D optee_ffa_shm_pool_alloc_pages();
> >       if (IS_ERR(pool)) {
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index db9ea673fbca..acd3051c4879 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -171,6 +171,24 @@ struct optee_ffa {
> >
> >  struct optee;
> >
> > +/**
> > + * struct optee_revision - OP-TEE OS revision reported by secure world
> > + * @os_major:                OP-TEE OS major version
> > + * @os_minor:                OP-TEE OS minor version
> > + * @os_build_id:     OP-TEE OS build identifier (0 if unspecified)
> > + *
> > + * Values come from OPTEE_SMC_CALL_GET_OS_REVISION (SMC ABI) or
> > + * OPTEE_FFA_GET_OS_VERSION (FF-A ABI); this is the trusted OS revisio=
n, not an
> > + * FF-A ABI version.
> > + */
> > +struct optee_revision {
> > +     u32 os_major;
> > +     u32 os_minor;
> > +     u64 os_build_id;
> > +};
> > +
> > +int optee_get_revision(struct tee_device *teedev, char *buf, size_t le=
n);
> > +
> >  /**
> >   * struct optee_ops - OP-TEE driver internal operations
> >   * @do_call_with_arg:        enters OP-TEE in secure world
> > @@ -249,6 +267,7 @@ struct optee {
> >       bool in_kernel_rpmb_routing;
> >       struct work_struct scan_bus_work;
> >       struct work_struct rpmb_scan_bus_work;
> > +     struct optee_revision revision;
> >  };
> >
> >  struct optee_session {
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index 0be663fcd52b..0baaf7986a35 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1242,6 +1242,7 @@ static int optee_smc_open(struct tee_context *ctx=
)
> >
> >  static const struct tee_driver_ops optee_clnt_ops =3D {
> >       .get_version =3D optee_get_version,
> > +     .get_tee_revision =3D optee_get_revision,
> >       .open =3D optee_smc_open,
> >       .release =3D optee_release,
> >       .open_session =3D optee_open_session,
> > @@ -1261,6 +1262,7 @@ static const struct tee_desc optee_clnt_desc =3D =
{
> >
> >  static const struct tee_driver_ops optee_supp_ops =3D {
> >       .get_version =3D optee_get_version,
> > +     .get_tee_revision =3D optee_get_revision,
> >       .open =3D optee_smc_open,
> >       .release =3D optee_release_supp,
> >       .supp_recv =3D optee_supp_recv,
> > @@ -1323,7 +1325,8 @@ static bool optee_msg_api_uid_is_optee_image_load=
(optee_invoke_fn *invoke_fn)
> >  }
> >  #endif
> >
> > -static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> > +static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
> > +                                   struct optee_revision *revision)
> >  {
> >       union {
> >               struct arm_smccc_res smccc;
> > @@ -1337,6 +1340,12 @@ static void optee_msg_get_os_revision(optee_invo=
ke_fn *invoke_fn)
> >       invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
> >                 &res.smccc);
> >
> > +     if (revision) {
> > +             revision->os_major =3D res.result.major;
> > +             revision->os_minor =3D res.result.minor;
> > +             revision->os_build_id =3D res.result.build_id;
> > +     }
> > +
> >       if (res.result.build_id)
> >               pr_info("revision %lu.%lu (%0*lx)", res.result.major,
> >                       res.result.minor, (int)sizeof(res.result.build_id=
) * 2,
> > @@ -1727,6 +1736,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >       unsigned int thread_count;
> >       struct tee_device *teedev;
> >       struct tee_context *ctx;
> > +     struct optee_revision revision =3D { };
>
> Ditto here.
>
> -Sumit
>
> >       u32 max_notif_value;
> >       u32 arg_cache_flags;
> >       u32 sec_caps;
> > @@ -1745,7 +1755,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >               return -EINVAL;
> >       }
> >
> > -     optee_msg_get_os_revision(invoke_fn);
> > +     optee_msg_get_os_revision(invoke_fn, &revision);
> >
> >       if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
> >               pr_warn("api revision mismatch\n");
> > @@ -1837,6 +1847,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >               goto err_unreg_teedev;
> >       }
> >       optee->supp_teedev =3D teedev;
> > +     optee->revision =3D revision;
> >
> >       optee_set_dev_group(optee);
> >
> > --
> > 2.43.0
> >

Best regards,
Aristo
