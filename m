Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C71CA5FA1
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:20:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E2985454BB
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790652026;
	bh=oTy1duB6jN3k5Bp37ZNFZXzeLVSqBJv4Ke1sGvrI5PY=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3FxENfPWr0cdNwxAwYZpNUnViYA7jBltKdulPMBSudPabGJEQNea+QvYbsrB/ARnA
	 DJ3KJtmpTnhPV2Lf5NY42XW+oZdpsHq1iijNpmmfC3CvpAj/rU6rXEd4cinxGAQt7Z
	 CVOwy/zX6QFaL2fxxGwZRJW3bp8Ayuuaj6Om5rDOx5wpdVkn2yTQ1FaQwsOGEGC1uq
	 IxbjO1ejTKLKN9dP4aAHh4K9GwGPXM3aYw/IFuC5eP6OXlHFTwZ6ec2GNE2zPmNJTg
	 E1emlrN1YD/1qvHATIcHqHHTBE2EZGK+c5zj8X69CEZ8i+g1weUdSV/74AIeebQvil
	 5AME9iDpNzxMA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 23E44454FA
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KeU2pJTo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a9ebMwj0;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0iZki4179692
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aCUHYK+w4BDMVrp4w2bXUwotIcGHHJCYmu108KdLKKU=; b=KeU2pJToCBgVGDtb
	l2KtoBHgPRgiyunO+KHMzrEeKafoEfIOX9XBJlls+lJA8/9RnSnaT8FxYIkUaWHI
	WIL4u2//qOjR4SSqyhDLWPSe7s+xQ437Uu9cYmLky4D7sSdkZK44A+OEVBizZ9Ro
	aCEwd24IZ7zouG9puTvNgf0TyjVbtTuUYHgQOx/x6aZj0oaKwi5zJgi9X9Ms34Qk
	gLJcHOWOMCb/pp9bJ2EseOB0REnbRAwvXiu7gtUg1cZgb1Mxp7fx6MBylgG77/Cn
	783E9shzCBqnHN9B0eNA84bYh/CwBJqajdnDWNF76DpWfTDyioMpyGF8MYpkLUmd
	uqjFTw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyxmu9c58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3425098ae4bso611294eec.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 20:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790651871; x=1791256671; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aCUHYK+w4BDMVrp4w2bXUwotIcGHHJCYmu108KdLKKU=;
        b=a9ebMwj0tKYHgO3SpVrc18+m4yKGGe0amWVax0oLr3FntRiiwR0SPK+4Gdc57LliNn
         Ajd/clRaqpdG5QjvpPwBLvEB9Bfx1TPfc1XO4EnaVT+SZOOGCV2dUlbPEWZDE7dNLXUx
         EQhmHYU4cuBq+yRxQRarleOXbfcpPgPZIUCGjxE8UZInrx0uqbUKlzUVi5IYBYcOMgze
         qJ6KFXj12Rd+aNnYZbHCiUARMULmCNz6f8kYoYNEm+Bmt74UjbMN3Kshlf0C2sGcI/+B
         Ngxh0rvev06MtjsHoSlcjdb6lmQA64MBKQ1A9D/rQu/z2+5E2wMOtpE0CJs5SM11oWLl
         tYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651871; x=1791256671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCUHYK+w4BDMVrp4w2bXUwotIcGHHJCYmu108KdLKKU=;
        b=LQ3BPmy7ZfJj7LyApuQhQQY6cIFO/qf3RTVrC8uRnFGOD71afvckjvXmwXyqci+hLY
         SNf9152C0N37xL8yBpCusjHkPKkYEjm5qLb4n4N7FiWRYXk1c05aT7PlWnf1yxJdsDqk
         kx47OF6XfJUpKU7a9CFaMOO92w81sR+hf1MhaJV6dHv3dG4becxmeI7a8vSXz6eZWAwu
         sAV+Fpz2tdsx+K8NzXn6twcFAYwarevqxaT8KdLTDQ7sSCSFE8CvyXPtz5fxGR1CH7VI
         BUTSduge2eSL+KOB2/i5l4E++JRjzAGFhNsdfxpE4jJK6HCCJ6v/kErOkRdRpeuVS+W1
         P2Gw==
X-Forwarded-Encrypted: i=1; AKwUvBz+xyUzO1XIZmtiVdmqLGrjUf50AMvvSewTt+WnTP35a4tZZBXcScIvw1Zqxse1bJN29GgBLTk=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++muKtcJgXkqqxhSKBq21EBCxqsZtjSJn6MZKS6h9RMLthIHg74x
	9vsQ/3tXYeSQvmAsNmx0k667gAo52Jj5UnfltFUX/eYBSnNXweSGg3ei9zIiQ3C6VQcupL6Jo8U
	103hG9C4UZzar9VmxQCzp+rYJm0RcUFXApKPsXVNtMevUzTqjCsvfhFYNFmuYLNb0VjLPB2w=
