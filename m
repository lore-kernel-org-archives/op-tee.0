Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9E2FF885A
	for <op-tee@archiver.kernel.org>; Tue, 28 Apr 2026 19:37:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9553844A1D
	for <op-tee@archiver.kernel.org>; Tue, 28 Apr 2026 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777405071;
	bh=I0fcDD/ten0VWuouw58AC4kCjDBHjHx6WSSZlL48Ckk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=L1zzdMhHc/ki0zs/5iHsbdKUyIq+Bhz1p6nmJB0Svcv9aftdLi58p2IrXQjtfLgsn
	 oR4XAXVRingxr5g3BkkF7Xwf9qHCef+DDlj/nMH50NDOYn656Zl/ZeKfrsGspGw1Ey
	 1y7xT599dys/wtZoArdmPplbMBr7qpjsm1EpdSSABuu02IYv7bbcvF1NOrdMGcPSkr
	 5N/OWpta42kgFuxsiptKJWvNdWf8e5+bkDsmguBBoGKnKxsKoCAnCEtPPuwYbaW2Ma
	 lhg152je63KZWdXVhb9RaxKSqvAdcz+nGlZMajEF91Z7FhfOQC54Y+Zhw7lwh/zIw9
	 Q0uN8KPP40DMA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A62B543250
	for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 19:37:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O6hhO0Q1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FYb3CbZm;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SFsJuR3713186
	for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 19:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/v2MbDPTy9gk9OluevpeqWGn
	rf+zZgQf7rxJQUu5J4c=; b=O6hhO0Q1fGugTxYhCMSUUbDUN5t2Pdu/vKOlaThi
	H05CGGgHaQdwCuYOV3aP47RiijriQEj6C00oAGaMD+Fm7mDAtK1aQXGpI0PX9sWe
	kPdGM7eCACgtfV7xSphqQ+Ar+jTEq2fQMIL4tQe5rSsT8jeRo0eB3jvyilJ9qIOL
	AO4gllsWQN1CIqrPA421U9tED5JrR6lO3evdfyxNp3NOaBZSz6pn0EZMapUMptnI
	ukV9df2ig8AE28JNOW+I2an4sq7TnGa3FJ5K/Uq07rGAToyfFCw/VF2Kp3aI945B
	ZTBn7lq2+1SLRgpd9UiJ6hoFABuSnlSJYNjmA6jKVcsX1A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtxb51a1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 19:37:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso5664207b3a.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777405051; x=1778009851; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/v2MbDPTy9gk9OluevpeqWGnrf+zZgQf7rxJQUu5J4c=;
        b=FYb3CbZmLm/BGKRCvGx93BBjLvTksYlaoz3e+6pT/67J9aQpCdXB53c2Fv4sY2iMv4
         RZaeX4GW7iquKMZpANx6maJfdi+ClzPc3UmTtxC/pD5aK2ItCtNR5rPESbWiKxYwS2nK
         vFP7q3bDywUtLozM2FuxnVcbaxRv8z7GZy9jXjvJXRUVTK0eRTpEmOnoF4zBY1c3Q7b7
         OmQUF5Ppo38QhBimeC2Y796vonNBfotplH2e5LeZWBtXIiLzVMYNIROSBqaVfX4G9nji
         tPM91ORcZRZ1es+Dt77CYyyTX/1PTCGbqn2EF8bAOURrdPT2wEA9QNfY9xh6hzjkVgGo
         mTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405051; x=1778009851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v2MbDPTy9gk9OluevpeqWGnrf+zZgQf7rxJQUu5J4c=;
        b=VW2EacbIBuahurd0PP1k0ZapcQfkRoND/BbxSiFFObXQBNcZsgwX5ByxTbKyONZg89
         JIJ3aXVfruJrbXHHdSsnhOfSdjxBLoOhEyXwYznTbBjm8KtNJmVeWwyQlDD6vaJFWG8o
         IQAlKM6AsgMJ+27bhE4MUB2/DnHoeneUOgUAbplc3oV/BP4mG7v8YDX4WRWs0IHhtqSC
         mD6wFjVPnA68DRlQZLqJSrxlNs0ZgWCYZInD0j8CH4/5pkDe6i/sYf+Bb9mKzNwfifV4
         VnA63itQcmLpFHq8gv/PH4SX9izZfLdKR6+Lnuaia0E+iqc4PUf5LNr3N4i6byy/+ETZ
         oO+A==
