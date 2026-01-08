Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C07CF6AB8
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 09:47:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7BCB84FF9E
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767865629;
	bh=kyS735lkzRm6iP9gLn878Rc7C/XLkvz6f+70xRRIC88=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=PuqpV2D9eOffCnz/SaceLRNdQL9KmnnApL93wjLRKxLyaqSs0lU0sOkYgt6HEtCvz
	 uG7CWy9xgekIz7QBZH7tZjqbPXSqkj1k0C1mhNaIrlfL8CVgS1KpKE2P6I6u5e3sU9
	 8QwZU1ap//Hypf5nTHQuWAwb+OFImqNsOD6MWFf/ir1OT3j+2S3CTt8Lj278GW2xQb
	 oxJmtw6mMdqcxV8okBYXoczydy6425Syu0/iJcGVNOS395hp7n8Se9vKKr2RUqAHjK
	 u2gKXc2GZSv6XNTS51p77oRrnIhHjqRJXSdTbXPULbGTgVkiO+UQ1Q4rXykrBgjrmq
	 T8skOdFZAfEFw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 854584304B
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Jan 2026 09:46:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dY4AhZT4;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=knnqRJ1+;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6088hBTF4049342
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Jan 2026 09:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B7V3RcisA+op3cY+VwOP9SxMwcFSGf1FmApbA3k+wkc=; b=dY4AhZT490YJjHcb
	smBudkm+YGRizvHAt8fVw6uroZVavNUnkgkO3S1LRKFoPOnOMt20qnXbGzY81eLu
	GZi/7U0Eb81+x7Ogeoe6K+OXJ11NzBItVkqpu6/aNFkwoO07R3oZWGykjxWE3ZTB
	dXt9bKlklZlMduNGy7A6dpmx6gLhhAaEpD1KaCxhHTbsoG5/7AOfXmFvbHiotTXf
	3PPf9vL/XvPAhJo3C9BNk4W3ggJQrV3ppPpJwUAJuqX//VQAVXVB6lHqPAaKROMa
	W4stTbyq5KlNyzCseN/whb4Ya557uGlWjHxqAPwbE+s6FB9K4sWWFbJttvmwTwsl
	NOe/1w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj2n8hgcj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Jan 2026 09:46:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7ba9c366057so5854956b3a.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 08 Jan 2026 01:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767865608; x=1768470408; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7V3RcisA+op3cY+VwOP9SxMwcFSGf1FmApbA3k+wkc=;
        b=knnqRJ1+JmJ8itHOgGBPjUfUl82aE0ptUDEwsa8c8u82dg4GQpSmSr2hrVEtLQWU1X
         PBT+Q5DfqZcrATlo19XaY4kSAKWHExEAcN/LaNzSbasBA8lBBFn7wvjUN8/JeycgvtP9
         7OIW/VF/MsUWAAMb9+lV4rBlzrMLCUqWPAPc8j4G4SqnLmvfJrMkYrL5OiwmVEZT4/XO
         jQPjPIbuDTjkHv+tH1tApIduKHfdQ95+BXkzirG3DOinX95J8pPUQgs1F98fUDo3ul9Y
         WDv2PzNbvlJYgeHrM8KzMXAMaSFL/hYSwsS26kYrEDO9GbMYR+PAm53grhh7ezuuNv+3
         a/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865608; x=1768470408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7V3RcisA+op3cY+VwOP9SxMwcFSGf1FmApbA3k+wkc=;
        b=bR7R9Xe1mdi/HJFPmNasjlAYPvbNRQtXtXlh8026p/UY8fEg+Nrvlr42ESgEHl5i11
         /0Op/++0IVFoABvy+3dJzYuA5g0DntsCGvrCa+LgYPcdUKlbSDhs+DzSDh0Bwq1w4mth
         QgVtQSVGKAhZw+1rS/gbJbewYCwJL44SG4DMVaM7YtKySpnoAHZcymXKkdYjDb1Y+eWL
         NgDThF0L+xtuH7axGunlnXxt7aam712hFY9WjlkhRwAIaxDJo1u1aEtcXJe77Ou46o5w
         jifPoZH4wuJrryYdT9YHD6Z1TZyxdTQ8YPvKQNOGB2P6YG7hLcVC4xFnavoWMUNVpKLx
         Ozwg==
