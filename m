Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9EBC44501
	for <op-tee@archiver.kernel.org>; Thu, 16 Jul 2026 06:58:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 83CE14509F
	for <op-tee@archiver.kernel.org>; Thu, 16 Jul 2026 06:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784185120;
	bh=Le2kQtLtcTq0r7YycUPeNXvXOv4DHeZ0LD+/2xd4OJk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AfwaR4CmtmpgNRM5Uz34T+K4xR3szrLG8fKVUhO2egmRJMaaRBO7yQugkqbFsUx6M
	 xP7b/mO5Bt8Gi5QbaR3oEf/zwhuvu7XNQPKq4rUkwrcwmHSH8wXoDEwelKfoygzamw
	 wdgcS7uHUERU+/6B06aII49iGRbjhVG3nefmjm/MoPw0HflDGp2ZcSaW5mNStbNQ4/
	 aNKS8VAhZqn38vk415pxo4dtEwu6XPi3+2JAqQtY7CZ/wxfLgcefzLA2sDyXWhp5mY
	 TFTgYji0xv0ZOPs2oXZeQZrmrFBhadwKBIaVYWWe3pXz2fPkQz93N9L7SbscqkIeTp
	 soDa6HoJusmkA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 14CBF44D57
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 06:58:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pu4gpwUe;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e2DoSZ3o;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3xEDP1557300
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 06:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y7z1jMqsSUwbIfrOHd7oWQ3crOjJumF30rM1jmgLfv0=; b=pu4gpwUePU6RQ7Em
	/37ThlckS5ZvFqebpC91IUebNAUi9ObgIU9d2CwNRXHsc8gTAsXiFRcDRRj6vQpd
	3odGlA4AXxsUocCPAs2r6nuCB0q7yHxXHkp/vDDc12WBEhNkgnVMYXaU2ebo3Mz0
	qvV+67doD/UDkIUL7YC1yRug0Irl8tcxJNwYhv3rUImheVItF06uT+BJoB9G/SYs
	F0/oSm6EgcrVpbkFJBrxszbm2qBjb7u/JbDXHULf/B7waBZOzHo2A2yv7oufJg2+
	zr4Q0pdT9rs+zkMskGv2pVw6ohwYZPnl5hZL3fm9+jpdt8xYfTe9FE41RPT8H03U
	TSFZ1Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqjfqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 06:58:32 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8486ffba174so10632539b3a.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 23:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784185111; x=1784789911; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y7z1jMqsSUwbIfrOHd7oWQ3crOjJumF30rM1jmgLfv0=;
        b=e2DoSZ3oS8udxVMMsEGybibG9LQRXz01Aml4lkup3bXMxAzf1aOa8eYeaJPXryKIkD
         6oYGgE8Qbo0uf13RIRqbdXRdYG3RPmmoafswUKLlc2gdDCeu2FFGlyYD0PUeQ6d4Xpb3
         pdUA2/ONN2mFzeGWA90Yu7FYDCA06S6dzahEOkJsmV/6huCblV4QCykBhQOmIVdr508E
         9bfwBPw+X2v1M24ITT3YnK6uxPT90kYgkWL1Ph4S8mBjgyIyWpffhNZf0sap1K3c+DOX
         HpT6wu7IJPf6HbOkjyKBkd5fxRdSEhK7TNkHfoCIDjh9CfTpJdOt86BbpT3GEviBaqsx
         qevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185111; x=1784789911;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y7z1jMqsSUwbIfrOHd7oWQ3crOjJumF30rM1jmgLfv0=;
        b=YCQ94rWzh7qHN7KO5kVV+iMIjBqGB1mr+8/CgHEoHiSYsLEcnpArDNZeQ6ckF9jBKW
         WAHbTJ4jB3nxsFPeq8sNFgXvnDgrTwhwtF6tI0sGB5jMGt5JitMlxiJygOltkv7Wyph/
         unFaPq7rPv2Prq9YnUcpc0B9dV4dt+iKQ/auHI4fze79v4a45gBH2PzSSrOf3wlPRBMC
         o+EczNyxB6F97o6AvOTtC/EW37UW94nvaDvCYke5jU+sEetAOZOr9JLFRozn5ttDakgA
         tCXM8neH0XlkxU9zoV12LrBRVC9mwy8pJ0U3myU6d24yoKklvcdNcWwjEV8OsX0nRSxG
         wPVw==
