Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52540C44500
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:12:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A176644E27
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783404757;
	bh=swwFCmvhnGXLtV5EjzA1jpj0y1exqoHCd9lIGCRTTXQ=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QIuPvGV5Zsea1/ZuQdhdoVU5KGRvQYCByhXGISp6x3/cCZLDIG60vfQJL8jhlKXU3
	 cVGB6J3d84ne/iOdzH9CSRVuyM8xqCKdrL7T+7y1Dt7FmPgxrhb0QMo8jK394MLMDa
	 L8AHZFUOMc6cskZFd+zTEMPcZMAMbNCk6FoFJPAX80b8kLlrfewxjmIZuWuLisWdUG
	 matmxkWAYH9J5pD1Nv21GwsKAqZJA/TbNdPiNlvaTD24cAP2NZeyfxk2uJ2KhdDmZZ
	 ut4hlagclvBe3HD9AlU+Ud3owagxkcznCY1DlkMQVhMYpY+/BWAOQ3G3vvEc6FQA5s
	 RNCIrBnBe73UQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9F3B843815
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Jul 2026 06:12:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MgzdsOOT;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ikmCrp2G;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66749JDi2670685
	for <op-tee@lists.trustedfirmware.org>; Tue, 7 Jul 2026 06:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N4XA902sDhftTe3c8fF1ABgOsUEkFzIp03BayNh/XVE=; b=MgzdsOOT5RJ9e31e
	hc3ZIEwiV1AkpBSL/D4Gc2Cge35bG4qmW1gYn2At0m0ZK9L5smuDwgcI6vKHJ+uM
	bAw9A/oY44UpE+gLSS8V80ENUhyBKz4kwVINI2TN187Fqh62YmpGqp6R/HsDfI9v
	LAn7cMGZ6KWhTCxOAaE6CYgGkz10Tz0gC3WcAJNnL7o40RODPt6KoE0b2Jx/kDX+
	r5fjNe4X6EQnz5pG+PJdR74W2VWdyd6M2pDnJNTZkySu7k/R729UQs0Zh9b1etqv
	6m7LvxzJltaYZnb5F9XlzRp0T4iBOzZB6OdvAyigSmSu0Cguei+ZqRivG0L7pn+z
	zIg5QQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgvhm8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 07 Jul 2026 06:12:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-845a29d8c1eso6130689b3a.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 06 Jul 2026 23:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783404724; x=1784009524; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4XA902sDhftTe3c8fF1ABgOsUEkFzIp03BayNh/XVE=;
        b=ikmCrp2GdDlNskOpqytwYWN6TArwJfdwuVOH5qAoOu5eq/Vr58aoUthMnHWbjmH/ri
         EG1oYt7qaicJjOVBC8XqbzXxLQheTKhsBnVKUYURf+CnT+mQFJnZ50GE5m89Xo0xhDxL
         gTk28NV87HUplU9l4vd0OkFV4iCevgaeEl7P9Co978Ehk1kiD0MToqu6LCc4c9Q20hIQ
         RjP8N+2IgO5lbPkgYpg2gzmjMm40uHjYOUX6BjF+LPcEHAjHszLLRQ7Aca4nyhXu3Rv5
         NtTYh1tLlmckl1eV8GA+U4jn807nO5dx5d7wJbHhAsLJ3qfzP4OvVILKdUM2d+RZkMb6
         O0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404724; x=1784009524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4XA902sDhftTe3c8fF1ABgOsUEkFzIp03BayNh/XVE=;
        b=GcmmRHNrabwidyJPBcyJGT9LEpfoj/g+yYl4OfaB/K5p0mZGSw+IxQKiAcQH1HcUfm
         Nd+tpAql3sLh99RX/xwQTNsr7hso4nAJ5o0TurPVkbzqvRgB40TM670lU3CSaf9KuxIC
         slPrm+g+LWsP1LgDbtqHhQ8Wf1CF+vyZw9Bxq8jtAoCn6w38UfcD2AWvqoVea8rjGCpY
         SietFpx38Gus834htn+5dSIEQWLhJOWentVLJvWUeAUI2FyUSahsWkuGO4mTvtzCBTxf
         75aKrb+W48iywfYSr2KTiUpGf7usqK27EbN7NifWrqpOB9IsJKJQ/0Khos6l9hsyOI9x
         QETQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVyDc4LiRitaAi0fqRKMGpl5wJlDL1EemiFWzTM2G4Tdr4B5OoG6WbA2/OVATu3QCW33WiS8Q=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yztq9faNheWdqWQozca9Ek/+ZCtnexo5JVWitQdtR9RJAAfM2gf
	urrgC9/2KOAhnSVx12WVcC5H4Kiunhe5OonTl2NRfZ+MpNX3V+28plKeqPoFR1IBgtdzg6pvoKI
	A/A1q/SLpT++Zo/JLxlzdpQSKjsAJgj1kVI3WZnoRDVepnRjvivlGVE7F1KAMRreaQUxECvH/
