Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A37D31A28
	for <op-tee@archiver.kernel.org>; Wed, 14 Jan 2026 08:19:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2011643272
	for <op-tee@archiver.kernel.org>; Wed, 14 Jan 2026 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768378789;
	bh=mTV6Jxbq7em1Iwz/pki8wC3LFeaTyzm3TO2CsQisscE=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=NuLlF4RW3tca6q0tnzDj4V5tAHtS+ej6tnkyYpMoX8SB6klJpma3F2czBt+VlxZNf
	 NOB0SzDhJhwpsUThLiiq8i691489k7u07zBfQWus4PNLy3+byz5vNgNMSDO/+pPzUA
	 E7eGhmejgbAuc/khEu06wJW481jpMPEfpyjqzuqOm144nf4A968vfVRInQfyBOjzyB
	 ZVSpCVI8amisj9D3foMivuBigMAm4WzSICgfUkzkvRJTFoqtD2pa1sQZAH6tQR6Ijd
	 PIObrPdp1NphIK402TGgrZZgsWBDUqvuNIZ+LI43H1T/HW0f73KZEX9+D2HcyR1Vec
	 NA4XOso9yPDUg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8960841A3D
	for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 08:19:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gC6D70sZ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TC+4cGdn;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E7j5bh2056606
	for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 08:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xIdicztn1w9ZGtLxmbsRFf
	QCbWASlDMjGyWKW49B3Qw=; b=gC6D70sZ8sUJqvabmyChZpz5GwLKka4zMBOxOb
	eUZ1pO0vpmFb1vuY7zAKocteT1FgxQ190m6D+rNIBZEjrNuRUzapxMswbZnjNhk/
	uPgHWfDUvygmywH5ua/39eV0APAh0FYMG37uGQ+AAXZNFSsH5qTJk40vBjl1Dh1p
	BQS1rDslkxPxQCGwxqEBXtyVyFkhr0sG4/4mgb9aVA0r+Gv96LL8yUO3KeCv5Mjw
	/+krLgMNfaK9wo6N69kCNwobBUDkwGKiTMrYoCnW2MZFJqViKpQg9OHd0ccQaIV+
	x0kvFdvGnnZJd9LfVH+5eSngTaki/j8W6rHJWLeHHqvydbUg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnr3eb97d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 08:19:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f1f79d6afso97727855ad.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 14 Jan 2026 00:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768378771; x=1768983571; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xIdicztn1w9ZGtLxmbsRFfQCbWASlDMjGyWKW49B3Qw=;
        b=TC+4cGdnyP/6Rbl4zZa53RvZoYD7QuNnd7nlt330BlAAfEj0M2oAobmVdRlgWAifvh
         Jj2IdkiS/z1MsfbXl1qC9xqyPW/KXCU2hELg+NqssTIcPvwnhP6cBrCXqsHLpY1WviCg
         +yQOqZElZ4gYd0vHBOtUMvKDtiYW+ZFqiKUA8iyVPk0X9YkPdw/rHIZAwt4kFEnaDHAO
         1gNPZ8JBAkLp9qhamkHXUzHQueS5NvhN8Gjf1osm6HNJ4sdm9xmvT8Ag5JqshEDHPMli
         TIZZZY1BXZVoJVSoGrHIZ67NmLoMSg1P6dmGeBT28NlhifzeZRtWFTIlomsF42PSbtMK
         fYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768378771; x=1768983571;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIdicztn1w9ZGtLxmbsRFfQCbWASlDMjGyWKW49B3Qw=;
        b=vyh3228MOZM4NsTOKbPKYxVPk3O+49CFIx4PI32Wc9Vxbg48lDatR9WDznjPSFiHhs
         PhUOhJHag+1Q6KorUYTE2yZi8TBGD5u4ODsM25UdzID2R6triyue8QDq0KbGRNUu+LL2
         Ebhn3VDsCz8bR321LFTPt6U59a5rvFEtBezqTprSlw3oTie3PbefmN15rGyEvVKLecZE
         VJ2Ab6Eq3PwvaxJ8DfOCbeiJ3iV+o/O+vID9Yvjoxy07PAsCrNlRhPSnkIJXbl0aXw/p
         5IofFZJ1bBID0zCqwEnXNiMHIgOz6v+c0alZiTqC48y96hOXjy2iZ8oaaNjzbLimwyZF
         QQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaKpwCyob/XWoG/Dj2ERGvByB7P480a35TIIql0BBP4N180cnNeX1MnY67N0Fsnb0ovCS46lY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzWRQWCtaszdYpRZjG5083mbRr8FkydcwgfmCLf1r5It+60uBTg
	Fb5G3sr8l3Ebx92/Yk0EMcM2XQmL1AoNc/PGZDJaqNg0Wummuy0Xt8i+6PkcZBw9x/9iyzYaymp
	VuCrL/jEBSLe1wwhSuKOOt5ulDH4LPSQW3i3frEZxTNfOTSyMwS3mC3FQawJ0dBEMqn3E4bPb
