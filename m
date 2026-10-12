Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8028ECA9ED0
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 09:45:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BA3D6451B1
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791798337;
	bh=fBVkiEo0lmz4W4b+TPHdkvDruTk6CvZhhfO3wDZi8IY=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Hk7XAL5lsljfxnsYCAPrBUxXQ8G8MfObdGgg7C5xwkEVvDncoPO2zUTJjU2p3XNPF
	 uAm/qE8wDKcHtl8jxsRResXryyOHBqHWk7VEqYSFOXVi9tqpA7mL/Rg4knsuyTj8oQ
	 Pm/sYUGJxWkmsp5U9ciQmqV/KAtlNq0XPqJLhPX4MiqalANPPTBhCNyW8Iu2afLwb9
	 T98gZKlODeo+yOlbueohvMQ4BWaVh5py0n4NJRly2UpX2n9LoTmdOaiUYD2q79Odk+
	 0fUBBNFCTHbyCQE+OsjDS2JwqPTx4xsYWC+girTBiJlTY4eIA9grAPkUdPXwEPm93/
	 SQDZbHazos2SA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 28E4541BDE
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:45:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e+R1im6n;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F5Qmaj7d;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8LFWM1754867
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hGtCNZ4UOOWqf7HnzftzRzSNN1uF1K70PGOPcNQI8Xg=; b=e+R1im6nSBfgZvwo
	gFVO9HSnJq3nv+S72lUMy8HKZHl6LIpmNiS3YK9x8eFPmm1MJ2W0Fv6RoPVVrxAh
	7RT4fNUiGl2xJpc4heOb7+hGfux8kP9wb5/q05Zy6p6+RE2UYq49BNL4vMfENtQi
	xm5Ml6CNaaDiPYG6kaSGYOnF41HtTcCk32wBBW845ynHwqEXPa08SmnbpJ2+qReo
	BTChexx0V4Qf6ysLW+b7xzgw+YH2YnpcCNf+iy+mCcoQXEsHQLj678cYfA/YPk7L
	AEDBDpIVh3S+5gjGGI5aWKOWDSUfbOReAlbfRtwB1YaMS4PIOafFNGM3U8jWZXQj
	8hVJiQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j71267n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:45:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a7fa5e0442so2383196a91.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791798317; x=1792403117; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hGtCNZ4UOOWqf7HnzftzRzSNN1uF1K70PGOPcNQI8Xg=;
        b=F5Qmaj7dDjdUfcgWhx2ZbWSIn3kssUj4wsobXs9Vi8MJ0PpmAi5WXhH0XcghjkZUi3
         w6GfQIiaHIyd5i+v2EqgFzokkEjFtmRsfWQcFkItWllbuQKuPTUcrYE6vnG/noJay3zk
         GfxJCKKjqB97sUOA/kUlI4+r9OqybQJA0cfwsQeTW+ptV0SSC5aypPNFlUPkWJmQW0RT
         Fxg4pvBtT/5o6pOSELRGxA8lE274uw8rQ6R7BssxqLf0Qvdea/MJsqe/pJXYYAlG+RX2
         J2loHjq7e0HJGlGAxZ+h5GTj8EptpotmcTLsfb37PLqQCFH0dcSSowBWkjd0mOYog20M
         RnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798317; x=1792403117;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hGtCNZ4UOOWqf7HnzftzRzSNN1uF1K70PGOPcNQI8Xg=;
        b=LEXjdzKOxIvUXVWrVY7mLXVdiDtNjcmrva+OeNuVoUBkmuzw0UXt9AUgTjI8ROSIYf
         T6a5EBkoc2sfSZq1vCGfm8iKgdM3eTv5JrAQ8mFto4bs8tIV0QSb0CMdiuGpPwTgTAtJ
         TGxpEynTKgoqFSoJiF7p/dxop4Ug5poWQSfZoQd3e3C4f9QOQyA4KK6yMGsMpWkIezcw
         J6+kcpcCRE+Rt936TxArYB5P6bbMthfxotICNXqvR65tcLuR22DSjZXxlnvBb/UCvv6Z
         6fX+PLlkhg+lvAEfg6gB4HTO89Vqjx0X4yKYqH2Jlg5UzVo42/pYw8qx2KyGlfC7ac60
         bDjg==
