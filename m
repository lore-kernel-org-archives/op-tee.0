Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1223C7EE2A
	for <op-tee@archiver.kernel.org>; Tue, 24 Jun 2025 06:55:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D044D3F731
	for <op-tee@archiver.kernel.org>; Tue, 24 Jun 2025 06:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1750748108;
	bh=MdT7uYOnECbFDiW2hyMdxKKNZUfqdYjCqJ0243HYg9s=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=RiFmlvVuM/36Nkn/8o1rKfwj9LI4K/QWd8CGcZpEPOMIgP/pQKsqhVypc4CFMYzzL
	 wSjAUi0m1Ul5Uu5ySv6JLkhRmB/fHKA/WyjHhrzYz8uIaYZjzrB0kK34dv3QNgJeWx
	 yorUjOY0jxa077I1R1txUbvDMBdpg4dFNdx5TDCWxWx+JmBWmiG7HNZmEMIigT0jXC
	 fBCIAqpEjstIK8XinSZHYIhjMNbPYcfc29tjR9aqOlJhDUWpRJTVBkeDSrNP/s86Rl
	 eN+dit70YqZw80XSVpqunVYw/gJKFvGy7i/poR4T5ENZIdjiLHcp6QwnS5CpDThUj3
	 RoZv2YDVDOV1Q==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B8C183F731
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Jun 2025 06:54:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d+VH9ff2;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O2ucKD024865
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Jun 2025 06:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OIrtVHNQp2y7Zse3vzNGVDYfeRg/j/EJRvoTEwsCgjo=; b=d+VH9ff26SfHRQMG
	uq6FbSoqgS5UZ6zmmRu8ogqtvVnV4Xm6mNtnJrgMc88NiP3H7NtxIb0g6R/SZleH
	/fJZiaGPg65ww+K5/m4YJ1WHw/J6KTefJT4r+h2nPti18qTbqiTSfANw1CjYqoi4
	rPnRmc4M3w5yiIzcWJgd0ET0FH59T4ZOLnmwWAc3asAQoHlrpGE3Yxr8RE7/2zI0
	sqfqLcnPTAUmrSoYi2JF+N9BYfEf1UfDDAZoq4HkpvhQrDlHTdxw1PylDeW5aagd
	uCO6NwJjvVHtNaPfJyxLoWnW03QyHKX6xd/xxX3U25rx+MGcgVnQzoh7e9dzfEJl
	Oy0ghA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f8ymt3s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Jun 2025 06:54:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b321087b1cdso2584169a12.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 23 Jun 2025 23:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750748085; x=1751352885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIrtVHNQp2y7Zse3vzNGVDYfeRg/j/EJRvoTEwsCgjo=;
        b=I4Md+IPHSzchzoZrU5abX89+qbt+eRzW9tGdqMBleZH+5FgBxzoy3+FSaurcgoXOcC
         8a9+CcAiYurDlJiiBb16ZGPp8PYlXPDMok5vhI6IQvdXIiLmWs9sFCc898INJ9kwqgBz
         nSYBnAJipeSWEa9dLdBbv2N/T5IiHbyjDmTomMltSbTtc18ERZe9QsLte7YsCYuxgS1M
         7tNhsLdzpZpxfahmLkXt5M8A0WP45pM/IodDDC6uEDMLW4wTLQwfQ5dcHMRQ22BmmJXJ
         eAaCZOfrnvX+imZ9Fj2hSzGZjBqueUfFVzQTF0vKfxdqGebsRMbtM3zdP4VKO0H13gwM
         r2gg==
X-Forwarded-Encrypted: i=1; AJvYcCWLQOYDbO9XINp6DBmImUwwOHA0czKAyWBsPpOJCOWcmDaHjHlZM7OEO3Ml+5d2tCVlUYh5hoA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy7Y2i8nMN2LkFyFLm0lE51U+YkBuukFO7ZSUI9IE6Tg/m9xn3f
	9Kcs00Rd+2U5i6jNUTx3wiD5+ZJcpVCXZJTPnj02+sxmq7C33QsY9xGSpUej/ZTkZeARSr407He
	fzH5yvA1zffd3Ku5RuUHQUYoACIVY8kTTWDG6lj/LhdoNOLs4zTKdrgx999fNa65casPohNY=
X-Gm-Gg: ASbGncvRHq7DdkgzqFR7iO8ESqbH9wcFp9VGL35G2z23vNAllJz5wtaMG7epHwreiMT
	OAiHa/eaf7NvBU3M1tTN+aqRs5rdX4PR6vMO+wIum74sMXBcPfaUcRcXXEIZ9ozJQVl6g0Xb3HW
	8UvUuOw+S9stEU3sUQqk0H+GC1HxV9w237gNGmTLPB2hLYsbHQAs1wtKzBdihaOdDOTI9eiiQdj
	3MyzVwNhS/T6pgbfDPaS66jKjO2u/pFZ1OT7tGuxlY/JdBGY/SrVj/BE8fuWn008yj+8EL4WTF4
	P0ukAlupJxTi9QAWnbnKkKiC3Q1Ru+8BRDMA9ZobVVWslvBcfGgo2/6lKbaeMsBetH6c2D1ZcKV
	0gkLEheddBRIr4ylOT7We
