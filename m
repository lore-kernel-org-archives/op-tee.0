Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F87AFF8867
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 13:43:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9054444405
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777470228;
	bh=8MlgmCf4zwoh87Y1YqLlhl00eWh9D+mSMPCZDrhBsPA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=bKCyrgIIiat1tabX/de8ux6P4zEcgQ4q0fRRtBL8B0KY7CIqCfQIVjCF9KHlWZ0gk
	 1ACCInOL7354xDDTFwyiLzBuwhy8+oOMJv2jYuym3FK3DygQNHazCtXsGSVsii1pfd
	 EUlquwRFdkRJvBeTNIsRXvR8pdaEGqEBTbk3STVDIz6mmFx8RO/5VRCNJU7vC151yE
	 cGfIPHwG1P3HWpSZOpaDmUjoG02hu07eBaN9XF3UnUkS0kFu+l0Gr6rS9+1rt3dCdk
	 grrSojtlo6IBVkObn3vhJt0nvErrNEtP2pKuDIibPPFLkyHbn02hHCPvS+F4AZkTzE
	 LXaO75DxI9xVA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2EEDD43AD6
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:32:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b4ShSk6m;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bf6MDb++;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8ptjI1728612
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zlXmXqOMWysl75wyJsPWf9ub
	9kxU1RPWgNiLMjMjO54=; b=b4ShSk6mKXAOrKXOdRb8rgeM9x0E3AOsUVpGffLX
	YHTR3NG/VHJbPyYcC95HQFsUhNe0VmjCUK0JBtUkd5xLFcFUvZngpyRLOUulQDSn
	nhS0ymk5Q/TAqTVAiCkTu/K2KoGMmZd4ITeT38pEf4r1FLCOVVHy8E6SudEJgvCz
	sI9DUmIPcJBOLQH36FG8SrtbCgHiNJttNS8RBr4nrKjz79AgT6VAzVj2EmgqUN5c
	AYY8mOcO8yx/QLoMEJWhB7hiq7WTX1D0YnsBoA1Ov1EpE1a3KvY9F8ZZNhTwA9ez
	4ag4G9vhGXxwOxTZimD4kr4NPA+7utKXEk+8SArbJOKdPQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4due5ks73d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:32:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b461b36990so135948635ad.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777469537; x=1778074337; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlXmXqOMWysl75wyJsPWf9ub9kxU1RPWgNiLMjMjO54=;
        b=bf6MDb++w4kXUWXqVxQlBlEsiQv0WGGtTfq1XpBas7BEJT3cV1zzUR/PoqB72+VNBh
         /Pi14AURnriu8wDG2XCQYfLAfKjQ+nAuY8G7o+M5NY2WsdTA7/LngvPK+OGUveb2fob8
         4FAJX1erGD1QDB03kDT59xLo73GRyPejzxwbjo9SWmodnYHxBGTBefdQxblIUW01nLr7
         jIVknfbiXDtyPHWO7DgpcEsgjAsFf/d41fL9dBBlFrlnjLJ5OX/RFoG7BuF8iI3og5MU
         CpgWl+sNgclkRPQm+5HR6yu1hg+kNJ6oZWK5/N7o2cyeD/+8MBjRScY/TduSSo3abJGJ
         eGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469537; x=1778074337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlXmXqOMWysl75wyJsPWf9ub9kxU1RPWgNiLMjMjO54=;
        b=IOIPGoi4bY2yaUiN3xlpgb9zh7YpzJad7i+D2H1dDwIe1n6jECEscOgctH4BkJwv00
         fKK3DYjJj5V9fMaP0KYR2Wlt7ElwH77zfeASaaJqE57KqJp6s8H7CyzExN0ikR/1k6Lt
         4ab+AWWoIg6jXPp5EKUPEVdTpL3hpCUJziybH3j05kh8+1holyiE8JmIvSJaighxe9vw
         Y1ArMcFIgGaEVlBT3Unv8LW8oB31mk0rPnOq4+1GBSOFibuaiTwMHrIPJUk9YrTHBbGt
         0jdBAAdmYSaGHc8bxh5LKaOYucY8jVWGU+uQgz1X+jwYve1XT2huW6r+u4HQGmb4WJS1
         /S6w==
X-Forwarded-Encrypted: i=1; AFNElJ97Ve/RPMWN1uaOnjeP2RPt+OahgotJJN0MYMAc4rKI60B6+CnZhj8B08LyzTs0n8qGfh6aWvY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyyIHMG9INtLEg055pdjN2hme0GDgvrFoQdw5jcUEy/yicK8TmL
	4QtkRaq+lnCLPmFzo0yOGvOw2byZHSzJvLJ70IJQhAKsGe9ZzOpNNf6gfnLdm/6wTwf3SLGbgLA
	TINJi9Z6uNe1VPDwPyRpr185GLZRRwEb9x0nm84YCtcoLVi9A3WDkFw6N6BIZ0eLQcYT8bm7y
