Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFA3CA0EE0
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 21:38:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1FDE14FBCA
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 21:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755121082;
	bh=ccjfO4/u/lWDNF3S1R9u3rjC6s7tA1lPQElrO9joQz8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=F7D0/Jc9D5/WsJa+PlYwfry6E49lO75LzQrhAfXEu9tmW4bY/j2aVTTre6KuMx7Xu
	 E2AfObmAyNEdMpykVOSNrZj+5VovDgaGQxwSHwd1fy6CYg7WBmflZSBfTP31X6KKTJ
	 AHJZ6r4wjypG8uqwHfN/MQNXa3jYnnbioIPvozu/bCxJ2CV7DeY1gJ1eSbm8tO8Vre
	 PiHc73NryPNR9xjY1badFmfvAOXKSlhNnOW51nr1vOdJ/+1Ip/xtuvsoBhuiv4Bh5Z
	 my9c3B7GBzvNFr/gtsW33FADYeHOkiMXDKhkFlJJbQL1chqsV8BJxAuyXSwEKG79jm
	 +HffLnRpWnFxw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9F6B042E7A
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 21:37:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cf01cekL;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLfwO002874
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 21:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+SndjKr0RXE6OvRgCGGjccbf8K/ICQkhBHCI3TArlkI=; b=cf01cekLIKKmp6W9
	Q/KiEcVSMrq8AYF3X5UAHRYpvTK1X1DUORA9hux8y9uPE16/4CYrPgxKaBlLS7Yt
	nu4uuJGy4uEe0ZJA+FxLoQaRnAxi+rROX43B20wRy5W/TI7G92K0GbK4nPxZSO7h
	88vZpNMTG9DLSNeD6RzLLu6goYg2RtxJIrvIzGZIS8aZzL36z56spkA+iJy9APXr
	pdUvD1/tM+pL076SnTHA0TS58l0s+JVc+wkln+ka4tX8MCVy0dsINtixHmJUvP0C
	OlxTaUoYFDF27xosid1bq4nfJT02CtZEulMGareqAO0apCpLC1Rs4LUgsAyWMnKY
	mSGE0Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv5atk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 21:37:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244581950a1so2325835ad.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 14:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121066; x=1755725866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SndjKr0RXE6OvRgCGGjccbf8K/ICQkhBHCI3TArlkI=;
        b=hfZr+ZcuqU3UHjBB4KJXOg37Qkr8VpmSQQyA+2BQ036BqrmB2KI2pnGhdJVwRlxReH
         lT2eHFcpQVakvAl8UdyGqR+dLvAixtoSjmiXBF+4YzfdelvxKzVfdW2hz9zBWdN8Duxe
         rbgl8YAkbXFYKzFVcK79HBebmTMlk7mfliF3Lk5AmlWx0MewH7BstUbPgcGUjOz2Auag
         seu5uGrZj9BzUVGkv03pLeByFoNxY/fCHOujer3wKSiyXB99Fc3v4pYq6KUOxaa540g/
         nUauz0tLzlZZ50V0kyNj20eSI2xSEV+3JsMAsx3rBde0AEgp64W7ZHqJCnkXMuhgrkDb
         ZUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtiBzDyhZv7tnAIzP6ssXUFOHxwBTuJ01W0L6kmrBXD8sSviZcd0n2lHWlC388NKOYw+CFiTA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwPO4o26dZtg6ivZ1K6WSYip8hfGzqq+D5RWNTgKTfBN0dsj8Fe
	S6XcQ6ZAi3Bbeqh/fBgYDW7TU0xTQyesMDYj2P0lKuf4vxHfuvNKFE8V/oNe1ne7dNP6WHYC9G2
	AUBHxkNxTkAxKlUj/duakkXYt5HfKusTTLJEKsx0JFtB5ayCMg1/R2J0UzZdrgWVtANwgJP4=
