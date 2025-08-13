Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F56CA0EC4
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:42:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9FEDB4FC50
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755045730;
	bh=8Vle92yZY9xDtV8ytKjL5d+JCb2sWNmHvm13yHE47Fc=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=LsZ+YSqCo7hTXfQVRtWrkfrEyCjpbnUR4YrCr5tWG3fO5jh3w+1pFCyPYkEs8118s
	 grELCCTG2awGHJczBXfQj2Ka45Z6DhKJ1zdUXyB7Er8kqwizYz/rhEjpnSjrtWmQ4k
	 fDWFX4J7WWrpZzh15oZA0c006YhLLc3mVtWPMXvz9TmNX6bzI9hwu3Xm12gJtv+8jO
	 W8HCOhtupzFz5mX39GzS9pkh51HQMf/8gDC6vXirIhkiRuw5ZO2dC/vvg5DFf/zvTt
	 BtX/RsHLY4vjkFVy4kJJrDD3kNSZza0WNN0WP6aFDSKzZVus1ZqQEFzLTcS6jNw9DM
	 FiVOCp0JtuqeQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3DBD6453FD
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AZqlctAO;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CK5H3E006385
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E9mIUmeVItJmyNwVFThGc/lr2aPxFoGHJijUqp9TSw4=; b=AZqlctAOyc6uApD2
	2Dvft7OJAvLN3DqMZTOexglXu5CtJjX210i9h3xdeCad6ICLWA6QU4V4Bm9rpiEe
	/5yM/6PV+QHBRNNRwaa6rlc7rg8h/RV2c3Tkmu/QdDDDy17NqfPOjRcQVJsa/2B8
	/JH69lCW929T9eWFx/yE9EajcfMrdD4VpbTt54yVflauE/1YmFvixpLWGMDQw7tM
	/M6/bdZdfjuTVyiPV4wrddxhZx7DYlyeBD3NPF5G4xIDICO6s0aosqz+ccRr8UyY
	8SkXPe3gFwQ6OGBpMkZ4kmL9plzYUcIxPQY7w04XZM+qUez5dEg+vUx3y4gSknEZ
	xI17zA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjnqcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-240012b74dfso44160435ad.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 12 Aug 2025 17:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045436; x=1755650236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9mIUmeVItJmyNwVFThGc/lr2aPxFoGHJijUqp9TSw4=;
        b=DOGoqM75rb9ExX/6pw9G9JGEXxgM3Lv1aPn0TIGOLr2QwRUEfugwBj7Mkge8TY0Bty
         SOzRvX6NxUyg38BPpyxM7sNKLDSsTnwe+AlkleOaewGEWZTpGh9Ifk9UgcAh1t2t95qL
         xgG3BgjBXCIIw/Grap892BuRJqcnK9AQEr7muc5EJUHJ20e8FzW/Y30gFwsP6uOEyMjE
         ok2/WY8agcSrelTaon0R4nhbzdOnx4mtztKStVfTL3YOLwPKXcnN0f8a47GHPOu0GPFa
         FHU5TAlOVQISNOmuBS7yJFLtiaYA/DtE7swZ8b01rfrSmjEPZKdi0WHg9sccbPcA7AHi
         1gzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmnmCNANzyDcjaE/1Be4HXYyK0joH6iotlyR4eM5MolnG17nF6Jq9pUZWQMZfGEzfn1ujQY1Y=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwpD1E5CM/k60uNcpoFtKsPrTEKU9BUTFj055b0Px+cPfnHtntL
	czCaifgXqV1bMfRkLFBckVqu31WMsjebz/eOI8kOw845vxzfwh+8K4Z/Z2NcJPwUDT8IovSVXSr
	iM7c+Q79ws4g/Dwmt+mQKQ036gf6WJa/zj1v0fH14ljNphRmXZTu8rWamBNn4//F1u+hlGVA=
