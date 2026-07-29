Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E03C53219
	for <op-tee@archiver.kernel.org>; Wed, 29 Jul 2026 07:05:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8059F44AB6
	for <op-tee@archiver.kernel.org>; Wed, 29 Jul 2026 07:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785308758;
	bh=LaUwlQ0pih/C9P6PsaoCmPY4eWOetzY9qEQD7G+NwXo=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BiSG0KzXPjy/jDLvbWEE83w0hgHMtTK7wBSR8FnGwUTgNM5Th5urHDfl3RLn9l0KZ
	 G5dX/xgFmvzMOvcwl5YF3m7XyFHk2NNhq+Hq1n2lw4xNnaTnVHhbxm+unmgEeVKV8p
	 1rHH+2FXl7R1LvB4TqyI0rBUFjwA2pmE7kd4CTTRW9OmV4wDYNKsuiE4EXokuENh5a
	 XJYV8ILn9RQV7HjT9fO1RHhmLFczlipFh6bpsh+NfGt73n9SWrC1hyfrWjVW7nZGeu
	 N6Y0wzqbZJaE0xhQq/RT3YreF0l5tEvfS7qmk2Lc7uWoBLIy/ie6Q/Oe3rVEXnWirJ
	 Hh6sFd3SWE1JA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4678C43E47
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 07:05:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M+D3M5ne;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hi9sdrgd;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T5ihfa416927
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 07:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hPd1z/hiGeNUquxIW1lIFG9lE3k/jZoE7Z6Nq9oWubA=; b=M+D3M5neEfdS89jc
	00fCUb3yivgrJVOQb5NgE/rpPQXa6cdK3ie6bylmM8ljExHkvYmqDsp64k8bIM09
	VSbPio4osvh3240e6mE05dnWySnfUhpAgbA5LHAoaVPDCSviRM447mMWALeNXLjB
	hz5SnFfNGCmoERKGpYhJrKfrFmzoEVsPBwALWfCtmw4lCzTI/xCU+dGrL2W3TmE4
	mLbWFq48SQXVrphNQtH1p0JYA2pvzDDIknujdYt0OfJtBbb8zAmp55ea4poyJ+so
	dKcwDgrrNH1cr22v/+I1xrB2zPJmfqj0aD6E99ae1Nu20gY9pfctgrU+xLlRpEq2
	vykAlQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqbn1r9r3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 07:05:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848662cd2a1so781373b3a.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785308750; x=1785913550; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPd1z/hiGeNUquxIW1lIFG9lE3k/jZoE7Z6Nq9oWubA=;
        b=Hi9sdrgdGSpKIsMdnLOeOt0w7pLP3zmY+KkIjQhwjgz8fPHPYvsiI2gejbBQduMp2W
         dT2ay/wTRS5/uXFpOXdr4kVm2z5KMkP/NC1OkxBxHClc01wZ+9IyXDZwG9r49f5M7rrT
         y0Rj8W5RVcCbnF9aozEIeyF53Ap8iBFrnKwogyCxzXM6ocD5YUuEI2Uv6i0AwnHqpG46
         w36+AXeGCPizn+45n6/xCHEDcq+RlekhV7dQgRYhTq1W1/QwPEKTskU2j0dS8vn6QW3i
         pY9PAjurDVdweM9iVg/f9jAzJed1gslKuQAiwTtsQM2E9/Lhx9ui/JsPk1ziucD0k9GO
         iKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785308750; x=1785913550;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPd1z/hiGeNUquxIW1lIFG9lE3k/jZoE7Z6Nq9oWubA=;
        b=Ii3FvYVnrAc4LCWyL5LPqbm3zHhgS+TflC6R6ady/t3siXAkOR39dC//A8ICGQOSSE
         MOTJxXwd73qLDoc6HiFIB6v7wFJcdcBFE4KVthr8G3GXdJgABrBZ49WPzxQV8kK75Fsp
         wQD11JseYmSy9TDVkw+c91z15dz6qx/KswZxLNPEN9rpHlXB/E2tzMzGbuJPnUEI+w5C
         LWHl/itevQfflYWuvOWZyPLgZe4hFBWQ7ZrXh8UUzalK2DIDg0rEX1+zeCLfyvQtZvyI
         Ak9ki9ZZdTjQ7WmVgqFTU8nL2u/e9ClNB4jp1cPBWJsK+YksHACB2BGgT1RbwDbrdy8j
         K0mA==
