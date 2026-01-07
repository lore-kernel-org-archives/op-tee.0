Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49465CFD652
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 15:28:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 85BCF4FF97
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767799734;
	bh=RQ6L+iRakCIIVZ4Q8VvzEgXIqB+VcJtyWBzjUhiDWnM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ldXqCzaD2nwyUYAXhLnP/GI/1hCYxUioKvBhiS/RPTVcihu9gA6GqT8XQcXZpxZ4D
	 AYh09sKHHyhGXmS5333V8EJc7b7X0mPi6DqiT8WDYOmAOCUWZRz45FXP2Np7FpadlF
	 QG69rDdOO77V29xzlR4AzggTSlQoGry+aNqYk9b/JGUuLpvJHGu6LNGKvgDJcMUNEl
	 dxue+amPNLEcMnA1dIJ/JVM/ArP3athBbVUrD2/JGYMsdjM3PZPeTAgU5jjbtC69EF
	 hgwxPqoAUGaIkdNlgiKJt1+90J4APo/9Kmm7n68jxNb1bwNBEsWZBHKx7gO+pB9H1w
	 I+wtVAWmSe+IA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7A0E44FF52
	for <op-tee@lists.trustedfirmware.org>; Wed,  7 Jan 2026 15:28:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GajhOGnC;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DCCD360018;
	Wed,  7 Jan 2026 15:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8816C4CEF1;
	Wed,  7 Jan 2026 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767799715;
	bh=RQ6L+iRakCIIVZ4Q8VvzEgXIqB+VcJtyWBzjUhiDWnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GajhOGnCpKrjaiYDZ0hwZTouNTMoBtWbF7UQcFHjKvTR6Nk0IvtTHQorIuG+UuDFY
	 Rl1r6EHjI9OkzL6Nb/Yfnq1rECXl3aax47UrW1sU3TDxFVNIqoZCWawYM5T6PtahDd
	 uBRqrEfI3ZOUWPnb/PE0MRq2AZwu6Xp/lgWPobFf5+QNAwCkCLkp6bSLeKPOH54acU
	 nHA1TGmS/QLxKJyucjrCEWGL0/t2OZS+NzAhJYWV9FM4/7gHK1vvMpGDTWCZ7RFnK8
	 P6NKV65zZPJEBrXMXpFzym3v0QdIgGG/obQifZSCZYwzIyXAqFpF0+qbqgUWjSGAvo
	 cPRkjlr0sP+UA==
Message-ID: <2f4b30fd-8e0a-4482-9bab-a90e32e69839@kernel.org>
Date: Wed, 7 Jan 2026 09:28:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] tee: add revision sysfs attribute
To: Aristo Chen <jj251510319013@gmail.com>, linux-kernel@vger.kernel.org
References: <20251230051804.6230-1-aristo.chen@canonical.com>
 <20260107152607.902735-1-aristo.chen@canonical.com>
Content-Language: en-US
In-Reply-To: <20260107152607.902735-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7A0E44FF52
X-Spamd-Bar: --
Message-ID-Hash: BVXWJO46AQS4Q3H42OHU3YFMVBO27R2C
X-Message-ID-Hash: BVXWJO46AQS4Q3H42OHU3YFMVBO27R2C
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BVXWJO46AQS4Q3H42OHU3YFMVBO27R2C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mario Limonciello via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mario Limonciello <superm1@kernel.org>

On 1/7/26 9:26 AM, Aristo Chen wrote:
> Add a generic TEE revision sysfs attribute backed by a new
> optional get_tee_revision() callback. The revision string is
> diagnostic-only and must not be used to infer feature support.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   Documentation/ABI/testing/sysfs-class-tee | 10 +++++
>   drivers/tee/tee_core.c                    | 51 ++++++++++++++++++++++-
>   include/linux/tee_core.h                  |  9 ++++
>   3 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
> index c9144d16003e..6e783210104e 100644
> --- a/Documentation/ABI/testing/sysfs-class-tee
> +++ b/Documentation/ABI/testing/sysfs-class-tee
> @@ -13,3 +13,13 @@ Description:
>   		space if the variable is absent. The primary purpose
>   		of this variable is to let systemd know whether
>   		tee-supplicant is needed in the early boot with initramfs.
> +
> +What:		/sys/class/tee/tee{,priv}X/revision
> +Date:		Dec 2025
> +KernelVersion:	6.18

