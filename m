Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054B1C5DF87
	for <op-tee@archiver.kernel.org>; Fri, 21 Aug 2026 08:34:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1A5A74534F
	for <op-tee@archiver.kernel.org>; Fri, 21 Aug 2026 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787301298;
	bh=qMKIStTY9uGBXIbbNGMaUVDuL+M376yE6CWA4T8XgXI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Gu5NYUQtdiSmK4cF0dcDkjKQoO/3xLPgWskCsaY/Oqi0VQmIVQiOK81MMJ6FSLm7/
	 q14BD/xUDLgQtpz0ZRT+5jpM/5iwsgnqS7N7BoGq5zpWG3tyBxGqchk3QyfSgSL6rF
	 y6adDywyM0mqIcqrdaCFDe8QTiSAV0K7ZCx8UzcI9beWCODtHSRqdh4lppJl2PFjnJ
	 RawoR9lWA68LWIj0fDAcBFqUqv9QcVjaT6aiWXJDLchL1BzGuJs63MAO/T2setWYFG
	 wwH0/eUsg6n1Afmx+AI5mroTEK+alXtu7FmKXm+1ay7WgEyJbVCwbSlvNzimSvQioC
	 L/Retg5JuAQAg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 306AA44F1E
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 08:34:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EafDhI/K;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jwl8lhOq;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8WWKq678246
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 08:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zkQWmi5XzBRwTW4ADEoT1+0nQs18k5RM5I5+50BNEOU=; b=EafDhI/K2LNjAJIt
	KszIgwV2LMcLTDt0FksgQRBlHAnS1UNJQzvaRAZET70uJg1ws7/FDNyKitFy1/Vk
	fTghGIfzVwbGyT1gibO+t5kVv42e/ueNNQEgaOi5wnqysfEa5aw/bq4DG65MqrQM
	4yCjlqYBVx8eQXyYgfBQgHkwLZKmQzK5e4znenSOqU2SrYSkNce+zsmCB00X6S97
	GCV7JYWQMZyP1RmN8ADOKBya3xPXWixqb/sM879v9MdkFaiYosZewR7EHbP4tsw3
	pWO0t5Tecur7UHTnrhkYuDELaXru4G9p/Fru0AA0G9BBK8ZwZbT6jchlX5E5G9am
	WQIKfg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ebus30d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 08:34:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8488ac68185so1489131b3a.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787301288; x=1787906088; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zkQWmi5XzBRwTW4ADEoT1+0nQs18k5RM5I5+50BNEOU=;
        b=jwl8lhOqG2jhVVbnVGaVOQlN9QbakkTomAOCbgxMMBl37tlHORviJqjKYdbKTuzCDJ
         NO6NtY86xBZXPL0otZ7f1/ai9TUGyTumIWSYXJqa3psaeAjvaZl9JNDJzTh4ouIC6Exc
         HhofGf8nstwQtIpxtVzpnLEIJDUa5M/g6UDSVVKHAwFKeeWC5ANXcsHt0pqY7/VjX0Tn
         hNsl3gSr2LtdfttKaHltkO/RqXHi2wLaX/7yBnuIKyjhtRflRfUZR3UH+OrSaCimkrdK
         EnHZ7dl/N4uGrMPPUVHWigvXkuEg97H3Ft6aecvfizbO4eGok1CU+G5IrtkdS68hFAwE
         K9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787301288; x=1787906088;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zkQWmi5XzBRwTW4ADEoT1+0nQs18k5RM5I5+50BNEOU=;
        b=rld5oAD7+LPUtfHivff/lzjp9VL+1LzudW8GBHOddRuqNZ7ROlsdCWF/65JERO9sbb
         ezFbc9Q5xrqMTTd4aHfXMBzwYyZpFaneq0FPaqRjTPfPcInbw84VOdY8c/i5WdwCHw+O
         /m34Ipxd0V98oXiPjPUWFMNaKvUvno8Yvd5Tm1e1Yjc5RRDYujHYDgaSUdpyaYSMDJLp
         Rml7Brmdo5p24xRKjWWXWkipUUzLZe/jRL3Sedj/Q1jHM8PR0BLTonnXf7Sds+9CQCT5
         d+VAPfFt9pN+Q2yzShvVPiw8+Yie32Q5WmYwZxL6FnnfwNR+mzCerZzQmqRZ7NJbOVqF
         nU9g==
