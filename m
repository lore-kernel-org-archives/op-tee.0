Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460D606A32E
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B3qLMld/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYtU+2jo
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E317645477
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:16:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B3qLMld/;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYtU+2jo;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3E0B94548F
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:15:36 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tKkJ1053147
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 11:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h2tJFFrgeLGaQIJ4J2QMFvkkhPDELzSwUHNctB/qs3o=; b=B3qLMld/L8EsPs6t
	hHHhNItnnqMUNMdPM7SubfsCc/kTa/mBPI6xJpbhiJ7mlxYPlC+YJ0heHXSxGBmx
	VjLLF735A9Rchyzy4+h0uXs5faeagGvbH1vPPocMkkWV+oYxkhe/z5huqNJaLwby
	iQNzqQYN/GivKgBQxWUQuW99WkkE3X747Av9/ue3jy4IFWe982OqW+A5UqumvqVA
	Ow5IBawrRrBzA4sbPCZBZhwNl6m95I0WtjDtBjK8WPLzdZZoBCx8JSZ9qzfdtW8e
	uR4oKuBhqT7uEO5jK+1GIyy7Y5cWSHaljP13arbKQGzfwrRW115fLdyTuQyxoEIr
	fsi3cw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9f8cpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 11:15:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36d1353fdcdso5242742eec.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 03:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793877335; x=1794482135; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2tJFFrgeLGaQIJ4J2QMFvkkhPDELzSwUHNctB/qs3o=;
        b=LYtU+2joxGbW0jKwt0EubzCVodWVtLmcD2nbDN4rgmsCHt3/YYE3ieB88JOtOveHVk
         YDwegVf3c62SZre7DFkbKFFDIjZpEZJ8GjC6+9kQ1029iDBuP0wYrVr7hiY8iwXStpKQ
         Bci8sgWnIWXZdvu9rfZDSyS52xQBQkx4SEamXMbXnj27giGoRcaA3SMEKwXlNDGoAVsv
         hjKVBYkv9GoUZL5OkNfGrS1UHBSUzDn8g9Gqeg8MDOqXpRd4pqoOC/I+Wdoja4izFpqd
         HBPunJEZKwqiINNQ4ciSxvz8uimcIv1Nb/D9iptZHyHxUPIfBUWuBDVLkvRBlN9bZKwd
         WVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877335; x=1794482135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2tJFFrgeLGaQIJ4J2QMFvkkhPDELzSwUHNctB/qs3o=;
        b=l9bJP4Y1ZuwNYjzyNKH8CDAztFFbqCYkr2DXiy8w7Vg7lKSzQNobdarfq4mZ3nFK9A
         0CefOePqy4wfpJGq8RUQk20HzZYr9HzhiVSz/hV6GVvUWjO5eahA8mT2eI9xTVqSin5h
         MKfCQxwSiFo8vfzPaLAYbILWNn98tDenW8XLOmJS0C/2EK3sG/ALhgShqCLKKUz8JU5N
         uUlmmSWGuERDMm07pnx+q2WCG1mT1To6AkLRY9V0QagIEEgBk8ZGMOUFgN4XueFL/YnK
         47e2kXOL7tB5/fa/IOdoTRHoGlFXNNt6kFbDOxXrHN0dUSbLjRumiW79mGljF2SI3weB
         lFNA==
X-Forwarded-Encrypted: i=1; AKwUvByQ3xXugDqn+Ovbr8sZbJ3Gv8sdIipqxzIk+azofuAQa1f5k++utI62NndzarZ1LpcBIb7VMyk=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8c0s+Zx+IqHa0YvFB+wm/FyRFTdZj2Si8Zur/ZmLGYLyazs0vA
	xGp88lFjwYSIZbc8miVe5uNNKpzaR/nI1bO0IFttTYwE5UnTKKT/TRdlnF46k+V68k/S2nR0w+l
	u1Ic7Uql8LzqeF0YT+5uk4cLkhBYCVzKe0Hdg/jZYs5AC4rfh1i6icq3acmeIWu6PMS1NtrqD
