Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDC7CA6017
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 02:35:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 95E8A45081
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 02:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791513315;
	bh=KOELMj0LwV5zsBTHyKOHzsraCuoji44mPg7ahaZLI+M=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=dER47bvRamS9FvY0vkANJeAIu/McvTTy3ZOMn2oigKjXOnKL+TA/HfdNykqWmlFqV
	 5JnV3zwCbWERtrrd9AqB0jRh/YZAsT0ZcEuWam93luNCDUKp9KqSkWnJBawZIUFr7m
	 dJrOuVT7mZ8uHZ+Trzlp3FnyYacmQ/IRohnaia2bfa/W0kTpHKpVefmj8prW23Gw4X
	 NbjbGi8p4YDIRU6697oTkG9Q4tE9eE2F0Onytln0OMyIiGiCQ134n40S0voqXmWbbX
	 H2Pexc8AESpsyshea9VYGDuPswaj1cKtiHCBIU7xTm22+INGz1jSweomPvyWeRKiVz
	 LM5oXIxQHG6qA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 452A44498C
	for <op-tee@lists.trustedfirmware.org>; Fri,  9 Oct 2026 02:35:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z1zsJbgh;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VK36VqZ0;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6990QEJo724968
	for <op-tee@lists.trustedfirmware.org>; Fri, 9 Oct 2026 02:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kfsweV6M9RJMr0ZZ5+OOh8EVgv6iTz3OXA+hsWJLjpA=; b=Z1zsJbghBUFErQ3Y
	uEVuwSPPz/d0ltHTkpiPQKTzSK6lZPnBd8s5zQ2Xgw0DkmBLqz7ZIRm06akmTAwA
	ayGsZUQHVJ+VAsUTZI4Qqcjs/kKKkdtTiQ7giVqgyJgM33P1wybgPd8F5Hf6fKTT
	ZsPSqdyuKgDG9gcTG9a0995ohHBu0VO5YVqMYyqysPMn6gDobFttHAMBFuD3jp0t
	CDl25n6MuiMtHZf8kgJ8sghQjIuRXwRfhgAAxXBuJ7FtlULb6jAUTMA9aPN0Y0fu
	6xbx0qv8+Lh1OsvKFXhWm6qAqWzB7v7ptCDMN4mrU+U4AzHR1075a2qZ0fKkvzLn
	W3wxJA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekv9u0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 09 Oct 2026 02:35:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a6d30f66c9so1737049a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 19:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791513306; x=1792118106; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfsweV6M9RJMr0ZZ5+OOh8EVgv6iTz3OXA+hsWJLjpA=;
        b=VK36VqZ03hUpNROExlj4whBTYArpwmZFWCR5GVJPj6LsGkGQJWBxO87Q81BD/WziGy
         qaxd8qcSHJM2JcoYRQcMucStNk2nOjN4BQ5lZrRUjWLD5VmhRKKrw7ox2uBTmRDygoNh
         h48ZX+osBs8jAo5qmdoipTJoi+JDtJumoSMfXNMzVdnFZlrUzzWRyScL4yF7qTVvd8K7
         YMZ6SDREVYIjZiDqQMhM20K9GfkxZr9GRMe1j4Pe+g7b3y9wHPtDU7gwtoMzKYgGTPF1
         osCZrD/cCqvpBqKfVMHQy9ZIqknh2FMYeCPVaPafSJWzoWDAJidcgPVEtpEDUL0kSR2r
         RFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791513306; x=1792118106;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kfsweV6M9RJMr0ZZ5+OOh8EVgv6iTz3OXA+hsWJLjpA=;
        b=Uni89wimz4zf8IODnnseDxFbdCKyaHRMybpsZpTS6cxAZWXaydneyBGwOyPWfS2wMI
         nadFsYvmVIpGvWu9NKJ4eZWh7uu++pu5G9oU6eqXOsmNX0psbxV4ivbGoa3BuBBtf1JD
         8SyFD+hNeiVD9ZmklXNv6ufEOJ5K/FAd1H+jNcsVP0wBKulPIMjVHZu3GesOXBp4WYir
         N/G2KJkBRNELdRJRVA6jUaToP2mfZF5/5Yv1rAHy8XZTwzYO2Ybf4NRut9KRZFJPzCdw
         N4GsCYHZlHmjHSEuSRTHWbE8w6VB/aeexXvS2RULJW6anHFUtoRCnmpvF23Gb3R6MBI8
         3n9w==
