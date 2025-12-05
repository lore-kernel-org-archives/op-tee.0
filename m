Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FC5D2E035
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 08:13:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9EC1E5007C
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1764922391;
	bh=eVxApeF5KzWi0FjBMwqqotT0BqAZ5xwAaG34fnKbfN4=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=pPiGznwxyhhCkD/HXUpYSyKj7tpJlphLcg7b1wcYT4AI0PWb+ZbgLwtDurLBX3fSN
	 fdEqPmTIzmdsZjimc3deM5lcwYa8SZ+i6fd4Gp/mXpt+T6g905+SAmbXSOh9wR2aMK
	 CDe37E8m+Q/IYWsMiTKsA4ES/QyRrNdV4ON+4Gn3BtrJhN6/xVb2Tsq2X7j84eszmK
	 FcomyrCftXMDNM2Ayy3fBuNYnOtAclKoVcXsd5njBz4kCq7HvowSfMbCynJyl6khdo
	 KBuc/zDc3c4DHCYJ4C334+7D4hdT/QO59dXU491RNVgVT45o1JZFtn2lXAUHsMJT8L
	 iPBzMnxaOCmLA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 80B7F431D7
	for <op-tee@lists.trustedfirmware.org>; Fri,  5 Dec 2025 08:13:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HRfiAbNL;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E0lJxlzI;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B586pPh2516877
	for <op-tee@lists.trustedfirmware.org>; Fri, 5 Dec 2025 08:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2tTy/zvW91q+YpW08L7i49
	S1Halc5LYQQRxx11Darlw=; b=HRfiAbNLZt3zGGE/pOX5PXvfPD5rCYzzn4mRr0
	svJTQY0Fa5rYrryZuoialSTuSbKcCENfOiN+G7KtV/J4sukQhv+j5BcggV6AJsHB
	i4pOnInlCye5dSuSFrl4js3HYT+p0d8TD5owW7eslFCdVsFOrvcJCKfzRnbBw990
	7EF2pRgYHbdYZ6KG1j3oTrTsM+hc2dpeb/EMV+Q2fY1NlBm1bDLy/YZkdhLAKhnq
	ZEB+QFP7t5K1CYdETLwjZXvbXPgaMar5KX1TsV2ZMhM99DIYasHi+7gQuLjJq0Sg
	AN7zgPMk3FR8thQ775qphXuqhC8k9YAGL3t6U86tom9KWh2Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auj7n1d8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 08:12:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29809acd049so43682155ad.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764922379; x=1765527179; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tTy/zvW91q+YpW08L7i49S1Halc5LYQQRxx11Darlw=;
        b=E0lJxlzI2MF6saFG+lGMUWbPwT4Dua5oUg3jsD80xZhow72guQ4vN8hwYoOysrOPeU
         UBXBu/r4s355cfVzbGlllkzMLOvcuzgoF5G2hNyshVhHxqC4xw3Ao+0WYuS6lHwJEO0f
         GqUBold4FGL0PonPL4kxVc3GGJFxo0gw+S2ulsFX/Zn7+ku8RgKWjsBDCcTgtByQkvCK
         YbUJAj7r+uceZ/ev2IGyFMNJM/txx+fLRXhV1f/2hGL12QovpyP4RQrWvIfR36GgE1fC
         wULVJ53bwygqv7yPG3hTy1FHexn2ObZrb1yz7bbcNpnpdIcdDTq6he3PqmDpBaX3eLPH
         AM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764922379; x=1765527179;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tTy/zvW91q+YpW08L7i49S1Halc5LYQQRxx11Darlw=;
        b=TJZJPgprvYPs0WIHdxZZe64L71TYLHKoyPgYvbyeCLnxkvapc02zrPKJzhxRTHO/tv
         RM/HSOp8GzXYOs4oboHJXpe+gSQSc3xADtqlyN1PBZ055OPP/5sgrXLskdL3GBEUDuzE
         6UZVnz5Pf+G8tB08polUY8jNQ1ktOALfkEQ9bWaoZC8dZYFi7GAtMBtk/yEal17NMd9i
         QYe+ubgKd3gykRzQFprwMKy9481h9P4eqI+xzzxE6yQfqcUcgaBtVLEhnuCGD7iZIWzL
         kOSohOsloDCJv8B+GugtBYNYprpfq6q8ZeQ3R3q0BzffLLUbt2/HQRoKP7OeI6AsViWS
         fO+g==
X-Forwarded-Encrypted: i=1; AJvYcCVu3czOlCXcVusFv4J9F1zq6J1sVLGUbMew+NXSMRpRHHqki44MZU3hoIgTBJoLT5D6V/AWdwE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx1WWs/go8OcHex86tfcfGn4cRsTwX9SMEXbOltfNJPTKuuX4x5
	q/mzc8L/ousCL/pezVp/6+BHoaHrr6Nd7uInqBF/eVp6t8LMqf8tTO9JYyCM+atyRVP4QWWcdGF
	uXf56bmwby7ytrz3BfYL/X8OuVEMPGmBl/f7rVH2rubX2kotC4lTmO/tHyeI0Las3dOQlSCY0
