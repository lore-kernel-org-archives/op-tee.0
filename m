Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FECC53219
	for <op-tee@archiver.kernel.org>; Wed, 29 Jul 2026 07:06:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7AABE44F6D
	for <op-tee@archiver.kernel.org>; Wed, 29 Jul 2026 07:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785308785;
	bh=JpbjOed841uoNyZgbbrf8oa3r2l9U4SVOjjXNLfnmJI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GKQDPOObREDlLy5t0YtfgITqNk3lWCrdRfnHY+8R0YA4aWssX1UMASE6y6eCkpa0J
	 l+n/xKEpomv6OrNTt89mZCO1yZVkJPbHU0QgcGogdO92ReHN3K6ckjxP/+Hfg7JQw5
	 LgIiJX4sXOrhg1+Ps7BA4xNEaV8U72u+i7nor9ljm1gfvPsNQDhhi3D3mMMC8VDLSj
	 cQyj1YGCoWEDWEDdr2I5pNtm2R7WyMZvGcDiuo8OYq04Kq2en7Fim7LcP7TYIaHAzs
	 DODS6Rl3ADm4TcNFG7EpM5bG9z+8k+YygsLMt0H0huQHeWirDjJjeUDBVs4X0GT9j8
	 yuNKOJX97nzAQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 67B61451A3
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 07:06:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mjv1wOyW;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V5+foFaf;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T5hxLj677347
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 07:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0OUBm1wl/4W/uyUJqKNXcBjQ/DSKUZnbvbwlpTjWvcM=; b=Mjv1wOyWnFk/+5+G
	B/vIP2NNnvtgeD6gNYkjDrHF5ANhV+8F4dc8IZJkAVd1PY9KjSRdm+M4f0QWiiu4
	zhU9HS7BkxDp7htc30m4tKu/3xoiY1XJvKkYzyKgtkpcK3iHzeW2hf8VCqMLaegs
	b3c8JVg1WxjLmyE5bwA2w6MmnBbw91Z38ZW3NZoDpNMRtYmIMtIZ24ce/mnGUDt+
	xD0ebUJ9ZuIzZ1WQk/WTdpaKNZBxDiUU1c+WWAIq03wnGEqwRuz3V9KcpICNuBKo
	1b5erltXPrx5qEgqPhRC3vcV51cY7Q8IgVE0u4zp9XIVGYKnpHREcEXiiKFSCZSf
	/kJpQg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqbmm09r6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 07:06:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso671494a91.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 00:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785308770; x=1785913570; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0OUBm1wl/4W/uyUJqKNXcBjQ/DSKUZnbvbwlpTjWvcM=;
        b=V5+foFafcjEvSVaEO0qwsh5g5e4hDji5ujdTh+Ao9c3Rs8r7WyHZhwaIlCMifzl5KA
         kVc0XUUL+yVKhkC+QdN+t4W4K8MwYxc0LKnU7Cdj9THE6urrxSSzKoE5hayjiCZ2m6ke
         svBbfx8p35eHeA9ZPQyTRNC5ComUbj0Lpu3sdUxla9kARJC3uc2YudMYNkbNcvHSvff6
         CvrrxfrPCXehrZFKtV3ybAEx0MNa5bptOOmRI2L0FutPdCzQtvyqjJrY7hvNkcualV1j
         GsKdjo7Zidj75gJc0DqLVLWZZ7o8rYj7hkLiHXR0JyCVU8id4jZ7OpDL38qumUj9OrkM
         pV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785308770; x=1785913570;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0OUBm1wl/4W/uyUJqKNXcBjQ/DSKUZnbvbwlpTjWvcM=;
        b=FbL0z0cHDpx64Ew3JMyTjwN23avnXuR44Wfir4QSO3rJgf4NaxVjwbWvYQUilVaxZW
         pcHxO3r7bL+hRLqngtnorHtFAqP7G1OFGDkD/qufXytGuBmHUt/2zrwkC/0Hs2vtojwD
         +rJtUwIfN6hPTKSTDdgYvNf7Fvvvj3Bqpc/9s1K0/Lujl1qHk7CgU7j9sEuscRgbUHQ8
         r+ZA9mA0PjjckE8KOqD1pIcg9Uau+AoF8kbKm4qZuDgUwfEGEDxIwfyBDfA+1FXRdHws
         +qIlO9e9cUKhhloKxWxssgbYokwE/Be9p+rvA2kI+ADqx/ZnealU1LtEOV6dYFFGeMqC
         DAuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrT4ecibNIfRljB1lkVBPuoafMzocVhIzZq/S1C90FuaAf9g31j4RdIC9dlwncg6xwwMmlvvg4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzZ9LFneL/y2FU3Db0VuJXOS+x5/UPtfm75HC1DDydYlBRtlR/v
	AVEFzXcCKQA6e1GvLjqfufuQwi5rpnJN+Er1X4ktbt0xyaOONbDYGiC28iVSaz/awYRjlqfjEhj
	84NFof+MFClfl7dODO9428jEK63WJJMOciy9gIvH8S1tiDjoFcSzJOht4aFCzukzqAqtDtBg=