X-Forwarded-Encrypted: i=1; AHgh+RorKiJ7lRMa0wbLrAVFmyKK1prSdETCgz0b2pBzYYXvI+OkZbZ2ZpkYeqPLJcfHhiz8xNo9Dog=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyYGxpOlU7zQpzNhEIN3sMRVihCqLmo21E3TYILAQ0JwwVz0vbE
	365sCwMtAdM2Q8aodd9NgVRl73DWFILJyUqXBj/wStR2nzrIMsGyiTPVIA8wInSLKZyyaUDTs/t
	ITLNvcaLr9vpo2lLUxpHj6ZmI47a/sdbesdvlt9GJyEK5rnedEyKIOC5lsyfowEV3a2MxvN0=
X-Gm-Gg: AR+sD11+TVKMMDXq3EUmCWu4ONJK8/023Vph1dNCALpAgHvik0iYB9haRusLniAe3kR
	OA2dE6q38EoMq8mC3dMMRFQ+ow/4U/3DEV5v4BblYMcHP333gWDFBQR6Fmv8XcfosdJST18pbrY
	qV6krGLBjHRaV/lzNjsCX+h9+AGmWfDKkdQDugfVQ2Q8FHlVHHHVaeUzth65vjNEN6kA1lIfq4I
	paSwcJ80uFJ67vVJN9HNpVLz9UK8mlMFf1n8p3wEnsEIyWqqVYhfIY/oWwToX+wU1p7gpYlDeH8
	beOvOzxtX5O4ln+R0Knz73Z6KEsXqBBb6U+QT/5lf6E+YJmchjQlhCUd3/QW42578gzas3IfKYe
	OpwIYHigJeSiKNqRMRYW5XRdsRgctZxODvQ==
X-Received: by 2002:a05:6a00:14cc:b0:846:f517:ba5a with SMTP id d2e1a72fcca58-84e93315ef0mr6578038b3a.28.1785308749976;
        Wed, 29 Jul 2026 00:05:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:14cc:b0:846:f517:ba5a with SMTP id d2e1a72fcca58-84e93315ef0mr6577998b3a.28.1785308749446;
        Wed, 29 Jul 2026 00:05:49 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.12.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea037565csm896471b3a.46.2026.07.29.00.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 00:05:48 -0700 (PDT)
Message-ID: <886466f0-0df2-4ee0-90f7-bd7e7bd731d9@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 17:05:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <20260722-qcom_uefisecapp_migrate_qcomtee-v2-5-b8a8fcbe4211@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-5-b8a8fcbe4211@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1NSBTYWx0ZWRfX7eX/m8Ol+elL
 tt6slOOwWUOAQV1JDtC4GKD0u1Cnd8pGZEEH7EVhjkIDXO4XhCdHUqyIw6CU17kb8z/RnS9kPjk
 d97kgqHDHL+8mGlmiw4gmlHLsRXS+oI=
X-Proofpoint-ORIG-GUID: CNMY0lMSbvw9YJNW9mcutu7G5onkKcTc
X-Authority-Analysis: v=2.4 cv=csCrVV4i c=1 sm=1 tr=0 ts=6a69a64e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=1tOsOel+q48EdXbnVOFv2g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=DMr0T2b9NGca9ooh4xUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1NSBTYWx0ZWRfX2O+ujcAhGbp8
 jncfPw+VfZC+xK5sORcFV4Uao2Th5lHRe2gzOon5O2FDSoGuGVjoKl/WiHvhhBJeCVQby1Ioy24
 B6hLom41GDgQT8xuranqoogH4lE4yETHMOZIRm8H1QyOCPchnSQmQNdt0/wKBLbmUI+XIOEKFnc
 0N3qcwt1wv2jYlyf0GKviIHR33O5g5vlrJ5HAM+TOPELfZgJe73ObpQANbWjpo1tYTKyRDAqxTv
 9BxyHAzKHUht/r7W5E0oe4EcSs8pExBud1VTQJR79jMjTZUlS8jJIOTf4xxyTpy3ZxtvA2Lgmxv
 ea83jmZ9ZgXyrkRZNSys9JIDrCQ4vh2fYvDUVUHy1B44sShV95l1Fja8t8bxcDk0kl71GMaFAx1
 AeyJhxaNc/A2rfDFbMcWLCCV2n3Bg5bSWon45I6EYxaXEkQg4uwcxB8hwserl90ySG7jHBWrjbd
 neoHNSQEfEb2prelRBQ==
