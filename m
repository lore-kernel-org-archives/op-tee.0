Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4B606A326
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OsqdMDG9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NCi8QE3L
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8308E43A89
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:17:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OsqdMDG9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NCi8QE3L;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0AAA74549A
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:15:48 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59thbN3531984
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 11:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IYW802/Qaa9XiXUiT0voD+k5ybmaYLNb7JNC06e0GJM=; b=OsqdMDG9Ncb/MD28
	kruC4Km4xpxvkvBaiXxyPVsKmFcD8XWMYmpUGRX2GVDG7Y+BJnoyUuabh0xlINi3
	Wj2t+8pwNLDfZEugZMTGLFslQlwbHPP5F25bjyem/a9+X/2wp6M+NWsoYkx3B7/Y
	DR+25+BO3+T5L/rZt0WN5v3112O8GlG9MT7ZYe4E2VntVsCtKjj6P9BkuZCDbqbU
	Zr0BXBOwjy03vwOXgDJtdT8kq/badq97PdMQRtveSBttivD8PqGEygSBskgdNPok
	g/8u7T9HhNu4GrhfJuTA98wAzfby+b4FIhLoM/ViPo11rSrSVgz1TlgdizNrWEhG
	8iJVCQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9ag5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 11:15:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a3451ea93so2505703eec.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 03:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793877346; x=1794482146; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYW802/Qaa9XiXUiT0voD+k5ybmaYLNb7JNC06e0GJM=;
        b=NCi8QE3LqFUEtKp0dTgl/MqqvG8cAotFU32vAMcBcIUjRciYW0ilVlS9HdsvvqW2ds
         umuJo6QdmOeyKyBp8iPrueJhj+lWCFlHaintXdXkZ0A4jAqOLKFQQT/WKk2DOTC0T5sm
         KO4Z8o9dyfg0xtUDEuUvZQSxH7wFgygVIs+BrDCl3RLDHWwUppx6aH7X4v8ZTv8qwgNU
         I3yWENwQYMIrBAvCLN9sTLSCvb36Ey9xrFjvDdPjwiotdCN8H+JBKZ7p84GFmEEdllB+
         imGA+mNgPUpNC8kuMGEQOdW1WBHfoJbHkTghxZig5qov8g14TLetnpWtQKvTMkePFqp6
         n88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877346; x=1794482146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYW802/Qaa9XiXUiT0voD+k5ybmaYLNb7JNC06e0GJM=;
        b=T+Ik36aYA4XqjV4YDsHErfDOEzeqQEcurToYP5K8wfFK2vyadmzZH3fe/VtoLsCJ0B
         +imJo0ZliTR34s0OjJ8X05mfT4Dxu5zAHRw/HWLKuZd4UXRbCwr5kZMGqnmq7odToIo+
         qhuR636fHRfy3wYmDvnkGmNwriUkkplTCSKkKm/qcmyKRfdUMTEYs+Q41yTXpOB+Ydsa
         x2w+VJJsnsYRFWtAj6cRkxYCGiIybedMXqqcBQzs1/h+n55Wnvc/XQVifn2hr9trAEFL
         hWbFGwoGkjfutL686kDnG9A6xZ0Dr73PmS3Hgzn3VPa/D7WQ0/pr94cQqwAqDsyFFQdw
         292Q==
X-Forwarded-Encrypted: i=1; AKwUvBxrgups8Pe8a1Kp/A27/c50jX05u/NRuuD8yXA0+wD9ijMtOiMsRRdmtyCQyQrFxYLhh5kY4zo=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8Wzi7xH9dVCeYKhDnErbucLQ9jvfSHOSdP5W+HydrFonlrY7jS
	ebWUxcfduowr12HFlsaJllzElBOjcdaSg1girvvRc0YTk2dZAF16ETOvVkeq1NkBI/payG1CkeK
	uVH0LelzFovWaieFdib2v9gxJiw3xzn5A+4JaCiVA0wAGSo22WfjDitfopR3dwZx7OqYUDGMp
X-Gm-Gg: AYBFou0N56abFrof08DXgeY84sQ7hg1W68icZafpRQSi6m/ESZQw8WsLaobISKGbtg9
	O5T04mG8NRwgq5EvbG44nsAN9CIM2Rbk6GWX/fr4t7Vx5SbzdDmLsv0L0vbPwHonCdoPqUtPbVo
	QfTF/ByIIQuwA5CKm36zt2M+GzXyVuwuUJJBwC4CKPrIm9h70SnFEwpzhriEzJ8AV5HSsXSzrxj
	JmBd/UpD03xgrDDhSu3+MWRlY3cjCZhbrm+NVr4ER74MAnc+KJ20XpPNfa+dhlA+0EqI9CN4INX
	XrlNZr3cfRUXd60wgAfCklMlt+1ps1uTE6cY8ATpRD2lytvBuTrIBlzyDDyLHdqr9vm87mj4kFq
	E+yFk7lSlIrRKsPQzxO9FBp4L0loZLv5Jwa3umGm1APAZ8KaHoHTd3RI/0scKT1LSgDsaCYgeKw
	==
