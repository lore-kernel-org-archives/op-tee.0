Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE06CA5FFC
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:35:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B9F7845481
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791286542;
	bh=hNGGqQh+aPxHTzj243SkQWaoT7cgLm/6qurhSVBQksY=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AEqjHQd2PzrHBgpOWM6bZPM5You8I91BZsmZzN2GARv/x90WPaUiIRX4G5cbjDT2K
	 csMlqOc7aXmB8uXX6023R16hBlyv57T+yNgjdXf3rARF23Jyx8ijndVntCpwqeI6Bj
	 J4FZ3B3zgr8v/bEs+EDM6xq4eTA9W5F4jnbpT9r2NmP/cuS2iC0kNoemYuTptsFm32
	 LDJ8/aSq5pN21a4Ek60/n0hUp+gls/dP5gDzMkRUOsaXR4A4GIf82V3e1LB54Y4Brw
	 FeEGdrsVBne9N3WaiDKbjEunRvyKQQbOe3UE2Bgdgce1b7q5Abphz6SflmRawcAOJV
	 wKs7T2/zSPp8g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9FCF145508
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 11:34:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=noJnROO1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FdOG4Hv0;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPVQE3454815
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 11:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TcPMFsWnCyAxICZPAGzWsR/xQ/fNZZK95P/3UHPpiUg=; b=noJnROO1a/5pJdtg
	SEpNNNVrLXdJrD+zEPh4tX4ED/CPeDMW/g195h7JLngzviIN9JvdspSHh8hiSxMS
	K8gBLIYQHWAnIGQ+kzT0ggUgIBwKk8/xzD928H2qHbE87+X5YaUNb83tpciIUnh/
	K/rX+lVioZ54i9WWXNhqgzzIvq6tAc72cLMlCrnt3UGYB/czJKZ0koa2to4Ms9t8
	FyWZjujfSw8WwUXHcCSCPzTOgW5hERI1q0nLUUK5WKnntaAfce0gP2tU8QvJaJQ/
	2kwNxBeKBQby4f+g1yM550DPNXDlSioeUFTqQ0STPQCYNpuWRS7MuJkvQmX3x0UG
	MfomiA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4y91g6ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 11:34:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so5174065a91.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791286456; x=1791891256; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TcPMFsWnCyAxICZPAGzWsR/xQ/fNZZK95P/3UHPpiUg=;
        b=FdOG4Hv02+QAxMvh4sVeAYV3tR9xtI7j0RWas3hCdnNUZbuQr2VMYRBcW7ZawPayet
         Nei1vEujpCiTb27ciG5CgW1rRiB8RlNJ3Odhvnhu8ANPH3xMZ8I89qKwS51kOUq3Nua2
         I7pQD270Hb4C2Kt7zl6JWfszDCkN0fD+jNiamXOhmoucAjbkoDDfYnWZeNk6cWWMs041
         U0dGc+2eKwO612lDtkiiyct2EHtvzNTA5EldNQ2f2b1L0RVa2M5/dXRZ7iOuD+TSmldE
         QT59cn6Z4dZhhbVEPtBCvX4FwilTgZVpYKBYXFTAXK6B6tLWKb78sTms55vITv4KFuWV
         kebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286456; x=1791891256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TcPMFsWnCyAxICZPAGzWsR/xQ/fNZZK95P/3UHPpiUg=;
        b=JMgfkjdsXVkWLeYZo5Tgz/Bze1NJDxcZjQ7O5A2IyPS5p6G4aTAIunzZjs1TImMjJ1
         y1kRGRaICvYY1Fh97QT/qf1+bLy17v1WNWaRfM0T+tPy0mlcRXhJ4yxIvI1+VkFgNOKN
         MtBeDUQ2ZY/8akqBGCvrERrH2iwevhOGpkJ0X/skCQyUk8JrTgwjYIrWk26YZ0IyEvoF
         1W9ePxEs/uCZdBCItgn17xGRTibAZFOtVnc28SMmfCLmUuMvZrMQw7DkF1ndq6kj1ahq
         duM/pEvZQJjTj7FGscF84GS8kjROxyhynfQJbS8LJzIizHc7Ore0yr27uciK1MqnUQt2
         NArQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdj0tFkf9fjoxXKlsYivsEEh7jVmN4oRX6b90WJWeS636drAGNRU6KwPJuj7OoWNPKA1b7Ago=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLajS04M8N/8AYNqFnX6wZUUDCWeGQqfnUzBkFtrcv6aT/B6qWr
	pqqNcYwMTtm/yD6o9q+GyYQRaH8RLp1aOU7oJ1qea4TH82Lvx+LMUoxyhd74d/1dkaWhLtVmlhR
	P9ZBQsrvq1ejF9hRk1IQLLTVHDNM5caQQG+wOwtwPnIO36yvNU9pHtJVWWyT4/TrCXpVtaueC
