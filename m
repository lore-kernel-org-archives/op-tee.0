Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4471EFF8873
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 14:25:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 507BA43AD6
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777472753;
	bh=5yQPAUjn3VunEoidQeZB/XrTAnrzeavxXWZHanAVIvc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ll0MkzeFpYfsWd6Fj85FUjUP2tcIzETQ/i8wwVKp56y/3JTI2lkTYZSyrZeFGDDeN
	 M0BRYSmhApyE/pToy0ExnDfYLWWALRz2WKlwSag6ggGjv8gRlnvAnkO1SP417/3vIz
	 3B42ijzhNvPsVFL4aO5zwI3eQybMUPgDkUBDd/h1RqSX3SMz79XCPPTPlWJZdR3Rm+
	 oD/tVZs5r/UGwL9dtetbxDVFTqDckdyAp61OYRBPVhPqg2/jcnHJnNFbFvhRVfRrcm
	 Fs3cH6NguLAKQB3BGgfphUGhqt2GW/3ksyCXwy/zWy+bk6O12aYqszXWj4iE32L3hj
	 rKwJKKgGuJEog==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4BF62443F2
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 14:00:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZVjkz/bw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kWYr+Vp6;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TCefxr317335
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 14:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YKH9dv7wKtC1p8ZEO04m+kEL
	X8b+zwv/sQpT8PdfGig=; b=ZVjkz/bwitIknIzBQGGYWMnjd+c7U3oo1VDD3ojE
	amdiGSdp8vi58LpqyydYMnBfvL8uamZ8WIYrelSlx2yLPdTEBOa2u20SKht8H31S
	rCBw4E8wCS+ccd6xz/bLRB8HZ3sjjR/CxRL9FhkuuOOdnvzRrymGZEyukKJ/adAg
	VXFsgNc/BcJCVi9QDz5cbpgzNVQMrf9kHGqjuSMKWUA68mslDXOcT1Scn3oUrQ0N
	VnucAWp6lTQ0s2WEiNpo1fwxuo1B4dYbqmecD2AHb2BbvD0DiQg309g1Nz6CblUF
	emwubpt8x6BGtRXRW72mh8KyG5jTGgq91yiJJSyh+Yx8gQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duj6t88s8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 14:00:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so6471450b3a.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471211; x=1778076011; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKH9dv7wKtC1p8ZEO04m+kELX8b+zwv/sQpT8PdfGig=;
        b=kWYr+Vp6WLVb4Be01RwB85cpzfN7am4T3Nb0pE2c4EOTEOpEEjpV4ZnadCJ/Rv3jka
         tewgPxdP0oy2+0d/r6kdDPwMXZt0tbTnE66Qu1txJ5cna7GiPNICSsF9VThI/La1oygt
         XgtOBIl9IH0mJxLKREGOimpaSZZGJKgUvsmDKXXbHwBKA8P/UGn38RnbUzl1nNCFcjNF
         gi/dUmZEecJ2yKIwnm37musc+ITh1LUDtqezCIf7gpdQxgcYIq+iWzfFp8gtGsNFV1h4
         zSpUcMAHWM6paBDNxQ7FYuFDaNxU/W8HQWzQy2JmdSSEj7PJIC9/maDfNVASi1SnzTs4
         7fzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471211; x=1778076011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKH9dv7wKtC1p8ZEO04m+kELX8b+zwv/sQpT8PdfGig=;
        b=rbJzcy54C2nF6ZTkSrE5aJxXLKR0ilaegW0no66iwMJgkN7SX8z4L2y7+fV0CfMb9U
         sRnkMjBZiKkjLjFAS77cO7D7nS268V9vuDqULHb/SealILn96HZzQGcqOMZI/pIzZlwE
         nrsMfsOQgITls9DEV5whUUW0FDuA1sdL5bn4NPREDeKG+3nfWHeRArziztUNlta+KmiM
         HmzxJrrmVGXHAUdMtnlZ5kQaTR8bTQZEs0ongs06YxKPsG3kpxfXatdipYhrtf+cq0Hn
         +ttGcwI5/wNXfoVwFGI+nInsNSyjpVO78zM6Tr1ctFFB04YeOJXVh39kgphBs0kQoekG
         vIKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8l0MYRymaRWq0Bk5ghleq9qJ9LpDdtCxihbYiHw5IiLF/0vxMWLOBvonTra/k9boAsMkoKNe0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyd3BgD+mvkEVQMwEup9XMP7xTezvlr7bV6mIV4SbNElWko8Xm9
	uL41VnLu6dydu873uZIWCOaDMREbN4fqu0XRfD5xGkMauXr8kOKSHoShsbUrJhh8l+xRap35WWI
	hOr5uqFG1jUaQ+r5g2fOf0YS2cQWnJW4PlMY4TKFI/ApYb1T3Qjojm0YuAOXpGXmWhLlws03z
