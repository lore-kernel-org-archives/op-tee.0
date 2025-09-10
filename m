Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9557CA0FED
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 00:13:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 021EB4FDAD
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757463213;
	bh=Yh85rlS4nql62j6YKEnNgls3TAgynSOKcaoqO7FHo1E=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=F8bqZLsQPuazv41NDT6qJFFfS2TQfVyJLemTKfRTf1ucn2v3mZx8B04L6zMdQLhqg
	 Bw288qJ6SKMNKiLU1tF506Je0JKDQSocL/hxF4lpCBZtO3XVUyB5p01yar1WJR9TkQ
	 V9fm9zuhRSjf+KupPTzOy2NUahRS2twGTqiT179uCYKyuZXu+Yejdj7eg4QI4q2gwX
	 eqQwgnY/KFU7/BPochlsRUEx2QlohLA/P9ElL/qVF6j9c19GO/WPldPdIE6p78PbxS
	 sNcH2Gd3uNnKC8hyF2AjmnFWzaNZD/LoI1Lk1/995DffH21sehxzZpBl1gMX87WtYM
	 89tu1apHUqsCA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5B9DB4FBAE
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VCVqCmA8;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589H2Sni029320
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=; b=VCVqCmA8LvzaKotB
	Rx5VH0HyTtER9gxW8+rfTKV8Vhide5TTImYb2eJrVZybrk5g0Ab88G3L6VIbXb5p
	vE6byxfDUybcZSRxNzXYLBqqzwq0JSVTEA0+q/1hB2CGmrS4phl6XjLjKEoNOQBA
	wmkOeILxqY2ZEnYkqy25toXvVDEvOfRyAFynqSUGBzvrYUJkjHYL82IQfbgw361D
	A9f+UAImCIJE1ne1BTgRplOk8YvZ4TukxdNhW2yw7eUOLR/Ca3seStKo3TCEibkf
	xS+wvu6V5p7jMhewLGVEVmGXJuTxMiMny64/3+DdM+NI/9AghnOTPlc1eNZMiFqd
	nMhL3g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8j1kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329ccb59ef6so7158098a91.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 09 Sep 2025 17:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463081; x=1758067881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=;
        b=fKANty1q9WQ+Rq8pgQWEnmjA6BRWBSIXeDd5ni0OH2IMCG/3TTbavWRhq8KHBZALPj
         c8IDgdkg3vgwdIxHBpccB5kr7LnEDuRKp9akv0nn9z92jpQvm/kCxljPPHSp+AlAAnY/
         NpO8GRAkyZL8RFIG2zxjlkIZlSU9kz1js/knTgwxiiqS6kOi5B4cS8ZMT2HEbjw9jZmD
         jKVgartc0rnnf+fVl00ADQLWuixbR5E8F0/6jv7KEuF7/PQ+bg8YaVmBDkrwebRBkBDu
         8BUDQ74DCq7X0BHekbH5qY2H9ES5Ueo+2y3VwgcyEkVNSRmAX4bpvNxxdAkdEETl4IG0
         TFZg==
X-Forwarded-Encrypted: i=1; AJvYcCWhPhwOE/gN7gYNf1lLD+8XnapT8DRDmjpk9Z5lkIXT8F8LeVY1b2H2uHvGVI8u5k2ilmQPwaU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz9tY25mjDGaWGqjZwAOMiL4ilm26KXPciSTMBMU2lfmPorOTaT
	zsGNAXZECMudhoWyu/DhtdWNoj7vmIx0hFLaVz9jdYErik4V5GL4rP6REa4uIoszmDyQqsH7vtI
	0iha7m5Rw8aeBF5h752EF1rJOXqOHk/XWYxg55aCWvj6oip6sE9YiE8Cot1tpW/FhiOEAAgc=
X-Gm-Gg: ASbGncvGuV3/G4HPYN/hXoHZ5xww9j4N4xNv8cFyexUmujMzT9aXsqB2JJ/IZrK270X
	N+9wcqXEDHGMdRX9uK9an+l4U1Mr6xBSifnso0s5Yysl9d3iVGN0tPUQ6IrRji2/AfdgIbA7ppb
	heZQcgiZlsYWendYSREe+1Gpd0mOgABQ4CzqoaYijXurXw9oHSrUdniJYu3fQLdwXX5a+O78axg
	HJRHAVeJPqDvXFiYyIJY7rRi9qJKsWNiJf41BILQLbyDEYHPkB5i6lsIr8uO+F6j2pSX878nWww
	3Rq7oP3qxl+l/rVDRr8N7oPQ10Dm9obajhpU4aZM0E3B6cE8pXif9DuN3OTe+Y4W18RpzTg+lVI
	+7RcL/JhMTcySq7RkD6FlslE=
X-Received: by 2002:a17:90b:384a:b0:327:c417:fec with SMTP id 98e67ed59e1d1-32d43f1780amr21188037a91.15.1757463081469;
        Tue, 09 Sep 2025 17:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPpB0vwyPXFQbNkrO3QbiG84lkfE6zB7czKy4X83WNMEMJNSWAA5xUsqNEV9v/dfKVZkRwvw==
X-Received: by 2002:a17:90b:384a:b0:327:c417:fec with SMTP id 98e67ed59e1d1-32d43f1780amr21187999a91.15.1757463081017;
        Tue, 09 Sep 2025 17:11:21 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:20 -0700 (PDT)
Date: Tue, 09 Sep 2025 17:11:05 -0700
Subject: [PATCH v10 03/11] tee: allow a driver to allocate a tee_device
 without a pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-3-20b17855ef31@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX4YGVprJH+c+1
 IFoeleBSRLDTG+znfgoijqZBzDDy55NoFwcCcOAu/WQF8jZT8tR+RJ2qdKDPGwuI6vBJYeV9oD2
 rDnkYvbFQbWcs/EelWNi74OQsRkE2cMZrcWl2LYnX2V7hOCw/aESMVGkDHIZXvcjQM+HTVf2odQ
 zgzkcy2WaipVhGIyzTqhpzPKf2+S3pV0AR5yPuqtQX4PGl4kXO0FKOO7gDcAiWjMsENSz7B/zS+
 6ofPwgAjfH9ZlEY/WrQc/Eex3s/+CTlWHHpuVHT4pwRZyljwXeebh9WPsr6mWIYbVqTYhPL0Y5k
 RT0pemHUg/rV5m+CjzrN1DoQVDq7fPIyWwfoNmmMgcQIj6R/5YCnsXOiP6dBWJcPSqJG7T8hLhH
 4RnfI+2T
X-Proofpoint-ORIG-GUID: ujvgOtLDZe6tXthqiwUr9r9WOIpneY9V
X-Proofpoint-GUID: ujvgOtLDZe6tXthqiwUr9r9WOIpneY9V
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c0c22a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031
X-Rspamd-Queue-Id: 5B9DB4FBAE
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
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
Message-ID-Hash: BYSD6AKDVHRZQ4X5YLBTCJRGSYCR5NDK
X-Message-ID-Hash: BYSD6AKDVHRZQ4X5YLBTCJRGSYCR5NDK
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BYSD6AKDVHRZQ4X5YLBTCJRGSYCR5NDK/>
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
index dcd40c26a538..33091aa21be0 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -852,7 +852,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1

