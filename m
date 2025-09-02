Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC894CA0FFE
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 05:01:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C92F4FD56
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 05:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756789290;
	bh=+8dSfgrMG4eFIFtqJ20ROAswX13YmpqsL2XfyfUksAU=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GyTzLiPlgrkPoXWd/A6warck85Ofk2NukvVPqXwT2drYBHo3dKIa8aZt36afpUOgF
	 ds9kJa5+IRs62s6B+Wn7mqdIZ/bEqD3zH4lMe6Eyqpy1/1Tpjbe39NNJAM3w1r3r8l
	 yHj0Z3tDj8Wep7ip+E8SbN4IIkt2cTOcyTt63a15IPNmAiJC68RDur3If/yp1+nn3s
	 vpF6H327XHzuglzVfDIdoUKDQy2f700Aq+HGtD7YqgHmDo9YMZVa2bRh2ZHgmCGwVX
	 jdTSM0DWbt+kNTGCFVo9EohwG8etqNmyilvqQnjyszJIV0rGCcDbOWv8Eno7NBMBv1
	 M7UhaBDipzcyA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D725F42D0E
	for <op-tee@lists.trustedfirmware.org>; Tue,  2 Sep 2025 04:56:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K7Jx23P4;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S9h0022293
	for <op-tee@lists.trustedfirmware.org>; Tue, 2 Sep 2025 04:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GaTc6vdim5GJ1OsrX7tFizDxK1+T66nxGle441QICfs=; b=K7Jx23P4OZAQr2fo
	AoDZTIxkFNqDxtNAi4dl7V0k7NeD4Eb6KdixcLg8/OUoqdtDP7JLVGnbLl/bwANz
	UX2DCly6R5Tlhv87gPz1UdXeDt7Nv5AssN5h1JbRr/N4FYXd6QNElXtYySA97Qbw
	6b8VACBFKswkoiMFzyOmDsgGli5tBf29DZZfJiTc7/Jyq9j8KrUoaf5NaLCEU2To
	rco9g2JAjBGq4Z2hpX/Uw+zt6h/j4l3SSBMky8HqSHRFfGy3UMx+g+rxx2Zh6FmJ
	lPhJ9SQAsHl+x+Z9SZho9uZSqswFN5et+9bOv/Z26VRGK5mywWYnItMgAZ9Tzxf2
	5W1d7Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6pc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 02 Sep 2025 04:56:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-248d9301475so68291365ad.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 01 Sep 2025 21:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788985; x=1757393785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaTc6vdim5GJ1OsrX7tFizDxK1+T66nxGle441QICfs=;
        b=AJVmap23jO9nSHdbOZJ3Opk1u3bWv0s4QjzfC1aMsgL8vrDoyhSDzfmJjeDR76wsOI
         ZNvFjAocFIXYpCFb7YP+tygZeEjlEi4zciIg29wR42nYVq4C8ONLTqX/0Qt9JGsAsDw3
         ES0u78qHwyLCIs2aq9kZys4CMOaY/qGFnkcT8zPdmzu+puvaCXFdDOfgd6uLW47CcJhV
         hkkFFwGmgf3GIPXA2FUOE7iEDczHkCk4nrQ6SU8QURpGooJPCIeP55l9uas1ld5lU56d
         hZq2opje2wXfPECVMgYMRo7Neu7o3NBat/brBc2l3L6/0fWP3C9AfOQC4uVQ97f4yrlT
         L87g==
X-Forwarded-Encrypted: i=1; AJvYcCWlWzjseIeA4kZ53iFqtSEdOjVvombCnD0RdtrCayTfewr6rGdP6sSRXpzXUxxk52/QRpABTtU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzFquNI1g8hocAKHvrydh1qf8X1xuzNAISwavSEHkV7mrgJsb8i
	2f4NM48wfjtiRbSvtSP5m+KgXrUA7zcGf88XuuYNq4c7Q7ydZ6r17DU8WPH9hTxhmnxwAseYHgD
	UJ83rlrvB+8vRNWqTbgdsM4sJwJ6WwT1bo/0G+s9sP1YPnemE1gPSV6D1iNlt25E8HuF5+48=
