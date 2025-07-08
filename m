Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828FFC83030
	for <op-tee@archiver.kernel.org>; Tue,  8 Jul 2025 00:18:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BB69F4FB8C
	for <op-tee@archiver.kernel.org>; Tue,  8 Jul 2025 00:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1751933921;
	bh=kFt6Oom5g+9QGUKhUH0b2chcUL/hscbZVZ8LC4C1q8I=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AM+ulkDB+vOD/vnqEqXm2NBXccpJ4eWz/tV6dWcWpmFypQgSzLMLJ38WawjZjp5+3
	 LzKlqSvjaTtZ7UpXlWDXOTWGnHzvjJaRZB0qEm7w0ijzgaFMZxWyi07dyvA39iCYtS
	 XQsMWslWPyj3QyjXf5tBENepLPAwUpfWt1UdDPRtxtdxkkc3zisSmoNlRA4mw2zhBU
	 IKblMSAlZC3o7KRT50uvvCmnHinVtEM7BvXP9216NeAl3cSTRy+R33MKSKMqXqAIaq
	 bcC4bq8vVIN8hG9t+ouLYySf9T9EgQ/Z73Whq3/ZW2IbF1syT0GxKyPEYL04ASvvao
	 CD1M5/qR4Gs1w==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E73FA3F6B0
	for <op-tee@lists.trustedfirmware.org>; Tue,  8 Jul 2025 00:18:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nHH0sG8E;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567DNBXc013805
	for <op-tee@lists.trustedfirmware.org>; Tue, 8 Jul 2025 00:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oaTOEkIO8yrsO0UKiWwZlqMg1M5J5KL8pwQLxI4CLgg=; b=nHH0sG8E+AXC4w4U
	T4O+a6q0EEjbnZQYFWebBAmLf1LFy5Z5grmBAUj38+fCP789t8D5bX+71ZNR6c6O
	GLAMa7KnfJMTt7SB1HVCtKMcZkAM8evugiLo9SgqYP5JUPcyDLNcn+Egu7JLPVcr
	c9hJKiCNhXIgebs3eEnBzEf/l8lpJyfuykGn8tx8AJt85i7j5zQ3DmYD5xJXoTGS
	16ndMIsTGrgYwojG+OE8FyCp6Kil7m92n/qQ36Av0+ueocIKULV+rC6qWTCg0svQ
	SNez+wSpq1uksn32XBms6yrpuna1MZ3yV5Roa5dKd8RGFg+NtwH1Jfwj+zKsisf8
	UBPw1Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b0q2p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 08 Jul 2025 00:18:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234a102faa3so28105585ad.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Jul 2025 17:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751933898; x=1752538698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaTOEkIO8yrsO0UKiWwZlqMg1M5J5KL8pwQLxI4CLgg=;
        b=hv24x3krd+EVd8Z6lEGhzs9C53nR8ZybjITcdrvzoB7W48w1ONq0UrOSidHchymCNN
         9JfGwoh71+T/MxxUxdzsEYQhUMpsLFD4Dr1F0LSFFqZdz1J0SnlRcx5xM3y62kcCsBC7
         M+UaLclceU0KV3UrkszJHxulNyREUbWnxcSzuB0xnanDso8EoPGKX1UqtpAlbr5RpBq6
         XPUAyBoxdXlkTC0y04mXyFo+5TRMFL7WsHO8s04HXQH5ZQrVUi2Qq54boT5e0EunYQr8
         pB2sfZ6+Z22pW/gRM+cSduMIYnFWQSmP8VrF6Sd8QYq2T/KFNxocFEkRN37YnyfTy0br
         Jp2g==
X-Forwarded-Encrypted: i=1; AJvYcCWib776iZQvPettSpnqmpvucScBJRqlRhh3765KucFkqqph/teGqwxwxkxIvAW9NKxbJSYPpiY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx3SAnlepZuY+RmQ6eEpuSRBDqAcugjbIRxrbuL8foQ0tCkNp2V
	8uyjLmsoiiuKJl8bqp8IvEYICrnDb8a+dLqUhE95RTNG+GY5kh2nP3iqn/DG/aM4UHGZZTuxzm4
	sfwpAEyH9U98YD9eGPcF4lMVolXHhsrQJI5ljMI1ZeBt1vAqntZEpz5GqyhnU5hnVTGolsA0=
X-Gm-Gg: ASbGncsUTNSGFWv4aVjPr8K/0m2NfS+LKhcG9kLSYYOwLoRS6ko2Ckw9PKasGhb1MG8
	0zWs4GC8NDn3mxKYuadmYU4rshuxBACNUoOT+bvu/tup4y20u4RpRDUIphRBzz2gamuvX67soCQ
	0Dr2Gxb9ICj3kHeMxJEAw78MipapnMvqFLqx+rjuyS8EtXeBAWR3xTP7Q7WDXz1iWmrewMmJfLL
	1HwWpWW6cuyNFu3Q3jqwvjtVRQSWTTwNcDySW1hstu+Y9U/8p2Xee71SvgwXxC/OBTvnNthowoQ
	dFXVtYn2hnEZvQe+NyWACHchux2sus9naa0fpcQAialWWt+zt4TgavOl3FQgtlW2yQNS4s+hMPm
	3soi1JCy5vPPkFwYqBuNO
