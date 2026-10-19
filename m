Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5873CCF2DA
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 09:23:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C66144FE8
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792401811;
	bh=gV5KN5Zm7fQjcSWfwU2nH5feZRNKiCvZoszC5a2aVMQ=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=E+tcu3mfh2H2yInZ9k+e0J9gBBgIADRx2w6aShItGXMQhbuYh/zEEVoksFq95drCp
	 BFpLcE/D4hTQCGPZL7wmFfz+JGwVj6tYysrVimAwqJ4oZl9FtW36mlOcRI0mfV+Iy1
	 xvkL9GCGmRnWVctYQ3fgjPafKP3dvCTcmFnb+V5CASc+8MLPCMftKYGHRYWw39CREs
	 ew0NWVupNXnNGaN6ly/Yt8CrfcVL8PP1+CKcZfvhseg3WV1me2XQnITA6ghTiL7EV3
	 E3g5pJJkCFE3gaZ62J1KMHMAN30IKYYNMFGVRdG7s4LwmsvePhJPkEhHKfY3I6bASg
	 eIMJTu8AgveFQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 514E0452FB
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=inKBm7dA;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ihG+FJ6r;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OrL11167946
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W14KmFOdJoa7pCoAY9piALiA9RYY45QOzgo4ZT23jpM=; b=inKBm7dAhxo3XMDD
	XDpI6sm+uQc2WAH/PKy6dX9uS/Z3xrAEhLLjkTGOnDtOAINjf0oNl6I77oEgGp27
	gmc9GiXtmEVYWubJhBcnFjNFzvK0yfX0J1XW/K9kN50Fp/ktO4lUGMxR9grOtfOc
	v5Gr/Ys6mCRAv4rQuu5F5el9AUT2CY+MTxCFQRPVHGTk8yWqodTZYsl8Cr+K0Tnx
	cWVzO/ZfBbRKQiP466BU5mBe7ka3dFkA89b6Soz9+zZ8DfrV1qQdN2yutaTGWNdV
	DB+v+dDKVslwCO7jt2QEClek9KIPUITIDQF06uOGKj2idFdCFTk/wFKY8ECWJir+
	/qN+UA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8bs6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35cbea41088so3347265eec.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401745; x=1793006545; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W14KmFOdJoa7pCoAY9piALiA9RYY45QOzgo4ZT23jpM=;
        b=ihG+FJ6rlAgJVPPUHcayHps+Z54y2ZX80wWe1jMbGv0eCF89A25falv1QSA1sM3Mm5
         5yX3mZDH6YgZPPTSpN/xkNrHyZ1oLak7nSamzpzoJQV8iw4otHJASsW11+cvR3KuaduD
         ebKDcrz1C9EdPtRR3Ei1ob6lvMIX4K5Lhz3Ftwhm0kn8KdCWFvfQUPYWGS9x4n1VeQg1
         HSCcTf4vPQyDX7uQBwzBnRdGftze/UzjNPBTdIRCjrdXCuQ5WykMhLe7uv7s3+2PaOAW
         qadAOi5hNEKXizXiD4EPoxS350yIcl9DTbO7snYF7K/PTlT9ojE9TjKR1a0v+qLT+8RM
         DBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401745; x=1793006545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W14KmFOdJoa7pCoAY9piALiA9RYY45QOzgo4ZT23jpM=;
        b=2gtuH5ns2/E4Bfwg8qwE0UzbQ5UaNikqQrrxiNqCASeQQNKvKGpvP5gUA4XLpw938J
         CG37ZjIck79k1RC6CwTtPPgKeLlg0dfZ85aGjpTtZu5jBo6+dkJo4u3a6VJWsLO3uOoz
         jO/vmlbixeYGHsocLztOOyEbou21wpoOJbYcR7mDHujRrhQpLeOFfz/gnujsT4B4vH6i
         M+lj4lPUbcdSy0DDiuQYxksc4ksaXhWwmtIoDqlz0HtAESYllyjO8n91QoEm06jcFPGk
         fdG5/f8VjQwizKQzE+k6P2DQ3q4iTrxINBKkNwJ59scJHLnelCRYuPP30kq0dfhuQIVI
         ToyA==
