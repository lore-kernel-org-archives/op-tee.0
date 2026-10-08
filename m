Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF21CA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:33:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AF889454F8
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430438;
	bh=JnNvI0ROVbZ4/iBbuzrOguXx3ENoG4ZYua0GfS7sBNM=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mNR3P9Zy7FxajnCJgXLvKIM2Pje7e0vxfES9Gqk90mY3jK51WEhoeQpygoAuUva26
	 RjR1D4MaXQkH/v3nPDZBJnl7yKcveJVEaUb60H5SYUcjz98FLfJrIed7hFAFN07Nh9
	 1cpWPq+KUNtzsEYVejtFPbI6vV/HrwU/5RnVRNMmHOwgbS78/1J4v16OoLsRCNswmZ
	 RlWn5vfy6O9NTUebGlHtL1GJmZlSspGDwueeDQirWpE8joN3uhbekOF/UhqAuIC9vC
	 pEYBG9UvMSvvS4Re8izq14H3HlaCwsIL80xd+EjP1QklNK9rjqzcRKfPmRTrJkPof8
	 NpoDRtDigFlvA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C7A7D4553A
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UmN1Kj39;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fkL71TAP;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hbAL2452535
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	duFdmTXcDjkm0mujzzm2BSo2d/76Xz98Eq27N7LBrpw=; b=UmN1Kj39mbehwriA
	Ug0JKty17Yr/zLu0eh2x0dvnrR0VyhZsQbBMKI6AvDfWP8gus6kXeti5nGLvXJDl
	KIO5qkWGbhH3NiJWXPHx4sltIVmIhBK4dBuJFv4S6WGoLKytM29YP9Ei1i4h455/
	fBDvVGL/wCdMJYZPE0JOvPdSnvFC0E97LwYfCVzkmy0SlVqAjVwNkcOGall7ZNzc
	6UVTBMilTTW+bvJPZy/OqQOghM1eNumFGZf5q8XWjTc0iWsMvOS3TAbKIPnqzCyr
	fXDBSXd8PefYb5el0Z4NPPZOCJmOHyXTB1yuaffdIAEdDV9ruQ3E8u6WQEpHqvmf
	NbDryg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe68w8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so10411647eec.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430136; x=1792034936; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=duFdmTXcDjkm0mujzzm2BSo2d/76Xz98Eq27N7LBrpw=;
        b=fkL71TAPUs7GC1r2Gf7+0g0TtiQguJ+7etyXqjkNeEeBqqTdhEdnE778sZh46b/Lnb
         cOhNjdG0s0i6tM4qQ6L+TymmMX5f+doXa3SXPmqSB7oakVLVK7koUn8iHuqBACFla+CE
         64EbPXc4qzpx4RRgbXQJZUB4gP7XkOhAyAzzGwfpv/FdoLxthfpahXqxYi6XmWqnaB0I
         RGNJGEoGG8O3M+QstaVpTde5ujLRpCc337VgX5dycTBZTWtuWEcom7chNqXvy2/l+Ag/
         kp/KTcBdwhVNdSRgwotfRXY6kuF649KD+wdaDUvgJ7Ih22YJoS3IICDaFOAIikB7rIXM
         5C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430136; x=1792034936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duFdmTXcDjkm0mujzzm2BSo2d/76Xz98Eq27N7LBrpw=;
        b=gTF6JzMG6YrERxza96dAS0jun9xG9+4YERAnwNJ2N0OPffhbtG2wmhHwJJI2Y1HCQs
         P19Als3n9ZS0V7x7k+yu13YAHzqxKj9QHn80bYRAOZWCvlLHY+U3cDkTa5JcguoedAlK
         PmR1iCzov3XE4duAxUSVrlm31cDnrxzCUI0Pqr5GMwONJ0fPTjkg0OxblV9kUeyrUpiD
         LgraE5wWfkIjLwi+XdNtQoQH/qHq1HyScfTPtkhAiqpjo2+1z2ELugWjYarwdLuKjJZO
         0QcmOqO3+xzF3tHbLyPFPbYtVSm7Vq6tI77I6rgDBZb7BJMBEuQeRbgzkCEH3NZEawdO
         iR2Q==
X-Forwarded-Encrypted: i=1; AKwUvBx5j9VTdY9euqbGzAz+KMNMmoMBfhVS6mgQUT9sefbYRfGpLQ3FrL9NSCyLSHHmnA1SwDf18tE=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLYPaFvnGFtMV1y1pndjxurMexvYwShPtnNJwMT6f3/2JavYOgP
	nHimeMrxHiUaBypL+oUTJ6TJzIyAFoQYIYFWkrED5jM/yzkCG/aP85wWWkebBQYRDHPi8r6t/bG
	gO4UlQMWlruxjd3esNLwP4Thok4pZafxsm0iOGNFB6a1awvB7h9KOX6KmO+R/AhkYzz2q02w=
