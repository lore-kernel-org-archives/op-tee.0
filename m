Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5455DC4451C
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:00:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 77F5443AAA
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784703611;
	bh=Uq74hKAscOJpoTlWbeJLC+5TbwItuETl2mqfiOIyB/o=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=L7JqUBygE9A1f+Et5BK8OdRKh4IbtpIN9BmoIusZ3dVUVkot2CUR9VOkFTBvP4x7A
	 K9ecoER2GF+bamk3xPANtmomALGSW1eNSRPrHqI7kuv5GQetupbSNboyBNjlm3qRpT
	 8s2crt8anQsGJycD3kQkLKXLUwum6NF0zF4/wo939LqtaGNe35BM+S3SwUFVR488R0
	 Pw2OblnJx0aF2LPgz6kOt5ouTZaZ55RZ1YIgP17nE7A9EAHoaQLhlvf+u9jBp7uIMi
	 xYwfwG95pn83ahEStM9J8WD5S3L8eykFJ1ohOAeearqQgBPGoGuevzJ3vTtc5IwWCf
	 Y5gtEtSXeKrOg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 191DF450DE
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K+M0kxUY;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dT6yOS3L;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53fag4027277
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	saoDSDdEuqFBR3Jg2F/u3iejFckYCh1dzz5cbtTO9NU=; b=K+M0kxUYU0m3W+AF
	bXsV/ySbeQfAVDHn9IzibpPhNyrPlopAQnguasY9QOag13ySP129KQMX0UKv2iF4
	hY+u+mgDsH1b2OxubxfRjtOatCAjfdofM/0ceqQ4ZfmLLjTEaltQc9ayhZwb+hOo
	oI9BwqCLAXXuPC2ul5+v4JrWNkfbJoCnBMOGzzW0RJtlpru7t6Egn1dkRLZl9iAZ
	1Mwfk4qqrWmhy/Xw20u4JU6rGZRveZSbJU3DLcW+xHRlORt+nSDt8Axw5mCh8YBC
	GVSenSiUh93Si/ZroftHKkTGkAWh5N8hRDBD6rIpK8IvSgRZKo+s/Twin2TmN0td
	Ix9cmg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsbyn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so15730019a91.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 21 Jul 2026 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784703580; x=1785308380; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=saoDSDdEuqFBR3Jg2F/u3iejFckYCh1dzz5cbtTO9NU=;
        b=dT6yOS3Ld67I/O8R2GOHpQVfk08ENOkIVyiVKuOIsP0y3GrM4cqjXHcTPiU4f3+05C
         zHEPKcqM2vFW9AgpcsKA7jvXN7XBHsnPCHSkDDPC7B2c8wYyQ0oU1Vh/lZIVmMnsm5Jl
         gd7Q8RVVewcPAGBlb1uBHsqm8Sq2abq+7zdH2XrbJI8Kba+11g6Ai0n/SuTg44Pvc+4p
         bmC3Pt1glWz3zUYq2DyAvkuY7XxTusFNhThVl1sFsN3eF3IUGhFQCIcBUyH9IdHsqMOy
         nglMNsmpiiRu18kUSJi15ag/1BUAuLU0CYsj72wzXKifbbLS5Xqaq4JY5QGYwQSiaVjn
         pqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784703580; x=1785308380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=saoDSDdEuqFBR3Jg2F/u3iejFckYCh1dzz5cbtTO9NU=;
        b=QhiqQl+RkTSyTKXTho/+LAN7MtPCqSqNl9ICCsbNLGRhQFAJPajV4qD202mVf4GOiM
         /jTYfwvy1O3PnbO9HH1oEFWYlGaJHIVwQOwCogXjRBZjm/2P3hbLUHvBESSeRuEiA16J
         M8XBh0Jn1pLNmjt8frgPlyiwNeSX6W9dXd/0eQMJMFpmtBt4j7YEWvxIOHfzwkIWXQAC
         XjrWrzvBnoHDJV9JRa7uNbrYS1rPRPDVwNayQVNS418dbJc7MvuGGkOg++dOUx7uVp2T
         Y+p1u01BpnKACBJjDSy2A75OuI3WEZoD7eEavgPpPfaeWH2FAbtFRtVJ8Mzd9iRs+9Xw
         6wMA==
