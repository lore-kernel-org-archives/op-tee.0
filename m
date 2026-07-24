Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90298C531FA
	for <op-tee@archiver.kernel.org>; Fri, 24 Jul 2026 09:14:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A043B44FB7
	for <op-tee@archiver.kernel.org>; Fri, 24 Jul 2026 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784884440;
	bh=w67qQqAdyi+Ybj6XnYCPF6f6f2EUvbXPSmE7iRSVj0E=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ulsAj8t+QEorfzqOup9PCPy++dkwpWr/0RATe3EhebQCG37FKQ9Omi7drUfpJUpzr
	 3ATq2YhYdHMYAmnJ6ajxSVYBo6TJSn+8AMkB1UEFAOOqTJthk1OjRIo+QKwlD36FgH
	 yR8Tfv9NgEkB6hx8qyMESLR86/5iF2dKd018U4bV3fxKyYkp2gIl6pv/Gaf1FLSH4y
	 TE0kTAA2Ui6jjWhVA2cqs8AjMj3OmKgLz+3eeZiqVljmydPbBv9+21MOq1trFuN4Eq
	 ay1mJamt9DgkkR+FSXU06XUc6nFpk/NAue7TLa80bP4EFFqcoJPIIi2rOYt3vbhTs2
	 s4MC8OvZs40Mw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4842443154
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 09:13:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cRa09QiH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ih52gaUq;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lJBI2276380
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 09:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9MgK1U5jSAS3Ah9+XNNPIqVUrC+U6xsLSHjHBFRHiBI=; b=cRa09QiHLf8wemDg
	G5YZe+SBLqeLUoCqmqNuF7HDcbtoyrxhYuvBu7qK8AXutKsr4CjD2UTfG/ISKy3J
	bAgYbsoC1zNhicR/kVK43UIruM5sCk0j4A8u7qt6n02u8vZZjdi5zMwHPBjxTldU
	uw0tE5AcNYMpaLwRhF9OyoCaZZKWmizvTlYFqRfPkntzyyTMkg6sBWg//twcl8Cq
	E2iJcsstAdYQwpG3Vz5bCpx+dx594Bip38RlRmKhXbz0elfYs6HKuoCfr3ZaTj5X
	RqHUOlcyJ/kLQF31tW0I2b5YklQB1ZkrMh54N1cYeV9W8c4YZXetPTYQKeMVH/bF
	y0tJ2Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0b0v9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 09:13:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so305499a91.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784884431; x=1785489231; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9MgK1U5jSAS3Ah9+XNNPIqVUrC+U6xsLSHjHBFRHiBI=;
        b=ih52gaUqx99y3oYwxDQnRUTsNYP0WStt2mZRuw9Dn2oV1iIZkydMBIcanmwbpq7gs5
         QpevUhwoUhY7d8qBoHQ48MEeq7FGHSUFV0QpD5FdpbmyCVjlxSu3mqB37t46GoU+YGtf
         YYFBPE8d7X/+5MD9M9MVAfr4rqJrYn/BuLX5tP/hnRH6oYiqaRE6CVm3JgrrTgOwlr1H
         M02TCcmvLag8NK3LcK0lXQptagqcn16xSqONS/mtUl9cudvTe6YIsbEYUHnXdvNdyfmW
         oLI46LdIyks93HXPbzNywsL9+5jFQD5XEAxzzNODKMip7djajBaTUo9wXlbq8fEuxWxJ
         79xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884431; x=1785489231;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9MgK1U5jSAS3Ah9+XNNPIqVUrC+U6xsLSHjHBFRHiBI=;
        b=p/9+sNXiiajtiXcea3de5p0+9vl/w0OESWvYPooXswMR8x8PL/dR8G1GQc1CD0Y15i
         uz4kwJI8kn+mDoxLsPl27cswWFXjrlWZR6Exela6cufUST7VrTAi0NyA5RcRvHCz2Inl
         H+fJYVz91TVgANFdqHau6g3TcwfWLV+RRGDXUEm7bgukDSh2qqEX8rH1Wq+biYBwaqe5
         GfXDxqp9IdVrZz8FzTZaUdwN/RI3dNXCDqaYN4czrWLHaEKTeN6om280ZIM++1sg25Gc
         5j0DW9Qqss6VDBLi1dSSuX+ENTQWbYGPmnfS+nyqrpKGYUoPHc4IrJMHPRa9x3/BaOOF
         B4bQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2OyEPd2dnOifWH24cCfgB9OwE0gKb8J/b8Mfab0Jirm71Erd9m5rl9sSc/LC4l9OP1sNOxH4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyv9zoO0WpbUOOtt2lf23yqingcLjSI2OXo9gunP0jnvmzE+kt6
	+nayg6qHaCb2RNCGKAwniC6NMlGShlknEbdrgqoWPz3632qUGF+fAn9cBbO+a8p6U416DkSZqn6
	mopF0JXC4wjgdq8DT6W9xci6znYiACGKqwe/rXooPI0YQPvOmGBwlbSK8DYIj1JJtqEtrNbh1
