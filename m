Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C565FC43458
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 06:52:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0A8EE450C2
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 06:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783666359;
	bh=Mv9GgaDQNtRYGWTm1gQ1mOi3EDQMpCPvxhm+2f/VXS4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xq50oY/Kj6KodzmSJMw7ufRguRNsTXS/gJJ6G40XKhVg+NRtePINxCqzdtRqALz1g
	 6+y7jhgJTQhZ/r3JJ6KqeIAk3NYtgFdQ/I/GePbmciHkWjCNpG94TXkEEsy4B+g5Jd
	 CjH3cIiYImVkiIjDPueyjEfTPRNpNykNWIN/UjuRSTK7wjtWeTV6vtJBHX1uJevxOq
	 CdNoDxPBtpDbsiIBP72U5v1ORpRDYfw1mi2PNSXJcI4SbN4R2Gc/PDhmzUlwLb1kI1
	 LKGIlm9TpCNNx8JmzcSVxJir/0j9z4a+0+YPSHp4NDeuCNXH1zE+oJi9Qsq+ovbka1
	 90JQFnfJjAB1g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8584443259
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 06:52:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nQFGASQK;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZFEhx97N;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3nSAX3803809
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 06:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XrgIQqUK3QvZGUscE0xgRqyYIXIAIug38pWr4S569hs=; b=nQFGASQKFBt5JKz2
	a0cvyXcYY9LWmx1+NIh3qLQSYp21vAnfq+np9JYotZ4qZR8FbQ7ZbPZl2MTJy9kD
	IQnDoUN4Rhgf8dap/5aakFzTBh6Yq3nLjtWA8FC/YQcWmgpHZwcPSQQSsHhfTNmp
	LjfN6uGP6aKbkGncNX7fnMyH8wv34Gasti5E8Fj8JqKbGi8/w4F2OVg1eLwhDuMO
	tISQMv4dEt4AQ/HdL2xzDItKViuRWz531CHz5HbTJzhaGLhMRpcoRRruiHwNFfaV
	QAO1GRA38gy+LT/4xB0j8OtNZj1/5KgkDHeJ4v0HltiMuB5FMozc4FOXby0N2JRP
	yC64gg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mtxty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 06:52:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-381250979d5so832094a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 09 Jul 2026 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783666351; x=1784271151; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrgIQqUK3QvZGUscE0xgRqyYIXIAIug38pWr4S569hs=;
        b=ZFEhx97NT+ejwIh34DEcUk6q2f/t48a7cXs/WEsd8njgyWUM5bhJQ4L6esieQ4E871
         lMt3wc43bmV5NusqbydFbxbQnCOsWP6bp5jRtRvuUi09R1RyVcmKcLfZNMaNrbbCFdsa
         qwgYM3VYAqaFTNx5xeI/ye1s7bMsT/rKEDSRnWtiLSj6kbBza4llUSN/AR1E5O/+HsZu
         +ZAsvF38sYm+CuYiZu97FODeOAs5vK237o7LYMIDI+AjexX1Fur2aYgaEbsup/hBf5aR
         8yeLO7aOLdSkkrEN2hUYJcE/7ubKt0bQIO3/gcMxHVL/9rCh57yBuvj5kM6ODku9nC91
         wcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783666351; x=1784271151;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrgIQqUK3QvZGUscE0xgRqyYIXIAIug38pWr4S569hs=;
        b=ru4KKoAr1RIdsBWxIuzB7HHfvkcp5NcinrnVt/ICk5NMah/DP27FIbnfXus2tiyq1p
         u07pG+80QI1FnZug2vcq3sJ/gRnTG6baMksZdWAyoMJ/C4QI0FZHCRAFCJnGPwaFzumz
         NCEm/BgT6JbVEP+nC7IbNFPRo/gOzBY8DbyXVJAbIKloz7UwltGgd0lQukwuhA2GN88g
         A/dHsDkd3QoDmPm2de68RosDdkMVgfzA4BGWLbSGHFqbnxkKCzU4+3QwgZhmQ1rJM+8o
         1VGJEWTnErdcn7axvhNcjwGSRVQvj1+CrMWT8ZadLF4Pbd+53nIISEw50veOpqQAHI9m
         8ciQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpt/2lQ+fbDVQ+GHaiQ/2rjPnSW/ju3iixPaZu66ravn64cKZTQHD6cYmiOOQFJiMcv1Q7aYE0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz9cwsCBpNK3Usz6m4UZNg/3nOY0xasM9eUhUzZCdS/irz47Mr5
	pubw5rzwqrmHxPvYomywxgBVq9ZtMha16gVQdzviFnIZwr07UxyIV2tLLIh/RtzjW82T3ZJhUXP
	Jrv2hNuKhS4XDwLMk/Pgw1WAazx6158mhSJeGDDYL9/gq2ZqGV4ZCYAwpqtQiDotmiPgjcEzK
