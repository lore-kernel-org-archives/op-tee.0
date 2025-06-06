Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB83C5B552
	for <op-tee@archiver.kernel.org>; Fri,  6 Jun 2025 02:02:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 509ED45A35
	for <op-tee@archiver.kernel.org>; Fri,  6 Jun 2025 02:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1749175335;
	bh=RosZNM45h6lNci+HzRHcl1YJXiwH57R3ufhklYa3Tf0=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=FQlj0Ll1Dnxy+QTbiYj0LZx4VqoqzMnyj3/2xilqfDU0KdqJ4BrI9AA+uydxKKnoZ
	 cHSUcgyp7DY8FQZGLdAZZvJNGgElSdAtEWY7ThDAymKyxSIZMbi3OP3Mi8EAtcBlz/
	 r6rcBFMs3ixC6dUUA72HMVEIxLJOJroqPNBxbn8bQwmyL92iM2vk7NI1nCMbm2CRqj
	 G/yxVh7CepFBEVC0pl9wyBYncYn+WIf0qbSPFzkhHdHzJDx0BEUzBAva4echWWMqGU
	 j4r6XGWddxJGMcUNEcHltXcfvI8N+5TY7gkbXKi4wET/UrtEt1/Tz+43qsDJ8UMTwm
	 hGRiFL6+LCyyg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 637C73EFC3
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Jun 2025 02:01:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bTeaM/BJ;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555DktKR027446
	for <op-tee@lists.trustedfirmware.org>; Fri, 6 Jun 2025 02:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GA1aXy5cDaO41/lAJ0ekIL
	EVrQfQeRuMYjktMOiQleQ=; b=bTeaM/BJ3+1M1WISOCryu2qJiqLdQtAm7qZK7X
	Hni00v1UvMq954f7KMa36ePlE9dR8hgPitVpJOCg4Sy2OkRrZmK8+o3WczeBVK0T
	pRkIEaBi1BIy5EJmLH/x1qi9x+gPlZ6b8Qm8upkv16BrYaHE9E/HqLwCmE7N6Dg2
	1wXSpuzg45/SnsZ2fCfty3Z5NcBHZWQHzKyYgnaUQW4Y4o99p5gG8Ax5PqzYjdt/
	BkFkz8X3/B+IZTcuyc2eh2opLTSKXo5QwQNm7F40x/mJKWhkcpg9+Ceg+Q8n9Bt1
	N6YIaoQUuzvZFKxcfd2K6q0hXk2gDIRGGKcNijtIn4hyI7+A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t344y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 06 Jun 2025 02:01:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so1344596a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Jun 2025 19:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749175310; x=1749780110;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GA1aXy5cDaO41/lAJ0ekILEVrQfQeRuMYjktMOiQleQ=;
        b=HRyNYsFoerIcYtRZdGmwQfL6hjwDCfibaljpepjAqIy+v1PjQeHuZQCHdILxZqt5VQ
         EHi9pM9zrCwPr399uBpEDFYk+CX3jd1pZbBLmjfIiIJ0PzcVPrlB+h2i/c/1WiLKz3Mb
         vuAi005G+okiTqzmoMYXX8iqAWQf0q/Y+JQqZZLpfurG7k5blzidSHsm6Ubr5AGiadyL
         5sS6GHZe214Mm3E3F7k/+P85LnrjigduF+xENzkjqem/Xhn/yBQ20VC6FRgqIkY//11G
         6rfK+IzO1dpVbq+whNlTTVRGPQ0EJXia1v93hBWQYVla1JkDw1D6sxA3LlbMoH1UG+Dk
         c/JA==
