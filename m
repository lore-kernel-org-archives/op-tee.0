Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D822CA0FED
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 00:14:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 83E924FDB5
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 00:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757463247;
	bh=8TSbhEgUPN9kdxwy9KCMFyUVP58G/S0fhvuvLlT55sU=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=RwVyZw5HP6W4fIxS0RVj9TPdsKBBhRP4iyW/lJSmyEvHeNBB+xD5YpyTfRRnET6Qo
	 NI5eBovoZSnZbk9mu2dJc4i+j9LUxOWHyWHTqo50RpizouTKsTW/fmoS2T5+rbWYmh
	 AAwHIrXvGxxTf5s5WhU9CACKXwlmiDyiPJ8dhS+eBw1sqiX/vBWPK3fCuRZN5+lIAt
	 wM0f+2HeBEVTvcRLgeVGHdQO88OBVcpJImzg3VS7EI3m6E701tWJMQbC9EYuxFRKrU
	 0SJqm8NyS1/SVzdHbBxhQN5vtX+QsFKD1RXuPf8CCpowvwhYmKAD/QCjZKc9i3WjD6
	 Ro64KwSC2KaNQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4AEE645A90
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dyBBvqZO;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589IKsN1020584
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kjXvseb+vxS0ErbDImEwiyaXgCwIyoxRM6Sfo6q8WkU=; b=dyBBvqZOdh5SxqjV
	jdbIKh8nc2E3KsLOv182eqV1uZYQ4phHBm2lD8iW85CbQyvPUzFYvLlHuLETaje6
	PnzTR2Lu3m8eCMD3vLttCaZYTtxAg3BonTZzDCs9I4e0YOx76HHFzboUDI2wdeDW
	rwUfaxDa74+S+6UoXdfeQnCtfYk5q7ffsuhT0Uv/AaDtXiH4s02nONnSxgz3zco8
	DnTyF2J3lwMxfVD4XJluEwvmnmiD0bfZddLQmWn3a8CajVqGaW+M/35HuB85QPef
	4xKIgH6W2Ibt6rhgPo7CcoWjaRHlcN9IvHc4iMtCiVn0BB4X9wW2mY8TbKg0xLOW
	qvsNfg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a9x54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b521ae330b0so3152516a12.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 09 Sep 2025 17:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463083; x=1758067883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjXvseb+vxS0ErbDImEwiyaXgCwIyoxRM6Sfo6q8WkU=;
        b=vCPiHFxGh2wM56q1aQCUa5S0Xv+7JrKrCLK1JvBpUr4Wz8eczpz8CcLIfzvc5Slwv0
         ruYxfoQ1v0SjQNkN1KvYei8i27qsPPztJNM6bfhYYKHKIZk76iSRYNLclJOPxhO/I5Ef
         6je6kDGro3fTJ2gFhOTJPE5LNniZoTLd1q6zc5nUNknm/PcG++cm4r3NU42N43vjSJZg
         sxDbYTPpYVs5pa8cNVFwQ7dcUrliuKusF2JWnlLh/ovNVsgjkqmLn6p9nYVO3EpKxDM5
         68lTVGWFXcDbcyR/AcDs2YSOFKLZY8ldvKrQHMwh4d4usDDPMIJhG3bSPVJUBoAyx6Wc
         UmnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJnTqOvjZvae3xsfwslitowvhh8soQoxdDoUZ9665EDmHmeUG1b+dIFP25AyhQwXCXcvXvhsU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzxc0HzQQX0XCp/1bTZxLBvYLeekbefzjA58ntsz10nJTCoL/AN
	Hxi0NAEIu1KxQAiNSz55cFAYSzNckXvPyrR56GwZJE9ncKPMc7klXJdvE1NSF2VPjl/9FA097WB
	jK6q2qkz1fpVvMkDTxIaRSeNUOYyUnMZQLUerF7qwBxlqRME4sy3/h0446yLMk5+Px63pRUE=
