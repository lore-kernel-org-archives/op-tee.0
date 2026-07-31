Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EC7C55167
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 07:39:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9B59544DED
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 07:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785483552;
	bh=OTZ19yLxcY8uvvUft7nojYrgOpQqdDEeKhZjM5NNkHk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rp/NI/fEvnage9MzBGHi9y7b7MyXvHGBdstz2Bp++kPoGnqJIVnSrUvEaD4L0lykP
	 8RQD6SLQfV8ipQ7oUXJPBA5uq+rBAdq2gncbacr1R3jSQZ9t9AUjHOQTWRB5KrXk/b
	 kI5MM1IygH+rhCeKCRzrGCzeF/Z1HrQyXpFGxcn+IFh9nYX/StrmmuT4Db1XT+OYaD
	 M+lX1Sb1FGmGhBaDYIJ0Gw9aNOBwEMetZcXm0qIRZuNU5SU3CPQUFhjySHmwt5HuSt
	 V/+GghSYXHFysi2PGZ2TbVnVrPBlE7YggZc5am73mnWSeb3Zlvmd9zMuq/vLj3EPF2
	 ecrR6zZJtI0dA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2DD0543E08
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 07:39:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SV61PbbR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WxAHvw/P;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7PeKF3812025
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 07:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VEq5ATevycqqov2TOMzsilA5PZHZMekVW67cJb1VJv0=; b=SV61PbbRL639M+wX
	PLNIsUlo/57ZG4F/OJeskiKaI52ZTWl++mVDIcEe8mLM8wXC/7BK+pLwj0DNK01G
	WBuXquQAHw8fjUh0KqPSHnNm5HU8MbtG+VpKBQANJCgdG3i0oPN3UTfcSp/RlfaY
	z1FIbOlxrayTjCh/QfIixe4INQITRvFWBPYgpRJLCkE7YQsqCZkyJC60k/S4BeQg
	pmCqZX4wbG8LADE9DZB2MFEAijsj2iCBmWxM1y7YfbLR5PbL7fhYlW7hVygvsn55
	XvKinkIKfY8Ee2X31XhMu0SnJL3l3E+gA0O9w8YjwGmQwGTCPGY0b2fJpGUThDs+
	FLrGrA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frqabg1fg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 07:39:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8488ac68185so2065996b3a.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785483543; x=1786088343; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VEq5ATevycqqov2TOMzsilA5PZHZMekVW67cJb1VJv0=;
        b=WxAHvw/PNLN0p5NtfXlp8l0HDpswEJstPNjsUWUwneYYUoyK8A7my1u9Wz22RXnRl6
         Eij1im1S0FRV+sGLqDaP9a1haGMu7pGVj72CvRybFfXLT35nlQS9PVYq/GDx2dr1wowI
         JuIHP8ojSo8CveUlpoeUPcABDvOEJSjKtiePa3xl9lfHe17FWhwk8AKtbdFSX9B2mlHc
         f02UsRuJtSy3zkjWY7sU4wm6w0r8cdiPxiRkvhxvd3HlwTnDl5W5wU2nx18K3PHGiguF
         i4xV31R8lWuyO/U+wZ2q4iOkgbF3fChiQV9DKQp/x1y1RqmqpC722mtyEzNxASzYgsAg
         IIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785483543; x=1786088343;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VEq5ATevycqqov2TOMzsilA5PZHZMekVW67cJb1VJv0=;
        b=iZuy/8jW3Ma6+OhkqJqwFeIerAWi/Zhc7SHvUiv7vDib84suvNSDAgK/UVDA3fXA2N
         z1HhajSnXFwZKdQSKIOJjh0NjwffQUxo2HEV0bl5JXt0ARiJCRD1bJ6HtYPnsdf0ou5a
         cpnXCVa6uTDlXv+zp2P2HaXNNHb3IE77HEPWwEz2L/6XRgQqYm/ZET/VRt+zIYC4HXKn
         en3sZVpFHaO/QENdDBJ8sX/2IxtaGnIYmgmcjRNdCsBBe6WiXtlwzKJp7dotf7y6H+4R
         r1FXvVx9eJIIzHShXqlmyyLVLUgakga8TRwtoi7BHuwnYJaPDTBa0lS3pif13MWUOwHa
         8jFw==