X-Gm-Gg: AYBFou1jzzjWEdOpWoXIWiXYSDXnQ9vcGISZwlFPt71AGfTUxc8o8/fAXuKSmMa1VBV
	jTJr+fIv7ChzsnjMl/GhpSOXm3ebbLMKnIqHpV70RGyuMEmfOqjHIZetEWpcWkpbQjXEo72MhEi
	Am2ebzoEAeTOFf2TCiRYlgp+Jrf/a4K2t8/Wjgn37JIuf9D26AOkLOUYjdKwzUgB9KwtA45p0we
	QVhqFpdFnmtPdMPJlAr5cNqokuyYHRO8kp8NUutelsw0vvfOJbdJFptADbUT++PY41CPwnCpoOj
	CwRH9hSFZQyttaB+dEG0fLQqOw2IaLpT34wztQz8yXL9yzL2h7y2tDjHKKbt0H503R5imNeqrNM
	XeqJgK9lLSI/wWQRxczk71cr/
X-Received: by 2002:a17:90b:4d88:b0:39e:6c6a:657d with SMTP id 98e67ed59e1d1-3a8737609f2mr955197a91.64.1791286455432;
        Tue, 06 Oct 2026 04:34:15 -0700 (PDT)
X-Received: by 2002:a17:90b:4d88:b0:39e:6c6a:657d with SMTP id 98e67ed59e1d1-3a8737609f2mr955145a91.64.1791286454626;
        Tue, 06 Oct 2026 04:34:14 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a709a4e80bsm9330092a91.4.2026.10.06.04.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:34:14 -0700 (PDT)
Date: Tue, 06 Oct 2026 17:03:24 +0530
Subject: [PATCH v4 3/7] tee: qcomtee: Allow object invokes from kernel
 clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-3-bf1c8e2a64ab@oss.qualcomm.com>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
In-Reply-To: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791286430; l=7501;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=vQ0glXVb8lZsQ77j/u+AmXWm85SK5TcXpfy8/NkGwe8=;
 b=EYQiTaOQBIuphTPGVwO9IYuX4aPBBKq8uWiW/+flR4UO/Vkzwz+aAaaC/bOEYb8WkVnKuF+iF
 F/N+RDTyyoZB++ly0XVB/CzVRvfRq+R3urKOTekQB/VPSVCGpeaAuIN
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX046AdBBl/57G
 FjbbCjm1KRUnKiICLgU5+2MZRo+DdLOdKrZVzrIL5hF8C8uawWstXvTZR5jbiziIUS8S1Cu+0LV
 erGPpdkD/SWhT9+0RTQZ72Yl4ycc6TU=