X-Forwarded-Encrypted: i=1; AJvYcCUgjTufCslFW4Vc+Ob2V4wITuHPLRvWMym84MBiRw7n2qUQNO5r8kwXlHnIqew7yTuvdm1ixX8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyNmHa9v2wx1isRSHx5HoUqoqsfj0jS4ZCHz7S77DdQk4QzjOv3
	ErqYQYXYG5sfQtwYYWCgLwUKcVyWJDAjN4adSUu1s7K1S6QterWXucBIfcZtPOhhDLIEgv1XXZF
	efINkh+xRF3rXio3iQC6q/3and4qtveqt6bI0M4ze4C7SqoJVKEY7CHICJxKkx6kJIE8jo78=
X-Gm-Gg: ASbGncsBzRvHwPJpDmGYfbITnzquIaXJ6Pjf5ByHNKePji0wVhMxq5cm1pRYZccJZe8
	aoYwr+5u6ZygdlJ38Ql1C8IE76weJ05JtTy3nZENMU4ERIbYf6cMeU7Y1FJgN4nLSTFLljm8UrK
	sKzC9lH56q3gtSrjrkSJP4iE1SXewySc5Je867UkNE+bfKBvyNW/qkDG7xEfUCrHPs1mPAn1mSA
	ijdTOkRJqV519ssPJERuLFiSNZyy4W92+Z/SviCa1U6Uz/1TJV4jxR8PPwJeCRixJa/IAqiCD4K
	Bch60qPDUB/yfKauoSoS9y80YOR+7VsgP0wmZLTfGsbPzVUO4O+O3b/Wcqz0RkUQLik3SXVJ/L5
	EwbRYNQ==
X-Received: by 2002:a17:90b:5203:b0:311:e4ff:1810 with SMTP id 98e67ed59e1d1-313472c00acmr2446800a91.3.1749175310227;
        Thu, 05 Jun 2025 19:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiF3QYisZjv7JTp29LA9QxsRKx5jqhaxgAnNO+DlelsSLtqshOhmaF22ux+jHQIShDOrKYig==
X-Received: by 2002:a17:90b:5203:b0:311:e4ff:1810 with SMTP id 98e67ed59e1d1-313472c00acmr2446754a91.3.1749175309791;
        Thu, 05 Jun 2025 19:01:49 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b128012sm288588a91.32.2025.06.05.19.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 19:01:49 -0700 (PDT)
Date: Thu, 05 Jun 2025 19:01:09 -0700
Subject: [PATCH] tee: optee: prevent use-after-free when the client exits
 before the supplicant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-fix-use-after-free-v1-1-a70d23bff248@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOVLQmgC/x2MQQ5FQBAFryK91skQg7iKWPjmNb1BepCfiLubW
 FZSVTdFmCJSl91kuDTqtiYo8oymZVxnsIbEVLrSu9pVLPrnM4JHOWAsBnArUvx88KFpKkrhbkj
 WN+2H53kBOdvBJWQAAAA=
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=RMizH5i+ c=1 sm=1 tr=0 ts=68424c0f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=BsZwT7xNq_OLigDTsxMA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAxOCBTYWx0ZWRfX0l5dB3N9JVb5
 br6i+wU83jPbGlfa9Teh/3hInu640KvwfMG6Wp5ao/Wz9YfW/gXaFo+/gGtZKcY7/3qx7AWvOMb
 HfwH5eiDuRYzqmt6ScLsXcgVDD7pgKMaTVicksHtovrdP0crq5qvIm1zkhAuS6HXfUVw7UC1Vdv
 JIb9gqCx2wWV5hR58+gb8XqpR39shitbphJPBPlTEx0RziqbA4K0EFZzZ0N8O9kIG6VJ0q7qak6
 GgAynyPLXn00A9lYsvx4Rq0wB6BVC5KToReH/MBp9gnfCAA4IZ5ltN1Hwlk2x2J3XCy7v8fymE4
 sn4zavSf/RChCu8NwrBeuVwV9I+NRVjZwa8s4zs1V94ncxnuX4P4bwWBoADkd2ZFI8mzYOH+tJs
 PSQt9BKDncjcmzKLeSq50LMHkOHbakCzkbE4/RTEcleDgYoZkpDvSesEpHZxAeJyQGuI4cIE
