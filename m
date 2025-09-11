Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477EDCAC58D
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 03:44:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 931B84FDD9
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 03:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757562273;
	bh=/X/slCEZNUYsN1/1Kb6qKCBb1SuAXT+Ssp2opHduLeg=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rvr32Mfe+co7pYw+CUymZ8Y3zUdrIh78ozZz6hf5vFPX5NWzHuWqz6lhBNw1mB1rm
	 hFDAQ2oiuIg3fY63yE5p2S90uhpuP+ijl6goiS3rfwM5J7Nl2i9vhMZNy8WhNslyk3
	 VhN4+gsEIZAsDQ40VnmzM+iTLWJhypnhUykLpveHpNYLERQHUXTi2j1hv2mAF+AAOy
	 26Rr5LqAPHbwJDKdh3Qg3ZThUQMARrvANBLJZF8lypYbVa9Vp0b8RoOoSq6W8YrRjp
	 2wibHP7RJMUZxB3z0z1tkAhgFDvqPYJ60ArLLUdI+wAu4eirywDgEVXTi8pK8dvnpB
	 8XrDCy/OUWWiA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E18464FB66
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:41:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GeVnbJLw;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2Ikhx002496
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lfnro9xo+EarbMqRFrPWzRQwLLoVHW/MmAqB1i9xt2Q=; b=GeVnbJLw5Qb6NLSF
	K+I9V5+6UJzRozu1AVPFBHRNBqFo/xlaP1Tun07LFpSzEWQZd+6eTTDHr5cvOZds
	OcoGnhLN4RRqeI//u/tzlMGRrFuCT/ZAd1PTTCPJJX37+sv2kQEjBzk7FlZxMrik
	CUNe/UHqQdJu8MWGN6vAQIiEtJI+v2zbsAdxQDunPPvnbdbkg0YXcHxWsX54gb4R
	HupxtCml0LK7/uaI/QqLMd4kzlFcUL9dKBV+qSwdSNswl3otScZYV1VrhBNnpISv
	gnBnjERXypPPCL7T6HaWIJ5eHjoM7g5Bx35bpGBN0nCqBtAyAfSJ8Ui0x7t9L+As
	9uoJ8g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8p5gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:41:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24e04a4f706so2871975ad.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 20:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562091; x=1758166891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfnro9xo+EarbMqRFrPWzRQwLLoVHW/MmAqB1i9xt2Q=;
        b=hFuY8C+ZfFqfsAmpDyPqNV7ulgMWWz9yrwP5fox05CZMu9xHd6Qke/PQsUdKtJDJki
         k8bPil1S+r91IxXZlmHpi731mMPIlbR2mHqJuPIs3lb8ll4p/PdY6gF7ZTamrU5Qooo/
         2UcIjxCaohUSwLSaQuKpZf4gJtt8xpvY7b/8HW2fwnSp7puyJr6KINitLhHHwQe6spyf
         XTljYJ/+gyYgjy+G+AkPYq/WjLf+QKiz/YjwTdfoUQ2L4D3Fdo1FLI+ro+vr4FD8Xw69
         c0RWx3TuPdssQZoOscWn+nEMis/a5MTS733G6N2cgGf+e8oOpiuZdlZr/pA3D+ahVt26
         UB+g==
X-Forwarded-Encrypted: i=1; AJvYcCUdTI5/+mQd5B3lLhOPaMtwLvsj2DkzscOFHn9J+LeU2SLFMUW4of3sH5/WuNwYQAR4gdgW8Yo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzPuargwxpnbHjAyGTHZd6ifDtw9s76vfVIbTxEVusCJYIqX99a
	P+LfsXDW3KCFbIKY7IEzi8CDeebcvJSXMEUAsTyQ+S7stJfeZJIdlInNKIBsrs4Kvhc/5F9F9ww
	z60AOrRvctNmaZuC26ranmcnmPX9RddAEsvQ5MwWmsmGXGFZSwjaYgEPsY1IY4McUF33nmVM=
