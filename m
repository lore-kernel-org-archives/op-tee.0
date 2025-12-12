Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF923D4335B
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 01:08:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3259745451
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 01:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765501681;
	bh=Zj4KWzcuPVXWcd7yrzODmHnEtjqPEnSa0AjQGBuGcXU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OoIOzh+1bRkJ/8tdpxS5v3RUqjYVwdYS3ksLBrv9REuFwjF9bM/jpdDu5Ny2BHEd4
	 UIe9G8xXEkzt9PvkdymCx9MFwbijwT7NyGYXqg4aFSVZ/3+K07aFO/pBoyhhP/EDsg
	 EcEeQ9usmzBgGCq8lnI2ARlM46NnIk/thUuzLgj9H1Wi79BqFRWMpisiugkKZC60d8
	 2qY+mrtV8uvJcD+YgovZrkrqsMLFcIQioyCkpVdRmopuXAgkBEaoObXtPUtuNUchVz
	 p3KD8imMTTKubVK0gWzgj1TwRe3kChwOeeenidmUwdkwboyD0k0JaWsev1sdlwfrxG
	 +U4NRewQIl5TA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2241E41BC3
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Dec 2025 01:07:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K4LD12ps;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FSJP8wUq;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBJdUKS2945430
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Dec 2025 01:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	10ueGSyugo/WYPVzD3Q3Vaygr+j+IoUQX6LPatNlMzo=; b=K4LD12psoTKNY1/j
	ZhjxLb2ZiY8i4Ef+U2gYWbtdbBSL24AvFVqVOCY1ACLoI52YYJyj1vRidL5JPjJp
	UjBxHp/2CdJlDEgBGHYaZMrDUPRfEJ45DTNWaj0b/cSJRONb/SjoqxG/ildu8y5X
	AP+9oZr71QXUsuXt9sFvmlLHiwkCc0CNrmTDc82qmPlrfSD67TaxiZpYMJgCnYsH
	B3eY8OiuG2LJDRVFBZpNG5tY0zamhKW4lYC8y0+i7KPBkmQLfbnaC/wnMPpSy5my
	h0sUEDjMSGKNsGbSkC9SFpPwv2FSH4oxA9wAS4KF1jHSlTtgavnliwTsHX8efvtU
	/T7O4w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b04a2gq30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Dec 2025 01:07:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29846a9efa5so10687465ad.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765501665; x=1766106465; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=10ueGSyugo/WYPVzD3Q3Vaygr+j+IoUQX6LPatNlMzo=;
        b=FSJP8wUqcF6NFfuWEirQiQqpek1WG3kM0r+8tCya+tyMsqLJmdQDTI9M0hnH1axG0c
         p75d53IEl7h3ep5mglJ9qL91u/SJKZ6uuNpHe71ofpXNvwRPI+3yXb5ZSrePHqNwUE9E
         fuOfn5TSpu50kH6xDfkyqrvuqHHqTBDucpmjme/sk+VZqmDTPRX4c2Fm1K77URmv7Bzm
         v6n1OH0n1Njnw73VTGiHpG2o/7r+1ooQlgS/esGIahMG4bjT6h1KNUIpqXeu2CHe5Mj1
         2hNFuInVOqc/k9a+EYrTuUNo17tBqVF6BjPGzXHS6SMAidhJYxJB5/sQgZKsu4IinS7J
         ia2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765501665; x=1766106465;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10ueGSyugo/WYPVzD3Q3Vaygr+j+IoUQX6LPatNlMzo=;
        b=IHkSmwF2CWxJxb9W8TO0CWXvOOq83Et6Uh4ZxH34WkKgZi0FCh8zKEmA1NNfLYHUg3
         whd7Cb2VgXTu2+2ZHfebBsfR0HuQc7lIG1SaqNRCjI67hb3GbLnwuS0CmHfQhe10p91U
         HM2BEMausQdEzFTXB3qULFVNtr5icPnbYBNn2nBjWXt0EZYNMWdYi0QIJ8UuRL8IG8hg
         /NBCOIWlSesig5B7mrMPGZpfQ+ULCmJflBpXghdHWAk929fqjVeV+GYO9WBjV7NsQ3Y9
         jt0QEC4TFq1wm2IE4QWsT7KtNVmmmqRfffUOg0UNQOYF91MUMy15wRAutIrh8ufSHKz4
         fNSw==
X-Forwarded-Encrypted: i=1; AJvYcCUfZz37xoIGBa+PNIdsGaSdv11pjXvtZoXnbaRMV5/fXVUhkau2eho5AzrwDimxYNVE+QN3flI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzfWgIh/568+xS8K57C1ZhlZiavqxCaX5dBp9HY8r8iVf1hpDwP
	i1uaiaLZ4eTqibS+rc73Al8468r+obSMfqBvuiwXk8cuclxc6i6YaMazA0Ly+UDYsM65EGWZr7v
	9+FJcAQ8R2H/31sxTrsLUW6XlYqd9+//Lcfb/g5kVEyGQFLks+CW3I0wrcRURdE+NGChG9i6G
X-Gm-Gg: AY/fxX6SelW1Yavwva/mofT4CVefB8XnE8F7ZHjUipD1nZOtVsm+vvNLstn0K/5yXbS
	rMPnPzum2/7hrY7rXgE+4ogmmC0EeroAC+GGm/6rAsE9OG/f4hhZpqLKv60LC1a+V6bWGiMCM0B
	Rm+KrHMLWnWqxJuQ7Z5z6tRdNUOgHkbni0AhvvaX5O1N1ow6U1dNoYuSSfL5m7edVLr0pCUr1V9
	Dlvlr2CZhe7fUMJzqAnu4YFcGWrj4WFQja1zJTltWlH9t3w22RtTFA+Fsr1+yGovJfwcNWwdXEJ
	gHMRDv7lPBV60GR1YakgDnsalfGv/pX77xOgPml7gECxH1yUlS1vYCbs2i76ZHI0ppVaTV3ocAA
	HzlP466BdTGBPOOC2YlNJM7h9PvTTOEo4pJiC/ZaU0LUKEEXo1eLHeSLle4wOidrrNbA=