X-Gm-Gg: AR+sD13WA4+9ljFRaZhBozXjYuPn11lBw7yJHXLpF2572K6KEQLW3JQgu3QfzXRF+BV
	Xg3h1cNiCytHb2/lAJc0PozWkoNEdDdMurpAcfiNHRURP1QNfHAGrk7irfFvI0p1/gzEJhHg00p
	hyFlXFZLXXMUswgbQlTvyMqr/n4iuwEejEtdD/6j08ks2u8XRs0GigeUK+hcuIu1xoJSB0YwS0y
	ErALqrRY2D7WDw2PjAWfT5gRFYgO1mEpbv7o/gdW1iRLYKG+xEoGVQ8EIFwIdQdZn7vJec173G3
	1FsklPp1NCJ5/XuaxPBN6IHnv5u6FU8NYjNVUFNpPsqYe+JZz4kfLFW8ykoSByxd1rJWCYzVjKu
	YKMJRjE7CGGeWksHqMM0Buni+KhU=
X-Received: by 2002:a17:90b:1643:b0:387:df8f:1408 with SMTP id 98e67ed59e1d1-38ec65ed975mr7199262a91.41.1784884430971;
        Fri, 24 Jul 2026 02:13:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1643:b0:387:df8f:1408 with SMTP id 98e67ed59e1d1-38ec65ed975mr7199216a91.41.1784884430398;
        Fri, 24 Jul 2026 02:13:50 -0700 (PDT)