X-Received: by 2002:a05:7301:f82:b0:36d:c3db:9802 with SMTP id 5a478bee46e88-36dc3dbadffmr3983089eec.18.1793877344896;
        Thu, 05 Nov 2026 03:15:44 -0800 (PST)
X-Received: by 2002:a05:7301:f82:b0:36d:c3db:9802 with SMTP id 5a478bee46e88-36dc3dbadffmr3983043eec.18.1793877344250;
        Thu, 05 Nov 2026 03:15:44 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dd7ec8881sm14002125eec.18.2026.11.05.03.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:15:43 -0800 (PST)
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:44:51 +0530
Subject: [PATCH v6 3/7] tee: qcomtee: Allow object invokes from kernel
 clients
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-3-c7d68ce05c51@oss.qualcomm.com>
References: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
In-Reply-To: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793877323; l=7572;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=F5q5zcQHeA+fmIYDPCCU1wcOsANKXJgvP8zn4B9u0xE=;
 b=td45KK0r80vX9AClxuJcqMaXTRybkP2FbdDt0bQZ7lyuLUzJIyYwbbv+LzgpELEnM8Pi/gWP/
 ZboDbLEspSECMtEnMIPbKQ8DbmCaVOX8XnCUMGULYWvk9h9VzPKHtRH
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX7SadEEEjxHKN
 QnXCRsSpCK5O5t69wMoSsSGZjTR+elxPnvvj953nulSdcZKyF8Kx+THCQjklCBORYQHecAq9CxB
 HjA3Njk7Ru1XVhNSahRPDHAeU14WaVn62NaEJ/MobUWsdyZeE1xY0M2fiax8NzR5WD9DJUE+8k9
 lV6S0aK+8lDT2iCj0Rp+pOM57jpY0ZWhFniBHwdIuNAmgLEetQsuH7jpJT5GsKzUjAi5t2HdcVB
 +Z0pnRMKyblt+hfkTdjyFlOEvzJ9zU1nJ8GjulBkfR716ZbPNblwKGaSq3Jz812G7LzQPJ+TnMr
 G39tHzfJKXKbLFXbprNGcpxtmlxfPANgPWSO6QDO/XuLaB0pLCzTc84BuCPhtO1rERC6LufOFDL
 VYLWRwLRtpFx4x/4hwhCBFj34+svS1zJLCC7IF7xB7oRDj4dmcVru17ugFWAp4LWxn9TtK8pZOR
 OC1JkwCvDU8LGcMGuWg==
