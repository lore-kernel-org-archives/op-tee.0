Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB6CCD37AC
	for <op-tee@archiver.kernel.org>; Fri, 15 May 2026 01:23:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 314A84371B
	for <op-tee@archiver.kernel.org>; Fri, 15 May 2026 01:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1778808228;
	bh=xCFPu1zNnERScuds1BA/xDI7JtrElF8fFYPNfBb474E=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=cC5UlL8z8YvVm6eXAcN/T2pq2A9IuSh2pkLzwN/3F4K8k+gFFsWpJukNvwU4oYjyG
	 aJklj/Ka1YgiPbHwq91R8znmhsaNfIAm+5DYLDP8Y2CD5X043os50/hp3DtC8fIhZ/
	 m/+zcBgufib3YbyYSFWks5lsAsI/YiBGQp6p81s8evB2t1JpoD5vA7c/9u0c9jcusP
	 FgYuGYuhJ0rU9EgEXoWkBEGmLFZRtS8GtGUr/eP+4ndkTKtW2pz1pIkLa+AEpfWhkC
	 bgItGgikseJsfxgrjM8JfeSwHPgVfaB1xNX7E9wWfoCCrWKIOppLrLFe7F/Iopcd49
	 Y2HoJm/1Nhrdg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C2C314371B
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 01:23:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j56L0qm8;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZbBVetcQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpSor1847980
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 01:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GbRyF0yHF8n8xfJ6kWgsPZHepfaFdKar74Yr2tZG1yo=; b=j56L0qm8BMNVIf3Y
	gj0eN+2W9sAi7aK1lwSHVZyd6JP5ByEv6z5prnc56YDYmj8uOOEsaDXUES5YKYE8
	pg9wboQvYOSh0cqXAKGDP+AarJmDlnFzzM0RTVCtPEHdRrR7s1QmF+NvEYkx+/AV
	PIw8RUu24tQ+5msdyGrCVdfW38BhgcDo0OQIOQcyWvLjwvGbTHT+ENVW4kBM71wI
	akHsAWXi3Fw5niBoyqy0VX1/t48HK8j4xr9DlYMjWaK5VKSRWh0/3Pd3Vo+0Rnon
	sk6sy/+JdgOtVwfwQA3uH3V8CguBN3rBDWbSz15venb0a4S8gpn7k7C0qLCDC8i8
	N1tPvg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1t103g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 01:23:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so323698b3a.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 14 May 2026 18:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778808219; x=1779413019; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbRyF0yHF8n8xfJ6kWgsPZHepfaFdKar74Yr2tZG1yo=;
        b=ZbBVetcQsOV9X87pOaTMxAlU8uBIImM/Y9D33DtPE7T+aX2DFcTt9pvpq7o06QHWs9
         2EE4cEEkawAV09Br1Dvw9K4H6HQ2MZsgQTmpgwFiNu3N/Q9xcVEMiWNAKe0a8+4cBwg8
         eb4eL1R0YzXqZSFyKYgpuP6HFkxzixSAllHkJVKEn5cw8+fBGzZ4jHYkmMM5UGmiMgGF
         QC80mOLvzqmRyOCByLnRU5HguA33PRWrmym/pAjdRBKisexT5MPmQYhCKd/OoYDh1rfq
         yFJ8MesukKqWAw8wXQ62boLF2Y5jufcRgvlOrNhm068BOmixQSZ+K5TgqGAfR1x+2kj/
         BlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778808219; x=1779413019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbRyF0yHF8n8xfJ6kWgsPZHepfaFdKar74Yr2tZG1yo=;
        b=iL8NEy6iINZQWmcr9gXAj2vzk/O9KKCBeH68+1iKUofmzTfYuZHCQGgoccP/B3l1b5
         LrRIy3TChH+m0e1KKC0AcEFlQtNz171b0/GOCCXGWi39LNWdbI/GI53WzQSXwp4fjz7f
         1fcZnnnJleYcYVcFmdWROzPmlj0Kyb15n8KWzMAGdow2oFYfpe6iOu1cUdQK8FKBZNt9
         aNt4HNEBstti1Q5nLxFdioMjRNKBSqxq0r2i6sxNKSdRe37c8cfWz7/p+bgQuMewuUhM
         jhDc9nKT3pTqYi5X9fDvkyFWO2X2oqmDcORIQAhIGczswtR+tFsZAOlnujVr3+FvtNqq
         0rwA==
