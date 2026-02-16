Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7738BE7BDAA
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 12:08:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C101E43862
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1771243729;
	bh=euoa0gLDnWI0VoNYowyLCRHx+WMPWsF+dGMS3EE15JA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=SQVU1v82Emw6EQAvti/u//HDcqVWYPzyHeVYaRxi+b8GoDnUHPkL5f+mjODnFpKbO
	 wLe6dsR6mEdRhfoh4bQXeLybKyDeywt1bPmevZcBs+OQOmGvVdnamtS/aBUpbK63p5
	 A55Ugd9Acv6BeyS14RIgAk5qGCu69sQ2qvjnoojYLDZoDk8nU5cRlCZzDPUmxpPl8X
	 NQCuFbt4H+VDo3NnoLsXze3JiNxsScOhnijc2vAYF/yK7C9GdEi7ziHMML6WogCt1F
	 mKODzVFsO+1UehfDgq+Idxqtd3Mo+QyDiQ/RyGxN8PqgZ2Ln+zAKRHYvVUNJByGYdv
	 RqaVaWih33w3Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9D3AC4373D
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 12:08:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WcH5T7Zh;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KUI1I4+H;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GBHhXW3474374
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 12:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h1GocAahT5JsGMvnHw49bX1S/TpbPEB2y5Rax7Pi0OQ=; b=WcH5T7ZhdXQnwe2y
	TOPVn6cEZQ+Giw57M42K3J+0/v7mRLP58KNT9AZWK5c172myHjjNbj7T3q9LclX/
	wRSJ0OfA7yX8SS55rpGMfC+VW5p5Cx5QZyyo02qW4yWx9cwBkvysPaHp/zcEFNaw
	+1vNGfuUfCMBGGYuS2umjPOnE6hKGw0iUync1aePfcG5KBpcTg9yD4CquE7kRj3e
	o4cByDvHm9lSbMY5ivDUbbl1Oc2mtByo8crUtutkYhjmt3kT7w4qZe5hgFKcT37L
	bUgegdDor6qy2d0fdp2sGLFf1/romM35PAu0rie5LqOtnGJd9xAi3lrV9M0uHy0S
	tyWHDQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cah4smf77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 12:08:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a784b2234dso171934605ad.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 04:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771243709; x=1771848509; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1GocAahT5JsGMvnHw49bX1S/TpbPEB2y5Rax7Pi0OQ=;
        b=KUI1I4+HW+v9FpbsbRdrh6czBbaZlBDq1wYCfd59EzPtOQZcDtM1CFr6AL9tmP9upr
         3m+/clgVblbAG9HX+ZrDzkfDQb5sAxLEmyMnIpuuv7ikFARYaBEBueyAMaBSsyYfV78x
         g4NfvvqM2AZQ7HkXvUSbgH7sUL5i2wBBPmMAe0PMgSw2PnSs6bpV09LLJpOyQIdBLspa
         XfA+z8Cq2+h7wGSspmJClD2rOn58avsKbkHmbNKuqdh0r60g91tFF/1dAXHVrxRxqc6r
         oUW77yCuJ0y7PDKSSmFc/GT8P6XfQFOkTB1Lb3sFtmSQWGc8XJkdBohhdyKJCajPINFp
         QVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771243709; x=1771848509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1GocAahT5JsGMvnHw49bX1S/TpbPEB2y5Rax7Pi0OQ=;
        b=n7gLFlzCG/mbQOogUAXXbF7/oXgzu74+a4GzraVBNeVfyw9mS9vD0Vf4zajHsl4dma
         Yu8M1GRAzf9yi4uyzF/4bqtROhpJxUPxeJ1fKvxESlBzY9m+d6Ql9ONHEZz5ZO5jn7KV
         tQvS6qboMU6jFTrs5WvG9Jxc2h+jKldNWH+A4Llnd5b5fiW/htOc6cbXWT8Qpl8xVKU5
         6RUJS10fTChOTL2gIfXg+LYvvFNhpJISwNdJn3TkZqknDpCQGaXjDq3QE5KHCMyZsjKI
         1IWoS9ZDXTpu28egZvyldjAPe1M4eLR4vFXTaC3hJ/6Y1bhOHC6EtX9u7hHY2rPYSfUm
         1KFw==