X-Forwarded-Encrypted: i=1; AHgh+RoNaZF6qOh/2DJqNtLKeeeuj0iMQuzVuB0Gc/zhCqO0INhpe219Bq0cibKjBJK2u1r9u7zRsjw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw/Kk0dpDHVu8Yw/jIH7VAUF2z8WvkU4ywrIk/GKG4oMd5Evvsn
	bTEZk+3/62SmxVUOYsM2QTcLTP5G0cNJ4OjOdV1wBQqHs48UyGirXkpDq6eaN+7ye1Gh91kRtJ7
	ekzg43aN9kprAZ1WBUnD1zAdLFH1VSEPSRV1AI7AEZ+i6gr4pH/nNMcBPyLRA68TZJXrTm9EH
X-Gm-Gg: AR+sD129ejC17AIdjdd9YEinH/eFTuy76R9O+TMQnYlgSqiLPoKc93tmtNBJ+PURCnA
	DtpcC9nxjSoQpBxuijz04Au0si3vD6X01AT+kgvWRi22x3/JuHVpFT77Ssg3JgKltkbkHDNy7X5
	QHG2A5pwlLjVB3MuI/WmqRG0f8AH26PRiw2qYH8R86ioRy+Jo84Cgt0zQVXfgEPAr1CO7UxvSX1
	HVa2qSUE4ET+343Dm0jjEWbKJc1c97WQs3DX+G0OzQivzFSntKRQL0aDa9lhyeD4CLM3vecyVYG
	GV64kbLi+iuDI6z2d5EjsmGpe1zd3BntdAD8N9kN7v8klz7yus0Vpa6AyprfZJs2qLbqc0OS5Rt
	ZPFB0GvHYd6bryc0IPRIAwLiKvVo=
X-Received: by 2002:a05:6a00:180b:b0:845:e9e8:645c with SMTP id d2e1a72fcca58-84ed6d29c96mr857764b3a.6.1785483543106;
        Fri, 31 Jul 2026 00:39:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:180b:b0:845:e9e8:645c with SMTP id d2e1a72fcca58-84ed6d29c96mr857736b3a.6.1785483542640;
        Fri, 31 Jul 2026 00:39:02 -0700 (PDT)