X-Forwarded-Encrypted: i=1; AKwUvByXli/vUvV7IEgDG7BDPGfhojxmSsPTc/yGrZFUj/L12drBq1qVNC0lB7LfK9L/j6YtqLTNCK8=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLF5dOaY3DPUv1R504z6mw1Q79wLS0wEjnQ4j19kOWBmbsUrbVe
	ZvCcS07NQOw5PKDqjkLGVX0h5JspTWKfIk8jagrP2PDt1hjf8krIoCvIVYHAWXfd+KZB0a9c7Z0
	Tj7Kmtac6Ojw0DXRU9LwZkFoJa0O8Ch+nSjpuyw5oE2eXqYO3wJBXBpnBhHJ0yCS5f/1RuiYZcP
	C6Oi46
X-Gm-Gg: AYBFou3vSAH/J/SDlBsHebr0YCTUrGyH8i8E7FAyhGLiWyLfkNXtk8THU4fb7JpThzb
	+C3Vzk8tfD5Ca7b5k9YPZ0hnc63glb8MJqRyCti7g8JsvAiOpMYq/ZPwVq/eNUImB3gfMpzCMP8
	ihW+3f0xL5ZCxcwbI7dlJfLOUzKaeTOT5otdBnPSNZutaJcTxVBJrQYeqz0gX1l3rJczNpu/2Hs
	3VP4gcMdKSuiVm3UhSykYwstcW/G+NzgQ90ABSrXdviZxBqg29B3+hS4DT84ktspDNbws4OHLU6
	UKVvG5n+nEM1NmpuWaOmD2YfLC2sntZ3ZLvwCGCZ5/pJDmQodzIVlXGGSLncVIUBA1J0e5XM46R
	xEnZc6HUUjAiLaSlmAeQdnJuvNjpblAt9
X-Received: by 2002:a05:7301:4615:b0:35c:8ce0:63dc with SMTP id 5a478bee46e88-361a1f522b5mr9290319eec.20.1792401744485;
        Mon, 19 Oct 2026 02:22:24 -0700 (PDT)
X-Received: by 2002:a05:7301:4615:b0:35c:8ce0:63dc with SMTP id 5a478bee46e88-361a1f522b5mr9290296eec.20.1792401743740;
        Mon, 19 Oct 2026 02:22:23 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm56225094eec.24.2026.10.19.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:22:23 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:51:47 +0530
Subject: [PATCH v4 2/3] tpm: Introduce Qualcomm TPM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-tpm_qcom_driver-v4-2-6889b9804ba7@oss.qualcomm.com>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
In-Reply-To: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX1kUsE1rPeF37
 Dhv1e/mzkKTmdHHkbgFXGiZCZ2e/FQpBd68V7nK77JBgTV+ctzZl6ft+GGi3FfI6XfAvEG0HR7J
 dej9zIzw+JeH0fTh7QlL9ob7RF6wGSc=
X-Proofpoint-ORIG-GUID: vm4EKdGJFFFcS8AFrOm663C86UqXw6LW
X-Proofpoint-GUID: vm4EKdGJFFFcS8AFrOm663C86UqXw6LW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX8y9ZZkE4lFdL
 Rumh93c2tYOaUFs8yDUuu4OaDKuuBo4vWIZmEtR1vVBevQfrxvUObMOmGBIS6PSLTJv4s9iWEV5
 RbPYJM9TWDwDkQ0eG8DV8hc7v6YCYTlZNiHc+IgMNe5DeJ+QKBWminzDnIUAWDa3JhIqQCeEb18
 yczSmAZ8dNV3AA2BNEuxwuEe0fuArnKgbnaYB98ITty0z8BFixSFijEJfKf+rgaXNVSnx7H/XMI
 iQMM508syWB1VQfL8SO6et13FHDxIub7NCVJfEWfCf+nsPVVlHpyLMpSTdlZLX6w9/P+hfNMZmV
 iXzm0OEU+a2nqvkKVhZQU7OBXQ4UMx953ksHOyOh5CROqJkwv6Nu4rslXnZAcl7uYt6KIJrwnLP
 yeZyxmeJNnD2Dg5aYZsnydw76LgSJjshZ9ctlPUfSjCBgpn/gyzBhlukp7gp9PoCUZLGW1dFqy0
 q7agwC7nvh15AJfyVqg==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5e151 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=fRNFA8eTS_BfqSrSx7UA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 514E0452FB
