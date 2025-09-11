Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18780CA1016
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 03:45:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 651B64FDDB
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 03:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757562349;
	bh=zqf0PKhzIuZVIPaRYJ3I122DsU5RbCE/8tAyDoK/2S4=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=4YDJ6jO2syZNSRBNMom7GCWR6wL4unQ9LFiHR2M+OEhHxsd2C7qzuWrAiyGqfuKGQ
	 G2vfRn4Pd1KOgks8yzLw9URVT3pBCkLkN9X+3LqVZ2eH91UrXdVoXlD0JN1U8exr3r
	 va19LN70mxPtkrOyMiN1CrPAMPqwKDKPcNtBXACn0NxZEYOjU7EgjyfZLY+VKAljWr
	 NUqvj81KWxjlE58QjSfaiPsYWCiGTIUhJ8IXnYhxjVfHEwpkv0agSYSGsdLnN9dbSP
	 AUpi5wAKx+VgiYh778vFoGZc0bz1m5dOcbzgLoMuRl7CWMo4rIUFW6m3iW+bQA5ili
	 DNHNudXKOtUtw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7FCB94FCBC
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:41:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GoPqovmV;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2J1XN016853
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lnPPGOh2u3id2oIj+03M3qcTEgPraCSEg+DXVn0qZCM=; b=GoPqovmV74sc0BqI
	rm58SwWewvG7GY84U4gd8b6Aj0H9v3mbLSSG/q+gkS3EvJo2HZ398G7611nhCgpd
	+/lo/7EycJiQn7hE+dlhkP80xrb45qJJyx5V810FtG4JlUPul6J/mWnJAWapNa/C
	BRq2ybxme30VGTNId6nRPucoPuVGaTKO0jtb360TaaTfxog/45C6R5Dex4YNyqcX
	jzDMc4aC+GKm5r/gABZPKypjrYDxHtGz6LSyMPGTIbCGY2stoP3xlYAZUG0IeZNg
	K9B0Vo4o7VrObck+0I0MtO0Vxub3K4RhHHvrZomFG4gW/i4maMvEA/L3ZniAzpbX
	K4FlWw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t382m4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:41:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24ce3e62946so3928645ad.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 20:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562094; x=1758166894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnPPGOh2u3id2oIj+03M3qcTEgPraCSEg+DXVn0qZCM=;
        b=NXKO6I40SXkDlEi/sWhqNBV8d6EYUH4o579p2oZJBph4/BjFr0UVvTaZUqvzf1dhBZ
         Dc2UQj3VTugQQ5ifEPaS/WnTZpk5ZkKQ+fbMfRTpHkUxmLhuTgt6A3Ftoexs1FO3mjvT
         HjZcxdzvP1pe0iyp25pfqj1aF0eKvsvy5UbDp4vihycmqT53QW9zACDIZ3dXGH7goFPu
         127J9LaNJBxWmCGQYliUV53q0SrSXZ4aI6mR97cVlQO+nB/7oK+LG3/UpAKLQxdcElPI
         DccHfgaPj6i3Z7BnRatdKbmoB7hgMrLSQicHFuUqrh+hd2/ppjdnNXX5QjoSG1zZy9iz
         c8fg==
X-Forwarded-Encrypted: i=1; AJvYcCXc8905ivmUQL6z3GPHrtJjCj2s1PCYGZg1bzS872rGK4A+Gjl7MSznrdGaduBUfnhRoPHdAek=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwNytxiZMWL42IaFtvI1nEbNoRehjIb/Iak2vFSUj8tCMQnsdrv
	2PnINHc9pk9l9LnNt1inP53ss+ekcWuLWsTL6wHUe9bJnUAetRjMKlpsC3iuTFjNKBgtU19Bx3v
	APoKWdmHwcxDjikGpPxE1wDMDqzaVRhtlWSd0ZTpuf3xZCTzsorhrAsumzMZqFBbyO4ozy5rMRb
	ySrNLMIQ==