Received: from [192.168.1.6] ([182.77.67.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29f31dsm83830b3a.36.2026.07.31.00.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 00:39:01 -0700 (PDT)
Message-ID: <e21db7e9-7cdf-409b-b6c8-268a8d3b9d04@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 13:08:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] tee: qcomtee: Allow object invokes from kernel
 clients
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <20260722-qcom_uefisecapp_migrate_qcomtee-v2-3-b8a8fcbe4211@oss.qualcomm.com>
 <ac5760cc-a4ab-4fe1-9962-6b6890de4f36@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <ac5760cc-a4ab-4fe1-9962-6b6890de4f36@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BN+DalQG c=1 sm=1 tr=0 ts=6a6c5117 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=mrmDAJacfjHp5PIfN2e9YA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=We5QyOu1FPZmSiEcj6oA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MyBTYWx0ZWRfX0IFIiDBfU7Nr
 ykEBwzD9hdnRmhj9+/snijNJx/gP03ffuYvP4CALVGdbYHw17C2iPbWLzIBvyq/h5FHk1hkmzrE
 CZwL1q3Wn8R2DGPZnbJ/NO23S7SpsCs=
X-Proofpoint-ORIG-GUID: QV1SoLP8pdlgtaR34ZBcddhJu0pLRiyT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MyBTYWx0ZWRfX69ifx0rJChNm
 YVBw5sSG3uPHw3ehswu7X4FY3uje3qyV1T4VzVyqTgiZ7W2ry2uKdp9kzrEpOrRfX6j3evsi0iB
 rxzXSsMIffGmdpyaJ6fjUQfFG9s3hS94fOcBewNGTLzSm/Q5thRX/cO/EezLPtXJctgwxyldvvF
 po2f7UrBLWg8Fo2lO4HKiPiKkLan9iA0Uq2c7oe+ZRq/MLDWUcjMOKsjcAw9GBVbmObyDDouKIR
 Q/ZPNbZvmEGrwS/1PL+llKA0hCKP6SUEXovsTaDo9LNq2O2+7eTZDrVY5XrAcOqF1eR3oFfmaOi
 33pc6KTslievdiOkCPw+zuWw6OZ9Y/xM2fB4Qj5AioANlWqZSCUt20uGCDGFr2NyFbBEJpRxSxM
 68ugOv8acaheXsn1KdUhx2u0P+PcwMRAXpGthhot13fA8kEMRabNEpBfBpsoFsJHixia4mFT+AO
 oxUXiG+g6ep6iIvnx0Q==
X-Proofpoint-GUID: QV1SoLP8pdlgtaR34ZBcddhJu0pLRiyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received];
	DNSWL_BLOCKED(0.00)[182.77.67.166:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2DD0543E08
X-Spamd-Bar: ------
Message-ID-Hash: VIN4CG5G7FI3ZGKMHI4RRE7JM2MMB7PE
X-Message-ID-Hash: VIN4CG5G7FI3ZGKMHI4RRE7JM2MMB7PE
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VIN4CG5G7FI3ZGKMHI4RRE7JM2MMB7PE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Amir,

On 29-07-2026 12:36 pm, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 7/22/2026 4:59 PM, Harshal Dev wrote:
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
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  drivers/tee/qcomtee/call.c           | 34 +++++++++++++++++++++++-----------
>>  drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
>>  include/linux/tee_drv.h              |  5 ++++-
>>  3 files changed, 30 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>> index 03d33b118f6d..c1bba5fbfa3e 100644
>> --- a/drivers/tee/qcomtee/call.c
>> +++ b/drivers/tee/qcomtee/call.c
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
>> +			u[i].flags = oic->kernel_ctx ? 0 :
>> +				QCOMTEE_ARG_FLAGS_UADDR;
>> +
>> +			if (u[i].flags && QCOMTEE_ARG_FLAGS_UADDR)
>> +				u[i].b.uaddr = params[i].u.ubuf.uaddr;
>> +			else
>> +				u[i].b.addr = params[i].u.ubuf.addr;
>> +
> 
> it is & not &&.
> Rather than ?:, can you have single if and update both flags and addr/uaddr.
>

Whoops, thank you for catching this. Ack, I will make this change.

Regards,
Harshal 
> - Amir
> 
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
>> @@ -429,7 +440,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  	/* Get an object to invoke. */
>>  	if (arg->id == TEE_OBJREF_NULL) {
>>  		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
>> -		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
>> +		if (qcomtee_root_object_check(oic, arg->op, params,
>> +					      arg->num_params))
>>  			return -EINVAL;
>>  
>>  		object = ROOT_QCOMTEE_OBJECT;
>> @@ -437,7 +449,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  		return -EINVAL;
>>  	}
>>  
>> -	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
>> +	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
>>  	if (ret)
>>  		goto out;
>>  
>> @@ -455,7 +467,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  
>>  	if (!result) {
>>  		/* Assume service is UNAVAIL if unable to process the result. */
>> -		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
>> +		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
>>  			result = QCOMTEE_MSG_ERROR_UNAVAIL;
>>  	} else {
>>  		/*
>> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
>> index 2528d07e4576..7bd6e23b038c 100644
>> --- a/drivers/tee/qcomtee/qcomtee_object.h
>> +++ b/drivers/tee/qcomtee/qcomtee_object.h
>> @@ -112,8 +112,9 @@ struct qcomtee_buffer {
>>   * @b: address and size if the type of argument is a buffer.
>>   * @o: object instance if the type of argument is an object.
>>   *
>> - * &qcomtee_arg.flags only accepts %QCOMTEE_ARG_FLAGS_UADDR for now, which
>> - * states that &qcomtee_arg.b contains a userspace address in uaddr.
>> ++ * If %QCOMTEE_ARG_FLAGS_UADDR is set in &qcomtee_arg.flags then it implies
>> ++ * that &qcomtee_arg.b contains a userspace address in uaddr.
>> ++ * Otherwise, &qcomtee_arg.b contains a kernel address in addr.
>>   */
>>  struct qcomtee_arg {
>>  	enum qcomtee_arg_type type;
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index ca99c6b747a8..71d0536db60e 100644
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

