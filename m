Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA2BC83F1D
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:52:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4F52242FB2
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752454334;
	bh=/7EXQJB73/5gvIoUTG6KNRo3AVFSgdFix2K94IEW4HE=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BTgYwDKPqTPXWrcvXaz9N9Te9lxqhmvJvDPapQMDoKK4fLsKtdMiN/H0r0DvK1XZ2
	 kuAhM5PlclJJhIZPT8LXRp/WZfkdC5w5VATeLyrz/71eFVb1IUuD/K0l9cMRRvGITA
	 +H4D2z+/KkOa+ZohoUGSGVBXFUPNsqje8SSKn42ZnPviPoZLBck904MGNbuPfqi6/C
	 uCxaHtTiUxCxaQC7yOG3ZprisTQpuI+Y7h480cH4m/SzyY61zp9YkRqEfQ5X4qFT0j
	 aigMapISNA0Lnvh9uiX6WD+nV1u9IR9swAYFHTUF+pzL9H8oXXqU404LkP7b9KNJO+
	 hpUSTt8Mm5XDA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 49C6540ABC
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p09MScsi;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNUGv6019883
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QvkKKmGa22ueSGt3EngA9F+r5r19tnVaQ1z09ewqLKU=; b=p09MScsiKDK6DM53
	DAhUDQah5I2Tl5ACEoaNgdyS6NZ/0wIoRefyau03Qni+RzdH1KEER4tGq1nqa40x
	EbkkEk8Nwss6S7LhrSG8y5n4oN80pno/CHHeBJFBTT6FgthVy0nUvL6pZWU84vlO
	TllYBfcetWPomThXp/zDDvx3Mwv6du03PAaGpkL2USJhl5s9PNTye1lbwzLg4Ctc
	AuJro/wV5g4Ef+ugpqwnJuqrz2ARrzmpAdCMatd+IlnAXa2+BRfk8pJdc1KatU9x
	umOdGQ9sj7P7LcigSSYZXJDQ7gsJPHMJrx9e1ovA7w4dlFdRLqkFl7uxhMPFDXfY
	/Hryfg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47uh0aasjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23824a9bc29so52326115ad.3
        for <op-tee@lists.trustedfirmware.org>; Sun, 13 Jul 2025 17:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454221; x=1753059021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvkKKmGa22ueSGt3EngA9F+r5r19tnVaQ1z09ewqLKU=;
        b=SjFRJnBrKlursdd7e+8KEiJRDXEHHEbC513zBNH8VDbAmC8wbBMlVFO6Q2nUnh0J96
         V66r5/I0CfQ5F2Cb7vcBIo+hYK21L/WMdy36tAYwYcHUIRPvcySWG4lhj8obi9yo1SwX
         BzWzq/2PUodS6o1KJaCrkJb8iqCZzWL12qgJ+cn0GF+PiKC5wD1tdMzsDc7yANSF4wSj
         +R4P4y7BQxtrH09vOqT0na6qdDsDscZaOFEhMSkBFVRn/xvfdx7XhUPn/PpYVp//f5jk
         lSlShpctyOGwuZlWAJmuWIJ7NBMO+mRdbc0Xj+EYJzt80iGr9ngoZO1Q7Qu2d9rDjvAR
         My3w==
X-Forwarded-Encrypted: i=1; AJvYcCXGiiRc7ujlb1/szll21tv6LGcjWhyIGZMnQm+Gh70wvClOLm30QP1XHvHkNoDKDfRh3dKSeXI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwI7VWglt9uH1k4LffCiX4e/DOoA0gg4QfiA/H3cMlWo6MdVxo+
	YGEkxuX3ixrftey8Mi2jPOuL0GQ0pPx+wmaiJalnJmN7bgcanT1O/I7FvVh2Qb2wpKJImjunSzV
	cxBj0ubj0SLLUvgPLgdEVBiFNhqLirJt2A8L8bCjzEkpclkKgT4nNgqyeFlZo1mLVNAqW22I=
X-Gm-Gg: ASbGncsfDR4r5BF30kQvO5nON/HIwzIg6GyFWcHqejrddIfjL4EBUs04Hm0xqadcSLC
	YHCYU0o+XBLxWdF808tlgyYCgGADbN9dSf5wbKoN7s5QxVlL4KbSE0cBGgMj6r4A7DqLOwxRQPp
	2ydwQ2QJdQuyg3gArAfGncvcJua5ibtAqFs+pzJRTp4boUQCROr1jITDxroqpHMjdqemrJicnev
	d9iP0ggfjcTn+/zscL1evvC/BmidhKHC1ABmJZx5tT0KcgaGZFepinxDrOz5DEMmPFopCdQemkR
	sZtHb8fbPd+hRiQoi5yKRDB7amwYi97rYRWX9K+LeTzTerM06cHqrkkz2gaXR9I7ty56GkDSvVx
	yEaAj2hDiqDm5s1+kutiS+lo=
X-Received: by 2002:a17:902:cf0e:b0:235:f078:473e with SMTP id d9443c01a7336-23dee262fb5mr193358415ad.43.1752454221414;
        Sun, 13 Jul 2025 17:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5X0qUNlSCOYZOXc+6fFe7qW/RjprPxFG+s/k+fDKrAs5f5Q2JYKfn8YqH6S388QYdLFb30A==
X-Received: by 2002:a17:902:cf0e:b0:235:f078:473e with SMTP id d9443c01a7336-23dee262fb5mr193357925ad.43.1752454220976;
        Sun, 13 Jul 2025 17:50:20 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:20 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:49:14 -0700
Subject: [PATCH v6 02/12] tee: add close_context to TEE driver operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-2-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX8aKHraLv2SaF
 QfCsr7DocCNNpjgintXPX2m/0b1TttCJyjJ0NoaZNUTeknUD3HIcV2296b1xLCZG/jOKxthgMIq
 T9Fh0cFnUpg6H5RAi3hL5Olk7ssUqFSuya8DWZI/EIiYnjeKwwLOJoRo3XUAmU4BKDEIaoXzeff
 yW6FEaHXzFtIfN64YfFjarLh+jlVFAfxF9+pHvIKA7vHcsTRsGAB3fw963euQXaQ3an+0kDGZEX
 BmPMnekG6u0CMtwMD0V12SHy7ZyyGcvlo4gLOX5F75uNPWQnzWvlW2FaBUKeATA6QukPp4FZZmp
 364CGgPPSLe7Prs9TV9pkhn4GH7Q9d/iWfjHDcG4I9NBxEjQ/HLSY71Z5SxpVoTS5tEwRaHSl6f
 xShU5LrGR500+lrmvlhyVPNuvVaWTwDWvPTbieeiXEL94gYz2GflwKu4Kcnmg2CPWhZCwVWV
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=6874544e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Oun69bGA1RwyZKjlVkYB2B1J9759Yyhu
X-Proofpoint-GUID: Oun69bGA1RwyZKjlVkYB2B1J9759Yyhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 49C6540ABC
X-Spamd-Bar: -------
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	RBL_SENDERSCORE_REPUT_9(-1.00)[205.220.168.131:from];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
Message-ID-Hash: GYRYV5DISDSPMJEVKP2GXIP3E5V6C3BV
X-Message-ID-Hash: GYRYV5DISDSPMJEVKP2GXIP3E5V6C3BV
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GYRYV5DISDSPMJEVKP2GXIP3E5V6C3BV/>
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