X-Gm-Gg: ASbGncvALcyuJApM2u6GEI2nhFuYuYLPrT22pSzb1in2qdp0fRLX4zK+JdAphEOGY14
	+B/JjE1Vx82yr010VN76SPT+a1ISJlqiaHbEn8M3znPM6Y7TqDwkm8cXPNf9Rxq3BajHcrI7K7d
	iFYkM0+j9lBaVU1TSloANQ2H2J5AGtoEY5z3C/OvEyvSiyiOtH6moPkbCTgbCi/I3eUQPC7bOF0
	WkCvG1dQTehDqUJlFM6DrxqOfh9vL0mbYsmhOl2GDdARb1ZzJY2qgllP1CH41ntxmwlN8NE+D+5
	57gfiZbsKHOsCRaVXab2Li0K7Wt9wF6s7fGuLvQT2h8K3I/ttwrb4dwveEjua/EJqN2krZsaoaM
	fnPrYO1WWcGyvS5W4gU099w0/A6v1d85aAETeHg==
X-Received: by 2002:a17:902:f68f:b0:234:a734:4ab1 with SMTP id d9443c01a7336-244584af4ffmr8494825ad.3.1755121065294;
        Wed, 13 Aug 2025 14:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuzWbzDav9fzDkocxmSvr5IQCdvgg5HSGiPWY/6Um64YBLDMk04VNr0wYVwa0mHQaKsHAjBA==
X-Received: by 2002:a17:902:f68f:b0:234:a734:4ab1 with SMTP id d9443c01a7336-244584af4ffmr8494365ad.3.1755121064760;
        Wed, 13 Aug 2025 14:37:44 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232578248dsm983697a91.16.2025.08.13.14.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:37:44 -0700 (PDT)
Message-ID: <a93b9788-92ef-4b5a-89ca-7e7733697eed@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 07:37:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] firmware: qcom: scm: add support for object
 invocation
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <f015c644-1176-47b3-8ce2-2567e529081e@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f015c644-1176-47b3-8ce2-2567e529081e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689d05ab cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=nTCLsnt1AoGLxjTXAKEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: gegJGPc4yIJAvvU9K5xOt8s5xKckkrx-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX6ykZt7j+ewv1
 sXS1gBBcZyJywh8IAAeCIu50v1GlOeOsX8qF7MP1jVmFaGKz+CXy7KzFeqq8/oxoiKdb50SW8Ri
 pi5JFC3R/7oqe/p5MKPRVB/AvDxh6HqoRZJpwvselPU1SAn+kjgWwPmfnU4NlDAea9I4e71n2Ao
 fOc72uO70rDS91VbaJuuO6fOXTbNMpNJrhnlIKoZnEX/ETEy5yLXmxGsupDkg+ljmoymm89hRCm
 gZvgTqORCd8MY3HqoTpvFFlXJm2cBeB5W9pf0MkZC23tTxFIYQciUmqzR4cHhzivIjsgIaum5ie
 Q5yIbkQ4JRgtcZUK3an+eDM8PCxWoD5qBNf9UHh1zpbqj4AXNXdH14HUbGK02bKPgWU8GIQgRhB
 IjOEVQdY
