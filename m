Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75256CA5FFC
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:34:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B43D845482
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791286480;
	bh=ND+1mAauHCpeEOGzRE+jBlJjOIKD3T7c7XKJWlJyL/A=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=filJxMohghN25HHf6QcU+BIUKml9Bj5yDz5l2T/5JEUPUlAX+sUoPfex/a3PKR1Uc
	 UP/3UCXMAQyfA3fMUU7kVBBn3qh56wJItl8++/G+ChA7tRZovk+NQJR7YYcamG/MxF
	 g4YjwCR1SA3AyYGZ68eNP1ctUesLEdRRpmaKtFLKc8XHHb4nFjpcw7hcP7hEReKx+g
	 bUD6uOVk1+R5TjgWm6VOzfPYziI0aXc2QUGZ06h4ulhf0yiFNvYicNB07S8EN5Uq7V
	 3YtEuSHc2Grig20SWpHuWzxHQRtBK/tKXfBJJ4DHZZboKBShcKjgsDeo8CawTHZLUe
	 RwhvfngCgm+pQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DC4524526D
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 11:34:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JjnOcmMs;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XVKpcysA;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPW1w718529
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 11:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jqjozfXj9kneHvAFPbQFagxM9e/DSE3jCUTbtNQnrlw=; b=JjnOcmMshwO1jJ0E
	2ZX3faNtoxsg5+FbGJoK6OEoLySklBvYjmiDZeWm7/fzaXLmRewdjMls+bMF4EQL
	eEZ/X92qKRJr+UQJqrVadijcoOEvIkFMPELxls6Zf/5NyEeP2ADNhlRyAh+NTdaI
	qnNWWRziy3TKrp+t8duFbyyTJi6zXbHtQeehHYtNI/Ck4/4Dj54M/Ovy+cFD9mJb
	eqHgT9win1ge+5pkk68pFsSVN81j/fXgjWqNo4ye0pSrO1Xw3rBsmEnLgliXdgPq
	aFQtavEyEAFurKr+vb0gzU8P5AQK6gWCWIDfRe/WuDLFH6r04+0n/2P6cKAB5Zdf
	oa+cIg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3kbs4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 11:34:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a47a81e70bso2999392a91.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791286444; x=1791891244; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jqjozfXj9kneHvAFPbQFagxM9e/DSE3jCUTbtNQnrlw=;
        b=XVKpcysAOzfFo41yRrUuim+E+nJ49jTQBgxH9aw8Oq2QcIhZwb04j4OpGG6Mmqzqof
         dM6vHVyaqUcMQJoCVbuNKyey1z7zX4Y4LcnWAgBZ+on7ayeBYgzZjeRFtrXPBejxxIwx
         hqS0zqni3ZSIJ09Wc3AlHUhIB7A1PbGM/fYE2GoQU3rzEsioNi+ZzSXTwG10kNtPxrSy
         TUMlxzE7SfISg40v/sOQhZe9lFqg962l9qA6f3A5dFGWzDFybhS5cUKQb+OqrOuOqviM
         AoKxvQmcruo2XJM3Vt9n0wA3KYpuyhE4S0Jw20pFjd//5wdkZPKLHp03gkjcbzaJMLlj
         kqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286444; x=1791891244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqjozfXj9kneHvAFPbQFagxM9e/DSE3jCUTbtNQnrlw=;
        b=mw9XHO0BLb+/x3iaPIZUhq5KAAWFhnMtCR7JHeNGKLlAcxYnyXtNLWhkf4ppiA2ttK
         aaHNUCsampJHTnd9dveIxBBgTutq2cA+bpzYDG2qHz6bMubMF9PdyDV1D/Z4oPXl67em
         QS1qK/jOcV7KNer5FqkrONMx3ZLJwQzTHJ/lJg/H0UGqv6UxSRsFZWrUYEHbTWkPy7GH
         542S0fYoXxljbtYgrGbZhhmfv7edq+QXT/WKhRu6ngOV6V1WGjSBM03lyB6yiGFPuuIi
         PEs6PTqHW08i+clKImwwTwTBFIRlQ8WRfWWJsZ2dRobgQpK10GJLYQdsCwnGFj+JfkkK
         vvXA==
X-Forwarded-Encrypted: i=1; AKwUvBwxdBPhozYEQ5hmOFvHqfiJ6rWgEHd7mIDeODGBifc5VZMcAVmwLFUGU1lwsujS1UWppfDIjKo=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLbFLt+1zSfTn45sRIxm9hiMpOVcYA4RSMnd6gcQAlrinH8ycO0
	rJTPJzBlxw+wjihBhw4QzMZy3SOu8iMGFCx67PdUg6P/aDfJvfQukQB6CWElgXjai2l1ULEQDln
	zOukoE/LZMTUwMqAsxxEGftvSkKNJktMy3xtlr9uyiPxUnckfd29LZBfWNB6fL3EPubMuqVCb
