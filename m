Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B45C55167
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 08:35:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D5A4C44FDA
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 08:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785486944;
	bh=0YcQTPpbAHI1H43ReAaIL7xaNtOaQA/qudDrLzE1Ka0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Npc2By9LPHRNaQVyVlLp7YfFLkPUCzRDi3CsY3/YDCqFYuo14E77cHOSbNV6gXDY9
	 hUqY5OO4zHiqFhi8BmxlfeGon7q3BQux7roPgNbUuhul/Vs0rL8RIK4t/hg5DIgf65
	 MMXCtjIGeozykndchYFHu7A8IpqrrXjNzmC13rUpz4HLMHE3q21yCeZM3b3hPkTalX
	 tfrTevTxX+nKu7b7BufMH45s37Ef/+9jMn0ZHGTVoWwjIO0UxK+noanWYu13D+XTK0
	 bA6iFjEVS+n3DyBwhAhuoGnVxk9D8Uc810ggnymAo2c48fLDf/PlM9nBeAkF9Aw7y9
	 7l5WCmZzYH1JA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E4790436DA
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 08:35:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hh7DiGZq;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EKPm23qW;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8MIx33744515
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 08:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sEyvAWBwmD7HLBGtEh2I3/0dgyK+rthm4FgKnWNYRvs=; b=Hh7DiGZqnxYb+izZ
	FV6GHwvrmEuAR+uR5S0754QjMDRfWE1tsG87MMymUskkoxR1cEdk5gnZ6jEQna9V
	XYEQamGOfvJud/49Be6AdZ8tL6/GNL51CTlWQqkNGRlWTiuyYMtSjtlYuZTgvTKR
	q1rwNU9hRHAi4LTX2P3MotztNIUBTDAjQ0vGxoiTcARceKqy7QmJ4PftiDzWghVn
	ylm91u4HjGIdq5H4P4v1/H7bBkym5JffZfTGZwZDGdSS5DOCsutjefw6XftgpfRh
	LZkxE3KDSNu6I6m5MkGBgd4BCgbmXyB0nK6ImwBSG35oGY7xxW/BhR/5pvE5cMNL
	/MU8HQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frr4wg1ka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 08:35:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c860544c077so1635688a12.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785486935; x=1786091735; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sEyvAWBwmD7HLBGtEh2I3/0dgyK+rthm4FgKnWNYRvs=;
        b=EKPm23qWc/at4PEVvuM6fb2Vqlx61jm3lY0t3YhygcLxCHCky4mKNX29p9QOKhnUNl
         Ux8dFd4FPBdLtmogpffgPNpaeZGaFFUIv0vWE2yUCiD2ICe/0TfCYc0I0chh3DRT/0Nd
         duFhUJUcX88o9BjcRmP58V5lXgA0KkiOpUjiKuQU8e2C6v5bLqgmKDWhp6IA6WgvKbTT
         6vzAmAk41ZCwRPsvjY2SYsT9A9ka7dinZQPwpXMeVM1ZbSARHv9YUckiT9KvhSEJscua
         RZ5Fzx2eWm1uJaGp6gZHZFj0rqDNdfdaQRGrGR9J00pk+QQ6aEo7aa4dR/soATDm6jfR
         1s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785486935; x=1786091735;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sEyvAWBwmD7HLBGtEh2I3/0dgyK+rthm4FgKnWNYRvs=;
        b=mpGtPNPtJIeMwkAyigsM46QZdSFebuBMnsf41crqD2RwGutucUmJEcbR83myWQl7N/
         aIX6b5LS5K5CnBZZBUl9rQNc2z+djeTDnbsxHeYaD+gdawz3IyBpu6Jb1Ea8tq+W3J8O
         uyxQCvfLwvwCubpexXCcLKDl8nBX/klMBaqLznhCwrvLhbNCbLm/cgHJ8to3z5cT6Tce
         1zUz0SnQXg9HyT1M/9aUruw132yIk9mVFtfkPMUWTv+PTcdxcZ2ivBKRySZgfEEqnKOm
         Nok7ju5etID5gbA+nOs2H0CtvCgVP9VSDFhu+eYGFDQn5j2td6yrDcFCCXaAb4lUi0C+
         eTnA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2yOGLcCzpGE74iCMnpD2xf4Uf1bRWHS3I8CHSvXaPAmCFYCxMqOlxKAJWQCf2cZQctVO9mBg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzfQjlybP9NZ3p8Q3V5JBKJNF6Xzm57LOoA9Fj1E+AMt52tsTvf
	gZ8BEfoxwqNYvtiNJF9Urm16kQrnpBxRK5H5ZPlxGaShwyjwa+zrBlP0rKe4t+3mO8x5KPahTZ0
	+zYERAxMP4Ok6n3aVd3Z9S5W/ZVmaYtoteo0F3yyQiuFcRAIdsuBMIrLBADUzeVPus/giS7+w
