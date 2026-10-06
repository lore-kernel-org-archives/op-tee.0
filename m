Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F398CA5FFF
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:40:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9C5B44542C
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791247233;
	bh=xfd7voO7tE36nEMwmvhnhqtwXd+9sNurmzQCmvHnQy8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gmHaG4tkk/xG0qexr9trHXY+uFUDzlQdIBGMVXsVKWX018PH/zbPsbaNDYsdJCZQO
	 WCNWdQcBcybdvyoKhYYTuN7fFMDi2OwxuGOkfKENIYP8u3y/nCiEdRoAzyJMyvoR5T
	 EPcg2F8wHgtp/UucDZxpz2Ym/C6lURSrvfUBmMAZHWdKQdqc5A3Q1ESVDaKdArd8mq
	 zDbzmPYT0cUQUMiVM8qav7nnWS0YhC1liA8+eadeX22gseNLO89Np3jEd0YE6kIE1L
	 4CNNavN04GSlkm2QruhHIn5Uy+vfMsyxcGdVR2k953MCWbXFzZqTJ0vn6NobW3yhlb
	 wUe2XtU02+DtA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 047074519A
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 00:39:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZA10ErgS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aPmCiSJQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695KNEUP2955278
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 00:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TyCY3djL8PN+a1DxJAYuBVVySj7YPULq6/PcA5HDv1k=; b=ZA10ErgSLT5HyZY/
	Y/v6nBvWCR6Qu9GdffazmR+/AhVDkA7RSXUQmK8zR6MB/avSOV+MH6alNdBF07QU
	TO2MT3rprFdLcyL+t5zpwHsFWC2N0LqE72EYdcYnbREVB4h833h0/vAqaQlP4NRD
	X+PmL3+EFnrpUgd6X+M/zMmFZpQ8hT0SLmmPk1Gvnv07D5OxHfTk0r/JxER8Udf4
	OcmjtEYBl5oij8mdAs2RVf4ZWBCPJxtaF23MryLm5ivkqzXnqT7WeieyxOibraXJ
	uDeIxTeBvqev9ff+RMn1NoA16XR8oWYEq1K/n9dYbcKrY8YBTVeSVQ1+AO1Q8PpS
	YK7o9w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cj62gcx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 00:39:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34d62bb27a1so9514167eec.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 17:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791247194; x=1791851994; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TyCY3djL8PN+a1DxJAYuBVVySj7YPULq6/PcA5HDv1k=;
        b=aPmCiSJQ4s0vDrARhThqanKOM7tgRUGrNPpSZyM9CtGQZdiuOZtGIEelSiHNtwgXqj
         cL7l4DwiGU9fnbJIVS1YD8KPApOdABIa66ZBGDfxtaeDQMNHRnsX20A48tLHa00GwK+n
         enGcWN6XBN44sZ3BMpDCDE/2gIgGp0TkzBSqlRwi/nA3W0uovWV13hOm3nIQGFJDQp4Q
         yXeN6LiTk89SK4cvgY6Odr/wyYHOf63R/me5JiNMbbiVRB6oZiGMMyLo4pwRaZLY0VjJ
         1OFRgNyhZe7v5VSEYi6NEWLQbpN0nRGMN+ASaLTl5nQSSEd27UYN03zGCnS/fZYuzd/N
         tE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791247194; x=1791851994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyCY3djL8PN+a1DxJAYuBVVySj7YPULq6/PcA5HDv1k=;
        b=0fLCT4bsG3/aode/zwvWrHgmFh1L/C2H5USmXYvLdyaDfIhXlNQQ4BvF1h6hQz6EpT
         AWC4rVZa+3JgspRf48kyy+GVMwsTgqDSHfTARAAqJM71GmWgSMu9WawLI9vy/rbhIM5V
         Tgw7zgIQF0op7dS/GRiuPCzsNgC5Z6jHh42tK3JQ8ynbJS/qZeqbDiXhzeuuBncbrEqH
         sWeBUtfREdMyA21Bkc3SO4yYX0sT/ZMm2Z+uD7XzyRoYBd65Kt27uKYLahhovSomFX2O
         cvdrvBfXk012qFWwV5SJqXHA/W+FBFhaLehUDZVdq489EOLS0sF985pniDCsOAz4btHU
         vUXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxi+8XXRsNhjlqONEa5lHxE9D2VIU431YKWh5cHQolyURiPQGKfaEltZQnKBJm7DCiogNaql1I=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJGk6gjDjBqDWwSPbi6WpbN6PuICYnGWN+U4Di4LYKiOiMGNUXI
	Czw4zMjb6HGqT6iRWbu10oQK8HEsXIQW7mertqy7SyS65QQmWur2XuMGtz9jz+hNnHGLvigf/CJ
	36MI5IPUnDysL2CqvWalXWd2wOytgM3Vqan9v3tdCcOorsu87xLdU/xaspU2v6C7bzXwluvM=
X-Gm-Gg: AYBFou0lW3XiBvkLVKGP2bzukGcKcLFlA7QKa+AzOBT7sigWcBYhOMPHFHhf5PNs0ld
	U35Dz0msJ+SLEDpSraOl4kNvpm5XFBaWthFJ3/G3MmLlmm27YIRXbxHoiPXn4OqHskydWrJpaLN
	mA/QjRIc1ui+lbuonZXo0oe3TrX4rSlscIGrjATxacK9N0SnwjU0A7392ERGQZfgrTct83EjU6S
	SqG4Ix52vuxwxh8y5rEM+aWOXhaQRe8BeaFHL9e7YPxhHQHm1Xx5d84T/4m3woYdqSDMuNwOvRi
	jGiT9ISTtHPcM92QvOPg7X8XokeuNduKABmPkuByO5EnmNh9Z/wO/QPUlBX3eD3K+WJ8sWBZw4p
	cAYZnYgNDQYSGsESp7TGROhji112Wy+LyZmMfEpyo/8hfH5UL3yp4TWw1Ww==