This needs to be bumped up and dates pushed out.

> +Contact:	op-tee@lists.trustedfirmware.org
> +Description:
> +		Read-only revision string reported by the TEE driver. This is
> +		for diagnostics only and must not be used to infer feature
> +		support. Use TEE_IOC_VERSION for capability and compatibility
> +		checks.
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d65d47cc154e..0a00499811c1 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1146,7 +1146,56 @@ static struct attribute *tee_dev_attrs[] = {
>   	NULL
>   };
>   
> -ATTRIBUTE_GROUPS(tee_dev);
> +static const struct attribute_group tee_dev_group = {
> +	.attrs = tee_dev_attrs,
> +};
> +
> +static ssize_t revision_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
> +	char version[TEE_REVISION_STR_SIZE];
> +	int ret;
> +
> +	if (!teedev->desc->ops->get_tee_revision)
> +		return -ENODEV;
> +
> +	ret = teedev->desc->ops->get_tee_revision(teedev, version,
> +						  sizeof(version));
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%s\n", version);
> +}
> +static DEVICE_ATTR_RO(revision);
> +
> +static struct attribute *tee_revision_attrs[] = {
> +	&dev_attr_revision.attr,
> +	NULL
> +};
> +
> +static umode_t tee_revision_attr_is_visible(struct kobject *kobj,
> +					    struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
> +
> +	if (teedev->desc->ops->get_tee_revision)
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
> +static const struct attribute_group tee_revision_group = {
> +	.attrs = tee_revision_attrs,
> +	.is_visible = tee_revision_attr_is_visible,
> +};
> +
> +static const struct attribute_group *tee_dev_groups[] = {
> +	&tee_dev_group,
> +	&tee_revision_group,
> +	NULL
> +};
>   
>   static const struct class tee_class = {
>   	.name = "tee",
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index 1f3e5dad6d0d..ee5f0bd41f43 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -76,6 +76,9 @@ struct tee_device {
>   /**
>    * struct tee_driver_ops - driver operations vtable
>    * @get_version:	returns version of driver
> + * @get_tee_revision:	returns revision string (diagnostic only);

Why is this comment here about it being for diagnostics only?  I feel 
it's up to the implementation how it would be used.

> + *			do not infer feature support from this, use
> + *			TEE_IOC_VERSION instead
>    * @open:		called for a context when the device file is opened
>    * @close_context:	called when the device file is closed
>    * @release:		called to release the context
> @@ -95,9 +98,12 @@ struct tee_device {
>    * client closes the device file, even if there are existing references to the
>    * context. The TEE driver can use @close_context to start cleaning up.
>    */
> +
>   struct tee_driver_ops {
>   	void (*get_version)(struct tee_device *teedev,
>   			    struct tee_ioctl_version_data *vers);
> +	int (*get_tee_revision)(struct tee_device *teedev,
> +				char *buf, size_t len);
>   	int (*open)(struct tee_context *ctx);
>   	void (*close_context)(struct tee_context *ctx);
>   	void (*release)(struct tee_context *ctx);
> @@ -123,6 +129,9 @@ struct tee_driver_ops {
>   	int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *shm);
>   };
>   
> +/* Size for TEE revision string buffer used by get_tee_revision(). */
> +#define TEE_REVISION_STR_SIZE	128
> +
>   /**
>    * struct tee_desc - Describes the TEE driver to the subsystem
>    * @name:	name of driver

