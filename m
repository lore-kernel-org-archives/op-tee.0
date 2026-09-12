Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342B3C79FB6
	for <op-tee@archiver.kernel.org>; Sat, 12 Sep 2026 10:18:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7F7D7443EB
	for <op-tee@archiver.kernel.org>; Sat, 12 Sep 2026 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789208279;
	bh=48SRyTLQwb6N0QIS0UsPI0LsEuN5TTV58p7/i+2YBbM=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eUyFBKYR9Lw+Y0e2MmczD2qRwiJYyVnEVtok26Ex2vo4LhQXQbqvdW4ZzoM0iK5Xc
	 cGa+3mCb8mJXnjRjL5k9wXn2jviSvnDVGjOyh88T2G82RkN7c7mcjFbZenHenQlcsI
	 8bvEYul7EWDx62RMfHtKNWEOlp5yZDq+sMTsU18Ej2PY2lgXJTcj9AmD6JJwqo6cM2
	 ZSDtZZ/glGyEP0tlLwBuQidmyYvs2baukVo2utA+I9Fl35eH82tchshVy2LRPeShbz
	 mxM37S8YP3iM6fSAeSXAnNBHU9EcOTMk/ggkhml0RS7XpK6Nv1Hp5P1124/MrBQiHq
	 1Hvq3Im3Jx/5g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B505E45480
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h9P10Eq/;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OISXr/CV;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C84tOh2663815
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fvGdQtR+Qwoj5VESRUaaVEODegCn4Sli4jhlqF7Rgls=; b=h9P10Eq/EjHe7DFE
	AHgtUu+UIQ9wbQglsmtTmEED1LS3t9Jq2HDfhzSlGFoAMdZWvziEZf+Xbuz1CSkl
	uHzWeZY3qegkmYQkSu4W9Tjjkp+sOq0Hcl59jMrptzK4lNfhTlNmvUA9k83gkFNT
	Z3+6pocgFldsyLB5gwj5JFlGAT/xQC/OxwM6k1ZTxoyI1ATMNZDUQE5AUcvuBO4H
	/C+arjehUGRr+Kpi87yn0uq5DuuxCnZAzX39PSee4MeIdkcK7af2wBMmeb1P3K/6
	9YbX89jsZyIjFZMnCBSsTaCyufqdm3usdlxa9Ig5MDKkZ/vwBqGXW9bfkARkjh+N
	/lPZZw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c8pnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398fe469aa0so3077155a91.2
        for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789208135; x=1789812935; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvGdQtR+Qwoj5VESRUaaVEODegCn4Sli4jhlqF7Rgls=;
        b=OISXr/CVRPefayhJcM64uCPtTk22tqZdKdq5rOxM+07s/qUznIqVcrFHf5wOKK4Pr4
         0Ooz9aPsryvAD90wCE/+wyDbhhthgUyT6dH/2QboizS8yCa83HI/cRGoHfSlMkpC+Gkg
         CW6PHMU0d/QjnAif9XrQIJB5sFBnXPJRIja6NDLgsDrSUDdmfeEUBT+jCgaa/5vjV+Gh
         NR14uIWKnrAoExK7xwB272K+Abm/ZkJyDDi7xFfA4OKTXMD6HlIlXBiz4tehoCkCTdoN
         V7YSrj6m0PouYid47SuBCpWkexXy5uw6Aa+K3a9HTWzD8lb58gkxZedoURzjVAjNJTS0
         kgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789208135; x=1789812935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvGdQtR+Qwoj5VESRUaaVEODegCn4Sli4jhlqF7Rgls=;
        b=a83s4w1TBqTbiktSTjoEavAEVtzqYXIO4upthaJ5z+6LlwxLy2DZsu+FZfNSNVpF4d
         jYLxo2cEcmDMdhUeL6bHFHNF6+oByDRIlm4cXgZez1SE9p926TbihP5IfFhvJDf+a9iE
         bCPFxsf8AOntsx4ozdyn6lirPHE7/MKhxDbL6ELxS/aE+EC4wUAF7Myygba8MGj1LLBR
         sh3TbsHzy01m8EZyOsAm5zaOxstRykHMuXiVqKoyrAR8pz+AXHMf1h6YfuFRmxXFU9os
         BjAciULMp/b0NgFe3hWpH95Z+QQEg6VNi44DfEZnih1mvuovaczT6DetUaOsO6g4vLIX
         7L9w==
X-Forwarded-Encrypted: i=1; AKwUvByB10iYskRTXuW+kiZEG9Rx5DpZUQPfwTXJ35PApKj2oYb0oc7n6g+8saEQRKNvs0XXTrMrkC8=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lAiHlr9zqtDrjRMdd3w6y+a57rb0xGs3ThGepFDriDTGm8ydlP
	SgNVlNIOCgDpVUR4DpghEQLLihsDr+BXvJvGJ3dxVtIy2UMtTdxN4StHKmKZqfdbvygeNYAu5l2
	htE9e7pjR6IC552/GZ6lEKVgSGk16HBERdIL0s5Vwpeq5iPsAvjrCybymJrPnY98OM+BF/XY=
X-Gm-Gg: AYBFou1+7OpE1uWJl6p/N6ItS7Bq1JLbMXKR4TOxKQXwyFnUbzvqi17xZtx6+GE+qmL
	7fAp3tP+OJA1XEk+DwZnJ1aw9pFYLEEk3tnYQxamIETf8OHtnZuUJ0ivzDK0VEMDpeeYQQL6OOJ
	QQK7vvGJ8tDjrDffv6jnY5ymgH02/VEZgGT0m+AkNBwdyu7jLLT7yHKmR4SIwXmiGr1drjH9J6V
	MLHJ/1PfPXP8Lha3zKUj3tM+GXZNqmTncfbtWcXtPIYsTQcGEe84J5I5aMGMKq9TAppnfCygJAt
	smgyMs+2CqZBXmfGa3nMFfVpF7CRGu/Mzhv9nQCSEcE3bLUKhEx6JIDQU2EviJhLH2u3Fu+/JQx
	WdMhRh30ju7u8N/aqmgoKliK89RC3otbrnaSr5vspWgvaJ8l0GyU58B6X2zU=