X-Gm-Gg: ASbGncseaOFPQpJI9BKfOPju8Z12lHi+cJSlEE9oqZlct3OrUeQVFXzMv64yY2RHKtJ
	HFnDkgSW4MPtYXgYczVf42BituJGvlgrn0MJfZ37SG/YjrCGI+JX1A7p+MOwI31uBe+lss9fO8S
	MyMZfqfKagKsjrdsl8yLvAYlvFJIXX+wmt6Frpi/ctRU3ocnBv5zQt5S0WzJauH2930gDEqBVcq
	0e5nFwOJttpXObcAndzYQfSSnVe97uC/y5F8ULL1TExcKG0PxRxCverNb4Xn0I2aJNh3eGICbgK
	iZwxqynmYO+k/kNXM+TmrAIvhwpRKqokl1ATPx0NQZNN/PLREWYLBtQZ90P3ZFz5pkpVKzmG4Yp
	ytfuMK6DAAj2rCzfK6J34foc=
X-Received: by 2002:a05:6a20:4320:b0:24c:cb06:f0db with SMTP id adf61e73a8af0-253430ae888mr19487911637.35.1757463083404;
        Tue, 09 Sep 2025 17:11:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6YXV/yo/etuXH1mofBir8R0+46jHu2hZYYNv2+fbMH7+eQOvuVrW4JcNtH6BTxe1fJ2MX+Q==
X-Received: by 2002:a05:6a20:4320:b0:24c:cb06:f0db with SMTP id adf61e73a8af0-253430ae888mr19487873637.35.1757463082883;
        Tue, 09 Sep 2025 17:11:22 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:22 -0700 (PDT)
Date: Tue, 09 Sep 2025 17:11:06 -0700
Subject: [PATCH v10 04/11] tee: add close_context to TEE driver operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-4-20b17855ef31@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c0c22c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DMOR6dBjZw__F4hUoeUeFqLLJRJiYv8d
X-Proofpoint-ORIG-GUID: DMOR6dBjZw__F4hUoeUeFqLLJRJiYv8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXzu66kOpW3oVW
 rlE7e28lEDtXOt3R4fggeyUWTn9hZdDZs3cVAi8JL32saunE5cloyyWSyW1rlK4wToWp4vDGdzd
 UH4CjhXQIEh6rWH3+4Goj0rGKgo0NlSybDK3wSxXt6Y7PyinQQP1ccbj38Zl2fwn2mE2x2c/YXu
 63jqioAm7uZmJ6Jn2ppz3H/EaN2OVxUH8R8A8Qu3L629yOduEREpATleNMKwd5JPL+jwr/HMV6B
 UaJN5kM0FpoI3GMXkBqN55WxZbGMVCFTay5wjEQqcsDp8WItEyG/n305xWtdwGPt0EswjykAiZE
 XtDo28ma36CFLXn0OyeBXeHnzn8sbOhsV3ogavdQbSPdfjrzVgRK9EULWLw1onJyF+cZ6G5w5iN
 +VfAeqrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039
X-Rspamd-Queue-Id: 4AEE645A90
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: MYSDSGYFY4O2Q43O6YW45DMENL4KTO4G
X-Message-ID-Hash: MYSDSGYFY4O2Q43O6YW45DMENL4KTO4G
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MYSDSGYFY4O2Q43O6YW45DMENL4KTO4G/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

The tee_context can be used to manage TEE user resources, including
those allocated by the driver for the TEE on behalf of the user.
The release() callback is invoked only when all resources, such as
tee_shm, are released and there are no references to the tee_context.

When a user closes the device file, the driver should notify the
TEE to release any resources it may hold and drop the context
references. To achieve this, a close_context() callback is
introduced to initiate resource release in the TEE driver when
the device file is closed.

Relocate teedev_ctx_get, teedev_ctx_put, tee_device_get, and
tee_device_get functions to tee_core.h to make them accessible
outside the TEE subsystem.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c    |  7 +++++++
 drivers/tee/tee_private.h |  6 ------
 include/linux/tee_core.h  | 50 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 33091aa21be0..0b4c65dc14cc 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -79,6 +79,7 @@ void teedev_ctx_get(struct tee_context *ctx)
 
 	kref_get(&ctx->refcount);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_get);
 
 static void teedev_ctx_release(struct kref *ref)
 {
@@ -96,11 +97,15 @@ void teedev_ctx_put(struct tee_context *ctx)
 
 	kref_put(&ctx->refcount, teedev_ctx_release);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_put);
 
 void teedev_close_context(struct tee_context *ctx)
 {
 	struct tee_device *teedev = ctx->teedev;
 
+	if (teedev->desc->ops->close_context)
+		teedev->desc->ops->close_context(ctx);
+
 	teedev_ctx_put(ctx);
 	tee_device_put(teedev);
 }
