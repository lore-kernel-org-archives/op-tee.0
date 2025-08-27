Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0504ACA0EFF
	for <op-tee@archiver.kernel.org>; Wed, 27 Aug 2025 06:06:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3C56D46644
	for <op-tee@archiver.kernel.org>; Wed, 27 Aug 2025 06:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756274801;
	bh=wMGz6LtFcqKacfGBJToPMAl+pHQslhvTR58QLzr0q7I=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3JMoOx9Lp7Kg1mDCuqLSj4VaVC4gYG6P5J9a+tgvLuZSuEOKK5pN/9k7FqbS8Lzyx
	 66w8kkyhWia4cTqvYEl64F8l2ZNi5P6bi814g90eH9vlTg+8cA6HvxZ1oeBsb7DSmt
	 fZqui8f88mkqLguy+ExvvfzJbeEcfH4A3eFPiccjGLM0jf9j2J/lIChxweyV/zC789
	 UbKkgKuO59VZ/OL1qgKa4wyU6qLqC3FJKHNtP/UggbvEGzL0sIAx2kaFP0rFAZ9cx2
	 4gFdpLh9Da2Qwyt0pO5XIBlwoLQYm1882KvKEfTC/Zy4u73z0b+DVlSRfLQkUPGIO+
	 3+Lhj1/RuEtGA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7722342F16
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 Aug 2025 06:06:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n06+6yXW;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R5Yr19023583
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 Aug 2025 06:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IvtoMULgukZ1V1cgtQetdWBAfSoYzONqp4myym0U6ZU=; b=n06+6yXW0wU0IpKz
	/+cogiaPfyl+lmuJ7TkprUJ72V/3CKRv7h/oJxp36crzCJpUNmcMeyRp09RunAMn
	C21412ZnXj3muBeVY7sPWwXYZ+vkj9n3ZZEehipGEvQAXd7J0BY3VBxwbvuOX4qi
	6KmthjfMvu8hO4TkUwZQzP1C8fyypOa/EylDhNmDMHedafqFBS7SQj706WS/YC39
	SLkxUBa39PGF7SHrIoO/Bg9etaQjwvWUl0LcaiJM4b/BduiSIBozd/bJ3EmK61+Y
	h4FQlyPWG4avYytuEIDHAXJq33C7x91FRUn6hYgjQLMUC2475PDhbS/nq3ou/dWt
	SE9oQw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unufqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 Aug 2025 06:06:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77053dd5eecso6590707b3a.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 26 Aug 2025 23:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756274786; x=1756879586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvtoMULgukZ1V1cgtQetdWBAfSoYzONqp4myym0U6ZU=;
        b=HdBVYgTHZqyHwOXy7WYrQPTWMj9RwDCBK2wMcTy0UrLqW19zQiCqRSkSXzmfHqjLw7
         CbvxOANcR/hYmpNgwvZvz4pislynLAfOimUQJXBCgkgpNaRyQdDKId9l3bUeF0swodaW
         qYxxVcP2PBOf7CyLeLdGK3xsDdhQhPk0usVrgsMgW5rNS2ASWRHe6nYV18a37uxtJcTo
         y4lCbkZnZZlrjSQZ8rj/idsOvsX4YgRfkYQAvFn0taehIZQaKLGh/iBXWkGqZQZNyRNR
         wRpd4KocDbcw6s3Ca0zzJKkNHqCsVDGCg6YLIAqejhRYiiV4SWViLg/I4ITU4b6RWmUc
         mjSg==
X-Forwarded-Encrypted: i=1; AJvYcCWsOs7qclYrBQtyn4zjl67uVrKQN3kHSZcIO3sbAuxayjJmjaahGG5PIDK8CgTbhec0xC8y8ko=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw0CUaVN8EaEfVXeGxWi8O0ZlJfj/CnLNzzQtlLYkjbfeYASQcN
	2l80lNzpPwoqGu5tytMA3MszyUK5l6qTLdTt4h3PrzsERJt3dVoBrQzksrd4px2w9nTMnOTKxNk
	6jnenxCYwSPcRpLLssCyVVEuQEntwdMs/DPi01xHXOI0qOxuCoDptsmI5vU18ipre7fOAyLA=
X-Gm-Gg: ASbGncswk1MW2VYES/n+SwjMVOGSPnzL3vG6Lz/yhrBoyZfVcWB7yiwyh/XEklFSjvx
	PANzYaq8mFibF3f33xXYqHqg/FFrUvtHot3g7TJb6gk4TwRkgp6Yg/5j5iLLxwpMh9RHL/Gdvah
	4HTQvfGo5/VqYneAH+8fPhH9ht51aHlx8mXU3R6jBdjDv+UPR3tqytzVNI3rjY+5DkEWChErcCI
	ZmcjAdGll7WeOTrMVVuyOs5UZDVU6mUZOy3Y5odzYeWjq41mvyyKFQWi14bO7+7zyXnYTZzHycZ
	mAI/78wDUUXpErTSmcoa0B3x0+3ARBM6Rucf7SjkMgmFSCIktsX6vJtb6dKaDEtFuE4rWx5VBBO
	vtYMjA9drvW9Kgd/lBZYQSlPGwWje6fAmgsJS/A==
X-Received: by 2002:a05:6a00:340e:b0:771:ea51:690e with SMTP id d2e1a72fcca58-771ea5170d6mr9587245b3a.20.1756274785582;
        Tue, 26 Aug 2025 23:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjXY9tZYbdaHdBkaKUQPtpmPxg/EWHTA5baJ83nFS3+u9isarHBBJ/FYnGHhPcbEv04uBR8Q==
