Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D5EC44536
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 23:43:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BD65043154
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 23:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784763821;
	bh=BNZuPLsbwVrBkfBs2VW6qnKvSIvcr1UzWHt6KNeYgUg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=f+Y2X3ITd3DNc+z+I44q1EmvfCxvyx0UcrGnaWkTvHj/44dg341cQ2Gl8pTWbh9ld
	 1Q09qZxIGr6UhXdP2iQ1+pDqfudaQLURyyk2i+FnAUIQXx+8KzUCzsHYUTaqXTarSY
	 G6WIB/he5Zmm0usP4KnIsB16Sw3kkqLHW1vMvPXA16JOjoATXjfwXOQ+Ax4eAvwLmZ
	 co2qaIiOPCahKyr/FgSuOSfIRtR3WV2iqzOv7Rpg74S7o+EAZ+vzt/lvegrfY8KcIG
	 iOrzMf01aANxRG3x6shU0Oh/BewG/Rz2i7UUhSol9thAu5SwkGBsa6kdA3gSc4ZDpt
	 afRocwGQnG7eQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3D73B43154
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 23:43:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=amEbmXcX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EVU4UBNL;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MMnxjW2254970
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 23:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VM4Q4+Q9bC+Ys9BdhS6aCA8dDkeyBz8iQ9iFH0DgBog=; b=amEbmXcXztApiHxv
	z/8OJhQa9dzm6pbO69cDOtL3eNHidf7vPXHHD7XMi7dVA6zfI4nqBetmCFJTs6gR
	YptKHvPwK+QS3AERXai3GO0Kv2HEQlX50z16HXGiVKKGUOsnfnLBsVan5TnZJm1e
	KCqJ3JfwOTfIL4Rhx7iaIDA2yqhExKHykRjLJf3wy2nexY/9nQIrS3jOyHhfBb7/
	ynM6dZXkp3sHxqqOi/C1/FPQYO2QaNwTHmUMg/nI6iDR6aYEvOOde9ieT2PxN5cj
	s1bZXAnM5rOE+21FH2bdVM1AIt5NFwHoMj8T8iBLF6fYbXaOWqEiinHYHRE5H6Qg
	7WaAeQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjuu7b68a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 23:43:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84885a4fcabso37503b3a.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784763813; x=1785368613; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VM4Q4+Q9bC+Ys9BdhS6aCA8dDkeyBz8iQ9iFH0DgBog=;
        b=EVU4UBNLugbjjaUM4v1ftDfP8a401HFG1PLTTf+hQTI+X2NqylytLQ1PQkNMtbWgeZ
         798laHpaN6q90fqPlcB5KjYo5/emFVjx4SJ43UjAQ1ZZdPzgjYRlQUqG+jyQ5LJISrje
         G9VqUp45zd3L+tS+7OEhbo/OuqxsCmLCDpPJDi9mHoSlc7YzCoemua2O68gSIWATEmo9
         uUo3We+xBg4KDjF0qXtj5LFICmnDvikuCue8ncJH7gNGbMegQgzpU3+4fhsAr0GRNIsH
         CEuKYJ9bEdGBRDaf4bv0omglD8hcXmlgQlDGXtDs3SmyM5HUtMUo5cOK1Gqnbxdt9n83
         fvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784763813; x=1785368613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VM4Q4+Q9bC+Ys9BdhS6aCA8dDkeyBz8iQ9iFH0DgBog=;
        b=hdI6sqhEirzdRh+k5U0AFW0t0SKSII+Vg8HEn/ocvhZsppapVWwEmcozosjsH2aM9z
         9Oz+89DfJaRkDOSGY/C8KYON1XSoJujeCeOeK3ek9ZFQL2wxH7JqppWR767tuXfuyS8I
         xsFNv+Bv2ouaYi4IouSIFFlEzPhz+FlofC119Jv7ZIV7DoVJh/YYE1EsZbcjhICrxtWp
         Yb1FpgScvgJXxyNPNovbUMreGNoExEHip1BSuU4Alr6arc5fZmM09msRRQSLbww1B4Nf
         YJ8GnOHnTtfAZBTOIOeS9IVxUduW1OtrrtruiOhaNFbNwe4PrkxFdC8PS53T1ipDPM+P
         zYvQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro30wvKRLqQNM1zrBqVBQHH50N80JYtMdFMEr86sTL0wP24N56ZXjjBCm2lGlBVpbjP9BVZJeI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxhcUk6Cy/EjqIra4xP7/1ns+ybWDW/QXXHuo/qXvS9xsN5AwGL
	5EOY/zxaaGjrKwMVEBOJFxRNNEB4evUv7X2o5Gi7CXmOrKlmT30R3lxCAmODVZcyIqQ3tSJMev4
	KnuCNnMTe4tJ0n8+ats9NJy81ydrNV0zaNcIKZEhk/Z5Os63qLCIBuQdvIBPZzpUePz5qzFg=
