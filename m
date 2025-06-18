Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD6CC7115B
	for <op-tee@archiver.kernel.org>; Wed, 18 Jun 2025 04:27:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0F530454E2
	for <op-tee@archiver.kernel.org>; Wed, 18 Jun 2025 04:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1750220842;
	bh=Re7uJ68Ehg6FTxwG5PwASqyRnnvQuln7dCvdjpWABto=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=tAPbR70CubikAEDneoWFM4alBKoSHlozUPgjaoGnNP8CBGuGQuNfcMHyemOi6RPE3
	 zHSpJMjvcEnTxIWuenAjEfri/6+HMWbEIpTBthTbSFOSWVqcFRJCVqln6FelzlGIbI
	 rAIhUY7UeXDdDyoEqQjsLuh49i2V7tm976Z21IZVcp9zyyieeUK3n8xC5edGdN06hA
	 YwqK7i63YWmD51Evd5gjOX+s8J7+FHGAt4j/W9GNNhfRLBiwmmhvNop5Sc9A6qBPMq
	 q0ByZSW/UaC0sPxSfsY8vCdI8wuPFqXBt8+WcGRl1XXuhG5WzfaoJgtsj+hsSlzY9t
	 19d1Osxf+FFWQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8CDF13E96B
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Jun 2025 04:26:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMOaRcvp;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HMXaJj019267
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Jun 2025 04:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HYo/jTJnslty2qiYpTIGQd
	70ScyWgQWrHYTXzntSuZw=; b=cMOaRcvpLfneOBXi7/Lf5u9F/foeHEZfZEo9a9
	HC9mCxRN8HXH6OJTVRrQn1g2gRsXa+xv9JSRp/cfIcAf11Atj7tb7gYluGtBKcbu
	UslDAUwzYUH6YvKnhN3fHKpPs3xKRWU2vYgod2nZxn87LX4pv4lFg+70LM4supCb
	Es+Yp3uA54kbKj5+plq8L+87pySFAhqdlbeJsqgnxU3njR8bJ0tW8nlUK9GkK/yh
	mbAkv6eABIP9yk4BwFWlyDWEaMrgeNTqLBlHJQIHxbTo8X6BDjPTMzp6Eutgh+Fp
	UsTOU+wx2LS5m0B2IG9keHf+7ZIJpm5qvYAGEN6vR7oDQ5WA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hd2rua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Jun 2025 04:26:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-747af0bf0ebso5312507b3a.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 17 Jun 2025 21:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750220818; x=1750825618;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYo/jTJnslty2qiYpTIGQd70ScyWgQWrHYTXzntSuZw=;
        b=XNSBjgyerXzXDGh4bsUW3hoULeL7naQOuqR0cmxU86KR/DBOMz7oQo06MIJCWdfTGo
         RbFy5BdEQtdcYVGpgoAEuvqL0W0u3aydzcaYoPrj94TvNQGLnlJ8S/hN8fSgL5JiyuNZ
         ScVLZ7duvTAtn5Hz0pkTyF353l4LAmaz+y75Ybc9RTcJ7OEvG2o8vXzkqBSykLSnACGX
         CGkH/P6ogySJ6JyH9nhnpQjM6LZ1bVn3911JgqWSfVXiQTY9W9d0ljkFhX6Q5vYdMK+N
         VGz4vEwqyzQbCOIdXBZyDX/B7YGFGhevjzEEV7NZMv+tyTW4tIzHQmZfgkI6rbCu3OBn
         8ccg==
X-Forwarded-Encrypted: i=1; AJvYcCVICuql69SZQ67db515THS/pRgFQGZUR0KeRXKHxQqIwdp0m5xpMYQ1/njIAFv32WpaL8uBrUo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxr5SikF7IH/akg4mVCVz9pqqgUoChDQVq0n2YGqRqwmovskbHy
	gaWIDcm6k9+C9r7w5w0/lksYstmp8yt+/ihzgrt5rZNolY/mqZugZ10rI0FrLDwYKRFHq5SnB//
	3wsqqot0hSL5DualX+jdsF9d9UcwJWNdHTHGc2yhBKkTlyQvbvUdn6rCsmQA3Y4gbNubNXGA=
X-Gm-Gg: ASbGnctA6S91J3zqiAdmTYPtDtK04mNkbdisRhGSDBTAKcmXtqciHzis4y83oXCuuEc
	7/gjJZp7eMD1fh9CJbuajxj50mbo0UL4m4GJz63hVVHkgQ2EzoSuVV26xu44wX5fpVPv8Mr4Q+T
	qqcdBzGgZSqdUJ+GQrowxn/WZOfUx3iRJ+X1xCTveJOBON0JqAxOfmtQSkteEM2RecHvHz1reMe
	2QNe4syM75EVKtCUQ15SGepBLUdmlZoJiPLD3VSO8wOj0m/OgvWlO/wG/kNOk9fWMF5u8DbhNdr
	z5xyehjMuQJ9c8TLY93fsZLEDvn47xeB6IYvXdTt+o2PoGm2qeZAgEWG6UnonOO2TrKmCRUif/c
	z8wMzPQ==