X-Gm-Gg: ASbGncst5f+qu7+ndWzXuJfVgXVc2ZOzTfxe+Sp06gqmJSlsoLll/EAxaDU6gU53LC1
	qHznpB7GJf9uz7Yg94Vd5RDmpSt39P27rqonfz63AM6mkBkB1zXHoGlSCZhfAr9DlBV9bWzCRl2
	Y8/X56AdF+rO1Qs01BiO/BVBZ1uFYUoyis/ktIU+/1Yvpl5DmvnObc4mkJOQ5b88AvDXVhJzy6u
	4B/UvPUUMyrvX+JeKp8vTe/C23Ej8cYv6etvRkTMCnwmLnMGr1GIAFw9IwEJoXtyXQvvRXgbOae
	cUGYJeDJhBBrJTyokIIN33IXXyjEMokxihksrSsgbLmQyP3m0SIal3DfCPAGePSgmHzvh/ySrUc
	E39ylomhLgKMk3xdt4uF4Bfg=
X-Received: by 2002:a17:903:2406:b0:240:49bf:6332 with SMTP id d9443c01a7336-2430d218afamr18366355ad.47.1755045436364;
        Tue, 12 Aug 2025 17:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFZ8I3i9S0gbmT7ZeBnhrBjqJHd1AmbumO63/UoIlLeoWED+/XTZ7ApkX0E4vEWA225OAgzQ==
X-Received: by 2002:a17:903:2406:b0:240:49bf:6332 with SMTP id d9443c01a7336-2430d218afamr18365875ad.47.1755045435828;
        Tue, 12 Aug 2025 17:37:15 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:15 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:35:40 -0700
Subject: [PATCH v7 11/11] Documentation: tee: Add Qualcomm TEE driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-11-ce7a1a774803@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX9c4D8NCmR5+P
 8Mtu3pYiU2oFfPrnqay9pibc6SCYa954Bk/W7LjB7MFOxFbWOzOn+QnUKJjlmWCVQxKsZGGQFk4
 NDEsmEChMD95T5mRCHPyUpDFW1//7yl3OAW/rFyyQsGCDRLt/YqC6V6CXTo3HDre0LYv5zhg8fW
 zV/KddeUcJdgonVHz3WiVImTvljI2QV0E9iBLa63yaUHm6gkSnmkElW8JH+XTDF2cxp5Bem7Ur4
 lZKyS31uXocX1dpUO64IXBDQk49u4SspenDil2H5uM8UolqbLNFRVooV1A8rmbfzLppCGeTfst9
 X2wrJ0ZquVjuKsI5pOlKWeMrRdJL+I/Zi725Nr0I0ddxinzS1/3LHPWcpNZHUb/rFZ0rPoXCcZg
 03QQeW3Y
X-Proofpoint-GUID: G0g1I8lFGbECOVvAfqIL23BCCZEzP4YF
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689bde3d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: G0g1I8lFGbECOVvAfqIL23BCCZEzP4YF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074
X-Rspamd-Queue-Id: 3DBD6453FD
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
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
Message-ID-Hash: 5IHLMHNDXZMOKO7XY67X4TJX5YXILRQA
X-Message-ID-Hash: 5IHLMHNDXZMOKO7XY67X4TJX5YXILRQA
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5IHLMHNDXZMOKO7XY67X4TJX5YXILRQA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add documentation for the Qualcomm TEE driver.

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 Documentation/tee/index.rst |  1 +
 Documentation/tee/qtee.rst  | 96 +++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                 |  1 +
 3 files changed, 98 insertions(+)

diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
index 4be6e69d7837..62afb7ee9b52 100644
--- a/Documentation/tee/index.rst
+++ b/Documentation/tee/index.rst
@@ -11,6 +11,7 @@ TEE Subsystem
    op-tee
    amd-tee
    ts-tee
+   qtee
 
 .. only::  subproject and html
 
