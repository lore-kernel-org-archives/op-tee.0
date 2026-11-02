Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76222606A938
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nu9kW/BD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hLpjK2S0
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C867745418
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nu9kW/BD;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hLpjK2S0;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 975A844243
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Nov 2026 13:41:36 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAOBK2902413
	for <op-tee@lists.trustedfirmware.org>; Mon, 2 Nov 2026 13:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u2CDzv4RDHZ8hPwlE+nBKssRwCunfdow4oBThFsTd0w=; b=Nu9kW/BDx7zBAKFG
	f12o7NKAt8AkTWlmTjT1ZCCfWrQIzowQc1H5FACyz0MlwdfeDm4LgQMYR2gvpbmj
	HbueCW1cV1awmTe5Z9WQVTZ+T1Kjrp9TweXelnFHlGgotbi2ARwvhfLm6cUz8rw9
	OVg7WTkQmKPhKLrNy/jEIVunAYNxbRBYd0b2C/ySsBgxPrY6MQYXmlBV4YIpOoVI
	poSsLjUkQZux90kC/+azzqzBbQKP38dV1JkNlMzuYM5hm9FY3kI3AWQ+ymGKLsSa
	oShV0FoMFWwZm56demoKcXCcIeyXcRokNqgxFIncsqgSFpDCWGxoq9kTsBnQSTch
	GHAgZg==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavgj63-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 02 Nov 2026 13:41:36 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-464fb819ac5so3243782fac.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Nov 2026 05:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793626895; x=1794231695; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u2CDzv4RDHZ8hPwlE+nBKssRwCunfdow4oBThFsTd0w=;
        b=hLpjK2S0ufVYEKzOBRV9/gV7BvlVvCeEK7ATOt8CGQLJOM/PXVe1WJ1bRoENWFRh8D
         gWp33SefZGQrZsXS9OQ2hyyLUsHedfyQs8NWP96uIweP3pFiX09y929y5KjNwGn9+q5l
         iNcDIgUAOBq9debQ4InAutK8eT7qMQi0TOlX/HPjCk9oPScYw+PWoHjRbgpicqRG9M9d
         tfK1qwEML0G2bn8iWKTPBiGGT30gm1n/LUJHQ/sMcCbkH/axH/XyOZcrD+kiUcqS3FlR
         mjQEOb2MaaxNDXL6UhJAI46JZ7kPSgjsm+NTZivozNT18OnbnTjTgI8BX3cK9tLQ4O74
         bLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626895; x=1794231695;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u2CDzv4RDHZ8hPwlE+nBKssRwCunfdow4oBThFsTd0w=;
        b=o13oROn9sjvJy89kpSXEp8vpTmXwlQfxQTXb/pU7oAi+06w+EmXQY1fiOInF4BJTQq
         9bbMlhVU55ZogdK+wJ9QOd3aLb2ss62HpJHYrmOqp5vQ2J+aftCNggbqs9qBgM7VkJ5A
         dsiv4qaGddjBWF87CcoXNgdjCh2cTmfNj14wwP8PtwKY9tYdcDefe7l6r6g1R1hoyl7t
         jXbwDq6jOnQZrVayKFp6VfF3NZUaM7k19dwFL/CVczVY3wTEYOgnTtUY/SWxtTj3XeQx
         sN7VL8ZWuR8cGxrpyqLZjdaSdznuelK6qoFdVinYQI+Kg7HNYli5a9gKVYUMp2htHVBz
         Jg/A==
X-Forwarded-Encrypted: i=1; AKwUvByJSZ28sstYiCaqN0np5re7DoXz/OGNX4sytdel6b8cmkjZC8ZWDKAVl1G/VaP2VpUW0Z24nds=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIm1pRIshUYbSMSwWyqeGGzis3r4zL/9Iw40+bVyxaKiy6+UkXk
	/u5KTbjk16kKqJloIsrrPZfds/44+pTfZogC0VKQvZoDsWQjMRq2183YHtMLgg5p4kfedM8d05p
	xgwtnnDUPVMWgMAwonpB9F/DW2JB27EyVy5ssGii6A3/FT18SE+2gykaUQ35haIlKDz8uN0xP
