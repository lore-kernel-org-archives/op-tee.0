Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7344C87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 22:24:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C56446461
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 22:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755123888;
	bh=MkzcIASgD2QGbcPW+Wul+0S3bWjeYPRrF6/zdQI2jik=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=A38bR1pat0ERNtO7CH3Di9OI+qgLcZgZ82PMn1E4IeS+UDHcf7d2EU2t6ZARte9uz
	 pv2Ne6mG67QJbsVkA0hmFUB7QwGykF8MMMXzOy5YEzpD6wI8cixahHVBTRc9wLTvGW
	 HySQ2YabmXErOk2udPQ4zYVsdbs3oHd44uVOsjARsY5DOBqBGIC8bteh24KVMjFGx0
	 N4wJigvoh3IoiMqcKjHLVqFQ7Vhhfj/40TBoXDCLWZ6Co9iTG+9gpbbj4iap8BeEuY
	 JEyU8ywZM8Qob3ev152QoiREHBY86Em5kJUIVQLLsMFAd84gpHGMT4uB5+vEDi/S2M
	 ZcW42BSkzO/UA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4642B42E10
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:24:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K9Rmk/HK;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLgcO029470
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7gth1q5wXt2kbolj7dWwKraNNmPxnZCoAelNEomImI=; b=K9Rmk/HKt+36obya
	M7UIbbgfRjSYDDYDWA3EMZ/BOIvwNdm2eFMRYEt3okNQRPA0cpkcWri3lnn2208z
	b57DhfPUBmsM/a71CsC8D0O0AGP4VNVIBDndA7NCLVIzbv38FMJIAfi+yQht2xNc
	VSuQDiWxyoC+8D1qos/8AaQZjYj43EmBU0CdXTGnrPwt10R0byL6SP7n2tRHtW4e
	MsTJ/Yw/hRfq5eyXk2PmPRIR41v/3ydboLU2mE6ABUihzo1eKQ5uTw2fr3QnZz06
	ecyaMqZzanckeqGnfFNvxfTg4ooITRU5EAIh1v9QvRicXdAvrfMU8kKF4NuFc7QW
	G8R6UA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9vh30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:24:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e614e73so349405b3a.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 15:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123871; x=1755728671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7gth1q5wXt2kbolj7dWwKraNNmPxnZCoAelNEomImI=;
        b=LphobI3gKdKJE9MdTedVkoojzZHl/1n1OW+Uj1lixxCXwWixmlox+Eg4OCuUrApZ4M
         5ZojnPPufjDNtmgdXis46dDAWtUhu33uSt4vdUEa4J2mDFtJWqEV4TlHqLShd6lJpbnC
         EWlQ7PeJcz/wrLDRnsPON0SgAq9+VQl3PTqJr4V1mF0ZxnyY7JmxNnnQfospX6JqQ7sY
         hybxxYiChGGOUsOMAFIfYzNmw22c24wzuK2t3+4qkRpAXsCSD43UtA6aoYm0sFbR5k40
         Mn8+FBBGJZ4lGwkSA3syQyFwCzhG2I7V/aGNU2IvHUBwxVFrKhcdxLUBeVNrWPO1nWBW
         OSpg==
X-Forwarded-Encrypted: i=1; AJvYcCXp18Hmiwyzo0SsLrwxWYe/dk30lOFjdOn13n53PBCtv8wo0wCag9xqkdDZET84VSvnBkpFiRQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyTDvi+d32hnI/oNGfbB35Q5ZGaBzz/wQ4+MxHlmOPB4N5i7md/
	LEVfZs3koZpOmIoVS+Y8MdN7ja2PBeBdAoRVrfMBxxoy5bc2j6qE7ZYZVIEyH3CPUTpfBaH+r85
	7x8GpeRuGCGq0Sxu/RSxBUmfwC2oUnCM8pj0uRTshvHk02tYwEIrMVTnSjFsQpMNfUSgVNKE=
