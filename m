Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E73C2A072
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 04:53:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8D9474FF15
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 04:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767588822;
	bh=L2BPLF+zzAad5IEvfr0tR9S6DLXuYtzVCAnaigKb9v0=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=KlL8cVJNsnIvrIkkpNkNovZb0N9qWxzLcZBJczOk9D8MFIq21zw1Wu73bBwqT0aLT
	 LLV55+fhMFm9QMffToKxzeVwDMi43yFPBOEdiRph7XHDvTqVZ80N9GoPGGrn7oWlXt
	 tFw6bhIWNd/7AW2JxQM3GEnkfKTBLpFB6eIh7VbnQs4X075wN+6Yi1LE3m5RGjlGHl
	 a8q2waScjYJ6l/bNoHDTZLZDOD1ap55EL1hX+lFYPW5alwWF19umL2uafxCj36569h
	 eflCddVAPek076AyOeT585NaYFWvmQt/mjQJ27FnUoA82aEXzPN5x83nS683BZZyGX
	 0GG0zLoqH5tDw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 19EC543216
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 04:53:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ClYtHQU8;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 858B260010;
	Mon,  5 Jan 2026 04:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D45C116D0;
	Mon,  5 Jan 2026 04:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767588803;
	bh=L2BPLF+zzAad5IEvfr0tR9S6DLXuYtzVCAnaigKb9v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClYtHQU88+0b90+Uf2COLk0ZGIXE7wa+eMoo+Bgrl1SxtUogodkoaix5IZp6Ji9d/
	 rEVeBk56MhlvPguxRieNCcOSD31i5LXA9x3rfHGvxWDnaaU0DQ3qDgdWxGLZN5qSrH
	 IYjsBryB2de/SqdR/CY6bDrpKA2tWLeLyX2TAQftit/XVfsxgr3s5W8K5+g6xESFF0
	 +Ejby+e5ndNAjABk1jpW+FoOz9/qumBHJhLpjKeAJxClUSXvL7DX6SpReBCbvVEvMN
	 UzeapEf0yESM7V1fvFV7TswgMmWcu8u2s8JRlojqlUZC+YEmVaXhahCxGArSQvjkXI
	 TZEBtO4RT7feA==
Date: Mon, 5 Jan 2026 10:23:17 +0530
To: Aristo Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH v4 1/2] tee: add revision sysfs attribute
Message-ID: <aVtDvWY6Ik9i-C0L@sumit-xelite>
References: <20251226131920.64582-1-aristo.chen@canonical.com>
 <20251230051804.6230-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230051804.6230-1-aristo.chen@canonical.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 19EC543216
X-Spamd-Bar: --
Message-ID-Hash: IG5U72RJFWN7FEDNYKTLDW7YNQW7MCVT
X-Message-ID-Hash: IG5U72RJFWN7FEDNYKTLDW7YNQW7MCVT
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IG5U72RJFWN7FEDNYKTLDW7YNQW7MCVT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Dec 30, 2025 at 01:17:58PM +0800, Aristo Chen wrote:
> Add a generic TEE revision sysfs attribute backed by a new optional
> get_tee_revision() callback. The revision string is diagnostic-only and
> must not be used to infer feature support.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  Documentation/ABI/testing/sysfs-class-tee | 10 +++++
>  drivers/tee/tee_core.c                    | 51 ++++++++++++++++++++++-
>  include/linux/tee_core.h                  |  8 ++++
>  3 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
> index c9144d16003e..6e783210104e 100644
> --- a/Documentation/ABI/testing/sysfs-class-tee
> +++ b/Documentation/ABI/testing/sysfs-class-tee
> @@ -13,3 +13,13 @@ Description:
>  		space if the variable is absent. The primary purpose
>  		of this variable is to let systemd know whether
>  		tee-supplicant is needed in the early boot with initramfs.
> +
> +What:		/sys/class/tee/tee{,priv}X/revision
> +Date:		Dec 2025
> +KernelVersion:	6.18
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
>  	NULL
>  };
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
>  static const struct class tee_class = {
>  	.name = "tee",
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index 1f3e5dad6d0d..c214c38898ca 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -76,6 +76,9 @@ struct tee_device {
>  /**
>   * struct tee_driver_ops - driver operations vtable
>   * @get_version:	returns version of driver
> + * @get_tee_revision:	returns revision string (diagnostic only);
> + *			do not infer feature support from this, use
> + *			TEE_IOC_VERSION instead
>   * @open:		called for a context when the device file is opened
>   * @close_context:	called when the device file is closed
>   * @release:		called to release the context
> @@ -98,6 +101,8 @@ struct tee_device {
>  struct tee_driver_ops {
>  	void (*get_version)(struct tee_device *teedev,
>  			    struct tee_ioctl_version_data *vers);
> +	int (*get_tee_revision)(struct tee_device *teedev,
> +				char *buf, size_t len);
>  	int (*open)(struct tee_context *ctx);
>  	void (*close_context)(struct tee_context *ctx);
>  	void (*release)(struct tee_context *ctx);
> @@ -292,6 +297,9 @@ struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
>  						phys_addr_t paddr, size_t size,
>  						int min_alloc_order);
>  
> +/* Size for TEE revision string buffer used by get_tee_revision(). */
> +#define TEE_REVISION_STR_SIZE	128
> +

Move this macro alongside get_tee_revision() callback. With that feel
free to add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>  /**
>   * tee_shm_pool_free() - Free a shared memory pool
>   * @pool:	The shared memory pool to free
> -- 
> 2.43.0
> 