X-Spamd-Bar: ------
Message-ID-Hash: L5JY7CTQZ4FK5ZJ74MO6SDBPFO7Y7ZOY
X-Message-ID-Hash: L5JY7CTQZ4FK5ZJ74MO6SDBPFO7Y7ZOY
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/L5JY7CTQZ4FK5ZJ74MO6SDBPFO7Y7ZOY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Add a TPM chip driver for platforms where a TPM 2.0 instance is
implemented by a Trusted Application (TA) running in Qualcomm's Trusted
Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
transport.

The driver discovers the qcom.tz.tpm TEE-bus device, opens a session
with the TPM TA, and register with tpm interface. This exposes the TA
through the standard /dev/tpm interface and the existing tpm2 command
layer. OS need not be aware underlying TPM instance is dTPM or fTPM.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/char/tpm/Kconfig    |   9 +
 drivers/char/tpm/Makefile   |   1 +
 drivers/char/tpm/tpm_qcom.c | 414 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 424 insertions(+)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 5f672f2c01b0..05d704ed3632 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -243,6 +243,15 @@ config TCG_FTPM_TEE
 	help
 	  This driver proxies for firmware TPM running in TEE.
 
+config TCG_QCOM
+	tristate "Qualcomm TEE based TPM Interface"
+	depends on QCOMTEE
+	help
+	  This driver provides interface to run TPM instances with Trustzone
+	  having Qualcomm TPM TA running in Qualcomm TEE.
+	  The mechanism uses the object-IPC based transport provided by
+	  QCOMTEE.
+
 config TCG_SVSM
 	tristate "SNP SVSM vTPM interface"
 	depends on AMD_MEM_ENCRYPT
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 5b5cdc0d32e4..471cbf49afd2 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -45,5 +45,6 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_QCOM) += tpm_qcom.o
 obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
 obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
