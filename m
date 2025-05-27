Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04BAC54F30
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 07:00:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2C4AF4138E
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 07:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748329235;
	bh=E6uzMlVABYzll5NXvUBttowq1iRwQDG93U4RQisFH+E=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ji8KBbTouFlZWDyQBTddRKlCTwqDjnCMeV/eBuEGZ+h5ytykRgvq6FlmQfB21tC9N
	 FRkWMOZFrDJQgBbVGv40FiV2QEGv13ziHcPYa4tHxuwvmPqv06nNzGI84RxU8rwmYc
	 v/llHKK3pC34AW6wblsJrSaGxrhdxP00I0bWkq/WYLRPqDKxE3mCL3ATRID+OTzk4/
	 cyhVm3NwOLkuWDZ0jSgTf9hoI9L7074kCrx83lGlUeMW9oXzx2OVfWh2bv22Za0Knu
	 8s8RPKcP5pNsvJM9PNynC6SeZ4bhs4jQlwB4zXCSQvJGrKsA71tu1pPexsSg0aLkhf
	 LcrsTEhqtkCcA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5C99442F20
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uy64nr5H;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R00KmF016904
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZtC+JQtO3gxDVAYbGb6Nhx3602teWQouLuAXr4MKzq4=; b=Uy64nr5HFEFTcqsT
	qlaxzxJ/o8pIouB/jOE0FGyB4oLs45KTCP7MjA9etAg5pnC9oYEdG3Q/LWBjIel3
	WihkVx0WPJdeJRUbW/Xb943MZ69CpKk6UVoVtooWfiNbmRfF5959m19NZSJwZJ+Y
	NhLYg1MWfIlb1LVn8WuDsk5ln7fHO/LmzqKvoi03f0j6r+Co2HcJTaRtSJ6Ytb9/
	YPFRGZ0/WEZ4OwIvzlTevSmtIT6jUC07iF8FPiESt0zImaCj5ngN/SmYYx2qG1DU
	JOYMijtBnDjNFfYzmUm6V8nTNiaz0vZF1+sxZtriBoKKph4RpH3E/vVx5hlAW/30
	GjEqBw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46vmgcte6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-740774348f6so2601779b3a.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 23:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329044; x=1748933844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtC+JQtO3gxDVAYbGb6Nhx3602teWQouLuAXr4MKzq4=;
        b=nZRVG9MJSAbbfaeT8n87wA+0GsX77qztHNkEfax1DkoI7oe9n5qXpD4mijBv2ktGyh
         c6fenkUgZNDftja8L9XjPl8FgJ56WXp4p870RnhxByY+6F44C22jWUAhSkerzsmDnwYm
         Xe9iRn0DDzTQ4YTowDYsmzwX92HMvwg62jS/vyaOruMaQ1y7Vll1RRM0RR8rrWiM1VNx
         PmkxJ26AIDUcjntq0wBADoElaS0SUT0l6P8VWytKDdAhKJQ3JOJ8IK19uGYxyU49oxZc
         Ku0leTogE6keXg4VdNmr6T4riV06Ab9aOd5mQiPo7m+zR3e9hy1DjPRH3EKmyN2tAb5b
         CJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCViABRXzWd4XUMo0PVAbJyiGm3PIalDqHH2//q2xyOjRAqUqtslKK5/iDiusFYTL+cO4qjcmA0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxvrdwtgqzT/rxjsMOePD6rkyx0U6Op7lo43GziW5QoiYSMXSqp
	oIjUKC7A81aZ4yXk5u4szkDniwTQ6sNw9JzzQFIH5pNomd5EnSux5CJdFDCwo1QgyOKM9a6ZrIl
	QtAtZBPdx++PjsD7dJ5Bg54NR2WV6nqcUz7Pus9HFw/05StfjQZm6kH2f+uyeCHTi12UkeAM=
