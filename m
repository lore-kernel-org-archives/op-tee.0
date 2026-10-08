Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11FECA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:32:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 16A7E454F9
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430348;
	bh=Nc7c2NB3hGdi48979inrlz8BAJzMB8SiKcycNRYpdSg=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=J5lJwb8rReg/BZUGTj6aG3NiiJxOxfz44LtHCYa7Je4jKVi3ATlPL7ZAHsB3TiUfL
	 RIIsL0cE2l2ltbJHGJKpM/alfpJp0xHXmj/DPi6Lim92rIGgKiHxpnq/GzBoak0UJ2
	 BIFJBrA8nNT1y/dw2ncqOXb3aGgqH/xK9n1qBm3VG1+GvnOyMweXRlOFQxgpfO8ygT
	 6QjUq6k3gGeq6FBjxa6axrfyDdon55MadUUQDV1bax1JTYelTNNv2X3q5OYe+Sfpdl
	 d9Zkbg6dzwQGVE4vlVwmCFHe+5PF2AqCOLvELfRhvmnErffmDXAsLyfX0eWFXAMoMb
	 jB+dUlN3EuQ0w==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F41514552B
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HfkO7VBQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CZFJ+Ybt;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hTFK1824411
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5GNPmOtb6vRXX69AT9xHsFaqITJ4EycmZwhRBnhLEI=; b=HfkO7VBQV/6BY5dX
	DjN/rwEZfsZ2b3qDbe4UlSF4rAmzD1c3FdwzPUXc4izeZ2hz9y36bwQU2XQNd0LJ
	IJhuSKSzKC6lIcPysyQYqd7WRtlEIDbfQM7yBAZ0lkKjS7FqWUcpDGgE5fumO29V
	BjCGl7ScfCNs6aZK+l8jsl8KciYcvJfzkK3Wf6bz6KdIxRpj8lZszh8mxzU9YLID
	lm/6k1K6iZKmKUq4EFte2/AWBqyoqB0LIYDIvTc6PW2CA5AiREMZr6rZzG7+Ef7J
	mQyydswDPpCF5evc+yzzhLjey7ydwPP7KXff//3Eh9UVAebXu+yvlJ8F46jEOQgP
	8JJBbg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe80vdq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3515d2fc5ebso5721374eec.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430131; x=1792034931; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h5GNPmOtb6vRXX69AT9xHsFaqITJ4EycmZwhRBnhLEI=;
        b=CZFJ+YbteLPu54MtcPIciqQncYWt+EEipkFJJQ1bm1WjJrM3Hyt9iYu/qoJSR3M2PA
         qqGC/1bzQ2WVHfpgvH0lJkgFFIVjvjf27mutptBdyA4D/SYjVYGcweEje5SsoPKg4Hgf
         YwuBN8h7pRVPRhqWsZXALGjYSaHpDcBhJMM/Kmc0pow3dnEE4MTc2ZsrpVgvV88lR/Wo
         AVJPFXBS3uwlWdqfWDH6zdiZ9kr+1uIHB8/GyLzpOyy90jk62Mcae8RfCADRi1JsHuc9
         wFP+8+aLtC4RDR57KmhWuDT5louhe2FZqTjg6vvdZP0HXHyEzBZmxLWfvb5FPXSHHfyO
         XRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430131; x=1792034931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5GNPmOtb6vRXX69AT9xHsFaqITJ4EycmZwhRBnhLEI=;
        b=W1BupRuRtsMEenU70Zv3AL/x0K2HXbInu6qwx4Ux16CTGPetHKIZqaKQMCIuBtVDYs
         sEf37H7Sv4r21e+tkstg2B2dquuxyB1bjexBVDb0tg7G0dtHUcN6MFO49hiWaZBAWlYU
         E6bUtsBea8QruJOb7FMYke83NHjET4ShK3x/BhaFjN8SBMzlm3MNO5K8Su4fxW1PZKgY
         jfwbWhFQEE5HNprim3Rq22KQNvAGRnaSlcSKver7LtLSLpWMGZcNQfcUQxJjBztvszwH
         IyG+4+tzTHWQutsnKZ46A4j7WSjVDasfQvbhVJQd/myOeYvB13nFTHU4Uh/SvAa6M0fg
         2PZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuIZ52fyWN0HuQuRUrZqm7cGOtdiyh0w4gpfpQ7VGwrVY1H0xqushsobYIyNYc0/zZ8v1vbrQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYITh3ZrDDH+icQnYEuZDi5J+itu4jcwo7U7jpBTYXu039A4hKRG
	80sIGNrw70elpZf+aaxzZ6da/s4D3t3F58ic9LdEHkb1wD52IQ0qYS++qNfya29HrmFd6zbo1PO
	bCSz9tJDvd1yEzd//y6e7auB8vWx+kjdFeoKK/PY+fA3KUmmtcN3cxAdQrlqPvax1FhuszbQ=
