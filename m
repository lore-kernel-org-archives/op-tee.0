Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EF2C87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 23:24:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 002BB43099
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755127450;
	bh=D66gSkXwljvzFre/FOcNCT6buXirBv7V//dYm97gyAg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eaYyM1TCt0PBjE+XQhUm5pAoPhKzwSRpGdY45up3Oyt6A9HRTnLxjVoUZCnqf3XB+
	 HRMiE6CWlZei9TvASdziLMrBSievRI3tucWtLC/vAZi4mVblF2H9IRIDlA/4sHv2Jo
	 NV6MELA4Ba/W/U/4BRTph6oWlV6gQDeULS7w35MtIBQKuzVOJqwGB5+2KabFURQomg
	 NVUNprsjETGFpAjeC9XNlktxnwgRzpmJCZ9Ps2e3zLoK/mzTONAh4N3NW7Tps7uuZ9
	 aqLvue88uuhaOmVRVPmt3k8K4Odv6YNyioTLN+ghs0S5Np7K+YUa/bVy2V6PiC9/iA
	 tFhR2pjJJ2H4g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A53D342E10
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:23:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOlzgTDK;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMK6AR002802
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iA6096032O8eraf5ErblJhkD3Z0jA/+vFYM4Vm1Ntuw=; b=TOlzgTDKGLoL6c3W
	60rRpgi2e6BWCynvvUsTJimxfrH1Jx8J+fCpYryKmW7KR/hvmWWF2Jfo4T2p6uCN
	noWNhlxOve1trqDf6IhHj/SMuv0NQfd/FHIVd8oi+iG7+QYRck3i+NtVgSXpU977
	MD2t/VBfUroL47SCDqUCaAGSnHVsr4viZcuBVwSig7q1InVKvA/MDVALiwsF0ME4
	JICcAwhzADnlR0Vr0LDHRdy6A9LPxvYsnxI2o9CO4yneATGRz5mwmSljp6/IeV3f
	q8IFZw4KKqV8sRseqjUy2KqIZEHjqEIXbf7mOOIirlaYQ7B6bEVevDhviQwWLwdh
	9inxbw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv5hnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:23:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f42254so6429685ad.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 16:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127435; x=1755732235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iA6096032O8eraf5ErblJhkD3Z0jA/+vFYM4Vm1Ntuw=;
        b=Hjr5E491dJQQrHSYboIRiWpYLpM25QLuuDzHIWi8A2DfoYF5DbApVp7ijwk9sJejUn
         mab7QevGYX7oI/jhOv5VwkCg3++cV8+Ue3pdKYlF1LDQvP6vOp5RnOLBa79x/OUdqTzv
         Wcpg02/Nj/uwaWlqanDMNNEPCC02Y4F37Xq7dRWIedqXgG6chJoAAuanOeAf190ojtpj
         2NIAsOFEH2YbkdTqeAj/Brdacp3WsWphja5qW7IDMq6LHi+NByks/1x0FZ/0QNwLqpZW
         +gUSrT2aWUhrT26Qsx4o9kztDLRba5p+j4+9gxe461HL7XHK8LztglRBa8tsPWBUDyYM
         g6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCW0FSQg6/8LkAP8PHpf+Oy8lUyN7GJqOuEr1iO7qYSpCfIK18irgKoZca/YJ0fFxzu+ZRNDamE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwGSQw5mieeIm33ETKPfPoAxv3P/YWVdVmcJeXBmRpJmQDc62lw
	cRnh5xDdt0rPxZxpB89WV6+yMCGWhqaZOdWvtnqOTHwK89QnDj54njrkaDzkvmBmIYuKGiqUqPv
	VU11AzkLfB7uc0TN5+ZZiFelmB0Oy1pLgaV4sGR706JVqQMaOMEmF8bPrLrz2MU+8x2i5l7PVP8
	qaeBt3ag==
X-Gm-Gg: ASbGncsRJP13XFDqqBrQwdrlPKRaphHex4XePtOBehbfwlixvLQLUtvaUzmJemnKmW8
	MRYxmM3Lt7B210nQ076y866I76wESxl2525OUDuhyx5PjcUfu1l/wfuYkUilkfeqj5j/wN/ugp+
	JPUtlTBbUfpBVW9Py0T+pTaO91N2IJbBpcaY+VnGGF+gfl4xRmYw0JXZxjjEw5pJ6cnK7apn0Ha
	sREIVYPyV7AEGsav3ISjdztfF24jbBrqabQZChobbZAeorQnQ3gnQeltLWt/saQEkeR0rUk0o2W
	QKQBth8rBr82aNaxItY9fZ2SFU2MofzbCrfONNfC3mXHgcC+fP37Z/cm/mk1ne6gQ7F6tiufuL/
	yi6sN/aFHs+QrcCdjW4y4Y3R4rWjoBF/+U1nP+g==
