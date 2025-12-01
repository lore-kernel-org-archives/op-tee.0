Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25D6D116F3
	for <op-tee@archiver.kernel.org>; Mon,  1 Dec 2025 13:30:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 38F4050072
	for <op-tee@archiver.kernel.org>; Mon,  1 Dec 2025 13:30:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aDowLjQN;
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2FF2643154
	for <op-tee@lists.trustedfirmware.org>; Mon,  1 Dec 2025 11:48:14 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dbd9c7e468so1739582137.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 01 Dec 2025 03:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764589693; x=1765194493; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nnXpYDrCoaqLl8fDHiiM83WAPrZ9Fbn5oqCW111z/M=;
        b=aDowLjQN/8UQ4vxU4zwA7LzcyYPK4H2Q+Z4Qeaf6u3Iui8Z0DFy6k28fvwStJhpVNd
         01BxLQb2nCcT1ykJSeoiqmnRHtDNXZsKpXbMCHkMqZWJ1hQGNLXOd9zjTOO/2hyohtiC
         rxa6rTbfxXqutkszmE90v4mKfYvfCVot/gu+gE6ypApZb1oEvs4ywhUt9sXPDyEbHHyy
         0fdBewXzC9wmze/hDu8Qz3/SrPzH9MkomHwPH+6U1RbdQlC6dja30Gm+ontAhW3+1ilF
         H15ZOJPYd6bvvSV09xy/iYaeIuHfljSNrrJB1aQLxfzhqYC09t+yk+12CvGGnh9zYBnx
         ttpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764589693; x=1765194493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nnXpYDrCoaqLl8fDHiiM83WAPrZ9Fbn5oqCW111z/M=;
        b=PLseTdr6NCWf9gaJ+5HIaV3c39DiCPuUZ+y9cPdtyGQRgtBfu4maosbvBE/BhsZ0Sh
         yk68mac3hl8PObikcB7dk7IbEWSK07/rFbHQhdkZAqx4EzAFsOcwdwgnbXPnrVOgBqqZ
         kKprgS9gLCYw5CZLpz8oqJ7aF6biHXZQ816rOsxR1W1Bs19Pth3jJ49J615+pniDraAp
         4W8yF9WeASH3SOzjYiK1F9Tij6PMn71WJNkjRQWMS5RxbFT9zNnzv0022X8SJT1kqSUs
         yPt0VJhou+gXz934BkbeWLFfkP92k4MDvjR0FfuRkDQl5ktO+c9JnPUqegSu1a/yYP3m
         c0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVfOiOUhGd4Iy3SRq61bcYU3WA3rXRsVN6XlHmVyGTfIgWa0O+KJRqgHSV9YdtKat+v0Ig3Lxw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy2GawdYZHyRPN6UqUGj6bd2dUCQj2CKmqhX5EWqR02pFhNEqKC
	n2a/BYffzWrr/Fnt7Qx3xVT+Gu5jAxHPu1cEMK04Kq7vuidLMVF+XDyPwk1oinwfLFji8kDRUE2
	cUa97IdA9EfePEkmFQxe6X7kBLCy/Vhk=
X-Gm-Gg: ASbGncumXDwT7yuC+RvPG8aI/s/fR0YTDjlyisPK6l6vvi9O6pnbWwIwb+CzlQrGprj
	ozZwfHP2QH1XkzDQosF/9PTtzHKL30cSy5u1O2ao7Zz1DQIeNuvgfmlmQWoo/OVLSi+JbeNaw19
	84Ki2A5mS7OraPAuZj3Zu8Nxoq6ShdAz+LDKJ9Uf16uwwPqr/SW8DfT1DCp5WxOZ8wniLCfcSoR
	bmfczFvpr+GLiaE8PmfYOXNSb8/iDYhkWDDe/CRejeTdfzm+7aFY1vsy+SJqin2NiUBKcI=
