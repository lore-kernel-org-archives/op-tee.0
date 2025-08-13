Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0173CCA0EDC
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:38:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 497584FCD3
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755045509;
	bh=MFrqGNTPT4AoV3VaCoEubJQ7khypQPxY9UTqtUk9UBw=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Fz+LMU6OPqZSTuT/1eKluHsxWaGDmX7VpHpvf7cYw4kfv75szR+ivGLxRA3yHj9r6
	 VPuxwFeuvdlse194n/OcCyuN5vPDp5djAN3p1pCLFl9tGsKaQ9EsaiC4GYb9aUApPG
	 6KoryLXr8uDvwYnz7Vm0Ffc/sILB20wVWVyryhP1I/L0LxhF46XH0YbyxrgTMPnN3j
	 6IeLXm8s2vjcPw31Z2zmKfZ1Gs8lOJDDQTH1CRA6Q5VbCdunoh1WssanaJUsb35MsT
	 P2i0rk9gauOf4t6BT+kH7wk15cPMgmrTP3LfguRFWK7XK/QmuUoqJmTAoZ1yG1tuwL
	 KojJJup9vLpSw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4FEF9430F3
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OaEN4QjC;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNt42h028949
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SZkIak/CnogNIohVjfrGy7vKdxiGWC4sl5fGDKdZ1SU=; b=OaEN4QjCehCWwHsM
	hK3AMmhwuWjG9rB+I/eMzSo75T/wzOmzky81Bc1I3BuuE/B6eeo/EenIXS+gvU83
	5m0Hs0Jtwpo9qmURHPk4878Bhy7tvuUnfckf9xRYHLn62ifKOUruAaukiF43l6js
	1wo4EWRoKcxm5gsNhpm3o+MQmf+2aHDV+MBmYKjXa1g2rFu3Rmbg7s9VMFDS8Kjq
	XGXr9zxWP6FNUqLxn5u5Ngky4UwkutxAk2aMfjGJ6arUi4WJlERSqk6EH3r5ND1m
	pN7FOcqd+rbWBaNtTz7VvfZQPbmu62Yr5RqhUF9mjNQ6ITLRKx/d74+m9fRpqruG
	0T2mIg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hm9tkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-242a1390e9eso123125405ad.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 12 Aug 2025 17:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045422; x=1755650222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZkIak/CnogNIohVjfrGy7vKdxiGWC4sl5fGDKdZ1SU=;
        b=n9yInBybrSxUUaoFYYEgW7iYtnVYFkUUEuYeoNKwJf5ZXJKo9oqrbYGL+ZitR8N7Jy
         glsQwix4aKT/m5jREx6yMu3EXdiqPDfEpVzx0YDiuQ0YeiLXdvAwRGDG5RbLFU1A8YYi
         928tsa9BO2KXSE31vopKkv6rO7tqiJJmsZ8nr/eZsaeynkU0Sb+G9O/EObn6RnQ7qRSS
         a4Efs+0UNuwmdZQkhaK4Vm1A1YB6CgVXBSDYASTNM2V/xpd+NNF9yWf62q/rZHPB633H
         7XG02b524GJrGW/MdFdUzmBlj2qY3FXM950Ktyk3V8UIMabHU+bIbpG0h8GRnkodw3WB
         8ZEg==
X-Forwarded-Encrypted: i=1; AJvYcCWbah7WfuvdPMI4nEVFN+qKoB1lfZ9t7XxjJ8D1RtqpqGizXIVbYAr8ICzW6Bn5NhIghsWlIj8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwAKNbtWpONN0sAeTIrEjEt063tkUOx+js1wZj85v0LsBV/l547
	DSCiHpSN7uTOxjNJkRpbNCPlltOWy7Q1fj+1mS1HCo8K7rVsvtH2E6eY+MJVxgretU0Rns99RwH
	J3wWPnx8468sFL/NSxWC7qlS3v8n5hAxqN0DBOENo9BUbfn+cLleoC/7Q2cqBaPCjQgKt8E4=
