Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934CFC79FB9
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 08:35:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AD5A94504F
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 08:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789029303;
	bh=1VG49kK4fNZl7JgRGZ2R0lXCv5A3AAINFdkFYWuVzrg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tnijz/jOGBkCmLCdNY+WnmrUZBpBBRZV0fms/yd2pVUdy1Nge9tJ8vZZ7jFgW04/G
	 AjrqoGcY5u4vpN4kfCYUFxBoMOiRKXrxSLVmVJLJW3aTlfXcMeHXMpheKZTY1tCVV4
	 6o4JeEW436T/WSnuo0tPImtxKb4SjJ5MigwSdb1x94pqJ1xzMPLNV3bWLA78SADKL3
	 6lWSZcf9Ng5uLFG33nLt0T0VpuQtY7P1vAjD+Idj9z74P7JEL1q20ynI2Mt4f6P54c
	 8ZCiDm+GQcCZfvvALqBDvTZC9eVQi6hvqVT/DR7I3ko/xki9q/hGrkyqhYl9owe5go
	 +4YR7susjashQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E774044A3E
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 08:34:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j+EgQV9N;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZGy0K3ew;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5HMti2974690
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 08:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZDtD7s+88cPFkDJa10PZ92cfoS/KlLMFXDnVCuSEkiw=; b=j+EgQV9Nr/E6JoKp
	V7juIRxiQ/FGbc4XOkpjrhmPem8YQAfkfFj5y08XCxsW82OGEdjLTycIKS59/oL3
	JaYlvBYdgO+IofwTSv8lul5Ii/GkQ2hXP4jYu9le79S5kU8BOE1NZt0p7OgFpPDA
	SxI4bs9F8LrVkAk2Y/t4nOyt3gD5fiLgNohIiiyRRhpD3YD433UURPftyhwcyb30
	EATMWh08rciW8CXfQK5z/9nbltTZMIhVzHX0uO99L2k9Q/AikSJ6D26klrliopXE
	5R9mof55HSj4hXGokrYpPICw8N4g6PkJNIn9fUV/2uM8Fh7XZrKN66N4FEqYoEah
	eZvbhQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg2vq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 08:34:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-853d0d87123so3315895b3a.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789029295; x=1789634095; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZDtD7s+88cPFkDJa10PZ92cfoS/KlLMFXDnVCuSEkiw=;
        b=ZGy0K3ewQxDaMg9EkDOOVe+8F4y6XD/2LWzK+f8mScwh1JKk3yyQH5lV0r8618UQcb
         TbMxE9KrFvdCPsJ0D1BivF9tsCkghsMX5ImYe3foJVCKLM4ouh8WsJ+jzMHuntpu8Act
         6kHmftPSeUcKhs48c8UbqyD2EGqL/RNfBRR7/a/wn9qhSioysix1c56fspjrruF75bp+
         B7rwrybnpO6adKsyxEDfTqyJB9H4W9ulTObJWUn2xa5vY6cj0vN9nJFDONJztP2epSOh
         +akmLsoBSO/3x/PfPtVhBYYLuApDLDQz6EK0LzNeh/Z/5u16ZvyjI6GcivK9pKHTuV5u
         UojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029295; x=1789634095;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDtD7s+88cPFkDJa10PZ92cfoS/KlLMFXDnVCuSEkiw=;
        b=ZBpumwy4mRtxXNxHhRiA9//ULQvGhqViYMDoUnRicIEiOv1Jj9pFO1KfXJxvEdH8sR
         dcosh8KbkLesyBjNZDE+Qz26KReZpd4CpqZL+UR3Ovxv/ZMgxJKf1Tk5VaMMRopvX9Jr
         dPhV12F9umP23SB3MOy7yOONVXw1D/lStrDZqRfkfM0IR3WDw+5lTt/PChoV3Fg2q8hj
         ghFg5L9yUQSiB2wyJpzPOA19GQ1kMrW5A38ruAT6WiJ7Lofu9COn+VaFbNwum5njBUK8
         5gUYhKGGofvbuMla0GGvJ/uPPz+5op3NjegcPfe3L7t3peIF0Ck4BkA8tMYzJ0Lk4iX9
         Ifsw==
X-Forwarded-Encrypted: i=1; AKwUvBwJtJFeU5MfIagYk7R9lUB07Yq8Jx3IUPJtqCE1fwBQ2pTmHBZ/kyITepAjhBfgnux54vwk9NI=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++m0gl0AzkuKOseYoEvURI1cdjd2W2qwOx80bkD0np2UG00Gp5yg
	gOjOSLUaFWy+pg7qoN3n8H3rxRUG95C7CJogUWkT/NnKoURNI+yKEc3W+COf+1qVq8x7u0rCXEf
	xqW631f+JPjv8SlNzYaw5KjDhBUBqg3t0ysS9tpnfwOp8RO7+0bn77eWlQAew8f4moUY5js3Y
X-Gm-Gg: AYBFou3XoXP7hm6SQNfN4u9T3o1tItlLa7Bm2CchZL+p5cziqmhvJjsYqEpR5p+rL4l
	mJMQqdFYN3/lRA7SDhIpOruGo28ALH+pt4HX4tf04Lr0r5krcXrl9McoVZPsVpV1ezPmM+kUS22
	RmmfIqmDHRXfFQwwvonWdwYJ3IqvejhV2aH/CmjT9hrXRlXKyat117ddzHHbJ7FD7Sl+cci4ZZi
	aajFawOmwTJl8r8gMsGX+7Nck+DddFiPPGvQkd3qoO8WP7oHUx4mZR/+IfhuKbWkf1khnBk1ZD6
	LH3DfmwJ4kcriG9IYrdCLdG+yOncXHCdcHI/xREt5+YEHaB7/hpb2vGOnMZ6EXYr3e/4/s1tfPu
	KT/1bTXHQqTQjpFCZc3U7m+EPRiSDrFE=