X-Gm-Gg: ASbGncsfAk7QuEVCMSSjoGS9KIcKNsaOJXEo26G7uWqToAtbknT2ugITSd6oFK7W/Tx
	UhlYF3M/tV1U0GzPzeA39yILJcGFB5tji0O+TEyZ5mOlF2EdXt4l9AjlCELY1ufJSt3uaJtl225
	ERyf3+27/2p3k7kj1TSZgoKNq1Ex6MZVOirSTUEG/jcEnOjpAnUSIqZc30xzHdW8KRQtBY/pk9e
	vq2SD9N8CS/c28dPo1yncRuu/GcGcdXlYhL6kFEyaCXUBmLVHFwurrXADE4JzhTJOzQVyFOVd1O
	Dx637wrflFtc7BiZzJgJ0qHiNctYfrQj8hI2BSknZAN3wfYXDkj64utzBaLHQSJhmZjq0czhT/C
	SVAsVoiOZIjRiQJmWXWvv4D+Gq6fYfVdQoQ2MlQ==
X-Received: by 2002:a05:6a00:3e24:b0:76b:f1c9:4ec9 with SMTP id d2e1a72fcca58-76e2fc23e59mr1085309b3a.6.1755123870888;
        Wed, 13 Aug 2025 15:24:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrd6YX7PSuR1I0NvscqCwDnSHruYilibycjxTioyww4LMs5uJhtMWQp7pwAdosrJAlaZ3ajA==
X-Received: by 2002:a05:6a00:3e24:b0:76b:f1c9:4ec9 with SMTP id d2e1a72fcca58-76e2fc23e59mr1085287b3a.6.1755123870379;
        Wed, 13 Aug 2025 15:24:30 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd8ebbsm33032684b3a.102.2025.08.13.15.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:24:29 -0700 (PDT)
Message-ID: <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 08:24:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
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
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
 <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689d10a0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=ShNZIzb07UMatG3o2d8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7oeMStMbk2DWgq5VOkHcJK4PVrOll3SK
X-Proofpoint-ORIG-GUID: 7oeMStMbk2DWgq5VOkHcJK4PVrOll3SK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfXzj6DkqwOgQQg
 lSTY9jbO4WpQzoSFDUo2GHVVUz4SbgKTCAfazB6DjGENLm/mJwdzkdaYCw4+03jIKl0qWThneTL
 XqU37zVKXJ5QVhqvhdI1NHa+lwGlgL06J7e1IYo77PgWdVAIdPN259IOVarBygW8BVMHUqoUUek
 GyQ/UDftcxsqqmlhZQHvxuzdckotSKBMcTuwmF7AGYUitdLvxyTGnwLscplx5bxQdtiaubibPBm
 H3iAxttjFrHLwJB6oKvf5zWqMWIQw4hw6E8yqzI+V6TCcBtlCoIsqsLBHMpQJhLFcKwFOHylYuu
 q6A9yvmhmQCC2ln2/wREtYHJcIfPQXKQ8JhARQ8aSuUIxyEJR3gNtd7fmXwCOxUnCrieupW/0zY
 3yxn8SH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164
X-Rspamd-Queue-Id: 4642B42E10
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.14 / 15.00];
	BAYES_HAM(-2.04)[95.31%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.210.198:received,1.41.240.65:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 2DFUBAGATCME6YJSCZN44POMUEIHE6IU
X-Message-ID-Hash: 2DFUBAGATCME6YJSCZN44POMUEIHE6IU
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2DFUBAGATCME6YJSCZN44POMUEIHE6IU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>> Enable userspace to allocate shared memory with QTEE. Since
>> QTEE handles shared memory as object, a wrapper is implemented
>> to represent tee_shm as an object. The shared memory identifier,
>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +/* Mapping information format as expected by QTEE. */
>> +struct qcomtee_mapping_info {
>> +	u64 paddr;
>> +	u64 len;
>> +	u32 perms;
>> +} __packed;
> 
> Please use types with explicit endianness, e.g. __le32. I'm assuming
> TZ will always be little-endian, regardless of the host OS
> 

I'm not entirely sure how this point is relevant. As I understand it,
the core that populates this struct is the same one that accesses it in TZ.
Your argument would absolutely make sense if the host and TZ were operating
on different cores with distinct architectures -- such as one being
little-endian and the other big-endian, which is not the case.

Regards,
Amir

> Konrad

