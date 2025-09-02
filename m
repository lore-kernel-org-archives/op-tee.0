Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F62CA0FFE
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 04:59:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E228B4FD6F
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 04:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756789180;
	bh=2jLp+9owgiqgZBOCKFldUxG3+QmUa/8reLXIFzBTr08=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=VPu41N0z+HyewdPGnPdbPJV8ETkFP4e7BpqBEQH0xa98E4gPiNEcEaQN9kn0wSXdf
	 WnOJBCg6Q5QA+NZ4P4SjotjJUH77tuoJXWaf0y9i6d70BrFI/n5QR0R3eL0NGiHKik
	 klvoQqHoiuYtrLmy/a2s8lSZQGQDlPDg9Wf++xrZBrTUwaOfFg03uESbrUM+jPNW2y
	 MxThSRSWl5XudOd6eJt67KqI+MwCu9Gj1aBIqvhoJc1qAA3vMD7JZpyANm2cFgJctS
	 8n/+3/HMHOlyhihno+I22iqSNrp4RQwjslc8gj4WWDS3dwM6RXiKm6ykvhXZ/qYj2B
	 HriRaye4X9TGg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C9CF64FD3F
	for <op-tee@lists.trustedfirmware.org>; Tue,  2 Sep 2025 04:56:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iU93sRdK;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S57r010330
	for <op-tee@lists.trustedfirmware.org>; Tue, 2 Sep 2025 04:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=; b=iU93sRdKWl3pXPjk
	CJm3C1+MEZAjvpK2QCNBTrxyaoU8Dhm6LI8yXVNG07wdFhUQ+ksbZt3/Zf7NxRK6
	a5cbhGIxEEh+Tv8SPxrURN+2jGmdO/stF+UUlE4bEdYO47qgwQ3q7ycSXF+Nr9Nn
	v/CMBo4e1KGkQds1Q+1pNR7W6n+hTt7TLGOjv8GMg9eQe6F90QFWkgmx09pd/HyH
	3mteK7EK7DSm2rE69rebLfyl+0iyWeC0GSLldtq0zEmRxug2+HK9dalUeHEomiNf
	/guNOzY6Juhf/kGHVY30dyPqkKaZtx3/0TYu0TIaf4kCg+otGg+FKFq3ju84LdS/
	rC3g0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjehpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 02 Sep 2025 04:56:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2490768ee5fso31243715ad.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 01 Sep 2025 21:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788979; x=1757393779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=;
        b=LOAlsyBczr4Hu2bX2nmtkLZ+H+mI9HVZLiivYAiuEO0nsq7BLrk3zITA4K6LPtMDWY
         EV7wJ78OyB7RTtuIfteU+CjW0OsYluVcF5y+IRpdyI9aaR3518cKaIZfP1BVs0n/dpMm
         twYNzr7THsUaC3NWynpJV+gu7Zf4jUYLd/ebSN1wPs9ruXCAAsvWYxpi3bT9LjA2YbBj
         UtxNi1221SLufxyarQ65EH3xZ6c1UmPQLHXTgFrEBybTN6VAphcpnuY8TojpeqF3DqeV
         dCQAnF6EO5jw7+cCW8N/wwvhlcC0nTqDhbVjCJAGbGNbhVEm+msy7LrR4OIPvk0Pe+oO
         ZWuA==
X-Forwarded-Encrypted: i=1; AJvYcCX0WRqvjUKDBD9YsKt6WMtz2vS5MPUpxtsyLVh9tzyTtsxHwllKIad6EKFt71xKQdxIRtqc5NE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzDCkqeNYSCP9o88haDEVQj3AvE7BIFsfvdc/kcBNqa8IjFAYOP
	STTAJZudIMn3cdadz4q9iLxocKiDlHA8EOONJ6x7CrIuYCm5ndm6KzdvWJfL9OIXgwK3QaS5/XM
	H/w2MH2AElIJ+HENJQiynroOWNele1BhOTeRPuTNqZ8U+3SV3CW23DpYSoAYk0T0Jxt81tgk=
X-Gm-Gg: ASbGncsbJOknBwt/7Shw0GOQyRoMSOOkrraokhaCXQL6h+wa9T18B3TDExYLzbQMBqQ
	JtC/KkcMUbnv200kRpyB87ehjeTdDNv6nsDIxo8JTgFJ2ogUVdSpjnP/O874XzBxOdyO6ZEQ7zP
	hyBP/yOy2KTQdj4JBrBJyEmRJYKyMnx7DqCrg6nkUqgqDeKj7Zu+e/WUdv+8K/w2zy+RSTCGXpK
	63A13S+ThYY9NyzbW7McAllIIiak/XT0GGOu/zkcmBfHZPpwtnE6y5/OFYVG1rZItKlFShA7sf9
	w6YVr5kWBkAp3MGRKRNqArkZDjBWxVkklxlw2q46P3pK8/saUYXC/d9w1RPim7Wte64y6rzOaYX
	oIl0xkgtVpyj6p67CCyyt7VA=
X-Received: by 2002:a17:903:ac8:b0:240:52c8:2552 with SMTP id d9443c01a7336-24944ae192cmr136873405ad.43.1756788978970;
        Mon, 01 Sep 2025 21:56:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjejh0uViNDEvhTaWcq9bv3V5Y7jPhdE44Q6k9Ox7H8xWnNvjCjQCM5Z2Mqif5+n1s8qZOHw==
X-Received: by 2002:a17:903:ac8:b0:240:52c8:2552 with SMTP id d9443c01a7336-24944ae192cmr136872895ad.43.1756788978349;
        Mon, 01 Sep 2025 21:56:18 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:17 -0700 (PDT)
Date: Mon, 01 Sep 2025 21:55:52 -0700
Subject: [PATCH v9 05/11] tee: increase TEE_MAX_ARG_SIZE to 4096
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-5-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b678f4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Hm0ERcfMCEHyXJTPKpaTl70GlLjU_iC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXwK3IWfl/nkBg
 qdqYFXYI08VaigFsjIudOZkRuT6022oJaaRWy6DFhYHw+bf1+/ZXQqCq5rKLtFn6A1HVtcPONWq
 Xt9ggVzkhogLAALQK4b3WfvXGZ9ZdLjeeAm2TGncWsrZEb6HmjEdAiygfr8Q5jICK3gSDr4ki0t
 BDloCNQhCXy6GYzgoGq9BxEQF3U5y/4jI1aOFXCkcBKq4X8BE9aiRmzLg5IXyief9GmEZISgQGD
 olIg+75lTdst8tDYiPlnqa+rmRVsesRB/y5rjVY7Kazy8wlw0LQE5lpdlMvGOZj27NSceMzAtS3
 QQPnqXqkcXNRXD5sqcb2es7wDawsnKNDlYfqzER0s0v6wcdbzI2wvWYWlZApYRuG4X2eIquaa4G
 RB2GQHTp
X-Proofpoint-ORIG-GUID: Hm0ERcfMCEHyXJTPKpaTl70GlLjU_iC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024
X-Rspamd-Queue-Id: C9CF64FD3F
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.20)[129.46.96.20:received,205.220.180.131:from];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: IUQREEYL54XLW4ZWQBLON3S23G3FSZEL
X-Message-ID-Hash: IUQREEYL54XLW4ZWQBLON3S23G3FSZEL
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IUQREEYL54XLW4ZWQBLON3S23G3FSZEL/>
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

