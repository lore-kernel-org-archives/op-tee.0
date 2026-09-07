Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32656C79F9E
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:29:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 542AE44F7B
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788773384;
	bh=cLT0bftYuWxI6XzPRjJvBq69JkHwsp1xKebWTnTY5JE=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=MewumMCyvTfyx85bB3dE5kWqdq0br2MrFcrf8JmunnBTIy8gHmD54embJ9QcQSfjY
	 UUF53oWfH7vXSq1m6iNaudvNMw2Rc8dnySvFAntae10IUsHPGeNOWqQGL5Xn45NBUb
	 33zLlUaVgvoOiNA66L+mvgCTtEgFZGqhMtOTj5W+yyienX9975VHkM/Yl1A1cu8AG9
	 GwUMlUPqzwGBJYLCNWBrAUsGvye/EnAfJhtdcaDTzZo29ExVzBWduonxDvUJfJFu6H
	 hOh36YSqeX5U/IRg1s3OGe1D8SQhT2sfBBsDNdwtsfHKu+ymQm/rMMcjICCn1SEpxp
	 40IlhgPUMgzfg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E984D45078
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Sep 2026 09:29:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=olei01Cz;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IQFzkJmt;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777LOb3363295
	for <op-tee@lists.trustedfirmware.org>; Mon, 7 Sep 2026 09:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l0c4thTN4BGGYhL3ienR3lPOHCXz3GdcGl1jf05y8VU=; b=olei01CzL/AWquQ7
	391AgbwrNfWZWuvLggoUghIC7rGkmGEimLBtmmcmDKpZHdh69UsX+0lI/LZT5llB
	t3F7dRHxiGhoG8FGZWadQ4SBAwGvNh6F9Vb6ul3nm+agaE0zxd/tSxGn5ooVufrv
	2gxzAF1CVNCDL0rf4GGqwjhJrpOElT6nzvyRM0BjJ5frO2hj7rOeU6CV12yr5oRd
	PggkKtT4HHzCfqG6ohq8thatxPLfDrJCqtuM2yS5KQnVRZgsc0fWTPG3iv+d46zO
	ZHTgU/lkIkbIA16aX33fGTLSgUiW2YRKESbUJy+t+qGwrIAd+0DvtjdIFkqWtoyN
	YlHG5w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghnmj1any-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 09:29:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so5000373a91.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788773353; x=1789378153; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0c4thTN4BGGYhL3ienR3lPOHCXz3GdcGl1jf05y8VU=;
        b=IQFzkJmthLWkbcV/6U/CooyM6yOpHpsJ97fkZR1OrbsFDUUa7FunwhfUZzmAO0GWgq
         TA9vLMphdBqfuJxvkrfocso7XCMLMTHyALnRLzmKDgYuQDqjTb+UDiF0tJuSCpcOaMOY
         wm1i7KS2Hpjfi8CMvSBlGVPl3nO3x+ji4UJecnWa8uRQS3GnQexUAx+SeNL3nmg9m5DU
         aoeXeLfoGlh2sxDUHUj6UctZeTvWQcNkF7QElpNVi7hxJKhiQ7pe+e2Lvbz1xNWzUnDf
         0kqCdCi4GcsXk9mA69Hr48WDEzlPHMH55sJd99PGEH+g6aoXMACB7VLTAOl5kNLn+h1j
         DvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773353; x=1789378153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0c4thTN4BGGYhL3ienR3lPOHCXz3GdcGl1jf05y8VU=;
        b=nidxgo2GLEXIgMxdpWRpyZJGwOpYuFQOFwteGqr68O0A/Zxi5LFS14R4TqLMbq/foR
         d6ZAENZOV2LkxlVzPnKOXl3yTk54PZ/BnvfJHSQ62lPsswcGHV3L4LDsBDB8SGM5GOxt
         vNazhtm5P2zSqPrIIpMycjA0lOlNqAy01EB62wb5JbS1nPRSeSdWRDeBhjRVn8QhvMOo
         uQBzVLnH7Fd3sUzggIv9LQKOwYmPy4b9fvQTCS32zG4TELla+J9x44EqB1gWWiNUEWnN
         WArLziLyEoCWDnYP2c0F81IclBozw+q72fmvrhxNrKNhV44K2qY1pAoaJSPH5kQHeNZw
         zaXA==
X-Forwarded-Encrypted: i=1; AKwUvByp4OALl6zj8PDTETBIojuHKyDfOzPgPfAwKSEZQl027Xrah9E0BCjRb5+Hi2mRQ2f64YuHwHo=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++m78A5T52lYB48ckQVK8rkKpZ1IuBFYa4F4wmwVHrChvjBZHw/D
	VAKfZAWe9bsPHg8soFzdWXBShWQpo0L1E7aliYtT5Yym6Acjg8X4bh8AomuPVopd3+aN8yQ52Cb
	R+jup2+NUwiTOz2OsnSJu8r0gCI4PTItqfNbI352xY2u5S3M/hQnnYNdotB9QWqChvBs/gtm8
