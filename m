Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11638CA5FA5
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 23:29:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1E6B745387
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 23:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790638160;
	bh=vWIA3l4w6E+TCN4JaSlqXNflb0iofK7r9LV8tfj2r+I=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2dCKy+2O2igb715R5Wk3U9pfjoMxdJi4oUmtcAy2TW/2H3QgkT9DimKhALVhPG+xv
	 c5x0R5B0C7scbrCoF/uhreKR0P+nOAZigp2QKcM6HpQYsOdv5ip3vZJWTkGQ3w+ruv
	 h+Fh/2OzdbPtnjUogtuoRYWp6fY/gr8+SJOGL4jQbVglFRmvNVKmmE36Nt11tENWNN
	 LBi79f7mZ8osPVzh3/N5LglLYUINlCe3pmEktGF4Vevuba3NH6QV91WHar/LI2YUqS
	 K6J6/Z86ecrc5oOCu104X0yUSLW1pyKzwXbPR4K+uLPleRCVYDmeVNwPEwllAc90h2
	 HXRrS+XZ6zo0g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7030045038
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 23:29:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CQ3OGgv6;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PJR7PhyX;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SLTodl3666504
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 23:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6xE2nyS3lW30H7ahtMFF6UYIertiEom6t7xNVmNJeTQ=; b=CQ3OGgv63EVHtNec
	smX3OJXowwz7I4XTJpXRhkX7XSqpmH1/WFSYlROHACC9MiAR9h7RXd+CsMcA90d5
	+O6UD6JtLsSFCq8CtU3E315+nBOZL3n+jBAlZaHjjzLROmhaEh5zBh/v8xGMvSmA
	c3bB4XowNm1LGqQGXMFrn4FP2nz1/fe8q3tgW4X7C4PCcDgDmuGFoSh6Nh0OqfoD
	uLbs/O8bMihsK4ec+AM2JIUKkDPXUVy8UQlXwMBPCRLtVVPkR3za1xGHBlyt/tWM
	VNcGZsn6QjKolduS3/Dg77SQrNmjtkNcF7U+y+wt40B1cclSJxM37N0PBUFN6kS/
	S8IzoA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03h7k1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 23:29:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1a439db36so2086058a12.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790638150; x=1791242950; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xE2nyS3lW30H7ahtMFF6UYIertiEom6t7xNVmNJeTQ=;
        b=PJR7PhyXTmcYE29bfBPlnf2irV6OYGqfBI+9FZ5sQ7MnIHNqucm69WWsuP8uB2nOSe
         1OYUArVsavSjSwk2t1xshw1h4gOYhWFFznQgIpkAGcEK2m1cEMssNbS4c/sOp6zk19zh
         e8dvc/KIhyOaHAjMHReMbgoopWe6cKec2z/iAZsB89/GwyJ29uIu01ICjTdj7+x9v6pu
         JKgad9NVQ79dpd4rAg965C4rrMscSsZ7htCE6vZRpFSxA+iZ3P5BlzxMVnuLSY+h2DJ7
         vpywY+60dA2TC6lLcub7H7PDJlCnz01dB6e6sGw6IXUIlOO35JQI09yoNrA1nTLKcmwn
         9cUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790638150; x=1791242950;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xE2nyS3lW30H7ahtMFF6UYIertiEom6t7xNVmNJeTQ=;
        b=00ULXDBBI71O9S2Yv6YjbV9+R1fX37saSaMASNKzHYWcNAV1gPeK7JO68l2hm9DTUc
         qHTA4kGV0x18I9JTSOdR7hkusUT8QBkLl9qrzLbuiDYXG5SXHaPYtskiIhukll66RDVd
         /jyGoVGjpf2y2c55EREp+lrKQM6rQEkHOEDVYDmcCF23Mi6d2aEIf+B204XR+6439+rY
         7ZPORgPNQ5pefCPwdcAFXhd1eGqEUP4FdjEWJxXWsSFaDAHAI52/QpJkYbFwMmDCG3Gp
         UP2ghYjTx3GO7KB2smeiO6gHaMdQlp1fhAYFZTP5KRdYAJ1ZBAGBhRymZT22Qn/CEKNF
         7u/A==
