Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30205CCF2D6
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 09:24:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 59CB544FC6
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792401839;
	bh=YSCzLQSB16uKcbe3+cGF2KdfW35CZ03t502Q8V6q/LI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OjmR/Lpz29eLIBam0NO33tOJPUisGaG8HiASSls3dzoZXnwrgnhG2Oc89tCHMnF/7
	 0zLP0PEWa8zXWghr30eoTBvMDCw+QZUekLGpx2aY9yS+V9m/bqZDmiUrkHMDkv7K4P
	 EFIq4IfZD5qDsLDIq9lZnwrqrsSqpTb+VhmWAHIYHYw6oUYm3RwbVo4DyRDvMRIfxT
	 H6s+Q5WXW2WHqQwawLWUvjuti3J9dgSED61p9DeKgYRJMVhOomCR3O+FATGdp937Rd
	 nw0MszFvFj/vjWIZ6gXuY4Nf5UTLS+EvHJDAPAsHCisAMZLNv2rU2gZEImubDYmrS3
	 OGm0coE+b0VcA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 60D4F452FB
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D8KQYvfU;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VQl5Muzt;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8PDwc2193399
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JPhY8yd7nilzGQLPZJehSpMwbHwaeWfXH6IGdZHCFa0=; b=D8KQYvfUiGomP2vh
	1E77fvOYjhjovo6v7Bq98ClXgB4uOqnjTsPDOdrHftph6UYBzuPUPD6cker2nYcH
	sZK1qQMPRxWJ8xLeCHgs2qZ/YYCReKRggLsnwxL8QJ/L4NsgBBGDtvYa0REueiEY
	M4tp6vNPPrASIuFcvB08XU1frJyDqYdqOjBQivvdDpTIVCc8LyZMdz51LLdF9RaT
	570etR8Ruyq8diobA+wKbzaXeu6/Xx3DVhcT6rek/nM5C5qiZ83MyyXVCYaELnIF
	ZN8l/qkKU8Wv26frf1wboAcmCupB98O1HA4Fp8YqGZ5Rb6Eygy0NkT54KWYyRY4B
	ZXpV1Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1a0sx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso3033137eec.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401749; x=1793006549; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPhY8yd7nilzGQLPZJehSpMwbHwaeWfXH6IGdZHCFa0=;
        b=VQl5Muzto1s9FP8jw+Wdi5NFeg8EqsSypQzicfSS24+mM2vNIUtFSavJlfCXpcxNMb
         N6KSeFqwkQpZoC4qHOiJjSBa0Jf+t3F5bsqVpVcCUOurjDMCCHCemS/p8YSdFJJ3fg7Z
         ZbeFcQcCS6A73TiI2QR//hkzc9oJt1MQC+f0MOrL+pEYBPEMZzg79USpXWfvvkcgWXnt
         QlhPH8IazMG5ALtUwmq0+Cb67XRQpoEMfT3hT2fC8dv8TCirYxXposyHUna9h9EAcZ4V
         MHZXP2Cb4rcsBPzwmDTo360PraIPbqhX/QeGMIORktjuNENx7KeH9pCkWHFyMBUwh4no
         E1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401749; x=1793006549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPhY8yd7nilzGQLPZJehSpMwbHwaeWfXH6IGdZHCFa0=;
        b=Cawi0u15T1wjAuhlEdci4s9l19gUkrfuc4YJ5HLh0GB41xU3GOpHLEx6+g0GEzJ6n4
         lZKIm+izifKUQ911isj6wMS0G/buyfBBPsmpA3AkPgtSYCQu92XRy/7fl9sDfqkOS4zm
         u6SohOQskeBao46bw0UyNWKJRzO0DKGjRDiq0zhSoPHYCytipEHFS2K07k56L+pbDGfj
         BHFuAOaFf1W9KkeOxPn3k5N96oeOIbEpBEOrJolatcZ8D4oQ+B3Z0rWhwXBMmxhk7fyM
         sZ8T6VMkQfTGwNcwniZ2YYew4J5urmZznMXXadZIdXwYd1W+rFiFennI2qtoE+FmbSvd
         vEhw==
X-Forwarded-Encrypted: i=1; AKwUvBxPRjxvsPKj6Khm/nMxRW8/f0bwEsmTF1u2slaOYgYBjoq4OrIJ0ahdAt+G/8j+WiZb1h9VYeA=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIYFK6VqcWna6qSUZdhSU0SwI8B7zwo4WqK625J6oQiqRdiO1NW
	Pog4F2bO9sDMkdyFlGirO+ipTMFi8NIcqZfm6tynlQnDFBK+Xg4NxAPTnyJj6WI2OgAAe12IsQQ
	fkVW9rdmDpYN8lOuXjXc+JgZH9e07MqPzXQFor6v1T7r5rRoatLYMCaDAdyNwOC95q/14zY6W
