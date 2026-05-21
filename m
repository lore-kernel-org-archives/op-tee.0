Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95212CD343F
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 06:41:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C5BE944392
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 06:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779345667;
	bh=Bg3wv+G7Rugf8pCuJ1KGip4ySS7+uJ2LCfo3GU+OnGA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=cLggH0vQZkGr6GrZOOUZXSSg9UZSa5ohYS/VdDEa/zNg6sopEmf7Fvk0fQ5rQpzSv
	 AgmBWosNIoavgEJ/vIruYCWy5xch9chV4Ji68cd0jY2LX23bM1YEwKk3mLtYc8jGbR
	 7qvYlZ0P/+jWWr7sFQndXSLBJfy7Q3mgXAc7J9VP8mdwssEj1dmEbSijIKH5fWeJY+
	 viANbUV7SIt/dwwRi5e0O82kHc0a9tb0rwjw8vM8QfKUsf9UKZLD8DgZn+yrpbMz4X
	 SoPU0HEdW19qn8c8cubx3nC+JJRcX2SRizBKY5MdkOjyNsJ/jZG/SPQqqbGjKeOCUL
	 JLtCclpPgkuOw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C8A2344392
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 06:41:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pGbvrLaL;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HyEF6duM;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6AfN02157876
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 06:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9gufQkHi4wZzoYH8TEPzFMkNzt1iU7P3JLBUE34HUhQ=; b=pGbvrLaL78us87ZC
	qoWvxsv7V2INxu/+LYewLf/Dj9+tEUXahR+lOB1X0Jn6fABWHOWTXz9IjuiptX63
	LDHkSGIRTxjXwrGYwGXEnQeETck4YSzpAKVmctSzjxA3Q5MHR1sSW2h8P3AO3uIB
	olClDTEjvs2c6UwO6AWstv3MzUE/DaqWAMcx/rbLwes0tAHjMYdL9Ju1yvFsH4td
	FamEMvDSnYWQQAPHrWkbljA26w1wV12BpCN7fks9DapiFsrMUxOlofal82eKGD9O
	y/eg1qOLPXIDCixysfptgpB//Pt+S6sQhrBHY1FLK4Go4EQ8hqIV9bfHbMLRiMF+
	EAoVPQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma41sht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 06:40:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so58539255ad.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779345659; x=1779950459; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gufQkHi4wZzoYH8TEPzFMkNzt1iU7P3JLBUE34HUhQ=;
        b=HyEF6duMlbjJt3AEc92yeqdIke1r5NC/ubQjJnBZOx+28CJX2XUF/9VoB33jyC879H
         0aYjjgnJPwxEh9xjTU/0EuTXbhlx0XjHJIx7l7liqQg3B4EXjOal2WEaWiKS+n47SdWE
         CajIyDuxc7J7NNo4kuy1LPsV0sa/7BTXuiBwy+VwIdDYkuDIsSz1CnUbXu/3ljtCIbYO
         3WONEsMUPp4UuJ2OpOEHuAyApfnU3awsbk0YAJQhW5MIyLFQVB9f8VICdRSUopT6yG9Q
         88ZCaL/OcXlIKW2U/WIO3ZKyOmpg4dk/mLzGH8C21DgdPGbEZMg89MRSrJnaJxTZaF0C
         uX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779345659; x=1779950459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gufQkHi4wZzoYH8TEPzFMkNzt1iU7P3JLBUE34HUhQ=;
        b=UAUbdCgdFzNvlaPKCKeRDqazabNIzbGTBZVXwXlle7hdVUHxkiQYiJ4URoz57y9UWZ
         rWfqT0NH1Y5l073hJvJIgwlw24oP/b3C7c1KrSgkyGyQertrXX9QPi8oPm+y29q0hfnC
         tZniWCz94miqmOy9jX5g29x0mjW0fFOOedBuzRgbJILfEdfY2kVwi9Ae1r0/URzDwV1J
         47z6HmsRnvYksodJdhF6dvM3h9vVxW4MoHUeJrsViL5lSpJqRIqc/X99IXikLH1a+JIJ
         1Kk7wmMU+WQ0DxLy1KRd6sDQBgcti3mk4VYoGpxlNrlkj1jtuzwdWyBlJAXBOxrOUnXx
         YOiw==
