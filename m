Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C508CA9ED1
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 09:39:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8199C451D6
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791797939;
	bh=aob59RsURu+FUrDkWWq58XPi1H9rODiQexwwefJyNFI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qbZQ/O2d5R9+q13lxXb02rfS2QL2a2+QMeY1OO6iJZk3yCSSd8a70BFLftQd2BV4X
	 RAeo6iGJ8OBY/vtxg0gw1kLnWAj7YPByMItKe/FQv4uJRMSmyudOOANwSHvC/OBWSF
	 o3qsWiG94MTgruaY0MoAzSTfupm5GNMwRk09D0qBNYeQjiVv4edN7D7PYDq+2txm0Z
	 X/Wh6kIawwTfxETYEn/YbLTj5wj7kt64EW5vok3A4i4eZPYocsslL9xwdvxgDVOqGO
	 +maoZBZnyB7R8fsZXEDazUolW+ivfXJRD9NDSv3got3jADU378h9SkTkqCyNuJEJiE
	 Pab4bmxaq3o/Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 581E043EE6
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:38:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8z7xHjA;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=afv2Emev;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8Kcb41592784
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pitDrUWGMmOcfY8ECPjobsbRe6e431atrR7IeBEqY+Q=; b=h8z7xHjAPN5cFzBB
	4XNeAgc1lIToNWRrQOLGn0crzDvty7dptRljOkuQUcDp4PrU5bLgLCZcLqWHh0ZU
	W2oRc7LGV06Gp3LXQlzbcoubX7I8cwF6c7Ku0r5ZXkG5D9bYPVNTG5hv5H0Pgxd8
	PvUAEdHKERkmHcaU4Z4v1MJfWJZhxnfLKezw5BiRcoHLwTKfgQ35quTHpoDe8/32
	oa6JY0w9lr4g0ZVoK9QH8Kms+W+uoenAhn2jYLMuFVt+GrZMC6eh7K9vJC9BnugX
	9K2LnnQzboaWow5OdirYa9NkvmI8/5y+nk1cChWSmq/pV9S8vuowfRJZwWWrtEbq
	/IvBjw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu12cd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:38:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e832c03576so31722735ad.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791797920; x=1792402720; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pitDrUWGMmOcfY8ECPjobsbRe6e431atrR7IeBEqY+Q=;
        b=afv2Emev+Co+GP28DYWItS2lhqTGhiWBYVA16D8tjt9hbkCp6L8mrLXpmmEvJcigta
         KKUeyZPqELfS5wUbbbr7TmEi6g5TL+ilreHuvXEseNEOeqds2fYmAlbFPeY8gXSN8LXn
         j1xlwBRUZX3De1i/J8DtLkBwwRufuvUMKFDdoUqK1+e7kUHQHeXx3w6J4cjte3AgHmrN
         sDn4mpZKQfVmM0UhU1xfE7EPR1Hc84eki6aktk8AvWUHvBXmH37eaDDOzQPXZ7VeJ3Ez
         kEayObcGzCjvCm5Zbi/TuPPZrgC3IP/3yYVk62UnBxF6WnD8LhDRr6KXUXnS+9pKR6MU
         C8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791797920; x=1792402720;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pitDrUWGMmOcfY8ECPjobsbRe6e431atrR7IeBEqY+Q=;
        b=XaMJHXS/3nZo7jRKeEr23FGPVp2T6bCa/0MHjPtbyufgG7d+uJsOYGyywJih/Ql66F
         KzimEPIxEsIwFwulQPXnhdqrUo3aVy4qLWk9MwttNAnk8w04mWPwaEk/ZZ1IQlRTLKT6
         CEmUUOfVUdrT548vh2XW52/gZJ7VHpz19Mxqeke8xWwExFUaBOkbKuTA3ZclTJWy6AVw
         wvBBtZu7HuEvDUqMPwD1CL9TiNOqPbGq1eJ8PfvXDSvUxVkktmc5Qclh3y1033s80PeC
         eKcUVQ6wJBaUbDHbcSS5S6hn2dfqAt8bL5+oo/AyJk+hTguekNAzlLasMwVaTx9gfhgr
         Tpww==
