Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC8AC43458
	for <op-tee@archiver.kernel.org>; Wed,  8 Jul 2026 06:29:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EFDAA44E7A
	for <op-tee@archiver.kernel.org>; Wed,  8 Jul 2026 06:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783492195;
	bh=0eFyRhU62Sp8Fxi3jAmIZTFwuMocCNKG2j2XsRE2x/g=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Nfn6wV99LSxI7EX+0SVP4PCIKQ2IF46mqMWYf1L1jBw53BNXgmz5TcyD8gOVbIx10
	 ffnQl3NBuNVa+3R1O+ARLxbybMeZieiU5OrdZHgoYsF3PZI6+k/4Qw0JbHJ3s4ncPN
	 BbnxYXEJL8kWo/ce26Gknzjsy9MdDEq64Z0PF8S1PIsY9jU5PZKe8FeNNjoYHsbxdd
	 2KnznLthzSc0k2RQ/8DJqGsCDhQDoDzDOXZSZaH713ehA0v5Qah7O7RB9+kXHFLD7s
	 RIXp0v5AAXUfq8Ecnss+hgkfQc0AUqFvNcDF5lnYKzhegfw4wrbcMMA5bW4lbV1nCZ
	 EpVgXFktXkgVg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4625442D04
	for <op-tee@lists.trustedfirmware.org>; Wed,  8 Jul 2026 06:29:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4F8+R0j;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I9/bYxTn;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842B7d1508797
	for <op-tee@lists.trustedfirmware.org>; Wed, 8 Jul 2026 06:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1F9UyrOYpeOrWMjmcc95u8JvN4hXEK2XvrTpwrlEp2s=; b=f4F8+R0jdQPbJCLU
	Jo9jKtE6ZeM/krA4f8BRaa5WWv5MtwJLy9wu6XUPNDvonsTtzJ6G+CbPUIHdBS3b
	t47jNI+5DA0Yy3pc7pXefIaHMda8Xo8DbVbmGZFcTGDFssoDqriyCKReSZ1JcrU2
	N6yLMbSAx1M1TQgoGmNt1K1NqNw7I4T5cwqpma54Lr54sgetex6P9eItNzt5TKdq
	HpFdPSPT29J9EipLQx4S7SYwqYWjh21PGaOTLXYDNL7tHofCBn5CdzspdmnED36v
	bUfSgUuJNDnSD3+6do/xiixI8DCKGCkiDjIhpVBph6ZFBDq7TieHbF88TYmKH0e8
	DnHp+w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9be597uy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 08 Jul 2026 06:29:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6823efcso4124315ad.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 07 Jul 2026 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783492187; x=1784096987; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1F9UyrOYpeOrWMjmcc95u8JvN4hXEK2XvrTpwrlEp2s=;
        b=I9/bYxTnb7PxwfB5nAt4MImHxtIt2iQTy6UmUIncdFNQs4rzmBcF3VbBlHI4Ory1ZS
         m/PAIPC8kI6YGlOkSfHeiCqWXdHY2IJoi/ibFe75sHAkucRkjUEILFDEvHfl3HSwZnx5
         dBc7+rnZFeIjYVSsc26xeQOmZaPbPtCmU1jh4VxSBSNGMxCwf0E0dwm0RqFw7uytxxfB
         w8QD06/MzpfP+ZnJWXqM3JsMpzT3bUUxb0NCY7R2x/Ffe0e5gSHEVP2fMPFpSMzlFdiu
         ugoLJhFh6M+/FN48GaYQIEL18t8naQVdspRoOORw2lH86Qxj0cEpKnJ4zMvVIeapgbtK
         ehzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783492187; x=1784096987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F9UyrOYpeOrWMjmcc95u8JvN4hXEK2XvrTpwrlEp2s=;
        b=Hfl42SfdmVmdiKICmDIREOyIL/pmXuga0/bkoja76RxSS7y/tNuo0sTkIluZ3TKE0Q
         cYy/ClBVh0+g99cvYXxILxcll7DjhJF+4gO6foETo28JkGAWr2jAgCaOxoQ1qVFI43df
         YQAnUlYd6iGauytuO+MzAvJ1V8p7uOOEE1C6kxvcOKPH7IW0c24O9womKhQ+VA3x84NJ
         m7W3onSSME1cqy0J9FLjx4Gf8csv3wrR4Pptdm+YIYmp2xMdEavMWUa8llBkGFV6nVSc
         2gTkQKspVvjBs7cXuY94HfOSuY9qlbwZVGe4vvCha72LDk/yLuMJYFPa7ccI1nz32tvF
         Xkrw==
