Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44B606A326
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mjwuQ6tS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UgV2HKQN
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4D37245466
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 16:33:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mjwuQ6tS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UgV2HKQN;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0E46B45336
	for <op-tee@lists.trustedfirmware.org>; Tue,  3 Nov 2026 16:33:23 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3G69603337252
	for <op-tee@lists.trustedfirmware.org>; Tue, 3 Nov 2026 16:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNX4j1BmI6v/586ULUJdkOuJ92tPPScGDdWzbmLn3Po=; b=mjwuQ6tS/VigZEq3
	ogxeCgwHxzhqzyfJV4CTYOXLH8FY8s1MqudfValPEMNThuzrnds/+rtXHbSiYJ3x
	Y1uIfLy+4LM7PhoodDOI3wPU8NgBQEenCPvUZWTazR9+FBt9xyZPLedZ+XQ5+fLW
	CTY9qaiJu9SvfXB+MmHKMj9JHj2fBmPKE38GdLGIjZd0z0LbX/5bnNzYGRRN79H0
	wRQj1c+gRehu5a2RnjhzjX2XEDiqelUyaH6tH+B6YgGvTSQBiZOC/697CGzjPJWO
	5QGvoF8uEyNSjvha2TLgLPjUOBhC161Ti7dv6aTXwu1tY91TUyQyIX07qVEGo04A
	ntxq4A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqjubg3ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 16:33:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cbf2fd504so797639485a.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 08:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793723601; x=1794328401; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNX4j1BmI6v/586ULUJdkOuJ92tPPScGDdWzbmLn3Po=;
        b=UgV2HKQN0icZE8rc0sAQoavq1NsR+rSn1GBGurBRcgIetMVv9kUQ/RytONr2IH9Quz
         XhA8NrxWJntUJ8O6gebDcadFCDLWdb6UrAe0cWK0ygoMHr/Hh4i9f4YJwvNqISK1IAqt
         aOjgB3FkIrEqh+d+nk6bXdJNnpa9A8So2R6Dk8udLf34h9JzAofvmS5YuQBAWA1J1rJW
         kVYo9C8JtcvU81o7EqJrdnGY+APshGpZV9V+6r42qZxpEi4OhD8CZ1Qj95L74MN+msjS
         i1zv9MBHCj3NZ8bxB8TSnW1qgu0HZzE2yKNGQ5LOr+wDle3Jx9IlMHI1XsF2fZ1++XZ0
         6ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723601; x=1794328401;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNX4j1BmI6v/586ULUJdkOuJ92tPPScGDdWzbmLn3Po=;
        b=yYEY9pgJajuddqvBvALP8qQHtenRZFuykP5Q+WSvPJGmMuDugoQaMYM8HSBFO1Crxu
         H0+YaNrL6wWLHuwYEIjARZRnbP4L2QNi0swQN1VThYzaPX0mCm9gNGn99B3/GalMcH6b
         Ir382LIR2Bsq6d/dWDUIszCHHkd1/KjT2BpA8fG6FwWtiDAQnZiFlzWfTA5YcA+O0fQu
         vhnmNX15di6d0rQUir0+ab9VwlP4r+zIlVbu7LCKiebaMsHT14lOSxoXovMChmRtPNX2
         PKB6jpJAHSAvxP3k9UddL6rWV/BGB2VU46bBx9A8lGG8hp1gMaIayffB3d/M+aqgiDTE
         hNYw==
X-Forwarded-Encrypted: i=1; AKwUvBy9gq48iBA6Zcykda66iTKIEIijgUo+8yL6oSBq3c4camIqLInwAfMNq27i9l2jmxT0CvzEtf0=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+bOLkylH6mRz/jDmyPGy/LqyIybM9RT5Ozc8jJ+ISFkeam4VU6
	7DsFNC7X2KCQn1RLbFFBIdU6nh0wAuQ4EmrZbM7uibaZSb9KuXgxyhiwWCtT1C6tubuLZWSTvb8
	BJSRPjKZk2rYYKnX0+HDjSW4fMUhoKe6uuL8PqV3nhLtEZs9dsstU5smUwMx3pmYxnLgXAAi7
X-Gm-Gg: AYBFou1EVYZJNU5pM3IFzpet8W9NUz5vyNdBIlRK3SQItGV2tVbshp5dZk2b6MPtMOv
	QRjngj4cGcIP4WK/kYBk5LX4UUw9TMUwdPQF3FOrTJoaERKfRSsYOmm7AHvXI2NuzhiRUvAP2mA
	NJmtv6aC3eeC0amNW5iZVhMFHRcOZe38sBzSPrrjhlgiRzxN5dFC3Y99KdN3zm02kro3fCMN1JC
	hWkbIw4dhC4p4gQvIBg/00oqqaEGGPPwnICQswhJXkiFzEWBT9vhEbbHcc21wsdZjUgz7Epfrtc
	IWVPIBKTw3WroKl4O7fDZyGKPlJjpZl+Ccewf3+/F453/s/6Q5Gh8gUogRI6gaO6cl0w7F+k/PQ
	2D3yw45kvlZ9bwnO3uaxKbXaCEs/JvdRE1Dusy7medeTNm4Nlk6ib7xViJptQwtMoJDTqjd7o5A
	MURLlAZX56iIib1U+OXHWhjaDa9dcND9aRzPJDLOuBGEnXKZqnq5hXkdaxWK8r3bRF7uZDeSb6/
	sj35UmJrbMuD6w=
