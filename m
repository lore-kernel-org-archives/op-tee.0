Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB7BC79F9E
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:30:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1C68844F7B
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788773440;
	bh=LslZmHiFw4eXcjoqHRbytzcKNjsZS+rKv5x/W1EAPV0=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=DLaa46ZRSn9QAiZUdS4NISr0Fo4rYx+xdhheWeZ0o+Bt5whgT1lVp8diEMfRx+VxM
	 734pCpzFkbCJoOPR8xR6drhiy0tv79Wafj4itJzMhsOUTfpak31yWqpgqiVOVxvKr5
	 FWd4yvvPsAH3/s7X59SUoEZX9aVE2vLk13wtZVCaAaoCFyLyxRS1P0ZLPxnHKHC6+e
	 MtIkd3GAutbeoBtvZMRqAJGpwNxKo/Dlxfg2H35ZJxbRo50oCI3KBav11S2TTFx4dU
	 z4GnEzEA/IK1m9vmhEifc3H0VA8G94KnzoBuXKSQCt18SarShHMjHVbvsbc73b116H
	 nVlkCAi21HKSA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 08E934544C
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Sep 2026 09:29:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sxg5vOaX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DE/Gomp6;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6877p0cD3657529
	for <op-tee@lists.trustedfirmware.org>; Mon, 7 Sep 2026 09:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/7NO8TOpBC2qx2KaYdX3mrHnbEjM6bfcjdRZslwa4oc=; b=Sxg5vOaXl4yHp9ak
	QkMnja+2wsqotlO3dDUwkra4vczbz7Ev/CcqAbm40LVbKYlgKsTHwvb8z6C0/o7h
	eB7QwackLvWoiC646JLlvZ84ZdmHg2ex8+OkpQzNJlHShG/ekV79LZuoNyUBlxs7
	634PQuHtDLyYCiQ645RPx3FNQKb1eYexavNg1hGf0Aa63gQ5FZCzjLnj+nu0NhYA
	1IuszZGSDf/ptWYBo1sI6TErjRsCgNrwVsDT7aY/XfHDA2LqJm/vU6DMZEGDGewq
	w0oHdv0jfrs2DOoqYb2T1grGGzi+ZHajUq4rQrilRkUMQa+lTXqs7LEfKpvGPsXq
	5v78cQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86rf17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 09:29:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1310949a12.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788773361; x=1789378161; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/7NO8TOpBC2qx2KaYdX3mrHnbEjM6bfcjdRZslwa4oc=;
        b=DE/Gomp6lR5isPGr1kzWaqV5SNuVStdD71VUT3fRh6vXtJZ3/AifSsactVgRL+/y4F
         PPqWSfj1+x+v3m0oru2h6O9JwLSYHYFMEzFOcSfm75gVmELlpauPj5U5qqZs/WEVh3YE
         8+lh76k/MSliP29nXV2+n4HFIAa/5qh3TATWaJD79XpRPTn0/cwQ+H4NiUFbJ48SXY1u
         rbEdsmMSRs5uw6zGPWNf7DefM11ESjznhYZvmPY5b7qy6piudfR2wKHkUESSvbisTVEY
         5uLijficYOj8VB+SnbHKkLW28q2vnh1Ge9+nX5nRF+vUq98FIxebrJqTR7UHOwXl5Fqs
         Fz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773361; x=1789378161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/7NO8TOpBC2qx2KaYdX3mrHnbEjM6bfcjdRZslwa4oc=;
        b=KFNgYGalby9OFzZ+wgMCoXGgF7Ta6KUQCqQeBAOcN7/c6xB2d15t3JzDkWbAOh6U5k
         8O8eeoVFCqjOfjPSctS0Ss4Yq6EFpMPwKYw5YML6h/KkFwf+J4SCoC9CvRhq2IdfBVr4
         Vmc+s2CCK4qNZ5Rwvw16ClkawaIlLCUiGAdpF6WVcoCPOQfOxIn+vSAmcCdvJ3+BVk+d
         3FnepQPx7VDmPQIGLg1HCeiOnH1O2fk0dZMXX4CgnHHrPkhQpMnJunC723f9t1wAlGTB
         HJiKQSpmnnEPPTWwVrED9cdZX9Cj280et1i8yde0MzfH+yb/Gd0ohAjX+l4crK5d+nDs
         ja3g==
X-Forwarded-Encrypted: i=1; AKwUvBwgRpb/mxhuFvFdaJNQ39/4Oh6CB+/3TXEtgyK26HAMO/JlTvt1Ezn6sa0EmcHweLn6+4r1BeE=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nT0P0i1miim4iq0dGviS+allVLktzUn7I802uVJyJcAbhTgg2T
	z3JXZRxlDw+AAklsTdZcEW+9oDbjAROBzYXg5BNCc2QsG0Lt9rZbvQD4CinJO1INkZxVXBmamdW
	lpcI5s5hCMPCgMq2ZxV//Rycr573mJyvqatp55IrqIEGQDdAjwwEwZNraye/Umb/jaLg/v4/9+d
	YYAMEs
