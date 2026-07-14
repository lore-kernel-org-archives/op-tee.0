Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D9BC44507
	for <op-tee@archiver.kernel.org>; Tue, 14 Jul 2026 23:48:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A3F1144FB5
	for <op-tee@archiver.kernel.org>; Tue, 14 Jul 2026 23:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784072895;
	bh=n9AjW65p0a7D6KQPmbrkol4qR1Xm8c7052xAtW+SOos=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=MIoHf8nThQnArxwW6qZQdwKUhpM8VG95vFWDCX56rvfiq7fUB63fF+3Oybk1L5hNo
	 p8JEXBkjvFjawFQX6NHT0FljPIrUgcYrA55PUb+7C0ncvEARAUFp7Jxn50z2DYcuKt
	 sVT4YGKPYMYa6Y9ten3neg7C1dbRm1Za/lpccUM17otTWPqDzv5n83DVWzVLDX5vEQ
	 RpM4C5LwaLOPgl0Rk7VM2BwSKcN7SSuL1mmKg3vbYPLukoATiE/HW1tI0F8UlXnIb3
	 a4vJU8YXWINLDW66ZNJUXp/cB+OOCsQMjCTPhJTU8sIku9a9tZibGhJpUGnyrBb6nB
	 /u2sBYjNA3tew==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 261ED44DAF
	for <op-tee@lists.trustedfirmware.org>; Tue, 14 Jul 2026 23:48:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lRLVL0wv;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UWXLrS0q;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EIwaKa1415374
	for <op-tee@lists.trustedfirmware.org>; Tue, 14 Jul 2026 23:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vn4MUzHPyhlagDYIvwca+AzfFmNytjBwvjVc71GBUkU=; b=lRLVL0wvMySyzkx2
	bm/jqLTqSS3Uj5xno85m35cdJWvZQEdt6WFdfcD6vx01lyPfb5hYagFpz/Rc4ogC
	NM7ivzc0wRoSWg6hgoc+veM8eSeFwsvGDQ1hFWNiB0oSTNaG7/WHUcGKhjytr0am
	eaV5BHEOqHbem4dT0lg64sdIoXJw0/xZZ36taoWAUinC5u/ZlI3eyqNWwI6uVmai
	X4KbXpITyZLnkWFr4AFpfeKtJcCkSsGPyctlwGs+SCCuhEXiEsh3tDBewEWA+Nws
	BvhdoWOHymprYISolLXQK7NYqyLyEGYGQSPPcY/3si82nPpdmrzUbFA07RGzMlf+
	0ydbSw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9ks6e0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 14 Jul 2026 23:48:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab041eced3so5364934a12.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 14 Jul 2026 16:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784072887; x=1784677687; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vn4MUzHPyhlagDYIvwca+AzfFmNytjBwvjVc71GBUkU=;
        b=UWXLrS0qJmDBPC5WEdPngCH+Tb1pl4A42CeS3EM7C4psNc/Ym3211ZkFsuefgj7ZVs
         ZFKj84OgTIQKA7dJ+tE1/omC4KtKh25W84RBBocg/NuwkpxTmMUzZEkjDVJJBJglzsgc
         GZAEn85Dv5pe8yfOP+FVNBb44E7jVRzlaA74W+5+92yj/QF+jw+6Dla2OkeW+9LrUd6d
         MmIHpiZs82xn1E1sPs+aIISo6XHIKDvakdlLhb6w5vTxJ9X/RlSX6hseFZhgSeEZuyow
         jrcTH1gx1WpopereNlRhJINkpEF+EHnHKIFQvoA5VFuEhrovgoAQuwIp+Io6oYneYcCQ
         i/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784072887; x=1784677687;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vn4MUzHPyhlagDYIvwca+AzfFmNytjBwvjVc71GBUkU=;
        b=sacOOm3IR3hIk5hx2+2sNRcjWcsWv4kbZ8/+QFqOmOH8x+A5ymqAtnJR2xcvgwHbO8
         XOFGMZZAO74AQo/ESjOZriC/q0rix0NIjGPlyYcDtqBLFQGiKVusygZo6iN1zruJW5gX
         4vEK1FTjyK9W8iqaJdnCTYk0GECpvOo6w1cRI6chbo3EAzANXB5j1ri+jj57ZrikaDNI
         NUXjlHqcZGH0zZmPR2fRLQfGp0Okik+fxsERhLqOdxVaqmW3cTQhHcsf+Y2ujjfa5wFq
         VAYtl6bhsljGpCOAwFK3L7zNgJM4EVEJPmOMOPxyh4juYsdHUQGEo/n0ZHsDcRlyk0gy
         WqGg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0E9AB9q1ngs7H4Y1wHB8LE6DgY/T8cl3mkK9COmWUMHl+1msX2O2onHPsoFigQ5I7O61CnSw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yytx59BAVVV5Qam5GjtKga8P5OVK+4uRpEQ1IiVgs+kzF1Dg+Yp
	MWneGQskWD6/l3eXxdPaba//HZpFPobm5NxPgSm5tlk/eG44sKhnRgQw+b0QW+/X7GFpkR7FHpK
	Fs2oiYBYtImJS7gze79WNc9S8oz91uI2x6qgdGGPkaHDF6S+5lsMlpKttB70uglovRrcXjNw=
