Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AB9C83F07
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 02:22:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3E42D4311C
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 02:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1751854937;
	bh=Bq2XJMDzBjiXHpkHSvC+7nVFKY7MgScve++Kw/NH70k=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=trFIWLDbajNUsouW64s3gVfwflx1FrH8/WedKBcG7LqOYyhXzh5vvNPHPrBo42G3v
	 l3pCeLTQJ1u3GknWvzHXXLnL9o8kDzHLZUNYE/+45EFJ6gIHvrdMicRSdBVq5SG0Su
	 7ma700nqhVxK3NvueYp3pnXjX/8uuLTa02TqqqnHd4Xaf+KeXaX8+NCohIL8JQ/7GL
	 5nWwk+yAKNFeWbtRnUhruwOczlsXRp2U2C0Z1w2G7S1yEMA7vn4jLbOZWuHCB0QMKE
	 6Y0mUfTXBo7MYkQgYM2cJwMaOipwXy09jGNhePxT0mZ3K6ajONvNqvHQtj+hSn9Hm1
	 oMUXb5HtYIFaA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A35F03F6B0
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Jul 2025 02:22:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m1LuClUr;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566NAPeg024236
	for <op-tee@lists.trustedfirmware.org>; Mon, 7 Jul 2025 02:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T5olA24btRh9/wTg0O38Fij6HpMfGAfuHWI/7YZiKu0=; b=m1LuClUr+NqCKGzm
	iFUR5a1S7wostAqs8oNWjjNK7OmKsKp58eL7Zr1stvy9Hge0ws1nATYlVNX/Qcgk
	hgRBmQyZ6kyZkYf55mRJxhstPPbgHp8Jt/6DVJKVLsn7mxlQMLP4abuyITPDGGMj
	ymp7VmPl01MUv9dKv1swXZ9wT/EkQ4HO0X1UfJVj5Ig6dlcv5n8YtRgFJa7ueDQK
	MfnGlKy1/iZiHh4t8A1IKavhStNwIKPaLjt6tpERfEuMvlsfwBEy53yfIqbl9Axe
	/TeGDFMa7hVKogC8f2+qcPN0Y/zB0TyFBGsSyZoQrTD+8wApQpoJDhIAqys9s064
	CMb69Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvef08yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 07 Jul 2025 02:22:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b3913a15e3fso461387a12.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 06 Jul 2025 19:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751854922; x=1752459722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5olA24btRh9/wTg0O38Fij6HpMfGAfuHWI/7YZiKu0=;
        b=kbrzGR+H/beCfaBWav1Rs9kf91YygevGkKevobFfsq1ZJtL09qdeCjud573nfyGiox
         DI8aXW+utVd93WKXC+yVKsAibByZiGJPe4RuLJRxid+fOsCIUcf3U7Q7iCRyjmlA9tNa
         lBX9by5vqmUynKSAKfw9A91BY3CPk/kaIeL38Yp2mCzxFI9J5eDbIxvZTiPSZ524wxyN
         vmZ+WCxQSiYGJm/PEDA5MOeLLRUaFs5Ws1pcEP1+G9Z88CI82CCazrHQDqV8wf2QLlVi
         kaD9tH9SEl9ESssqWLvhU++kSzHdyWVemxMrh57zUf99Jp1xx4LdbvHWK6a8SKPLJ+2r
         Zzew==
X-Gm-Message-State: AOJu0Ywc23Ur2fMldEr+Zqpx6FkqE0GwT4uuLpeOK61Gxf3bxksL6YX3
	ee9uO2SyItX6gmbhjhNZl7l1wpMfQSx9oPkZzpA1IEjjhB3jHWZ+mGidrAdAJpJq4CeXkAeBvGy
	CHQmmna58W1OBOsoS6sM2qklKyVAoFXYFE7RoDjZa3AJH9VEBtZeXslh01+E0wS/hvT637Pdl0q
	/8VBM=