X-Gm-Gg: ASbGncu+65477niy/i48oDLdT4fgiAqU0c/GIyNaXYuFnEa7sB/iJ6pEszuNmKRV6yS
	XVVwEtZtKQuAQVHNnf15rjRHIMgrMHMCbtQ3YiFCT09NEg7WSQHjskDhaklrqrVlmFyFQj/o/IY
	Z+drkYMQtU6hM3fTNp8G9GiFPHR4k0Tk9aaXw/ILxjrAq50GgwHrFFRngAsqlAsb7nM4RT6i2dc
	yS/a/3WY9MyieK8DKM8TdaKP839J3HF51RhVfP2hQ/ocODp9mfeRvfuhjND9EGnjSVIou+3MitX
	9LhG7NJLu0yo4NIPMglls6SNKc8rMjCE3yN81x2n5g1rLkhADEBq9Pm/8M9ZMJJskE4/CD1MuIg
	qXWT6BhqQzqQ3FmikBpS/qlY=
X-Received: by 2002:a17:903:41c9:b0:249:147:95bb with SMTP id d9443c01a7336-249448de13fmr111598095ad.13.1756788985025;
        Mon, 01 Sep 2025 21:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXaX1HfNEFgce/CqpAqiFLPHSgKmmTTu1lgTlIqGkApoJFe4/E3D7TAwWkW5ibXkmVnGac2g==
X-Received: by 2002:a17:903:41c9:b0:249:147:95bb with SMTP id d9443c01a7336-249448de13fmr111597865ad.13.1756788984558;
        Mon, 01 Sep 2025 21:56:24 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:24 -0700 (PDT)
Date: Mon, 01 Sep 2025 21:55:56 -0700
Subject: [PATCH v9 09/11] tee: qcom: add primordial object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-9-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
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
X-Proofpoint-GUID: uoqLsN8Ky1xZlOnCgmsNV7qkFdXCCsjR
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b678fa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=6dJEewf6gjddJ4Qna_sA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: uoqLsN8Ky1xZlOnCgmsNV7qkFdXCCsjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX3rZzSgO60tuZ
 cZSbBAwiJOahHirY50ndWDbcjmFOqnxVSXhfUff3Ieesiol87Y1I3/z2wB33Wq4u+xqB0cBICfJ
 xxSbkJUx5F4FYpIueiUJ3v3jWdevz6i91wapTnLEo81c4Kv/jjj9AsZIw6qGVuSCUaSKKz0o4Rz
 FiTzV4rVutxcBHyTSfHp+IjIMOAZ3Cp7GM3GhnO9fd84JNRRmmdNI5XrtDGq+2kdl+G5meV1KU+
 6Hrlu4PaFyT8xl2Az1skZ1JdCGsM6UPOtnaWNTO4VEB7u0R9B/um4b9oJaBj+GJjklQKuntZTAH
 4Rm+BIyNy0EgXhLX3gCu9ekqo8lIxheZkn3gTw7ulJiniJiJvFJKnzLblB/uCk+GmewxNFWwcKh
 RBxvnFBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
X-Rspamd-Queue-Id: D725F42D0E
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.20)[205.220.180.131:from,129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: ANR7XLRD64NNRDFMS3KHNDXZXGVF5EWM
X-Message-ID-Hash: ANR7XLRD64NNRDFMS3KHNDXZXGVF5EWM
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ANR7XLRD64NNRDFMS3KHNDXZXGVF5EWM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

After booting, the kernel provides a static object known as the
primordial object. This object is utilized by QTEE for native
kernel services such as yield or privileged operations.

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/Makefile         |  1 +
 drivers/tee/qcomtee/core.c           | 19 ++++++++---
 drivers/tee/qcomtee/primordial_obj.c | 63 ++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/qcomtee.h        |  3 ++
 4 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
index 600af2b8f1c1..78f8e899d143 100644
--- a/drivers/tee/qcomtee/Makefile
+++ b/drivers/tee/qcomtee/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_QCOMTEE) += qcomtee.o
 qcomtee-objs += async.o
 qcomtee-objs += call.o
 qcomtee-objs += core.o
+qcomtee-objs += primordial_obj.o
 qcomtee-objs += shm.o
 qcomtee-objs += user_obj.o
diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index b6931ed6f200..783acc59cfa9 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -31,10 +31,12 @@ int qcomtee_next_arg_type(struct qcomtee_arg *u, int i,
 }
 
 /*
- * QTEE expects IDs with the QCOMTEE_MSG_OBJECT_NS_BIT set for objects
- * of the QCOMTEE_OBJECT_TYPE_CB type.
+ * QTEE expects IDs with QCOMTEE_MSG_OBJECT_NS_BIT set for objects of
+ * QCOMTEE_OBJECT_TYPE_CB type. The first ID with QCOMTEE_MSG_OBJECT_NS_BIT
+ * set is reserved for the primordial object.
  */
