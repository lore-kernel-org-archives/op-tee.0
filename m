Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9349C2A070
	for <op-tee@archiver.kernel.org>; Sun,  4 Jan 2026 22:43:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E408C4FF37
	for <op-tee@archiver.kernel.org>; Sun,  4 Jan 2026 22:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767566584;
	bh=Z766a5eKhtLpv6IfPQN7+0qKX1TYy4S4ZuAf+IF+n78=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0FaqrQHPkLaAT8Y4wdG+vKh9sPqt1iAJ9+Tjs/nyl0DPez5NahyXMwiNpqYo9qwZC
	 56yHm6L4+6eTUxTZB9KPRkOZpK/UBL7YLNCZYY2PHxqKTqxgZ5OaZbFRZikldgk4Ib
	 Xq1M9/muI6jHnCTTBygXrSysxVeu6wzIYsRyLd2hBddhogcgWyik67LHx2uZrpoF9V
	 YGCz+SSTmkklDR2eBV2lafaPRZUESRCrypzDFOm/z9LddwwzEfKsKungqr37xFcho3
	 UbuAxbaH0K2rDbZi8CrmUsUVkgM5F4DdbBjihd2FTSDGaxVgowUt3Fiolil0x6s5pe
	 enx0Re4E7HieA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BD25341A35
	for <op-tee@lists.trustedfirmware.org>; Sun,  4 Jan 2026 22:42:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jtF5udo2;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S8rsHfRG;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604K0Z4Q3480044
	for <op-tee@lists.trustedfirmware.org>; Sun, 4 Jan 2026 22:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O/7vNr+DsrMEaDFspG2Z8LOHW88kZTo5Sbi3yhf6BjA=; b=jtF5udo2icRVijyB
	loIP/l7ROdQFZsLu6mrl5mS4kr55HTiJZ0VqWrVCWo8eaT4ONlymGWZTKqhdodIQ
	kFhbilShCgKz8zt/ViPGmnczpzJZ/NI0X/1Yx0AwQ1BQ5GR7qqwY3sKGZXIJDKg0
	HEPNcpupjK80eTD1BPvTCoBH0ug7mtqgkBzmKAM//r2xAROjoBtHTGvZ/Wd7Catx
	YXY+4fhuTjmzhRZMhzg8uelXlCT5l4+lbQD/XdLE7q4jTDSd7TJOQ4tUGYNlv8L0
	1G4/YrJWXz3wSj7GSDs8iUvN96ogLVbO5fvIDQt0h2C5ontNkbaMc+xXY8pg4QRA
	RovmWw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bf577sw0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sun, 04 Jan 2026 22:42:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so25289359b3a.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 04 Jan 2026 14:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767566563; x=1768171363; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/7vNr+DsrMEaDFspG2Z8LOHW88kZTo5Sbi3yhf6BjA=;
        b=S8rsHfRGxmo6nqzBqhl+DL7z8U3fiaL0lbmS1qN/1S7/RAlssyMaDIByQEsgBU/nH9
         PrsLmMuzZTopnvVpRGnvKUUoPZayjU9kFRPhKgcnehditLh3oVm8k4HbM8cx8MC7B4R+
         bcexIG3Eqf3E17mcNTSvjHKXoT2YAjJveg19tfFbi0kQ05QTvG88xX7fxFrZpAYpTVIS
         v0cvA3FsoI46m6kwxQ2RgBfcm/gWSLUzvRaYhLf4+B4eNxEnFcpxBlw5OBWd2GlYcCY+
         hHw6Bp9AYRPsJshWWtVorKSKgVNcsY1DFtAJWsko+K7tUOGcIx9YNEhHxrl+vW+LWyOg
         OLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767566563; x=1768171363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/7vNr+DsrMEaDFspG2Z8LOHW88kZTo5Sbi3yhf6BjA=;
        b=xJNNitXeCck+PJY0eFwDXw7tN43XVYz2oH3iTiwbXX5jlQxc+NCTulAVxTXLhZYWfL
         cbdyxN4Zivahs+fXRjX5XIw0TmPh8LwS9UlhksKPzPk3bJTed1POSMPJlPOfSFH1EiZs
         D91GTFvQUEg1r0j96oUDk5aA8YCaUWg7NuA8Xi5adjNH/evbqSn5u2wXlRrkw1PH9/Ix
         EUGVVHn1txNF9vVXgTpxDiGjLP7H6h9fAsFRys07dhNzxO+VM/yuUaq5j+zXWAemI3p/
         doySOe1527NtQVcaKMKcBV9+0O4+qC1D4VB37CXPUYDzeGidVsCBIxPry9r6GN3zXYEr
         6uPA==