X-Forwarded-Encrypted: i=1; AHgh+RrXCS0kvgjti/2yv/fUWtByTrhl+s47h5WUU7pTAKc6bTTv1xmE2HCFRCdammAbtxu1KtZuLGE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxdBKKSCOwptdnjBphjKTEUh/NIXXXGXS6+xwkELdCV0eOmUNQ9
	Mak52tkhF0WgtH/rO/wvEOBFmkqwV0bq7FkI+JKYJyl+q5WzTcgf4NrM0yQF5GIlA9BSmJHoa0P
	KtgP4P/SC5PQQ8VL/EROP7GvEkgSbZoIgiGqJIJvHl0/kLe7t0WrvAHcL6sK7N38Iuda+dHo6
X-Gm-Gg: AfdE7ckMGqymFmwfBgAvM+XFwN/j3+FdnGTUVZ08VAbQlGyRSlsOI9twGvr9A4aUVKi
	TKlsBu7wKWibi34/YW+ys/DekHm7VgkqAPcwwQoWyk7/QZFJEUIsixPec6F6vaHAmSp5GlYUZVM
	DwajqFcEcQfNWZactthXhxJXdO8TsuusFtde9HLcBsB43qjn9mAZZVn63/RFRhQGO68MEkN+hQa
	n5FPZSV937ukl6icYVvUXFjAVEe0SPtBHVtUleXE2lfmqs6l4SoDNolFr7ezJ0aWy8eygdUPrHI
	oSteTQHA1+tLfwLuVz3A9aolLFcTAWUmayjprqufK6rXm545F6fWSJ927V/E5pnyGniPDxW+h8Z
	dRJhDp4XObqPbYR8h4dBhAGOWOic=
X-Received: by 2002:a05:6a00:8a15:b0:84c:11d2:8ad2 with SMTP id d2e1a72fcca58-84c11d29919mr374769b3a.19.1784185111310;
        Wed, 15 Jul 2026 23:58:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:8a15:b0:84c:11d2:8ad2 with SMTP id d2e1a72fcca58-84c11d29919mr374745b3a.19.1784185110802;
        Wed, 15 Jul 2026 23:58:30 -0700 (PDT)
Received: from [10.92.174.90] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238f75sm4382727b3a.9.2026.07.15.23.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 23:58:30 -0700 (PDT)
Message-ID: <534f6507-dd46-432b-80cd-87c17e3e0a71@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 12:28:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tee: qcomtee: Track the object invocation context
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
 <20260707-qcom_uefisecapp_migrate_qcomtee-v1-1-f659cbd5d04c@oss.qualcomm.com>
 <b7c8b25b-374f-40a4-9c6d-bb20ee0cb5c9@oss.qualcomm.com>
 <fb1d4954-7c0f-4609-be40-b032876169b8@oss.qualcomm.com>
 <f917eb0f-9c9d-4f30-9c4f-ac3aeddac967@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f917eb0f-9c9d-4f30-9c4f-ac3aeddac967@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a588118 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=KopdRG5eK05-lo_pIREA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA3MCBTYWx0ZWRfXyfM/LQ2i896g
 ik39KI+QIWRqaWdFyEwVu5pavY6CA7I6iPBJNOTvl/hUtR3xTHsJyDpgvaivNXzn4ODm5PTETcS
 qwfelNMyti5igcOZnHXmcI9HrAuvsq8=
