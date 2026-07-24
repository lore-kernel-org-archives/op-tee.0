Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA80C531FA
	for <op-tee@archiver.kernel.org>; Fri, 24 Jul 2026 10:09:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 75FA944FD4
	for <op-tee@archiver.kernel.org>; Fri, 24 Jul 2026 10:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784887765;
	bh=PYUDbi5iKuH980nqgIklV3HZdwCi3yvxZfJ2dlqAx2s=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eRnS9L/UFo05Tz90BiwY3JFSWrRqih9kK7sfU+SmoMcEsuFUhQakUKFw0vwVzkWSz
	 ku0mlaqh1jseYIpohEz2ZtlONxRrS//DDSrJFBRftfR6jzaH527ZXjCaxrRScXfcC2
	 7o+4wykb4qPWivMkmV+75TVsBSMgq2Bpd8bF8qKd8W9WnbLQMKrWwXDMDjXkXENfHh
	 ZFhOGtgxYRFIz25tjXtD5RmJn2Uwd1NNgo0we8lDh7Ro8g5Ilo2pwsIXBtP3VF0Nca
	 TkXG8U3xPzLn3vrMnsZ0CeBO1Q87HNRGnxtQc4o31RfvkxmAQEYEoZ9JqzRLF1mhoZ
	 2+uQGkF5cbePg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9639843154
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 10:09:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gpi9MLap;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GMkiaHix;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lCTd2275931
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 10:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BGtm4L/AdYtPrYwJZGfMuaDNk2hgNNxus9W9HDcWv0Q=; b=gpi9MLapSvLu6rP7
	PeYFLLIgJcWrid0/bjdsw3ko6Cq0v0KLWjj8nB2lG1Jx5+0maAHWwoAjFThGz2Pi
	k1Cgd1uWDcJ74zUJCi7WkcNKAJyiE733/eB2Pgk5fQ5DYYetFQwv8RoYpIz1OZVT
	YGVxEYRH2BEmlE2+9/V8iiHgsyG+jc4fUglb0nsVfohhnjcLpdPUKX5gGlT9F5Nx
	VmlaodOL3UbU5p3ll+6XYkKV8qJlnmGU4+Po+gYcYPyYd62UlelCBLj66U8JEsox
	GzHDE91G31BVcVb7N7GhT/N618hmP2LDSS5za6kNra5ugRVi+YxFtP7xoORZt/H5
	XgPk9g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0b84h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 10:09:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso298868a91.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 03:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784887757; x=1785492557; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BGtm4L/AdYtPrYwJZGfMuaDNk2hgNNxus9W9HDcWv0Q=;
        b=GMkiaHixsYSpfp2BJr1/dGTFTTAzcAj1LSTATnV6MX8h9ONHUIIPbTjTzEcEzgJIkc
         nKAsdxIg3FVLYp+HzVDy4QTOeseFjWMFXkHzqNs/lprVmZCQQZsbtrxxXQcQvikzsdne
         kVcLLoFZX7akuYgG+A7oz1Eagl56N2y16xzEtLnLS45D9PIX1bYNmoX6eXdrnQVRbawI
         jePedhQnUP6DbcorTcZPXzEZ9pWCUPwAcJ0bp2R7/wFro7olbPvFpOgeyKBdJpYLV5nl
         svaaQJvhb+WEWk/3uAWuJDz/cY5GqAM1nNnD8foVIKXtXIAKO2A153Axst6ylpCZv6AW
         XYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784887757; x=1785492557;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BGtm4L/AdYtPrYwJZGfMuaDNk2hgNNxus9W9HDcWv0Q=;
        b=RabIlpbZrj+Miwc1DGrv1k0iiuMpXwMdQOIm8yWewYQCPyTl3xu/t//l5tdrl6PRFQ
         5uYWqyiSKYRi6dvEdc9GcPuHG07MDVLPmJn+Cpe6hMIzhp0CLtT2lu7KkxYWlqH7CcKr
         wucyUgk/8+MZdJPwkNAnXcECQTRWG7rBj5wCl5OnFrxZzxRRjf7SceXNAv8G20mwvsI4
         7ocz0DPVGFNB96R/GvCFIr1b+ZcwQJcVnAvZXACXjvM1U0w2ADmwonl3N0uGirAyQwDw
         qlKDZjWywYm4Vg2MmZWJdsUjIbkgfCkPg68yHHykZy92C9pLxJ0msp85hL3LNC5lSYa8
         TzzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2jD8mcdhRYgrB+TF5hh76+ZK93QTKzqXAwV+NE8zhJuJo3/bWoqZd+tjBG2BAx0IaIr0S4YI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwYjXA/M2warGRjuaLeDnTu+H2JeJgmkGcMKuqoDw9wiHdiB+yU
	T8VVYcH8WWrmFAHjo65N3aJdcjNxgXw8unMHBld7Gy4u98FJxmkhQlw1mRGVhtMbT0fQ4oLD1kV
	cl1jUdPcMzXmp90UE1a2AXI4nNllMB2vm51jhv1QAEvqmnr2yTs6haf+00NS+TPitRmTK+Eke
