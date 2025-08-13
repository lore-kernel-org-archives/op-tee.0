Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05906CA0EC4
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:40:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 519584FCCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755045636;
	bh=l2P7dGtNDbLNv/xg068cPe6Xi0IqjefQehxcflS58Qk=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xfUYl/hNavMXA8jskEdgdHQAAHB3gVnPH5oyEkmOfVnpZOIUcXhSA7bjfxQ9yH2NK
	 BAd19pFi/1K3yqtoBxM+tWClqwPLKsAlpOXCTu2YBxlnbOpQC5WnHkjDSb+Zn/oQkh
	 /aCC4nsXcOWH4D6tHDzqf1KEtb+hUz5RW/14Ha2KGHqNV8o8usEVrCvxJlw2/CahRx
	 HOCfhzk0pvTi+hw8zDw+5i+Jt/tB2ru1qQpuVDpm2g98/G6QC8bnu6kJjsHMRidWP8
	 5CzDUF7PMY4N/umIgph+fhYrb/2hVfOgW1kIQsv2zVfKGweaclo8uO95vEvGTA/W05
	 ZPgprv/WTnbHw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5AA2D4FCC7
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W5iETodn;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CKjhvX032253
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VgfYqYOzEqvZzDTEjOA+cDrnXPG7DG1jVg7ssY0+cns=; b=W5iETodn8jHBKi4m
	xuRfFmCAak3OCVLbVueIuVwGzqqFWX8lha19wKoPvLgAq/DEA8WOuKipNwL3mZuW
	wpMDy0d1Si8/Onh+e0ci5FITGJxWvv5mg5KBnSRvnaYZhUOesTufRdVn/5GdyTu0
	1mjJBWBo3aba5c8bUu/IAmksohlS84K7FxQyjWHJ/VmQfRCXBORgHOJttmQJ25gB
	+F96f/jScacwI22QmdMWqPIEUyniSerobI1xOdyzWPAGZDJFQ41ZfmBxQqBmv6rQ
	WJWQiWMWf6D5qcHD1jeHF0Hp/lVgB63BwPpkkfvTlbg7JZULwTs7aMUscNlwPpG9
	6tCIGA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vmtht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31eec1709e7so9982006a91.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 12 Aug 2025 17:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045428; x=1755650228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgfYqYOzEqvZzDTEjOA+cDrnXPG7DG1jVg7ssY0+cns=;
        b=iyMzeMcVU9zhipg/I0LNBy+pqb9n1I6BE3mmO2AGmRLiHVZeamwFyNpF6K13NbHl87
         2YYfCSvJsQM/CMTQ8jEo0+jR+P/e7BKOAay7BioUbhLo78IA94GjyE3EuNsO5096PPuM
         OzN+OX63FnTx/Xht38KMkj5L33Vltqg/CUBbOSCKtDd2BfAtWFdnkEYu6c1l/JT62rbp
         g2nx6Hisn5FpJtPx9l7aE8rcn4uAQtW+7OjFfk62qml4ZtH9clHphTixgtX1eWEgi9uk
         OgTk0XFrocVGus1N4vyEJt4RvgLgtO6jFvvy5vlDJQYEAvqAvgzeDecIjtWIhDPolBig
         b+yg==
X-Forwarded-Encrypted: i=1; AJvYcCUBGUZSQro8LaK9oz3+EYboCqieNcN/69oMpDD8caIlWh6m2l9XX99kdTISMZOO1sQEEnF7MiE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyFpKaxJ+aMI8sly4hUevD4nlJC54WRanQSuuAKORv3VyyXcts6
	BS+plVkfrs+CqwR1E+z9pw4SH0P1yALIlmfqhhcwmnHWSh3oOZ8ws4mPHfPzwaR5VCQQop+MnvP
	LXKZ/MS1m6jDxqlFfb1HMq1VM+vygc6ibQGdBmqQjvtpJe0CaqaOqHfs7/LMhOQEErZCJi84=