X-Received: by 2002:a05:6a00:92a8:b0:742:a5f2:9c51 with SMTP id d2e1a72fcca58-7489cfeb010mr22046441b3a.16.1750220817488;
        Tue, 17 Jun 2025 21:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNdoo1zE+YYZvAP9uC0JrnzDCOJF8BLEa+zrc49IDdrGbi4+kZ4TzqDxfxMmnSgeKPJmqXbQ==
X-Received: by 2002:a05:6a00:92a8:b0:742:a5f2:9c51 with SMTP id d2e1a72fcca58-7489cfeb010mr22046406b3a.16.1750220816940;
        Tue, 17 Jun 2025 21:26:56 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489000749csm10252212b3a.68.2025.06.17.21.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 21:26:56 -0700 (PDT)
Date: Tue, 17 Jun 2025 21:26:22 -0700
Subject: [PATCH v2] tee: optee: prevent use-after-free when the client
 exits before the supplicant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-fix-use-after-free-v2-1-1fbfafec5917@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAO0/UmgC/22NQQ6CMBBFr0Jm7ZC2UiGuvIdhUeiMNBGqLTQaw
 t2tJO7cTPJ+/n+zQqTgKMK5WCFQctH5KYM6FNAPZroROpsZlFBanESF7F64RELDMwXkQIQNs+y
 01bauK8jDR6Dc2qXXNvPg4uzDe/+R5Df96fQ/XZIo0dTCqmPHrKrm4mMsn4u5934cy3yg3bbtA
 80QXZO7AAAA
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAzNSBTYWx0ZWRfX1WSUURF0wLAh
 jbz2iY9rRvsKRM5A8hW4bmovvz1LN5C0ydc5teUUXFLvxgq6AqGWF8xToMoqjRF+BVxwKBdLcA+
 hnVi00ElyImDIpGrr/bq9Nn42i4Q2ytOn/zdtJwkwa1nyLgn3VehCcO+zxaAhK5kofMNvV3p9bf
 +5nceFB1SqobUWVLBwD9M9PkL4SKwFjaCYALwfLspgFOv9mDPuSh+vKTufYUYEHqkk56wCHjLz1
 y2KVRYQUSfLwFrAYNx/GFG+xGUqZcm681bvpP3OIk9gtJKhGyMT7cstwIOAXEXSKbj+bP+Cy4Ub
 DvNT27rmUSP71PThb3a41SrOpG0W7SsqvkF1l1Mu1DirELeZPRn8KtJ14FdjZDLHkRsbKr2TcmP
 8TKqJXlVvG9Q7suPCPFTclD0UyhDaAU8zsIo+WlwYdYHqi2wG29O8mJgNQxfdzGhZBHtTQX0
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=68524012 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=BsZwT7xNq_OLigDTsxMA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: EkNn6fYwwCUesMX3-qDWqsJMO99Tf6YY
X-Proofpoint-GUID: EkNn6fYwwCUesMX3-qDWqsJMO99Tf6YY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180035
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8CDF13E96B
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.20)[129.46.96.20:received,205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[205.220.168.131:from];
	DNSWL_BLOCKED(0.00)[209.85.210.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
Message-ID-Hash: X5ATNESSMZEAJTAFWOCI2L7TR3F4NAT3
X-Message-ID-Hash: X5ATNESSMZEAJTAFWOCI2L7TR3F4NAT3
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X5ATNESSMZEAJTAFWOCI2L7TR3F4NAT3/>
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
Changes in v2:
- Replace the static variable with a sentinel value.
- Fix the issue with returning the popped request to the supplicant.
- Link to v1: https://lore.kernel.org/r/20250605-fix-use-after-free-v1-1-a70d23bff248@oss.qualcomm.com
---
 drivers/tee/optee/supp.c | 110 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 35 deletions(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index d0f397c90242..fa39f5f226aa 100644
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
+#define INVALID_REQ_PTR ((struct optee_supp_req *)ERR_PTR(-ENOENT))
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
 
@@ -223,16 +246,47 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
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
+			 * Process the request while holding the lock,
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
+
+			return 0;
 		}
 
+		/* Check for the next request in the queue. */
+		continue;
+
+wait_for_request:
 		/*
 		 * If we didn't get a request we'll block in
 		 * wait_for_completion() to avoid needless spinning.
@@ -245,27 +299,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
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
 
@@ -297,12 +330,19 @@ static struct optee_supp_req *supp_pop_req(struct optee_supp *supp,
 	if (!req)
 		return ERR_PTR(-ENOENT);
 
+	/* optee_supp_thrd_req() already returned to optee. */
+	if (IS_ERR(req))
+		goto failed_req;
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