X-Gm-Gg: AYBFou2m1Y/sw/aZk9n8adeSd8Dx+gQhV937vRXx48Po9nMI0/pr3WRcXVFcAqwJoWl
	i14n8wXYr12/b2MT3sn4bNiKhXYsNpiRg9gvU9/TnmyusOO2W6FbLyhUsCBLtE4O8fS6c+VLFOI
	7ASnvdgKR0cU/NH/KgMQKQz+Ux1UOdOfBAMBY6PF2L8GVp6zwCsj03/S7r2hMhqAj5uOKkpXS3y
	icN1YIdoy6On4NqUx6+HdDQ16PcHcET5KAwEiMb/dtb24GhxYX2Q4TXS4POoss8ZM6RlJjDUjRM
	J+GZvf5AXlJFdGvxpQTPRoNw6lZfEG32sSMNuivER3XkT/T0A8X1obNhBjlf8mn1PSWTeLMHs+m
	1tIR5tUGKtBMwbUBqDJEZXkzb3oQ3D1AULy/vb343gBnNtff3DjwhObNLCIScxcygzAJ/z1zgLQ
	==
X-Received: by 2002:a05:7300:b2a5:b0:36e:9773:84b9 with SMTP id 5a478bee46e88-36e977399d6mr1173728eec.23.1793877334538;
        Thu, 05 Nov 2026 03:15:34 -0800 (PST)
X-Received: by 2002:a05:7300:b2a5:b0:36e:9773:84b9 with SMTP id 5a478bee46e88-36e977399d6mr1173681eec.23.1793877333729;
        Thu, 05 Nov 2026 03:15:33 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dd7ec8881sm14002125eec.18.2026.11.05.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:15:33 -0800 (PST)
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:44:49 +0530
Subject: [PATCH v6 1/7] tee: qcomtee: Track the object invocation context
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-1-c7d68ce05c51@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793877323; l=5531;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=x7TtrfjnVWlKZm3ThwgTIYoCmpFRPegZkJ+Pn2cNpoE=;
 b=/W5EXhOkgybs65hMsyArOx8DjwZlEfSaltIoB4TFknLU6N+SmxIprIYW+XRS0vvDgkwE45JaM
 58zGPy1JF7ZDvq8OFQ+ZIueoSNODSOtdkkkrAM+BzC+Lo2/r1hhjXPA
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfXzVUO4bgXQkFp
 Qk1e4skKW5T41RZDwStbXnTiUAkFBIYgxKovMsRJJWfw7m7t0n/shxq+5D8M+qp/j4I/BMtKL1l
 gxtlvJmxHy5hk6y5IcozO/VFz68JOGmxTMHjAkZhh7w89ODYWJsjNUD42qU/xVasw8tzxyvq20p
 khAjlK6YTJ5n8Lz7Cm1+CASVbSctCXEs790oaX8fR069bMBeuH7z8SF+as4OytB2plh8XGdZRpX
 Ayd/+zOmYz2POjOrs6+vFS7aVKaZ9oFVnGbtZKFwvlS3MXpj3bRgDdELbTRiqvDHVO+fm6H9MIA
 smuSekNe1WejCc2TjqNl7ejVineWEAIqUf7/9tSZU9HthbZqm0yw3WXGJw0MjRL8Hrz8vvy7S85
 71KLrMaeJkDl9WampoY1hwYXaMhRySalpXB/uGtKrpYjWUIIBSGULiyQTrDIL7o+Anv435hqod6
 me9OYfc1bkF2zWBN7kA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX3CEBBPN6HmIM
 qSCBOKO0WuCuT5UeBNek1ufJNSN1HfRKrf3RuV7VcC+5qXlF+wYTOIwyA4p8Wam396j7V0h4oMH
 R6xd0DsawwCt5krVyE+IpqWbNw74ci8=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aec6557 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Tj57qVV8HpgCqk1lqJgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: -DdiAt0xpxTJsPa5R-pcROHv1LpedRbZ
