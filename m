Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76F1CA5FE2
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 04:40:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CDEB13E882
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 04:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791175239;
	bh=piSaU7u3lxuizoSGNuH8VAp/jRAKZ+r70tRHdIWnQ7Y=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Y4QxdchP+PDxUzhBfNbgyni2yQVY2Awaefm6e+AULCx3shioioFPVWl/iPHUm2gnh
	 FnmRx5Y6II1Ay+qJhQOQqqVRISTne9UY0SR5l5ftDaD05AS8BW5AdA13adI+EMqeHD
	 g0VP67UFXPBLq74tFJTbOTo19nyOYvrqiFfzmIaaVcdYT04QGmG/T5YXCekRsKMC68
	 QlOF8PN/MA+Gvt//frth595uz66Py+5OdFFXGMkFGKXhyJi4Kfspi4vpOwHqzkHi8S
	 xyZmnMpgyGDWf4HMKmc0mA7oDR0YR2Zck59nIf7oGEZBiZBr6QBgSufRUfsaX4PQpI
	 USjM2fsdPnD2A==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 175263E882
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Oct 2026 04:40:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HoCWsO/K;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P9dg8Fg2;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69510E1h3838666
	for <op-tee@lists.trustedfirmware.org>; Mon, 5 Oct 2026 04:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ggULz4vwBuAHbZ84stjLwWZOA6YU/jtZhLLCdwL/6OQ=; b=HoCWsO/K4DcT1JHg
	ToOSHG1E/PeC1om45hN2LMzIegegjucR+mky2N7TXY0jNDwZCeZ8NdN3iTKan3xV
	WuWmnV/Nv5HQaA43Noz8LSmAD4PJfsGiODHewnjkVG2NdQd7/yZJl/kNr9kaxQq9
	2uNvwSbvfBQnsotyqx0RxbpP1e2PNoHFi/D4ekWn8CnsQ7g+2Gu0BqLMdODpXHqJ
	BGsRzKXTQVzqr4XpgVmG4r311gjrj++hnq94/wgA8/YS1sxHxFwi+ep6452ZS5oO
	w48kII8aSZKswu7NU8Jg8hgzP4ZFvOYV1phogA6Q3aGlj125TI5LNsOFx7mU+JSJ
	j4ZauQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2u08mbsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 04:40:30 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1384427c3efso1739075c88.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 04 Oct 2026 21:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791175230; x=1791780030; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ggULz4vwBuAHbZ84stjLwWZOA6YU/jtZhLLCdwL/6OQ=;
        b=P9dg8Fg2hwdDOkVHd7mR6Vy7noPeYxmJ+w6hxJg11mpqjsOPq1RWdktac/uTPbYTgF
         HahnjyirUblimpiZ/HYIVHVP+gHAZmLn2/ch6p/Tf3GQ4VWPADPFCsHGrYtfLUzSkeH5
         hZlVG3z58ohWjsJwnmPRJPVySYU0E+JGMxVKKETFMckKL3O3OFqAalGCR0I8sTXXbN+h
         wQZXQuksbX3Z7tUNfWHWijwB7UVUCkktFiQm9vyd/Os2YMDB3CMMxCiL6hED9ojl18f+
         jojnr+H14xHSYBBP5nmDCilD8PNMI3OeImkn95OG1cNfDrwGmcdn80XvXuJFVpjZPjwL
         wnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175230; x=1791780030;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ggULz4vwBuAHbZ84stjLwWZOA6YU/jtZhLLCdwL/6OQ=;
        b=ctKZxclr/HjWJw9SiCZl9zt9xXTNfxiU1uJiLacHkYtMqnOQM1oGZxcSf0eZ7Ahoi+
         MN5azY9sAiBjCGGfnIq0YGhOTFBnotlaGjjfbA/WTKRsyLjnosH9SXp6t59XcrmNvFKE
         glV3Kv+FP0HvSDkVQFwBqWnLGRu4H3tVAMVjq/01qO67cAcC4E4Q/+leET7bhK9/O6ny
         oDrpYuFzCKsUPq8gTjRA/9f9qNABdxNqVAP/LxCxwqriK9RG5o58Z9K96HU2gG+V9ns4
         L5hSkB6e95A9MWUgC1wKXA33nhohmy4WKWWUMnAmZVhTL5rY1Pd9R3MLk/2oHb2YS5ZT
         7ATA==
