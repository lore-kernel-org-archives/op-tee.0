Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06DDCD4F3C
	for <op-tee@archiver.kernel.org>; Fri, 15 May 2026 01:32:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DE943443F7
	for <op-tee@archiver.kernel.org>; Fri, 15 May 2026 01:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1778808726;
	bh=usEwnKkEaTPE+yU5TGR0oURw8nv72W+T5MSwsVZgYLE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GCM6QZekE2mwmeqOrxqzjlUeliAjnX/x/gatXgXY2OAV5OpKUTYB9LE+HV1xu84F8
	 /nyc7byfE1qzQXbB8IONzfq/W+Btk4IGRPhdEL2XwxmebVcmHnexwmVm02lCeFWSHW
	 0J8Mh3hv+rL4Vi18FGyKru9yEEbj3HhxJ0SIN9dt3c49GmMfHpdw0rXbD6IVZLh3hm
	 gg4lbMg3k6ITo290QHKL5kf3McdaV9yf76JB3f20DUbVEuqd0p31aZeS+CNK64wIlT
	 QJ0F7zeTzmL5SelWprpZ8u1EvD6sg74BBiKNTLoIsvfYYjI0ReBKlec1NSyYuwdg0D
	 rHMRgoJE71Pug==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7F777434BC
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 01:31:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cBhnEuQ0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XeLJ39vQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpaFR3198067
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 01:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HxJXpfYBS7mpaWwbnqYYsS+05m4PCWFY64z260Mm9fM=; b=cBhnEuQ0Yie0TnAK
	ERP5nO11N4a6rv1v443pUEQeOIvJNTeSB+U/1IIHjNRqGwplsJegcwpCjkkTDewn
	2wtiyff9ZRDB0oC+8HLS/V0GBHVksQdQnUHzhioXaNopAWQoi9lVInwwdYdpcnQm
	+gq/+WiuOlqzUA+vofQPAueWWx8YHQZwSVU56+OQLrG30Ao83W9tthtIWeYVNGU3
	IFIYNpFW08vYFTxBkz7bAomDrDQMoSLF8nrhtbSJIiNlbU6kRq9/na80VYGPQt+p
	T7Ep6Xgr7SgZ7pUiK8q9rudAGVn3fv6de9pX1Chx0QtyuatsztnI+Me50mwrQ1Sj
	Fto94w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1q91t8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 01:31:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c81086bf930so245214a12.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 14 May 2026 18:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778808717; x=1779413517; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxJXpfYBS7mpaWwbnqYYsS+05m4PCWFY64z260Mm9fM=;
        b=XeLJ39vQgBRi2tx1NhzfRaMrpmlGRQviTkK7xFMyfqnxHBr8nId+jJRDDXLz/8E6y1
         kee2Q7IL7+1iLd/2M3sj3CyK385k5OmUitBog3zFwAga/TlAb3r8MRzAmzGH7LvVga6T
         RsnTaCaHJx2V7c+L7gBbsmuS7nNzEJq/rS15OTa8nBfOIDGI9eD3mXeEXMb1n5EMV9ug
         MbhTW90sYhHXDWx1Sz+i9AFUFxVEV6+H0Ag/zukEqkYk7PQXpfG21NmXNgT+EgL+s1CU
         NaZ2O36BUxe1jqglDur3ZOiVo0M5U5jQxBQ6U7FoKkP9B+ze0FwSON2RTXfYkZSPFvAC
         H44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778808717; x=1779413517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxJXpfYBS7mpaWwbnqYYsS+05m4PCWFY64z260Mm9fM=;
        b=L47BKVL4SgYf2pSbqJyRQQkD/rcn8nKGljN9HYthHaMn6QXTJ+ID1zLVRcXOgNo3cJ
         YdgHkTSuYy+cXPpUTM8mTpLCUFlhbLWZMpQbvdkwEThhkqdsdsvLOjFNuMmH08bg9Q7J
         EozrvQ9wUKOpwV6oq16K/Pd3BQA8HYVWp0lI+ufM8VCpUyi3MApwq5rxVraFy5MQrtmd
         3fZ8ozfo2VV6ltQIEaBOLKLiGR58acDfW9Z0mm/qNSbIrQ8/2z3VNf8shH6nJyRjq6Q8
         4/DIR++UtARclnEzOwXHnEKyFunriQLKwFOvPACQz7yV9W1flTMIj6u75U7hTGWGmLlK
         K9IA==
X-Forwarded-Encrypted: i=1; AFNElJ+p2ij4ekMvoPCh6eS4QlAW5QqCyL+9asNFJ6TwX0K9KZtTO/e8pedAaXvRJcFnn0YCgpgCf2g=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxwUbGFuXr2HpfYkXqYvQn/iLDR5kGqJq4xBSEo1WHqHr1CV4d+
	CJBGO/BKhkuISsSm8DDjM9l390w0PhhoFvMIb8ltlVUoIxie52kNBdN8eLzee9lcxz7uC1ay6k7
	zUkpoStwRNan5zOshvdxr2TdbSnhRSIjDIlPI9ghEVKT6v6BBTcCFQFqBn7960ArJzUI7hfs=
