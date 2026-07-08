Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFDFC43458
	for <op-tee@archiver.kernel.org>; Wed,  8 Jul 2026 06:01:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D838645046
	for <op-tee@archiver.kernel.org>; Wed,  8 Jul 2026 06:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783490518;
	bh=WRcaoMH+g/SoWUtKRqzbRYwUKYcUQ2XK7GrXG21fTJI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qSu4NK8bHTg4GqaNgSlQgHnmjaFNCqL7hVLfwst7ZmJi5/zjKBSy7i1WWoDoHF1rC
	 hvPJwyOHd5WGWbSsv1kcIyazXs43BzrhOmuYxWSo76dIsZEee73dV+BNhxnVeIKnmu
	 3rqkqH+JbI5O5kxoUgWKIPCkaiNpvWKGkNTCH29nxpwHqlpHcsMRFIDnsb2m5mKcZU
	 zGc90T8zMmqWBlFuwwoGiLWBGeDCUvmWmP0rfCDlproXKKjKDzmQqnkU1x19X43iY/
	 aG/AsVWeTePos+ArOzIswLnvXj9VJO3JhUaPfbUmTZZYUCNsRfAvoIT383KEZ2k+Ah
	 kbNE3k+TNqZ3A==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B25874152C
	for <op-tee@lists.trustedfirmware.org>; Wed,  8 Jul 2026 06:01:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fjdbr4gN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=av1tnEbd;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842BDM1572668
	for <op-tee@lists.trustedfirmware.org>; Wed, 8 Jul 2026 06:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7z8OET7rO6M3TRuXlj9b3aCKb7Zgt+kWJI0H9Bb/fuw=; b=Fjdbr4gNWBSM8/F0
	0tZHbKfgy1SYKpIq59hJGEZYeCBQtwX7vVFGQUX7uVcvAu8aISWrnF4KILKeotMR
	eFOt2iq6GOZwDdzKL6UtARsDBBj1sB/ySNYzLcCHfDJEr/GjuUyfIsxpx8LP6taU
	kEqfMrPcg6satyig8DGtXxDLSG17sGuf4C7y57zyzIuos8RNd+q1aml4+8xTeKTt
	Iah4yuLAPIE1KbZNFepnFDSzMmFT2TbNo3p277pZ1xqD1rFy3T5FO4Q40ZE5mscY
	bPKQk6g1R2FI0rsI2iqlTLdxm0cELW2/xIPm/GDEqs2XWQ2jSGVJIyZHKhDnZPg1
	cx6bOg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f99hgsms8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 08 Jul 2026 06:01:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c354050c34so5973485ad.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 07 Jul 2026 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783490511; x=1784095311; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7z8OET7rO6M3TRuXlj9b3aCKb7Zgt+kWJI0H9Bb/fuw=;
        b=av1tnEbdh3xO3V3CZIK/BpFPydDZe7kp423ZV3iX/5AH3q6/dFPujD0DnmOmCfsSpy
         6mGO7ep/y8qDF+I2Aowq0OBYtKN0SLYpJxASPha38mjKomn5nhdNgp9Ccf6gFLIG31N4
         Dm7kPGmExBK94JN7iy+r5ADXQIpup+xU3RET7h1OEELZkkWRAQCGYyZ54Mf4sk8r2FKa
         S0OBvrzuBGvlDihFO6nsIB3XFCkX98OqoRy8pYx7TCliWWTb3sYXaDpJ5ceZ7dzME+5V
         yTr1/VHGiBAjUxb2JJBx6dw2ytwfeGHhJBu8aTLFoy+kttADNjSkjA9qZNt1zOYrC/e0
         jj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783490511; x=1784095311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z8OET7rO6M3TRuXlj9b3aCKb7Zgt+kWJI0H9Bb/fuw=;
        b=CixKH4aNFqgmN/rXAhwcEmwHEOPXKfugcr4KSe6jjQvxbzM2FYcZManLYE9tvYbpfX
         YsMR4Y0rMZcZiYDedgNGpK/Zvp3ON21uLUfP3IyH4wTP8MCAloe5lhsQyO9o7nPt2wkN
         QaCPQQIvDthFv3opz0LMrT6UexVr+p27lZg1p7Y1cce3RmiriBY1iplRJ/GPujs24Upn
         ZwlwZ0ly0iLgq+dqPk5eC7swPwwyI1ZuhFF+FF8b5gExHwUMF2DLVwnlGMYPS/T5NIUY
         +3qahcwSeYLAm/se8UQYywOsDw5vBVyt6ZINVF8hS1rv9yjPbGvH+XHwBbehU4FtZ0Cp
         psOA==
