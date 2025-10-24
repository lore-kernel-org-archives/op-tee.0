Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948F6CCD1AB
	for <op-tee@archiver.kernel.org>; Fri, 24 Oct 2025 05:21:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D7D0F4FF8B
	for <op-tee@archiver.kernel.org>; Fri, 24 Oct 2025 05:21:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hNcw4awF;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CEF7F43131
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Oct 2025 05:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=XkcekN7NTU4m2D27vewkJxwVK8Ws3wU7k2cIeR+8Qgg=; b=hNcw4awFWRWIz7FuDHVccrWe62
	EG+RQQhhCUbGp530FsyuOGQXqLbIiblzIBZlOb6Lf1XWpG7jExykY1WW7cKESc1SYqxYdXGTWlbz3
	3fhm2ygHYTlaFw7WTaJyg/o3c3VZkgVkXqE5vLd4+MfHX1Op0NXKAxhpgYRf9oWc8pFMBqpy0jOoP
	5twYklJmzg+VrYqtbn2aCka+lpEivXT5oJRw4oJVFyYsHFmpqpTKT7XFBPO1KtqMmAx/2U5Rb3AmJ
	dGMVH7f6BE9FZhiOOiikTINcIFgeF+jn4NAomht9AqyEoKLVp2NjBZG4ZqLifMHLUlyBIIxykKIFQ
	wJfuCIlg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCAEY-00000008Gcu-2nrW;
	Fri, 24 Oct 2025 05:21:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] tee: <uapi/linux/tee.h: fix all kernel-doc issues
Date: Thu, 23 Oct 2025 22:21:02 -0700
Message-ID: <20251024052102.635908-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CEF7F43131
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[infradead.org:dkim];
	R_MISSING_CHARSET(0.50)[];
	ONCE_RECEIVED(0.20)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:7247, ipnet:198.137.202.0/24, country:US];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[198.137.202.133:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_SPF_NA(0.00)[no SPF record];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	DMARC_NA(0.00)[infradead.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: G7O4FA7VPIRJMN4NKQY3WO7NZZYQWRO6
X-Message-ID-Hash: G7O4FA7VPIRJMN4NKQY3WO7NZZYQWRO6
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G7O4FA7VPIRJMN4NKQY3WO7NZZYQWRO6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Fix kernel-doc warnings so that there no other kernel-doc issues
in <uapi/linux/tee.h>:

- add ending ':' to some struct members as needed for kernel-doc
- change struct name in kernel-doc to match the actual struct name (2x)
- add a @params: kernel-doc entry multiple times

Warning: tee.h:265 struct member 'ret_origin' not described
 in 'tee_ioctl_open_session_arg'
Warning: tee.h:265 struct member 'num_params' not described
 in 'tee_ioctl_open_session_arg'
Warning: tee.h:265 struct member 'params' not described
 in 'tee_ioctl_open_session_arg'
Warning: tee.h:351 struct member 'num_params' not described
 in 'tee_iocl_supp_recv_arg'
Warning: tee.h:351 struct member 'params' not described
 in 'tee_iocl_supp_recv_arg'
Warning: tee.h:372 struct member 'num_params' not described
 in 'tee_iocl_supp_send_arg'
Warning: tee.h:372 struct member 'params' not described
 in 'tee_iocl_supp_send_arg'
Warning: tee.h:298: expecting prototype for struct
 tee_ioctl_invoke_func_arg. Prototype was for
 struct tee_ioctl_invoke_arg instead
Warning: tee.h:473: expecting prototype for struct
 tee_ioctl_invoke_func_arg. Prototype was for struct
 tee_ioctl_object_invoke_arg instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: op-tee@lists.trustedfirmware.org
---
 include/uapi/linux/tee.h |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- linux-next-20251022.orig/include/uapi/linux/tee.h
+++ linux-next-20251022/include/uapi/linux/tee.h
@@ -249,8 +249,9 @@ struct tee_ioctl_param {
  * @cancel_id:	[in] Cancellation id, a unique value to identify this request
  * @session:	[out] Session id
  * @ret:	[out] return value
- * @ret_origin	[out] origin of the return value
- * @num_params	[in] number of parameters following this struct
+ * @ret_origin:	[out] origin of the return value
+ * @num_params:	[in] number of &struct tee_ioctl_param entries in @params
+ * @params:	array of ioctl parameters
  */
 struct tee_ioctl_open_session_arg {
 	__u8 uuid[TEE_IOCTL_UUID_LEN];
@@ -276,14 +277,14 @@ struct tee_ioctl_open_session_arg {
 				     struct tee_ioctl_buf_data)
 
 /**
- * struct tee_ioctl_invoke_func_arg - Invokes a function in a Trusted
- * Application
+ * struct tee_ioctl_invoke_arg - Invokes a function in a Trusted Application
  * @func:	[in] Trusted Application function, specific to the TA
  * @session:	[in] Session id
  * @cancel_id:	[in] Cancellation id, a unique value to identify this request
  * @ret:	[out] return value
- * @ret_origin	[out] origin of the return value
- * @num_params	[in] number of parameters following this struct
+ * @ret_origin:	[out] origin of the return value
+ * @num_params:	[in] number of parameters following this struct
+ * @params:	array of ioctl parameters
  */
 struct tee_ioctl_invoke_arg {
 	__u32 func;
@@ -338,7 +339,8 @@ struct tee_ioctl_close_session_arg {
 /**
  * struct tee_iocl_supp_recv_arg - Receive a request for a supplicant function
  * @func:	[in] supplicant function
- * @num_params	[in/out] number of parameters following this struct
+ * @num_params:	[in/out] number of &struct tee_ioctl_param entries in @params
+ * @params:	array of ioctl parameters
  *
  * @num_params is the number of params that tee-supplicant has room to
  * receive when input, @num_params is the number of actual params
@@ -363,7 +365,8 @@ struct tee_iocl_supp_recv_arg {
 /**
  * struct tee_iocl_supp_send_arg - Send a response to a received request
  * @ret:	[out] return value
- * @num_params	[in] number of parameters following this struct
+ * @num_params:	[in] number of &struct tee_ioctl_param entries in @params
+ * @params:	array of ioctl parameters
  */
 struct tee_iocl_supp_send_arg {
 	__u32 ret;
@@ -454,11 +457,13 @@ struct tee_ioctl_shm_register_fd_data {
  */
 
 /**
- * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted Application
+ * struct tee_ioctl_object_invoke_arg - Invokes an object in a
+ *   Trusted Application
  * @id:		[in] Object id
  * @op:		[in] Object operation, specific to the object
  * @ret:	[out] return value
  * @num_params:	[in] number of parameters following this struct
+ * @params:	array of ioctl parameters
  */
 struct tee_ioctl_object_invoke_arg {
 	__u64 id;
