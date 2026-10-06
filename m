Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB66ACA5FFC
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:36:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 043EF452C2
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791286604;
	bh=g7TKIDQ7wd3sOvRr35lEot/KjYrlsV1dyNZ6GlMcRJY=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=UJziMkMs9lmtmCflL9fLAvI9EOo1XUV3ZDnPO+nEbW9eOt5QrbZoBzlhbWgr6sKRj
	 xFxcg3IJmnvi936UGRkFi3YZivfoxdGfgCwjeXmGcNQOaVYAaUmV8DOpD7iWOdBFYI
	 HoOH3Ls0mbxOrLEfKOfHlc+l+boKYfDHSRBSUB7S0/QUUAV7y3EXgIgmaKneqQCQPH
	 J9/g2PWAJ9CbW/LX+iSyE77OQ9aZGBw6tBzquzOzngPIcZBMlUC60CeW4LzaArMLJy
	 0bVjR7+BDAZraNjHHKQa6esugzQC0o3gnawOmg8T5QQf3K5Lb0L6y1lNOJio2EU61N
	 os6x9fDJRODuw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 27783454B1
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 11:34:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JLg/XMyP;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eW1yMIex;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPFRZ1707631
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 11:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNECpDUvfDFQ7Vcv29PShK9Ck0wrYCXcDsLiPwdsW7k=; b=JLg/XMyP5SBFODM7
	upQGZdsCZxgxT+TSH83/TyqISkBHciGojhZtJihxy/tFlxwzo7VmtfxbYUzhLAEb
	LkkDgAPDvJXkiYGUaLvTi9Iy8ch5STb4PBKK5ZMdb2O1xSqLSCd2Si5r0ksoX1uT
	HfWh5hLXfOazvIsjuHe313jHP0K4n4+7EqTinywvmaApdQOKHU7InlBeMbC1rkqU
	zai3TtH4GD4eziLFhYqlsMpR6WSx4VE3bkhRsmQqIhDoJ7ZPgr2ync05D3msUAzF
	5Ny2Oa4cHREFvPXu80CZP/mmduJ/+fwhW3MyL0iwelPxJuGcXpWRJvsYmwfCualB
	E7A9ug==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc50dcd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 11:34:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb48f41343aso570501a12.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791286467; x=1791891267; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNECpDUvfDFQ7Vcv29PShK9Ck0wrYCXcDsLiPwdsW7k=;
        b=eW1yMIexlv/ajY8kNDCNuhRLBONvcxihG6oq1/Hub3XpLuTE7v3NPUcjs6O/uQOMkd
         HUl/EhPNJf9R7sx95kQP1ihvfWEs3PffIUNIISMxZq9T18SSNiazyV1r02pI2V1BFezE
         LLgQSPXOJs2YPOdquHQfe81PFyHvi8nn/QERmzOYmxYHVSmhR9lA3r9tLZo+hs8aEfov
         aaHzkV00XLCPSwHa3FSkvq6lusCUOARB19+6RW2bDSFm+TR78x0K4IhVA7w4ZLcv1I32
         VEWnWIEWfwO4pAMxW2yjTgO+hc+WZFyQ98Y5LfAxaAv33emT+7nTB65KYwlPvC4BhQ1j
         LnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286467; x=1791891267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gNECpDUvfDFQ7Vcv29PShK9Ck0wrYCXcDsLiPwdsW7k=;
        b=yI20FOVskX13G6FzrB21pUTnechowVIg+oTIwV5lM8toapXxPST0Kb2vUhABaH3K+S
         m/zrFxupJfYMzPhilx4JEENfEA8GaJTm5k8DCBbhUporVrg3R3GPT8Vb8uiSHyNnIkjC
         JTjLP3qn5r8jEf7dQXX/3sid0tXylO60KAY+CNk2hR5mPVUbhw+iKMTY23ywwJdDs9WF
         x5TeElqET4HIv4OvFR3ipR66/k4jb3GOD+4Jg31+bl4bKpG195Dpb4zvioh0XdcIfd5q
         ABa/3pfwBojNspo1/YHE4h36u+kP9VSrGmHsap0Y6QMlFi6CK9n6AdN+KUZDIH7eMbNP
         IfHA==
X-Forwarded-Encrypted: i=1; AKwUvBwpAWxdaYHnMRwISbDKphzTuBN8lEpjbv+UOd14WV7NQq25MyEK28/cISMwN8EHLl2etRLQBY4=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJZlazoJmYzamxAW6Wy01lNC0jzf9KwJqNABTQf4ORk9kCj9HIJ
	jXIDjxBkmqI55PPqV2JElYuVCLSO9FxtEMQ0fX34jUpHi2YvP2Chxl0NeflCpXKmZGFhfoKds4o
	7YrmSilGs9h0Hd6bNEaw6eU4soWvFkInz1sGffJpfujV8L3XNQyIBNjj8WAzOD13uEZrS7kys
