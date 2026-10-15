Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FACCC6B34
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:42:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 140AC45319
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792064550;
	bh=hNQBOkWEGuN/zOfQJbBnRHCMXWNqJ7cLrq//Aso0wOY=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jEQhldIKUR1MphcM162LyGVNz3+U2OrpPVVPqQJyYugmhqjD16ns8jiXvtUkk+PoX
	 /TjERRGQ3rRgucK7QBLAcfaXLnTs4Q1ACXR19o+TZy6pCPhEJ7K19RI3cY1nMHDaaR
	 z6xFkE2aHH2EIBOutkTOcUSs7VZYt35vSKFfKsWhHdhLqLqC6nZuNXeBhjINDBSkhm
	 rViMGn4FzQ/2eLi1VjLg+8BREtExm+4Ffjx+erDuQayxhbyUmcckyqf2s+R5cidFDP
	 8RSt/u/7HFgrCrSLzJTCF3YU8x4FNB6PpQ66o5xBYUsuRtl2FksYuhSVNaTNq2ZcAI
	 Q2GUGlc/HZPaA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2AF054534C
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mnjD4vbx;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ip+mWpBN;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPuCW1596377
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oM+RM2pSzxoDn0B5KJKXYZ1LNdamxdVFsCDDHpYVI9c=; b=mnjD4vbx4KXZLP4D
	CRgaecEtFFwV6noaJimzheqGph6d9fnTzcJuNVG1JNmm+vbfcfPbq5qs67YgaxB7
	hXhcob4AA/FWuNuzg0onjrrE9qYeEECdUkUJ6xr0RyfUWEPxs1mhPlMuwrtQ2wbM
	4ZBZH3CCC0hJ9blWXeLJB9TZtKOGYjG2N9iVtvJMuJISul2FNtd2igch0pjg43MZ
	/xAf4Ul18NQvAQPed6eStYQ+69oghYq1ispP5aBdtsh4usDXOWGWt5qM7lg5p6Q4
	Posmq7+xVOADSYFOtLg1DuJ8+1j4zJDNVeLSyrAYhPjLwb80I1o9wbm7/FgjaD/P
	iUqmOg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v88rp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-359b81ad4e8so2950032eec.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792064412; x=1792669212; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oM+RM2pSzxoDn0B5KJKXYZ1LNdamxdVFsCDDHpYVI9c=;
        b=ip+mWpBNNDkpzrm4RxgPJkFQOJUYqkuF+Q2CFiubZWyNAyivIq7g2c69olMfPerU/F
         oOWlZ2l/YzGzYzKPF+tXrQhLMVHGQ2jslQ/VbGQeiCMOBk46WLuqURV5+vGwZvEnEtgm
         Lqtl4cOSKv6LvZ1nXYIMhlfV4oS4CbE29YsD2hY5Kx9a9hJ4NKgYlZMPB35oDUrRLWhT
         6ct6v7c4AjL9BV814TTZ1V0UVn3UY7YQbJEnZo8VEAZf5yN5WCdicZ45/akyr1Xpv+Sf
         DmydLW9Z59M33kRHvccBe3lT5pZqIYAnnRr7/JxN2V0tAW3VTRCbBfPuU6MyMhPHkYQi
         5fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064412; x=1792669212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oM+RM2pSzxoDn0B5KJKXYZ1LNdamxdVFsCDDHpYVI9c=;
        b=vsMlQ+hK+Vvm2GH/9pXPiEVZBKCFhti+YjFl85ai48h41aEh046FByGtA9DeymqsV9
         ARYFYbi+YoiS5uZitGBySAFbJoJsC/QJ+KLlizm6aKRWxsAroL57d1Y4fg0LrWBrcB2H
         uxj4JRW83kILwNiU2TqSPO5lCfRmDQS8oTUKY4h2JJrtlvS2AfUmkkPftEeeuGIgoFWD
         BOgdUwa47O2Eo2rjx8LYHptEyIPD/J5nYGqVv4c2uIlnMlbHnA+cTPyx6VmuBpfMSgTE
         RZEoqil0nQK3otFoI4BIwsRXIpS1lTXxp2vV2e8wcozmTn1Vz95xc0qs4GfWh4ABz4Kk
         jpfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwn7BmO3WkDyXw3jfgdJ+2NvgqGkEx6pLrg87/Kjd7UpqvUHaUlsNezEjaBIYc8zBUM+SBbEAQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLjc7fARH9EN5ZPQbF+z5k/x0+V2isPYgDXmx13PqrrINNgVymh
	tH6I0ej6lKqcGmxxJLjliTMd/1rKDOTXM7a2AjRqZomPzFQUDBE2Shx3hkaQylChUMWiVxvHAkH
	/0Hdn8qC+A/SXD6nZjE67fpx3PQR47tXdsGW5ye6QpZvswmflFXaGnr0YNaP5gaxHCiACu+aV
X-Gm-Gg: AYBFou32x83xqs7x3wZiBACuqitRlIFkJMV3m5OSnNbapzwU5IN8Mug3mHDZViOL/HU
	ss2QoNtoTKsXdNrso3iS+eO77kNsQVZ8MkKxx2YMwuFRGGrNMsZEnkBukXxRMUjmI52wAHzk7y3
	z5nmbYilfWvjmWji4XaczMdUC1XC472967TDHFJ1dxwDq7geChU1yX29BPIqS0AOCfCoNgq+Iqj
	4bs5GPHquGxexkbZNAOT2JrKQfQ8DSCfoNSEb+yy5T1liM4IY8y1/GfdNSMPLRxys64VgN779PD
	x67PKIYknJeoRo9LMvZK9gyhCFYdoGrOzl8gIqyWRWDutePp4cavRAz7zY5O2/fo5px11lhcy00
	FJ872q5yXA0tzE6M8y0P8uNJFfw==