X-Gm-Gg: ASbGncucldIwhCC1EB6+QfjP8dWImdkdd2DLoBSI4lxiJjTPDQJoNAKuOc997oa0dki
	/YbMHgjL5DmwXc5+HCgAF2D8U7AEZTsTfFMeFRJhw8yWNhjsjnNTIOPSV0d60Jfd0+sewywOjMi
	kTfETxJ3e6efSQ0dozPUDkd215uZsoK2G+n/7vJ5gj5tcS22Ljr4CzSM1Yj+3KKoZyyt+cx5uV0
	KHxW6CXXT7/MWuC6VReIHEP/C3SZX2P0ruTEcVnj3w8w8vucIcJ05QdLTn2u117qTAHmj63EXg5
	HtifeiJU3FG86anbc1EWLG6EJMzcjOScGC0q3TFwvFV9nf5sb4sp/+BcKqXB3yU85rRdJYSAbE4
	HWDHguCCiNbk9nj9kZWaz
X-Received: by 2002:a05:6a20:9190:b0:216:1fc7:5d51 with SMTP id adf61e73a8af0-22724394589mr10684604637.37.1751854922182;
        Sun, 06 Jul 2025 19:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcxYJiAIKlmWrDsNaXDukasvf6AjUCycZIluyuR9dsypV/yKCjCUkPOaJ9cSfv4pzTit8fJw==
X-Received: by 2002:a05:6a20:9190:b0:216:1fc7:5d51 with SMTP id adf61e73a8af0-22724394589mr10684565637.37.1751854921506;
        Sun, 06 Jul 2025 19:22:01 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450ccbsm7576701a12.3.2025.07.06.19.21.59
        for <op-tee@lists.trustedfirmware.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 19:22:01 -0700 (PDT)
Message-ID: <b1a71f06-901e-47fb-9e27-9d401d26f7fc@oss.qualcomm.com>
Date: Mon, 7 Jul 2025 12:21:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/9] tee: implement protected DMA-heap
To: op-tee@lists.trustedfirmware.org
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-4-jens.wiklander@linaro.org>
Content-Language: en-US
In-Reply-To: <20250610131600.2972232-4-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAxMyBTYWx0ZWRfX6Yk/oPqTYcwR
 klpsxJOzxo9mMtjGy7TqtyN3ciuJB0wDkzgnMX8n7vZSNMcnDbKZsrcZRy+mK2dBeEBbLNVYzoH
 z5pbDDK7U+pwRnryDwHady96Na/kfkQjqx7oYFjyaKJcAVTnKiooBsBKkbk8qj47O2VR45ORz9o
 DJLH8GZBiJMb6KB49S21a2mab7jpK+NTVD+mMwTiJsE4MvWOaX1xVrEFrSQJxBnm/OjzNR/agiQ
 UKFub6LkNVvUjC4ojb5ghoo8wP+EV+T1/+c7jdc2LMYee/BhYqk7mJx0WBEIcnaEijs+d04iue1
 85NawQn3kYNcG6vtA3oozE0Cbdbe8RKjlhFBZNJ0cToPbiOJMM4CCATg2nxNiWURyQvQABhw/4Y
 wOVHIZbpJ3fRFy9vutm+1GXQJCEGBW6gpsJPlGygmKiC2rHegj3l9wMbBeOFKE2nSlCjmq/H
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686b2f4b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=_iekhpp1kLB1Z_86-f8A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xDE_-bcyYlsEFFDKtXmmpzGTSZPw3FgG
X-Proofpoint-ORIG-GUID: xDE_-bcyYlsEFFDKtXmmpzGTSZPw3FgG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070013
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A35F03F6B0
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[205.220.180.131:from];
	DNSWL_BLOCKED(0.00)[209.85.215.197:received,1.41.240.65:received];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+]
