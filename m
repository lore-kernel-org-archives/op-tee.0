Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6988C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:38:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0E98444FB3
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782823094;
	bh=hjc+APBxG8BAnft1xBwXIOdKWJVGMl/z1UuFDPDGfwk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=IV5xZ9OJiThJv1FhLw3bLFxJ+k1ryEEGu4FTRlAKNjO/uqwO408JstF16qnowS9eQ
	 9ZejVQN29D900IKkZ7qvyxciSzWIj8g+Z/177ytI16wcoDeQC5CmHDm2VW2u1EslNc
	 1SuEjIDN18syFgBAClr+CYHWwJ2yIfpD2a5vwC4OU0CMR0LN+vkEMN9QfBSN/Ma4FW
	 coRuznVU8gvbxky5HgLw2QlRzVmo6o7FFeoU8YzByI3HFrQp6MOR635KIRCcyxWqfw
	 r7nweIj/Ae8aV7ONBhLGvCPvX9/nrUvAmGfA713Gt0bfcCx53PIGokDoH2WB6DRMN7
	 XAh4IMrLoBVcQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A60DD44ECA
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:38:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FsbzbzUe;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jRnCv8Vn;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mqBJ1611625
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4OYUFv598H0zTgYaTxiad7MP70D3IXkLu00sHk72TbM=; b=FsbzbzUeTWSQxnA9
	kJPqCIMJUFmj4GvpwwryZIJKRcy5rbWo34809alM0V531WTuqJpuNEpnV2QoFW8p
	0cF8pj2AeiEaEq0bMOuvc6VHejiI/+nZ+nE5Xj/bi/gQvlxtt6iyZ+FdHPQDKaUc
	RfvDKEiDFS12tBKAjqsnhorkqSGubivxTg+9+TBr7Wae3oGxa/xngntKkAo78ND9
	P0nyRJYj9WlaMliHyYpbcOefCh8tgTvvLL30PONEzLfFPSXWKzI+9r67TDc3MnTD
	i6SRoiuQ71TIJGrJMbITeyjrvRBh6cj2hRCq6NOq/XEx9ENPbhxUJm8QEF/Tx6EV
	nI/wFw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f441gtmem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:38:07 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bd933e15a8so173339e0c.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823086; x=1783427886; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4OYUFv598H0zTgYaTxiad7MP70D3IXkLu00sHk72TbM=;
        b=jRnCv8VnWYQpuF4Wk/ln6s6eIjuVhRBHiSHl0dYlvPSg/vtyd2XQmeebQIHSBcPYfk
         5zlmeDXEpyowt3tY9r7uvH7/UFfNElCGqaOxebauM7azijh4xaCrWL1rMX24KqrC0R2X
         HCcF5s6HTOAXLLQjKXMT9lnrfgSYiQyN2rByJ6OGjKHf4fsbpBscnKofsBRig587sg0W
         ZYfwJ30Zr9yh4OZaR5z9vdiwUXEPfRXI6aQgqrkXNuELtOJLCZ2Uk9Bem2L6ntERZtPg
         jNOdAvizsZcr1b3HGFAqxQ1IS0ex6uozgc1glOsbtD+Fbjh3h7eMyj5fYj6Ui27sWyMk
         QD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823086; x=1783427886;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OYUFv598H0zTgYaTxiad7MP70D3IXkLu00sHk72TbM=;
        b=bb+qASx6Wg893iJA6rYbDtt50ta/JkrrIJ4N1bzeMfLOG6Dy77aVOE4JQhr1gzdG65
         UUSSmcCg56KmI4pcmcGx2Fw6dLxLL1y7xbd2iKWqGFCst614DIBc/P/bAzjxEJ2tqM40
         Ls9/lnTuPTAAIVgmVuwTl8/A9tIliViPlynMaopL84S9ek2CVjz25KNioNEH+kZGk+Q7
         +1bv6//K+klWVBKpm3A7fxN3HcoOJTHgAj4SsxpzQkMaZueTH0zBNwNdGwB62aXFp7g9
         nlegIsFmh0avoXNP0TdhJbpziMGcIXgVWRoJD8SdKpjG+e0KMU4cgUrEVoTpaXm+3WPR
         1/6Q==
X-Forwarded-Encrypted: i=1; AHgh+RrqKJ7pTkFasqWd9FM1UhwTwTqrC7ZooVxOkkSSenhajEYbCBHXq4j9DqalhxXf5fZSukl7GgQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx93apkhTQnPwHEyLLYSUuaga99m0gnWMwBsT0SFYDeVAlX+uat
	yD8eHgIVrAi1Py8qVF0brIVnsWUX/GCIHciJal5nIaTGErgBdjcez7DLipZukbSqLDM9t9t5X37
	nuQET9VYZPyIr2PaV/5txQT8t9QQ9Tg/EIZbybJHfA+U+hcm4/6tpObdmG5+LjkvrcTsTZl6r
