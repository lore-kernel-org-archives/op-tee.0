Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FB8CA5FAB
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:19:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 937DE454C7
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790651995;
	bh=uFKjlolwn1ciafhDBmMwI2akc2BNZltPTKgmRmWckzk=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rBjxN1Z3zmY8nRz3OhE/Ii5otZHVfLdv5hb6Z+QGPbJnYkQNLbfOGuY1F7iAmNAeG
	 DcLB1+cdELUppQjwT9nDe7SH6j1pjWuDbo90Ec4vRLxgeEUbs0yr2AzSDEShbdqi+u
	 /ehVXE4sX3LoPUbCC0jH7c4CISFL1sNXpwrYA/43JUbVXd/EUavYxzEO3U4QRegG/Y
	 Y/+xUlZoiN/REIX4bh+moVfITFyaDxt9jKFdLM/3Ftv/NfZ8bJaB24yxptP4jJyVSf
	 efiIb+CcYD7DtWuZVDOWtkbhkyW4i4ilUFgIPw2GFBHDj+/GCB0H/vGy2JsMLF5jEu
	 tyM4Zl+QM77dw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C0F2C454BC
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RBYjQyfQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Umhu1n7q;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0jGOw2342323
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dASJnt3k+iJPNvbft15iYvw/242GHxpDWKpgPsBPFKM=; b=RBYjQyfQIm0ZW0Mv
	9bx+8E+EwcRxCBq0N4hspGuNB4YGuxsej+iq4FDqh+o/F9nCFvq6w0rJPK2QVJGV
	ui/0zYqKJIBWorO+gAPf9Tnoa7aeyP12imF+MqWLFJnd1PfutZKgwLFl9UVm5f3S
	vFEjp48hpL3uubhkjYYa2HETFdhrlVOiS9oF9B6YRqAMllOJPI7Tt8glf1qIsyLm
	pWM32xlNb8rsq4ajsjzeHb4N4u4+K9pEj1Mdq76hJLOEdvUWz/DJCIhGwsTl2bxm
	slbiNmIu2kW0nyhd0pTxkKBhIvqVrDtnj+V/+HDbj23L7AfzK7U3VGdsaAwF86hJ
	EdaNkw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw21w3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:50 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-142f4306744so806941c88.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 20:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790651870; x=1791256670; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dASJnt3k+iJPNvbft15iYvw/242GHxpDWKpgPsBPFKM=;
        b=Umhu1n7qP6vWBljReNYzDB9f8vvsET/KNnTwWh2Hioio7tNLswALMxiOSAyF7GoVBw
         kC53Erx64IB+jBJ2wV+nM19N/+InSxpVrzxvngCQAkeboK2wAsZL3ng/CIu6mHJ/+1Hf
         ktdYOqRnSMvAxMEgGI03eT/P7wJzYloZY62tpABr/2NVCPOS6ueNVG2gJXQq3bPvsHCk
         OvsN6yzbVNXTu0Jpn74uAvR7fGI4a/TQ8VdGHsr38fL1ckTrOvnENln7ZA716zRVna/S
         H21PVPTFCR6ZJS+7IlFZxJdv/T1iqRKZb50eKav5UT+ETvKGz2EFYlFPCd1/14dwMwFa
         vv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651870; x=1791256670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dASJnt3k+iJPNvbft15iYvw/242GHxpDWKpgPsBPFKM=;
        b=O43rP6hinTVerz0y0rWY4NbvEuiLVTGPCGayQiPQe+UJASpfh6Zf7gySsHP7npJR3q
         +SxDKmMz/Wfc3tcHC8B83Sgm24OYpqRn9CK/iQe6FKbxuSMgLSUDPJKVVJharagaWBHa
         GRt9YxWPkNJiMTFF+vH41n7nR6CHWlF2kQtq7VLwQEtsCnyRJzN+P2ut7NsYbPKImGe7
         ORpn47+XyENsx7xQHVYQi0x9rWROS4xbnkJuqra7FVVA3Roy+H+cz9yQrdXJ7qFD6kg7
         Isd+R7hTjmPHfTHIk06IOS0O9JgPZnzXSFA4eFNdcC37FOZx6+MvGDCwC1R8ou2RvllE
         C2Nw==
X-Forwarded-Encrypted: i=1; AKwUvByLWYiHDViL3Aft8q5WTjO1/uVzpEYIYxeMATc3b7oe9dPaW2VejLnz5F1F3PSV3u/g4CIL+Zw=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mKiIWAOAP4zWlMwGcspgcUwHPUO3gvRYrelVTD+65pw1cMr+UI
	2SZcKocmtdMcz1SvCPVGQSYJ6IeX8CiW/WULOnkRsa0JeRgIG3I/AD/WqxIQUu2hCNRWLZqnlOt
	z3f09HdH8uMamC23ImedfEuEJRbLt4ZKIcKIuZ9S5JHzdswIsd501yx213uYLq2YBJlyxQ5Q=