X-Forwarded-Encrypted: i=1; AHgh+RoqJQK5pE3l9x3zMorJE5Jf6VNC6U7Jr+Bo9feMqBkO3+K3CN9QIy56z2gaMTF/g0QDORBpQrQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx3moMG/WlJYLZHlwUAP26Pg2LfKIMlQh45B7f8m6ZqWUdfYHuc
	sMgRvROJoKMjqCZ6uB23baz4MYmLCNENsFw68B1ddlm+qk6U3YT8FmKW53c+7i608WFFc5UD41V
	XHQ2dSHVsDi7I9Jq/55KGT4nOOlLjuHt6SmouulCWF71oSUNn3jkkGnU2j6ll9TBITW6KRH0=
X-Gm-Gg: AfdE7cnscP+6TUmTKSE25yozj1/DhtoZaLRzUproKpzAUP+WJss7uZUV41OK6Klyyxp
	hBSVeGoOfKRNI0sT7FVle6qILLVTsWdXMBKIzqbHS8WLISj+4Il7Az+KTcvN0qeafKbXOg6StPj
	lJOhJT0oeGvvow678PgO3xj6n/xwc561jaiGaZTJ+i/St0A4eZiOie9sFWqXGoqf1sjDlrQgACy
	74vodGOZX3+Al8sWG0sOc7jjNfiC4q66Ku4pIXZZXXg0SzJLSImNKO0GgrAVzOoCsCnIb0VlqOE
	v8LtkKXgJZszjvY41jk1gf/6YYvnuIpKQd9OR7TY6NvqPFxxaqnmQ1ckHGgtBRP0ebHon3dY1Tr
	x5xyoDCmdA9WqyjkqR6W0IyVVomftQoHELne8NpoPUMLA
X-Received: by 2002:a17:902:f686:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2ccea5a4c8emr12224075ad.43.1783490510835;
        Tue, 07 Jul 2026 23:01:50 -0700 (PDT)
X-Received: by 2002:a17:902:f686:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2ccea5a4c8emr12223645ad.43.1783490510210;
        Tue, 07 Jul 2026 23:01:50 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.113.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1ea74sm22247685ad.41.2026.07.07.23.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 23:01:49 -0700 (PDT)
Message-ID: <b7c8b25b-374f-40a4-9c6d-bb20ee0cb5c9@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 16:01:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tee: qcomtee: Track the object invocation context
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
 <20260707-qcom_uefisecapp_migrate_qcomtee-v1-1-f659cbd5d04c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-1-f659cbd5d04c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: M42RNPdpjqEm5pE2dRhOXwznW2Uz0h3i
