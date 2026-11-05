Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B22606A33A
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dLEJwiEA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RKlKMdzt
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6DEE94546F
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 06:58:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dLEJwiEA;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RKlKMdzt;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F3BBF44E16
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 06:57:58 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56U9lJ4169647
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 06:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5BZi0ILo+b6FWXBhB/lYgeg36DZxQl6BshKo9X8ofw0=; b=dLEJwiEAWtXiOyOW
	WATmy9HqcwvykfKTiVhT8jDirAK0eciE1JCHYN7pYr33wblers2IZGemUctShEoM
	l9zxF7rXNGqCBCZBYcQ6povrfvrx3LWQfA+PPWtNVBeYOZzl/8VHHuaAjVCBT4xl
	SFPMw1+QkzD95Hy3W7WpZCKN1aI3WYHZ45xQl3rIk6WgTWc3KHmWCzcVYIanFjWm
	3XRGN+ZvsF9aMgZ+FelzwYrS/ycpV0cjLKuvLQ8sCl0gNX9GRk66Zmy7YdmMRHA7
	FCsJoy4HS3xbcpG36SW4tM2osN5zc+J7ZVKbl715Fb1NC2P/bWwB1CGpyeO8SpP9
	mHdl4w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcd853x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 06:57:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3662e7a9299so5466247eec.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 04 Nov 2026 22:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793861877; x=1794466677; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5BZi0ILo+b6FWXBhB/lYgeg36DZxQl6BshKo9X8ofw0=;
        b=RKlKMdzt6fuOydjD7lHzkK7JCnkVup9ew/ezQi/u5ydcJAr3xYf2D95jWGOwUVvsMZ
         ujYTjkoOgm58KVw4rOxr0QtcxbKnLwcXS59g+YRq389tO8DKQhFybP6+Es8yD5w5VHnC
         E26gMX+e+3h1gcic1NBxZTB/jDCdFHRzHDUurr7HEXhh0n90JBusQTnTyRkaXqnEUiI1
         Tgf+6jfE2KNF/zpmenSvvi+JgHcP7NLlRp3yRRHXYADk9KH4TLRswPojnIZ9D7DkjdyE
         yCkvHR6AVeaAgXJB2ADl5LSAp+sEjjBxqtanuet+nNVVfdjAJv33JO9G96znRo82dVlm
         2mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793861877; x=1794466677;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5BZi0ILo+b6FWXBhB/lYgeg36DZxQl6BshKo9X8ofw0=;
        b=RKfMui2/bjqPzlyBcUpUyPl6hrtZPw3nP65J7AOGOlf283WznCzF2NZIKGSYcvGoUC
         yzqaqYbbHiqDmfwj6POj9YPr3EDpnAtTmgyu10NGG/1NS9bPBs70ztU4r9Yoij6NZxKO
         P+lbCnH3jOIZ+9qf29MA2Kf2kF2mBHloHvjDrsEAhuyT/3hfBMpxQkIEmBgmUAKoHHKp
         f7aGVj7vGm0AiSBajxGsFxFn8+lHFaQCde9NA1LSI2xb/XWrNDx/1s5Fq5lI9mh5iXVA
         SsGWETUUxnOF5LfiYXHC3sGKAKMmjsoosIx5XD3cU8e0IQXkA0o6ojluoYhNR+1OH8/V
         3taQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTcyRAHXkwfY5yRHyDP4KBT6uSfgigXIoIReoUBDF45PPjTm4wmimkiUJU78c8Om7ft9xHb1U=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9aVKU7HhHZPNAkJz94eLJZezpZWlNsPFw4a/Mq9lAPkD7GaI18
	6YhTBhh3y1AfaZZG1d+2pvM869yR3rTnrTyKG1WNj8s2MgIRr1xG4WjLU+hRntnBfuGTke0IOwZ
	SjMWaJ64mpN332YQDsRZGPDQNTJ1Wf5pPDupjJuJUPgKUkrbH/73c6eufHX8glRPF8PeAyoYw