X-Gm-Gg: AYBFou3IL34zn+FRlBoZWGgKI8nZkEppTzpLSsMZHk/fH+ClpiJ/5xLedTaru5+XNSy
	0uk+iSJEiqCh2jvVirez37M88CqN0bv2GbqGip0fKVCWMWxfJwejLbYE312jsmx9S9Z7hBr+ViU
	18+fZy6CLxVPdPd2d7SfHDewPnd7wuzps8T+hRgr0KIDrjb5Y9Fk8sq4Z4FZanHDpMwspv/HywE
	sxdDCbiRgajWmk3JNEWV9cPCQdkNHcVFNeBaqPQG+NZvbo5XCu/GQ9mxhgbP1Vr7DoMcO48mql1
	GPi//VPXqZGiVeOhDlE0bT0Qy/s0xIA0RLCzeX4xsYkCOzWTmmOXUow70h5kYv6typOzFoYeeQ7
	0mPGxIFousBqxkEkGn5EDpFkv
X-Received: by 2002:a17:90b:2646:b0:39e:6c69:34d3 with SMTP id 98e67ed59e1d1-3a873729dbamr765312a91.55.1791286443913;
        Tue, 06 Oct 2026 04:34:03 -0700 (PDT)
X-Received: by 2002:a17:90b:2646:b0:39e:6c69:34d3 with SMTP id 98e67ed59e1d1-3a873729dbamr765291a91.55.1791286443347;
        Tue, 06 Oct 2026 04:34:03 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a709a4e80bsm9330092a91.4.2026.10.06.04.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:34:02 -0700 (PDT)
Date: Tue, 06 Oct 2026 17:03:22 +0530
Subject: [PATCH v4 1/7] tee: qcomtee: Track the object invocation context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-1-bf1c8e2a64ab@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791286430; l=5390;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=ND+1mAauHCpeEOGzRE+jBlJjOIKD3T7c7XKJWlJyL/A=;
 b=VpLPxcggntRVRhGxfNCK4iy4d3cjKYNFiq4NsSWhq2M6iqAEHPkAkDrOZLV8f0A1E6/j7UR5W
 dbODxrebKMtC6XwlhW2efpAsvQABkfMmT1laM3KuyrijWdszmb6j0r3
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: pCx00ILCQMBT3EcpFpLV8aa6h0VpuJ3q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfXz5HDed0paMYU
 TYQQprkRFeD2IIRqGXTztn9b/or6+yWgvOTOei23++6dSIOKlGPrZjkvWbCrmGDUjOr40TpCwNZ
 QpJLPAb3ZPPSS85Qqa/Qk8b6COFlUh4=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac4dcac cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=BY-klj7G_IJinew-6MgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX+ZBrZnn6vVIF
 WZMa1AFuzfrj+fhVowicL/QoELLQmqZJoMsbQz9YXhCFnimtGd4+pbMnwO8SIQEieBc8c6VEd1P
 2NtGPG+kaHYA/Tx1b/q1xWlHEUTSRpRW7KI2uK3MF3F6bugoCFTGhLIgXUc5I7sbxbxZU6bJOnX
 /0si+8B5eEgIMr4NuSmhOb+plxWp+gwWjnlW4CRZbMsgb7shkMtPGUwKkm+Zy+LRcFLKJBoAj7s
 PadW5iYTYuuOiWn502ii/Z4jh/0hQ2D9aJMQCXqlJ6FHmhDUVqtgHzRl2NSA0XDN2yZ4x7Ndk2t
 d+qaoAoSXQR07LHao8BYDAFsD2yX7cJ0xQi7J480SvLytSVJU1kpsYGPR7FkBq433/6cIT5nyn8
 Qg6TUPsCD8JsEn2I9u/Rj9/LrCk1iRtAr0FbSKbNf5+uGj3n0Q1+jbql2Hs6LfAcC/EX5UAc8UN
 xXHBDR+mYtk/mVU6d/A==
X-Proofpoint-GUID: pCx00ILCQMBT3EcpFpLV8aa6h0VpuJ3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
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
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DC4524526D
X-Spamd-Bar: ------
Message-ID-Hash: KKOZYJKBUBGWPPZL3N7XOHRIOG6YPFZC
X-Message-ID-Hash: KKOZYJKBUBGWPPZL3N7XOHRIOG6YPFZC
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KKOZYJKBUBGWPPZL3N7XOHRIOG6YPFZC/>
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

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 12 +++++++++---
 drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
 drivers/tee/tee_core.c               |  3 ++-
 include/linux/tee_core.h             |  8 +++++++-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 4a597eeaf174..3de54af45719 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -388,20 +388,26 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
  * @ctx: TEE context.
  * @arg: ioctl arguments.
  * @params: parameters for the object.
+ * @origin: origin of the object invocation (kernel or user-space).
  *
  * Return: On success, returns 0; on failure, returns < 0.
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
@@ -411,7 +417,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
 	/* Otherwise, invoke a QTEE object: */
 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
-		qcomtee_object_invoke_ctx_alloc(ctx);
+		qcomtee_object_invoke_ctx_alloc(ctx, kernel_ctx);
 	if (!oic)
 		return -ENOMEM;
 
@@ -648,7 +654,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
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