X-Forwarded-Encrypted: i=1; AJvYcCXCZOKAbXqh/ajxyvYXK23ItJgOmfWhVNc8BdaZ+hKH2CjEodR05qANR32sSRqGGe7BRnfKOMU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy5ZVSMrjwbQhFeBBMKsGZBvqu5kbcoNWzeoRfxMTmjX2Z7j/HZ
	w1wryHoJZ78+7kmeo0MR4SIX4tyRKx1Eh6svPB6VW8gxuWWYd/mXKqwX41EBWKSuZkUly17nefF
	a+yGbk9dDOQGoO1XNSenqniM5k/zDaIyucHbh2KfQoCwnKMKZNRgIxCA8qwW2N82Z0Z8eEXn2
X-Gm-Gg: AZuq6aI2wfy8ZSbkvRJEmrb+E4zfURROZz3dck+Xy0kIG8BMcj5vU26oGA5X/37V442
	cqknQ7Me2EToYSTuC3VKKeZnZSgwiFpaOYpXv+HjtUQ+2p+Mpfs8qOPWzzdQJ1N65nJb3eu/4RS
	XJVQqmBOpuWoaGEQaP8VqIyeDj/dGYbLtMK3GJVlSkTCqYuqDsqh9rsKvL0bjPq/CO2pg0Yqrz4
	x8NqodGh/Vue7VCUpi056DGnRBqqv/RKZ+1tKZEV2gGjxfRXGQYyqkxOh9xSjaIvLu6Nk72swpG
	OPAlmTZsgNIfsGhaDtfDV8lb7irTryCsf802ItZ10T2OJ7vRsC7afEaRtvOXxHeZmngiy+/F/hs
	JDqsZZqCbJelZOI7So5LgK+kVoIFarU6qo96rNCus5j7vii6Anpw=
X-Received: by 2002:a17:903:41d1:b0:2aa:f0d6:bf59 with SMTP id d9443c01a7336-2ab50598d15mr109344945ad.35.1771243709169;
        Mon, 16 Feb 2026 04:08:29 -0800 (PST)
X-Received: by 2002:a17:903:41d1:b0:2aa:f0d6:bf59 with SMTP id d9443c01a7336-2ab50598d15mr109344645ad.35.1771243708735;
        Mon, 16 Feb 2026 04:08:28 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa34bsm64774895ad.19.2026.02.16.04.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 04:08:28 -0800 (PST)
Message-ID: <98eab1bd-9177-4c92-8fdc-1ff35d020c79@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 17:38:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for
 QTEE-enabled Qualcomm SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
 <b7985f86-1df7-439c-8c54-abcf693180d0@oss.qualcomm.com>
 <f8a0e9ab-2d11-4ac9-aa5a-f216b348f81f@kernel.org>
 <91ccacf3-68cf-4bfe-879a-db515a6732ec@oss.qualcomm.com>
 <804c0c03-d461-4fd9-ad0f-be123b3f1798@oss.qualcomm.com>
 <7d4006b0-8fcc-4e31-abfc-98ca8bf3bc2f@kernel.org>
Content-Language: en-US
In-Reply-To: <7d4006b0-8fcc-4e31-abfc-98ca8bf3bc2f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEwMSBTYWx0ZWRfX051sMlYxdzli
 d1/Dmfg/qXAz3GQeTfoSSoY19gvzTPhC1EYY1vCkxAISKtPM0vEN/jgCZNhSeDKM1bQjItmDLKw
 2jihnOTcvl0pvaDtqoLn0LENnhCVfxPNH43FLuu+5q2gYIJcOiT7wsT7/FWsRaLlW/DS3s9VOn4
 sZvkHSTS4UB7aoDNg12PTGaKlJXV1D8JytR1Jqyw4JAkqdHaXKV+aK5K21Qe2SfMbbt8nMZ7uPe
 O3hPaSd/iSh8oUUyhTkUNkmXlFYEdVV9kdUKEFn9VYVvR9rhz0U2hjTmcYSTYbTTn3RgZgvH/Q+
 xCTwcgb3nn9ZrICdtennfe6bTU7zyqYc9zlsw1oBD/TEdFdYZRDNc4zAPp2KHsffWCSzN/6YYiu
 wUyncJ8Gj3JG3jPRYJeID0a2fERChPzacKS3kxaMV7iq8Nn+iYcWJHPyijH62djIB6pAmG69zto
 A4cA6iyu0GfWf3+uVsg==