X-Received: by 2002:a17:903:244c:b0:234:d679:72e3 with SMTP id d9443c01a7336-23dd1d80da1mr8271175ad.42.1751933897825;
        Mon, 07 Jul 2025 17:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMM+Gbo9/WjlZPVlIIUZQ4YQst2yhj+gXkh09Rr5WiqbDyV2/LPR3+ycOzSMRJJQfm2+cqXA==
X-Received: by 2002:a17:903:244c:b0:234:d679:72e3 with SMTP id d9443c01a7336-23dd1d80da1mr8270825ad.42.1751933897349;
        Mon, 07 Jul 2025 17:18:17 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e4d2sm103006315ad.148.2025.07.07.17.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 17:18:13 -0700 (PDT)
Message-ID: <07cd8098-2d2e-4f90-96c0-64f8547e291f@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 10:18:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] firmware: qcom: tzmem: export shm_bridge
 create/delete
To: Kuldeep Singh <quic_kuldsing@quicinc.com>,
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
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
 <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-8-024e3221b0b9@oss.qualcomm.com>
 <2455f20c-130c-4f27-9cf4-6411e485b845@quicinc.com>
Content-Language: en-US
In-Reply-To: <2455f20c-130c-4f27-9cf4-6411e485b845@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686c63ca cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pz6wV3uveH3Zlr5Ofa0A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAwMSBTYWx0ZWRfX5G2rNjEgEHNZ
 xw9S90J+EfEqe3tDcBA/O6fKU2ALbYKL/cIoc6PwdmulZ7XKhr+Rys1NL0IRbDS5a7Szj8Mwhtq
 g5BH+n0mMKQN3u8kA78myds8GzWVJnOEGzjqA+j7lHEvfGW0FUbASyXZGDC9bAKu1VgptXlNqB2
 Hj5H6MVc6LjZzwmwooV+wJVssc+9oHPKnRa2unfIZBdexE5R/Syz62ZxK2ZImJAFGcacPnIbDVH
 RxTZYrXAI4m5Do0pU5c9XYXaWlxD84ciSW+eBRjfE87+FuC/y+NG+0XSEndhrv6cQeYA+ic6cmj
 FFuQarlnphiqawFxnUVo9Ro8RtHgZvvJ5V2z3MBTa4f0j7aoAZ5btP7/x4y1QySK33xA6/Xf+Gf
 CE1kXUCtiMcz1XcKrE9rPGLhsfTatvgUd75nmTlud5shejOIBnfzQEVKF57VNH52vto4ARrp
X-Proofpoint-GUID: ywgAsD6ZZsTNEpUYl0d9uJvGKPZmnXYS
X-Proofpoint-ORIG-GUID: ywgAsD6ZZsTNEpUYl0d9uJvGKPZmnXYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080001
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E73FA3F6B0
X-Spamd-Bar: -------
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	RBL_SENDERSCORE_REPUT_9(-1.00)[205.220.168.131:from];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.214.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
Message-ID-Hash: SIZ7S52TIYIG4COZYOQPF54D3K536IPR
X-Message-ID-Hash: SIZ7S52TIYIG4COZYOQPF54D3K536IPR
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SIZ7S52TIYIG4COZYOQPF54D3K536IPR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Kuldeep,

On 7/1/2025 9:47 PM, Kuldeep Singh wrote:
> 
> On 5/27/2025 12:26 PM, Amirreza Zarrabi wrote:
>> Anyone with access to contiguous physical memory should be able to
>> share memory with QTEE using shm_bridge.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  drivers/firmware/qcom/qcom_tzmem.c       | 57 +++++++++++++++++++++++++-------
>>  include/linux/firmware/qcom/qcom_tzmem.h | 15 +++++++++
>>  2 files changed, 60 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
>> index 4fe333fd2f07..e9e4f06924ae 100644
>> --- a/drivers/firmware/qcom/qcom_tzmem.c
>> +++ b/drivers/firmware/qcom/qcom_tzmem.c
>> @@ -108,25 +108,61 @@ static int qcom_tzmem_init(void)
>>  	return 0;
>>  }
>>  
>> -static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
>> +/**
>> + * qcom_tzmem_shm_bridge_create() - Create a SHM bridge.
>> + * @paddr: Physical address of the memory to share.
>> + * @size: Size of the memory to share.
>> + * @handle: Handle to the SHM bridge.
>> + *
>> + * On platforms that support SHM bridge, this function creates a SHM bridge
>> + * for the given memory region with QTEE. The handle returned by this function
>> + * must be passed to qcom_tzmem_shm_bridge_delete() to free the SHM bridge.
>> + *
>> + * Return: On success, returns 0; on failure, returns < 0.
>> + */
>> +int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle)
>>  {
>>  	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags;
>> -	int ret;
>>  
>>  	if (!qcom_tzmem_using_shm_bridge)
>>  		return 0;
>>  
>> -	pfn_and_ns_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
>> -	ipfn_and_s_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
>> -	size_and_flags = area->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
>> +	pfn_and_ns_perm = paddr | QCOM_SCM_PERM_RW;
>> +	ipfn_and_s_perm = paddr | QCOM_SCM_PERM_RW;
>> +	size_and_flags = size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
>> +	if (qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
>> +				       size_and_flags, QCOM_SCM_VMID_HLOS,
>> +				       handle))
> 
> Can we add a debug log here to ease debugging in future?
> Something like this can also work.
> 
> pr_err("Shm bridge creation failed, ret: %d, NS PA|Perm: 0x%llx,
> size|flags: 0x%llx\n", ret, pfn_and_ns_perm_flags, size_and_flags);
> 

Sure.

Regards,
Amir

>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_create);
> 

