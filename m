Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5391C43458
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:14:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3D15743E5B
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783404862;
	bh=an3gXuk4A2+uvHpWTkRIawSelkiuFs5doNcyQWtYbNw=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=1ZHorfVw9qMa9HYgIiUZcmxi9Q6ZJflCmZSVlehX0b/J64FDDM5TjhCsZAQ5TZRom
	 QMloFXV1PH/clIHzk3xkEhUhyMgCGYGYW9c/RHrZjnPk37yzrFaaR06iWEP/hkKxlT
	 ro4EVn4XMs0+RdpDe5vrzaWunaLiCXed79Wa9QFM+rmqyMAeBzfuBhxv577gzQbdMW
	 JBOaymkPCW5/Zs0gE75S6sQDG2w3inlxBUpuKg0gkEwnpRQnxPZy0S4nhqk8t3TMQb
	 +TzcCqw3zQVwyGafLF5l04X9dhwjVqPrUTe/ae04L4c+vyT6PAMqI/tFzYlBSYIdJr
	 dGJkII4fEI/aw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9FD0D450D3
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Jul 2026 06:12:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HwtSdYsb;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yg72Soa0;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748utt2629826
	for <op-tee@lists.trustedfirmware.org>; Tue, 7 Jul 2026 06:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6HxuZEjRivqOYFFj1YwrCy4ofCv1OCHGdZU482Lj11E=; b=HwtSdYsb8l6buXNN
	TQWTbPo1Dr6zfRutjohy56KpU3iTwgjaqYh4lK4o+K0IKMsRNZk/WdDej5L3OjBN
	9QCGQVChzjNUtKhYy+OIexV1Ex32nfzH5icQ9uwOTUu9DhbrynNNZn0HPnDtGPsf
	X5aDVaCj4TVJl0RKkoOSPUgLMPRqX+ueci0TJjv2dPGiyr+/mhoESOq/IDSKtRHv
	f6inzau9txQHDi3ejppkciMLG9Of0H9SIaIegQb+bWIUIih6O/lVV35CNVaQRYei
	fQjgtaUqvj4Wat96vbZTBmM4QrkOz569LqMCSKXZH1NCO7TjNH7P86PsqDCQQDAs
	fZfNWg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h54tar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 07 Jul 2026 06:12:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8482fd61e83so497446b3a.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 06 Jul 2026 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783404741; x=1784009541; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HxuZEjRivqOYFFj1YwrCy4ofCv1OCHGdZU482Lj11E=;
        b=Yg72Soa0KF+anGIRrnOGnzhd5M6k53VB3q6Gc28vx/HdnaJ3RutO/3CvkDIysvaaGn
         JqdtZnqkbN0e27Pu4SGDvTcHDrYuuP/FTjl8ml5vD6Xn7x1mt3ww/pSpbnLOotMcTFD5
         vRLzDRl08E6fGq1jmRJhgK6G1aoW30oZhNo6o+TyRG4HeqG9rERwXXsr6l2Z19lNBpKJ
         rPCaWzYxIPQKUHf1xfYklh4Q7zVbKrNJuQlEfhFshNbVEo+F4/6lUpDe8IfQoeo8IdUe
         3xNvLCVykskpMJ2RA92HUOVp5g/QmabLlqhbUJVLhbc9EBIitQPRvrNmEheBBQgzUKTA
         6dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404741; x=1784009541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6HxuZEjRivqOYFFj1YwrCy4ofCv1OCHGdZU482Lj11E=;
        b=Z8Vtostkpsl2jbQjuqeRcjVhRt90v8jJPH9lD+QxoSbEdq+SRj+8u9IFw2DLDpIJ0O
         FRTAnOAqzYju2UBEgPNRZcQB3d8QbFmqhjulv+qHxS7bJP/y1begl3nnhGFzEMCJbu28
         se1o0W1AfBDgA4grEpwggrj+NTL0EMqy7/doxBwxLsbqb21jTFnXHX7Gs+REjOE623gy
         WhxKPWbGV5L/M3CX2Rnc4EuZKkmIMa86yPjXk1cli1Or3XR3DUNUr6xxTr5nT6zys6NW
         e15elp+47gdtLwY7MjNKBgv7b0pbZdjRSsHcTRPdzqcIXHjW0yQf4uXF40G7Iwl5PgRg
         CYgw==