X-Gm-Gg: AR+sD13pGkqShm16ZtHbNAOZA6Yr9ZqHN74T1xcP+TS7qpz727tgaq3vdw5SsSduOT7
	6M2RVk10z7AUHVQ6xFt6Cnf9qH9vqZNCZVJy08633Tkr6AaBxcJeBkM8d+NVXD6Npp7lMVhAhLT
	k7WQ8ctdh85YOEpZFmYPcftojvMa29/s3Zlk4jNMtOvthMc+Ub6VEDhp10cqytD8RqCBjHztaG5
	SnmBj696b3iabRXAwXii/PIxWj1I7ZQoFCMHu3KzgTnB/as7PkP8OXZqYprCP/+PM52MSioFzYp
	bLVYVaioUvAN7IV65r7r4DWLVzMwM1fhcjWzAgU+UNd1RKjd3Ycz+p5Ze0GilEjLADdogZAiK9X
	PMR2cm1KNvsui/FylBfTnQOf4cPIyJaUTFVk=
X-Received: by 2002:a05:6a00:1c88:b0:84e:4d6:78fe with SMTP id d2e1a72fcca58-84e2b83206fmr921253b3a.3.1784763813501;
        Wed, 22 Jul 2026 16:43:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c88:b0:84e:4d6:78fe with SMTP id d2e1a72fcca58-84e2b83206fmr921226b3a.3.1784763813044;
        Wed, 22 Jul 2026 16:43:33 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.113.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e23f7138asm923512b3a.32.2026.07.22.16.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 16:43:32 -0700 (PDT)
Message-ID: <4da5a8eb-3d22-4aa6-9fc2-31143aad384a@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 09:43:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: remove dead select from kconfig
To: Harshal Dev <harshal.dev@oss.qualcomm.com>, Arnd Bergmann
 <arnd@arndb.de>,
        Julian Braha <julianbraha@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>
References: <20260715092539.18384-1-julianbraha@gmail.com>
 <a3b7a752-8cc4-492a-bb62-43121b852c41@app.fastmail.com>
 <6600d003-709e-4186-98c4-a9ac263d7d6b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6600d003-709e-4186-98c4-a9ac263d7d6b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xxaKlKBaaIH2aGtugn_zU3ilGIrBRC1o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzMyBTYWx0ZWRfXw1Fx82q8u/mN
 FgUVejOUVXy80p/dFfgxrD8IIdYnktCA0Fme3A4E5fHq7SZOCHrWF3HAgoj6Xt7UqQrVNOYfwcB
 II6gKek3EYjD4dOvG5O9gVx5sbzISSA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzMyBTYWx0ZWRfXxs1z+swbgD96
 lRxHpSbw5oeck1d91XG3BRICIEbyZMfbDYxIPLG313hOVuvzIDFcmRIHXtqDeSHu/og0uTfEyZ9
 vM4R5dNl+B3+2SL3zcmaSAqR1x35BRPpaRR6fjtSXiHhNrx42mI19DkeD6fbE/UmzcBckia238s
 xTMcmUGuF0bjCOe24GfRkRYluWBj83uqsEBjahKDOxT5bEl2VtfO2X+2ZWMc03nhwM7+LXVL8DW
 TsGjkBSi17eOrLiGwE6ytlGYzu4u90CdCkQbpcACQrc+AHrbPBYS5xApbti3vg8H2RShCnNzjff
 hO8HyMYaAlpgUAjwRhI2RVis47HPzi5dNOfBmXfancgV5gCj0nRhHxFv9laCck1IMW2DIufmTMV
 IUHMURwsNshKTj8+VupqoJcXZdPjjA6osfOSO56jVZwaZPjGzwFKP5lN/Lu1Ds+cQSxiULfb3Jw
 AYAFw1KLxivAmQeHyKw==
