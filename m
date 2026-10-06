Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17993CA5FFC
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:37:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5328B4526D
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791286668;
	bh=qDDal9GJ8g6Ikut3T7wcy/AIpZjwo/GMmoItp1TdU54=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=g74RfNiTDsg6cZSFmuD+OrDcHWKUVfCEl+8QN5JR0MUMIXop1BRPFBeGzLktas0u5
	 ItZR9L9qyBFC/uWYQrCkKruWNiaW1ESpYEpTxVh3pCGeA+wT6Vh2ycg4y7PvUy/eDZ
	 YFjPeNnfNGJKTswsBQ3B3ii3/I0vhTNxByIEwtQA3VOhxlIMkCNnk1Zz0u0eri9BeA
	 tAWPBNOB0SEcN1rtJ4W05nUryGqF0OYDMXTE1wDpinNF+Q9ebRdlYBefMcspB9/T6D
	 P/U6RzqluGLS3M58nFZwcVF9dxg+Oq+TnLf5D1dHc6Ek80jC1Ivc9J8A70PV/SFe9E
	 Frd8hO3sgavCw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3C79245481
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 11:34:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WaGfpqZj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jXoMpuyI;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPEn3680877
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 11:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sv2K6+0+MUtgDlrDif2dTZr7/lGThf5F9lPAXQqHnjo=; b=WaGfpqZjdGPd8grA
	UlnPO20duchkDDD3HhGTwUCfhxCvNseSN8weivXt0gn1t0tNpDxS0NktmrxB/nyg
	NgLqZ86sONkFYhwpwgBzlJ5hlRaAz7WZ5gnFqdHjbONHjQt7A5hEIUmGgGyCPgPH
	1TqIR1DiKfsAGq5w99zvXnB5451hdb8gumKUU7yQxItpPvdqIY+JeJ84/qyKWUir
	iFqhb38F+/kJb46M+z+ixJhvzxpvAFPejca1MD8e3D8dGbIDCY2Aqsj62f/ZJNdk
	Zurkhs7IZ0vQPOEe6eJyXmCRdve4XMrVWaN/fuvjrKaWvQeZmBfnx7bsrml3usEN
	rBCA6g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9rd1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 11:34:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cade6b71so684812a12.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791286479; x=1791891279; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sv2K6+0+MUtgDlrDif2dTZr7/lGThf5F9lPAXQqHnjo=;
        b=jXoMpuyIU0hOVWcx6IjFSCSQD0HM1yVz+ldZtDorddw8AkDI2Yk49IyTMCf5kE+YqQ
         UEBTbQ9/++jKNg+955U5FbQLDg5Ml7CiSs8XP1QB71/48DWW1cN/OmNDCm5pvm5hrTJf
         h3qiGZm64VOwxoh3jBoGuXdN51ttdsTgOG8kLl2+/ESGW+sf5bLL4y+FgviHEZuKi958
         kuKuL8HSzzOXaeB6pk59EACaZXlpp23wwlAWtnrCZNJewEJGkR+uV5WhRPkb5MXlvcYC
         tgP9yfy+keihI/uvPRd+Jvrj9XY8JaA81MPQEDuZznCYyCsLFUJPFrfKp1NTwKf51lTH
         JhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286479; x=1791891279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv2K6+0+MUtgDlrDif2dTZr7/lGThf5F9lPAXQqHnjo=;
        b=qMyCjo8Wfdildjx2EJYR88t3XX4lDktaylelpblptVjiesPsw4DtbXpw3pgV+O/oPP
         fFM5MPRVvRu+lQh7op8hasPv5RQ4UomCrMhn5cPcvAZKxMbNfse/2V+GQUsbQffnxrlZ
         qQn1/V/HmlWhRYEPdqD4Q6zjDIP8Qrf/b4jYxzkOgND+0rf3Khe8u8qbLJhKHt7Xupvt
         0n8pllH/tA/pNZL7JYofHbumRgNfbSU4KiU0sCGD9WqhqIT2JUla4TzVDcgsjp+oDZb1
         3afS7QfbzoKWsdH5ijz8HNLV2gSU4SIO/KR0yJjzJjqxT3RgvaTdQtkIyLVJozCBjz6O
         sHTw==
X-Forwarded-Encrypted: i=1; AKwUvBwB2WvbTGDY38pDLpGr7uVr/uED+0ljxNzBtxM5rnoYsKVgVFzWLse0yxy7+0jYxiPdJxeTbrU=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLg19hCvyyVpX1MXQvW9m8m0CKi/al8v+1XqafY+pVlhk96kIxW
	kuBNE3pVDufZzIIp+Syj5hYt27ESso6wp6attzJOz49ncpIjzKzKJsuTY2ne/oeIoE2h16UEiil
	pAWufLHTrAeGxhbuqHrHj+6rppVvqPEd/cXjDDSqoMsx5NsjucUVyv1ut/YmL8IgU7FLnaUkb