X-Gm-Gg: AeBDiesT728Zj1zH5rhrFhCmgCauP2cKmDt62NKElLSwlxzXZhK+rHbpqAXQZVn3rke
	a6VkkiUGXWj7nKIxesfKVLEZbQEnkS29u/SOOEyhJ1pHCdSXw1ZEQGbetv1rkflJ6O49+5surHH
	s1gbZsyUlfCvewqy0bdD8bBNsbNwmPONd5aZwCsJCP8sZesANYUGCAQZ2knEGzOwPrnX9PrubEO
	is6tBZcx/mNHV5WOwORB6E7icm5lBWMITvEP1iF47c8R+d52iGJ6mpMXuLFYgPGrT+95K7ogJpM
	AK1XKR0GQ65m4VA2YfDmdhDfYzx5ytZivASWpUiUePCT0pUUUODBJu0qt65DnbNNIssmfeb1WyX
	fZtAnVYLh2KrJ7z5c9QYLn9Y1FibKrULFJZQAVDzzYXNObBmRYyRvLxBeG9c=
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id d2e1a72fcca58-834ddbf1ebamr8578670b3a.29.1777471211025;
        Wed, 29 Apr 2026 07:00:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id d2e1a72fcca58-834ddbf1ebamr8578551b3a.29.1777471210136;
        Wed, 29 Apr 2026 07:00:10 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80ec94sm2268304b3a.52.2026.04.29.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:00:09 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:29:54 +0530
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 10/15] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <20260429135954.nvr6nyfadsjeymyt@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-11-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-11-sumit.garg@kernel.org>
X-Proofpoint-GUID: hNknoMHNQGh-c9p06lTVLP4t8rTzRAlj
X-Authority-Analysis: v=2.4 cv=KcHidwYD c=1 sm=1 tr=0 ts=69f20eec cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=DQeyY4SaC-8ekjbwpG4A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: hNknoMHNQGh-c9p06lTVLP4t8rTzRAlj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MSBTYWx0ZWRfX8fSzeMRku/Je
 oKoJacNO1dEPEz6F2XxkVTJL5QFNrYM5zoVIGzEA439psMzRdC+zCOqmCBOJvN+vAys3dvNvAPy
 UR8eh7S/7G3ddgFcxKLxsc8ZdAaDKWWjndOEY9Jx8b4MORWp+Pz/gNP6stkKtDBI/R4LfDj70VW
 2TsSB6/y4WFcuosrG7M4IXwre8WEsvvR2QitH++aOv8BpKBazoBo+1Qs7rciXDb4IB5KuNvcOHj
 bOUgNqDTnJmirCaKFcjA3gaZzWFMDw+yuFZigymvTpEVbnNQTiDkSnd2OZRX2T/z1q3MOsX0ZEY
 ZlxwF7WwohaLJPBdh4hVsHhemoif32mDou0kar/IZalxsedb7Om4pb7WCLHaD0HdJOfDjMW6NhA
 pg62d4YXiUHL2OuE0BENcKGZeLTTeX5hhd88oIp16LXJsASiz+VB0GDqhnxiVwFFPH4DGMvw19w
 zQlYuiWC3IzCMbziBwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290141
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.210.197:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[50];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4BF62443F2
X-Spamd-Bar: ----
Message-ID-Hash: KSATGFIMV6PSFPFLTZMF7I2AVOMDDH3S
X-Message-ID-Hash: KSATGFIMV6PSFPFLTZMF7I2AVOMDDH3S
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KSATGFIMV6PSFPFLTZMF7I2AVOMDDH3S/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mukesh Ojha via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 03:25:58PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gdrivers/gpu/drm/msm/Kconfigpu/drm/msm/Kconfig
> index 250246f81ea9..09469d56513b 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -21,6 +21,7 @@ config DRM_MSM
>  	select SHMEM
>  	select TMPFS
>  	select QCOM_SCM

do we need this ?

> +	select QCOM_PAS
>  	select QCOM_UBWC_CONFIG
>  	select WANT_DEV_COREDUMP
>  	select SND_SOC_HDMI_CODEC if SND_SOC
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 79acae11154a..b556da823897 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -5,7 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/pm_opp.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/slab.h>
> @@ -653,7 +653,7 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
>  	if (adreno_is_a506(adreno_gpu))
>  		return 0;
>  
> -	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
> +	ret = qcom_pas_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
>  	if (ret)
>  		DRM_ERROR("%s: zap-shader resume failed: %d\n",
>  			gpu->name, ret);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 66f80f2d12f9..6d68edf0578c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/ascii85.h>
>  #include <linux/interconnect.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

do we need this ?

>  #include <linux/kernel.h>
>  #include <linux/of_reserved_mem.h>
> @@ -146,10 +147,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  		goto out;
>  
>  	/* Send the image to the secure world */
> -	ret = qcom_scm_pas_auth_and_reset(pasid);
> +	ret = qcom_pas_auth_and_reset(pasid);
>  
>  	/*
> -	 * If the scm call returns -EOPNOTSUPP we assume that this target
> +	 * If the pas call returns -EOPNOTSUPP we assume that this target
>  	 * doesn't need/support the zap shader so quietly fail
>  	 */
>  	if (ret == -EOPNOTSUPP)
> @@ -175,9 +176,9 @@ int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
>  	if (!zap_available)
>  		return -ENODEV;
>  
> -	/* We need SCM to be able to load the firmware */
> -	if (!qcom_scm_is_available()) {
> -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");
>  		return -EPROBE_DEFER;
>  	}
>  
> -- 
> 2.51.0
> 

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> 

-- 
-Mukesh Ojha
