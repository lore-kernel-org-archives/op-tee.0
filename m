Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BC0C88E72
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 20:38:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EB6A3451A2
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789677523;
	bh=Wi5x/Ouh/PeM1Z3PGzen1AuGIANL006sy5SnhuPr6aY=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=K2LOcu4LVUSBh1RO8WV1kyEYB0VWKDB2YzN0ihpQpT8i7tGZ5mD9oL1ysIypCf4eq
	 Nvness3y7NVgl8/nwchBOsWpNTnTAVIOHC1rZ9XmTc16ETvlpfxZKtR4WTcwajSlNb
	 J+dUaaSf6XRj5gcJu8i9Ca5j+fMA1lZ+RGHFYz43boM916k3bg6WeKZ6XKbeubDabu
	 XwaiWe4vyucNle9RXg6bv0TtR2+O+LRzBDXOF8+6feentKY35M7EVqYj8vB/PhlNtK
	 K+XiWCipjNDCmgUowezGAHs91+XgSie6ZsM0ri9Lt4D688/kU3W/iUsrTXhJRnM/H8
	 AtRjmFHUaFlkw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6BF7E44424
	for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 20:38:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bDMSa4iS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cTPMIg8G;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH5gjo2413203
	for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 20:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8YpNY/Bau2C9H4OXWV+XfoUZdnr4CV3FIhXIPLaLRpw=; b=bDMSa4iSiT8ItOZL
	qDlgE27bojSoam9G3l2wvgy1LHpWPkfn/+L27JL7XSP8tIMNBAM+VShnfQHvx7Sx
	HklycHyYEAS+3ywN8aA4DhZgIuPY9gcZiWa+ZsZWTxoYqwzkYWakBN/wBGvr3ExG
	UXvuMj/DMufQL1miacolNxE7jnHau+Fc4lsKaoVMm8hC1WEMYUL4bDNwOx/mmfIM
	WFqRC3Nxyqq5aUKNEqWDCMW9/M2bY8K7PCsh1b3z0cIefy6TcappZDautpQo2jPe
	GeupFN0+uoSdyO2Obeczcr4nrwTxCH7Z/yd85WiPhbNaIMSqp7chdUYyaDhQP7Yx
	j0JWsg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grgu5j3wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 20:38:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4b524ce78so861361a12.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789677513; x=1790282313; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YpNY/Bau2C9H4OXWV+XfoUZdnr4CV3FIhXIPLaLRpw=;
        b=cTPMIg8GcpYUcrAKHZHzrUjkqjmu4VuE33g0RcM9YcVoO42vd9f7rJCfl2jeoLscrX
         HSkx5zo3J+1pCwwp19h2WfWFKHusC+aR8WPnauvQQZ3o/xraE9ttXPRc/xZesdl58mP8
         CM9wV4bKfajeprMAPSGHfkq7fG0tR8t4wbUIaUL9CYD/2eFIbkHVgmeLLesJUh2UdR6v
         2kusjnfomKYHCv0UFbnAhCPbjJ+5hRwtArUl4ED4HWbchBqbP31snqDtK7uR6ATiYHce
         ZblC4WDIG6sGuVZFsNg0+47ha+IpK9xcaxMQ/r8jQDJbgXiaa7SOI+PNu4yPqJm5ucqT
         Bqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677513; x=1790282313;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8YpNY/Bau2C9H4OXWV+XfoUZdnr4CV3FIhXIPLaLRpw=;
        b=cdhjjO3eVuLZUuUYW51wwsYWUcDpBXqB2xE/lPVAFqCqHA6fTdtSy9E1dl6lXoSUiZ
         gbiJHa8Tea5z8wlIJx2y3cwt3a10ms52cNjGcA7AOwae3dwS36lgM0peS4vssQbgdU2d
         MlkGaxPCZDOYa7jA0UahuBg0vtPCFS9EgR7mL2WDwUKMVEfhdNSpcQYZIbRm66sK5n2Y
         4CFFbgADQBxXmpD8+ufnlJo0Lxv1eUyTo4EICAiLPTGSpeOwi7Y2MW5rALS2pdxJHtIq
         ns6fqbbdz/eM9cjviPnfFqfm/UF43uzRBErEh1xntAXl9lzyFPPZwiZ17i3000imkJnp
         aczQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/pS1Pz4Li7WzE2IBqnL74Ppw7RFnzxkHhdmeX2qRaxCEYUFbep+kXRf4nl1NcGBYymgop/24=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lhNUj9WC/xfqdRHbxUNHS9L+atYnEExqmuLfKU9KN4b0mi45CO
	gpieCLwcw4MHhu2gjakKaTGRdVe/q6pFuYavNFC7Atg7BkajTZkVqeScnH66vvLJcUrz7bp8JkG
	8p/H9Sa5sy4q4jFPqQacnVEwRKGb3/c4mG9IR/0lTMnUj+yPTipnSMZNMTNwZcO+v5Klz2xDQ
