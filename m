Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60889CA5FCB
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:04:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A386245222
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790852672;
	bh=JHVm623HXtSRzOgayEFKW9DRNqWXKZ0z7370+BQe0u0=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tXkTbtxD+yOByrKdo2pZVP+FrSNB9e/A23KNZ5UVsg4LgpJdjVNkZu1n1hcRXdyiO
	 Wl8EMhHn57osAKGpGbf8mE4YNwe+5HdBFySi1A9oNpG++mOkEEzlk5NylRhI981Sk1
	 g+AQjYSsQRmcgXRywxrGmSu6/0KNRKaK7o7d1hlGYOhmjUsbDUglkSuJAHuYkIk1Nc
	 JWppdqMZOVaN2d4Bz9YAqkNtKfW8u7WIFc/CtnpDmJODjBxrj4fpmel5YUH4qL9cMN
	 zZoaHIcDei/RHajEhsd5oiYCtOqlqcN6ecvVr8GD4Tr5ozmuWZ3puf74dCDxyibZLf
	 RVjyae4Qq+GYA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E460444EC0
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 11:03:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FfaECUiL;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DbZLlFsj;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xPR61062276
	for <op-tee@lists.trustedfirmware.org>; Thu, 1 Oct 2026 11:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XntUQam23skZGKH+QyQl8/V6moXnOa0k73qHOQ/KFB8=; b=FfaECUiLmYJxBeZ+
	2dvWRusiauQsQAdthZ9XymEiPk1UBeJ7Or9v0fs7x57jjJ0Y76kh2NwoHwcaK9CD
	m+kyZPXQRX5lLCsMX+Vrk8JZScBtpHLGBP2+zSFPekTlKJRk3EhkSKbH2fXc4+d7
	I7TCiGy3Cd+j/iZYbHx7pSbyUfjqWR4X1VD1iDewtOxKiQRzfwRhK3m5kLQs29Bp
	WZLHmKgu7gGVSPyt/vPVBF9+q/HOcAbnxYHyeeamIwDmrnY9Bsrku0V27v0I1Eza
	vQ0mDLqv3W9za49ZRqAQ7PUUP2a1waHrRcO3vVmE6XehvdUCFpoAmPopeTDqyBD7
	wAfcAA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvuhc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 11:03:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39533bb224cso8991387a91.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 04:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790852591; x=1791457391; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XntUQam23skZGKH+QyQl8/V6moXnOa0k73qHOQ/KFB8=;
        b=DbZLlFsjTMUGpCizI3Q18qcVnqvN2yTK0X9UVzGHcX9r0RglHuSZirGDMBPvDI+6Oq
         4pPL5r3j/lg/sDt/Qk5Upd3QJNwYphZRcvys3bzoVQYkuMay0F6+gS9i1WXi8PZ85YBV
         fntSSjztsh6SAMoLcHrM52adgiH9WfSO/UN1DosWpa+J9+sh68DCwIhgYVd+ObnBI+87
         QHCQUrhu8UdsDaWRuKM2tvQvq9eNVmdOh2JtZ9rf3HGYmtYMrjt4CWDSBw0PcDqxChNw
         DjPs6pvB5a49k0R5aitXfjzJkVOsjibXKQad2DV3q4kyOt4SVTs050b58Li23tO1tQ0W
         1d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852591; x=1791457391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XntUQam23skZGKH+QyQl8/V6moXnOa0k73qHOQ/KFB8=;
        b=20LLj14bFSJ9sjWxmcw1EhYwBYXVSXGfO6o3aNW/adphB02/v2Ah4KMcEEbHgfVJ5t
         v9utTnkh7+qTRrkXTFakP7dof5LS8GPw1w28xx9SGFUaOsD7/8bhS00GttMTm5QF4mDo
         4OnQqNK9yCmxjXDNOIdBuziX2qE+dRxlt1qjQXBN6t9tXCgaAPeOy4zULruTDRy7l6Jr
         2ZRtAvsnuHcc+Yr7a3Z7UfxuWiknDieHA3DZ2mUfRMSM3IMRu5ra8Kty8l8eatI+T6zG
         EHSEBWwcLgK/b6DyS+6Q28UOpFdXOvgPAf9l9ItGAIGmKYssWJYlIzqGo02ZLYeyC3fk
         7lPQ==
X-Forwarded-Encrypted: i=1; AKwUvByCf0Qxj9Q58WPF0MF6AF48I0yNvigRaD0uJXRXQ5FT7F10p9MFKAaEBf+EEn/VFgt9AxEu5Bc=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJmfOCPAJd9tjibXfod61ptW5W5jCBmC//edWNGguZnbr8mFOCz
	+kLTCRxDX0XM6HtFTqleSHa+lNQQFZ6eA194VofceWuqJbZTYwGJZ6z5d73Hr+BFWw9hS03ypWw
	a/4vRmhj2kzmXHdpPi+UuS87yzoUi3oPI+dGEdNwGYY2/JL/5evVDs7oTZI6YFM+zlUQmopxD
X-Gm-Gg: AYBFou3ZSAn9ktJlx/oHB46RKAGtQ+bjbE/EmrkcrXMrmrtmjUbUKFmKHAEAigzFOuE
	YCWpR4QJRJkb4+5v+JZl9OzKuSym3xz1iDzqWndJ5czq5mhbTPRTHxJEIYRmVJ+7WNwabQ864OZ
	iH2cYCpN/yZ+ThqWvgEx+BSgi7IaJcedeRFtCZkC9Lj5EJ1HxY4dNl8vldPr3FcFzbc5ja/qPRE
	kiJ3Mq5/qxnlm8jn2FPo6P/7cp832WGnVn+93Sa2zQmkyvymDjk7kEuk6y7MeghCgDPfQgSdlAq
	3tzBOoT29hrV+UbfrN2bV+XrSjSxzV3MOPD2bJ4VsohVjToQ2Whx7icRD/9fCMMbXmTPp0zlbPG
	WHOHe4UItiFQNocJciin4fftRTQ==
X-Received: by 2002:a17:90b:5112:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-3a4d197a4e4mr3168751a91.16.1790852590805;
        Thu, 01 Oct 2026 04:03:10 -0700 (PDT)
X-Received: by 2002:a17:90b:5112:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-3a4d197a4e4mr3168713a91.16.1790852590239;
        Thu, 01 Oct 2026 04:03:10 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4371383sm4076810a91.2.2026.10.01.04.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:03:08 -0700 (PDT)
Date: Thu, 01 Oct 2026 16:32:34 +0530
Subject: [PATCH v3 2/6] tee: Add kernel client object invoke helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-2-13df5c20c2e3@oss.qualcomm.com>
References: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790852574; l=2583;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=WCJlW5OePMWJUaw3c5FA+6JIuIBWmd2hlhsoPKjjx2A=;
 b=29hTYULmYXIKZGnWBOmfStG6tcxeab8zHD7YP5bg9KyClELhOujE7U89txdks5qD7a1XRa+9O
 heiHfJjra82DtbGzkDjfNhMwCE36TCGvcjEOI5wHKClC7T55UuN8GL8
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: TY-065lzVPprtx0-SL5U0SN_LKr7Ilkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX5Frl7sVu9pg0
 BJca3LCLAbQeAA5cF1wD9ErcTq1FdbHtSECebNv4LDDU5+5WHuBBoBCey3AOjxN5U20vXy7vl0O
 WNPmfWKOMDmK13IHGEoVaTxq6UVmmmBVWjxPAYcid48RjNmyhws9GYsc+HjoUtWeuu7IqX5vIvA
 ygt9ujLKravRfQIc76uOcnQ3xIFcyuvx6Q4Q+BghRfvYTBpnfylxEa/Rj0Y9o+bbmVthGgIq85+
 5bbY7xwROuZyQjeXn3l7OpvIvtJGrzueiBKYGl+Go5ZeiQrGHszL8CBxC45HdahxcP+oOZa2YV2
 XkyLgFxcwl+/JlypvkqNy81RSZQjkb1+gd5XPeapCU2D8pXbGQmw0m9xLbP2hqC74/dn1qW8hBZ
 jWNmCMkSUgFI3+VRoXiiuxDIX4sAZEz4i/j6zkrzHelyM+Ogq5K5+AclbBj/RZ4HvLYLatFfAA0
 VMOLcYzSrcUJnxxHASw==
X-Proofpoint-GUID: TY-065lzVPprtx0-SL5U0SN_LKr7Ilkl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX01v5Rrh6rJBb
 9g/rs4bkEYc9uoGoaclPKa7iSZKCvWCq/J0OPlz8xmM5Y1XDGZ0WJJ74QEl0hoyt/HLXPHVfy8F
 DSJZ9+mUedBe0kelhOzlyPg1V9Y7gzg=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abe3def cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kr-ihz5DC76VLKRVsLUA:9 a=QEXdDO2ut3YA:10
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
	BAYES_HAM(-3.00)[99.99%];
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
X-Rspamd-Queue-Id: E460444EC0
X-Spamd-Bar: ------
Message-ID-Hash: FFOOVT7MJCLP4TEQ4LVW4MHFAL5J3P4R
X-Message-ID-Hash: FFOOVT7MJCLP4TEQ4LVW4MHFAL5J3P4R
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FFOOVT7MJCLP4TEQ4LVW4MHFAL5J3P4R/>
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