X-Gm-Gg: AfdE7clll4pN8As7JtUEOo/W2GNogP3eXUcIqey4Mv32L0pbtqOS7FPVCIwTwEkBrKL
	kBgx/KyImkpzeNRTmcvtmmDm1WCLloxUvLYPSz34IeaL+c2LhTtwmNLoMz17ujiV15uknhAMfMu
	7NIS4HX2kQHM6KR1WPgRtttBLB0u531bPnQo0ofNHOQ052w8EmLn18wRSj8nfXQnqXb0QPCbKuh
	xUfRWNcaGNVitT4AJV0S5p3W1B044k8BqzcbEof7X7slcP7AbaqwsiUt9guOfaotqHULTlxM6M3
	DaUwll7Sa486t527LWCZUjAEvPY6fo6neSArt5rxiwPZoMSeelauqYjNRVKJXrOo3Mb4y2NRl5r
	RMr7mPjX6/nOocH4dkY74kwSgyMIcvo39kNNlplER
X-Received: by 2002:a17:903:41c9:b0:2cc:dacc:fe27 with SMTP id d9443c01a7336-2ccea45ab1fmr102817175ad.30.1783666350594;
        Thu, 09 Jul 2026 23:52:30 -0700 (PDT)
X-Received: by 2002:a17:903:41c9:b0:2cc:dacc:fe27 with SMTP id d9443c01a7336-2ccea45ab1fmr102816995ad.30.1783666350060;
        Thu, 09 Jul 2026 23:52:30 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm55577545ad.15.2026.07.09.23.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 23:52:29 -0700 (PDT)
Message-ID: <dad25802-2a26-490b-9488-650d5f78b018@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 12:22:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] tee: Add kernel client object invoke helper
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
 <20260707-qcom_uefisecapp_migrate_qcomtee-v1-2-f659cbd5d04c@oss.qualcomm.com>
 <651db8ad-ff57-4369-8401-f51bb7ea46f5@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <651db8ad-ff57-4369-8401-f51bb7ea46f5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: t-9h1PmqcOIn8PVXMsDcqoi-BYhJdpPD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MyBTYWx0ZWRfX9GyYo/qDeOzU
 8AVr8kDuHZofmQMUkJ5ieoAhC9butmJbrwbwogWozhwNv3/ic9wQ0E7dF1FuZoLWAr61t17DnaM
 xgiz7suDDEYndG/obCU6vKi4NJ8+t0o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MyBTYWx0ZWRfX1o726MY7cbwm
 PsvzvOQTaHGp+VX61KOPrDA9IxNVUGYfKrD+WSwOJdIy4h9FO6GU53biCdj19p9KzOz3CgWrEWG
 aOEUaSlz5hbyi4cSevD1DBoLCVDBOKFayHg7Z4VT/j1APUjqNTaBZ9fHMuECjjiaFxLvvfPAcgp
 S41LyvMUTEl/ksyffa0/4B7iNktOiFUA/QCUEaMMIYzGl5BLFR03gtvDzZaKfQTPTRy3kTfAzEG
 CeUoOwTsupwTkRghemOc/D0aNbALERsXmHtRuH1Yxrl1C4U2T+0W/LlDDtzh3ehao5/jAJlqdwT
 RV9e2uqUBGuwX0b8dlyOQvE7hJAnduJ5mX6NTX2TbiIfiD4KNXoO8dpGtRD2fWQ1dEUviVNjG7j
 W1LaFT93NQtdIpy6OUDRSY6UVS1G11+J5+o9WCFW+Mw1+YXqe9/IC8DjR42j11UgUg/c8m9f+ZA
 4mWzMF2lOX+XzFdx4Kg==
X-Proofpoint-GUID: t-9h1PmqcOIn8PVXMsDcqoi-BYhJdpPD
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a5096af cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=1nvLbgvQa2DmmGW0PDoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100063
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,205.220.180.131:from,209.85.216.72:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8584443259
X-Spamd-Bar: ----
Message-ID-Hash: YMO7A5YGGO5CZZB42IE5HKS2MGTYIZRC
X-Message-ID-Hash: YMO7A5YGGO5CZZB42IE5HKS2MGTYIZRC
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, jenswi@kernel.org, Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YMO7A5YGGO5CZZB42IE5HKS2MGTYIZRC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Amir,

