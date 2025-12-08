Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088FDD3B7E2
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 12:18:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 344564FF36
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 12:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765196308;
	bh=D6jlFM6qpOYSDEtnec3c9yJRj63yqrXRsBBvck6KMxM=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=MzvH2SiUMjt35mo57Bu13g7X44bDaryjaWi7QmTj+ltD2Q08RfTbAUreJXZxDlUOH
	 axxPzEnjwGIitsxhJYRYXHnRV3L0RXllLZ7ZSMvA/90SWrroCIGwjKmiVwpOu6KI8B
	 RA44t553HUFMfL+guTUqORpxel8MVzqXFaMojxwF6hxXVWgsDlFCHKAqpoGUnMrlyo
	 dPpLMl10uaN7WnlSWyntLtX2x/tSqDBCsG2zjQUU4kSOuJMhHlXzJ4SWRfGh5MZc9o
	 uZI6C083cgYk2vt3j0hrQdYg0pRuW3rt/eEszJAHTPMVrko3qnOFvEjYWiYinm7THe
	 kivU2i0Xs5dHg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0B932431A7
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Dec 2025 12:18:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=irzeHPVN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ggrG5Nva;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B89F8903863014
	for <op-tee@lists.trustedfirmware.org>; Mon, 8 Dec 2025 12:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=r8KgYehjNz2hs0tsOo52W7
	WUurojiETW2ClIwzQ4ql0=; b=irzeHPVN68wPOL/UiQfmdGrbBCHWMvAlcrNfdI
	vQo+B3RXpEF5c/cyZEa00W/MQ5RBdBaPJvBMnKNHwVFEjlFyLAGnpKHQZWjRwh+D
	PLmrzf8CrvgiRQH6ksgA2jlLZOQGTqE91bpIwzq96vJD3Vs2lnvmHKlvYH7+Jlra
	+X71SI+TRW1wmathvoz0JaFaUyS1h+/glVChStpiCNplr67io0Zm2BVU88hhB82t
	rKKcn4sRQAQEtxfXVdCmh3HuFfVN2gJJVUfjml7Nz7TmE62wS2+dNZ3nQcd8PuuA
	mtf4FhJTfaHhahIE6VR50OjX0B5I9fbdvy14gkguaGxFm18A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awuvg0gu4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 12:18:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29da1ea0b97so95113395ad.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 04:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765196295; x=1765801095; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8KgYehjNz2hs0tsOo52W7WUurojiETW2ClIwzQ4ql0=;
        b=ggrG5Nva0AkPisY13vGN8g61vapQ5GcGNLM0uxiDcakQhmooQRetlNkDrya/wYb0mT
         8EhJalLuvTcYRUX/41M7M6OenohmgiXu98TeyAoOuaXN/wHi8IotgYVZ9CrIo05gBpue
         gS6zt8GTrBSpATzEmLogn1ABTrgrxJ17LIzSYHIG0+WQ/ev5+zF/KTjfQhKO77/MvtA4
         kpH0bQfFyIV4aiLnD1UMtoEkQobo7W5qsOE253TjCwXXWHQRyVfpmFETtJiE7Kvq88P2
         dD64xuKzjU/dMh8HfnBE4daWxrX4GTM+Yl5GyD1hKTGIg5fg3S9QdDDREE+xHXCkMwnm
         Pm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765196295; x=1765801095;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8KgYehjNz2hs0tsOo52W7WUurojiETW2ClIwzQ4ql0=;
        b=m6HAe9AxDfq7SL+DhdFTDz8R+QDjtd/EHCRl0SXKAUXUysFwny03e3bu15V+jjvICY
         zsZpTILG+AwcXYuFBJ1PV7wt0EsAal5L+H9aKyFIEHzk/GxqmMPK6t1XLhK/0z8NPidC
         JSRtY1xlIgqjvdW4xerHu3h5svlEw06lJgCDgcnrN2ETHWr2FkzwkgD1qx5ozhNwOfrg
         +/pODYz9+K9CGVPDQ9wOdIdWQ/sHKbdMOhI742HKjSiX6XZmNmIroWXtwmMeYcPkLRn5
         RnEigwrbnRJKSvUr5rdPSU7HGy67Rn93hiGGyzETq4fn29hHA9LV/FvrjO3rdQUffuqt
         h4UA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Difyyh+dEKvyRnhHaStdj7hv5EObQuMi7RW60XqtPrtm7x62GvhLhWATlVKalorf53Frjh8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxDQgPN4UeTSFLMGQ6NEoz+L7NEkq4zM8sVmDSmcsgN70FnTXiN
	WDSx8xRGBjufbcIbb4ADGa1GC9grV5PM+wiT4+IOrkz/Ea6a1GzvvH4M6r2pux0P//dE819r5z5
	EDvxckDWK9pXN1f11Vx68unUmkxoMeLZmI1V/ipm1dff2zLclhZNJ3zCGzSp9ZDxShKMD0TCh