diff --git a/Documentation/tee/qtee.rst b/Documentation/tee/qtee.rst
new file mode 100644
index 000000000000..2fa2c1bf6384
--- /dev/null
+++ b/Documentation/tee/qtee.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================================
+QTEE (Qualcomm Trusted Execution Environment)
+=============================================
+
+The QTEE driver handles communication with Qualcomm TEE [1].
+
+The lowest level of communication with QTEE builds on the ARM SMC Calling
+Convention (SMCCC) [2], which is the foundation for QTEE's Secure Channel
+Manager (SCM) [3] used internally by the driver.
+
+In a QTEE-based system, services are represented as objects with a series of
+operations that can be called to produce results, including other objects.
+
+When an object is hosted within QTEE, executing its operations is referred
+to as "direct invocation". QTEE can also invoke objects hosted in the non-secure
+world using a method known as "callback request".
+
+The SCM provides two functions to support direct invocation and callback requests:
+
+- QCOM_SCM_SMCINVOKE_INVOKE: Used for direct invocation. It can return either
+  a result or initiate a callback request.
+- QCOM_SCM_SMCINVOKE_CB_RSP: Used to submit a response to a callback request
+  triggered by a previous direct invocation.
+
+The QTEE Transport Message [4] is stacked on top of the SCM driver functions.
+
+A message consists of two buffers shared with QTEE: inbound and outbound
+buffers. The inbound buffer is used for direct invocation, and the outbound
+buffer is used to make callback requests. This picture shows the contents of
+a QTEE transport message::
+
+                                      +---------------------+
+                                      |                     v
+    +-----------------+-------+-------+------+--------------------------+
+    | qcomtee_msg_    |object | buffer       |                          |
+    |  object_invoke  |  id   | offset, size |                          | (inbound buffer)
+    +-----------------+-------+--------------+--------------------------+
+    <---- header -----><---- arguments ------><- in/out buffer payload ->
+
+                                      +-----------+
+                                      |           v
+    +-----------------+-------+-------+------+----------------------+
+    | qcomtee_msg_    |object | buffer       |                      |
+    |  callback       |  id   | offset, size |                      | (outbound buffer)
+    +-----------------+-------+--------------+----------------------+
+
+Each buffer is started with a header and array of arguments.
+
+QTEE Transport Message supports four types of arguments:
+
+- Input Object (IO) is an object parameter to the current invocation
+  or callback request.
+- Output Object (OO) is an object parameter from the current invocation
+  or callback request.
+- Input Buffer (IB) is (offset, size) pair to the inbound or outbound region
+  to store parameter to the current invocation or callback request.
+- Output Buffer (OB) is (offset, size) pair to the inbound or outbound region
+  to store parameter from the current invocation or callback request.
+
+Picture of the relationship between the different components in the QTEE
+architecture::
+
+         User space               Kernel                     Secure world
+         ~~~~~~~~~~               ~~~~~~                     ~~~~~~~~~~~~
+   +--------+   +----------+                                +--------------+
+   | Client |   |callback  |                                | Trusted      |
+   +--------+   |server    |                                | Application  |
+      /\        +----------+                                +--------------+
+      ||  +----------+ /\                                          /\
+      ||  |callback  | ||                                          ||
+      ||  |server    | ||                                          \/
+      ||  +----------+ ||                                   +--------------+
+      ||       /\      ||                                   | TEE Internal |
+      ||       ||      ||                                   | API          |
+      \/       \/      \/   +--------+--------+             +--------------+
+   +---------------------+  | TEE    | QTEE   |             | QTEE         |
+   |   libqcomtee [5]    |  | subsys | driver |             | Trusted OS   |
+   +-------+-------------+--+----+-------+----+-------------+--------------+
+   |      Generic TEE API        |       |   QTEE MSG                      |
+   |      IOCTL (TEE_IOC_*)      |       |   SMCCC (QCOM_SCM_SMCINVOKE_*)  |
+   +-----------------------------+       +---------------------------------+
+
+References
+==========
+
+[1] https://docs.qualcomm.com/bundle/publicresource/topics/80-70015-11/qualcomm-trusted-execution-environment.html
+
+[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
+
+[3] drivers/firmware/qcom/qcom_scm.c
+
+[4] drivers/tee/qcomtee/qcomtee_msg.h
+
+[5] https://github.com/quic/quic-teec
diff --git a/MAINTAINERS b/MAINTAINERS
index d19a49d60b41..0b476b794f8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20882,6 +20882,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR

-- 
2.34.1

