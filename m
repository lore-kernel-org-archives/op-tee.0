Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE1BCA9ED1
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 10:35:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DD889451D6
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 10:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791801318;
	bh=A/8d3MGe0cKlhjuNMdPI6hNkGEu7XvWn0HIltuSpx6c=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=h39JF/+2NuaY+DtKwszjbVL3LBrf5C5zpxrG2cx5f+u+rJAV0epctSm8CBDfFZ4D1
	 M8HQInIQL1fy6sfBe/NcG+vDwinbfnvpZluAE0lxu785L41nH4VvT/h6tZMzhfZ5Wi
	 E/MYntHDqVIh63ak1G+bgyTVhkcLPoFmNanyypybvThHemRm8iY0fN0VaBtvpxX/t2
	 0TS8pD4M9W9zoz3Sj9wZ+Jp4hx/06sMITkk/6Xc2cwbZBq/UDEZEWf9Q2xXXANZFBD
	 YQV0EhmgSX5g+dbDfTKdCYNJn3yIpaUuAqLpBaImvCby2SiiUIhwHDuaOmHgVJtNv9
	 Ar7q4uVhq99FA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 484FF41BDE
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 10:34:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MxK5zd2x;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SwTDpGHC;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C9t2BO1404826
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 10:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2F7D20dpodh/eJvaR+DqngoKHhbQHBiHpKVmEIWV09Y=; b=MxK5zd2xGBG3WilJ
	suaQei2srd3kRZniaWGU8wdCKUnqHdsmgjweB8zsHiDhD05UHtOMwp9yd/JZTcVf
	syXTLWlUpunpZmrQFjvViJn2gV7ZtTY0EbWtHijM6QrfR1T3aI+O08AMui1GsES3
	lvkQszgYFmkUJa331Z/iI5eisCw1k7RcNv9a+Qi4sNGkvS8kqKbloGTS7Z/A0pRa
	JpTjhAyvU3D6/x7wGlBAGiwSRGUtun58ptt/DSyYZ45RC2DtAJd3n+t06260DdE6
	mfPIUQVvASluiSusy0OLGoPwUogm2fLiTja9gW7ei9dNIn0xSUgVF9I2Ofh4h3C7
	2bFmoQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wbc0608-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 10:34:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a8041a532eso1181076a91.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791801296; x=1792406096; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2F7D20dpodh/eJvaR+DqngoKHhbQHBiHpKVmEIWV09Y=;
        b=SwTDpGHCg/1baA1z0jzAPdgSHW1n4IeL8H/8vdAmzy5JcuLQ7f5Aq0iLmlVgdyNSQ7
         +kWKaf7giXUWbvHGQltYGavTrgyLPkHwJQPiTr2YGt907ZvALYE0TOk1pMx1ILjvPpPF
         TmgFREZaEZYLmQ3q217///CBkJpaBa6SaiHrd372gNpg70ZkTl5EfUEuIzbE9RBsg8Ax
         dDS0kXjbJlRZx1OZhBDy/hxZhrhhbOkLIz+9IQ9a00BWKnzYdcI28JhHYtUq7ufW1Hdy
         +47c8re4cTTcV179sDtrN3zMcpW8ZE0Q9tgbihiTb0XR+91ZHMqGHyLJJmK21mHQMN1o
         E9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791801296; x=1792406096;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2F7D20dpodh/eJvaR+DqngoKHhbQHBiHpKVmEIWV09Y=;
        b=2OcucluyEOlm82arKsG3Z9NQMeghy0euRIt22c10Q9RyvloX2pVY/dGUEnu2CZlLnh
         ky6CzCT3gyavO4pxtLFjB4m/LiLnOohGYEyKvxrEkIhWUkKm4jYn+JOFJM/MMmlaJDVU
         fLl6cTTAzipLgM823/76OKi/dnx1N75ViBGY5qv0X4n0AzgFeQDoJJuV585bMk608q9a
         piKqa37/Erwi3O4jD3v8gRNYnaf/R+IwRKbrBHq3W8IVqGrALHW9airiMVhvgIl6MCdo
         3S0WrJjlovI3WfzvqO46FJ2xUnGvn+hqejPCdzXMUVSpcQSLjELhlBsdjBlVI6aEHlwP
         W0Gg==
X-Forwarded-Encrypted: i=1; AKwUvBxx09x/mgJJrI9rbIVzpVDCcXLo/X7THVLQbXSc+BTmofGmTzh0BT2SOU6oVjcC4FAFB2RqGec=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJUXFBBNwAfFJ2M7BOXSXAjBmIho2yMlQnn2QJwwjKoSL3p/dqO
	DB8U1y8sPfFuJxBDLVK7VOU/e0aGjkWjioLB61jnmOVlOeS9IH5xB2SR2hSmQ+bxY9wmUF47aD8
	tXYWwMdIF6O9U0a9Z/E3LZfoQ+zEPoLDgunCFCJUHcdijL8cfkUfPp5WCeBs1Dw2gaGLjEb+n
