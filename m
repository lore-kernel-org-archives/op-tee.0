Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EE8C83F1A
	for <op-tee@archiver.kernel.org>; Fri, 11 Jul 2025 05:06:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 53D61430ED
	for <op-tee@archiver.kernel.org>; Fri, 11 Jul 2025 05:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752210382;
	bh=ZiQ3Fv8gmz6RId3auba0EbdkWD4thp4jNvTHfKbkpmo=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Fo1zvXd2YJKBu5bIw1XOmzJSSl08BJAoFP7ME2LOLXbi+FpCw6O5I/jCdVU7MRnKl
	 Nf8ly6EoKN4VlD3vw9+kBHGjm6kU8htirGbeolxYOmfPD53zdFzcrJHRDVEXaWDXuT
	 QYcNRaoA6W/4ZUJ99ni6Ui6h9FqbxG38omRUWF2Wl1zPYOQOjOJyD9e9Cm9VUch1J3
	 EHwugChcIHia+tkCyGC+0eGIjDHYxekvIOr6tU6yu0dHXPZ5uCoBVzZxHPElCZeiUq
	 u1xDfGoNNUc41Fmw1Kfo+OxA5Z+2dGr4rtN3aP/UzxZyzDfakPxd44xDy5j5PDofth
	 oyNcDAfKN8BKw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8F1724145B
	for <op-tee@lists.trustedfirmware.org>; Fri, 11 Jul 2025 05:05:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B9xo24QQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X7Al003805
	for <op-tee@lists.trustedfirmware.org>; Fri, 11 Jul 2025 05:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ON4p5KKmBIR3FGHX5880lk4pL/vyxFoXHm7nsMOOrHc=; b=B9xo24QQrEIy7vY7
	2H/4mBPA3lz09M1dFW1fwOCkLhQfAW7ZCNoO5BPE83/2joulY+bKdcmmx1buzB4N
	DJ/k0jMO4qVOPlg9gxsmsShYUDwx4+Tkh5hVzS+GqIQA6tnG6jwrpqRQiwm6b9RS
	XPBK0WcYvjRKsCFErTQqZ8xDU9gfETVVz772t9enoch6qBI1PW/ivByxjkm8ZNhE
	V0l/K9PWd8NBcsTNpnzDVg2pVE4TydTdDmZEskeyhotPZmCkHAhrBUl8EulOipbr
	2hFqH7AF6YTK/z5hJYO5lxELm+g7qlasIirEqu+f1a1xEQdDlh6mI8QGPKeqqOBC
	j50esQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbnyc26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 11 Jul 2025 05:05:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b115fb801bcso1903720a12.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 10 Jul 2025 22:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752210356; x=1752815156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ON4p5KKmBIR3FGHX5880lk4pL/vyxFoXHm7nsMOOrHc=;
        b=RIfzcgYP0wKpjX5JkI/g6pFxnAmIfMGJ+khpGXwzjD1vDhQcblyhx+QKrjqQkRXjpb
         UNVYZJ+2QjafDR9Q6+eoT4iMYxBhmwNPke3XFmDeFGcle1x8AY6VMG2n4Mgc778AZqJk
         IIfKg49Cm1uRIPEWXucCpK1n+NDvQvvJx4YgIJ/+qATuuLigAGYIt4JzDJ7J4D7AkWLV
         /bbwpKZJklJvClqy8+j51rBgiOxLDL8sb5U7dK0BA+OegLJzMPJ6tVx+HU0vpA4Wb861
         QvJ5uPPxIvVzfBgMJjeVyuPbAdsx2GNGDJQDfHE7LA4iW+k1iz6vMjDDXjb6pcDD/X8Q
         6mkg==
X-Forwarded-Encrypted: i=1; AJvYcCUNigemuCCnnz/sd5YNEp/8lnsiA0IUs/WhWi/BRi2L+7UK2Yyjcc+3N9FBZWrfHSkpqfrxB40=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyY8aznK33ZlX/ZTKDSjIO5qFIrSNj4kOueFidAJh9+OwlZmbBY
	WepamWnvQfp/I4YlQUMHAYqgA1BeblDcvW71HBUDISBt/hM6kJO8C+OYUzRrScljljhzgJJ+kXy
	3P1AWPhp61IprHEOuNUCdtvWbwv69VHTKOL75abZcUsvPGTXr/4ShXEkSMhtze8ypRF+EiDU=