X-Forwarded-Encrypted: i=1; AKwUvByfGvik/OiCMzT3zQ7OHTwxyqDSL4lUDKIE7qYkcMQuzd0me91cH5q4yFAxHKt3PNQD/XT5eMM=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJubFHZ5wg9C+92GV2kikK+sL2gRbGBFk6+nntxzsO2AkWLof2O
	Tl5RrEZIiWk/bIi+6/ZjW3Ev4mC5M3MzxrbqtgPTRSzdIjGGHdhmyc718aRa5sFaRRfCS+Z/6Na
	/lDWWZxKOf6lhEPPYt6Bn04ToLv3jxXG9gI+EmaiufdDx9pQA4We65EcFj2aiNnZ7ICvYWnRH
X-Gm-Gg: AYBFou2S0jQPOQBS43k+nJ6ietzqf3l+pkUhVG3H7ra1EZB1CN0o1w2HxUDDeK6XdMc
	/0hp7Lh/Ucs4iG8CUz8E4LTYB/Hak5LAN9+RPr7vcWyBEBYIR+/19cM3wTdLWqO+sCux5wAZMXa
	pvjSDRXLBddl4IP5V535iKBh0AEboo0I+85ee7PnWN51R/8WOGRqRieDF845xwRQkTbLXv+fiRh
	ypkXq+nfi7ty6nzajbBo+/ZvdRuOUoL3TNHzMK6ooVvVeR7fJ6ymvNeSArPyvhN9Txlsk4w/vbZ
	SbuUlH8XhH04vE8nd/NVtqdAOnhYuNx0nyxdGpuI0gKNwrR/tBqHLea6qE+4X3d/vsaB41vjkIq
	8IKyimYBHPkbL++Ti1jN9e5PzOohKxw==
X-Received: by 2002:a17:902:f789:b0:2e8:3534:eeab with SMTP id d9443c01a7336-2e842aa60c0mr76888015ad.14.1791797919662;
        Mon, 12 Oct 2026 02:38:39 -0700 (PDT)
X-Received: by 2002:a17:902:f789:b0:2e8:3534:eeab with SMTP id d9443c01a7336-2e842aa60c0mr76887735ad.14.1791797919091;
        Mon, 12 Oct 2026 02:38:39 -0700 (PDT)
