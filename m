Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449F6C4451C
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:02:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7A936451A3
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784703744;
	bh=LosjvZDIaSYjB3Gq/q9l/AWJ3RurWA5UZWsVfICp0jM=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=4qHUXrJm2CoZkhQkqTFi/aOad+fXyYHZxmwEtiHcXsI/rlYy8d27gh78/VybN+/BO
	 YsSeAxOgqv831zbrEsSvphe4yMGnQU2y0rrNnl4fywO/gMpixOXjpRq+jKkddN2QSm
	 GGgS5FDwnbhM1VkssFvXLOiFFh6LIScDnrhEUydAZkLAJd42Hi1tIuGoFPiOlyOUS1
	 t8x5bBksrlUMpdMITyj+LjMoZouJb2V2iLdFKS0eiBOBwuHnA75r89aOoi/qaNfpW1
	 1ooseIx4TTwPIW0wgRNhyOBeroZga9h/bj01diI58L1przl9aaS1RxfBGYbj1wIQfk
	 vhOMSByWGA9qA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A4774450DE
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 07:00:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F7dEPz1m;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y0NOP56A;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53lcN4027336
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 07:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9PuxTn6tqXxb1UzBUrLi98bIB+U0tB5y7IeqUgq/+Zo=; b=F7dEPz1m5gjDttwk
	pJbhI7KpMPUUrvIHLIyrKr3fGKVUvkJHJC/Vcw7ZILPm85sk6OmU/6MZ1PYkyn7G
	jX9NaW2P7KxqlfWnsFE3sYmjJWkbOyncPuSbQUY744zokQg7/jrr+bCdg5A1WvfC
	SrqMphAcEthUsD+gdknhVUNnr5cMk5OEKAESxcgJemY1lz2dA9sQfMpOUXMlWePn
	zGXd7HZnw6pHvM0jh+OQdH7twcEek1a2SnThgnNsmrr6Kq9dchF6KTuvMJRGXKMa
	s6vXAvacWatqROEwGEDXEIhk3WjRHCmAWimY0fTl2UM12iAr6b0I5IG8gtx6XkcJ
	R25Wqg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsbyse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 07:00:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccd1958e8fso123698035ad.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784703607; x=1785308407; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PuxTn6tqXxb1UzBUrLi98bIB+U0tB5y7IeqUgq/+Zo=;
        b=Y0NOP56AOKnrMZhFxNlzABCjHNfjocjajcGfTUGomTVa+qOehLXkFtvzWPaO3wbCXo
         DpYtxECAqb9W4m0XckhmYKOGsbOXs+dvAaPCiNa3i+GyQFeC8zXlyVrvyc5omx2vMSnX
         +hvaItkaAhxlL/bzI7HZ8CEYZD2QQKCC37XaB56ZgKFN9Gq4IoiOdjTp7rt8FuDCKNF3
         +rQPnIDJv31T5W7F+C5KgUCBQCrfcxYXEJxj8EamMpaEjZmZk7+4qPe+5ZAaXRLToFkD
         T9g6GkCidslJDc60ThW0bNm4W8a7LKj/VSrzWiQKEF01X1mHcJUQLIdsm5vz2DvovuST
         9dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784703607; x=1785308407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PuxTn6tqXxb1UzBUrLi98bIB+U0tB5y7IeqUgq/+Zo=;
        b=OXeQ26lb/M9qWZMq78opKMbB2I6KopIGRrNKi9hUStAi2W6vYvCJANoh98Eor/d7CC
         wRO2m9vmSGrMC0DaZI52bL2azWc9xe1uTFt6tcnlobwtHkNWqA0D6d3BgU0LbTgtfIC/
         i61pEFXVDivolwH5h1uMtlprg9LyyBY6+7xmL9BRztyLG7Fb6XaSGe8Y2e8Z2HYcggTd
         rIga95kNAaXL9u2c3GWiObWOTkn0in2i1OoPz9eTW+4n8oK/f0g3+EEpIdiQyBJzTz+J
         ZQfITVtHssrsvX+0Zsl12qVFg0G0apQWDBDNjD9BqgNvJyc1JDd64MvEQYUF7PYw3yml
         AnUA==