X-Gm-Gg: AYBFou3DweUXI3Ka/g2Xl65UbWpka+PIxEIrE+MWAOGoD63FCgonHv+Rvc8MTLjjjWW
	X0L+9m8xb3wZIcbnLqkOtz9XWSF6dcajj7q8RFe+9fZ14Iv+i50KlT2gUCKVA/Xr6pRKkvLMguM
	rgslewpl/EK922BOD+E8kGAQSyQe790mgOQM9guc5C6iDFoq6eqZ0AKf54/EQxPb7hpVE1UzQe4
	xDcDZpishvNMgaPG4daSOIETvMsAW04EfS+yVMOTK9qNUwVQaN363Ws3lscMAk2kVh98zfqKs6q
	omDRMq1kDyaw9OtsIg4bJwEXBnT9GfaJ6T39a7zqomH0ik6wZh4TAJ+9TKzlyvZ6j8rBP2ZxIfq
	o3phD5tSA6ltjNuEdxgWVN1q1c18QNM7WKEMlaEFdP5nnBSc5UTQJWDVgaraW7MSeRrvFY6R6SA
	==
X-Received: by 2002:a05:7301:6199:10b0:36c:a281:1bc with SMTP id 5a478bee46e88-36ca2810b86mr7310169eec.16.1793861877004;
        Wed, 04 Nov 2026 22:57:57 -0800 (PST)
X-Received: by 2002:a05:7301:6199:10b0:36c:a281:1bc with SMTP id 5a478bee46e88-36ca2810b86mr7310130eec.16.1793861876335;
        Wed, 04 Nov 2026 22:57:56 -0800 (PST)
Received: from [10.218.26.96] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39972d4sm23912082eec.26.2026.11.04.22.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 22:57:55 -0800 (PST)
Message-ID: <114ddfe0-b593-4ba0-832d-67aba24d9b66@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 12:27:50 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-6-1460691b35d3@oss.qualcomm.com>
 <4fed24d1-72a4-4314-a6e0-89ee7546240b@oss.qualcomm.com>
 <eddd891e-c23f-4977-9f40-9a41222f5bf2@oss.qualcomm.com>
 <af92dbae-701c-480c-b7c7-7bc7bf2e6fc9@oss.qualcomm.com>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Organization: Qualcomm
In-Reply-To: <af92dbae-701c-480c-b7c7-7bc7bf2e6fc9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aec28f6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=P-IC7800AAAA:8 a=dw0t6H4-AAAA:8 a=EUspDBNiAAAA:8 a=6SEQs-14KVBVJn2B1ksA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=wVJa4CU9-Z26yuRAZDil:22
X-Proofpoint-GUID: DrG012pYZwa_l9qyXu0pS_7fRRDByd1i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAyNyBTYWx0ZWRfX0yiTAe4/iLH3
 gR20rd+ti5JE9ZXbFDLMcZt8ARE5iyn+Gpp1/FaF/pnFYZBROuf/yz36OPicErW7tZFmTDu2V9B
 SEq4AVQFALhU1hrjsmnbsDA8a1xHhJw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAyNyBTYWx0ZWRfX4uK3bHGlJJTR
 o+EClTo6c8eb2nmuMkedq3b3WKhzkQdF740bE0hgb5KFXR5OIBm20u+Q0sJZhV3ckQJKskFJKwX
 tYdCJ+9nViorkV8WKTMxdYlwf5zLliHm8JFB1RPTV38Mzw896Wt3/Xt2v7dCu/Db8mwgVTHdTpK
 q69E5XMKsUMPFkBu7zavdYIsj0i8o6DPzlN7uH0ggOcX7FKO1jrvy/ChUvIhX/9mYCBHlJu/kXs
 NOCTVFTg26z/NR+n1OQhzCTYFnGR8gGRbp+7/6gBz0SNMy10rXJGYmPbw9J+Da8ZaCrxl0hDUxi
 kgNh64xCMghziiT4lWiuEGjXXpuTBmVwFDkwv9kqDLtX59QEVGFuWLcKrxjAobYbL++VNdezNkl
 LkOV0nr2dg2PJVssgJnRCsA/U00HQ9jbPufUaexNJRpMnOPKSqyqvQ4ohmO2Dr+yJ/8jdgQ4V2g
 chvSxgxfEQ3vgg72kMA==
X-Proofpoint-ORIG-GUID: DrG012pYZwa_l9qyXu0pS_7fRRDByd1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050027
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F3BBF44E16
X-Spamd-Bar: ------
Message-ID-Hash: GKDBBQVZC2IDCJTBKPSZOTIULEQPWRXB
X-Message-ID-Hash: GKDBBQVZC2IDCJTBKPSZOTIULEQPWRXB
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GKDBBQVZC2IDCJTBKPSZOTIULEQPWRXB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Amir,

