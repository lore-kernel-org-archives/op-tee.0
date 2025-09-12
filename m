Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB54CAC582
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:10:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8E8AA4FE1F
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757650255;
	bh=/X/slCEZNUYsN1/1Kb6qKCBb1SuAXT+Ssp2opHduLeg=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=HYYvzmKFfhskozNTqqQVStKrpzdPuAojLOLpDj+SPxpMzkpRAEAeYNthElo1SdzYM
	 9d/J9GLY2fCJRORoerKViey6hDiwBMApoIkXSD83tLo4lgtvOf2eDeXle6Z4x8io+v
	 AsLvtTzd0Le6pHvTBXA1fsBggEFzWONsIm5/CW8+PV95JnYrZzhQDPJAUq/s9/EShk
	 5Z66EB47venyRQQZuc8E1+RnBnQ4l84tJiRx4DLQjAksIWyR5IA7J8dI1RLDE0SnF2
	 2blSO5NDw5sidWgUEdeT2GUuu1MJUT0KIEhKQpT0tCN2dHIdSuRbNk6hOqH9yCCuL6
	 gGC3KNrxTOlNQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 431644FC29
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FYuVIyN9;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BMrT9x002279
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lfnro9xo+EarbMqRFrPWzRQwLLoVHW/MmAqB1i9xt2Q=; b=FYuVIyN9LxO0HPVr
	FF/PVjLSBPx/xLkNVpjnuaPe07t9YWPJlgurg3dhB/PWDSvUeHrRQ08tGgvFheEc
	2Mw8M59tmY5Wrt22BQz145yyzvonXtZ9IThrV1Wp84MyPx+Hhks35GUj18p5hKE6
	ESDW3XASUzOw+c3R+YISHxne4afM/O/BFZxh5lPfroGBysqkBDWH0bxObBcqxjXb
	TCPH+M0OCblPNgRL0cQjdPfghhZLbHGGRQIyQ8rWTU0DSx+jTYbSlPivL3YAcFP9
	r5vbTqRkOFahLlU9Aas53rdCq3U/b/49nBJ2yspMqsSEwtYbVfbHnxP/jkwI0WJX
	vZzmOw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493ydv2ayp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-25c1dba8d26so20500765ad.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 21:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650073; x=1758254873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfnro9xo+EarbMqRFrPWzRQwLLoVHW/MmAqB1i9xt2Q=;
        b=P9jyZFDmCf2jo8yk1xRoI+4WVH/PRxMOir6ieKSq3lBh5gU4HXJt+qi8D5Cb5GSeDg
         qsoiEoGfHbx9zghuuVy7fCFvQ2AddmB9kBQiuXzmVqQCOEn6H9xL0fsJdyZkoZkcFm1D
         OoB7m2VJUEPMyYCErLaxZZ7lZQLLtbxC7/9bahAeoNgyxZWQAvJMOVvAVFNXiJHmdbqc
         81h3IhEblu33jNXSQI5qk0hZEBPoZmfLengdbltQxRlpBK5/qP2HGCGs07RdKCo1dNKo
         JGEZKMeZUNoW9/Qa6cnnl7cP8+siwIiDHUfMepo12kg+PHdp8GTMLvurBSeVThYCr0Ia
         XXdA==
X-Forwarded-Encrypted: i=1; AJvYcCUj9glUXtFbBRf6LsIGGfDyYAzlWjvPwY7inpPKaWOCse5uY8m0xp/V9bbG7VfsMnp3O3cmzlc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwbkshL3By1ATMMUf7UdK7dkYgWC8eD7GfQR2RB2Pdnm4YZ462A
	qLBIdu1hKXcFFH+wZUybM5DB0DUcHqnnKoGXEVQpM79Lkx47rxrOgIhNVZI6dCeCaNwKoKXX146
	59nzWtaoVAmTFuCcQ7spWY7sJebTJrPzcuCpVbGiEfsv9gnVBS5wrQSnOLiiXB8edNlOKewk=
X-Gm-Gg: ASbGnctutbxHNnUy5wX3mFnnpRh3c8m94FPqj2GeEI6UUY2zo/TCxnI8ObuFUv3yI1F
	vDpDtGS5/c5uaSCDifUJpAI6FmeYl1rXNCoOl1X2lc0nfgL8gCBpvaQ+BN/HmopKlThn+tZAvJD
	JVEo5pHQ0l1IhhcrzYP9ny/GkuLKRsKvDZe/8biUiEc/vlvpSePMtWJ4jUQtj5/77zLvK0zbGfM
	OpeLgwiTQ3u7knRCNcU2EM0BWn2rj2DesM4TOl7Tc+L9qA91QZTq+RJOuuIymkmPdb5n3VUaCdo
	tfxANyvOoHkuBxYqaFVspiw0OQfxNYCMSDdzhqViRswvK/ANtjiUkx7aIrGzGWptaLPDEuhztNa
	W8fWbImvSWHxbD4uxCJQsXU4=
X-Received: by 2002:a17:902:c40e:b0:24c:6125:390a with SMTP id d9443c01a7336-25d24cabfd1mr17981745ad.10.1757650073165;
        Thu, 11 Sep 2025 21:07:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl/+2oD/khgoZCP95v8DA4L2JWQuWzLUvjXrGV4KLAA76uANju1HQAGD2sJ7tUbjdjPVS3fA==
X-Received: by 2002:a17:902:c40e:b0:24c:6125:390a with SMTP id d9443c01a7336-25d24cabfd1mr17981335ad.10.1757650072600;
        Thu, 11 Sep 2025 21:07:52 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:51 -0700 (PDT)
Date: Thu, 11 Sep 2025 21:07:43 -0700
Subject: [PATCH v12 04/11] tee: add close_context to TEE driver operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-4-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDEyMCBTYWx0ZWRfX2zVs8DpMhfe0
 ggoW1e+K/YgPa02Tu1uSUZzlo0Jc4j57SRI7kE4zvfgw2jtp3Vn17Mh8Ym7OFfrszG9Y9q1mJgE
 omyxZFVdSMwE5QGVIBflrH1FFTbtt729pO1h6kNAwdqPdEBuB1eaRXVaKlXzEu7hxhF0mFjgy7s
 8aEf2DTlAZ5sbPQ6Crsdl8CbzBdSkhTlwmb+mbXkoWXFtSot16qT3kty+NKUDuijfRdKanEPo/K
 7d54WZsBAFrLXaw/UCQFEQn2LLr7NkAWLU4kH5SfT5/R5a3OzozyTsSqVNqAZWP/lXMqO027W8r
 w1EtVMfPa0fjyVFHplwfb3NUoQ2sF/ez93icsB8NNKyrkW839RGWkYmTY535EF9rARvyjj0mtjd
 Llt5pM8/
X-Proofpoint-GUID: QjESA9A8wACU6giZ25f97HmpJw7-GSDv
X-Proofpoint-ORIG-GUID: QjESA9A8wACU6giZ25f97HmpJw7-GSDv
X-Authority-Analysis: v=2.4 cv=LoaSymdc c=1 sm=1 tr=0 ts=68c39c9a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509110120
X-Rspamd-Queue-Id: 431644FC29
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 5AJEO7GAQLBC6DXRWX43UNMLH4MTSO3U
X-Message-ID-Hash: 5AJEO7GAQLBC6DXRWX43UNMLH4MTSO3U
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5AJEO7GAQLBC6DXRWX43UNMLH4MTSO3U/>
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