X-Received: by 2002:a17:903:22cb:b0:234:df51:d16c with SMTP id d9443c01a7336-237d9badd36mr242209535ad.45.1750748084414;
        Mon, 23 Jun 2025 23:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExUm37dtay0q0velYcFv3DxtYUDTccTngr+8MncRLErFXqkPNRqyeek5noM/HvJdeGJNIpTg==
X-Received: by 2002:a17:903:22cb:b0:234:df51:d16c with SMTP id d9443c01a7336-237d9badd36mr242208865ad.45.1750748083825;
        Mon, 23 Jun 2025 23:54:43 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86103e5sm98486035ad.120.2025.06.23.23.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 23:54:43 -0700 (PDT)
Message-ID: <2d93ee96-0c36-4651-b6ad-9fddd0f6ad88@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 16:54:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/9] optee: support protected memory allocation
To: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org,
        linux-arm-kernel@lists.infradead.org
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-8-jens.wiklander@linaro.org>
Content-Language: en-US
In-Reply-To: <20250610131600.2972232-8-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA1NyBTYWx0ZWRfX09fnYihCFYrd
 /6iqu2h2SJj/GDzh/CNYajs+ekEnVz+zBSO8vewetk400J1ApIlJ5ZGftHG0LjmkIRPxy3MArme
 zV5kb/VNJxVsO/U4lGkZGYMw8delM6dsysXjJsDFNOZ5bGqL6aB6Uw/QDpp5Yqb2bHxwUka1uiM
 kprZP7J5+IIihU21SAv50/tU17Tw0ZQ0SsiM3uxJPjU4RbOTCmnqmMgIMKNCOO6bTxsQ0CzzZRB
 eXpqB5LoKHMMcU1qZX33e5h5Qsx8EkpbYJWjZ603VfEF6+dHSozBO5NQXiQUVm1CjfOCbRKho3G
 Q+A+v620LpTpn40VYUcoILrzYLgVHyx0DRbn0Ew6+VNPi2r7h8up04PUSoeutK1mutRQOIpm2aC
 49xmcVgNGve9doEWDRNs3+awsDfU9zOY2vgJtTQ3bFOMB5Ccdgxs5W9Xyv40dVlVyxQ5nDoB
X-Proofpoint-ORIG-GUID: 13t_65avi2Dp3yC68PJGAXAvUFwW31MM
X-Proofpoint-GUID: 13t_65avi2Dp3yC68PJGAXAvUFwW31MM
X-Authority-Analysis: v=2.4 cv=GLYIEvNK c=1 sm=1 tr=0 ts=685a4bb5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=99H9UyJNq6-z9PcZsEwA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240057
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B8C183F731
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	TAGGED_RCPT(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.200:received];
	DKIM_TRACE(0.00)[qualcomm.com:+]
Message-ID-Hash: QTMLTSGOPLN65T4NQEJLD4H4I3KMQX7U
X-Message-ID-Hash: QTMLTSGOPLN65T4NQEJLD4H4I3KMQX7U
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QTMLTSGOPLN65T4NQEJLD4H4I3KMQX7U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Jens,