X-Gm-Gg: ASbGncv1ejFkcJHLssW4nt9iZy3UtuvnhxmP4g07JncQE9+tdKHBDv2DmgPHPgeHA4e
	cHbp5uXkxYB6nPs++5L7N2klo1R84qP45uVUW2wFglmqELwZs/OEG6RHhmesh33qmtpmOQwZcCH
	hUsDTAXxAqMlyzBlH6kifFRHLXIdi7aKUW9+y0rKD5SruZHhKIs2/5sbrtaf3aDKo4We+HtYmkP
	67RAMaKZ/ntPYpAhIZfiipmtRFkZvEizs6ibvNyBwiSXEBdC+xMTuJckQLQDqCREW6Xc5gT6UP4
	dkmcjvuiroa8rCnxFEFE5WYICl8r118I6t9GdTicvTMr+pYspHwHfquZZ3R4bdNor/ROZToqIHz
	kBrminxeT2NTeGPamVseX9QtlSXLTseGQH8rJvg==
X-Received: by 2002:a17:902:e54a:b0:234:8a16:d62b with SMTP id d9443c01a7336-23dede38615mr28066765ad.12.1752210356368;
        Thu, 10 Jul 2025 22:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc9IdZCzOQJSKnApzYY4Ey9QwM3RLDd7RZBRwcYVcIK2ljlo/TA59XUzUEdTJNZzy9kf6SxQ==
X-Received: by 2002:a17:902:e54a:b0:234:8a16:d62b with SMTP id d9443c01a7336-23dede38615mr28066255ad.12.1752210355851;
        Thu, 10 Jul 2025 22:05:55 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de432289bsm37082315ad.118.2025.07.10.22.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 22:05:55 -0700 (PDT)
Message-ID: <ad88258e-dc44-4b82-b49c-e327609ab774@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 15:05:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] Documentation: tee: Add Qualcomm TEE driver
To: Sumit Garg <sumit.garg@kernel.org>
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
 <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-12-024e3221b0b9@oss.qualcomm.com>
 <aGu7boxOTB3TFRNU@sumit-X1>
Content-Language: en-US
In-Reply-To: <aGu7boxOTB3TFRNU@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAzMyBTYWx0ZWRfXxeIafzPL+Dht
 V9o8x9eoVN5ZryvamZzqd7zNAsxdodYfjIRx675f8QGoigw2ftClzFj82ZcN14bhks9/vGhTqbv
 KywsVZa7Cmuen4J/fw2EXcqobBYdoJbr1iuIb4C1pszZIvREnMcGIJ9tkjmbYm/7X4awCYB61b5
 yQEz1xqKr3YyXfZOE+4vFt58xj6324u/EFWFhYoLTfMW1q8ZJ7QAs6cwP9ziWcURYeeJNIoNEsL
 iYyvdj4vTxLqnRBTkHczv9gcI+0Uji2TBzDz7nqJw4JfDu6Y+UWoMxNwSOWfvE3pM8rLdqo1MtY
 hUqcWL83Cv1LTGZMxojbHHGdMKDt4cOHefdbsPZIEjSHKz+4MXPlpdK4wYbBAiGKmY4JwycIcAt
 nBUwTjdxUxpMTddzRQLkfB3aMVVMgKdXH+db3fv24+RsAZGbRHT0OkCUMSTpSZNHeoGG0omE
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=68709bb5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=XIjxTgID6P44-LRwrwcA:9 a=QEXdDO2ut3YA:10 a=M0EVDjxxv-UA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 2FPUJtZ0ScUn0IFedLiIiVzKsZ5dW0nm
X-Proofpoint-GUID: 2FPUJtZ0ScUn0IFedLiIiVzKsZ5dW0nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110033
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8F1724145B
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[205.220.168.131:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.215.197:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+]
Message-ID-Hash: YK6I6ZQMZTCEYU6MCABQKW2RU3GENLZM
X-Message-ID-Hash: YK6I6ZQMZTCEYU6MCABQKW2RU3GENLZM
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YK6I6ZQMZTCEYU6MCABQKW2RU3GENLZM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Sumit,