X-Gm-Gg: AYBFou16G3QS9hLuyLKzpJ6YVfmn1Qx0H5tN/MpQd6b07j4d8adsDdTIZ+Zet85aZOy
	11G2PainXwSutXrt1EhfjJmgxgwCrAwW8jnkGTZwFl7C6BoVwtvjgzIzfb3UnNjDGfoeY5T64i+
	FniiDkkyduMucOVFlkKjFdGQvX3DBRc5meYpMiVsaMpKmszHyOzLO0C6e4XWSiYi5/4QJfTL/zz
	bAjg4VF9vWrED1V7EU8mGpd5/nJjr/KHaXBSuBYILWXb3JWMMUUN8IK/NIHGnfG/dfB+XI35WJL
	SMou4JkZBl//mKdTvtLFWvYJ6Cwb+lvUN36u2Lpw/mBI3ULcIyF0qJfsg5bgqPG1SRGCW6X3Z4P
	tR/gXd7c6JjYnfhK4teZ5TkQZ
X-Received: by 2002:a17:90b:2f05:b0:3a0:c85a:ee12 with SMTP id 98e67ed59e1d1-3a87381f68bmr539700a91.41.1791286466778;
        Tue, 06 Oct 2026 04:34:26 -0700 (PDT)
X-Received: by 2002:a17:90b:2f05:b0:3a0:c85a:ee12 with SMTP id 98e67ed59e1d1-3a87381f68bmr539674a91.41.1791286466244;
        Tue, 06 Oct 2026 04:34:26 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a709a4e80bsm9330092a91.4.2026.10.06.04.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:34:25 -0700 (PDT)
Date: Tue, 06 Oct 2026 17:03:26 +0530
Subject: [PATCH v4 5/7] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-5-bf1c8e2a64ab@oss.qualcomm.com>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
In-Reply-To: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791286430; l=10148;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=g7TKIDQ7wd3sOvRr35lEot/KjYrlsV1dyNZ6GlMcRJY=;
 b=C19gBCRfhALRW9beckjU3Ug8rCq6PA0ZjascKDpT2YnStmcuuRSwXkAgTTGvo+ih1p7aF3C0W
 PttrV+jwEQrDoOFhTXe4QKiu2cyOCes3n/wlWqKChBajUswthUIIRs0
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Authority-Analysis: v=2.4 cv=X5THu2Te c=1 sm=1 tr=0 ts=6ac4dcc3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=nsqFTM80TsG4aMfu2G4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX/jZUzpAF6ckx
 LZHqkb3cwyA1IwwcTKoUpAs28onKUdvnOQpXlcmKZykVdVkTrUbaDG93DakHlR+jkexy1Ghya5T
 xC1eWrie5FdhPULZkpdpqBRglHUPThA=
X-Proofpoint-GUID: bu8ZIhMIOPpY5iOeI0hciYXrey5Gm3zN
X-Proofpoint-ORIG-GUID: bu8ZIhMIOPpY5iOeI0hciYXrey5Gm3zN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX6HRfX82qcdzH
 WE4Q1vfPR4owWBdzlhfhXpGOURNLEsNaP6SjMevUKdeL+6acoVZ1Z4gHeulRcOEqloDKMaFD2cM
 S2RguDXqbLEMPrXbv3Qn4O4yhN7zBQWF/Mv65tctF3lUWxi054BBLBUK1ZU7iU5hEyratSqHak6
 bIdcaN22N2++QpBwp2fi45t7qDHK2mQPc3/PgwaN5HLH6nyl04eUXuTo7eV1bkM7rUE066pN4Pi
 BKL4NGPuY6HB1ZG89GnyrgxUE1ZaBNtYx9/PJYhmagqL9hFmhlttIkIrJYsBQ6IkwyiNZPefDR2
 SRN9RD4yVV2sD0dHdIrXT6kuQqO2iZb9/hnXQL2GnVZh2AksJcIhhlX7MwV0s4wTO+etGHMUE7F
 0eECj2pQFF6M4oSD8ex5b1Em7Opv0uP1WTCiiyhyNvVHcajF1bbl86cTlU2F0G80I0IhrPy4SNm
 j4bnlhj6LfGYgV2AxsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060045
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
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 27783454B1
X-Spamd-Bar: ------
Message-ID-Hash: W7R7IUF75ZPPRVCV6HY76GLRBCRWEOJT
X-Message-ID-Hash: W7R7IUF75ZPPRVCV6HY76GLRBCRWEOJT
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/W7R7IUF75ZPPRVCV6HY76GLRBCRWEOJT/>
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
 drivers/tee/qcomtee/call.c           | 161 ++++++++++++++++++++++++++++++++++-
 drivers/tee/qcomtee/core.c           |   9 +-
 drivers/tee/qcomtee/qcomtee.h        |  12 +++
 drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
 drivers/tee/qcomtee/qcomtee_object.h |   3 +-
 5 files changed, 179 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index c97afaa1b4aa..3061bcbd15ab 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -676,9 +676,13 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 
 	/* Get ''FeatureVersions Service'' object. */
 	service = qcomtee_object_get_service(oic, client_env,
-					     QCOMTEE_FEATURE_VER_UID);
-	if (service == NULL_QCOMTEE_OBJECT)
+					     QCOMTEE_FEATURE_VER_UID,
+					     &result);
+	if (service == NULL_QCOMTEE_OBJECT) {
+		if (result)
+			pr_err("FeatureVersions Service unavailable (%d)\n", result);
 		goto out_failed;
+	}
 
 	/* IB: Feature to query. */
 	u[0].b.addr = &id;