X-Gm-Gg: AYBFou0eAI1+8vKgfOpISWnvDd/psCTgHIQ12WslQvsLrVDyDdzDFxeo/Td1WIZqf/F
	BUVGIydoKrgHPmvIJA8uqTlQw2mQQypjdfrKbQ0yMN5WnOYPVxtU1BRj6ZnpRgjgM8h4m8ekqif
	RsxXyXJlXsbdlwk8jzWc15Wdy8AqKrCdbkamwVmxl/BnwYXkhr/b7pskJlwIiYF2SeIOGfIWtZX
	sU0ao6Vs64wOpM98PBETrwG/ScaN7xG6PjAQTWM3aoqKKFnN4tLuK7N8nm6MZptkoZEa4/QvFT5
	YGfrdaA72uKnNUb0kav9+uB+kNAPZ+gCQcc8HPSGyHT/QdA40uf1lMEkxiBzt9KfS8xar9D1Xw/
	OQrhccRIH0HPrTjlkHqCWnlhizdiUOAqwVU18d+Gj1VaGYuehKNqDFrGitA==
X-Received: by 2002:a05:7301:670a:b0:351:595:750b with SMTP id 5a478bee46e88-3515dec9a10mr8252565eec.36.1791430135209;
        Wed, 07 Oct 2026 20:28:55 -0700 (PDT)
X-Received: by 2002:a05:7301:670a:b0:351:595:750b with SMTP id 5a478bee46e88-3515dec9a10mr8252508eec.36.1791430134484;
        Wed, 07 Oct 2026 20:28:54 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:53 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:27:16 -0700
Subject: [PATCH RFC v2 10/10] firmware: riscv: rpmi-tee: add signal bus
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-10-45939a13d223@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: qoJFQ8zJrzBwiGEGQfQjYhz8y3aPjIFN
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac70df8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=mv-pW7Q0PFkwfj-mGbgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: qoJFQ8zJrzBwiGEGQfQjYhz8y3aPjIFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfXzLU8cBZhf5DJ
 Yr6RFOYREQHyWhMqZy6Sgj1sKY/OKvl8hdW08ywJyYT3Vb13Ts6wSlsYa/NR5FBdiBc011Dth95
 nExN4a5tvjg6mQPiHuDbyZW3koFYG0MiJp+cAeqYfS7568VdnTDbKxDnWICub8iUdubxTTo2SIv
 Wev2glE4htkkG5uSR6pPNQaNipWA0IQ2LHCGm94qOll6DEoZoTViB3mj6I3hxG9pBrqDfUh17+f
 lo3hdv0/9/7ISBDXyAAQ8p3GPSjfC/FeYTdz4NleiKbViHEatG84k74T+jpLdfnRBsipsX3Dhf8
 3/+cwDsKxAsmCBqEeTfh0raot5rW7Y8ppj+w58wQa6OU0HBDy6RgO14UEvP4/f9TGA7ONSNqVt+
 edEHewtNrqdWwh433mmVlPQ5pIAkQSTgwyr5P55vEL7dYANCMQUqemgeWue5dedAdAjzd1hsb+M
 dcWvCQ2GaCpauXCwAzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX3LZ0ZF2BacbT
 lIyhZjKfXRLOBe0Sq9yxF4mjfgPUNCK4B8B4nr55dtYkA/3dpvVWxt0Fs73hYhAa/deVJerlgWq
 6ZvOllv85jc1NWAVqIvLmsxVhNYSIcI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org,oss.nxp.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.199:received];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C7A7D4553A
X-Spamd-Bar: ---
Message-ID-Hash: 3KHFGVKG4SIL5UG6JQTNL7FA6N2TK6LR
X-Message-ID-Hash: 3KHFGVKG4SIL5UG6JQTNL7FA6N2TK6LR
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3KHFGVKG4SIL5UG6JQTNL7FA6N2TK6LR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add signal buses for asynchronous notifications between Linux and TEE
endpoints, using the firmware-reported System MSI for interrupt delivery.

Allow service drivers to reserve and relinquish incoming signals and
raise outgoing signals. Dispatch incoming notifications through client
callbacks.

Drain notification callbacks before removing service devices, while
keeping the mailbox and signal buses available until client removal
completes.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/driver.c           | 599 ++++++++++++++++++++-
 drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h |  26 +
 include/linux/rpmi_tee.h                           |  24 +
 3 files changed, 647 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/riscv_rpmi_tee/driver.c b/drivers/firmware/riscv_rpmi_tee/driver.c
index 690561ed949d..36a5ad651351 100644
--- a/drivers/firmware/riscv_rpmi_tee/driver.c
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -8,14 +8,20 @@
 #include <linux/mailbox_client.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/cleanup.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/rpmi_tee.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
 
 #include "rpmi_tee_private.h"
 
@@ -42,6 +48,15 @@
 
 /* TEE_MEMORY_SEGMENT_SEND flags. */
 #define RPMI_TEE_SEGMENT_LAST		BIT(31)
