Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE54C44512
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:01:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D1E74450DB
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784703664;
	bh=G6VnwaO1IVScbnDaolrmIYtJTI0uR93I+XZ8UW66RtY=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EpIb6TQ3cLGSxz6G5r9oUabkCsZ4FMm+czsHTZHuX0CWZEkJbTMzqwuhL269TicxG
	 GrBAMEfk4HwrJm4F5Q7IeYWpjkNy4P8XF94nBkfvSy7zHsWMx/Wvn6ac6tqafkk2Am
	 07mbDcUe1JmAY1cRIibusa5SvYuobn1Lf9u3SzYxNNrSTz4fDwbOV4KSdQqzYzJzAT
	 svEuJF1qly/K46moTXVe3kEO+QX8wdGxqSLZ6ssV9GAK1d4RJRx/FEtgEElm9aqDgX
	 uTOm+Vx49t0OfOi2/jIcqA/Wy32Zq3cu+zmAhe50w+0Q+1iMxXx5QaxqN/4YzNeiMY
	 /be6XHjPvWjZg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8FD77451A6
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bUaXQhtc;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aMWt1ekf;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53iSX3662817
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QcGMG8S4sHvnkwBvz/VTr4JXUXb6aBnJmGIPnGyQ4as=; b=bUaXQhtcPF303SZr
	oy87bIYzvB4UQDcPgMNnp/1BjlNzsc0SgYPOUNkWdvJozIBidArbnlgMJiyf2vx8
	X5z/OFMTIDYx8VmfVleBHh0FmhXmbKqhdAF4YK8Q3ugXluCiKFimfmmFeRe/gmrW
	TYQArpLq4tcYMrtyO6wFz6KeOpBsqA6dXtbBTlzyBk7S106wRoEPI3AeCPm5cg6s
	Tz9576/sQyCcL/sLtT7fsFv38j5RFd+7ThLpsAR8GMstNiasns9mIfFJ3trzYV+5
	J05rRJPNa8QcyjfYi9jEhx6D86iD0FSmoU0lIvxIdxxUzd3wEcCs8ZH0mJ05K8cq
	PQ3kdw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2nka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso2425601a12.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 21 Jul 2026 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784703591; x=1785308391; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QcGMG8S4sHvnkwBvz/VTr4JXUXb6aBnJmGIPnGyQ4as=;
        b=aMWt1ekfXeQNU5A/aLiEsduI4dOvB++uQcPeasLa4JBd1RvJmCMNzhr/1ln5zA6SUo
         1GDPiSlHvmrOybk+K9KSmT8f9R4+4X7PdYTpb3LW2sILxeSSyEQ4D8QIhU09onDW+Zh5
         QmEdfi2esEhZj8SJlctxJUuYcS6ZbeY62l1e6kJr8yZkmyn598S8JorONwNy4e3l4M+K
         EN5ZM9K6PvRIppWQfztCWvqNXAwtjVXvYZb51pw31myDp3Aok99UkBkLeDW4erOnWzyq
         C6ePZrWeRInf6S5/LHIYAO3zYE30bt5zYziyuMtunQh7YoykBrJVIqeM0wdpNKJvSIc7
         3/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784703591; x=1785308391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QcGMG8S4sHvnkwBvz/VTr4JXUXb6aBnJmGIPnGyQ4as=;
        b=ZqifR7UQdXRswydBFxiqU8wM6RAcSTWGji98tsoaQw9+gGJUoY+CJ0cY0BeKK5Ozjo
         rXLqD1rpgUrOb+Gdp5F8cFepb+lHV8mejzKBKDysonPofmNzAd+VEkMdFFrfnFZ3T9fH
         ampC+4lFgQyDrRAYjqhZhEGWiCo57C7Xwe5vr9FAJr93e/nccgNfF6OC5O13fIsw7k8p
         N5YWjwyyWj5tGkosJKuBl0sRK6zj9+SpkQrSHqGTtufT/GtjagwrKKpeKOglmuwo21vy
         xFY+4hGIievJOkL5c9khGKZkUEZbtIresiizCjiHrm28gpf8NnNkZbTjKthUlI5MN/b1
         pvnQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGf2kJ7eSTou4rwoPfjJ21KDoqqWvLvDMOpIFGSPm2twFY/jyObN3xqIhk+ZNHgobqxc0StDo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzsYEgXMHKlB8GSTNFG1DX3QA2wPmOaz6XDs6e4x2iOuwxDh8WH
	S1TrMpgvM13u+2Wa+fut8R/ggwiu8jWrKfEr3TOaCP1jQ1vzZc8mue5C4McTS65YT9hyK91j/iH
	uIJ5rzqvJy2KIklr0PglOFC92CaBZY760yyKVuwPQFdfQEHvW4IlTilA7xipnqy7fTQnn/Fqa
