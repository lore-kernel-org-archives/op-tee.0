Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA44CAC58E
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 13:56:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E925E4FE0C
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 13:56:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WX/3wJlI;
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 56E3F4FC6F
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 13:51:03 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-60f476e97c3so421589d50.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757598663; x=1758203463; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YC/jPvTDCH7V0MdE5QEYPuycikAgoYKWyE534nDYx4M=;
        b=WX/3wJlIOmHXmGmGIIyxjmnnrwjZ/GnXROOy3kQq4V6ItOiZ/wAkE9Mvi8BkjxKvyO
         6/R4xyoA08l885540fh7Iifz1Gn3L8GYksSj/L5/uZbvm+Ciffsv+xqlwTGUReNZDHgS
         G0n2w9KZLGH89Z6xlIAAk2bnP8MQbIWgg+WbspW4vBnn23qaWYkfdDXgzVku8e/oZzIf
         2mRvhV9Tbi2PlKbgc9bkOENh23lEZt+RWojEjivdq9RG0VONqctidGVJtn5pWoOBZhCv
         UyXdqkvJWr0WcBZZrjFSHA01BOTySeK+VbEO/N8tIzyR1HbNNs/XOpMceDzIvWW0/LyT
         mtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598663; x=1758203463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YC/jPvTDCH7V0MdE5QEYPuycikAgoYKWyE534nDYx4M=;
        b=UQazHJOtzuexQmLidb/XJ7lA7CCeIYRvgRskCYEPA+JVd0dnczpQ6rwqEkZnM/0C20
         qbp3OVRuZPvXnE0qYjUzRr8Vek0pXrbQtdzhdht5UZV7A8BYkFtPq++jmXmmMyG9aJfQ
         Ub5TMMujvUfnl9X3oBXehoCErbzxZTatlt8ynXYOq34vXytk4hq0oIoGsv9jPVbZen5E
         DagydjIw83aotDuoL6gC+6MfD4ixVFC8qnONk2s6bnNfWrvcnZaPX8hNs3lSOjdMJq1+
         aPkbFILI5oZ0am6VAHpl/BRvuosVUQg8QGZ9EjvNCDXYzn4637wBhc5IhqHPBHN/8us5
         TvvA==
X-Forwarded-Encrypted: i=1; AJvYcCUzIwK27sbPpfh7BIOJ2QNc7dnbjiiK4JktrwebrpK9g4/7F01PrKfRmAzVYK61BZ4a+xmcqVM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxVbxfyxDgq9uzu9MhgBbEPgjLLmnD1iCK9cChTk3h2lbN5RVVn
	I8J19qhHn3oB2A3FZS8UAK99lqaSPFKRePsaGQ2K27koWoZ0pS5XYP9NOqr59zNIaq3vMQ==
X-Gm-Gg: ASbGncsOAErDHOb+YzUazBqxUwr8LkKS+EB3l9cMy9tNzyXwUWfFoAxy+OHpQ9a6Q73
	AxHvMj6k91bfvYZR/RIqh3pa84IGjDeKAgRwsOezPPuTC3kEioUXaOukhFkzQuA4VrmAhmG3Plj
	xcMyBLkNburq7TxQ1jyj/RYNYhLQS5N422s/QlKXdPby2CGQk66kR7qxZFDOBv6FAebNkmk9nZx
	G0n5cTWs5JZ7gqeia7ZlZ4aGMJNTziO2Yn8L+LHgJGtTkc02Og+O83JgwPAXRJHCBuauWhc5to3
	i7Ps4NlsQzG6YQHNT1dOxH3cXQ2Xm0pIxQ1H2dQArLCPOnTzAA0dmqSq/3T1Zc/OBL+LTpyp6Ae
	NfQkJyADe8Z7Ndrt9H5AG2toMUuM4VHXpal4wecHm1Z0Rvmzzg1+WfdsqY+Uo3qy+oAqlLK0lJo
	A=
