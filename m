Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19208CA5FCB
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:04:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4C3FC44F07
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790852641;
	bh=Irbg1KRJzwIAxvvjR3DfaB2BoPb6tvFu8FKM+ikBDGk=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Pgt//TZm2L62A5DYJ+QmV2/b9ovHepSbc98qpv8+82ovHX1MqARcDCiZC6SW4qEfT
	 44ad+Fva5gHqkLAqBYIJG+iKuKrjoCSt/Ao+xFW0bAUtnkPWFXFJQdEAUzqiYdtpN5
	 ffKglZ7YNhi8JcFXheUwV2B89x18qPizTDtNCrgeLoNwFufgraS29H4xAQ1f9vbd7T
	 qC630RIjT1cTFlLKc10vPjcFnGWYnyFEHvwr0uj7Fz0WhQvPItTKDzD68aGfQMRx6+
	 0sNxtb77Sml3Q90bTQW9CiA6aBdjmstpKcgybcYM9mQcAhCJHd1BTzDrABrq28Q2+F
	 PmxzaRp9cA/Kw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B96E844A49
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 11:03:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jVFTJAne;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PyGEreP2;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xcPW1062438
	for <op-tee@lists.trustedfirmware.org>; Thu, 1 Oct 2026 11:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GzMk85iZS5UHtjkiHXM8suSiraGPQ7MkLyLrHn8dGbY=; b=jVFTJAneaKXLp3gN
	JOTFWBpjlHOvnu6zdtWKEC6sI5re/Nj+fYmoC99Lo4xvRH6Hk/7SPc1rYo+iexkv
	dlGq9UKn2E0rwAWNs/k+5e+qSczDqtqo0R4EjunPrueIR45PUV90n6LXV/5tZYY0
	eoWPie4uIHD7Yhcn734HNVeTgK5v1KEBTXVzn+e6zXBCSEHRCoiw+xnOdFJQKBp6
	I8cK+RLiIcebqQZRvuz/CuCsEgcuLBCz0t2mHv+/Zw267TW4seL0JmtvJOIHDWVY
	rHCBIRhKD5KkaF0qyPcq8N0neyPpa/WkeHWASNP3L7i4AFwXdokmTKCvq1jKzNjU
	dI7aOA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvuhc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 11:03:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so6710783a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790852585; x=1791457385; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GzMk85iZS5UHtjkiHXM8suSiraGPQ7MkLyLrHn8dGbY=;
        b=PyGEreP22KMtnnFStBsq8ivPY0JWDUwn4usHkYpPiLwGeiZON/w9L09WO0y5DMbyGs
         DnJ3u8+WhbjcBYBOqnavfRwisVtSlu97I2fPpPQpah4JmxBWGGjK8XcDezUIwHiSaMWn
         fWIBD8YvV8qK66qE3xTdSpHftYUKFmvNFNcXg9+v/m9SPSTNNAmyef9ODBczp/0cmDUi
         kwCvHmaMk5h2j3xPVEZQENFjqXYzsTz5J9Bz6ufOJaCMlr2OK6orN4yxUwfIxUH7XQH3
         vgbGP2OvA8V02wfA3gNpw8nh3ITi5PSi3QEiwf9B2bCjgkrVZSJ8cmpPCfP7bf5NVJt7
         N8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852585; x=1791457385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzMk85iZS5UHtjkiHXM8suSiraGPQ7MkLyLrHn8dGbY=;
        b=gXNVcSPxzslvt4a6Qmc769G2ThHIE4XNiiyFQ7u8lCfuzOcgJEnSSdxch281pNoBFz
         kmwsWx2uzeO0I3lJ7HJ9KBvpZWvbltsIv/RaduVgaGZLO5L2gs85X0pAdVSPB8k9K9v/
         3t4wIJli0bFjgZc0K/7p5EmIi5I3c+bifYeLOafTclp/dwmySLxT/We6JEo7pJrEI9IK
         UtQXpmt2tjNR7oQFyRJKYZaGPGQZ8RtWzElP3sBO2CRPk97+ynevb5QXtiUF5LOnFrYB
         vYufTwa6YmUwT1/uFx8jtoRFOponMzkdwr5v5Igb1QvJEDUgFV/8RsyKTY10fbY88Wao
         aRzw==
X-Forwarded-Encrypted: i=1; AKwUvBySGdHiGts20TVqxMcUs5/Sger60UxsAbH2FKP+pS6qKv6XJrpezAt5sZcZcxIN3aNxYrPZbLs=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLcpG/+rgJozRByutzGlANM1xYfCF2CLDg1cBJHcsAbj8c07DBt
	/l9DA3t/+GCWsIbvzGOcrKghXnMNhwP3JxnPB+L3z0bqnveorAfxsfgfuUnnFY6o60/+O2ga7J+
	u7joF595/OttfOq14MvYjoOcg7kIVr8leEBafDH+z18HpU6ekYOll32OPuWihYB3MYvIQsj5k