X-Received: by 2002:a17:903:1c8:b0:23e:22dc:665c with SMTP id d9443c01a7336-244586c46fbmr13119835ad.33.1755127434795;
        Wed, 13 Aug 2025 16:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHDCnRh0Js6W0SOu+on6VKjPDQGJcgj0Cg2MJ13k4MfvzHuV5x1VI5U3usKguIYljIv3YAFA==
X-Received: by 2002:a17:903:1c8:b0:23e:22dc:665c with SMTP id d9443c01a7336-244586c46fbmr13119515ad.33.1755127434369;
        Wed, 13 Aug 2025 16:23:54 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77f33asm28118326a12.5.2025.08.13.16.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:23:53 -0700 (PDT)
Message-ID: <0cc814ae-ea8a-44cd-b502-1f89876e61b9@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 09:23:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
 <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
 <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
 <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
 <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
 <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689d1e8c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=pGb8jkpG1LKJgODn460A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jFqUjjeHWbWPVjnlJuGcaePuZm6De0qP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX/ycxAmhm5uqW
 aGFyQXVzDOzNquE+qeHiwhurfdUqYkBhRN/zyiOmHfWkZFe47112mFQHhXUpS1rNmPGL3k4Cxlb
 vs9NMhFR/W+F9KbOlqElfbHFMZCi6wlcS1ej5c5SGSQIu+xYVG+pUXrjOEaAM3IbsPEhbd+G4r8
 TwFjPH4918TOqNOEBv1ZUVW0/i2C02zTrT1tKDy6UUik8ln8j9AwNSarnfXSrnAzhngtdZKOT8U
 aQ+0CzZoLPWY6Dn+LPOmEGMrz8zzHcRbdycKGKBE7nUR2CY0XgwXc38Ir+VtGID1SHBHZZbRcga
 tOTuJSCBgTUIXvLH6fW4zpyGiZNgVRyuoIjGGOcaJTHMZL84JnaOqvq3nbFm1lyjojuT7XTz6cI
 yOzLTAAt
X-Proofpoint-GUID: jFqUjjeHWbWPVjnlJuGcaePuZm6De0qP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025
X-Rspamd-Queue-Id: A53D342E10
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.86 / 15.00];
	BAYES_HAM(-2.76)[98.95%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: WFZRCXW7FTHCWGQDT44MOIG32TEYXCXQ
X-Message-ID-Hash: WFZRCXW7FTHCWGQDT44MOIG32TEYXCXQ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WFZRCXW7FTHCWGQDT44MOIG32TEYXCXQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 8/14/2025 9:20 AM, Konrad Dybcio wrote:
> On 8/14/25 1:19 AM, Amirreza Zarrabi wrote:
>>
>>
>> On 8/14/2025 8:49 AM, Konrad Dybcio wrote:
>>> On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
>>>>
>>>>
>>>> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>>>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>>>> Enable userspace to allocate shared memory with QTEE. Since
>>>>>> QTEE handles shared memory as object, a wrapper is implemented
>>>>>> to represent tee_shm as an object. The shared memory identifier,
>>>>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>>>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>>>>
>>>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>> +/* Mapping information format as expected by QTEE. */
>>>>>> +struct qcomtee_mapping_info {
>>>>>> +	u64 paddr;
>>>>>> +	u64 len;
>>>>>> +	u32 perms;
>>>>>> +} __packed;
>>>>>
>>>>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>>>>> TZ will always be little-endian, regardless of the host OS
>>>>>
>>>>
>>>> I'm not entirely sure how this point is relevant. As I understand it,
>>>> the core that populates this struct is the same one that accesses it in TZ.
>>>> Your argument would absolutely make sense if the host and TZ were operating
>>>> on different cores with distinct architectures -- such as one being
>>>> little-endian and the other big-endian, which is not the case.
>>>
>>> CONFIG_CPU_BIG_ENDIAN=y exists on arm64
>>>
>>
>> Or, you are saying we may have a configuration where host is big-endian
>> but TZ is little-endian?
> 
> I was indeed about to say that.. I believe our tz is always little-endian
> but you can run the HLOS of either endianness

Ok, I'll update them.

> 
> Konrad

