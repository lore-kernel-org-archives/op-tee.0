Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386E606A31E
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=5V4aGBOq;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUd1zGgg;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=apAweXcL
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D958344E4A
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 03:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792984184;
	bh=f8Tzt2MwelBkuBugBCAiJnLbBVF7NvMOyRFfXVFfssk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=5V4aGBOqhuciTeOPhHonvHAmznRWQfstQ9NUUYU+bOXHNmQ6qMRZHOQcmfM47VyRD
	 CF16MHyOIpUWZ9KeIneplmYHRGnX7V9awJ7JQLbrfPeTktE4xFciRm4srldqSyP6kI
	 Vd60SgJihbF8AEb+PXrTCm+yMPKGVMhq1U6ntd9iSjbQon+FIuxZzTNAk7B9j+3bfh
	 DgxhDI/URmocJT6xKJR60xgdQ/rxSyiTKMRiTziXoD9fSGj5yAf54ShLjFnkgFi6YQ
	 AWZMrBL8tfFkj2XVxENyq3Dl3JuL+AEll5III5sfXF94rCAONVVCxKniMm6lycAuX/
	 Zv6byuCSDGT8Q==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AA1C044E4A
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 03:09:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUd1zGgg;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=apAweXcL;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2KbvF3015638
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 03:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SgSpBWnPBxyf15iYq1+d2gywSzNfOx3Fmff4tI5lniU=; b=dUd1zGgg+y2P+cVB
	gG1F4r1mjwo9Z6GZlYm3hJMhlMpWmTJt+LGqYoG2vNkupDFwNnA7E2ZgWgAz5tHR
	EGeapD4PAacE2uwyvEKVQESQ46Y9IunUoMyNAE6T/bEAygCOOEjEDhMIOPgs+9n5
	u+ONQW26qA1Hn/GlWr6shMAqij/i4Xncsvqy7nY7o6WSschcfviHLbiVTNovp5qJ
	0uehcsSU27OD5qdpG0mmkmreHJVtlZSFlltTKRyoGrgrcH2beBwGAWel6zt1wgPd
	+pDJEvmJEZ4US1JA6NweMBUJzr8o0J+QXYdWwfTcDpPvJ9EA++u+VQrs7UKB+K32
	rCSFkw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmscmka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 03:09:23 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a05bfa6af5so1787538b3a.2
        for <op-tee@lists.trustedfirmware.org>; Sun, 25 Oct 2026 20:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792984162; x=1793588962; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SgSpBWnPBxyf15iYq1+d2gywSzNfOx3Fmff4tI5lniU=;
        b=apAweXcLSRcwt4Czr79Xr60zYzTIXur6GoDv0RghG1m3Ut+qoL8PBS01yj8f66W7vM
         8UfIO7WDqPHZdI/YWo7NXj+sQPoWCAx3ejZONdQr8/l8+YaJ7fFkBt8LYcGkGkiQsZpO
         oyBnHgdY5GTfavpcFcCb3oNu+dI39yGcrTwCgQIbLUtD85T4jYtH7LDLjW4FZwWQiX7Z
         tUQszqGuU8kRZsMUfGlWinUq5Lol0W2AXzP62mwORazdjHty80IP2//NzZ8vKp2upkbc
         /tcY3RYJtwydGEdYd+c2jDHzLeCVAfI5sQOb5JtAKVNcDfZVXUaHLhQvfjubdpRIrzob
         9r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984162; x=1793588962;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgSpBWnPBxyf15iYq1+d2gywSzNfOx3Fmff4tI5lniU=;
        b=uhpoKaoKVNOkDUK81iqiPRY2DXSJxmChqcosqPKhE4+VgT3ujZNmxdT/KlvZ2QTrI0
         pg2ZDWcA3G6yCHAB3gOuEiqhRI5aBDkZjjf3UNuEipVKUZw4Lke2p2BLAly/Udfvz6Wl
         oRjP5hPsL3PmtyHyFS/jJLfZrlqR1xOnSch2CcnPzFbvakkTozzRWgLDIPtSmOEKJI57
         IMN+7WUbaoe/jfxpQ0WmIT3Bxw2LAYjA9PikTHbcne2RjIM9B9hhlYT6u28ztch9Lt++
         bbi+Af8Bcdii6E98p5UJ5JsTpCKB8pCon2WXPY4PhkJ3o31u49HdysGUftimFxDiG4ZT
         yW9g==
X-Forwarded-Encrypted: i=1; AKwUvBy/9hGJ9UOR3tu22wNQ3YH3Ge033BBvNa9/X0pu8GndXckyUnUsWQLwYaJqtrqoD3+AtCX36sM=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJdT1ZC65m0iLIue62n1OA+osBQkhRTNtchrezL5MFdTKGPbJqO
	LmsMWtlvmV/9vwS+M+GkLL6112nXX1mGnUEGkzxW562wgqy0BvMIjCOVszjKhiA5FZmp5T3WIed
	hUuopY5GwL+ssiXLPJ9LFxu+wGXSiIlMNY+f3JPygrDllr2fjAYj82kgX4oRZioICOsrdT/M=
X-Gm-Gg: AYBFou2G92w25n2DK5DQPSZLktPSzslmNRel8l9jtRJgIaXIygJbVx7wFjZtXRtQ20o
	b5Yfq5Uox+RKUxWna/H/rD0K+t/G1LWK5qe20iNnY8wnsgB/E0CzgzZSdKCLUWKNcKdzfGVfLzb
	YZf+zA/wx/F3Hxdlspy6es2Wzv1KgxHYPjmB0BDBN4GekRRXJZkgCco7niS2LwFQqi6A7aTC8cf
	Hgm7soOGpQfGqy/9wY3dW0lIQQVGg4446p1Hj4OQPzbDVGpph9sRs5NwwU7JTvIhwgBRBmbKT0t
	WGlhqlBR2E1dJDt8AZ32UJdvzKJxGh/qUI7q9L8ZssUP1X3WNkW+eE4djflEA7CX8c7Qh06q1LX
	4ferMEFq30UunNTsO5oNGGn3HvXH0YO0X
