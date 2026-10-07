Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CB3CA6009
	for <op-tee@archiver.kernel.org>; Wed,  7 Oct 2026 09:20:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 74FDA45498
	for <op-tee@archiver.kernel.org>; Wed,  7 Oct 2026 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791364832;
	bh=rsSHzG9MCaRsgobX/CMFnVuhdEY//HFwz+WtL2zAHcU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uIhWxrOIVDzpqdIZ8To+sq9eyQ2185NKOcTxlonD8hdbKt0h+zKP6zoKo2lFR4Od+
	 zuerbz4lICFnly9YpleR6vSQpWvlSWmgwUytNmvMp67WdTdKWoc7Tsoqma4OUUH16u
	 OtXFd/ygQK6+FDJMw+F0aHMDHtGQqne3M/ulam7/fWobd83WN8JsDIBUEpeODkK+7R
	 dsOy8N2KJ+TNgC+oCFEGNnz2syWqjfo6eRXKucwQUyiFQ9hvcyRAkdxpXM6RUtZybP
	 za42hRz3H8K2KxLgCxQ4Lteby2oGfAFY3KtDe9CAuf2TBrW645ougW1X7oXrc6MiIE
	 Ql3jScTSVjEeQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A263844E78
	for <op-tee@lists.trustedfirmware.org>; Wed,  7 Oct 2026 09:20:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FwxpWs6H;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NrYWLxcr;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jeHD3334684
	for <op-tee@lists.trustedfirmware.org>; Wed, 7 Oct 2026 09:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HmZU/tfQDHS+62aXxN/4u19VewursY3udPREkCWOYz8=; b=FwxpWs6H2tfu2+O8
	WlzuWLf6UpBeZrlOO5ZL5GHRaL9RNK7g6L27Z0L2FmyGGM7Sam7LyVUqpDIW10pc
	btX7qMR9f5zm3unrakvDK4dQKRmvxGTXdewzk7CP2tHSxle/z+aBvlJYcn7YW8DG
	rrD8Q0lqydM3PhJGiz1W8YDGURglI+e/em+RZ1WKsIdsjec/h/jx6SUBCx51ysZV
	2rezaZcWvtSYCRZnaQRx4s7cscrCkc/gYqFV+z1yrMmsxta96nNlTjuvm4heUMfx
	goAkqlOPjahlTTdMzo1kkGAO6+dK3vBetbO4hh0gaOSr0i63PZNkffpDAw0uIko9
	GZvJKw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h54623d8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 09:20:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e2e0bc619fso40906775ad.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 02:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791364823; x=1791969623; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HmZU/tfQDHS+62aXxN/4u19VewursY3udPREkCWOYz8=;
        b=NrYWLxcr9fAx2QGj2u89ulq/XfdnF5Wa8oAR0IMae1aW73039BmkzxDNztjlHQiwRT
         WxYNEYUKTN+p+KQKeiZdX+Bf2NEowO5flgMu55OswMxNkLAadOn4tVTCQkWpFCriqFBk
         ar1Sf0AH8nvv0KnlL7Z96BGAyEGCG3hAOxx0DoodKvSZGkfvEXIUn2w5yTZbIxOIiFsU
         f0ZT1U8XlOK1t8jF3+gud2UZRxIsUX0p9VrN6le917M9zRW4vHLQ5VnJgpy2K/gLAnJE
         TlF+tACC1rQcH5/AtSQW10OSrdnCOOoJHuUheKPUa7lvjVtW/YA/pgSZ4Mby3m40hrD4
         uGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791364823; x=1791969623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmZU/tfQDHS+62aXxN/4u19VewursY3udPREkCWOYz8=;
        b=L1cjOhHhjQ2pUVHHrfJGp4XX5+2xIKz5UWN54J4UiFj35GJZXn0LzKwJcC5B4RkHVX
         /v6dMwjoTd+7MZbhj4X19KrbM4oG4X8QhCpBGlgP5plfl9KCXcrlzEUuNUkFm4SQ5GkC
         /NOSz/PLzVpIw4PWUi3ABr9zPqYanvIkKU2L4ALRImtMjBoYw1lPCIXOjUTcXITSegfx
         RTrYyqvgCvd7mTIg6CpUeF/LGjpVJm/DGcyfhQCAjGjcjX9Z0mV56UkMU4EMJ0oRaMRF
         CKBNgIIwUt2sRMBeUXSIrc/QH7Sr7RlJ2paa7cPbln+1yE+iNskTfY1bng398Ob2CMfa
         pUVw==