X-Gm-Gg: AR+sD108G9CV071oe4Xy+BGTKbM5ZaHqihxNyPd0FjsX/EsyF2wbsBgtTVhTSRAunZF
	cN7xWV3jRgdK3p1bxYy6KS6YUaJ6FtCsiXLlgIfgoDO2BettHHWG/GFBV9B1frbGXRnWM3DG7Yt
	DStnyZXc7O2TVVnNoplbGmRZszBODYS/tTsyLPL7OzBGJSdy8Y7e3PVN1CYhietYulczzK7qER9
	1JiK0Xx8SBfgcVnN/2iHktOsQmfGvSTvrueUDGVqTh4k6h4kcojWRUYH7UXmU+9qeTX/JAVoCvp
	dJh7UES2wcS7j2EO/lcrNMshRudQRnaUPeiSEipCfCyahHZ/zkR3a5351FkOexQsWBFeG0dfI8P
	5rbWVKxGJHQN7qLRce0LimdVA+w==
X-Received: by 2002:a17:903:1a87:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2cf3481b77fmr231364155ad.2.1784703590629;
        Tue, 21 Jul 2026 23:59:50 -0700 (PDT)
X-Received: by 2002:a17:903:1a87:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2cf3481b77fmr231363795ad.2.1784703589966;
        Tue, 21 Jul 2026 23:59:49 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm9428935ad.22.2026.07.21.23.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:59:49 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:29:14 +0530
Subject: [PATCH v2 3/6] tee: qcomtee: Allow object invokes from kernel
 clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-3-b8a8fcbe4211@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784703569; l=6532;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=ZmUkuPpOF1W6pfjx6a8SqHj69RiLqeBYMsNl5lK852Q=;
 b=qYiW8DMUyPHo2m/kD+h7brMbuBtdk9j4aOvafDtQ9+Ij8V6+NkUH2Ec4Z1mzHUvDALnv295M5
 p73dmDh1H9hB8ql7hxwfvh+wRBxvlBPPXBhhRev+voj9faF6edqc6jM
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: muPAnb8B0GFQZrnPQOUonwZvmiq2EtH1
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a606a67 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XyePUiwmHbEyLJ1dZiEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: muPAnb8B0GFQZrnPQOUonwZvmiq2EtH1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfX+QRbLaXACJHH
 wU4dYcG2UBk7klDv3yWmY6WAA/zy4Qyy/GjVcw814onbJ/KRIBbGviKofEnctkzRYLGdQkXlLBK
 ZguaKlQu70Ray8nu/KKUDP8HAbTyP2jtyHzdEAETuMyS2ybF4aJBtsEp2A52viMUfruSJtdfLQa
 m2WvnxcDNheLLh+5WKW5R/Ww3GseRf/8wWbG3OwhNBbnAod0nIML95KCOdDOStTGKlj1rl5EQUm
 oP4G1yrPmUyEZVcZJnDO16fXXvx3r7KTnIwdMXdxheuLSVi4AUWl73ziVrTlTRAYz5KqJ0Aijr6
 ECGC0qYkeZNc35ZPZejSId/UjGCQWy7BpHyZWoPaqC4JBmGyCP/701w1UPOwkpLhWOR4efNstzI
 miI2XvCTlsI+HOLozt3obt6uEs8DWWs9BxBzMMYOlhyCuoB4AvChXcRNrrU/uunV9OcvnKDeYGM
 GEfxXa43tkCW03OC+fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfX9fYzjNhQZv6G
 Tp80vRcs7LZe/K5b1jgjBpxS5ECtZxvJP9NkKdVsAnRZ2cMGi/wXaSyotE1uaIIMIRS1nvDayvA
 IqWewE+3/uY0M3gaMRJuhR4ljHRKzxY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220063
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8FD77451A6
X-Spamd-Bar: ------
Message-ID-Hash: JQKZRT2YJFRUPN4CJAKXZRJ5JJQL4JGF
X-Message-ID-Hash: JQKZRT2YJFRUPN4CJAKXZRJ5JJQL4JGF
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JQKZRT2YJFRUPN4CJAKXZRJ5JJQL4JGF/>
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
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 34 +++++++++++++++++++++++-----------
 drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
 include/linux/tee_drv.h              |  5 ++++-
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 03d33b118f6d..c1bba5fbfa3e 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
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
+			u[i].flags = oic->kernel_ctx ? 0 :
+				QCOMTEE_ARG_FLAGS_UADDR;
+
+			if (u[i].flags && QCOMTEE_ARG_FLAGS_UADDR)
+				u[i].b.uaddr = params[i].u.ubuf.uaddr;
+			else
+				u[i].b.addr = params[i].u.ubuf.addr;
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
@@ -429,7 +440,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 	/* Get an object to invoke. */
 	if (arg->id == TEE_OBJREF_NULL) {
 		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
-		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
+		if (qcomtee_root_object_check(oic, arg->op, params,
+					      arg->num_params))
 			return -EINVAL;
 
 		object = ROOT_QCOMTEE_OBJECT;
@@ -437,7 +449,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 		return -EINVAL;
 	}
 
-	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
+	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
 	if (ret)
 		goto out;
 
@@ -455,7 +467,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
 	if (!result) {
 		/* Assume service is UNAVAIL if unable to process the result. */
-		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
+		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
 			result = QCOMTEE_MSG_ERROR_UNAVAIL;
 	} else {
 		/*
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index 2528d07e4576..7bd6e23b038c 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -112,8 +112,9 @@ struct qcomtee_buffer {
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
index ca99c6b747a8..71d0536db60e 100644
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