X-Gm-Gg: AYBFou2HFvasGiaLI5kTgO/udtqES3sTAO11r6fhGtS7sy74kZf2W9STxf0+3I3uVH9
	tTRFUdCb2WqQQLqoc7U7RZkWWVmCGFrpb05s4VcU0dYXABoKUmW6SoY18uKiR7ni05waUhh8x4a
	DrsUadA1LTaZT1GZECoDSyH2cB8L9jRDyDKBz1z0Uf5LSes4ikn4m0xaQ1QC5Mnbtzwaza8pfQS
	iGpkTiWJ98KrMh+p9hrJ/5yLXF059X+fwkQlatVqGW3d7FEkc/awxbT9OKdSirRwtg5KnOzDUL+
	/t8Es5t0ISpuiLeY8zKH4/6JXm6ktf/8hwhv8ith8QGvxVnIn0G3ZcR3g2ah2h+eySbLXdOT/xQ
	Lt/aUzbqhX10Q6RJCrVIytmQxKQ==
X-Received: by 2002:a17:90b:1cc6:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a4d193052fmr2530128a91.44.1790852585281;
        Thu, 01 Oct 2026 04:03:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1cc6:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a4d193052fmr2530072a91.44.1790852584461;
        Thu, 01 Oct 2026 04:03:04 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4371383sm4076810a91.2.2026.10.01.04.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:03:04 -0700 (PDT)
Date: Thu, 01 Oct 2026 16:32:33 +0530
Subject: [PATCH v3 1/6] tee: qcomtee: Track the object invocation context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-1-13df5c20c2e3@oss.qualcomm.com>
References: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790852574; l=5105;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=Irbg1KRJzwIAxvvjR3DfaB2BoPb6tvFu8FKM+ikBDGk=;
 b=39ny8Acn97VfoCc1oMYUGQxcyeUoP5ox7fMARAoQ4xQp8o4kXl9/TLfVA1ikwoIlaasgvufsj
 pI1M3P7V487BN615CT9z4QFt2W0uFLNamL9E5bXLXqyez5HA8sufSlo
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: cPo-0ylxvOWXTq0NitzQw1wG839tpYJJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfXwmgUUsLOw3MY
 3P5S+K74HIskv4dBO8NF6u8BPJ0XuezU9SfS/m+V4IpVnrclQv4vDnjBJpr2DJ2ez8k/df5D33R
 L0BWNjjRKDTPFu5Rzp7O68rsl25ZGF+//3wSEfRlPodeb4CD7T540uyOWELokw2/kFcO0Er6R4+
 YPR3y8h4LlpCWGZNqoGdfJ38+AF4BLUxqCYDwucTChmlTMlUgeT77EUSQXpSkwmgGwdWUc5Zu0z
 mKBGgBjAViTqGdUh6ZMinDppAQwYcIBrVsKIewUCXqZ2VqoOkuuu/Umiw8psblYk+xkP94crENO
 VeEHebTrfez25QDzn4CntBvzcq9oYqIf4H3Xu01t8AV8+z8spQy2CEa9reTqqxo3Mbj2NikAHFd
 ZkL55LXriBUIjLWrBjq2PQeP+ketvSZjh/vXn5wkzMlVhxA8OObyMRIWWp783fcYoLAiIHeQTV8
 diteG4Q6l8vjPoEE+eg==
X-Proofpoint-GUID: cPo-0ylxvOWXTq0NitzQw1wG839tpYJJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfXw0ouGNxV6ZQ6
 HF19iInpUH8UWNPX70NBVoL2R50sdEC75VnEz7UbPnFEWRXW9MYQ9MuQVdFKGNtmuZpt7Y5cY3F
 fbwySs9xs6AYl7/cSp/DYadaRwQn+Gs=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abe3ded cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=bFqmgcYAq-yHHMqQ97oA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010043
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
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B96E844A49
X-Spamd-Bar: ------
Message-ID-Hash: K75VTXHIIU2X5YVSCNJJ7IUOFCHSWATX
X-Message-ID-Hash: K75VTXHIIU2X5YVSCNJJ7IUOFCHSWATX
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/K75VTXHIIU2X5YVSCNJJ7IUOFCHSWATX/>
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
index 4a597eeaf174..a0f2992c0611 100644
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
index d5de02dcef3b..5f40617361fc 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -147,6 +147,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
  * struct qcomtee_object_invoke_ctx - QTEE context for object invocation.
  * @ctx: TEE context for this invocation.
  * @flags: flags for the invocation context.
+ * @kernel_ctx: flag that indicates this context is owned by a kernel client.
  * @errno: error code for the invocation.
  * @object: current object invoked in this callback context.
  * @u: array of arguments for the current invocation (+1 for ending arg).
@@ -159,6 +160,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
 struct qcomtee_object_invoke_ctx {
 	struct tee_context *ctx;
 	unsigned long flags;
+	bool kernel_ctx;
 	int errno;
 
 	struct qcomtee_object *object;
@@ -173,13 +175,15 @@ struct qcomtee_object_invoke_ctx {
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
index 1aac50c7c1de..30901390149c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -701,7 +701,8 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
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