-#define QCOMTEE_OBJECT_ID_START (QCOMTEE_MSG_OBJECT_NS_BIT + 1)
+#define QCOMTEE_OBJECT_PRIMORDIAL (QCOMTEE_MSG_OBJECT_NS_BIT)
+#define QCOMTEE_OBJECT_ID_START (QCOMTEE_OBJECT_PRIMORDIAL + 1)
 #define QCOMTEE_OBJECT_ID_END (U32_MAX)
 
 #define QCOMTEE_OBJECT_SET(p, type, ...) \
@@ -157,7 +159,9 @@ static void qcomtee_object_release(struct kref *refcount)
  */
 int qcomtee_object_get(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		return kref_get_unless_zero(&object->refcount);
 
 	return 0;
@@ -169,7 +173,9 @@ int qcomtee_object_get(struct qcomtee_object *object)
  */
 void qcomtee_object_put(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		kref_put(&object->refcount, qcomtee_object_release);
 }
 
@@ -261,6 +267,9 @@ qcomtee_local_object_get(struct qcomtee_object_invoke_ctx *oic,
 	struct qcomtee *qcomtee = tee_get_drvdata(oic->ctx->teedev);
 	struct qcomtee_object *object;
 
+	if (object_id == QCOMTEE_OBJECT_PRIMORDIAL)
+		return &qcomtee_primordial_object;
+
 	guard(rcu)();
 	object = xa_load(&qcomtee->xa_local_objects, object_id);
 	/* It already checks for %NULL_QCOMTEE_OBJECT. */
diff --git a/drivers/tee/qcomtee/primordial_obj.c b/drivers/tee/qcomtee/primordial_obj.c
new file mode 100644
index 000000000000..0e43f04493e2
--- /dev/null
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/delay.h>
+#include "qcomtee.h"
+
+/**
+ * DOC: Primordial Object
+ *
+ * After boot, the kernel provides a static object of type
+ * %QCOMTEE_OBJECT_TYPE_CB called the primordial object. This object is used
+ * for native kernel services or privileged operations.
+ *
+ * We support:
+ *  - %QCOMTEE_OBJECT_OP_YIELD to yield by the thread running in QTEE.
+ *  - %QCOMTEE_OBJECT_OP_SLEEP to wait for a period of time.
+ */
+
+#define QCOMTEE_OBJECT_OP_YIELD 1
+#define QCOMTEE_OBJECT_OP_SLEEP 2
+
+static int
+qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
+				struct qcomtee_object *primordial_object_unused,
+				u32 op, struct qcomtee_arg *args)
+{
+	int err = 0;
+
+	switch (op) {
+	case QCOMTEE_OBJECT_OP_YIELD:
+		cond_resched();
+		/* No output object. */
+		oic->data = NULL;
+		break;
+	case QCOMTEE_OBJECT_OP_SLEEP:
+		/* Check message format matched QCOMTEE_OBJECT_OP_SLEEP op. */
+		if (qcomtee_args_len(args) != 1 ||
+		    args[0].type != QCOMTEE_ARG_TYPE_IB ||
+		    args[0].b.size < sizeof(u32))
+			return -EINVAL;
+
+		msleep(*(u32 *)(args[0].b.addr));
+		/* No output object. */
+		oic->data = NULL;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static struct qcomtee_object_operations qcomtee_primordial_obj_ops = {
+	.dispatch = qcomtee_primordial_obj_dispatch,
+};
+
+struct qcomtee_object qcomtee_primordial_object = {
+	.name = "primordial",
+	.object_type = QCOMTEE_OBJECT_TYPE_CB,
+	.ops = &qcomtee_primordial_obj_ops
+};
diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
index f34be992e68b..084b3882017e 100644
--- a/drivers/tee/qcomtee/qcomtee.h
+++ b/drivers/tee/qcomtee/qcomtee.h
@@ -140,4 +140,7 @@ int qcomtee_user_object_submit(struct tee_context *ctx,
 			       struct tee_param *params, int num_params,
 			       int req_id, int errno);
 
+/* (2) Primordial Object. */
+extern struct qcomtee_object qcomtee_primordial_object;
+
 #endif /* QCOMTEE_H */

-- 
2.34.1