X-Forwarded-Encrypted: i=1; AKwUvBwmCoVsz4WJLQLvY1PbJDWJE7Ijd2TmrZ26bg6FGT87ITgfZiYrZqqMOZdnEv/SHfGvfSDlU0o=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIKe6eSLtENi/nK600/X8vJPmS1NHSS38BSDQtr8ws7YVEGwMK4
	KRDdEStKc3CRJY+AvOXDWrQkak9Nc2FtNVtj8sUUQNO2MhQxIyYk3kquvFWA2G0jUmAXS2HO2nl
	lImi8279FBP1bet9obpzSoH9dwb/NswN2fcdEBMxDa7apJ0ru1lbAw4aUam7+1iF71jfbGsLP
X-Gm-Gg: AYBFou3PqmeFm2h3JIburvXIlVdVEZjtFJg4KhkHg9tJKwARQTgBbd3CWEPD6XiYp6M
	JkA+OZFmN1IjCBWBWCM4U0IMlQNGyTCMQHPM9lQu4WzNANUN32ducMPuXS0W99XwPsp1oRIg8MT
	5LScsoNe1hO86f5V0Cy9xV+/aEDOKQJ4pHG742Bl/J5cvLMKCGQlFSgJ2sHUr1fqhVS4g2yJdP3
	uH8PWj4qWgTDr+Jd/jlq5iGWbnla9yjeQ0dnq/xMWWHGEN+0rma29o4GNJyVE0a2XGXtD6JM1Lq
	7rAnnOl4NVQ0o6eVVyhUm8ZduCQYQLttodIpoNatU+oPf7ZtNV1LSkMEdhKcDSZhOs3pVobDBI8
	MmLrIAZHmIYJEfCghnO0/UuFaI9oL
X-Received: by 2002:a17:902:ef4f:b0:2e6:943:39e0 with SMTP id d9443c01a7336-2e609433caemr10524885ad.29.1791364822370;
        Wed, 07 Oct 2026 02:20:22 -0700 (PDT)
X-Received: by 2002:a17:902:ef4f:b0:2e6:943:39e0 with SMTP id d9443c01a7336-2e609433caemr10524575ad.29.1791364821658;
        Wed, 07 Oct 2026 02:20:21 -0700 (PDT)