Received: from [192.168.29.10] ([49.37.155.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0124csm41234105ad.5.2026.10.12.02.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:38:38 -0700 (PDT)
Message-ID: <f7530ce2-ed7c-422e-9b15-cfdbc265c77b@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 15:08:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] tee: qcomtee: Allow object invokes from kernel
 clients
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
 <20261006-qcom_uefisecapp_migrate_qcomtee-v4-3-bf1c8e2a64ab@oss.qualcomm.com>
 <daa0983a-5fc2-462c-92f0-6ad87dfd71de@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <daa0983a-5fc2-462c-92f0-6ad87dfd71de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6accaaa0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ivpbP8R7Mhpy7qfOLL/Q+g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=3dGLg5FSYMxJAeFSFNkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfX84dxYXIK1NJ9
 6ogaszXG5rz2/qCsTN0wr0zcybeFD/uB4XF/bMzfDHbRyBivmP90X7C/FTF1igV3lmggsrWeK/T
 oYMPtl82BsxEHIPcKSvRrY4AfDwyLs5HLp9CnUVi1OPEyPtSbFAg7OV25RzLqM7Z8RdFpV0Dhx4
 yGcrxwblVJB7Mg2Qlqoe4kMpNqwgkZ0QV2yKunh+CWDwMiZ37eiiiKV6i7BCPg8uQ0IWmR2ImtQ
 bzb3SxffadQErcPZt/EUVfd+0jv1FUHKJX93ZDPQX3llFg1RkxagOpyeBehGUVDdh1rR4LDZGJJ
 6cWzBxby2wdjFPf/l7ABOchDf/y92lzPnb1VvlS3iNoVRtUYCXHo8p/k2DYh7C53RI30JW5YMKw
 S1q3tAOmDAtBnWaQqdFqghc29k2rJeb1KBVejVsShjtFmXhWXiJGv3tnZ/4VdicG7K/EuUFzpjF
 PYsiCZyfs/R5b+VcmWA==
X-Proofpoint-ORIG-GUID: IKWrZB6p6npO253AUp3kTEmsiT5Zow00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfXy1sroKCBfiC+
 bPxl+PrGuJ1QcDQzNGGYSoRM8uE5WoEGs4tBspcHDdIDJNApmq6Y8HPhqc7sTOTf57yYDZqehUA
 4r3q7fK0h7mti8KyOLbjwNEspj6b9to=
X-Proofpoint-GUID: IKWrZB6p6npO253AUp3kTEmsiT5Zow00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120038
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	DNSWL_BLOCKED(0.00)[49.37.155.134:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 581E043EE6
X-Spamd-Bar: ----
Message-ID-Hash: 2A7HPKXMBIRJKJS3GLADIMVLEQAPNJCL
X-Message-ID-Hash: 2A7HPKXMBIRJKJS3GLADIMVLEQAPNJCL
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2A7HPKXMBIRJKJS3GLADIMVLEQAPNJCL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Amir,

On 09-10-2026 06:49 am, Amirreza Zarrabi wrote:
> 
> 
> On 10/6/2026 10:33 PM, Harshal Dev wrote:
>> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>
>> QCOMTEE currently treats UBUF parameters as userspace addresses and
>> applies userspace restrictions when invoking the root object. This is
>> not suitable for object invocation requests issued by kernel clients.
>>
>> Use the kernel_ctx flag to distinguish kernel client requests from
>> userspace requests. For kernel contexts, do not mark UBUF parameters as
>> user addresses, and allow permitted root-object operations to proceed
>> without applying the userspace-only checks.
>>
>> This allows in-kernel users of tee_client_object_invoke_func() to issue
>> object invocation requests through the qcomtee backend.
>>
>> Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  drivers/tee/qcomtee/call.c           | 38 ++++++++++++++++++++++++------------
>>  drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
>>  include/linux/tee_drv.h              |  5 ++++-
>>  3 files changed, 32 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>> index 3de54af45719..c97afaa1b4aa 100644
>> --- a/drivers/tee/qcomtee/call.c
>> +++ b/drivers/tee/qcomtee/call.c
>> @@ -193,7 +193,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
>>   * @u: QTEE arguments.
>>   * @params: TEE parameters.
>>   * @num_params: number of elements in the parameter array.
>> - * @ctx: context in which the conversion should happen.
>> + * @oic: context to use for the current invocation.
>>   *
>>   * It assumes @u has at least @num_params + 1 entries and has been initialized
>>   * with %QCOMTEE_ARG_TYPE_INV as &struct qcomtee_arg.type.
>> @@ -202,7 +202,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
>>   */
>>  static int qcomtee_params_to_args(struct qcomtee_arg *u,
>>  				  struct tee_param *params, int num_params,
>> -				  struct tee_context *ctx)
>> +				  struct qcomtee_object_invoke_ctx *oic)
>>  {
>>  	int i;
>>  
>> @@ -210,8 +210,14 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>>  		switch (params[i].attr) {
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
>> -			u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
>> -			u[i].b.uaddr = params[i].u.ubuf.uaddr;
>> +			if (oic->kernel_ctx) {
>> +				u[i].flags = 0;
>> +				u[i].b.addr = params[i].u.ubuf.addr;
>> +			} else {
>> +				u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
>> +				u[i].b.uaddr = params[i].u.ubuf.uaddr;
>> +			}
>> +
>>  			u[i].b.size = params[i].u.ubuf.size;
>>  
>>  			if (params[i].attr ==
>> @@ -223,7 +229,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>>  			break;
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
>>  			u[i].type = QCOMTEE_ARG_TYPE_IO;
>> -			if (qcomtee_objref_to_arg(&u[i], &params[i], ctx))
>> +			if (qcomtee_objref_to_arg(&u[i], &params[i], oic->ctx))
>>  				goto out_failed;
>>  
>>  			break;
>> @@ -260,7 +266,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>>   * @params: TEE parameters.
>>   * @u: QTEE arguments.
>>   * @num_params: number of elements in the parameter array.
>> - * @ctx: context in which the conversion should happen.
>> + * @oic: context to use for the current invocation.
>>   *
>>   * @u should have already been initialized by qcomtee_params_to_args().
>>   * This also represents the end of a QTEE invocation that started with
>> @@ -270,7 +276,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>>   */
>>  static int qcomtee_params_from_args(struct tee_param *params,
>>  				    struct qcomtee_arg *u, int num_params,
>> -				    struct tee_context *ctx)
>> +				    struct qcomtee_object_invoke_ctx *oic)
>>  {
>>  	int i, np;
>>  
>> @@ -288,7 +294,8 @@ static int qcomtee_params_from_args(struct tee_param *params,
>>  			break;
>>  		case QCOMTEE_ARG_TYPE_OO:
>>  			/* TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT */
>> -			if (qcomtee_objref_from_arg(&params[np], &u[np], ctx))
>> +			if (qcomtee_objref_from_arg(&params[np], &u[np],
>> +						    oic->ctx))
>>  				goto out_failed;
>>  
>>  			break;
>> @@ -304,7 +311,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
>>  	/* Undo qcomtee_objref_from_arg(). */
>>  	for (i = 0; i < np; i++) {
>>  		if (params[i].attr == TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT)
>> -			qcomtee_context_del_qtee_object(&params[i], ctx);
>> +			qcomtee_context_del_qtee_object(&params[i], oic->ctx);
>>  	}
>>  
>>  	/* Release any IO and OO objects not processed. */
>> @@ -357,7 +364,8 @@ static int qcomtee_params_check(struct tee_param *params, int num_params)
>>  }
>>  
>>  /* Check if an operation on ROOT_QCOMTEE_OBJECT from userspace is permitted. */
>> -static int qcomtee_root_object_check(u32 op, struct tee_param *params,
>> +static int qcomtee_root_object_check(struct qcomtee_object_invoke_ctx *oic,
>> +				     u32 op, struct tee_param *params,
>>  				     int num_params)
>>  {
>>  	/* Some privileged operations recognized by QTEE. */
>> @@ -366,6 +374,9 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
>>  	    op == QCOMTEE_ROOT_OP_ADCI_SHUTDOWN)
>>  		return -EINVAL;
>>  
>> +	if (oic->kernel_ctx)
>> +		return 0;
>> +
>>  	/*
>>  	 * QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS is to register with QTEE
>>  	 * by passing a credential object as input OBJREF. TEE_OBJREF_NULL as a
>> @@ -430,7 +441,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  	/* Get an object to invoke. */
>>  	if (arg->id == TEE_OBJREF_NULL) {
>>  		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
>> -		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
>> +		if (qcomtee_root_object_check(oic, arg->op, params,
>> +					      arg->num_params))
>>  			return -EINVAL;
>>  
>>  		object = ROOT_QCOMTEE_OBJECT;
>> @@ -438,7 +450,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  		return -EINVAL;
>>  	}
>>  
>> -	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
>> +	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
>>  	if (ret)
>>  		goto out;
>>  
>> @@ -456,7 +468,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  
>>  	if (!result) {
>>  		/* Assume service is UNAVAIL if unable to process the result. */
>> -		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
>> +		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
>>  			result = QCOMTEE_MSG_ERROR_UNAVAIL;
>>  	} else {
>>  		/*
>> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
>> index 5f40617361fc..d3740099fae0 100644
>> --- a/drivers/tee/qcomtee/qcomtee_object.h
>> +++ b/drivers/tee/qcomtee/qcomtee_object.h
>> @@ -113,8 +113,9 @@ struct qcomtee_buffer {
>>   * @b: address and size if the type of argument is a buffer.
>>   * @o: object instance if the type of argument is an object.
>>   *
>> - * &qcomtee_arg.flags only accepts %QCOMTEE_ARG_FLAGS_UADDR for now, which
>> - * states that &qcomtee_arg.b contains a userspace address in uaddr.
>> ++ * If %QCOMTEE_ARG_FLAGS_UADDR is set in &qcomtee_arg.flags then it implies
>> ++ * that &qcomtee_arg.b contains a userspace address in uaddr.
>> ++ * Otherwise, &qcomtee_arg.b contains a kernel address in addr.
> 
> Fix the doc, remove extra `+`, then
>

Ack, many thanks for your careful review.

Regards,
Harshal 
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> - Amir
> 
>>   */
>>  struct qcomtee_arg {
>>  	enum qcomtee_arg_type type;
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index 369c87ad0205..367208210a32 100644
>> --- a/include/linux/tee_drv.h
>> +++ b/include/linux/tee_drv.h
>> @@ -83,7 +83,10 @@ struct tee_param_memref {
>>  };
>>  
>>  struct tee_param_ubuf {
>> -	void __user *uaddr;
>> +	union {
>> +		void *addr;
>> +		void __user *uaddr;
>> +	};
>>  	size_t size;
>>  };
>>  
>>
> 

