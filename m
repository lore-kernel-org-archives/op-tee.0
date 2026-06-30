Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B94C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:39:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 05CB544FB3
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782823164;
	bh=FxpES4QjZ5UOZ0ZDankh5pA1Tqn7LCiS68nn+rCzouA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=48Beh8XEASbbl7oU2GFtDYWYlnGQQWIlJd8pD4e26rBXOWi23sdbPOZupM2MM8xt2
	 XHUzmGjenwmNl2fCB7Ys4spLp0v6PLc352CwrOaUdQ5C36UQ3NzKIvXtYU37k4t9Tv
	 sQtv6NZYO5XyV36NSnsFxKntSNz206dA/lofFuYE64IbAKZE8iG1PBQDT3GekBqfoZ
	 KzTr4sKzeBt0rnAqZi8Fx+Lc/j1Kif14QAMHBbjij1HaG0JVunnF4uBrqe4OB4anaJ
	 lBRD0em7n1mli7NqF0R80esoI3+d/xj4lHNNYfD3I7+Of0gQz9SCQTH6ps2wRCGPDS
	 q9ZCtDY820Kaw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 496F444AFF
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:39:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AhXU0K1N;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iPs3WsQV;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nDcR1590654
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j+0Tx25hFjaHzRNkLyNtbTDFfSp/eulHhiy7NQz4/zY=; b=AhXU0K1Nf3o7hIe+
	5inixK4SQz3a7GOF0doOZ3d6lGTX1peoFk/Aw/reVBsilnEOhcwnvUjGsNKN6LVW
	9/lg2AKYC/dxUOAWlYYde2OXi/nx8t2gZTtwdSPUjxTdf1ss+aoz1+zTdS9KFAVl
	15opLDPFxXbGqx5SoxixFqiXBaDN9ybNSUZRGvAhhYGwA1A6bnDz3ZIaH87H52s+
	iRBjEBUyl4nR5vfV1EvLwnokHifuTBtoeCohE+9HHBHXRBfy/KlvGBbUUkv2co+h
	madwEOSh2PZidgsAnJFI3cjXgtH9DhRdrOUy2IDykIFTaePdIf21edNObcStvN3E
	mAYgmA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k3j7t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:39:16 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bd88c79dccso120873e0c.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823156; x=1783427956; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+0Tx25hFjaHzRNkLyNtbTDFfSp/eulHhiy7NQz4/zY=;
        b=iPs3WsQVB9Lv1tc5C2JWNkcS0vKXmMnF2hFBAa/BpCCYhgk5gZZenGmykIGs+GD4s8
         W+p0jV7b8CUgBZCMDRInTfZehTrDaGJo2V0VDxVuXh0ilDORPzK1kBRFZLDdC1YYl6jY
         kDUK/eWUBx4ziPxttwl/Qo1oFi+MUC/quZwk9ijN/lV+IR2U0YoMhxxi6a8ptFa0HHjT
         v09qaKqvzo7oZsx2EZA6BAqWKKuXNjhxHSV5H1iUc6YL9V7f9goWNdnFpUklP5DaPkxI
         Z+/OTpqsV2NnoQY7uYi9JyDKNJfbvudg0aOi2x0d/pZCyQlQSGnCYFz90vGkCDfDGZPM
         Gsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823156; x=1783427956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j+0Tx25hFjaHzRNkLyNtbTDFfSp/eulHhiy7NQz4/zY=;
        b=QCerSPdl8y4jd/tjKMFENGNHbExeLjPpgcR/az9YZx9qONConPucAhCuj3+Mt+3B0u
         5PToSHcDMWiNP/jH2vhVlzqFWGTYhxniybgnjMalfbccemFrDEiDy5+84SCVDTYQrLvQ
         EQa9pI6Pio3zzcyscwUGTw6eDy+G2dOZ37cg1EmKu5zy80+svgf5KzEdbgMuslV47aDn
         hqQSXm+WsuNB3wwaIc4IV3wwkf7EGN/kPK9AWW00yV7clwr1zZXC5TuUAw1gxcFMh6zv
         mjz9rGvpuvUMRXRh70JhhhK8CwjidHUSZZoj+STACc0M/iSlVkDkrCkFhDsP5KKJtfEd
         ZSuw==
X-Forwarded-Encrypted: i=1; AHgh+RrYTVsexpx6j2jGwfO9CfZz+SCMHOv1UItjOp4Uj1ScNQN2JticMSuDN76KZ6hz+3yoqgBXzBw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy37gc22H4EOdPvF5gaMZayzLSCQ5AzoTEVtTzR3bNUxPF7ca2D
	DqggfGp5Gt7C2pOe4YHvPLUaHC3+SaiPunsKh/Qz5XMIpRlelfb52YrxCZ624OOPUElADtlT7bx
	Eit60vB51FPsTKBohjWTkf191DLYWUZsa5GtGlr/CXlD/Bs73i0tK6Bt/lS34syasLRBgG3ja