X-Forwarded-Encrypted: i=1; AFNElJ9G6m4PDmHYJE58Lf/6HaiKGOQYkmSFJ/LNEUhR0OsbQHR3/SghJDTzL5yZ+SQkMQwib+xBfQ0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxhFjK/qgnE2e/TBFLdJi9PeaW6s1aF5WiBff3DXSlYq2CO8hjQ
	yyb5YuZYSE24mQaRAl1fk4teA4KRo/7+95ieGA5TlF0vWaunRqc/Gdwbe5j2IEmls/+m9R0c2Fv
	OmY1dUlqbHR+1z/eGnh49a1U4hAbDSf0ovWgutBDy1Y5/kHD/HtlQfUL6RzfjlZoBBIy7vDa+
X-Gm-Gg: AeBDietAe3eOsN8AI14A65RDCWsHki0YvHF/hWls9E4df193+MKUyBkbaNaYeruUtLM
	PKfWvDqeJzuVLSNHdDZX9oBOdX/KSG2vsavFlfVwsp5jrtlLo86Zw9iKZRK/8mauuJsXMZ1DUCp
	gW2bdO6aA50KVJ/xSX3R/JiVXUDin5jSA3A4FcLcHHY+Bvgh2Mx6WBsGvLweBCOpSeKxtJt5ojL
	cLaL/VV8xa3dm8YihBEwrXi/gO/QMyxRsNxBgTGjpEui8RyOkhHmOGO28XzIgu4tFyaXhVTkUvR
	/VCJzmvR8oDz47vn5aosIGXYn4z1KHcnmj9FsCU2rdLxvN5NySFm3BChlfaojyybH/V9TDNXEJH
	fOaR22zbP+tdlGPC6dQyGiAr8QVkmeegncWyg0o7TqhnMyREIMZ6kLJt3Cvg=
X-Received: by 2002:a05:6a00:a804:b0:82f:761:2b49 with SMTP id d2e1a72fcca58-834ea81252amr598140b3a.49.1777405050710;
        Tue, 28 Apr 2026 12:37:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:a804:b0:82f:761:2b49 with SMTP id d2e1a72fcca58-834ea81252amr598078b3a.49.1777405049990;
        Tue, 28 Apr 2026 12:37:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf35093sm3444849b3a.28.2026.04.28.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:37:29 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:07:14 +0530
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <20260428193714.sg5n3tntww2nuquu@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-12-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-12-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE5MSBTYWx0ZWRfX0suoGXuTQBfc
 NPBRmyxhKRI2SxWxUuFaTrL+IWg8n10JQZKkrlxMdSy9LpwbBwyLMoTuXlzS8XkKPpTWAc3g/kR
 Xu6bpyjBAuBiVEEZYCuqTnDH8X9i1ANdrHBxRFAd6gMoWzVAs5W9llrBWWmN2rLFRIDb4yu6oaX
 OwcZ30uwKit1MAc3+ar0iqh6O9g5C+Yg9qqIyiTu0gOkxVWSfoDKoRyr6PwKd7U1I/Bu0xuUzRO
 +qD2U8E6hjbiVVuVD0eJZa7fD62lnXAQJOEU1IEGWgJfv3KEjpdyVF9ZTY26mt/5mpnclVHlt7m
 ZQDA6TKF4hP44c+BzTkDtgFor/vhW+GbjyibaICw1yhg9q9WjlcYC2bdeJ8l/16TzIlr6qib7u8
 FGGIvuABLrgDyQcBK4y5zLpHktMAQml3egvQp85l0xqSPkqdizE1ydMdOez0rns+g0mrETkdO32
 24cLc2WmXBJ+2wliFHA==
X-Proofpoint-ORIG-GUID: wMQr1fqtG09xYq1WA0Ssmf6q6yhVxu_T
X-Proofpoint-GUID: wMQr1fqtG09xYq1WA0Ssmf6q6yhVxu_T
X-Authority-Analysis: v=2.4 cv=A45c+aWG c=1 sm=1 tr=0 ts=69f10c7b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=IA_ug8NyWMwr6sB50gwA:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280191
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A62B543250
X-Spamd-Bar: ----
Message-ID-Hash: Z3NON4SMK3LX34X4CYGL3U3XBDZKV4OX
X-Message-ID-Hash: Z3NON4SMK3LX34X4CYGL3U3XBDZKV4OX
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Z3NON4SMK3LX34X4CYGL3U3XBDZKV4OX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mukesh Ojha via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 03:25:59PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Along with that pass proper PAS ID to set_remote_state API. As per testing
> the SCM backend just ignores it while OP-TEE makes use of it to for proper
> book keeping purpose.