X-Gm-Gg: AR+sD112xVFUtKda6il0OgZSh1QGrDe9MXYCRs/8cEEMZVtruCpa2vILDGl2IpbPJmF
	+uJpOn+Wnwb9ABPxCKgGrabpJIf5qUQrTskXdRpOBhybhrfRfFqHWTh9bGh1s8HxxHiLDuqEPAg
	qPHlmJOzmb/3qI5KZvtOAre7w7MZJ7BJ21hP7Vx+5VclAlsiya5M1A6E8VgBVKTJjVvjBotwfwH
	CNhnwzvwBIYpZKCGgpI52kbGLDPGaLbXI/x5UtSeuw/6X30y+CDKH/Zi/RObum59EnnZsiX5mou
	80YsiYDgLwKxOuPnIx5hVyQIhwWPeNCTdVMKAevGye8FMozXPsJ4Vzs9zmtnSWovhaa5oxmsM1k
	rIe73qo9Iwd2F2jNvx4FsQVwQO5s=
X-Received: by 2002:a17:90b:2e03:b0:38f:1f8:1fa with SMTP id 98e67ed59e1d1-38f01f802b5mr3694507a91.15.1784887757436;
        Fri, 24 Jul 2026 03:09:17 -0700 (PDT)
X-Received: by 2002:a17:90b:2e03:b0:38f:1f8:1fa with SMTP id 98e67ed59e1d1-38f01f802b5mr3694491a91.15.1784887756996;
        Fri, 24 Jul 2026 03:09:16 -0700 (PDT)
Received: from [10.92.203.75] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03c4580csm1235836a91.15.2026.07.24.03.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 03:09:16 -0700 (PDT)
Message-ID: <1049a901-4b1f-4fa9-99f1-a05f6b3af933@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 15:39:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <20260722-qcom_uefisecapp_migrate_qcomtee-v2-6-b8a8fcbe4211@oss.qualcomm.com>
 <w3oebwhvheb6scbdv2dshhr6t4sx3nwalmlw4akqf4sj3n2nmm@s7e3xtr7cuev>
 <7c7ec8eb-d809-4e1b-9467-4c9105ab00e9@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <7c7ec8eb-d809-4e1b-9467-4c9105ab00e9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XRIdf21ep5NajifwYnjK48IBCWwwSyQr