X-Forwarded-Encrypted: i=1; AHgh+RrDguAdvlMiKmefze1wU5XLEyTuNHJ1KCi6DaeiYnUHvYHvamdxcewTf+eIqJ7oOt5ghjCfgso=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzhEEQFTXIdWkGf+CcHHz3Gw6rXfX01WNjHJN/eJHUuyqD7xR61
	vJMCIb2tpA7kdWpCBY489mFV7x8EtQApqbYfk/mjKAfePW+UXuPkmMlhyTbLRPDPtvFIN+xVjI7
	73t2qs2TVbeUgFicfx2yBbRi5w9huF1NKmZ0oAo9kEPYVRIFNvJ0/PbBtbBJ2X9hAVvufGTexIE
	pLIdGj
X-Gm-Gg: AR+sD10uQM1keKni+mZdmAgp20XnR/6eCsy4wqhHh+GpvxDOukDA654ujUbS+Sy9QLN
	CtgsqaJoZaxnKv1OzGc3RcD9nS/iXLAPfGgNDsZRCiQ6SPxMk3ncxoi0myqLH3jMi6Q9BDMeqQd
	xcfwkIvpl3w1/QQyIW1nwy0W8QF42ET9LWg/qu0qiIB9pewhe5Im50KTusZBEVilUJMUVOHU2UQ
	gu0z7jbvvczN6DoZhuzQgsSahCa69CoTkgHz2Y2alPvKdTL1AXgXDhMso3i7zqikbGh6vLaLEqT
	cU6dqQ6G1uceW1urmnsP6k8zrnRUx9pDCHIJq4682wJN1+4SfS/tmWQe1XPB8fJbZMBgt/iUaD+
	KRrihppwuN4ccFXiass/QsahNFQ==
X-Received: by 2002:a17:902:d2ce:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2cf34997962mr232058415ad.22.1784703606338;
        Wed, 22 Jul 2026 00:00:06 -0700 (PDT)
X-Received: by 2002:a17:902:d2ce:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2cf34997962mr232057865ad.22.1784703605648;
        Wed, 22 Jul 2026 00:00:05 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm9428935ad.22.2026.07.22.00.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:00:04 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:29:17 +0530
Subject: [PATCH v2 6/6] firmware: qcom: Add support for TEE based EFI-var
 client driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-6-b8a8fcbe4211@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784703569; l=26036;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=LosjvZDIaSYjB3Gq/q9l/AWJ3RurWA5UZWsVfICp0jM=;
 b=GL8Pd5NDBHbqi734JZA1eYHtk7R6u5+4cDNw052g8mCFumrKvTjv4P5BRtatR9Q3bq2pfmgrY
 /kVUyTjbnv7Ad7dvuoyuGMboF5fFMByZtbiiQmo45Qz8CIvDL/Mu5Y1
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: b_U3Ypr0JzKFW6UvjI5kxNVOHze2-q0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfXysQcU241P0Mt
 +Gdd/KMFJJsgjhaXjcCQsfnIn0nzU16BQtLibOTqDHPJwBmV6yhLJzlTcWKhjAUK4C2hXrBMOAS
 4adZldSLm7Zfx1HRQkNLUbcUBrNVpf6+kYGElp60XZJcGJjnQs/XlMFdO1i0rx9OsCbydS24AyG
 tryhNXW81D/3WORZCXclU9lkViHgIUAlnZtbFDyvwU7YZbVfX6PuMnfUmOPD6JakflMss347shV
 +69Pb8C3WV1tjHUH4KoAoLHorBgMwzoPndLil4tuBnQhRPOkZMFJBn10cMzrB412hMby7mtNXAE
 7hutEeOejocjjYF5C7WGavgOXjpzlSQQw88CK2eUWlomQrvmGnZmEB1Ra+MMwhQjLGYZ2LHOiZ+
 UAOWGiGIIKgQwjtJ8v88G8l9wJuD7HKSyA9nCho7XcsqQbIIHVJ9eoCe+/8hr3FkubbaYCACaDB
 XDbg5Qq8uwhIwUG9pAg==
