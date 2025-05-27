Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD28C54ED1
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 07:02:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5ABA042F97
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 07:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748329376;
	bh=aXe1yZumvUJJkI92L5z+O6jNwRKaOCyXZQ9Biqrb7Do=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=soFr4X/YSy4PQgCkZyIqml5iIzEBR/skz6PxDrrL3OtsPBrELD5vdMxDJJrWmQl7Z
	 bfHXia88lDCJCdxfvIIQuY7CxDfY6x38pBA2ZIOASkqh584ZkjOyR/37/8eDEjWfJb
	 yvVdXQcMf6CIVKSiwxjc64DzZlehj8GgJIRjx1KRwTn0mew1Ur/anzvL9zxnh0PNm1
	 HKwOUZCqI+GZP3c8rQftu/saNezeUKm0AGFvJ45Pm+xo37QyaCJiOOtqtz9XQZnuQN
	 uf8t70kp02ewgirqxW0WCAbZEx9ACnzhZIRIahg08YQV1ESHB7Zb/mG0PsBeCWdQ3K
	 iRX1ZLg9nqwKg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5B39E413B7
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q6Zrv7SA;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QMP1Th023955
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	He/2xOHm9r8pxCyAR/q53OU1lKXDtAqoYmT/PoWo34Q=; b=Q6Zrv7SATwo5RxJn
	HleoTOKrdjRKYdaY/Es+9f33/oqcBveynYV9YbraUdzbG5/xBktFfMJylZ8q11Vf
	kPKRgERl1EvUoYWUArSyim77C3ngg61GDD9GI03PY82DBdv9LAkp9OEtInG4fw6f
	lV0QP5Oh+sMlLX31HBJIBWxzUvbPY/e2pfY/oxx8uNMRbqwf64hJ3vQxCGTbFz6g
	4tp2asNtpwr1N4K+qe3WgLih3SjWeTopecWWRb1W52le0Y6Rp2dQLpUDSQMMA7iG
	Z0xUGjw/jmZdUQj3DKoAdqWhFvvQXhDMVME/sG9vIepuEjJD1iroMaEiyW7D2pqm
	RTn06w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ejwx9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b26e0fee541so1966076a12.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 23:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329052; x=1748933852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He/2xOHm9r8pxCyAR/q53OU1lKXDtAqoYmT/PoWo34Q=;
        b=YcS8sdMCJ2qNcqRn5HVTyS8TjDVgjpwoyqfHVOwyBdqd3ZkpD4t3NNkFC9aBb7rfPF
         JURDXaVeCbyCy7lagkATryKbkJ1cRO8REfQQUa6tkAPBdmR53KL4pZtu5ajFHAzBePc1
         w1MOobZBcPP7BnTPwDn4HgSxheTcRMXdsAUniMaNwAR892soy3ywG08HOzC3n9y+bIk8
         JLCJInmj8TyCg6tSuYF9qUNUYwPYrNRoJe9jbg/hKfmq2NbaNmTGrvojXCZAP0RFZW9G
         /Qq8PjCRFSLJxkaWiD0F8TBfPkhIG6aO0YWahMgN+bQ3CIEcXNNh6dADnDnJZQY2oxls
         ahpg==
X-Forwarded-Encrypted: i=1; AJvYcCXbUunfI55dDHzi1Naf7FEuKGua89O5M0R7I0mUODv7JIU7c54x8auTwgII9F969pyK3FGKqM8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyq6Cth86S6DkojxJH8y5AG+ePOg8/8EBXdECRATwkJTy6nBWcA
	TQ6vPzeVTF+B4S4+EIMQun9kG/P+6lBPKPkhFsxDKDNMEycfTBf82aFvxzwdWopmTw45dSy1CIz
	fKg2a2DF0JAsELz3kDp9nJv6ncsIZq+RV33sh776Fd/OezPT114OU/pwU/nZamwYkBRmlOYV4dy
	gbefDjMQ==