X-Forwarded-Encrypted: i=1; AHgh+RqgTuJB9bARy/m3M26FmJiGbHrlvGrYJuE1cNE3Oq3vaSXHLoV7D/dSTtij57vVL8aMnP3u0Q8=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mt46FqdJzk0xhvIH/J6BukvejFipJIEd1+M4BUvsjt+XYYA7L5
	g2zGNKmU8V59Fe9OFk9aoFoscnUZ6idtXbbKf1ouZ2NP1HWt/dOzT/9vYILFHKY0ZSb03L3Ajmq
	a6TuDteklgiuI/+A/yDm4xc8Y8WAzXrp4Cna4w/i5BboZh5Mx4Z27pZEhviAlwxjCWtMNyFnN
X-Gm-Gg: AR+sD11rkwy8JKCAlsQgPopUXT7RJ761LEmvB8w1pNy5xUtFYRe8qhFVAmmnP30HRUY
	2IfUfa94qdmoB1M5hS24X+pGMsOErWsBlXeq9u7qKkAjXfOHFfZvJdSsui6lv5uURpJkF624Vrx
	pILw+55q6n4hWT1b9TCWEe2SUkNPcru46f4ljhLlD+kM/i4L8EHWHhpcnOwDMFWV2+iI1NfggnW
	fdaDyXhw+4iVVuLwXP9zKSRzQESpUM/J17+yTzxpp6BdF1cgnIjUNBW5zGMqDa4SI5DO29UNvXD
	f3Q67hPMCTJ0fU3ewtCxbFVklHjUKeNGcVSRGSanVMimAVrzV7+j6ljtHbYwoHoLpCDX8YORPFG
	bM5qgVy4uxzTcgxIPOIsldjiTF9lh
X-Received: by 2002:a05:6a00:300f:b0:84f:a7bf:8fb9 with SMTP id d2e1a72fcca58-851f9a23599mr8615154b3a.3.1787301288357;
        Fri, 21 Aug 2026 01:34:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:300f:b0:84f:a7bf:8fb9 with SMTP id d2e1a72fcca58-851f9a23599mr8615031b3a.3.1787301287684;
        Fri, 21 Aug 2026 01:34:47 -0700 (PDT)
Received: from [10.92.193.241] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3640a31sm2550273b3a.40.2026.08.21.01.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 01:34:47 -0700 (PDT)
Message-ID: <57335851-3c04-4452-ac31-2020591ef816@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 14:04:35 +0530
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
 <ebcfafdf-6cd3-49cc-8096-d1289af75fd5@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <ebcfafdf-6cd3-49cc-8096-d1289af75fd5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CkqMlXLL-ZvtmXja-EHvRAbo3IS2S1ok
X-Proofpoint-ORIG-GUID: CkqMlXLL-ZvtmXja-EHvRAbo3IS2S1ok
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfXy8UrXlTH6SHZ
 1pCKNlNsexct9A5DZBWhXkTNfyuSAVFSpNmYrDQ3zoZLLcnl3QPHV4iRWckXQg/4X3hvE3XfKbR
 KU840K2IE/Tgvd5NVn3f3pwYBux/UGs=
X-Authority-Analysis: v=2.4 cv=QJlYgALL c=1 sm=1 tr=0 ts=6a880da9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8 a=9ateTxuJ7PeoZa8Ee7wA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX4U6Ghnju6eRB
 l0ow6KgwtdXQPPpnc+qUNwdc93eNUBxydilB7U5l8aSGcb7EdFUGtiaBbg4mW+RSz5H0Jo7asF7
 UYXcs5nOK8pSLurZE5dDYjH1/TLn3oJpUx1GAJcuEjKiCu1MJpGRZaTtzihZ4wXROPqf7VeYEeV
 ox/Vxcz+cmVXSGIZKnQFEUC+dPFjAX5NCBU/3ajyAVK5d5VVD3ibCUuER8xiFIprSRi10uo71Jg
 M8fvnWaVPo9WneUP1GpwORCPxifjY0B/skmaXnjHwE3LeuqsJ23PLmQZrwI/FAmKm/AGYI8T4WT
 RS8W9tjxHV+gt+jMgadcDtKsviAx6TVlSmrbQszpe+w8YcwS6HU0CxyMus0goOI0CTK+Qhuopyh
 TFUmDJU3XcFMzkLN/MzYqI88c+pRX3rgMi1YQyryZgxbXgboYxVJ13f48M6wsllMO5Qq/ia8XaH
 FExp7IaHJ2S33CpaSew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[205.220.180.131:from];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 306AA44F1E
X-Spamd-Bar: ------
Message-ID-Hash: 5R2W57RMNERTCZHUPR647OO3EQYLXHSU
X-Message-ID-Hash: 5R2W57RMNERTCZHUPR647OO3EQYLXHSU
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5R2W57RMNERTCZHUPR647OO3EQYLXHSU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hello Dmitry,