On 7/8/2026 11:59 AM, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 7/7/2026 4:11 PM, Harshal Dev wrote:
>> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>
>> Kernel clients can open a TEE context and invoke regular TA commands
>> through tee_client_invoke_func(). However, there is currently no
>> equivalent helper for invoking TEE objects.
>>
>> Add tee_client_object_invoke_func() as a kernel client API for issuing
>> object invocation requests. The helper checks that the backend provides
>> object_invoke_func() before setting the MSB of the object-id and forwarding
>> the request. The MSB of the object-id informs the TEE backend that the
>> object is invoked from a kernel context.
>>
>> This allows TEE backends that support privileged object-based calls from
>> the kernel-space.
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>>  drivers/tee/tee_core.c  | 13 +++++++++++++
>>  include/linux/tee_drv.h | 13 +++++++++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 7f986d7fb47f..0783802fd010 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -1413,6 +1413,19 @@ int tee_client_invoke_func(struct tee_context *ctx,
>>  }
>>  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>>  
>> +int tee_client_object_invoke_func(struct tee_context *ctx,
>> +				  struct tee_ioctl_object_invoke_arg *arg,
>> +				  struct tee_param *param)
>> +{
>> +	if (!ctx->teedev->desc->ops->object_invoke_func)
>> +		return -EINVAL;
>> +
>> +	/* Indicate that this object is being invoked from a kernel context. */
>> +	arg->id = arg->id | BIT(63);
> 
> Setting this bit is a qcomtee backend requirement and should not be
> exposed to the TEE subsystem.
> 
> Kernel users of qcomtee_object_invoke() should use the normal object ID
> value. For example, access to the initial ROOT maybe represented as
> TEE_OBJREF_NULL | BIT_ULL(63), but the upper bit must be managed by the
> qcomtee backend for any return object, i.e. The backend should also set
> BIT_ULL(63) automatically on each returned object ID.
> Callers should treat the ID as opaque and must not manipulate the upper bit directly.

I agree with this argument. Since we only invoke QTEE returned objects from
tee_client_object_invoke_func(), the QCOMTEE back-end should set the MSB of the object-id
when returning QTEE objects to TEE kernel client. It should also drop the MSB of the object-id
for both invoked QTEE objects and QTEE objects passed as arguments by a kernel client.

We are already taking care of dropping the MSB from the object-id for invoked QCOMTEE objects
from kernel-space. I believe the correct place for setting and unsetting the MSB for QCOMTEE
objects being passed as arguments are here:
https://elixir.bootlin.com/linux/v7.1/source/drivers/tee/qcomtee/call.c#L181
https://elixir.bootlin.com/linux/v7.1/source/drivers/tee/qcomtee/call.c#L125

Once the object-id is allocated by the back-end, we can check if the kernel_ctx flag is set
in oic. If so, we set the object-id's MSB before marshaling the object-id to a tee-param.
Similarly, when an object-id is passed by the kernel client, and kernel_ctx flag is set,
we unset the object-id's MSB before marshaling it from a tee-param.

Do let me know if you're aligned with this approach for achieving kernel context
awareness without TEE front-end or client involvement. In-effect we're offloading this
context information to QTEE object ids.

Regards,
Harshal
> 
>> +	return ctx->teedev->desc->ops->object_invoke_func(ctx, arg, param);
>> +}
>> +EXPORT_SYMBOL_GPL(tee_client_object_invoke_func);
>> +
>>  int tee_client_cancel_req(struct tee_context *ctx,
>>  			  struct tee_ioctl_cancel_arg *arg)
>>  {
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index e561a26f537a..ca99c6b747a8 100644
>> --- a/include/linux/tee_drv.h
>> +++ b/include/linux/tee_drv.h
>> @@ -283,6 +283,19 @@ int tee_client_invoke_func(struct tee_context *ctx,
>>  			   struct tee_ioctl_invoke_arg *arg,
>>  			   struct tee_param *param);
>>  
>> +/**
>> + * tee_client_object_invoke_func() - Invoke a TEE object from kernel space
>> + * @ctx:    TEE Context
>> + * @arg:    Invoke arguments, see description of
>> + *          struct tee_ioctl_object_invoke_arg
>> + * @param:  Parameters for the object invocation
>> + *
>> + * Return: On success, returns 0; on failure, returns < 0.
>> + */
>> +int tee_client_object_invoke_func(struct tee_context *ctx,
>> +				  struct tee_ioctl_object_invoke_arg *arg,
>> +				  struct tee_param *param);
>> +
>>  /**
>>   * tee_client_cancel_req() - Request cancellation of the previous open-session
>>   * or invoke-command operations in a Trusted Application
>>
> 
> Regards,
> Amir
> 