X-Forwarded-Encrypted: i=1; AFNElJ+Dneh6ILrkuQVUT4YMVaq09+K5fKmUcilpG6rj/mWFx+PVn5xjisbTBoQfYrvoJQN15/Xx5SI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzB34aNjr8FpwN38exuMts4aSLld0BsIHQHWN4w0dz3mAZqNatp
	YXRmL3EwniTqudfbxLcJ6OSYcbJ0oPTiB4+xiS3MDKTozaAMTKTYM8jva5zARuEc3Ch9RDYbmew
	u771PB9VJDdhP+ssKXFDJRsaAcqivEg9MZn2vYFlQLBnHFMzeLtP1znBvH9u/YRZLTtkjtbRQ
X-Gm-Gg: Acq92OGjmYWPp8aybMo817AlmY2vqyJYbqSiWM1BayY5YJz1Gk8+hhBNnHhJhhh8EIt
	qjc39n8TW/6mN1HIK5/fbL/xb03/9pCBIhYaTwpzF1GX0tqpTaaXD3dR1GH1x3kyyMO9RB/ldkX
	aLW6+stnzX6AuhusfoR4ZnGl83ZYwTRvGu43ZhssADNBab1JmsrlcB1OyW6G0Pqnc40cSRYXCv9
	9clXLddCTtMDnFZHHI35wmgE+jlQ5E2lzhXRySN9yojIwyrWbRStaI6PJy5rQGbHwzfd6VQMeyE
	2FH/H1SiDF6jLTniT4PsBeSqfOW9+Y9qFWcIBcS4Ei+SEwcbiIcYddqwE6uHVq+vGZz90mXlzBZ
	bvPXGIh/xVZCEnld/WBSoa2F9eWzrDanTiIIi7vSGwhNwfUsv8Sbuesza
X-Received: by 2002:a17:902:db07:b0:2bd:9a27:70f1 with SMTP id d9443c01a7336-2bea3367915mr15247505ad.30.1779345658566;
        Wed, 20 May 2026 23:40:58 -0700 (PDT)
X-Received: by 2002:a17:902:db07:b0:2bd:9a27:70f1 with SMTP id d9443c01a7336-2bea3367915mr15246705ad.30.1779345657978;
        Wed, 20 May 2026 23:40:57 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.250.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe8698sm234673925ad.40.2026.05.20.23.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 23:40:57 -0700 (PDT)
Message-ID: <07cdbd20-f0c5-4be5-878a-ef23dc633767@oss.qualcomm.com>
Date: Thu, 21 May 2026 12:10:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/16] media: qcom: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260518072856.22790-1-sumit.garg@kernel.org>
 <20260518072856.22790-12-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260518072856.22790-12-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ea8fb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=X+kW/DRse7pI7A4riirJBw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=WXTWxIQM56r_4Oy2wpoA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: KBD2Ah7FFm0f4VUe0tJ86qgWwypXRDPi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MSBTYWx0ZWRfX6jioISxEqtpP
 hXrD+TWZKA605+45DAZVTghethjPeMOOwGXxvKphcn1et49ZlCS5VONnEF4liJtv5TUUo/npz/G
 AfOcPiOrtNVEEUWl7sMzezq2zcQ9arnP+RUHh1MvcLXKA5+tDSb4n64ykRhJtXlA4f1AoyLcc0b
 JMLVEpf6nrIF05O40wk/rKHdiCyV85lZxdHyc17H5iAHZ8njp3gGLEQXOVULLpn6uFF7xGUn2EY
 VjuqY5fdxvNRRAStzIl6TRsyrqNxJJRNppKZ54FBMW4x7eXx7LqtQ84bwphpyPavmYO8BexX01a
 6RnuWwscCSVEQSY7r2CXLNETY5z3qNQmglLHdOriOgfuMIhBVvQwbjFl4AytS3xDTdzexsidhWl
 UerJVUF6JxcZWxlMusepBbWRz0acG4QYy0LLeZi1aQjsQhNg1XC3G60uFzhCqrbHPFy1UFxj+5W
 POh3b0fnEJa+X69Sc6w==
