Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903F1FF8867
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 13:22:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B778643AD6
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777468955;
	bh=K9SziZwg2cg6hFbGZntKPnTumWR+tSXth0HI677R5sU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zbUTx8/4uZzxQ+VUbt9Z9V1sY4QAvHue7+sJdtI8qVohrmuC+1/JOO7ivq5bDr7c0
	 C1GupV87GAKp/1a4Eo+kdMOiTDFVYSHIK43PP4qB5tUgwINT5fGAm/iDrmVoluNRvR
	 ovWALgr2pBKQmB5ba6yOvd6fDuAyz55egXH/X8zpgyxm4fMj58Q0UONRzRQfMvkYgO
	 X7YnqieWdOO/fzHiHZ9+9B8/fQaMFMvMceDn3t0YfqRAnbYgppnUlQRgsf2B8pcHo+
	 4MVDZl4dNgW773aKYF++lS48h9Y2M4tWnESUGtxz/8RGhoZh/IEOYxjhGCY5QBkHB9
	 yrEWWrgDap8RQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8572743AD6
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:20:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MpzMTZQN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sm/sFXzI;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q30M2095332
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=helEobTcZ3+WqP3KRmH5fips
	MFY/APaVYYJ+NFxCwsc=; b=MpzMTZQNb86sTF07AiqH/nkpLUkY4jGNjNCCekiR
	2F3lTRcf4LUhSYqCaGXyJSDops2MpH3hE94J5UTL3eTvZH702UNURHxKCkYz+qo9
	f5XB+VtPssFImppRrpuY39ObjH+ykdPv0SeRkpu5grOK99gwYnfunAVeHQgSsISl
	0/i4TSW1EIpmPTHHuw/JTUig82EtiP4i4B4tTKXZQjgTjx2+hL3pxcR2mezcMvCk
	IGT1ikpLw4y8g2XKFwbLYlqoOyBt+A63FOGXPf4rWwaQ+qnto0vi9Q1HUTRGtqNS
	egmgHjdignnFQoA2WiuDIaLO7BcWCP3IKfqwfqwt6S8jDg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3se75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:20:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so225978095ad.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777468839; x=1778073639; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=helEobTcZ3+WqP3KRmH5fipsMFY/APaVYYJ+NFxCwsc=;
        b=Sm/sFXzIsth87xj4XRybpq84kC0mgmToN3ykPeREAU0IOc6ij8Hioy52GAT7x4FMRs
         SsVGan4juplgQinB5MlCmnlN7yf3kEIKMkgjWKJsyrtLCF7AqGsyhZz0RLh4zFnbsZBi
         36e979BYeXimw6BSEO1njf+BXxZBxRruU8b6O6iliYtB3htRuv+OjRaIIP6lNS7rV3b/
         CrYDy6JLuTzpoDtdZd9X+llfyUfgM/Inp0o1txA0bnKpb1q7bfyn4el/gqpr1Yj0YKx7
         22YK7iCIB33mGRJBoUbsRLoBVj3sF1eNzWgoG9r3rY7Ht/iV1YELHtxWuBSEGSVdGVUM
         B9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468839; x=1778073639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=helEobTcZ3+WqP3KRmH5fipsMFY/APaVYYJ+NFxCwsc=;
        b=T4zCOo0IU4D+ZtweRqft3k0NctTZrbj+DQZA2uqgnUlLAw6zyX2iQ2zzlJPSRH+5ud
         jLjI9wDjcdUfAUBHFV3P9WdegyLZD5WnG9Vhe9qt/BJqRJmQHmihmIgabERlFj6RE0az
         XqYdndelJatOHZPlCWOMT5eS2JE4tHBquAIUULSbQ3FRiUqfiL5rSeRqZgIzYdQbgoeX
         4a5YEvFBX2zo8xM3sgEDyLaCMC5exmPJPcDJEcgtZnN+7wwjweqXzCR13daizq/HnUh4
         u/abryE2sIDuolsbmRIqk00KzyyKk7z/yqjGBEQT0wtSAlctlr+yuzXHfO8cd/ox5BLp
         eMTA==