X-Forwarded-Encrypted: i=1; AKwUvBy/kq5n1FXZsea7CgZkKhJ+fGP+hT0HgkeDKBRN0z364jStug2uD4x2eL0Pp5oUGIZbFRIYaiE=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nSrpzbJobXbBOzUnXXvpQOKkWfJFEc+XtscgVS4Xf5ppVBhQhs
	RIovTwac4FufLe7/6iIKBH15iRGvICq4Cb7YGXtZEMHZK6aRGtNsmbflDcV1P40Qaz1YfzX6nAd
	ppf4iozSH1CWm+BNbMQ3+pXKD/0BZ/3W9ICtx2dWhrhZUKttlKQgAOI8zJEoWZaSSBiHyyC0=
X-Gm-Gg: AYBFou19wtOsXgKEr2TC/yBzb0Z9yYZcCyWmcmAgZNpD9eF4AgwtGQHrjMoHWlnlHns
	s+okWSkTV47OQmStW0GgChIJTrQgiWIfwwGZea03vmFZ/pNbFSMc98K/RpOcUwkCUJf8n4oDeiv
	J2IdQ/UCPCsnDNRLTAf5sfj1+++bPYiKLeuxb7+g2e43TqnQ4XQigInT4/1zhmTXnK7iX3o/1ck
	parRVt+mSV9Umc74OytQnICOaPqZyoxkaxAXyGeg5XPKVmpTluMt9GF7CjazgIMK8PAhyuw2n/I
	YvwKBI344Re2EUuZXJUxcFTccRLqDTezBAm9p6mD/DTKj0LKzzO8bZGX872lLPgQxenB9nHU6hm
	mp++et01jgbpCpYInYpJavGmf9+tIanKI
X-Received: by 2002:a05:6a00:4148:b0:878:34b8:2322 with SMTP id d2e1a72fcca58-87e9bd7b48fmr9532525b3a.42.1790638150119;
        Mon, 28 Sep 2026 16:29:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:4148:b0:878:34b8:2322 with SMTP id d2e1a72fcca58-87e9bd7b48fmr9532500b3a.42.1790638149489;
        Mon, 28 Sep 2026 16:29:09 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.14.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea1940ecsm4793918b3a.13.2026.09.28.16.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 16:29:09 -0700 (PDT)
Message-ID: <6e2034eb-0192-4286-beb2-ba7f1186344c@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 09:29:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tpm: Introduce Qualcomm TPM driver
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-2-71a6b1752da8@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907-tpm_qcom_driver-v2-2-71a6b1752da8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA5MyBTYWx0ZWRfX1XPCwndsy6Da
 klb2eU9ZyLjdR9EShHr+rk67XBYR4SvDsUl960uERqK8yG6hll8I6dEyklFugfR/LLxz9RcwxEM
 Apphq8Nu7Vhg39g/TuhTOq2+8HGuJ8o=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abaf847 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Pslwi5Fl4CR3OXkguhnOPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Q5nOeYraEvT18xOnnC0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA5MyBTYWx0ZWRfXzZNFt7OCUa5S
 c1Cek5/91QLQD+MijLwg8W4Tc0tzb7/+PFyYkTjalO0Ce+jpLWgPJ/ZgdfTzHtAmPFdIP0BbjQ3
 pcsrTW6zfxfs/lYqrT1pzd42xD7rzXJnklup6M9uOPxReCGaE3gckBIXDd46KMqij9ZJipMiAEa
 a0XpBeMrOG47qwWojYFpv1DCE/wKPCE0FDhej+3KWKDAUBdyE83KCrX7eH+uVeTCQzMzwJz6EZZ
 rC8G0Iy5V+ew8OpwO6nPPguufdgoAAPab47NmpnA5sKs5ceHod8eG6GhAkb53p2HlVIteT+rBIu
 /J2WzGKX9Qu82PoPMHQUVpciF5vbvy0fvt6aQGe8bwjPINrJMyDJ6k1+0rhuhl7mFaHshqvErqn
 j15yZoulRyMxzRnwyBf/KTMKTrNOet1fSA4nDaL0c5jd5/APNEFrylsNt/nWQg0uTNhB7YIW47f
 Zw0a/IyycvZqpEwezgQ==
