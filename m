Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3321EC43458
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:13:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 74FAE450AE
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783404784;
	bh=Wc9YPOH3gLSEej49AwWn9+hi7hpzaEhY0b42nssqRJ8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=HH7YI60B3yJIbhqzJbkoZhmgAzBIweTLNyEJBXC0k3jYGhXLgN62kUlki7dtOo0OP
	 xScwgFiI0gIX4iPmW8vkugn8ptYsHJ1O0CHSGw1c+9AAlLS5LACT4hztHJ4EjiYjVU
	 JG31pT7uRkm+7F5PBu0vAswjgJMYWfI/yC6G+rL3z7KfTBHLEpm1jHtln7M08tRq5r
	 AswSzPIZNTE9Wojsr9wgstkFA8Ty06+XulDmNp+14kdwSYd12COM/05OHiQ6rRAjaC
	 1Ezpzd+EMAxl2K/FNKzhjM3ckf/WLScXcZ9Og7PlBQ8USMvmaNd8nYYjRAGQ6hUzF8
	 JMcLVCkBp18Sg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 77CC9450B6
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Jul 2026 06:12:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=idgrWUyR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d7Iyw1AF;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667490J42688450
	for <op-tee@lists.trustedfirmware.org>; Tue, 7 Jul 2026 06:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fWjDybI1o5yT4eZXIx3vUFWYnFEDkE2p45bYzyDGbmk=; b=idgrWUyRiRio27T/
	K/6iOKp/cti3Q9jNmV3NfZOAADb4wksGVuiFrB7L3FU2M0pZZWx6WdXUjN7sVP+M
	oNzGO4RxNL36tDLHiKxUw6DWeaI2MdMjH9eNCuUu/gjt7+jhwjZ0x9heKrqtB5zJ
	o34yg/OB7s/9oonmpuJ96flxRDDpm68GQh68L8zXzgHb21cWoIbeHOkmvma6El+x
	W1DX/hsZ7CApcDTCgQxS1BDHBk85yfgrFzL5+ts14QC52Uxpe8zr6oyvaYKqhCEs
	m/20V5i8UJOCFt2obTbbWye4b28FAYZnvgrEFr79QHVuGtT3g3te+iIA48p/4YDp
	9rfOQQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gvetb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 07 Jul 2026 06:12:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8478ff5d801so7119226b3a.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 06 Jul 2026 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783404728; x=1784009528; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWjDybI1o5yT4eZXIx3vUFWYnFEDkE2p45bYzyDGbmk=;
        b=d7Iyw1AFOjEhbcLZAfNKktr5F1fyCROsauvNv3imOaWETeWIlromRYe+bUZINv/H33
         JsZHPXGQ/fy1yvUz/WDnhl9om91VyHsC++oCFO2syAKkkYxj27XZr5IpglJ8OeCPz+1u
         ku2vV3vyMNjd7BQgRcbxRIf3pFId9+jVYu3JLPrvhWpXbXt145S720nuGZIY2HbQhuhl
         n8oqBD6WZzQlkLJ0507JcDzvQJMqTVjm6IYdulXjq22CiJU41jmf8MVv2m0g1T9YyNx1
         YUyy1B78UTpMUDfT9C/m85Fv9HwrBNpoPZO0xyyrCrlGXA9Ymd/OYtwKhT0Yow3ILeki
         jwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404728; x=1784009528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fWjDybI1o5yT4eZXIx3vUFWYnFEDkE2p45bYzyDGbmk=;
        b=KPJn+t3SU83FUwAY9bvdQBhES6aVxBX12QSCm2L4EEQIwoCz5b5xTvJ6oFoVQkGnDI
         oitte1BSy67TnElT6MOhAIIAV6SHRBNYr/hZWlVWIyXReHH6+HycXlPdhn7h7wctrjH8
         Rz2Cym71W8V07ya14UYezHJNZFQBoY3JjygmckGrl/EJGUWfyH5BOBxbhV1fvNl4UElU
         f9s3ApmEZy2T7oyvUrJDz0SdKxMa5PGylz2LZHMNhLF9L51s6s0sCeg4nnesOTNrGX8/
         gbvo4JC5d2uo+h9hJwcmf4iJaYFXSXD9pJLJByJKTDPf+HG7/DX1ipdwiD5UisFoEX/W
         yeWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFN95UPUet5p/YVOtiJqrAGs/UGa7VA+roMjwIpVgv+WInMfiZBupDxzke+fsgiX1Aap7S8bU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy/F5B2v1SMEtM4K79XfFz/0ELMUCDWkHEsFrw5BW/l6OvyKtzV
	ZYTd3MwXeVx/TYsmrg1cMwefpoHKvQr/R56cp7cWDmaxsoJd0Svak2migo09x4ANkH14RVdLWDC
	QfGEP9d1YDsv/eXptcDtX7njmtxQauTMglmD1XZeLxWif6ZK1G7eX2/d4Rn0pqCs+sNoVTeJm
