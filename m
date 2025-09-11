Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE1ECA1016
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 03:19:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 21E6A4FDCD
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 03:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757560766;
	bh=9HSJ4M3l8wxlkJRoKo/XxAvhBmmLkYJR9qfWXwkpZmg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3cOve0TwKl/LoKnqs06J7NO44W5smwja5r4OXQVJoaDqxLMGLMdHUd1RmZvjiJQRC
	 p3oNwqnz6YaPfnq5H4Z6tKohZy7ye4+wyWO/N3VwyLp4FEHfxHn/zVClYG4NRkrJ8v
	 qUFT3UpUI5b36bpAFR4HDqegeDl3/vIdnIXXFwz6S1X+SAir66Ha66ZAmAx7E/lszt
	 yvEuKvH0iiIwyGdHQ3GDkhn6qKaGcQRqfmKR/Dm4yb357GZIE6En+pegpomHNRWqIv
	 3xkY6pUL7b8xixAf/1+w9+dGkxWQSHS5vuUlkQTjqzKQP8QxSCQ+O+PvSp+cO1KonD
	 Jg6A2hgucosug==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1A24243085
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:19:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L6vYqPhb;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2JGhH006978
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LMMz/beZCdvqVQXt7ljdBTCVb0kcIqN10eziEUpqZKc=; b=L6vYqPhbj1DwYMfV
	oxvIRvTXnjvcVhM+OR3ScjO+gqbGmYKp37bx+jwl0L1wf90FIsL5r3yn7CRv3DBZ
	WUv1zHvhwjrGSXULwESjDewtySwTSlO/p0Bk8gc8fbZu4BjlarHLZOWl/DC77iky
	ghvAK/sLwmgWVhvybsJNH7PLh3bNDQOOBPi3XjuWja1umJpa4Od4EZUqEZ/Uqfqk
	5c/FB6xR0PtQRrXeSL+wM7ZgkmAD8oR/9wYXmjrQdRITlmuUKt+hfL09bYQluZi3
	AZrScIN1MnpCvY4CcpgaG6JisrrG1awIMB4ZvaXuajwfrruoXA9Wix6T4EaHSPDj
	tNGGRQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2a40q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:19:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329e1e3b25bso252684a91.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 20:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757560748; x=1758165548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMMz/beZCdvqVQXt7ljdBTCVb0kcIqN10eziEUpqZKc=;
        b=Wl0zWtG+rlUzNvzdH2tVEiJzyYp+kvyqTSjDfSrsG8/YV+G+NfEYqusMGgz00TzkbX
         6K2d43IQR4nTDDO6E9TanRhLvCD+2hxly0e0yKoWYDEfzJiPvhHJYfI3TLzGnVOl3Sid
         KRaZ7bNsO8hIJlmqWBAsuurNNt8+Z9mW19A891jse8ZeEk+UMONO3dbNWMaEJO+VZvkg
         bTjHpJOSDry+b5twSjNnTrO3+70tH4RwcMGhDdRPDYLmWGJKkMWIedXQT/PHE+ddX6//
         GrytfQ9ToIF5eYYy8v8YbFDVkuw7HsLE5kztP03WleiZtwNtDYb0hEUraP6tgsyuD72s
         S1og==
X-Forwarded-Encrypted: i=1; AJvYcCWmih4QNIWoQ3JvBp62vXd/7syU7EEBYTP70ZxiGEXMXKDGWwF8bLpfAQ5uqprLMUsf4IVaZdc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzYzvbqrgLqbO2HSTxJAuU7F/zjlS7xk2IIHhDB0etf37Uh/uX0
	eD4tO3SX8TU2h4ka9l30z3iMrfWVeCJCEa0P+M7OK7f/HRTCRtOaNGQ45HOyNXlarqwhN7x0zmb
	rhXV5dt/svO0HbVASRu+XiCHisxaV09xsEvkQRM3M2b6K8E8UZRaDmhsnJfZadHsiNEXO6FA=
X-Gm-Gg: ASbGncvgybmqaHGM9ps/xMJbeKAF8TwSRXPkknC/Qg+k9O3ey6k6WH03p53gsiAI3ba
	hjNryPBkn0nuF7SMvxenJ/KFoiZ29hkhf0HJA5gTNstrimsqsI3eJ22qIUDrpUElS8Z72v6iT6I
	IyPQ9uWq1D9XmrmONOIkn+uyI0boaoyjWN170bxpC/tygWKCxH0E1XzQ/ZFYYCabYJtWDO4RPpC
	1QMkL7I4E7RHDY9xl5aGPyghmCuA8bQZ1wEjtgMYLCxKcZKl4lYYEOphNSP44/G6xo4DahDhmDI
	ADZU39eSWXN8YrJUgEAndM2vQdSfIsEuwu6cW+IF8G+SlcFqYytGhcETtM5c8g0u5sh+NsNW4Fn
	bYzOJb0404LHeJ8V33s6fxD0BaoR2BgG+gDKN4A==
