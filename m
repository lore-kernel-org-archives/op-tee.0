Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB00606D821
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXXVgmI6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E0yYotJ8
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5A5F445458
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 08:35:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXXVgmI6;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E0yYotJ8;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5318844FC6
	for <op-tee@lists.trustedfirmware.org>; Tue,  3 Nov 2026 08:35:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A34h6ec750896
	for <op-tee@lists.trustedfirmware.org>; Tue, 3 Nov 2026 08:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjGYOoXPqfO2PS+EnHbnCc2SRWa6MjKD0u4kM2SpnS4=; b=GXXVgmI6Cc3TuPFu
	L+xDj/gHi2O6rL3sl/UWonamh65+NBM4el0R+m4WuoEoafd1/z5y9QhftleewQCC
	KfHi3hXfmeVmoyYSqmapbruCuholnIalSxt1Ll4D1Aza46rT0vg+LtgMeaycgMPQ
	anpqpU6PhuAO188PcI7OiQeZ73gHHwsW+eg7/NQF3TvgDcZh6KouBDDmTELJu9Hv
	siP6pExcWpQhXokO04IyjmUpaEE+BKGtqTz5hHvn+BFv4J+3r1tJqZwycYO3Peq9
	ghTT06ahr9Pve9RohM62gwrfCTAhdlh4WxgcxNX/5qcFw79PQ5Hb96dEH3EsnczK
	lXEOHQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq8u5gu6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 08:35:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eaae8d29e0so34612065ad.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 00:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793694919; x=1794299719; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jjGYOoXPqfO2PS+EnHbnCc2SRWa6MjKD0u4kM2SpnS4=;
        b=E0yYotJ8TIKWOws2mQrVYPmkIgzZYs/rgzCIHNj1NTbZIsT6kY7PXSpp0wRjyt6hxb
         aZLfU3ZcHxnKBkNcZ/BT3+j/fHooNI5M8+QNMPLB33LfqjMmuaPghBqazZ47xamB10iZ
         0+KR6pM6rus7lqbsPNnkP6n2Fx2BPmOdBCwmDcJCpljs6ZHDlfKhbUhXBdQbM2L6P4Fm
         ewvkAp0lS6EQvAV0Ejd7q0udfNKydqhMeTh4xAHJMFeTxhnuVorsCOoNgvj3d4wIwf73
         Y0c0Z8fnJfmaFogvFW+s4jATMzjdGpK6nhouYsI74Pp3MKfvSQ915AYizzqHxZHckiuX
         IVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694919; x=1794299719;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jjGYOoXPqfO2PS+EnHbnCc2SRWa6MjKD0u4kM2SpnS4=;
        b=wkGaK4lPdeUhovRGDj8PlCHLEaUz5z2ucJV5nAWpj6+U067+64+zpfAA7eBOWNiMIX
         fCu0GJCQTaQz9ZHg6yP7a2wj73bU7QJqEmCZRBOXXyg9OtKpAPnkunWwTtrvyEdjbLeS
         hOD4jjfETvnv1BJArFPm9qvJJGExUaAdjD/vToanWILlrH3qWosDDvz973VcYDTy0Nif
         ItlNzenCM1ZIHnuN0YqcRYny9PAQF95IrYWSsp3+lF75z/99V/YU0r8ZOmkGoNtq6Kxx
         vrTRJ3mZ6L5rEPIz+eCo4MO9E+9Bg94FJN49AY1ZfwiWp/LoY9TPfFlMTBkwmaxpCL8J
         tP9A==
X-Forwarded-Encrypted: i=1; AKwUvByb4kd1Lh5bfbZytHGCB0GQt10XM0rxZYrQoIunhx546YNcU/IEKPhyR2DeI4KhIETrwjL3+dk=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+YDgSDZP77SEANoBASenZOHBbWZTZfhm8C6V1Ok45Zb3mFmi/e
	dpnSVErbBQV1hxXdiFkoqQx4Wf/SylYgufbmj2183vqdjFn+Vt+x1v0yQoDoZBpKt4ekvN1pyBo
	X6PxkRM+1K85rm7qg09up/v/QcWJ+LZ8ZUDx8c+ap3ZmkI1B5nqtylgOPvkwc+ZIhR5aQNjzS