X-Proofpoint-GUID: b_U3Ypr0JzKFW6UvjI5kxNVOHze2-q0V
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfX7s1D9W/pshp7
 jezdqiv6iRy9KgTebolexUQoYr1qV5zld2ypfCYg/pjChzmJhwmTU+FE2NotubroqzE3ZGcQmLQ
 Rq8V23/IGTtmnAI5obj7GlGwPhCwTpU=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a606a77 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=lX1A334Kam2MR8cuwK8A:9
 a=ZP9I4r549iL3ZUHD:21 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220063
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A4774450DE
X-Spamd-Bar: ------
Message-ID-Hash: UXRA2MCFFWD43SJR5UAX7LFMSAF5E35D
X-Message-ID-Hash: UXRA2MCFFWD43SJR5UAX7LFMSAF5E35D
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UXRA2MCFFWD43SJR5UAX7LFMSAF5E35D/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

On Qualcomm SoC based platforms, UEFI stores EFI variables within the
Replay Protected Memory Block (RPMB) which is only accessible by the
Qualcomm Trusted Execution Environment (QTEE).

For Qualcomm platforms without emulated RPMB support, specifically
platforms where RPMB is not located within SPI-NOR storage and instead
located on UFS/EMMC storage, non-volatile EFI variables can only be set via
a callback request from the UEFI Trusted Application (TA) to the RPMB
service running in user-space (within the QTEE supplicant).

Unlike the QCOMTEE driver, the QSEECOM driver (used by the current
uefisecapp client driver) does not support callback requests. And on
certain Qualcomm platforms such as the RB3Gen2, attempts to access the
QSEECOM interface fail due to lack of support within QTEE.
On all such platforms, a TEE based uefisecapp client driver must be used to
access cached/volatile EFI variables within the uefisecapp TA and ensure
persistence of writes to non-volatile EFI variables through the RPMB
service hosted in the QTEE supplicant.

Add support for a TEE based uefisecapp client driver which installs efivar
operations after obtaining an object reference to the uefisecapp service.
This enables the kernel/user-space to access/modify both volatile EFI vars
stored by the Secure Application (in-memory) and non-volatile ones stored
within RPMB.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 MAINTAINERS                                 |   7 +
 drivers/firmware/qcom/Kconfig               |  24 ++
 drivers/firmware/qcom/Makefile              |   1 +
 drivers/firmware/qcom/qcom_tee_uefisecapp.c | 525 ++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_tee_uefisecapp.h | 120 +++++++
 5 files changed, 677 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10d12b51b1f6..e8316007370f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22018,6 +22018,13 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
 
+QUALCOMM TEE UEFISECAPP DRIVER
+M:	Harshal Dev <harshal.dev@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/qcom/qcom_tee_uefisecapp.c
+F:	drivers/firmware/qcom/qcom_tee_uefisecapp.h
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
 M:	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index b477d54b495a..20ce8b58e490 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -74,4 +74,28 @@ config QCOM_QSEECOM_UEFISECAPP
 	  Select Y here to provide access to EFI variables on the aforementioned
 	  platforms.
 
+config QCOM_TEE_UEFISECAPP
+	tristate "Qualcomm TEE UEFI Secure App client driver"
+	depends on QCOMTEE
+	depends on EFI
+	depends on !QCOM_QSEECOM_UEFISECAPP
+	help
+	  On Qualcomm SoC based platforms without emulated RPMB support,
+	  specifically platforms where RPMB is not present within SPI-NOR storage
+	  and instead located on UFS/EMMC storage, non-volatile EFI variables can
+	  only be set via a callback request from the UEFI Secure Application to
+	  the RPMB service running in user-space (within the QTEE supplicant:
+	  github.com/qualcomm/minkipc). Unlike the QCOMTEE driver, the QSEECOM
+	  driver used by the QSEECOM based uefisecapp does not support callback
+	  requests. And so on these platforms, the TEE based uefisecapp client
+	  driver must be used to ensure persistence of non-volatile EFI variables
+	  via writes through the RPMB service hosted in the QTEE supplicant.
+
+	  This module provides a TEE client driver for uefisecapp, installing efivar
+	  operations to allow the kernel and user-space access to EFI variables.
+
+	  Select m here to provide access to EFI variables on the aforementioned
+	  platforms if your Linux distribution has QTEE supplicant installed and
+	  running.
+
 endmenu
diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
index 0be40a1abc13..d780490b2865 100644
--- a/drivers/firmware/qcom/Makefile
+++ b/drivers/firmware/qcom/Makefile
@@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
 obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
 obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
 obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
+obj-$(CONFIG_QCOM_TEE_UEFISECAPP) += qcom_tee_uefisecapp.o
diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
new file mode 100644
index 000000000000..9a5a6f145a9f
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/efi.h>
+#include <linux/tee.h>
+#include <linux/tee_drv.h>
+#include <linux/ucs2_string.h>
+#include "qcom_tee_uefisecapp.h"
+
+static struct qcomtee_uefisec_app uefisec_app;
+
+static int qcuefi_get_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
+			       struct tee_param_ubuf in_attributes,
+			       struct tee_param_ubuf *data,
+			       u32 *out_attributes, u32 *out_errno)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
+	u32 nparams = 5;
+	struct tee_param param[nparams];
+
+	struct {
+		efi_guid_t guid;
+		u32 in_data_size;
+	} in_cong = { 0 };
+
+	struct {
+		u32 out_data_size;
+		u32 attributes;
+		u32 errno;
+	} out_cong = { 0 };
+
+	in_cong.guid = *guid;
+	in_cong.in_data_size = data->size;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id, QCOMTEE_UEFI_SEC_OP_GET_VAR, nparams);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
+	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
+	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, in_attributes);
+	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
+	SET_TEE_PARAM_UBUF(param[4], UBUF_OUTPUT, *data);
+
+	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_VAR invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	data->size = out_cong.out_data_size;
+	*out_attributes = out_cong.attributes;
+	*out_errno = out_cong.errno;
+
+	return ret;
+}
+
+static efi_status_t qcomtee_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid,
+					      u32 *attr, unsigned long *data_size,
+					      void *data)
+{
+	int ret;
+	u32 in_attr, out_attributes, out_errno;
+	struct tee_param_ubuf in_data, in_var, in_attributes;
+
+	if (!name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	/* 'attr' can be NULL, however an input attribute is always expected
+	 * by UefiSecApp TA
+	 */
+	in_attr = 0;
+	if (attr)
+		in_attr = *attr;
+
+	in_data = (struct tee_param_ubuf){ .addr = data, *data_size };
+	in_var = (struct tee_param_ubuf){ .addr = name,
+					  (ucs2_strlen(name) + 1) * sizeof(*name) };
+	in_attributes = (struct tee_param_ubuf){ .addr = &in_attr, sizeof(u32) };
+
+	/* On SUCCESS, 'data' member of 'in_data' has already been updated. */
+	ret = qcuefi_get_variable(in_var, guid, in_attributes, &in_data,
+				  &out_attributes, &out_errno);
+
+	if (ret)
+		return EFI_DEVICE_ERROR;
+
+	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT) {
+		/* If 'attr' is NULL 'out_attributes' is not updated. */
+		if (attr)
+			*attr = out_attributes;
+
+		*data_size = in_data.size;
+	}
+
+	return uefisecapp_err_to_efi_status(out_errno);
+}
+
+static int qcuefi_set_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
+			       u32 attributes, struct tee_param_ubuf data,
+			       u32 *out_errno)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
+	u32 nparams = 4;
+	struct tee_param param[nparams];
+
+	struct {
+		efi_guid_t guid;
+		u32 attributes;
+		u32 in_data_size;
+	} in_cong = { 0 };
+
+	in_cong.guid = *guid;
+	in_cong.attributes = attributes;
+	in_cong.in_data_size = data.size;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id, QCOMTEE_UEFI_SEC_OP_SET_VAR, nparams);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
+	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
+	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, data);
+	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(*out_errno));
+
+	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_SET_VAR invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	return ret;
+}
+
+static efi_status_t qcomtee_uefi_set_variable(efi_char16_t *name, efi_guid_t *guid,
+					      u32 attr, unsigned long data_size,
+					      void *data)
+{
+	int ret;
+	u32 out_errno;
+	struct tee_param_ubuf in_data, in_var;
+
+	if (!name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	in_data = (struct tee_param_ubuf){ .addr = data, data_size };
+	in_var = (struct tee_param_ubuf){ .addr = name,
+					  (ucs2_strlen(name) + 1) * sizeof(*name) };
+
+	ret = qcuefi_set_variable(in_var, guid, attr, in_data, &out_errno);
+	if (ret)
+		return EFI_DEVICE_ERROR;
+
+	return uefisecapp_err_to_efi_status(out_errno);
+}
+
+static int qcuefi_get_next_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
+				    struct tee_param_ubuf *out_variable,
+				    efi_guid_t *out_vendor_guid, u32 *out_errno)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
+	u32 nparams = 4;
+	struct tee_param param[nparams];
+
+	struct {
+		efi_guid_t guid;
+		u32 in_data_size;
+	} in_cong = { 0 };
+
+	struct {
+		efi_guid_t guid;
+		u32 out_data_size;
+		u32 errno;
+	} out_cong = { 0 };
+
+	/* Pass size of available buffer */
+	in_cong.in_data_size = out_variable->size;
+	in_cong.guid = *guid;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id, QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME, nparams);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
+	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
+	SET_TEE_PARAM_UBUF(param[2], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
+	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, *out_variable);
+
+	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	/* UefiSecApp TA does not touch 'out_variable.size'. Update it here.
+	 * On SUCCESS (!out_errno), 'out_data_size' is length of name in 'out_variable.addr'.
+	 * On failure (out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT), 'out_data_size' is
+	 * actual name length.
+	 * Otherwise, it's undefined.
+	 */
+	out_variable->size = out_cong.out_data_size;
+	*out_vendor_guid = out_cong.guid;
+	*out_errno = out_cong.errno;
+
+	return ret;
+}
+
+static efi_status_t qcomtee_uefi_get_next_variable(unsigned long *name_size,
+						   efi_char16_t *name,
+						   efi_guid_t *guid)
+{
+	int ret;
+	u32 out_errno;
+	efi_guid_t out_guid;
+	struct tee_param_ubuf in_var, out_var;
+
+	if (!name_size || !name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	if (*name_size == 0)
+		return EFI_INVALID_PARAMETER;
+
+	/* For 'in_var', 'name_size' is not necessarily size of 'name';
+	 * could be size of buffer where 'name' has been stored. TA expects a
+	 * NULL-terminated string in 'name' and ignores the size.
+	 * For 'out_var', 'name_size' is size of buffer pointed by 'name'.
+	 */
+	in_var = (struct tee_param_ubuf){ .addr = name, *name_size };
+	out_var = (struct tee_param_ubuf){ .addr = name, *name_size };
+
+	ret = qcuefi_get_next_variable(in_var, guid, &out_var, &out_guid,
+				       &out_errno);
+	if (ret)
+		return EFI_DEVICE_ERROR;
+
+	if (!out_errno)
+		*guid = out_guid;
+
+	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT)
+		*name_size = out_var.size;
+
+	/* On SUCCESS, 'name' stores the next variable name. */
+	return uefisecapp_err_to_efi_status(out_errno);
+}
+
+static int qcuefi_query_variable_info(u32 attributes,
+				      u64 *maximum_variable_storage_size,
+				      u64 *remaining_variable_storage_size,
+				      u64 *maximum_variable_size, u32 *out_errno)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
+	u32 nparams = 2;
+	struct tee_param param[nparams];
+
+	struct {
+		u64 max_var_storage_size;
+		u64 remaining_var_storage_size;
+		u64 maximum_var_size;
+		u32 errno;
+	} out_cong = { 0 };
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id, QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO, nparams);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(attributes));
+	SET_TEE_PARAM_UBUF(param[1], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
+
+	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	*maximum_variable_storage_size = out_cong.max_var_storage_size;
+	*remaining_variable_storage_size = out_cong.remaining_var_storage_size;
+	*maximum_variable_size = out_cong.maximum_var_size;
+	*out_errno = out_cong.errno;
+
+	return ret;
+}
+
+static efi_status_t qcomtee_uefi_query_variable_info(u32 attr, u64 *storage_space,
+						     u64 *remaining_space,
+						     u64 *max_variable_size)
+{
+	int ret;
+	u32 out_errno;
+	u64 maximum_variable_storage_size;
+	u64 remaining_variable_storage_size;
+	u64 maximum_variable_size;
+
+	if (!storage_space || !remaining_space || !max_variable_size)
+		return EFI_INVALID_PARAMETER;
+
+	ret = qcuefi_query_variable_info(attr,
+					 &maximum_variable_storage_size,
+					 &remaining_variable_storage_size,
+					 &maximum_variable_size,
+					 &out_errno);
+
+	if (ret)
+		return EFI_DEVICE_ERROR;
+
+	if (!out_errno) {
+		*storage_space = maximum_variable_storage_size;
+		*remaining_space = remaining_variable_storage_size;
+		*max_variable_size = maximum_variable_size;
+	}
+
+	return uefisecapp_err_to_efi_status(out_errno);
+}
+
+/**
+ * qcomtee_release_object() - Release an object returned by QTEE.
+ *
+ * Each object returned by QTEE repesents a secure service exposed to the
+ * client. Whenever an secure service is opened, QTEE may allocate resources
+ * on the client's behalf. Therefore, once the client is done accessing the
+ * secure service, the object representing it should be explicitly released
+ * so that QTEE can release the associated resources as well.
+ *
+ * @ctx: TEE context.
+ * @object: The object to release.
+ */
+static void qcomtee_release_object(struct tee_context *ctx,
+				   struct tee_param_objref object)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	SET_INVOKE_ARG(inv_arg, object.id, QCOMTEE_MSG_OBJECT_OP_RELEASE, 0);
+	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
+}
+
+/**
+ * qcomtee_get_uefisec_svc_obj() - Get a UEFI Secure App service object to
+ * begin communication with the service.
+ * @ctx: TEE context.
+ * @client_env_obj: The client environment object returned earlier by QTEE.
+ * @uefisec_svc_obj: The UEFI Secure App service object.
+ *
+ * Returns 0 on success.
+ * Returns < 0 if client environment object invocation failed.
+ * Returns > 0 if client environment invocation was success but UEFI Secure App
+ * service object could not be returned for some other reason (represented by the
+ * returned value)
+ */
+static int qcomtee_get_uefisec_svc_obj(struct tee_context *ctx,
+				       struct tee_param_objref client_env_obj,
+				       struct tee_param_objref *uefisec_svc_obj)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = client_env_obj.id;
+	u32 nparams = 2;
+	struct tee_param param[nparams];
+	u32 uefisec_uid = QCOMTEE_UEFI_SEC_UID;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id, QCOMTEE_OP_CLIENT_ENV_OPEN, nparams);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(uefisec_uid));
+	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
+
+	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_CLIENT_ENV_OPEN invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	*uefisec_svc_obj = param[1].u.objref;
+	return ret;
+}
+
+/**
+ * qcomtee_get_client_env_obj() - Get a client environment object to begin
+ * object exchange with QTEE.
+ * @ctx: TEE context.
+ * @client_env_obj: The client environment object returned by QTEE.
+ *
+ * Returns 0 on success.
+ * Returns < 0 if root object invocation failed.
+ * Returns > 0 if root object invocation was success but client environment
+ * object could not be returned for some other reason (represented by the
+ * returned value)
+ */
+static int qcomtee_get_client_env_obj(struct tee_context *ctx,
+				      struct tee_param_objref *client_env_obj)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u32 nparams = 2;
+	struct tee_param param[nparams];
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, TEE_OBJREF_NULL,
+		       QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS, nparams);
+	SET_TEE_PARAM_OBJREF(param[0], OBJREF_INPUT, TEE_OBJREF_NULL, 0);
+	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
+
+	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	*client_env_obj = param[1].u.objref;
+	return ret;
+}
+
+static const struct efivar_operations qcom_efivar_ops = {
+	.get_variable = qcomtee_uefi_get_variable,
+	.set_variable = qcomtee_uefi_set_variable,
+	.get_next_variable = qcomtee_uefi_get_next_variable,
+	.query_variable_info = qcomtee_uefi_query_variable_info,
+};
+
+static int qcomtee_ctx_match(struct tee_ioctl_version_data *ver,
+			     const void *data)
+{
+	return (ver->impl_id == TEE_IMPL_ID_QTEE);
+}
+
+static int qcomtee_uefisecapp_probe(struct tee_client_device *tee_dev)
+{
+	int ret, err;
+	struct tee_param_objref client_env_obj;
+	struct tee_param_objref uefisec_svc_obj;
+
+	uefisec_app.dev = &tee_dev->dev;
+	/* Open context with QCOMTEE driver */
+	uefisec_app.ctx = tee_client_open_context(NULL, qcomtee_ctx_match, NULL,
+						  NULL);
+	if (IS_ERR(uefisec_app.ctx))
+		return -ENODEV;
+
+	/* Obtain a reference to client_env object to begin object exchange
+	 * with QTEE
+	 */
+	ret = qcomtee_get_client_env_obj(uefisec_app.ctx, &client_env_obj);
+	if (ret) {
+		err = -EINVAL;
+		goto err_get_client_env;
+	}
+
+	/* Obtain a reference to the uefisec_svc object which provides access to
+	 * the EFI var storage.
+	 */
+	ret = qcomtee_get_uefisec_svc_obj(uefisec_app.ctx, client_env_obj,
+					  &uefisec_svc_obj);
+	if (ret) {
+		err = -EINVAL;
+		goto err_get_uefisec_svc;
+	}
+	uefisec_app.uefisec_svc_obj = uefisec_svc_obj;
+
+	ret = efivars_register(&uefisec_app.efivars, &qcom_efivar_ops);
+	if (ret) {
+		err = ret;
+		goto err_efi_vars_reg;
+	}
+
+	/* We don't need to keep a reference to this object anymore, we only
+	 * needed it to obtain the uefisec_svc object.
+	 */
+	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
+	return 0;
+
+err_efi_vars_reg:
+	qcomtee_release_object(uefisec_app.ctx, uefisec_svc_obj);
+err_get_uefisec_svc:
+	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
+err_get_client_env:
+	tee_client_close_context(uefisec_app.ctx);
+
+	return err;
+}
+
+static void qcomtee_uefisecapp_remove(struct tee_client_device *tee_dev)
+{
+	efivars_unregister(&uefisec_app.efivars);
+	qcomtee_release_object(uefisec_app.ctx, uefisec_app.uefisec_svc_obj);
+	tee_client_close_context(uefisec_app.ctx);
+}
+
+static const struct tee_client_device_id qcomtee_uefisecapp_id_table[] = {
+	{UEFISECAPP_UUID},
+	{}
+};
+MODULE_DEVICE_TABLE(tee, qcomtee_uefisecapp_id_table);
+
+static struct tee_client_driver qcomtee_uefisecapp_driver = {
+	.id_table	= qcomtee_uefisecapp_id_table,
+	.probe		= qcomtee_uefisecapp_probe,
+	.remove		= qcomtee_uefisecapp_remove,
+	.driver		= {
+		.name		= "qcom-tee-uefisecapp",
+	},
+};
+
+module_tee_client_driver(qcomtee_uefisecapp_driver);
+
+MODULE_AUTHOR("Qualcomm");
+MODULE_DESCRIPTION("TEE client driver for Qualcomm TEE UEFI Secure App");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.h b/drivers/firmware/qcom/qcom_tee_uefisecapp.h
new file mode 100644
index 000000000000..a014c18cfed0
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_TEE_UEFISECAPP_H
+#define QCOM_TEE_UEFISECAPP_H
+
+#define QCOMTEE_OP_CLIENT_ENV_OPEN 0
+#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS 5
+
+/* Each service exposed by QTEE is identified by a 32-bit UID */
+#define QCOMTEE_UEFI_SEC_UID                 413
+
+/* Operations supported by the UEFI Sec App service */
+#define QCOMTEE_UEFI_SEC_OP_GET_VAR 0
+#define QCOMTEE_UEFI_SEC_OP_SET_VAR 1
+#define QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO 2
+#define QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME 3
+
+/* Error codes returned by the UEFI Sec App service */
+#define QCOMTEE_UEFI_SEC_SUCCESS 0
+#define QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER 10
+#define QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED 11
+#define QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED 12
+#define QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION 13
+#define QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR 14
+#define QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES 15
+#define QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED 16
+#define QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT 17
+#define QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND 18
+#define QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED 19
+
+/* Operations for objects are 32-bit. QCOMTEE transport uses the upper 16 bits. */
+#define QCOMTEE_MSG_OBJECT_OP_MASK GENMASK(15, 0)
+#define QCOMTEE_MSG_OBJECT_OP_RELEASE (QCOMTEE_MSG_OBJECT_OP_MASK - 0)
+
+/**
+ * struct qcomtee_uefisec_app - An instance of UEFI Secure Application.
+ * @dev: TEE client device on the TEE bus which represents uefisecapp.
+ * @ctx: The context opened with the TEE subsystem by the uefisecapp client.
+ * @uefisec_svc_obj: A TEE object representing the uefisecapp service.
+ * @efivars: EFI variables registered with the EFI subsystem.
+ */
+struct qcomtee_uefisec_app {
+	struct device *dev;
+	struct tee_context *ctx;
+	struct tee_param_objref uefisec_svc_obj;
+	struct efivars efivars;
+};
+
+#define UEFISECAPP_UUID \
+	UUID_INIT(0x01f95dcd, 0x2d7e, 0x58be, \
+		  0xa1, 0x43, 0x81, 0x32, 0xa1, 0x72, 0xdb, 0x7d)
+
+/* Short-hands for these long attribute names */
+#define UBUF_INPUT     TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT
+#define UBUF_OUTPUT    TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT
+#define OBJREF_INPUT   TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT
+#define OBJREF_OUTPUT  TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT
+
+/* Init instance of 'struct tee_param_objref'. */
+#define SET_TEE_PARAM_OBJREF(param, attri, obj_id, obj_flag) do { \
+		(param).attr = (attri); \
+		(param).u.objref.id = (obj_id); \
+		(param).u.objref.flags = (obj_flag); \
+	} while (0)
+
+/* Init instance of 'struct tee_param_ubuf'. */
+#define SET_TEE_PARAM_UBUF(param, attri, ubuff) do { \
+		(param).attr = (attri); \
+		(param).u.ubuf = (ubuff);  \
+	} while (0)
+
+#define TEE_PARAM_UBUF(x) ((struct tee_param_ubuf){ .addr = &(x), sizeof(x) })
+
+#define SET_INVOKE_ARG(arg, object_id, opp, nparam) do { \
+		(arg).id = (object_id); \
+		(arg).op = (opp); \
+		(arg).num_params = (nparam); \
+	} while (0)
+
+static inline efi_status_t uefisecapp_err_to_efi_status(u32 err)
+{
+	switch (err) {
+	case QCOMTEE_UEFI_SEC_SUCCESS:
+		return EFI_SUCCESS;
+
+	case QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER:
+		return EFI_INVALID_PARAMETER;
+
+	case QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED:
+		return EFI_UNSUPPORTED;
+
+	case QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED:
+		return EFI_WRITE_PROTECTED;
+
+	case QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION:
+		return EFI_SECURITY_VIOLATION;
+
+	case QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR:
+		return EFI_DEVICE_ERROR;
+
+	case QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES:
+		return EFI_OUT_OF_RESOURCES;
+
+	case QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT:
+		return EFI_BUFFER_TOO_SMALL;
+
+	case QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND:
+		return EFI_NOT_FOUND;
+
+	/* No matching on EFI_* list. */
+	case QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED: /* EFI_ALREADY_STARTED.  */
+	case QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED: /* EFI_VOLUME_CORRUPTED. */
+	default:
+		return EFI_DEVICE_ERROR;
+	}
+}
+#endif /* QCOM_TEE_UEFISECAPP_H */

-- 
2.34.1