X-Received: by 2002:a05:6a21:6e8d:b0:3d3:af44:ee12 with SMTP id adf61e73a8af0-3dacbf4c52bmr12033299637.27.1789029294863;
        Thu, 10 Sep 2026 01:34:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e8d:b0:3d3:af44:ee12 with SMTP id adf61e73a8af0-3dacbf4c52bmr12033198637.27.1789029294111;
        Thu, 10 Sep 2026 01:34:54 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-339770f0489sm20481499eec.8.2026.09.10.01.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 01:34:53 -0700 (PDT)
Message-ID: <f39b118b-b100-4063-bc4c-ded1f9ce0233@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 14:04:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
 <apbXKZrjFdK1vrny@kernel.org>
 <38984608-4b5c-4355-ad85-8c5a1fb78cb2@oss.qualcomm.com>
 <aqGDL2qZ0sZNMG0f@kernel.org>
Content-Language: en-US
In-Reply-To: <aqGDL2qZ0sZNMG0f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bMqDs/+Z c=1 sm=1 tr=0 ts=6aa26baf cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pUs6DziAekBCN6WXSR0A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: uMSjaLQsyeBwNPJ1PU4-3-RSI3q_H-vh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA5NSBTYWx0ZWRfX1dTWoMIX1X9m
 NB6WA9aPG9YXKVGpsTM7h8ctBfrhDBINdWG4vn42too/8If0IURS6si+bBfS1dt/Bx3tXZErV1Z
 2SKf9qwh9Rp++q1DWgDh+PLoBsQ3OkiHBI/XThHOF8AQ5vs1/ibaCDIYqewENlRQAe/MuX39Fsx
 F9qh3wvIJtCGRgPssVZHnotK3HefffW5j9RSqnGsjG/yYsMY8VF5mCQqGH1DFJDVot1aQGE4AkW
 BAizmveRTy+jvVYlrlo21MhoNOI6cVRX0+CMVoiRFtkl2eR/2DJea5DdF7ThlU5V4yHpFyNK22W
 YWY4Saa+W4RIAERBcYr86QyWqMAX7mho4H1CE9oeYnuUUEXYWBt5zDkex83PE0xmKcFx0c9qzw4
 /Oz7hnFJ9/C3Kb7QxQkUjPwfVrIfSjipHncPIJs1ijF36aZHyNgLW4lmOUzsPVVtXveQ94qltqx
 PoTn6IEvmk+Lkc7VcKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA5NSBTYWx0ZWRfX/Ez+56uLxQSs
 w54y7eXsE8XdZo/LYBsQE+B6n+MDm8I8k9SiM5RR8bJd7x/bs5q6Lw3lL0lLKwMCjsJe7WZNO0x
 4qITgCO94NIhW3vVXqG9omS0jbp0gTk=
X-Proofpoint-ORIG-GUID: uMSjaLQsyeBwNPJ1PU4-3-RSI3q_H-vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100095
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.03 / 15.00];
	BAYES_HAM(-2.93)[99.71%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	URIBL_BLOCKED(0.00)[qualcomm.com:dkim,mx0a-0031df01.pphosted.com:helo,mx0a-0031df01.pphosted.com:rdns];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E774044A3E
X-Spamd-Bar: ------
Message-ID-Hash: 3DJFFGRPV7RLRXZJEV2ENKOKJXW6RABS
X-Message-ID-Hash: 3DJFFGRPV7RLRXZJEV2ENKOKJXW6RABS
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3DJFFGRPV7RLRXZJEV2ENKOKJXW6RABS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 09-09-2026 21:32, Jarkko Sakkinen wrote:
> On Wed, Sep 02, 2026 at 02:52:17PM +0530, Kuldeep Singh wrote:
>> On 01-09-2026 19:16, Jarkko Sakkinen wrote:
>>> Short summary has a different driver name that is implemented i.e.,
>>> it should has "tpm_qcom", not "tpm-qcom".
>>
>> True, let me make more generic like "Introduce Qualcomm TPM driver"
>> instead of having driver filename in commit title for any confusion.
>>
>>>>  MAINTAINERS                 |   7 +
>>>>  drivers/char/tpm/Kconfig    |   9 ++
>>>>  drivers/char/tpm/Makefile   |   1 +
>>>>  drivers/char/tpm/tpm_qcom.c | 371 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/char/tpm/tpm_qcom.h |  82 ++++++++++
>>>
>>> Rename it as tpm_qcom_tee just to be aligned on how Microsoft's fTPM
>>> driver is named.
>>
>> I'd say firstly microsoft ftpm driver should be renamed.
>> For example, MS ftpm is based on optee(session based context) whereas
>> Qcom tpm driver is based on qcomtee(part of same TEE subsystem but uses
>> completely different mink-ipc based sharing mechanism).
>> So, it's completely different driver compared to MS.
>>
>> My suggestions:
>>  - Rename MS driver i.e tpm_ftpm_tee.c -> tpm_microsoft.c
>>  - Rename Qcom driver i.e tpm_qcom.c -> tpm_qcom.c
> 
> This goes for argument using tpm_qcom.c but we don't rename ko's in
> normal circumstances (unfortunately so).

Sure, we can keep tpm_qcom.c then and don't update tpm_ftpm_tee.c
I hope I understand you correctly.

Kindly check v2 posted after addressing comments for latest.
https://lore.kernel.org/lkml/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com/

-- 
Regards
Kuldeep

