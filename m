Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA3FCA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:31:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A208D44FC6
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430317;
	bh=KaRcLGFBjQ//N9AGbNrr+zyJYDMAUB5KtT/9/yT6j3Y=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=neqWh8v6C253yKKrpuUMDeevKKMHZpTi4Gq9VH3Sj8oJogMVKauLoIBNOyI1IQSv7
	 ZWwareKWtPDc8AJ+cfurW2+mlfst3cKcSkOljTsz+RpicPj4oF+uXINwzMHhr4NbKm
	 iez3zfu62JIR82hoOdveNtXqdKWk1wmYWLSj/doZNxbzFmr7SBbDPrBAMDbUqY2iDm
	 dBKeEapvI32zcHXsMpOF4SHa3y5Lf/U+WNqDCwNkP7HQKVUlP4/Ymd+VoWXuNrYGEQ
	 /rp3db2xJfPUqiHCJyrPRgEU21zZ7YGsh5S8H5YhvuWwhRqGoxpeQeLzY/dD59sU3I
	 IpiTsExF4ifrA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 072784552F
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HcPUCrxn;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RTJnJA9R;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hTBw1114212
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qDOSkfgSlv2R0xVBV8llQiuT2ZcGPG0hoUyDMx3hNXc=; b=HcPUCrxnFasKbs6Z
	p0a29N47YufgXNd0bnGMNT593uVNWTUvHuyJ+79jrK6Xzm7cs4kPfPNz1P1k67/8
	e0n6tjFV4mjsnbOqJ20RGu7fT8+3KufYGI7QK0fHsG1AKhlUV8djsL1bHVvYDcDl
	3Hcud3hfeR+wlSgw3DL+vkUupCO/Xgsa9vjZ4NKnKYm8Cp8+r12YTjDx0fjhF2TT
	re96VFDUcmZVm/5SHPu6zV9pAokC0nDCNPr+5Ts9Q18AWGLMs59dtZg+7QrDzKdf
	daH7eU9EGzQLnwbaYva22/MufbzJHbrBktCIi9llTa/vc3ajVAryUZrnhOhQLsJm
	TiTb7Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3h0y8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3515d2fc5ebso5721330eec.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430130; x=1792034930; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDOSkfgSlv2R0xVBV8llQiuT2ZcGPG0hoUyDMx3hNXc=;
        b=RTJnJA9RD8CD3WdCPjfWULQ9hJCwoextAXy5Y1i+/6+ltLdtNNxTLWLxg1GEiB5ZkJ
         2drZOZXsPFLPo8XIxNkqQGVANWJSlqYqYXwapOBGIPSUTkBR1kSWGLHaEQYi/TncFZ4I
         /sfvq+dXjM0+edMU8hFjTV+2aHxQkcEY9T4/qHC2CO5tCo1Nco8wxIyw65EvMnUxXiXb
         dNtAnV7iLSrVOpH/DnAOtBYY2ZITGR7ebzEzt+0Xgbd1C71tx/dP4ruxHAEYYQqfCOi/
         Lq1j1QnLHR9IjhH9gpgckD+wtqBeLw7nOoW2l2HhUcYNMxLPGWj0+rA3bER5Vg+WJoRD
         JJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430130; x=1792034930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDOSkfgSlv2R0xVBV8llQiuT2ZcGPG0hoUyDMx3hNXc=;
        b=aB2L/HbtNE3NqDVy2umB1VfWcT469KBrnuYQhmwBh7qPQWhpoewPolafXSREU5Nv98
         dIk5tN8aIV5k7dPJrWXOdKIsFock+28AG4tYOzVVvrpLZDdVCo0Qc++sQwN4qpFG5rd9
         DpQasRhY86nkLvRj0IsZBHh9ZnYn1XVfRL0/7rGGpITqLOpBYlNGcHLxLwXKKj3jMNsG
         kfPbF5YKCBTLzoz9G++punezSN/TjqFWhVSVuuY5YA6zQHBMPU0g7H4nNf5Fr/AhP3En
         XlgoccPlsApwTCJEyPtWumNHkfUgKyKki13vBovwmf7ZxJqPJD4Y42H0WuZqlRtFN/qc
         oSJA==