X-Proofpoint-GUID: DRx18X7Iap_JjvJYBy8imPSe-Tg8nKp4
X-Proofpoint-ORIG-GUID: DRx18X7Iap_JjvJYBy8imPSe-Tg8nKp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.200:received];
	DNSWL_BLOCKED(0.00)[65.181.14.184:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7030045038
X-Spamd-Bar: ------
Message-ID-Hash: 6UBU33AY6RLOZLOPANONQNHPFAWDKJV7
X-Message-ID-Hash: 6UBU33AY6RLOZLOPANONQNHPFAWDKJV7
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6UBU33AY6RLOZLOPANONQNHPFAWDKJV7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Kuldeep,

Sorry for late review.

On 9/7/2026 7:28 PM, Kuldeep Singh wrote:
> Add a TPM chip driver for platforms where a TPM 2.0 instance is
> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
> transport.
> 
> The driver discovers the qcom.tz.tpm TEE-bus device, opens a session
> with the TPM TA, and register with tpm interface. This exposes the TA
> through the standard /dev/tpm interface and the existing tpm2 command
> layer. OS need not be aware underlying TPM instance is dTPM or fTPM.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  drivers/char/tpm/Kconfig    |   9 ++
>  drivers/char/tpm/Makefile   |   1 +
>  drivers/char/tpm/tpm_qcom.c | 354 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_qcom.h |  83 +++++++++++
>  4 files changed, 447 insertions(+)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 5f672f2c01b0..05d704ed3632 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -243,6 +243,15 @@ config TCG_FTPM_TEE
>  	help
>  	  This driver proxies for firmware TPM running in TEE.
>  
> +config TCG_QCOM
> +	tristate "Qualcomm TEE based TPM Interface"
> +	depends on QCOMTEE
> +	help
> +	  This driver provides interface to run TPM instances with Trustzone
> +	  having Qualcomm TPM TA running in Qualcomm TEE.
> +	  The mechanism uses the object-IPC based transport provided by
> +	  QCOMTEE.
> +
>  config TCG_SVSM
>  	tristate "SNP SVSM vTPM interface"
>  	depends on AMD_MEM_ENCRYPT
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 5b5cdc0d32e4..471cbf49afd2 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -45,5 +45,6 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_QCOM) += tpm_qcom.o
>  obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>  obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> diff --git a/drivers/char/tpm/tpm_qcom.c b/drivers/char/tpm/tpm_qcom.c
> new file mode 100644
> index 000000000000..ef29c66f18ae
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_qcom.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/tpm.h>
> +#include <linux/uuid.h>
> +
> +#include "tpm.h"
> +#include "tpm_qcom.h"
> +
> +/* UUID of the QTEE-bus device representing the TPM TA. */
> +static const uuid_t tpm_qcom_uuid =
> +	UUID_INIT(0xaabcb593, 0x7083, 0x5536,
> +		  0xac, 0x27, 0x3d, 0x2d, 0x89, 0x41, 0x9d, 0xdb);
> +
> +static void tpm_qcom_release_object(struct tee_context *ctx,
> +				    struct tee_param_objref object)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +
> +	inv_arg.id = object.id;
> +	inv_arg.op = QCOMTEE_MSG_OBJECT_OP_RELEASE;
> +	inv_arg.num_params = 0;
> +
> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
> +}
> +
> +static int tpm_qcom_get_client_env_obj(struct tee_context *ctx,
> +				       struct tee_param_objref *client_env_obj)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +	struct tee_param param[2] = {};
> +	int ret;
> +
> +	inv_arg.id = TEE_OBJREF_NULL;
> +	inv_arg.op = QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS;
> +	inv_arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT;
> +	param[0].u.objref.id = TEE_OBJREF_NULL;
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0)
> +		return ret ?: inv_arg.ret;