X-Proofpoint-GUID: XRIdf21ep5NajifwYnjK48IBCWwwSyQr
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a6339ce cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=w4gilCrdJcNue0UX48gA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MiBTYWx0ZWRfX7Fws/IjvgAlq
 I/l9jluqv3gBYMT2ZTr1LIqqXAfgv2ypdJQaWvhf2bjNvTsBbXGaj3zaXDYM3nRASM75z75vt6S
 QUgV6mPUOD5KBrXIByjACnUSF5S0/w4Nz2DsVIqcUYqOmQno84oiZnuqn9Y5XUsgQ0Eao6Ua5XM
 jhl1qCynOu5ngcOQpeB7sX93PjpVMz49n2Zi8JEIZyp7A48HbR6IDZkNXuMqTFahpleu20qaYu/
 qRtt7aFZTMDB1LrjnPW7cADOgMaGbR5qS6DWTBiUyJyZGzQ0ai1MNylqT6u46CKzj/P95Z9VrQG
 KMW9n5b79lGGk4/7VF39U3lQOwVFHDFYgsanrDTFmG0WNGVFwW+wYu0CBM/KukgXTAt4WNvWBT8
 XTFQy6mYFYNAdEiU9LNjFrsDMw+lD6iph4+iaVo4P4QmV+XEG3LGl/80bkGExDq9hHA608JiLKW
 kK7kEPGtQ+FsxURr+6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MiBTYWx0ZWRfX7zxGAlDlLNnd
 Yg7OGZcLQDl9zl3nRnuozg+6GW1+XL3QVnHiFGWqkDAF3aSbwBBz5zSyY+Dk37OwUL5ir/9Jh6N
 hzZRJkH9nP4ROV9wLSAJAc9J6Yr4B68=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240092
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
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9639843154
X-Spamd-Bar: ------
Message-ID-Hash: 6UCZDNHT3Y2H4OLLOZ3QK6FZMFO3ZOBT
X-Message-ID-Hash: 6UCZDNHT3Y2H4OLLOZ3QK6FZMFO3ZOBT
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6UCZDNHT3Y2H4OLLOZ3QK6FZMFO3ZOBT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>