X-Gm-Gg: AY/fxX4axIMe9cSLf2SQtecuSSXqlFk3CHWykLCUqc6ok3jdlJHBQ+mQfSnSPNTZtAr
	DBmy0ZtYTa/mfYcarkAySS5TDqTdXEzRo/tWju+JLYyD9iDJc9ElJhZYhGNd2EGd6eyy5qYark9
	rZ1Ptb9KQDGd2q7HfQYtm4tC3TmORXan+llrWNPFU6BmiDLyDZ7aHh75waYUdQ50VV1ks1uSnRx
	xT9fEyF6LVh4ML7/Ms2gtnhttqmY2TgI7n1ZDOJpIwj7bvh6qyZhNrNl0lt8lUgVatLfEGYgyUR
	FN9RdAJPh0AsnewsIXxMjRna8SpqwWqYOx/KgWqn9nnO/qTcdu/jPIlsFhbl4eIwASRRvk/2S9X
	IQvPUkoHHk3G8qH4mxYD2AoUNIZrMwe7BvXQ=
X-Received: by 2002:a17:902:f68b:b0:29e:93be:fe50 with SMTP id d9443c01a7336-2a599e4c426mr17475215ad.42.1768378770825;
        Wed, 14 Jan 2026 00:19:30 -0800 (PST)
X-Received: by 2002:a17:902:f68b:b0:29e:93be:fe50 with SMTP id d9443c01a7336-2a599e4c426mr17474895ad.42.1768378770267;
        Wed, 14 Jan 2026 00:19:30 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2d79sm225117435ad.56.2026.01.14.00.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:19:29 -0800 (PST)
Date: Wed, 14 Jan 2026 13:49:14 +0530
Subject: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for
 QTEE-enabled Qualcomm SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIJRZ2kC/4XOTQqDMBAF4KtI1lWSmBTblfcoRfIz0UA11VhpE
 e/e0ZULSwk8eCHzTWYSYfAQyTWZyQCTjz50WMQpIaZRXQ2pt9gJp1wyjLQ3oa3WGAEqC86Ezvk
 6LayhDiwTjGmCw88BnH9v8O2OvfFxDMNn2zOx9fYvObEUD9MOBFUFKFGGGLP+pR74tM0wyCpPf
 K/JnxpHzVy4PFNNc3GGsh/9gZbvteKnlqOmJbXGFUoLCQd/W5blC/aFt/RfAQAA
