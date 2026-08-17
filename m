Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA3AC5B572
	for <op-tee@archiver.kernel.org>; Mon, 17 Aug 2026 06:24:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B60F944F01
	for <op-tee@archiver.kernel.org>; Mon, 17 Aug 2026 06:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1786947869;
	bh=pxHr1DO668e1Cfo+ay8hi7UPyyAJfYBoVIcsw2GKnO0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=4x3TIJYJnfvih62x2nmC0sHfyiiT42Vtsm3gWlEj89mkFTbkrziCRoaKIbx0/CEE9
	 t95KbKBpTX6S4x5gnBTW3hWt6yNT0BAjZg4cVJ6X+LSQM2PNZk1xvQMeNMsrLQUbKT
	 v2cPaFQemejLN+IIurEMIOF3JiSFhbo/va/0JbknnATtVUxKeN8OA3XYT6ZWQpmPQ4
	 tKwE6QfaUBHZJzy0tragnTblyRBjMj9j0Xj65arUqIdjE9qFIRtSxwIi9r8gJ/6SsU
	 wdGMkUhHwpuHxUJQINDdKzSYjoVVuP0BkbluLm+4sAZoXLpjFO9XcnGQWzAswfhMY4
	 2g4EW7ipi028Q==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6F82944B25
	for <op-tee@lists.trustedfirmware.org>; Mon, 17 Aug 2026 06:24:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ETyrBSpm;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b4fD5rKP;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H44kLC1176303
	for <op-tee@lists.trustedfirmware.org>; Mon, 17 Aug 2026 06:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sBFP7hldo5C2lrz3cpQNyiu4obDR/68aBGEyMVk4V+c=; b=ETyrBSpmYUJ93AgM
	HzKxHwdWNQjn2pmQVva3b5aTkEPx+TXK6+DfpgPm0peg5SGZo9j6E2EKHJr2kZJI
	1OLCcdZ4Pu7I3i3BPF29beOKJl5urEKsjAqCd2zDl9aPeUX5s/6/Y3nwSPLLmHD8
	iSleS0f8wpS4w3hMIoILB23AjIHm+4JwO2GyQg+Oh4UEYoLZZZSyYsEbpcIRwhzP
	HL98MWin0zUk7RY9lFKUwEIFp28mvQBGeIYHWKqa7g98hox8byP3DiDVo0OMyZIc
	Uqi1BgNnxTgWOLu6nJrL8eaEYRLphrOrWVNAqZ3f83AHJVf7m0ttW2xCotYTzWH2
	yekfwQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txy8cpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 17 Aug 2026 06:24:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce8a76df2dso71283955ad.2
        for <op-tee@lists.trustedfirmware.org>; Sun, 16 Aug 2026 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786947859; x=1787552659; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sBFP7hldo5C2lrz3cpQNyiu4obDR/68aBGEyMVk4V+c=;
        b=b4fD5rKPwZXLWuygNO1IkJgmzM8OS+JB2vb2Ok/AaRni/hRW9kMBCMQH98KJpfHdcV
         HZjpNjd6xj9xTFUUmJ3dcmhX5swL/zLKwZkyqzQl0p/yrOHo9f6oA+d+HNdMpBmna8zw
         FK5tfZVklMnEyPik5wl1rW8KxHhI/uYgKNN73m91t43m/qGtij7rI1f/GZqkrwwp51fs
         DJ2L1eds2VG/8TFx+k8wBCKP9uaZ/UedLcvFczEhzRbDzmDe07i3hfcLWpkIxyHrBZ3/
         YqUVlEnj0AdD/o3FVepNTFJPsJIGB6I/c/QXdEx9kP6sikd6V0p0VUFXS/vgXwLnzezr
         dPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786947859; x=1787552659;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sBFP7hldo5C2lrz3cpQNyiu4obDR/68aBGEyMVk4V+c=;
        b=qAoj6QJSiPmYTfbFYPfui4W6KUMggUyoB6k4umU90NLTVx7rjuWMMjptuPNAJMVXyw
         z4RYSSUG9XoWFAXsqZf5tT7PQgPkxwzCudaqdXxMYV8WgddecQDKNQNNI7E40+WyxTde
         J/4PuFGjOEf/WPdX0LvCC7l52FJumsCHOSi5LjFSAdOK9Xp7hXdshBoSxt8tZMWVfmIp
         le7H+WvL8NdSmERHbT3c/lsbICwabNtTt9Q+moFn8UzkzsLihl2Dl7R1/4CBKkudMgtX
         LIE4y+bLnUYJPkcOXuD9Rw5BkNqyCGr5+49FJaTWhNC95A8u7bGyiNdoNCj4SB5eZcL+
         suJw==
