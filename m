Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93874D148B3
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 07:10:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D958E4FFAE
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 07:10:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZlIqQCwO;
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BB1B140AC9
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Jan 2026 02:56:22 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56021b53e9eso813221e0c.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Jan 2026 18:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767840982; x=1768445782; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0+AEGUqsCCF+N6pV3ffxxf/i1loErlOzoQIAxdDv9E=;
        b=ZlIqQCwO8AnDiMZjkWX3GjUYrUFgmNEEyI84MSntuNQKGwL890cDTgv7PX5QLkahaU
         kZuimqCWB8wmbKWcMGPKhu7MiO1WEgRtMwo2d+RtnyflKr82qQvBAc+r2G68UsEYxZUY
         7hArshKHjnx/0fumyAQXNZsg29xbnU0MSxVmb0U1YgbUD+bHGNStHs94I1xd7cWZHC6p
         c3+knAy3CF1zWKS+gTKLrEwd8Bf9wPDjFvGy1LI7935Di1BWE62y2MxWMOYIMuRifp+u
         C1wfE3Civ6lrRB2S5r4HUWNxeHyvE0MPT43XMNy30n4zrvB1axpGvorFcmVa1nmJFvSm
         gfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767840982; x=1768445782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0+AEGUqsCCF+N6pV3ffxxf/i1loErlOzoQIAxdDv9E=;
        b=YTvlaatO+OMRx/+rsCJ8PCut5cJtBUMehVOxjtquAHqdr/JbOSDgxrDr5qa1UP4Ajn
         W/fmts7dIlhqZwV2LEdJLodpNlJZhVqZL7C1cr90K26SO0WUWaV69uCBYVNYZk8UZbwu
         0iWnfXYNPlOzMyyGZknNdmFcWgEuElL7MBlVcrivdgelnvfxJhze/xqdEVbHccVAEX5m
         cnxWtErFB0tfxvp6pwmzWy0CSCYPLV8rOy6D6zGFT+jmo29Q+wCZItWPYYQVi6LW3Oct
         kzmmpQOkF6K8k5HSfvN0KUTV7DRu3SjQiWjr2xAcd4v50yLkE2UEozto4bXrvtV1jDqi
         MsOA==
X-Forwarded-Encrypted: i=1; AJvYcCUGhlksMR82AK5WyBPxvm73n23VS+PahddPCKBarw6x+nINHxau3JXtv7n0eHKzfgcmaUwOYVA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw7vrxvnysxctgNiDVza0h2IUTvvL88LId7IPrSltceFzewp0IN
	KV/e9FgZIMulJ40It8h/gnmk+Ccx99x20/5PQ6CZqiN4mqkmE2/HvQZP+SxMJH6DAaWAZWsMWXy
	foE9myZsJTIDofSf4w1TRQqOpsu9Nesg=
X-Gm-Gg: AY/fxX63B+PkFBJf8yvngVSflr9fZWvIpIb2shr9QcVhqLAqIMgPv8cVcu0ci+8Pwhe
	y+9oQc0+ZNjmaQIpVlpoxEXIwtF4ZAGoipSs+rvTjOnxXwv55eM9Ont/a7vd59PX4YHu2+LBzu8
	H0d7Ex6/AZ6j1nTY8gWhQMnAoqGhmmYSXrguv3hxnjPOZOt+EnfH3kyIv3SXUuIB2+6nOy8i3Z1
	z+rhyxxbj593eKkloCYxhd8NkQJitk2tyoRf28gzQHcFBryceS06u8eFXlPKZslvIAikLPrd6XW
	BAnEFNU=
X-Google-Smtp-Source: AGHT+IEU9bkuHvbidzrrOk6Wo1dpeOopkIHYOmJsUIWXaY0hVVc1p5dnbGTj/UWmeXzUIPbRT7kPIhMUq23LYQmyys8=
X-Received: by 2002:a05:6122:4899:b0:55b:8f06:75c with SMTP id
 71dfb90a1353d-56347faf1aamr1433527e0c.10.1767840982074; Wed, 07 Jan 2026
 18:56:22 -0800 (PST)
MIME-Version: 1.0
References: <20251230051804.6230-1-aristo.chen@canonical.com>
 <20260107152607.902735-1-aristo.chen@canonical.com> <2f4b30fd-8e0a-4482-9bab-a90e32e69839@kernel.org>
In-Reply-To: <2f4b30fd-8e0a-4482-9bab-a90e32e69839@kernel.org>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Thu, 8 Jan 2026 10:55:46 +0800
X-Gm-Features: AQt7F2oPpCUvY2NBAdgCQ7mCtaIoEhtTtbRR6dnO7rbUxXybwr3Hnb96aaApjrI
Message-ID: <CAJwFiGLJVOsu_=H-y82pVE92ZDpVZyqjB=We9ioLqjBsQx8Y5g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] tee: add revision sysfs attribute
To: Mario Limonciello <superm1@kernel.org>
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.171:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.171:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BB1B140AC9
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: CV5JGWRKOOUMFOLEUOWCC7VYUFYLMA6K
X-Message-ID-Hash: CV5JGWRKOOUMFOLEUOWCC7VYUFYLMA6K
X-Mailman-Approved-At: Thu, 08 Jan 2026 07:09:50 +0000
CC: linux-kernel@vger.kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CV5JGWRKOOUMFOLEUOWCC7VYUFYLMA6K/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Mario,