X-Gm-Gg: AYBFou2v9pv6KYBsckKDsd6Jocun0KHC0Go2L0g//+vK653m8E6Vp5lZ1Qf97KyKyan
	ZlXRD11ML/MoD3gRxYfxMDjfqWZ0948WzCUvKb44DjOqoPs3qhT+1gnbkftYh9XPiZagg5bxi/M
	qNtwo3z/O6AdXrcliHs3cGEwxYEGRc1UhVcjzVHmvQjuW9WHI3zAf+6jBj1BPcPZJA3y9/0/aYO
	oC14sNW4qtxOLrJI4tThe7sAHL5c/ETQ/YsEVC6DeC/5ElE853hpL+w0pDqFy4FDjnEOysWpJiI
	q2J5bL4+SdTdnCE2pNCYlUsok19iDq3xHtYIRc7GhqfGbIymOnc2TWOzbP76Frwvc752t3c1B0Q
	eSdF0MYQa4/skM5ld66DftNnm18Em
X-Received: by 2002:a17:90b:390a:b0:3ab:413:49a9 with SMTP id 98e67ed59e1d1-3ab3a932609mr8529223a91.50.1791801295657;
        Mon, 12 Oct 2026 03:34:55 -0700 (PDT)
X-Received: by 2002:a17:90b:390a:b0:3ab:413:49a9 with SMTP id 98e67ed59e1d1-3ab3a932609mr8529197a91.50.1791801294963;
        Mon, 12 Oct 2026 03:34:54 -0700 (PDT)