X-Received: by 2002:a05:7300:229a:b0:359:2f0b:bee3 with SMTP id 5a478bee46e88-3592f0bbfb3mr19158637eec.32.1792064411965;
        Thu, 15 Oct 2026 04:40:11 -0700 (PDT)
X-Received: by 2002:a05:7300:229a:b0:359:2f0b:bee3 with SMTP id 5a478bee46e88-3592f0bbfb3mr19158571eec.32.1792064411030;
        Thu, 15 Oct 2026 04:40:11 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm48144891eec.11.2026.10.15.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:40:10 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:09:39 +0530
Subject: [PATCH v5 5/7] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-5-1460691b35d3@oss.qualcomm.com>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792064379; l=9853;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=hNQBOkWEGuN/zOfQJbBnRHCMXWNqJ7cLrq//Aso0wOY=;
 b=CoyGEECxmSjTmrVK0wunclQNqjBpXOBa80PmicP03iaEiTRdjIiIQfzorEURPgazy5Ywwhv5e
 DwhAyehylPYAKyhoJLT1e4oQu8LBZvsAZn0I81Cip16FOjikCo+IS3l
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfXx9+AynxBPj/a
 y3D5x52EjiFs7IOfY7K15E7UMCdd/3QaccXqxPl2wLLtF6Y8xxIM3zy0bN+E6A1I7XlTZfDxK6j
 6bwIntM0IRGLKHuhg3m7zw71/iL9fXIRa6X5MzqNw2BkW+IUyMKaJ4rdqJNtasGPOwYmRIjim5y
 5HnHBdnRJ1W0oHYAaghc6kpeGMQNqIY027CpiQNU0y8WchQHiOo/ITOg9YGw8vmj248Pw1FxbAY
 BWRZ4NMyGSGqlBIhPe0jLMODuTXOh3wJp4CdwZqX3Hvedxjyf0J/LdShk5P57dndjcKH2exlrUv
 EMahOxbsUMFd1X4pgDGV3MqbzpzagMpAAg16yQEePQ/9KnKEF1fPK6+sAwbOzJ4alxyoTvhqZU0
 h66CwtOdS5qv2X2tD2VCsCLwSOiHRQltFNMG6BQMEzFv5YSmdaU2cObmCGHcM3Fr1iPfL7XYWj8
 6f5ztxs5ONtQbe2Vhkw==
X-Proofpoint-ORIG-GUID: Dlj2Xe4eBQUlkm3msaK-wu-nj6cM5Imf
X-Proofpoint-GUID: Dlj2Xe4eBQUlkm3msaK-wu-nj6cM5Imf
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0bb9c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=nsqFTM80TsG4aMfu2G4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX6+eJ3ZgIOrJw
 Dc8urznn7qM5065WCeQHXTLiwAO1ZXpgFPqnetTKkGc1FPhcB+JvOtANw2rnzqeKB5M4gcv9a1D
 0iNnnYvOOET8132CloxF0JSsEZDL4HA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150046
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2AF054534C
X-Spamd-Bar: ------
Message-ID-Hash: SDTFV4LKU7ZDOR2LHHSF2URTFGH5AQLZ
X-Message-ID-Hash: SDTFV4LKU7ZDOR2LHHSF2URTFGH5AQLZ
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SDTFV4LKU7ZDOR2LHHSF2URTFGH5AQLZ/>
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
 drivers/tee/qcomtee/qcomtee.h        |  10 +++
 drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
 drivers/tee/qcomtee/qcomtee_object.h |   3 +-
 5 files changed, 176 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index c97afaa1b4aa..47d8a4f9a159 100644
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
@@ -698,6 +702,155 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 	qcomtee_object_put(client_env);
 }
 
+/**
+ * is_qcomtee_service_available() - Check if the QTEE service identified by the UID
+ * is available.
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
+ * TEE client device.
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
+ * qtee_register_services() - Register the secure services exposed by QTEE
+ * as mentioned in 'qtee_services' list.
+ * @ctx: TEE context.
+ *
+ * Not all versions of QTEE support a given service. Hence, we try to
+ * enumerate as many services from the 'qtee_services' list as possible.
+ * Not being able to enumerate a service shouldn't cause the driver probe
+ * to fail since none of the services in the list are mandatory for
+ * establishing communication with QTEE.
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
@@ -779,6 +932,8 @@ static int qcomtee_probe(struct platform_device *pdev)
 		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
 		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
 
+	qtee_register_services(qcomtee->ctx);
+
 	return 0;
 
 err_dest_wq:
@@ -808,6 +963,7 @@ static void qcomtee_remove(struct platform_device *pdev)
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
index f39bf63fd1c2..b1fe1d317150 100644
--- a/drivers/tee/qcomtee/qcomtee.h
+++ b/drivers/tee/qcomtee/qcomtee.h
@@ -39,6 +39,16 @@ struct qcomtee {
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
index a241ab657318..e2f2508aad8f 100644
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

