Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298AECC6B34
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:40:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 53FC945312
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792064436;
	bh=TH9zxNeWaz65/B2YQ+b8LzdvFPHuxkaeoFfCpFnc9rs=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BnxFG9YZfiNLFewBI81JxM+RNmGyVOdKkZunTOis7M8S0SbyvyygNrtTuL1C/3bb5
	 6Vse+Xvgq4GvH3FDOQPBIBjG5lVetriNKOlvFennZhOBvLNRkdZoAmM2273fMU9AJw
	 DESQRcUt6d8rAGkT2mq3TsTiw/757+y9Gke/ZO0rVsqkCk/op4KEjptXFgNTI/6H+f
	 OjXJojbBDlFxF/Y+A4rU8YSlQoUHJLJJ/4Y3NVusOjhdYsHvINo5PfPN4ejD/d+18r
	 bbEyhd59EhL+bfUcScNZlou0um02QtkkALUi6x21gZ7UJ0Dyt6ILSPicgdxClWySA3
	 fD9atD0sUpd2g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8421B4531E
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:39:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U9Q7P2n0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GPUXlfV4;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jVST2416867
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qS++bIcOkmj5us9fGYAnFO6SHPHvZleD5TMRdoTL7YU=; b=U9Q7P2n0cqcBL42S
	NpvCKxyBXBeVh7rkgFhQr6dA14rYSlh23Q1mmtnyeX6FiH2CuPxqmGSiqXaXmqDR
	d9rmxmBGQGFRhHBcBnEyQerU30PD1BmyCtqDwN/L+GwW80ONzXQc8qcd7xCn1OTo
	vhnzPzx+dpl0BMpOWheq4VAoxOkK1lY9OHrOz63TW3XH9WyDGqiNPboYXk5S+g2I
	fwnMxQEzgJ1dNt0nuWQjnP4pHdmh3ma9lk0+KM08XKlbWI+mlRw00QSZCHChYc3z
	iFwYJuUr/4B9X9K8gGJETIa6/Cfpi3JI2Sey+HkDVreouSojpQIV/P9s+bLSHAg1
	3KLKfQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhhvrv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:39:51 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3552883bd19so10783111eec.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 04:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792064391; x=1792669191; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qS++bIcOkmj5us9fGYAnFO6SHPHvZleD5TMRdoTL7YU=;
        b=GPUXlfV4mdyia2TkqQmcRDc142MOV5CqwDa5Zse0Y0CURBaQxZF1M6XOgm0Y5Wl6Ge
         XAF4jdLrjRPzvMwdEozHsh/MNvT+nU80fW4E35Lj0DN0w7cr0wbHA1vsKWIpdjGFHr0n
         8y6bbVkZ7Lr+ZDsXA+ICJ8SJkEIiTo/Ipt6lhvs67jl3nNrXqq0JSAlWQPrKVJM9Nue4
         xr1Evuymtjgu0R6Wlf12Zthyqm0PKMOrhnGKuVv+wxTB8x196/XM9onkUotNAenf2AlU
         UpXQAd5XMG9BcJ1skOzk6JC/ho/yfpqEu7zSvPVde/WydYrugmZyOdITu9ck8Jq0/b+X
         TD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064391; x=1792669191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qS++bIcOkmj5us9fGYAnFO6SHPHvZleD5TMRdoTL7YU=;
        b=MdA97dYoSFWm+zyXYRs8Jh8OjjBcK0oiYeTAto5XWsjKrcoSyZc1Kl3m+vWbPHgt1e
         YDuaBGRouGPYdnMjFkWtdp2UWSi2tPXkhMk8SWH2UeYnjhO/W39Sid/53hIAVwWnUSdP
         TNpj/zt2xN5Qy4Ru8/ipGYyhbvJF+uSyBpYctgWgngXHVxGL/O6sMYvH6LhKTcZb4sFI
         xcblXY9DocR8dc35NEL+HqAZ44faUYdp7lyPuFJ/nMbnwbel5dkhUgRnjNrd/djFFneN
         ZXh8HvXh9x3F0/u7pnf9qiHi6jZKX3hVXlqSUPxlsgHRcYRPuy148oQuxkqfvFxRYMRq
         NZsg==
X-Forwarded-Encrypted: i=1; AKwUvByqBdk7wVOJnjFNC2wobaKGSq88jUY3VYLJnH5wnRk0idHHkbMxcJgH0mnKci4yPYlJrro4evI=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKgzw6vRCC7AdorebYlmO1D8iuMovt3tU0a4j8jtbqikIqH7H0P
	6zmW3qIja33+k+r8ZCFL6kLTE/Iz5jSJyFRuxIIRBgJ+CgIlBlZePL+YSh+cCO/CJDMwEudk+9A
	iIsXDMpZ3eDNhwFC3ULFwWuVvGftcD5pb5xuJmXi3WS0JD7MVVsrBM9zrCrZAfiTbpUtQ5Gsq