X-Gm-Gg: AYBFou15qASnIat9lWXUmV0CVErPY1TSKICzv2g0j8ZjvasxGbyU0JHloXd6/6ZEPW/
	H8xHtdebH+1eZel6RXXbPGgcryAYtFBZ3WPzSSvnNbnej/DmrC5OFt1Lc+Awpf+f1tWu8l3eBjh
	XD905vQTm5bzQfs96SwmuFmkssKSu9lat8G5u9zW7sgPSfhWG6KGvlaTpNyyMVGxBGJhehe6A8O
	lWeYP+Q29tVAGEbpN1rneGKzly0Ym6cyu9syt5Ki4osfJGz+PBCcqzMcjMXHjD/ZrnpNq71RV4Q
	W/wtUvgQ5+syhrHimGXJxBhzokS92nFUbfU7b5RVbh4ahMGPmM49Y0Cu+2H0NXLfoCSGH1Fd2wM
	Aveb44DrWA0m7YodH8j97pCLD8Z+kBzS5ZfSreyx3WJ6dsRy7ZpwYOQ==
X-Received: by 2002:a05:6a20:4306:b0:3d3:adbf:777d with SMTP id adf61e73a8af0-3dd8c4cc8b8mr304646637.25.1789677513382;
        Thu, 17 Sep 2026 13:38:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:4306:b0:3d3:adbf:777d with SMTP id adf61e73a8af0-3dd8c4cc8b8mr304613637.25.1789677512941;
        Thu, 17 Sep 2026 13:38:32 -0700 (PDT)
Received: from [10.73.236.146] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c00ede586sm14590388eec.10.2026.09.17.13.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 13:38:32 -0700 (PDT)
Message-ID: <71568eb6-8123-4ed3-a2d3-4e33e4880bf4@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:38:31 -0700
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
 <a9d9aac7-cb2d-46fe-a220-40f61f615b89@oss.qualcomm.com>
 <786a1460-c660-4de7-bb07-debdbd6a4661@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <786a1460-c660-4de7-bb07-debdbd6a4661@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI5NSBTYWx0ZWRfX5LCJL0pqZglj
 rXV5fvTZanti49N7GVuGNXQXvk6l5rNmD1wtWaIRwjJqABzE5jCZfD+CO56t/XGHnv4RO3gkMH7
 5Nmcuve64U2lv+qvzwlj+y46iaZ4NmQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI5NSBTYWx0ZWRfX3BQ+MytplKFw
 dSPelkuKbutlaYr2pFYRDWA6/+613UP16NB9NmutIzYo/p1s3SKts7++sRJbNNSwmqyuEL4gW8T
 YA2sxyVZ5kLppGxzj8jyLAoInA/6+muiGit7u/s+yiRfZF5mrYebGNlT3Xl382CR2ieGqgKo9kh
 fNOHZ3tiiyjhFGg+J9Zy9zd/l/lgXrsEkEg1+1Oo+Mx1LY3V/He7iLaut5fpUAOY0IhaaSB4B48
 m5eQFHKwxjHFfZAnzVIQUQlT/zsQvgWkJcRbhSnTWUJdfXCf9rZsGiD8MYOurKHB+oDh2WbgJ/P
 GwlfvA9FEtuXSxayJPdOJzpZyUvcU+9wDOTNbh1rsJ1U+3bRv9rC4UGDrAXBHaVF1JUgdlryvku
 p/z2DKqb0gib9NTj2WBDD578wUSqWNKIoKNM2VdWOuMj9LfZNODba8tS1QwLQh9KJBbsj1UsZst
 2qLQ9KRmIUtUECvvW2w==
X-Proofpoint-GUID: t6mMZARcsq5k1r62H0HQ16L3gUHrWcLn
X-Authority-Analysis: v=2.4 cv=GvbXaU1C c=1 sm=1 tr=0 ts=6aac4fca cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=5Hg3Q6Ij0jR0fJQLcq8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: t6mMZARcsq5k1r62H0HQ16L3gUHrWcLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170295
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6BF7E44424
X-Spamd-Bar: ----
Message-ID-Hash: HUPYBG6LHFRYKMVGHNG6D6VBAFB3YZVW
X-Message-ID-Hash: HUPYBG6LHFRYKMVGHNG6D6VBAFB3YZVW
X-MailFrom: trilokkumar.soni@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HUPYBG6LHFRYKMVGHNG6D6VBAFB3YZVW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Trilok Soni via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>

