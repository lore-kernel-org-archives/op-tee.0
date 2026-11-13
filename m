Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AD606A331
	for <op-tee@archiver.kernel.org>; Fri, 13 Nov 2026 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VXmdwO09;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UYQP4CU7
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 55D1A45374
	for <op-tee@archiver.kernel.org>; Fri, 13 Nov 2026 20:46:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VXmdwO09;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UYQP4CU7;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 80CB441BD6
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Nov 2026 20:45:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADKKF1X1291060
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Nov 2026 20:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b8GYNp9h1BN6LZCaFYnOi9RO+fehzDHVEHwdAXLSsuk=; b=VXmdwO09mKW3S/x7
	+wEETAizqcfOdCmVksYiKAMMhQWrf7IC3qpiAIDefnCV0TTrYQO+R5Eb+tl0zjEg
	he3zfJ7lkuESA7BZyVmMg57NxOvxb5P4C58dfVAQPM0z9NIb0oVpEJRKbyg50gbD
	feXOft05NYpxwrw/WfkvGll4+YdpVgKQ1A5l36nYKVTekTJsw1zxH1SfdfI/Q03k
	9TZ3dqYlPc1L/xJaeNLsJ7qxzG33VnLOuibXnGcag8J4X1dAHwBJTmqBRaXtXllE
	d5XOtILggd9s+D/cZNEm8rUlnPxZshrEzxOvvMs2THAAdJ3bHBwk/wiOBCZm6Xw2
	ZDOufw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvjab6w4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Nov 2026 20:45:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36efb506f29so1490649eec.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 13 Nov 2026 12:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794602753; x=1795207553; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b8GYNp9h1BN6LZCaFYnOi9RO+fehzDHVEHwdAXLSsuk=;
        b=UYQP4CU7o0A8Zm1NRP0Qm4A97ID3DQSHAe+WrfGGLph/gAQiNZd2Wo3NgKkuGn31/N
         OrhO4Q6fixso4zONBP0tbCkCqvmLQmaALEz+odmC8MC7e6jGLsZ9vMOrvi2WIXTqpWEI
         j8NC/biIWqSirssuAS7Sw0Eh5wl5PHQLiZUqqiS3qMIC5WE9+DPJpCmtIqpQthvHQF2I
         wfemGk4fXoMP8XYEcdZMK38aB0kpQMzSaXoruCUehE6gqqO6AE1tRybyimF6/VLDjq5J
         QvDcfn9+Na9+k6FAfQvVuomvaC0Sk5FiEKu2WVW5i5e4JWXl/p5RGf17A6A3DieXH6cZ
         0AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602753; x=1795207553;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b8GYNp9h1BN6LZCaFYnOi9RO+fehzDHVEHwdAXLSsuk=;
        b=kAu0/XOGcg75Q88XybzU/9xywfEv9lDoUc7fdnTxFu+mYSZRUfWGuvZ0b5XqibKrah
         sNMputt07QCSCbOaqHZKC6ZBhqKJl5JexJZYk/45js08pOAEFfXFSjU3x0eSfqSENzQW
         FdvNEre0yPAx76zmFX8vVO+iFC2E662TyBT8R/AcUb2Ro9Q6CLzCz95ZfXn7Cvb3GKqZ
         6nFNuF5Y+scOWaCngOShc7JRWWYLFLHv4DzC8Oopa5e8YFXLopjVFKZdqtr80ZY90Zzb
         vYSAlm7f214LxB3XkVLI8QjyIKssHc8mdF+V/0lIv58ScniYYWJ65CgKxL2bWj6nApVt
         TCWg==
X-Forwarded-Encrypted: i=1; AL+hErH+fkJV1SRGXfp4sv/CH/XNsHYX8R/uiKGvSlyqdWFiECvMhe/AIg66K3RXt4fAsNAG3y8R/bQ=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/OnMid+x+UEDrRsLSQM++w66AsE+6S2+yvogUCPfBJDS6Ir0lg
	PY6QDALZ5S8f6TY8lUKw5K/fPbsojD1ge//MuRjdulGzFsLA8uSRgONsGI+QMXIj5n2CKKviAz5
	3+StwKuZ5mhlJw/7Ztx16OQ8xx0uunIvLz+zQVCevAJE94EWH1wWAyo0YzsBvtxfNhHkLd0ls
X-Gm-Gg: AYBFou1CfktXBl/ol+RPxHIrXjTrUsyXQ7k368NzXdkjUyA7Jfdq4CuyVXdYvJTvEfs
	R0lnGWJTYaRaEokEUINlzhFzTUoQH6xqV7C374eJS1EcFgybX7I/uOdX5s0GFHM5XgG3ywXCr3u
	+xphYfbOtaZAjmaqDny3LdtYxRg/3BbphGGixPU1dazwJGd0RMTYvF+UJojFBMfQJbYy5sD+MkU
	0UaBuLcqGQNF9b9Q7Yoj5lJQwWg1ka2jBqmlwhUGo0TeQYY/3DQqTfzT/11S6nOyxBbroiuaQC7
	djjFbwcWmAhmXMViefGEaqZB83xTa2KBLvEApFaP17WnsOGqvFNbvrE+qphoqmn/99f8F7qlOcf
	VBbs9o3FChQF/BXoDqx+gA3z0i0Ki2jhdKseCa2rDvKsJEYC2RN5ZnE1lT2U04zePXHXSYPf9MO
	EapQ==
X-Received: by 2002:a05:7301:4614:b0:36a:12bb:7f8e with SMTP id 5a478bee46e88-379655d45c1mr2796751eec.13.1794602753194;
        Fri, 13 Nov 2026 12:45:53 -0800 (PST)