X-Forwarded-Encrypted: i=1; AHgh+RpnUfD1d1GM+JCWBwka5y0TCacHWgR2AC1RXOaMUtp5w25apYxZCKRdkcD7dOK9gVYywlUT+8w=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yywxe1MAVkCF+omCkSsz88y7Chmt4PeB4YXN3VrXxcSdRIeY4IJ
	SZGLOosc7QpMIDSDQj8KLiEJ2S16D5KMnRAj2CymqrosYM43Y0PouJ2YbXnWPInNUYqMarIHchz
	hp14qVvGzs5ytpDhpUi0R1SdPYxxgyuPFmjKv6TiZ6fukCCk06Qhm2c+mWRKROiP62+gAMP8k2Y
	jvd1kW
X-Gm-Gg: AfdE7cnXXKAHpg65GKCvzUsUJroFC4WStd1hF6IxF13y3J+igBzzCIKwsauyOp26XRr
	DBvlInzZEH80gYxzvdcCokmoiFp9vkQUVPqVAHrxTEi7bwBDh9HE9KljZ47qv8bqvgXl3W3yhP5
	zgXrZ1WQ6KEf75uEXyCtkd9oROb2NyOTrWWNQWn5I4h/qpIXwzJksFDvpgkoWNjrlB+rgJbIYCv
	ohF2Ie+OFTRPdwl1k3QLqwzzb5AA7mOzp2rshiNAfyKh+NLUSvv/ewNi6grgGynzSuZNcyFPzsy
	v0t1N4j0HRO82iL6wvz1aLBokOM/24xaqY8T+mQXIC1RRSeCU24V2ITvKp+UASpJeaWA+eioQi+
	EOQaO2GFQmklSlnigQ5/Z0YY2Se0JJi7Y2NbJ
X-Received: by 2002:a05:6a00:1708:b0:847:973b:3cfa with SMTP id d2e1a72fcca58-84826c23c70mr3852091b3a.15.1783404740856;
        Mon, 06 Jul 2026 23:12:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:1708:b0:847:973b:3cfa with SMTP id d2e1a72fcca58-84826c23c70mr3852063b3a.15.1783404740316;
        Mon, 06 Jul 2026 23:12:20 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm3299321b3a.8.2026.07.06.23.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:12:19 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:41:31 +0530
Subject: [PATCH 5/6] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-5-f659cbd5d04c@oss.qualcomm.com>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
In-Reply-To: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783404715; l=10315;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=an3gXuk4A2+uvHpWTkRIawSelkiuFs5doNcyQWtYbNw=;
 b=y9nRWh2PrURkVFBrnNQn16rxbjc+Da7v0/l3P+HhTKcLr3KeGb72rVvgRZXmGb0NLosyYla5c
 LmfEMTilE9HDe8ATOmCy+8tjPtqqUmV1el17jjP2VyBLmASp4wEJbVq
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: 4m2hq_u6qNYWosamhjUzwQ4taa_01HNJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX63obIcJEg04v
 8FdUqNQ8IfyLq/k0H+ravMDbz88EATnO522KDfkqYdfl1gPeMYQ0cutJKbgaMJ0tLJBfX9H7y8u
 vCzx7d6Xqxl8dMRkVJv1krYN5juuCzc=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c98c5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Nf0BAG_vLcPjEMih4eIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX7uBWXD6FfChr
 3cfyBEtu1PLCIXRlOuqqdMoG+/JdkjADCz+q6HAznSBjxwObzB720rJlV0V2+oAeYihiNp8HSe2
 tAzaoS+y06kc6c+GAtBGfwHqNAjUjccUa4pbuxR8NuhbBrxyKxxr5uIOd8lvoAkZYNL/tFmQpQH
 2g7lIhkz/qA7Kqrve6buI8uY4uEtfwf0tx3RrmnSXG4ohdM0x0F8kLgEyTSY7lIyw10sLi7dGJS
 RmtFVPlZMykIkJGb+84TCYniMdRjDTvw5k0kkhOCTvc6lTu5fc+UXfqkvjdXvnfEQrnFB6YOi5s
 9bAnQzhmYoA1aB74rK19W0OPlPjRyaojLPGGt+VB6Z4GicSb5KDctPKG/M9USiC4R9lfpmAQP9A
 qZTQh1w0gIZnK9FWiPiQZ1fg5VffDIgP/UvoJ6OwCrqEnQNFBaY5uVBydw6YKjuV2BhEA0AKiat
 msgb7Ec+iBLJzf7C9QQ==
