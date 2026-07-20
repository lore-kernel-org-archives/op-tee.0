Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67747C44515
	for <op-tee@archiver.kernel.org>; Mon, 20 Jul 2026 10:19:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 898F145197
	for <op-tee@archiver.kernel.org>; Mon, 20 Jul 2026 10:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784542762;
	bh=yapMXRgqm8On8wZD3Y13ylERRbelSnvEypyi9xq1P1o=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=57D4q7bwt14dW48uRDtqRcYt+x2DtgPc0qiBwXZFiQP2FA9wPphGEzPwO35chgt4u
	 MyXhu2GJ1KKVLckjZKQj3aQN0Zxp/JUvCWbtZ4XdY4nDnyhm+vEtyIoxza2dtSFwXa
	 TqyLFporpGQLYvt0lrCoKgbJ/nUq2lyiu+9pcMgFPWcF8NQVnIOKITxzeCkQlAs4Zd
	 EEzB2xnMqw1Ct0Jgk4QLNwMVzdXtP7UGjh1wfDNpAwmjGhjKVQACLB9wxTMGj1ZoEe
	 gyi2sh0olj3hSIrd6A5/if5Nrxr0UzPrpKdeQUAlPi9q0OZuUaTbTuhXXYbJ1/ybwj
	 xqS2IgY09IwAQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6E5B544E1C
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 10:19:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=owE2yGJg;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OEQxcjK5;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K9vlRR2320984
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 10:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O+rneuRae7ccfS7HwBJRtw/KkE2FTct/JS+yPwRVhak=; b=owE2yGJgCDL0e0En
	11/827nlFwSyoMVkyXId2i4zHXzT0Rf5rJUYShV2M4/LGzssxtqJLRGjiLnPGK/z
	G1A0ZzgeAmoCycgIbzVQIwdgYKDGDgQWkb7MTCE3Gt6oCr4FXdOeSEi5rVUyYyEp
	eSGutiGYPBnllu0kcb9cQTAzwivea/VR8k8eBzixtDc/zFOQXo0wFFWXzyovrofl
	fQ3DK7Ei6yWqwTyM/2LVcqTTEED5aX/uhmvd/QcR7rzQTlEOTecwecST/pei+wdD
	5DHDsJ/G65aGOUPiQhIN8gPaAIYSTXuu9wD3zbjGVobquIjorBqKl7Z7Qx+21lsf
	SzOvUQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0kruvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 10:19:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso12592280b3a.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784542754; x=1785147554; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O+rneuRae7ccfS7HwBJRtw/KkE2FTct/JS+yPwRVhak=;
        b=OEQxcjK5/55fkQDmyL91Z1O+PNxIXYFlHyrnIw3iQmZ7ewhsRTawPNlFy57m3oh15B
         mbg0aQmbwGLDGlL/eNZusIBMKxMG1dU+qcAH+fMVBy51IlUv9KfiMLUtSJLXtR60I1l3
         tefGx0cbcb27kOVcihTrubsN7Z22NaewUePsPSiQLk4o3xgnQ7jGlEDbdRsMVXWz6yCF
         bJoUFwNx2fx3cQSQUMSPiUr5VJCBy/dcR4WVq2xRCgAc01blamtCrtO/lbOMsTYNSyWJ
         pLga9vd2EE8zooKRPhPUAb9PndT3Pv2SHSKXDygxYf8Vs+lgUfHwgvK7HV4L2ELW9Kj2
         eWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542754; x=1785147554;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O+rneuRae7ccfS7HwBJRtw/KkE2FTct/JS+yPwRVhak=;
        b=LyYsfTdsNyS+VW/b8BwXcfxc6/BXbsflCL/dfcIQbWmbHD3FsUV3bfqZW4wE2Kp1OX
         CoSrptmh7LQOb2CHIzl9EG3jHgqzArZxFXDO2IlNq2ms72x79sB+cH1jdCCiLANqi7E6
         aJIsVYch0MK8NiYoUmtuF2JX7rAt+J4JAyGsgJHGrznDjA83uCSvwy8MWrHgac61T+FP
         PMBqcl4bWCKfQYep+Cs8jE3R4B32P1a2kaG/Fb9NeNbeevIel1bUCC4vsEHggrFtS1lx
         ZrJg9eW2wWe1rYEHu4nlRlYE/BPe9zTwscyDzI9LUVA2xlyy7DuCrjKWdu5ADObwS7uC
         dwvg==
