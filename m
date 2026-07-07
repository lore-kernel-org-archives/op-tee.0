Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E54C43458
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:13:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0164A43815
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783404810;
	bh=0eTjauZPn8IfSkvMdjZwIW90QvTg8s8dczcYNWpKwRA=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=W5kKD1ciaB+/Uz7vuJQnhk1VkOZ386SQJWOFYQT/tMtIBz5c5WObLJrGEvcul7MYJ
	 xhKsIrA8bEu7/cgvOzMORHb4sL5jccPvcHGxtbVuCXVmeJBJx+r+IuqnY/kgg1Ulat
	 z1Jonadum9Tstg5XMpWqpOarZwtKunUU3aebGLjuolk2DZFRoz0NVbmKpsN9MnVoNB
	 uGWMB7kpBj8egbMqOH0Zgi71zX7AWsblbxNL8nvNJwSy+Qrf/WPlxJeQ9xLV46fp5I
	 sP+U8bCnTv41yl4FzGmS5nBRA56fezh8JJU4D7oYzA56xOFeyf9gbcJYSQWhmvRNBv
	 ZgsuLOTeDpplQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 681BE450AE
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Jul 2026 06:12:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Io0+6HEh;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dVivRtRD;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66749Hfh2676660
	for <op-tee@lists.trustedfirmware.org>; Tue, 7 Jul 2026 06:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NNAd+TMb+3/aBq6GaRC6LydMmMiUk++N4aKr66RpLb8=; b=Io0+6HEhzqlLeXEw
	lfSVfE3QhcSXHUiGH8HhktWjbfgnkH/OOEXNR+w3eDv59Gur2OdikO5l/GULVukl
	l4vDkmH7LjMADd/7DiivL2rURDpYezJYMzopHTtRxNIKQr0DOSmy03ucZWpITfLy
	FsABkLx/sIaEZxdeanTAHa5kcWIkh3LD6CRoe2z3HUctBWttulbkwXrGakJnNW69
	D9ghJmXWJFSbqwuyjWZcB8IRPQA+Lml+wj1S//l3KQZpsVc1dm6CiFG3Rc+9L3UP
	kTqiMEXrk/G05FG3U7nLMgge+3SLAdwcQLfTQjx0shwyGg+BGFaQ1ZH+vjCTpof0
	RmwGwg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj78w70-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 07 Jul 2026 06:12:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8482b5cc6cfso959148b3a.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 06 Jul 2026 23:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783404733; x=1784009533; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNAd+TMb+3/aBq6GaRC6LydMmMiUk++N4aKr66RpLb8=;
        b=dVivRtRDWSLrwmRdjZZ+zXFAUQHr1jEaBCtrXyvxmhEZAThAPf8TcNmJVA3WWEQmTK
         QOJFBNYZ9h1ibA6EhNBuD0J3RJe3bv7KlSmwkKPNDhyJAHKpjlyCJBfZy8ZkDQ647Kqy
         mBU+CvKlhnGvF6C6HJt2ea2nOsWPRcIVfrGVcif6rJ97ePU0kaPntQPoyH8iSLz1yAbc
         2uGXDgLcMUx7JEBKBB7vVigKJ+BjLOouNsIid3YyHGMTvaQbJCpo2IniomSa64ROPxsC
         8UlOZqKYKQhPRlB41uIdl/KK1a7pP0Y6KWzWbW1ew/N1xLnROSTHMQb9/aHKV4QaH0TE
         fauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404733; x=1784009533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NNAd+TMb+3/aBq6GaRC6LydMmMiUk++N4aKr66RpLb8=;
        b=nbLxXJTMfWZyiMSjcZy3csLHxdeHK1+9WuJhXozLmhwWG96ME4WVLTK9LW7GOsqkWu
         BKK99ULuMi7LOD91G3RsufsORMLil5gTeicu+knA+gUjsIG8tRenCViJt3CBkA6uM6hL
         SX12zmSHFD03Wd6TWtGCTtrKR5yeJd3vu3iBWrCtNFcO8Da8WOk7TKY7VuZAVMUlIPwM
         npCnDSuetPn1Vj1+itkQfXrLWdIseyhxGbEHYJWgNuyjLNSTuG4LKMLuPmEnlup8NtrU
         h+cec/MKkgMtRrbTEvsFiYv/1JJrHtTxzTGakzCnlj9SM3hwvIjQBL9ChrlilFP8xFMT
         adoQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxovBR3tJhIvDd1qWnB8TsQ8Ayf3YwfIT6pIODq/37583Eqh82aokLgeiEebW8BLL0TBG2i/I=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YySFBXBFKBm/i5wguaA2WKjelzlUyOcaPZU66NGtwtCObDJehx2
	3sZxuxD2DrJc+kpirFUO3ATneV1HVtPrzDdEokuqplQlnWWdyjIrSK5aS4r8ktzIKsyjjC431Jb
	QR9O0JQ5/Dc22VSurtkfQI9k423hBszmcdKZfqi5uSQtWcb+qrv0s3OUViUhnQm2DfDxxr5yxEZ
	5SiSAE