X-Forwarded-Encrypted: i=1; AKwUvBz7sdF1RiQPmVVpyiXwoDaeA/BjWwmrnuNKW2rrmtIVt54mxSAF6vkBzXjthJ9x+vdUv/EVbl0=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYImzvubXvx0xBUchcTm9GDajswucosyoI4abyA9W+hrcSLxlnKM
	rPXDyakpDCVQ+gtmqQPzeIOUXrM3vhymB+KtNRnYZVRfQCaJrsTKsP5ZYlSOyiGxf2VVBmifuOC
	TAhmD1xVw/hgerru3bOOmdYAXXY9Nz3QzPDlUapKlqxcUClKXXTXskIGmXV6pns1vC1dVKceS
X-Gm-Gg: AYBFou0GnlO2eCOI02MesYJhzVoQ0+4+6eslGQPT3L4YwiZKZopXDpHcmWCfsx+8qF1
	d0zx1aVMCkv+OwSdnAjnr8yngMsyYB+ZqUTQN5n5HNQb8i7eWiHzXtF8VuCvPouffWfMOgP4WGm
	mJ9DwLxsuJkAlOv8ZyBoBKI2pmSflIk58/GpSBEplcimxTKkuMb1uc7FBHTXwQUAegigzY3q7sR
	prv6GoY7i+ujaDGOfYRWpoXZeqrRlNb9cOaVMi2dBt2RUlv2Z6qFaZZCqWf9RPJwZ/qAqi4YmG8
	dBzpzozS3MGyv/LfkWdHIrMxOWjDgax4VW3/n8iLwvkJLQYRp99Tufdt6kix5tCDTRBKjDpYUn5
	IdjgBckWsLGUC3qaSBiDOl0dc8Q1tpA==
X-Received: by 2002:a17:90b:5486:b0:39e:6a7f:1dcd with SMTP id 98e67ed59e1d1-3ab3ab1d56cmr8087593a91.41.1791798317380;
        Mon, 12 Oct 2026 02:45:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5486:b0:39e:6a7f:1dcd with SMTP id 98e67ed59e1d1-3ab3ab1d56cmr8087568a91.41.1791798316854;
        Mon, 12 Oct 2026 02:45:16 -0700 (PDT)
