Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E86C88E5C
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 05:30:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 78E3445286
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 05:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789536629;
	bh=W+a/JDOjoaE1hUAH1acBJLP7pSsGB05GfTnuEehx8/4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Y+bTJnKHDWDN+oPER3MgI5G0AV33AJltlXci3C49XLylT8G6lrnWw7J26hZhd2ZCn
	 O/TVr4gddMYI5Msou21Dk5Zs1lerkhome7rF/6IZTBhsvz8k7PgoS8K3KKqc2WIaoQ
	 M9mbofwFbCJFmPQsRPfgJE1I1QL1V4vWzMY/86KIvaooziT3QvDxG9LtRtBhAqL7K+
	 fePrbRryErWYr+UC9JSP8AJ4vCtnD5Ku5SLxUOG9Iy4lereIdgsskQBR+rJXIk5Hpr
	 r7XZ4kqUbZv5DD5q1CSHf+BUTUodD43C60EHKZMGsD5RAnFNjX7dgA5N149PuPq888
	 DSC7NmxIk0v9A==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5CD3544442
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 05:30:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UYrXbv/V;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XpGtc2BD;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ1rU079908
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 05:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PeWBUFQKpi9k7BVFmzgyqFxO12My8fWkOb1uwjidszI=; b=UYrXbv/VQwW3H57t
	Z0UA/w7bnzdwE+dSanmAzsdRk6gI/sj++H+ff/fO+Q9t7k2dHX8ErySsMR/cjeqj
	l+/Za20c21hYA/wfmv93J2ezDeIYAwmDKRlgOhe6F7ofLpdRItYwUuja43nD3qn4
	QMy3qBmPT+SYvdotWXdNsjSPEF5e8zujzBlTA+u7OGgjGAnG4fWgPM76B6Z4CkfT
	zqhtTcqmvLvb/7iptDndqOl8lyC4qQHLaHNSCKRfQpKV3ed9fO1OmvVUZAqxMgVV
	913Y3Rhehxxm4XZXl4d+tGPrrR5ROnpYYFlF5b1CNfBV6tC/wMiyAxJHUvmVa6/+
	r0UoLA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqagejge2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 05:30:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so9263806a91.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 15 Sep 2026 22:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789536620; x=1790141420; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PeWBUFQKpi9k7BVFmzgyqFxO12My8fWkOb1uwjidszI=;
        b=XpGtc2BDR6WMs5TIrEzTLT3WnE0GOcsVv1jzAFt8x1S86u02nDMBSov8sR9v/LD/k1
         L3T2N6aD4pFhcglEJDhS5bG7TeInOmbFYvjv2WBc/DE6J5Yb2s1KQWyaFYmyMUqoCx2D
         qJf2VqoL081mGyBOh+Lj4YZqPWuuPCyjRLuevLGNoPLc8xH+G3G+yUFkvaDfoiMhP3GM
         dfajT6NboTICl+cf9EVVYOPr1IADMsceoYGJh0PbSSvhNX0+Sz09NyXlQQsERLySKEVe
         pBheagYxJfR3O96naDPjNPy8S2xGheQ78nOcenSH7jHXFfwyqMhdWD4ZMZQcR1YudxzV
         kX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789536620; x=1790141420;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PeWBUFQKpi9k7BVFmzgyqFxO12My8fWkOb1uwjidszI=;
        b=SV2LB4VbJ9aZ2nOw3N8dETtU1NU85Vz96mPnSsCYPjlxtseb+rcfgrt5+b3n/eXuBX
         iamkZESoh/971iFte+GK1/CrTStj9pILMAjGYmgqpw856Rk26fseNNyv7Zi3DCWkn0cE
         420xl1dq39r9VH1LvEilkyWhcIoDYl3vrJvDCtCvSbuj3/snyHgwjDJylMiBNL9Z+y7V
         1eb7cHwj9j4mVyNFbMs43hgEka9azMhGyuj1Wy/pm9A+Cxurk7PJO8rhPsooLLOTtB13
         jp9+taWwhc0KZNzlzc7U3xN7yC9+dImx8jTzvtkEn3R/imqv5gB0NB72Tnuw2s5tprCb
         A8eA==