X-Authority-Analysis: v=2.4 cv=CviPtH4D c=1 sm=1 tr=0 ts=6a4de7d0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=+r7WnWcjNhrw7ahDJtTqLQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Xpymrd_i7WOtP7wGS5kA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: M42RNPdpjqEm5pE2dRhOXwznW2Uz0h3i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NSBTYWx0ZWRfX9QmaO2twX3Nr
 aToASFcMJgtEim97GLD/WBa8tjeCp7ICoqM44FgqFjT7vMlew4RxP2R6OiEkRtA6Nq1l+q7oNEc
 Tt7MvJmfoxmqPSF0ht9m1X8qJpscU2o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NSBTYWx0ZWRfX7ukdjxEcTGo5
 a1hn50iw+6jDJXfvmtqnuu9/f0kH86Dhj4NoExZynf95Uolim5FipUbZ2+x480Nfp02vqOiTzlK
 7A3JIALETVe9pf2cU+O6iyukoEPBXw/PXw15MdqNEccUFKR3GeBSL8DNooX6MmZewok03fl6n4/
 5LXg2UK1VfBWQziywTCWQ6MoSwgE0uZ7O20sFp6WOxlNuDkBFt0j78VqCpimzoNEtaPJXuh5+6F
 KHvZWdsrqBpivD7yX8YTazI/8fb4B5imieD0x3ZT7YGf54EJ21UjVnhQFyNtoNNSAKpzf5KeROx
 SprG/ne/3X0RXKxC5LTy0Vb0xQ1Q67b0qD1ugj0ylNMTEh68nOHW7gS2q+Lhxj1ucC+JaNdgwk5
 Rskgyv3JhXUGR2TsmByb4Irs05+ovM8iXqbgJjcKIbN9PLauIeurFcGO6auPQRxEKlX6ERlJNv5
 iSz/11j7Ym6u5p3X+ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B25874152C
X-Spamd-Bar: ------
Message-ID-Hash: X7FZ27VCIILMTXUHXPSLRYPA5YLBU566
X-Message-ID-Hash: X7FZ27VCIILMTXUHXPSLRYPA5YLBU566
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X7FZ27VCIILMTXUHXPSLRYPA5YLBU566/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Harshal,

