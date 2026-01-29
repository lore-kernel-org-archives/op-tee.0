Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2606ED46C01
	for <op-tee@archiver.kernel.org>; Thu, 29 Jan 2026 03:22:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 58B8243299
	for <op-tee@archiver.kernel.org>; Thu, 29 Jan 2026 03:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1769656976;
	bh=K6xHAGvgu/oTkp0qkaSIMKOft3xeCJMfJ9YElrFUBq4=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=FXZ0wLfLWBCjOqeealcoB4k5sX3a6lm0QaItfmOkhCMVSzwp/aVEGF35QfstclBku
	 HNk0U19DJQVFs2soZBgWVUZUGkILgKMCir9s/rkgfOXUXCavD9figYFg11K4d2boQr
	 HqXNDRO1Lwaa9IlWIbB6hZIBOWOPnBg9NYAvk0jG8Eb65Ia8qvHJ333WDSTd8Ljpoo
	 IXv2Oz1cg13x0hS5SuBc1ttUwNQo23d1vJophvo3IBikYqAr1A6YhabuukjhpoxM0M
	 ArQZC5uD2wYijyUEw9c1s6RyL2ubvA1XBpdF8kpDHOmTQTNdpvptY2vtkUEvuXSxjy
	 iEWbQEflm5J3w==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9E96841B55
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Jan 2026 03:22:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k+Ms+3GB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kwzReJCj;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2oxOJ2034140
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Jan 2026 03:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EGC6VyU3/KJZdVzczXkLfj
	sqQ9gqC5V6TvXxA7UoqKY=; b=k+Ms+3GBUaK4qeBkSHi9DxqKaczhPGv5bivkP6
	vP6Le9UXyd0vYPLigYwNWB3V5X4mI93nJb+h/Uy8CX6wHl2Ccm/wBqBqYj5HAqTU
	XO1wRMXy2wR8aDhMlgUDeVSEY46IQziGkhFUwbYppj1ycSZygckeFaA8q3KVeg/5
	wlIY1LI9avvtC6w0/6VmKsKjH4LJpJr22iWJLd9m3nHr7XcPIgE7g9kZcNhHcK+F
	QjEk2Ysg82p0Vzhmhxf6ITlMqPKa+C0fj0r5kxSZ0cH1uWL285DnfzUR7AVb+th5
	/8mwkIybMsT5/6czEz8jX2HFUZIFzDLZZXiJMMoiJCH8KjoQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byna7j0r1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Jan 2026 03:22:35 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-124aa710af7so3399109c88.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 28 Jan 2026 19:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769656955; x=1770261755; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EGC6VyU3/KJZdVzczXkLfjsqQ9gqC5V6TvXxA7UoqKY=;
        b=kwzReJCjkEPuBljne4d7pmPdu8NkWwB8hYpF0EklUEOuKQEVKXxE1xUDA18TcwF40r
         TmnGBY0cvGnZ2045XuDFsBLt9fSLmXN6AF4WIbC74QGYZQdhShWlSuOaGqXqIDX9v9VL
         7hnUTvPY0CB3P7coo0DD7IhBRlMCyKTtual/Jq5kq8mAyjZhVIaH7iQtDkHGCzxZMMMw
         KR1B5Ia3L2yw+9IMbC7ndIQ/1A99L7eHKyeq5cNggw8Z83vXYE/58MB10c6eKTQr1/lb
         RMPgjV3U1Y29tFPJd/CYw3yhxk0n4H52omo+D/o0rrl/hh06va+tkQMpZQE0b6mOtYEG
         KZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769656955; x=1770261755;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGC6VyU3/KJZdVzczXkLfjsqQ9gqC5V6TvXxA7UoqKY=;
        b=HZ2Ss9Ib6RFTQNbK9FcSakJh43fcPq+J/DDqmrCAuYBIt2qUqolGtwY5N2ixz8OpEC
         +6OAip2DkmjXOvJyoAPbY1/APlhIc3ubjTxBVQkk/LI2J2JUii30aTJNaRt8RNP1t1zp
         X6aguyxcIpm4O9zgEMQojQs9TOKFbncGpkDHJxsxtpu1fuPKSSEMD8pl8IRyCWlY1MbB
         0kshVAKwboNgEYPBChKmyjkBiaJhx8fv00fXJ9QkaAe0VBSoB+fdcUnIlcbrpWulheQd
         Cg1FIo7NybdNk/TgfBHwFgMype+NZCPewl4pMgZAclG5J6NiFD9JwS7Wd9sxixh2jnWo
         rZZA==