X-Forwarded-Encrypted: i=1; AKwUvBzVrhm5jLfS5/dJYqnViaTYdss2Y3YYPA5l+mQIB2yMiR14Rpealwvg6nWwB2xeSSP2/NoIjcI=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++n/GwYu2jFOanoRF97aieyO7MM9gqZvetLjbYa6I+51+mOGd3Ma
	L9tQWEKQw6fM9u7fr/3/GP+cz7dZT3cNda5U+m1aKupvonwy46+2E0xHh9qfsJm0QtDuMQlM8oO
	UAdFiqv0R1M0fAYO17shW2yl5pRYIfGnRNy9zH0vAM6+lNbT1+r1tdUful4I3Fd1vjGGEQd0N
X-Gm-Gg: AYBFou0on8NBxNoNEADijm/4tVAdk/cnuLIwVDngwOWEwquPXRs1DHm9fjnB8rP3+xs
	A3Ad0/KXcwGKsAnRKn/h8MylBVMWOy8N+eloV4brOGUfFe4yQmTNx4LYdZWo3z2XHpqdC9m3eMx
	U1PH+/pMmHeYLbHogLRqsbI+6SUQRVPlpIqXB+fv2iSZNS0EYaqNjfOsMApVj6nbawfkWe0z373
	3wdZNb2tfoNUmfX5axeF0Se1T0FFR2NYfgpdfJRbPyenzEHbznRfKzC7bo6LetHWoBVLQrpzj64
	4ucGluYvV8dLX6j0pLbNsceHgXSdUuZSi5fYaKJOFvf+Ovfm697IJ8fwJFnkaDr0b7iW5AkF4r4
	Ezip19FURLTFdZ1EIPr0vIH8Mdg==
X-Received: by 2002:a05:701b:2059:20b0:144:fb87:5b91 with SMTP id a92af1059eb24-14f5d0bbd97mr12325204c88.44.1791175229984;
        Sun, 04 Oct 2026 21:40:29 -0700 (PDT)
X-Received: by 2002:a05:701b:2059:20b0:144:fb87:5b91 with SMTP id a92af1059eb24-14f5d0bbd97mr12325174c88.44.1791175229391;
        Sun, 04 Oct 2026 21:40:29 -0700 (PDT)
Received: from [10.218.26.96] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a6cbsm17981454c88.5.2026.10.04.21.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 21:40:28 -0700 (PDT)
Message-ID: <dacc806a-b7b0-4f6f-92d9-124363d480a1@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 10:10:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
 <20261001-qcom_uefisecapp_migrate_qcomtee-v3-6-13df5c20c2e3@oss.qualcomm.com>
 <6aa0c698-509e-49d5-a229-7f756355b748@kernel.org>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <6aa0c698-509e-49d5-a229-7f756355b748@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lj9uh5kL855SLGu0EBP8FxtSZQ6-703r