X-Forwarded-Encrypted: i=1; AHgh+RolbuykMeNIpiTC0BZWW/E3cg8DR7jCSmMEeX8M4s0W/3hAuchR08RDtK6LIY8wn2QPHdNh27E=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy1pWiIbWbCSI8pm9UQVLBPSoIYk42unhb36A66Mu5CEyntGVvb
	KzPGElRYNoMixZGUC31Uukyo1XHaFdH6JXzuO+Asly5Vdkh7pXUGw2f9enNZ8yLD6i96F6xQJdj
	YK6pGrFF7jRzD/06+3HNgJJjmr8gsgXLjr/zPLMtJmVfS1gr4XGZwyy8sDn/jziORlQ3r6oml
X-Gm-Gg: AfdE7clpKinhOHcxSR2bc9j4sPGfujUo/9bgd2AY5A6WfBAZbcLoAE5286ntWeogaXP
	sj9d8yKUXbdnbU8OzT7NSTP8ONpNko1uib3NBY3wlkfAtuQgQJO7zznLElFGQBAcUyRq60MuKOs
	nQ+uCI+HFekeKEaKELGHaSyU8/vsaeOHUhqRm6EwCLPtoefv04ev6a872MT4V/bnsqQPsw337qr
	orZlS7Zr+bdAIX51bg8XuyiaWfJMIbVEubVboLKLtLN1fXE+BfWLfP8fAD27YdUfVVqDMM97uOf
	+WvpR0smIvjRLNe7FwW1rFqSmA9qw4NS+glH9DF1eMRHaYTazzEc+P+zHQcsn2lQDRzJaSwwMPf
	Ki8TiTd+zoyJ4XlYZB5tKF9KOwP8=
X-Received: by 2002:a05:6a00:9093:b0:848:70b4:ebbe with SMTP id d2e1a72fcca58-84c294d4beamr14636009b3a.41.1784542753612;
        Mon, 20 Jul 2026 03:19:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:9093:b0:848:70b4:ebbe with SMTP id d2e1a72fcca58-84c294d4beamr14635983b3a.41.1784542753160;
        Mon, 20 Jul 2026 03:19:13 -0700 (PDT)
Received: from [10.92.203.75] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adfdfe9sm5346784b3a.27.2026.07.20.03.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 03:19:12 -0700 (PDT)
Message-ID: <d1931ed8-57d3-4728-9ea6-0651067c2942@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 15:48:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tee: qcomtee: Track the object invocation context
To: Sumit Garg <sumit.garg@kernel.org>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
 <20260707-qcom_uefisecapp_migrate_qcomtee-v1-1-f659cbd5d04c@oss.qualcomm.com>
 <b7c8b25b-374f-40a4-9c6d-bb20ee0cb5c9@oss.qualcomm.com>
 <fb1d4954-7c0f-4609-be40-b032876169b8@oss.qualcomm.com>
 <f917eb0f-9c9d-4f30-9c4f-ac3aeddac967@oss.qualcomm.com>
 <534f6507-dd46-432b-80cd-87c17e3e0a71@oss.qualcomm.com>
 <alnnK1jVntH-llsA@sumit-xelite>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <alnnK1jVntH-llsA@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iUG5W41XumAiYuDks7oM6KJAFY_JuK8M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNSBTYWx0ZWRfX1yUHkYhuV4Ph
 0qYdXh+b8rCiJHHS/HWGW09VvrRIMSTypC0o0Nb1IyZyXMW/Ed/lc8S7/PQyc+I92hKFc9vU2p9
 UpRC32wCfl6V3yseZF9Sfum2BFuj5zg=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5df622 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=VZT3vSEkKENZW7lRfPUA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNSBTYWx0ZWRfX6J5EbtJRQvZK
 n8Pl4Fy131246jG5LDHLRtgIzwlXvlmQ+Nwt7a35hJmgtKFybFyCilL7LDNiP9t30SIZV4It1yA
 xDh+wjjRvLat+0cXxoaITWhRnnneLwcoivELOo2A5A77qaZ6JMgcqwTBu5D1DPeDFX7u9HT9Jqu
 EWm4PyAZfuXM4Oc5o18LdEfB4Yp+wYNgHNzCF0GzNlOPWD63rR1XV/PmAalhJP+JgXZXJzhH8Xv
 DwXURPyqcYtO47/eeWthlmueQvtz1oYSalSnfyPp5ZTf0lKV0s+uKZnZ/4uSGIKViugnL7xuNci
 TxZnzbeQY4Tm7nwN1pcSuVUpGEGoSoy+YuM/0OCO/chOmU8VArT+AGogSOiCihT+FzKwV9bg0la
 GbcGQusb+0eeory3KgkF/1pQhb0N0GI35lkR0mXNgKUDTKHT2ElG4mGHJMTNAOwRWu0mBBGazM4
 SttF1xrq31XnFQ+I7aw==
