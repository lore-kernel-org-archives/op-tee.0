Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B590ECA5FF0
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:43:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0CE0845219
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791247384;
	bh=cZPXtLBEO+nIR8AdAKN0AqSZ1s75QgRTXt/bK7/dtYY=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Blm2s9B35LlUn3wgl70i/Iplb+r7EPBfuynDcD3fFfBEbu5G5Ur3HeGfXs5TL60WO
	 31vDiGQk7lBNCtt8g3wFKWffHZbaNiS8YHo7RUzTr/WnggLmreHb2Ot7Nrb+k5UbPm
	 4LJBYZRsziNfWhRHmR/ZIxqjrwtXlK9UUwCTX2rZo7otlPYzKva2ESJyqCxAXpd281
	 JKFDyNRx/UgaoOce+ulmbgHJJJdYFUvok0zaPO2JVUc0sGMEls93FQvfZn6CjOf55Y
	 bWoZAP+eIApFXJ7qoWA24h9AqKLUoVU9yFH6o+Ao5TXL4wf/rAV/a4jPP6hYaOuSxg
	 mDOGRon9Uw4QA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 897F045506
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 00:40:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I/t6oz47;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e6oQtJL9;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695KNOhH2597275
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 00:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPry6s0/eZtpQh6W3xcXutov9SeCo8ZKZHlB3Z0ToE0=; b=I/t6oz47z/G8fqAC
	8RNzbOdJNfGxeU3HWlRFL7iYn+FoSZ0qLqZzyxhL3nxL/xQckIYUPOqMBm8EBwaM
	+DJK/O/rWzc31923V/F8rCDMOEQB2LuWu5PymJKNtzlY7QQytugyYtB/fQ9rnRN3
	WH0OHaOV/8+kn/DhrDOhgLrSqtX6TgTcZdwyj359W21cNG1s3I/LKiWMVytxi5R7
	7jzPPAwrpHFrzSeONhSYJexcx5lwVYkUDbamTseuakvdRRBSM4OR/YPlBlGbpZiT
	AGADfHWbxutC9pcKX21B/OIqZ7Azm1yUxizXJhTJA0hRm3kzxCthXWD4tSjqKrL+
	IWu2rg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4a7dtxx7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 00:40:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-313d1015161so6797155eec.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 17:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791247201; x=1791852001; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPry6s0/eZtpQh6W3xcXutov9SeCo8ZKZHlB3Z0ToE0=;
        b=e6oQtJL9mcWTMLgKNsS7MdmuVyG8vLVWrtoq3rd6NcYFR54pf4y+jF919jItVkWoCK
         WvEYX6r071W+wuPiLGZELs0CsJG7lbWm48twqyS2pLUWBzoPf5VHFksHwyeFziViZU36
         hi3cC9X2e+yjEvIOqfQVuvzov9izQQAH8sKJkPiDJnEpu94+rZU2Oj0cb8Tp8xcNf8Px
         AtZ/kbZQIiKLwii+bJD+sH3Knq9caM+tLsSc45bdhAWKgDzt1+Xw/M8JlLDsaXO4bH1t
         1XPYKKM797ZyURVtYtF3j6ESfyj8Ebq7r9dpJML6ElO+pBg8ZGcv6r/mD5chW7URJQna
         NEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791247201; x=1791852001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPry6s0/eZtpQh6W3xcXutov9SeCo8ZKZHlB3Z0ToE0=;
        b=ERlbnZ6SswBmqjrPdbcXvvxfC5bAY4mRcUTzHw3GeJSWzYU2AsyNcmIrRWbWsPV/fR
         eVrbtlveZUOANaFcaQ0EKZ4Y7wEGQRJ30q6gVpJoSXvEtJRm+UrZ/DAA6qw0UUkk6qUH
         9MwBuZ36O3N/Trv/13/kfikVthUEpBchcd1J50unakL/BewdhuBuvPcw34doTLeAYbbz
         4GquFyhhCHLgY45HE62tK3kzfjFq+Ky0ltMLtvzD2MzpiNqb96SRz6sPBIFjb+yLAL3I
         /wURqye2Lq3Mgt1mXGzboKlt+2G+laTfBtmj/7Z6mjNK0YdXOcqHpt52M/K5QLqkRJoX
         s3hA==
