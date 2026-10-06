Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2542ECA5FED
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:35:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6DA1245481
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791286512;
	bh=Rpbjn0YNacV1Aifz97E1Ai2mwQ/oNPnx/tZLiOWYIw0=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=NJ8H/tQQHvyy6vE8uupAgNCCIk9eblLaMJy8WFy5Yhs6uBJHrzsZBwOG2OnsRd9VB
	 +RWM0XVzQzkYfyKkb/DZYk3L2pcAaaEksuMWdNh9tZJcGNDwF+rQnbw6pyE5qnf7Et
	 3WuywgoxYdw4eCfv9M7vDLmDV8gPvrEUjrmYx7p/hmJ6QAa3GEk8EZ7kn7UqV9lOzp
	 rOQ9AIS404XR48IZ+uxfXfIhYZ0A4ahfK3zYGT6YdvOMO8xWrW1loX4rwbK40OntZX
	 KvVFeh2cpA2/yI9jqeiR3PFlf9ozPmaITGaZ2x3EhTzN8ZqMev4PEMdPUgTp0QbGFZ
	 hL7d3uQVTD2+Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 50602454B1
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 11:34:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hqK/WKgw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5/JN9S4;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPNth1172355
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 11:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KBx7DSS4OAVf2q7wVxZqqxHfDSq45aHtmPOJDnt8KdU=; b=hqK/WKgwFi8KBCv6
	i/2IQxUsEpV0EFxkTsQYoaxtDJCTEZU4VvBibb5yzRF6nF1Ue4KckPYTmDsE0dTa
	+j2dENYUcE3d0e12Flazw10Z6xVCblwgyK1lryFTtfjkynbCH7MdJ0zO9BnmkVYX
	qNP84mVCcZZpvpT8UOjbOi/yRv8Uq1pWzeiWOSpkRKdQ4vSXzNwdU6uS09Hl/LlG
	1RCZx2lcaGw/7fhjvh3QahNJg06bGtDYuPzUZTqkzd1n1xpR9/q2MdnX1Y1yxF/O
	Lq4GYCSt96w6XHMEX6uKIDUc2yr4U0gxQKwCGnMos8m3l3uYYDoaucRmCSpUz/K3
	ewM0Zw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xwwr8eg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 11:34:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so4181303a91.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791286450; x=1791891250; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KBx7DSS4OAVf2q7wVxZqqxHfDSq45aHtmPOJDnt8KdU=;
        b=W5/JN9S42KjA4rsK/Iva6arygw3ZrMYrXcnUOzivIlV07/o0rhhyTArtalzgRRcFez
         q5wFkM+XS2pCywOxko97PTbQZpc28HxX/QaTAyTe0UegecANoG2WGat6os82KnN5HXWD
         qD+sXWweQNMR/vKU5VHuUVUEJZJCJ3YeAR/52pr3OLMVV6KmkuhyBOQw/+fynAXqNEmY
         ShFcBzKRHC4LeC/0uCJG8oRX8M9dV3drYE4yGKvWfuFzNcLpwQURj3OdTX81ZzUgmoko
         f7w428Q2oVOS7G+ems4G5cZ/3VGRi8TO9UZ5fj+7RF49+Vk5TFLnC+1rEgh7ZrEun2Ic
         9pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286450; x=1791891250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KBx7DSS4OAVf2q7wVxZqqxHfDSq45aHtmPOJDnt8KdU=;
        b=QbWW8ShypTb3c6ll3i0NSvIaCphlQGE1R0fm4zOCh1tfJR1S1iSOe3Qj92+XZTThF3
         B9Ci6PmF+WVAqv9eqQeL4lV2GYOo0xr9S0CcazDL1XTym3n4ucfrSF2UkhtaXKznx4Pp
         0V0CCveG7TJ1CNUIZ808DrZBH0B3i0TaREFZZJR5jR6mBNWSAsbsgez+yE9VJIWrnlvV
         TT+NSF9/BjkuwSWETDIueFJNeyQOQMX9n4voPWfQQ+x9AbEiuzDq3zt41bvy//tgifa+
         X9IfGFliGAfFSMNx8EveffUn5g+heal0zJLzFkaSU5252eZtQJfDIOTFV64JsI0vdRpB
         GCHg==
X-Forwarded-Encrypted: i=1; AKwUvByxXV+dA+UIrXISe3yj027Rsv17GDLSmlsPygeGl8GAsDi6b3jKS7DZDd1RXVmIUpCQ+gV8u3g=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYI2N6E76jo84dkDWRvo04wzZdbOo94KO27kT9HwtFXuIvTAfPRq
	BUkClqU+vioMJiIg+Hqz6NWM4z7oId+ZaKGwS1ksJUAutDOpxiOrpjWogJu3lhQVzIYl+y9yTcv
	fys2+b5U/4pHrxiDsTicgdauJaqJd1OdRnDaaHaNF93Un3M+dKoFZR4B0k+bW1zQknYaUyabC