X-Forwarded-Encrypted: i=1; AKwUvBxmVd2mlnlQtATO5qZa7/lcwpdmWnxADJLE7K9OWEf0aWSR4SNSv607ZehrHaDp6zqkmBS8pjI=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kGn/FZjbZ6OlmbeOz3OXDm1lIP74QBwsGOZQ3z3yCPkdGEJ2SM
	xP3gk+G+06QVrwGNGrnBUyDnVDnSElt/PGVhQ80aUHCRqZm5cc0KmYrQiJWlL8EnwswFoZNskWY
	fH6s9mHFjBqwZR5u/wrw5EvKI/5m66TCaWEmJ2jXRPdOGWKwZR2ePdVZW741bin5g1DQYonw8
X-Gm-Gg: AYBFou3UYiS8EJ1FeDJkHt9z5gnMUp8k74zu7krcYPIVVLBFjlME01VMKQVrvzJrOKu
	1j5E/vuPDbE6GlVgv77knkD//oyYXkth8hpL+HyppdcFlToJJp9T+UoL2jJVihVVeByTJRc2iDZ
	JfLDR1IpVg6eU8DOD3/H+Hp2kNS8tuJglX7JeCkr1Y+7k6QLjOVgnDGKi8AKSpvmswClUe0cY5F
	lNaiF8hapvbbVt+/KDQZ4ZOvr0eQa+ksfvzYKJytEREmOHo9CKXtSTtK+huRwXzO8vir5nBEiCv
	gUR+AzJaOza2y0TJ3RCHKSV5QwHzrWuVUHog7U/Ls+pputkzyBjEF9wkBlHi5NQN8k5IhWWN8tj
	poP93KllDWiPjgTlL6MtWCw3qq3Pzub4CkLdagg==
X-Received: by 2002:a17:90b:224b:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39e1e4246f7mr3005293a91.13.1789536620491;
        Tue, 15 Sep 2026 22:30:20 -0700 (PDT)
X-Received: by 2002:a17:90b:224b:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39e1e4246f7mr3005220a91.13.1789536619995;
        Tue, 15 Sep 2026 22:30:19 -0700 (PDT)