X-Forwarded-Encrypted: i=1; AFNElJ9iSdHkTlGCZV8LXP7SI2zLWlDy2qWPgjJvDuNaHnzLFwcI9oqXns5Mfr3yE2o4D+vyxQPGFos=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyUikF7IatQB5WoAGfeVmhLIBqrMTHBDg1uCo9jPEymecrye69k
	r5wbyZaFBc9NItuWtCDBsUSp4ul97RQHFo6xay+6bfkU34x9cEW7VYib7J78CVYuUQSqTgglJFG
	NFz2fXFfRgpqFNXN7wZ8YV/OG7SzY3pcCJzpgG1zkAJUenTwIB3zUZfysLB4wETXLbzMt3tzE
X-Gm-Gg: AeBDiesf+AKmisqFfTl1hEv8ujwrAXy8kR7K6YKvzxWjwC4Rp2vyq8Qn0aWQRxfQxCd
	zr1+beEI1aDO6BAFjO+g5Dfaltg9xJLF+chpXtbsJlzh1ATNV8P493Q/Ni9JacfRgUIEFKGIoNW
	vIXuKskndHVnAK164ZeIyBbatA5F1wPmZukgj6XbjVkcWIL4wBzjxsL5rDB89IweZMmiqYI5763
	D2xQaLCz7NRFa2KMuboufCxllG5kDwiRU6nBVfpqXP2PEc0aaw0cDvLgYtwam3e/DLgOHouLru5
	l8EilMyQ4bO+ggNtkr/FlSKg6uXfFa+Mbh8Bk9ZRkROBXPH79nBO0l1yZTr/VRKt+Z8cZDrUhia
	NgSKc8jatq810Sd8tW68WuE8O9EsMVW62KTYw7Gx+UIseWPZ/fEHobbU+bDE=
X-Received: by 2002:a17:902:da81:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b97c4396e6mr82444295ad.17.1777468838527;
        Wed, 29 Apr 2026 06:20:38 -0700 (PDT)
X-Received: by 2002:a17:902:da81:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b97c4396e6mr82443265ad.17.1777468837700;
        Wed, 29 Apr 2026 06:20:37 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879f033sm22452335ad.28.2026.04.29.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:20:36 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:50:21 +0530
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
Message-ID: <20260429132021.xk2xtll545o256oz@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-5-sumit.garg@kernel.org>
X-Proofpoint-GUID: zTk5hF-SU1jxLfk8oYXv5-a8OSg1rDQ2
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f205a7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=uCB-_qCOk_dth8sO8NgA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: zTk5hF-SU1jxLfk8oYXv5-a8OSg1rDQ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNSBTYWx0ZWRfX7oXDbFEyPlh0
 aLKIoakCIM0CIdOaKWPjOGmFkvqRZJGFIeavPF/bURk76C1zqQ0kjd0BPQ4yGVAuiAeRCEhFeqV
 S5bo+isevwD+Me0KTM7H4XjmGEgM+Agrcu8EWjPeFBygjKu+SHi5d2RCpt8snS1S7wwxkSahoUM
 XCvhM1FJ4VEqovMBdMpSMiKfWqrEJCtmWW6DbFIpaqO9GSNwjih0fzqwaDAC/JsfCKYNvgqjQEw
 nTt48/pS4Faf7LJz3fjyOwyKCYE8nHL9Q7qTwdemp5JpGwyRxGzXI/BiRI/vwJbgsO90d73WONL
 +yMMnIqzLprL771gy6rtZT5LHNJZUSwbgiFQ6op8S9KOEGC4k3xuqEBZ3Kb2T55FZZE75HdGpP8
 pMsqXIV9dsuiI1ENt3pJWmabsOug+r/2J74UKtpcIL9z0W4S+b54EwKRKD5JLKkZcAQYgsI9ubK
 q3bcr8Lrq1AJhx5s8hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8572743AD6