On 05-11-2026 11:24 am, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 11/3/2026 7:35 PM, Harshal Dev wrote:
>> Hi Amir,
>>
>> On 26-10-2026 10:14 am, Amirreza Zarrabi wrote:
>>> Hi Harshal,
>>>
>>> On 10/15/2026 10:39 PM, Harshal Dev wrote:
>>>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
>>>> Replay Protected Memory Block (RPMB) located within either the UFS,
>>>> eMMC or SPI-NOR storage. The RPMB key which is one-time programmed into
>>>> the storage controller to allow authentication of the RPMB frames is
>>>> generated by and only available to the Qualcomm Trusted Execution
>>>> Environment (QTEE).
>>>>
>>>> The legacy QSEECOM protocol used for communicating with the QTEE is
>>>> deprecated and replaced with the use-case agnostic SMCInvoke protocol
>>>> starting with the Qualcomm SM8x50 series. On platforms where the QSEECOM
>>>> driver still probes, it does not support a listener interface with QTEE
>>>> to enable writing of non-volatile EFI variables to the RPMB for UFS and
>>>> eMMC storage.
>>>> Therefore on such platforms, a TEE client driver which communicates with
>>>> QTEE via the SMCInvoke protocol implemented by the QCOMTEE driver (and
>>>> registered with the TEE subsystem) must be used to update such EFI
>>>> variables.
>>>>
>>>> Add support for a TEE based uefisecapp client driver which installs efivar
>>>> operations after obtaining an object reference to the uefisecapp service.
>>>> This enables the kernel/user-space to access or modify both volatile EFI
>>>> variables stored by the Secure Application (in-memory) and non-volatile
>>>> ones stored within RPMB.
>>>>
>>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>>> ---
>>>>  MAINTAINERS                                 |   6 +
>>>>  drivers/firmware/qcom/Kconfig               |  31 ++
>>>>  drivers/firmware/qcom/Makefile              |   1 +
>>>>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 644 ++++++++++++++++++++++++++++
>>>>  4 files changed, 682 insertions(+)
>>>>
>>
>> [...]
>>
>>>> diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>>>> new file mode 100644
>>>> index 000000000000..bcd025f929fc
>>>> --- /dev/null
>>>> +++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>>>> @@ -0,0 +1,644 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>> + */
>>>> +
>>>> +#include <linux/efi.h>
>>>> +#include <linux/tee.h>
>>>> +#include <linux/tee_drv.h>
>>>> +#include <linux/ucs2_string.h>
>>
>> [...]
>>
>>>> +
>>>> +static efi_status_t qcomtee_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid,
>>>> +					      u32 *attr, unsigned long *data_size,
>>>> +					      void *data)
>>>> +{
>>>> +	int ret;
>>>> +	u32 in_attr, out_attributes, out_errno;
>>>> +	struct tee_param_ubuf in_data, in_var, in_attributes;
>>>> +
>>>> +	if (!name || !guid)
>>>> +		return EFI_INVALID_PARAMETER;
>>>> +
>>>> +	/*
>>>> +	 * 'attr' can be NULL, however an input attribute is always expected
>>>> +	 * by UefiSecApp TA
>>>> +	 */
>>>
>>> You are enforceing a poliy on the arguments of a cb which is called publicly, are you
>>> sure all callers understand that this output value is optional? it is not specified
>>> anywhere as far as I can see. This seesm to be a TA thing.
>>>
>>
>> I think the way this comment is written is a bit misleading. The comment is not about
>> the output value of attr, it is about the input value passed to this callback.
>>
>> The callers of this callback either pass a NULL value for attribute or a valid value.
>> When they pass NULL, they ignore the output since it's expected to not be set by the
>> implementation: https://elixir.bootlin.com/linux/v7.3/source/fs/efivarfs/vars.c#L505
>>
>> When they pass a valid value, they expect a valid output in return and operate on it:
>> https://elixir.bootlin.com/linux/v7.3/source/fs/efivarfs/file.c#L108
>> https://elixir.bootlin.com/linux/v7.3/source/fs/efivarfs/vars.c#L531
>> So the value is not optional, it is set or not set as per the expectation of the
>> caller. 
>>  
>>>> +	in_attr = 0;
>>
>> However, the SMCInvoke transport here needs this to not be NULL, and so we force
>> set a 0 here which is interpreted corrected by the TA as attribute not set.
>>
>> I will re-phrase this comment to avoid ambiguity.
>>
> 
> I do not believe it is comment issue. I understand attr is an optional output value
> which could be NULL. However, this implementation also uses attr as input. 
> 
> In your provided link:
> https://elixir.bootlin.com/linux/v7.3/source/fs/efivarfs/file.c#L108
> attr that passed to this function is from stack and uninitialized, so the
> TA will get garbage in in_attr based on bellow code. It this acceptable?
>

Yes, this is acceptable. As per the specification the implementation of this API does
not care whether the pointer points to a valid value or garbage because the pointer
is used to populated the output and any garbage pointed by the pointer is ignored.
If the pointer is not NULL, then as per the spec an output value must be returned 
which populates the pointed memory with an attr bitmask, please see:
https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.html#getvariable

The TA implementation also aligns with this expectation. 

Theoretically, if the TA were to consume the value passed here, it should anyway
sanitize and check the input. 
> 
>>>> +	if (attr)
>>>> +		in_attr = *attr;
>>>> +
>>>> +	in_data = (struct tee_param_ubuf){ .addr = data, *data_size };
>>>> +	in_var = (struct tee_param_ubuf){ .addr = name,
>>>> +					  (ucs2_strlen(name) + 1) * sizeof(*name) };
>>>> +	in_attributes = (struct tee_param_ubuf){ .addr = &in_attr, sizeof(u32) };
>>>> +
>>>> +	/* On SUCCESS, 'data' member of 'in_data' has already been updated. */
>>>> +	ret = qcuefi_get_variable(in_var, guid, in_attributes, &in_data,
>>>> +				  &out_attributes, &out_errno);
>>>> +
>>>> +	if (ret)
>>>> +		return EFI_DEVICE_ERROR;
>>>> +
>>>> +	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT) {
>>>> +		/* If 'attr' is NULL 'out_attributes' is not updated. */
>>>> +		if (attr)
>>>> +			*attr = out_attributes;
>>>> +
>>>> +		*data_size = in_data.size;
>>>> +	}
>>>> +
>>>> +	return uefisecapp_err_to_efi_status(out_errno);
>>>> +}
>>>> +
>>
>> [...]
>>
>>>> +
>>>> +static const struct efivar_operations qcom_efivar_ops = {
>>>> +	.get_variable = qcomtee_uefi_get_variable,
>>>> +	.set_variable = qcomtee_uefi_set_variable,
>>>
>>> Not sure how much it is relevant, but I was looking into the efi and in
>>> efivar_set_variable_locked, saw this comment "If no _nonblocking variant exists,
>>> the ordinary one is assumed to be non-blocking." which in not the case fo us.
>>>
>>> Does it make sense to introduce something like
>>> qcomtee_uefi_set_variable_nonblocking and return UNSUPPORTED!?
>>>
>>
>> Ack, this ensures that if a caller expects the set_variable() to land in a
>> non-blocking call, they get returned -ENOTSUPPORTED instead of being misled.
>> As far as I can see only the x86 pstore implementation explicitly requests
>> a call into a non-blocking variant:
>> https://elixir.bootlin.com/linux/v7.3/source/drivers/firmware/efi/efi-pstore.c#L227
>>  
>>>> +	.get_next_variable = qcomtee_uefi_get_next_variable,
>>>> +	.query_variable_info = qcomtee_uefi_query_variable_info,
>>>> +};
>>>> +
>>>> +static int qcomtee_ctx_match(struct tee_ioctl_version_data *ver,
>>>> +			     const void *data)
>>>> +{
>>>> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
>>>> +}
>>>> +
>>>> +static int qcomtee_uefisecapp_probe(struct tee_client_device *tee_dev)
>>>> +{
>>>> +	int ret, err;
>>>> +	struct tee_param_objref client_env_obj;
>>>> +	struct tee_param_objref uefisec_svc_obj;
>>>> +
>>>> +	uefisec_app.dev = &tee_dev->dev;
>>>> +	/* Open context with QCOMTEE driver */
>>>> +	uefisec_app.ctx = tee_client_open_context(NULL, qcomtee_ctx_match, NULL,
>>>> +						  NULL);
>>>> +	if (IS_ERR(uefisec_app.ctx))
>>>> +		return -ENODEV;
>>>> +
>>>> +	ret = qcomtee_get_client_env_obj(uefisec_app.ctx, &client_env_obj);
>>>> +	if (ret) {
>>>> +		err = -EINVAL;
>>>> +		goto err_get_client_env;
>>>> +	}
>>>> +
>>>> +	ret = qcomtee_get_uefisec_svc_obj(uefisec_app.ctx, client_env_obj,
>>>> +					  &uefisec_svc_obj);
>>>> +	if (ret) {
>>>> +		err = -EINVAL;
>>>> +		goto err_get_uefisec_svc;
>>>> +	}
>>>> +	uefisec_app.uefisec_svc_obj = uefisec_svc_obj;
>>>> +
>>>> +	ret = efivars_register(&uefisec_app.efivars, &qcom_efivar_ops);
>>>> +	if (ret) {
>>>> +		err = ret;
>>>> +		goto err_efi_vars_reg;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * We don't need to keep a reference to this object anymore, we only
>>>> +	 * needed it to obtain the uefisec_svc object.
>>>> +	 */
>>>> +	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
>>>> +	return 0;
>>>> +
>>>> +err_efi_vars_reg:
>>>> +	qcomtee_release_object(uefisec_app.ctx, uefisec_svc_obj);
>>>> +err_get_uefisec_svc:
>>>> +	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
>>>> +err_get_client_env:
>>>> +	tee_client_close_context(uefisec_app.ctx);
>>>> +
>>>> +	return err;
>>>> +}
>>>> +
>>>> +static void qcomtee_uefisecapp_remove(struct tee_client_device *tee_dev)
>>>> +{
>>>> +	efivars_unregister(&uefisec_app.efivars);
>>>
>>> I still have concerns about the removal path. efivars_unregister() acquires the
>>> semaphore interruptibly and can return -EINTR, for example when a signal arrives while
>>> it waits for an active EFI operation. Its return value is ignored here, so removal can
>>> release the service object and close the TEE context while the EFI provider remains registered.
>>>
>>
>> This is a valid point. But it seems like no easy solution exists here. The driver core
>> doesn't check the value being returned from remove(), so it will always detach the driver from
>> the device.
>>
>> Currently when -EINTR is returned, the driver is removed but __efivar->ops remain set, so a
>> subsequent call to __efivars->ops would cause a kernel panic/crash. If we check for error here
>> and return without releasing the service object/TEE context, we still have the same issues but
>> now also a leak; QTEE's object table still has the service object and the TEE context remains
>> allocated (while the driver is removed and __efivars->ops remain set to a random pointers).
>>
>> Everyone else is also suffering the same race:
>> https://elixir.bootlin.com/linux/v7.3/source/drivers/firmware/efi/stmm/tee_stmm_efi.c#L518
>> https://elixir.bootlin.com/linux/v7.3/source/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c#L842
>> https://elixir.bootlin.com/linux/v7.3/source/drivers/firmware/google/gsmi.c#L1075
>>
>> This is a framework level issue, where a fail-safe fix is to use down() instead of down_interruptible()
>> in efivar_unregister() and pray that whoever is invoking the callback comes out soon. But at
>> least it replaces a sure-shot kernel panic with a low probability deadlock which can be
>> diagnosed.
>>
>> I thought about other ways, like using try_module_get() from either the callbacks or the
>> efivar_register/unregister(), but neither solve this.
>> I can try initiating a discussion on this separately on the efivar mailing list, unless there
>> are any other innovative suggestions for solving it from within the driver. :)
>>
>> Let me know your thoughts.
>>
>>> Separately, efivar_lock() appears to have an existing bug: it checks __efivars->ops
>>> without first checking whether __efivars is NULL. Successful unregister sets that pointer to NULL,
>>> so subsequent access through an existing efivarfs can dereference NULL.
>>> I Feel, that needs an EFI-core fix as well. what do you think?
>>>
>>
>> Ack, this is true and a fix is straightforward. I will send a patch separately if someone hasn't
>> already sent one.
>>
>> Regards,
>> Harshal
>>  
> 
> Yeah, you are right. Let's ignore it for now.
>

Ack, I will respond here with the sent fixes along with v6 of this series.

Regards,
Harshal 
> Best Regards,
> Amir
> 
>>>
>>> - Amir
>>>
> 