Received: from [192.168.29.10] ([49.37.155.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3781d581sm16243499a91.1.2026.10.12.03.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 03:34:54 -0700 (PDT)
Message-ID: <74b6139b-a767-41fd-a628-a7d42a6c3aec@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 16:04:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
 <20261006-qcom_uefisecapp_migrate_qcomtee-v4-6-bf1c8e2a64ab@oss.qualcomm.com>
 <ba0522df-8cdf-4510-96f8-748e0a419742@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <ba0522df-8cdf-4510-96f8-748e0a419742@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MSBTYWx0ZWRfX5xavGo+b4MQB
 mK9NB74MaqBLSW5tFl3nFwlb3MVahE7cbh5/yuUuJmDU7OKxqm2r8N0OEgGGQKryRwAIrwnaSNn
 wGwdCXhwGgZ2JWOYxC3UdpYjoM0gYh8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MSBTYWx0ZWRfXwziv+AVf9DoQ
 S79urC2Eio9xyOzQd5d8CzWBB3LNB8I1p325GcC6+3B3bTVyrLv4t1LibOwjwxo/ctlCMca+OU+
 +8iDwWRF7goJYHE4Dl9lwK5JpnwB8MULhg3tvvsHcs7fQolAG9FNNP1TkhVYSQnW4ekcLro8cpy
 Mfra2JDol9tIJCBDIdGSIsEcyWdKudTiPawRLGi42nM2zBQlwIH6T7N1V3Tr5vINIzwV7Bqg/Vy
 byUp0MSV/qvZB59SgRXzkAksZ45i+ugRqjrm+gY3QKpAtRLaM6qYwC8g+R2rIv6Bdh6656Xaz1x
 rGDcwdQjR0BwFcPafn17V2hswbHHYhJKzCu+5winEgI2/9yAu5c1Vd78fSwCPzQWVQWeUSm8IQN
 ma2OVtmnylw9aLdwGg1yJfKLvWwj9WEHyT0R//M0LxDX8ntN4ChAD+KP0yaXF603HGXesbKogPU
 nMSSyQ/Dp6vz4fQ2VBQ==
X-Authority-Analysis: v=2.4 cv=C4p8WgP+ c=1 sm=1 tr=0 ts=6accb7d0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ivpbP8R7Mhpy7qfOLL/Q+g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=XdMvMmsopDThE1cEod4A:9 a=Fj3fdtCelTHB4AuG:21 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: d_TpYeyME-azCmNaPQD4hD1gQkL38Jcr
X-Proofpoint-GUID: d_TpYeyME-azCmNaPQD4hD1gQkL38Jcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120041
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 484FF41BDE
X-Spamd-Bar: ----
Message-ID-Hash: W55IGGMGWK5F3YCFHPXSTBN6Z7XPJJPW
X-Message-ID-Hash: W55IGGMGWK5F3YCFHPXSTBN6Z7XPJJPW
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/W55IGGMGWK5F3YCFHPXSTBN6Z7XPJJPW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Amir,

On 09-10-2026 08:04 am, Amirreza Zarrabi wrote:
> 
> 
> On 10/6/2026 10:33 PM, Harshal Dev wrote:
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
>> driver still probes, it does not support a listener interface with QTEE
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
>>  drivers/firmware/qcom/Kconfig               |  31 ++
>>  drivers/firmware/qcom/Makefile              |   1 +
>>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 648 ++++++++++++++++++++++++++++
>>  4 files changed, 686 insertions(+)
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
>> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
>> index 3ad22f8fc3e5..694d98fef4f4 100644
>> --- a/drivers/firmware/qcom/Kconfig
>> +++ b/drivers/firmware/qcom/Kconfig
>> @@ -79,4 +79,35 @@ config QCOM_QSEECOM_UEFISECAPP
>>  	  Select Y here to provide access to EFI variables on the aforementioned
>>  	  platforms.
>>  
>> +config QCOM_TEE_UEFISECAPP
>> +	tristate "Qualcomm TEE UEFI Secure App client driver"
>> +	depends on QCOMTEE
>> +	depends on EFI
>> +	help
>> +	  The QSEECOM protocol used for communicating with the Qualcomm Trusted
>> +	  Execution Environment (QTEE) is deprecated and replaced with the SMCInvoke
>> +	  protocol starting with the Qualcomm SM8x50 series. On platforms where the
>> +	  QSEECOM protocol still works (the QSEECOM driver probes) the driver does
>> +	  not support a listener interface with QTEE to enable writing of
>> +	  non-volatile EFI variables (via listener requests to Linux) in the Replay
>> +	  Protected Memory Block (RPMB) located on UFS/eMMC storage.
>> +	  Therefore on such platforms, the TEE based uefisecapp client driver
>> +	  (which communicates with QTEE via the SMCInvoke protocol) must be used
>> +	  to update such EFI variables through the RPMB service hosted in the QTEE
>> +	  supplicant user-space daemon (github.com/qualcomm/minkipc) which forwards
>> +	  RPMB packets to the RPMB device.
>> +	  NOTE: Qualcomm Compute platforms with SPI-NOR storage are an exception to
>> +	  this scenario. Since they do not have a firmware running on their SPI-NOR
>> +	  storage controller which must be programmed with a RPMB key, QTEE has a
>> +	  SPI-NOR driver which holds the key, and so the QSEECOM driver can be used
>> +	  for updating EFI variables on these platforms because QTEE never makes a
>> +	  listener request to Linux (QTEE doesn't need the Linux SPI-NOR driver).
>> +
>> +	  This module provides a TEE client driver for uefisecapp, installing efivar
>> +	  operations to allow the kernel and user-space access to EFI variables.
>> +
>> +	  Select m here to provide access to EFI variables on the aforementioned
>> +	  platforms if your Linux distribution has QTEE supplicant installed and
>> +	  running.
>> +
>>  endmenu
>> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
>> index 88ce74d74c3e..237192b74de3 100644
>> --- a/drivers/firmware/qcom/Makefile
>> +++ b/drivers/firmware/qcom/Makefile
>> @@ -9,5 +9,6 @@ CFLAGS_qcom_scm-smc.o := -I$(src)
>>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>> +obj-$(CONFIG_QCOM_TEE_UEFISECAPP) += qcom_tee_uefisecapp.o
>>  obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
>>  obj-$(CONFIG_QCOM_PAS_TEE)	+= qcom_pas_tee.o
>> diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>> new file mode 100644
>> index 000000000000..acb1709c0a53
>> --- /dev/null
>> +++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>> @@ -0,0 +1,648 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/efi.h>
>> +#include <linux/tee.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/ucs2_string.h>
>> +
>> +#define QCOMTEE_OP_CLIENT_ENV_OPEN 0
>> +#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS 5
>> +
>> +/* Each service exposed by QTEE is identified by a 32-bit UID */
>> +#define QCOMTEE_UEFI_SEC_UID                 413
>> +
>> +/* Operations supported by the UEFI Sec App service */
>> +#define QCOMTEE_UEFI_SEC_OP_GET_VAR 0
>> +#define QCOMTEE_UEFI_SEC_OP_SET_VAR 1
>> +#define QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO 2
>> +#define QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME 3
>> +
>> +#define QCOMTEE_GET_VAR_NPARAMS 5
>> +#define QCOMTEE_SET_VAR_NPARAMS 4
>> +#define QCOMTEE_QUERY_VAR_NPARAMS 2
>> +#define QCOMTEE_GET_NEXT_VAR_NPARAMS 4
>> +#define QCOMTEE_GET_UEFI_SVC_NPARAMS 2
>> +#define QCOMTEE_GET_CLIENT_ENV_NPARAMS 2
>> +
>> +/* Error codes returned by the UEFI Sec App service */
>> +#define QCOMTEE_UEFI_SEC_SUCCESS 0
>> +#define QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER 10
>> +#define QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED 11
>> +#define QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED 12
>> +#define QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION 13
>> +#define QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR 14
>> +#define QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES 15
>> +#define QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED 16
>> +#define QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT 17
>> +#define QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND 18
>> +#define QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED 19
>> +
>> +/* Operations for objects are 32-bit. QCOMTEE transport uses the upper 16 bits. */
>> +#define QCOMTEE_MSG_OBJECT_OP_MASK GENMASK(15, 0)
>> +#define QCOMTEE_MSG_OBJECT_OP_RELEASE (QCOMTEE_MSG_OBJECT_OP_MASK - 0)
>> +
>> +/**
>> + * struct qcomtee_uefisec_app - An instance of UEFI Secure Application.
>> + * @dev: TEE client device on the TEE bus which represents uefisecapp.
>> + * @ctx: The context opened with the TEE subsystem by the uefisecapp client.
>> + * @uefisec_svc_obj: A TEE object representing the uefisecapp service.
>> + * @efivars: EFI variables registered with the EFI subsystem.
>> + */
>> +struct qcomtee_uefisec_app {
>> +	struct device *dev;
>> +	struct tee_context *ctx;
>> +	struct tee_param_objref uefisec_svc_obj;
>> +	struct efivars efivars;
>> +};
>> +
>> +#define UEFISECAPP_UUID \
>> +	UUID_INIT(0x01f95dcd, 0x2d7e, 0x58be, \
>> +		  0xa1, 0x43, 0x81, 0x32, 0xa1, 0x72, 0xdb, 0x7d)
>> +
>> +/* Short-hands for these long attribute names */
>> +#define UBUF_INPUT     TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT
>> +#define UBUF_OUTPUT    TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT
>> +#define OBJREF_INPUT   TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT
>> +#define OBJREF_OUTPUT  TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT
>> +
>> +/* Init instance of 'struct tee_param_objref'. */
>> +#define SET_TEE_PARAM_OBJREF(param, attri, obj_id, obj_flag) do { \
>> +		(param).attr = (attri); \
>> +		(param).u.objref.id = (obj_id); \
>> +		(param).u.objref.flags = (obj_flag); \
>> +	} while (0)
>> +
>> +/* Init instance of 'struct tee_param_ubuf'. */
>> +#define SET_TEE_PARAM_UBUF(param, attri, ubuff) do { \
>> +		(param).attr = (attri); \
>> +		(param).u.ubuf = (ubuff);  \
>> +	} while (0)
>> +
>> +#define TEE_PARAM_UBUF(x) ((struct tee_param_ubuf){ .addr = &(x), sizeof(x) })
>> +
>> +#define SET_INVOKE_ARG(arg, object_id, opp, nparam) do { \
>> +		(arg).id = (object_id); \
>> +		(arg).op = (opp); \
>> +		(arg).num_params = (nparam); \
>> +	} while (0)
>> +
>> +static inline efi_status_t uefisecapp_err_to_efi_status(u32 err)
>> +{
>> +	switch (err) {
>> +	case QCOMTEE_UEFI_SEC_SUCCESS:
>> +		return EFI_SUCCESS;
>> +
>> +	case QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER:
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	case QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED:
>> +		return EFI_UNSUPPORTED;
>> +
>> +	case QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED:
>> +		return EFI_WRITE_PROTECTED;
>> +
>> +	case QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION:
>> +		return EFI_SECURITY_VIOLATION;
>> +
>> +	case QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR:
>> +		return EFI_DEVICE_ERROR;
>> +
>> +	case QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES:
>> +		return EFI_OUT_OF_RESOURCES;
>> +
>> +	case QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT:
>> +		return EFI_BUFFER_TOO_SMALL;
>> +
>> +	case QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND:
>> +		return EFI_NOT_FOUND;
>> +
>> +	/* No matching on EFI_* list. */
>> +	case QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED: /* EFI_ALREADY_STARTED.  */
>> +	case QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED: /* EFI_VOLUME_CORRUPTED. */
>> +	default:
>> +		return EFI_DEVICE_ERROR;
>> +	}
>> +}
>> +
>> +static struct qcomtee_uefisec_app uefisec_app;
> 
> Should not this singleton be protected, for instance against concurrent call and driver unbound?
>

