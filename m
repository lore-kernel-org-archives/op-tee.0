Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D0ECA5FFF
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:42:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B05214519A
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791247354;
	bh=s08gzyzL/xn+WRXKKYQymO9Xn/zYKdVDtDBoHjxSrlU=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FBMx/I7BH6OBhrnRIZH/LxAPzDatG2Ac7m0uVGr975wGPT34HUC6R6kz3ouNQICr8
	 +xitbJtAQZgekftNNsdllNMU7der4sHaQBRASOOIIem4wzkP1Jt6X59uzCHdHOp4Vf
	 r1dekMFRUze8Qv48/V3DSV0WkTJLd0HhfHxkKXMs2Uh5yGpKNoh1NNNfQx9dI/WViR
	 Fq7qM4SkiEBeCy++k4nkaG1ZSguSH/khdFdO0NMgd0wD/zQYj3YSNlso5Swvt5FrbF
	 CU0uk/y5AvVhZnPmFSt/+XdUsKOg43LiGCVHwyYPQ5e4JUBtFMYdjxQWt7KOyzBklQ
	 z2oFuZgPiTd7w==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E65044550C
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 00:40:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h3P+c/Kd;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KcNfW/1y;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695KMrRU3432194
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 00:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wua//ehqYe/k1gM6cXEAgLdAS/bL/RuV3uXFJa/HKLI=; b=h3P+c/Kdq7wfiKNC
	W6FNGDWCulEdDxpm627gK4TtbkaY5u8Tmw1S8yzXKkC04OPMoK3GHoB5492mfomA
	LLLeGOuEqJPn2hd1kWWZftiU0E6H7JuWuci1kNV7sNfZxIiPKzxrgvbOnVYSaWQ+
	uQBjhesYudXfxcIQRDrMslxxmwlOhSbEWFPv5IMLupjMYIQeZ9CnbR5eS+LXLYPq
	b5FRV0WRH6Y/n1c7HOtYQnId9MWg66yfxXvSlQAo9u0CQGTGmtpAgAusVoRdVgKk
	j3nyrloTAM7kx+hzqYcz5wNzMepbUxlOYb/DSs7ivlBhES+Mrmrxui8rhUh8g/l5
	k6gc+Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvty1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 00:40:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so5850283eec.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791247199; x=1791851999; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wua//ehqYe/k1gM6cXEAgLdAS/bL/RuV3uXFJa/HKLI=;
        b=KcNfW/1y62S4LyDpwdAN6EnFpUSnYt0VeTQCqXiwek8AAQUpuYZeRDYqm9VDDCDR2O
         wHNyKqW9q3WY+p0fb6uP7ZOG253vZ9H/LhvmLHi1ZB3BolesxAIlII68FL9hEw0b+hlR
         ulXjYpb6UyvAkMxl+6lBtlelldJfEmslf4SaPXjYyqwkjQpE9zYo/jMiIo0Cjai7rAdi
         V1f9bbuZA2w7Fv2yAMRmpantO8moJrftkTeqEOuJd8vqHUXZU5cYXd0ltEgb5r7enEqC
         R1goPKmPk4ZhmTYuuD8dVq9B7MiKfEIlU8v1uWlHOKJ3xFE907RtQoLoHA5xVGy2gRWP
         j2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791247199; x=1791851999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wua//ehqYe/k1gM6cXEAgLdAS/bL/RuV3uXFJa/HKLI=;
        b=mrpL3XaOphk85H99d0eTFFzFrd/8kXR0aohVMgR6xtAQruKjW34nVKtziQiWu384Dl
         AfsFiAYbPr5Ddq6tBErXvzzbq5aHkgotpQQ0pc3XHYcrnP95dsZpeZx9BnwI37l9ygvY
         EKZ82beQWzInbF0hXWKyM4KACMNdmIFcgafVhOQLLK3qxFSaQE46VzZupGFYum2p1Z3c
         WcZ8mRCURmUSEcVP+IRg2QwpnI6dS1ORvGwvAdNGigCScfEUWrGGUGW68GGu9HpvV+5v
         qk4Y3EmkVqg9hml3Qmn9E3ncGL9VSIHFCsjhSVJ/q2smb6RLnqTtGLqODe3S1v3NUUiJ
         mW/g==
