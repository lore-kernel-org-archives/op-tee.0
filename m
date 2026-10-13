Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF73CC6B03
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:45:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B002645258
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791870331;
	bh=7BF8ZScgsZHLtoDDQknMFHdNvkcDjl2HvDQGM+sKIhw=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BzkzAIvIfOHSEgDFOaJvNB/iorFi3wjmZ/uqGhWfvCAvb3Ob3F0y7r790yTSRgB0s
	 MUTWJ9Zo/Q6ld6Cumuh6d60yC/EneuRGtusm6lbxc24gFVMcD/d7nPsGcxD851LwhE
	 +tJf4GxLFJeYSfJJ8RxKTGid9a/IUrf7zQ/Kac45+Avia/Jyr288j6koky4QB6/Hqa
	 ckCj7B6lyFo8e6cx3Ik3tX/gUvHZn3zNQ3obYxYcTqvKX874nerir6W95weZqgioCg
	 mD9PueLZt549yrsH0t3pxWFFXgoQpTOOi3WoaUdLbh7dJN4wwnfBlQ/Vo7GcrsEKdG
	 ATOxMC/qJVL2Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DF04B45263
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:42:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h3wuXcy7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E9h/MCLr;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D215QO408886
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HcNd2IlEKJzNOkdFebRLg0raV2gMq1sWftz0bNxKsos=; b=h3wuXcy7W5oqq1HK
	w80XrogfnSKQCrpuWz6MsLhiOpOgyO2bIOc/hTPoDIUUFvRNI6mdZbMJdCPCVdbZ
	sU2AZ89qI9B6Apo0iQWVvcjvWr+2snoHoJ312AO0TWhzBHx0gQ1NAbNmzoe/rbBJ
	sEBS0r1zdQOiHCu0k4J+N7Tg2Io3URmVWy/Puhv08o0U4xI+g1NQ7hAyierFvZuT
	qHZ4K44mc1CVfjoJURUedT2QGkznFAuPeHwYJ0HfEzT2Cj/tZ3fh3HoxeMeZ0cho
	xIRR5jfkqU8ipuAyLdWL4o2+ZizeEiesheEU6eeS8x9QFHY1cQSLVa2xryyYNaTh
	dEFNdw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffmbtf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:42:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so4183744a91.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 22:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791870123; x=1792474923; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcNd2IlEKJzNOkdFebRLg0raV2gMq1sWftz0bNxKsos=;
        b=E9h/MCLroBz88BpTUzTTrKourAXyT618ci6cG4sjABtNhO3i1ddXn26ugBjZzRJQJD
         vWE2A9sP+3UvwBywCI8l4e+6TIb7UUCU+JqFxFFd12s8izBdIgHNaM2b0xwV5weoEmFJ
         bEg2/DTOlDM1dlLWrHtDuO0JEjE9juFMYoAxraDp/WOgzJCuZCsRfvK748nPeoFuzPto
         PR/7edZtgsEPXjk4AHB+Yiq/KvdngEjeIL1RbOwt/ddLt9eLKk0uRBs+duSN3M6kkJjP
         cUCFXLmHtqEexqVV/WGF1YA8ERQoE8MSDE+ghBa2dlBwSMu/OrsVRTZPWhjrInMOQTjV
         1kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791870123; x=1792474923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HcNd2IlEKJzNOkdFebRLg0raV2gMq1sWftz0bNxKsos=;
        b=aDyZYpsoHKiLwxfN2hPOEsD4QHOVicOCcS3LgMf94uiXeDpe82RxDjU/1LVRARoIza
         TbI/LzKyVt7PhsGlWhDzt3fQJ1qnBQReealPDCC5dLValwH3QxEtZeCU5Ac8wICiNVDe
         0h7hXKVVejQg7t4YWhYYWtOAs1PU43djEI+mQWKRJDbXvZS0HC3xkIVdANlJQ160Z5N9
         H1Yqp23s9G0ObMyPOQepUBu96fGlT82iwR5297If3As6Kpx5gVKDzbLIpzkTtZccFpgh
         4Y45TPQ/r45OBVaejQ9KAX4ii1a96VWEKUAfmMxni79MfUwY9DUtA+MzNP6Nl+xFmI3L
         97vA==
X-Forwarded-Encrypted: i=1; AKwUvBzIkUc4Cij3n/jcWppAjfw3kwMVtye5IPo4Xtbq4w9PQqm/yCEwmekJsBTODnXrMorOk5G2Z1E=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLyLokKlMjsh4jgZn4Alhv5meNWoCe3H2EN7Pyb0XTwZ34wHGGd
	FxI0nkcom/v7eYj/bVcOAMOmUPQcLY2PSDE3EzhYdP18WxzgzaExeG7E5GJ1IiSt3LTveiMgLg0
	8C3PBqNAS608UdqPlftojRIHphm2Mz4eBQCyfzEz6D+oGXkDDANumHU+YXVjcD3fbsix65GU=