X-Gm-Gg: AR+sD129hg9aISzgZptuziyqLWLQfAzb1WnN8JLoo36dHQVcj8Ce4ZXagI5QCLUsZgA
	6TKFIMvj1UN8ZUnGGyAekEud+r8c6vInQT3yE8bxQydsaG/yCZHsxFBag61KhXZjkgkexkmyjCX
	6bVc76FNCcMwxvZXGjzvN4dA+C3fcDp2rBjS2MdrA465LcYC/JL5xyhisqcLzCkk7T2H9rQN7MR
	O40ZwBaAonjftbihpZ2YFprRScveX54nrhCNmwIXu2L2JZNNu4raQk9e8prm1Eyk52F9E7tUzvi
	o3Xp4rC3feBGQKrN/lx7jaEXvQdIxxrS0wI7oUrYY6a6RYTeOlcXf+DbVAUWKfMkauAzym36jRy
	dQglafqiLc7FRUqbhWrj+GgzNTqyxcmdTQA==
X-Received: by 2002:a17:90b:3a4c:b0:37f:e326:6559 with SMTP id 98e67ed59e1d1-38f6a438830mr6228977a91.22.1785308770279;
        Wed, 29 Jul 2026 00:06:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3a4c:b0:37f:e326:6559 with SMTP id 98e67ed59e1d1-38f6a438830mr6228940a91.22.1785308769668;
        Wed, 29 Jul 2026 00:06:09 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.12.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f80717ec5sm450542a91.0.2026.07.29.00.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 00:06:09 -0700 (PDT)
Message-ID: <ac5760cc-a4ab-4fe1-9962-6b6890de4f36@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 17:06:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] tee: qcomtee: Allow object invokes from kernel
 clients
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <20260722-qcom_uefisecapp_migrate_qcomtee-v2-3-b8a8fcbe4211@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-3-b8a8fcbe4211@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jVY6CqI48v_tnwlvLjNuofQh3q7Idsl_
X-Proofpoint-ORIG-GUID: jVY6CqI48v_tnwlvLjNuofQh3q7Idsl_
X-Authority-Analysis: v=2.4 cv=R/Uz39RX c=1 sm=1 tr=0 ts=6a69a663 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=1tOsOel+q48EdXbnVOFv2g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Xs04euXehvGDb6oPuSgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1NSBTYWx0ZWRfXx2R6A7WNIwp2
 znPEeMtVYYtawAbpn0/wZbOvKLC215JOshJK9yKk6lbi5Ex2vc4v+v1YLYVjfkwVVMPOI0jqV0d
 h70cUvtmq+8V5wRLwHYCi7/QlWl8NP7YxjlvbNSb0irVHTnI56TVL8KqNnM0mesFKi1LD5KcYaY
 +wQRsbWG20E3Y5KCVEj/7/kXw2uWgb7A23vZiFo1WjgQPIeWkdeZZEWNDD7g0YnmCfI2/DBfCl8
 1NQ69znrTN1hx5cTEgPt0Z7jojI4VmEMACyByFG8Ktx5kAFH8lFxnO2XiO1Q+lSMyYpmO+dpEOK
 lxt6gIN76kJHmEEiAXw/ChQ2c+ca06RzW3SYbBJaI0yjM5aa7jwV4St1AJd89xGF06ksEV7X93K
 iQDh/blY4AI+OrOtEJFSbpWaet+skoiS5jOWdm+H9umjWofq+rXV7ocABR7Yxzcfhf2PZYAQ/PI
 nEx++5qxW0v9K1edzqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1NSBTYWx0ZWRfX50H+qqEpavKr
 /iDYsparBB+J36r2XWNqv8BV6LG+e7MjpxftNalDIT8D/3bVb/0losP19WgKATd9tgoAG3sA52m
 03XG2iImIY7Vd0JVouZF1iWr4tAkgQ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 67B61451A3
