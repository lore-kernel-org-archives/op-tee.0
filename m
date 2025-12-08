Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60ECD1CDC6
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 02:09:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DB916500A3
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 02:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765159747;
	bh=w22HP/nWRJ9nhoyTEjTWOnQ37ZAtJa5ZC5/dfp5OLeE=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=0ggdkauBg3ZLXm2Wybh7ph/XuD/oUl84cZUVBf2i/xqWSCNA51QEojQ65Br2pkQAO
	 k958iDOFt+sT3Ph6fd8UjbuTLT9A5gYjnyZbw2i0lAw2HM0vWuNxhHQm2Y6RpuHcRg
	 zyn7k1tuFMm7HM2mjPl/s5bCn0Bn98o86BLjF3w86tWt4MLIkfbap8yGWA6/6/5sGO
	 TnMIew9x8Yxp0ZoL/6PeUZSTdMqyWV0H7AGHwOu81QWcXoCXucBEpdB0Mg16570hd4
	 xi58Nx0OKou7q8eBK5YXiedPBqyaHaYkQmpPMteRhedPA3ApoxPZC10o/oN0WjnR58
	 rYS47mLkCXMmA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 33B514305F
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Dec 2025 02:08:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DuWPJJfa;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SVxgbQUg;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8275BB3669952
	for <op-tee@lists.trustedfirmware.org>; Mon, 8 Dec 2025 02:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3WGP91XI/V9pC6GHpPekKA9aM8v3JArvb7k
	xBbMuT+w=; b=DuWPJJfae82nm9aSa4NLHewlNBhNqtxTpAKhFVcogm7V1nbuKfN
	yeWDSvUJ8gsOjXmHhViBhMcuuF2+mIuXuzDZ/7OpHpiLz8RIPVcQfGa73VeIwNyF
	na+GS8bgINAxik9G+Kf4iqyhAM9BXpYaHZE1Kb8waLYkKVtfbLhEnsECzNSq+dBf
	1biAouLKkRIzMW7H1/iV23EhkXHUHZjFstAwAs8jZljtAVBq2MRHtkQMcG9vIFBC
	JfoGNz9xxfves7p+fyOqLiXaPBviRfZTqg8XYmcheJy+mmOS/KeA7pdJH8tdHTDV
	p4nvCKPkk10YxP/dB38jHMcFoV+z7QjMnGQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awnkr004c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 02:08:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3438744f11bso7794956a91.2
        for <op-tee@lists.trustedfirmware.org>; Sun, 07 Dec 2025 18:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765159732; x=1765764532; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3WGP91XI/V9pC6GHpPekKA9aM8v3JArvb7kxBbMuT+w=;
        b=SVxgbQUgofdYWvoTwaUfsQ+2aOhpiRH7srtXCVZq5twL25UFbqL587AV741cqazat7
         FmZExB4d629Ueq/kgn6WyZVBYvLhHauTQnou/BC8SWYLT5XfAoV3/tJ6XGzF/l4cQPbO
         C1L7qEb5zhTHn3QmlwCeiLBN9RGSMrfiHD4UEKmBctSVNAtj1X1VmZ3QHRLS1FTfvhct
         TYQS3356tRoZ9WuJYiFx8hrLEC153p3lwsNr4oEaYKMZ6NjsJQ3v0E7q4zZP3sHADFrC
         EdEpFmDeBKFexrhsIbCr/2XP9CMYVgVFxJuQYWqlRvmXeKgorEaBLB/xj2KpH0eNoRUj
         iUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159732; x=1765764532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WGP91XI/V9pC6GHpPekKA9aM8v3JArvb7kxBbMuT+w=;
        b=npxMGzkrcQb3yU6v9Kqd3T4qZ8GtHAItw//Sp07EMIYcW3zxX9jGlYxlF5xyh0PCCI
         h3+kL8P20Z9cOa/EyxA9jLVfFckqKp8YSLCXucIa1+7v8mkx6mRvq70AoMDZJv+Fapos
         gYQSFnJTqOj5ZtIMpdIe4vcay0lHS6k6KPwmOSnskd5/IvBnPHDI6smqBTDPfoUHBWjD
         LYEZiVXPiNbThbX1hd1nyshbfMLv8FeouwOdvBuNyoy3Bb4wE6mjpa66MKU++VXYkEM0
         arvx+znyncIvoxWD7T3Go77xjaNVQSyzbPdLnLZ61eqqS1QcXuwv3p5jkwiLFwBsgXZ0
         oFSA==