X-Proofpoint-GUID: CNMY0lMSbvw9YJNW9mcutu7G5onkKcTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4678C43E47
X-Spamd-Bar: ------
Message-ID-Hash: PZHVZHGANLLNQHGZCHH5K64XMF6ICV7C
X-Message-ID-Hash: PZHVZHGANLLNQHGZCHH5K64XMF6ICV7C
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PZHVZHGANLLNQHGZCHH5K64XMF6ICV7C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Harshal,

On 7/22/2026 4:59 PM, Harshal Dev wrote:
> QTEE exposes certain secure services implemented either within the QTEE
> kernel or via pre-loaded Trusted Applications (TAs). Such always-available
> services can be readily accessed by TEE client drivers via QTEE's
> object-IPC protocol if the service is registered as a device on the TEE
> bus.
> 
> One such service is the EFI-variables service, implemented by the
> uefisecapp TA which enables kernel clients to access EFI variables at
> runtime.
> 
> Maintain a static list of such always-available secure services and add
> support for the QCOMTEE driver to register these services as devices on
> the TEE bus during probe.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/call.c           | 160 ++++++++++++++++++++++++++++++++++-
>  drivers/tee/qcomtee/core.c           |   9 +-
>  drivers/tee/qcomtee/qcomtee.h        |  12 +++
>  drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
>  drivers/tee/qcomtee/qcomtee_object.h |   3 +-
>  5 files changed, 177 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index c1bba5fbfa3e..e909955e6b21 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -662,7 +662,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  {
>  	struct qcomtee_object *client_env, *service;
>  	struct qcomtee_arg u[3] = { 0 };
> -	int result;
> +	int result, error = 0;
>  
>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>  		qcomtee_object_invoke_ctx_alloc(ctx, true);
> @@ -675,9 +675,13 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  
>  	/* Get ''FeatureVersions Service'' object. */
>  	service = qcomtee_object_get_service(oic, client_env,
> -					     QCOMTEE_FEATURE_VER_UID);
> -	if (service == NULL_QCOMTEE_OBJECT)
> +					     QCOMTEE_FEATURE_VER_UID,
> +					     &error);
> +	if (service == NULL_QCOMTEE_OBJECT) {
> +		if (error)
> +			pr_err("Failed to get service! error: %d\n", error);
>  		goto out_failed;
> +	}

no need to check for !error (why new variable reuse result),
just print "FeatureVersions Service unavailable (%d)", result
The message "Failed to get service! error: %d\n" is not helpful.

