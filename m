Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1E0C55184
	for <op-tee@archiver.kernel.org>; Tue,  4 Aug 2026 03:49:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 26F2445044
	for <op-tee@archiver.kernel.org>; Tue,  4 Aug 2026 03:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785815364;
	bh=uRldD9+3oyDXVJuPrrx5fy1JmUONml1QdQ/guV8X7qc=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=LBgGMDF2y8vH52Hsi0cTiALML9SkCHBItnoGi5KgXT9m6pleauWDJ3yau72trjH6d
	 hLL9GG8QrSwjFVy2V2pde0uIY8tbyDyiYLrKcRsdtqVRTc4vRNMl54fjI7FH7rBw+3
	 FHSs2xk3IEh4OmXeMgLG7vOiLFerlAMtqzJs1fLEFk0iLfN4vUdma+B/RlU93Cl+PQ
	 B4V5KfPo6xzM3MWwSEGnUdAw1NBaJCeS0Q/dIdNBf/deobLiuaIPhrckZmU/w2XOzZ
	 T9wN66B0uwoxkfnAXLV77wMEA+EfdQvbNUDru4xA1RdJnb0rLvTkowo8ZU64/VBTiQ
	 rGsJ3cD4N7gKQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BD25743EFE
	for <op-tee@lists.trustedfirmware.org>; Tue,  4 Aug 2026 03:49:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VSazBtjs;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q5UBVCL6;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674177MN3457125
	for <op-tee@lists.trustedfirmware.org>; Tue, 4 Aug 2026 03:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XheG/6rV2f0cZ6qhmU4lso6FOAuMcYX8VwnAe6UhMAM=; b=VSazBtjs/4QVpwCD
	ZNTPOi2fm0tlMTcXDdhZ5F+VdTLCnv52Ty3cbs+EmVYThOKDEukk4Jdl+JdMWSBO
	/QWvgEUEvY/1l7/1hAV5mUN4/FihARS7JGd+JQ2XMB09oZUf/rDIbVxblvLB3oP7
	syffj2GT9FMqJzBYDlyXS9YxR0N+/skJ8/w7xHKGQrljNGN71K79EmC5uic8dYk6
	95LhwUfg4AXRIqxDjg0hW8PuVyJqL54uYAfTZJR5imxRJF9ujXs9fBP0XRshK62/
	ieleElmM0OWmHtY8RGBGovqQ7U9O2eoY5XCC56GPqdomL4CIjVPDis8tvFw8447L
	xFZDSQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftwhdtsu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 04 Aug 2026 03:49:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfa4e4684bso113108465ad.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 03 Aug 2026 20:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785815350; x=1786420150; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XheG/6rV2f0cZ6qhmU4lso6FOAuMcYX8VwnAe6UhMAM=;
        b=Q5UBVCL6PhDez8ItqTtk71cwjjW3QN9OWMXb11nptC7KmjGYnWWcSsprMWXTz9rXdO
         CTkExrVJCG7dEe+eTTz+C3J+smgITNlamPxlj/RgMILNBtRX6fz9aeOtHV5kaDLUzg33
         P2G1txLCJ7VA8PaAo0OBQZVs0oTvHpuOYTP352ImSeeVso/codu6kLr3momH/i936n1z
         vPpDj512jJp1i181p1DvZ6qfsOU7VmofxLyAxoHh7sNkubrpUzEVwyw9R8uFXTNohE/Y
         6G0ptK1ebZJDW5+rK7WZYvj7uJEtTC9GBqudN/DiQt2zQhO/sBdaeaRq0vAjFZdEMhLT
         kVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785815350; x=1786420150;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XheG/6rV2f0cZ6qhmU4lso6FOAuMcYX8VwnAe6UhMAM=;
        b=VivdsCuJc5fOwrPWv+P7qRuQAgF4ohdJzoiThqbykzdEgz0nRMAq8s9U9F1kf1G+JO
         VmbZJAJjZRekKH2C/jWAx28guOQzfJ+KCLcpgTTWv4hWy6tZk8u+ZDRpFBfEsdF+SxzK
         I3krngNEFtHCv3V2AxVhSYFxzSL8uqaZfwIetzm8JQjMiG3zveS1zeT1LG6uNxNdygU+
         mXwpfL72QVl/UdvJIJxQk2sZOb466gQI2SAbycMzQgFVobJIca9BEsGo/q3NiEre3RFh
         UWxkGKYZVWrkPZRl2n1orYzQGqTa8iqKZro+oCHK7R8Xl+Sk3ji2aGtN0o6Y/NSI+6Hf
         mSQg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3voJLNdZ21a8W7HuWwFfMei9sFt/FgDaTtq4iY/O4MZf2dhB84RbX2hbT5LHZ40Ur+vMO3Y4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzR8stCsBeXhjslWUFOZY25X1KsNDINN2wwK4OKcg1JQg/3uCvl
	CWarAuhzR0qLuvUn7p1pHhyHF1a64ve95HFYoXcLa8sTJrfdXfqFr3DWAd0/rxhlotOB/YJpEox
	kjkAtEFHa10sdFKnGNb4QA8VoEwVmb4aVu3OUVUKccMDn1e4J2PtBVW6sS9On4P3QTqLTgGE=