Received: from [10.92.161.47] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482d316sm7159435ad.49.2026.10.07.02.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 02:20:21 -0700 (PDT)
Message-ID: <d33c6321-9d4d-456a-b349-4f46840a0343@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 14:50:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tpm: Introduce Qualcomm TPM driver
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-2-71a6b1752da8@oss.qualcomm.com>
 <6e2034eb-0192-4286-beb2-ba7f1186344c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6e2034eb-0192-4286-beb2-ba7f1186344c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KwtMNIcLksK-DZ0VEjtYPQ2wxOzYSvS6
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac60ed7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=sBliAY4Pf1TY-0blGb4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNyBTYWx0ZWRfXylNM4O6RXr/m
 6NFtZYpxg1jXNTclORbaQABCqp2mFoS+gSV4shepyJx5mUBxr8HMiUFDk72aFTMo247RjeyXK7C
 Aj0RZR7/t8xQiy/t4R0Zzx9zqxxoqzY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNyBTYWx0ZWRfX1YFObTiBRa9M
 vx+IgwbOKYFURiPTE1Z7hzaAyFM/jy9VF3uWJKruxJpaVOBsOmBeOr1iWb+qleoDY+smJOvadUj
 PlzcVryOb0Lqo2HZsR1BJN2Pr8sSOrj3d/vHauB/JLKNbyQFjYyKogPacbemvGIBWb/aXKSaFQs
 c9L5eqp3mUCBDNj96slfQbCS3rISXRgAUc7fZQ5paY/+w7q+eLRqlVkodwgCAorEWzHsJEOeNPk
 3lI+tByo1Z3SWjVzrt6iuFUMyBi/dOXuNwC+EWKMCj9cgYgbEuD9cIkhYi19BjCl87BMTw2SLQi
 b99LrOEdNpvGs2zogeDGQjOd8MQehGN8RZFqwtf3ejxL+6ODwDEsAN5npIZ7GFvMdRIpR+TMsWA
 AP8/qcLHRbTABkYGA6OmSzZb/icFLd1PDZZODV9YiSz+KXErpGoWNDMfbPBcZs3koV47oOu455u
 9K1dbF0fEoCLuDpYCfg==
X-Proofpoint-ORIG-GUID: KwtMNIcLksK-DZ0VEjtYPQ2wxOzYSvS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070037
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.214.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A263844E78
X-Spamd-Bar: ------
Message-ID-Hash: 57PHPHAMKRZ54V2H5UTPJZ67KEDRL5YC
X-Message-ID-Hash: 57PHPHAMKRZ54V2H5UTPJZ67KEDRL5YC
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/57PHPHAMKRZ54V2H5UTPJZ67KEDRL5YC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 29-09-2026 04:59, Amirreza Zarrabi wrote:
> Hi Kuldeep,
> 
> Sorry for late review.
> 
> On 9/7/2026 7:28 PM, Kuldeep Singh wrote:
>> Add a TPM chip driver for platforms where a TPM 2.0 instance is
>> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
>> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
>> transport.
>>
>> The driver discovers the qcom.tz.tpm TEE-bus device, opens a session
>> with the TPM TA, and register with tpm interface. This exposes the TA
>> through the standard /dev/tpm interface and the existing tpm2 command
>> layer. OS need not be aware underlying TPM instance is dTPM or fTPM.
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> ---
>>  drivers/char/tpm/Kconfig    |   9 ++
>>  drivers/char/tpm/Makefile   |   1 +
>>  drivers/char/tpm/tpm_qcom.c | 354 ++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/char/tpm/tpm_qcom.h |  83 +++++++++++
>>  4 files changed, 447 insertions(+)
>>
>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index 5f672f2c01b0..05d704ed3632 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -243,6 +243,15 @@ config TCG_FTPM_TEE
>>  	help
>>  	  This driver proxies for firmware TPM running in TEE.
>>  
>> +config TCG_QCOM
>> +	tristate "Qualcomm TEE based TPM Interface"
>> +	depends on QCOMTEE
>> +	help
>> +	  This driver provides interface to run TPM instances with Trustzone
>> +	  having Qualcomm TPM TA running in Qualcomm TEE.
>> +	  The mechanism uses the object-IPC based transport provided by
>> +	  QCOMTEE.
>> +
>>  config TCG_SVSM
>>  	tristate "SNP SVSM vTPM interface"
>>  	depends on AMD_MEM_ENCRYPT
>> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>> index 5b5cdc0d32e4..471cbf49afd2 100644
>> --- a/drivers/char/tpm/Makefile
>> +++ b/drivers/char/tpm/Makefile
>> @@ -45,5 +45,6 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>>  obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
>> +obj-$(CONFIG_TCG_QCOM) += tpm_qcom.o
>>  obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>>  obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
>> diff --git a/drivers/char/tpm/tpm_qcom.c b/drivers/char/tpm/tpm_qcom.c
>> new file mode 100644
>> index 000000000000..ef29c66f18ae
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_qcom.c
>> @@ -0,0 +1,354 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + */
>> +
>> +#include <linux/mm.h>
>> +#include <linux/slab.h>
>> +#include <linux/tee.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/tpm.h>
>> +#include <linux/uuid.h>
>> +
>> +#include "tpm.h"
>> +#include "tpm_qcom.h"
>> +
>> +/* UUID of the QTEE-bus device representing the TPM TA. */
>> +static const uuid_t tpm_qcom_uuid =
>> +	UUID_INIT(0xaabcb593, 0x7083, 0x5536,
>> +		  0xac, 0x27, 0x3d, 0x2d, 0x89, 0x41, 0x9d, 0xdb);
>> +
>> +static void tpm_qcom_release_object(struct tee_context *ctx,
>> +				    struct tee_param_objref object)
>> +{
>> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
>> +
>> +	inv_arg.id = object.id;
>> +	inv_arg.op = QCOMTEE_MSG_OBJECT_OP_RELEASE;
>> +	inv_arg.num_params = 0;
>> +
>> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
>> +}
>> +
>> +static int tpm_qcom_get_client_env_obj(struct tee_context *ctx,
>> +				       struct tee_param_objref *client_env_obj)
>> +{
>> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
>> +	struct tee_param param[2] = {};
>> +	int ret;
>> +
>> +	inv_arg.id = TEE_OBJREF_NULL;
>> +	inv_arg.op = QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS;
>> +	inv_arg.num_params = 2;
>> +
>> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT;
>> +	param[0].u.objref.id = TEE_OBJREF_NULL;
>> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
>> +
>> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0)
>> +		return ret ?: inv_arg.ret;
> 
> These two functions are local. Do we really care about the return value?
> No caller seems to check it. Why not return `TEE_OBJREF_NULL` on failure instead?