The top-level efi_var framework which invokes the efivar_operations callbacks
defined below always takes an efivar_lock() before calling them, see:
https://elixir.bootlin.com/linux/v7.3-rc5/source/fs/efivarfs/vars.c#L501

Also, when this driver is being unbound the efivar_unregister() function called
at the start of qcomtee_uefisecapp_remove() attempts to take the same lock.
So a concurrent call efi-var call and driver remove are protected by
efivar_lock().

Since this singleton is always accessed under the same efivar_lock()
everywhere in this driver, it is also implicitly protected.
This is the reason why the STM efivar driver also doesn't protect its
singleton:
https://elixir.bootlin.com/linux/v7.3-rc5/source/drivers/firmware/efi/stmm/tee_stmm_efi.c#L27

I will add a comment on top of this singleton to explain that it is implictly
protected by efivar_lock().

Please do point out if there is some other corner case which you believe is
still not covered by the efivar_lock().

Regards,
Harshal 
>> +
>> +static int qcuefi_get_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
>> +			       struct tee_param_ubuf in_attributes,
>> +			       struct tee_param_ubuf *data,
>> +			       u32 *out_attributes, u32 *out_errno)
>> +{
>> +	int ret;
>> +	struct tee_ioctl_object_invoke_arg inv_arg;
>> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
>> +	struct tee_param param[QCOMTEE_GET_VAR_NPARAMS];
>> +
>> +	struct {
>> +		efi_guid_t guid;
>> +		u32 in_data_size;
>> +	} in_cong = { 0 };
>> +
>> +	struct {
>> +		u32 out_data_size;
>> +		u32 attributes;
>> +		u32 errno;
>> +	} out_cong = { 0 };
>> +
>> +	in_cong.guid = *guid;
>> +	in_cong.in_data_size = data->size;
>> +
>> +	memset(&inv_arg, 0, sizeof(inv_arg));
>> +	memset(&param, 0, sizeof(param));
>> +
>> +	SET_INVOKE_ARG(inv_arg, obj_id,
>> +		       QCOMTEE_UEFI_SEC_OP_GET_VAR,
>> +		       QCOMTEE_GET_VAR_NPARAMS);
>> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
>> +	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
>> +	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, in_attributes);
>> +	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
>> +	SET_TEE_PARAM_UBUF(param[4], UBUF_OUTPUT, *data);
>> +
>> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_VAR invoke ret: %d, err: 0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return ret ?: inv_arg.ret;
>> +	}
>> +
>> +	data->size = out_cong.out_data_size;
>> +	*out_attributes = out_cong.attributes;
>> +	*out_errno = out_cong.errno;
>> +
>> +	return ret;
>> +}
>> +
>> +static efi_status_t qcomtee_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid,
>> +					      u32 *attr, unsigned long *data_size,
>> +					      void *data)
>> +{
>> +	int ret;
>> +	u32 in_attr, out_attributes, out_errno;
>> +	struct tee_param_ubuf in_data, in_var, in_attributes;
>> +
>> +	if (!name || !guid)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	/* 'attr' can be NULL, however an input attribute is always expected
>> +	 * by UefiSecApp TA
>> +	 */
>> +	in_attr = 0;
>> +	if (attr)
>> +		in_attr = *attr;
>> +
>> +	in_data = (struct tee_param_ubuf){ .addr = data, *data_size };
>> +	in_var = (struct tee_param_ubuf){ .addr = name,
>> +					  (ucs2_strlen(name) + 1) * sizeof(*name) };
>> +	in_attributes = (struct tee_param_ubuf){ .addr = &in_attr, sizeof(u32) };
>> +
>> +	/* On SUCCESS, 'data' member of 'in_data' has already been updated. */
>> +	ret = qcuefi_get_variable(in_var, guid, in_attributes, &in_data,
>> +				  &out_attributes, &out_errno);
>> +
>> +	if (ret)
>> +		return EFI_DEVICE_ERROR;
>> +
>> +	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT) {
>> +		/* If 'attr' is NULL 'out_attributes' is not updated. */
>> +		if (attr)
>> +			*attr = out_attributes;
>> +
>> +		*data_size = in_data.size;
>> +	}
>> +
>> +	return uefisecapp_err_to_efi_status(out_errno);
>> +}
>> +
>> +static int qcuefi_set_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
>> +			       u32 attributes, struct tee_param_ubuf data,
>> +			       u32 *out_errno)
>> +{
>> +	int ret;
>> +	struct tee_ioctl_object_invoke_arg inv_arg;
>> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
>> +	struct tee_param param[QCOMTEE_SET_VAR_NPARAMS];
>> +
>> +	struct {
>> +		efi_guid_t guid;
>> +		u32 attributes;
>> +		u32 in_data_size;
>> +	} in_cong = { 0 };
>> +
>> +	in_cong.guid = *guid;
>> +	in_cong.attributes = attributes;
>> +	in_cong.in_data_size = data.size;
>> +
>> +	memset(&inv_arg, 0, sizeof(inv_arg));
>> +	memset(&param, 0, sizeof(param));
>> +
>> +	SET_INVOKE_ARG(inv_arg, obj_id,
>> +		       QCOMTEE_UEFI_SEC_OP_SET_VAR,
>> +		       QCOMTEE_SET_VAR_NPARAMS);
>> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
>> +	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
>> +	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, data);
>> +	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(*out_errno));
>> +
>> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_SET_VAR invoke ret: %d, err: 0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return ret ?: inv_arg.ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static efi_status_t qcomtee_uefi_set_variable(efi_char16_t *name, efi_guid_t *guid,
>> +					      u32 attr, unsigned long data_size,
>> +					      void *data)
>> +{
>> +	int ret;
>> +	u32 out_errno;
>> +	struct tee_param_ubuf in_data, in_var;
>> +
>> +	if (!name || !guid)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	in_data = (struct tee_param_ubuf){ .addr = data, data_size };
>> +	in_var = (struct tee_param_ubuf){ .addr = name,
>> +					  (ucs2_strlen(name) + 1) * sizeof(*name) };
>> +
>> +	ret = qcuefi_set_variable(in_var, guid, attr, in_data, &out_errno);
>> +	if (ret)
>> +		return EFI_DEVICE_ERROR;
>> +
>> +	return uefisecapp_err_to_efi_status(out_errno);
>> +}
>> +
>> +static int qcuefi_get_next_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
>> +				    struct tee_param_ubuf *out_variable,
>> +				    efi_guid_t *out_vendor_guid, u32 *out_errno)
>> +{
>> +	int ret;
>> +	struct tee_ioctl_object_invoke_arg inv_arg;
>> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
>> +	struct tee_param param[QCOMTEE_GET_NEXT_VAR_NPARAMS];
>> +
>> +	struct {
>> +		efi_guid_t guid;
>> +		u32 in_data_size;
>> +	} in_cong = { 0 };
>> +
>> +	struct {
>> +		efi_guid_t guid;
>> +		u32 out_data_size;
>> +		u32 errno;
>> +	} out_cong = { 0 };
>> +
>> +	/* Pass size of available buffer */
>> +	in_cong.in_data_size = out_variable->size;
>> +	in_cong.guid = *guid;
>> +
>> +	memset(&inv_arg, 0, sizeof(inv_arg));
>> +	memset(&param, 0, sizeof(param));
>> +
>> +	SET_INVOKE_ARG(inv_arg, obj_id,
>> +		       QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME,
>> +		       QCOMTEE_GET_NEXT_VAR_NPARAMS);
>> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
>> +	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
>> +	SET_TEE_PARAM_UBUF(param[2], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
>> +	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, *out_variable);
>> +
>> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME invoke ret: %d, err: 0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return ret ?: inv_arg.ret;
>> +	}
>> +
>> +	/* UefiSecApp TA does not touch 'out_variable.size'. Update it here.
>> +	 * On SUCCESS (!out_errno), 'out_data_size' is length of name in 'out_variable.addr'.
>> +	 * On failure (out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT), 'out_data_size' is
>> +	 * actual name length.
>> +	 * Otherwise, it's undefined.
>> +	 */
>> +	out_variable->size = out_cong.out_data_size;
>> +	*out_vendor_guid = out_cong.guid;
>> +	*out_errno = out_cong.errno;
>> +
>> +	return ret;
>> +}
>> +
>> +static efi_status_t qcomtee_uefi_get_next_variable(unsigned long *name_size,
>> +						   efi_char16_t *name,
>> +						   efi_guid_t *guid)
>> +{
>> +	int ret;
>> +	u32 out_errno;
>> +	efi_guid_t out_guid;
>> +	struct tee_param_ubuf in_var, out_var;
>> +
>> +	if (!name_size || !name || !guid)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	if (*name_size == 0)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	/* For 'in_var', 'name_size' is not necessarily size of 'name';
>> +	 * could be size of buffer where 'name' has been stored. TA expects a
>> +	 * NULL-terminated string in 'name' and ignores the size.
>> +	 * For 'out_var', 'name_size' is size of buffer pointed by 'name'.
>> +	 */
>> +	in_var = (struct tee_param_ubuf){ .addr = name, *name_size };
>> +	out_var = (struct tee_param_ubuf){ .addr = name, *name_size };
>> +
>> +	ret = qcuefi_get_next_variable(in_var, guid, &out_var, &out_guid,
>> +				       &out_errno);
>> +	if (ret)
>> +		return EFI_DEVICE_ERROR;
>> +
>> +	if (!out_errno)
>> +		*guid = out_guid;
>> +
>> +	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT)
>> +		*name_size = out_var.size;
>> +
>> +	/* On SUCCESS, 'name' stores the next variable name. */
>> +	return uefisecapp_err_to_efi_status(out_errno);
>> +}
>> +
>> +static int qcuefi_query_variable_info(u32 attributes,
>> +				      u64 *maximum_variable_storage_size,
>> +				      u64 *remaining_variable_storage_size,
>> +				      u64 *maximum_variable_size, u32 *out_errno)
>> +{
>> +	int ret;
>> +	struct tee_ioctl_object_invoke_arg inv_arg;
>> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
>> +	struct tee_param param[QCOMTEE_QUERY_VAR_NPARAMS];
>> +
>> +	struct {
>> +		u64 max_var_storage_size;
>> +		u64 remaining_var_storage_size;
>> +		u64 maximum_var_size;
>> +		u32 errno;
>> +	} out_cong = { 0 };
>> +
>> +	memset(&inv_arg, 0, sizeof(inv_arg));
>> +	memset(&param, 0, sizeof(param));
>> +
>> +	SET_INVOKE_ARG(inv_arg, obj_id,
>> +		       QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO,
>> +		       QCOMTEE_QUERY_VAR_NPARAMS);
>> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(attributes));
>> +	SET_TEE_PARAM_UBUF(param[1], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
>> +
>> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO invoke ret: %d, err: 0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return ret ?: inv_arg.ret;
>> +	}
>> +
>> +	*maximum_variable_storage_size = out_cong.max_var_storage_size;
>> +	*remaining_variable_storage_size = out_cong.remaining_var_storage_size;
>> +	*maximum_variable_size = out_cong.maximum_var_size;
>> +	*out_errno = out_cong.errno;
>> +
>> +	return ret;
>> +}
>> +
>> +static efi_status_t qcomtee_uefi_query_variable_info(u32 attr, u64 *storage_space,
>> +						     u64 *remaining_space,
>> +						     u64 *max_variable_size)
>> +{
>> +	int ret;
>> +	u32 out_errno;
>> +	u64 maximum_variable_storage_size;
>> +	u64 remaining_variable_storage_size;
>> +	u64 maximum_variable_size;
>> +
>> +	if (!storage_space || !remaining_space || !max_variable_size)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	ret = qcuefi_query_variable_info(attr,
>> +					 &maximum_variable_storage_size,
>> +					 &remaining_variable_storage_size,
>> +					 &maximum_variable_size,
>> +					 &out_errno);
>> +
>> +	if (ret)
>> +		return EFI_DEVICE_ERROR;
>> +
>> +	if (!out_errno) {
>> +		*storage_space = maximum_variable_storage_size;
>> +		*remaining_space = remaining_variable_storage_size;
>> +		*max_variable_size = maximum_variable_size;
>> +	}
>> +
>> +	return uefisecapp_err_to_efi_status(out_errno);
>> +}
>> +
>> +/**
>> + * qcomtee_release_object() - Release an object returned by QTEE.
>> + *
>> + * Each object returned by QTEE repesents a secure service exposed to the
>> + * client. Whenever an secure service is opened, QTEE may allocate resources
>> + * on the client's behalf. Therefore, once the client is done accessing the
>> + * secure service, the object representing it should be explicitly released
>> + * so that QTEE can release the associated resources as well.
>> + *
>> + * @ctx: TEE context.
>> + * @object: The object to release.
>> + */
>> +static void qcomtee_release_object(struct tee_context *ctx,
>> +				   struct tee_param_objref object)
>> +{
>> +	struct tee_ioctl_object_invoke_arg inv_arg;
>> +
>> +	memset(&inv_arg, 0, sizeof(inv_arg));
>> +	SET_INVOKE_ARG(inv_arg, object.id, QCOMTEE_MSG_OBJECT_OP_RELEASE, 0);
>> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
>> +}
>> +
>> +/**
>> + * qcomtee_get_uefisec_svc_obj() - Get a UEFI Secure App service object to
>> + * begin communication with the service.
>> + * @ctx: TEE context.
>> + * @client_env_obj: The client environment object returned earlier by QTEE.
>> + * @uefisec_svc_obj: The UEFI Secure App service object.
>> + *
>> + * Returns 0 on success.
>> + * Returns < 0 if client environment object invocation failed.
>> + * Returns > 0 if client environment invocation was success but UEFI Secure App
>> + * service object could not be returned for some other reason (represented by the
>> + * returned value)
>> + */
>> +static int qcomtee_get_uefisec_svc_obj(struct tee_context *ctx,
>> +				       struct tee_param_objref client_env_obj,
>> +				       struct tee_param_objref *uefisec_svc_obj)
>> +{
>> +	int ret;
>> +	struct tee_ioctl_object_invoke_arg inv_arg;
>> +	u64 obj_id = client_env_obj.id;
>> +	struct tee_param param[QCOMTEE_GET_UEFI_SVC_NPARAMS];
>> +	u32 uefisec_uid = QCOMTEE_UEFI_SEC_UID;
>> +
>> +	memset(&inv_arg, 0, sizeof(inv_arg));
>> +	memset(&param, 0, sizeof(param));
>> +
>> +	SET_INVOKE_ARG(inv_arg, obj_id,
>> +		       QCOMTEE_OP_CLIENT_ENV_OPEN,
>> +		       QCOMTEE_GET_UEFI_SVC_NPARAMS);
>> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(uefisec_uid));
>> +	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
>> +
>> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(uefisec_app.dev, "QCOMTEE_CLIENT_ENV_OPEN invoke ret: %d, err: 0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return ret ?: inv_arg.ret;
>> +	}
>> +
>> +	*uefisec_svc_obj = param[1].u.objref;
>> +	return ret;
>> +}
>> +
>> +/**
>> + * qcomtee_get_client_env_obj() - Get a client environment object to begin
>> + * object exchange with QTEE.
>> + * @ctx: TEE context.
>> + * @client_env_obj: The client environment object returned by QTEE.
>> + *
>> + * Returns 0 on success.
>> + * Returns < 0 if root object invocation failed.
>> + * Returns > 0 if root object invocation was success but client environment
>> + * object could not be returned for some other reason (represented by the
>> + * returned value)
>> + */
>> +static int qcomtee_get_client_env_obj(struct tee_context *ctx,
>> +				      struct tee_param_objref *client_env_obj)
>> +{
>> +	int ret;
>> +	struct tee_ioctl_object_invoke_arg inv_arg;
>> +	struct tee_param param[QCOMTEE_GET_CLIENT_ENV_NPARAMS];
>> +
>> +	memset(&inv_arg, 0, sizeof(inv_arg));
>> +	memset(&param, 0, sizeof(param));
>> +
>> +	SET_INVOKE_ARG(inv_arg, TEE_OBJREF_NULL,
>> +		       QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS,
>> +		       QCOMTEE_GET_CLIENT_ENV_NPARAMS);
>> +	SET_TEE_PARAM_OBJREF(param[0], OBJREF_INPUT, TEE_OBJREF_NULL, 0);
>> +	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
>> +
>> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(uefisec_app.dev, "QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS invoke ret: %d, err: 0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return ret ?: inv_arg.ret;
>> +	}
>> +
>> +	*client_env_obj = param[1].u.objref;
>> +	return ret;
>> +}
>> +
>> +static const struct efivar_operations qcom_efivar_ops = {
>> +	.get_variable = qcomtee_uefi_get_variable,
>> +	.set_variable = qcomtee_uefi_set_variable,
>> +	.get_next_variable = qcomtee_uefi_get_next_variable,
>> +	.query_variable_info = qcomtee_uefi_query_variable_info,
>> +};
>> +
>> +static int qcomtee_ctx_match(struct tee_ioctl_version_data *ver,
>> +			     const void *data)
>> +{
>> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
>> +}
>> +
>> +static int qcomtee_uefisecapp_probe(struct tee_client_device *tee_dev)
>> +{
>> +	int ret, err;
>> +	struct tee_param_objref client_env_obj;
>> +	struct tee_param_objref uefisec_svc_obj;
>> +
>> +	uefisec_app.dev = &tee_dev->dev;
>> +	/* Open context with QCOMTEE driver */
>> +	uefisec_app.ctx = tee_client_open_context(NULL, qcomtee_ctx_match, NULL,
>> +						  NULL);
>> +	if (IS_ERR(uefisec_app.ctx))
>> +		return -ENODEV;
>> +
>> +	/* Obtain a reference to client_env object to begin object exchange
>> +	 * with QTEE
>> +	 */
>> +	ret = qcomtee_get_client_env_obj(uefisec_app.ctx, &client_env_obj);
>> +	if (ret) {
>> +		err = -EINVAL;
>> +		goto err_get_client_env;
>> +	}
>> +
>> +	/* Obtain a reference to the uefisec_svc object which provides access to
>> +	 * the EFI var storage.
>> +	 */
>> +	ret = qcomtee_get_uefisec_svc_obj(uefisec_app.ctx, client_env_obj,
>> +					  &uefisec_svc_obj);
>> +	if (ret) {
>> +		err = -EINVAL;
>> +		goto err_get_uefisec_svc;
>> +	}
>> +	uefisec_app.uefisec_svc_obj = uefisec_svc_obj;
>> +
>> +	ret = efivars_register(&uefisec_app.efivars, &qcom_efivar_ops);
>> +	if (ret) {
>> +		err = ret;
>> +		goto err_efi_vars_reg;
>> +	}
>> +
>> +	/* We don't need to keep a reference to this object anymore, we only
>> +	 * needed it to obtain the uefisec_svc object.
>> +	 */
>> +	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
>> +	return 0;
>> +
>> +err_efi_vars_reg:
>> +	qcomtee_release_object(uefisec_app.ctx, uefisec_svc_obj);
>> +err_get_uefisec_svc:
>> +	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
>> +err_get_client_env:
>> +	tee_client_close_context(uefisec_app.ctx);
>> +
>> +	return err;
>> +}
>> +
>> +static void qcomtee_uefisecapp_remove(struct tee_client_device *tee_dev)
>> +{
>> +	efivars_unregister(&uefisec_app.efivars);
>> +	qcomtee_release_object(uefisec_app.ctx, uefisec_app.uefisec_svc_obj);
>> +	tee_client_close_context(uefisec_app.ctx);
>> +}
>> +
>> +static const struct tee_client_device_id qcomtee_uefisecapp_id_table[] = {
>> +	{UEFISECAPP_UUID},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(tee, qcomtee_uefisecapp_id_table);
>> +
>> +static struct tee_client_driver qcomtee_uefisecapp_driver = {
>> +	.id_table	= qcomtee_uefisecapp_id_table,
>> +	.probe		= qcomtee_uefisecapp_probe,
>> +	.remove		= qcomtee_uefisecapp_remove,
>> +	.driver		= {
>> +		.name		= "qcom-tee-uefisecapp",
>> +	},
>> +};
>> +
>> +module_tee_client_driver(qcomtee_uefisecapp_driver);
>> +
>> +MODULE_AUTHOR("Qualcomm");
>> +MODULE_DESCRIPTION("TEE client driver for Qualcomm TEE UEFI Secure App");
>> +MODULE_LICENSE("GPL");
>>
> 