X-Gm-Gg: AYBFou0OkIGLG8AJxElMsjA5FuKkT2wx6bnm0Ee5lhktYvr/zOh7fnermaWhSAV7pkA
	t6VL0kw2iOlmpaJ54Ks6i2hzbJGQqVm5OqVWTIj49bAb53UMpYMgYCmzeM0+NmmNpSpUvILmsKJ
	6Hhvc+dyZskFOnzNbXdxF39JgVdv6tTJ5GxjP6AxHbHBk3SRnVK8oMzxzTwAnpsk2KAFiQqfL3T
	Te7zImnVorVty7FNk7nxKggg+m5bTJ/2KKMPuAU0a0RBGYdHT+kkL4nSTB1PjpbeikOhNoqdXme
	fWj7kLXJd4LinqWD9i+pd4wi8Nq5vLAP8huNCG0h1mauR8L2D9hl+8InYTALdBp5q7c/w32120l
	99wx1b9NjpeUTavuz7QWbgfd+Qw==
X-Received: by 2002:a05:7300:6a93:b0:35a:22a4:12b with SMTP id 5a478bee46e88-35a22a421f0mr17265448eec.38.1792064390336;
        Thu, 15 Oct 2026 04:39:50 -0700 (PDT)
X-Received: by 2002:a05:7300:6a93:b0:35a:22a4:12b with SMTP id 5a478bee46e88-35a22a421f0mr17265411eec.38.1792064389759;
        Thu, 15 Oct 2026 04:39:49 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm48144891eec.11.2026.10.15.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:39:49 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:09:35 +0530
Subject: [PATCH v5 1/7] tee: qcomtee: Track the object invocation context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-1-1460691b35d3@oss.qualcomm.com>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792064379; l=5457;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=TH9zxNeWaz65/B2YQ+b8LzdvFPHuxkaeoFfCpFnc9rs=;
 b=ZG+Mu8yqk+xj7MqylDbXHpUjwystT2y4/wGB0s4aaEq95FUNNhsv5tRpDjfafzd2UHLXMzo+n
 Gv1x0E2PkoDAgS94DbIWfJLfluZBClFfFdGhjlD1xAZA4g9xh9tGra+
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX4UCUfyQNDp57
 6uvNpAyed+KFp1S0HVGylJDTgqac1xbCG1qlxG/WVGS7pI8WIp6X4p8nLPSe0hDPI6CHBo9UJe/
 2VdVaupjV7/4BtRViJqgaqpwDP862yEVvSIDhbzTyWv2M7qQZQwrDRiQn08Ne82DHI3oBqQmONy
 y5eE3Hx967SZUfhVZPQ+Ya0PIb3ch7D9DHVUtDEPuNjibt0B/dYjFFlu0ExIqtn5NfUshQGVheN
 zf139TEPxHzdh+LfLLWeFy/Aaqrmz4Q3rkDWV5HrQm3X3SC/kf5EtSdGywy3u+kxtA27k1v6FPz
 YCxBbCOFaV9bg696a6jbhBOuDEDhcv59EaVYJY+zyHOypZ3KcW0maJJxxYMnhpuxQRVxxjUBj2d
 ufiVn8elE6SjdGd2/n/DAI8Kf0ATYBMaa9yfKd4A6l+nYbHwGGqIjdjX4ubX7yOEbTTVsBJAhEx
 phLouD3cJtzJUHYmgRQ==
X-Proofpoint-GUID: F9dnQGBKLfGPkilypf07L8Pmv5b52Ivw
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0bb87 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Tj57qVV8HpgCqk1lqJgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX39l1GE08oawF
 3QmCRQjoWQebwhYRRFw6kbqsLDIj0c2RBQXp4s1IXDAxv+rlV2BbRckZxLxhFxp7YLMAP7K+f81
 JUahJxn/vcnnimaqihBB4XozIpnoTOg=
X-Proofpoint-ORIG-GUID: F9dnQGBKLfGPkilypf07L8Pmv5b52Ivw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150046
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8421B4531E
X-Spamd-Bar: ------
Message-ID-Hash: QWNBH6E4RRJUZ3UGUJVCDD5YAG5FQMFS
X-Message-ID-Hash: QWNBH6E4RRJUZ3UGUJVCDD5YAG5FQMFS
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QWNBH6E4RRJUZ3UGUJVCDD5YAG5FQMFS/>
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
Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
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

