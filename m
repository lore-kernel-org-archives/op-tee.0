Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2443CA0EE0
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 23:20:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4107F4FB98
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 23:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755127249;
	bh=K41reef5ANbMRiF4uxfGDDzVnXCjuA+uPaSg4T4I0S4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2PEYAi60VLK2qEXZOij/+Rc++mWM2OPghPXUULg0WCFIkSO7y4475mNjqdfCHmzcE
	 SbAeH7kwOIsE9wwGDhuoRMfuGbJsIRvfyU6X8e8rYRIRK26zj+FPnGJIubbfoEVRN4
	 HBTmgH+gFWEczC7ZP3764koObuBkmrYZAuzgi0ldYMnB8hX0W5QDmzcRZlX0pKNg3/
	 3leE4cZS895SQ2IDrizrwXOqgNoyKseCcQa7mzj2WTlW56HacdTSKjD2PzgTYB47s9
	 Nf+dADi5leVYQ78OHwDQ7Z1wA9i7mkr56okaT6c3ncPfcpgMo+BHruV+qZVAg2Eav3
	 9GrAQzkyuVLWA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 37BD142E7A
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:20:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZUr3CSHf;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DN53RZ028537
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MqQ5LAlEsNqEJ+2SlpIbhfIckQ4duQR//L6MMCTIFNU=; b=ZUr3CSHfaxYU7N0J
	LwQg1xZ/rtIGFfgOgxl//7sS/0lm4Aj5yk7ZCp2DrOeQnltcqlalw/MjKgKXJmB+
	oR6whs/bwSNoSSjCUsRBmrqLCuyYyseg7WuKg2byxi3NUBFU4hAcB1Sdee3KVWPP
	crdL2t/xZelR9gxtErvlVatGaPVfFcMk+mzQujkhNYImlwRCBKmehZkMqLAxIAXM
	ApjsmvSP8+P/Lhv6k2mBaW7cR7600sun5hZnVYHOR82/Gm4jqyUqYAyyrV1fU002
	d28pwp6qqgU8yccOV33hbPzippgHDkbiotXdJ726hvXMeBz1QTAZ/E0N0QmBMdb2
	A5tNZw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9vmnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:20:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109af1c20so854121cf.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 16:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127233; x=1755732033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqQ5LAlEsNqEJ+2SlpIbhfIckQ4duQR//L6MMCTIFNU=;
        b=vQXlnQoAX/f/m3guck/WXvCr8RHkbl/KHKdU/KP6OA8fOokSFARJHpXtw8uhq2bD1R
         KgxR2UbxdIwmsQhgKv3ePbpzd8YxU/4LZN1d/1AXxyYFi/7W/6u1wDC9bpM5ZTbCWTU1
         cBPPX9SV5Hgfa8sNORnDyIO1VTZO9qAhzF79h0430tckSWY0sbRaiM23E2DmV3spdVJY
         GzuiAa8pml5YN/r/b2CUgsiKL0xvpvLvXCBueBSlpCUosES/vCjlf+S+sK1dK3265nzA
         sqDLaOVoCrC77c3CRe5LdgF6Sz95rAJSpdFCIhVV0YLae5NyaUa626Zh4IfpLWhlJKI7
         moQA==
X-Forwarded-Encrypted: i=1; AJvYcCUtJMvCg2vjREpSAqL/v6ENzUDPUNH3yc4YLCPF3kEBPZ3y5dx/6FjHcIN9KBo/G9efNvwxQaA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzWjKKAFac7B50PeYxvcsZXm58UI1gNsXzw8QRvoGlBu4R/sGsz
	ty1UWPxFACvX2Mn0dofynzw7c6YBxWufyF8QW2gdJjBgtyc9wTXX24pceSrBjqeIEN7Y2IVutJb
	eYR5RSTmXI9WDoCuu3WasuyigfV4jrHO8cLSAVGrVP2ZSejbTpR2MlnGIJFlwMk5DNgXJ+DI4