X-Gm-Gg: AYBFou0ZVy2QRJmqeShp+HB7jTHkSzh5Qi4Qf2mBxucGlyHEskpNIyoeqaDRqSspiJr
	YLgbK8glxPQOPDdON6qCj1q6gU9K3EtSlX9VrDtMbVB45JNPB0kDCLViZTfiPNI46szh2sEI+3P
	BcBCC8jlfhAaDLLmAMqXiNQzInVC4ZV+BtAif6Bt8X/ErAgYtytLMMueIzDQxV0/dq5Wg7TFmdm
	P0ChA7dnPx4VD7Kyv4FlzLT/4yJs9K8JAouhv/ewAU6BDaHbLuDEPv1HbRnFClw0flylEu0VI0c
	r/1U/oiOqdsopmIOQ1GjCpKeM8dJi4gbfaOBNU0rztDrfOeR9tJ9143topyJitHAwln1KE0oKZj
	sSkTKm9FTHpDY3PKvgvu99GxBR6fQwZn/BofrGeS5k5Ix79F0r6EimMWe9Q==
X-Received: by 2002:a17:90b:224c:b0:3a4:9c30:425 with SMTP id 98e67ed59e1d1-3ab3ab20a11mr10348949a91.44.1791870123150;
        Mon, 12 Oct 2026 22:42:03 -0700 (PDT)
X-Received: by 2002:a17:90b:224c:b0:3a4:9c30:425 with SMTP id 98e67ed59e1d1-3ab3ab20a11mr10348924a91.44.1791870122630;
        Mon, 12 Oct 2026 22:42:02 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm22926361a91.11.2026.10.12.22.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:42:00 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:41:34 -0700
Subject: [PATCH RFC v3 7/9] tee: optee: execute yielding RPMI calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpmi-tee-service-grp-dev-v3-7-975b574667e2@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX7GFYJN+JN3LI
 lmNK9ID/nu+PcHuZvg7f6YyMPcjFPEZuPgqdU9pGAmGQneNMgtNnS62cF95siChrQtYAB2PrtQ2
 ZID3J5Vx55t/0PXr3ZF29YEgOfwl7FuXA1ovn4k+3ifpmnucci6VAXqdk0gwlxZUh43EB8euf5F
 8Hf12eQwhoBBzRU6DWQtxe+++F7oLcYxm7diNrWd8obCfpJ0Wn0ejrzSwcGC7TPsS6cioAHiaSA
 n2NEx43cIdgYcCUUiDsIt1mQeCacjC8cw29t8IlI6vkYkGrVu5tH4pysG+B8e3x+Uewk18nr017
 w3IeO9iN6LEOz+3oTvtLbh9woYYIlpik7QpMT+SWio+77WhSK1lrmZO/7tnwjzd9GHLmyyXV6B3
 Kg3aUMi+ZDh30WmQE6bmDBDCkpdGu9CrHOZhPE80kzu1XkAdHTEviLkMMrq7AW5ai2iodD4dkv7
 TU88mnCO+rZPCf4Ec/A==
X-Proofpoint-GUID: nPlA3vaZkNK9Ytlz4VbL_gNS7X48ufBh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfXz6V31Nau3OuW
 l+sba30bU7ma6n51IRVR2waKY682HY3sgu2Q4Nqtv8Uh53wGd9oLzF3zMiIgfZLo2AMbK+0Jsah
 3Oq3MKfn2dqMotUpYN6g6I82P3fs8bc=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acdc4ac cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aLZfyF7oQ8oiUT2OKIMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: nPlA3vaZkNK9Ytlz4VbL_gNS7X48ufBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130022
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[209.85.216.71:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DF04B45263
X-Spamd-Bar: -----
Message-ID-Hash: C4JJRZAPHQSYNRIDPYTUJPMKKBCMCDY6
X-Message-ID-Hash: C4JJRZAPHQSYNRIDPYTUJPMKKBCMCDY6
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/C4JJRZAPHQSYNRIDPYTUJPMKKBCMCDY6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

OP-TEE commands can span multiple exchanges with normal world. A call
may yield to request an RPC service or allow interrupt processing
before continuing execution in secure world.

Add the RPMI yielding-call path used by the common OP-TEE session
operations. Submit the command and RPC argument buffers as ranges
within a shared memory parcel.

Handle RPC requests while the call is suspended and resume execution
using the token returned by OP-TEE until the command completes.

Use the common OP-TEE call queue to wait when an initial request is
rejected with TEE_ERROR_BUSY, allowing another active call to complete
before retrying.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/rpmi_abi.c | 122 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
index 8b90c3653e80..9a6439e15a33 100644
--- a/drivers/tee/optee/rpmi_abi.c
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -8,6 +8,7 @@
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/overflow.h>
 #include <linux/rpmi_tee.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 #include "optee_private.h"
@@ -457,3 +458,124 @@ static void optee_rpmi_handle_rpc_cmd(struct tee_context *ctx,
 		optee_rpc_cmd(ctx, optee, arg);
 	}
 }
