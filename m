Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478C606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lR+BddGU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Un0V0B29
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 684D845483
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:19:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lR+BddGU;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Un0V0B29;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 95904454AD
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:16:09 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tMpY4084486
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 11:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sv2K6+0+MUtgDlrDif2dTZr7/lGThf5F9lPAXQqHnjo=; b=lR+BddGUfsubROt+
	nGVAasMFB6qoa8WOF+XapxKijBjG2H4V3l54WtyRAdlAUEG/R2idfqVocnUiYTrA
	ARWOuZwmIFj42qyEXJTC6ThUhZ1NMJBzbYlJogCvLz7XOcnTRafS/d4S+ZYzuRea
	yVpniZdeikSYRYXgi37+t4fLfn7J7pzU5iJ6vXC4TIppppyk9JmixPC4G4HLXNlP
	iUIcvcHX4njHV5xyIfDINe7OOhnL+ykx1N51j5oCnC1xeLofoRNku3yP0fZxZFf1
	A4xF1oYBsdSku3i3CpXVUwrn1W3Tl6fcKpyve5LdyhEDXOG0T8a9J42BoAy+hM7B
	7opICg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhkraec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 11:16:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36d2d353a5aso671083eec.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 03:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793877368; x=1794482168; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sv2K6+0+MUtgDlrDif2dTZr7/lGThf5F9lPAXQqHnjo=;
        b=Un0V0B29a/vYx9TAln7/H6QHcbsX1uJjB8O7PDW/Vv097J0sNSmbl68PSsCxgnK/Zk
         kNRqsT71EA/4VwxE1IHxpSqq8bqshrsSfnqXPwf2fPOV6Tc+BGhCtBfU9EZqCceIh7gr
         wyEmLOiCRUpMW4GXO2yWMIeTDYqTVaLOVuZNW/ts6/CZOovygK97cJoQk8+iH0YPjyMK
         WrfCpWFcjMdGcvH3nhqzc5Y2voU+AAP8BICSJuH/P0qa+ttXDKsyflhsV72kqu/aksVi
         JX9Pwvj6VRiVESUxJIo7hMabHXE7CmLjxK2CGCLoa8ikKiWLRRTLbTldSSbQG97b/RP8
         m7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877368; x=1794482168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv2K6+0+MUtgDlrDif2dTZr7/lGThf5F9lPAXQqHnjo=;
        b=dFVOz+HNN2ZAvSH3/SI4+zU1Z9Kgd1dPu6e1fidaaEsXsquSBsEKRzRI+u3bjfr6Hz
         rwPEMNuXjlNPQQhNSsLOqAHEMLKkEFh33a0cgqS2RDVNnjzyr5jGdCTeloNgkqUtmeUm
         M5QbCmCLJxvest0i2gw8UVOWAgVtRnyebQjjPg1qYxKE3J8faZS2grroQjfZhzz/NL5m
         wSMKVrNzjCaMQqIJc3ow+5xawr90L2CncGlZKxP+XIjjTpeuZyaQ+wGQIAstsV5YuE8O
         ny26PVm1WTZ4vQvdqdG3q5BLOH7br+OJh2CSE7IOQzkr3tZUJMEo7ZV131/RO8uuDLjQ
         2o/A==
X-Forwarded-Encrypted: i=1; AKwUvBw+K5qjuo4C3ahFXz4P7nNdZSnPG+NttXYLvw8KPc+XfQ80Fi+ZJ+EL32/lCQxPu5YZwEEyqGY=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+TPCkIw2aAwecYyQkvbQ2ABznV1s6yab8pcv8jyUk7VUpfpS9B
	NtTixFMwxHNQH1kQuIAneJjH67Q95HRRGx/Rb57xvO1aNGyoIeCBBv+AL0/NPwoTYIL2l0hryRI
	G5L5Xiz9F1DbfXI8uhyx/HJS5DiEh/oXgbkcvMM/U5kmGfQkQlPp8lGmYC4qyxGVuhlxqkn1w
