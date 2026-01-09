Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECDDD1681B
	for <op-tee@archiver.kernel.org>; Fri,  9 Jan 2026 11:48:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 440074FFBF
	for <op-tee@archiver.kernel.org>; Fri,  9 Jan 2026 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767959328;
	bh=yRyDLcAqiH6pZmNzsm5pfgCigsvRKT+X/T+uMrJY6AU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jxowPGUJ9ZD4r5vbwD4kRYEPn5b83F/lL02CB7yjQ2YqkwIRpjocnhWHkblo/wIPw
	 tw3JQVhSTta7gPEaHW5yy+RjydszfJWvPmrX4PdaxL2n9z6VhW4ed2btQaF9T9wa24
	 HVBBI5aDeSha69nvDvsPcYt4VCMS9ls7RQ0c4IihHaaOb+pvWUgGwDlBUiv4WpE9bS
	 i/Td2jQ+eCh1+J8zHdsxkfpXfF/jC7IkKSXFz7QokYHH4VVuFCInxUr73PlCEq+ko5
	 8/XNbClrgyNKZLV5rvLg6xsqMiVXNSOKcYxP3uvIQAN0U/vwded+Y4nnlGOCJ/xv4U
	 vgJ4gSTytsLCQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ED36D43182
	for <op-tee@lists.trustedfirmware.org>; Fri,  9 Jan 2026 11:48:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ofyuVSZk;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6809F436E1;
	Fri,  9 Jan 2026 11:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32CEC19421;
	Fri,  9 Jan 2026 11:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767959310;
	bh=yRyDLcAqiH6pZmNzsm5pfgCigsvRKT+X/T+uMrJY6AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofyuVSZk/CcVrcVS321Sfk7f3ACBCKWVY8NzKZEew7QcRiVWnkMmVgWmj23qM9gyh
	 COZwra0uQ1kI+fGH3tkh3djotKc6SahD+jsdVaW+qyDY3HWmmWhM5eEITVpj4t/ijW
	 LImXAco9YjROXp04kZd2SBpaIf40oA88nAAwBvm0GTkEKjeIc2SRIDY/48BISFkaJl
	 R6hbhC3MmYa0RSBwu+nnu3pX/kGgkm/LiDu+LaaRZAWlqtGlQKS/RWyGfCoiqalzQl
	 J5jpy7MGFwbCG0tbVACeWzJ/EMLvQGKSOkpKR9pqcp0oF8PtPvCpj8TSvcomH7f9B0
	 4n2Tk+ojX7xgQ==
Date: Fri, 9 Jan 2026 17:18:24 +0530
To: Aristo Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH v6 1/2] tee: add revision sysfs attribute
Message-ID: <aWDrCH9X2oHzboDH@sumit-xelite>
References: <20260107152607.902735-1-aristo.chen@canonical.com>
 <20260108064517.13854-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108064517.13854-1-aristo.chen@canonical.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ED36D43182
X-Spamd-Bar: --
Message-ID-Hash: FCJKZUA3E3WMHTWJIAYG7YU3LRA3VZ63
X-Message-ID-Hash: FCJKZUA3E3WMHTWJIAYG7YU3LRA3VZ63
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FCJKZUA3E3WMHTWJIAYG7YU3LRA3VZ63/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Jan 08, 2026 at 02:45:08PM +0800, Aristo Chen wrote:
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

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
> index c9144d16003e..1a0a3050aaa9 100644
> --- a/Documentation/ABI/testing/sysfs-class-tee
> +++ b/Documentation/ABI/testing/sysfs-class-tee
> @@ -13,3 +13,13 @@ Description:
>  		space if the variable is absent. The primary purpose
>  		of this variable is to let systemd know whether
>  		tee-supplicant is needed in the early boot with initramfs.
> +
> +What:		/sys/class/tee/tee{,priv}X/revision
> +Date:		Jan 2026
> +KernelVersion:	6.19
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
> index 1f3e5dad6d0d..ee5f0bd41f43 100644
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
> @@ -95,9 +98,12 @@ struct tee_device {
>   * client closes the device file, even if there are existing references to the
>   * context. The TEE driver can use @close_context to start cleaning up.
>   */
> +
>  struct tee_driver_ops {
>  	void (*get_version)(struct tee_device *teedev,
>  			    struct tee_ioctl_version_data *vers);
> +	int (*get_tee_revision)(struct tee_device *teedev,
> +				char *buf, size_t len);
>  	int (*open)(struct tee_context *ctx);
>  	void (*close_context)(struct tee_context *ctx);
>  	void (*release)(struct tee_context *ctx);
> @@ -123,6 +129,9 @@ struct tee_driver_ops {
>  	int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *shm);
>  };
>  
> +/* Size for TEE revision string buffer used by get_tee_revision(). */
> +#define TEE_REVISION_STR_SIZE	128
> +
>  /**
>   * struct tee_desc - Describes the TEE driver to the subsystem
>   * @name:	name of driver
> -- 
> 2.43.0
> 