These two functions are local. Do we really care about the return value?
No caller seems to check it. Why not return `TEE_OBJREF_NULL` on failure instead?

> +
> +	*client_env_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +static int tpm_qcom_get_svc_obj(struct tee_context *ctx,
> +				struct tee_param_objref client_env_obj,
> +				struct tee_param_objref *tpm_svc_obj)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +	struct tee_param param[2] = {};
> +	u32 tpm_uid = QCOMTEE_TPM_UID;
> +	int ret;
> +
> +	inv_arg.id = client_env_obj.id;
> +	inv_arg.op = QCOMTEE_OP_CLIENT_ENV_OPEN;
> +	inv_arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &tpm_uid,
> +						    .size = sizeof(tpm_uid) };
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0)
> +		return ret ?: inv_arg.ret;
> +
> +	*tpm_svc_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +static int tpm_qcom_send_command(struct tpm_qcom_private *pvt_data,
> +				 u32 locality, void *req, size_t req_len,
> +				 void *rsp, size_t *rsp_len)

This function seems to return both negative and positive values,
with different translations. This can cause issues; see the bug in tpm_qcom_send().
Maybe this should be documented?


> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +	struct tee_param param[3] = {};
> +	u8 locality_arg = locality;

What is the `locality` arg if it is always zero? planning for future?
Why not `u8 locality_arg = 0`?

> +	int ret;
> +
> +	inv_arg.id = pvt_data->tpm_svc_obj.id;
> +	inv_arg.op = QCOMTEE_TPM_OP_SEND_COMMAND;
> +	inv_arg.num_params = 3;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &locality_arg,
> +						   .size = sizeof(locality_arg) };
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[1].u.ubuf = (struct tee_param_ubuf){ .addr = req, .size = req_len };
> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT;
> +	param[2].u.ubuf = (struct tee_param_ubuf){ .addr = rsp, .size = *rsp_len };
> +
> +	ret = tee_client_object_invoke_func(pvt_data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(pvt_data->dev,
> +			"send_command invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*rsp_len = param[2].u.ubuf.size;
> +
> +	return ret;
> +}
> +
> +static int tpm_qcom_get_ta_details(struct tpm_qcom_private *pvt_data)
> +{
> +	struct tpm_qcom_ta_version_req ver_req = {
> +		.command_id = QCOMTEE_TPM_GET_TA_VERSION_ID,
> +	};
> +	struct tpm_qcom_ta_version_rsp ver_rsp;
> +	size_t ver_rsp_len = sizeof(ver_rsp);
> +	struct tpm_qcom_type_req type_req = {
> +		.command_id = QCOMTEE_TPM_TYPE_ID,
> +	};
> +	struct tpm_qcom_type_rsp type_rsp;
> +	size_t type_rsp_len = sizeof(type_rsp);
> +	int ret;
> +
> +	ret = tpm_qcom_send_command(pvt_data, 0, &ver_req, sizeof(ver_req),
> +				    &ver_rsp, &ver_rsp_len);
> +	if (ret || ver_rsp_len < sizeof(ver_rsp) || ver_rsp.status != 0) {
> +		dev_err(pvt_data->dev,
> +			"failed to query TA version: ret=%d, status=%u\n",
> +			ret, ret ? 0 : ver_rsp.status);
> +		return ret ?: -EIO;
> +	}

You already print in tpm_qcom_send_command(), why here again.

> +
> +	dev_info(pvt_data->dev, "TPM TA version %lu.%lu\n",
> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MAJOR, ver_rsp.version_num),
> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MINOR, ver_rsp.version_num));
> +
> +	ret = tpm_qcom_send_command(pvt_data, 0, &type_req, sizeof(type_req),
> +				    &type_rsp, &type_rsp_len);
> +	if (ret || type_rsp_len < sizeof(type_rsp) || type_rsp.status != 0) {
> +		dev_err(pvt_data->dev,
> +			"failed to query TPM type: ret=%d, status=%u\n",
> +			ret, ret ? 0 : type_rsp.status);
> +		return ret ?: -EIO;
> +	}