Received: from [192.168.86.250] ([76.176.48.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d13ee7sm3425309c88.8.2026.09.15.22.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 22:30:19 -0700 (PDT)
Message-ID: <a9d9aac7-cb2d-46fe-a220-40f61f615b89@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 22:30:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/5] optee: riscv: add RPMI TEE service group
 transport
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
 <20260912-rpmi-tee-service-grp-dev-v1-1-1d1d35c2a859@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260912-rpmi-tee-service-grp-dev-v1-1-1d1d35c2a859@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA2OCBTYWx0ZWRfX1BTKeqPGd9zS
 UmBVpuu/E7ypoZ9xIcknHY2OwTVNIDr38e/5uRsbxKEtGMG2CeExVWIJ5TZLJomL9olCP9dsuuF
 dVjBGsDhNeUwbZrkAt+4yFzIQNoZo3A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA2OCBTYWx0ZWRfX4+B9Rw44nEsa
 W49ANlF63Zj1yAiXe2UaNcf1m86CYPCK336WzxreoC4Ozf2YiiSqpYsk7L9UsbDf2o38LyPBaut
 nyBcrhD5oiAbK1QPvBJPCHrSEeuKHxFlMYn9Wa5If0l+YPQds5TqWIL5j5cMuOEex8dz+6Yjp+S
 r0UBop69mISNl5G71LroSrp6VDLfrubJ7x6OUlRw8xt4qsstUBy1F7CPpxfDxK0p9ht18DdV8Jh
 gDgIEBMRPBltQrqCh+y+OCu2zxgHU5SXBjdceE7+Os3lyQW/6vm/41PadR7YrCOhdtH2i20uJSh
 CClB9LzJSg9wFkYPWI+n1Bxp5iL1WcLh6bHoCU+NXZMQJOt1c79gURYeZEoLgcFIBtypw9Qcg8j
 SKEpShXJru2mjeqON+OJxhk9kveizeeD6KCabqjOKMRgO8WXA/LdrDKWcAuYaNNrPLgE4WkpflE
 FisQVJKXNleXu9FF46w==
X-Proofpoint-GUID: EO_mOUmYmZIsgXglWyUOus9NhInlSJeV
X-Proofpoint-ORIG-GUID: EO_mOUmYmZIsgXglWyUOus9NhInlSJeV
X-Authority-Analysis: v=2.4 cv=PcZqFShd c=1 sm=1 tr=0 ts=6aaa296d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=v3eslg5cZyQnhgVqE9oA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160068
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5CD3544442
X-Spamd-Bar: ----
Message-ID-Hash: XS2XRFDQVB5Q6KOODKP4BMGAHMET2D3T
X-Message-ID-Hash: XS2XRFDQVB5Q6KOODKP4BMGAHMET2D3T
X-MailFrom: trilokkumar.soni@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XS2XRFDQVB5Q6KOODKP4BMGAHMET2D3T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Trilok Soni via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>

On 9/12/2026 3:15 AM, Amirreza Zarrabi wrote:
> Add an OP-TEE transport for RISC-V using the RPMI TEE service group over
> the SBI MPXY mailbox framework.
> 
> Request one mailbox channel per hart and use the channel corresponding to
> the current CPU when issuing a TEE request. Probe the RPMI TEE service
> group and required memory-sharing capabilities before registering the
> transport.
> 
> This provides the basic transport and discovery support needed by the
> following patches.
> 
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/optee/Makefile                 |   1 +
>  drivers/tee/optee/core.c                   |   8 +-
>  drivers/tee/optee/optee_private.h          |  34 ++++
>  drivers/tee/optee/optee_riscv.c            | 312 +++++++++++++++++++++++++++++
>  drivers/tee/optee/optee_riscv.h            | 141 +++++++++++++
>  include/linux/mailbox/riscv-rpmi-message.h |   1 +
>  6 files changed, 495 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index ad7049c1c107..925b8ec7ef68 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -9,6 +9,7 @@ optee-objs += supp.o
>  optee-objs += device.o
>  optee-objs += smc_abi.o
>  optee-objs += ffa_abi.o
> +optee-$(CONFIG_RISCV_SBI_MPXY_MBOX) += optee_riscv.o
>  
>  # for tracing framework to find optee_trace.h
>  CFLAGS_smc_abi.o := -I$(src)
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index a52c1f498b99..63f1725e646e 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -220,6 +220,7 @@ void optee_remove_common(struct optee *optee)
>  
>  static int smc_abi_rc;
>  static int ffa_abi_rc;
> +static int riscv_abi_rc;
>  static bool intf_is_regged;
>  
>  static int __init optee_core_init(void)
> @@ -245,9 +246,10 @@ static int __init optee_core_init(void)
>  
>  	smc_abi_rc = optee_smc_abi_register();
>  	ffa_abi_rc = optee_ffa_abi_register();
> +	riscv_abi_rc = optee_riscv_abi_register();

Isn't it growing rapidly now? We have two register calls for the ARM,
one for the RISC-V. One more region specific ISA I am aware of and it
may have op-tee support in future? It is time we fix this logic
in the better way. 
 

>  
> -	/* If both failed there's no point with this module */
> -	if (smc_abi_rc && ffa_abi_rc) {
> +	/* If all failed there's no point with this module */
> +	if (smc_abi_rc && ffa_abi_rc && riscv_abi_rc) {

This is started looking ugly in my opinion. 

>  		if (IS_REACHABLE(CONFIG_RPMB)) {
>  			rpmb_interface_unregister(&rpmb_class_intf);
>  			intf_is_regged = false;
> @@ -270,6 +272,8 @@ static void __exit optee_core_exit(void)
>  		optee_smc_abi_unregister();
>  	if (!ffa_abi_rc)
>  		optee_ffa_abi_unregister();
> +	if (!riscv_abi_rc)
> +		optee_riscv_abi_unregister();
>  }
>  module_exit(optee_core_exit);
>  
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index aefe1e6f5689..8d22d65e087b 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -171,6 +171,31 @@ struct optee_ffa {
>  	struct work_struct notif_work;
>  };
>  
> +/**
> + * struct optee_riscv - RPMI TEE communication struct

do we need to name it optee_riscv? we don't use optee_arm anywhere in this
code I believe. 

More later...