X-Forwarded-Encrypted: i=1; AJvYcCWBLptWFeCrCqfNp/FxuzVW61LwpF3XciJsKZFt+hlriNj3nX8NjCNvnz/X5yC9llg80xK7o+I=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwbW9PDTi1Aiw0L9lEFbqy4+QPXK5oo1B59DXpgUj+jB/J+vt7Z
	QI8rduMvo8w7BXP7zabUVZm9Zm0xgs5waY40wTVoOSdlRpVs0oWiM6yC/gpahPZ2cpCZ0TZJmxU
	yoITt2FRvy0+eHDxed20DfMuy+MVgmNH/kvTDt7YK2gBr4I6V4P8UWXfPAniM8OYvdCBU3p5E
X-Gm-Gg: AY/fxX6lQFSVw2RkX3D//lJTqcm98pQQS9rwd9VneQiHo1bIQVO86J+8RbXTlFVmAsC
	Ez3ZDGBGRuGehXfahbaj2OXDcgOfRMUR264TQjlPnpHecBDRFxzSbBsw3G+pql5vygqhYK1Q8VV
	s4qwXw4mC8vSbY2uSRYcSWS9rwQ6XmexDW9DxNqz3cZG7dfO6HUxi7/N4jjtLHQIa6hRtQu5zN6
	bhDDtY9ts2xXVzQogECnn+ueQ1pKruozTtsnTK5SS2R8NCNWMuvqIIWCtCCwPIIeEDDuPJTFLLy
	4dlr8TQC6aFJMmAonsCqWur6PpCLTIQSi4uNA0i6tYByO0mDYYr/jijWpf52gmj1xFL7ZMru143
	l8jVYh0VhcS2kTlwbvD1RUTuRRYy8vdIehjcnya0=
X-Received: by 2002:a05:6a00:8007:b0:7a2:7a93:f8c9 with SMTP id d2e1a72fcca58-81b7de6086fmr5353479b3a.27.1767865607692;
        Thu, 08 Jan 2026 01:46:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMZpHyMO+jdm/lDEV75xA0kO2dYVAcx5zTcm+aIoS8vyPZx1Jc5H2YpY2OAqdGeFrva6OiKw==
X-Received: by 2002:a05:6a00:8007:b0:7a2:7a93:f8c9 with SMTP id d2e1a72fcca58-81b7de6086fmr5353457b3a.27.1767865607191;
        Thu, 08 Jan 2026 01:46:47 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f8b0csm7224645b3a.35.2026.01.08.01.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:46:46 -0800 (PST)
Message-ID: <735267c2-91df-41cb-9b53-97f8cb0fa8fa@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 15:16:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
To: Bjorn Andersson <andersson@kernel.org>
References: <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
 <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
 <aTtvHYDOny33yeOD@sumit-X1>
 <0a4368bf-40a2-42bb-b538-6e64c11598e3@oss.qualcomm.com>
 <cr5ryvw2zblk44zxb3cbwqglhqs5gq4iy6gcfjrofdal5khvsr@g6txeiqgoneu>
 <5a064c67-2c15-4ab9-ad34-a56a2e0ec150@oss.qualcomm.com>
 <a27tcbxmv4pwwvtxddeerrps6nasqpah35mzypz3p5ju2awigg@owrhgvasvuhe>
 <83ec99c3-ab34-4344-ac60-084a85e4fb2a@oss.qualcomm.com>
 <vro3jecpe27dxtkeqsjhpdouqju2rsc5jeqyoxefyfbdx5pahx@rqrt4hzqjrqo>
Content-Language: en-US
In-Reply-To: <vro3jecpe27dxtkeqsjhpdouqju2rsc5jeqyoxefyfbdx5pahx@rqrt4hzqjrqo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d+j4CBjE c=1 sm=1 tr=0 ts=695f7d08 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8
 a=420Oibe_mZBiAEJleGoA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: zVSnpVVxVIEkFO63IUA-MrF4sLxiTFEJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2NCBTYWx0ZWRfX7nkGUedZj4e3
 V21y12egiA/pj3MUu8IBZTEmhvPk+F4TZlIfH+7O2E6mtRTtgFSPjFjPtmago3y88bJI04zzeww
 k/jrUEBe8pJx9Mnp9qtb7qaAR7VwQQrgRD/P3FiGiQMmHWc8Bx1kAiTemx/XHuTkDQby3wBK2Jr
 f2ztlxQuTP+u98BdzqyzNKVxjisqfY9+r8TbriweWGWbcWyN586HPe+r0DaJo/DaVRej4TNaiXI
 nJvl8Csmc8M+MzlmxylUMKHCIT13zbDZkkQ/7I6un62mffIW6AZy7luJw2ltUBx4+uj9912hHHJ
 Gq1ZwuheIfZsep0lrINB0AVfJT81CyalcECvA10uwWpFoWre1U7nGN6SjK0B8NbzrxhldI+782x
 pb50JVxrUO5g7UE03dnOzD4L/olH8Un3EwbS33haucvORdzSPHUod4G6l4SKZ7SzvhWHATsnCvz
 2/XkS1H7ALiYMIFsBPA==