X-Forwarded-Encrypted: i=1; AHgh+RoKI1rP5mSU2jsdArn/pGP/gfqTY4kQn/VglO8xsaiaLFt7g4tNzqpmCKw35tyd+HUUKaMRVfY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxJUGtdff0fxkNUxjOAWFg0ENkq5oUgQFlhafpkawkiKY4Px1cu
	hlDDOlRi6TOwf3cUI3I2sepg1e0/8CRB8lr3BZ3LNK/UH5QB1Gg/R31ubDmC2xvlxqOhxeCKbjp
	BROZr37rVbmN3IwITGmIX86HaNiCmirA3DHLRPXXMZAq7xqp2YQuCONwS86Ax6RaIzB1su5U=
X-Gm-Gg: AfdE7cn/FmdEjiPXWH32FJqQvRhPjiDWlMiyEqAMLa65/d5XaXp+IvHmYi9trZkD2e6
	C/Oxl4gSLOAKC1ja2zHvlqmC9qHir4Y7SSvqFlcA2w9isr6xf7jntyRhrtgKZb50JADbEnxNNRE
	e/RxWZOrAYOl1D6i+lJIOUqFRudBj8E3RyQlJtL1nxqIeVL2HiDQAIJeaWdDsa85nC6unVJLWt2
	7YOIwkgGJVYZDQLNAI/EN1rzGyVgUuE4IyE8fFnOBVyX1tM8fWL719Oq0Wt42Lx9RAAOoVgeSZz
	G4pEoQxqYqbNLYyv7dR4sUJPp18JoE6EFXnPxnRnAlx+zyDlToj6lRyQnQnYmAyP1cB7I8Xvb45
	8cb/U88TJ3pgaIDHsbeH8iQTSuIGR8W/g4yoN9CBNi2vc
X-Received: by 2002:a17:902:f791:b0:2c9:97a7:b1eb with SMTP id d9443c01a7336-2ccea59f7a1mr11657515ad.42.1783492187106;
        Tue, 07 Jul 2026 23:29:47 -0700 (PDT)
X-Received: by 2002:a17:902:f791:b0:2c9:97a7:b1eb with SMTP id d9443c01a7336-2ccea59f7a1mr11657335ad.42.1783492186630;
        Tue, 07 Jul 2026 23:29:46 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.113.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5c361sm22607485ad.80.2026.07.07.23.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 23:29:46 -0700 (PDT)
Message-ID: <651db8ad-ff57-4369-8401-f51bb7ea46f5@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 16:29:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] tee: Add kernel client object invoke helper
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
 <20260707-qcom_uefisecapp_migrate_qcomtee-v1-2-f659cbd5d04c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-2-f659cbd5d04c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GJc41ONK c=1 sm=1 tr=0 ts=6a4dee5b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=+r7WnWcjNhrw7ahDJtTqLQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1yzuO3Wzu64Mvm5RHTIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2MCBTYWx0ZWRfXyf5bUnKkYSBO
 aa2TbaHUWfYCAzm9laqkNDuw+xQCo2ce7BaHE3THoirwK2rWb2/pt0zJaENeZmZC2QtN6zn9TFr
 q9bHIzquKVl739FCgkuqDC+KCYy451Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2MCBTYWx0ZWRfX08Y46dajlEHM
 QqnpgaivMQsdVF9ngwkgXUxhoGL2oFzd1pfoA8TvQBzaiMAFvPql5iGrd80QMQ6fK3bESpvUErr
 wF4N6aQHQHXIcHJ3RQcgwO5EYotIcX25ooZRqe84Ooqsm9u23seP8NdKIpdoDQvHxSsAM80F2Bu
 tb121nv9mNmbawO+CF/o4UVrU9fT2Bf6H3OP3F6SPNofoOZjg1idMqfaYYCAjh4IzXSDsEQJHfG
 bYNGlT1wvms4unnXkC3gbFLiidPrT3G7LXvof161+HZcBsU+eu9YSu5eYOIU4v9qKQvCVTIauR7
 w7ZlixCRtrGXjPJ3Sto+6umsLfIfYvwBcOQi4MeyibnFqsCTFv7ZrZUBahVS01gNnAmAtM+nYn7
 aDKmJl6ec7Woyb+4p1fnBEt6MdQL4r1Jhg59+/ITkHh0fp1j2Q3n+kMAwoQXlX/mfRZABGQwjkV
 WMglMTZS7MFMZJlZpjw==