X-Forwarded-Encrypted: i=1; AJvYcCUTLUcGkTpIc6gVYzsl+4+rJvU09y/UH+zfX3ut4yVzlMvKIgMT7ouyUTfv2rZ00TNAaNGfihA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwOySigvG98k+Id52PLrQzlZ8qM/d5+9XEGerfddp/XBNKffcxu
	Xxk9OLKjKJwi/E1OerKZXLRJd0TA82RwRikNdI0EDG/Rwu4Uy8+zACyNTd3kvIzXVWjqxbd3huA
	PJbjMo10quTEFQcGIBCLokAks2dH7SPvcK1ktXGPITtSKkoMgOJaMSJV8ZGyMhFcKkyg8XZGY
X-Gm-Gg: ASbGncv42Ui/3FzAVlP17n+N7Ug1v/edhxD5MuAD0rK+O66qBt4OoMHw4+kjK9D/O5B
	LkrdlwnsDyYBSAyz1lNprR3qJJAjiY2SJ3hyY4fl7wIXAXRzhBio3pRfw2jMlqdRLRClSYdvhDA
	CK2PcAIPXQNLOqASEKgDeoBeplC8ppOfNPIEyX7FVzcMimNvp+cK3EebaB8zF0EAyw0UWG1xh+p
	NK5p1fKNWjHmWImXs49pAg6nDqUEHbtGig+HdqpeGQrA+loXz0kPbBsSnIEthp0zhqEEgzHFw6Z
	Upoi7czbslCA5ANpMJzPcH6Pnjehtr+lCoUkioU16NBko1R6Y/s/Ec/YcxEHQyy0Uv7i/YgQQUN
	ZDGRHCGds8oqIxG53DewyZr6tv+lS7eQfDRgV09pgvpuuLfUZ1CzOtY9R
X-Received: by 2002:a17:90b:2fcf:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-349a25bccbbmr4669258a91.22.1765159732471;
        Sun, 07 Dec 2025 18:08:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrG/5bwhMAhRxYN0RWld3QNF2ZqZ5pChxoPhW9jJoYuDTIhqiBe8YPegtrhEZ5+5m+3NFPEw==
X-Received: by 2002:a17:90b:2fcf:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-349a25bccbbmr4669233a91.22.1765159731996;
        Sun, 07 Dec 2025 18:08:51 -0800 (PST)
