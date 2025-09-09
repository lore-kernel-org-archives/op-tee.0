Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8084DCAC58C
	for <op-tee@archiver.kernel.org>; Tue,  9 Sep 2025 21:00:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A57A64FD3D
	for <op-tee@archiver.kernel.org>; Tue,  9 Sep 2025 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757451627;
	bh=8V4Bhzzvs9zygxGz2U+YuP2tINhCtsLXcU+asmS+6Ss=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=B4R0NjvBe4pEl6GyQ1vxjsnggIHzDqfzXdICO+XjbBOVB2laBEi6LMscMAjS/F0vx
	 yXvnRGFxvME0UFulcYg2EXJdrMow6fmUvcTfWPIfquXHBeZFcz+TM63T00GZh9DoLa
	 i/Mw4YEiwrlYBy3xCQilIXN4yi2p4Vv4n6t0pwjC2tmHw/rxSvsP0ai7GqFUQxF/fa
	 RS+X05OAmTiPP6p7LuHnria2lcixlBvNoUilBbY05F8z2bOMyXotaqgnDfmdWoVwNS
	 R+OLh9LQYLCBnZB2wVO5xPORmJDtzrKSqgvr2+J2a6nfPmB9q7/pAkOAYiOr8NDg6u
	 704aeFrBmmHTw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 510B042DDD
	for <op-tee@lists.trustedfirmware.org>; Tue,  9 Sep 2025 21:00:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PxPB7rPQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HaeMB004152
	for <op-tee@lists.trustedfirmware.org>; Tue, 9 Sep 2025 21:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xla17iJicYpKev/QNXdqc8YcoWYyLjkenruSMyyFfa8=; b=PxPB7rPQ4svcQSZQ
	QyjZu2uiYaqvb9a3H+sQlwH/5aiW1bSUw8kNNgxFWy+b2mR2E4Hp6ba6fVtdeDWm
	B9Gx7XeuECSawjDilO8l0S+3x3iyDC+KVq3kMIgeWINY26JtjPKxqCyBf6dS9dzC
	eDu3YbukAeyf1AaVu+/9Z7I4LTNL69l2SV7OlLtbqTPXhDFepWKgNWL68ohRVfJE
	xqsCzivs5cBK6Wurfcc8FkW7kbbk6hxdbrvf5OfQz3O+3pKUDr5eyHE0ds+xafEm
	Io+Wl0E0nTmWYVaTAZZryYK6sbemW2M1j96xRtzrnC/AbrKh0ULjeqnV12JtGLUa
	KBAtzg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aaphxpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 09 Sep 2025 21:00:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7723d779674so5524731b3a.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 09 Sep 2025 14:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757451605; x=1758056405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xla17iJicYpKev/QNXdqc8YcoWYyLjkenruSMyyFfa8=;
        b=b1YLP+oz39BZnqZZOWjdjHxLSjTQQQ+FjKxtOlk9mQFoH1tQKYosv9zV1MpbVNX9gr
         PqPTT4R/QmBB0QgElByNtxx3br03Zz7gs6ubkDNV7I0aCJujj+4dOENWOfrqmEhjLPuQ
         JFLkYrta+6kQCk4LFJ28KtGzw3K7CmuSlRMp/FzWz+WLSESmDL9BYM2iUmHef9T07qxJ
         xOMtRqHmM18e8m15aLqug5rYlDx/65LlatiEOkey1iw3MKI+leJUrcW5kQ3w+eebRVPC
         qETW/MUWXDwYDAUN2twWvlr0Pk0ejT2kGheYxx43u2TYkM6FJ71Oc/nrRFPqs+tnfDy2
         xqHw==
X-Forwarded-Encrypted: i=1; AJvYcCXv47QWBzFkMEGOjXvKR+wbSh3Jbu+ZYShBVdkdmZDE7RgQbDP7XpUD9g0IMEMUgbmrqYJ5fgs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxZFOCqL7Ul4ZaSf0JLJ2zCHGg6ayNLWBZwF6u1zKhm4pczlYbm
	NqcBf0C4lm+ns09E+sFeHnVpnXAKFx9qgKxjLXwCHzf6U1FCx9vUMx50DW8ijWbv88xf1QVaBYM
	dggRuUgCIdGgQvYjLIBCk+Z73lN54OM3ItQsOVS+qsjArvd7l1RDorMMf8beaUYnL6zK1rKk=