X-Gm-Gg: AYBFou1O5wMZVBnsken0Slb/GTH3yd6bJBAryPAvNUbjBZ5KVD2kiiiteXRK3Ihlpqt
	FfSwV4zecG5iN0GaVSsnrg3xumtmLX2HV2Iq4YN0NeFP6TA0z5bUUyNEfS+ts5iOw0MFsZvv+ZU
	dT1xldt3Zg8jhTS9rUOHBQgmL/MISJ/Qi49jEu7IlWPmgZQ58AoxxS4tnTqtKBb/OU+84Ek0Wz4
	cKKaM6XXOPPR2RAXqp7ya/wAjgJ1nf5d8ao+mX8075ybYv6kV+4z5S3wXPk7kLen1MUXN0oP3ge
	znJoxvaqasqUKhLeH3nnymz37Wb4lTFvPArxXwXQ5FUjgNvmtTloPPfY7J0YrNuA9IYTNbH+n2o
	qqVDJTDhjssoo9ZIWrueT2nqgkWgVRv0NnybUMaadfpM5kwiWWsVvGnbStw==
X-Received: by 2002:a05:693c:810b:b0:33b:ea8c:811b with SMTP id 5a478bee46e88-3515dbd55e8mr4963590eec.5.1791430131110;
        Wed, 07 Oct 2026 20:28:51 -0700 (PDT)
X-Received: by 2002:a05:693c:810b:b0:33b:ea8c:811b with SMTP id 5a478bee46e88-3515dbd55e8mr4963556eec.5.1791430130414;
        Wed, 07 Oct 2026 20:28:50 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:49 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:27:13 -0700
Subject: [PATCH RFC v2 07/10] firmware: riscv: rpmi-tee: register TEE
 services and support calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-7-45939a13d223@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfXwTYPnmYeEQkj
 TrhYFj6NSoX7zkJAFa4VakYG6E1NUNT6sj8yM65h7fCwktxULsNSwPeGotrWntv0udze4KDbiS6
 EAvSyY36MUMTAdLW+vCnNj6HndwQ9jegKCzFaGfAkkxAeqiFHiYj3Ejp9u7+L6D2tz7p9bcfufP
 V5fZYd0MaLZlNCFWLSWuL1Oy2vuE6ErcH61XW8UBJSjOpmWuuHuCmdccyrDiAH7zzJbhfkdYNUw
 UyBcNSrQfOgGb/qUCEjxTCwomlCIXP89r2AA3ZKBb0qtNtz5eXiyKKAot84VTr3WKSph5jHMCZk
 Ex8rJLt2EP+REVpHkHc8byjtD6HbhQ9UiLIUH/4A5hrYLdDBmy0I7FZuKdAutTQlOwz8W/26T27
 FAjWY60LyrPwHC3ZAa97HTo7wrtio4OW8tmiZ1munpSfIBF6Q5Y9mc6zvVpE0ITtv5GNjgiFzVM
 wJHjuGIM1IwesJlCmhQ==