X-Gm-Gg: ASbGnctsqdCGNlGlYdkh1hZIrQpIzRe0j5+vk2cLJJCnAb4EYZ5FKKfuNFF9kAyXSJV
	ZM5dQNi09tUP94SeNxDU9lOe2hPUdZgv6IZITLOsp7cs5azSG6ubvEH7/e+/uP1VmgzBdIqCO7Q
	tnC1Tnu5o3O391DvpfSlwkJE5x9uP2h3Tn4qUgtABryz773O3Uy4ahakkQ2RjyAuD5vWFvI34pg
	Nc6zc49e9GTJdJdDDm1OU1snK+fcQJwmcoRYsm44q67pfPWdmkm3ztHM3eeIezQ4fNhYqAoyLLO
	5ra2K5dYA11Ets5sw9lGxBeijrQ2iFpmTC+IdUJvQr1n25pCw4BlaSYlRv04AjPde/Bj77D21Mz
	vXGK7Zv6CqfyqX7TCnlk0MdI=
X-Received: by 2002:a17:903:3c2c:b0:243:597:a2f0 with SMTP id d9443c01a7336-2430d108278mr16375825ad.23.1755045422394;
        Tue, 12 Aug 2025 17:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVTMGkjD367YhdbNapUwz7Z2X26qEDvXBYUGX4tepkb2C88xT8Wd/R5MHkhv4Ew7ZpY4TkfQ==
X-Received: by 2002:a17:903:3c2c:b0:243:597:a2f0 with SMTP id d9443c01a7336-2430d108278mr16375545ad.23.1755045421827;
        Tue, 12 Aug 2025 17:37:01 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:01 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:35:31 -0700
Subject: [PATCH v7 02/11] tee: add close_context to TEE driver operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-2-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfXzocLYEd9XY2a
 J3bZUOQaEl3HIC30WLuzODe/onM2LhGThCLlugm1mHpeeY6hSRX+Y02gpTz0v5QISkacxcnNZBN
 GbtvwKjmACGGYB4Qr/+MkL+t8H+qmu8tvRoRPOeC4Rx588ELLWG0YJaY+KdM+pfSV1h5L26jQEK
 qJhzD4QMuNDb6sW6GAi0rOyjW47VDo7GN3GyEb1ng8utldVYovPFvNrhQ9aayr94SI83DA5V0h9
 FncXrDyquaHZ3+FZ7BouYsLV8WgLSaDYO4Z8IgjAmngPrz5m7fXlL4SQ1z0V93Lv9eaAqrMQWEU
 fJZqffD0qi/Ph/wwzhooypPrk6YmlmdOlRYMFZY4gIpLR10dY4+t2o90x8VEbYQNrxX6c+wY6DH
 oD7U2Qc6
X-Proofpoint-GUID: wHw-EgN7J_HDWxw-QEyZqC1hcM_ctcTV
X-Proofpoint-ORIG-GUID: wHw-EgN7J_HDWxw-QEyZqC1hcM_ctcTV
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689bde2f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119
X-Rspamd-Queue-Id: 4FEF9430F3
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.199:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: BWIVNUAJKSINEMWYRYMHP5KW4RFPFAQ6
X-Message-ID-Hash: BWIVNUAJKSINEMWYRYMHP5KW4RFPFAQ6
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BWIVNUAJKSINEMWYRYMHP5KW4RFPFAQ6/>
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
index e47a68d337b4..a2b365bcee51 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -80,6 +80,7 @@ void teedev_ctx_get(struct tee_context *ctx)
 
 	kref_get(&ctx->refcount);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_get);
 
 static void teedev_ctx_release(struct kref *ref)
 {
@@ -97,11 +98,15 @@ void teedev_ctx_put(struct tee_context *ctx)
 
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
@@ -1038,6 +1043,7 @@ void tee_device_put(struct tee_device *teedev)
 	}
 	mutex_unlock(&teedev->mutex);
 }
+EXPORT_SYMBOL_GPL(tee_device_put);
 
 bool tee_device_get(struct tee_device *teedev)
 {
@@ -1050,6 +1056,7 @@ bool tee_device_get(struct tee_device *teedev)
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

