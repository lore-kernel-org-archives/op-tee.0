Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE8EC3ABDD
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:29:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9AF1342E34
	for <op-tee@archiver.kernel.org>; Tue, 20 May 2025 15:29:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y10Yl6Ey;
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EDB4845B2B
	for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 15:24:56 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso957933766b.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747754696; x=1748359496; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jENQpdYZ+Bna9Sv/iO8rSdNP+8ALEbOJc1sM21puJFE=;
        b=y10Yl6EyugElmI6cb/wHfexR4Uo0mN5yhy3GvQr44wvKkShIY5NGDGQ6B6W4cE7qbp
         t/tyrVQVT3k1uhDFi4DW3doXQtSkMGKWa1gYBSQEd3UCI0Am1dyJQm1iPMzU3rI/16sP
         Mi2r3oEs29uetHNBwgqsaR4N0Bk5PgNegpLcozQv3tVoyZIpXQDfVKV3vwv7PAqkHh/r
         SCe7iWvBuo/vlp3MlRJpk8hA+rFgLym7FY8lERHLucMYhszZ7JFPs1gpxESJvluJaKdM
         7L9XhHEbeosqEnv9reeSaXq/22BXLxA1bS6oa5UsZsbcN/3yCSC3Qfm6RtKRx5B2utM1
         goeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754696; x=1748359496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jENQpdYZ+Bna9Sv/iO8rSdNP+8ALEbOJc1sM21puJFE=;
        b=L8SjawfNxiGETw6GQgVt4npym3N4dAq0a7T4dMVP6x7cgjdzBwIfgj/tpDTgjJarss
         2Nset3j6FF5BeAmpQgGQ2+DYJHqwnHlPkaIsH7nTjH/pbcKaxFYahS+cTRsywg9eEr4V
         M1ggluApAjbnjbq6fOTtf/8oPjJj2kaBILFVIkjLEykCrftn66BpY2gSD/L6H+YL0hhX
         kQvcxOh6U+ECtusZZSRbdiEAAUQWfDflvKOgBEqhLAe8dMOdrn/HGZDg2Vd9G8ybgddV
         QdmnjvSw8Wi711PteTsM/NiLeG0fith/kqTmmXrsMX9ZGIhEpkoodzUsH3E2PWL9y/Sm
         m/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWHf2TGcBWNmznRvpMbQ1sz7DK7Iyd32voWllYQtXfWwpxebmJGX7bZzyWy6bQRfnXbVeZ9cWM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxxWex4Zc9RAUqPWilwVggN/17j8i4pe+zhVy73WKC8LVUqDGWo
	B3Ii4soev6fjhBFtS4eMSyI1kQPoO7NTziledvcWw54++R6A/PqQXpA5VGoLENo+3Tx3/w==
X-Gm-Gg: ASbGncsYjATWGq4MvAk3lsTDX5iIEaeSVXTNHTBGH0ZgwY6954s7GG0KRdESxt00o/j
	Cg0VDFSe1WMPs9TVCMzqXONkrbByuPVqdaBZDZcgEfYnOQ/6j3O7PNApKyW1Wy/cRsVSWBg3UFW
	USEYk1XQaNLWQseBMgmMEtnJMsv3SoehPceD8d5q0oG3Q+Mj1bYPUoHwHtrN+JlRyT16rT7bPZ0
	882HH+0fOOXVXGYXrdWTTX4uHLHn61OuCvRNOGbgRRN1WXkPH7C74uOYpgqwZFwhyTuudgZ9Qi6
	xQNq1F7c7OlK+x4m5lKOgl5G185jD8yCJri+5gyLN5S8hKpSMCm4TLC40qGNhkcFTn/b1QTe/sS
	pz2KahH4QCzuQ3WwjAE+Am3posIdui04e3cPF6Bw=