When we use 'Along with' or 'while at it', patch is doing two things and
not one.

> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
>  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
>  drivers/media/platform/qcom/venus/Kconfig     |  1 +
>  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
>  4 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
> index 3c803a05305a..f54b759c18aa 100644
> --- a/drivers/media/platform/qcom/iris/Kconfig
> +++ b/drivers/media/platform/qcom/iris/Kconfig
> @@ -1,13 +1,14 @@
>  config VIDEO_QCOM_IRIS
> -        tristate "Qualcomm iris V4L2 decoder driver"
> -        depends on VIDEO_DEV
> -        depends on ARCH_QCOM || COMPILE_TEST
> -        select V4L2_MEM2MEM_DEV
> -        select QCOM_MDT_LOADER if ARCH_QCOM
> -        select QCOM_SCM
> -        select VIDEOBUF2_DMA_CONTIG
> -        help
> -          This is a V4L2 driver for Qualcomm iris video accelerator
> -          hardware. It accelerates decoding operations on various
> -          Qualcomm SoCs.
> -          To compile this driver as a module choose m here.
> +	tristate "Qualcomm iris V4L2 decoder driver"
> +	depends on VIDEO_DEV
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select V4L2_MEM2MEM_DEV
> +	select QCOM_MDT_LOADER if ARCH_QCOM
> +	select QCOM_SCM
> +	select QCOM_PAS
> +	select VIDEOBUF2_DMA_CONTIG
> +	help
> +	  This is a V4L2 driver for Qualcomm iris video accelerator
> +	  hardware. It accelerates decoding operations on various
> +	  Qualcomm SoCs.
> +	  To compile this driver as a module choose m here.

Here, Space replaced by Tabs just for one line.., should be fine.


> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 5f408024e967..856fa6a79064 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/of_address.h>
>  #include <linux/of_reserved_mem.h>
> @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
>  		return -ENOMEM;
>  	}
>  
> -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
>  	if (ret)  {
>  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>  		return ret;
> @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
>  						     cp_config->cp_nonpixel_size);
>  		if (ret) {
>  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
>  			return ret;
>  		}
>  	}
> @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
>  
>  int iris_fw_unload(struct iris_core *core)
>  {
> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
>  }
>  
>  int iris_set_hw_state(struct iris_core *core, bool resume)
>  {
> -	return qcom_scm_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, core->irisi_platform_data->pas_id);


Should be a separate change for qcom_pas_set_remote_state()

>  }
> diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> index ffb731ecd48c..574172724e8f 100644
> --- a/drivers/media/platform/qcom/venus/Kconfig
> +++ b/drivers/media/platform/qcom/venus/Kconfig
> @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
>  	select OF_DYNAMIC if ARCH_QCOM
>  	select QCOM_MDT_LOADER if ARCH_QCOM
>  	select QCOM_SCM
> +	select QCOM_PAS
>  	select VIDEOBUF2_DMA_CONTIG
>  	select V4L2_MEM2MEM_DEV
>  	help
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 1de7436713ed..3c0727ea137d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	int ret;
>  
>  	if (core->use_tz) {
> -		ret = qcom_scm_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);

This too..

>  		if (resume && ret == -EINVAL)
>  			ret = 0;
>  		return ret;
> @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> -	    (core->use_tz && !qcom_scm_is_available()))
> +	    (core->use_tz && !qcom_pas_is_available()))
>  		return -EPROBE_DEFER;
>  
>  	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
>  	core->fw.mem_phys = mem_phys;
>  
>  	if (core->use_tz)
> -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
>  	else
>  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>  
> @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
>  						     res->cp_nonpixel_start,
>  						     res->cp_nonpixel_size);
>  		if (ret) {
> -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +			qcom_pas_shutdown(VENUS_PAS_ID);
>  			dev_err(dev, "set virtual address ranges fail (%d)\n",
>  				ret);
>  			return ret;
> @@ -274,7 +275,7 @@ int venus_shutdown(struct venus_core *core)
>  	int ret;
>  
>  	if (core->use_tz)
> -		ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +		ret = qcom_pas_shutdown(VENUS_PAS_ID);
>  	else
>  		ret = venus_shutdown_no_tz(core);
>  
> -- 
> 2.51.0

with above change

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> 

-- 
-Mukesh Ojha