X-Received: by 2002:a05:693c:20c1:20b0:351:1b39:9e49 with SMTP id 5a478bee46e88-3511b399f8cmr9534062eec.8.1791247194293;
        Mon, 05 Oct 2026 17:39:54 -0700 (PDT)
X-Received: by 2002:a05:693c:20c1:20b0:351:1b39:9e49 with SMTP id 5a478bee46e88-3511b399f8cmr9534042eec.8.1791247193689;
        Mon, 05 Oct 2026 17:39:53 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146ac078fsm2108874eec.22.2026.10.05.17.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:39:52 -0700 (PDT)
Date: Mon, 05 Oct 2026 17:39:45 -0700
Subject: [PATCH RFC v2 1/8] tee: optee: allow RPMI transport builds on
 RISC-V
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-rpmi-tee-service-grp-dev-v2-1-72f222e23ec1@oss.qualcomm.com>
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
In-Reply-To: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX5nZx9+pD9hl/
 TM9+FykQ7uB0H8/obP9EpA/iMvVU99gu/I8ozb7osbgsI11UPqy6o62nDw85HcL7/DhXN1yFrrW
 nfXb98ex1nks/de4xY0QhcBu4BFZ9620Bcw6zc2Oz42DUXeAeSA2n+1IT4fSN4cXJ/ArauWuuuu
 6WUDlN6JTN2sk3y1fdKqKPd01IcnZq/wIDPbJq6vhAu1IkV8tqRTJhyKrmkVG0Zk95byD3P7DTp
 zwY1VbMS/badZ/TUUqzsNOJwjfRHize4NdLwUU6imoyMf7KdWbm6kK8oKaoX9iH0NG6RERvePSn
 Vj6VsxY3DFA4WZ7qX9rviBt2jYcq0mU8j9brHy/OB/caoLKNsAJ4PRQpWPsfDX8tgQAPzYToLxt
 ZT4JLCxEOUDck8TtYV6YomblBzUGq4uEhm/JXYmD1wL7TwRkCXDjGghj+h6z1MVQmk5HbpsgVny
 Au9PgrtwHo/TcxqUfVA==
X-Proofpoint-GUID: ggiSRH8XQmi9u6WzXG5liw1EWWrAo_Jo
X-Proofpoint-ORIG-GUID: ggiSRH8XQmi9u6WzXG5liw1EWWrAo_Jo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX5N6YjT6A4M51
 CtWjY4WVOYMwK7JX37coErhdWhcfR8s6Vkei7ioIglMu5NiUP0/YvPo1TEHITSsAZy5SbmMGP9x
 nD2mFDJYsemN4uVyWxsN8qJ4LEAHqNs=
X-Authority-Analysis: v=2.4 cv=bpTZl0ai c=1 sm=1 tr=0 ts=6ac4435b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=FVoukCuPRgDGiLv7d_oA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DNSWL_BLOCKED(0.00)[74.125.82.199:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 047074519A
X-Spamd-Bar: -----
Message-ID-Hash: NQQSMVOQADZ5CJURYOFZQI7JAXZKOGUJ
X-Message-ID-Hash: NQQSMVOQADZ5CJURYOFZQI7JAXZKOGUJ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NQQSMVOQADZ5CJURYOFZQI7JAXZKOGUJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Allow the TEE subsystem and OP-TEE driver to be selected on RISC-V
systems with the RPMI TEE transport enabled. Prevent OP-TEE from being
built in when the transport is modular.

Common OP-TEE code checks the memory type when registering shared
memory. Add the RISC-V implementation so that code builds without
reaching the unsupported-architecture error. Reject mappings with
explicit non-cacheable or I/O memory types.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/Kconfig       | 3 ++-
 drivers/tee/optee/Kconfig | 3 ++-
 drivers/tee/optee/call.c  | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 98c3ad083940..ad754b647a3c 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -2,7 +2,8 @@
 # Generic Trusted Execution Environment Configuration
 menuconfig TEE
 	tristate "Trusted Execution Environment support"
-	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
+	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD || \
+		   RISCV_RPMI_TEE_TRANSPORT
 	select CRYPTO_LIB_SHA1
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 891dac63cab8..cc057c76de62 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -2,10 +2,11 @@
 # OP-TEE Trusted Execution Environment Configuration
 config OPTEE
 	tristate "OP-TEE"
-	depends on HAVE_ARM_SMCCC
+	depends on HAVE_ARM_SMCCC || RISCV_RPMI_TEE_TRANSPORT
 	depends on MMU
 	depends on RPMB || !RPMB
 	depends on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT
+	depends on RISCV_RPMI_TEE_TRANSPORT || !RISCV_RPMI_TEE_TRANSPORT
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index e046aff61828..267513cf4ec0 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -604,6 +604,8 @@ static bool is_normal_memory(pgprot_t p)
 #elif defined(CONFIG_ARM64)
 	return ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL)) ||
 	       ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED));
+#elif defined(CONFIG_RISCV)
+	return !(pgprot_val(p) & _PAGE_MTMASK);
 #else
 #error "Unsupported architecture"
 #endif

-- 
2.34.1