X-Gm-Gg: ASbGnct0zUrnIQLJRqXhdz6xzm+1I2TRrmk2Www+Sg5CqqQbqkEkoM67wpAgj89ZY5e
	XIR0wRypKtGE9nc8PKct36HAbiiKpOvriCOZAmAECeMVuDFvRWi9ESInSp3vlU4qAUf/CXQKs9l
	rV6E7ZSSlJCLqtbphG7YcnMsplzvonjuJiqqURHQRw6fm9lqJwN8B0w+2yJ5ulx4/Fu6xR/P/dA
	Zm9Qni0092I11daWvz08peyqZOTOssz5NpdROQrpqXM2V/Q9tEzPNztqH6rrL/LuGw/+imCvYOm
	RarDYDzh26zHy8g3Asp1MIjCQcSzgXz2qLUyYvG4PlgQ29qeKhLXLU4VNJhfkx9/gmOWQw62mB6
	aeMcgMpXmTfCHZgMLj8yokEM=
X-Received: by 2002:a17:902:ea0e:b0:24e:bdfa:112b with SMTP id d9443c01a7336-251761616c1mr196529295ad.61.1757562094244;
        Wed, 10 Sep 2025 20:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc2o2B2TakKKR9adyaPwYn48rLpxlSHAUGfCjETACNGIgh3Mywg9h99vJL8ucU9Xt+o6xDaQ==
X-Received: by 2002:a17:902:ea0e:b0:24e:bdfa:112b with SMTP id d9443c01a7336-251761616c1mr196529065ad.61.1757562093727;
        Wed, 10 Sep 2025 20:41:33 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:33 -0700 (PDT)