X-Forwarded-Encrypted: i=1; AKwUvBy+AyI2hkNHBvYxeV3MI4V5G2TDapIAOGEEhm625zElu5FAq+kVTTlclcG8/UHV8OMhFhmMBkM=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIwUNF0UkF/5ljNnCeFGPJvJSq+to95QnqYWKVtPrEsm3bkq0pV
	L0zAaRolH6L3cuyehRQgsn/SPPRSpZq5RR56T34kfSCuvfUy52B4pea5HDvy3z3jtHNmSuppx/A
	vhu3Kn4yvdKm1aE+jq7/CQ6TtaMKkggfUvARqBNWXYXMOVW97QH6jSfYQERR+Izsrl9Y5sXg=
X-Gm-Gg: AYBFou3rpF4PPLforBbN81UKzCZQzZ/QO7OOk9938H6NYdVhKcqQWqYYRZ1E3hatwiR
	31Mk2HoTlmQn6JA/FLIKB2nuiN6fNT9OIauEeXGBjKyIDLz5k6H81KtlVUFnIni223PgnwokbeY
	Sb4iuRKTnBO8wbJ8K+9asqOidWqNYeNxLbSPeFjCuK2PtneTCBW7SmxYB5hVWllD4isps2C4NLk
	hi4xdbWhzPTMPuUhQ/plcKfPWH/GmPVjBno10iI8p76ALJRaeMBzie9fGrpW6CImyLL/A29ZK4e
	QEyyjJcmbx4pATcxaDLtPYfWJWFf+005QVrNMChe5NnyjSspPZMuq1d9UgYsboR6pvnHNya9rUl
	7LAgyrjHDkJ7sMKJtjVFAH7aA3tvj5VjfwFZPE83CWvygr8k56L5RpjpSFg==
X-Received: by 2002:a05:7301:2324:b0:351:fc0:d080 with SMTP id 5a478bee46e88-3510fc0d605mr11956030eec.12.1791247199198;
        Mon, 05 Oct 2026 17:39:59 -0700 (PDT)
X-Received: by 2002:a05:7301:2324:b0:351:fc0:d080 with SMTP id 5a478bee46e88-3510fc0d605mr11955999eec.12.1791247198578;
        Mon, 05 Oct 2026 17:39:58 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146ac078fsm2108874eec.22.2026.10.05.17.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:39:58 -0700 (PDT)
Date: Mon, 05 Oct 2026 17:39:49 -0700
Subject: [PATCH RFC v2 5/8] tee: optee: add RPMI RPC handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-rpmi-tee-service-grp-dev-v2-5-72f222e23ec1@oss.qualcomm.com>
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
In-Reply-To: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac44360 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6VhrBSHLQm3oGo9yYzUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: K1_zsnd9qFXA-PQ5U8_qoh1BvjaHs8cc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfXwV0Mniy4jEEn
 ZCWE+ugeIziq/RmTcSif0B97gR9CQH8M71N8T33kyIvyH4rzjjpC8RYy9PeBVmRq0W1KafWi8KP
 Esi8lCpjsRD4SUPgoawtZLmdt2STT/hkR74NYhlVC1h0VoO5b9UO5o7sIyoSd0C5lDMgQE+4TY+
 0fHDPis1WBN7PVtIWqvIGK5U2/9+oaSA87kGm7AooODh3+tg9PwvHywze8BqBmWq6LCLPH4vMqt
 Q/0Iy0LIhgM+YFt26+ZT8fgah9VGKC50nS/eVstyyT15IV0L+/eB1EJke1/OoITFEWwW9Bh53H9
 n7+1COFHDExylbEj8MSLjoqqc1vJBxpxUcHNKTKO75emK73EfnhXSwdHNO2qhku1Nw55az92Zdl
 OW2Mhsjn45qPArU8x6MAZJZVRdcMGfma/sTpZr3zhIO2p0r0KRS/9a6s+gJ6VJhH2645EB77rVL
 PNZnrQEeY/dmtHyKKAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfXw1dBgjYGcfLk
 sHPoFPsWkQjDZ94U447KhBsP4AgpxAXdTaZMO75gf1U5TXNp8aLb9LpqHjr8ne0CMvBZiiR6Pb/
 lUN40qdh6QDIav8e3y0ptBFe40p4juM=
X-Proofpoint-ORIG-GUID: K1_zsnd9qFXA-PQ5U8_qoh1BvjaHs8cc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E65044550C
X-Spamd-Bar: -----
Message-ID-Hash: 5PN3NI3VWES3E3APEYTRV7YGQUIVZ7BO
X-Message-ID-Hash: 5PN3NI3VWES3E3APEYTRV7YGQUIVZ7BO
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5PN3NI3VWES3E3APEYTRV7YGQUIVZ7BO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

OP-TEE can suspend a yielding call to request services from normal
world through RPC.

