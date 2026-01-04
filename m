Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C973C2A070
	for <op-tee@archiver.kernel.org>; Sun,  4 Jan 2026 22:50:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 529F74FF31
	for <op-tee@archiver.kernel.org>; Sun,  4 Jan 2026 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767567047;
	bh=BUnBtuxk0eww1XMZ3mAG6YmWxZYPpuxsb7QXsefg4AE=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=iRSH5KW/lcouzM5wMq0A9Zsf6jYsAxz0URnLsX6cI5ACAddegubjqqvEzvbDah9hj
	 qd/LYcy78eFQlx1NEIHvavUKux52mSGj/OleSzpf1Ilo2/Vq2KlsFTHqU+JKTRaDgI
	 8VdhONuxI4sg7zRxEHFhdEIHjaLncI6dhl69Z4onQXQJonF2FyWd7S9StcKKAfVqGP
	 ldOZ9+Vm/o0yxCdLSzKoqeuWoaYnb1s2Ecl9phL5PPr310I9SN0OZBBHa8ySmIl5/7
	 JJBvZO9LfSF8rIz8nv4XT3xr/e4w5UqhRF+mGARsWncx8KqlYOYEe2Dja5ZUIADMn4
	 T1QamSHXBzD7Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 96E4F418F9
	for <op-tee@lists.trustedfirmware.org>; Sun,  4 Jan 2026 22:50:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kD+D91cN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=InC4hJPW;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604Mfk9j3847348
	for <op-tee@lists.trustedfirmware.org>; Sun, 4 Jan 2026 22:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z4OECOH/li4HpE49npbmoa6u/pIY/YVgufugJfqG2z8=; b=kD+D91cN7PlcIJIv
	C57BwI35lnkMtfZW5hRPub/pdbtRHDaIcQRMkjpVYBb7/w9orfJXQJ1H+hq8i6lg
	USbD7EODB7of1qHzJJomOw2wmYmvNh4T+CU92tVqIN9s+1xJCifXKixiFWMaWkKB
	uMV8mRu0etU+tKSIwkz2wg8oBssJN2sRWMrfl37/dKjnjYk7iicSlxjdAtMWl1pM
	15Wgo6kNo9+tTmCaKvJBBZQman92I5ZOMDgJ6IeFYojBKX+H35RPoHQhOAn+W/fe
	ZsdeFd2J208zlb9HJzSYHjHSjOOCraXTd/EeYy5SHipacnONlH4Mo+jntGOFuZQx
	1G7fAg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bfyx0g2se-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sun, 04 Jan 2026 22:50:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a09845b7faso206449535ad.3
        for <op-tee@lists.trustedfirmware.org>; Sun, 04 Jan 2026 14:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767567028; x=1768171828; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4OECOH/li4HpE49npbmoa6u/pIY/YVgufugJfqG2z8=;
        b=InC4hJPWmvccIvXWx8IeVeBNmvLjV0ekYtiAjHCmH+R+SgJ5dGXJS3Uus7fC8Jg8Rd
         nrNQLTKmEfBvcqat4fXWPe/8dIk5a1tnwO3iA+0F6dUIxiZNztpcUpO2/Hi6xyrfE3Jz
         +S1JnLqmvnLIQEwjdkyN13sFxL4CbwoMSXzEKigqsoXuRPgh6V+d/hVJbTJn5awSphgZ
         fqacssMimQ6mCOEWd8zAvzDHYRyLJUAqLknYj5vg4NGqompwXAwSx9Nnq7bW4BPTj2Uu
         bF9SCFavCNi2xdMwkD9mfN/Lj11zeprZPoPwnYkz7cisF+LhuYtlwFe5HwwPklQgEEce
         JijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767567028; x=1768171828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4OECOH/li4HpE49npbmoa6u/pIY/YVgufugJfqG2z8=;
        b=unRFZdxDAXwu2sHzfF/YfDps6IOCS88zC/7PVmpEvrpEO4NtApvUs4OfxYWuZ/VHaD
         N7bsRPZ6sCD7oIzVZwS1eRXZzl2LJqOp2U4Gv3BP9Y6zNSNapz6VZWop+jR0RNUrY7pr
         ohXwmnkVWlLXwKcwxWtojpPhIrtTvBjZ9iaIKWZ0N4sNiNWH3orDX5tw08BDmfd91ck/
         oxllNHyA8JXCdMfGi2dG8Qx5sgjBX88kg3ogqQCYkelH2ow5tvXq04krxqB2OItWwNli
         wEIYxe3qvopxD2sIC1e2qAjEMSASKx+33CgZSyRZT4HlLSIcy9tOZ5ksMJ55qAYLvGHU
         Argg==
