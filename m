Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08F8CA5FED
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:37:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3891A4545C
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791286636;
	bh=1p6kbTMvG16AtIwB5BEp4QBVRpIkLRoY8NmP+PjYLhI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=fy8gR+kgEMNk1pVEy3f1cRkJZ/KTmMhqkD/dI4e0prEM0ZfdqwET93sRAEHxkv7+g
	 lOsMvo4n8vD/iTpfl+7/47CARsIGImiPio0noNC/n9fU08bKkcjvijgmsOzQtHGwiS
	 uwJDx++JvztLFYVXp3Tsmmhc34vkMOW3NONw0ehxHrVvr8Qa+FmgGcSTcoCfj5TPvd
	 yTm9YGRkFrsomBE8Qw+wHok2BEbQ8SzVvADxVCYXslvR3DAz1KklZpzsDzMu7ym/ZA
	 Kz8sCt7roVf1tYyIfonD66cRukRhs3BqxApiBWF5OCbjOiuY+QZUPZ4CGAlkLHAG2r
	 MsYkBav5Ja4Dw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D958D45481
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 11:34:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h1KsrxVn;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TCikCs0n;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPEn7680829
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 11:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8tVx+KWykK46duYxxAHkzWrL4DrcqdJpqyoSSPQuggo=; b=h1KsrxVnH25Cddum
	dw6+MNGm4yiJn/CGhYTT7EOkO5BG5KxGQ672fUTO5UfEbir1MvKhlfCq+NKAqFjz
	XC+fcauYBxqadDQ7mQpCAQcT1gBz2ttiLngwcIwD8ywXUp2TX4nB4aWSXUTG0gJr
	iwK7LAH2NU/AhLMb5EOPRyd4xWOx8dcjhhd1vBh3c7JXCbU2DUXOI2Gd9SsTW44F
	2CVQEQwdhKK4n2UfIzmH/VuKSilh04u43818OVuv7r4XgaC/IiVWesYTdlI15SER
	qANOw/2Gpnx9cPH3rm3VEmbD2ye0bpCmgTqkLBfkx1x68L6y3UGRkDExtKZ92jhy
	v6ZC0w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9rd1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 11:34:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1cade6b71so684750a12.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 04:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791286474; x=1791891274; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tVx+KWykK46duYxxAHkzWrL4DrcqdJpqyoSSPQuggo=;
        b=TCikCs0n9KykKWY8yGMt3vu9rADk51J29RioQBB8uWxlnPl5kJ9JWLd2AeSHPpXbOg
         k1IlWNcITs+CGdZ7xlUgC2HawHNEQUn/gPPNYVk7+CDjmkp5/hFXRFUVtI0cT0X7oY44
         rWVbsX2M1RQa9SfCZQWd93f4tEjXt4EtzrIZef+sxqzcnomQckarc5s21lKWA402eXhH
         fvqQxaJvPE/mbei0x44Y37TuztmanmFP7vr42RRcJj040vHKcDaTGN2VpXG9TS37GQmE
         lhS0FF+5+nygjozfxebk68OUjRx8ui0MG1Oh3ol4eT+hNzOObcdtrNuqinU0v6styW3j
         MmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286474; x=1791891274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8tVx+KWykK46duYxxAHkzWrL4DrcqdJpqyoSSPQuggo=;
        b=NFxushDjsqVWZsUuqKkAmCKzq5O9j3OhyF7x0nKFgSCoCor/si07vgk7uu7kvnVgp/
         L+FuCv+zQjm/OxMw7ljUyoEMPciWeCK8ZLWqbnXNGPFdQspi++YfcSx5voxXOjS70Fgd
         vi04pgnK8E6R8HQwOVgwa0yTyHovfjCSJlZjxBnD886hm2yBcNcLr0zRHWIDMiHyMm7m
         qSQhFj+0hShWtIwNxB4vMC8xYDe1YWhGXVKSc8g5+BsraMuf5hLYLDSy5FY4bzfYp/NM
         L/4oDKQ42KxKqEf3YRwBqmOVn/eWgHLt0HZUaSOAYUEKXdRifJuOSFr+xbwzzrw6JuRy
         B1vQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCIWRoAfc+1hOq4/RLV/MQpO28+qwRzRDidlbmlAy+00Q4+aLN38tPzjMURFW1te58jRVo/54=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKvSS9n+DzAszm4o18qO+5biSF/6vnzy8IS8NUf6DzfM9yielLv
	Xbc7nPvAweEe+Ym7CsF81F/Y49TsQB5N1kHm60n7nVOsPCn27KV3qeBe2MYEUGEpwHieEbkdtao
	ulMbL7fGxfgMGTaGkcyQt88XzbuxajLb4lYT+sufPcj/QcY3oozDiMX+mVtDjvXAGIqaWeE6K