X-Forwarded-Encrypted: i=1; AJvYcCUerxLRuhAZg6qCJUMsrjlFaTg9huoeB90jkGGQA4tpP/csl0FBxXtN7MTT8outZUXf1Idem1E=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyOFGQ2SzS8Bf0TuxNFcfXfEUST3/6ZluiDIhw8W592ZwM8hv/s
	latbVvwacQjYq+RO0kNUPpn3cosZdl1AP3tiCeypxCpMFPd80SKScS+HRJKFliybfiGd1LQuneg
	T1sRjF+RyirCUCasbOs5GS/TLBFaSI0GHWflPfTh5cSjr46oAVNg4B19oA4Gip3Ac4YrzEEs=
X-Gm-Gg: AY/fxX5bPOIHnhtyVf7kZ7/hloG1KUlHnYSbvSBbGEL4cUUMK/XnxVohFbIi/HXHDZh
	A3nUfWSZDTvMXhiWR+QLltG3z3XX9twjUvUDbWGe9nberyLEsGRnO5uJsdEi1bo2JMAtIXqN/6e
	Ww+y2aAisaqfgN9X7RLKZDmWTvK/mudqZwHrcU7MekWiSM87oGFhkLAK91zdWNAS0MYaMsYaOrK
	CWe3ISOuiATKGbdV3l2nwLgHPXNUQ570o0qcGG6BrJEN1Yz6BaCj5msAU7QKaT8D7AECEpry63V
	9TcjzKNG2j7zfP1ZEEJDQstbt5EjmIEyyakGdrBOEhZAliylBzrm14+mLRYcJ2dq5eEwalaldb9
	4ugvtCIdBsVxuJ4tapRBBtnSw8iO1rp3hFadFex6kcx6fFVf6Ev8NgE67J3h4vSu3tyQHrUV6IX
	USLabrUn0=
X-Received: by 2002:a05:6a00:414b:b0:7e8:4471:ae5a with SMTP id d2e1a72fcca58-7ff67456b8fmr45161609b3a.38.1767566563092;
        Sun, 04 Jan 2026 14:42:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDuO73OCc1uAmvVfcN/wqa6d0iKBoYARuBWGAYA0w4rRlXhl21neol3T/X6jIAjYp7WFJBEQ==
X-Received: by 2002:a05:6a00:414b:b0:7e8:4471:ae5a with SMTP id d2e1a72fcca58-7ff67456b8fmr45161592b3a.38.1767566562587;
        Sun, 04 Jan 2026 14:42:42 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b22536esm45620684b3a.23.2026.01.04.14.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 14:42:42 -0800 (PST)