X-Forwarded-Encrypted: i=1; AJvYcCVg3oQFH9wgAkJavexK9Y2sKLbBmbE89ah65p1W7EhtziQ5rwgUJOw6pvJKchurN7jU2G9SBEM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzIISv7uQl3oLjKX8tLiCV6tRiM5HLEl6fq2+Mh2eDwavglKHqP
	Q8iMu5DH+uLuyu+kFma5aeZ/PYQZJafNSKCjsQbkB3zTaP106ki2fVCgKfdM4rJ39Cu8aewINPe
	0XkzoZ/fNUnHYA4mq1jhlgUqggVGcq8tDEO6VLTNy5BZUxYLPATBkzfhmObmVhhakfgNUYx0=
X-Gm-Gg: AY/fxX6Wv8E/c6rOYCrvxqFqGEfPxT4P83YU4Seif2IQX0pI56E9q+3sBKUkzL2g96n
	IH5RJSr/4hvQim8lnOmngG21zquxFbqjS64+ugqqUoEykXP8Ka51tV4Rvi3TZEm9PTZvAT/SAEB
	NC7nd7Fx9cQVN/8GWOJXPUhTsdcHm0dHWohRDXNzhfjsKfn5TDE18ZYoH4pjYeVZLcU3kCaO171
	OPktmYCUX9II0/HWKD7I7vXBz8foJ3W0d8tw9Z+H3g63lVI8BbZd/WFkJHmdaltW1YXYeCwRAa8
	HZuVJwODjzfrmB7poLViZ0yXuUdIDrEPjpgcLfjJlC9nCHFI4ITSxCZO4gaI4mjJnXfsBSmKDz5
	WzmAk876Uc62fywV2np9062MnWlfcAw2ciRoAIn8I8icR5TTx5SgI/mRgwH8MJlBqsAYl3EDuJG
	5ztTWogCI=
X-Received: by 2002:a17:903:41cd:b0:298:55c8:eb8d with SMTP id d9443c01a7336-2a2f272bd8fmr421732175ad.35.1767567028064;
        Sun, 04 Jan 2026 14:50:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSpjXMvZibipryUoqrlDqr7k2nu+DSzDZ8V71fOSDOZKY0FvdhnKHBf75BqgIzwl7VSPS6bQ==
X-Received: by 2002:a17:903:41cd:b0:298:55c8:eb8d with SMTP id d9443c01a7336-2a2f272bd8fmr421732095ad.35.1767567027574;
        Sun, 04 Jan 2026 14:50:27 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82762sm422934305ad.27.2026.01.04.14.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 14:50:27 -0800 (PST)