X-Forwarded-Encrypted: i=1; AKwUvByW18iKGswq1w/ESegvVdGgUqHScnxqzyVtqME8kJ2gvhv7+amahhFqsT7hMvCc0liDpEP4xDU=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kdZhTE/D9aHIvZeO9iuQz9gHbiX25Km6QY5T+BXQ/2qShD3tLq
	8CP2sv2fTq0+z8BNgolHlmBan3G0Wau/71OhqnrLIEuHP11AeG9/XI1L0CFJFCzYQ8EvvnmhmXg
	ENUYXrsO4v+BLqCnm5yunvA6XszsDrAjaQdc/F+U1mil9gR0cPTOvijnEMbnuDzWFdgdQlb8=
X-Gm-Gg: AYBFou2H3x0tCjw4GewBCPLx6G/f74f5pixCm7lnipaCjYhaUEAgPjVdgZ3biaslGNz
	9s3ABaJ4Ze9j4w7EHY6wxPY8hsOmwEkOUw26Wphl/dM2m3/74AhE3IxGr2yqbvMFFwCAtmDPg1D
	RWcfu29/hbqX7hn7vii2kO/EZShcO7npFcNwM5xSA3AHT6XvaMxSblD8BFfA6fCGwwX54BUrP1g
	4E2HzH+qU0D9XtqpSKIOVYiLE59SVFOR1k3g36o4Neaio/lKM8jtblutuCSt4INWjV7ZzwN6ApY
	R8NJAN8CV0Q0A50MuGx8Vqiu4VlgxQt9Fc+jFF4gdjPLn1EcEQfuBQ7MPOiMIrgbpFd10+FE/Nn
	1EebKd6pBPRM24wecZ3jE8KmKG3wDyJ8DfxDg4s9ahSURDNtp2muaexb18g==
X-Received: by 2002:a05:7300:51e1:b0:351:55c3:6896 with SMTP id 5a478bee46e88-3515dde39acmr5313060eec.16.1791430129767;
        Wed, 07 Oct 2026 20:28:49 -0700 (PDT)
X-Received: by 2002:a05:7300:51e1:b0:351:55c3:6896 with SMTP id 5a478bee46e88-3515dde39acmr5313028eec.16.1791430129097;
        Wed, 07 Oct 2026 20:28:49 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:48 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:27:12 -0700
Subject: [PATCH RFC v2 06/10] firmware: riscv: rpmi-tee: discover TEE
 endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-6-45939a13d223@oss.qualcomm.com>
References: <20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com>
In-Reply-To: <20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>,
        Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amirreza Zarrabi <amrzar@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX4Fq1QsiiemSc
 ogDzQ5c7N8UBDgOjiY6eJKnzhY3kXEaaAUtvX9Km2n+eiuH5cfczNqoE4gqbttCZ2nzgIaYzoLd
 HPPinPIYQsdljHbwuI/PYYuiLsaG2Zw=