X-Proofpoint-ORIG-GUID: KBD2Ah7FFm0f4VUe0tJ86qgWwypXRDPi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_GT_50(0.00)[50];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C8A2344392
X-Spamd-Bar: ----
Message-ID-Hash: KM5K2GBMV3TBSV4XUM2C22ASOH4YBWRQ
X-Message-ID-Hash: KM5K2GBMV3TBSV4XUM2C22ASOH4YBWRQ
X-MailFrom: vikash.garodia@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, sri
 nivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, pgujjula@qti.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KM5K2GBMV3TBSV4XUM2C22ASOH4YBWRQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vikash Garodia via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>


On 5/18/2026 12:58 PM, Sumit Garg wrote:
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 5f408024e967..b3c5281aea91 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <linux/of_address.h>
>   #include <linux/of_reserved_mem.h>
> @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
>   		return -ENOMEM;
>   	}
>   
> -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
>   	if (ret)  {
>   		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>   		return ret;
> @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
>   						     cp_config->cp_nonpixel_size);
>   		if (ret) {
>   			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
>   			return ret;
>   		}
>   	}
> @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
>   
>   int iris_fw_unload(struct iris_core *core)
>   {
> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
>   }
>   
>   int iris_set_hw_state(struct iris_core *core, bool resume)
>   {
> -	return qcom_scm_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, 0);
>   }
> diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> index 63ee8c78dc6d..7997b8aa427a 100644
> --- a/drivers/media/platform/qcom/venus/Kconfig
> +++ b/drivers/media/platform/qcom/venus/Kconfig
> @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
>   	select OF_DYNAMIC if ARCH_QCOM
>   	select QCOM_MDT_LOADER
>   	select QCOM_SCM
> +	select QCOM_PAS
>   	select VIDEOBUF2_DMA_CONTIG
>   	select V4L2_MEM2MEM_DEV
>   	help
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 1de7436713ed..3a38ff985822 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -12,6 +12,7 @@
>   #include <linux/of_reserved_mem.h>
>   #include <linux/platform_device.h>
>   #include <linux/of_device.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <linux/sizes.h>
>   #include <linux/soc/qcom/mdt_loader.h>
> @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>   	int ret;
>   
>   	if (core->use_tz) {
> -		ret = qcom_scm_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, 0);
>   		if (resume && ret == -EINVAL)
>   			ret = 0;
>   		return ret;
> @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
>   	int ret;
>   
>   	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> -	    (core->use_tz && !qcom_scm_is_available()))
> +	    (core->use_tz && !qcom_pas_is_available()))
>   		return -EPROBE_DEFER;
>   
>   	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
>   	core->fw.mem_phys = mem_phys;
>   
>   	if (core->use_tz)
> -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
>   	else
>   		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>   
> @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
>   						     res->cp_nonpixel_start,
>   						     res->cp_nonpixel_size);
>   		if (ret) {
> -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +			qcom_pas_shutdown(VENUS_PAS_ID);
>   			dev_err(dev, "set virtual address ranges fail (%d)\n",
>   				ret);
>   			return ret;


API "qcom_scm_mem_protect_video_var() would also need this migration, 
any reason not to consider that ?

Could you please check, if any such usage of legacy *scm* APIs, like the 
one i pointed above, can be enforced to err out at compile time ?

Regards,
Vikash
