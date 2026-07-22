Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93ABC4451C
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:01:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 23F2F450DC
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784703718;
	bh=ltTUr4ZNz1WK8n1xoNtPuphhExPvrUNLbuEMZg8+YzA=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=4DPJByii0pMIzp+eCE8VzeACKWB7ohbJ8y6j3bZK/oduEH77K886mWJwfP77pJ85v
	 FVULocsRBGfKWvpu7JFlwQsVkSXvIYj6YfsgoRgDvUCrisxpYf7JskRrKl37nV4ejT
	 ZstM7UGyEjtgozrOGqeGOhoNjx6ev3CmWkdAmMWw5PHKvHX9x+j2yqHMI+HywDJMBF
	 UNumrurMjSBttWV+N97iz1lw4kv4u75T4uCCYkmVS/Mq2ByCgzrJ8ZBFi2//VOcYnC
	 oNhovM+nI/zUhBJutR8vpnrrvhH5dksKCUx9h6wLevANHEd0+8evuFuyKNAutTvW6i
	 +no8uxcnBBILA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7EA5343DFC
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 07:00:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k6Cwq5Pf;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hmk06C4j;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53gDd3473526
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 07:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z7g91lbv5RV9lZPR9a6UTHIBqV9Y4ZqcpArgNql62cA=; b=k6Cwq5PfeE6QB+Hx
	EYJhzHCY3i0gmOedVUIhpY3D0eyGv2i1svyuPpqqJiwBF7TPq87wLlLcWhFk+1B8
	0aTfRaItVY9Qki/npFrecIViW5EcgK8tDQBrUW1D+olpOEU7AN5bD932DLNwuUMb
	iLQpkCnEQ8XoiTwQ+zwU3D594sQwaDyggCFJS6BJPbp6au9n1UOtklA3zaJeu9gh
	yp9cghMG1rGHAqAmcHJgEkdo2BuzMtCcl+x5ysqq1ygFwfGHnwJnYzjhaHqhsvQH
	YfoTHylGCK1n/5Vknw0yCeoVufYp+WuhDawxqRqZV5uklOlxhYSDANfJcBalOY20
	HuUURA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftqdd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 07:00:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf27789c79so76456385ad.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784703601; x=1785308401; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7g91lbv5RV9lZPR9a6UTHIBqV9Y4ZqcpArgNql62cA=;
        b=hmk06C4jS9JxeNFXBOo+ijipM44o7anMxPUdxEh2qU10g17AINr02DRNpvF8mOe68u
         rFH4mgs2X0wgZI//AwEe3NFasXfu+DigQTFAs3GMSp3Maikc8ACJGMlPLq4/1+o5Hmf5
         a7cf9j8nfy6NXcahorLn9M4dbYUQALVwGXgjRXuaoh429t77O38PE4+LvZpgHeb+DVcC
         WH08o7p6EesbRbcrUUDhEOhDrqRRM8H9H0/+oYe7FB8An4qSE4/x84tTLt6wPjpHWGFy
         1DKxsV56PX3m1rVOnNPwA8vF6aKWI4uiXcJ2roH7auxsQJAh8Whov4XRIEVrGcYkkkYr
         pmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784703601; x=1785308401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z7g91lbv5RV9lZPR9a6UTHIBqV9Y4ZqcpArgNql62cA=;
        b=ROwsk7MU0b9Ot1OOHnW01BT2p+jag1MdCgxwgs+s0PjlQOSubqbd7NSeW42iicp1L3
         zXgckc7sJrsuiKUNpVfqwpw4kLWs2j7g+ZpsmBHCJgOdhzFtuIjbOqdTLD1bpI4536n2
         lX2WUnN2YYgnU2fur2XtZx2WMcMXmV3L7ufaM56nVlUHqowVwGMVGZT3Wt3iAF5y8t4a
         w3xg78pcJZbNNw/K+8LXhxDSnKLyUWcJKwSuyiKEeVAeVxp1AhTQHrNFiCZzbnZwNMhw
         pLjd3OM1NKUb6MYV7oXe7Ruz+uwbWkY+uahQydSfmw0N9H4EiprqIgrvO4vCHbUtn+6F
         OPWA==
X-Forwarded-Encrypted: i=1; AHgh+Rqd/q71LrdUTNKfc30O/ddPZ8SOTuV5FWCXG38Cxc6i5CdBUc/MvJfl/V0vQI1EbDDCwC3YYFk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzXU/Mn6oNCCVPEsjPiFsm79X6w7J+H3NvnalZF4kXAydtTyguL
	DnGomOlbxCOZxeda9kl4Ycj++l9Z+gEGOWhxhNJiD22SU67/dAe693eSdhSXVDHHljwFFWhnP64
	WR69M8mbdhv0FTncQ7dBvK2+YsnCzCFMc7YPp9MFBMKdBBEBEX1/CvP5y2fpzDXDGtF/CF42R