Received: from [192.168.29.10] ([49.37.155.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f8277bsm15560286a91.11.2026.10.12.02.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:45:16 -0700 (PDT)
Message-ID: <447d71bd-b9fe-44c5-b4ac-375661bbbd92@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 15:15:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tee: Export uuidv5 generation for TEE backends
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
 <20261006-qcom_uefisecapp_migrate_qcomtee-v4-4-bf1c8e2a64ab@oss.qualcomm.com>
 <4b5d8ee4-4927-4932-963c-19eb76a8f67d@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <4b5d8ee4-4927-4932-963c-19eb76a8f67d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfXyXk1EcQUOcue
 2O1yNLCZE+m9QJG9HPWPHpGw+XVOp7neWAmea6VKJKj5k9aMVG3qYyNQffpxzLNBZ6gPZXUoZ26
 OXX2f4Vl3lV6U6gXV+m2654yuScQOas=
X-Proofpoint-GUID: 0DcJEXD3fxWPxZssdp6zpGBN6uIIfoUm
X-Proofpoint-ORIG-GUID: 0DcJEXD3fxWPxZssdp6zpGBN6uIIfoUm
X-Authority-Analysis: v=2.4 cv=ePGGH3p1 c=1 sm=1 tr=0 ts=6accac2e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ivpbP8R7Mhpy7qfOLL/Q+g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=HvXYQvMWAyfQ06qojRcA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfX3YfrUdu3Fr1Z
 XOkfNmS/aHCFB69q3cbLLTnnUNnXsauick3tzq1uoM/2znxHbI7E2a0dkD62GjS4RPsy1HQ9sbV
 9/DIkR9WbzNt1r7RzhmsBHYZ6iexKshJvh9kmmR+K+guS+P14fV00j8vHh12zcpeW5Or+QD0Qto
 wsUo8OEABtIMmv0ulWhWDyF5PAiQnwywtISl/60pjtmwCJ/+fLTfxhf/NhwD7GgV1ZLBBiMHt4y
 xrPac05tLjQIsHA+s8WBaGdmPldBpPD96CZrg+KLPITzpIglc2Ol0piyaDDeZSGsmDKq8wMQ/ae
 pPc5LlLwAIsm+nZdb7Qj21vW6crvI3oz6tB/xAINuXw7bKhjv4fi1jIFwq2E/cRBnAbRxtuGS3k
 HZZ1o9ZGZfdvMyfL+oxskvK3tA/49/CGn0zY8LWDhCTvu2yBznbuxmQRs99JwVnmwdkLl9foO8k
 vMuwFgNpBqtM3hsUUpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120038
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.216.69:received,49.37.155.134:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 28E4541BDE
X-Spamd-Bar: ------
Message-ID-Hash: SYJFVGOO45DV3RJOTKH4P7G3555ETJAL
X-Message-ID-Hash: SYJFVGOO45DV3RJOTKH4P7G3555ETJAL
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SYJFVGOO45DV3RJOTKH4P7G3555ETJAL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Amir,

On 09-10-2026 06:53 am, Amirreza Zarrabi wrote:
> 
> 
> On 10/6/2026 10:33 PM, Harshal Dev wrote:
>> Export the uuidv5() function defined in the TEE core to all TEE backends.
>> This enables the TEE backend drivers to generate a UUID for identifying
>> and registering their secure services on the TEE bus.
>>
>> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>>  drivers/tee/tee_core.c   |  9 +++++----
>>  include/linux/tee_core.h | 15 +++++++++++++++
>>  2 files changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index a03a3d645dd1..2cfd302d1393 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -135,7 +135,7 @@ static int tee_release(struct inode *inode, struct file *filp)
>>  }
>>  
>>  /**
>> - * uuid_v5() - Calculate UUIDv5
>> + * tee_generate_uuid_v5() - Calculate UUIDv5
>>   * @uuid: Resulting UUID
>>   * @ns: Name space ID for UUIDv5 function
>>   * @name: Name for UUIDv5 function
>> @@ -146,8 +146,8 @@ static int tee_release(struct inode *inode, struct file *filp)
>>   * This implements section (for SHA-1):
>>   * 4.3.  Algorithm for Creating a Name-Based UUID
>>   */
>> -static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>> -		    size_t size)
>> +void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>> +			  size_t size)
>>  {
>>  	unsigned char hash[SHA1_DIGEST_SIZE];
>>  	struct sha1_ctx ctx;
>> @@ -163,6 +163,7 @@ static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>>  	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
>>  	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
>>  }
>> +EXPORT_SYMBOL_GPL(tee_generate_uuid_v5);
>>  
>>  int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>>  				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
>> @@ -228,7 +229,7 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>>  		goto out_free_name;
>>  	}
>>  
>> -	uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
>> +	tee_generate_uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
>>  out_free_name:
>>  	kfree(name);
>>  
>> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>> index bcb5418d6fdc..a3f4f88b8423 100644
>> --- a/include/linux/tee_core.h
>> +++ b/include/linux/tee_core.h
>> @@ -272,6 +272,21 @@ void tee_device_set_dev_groups(struct tee_device *teedev,
>>  int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>>  				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
>>  
>> +/**
>> + * tee_generate_uuid_v5() - Calculate UUIDv5
>> + * @uuid: Resulting UUID
>> + * @ns: Name space ID for UUIDv5 function
>> + * @name: Name for UUIDv5 function
>> + * @size: Size of name
>> + *
>> + * UUIDv5 is specific in RFC 4122.
>> + *
>> + * This implements section (for SHA-1):
>> + * 4.3.  Algorithm for Creating a Name-Based UUID
>> + */
> 
> I think the functions in the header do not need to replicate the docs from c files.
> If you want you can remove it. Otherwise,
>

I can see that the exported function tee_session_calc_client_uuid() in the
.c file only provides the docs in the header file. Perhaps I can do the same
and remove the doc from the .c file and keep it here instead of replicating
it in both files. 
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>

Hope I can keep your tag with this. :)

Regards,
Harshal
 
> - Amir
> 
>> +void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>> +			  size_t size);
>> +
>>  /**
>>   * struct tee_shm_pool - shared memory pool
>>   * @ops:		operations
>>
> 