X-Authority-Analysis: v=2.4 cv=Ho/jiETS c=1 sm=1 tr=0 ts=6ac4dcb8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2fm1Try5a8I-Yd-RT8kA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX4beX/FLbPFjX
 Dyg3YartZmRnUe17+KQyFIR1UI9Uscy83AV5+m2V3VIwY24I6wc5v5IvpScsmxK2Uz06VgOlucA
 HC0uETfJSWME+pE0YYHkrkvk1I7hILC7z1i5eeL2xYF4IKX8LbAMrGTlajE04YuYsI1lcNbaliJ
 oRkCFKbJnHnid+lWOCBHkhVAHJy/4b/JwUKWBqNrhWYfwlp4FOW3NgELA+ZxbRa97tbOkY4PTUc
 B2nKGXegbXQZKg1AG5z+kHEU6S3v93Lz44BXWAHfuIvB356XI7MXan+3slTtas12TSJl9uQ/T4A
 kBBNccG7ptPOmsGjkSNPCbC4pD+EqBn6pSmR9dYRKq1HAKehRPCu8M+OB4dQv47i4kKLTVx6LDL
 1gbkNzE0BLJZhhL8QgFghOof0ks9ipyl05/2ZA5Pvo5nMmWWGwXQCsXdu3eGnbwoGiD83X9rNID
 IJbufR8a20SDKA8P6uw==
X-Proofpoint-ORIG-GUID: KB7Wumd3ruVJ61MV6KRu8SP0T8UvYzZk
X-Proofpoint-GUID: KB7Wumd3ruVJ61MV6KRu8SP0T8UvYzZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.216.70:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9FCF145508
X-Spamd-Bar: ------
Message-ID-Hash: EZE72IVOJ2FV72JGMDF7OLVEPFPW5YPY
X-Message-ID-Hash: EZE72IVOJ2FV72JGMDF7OLVEPFPW5YPY
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EZE72IVOJ2FV72JGMDF7OLVEPFPW5YPY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

QCOMTEE currently treats UBUF parameters as userspace addresses and
applies userspace restrictions when invoking the root object. This is
not suitable for object invocation requests issued by kernel clients.

Use the kernel_ctx flag to distinguish kernel client requests from
userspace requests. For kernel contexts, do not mark UBUF parameters as
user addresses, and allow permitted root-object operations to proceed
without applying the userspace-only checks.

This allows in-kernel users of tee_client_object_invoke_func() to issue
object invocation requests through the qcomtee backend.

Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 38 ++++++++++++++++++++++++------------
 drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
 include/linux/tee_drv.h              |  5 ++++-
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 3de54af45719..c97afaa1b4aa 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -193,7 +193,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
  * @u: QTEE arguments.
  * @params: TEE parameters.
  * @num_params: number of elements in the parameter array.
- * @ctx: context in which the conversion should happen.
+ * @oic: context to use for the current invocation.
  *
  * It assumes @u has at least @num_params + 1 entries and has been initialized
  * with %QCOMTEE_ARG_TYPE_INV as &struct qcomtee_arg.type.