X-Received: by 2002:a05:7301:4614:b0:36a:12bb:7f8e with SMTP id 5a478bee46e88-379655d45c1mr2796723eec.13.1794602752466;
        Fri, 13 Nov 2026 12:45:52 -0800 (PST)
Received: from [192.168.29.10] ([49.37.154.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm9032968eec.4.2026.11.13.12.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 12:45:52 -0800 (PST)
Message-ID: <1317a8b2-2f12-416c-aa12-8d0262e0d3c9@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 02:15:46 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] tee: optee: Register TEE devices on the platform
 bus
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
To: Eric Biggers <ebiggers@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Selvam Sathappan Periakaruppan <selvam.periakaruppan@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>
References: <20261111-ice-migrate-tee-svc-v2-0-29d19f6c92ab@oss.qualcomm.com>
 <20261111-ice-migrate-tee-svc-v2-4-29d19f6c92ab@oss.qualcomm.com>
 <197d7d58-9791-483f-9a7f-40747f44d1ee@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <197d7d58-9791-483f-9a7f-40747f44d1ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: k6ldVRzCHCMJNiXCDo2Mp3O9Z48ylIws
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4MiBTYWx0ZWRfX/YotnrDXkofn
 MihXa/cOBCvO+G4+Fv7686UZYCaWH9j/JdRuAk+z1RTPMR4TJMuSMv4h6Hob20VK/jhHIlcnNC4
 QlnajJL3uK28wJQNST5YUNz1OGmgrFE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4MiBTYWx0ZWRfX0BIOdf/2A9Jh
 YQLhTthGM6R7W6fiCVNHzz9CL51b1gPfpx3LaLdCv26a41SYTuMgOlywHHi9ZEiVb8XxNMimVvZ
 vccY68JxpRA73KvNHvinN6D77uu8Tx6MwsoMgn3ebNqSQLVy1lGYuQFUdw4bCdquGcqH5gcWTjI
 tZkZknbhou2AYVcCyh9yc5Adw2mVy2xOiOidVszIKB3s6IyXSsK3ZgP4fW5WN5XCzOC9RY/LpCZ
 +9wNvvhJ0fWtuYmPmGMRwaWOTZmiewK32TGoAW1slFbMSM2+BhyTMxHec72B0DD31ROecuPGolX
 ZkTdrCh+mUrmeJABKvUN97buQqttXwwBrFIXa59Jm26L+v/UfIVxZQZAG04s+R8u7DbkAsAM1MV
 pcWoYo/9OUbO3TLWop+5efBpXzLaKWRAj8aDx+01crzn2DA79a/fkYG3YsF7wJpfPP+3lD5NLk5
 DAlDh/giIhMqEIT2ZIg==
X-Proofpoint-ORIG-GUID: k6ldVRzCHCMJNiXCDo2Mp3O9Z48ylIws
X-Authority-Analysis: v=2.4 cv=AoN7T+9P c=1 sm=1 tr=0 ts=6af77702 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=KJEteu+P7FD/DYblE0u4eA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=b45o4kL6AAAA:8 a=EUspDBNiAAAA:8 a=EpkGB4z7we3iSK_TefgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130082
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[74.125.82.199:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 80CB441BD6
X-Spamd-Bar: ------
Message-ID-Hash: JOZDZCR3E5FVZS2VJE5JE4RNIPT2FBYL
X-Message-ID-Hash: JOZDZCR3E5FVZS2VJE5JE4RNIPT2FBYL
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JOZDZCR3E5FVZS2VJE5JE4RNIPT2FBYL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11-11-2026 08:27 pm, Harshal Dev wrote:
> + op-tee@lists.trustedfirmware.org, Jens Wiklander <jens.wiklander@oss.qualcomm.com>
> 
> On 11-11-2026 07:47 pm, Harshal Dev wrote:
>> The Qualcomm Inline Crypto Engine (ICE) driver is an independent platform
>> driver which polls on availability of a TEE interface (SCM driver) before
>> checking if the ICE secure service is supported by QTEE by querying the
>> qcom_scm_ice_available() API.
>>
>> The TEE subsystem currently does not provide any way to notify regarding
>> the availability of a TEE interface, i.e. whether QCOMTEE or OPTEE have
>> probed. And so when migrating to the TEE subsystem via an ICE TEE client
>> driver, ICE needs to defer probe until the OPTEE ICE Pseudo TA becomes
>> available on the TEE bus. This means that for OPTEE builds without the
>> ICE PTA, the ICE driver would indefintely defer probe and the dependent
>> UFS/SDHC storage driver will fail to come online.
>>
>> Add support for optionally registering the back-end TEE devices which
>> represent a particular TEE (say OPTEE) on the platform bus via the
>> tee_platform_device_register() API. 

I've been thinking a bit more about this. Instead of introducing a new
API on the TEE subsystem for re-registering the back-end TEE device on a
platform/auxiliary bus, can we just register the (OP)TEE device on the TEE
bus itself once all the Pseudo TAs have been enumerated?

This could be a reserved device with a reserved UUID that the client drivers
cannot interact with via the usual tee_open_session() function, and would be
returned an error.

A TEE client driver who wants to be notified once all the PTAs have been
enumerated on the TEE bus can register for this reserved OPTEE UUID and be
informed of this event via its registered probe() function for this device.

The TEE back-end device would be a sort of "end-of-line" marker for all the
PTAs on the TEE bus.

Let me know your thoughts.

Regards,
Harshal

>> This allows drivers which poll on
>> TEE secure interface availability to be notified even if the TEE service
>> itself is not supported.
>>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---