X-Proofpoint-GUID: zVSnpVVxVIEkFO63IUA-MrF4sLxiTFEJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080064
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TAGGED_RCPT(0.00)[renesas];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 854584304B
X-Spamd-Bar: ----
Message-ID-Hash: N7P7A5STBX2B2YCJR5UNOIUXTQCQREM2
X-Message-ID-Hash: N7P7A5STBX2B2YCJR5UNOIUXTQCQREM2
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/N7P7A5STBX2B2YCJR5UNOIUXTQCQREM2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi,

On 1/7/2026 8:34 PM, Bjorn Andersson wrote:
> On Wed, Jan 07, 2026 at 11:50:33AM +0530, Harshal Dev wrote:
>> Hi,
>>
>> On 1/2/2026 11:53 PM, Bjorn Andersson wrote:
>>> On Fri, Jan 02, 2026 at 02:21:57PM +0530, Harshal Dev wrote:
>>> [..]
>>>>
>>>>
>>>> I agree that the defconfig change effectively enables the driver for all arm64
>>>> boards, not just Qualcomm SoC based ones. To clarify this in the commit message,
>>>> let me explicitly state the following:
>>>> - Why we are enabling it for all arm64 boards.
>>>> - From which Qualcomm SoC onwards the driver is applicable to.
>>>> - What functionality the driver provides.
>>>> - How it's functionality has been tested and on which board.
>>>>
>>>> "
>>>> arm64: defconfig: Enable QCOMTEE module for QTEE-enabled Qualcomm SoCs
>>>>
>>>> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm Trusted
>>>> Execution Environment (QTEE) through the SMCInvoke interface, implemented by
>>>> the QCOMTEE driver. QTEE runs in the Secure World domain on ARM64 CPUs and
>>>> exposes secure services to Linux running in the Normal World domain.
>>>>
>>>> This change enables the QCOMTEE driver as a module to support communication
>>>> with QTEE.
>>>>
>>>> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and executing
>>>> a Trusted Application via tests hosted at github.com/qualcomm/minkipc.
>>>> "
>>>
>>> This commit message looks good to me.
>>>
>>> It also makes it clear that all platforms up to (not including) SM8650
>>> _only_ supports QSEECOM, and hence makes it clear that we have reason to
>>> support both mechanisms.
>>
>> I agree, before QCOMTEE driver, QSEECOM was the only way to communicate with
>> QTEE.
>>
>> I hope everyone else is aligned as well.
>> I will send a new patch version with the updated commit.
>>
> 
> I said the commit message looks good, not sure why you will send a new
> version.
> 

Yes, I understood that Bjorn, I meant to say that I will send a new patch-set
version 4 with this updated commit message that you just approved. :)

> What I wanted to put in writing is what you're saying - that all targets
> prior to SM8650 will only use QSEECOM - something that was contended in
> the previous discussions.
> 

I believe this the earlier statement from me that you're referring to,

"Based on all this, I am thinking perhaps it would be better to say that the
patch enables QCOMTEE driver for Qualcomm SoCs with arm64 CPUs? We could drop
mentions of specific SM8x50 models with HDK/MTP boards since the feature is
agnostic to those?"

I would like to correct this and make it clear. Not all Qualcomm SoCs would
work with the QCOMTEE driver. This was also demonstrated by Sumit earlier, when
he tried to test the driver on db845c and failed:
https://lore.kernel.org/all/aCRkRTMFi65zBODh@sumit-X1/#t

This was because the QTEE firmware OS version on older Qualcomm SoCs does not
support the SMCInvoke protocol, and so QSEECOM is the only way to talk to QTEE
on these platforms.

The SCM driver dynamically checks for SMCInvoke protocol support during probe
and does not register the 'QCOMTEE' device if it fails to detect that support
from QTEE firmware OS side:
https://elixir.bootlin.com/linux/v6.18.3/source/drivers/firmware/qcom/qcom_scm.c#L2203

So yes, for targets prior to SM8650, there is no guarantee that QCOMTEE would
work for them.

Thanks,
Harshal

> Regards,
> Bjorn
> 
>> Thanks,
>> Harshal
>>
>>>
>>> Thank you,
>>> Bjorn
>>