X-Gm-Gg: AeBDieufZGYY7fgkp30Q0r8L51yxYeFEcJ/XQQNpB/L53dSWiDkoDYGTzpG14eCC+je
	oD8J0fiFB5bnYu7izcoWsJ1DHzDtxURsdgJwmiBsHLau8XsxvKEasFm1Oj6COz+WDeXeTMM8AEA
	C0FP6hKb+0cJHoG7RPF0bKkiZTfPDzPKTTjaO5ePc6mwd4PJdECZfR21SH63niXho0uhKGGrXD1
	+As7x/8AdF2gUxsNP9Y1BHStE4wnoQ+6q01IKaqwyjFJ8SLVL2jY6UgRup7BLvkpG4z7l04JMkm
	a3F/wLqDEXSS9WY9t9TtPWbD4O//wiun5s4B5Tj90oNyumGwDySOjvWyolGi9UpAWMoiPqniWgp
	SXKRGJEInm0Y+ox2c7CPozakZfLoG1qj4eh2B9tyrxS+mHHwasce/337YQYE=
X-Received: by 2002:a17:903:2283:b0:2b9:86ca:5bf2 with SMTP id d9443c01a7336-2b986ca5cd1mr44795485ad.30.1777469536348;
        Wed, 29 Apr 2026 06:32:16 -0700 (PDT)
X-Received: by 2002:a17:903:2283:b0:2b9:86ca:5bf2 with SMTP id d9443c01a7336-2b986ca5cd1mr44794745ad.30.1777469535665;
        Wed, 29 Apr 2026 06:32:15 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98893f0b7sm25818105ad.40.2026.04.29.06.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:32:13 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:01:57 +0530
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 06/15] remoteproc: qcom_q6v5_mss: Switch to generic
 PAS TZ APIs
Message-ID: <20260429133157.lopr6n5vaik36466@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-7-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-7-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNyBTYWx0ZWRfXx+OmaxCvmciI
 ao3E0fChI4Nah1Cpinjj9BuViGU7xUuvS68GGKfw5iX/HsBTlZtRPeEbQraQdLL94y57yOw6brJ
 xc6lb/NT3lWF9l2Y8NneBpOBApEWkcg6v2YTMfHkDI2FdYXaLP34ZbWZ2w35v42OLLUeqXc6prL
 8APgfCCBG3ZV9h5Q1Epl0q5Xc2fCr6c677sPj6cqh18CHw8y4+A894+aWJE7TGIj0CrjYs1tNNT
 V6HlgG9wB063opiPde61lT1mVbaOUGCtNZ7sKCPn2gNg9RnXfisXGIL9ZazZYrNledeQ6MUu5Fe
 Mtf5OpNner8jUBQtBdv/p3qxgWZFrkipxrvuTekSJpQMVcr3dJWwX1Jj7tj8MqjuSWQALM/LwZG
 dYhhl0uZ8RrJ2RQxw9rSiWYsA/PcnwOZWIBdby8A4oOTBYA3jWu9b1mBDg7uCnrvyPisJotb4D1
 Ttxb6UPfU9sCCj0wyAQ==
X-Proofpoint-GUID: 9GTD5UAS8yMwVtet6uKFEhC1f6UhuOXS
X-Proofpoint-ORIG-GUID: 9GTD5UAS8yMwVtet6uKFEhC1f6UhuOXS
X-Authority-Analysis: v=2.4 cv=CL4amxrD c=1 sm=1 tr=0 ts=69f20861 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UXi9AHVq_sPz40Hf2JYA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290137
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.89 / 15.00];
	BAYES_HAM(-2.29)[96.67%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2EEDD43AD6
X-Spamd-Bar: ---
Message-ID-Hash: YVNU3CN4GJPXIU57ZFB2AK6XNEW24CSN
X-Message-ID-Hash: YVNU3CN4GJPXIU57ZFB2AK6XNEW24CSN
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YVNU3CN4GJPXIU57ZFB2AK6XNEW24CSN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mukesh Ojha via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 03:25:54PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index ae78f5c7c1b6..96888007faa8 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -34,6 +34,7 @@
>  #include "qcom_pil_info.h"
>  #include "qcom_q6v5.h"
>  
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

same here., whether it is needed now ?

>  
>  #define MPSS_CRASH_REASON_SMEM		421
> @@ -1480,7 +1481,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  	}
>  
>  	if (qproc->need_pas_mem_setup) {
> -		ret = qcom_scm_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
> +		ret = qcom_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
>  		if (ret) {
>  			dev_err(qproc->dev,
>  				"setting up mpss memory failed: %d\n", ret);
> @@ -2077,7 +2078,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> -	if (desc->need_mem_protection && !qcom_scm_is_available())
> +	if (desc->need_mem_protection && !qcom_pas_is_available())
>  		return -EPROBE_DEFER;
>  
>  	mba_image = desc->hexagon_mba_image;

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha
