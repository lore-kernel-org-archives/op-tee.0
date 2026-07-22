Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554DDC4451C
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:00:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7D447451A3
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784703638;
	bh=25WePboOUIh0OM10e66E31TxP7xc6qwFaDOGM2WjvkA=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FqiWR9JEwjm268A0JuO3OJlA5/8sJBPjfVMdEnnI2R7zEApXS5r9SEnlr4dHqj8uZ
	 jvWVQFMIM/2/s/VTampYq8N7dssCzn398OFAXAYkQArNhMJ/r4eyojCpRwH2cF+3Gw
	 JmOGSWn9v+0BcHa0kB9u5z8b2GgQwWh7DpaUdCKyFRruVUBv1dMp+Jn3s1XrMDjeLc
	 S+0UUbPBy2F4qLrdMaa08OExnj76UW3aLPo8LrcZHAToCB5D0mB+PCzRRqqgUZQJ8Y
	 mtABT7ExkJpASqNNgeH1pF2aG4SDaEdLnREkc3dSKuaCdp1m5ye0CCTDRzef6SBCmi
	 CmNa6IW8RxPSA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4336A451A7
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MDjA985F;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kg5uHGY1;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53a0V3662156
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	31qc/02ryLxVGZE3W44tXTDK/BxZ/hQGixj6FDcU8hw=; b=MDjA985FTEihcs3X
	2wdY/g4MKqtNbHKn/0l7btgtoFPyOsqvr8b6MCDfonA+ut2Flz/loSIvW7Lou1IR
	2PHskQaiWFW9MZTt312VyXPBuwzunDZd6sdNWj9yRGz0y84QDfzLRfrZ4oZ3qATq
	ek8hXIO0pAHOsUZeL6fm2LxkpfINR0A4h5s5WIZ8gsoswy2KYlff1heenxfQUNLd
	z7U+vQbcMNI9T0d8ceVpnnUXEOlgEL78Nc6uxknaJGHROZ/eFKHepsq0z6aGQ1+s
	4lyAO2VVUNevv79cLlzvGEZeJ+/5nPguQgHO7QwFL8lrOMyVKutGxODVaDFG94u5
	SIZDfw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2njb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cea6a46766so189611985ad.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 21 Jul 2026 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784703585; x=1785308385; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31qc/02ryLxVGZE3W44tXTDK/BxZ/hQGixj6FDcU8hw=;
        b=kg5uHGY1aWkMUsooi2h2+S6cbJfu5qzAR8BQwS8hJygO0OQ5FBra4JMspJ7S89OcIl
         hel58E0l2CYUG73EYxSVLXVj5JthhD+2GJIhcGeU33+RCDyQvLOVTUcopLKNQnapNdYi
         EnEyTOB8ANsrp/QH5QRC0HsefdtP9W/wNLTbUiJKHRgkD8pwMSgHbjdziCGCsCCeXuJX
         JtM9Tr2DzxBoqN88dxJkq4i7+GJCKLy7u1dV9dqNesOUE1BLjxFoSIopQGcqVigvycPv
         aS+cYcTniNKHksWkoydpiulgDjr1u03aWERIzCrKgzJ/pNx854QtzIaudn062dhMKqkh
         C49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784703585; x=1785308385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31qc/02ryLxVGZE3W44tXTDK/BxZ/hQGixj6FDcU8hw=;
        b=HXCsGjq1ABABIplR5dDSuJMuI48fXAaA4EX85SYEF4Bs1JZDziHqHGXcsKYHwPg7s4
         JsOkvN6ohR/ADC8CeI+lXuiQyKYrswLpx1YJaUUFyyyJHggIHI7wOeuyzV4c9TqnzrGa
         Z9GEJjsrkIT5fTRBgpqJZ1FKLzArtua/By9PsWrpK7VBskrtEo3Fo29ZScYyxEd9q5eC
         eE29bXuSUj9nj6z0JKEavGunoKaaGuZIm6X3R5eWOdJk+Oq+/iix4e+srhn9j74+N+Yj
         bJbzSEpvjzjXD4FounuVntRUBWPYmEPBUxOHjc65DAxdGbBz1AQV5lng4zQyOQ1c39/6
         voIw==
X-Forwarded-Encrypted: i=1; AHgh+RpeK8gzH4KDFEvVtOoPC/7Bvrath+Ok5RCawLS9J6SeCjEARWsmuUkyk6PWiV2HD7QwrHdyOv4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyx98INTak96co2XQRt0hHOefZ16e1aWtOMcchTWWzvHYwWQ9RY
	YuGVRnYDBBkPx6IF+z0E2oiyT88vwZu3r7kz+pbuZN70hqX7yKRjdBD8XnLGEEgtK6gyAmhvBY3
	0v3OkdqWpfHUBR363i0/Lsf2gvtz9sBrz0ybRGLTqLHp0b85Nk7hb4d3MLnplc4LnYUh4Kc0C