On 7/7/2025 10:19 PM, Sumit Garg wrote:
> On Mon, May 26, 2025 at 11:56:57PM -0700, Amirreza Zarrabi wrote:
>> Add documentation for the Qualcomm TEE driver.
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  Documentation/tee/index.rst |   1 +
>>  Documentation/tee/qtee.rst  | 150 ++++++++++++++++++++++++++++++++++++++++++++
>>  MAINTAINERS                 |   1 +
>>  3 files changed, 152 insertions(+)
>>
>> diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
>> index 4be6e69d7837..62afb7ee9b52 100644
>> --- a/Documentation/tee/index.rst
>> +++ b/Documentation/tee/index.rst
>> @@ -11,6 +11,7 @@ TEE Subsystem
>>     op-tee
>>     amd-tee
>>     ts-tee
>> +   qtee
>>  
>>  .. only::  subproject and html
>>  
>> diff --git a/Documentation/tee/qtee.rst b/Documentation/tee/qtee.rst
>> new file mode 100644
>> index 000000000000..8ae4da17c3a7
>> --- /dev/null
>> +++ b/Documentation/tee/qtee.rst
>> @@ -0,0 +1,150 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=============================================
>> +QTEE (Qualcomm Trusted Execution Environment)
>> +=============================================
>> +
>> +The QTEE driver handles communication with Qualcomm TEE [1].
>> +
>> +The lowest level of communication with QTEE builds on the ARM SMC Calling
>> +Convention (SMCCC) [2], which is the foundation for QTEE's Secure Channel
>> +Manager (SCM) [3] used internally by the driver [4].
>> +
>> +In a QTEE-based system, services are represented as objects with a series of
>> +operations that can be called to produce results, including other objects.
>> +
>> +When an object is hosted within QTEE, executing its operations is referred
>> +to as direct invocation. QTEE can invoke objects hosted in the kernel or
>> +userspace using a method known as callback requests.
>> +
>> +The SCM provides two functions for direct invocation and callback request:
>> +
>> +- QCOM_SCM_SMCINVOKE_INVOKE for direct invocation. It can return either
>> +  a result or a callback request.
>> +- QCOM_SCM_SMCINVOKE_CB_RSP submits a response for a previous callback request.
>> +
>> +The QTEE Transport Message [5] is stacked on top of the SCM driver functions.
>> +
>> +A message consists of two buffers shared with QTEE: inbound and outbound
>> +buffers. The inbound buffer is used for direct invocation, and the outbound
>> +buffer is used to make callback requests. This picture shows the contents of
>> +a QTEE transport message::
>> +
>> +                                      +---------------------+
>> +                                      |                     v
>> +    +-----------------+-------+-------+------+--------------------------+
>> +    | qcomtee_msg_    |object | buffer       |                          |
>> +    |  object_invoke  |  id   | offset, size |                          | (inbound buffer)
>> +    +-----------------+-------+--------------+--------------------------+
>> +    <---- header -----><---- arguments ------><- in/out buffer payload ->
>> +
>> +                                      +-----------+
>> +                                      |           v
>> +    +-----------------+-------+-------+------+----------------------+
>> +    | qcomtee_msg_    |object | buffer       |                      |
>> +    |  callback       |  id   | offset, size |                      | (outbound buffer)
>> +    +-----------------+-------+--------------+----------------------+
>> +
>> +Each buffer is started with a header and array of arguments.
>> +
>> +QTEE Transport Message supports four types of arguments:
>> +
>> +- Input Object (IO) is an object parameter to the current invocation
>> +  or callback request.
>> +- Output Object (OO) is an object parameter from the current invocation
>> +  or callback request.
>> +- Input Buffer (IB) is (offset, size) pair to the inbound or outbound region
>> +  to store parameter to the current invocation or callback request.
>> +- Output Buffer (OB) is (offset, size) pair to the inbound or outbound region
>> +  to store parameter from the current invocation or callback request.
>> +
>> +The QTEE driver provides the qcomtee_object, which represents an object within
>> +both QTEE and the kernel. To access any service in QTEE, a client needs to
>> +invoke an instance of this object. Any structure intended to represent a service
>> +for export to QTEE should include an instance of qcomtee_object::
>> +
>> +	struct driver_service {
>> +		struct qcomtee_object object;
>> +		...
>> +	};
>> +
>> +	#define to_driver_service_object(o) container_of((o), struct driver_service, object)
>> +
>> +	static int driver_service_dispatch(struct qcomtee_object *object, u32 op,
>> +					   struct qcomtee_arg *args)
>> +	{
>> +		struct driver_service *so = to_driver_service_object(object);
>> +
>> +		switch(op) {
>> +		case OBJECT_OP1:
>> +			...
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	static void driver_service_object_release(struct si_object *object)
>> +	{
>> +		struct driver_service *so = to_driver_service_object(object);
>> +		kfree(so);
>> +	}
>> +
>> +	struct si_object_operations driver_service_ops = {
>> +		.release = driver_service_object_release;
>> +		.dispatch = driver_service_dispatch;
>> +	};
>> +
>> +	void service_init(void)
>> +	{
>> +		struct driver_service *so = kzalloc(sizeof(*so), GFP_KERNEL);
>> +
>> +		/* Initialize so->object as a callback object. */
>> +		qcomtee_object_user_init(&so->object, QCOMTEE_OBJECT_TYPE_CB_OBJECT,
>> +					 &driver_service_ops, "driver_service_object");
>> +
>> +		/* Invoke a QTEE object and pass/register 'so->object' with QTEE. */
>> +		...
>> +	}
>> +	module_init(service_init);
> 
> Lets drop any reference for kernel client/services since they aren't
> supported by this patch-set yet.

Will do.

Regards,
Amir

> 
> -Sumit
> 
>> +
>> +The QTEE driver utilizes qcomtee_object to encapsulate userspace objects. When
>> +a callback request is made, it translates into calling the dispatch operation.
>> +For userspace objects, this is converted into requests accessible to callback
>> +servers and available through generic TEE API IOCTLs.
>> +
>> +Picture of the relationship between the different components in the QTEE
>> +architecture::
>> +
>> +         User space               Kernel                     Secure world
>> +         ~~~~~~~~~~               ~~~~~~                     ~~~~~~~~~~~~
>> +   +--------+   +----------+                                +--------------+
>> +   | Client |   |callback  |                                | Trusted      |
>> +   +--------+   |server    |                                | Application  |
>> +      /\        +----------+                                +--------------+
>> +      ||  +----------+ /\                                          /\
>> +      ||  |callback  | ||                                          ||
>> +      ||  |server    | ||                                          \/
>> +      ||  +----------+ ||                                   +--------------+
>> +      \/       /\      ||                                   | TEE Internal |
>> +   +-------+   ||      ||                                   | API          |
>> +   | TEE   |   ||      ||   +--------+--------+             +--------------+
>> +   | Client|   ||      ||   | TEE    | QTEE   |             | QTEE         |
>> +   | API   |   \/      \/   | subsys | driver |             | Trusted OS   |
>> +   +-------+----------------+----+-------+----+-------------+--------------+
>> +   |      Generic TEE API        |       |   QTEE MSG                      |
>> +   |      IOCTL (TEE_IOC_*)      |       |   SMCCC (QCOM_SCM_SMCINVOKE_*)  |
>> +   +-----------------------------+       +---------------------------------+
>> +
>> +References
>> +==========
>> +
>> +[1] https://docs.qualcomm.com/bundle/publicresource/topics/80-70015-11/qualcomm-trusted-execution-environment.html
>> +
>> +[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
>> +
>> +[3] drivers/firmware/qcom/qcom_scm.c
>> +
>> +[4] drivers/tee/qcomtee/qcom_scm.c
>> +
>> +[5] drivers/tee/qcomtee/qcomtee_msg.h
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 99fe1ae22ae0..42823d33cc03 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20515,6 +20515,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
>>  M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>  L:	linux-arm-msm@vger.kernel.org
>>  S:	Maintained
>> +F:	Documentation/tee/qtee.rst
>>  F:	drivers/tee/qcomtee/
>>  F:	include/linux/firmware/qcom/qcom_tee.h
>>  
>>
>> -- 
>> 2.34.1
>>