X-Gm-Gg: AR+sD11PimHwhXj3HKzXnVMgIOVH04c9WdxFT1krYERLCBVGnoGgwnyZ3yLwrm9C0Cw
	lLPmcTaDg81qPTwDpF3m9UdsgwGv2I2JqRYk2YwK1NwoIpwYhZa8h6oh0A6ymFYJIo6HVsmyIMM
	KqJBw/fsJ5pIPfAlVfl2EWV2a1vQhLSQeKAsX1M2La+6jPJ/eVoiU4/cZOzQ36gHJu4RGQgtjL+
	bN/xth0RSr+o9sr2PkYGcKV1W/QKmDBo1Qz8J4PCWCoHR51TEe/k69lPxdq5KgwU004d9nh3Zwr
	faa3bjpNCDWelVxfaDx4BdgDlDtY4MfKfmBqeb5jcUNF6xTovvCC31hbpUS27RaDa1181vcVxDm
	5sdnyW7jtGrbXuAfeDBKkU2+I6A==
X-Received: by 2002:a17:903:40cf:b0:2ca:2079:91cc with SMTP id d9443c01a7336-2cf34836a55mr231116825ad.5.1784703600905;
        Wed, 22 Jul 2026 00:00:00 -0700 (PDT)
X-Received: by 2002:a17:903:40cf:b0:2ca:2079:91cc with SMTP id d9443c01a7336-2cf34836a55mr231116565ad.5.1784703600419;
        Wed, 22 Jul 2026 00:00:00 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm9428935ad.22.2026.07.21.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:59:59 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:29:16 +0530
Subject: [PATCH v2 5/6] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-5-b8a8fcbe4211@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784703569; l=10257;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=ltTUr4ZNz1WK8n1xoNtPuphhExPvrUNLbuEMZg8+YzA=;
 b=ZecvUzCUTBtloCfVPCAS/ldUdsIlbuSrcJ/nDKElROmdw8SbaiDBPwu9WIYAg+BLvCKma1y8d
 Bz159LXYGYpCDrQc28w96S/YciUdkMeLcrxQbzRBkY+tO/zwb+nYBOu
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: PqAGbb7W7iT2YHcxVah442YRe9SVh0IK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfXzDQCByFPVh03
 HxWIwoZeBzULg4pYFMkEpx+BwgxNj194dfhl8YJvxO5AnkM1uqnoMgNfwvMqCIzfgf5kNf3ss1n
 jrPTr5Pgd+kqNHkG0DnimY5pBK9u+DjCTd7zw2RcAiItlsP4BTCBwEARC6ZkD9ivDaFUU0YX0Mu
 nmjVpB4ey6Nv3yRWHlovdqXwfKqK7ZYM2WGhh+RKbEl1bKJNZtH5+YJJ1No0s9oxZhJH+YY8q60
 GMaRkQLxHq3jqCIHJP1wDA8LXNgrQ3fWsdcTlf8fNM95dMx5dOi/ACz8iUaMAnfz5B0OT4d9hke
 Bp7v4bpouOsjuiZ3Ya/4Zni54g/yX19l91kqIn4vuIgzbCXxGbaKCQEvzYev56L0YNKNbcJDPBa
 nJi4mhHylALCQRcG68mHJosgDx/2MEbcTJbn3KrW3r/P0/VaOSduDQYTIE/ZM7ob4FHrTk1Hx6L
 lpyi4k751uLaM9jmuNw==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a606a71 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=nsqFTM80TsG4aMfu2G4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: PqAGbb7W7iT2YHcxVah442YRe9SVh0IK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfXwBDNOOSv6fwe
 yuQXiouOxyVbodhZu+bJidAWXQhBf4xp3YePP73ICbhq0Z871U5MOyBuVRi36IgceV36WvzlXWC
 FFkKXCY8nl+rXaehLFUi3einBN9C1Vw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220063
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
X-Rspamd-Queue-Id: 7EA5343DFC
X-Spamd-Bar: ------
Message-ID-Hash: OTWJRTHB32KFO7UGHCPIBEG37NGJZMHM
X-Message-ID-Hash: OTWJRTHB32KFO7UGHCPIBEG37NGJZMHM
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OTWJRTHB32KFO7UGHCPIBEG37NGJZMHM/>
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
index c1bba5fbfa3e..e909955e6b21 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -662,7 +662,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 {
 	struct qcomtee_object *client_env, *service;
 	struct qcomtee_arg u[3] = { 0 };
-	int result;
+	int result, error = 0;
 
 	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
 		qcomtee_object_invoke_ctx_alloc(ctx, true);
@@ -675,9 +675,13 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 
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
@@ -697,6 +701,153 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
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
@@ -778,6 +929,8 @@ static int qcomtee_probe(struct platform_device *pdev)
 		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
 		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
 
+	qtee_enumerate_services(qcomtee->ctx);
+
 	return 0;
 
 err_dest_wq:
@@ -807,6 +960,7 @@ static void qcomtee_remove(struct platform_device *pdev)
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
index f39bf63fd1c2..66d305a46c0a 100644
--- a/drivers/tee/qcomtee/qcomtee.h
+++ b/drivers/tee/qcomtee/qcomtee.h
@@ -17,6 +17,8 @@
 #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
 #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
 
+#define QTEE_UUID_NS_NAME_SIZE	        128
+
 /**
  * struct qcomtee - Main service struct.
  * @teedev: client device.
@@ -39,6 +41,16 @@ struct qcomtee {
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