A gentle reminder. Hopefully we can align on below points and move to
a v3 of this series.

Regards,
Harshal

On 17-08-2026 11:54 am, Harshal Dev wrote:
> Hi Dmitry,
> 
> Many thanks for your engagement and review on this series. I am looking forward
> to your opinions on below comments so we can align on a a v3 of this series.
> 
> Best Regards,
> Harshal
> 
> On 12-08-2026 05:00 pm, Harshal Dev wrote:
>> Hi Dmitry,
>>
>> On 10-08-2026 12:37 pm, Dmitry Baryshkov wrote:
>>> On Fri, Jul 24, 2026 at 02:43:42PM +0530, Harshal Dev wrote:
>>>> Hi Dmitry,
>>>>
>>>> On 22-07-2026 01:56 pm, Dmitry Baryshkov wrote:
>>>>> On Wed, Jul 22, 2026 at 12:29:11PM +0530, Harshal Dev wrote:
>>>>>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
>>>>>> Replay Protected Memory Block (RPMB) which is only accessible by the
>>>>>> Qualcomm Trusted Execution Environment (QTEE).
>>>>>
>>>>> Is it so? I think RPMB is accessible to Linux...
>>>>
>>>> I should have been more descriptive here, RPMB is accessible by Linux but
>>>> its frames can only be prepared by QTEE.
>>>>
>>>> The RPMB key which is one-time programmed into the storage controller to allow
>>>> authentication of the RPMB frames is generated by and only available to a TEE.
>>>> So on Qualcomm platforms (and many others platforms with a TEE) Linux can only
>>>> route the RPMB frames generated by QTEE to the storage, it cannot create and
>>>> write the RPMB frames itself (it doesn't have access to the key).
>>>>
>>>> While it is possible for Linux to generate/program/store this key, on Qualcomm
>>>> platforms we do not want Linux to do so because we do not trust it. We trust
>>>> QTEE.
>>>>
>>>> I will re-phrase this and make it a bit more clear everywhere.
>>>
>>> OK.
>>>
>>>>
>>>>>
>>>>>> For Qualcomm platforms without emulated RPMB support, specifically
>>>>>
>>>>> What is emulated RPMB support? Why is it mentioned here? Which platforms
>>>>> use emulated RPMB?
>>>>
>>>> Emulated RPMB refers to RPMB on a storage which doesn't have its own firmware.
>>>> Primarily, NAND/NOR storage. Unlike UFS/eMMC storage, NAND/NOR storage does not
>>>> have a storage controller where we can program the RPMB key to be used by the
>>>> firmware. So we must 'emulate' RPMB by moving the storage driver within QTEE
>>>> and making the driver hold/use the key.
>>>>
>>>> Qualcomm compute SoCs (Glymur, Hamoa) have RPMB available on SPI-*NOR* storage,
>>>> and a driver for communicating with it is also available in QTEE. And so, these
>>>> have 'emulated' RPMB.
>>>
>>> This needs to be explained in the cover letter.
>>>
>>
>> Ack. 
>>>>
>>>> I will add this detail in an updated cover letter.
>>>>>
>>>>>> platforms where RPMB is not located within SPI-NOR storage and instead
>>>>>> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
>>>>>> a callback request from the UEFI Secure Application to the RPMB service
>>>>>> running in user-space (within the QTEE supplicant [1]).
>>>>>
>>>>> Can it be moved to the kernel?
>>>>
>>>> We have a plan to move the RPMB service to the kernel similar to OPTEE:
>>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/tee/optee/rpc.c#L449
>>>>
>>>> It is a work in progress. Once this happens, we don't need QTEE supplicant available
>>>> on the Linux distribution.
>>>
>>> Ok.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
>>>>>> QSEECOM based uefisecapp) does not support callback requests.
>>>>>
>>>>> How did it work then? I think Windows has been perfectly using QSEECOM
>>>>> rather than QTEE.
>>>>
>>>> It works because Windows on Arm on Qualcomm has SPI-NOR storage. A driver for which
>>>
>>> I have WoA devices without SPI NOR. Windows still can store UEFI
>>> variables.
>>>
>>
>> Ahh, the key point here is 'Windows'. Windows has a separate way of providing
>> RPMB access via a service in the TrEE driver within the OS:
>> https://github.com/microsoft/Windows-driver-samples/tree/main/TrEE
>>
>> However, the Linux QSEECOM driver we have here in upstream does not have that support.
>> And so without the QCOMTEE + QTEE supplicant combination, we cannot access EFI
>> variables on these Qualcomm WoA platforms when they boot with upstream Linux.
>>
>>>> is available within QTEE, and so QTEE does not need to make a callback request
>>>> to Linux to request RPMB frame routing. However, in case of UFS/eMMC storage the
>>>> driver only exists in the Linux kernel and so QTEE must make a callback request.
>>>>
>>>> And so, if you try to use the QSEECOM driver to write EFI-variables to RPMB
>>>> on a device with UFS/eMMC storage, it won't work.
>>>
>>> Yep. It seems to work under Windows though.
>>>
>>
>> As explained above, the mechanism is different for Windows. A different driver
>> and a different protocol. :)
>>
>>>>
>>>>>
>>>>>> And on
>>>>>> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
>>>>>> QSEECOM interface fail due to lack of support within Qualcomm TEE.
>>>>>
>>>>> So, I assume, on RB3 Gen2 the QSEECOM doesn't report uefisecapp as
>>>>> supported. Does it?
>>>>
>>>> It doesn't, this API returns -2 if I add RB3 Gen2 in the allow-list for QSEECOM:
>>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/qcom/qcom_qseecom.c#L46
>>>
>>> Does it support QTEE-based uefi variable storage?
>>>
>>
>> It does, the QTEE-based uefi variable storage app, i.e. uefisecapp is loaded by
>> UEFI on RB3Gen2, however, the QSEECOM interface on RB3Gen2 is broken so it misreports
>> it as 'not supported'. But the app is loaded and available, which is why if you apply
>> this patch series, you can communicate with it. Just make sure you take the QTEE
>> release mentioned in this cover letter.
>>
>>>>>> On these platforms, a TEE based uefisecapp client driver is required to:
>>>>>> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
>>>>>> 2. Ensure persistence of non-volatile EFI variables via writes through
>>>>>> the RPMB service hosted in the QTEE supplicant.
>>>>>>
>>>>>> This series introduces such a uefisecapp TEE client driver for the
>>>>>> aforementioned Qualcomm platforms which installs efi-var operations _if_
>>>>>> the QCOMTEE driver registers support for an object-IPC based uefisecapp
>>>>>> service on the TEE bus during its probe. Only new QTEE firmware versions
>>>>>> available at [2] provide this support.
>>>>>
>>>>> What about existing WoA devices?
>>>>
>>>> New Windows on Arm devices like Hamoa/Glymur work perfectly fine with existing
>>>> QSEECOM based uefisecapp. But they will also work with this new QCOMTEE based
>>>> uefisecapp once they upgrade their firmware.
>>>
>>> Do extisting commercial devices suppot it? For example, does Lenovo T14s
>>> support it? Will it continue to work with this patchset in place?
>>
>> Existing devices like the Lenovo T14s do not have mature QCOMTEE/SMCInvoke support
>> on QTEE side and new QTEE versions for it are not being rolled out. However, this
>> QCOMTEE based uefisecapp driver and the QSEECOM based uefisecapp driver can co-exist.
>> It will not cause any breakage of existing working functionality since the QSEECOM
>> path can probe and continue as usual.
>>
>> As per your comments on patch 6 of this series, I plan to enable the QCOMTEE based
>> uefisecapp as default 'm'. That way we don't need to enable one over the other and
>> will continue supporting all existing functionality while extending it for devices
>> with UFS/eMMC storage and running upstream Linux.
>>
>> Do let me know your opinion on it.
>>
>>>
>>> What about other existing devices? We have WoA devices starting with
>>> MSM8998. The QSEECOM driver works on them, but, as you mentioned, it
>>> can't flash updates to the backing storage.
>>>
>>
>> Unfortunately, unless we roll out new QTEE firmware versions for devices like MSM8998
>> with QCOMTEE/SMCInvoke support + access to the Uefisecapp over SMCInvoke protocol,
>> they cannot be helped with this series.
>>
>>>> I need to double-check but this firmware release for Glymur on Qualcomm Linux
>>>> is probably carrying the support for QCOMTEE based uefisecapp access:
>>>> https://github.com/qualcomm-linux/meta-qcom/commit/728251fcbe5113980805ea6c571e33235062ee71
>>>> If not, the next release will definitely have it since I have merged support for
>>>> this in QTEE and talked to the boot firmware release team about this.
>>>
>>> Does it work on the CRD?
>>>
>>
>> Yes it does, I have validated on Glymur CRD by locally switching it from the current QSEECOM
>> based uefisecapp to this new QCOMTEE based uefisecapp. This is the QTEE release which
>> needs to be consumed for it:
>> https://github.com/qualcomm-linux/meta-qcom/commit/5590c1dc631827624c110df282965b85ef2a2e60 
>>
>>>>
>>>> The next planned firmware upgrade for Hamoa will also provide this support for
>>>> Qualcomm Linux. And similarly, for all other targets being supported upstream.
>>>
>>> So, we are forcing users to upgrade to the new firmware? That doesn't
>>> sound nice.
>>>
>>
>> We have an open ecosystem for all devices supported by the Qualcomm Linux distribution,
>> users can easily consume new releases (and new QTEE versions) to access new features.
>> Until now, developers/users of RB3Gen2 or IQ-9075 could not access EFI variables to
>> develop use-cases such as secure-boot key revocation, but by taking this patch series
>> as part of a subsequent Qualcomm Linux release, they will be able to.
>>
>>>>>> Thus, QCOMTEE now maintains a static list of always-available object-IPC
>>>>>> based secure services exposed by QTEE. These services are implemented either
>>>>>> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
>>>>>> usually loaded by the bootloader. The uefisecapp TA is an example of a
>>>>>> preloaded TA loaded by UEFI. A static list is required since QTEE does not
>>>>>> yet expose any way to dynamically query and enumerate the services exposed by
>>>>>> it.
>>>>>
>>>>> Can it be fixed instead of having static lists? In the end, we can't
>>>>> guarantee that users update the firmware.
>>>>>
>>>>
>>>> Unfortunately, no existing QTEE release out there currently has this support.
>>>> But support for this is currently being added by QTEE team last I checked with them.
>>>> Once it is available, and a new QTEE firmware release is out there, we will add
>>>> support for dynamically querying QTEE services in the QCOMTEE driver. 
>>>
>>> It seems you are still rolling out QTEE-based support. In such a case,
>>> please go back and implement dynamic detection of QTEE services.
>>> Otherwise it would be a nightmare.
>>>
>>
>> We are working on it, but until then there is no overhead involved in maintaining
>> this static list of services because we don't have to extend/modify this list when
>> adding support for a new Qualcomm platform upstream. If a particular service from
>> the list is not implemented/accessible from QTEE we log the event and silently avoid
>> probing the TEE driver for the service. We also don't add platform specific services
>> here. So the list doesn't need to be extended on a per-platform basis.
>>
>> So unlike the QSEECOM driver, we don't have to keep maintaining this list forever
>> for all new platforms.
>>
>>>>>> To facilitate object-IPC interactions from the kernel-space, this
>>>>>> series also introduces a tee_client_object_invoke_func() to allow
>>>>>> invocation of TEE objects similar to the existing tee_client_invoke_func()
>>>>>> API exported by the TEE subsystem which allows invocation of TEE functions.
>>>>>> Some suporting changes are also introduced to track and handle operations
>>>>>> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
>>>>>> driver.
>>>>>>
>>>>>> Finally and as previously mentioned, access to the object-IPC based uefisecapp
>>>>>> service is restricted on older QTEE firmware versions. A new QTEE firmware
>>>>>> release must be picked up from QArtifactory [2] for all upstream supported
>>>>>> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
>>>>>> driver.
>>>>>
>>>>> What about fused devices?
>>>>
>>>> The procedure for updating the firmware on fused devices is slightly different.
>>>> The firmware images need to be signed by the OEM using the security profile
>>>> of the chipset before flashing/upgrading them. Security profiles are now public:
>>>> https://github.com/qualcomm/security-profiles
>>>
>>> Will OEMs release new firmware images? What about the devices which are
>>> already out of the support phase? This whole story rotates about the 'we
>>> are releasing new firmware with new features' paradigm. However there
>>> are existing devices in the field, which typically can't be upgraded,
>>> From your cover letter it seems they can't support UEFI variables
>>> properly. However they do so in Windows.
>>>
>>
>> Yes Dmitry, this series is effectively forward looking. QSEECOM protocol/driver
>> support is essentially deprecated on QTEE side, no new features added to QTEE support
>> it, and it also doesn't work on many devices like the RB3Gen2.
>>
>> For existing devices, if they boot with upstream Linux and have RPMB located on
>> UFS/eMMC this patch series cannot help them. But the focus of this series is not on the
>> past, it is on currently supported and future hardware. Every new Qualcomm platform
>> whose support is being up-streamed or is planned to be up-streamed will have access to
>> EFI variables via this series.
>>
>> If someone wants to add support for older Qualcomm devices to access EFI variables
>> via QSEECOM that patch series will not conflict with this one. Like I said, both
>> QSEECOM and QCOMTEE based drivers can co-exist.
>>
>> Regards,
>> Harshal
>>
>>
>>  
>>
> 