On 6/10/2025 11:13 PM, Jens Wiklander wrote:
> Add support in the OP-TEE backend driver for protected memory
> allocation. The support is limited to only the SMC ABI and for secure
> video buffers.
> 
> OP-TEE is probed for the range of protected physical memory and a
> memory pool allocator is initialized if OP-TEE have support for such
> memory.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/Kconfig         |  5 +++
>  drivers/tee/optee/core.c          | 10 +++++
>  drivers/tee/optee/optee_private.h |  2 +
>  drivers/tee/optee/smc_abi.c       | 70 ++++++++++++++++++++++++++++++-
>  4 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index 7bb7990d0b07..50d2051f7f20 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -25,3 +25,8 @@ config OPTEE_INSECURE_LOAD_IMAGE
>  
>  	  Additional documentation on kernel security risks are at
>  	  Documentation/tee/op-tee.rst.
> +
> +config OPTEE_STATIC_PROTMEM_POOL
> +	bool
> +	depends on HAS_IOMEM && TEE_DMABUF_HEAPS
> +	default y
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index c75fddc83576..4b14a7ac56f9 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -56,6 +56,15 @@ int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long action,
>  	return 0;
>  }
>  
> +int optee_set_dma_mask(struct optee *optee, u_int pa_width)
> +{
> +	u64 mask = DMA_BIT_MASK(min(64, pa_width));
> +

nit: Why not dma_coerce_mask_and_coherent() instead of bellow?

- Amir

> +	optee->teedev->dev.dma_mask = &optee->teedev->dev.coherent_dma_mask;
> +
> +	return dma_set_mask_and_coherent(&optee->teedev->dev, mask);
> +}
> +
>  static void optee_bus_scan(struct work_struct *work)
>  {
>  	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> @@ -181,6 +190,7 @@ void optee_remove_common(struct optee *optee)
>  	tee_device_unregister(optee->supp_teedev);
>  	tee_device_unregister(optee->teedev);
>  
> +	tee_device_unregister_all_dma_heaps(optee->teedev);
>  	tee_shm_pool_free(optee->pool);
>  	optee_supp_uninit(&optee->supp);
>  	mutex_destroy(&optee->call_queue.mutex);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index dc0f355ef72a..5e3c34802121 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -272,6 +272,8 @@ struct optee_call_ctx {
>  
>  extern struct blocking_notifier_head optee_rpmb_intf_added;
>  
> +int optee_set_dma_mask(struct optee *optee, u_int pa_width);
> +
>  int optee_notif_init(struct optee *optee, u_int max_key);
>  void optee_notif_uninit(struct optee *optee);
>  int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index f0c3ac1103bb..cf106d15e64e 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1584,6 +1584,68 @@ static inline int optee_load_fw(struct platform_device *pdev,
>  }
>  #endif
>  
> +static struct tee_protmem_pool *static_protmem_pool_init(struct optee *optee)
> +{
> +#if IS_ENABLED(CONFIG_OPTEE_STATIC_PROTMEM_POOL)
> +	union {
> +		struct arm_smccc_res smccc;
> +		struct optee_smc_get_protmem_config_result result;
> +	} res;
> +	struct tee_protmem_pool *pool;
> +	void *p;
> +	int rc;
> +
> +	optee->smc.invoke_fn(OPTEE_SMC_GET_PROTMEM_CONFIG, 0, 0, 0, 0,
> +			     0, 0, 0, &res.smccc);
> +	if (res.result.status != OPTEE_SMC_RETURN_OK)
> +		return ERR_PTR(-EINVAL);
> +
> +	rc = optee_set_dma_mask(optee, res.result.pa_width);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	/*
> +	 * Map the memory as uncached to make sure the kernel can work with
> +	 * __pfn_to_page() and friends since that's needed when passing the
> +	 * protected DMA-buf to a device. The memory should otherwise not
> +	 * be touched by the kernel since it's likely to cause an external
> +	 * abort due to the protection status.
> +	 */
> +	p = devm_memremap(&optee->teedev->dev, res.result.start,
> +			  res.result.size, MEMREMAP_WC);
> +	if (IS_ERR(p))
> +		return p;
> +
> +	pool = tee_protmem_static_pool_alloc(res.result.start, res.result.size);
> +	if (IS_ERR(pool))
> +		devm_memunmap(&optee->teedev->dev, p);
> +
> +	return pool;
> +#else
> +	return ERR_PTR(-EINVAL);
> +#endif
> +}
> +
> +static int optee_protmem_pool_init(struct optee *optee)
> +{
> +	enum tee_dma_heap_id heap_id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
> +	struct tee_protmem_pool *pool = ERR_PTR(-EINVAL);
> +	int rc;
> +
> +	if (!(optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM))
> +		return 0;
> +
> +	pool = static_protmem_pool_init(optee);
> +	if (IS_ERR(pool))
> +		return PTR_ERR(pool);
> +
> +	rc = tee_device_register_dma_heap(optee->teedev, heap_id, pool);
> +	if (rc)
> +		pool->ops->destroy_pool(pool);
> +
> +	return rc;
> +}
> +
>  static int optee_probe(struct platform_device *pdev)
>  {
>  	optee_invoke_fn *invoke_fn;
> @@ -1679,7 +1741,7 @@ static int optee_probe(struct platform_device *pdev)
>  	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
>  	if (!optee) {
>  		rc = -ENOMEM;
> -		goto err_free_pool;
> +		goto err_free_shm_pool;
>  	}
>  
>  	optee->ops = &optee_ops;
> @@ -1752,6 +1814,9 @@ static int optee_probe(struct platform_device *pdev)
>  		pr_info("Asynchronous notifications enabled\n");
>  	}
>  
> +	if (optee_protmem_pool_init(optee))
> +		pr_info("Protected memory service not available\n");
> +
>  	/*
>  	 * Ensure that there are no pre-existing shm objects before enabling
>  	 * the shm cache so that there's no chance of receiving an invalid
> @@ -1787,6 +1852,7 @@ static int optee_probe(struct platform_device *pdev)
>  		optee_disable_shm_cache(optee);
>  	optee_smc_notif_uninit_irq(optee);
>  	optee_unregister_devices();
> +	tee_device_unregister_all_dma_heaps(optee->teedev);
>  err_notif_uninit:
>  	optee_notif_uninit(optee);
>  err_close_ctx:
> @@ -1803,7 +1869,7 @@ static int optee_probe(struct platform_device *pdev)
>  	tee_device_unregister(optee->teedev);
>  err_free_optee:
>  	kfree(optee);
> -err_free_pool:
> +err_free_shm_pool:
>  	tee_shm_pool_free(pool);
>  	if (memremaped_shm)
>  		memunmap(memremaped_shm);