X-Proofpoint-GUID: zEamHz7tiM0Yllj8GGlSXIyBWtpmbpK-
X-Proofpoint-ORIG-GUID: zEamHz7tiM0Yllj8GGlSXIyBWtpmbpK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_08,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060018
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.20)[129.46.96.20:received,205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 637C73EFC3
Message-ID-Hash: J3DSULAKKURNMWLLWFJKCMFXA4UODI4L
X-Message-ID-Hash: J3DSULAKKURNMWLLWFJKCMFXA4UODI4L
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J3DSULAKKURNMWLLWFJKCMFXA4UODI4L/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Commit 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop") made the
client wait as killable so it can be interrupted during shutdown or
after a supplicant crash. This changes the original lifetime expectations:
the client task can now terminate while the supplicant is still processing
its request.

If the client exits first it removes the request from its queue and
kfree()s it, while the request ID remains in supp->idr. A subsequent
lookup on the supplicant path then dereferences freed memory, leading to
a use-after-free.

Serialise access to the request with supp->mutex:

  * Hold supp->mutex in optee_supp_recv() and optee_supp_send() while
    looking up and touching the request.
  * Let optee_supp_thrd_req() notice that the client has terminated and
    signal optee_supp_send() accordingly.

With these changes the request cannot be freed while the supplicant still
has a reference, eliminating the race.

Fixes: 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop")
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/supp.c | 114 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 37 deletions(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index d0f397c90242..62c9c75f48a6 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -9,6 +9,7 @@
 
 struct optee_supp_req {
 	struct list_head link;
+	int id;
 
 	bool in_queue;
 	u32 func;
@@ -19,6 +20,9 @@ struct optee_supp_req {
 	struct completion c;
 };
 
+/* It is temporary request used for invalid pending request in supp->idr. */
+static struct optee_supp_req invalid_req;
+
 void optee_supp_init(struct optee_supp *supp)
 {
 	memset(supp, 0, sizeof(*supp));
@@ -102,6 +106,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	mutex_lock(&supp->mutex);
 	list_add_tail(&req->link, &supp->reqs);
 	req->in_queue = true;
+	req->id = -1;
 	mutex_unlock(&supp->mutex);
 
 	/* Tell an eventual waiter there's a new request */
@@ -117,21 +122,40 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	if (wait_for_completion_killable(&req->c)) {
 		mutex_lock(&supp->mutex);
 		if (req->in_queue) {
+			/* Supplicant has not seen this request yet. */
 			list_del(&req->link);
 			req->in_queue = false;
+
+			ret = TEEC_ERROR_COMMUNICATION;
+		} else if (req->id  == -1) {
+			/*
+			 * Supplicant has processed this request. Ignore the
+			 * kill signal for now and submit the result.
+			 */
+			ret = req->ret;
+		} else {
+			/*
+			 * Supplicant is in the middle of processing this
+			 * request. Replace req with invalid_req so that the ID
+			 * remains busy, causing optee_supp_send() to fail on
+			 * the next call to supp_pop_req() with this ID.
+			 */
+			idr_replace(&supp->idr, &invalid_req, req->id);
+			ret = TEEC_ERROR_COMMUNICATION;
 		}
+
+		kfree(req);
 		mutex_unlock(&supp->mutex);
-		req->ret = TEEC_ERROR_COMMUNICATION;
+	} else {
+		ret = req->ret;
+		kfree(req);
 	}
 
-	ret = req->ret;
-	kfree(req);
-
 	return ret;
 }
 
 static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
-					      int num_params, int *id)
+					      int num_params)
 {
 	struct optee_supp_req *req;
 
@@ -153,8 +177,8 @@ static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
 		return ERR_PTR(-EINVAL);
 	}
 
-	*id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
-	if (*id < 0)
+	req->id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
+	if (req->id < 0)
 		return ERR_PTR(-ENOMEM);
 
 	list_del(&req->link);
@@ -214,7 +238,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 	struct optee *optee = tee_get_drvdata(teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req = NULL;
-	int id;
 	size_t num_meta;
 	int rc;
 
@@ -223,16 +246,45 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		return rc;
 
 	while (true) {
-		mutex_lock(&supp->mutex);
-		req = supp_pop_entry(supp, *num_params - num_meta, &id);
-		mutex_unlock(&supp->mutex);
+		scoped_guard(mutex, &supp->mutex) {
+			req = supp_pop_entry(supp, *num_params - num_meta);
+			if (!req)
+				goto wait_for_request;
 
-		if (req) {
 			if (IS_ERR(req))
 				return PTR_ERR(req);
-			break;
+
+			/*
+			 * Popped a request: process it while holding the lock,
+			 * so that optee_supp_thrd_req() doesn't pull the
+			 * request out from under us.
+			 */
+
+			if (num_meta) {
+				/*
+				 * tee-supplicant support meta parameters ->
+				 * requests can be processed asynchronously.
+				 */
+				param->attr =
+					TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT |
+					TEE_IOCTL_PARAM_ATTR_META;
+				param->u.value.a = req->id;
+				param->u.value.b = 0;
+				param->u.value.c = 0;
+			} else {
+				supp->req_id = req->id;
+			}
+
+			*func = req->func;
+			*num_params = req->num_params + num_meta;
+			memcpy(param + num_meta, req->param,
+			       sizeof(struct tee_param) * req->num_params);
 		}
 
+		/* Check for the next request in the queue. */
+		continue;
+
+wait_for_request:
 		/*
 		 * If we didn't get a request we'll block in
 		 * wait_for_completion() to avoid needless spinning.
@@ -245,27 +297,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 			return -ERESTARTSYS;
 	}
 
-	if (num_meta) {
-		/*
-		 * tee-supplicant support meta parameters -> requsts can be
-		 * processed asynchronously.
-		 */
-		param->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT |
-			      TEE_IOCTL_PARAM_ATTR_META;
-		param->u.value.a = id;
-		param->u.value.b = 0;
-		param->u.value.c = 0;
-	} else {
-		mutex_lock(&supp->mutex);
-		supp->req_id = id;
-		mutex_unlock(&supp->mutex);
-	}
-
-	*func = req->func;
-	*num_params = req->num_params + num_meta;
-	memcpy(param + num_meta, req->param,
-	       sizeof(struct tee_param) * req->num_params);
-
 	return 0;
 }
 
@@ -297,12 +328,21 @@ static struct optee_supp_req *supp_pop_req(struct optee_supp *supp,
 	if (!req)
 		return ERR_PTR(-ENOENT);
 
+	/* optee_supp_thrd_req() already returned to optee. */
+	if (req == &invalid_req) {
+		req = ERR_PTR(-ENOENT);
+		goto failed_req;
+	}
+
 	if ((num_params - nm) != req->num_params)
 		return ERR_PTR(-EINVAL);
 
+	req->id = -1;
+	*num_meta = nm;
+failed_req:
 	idr_remove(&supp->idr, id);
 	supp->req_id = -1;
-	*num_meta = nm;
+
 
 	return req;
 }
@@ -328,9 +368,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 
 	mutex_lock(&supp->mutex);
 	req = supp_pop_req(supp, num_params, param, &num_meta);
-	mutex_unlock(&supp->mutex);
-
 	if (IS_ERR(req)) {
+		mutex_unlock(&supp->mutex);
 		/* Something is wrong, let supplicant restart. */
 		return PTR_ERR(req);
 	}
@@ -358,6 +397,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 
 	/* Let the requesting thread continue */
 	complete(&req->c);
+	mutex_unlock(&supp->mutex);
 
 	return 0;
 }

---
base-commit: 3be1a7a31fbda82f3604b6c31e4f390110de1b46
change-id: 20250604-fix-use-after-free-8ff1b5d5d774

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

