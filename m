Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A1FCA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:31:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D4C8145399
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430287;
	bh=v73mMtBcOz2f+7XRtZtad6s5TQPr8J/A5tYO0+opeA8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=IYHAf0S1FNu8SzFEbQPyhao9u3zxNqUUmikWgpVvhyxlAgeFaHZMhqQd906LUrOxX
	 0bIxwbaOKTH2yowxXRyIMzFVWuvkT04FmnG0OSU6hbi0ad/j8lwwUw2dv3MsA+DPv7
	 FvNhJ6ZHczFsV1J4RWZYjuhpBkGo3hnxrJXwIl70bXFKh9WNOKCKJyH1qVfM8T9uPf
	 ND2jp9snSE0Tf+eAo/SNgopVax5NnPCW5mljBLsi5EyIIsNM4CUvclKLM8mRN2D92o
	 HxAdoQjIwD2k4xtnBRXkVSQFPNS1f1kXaEJ4M4tdLQSpK/vvmp70iw2UyhTbWwSPFW
	 xFhRlVxTwz+uA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2D3EF452C8
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m3IiWMBw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bRG7VpQr;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hKvo433693
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JYhMxhZH0dD9pA3ktR3FA82R4vBs9fV9ebvrujfapgw=; b=m3IiWMBwcGiYIz06
	Xz8k6ERhnf8dzZHjJjD97zML0i1SrmBc1eV8Cye+/qQh1ZzKtExlf5bV8ZQlZeXG
	kia9J92NKIs1NAssqhRZXfiYVr1Su/8pQHRbMGejuj/xqoVb+q02u07ZU3xmOh9B
	km4FlapaY5WJAikmofQhW9//RUbsEPl2X9y5xOYL63NdmfnWupr44Fy0MEdbyIIc
	UdI+p420NhxnAS6c9ojW8qBoPY7vPyDYHOpQhSq7uy+7pc7MKPc7ie52/WeYe1Po
	KNrNifzsemCcKdRWlMoWGD08CNrhIkXt2HrlLh7z+uY7ugr0wI3tTPcTbkshMCAv
	lk4NEA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe38uvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-351788121cfso1445102eec.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430128; x=1792034928; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JYhMxhZH0dD9pA3ktR3FA82R4vBs9fV9ebvrujfapgw=;
        b=bRG7VpQr3QUWyIgc/uPmZML1JhtFs4x+knDD9FjizVez5dLvljy2m84oGRvdBMTcMS
         nmE9O/R07nF1swUEXQATpLO0DO15uI6o3dXukKMqjH8f06v8s1PyLWpA17NW48ycNgW6
         UsWxqMp3TvpZRqH10Co0PW81UD9SmcrXsXIrTgfjTwN5omPLxM42L23DwBqiMmNK52WK
         3Fd1rkXVqHwRB5m0zHYVOJKnZa0PWGe9Wyz+LOi2Tf4yooqO0q+8km7KHJruVgD1Qvkf
         iGUyi70iZf1K9xN/8Pt/W+wfL8YArvoMGfSxKfUEZnQZFbS2WvBoOPmCwCI3xUXmcnkU
         NMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430129; x=1792034929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYhMxhZH0dD9pA3ktR3FA82R4vBs9fV9ebvrujfapgw=;
        b=NtGEE18rLtokq2eGoiXzkYUYYlmsJvhAImMrKbVtJEN9dR55dI3zIPyiv9hBjReJhU
         nW0iK5ta0YErorjVafK30qFD5nXOqVATrmVY58lPDcOVeetYpr6F9g165e2NFPepSHiY
         TElZC4lHgu56bwrvBuYtDOYzbvvqlv0mWHuGU5G55vKNkWZbIHaI5QPiIg5l+WgDry9A
         Z1EU9HqMtqq9QEPcryaf0ZsokqWmP4XMEE6oypoJPM/GBbgNl8BqJYQihFX5p2DrHKfD
         UKm0vACQoew4N98LpdtE3pGVrWhlc9BvWE9KEtiP2r/yQxTa0xBCUq3NrGw5VjL0FeaV
         BYnQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2QyB1Zd1aVLGebTJAZDj9aTwkicBr+LnG0aJC1SLc8BDmcKd3jY/QwAZPv/qU82/oft3gXsQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLuT3RI2O4GQM0OEOtz1u7E0pdybj/L5n1a19YEzUnARJWPNSdj
	vB3mvloHcspGYpzRxAGzE2u3qIsa5zywdwwZwaY2slOGOQIy14o4jcVJdDBBQrXcEwot4cDropW
	JcTIP5FpkRP2AypB0Lw7lBIrjygUweKRFwFUTjXE2/QqqFsJYSOqMeVlPj8LSJ9gWdOWrYLM=