X-Gm-Gg: ASbGncsVCJRHCD7hcHkpMpmO2PIQ3xN68AfZMTXzi84A1M+Xy9OZvFwebMK9jCCR3j7
	0M60SzqOo8Lf/sD/nXcJczcvxovHRTvU1JkGaMmNsV0bpKLgm8CPwqXyvxJweJc9JqNOmyoDx2/
	SeMEnxG8JZhKNq7TdQJgeDFhOwVrNhhwzu2qQMGosNYfUUZVHzLCEtDKKMRrIBGhGSQbxIf2BHs
	5zoVIPzBYO+wR6cn/TWaJV+yB8BYr2T5/e/Bf0GEH7GDZzoDNoKsQcYZQV29FCtRM5uxUX+a/lJ
	qO5c/TfpiOADsAJVok8mYvw/7juY7HxAPnHe0uUxSfj4tlPmSOMgDuDs4RfZv7ytoGhfNla/H+b
	k+R3aD0nOXfdtr9VShIBvcYg=
X-Received: by 2002:a17:902:e542:b0:240:2bb6:d4ae with SMTP id d9443c01a7336-2430d1a1154mr13672855ad.30.1755045428458;
        Tue, 12 Aug 2025 17:37:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETQhucWOuyrInlNMjjBgfPxk6ddKB7vzyIdf9uZsC7lDRvSujER8Z4KmqJHik85GdmZw/OCw==
X-Received: by 2002:a17:902:e542:b0:240:2bb6:d4ae with SMTP id d9443c01a7336-2430d1a1154mr13672655ad.30.1755045428036;
        Tue, 12 Aug 2025 17:37:08 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:07 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:35:35 -0700
Subject: [PATCH v7 06/11] firmware: qcom: scm: add support for object
 invocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-6-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX77vTVrGjVL4A
 RAKv+qxcYdCF37CEL0g57HXJwmsu0BczrAyO2r2JZ0oc5P/zuhcoLZLgwl2MbvKfpvu6QngOo7l
 xQFOaRKQZfqTrY9EVm4zGY0Zx9PqobPFQhXqr1jjejC2tX4bgppVzstPXZdurLAbliHAA8sJxAu
 LUZxFJJDV1kqvxM5+5qjKyK/PvxlEIlLRxqKuDBd7ilojF0Bh+NlVyu4S907jKBPMgGgw+1tN7N
 2JvSMesX9nTbOgcDmjPK1wmd0WHxTxm7bWIedwVSHK9Qd7qKWyNfF3kirA4l4DpvLcHwp7fegzS
 98KIeH+lY2qoJBlT+7zdJaWYbS37pPeMhioxE3U2kvGS8FPqm/a77wZ/Zd/2WiAJLxplSVhhNNE
 IIMe4vW0
X-Proofpoint-GUID: CaIr-0peGN8Lx3idA_s5yLEs-3FAfFTr
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689bde35 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=dBYAKgxw8cyf2mnx-aAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CaIr-0peGN8Lx3idA_s5yLEs-3FAfFTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107
X-Rspamd-Queue-Id: 5AA2D4FCC7
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: Y4RWSPEHP47RW3MGLA3VQLD7TCF63XZS
X-Message-ID-Hash: Y4RWSPEHP47RW3MGLA3VQLD7TCF63XZS
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Y4RWSPEHP47RW3MGLA3VQLD7TCF63XZS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
the secure world, accessed via objects. A QTEE client can invoke these
objects to request services. Similarly, QTEE can request services from
the nonsecure world using objects exported to the secure world.

Add low-level primitives to facilitate the invocation of objects hosted
in QTEE, as well as those hosted in the nonsecure world.

If support for object invocation is available, the qcom_scm allocates
a dedicated child platform device. The driver for this device communicates
with QTEE using low-level primitives.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 128 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   7 ++
 include/linux/firmware/qcom/qcom_scm.h |   6 ++
 3 files changed, 141 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index edeae6cdcf31..96d5cf40a74c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2094,6 +2094,124 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 #endif /* CONFIG_QCOM_QSEECOM */
 