X-Gm-Gg: AYBFou2Z1toMKV3cYoo/uSH4tjNH8d94/cKQKXi40EF52mqa1HD/3336zQKqP3lfTo8
	oI3uwJH+r45BwM5vcaenXNF8GTtoUDAoRDs5OxHX9ren8qMJKhsASRvk2tz943AbaHvHB9UQeO+
	cmlUYgVl0L9YmiVZRM1gywGku9sw9+H2x99wIozYPGk+G/G7T5BWSfEviKQhgsxcKP7iDZE/jI+
	soaadWqN7bH6Z8Xi9De5lvK5QclawsdnnQh8oDU37vWwcBcoRARhmbW7Es5YA5vS8hKH5gYhlmy
	5Fw11BA7WU6m+lDq6mjh9OItXSN1tHO8z8+KOiFtzmHm4XnbE0YOTn4KdFzYt/8SyJGTk3S2UTz
	8nyq5yQi1dtPCgJnOME6Kqz1zUGwmJnMVCeK7qAkY8Hv5ewnZ0FsgJWO2zIghNmzLezs0wjEbiQ
	==
X-Received: by 2002:a05:6871:1cd:b0:4a7:424b:934 with SMTP id 586e51a60fabf-4a9076455ffmr6067084fac.12.1793626895264;
        Mon, 02 Nov 2026 05:41:35 -0800 (PST)
X-Received: by 2002:a05:6871:1cd:b0:4a7:424b:934 with SMTP id 586e51a60fabf-4a9076455ffmr6067072fac.12.1793626894848;
        Mon, 02 Nov 2026 05:41:34 -0800 (PST)
Received: from [10.92.207.38] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921a53b59sm6647163fac.14.2026.11.02.05.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 05:41:34 -0800 (PST)
Message-ID: <e618a9f3-6a33-4dbc-a15f-217542ef28f9@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 19:11:27 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] tee: qcomtee: Allow object invokes from kernel
 clients
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-3-1460691b35d3@oss.qualcomm.com>
 <952816ce-3e37-4628-8308-4208b4359549@oss.qualcomm.com>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Organization: Qualcomm
In-Reply-To: <952816ce-3e37-4628-8308-4208b4359549@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX9UTfQsgD6AKU
 F95CGAFlAV+m2Ff2sY1Ey0s2Q+AAfgoeMo6EeAOsv0IAzYUoa43cgtzgosJYUqziuHCHCZxRvx8
 hJDqQ0prhZapu/EiM+37dlK6+jej7G1YthQP+CN7mTQpGt9dtd8qBCOerIDc2u84vfmLsNVcNKj
 4KzQ1c5QimLd3HNojt2CduyyddQitkKxaNBw4f6RaaxTGTKf3OlN8QY4uuqGk1dAWzBgPGddT8J
 Iqha0vyOazo0/J2bH27SZaZ8EsPi+S+sRWnbG5vs2qg7QRLzmuAhmVVhJpYf7LJZlfXfFYXMRO1
 cCvqXQObuuG016mK9Y7uczSwMxa6AF/hyU8LoeNWgpYFTKheA13eeQ5glU83ALQZEgFeDKygFFm
 uK5IpojqGwWg0LHFgtqGxnVteb5BnjGO1DctCAViBqJxmdasTXTps9G1MTgjZdAs9AcCCd+eFV8
 YyU9euC+7o5Axr6ooJw==
X-Proofpoint-GUID: _8u5zZPAd3bBYEfGJq96uoZzpPWo1VAI
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae89310 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JrbDfxSjzSyu3ErrWlQA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX/pTWhSHfB2fr
 nDAiuEpJjA/RayxYPEEryUV/vX8Gi07E6C7ZduRGLD/HYOTcwaBTscdoYVpBB8LO0NCDzvJOOhX
 R0mLrKVgYMeSoTr4mIt3lH8ISuRg0eg=
X-Proofpoint-ORIG-GUID: _8u5zZPAd3bBYEfGJq96uoZzpPWo1VAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.08 / 15.00];
	BAYES_HAM(-2.98)[99.91%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.71:received];
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
X-Rspamd-Queue-Id: 975A844243
X-Spamd-Bar: ----
Message-ID-Hash: RK35IPVPUOTP5JZESBZRH7TVRF4HR6BC
X-Message-ID-Hash: RK35IPVPUOTP5JZESBZRH7TVRF4HR6BC
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RK35IPVPUOTP5JZESBZRH7TVRF4HR6BC/>
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

On 26-10-2026 08:45 am, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 10/15/2026 10:39 PM, Harshal Dev wrote:
>> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>
>> QCOMTEE currently treats UBUF parameters as userspace addresses and
>> applies userspace restrictions when invoking the root object. This is
>> not suitable for object invocation requests issued by kernel clients.
>>
>> Use the kernel_ctx flag to distinguish kernel client requests from
>> userspace requests. For kernel contexts, do not mark UBUF parameters as
>> user addresses, and allow permitted root-object operations to proceed
>> without applying the userspace-only checks.
>>
>> This allows in-kernel users of tee_client_object_invoke_func() to issue
>> object invocation requests through the qcomtee backend.
>>
>> Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> Same here.
>

Ack.

Regards,
Harshal
 
> - Amir