Ok, I think we can return common error but still need some error log
which will point to exact failure. Maybe I'll add log to print
ret/inv_arg.ret and return TEE_OBJREF_NULL directly. Sounds good?
> 
>> +
>> +	*client_env_obj = param[1].u.objref;
>> +	return ret;
>> +}
>> +
>> +static int tpm_qcom_get_svc_obj(struct tee_context *ctx,
>> +				struct tee_param_objref client_env_obj,
>> +				struct tee_param_objref *tpm_svc_obj)
>> +{
>> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
>> +	struct tee_param param[2] = {};
>> +	u32 tpm_uid = QCOMTEE_TPM_UID;
>> +	int ret;
>> +
>> +	inv_arg.id = client_env_obj.id;
>> +	inv_arg.op = QCOMTEE_OP_CLIENT_ENV_OPEN;
>> +	inv_arg.num_params = 2;
>> +
>> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
>> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &tpm_uid,
>> +						    .size = sizeof(tpm_uid) };
>> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
>> +
>> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0)
>> +		return ret ?: inv_arg.ret;
>> +
>> +	*tpm_svc_obj = param[1].u.objref;
>> +	return ret;
>> +}
>> +
>> +static int tpm_qcom_send_command(struct tpm_qcom_private *pvt_data,
>> +				 u32 locality, void *req, size_t req_len,
>> +				 void *rsp, size_t *rsp_len)
> 
> This function seems to return both negative and positive values,
> with different translations. This can cause issues; see the bug in tpm_qcom_send().
> Maybe this should be documented?

I think we can improve like below:
	1. Returning -ve ret value directly.
	2. IF ret==0 and inv_arg.ret contains failure, print both values and
return common value i.e -EINVAL to the callers.
This will guarantee error is propagated correctly either from qcomtee/TA
or QTEE.