@@ -1001,6 +1006,7 @@ void tee_device_put(struct tee_device *teedev)
 	}
 	mutex_unlock(&teedev->mutex);
 }
+EXPORT_SYMBOL_GPL(tee_device_put);
 
 bool tee_device_get(struct tee_device *teedev)
 {
@@ -1013,6 +1019,7 @@ bool tee_device_get(struct tee_device *teedev)
 	mutex_unlock(&teedev->mutex);
 	return true;
 }
+EXPORT_SYMBOL_GPL(tee_device_get);
 
 /**
  * tee_device_unregister() - Removes a TEE device
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 9bc50605227c..d3f40a03de36 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -14,12 +14,6 @@
 
 int tee_shm_get_fd(struct tee_shm *shm);
 
-bool tee_device_get(struct tee_device *teedev);
-void tee_device_put(struct tee_device *teedev);
-
-void teedev_ctx_get(struct tee_context *ctx);
-void teedev_ctx_put(struct tee_context *ctx);
-
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length);
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index a38494d6b5f4..284ca6b3e03a 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -65,8 +65,9 @@ struct tee_device {
 /**
  * struct tee_driver_ops - driver operations vtable
  * @get_version:	returns version of driver
- * @open:		called when the device file is opened
- * @release:		release this open file
+ * @open:		called for a context when the device file is opened
+ * @close_context:	called when the device file is closed
+ * @release:		called to release the context
  * @open_session:	open a new session
  * @close_session:	close a session
  * @system_session:	declare session as a system session
@@ -76,11 +77,17 @@ struct tee_device {
  * @supp_send:		called for supplicant to send a response
  * @shm_register:	register shared memory buffer in TEE
  * @shm_unregister:	unregister shared memory buffer in TEE
+ *
+ * The context given to @open might last longer than the device file if it is
+ * tied to other resources in the TEE driver. @close_context is called when the
+ * client closes the device file, even if there are existing references to the
+ * context. The TEE driver can use @close_context to start cleaning up.
  */
 struct tee_driver_ops {
 	void (*get_version)(struct tee_device *teedev,
 			    struct tee_ioctl_version_data *vers);
 	int (*open)(struct tee_context *ctx);
+	void (*close_context)(struct tee_context *ctx);
 	void (*release)(struct tee_context *ctx);
 	int (*open_session)(struct tee_context *ctx,
 			    struct tee_ioctl_open_session_arg *arg,
@@ -154,6 +161,24 @@ int tee_device_register(struct tee_device *teedev);
  */
 void tee_device_unregister(struct tee_device *teedev);
 
+/**
+ * tee_device_get() - Increment the user count for a tee_device
+ * @teedev: Pointer to the tee_device
+ *
+ * If tee_device_unregister() has been called and the final user of @teedev
+ * has already released the device, this function will fail to prevent new users
+ * from accessing the device during the unregistration process.
+ *
+ * Returns: true if @teedev remains valid, otherwise false
+ */
+bool tee_device_get(struct tee_device *teedev);
+
+/**
+ * tee_device_put() - Decrease the user count for a tee_device
+ * @teedev: pointer to the tee_device
+ */
+void tee_device_put(struct tee_device *teedev);
+
 /**
  * tee_device_set_dev_groups() - Set device attribute groups
  * @teedev:	Device to register
@@ -315,4 +340,25 @@ struct tee_context *teedev_open(struct tee_device *teedev);
  */
 void teedev_close_context(struct tee_context *ctx);
 
+/**
+ * teedev_ctx_get() - Increment the reference count of a context
+ * @ctx: Pointer to the context
+ *
+ * This function increases the refcount of the context, which is tied to
+ * resources shared by the same tee_device. During the unregistration process,
+ * the context may remain valid even after tee_device_unregister() has returned.
+ *
+ * Users should ensure that the context's refcount is properly decreased before
+ * calling tee_device_put(), typically within the context's release() function.
+ * Alternatively, users can call tee_device_get() and teedev_ctx_get() together
+ * and release them simultaneously (see shm_alloc_helper()).
+ */
+void teedev_ctx_get(struct tee_context *ctx);
+
+/**
+ * teedev_ctx_put() - Decrease reference count on a context
+ * @ctx: pointer to the context
+ */
+void teedev_ctx_put(struct tee_context *ctx);
+
 #endif /*__TEE_CORE_H*/

-- 
2.34.1