X-Received: by 2002:a17:902:ce06:b0:24e:e5c9:ed07 with SMTP id d9443c01a7336-2517311894dmr260007505ad.36.1757560747496;
        Wed, 10 Sep 2025 20:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ6oFZGsoKEF6YNPd0EkmIus1YyTMDPHQIG1x59bSwD39p0/YQfyp9Xmnvg21I1G/sYxEahA==
X-Received: by 2002:a17:902:ce06:b0:24e:e5c9:ed07 with SMTP id d9443c01a7336-2517311894dmr260006635ad.36.1757560746789;
        Wed, 10 Sep 2025 20:19:06 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304ce8sm2660265ad.128.2025.09.10.20.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 20:19:06 -0700 (PDT)
Message-ID: <23fe069e-727f-4bc3-a526-9320090991ed@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 13:18:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Sumit Garg <sumit.garg@kernel.org>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
 <aMEINycp24DG6KXO@sumit-X1>
Content-Language: en-US
In-Reply-To: <aMEINycp24DG6KXO@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c23fad cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=PQODIOjcjKhI4WzMhAgA:9
 a=D8jLBtTEXUNSpw3P:21 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZCxIpLFxa7GwRjU_BpJAg_hKOEMM9jmL
X-Proofpoint-GUID: ZCxIpLFxa7GwRjU_BpJAg_hKOEMM9jmL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX0/9ShmQxGIy3
 5l1Fuj1YcigWQpN5hw4g86BP4YF4eQjjEnbRmRPDRZAJk87JPt27qD0DMNPnyrUyrmr9noKv80K
 E8eGbPn6q645IAfNAnhBAjvFizEA0DNLRBSgQDL+RvIPsOAOG7fBe39xgT2Ir3MQaFTFBMvnm50
 4FvkBSczLjRMnGca8mVzqvaHTAIY9LyRqEVEPLOAqyXeNlaowp+JS3VnaCXD1ZRhH6KCNyx+dAH
 htqu/F8qyH3OsttQjjY8ns/890Ejl+He1NtUJ6A9APZmaf99bZc8XCNWAidz2SUH+Fpa46dhzfZ
 37OVuvK1EmN4v8S7IF/i0WvPDAnVwFaJsmo0Xn6VGk9MT3/kiEuBCdMJmu4t4b/CPWYgBRjiW+5
 ziKcw4RU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094
X-Rspamd-Queue-Id: 1A24243085
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[21];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: ZPLJWFEAZWTUHTLBZLJGNNKBJGUANDVV
X-Message-ID-Hash: ZPLJWFEAZWTUHTLBZLJGNNKBJGUANDVV
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZPLJWFEAZWTUHTLBZLJGNNKBJGUANDVV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Sumit,