X-Google-Smtp-Source: AGHT+IFqY4h2NpY86j+8+RSQ2/LtjcK5xcXoPlpx7nYRJjaJ1a6+U5PGAOL0d+GW//GhuZoTtpAudzpxdJ7/aub/+7s=
X-Received: by 2002:a67:e7cc:0:b0:5db:cc92:26e7 with SMTP id
 ada2fe7eead31-5e1de3ceb1emr12395856137.38.1764589693542; Mon, 01 Dec 2025
 03:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20251121141230.489294-1-jj251510319013@gmail.com>
 <20251122145924.381725-1-jj251510319013@gmail.com> <CAHUa44HFC+BTO3KfaNF1LHiM7frgt2myzZ_85Mbf1t2gUY9iSg@mail.gmail.com>
 <aSVgctqRSy5_vvkN@sumit-X1> <aSVhBn0LR2CwM9p3@sumit-X1>
In-Reply-To: <aSVhBn0LR2CwM9p3@sumit-X1>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Mon, 1 Dec 2025 19:47:37 +0800
X-Gm-Features: AWmQ_bkYPvRZqWrzgKEOn4NIBOirfTOtWTXTQZxsAb1oZNlrkxy_5JHX1m_P4F4
Message-ID: <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ---
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2FF2643154
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	URIBL_BLOCKED(0.00)[canonical.com:email];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.217.42:from];
	DNSWL_BLOCKED(0.00)[209.85.217.42:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	FREEMAIL_ENVFROM(0.00)[gmail.com]
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: ZC65JSVEAH72H7TRJQKNVGJBDPNBSSXK
X-Message-ID-Hash: ZC65JSVEAH72H7TRJQKNVGJBDPNBSSXK
X-Mailman-Approved-At: Mon, 01 Dec 2025 13:29:50 +0000
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZC65JSVEAH72H7TRJQKNVGJBDPNBSSXK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

Sumit Garg <sumit.garg@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=9C=8825=E6=
=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Nov 25, 2025 at 01:23:22PM +0530, Sumit Garg via OP-TEE wrote:
> > On Mon, Nov 24, 2025 at 08:15:04AM +0100, Jens Wiklander wrote:
> > > Hi,
> > >
> > > On Sat, Nov 22, 2025 at 4:00=E2=80=AFPM Wei Ming Chen <jj251510319013=
@gmail.com> wrote:
> > > >
> > > > From: Aristo Chen <aristo.chen@canonical.com>
> > > >
> > > > Today the only way to read the OP-TEE OS version is from dmesg/jour=
nal
> > > > logs, which can be lost as buffers roll over. Capture the OS revisi=
on
> > > > (major/minor/build_id) from secure world for both SMC and FF-A ABIs=
, store
> > > > it in the OP-TEE driver, and expose a stable userspace readout via
> > > > /sys/class/tee/tee*/optee_os_revision.
> > > >
> > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > > ---
> > > >  drivers/tee/optee/core.c          | 19 +++++++++++++++++++
> > > >  drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
> > > >  drivers/tee/optee/optee_private.h | 17 +++++++++++++++++
> > > >  drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
> > > >  4 files changed, 58 insertions(+), 4 deletions(-)
> > >
> > > This appears to be a feature that could be useful for all TEEs.
> >
> > True, it is something that TEE core should support. Although I would
> > have preferred to extend TEE_IOC_VERSION since that's the common way th=
e
> > user-space library get's TEE implementation specific information. But
> > since it being already a user-space ABI which doesn't offer extension.
> > Maybe we can consider adding TEE_IOC_REVERSION instead of sysfs.
>
> Ah, typo here:
>
> s/TEE_IOC_REVERSION/TEE_IOC_REVISION/
>
> -Sumit
>
> >
> > But before doing that we need to know who is the actual consumer here
> > from user-space perspective? Will the client applications also depend o=
n
> > the TEE implementation revision?
My current thinking is that if the TEE revision is exposed, users can write=
 a
script to capture the platform state and record the exact secure OS revisio=
n
even after the dmesg/journalctl logs have rolled over. This would significa=
ntly
improve bug triage and regression tracking.

In my case, I have a package with precompiled xtest binaries for multiple
releases (from 3.14 to 4.6), and I work with different platforms that run
different OP-TEE OS versions. Having a reliable way to obtain the TEE
revision would help a lot, as it would allow me to select the correct xtest
version when running tests.
> >
> > > If so,
> > > let's take a step back to see what's needed. We can add the sysfs
> > > attribute from drivers/tee/tee_core.c and add another optional
> > > callback to struct tee_driver_ops, such as get_tee_revision(). For
> > > OP-TEE, the specific information we want to share is clear, but other
> > > TEEs might have additional or different data. What do others think?
> >
> > Implementation wise, this sounds like a reasonable approach.
> >
> > -Sumit
> >
> > >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > > index 5b62139714ce..66409cf5da1c 100644
> > > > --- a/drivers/tee/optee/core.c
> > > > +++ b/drivers/tee/optee/core.c
> > > > @@ -83,8 +83,27 @@ static ssize_t rpmb_routing_model_show(struct de=
vice *dev,
> > > >  }
> > > >  static DEVICE_ATTR_RO(rpmb_routing_model);
> > > >
> > > > +static ssize_t optee_os_revision_show(struct device *dev,
> > > > +                                     struct device_attribute *attr=
, char *buf)
> > > > +{
> > > > +       struct optee *optee =3D dev_get_drvdata(dev);
> > > > +       struct optee_version_info *v;
> > > > +
> > > > +       if (!optee)
> > > > +               return -ENODEV;
> > > > +
> > > > +       v =3D &optee->version_info;
> > > > +       if (v->os_build_id)
> > > > +               return sysfs_emit(buf, "%u.%u (%016llx)\n", v->os_m=
ajor,
> > > > +                                 v->os_minor, (unsigned long long)=
v->os_build_id);
> > > > +
> > > > +       return sysfs_emit(buf, "%u.%u\n", v->os_major, v->os_minor)=
;
> > > > +}
> > > > +static DEVICE_ATTR_RO(optee_os_revision);
> > > > +
> > > >  static struct attribute *optee_dev_attrs[] =3D {
> > > >         &dev_attr_rpmb_routing_model.attr,
> > > > +       &dev_attr_optee_os_revision.attr,
> > > >         NULL
> > > >  };
> > > >
> > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_ab=
i.c
> > > > index bf8390789ecf..3d4f35599dd1 100644
> > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > @@ -776,7 +776,8 @@ static int optee_ffa_reclaim_protmem(struct opt=
ee *optee,
> > > >   */
> > > >
> > > >  static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev=
,
> > > > -                                       const struct ffa_ops *ops)
> > > > +                                       const struct ffa_ops *ops,
> > > > +                                       struct optee_version_info *=
version_info)
> > > >  {
> > > >         const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
> > > >         struct ffa_send_direct_data data =3D {
> > > > @@ -806,6 +807,12 @@ static bool optee_ffa_api_is_compatible(struct=
 ffa_device *ffa_dev,
> > > >                 pr_err("Unexpected error %d\n", rc);
> > > >                 return false;
> > > >         }
> > > > +       if (version_info) {
> > > > +               version_info->os_major =3D data.data0;
> > > > +               version_info->os_minor =3D data.data1;
> > > > +               version_info->os_build_id =3D data.data2;
> > > > +       }
> > > > +
> > > >         if (data.data2)
> > > >                 pr_info("revision %lu.%lu (%08lx)",
> > > >                         data.data0, data.data1, data.data2);
> > > > @@ -1034,6 +1041,7 @@ static int optee_ffa_probe(struct ffa_device =
*ffa_dev)
> > > >  {
> > > >         const struct ffa_notifier_ops *notif_ops;
> > > >         const struct ffa_ops *ffa_ops;
> > > > +       struct optee_version_info version_info =3D { };
> > > >         unsigned int max_notif_value;
> > > >         unsigned int rpc_param_count;
> > > >         struct tee_shm_pool *pool;
> > > > @@ -1047,7 +1055,7 @@ static int optee_ffa_probe(struct ffa_device =
*ffa_dev)
> > > >         ffa_ops =3D ffa_dev->ops;
> > > >         notif_ops =3D ffa_ops->notifier_ops;
> > > >
> > > > -       if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
> > > > +       if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &version=
_info))
> > > >                 return -EINVAL;
> > > >
> > > >         if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> > > > @@ -1059,6 +1067,7 @@ static int optee_ffa_probe(struct ffa_device =
*ffa_dev)
> > > >         optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
> > > >         if (!optee)
> > > >                 return -ENOMEM;
> > > > +       optee->version_info =3D version_info;
> > > >
> > > >         pool =3D optee_ffa_shm_pool_alloc_pages();
> > > >         if (IS_ERR(pool)) {
> > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/=
optee_private.h
> > > > index db9ea673fbca..3e7bcd44976b 100644
> > > > --- a/drivers/tee/optee/optee_private.h
> > > > +++ b/drivers/tee/optee/optee_private.h
> > > > @@ -19,6 +19,22 @@
> > > >
> > > >  #define OPTEE_MAX_ARG_SIZE     1024
> > > >
> > > > +/**
> > > > + * struct optee_version_info - OP-TEE OS revision reported by secu=
re world
> > > > + * @os_major:          OP-TEE OS major version
> > > > + * @os_minor:          OP-TEE OS minor version
> > > > + * @os_build_id:       OP-TEE OS build identifier (0 if unspecifie=
d)
> > > > + *
> > > > + * Values come from OPTEE_SMC_CALL_GET_OS_REVISION (SMC ABI) or
> > > > + * OPTEE_FFA_GET_OS_VERSION (FF-A ABI); this is the trusted OS rev=
ision, not an
> > > > + * FF-A ABI version.
> > > > + */
> > > > +struct optee_version_info {
> > > > +       u32 os_major;
> > > > +       u32 os_minor;
> > > > +       u64 os_build_id;
> > > > +};
> > > > +
> > > >  /* Some Global Platform error codes used in this driver */
> > > >  #define TEEC_SUCCESS                   0x00000000
> > > >  #define TEEC_ERROR_BAD_PARAMETERS      0xFFFF0006
> > > > @@ -249,6 +265,7 @@ struct optee {
> > > >         bool in_kernel_rpmb_routing;
> > > >         struct work_struct scan_bus_work;
> > > >         struct work_struct rpmb_scan_bus_work;
> > > > +       struct optee_version_info version_info;
> > > >  };
> > > >
> > > >  struct optee_session {
> > > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_ab=
i.c
> > > > index 0be663fcd52b..07c703609320 100644
> > > > --- a/drivers/tee/optee/smc_abi.c
> > > > +++ b/drivers/tee/optee/smc_abi.c
> > > > @@ -1323,7 +1323,8 @@ static bool optee_msg_api_uid_is_optee_image_=
load(optee_invoke_fn *invoke_fn)
> > > >  }
> > > >  #endif
> > > >
> > > > -static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> > > > +static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
> > > > +                                     struct optee_version_info *ve=
rsion_info)
> > > >  {
> > > >         union {
> > > >                 struct arm_smccc_res smccc;
> > > > @@ -1337,6 +1338,12 @@ static void optee_msg_get_os_revision(optee_=
invoke_fn *invoke_fn)
> > > >         invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0,=
 0,
> > > >                   &res.smccc);
> > > >
> > > > +       if (version_info) {
> > > > +               version_info->os_major =3D res.result.major;
> > > > +               version_info->os_minor =3D res.result.minor;
> > > > +               version_info->os_build_id =3D res.result.build_id;
> > > > +       }
> > > > +
> > > >         if (res.result.build_id)
> > > >                 pr_info("revision %lu.%lu (%0*lx)", res.result.majo=
r,
> > > >                         res.result.minor, (int)sizeof(res.result.bu=
ild_id) * 2,
> > > > @@ -1727,6 +1734,7 @@ static int optee_probe(struct platform_device=
 *pdev)
> > > >         unsigned int thread_count;
> > > >         struct tee_device *teedev;
> > > >         struct tee_context *ctx;
> > > > +       struct optee_version_info version_info =3D { };
> > > >         u32 max_notif_value;
> > > >         u32 arg_cache_flags;
> > > >         u32 sec_caps;
> > > > @@ -1745,7 +1753,7 @@ static int optee_probe(struct platform_device=
 *pdev)
> > > >                 return -EINVAL;
> > > >         }
> > > >
> > > > -       optee_msg_get_os_revision(invoke_fn);
> > > > +       optee_msg_get_os_revision(invoke_fn, &version_info);
> > > >
> > > >         if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
> > > >                 pr_warn("api revision mismatch\n");
> > > > @@ -1814,6 +1822,7 @@ static int optee_probe(struct platform_device=
 *pdev)
> > > >                 rc =3D -ENOMEM;
> > > >                 goto err_free_shm_pool;
> > > >         }
> > > > +       optee->version_info =3D version_info;
> > > >
> > > >         optee->ops =3D &optee_ops;
> > > >         optee->smc.invoke_fn =3D invoke_fn;
> > > > --
> > > > 2.43.0
> > > >
