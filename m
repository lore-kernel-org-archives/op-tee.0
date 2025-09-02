Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45742CA0FFE
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 05:02:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 95B454FD74
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 05:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756789363;
	bh=696U7/FWwaaFIGlzeZRWykn9zjUkr8pce7ma6fekJEY=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mS047gvMeYM7IVjIZSm/31xXrF5Iu5/iae4NT01jKcKE7vZK7nJwLNj2SDKDYaL4y
	 hQEIWftAfNYFpnTYGdjlIsO100/+QTmxcgG3tD2kI4eECqlqkRT0v5gjvlMxW3BV2K
	 CTELT3flAkafovcvgU7m1ggnf0w+LOUbJIDyQdcrt85Bge3ZiOoQpGqsuQ0v/tmyeM
	 jhzK5Zjdwg0Z7UYL6b/ZuZQJhTrLGm4Wj1y9tc0B2kgeXl4gT9qfL2pglXx3/vMigL
	 P62B2vqvLAerioY8vFNlH54PYbuYsGQYXpnY0JusqeqZUVx2FbaV7iYvih3FDsIJ6T
	 xVRz4TlqIKdjQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7C6464FD5E
	for <op-tee@lists.trustedfirmware.org>; Tue,  2 Sep 2025 04:56:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tx4vpK2W;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S6hI030132
	for <op-tee@lists.trustedfirmware.org>; Tue, 2 Sep 2025 04:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4C5VhC/4pFCnYsmQJ5EmNbV8HXu0TRSksgnPURzlR3I=; b=Tx4vpK2WBWhiCtNY
	sm8/FoCB0SlXn37FORfYCgOjeQemeJ+LUOOETXQnEpU3iT1gg48+xYQYmiqqEDjH
	YlLvUrEakatZJT2NVCkbY8cC1x0OY4F28Xd89XznVUJb6yGUmoebgKRG9OMfZASS
	cVB+1BG8wKyNAk8rId4bZlpUCSiZ0jW0y2HCxJgJ9tJ1cQt1nh5nlA/6noek+//f
	3lr9VfvgN2Ogih1uKI0Y40B0KWdbBNOm6OTbb+JmIJnk+7IdDbq4f7ICQkKJiXV4
	7hOBQeX0qItaRIg7VEu2hEnVwuUVNMUcXIz1lrWg3kACSeXjqt3ZCYTboFHAW90v
	G5CdVA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy2b9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 02 Sep 2025 04:56:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-248981c02cfso54470355ad.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 01 Sep 2025 21:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788989; x=1757393789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C5VhC/4pFCnYsmQJ5EmNbV8HXu0TRSksgnPURzlR3I=;
        b=U3zzh4gmD1sW9FK6AFxSvIkGnm/+mai24aMnU+wt9MULDVxm9na8VdTslMgxCITnQP
         fsuvQWROU0/WL8itI5pBQ1WGgG8RdIFi2Vor+eDfmWEInHOnrF00T0jhuqdmo4ybrP5n
         DvEDh+EaQgXjq27GOte9nluuD+m0kM9FIu/5GjNOGTZOPxPL2elRp0IqQudGLDxMvV/C
         YTGntq3jh31Z8q3wDQSELbtVg0TeKr3t/I8X9p8mdcpPIyl2B56hADuM9KK0Zb6HqFzg
         muMqbyI0rT1WJVh7UESLIsE7Gg1GSzaUqy3/Rz6TnsmRFH5LgWACrY9ZXAAWU2eWD1bU
         RP7A==
X-Forwarded-Encrypted: i=1; AJvYcCVC2neKwUzsv/Up33EUCbhjmkqil1wyrHZp9FLSIEoBW0ZIy4BGnY9T9RKUUve7MzJnAAPXlKY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxkKoQkmyy60cQSITCPfNLcdvxVvbWyK+ftOI/oS3Teaf1ll4SK
	LdgNKWbfrsIHHb/ZbGO0mJMw3a5CmIntybhPSoz5k9eVa7Ua7kiqZBztn0Q1O8bi/cXMrib5jrR
	HfVBjyK3aWcX/Fz0ZlF8tBNlZCXzkUgAcZkjQRirr+VUbdEZa5peKo1oVtHjZsqzutb4ubG4=