X-Gm-Gg: ASbGncvo/sKXmcudhkJVTkDM7BRwebUuolrdVHAFpbx4900u0dOKYtKemuyUFMrtcnH
	cXgd/iyRVcxCeMVaf6InPPEvOOwqGcnN9QMl1zd1CC0YrsNHvfk2bhKtns4XOf4NjAS5K3SN0pe
	otQ1JNDTLw0Uoo70KQEBTs31UBV4zz5wyMHCejU3R6KGSCy705CVBpNaBqES/KfRK5djdFD7Ep6
	B/Nhk/IJcJSsvsBpGqXJT0+75azKI8wV7wVhpNUpxaBz+k/r0sRB2mYwmvABukhDJmVYWKc/omH
	Ffn/3/Uv8bvsElMcFX8SkR7npJIlx5wCV/t5xUT3fmIzPx16SVDFatTnYRRjSF/wJ1fQNe269KE
	7RvrE4vGs/AVeJEal/TQBjPc=
X-Received: by 2002:a17:902:f681:b0:250:74b2:a840 with SMTP id d9443c01a7336-25172483a34mr238752965ad.44.1757562090725;
        Wed, 10 Sep 2025 20:41:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2b0ipDRDvZkbzduHPtXWYapgLH3UaQWL1xsBCUzaccisMS56SSp8yl7NyLyuUuiRKSMRPXg==
X-Received: by 2002:a17:902:f681:b0:250:74b2:a840 with SMTP id d9443c01a7336-25172483a34mr238752765ad.44.1757562090085;
        Wed, 10 Sep 2025 20:41:30 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:29 -0700 (PDT)
Date: Wed, 10 Sep 2025 20:41:17 -0700
Subject: [PATCH v11 04/11] tee: add close_context to TEE driver operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-4-520e867b3d74@oss.qualcomm.com>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX27HnelR1MfVL
 qdZLQieUNP74TnxLlPBTpY0JV618qQtUck1y+wkN+Y1vqQ7yYDIZP6k2X1ew35jwQHjKQ02GSma
 HcNA8j87cuHexBsqG7wV3mFsuJtfldpaDBVZOdvYxQ0s5A3TYHgFr6Yi+IiJBUhcwjMlDmv+Cey
 P/tvFNXihG1Labwi/UjhO1zxgwZoB5ikNE2TmCYhDJHf1ejwtJ30f3ykiDLF8eY5TZKAJt7yupr
 cblwnIvLvaJQOO3/S3884LMb2kQmxFEDhF5yhPctG66brtTPRyuNMGcCo5EtQa9tVi6zn9ftpbC
 sVMUslbuVsFkCKrxG94NsS/6P71uOX8U4U9/e/JV1vCpLMxqQcQXfMul95SzqBBwbUDRqHkgYT7
 FIONUI++
X-Proofpoint-ORIG-GUID: kySbEdBCCiKkcf0dfTQf_zc1lugmCKSj
X-Proofpoint-GUID: kySbEdBCCiKkcf0dfTQf_zc1lugmCKSj
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c244ec cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031
X-Rspamd-Queue-Id: E18464FB66
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: MVASTNUB2ZVNJL5SEL6LN2B2MCFJO45O
X-Message-ID-Hash: MVASTNUB2ZVNJL5SEL6LN2B2MCFJO45O
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MVASTNUB2ZVNJL5SEL6LN2B2MCFJO45O/>
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
index 9fa042d80622..f8534a00c56c 100644
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
@@ -1075,6 +1080,7 @@ void tee_device_put(struct tee_device *teedev)
 	}
 	mutex_unlock(&teedev->mutex);
 }
+EXPORT_SYMBOL_GPL(tee_device_put);
 
 bool tee_device_get(struct tee_device *teedev)
 {
@@ -1087,6 +1093,7 @@ bool tee_device_get(struct tee_device *teedev)
 	mutex_unlock(&teedev->mutex);
 	return true;
 }
+EXPORT_SYMBOL_GPL(tee_device_get);
 
 /**
  * tee_device_unregister() - Removes a TEE device
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index a9b5e4a6a8f7..6bde688bfcb1 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -23,12 +23,6 @@ struct tee_shm_dmabuf_ref {
 
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
index 7b0c1da2ca6c..456a940d4710 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -76,8 +76,9 @@ struct tee_device {
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
@@ -87,11 +88,17 @@ struct tee_device {
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
@@ -200,6 +207,24 @@ int tee_device_register_dma_heap(struct tee_device *teedev,
 				 struct tee_protmem_pool *pool);
 void tee_device_put_all_dma_heaps(struct tee_device *teedev);
 
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
@@ -374,4 +399,25 @@ struct tee_context *teedev_open(struct tee_device *teedev);
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