X-Received: by 2002:a17:902:da47:b0:29f:13d2:1c67 with SMTP id d9443c01a7336-29f26d0d376mr1749895ad.16.1765501665191;
        Thu, 11 Dec 2025 17:07:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6HxE3bSHkAkVRNh5aCi/K05N4p4UDTA8EHhvxZgkMkg7jO0dlxCo8D1XzA0t0iHl5cid5wA==
X-Received: by 2002:a17:902:da47:b0:29f:13d2:1c67 with SMTP id d9443c01a7336-29f26d0d376mr1749655ad.16.1765501664666;
        Thu, 11 Dec 2025 17:07:44 -0800 (PST)
Received: from [10.200.7.150] (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016ac2sm35606645ad.49.2025.12.11.17.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 17:07:44 -0800 (PST)
Message-ID: <b29c97cd-cade-40ef-8e6d-d164b1d16059@oss.qualcomm.com>
Date: Fri, 12 Dec 2025 02:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
To: Sumit Garg <sumit.garg@kernel.org>
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
 <aTtn-x0hh18V7n7J@sumit-X1>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aTtn-x0hh18V7n7J@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LrBHYLMk6SlLtgtktT5V5GL5fYlOiZ0I
X-Authority-Analysis: v=2.4 cv=PZPyRyhd c=1 sm=1 tr=0 ts=693b6ae2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=gC7H+NTNV8TiHuUi9Bl0tg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rtcvcfkpwUOWW_TkcukA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: LrBHYLMk6SlLtgtktT5V5GL5fYlOiZ0I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDAwNyBTYWx0ZWRfX8L4FSMcPSceR
 W1omFNLuJfh9qJB5TeM3AAIAne6ZrMcO+KlIsawJPolHlR3Pw5NErnrKxPz5PVAGN8aPEinfyar
 LhCYwWVervh8wX12I1Iyv15f/jImhLTkPtxowTGkgKyugndD5yuB8+7u9fOwHGVgzElqYh8e3QQ
 OiojVEZ2oIn60yGsSTVcJ/4KsRvRLo5Gt6ssGxNMo9kdYEtQyM+yNlSY+gz/1MwB+VID3TdLmYK
 eT4Iz1sphn8iX2F+hLcRAYDdM++vvvfhtM1xuL+evl+2GLWllhOTfc+IvXzpNYDO1En4IvPC3x9
 J8moGHjHOeQQzfd1rfZKAl83wsuw1wXbAtmOh2+yDPaE4hvB6ixBE2Zcr+KYkh/IoZKPWQHpuIu
 poz2SHxXQy4qtknEZxaNhuq+5rUTJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512120007
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2241E41BC3
Message-ID-Hash: WKZGTWJALHQFWHLHUGBD6RCN4XJISCJ5
X-Message-ID-Hash: WKZGTWJALHQFWHLHUGBD6RCN4XJISCJ5
X-MailFrom: krzysztof.kozlowski@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WKZGTWJALHQFWHLHUGBD6RCN4XJISCJ5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

On 12/12/2025 01:55, Sumit Garg wrote:
> On Mon, Dec 08, 2025 at 03:08:45AM +0100, Krzysztof Kozlowski wrote:
>> Initializing automatic __free variables to NULL without need (e.g.
>> branches with different allocations), followed by actual allocation is
>> in contrary to explicit coding rules guiding cleanup.h:
>>
>> "Given that the "__free(...) = NULL" pattern for variables defined at
>> the top of the function poses this potential interdependency problem the
>> recommendation is to always define and assign variables in one statement
>> and not group variable definitions at the top of the function when
>> __free() is used."
>>
>> Code does not have a bug, but is less readable and uses discouraged
>> coding practice, so fix that by moving declaration to the place of
>> assignment.
> 
> Okay I see but..
> 
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  drivers/tee/qcomtee/call.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>> index 65f9140d4e1f..8f8830f0df26 100644
>> --- a/drivers/tee/qcomtee/call.c
>> +++ b/drivers/tee/qcomtee/call.c
>> @@ -395,9 +395,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  				 struct tee_ioctl_object_invoke_arg *arg,
>>  				 struct tee_param *params)
>>  {
>> -	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
>>  	struct qcomtee_context_data *ctxdata = ctx->data;
>> -	struct qcomtee_arg *u __free(kfree) = NULL;
>>  	struct qcomtee_object *object;
>>  	int i, ret, result;
>>  
>> @@ -412,12 +410,14 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  	}
>>  
>>  	/* Otherwise, invoke a QTEE object: */
>> -	oic = qcomtee_object_invoke_ctx_alloc(ctx);
>> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>> +		qcomtee_object_invoke_ctx_alloc(ctx);
>>  	if (!oic)
>>  		return -ENOMEM;
>>  
>>  	/* +1 for ending QCOMTEE_ARG_TYPE_INV. */
>> -	u = kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
>> +	struct qcomtee_arg *u __free(kfree) = kcalloc(arg->num_params + 1, sizeof(*u),
>> +						      GFP_KERNEL);
> 
> ..this makes the code less readable with variable declarations floating

Which is intentional.

> within the function. I would rather favor to not use the cleanup.h construct
> but use explicit kfree() invocations instead like it's done in all other
> allocations in the TEE subsystem.

Sure, fair. I just don't get why introducing cleanup.h without actually
accepting its explicitly documented style...


Best regards,
Krzysztof
