Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC341C2A070
	for <op-tee@archiver.kernel.org>; Sun,  4 Jan 2026 22:49:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 254934FF3E
	for <op-tee@archiver.kernel.org>; Sun,  4 Jan 2026 22:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767566959;
	bh=zE1vpm2UBtKXFSIWtO3EvHyFceAauG46kIibQY7dsZY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=kKHX2x55bX8RduEQ9KfimWuVsauVt6CFw0rqqLLrpdnp37d9MSZJ7OT01TYq6uCy1
	 4omuW/mEY70o4NWMu04xhKnnEYNqcsnwzIL4qNE9DwjATO/Cl/r2qm6wtAjSATN+6r
	 ZI8rlpWVpB0eXxerohaftZQYP19Rfoz5FiNX6ODHHSY2bllJPSK1//Oiji/dLOL62M
	 phdPYi33pIVIQo2iFnVeJUDI6iNPtPdfQ7OtTEmzWeU6EInACPMQDsciyakrzUA021
	 4ajymIlszXrkkfUTk2p0dn+Nqay7+ainYo8rFy2HypYwGJyHQT8/X10WDrWJAl5g7f
	 8Q8qfcbgKfyzQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 17BFC418F9
	for <op-tee@lists.trustedfirmware.org>; Sun,  4 Jan 2026 22:49:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pqKYHZop;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HPAwVdob;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604MmxWO1112126;
	Sun, 4 Jan 2026 22:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LaEu4i9Ss5ICFhfsy7EyyVcKTEq3KRBwxvKW89uDbsE=; b=pqKYHZopAFFSui1V
	d/GjmjbUoHlVsx3bpB0SZAHecUCxJLcfQUM0S7fvcbo5KVoctqOydCxwgiKYywau
	UIVAS/SagJvSYnz+qusAqjlOzP4WgviHdw7La58oznUsnmxsufE+9diMjFZ0CWSK
	64nLa1/CMdioSBTDVpYYYHr9XASdk9iGpTdLaa2+S1OEBmQLkxO/rwMc9LAAo/PL
	nZkskzbaINViR4DoEtra3rIhjuOdXvnp+P8kkAaVgjCzY5UfW5sYrUwgzLznBt9H
	S6WjeKETfhyMgmUPEwEPDisXU6j36eM1pZuQcry88h46A6rpR1sHLw7U9+5M4rWk
	+ploEQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bev9hagxu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sun, 04 Jan 2026 22:48:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so14913719b3a.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 04 Jan 2026 14:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767566938; x=1768171738; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LaEu4i9Ss5ICFhfsy7EyyVcKTEq3KRBwxvKW89uDbsE=;
        b=HPAwVdobSxqhbjaOftrk2WWJcfYDY1XLDy3vs/H6FpHBEeHdqOJy5NVRJOPVDssODw
         osdfvkL5LkyE+ul1e99AvwDJjTpDDUkhdK2UroCa3RiRQRaKRomImbtajnWPWASFZzNX
         zFWoYnkMAIt/Ll7pp+pLp/09tTSee5MJkUa9cnRxbXZCKKdUFne+AC6tPmXlZtJL4Krw
         80FIQw1+BW/3hqk6KEpWFISabxOkjNAVCIgwUzJGN6wbiSDZc/3JGGjsbAyismZXD3Eb
         1I12jHw6aYoiF3a2VQbY7KlroQynRHEeQ0XdDR2gCm9w+MsJpvpbQsi9dHK12Te9Yytu
         3ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767566938; x=1768171738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaEu4i9Ss5ICFhfsy7EyyVcKTEq3KRBwxvKW89uDbsE=;
        b=hgdXXvgHqG+ku95B6F+JF1pqTp/ZG6B/90knm8h+ns7bMq5DtyEnP45RmlqT+fUdVz
         +q01uZ6/7+Dg7KQkq99sooMac9rWmnjDn56/OxnqOc5B1Zq1W93uvGbtNBWKMBGOO1KE
         anhjb28o27VcAmcLrRTAP5z8d7GIL0H8bovcp9YZAs4ceoQkHOAVpMC248CL+I2xdB4x
         sgYcnjR2GKgJw0TvsTcUok+FqVmnUJ25zR2rOLtTMdCaHAu92lREyxeJZoWpbetlv2WA
         cE037/hRs3iPU6IZ51J/mCwpVSPP1F+Qadw5CIbsb6s3lrBnNLGG/QxGfUOUtxvSQu9c
         gPtw==
X-Forwarded-Encrypted: i=1; AJvYcCXFBCnL3kj/w58cfDffPsN3EpoVh33yUwopTYBiOYwMXyHHo4GOQgoiWFUNkeAAyXZzwiYF/UY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywey+ngl0Qy2yxZ5gFRYiA/cS7LKcVl321QFFl4o/96uclQnDRs
	8Y/myUQMWmMiFszclLUsXeKzsvlb7BDdZRfnUX2CBTZ272IxT1EkH5A1DzealNFDsyfe48C8kBA
	iidT20HuQcbzdzguMPWQVViSVW+i3+JeGESsijJBFzpU1/1Q/1NhTp7d0vNn+9UMMSaDZt3Y=
