Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6660A2604
	for <op-tee@archiver.kernel.org>; Thu, 29 Oct 2026 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ko1jneTz
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F0982453CD
	for <op-tee@archiver.kernel.org>; Thu, 29 Oct 2026 09:02:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ko1jneTz;
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A451F4422A
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Oct 2026 09:01:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF4E4437BC;
	Thu, 29 Oct 2026 09:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E331F012E2;
	Thu, 29 Oct 2026 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793264505;
	bh=xzym8x9efLzMKPeyyU/1JZZp8jlNuIxFa2DvUwG9gN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ko1jneTz9FrmzJmQZmWE/Sa6aeIEsQDJF+BbxrKkyUw8K9X8pcwCMwTsIpEYiy86z
	 kTTu03kQC1FSgMLMp/mWEzs/60/g2w8bKMxOgS19DBJuUXtzwYY7CEZoWcRzWRUS4/
	 JY8XR77Obc4zdY3m111EzlYBxU3c//Bi4cXjR9ik=
Date: Thu, 29 Oct 2026 10:01:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Haruka Kuze <harukak@zohomail.eu>
Subject: Re: [PATCH 2/2] rpmb: add a virtio RPMB device driver
Message-ID: <2026102958-surface-preorder-c3c8@gregkh>
References: <20261029081317.2264887-1-harukak@zohomail.eu>
 <20261029081317.2264887-3-harukak@zohomail.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261029081317.2264887-3-harukak@zohomail.eu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,arndb.de,gmail.com,linux.alibaba.com,linaro.org,sandisk.com,oss.qualcomm.com,lists.linux.dev,lists.trustedfirmware.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A451F4422A