diff --git a/drivers/char/tpm/tpm_qcom.c b/drivers/char/tpm/tpm_qcom.c
new file mode 100644
index 000000000000..e9e4746f0004
--- /dev/null
+++ b/drivers/char/tpm/tpm_qcom.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/tee.h>
+#include <linux/tee_drv.h>
+#include <linux/tpm.h>
+#include <linux/uuid.h>
+
+#include "tpm.h"
+
+#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS	5
+#define QCOMTEE_OP_CLIENT_ENV_OPEN		0
+#define QCOMTEE_MSG_OBJECT_OP_MASK		GENMASK(15, 0)
+#define QCOMTEE_MSG_OBJECT_OP_RELEASE		(QCOMTEE_MSG_OBJECT_OP_MASK - 0)
+
+#define QCOMTEE_TPM_OP_SEND_COMMAND	0
+
+/* UID of the "qcom.tz.tpm" service */
+#define QCOMTEE_TPM_UID			81
+
+/* Max buffer size supported by TPM TA */
+#define TPM_QCOM_MAX_COMMAND_SIZE	SZ_4K
+#define TPM_QCOM_MAX_RESPONSE_SIZE	SZ_4K
+
+#define QCOMTEE_TPM_GET_TA_VERSION_ID	0x0001000
+#define QCOMTEE_TPM_TA_VERSION_MAJOR	GENMASK(31, 16)
+#define QCOMTEE_TPM_TA_VERSION_MINOR	GENMASK(15, 0)
+
+struct tpm_qcom_ta_version_req {
+	u32 command_id;
+} __packed;
+
+struct tpm_qcom_ta_version_resp {
+	u32 status;
+	u32 command_id;
+	u32 version_num;
+} __packed;
+
+#define QCOMTEE_TPM_TYPE_ID		0x0080000
+#define QCOMTEE_TPM_TYPE_DTPM		0x6454504dU
+#define QCOMTEE_TPM_TYPE_FTPM		0x6654504dU
+#define QCOMTEE_TPM_TYPE_NONE		0x4e6f6e65U
+
+struct tpm_qcom_type_req {
+	u32 command_id;
+} __packed;
+
+struct tpm_qcom_type_resp {
+	u32 command_id;
+	u32 status;
+	u32 tpm_type;
+} __packed;
+
+/*
+ * dTPM SPI transfer optimization:
+ * TRANSFER_START before a burst of commands, TRANSFER_END once done.
+ */
+#define QCOMTEE_TPM_TRANSFER_ID		0x0000002
+#define QCOMTEE_TPM_TRANSFER_END	0
+#define QCOMTEE_TPM_TRANSFER_START	1
+
+struct tpm_qcom_transfer_req {
+	u32 command_id;
+	u32 transfer_state;
+} __packed;
+
+struct tpm_qcom_transfer_resp {
+	u32 command_id;
+	u32 status;
+} __packed;
+
+struct tpm_qcom_private {
+	struct tpm_chip *chip;
+	struct device *dev;
+	struct tee_context *ctx;
+	struct tee_param_objref tpm_svc_obj;
+	bool is_dtpm;
+};
+
+/* UUID of the QTEE-bus device representing the TPM TA. */
+static const uuid_t tpm_qcom_uuid =
+	UUID_INIT(0xaabcb593, 0x7083, 0x5536,
+		  0xac, 0x27, 0x3d, 0x2d, 0x89, 0x41, 0x9d, 0xdb);
+
+static void tpm_qcom_release_object(struct tee_context *ctx,
+				    struct tee_param_objref object)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg = {};
+
+	inv_arg.id = object.id;
+	inv_arg.op = QCOMTEE_MSG_OBJECT_OP_RELEASE;
+	inv_arg.num_params = 0;
+
+	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
+}
+
+static int tpm_qcom_get_client_env_obj(struct device *dev,
+				       struct tee_context *ctx,
+				       struct tee_param_objref *client_env_obj)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg = {};
+	struct tee_param param[2] = {};
+	int ret;
+
+	inv_arg.id = TEE_OBJREF_NULL;
+	inv_arg.op = QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS;
+	inv_arg.num_params = 2;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT;
+	param[0].u.objref.id = TEE_OBJREF_NULL;
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
+
+	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "get client env obj failed: ret=%d, invoke_ret=0x%x\n",
+			ret, inv_arg.ret);
+		return -EINVAL;
+	}
+
+	*client_env_obj = param[1].u.objref;
+	return 0;
+}
+
+static int tpm_qcom_get_svc_obj(struct device *dev,
+				struct tee_context *ctx,
+				struct tee_param_objref client_env_obj,
+				struct tee_param_objref *tpm_svc_obj)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg = {};
+	struct tee_param param[2] = {};
+	u32 tpm_uid = QCOMTEE_TPM_UID;
+	int ret;
+
+	inv_arg.id = client_env_obj.id;
+	inv_arg.op = QCOMTEE_OP_CLIENT_ENV_OPEN;
+	inv_arg.num_params = 2;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
+	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &tpm_uid,
+						    .size = sizeof(tpm_uid) };
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
+
+	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "get TPM service obj failed: ret=%d, invoke_ret=0x%x\n",
+			ret, inv_arg.ret);
+		return -EINVAL;
+	}
+
+	*tpm_svc_obj = param[1].u.objref;
+	return 0;
+}
+
+static int tpm_qcom_send_command(struct tpm_qcom_private *pvt_data,
+				 void *req, size_t req_len, void *resp,
+				 size_t *resp_len)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg = {};
+	struct tee_param param[3] = {};
+	u8 locality_arg = 0;
+	int ret;
+
+	inv_arg.id = pvt_data->tpm_svc_obj.id;
+	inv_arg.op = QCOMTEE_TPM_OP_SEND_COMMAND;
+	inv_arg.num_params = 3;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
+	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &locality_arg,
+						   .size = sizeof(locality_arg) };
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
+	param[1].u.ubuf = (struct tee_param_ubuf){ .addr = req, .size = req_len };
+	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT;
+	param[2].u.ubuf = (struct tee_param_ubuf){ .addr = resp, .size = *resp_len };
+
+	ret = tee_client_object_invoke_func(pvt_data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(pvt_data->dev,
+			"send_command invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: -EINVAL;
+	}
+
+	*resp_len = param[2].u.ubuf.size;
+
+	return 0;
+}
+
+static int tpm_qcom_get_ta_details(struct tpm_qcom_private *pvt_data)
+{
+	struct tpm_qcom_ta_version_req ver_req = {
+		.command_id = QCOMTEE_TPM_GET_TA_VERSION_ID,
+	};
+	struct tpm_qcom_ta_version_resp ver_resp;
+	size_t resp_len = sizeof(ver_resp);
+	struct tpm_qcom_type_req type_req = {
+		.command_id = QCOMTEE_TPM_TYPE_ID,
+	};
+	struct tpm_qcom_type_resp type_resp;
+	int ret;
+
+	ret = tpm_qcom_send_command(pvt_data, &ver_req, sizeof(ver_req),
+				    &ver_resp, &resp_len);
+	if (ret < 0 || resp_len < sizeof(ver_resp) || ver_resp.status != 0)
+		return ret ?: -EIO;
+
+	dev_info(pvt_data->dev, "TPM TA version %u.%u\n",
+		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MAJOR, ver_resp.version_num),
+		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MINOR, ver_resp.version_num));
+
+	resp_len = sizeof(type_resp);
+	ret = tpm_qcom_send_command(pvt_data, &type_req, sizeof(type_req),
+				    &type_resp, &resp_len);
+	if (ret < 0 || resp_len < sizeof(type_resp) || type_resp.status != 0)
+		return ret ?: -EIO;
+
+	switch (type_resp.tpm_type) {
+	case QCOMTEE_TPM_TYPE_FTPM:
+		dev_info(pvt_data->dev, "TPM type: fTPM\n");
+		pvt_data->is_dtpm = false;
+		break;
+	case QCOMTEE_TPM_TYPE_DTPM:
+		dev_info(pvt_data->dev, "TPM type: dTPM\n");
+		pvt_data->is_dtpm = true;
+		break;
+	default:
+		dev_err(pvt_data->dev, "unsupported TPM type: 0x%08x\n",
+			type_resp.tpm_type);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* fTPM does not implement this command and to be invoked via dtpm only. */
+static void tpm_qcom_transfer(struct tpm_qcom_private *pvt_data,
+			      u32 transfer_state)
+{
+	struct tpm_qcom_transfer_req req = {
+		.command_id = QCOMTEE_TPM_TRANSFER_ID,
+		.transfer_state = transfer_state,
+	};
+	struct tpm_qcom_transfer_resp resp;
+	size_t resp_len = sizeof(resp);
+
+	tpm_qcom_send_command(pvt_data, &req, sizeof(req), &resp, &resp_len);
+}
+
+static int tpm_qcom_cmd_ready(struct tpm_chip *chip)
+{
+	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+
+	if (pvt_data->is_dtpm)
+		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_START);
+
+	return 0;
+}
+
+static int tpm_qcom_go_idle(struct tpm_chip *chip)
+{
+	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+
+	if (pvt_data->is_dtpm)
+		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_END);
+
+	return 0;
+}
+
+/*
+ * The raw TPM2 command in @buf is sent directly as send_command's UBUF-in
+ * param and the raw TPM2 response is read back from its UBUF-out param.
+ */
+static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			 size_t cmd_len)
+{
+	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+	struct tpm_header *header = (struct tpm_header *)buf;
+	size_t resp_len = PAGE_ALIGN(TPM_QCOM_MAX_RESPONSE_SIZE);
+	size_t copy_len;
+	int ret;
+
+	if (cmd_len > TPM_QCOM_MAX_COMMAND_SIZE) {
+		dev_err(&chip->dev, "len=%zd exceeds TPM_QCOM_MAX_COMMAND_SIZE\n",
+			cmd_len);
+		return -EIO;
+	}
+
+	u8 *response __free(kfree) = kzalloc(resp_len, GFP_KERNEL);
+	if (!response)
+		return -ENOMEM;
+
+	ret = tpm_qcom_send_command(pvt_data, buf, cmd_len, response, &resp_len);
+	if (ret < 0) {
+		dev_err(&chip->dev, "TPM command failed: cmd_len=%zu, tpm_cc=0x%08x, ret:%d\n",
+			cmd_len, be32_to_cpu(header->ordinal), ret);
+		return ret;
+	}
+
+	copy_len = min_t(size_t, bufsiz, resp_len);
+	memcpy(buf, response, copy_len);
+
+	return copy_len;
+}
+
+static const struct tpm_class_ops tpm_qcom_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.send = tpm_qcom_send,
+	.cmd_ready = tpm_qcom_cmd_ready,
+	.go_idle = tpm_qcom_go_idle,
+};
+
+static int tpm_qcom_ctx_match(struct tee_ioctl_version_data *ver,
+			      const void *data)
+{
+	return (ver->impl_id == TEE_IMPL_ID_QTEE);
+}
+
+static int tpm_qcom_probe(struct tee_client_device *tee_dev)
+{
+	struct device *dev = &tee_dev->dev;
+	struct tpm_qcom_private *pvt_data;
+	struct tee_param_objref client_env_obj;
+	struct tee_param_objref tpm_svc_obj;
+	struct tpm_chip *chip;
+	int err;
+
+	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
+	if (!pvt_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, pvt_data);
+
+	pvt_data->ctx = tee_client_open_context(NULL, tpm_qcom_ctx_match, NULL, NULL);
+	if (IS_ERR(pvt_data->ctx))
+		return -ENODEV;
+
+	err = tpm_qcom_get_client_env_obj(dev, pvt_data->ctx, &client_env_obj);
+	if (err)
+		goto out_ctx;
+
+	err = tpm_qcom_get_svc_obj(dev, pvt_data->ctx, client_env_obj, &tpm_svc_obj);
+	/* Release client_env object irrespective of service obj return status */
+	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
+	if (err)
+		goto out_ctx;
+
+	pvt_data->tpm_svc_obj = tpm_svc_obj;
+	pvt_data->dev = dev;
+
+	err = tpm_qcom_get_ta_details(pvt_data);
+	if (err)
+		goto out_svc_obj;
+
+	chip = tpmm_chip_alloc(dev, &tpm_qcom_ops);
+	if (IS_ERR(chip)) {
+		dev_err(dev, "tpmm_chip_alloc failed\n");
+		err = PTR_ERR(chip);
+		goto out_svc_obj;
+	}
+
+	pvt_data->chip = chip;
+	dev_set_drvdata(dev, pvt_data);
+	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
+
+	err = tpm_chip_register(pvt_data->chip);
+	if (err) {
+		dev_err(dev, "tpm_chip_register failed with rc=%d\n", err);
+		goto out_svc_obj;
+	}
+
+	return 0;
+
+out_svc_obj:
+	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
+
+out_ctx:
+	tee_client_close_context(pvt_data->ctx);
+	return err;
+}
+
+static void tpm_qcom_remove(struct tee_client_device *tee_dev)
+{
+	struct tpm_qcom_private *pvt_data = dev_get_drvdata(&tee_dev->dev);
+
+	tpm_chip_unregister(pvt_data->chip);
+	tpm_qcom_release_object(pvt_data->ctx, pvt_data->tpm_svc_obj);
+	tee_client_close_context(pvt_data->ctx);
+}
+
+static const struct tee_client_device_id tpm_qcom_id_table[] = {
+	{ tpm_qcom_uuid },
+	{}
+};
+MODULE_DEVICE_TABLE(tee, tpm_qcom_id_table);
+
+static struct tee_client_driver tpm_qcom_driver = {
+	.id_table	= tpm_qcom_id_table,
+	.probe		= tpm_qcom_probe,
+	.remove		= tpm_qcom_remove,
+	.driver		= {
+		.name	= "tpm_qcom",
+	},
+};
+
+module_tee_client_driver(tpm_qcom_driver);
+
+MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
+MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1