X-Gm-Gg: AfdE7clI9jfisecO7jsh53ya7oKwOEQ4L9IfvoYIC2JmtITHC+AgjK8AQcGZvfKb93F
	qM6Hxh/F5W4X+srqc4G7bFeu4Bcs4HF2aRlPCvbnmr/OJStnZ19M8Nw5L8qoG+zp4959kNdGQ+E
	CP+fvBxKD+1BfECCTUYQqiRcYPREy2bU3jwe/02w7qOnVNVYr9EuUBI/DO5OpZJhyW4NSa8cfjh
	LNSqYAdjNSGK9GI7VaK97d+GLMc7/fJg6PksoTDgS1VUrP4HVVuptPpjlyRqatx7+O20UtgyIiK
	6XxZmE3JhMWoDENh65F0oBu6qgRzXTgUHj1AzVbNzTgLxtnE78vgTK0KDLdbm+SN7mqp8vqoQf6
	++ukiXgZLvQL10/qsL1ATUVMh/xTh/ZaOguiQ
X-Received: by 2002:a05:6a00:22c5:b0:847:9565:7a58 with SMTP id d2e1a72fcca58-84826df132amr3609191b3a.48.1783404728517;
        Mon, 06 Jul 2026 23:12:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:22c5:b0:847:9565:7a58 with SMTP id d2e1a72fcca58-84826df132amr3609148b3a.48.1783404727696;
        Mon, 06 Jul 2026 23:12:07 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm3299321b3a.8.2026.07.06.23.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:12:07 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:41:28 +0530
Subject: [PATCH 2/6] tee: Add kernel client object invoke helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-2-f659cbd5d04c@oss.qualcomm.com>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
In-Reply-To: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783404715; l=2685;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=tf7n4iBWfzhqdtN6PCm26dFltLwD/+JEiJW6BobHH+w=;
 b=0IoQzMoBgXd3Nm4jBsZCdkfR2D05fBzDzovrQrN13cn3KEMKvPOJfN0vDgLCztUzjcFqgIhc7
 lLxu+XHvEUZBlk8bJ7piE7Uf3oXHc/yGge+FWStw2kXrz9vPifX1jzq
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: GKCVHFfJSGunvJff-kb7irS8XpFGtGGX
X-Proofpoint-ORIG-GUID: GKCVHFfJSGunvJff-kb7irS8XpFGtGGX
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c98b9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kr-ihz5DC76VLKRVsLUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfXzE3GlwjhQi3E
 mOUQwkmIZ26roSmKsdcH7OHqtUAAdH6Ua3cAi+DXGpMmlA2r7SsvsLicEj5+keptfe3Ezf5qM9+
 R6dM/hVXSrm0iiXDyRVhf6qPBIJWbRUSheGfCpSvgrHwTsIqA2wAb+g0DtmtlgEFCoisb3JrA/U
 cg4RY9i6NmIwAs3nBMFIjwQw15lPnIau+anPBWrHnoCb+qgfw4BrNm9LIBUcXTaakfBxIgQdtxc
 oI8YZ1hmnS7EXOjYq4lSFcUYh2gtZ/UdViPqQ5fnTiGb2vRAA8A9Jh2gjXFQyWb9h5AHmTyyUWR
 idEmp+cn8xyXuETonlDdFY6AYllPnTl1suvYyhc1IGaGIOuDyNeHwEVRaLxQD/MAsn3aepteiUb
 iltYOsefxVKFv3jcPdwjKZ0ljufZ7xkNiyPpi1EzhFU8ON+YokgX0OuqKn8IA6VjuSryTRKe+Qj
 tiGhOXU8d6HprfRYRAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX8VNs6Q0rg5Jh
 mZkEbIpPkXdvxeAVLuk4r27QkHkb+xO2HsF/v+y/SccZpTC5IXBhpnkmPrzGkAXQx0yy6xA0AUi
 7AAVoPCL2kluIgwo9nXFkyoOcDflmzs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	NEURAL_HAM(-0.00)[-1.000];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from,209.85.210.197:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 77CC9450B6
X-Spamd-Bar: -----
Message-ID-Hash: 7DXI2S4SVLIQMH4LGZUEJHDFTYT6W6JD
X-Message-ID-Hash: 7DXI2S4SVLIQMH4LGZUEJHDFTYT6W6JD
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7DXI2S4SVLIQMH4LGZUEJHDFTYT6W6JD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Kernel clients can open a TEE context and invoke regular TA commands
through tee_client_invoke_func(). However, there is currently no
equivalent helper for invoking TEE objects.

Add tee_client_object_invoke_func() as a kernel client API for issuing
object invocation requests. The helper checks that the backend provides
object_invoke_func() before setting the MSB of the object-id and forwarding
the request. The MSB of the object-id informs the TEE backend that the
object is invoked from a kernel context.

This allows TEE backends that support privileged object-based calls from
the kernel-space.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/tee_core.c  | 13 +++++++++++++
 include/linux/tee_drv.h | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 7f986d7fb47f..0783802fd010 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1413,6 +1413,19 @@ int tee_client_invoke_func(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_client_invoke_func);
 
+int tee_client_object_invoke_func(struct tee_context *ctx,
+				  struct tee_ioctl_object_invoke_arg *arg,
+				  struct tee_param *param)
+{
+	if (!ctx->teedev->desc->ops->object_invoke_func)
+		return -EINVAL;
+
+	/* Indicate that this object is being invoked from a kernel context. */
+	arg->id = arg->id | BIT(63);
+	return ctx->teedev->desc->ops->object_invoke_func(ctx, arg, param);
+}
+EXPORT_SYMBOL_GPL(tee_client_object_invoke_func);
+
 int tee_client_cancel_req(struct tee_context *ctx,
 			  struct tee_ioctl_cancel_arg *arg)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index e561a26f537a..ca99c6b747a8 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -283,6 +283,19 @@ int tee_client_invoke_func(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param);
 
+/**
+ * tee_client_object_invoke_func() - Invoke a TEE object from kernel space
+ * @ctx:    TEE Context
+ * @arg:    Invoke arguments, see description of
+ *          struct tee_ioctl_object_invoke_arg
+ * @param:  Parameters for the object invocation
+ *
+ * Return: On success, returns 0; on failure, returns < 0.
+ */
+int tee_client_object_invoke_func(struct tee_context *ctx,
+				  struct tee_ioctl_object_invoke_arg *arg,
+				  struct tee_param *param);
+
 /**
  * tee_client_cancel_req() - Request cancellation of the previous open-session
  * or invoke-command operations in a Trusted Application

-- 
2.34.1