X-Gm-Gg: AYBFou2+BIlppWnYcXRQEg9+DGod772ULRliMZLGN7BcTB3oR2/B6QWPNHUnoNzwRF3
	hPEbd3T/BaKr1eUW0/0hN044xFtOkuTkBkyf2nbVTlSavYv2b2dk4Z+yQDj1r9AIkVChkj/QqeO
	unYeKK44Pnb6SZv6mpakTcVVHZet5b3KSin6iGvSlg2K/xy/ydCxr/2Ldy+SgM9/+r7AFM5Fr0W
	k3IOWBgaU/LSEl7Hqj5Uua8fwUt6QCowhnbq7Klal+rGeiM3U5/eWtOTzmGtOZEw8tR9nY75iF5
	bi6DwpjBhqu0vrUTivzPFa7+MsPrCZbozQ25wQG9gEc+d6CT7sfn/oPgg1b66lDfxqAe5v023cu
	T2wkfNs8KtfZcnsN9N5sB71Jk4MtGqY6VLYDbyWGCUWZpw5RxYRZSjJ7hI8TrRQ0yjmU6mlAoqA
	==
X-Received: by 2002:a17:903:1b50:b0:2e9:4f21:91ef with SMTP id d9443c01a7336-2eb3644f6b4mr108754135ad.36.1793694918700;
        Tue, 03 Nov 2026 00:35:18 -0800 (PST)
X-Received: by 2002:a17:903:1b50:b0:2e9:4f21:91ef with SMTP id d9443c01a7336-2eb3644f6b4mr108753885ad.36.1793694918130;
        Tue, 03 Nov 2026 00:35:18 -0800 (PST)
Received: from [10.218.26.96] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922fc14sm37867755ad.26.2026.11.03.00.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 00:35:17 -0800 (PST)
Message-ID: <eddd891e-c23f-4977-9f40-9a41222f5bf2@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 14:05:12 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v5 6/7] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-6-1460691b35d3@oss.qualcomm.com>
 <4fed24d1-72a4-4314-a6e0-89ee7546240b@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <4fed24d1-72a4-4314-a6e0-89ee7546240b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0sSajccd-PGf_EtAsXaVXCX0uPx49hay
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNCBTYWx0ZWRfX/xeBM2HurmwM
 tpF+JVG8o7UwrkWzpr9SrBOyjKINlVpJ9W9uMjzpYj33rgQ3iVABgu9fYfeiveE86oNrwImwSMW
 +f5+Osdntk6eTyZOUTJQeuOFijB/kNE=
X-Authority-Analysis: v=2.4 cv=RZ0FmFtv c=1 sm=1 tr=0 ts=6ae99cc7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=G7uvFKq4MHJBrDxLf1cA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 0sSajccd-PGf_EtAsXaVXCX0uPx49hay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNCBTYWx0ZWRfX/Q6x5oecPuR3
 ZhqvHfyaAgG9KQWwQD0KZJH4ZAhSv5tdXs0O6Xwlqzn7kUtApCL7U+cMukhFcqtDA6JNWfOPpo7
 Z37jgzTe051/bGZKjx3MzSQY8/kTMy9Ce7kzFuXM1vaaFTM5HjCcirXpn21TIOcBWOD1trSiw4Y
 L+malivXkvUUessnbaFclN7AdilVWS7F0XpNSS8f9xMPmBXBEdhIZm9oxUweU8bvMfi+maNQnwG
 BcXzMk5a6icWuTmN+PyeaGmscMWd5lgyCwgxNoMUD7OF3lT3D/t1diIo/7ynceZgezBFL3hltqJ
 LWHUc59D8kN8ez3jNKIu3ttM3zWuD0feb1SXWOIUg2zPRla+vPW5Rgm09aING8zz9zKTp/3xwSC
 DIZpCXFAn8A7G1MgaMEVs+WoNPhswwwYIJxF+Sn+ePSnX5swhgTQUAVg/9JuDgeBfBY+VL2a/Ol
 4MFAagVh8j2hH2e3FnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030034
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5318844FC6
X-Spamd-Bar: ----
Message-ID-Hash: QAOAJFUMHGQO6FAFHX7KFVLFLTIUL7VP
X-Message-ID-Hash: QAOAJFUMHGQO6FAFHX7KFVLFLTIUL7VP
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QAOAJFUMHGQO6FAFHX7KFVLFLTIUL7VP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Amir,

On 26-10-2026 10:14 am, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 10/15/2026 10:39 PM, Harshal Dev wrote:
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
>>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 644 ++++++++++++++++++++++++++++
>>  4 files changed, 682 insertions(+)
>>

[...]

>> diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>> new file mode 100644
>> index 000000000000..bcd025f929fc
>> --- /dev/null
>> +++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>> @@ -0,0 +1,644 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/efi.h>
>> +#include <linux/tee.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/ucs2_string.h>

