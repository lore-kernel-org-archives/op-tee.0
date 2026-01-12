Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925EFCF45C5
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 19:40:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B6BA243296
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 19:40:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lYtYHCbY;
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5EBE143275
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 10:44:03 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-93f5910b06cso3101212241.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 02:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768214643; x=1768819443; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsIPMVr2V952kp450zzumhqp0nc1hAq2gSm8efLCZlc=;
        b=lYtYHCbY8UKgYTS3hOY/3c0r4OO2T5fuS8hLNadi7puuT2cChV9njZTAiN8e4qtK5Q
         EKAD63M2smrnqTJH/Ud4noetnqmEOQbP326pCQl2DZIsuXUoNN4BUuZhbMrSsP+1DCu7
         sBfD8aBT/JKvuR+Ub66xJKeQsJsRsmqkv1c7CxetJquy4wKpT0qH91GTsJWcbsTa8PAv
         TqOiq0Z58AeZT+z1I4o5pFbTOblD1nfFeK6MqRPeSInE7PloFaywABH0iKxzYyFA7yX8
         YLu7ftRQz/+fEmOE5P5HGPh0SNp5PHv3Qj7bPv1qIJa8/jfXj28a2pOwTsmQ4mvU8YTg
         AIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214643; x=1768819443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DsIPMVr2V952kp450zzumhqp0nc1hAq2gSm8efLCZlc=;
        b=buRqLDUnV489CCngCnWnA3lZSOR6y2UPJR9G4n4IE56s6FFbkPxWqOmWW/co7yyyDi
         t0Xvu0rj4RGG9w7/MWRaEvD4bxv9OPLNmi7HpLKZceDxAoljCjUbu8B0tzLPOi+vqbK6
         fSx9FnMpNQxF0tuTR+EkU0lYSQiBDoUhitKplinP5X5NmLFF8lSkjXqZ2tkRnGxIUk21
         I40Hz99EJI/tOfnohm6viI2EkB94migeTHD4PxK9J3grDPPZHva+KIZl6Dvsm7F1c+Up
         JxjfPN6DautM7BZ4rZq2FOx9bq1yqxhdtKHLUVb70rA+fen+B0OaqKYceBr4ko0q+Z+p
         yf8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzlu7ogWoa7vqiOxMyjfDfF4BXAyKIdDVVXb9tk/rSTDZ8Kc0pdK8Zcu0cnvZq9aDOBvsOvHk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw/Tql2y38aoX1hWeW1cKcnZUYOzJufMK2PF+R4meTN9mvhQMtC
	jmH4DRLiQftUopqBhM/d7kSvdC1A3LTLqXlh6IH4dpillDJAHosx7zKizV1T1LcBanCpaM2z2tJ
	YmHM3oY6QugNKWd4uA10D0JHfSmeoHy0=
X-Gm-Gg: AY/fxX4ACmhYVsBPfPUeWCk0cTW3KUSHTZfcgp+nmRx+6FLN1WLLOSej3t7r27CJdDb
	LPwhr5/p8aTzdZA3S6mRhq6MK3DcW2uADXNbm5fJZk+FE+uGt48tOC7u1bG7fhsCskZJhtxO/Lr
	7MoiNWq4icFWVJSY6kCsKsD5iOGkxgAKCLGTArBxowrpKE+D+HMDYtXIXt9iz8xbAH6dCVGo5kC
	FvZarJyZ4DIM6X8r4fu5mexVwsXSoeDUMPePxR9pNxWNNAPuZXH7dyJOLqqBA47VRxIKHx4
X-Google-Smtp-Source: AGHT+IFcmA5oRMSiPxEcN6qjbB2hTUUzRoGdD9Accc2zTM1tWA2vCGf4ykLEOzcBe830dg2fr+kSzsfOCsJf5jCCaso=
X-Received: by 2002:a05:6102:3f01:b0:5db:de8f:3278 with SMTP id
 ada2fe7eead31-5ec757092f3mr9074630137.10.1768214642681; Mon, 12 Jan 2026
 02:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20260107152607.902735-1-aristo.chen@canonical.com>
 <20260108064517.13854-1-aristo.chen@canonical.com> <20260108064517.13854-2-aristo.chen@canonical.com>
 <20260112095503.GA2835866@rayden>
In-Reply-To: <20260112095503.GA2835866@rayden>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Mon, 12 Jan 2026 18:43:26 +0800
X-Gm-Features: AZwV_QiDf4meejVwH6g7tXElzTP6KLKnYm-R64qKJnr0THIY_ZFVHi8B8dhKw6E
Message-ID: <CAJwFiGLCznis=AN-Mi_skvsEz5NWpy7CqwAs_VTfr576oDwvtQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] tee: optee: store OS revision for TEE core
To: Jens Wiklander <jens.wiklander@linaro.org>
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.222.41:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.41:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5EBE143275
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 32KSWCFBNTCB5VGTSPRCUMJYKCJWATPW
X-Message-ID-Hash: 32KSWCFBNTCB5VGTSPRCUMJYKCJWATPW
X-Mailman-Approved-At: Mon, 12 Jan 2026 19:39:40 +0000
CC: linux-kernel@vger.kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/32KSWCFBNTCB5VGTSPRCUMJYKCJWATPW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens,

Jens Wiklander <jens.wiklander@linaro.org> =E6=96=BC 2026=E5=B9=B41=E6=9C=
=8812=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:55=E5=AF=AB=E9=81=93=
=EF=BC=9A
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
>
> Checkpatch complains with:
> CHECK: Alignment should match open parenthesis
> #62: FILE: drivers/tee/optee/ffa_abi.c:779:
> +static bool optee_ffa_get_os_revision(struct ffa_device *ffa_dev,
> +                                       const struct ffa_ops *ops,
>
> CHECK: Alignment should match open parenthesis
> #142: FILE: drivers/tee/optee/ffa_abi.c:1091:
> +       if (!optee_ffa_get_os_revision(ffa_dev, ffa_ops, &optee->revision=
,
> +                                        false)) {
>
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Aristo Chen =
<jj251510319013@gmail.com>' !=3D 'Signed-off-by: Aristo Chen <aristo.chen@c=
anonical.com>'
>
> total: 0 errors, 1 warnings, 2 checks, 199 lines checked

Sorry for causing the inconvenience, somehow I did not get complained
by the checkpatch.pl
and I will fix the warnings in v7

just out of curiosity and trying to prevent from making the same
mistake again, are you using
command like this?

```
$ ./scripts/checkpatch.pl v6_patch/*
-------------------------------------------------------
v6_patch/v6-0001-tee-add-revision-sysfs-attribute.patch
-------------------------------------------------------
total: 0 errors, 0 warnings, 100 lines checked

v6_patch/v6-0001-tee-add-revision-sysfs-attribute.patch has no obvious
style problems and is ready for submission.
---------------------------------------------------------------
v6_patch/v6-0002-tee-optee-store-OS-revision-for-TEE-core.patch
---------------------------------------------------------------
total: 0 errors, 0 warnings, 199 lines checked

v6_patch/v6-0002-tee-optee-store-OS-revision-for-TEE-core.patch has no
obvious style problems and is ready for submission.
```

As you can see, I did not see any complain from the output, so I was
assuming they are
in a good shape.

>
> Cheers,
> Jens
>
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
