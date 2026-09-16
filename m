Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B63C982C9
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 21:23:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id ED2D3451E5
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 21:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789593839;
	bh=gJJWBQeFSX1YsrOWygD+rC9pHJoBZw2+qKeEeFs6RRo=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=hrdKlplE0Z7sGRNax6atQbTjGV2gW7iwaqNTgEXfMwu5lhDsSmofJvW1bilKm5wbe
	 au2kfWs1CCnoIDfae20HkxfCvNLwTw7Y0YjtVeWdI3tD6De7YVRIq0azF6x36g56v7
	 MfMlV0OLQ4Xc73lDdnZ07VaWQdjEXEqDRdlQoQWriaPCF0xHfaLWdZMmLZ95PEx7hh
	 qK1nwU2bh7F1pCSc5w8+YkEbRT4PCwDpmruiXl3Dy1tXyB/MbGbYr8n+8SitIkKMM6
	 hst8VzhuXVjiLAF3GF70S+fEBY67eDKVTtc9CMQNAbrSXwxxb+KPimrRNJ7AHzFqnk
	 cGF3DZ5K92/iQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0A6A744F00
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 21:23:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B9zVUleq;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BjBXyVbb;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFeeRm2600748
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 21:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w/qTLVLi8JrEbZ5Wtjo59+5wUP++p74xd9zORAOvt3Q=; b=B9zVUleqVc0IwYvo
	2kVS9RooIb9ERrcP5PS6AJMR0gaiIevixWLq5qN/3aBKETxjM+rhRBUTzcok5Whb
	svM4ZTgwJPuPkCaNElgopGA52rcmgpqGQ7XVErtlmAIEq+GzVMbMCz6NH7EA7DIx
	JFvOfToWEO0K8/39zGLSg9eniwoyvlbxaElKoqjDbAnPej0Q6e50+et7aoofhuox
	XHRPcOIRMlbXXmowCW3mvxB+TDmnEzDZfJDrqhJKvE0PKJOxQYHIl9qkUCr6fnmg
	4vxlh7AoQbWeNSsdY4heO8bk0K6uRVpYox3qdPrQXH1kiaweWsoA9yWTsJkLltAR
	0ei0/Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb261b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 21:23:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4b524ce78so91540a12.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789593830; x=1790198630; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/qTLVLi8JrEbZ5Wtjo59+5wUP++p74xd9zORAOvt3Q=;
        b=BjBXyVbbYRXK4C6r2c0murKKThGdx2H8YlLRVhc8yS+3Nfe5GNStQ3ClExzXWv2gnt
         hkyh79wI3ADe5F/nSmEDSHM+/G22uhdy5Iv0nEqeQU11Y6m8WTaI2v8iybyXu58VoleC
         sg/rVHIeI8uMPCxmhCjsWpIJRi8bWjUBN6FX0BGYtLT4HwIntQBtjkZmlyCA7QKPgIfN
         /yTepHI1aEzUdQspgrwrAPPAzanSlvjwnpFPnBiFIy/i36VjANY1MUoRKR8BfvngaHqn
         WGtBzywQTyQ6Xloxh/XgXBvpB+xrFFu9aed9olacM2lFrJyoV4646bA8i1HoCxYay6Sb
         FbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593830; x=1790198630;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w/qTLVLi8JrEbZ5Wtjo59+5wUP++p74xd9zORAOvt3Q=;
        b=TAKEIv6Uv46gaeS+WOLvN2BWRdqrCw26gJj9N4noq7ZpesLUGtkANh/X4aFwvk4G20
         fJhK24yu5ExwyUwPYQBVhxfOCnnZsqey4pV3YB91CdNR77DVxvpe+mwzxVRYF+1T+uUv
         7Qv42mK+b9QieT0IbY2iBqZURCwucaFGKkztb/EEh1joFRAtpwW8JfRGkow+lRXLsZxu
         ZGj4Rsnx1uUVTtR1Ul+GV/dEboaQp0Zfk6RkTqsNPLQAPjH96KlBL5XAe9Vm39VCLeld
         vRDrGw6iYmA4Zkl7McltvIae5ZMPNF7Pg+7JayiheI4Ze8sA97lUAtdJ1Kl37Bkk+zM9
         asrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQPNXwU/+CcCCz+xZZgEZjY9oHYUr8mUGtyGajfZE4QULH8SkIVq4Kz+SL9Oq895ri3rIXgdI=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kLVM6ZgB2eqMMpuS0Snu5ZfEOmQ44s/uxs3sDsa/NL/GBjzIaW
	PNjFCyXIXcYxIckR5mIIFSN84IfoBT1uMM94Zf1O+6dD5YHokiwtUOG5cQi3/nDcFzZLbHBy5lh
	rjYsVhkQ3m6putemk7LPwCb2BxkEdWevhD1U3s+NcBrkGg87HA1eSeBSDvDvOEmxiyayCZbI=
