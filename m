Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82E4CF6BE4
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 06:20:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1A1784FF25
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 06:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767766858;
	bh=0NHR5kxSnqaD1JXy9cBtV0Ahrk/Vq4nzu3+gdILbA0E=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=f7yitpxfwJzhmb8BEBZjgnQPHDTfoR8sQJUMKe80XABmUhq0+yONvygMwzGh2bZnL
	 TlVkIuaFuU7yKLRnCGbRLabLyY8pqxrGzu0MyKLtREaWBkgh0ygW6VRbv3HGU4dbyb
	 gYnuUGGWOgB5cYpOoKeEj3lQLXTFTH8InFVB2vBK4laA/RVgQrfQ7zEdIDnnM2NIAG
	 JTtQZXrLPY6n9FZZ7q1bXUWW/sS7/TCwYRHCLCSMZ0u4dQ4o5BhSPdbo7SZaI/9I7c
	 qBxSSxDmrgahk/PmQaZbivEnLCFbOYLc2j9gZFQ9EVeNP3Hy3sq1xeAUdbpGlcsWf7
	 3jPVmqDjR03Cw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 047794187A
	for <op-tee@lists.trustedfirmware.org>; Wed,  7 Jan 2026 06:20:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J1Eq2M3M;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rm8Y5kKo;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NwQu91269802
	for <op-tee@lists.trustedfirmware.org>; Wed, 7 Jan 2026 06:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wPxReV0FVYF+dmKGnMOK2qwx9Ci/4iX/blQouO4efNo=; b=J1Eq2M3MDAfhPmf0
	5WZ9XJQRPs2j+NrskibPCeBqPZqrA48Fnaxz0dNaqGCW3zuCx7UGQ84qD2UdATMk
	rFb+QuDjJiEMAcwVlHSyoYt7HMRHI0Vsm+6rckQpobVA0XeHRP3MjYMn66VKsyxe
	pjxt57RsiCn6B6nw3fh3MX7zhy9F9a74UsjgLhhPXPg+Q6pIDLTOWtPQcBN+PBcF
	QUM/saGSQaysjbt8tgVnlph+e1Ept2YdMHdrKliftGD/lg5WPOTCAp/ppDMtLNgg
	QFwNSXxtcE3NWQl8MVQUk4t+K++B/oA8B3RGP2h1K+XfRmAGlYbnHUIPRbtyQhrs
	WDqbmA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh660t396-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 07 Jan 2026 06:20:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b9208e1976so2911135b3a.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 06 Jan 2026 22:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767766839; x=1768371639; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPxReV0FVYF+dmKGnMOK2qwx9Ci/4iX/blQouO4efNo=;
        b=Rm8Y5kKo/LnhTU7d4LpsiYQvnvg2H9DsiAD2w28eae0KxVKuCC7+448tj0Ak3wbTEn
         QtNLlN/vCOYyKecJo/7sh65jLiSdhNK1BES5HNC2Wy6UhAak/GjQbWfD+XCkPbUplw2F
         MzjGKbMcA7j0PQ1n0oG+M7QOi4uNXaIq92faY6qSoUcCM/dQm2kj0uAbBaBYsnhux3OL
         DoSlg3bF+XPLZnEKSMuJ5FvfTmCLnz1GDVks+Ft04bAP+Gp4LsIod7UBiLVb+Em95cuS
         WR0yFggtQyMFW9Brx42nJJOXiwz7an3yjVWLF2YPEr2wl5Ck2vmziVF6ScTgRddwa609
         GdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767766839; x=1768371639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPxReV0FVYF+dmKGnMOK2qwx9Ci/4iX/blQouO4efNo=;
        b=jOo1atDM7mbC6ghesIaBCS1SLYBZ7wjxzkW+bbUW2S9dvaFoX1HlozFtiiIBerWTyq
         MauOzm0+8TIleN3bqRf9eLX+2KCSn9uI6OIRFJm1ik2KH4rvyu+UqCTcgpKV7C1mGo8P
         Gr/Pcbaw3GWNBo/LhXMbxalCOUGGPv7VGfJHtkCAT2sUAaOeTT1tnGxSVnnHwXDbtBk3
         /+aMJGAuezBs6cs6eMUpHM5NPzHtC1UsOPnvzcHGCNrW3ZrjpFkHek7YXbILhMHP2QGx
         0DRJ2q2SDDSpK686xC2HiiIJG6ZKYXKNv7ZLHgXayezB75HOOhSev1qjwB6KaztclZhG
         8+1A==
X-Forwarded-Encrypted: i=1; AJvYcCV+aEe08J4C9cdEdu8xpIo9K6rYg/BkGVcUFkoKgJwoDVdsnMeOA4bSdpyRZizdhhg3OFKYe3s=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwkckYsWSLvmqHlrYa1U6kZnwApxABAJo7Wct1mlqs3jyprnmlw
	VNAapAPRy28CzeNYkZs6LXn4/7RSlK9W2Lbrvq+1/dd9aHfLU8kQHdGgrTRKj9dKB2272SbWpVC
	gg2Jez7UkqlimiUCBhsJosxPFA0prQyu6749QrJ9ZJV4YAWiyrr/q6QQniPWEYh8abG8a4dYG