X-Received: by 2002:a05:6a00:340e:b0:771:ea51:690e with SMTP id d2e1a72fcca58-771ea5170d6mr9587212b3a.20.1756274785081;
        Tue, 26 Aug 2025 23:06:25 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ecc4454esm6208226b3a.0.2025.08.26.23.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 23:06:24 -0700 (PDT)
Message-ID: <265e23fb-8865-4dee-99ed-f08450975ba8@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 16:06:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/11] firmware: qcom: scm: add support for object
 invocation
To: Bjorn Andersson <andersson@kernel.org>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
 <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-6-7066680f138a@oss.qualcomm.com>
 <itpdolgmxp4ofdv3vf2ghulo7slj5wjby2tvawehihwvenbep2@ub5sdgf6gxeh>
Content-Language: en-US
In-Reply-To: <itpdolgmxp4ofdv3vf2ghulo7slj5wjby2tvawehihwvenbep2@ub5sdgf6gxeh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0L5KMLVXFDOBKohet77Vq0Wx5Ge6jMro
X-Proofpoint-ORIG-GUID: 0L5KMLVXFDOBKohet77Vq0Wx5Ge6jMro
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68aea062 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=3sczFqAQEyrjP0LPqEUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX2184MVvhDp8Q
 fPjV2gbiwm4iiPdLmOqrQBoNfogt9NhDe5seiGlwsdlAHvuLq30+Rpmkm7+wiTcwYzgrqwKlNBN
 k3VWRGyc1nesu4NmPiDSNe3i80mDOw1LZNlcFvLigL8eT5MK7W5iW71m+PTtq5+tJ+TCJG3Cl78
 XgFoIdNGxTj/ATt1kVdWJBVnBKP4kv/aig1CfkSyQ7xylBmBPECS/n88OFtqFXHAULxY4l7brdn
 bfYsYt7BFYJZi+2mAX/fL3Rnk6BzdIUJ9NrjURR+L/xzxnjBPJTNdWnsHvtMA1CDDa03Peyp/Nx
 l7nj38Hr8pWhodMKoVMepVR9XokHIUWBxwrvfLhg1EEdzg85vrZ5wNph8EfIw94a/fTKHM9qdlD
 KlxlttmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031
X-Rspamd-Queue-Id: 7722342F16
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.199:received];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: UFSLDYIC7QQCTEZH3YVVNRUXDKDPG75Y
X-Message-ID-Hash: UFSLDYIC7QQCTEZH3YVVNRUXDKDPG75Y
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UFSLDYIC7QQCTEZH3YVVNRUXDKDPG75Y/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Bjorn,

On 8/27/2025 1:52 AM, Bjorn Andersson wrote:
> On Wed, Aug 20, 2025 at 04:38:53PM -0700, Amirreza Zarrabi wrote:
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> [..]
>> +static void qcom_scm_qtee_free(void *data)
>> +{
>> +	struct platform_device *qtee_dev = data;
>> +
>> +	platform_device_unregister(qtee_dev);
>> +}
>> +
>> +static int qcom_scm_qtee_init(struct qcom_scm *scm)
>> +{
>> +	struct platform_device *qtee_dev;
>> +	u64 result, response_type;
>> +	int ret;
>> +
>> +	/*
>> +	 * Check if QTEE supports smcinvoke:
>> +	 * This will fail due to invalid buffers, but first, it checks whether
>> +	 * the call is supported in QTEE syscall handler.
>> +	 * If not supported, -EIO is returned.
>> +	 */
>> +	ret = qcom_scm_qtee_invoke_smc(0, 0, 0, 0, &result, &response_type);
>> +	if (ret == -EIO)
>> +		return -EIO;
>> +
>> +	/* Setup QTEE interface device. */
>> +	qtee_dev = platform_device_alloc("qcomtee", -1);
>> +	if (!qtee_dev)
>> +		return -ENOMEM;
>> +
>> +	qtee_dev->dev.parent = scm->dev;
>> +
>> +	ret = platform_device_add(qtee_dev);
>> +	if (ret) {
>> +		platform_device_put(qtee_dev);
>> +		return ret;
>> +	}
> 
> Wouldn't this work instead of the alloc + parent + add?
> 
> 	qtee_dev = platform_device_alloc_data(scm->dev, "qcomtee", -1, NULL, 0);
> 	if (IS_ERR(qtee_dev))
> 		return PTR_ERR(qtee_dev);
>

You are right, I'll replace it with platform_device_register_data().

>> +
>> +	return devm_add_action_or_reset(scm->dev, qcom_scm_qtee_free, qtee_dev);
>> +}
>> +
>>  /**
>>   * qcom_scm_is_available() - Checks if SCM is available
>>   */
>> @@ -2326,6 +2450,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
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
>> +	dev_warn_probe(scm->dev, ret, "Failed to initialize qcomtee\n");
> 
> A successful boot of db410c (APQ8016) now has the following in the log:
> 
> [    0.161437] qcom_scm firmware:scm: error -EIO: Failed to initialize qcomtee
> 
> If the target doesn't implement qtee, I'd expect that you tell me that -
> or preferably stay silent.
> 
> Looking at the other error conditions, we find -ENOMEM, for which you
> should also avoid printing. In fact, I believe all other error paths of
> qcom_scm_qtee_init() will have printed an error already (if not, please
> move the error print to the place(s) where it's needed).
> 
> As you're ignoring the return value, please then also change the return
> type of the function to void.
> 
> Regards,
> Bjorn
> 

Sure, a successful QTEE boot already logs its version from TEE SS,
along with any internal error messages. Based on those logs,
it's quite clear whether this function failed or succeeded at the
beginning. I'll remove the print statements.

Regards,
Amir

>> +
>>  	return 0;
>>  }