X-Gm-Gg: ASbGnctoRJ9wR2Q5h4l7GyLXZW0MPnu3PhnjL9f82hYB7oi0YU3L+ykpRRrl3Tf0PqO
	6DY2EwyQIE7blGjPrgi6HmYU2wh4MUocre09BdAMZZ+znYiCQPMHJz8SahBUFG6QBRRxBMbJ8VB
	Qy2Vkea94lLMyXIdfyZbyV4gUVnqwC67pOXCPFBQQtIwmqzdvpF5vkCNtM2R1e3P09xLHIiOq26
	DJECOlNd+bdURubbcC6ovUItV6lPYoa5RvQXFr6hikxS0ER5T6OFYOxafjxjqbY6pqlhhI3Da7Y
	QpJB++wSqOHXHV6Wgce0sIF7Z+lkxARG8KKCQbx1OXVz1b8MblmehJ334lQ8MfpTXtT1NPdsiY1
	rI/2ZnIcZndP/mdbp6xNzCWVgzjhu7Wt1u2U=
X-Received: by 2002:a17:902:d4ce:b0:299:bdaa:a886 with SMTP id d9443c01a7336-29df54722eamr67230625ad.12.1765196295345;
        Mon, 08 Dec 2025 04:18:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0rG4fTBix2eOpryIF0lz8usdxt4K1kw58A1htdG9AuIp9gNNdolLr90ra94yaa4r2fGSeDw==
X-Received: by 2002:a17:902:d4ce:b0:299:bdaa:a886 with SMTP id d9443c01a7336-29df54722eamr67230365ad.12.1765196294832;
        Mon, 08 Dec 2025 04:18:14 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4d3a0esm123116805ad.42.2025.12.08.04.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 04:18:14 -0800 (PST)
Date: Mon, 08 Dec 2025 17:48:05 +0530
Subject: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPzBNmkC/4XN0QqDIBQG4FcJr2eoWbRd9R5jhOmxhC2XNtmI3
 n2nrsZgDOGH/3DO50IiBAeRnLKFBEguOj9iKQ4Z0YMae6DOYCeCiZJj0En7W7vFDNAasNqP1vW
 0NppZMFxy3hE8vgew7rnD5wv2wcXZh9f+T+Lb9C+ZOMXHOwuSqRqUbHyM+fRQV1y95Rhkk5P41
 MqfmkBNH0VZsY4VsoJmmt2Xtq7rG4hZ4uoRAQAA
X-Change-ID: 20251202-qcom_qcomtee_defconfig-8dc0fed1411b
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765196291; l=1365;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=D6jlFM6qpOYSDEtnec3c9yJRj63yqrXRsBBvck6KMxM=;
 b=YMDvEb1JSB7izZ4RCeRiTa0OAOvn0uDus73lidnPilmPzXI0aOzFyuY0uQJCj3GULzxQ+S5LJ
 DikYR/4WGV1AODtwOsf/fskqAcUmQWNglSY7PaKh4YpJ0sBfWea5Gx/
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDEwNCBTYWx0ZWRfXzNpFkAOCy0lc
 tnIfRRy0+UNI7E2DipzPKz2aPF5HkazTBe98qI68cLRMjr13jpNVW690pXUdQZCPFxbsEhIoPoN
 c+PkMIKNchiQi3qxiozR9xjA7iPA32Gpew35BBFYWmafq/nVSi95Hkuuh+unVTMcahZR5gVXT63
 767ZNp36Zrn9oyBM6BFRaGhN3Ho/Ejdtypa8tXhWn+LBQ3x20imd5zyPj1nwfmtLeyHMpq00Ci8
 cYaOMYb/k+fE9vdqZPua2y+PxxZmZeTsJ2s48f+ov8OdFkN2i2VZEWzi9xRoXpHhxBbrMXs3eUp
 weOtTUbRbVMKSR9k27pXn55rXky+MhCCDRps1FX1Sx90gcNOo4yPxntzmZauMNp7fNm++ilfgc7
 vt+9F73JX/syeo6FwS8G86R7XNsnmQ==
X-Proofpoint-ORIG-GUID: 8X9zOogNbeFK5FjbmbfKUj-bXhNcabu1
X-Authority-Analysis: v=2.4 cv=cqSWUl4i c=1 sm=1 tr=0 ts=6936c207 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=uAwLMdngRYKIU0bMnCgA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 8X9zOogNbeFK5FjbmbfKUj-bXhNcabu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080104
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0B932431A7
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[202.46.23.25:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received]
Message-ID-Hash: 5JVL5YJZOBJS3RU5I7PCQ5IWWEMIN5VP
X-Message-ID-Hash: 5JVL5YJZOBJS3RU5I7PCQ5IWWEMIN5VP
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5JVL5YJZOBJS3RU5I7PCQ5IWWEMIN5VP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Enable QCOMTEE driver on Qualcomm SM8650+ SoCs to facilitate communication
with the Qualcomm Trusted Execution Environment (QTEE).
(No enablement required in DTS files since QCOMTEE device is dynamically
registered by the QCOM_SCM firmware driver)

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
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