X-Gm-Gg: AY/fxX5XYfefHd5SNJpXRVDcpOkAublGzVCXFIeLqdzId0soHdeCSNqhdyTvo2jK2ux
	SJjQkhnYBzH5DDSoPNXIyh04sMksWikBMmXBX3Z80Kdxvd5bUVlyvPtlf1sCSCz6T9XJ8tK8joD
	VmtBpVwxGtLhSnT6wS2lMfjBJ69CaVmoHVuT+c5kqyN945ofKwRHrJ8h7szf2bw6dkyRZpgI4KJ
	9t/uoe+q4Zdc7RWnRmDmWhmzQgg7P5aSPlK4DSAjI8y+bWnd/82fICqIzJVgdm+zRz2Zxm4HSFV
	xXa7C2SqHofRiUfcNLgQWVaAtjJtgbWp2HIfnrFiP+6xu/Gipv3roH2IC/QPgEal4CogZJINPBP
	sPvXZRipjwBHcoWGup4Dp5p8EAE2298FFtM8oYWk=
X-Received: by 2002:a05:6a00:ab89:b0:7e8:4398:b362 with SMTP id d2e1a72fcca58-81b7fdbf1c4mr1548405b3a.53.1767766838775;
        Tue, 06 Jan 2026 22:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx1lYiQhZ8gVzaVIs5EKsSIS+3M39lkVpIbE6b6T/0uy2E+DImqe/1djPdXBhx6I9rWsP9iw==
X-Received: by 2002:a05:6a00:ab89:b0:7e8:4398:b362 with SMTP id d2e1a72fcca58-81b7fdbf1c4mr1548383b3a.53.1767766838290;
        Tue, 06 Jan 2026 22:20:38 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm3856498b3a.54.2026.01.06.22.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 22:20:37 -0800 (PST)
Message-ID: <83ec99c3-ab34-4344-ac60-084a85e4fb2a@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 11:50:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
To: Bjorn Andersson <andersson@kernel.org>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
 <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
 <aTtvHYDOny33yeOD@sumit-X1>
 <0a4368bf-40a2-42bb-b538-6e64c11598e3@oss.qualcomm.com>
 <cr5ryvw2zblk44zxb3cbwqglhqs5gq4iy6gcfjrofdal5khvsr@g6txeiqgoneu>
 <5a064c67-2c15-4ab9-ad34-a56a2e0ec150@oss.qualcomm.com>
 <a27tcbxmv4pwwvtxddeerrps6nasqpah35mzypz3p5ju2awigg@owrhgvasvuhe>
Content-Language: en-US
In-Reply-To: <a27tcbxmv4pwwvtxddeerrps6nasqpah35mzypz3p5ju2awigg@owrhgvasvuhe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNptWcZl c=1 sm=1 tr=0 ts=695dfb37 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=o-UZHf26lxxCeA_mQM4A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: Z51S0Nai5W9snTAiL_SKb9TW237-zlDI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA0OSBTYWx0ZWRfX2mAt+izw48cP
 OaKK2/Ul48X2YMEIA+aSCUN5m0zgYhilxARB3m4KOvQMaLHKMCi1kUxDmiqUj9fXvHy76UVKCTE
 zgADSYe9L0m1G8nxAlynXZ9C3g3wfsCdpewEVA7dCpEPUU35jkCHzgLvshzMDSsI/4Xy0raZ4cN
 YqVGj+tX2kV0KCYux+6vJwBwIZvKbg+bGxA3IaE3T9mbveiIsqQb5CNzMiYj699HFiJUKJhAi9y
 JOLJ2e8wkPI24JDjShy7pUuQj+TuLjjYb1g5PWh7mkt/9b9D1ODjKpRBUMWJ2NqPjnKfMiEwVK6
 wzt85AnWEurPwSVNSBzNo47ZNMt+so0V3wzFUI0B497cI7EXMRo6Vsb/9GyieycqBP2tlJiBKMK
 hQi2oTbV0yzYUCVME97IzI4ifEqDXxp0Q85EmfhH1U2kLuhu42g7L8vPLCCJju0rc6vaJW1MIe+
 EZa/yFH8HtLWze32jdw==
X-Proofpoint-GUID: Z51S0Nai5W9snTAiL_SKb9TW237-zlDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070049
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[renesas];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 047794187A
X-Spamd-Bar: --
Message-ID-Hash: OF3GYDY32W4VK7HHR3R4ITQIACPQIKTW
X-Message-ID-Hash: OF3GYDY32W4VK7HHR3R4ITQIACPQIKTW
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OF3GYDY32W4VK7HHR3R4ITQIACPQIKTW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi,

On 1/2/2026 11:53 PM, Bjorn Andersson wrote:
> On Fri, Jan 02, 2026 at 02:21:57PM +0530, Harshal Dev wrote:
> [..]
>>
>>
>> I agree that the defconfig change effectively enables the driver for all arm64
>> boards, not just Qualcomm SoC based ones. To clarify this in the commit message,
>> let me explicitly state the following:
>> - Why we are enabling it for all arm64 boards.
>> - From which Qualcomm SoC onwards the driver is applicable to.
>> - What functionality the driver provides.
>> - How it's functionality has been tested and on which board.
>>
>> "
>> arm64: defconfig: Enable QCOMTEE module for QTEE-enabled Qualcomm SoCs
>>
>> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm Trusted
>> Execution Environment (QTEE) through the SMCInvoke interface, implemented by
>> the QCOMTEE driver. QTEE runs in the Secure World domain on ARM64 CPUs and
>> exposes secure services to Linux running in the Normal World domain.
>>
>> This change enables the QCOMTEE driver as a module to support communication
>> with QTEE.
>>
>> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and executing
>> a Trusted Application via tests hosted at github.com/qualcomm/minkipc.
>> "
> 
> This commit message looks good to me.
> 
> It also makes it clear that all platforms up to (not including) SM8650
> _only_ supports QSEECOM, and hence makes it clear that we have reason to
> support both mechanisms.

I agree, before QCOMTEE driver, QSEECOM was the only way to communicate with
QTEE.

I hope everyone else is aligned as well.
I will send a new patch version with the updated commit.

Thanks,
Harshal

> 
> Thank you,
> Bjorn