+
+/* TEE_SIGNAL_BUS_SETUP feature value and TEE_SIGNAL_RETRIEVE flags. */
+#define RPMI_TEE_SIGNAL_MODE_MASK	GENMASK(1, 0)
+#define RPMI_TEE_SIGNAL_WIDTH_MASK	GENMASK(11, 2)
+#define RPMI_TEE_SIGNAL_INDEX_MASK	GENMASK(31, 12)
+
+#define RPMI_TEE_SIGNAL_MODE_SYSTEM_MSI	1
+#define RPMI_TEE_SIGNAL_MORE_AVAILABLE	BIT(31)
+
 /**
  * struct rpmi_tee_probe_features_req - TEE_PROBE_FEATURES request
  * @feature_id: TEE feature identifier to query.
@@ -180,6 +195,87 @@ struct rpmi_tee_parcel_reclaim_resp {
 	__le32 flags;
 } __packed;
 
+/**
+ * struct rpmi_tee_signal_bus_setup_req - SIGNAL_BUS_SETUP request
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ * @bus_width: Total number of signal IDs in the bus.
+ * @sender_signals: Number of signal IDs reserved for the endpoint sender.
+ */
+struct rpmi_tee_signal_bus_setup_req {
+	__le32 target_id;
+	__le32 bus_width;
+	__le32 sender_signals;
+} __packed;
+
+/**
+ * struct rpmi_tee_signal_bus_teardown_req - SIGNAL_BUS_TEARDOWN request
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ */
+struct rpmi_tee_signal_bus_teardown_req {
+	__le32 target_id;
+} __packed;
+
+/**
+ * struct rpmi_tee_signal_raise_req - SIGNAL_RAISE request prefix
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ * @signal_count: Number of signal IDs in @signals.
+ * @signals: Signal IDs to raise.
+ */
+struct rpmi_tee_signal_raise_req {
+	__le32 target_id;
+	__le32 signal_count;
+	__le32 signals[];
+} __packed;
+
+/**
+ * struct rpmi_tee_signal_raise_one_req - Single-signal SIGNAL_RAISE request
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ * @signal_count: Must be one.
+ * @signal: Signal ID to raise.
+ */
+struct rpmi_tee_signal_raise_one_req {
+	__le32 target_id;
+	__le32 signal_count;
+	__le32 signal;
+} __packed;
+
+/**
+ * struct rpmi_tee_signal_retrieve_resp - SIGNAL_RETRIEVE response prefix
+ * @status: RPMI completion status.
+ * @flags: Response flags.
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ * @signal_count: Number of signal IDs in @signals.
+ * @signals: Retrieved signal IDs.
+ */
+struct rpmi_tee_signal_retrieve_resp {
+	__le32 status;
+	__le32 flags;
+	__le32 target_id;
+	__le32 signal_count;
+	__le32 signals[];
+} __packed;
+
+enum rpmi_tee_signal_state {
+	RPMI_TEE_SIGNAL_ACTIVE,
+	RPMI_TEE_SIGNAL_RELEASING,
+};
+
+struct rpmi_tee_signal_reservation {
+	struct rpmi_tee_device *rdev;
+	rpmi_tee_notifier_cb cb;
+	void *cb_data;
+	enum rpmi_tee_signal_state state;
+};
+
+struct rpmi_tee_signal_bus {
+	struct list_head node;	/* Link in the notification signal-bus list. */
+	struct mutex lock;	/* Serializes reservation state and lifetime. */
+	struct xarray reservations;
+	u32 endpoint_id;
+	u32 width;
+	u32 tee_to_ree_count;
+};
+
 struct rpmi_tee_child {
 	struct list_head node;
 	struct rpmi_tee_device *rdev;
@@ -795,6 +891,280 @@ static int rpmi_tee_op_memory_share(struct rpmi_tee_device *rdev,
 	return rpmi_tee_op_parcel_create(rdev, args, false);
 }
 
+static struct rpmi_tee_signal_bus *
+__rpmi_tee_find_signal_bus(struct rpmi_tee_transport *priv, u32 endpoint_id)
+{
+	struct rpmi_tee_signal_bus *bus;
+
+	list_for_each_entry(bus, &priv->notif.buses, node) {
+		if (bus->endpoint_id == endpoint_id)
+			return bus;
+	}
+
+	return NULL;
+}
+
+static struct rpmi_tee_signal_bus *
+rpmi_tee_find_signal_bus(struct rpmi_tee_transport *priv, u32 endpoint_id)
+{
+	lockdep_assert_held(&priv->notif.ops_lock);
+	/* Do not access signal buses after notification shutdown starts. */
+	if (priv->notif.shutting_down)
+		return NULL;
+
+	return __rpmi_tee_find_signal_bus(priv, endpoint_id);
+}
+
+/* Invoke an active signal callback without holding the bus lock. */
+static int rpmi_tee_dispatch_signal(struct rpmi_tee_signal_bus *bus,
+				    u32 signal)
+{
+	struct rpmi_tee_signal_reservation *resv;
+	rpmi_tee_notifier_cb cb = NULL;
+	struct rpmi_tee_device *rdev = NULL;
+	void *cb_data = NULL;
+
+	if (signal >= bus->tee_to_ree_count)
+		return -EPROTO;
+
+	scoped_guard(mutex, &bus->lock) {
+		resv = xa_load(&bus->reservations, signal);
+		if (resv && resv->state == RPMI_TEE_SIGNAL_ACTIVE) {
+			cb = resv->cb;
+			cb_data = resv->cb_data;
+			rdev = resv->rdev;
+		}
+	}
+
+	if (cb)
+		cb(rdev, signal, cb_data);
+
+	return 0;
+}
+
+/* Release signal IDs that have passed the empty-retrieval barrier. */
+static void rpmi_tee_signal_bus_drop_releasing(struct rpmi_tee_signal_bus *bus)
+{
+	struct rpmi_tee_signal_reservation *resv;
+	unsigned long index;
+
+	guard(mutex)(&bus->lock);
+	xa_for_each(&bus->reservations, index, resv) {
+		if (resv->state != RPMI_TEE_SIGNAL_RELEASING)
+			continue;
+
+		xa_erase(&bus->reservations, index);
+		kfree(resv);
+	}
+}
+
+/**
+ * rpmi_tee_retrieve_signals() - Drain pending TEE-to-REE signals
+ * @priv: RPMI TEE transport
+ *
+ * Retrieve and dispatch signals until the firmware reports no pending data.
+ * Return relinquished signal IDs to their buses only after that empty
+ * retrieval.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int rpmi_tee_retrieve_signals(struct rpmi_tee_transport *priv)
+{
+	size_t resp_len = priv->mbox.max_msg_data_size;
+	u32 flags, endpoint_id, signal_count, i;
+	struct rpmi_tee_signal_bus *bus;
+	s32 status;
+	int ret;
+
+	struct rpmi_tee_signal_retrieve_resp *resp __free(kfree) =
+		kzalloc(resp_len, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	for (;;) {
+		scoped_guard(mutex, &priv->notif.ops_lock) {
+			/* Stop retrieving so shutdown can drain the worker. */
+			if (priv->notif.shutting_down)
+				return 0;
+
+			resp_len = priv->mbox.max_msg_data_size;
+			ret = rpmi_tee_send_with_status(priv,
+					RPMI_TEE_SRV_SIGNAL_RETRIEVE,
+					NULL, 0, resp, &resp_len, &status);
+			/*
+			 * A signal may be raised after a clear MORE_AVAILABLE
+			 * response and before relinquish. Reusing the ID could
+			 * deliver it to the wrong client.
+			 * Reuse relinquished IDs only after an empty retrieve.
+			 */
+			if (!ret && status == RPMI_ERR_NO_DATA) {
+				struct rpmi_tee_signal_bus *bus;
+
+				list_for_each_entry(bus, &priv->notif.buses, node)
+					rpmi_tee_signal_bus_drop_releasing(bus);
+			}
+		}
+
+		if (ret)
+			return ret;
+		/* The firmware has no more pending signals. */
+		if (status == RPMI_ERR_NO_DATA)
+			return 0;
+		if (status)
+			return rpmi_to_linux_error(status);
+		if (resp_len < sizeof(*resp))
+			return -EPROTO;
+
+		flags = get_unaligned_le32(&resp->flags);
+		endpoint_id = get_unaligned_le32(&resp->target_id);
+		signal_count = get_unaligned_le32(&resp->signal_count);
+
+		/* Validate the response flags and its variable-length signal array. */
+		if ((flags & ~RPMI_TEE_SIGNAL_MORE_AVAILABLE) || !signal_count ||
+		    signal_count != (resp_len - sizeof(*resp)) / sizeof(__le32))
+			return -EPROTO;
+
+		bus = __rpmi_tee_find_signal_bus(priv, endpoint_id);
+		if (!bus || signal_count > bus->tee_to_ree_count)
+			return -EPROTO;
+
+		for (i = 0; i < signal_count; i++) {
+			u32 signal = get_unaligned_le32(&resp->signals[i]);
+
+			ret = rpmi_tee_dispatch_signal(bus, signal);
+			if (ret)
+				return ret;
+		}
+	}
+}
+
+static void rpmi_tee_notif_work(struct work_struct *work)
+{
+	struct rpmi_tee_notif_state *notif =
+		container_of(work, struct rpmi_tee_notif_state, work);
+	struct rpmi_tee_transport *priv =
+		container_of(notif, struct rpmi_tee_transport, notif);
+	int ret;
+
+	ret = rpmi_tee_retrieve_signals(priv);
+	if (ret)
+		dev_warn(priv->dev, "failed to retrieve signals: %d\n", ret);
+}
+
+static irqreturn_t rpmi_tee_notif_irq_handler(int irq, void *data)
+{
+	struct rpmi_tee_transport *priv = data;
+
+	queue_work(priv->notif.wq, &priv->notif.work);
+	return IRQ_HANDLED;
+}
+
+/* Reserve a TEE-to-REE signal for a notification consumer. */
+static int rpmi_tee_op_notify_request(struct rpmi_tee_device *rdev,
+				      rpmi_tee_notifier_cb cb, void *cb_data,
+				      u32 *signal)
+{
+	struct rpmi_tee_transport *priv = rpmi_tee_device_to_transport(rdev);
+	struct rpmi_tee_signal_bus *bus;
+	u32 id;
+
+	if (!cb || !signal)
+		return -EINVAL;
+
+	guard(mutex)(&priv->notif.ops_lock);
+	bus = rpmi_tee_find_signal_bus(priv, rdev->endpoint_id);
+	if (!bus)
+		return -EOPNOTSUPP;
+
+	struct rpmi_tee_signal_reservation *resv __free(kfree) =
+		kzalloc_obj(*resv, GFP_KERNEL);
+	if (!resv)
+		return -ENOMEM;
+
+	resv->rdev = rdev;
+	resv->cb = cb;
+	resv->cb_data = cb_data;
+	scoped_guard(mutex, &bus->lock) {
+		int ret;
+
+		ret = xa_alloc(&bus->reservations, &id, resv,
+			       XA_LIMIT(0, bus->tee_to_ree_count - 1),
+			       GFP_KERNEL);
+		if (ret)
+			return ret == -EBUSY ? -ENOSPC : ret;
+	}
+
+	*signal = id;
+	/* xa_alloc owns resv. */
+	retain_and_null_ptr(resv);
+
+	return 0;
+}
+
+/* Relinquish a previously reserved TEE-to-REE signal. */
+static int rpmi_tee_op_notify_relinquish(struct rpmi_tee_device *rdev,
+					 u32 signal)
+{
+	struct rpmi_tee_transport *priv = rpmi_tee_device_to_transport(rdev);
+	struct rpmi_tee_signal_bus *bus;
+
+	guard(mutex)(&priv->notif.ops_lock);
+	bus = rpmi_tee_find_signal_bus(priv, rdev->endpoint_id);
+	if (!bus)
+		return -EOPNOTSUPP;
+
+	if (signal >= bus->tee_to_ree_count)
+		return -EINVAL;
+
+	scoped_guard(mutex, &bus->lock) {
+		struct rpmi_tee_signal_reservation *resv;
+
+		resv = xa_load(&bus->reservations, signal);
+		if (!resv)
+			return -ENOENT;
+		/* Release only if @signal belongs to @rdev. */
+		if (resv->rdev != rdev)
+			return -EPERM;
+		if (resv->state == RPMI_TEE_SIGNAL_RELEASING)
+			return -EALREADY;
+
+		resv->state = RPMI_TEE_SIGNAL_RELEASING;
+	}
+
+	queue_work(priv->notif.wq, &priv->notif.work);
+
+	return 0;
+}
+
+/* Raise an REE-to-TEE signal. */
+static int rpmi_tee_op_signal_raise(struct rpmi_tee_device *rdev, u32 signal)
+{
+	struct rpmi_tee_transport *priv = rpmi_tee_device_to_transport(rdev);
+	struct rpmi_tee_signal_raise_one_req req = {
+		.target_id = cpu_to_le32(rdev->endpoint_id),
+		.signal_count = cpu_to_le32(1),
+		.signal = cpu_to_le32(signal),
+	};
+	struct rpmi_tee_signal_bus *bus;
+
+	guard(mutex)(&priv->notif.ops_lock);
+	bus = rpmi_tee_find_signal_bus(priv, rdev->endpoint_id);
+	if (!bus)
+		return -EOPNOTSUPP;
+
+	if (signal < bus->tee_to_ree_count || signal >= bus->width)
+		return -EINVAL;
+
+	return rpmi_tee_send(priv, RPMI_TEE_SRV_SIGNAL_RAISE, &req,
+			     sizeof(req), NULL, NULL);
+}
+
+static const struct rpmi_tee_notifier_ops rpmi_tee_notifier_ops = {
+	.notify_request = rpmi_tee_op_notify_request,
+	.notify_relinquish = rpmi_tee_op_notify_relinquish,
+	.signal_raise = rpmi_tee_op_signal_raise,
+};
+
 static const struct rpmi_tee_info_ops rpmi_tee_info_ops = {
 	.msg_limits_get = rpmi_tee_op_msg_limits_get,
 };