X-Proofpoint-GUID: xxaKlKBaaIH2aGtugn_zU3ilGIrBRC1o
X-Authority-Analysis: v=2.4 cv=JuTBas4C c=1 sm=1 tr=0 ts=6a6155a6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=+pqzwZzB1FLV8+kquSSWdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=cTKkiFmBdYaFWAhAJ_8A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220233
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,arndb.de,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[209.85.210.200:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3D73B43154
X-Spamd-Bar: ----
Message-ID-Hash: 2SXGQJR6M64LBCN77K4TDRK25ABMAJL6
X-Message-ID-Hash: 2SXGQJR6M64LBCN77K4TDRK25ABMAJL6
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, jenswi@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2SXGQJR6M64LBCN77K4TDRK25ABMAJL6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi,

On 7/20/2026 3:55 PM, Harshal Dev wrote:
> Hi,
> 
> On 7/15/2026 3:38 PM, Arnd Bergmann wrote:
>> On Wed, Jul 15, 2026, at 11:25, Julian Braha wrote:
>>> 'select' does not work on config options in a 'choice', so currently it is
>>> possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE.
>>>
>>> This patch removes the select.
>>>
>>> I've compile-tested this and found that it builds fine without
>>> QCOM_TZMEM_MODE_SHMBRIDGE, but I don't have the hardware to runtime test.
>>> Please advise if it would be better to make QCOM_TZMEM_MODE_SHMBRIDGE a
>>> dependency.
>>>
>>> This dead select was found by kconfirm, a static analysis tool for Kconfig.
>>
>> Right, clearly something is wrong here.
>>
>>> @@ -5,7 +5,6 @@ config QCOMTEE
>>>  	depends on ARCH_QCOM || COMPILE_TEST
>>>  	depends on !CPU_BIG_ENDIAN
>>>  	select QCOM_SCM
>>> -	select QCOM_TZMEM_MODE_SHMBRIDGE
>>>  	help
>>
>> From the implementation, my guess would be that QCOMTEE actually
>> requires QCOM_TZMEM_MODE_SHMBRIDGE and it only links successfully
>> because of the stub helpers added in 8aa1e3a6f0ff ("firmware:
>> qcom: tzmem: export shm_bridge create/delete").
> 
> This is correct. QCOMTEE can build without TZMEM_MODE_SHMBRIDGE, but will not
> work without this config. TrustZone will just refuse the memory shared without
> this config enabled. So it is a hard dependency.
> 
>>
>> If that is the case, we probably need a 'depends on
>> QCOM_TZMEM_MODE_SHMBRIDGE' here, and can remove the stub
>> functions.
>>
>> It is also possible that the 'choice' itself is wrong, and
>> this should be detected at runtime. It is a rather odd Kconfig
>> option, as it sounds like only one of the two is correct on
>> a given hardware. The CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE variant
>> contains runtime hardware detection, so it should actually
>> be safe to enable that anywhere. If this is true, we could
>> just turn the choice into a 'bool' symbol and remove the
>> generic case.
>>
> 
> So when TZMEM_MODE_SHMBRIDGE isn't enabled, and instead TZMEM_MODE_GENERIC
> is used, the driver just becomes a generic memory allocator, so the clients
> cannot share this memory with QTEE. I couldn't find any existing clients
> of TZMEM that aren't using it in MODE_SHMBRIDGE, in other words it seems that
> we don't have any users for MODE_GENERIC.
> 
> In that case, it appears to be a better choice to make this a bool.
> Either MODE_SHMBRIDGE or not.
> But since @Bartoz is the maintainer, I would let him provide his comments
> on this.
> 

Thanks Arnd, and thanks Harshal.

The stubs and their no-op behavior were intentional. They were added so
callers could use the SHMBridge helpers without having to distinguish between
the TZMEM modes. When SHMBridge is not enabled by QTEE, creating or deleting
a bridge is expected to be a no-op and normal memory can still be used.

The problematic case is when SHMBridge support is compiled out while QTEE
has it enabled. The compile-time stubs still return success, even though the
memory was not registered as an SHMbridge. This is not a valid configuration
for qcomtee, or for other clients sharing memory with QTEE.

I agree that Arnd's second proposal is the cleaner approach.
QCOM_TZMEM_MODE_SHMBRIDGE can become a regular bool, while retaining the generic
allocation behavior as the runtime fallback. qcomtee can then select it,
ensuring that runtime detection is always available without making SHMBridge a
requirement on every platform.

With this user can not make wrong configuration choice using QCOM_TZMEM_MODE_GENERIC
and we can drop the stubs.

Regards,
Amir

> Regards,
> Harshal 
>> I've added a few more people to Cc that may know the correct
>> answer here.
>>
>>      Arnd
> 