Message-ID-Hash: QH4C5E6ZG6RAN3DHDPFK6EBPYQYWTX67
X-Message-ID-Hash: QH4C5E6ZG6RAN3DHDPFK6EBPYQYWTX67
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QH4C5E6ZG6RAN3DHDPFK6EBPYQYWTX67/>
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
> Implement DMA heap for protected DMA-buf allocation in the TEE
> subsystem.
> 
> Protected memory refers to memory buffers behind a hardware enforced
> firewall. It is not accessible to the kernel during normal circumstances
> but rather only accessible to certain hardware IPs or CPUs executing in
> higher or differently privileged mode than the kernel itself. This
> interface allows to allocate and manage such protected memory buffers
> via interaction with a TEE implementation.
> 
> The protected memory is allocated for a specific use-case, like Secure
> Video Playback, Trusted UI, or Secure Video Recording where certain
> hardware devices can access the memory.
> 
> The DMA-heaps are enabled explicitly by the TEE backend driver. The TEE
> backend drivers needs to implement protected memory pool to manage the
> protected memory.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/Kconfig       |   5 +
>  drivers/tee/Makefile      |   1 +
>  drivers/tee/tee_heap.c    | 472 ++++++++++++++++++++++++++++++++++++++
>  drivers/tee/tee_private.h |   6 +
>  include/linux/tee_core.h  |  65 ++++++
>  5 files changed, 549 insertions(+)
>  create mode 100644 drivers/tee/tee_heap.c
> 
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index 61b507c18780..90600607a9d8 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -13,6 +13,11 @@ menuconfig TEE
>  
>  if TEE
>  
> +config TEE_DMABUF_HEAPS
> +	bool
> +	depends on HAS_DMA && DMABUF_HEAPS
> +	default y
> +
>  source "drivers/tee/optee/Kconfig"
>  source "drivers/tee/amdtee/Kconfig"
>  source "drivers/tee/tstee/Kconfig"
> diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
> index 5488cba30bd2..949a6a79fb06 100644
> --- a/drivers/tee/Makefile
> +++ b/drivers/tee/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TEE) += tee.o
>  tee-objs += tee_core.o
> +tee-objs += tee_heap.o
>  tee-objs += tee_shm.o
>  tee-objs += tee_shm_pool.o
>  obj-$(CONFIG_OPTEE) += optee/
> diff --git a/drivers/tee/tee_heap.c b/drivers/tee/tee_heap.c
> new file mode 100644
> index 000000000000..7788381a76cb
> --- /dev/null
> +++ b/drivers/tee/tee_heap.c
> @@ -0,0 +1,472 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, Linaro Limited
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <linux/genalloc.h>
> +#include <linux/module.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/tee_core.h>
> +#include <linux/xarray.h>
> +
> +#include "tee_private.h"
> +
> +struct tee_dma_heap {
> +	struct dma_heap *heap;
> +	enum tee_dma_heap_id id;
> +	struct tee_protmem_pool *pool;
> +	struct tee_device *teedev;
> +	/* Protects pool and teedev above */
> +	struct mutex mu;
> +};
> +
> +struct tee_heap_buffer {
> +	struct tee_protmem_pool *pool;
> +	struct tee_device *teedev;
> +	size_t size;
> +	size_t offs;
> +	struct sg_table table;
> +};
> +
> +struct tee_heap_attachment {
> +	struct sg_table table;
> +	struct device *dev;
> +};
> +
> +struct tee_protmem_static_pool {
> +	struct tee_protmem_pool pool;
> +	struct gen_pool *gen_pool;
> +	phys_addr_t pa_base;
> +};
> +
> +#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
> +static DEFINE_XARRAY_ALLOC(tee_dma_heap);
> +
> +static int copy_sg_table(struct sg_table *dst, struct sg_table *src)
> +{
> +	struct scatterlist *dst_sg;
> +	struct scatterlist *src_sg;
> +	int ret;
> +	int i;
> +
> +	ret = sg_alloc_table(dst, src->orig_nents, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	dst_sg = dst->sgl;
> +	for_each_sgtable_sg(src, src_sg, i) {
> +		sg_set_page(dst_sg, sg_page(src_sg), src_sg->length,
> +			    src_sg->offset);
> +		dst_sg = sg_next(dst_sg);
> +	}
> +
> +	return 0;
> +}
> +
> +static int tee_heap_attach(struct dma_buf *dmabuf,
> +			   struct dma_buf_attachment *attachment)
> +{
> +	struct tee_heap_buffer *buf = dmabuf->priv;
> +	struct tee_heap_attachment *a;
> +	int ret;
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	ret = copy_sg_table(&a->table, &buf->table);
> +	if (ret) {
> +		kfree(a);
> +		return ret;
> +	}
> +
> +	a->dev = attachment->dev;
> +	attachment->priv = a;
> +
> +	return 0;
> +}
> +
> +static void tee_heap_detach(struct dma_buf *dmabuf,
> +			    struct dma_buf_attachment *attachment)
> +{
> +	struct tee_heap_attachment *a = attachment->priv;
> +
> +	sg_free_table(&a->table);
> +	kfree(a);
> +}
> +
> +static struct sg_table *
> +tee_heap_map_dma_buf(struct dma_buf_attachment *attachment,
> +		     enum dma_data_direction direction)
> +{
> +	struct tee_heap_attachment *a = attachment->priv;
> +	int ret;
> +
> +	ret = dma_map_sgtable(attachment->dev, &a->table, direction,
> +			      DMA_ATTR_SKIP_CPU_SYNC);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return &a->table;
> +}
> +
> +static void tee_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
> +				   struct sg_table *table,
> +				   enum dma_data_direction direction)
> +{
> +	struct tee_heap_attachment *a = attachment->priv;
> +
> +	WARN_ON(&a->table != table);
> +
> +	dma_unmap_sgtable(attachment->dev, table, direction,
> +			  DMA_ATTR_SKIP_CPU_SYNC);
> +}
> +
> +static void tee_heap_buf_free(struct dma_buf *dmabuf)
> +{
> +	struct tee_heap_buffer *buf = dmabuf->priv;
> +	struct tee_device *teedev = buf->teedev;
> +
> +	buf->pool->ops->free(buf->pool, &buf->table);
> +	tee_device_put(teedev);
> +}
> +
> +static const struct dma_buf_ops tee_heap_buf_ops = {
> +	.attach = tee_heap_attach,
> +	.detach = tee_heap_detach,
> +	.map_dma_buf = tee_heap_map_dma_buf,
> +	.unmap_dma_buf = tee_heap_unmap_dma_buf,
> +	.release = tee_heap_buf_free,
> +};
> +
> +static struct dma_buf *tee_dma_heap_alloc(struct dma_heap *heap,
> +					  unsigned long len, u32 fd_flags,
> +					  u64 heap_flags)
> +{
> +	struct tee_dma_heap *h = dma_heap_get_drvdata(heap);
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct tee_device *teedev = NULL;
> +	struct tee_heap_buffer *buf;
> +	struct tee_protmem_pool *pool;
> +	struct dma_buf *dmabuf;
> +	int rc;
> +
> +	mutex_lock(&h->mu);
> +	if (tee_device_get(h->teedev)) {
> +		teedev = h->teedev;
> +		pool = h->pool;
> +	}
> +	mutex_unlock(&h->mu);
> +
> +	if (!teedev)
> +		return ERR_PTR(-EINVAL);
> +
> +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> +	if (!buf) {
> +		dmabuf = ERR_PTR(-ENOMEM);
> +		goto err;
> +	}
> +	buf->size = len;
> +	buf->pool = pool;
> +	buf->teedev = teedev;
> +
> +	rc = pool->ops->alloc(pool, &buf->table, len, &buf->offs);
> +	if (rc) {
> +		dmabuf = ERR_PTR(rc);
> +		goto err_kfree;
> +	}
> +
> +	exp_info.ops = &tee_heap_buf_ops;
> +	exp_info.size = len;
> +	exp_info.priv = buf;
> +	exp_info.flags = fd_flags;
> +	dmabuf = dma_buf_export(&exp_info);
> +	if (IS_ERR(dmabuf))
> +		goto err_protmem_free;
> +
> +	return dmabuf;
> +
> +err_protmem_free:
> +	pool->ops->free(pool, &buf->table);
> +err_kfree:
> +	kfree(buf);
> +err:
> +	tee_device_put(h->teedev);
> +	return dmabuf;
> +}
> +
> +static const struct dma_heap_ops tee_dma_heap_ops = {
> +	.allocate = tee_dma_heap_alloc,
> +};
> +
> +static const char *heap_id_2_name(enum tee_dma_heap_id id)
> +{
> +	switch (id) {
> +	case TEE_DMA_HEAP_SECURE_VIDEO_PLAY:
> +		return "protected,secure-video";
> +	case TEE_DMA_HEAP_TRUSTED_UI:
> +		return "protected,trusted-ui";
> +	case TEE_DMA_HEAP_SECURE_VIDEO_RECORD:
> +		return "protected,secure-video-record";
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static int alloc_dma_heap(struct tee_device *teedev, enum tee_dma_heap_id id,
> +			  struct tee_protmem_pool *pool)
> +{
> +	struct dma_heap_export_info exp_info = {
> +		.ops = &tee_dma_heap_ops,
> +		.name = heap_id_2_name(id),
> +	};
> +	struct tee_dma_heap *h;
> +	int rc;
> +
> +	if (!exp_info.name)
> +		return -EINVAL;
> +
> +	if (xa_reserve(&tee_dma_heap, id, GFP_KERNEL)) {
> +		if (!xa_load(&tee_dma_heap, id))
> +			return -EEXIST;
> +		return -ENOMEM;
> +	}
> +
> +	h = kzalloc(sizeof(*h), GFP_KERNEL);
> +	if (!h)
> +		return -ENOMEM;
> +	h->id = id;
> +	h->teedev = teedev;
> +	h->pool = pool;
> +	mutex_init(&h->mu);
> +
> +	exp_info.priv = h;
> +	h->heap = dma_heap_add(&exp_info);
> +	if (IS_ERR(h->heap)) {
> +		rc = PTR_ERR(h->heap);
> +		kfree(h);
> +
> +		return rc;
> +	}
> +
> +	/* "can't fail" due to the call to xa_reserve() above */
> +	return WARN_ON(xa_is_err(xa_store(&tee_dma_heap, id, h, GFP_KERNEL)));
> +}
> +
> +int tee_device_register_dma_heap(struct tee_device *teedev,
> +				 enum tee_dma_heap_id id,
> +				 struct tee_protmem_pool *pool)
> +{
> +	struct tee_dma_heap *h;
> +	int rc;
> +
> +	h = xa_load(&tee_dma_heap, id);
> +	if (h) {
> +		mutex_lock(&h->mu);
> +		if (h->teedev) {
> +			rc = -EBUSY;
> +		} else {
> +			h->teedev = teedev;
> +			h->pool = pool;
> +			rc = 0;
> +		}
> +		mutex_unlock(&h->mu);
> +	} else {
> +		rc = alloc_dma_heap(teedev, id, pool);
> +	}
> +
> +	if (rc)
> +		dev_err(&teedev->dev, "can't register DMA heap id %d (%s)\n",
> +			id, heap_id_2_name(id));
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tee_device_register_dma_heap);
> +

I'm having a bit of trouble understanding the rationale behind
supporting tee_device_unregister_all_dma_heaps(). Considering that
the heap remains accessible from userspace, wouldn't this lead
to undefined behavior? For example, what happens if a user is
in the middle of a tee_dma_heap_alloc() -- specifically before
tee_device_get() -- while the backend calls tee_device_unregister_all_dma_heaps()?

I understand that you want to use teedev refcount to protect against
the TEE driver unbinding if there is a buffer allocated. But what about
the heap device?

Additionally, what if the user decides to unbind the TEE backend driver?
Would the dma_heap device still persist without any alloc function?

In the case of qcomtee, my original idea was to have two separate
drivers loaded alongside each other. This setup would allow the
TEE backend driver to support unbinding, while the protected memory
backend could remain loaded. This separation is particularly useful
for FFA, or scenarios where the protected buffer does not need to be
transfered to TEE.

Or

A reference to teedev could be obtained when the heap is registered,
rather than for each buffer allocation. In other words, once the heap
is registered, the backend must remain active and cannot be unloaded.

Or

Find a way to have something like dma_heap_rm()?

Please let me know if I mis-understood something? or missing something :)

Regards,
Amir

> +void tee_device_unregister_all_dma_heaps(struct tee_device *teedev)
> +{
> +	struct tee_protmem_pool *pool;
> +	struct tee_dma_heap *h;
> +	u_long i;
> +
> +	xa_for_each(&tee_dma_heap, i, h) {
> +		if (h) {
> +			pool = NULL;
> +			mutex_lock(&h->mu);
> +			if (h->teedev == teedev) {
> +				pool = h->pool;
> +				h->teedev = NULL;
> +				h->pool = NULL;
> +			}
> +			mutex_unlock(&h->mu);
> +			if (pool)
> +				pool->ops->destroy_pool(pool);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
> +
> +int tee_heap_update_from_dma_buf(struct tee_device *teedev,
> +				 struct dma_buf *dmabuf, size_t *offset,
> +				 struct tee_shm *shm,
> +				 struct tee_shm **parent_shm)
> +{
> +	struct tee_heap_buffer *buf;
> +	int rc;
> +
> +	/* The DMA-buf must be from our heap */
> +	if (dmabuf->ops != &tee_heap_buf_ops)
> +		return -EINVAL;
> +
> +	buf = dmabuf->priv;
> +	/* The buffer must be from the same teedev */
> +	if (buf->teedev != teedev)
> +		return -EINVAL;
> +
> +	shm->size = buf->size;
> +
> +	rc = buf->pool->ops->update_shm(buf->pool, &buf->table, buf->offs, shm,
> +					parent_shm);
> +	if (!rc && *parent_shm)
> +		*offset = buf->offs;
> +
> +	return rc;
> +}
> +#else
> +int tee_device_register_dma_heap(struct tee_device *teedev __always_unused,
> +				 enum tee_dma_heap_id id __always_unused,
> +				 struct tee_protmem_pool *pool __always_unused)
> +{
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(tee_device_register_dma_heap);
> +
> +void
> +tee_device_unregister_all_dma_heaps(struct tee_device *teedev __always_unused)
> +{
> +}
> +EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
> +
> +int tee_heap_update_from_dma_buf(struct tee_device *teedev __always_unused,
> +				 struct dma_buf *dmabuf __always_unused,
> +				 size_t *offset __always_unused,
> +				 struct tee_shm *shm __always_unused,
> +				 struct tee_shm **parent_shm __always_unused)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +static struct tee_protmem_static_pool *
> +to_protmem_static_pool(struct tee_protmem_pool *pool)
> +{
> +	return container_of(pool, struct tee_protmem_static_pool, pool);
> +}
> +
> +static int protmem_pool_op_static_alloc(struct tee_protmem_pool *pool,
> +					struct sg_table *sgt, size_t size,
> +					size_t *offs)
> +{
> +	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
> +	phys_addr_t pa;
> +	int ret;
> +
> +	pa = gen_pool_alloc(stp->gen_pool, size);
> +	if (!pa)
> +		return -ENOMEM;
> +
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (ret) {
> +		gen_pool_free(stp->gen_pool, pa, size);
> +		return ret;
> +	}
> +
> +	sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);
> +	*offs = pa - stp->pa_base;
> +
> +	return 0;
> +}
> +
> +static void protmem_pool_op_static_free(struct tee_protmem_pool *pool,
> +					struct sg_table *sgt)
> +{
> +	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sgtable_sg(sgt, sg, i)
> +		gen_pool_free(stp->gen_pool, sg_phys(sg), sg->length);
> +	sg_free_table(sgt);
> +}
> +
> +static int protmem_pool_op_static_update_shm(struct tee_protmem_pool *pool,
> +					     struct sg_table *sgt, size_t offs,
> +					     struct tee_shm *shm,
> +					     struct tee_shm **parent_shm)
> +{
> +	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
> +
> +	shm->paddr = stp->pa_base + offs;
> +	*parent_shm = NULL;
> +
> +	return 0;
> +}
> +
> +static void protmem_pool_op_static_destroy_pool(struct tee_protmem_pool *pool)
> +{
> +	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
> +
> +	gen_pool_destroy(stp->gen_pool);
> +	kfree(stp);
> +}
> +
> +static struct tee_protmem_pool_ops protmem_pool_ops_static = {
> +	.alloc = protmem_pool_op_static_alloc,
> +	.free = protmem_pool_op_static_free,
> +	.update_shm = protmem_pool_op_static_update_shm,
> +	.destroy_pool = protmem_pool_op_static_destroy_pool,
> +};
> +
> +struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t paddr,
> +						       size_t size)
> +{
> +	const size_t page_mask = PAGE_SIZE - 1;
> +	struct tee_protmem_static_pool *stp;
> +	int rc;
> +
> +	/* Check it's page aligned */
> +	if ((paddr | size) & page_mask)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!pfn_valid(PHYS_PFN(paddr)))
> +		return ERR_PTR(-EINVAL);
> +
> +	stp = kzalloc(sizeof(*stp), GFP_KERNEL);
> +	if (!stp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	stp->gen_pool = gen_pool_create(PAGE_SHIFT, -1);
> +	if (!stp->gen_pool) {
> +		rc = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	rc = gen_pool_add(stp->gen_pool, paddr, size, -1);
> +	if (rc)
> +		goto err_free_pool;
> +
> +	stp->pool.ops = &protmem_pool_ops_static;
> +	stp->pa_base = paddr;
> +	return &stp->pool;
> +
> +err_free_pool:
> +	gen_pool_destroy(stp->gen_pool);
> +err_free:
> +	kfree(stp);
> +
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_GPL(tee_protmem_static_pool_alloc);
> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> index 9bc50605227c..6c6ff5d5eed2 100644
> --- a/drivers/tee/tee_private.h
> +++ b/drivers/tee/tee_private.h
> @@ -8,6 +8,7 @@
>  #include <linux/cdev.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
> +#include <linux/dma-buf.h>
>  #include <linux/kref.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
> @@ -24,4 +25,9 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>  					  unsigned long addr, size_t length);
>  
> +int tee_heap_update_from_dma_buf(struct tee_device *teedev,
> +				 struct dma_buf *dmabuf, size_t *offset,
> +				 struct tee_shm *shm,
> +				 struct tee_shm **parent_shm);
> +
>  #endif /*TEE_PRIVATE_H*/
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index a38494d6b5f4..22e03d897dc3 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -8,9 +8,11 @@
>  
>  #include <linux/cdev.h>
>  #include <linux/device.h>
> +#include <linux/dma-buf.h>
>  #include <linux/idr.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> +#include <linux/scatterlist.h>
>  #include <linux/tee.h>
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
> @@ -30,6 +32,12 @@
>  #define TEE_DEVICE_FLAG_REGISTERED	0x1
>  #define TEE_MAX_DEV_NAME_LEN		32
>  
> +enum tee_dma_heap_id {
> +	TEE_DMA_HEAP_SECURE_VIDEO_PLAY = 1,
> +	TEE_DMA_HEAP_TRUSTED_UI,
> +	TEE_DMA_HEAP_SECURE_VIDEO_RECORD,
> +};
> +
>  /**
>   * struct tee_device - TEE Device representation
>   * @name:	name of device
> @@ -116,6 +124,36 @@ struct tee_desc {
>  	u32 flags;
>  };
>  
> +/**
> + * struct tee_protmem_pool - protected memory pool
> + * @ops:		operations
> + *
> + * This is an abstract interface where this struct is expected to be
> + * embedded in another struct specific to the implementation.
> + */
> +struct tee_protmem_pool {
> +	const struct tee_protmem_pool_ops *ops;
> +};
> +
> +/**
> + * struct tee_protmem_pool_ops - protected memory pool operations
> + * @alloc:		called when allocating protected memory
> + * @free:		called when freeing protected memory
> + * @update_shm:		called when registering a dma-buf to update the @shm
> + *			with physical address of the buffer or to return the
> + *			@parent_shm of the memory pool
> + * @destroy_pool:	called when destroying the pool
> + */
> +struct tee_protmem_pool_ops {
> +	int (*alloc)(struct tee_protmem_pool *pool, struct sg_table *sgt,
> +		     size_t size, size_t *offs);
> +	void (*free)(struct tee_protmem_pool *pool, struct sg_table *sgt);
> +	int (*update_shm)(struct tee_protmem_pool *pool, struct sg_table *sgt,
> +			  size_t offs, struct tee_shm *shm,
> +			  struct tee_shm **parent_shm);
> +	void (*destroy_pool)(struct tee_protmem_pool *pool);
> +};
> +
>  /**
>   * tee_device_alloc() - Allocate a new struct tee_device instance
>   * @teedesc:	Descriptor for this driver
> @@ -154,6 +192,11 @@ int tee_device_register(struct tee_device *teedev);
>   */
>  void tee_device_unregister(struct tee_device *teedev);
>  
> +int tee_device_register_dma_heap(struct tee_device *teedev,
> +				 enum tee_dma_heap_id id,
> +				 struct tee_protmem_pool *pool);
> +void tee_device_unregister_all_dma_heaps(struct tee_device *teedev);
> +
>  /**
>   * tee_device_set_dev_groups() - Set device attribute groups
>   * @teedev:	Device to register
> @@ -229,6 +272,28 @@ static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
>  	pool->ops->destroy_pool(pool);
>  }
>  
> +/**
> + * tee_protmem_static_pool_alloc() - Create a protected memory manager
> + * @paddr:	Physical address of start of pool
> + * @size:	Size in bytes of the pool
> + *
> + * @returns pointer to a 'struct tee_protmem_pool' or an ERR_PTR on failure.
> + */
> +struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t paddr,
> +						       size_t size);
> +
> +/**
> + * tee_protmem_pool_free() - Free a protected memory pool
> + * @pool:	The protected memory pool to free
> + *
> + * There must be no remaining protected memory allocated from this pool
> + * when this function is called.
> + */
> +static inline void tee_protmem_pool_free(struct tee_protmem_pool *pool)
> +{
> +	pool->ops->destroy_pool(pool);
> +}
> +
>  /**
>   * tee_get_drvdata() - Return driver_data pointer
>   * @returns the driver_data pointer supplied to tee_register().

