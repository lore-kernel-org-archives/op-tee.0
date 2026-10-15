Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6138CC6B3A
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:43:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 18AD14531D
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792064610;
	bh=qDDal9GJ8g6Ikut3T7wcy/AIpZjwo/GMmoItp1TdU54=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=PTyNERufCOMj+dnloElMBdbOP3WEAni/saRJV8XrkwP2SFbdQtXNggvfci8A+K81V
	 h4LxtXXI+Uzlm1xgn2byj0FEP4ihx6aBycqItDHmM97j48BQ2ec9ukh+ZkdEnQ6SGa
	 G588m4DgTgEM1kV3p/T6unRWlwic4F0vyaakmqoWffaBoxGXcEGVq0m+gBvES6YriA
	 JkMxryxUWdUqJs40BCZO+sutiS89KjuIlJEC763uTOBAdJvyOyUGP5nEnD8jfVC1OM
	 9P3gJDCI/r5MLAJIhjLLP66ilWG5SP+WpDympwiY3nZD0npDUz6TMHZaf3MP/NvNfM
	 fDoW36Ny1I4MA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 323794531D
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fccRvl3q;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h7HQ+6Ey;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jJcu4077489
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sv2K6+0+MUtgDlrDif2dTZr7/lGThf5F9lPAXQqHnjo=; b=fccRvl3q5BxB0woB
	nKbTJz/u6hBKEKfzNruWtx9hvX9Ha6CuYHJLlKRVIwR1WM82MBSVTl8LTR6bJYKJ
	bUQi2C1N4hWZUz3TP1z52TG3ChLZe3aOQA0FRZavomV00PmszB/X5eQ9WsSJ1h66
	CIiU7fYbankI5D3iC4kfq8/qMKkchaWIxJZF1IseAzA27KFQsITgtPAlL3Kq9Lv5
	rMzyw3XcMuen44/K5u9U3k3CPI+l5etpeymKg7fiolrTlvw6dmEAMMuMsFBn/sQl
	BXpplSx4SF50gSlKTFZdRQQcKq06sj7P+Jo5oI5AfG7ds5tEIF0F9FMPhZbDOTW0
	rqZ69g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc0ghr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-359b81ad4e8so2950220eec.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792064424; x=1792669224; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sv2K6+0+MUtgDlrDif2dTZr7/lGThf5F9lPAXQqHnjo=;
        b=h7HQ+6Ey1jN22ZxwRtzibg67e+w1eNVxzjZ46Tz0xtZR8+uDCu4w3SJPxQmoRfPRTT
         YzakKXFQxBnyF5zXxxxo7DOYA+K7Hxg7y6jkKiotGNt85TzfkIMp9PwO/qzzuEkblk2+
         IajP6YgIuVByp4MWpyAC+xubVY3jb4/xaC5N5JfU71SFrfe1Df4IIj+hwWE9ArLxf7S2
         GcfQilD1gFG/BLGw7ahRhsVV4U/OVqC0SncPC1w/uyweqjeQfpF1HJPC1pgzaTlNAkte
         Ral9OO5vf21pgAdg1O52ShMLHF1sxTwlxl5m+CTxdTyKjjswtEybZwKd28pNGA8zebNS
         sHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064424; x=1792669224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv2K6+0+MUtgDlrDif2dTZr7/lGThf5F9lPAXQqHnjo=;
        b=Ys4GVNaR7VbzscQTkVAOwVBmzOX3MzlzNUhpQmoT7oeNFWGalhrnHzqtjFToiRFjTL
         QJc60RAkPe3SLqMszaG2m/I4y3CpPpYVuo9FE/7s8WrySnTECtc0D4eldxi8rZSDjfmt
         BJy9N28ZoW+BQ/tzu+Q1M3ji9CHEg8a0fBEepTpYgeDfA0r4oKEMpnOcoo6HW9IUPnm/
         LtEBbquAUpyCHncJUj6ikKKwzgIcX77ugev433v57tbe9gXI74M5I+c/mwipY6dDi67f
         zV0aSI9SufsPAjCRkgBnaFZ74Pz1p9qo37YWBzanrstS37qzS2Do6/7Hpap34wJCFLJz
         wbig==
X-Forwarded-Encrypted: i=1; AKwUvBzfqWGc77t7INha5FC6Swi907BSDdV3d5gJuUfDotoKdWDhBixp9LDYXY2L3N51N7G5PHA7JFI=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYI7o2S5+lag56610YlvM+pPEjqg2BB6HuMQPBUOX/2FphqhjwVI
	/HswLQ5IK7cyi0nMXI+gW9VUqFV+KnKZSoIYb65xRGpKvY1pCgB3IiPah5Oz56nqEeXZIUJJXWC
	D8MVyUBgSGvdcMT9vyfwNeSgzwXFxgPmlX99zdjJY2IZhpFLZ8E9lUoD1GFy809sgQYKpPaFg