X-Proofpoint-GUID: i_OYwKgN3FIkojz3S_ENCEPKZT1d8Kgy
X-Proofpoint-ORIG-GUID: i_OYwKgN3FIkojz3S_ENCEPKZT1d8Kgy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX4lVFFFSVTIsy
 MUZ900TiCrXBjZybcbUwLYfwg1ELOOhc501unApwLClbvyrU6JyB5BCWG0TzEpteoRn6kq32so7
 uj9ILZMGDWtcgEK3YVSt4Gkc6mq6IZE=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac70df4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=y-vMUYROV6c7iJA4GfAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.199:received];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F41514552B
X-Spamd-Bar: ---
Message-ID-Hash: 2MDHPRWDIEMEIQZU3VLKYHXF5LHJJM3Q
X-Message-ID-Hash: 2MDHPRWDIEMEIQZU3VLKYHXF5LHJJM3Q
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2MDHPRWDIEMEIQZU3VLKYHXF5LHJJM3Q/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Register discovered TEE services as RPMI TEE bus devices so service
drivers can bind to them.

Provide TEE_CALL operations for exchanging service-defined requests
and responses, and expose the transport's payload limits to clients.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/driver.c           | 278 ++++++++++++++++++++-
 drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h |  13 +
 include/linux/rpmi_tee.h                           |  35 +++
 3 files changed, 325 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/riscv_rpmi_tee/driver.c b/drivers/firmware/riscv_rpmi_tee/driver.c
index a70b8be41bed..a683f7d28c25 100644
--- a/drivers/firmware/riscv_rpmi_tee/driver.c
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -5,16 +5,52 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include <linux/unaligned.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/cleanup.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/rpmi_tee.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
 
 #include "rpmi_tee_private.h"
 