@@ -813,6 +1183,7 @@ static const struct rpmi_tee_ops rpmi_tee_ops = {
 	.info_ops = &rpmi_tee_info_ops,
 	.msg_ops = &rpmi_tee_msg_ops,
 	.mem_ops = &rpmi_tee_mem_ops,
+	.notifier_ops = &rpmi_tee_notifier_ops,
 };
 
 static void rpmi_tee_unregister_devices(struct rpmi_tee_transport *priv)
@@ -826,6 +1197,212 @@ static void rpmi_tee_unregister_devices(struct rpmi_tee_transport *priv)
 	}
 }
 
+static void rpmi_tee_signal_bus_destroy_resvs(struct rpmi_tee_signal_bus *bus)
+{
+	struct rpmi_tee_signal_reservation *resv;
+	unsigned long index;
+
+	xa_for_each(&bus->reservations, index, resv) {
+		xa_erase(&bus->reservations, index);
+		kfree(resv);
+	}
+
+	xa_destroy(&bus->reservations);
+}
+
+static void rpmi_tee_teardown_signal_buses(struct rpmi_tee_transport *priv)
+{
+	struct rpmi_tee_signal_bus *bus, *tmp;
+
+	list_for_each_entry_safe(bus, tmp, &priv->notif.buses, node) {
+		struct rpmi_tee_signal_bus_teardown_req req = {
+			.target_id = cpu_to_le32(bus->endpoint_id),
+		};
+		int ret;
+
+		/* Completion includes the target TEE's teardown acknowledgment. */
+		ret = rpmi_tee_send(priv, RPMI_TEE_SRV_SIGNAL_BUS_TEARDOWN, &req,
+				    sizeof(req), NULL, NULL);
+		if (ret)
+			dev_warn(priv->dev, "failed to tear down signal bus for %#x: %d\n",
+				 bus->endpoint_id, ret);
+
+		rpmi_tee_signal_bus_destroy_resvs(bus);
+		list_del(&bus->node);
+		kfree(bus);
+	}
+}
+
+/* Drain callbacks, remove clients, then tear down notification resources. */
+static void rpmi_tee_teardown_endpoints(struct rpmi_tee_transport *priv)
+{
+	/* Initiate a notification shutdown. */
+	scoped_guard(mutex, &priv->notif.ops_lock)
+		priv->notif.shutting_down = true;
+
+	if (priv->notif.irq_requested) {
+		free_irq(priv->notif.irq, priv);
+		priv->notif.irq_requested = false;
+	}
+
+	if (priv->notif.wq) {
+		destroy_workqueue(priv->notif.wq);
+		priv->notif.wq = NULL;
+	}
+
+	/* Clients can still send final TEE_CALLs while signal buses exist. */
+	rpmi_tee_unregister_devices(priv);
+
+	/* Public notification operations and callbacks have stopped. */
+	rpmi_tee_teardown_signal_buses(priv);
+
+	if (priv->notif.irq) {
+		irq_dispose_mapping(priv->notif.irq);
+		priv->notif.irq = 0;
+	}
+}
+
+/* Set up an RPMI signal bus for one @endpoint_id TEE endpoint. */
+static int rpmi_tee_setup_ep_signal_bus(struct rpmi_tee_transport *priv,
+					u32 endpoint_id)
+{
+	struct rpmi_tee_signal_bus_setup_req req;
+	u32 max_width, width, tee_to_ree_count;
+
+	/* Avoid duplicate signal bus for endpoint. */
+	if (__rpmi_tee_find_signal_bus(priv, endpoint_id))
+		return 0;
+
+	if (priv->mbox.max_msg_data_size <
+	    sizeof(struct rpmi_tee_signal_retrieve_resp))
+		return -EMSGSIZE;
+
+	max_width = FIELD_GET(RPMI_TEE_SIGNAL_WIDTH_MASK,
+			      priv->notif.feature);
+	width = min(max_width,
+		    2 * ((priv->mbox.max_msg_data_size -
+			  sizeof(struct rpmi_tee_signal_retrieve_resp)) /
+			 sizeof(__le32)) + 1);
+	if (width < 2)
+		return -EMSGSIZE;
+
+	/* Use half available signals for TEE-to-REE range. */
+	tee_to_ree_count = width / 2;
+
+	struct rpmi_tee_signal_bus *bus __free(kfree) =
+		kzalloc_obj(*bus, GFP_KERNEL);
+	if (!bus)
+		return -ENOMEM;
+
+	mutex_init(&bus->lock);
+	xa_init_flags(&bus->reservations, XA_FLAGS_ALLOC);
+	bus->endpoint_id = endpoint_id;
+	bus->width = width;
+	bus->tee_to_ree_count = tee_to_ree_count;
+
+	req.target_id = cpu_to_le32(endpoint_id);
+	req.bus_width = cpu_to_le32(width);
+	req.sender_signals = cpu_to_le32(tee_to_ree_count);
+	/* Publish the local bus only after the target TEE accepts setup. */
+	if (rpmi_tee_send(priv, RPMI_TEE_SRV_SIGNAL_BUS_SETUP, &req,
+			  sizeof(req), NULL, NULL))
+		return -EOPNOTSUPP;
+
+	list_add_tail(&no_free_ptr(bus)->node, &priv->notif.buses);
+
+	return 0;
+}
+
+static int rpmi_tee_map_signal_irq(struct rpmi_tee_transport *priv)
+{
+	struct device_node *np;
+	struct of_phandle_args oirq = {};
+	u32 mode, index;
+	int irq;
+
+	mode = FIELD_GET(RPMI_TEE_SIGNAL_MODE_MASK, priv->notif.feature);
+	if (mode != RPMI_TEE_SIGNAL_MODE_SYSTEM_MSI)
+		return 0;
+
+	for_each_compatible_node(np, NULL, "riscv,rpmi-system-msi") {
+		if (of_device_is_available(np))
+			break;
+	}
+
+	if (!np)
+		return 0;
+	if (!irq_find_host(np)) {
+		of_node_put(np);
+		return -EPROBE_DEFER;
+	}
+
+	index = FIELD_GET(RPMI_TEE_SIGNAL_INDEX_MASK, priv->notif.feature);
+	oirq.np = np;
+	oirq.args_count = 1;
+	oirq.args[0] = index;
+	irq = irq_create_of_mapping(&oirq);
+
+	of_node_put(np);
+
+	return irq;
+}
+
+/**
+ * rpmi_tee_setup_signal_bus() - Set up signal notification delivery
+ * @priv: RPMI TEE transport
+ * @system: Discovered TEE endpoints that may own signal buses
+ *
+ * Map the signal interrupt, then set up a bus for each endpoint. Endpoint
+ * setup failures are nonfatal, allowing notifications for the remaining
+ * endpoints. Register the interrupt handler only when at least one bus is
+ * available.
+ *
+ * Return: 0 on completion, or -EPROBE_DEFER when the System MSI IRQ domain
+ * is not ready.
+ */
+static int
+rpmi_tee_setup_signal_bus(struct rpmi_tee_transport *priv,
+			 const struct rpmi_tee_discovery *system)
+{
+	struct rpmi_tee_discovered_endpoint *ep;
+	int ret;
+
+	priv->notif.irq = rpmi_tee_map_signal_irq(priv);
+	if (priv->notif.irq < 0)
+		return priv->notif.irq;
+	if (!priv->notif.irq)
+		return 0;
+
+	list_for_each_entry(ep, &system->eps, node) {
+		ret = rpmi_tee_setup_ep_signal_bus(priv, ep->ep_id);
+		if (ret)
+			dev_warn(priv->dev, "failed to set up signal bus for %#x: %d\n",
+				 ep->ep_id, ret);
+	}
+
+	if (list_empty(&priv->notif.buses))
+		goto out_failed;
+
+	ret = request_irq(priv->notif.irq, rpmi_tee_notif_irq_handler, 0,
+			  dev_name(priv->dev), priv);
+	if (ret) {
+		dev_warn(priv->dev, "failed to request signal IRQ: %d\n", ret);
+		rpmi_tee_teardown_signal_buses(priv);
+		goto out_failed;
+	}
+
+	priv->notif.irq_requested = true;
+
+	return 0;
+
+out_failed:
+	/* Failures are nonfatal; only disable notification. */
+	irq_dispose_mapping(priv->notif.irq);
+	priv->notif.irq = 0;
+
+	return 0;
+}
+
 static struct rpmi_tee_device *
 rpmi_tee_find_device(struct rpmi_tee_transport *priv, const uuid_t *uuid,
 		     u32 endpoint_id)