X-Forwarded-Encrypted: i=1; AHgh+RqpNCH38x9YRt8hg9iC2WdIeZbMnioCuZZOqqRrs+k0ZZMnn8ZfUsmj5bitktISbB0xoHz+4fI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzcWpZaF+b5hI4RyhInZHO316jxVNu+ymFs1qOeSOvaiTG3wHeT
	C3ieDNHbm+jAFFI/ZIPBqdvl2t9FYwFjmnpPaIstU/QOFayVZ7sak942dG53a1dz6NRgvzEyddW
	DogHLX0nkdkJQiKOFLx54bLaRlOevklzSwk4saY65zXM0xnUYpB+dDPLT4y2ERQWnG29DWl61
X-Gm-Gg: AR+sD10B9i5bWN+MXL32/HWvIN0DJZ01a8xmXNvhnCm0FcbfLVmgUrObvt5VfLBlu3T
	EAyXYGdPTY1kwuI14+om9zUuvXgv9waHJ028r5ENB9XVzIh+l548zLMZp2rz+mzz/wF8kAWpMsN
	LM1mpU/kAHw3IVq22TFf/KgDjr5VdwRK/Fjq2RwtHR46+cTUxk7v0btO8np0jkpTepHa45dCaUL
	l7lYH7uRvPKKNAO8RRC/id4fH2+nC7t8jORK4/JLxuyFihR8ggJJZwzrDdRoANxjcwGqtD2BEMl
	bU0qlhTgP0hGQjYA4QJ8DwlZ1CraITShL3lVvAiEG8vH/JuqUYTyrHVP0/r9VcYtpAAKHkX/w9+
	LoVzaFN+/9mqSmTpZnyk+orzJLneX
X-Received: by 2002:a17:902:ec90:b0:2ca:d658:d874 with SMTP id d9443c01a7336-2d3b0cf02damr216912345ad.23.1786947859140;
        Sun, 16 Aug 2026 23:24:19 -0700 (PDT)
X-Received: by 2002:a17:902:ec90:b0:2ca:d658:d874 with SMTP id d9443c01a7336-2d3b0cf02damr216911895ad.23.1786947858533;
        Sun, 16 Aug 2026 23:24:18 -0700 (PDT)
Received: from [10.92.195.156] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb49e7c7sm984365ad.14.2026.08.16.23.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 23:24:17 -0700 (PDT)
Message-ID: <ebcfafdf-6cd3-49cc-8096-d1289af75fd5@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 11:54:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add TEE based client driver for UEFI Secure
 Application
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <nfijwr2ptpxqvdw625yedep7tmakwvkeavyeobrmig5hbkw77w@rcqyp7h4y327>
 <db27820a-2b43-45e4-bc4a-0e9e81aacd93@oss.qualcomm.com>
 <oicbypv7rpxmweclopi5xxpcfq5chnypp5tlqd4uix2pm5e72f@kd3bibeximjq>
 <10a091a4-89a5-4a0c-820d-c5b91dd52529@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <10a091a4-89a5-4a0c-820d-c5b91dd52529@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0NiBTYWx0ZWRfXy9oQpU6ZaNKJ
 kAJDgedeDQ3fl48CC5niXzGufdL8GTWzvzOiqUsVlvjs83UFildG0RaiPRsN2svvzKnLpWW3jWa
 oB54ireFtV1vSTNHTJszU61mSjfy5sE=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a82a914 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8 a=f5ZdGIiNhfuRS9tBkb8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0NiBTYWx0ZWRfX7PR0MjnICqp4
 QB2tZv4v1MrpJFQ4t3BiVKVH2Ef/6BkdifPzrPhaVcVVWU0rlYVEr6TAb3hAEHt7kW7U4ukhFSx
 X81slrjjBA7kmRZpDTLD5L1WIMEKk7F16eC8iE4SbD/Mz7loloUGHBKhv1DMcN9ErDArk1GgI2l
 Ukb6Yl6vi+jM4cwkBcGXevjXZJf/MzrQcsfZTqcJF64s+g4VFEtei5jYbFUt+JAuVWIkXs+Eew1
 V3XcXcTXbzDXcWkvrlkKgJXw9n7E5yYxAE08KSoqg2AfEgPfzre+595iUjBn9Vr0wAZsAkCUVJg
 Kf7qwGKVFPkLFGDXWrnm9YeTH/wqmJprDKEpg+fxnAjMKRihY9Y79/IM5h6knj+IeTgt7GAq8a2
 hfP1G9yaPQFbUh40AhmfTzPc4sgxt5+H8hex2i2rmXgld9WSyrbOqAvOS/koJ2dE4tmtFQCWmiz
 1WaJ0GZFhWVl8no+cCw==