On 7/7/2026 4:11 PM, Harshal Dev wrote:
> QCOMTEE needs to distinguish between object invocations arriving from
> kernel clients and user-space clients in order to correctly marshal
> UBUF parameters and decide whether certain operations should be permitted.
> 
> Add a kernel_ctx flag to struct qcomtee_object_invoke_context to track
> the context of object invocation. Objects invoked from the kernel-space
> are expected to have the MSB of their 64-bit object-id set to indicate a
> kernel context, whereas objects invoked from user-space should not set it.
> To ensure this, we restrict the object-id space of user-space invoked
> objects to 32-bits. This is in-line with QTEE expectation of 32-bit object
> ids.
> 
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/call.c           | 24 ++++++++++++++++++++++--
>  drivers/tee/qcomtee/qcomtee.h        |  6 ++++++
>  drivers/tee/qcomtee/qcomtee_object.h |  8 ++++++--
>  drivers/tee/tee_core.c               |  4 ++++
>  4 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index 0efc5646242a..a74a54d67b06 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -397,11 +397,31 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  {
>  	struct qcomtee_context_data *ctxdata = ctx->data;
>  	struct qcomtee_object *object;
> +	bool kernel_ctx = false;
>  	int i, ret, result;
>  
>  	if (qcomtee_params_check(params, arg->num_params))
>  		return -EINVAL;
>  
> +	/* Obtain the invocation context information from the MSB of the object
> +	 * `id` field.
> +	 */
> +	kernel_ctx = QCOMTEE_GET_CLIENT_CTX(arg->id);
> +	/* User-space identifies a NULL object via a 32-bit TEE_OBJREF_NULL id, whereas
> +	 * the kernel uses as 64-bit object-id. Hence, we check for a NULL object by
> +	 * sign-extending the object-id to 64 bits. If user-space is indeed invoking a
> +	 * NULL object we must extend the object-id to 64-bits from here on so that
> +	 * QCOMTEE can recognize it.
> +	 */
> +	if (!kernel_ctx && ((s64)(s32)arg->id) == TEE_OBJREF_NULL)
> +		arg->id = TEE_OBJREF_NULL;

Does it need to be MSB -- why bit 63? the object ID supported by QTEE is 32-bit anyway.
Let's mask the upper 32-bit and do something like kernel_ctx = !!upper_32_bits(id).
What do you think?

> +
> +	/* If the object being invoked is not NULL, drop the MSB from the `id` field to
> +	 * obtain the actual object-id.
> +	 */
> +	if (arg->id != TEE_OBJREF_NULL)
> +		arg->id = QCOMTEE_SANITIZE_OBJ_ID(arg->id);
> +
>  	/* First, handle reserved operations: */
>  	if (arg->op == QCOMTEE_MSG_OBJECT_OP_RELEASE) {
>  		del_qtee_object(arg->id, ctxdata);
> @@ -411,7 +431,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  
>  	/* Otherwise, invoke a QTEE object: */
>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
> -		qcomtee_object_invoke_ctx_alloc(ctx);
> +		qcomtee_object_invoke_ctx_alloc(ctx, kernel_ctx);
>  	if (!oic)
>  		return -ENOMEM;
>  
> @@ -648,7 +668,7 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  	int result;
>  
>  	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
> -		qcomtee_object_invoke_ctx_alloc(ctx);
> +		qcomtee_object_invoke_ctx_alloc(ctx, true);
>  	if (!oic)
>  		return;
>  
> diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
> index f39bf63fd1c2..5d292a2ff83d 100644
> --- a/drivers/tee/qcomtee/qcomtee.h
> +++ b/drivers/tee/qcomtee/qcomtee.h
> @@ -17,6 +17,12 @@
>  #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
>  #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
>  
> +/* The MSB of the object_id field indicates whether the client is invoking the
> + * object from user context or kernel context.
> + */
> +#define QCOMTEE_GET_CLIENT_CTX(x) (((x) >> 63) & 1U)
> +#define QCOMTEE_SANITIZE_OBJ_ID(x) ((x) & (BIT(63) - 1))
> +
>  /**
>   * struct qcomtee - Main service struct.
>   * @teedev: client device.
> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
> index 8b4401ecad48..2528d07e4576 100644
> --- a/drivers/tee/qcomtee/qcomtee_object.h
> +++ b/drivers/tee/qcomtee/qcomtee_object.h
> @@ -146,6 +146,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
>   * struct qcomtee_object_invoke_ctx - QTEE context for object invocation.
>   * @ctx: TEE context for this invocation.
>   * @flags: flags for the invocation context.
> + * @kernel_ctx: flag that indicates this context is owned by a kernel client.
>   * @errno: error code for the invocation.
>   * @object: current object invoked in this callback context.
>   * @u: array of arguments for the current invocation (+1 for ending arg).
> @@ -158,6 +159,7 @@ static inline int qcomtee_args_len(struct qcomtee_arg *args)
>  struct qcomtee_object_invoke_ctx {
>  	struct tee_context *ctx;
>  	unsigned long flags;
> +	bool kernel_ctx;
>  	int errno;
>  
>  	struct qcomtee_object *object;
> @@ -172,13 +174,15 @@ struct qcomtee_object_invoke_ctx {
>  };
>  
>  static inline struct qcomtee_object_invoke_ctx *
> -qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx)
> +qcomtee_object_invoke_ctx_alloc(struct tee_context *ctx, bool kernel_ctx)
>  {
>  	struct qcomtee_object_invoke_ctx *oic;
>  
>  	oic = kzalloc_obj(*oic);
> -	if (oic)
> +	if (oic) {
>  		oic->ctx = ctx;
> +		oic->kernel_ctx = kernel_ctx;
> +	}
>  	return oic;
>  }
>  
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index ef9642d72672..7f986d7fb47f 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -706,6 +706,10 @@ static int tee_ioctl_object_invoke(struct tee_context *ctx,
>  			goto out;
>  	}
>  
> +	/* Userspace object-ids are restricted to 32-bits. */
> +	if (arg.id > U32_MAX)
> +		return -EINVAL;
> +

This change belongs to tee SS, move it to a separate commit with appropriate message.

>  	rc = ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
>  	if (rc)
>  		goto out;
> 

Regards,
Amir