X-Gm-Gg: AYBFou0Qog7YlTC0O4bIcQ6uKDwG3YsYFV1IhBSgChTBHa0mi3DM8nnilRP+M/wO2iD
	C+eYrrTSfz1E6t3oytRISOKPirKti/CArWEZLmen4X8vzCqBFTbV6CwRe01eqWCtnfFM7SpDceF
	6DHXqAMHsql3mOQTR2vcAUgPBz3XRYHMMrulJ0E6rQ2o3BGfvKmRVMC4PlaS6yCIvQzJOJNGjqs
	w0cg4N4TEZPVYvCwfxm2pDkqC0skQRNG6eXr3kfTen6uM5OP5rxpmlTmginbQbt5CDO+Dcs2g03
	XjMQ65nAiT3XQnkTuIg3MYB3jmCaRetTEEM+mkqlJdDU9tHt0kvzXbSbK2MJGR6AnbgikmE+p14
	a8hSL9fa2vOYt460OB1UnqupJ5rdcaJK0
X-Received: by 2002:a05:693c:6395:10b0:35d:b44:a52 with SMTP id 5a478bee46e88-361a23528d5mr10797494eec.24.1792401748812;
        Mon, 19 Oct 2026 02:22:28 -0700 (PDT)
X-Received: by 2002:a05:693c:6395:10b0:35d:b44:a52 with SMTP id 5a478bee46e88-361a23528d5mr10797467eec.24.1792401748285;
        Mon, 19 Oct 2026 02:22:28 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm56225094eec.24.2026.10.19.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:22:27 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:51:48 +0530
Subject: [PATCH v4 3/3] MAINTAINERS: Add Qualcomm TPM driver entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-tpm_qcom_driver-v4-3-6889b9804ba7@oss.qualcomm.com>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
In-Reply-To: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX44h3witFAyL7
 b2USfK78JoqEDG0vFJKEbY4B2aL6r3AJPcC5SDOCl2JzWUcBP9m+erCZDanDBT7cSFgbObv9LnJ
 Us6/8bPGvZurxpkJe3iokB/64XiYo64=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad5e155 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tHMf5gnvwFDjO4kcr9MA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX1y9FaVSGNYMX
 RtSs2z1eqiu8dvO0IjoKr0/8obGPI1Xgi1kz+846rtVkpNlhm+jMmps8zL4xpccEXNFQN6QYc39
 8HQgOIAkZBD/Rz+YSmSOQoikBEXHPkgxZn0yyTot/qE/FNk8efH/9iLjZTImYr/VDxTqrOh96hd
 baEXmYLe1qJ5ME1BO5CPHn590PkcuaBxCadW+3/+y8+VHgmf+g7z0UibGR2wh4vuD9Gd/jw9CQT
 JU+VvWfZt0/FrarUoNaTu/ASdZBoPoLwCI4vX4f7d+wPq+xrpAPSHt7y3x3lOvSnuPoah6UB/KX
 Xn7J6rsQWSi5ml89OhOQlJzTK6bVjKPA8136JTH2UhyW4UcrzAIU3hCkzbVT0Q8CA5vyfkwTTHy
 y8pSR2iC/EpbREOEMo54LougMJaF+Ws8gSkxkNO2ClJULaxnq/qjYxbwxlyKuCOfTKi6PKfyL10
 Fn/OFu/09a9mn/3uetA==
X-Proofpoint-ORIG-GUID: nFr7RiRceOkXmChh-aRl-rhjUaxJFHHh
X-Proofpoint-GUID: nFr7RiRceOkXmChh-aRl-rhjUaxJFHHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from,74.125.82.199:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 60D4F452FB
X-Spamd-Bar: -----
Message-ID-Hash: T5XADFQ2PB3KCVGOJAYF6FFKPXAMIOJ7
X-Message-ID-Hash: T5XADFQ2PB3KCVGOJAYF6FFKPXAMIOJ7
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/T5XADFQ2PB3KCVGOJAYF6FFKPXAMIOJ7/>
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
index fb43b8e46158..bb86a7c024e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23160,6 +23160,12 @@ S:	Maintained
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