X-Gm-Gg: Acq92OFXDVkpmKZtDEkNVj4pzAMCI1isae+nAEogVA0QBiPliLVSHgx2R1jAuw6OsDj
	p7+PAlBtzbXjdEAelk3TuPBbX6QrHsAaey8vuZGyfc05v6dk4DR2twa7jkQJzo8S/kyh+QlzAEJ
	ZKoTMCywMRLsL32i6uiX9d0ao5NxDDvmQG5N9MqgGKXGGE5Au/idmD3CzoQc5OR7lLvaQXjkzHB
	0T84u2reyRhXFMn6QEv5gGS6UBLiXLtptJ1dQi6IAaVZfN9RTB3Jvlea/G8byj7NKe7jK1Npuqo
	QvjOSznW1DSr4iey7EamF6xWdUuLtoQczeN1Qrr3kZjqnm1vFNiRi4vmGBwi+DtAHgMgAj/++uk
	QanD/bwvoZ4TSUxMvuSwhz3gbyF94FP9P6bkNPNzV4PS3b/IYtEOf4+CShF2IPi5DgpojXXCJYj
	8jmKEgWTyTQikA+nJ8hZs=
X-Received: by 2002:a17:903:2ecd:b0:2bd:3c21:a053 with SMTP id d9443c01a7336-2bd5283e0c5mr51230095ad.24.1778808716747;
        Thu, 14 May 2026 18:31:56 -0700 (PDT)
X-Received: by 2002:a17:903:2ecd:b0:2bd:3c21:a053 with SMTP id d9443c01a7336-2bd5283e0c5mr51229835ad.24.1778808716140;
        Thu, 14 May 2026 18:31:56 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd7e8e5904sm10360535ad.64.2026.05.14.18.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 18:31:55 -0700 (PDT)
Message-ID: <8182784b-b6c2-4136-af8d-3aea4f5a4662@oss.qualcomm.com>
Date: Fri, 15 May 2026 11:31:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: qcomtee: add missing va_end in early return
 qcomtee_object_user_init()
To: Robertus Diawan Chris <robertusdchris@gmail.com>,
        jens.wiklander@linaro.org, sumit.garg@kernel.org
References: <20260513091031.145826-1-robertusdchris@gmail.com>
Content-Language: en-US
In-Reply-To: <20260513091031.145826-1-robertusdchris@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: e3IULs9XDdPMm1VxlF_vqWIAnRlCbAkr
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a06778d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=A39jgTEGnKEs4j151ysA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAxMiBTYWx0ZWRfX7ONl8uvdYn8T
 rxNiZjlT0huARjroPeUNMXyGzKqE7v1wrpQJtQvjnhr33CoYsJsstQspjzUZM6+ugdDwtI6ASku
 y+6DC0Ec2RBFelL/yasRMxP0K6HIWjt4+5jnmrEtv846rk4ySKUtQRfZ8AvcApnNjGOuJMsDuhJ
 jd0qyF5HTAsxMi4bzH0D+66fwiMXj5Mh/1El6ZuU2GpjQrLX5JsHRlLrvuaqUGX/LCh8sqJXFXz
 WVBMAc8iV67s6cbcXaY6BYNkHG+wXG7T61nHWzKujhzThQ9yyTz2A1+NoF72B/hDdiTnRVd8wKh
 mKNv/qiDwMKJNDpizUjMg6+xVLPEqcos1BuIDsK5XO69jucQei1wJJFFbw7Ai1s2Nu6ESnx9xCO
 ZjDVusafR6pgecZQvTRCdZqtxRH+BgeUXGD3oMcE2AxZy3LPlrOA+BZA98Buy1FPAY2NAp0lZR+
 7sqqunRLlujMbJnwKrw==
X-Proofpoint-ORIG-GUID: e3IULs9XDdPMm1VxlF_vqWIAnRlCbAkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_06,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.199:received];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org,kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7F777434BC
X-Spamd-Bar: ------
Message-ID-Hash: X2FD44KRTD4XO3PUYKLOBKUHINJV6B2Q
X-Message-ID-Hash: X2FD44KRTD4XO3PUYKLOBKUHINJV6B2Q
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, me@brighamcampbell.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X2FD44KRTD4XO3PUYKLOBKUHINJV6B2Q/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi,

Forgot to mention: how about using a break instead of a goto.
Then feel free to add Reviewed-by.

Thanks,
Amir


On 5/13/2026 7:10 PM, Robertus Diawan Chris wrote:
> qcomtee_object_user_init() is a variadic function and when the function
> return because there's no dispatch callback in QCOMTEE_OBJECT_TYPE_CB
> case, there's no va_end to cleanup "ap" object initialized by va_start
> and that can cause undefined behavior. So make sure to use va_end before
> returning the error code when there's no dispatch callback.
> 
> This is reported by Coverity Scan as "Missing varargs init or cleanup".
> 
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
> ---
> I don't have the device, so I am not sure how to test this change.
> Thank you.
> 
>  drivers/tee/qcomtee/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> index b1cb50e434f0..901a31e8201f 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -306,8 +306,10 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
>  		break;
>  	case QCOMTEE_OBJECT_TYPE_CB:
>  		object->ops = ops;
> -		if (!object->ops->dispatch)
> -			return -EINVAL;
> +		if (!object->ops->dispatch) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  
>  		/* If failed, "no-name". */
>  		object->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
> @@ -320,6 +322,8 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
>  	default:
>  		ret = -EINVAL;
>  	}
> +
> +out:
>  	va_end(ap);
>  
>  	return ret;
> 
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581

