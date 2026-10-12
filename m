Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50975CA9ED1
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 09:36:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 766B8451E9
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791797788;
	bh=Cd1sz5HqVwywuKmbSEi2GjApynlrMw3/S4hBxggZCtA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=MKd0ZttOk+srT21AA7MnXM8hM+3ibWKXQLCCAVRvROKKwhdioL4yOZN097zAh9q97
	 /nAmo/snUIMu4jsiaPfeYQxHzXRc5hx/dHzhX8HP+7VgDpDEF5AsBitmCRlk0PAq11
	 T+s7iNybSGrtI/v5+PAQFj+A2oRr4akF2wccMx01ji8gFZ1a8hbbCi/DbLmyRDVO4c
	 FJLcY7JOW/H8t96NHlhQeRqk57eJKYWBbx0bB37TeyiuGmZ9SzxSQ7xW6FlM5Uz5GO
	 Zyc+X7vKmZtSvMtbzTb1kFd+y82QvJ/LQhR3uzcd/QCATUxXrbq42oKE0UlREuvz2v
	 b9qz4oVY/gJ0g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2D38E43EE6
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:36:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SUoBJNe0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g86Quo7z;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8KlTc2181456
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vFI6tpwU01Vx9Ur1mcn8qmOufatJQe19bsiv/JBf6+I=; b=SUoBJNe0eJ8QLDwM
	XVWcB7cO5XkHjsV0YxCtcZpg1Ex9AhGqVqkWaA/gC1XSQlof4xfLYmreJVV0KMzm
	vINpEem1O/EBoCtHU1V5faS+EtIg5Dr53hHTl++L5m3N5YU7/hQ9T08HF/mNpg/d
	ECwQ8WgGr9Qnhbn98hWjTwkPrTDqJqg5Zaa6FtTj4PLiggDJNp4ATCwpHXKeyYKF
	OO3Tos2CYiDLInEd093sYJSBiplCag5/JOz1U/TfeEOdX9dWGF1m2RCtSqE3akmq
	O1iwqs6CL5N9IftG/O31Savzt3RGdme2Wg9f2VWAEHhDZJUOdnpIua5su1blkr6F
	87apPw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1s2tp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:36:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-88c4da716f4so2584094b3a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791797767; x=1792402567; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vFI6tpwU01Vx9Ur1mcn8qmOufatJQe19bsiv/JBf6+I=;
        b=g86Quo7z1mPluaNCFC9efY5qUvY6FggW/6jjzpmZigjTGBcMnOX2+U1yTHjq31Lp1Y
         5ESAcezhwbTCekOfFZfpiRMSacahgU8r57hMNHVkDtR0pLrQIStx9+mUqeT/ROwGSn0d
         U7b+s3wqm0dDhO++9YO2z+qL50nJsliEI+fWtXkNfQgctvK7GGCr2rCTLLj9kpb/3hHN
         5MN+Te82NybGHzTk2KDvvbLibfQc7dFHpYo4ZfwgkZVILC+X5TsszM8kNrKY43BlMoJq
         M1j7Ui0nToQbZ8betTLFCi1dHQZvVwu45WY617yli+1sJ4c575r2Ls3JPFtgdosjxRMg
         qBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791797767; x=1792402567;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vFI6tpwU01Vx9Ur1mcn8qmOufatJQe19bsiv/JBf6+I=;
        b=lnRhJwFoALesrd4O4Pgc86Ic1y29VhYKONqiDSZMBk7NGM54AGU/9PNTihO7xvtcDV
         U9L4qWsKZainHICHEpjjXtnFt/37uQOAk6E26oElpjPPZyuuLtjeUAIw/7adUDIz6sAF
         QdQLd6UYXvC+rsiBfdVr5rjZiXvvggr8KyFybH0RZiQKuGB+0nythFo7plFTgrNZ4qLb
         AzM1orZ/ijVaRNhEbzCa7PKk41BO48jPmAdop5IKDTPmF3UdxHZ2pTuW0CauhKHTw94a
         sbC9gB1IMA6ro8aXTIUnyo+wYGZqEOmr9rRXaGV/cYf4rXmcai4kJ3hMVNRWvLDO3bhb
         m7Mg==
