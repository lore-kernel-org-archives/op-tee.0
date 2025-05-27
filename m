Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB673C54F30
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 06:58:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3DC9D42FBD
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 06:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748329102;
	bh=6ti6WK3uD8rSgx1+MJL0OTBiXFAh+a7/YuzQpoRdCak=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0JZ19gmzAyQLJzOl5nY2cI6OZd1rvS+RzysGSWwGWAhebQE2GokuyBCJKCYwAErJd
	 4Hw4w8DUYbbqi1HYHchDh3WJT2NCBDG0iV4InlnDq+PAABzgXgR2CrjhKMcx71mep+
	 jRH4mr30LTctKBig4OjRg31MZvJB8dGE/ZrThmsrtoYupxet2vD09EGB5jRsZOH8XB
	 6VfEd+WtZzT8ndT0mPlLs6qQvJEyP4czRi3QBEo73jDczlaHCAO2sd/N+5jbh12nhd
	 bP01LVqGBtWE5eXThOQ/2eKcwKvcmDmfjeyeAl3/TwJA9qZZJxyHXogbcaUvt0krXB
	 UpYCjbk5CS6LQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BC7DE3E979
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XffPuxZX;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QLhsQh008758
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=; b=XffPuxZXV5ikZ74Y
	FE0lmCxHjo5s/ON9M906LHyjYA91qSos6chagS5LD9bgRB62zl3yWYtEcImewnz/
	S4wlFc/vLAnvfOVapph/himlXO/RPYFV4xg00rsR8xX9nFAK0yA6u6jCNKdwkYbX
	Yhp7AR3r/ijo4s7UNRRWSiCTi92E1iNwcAVtTgC9k6o4fseGGBVXhggt43xCn2or
	xrg2hSAQBwBmWXkJ4SwxkLqUF51hEJ4m9k7nQ4EnhpP9vQrrKYJGaGmCASfVmume
	QaHERKsVyXxFNQVJW49QLABQFu4wlSb2Z2w4MjHj4SyBZO5RV2JVtudl5MY1K5Le
	UqcMog==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g8wwx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 06:57:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-742951722b3so2469676b3a.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 23:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329037; x=1748933837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=;
        b=rDuewZSPsjGNkoXNd6I9UhysuQb6VNkz+uhI0VvNETbcfYHk7tOsPkNOr/rXWQxVmN
         M5rC/vVq+DUK3HnJidzv3GpgLdmMMTZN+kLw3664xwzqJaYwwmE0f8By1EIDMb/YBUY8
         Pqbmc99kR2Hv7iImASvTwTnzpmFaN9UPekC+DxPDjf0plxNIw94oX/A1ATvrKBJTMVl4
         ZdAWGcgqSv33+1xDqxVKg/qH4NQhsAjdxDQ7xc0RfMMn2GpdnR3y8NIm0JQHJ5shvNHr
         jX4XJcxcGyYw+nZuc8WWrce8xVlHlUPISbc07m4A1brX8XqUzzk7zzJIVmISyL2cr3bF
         1tnw==
X-Forwarded-Encrypted: i=1; AJvYcCVsbmXJIg6WPhZP/jtQuk6JPYzp4k2CvI/7D9pMQzTeVQR+POrDYxjCWBoEx6K/P+lKF81715Y=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx5uWXdQ3CLNwjgtG9QYV3Cobsfz5VUNYP4jWUoGDSBazDxI93o
	er2FacE4wrQCILmXMy2w2UveDM9CsEFm8UxIolDMzlaMTaCu9g9caJFBQPq+sbo9L6pWg9b+D8Z
	s1tM3pVq8OKmDLXaRUooog99a6OTdM+DO0r6buNdwZu6D7C/FfnaY40n+dFlfOdoxnUqQoc8=
X-Gm-Gg: ASbGncuErazHcZgfgkCkyMLidmJfL5JdsD7LOoobFCB51JpBwm/mcd6R0kW4lcS5KvR
	Rr+zO7sMdgD37/Tg+GjkNMkm6ajdJVxem9TxUJ2QY000sMzG1Jff3o68lsYPjysgN3djCMr6e5D
	drdjIiAIiprgm91PthipwyY/Dbf0/I5hyA9EmLw8ATwflzqyKx/cYk6t0wL0kKy6pxEiAz8sZfL
	/e6lV5w3UxvJJi+aJkzvBnb0jP9uHtnlR49IKb4/Wb56eKsI2IFdo57zxVKdGLYsKSVfaq6Ep/v
	mX8Wp+7W6d6y3Se2PLVkU7MIrZe+PfIAb5evXCfb9mo0SYgOGqBKrD3lnn7NZqmbRy0I9no=
X-Received: by 2002:a05:6a00:a94:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-745fe0589e6mr14944418b3a.22.1748329036970;
        Mon, 26 May 2025 23:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuN5nvo50ha0rqfJNyLS1nF/5MRTlYqa+OqS281BYZkxySrFxKujXSx05vTLcA79D9Jnj30g==
X-Received: by 2002:a05:6a00:a94:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-745fe0589e6mr14944391b3a.22.1748329036568;
        Mon, 26 May 2025 23:57:16 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:15 -0700 (PDT)
Date: Mon, 26 May 2025 23:56:46 -0700
Subject: [PATCH v5 01/12] tee: allow a driver to allocate a tee_device
 without a pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-1-024e3221b0b9@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=6835624e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: uwLiMxNt93nNMhHLd3bpWvqaYTBREads
X-Proofpoint-GUID: uwLiMxNt93nNMhHLd3bpWvqaYTBREads
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NCBTYWx0ZWRfX0hWs0lQ1Smvj
 qsBFvTyOAOkcMuIz9vZnXDfjAVckjQheGqqSf0rxtSm9TsiAH2XDDBO3RgALalVpCEdsplnm+VK
 HAENe3umJ3u55NIFuhxZNzNKTL0J6N8R+mqxocGWWGPhaUOIr5ETJM0TPuNAdr0RZT7ccYAB43G
 WNjxs6Gs/kVKviHZpsIKefJMjCBJTrtWPqoksl75zi4pmTkKrkDZnxbnQtf4KN1fELLO0kiuuoN
 R7ltvKXo1ImRDa8vr5RZirSzJ6VkgsVjF/zHUf46tZ4vJodmrokt5848d2JQiQy3YgV9a+xI0nb
 a0+ng9bDQpLEWkHFj2hxQKxVyF9eG64+/cBqHFVe3pWHnQXM73e+3+8zdFWqIdvFu6YS7qIQiK8
 XtB/DFSrUDF1YgKyzGgKPkUzSiD6su2EoUqg30rx3hLissuNoz+BQogM8SYye84wYcWRNf4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270054
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BC7DE3E979
Message-ID-Hash: RSQ4ADF5G6NN435RONV5UB5QRN5R3EII
X-Message-ID-Hash: RSQ4ADF5G6NN435RONV5UB5QRN5R3EII
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RSQ4ADF5G6NN435RONV5UB5QRN5R3EII/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index acc7998758ad..133447f25065 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -889,7 +889,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1