X-Gm-Gg: AYBFou1ZizbE2sdY3vCnrmj0Y/V1dBvo6AGQiLNBrb0wyBxNMdbH848CreLWJPUp7vH
	pQZtJ3wO5yuvPy9usYscfvT8mWK8ITals14A0xX+awRzEYdn//LnjMp9mj1EC1zdo5zGC5Le+uK
	hMUOdqMNFme02n3GZykJm3l5Jg6PXZ9I9k9xVI9YSV683oa5darqP1nMIe5D5on3FcR0XKIGzl7
	LzWX47NYlc9D0EkgqavuX4YAecqUeJ+rO0Zp84spPTSGcAtbNRinFzzSQ6j4bvcljZVofBbOCJW
	LOpHNkKsCaSRwdCBQ2109b771RJt4fQGzONckaCdOwvyEl+bSHYGRrLirL4up0ecuj0xfkfQjQ4
	x7HgezBVc0h3UKQDOinpscUf32Wcqo1t2PvOECc99MgnRQJuVTFL0+AEowqs=
X-Received: by 2002:a05:701b:424f:20b0:136:4bbe:9524 with SMTP id a92af1059eb24-14b2df6149dmr1530578c88.10.1790651871191;
        Mon, 28 Sep 2026 20:17:51 -0700 (PDT)
X-Received: by 2002:a05:701b:424f:20b0:136:4bbe:9524 with SMTP id a92af1059eb24-14b2df6149dmr1530549c88.10.1790651870575;
        Mon, 28 Sep 2026 20:17:50 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm24789368c88.11.2026.09.28.20.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:17:50 -0700 (PDT)
Date: Mon, 28 Sep 2026 20:16:56 -0700
Subject: [PATCH RFC 05/10] firmware: add RPMI TEE transport core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-riscv-rpmi-tee-abi-v1-5-04908b81d885@oss.qualcomm.com>
References: <20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com>
In-Reply-To: <20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>,
        Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amirreza Zarrabi <amrzar@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfXzD4ge0zsdKsi
 msYVdaqofRey0Ak5IQYyidk0HL8hdFyprRuAjOGrEvvtF14mez6csrbVP/PnRIhUFK79QxvVULf
 SvkwV9BVmlFEwxxsNPiSODkYh0A0VXbdDYgPH/jU8PN2gK5MF/NeBOVaUghxwnXp/xasK8h/BDa
 ZqiCnolf9pkgmiVh9NIDMSyfBOIjQMaYwih+LHeOydbQG6LsDAF7Os1oXwJltRzrPyV6nPwDu2f
 Th/GfDxTOn4LjDcrfJNbVGpKqSr8FEx8bO9JLC3bapB5w/oJkUr4fm4AgbRwOcypPeHvmWQZo7a
 iVVP4M+4tSJXdiKC+ki0eI5zU6WEYm2RCzrd7MupzYSCJ5pEQtV6BhCQ7Z65UEOGZt6lfcbnrHb
 G29rZrm/mTJIQJzid36S+AVTRbakrdKgALqrp8OGlnu0W34FJVc7dIxaBFQGO4hsIKdmBDgPrdM
 oI6032CnrV0WtiOoJEQ==
X-Proofpoint-GUID: 4zqeLT70rI9Z6w-Sp2s28J820q-U7kUV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfXwbp4ZgOjW/Cp
 lP67s+BlPAaaym40fEYA1l1Zi/CGRT/lgO9cXOA5382B6lgH7NcwYRueNnkOe78XBNqddgjTdXe
 aiKd3AHJGUbpAI/ms1l0qihMYX4WVR4=
X-Proofpoint-ORIG-GUID: 4zqeLT70rI9Z6w-Sp2s28J820q-U7kUV
X-Authority-Analysis: v=2.4 cv=c70+0h9l c=1 sm=1 tr=0 ts=6abb2ddf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 23E44454FA
X-Spamd-Bar: ----
Message-ID-Hash: E347SZPLES4WZF2JLCZUDY3EWVJ7ETFF
X-Message-ID-Hash: E347SZPLES4WZF2JLCZUDY3EWVJ7ETFF
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/E347SZPLES4WZF2JLCZUDY3EWVJ7ETFF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add the RISC-V RPMI TEE platform driver and bind it to a direct
synchronous mailbox channel via tx_sync.

Before retaining the channel, validate the RPMI spec version, the
TEE service-group identifier and version, and cache the negotiated
maximum message data size, so later discovery, memory, and
notification support can rely on a checked transport.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/Makefile |   3 +
 drivers/firmware/riscv_rpmi_tee/driver.c | 144 +++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/drivers/firmware/riscv_rpmi_tee/Makefile b/drivers/firmware/riscv_rpmi_tee/Makefile