X-Forwarded-Encrypted: i=1; AHgh+RoLlh317JCryLWB86yR346YLH7m3f5e/1bQdf4Fqj78ghL+hcoK9vP7Ww7PuuRGoPo07B7urYI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxugTcXQWB3iFtDcMls4lcFATNgSNQTxoy0PgytNUQkn8fO36JF
	gJe5b8C10bUvuvguG1dB1zS4VRGa5hD7TD2nbixA5OH5BDGELLLlKXSpLjYDdYyH1NWPVJzCmfU
	28duBxnCQmqgML9y94bucHENZ5bFKacUdG2ziucsp5LEM7SjmACHI3mZ65eF5wGdNtqiKzpqK
X-Gm-Gg: AR+sD117xnD43NRWphz4F3O7JKg6BSRiK/4HV/+Ov/ot0mg9oDo0D+svR+FLO585AMj
	9R03tSFr2HYcFs6yj5BPaQJBzRFcPfJ0oHkcjC3JfWWqsrLmZTIEtOfAj2SSG9Up2xpezevMcDm
	rgXT9xWZvqK3oMWypwvVWkKATv8kHfGyuUMuUhPFtkhAGDB3wla63qtuEVGCoOvjozJ8EzhRbOQ
	+cEnN7q9mjAZuqblAhcxQekt4ft7NDDBI1Q4gNnW2OvwlWFwIMH5pAfAJg5ZWu+rh6EGCxASoMR
	sUDUR7Jd4p3B+S2bHnj1+B719aFBcXcFsn3/gvsiPY9oibO2d1PFW1JyCfzOUe6f3+0s2Liu1Iu
	3Z7Uv3PuEcUYXVm5sjDto7pK1yA==
X-Received: by 2002:a17:903:189:b0:2cf:906c:7d1 with SMTP id d9443c01a7336-2cf906c0d37mr21989945ad.20.1784703580062;
        Tue, 21 Jul 2026 23:59:40 -0700 (PDT)
X-Received: by 2002:a17:903:189:b0:2cf:906c:7d1 with SMTP id d9443c01a7336-2cf906c0d37mr21989805ad.20.1784703579605;
        Tue, 21 Jul 2026 23:59:39 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm9428935ad.22.2026.07.21.23.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:59:38 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:29:12 +0530
Subject: [PATCH v2 1/6] tee: qcomtee: Track the object invocation context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-1-b8a8fcbe4211@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784703569; l=5105;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=Uq74hKAscOJpoTlWbeJLC+5TbwItuETl2mqfiOIyB/o=;
 b=PFbHpdPKr5cwtQn4xbDEDLIt+rmsnl3yHQmhSVoVCCSwjBpvEBP9mTv+rpaNItkG5Hw5+zCoE
 Kp/MK/SYd3OAc8PcuRfoqqf3LBCqe1xO5x+mDvRJUQRIS5Gxw6Kvm8P
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: VepyCNZJnb8krptv6g8pJlBGOVu6KK1q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfX26QyYPzHa0YY
 +pSkkcFpgyCIY8AQ2JiMuLHv7sCUoUC8gKLzPJVbFojRy+6x7bIn9dw9Idgyrhms3FQKtiYjSP8
 I/K+Wmu5dsIS1zdnlfqFqzok85mh7LV01wX92K6o+XtlM+XpoiCkrGXhA0oGAiiGjo6iNRWd5JM
 bTtB+XqmgdX0Cr707rx3vkwpo45KSPr5+jvS7LrwBtCsVAIFbTJmmq+4uXyigkV3oapB9cL/H8K
 Lkv3GK/8PFMp1nhYzrJujNO6yeKKqEHa4C5VAloiuLeRg9GQ+jsg41N4WkDICOWydJngdlJFN98
 kll4hXs1NlKe4porZPThLe5eoH6WjmCbFiBS0hzMR7PwfU75lkkMpo0DrM8ybU++EDiU5ujtN8k
 kW64Qo+ns2GQqgOvGxFxX5IoGdWhHufQelTB3OZa2ShF7VzEj5dKXOdeEigC9qOFdcBNj8CjNcq
 DZRCVXlpDbREtOMebKQ==
X-Proofpoint-GUID: VepyCNZJnb8krptv6g8pJlBGOVu6KK1q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfX8HVMoBONAMu4
 Dzxmbb17cnNzqdj3T7glW0UbFrCZOxU/c+F7O0E9gp49pYNTOtbuK0ljfli6EOuY7Y9z8b/4Qch
 a8uoDa7oF1vvtJCQT5bF/DrjfUPzz3c=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a606a5c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=bFqmgcYAq-yHHMqQ97oA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220063
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 191DF450DE
X-Spamd-Bar: ------
Message-ID-Hash: DKGPH3BT4GM3LWJQ4WOEPJPQQLQV2NLE
X-Message-ID-Hash: DKGPH3BT4GM3LWJQ4WOEPJPQQLQV2NLE
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DKGPH3BT4GM3LWJQ4WOEPJPQQLQV2NLE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