X-Gm-Gg: AYBFou0VMKxaIK6vSmS93YRVsnqHQgIzdaA6jmUPI9q2IJPL8YbxKmWuFn7CQ05orQ6
	jIA9CTgixZVmiFFOKXeSkz8yPzHXyBrdrZ7VhUcL1ZhWuREMfRWyyIGZ1T6Pm6EszzYTUK8L2yG
	PWfE9H7ov73KBV1MgQcXsfOwYb5OXStpiVRqvlfKUKm1ldYn1KBlbQu6sAIjce7Axh4xG0oPHbJ
	zT67oxBkcKKocM/YUxNdVoCvNB44IpIWK+Gut5Oqs/cRn375PeRQDtPvSVPrJENvuBBvBPopLlX
	IDKAZEtfELlKEmDy0wBVDUAPVIguYSrbweZm7YKFsECJ626w7XTxQXLV65U/divj+PkIK5R0MZW
	9WrAhUW1GNLMiL7o0k9yQz3kO
X-Received: by 2002:a17:90b:4c04:b0:3a0:c20b:2ff1 with SMTP id 98e67ed59e1d1-3a87373eb38mr562358a91.28.1791286473859;
        Tue, 06 Oct 2026 04:34:33 -0700 (PDT)
X-Received: by 2002:a17:90b:4c04:b0:3a0:c20b:2ff1 with SMTP id 98e67ed59e1d1-3a87373eb38mr562304a91.28.1791286471877;
        Tue, 06 Oct 2026 04:34:31 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a709a4e80bsm9330092a91.4.2026.10.06.04.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:34:31 -0700 (PDT)
Date: Tue, 06 Oct 2026 17:03:27 +0530
Subject: [PATCH v4 6/7] firmware: qcom: Add support for TEE based EFI-var
 client driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-6-bf1c8e2a64ab@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791286430; l=26352;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=1p6kbTMvG16AtIwB5BEp4QBVRpIkLRoY8NmP+PjYLhI=;
 b=hiHAykyxZYEltwWILaTPyavwWHu7RlLJS7dJa1bgotp4jvRNa8bh/ADSaaBIpwH4BpClHmGVO
 Xxh9R1+/VnTDQKcSqw/VtnD6DsKkRpdyNyojOYRLaZf+RH1FtjYniw2
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac4dccb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=lX1A334Kam2MR8cuwK8A:9
 a=Fj3fdtCelTHB4AuG:21 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfXzdMscMAvIgW4
 6jgtRtbU/OdON1+Gsi9Qsy1N5KW43/TTgtCfsWh91F6WFwP29hIDNKukJd7PnCx3lVitfd2FH+8
 DHQ1UsMSiRPZ0sxjI6ygDimX429y5jc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfXwN3Wv+PRUKhI
 pDKKMbimAglmMOg6T9oGdwA9kP4CK6aZQiQRxAQsWMRB6IIT/ZJy7eWPno6+SAa6zGwVSLlV9FM
 CcAEpI1Z5JJqxgtejjtvtXzRUOQwnXaCMTL2Qa79L1UKI1xbRiFecvZRmlPs3JfVfbe79kSYqVn
 nmlKxhwMUOxl6XK2A/UOvOy+CJ6FDh6GiQt5LcsGWcZ39kqBalJCJWHbY5g6smVn5AKnu4QtP2L
 /n504yYCN7WomWySxpVMW88pQNY1HgqslAKbktQe8apmWD4r3xdGsXkR96U/kmARuRo7f9pdWVq
 6NvFLHEEart1z56CvtyE/babPQRcpv2V3DA8qAY40Xkg9179XwzJUDjl52uzjuzgNIb1j5DqwJn
 LBstZhCpR4j4wPPS4OFDsUTt7NfwrP3+ghdDtnnWshLuwV+NIJvnTFqtEbvza1QZg2vu/vTl0uh
 d4HonOw/WOMYAnHJRuA==
