Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5FECA6015
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 01:04:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DB28E454E3
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 01:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791507846;
	bh=xBJ/7w9id6syIhW5wipRMkeRBktiTifargS+O9WpD7o=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Cbj6sMAHkml+EPDtU8AR3aMPcxvEO0wK69kWbjZsfI9lqZN9jO+oBBNSyPSTJOI9q
	 vOX0UiVEJmh01ZocwyTQDv2b+P/5fSOASueQa3Wt72b45bH41fydejKPdPClSYe2nd
	 PqpTwdhffGyYJDjR13fsR8YvQoxsTyMw63OZWBV1OkNGPJDcFOPMyu6qwiee5h/dBF
	 sllPw6kCGFEJaAz89jXH+6rKoebJwN+UdQE9wqe0CYPhhKp09e99vsH55y93eLKx50
	 n3why+IKpvlqSFfTlGx3mgdCBZe01fVYgbtEAhJ+96n5s1lOBIjteYgMS5sQ98XamM
	 Qg+Ek/O1/IMJA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7494D4498C
	for <op-tee@lists.trustedfirmware.org>; Fri,  9 Oct 2026 01:03:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T6nluYy8;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OBTwMrG2;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6990QM7f202714
	for <op-tee@lists.trustedfirmware.org>; Fri, 9 Oct 2026 01:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pKvG9/Cxnz4Au03lnvbc02tVpQ/J5aw1CU2DV7LDkYo=; b=T6nluYy8S6u4dppI
	BWT/eMSgy4OJOUwVtlize9siEe5n1ujkqznvjyWQf7JzYKVh+EMAPc5XGcbnVF9Q
	bqhtiHTDQHO16z6uJSeM3HFllNgqOuPYyQphnB6iLmpunDgi2MaTQgRKSc/ekYV8
	ac8rDPnBjiWoWuO1gz9cz9wWuplB+RaEKw3DLcL1r3cESBLbsICnj9xhLpWu3P3d
	IxwzJ2aa2xotTWaIpGIJLCZV7i8GXlw4g6+FCcdiIPPcaQvbG3f/r1dsVifmH2+0
	LGpuVoEd2CJyOT1fUrcHmU0hipuHof3YRy9mUTe//XNyIvTKYkNHSTBBtJnzE5/u
	67TYPw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk97bq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 09 Oct 2026 01:03:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a85a33333cso3311326a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791507838; x=1792112638; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pKvG9/Cxnz4Au03lnvbc02tVpQ/J5aw1CU2DV7LDkYo=;
        b=OBTwMrG2VQgFSind6ir4NEWB7KvF27MBmM/XXtAgGDC2nCgBwNleZen4GF+BE5YKdn
         QkGxxGZn4xPngMYf8Y2BZZImUn8+vQq6GbZKdH+cHj3ZVw1uQ4YSv1Y6Qk+3aQHHSk0m
         CfOoNCTH/w8frQmgCFFmRvVJFd9UXrNAEsKutMy02SA/ck8RoZ8SG1qoeDSvk8/9g9+c
         BSTleG1W4YlQnHNPXBE5vH66SkEjqpbYVQVieLvDmo6Yj7Emxe1L4aHEJ2+LqbzCiLRx
         MDCwVQLXmNu/zTajXLRSgY+ps1Gc8qeQAdsoLC8sjqps/DwIbLyg00anW9MpTj8bYdXs
         aTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791507838; x=1792112638;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKvG9/Cxnz4Au03lnvbc02tVpQ/J5aw1CU2DV7LDkYo=;
        b=dVVXyy4bMJ2VK5kZ5dKjE4FoN6N805jBCjjQxMdOS8bpVQ2u/acMvJCzVTUcoVWAzb
         Nju9MTUuWC1LfBeP/6w7PXSBF/hFTGHaNlna2TBzz2SY2skqgSqMpG55TnVVdqyiFkkT
         jdQ7xttQ3qrX+I+mYht8cnZ+vEnsQ5HutAzogmxO306iA651UclzwqosfwcranvZHkmx
         B0ExIw+lNes07sm2JaUDJPxdxiCzrWMm6H4Lf4z+jjmuJ8AZ75zk3Uy/gNhSUvvttYFi
         bT4iKNA9P9PWgadzOaERokxjPWfF+Tzzw+XXGkSwCt+yPDRNNJcwMxTN0mlYDxdGHI6y
         QnXQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9EAJscrE0ZFrSZ2kjvd6Ho14tMv7lBQ9oG0AxZ/w7RXq45BbzXXYtwKmbw4hb+YHTIGe0eOQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLxTLTIMvdZiReRhaj4wsgZ04Y3IbBdm9762Arf7kMLXpvHhW+d
	29iH52Uhrv8kLlqoVk/WgZmaHT3Jzo3HyNA3kg2DEGmFFZuQBG1uf2TI89Af9I+MQp+wuNEM+U3
	u5s0ASUEplxOsUk7qGeilGnGGhA2J6y9itq8qd/OiPh97hDVS6CnTq+8mqzkGXRC8/BCX4Mc=