QCOMTEE needs to distinguish between object invocations arriving from
kernel clients and user-space clients in order to correctly marshal
UBUF parameters and decide whether certain operations should be permitted.

Introduce an enum tee_object_invoke_origin to allow clients to indicate
the context of the TEE object invocation, and add a kernel_ctx flag to the
QCOMTEE context so the TEE back-end can track it.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 11 ++++++++---
 drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
 drivers/tee/tee_core.c               |  3 ++-
 include/linux/tee_core.h             |  8 +++++++-
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 0efc5646242a..03d33b118f6d 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -393,15 +393,20 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
  */
 static int qcomtee_object_invoke(struct tee_context *ctx,
 				 struct tee_ioctl_object_invoke_arg *arg,
-				 struct tee_param *params)
+				 struct tee_param *params,
+				 enum tee_object_invoke_origin origin)
 {
 	struct qcomtee_context_data *ctxdata = ctx->data;
 	struct qcomtee_object *object;
+	bool kernel_ctx = false;
 	int i, ret, result;
 
 	if (qcomtee_params_check(params, arg->num_params))
 		return -EINVAL;
 
+	if (origin == TEE_OBJECT_INVOKE_KERNEL)
+		kernel_ctx = true;
+
 	/* First, handle reserved operations: */
 	if (arg->op == QCOMTEE_MSG_OBJECT_OP_RELEASE) {
 		del_qtee_object(arg->id, ctxdata);
@@ -411,7 +416,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
 	/* Otherwise, invoke a QTEE object: */
 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
-		qcomtee_object_invoke_ctx_alloc(ctx);
+		qcomtee_object_invoke_ctx_alloc(ctx, kernel_ctx);
 	if (!oic)
 		return -ENOMEM;
 
@@ -648,7 +653,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 	int result;
 
 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
-		qcomtee_object_invoke_ctx_alloc(ctx);
+		qcomtee_object_invoke_ctx_alloc(ctx, true);
 	if (!oic)
 		return;
 
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index 8b4401ecad48..2528d07e4576 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -146,6 +146,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
  * struct qcomtee_object_invoke_ctx - QTEE context for object invocation.
  * @ctx: TEE context for this invocation.
  * @flags: flags for the invocation context.
+ * @kernel_ctx: flag that indicates this context is owned by a kernel client.
  * @errno: error code for the invocation.
  * @object: current object invoked in this callback context.
  * @u: array of arguments for the current invocation (+1 for ending arg).
@@ -158,6 +159,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
 struct qcomtee_object_invoke_ctx {
 	struct tee_context *ctx;
 	unsigned long flags;
+	bool kernel_ctx;
 	int errno;
 
 	struct qcomtee_object *object;
@@ -172,13 +174,15 @@ struct qcomtee_object_invoke_ctx {
 };
 
 static inline struct qcomtee_object_invoke_ctx *
-qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx)
+qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx, bool kernel_ctx)
 {
 	struct qcomtee_object_invoke_ctx *oic;
 
 	oic = kzalloc_obj(*oic);
-	if (oic)
+	if (oic) {
 		oic->ctx = ctx;
+		oic->kernel_ctx = kernel_ctx;
+	}
 	return oic;
 }
 
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index ef9642d72672..dba5d4d2d47e 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -706,7 +706,8 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
 			goto out;
 	}
 
-	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
+	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params,
+							TEE_OBJECT_INVOKE_USERSPACE);
 	if (rc)
 		goto out;
 
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index f993d5118edd..bcb5418d6fdc 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -73,6 +73,11 @@ struct tee_device {
 	struct tee_shm_pool *pool;
 };
 
+enum tee_object_invoke_origin {
+	TEE_OBJECT_INVOKE_USERSPACE,
+	TEE_OBJECT_INVOKE_KERNEL,
+};
+
 /**
  * struct tee_driver_ops - driver operations vtable
  * @get_version:	returns version of driver
@@ -117,7 +122,8 @@ struct tee_driver_ops {
 			   struct tee_param *param);
 	int (*object_invoke_func)(struct tee_context *ctx,
 				  struct tee_ioctl_object_invoke_arg *arg,
-				  struct tee_param *param);
+				  struct tee_param *param,
+				  enum tee_object_invoke_origin origin);
 	int (*cancel_req)(struct tee_context *ctx, u32 cancel_id, u32 session);
 	int (*supp_recv)(struct tee_context *ctx, u32 *func, u32 *num_params,
 			 struct tee_param *param);

-- 
2.34.1