X-Forwarded-Encrypted: i=1; AKwUvBz+RBWI4M0gb5L+TJPdnPCU7uVOpuePkNSt4dlNh+wpQj/D78MspxQYFtO7WlfYamR4K524ffM=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYI0q3sessbAGFGz1mSSfBjTK5Zc45pP5LxRPn2Hm67mx+Rr/XXg
	snaAXFK2W2+Go17a+PME155+nyXAokXZvnQDYxsXWLJz+uDkkiaMkkPzdM0UiVsuBIeN2mNbyfb
	5DCHBlJPq0H6J6fVvRHCyWWY2z2FLznAm1LvDOJ8p/JXxHJFpAvqp5ywVJLom4Q99P03KQsho
X-Gm-Gg: AYBFou0ji3mi/SBvUWoD649a8PLlj82qZSVVIuxvV1b1ZVerwqoNx0a/59Bl/OhZWZJ
	l6Q6XyT/7zC9FgUVNSVDLP+p2PTa4Rwbkj2YvxQqLjCav92QfBn3PZhNhbrFiSRUU2SSOaggMoA
	KVTYEJe2zab1u79UGrd+8kaqUK7JzBTIPBR2LGd4YN0LBHhakCZmDY7lZqfQN57zRfIkkR3my0f
	ZjSdlYyctC8nl+F42f2KEdWWQ/VNjIVMGugNgFPVIg+5eWOGfRyUGauLaKx3v/dallJ6a/A+7bC
	fWq0h52PpF8KUV025+6P97a4TmWdYuwylHmufG4fcxlcu0Xb5Sry8wZ41UN3g/1A2q/bFqm27yQ
	UfLl9iq1tenqNnvKRnBjW4c5O6/YRUA==
X-Received: by 2002:a05:6a21:610e:b0:3dd:a00a:1715 with SMTP id adf61e73a8af0-3e16bebe9c7mr7324454637.48.1791797767419;
        Mon, 12 Oct 2026 02:36:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:610e:b0:3dd:a00a:1715 with SMTP id adf61e73a8af0-3e16bebe9c7mr7324422637.48.1791797766811;
        Mon, 12 Oct 2026 02:36:06 -0700 (PDT)
