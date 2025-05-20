Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7E9C3DA6D
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:28:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 65D8045B79
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:28:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uxo6SOqA;
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6B3B542F55
	for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 15:24:51 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acbb85ce788so1149393966b.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747754690; x=1748359490; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYLMHkDR/tPWcpSeZiIlQos+TrKLGRgGVHxxpAWir3w=;
        b=uxo6SOqArv+Rtuj0YTyKQQME9SroPZtF1yy+smRabaUcFeaCI5a4icJZSsItvJI7RQ
         NJ0hBDltfE3TNMbaaseeH3rpiG7iixKg3yk7RVnwvamsYhwSovr8yuq+1StTY0pgQigF
         K24588EkyMw3qw/8GEaNdxDVouuGdIKjAbysVJkA+ZO9O4wgkxn8dOjpyTJFPu9oNmVb
         X7N08zga3eRVIQ88kDcCGhldeCjhCKOBzQoGn7M3IbLmqASdrvSdYTYhXssQA4tvNwA8
         UlWXsurIK9cw2BZE3VaCM5t1qdrZm+eXHk+H/NOU36LRAMk1cJBgRP2RbJ0bjF5Z8tFT
         kZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754690; x=1748359490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYLMHkDR/tPWcpSeZiIlQos+TrKLGRgGVHxxpAWir3w=;
        b=g9FBpN3K9dtLSiSQMqcSoAhxCeGn3869CJxCBhKp6Wgvl4U+FS8Py5OLDYQUWGBytM
         aIOTgyPHpOs8zzfVw++W0GC0jc+lO2nwTTuIRz+BDbcScymbF1hToSZ5dFCRJFu/rYdO
         wC3boX0o2NTmw5Zuvflb8POxwWhnBhLaC3U/rkDu3XWi7siceDrPSNNSDv73F8xS1aaS
         9gNNuF/TwNdU1813iedAQCo2vO06rdeDK2kZzrh6dnlwAUTsFrg33thJe7/nPgBAslaY
         Wd4QNTrzZVB4Utnljhe/m1kvPElngHHskG2F29ZikCz7QzT8tMYEdZWXB5B4OrNF40P5
         6rNA==
X-Forwarded-Encrypted: i=1; AJvYcCW3d/EVsm5TUPOFwtUZif4e1aLAsyosWE5UpYKgreNCCAt7Lph9oSqo39xGLcBE5cmWKi1XKnM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyaWYWUz8ZJN5R/AUH07znf1DFWpF/FITFFvjB11PKDsQ6KIec/
	GbcKD1u9qvJ08eYbmeXCALdXUcaIiOkOy8zAzyyjzj8MmQhjYQaCFYpiZwqkbJ6Bh4cSqw==
X-Gm-Gg: ASbGncseC90LgKHyRoMczUmDuZXecT6wj/XhkJIzrXFgO2BiM66riRC4dVWrpN2UDWT
	mATRp0iEJF/nWk2FV59SK1UzGJYZbjNyWCaA2WMJplaC2zthLvVPGQ/AZR9krGtVQ6tAtxLsV/B
	qsu2/cZPGfvGBALDyzZNOuIw0XK2jtJ42gH+9dJmdSBedBDAggOv3UYxnYnM6pEhHiW0i+5q7P9
	oHoqVilU/cxPukVdIVi8hhCTF71/zcQo8pgzdMTJky3yvVuT0OTwNloQ78IhHwcr2QNC6iIUjPx
	umhScmGVfOXcLSnczC5EKsGODhAWEB0RYvJafJeEEMcfVwA1AvzI1ynNL3pMAxJrWWIlfmtB3vR
	90ntxdejJIJWnGJheoSGo5sNtURMd
X-Google-Smtp-Source: AGHT+IH1F3ARaz0eu5TNmhoYwL5GYYxn/a/Uy3LhTz+YKDYcsP+SYPwnNqbxv1AMZgM9n1+zv+umBA==
X-Received: by 2002:a17:907:7e85:b0:ad2:25e9:f7a1 with SMTP id a640c23a62f3a-ad52d5b9fb8mr1621475166b.40.1747754690195;
        Tue, 20 May 2025 08:24:50 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278257sm742608766b.82.2025.05.20.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:24:49 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 5/9] tee: new ioctl to a register tee_shm from a dmabuf file descriptor