On 24-07-2026 02:44 pm, Harshal Dev wrote:
> Hi Dmitry,
> 
> On 22-07-2026 02:07 pm, Dmitry Baryshkov wrote:
>> On Wed, Jul 22, 2026 at 12:29:17PM +0530, Harshal Dev wrote:
>>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
>>> Replay Protected Memory Block (RPMB) which is only accessible by the
>>> Qualcomm Trusted Execution Environment (QTEE).
>>>
>>> For Qualcomm platforms without emulated RPMB support, specifically
>>> platforms where RPMB is not located within SPI-NOR storage and instead
>>> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
>>> a callback request from the UEFI Trusted Application (TA) to the RPMB
>>> service running in user-space (within the QTEE supplicant).
>>>
>>> Unlike the QCOMTEE driver, the QSEECOM driver (used by the current
>>> uefisecapp client driver) does not support callback requests. And on
>>> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
>>> QSEECOM interface fail due to lack of support within QTEE.
>>> On all such platforms, a TEE based uefisecapp client driver must be used to
>>> access cached/volatile EFI variables within the uefisecapp TA and ensure
>>> persistence of writes to non-volatile EFI variables through the RPMB
>>> service hosted in the QTEE supplicant.
>>>
>>> Add support for a TEE based uefisecapp client driver which installs efivar
>>> operations after obtaining an object reference to the uefisecapp service.
>>> This enables the kernel/user-space to access/modify both volatile EFI vars
>>> stored by the Secure Application (in-memory) and non-volatile ones stored
>>> within RPMB.
>>>
>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>> ---
>>>  MAINTAINERS                                 |   7 +
>>>  drivers/firmware/qcom/Kconfig               |  24 ++
>>>  drivers/firmware/qcom/Makefile              |   1 +
>>>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 525 ++++++++++++++++++++++++++++
>>>  drivers/firmware/qcom/qcom_tee_uefisecapp.h | 120 +++++++
>>>  5 files changed, 677 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 10d12b51b1f6..e8316007370f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -22018,6 +22018,13 @@ L:	linux-arm-msm@vger.kernel.org
>>>  S:	Maintained
>>>  F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>>>  
>>> +QUALCOMM TEE UEFISECAPP DRIVER
>>> +M:	Harshal Dev <harshal.dev@oss.qualcomm.com>
>>> +L:	linux-arm-msm@vger.kernel.org
>>> +S:	Maintained
>>> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.c
>>> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.h
>>> +
>>>  QUALCOMM RMNET DRIVER
>>>  M:	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
>>>  M:	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
>>> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
>>> index b477d54b495a..20ce8b58e490 100644
>>> --- a/drivers/firmware/qcom/Kconfig
>>> +++ b/drivers/firmware/qcom/Kconfig
>>> @@ -74,4 +74,28 @@ config QCOM_QSEECOM_UEFISECAPP
>>>  	  Select Y here to provide access to EFI variables on the aforementioned
>>>  	  platforms.
>>>  
>>> +config QCOM_TEE_UEFISECAPP
>>> +	tristate "Qualcomm TEE UEFI Secure App client driver"
>>> +	depends on QCOMTEE
>>> +	depends on EFI
>>> +	depends on !QCOM_QSEECOM_UEFISECAPP
>>
>> Nope. The kernels can be built for multiple platforms. Implement a
>> runtime selection, which uefisecapp client is to be used.
>>
> 
> I agree. I reflected on this yesterday, and in hindsight it feels we do not
> really need to add a !QCOM_QSEECOM_UEFISECAPP. Both of these drivers can co-exist.
> 
> Both drivers attempt to register to the efivar interface via efivar_register(),
> but only one will ever succeed. Since both QCOM_QSEECOM_UEFISECAPP and QCOM_QSEECOM
> are built into the kernel with 'y' the default path will be QSEECOM based when
> both are supported.
> 
> I can drop this 'depends' in v3, and instead add a commit which enables this by
> default with CONFIG_QCOM_TEE_UEFISECAPP=m. Let me know your thoughts. 
>>> +	help
>>> +	  On Qualcomm SoC based platforms without emulated RPMB support,
>>
>> What is emulated RPMB support? How does a user (or a distro maintainer)
>> understand if this needs to be enabled or not?
> 
> Ack. I will try to use simpler terms here to help distro maintainers. If device has
> UFS/eMMC storage, this driver is the only way to access EFI variables within
> RPMB. So it should be set to 'm'.
> 
> If device is SPI-NOR based, this driver will still work. User can decide
> if they want to use this or continue with the old QSEECOM path.
> 
> Regards,
> Harshal
> 
>>
>>> +	  specifically platforms where RPMB is not present within SPI-NOR storage
>>> +	  and instead located on UFS/EMMC storage, non-volatile EFI variables can
>>> +	  only be set via a callback request from the UEFI Secure Application to
>>> +	  the RPMB service running in user-space (within the QTEE supplicant:
>>> +	  github.com/qualcomm/minkipc). Unlike the QCOMTEE driver, the QSEECOM
>>> +	  driver used by the QSEECOM based uefisecapp does not support callback
>>> +	  requests. And so on these platforms, the TEE based uefisecapp client
>>> +	  driver must be used to ensure persistence of non-volatile EFI variables
>>> +	  via writes through the RPMB service hosted in the QTEE supplicant.
>>> +
>>> +	  This module provides a TEE client driver for uefisecapp, installing efivar
>>> +	  operations to allow the kernel and user-space access to EFI variables.
>>> +
>>> +	  Select m here to provide access to EFI variables on the aforementioned
>>> +	  platforms if your Linux distribution has QTEE supplicant installed and
>>> +	  running.
>>> +
>>>  endmenu
>>> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
>>> index 0be40a1abc13..d780490b2865 100644
>>> --- a/drivers/firmware/qcom/Makefile
>>> +++ b/drivers/firmware/qcom/Makefile
>>> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>>>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>>>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>>>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>>> +obj-$(CONFIG_QCOM_TEE_UEFISECAPP) += qcom_tee_uefisecapp.o
>>> diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>>> new file mode 100644
>>> index 000000000000..9a5a6f145a9f
>>> --- /dev/null
>>> +++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>>> @@ -0,0 +1,525 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>> + */
>>> +
>>> +#include <linux/efi.h>
>>> +#include <linux/tee.h>
>>> +#include <linux/tee_drv.h>
>>> +#include <linux/ucs2_string.h>
>>> +#include "qcom_tee_uefisecapp.h"
>>
>> You are the only user, inline the header here.

Ack. I will expand this header and place its contents in this .c file itself.
I hope this is what you meant by 'inline'.

>>
>>> +
>>> +static struct qcomtee_uefisec_app uefisec_app;
>>
>> Do you need global data? Can it be obtained from other context variables
>> using container_of()?

Actually I really did try to do this, but unfortunately the EFI subsystem's efivars_register()
API called by this driver doesn't provide a way to store a private pointer to a struct like this one.
And so none of the callbacks registered by this driver via qcom_efivar_ops{} can provide
access to this pointer by calling container_of() later. The other EFI drivers have a similar
constraint:
https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/efi/stmm/tee_stmm_efi.c#L27
https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c#L697

Apologies for missing out on these two comments in the previous reply.

Regards,
Harshal

>>
>>
> 