X-Gm-Gg: AYBFou0DcKRaIiM5/MP0vIhIh63xfAa8NW2zVBvRoobZmrJZm7uOBIK49sTdSdbn0Ax
	kT8TtFj5x3jPtAdkgbs9A64vWlHmeAb2UWWD4DoBeMf9N7GVLzuT9jN+Ch1qCJru/3mZsdYms2c
	O6rqWPhOs8HecRV+rH7LrlLMONn6M5pZb9I08OJNe1DzR2eJnfW6dxdIeRmQsI9s2cHdq8uW1sC
	fC9ppcjlVMYcXIamcqCawoQVzScGCJO26GSqtyjcvXhm8XqUQIUQHz/sPx8pFybNS15H5gyWSGT
	C8jXENqo1vXY8+Ke+qFpG7DVeQtKGP2cRgKnJp3KXWJAP68o0PxvQLb3YKqQ2TbRIwHvU23TSDg
	07NgkJl7+XTXuikD3xqh9b0CjUDZ84i16Foqay3/QFcmVnD/HoQVoh+cz3g==
X-Received: by 2002:a05:7300:8808:b0:351:232c:6d79 with SMTP id 5a478bee46e88-3515dd837d6mr4640147eec.12.1791430128406;
        Wed, 07 Oct 2026 20:28:48 -0700 (PDT)
X-Received: by 2002:a05:7300:8808:b0:351:232c:6d79 with SMTP id 5a478bee46e88-3515dd837d6mr4640114eec.12.1791430127800;
        Wed, 07 Oct 2026 20:28:47 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:47 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:27:11 -0700
Subject: [PATCH RFC v2 05/10] firmware: add RPMI TEE transport core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-5-45939a13d223@oss.qualcomm.com>
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
X-Proofpoint-GUID: 9xudqIXv7IeNZ5vHY_ELLIekqqdjzkhj
X-Authority-Analysis: v=2.4 cv=QOz91QLL c=1 sm=1 tr=0 ts=6ac70df1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=0-kq_-QLXk4bkpNlR94A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX0wdVZl/ubF+u
 TBD4/QEBHhUepyesYLpr3uqHQgyKVyNjlpKh0MWVmP8vqLJxNbcUPIVo6BsW0DLaryJEBPZNBDR
 tvz59kDmfLfrEmafLNNzZBGn53SAApA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfXwwcmjUSu6XtU
 ynKS79nbECKP00+0gix8Kplv3EchdaGMVn66iQ5LwpCP6ou0XMMRvcs1q6OyyeXKyHz7TOPJpZa
 JFdFhrq8ELLpX2TFJ9/St5D1GFMabgzlYqAVlCuCzZezpHfqCdyDPhroKDv18YEcoBL4ffp68pz
 lhW9X3PncwXFUf2UjX1CxgSgAv2y068ty4nUQ4MSXIDEcqqnNK4RViXhoMMv4G1KEvmCcw4n6Rs
 IZI34kfj85RI9slcnwD/rQagPL75JSMcJBid/xxKG1yyahqEajoITdOqEspRQWnIq4BUn76Qloe
 Z1LYF21MsZ0F+sCeoXql7b8IoBy6JPS3b6A8muuFM25fDAgEGrPQM4LxwLxeYwbTHpVwM5WnrmC
 OJpwbMXkS+Q+CIb+O+9Jn6s0xSszY1KtO/oSV92Gez5WXfMpuMk75NsbWel3SMHqryVkhHqFKx6
 LT5lZuw5tG+9ylreLJg==
X-Proofpoint-ORIG-GUID: 9xudqIXv7IeNZ5vHY_ELLIekqqdjzkhj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org,oss.nxp.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2D3EF452C8
X-Spamd-Bar: ---
Message-ID-Hash: 2BKT2RS6SLNCUHUVQMURKRXLOC4M237B
X-Message-ID-Hash: 2BKT2RS6SLNCUHUVQMURKRXLOC4M237B
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2BKT2RS6SLNCUHUVQMURKRXLOC4M237B/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add a platform driver for the RPMI TEE service group using an SBI MPXY
mailbox channel. Select direct synchronous mailbox transfers so RPMI
transactions complete in the calling context.

Query mailbox attributes to check the RPMI specification version, TEE
service-group identifier and service-group version. Cache the maximum
message data size for subsequent service requests.

This establishes the transport state used by later discovery, memory,
and notification support.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/Makefile           |   3 +
 drivers/firmware/riscv_rpmi_tee/driver.c           | 133 +++++++++++++++++++++
 drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h |  26 ++++
 3 files changed, 162 insertions(+)

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
index 000000000000..d9ae161d241b
--- /dev/null
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -0,0 +1,133 @@
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
+#include "rpmi_tee_private.h"
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
diff --git a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
new file mode 100644
index 000000000000..b25192c5df00
--- /dev/null
+++ b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _RPMI_TEE_PRIVATE_H
+#define _RPMI_TEE_PRIVATE_H
+
+#include <linux/mailbox_client.h>
+#include <linux/types.h>
+
+/* TEE service group and the services used by this module. */
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
+#endif /* _RPMI_TEE_PRIVATE_H */

-- 
2.34.1