X-Proofpoint-ORIG-GUID: 24A2uuUHcyHphjHvBFFPpu-iRTfeAVfz
X-Proofpoint-GUID: 24A2uuUHcyHphjHvBFFPpu-iRTfeAVfz
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D958D45481
X-Spamd-Bar: ------
Message-ID-Hash: H6OPCAR4SRJG55UUUA3D4LQ6EMQLJNCI
X-Message-ID-Hash: H6OPCAR4SRJG55UUUA3D4LQ6EMQLJNCI
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/H6OPCAR4SRJG55UUUA3D4LQ6EMQLJNCI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

On Qualcomm SoC based platforms, UEFI stores EFI variables within the
Replay Protected Memory Block (RPMB) located within either the UFS,
eMMC or SPI-NOR storage. The RPMB key which is one-time programmed into
the storage controller to allow authentication of the RPMB frames is
generated by and only available to the Qualcomm Trusted Execution
Environment (QTEE).

The legacy QSEECOM protocol used for communicating with the QTEE is
deprecated and replaced with the use-case agnostic SMCInvoke protocol
starting with the Qualcomm SM8x50 series. On platforms where the QSEECOM
driver still probes, it does not support a listener interface with QTEE
to enable writing of non-volatile EFI variables to the RPMB for UFS and
eMMC storage.
Therefore on such platforms, a TEE client driver which communicates with
QTEE via the SMCInvoke protocol implemented by the QCOMTEE driver (and
registered with the TEE subsystem) must be used to update such EFI
variables.

Add support for a TEE based uefisecapp client driver which installs efivar
operations after obtaining an object reference to the uefisecapp service.
This enables the kernel/user-space to access or modify both volatile EFI
variables stored by the Secure Application (in-memory) and non-volatile
ones stored within RPMB.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 MAINTAINERS                                 |   6 +
 drivers/firmware/qcom/Kconfig               |  31 ++
 drivers/firmware/qcom/Makefile              |   1 +
 drivers/firmware/qcom/qcom_tee_uefisecapp.c | 648 ++++++++++++++++++++++++++++
 4 files changed, 686 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30c1cdd0fb38..7ccedad8d388 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22981,6 +22981,12 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
 
+QUALCOMM TEE UEFISECAPP DRIVER
+M:	Harshal Dev <harshal.dev@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/qcom/qcom_tee_uefisecapp.c
+
 QUALCOMM PINCTRL DRIVERS
 M:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index 3ad22f8fc3e5..694d98fef4f4 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -79,4 +79,35 @@ config QCOM_QSEECOM_UEFISECAPP
 	  Select Y here to provide access to EFI variables on the aforementioned
 	  platforms.
 