On 9/10/2025 3:10 PM, Sumit Garg wrote:
> Hi Amir,
> 
> On Tue, Sep 09, 2025 at 05:11:02PM -0700, Amirreza Zarrabi wrote:
>> This patch series introduces a Trusted Execution Environment (TEE)
>> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
>> and services to run securely. It uses an object-based interface, where
>> each service is an object with sets of operations. Clients can invoke
>> these operations on objects, which can generate results, including other
>> objects. For example, an object can load a TA and return another object
>> that represents the loaded TA, allowing access to its services.
>>
>> Kernel and userspace services are also available to QTEE through a
>> similar approach. QTEE makes callback requests that are converted into
>> object invocations. These objects can represent services within the
>> kernel or userspace process.
>>
>> Note: This patch series focuses on QTEE objects and userspace services.
>>
>> Linux already provides a TEE subsystem, which is described in [1]. The
>> tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
>> can be used by userspace to talk to a TEE backend driver. We extend the
>> Linux TEE subsystem to understand object parameters and an ioctl call so
>> client can invoke objects in QTEE:
>>
>>   - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
>>   - TEE_IOC_OBJECT_INVOKE
>>
>> The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
>> used for invoking services in the userspace process by QTEE.
>>
>> The TEE backend driver uses the QTEE Transport Message to communicate
>> with QTEE. Interactions through the object INVOKE interface are
>> translated into QTEE messages. Likewise, object invocations from QTEE
>> for userspace objects are converted into SEND/RECV ioctl calls to
>> supplicants.
>>
>> The details of QTEE Transport Message to communicate with QTEE is
>> available in [PATCH 12/12] Documentation: tee: Add Qualcomm TEE driver.
>>
>> You can run basic tests with following steps:
>> git clone https://github.com/quic/quic-teec.git
>> cd quic-teec
>> mkdir build
>> cmake .. -DCMAKE_TOOLCHAIN_FILE=CMakeToolchain.txt -DBUILD_UNITTEST=ON
>>
>> https://github.com/quic/quic-teec/blob/main/README.md lists dependencies
>> needed to build the above.
>>
>> More comprehensive tests are availabe at
>> https://github.com/qualcomm/minkipc.
>>
>> root@qcom-armv8a:~# qtee_supplicant &
>> root@qcom-armv8a:~# qtee_supplicant: process entry PPID = 378
>> Total listener services to start = 4
>> Opening CRequestTABuffer_open
>> Path /data/
>> register_service ::Opening CRegisterTABufCBO_UID
>> Calling TAbufCBO Register
>> QTEE_SUPPLICANT RUNNING
>>  
>> root@qcom-armv8a:~# smcinvoke_client -c /data 1
>> Run callback obj test...
>> Load /data/tzecotestapp.mbn, size 52192, buf 0x1e44ba0.
>> System Time: 2024-02-27 17:26:31
>> PASSED - Callback tests with Buffer inputs.
>> PASSED - Callback tests with Remote and Callback object inputs.
>> PASSED - Callback tests with Memory Object inputs.
>> TEST PASSED!
>> root@qcom-armv8a:~#
>> root@qcom-armv8a:~# smcinvoke_client -m /data 1
>> Run memory obj test...
>> Load /data/tzecotestapp.mbn, size 52192, buf 0x26cafba0.
>> System Time: 2024-02-27 17:26:39
>> PASSED - Single Memory Object access Test.
>> PASSED - Two Memory Object access Test.
>> TEST PASSED!
>>
>> This series has been tested for QTEE object invocations, including
>> loading a TA, requesting services from the TA, memory sharing, and
>> handling callback requests to a supplicant.
>>
>> Tested platforms: sm8650-mtp, sm8550-qrd, sm8650-qrd, sm8650-hdk
>>
>> [1] https://www.kernel.org/doc/Documentation/tee.txt
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>
>> Changes in v10:
>> - Remove all loggings in qcom_scm_qtee_init().
>> - Reorder patches.
>> - Link to v9:
>>   https://lore.kernel.org/r/20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com
> 
> It's still not rebased on top of linux-next and have merge conflicts,
> see my comments here [1].
> 
> [1] https://lore.kernel.org/all/aL_MCagNVIDXW0wp@sumit-X1/
> 
> -Sumit

Thanks, I'll rebase.

As per Bjorn's request, I removed the logging messages entirely,
as they seemed redundant. ;).

Regards,
Amir