X-Proofpoint-ORIG-GUID: Nhgi30Ui6hR7-dWzALWqTRnzeacw8V_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA3MCBTYWx0ZWRfXy2ZO3PonGjV3
 OLTmkBHbTRQCOmjotLiiaNhwAHVskmgka+t7LB30dkQrmo3Oy7nV30I7DTIgoZGEovHuqT/GWMq
 2vYkBWRJ9o6n1G5i5vJXhJEpKbSTo+K0+GkDLGsPNsA2e/27LP+P6iOs5+3tj+4oM/6krLQG0zN
 5jKQBMSTpTYKnlFr5VfgiykLJz+YGKQdEejA0Z47g4qY9SSVNDy8X87Ob7vaKeg5kqVIr5pYLea
 JPEgs8KTgVdw4A/rXUH5gSexLSJjav52hWKDaMcdAHibYGeqEcwjUmA+qJvNPzIkBMpSatqoGCu
 pV6lOhtWETwa+TzUr4c1Gb/976B60gbBf5XVyDlp1IjbxiPvWdpD7j85un8HNXKKFyTAgLJg1Po
 w9vA0MepbFv+vBH1TPmV903XBACg38xk/PynStGWQaBve+iILxiVOToX61n4n+9GQjVEkiA9X7W
 PnompLmVFyliZ3/rQkg==
X-Proofpoint-GUID: Nhgi30Ui6hR7-dWzALWqTRnzeacw8V_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160070
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 14CBF44D57
X-Spamd-Bar: ------
Message-ID-Hash: EA2LNAYGK4V25DXV6YHMJBCBN2ZBNXXK
X-Message-ID-Hash: EA2LNAYGK4V25DXV6YHMJBCBN2ZBNXXK
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>, jenswi@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EA2LNAYGK4V25DXV6YHMJBCBN2ZBNXXK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Amir,

