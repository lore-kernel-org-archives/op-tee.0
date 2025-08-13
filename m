Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F47C87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 22:52:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E1CD24662E
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 22:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755125551;
	bh=gpvubl7IBMGZ3fNhTgbXzyPTB7BEybWTWqj8EEGwPiM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xr0No83HxJCwLjQgxE6eQAfei0xszqe8e1zyi9br74Ia4qRM+PwCpDTurjDRWKpSF
	 VZAFJ49InVN/gVlxCTzZjHTSllU4bLxQijVyMGolRgCq02PqHU3TmuCcQ/6dwUNd13
	 WEAVQ1ptd7MvDUoFdOrV5D6Z1+XG1ZaakDilDe4sYH7CGOU3kMyVLBBehaOJLJHjLM
	 WCBtLiWlMLaJ02jrSDe0Z3h21PSXTz3BgD882LIAAr3IlcWxy/xMzpOIzWeCtAPzsI
	 s0hvgywtCO1FlWyI50KMJ/WIZRqdPX++CwpPhjQBwCCXajF7SFAAk5lBBZIMgkDKpB
	 xelvM4q2VVqTg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0E70742E12
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:52:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fjd/24VX;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLwduc002794
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t42PazxIAwcY8zhaSfswxJzoFRiL77Ql0tEpJIyMuFY=; b=Fjd/24VXocnkshuC
	d00CX9XpBwlgTwwRriOLYf7uwSvAm8cs1rWazUkX4qDzJgFYycUVeGbRoujWltSG
	HwSuWa5l/p0Iz5QISvF8myCaFiA4NKiLJQKcCPbOZHKnw6qgBcoUxsHVwLf+9ubM
	0Lb8tppanA1gEPCy6TO2avDw2BYmvMA7j7bjOcUadWvTV1rndO+g7894Y1+k0yr+
	4+WJFfDx3v1JbNIOVXoijYZzDLXD9UzZ3DRO9KlS/VljDE06Bqp2mNVjUMIz3W7o
	9tXhUGZuYatTyGlTF7uyQ5cOE+xB42i5KSlV1J4McSHLJOC+1R/BZ0/FT66lXYRO
	sPbLyw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv5fg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:52:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e87065670fso7589585a.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 15:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125536; x=1755730336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t42PazxIAwcY8zhaSfswxJzoFRiL77Ql0tEpJIyMuFY=;
        b=gU1DkgpEhtzzu1Oy5eZL+ko7oruid3pEaps+QbRbS9KDSRCn3l/POuc1Vxj8ai+iM8
         Uh1IMeyGn+nNoAW882dqkRxMIDm0KZ2hdpyNJTrc1dJs8+KN0iBQ5CfirP208kqt6p/e
         qjrJl/fwR1E4NRH/mXhbB+ofWLoUPMZCIlwyPp63LF/PA1pZnktD//nTGHUPstLeBOcY
         PqJbo/D99sDUZ7Ie/Eo9kvjqLVQFw12404j92uKgH3zlzK9aAsKiLBVtYu3T1vXBYurm
         uMOY+Zmygt7CZp4r0UMnzwgEAnz6gUjPGyGD6YgDH+vQwU96f41/zOmERitkDu9AxO+W
         psZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjZtim+g2TPR+sUrqickUhPvisvUieFBXhT353G0mQdIkrS1wGhFUE3C+APUDS+ihrxGrFwgg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwHY83zhBGjmE8khZ0yFfTy5w55weGlHp+qpUU9/siJmIZjNi9E
	tRNU5TTPXJgAr6QQK6BoR6D95IR9WgTUJqX59UqRN9D7zAnfwQsfshd90q8Um8wU1GQ6HStrQ47
	QIloEb31VmmI4xQpUxcDkHFjUOZlnzqKn3vLAjx7SigWfk3Xg0WeKF0xKxV87l8qx6auyJZ6H
X-Gm-Gg: ASbGncuhKSj3UQUuD5mAzjNjoS1XcvS/UYiSJSR/xn0cjmsMpWCUR3qNdamXcJAKsKS
	PmtOaMmo71Lau7F+eXLnODJda3Vc2h5GByqZCPhfLB2qlA4YbDLDlkLTdG1ngMk4DJH2/Mg91um
	YH8W2zspvURnzpNrN+3xa04AInS6GXzirCrCamJIfOFB+BdXTgeuxbnbihAyhXstm6PF9/OsAaZ
	CEVjpc1C8stB8DZe6SpoXP9K9rRhxdRTwo+cLlFPVnNHz8SoBptvAq3L3zxIScyQQXxZdFr+qAb
	2ewQ6VaV2VYsbqw4FVoUio3OzbQDsOEUFqxqzGA5WJU7ajQHuhOWdTY2xgYm0vynCKpQvkdYcGQ
	yI7yYyUBPmcBFr3KdtQ==