X-Gm-Gg: AR+sD12pNHYm5oohsNNDJHbDfPgSXFUSme4XOiBcGGehrY8mO5hbgOL/3v1F2urXKiv
	yc5yawe7zKovukYNXYA1owpr2HPxOLu/XMHCD5zpK+as+uIQiSyMzcp1ExsejnwpDflkGdU0g0I
	uqosB836DPWi/uMVvDrNiVEYZENk6DIr6+3ScnBbM7MIlgowLjN115PpQgftLluZatRNqVgmqNo
	OqUgr9zCWpZ/JWCzGlmnyiMdobzbdohsVDyIWJeg83nGJ45fNx7ZZTUmLjWKv8asFzwYGS2lE88
	/Hp/Oo1dE8MdyHouq/DN/pLufLdl0iZeew+vAzltLRCdZsrEstwxIhrwF4Dwcb3vu3VNAzgCJKe
	+QHcKshja18SaQdxxAQCZAb2yqSj7U2RfqQ==
X-Received: by 2002:a17:902:ebc2:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2d0521a56ecmr131899115ad.10.1785815349706;
        Mon, 03 Aug 2026 20:49:09 -0700 (PDT)
X-Received: by 2002:a17:902:ebc2:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2d0521a56ecmr131898905ad.10.1785815349304;
        Mon, 03 Aug 2026 20:49:09 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.118.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae60139sm46681795ad.29.2026.08.03.20.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:49:08 -0700 (PDT)
Message-ID: <9f11db59-5245-4bd5-afbb-485500d37675@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 13:49:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: qcomtee: fix kernel-doc warnings
To: Babanpreet Singh <bbnpreetsingh@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>
References: <20260802003956.7-1-bbnpreetsingh@gmail.com>
Content-Language: en-US
In-Reply-To: <20260802003956.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zf4t8MVA c=1 sm=1 tr=0 ts=6a71613b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=P7rZ2Udeej982rJtnmwBRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=wsK6t3w6FQtueOB5nkoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Wrn4q47ppy2zSbzqQiFnyv-_U27JDSoU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAyNiBTYWx0ZWRfXxOErbG8E1TuP
 FSXUXLcez+0A2FlH7xtBfcDwhmjevL6wcYaoZ42/3ZwgJ2lFvEO9uawgRuEvacPuJkEWbXt0SKj
 FY3311EJnaC2hGh/ipC3kYVoc+qtkmRISOzzQH84KfsMT7tyVk2wsj42vTU/Eugz279jODvPR2z
 Wjp8AFZiIkbyjCDb8qzQ7NJ26q892xQaXsbKNkVUwXyhvmp8NvYx+2vXRM3yUReEYOxyGowfX2C
 T4DyYPYHnJ+lsDmBg9zshv18PVH6oJlDjToTi+a9fu5R/nYJHmMC0x83Kpn5yF8avSDvX1LCl+6
 yjVcZq829S5VKHAm80xuNvBWyesmAzUfTzVa+MLHvgUA62F2XQj+hnCJgTweJNC0SgYwvzEOnAi
 bPV5agMj1SVgXeqQ3yFGoT8DvYOOS3KBw6C37c64ZVdZSVI2hM/13RhwyTF+e7cYSIk9Q87eLjk
 8G6j6kuaLZE/uGYWnpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAyNiBTYWx0ZWRfXwAFuylnf/Byp
 HMNtyAPufHLI2i9Jg8mX/EvHZrrz+d3IBTdDajX4ZnxgbBR9Z5xx56QwAO4ausvo6kukJA4mXq+
 7QmTJXuLOvgEwTwAm2n1YLLi62tzytE=
X-Proofpoint-GUID: Wrn4q47ppy2zSbzqQiFnyv-_U27JDSoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040026
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from,206.83.118.41:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BD25743EFE
X-Spamd-Bar: -----
Message-ID-Hash: FUMG5JXPC6JFJK44IVBZ7TUFU2EJPCKF
X-Message-ID-Hash: FUMG5JXPC6JFJK44IVBZ7TUFU2EJPCKF
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FUMG5JXPC6JFJK44IVBZ7TUFU2EJPCKF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Babanpreet,

Thanks.

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Amir

On 8/2/2026 10:39 AM, Babanpreet Singh wrote:
> Fix kernel-doc issues present since the driver was added in commit
> d6e290837e50 ("tee: add Qualcomm TEE driver"):
> 
> - async_release() documents its second parameter as @msg, but the
>   parameter is named async_msg (msg is a local variable);
> - struct qcomtee_msg_object_invoke documents member @ctx, but the
>   member is named cxt;
> - enum qcomtee_arg_type leaves QCOMTEE_ARG_TYPE_NR undescribed.
> 
> The cxt spelling is part of the QTEE message format and is used
> throughout the driver; struct qcomtee_msg_callback in the same header
> already documents it as @cxt, so the comment is corrected rather than
> the member.
> 
> No functional changes.
> 
> Assisted-by: Claude:claude-opus-5 [kernel-doc]
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> ---
>  drivers/tee/qcomtee/async.c          | 4 ++--
>  drivers/tee/qcomtee/qcomtee_msg.h    | 2 +-
>  drivers/tee/qcomtee/qcomtee_object.h | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/async.c b/drivers/tee/qcomtee/async.c
> index 31bff4309e672..5849e51612033 100644
> --- a/drivers/tee/qcomtee/async.c
> +++ b/drivers/tee/qcomtee/async.c
> @@ -97,10 +97,10 @@ static void qcomtee_get_async_buffer(struct qcomtee_object_invoke_ctx *oic,
>  /**
>   * async_release() - Process QTEE async release requests.
>   * @oic: context used for the current invocation.
> - * @msg: async message for object release.
> + * @async_msg: async message for object release.
>   * @size: size of the async buffer available.
>   *
> - * Return: Size of the outbound buffer used when processing @msg.
> + * Return: Size of the outbound buffer used when processing @async_msg.
>   */
>  static size_t async_release(struct qcomtee_object_invoke_ctx *oic,
>  			    struct qcomtee_async_msg_hdr *async_msg,
> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
> index 878f70178a5b6..5d7b21fdd3688 100644
> --- a/drivers/tee/qcomtee/qcomtee_msg.h
> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
> @@ -112,7 +112,7 @@ union qcomtee_msg_arg {
>  
>  /**
>   * struct qcomtee_msg_object_invoke - Direct object invocation message.
> - * @ctx: object ID hosted in QTEE.
> + * @cxt: object ID hosted in QTEE.
>   * @op: operation for the object.
>   * @counts: number of different types of arguments in @args.
>   * @args: array of arguments.
> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
> index 8b4401ecad48c..d5de02dcef3b9 100644
> --- a/drivers/tee/qcomtee/qcomtee_object.h
> +++ b/drivers/tee/qcomtee/qcomtee_object.h
> @@ -74,6 +74,7 @@ enum qcomtee_object_type {
>   * @QCOMTEE_ARG_TYPE_OO: output object (OO).
>   * @QCOMTEE_ARG_TYPE_IB: input buffer (IB).
>   * @QCOMTEE_ARG_TYPE_IO: input object (IO).
> + * @QCOMTEE_ARG_TYPE_NR: number of argument types.
>   *
>   * Use the invalid type to specify the end of the argument array.
>   */

