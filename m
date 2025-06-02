Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760F9C54FB3
	for <op-tee@archiver.kernel.org>; Mon,  2 Jun 2025 12:05:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9577F42F57
	for <op-tee@archiver.kernel.org>; Mon,  2 Jun 2025 12:05:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uJXarZdk;
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AE14D42F57
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Jun 2025 12:05:10 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad883afdf0cso825606966b.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Jun 2025 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748865909; x=1749470709; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXqT1W9coYxflQ58g2BW6Pc86Dj0YWrYeMFCe9jmnks=;
        b=uJXarZdko53pijXEPbtrheo6xNN0Q4YEE36fiOFkv9K021jS1iuYiT8WCaI8cHvkS5
         kiniM2yBmKz+Uz/FYeXo11KlRq0o96L+iDbITyYhgx3mVABJgH7ti5F4T+QJ8KeSpGlt
         t0+ao7FbHDzzIyOGNA9Dk9/rsBuvNIgBMmkEx9+AG35SWby6ovpYnsHDTyNIa3cBIDsE
         PgXvyf2CD0I2FqtHGq/Jm048GdDk2WE6QBXpvPiPzwwZ7yqoBIR+aRrdBfWVQlUDDHmg
         HwUA8gGS0MKXteYaRLz7jQ8pvOxiuixLK26zPOkf3gmfTALmy8KGFDpPP0H2hrYUJoD1
         x3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748865909; x=1749470709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXqT1W9coYxflQ58g2BW6Pc86Dj0YWrYeMFCe9jmnks=;
        b=vewtMoFZUFlqtC6VFPZGZcfO9tLoHWYPkcNB3jCaeUjq+za1MIfDPrUvqLDr0/9uIB
         sMoW72Oih4DN3MLWDcyVg5QSOY4CVC9qzpNBPQfsiqW0Z4GP6KIIZngmFbhxrONONTZe
         dUVWr+qFOtcItyULr8TnYGfOIXrMgZKs0IhOoYmasq/lhPODpjWwUx+5q/TELqOKDFmS
         fiPmeOdFvHJmoxnGlSc9I4yk3TDicA2byryIb1qJGubkX/X//bbsPO8N46Rw8iNVC9q4
         qGEttnx3INp4NUULqDh57Ds9fbkIuAy6KJehXwJ6NI4q/o3QA8BKrcU9XFHx0Hm1VNsu
         XzNw==
X-Forwarded-Encrypted: i=1; AJvYcCU0R74Y3xQfdKuS05M5qr2Il0SF3qR+vWXhdjmRROhB2JTJrPUX+6ftPl3S512dQpV0wJ6R0tE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyOpS1rpsOiv9lFTmuzYmf4dJ1wuSV6pezRthzzFx7gJrM5KeqB
	GEDDsOqoGIsxH6VTN2zwBPnjRxkQGUcJMucgXOXQ+nBHG0dTGy2/EYiekZv418jWkF85LQ==
X-Gm-Gg: ASbGnctDmezkajU5i3Nyq12WKLhPqmP5IHsw9qHBFcIi/LHpa2X5q3PKY58uEhfFFBB
	KGV0bFYkCPHOWpUlbz4EtqSUH4/yor2TGxCfVKgSTSfUltqfn9j1+wlLSdzBzfpDAN2bGLfqlUq
	Z7dzJ86votSWWc8kiDPebPgsxp2g3/+iFd0+9DRPIeYkOe4pFQ7D3zjzvFoDLXXkKvRnvxN+ML8
	p58KTAGLtw7l1vF0XLb0xKfY2GF/KphzKlUnm07K9+jVFUWejLaPTW2IpZKfYskSerL9/uDRqIo
	OpU9Yhs5CX2clhPq/RrUPC3BXSwZj93u+fl9UFMZGCEXKkreyJGKdfnyotu4ji4XImugEBfkksK
	OhbiniUnpNdR8ZSIpftaMMQS8sNpv
X-Google-Smtp-Source: AGHT+IEVQ9uC/APOXLZA8rP51xl0Oh2FIud0sbigPbTzSlGEbMSLk7pPhiqm+QJ0ezu7OnHY+TD/yA==
X-Received: by 2002:a17:907:60d6:b0:ad8:a88c:84e3 with SMTP id a640c23a62f3a-adb36ba4bf9mr1159519166b.33.1748865909550;
        Mon, 02 Jun 2025 05:05:09 -0700 (PDT)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5e2bf029sm777773466b.115.2025.06.02.05.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:05:08 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Subject: [PATCH] optee: ffa: fix sleep in atomic context
Date: Mon,  2 Jun 2025 14:04:35 +0200
Message-ID: <20250602120452.2507084-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.218.44:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.218.44:from];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AE14D42F57
Message-ID-Hash: J4PFQL4T7V42L5KNNQCKTDEOUWCCQXNF
X-Message-ID-Hash: J4PFQL4T7V42L5KNNQCKTDEOUWCCQXNF
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jerome Forissier <jerome.forissier@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J4PFQL4T7V42L5KNNQCKTDEOUWCCQXNF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