X-Gm-Gg: ASbGncvQiUm9cH2L/2N0NBBDarDivvcAWRHyZVdOnMJFvZENGi5rhPbZlv9HgFgvUVH
	BHrpZt7Jfpc/b2tGIomlBuwc/Gtck/8nXMLuVtsDyj6roNV/V0XXXXBBpbi4kIY9HFgqewDqJG2
	Q+8SOSU10bXY/3F9RTbeMBf2z0D9Apl1ynHbbKo6nGWTWLC/juh7GRcrs3ns9EJjgB4STezCVsR
	mQOQF+N0R3oU5QOJkCLJI72GYjBDk7OhtZaU3E2M5A1+l04kck/1IBXV1WbT18CfWuUIkRQ/0Dk
	xzSsSWkabR9+dUc00WCklFSJsjW/5J3TuXfC5AynNKxEzgs6OV6CTUbr5BODeNH12eYCny/3ooK
	xnnsvg4qnXgjvbf6wM2P8cJg=
X-Received: by 2002:a17:902:d502:b0:246:fdf7:2c71 with SMTP id d9443c01a7336-24944af12e2mr132951165ad.47.1756788988610;
        Mon, 01 Sep 2025 21:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7F0eEjJmAaiuShpIkxQfExITaVHfEaEVCThMdzzbDlLzUzKrz3dCFXLdIOBLWZwLgt+OxrA==
X-Received: by 2002:a17:902:d502:b0:246:fdf7:2c71 with SMTP id d9443c01a7336-24944af12e2mr132950855ad.47.1756788988089;
        Mon, 01 Sep 2025 21:56:28 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:27 -0700 (PDT)
Date: Mon, 01 Sep 2025 21:55:58 -0700
Subject: [PATCH v9 11/11] Documentation: tee: Add Qualcomm TEE driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-11-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b678fd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Cse2D-HSohUGfAP-fCFfStuKoWJuitpC
X-Proofpoint-ORIG-GUID: Cse2D-HSohUGfAP-fCFfStuKoWJuitpC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX1nOXyB12dHwn
 ogMq4exqHev49N/F8pZ0kzHSiuOXchCLKbCQdOy9RGp0od9yFkSLVm9WMZrV4YLJaFFdspt0oZQ
 KhDUcOJxgoQu7Kc2x/szyggg9hyB0MkpuS3sbbvMNCXewxxMaVjxoBkqJSCYEZBGS4S/NZiXyCv
 gpiDSGaOuA7JxmpM72H0rGLddS6dls8YfSnlpfuZ9dipAF9HPVnS/IKvmsqCrX1BwPDeLWBNiFv
 QSK+DRP8M3vodJpHFDGfElVgPHpTEMKg/mwbADP8NG+bdLb4HT3gdy+5LwRYZb/vYq1A+ocO6w0
 5E+AI2FVVwUAAvYnJcaEnK9RLogXujomRgfw1BbYqQyCwN8G/2FWpUzAjOVMXBvDBA5oRVNyhH1
 XfFsp8uS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
X-Rspamd-Queue-Id: 7C6464FD5E
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.20)[129.46.96.20:received,205.220.180.131:from];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: J3BNFC6EM6TNK7NQCS3XUSGDDWBZO4OU
X-Message-ID-Hash: J3BNFC6EM6TNK7NQCS3XUSGDDWBZO4OU
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J3BNFC6EM6TNK7NQCS3XUSGDDWBZO4OU/>
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
index 5086db700aeb..bac9436f65c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20984,6 +20984,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR

-- 
2.34.1