X-Spamd-Bar: --
Message-ID-Hash: 5SGA5WEXEWRLCS42LOOO6SVWDRCPBBAE
X-Message-ID-Hash: 5SGA5WEXEWRLCS42LOOO6SVWDRCPBBAE
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5SGA5WEXEWRLCS42LOOO6SVWDRCPBBAE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mukesh Ojha via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 03:25:52PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for Peripheral Authentication Service (PAS) driver based
> on TEE bus with OP-TEE providing the backend PAS service implementation.
> 
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig        |  10 +
>  drivers/firmware/qcom/Makefile       |   1 +
>  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
>  3 files changed, 490 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 9a12ae2b639d..300b3a1bd178 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -14,6 +14,16 @@ config QCOM_PAS
>  	  backends plugged in whether it's an SCM implementation or a proper
>  	  TEE bus based PAS service implementation.
>  
> +config QCOM_PAS_TEE
> +	tristate
> +	select QCOM_PAS
> +	depends on TEE
> +	depends on !CPU_BIG_ENDIAN
> +	default m if ARCH_QCOM
> +	help
> +	  Enable the generic Peripheral Authentication Service (PAS) provided
> +	  by the firmware TEE implementation as the backend.
> +
>  config QCOM_SCM
>  	select QCOM_PAS
>  	select QCOM_TZMEM
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index dc5ab45f906a..48801d18f37b 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>  obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> +obj-$(CONFIG_QCOM_PAS_TEE)	+= qcom_pas_tee.o
> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
> new file mode 100644
> index 000000000000..af73d0a68525
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas_tee.c
> @@ -0,0 +1,479 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/tee_drv.h>
> +#include <linux/uuid.h>
> +
> +#include "qcom_pas.h"
> +
> +/*
> + * Peripheral Authentication Service (PAS) supported.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + */
> +#define TA_QCOM_PAS_IS_SUPPORTED		1
> +
> +/*
> + * PAS capabilities.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [out] params[1].value.a:	PAS capability flags
> + */
> +#define TA_QCOM_PAS_CAPABILITIES		2
> +
> +/*
> + * PAS image initialization.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[1].memref:	Loadable firmware metadata
> + */
> +#define TA_QCOM_PAS_INIT_IMAGE			3
> +
> +/*
> + * PAS memory setup.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Relocatable firmware size
> + * [in]  params[1].value.a:	32bit LSB relocatable firmware memory address
> + * [in]  params[1].value.b:	32bit MSB relocatable firmware memory address
> + */
> +#define TA_QCOM_PAS_MEM_SETUP			4
> +
> +/*
> + * PAS get resource table.
> + *
> + * [in]     params[0].value.a:	Unique 32bit remote processor identifier
> + * [inout]  params[1].memref:	Resource table config
> + */
> +#define TA_QCOM_PAS_GET_RESOURCE_TABLE		5
> +
> +/*
> + * PAS image authentication and co-processor reset.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Firmware size
> + * [in]  params[1].value.a:	32bit LSB firmware memory address
> + * [in]  params[1].value.b:	32bit MSB firmware memory address
> + * [in]  params[2].memref:	Optional fw memory space shared/lent
> + */
> +#define TA_QCOM_PAS_AUTH_AND_RESET		6
> +
> +/*
> + * PAS co-processor set suspend/resume state.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Co-processor state identifier
> + */
> +#define TA_QCOM_PAS_SET_REMOTE_STATE		7
> +
> +/*
> + * PAS co-processor shutdown.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + */
> +#define TA_QCOM_PAS_SHUTDOWN			8
> +
> +#define TEE_NUM_PARAMS				4
> +
> +/**
> + * struct qcom_pas_tee_private - PAS service private data
> + * @dev:		PAS service device.
> + * @ctx:		TEE context handler.
> + * @session_id:		PAS TA session identifier.
> + */
> +struct qcom_pas_tee_private {
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	u32 session_id;
> +};
> +
> +static bool qcom_pas_tee_supported(struct device *dev, u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_IS_SUPPORTED,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS not supported, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int qcom_pas_tee_init_image(struct device *dev, u32 pas_id,
> +				   const void *metadata, size_t size,
> +				   struct qcom_pas_context *ctx)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_INIT_IMAGE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		}
> +	};
> +	struct tee_shm *mdata_shm;
> +	u8 *mdata_buf = NULL;
> +	int ret;
> +
> +	mdata_shm = tee_shm_alloc_kernel_buf(data->ctx, size);
> +	if (IS_ERR(mdata_shm)) {
> +		dev_err(dev, "mdata_shm allocation failed\n");
> +		return PTR_ERR(mdata_shm);
> +	}
> +
> +	mdata_buf = tee_shm_get_va(mdata_shm, 0);
> +	if (IS_ERR(mdata_buf)) {
> +		dev_err(dev, "mdata_buf get VA failed\n");
> +		tee_shm_free(mdata_shm);
> +		return PTR_ERR(mdata_buf);
> +	}
> +	memcpy(mdata_buf, metadata, size);
> +
> +	param[1].u.memref.shm = mdata_shm;
> +	param[1].u.memref.size = size;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS init image failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		tee_shm_free(mdata_shm);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	if (ctx)
> +		ctx->ptr = (void *)mdata_shm;
> +	else
> +		tee_shm_free(mdata_shm);
> +
> +	return ret;
> +}
> +
> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> +				  phys_addr_t addr, phys_addr_t size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_MEM_SETUP,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = size,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = lower_32_bits(addr),
> +			.u.value.b = upper_32_bits(addr),
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +DEFINE_FREE(shm_free, struct tee_shm *, tee_shm_free(_T))
> +
> +static void *qcom_pas_tee_get_rsc_table(struct device *dev,
> +					struct qcom_pas_context *ctx,
> +					void *input_rt, size_t input_rt_size,
> +					size_t *output_rt_size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_GET_RESOURCE_TABLE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = ctx->pas_id,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> +			.u.memref.size = input_rt_size,
> +		}
> +	};
> +	void *rt_buf = NULL;
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			ctx->pas_id, ret, inv_arg.ret);
> +		return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
> +	}
> +
> +	if (param[1].u.memref.size) {
> +		struct tee_shm *rt_shm __free(shm_free) =
> +			tee_shm_alloc_kernel_buf(data->ctx,
> +						 param[1].u.memref.size);
> +		void *rt_shm_va;
> +
> +		if (IS_ERR(rt_shm)) {
> +			dev_err(dev, "rt_shm allocation failed\n");
> +			return rt_shm;
> +		}
> +
> +		rt_shm_va = tee_shm_get_va(rt_shm, 0);
> +		if (IS_ERR(rt_shm_va)) {
> +			dev_err(dev, "rt_shm get VA failed\n");
> +			return ERR_CAST(rt_shm_va);
> +		}
> +		memcpy(rt_shm_va, input_rt, input_rt_size);

It is very obvious that every existing user will pass NULL as input_rt
and 0 as input_rt_size.

Are you not getting NULL pointer on this input_rt ? Ok, you may be not
getting because, input_rt_size == 0.

I hope, your backend implementation checks for this num == 0 and then
ignore input rt.

> +
> +		param[1].u.memref.shm = rt_shm;
> +		ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +		if (ret < 0 || inv_arg.ret != 0) {
> +			dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +				ctx->pas_id, ret, inv_arg.ret);
> +			return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
> +		}
> +
> +		if (param[1].u.memref.size) {
> +			*output_rt_size = param[1].u.memref.size;
> +			rt_buf = kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);
> +			if (!rt_buf)
> +				return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	return rt_buf;
> +}
> +
> +static int __qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id,
> +					 phys_addr_t mem_phys, size_t mem_size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_AUTH_AND_RESET,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = mem_size,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = lower_32_bits(mem_phys),
> +			.u.value.b = upper_32_bits(mem_phys),
> +		},
> +		/* Reserved for fw memory space to be shared or lent */
> +		[2] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS auth reset failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)
> +{
> +	return __qcom_pas_tee_auth_and_reset(dev, pas_id, 0, 0);
> +}
> +
> +static int qcom_pas_tee_prepare_and_auth_reset(struct device *dev,
> +					       struct qcom_pas_context *ctx)
> +{
> +	return __qcom_pas_tee_auth_and_reset(dev, ctx->pas_id, ctx->mem_phys,
> +					     ctx->mem_size);
> +}
> +
> +static int qcom_pas_tee_set_remote_state(struct device *dev, u32 state,
> +					 u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_SET_REMOTE_STATE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = state,
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);

