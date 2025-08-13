Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8479CA0EDC
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:41:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2A2634FCD8
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755045698;
	bh=O53oCjVOWFRQhjWHjt+4P5FEAFT625NmeW0TBuS/Eqs=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Rgy9CkbPOLvZKU3k2ATS5N4Y2j018Izano+V2vf2n++CpWS7KyHA9sRm72UL+VSVe
	 vGBG1q7cHRpm5RTu8WxBShczmh61eWyWIW5L7MSh2gBAQp/5kMoN9Q1CNPufThFmY/
	 Ljkl1i8xu5tNH38PHVUV3RtuZx1/8TexECy31i8f/0zk/ghwShIadUHSUxkAbRpfRC
	 xy0SoR8pSuzAk/eaJegnIppC7r08n/EZd4ZyC2fzUc4hSyaJEX3bDXMYnXX5nDaPoV
	 Ef3ZsfIM6xOPg89Dz7nJUMqn5IFKwbEHqxJuOAENVf/+R6fHi4r2kPvhnM+94lMUTu
	 Ai2i3dt/0nndQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4A3AF453FD
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dyRUUEtl;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJx8FY012369
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6+xxwSKNpqZLnnngK2iH6cMzG+P3jkkyP7YphG9EiKQ=; b=dyRUUEtlpPiZfYXI
	B4QwBXfkzetvoj3MJXwTKVIl3KvQHjI+fxcu/pToqwBwZ171o3NbiyXXYQSFgfhW
	tvHopc6Vzp/7xoZ/M7/sRHu4w3oI9Y5mmAQXWj7O+ib3IGs+dSBai9FucSr7MV/c
	Hb3/vLosfqt2o1J+Zhhgha8WPv0GE8Lyb4rshh18XNBwVkhYA2aStbL5AgPkAJrY
	GOLJ7mrS8miHdXNmmoO6hoyU48FTNHO/ukoqhBMJC5ltRRWtr9TqGnWauyzyU5LY
	Kr3/qvOgM0UcSQ4aOuwHLJm8IzT+XVTU7i/GmD+B2FqEt1dtXHBP8zPjx37nS91b
	o2k8rg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv1vms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so12674461a91.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 12 Aug 2025 17:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045433; x=1755650233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+xxwSKNpqZLnnngK2iH6cMzG+P3jkkyP7YphG9EiKQ=;
        b=fnmP03JWoH0GgQD4QHeCspxnZb7YJ+yjaoUPwggESo8dUL5muweSH7Gljg7CQTgLTJ
         nwPSHjEvr6Hsc+DwgRZf7pMdzVfwYUbbi51NUsDSdaFNWGta4qYbPJPQEsOYsHsJZ3Ii
         HMQR+Zhbb+bo/MEiniFqX6qF5KATPucsKeH38+EuG5Scm5VzZzaEPqGTu5bF/uG5hgdR
         lstnXfMt7755WuRvllQwolCDpuUB20P2U89KGMmMM41tLjNbr74crIsGOZAz2Ggz1CFt
         CCHKYPW6vjZ92/6/B2ljQA5wGC10NYE+RwpDGGrFMH98D3KSWyvQXo2d8GYb1B8OXMo6
         AvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdF3g0VqoTJQz/rZHmKvkH1d+qRy1mcqO5ZL8UZ3tDD49/d+FZp0LDn9QzqMloxQG3eR/tM5Y=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxmz24qY5QCwVwod3O90CO5uMzsVrIhqONHWgelyr+rx4yxOHKi
	+TJU0QqP2Lo2LQTiNn8aB64RJJXHu9UoQy+ZrVt1NjxN8cueHj3ze7MoOGh/JkAntnlbH/StOVs
	6iWPQfTXaLEbVtKw/3bhbUOXiLfydp74sa0NF3PtG6Kgbjp5oFWCyPoAQ/fsuU7MjtpBYGc8=
X-Gm-Gg: ASbGnctBum6EPr8uMscmCOc5q4iuGNH5HS+7xwG5dOEg4fLw7PR9Au2/FHsY6iVLiuL
	vyzKPeSXgg0S8CNKuJNQzUry8mKolEP1miJAcTQ5Si06O6RXm++sORJTPiQES4MiCAGE1A6INk1
	Iyit8u2XZRzZr0oYQ6Jmin7l+SbFwj6p7tgtadM2mPrtCWQfOG0O1YvKy915obTnOh46kADl5Wk
	qqqd4DS3di+j4P2GGUORYnawZHwxhURK+QhfCgmkk0NtYX6/RpLifr9VKjOroZfg3ObX9FvnkMZ
	ugGFn7XgwPLp/S4lA9a+LybMLoYC1bPz/0rAPqoUl/iZTd1E78Q3r6oi8XXvjuCVOztRKwX1e9x
	h04JeD5K7nrYmELcZ3YOyMMc=
X-Received: by 2002:a17:902:d48d:b0:240:80f:228e with SMTP id d9443c01a7336-2430d21d507mr16719375ad.52.1755045433467;
        Tue, 12 Aug 2025 17:37:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8i8EynRFCyIKJFpe6TlZ6plHoRJ1fRFvTsjRThmN5ggZyOGDgU+lkaJqS2YMALD+4ZNq6rQ==
X-Received: by 2002:a17:902:d48d:b0:240:80f:228e with SMTP id d9443c01a7336-2430d21d507mr16718925ad.52.1755045433001;
        Tue, 12 Aug 2025 17:37:13 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:12 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:35:38 -0700
Subject: [PATCH v7 09/11] qcomtee: add primordial object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-9-ce7a1a774803@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689bde3a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=6dJEewf6gjddJ4Qna_sA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -oKCAeExe91EKtegtuZHUcJZdPtclgs5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX7DkjweVnRdUc
 ZM+MzfynFZYUcZO+7JHq06CntXxkuOIN/0nn3Unmy2bvf5hQeT9grBNU9Ldw/2IIhMWjHGsbgHb
 6CS6fpLfPe+u/8GoWQXiVRtFUv0HLNxOvLBzWK/dJXh9s1DB3b1hdyMUDUusCiQTgl+oLaENHrn
 vgIDXShaFkM3ljsKdTVF2RXQyV8g6c0feVXj4HsTDhnAFQyCdcn/zIzrU/sVc22NRXWlswP/895
 mu+F9xrztkm1FIQ0ZR0Ia6bJfPo94V12LuAUID5AAyvbYx9eBqP8K82kXD8T6tG7hZj6K+cCNPy
 1TzNYmxh/S04dtI5fAD/qmoXXA2aQOKZ162Z6oCnqd5a6WrbWiDyrwLePCBbmCIiRGZLC/g8D9c
 uaWNRm0y
X-Proofpoint-GUID: -oKCAeExe91EKtegtuZHUcJZdPtclgs5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025
X-Rspamd-Queue-Id: 4A3AF453FD
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
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
Message-ID-Hash: AUA6ZPEWCKIOTE6MP67IMPHMJ2TT26IE
X-Message-ID-Hash: AUA6ZPEWCKIOTE6MP67IMPHMJ2TT26IE
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AUA6ZPEWCKIOTE6MP67IMPHMJ2TT26IE/>
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
index 6d28138ef266..e1ea2c5eaff5 100644
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
index 000000000000..df94fbf5f141
--- /dev/null
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
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

