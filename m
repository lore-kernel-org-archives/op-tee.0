Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EF4EC01A6
	for <op-tee@archiver.kernel.org>; Mon, 23 Mar 2026 08:41:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E7FCA43DEF
	for <op-tee@archiver.kernel.org>; Mon, 23 Mar 2026 08:41:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aRM1Ps6C;
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B8AAE41A34
	for <op-tee@lists.trustedfirmware.org>; Sun, 22 Mar 2026 16:31:22 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56ce54c8c82so556427e0c.2
        for <op-tee@lists.trustedfirmware.org>; Sun, 22 Mar 2026 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774197082; x=1774801882; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfCZJAbd1LpmnuBBLu17NpZwGzJ2K2NQwLQJ5IKDWMg=;
        b=aRM1Ps6CC2SekR0gw9aOMa+5mg/bHb/PrZNEGn3XxyXSFGBMjeUd9avVueGOPuqMqJ
         U3EuiRfzJQ/glPyeQU+0lshM+427gnMl9dugSlm69bdxTNz5dSb0QARHBroLZD037vC5
         cq6n47q2MCxKUy6o2IMmY1kg3uBXEn9J2dwlVDDRFlgIiJFpRbopX/fQFMTMqvDCY73w
         bQMYkCaY7dDn3td8leINTn8yIV0QBewtcv88ZkB0goEBGS0K6sAxZpOoSRzGK2ZVnjCr
         0LAE4si1tjIZ9feWcM3O/zlDL2V1O53FCB1NP1NbXrtdEuHFah9+cxp0liPAllc1D3+4
         hK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774197082; x=1774801882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfCZJAbd1LpmnuBBLu17NpZwGzJ2K2NQwLQJ5IKDWMg=;
        b=GJljzw6fDB2E06hwnL8sySSIW7HzgmR5toeHsIQ+TsAWlOt/B0WfHuiMJNYljT+ckV
         JNBxtVkM+X4HBVBrATfZ7chaeFSJKEcnH1yGrAXVVwJcgrVg0tZ1XgH52nzK5K6Fw+dQ
         JujbldkGycinHzVIVe/rRPG1T7qbRsapN1YvwoEj1GXjJ0DWBz5etdF3olKQcd5/ptvk
         4rze4nx+0GAWReABuVKlKH94ZkuLa5ZoK+0ptppPKEE734ypnBAZ9ZFE63lQjxcTsfJ2
         +GKzqr0WUfyeAMKHUMXQYFkJfKRz0brxTeylaXmTW1cK9QIVgZcd8C20MmkQ9WiCdJ4u
         6KZg==
X-Forwarded-Encrypted: i=1; AJvYcCW7KjA7eyOY+uhqAVzfR2ipisA8BreiWLWdw/W0y/hw3MtZu415zTndC0l9p6V+UEq59wbr6S0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyl8P59+kWfgdWRB/d7svaLPdbLGk3G9ZCkI4iWtSXSu7unZX80
	Djp1zv+363LF/XYH3xB0nccw7RAYmLjGuNCszMi5s/f0KZ7RGiBL/pce
X-Gm-Gg: ATEYQzyf8oOpRerdgX59BjuLKdtntO036f9daW7e/TgRsZ0aK8gAyWjDi4aHj1QYHmI
	5Ofc1FEfc9lQKE7OpQHvY7RDJcLtIl7Ol2lC3Uc60iLXxWHvj1xWrS2rTxM4dmtEZsEyQGKZ3ZK
	HZ3kjZpXTpmMPzF0suLIVUC+NsXBL3SbLREQUM+8fKq8MjMO4Xui9I9blCsEzbILZx6xwElwIpB
	RyBDxzDLRYc4NoJNAxCutcC69vm491ob2VSaAN8NMSZwpMCeBW8Zk0jLw5hb0WDGdcHjY+uthVq
	zZSbgy1N8u7OTnnfKEoiTtTzG3iS1VU3W5MMKS/0mCNPSTcx5nw/3sqKSe2hbqhaEsl+VBuKSm5
	XCZ4rcJpEhV7eJ3uS/Cuj2rEpMu1xwb43po310sjptSUPDeSLlAMTtSkIby5e11JHdhqdEDDlq8
	tuDyYe3NVdG+eT/AhKwv8ScQ==
X-Received: by 2002:a05:6122:510:b0:56c:ce79:9e18 with SMTP id 71dfb90a1353d-56cde32324bmr3666294e0c.4.1774197082006;
        Sun, 22 Mar 2026 09:31:22 -0700 (PDT)