X-Gm-Gg: ASbGncvt7DXpmCztxma149uFtzE98opOUg1cv3KSflDgo2geIwrY+pEBJ4/ZcVN2+kq
	fwZfZdYQfLRxlCkMx1ztnOr1Nsdi9wQwhtz0GzGbzBFMP8sCcTdtpgi0B5uC9mTCHg6vsAaNypa
	tQBYDMp+TFKVNaE2xDRa1obt/NOtv6LaB23HXechpvlZed8TfioFYV7frEk6eAJNADlwD3HgCg5
	rqZF87e3+KAJzYjdTyfkCBj0NKSaT1zMwD0SwZf49FQHJGWs9qNe3DQEPv9odgPbt88SI/mt/F6
	t42SFAOSEY4v+XtsG9442Tt75p7NZohx8D3DsDhknBqQEJ5OTyQl9TtBcj0RVpKyOc5VYSOS7rj
	OGPNB3KGUblNfWEkoNeofR2Pvn+ZrW9Vhx/U+kA==
X-Received: by 2002:a05:6a00:1792:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7742dd506a1mr14346035b3a.10.1757451604576;
        Tue, 09 Sep 2025 14:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPoCCl4oTUfrkkB6L6KOV3tgeo10q/nP1o0Y+0BVtF89ZoRpxM+guv+SKYacMeBkrnqcUTvg==
X-Received: by 2002:a05:6a00:1792:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7742dd506a1mr14345987b3a.10.1757451603933;
        Tue, 09 Sep 2025 14:00:03 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774661559a1sm2913058b3a.45.2025.09.09.13.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:00:03 -0700 (PDT)
Message-ID: <810b5737-53de-42f8-96d7-1c712cb87822@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 06:59:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Bjorn Andersson <andersson@kernel.org>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
 <rvz274v27t54iktoa6uds5hyrs5ujkmahdl4o635gkah7cw277@jf4fjp5wb7ci>
Content-Language: en-US
In-Reply-To: <rvz274v27t54iktoa6uds5hyrs5ujkmahdl4o635gkah7cw277@jf4fjp5wb7ci>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c09556 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=PQODIOjcjKhI4WzMhAgA:9
 a=lVWfZRcH457ZfW6I:21 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NkWUVfdUza-ZZTsgICsudXmlk-fkligj
X-Proofpoint-ORIG-GUID: NkWUVfdUza-ZZTsgICsudXmlk-fkligj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX5eVu+A6HeP2E
 XCePOCJvlLL0y5CVkn+i7wY6D1O29nVemmq1110yMvkl57jy1BMc9DTiGp3nqxMU00Txl8ks89w
 dRbjQnjVQJ3eSM9WAiRnDKwByyoJTJGpfbOlFH9DGPJC4wbmnIOWseluoPckvZXOThLwijqmCdV
 8SX4JZnpwHXA8IqR1R3XKLb5KjZJIuZ2YkzF3maFXXca4Un+xVd4aW3pv5vJW4FmtJjwtmYAn6J
 uxrp+0pFNDRAp1JH4I17wqkhcuikDVcFRSTAuZP/QTjkbmnR13F5mnLIkRSi5QwzL2LA1Bo4iQd
 9EnZcSImbE/DGnHDBci/d9yBnBXaQeIy9fhLZUXNGdYZ8TDWop6wYzznbwKNivDA4e4yxDWAnNS
 N6F2ItnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000
X-Rspamd-Queue-Id: 510B042DDD
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[21];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[1.41.240.65:received,209.85.210.197:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 3AHYKHBCUY6QIPZXLOMRYD4DDFHOKGHI
X-Message-ID-Hash: 3AHYKHBCUY6QIPZXLOMRYD4DDFHOKGHI
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3AHYKHBCUY6QIPZXLOMRYD4DDFHOKGHI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 9/10/2025 1:03 AM, Bjorn Andersson wrote:
> On Mon, Sep 01, 2025 at 09:55:47PM -0700, Amirreza Zarrabi wrote:
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
>>       tee: allow a driver to allocate a tee_device without a pool
>>       tee: add close_context to TEE driver operation
>>       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
>>       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
>>       tee: increase TEE_MAX_ARG_SIZE to 4096
>>       firmware: qcom: scm: add support for object invocation
>>       firmware: qcom: tzmem: export shm_bridge create/delete
> 
> These two patches are for code maintained by me, the rest by Jens. So we
> will have to dance to get this merged.
> 
> Is there are reason why these two are in the middle of the series? Do
> they need to come after the first 5 but before the next 3?
> 
> Regards,
> Bjorn
> 

There is no functional reason - it's just that they belong to QC,
so I kept them close together.

I'll move both ahead of all other TEE-related items.

Regards,
Amir


>>       tee: add Qualcomm TEE driver
>>       tee: qcom: add primordial object
>>       tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
>>       Documentation: tee: Add Qualcomm TEE driver
>>
>>  Documentation/tee/index.rst              |   1 +
>>  Documentation/tee/qtee.rst               |  96 ++++
>>  MAINTAINERS                              |   7 +
>>  drivers/firmware/qcom/qcom_scm.c         | 124 +++++
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
>>  27 files changed, 4415 insertions(+), 28 deletions(-)
>> ---
>> base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
>> change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
>>
>> Best regards,
>> -- 
>> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>