@@ -881,14 +1458,19 @@ static int rpmi_tee_setup_endpoints(struct rpmi_tee_transport *priv)
 	if (ret)
 		return ret;
 
+	ret = rpmi_tee_setup_signal_bus(priv, &system);
+	if (ret)
+		goto out_failed;
+
 	list_for_each_entry(ep, &system.eps, node) {
 		ret = rpmi_tee_register_devices(priv, ep);
 		if (ret) {
-			rpmi_tee_unregister_devices(priv);
+			rpmi_tee_teardown_endpoints(priv);
 			break;
 		}
 	}
 
+out_failed:
 	rpmi_tee_free_discovery(&system);
 
 	return ret;
@@ -907,7 +1489,11 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 	INIT_LIST_HEAD(&priv->devices);
+	INIT_LIST_HEAD(&priv->notif.buses);
 	mutex_init(&priv->mem.lock);
+	mutex_init(&priv->notif.ops_lock);
+	INIT_WORK(&priv->notif.work, rpmi_tee_notif_work);
+
 	priv->mbox.client.dev = &pdev->dev;
 	priv->mbox.client.tx_sync = true;
 	priv->mbox.chan = mbox_request_channel(&priv->mbox.client, 0);
@@ -915,6 +1501,7 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->mbox.chan),
 				     "failed to request mailbox channel\n");
 
