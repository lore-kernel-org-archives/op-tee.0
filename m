Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A44C54F30
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 06:58:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 41E9642FC8
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 06:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748329133;
	bh=cT4xLgSWOqfNuREgIqfSkNTrYlsBLiswRyt83c71RTs=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ILP9RvhPuXa0pf/FocLnjbPuOfJzBtEHnDKB6rcUVZ2zIygkKGcoSuXdBsXZT2TMg
	 dREWf//s3xPFRNNMgNOtkWIVyTjJUAla+fs4QXw97d6Pab3sKdqylLDwNc8z1puTqM
	 AC0rHO8TbKHkopZ9kyJyeUD07WDxRBKLpSEXshF4aB3qicF7OSwbZiin9SP/S2FLc0
	 qWnIHJhzpJgO+kHyawSVUhGODGMlodIGViEtYRW9nQGXqUpdEEyjO+luBl8wEUDPjr
	 QEjsxD85geXoeepVTSIGi3Mq5O2PsWuAFQ4MaHOYs+dCxPO3nG1smzDHcllRHgL+38
	 6B1HvOhIlkezQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AA86442F1A
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WzA0Q4Mf;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QLhsQi008758
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ygugRm4SsXMkb/d+FivUiOwn/n8fxWFcMiA6Lz8ODvY=; b=WzA0Q4MfOh83M+fD
	7oRXp45i0ixKCECLgsV34qTA/i9+n7Hzb5XL4oCQj6roNNE9jK7PswgsAxTwaUge
	OWXqZk28jxjeLFnkco7pAGfZoe4Y/3BUmx6IM+CkyK6HkPuDWM4fmttF9iQUb9hy
	Nqoywfe/j5+UM7C/ubbpT7aXTgIoBSn6kZcXwqCLhKSA5B/8lgJXFEW6j4acAyVJ
	cfCnL+PsRT5YEik6jArF0YPdQ0AkgSeLmIQBDNtFKGV/DvqsAEwKfd/J604uDU8e
	N+N2miyVyBg5r5n6eM0hmEEhZQft0tm3pPakovMwYruFRByuPTe421CiO4nVmHe+
	MRmu8A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g8wwxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2c0cbf9fddso1829693a12.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 23:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329039; x=1748933839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygugRm4SsXMkb/d+FivUiOwn/n8fxWFcMiA6Lz8ODvY=;
        b=bJTS1oedcgUmSNveZZngqiy3qMZhEH+kIQsP5YInaiZTZ/sTvdnJGM4v/4q9jxXQ9T
         ktM+VlqCv6oOjPZKVyHuQJlw4ib4ZyRmt19DRVSinWmpMjlGwzaWUkUpLQH0zbE8sb6K
         uYNGqJAITWn0p1XI9R2ZAx3n4Qm2qFDl3lEs2e/KfaOWsiW3Bkvr+/BONysijixe9LHY
         YLxOewj00vXv1EuVQJYU5cJJ7WInhbbDuKcpj/kzJeHzzE65Ga0a+LNsHJmJ/cIBc3GU
         hvGFb+3LZ6AVNeN7q4TYPX3Ra5INkLrRi0w11fc5tB0atf+iBBKzmFXKqEB5UTHGESFS
         cu5g==
X-Forwarded-Encrypted: i=1; AJvYcCU0/i1oMxiUgTDcWQTrAtlWc60JoRrK2pSbDrowucIEu/qKlbDNqdECOzF1tmaFd1zs/EFIeuA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxKwPEj+XLbGKFZOTuWM1i9JksIlZ3AvaR6nmRaVXVuYVPdP1Ed
	kETZm92F4wLQ4wwSpDNkHavtLvKXDUggmPWo6K2BSELA1Pg3FP86oZ4lFxiosj7OJaxLl5WU1p5
	9+vpG7tc7N/B6GdYq6ZKug8n0t3U25OYWUtBEZOfbm9KUxrqfutWZ/Xc728uUXU2Y5+1qBKg=
X-Gm-Gg: ASbGncua5PDVXMNIro7W2Fpy2UfqyE1P+/HrFkR21uwX6foyXIvXyGcsri5MvgouwaE
	yyQGqv13xQic7sDGGzbMJiS/YKEgintSmkE8p3H2ZkY+5G/RGxhR5RnOmjWbUDz0SLqqujGwW/6
	L7M1QRECCsouu0/UlmCzaJ/8R1INJ4Fn6H9XFTXxuZy5M9QGtyZ7AgTJd0fBgVpecIgFtrChgVH
	gbwTmHOgYj2hMSE/59/14jbjp764op0z0R3yYQPFcXR0s5B/R0uD35vib+j1rdgWc1fvAxgxQCy
	FTZvCnwu9IK7h2cnbXWvaPbdGUyZUMViT5HIvzk12UOVRNEyN/2ksYQEc0B5Q4V6OSeTiC4=
X-Received: by 2002:a05:6a20:9d90:b0:215:db66:2a32 with SMTP id adf61e73a8af0-2188c34144cmr16951454637.33.1748329038789;
        Mon, 26 May 2025 23:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXEN+b4LBU0sjDfJGjW0s5KtMVUe6w1X1BROAUzJDl+VzOFSY+j3GfW20682wQFapRYyItgQ==
X-Received: by 2002:a05:6a20:9d90:b0:215:db66:2a32 with SMTP id adf61e73a8af0-2188c34144cmr16951418637.33.1748329038363;
        Mon, 26 May 2025 23:57:18 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:17 -0700 (PDT)
Date: Mon, 26 May 2025 23:56:47 -0700
Subject: [PATCH v5 02/12] tee: add close_context to TEE driver operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-2-024e3221b0b9@oss.qualcomm.com>
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
In-Reply-To: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=68356250 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: IJh1EO35CebamHL1sp2b5slH2Dtjcq35
X-Proofpoint-GUID: IJh1EO35CebamHL1sp2b5slH2Dtjcq35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NCBTYWx0ZWRfX348ldnTcZMQU
 5/n/toB4P+qKJZ2uOwXHci6CMPZn6AtxnnsMEa1fPlnrKh46PPOvrKibGrQnLG4dfDYUqgamVkI
 7ZvIKRYz5ZBmO+o6xmMzEPIjVJVHkKV9hY8PMIO/9LeXbKf24N9V/UIe9Il25tsBMKbARQRrCER
 JHN1FZwlWY4ahG+c+0cBAzatFb91gZSxJGucMQfdXUGJ0uHhN29wFgMnEmN0KeLLTeLisuk7Q1S
 HH2pbkNZI1gIk1Qmo9ULtFU5GPBUxdUqk2apCG4ZG8Uddphca5iy0hKdxI9xw2xxC/81kqgNBeL
 9ON/hRZoy073KGQHsCM15NWOPs9O9hQOJDJVeA+K3dGrEVEVQiHRpxuJZpewNmEpOba/mJdpJtb
 milT2qvMarFncV1u0r3qvUYSiu1ITl2mBIUnasBVYaahgKlRkqpW8Kv+/MamrK71vSFCl6RK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270054
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.200:received];
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
X-Rspamd-Queue-Id: AA86442F1A
Message-ID-Hash: AAI7ABQRPFHOFSO4I7WGKFIALQPQQJ3N
X-Message-ID-Hash: AAI7ABQRPFHOFSO4I7WGKFIALQPQQJ3N
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AAI7ABQRPFHOFSO4I7WGKFIALQPQQJ3N/>
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
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c    |  7 +++++++
 drivers/tee/tee_private.h |  6 ------
 include/linux/tee_core.h  | 50 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 133447f25065..b9ea5a85278c 100644
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