X-Proofpoint-ORIG-GUID: 4m2hq_u6qNYWosamhjUzwQ4taa_01HNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070056
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
X-Rspamd-Queue-Id: 9FD0D450D3
X-Spamd-Bar: ------
Message-ID-Hash: VJXMBRBKSPFYOIJVPFPS2NA53AYTXEVK
X-Message-ID-Hash: VJXMBRBKSPFYOIJVPFPS2NA53AYTXEVK
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VJXMBRBKSPFYOIJVPFPS2NA53AYTXEVK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

QTEE exposes certain secure services implemented either within the QTEE
kernel or via pre-loaded Trusted Applications (TAs). Such always-available
services can be readily accessed by TEE client drivers via QTEE's
object-IPC protocol if the service is registered as a device on the TEE
bus.

One such service is the EFI-variables service, implemented by the
uefisecapp TA which enables kernel clients to access EFI variables at
runtime.

Maintain a static list of such always-available secure services and add
support for the QCOMTEE driver to register these services as devices on
the TEE bus during probe.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 160 ++++++++++++++++++++++++++++++++++-
 drivers/tee/qcomtee/core.c           |   9 +-
 drivers/tee/qcomtee/qcomtee.h        |  12 +++
 drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
 drivers/tee/qcomtee/qcomtee_object.h |   3 +-
 5 files changed, 177 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index e12c1a6e72d8..4373fcac2f5f 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -677,7 +677,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 {
 	struct qcomtee_object *client_env, *service;
 	struct qcomtee_arg u[3] = { 0 };
-	int result;
+	int result, error = 0;
 
 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
 		qcomtee_object_invoke_ctx_alloc(ctx, true);
@@ -690,9 +690,13 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 
 	/* Get ''FeatureVersions Service'' object. */
 	service = qcomtee_object_get_service(oic, client_env,
-					     QCOMTEE_FEATURE_VER_UID);
-	if (service == NULL_QCOMTEE_OBJECT)
+					     QCOMTEE_FEATURE_VER_UID,
+					     &error);
+	if (service == NULL_QCOMTEE_OBJECT) {
+		if (error)
+			pr_err("Failed to get service! error: %d\n", error);
 		goto out_failed;
+	}
 
 	/* IB: Feature to query. */
 	u[0].b.addr = &id;
@@ -712,6 +716,153 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 	qcomtee_object_put(client_env);
 }
 