+	/* Validate the RPMI mailbox transport. */
 	ret = rpmi_tee_check_transport(priv);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret,
@@ -944,6 +1531,12 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_failed;
 
+	priv->notif.wq = alloc_workqueue("rpmi_tee_notif", WQ_UNBOUND, 0);
+	if (!priv->notif.wq) {
+		ret = -ENOMEM;
+		goto out_failed;
+	}
+
 	ret = rpmi_tee_setup_endpoints(priv);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret,
@@ -954,6 +1547,8 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 	return 0;
 
 out_failed:
+	if (priv->notif.wq)
+		destroy_workqueue(priv->notif.wq);
 	mbox_free_channel(priv->mbox.chan);
 
 	return ret;
@@ -963,7 +1558,7 @@ static void rpmi_tee_transport_remove(struct platform_device *pdev)
 {
 	struct rpmi_tee_transport *priv = platform_get_drvdata(pdev);
 
-	rpmi_tee_unregister_devices(priv);
+	rpmi_tee_teardown_endpoints(priv);
 	mbox_free_channel(priv->mbox.chan);
 }
 
diff --git a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
index 4df47d52724a..4d302f8ca16a 100644
--- a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
+++ b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <linux/workqueue.h>
 
 /* TEE service group and the services used by this module. */
 #define RPMI_SRVGRP_TEE		0x10