X-Google-Smtp-Source: AGHT+IHZBm0VWF5Q2HiB0+9X7Vnwcu0dm3iI+l+WvOP7Jt3IX2w3wk8CNJ5VHY3b6oDMOP/vs9Jw5w==
X-Received: by 2002:a53:b3c8:0:b0:5fb:957d:d74f with SMTP id 956f58d0204a3-6102163daa0mr12706114d50.3.1757598662617;
        Thu, 11 Sep 2025 06:51:02 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7623434csm3526257b3.11.2025.09.11.06.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:51:01 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v12 9/9] optee: smc abi: dynamic protected memory allocation
Date: Thu, 11 Sep 2025 15:49:50 +0200
Message-ID: <20250911135007.1275833-10-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911135007.1275833-1-jens.wiklander@linaro.org>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 56E3F4FC6F
X-Spamd-Bar: ++
X-Spamd-Result: default: False [2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	RBL_VIRUSFREE_BOTNET(2.00)[74.125.224.49:from];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	NEURAL_HAM(-0.00)[-0.878];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[37.123.177.177:received,74.125.224.49:from];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	R_DKIM_ALLOW(0.00)[linaro.org:s=google];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.224.49:from];
	TAGGED_RCPT(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	R_SPF_ALLOW(0.00)[+ip4:74.125.0.0/16:c];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: JZEN6X3ILSN6LVLGAZYIXZZKEVMNTRTY
X-Message-ID-Hash: JZEN6X3ILSN6LVLGAZYIXZZKEVMNTRTY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JZEN6X3ILSN6LVLGAZYIXZZKEVMNTRTY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add support in the OP-TEE backend driver for dynamic protected memory
allocation using the SMC ABI.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/smc_abi.c | 78 +++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b4c007ed3b94..0be663fcd52b 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -965,6 +965,70 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 	return rc;
 }
 
+static int optee_smc_lend_protmem(struct optee *optee, struct tee_shm *protmem,
+				  u32 *mem_attrs, unsigned int ma_count,
+				  u32 use_case)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg = optee_get_msg_arg(optee->ctx, 2, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_LEND_PROTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	msg_arg->params[0].u.value.a = use_case;
+	msg_arg->params[1].attr = OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
+	msg_arg->params[1].u.tmem.buf_ptr = protmem->paddr;
+	msg_arg->params[1].u.tmem.size = protmem->size;
+	msg_arg->params[1].u.tmem.shm_ref = (u_long)protmem;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret != TEEC_SUCCESS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	protmem->sec_world_id = (u_long)protmem;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
+static int optee_smc_reclaim_protmem(struct optee *optee,
+				     struct tee_shm *protmem)
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
+	msg_arg->cmd = OPTEE_MSG_CMD_RECLAIM_PROTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+	msg_arg->params[0].u.rmem.shm_ref = (u_long)protmem;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret != TEEC_SUCCESS)
+		rc = -EINVAL;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
 /*
  * 5. Asynchronous notification
  */
@@ -1216,6 +1280,8 @@ static const struct optee_ops optee_ops = {
 	.do_call_with_arg = optee_smc_do_call_with_arg,
 	.to_msg_param = optee_to_msg_param,
 	.from_msg_param = optee_from_msg_param,
+	.lend_protmem = optee_smc_lend_protmem,
+	.reclaim_protmem = optee_smc_reclaim_protmem,
 };
 
 static int enable_async_notif(optee_invoke_fn *invoke_fn)
@@ -1627,14 +1693,20 @@ static struct tee_protmem_pool *static_protmem_pool_init(struct optee *optee)
 
 static int optee_protmem_pool_init(struct optee *optee)
 {
+	bool protm = optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM;
+	bool dyn_protm = optee->smc.sec_caps &
+			 OPTEE_SMC_SEC_CAP_DYNAMIC_PROTMEM;
 	enum tee_dma_heap_id heap_id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
 	struct tee_protmem_pool *pool = ERR_PTR(-EINVAL);
-	int rc;
+	int rc = -EINVAL;
 
-	if (!(optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM))
+	if (!protm && !dyn_protm)
 		return 0;
 
-	pool = static_protmem_pool_init(optee);
+	if (protm)
+		pool = static_protmem_pool_init(optee);
+	if (dyn_protm && IS_ERR(pool))
+		pool = optee_protmem_alloc_dyn_pool(optee, heap_id);
 	if (IS_ERR(pool))
 		return PTR_ERR(pool);
 
-- 
2.43.0