@@ -698,6 +702,156 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 	qcomtee_object_put(client_env);
 }
 
+/**
+ * is_qcomtee_service_available() - Check if the QTEE service identified by the UID
+ * is available
+ * @oic: context to use for the current invocation.
+ * @client_env: Client environment object.
+ * @service_name: Name of the QTEE service.
+ * @uid: 32-bit UID of the service.
+ *
+ * Returns true if the service exists and is available.
+ * Returns false if a service is not exposed by QTEE.
+ */
+static bool is_qcomtee_service_available(struct qcomtee_object_invoke_ctx *oic,
+					 struct qcomtee_object *client_env,
+					 const char *service_name, u32 uid)
+{
+	struct qcomtee_object *service;
+	int error = 0;
+	bool ret = false;
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
+		pr_debug("%s is unavailable (%d)\n", service_name, error);
+
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
+ * qtee_register_service() - Register a given QTEE service on the TEE bus as a
+ * TEE client device
+ * @oic: context to use for the current invocation.
+ * @client_env: Client environment object.
+ * @service_name: Name of the QTEE service to be enumerated.
+ * @uid: 32-bit UID used by QTEE to identify the service.
+ *
+ * Returns 0 on success and < 0 on failure.
+ */
+static int qtee_register_service(struct qcomtee_object_invoke_ctx *oic,
+				 struct qcomtee_object *client_env,
+				 const char *service_name,
+				 const u32 uid)
+{
+	struct tee_client_device *qtee_service;
+	uuid_t service_uuid;
+	int rc;
+
+	if (!is_qcomtee_service_available(oic, client_env, service_name, uid))
+		return -EOPNOTSUPP;
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
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * qtee_register_services() - Enumerate all the secure services exposed by QTEE
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
+static void qtee_register_services(struct tee_context *ctx)
+{
+	u32 idx;
+	struct qcomtee_object *client_env;
+
+	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
+		qcomtee_object_invoke_ctx_alloc(ctx, true);
+	if (!oic)
+		return;
+
+	client_env = qcomtee_object_get_client_env(oic);
+	if (client_env == NULL_QCOMTEE_OBJECT)
+		return;
+
+	for (idx = 0; idx < ARRAY_SIZE(qtee_services); idx++)
+		qtee_register_service(oic, client_env,
+				      qtee_services[idx].name,
+				      qtee_services[idx].uid);
+
+	qcomtee_object_put(client_env);
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
@@ -779,6 +933,8 @@ static int qcomtee_probe(struct platform_device *pdev)
 		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
 		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
 
+	qtee_register_services(qcomtee->ctx);
+
 	return 0;
 
 err_dest_wq:
@@ -808,6 +964,7 @@ static void qcomtee_remove(struct platform_device *pdev)
 {
 	struct qcomtee *qcomtee = platform_get_drvdata(pdev);
 
+	qtee_unregister_services();
 	teedev_close_context(qcomtee->ctx);
 	/* Wait for RELEASE operations to be processed for QTEE objects. */
 	tee_device_unregister(qcomtee->teedev);
diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index 60fe3b5776e3..4a523a95bf0e 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -898,19 +898,20 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic)
 
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
index 5d7b21fdd368..9278a361dc70 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -105,6 +105,7 @@ union qcomtee_msg_arg {
 #define QTEE_VERSION_GET_MINOR(x) (((x) >> 12) & 0xffU)
 #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
 
+#define QCOMTEE_UEFI_SEC_UID            413
 /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
 
 /* The message contains a callback request. */
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index d3740099fae0..901ba3565a73 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -317,6 +317,7 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic);
 
 struct qcomtee_object *
 qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
-			   struct qcomtee_object *client_env, u32 uid);
+			   struct qcomtee_object *client_env, u32 uid,
+			   int *result);
 
 #endif /* QCOMTEE_OBJECT_H */

-- 
2.34.1

