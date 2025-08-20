Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9E2CA0EED
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 23:40:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E0AF24FD15
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755733213;
	bh=Yh85rlS4nql62j6YKEnNgls3TAgynSOKcaoqO7FHo1E=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=f1DNEH789emZpK2KWSQJnh3KR7H1VrCU0LmMiGfpttL4XyVEIGfiggZYUvqKdcGNr
	 X/cv2PXo+8/i4ocZ3B15MxmRuPEfA72ls7i33s+/X43DwjnPEsfdUidh5uRnmTXj6/
	 g/XAzcxqHjxHbkV+avcmIqTSkVas3PPsQttKnDC6zTn5qvcLBlkGlzyDRzRCp03A+U
	 Q2vwBlou9Upmc2YPM9Sz1kyCjE1Y9DhskW0nFDpEamSKoRWvlOMtp/XL5cNBspX9nE
	 la8gSUAYe/18hPJhXvDQsD6T4d9JGvqfq7hcvdnWxXbfmdu5Pe7oMICI774Ux0cf53
	 gWLPEq2SbLMzg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8856C42E02
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l+aSTJlp;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJkfJv029606
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=; b=l+aSTJlpcqgFB47O
	XttTZfcw5KAmMiF4b6ifSUAAqIkzDy8gWM+qyIseFIQJsuRHF3Wp+hMQig1S/1V6
	tAjEOYDFxWdMbCD6fhpE6N/02Litm6JmFE5Tg4DOHz59S5216XsvTNcmCgrUQiOD
	qulZlIwmt7shhq7fD9btxdjYnsxEwk67PwI03fWFLWSYf8e9AFCHXj/6SHxyjvyi
	JsWVHGUIz1IfVHzbj49X15EQFPPyou+F5TGsiR1TH3jtMJXtP1tGhhAwH9CbMtBE
	aBJOFdc0kw+6kgQ0zqq1qZNnmrHkHDIkTFdMgPBu9pyuMt3qzxRJJQu6Zegw1JDP
	UawdiQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528ua5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326de9344so815105a91.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 16:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733145; x=1756337945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=;
        b=IwVQL7pMLdTyO3qgN4HN5AWEhAMizjy6NxgQogMGtGaxZ90B08D4mgllO7jMyaEvFG
         dprbrKQzJUrD7H3ZkZ+mhkHr4zpR+a/yiQsDQ/Uwe5eK0cqe71cvq+JtDCLp9XYDUkR0
         oXQ4MH5+CCe6wEIwx3cYzi2xW1ZG2NYxxqmRBYkjOCupe0hg5r8JFl3JF/ZPsVn/gluJ
         Cq9QvYeBW77N+9re9RWS5pgDAboAfwcGBuZIgCrMeLmir9jlRQDs04U4IGbgu5DhA4op
         hJnfA1IFAIUhHsxWyzzkKrO2HMYjnbX9uvPZC3ZKgGOecWqTY7PGlYIQ5xbVIjmyTx4t
         UKXw==
X-Forwarded-Encrypted: i=1; AJvYcCXZxyfBy9XWsYHRB+nWQLGkts5P42gaQUw+tULDrayvDbW0xhoFgE0MtenbQKowcYNwN3ao0uA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx7TIAFSYqOLdrAPLlv9foeTKMih5Zfi7ITL9TQJk6oHTEV4K6d
	CLPGRS7VvIbmM4xT2ZxHKcr1kQaF7wEHH460iwCVZbJ+sSV8gsOwXD4syIqrsQTLm0oMw6GWaoz
	tE75fMIYMB33j+LaR/L/FuN49AX33LXS9Noz/IaugL3J54JKgqOvwULw240AQ+3HUCnXhmc8=
X-Gm-Gg: ASbGncs3ml6rbQrWpRHy4Y8XwSy6lgZqGYWoO/CNX3O+CMplEWC8xDFcD34bc57ZfOG
	bNYI1cguXaMLTAO+lG52yhrCSHxFPmPEzU1GKexjzwQJNUdTeVEjZw8Av+2XZHbExjku+BDrCvD
	94nLfzOiUkGQrifPsLGC1y/dDfLsSbPZ7HoVizlxD1G5GLG1iGkPsc92j7FcUpPIR4QKPWouwzm
	LAAKYJpImy26TdxhxRNikBemTps9wk+M+gjwRtI1lKxULqdAx/kXsVmT7jq6k5Zhfi4+rb7FQFu
	PVRBvV+B4ECgWTQU1PQsd8TY5c/GxEGgTVRBxf/g9OhqkTi4HZFxyR2YTNduh+wYvnx8cM+kF5M
	2ZIe9XnAiQs0PkecFWskp5fA=
X-Received: by 2002:a17:90b:33c5:b0:31e:7410:a4d7 with SMTP id 98e67ed59e1d1-324ed17a46amr814654a91.33.1755733144715;
        Wed, 20 Aug 2025 16:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXK18UdIY44KcNM7aaFlARIr1CMW3Y1H8zVdLrdvIntoDG55CLQtOdtAX1cQDdnrcWsR0qBw==
X-Received: by 2002:a17:90b:33c5:b0:31e:7410:a4d7 with SMTP id 98e67ed59e1d1-324ed17a46amr814631a91.33.1755733144241;
        Wed, 20 Aug 2025 16:39:04 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:03 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:38:48 -0700
Subject: [PATCH v8 01/11] tee: allow a driver to allocate a tee_device
 without a pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-1-7066680f138a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a65c9a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: bd0qsmH6fDqrfDegVZIFvGpnoTq5k8J2
X-Proofpoint-ORIG-GUID: bd0qsmH6fDqrfDegVZIFvGpnoTq5k8J2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzHQcOCacfohM
 ZPjlqw0RIDqpSTtFquM4y8wSAJFoM9/Q189YkCfEDzuqCwnSqTLtkHlUt2VxyIfusd9QPBjQOim
 g92gX/TgTgKNSOkzkuF1zrk38etnSOKwY9Dnr8/HBpMouA7A/qTX/8UEtrVuEvk0I13I1NPtG3k
 LuCW4pYkSm+ob5DU35mGEWocJrzHvkEqEVdazXTEok632TP/rjs7L4vQC2kGp+RWaixE/8uXSXm
 yxc2At89JqQlv4SHPGiiV+yJbqqbK2OrnOpjQ++HFHQm02zOpA0HjESbmUO88rXNBVBVlSYYHkb
 blXGDvERdso/9llDVvkmOmcY5ZVg03yWwMxb9BGzMPfHQM2K+yYw312ajFXB3KCu7+nF9mp9nNM
 Eo/vtwi6pwd0QMze72z1CuV8KF8iHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013
X-Rspamd-Queue-Id: 8856C42E02
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.20)[129.46.96.20:received,205.220.180.131:from];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[20];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: X36L3YMWAAP255HTGKFE6RM7F4FRPKSX
X-Message-ID-Hash: X36L3YMWAAP255HTGKFE6RM7F4FRPKSX
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X36L3YMWAAP255HTGKFE6RM7F4FRPKSX/>
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