X-Forwarded-Encrypted: i=1; AKwUvBwUYF+nQYlGIqFdQQbcpUZQv+3+Kn+zZFcSypVlPYHPNeeYXQMG2LkQGtDhL9X+cjoU6JzmauU=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIiykVSiYFb3RjWQiLDmL00YtdYYFNSS+zoVbA6sJim+7C2A5V1
	oLZBdWvm9eguPDZDhOgNGp195iiBM1dDT1FjMTCyYhl7GTykppR+HzFs9zHCBY86NBfN+VGlNM/
	32ndYf9OPSZ+1D2did4gj4QQw1O2T81XeHGZTnY2KB5/T4UQOwNw2q32DkuEqmhf3kzDqAfg=
X-Gm-Gg: AYBFou38GeGFwANBTEI7l1551+0DWsqmGJhh7F0RW619O5OMMeDaZ/3+ABVbTuGHJgY
	bSRvxf1HukhchYbeAiuQOV9tlkKQRGW2AjK/PTXDeldmOlepac+xqXYejYgE+M4AL7nbBe5rbfT
	OJWZfDqD+aLaUE06r07sKwHtC0x/QO6tPLJazqsuIkaI6iIPjojVJ8vQMB13RZbkbq3gAMqXQWr
	bpksO1q19mKfJ7yefDVvWK6gD2t/WlQRyubwJlmgOyAVUgoStGBqAyJnd7K1VB7iv7ggTwaVT3k
	TNAzjVjbW20FQIBBu9HCc8jOk+TLLovYJZuCkEI8ZaqMo9PNlwpeJsO/DTq1P2S5UEdSAogotYL
	ljfZbgXUdqtML2Tz4oYBA4+c8//f66/cNYfFEbNQCAq6ThGa9MoOph9Wu8g==
X-Received: by 2002:a05:693c:3881:b0:34c:bc38:e2ee with SMTP id 5a478bee46e88-34f15066431mr15179410eec.8.1791247200689;
        Mon, 05 Oct 2026 17:40:00 -0700 (PDT)
X-Received: by 2002:a05:693c:3881:b0:34c:bc38:e2ee with SMTP id 5a478bee46e88-34f15066431mr15179369eec.8.1791247199931;
        Mon, 05 Oct 2026 17:39:59 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146ac078fsm2108874eec.22.2026.10.05.17.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:39:59 -0700 (PDT)
Date: Mon, 05 Oct 2026 17:39:50 -0700
Subject: [PATCH RFC v2 6/8] tee: optee: execute yielding RPMI calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-rpmi-tee-service-grp-dev-v2-6-72f222e23ec1@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX/WikrUJNPeE0
 +3Q9GdJ7xNl2qAS0326+JJfrOrdzdwYFxPhotpOFwxAgg7iXOcHhpsftBK0OFP70s74BZZq0nh0
 tQEAe/4p7VvHdGdLYDvzS109ACYQ67g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX29EzDo3J2gOU
 YPfgI+kTK8MyLFH/zaFPDmQ6HZ80RpTFkWUQkhHVlx8TA2pIgnSFx0ihiRFwpn4oXKwlhZRrZTg
 qJV8uOhKCGrfkacTjMV5xB20bkD31vFUmp+PUawkwQygA/zb4ygO+kns1FNb8Kgqj5ShwklF+tz
 Pi6secuIMKSefQf7ZXFNK6xEn+D6TDG1GMORqooJ66iMb+vXRhfFeWEPyNSwC6fIN/5Iv+VCcuT
 kiHCQDDtO0sUXlWJXSK/RA/QGCDnYRMopZrsXIdoDYcfyV7ExjbjkcqVaoAMzxwEu8htnZt6cxI
 V59z3xVZypSyaWINJoY4FejSlG8/Al7VssN3oBvNx4BztoyekETTlIillSlwEHcNShqC87PbBEu
 VqWjBL6tgTUzs0N2xuKdb6QGzZG1f9IleyKA+KOsrYj9wZkWzkVslvJqWIbpf7r65+GqPMUIJqe
 Aju+z15vudcEw3ieaoA==