Mario Limonciello <superm1@kernel.org> =E6=96=BC 2026=E5=B9=B41=E6=9C=887=
=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:28=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 1/7/26 9:26 AM, Aristo Chen wrote:
> > Add a generic TEE revision sysfs attribute backed by a new
> > optional get_tee_revision() callback. The revision string is
> > diagnostic-only and must not be used to infer feature support.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > ---
> >   Documentation/ABI/testing/sysfs-class-tee | 10 +++++
> >   drivers/tee/tee_core.c                    | 51 ++++++++++++++++++++++=
-
> >   include/linux/tee_core.h                  |  9 ++++
> >   3 files changed, 69 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/=
ABI/testing/sysfs-class-tee
> > index c9144d16003e..6e783210104e 100644
> > --- a/Documentation/ABI/testing/sysfs-class-tee
> > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > @@ -13,3 +13,13 @@ Description:
> >               space if the variable is absent. The primary purpose
> >               of this variable is to let systemd know whether
> >               tee-supplicant is needed in the early boot with initramfs=
.
> > +
> > +What:                /sys/class/tee/tee{,priv}X/revision
> > +Date:                Dec 2025
> > +KernelVersion:       6.18
>
> This needs to be bumped up and dates pushed out.

I will fix this in the v6 patch, thanks!

>
> > +Contact:     op-tee@lists.trustedfirmware.org
> > +Description:
> > +             Read-only revision string reported by the TEE driver. Thi=
s is
> > +             for diagnostics only and must not be used to infer featur=
e
> > +             support. Use TEE_IOC_VERSION for capability and compatibi=
lity
> > +             checks.
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index d65d47cc154e..0a00499811c1 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -1146,7 +1146,56 @@ static struct attribute *tee_dev_attrs[] =3D {
> >       NULL
> >   };
> >
> > -ATTRIBUTE_GROUPS(tee_dev);
> > +static const struct attribute_group tee_dev_group =3D {
> > +     .attrs =3D tee_dev_attrs,
> > +};
> > +
> > +static ssize_t revision_show(struct device *dev,
> > +                          struct device_attribute *attr, char *buf)
> > +{
> > +     struct tee_device *teedev =3D container_of(dev, struct tee_device=
, dev);
> > +     char version[TEE_REVISION_STR_SIZE];
> > +     int ret;
> > +
> > +     if (!teedev->desc->ops->get_tee_revision)
> > +             return -ENODEV;
> > +
> > +     ret =3D teedev->desc->ops->get_tee_revision(teedev, version,
> > +                                               sizeof(version));
> > +     if (ret)
> > +             return ret;
> > +
> > +     return sysfs_emit(buf, "%s\n", version);
> > +}
> > +static DEVICE_ATTR_RO(revision);
> > +
> > +static struct attribute *tee_revision_attrs[] =3D {
> > +     &dev_attr_revision.attr,
> > +     NULL
> > +};
> > +
> > +static umode_t tee_revision_attr_is_visible(struct kobject *kobj,
> > +                                         struct attribute *attr, int n=
)
> > +{
> > +     struct device *dev =3D kobj_to_dev(kobj);
> > +     struct tee_device *teedev =3D container_of(dev, struct tee_device=
, dev);
> > +
> > +     if (teedev->desc->ops->get_tee_revision)
> > +             return attr->mode;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct attribute_group tee_revision_group =3D {
> > +     .attrs =3D tee_revision_attrs,
> > +     .is_visible =3D tee_revision_attr_is_visible,
> > +};
> > +
> > +static const struct attribute_group *tee_dev_groups[] =3D {
> > +     &tee_dev_group,
> > +     &tee_revision_group,
> > +     NULL
> > +};
> >
> >   static const struct class tee_class =3D {
> >       .name =3D "tee",
> > diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> > index 1f3e5dad6d0d..ee5f0bd41f43 100644
> > --- a/include/linux/tee_core.h
> > +++ b/include/linux/tee_core.h
> > @@ -76,6 +76,9 @@ struct tee_device {
> >   /**
> >    * struct tee_driver_ops - driver operations vtable
> >    * @get_version:    returns version of driver
> > + * @get_tee_revision:        returns revision string (diagnostic only)=
;
>
> Why is this comment here about it being for diagnostics only?  I feel
> it's up to the implementation how it would be used.

According to the previous discussion, we would like to prevent user
thinking about optee os version x.y means z feature, and we should
always use TEE_IOC_VERSION for capability and compatibility
check.

Is there any other specific use case that makes you think removing
the wording is required?

>
> > + *                   do not infer feature support from this, use
> > + *                   TEE_IOC_VERSION instead
> >    * @open:           called for a context when the device file is open=
ed
> >    * @close_context:  called when the device file is closed
> >    * @release:                called to release the context
> > @@ -95,9 +98,12 @@ struct tee_device {
> >    * client closes the device file, even if there are existing referenc=
es to the
> >    * context. The TEE driver can use @close_context to start cleaning u=
p.
> >    */
> > +
> >   struct tee_driver_ops {
> >       void (*get_version)(struct tee_device *teedev,
> >                           struct tee_ioctl_version_data *vers);
> > +     int (*get_tee_revision)(struct tee_device *teedev,
> > +                             char *buf, size_t len);
> >       int (*open)(struct tee_context *ctx);
> >       void (*close_context)(struct tee_context *ctx);
> >       void (*release)(struct tee_context *ctx);
> > @@ -123,6 +129,9 @@ struct tee_driver_ops {
> >       int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *sh=
m);
> >   };
> >
> > +/* Size for TEE revision string buffer used by get_tee_revision(). */
> > +#define TEE_REVISION_STR_SIZE        128
> > +
> >   /**
> >    * struct tee_desc - Describes the TEE driver to the subsystem
> >    * @name:   name of driver
>

Best regards,
Aristo