X-Proofpoint-GUID: -DdiAt0xpxTJsPa5R-pcROHv1LpedRbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
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
	DNSWL_BLOCKED(0.00)[74.125.82.200:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3E0B94548F
X-Spamd-Bar: ----
Message-ID-Hash: MIC3JBDUQCR4CQ3Q2WLJMCG3OJGKKZRE
X-Message-ID-Hash: MIC3JBDUQCR4CQ3Q2WLJMCG3OJGKKZRE
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MIC3JBDUQCR4CQ3Q2WLJMCG3OJGKKZRE/>
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

QCOMTEE needs to distinguish between object invocations arriving from
kernel clients and user-space clients in order to correctly marshal
UBUF parameters and decide whether certain operations should be permitted.

Introduce an enum tee_object_invoke_origin to allow clients to indicate
the context of the TEE object invocation, and add a kernel_ctx flag to the
QCOMTEE context so the TEE back-end can track it.

Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 12 +++++++++---
 drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
 drivers/tee/tee_core.c               |  3 ++-
 include/linux/tee_core.h             |  8 +++++++-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 4a597eeaf174..3de54af45719 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -388,20 +388,26 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
  * @ctx: TEE context.
  * @arg: ioctl arguments.
  * @params: parameters for the object.
+ * @origin: origin of the object invocation (kernel or user-space).
  *
  * Return: On success, returns 0; on failure, returns < 0.
  */
 static int qcomtee_object_invoke(struct tee_context *ctx,
 				 struct tee_ioctl_object_invoke_arg *arg,
-				 struct tee_param *params)
+				 struct tee_param *params,
+				 enum tee_object_invoke_origin origin)
 {
 	struct qcomtee_context_data *ctxdata = ctx->data;
 	struct qcomtee_object *object;
+	bool kernel_ctx = false;
 	int i, ret, result;
 
 	if (qcomtee_params_check(params, arg->num_params))
 		return -EINVAL;
 
+	if (origin == TEE_OBJECT_INVOKE_KERNEL)
+		kernel_ctx = true;
+
 	/* First, handle reserved operations: */
 	if (arg->op == QCOMTEE_MSG_OBJECT_OP_RELEASE) {
 		del_qtee_object(arg->id, ctxdata);
@@ -411,7 +417,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
 	/* Otherwise, invoke a QTEE object: */
 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
-		qcomtee_object_invoke_ctx_alloc(ctx);
+		qcomtee_object_invoke_ctx_alloc(ctx, kernel_ctx);
 	if (!oic)
 		return -ENOMEM;
 
@@ -648,7 +654,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 	int result;
 
 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
-		qcomtee_object_invoke_ctx_alloc(ctx);
+		qcomtee_object_invoke_ctx_alloc(ctx, true);
 	if (!oic)
 		return;
 
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index d5de02dcef3b..5f40617361fc 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -147,6 +147,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
  * struct qcomtee_object_invoke_ctx - QTEE context for object invocation.
  * @ctx: TEE context for this invocation.
  * @flags: flags for the invocation context.
+ * @kernel_ctx: flag that indicates this context is owned by a kernel client.
  * @errno: error code for the invocation.
  * @object: current object invoked in this callback context.
  * @u: array of arguments for the current invocation (+1 for ending arg).
@@ -159,6 +160,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
 struct qcomtee_object_invoke_ctx {
 	struct tee_context *ctx;
 	unsigned long flags;
+	bool kernel_ctx;
 	int errno;
 
 	struct qcomtee_object *object;
@@ -173,13 +175,15 @@ struct qcomtee_object_invoke_ctx {
 };
 
 static inline struct qcomtee_object_invoke_ctx *
-qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx)
+qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx, bool kernel_ctx)
 {
 	struct qcomtee_object_invoke_ctx *oic;
 
 	oic = kzalloc_obj(*oic);
-	if (oic)
+	if (oic) {
 		oic->ctx = ctx;
+		oic->kernel_ctx = kernel_ctx;
+	}
 	return oic;
 }
 
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 1aac50c7c1de..30901390149c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -701,7 +701,8 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
 			goto out;
 	}
 
-	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
+	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params,
+							TEE_OBJECT_INVOKE_USERSPACE);
 	if (rc)
 		goto out;
 
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index f993d5118edd..bcb5418d6fdc 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -73,6 +73,11 @@ struct tee_device {
 	struct tee_shm_pool *pool;
 };
 
+enum tee_object_invoke_origin {
+	TEE_OBJECT_INVOKE_USERSPACE,
+	TEE_OBJECT_INVOKE_KERNEL,
+};
+
 /**
  * struct tee_driver_ops - driver operations vtable
  * @get_version:	returns version of driver
@@ -117,7 +122,8 @@ struct tee_driver_ops {
 			   struct tee_param *param);
 	int (*object_invoke_func)(struct tee_context *ctx,
 				  struct tee_ioctl_object_invoke_arg *arg,
-				  struct tee_param *param);
+				  struct tee_param *param,
+				  enum tee_object_invoke_origin origin);
 	int (*cancel_req)(struct tee_context *ctx, u32 cancel_id, u32 session);
 	int (*supp_recv)(struct tee_context *ctx, u32 *func, u32 *num_params,
 			 struct tee_param *param);

-- 
2.34.1