X-Gm-Gg: AYBFou0VDyuEloA2T8GeEHTK5zK+K0Ban7+fmrgrXfmnIzyu3I+Y426z54X9MB4Jwh0
	g153Pc2ek1VAplQk1k/Z9jVUCJAFflLGXOPkfZ5XMxaIrhjgdCttqaisXOO1YO+UUiHBu7NNjVu
	rQzCD1roDK21MhQf+v/DyS1BE8fPNuN4kLknbw+aNLMalzWXybUR/BT5B5ql6SrJDpUxB5DzMNP
	7pEV738SHBqjwILBvCGlEDBdPxfR06rBlFOm6batok+NqpQSVQ6c4sS7lJJ7m5q2t7t6/FFmhC9
	BV5RDpSWuAXAAiRxKkf8Vq6ASLglIwjXOXFj9RcmJOnm5w9InrdGILagveLoulrWe73O+m0ulfg
	uSqle7JzwyYjnp61PiiRXNNatdYg1pjX7sowJTo39QPx0aqb0mXVsXLJUWho=
X-Received: by 2002:a05:7023:881:b0:143:2984:6516 with SMTP id a92af1059eb24-146d096b3damr13332479c88.37.1790651870000;
        Mon, 28 Sep 2026 20:17:50 -0700 (PDT)
X-Received: by 2002:a05:7023:881:b0:143:2984:6516 with SMTP id a92af1059eb24-146d096b3damr13332436c88.37.1790651869421;
        Mon, 28 Sep 2026 20:17:49 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm24789368c88.11.2026.09.28.20.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:17:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 20:16:55 -0700
Subject: [PATCH RFC 04/10] dt-bindings: firmware: add RISC-V RPMI TEE
 transport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-riscv-rpmi-tee-abi-v1-4-04908b81d885@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb2dde cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=X9k_jdDNchH65YliorYA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: NfdXt7dJk90Ci3JTaL6flc1SN9XzC7mD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX6GAseBRdY961
 hmlAFfGr6v+4Q4PxLLvPu27Cc/4mIj1fsEktLh0suVbCP4qze2C9RqOuaom8/98Z2CGle3D+DY0
 aTONB5ptelz6g5NjcS7xjWgALuZp5xwIsICkV3YRViQVeeFsZaDyXB2GukJIA22IXEZYxXSTOAI
 8yd/gpa9/cQ6wb+0sfK9vfkxjuxI0CVSPghqDDXLyVEqC1uh+V7PEDENGKjN8x1zL9Ufgb3NNml
 9IltDS6kkQW++OA4jpQJAqqWW1eLSy2exaJcnwy27/aqlvizNqNK54TsIWoH5T5MEyh5IHkZ+9o
 VqMWe7ZNVA29YXCvJ41i7ZCDG2CTaWTOzDXBJpIHO30XKEQoyVS9g3l1svfSjoDo/mV4bEvWYnx
 Vk0xkZsPPRSCMhpYmJuV7V2485rXgxQQJtjeo3jqsqk4uKXEX96XRNWZpVxqRVET5xUkTgeVTvk
 LXbds96yZ+M0NY2Vv3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX0w62r/qo00+w
 hwFL/wiHI83Dafy1vfnKp5QL67XnVnSh8Eb9mhUZz+ByXuaNCRyXuL1DhHrooTyOHaRSBDr9jJG
 L8tYNrzO0n7DVillKMhnpcPw/+OFZaA=
X-Proofpoint-GUID: NfdXt7dJk90Ci3JTaL6flc1SN9XzC7mD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.59 / 15.00];
	BAYES_HAM(-2.99)[99.95%];
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
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.72:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C0F2C454BC
X-Spamd-Bar: ----
Message-ID-Hash: W2LE5MPWBJGOEFTMBKRVP55FO5DW3JAE
X-Message-ID-Hash: W2LE5MPWBJGOEFTMBKRVP55FO5DW3JAE
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/W2LE5MPWBJGOEFTMBKRVP55FO5DW3JAE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Document the platform device that carries the RISC-V RPMI TEE
service group over a single SBI MPXY mailbox channel.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 .../bindings/firmware/riscv,rpmi-tee.yaml          | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/riscv,rpmi-tee.yaml b/Documentation/devicetree/bindings/firmware/riscv,rpmi-tee.yaml
new file mode 100644
index 000000000000..32287f27a625
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/riscv,rpmi-tee.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/riscv,rpmi-tee.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI TEE service group transport
+
+maintainers:
+  - Amirreza Zarrabi <amrzar@gmail.com>
+
+description: |
+  The RISC-V Platform Management Interface TEE service group is carried over
+  an SBI MPXY RPMI mailbox channel. The transport discovers TEE services and
+  creates child devices for their endpoint and UUID pairs.
+
+properties:
+  compatible:
+    const: riscv,rpmi-tee
+
+  mboxes:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    rpmi-tee {
+        compatible = "riscv,rpmi-tee";
+        mboxes = <&mpxy_mbox 0x3000 0x0>;
+    };

-- 
2.34.1