X-Received: by 2002:a05:620a:a502:b0:945:ad43:1d59 with SMTP id af79cd13be357-945ad431d8dmr1008661485a.75.1793723601213;
        Tue, 03 Nov 2026 08:33:21 -0800 (PST)
X-Received: by 2002:a05:620a:a502:b0:945:ad43:1d59 with SMTP id af79cd13be357-945ad431d8dmr1008657185a.75.1793723600734;
        Tue, 03 Nov 2026 08:33:20 -0800 (PST)
Received: from [172.16.20.169] (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebf3dcc9sm101883766b.53.2026.11.03.08.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:33:19 -0800 (PST)
Message-ID: <2f6f80eb-57a4-406d-a041-8602805c7647@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 17:33:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <atYZXRLf3YPZhiNB@kernel.org>
 <8896d867-dfba-4d63-a0f0-5686c572b262@oss.qualcomm.com>
 <athuhfkfGPZp_YXT@kernel.org>
Content-Language: en-US
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
In-Reply-To: <athuhfkfGPZp_YXT@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NSBTYWx0ZWRfX62Ck5Y9TKczp
 OgR9Rg6xOlNKqpEedrLl6/H4qh4AC0V5dJBH0kYhwKokJAsPKfCJ/yUgpScpnxzOYo2w0hwLoPx
 fP/BWdtyEPXDHNDBtEtNMrkA0pKgLzc=
X-Authority-Analysis: v=2.4 cv=JeUpPkKV c=1 sm=1 tr=0 ts=6aea0cd1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ma1MJH4ChwW9rezZrwsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: PU8FjorrWkoW-Xi94fyUrXEtxZm2aSUQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NSBTYWx0ZWRfX1qJ7gmBHe8yG
 CCYfEzzGKHIluZaSTt0CfADO1P/4XPRSR3PKFua+4+gvgXj8PsWgt4BhTRo1yt4CZKHBQdS+QhE
 BE7bDIQIjKeHp36lIKSOAfKLTxD+Zx7Go6PqA1n7iOKFKPg/wzCUwuDqkSKprHCeFqxjzFRdS2K
 mkFUgHnG56FzbDkm3jH5F/1AqBMB4nNHPvXHj45HYfSczeRomweCHFhluZtEqob+yir/V46AMmo
 pEtyUmQKJpKp0U6PSQpX6Vs7hTEIn+VxDfVKFDvEBQIl7bQLW7YipR6B0m2m3EjYc4/m/P6zied
 pC4OX/9tzaw/eZ/+Pc0a/e4IiAJ4yTWjBqU0qCqwWu+e6iqD2OTb1OHKV1RvDfQ/8eOVZlz0OAF
 g1tqt5Oda6GE+3RUOg4QTUMgfX1jszSOXr422MLDvQ6FabPB0dQZd11+zuLhkQYL/H+Ls6rN9yY
 /KyEhkxt75HuaZOtVmQ==
X-Proofpoint-ORIG-GUID: PU8FjorrWkoW-Xi94fyUrXEtxZm2aSUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030065
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[79.136.84.34:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0E46B45336
X-Spamd-Bar: ----
Message-ID-Hash: VIID35A3AVS43CB3O3VNCMPYPYIZHEA7
X-Message-ID-Hash: VIID35A3AVS43CB3O3VNCMPYPYIZHEA7
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VIID35A3AVS43CB3O3VNCMPYPYIZHEA7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 21/10/2026 09.49, Jarkko Sakkinen wrote:
> On Wed, Oct 21, 2026 at 11:21:33AM +0530, Kuldeep Singh wrote:
>>> Applying this pulls tons of TEE patches:
>>>
>>> Applying: tee: qcomtee: Track the object invocation context
>>> Applying: tee: Add kernel client object invoke helper
>>> Applying: tee: qcomtee: Allow object invokes from kernel clients
>>> Applying: tee: Export uuidv5 generation for TEE backends
>>> Applying: tee: qcomtee: Add support for registering QTEE services on TEE bus
>>> Applying: firmware: qcom: Add support for TEE based EFI-var client driver
>>> Applying: arm64: defconfig: Enable UefiSecApp TEE client driver for Qualcomm SoCs
>>> Applying: tee: qcomtee: Register qcom.tz.tpm service for discovery
>>> Applying: tpm: Introduce Qualcomm TPM driver
>>> Applying: MAINTAINERS: Add Qualcomm TPM driver entry
>>
>> Yes, first 5 are tee patches prerequisite for tpm series as mentioned in
>> cover letter too and this series can only be merged once Jens can pick
>> dependent series[1] in linux-next.
>>
>> Since, v7.4 merge window going to start soon so i doubt Jens can pick
>> for v7.4.
>>
>> Jens, Any plan/timeline you are aiming to pick series[1]?
>> I see it's mostly reviewed with no other relevant feedback to be addressed.

I'm sorry for the delay, I lost control over my inbox for a while. 
Looking at [1] it appears some more is needed before it's ready.

> 
> Maybe it is better to pick also TPM patches through your tree when
> you choose to so that this will go in-sync.

Yes, that makes sense.

> 
>>
>> [1]
>> https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/
>>
>> -- 
>> Regards
>> Kuldeep
> 
> Br, Jarkko


Cheers,
Jens