X-Gm-Gg: ASbGncse/KQh5IlzoH1rOj25KUuwMbMqC4AgrSTtY/42fMjqhigJ7VNeHEqJJxMD2Tv
	NFmALoKOjaFA9hHthiN1ukR0R2g5o/kvwkLddAFYYOM1qXFJDNyZaF+sILv26wsxNtiJGIX1rN3
	PR+BW0hODVwb0jztxSzzDnQRIABXJiEWaHx5+SiQdSTFtxf7HsD+//hm15vyyKbz+3iLm+B/9gK
	N88CWAUPPviT8qXnrSJHEheJ4VpeTvXwy5WFPd2+OWq0Beu518ps4IW6RumWgeGHI47CEomC1MM
	95E4eomrvZWQli0LYS0k48xcIIg92qJ/B7UhfYpxSyBmIkiwuj9c7/Qlo19XDgu1eAA6F9Y=
X-Received: by 2002:a05:6a20:2d07:b0:203:bb3b:5f1e with SMTP id adf61e73a8af0-2188c1e8dacmr17039842637.1.1748329052264;
        Mon, 26 May 2025 23:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVgxAu8lBxbrpstlo7/hYePbT6lFQVTqYcw3BdUiB7ZTFvd2Pr5m7vLP3HE+0xPQeMXwjGWw==
X-Received: by 2002:a05:6a20:2d07:b0:203:bb3b:5f1e with SMTP id adf61e73a8af0-2188c1e8dacmr17039810637.1.1748329051813;
        Mon, 26 May 2025 23:57:31 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:31 -0700 (PDT)
Date: Mon, 26 May 2025 23:56:55 -0700
Subject: [PATCH v5 10/12] qcomtee: add primordial object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-10-024e3221b0b9@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=6835625d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=6dJEewf6gjddJ4Qna_sA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -xOTbQjjcrofa5dzVy51WwuN_0vMRiVX
X-Proofpoint-GUID: -xOTbQjjcrofa5dzVy51WwuN_0vMRiVX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1MyBTYWx0ZWRfXwLVYIlBAP3Xm
 YZUx1Rgd0ucDXdtlwK1uxej4NyphJgIrEpR1cDM2XF70W3hv43Imvx3yZCPNaI6K6sWD7Yd37bP
 q30qPpPNo6aZspDrS5c9Eo2346fWSR+/b4miUFtT9e1Nwavr4ruTTWdLxx7KWIz2KV91gp+z5ws
 LE4jPMHYH480A3p/2UrAErGNjKHP98pj2ZypzAIjXzY7+KWKf5zwr0XFhpu+wM5kvzGKWlwvewq
 XJwvxg10L2St3zBURkCd5LlTejXG3L6eIb/Gn2dw7p6lS5qEFlOpLp3yPuj4CUBn/HbEc9hMMYf
 0ouMnrUXa5f2NrbUROo33OV12WIzMeVm+ZfazDO/OX88+kznFPo0nXG7actTC/c9SBvu0IApNJL
 1sDjZDkA48SXNFNozWr86VMuU2XKTvHUHFvuL3/qQZP/baO6wC/zffArlpDC9nXLzBrgNV7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270053
X-Spamd-Bar: ----------
X-Spamd-Result: default: False [-10.80 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5B39E413B7
Message-ID-Hash: EGD7JG52SROMWUEJ7DPX5R7UIBHDHMSI
X-Message-ID-Hash: EGD7JG52SROMWUEJ7DPX5R7UIBHDHMSI
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EGD7JG52SROMWUEJ7DPX5R7UIBHDHMSI/>
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
index 0e7f3ab8242a..a949c41dc687 100644
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
index a69d7c091637..f3a5c4658792 100644
--- a/drivers/tee/qcomtee/qcomtee.h
+++ b/drivers/tee/qcomtee/qcomtee.h
@@ -221,4 +221,7 @@ int qcomtee_user_object_submit(struct tee_context *ctx,
 			       struct tee_param *params, int num_params,
 			       int req_id, int errno);
 
+/* (2) Primordial Object. */
+extern struct qcomtee_object qcomtee_primordial_object;
+
 #endif /* QCOMTEE_H */

-- 
2.34.1