Message-ID: <eca4b7b7-d4de-4209-9965-4a8ce027caee@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 09:50:23 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tee: qcomtee: user: Fix confusing cleanup.h syntax
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20251208020844.5310-6-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251208020844.5310-6-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZYFJbrl c=1 sm=1 tr=0 ts=695aeeb5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XSG46yrzQr2AIDBsqHYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDIwOSBTYWx0ZWRfX6Yknzc+H3PJV
 8RYLmQBSq/OJYI6DhH6Z2Y060VD5m6kOtYFgPwcDWUGt5ryHpueYjbNU61Mcum3FAbq+6/n0cLS
 DoqyPVaS3OCRW9c3WS2P1UGIXY7YbLzLwQqRc/yYRMf1eUm87Yowxce+3xO8oQmHsz6V3Ss/Zpx
 VwR5VY2pUF6dGaDicIXOHO993rQdxNEAF9igAO3tfskGo6ZLiE+rOX6RxGeGk+vVBd21Qu5egB/
 IoqV/G2wJozEzpqd9sbA8lc+reRELURFu5CfOqkcWYz//ZdCF212iUGmfi8ReLjx13Ob56+Umqc
 486c2FIPCZ0svyaN2CfnR8Qzm9C8dy/525iBQHQAEkr0aZ+wmf2dLMeZ8CNZRoSt3z0MIEAWdG1
 E9ZRqiOH9vxBLceSGaR3KBogLF1qnWMkHMxcYGi/lI4Dusehf4fXrrTcR62TMNWFI14DTzDOu4W
 AfozazIyyNfVyoCFHxg==
X-Proofpoint-GUID: A21Ek2s_6o2L808TRHyJn7pKw8Sf9bA1
X-Proofpoint-ORIG-GUID: A21Ek2s_6o2L808TRHyJn7pKw8Sf9bA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_06,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601040209
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[1.41.240.65:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 96E4F418F9
X-Spamd-Bar: ------
Message-ID-Hash: FMZAHH2J5ELAS4MAC25CCG2EHC2BRTOB
X-Message-ID-Hash: FMZAHH2J5ELAS4MAC25CCG2EHC2BRTOB
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FMZAHH2J5ELAS4MAC25CCG2EHC2BRTOB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 12/8/2025 1:08 PM, Krzysztof Kozlowski wrote:
> Initializing automatic __free variables to NULL without need (e.g.
> branches with different allocations), followed by actual allocation is
> in contrary to explicit coding rules guiding cleanup.h:
> 
> "Given that the "__free(...) = NULL" pattern for variables defined at
> the top of the function poses this potential interdependency problem the
> recommendation is to always define and assign variables in one statement
> and not group variable definitions at the top of the function when
> __free() is used."
> 
> Code does not have a bug, but is less readable and uses discouraged
> coding practice, so fix that by moving declaration to the place of
> assignment.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/user_obj.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/user_obj.c b/drivers/tee/qcomtee/user_obj.c
> index 0139905f2684..6aa3aefd67f0 100644
> --- a/drivers/tee/qcomtee/user_obj.c
> +++ b/drivers/tee/qcomtee/user_obj.c
> @@ -228,10 +228,10 @@ static int qcomtee_user_object_dispatch(struct qcomtee_object_invoke_ctx *oic,
>  {
>  	struct qcomtee_user_object *uo = to_qcomtee_user_object(object);
>  	struct qcomtee_context_data *ctxdata = uo->ctx->data;
> -	struct qcomtee_ureq *ureq __free(kfree) = NULL;
>  	int errno;
>  
> -	ureq = kzalloc(sizeof(*ureq), GFP_KERNEL);
> +	struct qcomtee_ureq *ureq __free(kfree) = kzalloc(sizeof(*ureq),
> +							  GFP_KERNEL);
>  	if (!ureq)
>  		return -ENOMEM;
>  
> @@ -367,10 +367,10 @@ int qcomtee_user_param_to_object(struct qcomtee_object **object,
>  				 struct tee_param *param,
>  				 struct tee_context *ctx)
>  {
> -	struct qcomtee_user_object *user_object __free(kfree) = NULL;
>  	int err;
>  
> -	user_object = kzalloc(sizeof(*user_object), GFP_KERNEL);
> +	struct qcomtee_user_object *user_object __free(kfree) =
> +		kzalloc(sizeof(*user_object), GFP_KERNEL);
>  	if (!user_object)
>  		return -ENOMEM;
>  

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

- Amir