X-Forwarded-Encrypted: i=1; AJvYcCXHebDGgykXqpMK+uvt5QPsogkFkv1lsCUvb4ZQIDUPaAyWJEXeLvsaUdGXIcZlyamwXM71QFU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyTZzGC7BYeZjBIV8zm1DMKrfcoz8FV0KRx+d/oVs3VkY4HKE71
	njpiMeX1s2fXO+DCXnGV+oY9jJKGy5YxGXlY9T04IDQSYXHPIVESp24aLvuBmnF4osIx/W19mPd
	q8I2VIXv8/rLdzxJZx/Aqba/XN877M/pACjHxFeFVhiHWxCyIhuotIQwTEjbtYLvF89AasAI=
X-Gm-Gg: AZuq6aKbpUqE92/yf7XHviRDD0hmwQ1GsoYkO0yRKnZPXkPaK6qpYhRLKiqJXK05hZv
	fAWcwHh9oLE2PQe1AiDCHfAXeh2OgK1t2I0Tiqdg0VvEm0nb5aQ340Lu8bYllfeIG7TXb4E8iMQ
	YmcPC+tQ7is9z5DXeZiofwDvlZGAPWEHe0qiopXarFx8NHP667iEzj4LSO/sQRZ20GzOU7QzxS/
	XyHJyaQsT8Dqy/0qRNSFOMjK7/Oezf4FLHBrY12zn65Ov5L9+0yBBOpEYAQeELrDHImic5tuGKk
	Bg0j2RPXbaZWgyuTV2cigAvVdItr199I3i1JKKs9nz1w0QHCfHYIfQ04+bjYCUgGvttc7Z0ycQH
	8TO181lNrvlMzWfFEaVQct1rPoX6SMDp70Ou2JD6/EjrVvYpwwzdVGiHMUYAeSSMnI/sG
X-Received: by 2002:a05:7022:41a7:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-124a00aeb09mr3570775c88.28.1769656954845;
        Wed, 28 Jan 2026 19:22:34 -0800 (PST)
X-Received: by 2002:a05:7022:41a7:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-124a00aeb09mr3570755c88.28.1769656954128;
        Wed, 28 Jan 2026 19:22:34 -0800 (PST)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efd3b8sm4740532c88.17.2026.01.28.19.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 19:22:33 -0800 (PST)
Date: Wed, 28 Jan 2026 19:22:20 -0800
Subject: [PATCH v3] tee: optee: prevent use-after-free when the client
 exits before the supplicant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-fix-use-after-free-v3-1-b0786670d927@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGvSemkC/23NwQ6CMAwG4FchO1vCBnPoyfcwHgZrZYkw3WDRE
 N7dQWLigUuTv/n7dWYBvcXAztnMPEYbrBtSKA8Zazs93BGsSZmJQsjiWFRA9g1TQNA0ogfyiFA
 T8UYaaZSqWDp8ekytDb3eUu5sGJ3/bD8iX7c/Tu5xkQMHrQojyoZIVPXFhZC/Jv1oXd/nabBVj
 eJP4mpXEkni1JAmbOWJqx1pWZYvLNZWAgUBAAA=
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: JkSIbNRjqEXt807BqYFadp5oyIgjxyvh
X-Authority-Analysis: v=2.4 cv=J72nLQnS c=1 sm=1 tr=0 ts=697ad27c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6MCoFBzevOMPZS9IYwYA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: JkSIbNRjqEXt807BqYFadp5oyIgjxyvh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAxOSBTYWx0ZWRfX77fVbBODkdeB
 iuM7JgqB3N70ALEu/rE53U3w2+ubT3yU43rHSjyq+KWa2YxWJT5jmIrcESi0BV8Jiorigy4v+9Z
 uEKKE5B1d2v7BSKCCesUl1boIDw7jUQCfEX4qDRartQMT07CshsrOUECUlp7U8VMU/z702+JBA0
 TaWQkl7XV6fMaQIrcFhG5WoojBskLKjbjBLD3XPyE7b/5bB4LGj4fi7YsIR7ldWrqPtzzUkwdKz
 A/YeZBv/h0aDBVX4LGAazCF9Qdbj0khUuhdtE+3Cp0x+Di2ArmkXv40QYTLspjvWOBySS5dxCXk
 bH9ZMoZHnWMhkv3kDVqcP2IZwZ+WrFwkHVLOSDU5jhp1a8LePUkggr+J0IJXzEWZqIHAyuz4V96
 9uu9RojEYhoNc/iDgH+sd0533ErCraghFrR56Ob+ISP3BGbAjY5Fq1gpZKvW03SvSBpc2pQwDMi
 pbN4PDQd7o9VgQ7I72g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290019
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.69:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9E96841B55
X-Spamd-Bar: ------
Message-ID-Hash: CB6XTY7OARKCLHJDO75RDMIUEJJ3RF7N
X-Message-ID-Hash: CB6XTY7OARKCLHJDO75RDMIUEJJ3RF7N
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Michael Wu <michael@allwinnertech.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CB6XTY7OARKCLHJDO75RDMIUEJJ3RF7N/>
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
Changes in v3:
- Introduce processed flag instead of -1 for req->id.
- Update optee_supp_release() as reported by Michael Wu.
- Use mutex instead of guard.
- Link to v2: https://lore.kernel.org/r/20250617-fix-use-after-free-v2-1-1fbfafec5917@oss.qualcomm.com

