Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A7ED26D9B
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 09:50:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 04F5D4326D
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 09:50:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VTrdy0VG;
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 54FA743252
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 09:50:26 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e12fd71984so4418785fac.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 01:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768211425; x=1768816225; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7zGDqqX/Vm4a+CCdOgZFFPQoTxuIRR/oPkNZgulnio=;
        b=VTrdy0VGhD+DYNyg5c9LVF1G0tZAYWyrjIrZQ9K9sstIWRFuLq+ZPUzIvqWMmc3yYQ
         8GkEhpP+DHeeCx2H7poj1SH081exV8ckHe39AT6vsAECI0W92wbAt+6nrLQQ0r0jF0xi
         Qsb0qKSZUo2Dntiqs6CmYcLjIDi+ARVKUsJxiPQ0YXBDboCoRzY9fuL2zVKI7j2WS9fZ
         SOhLsu8/FT3Ga99PiCvrLcO/xg5rVzhTIZO9CkY9N1ilMZL5si0YoG7DiYrS2GuqmzFp
         9Q4rNTtR1LgjyAyCU6Ij9Q6v6lUrJHdHHunT1buRZjoQj09o51uHFsHT6L5pE3QPZ9U8
         lFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768211425; x=1768816225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7zGDqqX/Vm4a+CCdOgZFFPQoTxuIRR/oPkNZgulnio=;
        b=EDvlL2Q0MWnL6GuWja7btYIBRtcqsS47kUWhFcrz3Ws9Ym9zggU+xxnAwKl0GoQ7gR
         wg+R+/8BPGnvdTu98nZtgFKCIsTBn4TY6byMTNlDqXwqbVOGZeaqN2RdV3kcVDR1qUxN
         jvVy0pKujw2IWCpwh3Rrss4QjFXw2VKIq0HmzG0mm1/22V1iDARdwPJzcs8Y5qqQ+bXB
         f1HaPveL9KdYYvn046JUVkmI8VyrghNdwd9+BudolmRpu/c8LkLFm2eTIX/hVtLco0wT
         8UHFUh4Jn/Q5ch0Zi5iD3/Av4TVD1+aUL56PkJELqkZ2aHyoztjxWh+FM7PJTXZi+F9x
         gDKA==
X-Forwarded-Encrypted: i=1; AJvYcCXl7goABdLVDKyliWAjfJdr/ak7MJQ0RIvLIf9cCByUrtzeRbav1RscxyqL3cGPyi6eWDvv/k8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywd2fMk15aWdETN4i6vABCX/g+svk/gTUcaM4DHEPcvr8+WVth3
	cyFWHYSyuea831baPh3A4i+/1PLBY7iG6a48UwzAUeRKq1f+XlHBYQrHHgG8tBPXjszTXRoLlI/
	P90OqYF6xf4/28vd3vrINOPQsWxyrTOwRNTCip+4ygWQO
X-Gm-Gg: AY/fxX4RToYzfH4fG4Qsrz3jRWgGe9I1E6c5SaHntNscFcfF+UR+J/mBcSa1SKjVxVR
	QdrAbpkGdv5LqTfXxmyeVZXDDpvHC2H8qtl8A9zjLt16U8vaQHkrjGHhnTC53wasdCeS2YxfmTm
	oiymtgqFS9lo86OYThoO8Tp0QLAz9n8Yml7pVk7rXfmEkJrGAT6RGnWTLPmODPGSkOToIVazfBr
	lljQ2wxghpYp2bPOC/KUotjtzp/bHA+y0CmUsgOl9p++U/102Q1CniYpSZ+X5oPbfa9OxA3Ccb8
	d7V29/9ldW+3xh66ipJ2pktU4A==
X-Google-Smtp-Source: AGHT+IFGSMsiom2lUHtH17vh5gbJADpw5OJNuaVJeLbrLzkJlo7/fEMPip2Cal8vtD9xJHMsujoq96Pw6QeAJPkeF64=
X-Received: by 2002:a05:6820:f00c:b0:65f:6770:f517 with SMTP id
 006d021491bc7-65f6770f943mr5473247eaf.29.1768211425582; Mon, 12 Jan 2026
 01:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20260107152607.902735-1-aristo.chen@canonical.com> <20260108064517.13854-1-aristo.chen@canonical.com>
In-Reply-To: <20260108064517.13854-1-aristo.chen@canonical.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 12 Jan 2026 10:50:14 +0100
X-Gm-Features: AZwV_QimTwEqw02VJmJokP6LQravk_i-ufEVlLlKMHWrgH6uKvLszDoyGdZNU84
Message-ID: <CAHUa44ESiqjr0paiSTFFceqzwf5ntMaHUs7aqvHNYqHMLEpOAg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] tee: add revision sysfs attribute
To: Aristo Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.52:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.52:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 54FA743252
X-Spamd-Bar: --
Message-ID-Hash: 3EBAXTRZE7SIILLDGJWZI4KB65NFSJSK
X-Message-ID-Hash: 3EBAXTRZE7SIILLDGJWZI4KB65NFSJSK
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3EBAXTRZE7SIILLDGJWZI4KB65NFSJSK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, Jan 8, 2026 at 7:45=E2=80=AFAM Aristo Chen <jj251510319013@gmail.co=
m> wrote:
>
> Add a generic TEE revision sysfs attribute backed by a new
> optional get_tee_revision() callback. The revision string is
> diagnostic-only and must not be used to infer feature support.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  Documentation/ABI/testing/sysfs-class-tee | 10 +++++
>  drivers/tee/tee_core.c                    | 51 ++++++++++++++++++++++-
>  include/linux/tee_core.h                  |  9 ++++
>  3 files changed, 69 insertions(+), 1 deletion(-)

