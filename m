Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F43FCC6B03
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:45:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4A9BD45225
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791870303;
	bh=UZD4R6R/FQWDGv8pkyECBSdQs7WwyexiNCcXxk6sEBs=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uYhoApGp5bVQWPlXzhiAGmET49kA8b8YoDhrgR61zRllLZSolyPVCrNYO3nBWOPGF
	 TwffQUZBJ/ol0cgN5SgOs/Rqy1c6G5g5jzmHtOJOh15FKw2GYjXLZHmmGFnEtRMxpK
	 2HXnlKF3FcgoJEr1rxSE85o7ASadk2WoJfgeKr4t9NZtQfZjYMHzm234IEslLGVmni
	 VervN/AINJkzvVhTobkTZSYOiE6i1NTDZSYQc8ykrAHQUPXg1j99momja0216WEvmQ
	 6mKGq501aRSRW0ZnfrGZo5letZl6iRuqX/yyEcB1nzaFIFvygE83OnGN2mg+BQGWqS
	 eBAW9LVj9IP+A==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 73B2745232
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:42:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BjGhVx1F;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cnEzUp28;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D213ki3908182
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rd65ljd9yXesQac/jFW5/g1sKZN3hISajAVdGuSexr0=; b=BjGhVx1FntWvYtaD
	TyU2KTvHMMl22qHKhKBFeh3bJBxlmq8Xh3CyzU1IOuMa4goYuiMSSO1SDdtxw5sW
	Mqnd74KyCy4JtWXqA7p6NZ/IFMn9AiDKNAc4M+sf+dzde6BfQwk4RO2NzWz9+gZn
	jVhTD+jvBRNqAo/eMo5FWxOdziAUMoISYxj2oj5S7FmAF1HC1qtPH7Zru44OIHW5
	vesN55n9wEYRgsAnXwNMBYTRgPhGB7heOsnYAfGBKB9SEVheemStYtBYY9Pcq1d1
	9PIMQdxs2q1DR12LgRVg2h3falQ4K52r2sBVWVZfJAuOf488WrZPw7O6SDi0cSMW
	SIu+Fg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqsudv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:42:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a8af172664so2042361a91.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 22:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791870120; x=1792474920; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rd65ljd9yXesQac/jFW5/g1sKZN3hISajAVdGuSexr0=;
        b=cnEzUp28hwA4rVeur2dy44ZzIvWUvf/t4BkDG7j4tOHY2XqRJRTWXb28bot+lYLZdN
         emfr9NGAHpf4ZUh6BaaUHL3+ckJghHfkfg5md8flHLPRYJ2MSu+lSR963YAN6V+Oifrv
         mVL9W8zj7IsEjZlQ0X7T3G9rqlwilQJYY6zmITrzohtnS8FqicKmlgh6LDmGMBLU4Pn0
         E/ejDJf9VcNB0Lv/FFoH4/vjcbcet7jatONYxoITX3g6xu6lxis95gzQz1l//PWYoWaB
         16hT9loMH4dzLvO0pPao+YKzIZHVzZ4JzjyqZxvOX+GdJRIQwGZmOqH4/93WlBWVbH5k
         fW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791870120; x=1792474920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rd65ljd9yXesQac/jFW5/g1sKZN3hISajAVdGuSexr0=;
        b=psD3vtYgaDNu6pPLOUakZa31z/eaQLwR0EmKoD06II67OOTpCGppv6UZe0PQQZNo56
         r1twWxCCQO/spEhoIO2w3GrjN4gTC7P7NWa0t+fClhLQjZju/ncigJIgih6kANiMFeKo
         7O8UNkAp8z+KtGd1PgOMDFquCnfxdeLVFmSSs/Y0FE0lX/qGNgoJPjskZbJcNshPHszl
         WQ8zjWU4+BLjaon+eaneVVRcm118HXEUXF77RFOwMGTKXbzXue1c2btBBzv71PB43M/0
         R4dQENjtoIH29A1n8K1HpzlCxYBiaCsGHhdOs1hK5J4nPwDZ3PwwigEbJv4rlMBqVbBo
         eVrA==
X-Forwarded-Encrypted: i=1; AKwUvByyDvN/z+//j/JslPmNxeIHpyvrPltq8rrZxQboxx3o2hq7bxRPaAe4WYdpnsVyjB3qYHJuiH0=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKSfy2tiJkNc78b6YpMDxEx8o1ahu6acci8nkDnHjUP5dI81EkS
	5J58f2d8mWxddlQHk3Pn0rxjGi3qn+IIABshjPz0TpBt7ox2d+VdRa/EmohpMbXzpigWVz5fkT9
	d2E8i5JGJQlkleKZnHeABunA2E3xRLt/BK1mOk6fGIUTn1gzNgBpHcNVPUrkyPtutfoaO9cs=
X-Gm-Gg: AYBFou2LRkbd6txmhESpMzvH+MC2WWFTVbufUzZrmOgZScwyk/Dk23BiUrW3smf+iD2
	Ge2F1YrFsZH94sT/n8ATEsFXKj+xWjZxNg4eKXXQXxLAgB/btB+R0OQIRaTDAnIlDKkkhBJebE7
	hKJjZTqgLfCl6GXcdemd5+F10/eT4ATx64ndmsdmqRDPbrMqJVg9w/DtUSKoGL5jcpkeNqDCsPl
	3Do5lJNI2t7HlF5V7/vjUSAtnQzpXSILSqE1gakUmcULxB8IHxrhb8jkBAF0/OzsmyAE5DNhbbZ
	iiVO8XWf9GCZQAPrPDL5K4iRzDBR8oHMERvhzg62oGvd+6fYyUuNrqqFNlnygCcbVClAtD0OFt0
	iv7cVj3FwshWOMtiJfR13DzfMwp05iL9n5y/AvUX50l/Gz/HfwtacWdTElA==