X-Gm-Gg: AYBFou19Y/qcLfCddPyTPJRDCpQUIpj9pY90kQTTcEY7Vny5lachZIOFaScjGFCOtkX
	sRIkAhxDranRduPRbGO6uNuqHPTKa55ymemjwVOiBrzD12gPydg6qSH6s50eG3CmnjqRXaXjW2G
	F7IZN9rro4YYMzkD7+cp3nFCSOxkDfjiZZV+kwr+lSG1x9zX6uEYHOzFlhSnMCnu4uNlFuICpaY
	Pzzhc0mIid/l07lYaAZO0VKtPIIly5cAG/kXA3UcC59PeYna2tF7kDsyKSRN0TD+FtZlO8s4H5P
	O2P8W9s0QlyzL8ngDvG9Up4d3IEEB3OmkrOS7xEx6kkJM5WOdsrGIRoA2mkOrnRmWBrPyVKcwCJ
	skhcug3KIND66sbLpsSslNjbajyjYnz1jmQ==
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr35910557a91.16.1788773352953;
        Mon, 07 Sep 2026 02:29:12 -0700 (PDT)
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr35910496a91.16.1788773352487;
        Mon, 07 Sep 2026 02:29:12 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm1627830eec.31.2026.09.07.02.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:29:12 -0700 (PDT)
Date: Mon, 07 Sep 2026 14:58:41 +0530
Subject: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
In-Reply-To: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfX29LcLXthmfQS
 gOOzbmyF3kguoXehi/Vh+2lpuw8jbIvS2lz14fa+A1Si2yK0ZJ7rRZ1DL+rDuSUp/RTqLVy+YBr
 iraKgijPjcaawRoypqlVdLlmUQ72U0dcWJYFlc60cVlCIPlLSvl9/X5Q9swmvsMDMIKvID6cEPd
 +QAIrC+wgE+Asilf7GOd7rg8B3P64XXNxgjDRN8Aed4pnV9vG82nG1ftor/CHX/jLxCYtW+6gYP
 FaCS01eO9BMFpT63cBMDVAbNcm0AnH1ZPczfh8/IRjfBlzTJTqZKVdHAUth9NMfWC+N8IectxC8
 1Kt4+zusW4L9VBXYlr2g18IhEdcHGfSeY2KxE+IkAURYtbXLuOVXeEkvfmkrMI/Q1cMPdyzHAlO
 zi7bPn2bHD55K5WVR1iL+Jox/pUVJAQP0sD/KYK9axmpuhPxJk5qI/ZJy8Ug6+EQ79wmG5uOyQ5
 OhoXb3KR9hrEOdorpGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfX+T/WPRJPT71C
 n6Ar1YCL+XM4ZMO5rkSc7olQ04WCTKP8wVQf8Ojf3cILz/CQ448+OaFQHFyjl8BcDG+scVyFufb
 VNCTmSKOZaR1rNcWhxbcrJKT/2+hA4o=
X-Proofpoint-ORIG-GUID: Tu5JroaYFUOzrJalHMpJ6N3fV3TKEDFI
X-Proofpoint-GUID: Tu5JroaYFUOzrJalHMpJ6N3fV3TKEDFI
X-Authority-Analysis: v=2.4 cv=LZYMLDfi c=1 sm=1 tr=0 ts=6a9e83e9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070103
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E984D45078
X-Spamd-Bar: ----
Message-ID-Hash: Y5RQNHVCKU4DGU4IGXYLURKWYDOMORZN
X-Message-ID-Hash: Y5RQNHVCKU4DGU4IGXYLURKWYDOMORZN
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Y5RQNHVCKU4DGU4IGXYLURKWYDOMORZN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
is enumerated as a TEE-bus device, allowing a client driver to bind to
it via its generated UUID.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c        | 4 +++-
 drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 4212572ff54b..aca4e8c6e37b 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -753,7 +753,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
 
 static const struct qtee_service qtee_services[] = {
 	{ "qcom.tz.uefisecapp",
-	   QCOMTEE_UEFI_SEC_UID }
+	   QCOMTEE_UEFI_SEC_UID },
+	{ "qcom.tz.tpm",
+	   QCOMTEE_TPM_UID }
 };
 
 static void qtee_release_service(struct device *dev)
diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
index ecaf8db67d45..87f1c257a877 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -106,6 +106,8 @@ union qcomtee_msg_arg {
 #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
 
 #define QCOMTEE_UEFI_SEC_UID            413
+#define QCOMTEE_TPM_UID			81
+
 /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
 
 /* The message contains a callback request. */

-- 
2.34.1