X-Gm-Gg: ASbGncuPcZ1thOrumJUhyVA+SBtCXporNg2Oo0NU/2jw1/1/3NFVoxHv77PB4+Td8HO
	5nZNmGDTOjFuUhMSgtuKE8bswhY7MU+i8bTfTbj+RkrqiAIUxuXjCZ7vJ7jdYfynYvPF8Fk0GzM
	d2Ds5iNCAwfzgnkzQu2GrKygUZFLeWYWFEW1Q55GUPYxAXcjv9NCgWrjkydXV1HwJreOlUdeMek
	QrENf8Tgerj+uSPXr7geeG6JQn52UdXhANHrgtCOsCve0Hx0xvl8fUV2wbPf121W1+VKbuUM+HG
	wA0+8YZ92zUpGX5xDbEuWMbuxPFEBeFX/RPH1bK0vw5TmfAU667qPLaGkVF3nfl1MuwD+viQtCf
	BkbunTfmbvYA8M4brQr3sfjZz1dnwgEwfMqw=
X-Received: by 2002:a17:902:c408:b0:297:d45b:6d97 with SMTP id d9443c01a7336-29d682f2beemr126720475ad.14.1764922378577;
        Fri, 05 Dec 2025 00:12:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkj3ASSclV1IKwcKMUeW/seQsN0RUOmkHCMuLCDtU/i4UYt10MwhYXiJEOpvn1BVkGkNp4cg==
X-Received: by 2002:a17:902:c408:b0:297:d45b:6d97 with SMTP id d9443c01a7336-29d682f2beemr126720125ad.14.1764922378090;
        Fri, 05 Dec 2025 00:12:58 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabf9asm40265685ad.83.2025.12.05.00.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 00:12:57 -0800 (PST)
Date: Fri, 05 Dec 2025 13:42:44 +0530
Subject: [PATCH v2] arm64: defconfig: Enable QCOMTEE for Qualcomm SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-qcom_qcomtee_defconfig-v2-1-c92560b0346e@qti.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPuTMmkC/4WN0QqDMAxFf0XyvEojDmRP+48hUttUA9PO1pUN8
 d8X/YEROHAuyc0GiSJTgluxQaTMicMsUl0KsKOZB1LsxKHS1RUFarFh6g6sRJ0jb8PseVCNs9q
 TwxqxBzl+RfL8OYsfrfjIaQ3xe/7JeKR/KzMqGew91do0ZOp7SKlc3uYpq1MpgHbf9x/hcY1Cw
 wAAAA==
X-Change-ID: 20251202-qcom_qcomtee_defconfig-8dc0fed1411b
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764922374; l=1054;
 i=hdev@qti.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=eVxApeF5KzWi0FjBMwqqotT0BqAZ5xwAaG34fnKbfN4=;
 b=33UGv3twGKg/R9UGUDY+jtQnNsU5YRa1NViUS/K4VBGTYVzjR4y2xYKvNOWg0E3KVDl4c5rg1
 Ni50XHFoR/JBM0lzrPbCZ8Sd9ywokbt5L3KgxdFuooErjIPxnmHO00C
X-Developer-Key: i=hdev@qti.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Authority-Analysis: v=2.4 cv=DOSCIiNb c=1 sm=1 tr=0 ts=6932940b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=uAwLMdngRYKIU0bMnCgA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: gVQ3Ok-Bw9F5Sn6ROSINRhFTk7vwU5A8
X-Proofpoint-GUID: gVQ3Ok-Bw9F5Sn6ROSINRhFTk7vwU5A8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA1NiBTYWx0ZWRfX4pJRkAMpQM51
 ODWTiLI9RUj8t6wgbs4Nt6fCeyi9MwQb9Jexz15mZP/isQIE7hkM1bKL+Pqv8HCW8OknNPo2nid
 5n2Si91n2y6nXcY4aX6tOoLbw0Iupoljf5cMfakbBMy+rmSa0FgSoV9ldZw41TBxnlEOmI7Rvyb
 U1sCJJpv3Of/yZKjKiFNYXHebMklRUpYkUNNzmHbuvJfFAyT4QkzzOlLwiapojnAokaJKUt4brH
 L9tjYc+Yj73rlKpxrnCuLe0EI5ZJYymurwNbone2Fd+DFWV6zhNvlbKZte0Itm+wAGI2KPsRfVD
 HNTgfw1/YiXFK/NaiRunECWypQN+gDwOG/vQYfBwcpvTSr6K1aPttsRjYFw/jh2kHXr9DChu9pL
 yFqAeNP937WF3Vqy4oN0Y1TO5UeHNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050056
X-Spamd-Bar: --
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 80B7F431D7
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_BLOCKED(0.00)[qti.qualcomm.com:mid];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	BLOCKLISTDE_FAIL(0.00)[202.46.23.25:server fail,209.85.214.197:server fail,205.220.180.131:server fail];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received]
Message-ID-Hash: 7AP44K7RWYCQ36J5PAACKT75M24BSC7I
X-Message-ID-Hash: 7AP44K7RWYCQ36J5PAACKT75M24BSC7I
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7AP44K7RWYCQ36J5PAACKT75M24BSC7I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Enable config 'm' for the QCOMTEE driver to facilitate communication with
the Qualcomm Trusted Execution Environment (QTEE) on Qualcomm platforms.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
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
Harshal Dev <hdev@qti.qualcomm.com>