X-Google-Smtp-Source: AGHT+IHuuCq9HbzsepCL0ZTIZa5OeX6y7nIvClccQkC5ORlP18GbvwAI79ZLJFwo1QYu6hYKGoug2g==
X-Received: by 2002:a17:907:9728:b0:ad5:5302:4023 with SMTP id a640c23a62f3a-ad55302638cmr1076828366b.44.1747754695662;
        Tue, 20 May 2025 08:24:55 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278257sm742608766b.82.2025.05.20.08.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:24:55 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 8/9] optee: FF-A: dynamic protected memory allocation
Date: Tue, 20 May 2025 17:16:51 +0200
Message-ID: <20250520152436.474778-9-jens.wiklander@linaro.org>
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
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.52:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.52:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EDB4845B2B
Message-ID-Hash: HX6PYSH5SWXKAFTZXAR72WOYXZVMFUIP
X-Message-ID-Hash: HX6PYSH5SWXKAFTZXAR72WOYXZVMFUIP
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HX6PYSH5SWXKAFTZXAR72WOYXZVMFUIP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add support in the OP-TEE backend driver dynamic protected memory
allocation with FF-A.

The protected memory pools for dynamically allocated protected memory
are instantiated when requested by user-space. This instantiation can
fail if OP-TEE doesn't support the requested use-case of protected
memory.

Restricted memory pools based on a static carveout or dynamic allocation
can coexist for different use-cases. We use only dynamic allocation with
FF-A.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/ffa_abi.c       | 147 ++++++++++++-
 drivers/tee/optee/optee_private.h |  13 +-
 drivers/tee/optee/protmem.c       | 332 ++++++++++++++++++++++++++++++
 4 files changed, 490 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tee/optee/protmem.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index a6eff388d300..ad7049c1c107 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,6 +4,7 @@ optee-objs += core.o
 optee-objs += call.o
 optee-objs += notif.o
 optee-objs += rpc.o
+optee-objs += protmem.o
 optee-objs += supp.o
 optee-objs += device.o
 optee-objs += smc_abi.o
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f3af5666bb11..b9cbd733e5c6 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -649,6 +649,124 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
 	return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
 }
 
