Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9917CC87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 22:56:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D2D354662E
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755125770;
	bh=jAnNKoc8OIVx+dw7TrFVfvfY8lmRFsZzlTTw/qR/0dk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=lLQi4d58D9b7hat/ECLjDJIH9Y2xMWK7ZFnTrbowZv4pyosqbLAxrLQZ1CUoZrMdd
	 OS8sd70d20Mt4BtDYJemTilSCZNxswA4zMmdVGdCGlykGhlziQZnVocfQcmWsxRXEw
	 tSwCTD7K/NeXj7U0wcWDDSLClcZOPN4xc5HoRqB4jPnYfkinDfkDkUpnmFZjnfW2IK
	 EdFCpBge3acJt2dxNXhdBD1+zQL6pvvfcAzwY8OgDRPRohYrT/pChbmKajNAdlWqvY
	 XNfZ6TbRABwDPEBPkVQEQ3q3L8ipziyBcIBcpIsWW2yoZOcKoKBz3VvDcBc7HuzzZ/
	 oZdI4qcL+EtcA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1960242E10
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:55:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kvOe4hR3;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLfJh030090
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8e0ZVNprxYNA0/9coeslBrJajBup8IpRB7mgWlinU3I=; b=kvOe4hR389WJMGpr
	pSwX613gEZv7psgmjtiDKWNew9mN/oaXMWt7VZsUGZ0BYhGuur1Tz3LOgjc4ZcK8
	/ynBUUlLlkC9ecKh/1uPZUlS49gpcuwVRp1AIl8jtwpxIE2wI758QNLtqcuIMjqI
	u5Iu1TIo6URF61zeq0ZC83H3d+6cTgEDcqZXQq6s97Yqr1aWTmz2quWNfvCk2QFF
	euT8hKEvGddJZWYZKTRwNVXCQURNZieBYj52C5lJvsE4tofLzHsd4HIGpe++dhTC
	2hnP3czq2OO5mp5AJoSFJhPJvDbMPVyR6GLoI3PXpoxprIRy8abBaUsC7jdJ9wdQ
	0fkCvg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vrd85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:55:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4716f9dad2so430347a12.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 15:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125754; x=1755730554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8e0ZVNprxYNA0/9coeslBrJajBup8IpRB7mgWlinU3I=;
        b=jd/1b3grkePe1DR2bNH3enhvq7vmNeXj/ijCp8tihc/Z53w5xtepj73/795hXBmi9z
         cgfjqYTk4WGKMd2ZDlYmcSYSonzjrooVcngaXx/ty9y+rVdeEfp4JUvbBjyZ07Ss20rE
         +Une/RmdmrtVAqhHjL3UPdar7DlW/nW0vEnZ8THwztE77cZ039+pMeBUmfjep4CYSkAy
         fv5pC5ZGW4+qGi5j0dN/00c6xn645NQwenPrkIgAVLNIBA2ULOh1wiG0QKd6zHB5rbpr
         bXlsJiNq9aO00ib1J2ROk96MfoawcmecSi24qAZMf0tyEnR28aprnu7R6UuD7hTaIJ5m
         hAlA==
X-Forwarded-Encrypted: i=1; AJvYcCW11JZeTkpsAoheof9AS6Ld+BWvb9RJl5wnvMObq7cX5Pea1jD+hMDmVUTWZoETlgH+bMeB1s4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw3C1CC/LcBRjWFdg/X7yPjcinMgkauEZxx38B5c9nKd9nLFJdw
	Kxx65PNb0PGv9Hdb0MXgNHzjrFaS2RRw5tGWN/dJ+TJ/QEsWVLjIlLapS4rFAF8HRVI3hJcpHlx
	SVuMm1IDFNKTVnIyiF+mhyT9hkphJQeWkIzKMiZ0jFC+Je7HflqK6UGow8kbnlraheec98zk=
X-Gm-Gg: ASbGncvXxbSrmjolT7I2nSO6+brbmWzOq2URHvJZChmZWkzYm8KBNYV8XZIXV64LGjK
	R2TpRmmyZimiYekS0CShqwZbKgNIpPBfgGeD7C6x+8pEYuucBmz+zqgMqKEo6RZlaJmfYGjCJvA
	qlsLqONdG63k+Ga5bdp8OzTI8BGaMl7p08qYKkHm6kaWYR22oRF+o/pO25Kj/IWJZbEH7A/Itdi
	xSE/u6vmHVMsH7xuwwIugFYbi26ryq39PAyZ2nMQy8CNS9N1qT578YtNmel0mAy472csaergjES
	U363YsLQAf94ONlGNRywCk7j1A3/ivl9b53vGhhdldKyqHFsi8+MlLZYP36OY4NmD91ABzSd+2K
	LVSkPjHTs+PvKktfCVbJCbzeynEcyEBO8uxvzCw==