@@ -202,7 +202,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
  */
 static int qcomtee_params_to_args(struct qcomtee_arg *u,
 				  struct tee_param *params, int num_params,
-				  struct tee_context *ctx)
+				  struct qcomtee_object_invoke_ctx *oic)
 {
 	int i;
 
@@ -210,8 +210,14 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
 		switch (params[i].attr) {
 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
-			u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
-			u[i].b.uaddr = params[i].u.ubuf.uaddr;
+			if (oic->kernel_ctx) {
+				u[i].flags = 0;
+				u[i].b.addr = params[i].u.ubuf.addr;
+			} else {
+				u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
+				u[i].b.uaddr = params[i].u.ubuf.uaddr;
+			}
+
 			u[i].b.size = params[i].u.ubuf.size;
 
 			if (params[i].attr ==
@@ -223,7 +229,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
 			u[i].type = QCOMTEE_ARG_TYPE_IO;
-			if (qcomtee_objref_to_arg(&u[i], &params[i], ctx))
+			if (qcomtee_objref_to_arg(&u[i], &params[i], oic->ctx))
 				goto out_failed;
 
 			break;
@@ -260,7 +266,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
  * @params: TEE parameters.
  * @u: QTEE arguments.
  * @num_params: number of elements in the parameter array.
- * @ctx: context in which the conversion should happen.
+ * @oic: context to use for the current invocation.
  *
  * @u should have already been initialized by qcomtee_params_to_args().
  * This also represents the end of a QTEE invocation that started with
@@ -270,7 +276,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
  */
 static int qcomtee_params_from_args(struct tee_param *params,
 				    struct qcomtee_arg *u, int num_params,
-				    struct tee_context *ctx)
+				    struct qcomtee_object_invoke_ctx *oic)
 {
 	int i, np;
 
@@ -288,7 +294,8 @@ static int qcomtee_params_from_args(struct tee_param *params,
 			break;
 		case QCOMTEE_ARG_TYPE_OO:
 			/* TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT */
-			if (qcomtee_objref_from_arg(&params[np], &u[np], ctx))
+			if (qcomtee_objref_from_arg(&params[np], &u[np],
+						    oic->ctx))
 				goto out_failed;
 
 			break;
@@ -304,7 +311,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
 	/* Undo qcomtee_objref_from_arg(). */
 	for (i = 0; i < np; i++) {
 		if (params[i].attr == TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT)
-			qcomtee_context_del_qtee_object(&params[i], ctx);
+			qcomtee_context_del_qtee_object(&params[i], oic->ctx);
 	}
 
 	/* Release any IO and OO objects not processed. */
@@ -357,7 +364,8 @@ static int qcomtee_params_check(struct tee_param *params, int num_params)
 }
 
 /* Check if an operation on ROOT_QCOMTEE_OBJECT from userspace is permitted. */
-static int qcomtee_root_object_check(u32 op, struct tee_param *params,
+static int qcomtee_root_object_check(struct qcomtee_object_invoke_ctx *oic,
+				     u32 op, struct tee_param *params,
 				     int num_params)
 {
 	/* Some privileged operations recognized by QTEE. */
@@ -366,6 +374,9 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
 	    op == QCOMTEE_ROOT_OP_ADCI_SHUTDOWN)
 		return -EINVAL;
 
+	if (oic->kernel_ctx)
+		return 0;
+
 	/*
 	 * QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS is to register with QTEE
 	 * by passing a credential object as input OBJREF. TEE_OBJREF_NULL as a
@@ -430,7 +441,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 	/* Get an object to invoke. */
 	if (arg->id == TEE_OBJREF_NULL) {
 		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
-		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
+		if (qcomtee_root_object_check(oic, arg->op, params,
+					      arg->num_params))
 			return -EINVAL;
 
 		object = ROOT_QCOMTEE_OBJECT;
@@ -438,7 +450,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 		return -EINVAL;
 	}
 
-	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
+	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
 	if (ret)
 		goto out;
 
@@ -456,7 +468,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
 	if (!result) {
 		/* Assume service is UNAVAIL if unable to process the result. */
-		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
+		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
 			result = QCOMTEE_MSG_ERROR_UNAVAIL;
 	} else {
 		/*
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index 5f40617361fc..d3740099fae0 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -113,8 +113,9 @@ struct qcomtee_buffer {
  * @b: address and size if the type of argument is a buffer.
  * @o: object instance if the type of argument is an object.
  *
- * &qcomtee_arg.flags only accepts %QCOMTEE_ARG_FLAGS_UADDR for now, which
- * states that &qcomtee_arg.b contains a userspace address in uaddr.
++ * If %QCOMTEE_ARG_FLAGS_UADDR is set in &qcomtee_arg.flags then it implies
++ * that &qcomtee_arg.b contains a userspace address in uaddr.
++ * Otherwise, &qcomtee_arg.b contains a kernel address in addr.
  */
 struct qcomtee_arg {
 	enum qcomtee_arg_type type;
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 369c87ad0205..367208210a32 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -83,7 +83,10 @@ struct tee_param_memref {
 };
 
 struct tee_param_ubuf {
-	void __user *uaddr;
+	union {
+		void *addr;
+		void __user *uaddr;
+	};
 	size_t size;
 };
 

-- 
2.34.1

