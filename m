Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (unknown [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DAEFEA806
	for <op-tee@archiver.kernel.org>; Wed, 25 Mar 2026 05:14:29 +0000 (UTC)
Received: from server-108-138-64-117.iad12.r.cloudfront.net (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A5FE84436C
	for <op-tee@archiver.kernel.org>; Wed, 25 Mar 2026 05:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774415668;
	bh=HlMYOavZlom+8UZN2xckPAC6WFBM+19NyvW+PYf27tg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=VnPZGeLMNSWolj5sZmIemRHIu45N82eQ7TXmD0UNZAZTZfNHlze8YHVzRLbRZ097s
	 d80dUmpnNG2ld1eVmTCe9EB5H+qreGZzJZYU9oeaHB94FPvHmROMmMqFqFv++sO5s4
	 XAf0hbDt04tKt0SZeDKNs1n1jWNqM6PRndl9ac8aWemgt55bhQdo1e9kSWZQblH1BV
	 4fXbWuAYTp4giY3gYEM2ble/ofuW08DbiWViUelqJp/E/M8M/BqWXAwTHtWs1FFYlu
	 ZHc+QsHjYye9xhij59bI1ae1U5MEI9QCpIOfH9GTnZUiyo8PEWiMfIANnn3KfLkx7E
	 ada6Q+/1CgqRQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2CDAC42FCA
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Mar 2026 04:34:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UxXtUFqX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lb9aDNL7;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3oCOv1208841
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Mar 2026 04:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EHUp7/16YUMBtKGES+yYYqc2
	0LzNJsKIcI6vCitDSoc=; b=UxXtUFqX1/6g2nxsMa/K3D44muLA4QP/qfif7ikK
	0PfGqXPH2DkXPdFnv2JwH9dBZrMi+CJqXZ0Fx5kAQPk9xIyNvrptcTe2T39UgZRD
	PqQ9HCtVYJnygYaIfjzbz/TXWLO5j1HuJqsSRgROj20zluZNW1VYdXF495ZZnzmo
	kQW5B/W7yOkgLxG3oM1WyUL0pFOI4P4e6nmddPEUOF8OeK5190ahq1G2S+KRAZLx
	FjtOUwxDpHveFbF9HNRmUu11f7KytW5gnm2N/GHuedbMnGAxOs/bt4U7Z2UpMdLK
	7xeadyqyfvYZQ6/nJzG5hnrxVaUQfMPYQJzdZGp34rGkDA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d485983qm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Mar 2026 04:34:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89c3d3f5799so146882286d6.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 24 Mar 2026 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774413264; x=1775018064; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHUp7/16YUMBtKGES+yYYqc20LzNJsKIcI6vCitDSoc=;
        b=Lb9aDNL7Zqwa9LntoUD7+U3+TTtfeIQDlhT1j2NzttvU57rzKp03J2nWFIuSd6SOi0
         rb0YbyVUyFxnrQHio22p7a7o1KbXZtsTFCXgvrRgWqhCjOb8RoONkrRuUkGx643UGPu+
         6DUunlxYMpZVUOVw9J2FdFpmFGU/d35g+Na9PuOtTj5dyZBpqliYy84Z16uEvkPV1hYX
         5LLk4vXf5Ff88Lt65LlAEFdJX3eKk9fmEdnU/ev4sMoZV1FxMUDIL0Z2sKnscRkhNc90
         9PDob64FPg1u7YUXU1/OdaIw8zSUYpBeyzYLDn7hFp16RjQ9Cms6W1F0xP+pLzs1MpD4
         eUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774413264; x=1775018064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHUp7/16YUMBtKGES+yYYqc20LzNJsKIcI6vCitDSoc=;
        b=I/4FSTLu2KJL2/L/veT9L7sOBr0Ztd/DvvO3S3zQDhgeKrHghKLlB2VQxo7O6C+bI6
         AdtdQOvswbPi0CfL6DYYERMZP8x3cLYFP17gu7wz7FBhmBrPjMTUKYvwObqqx8h64RtC
         x9dglh9RXiXvU3gOCKVou/HoGfR//Ke89195Zsc9RgR7AkBV73QbYsNBXNJEYZvzfV+P
         famWDtKku0qsNbXg63BUEIiL2JRI4VpUyjKYFROi1zsXMHC7knxxdliBjO3HGxFHta8X
         Gz7Wa6wGMf4IeM7aHDoB4r/ADKCVcTIrto/ZlhDiNSfFm7OR5kbpJQIO45OuMmwnsg5S
         DD4w==
X-Forwarded-Encrypted: i=1; AJvYcCWnw+gJaxqprVwvx9C0UVWahqVHIAXlmoFZ91NnsE+dTi8fFODRUngDG0Dsin3z3tb4c6uWsBs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzNDE7cKOCF95+iILs7qKuvXqxAncByTw1T3XgNeQ/InBMNMwhN
	WuKf8hVxjqRQdZxZDPQqp5NqwaLvRXqcE0Px+U1/oUWblEqkffQ5M/WNmi/tL82Bslai3iMMolR
	ci/zDQ3StsxBluDFvbq3+jySwn6MpVZtIykR6q0x7SQFb+yet8w7LkrPxbPDQ7j/j9tuO/yZ0
X-Gm-Gg: ATEYQzyJ7gO+zw5kMcLFEsxJsi5lGgjrt4NMdsvDoIoJ48OvFZtgeXM2/iKfA/Ju8Ij
	pzzNC0YvXO4SMmtOqFT/LxWIq+ejnrbcuh+6ARQ/10SgrvGhqgNILKhdWztEerhW5fESAyZXAPr
	GjYFwbF19FwHxwCPeUJXpwLJlJrLwgJBDBylJBl0Uc6SAP8Gwac3usRDLoUdIXjMoZWs5HK4m2e
	CxEVsHxzdPdOU2jyPmQuyjtS6qhnHQij6ehTHmakPA3PjyvgdqQABvx+V0FgPvLTdPLXb8LXCVh
	U8n6wjJcvcNv9M9tuxlfZWgb5hgxZ9WLVBQAMx8dlgoctWH8rGMUR8GLK/P27KZac6L9BQqGbLY
	p+OpOCgbe2RpT1HpG6KaMbJ0IiLKK+ERccELFkx9dwI6MNzrwXgGYMD8SzqeGTqOu65CYT0alFC
	PvIQHIOv9tvrbzOMMNkQXuxU2O7aBKCaNINvk=
X-Received: by 2002:a05:622a:4ce:b0:509:1987:7626 with SMTP id d75a77b69052e-50b80ed53b8mr28888641cf.68.1774413263910;
        Tue, 24 Mar 2026 21:34:23 -0700 (PDT)
X-Received: by 2002:a05:622a:4ce:b0:509:1987:7626 with SMTP id d75a77b69052e-50b80ed53b8mr28888091cf.68.1774413263409;
        Tue, 24 Mar 2026 21:34:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207500sm3648167e87.41.2026.03.24.21.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 21:34:21 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:34:18 +0200
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH 10/14] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <v4ffww2r4ljqqbmvsc5jcr4ztqjbpfb42xryjeuz4abqiwup3a@2gfeelhjzzz4>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-11-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306105027.290375-11-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyOCBTYWx0ZWRfX67W68skXqIld
 QxK0lrbPfQZ9G7L8mFnK/qeg89uChALhLRFL6sIb68GYgmjaW2dyo7f62VztanmPUDDbOmDJRg9
 j9EBYwXQM1rt2EQtOMOp/g+HpqftfjwmVVwz1jMk9nnaqm9vU3yUKH6K0PNTF0sLCQTSiunfZDO
 RkuLAOEDoXfdrw1Vm6VkUq00kwM4ma4yRNHAkxMB1clMSpYPv9ijAABqHH3M0KSPxuhKZYod3ej
 515d9Sru82CMRGpqp7KHNA0hCeH3YrMwNpiph8nEHt3bbum7D/I8pZK41ku8Uq6LFT1mZBm/JUz
 b0AHcnqQbAa6HSh4cgdrrD+teuYFUe0Sz+dhGZ7OkGXvcDVlw6rZMB4p4hByxo7Xy1Cf1R56XO1
 Fm4Ozw25KHU/joJqCAfoNluUFDZuTgo/iStgCwWnx2TSKZBZ/DSAEYWnTYQqKSWIeRuHGqrYivr
 TgjxDNA5Qj8TRbkAm4Q==
X-Authority-Analysis: v=2.4 cv=VODQXtPX c=1 sm=1 tr=0 ts=69c365d0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=kPJGyq6PTXsXdZOMel8A:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: vTe8FnaGNn_eoXe7imvOXjazxaupILWo
X-Proofpoint-ORIG-GUID: vTe8FnaGNn_eoXe7imvOXjazxaupILWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250028
X-Rspamd-Queue-Id: 2CDAC42FCA
X-Spamd-Bar: ----
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[49];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.219.69:received]
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: AXVHBBZV63VCRKBNHAKF7MCGUWCVYJWB
X-Message-ID-Hash: AXVHBBZV63VCRKBNHAKF7MCGUWCVYJWB
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.
 qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AXVHBBZV63VCRKBNHAKF7MCGUWCVYJWB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Fri, Mar 06, 2026 at 04:20:23PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index ef9fd6171af7..3283852f9a14 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -5,7 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>

Missing `select QCOM_PAS`.


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

-- 
With best wishes
Dmitry