X-Received: by 2002:a17:902:ef48:b0:243:38d:b3c5 with SMTP id d9443c01a7336-244586d6812mr11282995ad.47.1755125754319;
        Wed, 13 Aug 2025 15:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwyZkPhdjRr1DNqf2XUlzMie+QCuji1zBonY4NxpkKvkrR7x/LGRt8rtlqOJlwD4OUaeYUew==
X-Received: by 2002:a17:902:ef48:b0:243:38d:b3c5 with SMTP id d9443c01a7336-244586d6812mr11282655ad.47.1755125753877;
        Wed, 13 Aug 2025 15:55:53 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2429b4ca995sm202959025ad.177.2025.08.13.15.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:55:53 -0700 (PDT)
Message-ID: <1874e02d-993f-483b-bcb7-dba7c0611376@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 08:55:45 +1000
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
 <a93b9788-92ef-4b5a-89ca-7e7733697eed@oss.qualcomm.com>
 <176361cd-a095-4b81-9e36-f933d159d249@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <176361cd-a095-4b81-9e36-f933d159d249@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfXwPcdOsft10cl
 AEHH5jWUrMdClLkwTVPD4IqHpr09yv5pL0IS6JFHz/OVrSz+NdOqSjtRKBsG1OSX49ielzCOK1l
 9z6BHpg7fBBlbFy5tO7sKR9roG0KVzfcikgiX5Jbe0nvluXD2rCgl6xLVraalvDwi0kms2x6e7p
 8keTZsVTUxHudRxtDqgerhQ56uj1nVQ0g0suaw0Eieasl3Gb3mA94Wuqh4l7/+VRdbIbpUHXKTb
 eZrdSFTcoDe9vaevHkqTFn8080y74bZvReXWkf0ruDuUXlkBNMiX4QRF/g7iYDV+7OV6NGVe5b+
 puEgHv4k+dD2oOONsc632313lsa4J6vS0HZdLz5B/9z/2jGacBofLTfn0n+er7SfmZaCD/8Z6Ye
 shxDnorL
X-Proofpoint-GUID: kSU1YRaarZXn3wWJDdsmmlCZAYMMwO5J
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689d17fb cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=T0n-DW2OHO-Z3PBZrcMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kSU1YRaarZXn3wWJDdsmmlCZAYMMwO5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107
X-Rspamd-Queue-Id: 1960242E10
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[1.41.240.65:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: S3CZKNU53TEK65JBASLESQALAFNPWGDW
X-Message-ID-Hash: S3CZKNU53TEK65JBASLESQALAFNPWGDW
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/S3CZKNU53TEK65JBASLESQALAFNPWGDW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 8/14/2025 8:52 AM, Konrad Dybcio wrote:
> On 8/13/25 11:37 PM, Amirreza Zarrabi wrote:
>>
>>
>> On 8/13/2025 7:53 PM, Konrad Dybcio wrote:
>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>> Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
>>>> the secure world, accessed via objects. A QTEE client can invoke these
>>>> objects to request services. Similarly, QTEE can request services from
>>>> the nonsecure world using objects exported to the secure world.
>>>>
>>>> Add low-level primitives to facilitate the invocation of objects hosted
>>>> in QTEE, as well as those hosted in the nonsecure world.
>>>>
>>>> If support for object invocation is available, the qcom_scm allocates
>>>> a dedicated child platform device. The driver for this device communicates
>>>> with QTEE using low-level primitives.
>>>>
>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>> ---
> 
> [...]
> 
>>>>  /**
>>>>   * qcom_scm_is_available() - Checks if SCM is available
>>>>   */
>>>> @@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>>  	ret = qcom_scm_qseecom_init(scm);
>>>>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>>>>  
>>>> +	/*
>>>> +	 * Initialize the QTEE object interface.
>>>> +	 *
>>>> +	 * This only represents the availability for QTEE object invocation
>>>> +	 * and callback support. On failure, ignore the result. Any subsystem
>>>> +	 * depending on it may fail if it tries to access this interface.
>>>> +	 */
>>>> +	ret = qcom_scm_qtee_init(scm);
>>>> +	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);
>>>
>>> This will throw a WARN on *a lot* of platforms, ranging from
>>> Chromebooks running TF-A (with a reduced SMC handler), through
>>> platforms requiring QCOM_SCM_SMCINVOKE_INVOKE_LEGACY (0x00) cmd
>>>
>>
>> Are you suggesting I remove the WARN? If so, how should the user be notified?
>> Should the error simply be ignored?
> 
> I suggest using dev_info/dev_notice, WARN prints multiple dozen lines
> and taints the kernel
> 
> Konrad

Ack.

Amir