checkpatch complains with:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Aristo
Chen <jj251510319013@gmail.com>' !=3D 'Signed-off-by: Aristo Chen
<aristo.chen@canonical.com>'

total: 0 errors, 1 warnings, 0 checks, 100 lines checked

Cheers,
Jens

>
> diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/AB=
I/testing/sysfs-class-tee
> index c9144d16003e..1a0a3050aaa9 100644
> --- a/Documentation/ABI/testing/sysfs-class-tee
> +++ b/Documentation/ABI/testing/sysfs-class-tee
> @@ -13,3 +13,13 @@ Description:
>                 space if the variable is absent. The primary purpose
>                 of this variable is to let systemd know whether
>                 tee-supplicant is needed in the early boot with initramfs=
.
> +
> +What:          /sys/class/tee/tee{,priv}X/revision
> +Date:          Jan 2026
> +KernelVersion: 6.19
> +Contact:       op-tee@lists.trustedfirmware.org
> +Description:
> +               Read-only revision string reported by the TEE driver. Thi=
s is
> +               for diagnostics only and must not be used to infer featur=
e
> +               support. Use TEE_IOC_VERSION for capability and compatibi=
lity
> +               checks.
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d65d47cc154e..0a00499811c1 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1146,7 +1146,56 @@ static struct attribute *tee_dev_attrs[] =3D {
>         NULL
>  };
>
> -ATTRIBUTE_GROUPS(tee_dev);
> +static const struct attribute_group tee_dev_group =3D {
> +       .attrs =3D tee_dev_attrs,
> +};
> +
> +static ssize_t revision_show(struct device *dev,
> +                            struct device_attribute *attr, char *buf)
> +{
> +       struct tee_device *teedev =3D container_of(dev, struct tee_device=
, dev);
> +       char version[TEE_REVISION_STR_SIZE];
> +       int ret;
> +
> +       if (!teedev->desc->ops->get_tee_revision)
> +               return -ENODEV;
> +
> +       ret =3D teedev->desc->ops->get_tee_revision(teedev, version,
> +                                                 sizeof(version));
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%s\n", version);
> +}
> +static DEVICE_ATTR_RO(revision);
> +
> +static struct attribute *tee_revision_attrs[] =3D {
> +       &dev_attr_revision.attr,
> +       NULL
> +};
> +
> +static umode_t tee_revision_attr_is_visible(struct kobject *kobj,
> +                                           struct attribute *attr, int n=
)
> +{
> +       struct device *dev =3D kobj_to_dev(kobj);
> +       struct tee_device *teedev =3D container_of(dev, struct tee_device=
, dev);
> +
> +       if (teedev->desc->ops->get_tee_revision)
> +               return attr->mode;
> +
> +       return 0;
> +}
> +
> +static const struct attribute_group tee_revision_group =3D {
> +       .attrs =3D tee_revision_attrs,
> +       .is_visible =3D tee_revision_attr_is_visible,
> +};
> +
> +static const struct attribute_group *tee_dev_groups[] =3D {
> +       &tee_dev_group,
> +       &tee_revision_group,
> +       NULL
> +};
>
>  static const struct class tee_class =3D {
>         .name =3D "tee",
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index 1f3e5dad6d0d..ee5f0bd41f43 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -76,6 +76,9 @@ struct tee_device {
>  /**
>   * struct tee_driver_ops - driver operations vtable
>   * @get_version:       returns version of driver
> + * @get_tee_revision:  returns revision string (diagnostic only);
> + *                     do not infer feature support from this, use
> + *                     TEE_IOC_VERSION instead
>   * @open:              called for a context when the device file is open=
ed
>   * @close_context:     called when the device file is closed
>   * @release:           called to release the context
> @@ -95,9 +98,12 @@ struct tee_device {
>   * client closes the device file, even if there are existing references =
to the
>   * context. The TEE driver can use @close_context to start cleaning up.
>   */
> +
>  struct tee_driver_ops {
>         void (*get_version)(struct tee_device *teedev,
>                             struct tee_ioctl_version_data *vers);
> +       int (*get_tee_revision)(struct tee_device *teedev,
> +                               char *buf, size_t len);
>         int (*open)(struct tee_context *ctx);
>         void (*close_context)(struct tee_context *ctx);
>         void (*release)(struct tee_context *ctx);
> @@ -123,6 +129,9 @@ struct tee_driver_ops {
>         int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *sh=
m);
>  };
>
> +/* Size for TEE revision string buffer used by get_tee_revision(). */
> +#define TEE_REVISION_STR_SIZE  128
> +
>  /**
>   * struct tee_desc - Describes the TEE driver to the subsystem
>   * @name:      name of driver
> --
> 2.43.0
>