X-Gm-Gg: AYBFou0xu4lgpI7lsTH6VkubQyPyqb8cy15pUJi/HZzKpI9OoCrE0Xa0AYMWufqCTCe
	rT0JQybGKZdg5WjC1JPqqYvgJ1fnVq4MHwzLkwEmXlyx4MQOqaQyz56QndQJV3eLkSvM7TAFByQ
	6qXPl1K4mLkpnbXv8VSHL9bto14L/u8PE3SXKxoREtDXwEJYTHS6MK7nHIQ8ULsq21TOOFHo8Ln
	GcXJx0HYjqrX1wqTVWz5DQf3ZqqygKJTT4/yFST0xhwYlQdgA6jLugPqu7j3FKjMZym0X3UrxBC
	pjENjLi2MckkZL9+KHdcbotHl/HAuOyxcoNFqlhzNUAlKhqkisYXqolBy3pS3b/CxRQqSPumi56
	wjB7GHYc3l9wEXA1m7VmBgHmv8jyWRduY
X-Received: by 2002:a05:6a21:6b10:b0:3da:3bdb:b22a with SMTP id adf61e73a8af0-3dd5f71a912mr10826728637.20.1789593829852;
        Wed, 16 Sep 2026 14:23:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b10:b0:3da:3bdb:b22a with SMTP id adf61e73a8af0-3dd5f71a912mr10826675637.20.1789593829396;
        Wed, 16 Sep 2026 14:23:49 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.15.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50a7a3526sm2253425a12.0.2026.09.16.14.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 14:23:48 -0700 (PDT)
Message-ID: <786a1460-c660-4de7-bb07-debdbd6a4661@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 07:23:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/5] optee: riscv: add RPMI TEE service group
 transport
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
 <20260912-rpmi-tee-service-grp-dev-v1-1-1d1d35c2a859@oss.qualcomm.com>
 <a9d9aac7-cb2d-46fe-a220-40f61f615b89@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a9d9aac7-cb2d-46fe-a220-40f61f615b89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aab08e6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=RYJI0oIToGyOemi2SthaJQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-u4usqK0Ikitso02ChQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: KrVaqdFM7vhEGW2CAcNQlK53r1dz9xDS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI5NyBTYWx0ZWRfXxsPqhCKManRF
 cTHSgf0SP6nJBBEoBfIEAg3YyGyQRQ4gtuEa8eONihJg1tFW39WXyeQG6kUaOMCAYwRkUr3my64
 xg/BKsabE9q4Jl9hZBMLYT/Cj+pqCDMN6Rgmd+cd1f8EaHQONhu1aww8Aa766cKb/EfmrA/BGc6
 Vpm/asZOnBVHMbXSk4pz55j+QRRqOn4KoSoBU5Zzs138AcffULIRX37BQUpHOfBTkWvVJWaLEsF
 f8lbhP6SD0PKMIYaGxrGK3YX5Bc3QBVIC/egG386B+dd0YLZ29zgRpLrf9F9g33Xfr2b1BQxlsJ
 tCvkMBxL+O8jPIkQzJbGhCFT5JR8KdmvCEMoZv7jZC0k72T29/aOkjm2OBT4f98TRDlnd0USSvu
 VocTUfDG4I2iw6evL0qZKpkpyvbZ6cG15gnjnWvHR2h/H/r/CKIcw5XCw/uH4BWxkmKpEVY1zNN
 gSWvvVptpuZnQDaHQow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI5NyBTYWx0ZWRfXypHZeEb1vyDv
 hqGJ9Q/8Sim1isynK08MKBoV0ZBEill2+aLPcvYMxZqkcdQNUYFtNPhpBrLBRmZLH+r8bMKtR4e
 +fNYSOPjVn5TkGEBZQQshTEsvPmppTc=
