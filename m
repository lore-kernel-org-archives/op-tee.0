Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6326CC6B34
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 06:40:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1A44B4530B
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792046406;
	bh=JYTMtNgj/5fZcL3ftFEkoott1ir+FEvQxYenqM4wIjE=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Rpy5lnFj5ynncxdUMwWcmBpKkyj0yNZSfhkkXtZ4zIUKts8MAPDxSLu3pasOIwyKx
	 fyQ8w2i29la+CkFUXxLuvsN7r3i2AEoCir/aCHEAYp8qAZasssbgM6bsQAt4JIuT0A
	 badvuxf9QDEkyYSI4l42oHv6wCuFhOjbh050S2ocVDdZqvegmiDvYa4FtF76DDvkvt
	 yTnwcvee41eaujDKXZ/n7zG4YxKc+N5uogAHHMEQNaXaKOorqHPrqP6U9Kkdppuvr6
	 GxmmfwjLeD5ta7XT3swT+jeDsGv+HDy+XIJzvgj/rzj6tCjd1IX3l1WGnLyaXx0/os
	 wSaJrXQBRNTBw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 43CDC45301
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 06:38:31 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TvXu1D1e;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MEIawW/p;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F66xMj644576
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 06:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vn+PAPU2yd7dK7uPhM98pxh8Uq/TtLrKIIgwoWoqb3U=; b=TvXu1D1ezG/STOX9
	8R0AFj1gTvm2/nHC15+MuZiqzspRvk1HLnKXf4UGL7aK6ufIT3D82+PG4lYDENed
	2FEX1L/DHyCgsk0SpV+bJMV7i5db5Wksppsd6LrHXuWR954+54infdTFRWAfc6YW
	bZv8xx7yq1k2Hzz3L6Y8Qyh6XKQCljvo+zVecVDMW3aeMfXRxmXaQI9qxU0dW7fV
	MUSBOlwWv8HVFwqdnE+r32Jx/13swZ3AyVazVPPCzxCQFFJzb6KbqAZEKPMKH2xn
	PwSz4sp8WioAma1ICiJPmSgPV9rCceidSbBNB0Y7TIy9Q5o2t0f5IYzAsGWxt8kt
	aSeeKA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmy9h2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 06:38:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab9850456aso1753439a91.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 14 Oct 2026 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792046309; x=1792651109; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vn+PAPU2yd7dK7uPhM98pxh8Uq/TtLrKIIgwoWoqb3U=;
        b=MEIawW/pxooqRKw6FP+fZSlpyyvaYjw+PhltWTDSn45HSU2IXd9chYE+lOz32qGFK9
         DudNcvLDbiTi/jtB+y/a1AFlL9w1fAJxesrMPVuSlTvc90e/DSVudxOaSaaDbijYmpj6
         xOvi1fBT3hDXyG9rYQbXwAMu4OKgkBe9mn6MpembwXF8wDfGBdSz1yRmtdGzDwtP9cql
         RfOSQHq+YWYaaPn5Q0a7K7X1YguQSnbfHAnZ4chljLRsOPxW4d3QmQtfXOxg7sOzIsA2
         v0CbFXAAonAOUA5ly3JfgsEmZvYlisc7769BCo77pPNVatq9E4ZdnVAhv6CuITblj3hH
         Uq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046309; x=1792651109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vn+PAPU2yd7dK7uPhM98pxh8Uq/TtLrKIIgwoWoqb3U=;
        b=i9r55rvEWftD3EOoCOfhNaAX5d/65aE1Svm6dxEjkCx4v8gRfq7TSIIvGb+zx7fkiv
         BMCgSg54qDrXjnwzMrNyzHiDcxXsGQfWBkOFQZpN++cmyoEL8qZ6YgGIT8XO1X+ECShu
         rzjiV5yFP66H70zhH8g513EkLtqj3YMoFn/wiyLmxU8srERI9Z70mamvlPVl63HOLuYU
         735hQrBFODRFmGLEQ/37Tg/dtw9FHHBiImCab3DBqt/CoGUbIEA2YzPSj97Rlg7t4sad
         S5qCpg1XrjLjAoW/Fg7NArjN0glxU5nz8ze6VZlml511yxXZyW9jUo1pJtzGkLmC7sFq
         4kKQ==