+/**
+ * is_qcomtee_service_available() - Check if the QTEE service identified by the UID
+ * is available
+ * @ctx: TEE context.
+ * @uid: 32-bit UID of the service.
+ *
+ * Returns true if the service exists and is available.
+ * Returns false if a service is not exposed by QTEE.
+ */
+static bool is_qcomtee_service_available(struct tee_context *ctx, u32 uid)
+{
+	struct qcomtee_object *client_env;
+	struct qcomtee_object *service;
+	int error = 0;
+	bool ret = false;
+
+	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
+		qcomtee_object_invoke_ctx_alloc(ctx, true);
+	if (!oic)
+		return ret;
+
+	client_env = qcomtee_object_get_client_env(oic);
+	if (client_env == NULL_QCOMTEE_OBJECT)
+		return ret;
+
+	/* Get service object corresponding to the uid. */
+	service = qcomtee_object_get_service(oic, client_env, uid, &error);
+	if (service != NULL_QCOMTEE_OBJECT) {
+		qcomtee_object_put(service);
+		ret = true;
+	}
+
+	/* When we fail to get the service, QTEE provides the reason. */
+	if (error)
+		pr_err("Failed to get service! error: %d\n", error);
+
+	qcomtee_object_put(client_env);
+	return ret;
+}
+
+/*
+ * QTEE Service UUID name space identifier
+ *
+ * A random UUID that is allocated as a name space identifier for forming UUID's
+ * representing secure services exposed by QTEE.
+ */
+static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
+						     0x93, 0x4e, 0xa2, 0xf2,
+						     0x0a, 0xba, 0x98, 0x42);
+
+static const struct qtee_service qtee_services[] = {
+	{ "qcom.tz.uefisecapp",
+	   QCOMTEE_UEFI_SEC_UID }
+};
+
+static void qtee_release_service(struct device *dev)
+{
+	struct tee_client_device *qtee_service = to_tee_client_device(dev);
+
+	kfree(qtee_service);
+}
+
+/**
+ * qtee_enumerate_service() - Enumerate a given QTEE service and register
+ * it on the TEE bus as a TEE client device
+ * @ctx: TEE context.
+ * @service_uuid: UUID of the service to be registered on the TEE bus.
+ * @uid: 32-bit UID used by QTEE to identify the service.
+ *
+ * Returns 0 on success and < 0 on failure.
+ */
+static int qtee_enumerate_service(struct tee_context *ctx, const char *service_name,
+				  const u32 uid)
+{
+	struct tee_client_device *qtee_service;
+	uuid_t service_uuid;
+	int rc;
+
+	if (!is_qcomtee_service_available(ctx, uid))
+		return -ENXIO;
+
+	tee_generate_uuid_v5(&service_uuid, &qtee_service_uuid_ns, service_name,
+			     strlen(service_name));
+
+	qtee_service = kzalloc_obj(*qtee_service);
+	if (!qtee_service)
+		return -ENOMEM;
+
+	qtee_service->dev.bus = &tee_bus_type;
+	qtee_service->dev.release = qtee_release_service;
+	if (dev_set_name(&qtee_service->dev, "qtee-svc-%pUb", &service_uuid)) {
+		kfree(qtee_service);
+		return -ENOMEM;
+	}
+	uuid_copy(&qtee_service->id.uuid, &service_uuid);
+
+	rc = device_register(&qtee_service->dev);
+	if (rc) {
+		pr_err("QTEE service registration failed, err: %d\n", rc);
+		put_device(&qtee_service->dev);
+		kfree(qtee_service);
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * qtee_enumerate_services() - Enumerate all the secure services exposed by QTEE
+ * from the static 'qtee_services' list and register them on the TEE bus as
+ * TEE client devices.
+ *
+ * Not all versions of QTEE support a given service. Hence, we try to
+ * enumerate as many services from the 'qtee_services' list as possible.
+ * Not being able to enumerate a service shouldn't cause the driver probe
+ * to fail since none of the services in the list are mandatory for
+ * establishing communication with QTEE.
+ * @ctx: TEE context.
+ */
+static void qtee_enumerate_services(struct tee_context *ctx)
+{
+	int rc;
+	u32 idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(qtee_services); idx++) {
+		rc = qtee_enumerate_service(ctx, qtee_services[idx].name,
+					    qtee_services[idx].uid);
+		if (rc == -ENXIO)
+			pr_err("QTEE does not implement service %d.\n",
+			       qtee_services[idx].uid);
+	}
+}
+
+static int qtee_unregister_service(struct device *dev, void *data)
+{
+	if (!strncmp(dev_name(dev), "qtee-svc", strlen("qtee-svc")))
+		device_unregister(dev);
+
+	return 0;
+}
+
+static void qtee_unregister_services(void)
+{
+	bus_for_each_dev(&tee_bus_type, NULL, NULL,
+			 qtee_unregister_service);
+}
+
 static const struct tee_driver_ops qcomtee_ops = {
 	.get_version = qcomtee_get_version,
 	.open = qcomtee_open,
@@ -793,6 +944,8 @@ static int qcomtee_probe(struct platform_device *pdev)
 		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
 		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
 
+	qtee_enumerate_services(qcomtee->ctx);
+
 	return 0;
 
 err_dest_wq:
@@ -822,6 +975,7 @@ static void qcomtee_remove(struct platform_device *pdev)
 {
 	struct qcomtee *qcomtee = platform_get_drvdata(pdev);
 
+	qtee_unregister_services();
 	teedev_close_context(qcomtee->ctx);
 	/* Wait for RELEASE operations to be processed for QTEE objects. */
 	tee_device_unregister(qcomtee->teedev);
diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index b1cb50e434f0..4e39e867c3e9 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -896,19 +896,20 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic)
 
 struct qcomtee_object *
 qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
-			   struct qcomtee_object *client_env, u32 uid)
+			   struct qcomtee_object *client_env, u32 uid,
+			   int *result)
 {
 	struct qcomtee_arg u[3] = { 0 };
-	int ret, result;
+	int ret;
 
 	u[0].b.addr = &uid;
 	u[0].b.size = sizeof(uid);
 	u[0].type = QCOMTEE_ARG_TYPE_IB;
 	u[1].type = QCOMTEE_ARG_TYPE_OO;
 	ret = qcomtee_object_do_invoke(oic, client_env, QCOMTEE_CLIENT_ENV_OPEN,
-				       u, &result);
+				       u, result);
 