>> +{
>> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
>> +	struct tee_param param[3] = {};
>> +	u8 locality_arg = locality;
> 
> What is the `locality` arg if it is always zero? planning for future?
> Why not `u8 locality_arg = 0`?

Locality arg is an input to idl and it's 0 for calls here.
We can update directly in send_command and no need for caller input here.
> 
>> +	int ret;
>> +
>> +	inv_arg.id = pvt_data->tpm_svc_obj.id;
>> +	inv_arg.op = QCOMTEE_TPM_OP_SEND_COMMAND;
>> +	inv_arg.num_params = 3;
>> +
>> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
>> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &locality_arg,
>> +						   .size = sizeof(locality_arg) };
>> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
>> +	param[1].u.ubuf = (struct tee_param_ubuf){ .addr = req, .size = req_len };
>> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT;
>> +	param[2].u.ubuf = (struct tee_param_ubuf){ .addr = rsp, .size = *rsp_len };
>> +
>> +	ret = tee_client_object_invoke_func(pvt_data->ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(pvt_data->dev,
>> +			"send_command invoke ret: %d, err: 0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return ret ?: inv_arg.ret;
>> +	}

We can have cmd parameter here and this way we can avoid prints in
callers of tpm_qcom_send_command.
>> +
>> +	*rsp_len = param[2].u.ubuf.size;
>> +
>> +	return ret;
>> +}
>> +
>> +static int tpm_qcom_get_ta_details(struct tpm_qcom_private *pvt_data)
>> +{
>> +	struct tpm_qcom_ta_version_req ver_req = {
>> +		.command_id = QCOMTEE_TPM_GET_TA_VERSION_ID,
>> +	};
>> +	struct tpm_qcom_ta_version_rsp ver_rsp;
>> +	size_t ver_rsp_len = sizeof(ver_rsp);
>> +	struct tpm_qcom_type_req type_req = {
>> +		.command_id = QCOMTEE_TPM_TYPE_ID,
>> +	};
>> +	struct tpm_qcom_type_rsp type_rsp;
>> +	size_t type_rsp_len = sizeof(type_rsp);
>> +	int ret;
>> +
>> +	ret = tpm_qcom_send_command(pvt_data, 0, &ver_req, sizeof(ver_req),
>> +				    &ver_rsp, &ver_rsp_len);
>> +	if (ret || ver_rsp_len < sizeof(ver_rsp) || ver_rsp.status != 0) {
>> +		dev_err(pvt_data->dev,
>> +			"failed to query TA version: ret=%d, status=%u\n",
>> +			ret, ret ? 0 : ver_rsp.status);
>> +		return ret ?: -EIO;
>> +	}
> 
> You already print in tpm_qcom_send_command(), why here again.
Yeah, we can skip printing here.

> 
>> +
>> +	dev_info(pvt_data->dev, "TPM TA version %lu.%lu\n",
>> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MAJOR, ver_rsp.version_num),
>> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MINOR, ver_rsp.version_num));
>> +
>> +	ret = tpm_qcom_send_command(pvt_data, 0, &type_req, sizeof(type_req),
>> +				    &type_rsp, &type_rsp_len);
>> +	if (ret || type_rsp_len < sizeof(type_rsp) || type_rsp.status != 0) {
>> +		dev_err(pvt_data->dev,
>> +			"failed to query TPM type: ret=%d, status=%u\n",
>> +			ret, ret ? 0 : type_rsp.status);
>> +		return ret ?: -EIO;
>> +	}
> 
> You already print in tpm_qcom_send_command(), why here again.

Yeah, we can skip printing here.