X-Proofpoint-GUID: egKn6uUo1tWvZg8CYRheZcQAfl4KUzy2
X-Proofpoint-ORIG-GUID: egKn6uUo1tWvZg8CYRheZcQAfl4KUzy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from,202.46.23.19:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6F82944B25
X-Spamd-Bar: -----
Message-ID-Hash: IZRSCJQKORYJZZLEENBBEVWYZBVDDKP3
X-Message-ID-Hash: IZRSCJQKORYJZZLEENBBEVWYZBVDDKP3
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IZRSCJQKORYJZZLEENBBEVWYZBVDDKP3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Dmitry,

Many thanks for your engagement and review on this series. I am looking forward
to your opinions on below comments so we can align on a a v3 of this series.

Best Regards,
Harshal

On 12-08-2026 05:00 pm, Harshal Dev wrote:
> Hi Dmitry,
> 
> On 10-08-2026 12:37 pm, Dmitry Baryshkov wrote:
>> On Fri, Jul 24, 2026 at 02:43:42PM +0530, Harshal Dev wrote:
>>> Hi Dmitry,
>>>
>>> On 22-07-2026 01:56 pm, Dmitry Baryshkov wrote:
>>>> On Wed, Jul 22, 2026 at 12:29:11PM +0530, Harshal Dev wrote:
>>>>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
>>>>> Replay Protected Memory Block (RPMB) which is only accessible by the
>>>>> Qualcomm Trusted Execution Environment (QTEE).
>>>>
>>>> Is it so? I think RPMB is accessible to Linux...
>>>
>>> I should have been more descriptive here, RPMB is accessible by Linux but
>>> its frames can only be prepared by QTEE.
>>>
>>> The RPMB key which is one-time programmed into the storage controller to allow
>>> authentication of the RPMB frames is generated by and only available to a TEE.
>>> So on Qualcomm platforms (and many others platforms with a TEE) Linux can only
>>> route the RPMB frames generated by QTEE to the storage, it cannot create and
>>> write the RPMB frames itself (it doesn't have access to the key).
>>>
>>> While it is possible for Linux to generate/program/store this key, on Qualcomm
>>> platforms we do not want Linux to do so because we do not trust it. We trust
>>> QTEE.
>>>
>>> I will re-phrase this and make it a bit more clear everywhere.
>>
>> OK.
>>
>>>
>>>>
>>>>> For Qualcomm platforms without emulated RPMB support, specifically
>>>>
>>>> What is emulated RPMB support? Why is it mentioned here? Which platforms
>>>> use emulated RPMB?
>>>
>>> Emulated RPMB refers to RPMB on a storage which doesn't have its own firmware.
>>> Primarily, NAND/NOR storage. Unlike UFS/eMMC storage, NAND/NOR storage does not
>>> have a storage controller where we can program the RPMB key to be used by the
>>> firmware. So we must 'emulate' RPMB by moving the storage driver within QTEE
>>> and making the driver hold/use the key.
>>>
>>> Qualcomm compute SoCs (Glymur, Hamoa) have RPMB available on SPI-*NOR* storage,
>>> and a driver for communicating with it is also available in QTEE. And so, these
>>> have 'emulated' RPMB.
>>
>> This needs to be explained in the cover letter.
>>
> 
> Ack. 
>>>
>>> I will add this detail in an updated cover letter.
>>>>
>>>>> platforms where RPMB is not located within SPI-NOR storage and instead
>>>>> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
>>>>> a callback request from the UEFI Secure Application to the RPMB service
>>>>> running in user-space (within the QTEE supplicant [1]).
>>>>
>>>> Can it be moved to the kernel?
>>>
>>> We have a plan to move the RPMB service to the kernel similar to OPTEE:
>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/tee/optee/rpc.c#L449
>>>
>>> It is a work in progress. Once this happens, we don't need QTEE supplicant available
>>> on the Linux distribution.
>>
>> Ok.
>>
>>>
>>>>
>>>>>
>>>>> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
>>>>> QSEECOM based uefisecapp) does not support callback requests.
>>>>
>>>> How did it work then? I think Windows has been perfectly using QSEECOM
>>>> rather than QTEE.
>>>
>>> It works because Windows on Arm on Qualcomm has SPI-NOR storage. A driver for which
>>
>> I have WoA devices without SPI NOR. Windows still can store UEFI
>> variables.
>>
> 
> Ahh, the key point here is 'Windows'. Windows has a separate way of providing
> RPMB access via a service in the TrEE driver within the OS:
> https://github.com/microsoft/Windows-driver-samples/tree/main/TrEE
> 
> However, the Linux QSEECOM driver we have here in upstream does not have that support.
> And so without the QCOMTEE + QTEE supplicant combination, we cannot access EFI
> variables on these Qualcomm WoA platforms when they boot with upstream Linux.
> 
>>> is available within QTEE, and so QTEE does not need to make a callback request
>>> to Linux to request RPMB frame routing. However, in case of UFS/eMMC storage the
>>> driver only exists in the Linux kernel and so QTEE must make a callback request.
>>>
>>> And so, if you try to use the QSEECOM driver to write EFI-variables to RPMB
>>> on a device with UFS/eMMC storage, it won't work.
>>
>> Yep. It seems to work under Windows though.
>>
> 
> As explained above, the mechanism is different for Windows. A different driver
> and a different protocol. :)
> 
>>>
>>>>
>>>>> And on
>>>>> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
>>>>> QSEECOM interface fail due to lack of support within Qualcomm TEE.
>>>>
>>>> So, I assume, on RB3 Gen2 the QSEECOM doesn't report uefisecapp as
>>>> supported. Does it?
>>>
>>> It doesn't, this API returns -2 if I add RB3 Gen2 in the allow-list for QSEECOM:
>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/qcom/qcom_qseecom.c#L46
>>
>> Does it support QTEE-based uefi variable storage?
>>
> 
> It does, the QTEE-based uefi variable storage app, i.e. uefisecapp is loaded by
> UEFI on RB3Gen2, however, the QSEECOM interface on RB3Gen2 is broken so it misreports
> it as 'not supported'. But the app is loaded and available, which is why if you apply
> this patch series, you can communicate with it. Just make sure you take the QTEE
> release mentioned in this cover letter.
> 
>>>>> On these platforms, a TEE based uefisecapp client driver is required to:
>>>>> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
>>>>> 2. Ensure persistence of non-volatile EFI variables via writes through
>>>>> the RPMB service hosted in the QTEE supplicant.
>>>>>
>>>>> This series introduces such a uefisecapp TEE client driver for the
>>>>> aforementioned Qualcomm platforms which installs efi-var operations _if_
>>>>> the QCOMTEE driver registers support for an object-IPC based uefisecapp
>>>>> service on the TEE bus during its probe. Only new QTEE firmware versions
>>>>> available at [2] provide this support.
>>>>
>>>> What about existing WoA devices?
>>>
>>> New Windows on Arm devices like Hamoa/Glymur work perfectly fine with existing
>>> QSEECOM based uefisecapp. But they will also work with this new QCOMTEE based
>>> uefisecapp once they upgrade their firmware.
>>
>> Do extisting commercial devices suppot it? For example, does Lenovo T14s
>> support it? Will it continue to work with this patchset in place?
> 
> Existing devices like the Lenovo T14s do not have mature QCOMTEE/SMCInvoke support
> on QTEE side and new QTEE versions for it are not being rolled out. However, this
> QCOMTEE based uefisecapp driver and the QSEECOM based uefisecapp driver can co-exist.
> It will not cause any breakage of existing working functionality since the QSEECOM
> path can probe and continue as usual.
> 
> As per your comments on patch 6 of this series, I plan to enable the QCOMTEE based
> uefisecapp as default 'm'. That way we don't need to enable one over the other and
> will continue supporting all existing functionality while extending it for devices
> with UFS/eMMC storage and running upstream Linux.
> 
> Do let me know your opinion on it.
> 
>>
>> What about other existing devices? We have WoA devices starting with
>> MSM8998. The QSEECOM driver works on them, but, as you mentioned, it
>> can't flash updates to the backing storage.
>>
> 
> Unfortunately, unless we roll out new QTEE firmware versions for devices like MSM8998
> with QCOMTEE/SMCInvoke support + access to the Uefisecapp over SMCInvoke protocol,
> they cannot be helped with this series.
> 
>>> I need to double-check but this firmware release for Glymur on Qualcomm Linux
>>> is probably carrying the support for QCOMTEE based uefisecapp access:
>>> https://github.com/qualcomm-linux/meta-qcom/commit/728251fcbe5113980805ea6c571e33235062ee71
>>> If not, the next release will definitely have it since I have merged support for
>>> this in QTEE and talked to the boot firmware release team about this.
>>
>> Does it work on the CRD?
>>
> 
> Yes it does, I have validated on Glymur CRD by locally switching it from the current QSEECOM
> based uefisecapp to this new QCOMTEE based uefisecapp. This is the QTEE release which
> needs to be consumed for it:
> https://github.com/qualcomm-linux/meta-qcom/commit/5590c1dc631827624c110df282965b85ef2a2e60 
> 
>>>
>>> The next planned firmware upgrade for Hamoa will also provide this support for
>>> Qualcomm Linux. And similarly, for all other targets being supported upstream.
>>
>> So, we are forcing users to upgrade to the new firmware? That doesn't
>> sound nice.
>>
> 
> We have an open ecosystem for all devices supported by the Qualcomm Linux distribution,
> users can easily consume new releases (and new QTEE versions) to access new features.
> Until now, developers/users of RB3Gen2 or IQ-9075 could not access EFI variables to
> develop use-cases such as secure-boot key revocation, but by taking this patch series
> as part of a subsequent Qualcomm Linux release, they will be able to.
> 
>>>>> Thus, QCOMTEE now maintains a static list of always-available object-IPC
>>>>> based secure services exposed by QTEE. These services are implemented either
>>>>> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
>>>>> usually loaded by the bootloader. The uefisecapp TA is an example of a
>>>>> preloaded TA loaded by UEFI. A static list is required since QTEE does not
>>>>> yet expose any way to dynamically query and enumerate the services exposed by
>>>>> it.
>>>>
>>>> Can it be fixed instead of having static lists? In the end, we can't
>>>> guarantee that users update the firmware.
>>>>
>>>
>>> Unfortunately, no existing QTEE release out there currently has this support.
>>> But support for this is currently being added by QTEE team last I checked with them.
>>> Once it is available, and a new QTEE firmware release is out there, we will add
>>> support for dynamically querying QTEE services in the QCOMTEE driver. 
>>
>> It seems you are still rolling out QTEE-based support. In such a case,
>> please go back and implement dynamic detection of QTEE services.
>> Otherwise it would be a nightmare.
>>
> 
> We are working on it, but until then there is no overhead involved in maintaining
> this static list of services because we don't have to extend/modify this list when
> adding support for a new Qualcomm platform upstream. If a particular service from
> the list is not implemented/accessible from QTEE we log the event and silently avoid
> probing the TEE driver for the service. We also don't add platform specific services
> here. So the list doesn't need to be extended on a per-platform basis.
> 
> So unlike the QSEECOM driver, we don't have to keep maintaining this list forever
> for all new platforms.
> 
>>>>> To facilitate object-IPC interactions from the kernel-space, this
>>>>> series also introduces a tee_client_object_invoke_func() to allow
>>>>> invocation of TEE objects similar to the existing tee_client_invoke_func()
>>>>> API exported by the TEE subsystem which allows invocation of TEE functions.
>>>>> Some suporting changes are also introduced to track and handle operations
>>>>> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
>>>>> driver.
>>>>>
>>>>> Finally and as previously mentioned, access to the object-IPC based uefisecapp
>>>>> service is restricted on older QTEE firmware versions. A new QTEE firmware
>>>>> release must be picked up from QArtifactory [2] for all upstream supported
>>>>> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
>>>>> driver.
>>>>
>>>> What about fused devices?
>>>
>>> The procedure for updating the firmware on fused devices is slightly different.
>>> The firmware images need to be signed by the OEM using the security profile
>>> of the chipset before flashing/upgrading them. Security profiles are now public:
>>> https://github.com/qualcomm/security-profiles
>>
>> Will OEMs release new firmware images? What about the devices which are
>> already out of the support phase? This whole story rotates about the 'we
>> are releasing new firmware with new features' paradigm. However there
>> are existing devices in the field, which typically can't be upgraded,
>> From your cover letter it seems they can't support UEFI variables
>> properly. However they do so in Windows.
>>
> 
> Yes Dmitry, this series is effectively forward looking. QSEECOM protocol/driver
> support is essentially deprecated on QTEE side, no new features added to QTEE support
> it, and it also doesn't work on many devices like the RB3Gen2.
> 
> For existing devices, if they boot with upstream Linux and have RPMB located on
> UFS/eMMC this patch series cannot help them. But the focus of this series is not on the
> past, it is on currently supported and future hardware. Every new Qualcomm platform
> whose support is being up-streamed or is planned to be up-streamed will have access to
> EFI variables via this series.
> 
> If someone wants to add support for older Qualcomm devices to access EFI variables
> via QSEECOM that patch series will not conflict with this one. Like I said, both
> QSEECOM and QCOMTEE based drivers can co-exist.
> 
> Regards,
> Harshal
> 
> 
>  
> 