You already print in tpm_qcom_send_command(), why here again.

> +
> +	switch (type_rsp.tpm_type) {
> +	case QCOMTEE_TPM_TYPE_FTPM:
> +		dev_info(pvt_data->dev, "TPM type: fTPM\n");
> +		pvt_data->is_dtpm = false;
> +		break;
> +	case QCOMTEE_TPM_TYPE_DTPM:
> +		dev_info(pvt_data->dev, "TPM type: dTPM\n");
> +		pvt_data->is_dtpm = true;
> +		break;
> +	default:
> +		dev_err(pvt_data->dev, "unsupported TPM type: 0x%08x\n",
> +			type_rsp.tpm_type);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/* fTPM does not implement this command and to be invoked via dtpm only. */
> +static void tpm_qcom_transfer(struct tpm_qcom_private *pvt_data,
> +			      u32 transfer_state)
> +{
> +	struct tpm_qcom_transfer_req req = {
> +		.command_id = QCOMTEE_TPM_TRANSFER_ID,
> +		.transfer_state = transfer_state,
> +	};
> +	struct tpm_qcom_transfer_rsp rsp;
> +	size_t rsp_len = sizeof(rsp);
> +	int ret;
> +
> +	ret = tpm_qcom_send_command(pvt_data, 0, &req, sizeof(req), &rsp,
> +				    &rsp_len);
> +	if (ret || rsp_len < sizeof(rsp) || rsp.status != 0)
> +		dev_warn(pvt_data->dev,
> +			 "transfer state=%u hint failed: ret=%d, status=%u\n",
> +			 transfer_state, ret, ret ? 0 : rsp.status);

You already print in tpm_qcom_send_command(), why here again.
If you remove the message, I also argue the function is not required.
Directly call tpm_qcom_send_command() bellow.

> +}
> +
> +static int tpm_qcom_cmd_ready(struct tpm_chip *chip)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +
> +	if (pvt_data->is_dtpm)
> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_START);

Is it intentional to ignore failures here and in the next function, and always return success?
Are these functions best-effort, such that failures are considered irrelevant?