should be "PAS set remote state failed .."

> +		return ret ?: -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_pas_tee_shutdown(struct device *dev, u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_SHUTDOWN,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void qcom_pas_tee_metadata_release(struct device *dev,
> +					  struct qcom_pas_context *ctx)
> +{
> +	struct tee_shm *mdata_shm = ctx->ptr;
> +
> +	tee_shm_free(mdata_shm);
> +}
> +
> +static struct qcom_pas_ops qcom_pas_ops_tee = {
> +	.drv_name		= "qcom-pas-tee",
> +	.supported		= qcom_pas_tee_supported,
> +	.init_image		= qcom_pas_tee_init_image,
> +	.mem_setup		= qcom_pas_tee_mem_setup,
> +	.get_rsc_table		= qcom_pas_tee_get_rsc_table,
> +	.auth_and_reset		= qcom_pas_tee_auth_and_reset,
> +	.prepare_and_auth_reset	= qcom_pas_tee_prepare_and_auth_reset,
> +	.set_remote_state	= qcom_pas_tee_set_remote_state,
> +	.shutdown		= qcom_pas_tee_shutdown,
> +	.metadata_release	= qcom_pas_tee_metadata_release,
> +};
> +
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	return ver->impl_id == TEE_IMPL_ID_OPTEE;
> +}
> +
> +static int qcom_pas_tee_probe(struct tee_client_device *pas_dev)
> +{
> +	struct device *dev = &pas_dev->dev;
> +	struct qcom_pas_tee_private *data;
> +	struct tee_ioctl_open_session_arg sess_arg = {
> +		.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL
> +	};
> +	int ret, err = -ENODEV;

Most people prefer one line per variable..


> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
> +	if (IS_ERR(data->ctx))
> +		return -ENODEV;
> +
> +	export_uuid(sess_arg.uuid, &pas_dev->id.uuid);
> +	ret = tee_client_open_session(data->ctx, &sess_arg, NULL);
> +	if (ret < 0 || sess_arg.ret != 0) {
> +		dev_err(dev, "tee_client_open_session failed, ret: %d, err: 0x%x\n",
> +			ret, sess_arg.ret);
> +		err = ret ?: -EINVAL;

Only user of goto,  we can close the context and return from here and
'err' not used.

		tee_client_close_context(data->ctx);
		return ret ?: -EINVAL;

> +		goto out_ctx;


> +	}
> +
> +	data->session_id = sess_arg.session;
> +	dev_set_drvdata(dev, data);
> +	qcom_pas_ops_tee.dev = dev;
> +	qcom_pas_ops_register(&qcom_pas_ops_tee);
> +
> +	return ret;
> +out_ctx:
> +	tee_client_close_context(data->ctx);

Return after two line does not look nice.

> +
> +	return err;
> +}
> +
> +static void qcom_pas_tee_remove(struct tee_client_device *pas_dev)
> +{
> +	struct device *dev = &pas_dev->dev;
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +
> +	qcom_pas_ops_unregister();
> +	tee_client_close_session(data->ctx, data->session_id);
> +	tee_client_close_context(data->ctx);
> +}
> +
> +static const struct tee_client_device_id qcom_pas_tee_id_table[] = {
> +	{UUID_INIT(0xcff7d191, 0x7ca0, 0x4784,
> +		   0xaf, 0x13, 0x48, 0x22, 0x3b, 0x9a, 0x4f, 0xbe)},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, qcom_pas_tee_id_table);
> +
> +static struct tee_client_driver optee_pas_tee_driver = {
> +	.probe		= qcom_pas_tee_probe,
> +	.remove		= qcom_pas_tee_remove,
> +	.id_table	= qcom_pas_tee_id_table,
> +	.driver		= {
> +		.name		= "qcom-pas-tee",
> +	},
> +};
> +
> +module_tee_client_driver(optee_pas_tee_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm PAS TEE driver");
> -- 
> 2.51.0
>


With above change,

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha
