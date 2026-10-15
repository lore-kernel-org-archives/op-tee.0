Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11770CC6B3C
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:41:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 59B2B45340
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792064465;
	bh=9uiJaJ4e2BvkUloOW2tLoZeTSbF9MZs2h7FS104pW7w=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EsqvXMvNN0MKu8yxxORY/q+hmMMj4c9vRTbrnebqnNgUgPY6aIOBccadN5ckbcEct
	 0QVBgKvG24e4/h4FwD/0mBgVDORTXriFEQjqjpver0X3JAIgML0jCNQyhwYs2uy0N/
	 f9APsHHSmqvMAo6JrtwLYtjZTcS3o+TB1DdhvO98BiIrsvAiwOmdyXrvxfPJN0tyYu
	 qX1kGopu3lgpQ/ZzAEFv4DX3ukhQfN2zFpnx/xT0qwEE7GWB/pP+XiaHGZdsymbxKq
	 OizuvXO5TPwjfN+YbCd/n6T21oaVQHJD6tHAdoxd6kcqg7oxrvMLRXS49C5GOz+/vo
	 9ZNGhSLpHMA9A==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5314445301
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:39:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jvz45mmC;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J1Kh7oiL;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jODd2114144
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KVvQmOi35PVuIVlVsInax0HmLCBph4ogykLGZROUzqw=; b=Jvz45mmC7KeRae1m
	LASzFUuUyxAoZAQV8Nn0pCNzRLDHCfj5PPAnm4ZSh+gIEfyknqYnlpKHpTVMu5mu
	t9dkkMqxU2TGeEoLqdiDxAGrzJuUQwmRYiABLKqGAZ49lUeHZYdnz7NKMDiiqCtc
	lQO+3ZzLEbojFq5T2m0NP9FVV5xD9Ns3pworJjoWr+8JqHfGG8nd9+H5TuvYJW/I
	QC8ZjfvWmUQa7/t4qiJx2wlTU07KD/VjVuVVC5zTSsFPyqwJxREYIV7xblJ48Jnl
	zAJfpZ2u6Aml1A3svS99+QtgebM8+60UPBWq273Cxp1ZbPGpypS9oNJcIUSCs67u
	2sLmkw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmyaub7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:39:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3552883bd19so10783299eec.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792064396; x=1792669196; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVvQmOi35PVuIVlVsInax0HmLCBph4ogykLGZROUzqw=;
        b=J1Kh7oiL+s7MHob5tjRE+eH3I1LHiIOx5le4tiMU2hLV5z3InVnV1RVXK+2Tjhb1NH
         HSb0UwG+dNUIdQpy1AJ4ZZVdm0WqzKTG9rt3b/yLfrTmhJ8lFOYkz7C8/9I6p60AOYJS
         sGQnumVEuTSUKMux73Ejo2iCwyKbr5UNf678Dr6Hrx/T1Wvjw32FGXZVeIXrniitZ0y2
         iNHhYLPRmTvxwqlV9aqSZcoXsUjSHqKjXUzVZ2bpdYwCYIiEj0KRAjapzwuhIojuOsd3
         38HyHRLzyCtazfPF6NkB1FsgrpNN6/H7UOAWvQTd1MKfNN7FSo1FWVOI2DsR9Q0fm76n
         isKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064396; x=1792669196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KVvQmOi35PVuIVlVsInax0HmLCBph4ogykLGZROUzqw=;
        b=0K6XX0ai2cu7zwbtdyDY9bgciqXWB8sPJfHdZP0Nhp4plJWCGvhjwml8mzXxNDopLL
         37bQTO1Dph5A+NLTO2ka6iilkBb8N2FsBk/6cmraGSdaKgnkO3+QJ/nw3OG2paX7FvSq
         6s3MrRecpDZ1uHgGZHD/7XBkLKa9iEuGFTsmFFQ+EPiaczDH0Q2Ynax41FakiSOVHu7v
         mLJ3CFGHDCTes0lRxFiW+J4McbN5rmYfSDmD6GVd3ntIayyIfVSzBTcROH7Neo4+1qTR
         m8jp3yaDQNgKlhLFzAKXGR5mfvOR7srmA+lvEAiFwzsBc4uvX0FQGqCTfhSe3b3lucyZ
         fY5w==
X-Forwarded-Encrypted: i=1; AKwUvBwF+VVzhnceuksCcEvRAlcYJXDMbLS1OevoI6MPYDs/Q8oBOvr1DcpWoL/mPhGSPMtL6bgqPn0=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLzBmJAnrg/bHOwj3DAoXqNuCl+LQ1jgZlalFEyi8ALz8FKjut6
	lx9tPC/JXXx7lrdEfMJyNdhZE4DR+SkpmADbsMbCzouH+x4rY6+O/v2vugb31KM8rJVxI/LrOw+
	ukrCpbaQnAKja5hc1hyCDexzLc/VJUaRIf+sOue7hNOxONTS7mE9sZotxb+s2omvMa7ioTCrW
X-Gm-Gg: AYBFou1dmhHNrAF3Q8bg9boW1m0GE59PB2tffGifjI72JbrCiIQoVDIdQD7Ww7hohxq
	3xrpFzS0xQw1OHbQhnXOg5O0lzNhGbpoRGjxbf4EWFFTxTPd4kwm6v+DPF8PssGWZbRS0oDO+sq
	ZYnX4DxoVxt/R/b6laFlL/ser88BIbMCQDD83IZK8EV2cEHw/T8HmImy4n3T2RN+95HPkDT3oqi
	bFAwauYu1U4kGemkYHmRtFTnFIXJm1cpX/0M1UQgHgHQyjtMJ9Ti5EEUN8v8rcTQS+bePQBUJ8E
	pdbr+KT74A7hNAzafrTZi49PE32TUwcxhaglICN7gd35cZQ+2SdbDO0Ed970CigvOPYlCcig6HW
	3tY2CGWOD42+LoI6q5pUK5G8SCA==
X-Received: by 2002:a05:693c:88d9:20b0:35e:a117:8fd8 with SMTP id 5a478bee46e88-35ea11794a8mr4574847eec.17.1792064395614;
        Thu, 15 Oct 2026 04:39:55 -0700 (PDT)
X-Received: by 2002:a05:693c:88d9:20b0:35e:a117:8fd8 with SMTP id 5a478bee46e88-35ea11794a8mr4574807eec.17.1792064395019;
        Thu, 15 Oct 2026 04:39:55 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm48144891eec.11.2026.10.15.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:39:54 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:09:36 +0530
Subject: [PATCH v5 2/7] tee: Add kernel client object invoke helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-2-1460691b35d3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792064379; l=2705;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=9nwxakqFfP8UgReOaO2Eea23hTqKM9MMPIlUczN1Z6s=;
 b=UkRJN8bSt4b6EnQU3ubL1ILyxwuJS1HWSKjasS9fhq8FDLeNUuFaSzuD4TdzGcB3vXDyV6Xfx
 YOONo+3znsXCwiTMUI7yD+YULYAXW620IDo/7pWVgHu5Li05FEmc6wc
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: dN4hR2azOGK0iJP-qsnQPZt-dnCBON6t
X-Proofpoint-ORIG-GUID: dN4hR2azOGK0iJP-qsnQPZt-dnCBON6t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX1n+y7beeRP6l
 nt4rvr9ihC3eMf+w4inttrlgRn2wng0VDr1LIW2zOK9Qt2mzOx2LYMIWaPO45WzUDwd5LBbUnEo
 L3GK9wokrhiqah+F329qatbqq5DUSSM=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad0bb8c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kr-ihz5DC76VLKRVsLUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX8985kbsubLwL
 O9ErTNPaj0Eq4b8Hnhi1PIVVhG7ICZZxe6njlflJYF0ggfrddzAlYOJm6J6i4dwyag822DXSS/O
 AxvhV1sUuVNrc1MDbnQybolrSloKzuHZu3kiZoaNnvKyPz86VIalNl2FSZYk/DQLfvHSFYazhzD
 rOHfbCkWp3eHBPDDmz/cfXtTeHj3yyRBi8mwa7BXwj9ypSqSLEeEaF71+H3a6olh8NpUB6h6z0h
 s44z/pPUB2nuXejL+NzlSzjCj9yNJ7INOIbSXVenThKlPTf6R9HoPvL/hVJt4n0W17mZyBAvvY1
 EM6rixKk8m6RN9NehbFWOg6ZIMKS4wToG+KEXjzBsY+MhQCfkBlskOKCK7A5O/GNSZVT0QjVOsu
 ZBgI9rNlL/z56iOcQcdoSpOgyxqs8LuIk2KfGtsP8pgp7U1kKHZp23oK5T1IAu4dhxBu8tJg7wV
 90McW6+TONkGkNoxXEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
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
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5314445301
X-Spamd-Bar: ------
Message-ID-Hash: ZJTO2IDHHKDFZED3RDV6ZJ6LUC7X4X6H
X-Message-ID-Hash: ZJTO2IDHHKDFZED3RDV6ZJ6LUC7X4X6H
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZJTO2IDHHKDFZED3RDV6ZJ6LUC7X4X6H/>
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
Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
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