+
+/* Handle RPC command or interrupt returns from a yielding call. */
+static void optee_rpmi_handle_rpc(struct tee_context *ctx, struct optee *optee,
+				  u32 result, struct optee_msg_arg *arg)
+{
+	switch (result) {
+	case OPTEE_RPMI_YIELDING_CALL_RETURN_RPC_CMD:
+		optee_rpmi_handle_rpc_cmd(ctx, optee, arg);
+		break;
+	case OPTEE_RPMI_YIELDING_CALL_RETURN_INTERRUPT:
+		break;
+	default:
+		pr_warn("Unknown RPC func 0x%x\n", result);
+		break;
+	}
+}
+
+/**
+ * optee_rpmi_yielding_call() - submit and resume a yielding RPMI command
+ * @ctx: calling context
+ * @req: initial command request
+ * @rpc_arg: shared RPC argument buffer
+ * @system_thread: caller requests TEE system thread support
+ *
+ * Only TEE_ERROR_BUSY rejection of the initial command permits retry.
+ *
+ * Return: zero on completion, or a negative error.
+ */
+static int optee_rpmi_yielding_call(struct tee_context *ctx,
+				    const struct optee_rpmi_call_req *req,
+				    struct optee_msg_arg *rpc_arg,
+				    bool system_thread)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct optee_rpmi_resume_req resume = {
+		.op = cpu_to_le32(OPTEE_RPMI_YIELDING_CALL_RESUME),
+	};
+	struct optee_rpmi_call_resp resp;
+	struct optee_call_waiter waiter;
+	bool resuming = false;
+	u32 result, status;
+	int rc;
+
+	optee_cq_wait_init(&optee->call_queue, &waiter, system_thread);
+	while (true) {
+		if (resuming)
+			rc = optee_rpmi_call_with_status(optee, &resume,
+							 sizeof(resume),
+							 &resp, sizeof(resp),
+							 &status);
+		else
+			rc = optee_rpmi_call_with_status(optee, req,
+							 sizeof(*req),
+							 &resp, sizeof(resp),
+							 &status);
+		if (rc)
+			goto done;
+
+		switch (status) {
+		case TEEC_SUCCESS:
+			break;
+		case TEEC_ERROR_BUSY:
+			if (!resuming) {
+				optee_cq_wait_for_completion(&optee->call_queue,
+							     &waiter);
+				continue;
+			}
+
+			fallthrough;
+		default:
+			rc = -EIO;
+			goto done;
+		}
+
+		result = le32_to_cpu(resp.result);
+		if (result == OPTEE_RPMI_YIELDING_CALL_RETURN_DONE)
+			goto done;
+
+		cond_resched();
+		optee_rpmi_handle_rpc(ctx, optee, result, rpc_arg);
+
+		resume.resume_token = resp.resume_token;
+		resuming = true;
+	}
+done:
+	optee_cq_wait_final(&optee->call_queue, &waiter);
+
+	return rc;
+}
+
+/* The caller supplies SHM with room for command and RPC args. */
+static int optee_rpmi_do_call_with_arg(struct tee_context *ctx,
+				       struct tee_shm *shm, u_int offs,
+				       bool system_thread)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct optee_msg_arg *arg, *rpc_arg;
+	struct optee_rpmi_call_req req = {
+		.op = cpu_to_le32(OPTEE_RPMI_YIELDING_CALL_WITH_ARG),
+		.global_id = cpu_to_le64(shm->sec_world_id),
+	};
+	size_t arg_size, rpc_size, rpc_offset;
+
+	arg = tee_shm_get_va(shm, offs);
+	if (IS_ERR(arg))
+		return PTR_ERR(arg);
+
+	arg_size = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
+	rpc_size = OPTEE_MSG_GET_ARG_SIZE(optee->rpc_param_count);
+	rpc_offset = offs + arg_size;
+	rpc_arg = tee_shm_get_va(shm, rpc_offset);
+	if (IS_ERR(rpc_arg))
+		return PTR_ERR(rpc_arg);
+
+	req.arg_offset = cpu_to_le64((u64)shm->offset + offs);
+	req.rpc_offset = cpu_to_le64((u64)shm->offset + rpc_offset);
+	req.arg_size = cpu_to_le32(arg_size);
+	req.rpc_size = cpu_to_le32(rpc_size);
+
+	return optee_rpmi_yielding_call(ctx, &req, rpc_arg, system_thread);
+}

-- 
2.34.1