+static int do_call_lend_protmem(struct optee *optee, u64 cookie, u32 use_case)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg = optee_get_msg_arg(optee->ctx, 1, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_ASSIGN_PROTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	msg_arg->params[0].u.value.a = cookie;
+	msg_arg->params[0].u.value.b = use_case;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret != TEEC_SUCCESS) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
+static int optee_ffa_lend_protmem(struct optee *optee, struct tee_shm *protmem,
+				  u16 *end_points, unsigned int ep_count,
+				  u32 use_case)
+{
+	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
+	const struct ffa_mem_ops *mem_ops = ffa_dev->ops->mem_ops;
+	const struct ffa_msg_ops *msg_ops = ffa_dev->ops->msg_ops;
+	struct ffa_send_direct_data data;
+	struct ffa_mem_region_attributes *mem_attr;
+	struct ffa_mem_ops_args args = {
+		.use_txbuf = true,
+		.tag = use_case,
+	};
+	struct page *page;
+	struct scatterlist sgl;
+	unsigned int n;
+	int rc;
+
+	mem_attr = kcalloc(ep_count, sizeof(*mem_attr), GFP_KERNEL);
+	for (n = 0; n < ep_count; n++) {
+		mem_attr[n].receiver = end_points[n];
+		mem_attr[n].attrs = FFA_MEM_RW;
+	}
+	args.attrs = mem_attr;
+	args.nattrs = ep_count;
+
+	page = phys_to_page(protmem->paddr);
+	sg_init_table(&sgl, 1);
+	sg_set_page(&sgl, page, protmem->size, 0);
+
+	args.sg = &sgl;
+	rc = mem_ops->memory_lend(&args);
+	kfree(mem_attr);
+	if (rc)
+		return rc;
+
+	rc = do_call_lend_protmem(optee, args.g_handle, use_case);
+	if (rc)
+		goto err_reclaim;
+
+	rc = optee_shm_add_ffa_handle(optee, protmem, args.g_handle);
+	if (rc)
+		goto err_unreg;
+
+	protmem->sec_world_id = args.g_handle;
+
+	return 0;
+
+err_unreg:
+	data = (struct ffa_send_direct_data){
+		.data0 = OPTEE_FFA_RELEASE_PROTMEM,
+		.data1 = (u32)args.g_handle,
+		.data2 = (u32)(args.g_handle >> 32),
+	};
+	msg_ops->sync_send_receive(ffa_dev, &data);
+err_reclaim:
+	mem_ops->memory_reclaim(args.g_handle, 0);
+	return rc;
+}
+
+static int optee_ffa_reclaim_protmem(struct optee *optee,
+				     struct tee_shm *protmem)
+{
+	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
+	const struct ffa_msg_ops *msg_ops = ffa_dev->ops->msg_ops;
+	const struct ffa_mem_ops *mem_ops = ffa_dev->ops->mem_ops;
+	u64 global_handle = protmem->sec_world_id;
+	struct ffa_send_direct_data data = {
+		.data0 = OPTEE_FFA_RELEASE_PROTMEM,
+		.data1 = (u32)global_handle,
+		.data2 = (u32)(global_handle >> 32)
+	};
+	int rc;
+
+	optee_shm_rem_ffa_handle(optee, global_handle);
+	protmem->sec_world_id = 0;
+
+	rc = msg_ops->sync_send_receive(ffa_dev, &data);
+	if (rc)
+		pr_err("Release SHM id 0x%llx rc %d\n", global_handle, rc);
+
+	rc = mem_ops->memory_reclaim(global_handle, 0);
+	if (rc)
+		pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
+
+	return rc;
+}
+
 /*
  * 6. Driver initialization
  *
@@ -810,6 +928,8 @@ static const struct optee_ops optee_ffa_ops = {
 	.do_call_with_arg = optee_ffa_do_call_with_arg,
 	.to_msg_param = optee_ffa_to_msg_param,
 	.from_msg_param = optee_ffa_from_msg_param,
+	.lend_protmem = optee_ffa_lend_protmem,
+	.reclaim_protmem = optee_ffa_reclaim_protmem,
 };
 
 static void optee_ffa_remove(struct ffa_device *ffa_dev)
@@ -868,6 +988,25 @@ static int optee_ffa_async_notif_init(struct ffa_device *ffa_dev,
 	return rc;
 }
 
+static int optee_ffa_protmem_pool_init(struct optee *optee, u32 sec_caps)
+{
+	enum tee_dma_heap_id id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
+	struct tee_protmem_pool *pool;
+	int rc = 0;
+
+	if (sec_caps & OPTEE_FFA_SEC_CAP_PROTMEM) {
+		pool = optee_protmem_alloc_dyn_pool(optee, id);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+
+		rc = tee_device_register_dma_heap(optee->teedev, id, pool);
+		if (rc)
+			pool->ops->destroy_pool(pool);
+	}
+
+	return rc;
+}
+
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_notifier_ops *notif_ops;
@@ -918,7 +1057,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 				  optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
-		goto err_free_pool;
+		goto err_free_shm_pool;
 	}
 	optee->teedev = teedev;
 
@@ -965,6 +1104,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 			       rc);
 	}
 
+	if (optee_ffa_protmem_pool_init(optee, sec_caps))
+		pr_info("Protected memory service not available\n");
+
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc)
 		goto err_unregister_devices;
@@ -978,6 +1120,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 err_unregister_devices:
 	optee_unregister_devices();
+	tee_device_unregister_all_dma_heaps(optee->teedev);
 	if (optee->ffa.bottom_half_value != U32_MAX)
 		notif_ops->notify_relinquish(ffa_dev,
 					     optee->ffa.bottom_half_value);
@@ -995,7 +1138,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
 	tee_device_unregister(optee->teedev);
-err_free_pool:
+err_free_shm_pool:
 	tee_shm_pool_free(pool);
 err_free_optee:
 	kfree(optee);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 5e3c34802121..68e94856205c 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -174,9 +174,14 @@ struct optee;
  * @do_call_with_arg:	enters OP-TEE in secure world
  * @to_msg_param:	converts from struct tee_param to OPTEE_MSG parameters
  * @from_msg_param:	converts from OPTEE_MSG parameters to struct tee_param
+ * @lend_protmem:	lends physically contiguous memory as restricted
+ *			memory, inaccessible by the kernel
+ * @reclaim_protmem:	reclaims restricted memory previously lent with
+ *			@lend_protmem() and makes it accessible by the
+ *			kernel again
  *
  * These OPs are only supposed to be used internally in the OP-TEE driver
- * as a way of abstracting the different methogs of entering OP-TEE in
+ * as a way of abstracting the different methods of entering OP-TEE in
  * secure world.
  */
 struct optee_ops {
@@ -189,6 +194,10 @@ struct optee_ops {
 	int (*from_msg_param)(struct optee *optee, struct tee_param *params,
 			      size_t num_params,
 			      const struct optee_msg_param *msg_params);
+	int (*lend_protmem)(struct optee *optee, struct tee_shm *protmem,
+			    u16 *end_points, unsigned int ep_count,
+			    u32 use_case);
+	int (*reclaim_protmem)(struct optee *optee, struct tee_shm *protmem);
 };
 
 /**
@@ -285,6 +294,8 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 void optee_supp_init(struct optee_supp *supp);
 void optee_supp_uninit(struct optee_supp *supp);
 void optee_supp_release(struct optee_supp *supp);
+struct tee_protmem_pool *optee_protmem_alloc_dyn_pool(struct optee *optee,
+						      enum tee_dma_heap_id id);
 
 int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		    struct tee_param *param);
diff --git a/drivers/tee/optee/protmem.c b/drivers/tee/optee/protmem.c
new file mode 100644
index 000000000000..f7e4f1068ef1
--- /dev/null
+++ b/drivers/tee/optee/protmem.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Linaro Limited
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/errno.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tee_core.h>
+#include <linux/types.h>
+#include "optee_private.h"
+
+struct optee_protmem_dyn_pool {
+	struct tee_protmem_pool pool;
+	struct gen_pool *gen_pool;
+	struct optee *optee;
+	size_t page_count;
+	u16 *end_points;
+	u_int end_point_count;
+	refcount_t refcount;
+	u32 use_case;
+	struct tee_shm *protmem;
+	/* Protects when initializing and tearing down this struct */
+	struct mutex mutex;
+};
+
+static struct optee_protmem_dyn_pool *
+to_protmem_dyn_pool(struct tee_protmem_pool *pool)
+{
+	return container_of(pool, struct optee_protmem_dyn_pool, pool);
+}
+
+static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
+{
+	int rc;
+
+	rp->protmem = tee_shm_alloc_dma_mem(rp->optee->ctx, rp->page_count);
+	if (IS_ERR(rp->protmem)) {
+		rc = PTR_ERR(rp->protmem);
+		goto err_null_protmem;
+	}
+
+	/*
+	 * TODO unmap the memory range since the physical memory will
+	 * become inaccesible after the lend_protmem() call.
+	 */
+	rc = rp->optee->ops->lend_protmem(rp->optee, rp->protmem,
+					  rp->end_points,
+					  rp->end_point_count, rp->use_case);
+	if (rc)
+		goto err_put_shm;
+	rp->protmem->flags |= TEE_SHM_DYNAMIC;
+
+	rp->gen_pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!rp->gen_pool) {
+		rc = -ENOMEM;
+		goto err_reclaim;
+	}
+
+	rc = gen_pool_add(rp->gen_pool, rp->protmem->paddr,
+			  rp->protmem->size, -1);
+	if (rc)
+		goto err_free_pool;
+
+	refcount_set(&rp->refcount, 1);
+	return 0;
+
+err_free_pool:
+	gen_pool_destroy(rp->gen_pool);
+	rp->gen_pool = NULL;
+err_reclaim:
+	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+err_put_shm:
+	tee_shm_put(rp->protmem);
+err_null_protmem:
+	rp->protmem = NULL;
+	return rc;
+}
+
+static int get_dyn_protmem(struct optee_protmem_dyn_pool *rp)
+{
+	int rc = 0;
+
+	if (!refcount_inc_not_zero(&rp->refcount)) {
+		mutex_lock(&rp->mutex);
+		if (rp->gen_pool) {
+			/*
+			 * Another thread has already initialized the pool
+			 * before us, or the pool was just about to be torn
+			 * down. Either way we only need to increase the
+			 * refcount and we're done.
+			 */
+			refcount_inc(&rp->refcount);
+		} else {
+			rc = init_dyn_protmem(rp);
+		}
+		mutex_unlock(&rp->mutex);
+	}
+
+	return rc;
+}
+
+static void release_dyn_protmem(struct optee_protmem_dyn_pool *rp)
+{
+	gen_pool_destroy(rp->gen_pool);
+	rp->gen_pool = NULL;
+
+	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+	rp->protmem->flags &= ~TEE_SHM_DYNAMIC;
+
+	WARN(refcount_read(&rp->protmem->refcount) != 1, "Unexpected refcount");
+	tee_shm_put(rp->protmem);
+	rp->protmem = NULL;
+}
+
+static void put_dyn_protmem(struct optee_protmem_dyn_pool *rp)
+{
+	if (refcount_dec_and_test(&rp->refcount)) {
+		mutex_lock(&rp->mutex);
+		if (rp->gen_pool)
+			release_dyn_protmem(rp);
+		mutex_unlock(&rp->mutex);
+	}
+}
+
+static int protmem_pool_op_dyn_alloc(struct tee_protmem_pool *pool,
+				     struct sg_table *sgt, size_t size,
+				     size_t *offs)
+{
+	struct optee_protmem_dyn_pool *rp = to_protmem_dyn_pool(pool);
+	size_t sz = ALIGN(size, PAGE_SIZE);
+	phys_addr_t pa;
+	int rc;
+
+	rc = get_dyn_protmem(rp);
+	if (rc)
+		return rc;
+
+	pa = gen_pool_alloc(rp->gen_pool, sz);
+	if (!pa) {
+		rc = -ENOMEM;
+		goto err_put;
+	}
+
+	rc = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (rc)
+		goto err_free;
+
+	sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);
+	*offs = pa - rp->protmem->paddr;
+
+	return 0;
+err_free:
+	gen_pool_free(rp->gen_pool, pa, size);
+err_put:
+	put_dyn_protmem(rp);
+
+	return rc;
+}
+
+static void protmem_pool_op_dyn_free(struct tee_protmem_pool *pool,
+				     struct sg_table *sgt)
+{
+	struct optee_protmem_dyn_pool *rp = to_protmem_dyn_pool(pool);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sgtable_sg(sgt, sg, i)
+		gen_pool_free(rp->gen_pool, sg_phys(sg), sg->length);
+	sg_free_table(sgt);
+	put_dyn_protmem(rp);
+}
+
+static int protmem_pool_op_dyn_update_shm(struct tee_protmem_pool *pool,
+					  struct sg_table *sgt, size_t offs,
+					  struct tee_shm *shm,
+					  struct tee_shm **parent_shm)
+{
+	struct optee_protmem_dyn_pool *rp = to_protmem_dyn_pool(pool);
+
+	*parent_shm = rp->protmem;
+
+	return 0;
+}
+
+static void pool_op_dyn_destroy_pool(struct tee_protmem_pool *pool)
+{
+	struct optee_protmem_dyn_pool *rp = to_protmem_dyn_pool(pool);
+
+	mutex_destroy(&rp->mutex);
+	kfree(rp);
+}
+
+static struct tee_protmem_pool_ops protmem_pool_ops_dyn = {
+	.alloc = protmem_pool_op_dyn_alloc,
+	.free = protmem_pool_op_dyn_free,
+	.update_shm = protmem_pool_op_dyn_update_shm,
+	.destroy_pool = pool_op_dyn_destroy_pool,
+};
+
+static int get_protmem_config(struct optee *optee, u32 use_case,
+			      size_t *min_size, u_int *pa_width,
+			      u16 *end_points, u_int *ep_count)
+{
+	struct tee_param params[2] = {
+		[0] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT,
+			.u.value.a = use_case,
+		},
+		[1] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT,
+		},
+	};
+	struct optee_shm_arg_entry *entry;
+	struct tee_shm *shm_param = NULL;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	if (end_points && *ep_count) {
+		params[1].u.memref.size = *ep_count * sizeof(*end_points);
+		shm_param = tee_shm_alloc_priv_buf(optee->ctx,
+						   params[1].u.memref.size);
+		if (IS_ERR(shm_param))
+			return PTR_ERR(shm_param);
+		params[1].u.memref.shm = shm_param;
+	}
+
+	msg_arg = optee_get_msg_arg(optee->ctx, ARRAY_SIZE(params), &entry,
+				    &shm, &offs);
+	if (IS_ERR(msg_arg)) {
+		rc = PTR_ERR(msg_arg);
+		goto out_free_shm;
+	}
+	msg_arg->cmd = OPTEE_MSG_CMD_GET_PROTMEM_CONFIG;
+
+	rc = optee->ops->to_msg_param(optee, msg_arg->params,
+				      ARRAY_SIZE(params), params);
+	if (rc)
+		goto out_free_msg;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out_free_msg;
+	if (msg_arg->ret && msg_arg->ret != TEEC_ERROR_SHORT_BUFFER) {
+		rc = -EINVAL;
+		goto out_free_msg;
+	}
+
+	rc = optee->ops->from_msg_param(optee, params, ARRAY_SIZE(params),
+					msg_arg->params);
+	if (rc)
+		goto out_free_msg;
+
+	if (!msg_arg->ret && end_points &&
+	    *ep_count < params[1].u.memref.size / sizeof(u16)) {
+		rc = -EINVAL;
+		goto out_free_msg;
+	}
+
+	*min_size = params[0].u.value.a;
+	*pa_width = params[0].u.value.c;
+	*ep_count = params[1].u.memref.size / sizeof(u16);
+
+	if (msg_arg->ret == TEEC_ERROR_SHORT_BUFFER) {
+		rc = -ENOSPC;
+		goto out_free_msg;
+	}
+
+	if (end_points)
+		memcpy(end_points, tee_shm_get_va(shm_param, 0),
+		       params[1].u.memref.size);
+
+out_free_msg:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+out_free_shm:
+	if (shm_param)
+		tee_shm_free(shm_param);
+	return rc;
+}
+
+struct tee_protmem_pool *optee_protmem_alloc_dyn_pool(struct optee *optee,
+						      enum tee_dma_heap_id id)
+{
+	struct optee_protmem_dyn_pool *rp;
+	u32 use_case = id;
+	size_t min_size;
+	u_int pa_width;
+	int rc;
+
+	rp = kzalloc(sizeof(*rp), GFP_KERNEL);
+	if (!rp)
+		return ERR_PTR(-ENOMEM);
+	rp->use_case = use_case;
+
+	rc = get_protmem_config(optee, use_case, &min_size, &pa_width, NULL,
+				&rp->end_point_count);
+	if (rc) {
+		if (rc != -ENOSPC)
+			goto err;
+		rp->end_points = kcalloc(rp->end_point_count,
+					 sizeof(*rp->end_points), GFP_KERNEL);
+		if (!rp->end_points) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		rc = get_protmem_config(optee, use_case, &min_size, &pa_width,
+					rp->end_points, &rp->end_point_count);
+		if (rc)
+			goto err_kfree_eps;
+	}
+
+	rc = optee_set_dma_mask(optee, pa_width);
+	if (rc)
+		goto err_kfree_eps;
+
+	rp->pool.ops = &protmem_pool_ops_dyn;
+	rp->optee = optee;
+	rp->page_count = min_size / PAGE_SIZE;
+	mutex_init(&rp->mutex);
+
+	return &rp->pool;
+
+err_kfree_eps:
+	kfree(rp->end_points);
+err:
+	kfree(rp);
+	return ERR_PTR(rc);
+}
-- 
2.43.0