X-Gm-Gg: AR+sD13l/0+pHWFykwiLxe7KukNLh2WJJPcQae1bQ1YeDKGLVvPEMp7Osj6+DGeR0YR
	24bqG/lL14XRdQF3KzFrNrHS65ln/rRSKcqwp+/8aRG3uA/oE5kGvi4sjOXkaWOj6nbSHX9EYCr
	x9CKSHXmM3cdSKyTfZhf2UlmwEECgD/lmDrSZngwa3YENz2qsaYKag1UvhvYBCwNUDa4nWCO7hV
	tpvTUkGJYjwhFPNozn4COUfljVmVB8ib7PRKneGAOh7DojzSvwhvxOBjh7xCDX0GZtAqwFj9Z9L
	w7OamAxZRq/nzsgk/skh7eHauAop/jqFnl5nq3oP+S9xjIDFZyMFIm6V5ee+pqe54BDmsJhZdIU
	qlaA3tlM68xCAEls3WkHfe+SNbQ==
X-Received: by 2002:a17:902:fc4b:b0:2ba:6518:a6d4 with SMTP id d9443c01a7336-2cf34906386mr240005865ad.20.1784703585379;
        Tue, 21 Jul 2026 23:59:45 -0700 (PDT)
X-Received: by 2002:a17:902:fc4b:b0:2ba:6518:a6d4 with SMTP id d9443c01a7336-2cf34906386mr240005515ad.20.1784703584781;
        Tue, 21 Jul 2026 23:59:44 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm9428935ad.22.2026.07.21.23.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:59:43 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:29:13 +0530
Subject: [PATCH v2 2/6] tee: Add kernel client object invoke helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-2-b8a8fcbe4211@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784703569; l=2583;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=CXt0mSkOb6Fv+NT3vb9BCSp9EdXlKG5hU1H1pxd/wnc=;
 b=Y2LJQzDplsNqP3q2YuickHd4qkJhiO33TsIfTfT4UR7bl6qIwggPUpi31T5kjH5TerPc+qXX1
 D/kUoMsA64yAkN1RPu42L90ss/hWblwUp9b7FmCCOHQllGUqNLRVmN7
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: OH7XpFQOuWUa_ywQ6XZA-GzHrB1yA6Kw
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a606a62 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kr-ihz5DC76VLKRVsLUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: OH7XpFQOuWUa_ywQ6XZA-GzHrB1yA6Kw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfX7t9yWOCswBzi
 4vl0j+wZJ//si2B1u6QGXGnXebPoz2HUmUXNnP+tqluOYqbUetkht8jWgPKun7gCjRk3n1wCLU5
 xjZTwinhACz9jUVMrCcifPj8N9MbgATQ8x6ttfwIz76NRY4SuVIT8A7iuXcqYdpCOPTmkD9wDA0
 1yZLHuPWXrMJjInXmtR81lR7IPgM3LiyLCxBSXTbY3rl26n/+G+79tZM5TdkXS4997YlL31nak2
 gfc6zGvynN1J4FkynBFiu6/86cOVEh90E494z2fAyKH0AnYswe5UDBNe4vu1exaj9QfHSYd5RdU
 nGlMPysf5WyvOUaElpFhGkxfSy3P+UEz6RdFYr1sp1Q17nreu9l3YIJa5W2qjbiWQB0akP5eZC4
 g/h0pNstgksFSUQXLTsufIHKJkOqt9ih9rEXtup80Eofub0zDYFVQx/WHBPFkWyHCcmCjqrIRzD
 ulXlIfwrLbI8qENt4Qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfX3pRY7TQIvXNB
 oQ01r2RWZWHFIYE2DXJIdKskh0ogRFzc0VwuuutFNi3RzJsc2aH7B8rOXTZD7a/QL9/mIl9M9LF
 azoMcXs3kWZ7cVW9MAksWjzshk9uWVA=
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4336A451A7
X-Spamd-Bar: ------
Message-ID-Hash: ZB2WM2OT3JL4HONSLJDGABDJLWGVISYW
X-Message-ID-Hash: ZB2WM2OT3JL4HONSLJDGABDJLWGVISYW
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZB2WM2OT3JL4HONSLJDGABDJLWGVISYW/>
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
index dba5d4d2d47e..bb418490f3af 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1410,6 +1410,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
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

