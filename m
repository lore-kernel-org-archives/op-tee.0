Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD4DC83F17
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:56:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 884B3451D7
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752454600;
	bh=xyC4ljT6KHH2oOYe61zsOgJHkbSxs7nTcBkLYACz68c=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zhNiP22nE27vmhgl7AZ/gKhkAHCdv686Y2wQog9PRgCkA2EJzHj/xtW5D225GChRV
	 UFUdvAb+s3ZkfxXu4CNOnf+UTxkmGazqFlpSQY0HrwSI92PHcs+ScEcpX2i3KZqQsi
	 FIjsspZKHTbyxvUNp9fYmKgPDy6mJh9y3JrYzI7EqL+aLT3Xo51UFc/racZXNrLd2t
	 8Ieoruw4YK0z8QeCP/25nFcyP0CSuW2KBQpX0pJK62CDMjKE8Hpq6ROWLG0p5dfCHn
	 JSrDdYP6LM0lR9UU073ywRDbBegmBePsGAtmRU7FhcQEbn+CyzVbqUgCdM+APhrCSL
	 xfuDQ5Mq6cpNA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 887994FC95
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KxN63jZn;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNPPZ2032000
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFKZ2Vv8rP8BW5x5RLW0X2t4wnUgLw4yB1fx44K8dqA=; b=KxN63jZncXng1ECz
	+Aik3IMs99j/hx2OYbL5OS+Jf5ExdSEVFS67ucHiPTAQ/Xb3tY+OmaH0Gn4p1+ef
	cCvkBKo9QyOUkL9YxZiIAZG3saqVUvw6lrp9SntR8qgDxEnr06O0adwSvQHDrEqn
	4wRvddDT2LYA8efFfNjG4tZM0X3IbFKCnk9aoozHRuFikHUAUUM5KTBhNag2F9F3
	zgiHsnMCDgPPFpUrXxwkLjHsziGu08bXfFCk8KcfjLre7xQfeYqqZohykOhxhyTj
	B78jkAzxANUnzZB64Uc8A//+4v/ULR3PMuW3l88aUCOd7NaUwAdwfLIcmLBc5yi6
	F8AQNA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmtsrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234b133b428so29959775ad.3
        for <op-tee@lists.trustedfirmware.org>; Sun, 13 Jul 2025 17:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454236; x=1753059036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFKZ2Vv8rP8BW5x5RLW0X2t4wnUgLw4yB1fx44K8dqA=;
        b=JTn5eUL6F1xGZGEy+CkdCJgEIdC3RsLLc/x6XxBvwocs5xvdswSHnrOsytEP0mITkw
         8M7XtUAsMsbR6APwR/LB8swIa0aohKvE9rL22uhN9RLEwdaiMTaJPVwy0Jy/j0s1Rf+y
         M3htaCnctWXu8Mzz9McNpvIltIUFxRro9AVJrl4fT2PMcaO65QxVgzt4dW1KAS2Pg699
         KN0up0QnghRXlRZq8J5DmxD8PMxPAFvbiKv2gWu3a4hIHXd2B9L//68ThMet5R0rwJM7
         wz1GjHvrOYlDkR2nIFnhFpgp0N6XN3o3nj7mzgFb+CjHYHzDt29oxWI/6mMf63RblrxR
         13Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWY7SmwEeBR9qd960GyMEhEggPbSGAvhDPOKBfFm5CxENmP2Qc01hf8R+egIepYi+rI13bLmgk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzgUra2KcroxawiZwxwfuWEf+EXEXxNdGkQMxa48pkw6tsPkhqE
	Nyan2NS1K0+1xfaLDHuuV9J8Cwwqx0gTgZOPhaKOV4Oe2XaTR1Mk4it10hBCTaHGY0DOhkWKZ9z
	jUTdcoa9sxgQzcp+NHNbGUL8uyagVsraNd1YPt++dFPG9ADV+xAgJkU8sUSo0EioGFjUE1h4=