X-Proofpoint-GUID: gegJGPc4yIJAvvU9K5xOt8s5xKckkrx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025
X-Rspamd-Queue-Id: 9F6B042E7A
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.214.199:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 4GIG7JFSW7YQNR3FD25IO7MQRBSAAULE
X-Message-ID-Hash: 4GIG7JFSW7YQNR3FD25IO7MQRBSAAULE
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4GIG7JFSW7YQNR3FD25IO7MQRBSAAULE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 8/13/2025 7:53 PM, Konrad Dybcio wrote:
> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>> Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
>> the secure world, accessed via objects. A QTEE client can invoke these
>> objects to request services. Similarly, QTEE can request services from
>> the nonsecure world using objects exported to the secure world.
>>
>> Add low-level primitives to facilitate the invocation of objects hosted
>> in QTEE, as well as those hosted in the nonsecure world.
>>
>> If support for object invocation is available, the qcom_scm allocates
>> a dedicated child platform device. The driver for this device communicates
>> with QTEE using low-level primitives.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
>> +			     phys_addr_t outbuf, size_t outbuf_size,
>> +			     u64 *result, u64 *response_type)
>> +{
>> +	struct qcom_scm_desc desc = {
>> +		.svc = QCOM_SCM_SVC_SMCINVOKE,
>> +		.cmd = QCOM_SCM_SMCINVOKE_INVOKE,
>> +		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
>> +		.args[0] = inbuf,
>> +		.args[1] = inbuf_size,
>> +		.args[2] = outbuf,
>> +		.args[3] = outbuf_size,
>> +		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW, QCOM_SCM_VAL,
>> +					 QCOM_SCM_RW, QCOM_SCM_VAL),
>> +	};
>> +	struct qcom_scm_res res;
>> +	int ret;
>> +
>> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*response_type = res.result[0];
>> +	*result = res.result[1];
> 
> These are dereferenced without checking, which will surely upset static
> checkers (and users)
> 

There is no consistency in qcom_scm.c; I see multiple instances where
similar dereferencing is already happening in this file. However, I'll
add the if (...) check to be sure. The reason I initially skipped it
is that this API has a single user -- the TEE subsystem.

> I see that res.result[2] should also return some (aptly named) "data"
> which you handled in v1, but dropped in v2 (without a comment AFAICT)
> 
> Looking at it, we could probably wrap it in qcom_scm_qseecom_call()
> which this seems to be fit for
> 

I cannot use qcom_scm_qseecom_call() because this is not a qseecom
transport. It's a new transport called smcinvoke, which, for instance,
does not require a lock.

The data field is intended for qseecom over smcinvoke, which we will
never support -- so there's no reason to return it.

>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(qcom_scm_qtee_invoke_smc);
>> +
>> +/**
>> + * qcom_scm_qtee_callback_response() - Submit response for callback request.
>> + * @buf: start address of memory area used for outbound buffer.
>> + * @buf_size: size of the memory area used for outbound buffer.
>> + * @result: Result of QTEE object invocation.
>> + * @response_type: Response type returned by QTEE.
>> + *
>> + * @response_type determines how the contents of @buf should be processed.
>> + *
>> + * Return: On success, return 0 or <0 on failure.
>> + */
>> +int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
>> +				    u64 *result, u64 *response_type)
> 
> These should be aligned

Ack.

> 
>> +{
>> +	struct qcom_scm_desc desc = {
>> +		.svc = QCOM_SCM_SVC_SMCINVOKE,
>> +		.cmd = QCOM_SCM_SMCINVOKE_CB_RSP,
>> +		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
>> +		.args[0] = buf,
>> +		.args[1] = buf_size,
>> +		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
>> +	};
>> +	struct qcom_scm_res res;
>> +	int ret;
>> +
>> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*response_type = res.result[0];
>> +	*result = res.result[1];
> 
> this also seems like a good candidate for qcom_scm_qseecom_call()
> 

ditto.

> [...]
> 
>>  /**
>>   * qcom_scm_is_available() - Checks if SCM is available
>>   */
>> @@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>  	ret = qcom_scm_qseecom_init(scm);
>>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>>  
>> +	/*
>> +	 * Initialize the QTEE object interface.
>> +	 *
>> +	 * This only represents the availability for QTEE object invocation
>> +	 * and callback support. On failure, ignore the result. Any subsystem
>> +	 * depending on it may fail if it tries to access this interface.
>> +	 */
>> +	ret = qcom_scm_qtee_init(scm);
>> +	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);
> 
> This will throw a WARN on *a lot* of platforms, ranging from
> Chromebooks running TF-A (with a reduced SMC handler), through
> platforms requiring QCOM_SCM_SMCINVOKE_INVOKE_LEGACY (0x00) cmd
> 

Are you suggesting I remove the WARN? If so, how should the user be notified?
Should the error simply be ignored?

> Konrad

Thanks,
Amir