> +
> +	return 0;
> +}
> +
> +static int tpm_qcom_go_idle(struct tpm_chip *chip)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +
> +	if (pvt_data->is_dtpm)
> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_END);
> +
> +	return 0;
> +}
> +
> +/*
> + * The raw TPM2 command in @buf is sent directly as send_command's UBUF-in
> + * param and the raw TPM2 response is read back from its UBUF-out param.
> + */
> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> +			 size_t cmd_len)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +	size_t rsp_len = PAGE_ALIGN(MAX_RESPONSE_SIZE);
> +	size_t copy_len;
> +	int ret;
> +
> +	if (cmd_len > MAX_COMMAND_SIZE) {
> +		dev_err(&chip->dev, "len=%zd exceeds MAX_COMMAND_SIZE\n", cmd_len);
> +		return -EIO;
> +	}
> +
> +	u8 *response __free(kfree) = kzalloc(rsp_len, GFP_KERNEL);
> +	if (!response)
> +		return -ENOMEM;
> +
> +	ret = tpm_qcom_send_command(pvt_data, 0, buf, cmd_len, response,
> +				    &rsp_len);
> +	if (ret < 0) {

This does not seem right; tpm_qcom_send_command() can return positive on failure.
How about tpm_qcom_ops.send?

> +		dev_err(&chip->dev, "send_command failed: ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	copy_len = min_t(size_t, bufsiz, rsp_len);
> +	memcpy(buf, response, copy_len);
> +
> +	return copy_len;
> +}
> +
> +static const struct tpm_class_ops tpm_qcom_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.send = tpm_qcom_send,
> +	.cmd_ready = tpm_qcom_cmd_ready,
> +	.go_idle = tpm_qcom_go_idle,
> +};
> +
> +static int tpm_qcom_ctx_match(struct tee_ioctl_version_data *ver,
> +			      const void *data)
> +{
> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
> +}
> +
> +static int tpm_qcom_probe(struct tee_client_device *tee_dev)
> +{
> +	struct device *dev = &tee_dev->dev;
> +	struct tpm_qcom_private *pvt_data;
> +	struct tee_param_objref client_env_obj;
> +	struct tee_param_objref tpm_svc_obj;
> +	struct tpm_chip *chip;
> +	int rc, err;
> +
> +	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
> +	if (!pvt_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, pvt_data);
> +
> +	pvt_data->ctx = tee_client_open_context(NULL, tpm_qcom_ctx_match, NULL, NULL);
> +	if (IS_ERR(pvt_data->ctx))
> +		return -ENODEV;
> +
> +	rc = tpm_qcom_get_client_env_obj(pvt_data->ctx, &client_env_obj);
> +	if (rc) {
> +		err = -EINVAL;
> +		goto out_ctx;
> +	}
> +
> +	rc = tpm_qcom_get_svc_obj(pvt_data->ctx, client_env_obj, &tpm_svc_obj);
> +	if (rc) {
> +		err = -EINVAL;
> +		goto out_client_env;
> +	}
> +	pvt_data->tpm_svc_obj = tpm_svc_obj;
> +	pvt_data->dev = dev;
> +
> +	err = tpm_qcom_get_ta_details(pvt_data);
> +	if (err)
> +		goto out_svc_obj;
> +
> +	chip = tpm_chip_alloc(dev, &tpm_qcom_ops);
> +	if (IS_ERR(chip)) {
> +		dev_err(dev, "tpm_chip_alloc failed\n");
> +		err = PTR_ERR(chip);
> +		goto out_svc_obj;
> +	}
> +
> +	pvt_data->chip = chip;
> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
> +
> +	err = tpm_chip_register(pvt_data->chip);
> +	if (err) {
> +		dev_err(dev, "tpm_chip_register failed with rc=%d\n", err);
> +		goto out_chip;
> +	}
> +
> +	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
> +	return 0;
> +
> +out_chip:
> +	put_device(&pvt_data->chip->dev);
> +out_svc_obj:
> +	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
> +out_client_env:
> +	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
> +out_ctx:
> +	tee_client_close_context(pvt_data->ctx);
> +	return err;
> +}
> +
> +static void tpm_qcom_remove(struct tee_client_device *tee_dev)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(&tee_dev->dev);
> +
> +	tpm_chip_unregister(pvt_data->chip);
> +	put_device(&pvt_data->chip->dev);

Is there any reason you do not use tpmm_chip_alloc() and directly call put_device?

