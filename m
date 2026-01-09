Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A476BD232D7
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 10:21:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E2B5E430AB
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 10:21:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KZNFMXPB;
	dkim-atps=neutral
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CD71E4FCAF
	for <op-tee@lists.trustedfirmware.org>; Fri,  9 Jan 2026 15:08:17 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93f500ee7b8so2097322241.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 09 Jan 2026 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767971297; x=1768576097; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz00JqNbtUxid4Ik3Wf/aVpIAcZkt7uWd2SEppn1c5c=;
        b=KZNFMXPBkTsdIbjz27CdlstOQHUwlSuASqT736YhYdaHq2z4kP7FWfUV+uVPaGT6+/
         3/2uFAP2tGq8z18x6bKa43xzkMA781i7LQGCRQrHxLXZHW0YB739ob5/tzYPEcj2isSe
         hqF1zmDmyeAqb5pJQQ+61Rdt6uDnR85h0eRvx6wAvKe8vCDszQSdvAlaX0uDGUaPQ4Q1
         EqsNwGO/+nkWBnlPrcRsyP3JF5RhQmbJWkA2OySdtE5WROLStFJL9p+IDLlrvtz9N+jI
         /hHsGOh2VlxtrMJyqKB8CqbSyKLWCItjiaIKEtikXWVESCmfqa2et4GLdYj1n7hWVj21
         0tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767971297; x=1768576097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cz00JqNbtUxid4Ik3Wf/aVpIAcZkt7uWd2SEppn1c5c=;
        b=bVANQNMpQeSiH5J6B1Mf/o9dil/Tcc9VwS6ezymGoF0pS3JJBne5d7ybaoLLIMk7fU
         TuVfaBY+RPIKVMqfM0IpQY2ho0T2V0QH+qWMBr3v430tAruZ7QaehFBd4stlwFha2jMd
         8BFHCCzFSof244w/c8UR+7rMkf1JV5NKwsAFy9osoGMc3wIyMlKnmaQeSJy9vKe0Ij/1
         GJ1UVbadquON2rFAjCXjOgv28qyZgSsvF836EFyt+ZIlrOgZ/rXQtmHVnujKZ4HJtN3F
         cpmS8gPXcWO6r59q6Vk/pLQrs7g/mEkuhfAeaexClByYHTb4nsOTEJIDWU+UCq9ZsDZi
         g5ng==
X-Forwarded-Encrypted: i=1; AJvYcCUhmyx5/WIM1IS7Xfx7Gl3/z78NP95J9/lEwT3/jXptbnzjamH5AFfbZsZqhfByy9geycdSTvk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwgE80QHJCOF/m00qcZEDgMoV8TT1BOS9AoGhXpchNKYyAo+U25
	HL0dkT0DRSVU7kjmBV5wFWSFpsAXbNaeTzk7TRgYjPVjPV8sY1nH6oBDR3wSwOJBkM3GHPujSNN
	Vr6lyRDllEW3SfDG0e+LnkWtjky9y2/Y=
X-Gm-Gg: AY/fxX7oPTrZTJC6/LBt9P7CWqVfS9jJTlySL5j5aomw93xdC1AS66GPvVe+ILFm/tM
	edbL2ZewIDGQxDTZVsbkBv5ma8wQ/JIHc7zTDfAtu+kamxn0qqrPKCCDcgiMR7Vr8K4l2nTT7PS
	HU9K9zZ11FullvCZguI184jbhSmhVxQbZBTbI7JdmhAdvnPSSSJ0tYkCsVlsUVUtbqYZy7wEVAL
	kLgzdggaatlW6+KeueWhavpBg5cvAYy1r5bklu/VuFw9fIdoP9FdhMGL6z5gXxT8Jmh194=