The OP-TEE driver registers the function notif_callback() for FF-A
notifications. However, this function is called in an atomic context
leading to errors like this when processing asynchronous notifications:

 | BUG: sleeping function called from invalid context at kernel/locking/mutex.c:258
 | in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9, name: kworker/0:0
 | preempt_count: 1, expected: 0
 | RCU nest depth: 0, expected: 0
 | CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.14.0-00019-g657536ebe0aa #13
 | Hardware name: linux,dummy-virt (DT)
 | Workqueue: ffa_pcpu_irq_notification notif_pcpu_irq_work_fn
 | Call trace:
 |  show_stack+0x18/0x24 (C)
 |  dump_stack_lvl+0x78/0x90
 |  dump_stack+0x18/0x24
 |  __might_resched+0x114/0x170
 |  __might_sleep+0x48/0x98
 |  mutex_lock+0x24/0x80
 |  optee_get_msg_arg+0x7c/0x21c
 |  simple_call_with_arg+0x50/0xc0
 |  optee_do_bottom_half+0x14/0x20
 |  notif_callback+0x3c/0x48
 |  handle_notif_callbacks+0x9c/0xe0
 |  notif_get_and_handle+0x40/0x88
 |  generic_exec_single+0x80/0xc0
 |  smp_call_function_single+0xfc/0x1a0
 |  notif_pcpu_irq_work_fn+0x2c/0x38
 |  process_one_work+0x14c/0x2b4
 |  worker_thread+0x2e4/0x3e0
 |  kthread+0x13c/0x210
 |  ret_from_fork+0x10/0x20

Fix this by adding work queue to process the notification in a
non-atomic context.

Fixes: d0476a59de06 ("optee: ffa_abi: add asynchronous notifications")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c       | 41 ++++++++++++++++++++++++-------
 drivers/tee/optee/optee_private.h |  2 ++
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f3af5666bb11..f9ef7d94cebd 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -728,12 +728,21 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 	return true;
 }
 
+static void notif_work_fn(struct work_struct *work)
+{
+	struct optee_ffa *optee_ffa = container_of(work, struct optee_ffa,
+						   notif_work);
+	struct optee *optee = container_of(optee_ffa, struct optee, ffa);
+
+	optee_do_bottom_half(optee->ctx);
+}
+
 static void notif_callback(int notify_id, void *cb_data)
 {
 	struct optee *optee = cb_data;
 
 	if (notify_id == optee->ffa.bottom_half_value)
-		optee_do_bottom_half(optee->ctx);
+		queue_work(optee->ffa.notif_wq, &optee->ffa.notif_work);
 	else
 		optee_notif_send(optee, notify_id);
 }
@@ -817,9 +826,11 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 	struct optee *optee = ffa_dev_get_drvdata(ffa_dev);
 	u32 bottom_half_id = optee->ffa.bottom_half_value;
 
-	if (bottom_half_id != U32_MAX)
+	if (bottom_half_id != U32_MAX) {
 		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
 							      bottom_half_id);
+		destroy_workqueue(optee->ffa.notif_wq);
+	}
 	optee_remove_common(optee);
 
 	mutex_destroy(&optee->ffa.mutex);
@@ -835,6 +846,13 @@ static int optee_ffa_async_notif_init(struct ffa_device *ffa_dev,
 	u32 notif_id = 0;
 	int rc;
 
+	INIT_WORK(&optee->ffa.notif_work, notif_work_fn);
+	optee->ffa.notif_wq = create_workqueue("optee_notification");
+	if (!optee->ffa.notif_wq) {
+		rc = -EINVAL;
+		goto err;
+	}
+
 	while (true) {
 		rc = ffa_dev->ops->notifier_ops->notify_request(ffa_dev,
 								is_per_vcpu,
@@ -851,19 +869,24 @@ static int optee_ffa_async_notif_init(struct ffa_device *ffa_dev,
 		 * notifications in that case.
 		 */
 		if (rc != -EACCES)
-			return rc;
+			goto err_wq;
 		notif_id++;
 		if (notif_id >= OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE)
-			return rc;
+			goto err_wq;
 	}
 	optee->ffa.bottom_half_value = notif_id;
 
 	rc = enable_async_notif(optee);
-	if (rc < 0) {
-		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
-							      notif_id);
-		optee->ffa.bottom_half_value = U32_MAX;
-	}
+	if (rc < 0)
+		goto err_rel;
+
+	return 0;
+err_rel:
+	ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev, notif_id);
+err_wq:
+	destroy_workqueue(optee->ffa.notif_wq);
+err:
+	optee->ffa.bottom_half_value = U32_MAX;
 
 	return rc;
 }
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index dc0f355ef72a..9526087f0e68 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -165,6 +165,8 @@ struct optee_ffa {
 	/* Serializes access to @global_ids */
 	struct mutex mutex;
 	struct rhashtable global_ids;
+	struct workqueue_struct *notif_wq;
+	struct work_struct notif_work;
 };
 
 struct optee;
-- 
2.43.0