Received: from dream.. ([2804:1b3:a701:31ac:8f8e:b3a6:98ae:53a1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddb6d041sm8202043e0c.1.2026.03.22.09.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 09:31:21 -0700 (PDT)
From: Rodrigo Zaiden <rodrigoffzz@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] tee: optee: fix kernel-doc warnings
Date: Sun, 22 Mar 2026 13:31:14 -0300
Message-ID: <20260322163114.17233-1-rodrigoffzz@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,linuxfoundation.org,brighamcampbell.com,gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.173:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.173:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B8AAE41A34
X-Spamd-Bar: --
X-MailFrom: rodrigoffzz@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: XCURA7W4ZFM4WU5OSYQRSOQMWE6NUE57
X-Message-ID-Hash: XCURA7W4ZFM4WU5OSYQRSOQMWE6NUE57
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:41:40 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, Shuah Khan <skhan@linuxfoundation.org>, Brigham Campbell <me@brighamcampbell.com>, Rodrigo Zaiden <rodrigoffzz@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XCURA7W4ZFM4WU5OSYQRSOQMWE6NUE57/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Fix kernel-doc issues in optee_private.h and optee_msg.h:

- Add missing documentation for struct members: optee_msg_param_value,
  optee_msg_param, optee_msg_arg, optee, and optee_ffa;
- Ensure member descriptions follow the order of declaration;
- Use consistent formatting (lowercase descriptions and ':' after
  member names);
- Adjust indentation for better alignment;

This resolves kernel-doc warnings such as missing member descriptions
and incorrect prototype documentation.
No functional changes.

Signed-off-by: Rodrigo Zaiden <rodrigoffzz@gmail.com>
---
 drivers/tee/optee/optee_msg.h     |  50 +++++++------
 drivers/tee/optee/optee_private.h | 120 ++++++++++++++++--------------
 2 files changed, 92 insertions(+), 78 deletions(-)

diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 838e1d4a22f0..7d9b12e71c03 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -103,9 +103,9 @@
 
 /**
  * struct optee_msg_param_tmem - temporary memory reference parameter
- * @buf_ptr:	Address of the buffer
- * @size:	Size of the buffer
- * @shm_ref:	Temporary shared memory reference, pointer to a struct tee_shm
+ * @buf_ptr:	address of the buffer
+ * @size:	size of the buffer
+ * @shm_ref:	temporary shared memory reference, pointer to a struct tee_shm
  *
  * Secure and normal world communicates pointers as physical address
  * instead of the virtual address. This is because secure and normal world
@@ -122,9 +122,9 @@ struct optee_msg_param_tmem {
 
 /**
  * struct optee_msg_param_rmem - registered memory reference parameter
- * @offs:	Offset into shared memory reference
- * @size:	Size of the buffer
- * @shm_ref:	Shared memory reference, pointer to a struct tee_shm
+ * @offs:	offset into shared memory reference
+ * @size:	size of the buffer
+ * @shm_ref:	shared memory reference, pointer to a struct tee_shm
  */
 struct optee_msg_param_rmem {
 	u64 offs;
@@ -134,12 +134,12 @@ struct optee_msg_param_rmem {
 
 /**
  * struct optee_msg_param_fmem - FF-A memory reference parameter
- * @offs_lower:	   Lower bits of offset into shared memory reference
- * @offs_upper:	   Upper bits of offset into shared memory reference
- * @internal_offs: Internal offset into the first page of shared memory
- *		   reference
- * @size:	   Size of the buffer
- * @global_id:	   Global identifier of the shared memory
+ * @offs_low:		lower bits of offset into shared memory reference
+ * @offs_high:		higher bits of offset into shared memory reference
+ * @internal_offs:	internal offset into the first page of shared memory
+ *			reference
+ * @size:		size of the buffer
+ * @global_id:		global identifier of the shared memory
  */
 struct optee_msg_param_fmem {
 	u32 offs_low;
@@ -151,6 +151,9 @@ struct optee_msg_param_fmem {
 
 /**
  * struct optee_msg_param_value - opaque value parameter
+ * @a: first opaque value
+ * @b: second opaque value
+ * @c: third opaque value
  *
  * Value parameters are passed unchecked between normal and secure world.
  */
@@ -168,6 +171,7 @@ struct optee_msg_param_value {
  * @fmem:	parameter by FF-A registered memory reference
  * @value:	parameter by opaque value
  * @octets:	parameter by octet string
+ * @u:		union holding OP-TEE msg parameter
  *
  * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is used in
  * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value or octets,
@@ -189,16 +193,18 @@ struct optee_msg_param {
 
 /**
  * struct optee_msg_arg - call argument
- * @cmd: Command, one of OPTEE_MSG_CMD_* or OPTEE_MSG_RPC_CMD_*
- * @func: Trusted Application function, specific to the Trusted Application,
- *	     used if cmd == OPTEE_MSG_CMD_INVOKE_COMMAND
- * @session: In parameter for all OPTEE_MSG_CMD_* except
- *	     OPTEE_MSG_CMD_OPEN_SESSION where it's an output parameter instead
- * @cancel_id: Cancellation id, a unique value to identify this request
- * @ret: return value
- * @ret_origin: origin of the return value
- * @num_params: number of parameters supplied to the OS Command
- * @params: the parameters supplied to the OS Command
+ * @cmd:	command, one of OPTEE_MSG_CMD_* or OPTEE_MSG_RPC_CMD_*
+ * @func:	Trusted Application function, specific to the Trusted
+ *		Application, used if cmd == OPTEE_MSG_CMD_INVOKE_COMMAND
+ * @session:	in parameter for all OPTEE_MSG_CMD_* except
+ *		OPTEE_MSG_CMD_OPEN_SESSION where it's an output parameter
+ *		instead
+ * @cancel_id:	cancellation id, a unique value to identify this request
+ * @pad:	padding for alignment
+ * @ret:	return value
+ * @ret_origin:	origin of the return value
+ * @num_params:	number of parameters supplied to the OS Command
+ * @params:	the parameters supplied to the OS Command
  *
  * All normal calls to Trusted OS uses this struct. If cmd requires further
  * information than what these fields hold it can be passed as a parameter
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index acd3051c4879..aefe1e6f5689 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -47,11 +47,11 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
 				unsigned long, unsigned long,
 				struct arm_smccc_res *);
 
-/*
+/**
  * struct optee_call_waiter - TEE entry may need to wait for a free TEE thread
- * @list_node		Reference in waiters list
- * @c			Waiting completion reference
- * @sys_thread		True if waiter belongs to a system thread
+ * @list_node:	reference in waiters list
+ * @c:		waiting completion reference
+ * @sys_thread:	true if waiter belongs to a system thread
  */
 struct optee_call_waiter {
 	struct list_head list_node;
@@ -59,13 +59,13 @@ struct optee_call_waiter {
 	bool sys_thread;
 };
 
-/*
+/**
  * struct optee_call_queue - OP-TEE call queue management
- * @mutex			Serializes access to this struct
- * @waiters			List of threads waiting to enter OP-TEE
- * @total_thread_count		Overall number of thread context in OP-TEE or 0
- * @free_thread_count		Number of threads context free in OP-TEE
- * @sys_thread_req_count	Number of registered system thread sessions
+ * @mutex:			serializes access to this struct
+ * @waiters:			list of threads waiting to enter OP-TEE
+ * @total_thread_count:		overall number of thread context in OP-TEE or 0
+ * @free_thread_count:		number of threads context free in OP-TEE
+ * @sys_thread_req_count:	number of registered system thread sessions
  */
 struct optee_call_queue {
 	/* Serializes access to this struct */
@@ -96,17 +96,17 @@ struct optee_shm_arg_cache {
 
 /**
  * struct optee_supp - supplicant synchronization struct
- * @ctx			the context of current connected supplicant.
- *			if !NULL the supplicant device is available for use,
- *			else busy
- * @mutex:		held while accessing content of this struct
- * @req_id:		current request id if supplicant is doing synchronous
- *			communication, else -1
- * @reqs:		queued request not yet retrieved by supplicant
- * @idr:		IDR holding all requests currently being processed
- *			by supplicant
- * @reqs_c:		completion used by supplicant when waiting for a
- *			request to be queued.
+ * @mutex:	held while accessing content of this struct
+ * @ctx:	the context of current connected supplicant.
+ *		if !NULL the supplicant device is available for use,
+ *		else busy
+ * @req_id:	current request id if supplicant is doing synchronous
+ *		communication, else -1
+ * @reqs:	queued request not yet retrieved by supplicant
+ * @idr:	IDR holding all requests currently being processed
+ *		by supplicant
+ * @reqs_c:	completion used by supplicant when waiting for a
+ *		request to be queued.
  */
 struct optee_supp {
 	/* Serializes access to this struct */
@@ -119,25 +119,25 @@ struct optee_supp {
 	struct completion reqs_c;
 };
 
-/*
+/**
  * struct optee_pcpu - per cpu notif private struct passed to work functions
- * @optee		optee device reference
+ * @optee:	optee device reference
  */
 struct optee_pcpu {
 	struct optee *optee;
 };
 
-/*
+/**
  * struct optee_smc - optee smc communication struct
- * @invoke_fn		handler function to invoke secure monitor
- * @memremaped_shm	virtual address of memory in shared memory pool
+ * @invoke_fn:		handler function to invoke secure monitor
+ * @memremaped_shm:	virtual address of memory in shared memory pool
  * @sec_caps:		secure world capabilities defined by
  *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
- * @notif_irq		interrupt used as async notification by OP-TEE or 0
- * @optee_pcpu		per_cpu optee instance for per cpu work or NULL
- * @notif_pcpu_wq	workqueue for per cpu asynchronous notification or NULL
- * @notif_pcpu_work	work for per cpu asynchronous notification
- * @notif_cpuhp_state   CPU hotplug state assigned for pcpu interrupt management
+ * @notif_irq:		interrupt used as async notification by OP-TEE or 0
+ * @optee_pcpu:		per_cpu optee instance for per cpu work or NULL
+ * @notif_pcpu_wq:	workqueue for per cpu asynchronous notification or NULL
+ * @notif_pcpu_work:	work for per cpu asynchronous notification
+ * @notif_cpuhp_state:	CPU hotplug state assigned for pcpu interrupt management
  */
 struct optee_smc {
 	optee_invoke_fn *invoke_fn;
@@ -151,13 +151,15 @@ struct optee_smc {
 };
 
 /**
- * struct optee_ffa_data -  FFA communication struct
- * @ffa_dev		FFA device, contains the destination id, the id of
+ * struct optee_ffa -  FFA communication struct
+ * @ffa_dev:		FFA device, contains the destination id, the id of
  *			OP-TEE in secure world
- * @bottom_half_value	Notification ID used for bottom half signalling or
+ * @bottom_half_value:	notification ID used for bottom half signalling or
  *			U32_MAX if unused
- * @mutex		Serializes access to @global_ids
- * @global_ids		FF-A shared memory global handle translation
+ * @mutex:		serializes access to @global_ids
+ * @global_ids:		FF-A shared memory global handle translation
+ * @notif_wq:		workqueue for FF-A asynchronous notification
+ * @notif_work:		work for FF-A asynchronous notification
  */
 struct optee_ffa {
 	struct ffa_device *ffa_dev;
@@ -222,26 +224,32 @@ struct optee_ops {
 
 /**
  * struct optee - main service struct
- * @supp_teedev:	supplicant device
- * @teedev:		client device
- * @ops:		internal callbacks for different ways to reach secure
- *			world
- * @ctx:		driver internal TEE context
- * @smc:		specific to SMC ABI
- * @ffa:		specific to FF-A ABI
- * @call_queue:		queue of threads waiting to call @invoke_fn
- * @notif:		notification synchronization struct
- * @supp:		supplicant synchronization struct for RPC to supplicant
- * @pool:		shared memory pool
- * @mutex:		mutex protecting @rpmb_dev
- * @rpmb_dev:		current RPMB device or NULL
- * @rpmb_scan_bus_done	flag if device registation of RPMB dependent devices
- *			was already done
- * @rpmb_scan_bus_work	workq to for an RPMB device and to scan optee bus
- *			and register RPMB dependent optee drivers
- * @rpc_param_count:	If > 0 number of RPC parameters to make room for
- * @scan_bus_done	flag if device registation was already done.
- * @scan_bus_work	workq to scan optee bus and register optee drivers
+ * @supp_teedev:		supplicant device
+ * @teedev:			client device
+ * @ops:			internal callbacks for different ways to reach
+ *				secure world
+ * @ctx:			driver internal TEE context
+ * @smc:			specific to SMC ABI
+ * @ffa:			specific to FF-A ABI
+ * @shm_arg_cache:		shared memory cache argument
+ * @call_queue:			queue of threads waiting to call @invoke_fn
+ * @notif:			notification synchronization struct
+ * @supp:			supplicant synchronization struct for RPC to
+ *				supplicant
+ * @pool:			shared memory pool
+ * @rpmb_dev_mutex:		mutex protecting @rpmb_dev
+ * @rpmb_dev:			current RPMB device or NULL
+ * @rpmb_intf:			RPMB notifier block
+ * @rpc_param_count:		if > 0 number of RPC parameters to make room for
+ * @scan_bus_done:		flag if device registation was already done
+ * @rpmb_scan_bus_done:		flag if device registation of RPMB dependent
+ *				devices was already done
+ * @in_kernel_rpmb_routing:	flag if OP-TEE supports in-kernel RPMB routing
+ * @scan_bus_work:		workq to scan optee bus and register optee
+ *				drivers
+ * @rpmb_scan_bus_work:		workq to for an RPMB device and to scan optee
+ *				bus and register RPMB dependent optee drivers
+ * @revision:			OP-TEE OS revision
  */
 struct optee {
 	struct tee_device *supp_teedev;
-- 
2.43.0