Changes in v2:
- Replace the static variable with a sentinel value.
- Fix the issue with returning the popped request to the supplicant.
- Link to v1: https://lore.kernel.org/r/20250605-fix-use-after-free-v1-1-a70d23bff248@oss.qualcomm.com
---
 drivers/tee/optee/supp.c | 122 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 36 deletions(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index d0f397c90242..0ec66008df19 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -10,7 +10,11 @@
 struct optee_supp_req {
 	struct list_head link;
 
+	int id;
+
 	bool in_queue;
+	bool processed;
+
 	u32 func;
 	u32 ret;
 	size_t num_params;
@@ -19,6 +23,9 @@ struct optee_supp_req {
 	struct completion c;
 };
 
+/* It is temporary request used for invalid pending request in supp->idr. */
+#define INVALID_REQ_PTR ((struct optee_supp_req *)ERR_PTR(-ENOENT))
+
 void optee_supp_init(struct optee_supp *supp)
 {
 	memset(supp, 0, sizeof(*supp));
@@ -46,6 +53,10 @@ void optee_supp_release(struct optee_supp *supp)
 	/* Abort all request retrieved by supplicant */
 	idr_for_each_entry(&supp->idr, req, id) {
 		idr_remove(&supp->idr, id);
+		/* Skip if request was already marked invalid */
+		if (IS_ERR(req))
+			continue;
+
 		req->ret = TEEC_ERROR_COMMUNICATION;
 		complete(&req->c);
 	}
@@ -102,6 +113,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	mutex_lock(&supp->mutex);
 	list_add_tail(&req->link, &supp->reqs);
 	req->in_queue = true;
+	req->processed = false;
 	mutex_unlock(&supp->mutex);
 
 	/* Tell an eventual waiter there's a new request */
@@ -117,21 +129,40 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	if (wait_for_completion_killable(&req->c)) {
 		mutex_lock(&supp->mutex);
 		if (req->in_queue) {
+			/* Supplicant has not seen this request yet. */
 			list_del(&req->link);
 			req->in_queue = false;
+
+			ret = TEEC_ERROR_COMMUNICATION;
+		} else if (req->processed) {
+			/*
+			 * Supplicant has processed this request. Ignore the
+			 * kill signal for now and submit the result.
+			 */
+			ret = req->ret;
+		} else {
+			/*
+			 * Supplicant is in the middle of processing this
+			 * request. Replace req with INVALID_REQ_PTR so that
+			 * the ID remains busy, causing optee_supp_send() to
+			 * fail on the next call to supp_pop_req() with this ID.
+			 */
+			idr_replace(&supp->idr, INVALID_REQ_PTR, req->id);
+			ret = TEEC_ERROR_COMMUNICATION;
 		}
+
 		mutex_unlock(&supp->mutex);
-		req->ret = TEEC_ERROR_COMMUNICATION;
+	} else {
+		ret = req->ret;
 	}
 
-	ret = req->ret;
 	kfree(req);
 
 	return ret;
 }
 
 static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
-					      int num_params, int *id)
+					      int num_params)
 {
 	struct optee_supp_req *req;
 
@@ -153,8 +184,8 @@ static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
 		return ERR_PTR(-EINVAL);
 	}
 