Date: Tue, 20 May 2025 17:16:48 +0200
Message-ID: <20250520152436.474778-6-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520152436.474778-1-jens.wiklander@linaro.org>
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.10 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.45:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,foss.st.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.45:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6B3B542F55
Message-ID-Hash: 2HOXYRSHEZ6QGQ2AE4ZCU4ERIHGMUEKX
X-Message-ID-Hash: 2HOXYRSHEZ6QGQ2AE4ZCU4ERIHGMUEKX
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, Etienne Carriere <etienne.carriere@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2HOXYRSHEZ6QGQ2AE4ZCU4ERIHGMUEKX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Etienne Carriere <etienne.carriere@foss.st.com>

Add a userspace API to create a tee_shm object that refers to a dmabuf
reference.

Userspace registers the dmabuf file descriptor as in a tee_shm object.
The registration is completed with a tee_shm returned file descriptor.

Userspace is free to close the dmabuf file descriptor after it has been
registered since all the resources are now held via the new tee_shm
object.

Closing the tee_shm file descriptor will eventually release all
resources used by the tee_shm object when all references are released.

The new IOCTL, TEE_IOC_SHM_REGISTER_FD, supports dmabuf references to
physically contiguous memory buffers. Dmabuf references acquired from
the TEE DMA-heap can be used as protected memory for Secure Video Path
and such use cases. It depends on the TEE and the TEE driver if dmabuf
references acquired by other means can be used.

A new tee_shm flag is added to identify tee_shm objects built from a
registered dmabuf, TEE_SHM_DMA_BUF.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c    |  63 +++++++++++++++++++++-
 drivers/tee/tee_private.h |  10 ++++
 drivers/tee/tee_shm.c     | 111 ++++++++++++++++++++++++++++++++++++--
 include/linux/tee_core.h  |   1 +
 include/linux/tee_drv.h   |  10 ++++
 include/uapi/linux/tee.h  |  31 +++++++++++
 6 files changed, 221 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 5259b8223c27..0e9d9e5872a4 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -353,11 +353,49 @@ tee_ioctl_shm_register(struct tee_context *ctx,
 	return ret;
 }
 