Message-ID: <ebaf9e48-07c6-4b00-b773-312e0c9a8e21@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 09:42:37 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: k0s1XK2Lb7Iy9RdKlx_RKuNWMzjx65zU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDIwOCBTYWx0ZWRfX0L5FHyZyZjSo
 /q4qjGehF6wkzjB75248hpj3MRPfFF6yNg2hH/Y7SMR7WSeIDz8cz/FONBJoWb8ihkjzHRAHCJc
 IgYSPRyTLwI/ZNrBcWFBQwa+EHtWzlFSI2feb/gmTljlrIA1zJxUt/SrDKnmnhHeMAuN3Y0HaW8
 7ku9A3EuXzexKBIOopwi4xW+HwM0dWQ28EjzK9v0HPt1UFQ2KR90GtsUAkOcX3V3G6Lv6TV3s81
 nY6nO3H2WVbWQhyX5M9zlPZ9jovhx2nbYR+3WafDbU0alCLhX5caG3m08YyIzQbLFlrgEkEUb72
 4UNXDycIGeA+8dfFpGixOsjntaiWALIABozFnQ4b6VHL2LyAC0IU5AKYBT1lG0nU9ph5YaHDqCl
 io32EAAtjm9b+02qi958j6G/Ep5xyPrNDVh0fhe7Gyu5mYl28WyD9R3OA0mNNXFVtLaOrEITrSe
 Oc56PNhRU8Rw3Od5EJg==
X-Proofpoint-GUID: k0s1XK2Lb7Iy9RdKlx_RKuNWMzjx65zU
X-Authority-Analysis: v=2.4 cv=d+z4CBjE c=1 sm=1 tr=0 ts=695aece4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=f4zK_zY1VO43RE-C1HAA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_06,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601040208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BD25341A35
X-Spamd-Bar: ----
Message-ID-Hash: U5VHHHAPWAWQBR4OKAHSTIPUXWE6XWQN
X-Message-ID-Hash: U5VHHHAPWAWQBR4OKAHSTIPUXWE6XWQN
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U5VHHHAPWAWQBR4OKAHSTIPUXWE6XWQN/>
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
>  drivers/tee/qcomtee/call.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

- Amir

> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index 65f9140d4e1f..8f8830f0df26 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -395,9 +395,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  				 struct tee_ioctl_object_invoke_arg *arg,
>  				 struct tee_param *params)
>  {
> -	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
>  	struct qcomtee_context_data *ctxdata = ctx->data;
> -	struct qcomtee_arg *u __free(kfree) = NULL;
>  	struct qcomtee_object *object;
>  	int i, ret, result;
>  
> @@ -412,12 +410,14 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  	}
>  
>  	/* Otherwise, invoke a QTEE object: */
> -	oic = qcomtee_object_invoke_ctx_alloc(ctx);
> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
> +		qcomtee_object_invoke_ctx_alloc(ctx);
>  	if (!oic)
>  		return -ENOMEM;
>  
>  	/* +1 for ending QCOMTEE_ARG_TYPE_INV. */
> -	u = kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
> +	struct qcomtee_arg *u __free(kfree) = kcalloc(arg->num_params + 1, sizeof(*u),
> +						      GFP_KERNEL);
>  	if (!u)
>  		return -ENOMEM;
>  
> @@ -562,9 +562,8 @@ static int qcomtee_supp_send(struct tee_context *ctx, u32 errno, u32 num_params,
>  
>  static int qcomtee_open(struct tee_context *ctx)
>  {
> -	struct qcomtee_context_data *ctxdata __free(kfree) = NULL;
> -
> -	ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
> +	struct qcomtee_context_data *ctxdata __free(kfree) = kzalloc(sizeof(*ctxdata),
> +								     GFP_KERNEL);
>  	if (!ctxdata)
>  		return -ENOMEM;
>  
> @@ -645,12 +644,12 @@ static void qcomtee_get_version(struct tee_device *teedev,
>  static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  					  u32 *version)
>  {
> -	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
>  	struct qcomtee_object *client_env, *service;
>  	struct qcomtee_arg u[3] = { 0 };
>  	int result;
>  
> -	oic = qcomtee_object_invoke_ctx_alloc(ctx);
> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
> +		qcomtee_object_invoke_ctx_alloc(ctx);
>  	if (!oic)
>  		return;
>  

