Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC30C43458
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 06:37:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BE7EF44F50
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 06:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783665438;
	bh=mBSuDQvKojrT0IOU24GSxHqlrGwicSKqabhsxL5NX+c=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=M+I2h3lhcVhFZtOio4PuRGNhrV+N8PxfDC+o1sML2F0EOTS/lkmyMtyttIggX3dOZ
	 PyqRkx5bEQZGeSnbmB8jR8qQjrXkd9uydBNQ4aWDTja3rDknKw7Mw4IQRDAIUmOdQa
	 viWrFESAWUJIf/fK18DyO7oBifopXiesXGB3ldkkOuDMHowwEz0Pa9H1p67ze4bPlK
	 IHNe+XC5ucJN+TY36gGRc+xVlCy1RKXEYpTaSdg1QBHuNkYsWiAEFKmi8f+7nzxpy4
	 O1NUhCQieMDDZxOPjW5K8faWAw+N/Aei+SZOpbzhVVf3xMVUdliUl7yeONIYJ4siPY
	 oOGij1YIkJ5eQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A960243EE4
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 06:37:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c8ReGJRI;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HccnHLKY;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3mpPr3898698
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 06:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b0Nr6OZmag1QtQ05vPgvrW7VieRyDOuUjbEvIh1Jvgc=; b=c8ReGJRIJHnOBoCQ
	BUV9qTWqMXZjONBtYJq+NVtWvwKj8WuGG2poB05YKc7+ub7qIQA8XuZafK8Xj9Om
	PT5H7M7URW/PsMtO9CvTx6nhOkekEOv8yR/tD80wg1mcK3uSYKQCdnIyp+uxjq32
	pXa/zjYrKI+rlnIaPJMnfLKGDjQskao76Mt90zRLEVqkaHrR7884VTVmxpmzAmv0
	TJ7EJkmrxFepHi8MwxTm4EXLwbH229chN2Bi3mN239lw3K2p8/GEUjYpqj5aE9c9
	VmpLXeLAs6C21sclCmY9e/firfeJow17BJGJvof1h1tEz47FbC8GY5afsI4WUCBB
	oX45ZQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3k5te-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 06:37:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc8bde6318so10912215ad.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 09 Jul 2026 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783665426; x=1784270226; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0Nr6OZmag1QtQ05vPgvrW7VieRyDOuUjbEvIh1Jvgc=;
        b=HccnHLKYcpJlDOkFvgj+0ABYv+mAstS7HFkl11ECd1PskKeVlol6sXoKzeHY4Tlc5q
         5A6D/MeQ4hkJx/98ilH6ijywfNOYLo1TXRt/LI6ufSoGtHhprFUnrtnauOi/o3cTTOGa
         ToRda0da8QSZo2FT77bzwQY7ZGEl2ZTjEWGRCSSxxn1cbFRnQ9bQ/R9uRlD4Mvv1cq+b
         yLQd9YYnBx7ej3gEuO8v0cOitdl5kZqSIBwYsWmfUnUplmWfViuGLU9Wm7cbLpas03rT
         2V0+ojnusMgd8bRGwC+/R18AlG9qfMW6yg8LIr/Uf3V71MuDDFPd9CLoU7Eg8Bwk4SUz
         8qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783665426; x=1784270226;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b0Nr6OZmag1QtQ05vPgvrW7VieRyDOuUjbEvIh1Jvgc=;
        b=AgozcM/gLJLFP0Hh/RTiuprffghlN6ie2w5bwknZvPHdx02k2WUMXpMFCpoJOh2sPr
         FDh6cC5Q53RuXA2z1xiJ7mPFgwO27SXKQwAPYI9HDCSNVg8wf9DkDB+vIoXDug8/LKdq
         4zYFbuOkjfiTcvchqyVpwnMeslLEP2oCHaT2k+E9bvh4J6ydpSR/Z91rlsmdXsyDYiKz
         fATN7srk7MGEza0iTDhJO24W0DCRrBxPevSnNUrxWL/4yl0EFoW2Kzzs1bK6mpoz5Gnp
         jYlG/dXHA7MYpIeSvWn185VB1sG4AsLx6VDdd4+b87dqjmPW5rh7YLXE/FXlqPs25sGE
         0/iw==