X-Proofpoint-GUID: iUG5W41XumAiYuDks7oM6KJAFY_JuK8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200115
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6E5B544E1C
X-Spamd-Bar: ------
Message-ID-Hash: JFVEHH5L7GYLU25MFILU7CGGXPNFG6FK
X-Message-ID-Hash: JFVEHH5L7GYLU25MFILU7CGGXPNFG6FK
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>, jenswi@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JFVEHH5L7GYLU25MFILU7CGGXPNFG6FK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Sumit,

On 17-07-2026 01:56 pm, Sumit Garg wrote:
> On Thu, Jul 16, 2026 at 12:28:25PM +0530, Harshal Dev wrote:
>> Hi Amir,
>>
>> On 7/15/2026 5:17 AM, Amirreza Zarrabi wrote:
>>> Hi Harshal,
>>>
>>> On 7/10/2026 4:37 PM, Harshal Dev wrote:
>>>> Hi Amir,
>>>>
>>>> On 7/8/2026 11:31 AM, Amirreza Zarrabi wrote:
>>>>> Hi Harshal,
>>>>>
>>>>> On 7/7/2026 4:11 PM, Harshal Dev wrote:
>>>>>> QCOMTEE needs to distinguish between object invocations arriving from
>>>>>> kernel clients and user-space clients in order to correctly marshal
>>>>>> UBUF parameters and decide whether certain operations should be permitted.
>>>>>>
>>>>>> Add a kernel_ctx flag to struct qcomtee_object_invoke_context to track
>>>>>> the context of object invocation. Objects invoked from the kernel-space
>>>>>> are expected to have the MSB of their 64-bit object-id set to indicate a
>>>>>> kernel context, whereas objects invoked from user-space should not set it.
>>>>>> To ensure this, we restrict the object-id space of user-space invoked
>>>>>> objects to 32-bits. This is in-line with QTEE expectation of 32-bit object
>>>>>> ids.
>>>>>>
>>>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>>>>> ---
>>>>>>  drivers/tee/qcomtee/call.c           | 24 ++++++++++++++++++++++--
>>>>>>  drivers/tee/qcomtee/qcomtee.h        |  6 ++++++
>>>>>>  drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
>>>>>>  drivers/tee/tee_core.c               |  4 ++++
>>>>>>  4 files changed, 38 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>>>>>> index 0efc5646242a..a74a54d67b06 100644
>>>>>> --- a/drivers/tee/qcomtee/call.c
>>>>>> +++ b/drivers/tee/qcomtee/call.c
>>>>>> @@ -397,11 +397,31 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>>>>>  {
>>>>>>  	struct qcomtee_context_data *ctxdata = ctx->data;
>>>>>>  	struct qcomtee_object *object;
>>>>>> +	bool kernel_ctx = false;
>>>>>>  	int i, ret, result;
>>>>>>  
>>>>>>  	if (qcomtee_params_check(params, arg->num_params))
>>>>>>  		return -EINVAL;
>>>>>>  
>>>>>> +	/* Obtain the invocation context information from the MSB of the object
>>>>>> +	 * `id` field.
>>>>>> +	 */
>>>>>> +	kernel_ctx = QCOMTEE_GET_CLIENT_CTX(arg->id);
>>>>>> +	/* User-space identifies a NULL object via a 32-bit TEE_OBJREF_NULL id, whereas
>>>>>> +	 * the kernel uses as 64-bit object-id. Hence, we check for a NULL object by
>>>>>> +	 * sign-extending the object-id to 64 bits. If user-space is indeed invoking a
>>>>>> +	 * NULL object we must extend the object-id to 64-bits from here on so that
>>>>>> +	 * QCOMTEE can recognize it.
>>>>>> +	 */
>>>>>> +	if (!kernel_ctx && ((s64)(s32)arg->id) == TEE_OBJREF_NULL)
>>>>>> +		arg->id = TEE_OBJREF_NULL;
>>>>>
>>>>> Does it need to be MSB -- why bit 63? the object ID supported by QTEE is 32-bit anyway.
>>>>> Let's mask the upper 32-bit and do something like kernel_ctx = !!upper_32_bits(id).
>>>>> What do you think?
>>>>
>>>> I agree. Instead of checking for kernel-ctx by right shifting, I can use this approach.
>>>> QTEE objects invoked from user-space (including NULL object) will always have their
>>>> object-id constrained to lower 32 bits anyway as per PR: https://github.com/quic/quic-teec/pull/27
>>>>
>>>> And for kernel-space invoked QTEE objects, upper 32-bits would be set for NULL object,
>>>> and 63rd bit expected to be set as well.
>>>>
>>>
>>> Re-thinking this, I'm a bit concerned about overloading id while keeping it as a u64,
>>> and then filtering its upper 32 bits in tee_ioctl_object_invoke(). It feels unintuitive,
>>> as it naturally raises the question: if only the lower 32 bits are meaningful,
>>> why is id a `u64` in the first place?
>>>
>>> What if we make the caller origin explicit instead, for example:
>>>
>>> enum tee_object_invoke_origin {
>>> 	TEE_OBJECT_INVOKE_USERSPACE,
>>> 	TEE_OBJECT_INVOKE_KERNEL,
>>> };
>>>
>>> and then pass it through the backend op:
>>>
>>> int (*object_invoke_func)(struct tee_context *ctx,
>>> 			  struct tee_ioctl_object_invoke_arg *arg,
>>> 			  struct tee_param *param,
>>> 			  enum tee_object_invoke_origin origin);
>>>
>>> It seems more straightforward and avoids encoding caller-origin metadata into id.
>>> If you are OK, let's do this.
>>>
>>
>> Honestly, this approach makes everything a lot more easier, since we don't need complex
>> bit manipulation in back-end to filter the upper 32 bits and handle the case of
>> TEE_OBJREF_NULL. I can also then drop the PR: https://github.com/quic/quic-teec/pull/27
>>
>> I am fine with updating this callback and calling it with TEE_OBJECT_INVOKE_USERSPACE from
>> https://elixir.bootlin.com/linux/v7.1/source/drivers/tee/tee_core.c#L704
>> and TEE_OBJECT_INVOKE_KERNEL from the newly introduced tee_client_object_invoke_func().
>>
>> But is there any special reason for choosing an enum over a boolean value here? Are we planning
>> to extend the enum later to introduce any other context information?
> 
> I think enum is just better to provide enough info for the flag.
>

Ack.

>>
>> I am fine with this approach. I hope the OP-TEE maintainers @Sumit are fine as well with the
>> new parameter addition in the callback.
> 
> That's fine with me if it simplifies the object handling for you folks.

Ack, thank you for your review, I will spin a v2 based on this feedback.

Regards,
Harshal

> 
> -Sumit