X-Forwarded-Encrypted: i=1; AKwUvByrnZPdEEWFykUX/mVS5IKtBoRb59Yq7AMw3bQyl4i/3dYH/fPRnOiyXkyvGlfATZ59HEfTw1Q=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIw8DoXtw/10nGqo75xZ+yGrnF7XDDTHkLm3QrKdfyfvJ1EFxSq
	7XRBm5eV94NiUY1Fc6z7v1tSIdrAu/e6lI7+kut0Ctontq1YIliMPyzXe/tRocPfW2reDwQwlr7
	I7vXBV9qaF15HYXZmuF5AcgsnGEPIlKuFmE5+yY+ixWCBrvwjD1lnk6u1fTI4GImmDfdB7Jw=
X-Gm-Gg: AYBFou3DpbBFX1Ucvgn1qWx+91NULXgE9JLIlTAcoO7UjupE3MHox1/yxBjg0z5N8qm
	DGSO/Y8wRuAIPkeIatze71emyI1smzbjcZaovsrP1pyoOuBSUkBMjEmUV7hFOKPynOrFtWOmY69
	QhHYGznSWYOGtgaQ57QA3CtPUdyqkuQD6xgkRpS4vTQpBLnLL7ksuiP5JHrGDweV4EEJEXE8sIk
	FGzeUEfcWEYZi70KMa6cKJSxaOtbg5rvHEBCJkhpEAsKssvVwmOOYeLjs/VR19SZA0ZBUzoOLT7
	Dm9gFJuxlZGTWXPkYTTEDc3BVhZA9RRiMmnwMnqv+U86Xs5YdCEjnWtPDCkWjczsI0MqlKtJbGF
	vSZ+mbxVAF3IgrYzF81ozkUZL92Qkx3AM
X-Received: by 2002:a17:90b:258f:b0:3a4:7195:ecba with SMTP id 98e67ed59e1d1-3ab3a9a8d2bmr301842a91.20.1791513306174;
        Thu, 08 Oct 2026 19:35:06 -0700 (PDT)
X-Received: by 2002:a17:90b:258f:b0:3a4:7195:ecba with SMTP id 98e67ed59e1d1-3ab3a9a8d2bmr301817a91.20.1791513305208;
        Thu, 08 Oct 2026 19:35:05 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.12.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ca1e04sm1399622a91.1.2026.10.08.19.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 19:35:04 -0700 (PDT)
Message-ID: <ba0522df-8cdf-4510-96f8-748e0a419742@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 13:34:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
 <20261006-qcom_uefisecapp_migrate_qcomtee-v4-6-bf1c8e2a64ab@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-6-bf1c8e2a64ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oqcKorxfCm8rtuJ_dWeNB36WnHChpG5l
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac852db cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9v5PfQ1E2GNzj2RibJmqVw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=81jqDg-q10b2Op3f9YwA:9
 a=Fj3fdtCelTHB4AuG:21 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAxMCBTYWx0ZWRfX28cVJCqBCJiv
 OZKhbrbsja85e4WBTszaWQukLsgAozAut2/ZqGykkw+7RDMmmSzCCnSgRkL2a3YbN6jks0FyaoP
 4UbiyMbO5WWuowzxp82T9P/2eCJScJTApOmYd7DovmskuqCLCNqFT7t8QsOQfu2u+XjSgSlJ+Ac
 8YP345Hz7T7EmX5uCjo1tYBUBzpv5YxWL/8qD2cXwjhi12eqQJhI2pBzX4DjLWrrDPxgo7FNc8R
 /ctFk9OckCHsColaX0gY3HKTFZivI2CnynXuR/3qIbSNF2ZLOYCSyymENsOgnDMgW6HsA+N48rg
 jeflc6b+ZFLZmRRDwy9Hpp/uzXbCQ3YpcF6liSvuJ8eIgZHRKWIOdVXf8jaYSIDR0Zgq31bMYpw
 xJp1P2UnYJEeyihTDu7C3ETvREa2STZvkGSUgLdN5cJ6FVSzsTXKTpHyZ9ys2Mi924Gxhcaa2VI
 pIbh2+/3b3ZbjKuZTng==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAxMCBTYWx0ZWRfX/x3o7ijCihx/
 okvT0TvNTy/h5zOEJDCd017xAhe9HmYJ1cRYe3xjhgAX373rA1OqFjA5wxpHyIbq3eE45i9MidN
 ZpUrWwTIXF/PRz6Qd41mYi5/o5w9HcQ=