+static int
+tee_ioctl_shm_register_fd(struct tee_context *ctx,
+			  struct tee_ioctl_shm_register_fd_data __user *udata)
+{
+	struct tee_ioctl_shm_register_fd_data data;
+	struct tee_shm *shm;
+	long ret;
+
+	if (copy_from_user(&data, udata, sizeof(data)))
+		return -EFAULT;
+
+	/* Currently no input flags are supported */
+	if (data.flags)
+		return -EINVAL;
+
+	shm = tee_shm_register_fd(ctx, data.fd);
+	if (IS_ERR(shm))
+		return -EINVAL;
+
+	data.id = shm->id;
+	data.flags = shm->flags;
+	data.size = shm->size;
+
+	if (copy_to_user(udata, &data, sizeof(data)))
+		ret = -EFAULT;
+	else
+		ret = tee_shm_get_fd(shm);
+
+	/*
+	 * When user space closes the file descriptor the shared memory
+	 * should be freed or if tee_shm_get_fd() failed then it will
+	 * be freed immediately.
+	 */
+	tee_shm_put(shm);
+	return ret;
+}
+
 static int param_from_user_memref(struct tee_context *ctx,
 				  struct tee_param_memref *memref,
 				  struct tee_ioctl_param *ip)
 {
 	struct tee_shm *shm;
+	size_t offs = 0;
 
 	/*
 	 * If a NULL pointer is passed to a TA in the TEE,
@@ -388,6 +426,26 @@ static int param_from_user_memref(struct tee_context *ctx,
 			tee_shm_put(shm);
 			return -EINVAL;
 		}
+
+		if (shm->flags & TEE_SHM_DMA_BUF) {
+			struct tee_shm_dmabuf_ref *ref;
+
+			ref = container_of(shm, struct tee_shm_dmabuf_ref, shm);
+			if (ref->parent_shm) {
+				/*
+				 * The shm already has one reference to
+				 * ref->parent_shm so we are clear of 0.
+				 * We're getting another reference since
+				 * this shm will be used in the parameter
+				 * list instead of the shm we got with
+				 * tee_shm_get_from_id() above.
+				 */
+				refcount_inc(&ref->parent_shm->refcount);
+				tee_shm_put(shm);
+				shm = ref->parent_shm;
+				offs = ref->offset;
+			}
+		}
 	} else if (ctx->cap_memref_null) {
 		/* Pass NULL pointer to OP-TEE */
 		shm = NULL;
@@ -395,7 +453,7 @@ static int param_from_user_memref(struct tee_context *ctx,
 		return -EINVAL;
 	}
 
-	memref->shm_offs = ip->a;
+	memref->shm_offs = ip->a + offs;
 	memref->size = ip->b;
 	memref->shm = shm;
 
@@ -841,6 +899,8 @@ static long tee_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return tee_ioctl_shm_alloc(ctx, uarg);
 	case TEE_IOC_SHM_REGISTER:
 		return tee_ioctl_shm_register(ctx, uarg);
+	case TEE_IOC_SHM_REGISTER_FD:
+		return tee_ioctl_shm_register_fd(ctx, uarg);
 	case TEE_IOC_OPEN_SESSION:
 		return tee_ioctl_open_session(ctx, uarg);
 	case TEE_IOC_INVOKE:
@@ -1300,3 +1360,4 @@ MODULE_AUTHOR("Linaro");
 MODULE_DESCRIPTION("TEE Driver");
 MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("DMA_BUF");
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 6c6ff5d5eed2..308467705da6 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -13,6 +13,16 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+/* extra references appended to shm object for registered shared memory */
+struct tee_shm_dmabuf_ref {
+	struct tee_shm shm;
+	size_t offset;
+	struct dma_buf *dmabuf;
+	struct dma_buf_attachment *attach;
+	struct sg_table *sgt;
+	struct tee_shm *parent_shm;
+};
+
 int tee_shm_get_fd(struct tee_shm *shm);
 
 bool tee_device_get(struct tee_device *teedev);
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..e1ed52ee0a16 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -4,6 +4,7 @@
  */
 #include <linux/anon_inodes.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
 #include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -45,7 +46,23 @@ static void release_registered_pages(struct tee_shm *shm)
 
 static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
 {
-	if (shm->flags & TEE_SHM_POOL) {
+	struct tee_shm *parent_shm = NULL;
+	void *p = shm;
+
+	if (shm->flags & TEE_SHM_DMA_BUF) {
+		struct tee_shm_dmabuf_ref *ref;
+
+		ref = container_of(shm, struct tee_shm_dmabuf_ref, shm);
+		parent_shm = ref->parent_shm;
+		p = ref;
+		if (ref->attach) {
+			dma_buf_unmap_attachment(ref->attach, ref->sgt,
+						 DMA_BIDIRECTIONAL);
+
+			dma_buf_detach(ref->dmabuf, ref->attach);
+		}
+		dma_buf_put(ref->dmabuf);
+	} else if (shm->flags & TEE_SHM_POOL) {
 		teedev->pool->ops->free(teedev->pool, shm);
 	} else if (shm->flags & TEE_SHM_DYNAMIC) {
 		int rc = teedev->desc->ops->shm_unregister(shm->ctx, shm);
@@ -57,9 +74,10 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
 		release_registered_pages(shm);
 	}
 
-	teedev_ctx_put(shm->ctx);
+	if (shm->ctx)
+		teedev_ctx_put(shm->ctx);
 
-	kfree(shm);
+	kfree(p);
 
 	tee_device_put(teedev);
 }
@@ -169,7 +187,7 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
  * tee_client_invoke_func(). The memory allocated is later freed with a
  * call to tee_shm_free().
  *
- * @returns a pointer to 'struct tee_shm'
+ * @returns a pointer to 'struct tee_shm' on success, and ERR_PTR on failure
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
 {
@@ -179,6 +197,91 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
 
+struct tee_shm *tee_shm_register_fd(struct tee_context *ctx, int fd)
+{
+	struct tee_shm_dmabuf_ref *ref;
+	int rc;
+
+	if (!tee_device_get(ctx->teedev))
+		return ERR_PTR(-EINVAL);
+
+	teedev_ctx_get(ctx);
+
+	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+	if (!ref) {
+		rc = -ENOMEM;
+		goto err_put_tee;
+	}
+
+	refcount_set(&ref->shm.refcount, 1);
+	ref->shm.ctx = ctx;
+	ref->shm.id = -1;
+	ref->shm.flags = TEE_SHM_DMA_BUF;
+
+	ref->dmabuf = dma_buf_get(fd);
+	if (IS_ERR(ref->dmabuf)) {
+		rc = PTR_ERR(ref->dmabuf);
+		goto err_kfree_ref;
+	}
+
+	rc = tee_heap_update_from_dma_buf(ctx->teedev, ref->dmabuf,
+					  &ref->offset, &ref->shm,
+					  &ref->parent_shm);
+	if (!rc)
+		goto out;
+	if (rc != -EINVAL)
+		goto err_put_dmabuf;
+
+	ref->attach = dma_buf_attach(ref->dmabuf, &ctx->teedev->dev);
+	if (IS_ERR(ref->attach)) {
+		rc = PTR_ERR(ref->attach);
+		goto err_put_dmabuf;
+	}
+
+	ref->sgt = dma_buf_map_attachment(ref->attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(ref->sgt)) {
+		rc = PTR_ERR(ref->sgt);
+		goto err_detach;
+	}
+
+	if (sg_nents(ref->sgt->sgl) != 1) {
+		rc = -EINVAL;
+		goto err_unmap_attachement;
+	}
+
+	ref->shm.paddr = page_to_phys(sg_page(ref->sgt->sgl));
+	ref->shm.size = ref->sgt->sgl->length;
+
+out:
+	mutex_lock(&ref->shm.ctx->teedev->mutex);
+	ref->shm.id = idr_alloc(&ref->shm.ctx->teedev->idr, &ref->shm,
+				1, 0, GFP_KERNEL);
+	mutex_unlock(&ref->shm.ctx->teedev->mutex);
+	if (ref->shm.id < 0) {
+		rc = ref->shm.id;
+		if (ref->attach)
+			goto err_unmap_attachement;
+		goto err_put_dmabuf;
+	}
+
+	return &ref->shm;
+
+err_unmap_attachement:
+	dma_buf_unmap_attachment(ref->attach, ref->sgt, DMA_BIDIRECTIONAL);
+err_detach:
+	dma_buf_detach(ref->dmabuf, ref->attach);
+err_put_dmabuf:
+	dma_buf_put(ref->dmabuf);
+err_kfree_ref:
+	kfree(ref);
+err_put_tee:
+	teedev_ctx_put(ctx);
+	tee_device_put(ctx->teedev);
+
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(tee_shm_register_fd);
+
 /**
  * tee_shm_alloc_priv_buf() - Allocate shared memory for a privately shared
  *			      kernel buffer
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index b8b99c97e00c..02c07f661349 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -28,6 +28,7 @@
 #define TEE_SHM_USER_MAPPED	BIT(1)  /* Memory mapped in user space */
 #define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
 #define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
+#define TEE_SHM_DMA_BUF		BIT(4)	/* Memory with dma-buf handle */
 
 #define TEE_DEVICE_FLAG_REGISTERED	0x1
 #define TEE_MAX_DEV_NAME_LEN		32
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a54c203000ed..824f1251de60 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -116,6 +116,16 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length);
 
+/**
+ * tee_shm_register_fd() - Register shared memory from file descriptor
+ *
+ * @ctx:	Context that allocates the shared memory
+ * @fd:		Shared memory file descriptor reference
+ *
+ * @returns a pointer to 'struct tee_shm' on success, and ERR_PTR on failure
+ */
+struct tee_shm *tee_shm_register_fd(struct tee_context *ctx, int fd);
+
 /**
  * tee_shm_free() - Free shared memory
  * @shm:	Handle to shared memory to free
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index d0430bee8292..8ec5f46fbfbe 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -118,6 +118,37 @@ struct tee_ioctl_shm_alloc_data {
 #define TEE_IOC_SHM_ALLOC	_IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + 1, \
 				     struct tee_ioctl_shm_alloc_data)
 
+/**
+ * struct tee_ioctl_shm_register_fd_data - Shared memory registering argument
+ * @fd:		[in] File descriptor identifying dmabuf reference
+ * @size:	[out] Size of referenced memory
+ * @flags:	[in] Flags to/from allocation.
+ * @id:		[out] Identifier of the shared memory
+ *
+ * The flags field should currently be zero as input. Updated by the call
+ * with actual flags as defined by TEE_IOCTL_SHM_* above.
+ * This structure is used as argument for TEE_IOC_SHM_REGISTER_FD below.
+ */
+struct tee_ioctl_shm_register_fd_data {
+	__s64 fd;
+	__u64 size;
+	__u32 flags;
+	__s32 id;
+};
+
+/**
+ * TEE_IOC_SHM_REGISTER_FD - register a shared memory from a file descriptor
+ *
+ * Returns a file descriptor on success or < 0 on failure
+ *
+ * The returned file descriptor refers to the shared memory object in the
+ * kernel. The supplied file deccriptor can be closed if it's not needed
+ * for other purposes. The shared memory is freed when the descriptor is
+ * closed.
+ */
+#define TEE_IOC_SHM_REGISTER_FD	_IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + 8, \
+				     struct tee_ioctl_shm_register_fd_data)
+
 /**
  * struct tee_ioctl_buf_data - Variable sized buffer
  * @buf_ptr:	[in] A __user pointer to a buffer
-- 
2.43.0