X-Proofpoint-ORIG-GUID: vIzA-toDUY26hoOEfojXLoEFqnNYe411
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX/rFR2Vu+h080
 ZpQ62kzpX7dwrXlKc2Ik+zIggKfpIY41kBcBtuqP6U6/4JY39VL8fY7HQZSKEJe99XiWeFCNgrD
 8MvKX3rDcF0poQGSrCmxP0F8oQgt7oU=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec6563 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2fm1Try5a8I-Yd-RT8kA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: vIzA-toDUY26hoOEfojXLoEFqnNYe411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050044
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[74.125.82.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0AAA74549A
X-Spamd-Bar: ----
Message-ID-Hash: UOLUFZPBEI6LQQYVMXH6PLUGCD4NFZPK
X-Message-ID-Hash: UOLUFZPBEI6LQQYVMXH6PLUGCD4NFZPK
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UOLUFZPBEI6LQQYVMXH6PLUGCD4NFZPK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

QCOMTEE currently treats UBUF parameters as userspace addresses and
applies userspace restrictions when invoking the root object. This is
not suitable for object invocation requests issued by kernel clients.

Use the kernel_ctx flag to distinguish kernel client requests from
userspace requests. For kernel contexts, do not mark UBUF parameters as
user addresses, and allow permitted root-object operations to proceed
without applying the userspace-only checks.

This allows in-kernel users of tee_client_object_invoke_func() to issue
object invocation requests through the qcomtee backend.

Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd
Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 38 ++++++++++++++++++++++++------------
 drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
 include/linux/tee_drv.h              |  5 ++++-
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 3de54af45719..c97afaa1b4aa 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -193,7 +193,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
  * @u: QTEE arguments.
  * @params: TEE parameters.
  * @num_params: number of elements in the parameter array.
- * @ctx: context in which the conversion should happen.
+ * @oic: context to use for the current invocation.
  *
  * It assumes @u has at least @num_params + 1 entries and has been initialized
  * with %QCOMTEE_ARG_TYPE_INV as &struct qcomtee_arg.type.
@@ -202,7 +202,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
  */
 static int qcomtee_params_to_args(struct qcomtee_arg *u,
 				  struct tee_param *params, int num_params,
-				  struct tee_context *ctx)
+				  struct qcomtee_object_invoke_ctx *oic)
 {
 	int i;
 
@@ -210,8 +210,14 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
 		switch (params[i].attr) {
 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
-			u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
-			u[i].b.uaddr = params[i].u.ubuf.uaddr;
+			if (oic->kernel_ctx) {
+				u[i].flags = 0;
+				u[i].b.addr = params[i].u.ubuf.addr;
+			} else {
+				u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
+				u[i].b.uaddr = params[i].u.ubuf.uaddr;
+			}
+
 			u[i].b.size = params[i].u.ubuf.size;
 
 			if (params[i].attr ==
@@ -223,7 +229,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
 			u[i].type = QCOMTEE_ARG_TYPE_IO;
-			if (qcomtee_objref_to_arg(&u[i], &params[i], ctx))
+			if (qcomtee_objref_to_arg(&u[i], &params[i], oic->ctx))
 				goto out_failed;
 
 			break;
@@ -260,7 +266,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
  * @params: TEE parameters.
  * @u: QTEE arguments.
  * @num_params: number of elements in the parameter array.
- * @ctx: context in which the conversion should happen.
+ * @oic: context to use for the current invocation.
  *
  * @u should have already been initialized by qcomtee_params_to_args().
  * This also represents the end of a QTEE invocation that started with
@@ -270,7 +276,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
  */
 static int qcomtee_params_from_args(struct tee_param *params,
 				    struct qcomtee_arg *u, int num_params,
-				    struct tee_context *ctx)
+				    struct qcomtee_object_invoke_ctx *oic)
 {
 	int i, np;
 
@@ -288,7 +294,8 @@ static int qcomtee_params_from_args(struct tee_param *params,
 			break;
 		case QCOMTEE_ARG_TYPE_OO:
 			/* TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT */
-			if (qcomtee_objref_from_arg(&params[np], &u[np], ctx))
+			if (qcomtee_objref_from_arg(&params[np], &u[np],
+						    oic->ctx))
 				goto out_failed;
 
 			break;
@@ -304,7 +311,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
 	/* Undo qcomtee_objref_from_arg(). */
 	for (i = 0; i < np; i++) {
 		if (params[i].attr == TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT)
-			qcomtee_context_del_qtee_object(&params[i], ctx);
+			qcomtee_context_del_qtee_object(&params[i], oic->ctx);
 	}
 
 	/* Release any IO and OO objects not processed. */
@@ -357,7 +364,8 @@ static int qcomtee_params_check(struct tee_param *params, int num_params)
 }
 
 /* Check if an operation on ROOT_QCOMTEE_OBJECT from userspace is permitted. */
-static int qcomtee_root_object_check(u32 op, struct tee_param *params,
+static int qcomtee_root_object_check(struct qcomtee_object_invoke_ctx *oic,
+				     u32 op, struct tee_param *params,
 				     int num_params)
 {
 	/* Some privileged operations recognized by QTEE. */
@@ -366,6 +374,9 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
 	    op == QCOMTEE_ROOT_OP_ADCI_SHUTDOWN)
 		return -EINVAL;
 
+	if (oic->kernel_ctx)
+		return 0;
+
 	/*
 	 * QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS is to register with QTEE
 	 * by passing a credential object as input OBJREF. TEE_OBJREF_NULL as a
@@ -430,7 +441,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 	/* Get an object to invoke. */
 	if (arg->id == TEE_OBJREF_NULL) {
 		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
-		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
+		if (qcomtee_root_object_check(oic, arg->op, params,
+					      arg->num_params))
 			return -EINVAL;
 
 		object = ROOT_QCOMTEE_OBJECT;
@@ -438,7 +450,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 		return -EINVAL;
 	}
 
-	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
+	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
 	if (ret)
 		goto out;
 
@@ -456,7 +468,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
 	if (!result) {
 		/* Assume service is UNAVAIL if unable to process the result. */
-		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
+		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
 			result = QCOMTEE_MSG_ERROR_UNAVAIL;
 	} else {
 		/*
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index 5f40617361fc..a241ab657318 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -113,8 +113,9 @@ struct qcomtee_buffer {
  * @b: address and size if the type of argument is a buffer.
  * @o: object instance if the type of argument is an object.
  *
- * &qcomtee_arg.flags only accepts %QCOMTEE_ARG_FLAGS_UADDR for now, which
- * states that &qcomtee_arg.b contains a userspace address in uaddr.
+ * If %QCOMTEE_ARG_FLAGS_UADDR is set in &qcomtee_arg.flags then it implies
+ * that &qcomtee_arg.b contains a userspace address in uaddr.
+ * Otherwise, &qcomtee_arg.b contains a kernel address in addr.
  */
 struct qcomtee_arg {
 	enum qcomtee_arg_type type;
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 369c87ad0205..367208210a32 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -83,7 +83,10 @@ struct tee_param_memref {
 };
 
 struct tee_param_ubuf {
-	void __user *uaddr;
+	union {
+		void *addr;
+		void __user *uaddr;
+	};
 	size_t size;
 };
 

-- 
2.34.1