-	if (ret || result)
+	if (ret || *result)
 		return NULL_QCOMTEE_OBJECT;
 
 	return u[1].o;
diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
index 5d292a2ff83d..44fbed6868ca 100644
--- a/drivers/tee/qcomtee/qcomtee.h
+++ b/drivers/tee/qcomtee/qcomtee.h
@@ -17,6 +17,8 @@
 #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
 #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
 
+#define QTEE_UUID_NS_NAME_SIZE	        128
+
 /* The MSB of the object_id field indicates whether the client is invoking the
  * object from user context or kernel context.
  */
@@ -45,6 +47,16 @@ struct qcomtee {
 	u32 qtee_version;
 };
 
+/**
+ * struct qtee_service - A secure service exposed by QTEE identified by a 32-bit UID.
+ * @name: Name of the QTEE service.
+ * @uid: 32-bit UID used by QTEE to identify the service.
+ */
+struct qtee_service {
+	const char *name;
+	const u32 uid;
+};
+
 void qcomtee_fetch_async_reqs(struct qcomtee_object_invoke_ctx *oic);
 struct qcomtee_object *qcomtee_idx_erase(struct qcomtee_object_invoke_ctx *oic,
 					 u32 idx);
diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
index 878f70178a5b..ecaf8db67d45 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -105,6 +105,7 @@ union qcomtee_msg_arg {
 #define QTEE_VERSION_GET_MINOR(x) (((x) >> 12) & 0xffU)
 #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
 
+#define QCOMTEE_UEFI_SEC_UID            413
 /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
 
 /* The message contains a callback request. */
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index 7bd6e23b038c..f4cb9b8fcbd4 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -316,6 +316,7 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic);
 
 struct qcomtee_object *
 qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
-			   struct qcomtee_object *client_env, u32 uid);
+			   struct qcomtee_object *client_env, u32 uid,
+			   int *result);
 
 #endif /* QCOMTEE_OBJECT_H */

-- 
2.34.1