X-Proofpoint-GUID: 2GJvUMwfbl-d44JT_nQN6hnDJcAZstAz
X-Authority-Analysis: v=2.4 cv=SvwFe/O0 c=1 sm=1 tr=0 ts=6ac44361 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aLZfyF7oQ8oiUT2OKIMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 2GJvUMwfbl-d44JT_nQN6hnDJcAZstAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
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
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 897F045506
X-Spamd-Bar: -----
Message-ID-Hash: CKTH4B62KZDIR5JE2XHOLRIMHRDL2GKB
X-Message-ID-Hash: CKTH4B62KZDIR5JE2XHOLRIMHRDL2GKB
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CKTH4B62KZDIR5JE2XHOLRIMHRDL2GKB/>
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
rejected with RPMI_ERR_BUSY, allowing another active call to complete
before retrying.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/rpmi_abi.c | 124 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
index 58d82678be98..6e76316794c1 100644
--- a/drivers/tee/optee/rpmi_abi.c
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -9,6 +9,7 @@
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/overflow.h>
 #include <linux/rpmi_tee.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 #include "optee_private.h"
@@ -560,3 +561,126 @@ static void optee_rpmi_handle_rpc_cmd(struct tee_context *ctx,
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
+ * Only RPMI_ERR_BUSY rejection of the initial command permits retry.
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
+		/* resume_token is nonzero after OP-TEE suspends the call. */
+		.resume_token = 0,
+	};
+	struct optee_rpmi_call_resp resp;
+	struct optee_call_waiter waiter;
+	u32 result;
+	s32 status;
+	int ret;
+
+	optee_cq_wait_init(&optee->call_queue, &waiter, system_thread);
+	while (true) {
+		if (resume.resume_token)
+			ret = optee_rpmi_call_with_status(optee, &resume,
+							  sizeof(resume), &resp,
+							  sizeof(resp), &status);
+		else
+			ret = optee_rpmi_call_with_status(optee, req, sizeof(*req),
+							  &resp, sizeof(resp),
+							  &status);
+		if (ret)
+			goto done;
+
+		switch (status) {
+		case RPMI_SUCCESS:
+			break;
+		case RPMI_ERR_BUSY:
+			if (!resume.resume_token) {
+				optee_cq_wait_for_completion(&optee->call_queue,
+							     &waiter);
+				continue;
+			}
+
+			fallthrough;
+		default:
+			ret = rpmi_to_linux_error(status);
+			goto done;
+		}
+
+		result = get_unaligned_le32(&resp.result);
+		if (result == OPTEE_RPMI_YIELDING_CALL_RETURN_DONE)
+			goto done;
+
+		cond_resched();
+		optee_rpmi_handle_rpc(ctx, optee, result, rpc_arg);
+
+		resume.resume_token = resp.resume_token;
+	}
+done:
+	optee_cq_wait_final(&optee->call_queue, &waiter);
+
+	return ret;
+}
+
+/* The caller supplies SHM with room for command and RPC args. */
+static int optee_rpmi_do_call_with_arg(struct tee_context *ctx,
+				       struct tee_shm *shm, u_int offs,
+				       bool system_thread)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct optee_msg_arg *arg, *rpc_arg;
+	struct optee_rpmi_call_req req;
+	size_t arg_size, rpc_size, rpc_offset;
+	u32 parcel_id, nonce;
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
+	optee_rpmi_shm_get_identity(shm, &parcel_id, &nonce);
+
+	req.op = cpu_to_le32(OPTEE_RPMI_YIELDING_CALL_WITH_ARG);
+	req.parcel_id = cpu_to_le32(parcel_id);
+	req.nonce = cpu_to_le32(nonce);
+	req.arg_offset = cpu_to_le64((u64)shm->offset + offs);
+	req.rpc_offset = cpu_to_le64((u64)shm->offset + rpc_offset);
+	req.arg_size = cpu_to_le32(arg_size);
+	req.rpc_size = cpu_to_le32(rpc_size);
+
+	return optee_rpmi_yielding_call(ctx, &req, rpc_arg, system_thread);
+}

-- 
2.34.1