On 7/15/2026 5:17 AM, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 7/10/2026 4:37 PM, Harshal Dev wrote:
>> Hi Amir,
>>
>> On 7/8/2026 11:31 AM, Amirreza Zarrabi wrote:
>>> Hi Harshal,
>>>
>>> On 7/7/2026 4:11 PM, Harshal Dev wrote:
>>>> QCOMTEE needs to distinguish between object invocations arriving from
>>>> kernel clients and user-space clients in order to correctly marshal
>>>> UBUF parameters and decide whether certain operations should be permitted.
>>>>
>>>> Add a kernel_ctx flag to struct qcomtee_object_invoke_context to track
>>>> the context of object invocation. Objects invoked from the kernel-space
>>>> are expected to have the MSB of their 64-bit object-id set to indicate a
>>>> kernel context, whereas objects invoked from user-space should not set it.
>>>> To ensure this, we restrict the object-id space of user-space invoked
>>>> objects to 32-bits. This is in-line with QTEE expectation of 32-bit object
>>>> ids.
>>>>
>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>>> ---
>>>>  drivers/tee/qcomtee/call.c           | 24 ++++++++++++++++++++++--
>>>>  drivers/tee/qcomtee/qcomtee.h        |  6 ++++++
>>>>  drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
>>>>  drivers/tee/tee_core.c               |  4 ++++
>>>>  4 files changed, 38 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>>>> index 0efc5646242a..a74a54d67b06 100644
>>>> --- a/drivers/tee/qcomtee/call.c
>>>> +++ b/drivers/tee/qcomtee/call.c
>>>> @@ -397,11 +397,31 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>>>  {
>>>>  	struct qcomtee_context_data *ctxdata = ctx->data;
>>>>  	struct qcomtee_object *object;
>>>> +	bool kernel_ctx = false;
>>>>  	int i, ret, result;
>>>>  
>>>>  	if (qcomtee_params_check(params, arg->num_params))
>>>>  		return -EINVAL;
>>>>  
>>>> +	/* Obtain the invocation context information from the MSB of the object
>>>> +	 * `id` field.
>>>> +	 */
>>>> +	kernel_ctx = QCOMTEE_GET_CLIENT_CTX(arg->id);
>>>> +	/* User-space identifies a NULL object via a 32-bit TEE_OBJREF_NULL id, whereas
>>>> +	 * the kernel uses as 64-bit object-id. Hence, we check for a NULL object by
>>>> +	 * sign-extending the object-id to 64 bits. If user-space is indeed invoking a
>>>> +	 * NULL object we must extend the object-id to 64-bits from here on so that
>>>> +	 * QCOMTEE can recognize it.
>>>> +	 */
>>>> +	if (!kernel_ctx && ((s64)(s32)arg->id) == TEE_OBJREF_NULL)
>>>> +		arg->id = TEE_OBJREF_NULL;
>>>
>>> Does it need to be MSB -- why bit 63? the object ID supported by QTEE is 32-bit anyway.
>>> Let's mask the upper 32-bit and do something like kernel_ctx = !!upper_32_bits(id).
>>> What do you think?
>>
>> I agree. Instead of checking for kernel-ctx by right shifting, I can use this approach.
>> QTEE objects invoked from user-space (including NULL object) will always have their
>> object-id constrained to lower 32 bits anyway as per PR: https://github.com/quic/quic-teec/pull/27
>>
>> And for kernel-space invoked QTEE objects, upper 32-bits would be set for NULL object,
>> and 63rd bit expected to be set as well.
>>
> 
> Re-thinking this, I'm a bit concerned about overloading id while keeping it as a u64,
> and then filtering its upper 32 bits in tee_ioctl_object_invoke(). It feels unintuitive,
> as it naturally raises the question: if only the lower 32 bits are meaningful,
> why is id a `u64` in the first place?
> 
> What if we make the caller origin explicit instead, for example:
> 
> enum tee_object_invoke_origin {
> 	TEE_OBJECT_INVOKE_USERSPACE,
> 	TEE_OBJECT_INVOKE_KERNEL,
> };
> 
> and then pass it through the backend op:
> 
> int (*object_invoke_func)(struct tee_context *ctx,
> 			  struct tee_ioctl_object_invoke_arg *arg,
> 			  struct tee_param *param,
> 			  enum tee_object_invoke_origin origin);
> 
> It seems more straightforward and avoids encoding caller-origin metadata into id.
> If you are OK, let's do this.
>

Honestly, this approach makes everything a lot more easier, since we don't need complex
bit manipulation in back-end to filter the upper 32 bits and handle the case of
TEE_OBJREF_NULL. I can also then drop the PR: https://github.com/quic/quic-teec/pull/27

I am fine with updating this callback and calling it with TEE_OBJECT_INVOKE_USERSPACE from
https://elixir.bootlin.com/linux/v7.1/source/drivers/tee/tee_core.c#L704
and TEE_OBJECT_INVOKE_KERNEL from the newly introduced tee_client_object_invoke_func().

But is there any special reason for choosing an enum over a boolean value here? Are we planning
to extend the enum later to introduce any other context information?

I am fine with this approach. I hope the OP-TEE maintainers @Sumit are fine as well with the
new parameter addition in the callback.

Regards,
Harshal 
> - Amir
> 
>>>
>>>> +
>>>> +	/* If the object being invoked is not NULL, drop the MSB from the `id` field to
>>>> +	 * obtain the actual object-id.
>>>> +	 */
>>>> +	if (arg->id != TEE_OBJREF_NULL)
>>>> +		arg->id = QCOMTEE_SANITIZE_OBJ_ID(arg->id);
>>>> +
>>>>  	/* First, handle reserved operations: */
>>>>  	if (arg->op == QCOMTEE_MSG_OBJECT_OP_RELEASE) {
>>>>  		del_qtee_object(arg->id, ctxdata);
>>>> @@ -411,7 +431,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>>>  
>>>>  	/* Otherwise, invoke a QTEE object: */
>>>>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>>>> -		qcomtee_object_invoke_ctx_alloc(ctx);
>>>> +		qcomtee_object_invoke_ctx_alloc(ctx, kernel_ctx);
>>>>  	if (!oic)
>>>>  		return -ENOMEM;
>>>>  
>>>> @@ -648,7 +668,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>>>>  	int result;
>>>>  
>>>>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>>>> -		qcomtee_object_invoke_ctx_alloc(ctx);
>>>> +		qcomtee_object_invoke_ctx_alloc(ctx, true);
>>>>  	if (!oic)
>>>>  		return;
>>>>  
>>>> diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
>>>> index f39bf63fd1c2..5d292a2ff83d 100644
>>>> --- a/drivers/tee/qcomtee/qcomtee.h
>>>> +++ b/drivers/tee/qcomtee/qcomtee.h
>>>> @@ -17,6 +17,12 @@
>>>>  #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
>>>>  #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
>>>>  
>>>> +/* The MSB of the object_id field indicates whether the client is invoking the
>>>> + * object from user context or kernel context.
>>>> + */
>>>> +#define QCOMTEE_GET_CLIENT_CTX(x) (((x) >> 63) & 1U)
>>>> +#define QCOMTEE_SANITIZE_OBJ_ID(x) ((x) & (BIT(63) - 1))
>>>> +
>>>>  /**
>>>>   * struct qcomtee - Main service struct.
>>>>   * @teedev: client device.
>>>> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
>>>> index 8b4401ecad48..2528d07e4576 100644
>>>> --- a/drivers/tee/qcomtee/qcomtee_object.h
>>>> +++ b/drivers/tee/qcomtee/qcomtee_object.h
>>>> @@ -146,6 +146,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
>>>>   * struct qcomtee_object_invoke_ctx - QTEE context for object invocation.
>>>>   * @ctx: TEE context for this invocation.
>>>>   * @flags: flags for the invocation context.
>>>> + * @kernel_ctx: flag that indicates this context is owned by a kernel client.
>>>>   * @errno: error code for the invocation.
>>>>   * @object: current object invoked in this callback context.
>>>>   * @u: array of arguments for the current invocation (+1 for ending arg).
>>>> @@ -158,6 +159,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
>>>>  struct qcomtee_object_invoke_ctx {
>>>>  	struct tee_context *ctx;
>>>>  	unsigned long flags;
>>>> +	bool kernel_ctx;
>>>>  	int errno;
>>>>  
>>>>  	struct qcomtee_object *object;
>>>> @@ -172,13 +174,15 @@ struct qcomtee_object_invoke_ctx {
>>>>  };
>>>>  
>>>>  static inline struct qcomtee_object_invoke_ctx *
>>>> -qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx)
>>>> +qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx, bool kernel_ctx)
>>>>  {
>>>>  	struct qcomtee_object_invoke_ctx *oic;
>>>>  
>>>>  	oic = kzalloc_obj(*oic);
>>>> -	if (oic)
>>>> +	if (oic) {
>>>>  		oic->ctx = ctx;
>>>> +		oic->kernel_ctx = kernel_ctx;
>>>> +	}
>>>>  	return oic;
>>>>  }
>>>>  
>>>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>>>> index ef9642d72672..7f986d7fb47f 100644
>>>> --- a/drivers/tee/tee_core.c
>>>> +++ b/drivers/tee/tee_core.c
>>>> @@ -706,6 +706,10 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
>>>>  			goto out;
>>>>  	}
>>>>  
>>>> +	/* Userspace object-ids are restricted to 32-bits. */
>>>> +	if (arg.id > U32_MAX)
>>>> +		return -EINVAL;
>>>> +
>>>
>>> This change belongs to tee SS, move it to a separate commit with appropriate message.
>>
>> Ack.
>>
>> Regards,
>> Harshal
>>>
>>>>  	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
>>>>  	if (rc)
>>>>  		goto out;
>>>>
>>>
>>> Regards,
>>> Amir
>>>
>>
> 