Date: Wed, 10 Sep 2025 20:41:19 -0700
Subject: [PATCH v11 06/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-6-520e867b3d74@oss.qualcomm.com>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: N4qI8y6EBbAqYbRsl13gKJxjf36FU0RL
X-Proofpoint-GUID: N4qI8y6EBbAqYbRsl13gKJxjf36FU0RL
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c244ef cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=fw-SQdjKjSnpQ1BqlTsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfXz/9W5PrhIhlq
 4n2FKViqxbSUEHTXkTYwEVsT+sZFrUt3aX+3qlHylc5f0mxcl4F3oVZ5AIgxYDsuMq7oklZ/FFQ
 AnCJb618BQkwJq4cT9ZaMdqZyL01cWOnEfSQASc6ZEr42eYw5lmRXQUD5DvEhLhjrgFcVyBWVgK
 WdcjFGXI6CvLH/5C1N9Lxz/qcIGB38LofFHxnQODRSybTRwtUcFOv85o8NBe1tMoM5wdNznkskW
 TWXDvSRe5dNPInxY1HdF6w4NoeTidTY5f7/fXK8kZPBSjLhFWDOv809C2EC4BVIq+3EhoiJBJwq
 mvBQ+rEZpOF0MreoYE1ElBjEQDFQtD0BoN59rdfuHWZpz5sxR9uc5Q05FuVrtFNfdaUpkMUsmNE
 VrrSVch1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066
X-Rspamd-Queue-Id: 7FCB94FCBC
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: JL6PZGEZQFMUIWLN4K3A6NZOAWYFZQMI
X-Message-ID-Hash: JL6PZGEZQFMUIWLN4K3A6NZOAWYFZQMI
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JL6PZGEZQFMUIWLN4K3A6NZOAWYFZQMI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

The TEE subsystem allows session-based access to trusted services,
requiring a session to be established to receive a service. This
is not suitable for an environment that represents services as objects.
An object supports various operations that a client can invoke,
potentially generating a result or a new object that can be invoked
independently of the original object.

Add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT/INOUT to represent an
object. Objects may reside in either TEE or userspace. To invoke an
object in TEE, introduce a new ioctl. Use the existing SUPPL_RECV and
SUPPL_SEND to invoke an object in userspace.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/tee_core.h |  4 +++
 include/linux/tee_drv.h  |  6 ++++
 include/uapi/linux/tee.h | 41 +++++++++++++++++++----
 4 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index bb2e3a6c23a3..e22995e457f3 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -450,6 +450,7 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 		switch (ip.attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
 		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
@@ -468,6 +469,11 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 				return -EFAULT;
 
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
+			params[n].u.objref.id = ip.a;
+			params[n].u.objref.flags = ip.b;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -506,6 +512,12 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
 			if (put_user((u64)p->u.ubuf.size, &up->b))
 				return -EFAULT;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
+			if (put_user(p->u.objref.id, &up->a) ||
+			    put_user(p->u.objref.flags, &up->b))
+				return -EFAULT;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			if (put_user((u64)p->u.memref.size, &up->b))
@@ -658,6 +670,66 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
 	return rc;
 }
 
+static int tee_ioctl_object_invoke(struct tee_context *ctx,
+				   struct tee_ioctl_buf_data __user *ubuf)
+{
+	int rc;
+	size_t n;
+	struct tee_ioctl_buf_data buf;
+	struct tee_ioctl_object_invoke_arg __user *uarg;
+	struct tee_ioctl_object_invoke_arg arg;
+	struct tee_ioctl_param __user *uparams = NULL;
+	struct tee_param *params = NULL;
+
+	if (!ctx->teedev->desc->ops->object_invoke_func)
+		return -EINVAL;
+
+	if (copy_from_user(&buf, ubuf, sizeof(buf)))
+		return -EFAULT;
+
+	if (buf.buf_len > TEE_MAX_ARG_SIZE ||
+	    buf.buf_len < sizeof(struct tee_ioctl_object_invoke_arg))
+		return -EINVAL;
+
+	uarg = u64_to_user_ptr(buf.buf_ptr);
+	if (copy_from_user(&arg, uarg, sizeof(arg)))
+		return -EFAULT;
+
+	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
+		return -EINVAL;
+
+	if (arg.num_params) {
+		params = kcalloc(arg.num_params, sizeof(struct tee_param),
+				 GFP_KERNEL);
+		if (!params)
+			return -ENOMEM;
+		uparams = uarg->params;
+		rc = params_from_user(ctx, params, arg.num_params, uparams);
+		if (rc)
+			goto out;
+	}
+
+	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
+	if (rc)
+		goto out;
+
+	if (put_user(arg.ret, &uarg->ret)) {
+		rc = -EFAULT;
+		goto out;
+	}
+	rc = params_to_user(uparams, arg.num_params, params);
+out:
+	if (params) {
+		/* Decrease ref count for all valid shared memory pointers */
+		for (n = 0; n < arg.num_params; n++)
+			if (tee_param_is_memref(params + n) &&
+			    params[n].u.memref.shm)
+				tee_shm_put(params[n].u.memref.shm);
+		kfree(params);
+	}
+	return rc;
+}
+
 static int tee_ioctl_cancel(struct tee_context *ctx,
 			    struct tee_ioctl_cancel_arg __user *uarg)
 {
@@ -713,6 +785,12 @@ static int params_to_supp(struct tee_context *ctx,
 			ip.b = p->u.ubuf.size;
 			ip.c = 0;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
+			ip.a = p->u.objref.id;
+			ip.b = p->u.objref.flags;
+			ip.c = 0;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -825,6 +903,11 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
 				return -EFAULT;
 
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
+			p->u.objref.id = ip.a;
+			p->u.objref.flags = ip.b;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			/*
@@ -907,6 +990,8 @@ static long tee_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return tee_ioctl_open_session(ctx, uarg);
 	case TEE_IOC_INVOKE:
 		return tee_ioctl_invoke(ctx, uarg);
+	case TEE_IOC_OBJECT_INVOKE:
+		return tee_ioctl_object_invoke(ctx, uarg);
 	case TEE_IOC_CANCEL:
 		return tee_ioctl_cancel(ctx, uarg);
 	case TEE_IOC_CLOSE_SESSION:
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index 456a940d4710..1f3e5dad6d0d 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -83,6 +83,7 @@ struct tee_device {
  * @close_session:	close a session
  * @system_session:	declare session as a system session
  * @invoke_func:	invoke a trusted function
+ * @object_invoke_func:	invoke a TEE object
  * @cancel_req:		request cancel of an ongoing invoke or open
  * @supp_recv:		called for supplicant to get a command
  * @supp_send:		called for supplicant to send a response
@@ -108,6 +109,9 @@ struct tee_driver_ops {
 	int (*invoke_func)(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param);
+	int (*object_invoke_func)(struct tee_context *ctx,
+				  struct tee_ioctl_object_invoke_arg *arg,
+				  struct tee_param *param);
 	int (*cancel_req)(struct tee_context *ctx, u32 cancel_id, u32 session);
 	int (*supp_recv)(struct tee_context *ctx, u32 *func, u32 *num_params,
 			 struct tee_param *param);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 7915e8869cbd..88a6f9697c89 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -87,6 +87,11 @@ struct tee_param_ubuf {
 	size_t size;
 };
 
+struct tee_param_objref {
+	u64 id;
+	u64 flags;
+};
+
 struct tee_param_value {
 	u64 a;
 	u64 b;
@@ -97,6 +102,7 @@ struct tee_param {
 	u64 attr;
 	union {
 		struct tee_param_memref memref;
+		struct tee_param_objref objref;
 		struct tee_param_ubuf ubuf;
 		struct tee_param_value value;
 	} u;
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 0e3b735dcfca..9abb0f299549 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -48,8 +48,10 @@
 #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplicant) */
 #define TEE_GEN_CAP_REG_MEM	(1 << 2)/* Supports registering shared memory */
 #define TEE_GEN_CAP_MEMREF_NULL	(1 << 3)/* NULL MemRef support */
+#define TEE_GEN_CAP_OBJREF	(1 << 4)/* Supports generic object reference */
 
-#define TEE_MEMREF_NULL		(__u64)(-1) /* NULL MemRef Buffer */
+#define TEE_MEMREF_NULL		((__u64)(-1)) /* NULL MemRef Buffer */
+#define TEE_OBJREF_NULL		((__u64)(-1)) /* NULL ObjRef Object */
 
 /*
  * TEE Implementation ID
@@ -158,6 +160,13 @@ struct tee_ioctl_buf_data {
 #define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT	9
 #define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT	10	/* input and output */
 
+/*
+ * These defines object reference parameters.
+ */
+#define TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT	11
+#define TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT	12
+#define TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT	13
+
 /*
  * Mask for the type part of the attribute, leaves room for more types
  */
@@ -195,15 +204,16 @@ struct tee_ioctl_buf_data {
  * @attr: attributes
  * @a: if a memref, offset into the shared memory object,
  *     else if a ubuf, address of the user buffer,
- *     else a value parameter
- * @b: if a memref or ubuf, size of the buffer, else a value parameter
+ *     else if an objref, object identifier, else a value parameter
+ * @b: if a memref or ubuf, size of the buffer,
+ *     else if objref, flags for the object, else a value parameter
  * @c: if a memref, shared memory identifier, else a value parameter
  *
  * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, ubuf, or value is
  * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
- * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYPE_UBUF_*
- * indicates ubuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the members
- * are used.
+ * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, TEE_PARAM_ATTR_TYPE_UBUF_*
+ * indicates ubuf, and TEE_PARAM_ATTR_TYPE_OBJREF_* indicates objref.
+ * TEE_PARAM_ATTR_TYPE_NONE indicates that none of the members are used.
  *
  * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
  * identifier representing the shared memory object. A memref can reference
@@ -442,4 +452,23 @@ struct tee_ioctl_shm_register_fd_data {
  * munmap(): unmaps previously shared memory
  */
 
+/**
+ * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted Application
+ * @id:		[in] Object id
+ * @op:		[in] Object operation, specific to the object
+ * @ret:	[out] return value
+ * @num_params:	[in] number of parameters following this struct
+ */
+struct tee_ioctl_object_invoke_arg {
+	__u64 id;
+	__u32 op;
+	__u32 ret;
+	__u32 num_params;
+	/* num_params tells the actual number of element in params */
+	struct tee_ioctl_param params[];
+};
+
+#define TEE_IOC_OBJECT_INVOKE	_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE + 10, \
+				     struct tee_ioctl_buf_data)
+
 #endif /*__TEE_H*/

-- 
2.34.1