X-Proofpoint-GUID: lj9uh5kL855SLGu0EBP8FxtSZQ6-703r
X-Authority-Analysis: v=2.4 cv=JqlkP84C c=1 sm=1 tr=0 ts=6ac32a3e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=gJ6ZtcXeIMAt1hGiui0A:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxOCBTYWx0ZWRfX6GqPIhvVlL2n
 l0RPh3Uu3tOOjI3pVB9aCi0Cxo7kGS/Bmyj6wPO/I8+JI8xnmPI+aM3f7P3DfkyBziJlXcHxRbx
 HJGRFaZT6ps4T7RR8x7T3UoT0HURkFU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxOCBTYWx0ZWRfX8ObPiOiSsWvT
 yrPJm1Hhnlh1BL1EQB9Ej3b6OMXdiGwJhn/3VjkFAnwNkcyjynaWcz5YwPEAsoep2CTgzFWCIul
 GT449SmfmM9m2ROotHklPH2SeGYcxkQgAFHkFHm2OJ7vOs+h3jNY/bNelRMP9fCCYuu206y2Eti
 uodbBV3yJC8FBcCKkbOfvS7FDs1QDSFpgCGGKUXVA39m/GKnGq6pUroDDVKqe2fgNHYo3DCuJUt
 FI+kZjnEqL+84ceCAKM/MQEQkfNniUtQnsM2llKw7hw4mIz61WPqO3IUQ4JRkCg+siZXzXelD50
 E2M0Q5dKywxWgsLTlyxnKrg1GbMxZwGhqKgGuZ/pFIPWSeBH+MUPZHEbH+DWLmQv94+mV3Y4cff
 F5I4+CcuDIxaW1arGxnxXW58fn3UmYwYFugX4P1lEiaG4wPg7oRbEyiW6hq66E6rqRdHvREsItx
 0FW2UnraG/l5Xp3ZLwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050018
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.69:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 175263E882
X-Spamd-Bar: ------
Message-ID-Hash: D6AIWJB3GXTCKI4BNN6Z7SFRRBDT3XLQ
X-Message-ID-Hash: D6AIWJB3GXTCKI4BNN6Z7SFRRBDT3XLQ
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/D6AIWJB3GXTCKI4BNN6Z7SFRRBDT3XLQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Krzysztof,

On 02-10-2026 11:16 am, Krzysztof Kozlowski wrote:
> On 01/10/2026 13:02, Harshal Dev wrote:
>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
>> Replay Protected Memory Block (RPMB) located within either the UFS,
>> eMMC or SPI-NOR storage. The RPMB key which is one-time programmed into
>> the storage controller to allow authentication of the RPMB frames is
>> generated by and only available to the Qualcomm Trusted Execution
>> Environment (QTEE).
>>
>> The legacy QSEECOM protocol used for communicating with the QTEE is
>> deprecated and replaced with the use-case agnostic SMCInvoke protocol
>> starting with the Qualcomm SM8x50 series. On platforms where the QSEECOM
>> still driver probes, it does not support a listener interface with QTEE
>> to enable writing of non-volatile EFI variables to the RPMB for UFS and
>> eMMC storage.
>> Therefore on such platforms, a TEE client driver which communicates with
>> QTEE via the SMCInvoke protocol implemented by the QCOMTEE driver (and
>> registered with the TEE subsystem) must be used to update such EFI
>> variables.
>>
>> Add support for a TEE based uefisecapp client driver which installs efivar
>> operations after obtaining an object reference to the uefisecapp service.
>> This enables the kernel/user-space to access or modify both volatile EFI
>> variables stored by the Secure Application (in-memory) and non-volatile
>> ones stored within RPMB.
>>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>>  MAINTAINERS                                 |   6 +
>>  arch/arm64/configs/defconfig                |   1 +
>>  drivers/firmware/qcom/Kconfig               |  31 ++
>>  drivers/firmware/qcom/Makefile              |   1 +
>>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 636 ++++++++++++++++++++++++++++
>>  5 files changed, 675 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 30c1cdd0fb38..7ccedad8d388 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22981,6 +22981,12 @@ L:	linux-arm-msm@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>>  
>> +QUALCOMM TEE UEFISECAPP DRIVER
>> +M:	Harshal Dev <harshal.dev@oss.qualcomm.com>
>> +L:	linux-arm-msm@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.c
>> +
>>  QUALCOMM PINCTRL DRIVERS
>>  M:	Bartosz Golaszewski <brgl@kernel.org>
>>  L:	linux-arm-msm@vger.kernel.org
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index fce418fe6ff6..a8525878c679 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -277,6 +277,7 @@ CONFIG_IMX_SCU=y
>>  CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
>>  CONFIG_QCOM_QSEECOM=y
>>  CONFIG_QCOM_QSEECOM_UEFISECAPP=y
>> +CONFIG_QCOM_TEE_UEFISECAPP=m
> 
> I do not see how this change is relevant here. Adding a driver has
> nothing to do with defconfig. Drop or split.
> 
> Not mentioning that nowhere is explained why you actually need it.

Ack, I will split this into a separate commit and provide a brief explanation
for this config.

Regards,
Harshal

> 
> 
> Best regards,
> Krzysztof