X-Proofpoint-ORIG-GUID: KrVaqdFM7vhEGW2CAcNQlK53r1dz9xDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160297
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0A6A744F00
X-Spamd-Bar: ----
Message-ID-Hash: Y7NU7CGZXX27KQGCUYF73LJKY6G7IUVT
X-Message-ID-Hash: Y7NU7CGZXX27KQGCUYF73LJKY6G7IUVT
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Y7NU7CGZXX27KQGCUYF73LJKY6G7IUVT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Trilok,

On 9/16/2026 3:30 PM, Trilok Soni wrote:
> On 9/12/2026 3:15 AM, Amirreza Zarrabi wrote:
>> Add an OP-TEE transport for RISC-V using the RPMI TEE service group over
>> the SBI MPXY mailbox framework.
>>
>> Request one mailbox channel per hart and use the channel corresponding to
>> the current CPU when issuing a TEE request. Probe the RPMI TEE service
>> group and required memory-sharing capabilities before registering the
>> transport.
>>
>> This provides the basic transport and discovery support needed by the
>> following patches.
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  drivers/tee/optee/Makefile                 |   1 +
>>  drivers/tee/optee/core.c                   |   8 +-
>>  drivers/tee/optee/optee_private.h          |  34 ++++
>>  drivers/tee/optee/optee_riscv.c            | 312 +++++++++++++++++++++++++++++
>>  drivers/tee/optee/optee_riscv.h            | 141 +++++++++++++
>>  include/linux/mailbox/riscv-rpmi-message.h |   1 +
>>  6 files changed, 495 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
>> index ad7049c1c107..925b8ec7ef68 100644
>> --- a/drivers/tee/optee/Makefile
>> +++ b/drivers/tee/optee/Makefile
>> @@ -9,6 +9,7 @@ optee-objs += supp.o
>>  optee-objs += device.o
>>  optee-objs += smc_abi.o
>>  optee-objs += ffa_abi.o
>> +optee-$(CONFIG_RISCV_SBI_MPXY_MBOX) += optee_riscv.o
>>  
>>  # for tracing framework to find optee_trace.h
>>  CFLAGS_smc_abi.o := -I$(src)
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index a52c1f498b99..63f1725e646e 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -220,6 +220,7 @@ void optee_remove_common(struct optee *optee)
>>  
>>  static int smc_abi_rc;
>>  static int ffa_abi_rc;
>> +static int riscv_abi_rc;
>>  static bool intf_is_regged;
>>  
>>  static int __init optee_core_init(void)
>> @@ -245,9 +246,10 @@ static int __init optee_core_init(void)
>>  
>>  	smc_abi_rc = optee_smc_abi_register();
>>  	ffa_abi_rc = optee_ffa_abi_register();
>> +	riscv_abi_rc = optee_riscv_abi_register();
> 
> Isn't it growing rapidly now? We have two register calls for the ARM,
> one for the RISC-V. One more region specific ISA I am aware of and it
> may have op-tee support in future? It is time we fix this logic
> in the better way. 
>
> 
>>  
>> -	/* If both failed there's no point with this module */
>> -	if (smc_abi_rc && ffa_abi_rc) {
>> +	/* If all failed there's no point with this module */
>> +	if (smc_abi_rc && ffa_abi_rc && riscv_abi_rc) {
> 
> This is started looking ugly in my opinion. 
> 
>>  		if (IS_REACHABLE(CONFIG_RPMB)) {
>>  			rpmb_interface_unregister(&rpmb_class_intf);
>>  			intf_is_regged = false;
>> @@ -270,6 +272,8 @@ static void __exit optee_core_exit(void)
>>  		optee_smc_abi_unregister();
>>  	if (!ffa_abi_rc)
>>  		optee_ffa_abi_unregister();
>> +	if (!riscv_abi_rc)
>> +		optee_riscv_abi_unregister();
>>  }
>>  module_exit(optee_core_exit);
>>  
>> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
>> index aefe1e6f5689..8d22d65e087b 100644
>> --- a/drivers/tee/optee/optee_private.h
>> +++ b/drivers/tee/optee/optee_private.h
>> @@ -171,6 +171,31 @@ struct optee_ffa {
>>  	struct work_struct notif_work;
>>  };
>>  
>> +/**
>> + * struct optee_riscv - RPMI TEE communication struct
> 
> do we need to name it optee_riscv? we don't use optee_arm anywhere in this
> code I believe. 
> 
> More later...
> 

The naming convention, and even the file structure, will change in v2.
This RFC currently mirrors the _internal_ FF-A implementation, which is neither
required nor ideal. We are moving away from that structure.

Best Regards,
Amir