X-Gm-Gg: AfdE7cl2WW7mXjKIwZJJogdk5ViPXh3GVvJBX5hv9RunTQBsBinNl69im0+Bh3pOBEM
	SDSFhyGBWjchs1S1HpFRTuhHYpoy4EtL73udS0h81TZlsgCf4fCWRctJl1d8nM8ZdcqCs4nv2eb
	fFFFDec9UyYWes9C+Og8DHPNBs1msvhGZLeZ1m6nmOX/NmcRQdS4h6M50QvDtMiBNucRRRKkGq9
	S+H734folq7pFHNUopGh8lSLKzIXyJGeJ/eVIdKLLMzpCj+aLtV7DsxEhE71kyXPrUv5cVwAsFV
	wDBeyiagVP6QwSLymxtMiEtXLaOo43T1AuqegpeA5jlYs12lRWZjA10/1bLi1Xf2HxIr/QFJE4W
	mNst7vbFFGHjC+xaGiOc9i5R9FIY9n5MC4lk=
X-Received: by 2002:a05:6102:6886:b0:631:b312:a2a6 with SMTP id ada2fe7eead31-73a333ba5c0mr489597137.0.1782823155799;
        Tue, 30 Jun 2026 05:39:15 -0700 (PDT)
X-Received: by 2002:a05:6102:6886:b0:631:b312:a2a6 with SMTP id ada2fe7eead31-73a333ba5c0mr489583137.0.1782823155407;
        Tue, 30 Jun 2026 05:39:15 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3a3bc5sm1155708a12.5.2026.06.30.05.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:39:14 -0700 (PDT)
Message-ID: <f849f648-6891-4e51-89e6-dc803d07ee16@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/14] drm/msm: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-9-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-9-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXwGp5idUZCoLs
 TBWi+cgmvHvdb1h66uJSpAzSZs/gPDnYRNFUb/Bj5NoSyaaLSr24qMYzTRx/rhRSwX+ye+lxSE3
 YNo58tPDvYF0jnaF9JhG3XVQXFKblLU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX22hbkkhUOX8t
 4hsYt3ycnowv5hKBHpnBavUBe2WpRkR5NNOWCvFsy9X/bU6CzRyyrBbPsEfzR5sm6mRh+445Coa
 pXPvI4towEm41J1ZOA0C0mrvLMNCNPM83SkE+GW2q4xtNVZd6Q+ZaLVzB7ghso97KAwL2u3sb7S
 HxR5njRkbNkkjZ6H+FbtUeQVl4UCoGZF6uj4aHDHm+3Oew54u+J1rP/R+HEuYceidgJt2z222Fv
 zUjvEGBzS41q7lnY6NkizJYmKjY7/asyG+bCPTabWJYR2RREoaKWdfxXFTAaIED0pqMiOQ17KEN
 FZ33Ob3glk8vwAlCOsGkrBzu1xEe82m7zP/gEiNq6TDSwTkw8L4dJT1bLLeJziiZi22EEfU1vv4
 +tK3WLeRwkSCA4/JShizTPOHoZYG+bTzgcnlSLDTukinDLwpKTM2JynzLWIFaZTTZW0H9HF1zTj
 EqpS3rpxkryKCx+6hAg==
X-Proofpoint-ORIG-GUID: 7VB4HF654MuRCiMLJFT0DiyM_s8NheHJ
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a43b8f4 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=E6O5LMYzsyQa2pg2XTQA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: 7VB4HF654MuRCiMLJFT0DiyM_s8NheHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[178.235.128.140:received,205.220.180.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.200:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 496F444AFF
X-Spamd-Bar: ---
Message-ID-Hash: K7UKJ5BJOLW2YXJKR3X3WO746HNZ5RSM
X-Message-ID-Hash: K7UKJ5BJOLW2YXJKR3X3WO746HNZ5RSM
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/K7UKJ5BJOLW2YXJKR3X3WO746HNZ5RSM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 250246f81ea9..09469d56513b 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -21,6 +21,7 @@ config DRM_MSM
>  	select SHMEM
>  	select TMPFS
>  	select QCOM_SCM
> +	select QCOM_PAS

NOP change

[...]

> -	/* We need SCM to be able to load the firmware */
> -	if (!qcom_scm_is_available()) {
> -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");

Just "PAS", drop the "Qcom"

Konrad
