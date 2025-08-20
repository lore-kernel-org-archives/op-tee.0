Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0208CA0EDC
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 23:42:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1475845A9A
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 23:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755733352;
	bh=nhZDUeOuEBpe4gtZaFsCxHLG2a7kWizgihFMSQLXv+o=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=imgkMn8sTBfhVFfBpP5411sK3qtNkE9WltGAEIxLRvFeJ8/JA6lcJWjk+7mQL2RxO
	 OOaLHYrcWDbxlCrURJ4PzqrU/aV+HjsWZkORR5Q5jun5YI+81zoAiWiSsP04s2s40g
	 9BOnVVPGx8196LzmXQlgW6G5rlPrGJwDjnN7WC3yTcpFX56jF/tig0L8HdCG/FquBt
	 UaYtCJE5FpOvGPNdMhW9wovFFZCKjGnhJ6YZOKHB1BLH6OhcxqbqxEE9zlkddjhfD7
	 QrIXVEBB+MOhdjnT089Z80kMcbwJODnuW7hXVKaMgYAsjq6v6rMsIdnQHQjT8jAYv2
	 /PogqfsB/RBcg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7FD4A4308A
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PCWZUO4a;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJhxHh014392
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=; b=PCWZUO4aCsixtpoF
	ZFGaRiI/6mzDtjoEH40urxBiBbP6+XNt3WvN4/qYQsr0fqBATlGs6cJR1+romPz0
	ZSHD9uWkf8dQeqx7lef6lfm4tn/VqwZPFqnoHAr2zjvtMmN0srjxjmxQDwW1rK2M
	YfsXkmo2edya5VKqK90hmv3Ews9/uixj7AguCvnrt3k+Y9Zi+MyHZbZo+CiuS6Q2
	NwIfZ80OyNi3rOn3CnM+IOLEGoeXD5fceAWlDqohdSvOTCMo1M2Zdfg5ALM+RwKU
	zfCtSOwoEcVuUQitrXscftqWHOkiBOK6s8PZMHZiq/o3/oSRfXybseTb02YY4wBM
	aATMBg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8968c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458264c5aso3859535ad.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 16:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733151; x=1756337951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=;
        b=FiCLlS/GcvdjLXY+M7iJESzQyQyVyPv9ZVP2flOt96VN1IfubLoL9X4P8As3HXDBZr
         YnVvjbYJSK1UxjrTgi+eIB9tChu96YUkZmM4Ogj0MlykRBu/tKJsUvwBavTnVq7F+7Ut
         S8JeUWZTGkJrmQPpfUc5ObuWQe3xkXXrzjYO0QEIj9Eg6k0vhEN5qKZwCvOFCTG2Y1Gy
         uhjECY7cMaxs5WGWmId/XBjFzx3cFhsTawBGbxMv319fvrx9y8D1TjefMNPZOSxR0FS8
         euBSz9o9QkhNJwxIO4BQeeMQ+RTItO/OkSj4hs9/YZectAW/lQ1lhLPuoozYUEwGl79W
         N+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcaO9XfFD1fQD8mJqWsMnhRscKA6DA4GauB7OMccPHnDaM4ZmSNZArg0wgmPtg2b+m1ZXTlZ8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzr3OjmwWHnPBJCoenzbCpCTNfwpywBwLhzUBD0FpAO2r1uLjtl
	cYwVuFWWrltLPyolzX1Vdr2gPrD89bt4yPIF2uX4pP3/lLEB/Pw2od0evA7HPi0OJLCc4rVAS01
	eE/w/n3J0Wa3j9Mji/rqgWvHNKjKaSpF3ldLcGN3P97ekdnTiQ5IqVs4VKtqoh87U8qWk6io=
X-Gm-Gg: ASbGncutnD22FUIwXOW7EwWOXf5oeybEcssUzmn5xR178T2KUDu6nRhfoaYz+Ia8KUo
	uGT5mpkVEo4poZY/FA/QKBhp7dY+RxIf1FEkHD7PeNjCkFIMi3zHMKval8TaG5mNRD98+/tkcID
	1qRd6YTrmtA+RSy5KDrk6HwzVwo/vhLgju845MfHfj3aIaW4q2YW5hk64/RcjKqqBF//tHiNIBU
	Gv8wMSUSbn6lIh489mjzHNJUiBuKivasVfO6X5VNXgLTHUuJyeV3W6DU0gpl6L9/iPE+fAVp4UE
	ThrbR+nhTE4QlhUV9IKaEnsjzFwN9NGte0bmcljgLCA9epYU/luFn3R5zmhjYVwKiMH0d3GaNeG
	OQ8wsXNlqzi5CWvWTv/+ywjo=
X-Received: by 2002:a17:902:db0a:b0:242:c66f:9f87 with SMTP id d9443c01a7336-245ff87a0acmr5982685ad.51.1755733150830;
        Wed, 20 Aug 2025 16:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJciBVPvgUAISLnaeCIDM3TBinhx3jI5VVAs1yjKKv+IWNyYEVSSEyv5G7WBqrbl04hMo4gQ==
X-Received: by 2002:a17:902:db0a:b0:242:c66f:9f87 with SMTP id d9443c01a7336-245ff87a0acmr5982475ad.51.1755733150316;
        Wed, 20 Aug 2025 16:39:10 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:09 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:38:52 -0700
Subject: [PATCH v8 05/11] tee: increase TEE_MAX_ARG_SIZE to 4096
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-5-7066680f138a@oss.qualcomm.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfX9dp6BQLFB+df
 XbPD/wZ1JeEKs5ht1Iymr51iLmsqCiuboD5SqdVIEtCYy3YFyB8c62ItxDghuoXd+eDD9AxFCgG
 kpgA9WciJltcmkg5s8ExHIW/irwA0wkZSyhltJsAkVJQ+jiNjJC3HwAWf1Xcbx88gEs8nPUu9N7
 ae8H5HYuG5abBu7uMb+FaA6DMtGDdApS4Kz2JAtlcyL3a6XNLAWk3sb4hhQ5Eh56scIp36b9669
 vuLDbpWoGWyBc2GS3BHWsYFj5KWiG/BPjxdMtcbYPL9aSYp57B5/2p6pxrFr2tVT0ce/X8r/uP0
 9zPBx+WqrUQFKD6XVzUX/5jgFqrZDti0YFklZweyrWQz0MjeLJyOuuROK7tT8ZPvtm5JGtmpvxe
 FN2auVWdwbvbTv21Fh70O/bneWbkGQ==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a65ca0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fOnTO1ED3qHdAlZZKgWkrOr_tcuj7fTv
X-Proofpoint-ORIG-GUID: fOnTO1ED3qHdAlZZKgWkrOr_tcuj7fTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134
X-Rspamd-Queue-Id: 7FD4A4308A
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.20)[129.46.96.20:received,205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: O3QB47H3NXPVA3H4Z4XSCY5CPKMTTIEK
X-Message-ID-Hash: O3QB47H3NXPVA3H4Z4XSCY5CPKMTTIEK
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/O3QB47H3NXPVA3H4Z4XSCY5CPKMTTIEK/>
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