On 9/16/2026 2:23 PM, Amirreza Zarrabi wrote:
> Hi Trilok,
> 
> On 9/16/2026 3:30 PM, Trilok Soni wrote:
>> On 9/12/2026 3:15 AM, Amirreza Zarrabi wrote:
>>> Add an OP-TEE transport for RISC-V using the RPMI TEE service group over
>>> the SBI MPXY mailbox framework.
>>>
>>> Request one mailbox channel per hart and use the channel corresponding to
>>> the current CPU when issuing a TEE request. Probe the RPMI TEE service
>>> group and required memory-sharing capabilities before registering the
>>> transport.
>>>
>>> This provides the basic transport and discovery support needed by the
>>> following patches.
>>>
>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>> ---
>>>  drivers/tee/optee/Makefile                 |   1 +
>>>  drivers/tee/optee/core.c                   |   8 +-
>>>  drivers/tee/optee/optee_private.h          |  34 ++++
>>>  drivers/tee/optee/optee_riscv.c            | 312 +++++++++++++++++++++++++++++
>>>  drivers/tee/optee/optee_riscv.h            | 141 +++++++++++++
>>>  include/linux/mailbox/riscv-rpmi-message.h |   1 +
>>>  6 files changed, 495 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
>>> index ad7049c1c107..925b8ec7ef68 100644
>>> --- a/drivers/tee/optee/Makefile
>>> +++ b/drivers/tee/optee/Makefile
>>> @@ -9,6 +9,7 @@ optee-objs += supp.o
>>>  optee-objs += device.o
>>>  optee-objs += smc_abi.o
>>>  optee-objs += ffa_abi.o
>>> +optee-$(CONFIG_RISCV_SBI_MPXY_MBOX) += optee_riscv.o
>>>  
>>>  # for tracing framework to find optee_trace.h
>>>  CFLAGS_smc_abi.o := -I$(src)
>>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>>> index a52c1f498b99..63f1725e646e 100644
>>> --- a/drivers/tee/optee/core.c
>>> +++ b/drivers/tee/optee/core.c
>>> @@ -220,6 +220,7 @@ void optee_remove_common(struct optee *optee)
>>>  
>>>  static int smc_abi_rc;
>>>  static int ffa_abi_rc;
>>> +static int riscv_abi_rc;
>>>  static bool intf_is_regged;
>>>  
>>>  static int __init optee_core_init(void)
>>> @@ -245,9 +246,10 @@ static int __init optee_core_init(void)
>>>  
>>>  	smc_abi_rc = optee_smc_abi_register();
>>>  	ffa_abi_rc = optee_ffa_abi_register();
>>> +	riscv_abi_rc = optee_riscv_abi_register();
>>
>> Isn't it growing rapidly now? We have two register calls for the ARM,
>> one for the RISC-V. One more region specific ISA I am aware of and it
>> may have op-tee support in future? It is time we fix this logic
>> in the better way. 
>>
>>
>>>  
>>> -	/* If both failed there's no point with this module */
>>> -	if (smc_abi_rc && ffa_abi_rc) {
>>> +	/* If all failed there's no point with this module */
>>> +	if (smc_abi_rc && ffa_abi_rc && riscv_abi_rc) {
>>
>> This is started looking ugly in my opinion. 
>>
>>>  		if (IS_REACHABLE(CONFIG_RPMB)) {
>>>  			rpmb_interface_unregister(&rpmb_class_intf);
>>>  			intf_is_regged = false;
>>> @@ -270,6 +272,8 @@ static void __exit optee_core_exit(void)
>>>  		optee_smc_abi_unregister();
>>>  	if (!ffa_abi_rc)
>>>  		optee_ffa_abi_unregister();
>>> +	if (!riscv_abi_rc)
>>> +		optee_riscv_abi_unregister();
>>>  }
>>>  module_exit(optee_core_exit);
>>>  
>>> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
>>> index aefe1e6f5689..8d22d65e087b 100644
>>> --- a/drivers/tee/optee/optee_private.h
>>> +++ b/drivers/tee/optee/optee_private.h
>>> @@ -171,6 +171,31 @@ struct optee_ffa {
>>>  	struct work_struct notif_work;
>>>  };
>>>  
>>> +/**
>>> + * struct optee_riscv - RPMI TEE communication struct
>>
>> do we need to name it optee_riscv? we don't use optee_arm anywhere in this
>> code I believe. 
>>
>> More later...
>>
> 
> The naming convention, and even the file structure, will change in v2.
> This RFC currently mirrors the _internal_ FF-A implementation, which is neither
> required nor ideal. We are moving away from that structure.

Thanks. 

I also don't like the growing registration calls and complicated "&&" checks
above. 

---Trilok Soni

