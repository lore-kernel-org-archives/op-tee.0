Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80C606A324
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j7ZXNnyT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MI5c+MqR
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B3AF044243
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 13:44:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j7ZXNnyT;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MI5c+MqR;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 646E244243
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Nov 2026 13:44:41 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAH2t364450
	for <op-tee@lists.trustedfirmware.org>; Mon, 2 Nov 2026 13:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e8MBAdBKrttfmf2SLeeFXH0l/P8tVr7RM3jVh+74XjI=; b=j7ZXNnyTrTG3DEnH
	81h/yN3RpHTa0cumufUHF1oONTCUmIAk4Uh1VB+V71WDB1LlLFBnkO0CJNXxUNAn
	pQwTmX+60vHzwt+UKSpNV/BovivWDqPE+5e/qUW1xNg+MHu5BqEsShtFsS07hFsg
	QVBtfS/YUd0H9oFD5FsuCpmiWQUNjiZ7nf64AXPq3S2IQbImNKXgRxhniCHmWZqr
	3F1t6pmvDbQxECoJUa7jKm6zH3s3Z7ofUnmd/hK5qj0auKNF6zZab/N0vEwNzFHQ
	62Mc0X9CIrBDYLZ4g1vMYCqkXCeM2Mv9Fo5TMsuCeIWjQmKrpvuLxlOHNCf+rKb+
	dtBE3g==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6rhqa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 02 Nov 2026 13:44:40 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8468290b866so4279311a34.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Nov 2026 05:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793627080; x=1794231880; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e8MBAdBKrttfmf2SLeeFXH0l/P8tVr7RM3jVh+74XjI=;
        b=MI5c+MqRKvUwqYtTp8PKq3BHbsVz5XwmsVeU1dsdOcc6gWXjHn8vGMkqvbBGdI22gt
         uZg/Ko2N+hm3Nd/3XJ0hy8c8c54JS1ZVj4w75CJKNkwIk87SsJYDX7PmhN00U51HihwU
         ZC4jF5y5odp51TmFygL7DhnJzX2ffvItdCB/yN7HtbSp/RYcSrp0DiO2U8R8ngrgUqjM
         KC+Qa8vOaP23IqDYD0Xk5gaN6eZVL4rYFHFgLcXUrf44LCsp0MxJ4QP1ISXvcpgxMIPx
         FCHwI+GMbXCJ1/JtEQNhUSnRX4LA/H5XtA65JSWJgTdAEJtmZxA++ZAlCJtpeigfvTc3
         Vxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627080; x=1794231880;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e8MBAdBKrttfmf2SLeeFXH0l/P8tVr7RM3jVh+74XjI=;
        b=VO4SM39hlcB8M9NGDMuuG4DWLG8n3utm0Mxc+1Bmj6DiZRh/fFdVR+lL9/JojaMosX
         ksng2Yp+xrL5wygnsU+LK2U4TU0OLZdMtfj/zO9TVhUdgbbq8mjQ6g4VT66F+XrmPDt5
         /pKubUBxi/+ufG0ZlQo7mfsR6RCB01uZKvjpAfihr3C5nWxZEasJjst0WpXaAIISzTOy
         xGZY0bhuBKKPGrNvqM/7R0zwitQpskxgNJroi4ED2nwI0mU7W9Av5cF4/dcR/GfDPZJV
         IbOV48il0FR2NUIXmPfBRvR/taNZ9H7rUeIkRjZRnVz+xCqG7ekMJDTSsnSVwlaZI/4f
         he4A==
X-Forwarded-Encrypted: i=1; AKwUvByio16jmMYRjEFt4VPsDYFv/BOHakm3zK6stzHYjXOSjMDbw8U8ualneApH6r+Bl5OJzIAQV+w=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJ9yt2r+rWZ6DYM0yK+HhAh4Yq/It4s6/pUdzqEVA2G7w0E9vtm
	bIYXeRNDqt6uVSXZpusDMjFAJOt8e0roZadvU2IJREYe2VMHa2cVHP1+XGkYBqS4qCFydTc4LBy
	rv+0bSHD1wA1m2174IV/GQTT3m3ZQvlvRCpISYG7mbOeqldQr9nVkWJLqzrHekBFNLlGnhM4P
