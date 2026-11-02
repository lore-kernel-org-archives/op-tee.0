Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813B60A3818
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ler+eN+Y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h4AUqXJb
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E9DD444243
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ler+eN+Y;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h4AUqXJb;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A8E5B44243
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Nov 2026 13:40:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAJCl3423280
	for <op-tee@lists.trustedfirmware.org>; Mon, 2 Nov 2026 13:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MnaUQhO5JAaxIur7GOA2e889cogxOhGTawaHy/i7Vc8=; b=Ler+eN+YjCkhQLwC
	Jx4aCWfAFgFnHH6dJ5om1/Bfmw9AjlGHN0WjjTW2UYKAr4QtEHZJfQ3T+6wE3Bxq
	wulHzpI+Lysjpvl3fap7jO1YucjCj2omV/QnKh2LjONg22oiARa/GHBoF9xsrA58
	ttw7CeFYYrv1GbrxE6T4ys4xTrNl6WSuftmClwMc7IVVIp+Tmr3XFaIyoPMP/eRp
	aZ8/Cz86g16dMSOFIeyN7YAAf2qCkf6bs4Rgisy+41VcNizelowS75Og4rH9kl9v
	V3Nk1CvWJsQZQp3sMaHvAbmC/eRYpl2b7JAScRvKH3ANeeq01UfT5QEfSV7y0Ir4
	JMW7xQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrh2de-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 02 Nov 2026 13:40:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e869e00005so48215605ad.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Nov 2026 05:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793626824; x=1794231624; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MnaUQhO5JAaxIur7GOA2e889cogxOhGTawaHy/i7Vc8=;
        b=h4AUqXJbA9OJwOkoHpIPaI0UBzcY6+lrVmkAJ/oaqpPQmSYK/NbSQTj99NQHmRmea4
         wplPUXteEsvbF3eqf7QvcitxVDRClx/nGMNEvBUHUkyyXvwfR7937tVj3+n4iG82IrKA
         f87AsqvTp7IlWrFzmrvZmLoDMpu7OJRsLGCNFZ3/IFqyqcin+bebafrTbA1xzZwSF6O3
         DVvh4xLNeIzqEOyA83U+iGRmafukCqXXGXcgKBnbAylqJhZsYit5MU93yg45qLj2dUiK
         kW1wVEW50l8ruzobofiSkQGXXmOFftf4eAnR0B6J1Yn4I6+htrAXYGgQ+5wMCXMDCBbq
         yWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626824; x=1794231624;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MnaUQhO5JAaxIur7GOA2e889cogxOhGTawaHy/i7Vc8=;
        b=fE8yOpoIDLxjkoS4eh4HsCZLWTT4Hbu1rILUGl81z/aPYHcLmcQKwXJkKI6awoDDni
         TaTyqyK8ebV5esEEFNC4s3zYxFIagnrnmkX5VJfb9loNLgNd3fGpY1ctWNfXQWSmBt3k
         zkRad/rurlR/YKeMjZVYlBOzDMjhM2ns9jOFL2ghybvN1j2iKhQI/L3mCc1pKHMjR0m0
         8fvCGPxm77EhDmRpWleYIft30bS8jXaRma5RKeWCcu361E7z8dLgVfFgeNyVGKYiCDVu
         uvpl4h1MvLvmx3bLb12cso/TWomsn+IBGzZJ+fQbbvuzgkoQMGFvHnpGeL4AStkPV61A
         08qg==
X-Forwarded-Encrypted: i=1; AKwUvBxQeAzjh9DvdR6gwwmpR6JLUnYFiZjTWR8b3Yg5e5Vf6qC/v3/qWwshtzRPG9G3DsklZ0tgSqw=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9hvZ3sr9YKD7/Xv72AVKCrxmp1rqNRvTL7pGK0H8Bea90Bqp1P
	on/fTeWDlbFzizuisRVHWKwbeRtF5W6b+f4RceyzbDQ8K8hm26dUe3knndhP44kxDC99RSopNGD
	2GjlWt8OWdqJ0vUzlDYcrLQGlPZBeBkkBw6BUsip2V4Rh9hO87k/veqTUU+CHFEZphotCXguE