X-Gm-Gg: AYBFou3JaPU1yU7jki3DfBcQu3jG99cdFACMg62/lw3no+xXRT6qNAw9aFt+drdTIJ/
	PcERwRMdudY1L2rlxTKOLzy9jERXUh5mDfJwK7A7Zjv+oo5M0bbzr2p2A5BGvatj++T0lB6ksiX
	9iHRyaYS/Q/2jE4H+oM43rd1KhVHS6CllVfFnRNg6nze3Y7buGA+f6wvIbNAIjKl0w/fPC26Qk+
	dZOF8qs08P52CloDiYeUuYSZHusPMyUkShHY4semlLAOKhFGSAvtJIoxlRrKoSE5+7LJ9qNdjbB
	gr/Sf/4AyM6gthuwlHSyZVLP/EOn9E5jIo0a9s9dYRYXzO9zaSCmdAT09LX4kmnDauERWBUpHI9
	ZMGws5TpHBJieEakWM8nNSdFj
X-Received: by 2002:a17:90b:3e82:b0:39d:f4a8:75ef with SMTP id 98e67ed59e1d1-3a872ade7ccmr899942a91.1.1791286449444;
        Tue, 06 Oct 2026 04:34:09 -0700 (PDT)
X-Received: by 2002:a17:90b:3e82:b0:39d:f4a8:75ef with SMTP id 98e67ed59e1d1-3a872ade7ccmr899925a91.1.1791286448939;
        Tue, 06 Oct 2026 04:34:08 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a709a4e80bsm9330092a91.4.2026.10.06.04.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:34:08 -0700 (PDT)
Date: Tue, 06 Oct 2026 17:03:23 +0530
Subject: [PATCH v4 2/7] tee: Add kernel client object invoke helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-2-bf1c8e2a64ab@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791286430; l=2638;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=Quti/9VlUblrcTksx7XZhJmH9kVP/PDp+rrGqRHsdVw=;
 b=J9ElpovhGgPaipJFN0RwR9Shmw8hecBUpv/Wb0IGyeRE8PiDgfKGEMqTMkuxmhTrMSxW2xOXH
 5RfTpEUkC4tBmdXXaWItMlBxonu7im7mtgsRyLAyUtT+2ARzd2/76/v
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX94J2Vo/rIxBJ
 3XWI7tFeFYOfNkoutlYbYVmJH8dCHoajRxb1KML2MU0JrM6pXxBtwuj+Arz0WXfPHqg0E68I5gB
 dfR/Aj7oiv25w7vXrSXOkFBA2bjLxqyugp4yUxZe1+8MxSzEMQbL+sftFzHbML9XxPnKZh2DOQj
 1HUO/+kl5pA/GIDqFWvw52jCCxKfkWpmvdqgT6W3sSaycpsNBNCfsnCSJOE5LmYlBMDXri9TD5a
 ljt+rDyQOFoH24S+Jny7YZ18IHOcUsERabuEqogia961tAURJGOpLii+xotikw9iQb/h2asMT7a
 d1pmlRhGMothA78+XV2RaiSvAev4v++1ZSNA0FtXp76EIz1rJecAoZIHdyOO3COj2GU8zICxvDg
 uLH54hl9N9HU4D3mQ4Aus6nld8kG0NRQVvU0X4ruRmhRLDpfRT+MV4rks5B2N+lYelEdeOY7Alp
 /Pz6YWfK/68ABb+aSXg==
X-Proofpoint-ORIG-GUID: k-IcGEQeiRNUoGWHG8Uq3WpvavduTrNW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX+3pk/aCf9fpO
 600eGHtspBoC4S/sFM4Aa+4yeS996cI8ha5wKUup3OvhmkXht9IFpgj4agioYQgiIzvtcYtg7MP
 EMgwHNS/KbYUqrKAZjrJodmjLet9My0=
X-Proofpoint-GUID: k-IcGEQeiRNUoGWHG8Uq3WpvavduTrNW
X-Authority-Analysis: v=2.4 cv=SJXXx+vH c=1 sm=1 tr=0 ts=6ac4dcb2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=kr-ihz5DC76VLKRVsLUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
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
	DNSWL_BLOCKED(0.00)[209.85.216.71:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 50602454B1
X-Spamd-Bar: ------
Message-ID-Hash: RQ6JSCDCJGH3QEZVR34GYNPML7LOBKSA
X-Message-ID-Hash: RQ6JSCDCJGH3QEZVR34GYNPML7LOBKSA
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RQ6JSCDCJGH3QEZVR34GYNPML7LOBKSA/>
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
object_invoke_func() before forwarding the request by setting the origin
as TEE_OBJECT_INVOKE_KERNEL. This allows TEE backends to support
privileged object-based calls from the kernel-space.

Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c  | 12 ++++++++++++
 include/linux/tee_drv.h | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 30901390149c..a03a3d645dd1 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1404,6 +1404,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_client_invoke_func);
 
+int tee_client_object_invoke_func(struct tee_context *ctx,
+				  struct tee_ioctl_object_invoke_arg *arg,
+				  struct tee_param *param)
+{
+	if (!ctx->teedev->desc->ops->object_invoke_func)
+		return -EINVAL;
+
+	return ctx->teedev->desc->ops->object_invoke_func(ctx, arg, param,
+							  TEE_OBJECT_INVOKE_KERNEL);
+}
+EXPORT_SYMBOL_GPL(tee_client_object_invoke_func);
+
 int tee_client_cancel_req(struct tee_context *ctx,
 			  struct tee_ioctl_cancel_arg *arg)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index f3c5e106d853..369c87ad0205 100644
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