X-Gm-Gg: AfdE7cmmTQkPiE9Pu37kdx/tZfkJvaMxGAtdlJlAWYTFnE5a2cU7jCfdXNTlbVLS/Wu
	M3wUsb1YIrMe+EFmIlKT1BHSFQViwvnrYOk/hJy8/vAYTUsKm1JAKos9Z7BTDj/ne47MhUam5mx
	GZnacmIW797Pnlfh5m0Eos1lMY2CbHMndgwYANTwYjTj5gVU9/W6K9DlsXpwtw3b1vbWZNvnntu
	2iOsLGKl9+Mbngy54+XIALB0tihZLbE0SeKWXUxxJJYDsdC/bmBWyTZ3h3s3VcO5ntw8l36SvU9
	ZjKb6QWCfGgQG7m4wveLfWmdKIRSUwuuBC1B/6AFcnnjLa/eAnutyfkN/Mt+kjGW7DMrb4BKUlS
	hwkKxMClRx+YIK09mbJ7fAHUXekJ9+1tW0P1rCiq4ffc=
X-Received: by 2002:a05:6a20:6f04:b0:3c0:9c19:6592 with SMTP id adf61e73a8af0-3c3576c5a50mr5232421637.76.1784072887390;
        Tue, 14 Jul 2026 16:48:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f04:b0:3c0:9c19:6592 with SMTP id adf61e73a8af0-3c3576c5a50mr5232398637.76.1784072886848;
        Tue, 14 Jul 2026 16:48:06 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.14.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31198cb2b99sm58087377eec.26.2026.07.14.16.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 16:48:06 -0700 (PDT)
Message-ID: <f917eb0f-9c9d-4f30-9c4f-ac3aeddac967@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:47:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tee: qcomtee: Track the object invocation context
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
 <20260707-qcom_uefisecapp_migrate_qcomtee-v1-1-f659cbd5d04c@oss.qualcomm.com>
 <b7c8b25b-374f-40a4-9c6d-bb20ee0cb5c9@oss.qualcomm.com>
 <fb1d4954-7c0f-4609-be40-b032876169b8@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fb1d4954-7c0f-4609-be40-b032876169b8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a56cab8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=1ihhdXzpPjkKEZVMewh6kw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=j_0Qh49M8Pi7-mX27roA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: BqV1xWvSdJkfKg1dAiZoY5Bfjviskn-h
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDI0NiBTYWx0ZWRfX65i5FIMhVJot
 Jn+QmSbvhCPKLxX3kwYPhme/a6Qrhavldb95FaSMnK/NYLcqyhcXCMATki+c7OoYijgGe/c5Uff
 q5UVrDBFDhBxoX+JAZM8sb1dL7WRDu0=
X-Proofpoint-GUID: BqV1xWvSdJkfKg1dAiZoY5Bfjviskn-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDI0NiBTYWx0ZWRfXy7qTmNGQRZ7l
 GLS0ZgvdiEyf+bfmjdrtS0T8OKiLReYxtc+8OLipel3Z42I5XA+RhpnNE2zLK6+Z5NbOPheVUvq
 a3IiY+u1MuzGkPMd7PKCR8Y2Xpz/7wQYuatMORi8/+7eUurEgkzpWZ7qzhAO3BTVFmwhE6Ybahe
 N9zvQVZUPQ28nvpm6oxRQOMt3qciOdmHnVGLh6TWhv1M/2TP3mHc+gZicEKELXlfyIio7BL/wCO
 3EbZSDvD3HZqx9Jrb8TbUkiFDC0TpS+BNe5Nv7hlCw/y38XBFUId9bBT+uhlYRCRv2b9JHyDuGr
 ZRAMQqEyLKb32h4SEq8m6kF6WbKNiwm7L1r86ksmR6IzdC+jIcGxfdwqQJjtZ4/6EkyxIbz2Bj6
 DZGd4C1QnHA+CiJsj4hkUi6i41h5iBqaz4GF53S2YwS8+mdk6kxa3s6B7jRGs0ByJ4eVhDxj0kU
 4taNd2/2xjWQ5i7k9BQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140246
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 261ED44DAF
X-Spamd-Bar: ----
Message-ID-Hash: IKJ7U4HO3XIIVAHPWSBU3TMZUOXY5H44
X-Message-ID-Hash: IKJ7U4HO3XIIVAHPWSBU3TMZUOXY5H44
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, jenswi@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IKJ7U4HO3XIIVAHPWSBU3TMZUOXY5H44/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Harshal,