@@ -20,12 +21,37 @@
 #define RPMI_TEE_SRV_PROBE_DOMAIN	0x04
 #define RPMI_TEE_SRV_PROBE_ENDPOINT	0x05
 #define RPMI_TEE_SRV_CALL		0x18
+#define RPMI_TEE_SRV_SIGNAL_BUS_SETUP		0x0a
+#define RPMI_TEE_SRV_SIGNAL_BUS_TEARDOWN	0x0b
+#define RPMI_TEE_SRV_SIGNAL_RAISE		0x0c
+#define RPMI_TEE_SRV_SIGNAL_RETRIEVE		0x0d
 #define RPMI_TEE_SRV_MEMORY_PARCEL_CREATE	0x0e
 #define RPMI_TEE_SRV_MEMORY_PARCEL_RECLAIM	0x11
 #define RPMI_TEE_SRV_MEMORY_SEGMENT_SEND	0x12
 
+/**
+ * struct rpmi_tee_notif_state - Signal notification state
+ * @buses: List of signal buses established for TEE endpoints.
+ * @work: Retrieves and dispatches pending TEE-to-REE signals.
+ * @wq: Workqueue used for @work.
+ * @ops_lock: Serializes public notification operations with signal-bus
+ *	    teardown. It prevents new operations after @shutting_down is set and
+ *	    serializes rpmi_tee_op_notify_relinquish() with the empty
+ *	    SIGNAL_RETRIEVE release barrier.
+ * @feature: SIGNAL feature value reported by the transport.
+ * @irq: Linux IRQ assigned to the signal notification interrupt.
+ * @irq_requested: Whether @irq has been requested.
+ * @shutting_down: Prevents public notification operations during teardown.
+ */
 struct rpmi_tee_notif_state {
+	struct list_head buses;
+	struct work_struct work;
+	struct workqueue_struct *wq;
+	struct mutex ops_lock;
 	u32 feature;
+	int irq;
+	bool irq_requested;
+	bool shutting_down;
 };
 
 struct rpmi_tee_mbox {
diff --git a/include/linux/rpmi_tee.h b/include/linux/rpmi_tee.h
index 10f6cae4a3a7..f392b75ecaef 100644
--- a/include/linux/rpmi_tee.h
+++ b/include/linux/rpmi_tee.h
@@ -127,11 +127,35 @@ struct rpmi_tee_mem_ops {
 	int (*memory_reclaim)(struct rpmi_tee_device *rdev, u32 parcel_id);
 };
 
+typedef void (*rpmi_tee_notifier_cb)(struct rpmi_tee_device *rdev,
+				     u32 signal, void *cb_data);
+
+/* RPMI TEE signal notification operations. */
+struct rpmi_tee_notifier_ops {
+	/**
+	 * @notify_request: Allocate a TEE-to-REE signal and associate it with
+	 *	@cb and @cb_data. The allocated signal is returned through @signal.
+	 */
+	int (*notify_request)(struct rpmi_tee_device *rdev,
+			      rpmi_tee_notifier_cb cb, void *cb_data, u32 *signal);
+	/**
+	 * @notify_relinquish: Stop dispatching a TEE-to-REE @signal previously
+	 *	allocated for @rdev. The release is asynchronous and a callback may
+	 *	relinquish its own signal.
+	 */
+	int (*notify_relinquish)(struct rpmi_tee_device *rdev, u32 signal);
+	/**
+	 * @signal_raise: Raise an REE-to-TEE @signal selected by the TEE service.
+	 */
+	int (*signal_raise)(struct rpmi_tee_device *rdev, u32 signal);
+};
+
 /* RPMI TEE transport operation groups. */
 struct rpmi_tee_ops {
 	const struct rpmi_tee_info_ops *info_ops;
 	const struct rpmi_tee_msg_ops *msg_ops;
 	const struct rpmi_tee_mem_ops *mem_ops;
+	const struct rpmi_tee_notifier_ops *notifier_ops;
 };
 
 extern const struct bus_type rpmi_tee_bus_type;

-- 
2.34.1