X-Gm-Gg: AY/fxX7b6J/RVi6Mz46L2WL48/JwiMwJov3hNwMd3J6KoqMroqjNzvi2R7E0aKnOxvj
	DlLi6V4K8wIMHZ3ShHQQ1xtLpzRu8nd8fn7SkXTK5OOdAEniaV+HGaoe8tu1IGmZ6FjWGFxmAC8
	+pNkTMDq/9CvufHftNuJgWhY0FrZR7vmInB8U6KZBgyVSI+5AqIJ9Dq4rZOciMrqt5PoWo+ZX19
	PGioE65j7RxkaP1N2BILAp8IZHzhPGHXj6Lfu1xmg2USHOrW3kz+R21ZgCo7ZpMV09h47Iow/ts
	x0Br07hIiLSsTXVXLhbVFYvGhDgunHCVlQxwPtdsRw8biJlz2pLlgWFqP6bJ9XaIvxtICfRVZY/
	TDIUtwUITM9xwwsyb8lGusYWSleumHNL/Yj+lODB4wB7sgegiEUwKNoLz6iPMm1TC85ySy2hZVp
	CaBpOC0vM=
X-Received: by 2002:a05:6a00:a885:b0:7f7:532a:e44b with SMTP id d2e1a72fcca58-7ff65f78a13mr39009058b3a.41.1767566938305;
        Sun, 04 Jan 2026 14:48:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt476BmHGHKB7jNiFCnddknZmEegIAAcs50j2xzI/2wAdhXcWoaTsug++HzAXl9e3RTethqg==
X-Received: by 2002:a05:6a00:a885:b0:7f7:532a:e44b with SMTP id d2e1a72fcca58-7ff65f78a13mr39009049b3a.41.1767566937789;
        Sun, 04 Jan 2026 14:48:57 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f300sm46136305b3a.54.2026.01.04.14.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 14:48:57 -0800 (PST)
Message-ID: <d840d693-b23d-46e2-8996-b59b5e556cf6@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 09:48:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tee: qcomtee: mem: Fix confusing cleanup.h syntax
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20251208020844.5310-5-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251208020844.5310-5-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDIwOSBTYWx0ZWRfX+iBsmULgzjVH
 qfeQCk+oxinGIur/chjWCrysAyDwkEBWk8xPACwFc7V+m5MqeLhYFNz4caabwjDWAIqiZrp+TNk
 r1df8Lqw7vMOoXt68c4HqJo2CzpFHMkL2Cdse1jocsSiTQKG3p0I29QJ/bRYhoMOA6shGekEja+
 Sv8mRH4jadVdb2hmDVoIH3se8PdaVjUoRQg/6BtegZ+45FAVCnR7F53zg5JOjtwPKUHb4EA9wHU
 4zSu4FLPzzxL55PkPRmiyX6OGcNn71NViZT3xr1UFd8RbfqcwtDD3DL41e2QH5Mu4tfC5M6ZByB
 nEAcvhnwqqOGwlw3t59qnEOMu+jmM0cIj63lc8G88copTFKKsW5M9p4mZqbrRpfAVG6PyHLCX6y
 /ipfP1sknE3sE9hHQam4UD9RpbywtB7NDdGtFnbbr6rseOaS4++PLN+/o2qiVz32eQH2KvYtT/Y
 nYiwYkyp6E35unhZd/w==
X-Proofpoint-GUID: DO-pFWItuJUpxi1oMEse_FkivilaKpHd
X-Authority-Analysis: v=2.4 cv=RrbI7SmK c=1 sm=1 tr=0 ts=695aee5b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FIGAOsSgX-vrdh4HXBUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: DO-pFWItuJUpxi1oMEse_FkivilaKpHd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_06,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601040209
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.210.199:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 17BFC418F9
X-Spamd-Bar: ------
Message-ID-Hash: YEFXSWB6BR32JT7IDDPPCX524FJFWXAG
X-Message-ID-Hash: YEFXSWB6BR32JT7IDDPPCX524FJFWXAG
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YEFXSWB6BR32JT7IDDPPCX524FJFWXAG/>
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
>  drivers/tee/qcomtee/mem_obj.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/mem_obj.c b/drivers/tee/qcomtee/mem_obj.c
> index 228a3e30a31b..a16f8fc39b8d 100644
> --- a/drivers/tee/qcomtee/mem_obj.c
> +++ b/drivers/tee/qcomtee/mem_obj.c
> @@ -88,11 +88,11 @@ int qcomtee_memobj_param_to_object(struct qcomtee_object **object,
>  				   struct tee_param *param,
>  				   struct tee_context *ctx)
>  {
> -	struct qcomtee_mem_object *mem_object __free(kfree) = NULL;
>  	struct tee_shm *shm;
>  	int err;
>  
> -	mem_object = kzalloc(sizeof(*mem_object), GFP_KERNEL);
> +	struct qcomtee_mem_object *mem_object __free(kfree) = kzalloc(sizeof(*mem_object),
> +								      GFP_KERNEL);
>  	if (!mem_object)
>  		return -ENOMEM;
>  

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

- Amir