X-Forwarded-Encrypted: i=1; AHgh+RoZRqdPciblMuC5YbQN6WPo8dYknA989ksFIpESNj2jdzlac/B9yfc1hxiBgtZSKs8FyEx4rUc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywrs5BaAv0y0r7hq0jgLRz7Tr46AWhNVZFlT7CBDOblzCSgddTP
	P9kK9fPaSiTX6Ms0B4lwmHPhvlS/gP5cOyuPNLo/L/JAW3e7baA6yaeNYRQm7q8eE7/MTUiwlwi
	u9EQHXV48z4A9MMOznh/LGEhBtkf9Z/kzAwmnD3aL3fVDvCUQHEmgicNPucqXrL9yVQvIMmkO
X-Gm-Gg: AfdE7cluSptwcZts3UqtKSsQt+40sD+i4Et5RXijUUG7TZ89FqKq+W9aLqhHLytZ8j5
	IUHj8fI6EWj1xc8GC1PEAqwHAByzMbFcpz8cC7beuM1qKBgIU2jcz9UUmqsPkftLamvCYSSrt6Q
	LcCSsrIPzRIb9YLOtuGJHRwCx5n15t1nZyrK2oMgI8kY+KfZhd032UYwBPlDYOtGAo57TNxFgrd
	HvVk0OZT3h26dBHuYwi72+5Eih717rlQTz/IOembeIVCUMffKwYpGxUruqWNzZX+YG3iEf11Mwa
	AWlX4GI6JXGt7WDM7v8HqA8O9St6WKSqZcOEuzl5zKZZPWhnR5ppEsBlUO6OcyO97vsCqFx0uRy
	QOPmHv48NSw5oVYLQAL/2uCOtiExZhJJqMhYBHdUo
X-Received: by 2002:a17:902:e54e:b0:2c9:e86e:aa0a with SMTP id d9443c01a7336-2ccea274c6amr101741155ad.0.1783665425615;
        Thu, 09 Jul 2026 23:37:05 -0700 (PDT)
X-Received: by 2002:a17:902:e54e:b0:2c9:e86e:aa0a with SMTP id d9443c01a7336-2ccea274c6amr101740955ad.0.1783665425017;
        Thu, 09 Jul 2026 23:37:05 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bdddsm54257415ad.77.2026.07.09.23.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 23:37:04 -0700 (PDT)
Message-ID: <fb1d4954-7c0f-4609-be40-b032876169b8@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 12:07:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tee: qcomtee: Track the object invocation context
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
 <20260707-qcom_uefisecapp_migrate_qcomtee-v1-1-f659cbd5d04c@oss.qualcomm.com>
 <b7c8b25b-374f-40a4-9c6d-bb20ee0cb5c9@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b7c8b25b-374f-40a4-9c6d-bb20ee0cb5c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MSBTYWx0ZWRfXwMlZ6YE7WXZb
 Rzu72wIMZrq6yUH83nbNuvZiRcogjPRJVnBPWYLcjLiUoD4I0D3Y1OkRD5qVd0QYvUBZQhMYYmd
 MeXp56xEfCRQJzd23JEMuTh6QRWuyHH8yuDwxH/9JLIZNT6e8VDXBBhcnKwRWGRSFG9Twjn1nLl
 KkNbFGJT4pdZU9jb20edlRGulsVFZRCZkTyRNj7b7cQ1dpKB5jiw7NFPrrueOrUKwj1j/OdkAu0
 JriBF+D88J6wRm2PovI/54t/PUHGv2ohIPnvBN/n6VpAzc+T+nIFV0O3T0JJf465niU8He1LpE6
 ZY59kF98j+GrTdsvINR6k2BktE3Yp7FT/H3SF5+nvUH7yzlbHfT6rLkwsVP/BU68YoNgWJB+yL8
 0zPzFxSLdbchPc8LZnzFmhF9Kwxj9QeUC5/4YswbX1tvMQ5qXmVrh1B+ZOpYYOPx0AC+IiPrbLN
 kkwbrbQsHsRC+lrVXKw==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a509317 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=-b72njiGIdzoQt0YrOEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MSBTYWx0ZWRfX92OTy/ZDKbHS
 k/o7Fwu2zRIhgjz1n5O/wVq+sBM+iFNTth3WOyv5BU3iwFRTj82OMLeUB7/t5kSpLKH+YTMM5t1
 r0l6d1qmLmMYv5YvZEApUapzDPB0HvI=