X-Gm-Gg: AfdE7cm9lCyFKsPYeVu/RNJy0+N0epGZH+L9I9dUfx0bHdHZ1InwT0/ToEWmmYH/HXi
	0c0EJBSZ4saQ4uumzO9Lg0pLFkp0rbUXRRksAiKJvOrcUTi6RNxhHblofpU4Mm0Hjsm0Sg6F/Qc
	n8Wc3cYlSD0bLCFukUFiHo0nfFU9aK5XOBTC0uYGrrGaDpcfX7riBJ+zXnDV1j8qTpKhJS57t1L
	fK9hP119YzG5FrTdgvpkbyZiXo4olHQjwjhriOVDP1Xs4gEDgWoJNYzE4NoAb1oGQUWa+CnHKd8
	QbU7SrTvQL9wzU8JdY8hm17jZLfoMjJVvSGg6ejh1O5u2Lwz2L1RsPzjMJZtRGJq5QnaKhV932N
	d6065PJD1ZtkDwn5StPxGJBHSeTBHgHTVYOkh
X-Received: by 2002:a05:6a00:94d2:b0:842:83d1:ee6d with SMTP id d2e1a72fcca58-84826d9e918mr3749321b3a.45.1783404724112;
        Mon, 06 Jul 2026 23:12:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:94d2:b0:842:83d1:ee6d with SMTP id d2e1a72fcca58-84826d9e918mr3749288b3a.45.1783404723570;
        Mon, 06 Jul 2026 23:12:03 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm3299321b3a.8.2026.07.06.23.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:12:03 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:41:27 +0530
Subject: [PATCH 1/6] tee: qcomtee: Track the object invocation context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-1-f659cbd5d04c@oss.qualcomm.com>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
In-Reply-To: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783404715; l=5636;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=swwFCmvhnGXLtV5EjzA1jpj0y1exqoHCd9lIGCRTTXQ=;
 b=uf/oPxl1JN73Nkc3YvvPVlkXI6dU3u1y1EVY3cA+GokfjTWaK15SIJ+daxxeOjzpHQYxkQLy9
 2h2RSJwJ3AqDSDtIpcr3/0KejM+HrPn7XNC9tsN1E41B3PIXQJpD1Lx
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: njbhMoSyfwVMtZCLO6HzVAEf4vV3XOWp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfXzONA4ucEQq43
 CgtSpovYiF50/gZpnWY4JsCrTDJawFesjacQWgOBAA5e/egOUL0ZptHAUkj7iN6iliPlyBTyOw2
 073YEIeBd0aLhWiczMjFiwOKH+8zqFwzgI66DWU5uZYYBrqaQ03aBZvnq3xXs6QQIdp7D4OJtzo
 N4aeqUP8vdiddAgTWitKsWi9N6ykHnv+xWzw7nThgYiq5+3hcOPrSkEe2s4V9gckrxolTnhZgB7
 Mudrvk270IasokFXTpXIi8P8cttGjz7H8a0pq+7ZI9yVs48ZUkdM8eKB7/bW1Wgg4fD7zgRbj+M
 4/mmGcye8GsqUHKFIZcJ/vpB+5VImJG2M0Uhr+5aSyvQfm9iXENuoUYAW/h0JZnc79q4lAv+6tv
 Q6RtnnH5Ke2zlt1r2bKVqEjHF+MqTneGwPtey6C35l5Teyc0O1tQVKPlr5i0KwwWDYHMch06wTZ
 VZwBvKDzXZNH3fQlP0Q==
X-Proofpoint-ORIG-GUID: njbhMoSyfwVMtZCLO6HzVAEf4vV3XOWp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX0l1sygMFnb1I
 tiOU7dS2b656BFAt4POGf/Mv26rUwyxl9gV2GJpdAvhw1QHf4H0IlLzzIzVWQ8308U8SYF6Gwob
 HPpGm7bQEXNsEULeh6EYkTWmhDWVpKo=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c98b5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=BWs0V4_eQumgdb2k_SYA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9F3B843815
X-Spamd-Bar: ------
Message-ID-Hash: 4ZQ33GIV7J3OPX44GDU2WM6TGDUVBTXE
X-Message-ID-Hash: 4ZQ33GIV7J3OPX44GDU2WM6TGDUVBTXE
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4ZQ33GIV7J3OPX44GDU2WM6TGDUVBTXE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