X-Proofpoint-GUID: oqcKorxfCm8rtuJ_dWeNB36WnHChpG5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090010
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 452A44498C
X-Spamd-Bar: ----
Message-ID-Hash: ALOYXHI6LS6YLSKXK4CJFSOEZTVK2EW2
X-Message-ID-Hash: ALOYXHI6LS6YLSKXK4CJFSOEZTVK2EW2
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ALOYXHI6LS6YLSKXK4CJFSOEZTVK2EW2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 10/6/2026 10:33 PM, Harshal Dev wrote:
> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> Replay Protected Memory Block (RPMB) located within either the UFS,
> eMMC or SPI-NOR storage. The RPMB key which is one-time programmed into
> the storage controller to allow authentication of the RPMB frames is
> generated by and only available to the Qualcomm Trusted Execution
> Environment (QTEE).
> 
> The legacy QSEECOM protocol used for communicating with the QTEE is
> deprecated and replaced with the use-case agnostic SMCInvoke protocol
> starting with the Qualcomm SM8x50 series. On platforms where the QSEECOM
> driver still probes, it does not support a listener interface with QTEE
> to enable writing of non-volatile EFI variables to the RPMB for UFS and
> eMMC storage.
> Therefore on such platforms, a TEE client driver which communicates with
> QTEE via the SMCInvoke protocol implemented by the QCOMTEE driver (and
> registered with the TEE subsystem) must be used to update such EFI
> variables.
> 
> Add support for a TEE based uefisecapp client driver which installs efivar
> operations after obtaining an object reference to the uefisecapp service.
> This enables the kernel/user-space to access or modify both volatile EFI
> variables stored by the Secure Application (in-memory) and non-volatile
> ones stored within RPMB.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  MAINTAINERS                                 |   6 +
>  drivers/firmware/qcom/Kconfig               |  31 ++
>  drivers/firmware/qcom/Makefile              |   1 +
>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 648 ++++++++++++++++++++++++++++
>  4 files changed, 686 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 30c1cdd0fb38..7ccedad8d388 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22981,6 +22981,12 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>  
> +QUALCOMM TEE UEFISECAPP DRIVER
> +M:	Harshal Dev <harshal.dev@oss.qualcomm.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.c
> +
>  QUALCOMM PINCTRL DRIVERS
>  M:	Bartosz Golaszewski <brgl@kernel.org>
>  L:	linux-arm-msm@vger.kernel.org
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 3ad22f8fc3e5..694d98fef4f4 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -79,4 +79,35 @@ config QCOM_QSEECOM_UEFISECAPP
>  	  Select Y here to provide access to EFI variables on the aforementioned
>  	  platforms.
>  
> +config QCOM_TEE_UEFISECAPP
> +	tristate "Qualcomm TEE UEFI Secure App client driver"
> +	depends on QCOMTEE
> +	depends on EFI
> +	help
> +	  The QSEECOM protocol used for communicating with the Qualcomm Trusted
> +	  Execution Environment (QTEE) is deprecated and replaced with the SMCInvoke
> +	  protocol starting with the Qualcomm SM8x50 series. On platforms where the
> +	  QSEECOM protocol still works (the QSEECOM driver probes) the driver does
> +	  not support a listener interface with QTEE to enable writing of
> +	  non-volatile EFI variables (via listener requests to Linux) in the Replay
> +	  Protected Memory Block (RPMB) located on UFS/eMMC storage.
> +	  Therefore on such platforms, the TEE based uefisecapp client driver
> +	  (which communicates with QTEE via the SMCInvoke protocol) must be used
> +	  to update such EFI variables through the RPMB service hosted in the QTEE
> +	  supplicant user-space daemon (github.com/qualcomm/minkipc) which forwards
> +	  RPMB packets to the RPMB device.
> +	  NOTE: Qualcomm Compute platforms with SPI-NOR storage are an exception to
> +	  this scenario. Since they do not have a firmware running on their SPI-NOR
> +	  storage controller which must be programmed with a RPMB key, QTEE has a
> +	  SPI-NOR driver which holds the key, and so the QSEECOM driver can be used
> +	  for updating EFI variables on these platforms because QTEE never makes a
> +	  listener request to Linux (QTEE doesn't need the Linux SPI-NOR driver).
> +
> +	  This module provides a TEE client driver for uefisecapp, installing efivar
> +	  operations to allow the kernel and user-space access to EFI variables.
> +
> +	  Select m here to provide access to EFI variables on the aforementioned
> +	  platforms if your Linux distribution has QTEE supplicant installed and
> +	  running.
> +
>  endmenu
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index 88ce74d74c3e..237192b74de3 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -9,5 +9,6 @@ CFLAGS_qcom_scm-smc.o := -I$(src)
>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> +obj-$(CONFIG_QCOM_TEE_UEFISECAPP) += qcom_tee_uefisecapp.o
>  obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
>  obj-$(CONFIG_QCOM_PAS_TEE)	+= qcom_pas_tee.o
> diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
> new file mode 100644
> index 000000000000..acb1709c0a53
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
> @@ -0,0 +1,648 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/ucs2_string.h>
> +
> +#define QCOMTEE_OP_CLIENT_ENV_OPEN 0
> +#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS 5
> +
> +/* Each service exposed by QTEE is identified by a 32-bit UID */
> +#define QCOMTEE_UEFI_SEC_UID                 413
> +
> +/* Operations supported by the UEFI Sec App service */
> +#define QCOMTEE_UEFI_SEC_OP_GET_VAR 0
> +#define QCOMTEE_UEFI_SEC_OP_SET_VAR 1
> +#define QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO 2
> +#define QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME 3
> +
> +#define QCOMTEE_GET_VAR_NPARAMS 5
> +#define QCOMTEE_SET_VAR_NPARAMS 4
> +#define QCOMTEE_QUERY_VAR_NPARAMS 2
> +#define QCOMTEE_GET_NEXT_VAR_NPARAMS 4
> +#define QCOMTEE_GET_UEFI_SVC_NPARAMS 2
> +#define QCOMTEE_GET_CLIENT_ENV_NPARAMS 2
> +
> +/* Error codes returned by the UEFI Sec App service */
> +#define QCOMTEE_UEFI_SEC_SUCCESS 0
> +#define QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER 10
> +#define QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED 11
> +#define QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED 12
> +#define QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION 13
> +#define QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR 14
> +#define QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES 15
> +#define QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED 16
> +#define QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT 17
> +#define QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND 18
> +#define QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED 19
> +
> +/* Operations for objects are 32-bit. QCOMTEE transport uses the upper 16 bits. */
> +#define QCOMTEE_MSG_OBJECT_OP_MASK GENMASK(15, 0)
> +#define QCOMTEE_MSG_OBJECT_OP_RELEASE (QCOMTEE_MSG_OBJECT_OP_MASK - 0)
> +
> +/**
> + * struct qcomtee_uefisec_app - An instance of UEFI Secure Application.
> + * @dev: TEE client device on the TEE bus which represents uefisecapp.
> + * @ctx: The context opened with the TEE subsystem by the uefisecapp client.
> + * @uefisec_svc_obj: A TEE object representing the uefisecapp service.
> + * @efivars: EFI variables registered with the EFI subsystem.
> + */
> +struct qcomtee_uefisec_app {
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	struct tee_param_objref uefisec_svc_obj;
> +	struct efivars efivars;
> +};
> +
> +#define UEFISECAPP_UUID \
> +	UUID_INIT(0x01f95dcd, 0x2d7e, 0x58be, \
> +		  0xa1, 0x43, 0x81, 0x32, 0xa1, 0x72, 0xdb, 0x7d)
> +
> +/* Short-hands for these long attribute names */
> +#define UBUF_INPUT     TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT
> +#define UBUF_OUTPUT    TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT
> +#define OBJREF_INPUT   TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT
> +#define OBJREF_OUTPUT  TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT
> +
> +/* Init instance of 'struct tee_param_objref'. */
> +#define SET_TEE_PARAM_OBJREF(param, attri, obj_id, obj_flag) do { \
> +		(param).attr = (attri); \
> +		(param).u.objref.id = (obj_id); \
> +		(param).u.objref.flags = (obj_flag); \
> +	} while (0)
> +
> +/* Init instance of 'struct tee_param_ubuf'. */
> +#define SET_TEE_PARAM_UBUF(param, attri, ubuff) do { \
> +		(param).attr = (attri); \
> +		(param).u.ubuf = (ubuff);  \
> +	} while (0)
> +
> +#define TEE_PARAM_UBUF(x) ((struct tee_param_ubuf){ .addr = &(x), sizeof(x) })
> +
> +#define SET_INVOKE_ARG(arg, object_id, opp, nparam) do { \
> +		(arg).id = (object_id); \
> +		(arg).op = (opp); \
> +		(arg).num_params = (nparam); \
> +	} while (0)
> +
> +static inline efi_status_t uefisecapp_err_to_efi_status(u32 err)
> +{
> +	switch (err) {
> +	case QCOMTEE_UEFI_SEC_SUCCESS:
> +		return EFI_SUCCESS;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER:
> +		return EFI_INVALID_PARAMETER;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED:
> +		return EFI_UNSUPPORTED;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED:
> +		return EFI_WRITE_PROTECTED;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION:
> +		return EFI_SECURITY_VIOLATION;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR:
> +		return EFI_DEVICE_ERROR;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES:
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT:
> +		return EFI_BUFFER_TOO_SMALL;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND:
> +		return EFI_NOT_FOUND;
> +
> +	/* No matching on EFI_* list. */
> +	case QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED: /* EFI_ALREADY_STARTED.  */
> +	case QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED: /* EFI_VOLUME_CORRUPTED. */
> +	default:
> +		return EFI_DEVICE_ERROR;
> +	}
> +}
> +
> +static struct qcomtee_uefisec_app uefisec_app;