+/**
+ * struct rpmi_tee_call_req - TEE_CALL request prefix
+ * @sender_id: Calling REE endpoint identifier.
+ * @target_id: Destination TEE endpoint identifier.
+ * @service: UUID of the target service.
+ * @service_data_len: Length of @service_data in bytes.
+ * @service_data: Service-defined request data.
+ */
+struct rpmi_tee_call_req {
+	__le32 sender_id;
+	__le32 target_id;
+	u8 service[UUID_SIZE];
+	__le32 service_data_len;
+	u8 service_data[];
+} __packed;
+
+/**
+ * struct rpmi_tee_call_resp - TEE_CALL response prefix
+ * @status: RPMI completion status.
+ * @service_data_len: Length of @service_data in bytes.
+ * @service_data: Service-defined response data.
+ */
+struct rpmi_tee_call_resp {
+	__le32 status;
+	__le32 service_data_len;
+	u8 service_data[];
+} __packed;
+
+struct rpmi_tee_child {
+	struct list_head node;
+	struct rpmi_tee_device *rdev;
+};
+
 /* rpmi_tee_send_with_status() - Send an RPMI TEE service request. */
 int rpmi_tee_send_with_status(struct rpmi_tee_transport *priv, u32 service_id,
 			      const void *req, size_t req_len, void *resp,
@@ -43,6 +79,47 @@ int rpmi_tee_send_with_status(struct rpmi_tee_transport *priv, u32 service_id,
 	return 0;
 }
 
+/**
+ * rpmi_tee_send() - Send an RPMI TEE service request
+ * @priv: RPMI TEE transport
+ * @service_id: RPMI TEE service identifier
+ * @req: Request data
+ * @req_len: Request data length
+ * @resp: Response data buffer, or %NULL for a status-only response
+ * @resp_len: On entry, response buffer capacity; on success, response length
+ *
+ * Pass both @resp and @resp_len as %NULL when the service has no response
+ * payload beyond the mandatory RPMI status word.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int rpmi_tee_send(struct rpmi_tee_transport *priv, u32 service_id,
+			 const void *req, size_t req_len, void *resp,
+			 size_t *resp_len)
+{
+	__le32 status_resp;
+	size_t status_resp_len = sizeof(status_resp);
+	s32 status;
+	int ret;
+
+	if (!resp && !resp_len) {
+		resp = &status_resp;
+		resp_len = &status_resp_len;
+	} else if (!resp || !resp_len) {
+		return -EINVAL;
+	}
+
+	ret = rpmi_tee_send_with_status(priv, service_id, req, req_len, resp,
+					resp_len, &status);
+	if (ret)
+		return ret;
+
+	if (status == RPMI_ERR_NO_DATA)
+		return -ENODATA;
+
+	return rpmi_to_linux_error(status);
+}
+
 /**
  * rpmi_tee_get_attr() - Get an RPMI mailbox attribute
  * @priv: RPMI TEE transport
@@ -95,12 +172,202 @@ static int rpmi_tee_check_transport(struct rpmi_tee_transport *priv)
 	ret = rpmi_tee_get_attr(priv, RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE, &value);
 	if (ret)
 		return ret;
+	/* The mandatory TEE_CALL request and response must fit the mailbox. */
+	if (value < sizeof(struct rpmi_tee_call_req) ||
+	    value < sizeof(struct rpmi_tee_call_resp))
+		return -EMSGSIZE;
 
 	priv->mbox.max_msg_data_size = value;
+	priv->max_call_req_size = value - sizeof(struct rpmi_tee_call_req);
+	priv->max_call_resp_size = value - sizeof(struct rpmi_tee_call_resp);
+
+	return 0;
+}
+
+/* RPMI TEE SERVICE GRP API. */
+
+/* Return the transport that owns @rdev. */
+static struct rpmi_tee_transport *
+rpmi_tee_device_to_transport(struct rpmi_tee_device *rdev)
+{
+	return dev_get_drvdata(rdev->dev.parent);
+}
+
+static int rpmi_tee_op_msg_limits_get(struct rpmi_tee_device *rdev,
+				      struct rpmi_tee_msg_limits *limits)
+{
+	struct rpmi_tee_transport *priv = rpmi_tee_device_to_transport(rdev);
+
+	if (!limits)
+		return -EINVAL;
+
+	limits->max_req_size = priv->max_call_req_size;
+	limits->max_resp_size = priv->max_call_resp_size;
+
+	return 0;
+}
+
+/**
+ * rpmi_tee_op_call - Invoke a service offered by a TEE endpoint
+ * @rdev: TEE service device.
+ * @req: Service-defined request data.
+ * @req_len: Length of @req in bytes.
+ * @resp: Buffer for service-defined response data.
+ * @resp_len: On entry, capacity of @resp; on success, response length.
+ *
+ * MPXY can return -ENOSPC after the TEE has processed the request when the
+ * response exceeds the supplied buffer. Callers must not blindly retry a
+ * non-idempotent request in that case.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int rpmi_tee_op_call(struct rpmi_tee_device *rdev, const void *req,
+			    size_t req_len, void *resp, size_t *resp_len)
+{
+	struct rpmi_tee_transport *priv = rpmi_tee_device_to_transport(rdev);
+	size_t call_req_len, call_resp_len;
+	u32 service_data_len;
+	int ret;
+
+	if (!resp_len || (!req && req_len) || (!resp && *resp_len))
+		return -EINVAL;
+
+	/* TEE_CALL payload must fit the mailbox. */
+	if (req_len > priv->max_call_req_size ||
+	    *resp_len > priv->max_call_resp_size)
+		return -EMSGSIZE;
+
+	call_req_len = sizeof(struct rpmi_tee_call_req) + req_len;
+	call_resp_len = sizeof(struct rpmi_tee_call_resp) + *resp_len;
+
+	struct rpmi_tee_call_req *call_req __free(kfree) =
+		kzalloc(call_req_len, GFP_KERNEL);
+	if (!call_req)
+		return -ENOMEM;
+
+	struct rpmi_tee_call_resp *call_resp __free(kfree) =
+		kzalloc(call_resp_len, GFP_KERNEL);
+	if (!call_resp)
+		return -ENOMEM;
+
+	call_req->sender_id = cpu_to_le32(priv->self_id);
+	call_req->target_id = cpu_to_le32(rdev->endpoint_id);
+	export_uuid(call_req->service, &rdev->uuid);
+	call_req->service_data_len = cpu_to_le32(req_len);
+	if (req_len)
+		memcpy(call_req->service_data, req, req_len);
+	/* Make TEE CALL. */
+	ret = rpmi_tee_send(priv, RPMI_TEE_SRV_CALL, call_req, call_req_len,
+			    call_resp, &call_resp_len);
+	if (ret)
+		return ret;
+
+	if (call_resp_len < sizeof(*call_resp))
+		return -EPROTO;
+	service_data_len = get_unaligned_le32(&call_resp->service_data_len);
+	/* Verify the firmware-reported length fits the actual response. */
+	if (service_data_len != call_resp_len - sizeof(*call_resp))
+		return -EPROTO;
+
+	if (service_data_len)
+		memcpy(resp, call_resp->service_data, service_data_len);
+	*resp_len = service_data_len;
+
+	return 0;
+}
+
+static const struct rpmi_tee_info_ops rpmi_tee_info_ops = {
+	.msg_limits_get = rpmi_tee_op_msg_limits_get,
+};
+
+static const struct rpmi_tee_msg_ops rpmi_tee_msg_ops = {
+	.call = rpmi_tee_op_call,
+};
+
+static const struct rpmi_tee_ops rpmi_tee_ops = {
+	.info_ops = &rpmi_tee_info_ops,
+	.msg_ops = &rpmi_tee_msg_ops,
+};
+
+static void rpmi_tee_unregister_devices(struct rpmi_tee_transport *priv)
+{
+	struct rpmi_tee_child *child, *tmp;
+
+	list_for_each_entry_safe(child, tmp, &priv->devices, node) {
+		list_del(&child->node);
+		rpmi_tee_device_unregister(child->rdev);
+		kfree(child);
+	}
+}
+
+static struct rpmi_tee_device *
+rpmi_tee_find_device(struct rpmi_tee_transport *priv, const uuid_t *uuid,
+		     u32 endpoint_id)
+{
+	struct rpmi_tee_child *child;
+
+	list_for_each_entry(child, &priv->devices, node) {
+		if (child->rdev->endpoint_id == endpoint_id &&
+		    uuid_equal(&child->rdev->uuid, uuid))
+			return child->rdev;
+	}
+
+	return NULL;
+}
+
+static int
+rpmi_tee_register_devices(struct rpmi_tee_transport *priv,
+			  const struct rpmi_tee_discovered_endpoint *ep)
+{
+	u32 i;
+
+	for (i = 0; i < ep->service_count; i++) {
+		const uuid_t *uuid = &ep->services[i];
+
+		/* Discard duplicate devices in the same endpoint. */
+		if (rpmi_tee_find_device(priv, uuid, ep->ep_id))
+			continue;
+
+		struct rpmi_tee_child *child __free(kfree) =
+			kzalloc_obj(*child, GFP_KERNEL);
+		if (!child)
+			return -ENOMEM;
+
+		child->rdev =
+			rpmi_tee_device_register(uuid, ep->ep_id,
+						 &rpmi_tee_ops, priv->dev);
+		if (IS_ERR(child->rdev))
+			return PTR_ERR(child->rdev);
+
+		list_add_tail(&no_free_ptr(child)->node, &priv->devices);
+	}
 
 	return 0;
 }
 