> +	tpm_qcom_release_object(pvt_data->ctx, pvt_data->tpm_svc_obj);
> +	tee_client_close_context(pvt_data->ctx);
> +}
> +
> +static const struct tee_client_device_id tpm_qcom_id_table[] = {
> +	{ tpm_qcom_uuid },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, tpm_qcom_id_table);
> +
> +static struct tee_client_driver tpm_qcom_driver = {
> +	.id_table	= tpm_qcom_id_table,
> +	.probe		= tpm_qcom_probe,
> +	.remove		= tpm_qcom_remove,
> +	.driver		= {
> +		.name	= "tpm_qcom",
> +	},
> +};
> +
> +module_tee_client_driver(tpm_qcom_driver);
> +
> +MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
> +MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_qcom.h b/drivers/char/tpm/tpm_qcom.h
> new file mode 100644
> index 000000000000..3945b12643b7
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_qcom.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __TPM_QCOM_H__
> +#define __TPM_QCOM_H__

As most of these are only consumed in qcom_tpm.c, it makes more sense to
move them and drop the header. Unless you have some reason. 

> +
> +#include <linux/bitfield.h>
> +#include <linux/tee_drv.h>
> +#include <linux/tpm.h>
> +#include <linux/uuid.h>
> +
> +#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS	5
> +#define QCOMTEE_OP_CLIENT_ENV_OPEN		0
> +#define QCOMTEE_MSG_OBJECT_OP_MASK		GENMASK(15, 0)
> +#define QCOMTEE_MSG_OBJECT_OP_RELEASE		(QCOMTEE_MSG_OBJECT_OP_MASK - 0)
> +
> +#define QCOMTEE_TPM_OP_SEND_COMMAND	0
> +
> +/* UID of the "qcom.tz.tpm" service */
> +#define QCOMTEE_TPM_UID			81
> +
> +/* Max buffer size supported by TPM TA */
> +#define MAX_COMMAND_SIZE		SZ_4K
> +#define MAX_RESPONSE_SIZE		SZ_4K

These names are confusing, rename to something like
`QCOM_TPM_MAX_COMMAND_SIZE` and `QCOM_TPM_MAX_RESPONSE_SIZE`.

> +
> +#define QCOMTEE_TPM_GET_TA_VERSION_ID	0x0001000
> +#define QCOMTEE_TPM_TA_VERSION_MAJOR	GENMASK(31, 16)
> +#define QCOMTEE_TPM_TA_VERSION_MINOR	GENMASK(15, 0)
> +
> +struct tpm_qcom_ta_version_req {
> +	u32 command_id;
> +} __packed;
> +
> +struct tpm_qcom_ta_version_rsp {
> +	u32 status;
> +	u32 command_id;
> +	u32 version_num;
> +} __packed;
> +
> +#define QCOMTEE_TPM_TYPE_ID		0x0080000
> +#define QCOMTEE_TPM_TYPE_DTPM		0x6454504dU
> +#define QCOMTEE_TPM_TYPE_FTPM		0x6654504dU
> +#define QCOMTEE_TPM_TYPE_NONE		0x4e6f6e65U
> +
> +struct tpm_qcom_type_req {
> +	u32 command_id;
> +} __packed;
> +
> +struct tpm_qcom_type_rsp {
> +	u32 command_id;
> +	u32 status;
> +	u32 tpm_type;
> +} __packed;
> +
> +/*
> + * dTPM SPI transfer optimization:
> + * TRANSFER_START before a burst of commands, TRANSFER_END once done.
> + */
> +#define QCOMTEE_TPM_TRANSFER_ID		0x0000002
> +#define QCOMTEE_TPM_TRANSFER_END	0
> +#define QCOMTEE_TPM_TRANSFER_START	1
> +
> +struct tpm_qcom_transfer_req {
> +	u32 command_id;
> +	u32 transfer_state;
> +} __packed;
> +
> +struct tpm_qcom_transfer_rsp {

nitpik: can you use `resp` instead of `rsp`?

> +	u32 command_id;
> +	u32 status;
> +} __packed;
> +
> +struct tpm_qcom_private {
> +	struct tpm_chip *chip;
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	struct tee_param_objref tpm_svc_obj;
> +	bool is_dtpm;
> +};
> +
> +#endif /* __TPM_QCOM_H__ */
> 

Best Regards,
Amir