X-Gm-Gg: AfdE7cni5iMQcH8/auH3JgcbFeUhrIViNSRoD90bYlAGxjUGFXxHFkYH86YiYK+D8XJ
	/niMZ5hg12qseUqNskuYq2iLWrNBXW3EXPYO3GPGHqzFtPgyF2aU0wTSoUwEccb8fgr+U5M16pv
	yuGsRXhybqK6yEpVzQxqJ1Ip/rHUyKKdVc/tjymABD2qJ04y2loqdpOK+meQTyCX0tuGPEfpDEM
	Yu4VBJYylPupuxJW2V2CObeCry1HAcnXMz2xQL5I4WcLVMzPTrCISzDSFUH0UbT65uTcm2Z3YZa
	fwu0ESF2V5qPIQyhFcNe+KQCDbkhiEKPW23+THlIarfuS9aHygdZ61vxp7GeXVIO75C+vohzcva
	PLWbeXe9Aj/3z4jdgK9jtrY1M08kx1pTkwQXb
X-Received: by 2002:a05:6a00:4b15:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-84826bea1c7mr3416691b3a.25.1783404732597;
        Mon, 06 Jul 2026 23:12:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b15:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-84826bea1c7mr3416647b3a.25.1783404732003;
        Mon, 06 Jul 2026 23:12:12 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm3299321b3a.8.2026.07.06.23.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:12:11 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:41:29 +0530
Subject: [PATCH 3/6] tee: qcomtee: Allow object invokes from kernel clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-3-f659cbd5d04c@oss.qualcomm.com>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
In-Reply-To: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783404715; l=6471;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=/owlBkDPCA2vuWSbsJZD4eHZ9HPwNyiIkP0LxaPIwKA=;
 b=qVSk5YQzILNpzM0ym015Ib8Zv8kzB0ZSfQxbEOWG+KWwAhnIrI0UCTiT8HniolJ+5J3peNh0L
 Nc7cIFaLke2DeX7eI1/LDP0l1lNSmgebtPzhcxrZXgAduWzkonPhTim
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: DjEeN8NpmGYM0k9M0EB9KOqr7y-37Iq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX/7j0Wjn/aud1
 wmGcBim6djaWLI7SboUqcwgQUwgASkeUfpPx6z54FQY8Ze0PevckXXnVHxBaCVxGCEw2BZNOuLi
 XcZwadOcS8omhlN0WIec2H5B+clJvH00Ii85okXxNHShHtvmUAssofNmhNalJODrYKGF8cFVk92
 Re38a+L/zUf878pT0rOMLOrJwfHeERrlXFxYpAS0Y0ufh9ZU5cFif6LbUsl7ovAJBSu2O3/4e1y
 LzkB726UYSCkFcf732AUeinpLvKEP+eSikBIsLeeUhKiKX0wcMDYCpHwLDSh639NESd/A2IJm4D
 owAZADNQoIlrc85rk/gst8StWaiXP79ZeuE4KCN5Kqay/mg1taz1JqyvGdvDvnePqY5YgrmGGzr
 9GPVyNYBDehuLptg54FG/J6/9UhQJc8Fyb09EDUrYw9ZRMtbgBXoD5cRGgGu0OrDv3dCsmVPI/J
 5kiEwt/Q/v3H/pZI9ng==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4c98bd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=XyePUiwmHbEyLJ1dZiEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX8/IeaL9g61SJ
 oW8AnyYwqlygi1X0Z/CH1E2zRoaM/Kgg2cN9dTQ4/Qj5SzTOw9Wq/Rwm0q8CuXF9HY69nauTA2C
 QOiTLti5K7aFRUelhNH+OxHWsgNogoc=
X-Proofpoint-GUID: DjEeN8NpmGYM0k9M0EB9KOqr7y-37Iq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 681BE450AE
X-Spamd-Bar: ------
Message-ID-Hash: UT4ATZWD7RSZIHJRSFSDEEMOCWGRIF2G
X-Message-ID-Hash: UT4ATZWD7RSZIHJRSFSDEEMOCWGRIF2G
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UT4ATZWD7RSZIHJRSFSDEEMOCWGRIF2G/>
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

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 34 +++++++++++++++++++++++-----------
 drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
 include/linux/tee_drv.h              |  5 ++++-
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index a74a54d67b06..e12c1a6e72d8 100644
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
@@ -444,7 +455,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 	/* Get an object to invoke. */
 	if (arg->id == TEE_OBJREF_NULL) {
 		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
-		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
+		if (qcomtee_root_object_check(oic, arg->op, params,
+					      arg->num_params))
 			return -EINVAL;
 
 		object = ROOT_QCOMTEE_OBJECT;
@@ -452,7 +464,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 		return -EINVAL;
 	}
 
-	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
+	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
 	if (ret)
 		goto out;
 
@@ -470,7 +482,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
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