X-Gm-Gg: ASbGnctNtm3jOrnSUFGLP0DK4mIkJQP6OftZgBLHJb8/HbHzMo8UTSLN/wD8+RQ6h+r
	hvel9M0Rm/6OVW23i4ZqeXY56AB7yJeCBc28cBcmp1zOd4lAbVBMO4HaPIoX+oA/ofIzwjs/t6C
	XXl/DHvrRraPuE3+xC9VXvOIuCHPsoHks88GtU7z0NgHhTMlRMRVGfwgK4YNiUMYonhaNBJeRd6
	JjEvw+liagU7RQwcdtVLaXMpgMDYf4mlIMG674MGzBvjkRpKGIgWWqVdTh8FrNAr+1Xckos/R+7
	nS9c+Mrvun8Zrhwcbv40vOYDw1uH/zBvHHiq70edFIM6jYCI7yn+gFI4RE8Pzv6hiZzY55PLggP
	rCV0Iud+z6Up/75bSOkWswcg=
X-Received: by 2002:a17:903:1987:b0:235:f3e6:4680 with SMTP id d9443c01a7336-23df083b061mr146286265ad.21.1752454235577;
        Sun, 13 Jul 2025 17:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWE63CUT+mV4eFI/L/OI3mlg28dVXCWxHTZWUfahh4Pbw8pKLIOS3+I2QJimL01ku9B4lVgQ==
X-Received: by 2002:a17:903:1987:b0:235:f3e6:4680 with SMTP id d9443c01a7336-23df083b061mr146285835ad.21.1752454235146;
        Sun, 13 Jul 2025 17:50:35 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:34 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:49:22 -0700
Subject: [PATCH v6 10/12] qcomtee: add primordial object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-10-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-GUID: Wj4Ah6zN3nJKtYDuewHib7K6VpEWmAm2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX7hNeG8vDRRPv
 hLeoQjlOxi9+3OYvM8Cc/4LoWm5odJ8wYXD+fk3q1BmzSV6MM/H52M8GY8s8lqGmdjXfdZWOTpP
 43rYnG8qWNIxTB+k0HyDjFAOkb5IxwRiDez2D3K1T9gsuAvc+0uTDavMq1zyNbwyoa17SdkEIK4
 IrVp5QGIHAidEHW1JXYLtc8futVuRpu7WzEvjLIPc7lX86nT8sB7Qq9/Wkp8bSH6vKpl8aOfOmf
 ckHnwQe+8bnVedVsezWI3gqD47/jXY1TEN3JWkH8praKcKCNsiUIV4OSBhI3d3twetCmVDK/Cg+
 +qjTLQEs5IVwhcpY6vhvuoTrVA2FJTLaaeg67bBeQJq/FTePFQ/RuAMtM9p1KQ+tHoRfbRcdW8c
 t1utBiDkDyJd4QyYhmbY0WleQ/rKsT8TzFtTN57kM3e+3lMLI39PZiHvS0BUaC9ImqTd1aRc
X-Proofpoint-ORIG-GUID: Wj4Ah6zN3nJKtYDuewHib7K6VpEWmAm2
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=6874545c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=6dJEewf6gjddJ4Qna_sA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 887994FC95
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[205.220.168.131:from];
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
Message-ID-Hash: SZZZIT3QVHCFDTYXHNISOK2RVIXZ5RQP
X-Message-ID-Hash: SZZZIT3QVHCFDTYXHNISOK2RVIXZ5RQP
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SZZZIT3QVHCFDTYXHNISOK2RVIXZ5RQP/>
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
 drivers/tee/qcomtee/primordial_obj.c | 66 ++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/qcomtee.h        |  3 ++
 4 files changed, 84 insertions(+), 5 deletions(-)

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
index 46a5ca95b7a9..9491f5aae4e1 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -30,10 +30,12 @@ int qcomtee_next_arg_type(struct qcomtee_arg *u, int i,
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
@@ -156,7 +158,9 @@ static void qcomtee_object_release(struct kref *refcount)
  */
 int qcomtee_object_get(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		return kref_get_unless_zero(&object->refcount);
 
 	return 0;
@@ -168,7 +172,9 @@ int qcomtee_object_get(struct qcomtee_object *object)
  */
 void qcomtee_object_put(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		kref_put(&object->refcount, qcomtee_object_release);
 }
 
@@ -260,6 +266,9 @@ qcomtee_local_object_get(struct qcomtee_object_invoke_ctx *oic,
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
index 000000000000..025346cde835
--- /dev/null
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+
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
index ae82e7747c90..4253bf49f31b 100644
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