[...]

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
>> +	/*
>> +	 * 'attr' can be NULL, however an input attribute is always expected
>> +	 * by UefiSecApp TA
>> +	 */
> 
> You are enforceing a poliy on the arguments of a cb which is called publicly, are you
> sure all callers understand that this output value is optional? it is not specified
> anywhere as far as I can see. This seesm to be a TA thing.
>

I think the way this comment is written is a bit misleading. The comment is not about
the output value of attr, it is about the input value passed to this callback.

The callers of this callback either pass a NULL value for attribute or a valid value.
When they pass NULL, they ignore the output since it's expected to not be set by the
implementation: https://elixir.bootlin.com/linux/v7.3/source/fs/efivarfs/vars.c#L505

When they pass a valid value, they expect a valid output in return and operate on it:
https://elixir.bootlin.com/linux/v7.3/source/fs/efivarfs/file.c#L108
https://elixir.bootlin.com/linux/v7.3/source/fs/efivarfs/vars.c#L531
So the value is not optional, it is set or not set as per the expectation of the
caller. 
 
>> +	in_attr = 0;

However, the SMCInvoke transport here needs this to not be NULL, and so we force
set a 0 here which is interpreted corrected by the TA as attribute not set.

I will re-phrase this comment to avoid ambiguity.

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

[...]

>> +
>> +static const struct efivar_operations qcom_efivar_ops = {
>> +	.get_variable = qcomtee_uefi_get_variable,
>> +	.set_variable = qcomtee_uefi_set_variable,
> 
> Not sure how much it is relevant, but I was looking into the efi and in
> efivar_set_variable_locked, saw this comment "If no _nonblocking variant exists,
> the ordinary one is assumed to be non-blocking." which in not the case fo us.
> 
> Does it make sense to introduce something like
> qcomtee_uefi_set_variable_nonblocking and return UNSUPPORTED!?
>

Ack, this ensures that if a caller expects the set_variable() to land in a
non-blocking call, they get returned -ENOTSUPPORTED instead of being misled.
As far as I can see only the x86 pstore implementation explicitly requests
a call into a non-blocking variant:
https://elixir.bootlin.com/linux/v7.3/source/drivers/firmware/efi/efi-pstore.c#L227
 
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
>> +	ret = qcomtee_get_client_env_obj(uefisec_app.ctx, &client_env_obj);
>> +	if (ret) {
>> +		err = -EINVAL;
>> +		goto err_get_client_env;
>> +	}
>> +
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
>> +	/*
>> +	 * We don't need to keep a reference to this object anymore, we only
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
> 
> I still have concerns about the removal path. efivars_unregister() acquires the
> semaphore interruptibly and can return -EINTR, for example when a signal arrives while
> it waits for an active EFI operation. Its return value is ignored here, so removal can
> release the service object and close the TEE context while the EFI provider remains registered.
>

This is a valid point. But it seems like no easy solution exists here. The driver core
doesn't check the value being returned from remove(), so it will always detach the driver from
the device.

Currently when -EINTR is returned, the driver is removed but __efivar->ops remain set, so a
subsequent call to __efivars->ops would cause a kernel panic/crash. If we check for error here
and return without releasing the service object/TEE context, we still have the same issues but
now also a leak; QTEE's object table still has the service object and the TEE context remains
allocated (while the driver is removed and __efivars->ops remain set to a random pointers).

Everyone else is also suffering the same race:
https://elixir.bootlin.com/linux/v7.3/source/drivers/firmware/efi/stmm/tee_stmm_efi.c#L518
https://elixir.bootlin.com/linux/v7.3/source/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c#L842
https://elixir.bootlin.com/linux/v7.3/source/drivers/firmware/google/gsmi.c#L1075

This is a framework level issue, where a fail-safe fix is to use down() instead of down_interruptible()
in efivar_unregister() and pray that whoever is invoking the callback comes out soon. But at
least it replaces a sure-shot kernel panic with a low probability deadlock which can be
diagnosed.

I thought about other ways, like using try_module_get() from either the callbacks or the
efivar_register/unregister(), but neither solve this.
I can try initiating a discussion on this separately on the efivar mailing list, unless there
are any other innovative suggestions for solving it from within the driver. :)

Let me know your thoughts.

> Separately, efivar_lock() appears to have an existing bug: it checks __efivars->ops
> without first checking whether __efivars is NULL. Successful unregister sets that pointer to NULL,
> so subsequent access through an existing efivarfs can dereference NULL.
> I Feel, that needs an EFI-core fix as well. what do you think?
>

Ack, this is true and a fix is straightforward. I will send a patch separately if someone hasn't
already sent one.

Regards,
Harshal
 
> 
> - Amir
>