X-Proofpoint-GUID: 6EexJB5ffysRsU2GGnkEXRw3EIZIN6zI
X-Proofpoint-ORIG-GUID: 6EexJB5ffysRsU2GGnkEXRw3EIZIN6zI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A960243EE4
X-Spamd-Bar: ----
Message-ID-Hash: YTHDPOGJNAADMEVN2OAP3WAV7EVXSCG4
X-Message-ID-Hash: YTHDPOGJNAADMEVN2OAP3WAV7EVXSCG4
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, jenswi@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YTHDPOGJNAADMEVN2OAP3WAV7EVXSCG4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Amir,

On 7/8/2026 11:31 AM, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 7/7/2026 4:11 PM, Harshal Dev wrote:
>> QCOMTEE needs to distinguish between object invocations arriving from
>> kernel clients and user-space clients in order to correctly marshal
>> UBUF parameters and decide whether certain operations should be permitted.
>>
>> Add a kernel_ctx flag to struct qcomtee_object_invoke_context to track
>> the context of object invocation. Objects invoked from the kernel-space
>> are expected to have the MSB of their 64-bit object-id set to indicate a
>> kernel context, whereas objects invoked from user-space should not set it.
>> To ensure this, we restrict the object-id space of user-space invoked
>> objects to 32-bits. This is in-line with QTEE expectation of 32-bit object
>> ids.
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>>  drivers/tee/qcomtee/call.c           | 24 ++++++++++++++++++++++--
>>  drivers/tee/qcomtee/qcomtee.h        |  6 ++++++
>>  drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
>>  drivers/tee/tee_core.c               |  4 ++++
>>  4 files changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>> index 0efc5646242a..a74a54d67b06 100644
>> --- a/drivers/tee/qcomtee/call.c
>> +++ b/drivers/tee/qcomtee/call.c
>> @@ -397,11 +397,31 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  {
>>  	struct qcomtee_context_data *ctxdata = ctx->data;
>>  	struct qcomtee_object *object;
>> +	bool kernel_ctx = false;
>>  	int i, ret, result;
>>  
>>  	if (qcomtee_params_check(params, arg->num_params))
>>  		return -EINVAL;
>>  
>> +	/* Obtain the invocation context information from the MSB of the object
>> +	 * `id` field.
>> +	 */
>> +	kernel_ctx = QCOMTEE_GET_CLIENT_CTX(arg->id);
>> +	/* User-space identifies a NULL object via a 32-bit TEE_OBJREF_NULL id, whereas
>> +	 * the kernel uses as 64-bit object-id. Hence, we check for a NULL object by
>> +	 * sign-extending the object-id to 64 bits. If user-space is indeed invoking a
>> +	 * NULL object we must extend the object-id to 64-bits from here on so that
>> +	 * QCOMTEE can recognize it.
>> +	 */
>> +	if (!kernel_ctx && ((s64)(s32)arg->id) == TEE_OBJREF_NULL)
>> +		arg->id = TEE_OBJREF_NULL;
> 
> Does it need to be MSB -- why bit 63? the object ID supported by QTEE is 32-bit anyway.
> Let's mask the upper 32-bit and do something like kernel_ctx = !!upper_32_bits(id).
> What do you think?

I agree. Instead of checking for kernel-ctx by right shifting, I can use this approach.
QTEE objects invoked from user-space (including NULL object) will always have their
object-id constrained to lower 32 bits anyway as per PR: https://github.com/quic/quic-teec/pull/27

And for kernel-space invoked QTEE objects, upper 32-bits would be set for NULL object,
and 63rd bit expected to be set as well.

> 
>> +
>> +	/* If the object being invoked is not NULL, drop the MSB from the `id` field to
>> +	 * obtain the actual object-id.
>> +	 */
>> +	if (arg->id != TEE_OBJREF_NULL)
>> +		arg->id = QCOMTEE_SANITIZE_OBJ_ID(arg->id);
>> +
>>  	/* First, handle reserved operations: */
>>  	if (arg->op == QCOMTEE_MSG_OBJECT_OP_RELEASE) {
>>  		del_qtee_object(arg->id, ctxdata);
>> @@ -411,7 +431,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>>  
>>  	/* Otherwise, invoke a QTEE object: */
>>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>> -		qcomtee_object_invoke_ctx_alloc(ctx);
>> +		qcomtee_object_invoke_ctx_alloc(ctx, kernel_ctx);
>>  	if (!oic)
>>  		return -ENOMEM;
>>  
>> @@ -648,7 +668,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>>  	int result;
>>  
>>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>> -		qcomtee_object_invoke_ctx_alloc(ctx);
>> +		qcomtee_object_invoke_ctx_alloc(ctx, true);
>>  	if (!oic)
>>  		return;
>>  
>> diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
>> index f39bf63fd1c2..5d292a2ff83d 100644
>> --- a/drivers/tee/qcomtee/qcomtee.h
>> +++ b/drivers/tee/qcomtee/qcomtee.h
>> @@ -17,6 +17,12 @@
>>  #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
>>  #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
>>  
>> +/* The MSB of the object_id field indicates whether the client is invoking the
>> + * object from user context or kernel context.
>> + */
>> +#define QCOMTEE_GET_CLIENT_CTX(x) (((x) >> 63) & 1U)
>> +#define QCOMTEE_SANITIZE_OBJ_ID(x) ((x) & (BIT(63) - 1))
>> +
>>  /**
>>   * struct qcomtee - Main service struct.
>>   * @teedev: client device.
>> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
>> index 8b4401ecad48..2528d07e4576 100644
>> --- a/drivers/tee/qcomtee/qcomtee_object.h
>> +++ b/drivers/tee/qcomtee/qcomtee_object.h
>> @@ -146,6 +146,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
>>   * struct qcomtee_object_invoke_ctx - QTEE context for object invocation.
>>   * @ctx: TEE context for this invocation.
>>   * @flags: flags for the invocation context.
>> + * @kernel_ctx: flag that indicates this context is owned by a kernel client.
>>   * @errno: error code for the invocation.
>>   * @object: current object invoked in this callback context.
>>   * @u: array of arguments for the current invocation (+1 for ending arg).
>> @@ -158,6 +159,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
>>  struct qcomtee_object_invoke_ctx {
>>  	struct tee_context *ctx;
>>  	unsigned long flags;
>> +	bool kernel_ctx;
>>  	int errno;
>>  
>>  	struct qcomtee_object *object;
>> @@ -172,13 +174,15 @@ struct qcomtee_object_invoke_ctx {
>>  };
>>  
>>  static inline struct qcomtee_object_invoke_ctx *
>> -qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx)
>> +qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx, bool kernel_ctx)
>>  {
>>  	struct qcomtee_object_invoke_ctx *oic;
>>  
>>  	oic = kzalloc_obj(*oic);
>> -	if (oic)
>> +	if (oic) {
>>  		oic->ctx = ctx;
>> +		oic->kernel_ctx = kernel_ctx;
>> +	}
>>  	return oic;
>>  }
>>  
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index ef9642d72672..7f986d7fb47f 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -706,6 +706,10 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
>>  			goto out;
>>  	}
>>  
>> +	/* Userspace object-ids are restricted to 32-bits. */
>> +	if (arg.id > U32_MAX)
>> +		return -EINVAL;
>> +
> 
> This change belongs to tee SS, move it to a separate commit with appropriate message.

Ack.

Regards,
Harshal
> 
>>  	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
>>  	if (rc)
>>  		goto out;
>>
> 
> Regards,
> Amir
> 