X-Gm-Gg: AR+sD11bf8Wvg2RqOjLcXw1iJwsWqwS1qrg9tdk+UdSlV4swB20OPDbt+PVlVP7thAQ
	G36pTZSfW3H5Zmdmn+YyvlxsJyeS+D63BNFI+HAkePLhTFk6O909nD5a7T1T1UKgL1f4dksDQML
	p+WrzeHgafXs40Y8zsZ6Z37tbsaAK6IMN+kpJJ7cX0wGkWPg5Qc4FmZPyn0fxPkvC7gRtVLHb3R
	jxAU2POIw21fcRPySfmyzOh5RzuM8KFoJNpKaHwrLvG6eORgm4nVgrrShy5VWAsUmc/paOpd3vj
	N7ZfBkPV6J26yslQvnxvc69u9sWc/rXTRTzqWeUBjoPJ1oo7VuClNSqQgwedyIp8zQLWQdeAE1a
	RnVrDfWHoI5472sB6fot3raRlYK8=
X-Received: by 2002:a05:6a21:e097:b0:3c3:7d12:a98c with SMTP id adf61e73a8af0-3c91b3abb28mr1056439637.52.1785486935410;
        Fri, 31 Jul 2026 01:35:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:e097:b0:3c3:7d12:a98c with SMTP id adf61e73a8af0-3c91b3abb28mr1056414637.52.1785486934769;
        Fri, 31 Jul 2026 01:35:34 -0700 (PDT)