X-Gm-Gg: AYBFou2Sg87BRopfVUD7ScOCKsGhEe4UIQkljgLakXQVgAhySoM6KWYIBpIhhvsb7ED
	YChXvViQRplP9atJCXK6/WCBu4LXCkWEjxJv3fx0etwMDQcasQHlXuyXhlKO7WHnioh7KEnsQfQ
	GXgN3k8JnoKRlr9l6FYlMjwr7xjLw+/fmMeiQihfoVY13vGIV1s+jRokXr+q+u91d7tJ0uG8Fcy
	50LiK5VNlU7soJBipUP/bg4cMhIxX+cywj0oBS7nchDz5ky6HYJCun42HIUR8P9kDT3ZR011tk/
	z3XZO83zdHBLMXx7u8MG36ffrlkzWLbg0ivO8W3jHKfUVlMm8dqA0iQs5HxclgvUsxaRn3AI9v6
	Cnr7ueuQnryDrjac+2wQRW7ruXIBzF7pL
X-Received: by 2002:a17:90b:1dd1:b0:3a8:f70f:1cb8 with SMTP id 98e67ed59e1d1-3ab3aceb97dmr409607a91.44.1791507837665;
        Thu, 08 Oct 2026 18:03:57 -0700 (PDT)
X-Received: by 2002:a17:90b:1dd1:b0:3a8:f70f:1cb8 with SMTP id 98e67ed59e1d1-3ab3aceb97dmr409567a91.44.1791507836931;
        Thu, 08 Oct 2026 18:03:56 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.12.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed040dsm1348494a91.6.2026.10.08.18.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 18:03:56 -0700 (PDT)
Message-ID: <c67afee3-269d-4acc-9e70-72d932d3e1e9@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 12:03:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] tee: Add kernel client object invoke helper
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
 <20261006-qcom_uefisecapp_migrate_qcomtee-v4-2-bf1c8e2a64ab@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-2-bf1c8e2a64ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mTQefKv48SnGgNql3XRx2CrH1T7S56F7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwMyBTYWx0ZWRfXx8qJN9ReVZP/
 WdqD4/i+xZF6uSxuxDImsc+p/mshrI2dqNP380FFTbfT7KJAoC17O4+2RJbuzHrwIwlDJTQL25I
 NRTS5LNA2teavuoUZV5X2I2TiT1scbI=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac83d7e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9v5PfQ1E2GNzj2RibJmqVw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=HcZ5Pp6Carw7JWlrJ38A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwMyBTYWx0ZWRfXx6aQCY2ED5um
 UUD0Qjh1P5jye2PjmKTJOT1jJvoDql9QZjnMwmjtG9YgZ6k/aEEX2UR3xOF+v+OOHaEtwFBoOkB
 LGPZCWmcI+O0MxW3zfHEWVGkvL+Sip8VWawyB5d5XPgnoHvpikKJGeqKRjE6vltGq9SxqzZ9CIG
 WDYS7BaQc53OlkBQy53faxf0jgmHDrALCT0h20wway/IXf6GSnmD403I6jRLr7shW3gYdatQnX1
 QN2a4u2fcBi2Tk4j4QaF9OjqJkM64m+zOa4a7ta/ZGTVHF1pO5I9wGumQnsgdP4NDm6V/xG9nOi
 tz8SThbn7glSiHqEtYOJyAOt7rikQucDFE+ykD1xOR9/4ZrOwbrZ8PSNNnxvA6vyebaU46QO4xp
 8gkc7WGmViwgOraNAqiLNr+r5cWMdfM2CsYqlDQUTomL1ywYCekPXI/8SbQQtDaR4pWOPwNumEx
 TQOJxiJMIeV+O7yD5fg==
X-Proofpoint-ORIG-GUID: mTQefKv48SnGgNql3XRx2CrH1T7S56F7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090003
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[65.181.12.250:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7494D4498C
X-Spamd-Bar: ----
Message-ID-Hash: RQR32UDBLXINBFDWO2LTGFMCC7TKR6U7
X-Message-ID-Hash: RQR32UDBLXINBFDWO2LTGFMCC7TKR6U7
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RQR32UDBLXINBFDWO2LTGFMCC7TKR6U7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Looks fine to me.

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

- Amir

On 10/6/2026 10:33 PM, Harshal Dev wrote:
> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> Kernel clients can open a TEE context and invoke regular TA commands
> through tee_client_invoke_func(). However, there is currently no
> equivalent helper for invoking TEE objects.
> 
> Add tee_client_object_invoke_func() as a kernel client API for issuing
> object invocation requests. The helper checks that the backend provides
> object_invoke_func() before forwarding the request by setting the origin
> as TEE_OBJECT_INVOKE_KERNEL. This allows TEE backends to support
> privileged object-based calls from the kernel-space.
> 
> Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/tee_core.c  | 12 ++++++++++++
>  include/linux/tee_drv.h | 13 +++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 30901390149c..a03a3d645dd1 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1404,6 +1404,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
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
> +	return ctx->teedev->desc->ops->object_invoke_func(ctx, arg, param,
> +							  TEE_OBJECT_INVOKE_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_object_invoke_func);
> +
>  int tee_client_cancel_req(struct tee_context *ctx,
>  			  struct tee_ioctl_cancel_arg *arg)
>  {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index f3c5e106d853..369c87ad0205 100644
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