Add handlers for shared-memory allocation and free requests. Use the
existing kernel and supplicant allocation helpers, return RPMI parcel
references for allocated memory, and resolve those references when
freeing it.

Route other commands through the common OP-TEE RPC dispatcher. Store
RPC results in the shared arguments for OP-TEE to consume when the
yielding call resumes.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/rpmi_abi.c | 109 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
index c29b7ac4552a..58d82678be98 100644
--- a/drivers/tee/optee/rpmi_abi.c
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -13,6 +13,7 @@
 #include <linux/unaligned.h>
 #include "optee_private.h"
 #include "optee_rpmi.h"
+#include "optee_rpc_cmd.h"
 
 /* Nonzero nonce keeps parcel ID zero distinct from a null reference. */
 #define OPTEE_RPMI_SHM_NONCE	1
@@ -451,3 +452,111 @@ static int optee_rpmi_from_msg_param(struct optee *optee,
 	}
 	return 0;
 }
+
+static void optee_rpmi_handle_rpc_shm_alloc(struct tee_context *ctx,
+					    struct optee *optee,
+					    struct optee_msg_arg *arg)
+{
+	u32 parcel_id, nonce;
+	struct tee_shm *shm;
+	u64 type, size;
+
+	if (arg->num_params != 1 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_INPUT)
+		goto err_bad_param;
+
+	type = arg->params[0].u.value.a;
+	size = arg->params[0].u.value.b;
+	if (!size || size > SIZE_MAX - PAGE_SIZE + 1)
+		goto err_bad_param;
+
+	switch (type) {
+	case OPTEE_RPC_SHM_TYPE_APPL:
+		shm = optee_rpc_cmd_alloc_suppl(ctx, size);
+		break;
+	case OPTEE_RPC_SHM_TYPE_KERNEL:
+		shm = tee_shm_alloc_priv_buf(optee->ctx, size);
+		break;
+	default:
+		goto err_bad_param;
+	}
+
+	if (IS_ERR(shm)) {
+		arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+		return;
+	}
+
+	optee_rpmi_shm_get_identity(shm, &parcel_id, &nonce);
+	arg->params[0] = (struct optee_msg_param) {
+		.attr = OPTEE_MSG_ATTR_TYPE_PMEM_OUTPUT,
+		.u.pmem = {
+			.offs = shm->offset,
+			.size = tee_shm_get_size(shm),
+			.parcel_id = parcel_id,
+			.nonce = nonce,
+		},
+	};
+
+	arg->ret = TEEC_SUCCESS;
+	return;
+
+err_bad_param:
+	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+}
+
+static void optee_rpmi_handle_rpc_shm_free(struct tee_context *ctx,
+					   struct optee *optee,
+					   struct optee_msg_arg *arg)
+{
+	struct tee_shm *shm;
+	u64 type, parcel_id, nonce;
+
+	if (arg->num_params != 1 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_INPUT)
+		goto err_bad_param;
+
+	type = arg->params[0].u.value.a;
+	parcel_id = arg->params[0].u.value.b;
+	nonce = arg->params[0].u.value.c;
+	if (parcel_id > U32_MAX || nonce > U32_MAX)
+		goto err_bad_param;
+
+	shm = optee_rpmi_get_shm_for_parcel(optee, parcel_id, nonce);
+	if (!shm)
+		goto err_bad_param;
+
+	switch (type) {
+	case OPTEE_RPC_SHM_TYPE_APPL:
+		optee_rpc_cmd_free_suppl(ctx, shm);
+		break;
+	case OPTEE_RPC_SHM_TYPE_KERNEL:
+		tee_shm_free(shm);
+		break;
+	default:
+		goto err_bad_param;
+	}
+
+	arg->ret = TEEC_SUCCESS;
+	return;
+
+err_bad_param:
+	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+}
+
+/* OP-TEE leaves the shared arguments unchanged while Linux handles the RPC. */
+static void optee_rpmi_handle_rpc_cmd(struct tee_context *ctx,
+				      struct optee *optee,
+				      struct optee_msg_arg *arg)
+{
+	arg->ret_origin = TEEC_ORIGIN_COMMS;
+	switch (arg->cmd) {
+	case OPTEE_RPC_CMD_SHM_ALLOC:
+		optee_rpmi_handle_rpc_shm_alloc(ctx, optee, arg);
+		break;
+	case OPTEE_RPC_CMD_SHM_FREE:
+		optee_rpmi_handle_rpc_shm_free(ctx, optee, arg);
+		break;
+	default:
+		optee_rpc_cmd(ctx, optee, arg);
+	}
+}

-- 
2.34.1