>  
>  	/* IB: Feature to query. */
>  	u[0].b.addr = &id;
> @@ -697,6 +701,153 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  	qcomtee_object_put(client_env);
>  }
>  
> +/**
> + * is_qcomtee_service_available() - Check if the QTEE service identified by the UID
> + * is available
> + * @ctx: TEE context.
> + * @uid: 32-bit UID of the service.
> + *
> + * Returns true if the service exists and is available.
> + * Returns false if a service is not exposed by QTEE.
> + */
> +static bool is_qcomtee_service_available(struct tee_context *ctx, u32 uid)
> +{
> +	struct qcomtee_object *client_env;
> +	struct qcomtee_object *service;
> +	int error = 0;
> +	bool ret = false;
> +
> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
> +		qcomtee_object_invoke_ctx_alloc(ctx, true);
> +	if (!oic)
> +		return ret;
> +
> +	client_env = qcomtee_object_get_client_env(oic);
> +	if (client_env == NULL_QCOMTEE_OBJECT)
> +		return ret;
> +
> +	/* Get service object corresponding to the uid. */
> +	service = qcomtee_object_get_service(oic, client_env, uid, &error);
> +	if (service != NULL_QCOMTEE_OBJECT) {
> +		qcomtee_object_put(service);
> +		ret = true;
> +	}
> +
> +	/* When we fail to get the service, QTEE provides the reason. */
> +	if (error)
> +		pr_err("Failed to get service! error: %d\n", error);
> +

This is not a useful message. We need to know which static service is missing:
e.g. print "%s is unavailable (%d)", qcom.tz.uefisecapp, error.
Also it is possible to re-org to avoid qcomtee_object_invoke_ctx_alloc() and
qcomtee_object_get_client_env() on each iteration? oic is reusable.

> +	qcomtee_object_put(client_env);
> +	return ret;
> +}
> +
> +/*
> + * QTEE Service UUID name space identifier
> + *
> + * A random UUID that is allocated as a name space identifier for forming UUID's
> + * representing secure services exposed by QTEE.
> + */
> +static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
> +						     0x93, 0x4e, 0xa2, 0xf2,
> +						     0x0a, 0xba, 0x98, 0x42);
> +
> +static const struct qtee_service qtee_services[] = {
> +	{ "qcom.tz.uefisecapp",
> +	   QCOMTEE_UEFI_SEC_UID }
> +};
> +
> +static void qtee_release_service(struct device *dev)
> +{
> +	struct tee_client_device *qtee_service = to_tee_client_device(dev);
> +
> +	kfree(qtee_service);
> +}
> +
> +/**
> + * qtee_enumerate_service() - Enumerate a given QTEE service and register
> + * it on the TEE bus as a TEE client device
> + * @ctx: TEE context.
> + * @service_uuid: UUID of the service to be registered on the TEE bus.
> + * @uid: 32-bit UID used by QTEE to identify the service.
> + *
> + * Returns 0 on success and < 0 on failure.
> + */
> +static int qtee_enumerate_service(struct tee_context *ctx, const char *service_name,
> +				  const u32 uid)
> +{
> +	struct tee_client_device *qtee_service;
> +	uuid_t service_uuid;
> +	int rc;
> +
> +	if (!is_qcomtee_service_available(ctx, uid))
> +		return -ENXIO;

-EOPNOTSUPP?

> +
> +	tee_generate_uuid_v5(&service_uuid, &qtee_service_uuid_ns, service_name,
> +			     strlen(service_name));
> +
> +	qtee_service = kzalloc_obj(*qtee_service);
> +	if (!qtee_service)
> +		return -ENOMEM;
> +
> +	qtee_service->dev.bus = &tee_bus_type;
> +	qtee_service->dev.release = qtee_release_service;
> +	if (dev_set_name(&qtee_service->dev, "qtee-svc-%pUb", &service_uuid)) {
> +		kfree(qtee_service);
> +		return -ENOMEM;
> +	}
> +	uuid_copy(&qtee_service->id.uuid, &service_uuid);
> +
> +	rc = device_register(&qtee_service->dev);
> +	if (rc) {
> +		pr_err("QTEE service registration failed, err: %d\n", rc);
> +		put_device(&qtee_service->dev);
> +		kfree(qtee_service);

It is double free!? is not put_device enough?

> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * qtee_enumerate_services() - Enumerate all the secure services exposed by QTEE
> + * from the static 'qtee_services' list and register them on the TEE bus as
> + * TEE client devices.
> + *
> + * Not all versions of QTEE support a given service. Hence, we try to
> + * enumerate as many services from the 'qtee_services' list as possible.
> + * Not being able to enumerate a service shouldn't cause the driver probe
> + * to fail since none of the services in the list are mandatory for
> + * establishing communication with QTEE.
> + * @ctx: TEE context.
> + */
> +static void qtee_enumerate_services(struct tee_context *ctx)
> +{
> +	int rc;
> +	u32 idx;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(qtee_services); idx++) {
> +		rc = qtee_enumerate_service(ctx, qtee_services[idx].name,
> +					    qtee_services[idx].uid);
> +		if (rc == -ENXIO)
> +			pr_err("QTEE does not implement service %d.\n",
> +			       qtee_services[idx].uid);

If you print in is_qcomtee_service_available(), why here again?

- Amir

> +	}
> +}
> +
> +static int qtee_unregister_service(struct device *dev, void *data)
> +{
> +	if (!strncmp(dev_name(dev), "qtee-svc", strlen("qtee-svc")))
> +		device_unregister(dev);
> +
> +	return 0;
> +}
> +
> +static void qtee_unregister_services(void)
> +{
> +	bus_for_each_dev(&tee_bus_type, NULL, NULL,
> +			 qtee_unregister_service);
> +}
> +
>  static const struct tee_driver_ops qcomtee_ops = {
>  	.get_version = qcomtee_get_version,
>  	.open = qcomtee_open,
> @@ -778,6 +929,8 @@ static int qcomtee_probe(struct platform_device *pdev)
>  		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
>  		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
>  
> +	qtee_enumerate_services(qcomtee->ctx);
> +
>  	return 0;
>  
>  err_dest_wq:
> @@ -807,6 +960,7 @@ static void qcomtee_remove(struct platform_device *pdev)
>  {
>  	struct qcomtee *qcomtee = platform_get_drvdata(pdev);
>  
> +	qtee_unregister_services();
>  	teedev_close_context(qcomtee->ctx);
>  	/* Wait for RELEASE operations to be processed for QTEE objects. */
>  	tee_device_unregister(qcomtee->teedev);
> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> index b1cb50e434f0..4e39e867c3e9 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -896,19 +896,20 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic)
>  
>  struct qcomtee_object *
>  qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
> -			   struct qcomtee_object *client_env, u32 uid)
> +			   struct qcomtee_object *client_env, u32 uid,
> +			   int *result)
>  {
>  	struct qcomtee_arg u[3] = { 0 };
> -	int ret, result;
> +	int ret;
>  
>  	u[0].b.addr = &uid;
>  	u[0].b.size = sizeof(uid);
>  	u[0].type = QCOMTEE_ARG_TYPE_IB;
>  	u[1].type = QCOMTEE_ARG_TYPE_OO;
>  	ret = qcomtee_object_do_invoke(oic, client_env, QCOMTEE_CLIENT_ENV_OPEN,
> -				       u, &result);
> +				       u, result);
>  
> -	if (ret || result)
> +	if (ret || *result)
>  		return NULL_QCOMTEE_OBJECT;
>  
>  	return u[1].o;
> diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
> index f39bf63fd1c2..66d305a46c0a 100644
> --- a/drivers/tee/qcomtee/qcomtee.h
> +++ b/drivers/tee/qcomtee/qcomtee.h
> @@ -17,6 +17,8 @@
>  #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
>  #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
>  
> +#define QTEE_UUID_NS_NAME_SIZE	        128
> +
>  /**
>   * struct qcomtee - Main service struct.
>   * @teedev: client device.
> @@ -39,6 +41,16 @@ struct qcomtee {
>  	u32 qtee_version;
>  };
>  
> +/**
> + * struct qtee_service - A secure service exposed by QTEE identified by a 32-bit UID.
> + * @name: Name of the QTEE service.
> + * @uid: 32-bit UID used by QTEE to identify the service.
> + */
> +struct qtee_service {
> +	const char *name;
> +	const u32 uid;
> +};
> +
>  void qcomtee_fetch_async_reqs(struct qcomtee_object_invoke_ctx *oic);
>  struct qcomtee_object *qcomtee_idx_erase(struct qcomtee_object_invoke_ctx *oic,
>  					 u32 idx);
> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
> index 878f70178a5b..ecaf8db67d45 100644
> --- a/drivers/tee/qcomtee/qcomtee_msg.h
> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
> @@ -105,6 +105,7 @@ union qcomtee_msg_arg {
>  #define QTEE_VERSION_GET_MINOR(x) (((x) >> 12) & 0xffU)
>  #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>  
> +#define QCOMTEE_UEFI_SEC_UID            413
>  /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
>  
>  /* The message contains a callback request. */
> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
> index 7bd6e23b038c..f4cb9b8fcbd4 100644
> --- a/drivers/tee/qcomtee/qcomtee_object.h
> +++ b/drivers/tee/qcomtee/qcomtee_object.h
> @@ -316,6 +316,7 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic);
>  
>  struct qcomtee_object *
>  qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
> -			   struct qcomtee_object *client_env, u32 uid);
> +			   struct qcomtee_object *client_env, u32 uid,
> +			   int *result);
>  
>  #endif /* QCOMTEE_OBJECT_H */
> 