QCOMTEE needs to distinguish between object invocations arriving from
kernel clients and user-space clients in order to correctly marshal
UBUF parameters and decide whether certain operations should be permitted.

Add a kernel_ctx flag to struct qcomtee_object_invoke_context to track
the context of object invocation. Objects invoked from the kernel-space
are expected to have the MSB of their 64-bit object-id set to indicate a
kernel context, whereas objects invoked from user-space should not set it.
To ensure this, we restrict the object-id space of user-space invoked
objects to 32-bits. This is in-line with QTEE expectation of 32-bit object
ids.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 24 ++++++++++++++++++++++--
 drivers/tee/qcomtee/qcomtee.h        |  6 ++++++
 drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
 drivers/tee/tee_core.c               |  4 ++++
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 0efc5646242a..a74a54d67b06 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -397,11 +397,31 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 {
 	struct qcomtee_context_data *ctxdata = ctx->data;
 	struct qcomtee_object *object;
+	bool kernel_ctx = false;
 	int i, ret, result;
 
 	if (qcomtee_params_check(params, arg->num_params))
 		return -EINVAL;
 
+	/* Obtain the invocation context information from the MSB of the object
+	 * `id` field.
+	 */
+	kernel_ctx = QCOMTEE_GET_CLIENT_CTX(arg->id);
+	/* User-space identifies a NULL object via a 32-bit TEE_OBJREF_NULL id, whereas
+	 * the kernel uses as 64-bit object-id. Hence, we check for a NULL object by
+	 * sign-extending the object-id to 64 bits. If user-space is indeed invoking a
+	 * NULL object we must extend the object-id to 64-bits from here on so that
+	 * QCOMTEE can recognize it.
+	 */
+	if (!kernel_ctx && ((s64)(s32)arg->id) == TEE_OBJREF_NULL)
+		arg->id = TEE_OBJREF_NULL;
+
+	/* If the object being invoked is not NULL, drop the MSB from the `id` field to
+	 * obtain the actual object-id.
+	 */
+	if (arg->id != TEE_OBJREF_NULL)
+		arg->id = QCOMTEE_SANITIZE_OBJ_ID(arg->id);
+
 	/* First, handle reserved operations: */
 	if (arg->op == QCOMTEE_MSG_OBJECT_OP_RELEASE) {
 		del_qtee_object(arg->id, ctxdata);
@@ -411,7 +431,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
 	/* Otherwise, invoke a QTEE object: */
 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
-		qcomtee_object_invoke_ctx_alloc(ctx);
+		qcomtee_object_invoke_ctx_alloc(ctx, kernel_ctx);
 	if (!oic)
 		return -ENOMEM;
 
@@ -648,7 +668,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 	int result;
 
 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
-		qcomtee_object_invoke_ctx_alloc(ctx);
+		qcomtee_object_invoke_ctx_alloc(ctx, true);
 	if (!oic)
 		return;
 
diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
index f39bf63fd1c2..5d292a2ff83d 100644
--- a/drivers/tee/qcomtee/qcomtee.h
+++ b/drivers/tee/qcomtee/qcomtee.h
@@ -17,6 +17,12 @@
 #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
 #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
 
+/* The MSB of the object_id field indicates whether the client is invoking the
+ * object from user context or kernel context.
+ */
+#define QCOMTEE_GET_CLIENT_CTX(x) (((x) >> 63) & 1U)
+#define QCOMTEE_SANITIZE_OBJ_ID(x) ((x) & (BIT(63) - 1))
+
 /**
  * struct qcomtee - Main service struct.
  * @teedev: client device.
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index 8b4401ecad48..2528d07e4576 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -146,6 +146,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
  * struct qcomtee_object_invoke_ctx - QTEE context for object invocation.
  * @ctx: TEE context for this invocation.
  * @flags: flags for the invocation context.
+ * @kernel_ctx: flag that indicates this context is owned by a kernel client.
  * @errno: error code for the invocation.
  * @object: current object invoked in this callback context.
  * @u: array of arguments for the current invocation (+1 for ending arg).
@@ -158,6 +159,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
 struct qcomtee_object_invoke_ctx {
 	struct tee_context *ctx;
 	unsigned long flags;
+	bool kernel_ctx;
 	int errno;
 
 	struct qcomtee_object *object;
@@ -172,13 +174,15 @@ struct qcomtee_object_invoke_ctx {
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
index ef9642d72672..7f986d7fb47f 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -706,6 +706,10 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
 			goto out;
 	}
 
+	/* Userspace object-ids are restricted to 32-bits. */
+	if (arg.id > U32_MAX)
+		return -EINVAL;
+
 	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
 	if (rc)
 		goto out;

-- 
2.34.1