X-Google-Smtp-Source: AGHT+IHKwNb91FMU5IEf1Rkn7r3d3ebM9dk2/HRk0jZo+K+XAy1tcdrhTCTiqgJJ6KggjP5xd3euA8pwk9CPqlzqobM=
X-Received: by 2002:a05:6122:2190:b0:554:b32c:6f76 with SMTP id
 71dfb90a1353d-56347ffa4b1mr3565879e0c.15.1767971296989; Fri, 09 Jan 2026
 07:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20260107152607.902735-1-aristo.chen@canonical.com>
 <20260108064517.13854-1-aristo.chen@canonical.com> <20260108064517.13854-2-aristo.chen@canonical.com>
 <aWDrejFoUtKy6wdE@sumit-xelite>
In-Reply-To: <aWDrejFoUtKy6wdE@sumit-xelite>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Fri, 9 Jan 2026 23:07:40 +0800
X-Gm-Features: AZwV_QiY4gjdeqpRHMQ0ZaEr0jYV6WHRLInjOb7z8D8z0wdIP9dG79L4DmkrfzI
Message-ID: <CAJwFiG+GKKa-vYwWzY8Dyw7GsaTq90kAyHWz1NJ28Bni43-nTQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] tee: optee: store OS revision for TEE core
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
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.222.46:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.46:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CD71E4FCAF
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: DXB4TWQFQKLEVGA6AQJTH3I2LKCUA2P4
X-Message-ID-Hash: DXB4TWQFQKLEVGA6AQJTH3I2LKCUA2P4
X-Mailman-Approved-At: Mon, 12 Jan 2026 10:20:59 +0000
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DXB4TWQFQKLEVGA6AQJTH3I2LKCUA2P4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Sumit

Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2026=E5=B9=B41=E6=9C=889=E6=97=
=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Jan 08, 2026 at 02:45:09PM +0800, Aristo Chen wrote:
> > Collect OP-TEE OS revision from secure world for both SMC and FF-A
> > ABIs, store it in the OP-TEE driver, and expose it through the
> > generic get_tee_revision() callback.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > ---
> >  drivers/tee/optee/core.c          | 23 +++++++++++++
> >  drivers/tee/optee/ffa_abi.c       | 57 ++++++++++++++++++++++++-------
> >  drivers/tee/optee/optee_private.h | 19 +++++++++++
> >  drivers/tee/optee/smc_abi.c       | 15 ++++++--
> >  4 files changed, 99 insertions(+), 15 deletions(-)
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
> > index bf8390789ecf..82dbed1c87e5 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -775,6 +775,42 @@ static int optee_ffa_reclaim_protmem(struct optee =
*optee,
> >   * with a matching configuration.
> >   */
> >
> > +static bool optee_ffa_get_os_revision(struct ffa_device *ffa_dev,
> > +                                     const struct ffa_ops *ops,
> > +                                     struct optee_revision *revision,
> > +                                     bool log)
> > +{
> > +     const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
> > +     struct ffa_send_direct_data data =3D {
> > +             .data0 =3D OPTEE_FFA_GET_OS_VERSION,
> > +     };
> > +     int rc;
> > +
> > +     msg_ops->mode_32bit_set(ffa_dev);
> > +
> > +     rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
> > +     if (rc) {
> > +             pr_err("Unexpected error %d\n", rc);
> > +             return false;
> > +     }
> > +
> > +     if (revision) {
> > +             revision->os_major =3D data.data0;
> > +             revision->os_minor =3D data.data1;
> > +             revision->os_build_id =3D data.data2;
> > +     }
> > +
> > +     if (log) {
> > +             if (data.data2)
> > +                     pr_info("revision %lu.%lu (%08lx)",
> > +                             data.data0, data.data1, data.data2);
> > +             else
> > +                     pr_info("revision %lu.%lu", data.data0, data.data=
1);
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >  static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
> >                                       const struct ffa_ops *ops)
> >  {
> > @@ -798,19 +834,8 @@ static bool optee_ffa_api_is_compatible(struct ffa=
_device *ffa_dev,
> >               return false;
> >       }
> >
> > -     data =3D (struct ffa_send_direct_data){
> > -             .data0 =3D OPTEE_FFA_GET_OS_VERSION,
> > -     };
> > -     rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
> > -     if (rc) {
> > -             pr_err("Unexpected error %d\n", rc);
> > +     if (!optee_ffa_get_os_revision(ffa_dev, ops, NULL, true))
>
> Why do you need to invoke optee_ffa_get_os_revision() here?

I=E2=80=99m calling optee_ffa_get_os_revision() here to avoid duplicating t=
he
GET_OS_VERSION call/printing logic. The original code in
optee_ffa_api_is_compatible() already did the OS version query and
printed it; after factoring it out, the helper keeps that behavior in one
place. If we don=E2=80=99t call it there, we=E2=80=99d either lose the exis=
ting dmesg log
or re=E2=80=91implement the same OS=E2=80=91version query/print block again=
, which I=E2=80=99m
trying to avoid.

If you=E2=80=99d rather avoid the extra call at this stage, maybe we can al=
ways
print the log in the optee_ffa_get_os_revision() and remove the call
from optee_ffa_api_is_compatible() entirely.

>
> -Sumit
>
> >               return false;
> > -     }
> > -     if (data.data2)
> > -             pr_info("revision %lu.%lu (%08lx)",
> > -                     data.data0, data.data1, data.data2);
> > -     else
> > -             pr_info("revision %lu.%lu", data.data0, data.data1);
> >
> >       return true;
> >  }
> > @@ -900,6 +925,7 @@ static int optee_ffa_open(struct tee_context *ctx)
> >
> >  static const struct tee_driver_ops optee_ffa_clnt_ops =3D {
> >       .get_version =3D optee_ffa_get_version,
> > +     .get_tee_revision =3D optee_get_revision,
> >       .open =3D optee_ffa_open,
> >       .release =3D optee_release,
> >       .open_session =3D optee_open_session,
> > @@ -918,6 +944,7 @@ static const struct tee_desc optee_ffa_clnt_desc =
=3D {
> >
> >  static const struct tee_driver_ops optee_ffa_supp_ops =3D {
> >       .get_version =3D optee_ffa_get_version,
> > +     .get_tee_revision =3D optee_get_revision,
> >       .open =3D optee_ffa_open,
> >       .release =3D optee_release_supp,
> >       .supp_recv =3D optee_supp_recv,
> > @@ -1060,6 +1087,12 @@ static int optee_ffa_probe(struct ffa_device *ff=
a_dev)
> >       if (!optee)
> >               return -ENOMEM;
> >
> > +     if (!optee_ffa_get_os_revision(ffa_dev, ffa_ops, &optee->revision=
,
> > +                                      false)) {
> > +             rc =3D -EINVAL;
> > +             goto err_free_optee;
> > +     }
> > +
> >       pool =3D optee_ffa_shm_pool_alloc_pages();
> >       if (IS_ERR(pool)) {
> >               rc =3D PTR_ERR(pool);
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
> > index 0be663fcd52b..51fae1ab8ef8 100644
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
> > @@ -1745,8 +1754,6 @@ static int optee_probe(struct platform_device *pd=
ev)
> >               return -EINVAL;
> >       }
> >
> > -     optee_msg_get_os_revision(invoke_fn);
> > -
> >       if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
> >               pr_warn("api revision mismatch\n");
> >               return -EINVAL;
> > @@ -1815,6 +1822,8 @@ static int optee_probe(struct platform_device *pd=
ev)
> >               goto err_free_shm_pool;
> >       }
> >
> > +     optee_msg_get_os_revision(invoke_fn, &optee->revision);
> > +
> >       optee->ops =3D &optee_ops;
> >       optee->smc.invoke_fn =3D invoke_fn;
> >       optee->smc.sec_caps =3D sec_caps;
> > --
> > 2.43.0
> >

Best regards,
Aristo
