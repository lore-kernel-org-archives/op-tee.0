Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBF9CA0EDC
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:37:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9EF1E4FCD3
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755045477;
	bh=oYBmYKyNuJgx7AjR/DtMe3YDtEmf5yTSQmNY45/h+Mk=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ikxwNHpQBUfJMo0n8IwTl/VvvCkv7s5JJXud3X2Zx8ppCfwvnjY3gMOn97dPz5Hcx
	 yhmwub3d3DPZFr911odx2Ry5ltI2ZIXeS9u3CleJ+J3atAKoTdddAyQOEuk7x2FReM
	 ovomrooW+FH3vSKr2DwewhtAEvMZqri6s5qIxWk5j0jgu90AytgqT1vOR3tVjZ+G34
	 anH1X4R195IofP9/Ax90L2sH1i5FSDTxkZHOMjnz7ZzHMIo4sTBOyxLKlCOMFIsv7R
	 JXurRN86SGL9zRuQUTdmyUHkrqq48t0LQChMlNn2ZyrcBYfAO7aQ41S0MxecuS0J5/
	 ico2xE+r4jceA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9221742C16
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a5JbHF57;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CL7iKf032260
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aOcaZQdsCvBu0o12Lc511EeGDT2I7mkwnOLM4V2+Xso=; b=a5JbHF57vjtIG3Y+
	W9ifcik6dLYxdmud4XMvyhpXMtAJgEnVfwGGmbO0UtupfpoDEts8WtUNyKtyMU7M
	1xnLjB5lAP5sdW2bPRkFPZiEyZtjmPSfggk6B1Lv5bZIoBcgodGg19V8hsJgN3am
	0y4pxUNbeJJZDZS4DIWqA4D0MV2OCrxOX355vPVIHcyMB1dKNpiPt7xfNLBZpe0t
	40yumk4FYi8PvHDmEgDJ8khzdpJmnOVVU+OKEQb4VH8bWIPp4XpobsMotIl8tMEh
	4BKi6qJfQATmehkWHM16/CEY/kxVwkXsS7Zoqv+2idXUi6VkptW8BluOXGMqaDyt
	7qTQzA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vmtha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:02 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b42bcfe9c89so8659004a12.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 12 Aug 2025 17:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045421; x=1755650221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOcaZQdsCvBu0o12Lc511EeGDT2I7mkwnOLM4V2+Xso=;
        b=w2EJ6QvRLqgEChLtOVYs4kyVGleuOlmNXru5D0gHAb2rpPDMSM5I+LtXXuc/zQFsVz
         fMZ/uLj11bWknFs89MS8NU/pVSQM8CRYwsoxRmDqrnx7ooJCeOaAmioceEs8z5rC2GZD
         /ePBEF4e0CFxtErzig7LLAdSN0RLLZKenHC74ujxZwkYPBqtFrqJ08JrvbyyTKg/ZRMc
         IvSxHw1Z+zsr50S7Rh3Ai0q0fUYcygAchqOL2XfmeskpxA829lsbgqsf0/L1YENM9Ph5
         8CLqO/7ol59gwuMekJVrNbobxXg0fUIToVa/fNosP2xIk4vsUKGnq9RSoNlhMwRjylej
         1XpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFnD9jjidFpmpEgUpWPEMO1gnV+17w4+GmL+dNfR9t3Kl8sNPimqGHC60FPsLxSjsZsrEkMzo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzBOERc8YaKURiAijFSlxwHVEbVUmINfM24uH7qDKT+rVMIPp/m
	nab4nF7JQLmpork2SW6hRNDGGzxmrcfDmMwSZC947unVLZZo+0bYQnFMfjKpDafKkQ2PtSXC99a
	V7UiUGSQm44hhLp+5NYWuO8sCc2530FGVuXN14BWwn73ppebjd0ojyahmzTtRDxkA4RGim9Q=
X-Gm-Gg: ASbGncsH+dVeV2x6kRjh1AglOX96eXgauK4MN7cHKgPpiNkvu5HbNaOmwT9F+xIJIr8
	PAzkXLGvb3Ol1FE/X9d7w5uM0islbNMaxMznw0DdA6rJWYDPgeYllOH5aLxNBKwDR5WytVZrX6s
	b6NP5hkJQKK3FEXRv4xmgvjo1K91TSWxLTTtZavH+jGF3yYqsHqgUXZz18Z3rhhfWFuK9lc4Pq1
	nyq6TzSfCN0TYFem+7eD9xmF7Rf3HOJmIA8V26G4CAvLjCv3I+V+biSJSGK8wRlj6UJY0rgh3o0
	QyZlSfwwWxu9pMd6INKB2XbzJU/j6E5x3jgBw0b9Dq7Hfn1VMn91nmPagKJ45/ONci1ZTZPbXdB
	8hcRO8W4INA8PU03JsXZBJP0=
X-Received: by 2002:a17:903:2290:b0:243:3c4:ccaa with SMTP id d9443c01a7336-2430d0d4d45mr18426395ad.19.1755045420809;
        Tue, 12 Aug 2025 17:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF98zX42RSwWdppbMzosqG0TdHr9UoXTpkldnh54KBhgrVV7+MPU1d8WuN43VIfE3fGM3u3QA==
X-Received: by 2002:a17:903:2290:b0:243:3c4:ccaa with SMTP id d9443c01a7336-2430d0d4d45mr18426035ad.19.1755045420387;
        Tue, 12 Aug 2025 17:37:00 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:36:59 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:35:30 -0700
Subject: [PATCH v7 01/11] tee: allow a driver to allocate a tee_device
 without a pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-1-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX6yGpxM2YbCa9
 68m6R0XCqzSLVro7SRFkfLTyfbzMZkeWwP5y3SbeEBcK9gwldyx6q4S+0FlYLd5YTkRUE5ULk6o
 iaKZgi41cKUL+4WpNXcQ/VCrEJYwpUfCkEVivG/7v3/Onx0Dhp7Q75Xt99iTxgxl0LFRBaJPhsZ
 AHYACkyWhcUbozZcx05vbiOfZF3RV0whNofi3yd5zIXG2XhlZmT9fH1r82dm4l8BO3L0as3QPSq
 /6H4EBhdH3H5WuZuX8VhKf00+yTotH+ELzaaf0+AAosTOwvTeg3sxSvSILEQyr4h62LpC7fzdCF
 8HRcf/9tWbP1XQCWKTkogiJ73Lo0bNbDfSw/cYXUvVnqUn0nauyjXpQlQCEUSXI2PBpOCwnbe+r
 GQoiiVto
X-Proofpoint-GUID: 5GI6vgda_1VMcbBdN6X-lJFQiKuk_6R_
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689bde2e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 5GI6vgda_1VMcbBdN6X-lJFQiKuk_6R_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107
X-Rspamd-Queue-Id: 9221742C16
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: WLOHRYMPA3WEGALFVRYIEU2R65M3IJFN
X-Message-ID-Hash: WLOHRYMPA3WEGALFVRYIEU2R65M3IJFN
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WLOHRYMPA3WEGALFVRYIEU2R65M3IJFN/>
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
index 944f913f8592..e47a68d337b4 100644
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