X-Gm-Gg: AYBFou2tqei6aoeTtjAYbT9RCpigFAiDJjeeW/BZrNTJ8bV3zfZM17x9LLpJflI8WeC
	+OAPShdZirdk6ocZ+orA2ka34aFpYAWOUkPIXqTNKQs9Ele0SVNJorK2tAFfUqUDpjZjYBE9I+f
	3KlwIcECwfCuzbelFYsfPtNdoMk8k2K+BLHX7PDZP6LCLHyJbQEJivMQ8niLSD9Sf+Nl0Ay7mx0
	eSi8uQlTrcrSQkFWw6JLgn4rCwstxPigYwASYO3vCp068BqtF1fCMRjSx+p+o9/44oFFHbvZATx
	mkPM5YofSqpb4RAh1aMKrpKN+6H49jyZ4e3XaeTQDBfg3DxP0ARRWapxK9Hz9y8oUXe4Ptx+25s
	bWU42OgsoCiLTOP4Irhdt20X0EpJ2gWFifdvS8SHmcgV1Ixgl1i+qMQ+QSH2AMKk4xl8sdgNLeg
	==
X-Received: by 2002:a17:903:3c27:b0:2e9:670f:d080 with SMTP id d9443c01a7336-2eb36450a4fmr93246905ad.32.1793626823591;
        Mon, 02 Nov 2026 05:40:23 -0800 (PST)
X-Received: by 2002:a17:903:3c27:b0:2e9:670f:d080 with SMTP id d9443c01a7336-2eb36450a4fmr93246615ad.32.1793626823102;
        Mon, 02 Nov 2026 05:40:23 -0800 (PST)
Received: from [10.92.207.38] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3929b27bsm27952085ad.62.2026.11.02.05.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 05:40:22 -0800 (PST)
Message-ID: <0f3572e3-e318-4f4b-894a-d2c16d8429c7@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 19:10:16 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] tee: Add kernel client object invoke helper
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-2-1460691b35d3@oss.qualcomm.com>
 <5d260732-c586-42b6-b7a1-e8eca9c41229@oss.qualcomm.com>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Organization: Qualcomm
In-Reply-To: <5d260732-c586-42b6-b7a1-e8eca9c41229@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae892c8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KkQ6sNVK5zAhvL3FsXYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: bFz2jDBLRDRoApYnvanAuLDpQrNVKzr0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX0XCvz9LDOHZq
 M2Emsz16xBaHv7ODzE1/O6g183Sc/Jf5H79XaUvoFn0QH14zEnieVFsSqmYuRCj8e1NcAcMJOLR
 j9mXc7fpohq4fdk3OKRJJPS+yLYSU+U=
X-Proofpoint-ORIG-GUID: bFz2jDBLRDRoApYnvanAuLDpQrNVKzr0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX25S7iH1TRS1t
 jpedVnynXJpao+1/oYxJqM+Lm2TrPuQpDFUecALnXCRhMYXC3PqXvvvUwkW1E/cm5YePqzuy26v
 8OiM1dH5UY0C5ILT4kDgMw9GjiHsR9EkXHZs83rZXz2qLCIVQbGmWyRmEpXi4W2U9BWh/hRVRM2
 NfMwdnmzAOfH/XsJWygQlY5DJw49k00gzxoPCR5uEHK3K+1i7BqUqccAhzFo8GAaycUKWrmbkrQ
 wqso5ypXF4A8T7niI0IfHvlNTuAD2loo9dVOSTylMo43lierRfJLtyuCjYSWh/ncqG3YyaNt2TT
 OrJlcXIaItjRjLCRkodChMzew3YLqX4bHt2X4WDLRxCQUJwe+llbOgkp8AwFMVfZJwyparmC0mT
 PMpiCFSTVTxE27/hyffzyqvuuHCDE9cdE0UoE9VCeMxBRCZD7d0TMKnw4yB4d09Ahx2qCzNcIeA
 uFi5ig/D96Z/B1WwArg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A8E5B44243
X-Spamd-Bar: ----
Message-ID-Hash: B7GYLWH57A5KB4Q4SVPZZD7FONA2S7RX
X-Message-ID-Hash: B7GYLWH57A5KB4Q4SVPZZD7FONA2S7RX
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B7GYLWH57A5KB4Q4SVPZZD7FONA2S7RX/>
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

Hi Amir,

On 26-10-2026 08:39 am, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 10/15/2026 10:39 PM, Harshal Dev wrote:
>> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>
>> Kernel clients can open a TEE context and invoke regular TA commands
>> through tee_client_invoke_func(). However, there is currently no
>> equivalent helper for invoking TEE objects.
>>
>> Add tee_client_object_invoke_func() as a kernel client API for issuing
>> object invocation requests. The helper checks that the backend provides
>> object_invoke_func() before forwarding the request by setting the origin
>> as TEE_OBJECT_INVOKE_KERNEL. This allows TEE backends to support
>> privileged object-based calls from the kernel-space.
>>
>> Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> I did not notice this patch has my signed-off tag already.
> You can drop my Reviewed-by tag.
>

Makes sense, I did not notice this because b4 applied it automatically.

Ack.

Regards,
Harshal

> - Amir
> 