X-Forwarded-Encrypted: i=1; AFNElJ/arw+tb/qvOS91tYWNkKpyf08+n869hQNEbgI+gLwxMEoOfH/YIpdN5GQAuurtDLK3f7LvYek=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxHOEHoc2QBjyKBpM/0Pg6rTkxM8vmDCYMFCd5V9zVgK9iHTf82
	uATyMnS5+N4XePoHugq83mA3dqTWlkHEO0tb5394Qq1vAGiCgR66kco7AHI9rtzyRRnZ5iz+MeH
	1oQynDS5Llu25PlMpxIjeIIsg6NgV4AJGTIlP5t7bwp+2N0z1j7+wGR5MBPlQPzSZLVYYz8Q=
X-Gm-Gg: Acq92OEW6/gOeD7GcKBssDshpXC2eLRu8dsljazRBxCGAN7HPB6rrZesTz6zECLwiKM
	CL4JIOhmrTF7Wa8IC6dS6uI8MyWbyrqW/fUDxN3xtetpMfJfV1q5vFKLt4vubfo7URVmDQu88AH
	8Ygem0M56gok63ekQcR1v3McmZbUEvR5FxKDYgnRb/pzvePPndM8qA0XJQ8H2WdHHSBTXRszZ28
	/S97d7i2swc3X/zcKtN0bapRDe9ouX+gCiKe7mhfFkLcBfpiLEReT9E+nMZhCSHlbDMY6f8y1HO
	LyCap2wHrG+b/X001OuJwP1/aQIdls4W8abumWMIjR+pBmwcPD+ebz+RlklK4omQJUg+C3Kr6Ji
	ZSwBJe3Wh8Dpv9y6H1s1gV8/xFP8Nge2NhUtRY73aN6u9cy3g9AloaIkwpMPoycevzkQtyQVyds
	LO3vqKm1CspmOKy2im14E=
X-Received: by 2002:a05:6a00:3028:b0:82f:2aaa:c14c with SMTP id d2e1a72fcca58-83f18e770a7mr5239993b3a.16.1778808219192;
        Thu, 14 May 2026 18:23:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:3028:b0:82f:2aaa:c14c with SMTP id d2e1a72fcca58-83f18e770a7mr5239976b3a.16.1778808218670;
        Thu, 14 May 2026 18:23:38 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19663ff8sm4062970b3a.8.2026.05.14.18.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 18:23:38 -0700 (PDT)
Message-ID: <6f67ffe9-41ca-4102-99be-440356ba672a@oss.qualcomm.com>
Date: Fri, 15 May 2026 11:23:32 +1000
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
X-Authority-Analysis: v=2.4 cv=D7Z37PRj c=1 sm=1 tr=0 ts=6a06759c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=2fb_BHWLsD0z38efADMA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAxMSBTYWx0ZWRfX10tuRXw9woKJ
 tx7kEDlLxz8hmyQVn9HJK2i0PKqhCB3GvtFPJvMBsRv1YzKXzVVj8XnAoFeEQH5orZH+ekm8sKW
 dxn5ZbsrbSRDlMEaQ18+z6HKt8xLb/8bW2o4+Obrg61+0bQXpSbSbqqP6LOjZdPoI387U2KEooA
 C6/y1VdD3nZkO2QpMrRrX+XSq1JV4vcW36wHeXOMrPZ3vs9OfK4CgYVPI+RU9E3fNdJw3WkVl0Y
 FKwWFuyWasNdyNoiks3eIgzs7th+dhQ8LdV45oq55F5pMH98RsnpQGa9xs++F3ExZpyYYaEsUVC
 YZIUCJMcUpJ8grmbdtB9D4VVD7hIORMCG61czdBHPX8ldR8ori8y3YmM18FgZjVJaQZTHniMejz
 mXL3b2/br2nCj50rHV+FshlNMlYknzatZR2XeY2MHOlTBiGJjXB1YpewEcc0VnTjXqp+bZL2nGu
 k+NIWOXAlI6CXsSqb3A==
X-Proofpoint-ORIG-GUID: v9hRedZnV_laqx-Gu7KkEP1XDym3e-E4
X-Proofpoint-GUID: v9hRedZnV_laqx-Gu7KkEP1XDym3e-E4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_06,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1011 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150011
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received];
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
X-Rspamd-Queue-Id: C2C314371B
X-Spamd-Bar: ------
Message-ID-Hash: ZEABET3XCYD5MF6ONHGNEIWSWDPOOCXB
X-Message-ID-Hash: ZEABET3XCYD5MF6ONHGNEIWSWDPOOCXB
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, me@brighamcampbell.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZEABET3XCYD5MF6ONHGNEIWSWDPOOCXB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi,

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

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Thanks.
Amir

