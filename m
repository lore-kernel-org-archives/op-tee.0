Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47D7CA0EE5
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 09:53:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 199034FCAB
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755078829;
	bh=ht1diEblsf5dN2e1cjhOK7qCFVmjDiqNwW826Qyw2Rw=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=WecCENWba1N/P1HSjBIKGef6K5XNLT5pLwct4bDHh64RkFVw54Xsjj9l4TJyava6L
	 uloqCniPr0LwUJBni3MPGigDy49ouO05Sp/SgOZGpDZnDLHpYRLF4ahoT4IO73l2Yd
	 9csaIjavrsNRUBxA/TPSddcEfGDxuhzgVK3EAK7Tmx4PXD9M2OQUIqN8pDI8kVGnCn
	 aBXaWnx6QQv0HHf5ybU73rpDPqQiGcZ7lBei+bv71jmZlPrPRnkVAE9oFrZSbF+qZ+
	 YhGMh7ucAPOvO4s9xQf/PkGTEXeUtgB+rZ7VGDE8HMXq/vtI+O7ICHB7dZ6Mz6mpjv
	 yuMu6g03VNBXg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9DAEC42E7A
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 09:53:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jv1gb4ke;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mLx6026045
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 09:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0MpY81TRuNNBDJHPaklTYFI4wsF3yIvIsNOVJLMUbFI=; b=jv1gb4keblqk8Oe8
	0IfDMzKm25CeMTPUr3pF7EbmmsPsOLRWBpI00RvmXRswzIs7e8YQH+a0cRyDckIF
	LA4ZoN1AZjOx5pFVY3yJK4jw/QU8r2bxYcFvbcGdFiorQreKFUbhT07kl9Gi+G2N
	f55HidrgJkXBV5yJUT8BuXqNrt4c5PTtAZP+JnoYr5CYrsGIvfgmUEzGc4h7rmVc
	/DqajI7vnQRNFloz+QUnWILumdJbaJEZiGsizqio23jkwNZSN4z803BRoqhfjI79
	Wes3vpWBA5aKH4D6XyhjXc0Xhyb1iJFF9YTwD+0giYsH3PMGy5fLkWA1jfGrVSci
	OBrGMg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9suj38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 09:53:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0938f0dabso18149211cf.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 02:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755078813; x=1755683613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MpY81TRuNNBDJHPaklTYFI4wsF3yIvIsNOVJLMUbFI=;
        b=od04p6lUxOD7jwWHaN2RZlz61HApItJjVLfZecwUDzZoS763ShVuRGtuQqBcblOBmB
         2j6iHRO2fSpaxgOrvredtnRfhXjznyubBbYlOdmWqkZIw5LG+NJtZzQ2nfB8U4ArHERM
         J7PBp6zO45Ko9LaQo99G0/kpiFIyBv30Cl9FqTGdXgQaryOvxSGitX+CqAPyUKwMhcQ6
         yC/o0gccepcyVR8Bo2a7nsntvcLe4/dI2W6tKIZHs6HNTQYI+thSCvVRlWWlvyYeGLhe
         BhJosQBFwaUh+kSb51Lo2EZ4fZOch6WreXou/KiTUnQ6bAAbo8/3zDhLI0MN/U4Hpuy4
         nCQw==
X-Forwarded-Encrypted: i=1; AJvYcCUYWThjo4Ownv1r9ZMe3tNBhHOwKlgs9QB0TUHme9/pF76XyYCmfMympu9MdyCaDQLFPwTMGBA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzq8+/IrR3GmbVNLCfyJb+kGst/aDkmQ3ACxrnhR0VeO5UEsBQ9
	RZk2pieabePFNbja0ZHb7zxl970e0hj5aTHin1oKsunk7QQgfyPH812heLsrwZ2R2CME83Au1jR
	sacIMmV6nw0/hL4cmQrquEdkc9ekg7wEYjXK6BD74CMEmLfmwtZSMO4NKDw8tsUX4EdpfAMvA
X-Gm-Gg: ASbGncvJjDEv4SNmP29hm5VBR7bkl20QhB3NxhMDn4xNJPW+3f7uvssSodEm0tIO2Pv
	cKk4j79Sbgw6Sb2JZpdImc5D5e9uT+nCFxlUiw2zNReaOH28h7srF7J0qJ1QQ/H7uTVF+1dZmTq
	PCFfmoh57LDNIjfckVzYswTJUm3SrPjCH/oxWochwY0J0a2yVHyweR5UPPQezdbzRYM3cfES8A0
	/WAEBWQ0IxjUR5WVXbcawNo9WE+SOOIpHCneVSo8jDtRzwqsuP6lsnKg1KMu0FGVQo1MkYz6/ey
	iaQ87OAd5EoknsXh9AAuhutMnk+fpd/BI82pOsmKlb3s93CgdNJI88fSL6YkNOiG8qzxGynuD0Q
	5RYUsT/uUoa30+QzZdQ==
X-Received: by 2002:a05:622a:143:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b0fc6f5abamr14652391cf.3.1755078813020;
        Wed, 13 Aug 2025 02:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHL9p/V8kgz7pgbQLj/2LkDGUoYpwD7WnZTmIEKh4brnTqRmXHLFYJ1dJDBYqoeMLjGgWK2g==
