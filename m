Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D61DCAC582
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 00:15:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DE1A44FD92
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 00:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757463354;
	bh=2jLp+9owgiqgZBOCKFldUxG3+QmUa/8reLXIFzBTr08=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=PQAjL3jU9EXNzY+R5ft5BdTEqeTKWeg/RUzDkOQPNY3cNk+3qWFrtOjaD7O5FRcfh
	 rcQLxLlz8aTshQd5eeaswlVR2Fw6kpOXkTMXBrwL4krUtbx4f2ggTQKyoh6ZoOQwQf
	 yAQZvYD1ArqVCtGEsK/zzBK0UNUGIQnj25pUrDifXVgsenEQ8o9Yug/qBAp2KAuagB
	 GusIt4vQOK7ngeAHkVqhgplwnLEWAK/M6+frLo6tq+9DlGuL0MNQc4VNWpMkUnQaMG
	 7nqBov3/pTNpq3ThmUlBgFkBYrq+5zwLMPZUfS9GXKLuNnCqvXfz1h/og8dDGZTGKb
	 m+CwNyPsNQ+Rw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C969D4FD9D
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MVwYk8PV;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589I0Mr4002266
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=; b=MVwYk8PVhFe5OTTR
	osJ8zYtkGNaKwQapy00sM8Me340JBh+tbaODTgTWBD3k0+g2v6M8QxKUtoiE2f2G
	LqaDTNrjPeN54eJcCPBBLNNqXIt+01tV6r5Z+1VwB71CTFLHCB+KzzV0N1IXrm/H
	EYI4T9qb3uK/XGZh5zGsqAF7HJ4yJc1n0Dy8Fs0Z8gKYGiyK8tZXvMoeMzg0eKsa
	Vv7AJ/1a+jc7FTS9/YlQ9L9DgGHwg6i3SlfEaX2ugoCy5zJBkIoTJpBsah2OpOam
	6PSDLOJV8BBxfSAH8qxPU+43+dFBPBxUaDwbw/CSuL5SpYXnUROzpcPOuXy49NCl
	E6A31A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg1uh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581953b8so70844835ad.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 09 Sep 2025 17:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463089; x=1758067889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=;
        b=e2RqNAQfPghbF/vy6hKkHwzRFjhbCZpsNOXxOeFK0mBH7nEOv+YNhbhlLPR/6RWF3i
         fapiD5sAOvXF6uDWCVDkDp7bszEEErYFgL6pRd1RADk1obGDd1iFDLoBhM9BZgFwDZZg
         X97z4KyyZ2wG8r3w5dNQQGoqMYKb7anPJ0pdvheeqRjG+K7wPaYZh5nnMsiqnAqBRBNR
         8soL+cH0QdxYTbldpY7nxabUh11g8MWjQMnKphy4gkPvFTnVY2QTjSKHULcslPTsNQrl
         ArbK6ohDC97a2/OayNZlb3F5f6F68OJzZg+D9dWm2p2oYGx38oLcwBf7qMhmhqfPG7bn
         rHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHGjsJ53yjI7j7TfLUa62EXyDKI4VJ/wfKOwRyd1SLa9uk1XgAz4+0bivuqpSnmXAAKCuRPBI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywl9LyNhjXgnKrWNsZ8x/au8YGttUSwyVti2jlENdrytG85CzAL
	quX4069WGNh4eUrUzDJfZOKP/XH2aGSYJWCLgYMx2FykdFzAJovKMnItJnsC7BuVcQRooZiEgA+
	ex1/TmLZdNosNKyQeMliGJ1XvUM+hQeEaXimBNU0nYt99ZtTJEX3adOkD193OsK76OkRRKd4=
X-Gm-Gg: ASbGncvAcm0E3egtC9btqk2xiFVZ50ajF6bZ1NYVwY0Ggrs1EXu0WRzmDWC3eTYgm77
	nI8WOCuDPc3mXf3LduduEekD720IUQvfwUJJ3KSI+Rm7oeLU8QC1w4nOY89lc0EafVX1RZXOkK5
	qTmzuUQHz2/Yo9xi/6o3bDlMm70Pb1qNMh53NdqkzBrZgkfPNwPWvRAOTen0v3hGHHJPK8K2Cam
	3oVdh8+eBBBIcaxTAwfpo6F+cklZ670fzRxK9NIIg2NV8LBxJRQI6HHqlm6DZgB47ewEGsk6CZp
	z5aziNrgJNp3O7NvV1ULnPNvpiKKqr1aaw4oBZQcdw/EWD4CaQpDe2xamR0L73xU9s7A4jIP0fW
	oJwmu/92X4pDaOt10ajlSofE=
X-Received: by 2002:a17:902:cf04:b0:250:1ba5:b207 with SMTP id d9443c01a7336-25175f6e7c9mr196375595ad.59.1757463088822;
        Tue, 09 Sep 2025 17:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwv4U/CQ0DLFLSD+hMaG+/IFah4m6GULCeF3UMTUtfOmP+rVq3Sj4WE3bpGNjpxi71sWc8iQ==
X-Received: by 2002:a17:902:cf04:b0:250:1ba5:b207 with SMTP id d9443c01a7336-25175f6e7c9mr196375195ad.59.1757463088335;
        Tue, 09 Sep 2025 17:11:28 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:27 -0700 (PDT)
Date: Tue, 09 Sep 2025 17:11:09 -0700
Subject: [PATCH v10 07/11] tee: increase TEE_MAX_ARG_SIZE to 4096
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-7-20b17855ef31@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Tzr6hEOTRkn9732_o2Nz1tyqtCSjdeZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX7vG+P7+AXGpL
 zl+M6/fV9WCGs7CUs9HwxKbscmTuSy0tqUNj4CjwtFgk8ty/oyBfsTFcbquoaDgvfMH10/g/U43
 yE8CwLmUD+BJR0SahOx9r6jxXIQlHlVjHBUqHHJGioICzJ+cK6iIVAPgMK4+WsCuVXS0XnbCH7t
 EKzJWLXQ3e2sx9kNG9JEvc0tBt3DhLIsfzO5r2kOTswvjAQZON5RFIHoGb0kbNabYGYQxvgOvk1
 7DLsi1r0EFmrsMrC09+AkLCyrVYAbla9khjxiqwCExsqmJEbG3KbOkUDxbENBT+Vc7Ecr/mEzHt
 rGQLzcIEAxV3S+7R3sOE9GzUf9YCKRM9HfY2pEsbYz3wiHGh6xsDaDD5UJKiA70Xf1AuZbMOonM
 3UUVmlgJ
X-Proofpoint-GUID: Tzr6hEOTRkn9732_o2Nz1tyqtCSjdeZW
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c0c231 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035
X-Rspamd-Queue-Id: C969D4FD9D
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: HE7G6TO5TYFJEFIHEXT3FD25UJLNNSAB
X-Message-ID-Hash: HE7G6TO5TYFJEFIHEXT3FD25UJLNNSAB
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HE7G6TO5TYFJEFIHEXT3FD25UJLNNSAB/>
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
index ac455683ab5b..5e393080fda1 100644
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