X-Gm-Gg: AYBFou1xnD4d2fgqGTdjIWY8mGiAhFnRRgtlAqeHu5/I7keNKPt8DaN7NYwzbQzXRwX
	BPymYDeANfJ1uAYvclWIPlVNA2rQSjh3IaZmqLskrXO2zzzuvCKN9QO0lzO8pyiLMuPMTVCbjtK
	8sBptwD6RCtb0pxYuZnHfe5pvsPN8ZXkS2ABdCIZ8kGkBhNCB7NE9ix7sViQSB69i1x6wwQeC4i
	0VvlmVmurKJQQyNk3XQZZ0b07SCbSU27jCMmGDxPM07WDJlrEWx5IVw+6z8/ttvYZhZa4cYdotV
	sFtb4Zju5Nl8/MvjK4YxYFwATQONznUq3W8zSZLptb1vydoiR45A1yoGIqDeEChbihl1nRS1Obt
	SVY6k9nHUY4Lx4ewsNQ+YkPLvDojjRG8b1mPMh5hDiQaf7RZluKkSdKDwG8bc8kV0skPhMYmNNA
	==
X-Received: by 2002:a05:6820:151b:b0:6d8:d121:a970 with SMTP id 006d021491bc7-714f27a0151mr5260221eaf.76.1793627080086;
        Mon, 02 Nov 2026 05:44:40 -0800 (PST)
X-Received: by 2002:a05:6820:151b:b0:6d8:d121:a970 with SMTP id 006d021491bc7-714f27a0151mr5260199eaf.76.1793627079603;
        Mon, 02 Nov 2026 05:44:39 -0800 (PST)
Received: from [10.92.207.38] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2e5b450sm8780853eaf.11.2026.11.02.05.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 05:44:38 -0800 (PST)
Message-ID: <395a146a-5c60-486c-869b-d3706f5e85cc@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 19:14:32 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-5-1460691b35d3@oss.qualcomm.com>
 <b27834b1-4ed3-4eb1-a8e3-a1239f20ad43@oss.qualcomm.com>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Organization: Qualcomm
In-Reply-To: <b27834b1-4ed3-4eb1-a8e3-a1239f20ad43@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX8wgynEZLRqhZ
 v7AYFa4mZq45+X0Y7n4y4Pi0X0aPaDFbl4Qyxmulf3XBxWH/ej4J5mPMsfWm7mve8rd8b17fUuX
 y84N/vHfGw2QeHBBD5um0Q697IOIVi21BfvHu0Rpg6ss7Hr7dKszvVo171nxCu03V4WA6LTioTj
 I+2qycNg0Og1H5mmAMY4ewIsqAUA04UcbKs5msHVD1u/w7+jT8RnMxaJdQCvk3jkRNfEdXmDhfS
 CnXX3GviSHZk/Cv07zLQ3axgQbJ/gLAHeBOjeTdNI/ydYBq9nMfaZ25Uo0PSr7RUWtvE3l+uz1/
 8xanL4uLY1oT+i1VtCdE5zbk1/Dy2o7ldizOvcXsuBhScOX96bua6NWE0RLFxOP8NfdWlcM1aj/
 GaaQyofSJh7FhuqLsrvW/7iFdlg6f+AATS59MwLy2dsiB4HVhCRVNN5+6NDNKJ6o8U3Tf497Vy8
 cPyBfjQHS3uHAjO0jbA==
X-Proofpoint-GUID: toApYyh7LrWGYJimjIZey7E7w5Rm0clj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX2nBdpOBOnphq
 VwVc8shVwSZoVyoOQJR+mospQPm0K7hTP6qkrkHYhpAD5et+fjPCf//plizUifjJ8JKlVXMgKrr
 1zv/euo/i/mb/8ag3LX/VMOM1P8Epak=
X-Proofpoint-ORIG-GUID: toApYyh7LrWGYJimjIZey7E7w5Rm0clj
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae893c8 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CC0UIsglRpZkCHxahuUA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.210.69:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 646E244243
X-Spamd-Bar: ----
Message-ID-Hash: ZVYWFIHNICQKY4YNWGSMNY67BFVXATPN
X-Message-ID-Hash: ZVYWFIHNICQKY4YNWGSMNY67BFVXATPN
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZVYWFIHNICQKY4YNWGSMNY67BFVXATPN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Amir,

On 26-10-2026 09:21 am, Amirreza Zarrabi wrote:
> Hi Harshal,
> 
> On 10/15/2026 10:39 PM, Harshal Dev wrote:
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
>>  drivers/tee/qcomtee/qcomtee.h        |  10 +++
>>  drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
>>  drivers/tee/qcomtee/qcomtee_object.h |   3 +-
>>  5 files changed, 176 insertions(+), 7 deletions(-)
>>

[...]

>> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
>> index 60fe3b5776e3..4a523a95bf0e 100644
>> --- a/drivers/tee/qcomtee/core.c
>> +++ b/drivers/tee/qcomtee/core.c
>> @@ -898,19 +898,20 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic)
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
> 
> Please initialize *result, otherwise for instance, on mem allocation failure,
> qcomtee_object_do_invoke returns with errno. The caller checks the return value + result
> and may print garbage.
>

Ack, will initialize here and omit in the caller.

Regards,
Harshal 
> - Amir
