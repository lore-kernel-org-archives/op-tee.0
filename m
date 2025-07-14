Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA03C83F17
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:54:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4549642FB2
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752454449;
	bh=nhZDUeOuEBpe4gtZaFsCxHLG2a7kWizgihFMSQLXv+o=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qUnRx6TJ5nTHfDe20mfsc8W1uTEj1GbPx7omiX7e7e6/PTvIZd5LYifgs9N1pl8ut
	 2uTl8VgEhkcWPHpMpL3P/ddh6Nr9gI2hzh0abmUOlhHRR7OyyOqzwbVDNLT+5oVPL5
	 Dcwc0XND+h3SIAYo9e0ymGOO4YhqVLs+svsPjduB8yN6wx3CnZEsU7jPZvzlc540Uc
	 NM4WIF/mSNsaDoCMpkAbB195hNAoIWqpF9+bkxK2JJs6tp9fLq6h7AoWv2TXdmBdHb
	 TOpxHTCUvMtqWn78vQ6yibgXVKlrlTzTirC5VoAdlwc7fHvpTpQuN2GItxZWptNa1V
	 yNthy02j/AyXA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4FA8A40ABA
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FiBFiTjo;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMdWSL026100
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=; b=FiBFiTjoRgGWwliv
	A6NRpzvOrEY2F2d1GiOU+gG2D98jldeZyZNBG22V6PrZlHFWpEl/xLQCPSRcULzO
	q0cJQxFLngWl3AwSZMCPnGNa/dyB2lt71XzCbGo/Kk4XG7jH/bHUFmn6ikqJBcsV
	y9j/g6P1dkTPEDY0Uxig5mgd2UjorcNhxy+w+Yz+A92pb4IKFcmPc4b4dVhAPcMa
	RhCmpNIj3t7qJm2/gAZtqZhyogUUhXXtStWx7Ay9TJSE5KaK/JLz5eVVIm9t0LVk
	NrqkvD/GYdR1qL/7LBW+gUho6lXnuv4YVKTAqx4lBs6xgtFsV+iAGI2eUnhFg7S9
	FKvmGg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufuejvy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2382607509fso21709575ad.3
        for <op-tee@lists.trustedfirmware.org>; Sun, 13 Jul 2025 17:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454226; x=1753059026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=;
        b=iLh7FdwL6ZBono/3D1l+MoHjSRXLZjQ4qKnHIY1d17KWkfC20sreFIpZTQ5ZQqOdjz
         XUjGKIMXVokGh9TK37NeBY4bKhhMEM1lszFwaiTwvIZ7QK/tjehXLeVNWonGA/LWB3C2
         u7rSyK3vz8+Hnvmj/tq5v748cqPRWS6BxNcX+CSdl8eWPQSnAuJV8jtU4k1q274ok+xC
         Lx66FpQI3v7LLu7IdYfNc0h8nbxnoyL2ip3/+uDR7sEjR4jva3WvHUVZ3kerplf2BSzL
         WIDB4Xu12X3FK3i/HDfqqHjrvblvNnOVgzIIM2Brmh+cbYElNVoFYmic2WzH17IAgPAD
         HWTw==
X-Forwarded-Encrypted: i=1; AJvYcCWx7vtLMQ4jjb+qqq+kxJAhUIcAm84NFn1Wphi/MIl9dhapNUU/809EBuEvtuNJuhAs+iX1B7Y=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw97u7WRmFlfZT/JOykAJKqAywP03eRLdVQL3U5FjWV3Coj7S2R
	PQ70iaMlrX5dq5/SW5QqtHWFKt3RUGwIybabA0IwxsVstSk/8eZ4kn80I2cRvC7pV3W1gtJNCZz
	ON3CirzX8ds4JSRNsC5B5A/Ibd/nqRcmTvqZ87ZzmVdXa2Uaf3niOvCGHDT5sWSeeORtPVxE=
X-Gm-Gg: ASbGncsfH96IteClrngpLOBQTUHopkKXvtIYwNTeAQ0tXDVOr0UVHYkgMpmBCJ+8/J5
	npjyu6r3Omd6g3hINVsxhsWjaFpKDNngbdPOc5vcBCX25m+uL2auCCq82afecZKZP1U185r8iDr
	A8jaIP18wFzEO6tEjHaW6lZxL9biPJpZ4Cp6/eMakGzCNo0NAnASdal5/ss0+ocTFuppZmsp2KD
	H72SwjSP0R5zd1XZ7F5a0hVuEONb8zJLwWaL2FUqsRhY55R4Atzm/VtvTgZywZKVjvt6WPvdrKn
	TfNge57UhtyvpJG+NYpxvFkH/3kjSIyM4U2gUuxO0Sujzo4EUTMKOhrzB7TZy/2GEFU5LLxYrNS
	CKaUoK1eYFwTZvk6keHvJUAI=
X-Received: by 2002:a17:902:fb4b:b0:234:a44c:18d with SMTP id d9443c01a7336-23dede4f2b0mr147211635ad.22.1752454226438;
        Sun, 13 Jul 2025 17:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSKkQ1vcVqMqiNeyFPoUR8IIMJMh4dpPpOY24o/EK6hmUwpEmfMEVSQBsWp82yDp7UsudZ3w==
X-Received: by 2002:a17:902:fb4b:b0:234:a44c:18d with SMTP id d9443c01a7336-23dede4f2b0mr147211335ad.22.1752454226033;
        Sun, 13 Jul 2025 17:50:26 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:25 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:49:17 -0700
Subject: [PATCH v6 05/12] tee: increase TEE_MAX_ARG_SIZE to 4096
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-5-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: wRkIwsRqOYfxQNIIy3FYJZz36r8Pb4qs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX/CX8NB6G/dfy
 TLBVwhkV0kLNodT11/FKEATFPTsMLXdRRXYQ576S0EKqxbj2Hgk0YTmIxFO4rJXR3gk8vzR2ieW
 CPG+6VvPwP7n6fqqN6Gia2HbUvrNtZZZd8N385B05bXYhzmvmPCUgfaDLSd0sdSpwnzSbUB5X0/
 qAcQ7vYM+G0XsLkfa1Do0oytZD9DWFpPfqbLe7YB6Nm3JcwVjoHoSK6LUnGaRsB8Bl7aTyGAV/a
 HwDjRezONu52F2QCm1gHIeLJJuLeMZGlTGcY62yn/P3eR8J4b+uNBygFX7dkgKUJGIO08/UGqAu
 opJeTj8mLxUaSZgvAgZAJwpJt0kaqF1E0GujS8IpMpzUuByp2p0nsB0l35R+yRQNfGRZDRN22tC
 S6r+CNHxWTqkEhpUjiAFTUGZigkM0+La5/MZvDGGHtWJ6Jbm4J+H+L22TNPVn793u2lqHgxE
X-Proofpoint-GUID: wRkIwsRqOYfxQNIIy3FYJZz36r8Pb4qs
X-Authority-Analysis: v=2.4 cv=TL9FS0la c=1 sm=1 tr=0 ts=68745453 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=992 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140002
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4FA8A40ABA
X-Spamd-Bar: -------
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	RBL_SENDERSCORE_REPUT_9(-1.00)[205.220.168.131:from];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
Message-ID-Hash: NJWMQNNFOLI6E57SFW4C73GUHAGGYTJI
X-Message-ID-Hash: NJWMQNNFOLI6E57SFW4C73GUHAGGYTJI
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NJWMQNNFOLI6E57SFW4C73GUHAGGYTJI/>
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

