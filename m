Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33E4C83F1D
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:57:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3E4C645A1C
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752454675;
	bh=oUzmLIFl9vCPfoPNulUuSOSohYJa56PJu1YTll4mynw=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=l11ANNwYz2+AMvGXUKzwIOTbc+e/08cYF+A5iFTF8/YrUfnpwXdeXdvCHXMAKLKc4
	 lN97YL7PgA9e8kYp43H8f/85J4HxOuJMk1QItzjROIbbPdcLSVqqyx9o0ayGZX1u3a
	 RWLT118Xw+LM+Y4jtq5G/BdJzVtGV+VmJ2V7XQkKzAiCOP360MHp/3O84OMn+3oIdR
	 D6Y7QNB2aIzm+n5v8WLMmJbltVXftvhdKgjHw8zWtMHwhZZtpncss2WxyclGQzo+39
	 IrRsw7ODxKM9TiDUD11NkfZzX0Oz7FmJC03ThSU+mvlNU0eHM/yky9PdX1+Y7gDqOr
	 2kHIfVRyHQyvA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1770A4FB40
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hx3SdW3j;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLrc9U000609
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ytumVm0CoQT2UiSI9m4EbOedIWBaTexPn7wx5CCAvew=; b=Hx3SdW3jIaJ2J6kn
	qs34+ISXzB3q/nhpt/OvBf9CeFhOdrG2AZUhj3X8IoS0GfUUlyUMahWMRQrX+sou
	hIeoJidq+je9jw0pm6kQOk7ZFcIJc/Pu6ZZf9qcHDtOTvYPDnX0hhZdJgOl3GMzf
	VX08q7RaIU/r3t1MkjjYeal6yc+Q1FxW9UyAjNGQDIszdAbEo3Nq3kn25L5fSVd1
	i66kzfI5GADoeLojAyGk/x5EB5plrIvxoC73rWwidbVSMcoYbwdvs7zEkGFtKhw8
	OV4OtQmkP2lJ85t/w+Z8A0R4NVeHbWoHhzGf3lHjdlNuSZVH2qmtz1cYPur9nhHt
	2xGUZw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmtss8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b39280167fdso3007955a12.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 13 Jul 2025 17:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454239; x=1753059039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytumVm0CoQT2UiSI9m4EbOedIWBaTexPn7wx5CCAvew=;
        b=nRZAIBNQN9m14ImP/fVwkS0bxcyJvilJ3izjLSUdSfvD7CKd3QtL6WKzNaOK0Nt+yT
         J2ZvE83siPnqGkp3rOlo/jZCmj1jUvb5y8wSqF85qkZR9w52uoK/TToD2UnsylymkjXc
         1WlkzAMtJPc3XkGLkgRNBwZwX8fXl5Gbq5fpnXtmeUY/9OXrlGmwZX86n6t+BGMOWpha
         nqbCdPHETBWYxSHmvGCDS8szVzeGIqKsG0hSfx5BYU7wkTmvN8yCBpnIRsjUI+zDDydg
         7PPUe+L2FiRdHplp1+oeawc7AG6D+Thw3p1kg/aUVfYsfpZsIvHoilLYU9Qtjw4QqSYd
         fZnw==
X-Forwarded-Encrypted: i=1; AJvYcCWGn/z33BSeC0WRkSO1En1K7k5rCA4ckYCmPGhAxmKuy4sjSheJ+sTrKMxcCfkIvHFlt5mc2xU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzjFnq1AozFVpWayFqRx1dpBbJF1y6JtdMMImqPu4Q/dlujvRt0
	fkGBbKwf35Wqxi81NztGJ9unDJ1ObTDPQ/Rmu1WS+xVR0fi00vO29u5OQrG6P1Esk0UMKoYXIQy
	Fwzxg/m2gf8ZRBWZNn84WN8WRAUg+Ko7FcI/fR92V688W/N2vdW/JGYbod0p2Hs0rXD66w5Y=
X-Gm-Gg: ASbGncs39se7KASFrg0BYoN4/wtAQ+lRYjgy3f1F9bpx+qBUH357/5NsUahyQDpIBer
	In+xEbnK0w6ATK4f/Yy/qNye3WMwh7DLfKzX2aj6V3qaeUu0bNY+BHovtkJ2mckZUXGQugjnqF2
	vibrqf1JuV0nRooNTuSHygWX2ydzaFmfXqJCWGFaa/bORL4YgNoWHF0J4QV/4C0MoNbzmQnW+Fe
	gEWR7HiOlTJQEg6Erl1mnMo0tmWorFHyQZyvgBkTVk5BhEtQ4GBw3KILwGXxhV7j2H5FHBDAHEg
	PocQhtUmQD1qFgiGjFRFvRlboNE02/VSs/pYXzJWTTG5IzyXyq/+aDylsRBjyx5dOx9vj+gZ3gp
	fF5w/QJ34s0eTgR7g9GJw32M=
X-Received: by 2002:a17:90b:5804:b0:311:b005:93d4 with SMTP id 98e67ed59e1d1-31c50e2c50dmr15386692a91.25.1752454239103;
        Sun, 13 Jul 2025 17:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3jGL0eHjBRDOFcNGYXTZVoUK2+ayeWgQN5DlcGBALaaf5nl7YCP7GQ2hWPGEb1tdZhuWi8g==
X-Received: by 2002:a17:90b:5804:b0:311:b005:93d4 with SMTP id 98e67ed59e1d1-31c50e2c50dmr15386649a91.25.1752454238650;
        Sun, 13 Jul 2025 17:50:38 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:37 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:49:24 -0700
Subject: [PATCH v6 12/12] Documentation: tee: Add Qualcomm TEE driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-12-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-GUID: bEeBNM5KY0hR9Y-NAQQJi6t-CJmn-cTI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX8vh6+aTt7QuX
 J8CLX8XrtmEnJFxAP6U+FdCgbkUz192kPc6PAKlMiazgUUqRdpZ74sQfZb+DLar6YscU5f76Pwa
 F7/0LVxfg3/+aOWkjjyRVwCQADJ9xrDIK6H8YqBjnfdU5n84NKg9ldXEg34NyMaZ56FtJuR5xZO
 /PF+lzxiDH0iGH/UjwdHY/7vsrh8NHCnyNTcrXBPJtCucbmxXZrXPB1eiL1n78LbKcqjtiZrvJN
 bzaJyaSLaG3HoGnYoWCXKYaWLnfofaAEFnxxtM6vMmeUg2kl8MeuIV86iTLCrkeNyBeTAkkVmPa
 PPjrlJFC/5Y7c1DsPBFuP0oR6jUJlwb6GUBwMRhniYpRdPhPw1v8sVC8ZPdNs0tuOeTSBWvdsVn
 kj8Pd4nZ8jMKSyeAp00yFLitwn14lbYKKQ3A53jm6kVrAHU9ymFcZ0/L97H3i4ZJYDgIPkDd
X-Proofpoint-ORIG-GUID: bEeBNM5KY0hR9Y-NAQQJi6t-CJmn-cTI
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=68745460 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1770A4FB40
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
Message-ID-Hash: BFIDULBNV6TTVFBMRQ4WN7DJVNQ3EURB
X-Message-ID-Hash: BFIDULBNV6TTVFBMRQ4WN7DJVNQ3EURB
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BFIDULBNV6TTVFBMRQ4WN7DJVNQ3EURB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add documentation for the Qualcomm TEE driver.

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
index 9fc58f48fa14..391fc6e6defc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20706,6 +20706,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR

-- 
2.34.1