X-Gm-Gg: AYBFou0D2+sSqre222wr5qpSvJw1DVpaPyBiiDNhfj26UBPDnoP5Gkd6VTHr3Fy6iRu
	y+3JUUJJeZ2kJl1n4P2bV++Y4qqIS2RLZDxRChLEVKyzGSjoepiAyTGBZeRNypa2oSIAmE3gD+B
	jrkqeoZxG9Eg6mpuQRf1h1/5lmZ/9ECo+2XWca7+gApa7d84mnvnxNlTEP/S9vgi8MKIQczIxFg
	HLVTAcWj0FHrSNHVXELzeKGZ4ihxlALb6zsjeTcmfkfTPbcFn7bEbnQFW/EPSjqrBXLbR88+046
	Uh6zetvyNGFNVEnXIea23Kn6Sk7D4gk/2Jo9eVF0faY4ypdzMSzU91POaN4auWj0E6T2k8+XCpl
	4xy6nBbwl9DELh6yzp/AcrH60qIpFtJVYiw==
X-Received: by 2002:a17:90a:d644:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-39b26245cfcmr34204113a91.20.1788773361351;
        Mon, 07 Sep 2026 02:29:21 -0700 (PDT)
X-Received: by 2002:a17:90a:d644:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-39b26245cfcmr34204062a91.20.1788773360958;
        Mon, 07 Sep 2026 02:29:20 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm1627830eec.31.2026.09.07.02.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:29:20 -0700 (PDT)
Date: Mon, 07 Sep 2026 14:58:43 +0530
Subject: [PATCH v2 3/3] MAINTAINERS: Add Qualcomm TPM driver entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-tpm_qcom_driver-v2-3-71a6b1752da8@oss.qualcomm.com>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
In-Reply-To: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 2b3xlm5Amy_YjfqpjbwDYRNR8skyjJaW
X-Proofpoint-ORIG-GUID: 2b3xlm5Amy_YjfqpjbwDYRNR8skyjJaW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfX3Y79s0FLbINp
 FCowxNh3ZOg9PMy7ARbQEXlg0QVC82gNrNhMxkPzK3AjvGEN0rtufhKYl2SYybuyoDkx5aYps+N
 NIV1aQt3xePI8CnPi+1AUHiLaUr1gYM=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9e83f2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=sADh3fXFaV6XPm21ZS4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfX+LRiAIwuubWk
 Wlwbeaa/5wiPNVDFZxyB4SeYw+S1/ZraUYyA2ywjjS/sJHiWHxO6uSqx9sZQJ4oCWeW3OkM7qCW
 jX3YuBiHBHsxRTe9aqKzRiKagmuS1iMdIy7cOvzL5jEMQZ7FGHy6d1XTZ3QXRYiLEVuQaxx+GEw
 FLPJNf5I9cf3OX4hmi8z6AgeQy70dEU6LbC/brD6zgsX0Rkyb7uyQBanF6RwMVxumKrwJq7q36U
 tnV2bnANXq4U/jwIEG7tsgIyo5J1TG9gsoTZ4SUu32M/6218fMbr/oiY80xgVbD4cY7FSfldkHY
 20fzbhglMqoQ/zgfQWYP1Llc9nJ9ZWw/lmbC6f6Scj8j0YTRNYiG+3XPENh8WlN5SFkw99PythM
 oqxG/2yrywYRJS1KJprQS7NfJFErjDEM4c8zbtGuruxBc+iy8TLJEYwqVGwqOOg13HNp50dsB/s
 qpFYKsWaZUa34car4ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070103
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 08E934544C
X-Spamd-Bar: ---
Message-ID-Hash: LVCTXIPMMW6562BMN5DDYVWIUDG253RJ
X-Message-ID-Hash: LVCTXIPMMW6562BMN5DDYVWIUDG253RJ
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LVCTXIPMMW6562BMN5DDYVWIUDG253RJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Add a dedicated MAINTAINERS entry for the Qualcomm TPM driver, which
uses the Qualcomm TEE interface (qcomtee) to communicate with a TPM
Trusted Application running in TrustZone.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47b04968e79a..cfa5b66823c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22636,6 +22636,13 @@ S:	Maintained
 F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
+QUALCOMM TPM DRIVER
+M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/char/tpm/tpm_qcom.c
+F:	drivers/char/tpm/tpm_qcom.h
+
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR
 M:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-arm-msm@vger.kernel.org

-- 
2.34.1