> 
>> +
>> +	switch (type_rsp.tpm_type) {
>> +	case QCOMTEE_TPM_TYPE_FTPM:
>> +		dev_info(pvt_data->dev, "TPM type: fTPM\n");
>> +		pvt_data->is_dtpm = false;
>> +		break;
>> +	case QCOMTEE_TPM_TYPE_DTPM:
>> +		dev_info(pvt_data->dev, "TPM type: dTPM\n");
>> +		pvt_data->is_dtpm = true;
>> +		break;
>> +	default:
>> +		dev_err(pvt_data->dev, "unsupported TPM type: 0x%08x\n",
>> +			type_rsp.tpm_type);
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* fTPM does not implement this command and to be invoked via dtpm only. */
>> +static void tpm_qcom_transfer(struct tpm_qcom_private *pvt_data,
>> +			      u32 transfer_state)
>> +{
>> +	struct tpm_qcom_transfer_req req = {
>> +		.command_id = QCOMTEE_TPM_TRANSFER_ID,
>> +		.transfer_state = transfer_state,
>> +	};
>> +	struct tpm_qcom_transfer_rsp rsp;
>> +	size_t rsp_len = sizeof(rsp);
>> +	int ret;
>> +
>> +	ret = tpm_qcom_send_command(pvt_data, 0, &req, sizeof(req), &rsp,
>> +				    &rsp_len);
>> +	if (ret || rsp_len < sizeof(rsp) || rsp.status != 0)
>> +		dev_warn(pvt_data->dev,
>> +			 "transfer state=%u hint failed: ret=%d, status=%u\n",
>> +			 transfer_state, ret, ret ? 0 : rsp.status);
> 
> You already print in tpm_qcom_send_command(), why here again.
> If you remove the message, I also argue the function is not required.
> Directly call tpm_qcom_send_command() bellow.

Seems we can save merge this chunk into tpm_qcom_cmd_ready only.
Let me do it.

> 
>> +}
>> +
>> +static int tpm_qcom_cmd_ready(struct tpm_chip *chip)
>> +{
>> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +
>> +	if (pvt_data->is_dtpm)
>> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_START);
> 
> Is it intentional to ignore failures here and in the next function, and always return success?
> Are these functions best-effort, such that failures are considered irrelevant?

Yes, this is a mechanism to notify TA about making an optimization like
acquiring dtpm spi bus and keeping spi/gpio resources active for
upcoming raw tpm command.
This indeed help for long running commands by keeping spi connections
active and releasing once TRANSFER_END is called.

If we don't make this call, it won't impact the functionality but some
performance penalty will be there.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int tpm_qcom_go_idle(struct tpm_chip *chip)
>> +{
>> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +
>> +	if (pvt_data->is_dtpm)
>> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_END);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * The raw TPM2 command in @buf is sent directly as send_command's UBUF-in
>> + * param and the raw TPM2 response is read back from its UBUF-out param.
>> + */
>> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>> +			 size_t cmd_len)
>> +{
>> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +	size_t rsp_len = PAGE_ALIGN(MAX_RESPONSE_SIZE);
>> +	size_t copy_len;
>> +	int ret;
>> +
>> +	if (cmd_len > MAX_COMMAND_SIZE) {
>> +		dev_err(&chip->dev, "len=%zd exceeds MAX_COMMAND_SIZE\n", cmd_len);
>> +		return -EIO;
>> +	}
>> +
>> +	u8 *response __free(kfree) = kzalloc(rsp_len, GFP_KERNEL);
>> +	if (!response)
>> +		return -ENOMEM;
>> +
>> +	ret = tpm_qcom_send_command(pvt_data, 0, buf, cmd_len, response,
>> +				    &rsp_len);
>> +	if (ret < 0) {
> 
> This does not seem right; tpm_qcom_send_command() can return positive on failure.
> How about tpm_qcom_ops.send?

Mentioned below, we can update return value to propagate errors
correctly to userspace layer or the callers.
> 
>> +		dev_err(&chip->dev, "send_command failed: ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	copy_len = min_t(size_t, bufsiz, rsp_len);
>> +	memcpy(buf, response, copy_len);
>> +
>> +	return copy_len;
>> +}
>> +
>> +static const struct tpm_class_ops tpm_qcom_ops = {
>> +	.flags = TPM_OPS_AUTO_STARTUP,
>> +	.send = tpm_qcom_send,
>> +	.cmd_ready = tpm_qcom_cmd_ready,
>> +	.go_idle = tpm_qcom_go_idle,
>> +};
>> +
>> +static int tpm_qcom_ctx_match(struct tee_ioctl_version_data *ver,
>> +			      const void *data)
>> +{
>> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
>> +}
>> +
>> +static int tpm_qcom_probe(struct tee_client_device *tee_dev)
>> +{
>> +	struct device *dev = &tee_dev->dev;
>> +	struct tpm_qcom_private *pvt_data;
>> +	struct tee_param_objref client_env_obj;
>> +	struct tee_param_objref tpm_svc_obj;
>> +	struct tpm_chip *chip;
>> +	int rc, err;
>> +
>> +	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
>> +	if (!pvt_data)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(dev, pvt_data);
>> +
>> +	pvt_data->ctx = tee_client_open_context(NULL, tpm_qcom_ctx_match, NULL, NULL);
>> +	if (IS_ERR(pvt_data->ctx))
>> +		return -ENODEV;
>> +
>> +	rc = tpm_qcom_get_client_env_obj(pvt_data->ctx, &client_env_obj);
>> +	if (rc) {
>> +		err = -EINVAL;
>> +		goto out_ctx;
>> +	}
>> +
>> +	rc = tpm_qcom_get_svc_obj(pvt_data->ctx, client_env_obj, &tpm_svc_obj);
>> +	if (rc) {
>> +		err = -EINVAL;
>> +		goto out_client_env;
>> +	}
>> +	pvt_data->tpm_svc_obj = tpm_svc_obj;
>> +	pvt_data->dev = dev;
>> +
>> +	err = tpm_qcom_get_ta_details(pvt_data);
>> +	if (err)
>> +		goto out_svc_obj;
>> +
>> +	chip = tpm_chip_alloc(dev, &tpm_qcom_ops);
>> +	if (IS_ERR(chip)) {
>> +		dev_err(dev, "tpm_chip_alloc failed\n");
>> +		err = PTR_ERR(chip);
>> +		goto out_svc_obj;
>> +	}
>> +
>> +	pvt_data->chip = chip;
>> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
>> +
>> +	err = tpm_chip_register(pvt_data->chip);
>> +	if (err) {
>> +		dev_err(dev, "tpm_chip_register failed with rc=%d\n", err);
>> +		goto out_chip;
>> +	}
>> +
>> +	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
>> +	return 0;
>> +
>> +out_chip:
>> +	put_device(&pvt_data->chip->dev);
>> +out_svc_obj:
>> +	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
>> +out_client_env:
>> +	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
>> +out_ctx:
>> +	tee_client_close_context(pvt_data->ctx);
>> +	return err;
>> +}
>> +
>> +static void tpm_qcom_remove(struct tee_client_device *tee_dev)
>> +{
>> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(&tee_dev->dev);
>> +
>> +	tpm_chip_unregister(pvt_data->chip);
>> +	put_device(&pvt_data->chip->dev);
> 
> Is there any reason you do not use tpmm_chip_alloc() and directly call put_device?

I explored and seems tpmm_chip_alloc is devm managed so put_device can
be skipped but tpm_chip_unregister will still need to be called.

> 
>> +	tpm_qcom_release_object(pvt_data->ctx, pvt_data->tpm_svc_obj);
>> +	tee_client_close_context(pvt_data->ctx);
>> +}
>> +
>> +static const struct tee_client_device_id tpm_qcom_id_table[] = {
>> +	{ tpm_qcom_uuid },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(tee, tpm_qcom_id_table);
>> +
>> +static struct tee_client_driver tpm_qcom_driver = {
>> +	.id_table	= tpm_qcom_id_table,
>> +	.probe		= tpm_qcom_probe,
>> +	.remove		= tpm_qcom_remove,
>> +	.driver		= {
>> +		.name	= "tpm_qcom",
>> +	},
>> +};
>> +
>> +module_tee_client_driver(tpm_qcom_driver);
>> +
>> +MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
>> +MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/char/tpm/tpm_qcom.h b/drivers/char/tpm/tpm_qcom.h
>> new file mode 100644
>> index 000000000000..3945b12643b7
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_qcom.h
>> @@ -0,0 +1,83 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __TPM_QCOM_H__
>> +#define __TPM_QCOM_H__
> 
> As most of these are only consumed in qcom_tpm.c, it makes more sense to
> move them and drop the header. Unless you have some reason.

Yeah makes sense.
We can have it in tpm_qcom.c only.
> 
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/tpm.h>
>> +#include <linux/uuid.h>
>> +
>> +#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS	5
>> +#define QCOMTEE_OP_CLIENT_ENV_OPEN		0
>> +#define QCOMTEE_MSG_OBJECT_OP_MASK		GENMASK(15, 0)
>> +#define QCOMTEE_MSG_OBJECT_OP_RELEASE		(QCOMTEE_MSG_OBJECT_OP_MASK - 0)
>> +
>> +#define QCOMTEE_TPM_OP_SEND_COMMAND	0
>> +
>> +/* UID of the "qcom.tz.tpm" service */
>> +#define QCOMTEE_TPM_UID			81
>> +
>> +/* Max buffer size supported by TPM TA */
>> +#define MAX_COMMAND_SIZE		SZ_4K
>> +#define MAX_RESPONSE_SIZE		SZ_4K
> 
> These names are confusing, rename to something like
> `QCOM_TPM_MAX_COMMAND_SIZE` and `QCOM_TPM_MAX_RESPONSE_SIZE`.

Sure.
> 
>> +
>> +#define QCOMTEE_TPM_GET_TA_VERSION_ID	0x0001000
>> +#define QCOMTEE_TPM_TA_VERSION_MAJOR	GENMASK(31, 16)
>> +#define QCOMTEE_TPM_TA_VERSION_MINOR	GENMASK(15, 0)
>> +
>> +struct tpm_qcom_ta_version_req {
>> +	u32 command_id;
>> +} __packed;
>> +
>> +struct tpm_qcom_ta_version_rsp {
>> +	u32 status;
>> +	u32 command_id;
>> +	u32 version_num;
>> +} __packed;
>> +
>> +#define QCOMTEE_TPM_TYPE_ID		0x0080000
>> +#define QCOMTEE_TPM_TYPE_DTPM		0x6454504dU
>> +#define QCOMTEE_TPM_TYPE_FTPM		0x6654504dU
>> +#define QCOMTEE_TPM_TYPE_NONE		0x4e6f6e65U
>> +
>> +struct tpm_qcom_type_req {
>> +	u32 command_id;
>> +} __packed;
>> +
>> +struct tpm_qcom_type_rsp {
>> +	u32 command_id;
>> +	u32 status;
>> +	u32 tpm_type;
>> +} __packed;
>> +
>> +/*
>> + * dTPM SPI transfer optimization:
>> + * TRANSFER_START before a burst of commands, TRANSFER_END once done.
>> + */
>> +#define QCOMTEE_TPM_TRANSFER_ID		0x0000002
>> +#define QCOMTEE_TPM_TRANSFER_END	0
>> +#define QCOMTEE_TPM_TRANSFER_START	1
>> +
>> +struct tpm_qcom_transfer_req {
>> +	u32 command_id;
>> +	u32 transfer_state;
>> +} __packed;
>> +
>> +struct tpm_qcom_transfer_rsp {
> 
> nitpik: can you use `resp` instead of `rsp`?

Umm, okay.

> 
>> +	u32 command_id;
>> +	u32 status;
>> +} __packed;
>> +
>> +struct tpm_qcom_private {
>> +	struct tpm_chip *chip;
>> +	struct device *dev;
>> +	struct tee_context *ctx;
>> +	struct tee_param_objref tpm_svc_obj;
>> +	bool is_dtpm;
>> +};
>> +
>> +#endif /* __TPM_QCOM_H__ */
>>
> 
> Best Regards,
> Amir

-- 
Regards
Kuldeep