X-Received: by 2002:a05:622a:143:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b0fc6f5abamr14652161cf.3.1755078812394;
        Wed, 13 Aug 2025 02:53:32 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92a2ec9cbsm2254739566b.79.2025.08.13.02.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 02:53:31 -0700 (PDT)
Message-ID: <f015c644-1176-47b3-8ce2-2567e529081e@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 11:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] firmware: qcom: scm: add support for object
 invocation
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-6-ce7a1a774803@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-6-ce7a1a774803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689c609e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ZC-EX8TnQz-G3DLW9GIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vy-SnFgyEFyckV6hGKvX66ogOXD-iD8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXx7+VzJ2C+wm7
 sBomOMmfkH71+Suo1VP6lXi02mp3sE8GeHs1jqCHviePo8EY4uDwWLXkOtY+urnbqMx+HOMzcvC
 NmucmNlvWsgMYUBbvICpZWJ0Shn5pKPYXADXWLg3M/u74ojhQlXs+qgEXPxtsqMYAUK7vaJ2k5H
 LVjubXIljuHezCy0DahIWqz6MC1Pv7pl0djhxLBy/qDm6sty7s+Vkc5F8Dfw//pHg09qbRo0/8+
 7sbhmJ9mJwU3i6F7qvfgMjjiu5821xiTdBNpim5SYsqUj0OghuTtoGgY7eMRKJH4ApcYQtWiWAd
 jJmq57zLK0CEOpuyYJdNWaKR1Y6YEAQWtZtbUD/ZC4fzAUvtHwp4jSvGjjBUX1oe4ApviOERkL8
 NuDfScOG
X-Proofpoint-GUID: vy-SnFgyEFyckV6hGKvX66ogOXD-iD8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1011 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015
X-Rspamd-Queue-Id: 9DAEC42E7A
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.198:received,205.220.168.131:from];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: WGW4TN7XUTM3MYKX33A2HWQA6JXPKNWD
X-Message-ID-Hash: WGW4TN7XUTM3MYKX33A2HWQA6JXPKNWD
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WGW4TN7XUTM3MYKX33A2HWQA6JXPKNWD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
> Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
> the secure world, accessed via objects. A QTEE client can invoke these
> objects to request services. Similarly, QTEE can request services from
> the nonsecure world using objects exported to the secure world.
> 
> Add low-level primitives to facilitate the invocation of objects hosted
> in QTEE, as well as those hosted in the nonsecure world.
> 
> If support for object invocation is available, the qcom_scm allocates
> a dedicated child platform device. The driver for this device communicates
> with QTEE using low-level primitives.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

[...]

> +int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
> +			     phys_addr_t outbuf, size_t outbuf_size,
> +			     u64 *result, u64 *response_type)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_SMCINVOKE,
> +		.cmd = QCOM_SCM_SMCINVOKE_INVOKE,
> +		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
> +		.args[0] = inbuf,
> +		.args[1] = inbuf_size,
> +		.args[2] = outbuf,
> +		.args[3] = outbuf_size,
> +		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW, QCOM_SCM_VAL,
> +					 QCOM_SCM_RW, QCOM_SCM_VAL),
> +	};
> +	struct qcom_scm_res res;
> +	int ret;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	if (ret)
> +		return ret;
> +
> +	*response_type = res.result[0];
> +	*result = res.result[1];

These are dereferenced without checking, which will surely upset static
checkers (and users)

I see that res.result[2] should also return some (aptly named) "data"
which you handled in v1, but dropped in v2 (without a comment AFAICT)

Looking at it, we could probably wrap it in qcom_scm_qseecom_call()
which this seems to be fit for

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(qcom_scm_qtee_invoke_smc);
> +
> +/**
> + * qcom_scm_qtee_callback_response() - Submit response for callback request.
> + * @buf: start address of memory area used for outbound buffer.
> + * @buf_size: size of the memory area used for outbound buffer.
> + * @result: Result of QTEE object invocation.
> + * @response_type: Response type returned by QTEE.
> + *
> + * @response_type determines how the contents of @buf should be processed.
> + *
> + * Return: On success, return 0 or <0 on failure.
> + */
> +int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
> +				    u64 *result, u64 *response_type)

These should be aligned

> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_SMCINVOKE,
> +		.cmd = QCOM_SCM_SMCINVOKE_CB_RSP,
> +		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
> +		.args[0] = buf,
> +		.args[1] = buf_size,
> +		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
> +	};
> +	struct qcom_scm_res res;
> +	int ret;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	if (ret)
> +		return ret;
> +
> +	*response_type = res.result[0];
> +	*result = res.result[1];

this also seems like a good candidate for qcom_scm_qseecom_call()

[...]

>  /**
>   * qcom_scm_is_available() - Checks if SCM is available
>   */
> @@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	ret = qcom_scm_qseecom_init(scm);
>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>  
> +	/*
> +	 * Initialize the QTEE object interface.
> +	 *
> +	 * This only represents the availability for QTEE object invocation
> +	 * and callback support. On failure, ignore the result. Any subsystem
> +	 * depending on it may fail if it tries to access this interface.
> +	 */
> +	ret = qcom_scm_qtee_init(scm);
> +	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);

This will throw a WARN on *a lot* of platforms, ranging from
Chromebooks running TF-A (with a reduced SMC handler), through
platforms requiring QCOM_SCM_SMCINVOKE_INVOKE_LEGACY (0x00) cmd

Konrad