X-Proofpoint-ORIG-GUID: qrm2l8nN7PP5evzkPCQvjMjdjVewxkMM
X-Proofpoint-GUID: qrm2l8nN7PP5evzkPCQvjMjdjVewxkMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[206.83.113.14:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4625442D04
X-Spamd-Bar: ------
Message-ID-Hash: Z5EXMOU443FVYSD5R2VTSTPJG5PENI6T
X-Message-ID-Hash: Z5EXMOU443FVYSD5R2VTSTPJG5PENI6T
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Z5EXMOU443FVYSD5R2VTSTPJG5PENI6T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Harshal,

On 7/7/2026 4:11 PM, Harshal Dev wrote:
> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> Kernel clients can open a TEE context and invoke regular TA commands
> through tee_client_invoke_func(). However, there is currently no
> equivalent helper for invoking TEE objects.
> 
> Add tee_client_object_invoke_func() as a kernel client API for issuing
> object invocation requests. The helper checks that the backend provides
> object_invoke_func() before setting the MSB of the object-id and forwarding
> the request. The MSB of the object-id informs the TEE backend that the
> object is invoked from a kernel context.
> 
> This allows TEE backends that support privileged object-based calls from
> the kernel-space.
> 
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  drivers/tee/tee_core.c  | 13 +++++++++++++
>  include/linux/tee_drv.h | 13 +++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 7f986d7fb47f..0783802fd010 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1413,6 +1413,19 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  }
>  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>  
> +int tee_client_object_invoke_func(struct tee_context *ctx,
> +				  struct tee_ioctl_object_invoke_arg *arg,
> +				  struct tee_param *param)
> +{
> +	if (!ctx->teedev->desc->ops->object_invoke_func)
> +		return -EINVAL;
> +
> +	/* Indicate that this object is being invoked from a kernel context. */
> +	arg->id = arg->id | BIT(63);

Setting this bit is a qcomtee backend requirement and should not be
exposed to the TEE subsystem.

Kernel users of qcomtee_object_invoke() should use the normal object ID
value. For example, access to the initial ROOT maybe represented as
TEE_OBJREF_NULL | BIT_ULL(63), but the upper bit must be managed by the
qcomtee backend for any return object, i.e. The backend should also set
BIT_ULL(63) automatically on each returned object ID.
Callers should treat the ID as opaque and must not manipulate the upper bit directly.

> +	return ctx->teedev->desc->ops->object_invoke_func(ctx, arg, param);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_object_invoke_func);
> +
>  int tee_client_cancel_req(struct tee_context *ctx,
>  			  struct tee_ioctl_cancel_arg *arg)
>  {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index e561a26f537a..ca99c6b747a8 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -283,6 +283,19 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  			   struct tee_ioctl_invoke_arg *arg,
>  			   struct tee_param *param);
>  
> +/**
> + * tee_client_object_invoke_func() - Invoke a TEE object from kernel space
> + * @ctx:    TEE Context
> + * @arg:    Invoke arguments, see description of
> + *          struct tee_ioctl_object_invoke_arg
> + * @param:  Parameters for the object invocation
> + *
> + * Return: On success, returns 0; on failure, returns < 0.
> + */
> +int tee_client_object_invoke_func(struct tee_context *ctx,
> +				  struct tee_ioctl_object_invoke_arg *arg,
> +				  struct tee_param *param);
> +
>  /**
>   * tee_client_cancel_req() - Request cancellation of the previous open-session
>   * or invoke-command operations in a Trusted Application
> 

Regards,
Amir