X-Gm-Gg: ASbGncvdTph1dYpDc5ZIjy07gg6w4osSfy8y0nLlgFIJi/8baXefPmjKSaXK37QzFZy
	0zry9VXNSJ/KhI7cWsjJ2Web+I6ZMjlIyY+1hodwmiZx5YTNRXSRjx2e6P+VsbxVy+npshQRfAg
	3RuUfhXfG9cX7BNckeuqOdk+52OmFJfC4rOrv+R5rMfAJn6VcsjFD32SOZnYrcJDS0qCBtYAHdz
	FWREgnw7v8rq6ArP2RkmC7ZXDSnEmGUcwLh4AHJi44n+AwfWft9nfwL+7xyfZQA8+gzwHPbBEp9
	7fll7pib9+NStTnbz7WZJ3lTo9HjucplWtXRwCZPB92zq54rO/C7w/W0+yVkgHnRcAE6iGyiQyk
	JtcXwwS8SCtpKv5rWGA==
X-Received: by 2002:a05:622a:11c9:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4b0fc7bd280mr35471871cf.10.1755127232709;
        Wed, 13 Aug 2025 16:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEerwHUOumqAcf494bszPPlRc+za1y06J1v7a2/RnRceuUSxkyYhtRk1xeTG5320KKmAVxs7g==
X-Received: by 2002:a05:622a:11c9:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4b0fc7bd280mr35471561cf.10.1755127232170;
        Wed, 13 Aug 2025 16:20:32 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9113e40sm22753076a12.57.2025.08.13.16.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:20:30 -0700 (PDT)
Message-ID: <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 01:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
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
Content-Language: en-US
In-Reply-To: <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689d1dc2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=frUY0QHmMtcHLPOZDgsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BMwP-U30NeZeIWwGoAnfTGX6L7uB34-P
X-Proofpoint-ORIG-GUID: BMwP-U30NeZeIWwGoAnfTGX6L7uB34-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX71674feG4fxA
 9qVO9LtkILXXGY9O6kAAeaI04pDwLFZGAoS7sqDxfEG4tlYQNV7Z1PQfxnjJrb86/uigJXvBXRk
 gfyffiVP4n1cJBEpywzGnR7e1St4x1Lur4kcvPNekcVggMg15Lr7PD4eQu+UB0UUqT2f6ABrOne
 YvhJVbX4d0Vbya8s3+WzPQKzd6P3num8V9iUCeYcGgITV1YSiZiuLDUTykejvedsXA9li1yfxh9
 MkcMnsTDufzG9+bzM+xLLY3lPAJigGUoZZ7AzZ8duIHFi7ndhEfG9vbtfD7KYm2prznP/Zcmq+i
 lT9z5NLYuRxUflQi/uAHITnvYtN5+nhJLF+d9a25yRb3wiWdhHyHyU35r8BDBAm1ua8JOOJzBOC
 u6hteG9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164
X-Rspamd-Queue-Id: 37BD142E7A
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.85 / 15.00];
	BAYES_HAM(-2.85)[99.37%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: UHM4KCAJU6BHNH3AW6S4S2RAGTE57Q7S
X-Message-ID-Hash: UHM4KCAJU6BHNH3AW6S4S2RAGTE57Q7S
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UHM4KCAJU6BHNH3AW6S4S2RAGTE57Q7S/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 8/14/25 1:19 AM, Amirreza Zarrabi wrote:
> 
> 
> On 8/14/2025 8:49 AM, Konrad Dybcio wrote:
>> On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
>>>
>>>
>>> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>>> Enable userspace to allocate shared memory with QTEE. Since
>>>>> QTEE handles shared memory as object, a wrapper is implemented
>>>>> to represent tee_shm as an object. The shared memory identifier,
>>>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>>>
>>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> +/* Mapping information format as expected by QTEE. */
>>>>> +struct qcomtee_mapping_info {
>>>>> +	u64 paddr;
>>>>> +	u64 len;
>>>>> +	u32 perms;
>>>>> +} __packed;
>>>>
>>>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>>>> TZ will always be little-endian, regardless of the host OS
>>>>
>>>
>>> I'm not entirely sure how this point is relevant. As I understand it,
>>> the core that populates this struct is the same one that accesses it in TZ.
>>> Your argument would absolutely make sense if the host and TZ were operating
>>> on different cores with distinct architectures -- such as one being
>>> little-endian and the other big-endian, which is not the case.
>>
>> CONFIG_CPU_BIG_ENDIAN=y exists on arm64
>>
> 
> Or, you are saying we may have a configuration where host is big-endian
> but TZ is little-endian?

I was indeed about to say that.. I believe our tz is always little-endian
but you can run the HLOS of either endianness

Konrad