X-Change-ID: 20251202-qcom_qcomtee_defconfig-8dc0fed1411b
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768378766; l=2079;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=mTV6Jxbq7em1Iwz/pki8wC3LFeaTyzm3TO2CsQisscE=;
 b=G0Rpa5CzcHSs+X1sbIjEiW54p8blc4rOWEJAubjMuyiW9MaitifvRCghI2k4d+AWi+zeB5fla
 keCXCMlrhwwDwShGymbkzpRxJlTc1Pc6uZCL9vfh81VRi6B6En66ux7
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Authority-Analysis: v=2.4 cv=TPFIilla c=1 sm=1 tr=0 ts=69675194 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=_sHcNNlezzEkF8pCUssA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA2NSBTYWx0ZWRfX7wJ7QHyMbsCD
 F7cY0dhfr5oNIOVdQrwNUouOlx+WOmPkfQhUNqHHGpphtOY+XBzBnDhxaUA3VkQuZBU9urcCZn/
 CIj8bnSyEGvSG8NV0SN4QI/42XUvGV85cUX9djUxEJyeNC/I4LMKWPdph6JBQl5IImL4+yxIU/h
 WG4zXoDGfTEPBFIH+wzeRlBkXOpnVG++krqLUOCsvBZ56rCW0P7zjwh6noyh/wY8x8oOjByxsxK
 DUktWksjikuuxIzs6fL5W8f2QuLX74FYYnw0mCmOi6BBnFuazGNPusshnrHCf00mJFYbxYPSCl1
 UWgKPFEG1iszAgsiQXOeZNF67S8PGCXcy+7JO+F28z4BAdAr/Prp5TT3qpvYa4oOv3aCn+GxS2r
 ohUC9Jxkx6fpuaiVxz+ex/YtKRhjHmHkX3q2XAzgOO1cj1v1kqlfR8YIN8xWULc3LUpcGsKFIej
 zFcv0KQl8AxwAirutVw==
X-Proofpoint-GUID: 8xxGmUpDD77FrWF_eID8g3ypEler1fww
X-Proofpoint-ORIG-GUID: 8xxGmUpDD77FrWF_eID8g3ypEler1fww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140065
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.214.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8960841A3D
X-Spamd-Bar: ----
Message-ID-Hash: 56UF3VVC74J3V5UJO4PT7K53KNC3U4MY
X-Message-ID-Hash: 56UF3VVC74J3V5UJO4PT7K53KNC3U4MY
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/56UF3VVC74J3V5UJO4PT7K53KNC3U4MY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
Trusted Execution Environment (QTEE) through the SMCInvoke interface,
implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
on ARM64 CPUs and exposes secure services to Linux running in the Normal
World domain.

This change enables the QCOMTEE driver as a module to support
communication with QTEE.

QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and
executing a Trusted Application via tests hosted at
github.com/qualcomm/minkipc.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
Changes in v4:
- Updated the commit message as per discussion to clarify the following:
- Why we are enabling QCOMTEE for all arm64 boards.
- From which Qualcomm SoC onwards the driver is applicable.
- What functionality the driver provides.
- How the functionality has been tested and on which board.
- Link to v3: https://lore.kernel.org/r/20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com

Changes in v3:
- Updated the commit message to reflect the supported Qualcomm platforms.
- Link to v2: https://lore.kernel.org/r/20251205-qcom_qcomtee_defconfig-v2-1-c92560b0346e@qti.qualcomm.com

Changes in v2:
- Updated CONFIG_QCOMTEE flag to 'm' since QCOMTEE can be built as a module.
- Link to v1: https://lore.kernel.org/r/20251202-qcom_qcomtee_defconfig-v1-1-11bfe40a8ea4@oss.qualcomm.com
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cdb7d69e3b24..e952d24bef77 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1789,6 +1789,7 @@ CONFIG_FPGA_MGR_ZYNQMP_FPGA=m
 CONFIG_FPGA_MGR_VERSAL_FPGA=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+CONFIG_QCOMTEE=m
 CONFIG_MUX_GPIO=m
 CONFIG_MUX_MMIO=y
 CONFIG_SLIMBUS=m

---
base-commit: 47b7b5e32bb7264b51b89186043e1ada4090b558
change-id: 20251202-qcom_qcomtee_defconfig-8dc0fed1411b

Best regards,
-- 
Harshal Dev <harshal.dev@oss.qualcomm.com>