X-Gm-Gg: AYBFou06+3NMHltMpmcQ7mGGXyIcyno6eFQP2/cYIG9KC5poj+LtzLsJWeU6a8W4aLI
	ExsT5wYHoP9pejcfkhAWMACiv4zcdpkvpOAXw56wDGCrIxkV8A3/YBpiWBc6Y24PeGzqjCJ8r33
	y/F2qZxqN5vZ4elVBXUjbpq7K7mJAbORwSRBwo+kzJJ4tjVlfYDAacTrqBYCsaWb8RuRIdDGG2F
	0N+uK4V3wOSovUwQspKjmCKobjkHj5ClfkAEtw37/1j/FxPzGtdVZ0TOuhxBJ8dzH/jBuG3y1pq
	sCPeQ2NiVdZecoKC1rjiS3M49ifaXe3vAoV3Ap8gXAskVdGA4Y7psjA//6oPIQXTDCxoHP5G4os
	9D5YrDPhrYmclRSiBrC0Ni9zF
X-Received: by 2002:a17:90b:1b09:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3a87368608amr554170a91.18.1791286478365;
        Tue, 06 Oct 2026 04:34:38 -0700 (PDT)
X-Received: by 2002:a17:90b:1b09:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3a87368608amr554137a91.18.1791286477300;
        Tue, 06 Oct 2026 04:34:37 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a709a4e80bsm9330092a91.4.2026.10.06.04.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:34:36 -0700 (PDT)
Date: Tue, 06 Oct 2026 17:03:28 +0530
Subject: [PATCH v4 7/7] arm64: defconfig: Enable UefiSecApp TEE client
 driver for Qualcomm SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-7-bf1c8e2a64ab@oss.qualcomm.com>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
In-Reply-To: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791286430; l=1240;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=qDDal9GJ8g6Ikut3T7wcy/AIpZjwo/GMmoItp1TdU54=;
 b=YjzJU1dcgPuRriBWDp0JHYX/56t9ZNJrr/NFnoRLRhaU93MIfOhqsRAhHc9ATIoUjByrLvAxM
 FlNUuIfbYJRAELZQYbjvZMUCWNweCX+rXzhJxDIzEorlzYt8MeeWCg0
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac4dccf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=L1DwG8FsHRaiiIOMTvUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX9dVGVBQFfeNw
 pMSPD3malK83ORl1CE0rGIZcE7CN7clrgo+AeZdTEP0MyElQBGWGMKQ/RazXiM+fz6ynb0Vz4PE
 LOm3agmeJAoZqczGz+X1QAcEvQd7VFU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX3aGe4krxt1OY
 xSZcqd6agBG7Eo5FZY70PIvo0QzCy0vgkW8jBOP/mNTa+Bkivm9sx2lVHAKDjx5PhUsryEJTLHn
 Iii3T3ObnXy6IB6IxncqZ1CZsp7WXx5eXsHbh96ysCQIDV4Z6p2Dwgjo4xpvBgIUQImte35Uu03
 /XajQf1M7voEc7FyeHa/eH69Ih8jCrtfLKiVGEM8v2qmlsddqtmC73CVzRecT/jlAaARH9J7fnD
 9d9EwRw9C9fUb6Fs6577N/dzzeK8U/++NcBmu53q+3bUE4B+GIwMEdG/4olyU0it/4b/yaGJ+ye
 AOUoOqkGORvYVk1WddLP3sAvY4fdezjQkFZce0Oewf9SfYkbwga/k93RdFwl29IoYB/nKnukXGu
 GlMthCaE9UvSs4cpdwQyLt2Q68RSDnXax0XLbIyLdg2BhkaoLWCKC+ZOKwqu5Xeb09HSUJYCoMB
 HSwjLYpZ3Vj67Lvz2lg==
X-Proofpoint-ORIG-GUID: PZ4N0__AoDO0NEkH_-MquefnAe_QvzHY
X-Proofpoint-GUID: PZ4N0__AoDO0NEkH_-MquefnAe_QvzHY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3C79245481
X-Spamd-Bar: ------
Message-ID-Hash: WE3L6V6SFY4WS7PF6UCJJCVI72SUS54R
X-Message-ID-Hash: WE3L6V6SFY4WS7PF6UCJJCVI72SUS54R
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WE3L6V6SFY4WS7PF6UCJJCVI72SUS54R/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

All Qualcomm SoCs starting from SM8x50 provide access to the Qualcomm
Trusted Execution Environment (QTEE) through the SMCInvoke interface
implemented by the QCOM-TEE driver. QTEE runs in the Secure World domain
on ARM64 CPUs and exposes secure services to Linux running in the Normal
World domain.

This change enables the UefiSecApp TEE client driver as a module to provide
access to UEFI variables on Qualcomm SoCs via the uefisecapp Trusted
Application running in QTEE. The TEE client driver communicates with QTEE
via the QCOM-TEE driver.

Access to UEFI variables has been tested on a Qualcomm RB3Gen2 board via
the efivar tool.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fce418fe6ff6..a8525878c679 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -277,6 +277,7 @@ CONFIG_IMX_SCU=y
 CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_QCOM_QSEECOM=y
 CONFIG_QCOM_QSEECOM_UEFISECAPP=y
+CONFIG_QCOM_TEE_UEFISECAPP=m
 CONFIG_EXYNOS_ACPM_PROTOCOL=m
 CONFIG_TEGRA_BPMP=y
 CONFIG_ZYNQMP_FIRMWARE_DEBUG=y

-- 
2.34.1