X-Received: by 2002:a17:90a:d2cb:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-39d9c234851mr13405559a91.14.1789208135072;
        Sat, 12 Sep 2026 03:15:35 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cb:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-39d9c234851mr13405513a91.14.1789208134601;
        Sat, 12 Sep 2026 03:15:34 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm10340085eec.8.2026.09.12.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:15:34 -0700 (PDT)
Date: Sat, 12 Sep 2026 03:15:16 -0700
Subject: [PATCH RFC 5/5] dt-bindings: tee: add RISC-V RPMI TEE transport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-rpmi-tee-service-grp-dev-v1-5-1d1d35c2a859@oss.qualcomm.com>
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
In-Reply-To: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=e+mT2qp/ c=1 sm=1 tr=0 ts=6aa52648 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=b45o4kL6AAAA:8 a=UjdUaUu09JUVB5va2ocA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22 a=dhdsR-PFWuPJUldTnwXm:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE0NiBTYWx0ZWRfX9Bt7CN9q/hql
 VEK1kN8GP/AK3E/Fmgo27+XhvCS4uIDPMCTn+IAgQY7GHisPeKc5szf2AWQA0dgNN199/zNRDDh
 q3DgtHi2JWqR4uTLJ4TEhwMwZZfZAyo=
X-Proofpoint-ORIG-GUID: Rbiimoz-055c43z5sepqEjLelkxK8Ab9
X-Proofpoint-GUID: Rbiimoz-055c43z5sepqEjLelkxK8Ab9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE0NiBTYWx0ZWRfXyi02aFPGvD+s
 J4K+zVkdKprHKeFpw68zVLhe9wfPPS7ME/kWfHOqhTyIWJwwJvPlwDxXWFa00+TPFn9cstIx7Hs
 xp+klyOw5qTMg28KdF2hURJZNkvI6UVcvENAlcD3p90cvAu+hmJDgmiN4LLw7OdBnhq6PPeASCX
 H5z0H61NT5357sOgOeCElTNL2dsn5wyTogemJLQdBc3cq2vn/jvI6ZmFHKfinDbJ2IQR+fQFDlM
 Sfi0C19ZHzZcpeg/TfXswKV40MZVCGr4zoFnX6Qi5UNZ6PWqiYGe/Tz3RMeNQ1kiZZJArsGThUx
 A83PgVH7/mY5JLoDyo6FJ/j0cpmkFhlUfAjcjMTOs1Zox3nth6U/W1De4Cv9x5AbLwmNdHyjpk9
 AAnmYMTX0CkZxHO9UmEON/NiF3Xa/aHDcMO5GjfwdZGa46nRVl0TodGgcweRZIcBjm9JMDsTHXm
 4FrsGhbFuc4l/Yw7zoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	URIBL_BLOCKED(0.00)[oss.qualcomm.com:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,mx0b-0031df01.pphosted.com:helo,mx0b-0031df01.pphosted.com:rdns,devicetree.org:url];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B505E45480
X-Spamd-Bar: -----
Message-ID-Hash: VXUBDUCWY6MKXCBYYCUTLG7PCOHPPKY2
X-Message-ID-Hash: VXUBDUCWY6MKXCBYYCUTLG7PCOHPPKY2
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VXUBDUCWY6MKXCBYYCUTLG7PCOHPPKY2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add a device-tree binding for the OP-TEE RISC-V transport using the RPMI
TEE service group over SBI MPXY.

Describe one mailbox channel per hart and an optional interrupt used as
the availability doorbell for asynchronous notifications.

Add the binding to the existing OP-TEE MAINTAINERS entry.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 .../bindings/tee/riscv,rpmi-mpxy-tee.yaml          | 65 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml b/Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml
new file mode 100644
index 000000000000..8f6ff313fd42
--- /dev/null
+++ b/Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tee/riscv,rpmi-mpxy-tee.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI TEE service group based message proxy
+
+maintainers:
+  - Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a messaging
+  protocol which is modular and extensible. The supervisor software can
+  send/receive RPMI messages via the SBI MPXY extension [2] or some dedicated
+  supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines a TEE service group which is the RISC-V
+  analog of Arm FF-A: OP-TEE and the rich execution environment (REE, i.e.
+  Linux) are peer endpoints and the RPMI framework (machine mode firmware)
+  mediates every message. Entering OP-TEE on a hart runs it on that hart until
+  it responds, so the SBI implementation provides one SBI MPXY channel per
+  hart; all of them are listed, in hart order, on a single node.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    const: riscv,rpmi-mpxy-tee
+
+  mboxes:
+    minItems: 1
+    description:
+      One SBI MPXY channel implementing the RPMI TEE service group per hart,
+      listed in the same order as the CPU nodes.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Availability doorbell raised by OP-TEE to signal asynchronous
+      notifications over the RPMI TEE signal bus. Optional; when absent
+      asynchronous notification is disabled.
+
+required:
+  - compatible
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    tee {
+        compatible = "riscv,rpmi-mpxy-tee";
+        mboxes = <&mpxy_mbox 0x10 0x0>, <&mpxy_mbox 0x11 0x0>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 207a6e2db70c..7d0e550085b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20577,6 +20577,7 @@ M:	Jens Wiklander <jenswi@kernel.org>
 L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-optee-devices
+F:	Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER

-- 
2.34.1