X-Spamd-Bar: ------
Message-ID-Hash: I66GQYEJEYTHQ4VQFSOQ77QHIBSF2RU6
X-Message-ID-Hash: I66GQYEJEYTHQ4VQFSOQ77QHIBSF2RU6
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I66GQYEJEYTHQ4VQFSOQ77QHIBSF2RU6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Harshal,

On 7/22/2026 4:59 PM, Harshal Dev wrote:
> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> QCOMTEE currently treats UBUF parameters as userspace addresses and
> applies userspace restrictions when invoking the root object. This is
> not suitable for object invocation requests issued by kernel clients.
> 
> Use the kernel_ctx flag to distinguish kernel client requests from
> userspace requests. For kernel contexts, do not mark UBUF parameters as
> user addresses, and allow permitted root-object operations to proceed
> without applying the userspace-only checks.
> 
> This allows in-kernel users of tee_client_object_invoke_func() to issue
> object invocation requests through the qcomtee backend.
> 
> Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/call.c           | 34 +++++++++++++++++++++++-----------
>  drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
>  include/linux/tee_drv.h              |  5 ++++-
>  3 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index 03d33b118f6d..c1bba5fbfa3e 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -202,7 +202,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
>   */
>  static int qcomtee_params_to_args(struct qcomtee_arg *u,
>  				  struct tee_param *params, int num_params,
> -				  struct tee_context *ctx)
> +				  struct qcomtee_object_invoke_ctx *oic)
>  {
>  	int i;
>  
> @@ -210,8 +210,14 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>  		switch (params[i].attr) {
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
> -			u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
> -			u[i].b.uaddr = params[i].u.ubuf.uaddr;
> +			u[i].flags = oic->kernel_ctx ? 0 :
> +				QCOMTEE_ARG_FLAGS_UADDR;
> +
> +			if (u[i].flags && QCOMTEE_ARG_FLAGS_UADDR)
> +				u[i].b.uaddr = params[i].u.ubuf.uaddr;
> +			else
> +				u[i].b.addr = params[i].u.ubuf.addr;
> +

it is & not &&.
Rather than ?:, can you have single if and update both flags and addr/uaddr.

- Amir

>  			u[i].b.size = params[i].u.ubuf.size;
>  
>  			if (params[i].attr ==
> @@ -223,7 +229,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>  			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
>  			u[i].type = QCOMTEE_ARG_TYPE_IO;
> -			if (qcomtee_objref_to_arg(&u[i], &params[i], ctx))
> +			if (qcomtee_objref_to_arg(&u[i], &params[i], oic->ctx))
>  				goto out_failed;
>  
>  			break;
> @@ -270,7 +276,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>   */
>  static int qcomtee_params_from_args(struct tee_param *params,
>  				    struct qcomtee_arg *u, int num_params,
> -				    struct tee_context *ctx)
> +				    struct qcomtee_object_invoke_ctx *oic)
>  {
>  	int i, np;
>  
> @@ -288,7 +294,8 @@ static int qcomtee_params_from_args(struct tee_param *params,
>  			break;
>  		case QCOMTEE_ARG_TYPE_OO:
>  			/* TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT */
> -			if (qcomtee_objref_from_arg(&params[np], &u[np], ctx))
> +			if (qcomtee_objref_from_arg(&params[np], &u[np],
> +						    oic->ctx))
>  				goto out_failed;
>  
>  			break;
> @@ -304,7 +311,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
>  	/* Undo qcomtee_objref_from_arg(). */
>  	for (i = 0; i < np; i++) {
>  		if (params[i].attr == TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT)
> -			qcomtee_context_del_qtee_object(&params[i], ctx);
> +			qcomtee_context_del_qtee_object(&params[i], oic->ctx);
>  	}
>  
>  	/* Release any IO and OO objects not processed. */
> @@ -357,7 +364,8 @@ static int qcomtee_params_check(struct tee_param *params, int num_params)
>  }
>  
>  /* Check if an operation on ROOT_QCOMTEE_OBJECT from userspace is permitted. */
> -static int qcomtee_root_object_check(u32 op, struct tee_param *params,
> +static int qcomtee_root_object_check(struct qcomtee_object_invoke_ctx *oic,
> +				     u32 op, struct tee_param *params,
>  				     int num_params)
>  {
>  	/* Some privileged operations recognized by QTEE. */
> @@ -366,6 +374,9 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
>  	    op == QCOMTEE_ROOT_OP_ADCI_SHUTDOWN)
>  		return -EINVAL;
>  
> +	if (oic->kernel_ctx)
> +		return 0;
> +
>  	/*
>  	 * QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS is to register with QTEE
>  	 * by passing a credential object as input OBJREF. TEE_OBJREF_NULL as a
> @@ -429,7 +440,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  	/* Get an object to invoke. */
>  	if (arg->id == TEE_OBJREF_NULL) {
>  		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
> -		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
> +		if (qcomtee_root_object_check(oic, arg->op, params,
> +					      arg->num_params))
>  			return -EINVAL;
>  
>  		object = ROOT_QCOMTEE_OBJECT;
> @@ -437,7 +449,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  		return -EINVAL;
>  	}
>  
> -	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
> +	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
>  	if (ret)
>  		goto out;
>  
> @@ -455,7 +467,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  
>  	if (!result) {
>  		/* Assume service is UNAVAIL if unable to process the result. */
> -		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
> +		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
>  			result = QCOMTEE_MSG_ERROR_UNAVAIL;
>  	} else {
>  		/*
> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
> index 2528d07e4576..7bd6e23b038c 100644
> --- a/drivers/tee/qcomtee/qcomtee_object.h
> +++ b/drivers/tee/qcomtee/qcomtee_object.h
> @@ -112,8 +112,9 @@ struct qcomtee_buffer {
>   * @b: address and size if the type of argument is a buffer.
>   * @o: object instance if the type of argument is an object.
>   *
> - * &qcomtee_arg.flags only accepts %QCOMTEE_ARG_FLAGS_UADDR for now, which
> - * states that &qcomtee_arg.b contains a userspace address in uaddr.
> ++ * If %QCOMTEE_ARG_FLAGS_UADDR is set in &qcomtee_arg.flags then it implies
> ++ * that &qcomtee_arg.b contains a userspace address in uaddr.
> ++ * Otherwise, &qcomtee_arg.b contains a kernel address in addr.
>   */
>  struct qcomtee_arg {
>  	enum qcomtee_arg_type type;
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index ca99c6b747a8..71d0536db60e 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -83,7 +83,10 @@ struct tee_param_memref {
>  };
>  
>  struct tee_param_ubuf {
> -	void __user *uaddr;
> +	union {
> +		void *addr;
> +		void __user *uaddr;
> +	};
>  	size_t size;
>  };
>  
> 