X-Gm-Gg: AfdE7cmQ55xqtLWftkp31xXmw0xkUB05uYUt8KmT3IIuQPhOend+dg+EiIe9F3TyfGq
	1b0XzUaLq98GqbNtr6dsiJk0Lzb//HijoHvYLJ31zQJZ6Y7RD4LrhbfmJTtW/Zo4ODh+Jl7XhpX
	uR/1uLHI1cwzPXosZLggJHQS1F+aH50ieC9TO/OUJ6TZ6WRANaOnbA1Q91/Hqk90fAbx6KKVH+Z
	nCV6O762KniS83C9K69UvZFnqolj4Chi9MC8FT8PYjWXRIA7WWbNZGPQla7lo80oElAeSzKK516
	QGME8kn/vkrT0v/hWlAXnuQURVlMec3Fxn3RrRE6/1T7PVHyzvDWnm3hR+nzrjEXGZII+BBTUWK
	4WfwH2mAy8egixrlzABs+SXofu66mfSrvIII=
X-Received: by 2002:a05:6102:5804:b0:739:64ad:bf4e with SMTP id ada2fe7eead31-73a3912c265mr460482137.7.1782823086349;
        Tue, 30 Jun 2026 05:38:06 -0700 (PDT)
X-Received: by 2002:a05:6102:5804:b0:739:64ad:bf4e with SMTP id ada2fe7eead31-73a3912c265mr460459137.7.1782823085760;
        Tue, 30 Jun 2026 05:38:05 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c95003bsm1081611a12.21.2026.06.30.05.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:38:05 -0700 (PDT)
Message-ID: <64e425ab-dddc-4221-81d3-3283e2961bea@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/14] remoteproc: qcom: Select QCOM_PAS generic
 service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-8-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-8-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXzIxk0f6MlfEo
 dvjmpMSHP/Y1rMcuCR4YCoU5+n9qUKXkCkYrGm+OVqbyry7Jvj1yvFocw2qerrkeCDc7ukayrkK
 nczqV9oLuKPiVJbZb7qPGuYW8nr9N6Y=
X-Proofpoint-ORIG-GUID: I-Qllnmwh5_tUhT3Sdo3invj_l9BKibq
X-Authority-Analysis: v=2.4 cv=F8dnsKhN c=1 sm=1 tr=0 ts=6a43b8af cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9LJ1SYc1tAtFajrMtPYA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXwdGwbb8cBsNA
 srvA52mLQIUqDR5yWVvzQMHxYiAcp+XkeJkJwUQT6M5d58AzM3buIFH1tv9jw5Qf35/jTxb67Wt
 K8GlLf07dl60CU+neHRoV5ZGGLbkJ1BxQrvl8O9GzFgHoNPZ8EOOiL6J61yoJUXcI7kJta7dnyG
 iuFEhfPsCgzlADKSUOA/q259qk/H/OzWDqkRMvpEOUVSCeda2g6hjUG3dYoNEPqJgpLJAOan/W4
 +6HruvPj1l1wqkk7rhdI/BV92/R6PH6X/Z4jMZ36k7FWEc/NG8eZH4DJST2Cx3w1I9wmxhBIlr0
 WnHenVqRYZgSFywH0lIQ6IB3p//vdYz8C9nk4n1Bw5EzvBxlPTIVE6AD3ra5U1FsPn1oCGr3Wpi
 wC085IqMWI4dvl4dY683heMEzMaciAPJ7qoTlGaGs8bSKmcdJr9gcy1Nqfz9P8nmYME8K3wLN3f
 tkEbtwZzCXYQrZYSPBQ==
X-Proofpoint-GUID: I-Qllnmwh5_tUhT3Sdo3invj_l9BKibq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[178.235.128.140:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.200:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A60DD44ECA
X-Spamd-Bar: ---
Message-ID-Hash: 7SULJT4IMFHO2CNY4ACLAPLMON2MAZXP
X-Message-ID-Hash: 7SULJT4IMFHO2CNY4ACLAPLMON2MAZXP
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7SULJT4IMFHO2CNY4ACLAPLMON2MAZXP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Select PAS generic service driver to enable support for multiple PAS
> backends like OP-TEE in addition to SCM.
> 
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c521c744e7db..65befdbfa5f7 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -210,6 +210,7 @@ config QCOM_Q6V5_MSS
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
> +	select QCOM_PAS

This is a NOP, SCM already requires QCOM_PAS

>  	help
>  	  Say y here to support the Qualcomm self-authenticating modem
>  	  subsystem based on Hexagon V5. The TrustZone based system is
> @@ -230,6 +231,7 @@ config QCOM_Q6V5_PAS
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
> +	select QCOM_PAS

Likewise

>  	help
>  	  Say y here to support the TrustZone based Peripheral Image Loader for
>  	  the Qualcomm remote processors. This is commonly used to control
> @@ -282,7 +284,7 @@ config QCOM_WCNSS_PIL
>  	select QCOM_MDT_LOADER
>  	select QCOM_PIL_INFO
>  	select QCOM_RPROC_COMMON
> -	select QCOM_SCM
> +	select QCOM_PAS

This is OK

_however_

It leads to a situation where no back-ends can be enabled

Konrad
