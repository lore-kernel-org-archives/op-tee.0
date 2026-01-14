Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F07ED37E55
	for <op-tee@archiver.kernel.org>; Wed, 14 Jan 2026 15:43:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 737F0432A6
	for <op-tee@archiver.kernel.org>; Wed, 14 Jan 2026 15:43:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uCNic5h/;
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A8C8D432A6
	for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 15:43:08 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c78da5936so354418b6e.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 07:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768405388; x=1769010188; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/aGLatx0ZaG5SHT6dsIn8mLqpN1/D9EyBTDeiW+oDA=;
        b=uCNic5h/u4Jz09cXMK6vj5NtdYvzZX5CIkneK54gAcyHIZ4hh2VoiQkI1qD1AG4U57
         VBwDK7NRG3uZ/+aJBx1ajVFGBxhz2VQuSJvWjruVadV2Tvxr6NW4AuB4K3xyn8Jj3HG0
         K160mBRLjhg6b1gLDanwZlyoxfH9aBddKimWxdsn6IX84zxONRgldp42oTTG9gkAbBwc
         0te15lA++oXVrwJWh8yzBIwEAQSVdwQFQqR/mYj0v7/r8SPEdEzhxCY1Vv/cMPpar1r4
         nLmCB3iuxeOjlrZTFNlL8XTpwBNoN/grR4Xnd3wmIXiK3j3ah6YcBUxxofBDIBkciqmo
         K7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405388; x=1769010188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/aGLatx0ZaG5SHT6dsIn8mLqpN1/D9EyBTDeiW+oDA=;
        b=W/haevCrQDx10R0QL2csW9ptiPv4aGeBIQLyCAsEsfnxMEPOJQ3v1g+kvgtO8Bg+ix
         ZQQKGx2SGpbMPWu/L04WB2mrlFHaxZV4LjEXF38lBVhnB8FHRSDhnJNWAb70pbvwYXhq
         TKm1ruSr69r3iOzjA4u9SKu8gznR5Ln9oou+nf/Y/Depa4peEtRgstgbLUFYbmbY4GI3
         8GlKKNkVhBzjxHjJf5QQyIRrJFY7O/aDFl+SPo8W6lM/qFaip0RagHeGmKg8UJ6I9+m+
         19jJt8Kw1VEs2FpDJDF9zhwq+W58JjQHNYtCXDZ1LlKCX+2a0yLwzLfDbXv3UWsVEXQ8
         2seA==
X-Forwarded-Encrypted: i=1; AJvYcCUR/y1spX4RAxPDrmdzcb0D/LAP1fH6+irp3X02ZIXgE7R/fg+7xIyIotg0Y8VzPWSlgDaDPbA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxmTUgNUFiOVXZmCiCSaq5IySaJ4W8Yo4ej+VSLG2PZP2s5XMfD
	nTVhiC+/t4/KJfM6gUaz2tUaSCF+ySWdgLv6Sm+Y3kjte2RgNEDT6iKW+HWkuoEtdzbcW8PA1Bs
	1voxGRqGngyUtKA3o/rAOSMeUWLdEFf00lddKhjPKse8V
X-Gm-Gg: AY/fxX7kynjnu0BFERwntCTBPDmMUs4TkVHV2i8qx+i9jcv5DyefDR9LCmHY5lH9FMl
	plYQ28/SQVoHw0sFbrp7id5J4qcfJLZngLKQ+PQv1LPwWZZhYKsTu8LyP+50fa5nSig5OPv65G6
	YUGc4DjfIcB9RivV9ZXh00yRmSDKAINo3/EqoZTfgJBtZwS5pExU1VFOKIbgIEONRJ59q5mOCD4
	Ig883ndjJ7CNNRKLlParY5tWk5dGwazxRL/oW00QSQ3zAG3taV0Ut9sWdKgdo9cJh0rF/dGhHmQ
	+575CmLlsyuSUb1Zhp9K0suwow==
X-Received: by 2002:a05:6808:138c:b0:450:89ee:922b with SMTP id
 5614622812f47-45c71419880mr1863627b6e.22.1768405387965; Wed, 14 Jan 2026
 07:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20260108064517.13854-1-aristo.chen@canonical.com> <20260112154833.78546-1-aristo.chen@canonical.com>
In-Reply-To: <20260112154833.78546-1-aristo.chen@canonical.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 14 Jan 2026 16:42:56 +0100
X-Gm-Features: AZwV_QjCd2YJplibtH6LRO-_DvcLTfl3rXxivd84EY8R7JZDPlOTPCWCPGQI6os
Message-ID: <CAHUa44HULHuYcA0x47sw2=3ODLuzzXU_3tBwM7y1TSrWAk+sVA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] tee: add revision sysfs attribute
To: Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.172:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	DNSWL_BLOCKED(0.00)[209.85.167.172:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A8C8D432A6
X-Spamd-Bar: --
Message-ID-Hash: SC5OW2FYONUJGMU4DSQZ3TZ7CY7ABC44
X-Message-ID-Hash: SC5OW2FYONUJGMU4DSQZ3TZ7CY7ABC44
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SC5OW2FYONUJGMU4DSQZ3TZ7CY7ABC44/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Jan 12, 2026 at 4:48=E2=80=AFPM Aristo Chen <aristo.chen@canonical.=
com> wrote:
>
> Add a generic TEE revision sysfs attribute backed by a new
> optional get_tee_revision() callback. The revision string is
> diagnostic-only and must not be used to infer feature support.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  Documentation/ABI/testing/sysfs-class-tee | 10 +++++
>  drivers/tee/tee_core.c                    | 51 ++++++++++++++++++++++-
>  include/linux/tee_core.h                  |  9 ++++
>  3 files changed, 69 insertions(+), 1 deletion(-)

Looks good, I'm picking up this.

Thanks,
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