X-Proofpoint-ORIG-GUID: dwAHqMsrvb2yWMdBg4Xk2flobASNysnD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfXwI5gZtc1Uj7Z
 6ql9TckvChdh6vs3j+/ss9Ku2A3/XY2MhtoclWsrI+pkvm/y4MU9FXwB9vWDpLyT+qO4tEwUlPO
 Ip1CtK4+mDcxd34zjPTL5ksfvj6IH6rFqkgFQ428HvX5kWChjJT1Gja1t+Me2PjYTtqxIBe1zkW
 q8bcEMtN8wR+Ies097c0Z3Zdff1L5GVCvzhmpOB2Q/Pd9Q29u7cGT+p0WRWQBLOqEAhPT2h88wz
 O+P813TAZ8B/AN6JT5ZC0TXEKLeVoXkYitkJXdWke+EpOAYsH2ktu7nUPUwB/qkEzkEO1e/1IfN
 4WVJy/WB3wbRBerozpzcBfnwANLBChkjaXSOOceBE/HCP87ac9DWLz1LdJ+bFf4l7qcEzYftAjN
 LjjWb/uAVd5Dln8314LBp1vXzZtHVsWoYPWHrDKCZ4CBX+1FTiuxv5qNyR9d8cuJQvHirbSO4FY
 gjJ9uGtPOk5Xvurjokg==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac70df3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=LGPBHASfCGe67HC_iDoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: dwAHqMsrvb2yWMdBg4Xk2flobASNysnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org,oss.nxp.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[74.125.82.198:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 072784552F
X-Spamd-Bar: ---
Message-ID-Hash: I7NWPFKBKES23OLUWPQHGWOMFDVBPS4E
X-Message-ID-Hash: I7NWPFKBKES23OLUWPQHGWOMFDVBPS4E
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I7NWPFKBKES23OLUWPQHGWOMFDVBPS4E/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add discovery through the PROBE_SYSTEM, PROBE_DOMAIN and PROBE_ENDPOINT
services. Obtain the caller's endpoint ID and enumerate reachable
physical TEE endpoints and their service UUIDs.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/Makefile           |   2 +-
 drivers/firmware/riscv_rpmi_tee/discovery.c        | 383 +++++++++++++++++++++
 drivers/firmware/riscv_rpmi_tee/driver.c           |  29 ++
 drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h |  42 +++
 4 files changed, 455 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/riscv_rpmi_tee/Makefile b/drivers/firmware/riscv_rpmi_tee/Makefile
index 8984127535ed..fc6edfb21dbc 100644
--- a/drivers/firmware/riscv_rpmi_tee/Makefile
+++ b/drivers/firmware/riscv_rpmi_tee/Makefile
@@ -3,6 +3,6 @@
 rpmi-tee-bus-y = bus.o
 rpmi-tee-core-objs := $(rpmi-tee-bus-y)
 obj-$(CONFIG_RISCV_RPMI_TEE_TRANSPORT) = rpmi-tee-core.o
-rpmi-tee-driver-y = driver.o
+rpmi-tee-driver-y = driver.o discovery.o
 rpmi-tee-module-objs := $(rpmi-tee-driver-y)
 obj-$(CONFIG_RISCV_RPMI_TEE_TRANSPORT) += rpmi-tee-module.o
diff --git a/drivers/firmware/riscv_rpmi_tee/discovery.c b/drivers/firmware/riscv_rpmi_tee/discovery.c
new file mode 100644
index 000000000000..fedd68bba639
--- /dev/null
+++ b/drivers/firmware/riscv_rpmi_tee/discovery.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/bits.h>
+#include <linux/errno.h>
+#include <linux/cleanup.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#include "rpmi_tee_private.h"
+
+/* Role flags in PROBE_DOMAIN and PROBE_ENDPOINT responses. */
+#define RPMI_TEE_DOMAIN_TEE		BIT(31)
+#define RPMI_TEE_ENDPOINT_TEE		BIT(31)
+#define RPMI_TEE_ENDPOINT_PHYSICAL	BIT(30)
+
+/**
+ * struct rpmi_tee_probe_system_resp - PROBE_SYSTEM response prefix
+ * @status: RPMI completion status.
+ * @caller_domain: Calling endpoint's domain ID.
+ * @caller_endpoint: Calling physical endpoint ID.
+ * @domain_count: Number of entries in @domains.
+ * @domains: Reachable domain identifiers.
+ */
+struct rpmi_tee_probe_system_resp {
+	__le32 status;
+	__le32 caller_domain;
+	__le32 caller_endpoint;
+	__le32 domain_count;
+	__le32 domains[];
+} __packed;
+
+/**
+ * struct rpmi_tee_probe_domain_req - PROBE_DOMAIN request
+ * @domain_id: Domain identifier from PROBE_SYSTEM.
+ */
+struct rpmi_tee_probe_domain_req {
+	__le32 domain_id;
+} __packed;
+
+/**
+ * struct rpmi_tee_probe_domain_resp - PROBE_DOMAIN response prefix
+ * @status: RPMI completion status.
+ * @flags: Domain role flags.
+ * @endpoint_count: Number of entries in @endpoints.
+ * @endpoints: Physical and proxied endpoint IDs.
+ */
+struct rpmi_tee_probe_domain_resp {
+	__le32 status;
+	__le32 flags;
+	__le32 endpoint_count;
+	__le32 endpoints[];
+} __packed;
+
+/**
+ * struct rpmi_tee_probe_endpoint_req - PROBE_ENDPOINT request
+ * @endpoint_id: Endpoint identifier from PROBE_DOMAIN.
+ */
+struct rpmi_tee_probe_endpoint_req {
+	__le32 endpoint_id;
+} __packed;
+
+/**
+ * struct rpmi_tee_probe_endpoint_resp - PROBE_ENDPOINT response prefix
+ * @status: RPMI completion status.
+ * @flags: Endpoint role and lifetime flags.
+ * @name: Debug name, not a matching identity.
+ * @proxied_count: Number of proxied endpoint IDs in @data.
+ * @parcel_count: Number of parcel IDs in @data.
+ * @service_count: Number of 16-byte service UUIDs in @data.
+ * @metadata_len: Metadata length in bytes.
+ * @data: Proxied endpoint IDs, parcel IDs, service UUIDs, then metadata.
+ */
+struct rpmi_tee_probe_endpoint_resp {
+	__le32 status;
+	__le32 flags;
+	u8 name[32];
+	__le32 proxied_count;
+	__le32 parcel_count;
+	__le32 service_count;
+	__le32 metadata_len;
+	u8 data[];
+} __packed;
+
+struct rpmi_tee_system_info {
+	u32 caller_domain;
+	u32 caller_endpoint;
+	u32 domain_count;
+	const u8 *domains;
+};
+
+/* Return the domain ID at a validated index in the system response. */
+static inline u32
+rpmi_tee_domain_id_at(const struct rpmi_tee_system_info *info, u32 index)
+{
+	return get_unaligned_le32(info->domains +
+				  (size_t)index * sizeof(__le32));
+}
+
+struct rpmi_tee_domain_info {
+	u32 flags;
+	u32 endpoint_count;
+	const u8 *endpoints;
+};
+
+/* Return the endpoint ID at a validated index in the domain response. */
+static inline u32
+rpmi_tee_endpoint_id_at(const struct rpmi_tee_domain_info *info, u32 index)
+{
+	return get_unaligned_le32(info->endpoints +
+				  (size_t)index * sizeof(__le32));
+}
+
+struct rpmi_tee_endpoint_info {
+	u32 flags;
+	u32 service_count;
+	const u8 *services;
+};
+
+/* Copy the service UUID at a validated index in the endpoint response. */
+static inline void
+rpmi_tee_service_uuid_at(const struct rpmi_tee_endpoint_info *info,
+			 u32 index, uuid_t *uuid)
+{
+	import_uuid(uuid, info->services + (size_t)index * UUID_SIZE);
+}
+
+/* rpmi_tee_parse_*_response parse and validate the response. */
+
+static int rpmi_tee_parse_system_response(const void *data, size_t len,
+					  struct rpmi_tee_system_info *info)
+{
+	const struct rpmi_tee_probe_system_resp *resp = data;
+	u32 count;
+
+	if (len < sizeof(*resp))
+		return -EPROTO;
+
+	count = get_unaligned_le32(&resp->domain_count);
+	if (len != sizeof(*resp) + (u64)count * sizeof(__le32))
+		return -EPROTO;
+
+	info->caller_domain = get_unaligned_le32(&resp->caller_domain);
+	info->caller_endpoint = get_unaligned_le32(&resp->caller_endpoint);
+	info->domain_count = count;
+	/* Borrowed pointer, use rpmi_tee_domain_id_at() to access. */
+	info->domains = (const u8 *)data + sizeof(*resp);
+
+	return 0;
+}
+
+static int rpmi_tee_parse_domain_response(const void *data, size_t len,
+					  struct rpmi_tee_domain_info *info)
+{
+	const struct rpmi_tee_probe_domain_resp *resp = data;
+	u32 count;
+
+	if (len < sizeof(*resp))
+		return -EPROTO;
+
+	count = get_unaligned_le32(&resp->endpoint_count);
+	if (len != sizeof(*resp) + (u64)count * sizeof(__le32))
+		return -EPROTO;
+
+	info->flags = get_unaligned_le32(&resp->flags);
+	info->endpoint_count = count;
+	/* Borrowed pointer, use rpmi_tee_endpoint_id_at() to access. */
+	info->endpoints = (const u8 *)data + sizeof(*resp);
+
+	return 0;
+}
+
+static int rpmi_tee_parse_endpoint_response(const void *data, size_t len,
+					    struct rpmi_tee_endpoint_info *info)
+{
+	const struct rpmi_tee_probe_endpoint_resp *resp = data;
+	size_t remaining, service_offset;
+	u32 proxied, parcels, services;
+
+	if (len < sizeof(*resp))
+		return -EPROTO;
+
+	remaining = len - sizeof(*resp);
+	proxied = get_unaligned_le32(&resp->proxied_count);
+	parcels = get_unaligned_le32(&resp->parcel_count);
+	services = get_unaligned_le32(&resp->service_count);
+
+	/* Check both ID arrays before adding their counts. */
+	if (proxied > remaining / sizeof(__le32) ||
+	    parcels > remaining / sizeof(__le32) - proxied)
+		return -EPROTO;
+
+	service_offset = ((size_t)proxied + parcels) * sizeof(__le32);
+	remaining -= service_offset;
+	if (services > remaining / UUID_SIZE)
+		return -EPROTO;
+
+	/* Ignore metadata following the service UUID array. */
+	info->flags = get_unaligned_le32(&resp->flags);
+	info->service_count = services;
+	/* Borrowed pointer, use rpmi_tee_service_uuid_at() to get UUID. */
+	info->services = resp->data + service_offset;
+
+	return 0;
+}
+
+/* Return an owned probe response; vanished domain/endpoint IDs yield -ENOENT. */
+static int rpmi_tee_probe_info(struct rpmi_tee_transport *priv, u32 service,
+			       const void *req, size_t req_len, void **data,
+			       size_t *data_len)
+{
+	size_t resp_len = priv->mbox.max_msg_data_size;
+	s32 status;
+	int ret;
+
+	void *resp __free(kfree) = kzalloc(resp_len, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	ret = rpmi_tee_send_with_status(priv, service, req, req_len, resp,
+					&resp_len, &status);
+	if (ret)
+		return ret;
+
+	if (status == RPMI_ERR_INVALID_PARAM &&
+	    (service == RPMI_TEE_SRV_PROBE_DOMAIN ||
+	     service == RPMI_TEE_SRV_PROBE_ENDPOINT))
+		return -ENOENT;
+
+	ret = rpmi_to_linux_error(status);
+	if (ret)
+		return ret;
+
+	*data_len = resp_len;
+	*data = no_free_ptr(resp);
+
+	return 0;
+}
+
+static int rpmi_tee_add_endpoint(struct rpmi_tee_discovery *system, u32 ep_id,
+				 const struct rpmi_tee_endpoint_info *info)
+{
+	struct rpmi_tee_discovered_endpoint *ep;
+	u32 i;
+
+	/* Skip endpoints already discovered. */
+	list_for_each_entry(ep, &system->eps, node)
+		if (ep->ep_id == ep_id)
+			return 0;
+
+	ep = kzalloc(struct_size(ep, services, info->service_count), GFP_KERNEL);
+	if (!ep)
+		return -ENOMEM;
+
+	ep->ep_id = ep_id;
+	ep->service_count = info->service_count;
+	for (i = 0; i < ep->service_count; i++)
+		rpmi_tee_service_uuid_at(info, i, &ep->services[i]);
+
+	list_add_tail(&ep->node, &system->eps);
+
+	return 0;
+}
+
+/* Discover physical TEE endpoints in one domain, skipping vanished IDs. */
+static int rpmi_tee_discover_domain(struct rpmi_tee_transport *priv, u32 id,
+				    struct rpmi_tee_discovery *system)
+{
+	struct rpmi_tee_domain_info domain;
+	struct rpmi_tee_probe_domain_req req = {
+		.domain_id = cpu_to_le32(id),
+	};
+	size_t len;
+	int ret;
+	u32 i;
+
+	void *data __free(kfree) = NULL;
+
+	ret = rpmi_tee_probe_info(priv, RPMI_TEE_SRV_PROBE_DOMAIN, &req,
+				  sizeof(req), &data, &len);
+	if (ret)
+		return ret == -ENOENT ? 0 : ret;
+
+	ret = rpmi_tee_parse_domain_response(data, len, &domain);
+	/* Only TEE domains are processed. */
+	if (ret || !(domain.flags & RPMI_TEE_DOMAIN_TEE))
+		return ret;
+
+	for (i = 0; i < domain.endpoint_count; i++) {
+		u32 ep_id = rpmi_tee_endpoint_id_at(&domain, i);
+		struct rpmi_tee_endpoint_info endpoint;
+		struct rpmi_tee_probe_endpoint_req ep_req = {
+			.endpoint_id = cpu_to_le32(ep_id),
+		};
+
+		void *ep_data __free(kfree) = NULL;
+
+		ret = rpmi_tee_probe_info(priv, RPMI_TEE_SRV_PROBE_ENDPOINT,
+					  &ep_req, sizeof(ep_req), &ep_data,
+					  &len);
+		if (ret == -ENOENT)
+			continue;
+
+		if (ret)
+			return ret;
+
+		ret = rpmi_tee_parse_endpoint_response(ep_data, len, &endpoint);
+		if (ret)
+			return ret;
+
+		/* Only physical TEE endpoints are processed. */
+		if (ep_id == priv->self_id ||
+		    !(endpoint.flags & RPMI_TEE_ENDPOINT_TEE) ||
+		    !(endpoint.flags & RPMI_TEE_ENDPOINT_PHYSICAL))
+			continue;
+
+		ret = rpmi_tee_add_endpoint(system, ep_id, &endpoint);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Free all discovered endpoints and their copied service UUIDs. */
+void rpmi_tee_free_discovery(struct rpmi_tee_discovery *system)
+{
+	struct rpmi_tee_discovered_endpoint *ep, *next;
+
+	list_for_each_entry_safe(ep, next, &system->eps, node) {
+		list_del(&ep->node);
+		kfree(ep);
+	}
+}
+
+/**
+ * rpmi_tee_discover_endpoints() - Discover physical TEE endpoints and services
+ * @priv: RPMI TEE transport
+ * @system: Returned list of endpoints and their service UUIDs
+ *
+ * Obtain caller identity and walk SYSTEM, DOMAIN and ENDPOINT probes. The
+ * caller releases the entries with rpmi_tee_free_discovery() on success.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+int rpmi_tee_discover_endpoints(struct rpmi_tee_transport *priv,
+				struct rpmi_tee_discovery *system)
+{
+	struct rpmi_tee_system_info info;
+	size_t len;
+	int ret;
+	u32 i;
+
+	void *data __free(kfree) = NULL;
+
+	INIT_LIST_HEAD(&system->eps);
+	/* PROBE_SYSTEM has no request data and returns the caller's identity. */
+	ret = rpmi_tee_probe_info(priv, RPMI_TEE_SRV_PROBE_SYSTEM, NULL, 0,
+				  &data, &len);
+	if (ret)
+		return ret;
+
+	ret = rpmi_tee_parse_system_response(data, len, &info);
+	if (ret)
+		return ret;
+
+	priv->self_id = info.caller_endpoint;
+	for (i = 0; i < info.domain_count; i++) {
+		u32 domain_id = rpmi_tee_domain_id_at(&info, i);
+
+		ret = rpmi_tee_discover_domain(priv, domain_id, system);
+		if (ret) {
+			rpmi_tee_free_discovery(system);
+
+			return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/firmware/riscv_rpmi_tee/driver.c b/drivers/firmware/riscv_rpmi_tee/driver.c
index d9ae161d241b..a70b8be41bed 100644
--- a/drivers/firmware/riscv_rpmi_tee/driver.c
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -5,6 +5,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/unaligned.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/module.h>
@@ -14,6 +15,34 @@
 
 #include "rpmi_tee_private.h"
 
+/* rpmi_tee_send_with_status() - Send an RPMI TEE service request. */
+int rpmi_tee_send_with_status(struct rpmi_tee_transport *priv, u32 service_id,
+			      const void *req, size_t req_len, void *resp,
+			      size_t *resp_len, s32 *status)
+{
+	size_t max_resp_len = *resp_len;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	if (req_len > priv->mbox.max_msg_data_size ||
+	    max_resp_len > priv->mbox.max_msg_data_size)
+		return -EMSGSIZE;
+
+	rpmi_mbox_init_send_with_response(&msg, service_id, (void *)req,
+					  req_len, resp, max_resp_len);
+	ret = rpmi_mbox_send_message_sync(priv->mbox.chan, &msg);
+	if (ret)
+		return ret;
+	/* At least STATUS word should be present. */
+	if (msg.data.out_response_len < sizeof(__le32))
+		return -EPROTO;
+
+	*resp_len = msg.data.out_response_len;
+	*status = (s32)get_unaligned_le32(resp);
+
+	return 0;
+}
+
 /**
  * rpmi_tee_get_attr() - Get an RPMI mailbox attribute
  * @priv: RPMI TEE transport
diff --git a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
index b25192c5df00..ba0e7cb59b6d 100644
--- a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
+++ b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
@@ -6,12 +6,18 @@
 #ifndef _RPMI_TEE_PRIVATE_H
 #define _RPMI_TEE_PRIVATE_H
 
+#include <linux/list.h>
 #include <linux/mailbox_client.h>
 #include <linux/types.h>
+#include <linux/uuid.h>
 
 /* TEE service group and the services used by this module. */
 #define RPMI_SRVGRP_TEE		0x10
 
+#define RPMI_TEE_SRV_PROBE_SYSTEM	0x03
+#define RPMI_TEE_SRV_PROBE_DOMAIN	0x04
+#define RPMI_TEE_SRV_PROBE_ENDPOINT	0x05
+
 struct rpmi_tee_mbox {
 	struct mbox_client client;
 	struct mbox_chan *chan;
@@ -21,6 +27,42 @@ struct rpmi_tee_mbox {
 struct rpmi_tee_transport {
 	struct device *dev;
 	struct rpmi_tee_mbox mbox;
+	u32 self_id;
+};
+
+/* Report local transport errors separately from the returned RPMI status. */
+int rpmi_tee_send_with_status(struct rpmi_tee_transport *priv, u32 service_id,
+			      const void *req, size_t req_len, void *resp,
+			      size_t *resp_len, s32 *status);
+
+/**
+ * struct rpmi_tee_discovered_endpoint - Physical TEE endpoint and its services
+ * @node: Entry in &struct rpmi_tee_discovery.eps.
+ * @ep_id: Physical TEE endpoint ID.
+ * @service_count: Number of UUIDs in @services.
+ * @services: Service UUIDs for the endpoint.
+ */
+struct rpmi_tee_discovered_endpoint {
+	struct list_head node;
+	u32 ep_id;
+	u32 service_count;
+	uuid_t services[] __counted_by(service_count);
 };
 
+/**
+ * struct rpmi_tee_discovery - Discovered physical TEE endpoints and services
+ * @eps: List of &struct rpmi_tee_discovered_endpoint entries, excluding the
+ *	 caller endpoint.
+ *
+ * On successful discovery, the caller owns the entries and releases them with
+ * rpmi_tee_free_discovery(). Endpoints without services are also included.
+ */
+struct rpmi_tee_discovery {
+	struct list_head eps;
+};
+
+void rpmi_tee_free_discovery(struct rpmi_tee_discovery *system);
+int rpmi_tee_discover_endpoints(struct rpmi_tee_transport *priv,
+				struct rpmi_tee_discovery *system);
+
 #endif /* _RPMI_TEE_PRIVATE_H */

-- 
2.34.1