X-Gm-Gg: AYBFou2szr5az4o+g4JTz8a+NLGhhQFqEq0sN4Tg410YfxAaTKVVFqgaqivGO1btLJu
	LpvZeTtMAS9RGPy6IKxtQo89RVswPRxp1nzJ7lP0srERQBSoZHlOrz85cHlRxIWPRoxwf3SEUJS
	nKq9lf+Dvinl/EXlWRIUbtpqUo6VfrIoVHRXPO9GsnLO+kviPP9j4RW+asRcFPeLUXdDWoPts/c
	zk/+OIwS9VZM2ZZFICvSbzzScsWzc4riramIEO+T44/OkgfG6zzln1ju7dauOBiXQL75ubJcUE8
	PkS6gI1/FKdRvwFPgPTPVFC6m4qMaQc1/2JIXovpFky51Zc46OmLw4V0A/O3nABO5awuliQt8ct
	s8fnaSaxKUmkSr3lsYuWLUeaCTV+i+0sdiymQIy5l5ERp7M7GWQeBpCfGYlahLbyJI0LoyaxmKQ
	==
X-Received: by 2002:a05:693c:3881:b0:36e:ca05:8c3c with SMTP id 5a478bee46e88-36eca058eeamr629098eec.2.1793877367558;
        Thu, 05 Nov 2026 03:16:07 -0800 (PST)
X-Received: by 2002:a05:693c:3881:b0:36e:ca05:8c3c with SMTP id 5a478bee46e88-36eca058eeamr629067eec.2.1793877366941;
        Thu, 05 Nov 2026 03:16:06 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dd7ec8881sm14002125eec.18.2026.11.05.03.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:16:06 -0800 (PST)
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:44:55 +0530
Subject: [PATCH v6 7/7] arm64: defconfig: Enable UefiSecApp TEE client
 driver for Qualcomm SoCs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-7-c7d68ce05c51@oss.qualcomm.com>
References: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
In-Reply-To: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793877323; l=1240;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=qDDal9GJ8g6Ikut3T7wcy/AIpZjwo/GMmoItp1TdU54=;
 b=Ro59s+sMdEnPuTJjz1hVTNxB0xO/hgmSpPmDiIqtiTBstH6De1YfYGFDwOx1GP11ZH9UQkkoS
 ClnOQO4R5RbCEWPsVLFgl8eFwqUW/QqNuvbQngOJpsGou+L69pmFyfj
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX/uKMv1JbVKKz
 MWKe+4mIPtzSUBNd+a1RswAmhsBrnhWXdhS/CoZhtwRBggoPfYSPUeTVwaPBN8ZhAAP1gxN3LWu
 qkPJYTeyUF0M1p25I1LCCwXZp9549lEs1/kYGqhr8Hy403FlGhsTUZ7GWJ192I35tWOoj/jRKmN
 REU7otFG8ZVoEa0Nz/plbJvpwJNLfrDJmYizJ+vkro8HMB8mADg64l2b9NEfhYEjlkGEK8Ts4sA
 bsJHR6NsdW03KTg/KW5fEyaD0udemxG7tFXf7Rm7LvkGIOUUjKNOR7NlTf8jczHiC9ZIbKFQgg8
 PRz3lvt4T7SiKviUPdoiKrYGFfuzngNpJ6nzUOknp1ZkS3mYa/7cyztB8kKvXsNNqiw8kM0ooXQ
 2J/M4P1yB6cBQucBEgzbZlEo3AmJAjaHdDInU0RTSZUx9Q/X8GwQGCLiOubKiqJxmBs72ftANOM
 LP5ZVirkrbK8Uem45yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX6QerqFogEBWA
 RU77q1u6mvnnenouHoAtFTDwCMcdP4nNk42YLLPrRpBoG3vpSjhtersN3QFEpImhgfK9MUffoAt
 mQVEW4SOp5RHQ/zq3+Tu6ksnqBDSUlg=
X-Proofpoint-ORIG-GUID: ka4Yo0d8ybX-MoITVLeU8dg72H2OqGd2
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aec6578 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=L1DwG8FsHRaiiIOMTvUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: ka4Yo0d8ybX-MoITVLeU8dg72H2OqGd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050044
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[74.125.82.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 95904454AD
X-Spamd-Bar: ----
Message-ID-Hash: NDFUCZF6EOVGBAGTYRJ3CH5MCFR2C3M7
X-Message-ID-Hash: NDFUCZF6EOVGBAGTYRJ3CH5MCFR2C3M7
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NDFUCZF6EOVGBAGTYRJ3CH5MCFR2C3M7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