Received: from [10.92.203.75] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f08df8a94sm389306a91.2.2026.07.24.02.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 02:13:49 -0700 (PDT)
Message-ID: <db27820a-2b43-45e4-bc4a-0e9e81aacd93@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 14:43:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add TEE based client driver for UEFI Secure
 Application
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <nfijwr2ptpxqvdw625yedep7tmakwvkeavyeobrmig5hbkw77w@rcqyp7h4y327>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <nfijwr2ptpxqvdw625yedep7tmakwvkeavyeobrmig5hbkw77w@rcqyp7h4y327>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xALoLfEw7QcEUY-h01gB5-5m3yGDuPPT
X-Proofpoint-GUID: xALoLfEw7QcEUY-h01gB5-5m3yGDuPPT
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a632ccf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8 a=EPKcpx9xAAAA:20 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=EQysn5-VQ2r5Ey136RIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22 a=ZT_8zCgGubuJgGonBfBE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfXyHCebfDMm361
 Zxw4uIuUhNp0m2uNW84KKhSGUEm5Dg3KanD/7TfGa6k6ylH2nPLLNx6+dGsCYt+bxF9kCsc9m/Y
 HcEC8Uj4Ru0h5Nc2VGvv5qGAlZlGGSGgLMj4MB5QWF8pxCmhhT93T/fMPsJSlDV9maFZXs/40E1
 /TpFhRMq49UqLghNEcCSF57xJNb98NWzOHAENM8XpQrx/QajJuU65wmsW72hhSLv198GjQQqi5e
 xlKrjm4iNsZYpB6tMpNqWBceySYdespL5cMAUkjAtF1p+DRI2wXbidlsyC2J2TaDc/AUpnOSeSA
 Ap8gOnEHqfQGMqRTVbq6cLtR/6t2lxAtD7gUmI4yjvPrDDNndX7Xpp0Om25GMoSXL0xvlYyrbuz
 Gw91Y87fkmcNwIfM8Be7T40I9Ws7q4j+jFE70zErS+f9Sx6gIW1MJckL7pp9pVL78XsBVTszMbJ
 GN4MXgc2kbc8iLMWRMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfX+Dx6P3WVFuSr
 fgnIrzPonO4fvcHWuVo4OI3uE9nOOnLhZjXpEqf0c7NiGlE/bQjKpi7Do3LUd9L3mjxYb3C7/sR
 0G85zbVG6SMivJz/f6n7vT3bfy+4Nyw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240083
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REDIRECTOR_URL(0.00)[shorturl.at];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	HAS_ORG_HEADER(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.216.70:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4842443154
X-Spamd-Bar: ------
Message-ID-Hash: JEBI7QT6CGXOLYVRLJH5HBOTN4HILKFW
X-Message-ID-Hash: JEBI7QT6CGXOLYVRLJH5HBOTN4HILKFW
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JEBI7QT6CGXOLYVRLJH5HBOTN4HILKFW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Dmitry,

On 22-07-2026 01:56 pm, Dmitry Baryshkov wrote:
> On Wed, Jul 22, 2026 at 12:29:11PM +0530, Harshal Dev wrote:
>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
>> Replay Protected Memory Block (RPMB) which is only accessible by the
>> Qualcomm Trusted Execution Environment (QTEE).
> 
> Is it so? I think RPMB is accessible to Linux...

I should have been more descriptive here, RPMB is accessible by Linux but
its frames can only be prepared by QTEE.

The RPMB key which is one-time programmed into the storage controller to allow
authentication of the RPMB frames is generated by and only available to a TEE.
So on Qualcomm platforms (and many others platforms with a TEE) Linux can only
route the RPMB frames generated by QTEE to the storage, it cannot create and
write the RPMB frames itself (it doesn't have access to the key).

While it is possible for Linux to generate/program/store this key, on Qualcomm
platforms we do not want Linux to do so because we do not trust it. We trust
QTEE.

I will re-phrase this and make it a bit more clear everywhere.

> 
>> For Qualcomm platforms without emulated RPMB support, specifically
> 
> What is emulated RPMB support? Why is it mentioned here? Which platforms
> use emulated RPMB?

Emulated RPMB refers to RPMB on a storage which doesn't have its own firmware.
Primarily, NAND/NOR storage. Unlike UFS/eMMC storage, NAND/NOR storage does not
have a storage controller where we can program the RPMB key to be used by the
firmware. So we must 'emulate' RPMB by moving the storage driver within QTEE
and making the driver hold/use the key.

Qualcomm compute SoCs (Glymur, Hamoa) have RPMB available on SPI-*NOR* storage,
and a driver for communicating with it is also available in QTEE. And so, these
have 'emulated' RPMB.

I will add this detail in an updated cover letter.
> 
>> platforms where RPMB is not located within SPI-NOR storage and instead
>> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
>> a callback request from the UEFI Secure Application to the RPMB service
>> running in user-space (within the QTEE supplicant [1]).
> 
> Can it be moved to the kernel?

We have a plan to move the RPMB service to the kernel similar to OPTEE:
https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/tee/optee/rpc.c#L449

It is a work in progress. Once this happens, we don't need QTEE supplicant available
on the Linux distribution.

> 
>>
>> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
>> QSEECOM based uefisecapp) does not support callback requests.
> 
> How did it work then? I think Windows has been perfectly using QSEECOM
> rather than QTEE.

It works because Windows on Arm on Qualcomm has SPI-NOR storage. A driver for which
is available within QTEE, and so QTEE does not need to make a callback request
to Linux to request RPMB frame routing. However, in case of UFS/eMMC storage the
driver only exists in the Linux kernel and so QTEE must make a callback request.

And so, if you try to use the QSEECOM driver to write EFI-variables to RPMB
on a device with UFS/eMMC storage, it won't work.

> 
>> And on
>> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
>> QSEECOM interface fail due to lack of support within Qualcomm TEE.
> 
> So, I assume, on RB3 Gen2 the QSEECOM doesn't report uefisecapp as
> supported. Does it?

It doesn't, this API returns -2 if I add RB3 Gen2 in the allow-list for QSEECOM:
https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/qcom/qcom_qseecom.c#L46

> 
>> On these platforms, a TEE based uefisecapp client driver is required to:
>> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
>> 2. Ensure persistence of non-volatile EFI variables via writes through
>> the RPMB service hosted in the QTEE supplicant.
>>
>> This series introduces such a uefisecapp TEE client driver for the
>> aforementioned Qualcomm platforms which installs efi-var operations _if_
>> the QCOMTEE driver registers support for an object-IPC based uefisecapp
>> service on the TEE bus during its probe. Only new QTEE firmware versions
>> available at [2] provide this support.
> 
> What about existing WoA devices?

New Windows on Arm devices like Hamoa/Glymur work perfectly fine with existing
QSEECOM based uefisecapp. But they will also work with this new QCOMTEE based
uefisecapp once they upgrade their firmware.

I need to double-check but this firmware release for Glymur on Qualcomm Linux
is probably carrying the support for QCOMTEE based uefisecapp access:
https://github.com/qualcomm-linux/meta-qcom/commit/728251fcbe5113980805ea6c571e33235062ee71
If not, the next release will definitely have it since I have merged support for
this in QTEE and talked to the boot firmware release team about this.

The next planned firmware upgrade for Hamoa will also provide this support for
Qualcomm Linux. And similarly, for all other targets being supported upstream.

> 
>>
>> Thus, QCOMTEE now maintains a static list of always-available object-IPC
>> based secure services exposed by QTEE. These services are implemented either
>> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
>> usually loaded by the bootloader. The uefisecapp TA is an example of a
>> preloaded TA loaded by UEFI. A static list is required since QTEE does not
>> yet expose any way to dynamically query and enumerate the services exposed by
>> it.
> 
> Can it be fixed instead of having static lists? In the end, we can't
> guarantee that users update the firmware.
>

Unfortunately, no existing QTEE release out there currently has this support.
But support for this is currently being added by QTEE team last I checked with them.
Once it is available, and a new QTEE firmware release is out there, we will add
support for dynamically querying QTEE services in the QCOMTEE driver. 
>>
>> To facilitate object-IPC interactions from the kernel-space, this
>> series also introduces a tee_client_object_invoke_func() to allow
>> invocation of TEE objects similar to the existing tee_client_invoke_func()
>> API exported by the TEE subsystem which allows invocation of TEE functions.
>> Some suporting changes are also introduced to track and handle operations
>> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
>> driver.
>>
>> Finally and as previously mentioned, access to the object-IPC based uefisecapp
>> service is restricted on older QTEE firmware versions. A new QTEE firmware
>> release must be picked up from QArtifactory [2] for all upstream supported
>> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
>> driver.
> 
> What about fused devices?

The procedure for updating the firmware on fused devices is slightly different.
The firmware images need to be signed by the OEM using the security profile
of the chipset before flashing/upgrading them. Security profiles are now public:
https://github.com/qualcomm/security-profiles

Regards,
Harshal

> 
>>
>> This patch series has been validated on Kodiak RB3Gen2 platform with UFS
>> storage by attempting to read/write EFI variables via the efivar tool [3]
>> after mounting the efivarfs filesystem. See [4] for an example.
>>
>> Merge Strategy:
>>
>> This patch series could either be taken from the OP-TEE tree or the
>> QCOM soc tree. I would prefer it to be picked by the OP-TEE tree since
>> all except the uefisecapp TEE client driver patch in this series make
>> changes relevant to the TEE subsystem. It would be great if the QCOM soc
>> tree maintainers can Ack the uefisecapp driver patch.
>>
>> [1] https://github.com/qualcomm/minkipc
>> [2] https://shorturl.at/zQU07
>> [3] https://github.com/rhboot/efivar
>> [4] https://docs.qualcomm.com/doc/80-70020-27/topic/manage_uefi_environment_variables_using_efivar_tool.html
>>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Drop using MSB of the object_id to distingush kernel and user object invoke contexts.
>> - Introduce enum tee_object_invoke_origin to check the context of object invocation.
>> - Link to v1: https://lore.kernel.org/r/20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com
>>
>> ---
>> Amirreza Zarrabi (2):
>>       tee: Add kernel client object invoke helper
>>       tee: qcomtee: Allow object invokes from kernel clients
>>
>> Harshal Dev (4):
>>       tee: qcomtee: Track the object invocation context
>>       tee: Export uuidv5 generation for TEE backends
>>       tee: qcomtee: Add support for registering QTEE services on TEE bus
>>       firmware: qcom: Add support for TEE based EFI-var client driver
>>
>>  MAINTAINERS                                 |   7 +
>>  drivers/firmware/qcom/Kconfig               |  24 ++
>>  drivers/firmware/qcom/Makefile              |   1 +
>>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 525 ++++++++++++++++++++++++++++
>>  drivers/firmware/qcom/qcom_tee_uefisecapp.h | 120 +++++++
> 
> I don't see any changes to the QSEECOM drivers. Is it allowed to use
> QSEECOM and QTEE access to uefisecapp at the same time?
> 
>>  drivers/tee/qcomtee/call.c                  | 205 ++++++++++-
>>  drivers/tee/qcomtee/core.c                  |   9 +-
>>  drivers/tee/qcomtee/qcomtee.h               |  12 +
>>  drivers/tee/qcomtee/qcomtee_msg.h           |   1 +
>>  drivers/tee/qcomtee/qcomtee_object.h        |  16 +-
>>  drivers/tee/tee_core.c                      |  24 +-
>>  include/linux/tee_core.h                    |  23 +-
>>  include/linux/tee_drv.h                     |  18 +-
>>  13 files changed, 952 insertions(+), 33 deletions(-)
>> ---
>> base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
>> change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014
>>
>> Best regards,
>> -- 
>> Harshal Dev <harshal.dev@oss.qualcomm.com>
>>
> 