Received: from [192.168.29.10] ([49.37.155.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9d4fc36sm4014405a12.1.2026.10.12.02.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:36:06 -0700 (PDT)
Message-ID: <1854d39a-9ef9-4b04-8b5b-3384b8403375@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 15:06:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
 <20261006-qcom_uefisecapp_migrate_qcomtee-v4-6-bf1c8e2a64ab@oss.qualcomm.com>
 <r7gtspju4cp5iwelv4zs4xoh4d7ambeceptmjtqaf5hcjzmc5n@4msc3ap4yfhz>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <r7gtspju4cp5iwelv4zs4xoh4d7ambeceptmjtqaf5hcjzmc5n@4msc3ap4yfhz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2jjnlVeiTz1NUQSsH1QVZJRrY8oSOw3J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfXwnX2iRgqoOPV
 P1SQ1BVrOK+mMUSeQIqaBo2QvOug7qpfU5WBhcJY9VGXbDoxw+LEEhQJRz0tWEUCQYCCTva18JI
 YR9Y4Sgx457CjtBuUzQg+vHIC08gZig=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6accaa08 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ivpbP8R7Mhpy7qfOLL/Q+g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=sfOm8-O8AAAA:8 a=LDF6XqZlvw75vdSADQcA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: 2jjnlVeiTz1NUQSsH1QVZJRrY8oSOw3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfX8wbUogbyL2Xp
 Z5FyqL/lxWEOcWHnysHrKMnxlG+3ykMFdeiP999fvFDgJjUuakEOvcZ06QOPu6HdNMBifqivCI6
 bRfH93MEsa6w4IJCruEoNMF6Of8VnWdJVJQSt0SIAFGnMKog8QJ8TecV6SAsHiqUa3ugwXMb8dd
 YOj/DfkixRy67GCA5qH/64EySp6nVtafK6ZQCDRSXFzu2IFSdc/3kEIka9ZDcq/FZzD8YMOfWfp
 RTD256fRmyUI8zGbmUjf6/M0DZfEO0/VLQ5ct1V4E8UkAkKpdGVs3fnpq/5feMm73b64MN/aTQ3
 tE0zdcQ8Ms3Ah4CHiArQiGsHEQt3HEWb0am3lNNvmg5dnpTeomZSziaJGIZUv452pF8xQHHx6X/
 DDPKHWcB+5UgYsBibtnzZYWSkLuUpKNYbGr/Pbxs0K0Bg7uBnW73Jg2APDlLx6zbJvF56zT+Q4F
 0ki2abjq6VFs8ELMQUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120038
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
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
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2D38E43EE6
X-Spamd-Bar: ----
Message-ID-Hash: 6HNKHJEMTWGAMS3T46ENPVXZTCUMXNKV
X-Message-ID-Hash: 6HNKHJEMTWGAMS3T46ENPVXZTCUMXNKV
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6HNKHJEMTWGAMS3T46ENPVXZTCUMXNKV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Dmitry,

On 06-10-2026 07:18 pm, Dmitry Baryshkov wrote:
> On Tue, Oct 06, 2026 at 05:03:27PM +0530, Harshal Dev wrote:
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
> 
> Why do we need to copy data? Can we pass pointers directly to the
> qcuefi_foo calls?
>

Ack, this function can have this optimization, no need for copying.
 
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
> 
> Nit: check out the preferred block comment format. also, I think these
> comments echo the code which pretty obvious here.
>

Ack, I'll just drop this comment. And update the other ones to the preferred
block comment format.

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
> 
> If we have both QSEECOM and QTEE drivers enabled (which we hopefully
> will in distro kernels) and if QSEECOM has already provided UEFI vars
> implementation, this call will print a warning and a probe error in
> kernel logs. Similarly, if this driver registers UEFI vars
> implementation first, the QSEECOM one will print out the error.
> 
> We know that there is this kind of a clash. I think it makes sense to
> handle it. Earlier you wrote that QTEE would be a better option if the
> platform supports both. Would it be possible to implement this kind of
> selection?
>

This has been on my mind since the beginning. We could have a central
hub layer which both the QCOMTEE and QSEECOM drivers register with during
their probe and pass a list of services they can communicate with. This
one for example:
https://elixir.bootlin.com/linux/v7.3-rc5/source/drivers/firmware/qcom/qcom_qseecom.c#L86

When the hub realizes (at QCOMTEE registration) that a service is available
via both QSEECOM and QCOMTEE, it could call an API such as qcomtee_check_service()
to check if the current QTEE firmware OS version supports it. If so, it would
call qseecom_client_remove() for this service:
https://elixir.bootlin.com/linux/v7.3-rc5/source/drivers/firmware/qcom/qcom_qseecom.c#L30
and then call qtee_register_service().

This is a high level view of how such a framework could work. But since
only uefisecapp currently fits this scenario it feels like an overkill to
push it along with this series. I can see that Kuldeep's series which is adding
TPM service support also fits the scenario of a service being available via both
QSEECOM and QCOMTEE:
https://lore.kernel.org/all/20261001055029.1960743-1-zeroknots@protonmail.com/

I am fine with investigating the feasibility of such a framework in more
depth if everyone here feels that it is now required. Amir's inputs on this
would be welcome since he is the maintaiiner for QCOMTEE.

And this would have to be a separate patch series after this one lands.

Regards,
Harshal 
>> +		err = ret;
>> +		goto err_efi_vars_reg;
>> +	}
>> +
> 