X-Gm-Gg: AYBFou2hJ5BgGNfoauqEI/JmwCR6KpdlIJQewtuk/cRSU4mL/Ce32kqNRIoaEVDBpEg
	Aat3xdzed8BE54sBvFa3FxAu4mWALJqLs4IjpWvLXqJ0aaUolgS1c8tNkpgDB/8i3ykk/JITqea
	Ldz/jJgAHzOAdC4iOcVOKSX2bjdz9OZYURmSx5qRqBFdMjiQukwiMqelznrUxwJdl7NwpCk+mMt
	JTR5u6dT5BxAwj+AYMrdlajer7xfqVAua5/je4GpPQRVyWTTlObFia9Mg+bWKE6O/LuU6Cxoa38
	0mz+w6sqkL+I2Zq8dqujjt7q6T3l0TSySaovWtrn4it8A9sZiCwqYUSscXjWevYWKpOWq+4oCjl
	TLwQ7CC1I4e645Qc8+gxOPHmH1w==
X-Received: by 2002:a05:7301:77ca:b0:35c:6268:8127 with SMTP id 5a478bee46e88-35c62689d3emr10317820eec.13.1792064423927;
        Thu, 15 Oct 2026 04:40:23 -0700 (PDT)
X-Received: by 2002:a05:7301:77ca:b0:35c:6268:8127 with SMTP id 5a478bee46e88-35c62689d3emr10317790eec.13.1792064423384;
        Thu, 15 Oct 2026 04:40:23 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm48144891eec.11.2026.10.15.04.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:40:23 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:09:41 +0530
Subject: [PATCH v5 7/7] arm64: defconfig: Enable UefiSecApp TEE client
 driver for Qualcomm SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-7-1460691b35d3@oss.qualcomm.com>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792064379; l=1240;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=qDDal9GJ8g6Ikut3T7wcy/AIpZjwo/GMmoItp1TdU54=;
 b=h337Cjzx40d1Oa0bgdtGrc718cUop1UqHCOTA0q42DmHXOvEVZ2J/aBIuy7x0aRk6pSyDNODj
 biXyTymUe2UDJ6HeGcdYLrNpdiHe1seBVm1ao6vlMZcewQz11CPjPbm
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad0bba8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=L1DwG8FsHRaiiIOMTvUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX4gnGbkvOMQpk
 9gAUv2q43HlM8Fvy0bkAd+3EzhIsNsAa/gHwh2/6kPl2f0SHkn0XsOMPxFXES2k5zjHlFBZGWj/
 HaxylSvrsvvqUxJ07emVEqm5ONSCYfA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfXzHqicM6eQ/X/
 OivhCq3O8sgkS9GxHNeXqGyyVWxn7zcvBhNV14s1jIqxZLlQo8owHT5HXKh3zi1M+lfF0Jbemgq
 RmmUee2xlt2IMFmdttfiffzkUZMC30SWCtaRx6YqFHcJlbP54c28ee0cpuvF8/EC/Wl2l97KHy4
 2a6BZ6fkCLYSX9/Om1KfzXjdO8TGf1I0XUMw0v2u+XGuQZPUlnvpWx5FixYkCmnIVDyC+Z3Z/1S
 g71TJ9YJN56xxTxK79eevRb0/0im6JJk8zmsFzmeHmdNMFJfz/bwa47D2l0BET7fSIwBMeAVvVh
 8ejXfH+Z+g3CDCQCBikHkVRjgOOSFghcUIHkg3syhWd8B8TZgq+XSNtL0c6bcCVhEPdk4jY/PPd
 fExPzyDIOYQG8GsJ0dpEc5X6rWVXLk+IhELWdw4PUcc7lih7nv1EtoqJBU2i0MXydATYcq7R9vl
 bvYJ3ybXQR6qfCCRJGw==
X-Proofpoint-ORIG-GUID: 6PyMHFBmZOYlM1TG2bJC-FvbrFTXaE0d
X-Proofpoint-GUID: 6PyMHFBmZOYlM1TG2bJC-FvbrFTXaE0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 323794531D
X-Spamd-Bar: ------
Message-ID-Hash: L5R7SRRY6HF7ARLIRG4EQ3E5DLBLSS47
X-Message-ID-Hash: L5R7SRRY6HF7ARLIRG4EQ3E5DLBLSS47
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/L5R7SRRY6HF7ARLIRG4EQ3E5DLBLSS47/>
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