Should not this singleton be protected, for instance against concurrent call and driver unbound?

> +
> +static int qcuefi_get_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
> +			       struct tee_param_ubuf in_attributes,
> +			       struct tee_param_ubuf *data,
> +			       u32 *out_attributes, u32 *out_errno)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
> +	struct tee_param param[QCOMTEE_GET_VAR_NPARAMS];
> +
> +	struct {
> +		efi_guid_t guid;
> +		u32 in_data_size;
> +	} in_cong = { 0 };
> +
> +	struct {
> +		u32 out_data_size;
> +		u32 attributes;
> +		u32 errno;
> +	} out_cong = { 0 };
> +
> +	in_cong.guid = *guid;
> +	in_cong.in_data_size = data->size;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_UEFI_SEC_OP_GET_VAR,
> +		       QCOMTEE_GET_VAR_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
> +	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
> +	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, in_attributes);
> +	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
> +	SET_TEE_PARAM_UBUF(param[4], UBUF_OUTPUT, *data);
> +
> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_VAR invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	data->size = out_cong.out_data_size;
> +	*out_attributes = out_cong.attributes;
> +	*out_errno = out_cong.errno;
> +
> +	return ret;
> +}
> +
> +static efi_status_t qcomtee_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid,
> +					      u32 *attr, unsigned long *data_size,
> +					      void *data)
> +{
> +	int ret;
> +	u32 in_attr, out_attributes, out_errno;
> +	struct tee_param_ubuf in_data, in_var, in_attributes;
> +
> +	if (!name || !guid)
> +		return EFI_INVALID_PARAMETER;
> +
> +	/* 'attr' can be NULL, however an input attribute is always expected
> +	 * by UefiSecApp TA
> +	 */
> +	in_attr = 0;
> +	if (attr)
> +		in_attr = *attr;
> +
> +	in_data = (struct tee_param_ubuf){ .addr = data, *data_size };
> +	in_var = (struct tee_param_ubuf){ .addr = name,
> +					  (ucs2_strlen(name) + 1) * sizeof(*name) };
> +	in_attributes = (struct tee_param_ubuf){ .addr = &in_attr, sizeof(u32) };
> +
> +	/* On SUCCESS, 'data' member of 'in_data' has already been updated. */
> +	ret = qcuefi_get_variable(in_var, guid, in_attributes, &in_data,
> +				  &out_attributes, &out_errno);
> +
> +	if (ret)
> +		return EFI_DEVICE_ERROR;
> +
> +	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT) {
> +		/* If 'attr' is NULL 'out_attributes' is not updated. */
> +		if (attr)
> +			*attr = out_attributes;
> +
> +		*data_size = in_data.size;
> +	}
> +
> +	return uefisecapp_err_to_efi_status(out_errno);
> +}
> +
> +static int qcuefi_set_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
> +			       u32 attributes, struct tee_param_ubuf data,
> +			       u32 *out_errno)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
> +	struct tee_param param[QCOMTEE_SET_VAR_NPARAMS];
> +
> +	struct {
> +		efi_guid_t guid;
> +		u32 attributes;
> +		u32 in_data_size;
> +	} in_cong = { 0 };
> +
> +	in_cong.guid = *guid;
> +	in_cong.attributes = attributes;
> +	in_cong.in_data_size = data.size;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_UEFI_SEC_OP_SET_VAR,
> +		       QCOMTEE_SET_VAR_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
> +	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
> +	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, data);
> +	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(*out_errno));
> +
> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_SET_VAR invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static efi_status_t qcomtee_uefi_set_variable(efi_char16_t *name, efi_guid_t *guid,
> +					      u32 attr, unsigned long data_size,
> +					      void *data)
> +{
> +	int ret;
> +	u32 out_errno;
> +	struct tee_param_ubuf in_data, in_var;
> +
> +	if (!name || !guid)
> +		return EFI_INVALID_PARAMETER;
> +
> +	in_data = (struct tee_param_ubuf){ .addr = data, data_size };
> +	in_var = (struct tee_param_ubuf){ .addr = name,
> +					  (ucs2_strlen(name) + 1) * sizeof(*name) };
> +
> +	ret = qcuefi_set_variable(in_var, guid, attr, in_data, &out_errno);
> +	if (ret)
> +		return EFI_DEVICE_ERROR;
> +
> +	return uefisecapp_err_to_efi_status(out_errno);
> +}
> +
> +static int qcuefi_get_next_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
> +				    struct tee_param_ubuf *out_variable,
> +				    efi_guid_t *out_vendor_guid, u32 *out_errno)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
> +	struct tee_param param[QCOMTEE_GET_NEXT_VAR_NPARAMS];
> +
> +	struct {
> +		efi_guid_t guid;
> +		u32 in_data_size;
> +	} in_cong = { 0 };
> +
> +	struct {
> +		efi_guid_t guid;
> +		u32 out_data_size;
> +		u32 errno;
> +	} out_cong = { 0 };
> +
> +	/* Pass size of available buffer */
> +	in_cong.in_data_size = out_variable->size;
> +	in_cong.guid = *guid;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME,
> +		       QCOMTEE_GET_NEXT_VAR_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
> +	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
> +	SET_TEE_PARAM_UBUF(param[2], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
> +	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, *out_variable);
> +
> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	/* UefiSecApp TA does not touch 'out_variable.size'. Update it here.
> +	 * On SUCCESS (!out_errno), 'out_data_size' is length of name in 'out_variable.addr'.
> +	 * On failure (out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT), 'out_data_size' is
> +	 * actual name length.
> +	 * Otherwise, it's undefined.
> +	 */
> +	out_variable->size = out_cong.out_data_size;
> +	*out_vendor_guid = out_cong.guid;
> +	*out_errno = out_cong.errno;
> +
> +	return ret;
> +}
> +
> +static efi_status_t qcomtee_uefi_get_next_variable(unsigned long *name_size,
> +						   efi_char16_t *name,
> +						   efi_guid_t *guid)
> +{
> +	int ret;
> +	u32 out_errno;
> +	efi_guid_t out_guid;
> +	struct tee_param_ubuf in_var, out_var;
> +
> +	if (!name_size || !name || !guid)
> +		return EFI_INVALID_PARAMETER;
> +
> +	if (*name_size == 0)
> +		return EFI_INVALID_PARAMETER;
> +
> +	/* For 'in_var', 'name_size' is not necessarily size of 'name';
> +	 * could be size of buffer where 'name' has been stored. TA expects a
> +	 * NULL-terminated string in 'name' and ignores the size.
> +	 * For 'out_var', 'name_size' is size of buffer pointed by 'name'.
> +	 */
> +	in_var = (struct tee_param_ubuf){ .addr = name, *name_size };
> +	out_var = (struct tee_param_ubuf){ .addr = name, *name_size };
> +
> +	ret = qcuefi_get_next_variable(in_var, guid, &out_var, &out_guid,
> +				       &out_errno);
> +	if (ret)
> +		return EFI_DEVICE_ERROR;
> +
> +	if (!out_errno)
> +		*guid = out_guid;
> +
> +	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT)
> +		*name_size = out_var.size;
> +
> +	/* On SUCCESS, 'name' stores the next variable name. */
> +	return uefisecapp_err_to_efi_status(out_errno);
> +}
> +
> +static int qcuefi_query_variable_info(u32 attributes,
> +				      u64 *maximum_variable_storage_size,
> +				      u64 *remaining_variable_storage_size,
> +				      u64 *maximum_variable_size, u32 *out_errno)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
> +	struct tee_param param[QCOMTEE_QUERY_VAR_NPARAMS];
> +
> +	struct {
> +		u64 max_var_storage_size;
> +		u64 remaining_var_storage_size;
> +		u64 maximum_var_size;
> +		u32 errno;
> +	} out_cong = { 0 };
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO,
> +		       QCOMTEE_QUERY_VAR_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(attributes));
> +	SET_TEE_PARAM_UBUF(param[1], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
> +
> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*maximum_variable_storage_size = out_cong.max_var_storage_size;
> +	*remaining_variable_storage_size = out_cong.remaining_var_storage_size;
> +	*maximum_variable_size = out_cong.maximum_var_size;
> +	*out_errno = out_cong.errno;
> +
> +	return ret;
> +}
> +
> +static efi_status_t qcomtee_uefi_query_variable_info(u32 attr, u64 *storage_space,
> +						     u64 *remaining_space,
> +						     u64 *max_variable_size)
> +{
> +	int ret;
> +	u32 out_errno;
> +	u64 maximum_variable_storage_size;
> +	u64 remaining_variable_storage_size;
> +	u64 maximum_variable_size;
> +
> +	if (!storage_space || !remaining_space || !max_variable_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	ret = qcuefi_query_variable_info(attr,
> +					 &maximum_variable_storage_size,
> +					 &remaining_variable_storage_size,
> +					 &maximum_variable_size,
> +					 &out_errno);
> +
> +	if (ret)
> +		return EFI_DEVICE_ERROR;
> +
> +	if (!out_errno) {
> +		*storage_space = maximum_variable_storage_size;
> +		*remaining_space = remaining_variable_storage_size;
> +		*max_variable_size = maximum_variable_size;
> +	}
> +
> +	return uefisecapp_err_to_efi_status(out_errno);
> +}
> +
> +/**
> + * qcomtee_release_object() - Release an object returned by QTEE.
> + *
> + * Each object returned by QTEE repesents a secure service exposed to the
> + * client. Whenever an secure service is opened, QTEE may allocate resources
> + * on the client's behalf. Therefore, once the client is done accessing the
> + * secure service, the object representing it should be explicitly released
> + * so that QTEE can release the associated resources as well.
> + *
> + * @ctx: TEE context.
> + * @object: The object to release.
> + */
> +static void qcomtee_release_object(struct tee_context *ctx,
> +				   struct tee_param_objref object)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	SET_INVOKE_ARG(inv_arg, object.id, QCOMTEE_MSG_OBJECT_OP_RELEASE, 0);
> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
> +}
> +
> +/**
> + * qcomtee_get_uefisec_svc_obj() - Get a UEFI Secure App service object to
> + * begin communication with the service.
> + * @ctx: TEE context.
> + * @client_env_obj: The client environment object returned earlier by QTEE.
> + * @uefisec_svc_obj: The UEFI Secure App service object.
> + *
> + * Returns 0 on success.
> + * Returns < 0 if client environment object invocation failed.
> + * Returns > 0 if client environment invocation was success but UEFI Secure App
> + * service object could not be returned for some other reason (represented by the
> + * returned value)
> + */
> +static int qcomtee_get_uefisec_svc_obj(struct tee_context *ctx,
> +				       struct tee_param_objref client_env_obj,
> +				       struct tee_param_objref *uefisec_svc_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = client_env_obj.id;
> +	struct tee_param param[QCOMTEE_GET_UEFI_SVC_NPARAMS];
> +	u32 uefisec_uid = QCOMTEE_UEFI_SEC_UID;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_OP_CLIENT_ENV_OPEN,
> +		       QCOMTEE_GET_UEFI_SVC_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(uefisec_uid));
> +	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_CLIENT_ENV_OPEN invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*uefisec_svc_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +/**
> + * qcomtee_get_client_env_obj() - Get a client environment object to begin
> + * object exchange with QTEE.
> + * @ctx: TEE context.
> + * @client_env_obj: The client environment object returned by QTEE.
> + *
> + * Returns 0 on success.
> + * Returns < 0 if root object invocation failed.
> + * Returns > 0 if root object invocation was success but client environment
> + * object could not be returned for some other reason (represented by the
> + * returned value)
> + */
> +static int qcomtee_get_client_env_obj(struct tee_context *ctx,
> +				      struct tee_param_objref *client_env_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	struct tee_param param[QCOMTEE_GET_CLIENT_ENV_NPARAMS];
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, TEE_OBJREF_NULL,
> +		       QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS,
> +		       QCOMTEE_GET_CLIENT_ENV_NPARAMS);
> +	SET_TEE_PARAM_OBJREF(param[0], OBJREF_INPUT, TEE_OBJREF_NULL, 0);
> +	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*client_env_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +static const struct efivar_operations qcom_efivar_ops = {
> +	.get_variable = qcomtee_uefi_get_variable,
> +	.set_variable = qcomtee_uefi_set_variable,
> +	.get_next_variable = qcomtee_uefi_get_next_variable,
> +	.query_variable_info = qcomtee_uefi_query_variable_info,
> +};
> +
> +static int qcomtee_ctx_match(struct tee_ioctl_version_data *ver,
> +			     const void *data)
> +{
> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
> +}
> +
> +static int qcomtee_uefisecapp_probe(struct tee_client_device *tee_dev)
> +{
> +	int ret, err;
> +	struct tee_param_objref client_env_obj;
> +	struct tee_param_objref uefisec_svc_obj;
> +
> +	uefisec_app.dev = &tee_dev->dev;
> +	/* Open context with QCOMTEE driver */
> +	uefisec_app.ctx = tee_client_open_context(NULL, qcomtee_ctx_match, NULL,
> +						  NULL);
> +	if (IS_ERR(uefisec_app.ctx))
> +		return -ENODEV;
> +
> +	/* Obtain a reference to client_env object to begin object exchange
> +	 * with QTEE
> +	 */
> +	ret = qcomtee_get_client_env_obj(uefisec_app.ctx, &client_env_obj);
> +	if (ret) {
> +		err = -EINVAL;
> +		goto err_get_client_env;
> +	}
> +
> +	/* Obtain a reference to the uefisec_svc object which provides access to
> +	 * the EFI var storage.
> +	 */
> +	ret = qcomtee_get_uefisec_svc_obj(uefisec_app.ctx, client_env_obj,
> +					  &uefisec_svc_obj);
> +	if (ret) {
> +		err = -EINVAL;
> +		goto err_get_uefisec_svc;
> +	}
> +	uefisec_app.uefisec_svc_obj = uefisec_svc_obj;
> +
> +	ret = efivars_register(&uefisec_app.efivars, &qcom_efivar_ops);
> +	if (ret) {
> +		err = ret;
> +		goto err_efi_vars_reg;
> +	}
> +
> +	/* We don't need to keep a reference to this object anymore, we only
> +	 * needed it to obtain the uefisec_svc object.
> +	 */
> +	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
> +	return 0;
> +
> +err_efi_vars_reg:
> +	qcomtee_release_object(uefisec_app.ctx, uefisec_svc_obj);
> +err_get_uefisec_svc:
> +	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
> +err_get_client_env:
> +	tee_client_close_context(uefisec_app.ctx);
> +
> +	return err;
> +}
> +
> +static void qcomtee_uefisecapp_remove(struct tee_client_device *tee_dev)
> +{
> +	efivars_unregister(&uefisec_app.efivars);
> +	qcomtee_release_object(uefisec_app.ctx, uefisec_app.uefisec_svc_obj);
> +	tee_client_close_context(uefisec_app.ctx);
> +}
> +
> +static const struct tee_client_device_id qcomtee_uefisecapp_id_table[] = {
> +	{UEFISECAPP_UUID},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, qcomtee_uefisecapp_id_table);
> +
> +static struct tee_client_driver qcomtee_uefisecapp_driver = {
> +	.id_table	= qcomtee_uefisecapp_id_table,
> +	.probe		= qcomtee_uefisecapp_probe,
> +	.remove		= qcomtee_uefisecapp_remove,
> +	.driver		= {
> +		.name		= "qcom-tee-uefisecapp",
> +	},
> +};
> +
> +module_tee_client_driver(qcomtee_uefisecapp_driver);
> +
> +MODULE_AUTHOR("Qualcomm");
> +MODULE_DESCRIPTION("TEE client driver for Qualcomm TEE UEFI Secure App");
> +MODULE_LICENSE("GPL");
> 