X-Forwarded-Encrypted: i=1; AKwUvBywtw/XtNC2Gj729ylWz9fMWvm5v63k56Q1X2ODX2ISPQ52UJ4xV0bD4yYUhuvuHPxzDACDcYI=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIb++3dzAdTJoSs/VBu6FNsdwm7KGdJ/Pou515/pG25Q+YXzXBm
	ExZ1zb/QYMVJ6TtL9gBbfcfy/Cy6uYwgHTsd3Og8+wzxq5Gz1/njaeGEehgHhltHAt/ynk4Vvzy
	A6ajdX2plawboAFxYxarNLI9QZeCvArkGrWXUnrTxOVfDABJq16WF68Sy6rSoSBugRiFMSBAS
X-Gm-Gg: AYBFou3Ae+HKx9DR63Ds+SVY+I91MHKD9WVLgoNmOHZ4iCDExdFJP4iPHzpdX4ogfMP
	NDer/0ghwdWcV5HaMg0CfLpbG0JViGqQ/xNjLnISorEb+chZxXZ5Tg+7JDCKwGVclkOWkRXhaId
	N0JlIfRw8UhsM8tp7QIMucV4j/C2WWX1yzGBcS1WgfXYFP+Fwb0iAgkcgpseQLlS5hXKEuWuJc8
	0MNVnnyUzhsRwZ2RPszf0my6F6/IDoEyzzNAKD3TEQb+7vX3bKT0CYPCb6b+DZKQSJLgj1j1kbz
	rbK+hXPX8x3+CHF7K8FnPiSrgEqqlULBQ+08YeAexfmMkpsoxzz3bJNnt+JlMbdRbceI2CQ1mCW
	nAKDKKTLpWu3XwdeRk4R4AMI+nFXeQipl
X-Received: by 2002:a17:90b:4f4c:b0:3ac:7377:fd48 with SMTP id 98e67ed59e1d1-3ac73780712mr3644503a91.56.1792046309418;
        Wed, 14 Oct 2026 23:38:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4f4c:b0:3ac:7377:fd48 with SMTP id 98e67ed59e1d1-3ac73780712mr3644492a91.56.1792046308950;
        Wed, 14 Oct 2026 23:38:28 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93ff4474sm2844429a91.0.2026.10.14.23.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:38:28 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:07:48 +0530
Subject: [PATCH v3 3/3] MAINTAINERS: Add Qualcomm TPM driver entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tpm_qcom_driver-v3-3-247c8e50250e@qti.qualcomm.com>
References: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
In-Reply-To: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: RCnZ2FRjrKKm2q3cknpurCCjdZwyDcn9
X-Proofpoint-ORIG-GUID: RCnZ2FRjrKKm2q3cknpurCCjdZwyDcn9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX9077A+UsyeCT
 1rieQjJviBtJzrzkZOpUVWacMeMLyubmi+QMQWOvvfd9axjZCUSjOCTI8P3Md1xI/2BKsulGaCm
 ivSepaSyiio9BYYMSBdnXpZZCcCqtCY=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad074e6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tHMf5gnvwFDjO4kcr9MA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX36WnNYJkHWor
 7JIbAlMuK8eVn6sUfgKXCAkxHOm0sGRBIhHw8QtDDNwSB/WRt0XwRyS4PG/cKkxZ4BT7Gh4JETd
 LVCae9v/siQmbTinKXBBpdm9aJCOHFohcdXU2nKPxnpFwUHXyDqFJn4n2Jrdas4cMHh3+3FjFK6
 JOaRLIowaROCuo1XXtPBu58h1R1KiYGXVwNV5iSlM3WK05XNdOMDyPjKbR1Ndj7Ab/gPGcAnVjo
 1aPhO0UqkWERFw4JSZjnwVaJIVUKrgpLpHL6FAZK/C8ad2VMtTmQBQYfYHW8Pi5KaWRBEGB5DEL
 y9gz9h5XdpCf4GgviTpYf9RfoUtA8J//dsw1BR7vRYQB5cDaTnb6KcEJKpiQVwhhfOhEk20qL0H
 0A/l4pEi8BnAsUGxYPoXsz99OW/V3nL9mG/bm9metGEw2OjysR/mj7oCAkSNB4Oh+CZJiwvxJSA
 ovn/R+10upZw5OV4FxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150026
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.216.70:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 43CDC45301
X-Spamd-Bar: ------
Message-ID-Hash: YY54XQWRDEBAZADYPS7D3U242K6AUC2N
X-Message-ID-Hash: YY54XQWRDEBAZADYPS7D3U242K6AUC2N
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YY54XQWRDEBAZADYPS7D3U242K6AUC2N/>
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0426fc05a66d..618ebcf39ca4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23124,6 +23124,12 @@ S:	Maintained
 F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
+QUALCOMM TPM DRIVER
+M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/char/tpm/tpm_qcom.c
+
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR
 M:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-arm-msm@vger.kernel.org

-- 
2.34.1