X-Received: by 2002:a17:90a:109:b0:3a8:2046:7e5f with SMTP id 98e67ed59e1d1-3ab3a747e69mr6959397a91.12.1791870119627;
        Mon, 12 Oct 2026 22:41:59 -0700 (PDT)
X-Received: by 2002:a17:90a:109:b0:3a8:2046:7e5f with SMTP id 98e67ed59e1d1-3ab3a747e69mr6959373a91.12.1791870119113;
        Mon, 12 Oct 2026 22:41:59 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm22926361a91.11.2026.10.12.22.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:41:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:41:33 -0700
Subject: [PATCH RFC v3 6/9] tee: optee: add RPMI RPC handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpmi-tee-service-grp-dev-v3-6-975b574667e2@oss.qualcomm.com>
References: <20261012-rpmi-tee-service-grp-dev-v3-0-975b574667e2@oss.qualcomm.com>
In-Reply-To: <20261012-rpmi-tee-service-grp-dev-v3-0-975b574667e2@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX5iPT6x1pEtkB
 vJFOl0R2Jk+Je5YG5lit2MgohJg/+YI1oqBA+m227PQSqOeDDaz30QWPL7G7HKohKTz+bAiQOoX
 3C9vF59qOaYuPsuAkQ2UvJKnLMsZAy+APupBUGEgs3yf2FNCCAB3LcUkNuWcvcg41kcjE83W5Wn
 cgpXLiIT/BQNEYFAF8BfLWC8S0JVpRImYAba1ATSKg+YsjGBclxpsnsTTbfOAwG8D870L3ryuDR
 OO/XcAjPkmw48SJd0jFTjlJmvVeMb5t0H47cJ2JcRKN8ubDHYjHe0rcdwJ+jLXyUnSELBdmXKNm
 OirueLvIit+e15nf1V2d/ra+H3U4k/ninWtGhwZb6P4+6jO+ieAzqz2h/6dKXalV6IguQB2sz3F
 YtsXtom+n6F83ygPQNog+hbGdvazt44NR4HGF7U5OBa3uex8KZ3iUXtl+ReoIDXCWus2zUZKqJ6
 5gkIuE+IUix24Eywjsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX8RsMBGIUyEph
 Syl4Ui1n3/OWp1CSf8RjFQyp3k+LZcDZEy3sZB+/MxRjk+EQSx+TuCsKjshmm6Mk0g+7Ke2Hga8
 7/3s1G8tpZvI5N43/G97bMcIf/nrSCQ=
X-Proofpoint-ORIG-GUID: 8QBVfgXxnbfGOiY4INo5f8FQMD3A8Wx6
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6acdc4a8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6VhrBSHLQm3oGo9yYzUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 8QBVfgXxnbfGOiY4INo5f8FQMD3A8Wx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130022
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 73B2745232
X-Spamd-Bar: -----
Message-ID-Hash: YWARWDGZ4Z7SMZBEZVIPHY6G2YWHTPXB
X-Message-ID-Hash: YWARWDGZ4Z7SMZBEZVIPHY6G2YWHTPXB
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YWARWDGZ4Z7SMZBEZVIPHY6G2YWHTPXB/>
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
 drivers/tee/optee/rpmi_abi.c | 104 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
index bbb219ddab38..8b90c3653e80 100644
--- a/drivers/tee/optee/rpmi_abi.c
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -12,6 +12,7 @@
 #include <linux/unaligned.h>
 #include "optee_private.h"
 #include "optee_rpmi.h"
+#include "optee_rpc_cmd.h"
 
 /* Keep transport errors separate from the control status in a response. */
 static int optee_rpmi_call_with_status(struct optee *optee,
@@ -353,3 +354,106 @@ static int optee_rpmi_from_msg_param(struct optee *optee,
 
 	return 0;
 }
+
+static void optee_rpmi_handle_rpc_shm_alloc(struct tee_context *ctx,
+					    struct optee *optee,
+					    struct optee_msg_arg *arg)
+{
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
+	arg->params[0] = (struct optee_msg_param) {
+		.attr = OPTEE_MSG_ATTR_TYPE_PMEM_OUTPUT,
+		.u.pmem.size = tee_shm_get_size(shm),
+		.u.pmem.global_id = shm->sec_world_id,
+		.u.pmem.offs = shm->offset,
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
+	u64 type, global_id;
+
+	if (arg->num_params != 1 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_INPUT)
+		goto err_bad_param;
+
+	type = arg->params[0].u.value.a;
+	global_id = arg->params[0].u.value.b;
+	/* SHM_FREE requires a non-NULL identity. */
+	if (!optee_rpmi_nonce(global_id) || arg->params[0].u.value.c)
+		goto err_bad_param;
+
+	shm = optee_shm_handle_map_lookup(&optee->rpmi.shm_map, global_id);
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