X-Received: by 2002:a05:620a:4623:b0:7e6:5598:1fc6 with SMTP id af79cd13be357-7e8705a3275mr89869685a.8.1755125535622;
        Wed, 13 Aug 2025 15:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHclD7EUgbPfmus8NrnhqiEVqDLALZXNIA0vOZsJQC8vPRZCLtqwvV5bJV25qlMQ6s/DbEOQw==
X-Received: by 2002:a05:620a:4623:b0:7e6:5598:1fc6 with SMTP id af79cd13be357-7e8705a3275mr89866185a.8.1755125534989;
        Wed, 13 Aug 2025 15:52:14 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6186bfee29csm2338635a12.15.2025.08.13.15.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:52:14 -0700 (PDT)
Message-ID: <176361cd-a095-4b81-9e36-f933d159d249@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 00:52:11 +0200
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
 <f015c644-1176-47b3-8ce2-2567e529081e@oss.qualcomm.com>
 <a93b9788-92ef-4b5a-89ca-7e7733697eed@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a93b9788-92ef-4b5a-89ca-7e7733697eed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689d1720 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=pfBxzQCg3Pwb8BljcmgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sP3QrdmtoRv1mqvamgrfVjjhqx6tF-Gy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX5t69ndVINpTx
 sa3jiril5LecPfZNVisOmFWUPc8lVdDhb0XhguVFBAEZbxprAt8xtvUGATPS/y1LjImVJU+OTbD
 3c+bBxRdJCLSBLNrrZKZTaYlvpYycZ+n3xaK5am9myPUlerx9j86gJT6DiYEbRyR2OwEbSHAS7l
 P1ztgLetDU8IKtRqWWfYAX9pwnwy/nBE+hP3eH7LwSQ9pHB8Mlsp9w75hhoVrhkX/mdibZXWcnX
 3YRkVAFQLrycaS9yW1amYxnhQpHBdFgWq/zRjOVmPREwHvZoY/eszHGZdHcx/Xwdw/i0lGTZbpv
 es+Y/3xKQDSc/IFn7AZ1iadperNlZfc2knllVs7lIetZ2Q8TzVA/TqcEddu0arkMdRtznMWwaTA
 ucV08ROa
X-Proofpoint-GUID: sP3QrdmtoRv1mqvamgrfVjjhqx6tF-Gy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025
X-Rspamd-Queue-Id: 0E70742E12
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.222.197:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: SPHNWWI7HSBIQLBLQ3ZQNPRBOKZTDVEM
X-Message-ID-Hash: SPHNWWI7HSBIQLBLQ3ZQNPRBOKZTDVEM
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SPHNWWI7HSBIQLBLQ3ZQNPRBOKZTDVEM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 8/13/25 11:37 PM, Amirreza Zarrabi wrote:
> 
> 
> On 8/13/2025 7:53 PM, Konrad Dybcio wrote:
>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>> Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
>>> the secure world, accessed via objects. A QTEE client can invoke these
>>> objects to request services. Similarly, QTEE can request services from
>>> the nonsecure world using objects exported to the secure world.
>>>
>>> Add low-level primitives to facilitate the invocation of objects hosted
>>> in QTEE, as well as those hosted in the nonsecure world.
>>>
>>> If support for object invocation is available, the qcom_scm allocates
>>> a dedicated child platform device. The driver for this device communicates
>>> with QTEE using low-level primitives.
>>>
>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>> ---

[...]

>>>  /**
>>>   * qcom_scm_is_available() - Checks if SCM is available
>>>   */
>>> @@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>  	ret = qcom_scm_qseecom_init(scm);
>>>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>>>  
>>> +	/*
>>> +	 * Initialize the QTEE object interface.
>>> +	 *
>>> +	 * This only represents the availability for QTEE object invocation
>>> +	 * and callback support. On failure, ignore the result. Any subsystem
>>> +	 * depending on it may fail if it tries to access this interface.
>>> +	 */
>>> +	ret = qcom_scm_qtee_init(scm);
>>> +	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);
>>
>> This will throw a WARN on *a lot* of platforms, ranging from
>> Chromebooks running TF-A (with a reduced SMC handler), through
>> platforms requiring QCOM_SCM_SMCINVOKE_INVOKE_LEGACY (0x00) cmd
>>
> 
> Are you suggesting I remove the WARN? If so, how should the user be notified?
> Should the error simply be ignored?

I suggest using dev_info/dev_notice, WARN prints multiple dozen lines
and taints the kernel

Konrad