+static int rpmi_tee_setup_endpoints(struct rpmi_tee_transport *priv)
+{
+	struct rpmi_tee_discovered_endpoint *ep;
+	struct rpmi_tee_discovery system;
+	int ret;
+
+	ret = rpmi_tee_discover_endpoints(priv, &system);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(ep, &system.eps, node) {
+		ret = rpmi_tee_register_devices(priv, ep);
+		if (ret) {
+			rpmi_tee_unregister_devices(priv);
+			break;
+		}
+	}
+
+	rpmi_tee_free_discovery(&system);
+
+	return ret;
+}
+
 static int rpmi_tee_transport_probe(struct platform_device *pdev)
 {
 	struct rpmi_tee_transport *priv;
@@ -112,6 +379,7 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
+	INIT_LIST_HEAD(&priv->devices);
 	priv->mbox.client.dev = &pdev->dev;
 	priv->mbox.client.tx_sync = true;
 	priv->mbox.chan = mbox_request_channel(&priv->mbox.client, 0);
@@ -126,6 +394,13 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 		goto out_failed;
 	}
 
+	ret = rpmi_tee_setup_endpoints(priv);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret,
+			      "failed to discover RPMI TEE services\n");
+		goto out_failed;
+	}
+
 	return 0;
 
 out_failed:
@@ -138,6 +413,7 @@ static void rpmi_tee_transport_remove(struct platform_device *pdev)
 {
 	struct rpmi_tee_transport *priv = platform_get_drvdata(pdev);
 
+	rpmi_tee_unregister_devices(priv);
 	mbox_free_channel(priv->mbox.chan);
 }
 
diff --git a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
index ba0e7cb59b6d..07e6b9913cb7 100644
--- a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
+++ b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
@@ -17,6 +17,7 @@
 #define RPMI_TEE_SRV_PROBE_SYSTEM	0x03
 #define RPMI_TEE_SRV_PROBE_DOMAIN	0x04
 #define RPMI_TEE_SRV_PROBE_ENDPOINT	0x05
+#define RPMI_TEE_SRV_CALL		0x18
 
 struct rpmi_tee_mbox {
 	struct mbox_client client;
@@ -24,10 +25,22 @@ struct rpmi_tee_mbox {
 	u32 max_msg_data_size;
 };
 
+/**
+ * struct rpmi_tee_transport - State for one RPMI TEE transport instance
+ * @dev: Parent platform device.
+ * @mbox: RPMI mailbox transport state.
+ * @max_call_req_size: Maximum TEE_CALL request payload size in bytes.
+ * @max_call_resp_size: Maximum TEE_CALL response payload size in bytes.
+ * @self_id: Local REE physical endpoint identifier.
+ * @devices: List of registered TEE service devices.
+ */
 struct rpmi_tee_transport {
 	struct device *dev;
 	struct rpmi_tee_mbox mbox;
+	size_t max_call_req_size;
+	size_t max_call_resp_size;
 	u32 self_id;
+	struct list_head devices;
 };
 
 /* Report local transport errors separately from the returned RPMI status. */
diff --git a/include/linux/rpmi_tee.h b/include/linux/rpmi_tee.h
index c499f0427833..a76055149996 100644
--- a/include/linux/rpmi_tee.h
+++ b/include/linux/rpmi_tee.h
@@ -41,6 +41,41 @@ struct rpmi_tee_driver {
 #define to_rpmi_tee_drv(d) \
 	container_of_const(d, struct rpmi_tee_driver, driver)
 
+/**
+ * struct rpmi_tee_msg_limits - TEE_CALL service payload limits
+ * @max_req_size: Maximum request payload size in bytes.
+ * @max_resp_size: Maximum response payload size in bytes.
+ *
+ * Limits exclude the RPMI TEE_CALL request and response prefixes, but include
+ * any service-specific headers supplied by the caller.
+ */
+struct rpmi_tee_msg_limits {
+	size_t max_req_size;
+	size_t max_resp_size;
+};
+
+/**
+ * struct rpmi_tee_info_ops - RPMI TEE transport information operations
+ * @msg_limits_get: Return cached TEE_CALL payload limits for the transport
+ *	serving @rdev in @limits. Limits remain fixed for the transport lifetime.
+ *	Return 0 on success, or a negative error code on failure.
+ */
+struct rpmi_tee_info_ops {
+	int (*msg_limits_get)(struct rpmi_tee_device *rdev,
+			      struct rpmi_tee_msg_limits *limits);
+};
+
+struct rpmi_tee_msg_ops {
+	int (*call)(struct rpmi_tee_device *rdev, const void *req,
+		    size_t req_len, void *resp, size_t *resp_len);
+};
+
+/* RPMI TEE transport operation groups. */
+struct rpmi_tee_ops {
+	const struct rpmi_tee_info_ops *info_ops;
+	const struct rpmi_tee_msg_ops *msg_ops;
+};
+
 extern const struct bus_type rpmi_tee_bus_type;
 
 #if IS_REACHABLE(CONFIG_RISCV_RPMI_TEE_TRANSPORT)

-- 
2.34.1