X-Received: by 2002:a05:6a00:a387:b0:890:bd5c:5710 with SMTP id d2e1a72fcca58-8a369072ee8mr4274276b3a.41.1792984162614;
        Sun, 25 Oct 2026 20:09:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:a387:b0:890:bd5c:5710 with SMTP id d2e1a72fcca58-8a369072ee8mr4274250b3a.41.1792984162140;
        Sun, 25 Oct 2026 20:09:22 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.119.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a368d867adsm810745b3a.5.2026.10.25.20.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 20:09:21 -0700 (PDT)
Message-ID: <5d260732-c586-42b6-b7a1-e8eca9c41229@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 14:09:16 +1100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] tee: Add kernel client object invoke helper
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-2-1460691b35d3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-2-1460691b35d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: b5WoLJjDwPwsT_H5lVfvcKnYCgeZONbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAxMiBTYWx0ZWRfXxEyCXhlzDuBN
 ScE8lXagpH9jGsusDBBJBDl28yK6/q5OtY5jm/aA92PvqeMAJGjhxpH1hrJkoZnhBmwR36nxcpy
 aoKu1dBRfyUwLg5O/4eD8sVyRizoydG/Tb0M/ykhWEiM3EP9i5IFix9AE+dYBQqhtZ7ZpI3B8yV
 1Ku3+7H9tIkSAketTNGoL9IZqP1rJdeGenVZUCtF/06dUBOqQAqYz41Q8ia1IxgQf8IuU23mmWl
 Kj+61liMm/WygEifpIHTculLXvuMla1YuPziIqNx2AUNZDwNgUHQhi7supcl2RKGXQs2rt6acYS
 DZ8ZrJiLq+9FxwECDLdH94v3I3+aZ9e+/sap1g8FD4f77OCrkG/iyu1dPRzv2rcLFfnGevH1Z25
 B/hJLUlhIhdrEM/ux0g0zaj8HVfKGzdGG4eoghntaG3TJxOByEXB+kTlaGHVRoZekv99+GpWvnG
 SJRuo5HSHMU+g7oTHbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAxMiBTYWx0ZWRfX+Z762GaGmvsN
 az8oWOw3sEAmHVJeHS7PoDFmz+A4cTlNV+TkYoxBrU9xQbsgRxgqosGAvWkrwi+eS6wT9LinyX2
 7a+L/AVooMDnzvc7eWcF/zTfDTOFneA=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adec463 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=pnHLkUe0LhHGSDu6DPowAg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Vsz39dQLEg-ztEiNogYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: b5WoLJjDwPwsT_H5lVfvcKnYCgeZONbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AA1C044E4A
X-Spamd-Bar: ------
Message-ID-Hash: EW24KFGVMVYM7H5UTGKIVNGUJ4L3KCMT
X-Message-ID-Hash: EW24KFGVMVYM7H5UTGKIVNGUJ4L3KCMT
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EW24KFGVMVYM7H5UTGKIVNGUJ4L3KCMT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Harshal,

On 10/15/2026 10:39 PM, Harshal Dev wrote:
> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> Kernel clients can open a TEE context and invoke regular TA commands
> through tee_client_invoke_func(). However, there is currently no
> equivalent helper for invoking TEE objects.
> 
> Add tee_client_object_invoke_func() as a kernel client API for issuing
> object invocation requests. The helper checks that the backend provides
> object_invoke_func() before forwarding the request by setting the origin
> as TEE_OBJECT_INVOKE_KERNEL. This allows TEE backends to support
> privileged object-based calls from the kernel-space.
> 
> Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

I did not notice this patch has my signed-off tag already.
You can drop my Reviewed-by tag.

- Amir

> ---
>  drivers/tee/tee_core.c  | 12 ++++++++++++
>  include/linux/tee_drv.h | 13 +++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 30901390149c..a03a3d645dd1 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1404,6 +1404,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  }
>  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>  
> +int tee_client_object_invoke_func(struct tee_context *ctx,
> +				  struct tee_ioctl_object_invoke_arg *arg,
> +				  struct tee_param *param)
> +{
> +	if (!ctx->teedev->desc->ops->object_invoke_func)
> +		return -EINVAL;
> +
> +	return ctx->teedev->desc->ops->object_invoke_func(ctx, arg, param,
> +							  TEE_OBJECT_INVOKE_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_object_invoke_func);
> +
>  int tee_client_cancel_req(struct tee_context *ctx,
>  			  struct tee_ioctl_cancel_arg *arg)
>  {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index f3c5e106d853..369c87ad0205 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -283,6 +283,19 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  			   struct tee_ioctl_invoke_arg *arg,
>  			   struct tee_param *param);
>  
> +/**
> + * tee_client_object_invoke_func() - Invoke a TEE object from kernel space
> + * @ctx:    TEE Context
> + * @arg:    Invoke arguments, see description of
> + *          struct tee_ioctl_object_invoke_arg
> + * @param:  Parameters for the object invocation
> + *
> + * Return: On success, returns 0; on failure, returns < 0.
> + */
> +int tee_client_object_invoke_func(struct tee_context *ctx,
> +				  struct tee_ioctl_object_invoke_arg *arg,
> +				  struct tee_param *param);
> +
>  /**
>   * tee_client_cancel_req() - Request cancellation of the previous open-session
>   * or invoke-command operations in a Trusted Application
> 