Received: from quoll (fs98a57d9d.tkyc007.ap.nuro.jp. [152.165.125.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34986460717sm6481676a91.5.2025.12.07.18.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:51 -0800 (PST)
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
Date: Mon,  8 Dec 2025 03:08:45 +0100
Message-ID: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2937; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=w22HP/nWRJ9nhoyTEjTWOnQ37ZAtJa5ZC5/dfp5OLeE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpNjMsmjXlLw1xsJumQ14vmDefJJ/qUkCdcVsO+
 tSM1ublOJ6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaTYzLAAKCRDBN2bmhouD
 13LhD/0VSMflZEH1bwUcU87tggaD+IPWfPu1oV98XZbYGoYzGNCHLEdoFrVAPnJ7jOEidBdwnYl
 dn4EPipxw9IpKyOKnlRzaoU19U5Qx5X9vGxmS6X5h+6hUCS23hfdya1kMZ56FDEX/5QWrCxfN5T
 YSnWnBf+HN+cBQcWwQLQ6k+oD6/KVkqPlTizkI4IbQ8DeWOdowqTluoKrQfTcQNnBby3mVIUckr
 /p2FpgHJ8WcqdvGKfqMhELcJ2mDS3l7sF7lxBd3NmhX2+hCvtvSWpwdH/V4HRtXeLGrLdMunSTi
 p8ua+AA3dRQLRrHyPF4z++JZ02bliPtJeMJRlxZq7jQLrTZxyImttlU9IYKMr5AROeKd9x/4PFA
 h9S9e3uuA56/I0GJkPEKd7LhKfuqrcPVU4pS8A5VJyjjlgGSypMC8ktczimruZip9jdIJyP3KoR
 tH7rwm4aEDmtfWCJ34q75CJ1d59Jl9eu7WMuKeaCaWHqj0Tr7TAxt3s82jdv6v2Qlx/JleEt/rr
 5awpNAUSHp/SN8Sn/9pg+Z1okK6z42wdky0FNbOqDnc98I7cmou9XLCFp3Iin5UMR1Ctrydd6BG
 B9XRSOYXnQ/LOLFvzUImohsbYEXfYA1fjkTh5UpNveQmx1syPD31v8MHsmwg1FhS9gDPK8TGpsP nAF6mq+lk/pNThw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDAxNSBTYWx0ZWRfXx41Com5F9Rq6
 hqSaC8Obx64DQIJNgN7LQga3Jgii+MEkE5oSOm0wfH8KPiTyoZcvgQLBJW62merphu/JzhHHNT2
 zYVQ1ZAgUbZeVXOKlYW9nepiUegJK51OEPnyBHgc2HTUtAT4CCC8fhF8JnQFX4H1W3NgPKyM7IB
 EwumACf3yFORctg1wpQ66L0CRTKE68U4RIcZ6TDF+fteNQEt0JTmhSa4+dEaaisEzq33gIUwjQ1
 N9gP4kojep5kky/Oa2aek5kJPnNuY893tx30CBWm/AOH5PtkEh/6eHoKW8GE5gLsHL+/ySpAvSf
 Oo9ZRu62jO3hvTOvkZL1oQbnHTX9eme78b5aqjGaQzAkmv2T10nwH5nMw5rgZtfh1350XlHH6AY
 JA1LQGycq5GSTuPfH8RGFAsne37oIQ==
X-Proofpoint-GUID: QhOMonSlcJ8WTdWg3uiVJ3QRyM5vTk1D
X-Proofpoint-ORIG-GUID: QhOMonSlcJ8WTdWg3uiVJ3QRyM5vTk1D
X-Authority-Analysis: v=2.4 cv=RMy+3oi+ c=1 sm=1 tr=0 ts=69363335 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=vTE1kzb4AqIx7XBf0Bkr0A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bnnKY8jWoa2RUCiOtN4A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080015
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 33B514305F
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: KJO6LZPRDRTPEIXR6MITN5F3MTJ76BPP
X-Message-ID-Hash: KJO6LZPRDRTPEIXR6MITN5F3MTJ76BPP
X-MailFrom: krzysztof.kozlowski@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KJO6LZPRDRTPEIXR6MITN5F3MTJ76BPP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Initializing automatic __free variables to NULL without need (e.g.
branches with different allocations), followed by actual allocation is
in contrary to explicit coding rules guiding cleanup.h:

"Given that the "__free(...) = NULL" pattern for variables defined at
the top of the function poses this potential interdependency problem the
recommendation is to always define and assign variables in one statement
and not group variable definitions at the top of the function when
__free() is used."

Code does not have a bug, but is less readable and uses discouraged
coding practice, so fix that by moving declaration to the place of
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 65f9140d4e1f..8f8830f0df26 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -395,9 +395,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 				 struct tee_ioctl_object_invoke_arg *arg,
 				 struct tee_param *params)
 {
-	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
 	struct qcomtee_context_data *ctxdata = ctx->data;
-	struct qcomtee_arg *u __free(kfree) = NULL;
 	struct qcomtee_object *object;
 	int i, ret, result;
 
@@ -412,12 +410,14 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 	}
 
 	/* Otherwise, invoke a QTEE object: */
-	oic = qcomtee_object_invoke_ctx_alloc(ctx);
+	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
+		qcomtee_object_invoke_ctx_alloc(ctx);
 	if (!oic)
 		return -ENOMEM;
 
 	/* +1 for ending QCOMTEE_ARG_TYPE_INV. */
-	u = kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
+	struct qcomtee_arg *u __free(kfree) = kcalloc(arg->num_params + 1, sizeof(*u),
+						      GFP_KERNEL);
 	if (!u)
 		return -ENOMEM;
 
@@ -562,9 +562,8 @@ static int qcomtee_supp_send(struct tee_context *ctx, u32 errno, u32 num_params,
 
 static int qcomtee_open(struct tee_context *ctx)
 {
-	struct qcomtee_context_data *ctxdata __free(kfree) = NULL;
-
-	ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
+	struct qcomtee_context_data *ctxdata __free(kfree) = kzalloc(sizeof(*ctxdata),
+								     GFP_KERNEL);
 	if (!ctxdata)
 		return -ENOMEM;
 
@@ -645,12 +644,12 @@ static void qcomtee_get_version(struct tee_device *teedev,
 static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 					  u32 *version)
 {
-	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
 	struct qcomtee_object *client_env, *service;
 	struct qcomtee_arg u[3] = { 0 };
 	int result;
 
-	oic = qcomtee_object_invoke_ctx_alloc(ctx);
+	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
+		qcomtee_object_invoke_ctx_alloc(ctx);
 	if (!oic)
 		return;
 
-- 
2.51.0