> 
>>
>> Changes in v9:
>> - Remove unnecessary logging in qcom_scm_probe().
>> - Replace the platform_device_alloc()/add() sequence with
>>   platform_device_register_data().
>> - Fixed sparse warning.
>> - Fixed documentation typo.
>> - Link to v8:
>>   https://lore.kernel.org/r/20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com
>>
>> Changes in v8:
>> - Check if arguments to qcom_scm_qtee_invoke_smc() and
>>   qcom_scm_qtee_callback_response() are NULL.
>> - Add CPU_BIG_ENDIAN as a dependency to Kconfig.
>> - Fixed kernel bot errors.
>> - Link to v7:
>>   https://lore.kernel.org/r/20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com
>>
>> Changes in v7:
>> - Updated copyrights.
>> - Updated Acked-by: tags.
>> - Fixed kernel bot errors.
>> - Link to v6:
>>   https://lore.kernel.org/r/20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com
>>
>> Changes in v6:
>> - Relocate QTEE version into the driver's main service structure.
>> - Simplfies qcomtee_objref_to_arg() and qcomtee_objref_from_arg().
>> - Enhanced the return logic of qcomtee_object_do_invoke_internal().
>> - Improve comments and remove redundant checks.
>> - Improve helpers in qcomtee_msh.h to use GENMASK() and FIELD_GET().
>> - updated Tested-by:, Acked-by:, and Reviewed-by: tags
>> - Link to v5:
>>   https://lore.kernel.org/r/20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com
>>
>> Changes in v5:
>> - Remove references to kernel services and public APIs.
>> - Support auto detection for failing devices (e.g., RB1, RB4).
>> - Add helpers for obtaining client environment and service objects.
>> - Query the QTEE version and print it.
>> - Move remaining static variables, including the object table, to struct
>>   qcomtee.
>> - Update TEE_MAX_ARG_SIZE to 4096.
>> - Add a dependancy to QCOM_TZMEM_MODE_SHMBRIDGE in Kconfig
>> - Reorganize code by removing release.c and qcom_scm.c.
>> - Add more error messages and improve comments.
>> - updated Tested-by:, Acked-by:, and Reviewed-by: tags
>> - Link to v4: https://lore.kernel.org/r/20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com
>>
>> Changes in v4:
>> - Move teedev_ctx_get/put and tee_device_get/put to tee_core.h.
>> - Rename object to id in struct tee_ioctl_object_invoke_arg.
>> - Replace spinlock with mutex for qtee_objects_idr.
>> - Move qcomtee_object_get to qcomtee_user/memobj_param_to_object.
>> - More code cleanup following the comments.
>> - Cleanup documentations.
>> - Update MAINTAINERS file.
>> - Link to v3: https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com
>>
>> Changes in v3:
>> - Export shm_bridge create/delete APIs.
>> - Enable support for QTEE memory objects.
>> - Update the memory management code to use the TEE subsystem for all
>>   allocations using the pool.
>> - Move all driver states into the driver's main service struct.
>> - Add more documentations.
>> - Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-0-297eacd0d34f@quicinc.com
>>
>> Changes in v2:
>> - Clean up commit messages and comments.
>> - Use better names such as ubuf instead of membuf or QCOMTEE prefix
>>   instead of QCOM_TEE, or names that are more consistent with other
>>   TEE-backend drivers such as qcomtee_context_data instead of
>>   qcom_tee_context.
>> - Drop the DTS patch and instantiate the device from the scm driver.
>> - Use a single structure for all driver's internal states.
>> - Drop srcu primitives and use the existing mutex for synchronization
>>   between the supplicant and QTEE.
>> - Directly use tee_context to track the lifetime of qcomtee_context_data.
>> - Add close_context() to be called when the user closes the tee_context.
>> - Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com
>>
>> Changes in v1:
>> - It is a complete rewrite to utilize the TEE subsystem.
>> - Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com
>>
>> ---
>> Amirreza Zarrabi (11):
>>       firmware: qcom: tzmem: export shm_bridge create/delete
>>       firmware: qcom: scm: add support for object invocation
>>       tee: allow a driver to allocate a tee_device without a pool
>>       tee: add close_context to TEE driver operation
>>       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
>>       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
>>       tee: increase TEE_MAX_ARG_SIZE to 4096
>>       tee: add Qualcomm TEE driver
>>       tee: qcom: add primordial object
>>       tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
>>       Documentation: tee: Add Qualcomm TEE driver
>>
>>  Documentation/tee/index.rst              |   1 +
>>  Documentation/tee/qtee.rst               |  96 ++++
>>  MAINTAINERS                              |   7 +
>>  drivers/firmware/qcom/qcom_scm.c         | 119 ++++
>>  drivers/firmware/qcom/qcom_scm.h         |   7 +
>>  drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
>>  drivers/tee/Kconfig                      |   1 +
>>  drivers/tee/Makefile                     |   1 +
>>  drivers/tee/qcomtee/Kconfig              |  12 +
>>  drivers/tee/qcomtee/Makefile             |   9 +
>>  drivers/tee/qcomtee/async.c              | 182 ++++++
>>  drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++++++++
>>  drivers/tee/qcomtee/core.c               | 915 +++++++++++++++++++++++++++++++
>>  drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
>>  drivers/tee/qcomtee/primordial_obj.c     | 113 ++++
>>  drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
>>  drivers/tee/qcomtee/qcomtee_msg.h        | 304 ++++++++++
>>  drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
>>  drivers/tee/qcomtee/shm.c                | 150 +++++
>>  drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++++
>>  drivers/tee/tee_core.c                   | 127 ++++-
>>  drivers/tee/tee_private.h                |   6 -
>>  include/linux/firmware/qcom/qcom_scm.h   |   6 +
>>  include/linux/firmware/qcom/qcom_tzmem.h |  15 +
>>  include/linux/tee_core.h                 |  54 +-
>>  include/linux/tee_drv.h                  |  12 +
>>  include/uapi/linux/tee.h                 |  56 +-
>>  27 files changed, 4410 insertions(+), 28 deletions(-)
>> ---
>> base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
>> change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
>>
>> Best regards,
>> -- 
>> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>