+config QCOM_TEE_UEFISECAPP
+	tristate "Qualcomm TEE UEFI Secure App client driver"
+	depends on QCOMTEE
+	depends on EFI
+	help
+	  The QSEECOM protocol used for communicating with the Qualcomm Trusted
+	  Execution Environment (QTEE) is deprecated and replaced with the SMCInvoke
+	  protocol starting with the Qualcomm SM8x50 series. On platforms where the
+	  QSEECOM protocol still works (the QSEECOM driver probes) the driver does
+	  not support a listener interface with QTEE to enable writing of
+	  non-volatile EFI variables (via listener requests to Linux) in the Replay
+	  Protected Memory Block (RPMB) located on UFS/eMMC storage.
+	  Therefore on such platforms, the TEE based uefisecapp client driver
+	  (which communicates with QTEE via the SMCInvoke protocol) must be used
+	  to update such EFI variables through the RPMB service hosted in the QTEE
+	  supplicant user-space daemon (github.com/qualcomm/minkipc) which forwards
+	  RPMB packets to the RPMB device.
+	  NOTE: Qualcomm Compute platforms with SPI-NOR storage are an exception to
+	  this scenario. Since they do not have a firmware running on their SPI-NOR
+	  storage controller which must be programmed with a RPMB key, QTEE has a
+	  SPI-NOR driver which holds the key, and so the QSEECOM driver can be used
+	  for updating EFI variables on these platforms because QTEE never makes a
+	  listener request to Linux (QTEE doesn't need the Linux SPI-NOR driver).
+
+	  This module provides a TEE client driver for uefisecapp, installing efivar
+	  operations to allow the kernel and user-space access to EFI variables.
+
+	  Select m here to provide access to EFI variables on the aforementioned
+	  platforms if your Linux distribution has QTEE supplicant installed and
+	  running.
+
 endmenu
diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
index 88ce74d74c3e..237192b74de3 100644
--- a/drivers/firmware/qcom/Makefile
+++ b/drivers/firmware/qcom/Makefile
@@ -9,5 +9,6 @@ CFLAGS_qcom_scm-smc.o := -I$(src)
 obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
 obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
 obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
+obj-$(CONFIG_QCOM_TEE_UEFISECAPP) += qcom_tee_uefisecapp.o
 obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
 obj-$(CONFIG_QCOM_PAS_TEE)	+= qcom_pas_tee.o
diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
new file mode 100644
index 000000000000..acb1709c0a53
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
@@ -0,0 +1,648 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/efi.h>
+#include <linux/tee.h>
+#include <linux/tee_drv.h>
+#include <linux/ucs2_string.h>
+
+#define QCOMTEE_OP_CLIENT_ENV_OPEN 0
+#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS 5
+
+/* Each service exposed by QTEE is identified by a 32-bit UID */
+#define QCOMTEE_UEFI_SEC_UID                 413
+
+/* Operations supported by the UEFI Sec App service */
+#define QCOMTEE_UEFI_SEC_OP_GET_VAR 0
+#define QCOMTEE_UEFI_SEC_OP_SET_VAR 1
+#define QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO 2
+#define QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME 3
+
+#define QCOMTEE_GET_VAR_NPARAMS 5
+#define QCOMTEE_SET_VAR_NPARAMS 4
+#define QCOMTEE_QUERY_VAR_NPARAMS 2
+#define QCOMTEE_GET_NEXT_VAR_NPARAMS 4
+#define QCOMTEE_GET_UEFI_SVC_NPARAMS 2
+#define QCOMTEE_GET_CLIENT_ENV_NPARAMS 2
+
+/* Error codes returned by the UEFI Sec App service */
+#define QCOMTEE_UEFI_SEC_SUCCESS 0
+#define QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER 10
+#define QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED 11
+#define QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED 12
+#define QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION 13
+#define QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR 14
+#define QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES 15
+#define QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED 16
+#define QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT 17
+#define QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND 18
+#define QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED 19
+
+/* Operations for objects are 32-bit. QCOMTEE transport uses the upper 16 bits. */
+#define QCOMTEE_MSG_OBJECT_OP_MASK GENMASK(15, 0)
+#define QCOMTEE_MSG_OBJECT_OP_RELEASE (QCOMTEE_MSG_OBJECT_OP_MASK - 0)
+
+/**
+ * struct qcomtee_uefisec_app - An instance of UEFI Secure Application.
+ * @dev: TEE client device on the TEE bus which represents uefisecapp.
+ * @ctx: The context opened with the TEE subsystem by the uefisecapp client.
+ * @uefisec_svc_obj: A TEE object representing the uefisecapp service.
+ * @efivars: EFI variables registered with the EFI subsystem.
+ */
+struct qcomtee_uefisec_app {
+	struct device *dev;
+	struct tee_context *ctx;
+	struct tee_param_objref uefisec_svc_obj;
+	struct efivars efivars;
+};
+
+#define UEFISECAPP_UUID \
+	UUID_INIT(0x01f95dcd, 0x2d7e, 0x58be, \
+		  0xa1, 0x43, 0x81, 0x32, 0xa1, 0x72, 0xdb, 0x7d)
+
+/* Short-hands for these long attribute names */
+#define UBUF_INPUT     TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT
+#define UBUF_OUTPUT    TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT
+#define OBJREF_INPUT   TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT
+#define OBJREF_OUTPUT  TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT
+
+/* Init instance of 'struct tee_param_objref'. */
+#define SET_TEE_PARAM_OBJREF(param, attri, obj_id, obj_flag) do { \
+		(param).attr = (attri); \
+		(param).u.objref.id = (obj_id); \
+		(param).u.objref.flags = (obj_flag); \
+	} while (0)
+
+/* Init instance of 'struct tee_param_ubuf'. */
+#define SET_TEE_PARAM_UBUF(param, attri, ubuff) do { \
+		(param).attr = (attri); \
+		(param).u.ubuf = (ubuff);  \
+	} while (0)
+
+#define TEE_PARAM_UBUF(x) ((struct tee_param_ubuf){ .addr = &(x), sizeof(x) })
+
+#define SET_INVOKE_ARG(arg, object_id, opp, nparam) do { \
+		(arg).id = (object_id); \
+		(arg).op = (opp); \
+		(arg).num_params = (nparam); \
+	} while (0)
+
+static inline efi_status_t uefisecapp_err_to_efi_status(u32 err)
+{
+	switch (err) {
+	case QCOMTEE_UEFI_SEC_SUCCESS:
+		return EFI_SUCCESS;
+
+	case QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER:
+		return EFI_INVALID_PARAMETER;
+
+	case QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED:
+		return EFI_UNSUPPORTED;
+
+	case QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED:
+		return EFI_WRITE_PROTECTED;
+
+	case QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION:
+		return EFI_SECURITY_VIOLATION;
+
+	case QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR:
+		return EFI_DEVICE_ERROR;
+
+	case QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES:
+		return EFI_OUT_OF_RESOURCES;
+
+	case QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT:
+		return EFI_BUFFER_TOO_SMALL;
+
+	case QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND:
+		return EFI_NOT_FOUND;
+
+	/* No matching on EFI_* list. */
+	case QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED: /* EFI_ALREADY_STARTED.  */
+	case QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED: /* EFI_VOLUME_CORRUPTED. */
+	default:
+		return EFI_DEVICE_ERROR;
+	}
+}
+
+static struct qcomtee_uefisec_app uefisec_app;
+
+static int qcuefi_get_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
+			       struct tee_param_ubuf in_attributes,
+			       struct tee_param_ubuf *data,
+			       u32 *out_attributes, u32 *out_errno)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
+	struct tee_param param[QCOMTEE_GET_VAR_NPARAMS];
+
+	struct {
+		efi_guid_t guid;
+		u32 in_data_size;
+	} in_cong = { 0 };
+
+	struct {
+		u32 out_data_size;
+		u32 attributes;
+		u32 errno;
+	} out_cong = { 0 };
+
+	in_cong.guid = *guid;
+	in_cong.in_data_size = data->size;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id,
+		       QCOMTEE_UEFI_SEC_OP_GET_VAR,
+		       QCOMTEE_GET_VAR_NPARAMS);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
+	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
+	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, in_attributes);
+	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
+	SET_TEE_PARAM_UBUF(param[4], UBUF_OUTPUT, *data);
+
+	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_VAR invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	data->size = out_cong.out_data_size;
+	*out_attributes = out_cong.attributes;
+	*out_errno = out_cong.errno;
+
+	return ret;
+}
+
+static efi_status_t qcomtee_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid,
+					      u32 *attr, unsigned long *data_size,
+					      void *data)
+{
+	int ret;
+	u32 in_attr, out_attributes, out_errno;
+	struct tee_param_ubuf in_data, in_var, in_attributes;
+
+	if (!name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	/* 'attr' can be NULL, however an input attribute is always expected
+	 * by UefiSecApp TA
+	 */
+	in_attr = 0;
+	if (attr)
+		in_attr = *attr;
+
+	in_data = (struct tee_param_ubuf){ .addr = data, *data_size };
+	in_var = (struct tee_param_ubuf){ .addr = name,
+					  (ucs2_strlen(name) + 1) * sizeof(*name) };
+	in_attributes = (struct tee_param_ubuf){ .addr = &in_attr, sizeof(u32) };
+
+	/* On SUCCESS, 'data' member of 'in_data' has already been updated. */
+	ret = qcuefi_get_variable(in_var, guid, in_attributes, &in_data,
+				  &out_attributes, &out_errno);
+
+	if (ret)
+		return EFI_DEVICE_ERROR;
+
+	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT) {
+		/* If 'attr' is NULL 'out_attributes' is not updated. */
+		if (attr)
+			*attr = out_attributes;
+
+		*data_size = in_data.size;
+	}
+
+	return uefisecapp_err_to_efi_status(out_errno);
+}
+
+static int qcuefi_set_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
+			       u32 attributes, struct tee_param_ubuf data,
+			       u32 *out_errno)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
+	struct tee_param param[QCOMTEE_SET_VAR_NPARAMS];
+
+	struct {
+		efi_guid_t guid;
+		u32 attributes;
+		u32 in_data_size;
+	} in_cong = { 0 };
+
+	in_cong.guid = *guid;
+	in_cong.attributes = attributes;
+	in_cong.in_data_size = data.size;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id,
+		       QCOMTEE_UEFI_SEC_OP_SET_VAR,
+		       QCOMTEE_SET_VAR_NPARAMS);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
+	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
+	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, data);
+	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(*out_errno));
+
+	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_SET_VAR invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	return ret;
+}
+
+static efi_status_t qcomtee_uefi_set_variable(efi_char16_t *name, efi_guid_t *guid,
+					      u32 attr, unsigned long data_size,
+					      void *data)
+{
+	int ret;
+	u32 out_errno;
+	struct tee_param_ubuf in_data, in_var;
+
+	if (!name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	in_data = (struct tee_param_ubuf){ .addr = data, data_size };
+	in_var = (struct tee_param_ubuf){ .addr = name,
+					  (ucs2_strlen(name) + 1) * sizeof(*name) };
+
+	ret = qcuefi_set_variable(in_var, guid, attr, in_data, &out_errno);
+	if (ret)
+		return EFI_DEVICE_ERROR;
+
+	return uefisecapp_err_to_efi_status(out_errno);
+}
+
+static int qcuefi_get_next_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
+				    struct tee_param_ubuf *out_variable,
+				    efi_guid_t *out_vendor_guid, u32 *out_errno)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
+	struct tee_param param[QCOMTEE_GET_NEXT_VAR_NPARAMS];
+
+	struct {
+		efi_guid_t guid;
+		u32 in_data_size;
+	} in_cong = { 0 };
+
+	struct {
+		efi_guid_t guid;
+		u32 out_data_size;
+		u32 errno;
+	} out_cong = { 0 };
+
+	/* Pass size of available buffer */
+	in_cong.in_data_size = out_variable->size;
+	in_cong.guid = *guid;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id,
+		       QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME,
+		       QCOMTEE_GET_NEXT_VAR_NPARAMS);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
+	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
+	SET_TEE_PARAM_UBUF(param[2], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
+	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, *out_variable);
+
+	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	/* UefiSecApp TA does not touch 'out_variable.size'. Update it here.
+	 * On SUCCESS (!out_errno), 'out_data_size' is length of name in 'out_variable.addr'.
+	 * On failure (out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT), 'out_data_size' is
+	 * actual name length.
+	 * Otherwise, it's undefined.
+	 */
+	out_variable->size = out_cong.out_data_size;
+	*out_vendor_guid = out_cong.guid;
+	*out_errno = out_cong.errno;
+
+	return ret;
+}
+
+static efi_status_t qcomtee_uefi_get_next_variable(unsigned long *name_size,
+						   efi_char16_t *name,
+						   efi_guid_t *guid)
+{
+	int ret;
+	u32 out_errno;
+	efi_guid_t out_guid;
+	struct tee_param_ubuf in_var, out_var;
+
+	if (!name_size || !name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	if (*name_size == 0)
+		return EFI_INVALID_PARAMETER;
+
+	/* For 'in_var', 'name_size' is not necessarily size of 'name';
+	 * could be size of buffer where 'name' has been stored. TA expects a
+	 * NULL-terminated string in 'name' and ignores the size.
+	 * For 'out_var', 'name_size' is size of buffer pointed by 'name'.
+	 */
+	in_var = (struct tee_param_ubuf){ .addr = name, *name_size };
+	out_var = (struct tee_param_ubuf){ .addr = name, *name_size };
+
+	ret = qcuefi_get_next_variable(in_var, guid, &out_var, &out_guid,
+				       &out_errno);
+	if (ret)
+		return EFI_DEVICE_ERROR;
+
+	if (!out_errno)
+		*guid = out_guid;
+
+	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT)
+		*name_size = out_var.size;
+
+	/* On SUCCESS, 'name' stores the next variable name. */
+	return uefisecapp_err_to_efi_status(out_errno);
+}
+
+static int qcuefi_query_variable_info(u32 attributes,
+				      u64 *maximum_variable_storage_size,
+				      u64 *remaining_variable_storage_size,
+				      u64 *maximum_variable_size, u32 *out_errno)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
+	struct tee_param param[QCOMTEE_QUERY_VAR_NPARAMS];
+
+	struct {
+		u64 max_var_storage_size;
+		u64 remaining_var_storage_size;
+		u64 maximum_var_size;
+		u32 errno;
+	} out_cong = { 0 };
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id,
+		       QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO,
+		       QCOMTEE_QUERY_VAR_NPARAMS);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(attributes));
+	SET_TEE_PARAM_UBUF(param[1], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
+
+	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	*maximum_variable_storage_size = out_cong.max_var_storage_size;
+	*remaining_variable_storage_size = out_cong.remaining_var_storage_size;
+	*maximum_variable_size = out_cong.maximum_var_size;
+	*out_errno = out_cong.errno;
+
+	return ret;
+}
+
+static efi_status_t qcomtee_uefi_query_variable_info(u32 attr, u64 *storage_space,
+						     u64 *remaining_space,
+						     u64 *max_variable_size)
+{
+	int ret;
+	u32 out_errno;
+	u64 maximum_variable_storage_size;
+	u64 remaining_variable_storage_size;
+	u64 maximum_variable_size;
+
+	if (!storage_space || !remaining_space || !max_variable_size)
+		return EFI_INVALID_PARAMETER;
+
+	ret = qcuefi_query_variable_info(attr,
+					 &maximum_variable_storage_size,
+					 &remaining_variable_storage_size,
+					 &maximum_variable_size,
+					 &out_errno);
+
+	if (ret)
+		return EFI_DEVICE_ERROR;
+
+	if (!out_errno) {
+		*storage_space = maximum_variable_storage_size;
+		*remaining_space = remaining_variable_storage_size;
+		*max_variable_size = maximum_variable_size;
+	}
+
+	return uefisecapp_err_to_efi_status(out_errno);
+}
+
+/**
+ * qcomtee_release_object() - Release an object returned by QTEE.
+ *
+ * Each object returned by QTEE repesents a secure service exposed to the
+ * client. Whenever an secure service is opened, QTEE may allocate resources
+ * on the client's behalf. Therefore, once the client is done accessing the
+ * secure service, the object representing it should be explicitly released
+ * so that QTEE can release the associated resources as well.
+ *
+ * @ctx: TEE context.
+ * @object: The object to release.
+ */
+static void qcomtee_release_object(struct tee_context *ctx,
+				   struct tee_param_objref object)
+{
+	struct tee_ioctl_object_invoke_arg inv_arg;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	SET_INVOKE_ARG(inv_arg, object.id, QCOMTEE_MSG_OBJECT_OP_RELEASE, 0);
+	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
+}
+
+/**
+ * qcomtee_get_uefisec_svc_obj() - Get a UEFI Secure App service object to
+ * begin communication with the service.
+ * @ctx: TEE context.
+ * @client_env_obj: The client environment object returned earlier by QTEE.
+ * @uefisec_svc_obj: The UEFI Secure App service object.
+ *
+ * Returns 0 on success.
+ * Returns < 0 if client environment object invocation failed.
+ * Returns > 0 if client environment invocation was success but UEFI Secure App
+ * service object could not be returned for some other reason (represented by the
+ * returned value)
+ */
+static int qcomtee_get_uefisec_svc_obj(struct tee_context *ctx,
+				       struct tee_param_objref client_env_obj,
+				       struct tee_param_objref *uefisec_svc_obj)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	u64 obj_id = client_env_obj.id;
+	struct tee_param param[QCOMTEE_GET_UEFI_SVC_NPARAMS];
+	u32 uefisec_uid = QCOMTEE_UEFI_SEC_UID;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, obj_id,
+		       QCOMTEE_OP_CLIENT_ENV_OPEN,
+		       QCOMTEE_GET_UEFI_SVC_NPARAMS);
+	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(uefisec_uid));
+	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
+
+	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_CLIENT_ENV_OPEN invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	*uefisec_svc_obj = param[1].u.objref;
+	return ret;
+}
+
+/**
+ * qcomtee_get_client_env_obj() - Get a client environment object to begin
+ * object exchange with QTEE.
+ * @ctx: TEE context.
+ * @client_env_obj: The client environment object returned by QTEE.
+ *
+ * Returns 0 on success.
+ * Returns < 0 if root object invocation failed.
+ * Returns > 0 if root object invocation was success but client environment
+ * object could not be returned for some other reason (represented by the
+ * returned value)
+ */
+static int qcomtee_get_client_env_obj(struct tee_context *ctx,
+				      struct tee_param_objref *client_env_obj)
+{
+	int ret;
+	struct tee_ioctl_object_invoke_arg inv_arg;
+	struct tee_param param[QCOMTEE_GET_CLIENT_ENV_NPARAMS];
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	SET_INVOKE_ARG(inv_arg, TEE_OBJREF_NULL,
+		       QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS,
+		       QCOMTEE_GET_CLIENT_ENV_NPARAMS);
+	SET_TEE_PARAM_OBJREF(param[0], OBJREF_INPUT, TEE_OBJREF_NULL, 0);
+	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
+
+	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(uefisec_app.dev, "QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS invoke ret: %d, err: 0x%x\n",
+			ret, inv_arg.ret);
+		return ret ?: inv_arg.ret;
+	}
+
+	*client_env_obj = param[1].u.objref;
+	return ret;
+}
+
+static const struct efivar_operations qcom_efivar_ops = {
+	.get_variable = qcomtee_uefi_get_variable,
+	.set_variable = qcomtee_uefi_set_variable,
+	.get_next_variable = qcomtee_uefi_get_next_variable,
+	.query_variable_info = qcomtee_uefi_query_variable_info,
+};
+
+static int qcomtee_ctx_match(struct tee_ioctl_version_data *ver,
+			     const void *data)
+{
+	return (ver->impl_id == TEE_IMPL_ID_QTEE);
+}
+
+static int qcomtee_uefisecapp_probe(struct tee_client_device *tee_dev)
+{
+	int ret, err;
+	struct tee_param_objref client_env_obj;
+	struct tee_param_objref uefisec_svc_obj;
+
+	uefisec_app.dev = &tee_dev->dev;
+	/* Open context with QCOMTEE driver */
+	uefisec_app.ctx = tee_client_open_context(NULL, qcomtee_ctx_match, NULL,
+						  NULL);
+	if (IS_ERR(uefisec_app.ctx))
+		return -ENODEV;
+
+	/* Obtain a reference to client_env object to begin object exchange
+	 * with QTEE
+	 */
+	ret = qcomtee_get_client_env_obj(uefisec_app.ctx, &client_env_obj);
+	if (ret) {
+		err = -EINVAL;
+		goto err_get_client_env;
+	}
+
+	/* Obtain a reference to the uefisec_svc object which provides access to
+	 * the EFI var storage.
+	 */
+	ret = qcomtee_get_uefisec_svc_obj(uefisec_app.ctx, client_env_obj,
+					  &uefisec_svc_obj);
+	if (ret) {
+		err = -EINVAL;
+		goto err_get_uefisec_svc;
+	}
+	uefisec_app.uefisec_svc_obj = uefisec_svc_obj;
+
+	ret = efivars_register(&uefisec_app.efivars, &qcom_efivar_ops);
+	if (ret) {
+		err = ret;
+		goto err_efi_vars_reg;
+	}
+
+	/* We don't need to keep a reference to this object anymore, we only
+	 * needed it to obtain the uefisec_svc object.
+	 */
+	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
+	return 0;
+
+err_efi_vars_reg:
+	qcomtee_release_object(uefisec_app.ctx, uefisec_svc_obj);
+err_get_uefisec_svc:
+	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
+err_get_client_env:
+	tee_client_close_context(uefisec_app.ctx);
+
+	return err;
+}
+
+static void qcomtee_uefisecapp_remove(struct tee_client_device *tee_dev)
+{
+	efivars_unregister(&uefisec_app.efivars);
+	qcomtee_release_object(uefisec_app.ctx, uefisec_app.uefisec_svc_obj);
+	tee_client_close_context(uefisec_app.ctx);
+}
+
+static const struct tee_client_device_id qcomtee_uefisecapp_id_table[] = {
+	{UEFISECAPP_UUID},
+	{}
+};
+MODULE_DEVICE_TABLE(tee, qcomtee_uefisecapp_id_table);
+
+static struct tee_client_driver qcomtee_uefisecapp_driver = {
+	.id_table	= qcomtee_uefisecapp_id_table,
+	.probe		= qcomtee_uefisecapp_probe,
+	.remove		= qcomtee_uefisecapp_remove,
+	.driver		= {
+		.name		= "qcom-tee-uefisecapp",
+	},
+};
+
+module_tee_client_driver(qcomtee_uefisecapp_driver);
+
+MODULE_AUTHOR("Qualcomm");
+MODULE_DESCRIPTION("TEE client driver for Qualcomm TEE UEFI Secure App");
+MODULE_LICENSE("GPL");

-- 
2.34.1