Received: from [192.168.1.6] ([182.77.67.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e107sm3602404eec.27.2026.07.31.01.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 01:35:34 -0700 (PDT)
Message-ID: <2e41d146-c641-444f-b406-875534c1cd98@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 14:05:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <20260722-qcom_uefisecapp_migrate_qcomtee-v2-5-b8a8fcbe4211@oss.qualcomm.com>
 <886466f0-0df2-4ee0-90f7-bd7e7bd731d9@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <886466f0-0df2-4ee0-90f7-bd7e7bd731d9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1LBiHSbSJrRGD4R6GxVBTWikbJq5z8-v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfXweKf3LW2l2/R
 rnnwWngg++UjiYHc+kz/tgXYmHg9wTlH0Flz+lnO57wNbQfl7zo6tBdbJ90ug9iMW4c2p+MuJFZ
 gH6ipxKk7SJJkR+0IFRBn/pD0Xxrphw=
X-Authority-Analysis: v=2.4 cv=D4Z37PRj c=1 sm=1 tr=0 ts=6a6c5e59 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=mrmDAJacfjHp5PIfN2e9YA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=-09G-BynkYMubqyH6yoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfX+yMjkqfd+oGz
 9NaOwo9Hf+lCIhjDBGjH8cz5KmhrLFFLatT6jEZdL7izjWaINKY/muJICj4Vtlew8fPXQwiuf/y
 UUcl8GmtEJeZpduccH0tpgdwIAsI+zBhqAk4hGcK8VTEX2/ashx5SWaiLtjpQqY7CfRX+7dvmTN
 5e60fIwUMXiz7V8CXuRmYlzZSqfQdQ0XHSljpzvW6OJu8NJDsdNc5/k7Yyojggn0oMu9DvFqTs3
 IiscaqHmRDXl4RJJQdrQsZ3B/PQSNt7Vsil4BXEOMdT1/GeVFejkAFXpWF46n4aJn3imvC3B5kH
 vJrMlI3CxXhY0QaxcpH+M/PlM2DrYD+IclstI7KBqolPuarUnysCx6mM6ZTQhw6xSvkwRq47Qje
 gevcVnsugz5YKarOd4FkvyBS0g9Rhj5JGKJQJf9/f9Gm3dVl88Lyn+n0WJ9AiCdqCqDYDM/ZyIf
 4FYPlg7+z0PSHVglTvg==
X-Proofpoint-ORIG-GUID: 1LBiHSbSJrRGD4R6GxVBTWikbJq5z8-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received];
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
X-Rspamd-Queue-Id: E4790436DA
X-Spamd-Bar: ----
Message-ID-Hash: YTP3VREIAVF47HV2LDFHTHJXGZPN2N5I
X-Message-ID-Hash: YTP3VREIAVF47HV2LDFHTHJXGZPN2N5I
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YTP3VREIAVF47HV2LDFHTHJXGZPN2N5I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Amir,

On 29-07-2026 12:35 pm, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 7/22/2026 4:59 PM, Harshal Dev wrote:
>> QTEE exposes certain secure services implemented either within the QTEE
>> kernel or via pre-loaded Trusted Applications (TAs). Such always-available
>> services can be readily accessed by TEE client drivers via QTEE's
>> object-IPC protocol if the service is registered as a device on the TEE
>> bus.
>>
>> One such service is the EFI-variables service, implemented by the
>> uefisecapp TA which enables kernel clients to access EFI variables at
>> runtime.
>>
>> Maintain a static list of such always-available secure services and add
>> support for the QCOMTEE driver to register these services as devices on
>> the TEE bus during probe.
>>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>>  drivers/tee/qcomtee/call.c           | 160 ++++++++++++++++++++++++++++++++++-
>>  drivers/tee/qcomtee/core.c           |   9 +-
>>  drivers/tee/qcomtee/qcomtee.h        |  12 +++
>>  drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
>>  drivers/tee/qcomtee/qcomtee_object.h |   3 +-
>>  5 files changed, 177 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>> index c1bba5fbfa3e..e909955e6b21 100644
>> --- a/drivers/tee/qcomtee/call.c
>> +++ b/drivers/tee/qcomtee/call.c
>> @@ -662,7 +662,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>>  {
>>  	struct qcomtee_object *client_env, *service;
>>  	struct qcomtee_arg u[3] = { 0 };
>> -	int result;
>> +	int result, error = 0;
>>  
>>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>>  		qcomtee_object_invoke_ctx_alloc(ctx, true);
>> @@ -675,9 +675,13 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>>  
>>  	/* Get ''FeatureVersions Service'' object. */
>>  	service = qcomtee_object_get_service(oic, client_env,
>> -					     QCOMTEE_FEATURE_VER_UID);
>> -	if (service == NULL_QCOMTEE_OBJECT)
>> +					     QCOMTEE_FEATURE_VER_UID,
>> +					     &error);
>> +	if (service == NULL_QCOMTEE_OBJECT) {
>> +		if (error)
>> +			pr_err("Failed to get service! error: %d\n", error);
>>  		goto out_failed;
>> +	}
> 
> no need to check for !error (why new variable reuse result),

Ack. will use 'result' everywhere where I am calling this. Makes sense.

> just print "FeatureVersions Service unavailable (%d)", result
> The message "Failed to get service! error: %d\n" is not helpful.

Ack.

> 
>>  
>>  	/* IB: Feature to query. */
>>  	u[0].b.addr = &id;
>> @@ -697,6 +701,153 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>>  	qcomtee_object_put(client_env);
>>  }
>>  
>> +/**
>> + * is_qcomtee_service_available() - Check if the QTEE service identified by the UID
>> + * is available
>> + * @ctx: TEE context.
>> + * @uid: 32-bit UID of the service.
>> + *
>> + * Returns true if the service exists and is available.
>> + * Returns false if a service is not exposed by QTEE.
>> + */
>> +static bool is_qcomtee_service_available(struct tee_context *ctx, u32 uid)
>> +{
>> +	struct qcomtee_object *client_env;
>> +	struct qcomtee_object *service;
>> +	int error = 0;
>> +	bool ret = false;
>> +
>> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>> +		qcomtee_object_invoke_ctx_alloc(ctx, true);
>> +	if (!oic)
>> +		return ret;
>> +
>> +	client_env = qcomtee_object_get_client_env(oic);
>> +	if (client_env == NULL_QCOMTEE_OBJECT)
>> +		return ret;
>> +
>> +	/* Get service object corresponding to the uid. */
>> +	service = qcomtee_object_get_service(oic, client_env, uid, &error);
>> +	if (service != NULL_QCOMTEE_OBJECT) {
>> +		qcomtee_object_put(service);
>> +		ret = true;
>> +	}
>> +
>> +	/* When we fail to get the service, QTEE provides the reason. */
>> +	if (error)
>> +		pr_err("Failed to get service! error: %d\n", error);
>> +
> 
> This is not a useful message. We need to know which static service is missing:
> e.g. print "%s is unavailable (%d)", qcom.tz.uefisecapp, error.

Ack.

> Also it is possible to re-org to avoid qcomtee_object_invoke_ctx_alloc() and
> qcomtee_object_get_client_env() on each iteration? oic is reusable.
>

Agreed, since this is called in a loop, it results in unnecessary re-allocation
on every iteration and call to QTEE for getting client_env().
Ack. 
>> +	qcomtee_object_put(client_env);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * QTEE Service UUID name space identifier
>> + *
>> + * A random UUID that is allocated as a name space identifier for forming UUID's
>> + * representing secure services exposed by QTEE.
>> + */
>> +static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
>> +						     0x93, 0x4e, 0xa2, 0xf2,
>> +						     0x0a, 0xba, 0x98, 0x42);
>> +
>> +static const struct qtee_service qtee_services[] = {
>> +	{ "qcom.tz.uefisecapp",
>> +	   QCOMTEE_UEFI_SEC_UID }
>> +};
>> +
>> +static void qtee_release_service(struct device *dev)
>> +{
>> +	struct tee_client_device *qtee_service = to_tee_client_device(dev);
>> +
>> +	kfree(qtee_service);
>> +}
>> +
>> +/**
>> + * qtee_enumerate_service() - Enumerate a given QTEE service and register
>> + * it on the TEE bus as a TEE client device
>> + * @ctx: TEE context.
>> + * @service_uuid: UUID of the service to be registered on the TEE bus.
>> + * @uid: 32-bit UID used by QTEE to identify the service.
>> + *
>> + * Returns 0 on success and < 0 on failure.
>> + */
>> +static int qtee_enumerate_service(struct tee_context *ctx, const char *service_name,
>> +				  const u32 uid)
>> +{
>> +	struct tee_client_device *qtee_service;
>> +	uuid_t service_uuid;
>> +	int rc;
>> +
>> +	if (!is_qcomtee_service_available(ctx, uid))
>> +		return -ENXIO;
> 
> -EOPNOTSUPP?

Ack.

> 
>> +
>> +	tee_generate_uuid_v5(&service_uuid, &qtee_service_uuid_ns, service_name,
>> +			     strlen(service_name));
>> +
>> +	qtee_service = kzalloc_obj(*qtee_service);
>> +	if (!qtee_service)
>> +		return -ENOMEM;
>> +
>> +	qtee_service->dev.bus = &tee_bus_type;
>> +	qtee_service->dev.release = qtee_release_service;
>> +	if (dev_set_name(&qtee_service->dev, "qtee-svc-%pUb", &service_uuid)) {
>> +		kfree(qtee_service);
>> +		return -ENOMEM;
>> +	}
>> +	uuid_copy(&qtee_service->id.uuid, &service_uuid);
>> +
>> +	rc = device_register(&qtee_service->dev);
>> +	if (rc) {
>> +		pr_err("QTEE service registration failed, err: %d\n", rc);
>> +		put_device(&qtee_service->dev);
>> +		kfree(qtee_service);
> 
> It is double free!? is not put_device enough?
>

Thank you for catching this, I did not realize that put_device frees the entire
struct.

Ack. 
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * qtee_enumerate_services() - Enumerate all the secure services exposed by QTEE
>> + * from the static 'qtee_services' list and register them on the TEE bus as
>> + * TEE client devices.
>> + *
>> + * Not all versions of QTEE support a given service. Hence, we try to
>> + * enumerate as many services from the 'qtee_services' list as possible.
>> + * Not being able to enumerate a service shouldn't cause the driver probe
>> + * to fail since none of the services in the list are mandatory for
>> + * establishing communication with QTEE.
>> + * @ctx: TEE context.
>> + */
>> +static void qtee_enumerate_services(struct tee_context *ctx)
>> +{
>> +	int rc;
>> +	u32 idx;
>> +
>> +	for (idx = 0; idx < ARRAY_SIZE(qtee_services); idx++) {
>> +		rc = qtee_enumerate_service(ctx, qtee_services[idx].name,
>> +					    qtee_services[idx].uid);
>> +		if (rc == -ENXIO)
>> +			pr_err("QTEE does not implement service %d.\n",
>> +			       qtee_services[idx].uid);
> 
> If you print in is_qcomtee_service_available(), why here again?
>

Ack, will remove from here.

Regards,
Harshal 
> - Amir
> 
>> +	}
>> +}
>> +
>> +static int qtee_unregister_service(struct device *dev, void *data)
>> +{
>> +	if (!strncmp(dev_name(dev), "qtee-svc", strlen("qtee-svc")))
>> +		device_unregister(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void qtee_unregister_services(void)
>> +{
>> +	bus_for_each_dev(&tee_bus_type, NULL, NULL,
>> +			 qtee_unregister_service);
>> +}
>> +
>>  static const struct tee_driver_ops qcomtee_ops = {
>>  	.get_version = qcomtee_get_version,
>>  	.open = qcomtee_open,
>> @@ -778,6 +929,8 @@ static int qcomtee_probe(struct platform_device *pdev)
>>  		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
>>  		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
>>  
>> +	qtee_enumerate_services(qcomtee->ctx);
>> +
>>  	return 0;
>>  
>>  err_dest_wq:
>> @@ -807,6 +960,7 @@ static void qcomtee_remove(struct platform_device *pdev)
>>  {
>>  	struct qcomtee *qcomtee = platform_get_drvdata(pdev);
>>  
>> +	qtee_unregister_services();
>>  	teedev_close_context(qcomtee->ctx);
>>  	/* Wait for RELEASE operations to be processed for QTEE objects. */
>>  	tee_device_unregister(qcomtee->teedev);
>> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
>> index b1cb50e434f0..4e39e867c3e9 100644
>> --- a/drivers/tee/qcomtee/core.c
>> +++ b/drivers/tee/qcomtee/core.c
>> @@ -896,19 +896,20 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic)
>>  
>>  struct qcomtee_object *
>>  qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
>> -			   struct qcomtee_object *client_env, u32 uid)
>> +			   struct qcomtee_object *client_env, u32 uid,
>> +			   int *result)
>>  {
>>  	struct qcomtee_arg u[3] = { 0 };
>> -	int ret, result;
>> +	int ret;
>>  
>>  	u[0].b.addr = &uid;
>>  	u[0].b.size = sizeof(uid);
>>  	u[0].type = QCOMTEE_ARG_TYPE_IB;
>>  	u[1].type = QCOMTEE_ARG_TYPE_OO;
>>  	ret = qcomtee_object_do_invoke(oic, client_env, QCOMTEE_CLIENT_ENV_OPEN,
>> -				       u, &result);
>> +				       u, result);
>>  
>> -	if (ret || result)
>> +	if (ret || *result)
>>  		return NULL_QCOMTEE_OBJECT;
>>  
>>  	return u[1].o;
>> diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
>> index f39bf63fd1c2..66d305a46c0a 100644
>> --- a/drivers/tee/qcomtee/qcomtee.h
>> +++ b/drivers/tee/qcomtee/qcomtee.h
>> @@ -17,6 +17,8 @@
>>  #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
>>  #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
>>  
>> +#define QTEE_UUID_NS_NAME_SIZE	        128
>> +
>>  /**
>>   * struct qcomtee - Main service struct.
>>   * @teedev: client device.
>> @@ -39,6 +41,16 @@ struct qcomtee {
>>  	u32 qtee_version;
>>  };
>>  
>> +/**
>> + * struct qtee_service - A secure service exposed by QTEE identified by a 32-bit UID.
>> + * @name: Name of the QTEE service.
>> + * @uid: 32-bit UID used by QTEE to identify the service.
>> + */
>> +struct qtee_service {
>> +	const char *name;
>> +	const u32 uid;
>> +};
>> +
>>  void qcomtee_fetch_async_reqs(struct qcomtee_object_invoke_ctx *oic);
>>  struct qcomtee_object *qcomtee_idx_erase(struct qcomtee_object_invoke_ctx *oic,
>>  					 u32 idx);
>> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
>> index 878f70178a5b..ecaf8db67d45 100644
>> --- a/drivers/tee/qcomtee/qcomtee_msg.h
>> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
>> @@ -105,6 +105,7 @@ union qcomtee_msg_arg {
>>  #define QTEE_VERSION_GET_MINOR(x) (((x) >> 12) & 0xffU)
>>  #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>>  
>> +#define QCOMTEE_UEFI_SEC_UID            413
>>  /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
>>  
>>  /* The message contains a callback request. */
>> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
>> index 7bd6e23b038c..f4cb9b8fcbd4 100644
>> --- a/drivers/tee/qcomtee/qcomtee_object.h
>> +++ b/drivers/tee/qcomtee/qcomtee_object.h
>> @@ -316,6 +316,7 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic);
>>  
>>  struct qcomtee_object *
>>  qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
>> -			   struct qcomtee_object *client_env, u32 uid);
>> +			   struct qcomtee_object *client_env, u32 uid,
>> +			   int *result);
>>  
>>  #endif /* QCOMTEE_OBJECT_H */
>>
> 