X-Gm-Gg: ASbGncsB+xJK8zVdV4FFWT+RAhWDHsmbNz8hzJYMVINE10oPcMhUmPwIB4ujSMwy7d7
	dXmeB9Ii9zLSXCxmLSrEQ4/6tVuoDOP39wqNCpGmtDDaoiEM2gualHdmak05iXC+hpr50yGkjR/
	2VNyWmlEd67sbPIb2vxU8estowzV3zVhCUOXl/LZsF3+70ZwmE5qDPYzQAzNy9rbJslDVj3aD+7
	0pnb7d6+IVzW7eUNk9EVqRXpp3p/BKsMnv7UlGYudmO2kaOe9T9EGS8B91MpswWl0x5+uiuTqRg
	Osb5qnekATSMhFxsY1x6pTPVt7+U+JoETcIs/x/7Jp2Qwpo/GqsqnXNkeOpgOAg3gUPhEtc=
X-Received: by 2002:a05:6a00:22c2:b0:740:6630:633f with SMTP id d2e1a72fcca58-745fde9e86bmr17925589b3a.8.1748329043704;
        Mon, 26 May 2025 23:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuJK0Qw8sB9Ij2uNOo2Tek3D/ke3eqsRNl8h7Kgqs57y3/v4DiAHeFdr24Fp7zbHoUEgQ4Fw==
X-Received: by 2002:a05:6a00:22c2:b0:740:6630:633f with SMTP id d2e1a72fcca58-745fde9e86bmr17925560b3a.8.1748329043282;
        Mon, 26 May 2025 23:57:23 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:22 -0700 (PDT)
Date: Mon, 26 May 2025 23:56:50 -0700
Subject: [PATCH v5 05/12] tee: increase TEE_MAX_ARG_SIZE to 4096
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-5-024e3221b0b9@oss.qualcomm.com>
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
In-Reply-To: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: 6h-2_Pxsl1_1Bu3kWG0xmV6yergCttsZ
X-Proofpoint-GUID: 6h-2_Pxsl1_1Bu3kWG0xmV6yergCttsZ
X-Authority-Analysis: v=2.4 cv=Ws4rMcfv c=1 sm=1 tr=0 ts=68356254 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=JCP0Puskdh6qvuzBaLcA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NCBTYWx0ZWRfX8LgPlPVsG1aX
 ElifFtD9fB2k3UzaRxvKy2TqokucspMW6lSbF4JioMjmzdpKdHvc3EYCE5uivJdfaC0v/c39d7I
 jhJH4oUc/YcyKfJn2rRV5cgzAk0hRMLeOr7soQFKWv7aIuqnKUT24mpE6f15OPxuHzMzi9vAA8w
 RWtDTdftLoxcFPHuWtNSVT5PxzeBAnsBx1pFhqda5kTeVlglj4T5hNfa+BDoGCmD1hW9/b89XV6
 rUxfBqmqnG8TNI8uz44aYQH2nuEhA/WXcz5r2sW7SFvWq2yC7NVRX9N+BQJNMIx9fMj7sGqLsqo
 P4Z9javMF92jBvgZVTx8yAiZ0EXJS3TCh/QdaPOB2m+qG72N5DEAQCT2lk0M6wycoMJiWBqRoNo
 PBf6NGHwNrrVZrLlmiVG0/7Y0LUAkpwZ5DAVNkp/i7L/C7Noo4jImIQEhcM7o8AJgmvZ4pG+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=954 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270054
X-Spamd-Bar: ----------
X-Spamd-Result: default: False [-10.80 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5C99442F20
Message-ID-Hash: Z7T3E63YLMWX6P3WRLJOEO3PKUA4S4JE
X-Message-ID-Hash: Z7T3E63YLMWX6P3WRLJOEO3PKUA4S4JE
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Z7T3E63YLMWX6P3WRLJOEO3PKUA4S4JE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Increase TEE_MAX_ARG_SIZE to accommodate worst-case scenarios where
additional buffer space is required to pass all arguments to TEE.
This change is necessary for upcoming support for Qualcomm TEE, which
requires a larger buffer for argument marshaling.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 include/uapi/linux/tee.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 441d97add53f..71a365afb89b 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -42,7 +42,7 @@
 #define TEE_IOC_MAGIC	0xa4
 #define TEE_IOC_BASE	0
 
-#define TEE_MAX_ARG_SIZE	1024
+#define TEE_MAX_ARG_SIZE	4096
 
 #define TEE_GEN_CAP_GP		(1 << 0)/* GlobalPlatform compliant TEE */
 #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplicant) */

-- 
2.34.1

