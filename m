Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B762CAC582
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:12:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 65C844FE1A
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757650369;
	bh=/lv6U+EjPMeafYia+qKbji5Tbq552Q5xbMPIUY9qAiA=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ZA8LUNcUZmrkTVfyabK8U1B8iUglpckjBCUtJlLsacxL7v2bMylcy5iECvlbPQCou
	 bfSU3cSI/ToCEtkwAFbqmCd6O7GfNSf18CwYwiqMRCQ/yXEjGvSHohjueZUIaAYYM7
	 4ecw/YF2cL4ExN+1VNwPo/+1EryXEmAsavbLLyUXuxzlNhV/OhrRNmIW5Sybn2tgd8
	 khQsEinT+Muau1ULxyfzH2Kt6Dga6qpy1S+bUhdYbBxsNjNeOCYvFb+PEXSTaq1f97
	 9K5m+ymfVuULz6Rm6iMsHubLpNN1p8nYeuw0RpdngxE24Hd2nBgTWzRotbOyenCevS
	 iO09dAU5p3U3A==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 49CCA4FDFC
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:08:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=myK/rdMl;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BJiOiM015872
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=; b=myK/rdMl99YEWJ+9
	xmp2+5NdqcR+Mu+5y0d5ntrTJX9/3MebyNDBN6k2hK86ki46zaHW748n/KtCBdeD
	E7qghvpX0ci8pjksyjhbtkX+LtEM5Gt1MZcYZtDy5JafX2Khhg7DaqXXzsANT7xe
	DivRXSpi6QsdkYn0hI3Osyenpa1JFJHDpZQHErgoOrUjSxa63457nU2i06IqMgAw
	zE/Vzu1O0sX6KCtTHFnWxXY6ji6a9apjzErEzNhHq1r1DvPPAAfNx/A/bNvvC+KY
	aF1b1ZNKfjQIJ+Y8/VfNenfusgpvFdpATG0XArnnzpTg8ooKN9Ke01LjlaSqpCEU
	fQo7aw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4ma0f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77243618babso1455248b3a.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 21:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650078; x=1758254878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=;
        b=pWuKIjWlTAwK6SWAkJy8vfSYkKFXgRCWSJsrdySDbTHcFQzYjQz7mixQMwkhfxOjs2
         CZX8Hq5gpsLPJ5a5OCAWPmkFJ5Irpvq0xXxcyXcDkGtcPJCide61VsCA8x137Sxs/jw4
         3a0nh5NHpYm6S0S9rXATQx0VjPh/cKCcrERhlFn1YNKcLG35Jm6zH73tFgCiFqHVKrvo
         iVVbBWlipa2vpaFdXPaFjgSfJsu5Ecyj/AVUpEnkcJk9rezdEL2aWWxu9Kx5sfRkU/OI
         oaPVX2OGnN4bWqSMwSoyKKKSzyX+ZkZ3HKNKL70rdw8hivYpQUjHM/HTcF9uv2HncffH
         Dgxg==
X-Forwarded-Encrypted: i=1; AJvYcCVgt75SfrN6uEOjwNGUqAoURDRb8InJnJiC7gUWm9OZtR/PfphvSyfVpAbBgFQ9GdQmytWgyFU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy/JvtlbQBCC+TRzdgCJmOctEFXqZJAUOnamllyTr2UaCZ5FWCx
	cKzADUdcgiVz1xdmta3GHYn87jem53eNTs3ZM+Uadk3ZRyRyt609ZcLGkMcNjtFlpqKVon/l8eI
	IK3wxzteLu7P//SWkV74olWw/Iptm1hWL1LgFxeOtDiUBuciAdDW63SWw03jDbXHXqC/4klo=
X-Gm-Gg: ASbGncv5RgHNByDUJ+WDg75hPiLf+sKP6YPecSvOhnGIKOM7uNwjflklZgUVytU/iDV
	OKKPpLVUWcyD2hf6WGZ6jewzvF/Ko1yiDCzxOgSgynf9uGatjyqE95S9k9vXlvLw/r9ScpZKgBi
	3JEEEQxm1vSHLqJdkd4TaVVW2GLvNQFD8U/KniNcgp33D5LPt49sCQvLhR/GxGystfTbnZxdsZT
	oi7m//TGRe0e+pdJv/tpG6CeDLMhlWE42QhzfolNreJzgXNAErrfDtP2IhR9Ceh/VFel8U6ZMqV
	6XhxIlrBiLso2uM/QQy7I6iYVbA9K2ro/XVLe1Q3XHLE6pmiqQSnj41G+/BbmCM3Fz2SU/axsbg
	JMvjHIXaSIy4Np97CZUS+qBc=
X-Received: by 2002:a05:6a21:32a7:b0:251:e4b4:7a37 with SMTP id adf61e73a8af0-2602a894843mr2108807637.19.1757650078389;
        Thu, 11 Sep 2025 21:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ46PSyhK+l4ntr3olYRusLBfLu7HsNfzRgfw3MxvnYkVZfq0w6ancyu/i44/JHqDSTmkaxg==
X-Received: by 2002:a05:6a21:32a7:b0:251:e4b4:7a37 with SMTP id adf61e73a8af0-2602a894843mr2108762637.19.1757650077930;
        Thu, 11 Sep 2025 21:07:57 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:57 -0700 (PDT)
Date: Thu, 11 Sep 2025 21:07:46 -0700
Subject: [PATCH v12 07/11] tee: increase TEE_MAX_ARG_SIZE to 4096
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-7-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXzMKWM1y2szwm
 kJ8O8dghe0dVmRBuZjMh4xTNxrUrUvqOu9THj68kEzxYLHOHOXkrcaeiXpMw9kl2Ni9Dy9nMORh
 O14CQvoxmreFBKXsQIgLMIXIQkR/bf3Je1hGk465wdXgYqdbAOSp54D/iK5bWBIiWWwUHRPhs/9
 tpPwSMIhfWC6p7YdAUBWOOY8G8hq0EP3dqS/V0S/2hs2yFdYfhrYpNQlPS7Yjh0qQpcRd/YoLoR
 E0H9EMG5WBsrV8uYJ8yET97zFx/2rIUx7q2PtE3qd2vnTw2dKgRsq2tgED3bvlwEstUJsEg58Xj
 Zdx4HB0SJHfHBFzwcqi4gVRCX0rAsUoInLC5/v/XGZ9RcL7qmKKnTJZ3hTAbvtJU6BpR6C0TsKn
 H3DkO0ul
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c39c9f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IYXVpgOwo0ubNRBPYAX7CzUCZwOGbDBh
X-Proofpoint-ORIG-GUID: IYXVpgOwo0ubNRBPYAX7CzUCZwOGbDBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038
X-Rspamd-Queue-Id: 49CCA4FDFC
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received,205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: OORCBL5UAFMHLLZHZ74UFGFL7DUZXPX5
X-Message-ID-Hash: OORCBL5UAFMHLLZHZ74UFGFL7DUZXPX5
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OORCBL5UAFMHLLZHZ74UFGFL7DUZXPX5/>
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

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 include/uapi/linux/tee.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 9abb0f299549..a5466b503bfe 100644
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