X-Spamd-Bar: /
Message-ID-Hash: DFYG7IG5PATIRPT2T5LQI6AFZTJGJXX2
X-Message-ID-Hash: DFYG7IG5PATIRPT2T5LQI6AFZTJGJXX2
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jason Wang <jasowangio@gmail.com>, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Sumit Garg <sumit.garg@kernel.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Tomas Winkler <tomas.winkler@sandisk.com>, Ulf Hansson <ulfh@kernel.org>, Harald Mommer <harald.mommer@oss.qualcomm.com>, virtualization@lists.linux.dev, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DFYG7IG5PATIRPT2T5LQI6AFZTJGJXX2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 05:13:17PM +0900, Haruka Kuze wrote:
> No driver exists for virtio-rpmb devices (virtio ID 28), so OP-TEE
> running in a guest can not use them.
>=20
> This registers the virtio-rpmb devices found with the RPMB sub-system.
> Each request is done in one transfer on request queue, and for key
> programming and data writing a result read frame is appended so that
> the device can return the result.
>=20
> These frames are copied since the caller's buffers are not always
> usable for DMA.
>=20
> These frames follow the emmc definition, so that the device is
> registered as RPMB_TYPE_EMMC. The device has no identifier of own, so
> that a fixed dev_id is used for the key derivation for the device.
>=20
> Based on the virtio-rpmb driver in Alex Benn=E9e's RPMB series.
>=20
> Link: https://lore.kernel.org/all/20220405093759.1126835-4-alex.bennee@li=
naro.org/
> Signed-off-by: Haruka Kuze <harukak@zohomail.eu>
> ---
>  MAINTAINERS                      |   7 +
>  drivers/misc/Kconfig             |  10 ++
>  drivers/misc/Makefile            |   1 +
>  drivers/misc/virtio_rpmb.c       | 294 +++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_rpmb.h |  56 ++++++
>  5 files changed, 368 insertions(+)
>  create mode 100644 drivers/misc/virtio_rpmb.c
>  create mode 100644 include/uapi/linux/virtio_rpmb.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 748ce4d1c6a2..488003a28534 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29707,6 +29707,13 @@ S:	Maintained
>  F:	drivers/char/hw_random/virtio-rng.c
>  F:	include/uapi/linux/virtio_rng.h
> =20
> +VIRTIO RPMB DRIVER
> +M:	Haruka Kuze <harukak@zohomail.eu>
> +L:	virtualization@lists.linux.dev
> +S:	Maintained
> +F:	drivers/misc/virtio_rpmb.c
> +F:	include/uapi/linux/virtio_rpmb.h
> +
>  VIRTIO RTC DRIVER
>  M:	Peter Hilber <peter.hilber@oss.qualcomm.com>
>  L:	virtualization@lists.linux.dev
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index c40e89cc5724..eb3518ecc8fe 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -91,6 +91,16 @@ config RPMB
> =20
>  	  If unsure, select N.
> =20
> +config VIRTIO_RPMB
> +	tristate "Virtio RPMB driver"
> +	depends on VIRTIO && RPMB
> +	help
> +	  Driver for virtio RPMB devices. The device is registered with the
> +	  RPMB subsystem, where in-kernel users such as OP-TEE can use it.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called virtio_rpmb.
> +
>  config TI_FPC202
>  	tristate "TI FPC202 Dual Port Controller"
>  	depends on I2C
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 7cc3d615d37a..e4390bb8bdc0 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_TIFM_CORE)       	+=3D tifm_core.o
>  obj-$(CONFIG_TIFM_7XX1)       	+=3D tifm_7xx1.o
>  obj-$(CONFIG_PHANTOM)		+=3D phantom.o
>  obj-$(CONFIG_RPMB)		+=3D rpmb-core.o
> +obj-$(CONFIG_VIRTIO_RPMB)	+=3D virtio_rpmb.o
>  obj-$(CONFIG_QCOM_COINCELL)	+=3D qcom-coincell.o
>  obj-$(CONFIG_QCOM_FASTRPC)	+=3D fastrpc.o
>  obj-$(CONFIG_SENSORS_BH1770)	+=3D bh1770glc.o
> diff --git a/drivers/misc/virtio_rpmb.c b/drivers/misc/virtio_rpmb.c
> new file mode 100644
> index 000000000000..f02bdf13aa43
> --- /dev/null
> +++ b/drivers/misc/virtio_rpmb.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtio RPMB driver
> + *
> + * Copyright (c) 2018-2019 Intel Corporation.
> + * Copyright (c) 2021-2022 Linaro Ltd.
> + *
> + * Based on the virtio-rpmb driver in Alex Benn=E9e's RPMB series.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/rpmb.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_rpmb.h>
> +
> +#define VIRTIO_RPMB_FRAME_SIZE	sizeof(struct virtio_rpmb_frame)
> +static_assert(VIRTIO_RPMB_FRAME_SIZE =3D=3D 512);
> +
> +/*
> + * This device has no identifier on its own.
> + * This value is used as input when OP-TEE is deriving the RPMB
> + * key, so it shall stay stable.
> + */
> +static const u8 virtio_rpmb_dev_id[16] =3D "virtio-rpmb";
> +
> +/**
> + * struct virtio_rpmb - virtio RPMB device state
> + * @vdev: virtio device
> + * @vq: request queue, NULL while the device is gone or frozen
> + * @lock: serializes requests and protects @vq
> + * @rdev: RPMB device
> + * @max_wr: maximum number of blocks in one write request, 0 if unlimited
> + * @max_rd: maximum number of blocks in one read request, 0 if unlimited
> + */
> +struct virtio_rpmb {
> +	struct virtio_device *vdev;
> +	struct virtqueue *vq;
> +	struct mutex lock;
> +	struct rpmb_dev *rdev;
> +	u8 max_wr;
> +	u8 max_rd;
> +};
> +
> +struct virtio_rpmb_req {
> +	struct completion done;
> +	unsigned int len;
> +};
> +
> +static void virtio_rpmb_done(struct virtqueue *vq)
> +{
> +	struct virtio_rpmb_req *req;
> +	unsigned int len;
> +
> +	while ((req =3D virtqueue_get_buf(vq, &len))) {
> +		req->len =3D len;
> +		complete(&req->done);
> +	}
> +}
> +
> +static int virtio_rpmb_xfer(struct virtio_rpmb *vr, void *out,
> +			    unsigned int out_len, void *in, unsigned int in_len)
> +{
> +	struct scatterlist out_sg, in_sg, *sgs[2] =3D { &out_sg, &in_sg };
> +	struct virtio_rpmb_req req;
> +	int ret;
> +
> +	sg_init_one(&out_sg, out, out_len);
> +	sg_init_one(&in_sg, in, in_len);
> +	init_completion(&req.done);
> +
> +	mutex_lock(&vr->lock);

guard()?

thanks,

greg k-h