X-Proofpoint-GUID: qRV6s7qP1IMg2gvZWOkjCmASDGFV5mYV
X-Proofpoint-ORIG-GUID: qRV6s7qP1IMg2gvZWOkjCmASDGFV5mYV
X-Authority-Analysis: v=2.4 cv=EbXFgfmC c=1 sm=1 tr=0 ts=699308be cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=2EOIg3pBiIC1XDWYfRIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.199:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9D3AC4373D
X-Spamd-Bar: ----
Message-ID-Hash: UUSQ2OCZ2DJQ4XHZOKKSLHAFT7FYXCKE
X-Message-ID-Hash: UUSQ2OCZ2DJQ4XHZOKKSLHAFT7FYXCKE
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UUSQ2OCZ2DJQ4XHZOKKSLHAFT7FYXCKE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>



On 2/16/2026 4:09 PM, Krzysztof Kozlowski wrote:
> On 16/02/2026 11:36, Harshal Dev wrote:
>>
>>
>> On 2/16/2026 10:48 AM, Kuldeep Singh wrote:
>>>
>>>
>>> On 2/13/2026 3:56 PM, Krzysztof Kozlowski wrote:
>>>> On 13/02/2026 11:24, Kuldeep Singh wrote:
>>>>>
>>>>>
>>>>> On 1/14/2026 1:49 PM, Harshal Dev via OP-TEE wrote:
>>>>>> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
>>>>>> Trusted Execution Environment (QTEE) through the SMCInvoke interface,
>>>>>> implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
>>>>>> on ARM64 CPUs and exposes secure services to Linux running in the Normal
>>>>>> World domain.
>>>>>>
>>>>>> This change enables the QCOMTEE driver as a module to support
>>>>>> communication with QTEE.
>>>>>>
>>>>>> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and
>>>>>> executing a Trusted Application via tests hosted at
>>>>>> github.com/qualcomm/minkipc.
>>>>>>
>>>>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>>>>
>>>>> Tested on rb3gen2 device and able to see driver load successfully.
>>>>
>>>> What exactly did you test? That a module can be built?
>>>>
>>>>>
>>>>> root@qcom-armv8a:~# lsmod | grep qcomtee
>>>>> qcomtee                32768  0
>>>>
>>>> Sorry, but that's basic of kbuild and module system.
>>>
>>> Yes, did a basic testing only.
>>>
>>>>
>>>>
>>>>> root@qcom-armv8a:~# rmmod qcomtee
>>>>> root@qcom-armv8a:~# insmod
>>>>
>>>> Not a defconfig testing.
>>>>
>>>>> /lib/modules/6.18.0-next-20251202-00002-ga8c3ce157925
>>>>> -dirty/kernel/drivers/tee/qcomtee/qcomtee.ko
>>>>> [  164.464598] qcomtee: QTEE version 5.2.0
>>>>> root@qcom-armv8a:~# ls /dev/tee0
>>>>> /dev/tee0
>>>>> root@qcom-armv8a:~#
>>>>>
>>>>> With that,
>>>>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>>>> Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>>>
>>>> You cannot test a defconfig.
>>>
>>> Sure, we can drop tested-by tag.
>>> Maybe patch author once send next rev can just add Reviewed-by tag only.
>>> Hope this is fine.
>>>
>>
>> I am fine with us dropping this Tested-by tag. I thought it made sense to test that
>> the driver being built as a module is removed without encountering any issues.
> 
> We do not talk about this. No one claimed that this test is good or not.
> Read again discussion - there was no test of this defconfig change. It
> did not happen as it cannot happen or is completely pointless. The tag
> applies to THE COMMIT not to something else. I explained this way too
> many times.
> 

Understood. Thank you for clarifying once again Krzysztof.

Regards,
Harshal

>> I will not send another patch revision just to collect/drop tags.
>>
>> Thanks,
>> Harshal
> 
> 
> Best regards,
> Krzysztof