+/**
+ * qcom_scm_qtee_invoke_smc() - Invoke a QTEE object.
+ * @inbuf: start address of memory area used for inbound buffer.
+ * @inbuf_size: size of the memory area used for inbound buffer.
+ * @outbuf: start address of memory area used for outbound buffer.
+ * @outbuf_size: size of the memory area used for outbound buffer.
+ * @result: result of QTEE object invocation.
+ * @response_type: response type returned by QTEE.
+ *
+ * @response_type determines how the contents of @inbuf and @outbuf
+ * should be processed.
+ *
+ * Return: On success, return 0 or <0 on failure.
+ */
+int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
+			     phys_addr_t outbuf, size_t outbuf_size,
+			     u64 *result, u64 *response_type)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_SMCINVOKE,
+		.cmd = QCOM_SCM_SMCINVOKE_INVOKE,
+		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
+		.args[0] = inbuf,
+		.args[1] = inbuf_size,
+		.args[2] = outbuf,
+		.args[3] = outbuf_size,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW, QCOM_SCM_VAL,
+					 QCOM_SCM_RW, QCOM_SCM_VAL),
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	if (ret)
+		return ret;
+
+	*response_type = res.result[0];
+	*result = res.result[1];
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_scm_qtee_invoke_smc);
+
+/**
+ * qcom_scm_qtee_callback_response() - Submit response for callback request.
+ * @buf: start address of memory area used for outbound buffer.
+ * @buf_size: size of the memory area used for outbound buffer.
+ * @result: Result of QTEE object invocation.
+ * @response_type: Response type returned by QTEE.
+ *
+ * @response_type determines how the contents of @buf should be processed.
+ *
+ * Return: On success, return 0 or <0 on failure.
+ */
+int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
+				    u64 *result, u64 *response_type)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_SMCINVOKE,
+		.cmd = QCOM_SCM_SMCINVOKE_CB_RSP,
+		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
+		.args[0] = buf,
+		.args[1] = buf_size,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	if (ret)
+		return ret;
+
+	*response_type = res.result[0];
+	*result = res.result[1];
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_scm_qtee_callback_response);
+
+static void qcom_scm_qtee_free(void *data)
+{
+	struct platform_device *qtee_dev = data;
+
+	platform_device_unregister(qtee_dev);
+}
+
+static int qcom_scm_qtee_init(struct qcom_scm *scm)
+{
+	struct platform_device *qtee_dev;
+	u64 result, response_type;
+	int ret;
+
+	/*
+	 * Check if QTEE supports smcinvoke:
+	 * This will fail with -EINVAL due to invalid buffers, but first,
+	 * it checks whether the call is supported in QTEE syscall handler.
+	 * If not supported, -EIO is returned.
+	 */
+	ret = qcom_scm_qtee_invoke_smc(0, 0, 0, 0, &result, &response_type);
+	if (ret == -EIO)
+		return -EIO;
+
+	/* Setup QTEE interface device. */
+	qtee_dev = platform_device_alloc("qcomtee", -1);
+	if (!qtee_dev)
+		return -ENOMEM;
+
+	qtee_dev->dev.parent = scm->dev;
+
+	ret = platform_device_add(qtee_dev);
+	if (ret) {
+		platform_device_put(qtee_dev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(scm->dev, qcom_scm_qtee_free, qtee_dev);
+}
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
@@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	ret = qcom_scm_qseecom_init(scm);
 	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
 
+	/*
+	 * Initialize the QTEE object interface.
+	 *
+	 * This only represents the availability for QTEE object invocation
+	 * and callback support. On failure, ignore the result. Any subsystem
+	 * depending on it may fail if it tries to access this interface.
+	 */
+	ret = qcom_scm_qtee_init(scm);
+	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);
+
 	return 0;
 }
 
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 0e8dd838099e..a56c8212cc0c 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -156,6 +156,13 @@ int qcom_scm_shm_bridge_enable(struct device *scm_dev);
 #define QCOM_SCM_SVC_GPU			0x28
 #define QCOM_SCM_SVC_GPU_INIT_REGS		0x01
 
+/* ARM_SMCCC_OWNER_TRUSTED_OS calls */
+
+#define QCOM_SCM_SVC_SMCINVOKE			0x06
+#define QCOM_SCM_SMCINVOKE_INVOKE_LEGACY	0x00
+#define QCOM_SCM_SMCINVOKE_CB_RSP		0x01
+#define QCOM_SCM_SMCINVOKE_INVOKE		0x02
+
 /* common error codes */
 #define QCOM_SCM_V2_EBUSY	-12
 #define QCOM_SCM_ENOMEM		-5
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 0f667bf1d4d9..a55ca771286b 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -175,4 +175,10 @@ static inline int qcom_scm_qseecom_app_send(u32 app_id,
 
 #endif /* CONFIG_QCOM_QSEECOM */
 
+int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
+			     phys_addr_t outbuf, size_t outbuf_size,
+			     u64 *result, u64 *response_type);
+int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
+				    u64 *result, u64 *response_type);
+
 #endif

-- 
2.34.1