index d80ab5bc9dc4..8984127535ed 100644
--- a/drivers/firmware/riscv_rpmi_tee/Makefile
+++ b/drivers/firmware/riscv_rpmi_tee/Makefile
@@ -3,3 +3,6 @@
 rpmi-tee-bus-y = bus.o
 rpmi-tee-core-objs := $(rpmi-tee-bus-y)
 obj-$(CONFIG_RISCV_RPMI_TEE_TRANSPORT) = rpmi-tee-core.o
+rpmi-tee-driver-y = driver.o
+rpmi-tee-module-objs := $(rpmi-tee-driver-y)
+obj-$(CONFIG_RISCV_RPMI_TEE_TRANSPORT) += rpmi-tee-module.o
diff --git a/drivers/firmware/riscv_rpmi_tee/driver.c b/drivers/firmware/riscv_rpmi_tee/driver.c
new file mode 100644
index 000000000000..633dba116584
--- /dev/null
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RISC-V RPMI TEE transport
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/mailbox_client.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rpmi_tee.h>
+
+#define RPMI_SRVGRP_TEE		0x10
+
+struct rpmi_tee_mbox {
+	struct mbox_client client;
+	struct mbox_chan *chan;
+	u32 max_msg_data_size;
+};
+
+struct rpmi_tee_transport {
+	struct device *dev;
+	struct rpmi_tee_mbox mbox;
+};
+
+/**
+ * rpmi_tee_get_attr() - Get an RPMI mailbox attribute
+ * @priv: RPMI TEE transport
+ * @id: Attribute identifier
+ * @value: Returned attribute value
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int rpmi_tee_get_attr(struct rpmi_tee_transport *priv,
+			     enum rpmi_mbox_attribute_id id, u32 *value)
+{
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_get_attribute(&msg, id);
+	ret = rpmi_mbox_send_message_sync(priv->mbox.chan, &msg);
+	if (ret)
+		return ret;
+
+	*value = msg.attr.value;
+
+	return 0;
+}
+
+/* Validate the RPMI mailbox transport and cache its message size. */
+static int rpmi_tee_check_transport(struct rpmi_tee_transport *priv)
+{
+	u32 value;
+	int ret;
+
+	ret = rpmi_tee_get_attr(priv, RPMI_MBOX_ATTR_SPEC_VERSION, &value);
+	if (ret)
+		return ret;
+	if (value < RPMI_MKVER(1, 0))
+		return -EPROTONOSUPPORT;
+
+	ret = rpmi_tee_get_attr(priv, RPMI_MBOX_ATTR_SERVICEGROUP_ID, &value);
+	if (ret)
+		return ret;
+	if (value != RPMI_SRVGRP_TEE)
+		return -ENODEV;
+
+	ret = rpmi_tee_get_attr(priv, RPMI_MBOX_ATTR_SERVICEGROUP_VERSION,
+				&value);
+	if (ret)
+		return ret;
+	if (value < RPMI_MKVER(1, 0))
+		return -EPROTONOSUPPORT;
+
+	ret = rpmi_tee_get_attr(priv, RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE, &value);
+	if (ret)
+		return ret;
+
+	priv->mbox.max_msg_data_size = value;
+
+	return 0;
+}
+
+static int rpmi_tee_transport_probe(struct platform_device *pdev)
+{
+	struct rpmi_tee_transport *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+	priv->mbox.client.dev = &pdev->dev;
+	priv->mbox.client.tx_sync = true;
+	priv->mbox.chan = mbox_request_channel(&priv->mbox.client, 0);
+	if (IS_ERR(priv->mbox.chan))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->mbox.chan),
+				     "failed to request mailbox channel\n");
+
+	ret = rpmi_tee_check_transport(priv);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret,
+			      "invalid RPMI TEE mailbox channel\n");
+		goto out_failed;
+	}
+
+	return 0;
+
+out_failed:
+	mbox_free_channel(priv->mbox.chan);
+
+	return ret;
+}
+
+static void rpmi_tee_transport_remove(struct platform_device *pdev)
+{
+	struct rpmi_tee_transport *priv = platform_get_drvdata(pdev);
+
+	mbox_free_channel(priv->mbox.chan);
+}
+
+static const struct of_device_id rpmi_tee_transport_match[] = {
+	{ .compatible = "riscv,rpmi-tee" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpmi_tee_transport_match);
+
+static struct platform_driver rpmi_tee_transport_driver = {
+	.probe = rpmi_tee_transport_probe,
+	.remove = rpmi_tee_transport_remove,
+	.driver = {
+		.name = "riscv-rpmi-tee",
+		.of_match_table = rpmi_tee_transport_match,
+	},
+};
+
+module_platform_driver(rpmi_tee_transport_driver);
+
+MODULE_DESCRIPTION("RISC-V RPMI TEE service group transport");
+MODULE_LICENSE("GPL");

-- 
2.34.1