-	*id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
-	if (*id < 0)
+	req->id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
+	if (req->id < 0)
 		return ERR_PTR(-ENOMEM);
 
 	list_del(&req->link);
@@ -214,7 +245,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 	struct optee *optee = tee_get_drvdata(teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req = NULL;
-	int id;
 	size_t num_meta;
 	int rc;
 
@@ -224,15 +254,48 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 
 	while (true) {
 		mutex_lock(&supp->mutex);
-		req = supp_pop_entry(supp, *num_params - num_meta, &id);
-		mutex_unlock(&supp->mutex);
 
-		if (req) {
-			if (IS_ERR(req))
-				return PTR_ERR(req);
-			break;
+		req = supp_pop_entry(supp, *num_params - num_meta);
+		if (!req) {
+			mutex_unlock(&supp->mutex);
+			goto wait_for_request;
+		}
+
+		if (IS_ERR(req)) {
+			rc = PTR_ERR(req);
+			mutex_unlock(&supp->mutex);
+
+			return rc;
 		}
 
+		/*
+		 * Process the request while holding the lock, so that
+		 * optee_supp_thrd_req() doesn't pull the request from under us.
+		 */
+
+		if (num_meta) {
+			/*
+			 * tee-supplicant support meta parameters ->
+			 * requests can be processed asynchronously.
+			 */
+			param->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT |
+				      TEE_IOCTL_PARAM_ATTR_META;
+			param->u.value.a = req->id;
+			param->u.value.b = 0;
+			param->u.value.c = 0;
+		} else {
+			supp->req_id = req->id;
+		}
+
+		*func = req->func;
+		*num_params = req->num_params + num_meta;
+		memcpy(param + num_meta, req->param,
+		       sizeof(struct tee_param) * req->num_params);
+
+		mutex_unlock(&supp->mutex);
+		return 0;
+
+wait_for_request:
 		/*
 		 * If we didn't get a request we'll block in
 		 * wait_for_completion() to avoid needless spinning.
@@ -243,29 +306,10 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		 */
 		if (wait_for_completion_interruptible(&supp->reqs_c))
 			return -ERESTARTSYS;
-	}
 
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
+		/* Check for the next request in the queue. */
 	}
 
-	*func = req->func;
-	*num_params = req->num_params + num_meta;
-	memcpy(param + num_meta, req->param,
-	       sizeof(struct tee_param) * req->num_params);
-
 	return 0;
 }
 
@@ -297,12 +341,18 @@ static struct optee_supp_req *supp_pop_req(struct optee_supp *supp,
 	if (!req)
 		return ERR_PTR(-ENOENT);
 
+	/* optee_supp_thrd_req() already returned to optee. */
+	if (IS_ERR(req))
+		goto failed_req;
+
 	if ((num_params - nm) != req->num_params)
 		return ERR_PTR(-EINVAL);
 
+	*num_meta = nm;
+failed_req:
 	idr_remove(&supp->idr, id);
 	supp->req_id = -1;
-	*num_meta = nm;
+
 
 	return req;
 }
@@ -328,9 +378,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 
 	mutex_lock(&supp->mutex);
 	req = supp_pop_req(supp, num_params, param, &num_meta);
-	mutex_unlock(&supp->mutex);
-
 	if (IS_ERR(req)) {
+		mutex_unlock(&supp->mutex);
 		/* Something is wrong, let supplicant restart. */
 		return PTR_ERR(req);
 	}
@@ -355,9 +404,10 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 		}
 	}
 	req->ret = ret;
-
+	req->processed = true;
 	/* Let the requesting thread continue */
 	complete(&req->c);
+	mutex_unlock(&supp->mutex);
 
 	return 0;
 }

---
base-commit: 3f24e4edcd1b8981c6b448ea2680726dedd87279
change-id: 20250604-fix-use-after-free-8ff1b5d5d774

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