On 7/10/2026 4:37 PM, Harshal Dev wrote:
> Hi Amir,
> 
> On 7/8/2026 11:31 AM, Amirreza Zarrabi wrote:
>> Hi Harshal,
>>
>> On 7/7/2026 4:11 PM, Harshal Dev wrote:
>>> QCOMTEE needs to distinguish between object invocations arriving from
>>> kernel clients and user-space clients in order to correctly marshal
>>> UBUF parameters and decide whether certain operations should be permitted.
>>>
>>> Add a kernel_ctx flag to struct qcomtee_object_invoke_context to track
>>> the context of object invocation. Objects invoked from the kernel-space
>>> are expected to have the MSB of their 64-bit object-id set to indicate a
>>> kernel context, whereas objects invoked from user-space should not set it.
>>> To ensure this, we restrict the object-id space of user-space invoked
>>> objects to 32-bits. This is in-line with QTEE expectation of 32-bit object
>>> ids.
>>>
>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>> ---
>>>  drivers/tee/qcomtee/call.c           | 24 ++++++++++++++++++++++--
>>>  drivers/tee/qcomtee/qcomtee.h        |  6 ++++++
>>>  drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
>>>  drivers/tee/tee_core.c               |  4 ++++
>>>  4 files changed, 38 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>>> index 0efc5646242a..a74a54d67b06 100644
>>> --- a/drivers/tee/qcomtee/call.c
>>> +++ b/drivers/tee/qcomtee/call.c
>>> @@ -397,11 +397,31 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>>  {
>>>  	struct qcomtee_context_data *ctxdata = ctx->data;
>>>  	struct qcomtee_object *object;
>>> +	bool kernel_ctx = false;
>>>  	int i, ret, result;
>>>  
>>>  	if (qcomtee_params_check(params, arg->num_params))
>>>  		return -EINVAL;
>>>  
>>> +	/* Obtain the invocation context information from the MSB of the object
>>> +	 * `id` field.
>>> +	 */
>>> +	kernel_ctx = QCOMTEE_GET_CLIENT_CTX(arg->id);
>>> +	/* User-space identifies a NULL object via a 32-bit TEE_OBJREF_NULL id, whereas
>>> +	 * the kernel uses as 64-bit object-id. Hence, we check for a NULL object by
>>> +	 * sign-extending the object-id to 64 bits. If user-space is indeed invoking a
>>> +	 * NULL object we must extend the object-id to 64-bits from here on so that
>>> +	 * QCOMTEE can recognize it.
>>> +	 */
>>> +	if (!kernel_ctx && ((s64)(s32)arg->id) == TEE_OBJREF_NULL)
>>> +		arg->id = TEE_OBJREF_NULL;
>>
>> Does it need to be MSB -- why bit 63? the object ID supported by QTEE is 32-bit anyway.
>> Let's mask the upper 32-bit and do something like kernel_ctx = !!upper_32_bits(id).
>> What do you think?
> 
> I agree. Instead of checking for kernel-ctx by right shifting, I can use this approach.
> QTEE objects invoked from user-space (including NULL object) will always have their
> object-id constrained to lower 32 bits anyway as per PR: https://github.com/quic/quic-teec/pull/27
> 
> And for kernel-space invoked QTEE objects, upper 32-bits would be set for NULL object,
> and 63rd bit expected to be set as well.
> 

Re-thinking this, I'm a bit concerned about overloading id while keeping it as a u64,
and then filtering its upper 32 bits in tee_ioctl_object_invoke(). It feels unintuitive,
as it naturally raises the question: if only the lower 32 bits are meaningful,
why is id a `u64` in the first place?

What if we make the caller origin explicit instead, for example:

enum tee_object_invoke_origin {
	TEE_OBJECT_INVOKE_USERSPACE,
	TEE_OBJECT_INVOKE_KERNEL,
};

and then pass it through the backend op:

int (*object_invoke_func)(struct tee_context *ctx,
			  struct tee_ioctl_object_invoke_arg *arg,
			  struct tee_param *param,
			  enum tee_object_invoke_origin origin);

It seems more straightforward and avoids encoding caller-origin metadata into id.
If you are OK, let's do this.

- Amir

>>
>>> +
>>> +	/* If the object being invoked is not NULL, drop the MSB from the `id` field to
>>> +	 * obtain the actual object-id.
>>> +	 */
>>> +	if (arg->id != TEE_OBJREF_NULL)
>>> +		arg->id = QCOMTEE_SANITIZE_OBJ_ID(arg->id);
>>> +
>>>  	/* First, handle reserved operations: */
>>>  	if (arg->op == QCOMTEE_MSG_OBJECT_OP_RELEASE) {
>>>  		del_qtee_object(arg->id, ctxdata);
>>> @@ -411,7 +431,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>>  
>>>  	/* Otherwise, invoke a QTEE object: */
>>>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>>> -		qcomtee_object_invoke_ctx_alloc(ctx);
>>> +		qcomtee_object_invoke_ctx_alloc(ctx, kernel_ctx);
>>>  	if (!oic)
>>>  		return -ENOMEM;
>>>  
>>> @@ -648,7 +668,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>>>  	int result;
>>>  
>>>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>>> -		qcomtee_object_invoke_ctx_alloc(ctx);
>>> +		qcomtee_object_invoke_ctx_alloc(ctx, true);
>>>  	if (!oic)
>>>  		return;
>>>  
>>> diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
>>> index f39bf63fd1c2..5d292a2ff83d 100644
>>> --- a/drivers/tee/qcomtee/qcomtee.h
>>> +++ b/drivers/tee/qcomtee/qcomtee.h
>>> @@ -17,6 +17,12 @@
>>>  #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
>>>  #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
>>>  
>>> +/* The MSB of the object_id field indicates whether the client is invoking the
>>> + * object from user context or kernel context.
>>> + */
>>> +#define QCOMTEE_GET_CLIENT_CTX(x) (((x) >> 63) & 1U)
>>> +#define QCOMTEE_SANITIZE_OBJ_ID(x) ((x) & (BIT(63) - 1))
>>> +
>>>  /**
>>>   * struct qcomtee - Main service struct.
>>>   * @teedev: client device.
>>> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
>>> index 8b4401ecad48..2528d07e4576 100644
>>> --- a/drivers/tee/qcomtee/qcomtee_object.h
>>> +++ b/drivers/tee/qcomtee/qcomtee_object.h
>>> @@ -146,6 +146,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
>>>   * struct qcomtee_object_invoke_ctx - QTEE context for object invocation.
>>>   * @ctx: TEE context for this invocation.
>>>   * @flags: flags for the invocation context.
>>> + * @kernel_ctx: flag that indicates this context is owned by a kernel client.
>>>   * @errno: error code for the invocation.
>>>   * @object: current object invoked in this callback context.
>>>   * @u: array of arguments for the current invocation (+1 for ending arg).
>>> @@ -158,6 +159,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
>>>  struct qcomtee_object_invoke_ctx {
>>>  	struct tee_context *ctx;
>>>  	unsigned long flags;
>>> +	bool kernel_ctx;
>>>  	int errno;
>>>  
>>>  	struct qcomtee_object *object;
>>> @@ -172,13 +174,15 @@ struct qcomtee_object_invoke_ctx {
>>>  };
>>>  
>>>  static inline struct qcomtee_object_invoke_ctx *
>>> -qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx)
>>> +qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx, bool kernel_ctx)
>>>  {
>>>  	struct qcomtee_object_invoke_ctx *oic;
>>>  
>>>  	oic = kzalloc_obj(*oic);
>>> -	if (oic)
>>> +	if (oic) {
>>>  		oic->ctx = ctx;
>>> +		oic->kernel_ctx = kernel_ctx;
>>> +	}
>>>  	return oic;
>>>  }
>>>  
>>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>>> index ef9642d72672..7f986d7fb47f 100644
>>> --- a/drivers/tee/tee_core.c
>>> +++ b/drivers/tee/tee_core.c
>>> @@ -706,6 +706,10 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
>>>  			goto out;
>>>  	}
>>>  
>>> +	/* Userspace object-ids are restricted to 32-bits. */
>>> +	if (arg.id > U32_MAX)
>>> +		return -EINVAL;
>>> +
>>
>> This change belongs to tee SS, move it to a separate commit with appropriate message.
> 
> Ack.
> 
> Regards,
> Harshal
>>
>>>  	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
>>>  	if (rc)
>>>  		goto out;
>>>
>>
>> Regards,
>> Amir
>>
> 

