Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C845606A31A
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=aB3iHsvg;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nc2TihsH;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NUkpRmrB
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C65B2451B5
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792617329;
	bh=tq6BzsJoKxz3oNaDQPH1Dw4GgDGhQdCD+RYmXl8uXOQ=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=aB3iHsvgdONHt6C6v5Ndko6XJU9Rr/bWfuGcXGre6Xy76UVpBN1MKT6F3nUXJ5Hss
	 raSE1ZbtA2iflP0qSIZAqCMQq4MDW0rKoWODkZm9uIwZ0coHsAtDII/ofx/kO4ytYD
	 rN+GGuvUo/7uJPnGIonyTibdUq14ImkU68xLbwyq7o2L7bW8maGK1E+IQzofXSVeAb
	 9dr24dPo4WEWjvqjj1XeXu5SfbL8tjAa0sKrx788jHQDrXOO/1TbMcAmX16VVJle/5
	 BwNuQMdsuwcnveODVkJ9PWGuFGXs7JWjG/LBXsgRW5pIKss8rPcVGC8kxscldrv5Ze
	 ZLXCN0Oe3RCiw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7DE6444A25
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 21:15:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nc2TihsH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NUkpRmrB;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LKfrxS1157501
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 21:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QE0XwmxxYjyh72q5hRFKajNE0rpJOhIYUg/y5GFoYyY=; b=Nc2TihsHmmQu++9i
	ZyuB/etfWO9U6CbJ8XVCh9ArX/7OZG0+NyqE+tCIHSbZ+cH7JqF+zEqF+5RHaFar
	0N1OS7SWijfwJEnnd8HbNlwP4biTfFxrEF2lr5tt5DI3E+NMWlazrBahJdE7+x/N
	YOxNbhSWM0pJ7K5kA7gMB42byh8TNhdRYSeYFNdjL6pK3RXTUwNB8xO/ifSsqqiG
	BIS/7pe70WuD9LtF+6MWQ8YWtUgEjtAae1+QWYrnJqKWXXI0Sf+08CHRTX+5Zj7/
	gcxFmAAQBDqhmF6nm4bBHFosdDqL6i+l1cRF2Lv+2DZuB+eHDnpLhy2+rsFuzW3l
	3d2GYg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv18bb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 21:15:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36696c9f55bso240100eec.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792617307; x=1793222107; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QE0XwmxxYjyh72q5hRFKajNE0rpJOhIYUg/y5GFoYyY=;
        b=NUkpRmrBTyf6P86kXMvruRkynvTrasuK/lOOZbPH8Pj9lyeObQbnmualS8HHFmIJTR
         +W6Cc89v1XFvaNeuwwHhzuw3c4Vzi+dy4wvRZstmBROu9MYIm6Jq+M29keipzcj2WUjW
         ziWxK1zuQisuFqWy3N2LdcDMEkki2Wzz7BrsTSb5Jjv0EPntWz8cFrj0G6ahSmyHUcZE
         M5hJnm9MEIeWyN3SR/JXNnQRA+ngEu03KEHvpsvBxaFsZEXXl6+mUUoIEwf1rCYKdrID
         5emCA3HGQyx6JbCuvZOghSanAdDY9skC6shNNqRJFxKSYEzir6sZ18VqQpEcJt+diYkj
         mDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617307; x=1793222107;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QE0XwmxxYjyh72q5hRFKajNE0rpJOhIYUg/y5GFoYyY=;
        b=CRZikeF/Mn/TYLCRuSVpr2xJsYq4efo1ruXFD8tdpuc1fIxu83XJV/SDJCiEIpsGNO
         pmXCBhND7NgW9iX6PdNvPUsgejh0MugHOLpLgA/YPF9CClbPxQh3x8HCL5JGXl+98vT/
         QOA2S+N9unHiTvkO7hMMGxxbn3khFXmp6qVBkOWoDDLATO1wc9rAoaP3FDr5oOcfmvds
         C3Z0vArhPSioDYseHG/gWtiohd0hLU+ugXov6WHGcpC0Bpg/W9DRfqNevDLIAOC37yPj
         /2PZLOvTVgjtCjJL6DS7c78jMGDIECiJkt9m/Wrd0B06vi15OINr9bBYvq1AdsJ7E9RO
         YZoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZ0E3GxFuwllgeIsAZwpdWvlrVH5JV2xPjsDLlQeQeh/0Q0wHU62AzWwm6vR6A7nKz1CQNOEc=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLmct6O8HiJ2/5dHNWskSSjmZNQrj5l9qo0cJoMXVlHOibJ4QiQ
	NTqSxs3WsC7WK/HtzmuKI5WPTcmb+fhej62hJotNyVZUpr98qVgh+AhQ4+7M6RyapoyILP4Vmp8
	Yua9yPWdZ1u/dcsL5KA3YeikJa3cI141dDUyYGgiTcyQYmIX+N0PPi6/VbNhTBbSqwTfCUYA=
X-Gm-Gg: AYBFou3hzMNfiHMl5Tx5mimwsfmjpLuDuOvcaIlovFp+vSE+ejlx2E8RFiUA9YFWC9a
	HbzXx5nnd1tQxAtdt7srAIFT1HEXP3+BVbLukjxL8K4m+gS5KVfcJjOQ8p7pPesKPyjXE+Fs6Ab
	Xgj6Qb35mpnSLEy8VfeYBgGj7rOPBEuhry3uqC8ZwUjcPDFY8b/shsTOjDTuSZufuviAlq7VxiI
	cDbg/E7N9CslvZjAyLvvEFvYrAF1Xirb6AFdlMEuHvUbm2p+LyPtD+VLtO7NwSQYeH0S32yvZS7
	KphXvSseDvj64tQU/pfBmD89yFVNg9GMO55AQGe1xnTnA/x3h2dcz2DcHHa8ffdedhqMSy7cWYe
	964m7fgMWLpCbedlqh+4THgMRzIcyv3s=
X-Received: by 2002:a05:7301:5f0b:b0:359:27e6:b684 with SMTP id 5a478bee46e88-368adfddd63mr583219eec.3.1792617306848;
        Wed, 21 Oct 2026 14:15:06 -0700 (PDT)
X-Received: by 2002:a05:7301:5f0b:b0:359:27e6:b684 with SMTP id 5a478bee46e88-368adfddd63mr583185eec.3.1792617306025;
        Wed, 21 Oct 2026 14:15:06 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.13.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8439sm10631970eec.11.2026.10.21.14.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 14:15:05 -0700 (PDT)
Message-ID: <672d7be2-072d-424a-80f7-025c70440b08@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 08:14:59 +1100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] tpm: Introduce Qualcomm TPM driver
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <20261019-tpm_qcom_driver-v4-2-6889b9804ba7@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019-tpm_qcom_driver-v4-2-6889b9804ba7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad92b5b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=DFNpOA17G2bluAzxCnbuxw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=uY2erOa96md1tqpinVYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: wi0sRg30jhgkeYr2qN6ffYHCWRaCbXM5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4NCBTYWx0ZWRfXzhzw6OdHixSX
 QavZhukXa2r7g7J5VG6opAcEOJzQWVUTN1v64ykvFAPtDwDDOzc3nVfYM93ElQICy2Ns6flA/xb
 NzWcsJa36pYF/e5JQNY+j8GBBTOaHtw=
X-Proofpoint-GUID: wi0sRg30jhgkeYr2qN6ffYHCWRaCbXM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4NCBTYWx0ZWRfXxJn4u2okraxi
 WWAE6XR/f17LlEEvj6TgEX+0n//XNpe7LScybtbEUcJkB/i9dn4VNj1uWXjyk9cPQ8LpgQgA54d
 yBeDBRDyd5twBmxyjHVraR7iULXyh34mql2rNbNHa0UH72miMo/kX02mzmRp5zq7UgfMMI/5Eap
 2VkV+FyuTZc7MwJdLSGHas08IJuySTusEBJsOSy9DuSVSe+2jux7hYs8Hil01UogaYKJJZdyEka
 KgXfgOfdf8oIEwhAywEWf3HnYRfOnym/5ZipdWz8grXBNq6D7v1Vlt1i36z2oRxy5fgSAuyb+OD
 1HbkMEDPBPBLVwpPoRqEWZtMmvkRsIn/ZeBW53VTUCrKj1y0qDu7ptmN4L98TJ2rQ71KeFjO5W7
 N6R39KXR3Ad/kNWi96DPjsi5BNlC8gtzqarlrHQzTsgWgU3AAMO1EG6DfGT8wa4cZo/BEn6q3LM
 qE17hR4qJyDgGRamWPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210084
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7DE6444A25
X-Spamd-Bar: ------
Message-ID-Hash: TP53AJZXIHXWEXFYVOYPKKRC5TE7TCI7
X-Message-ID-Hash: TP53AJZXIHXWEXFYVOYPKKRC5TE7TCI7
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TP53AJZXIHXWEXFYVOYPKKRC5TE7TCI7/>
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

Hi Kuldeep,

On 10/19/2026 8:21 PM, Kuldeep Singh wrote:
> Add a TPM chip driver for platforms where a TPM 2.0 instance is
> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
> transport.
> 
> The driver discovers the qcom.tz.tpm TEE-bus device, opens a session
> with the TPM TA, and register with tpm interface. This exposes the TA
> through the standard /dev/tpm interface and the existing tpm2 command
> layer. OS need not be aware underlying TPM instance is dTPM or fTPM.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  drivers/char/tpm/Kconfig    |   9 +
>  drivers/char/tpm/Makefile   |   1 +
>  drivers/char/tpm/tpm_qcom.c | 414 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 424 insertions(+)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 5f672f2c01b0..05d704ed3632 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -243,6 +243,15 @@ config TCG_FTPM_TEE
>  	help
>  	  This driver proxies for firmware TPM running in TEE.
>  
> +config TCG_QCOM
> +	tristate "Qualcomm TEE based TPM Interface"
> +	depends on QCOMTEE
> +	help
> +	  This driver provides interface to run TPM instances with Trustzone
> +	  having Qualcomm TPM TA running in Qualcomm TEE.
> +	  The mechanism uses the object-IPC based transport provided by
> +	  QCOMTEE.
> +
>  config TCG_SVSM
>  	tristate "SNP SVSM vTPM interface"
>  	depends on AMD_MEM_ENCRYPT
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 5b5cdc0d32e4..471cbf49afd2 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -45,5 +45,6 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_QCOM) += tpm_qcom.o
>  obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>  obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> diff --git a/drivers/char/tpm/tpm_qcom.c b/drivers/char/tpm/tpm_qcom.c
> new file mode 100644
> index 000000000000..e9e4746f0004
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_qcom.c
> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/tpm.h>
> +#include <linux/uuid.h>
> +
> +#include "tpm.h"
> +
> +#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS	5
> +#define QCOMTEE_OP_CLIENT_ENV_OPEN		0
> +#define QCOMTEE_MSG_OBJECT_OP_MASK		GENMASK(15, 0)
> +#define QCOMTEE_MSG_OBJECT_OP_RELEASE		(QCOMTEE_MSG_OBJECT_OP_MASK - 0)
> +
> +#define QCOMTEE_TPM_OP_SEND_COMMAND	0
> +
> +/* UID of the "qcom.tz.tpm" service */
> +#define QCOMTEE_TPM_UID			81
> +
> +/* Max buffer size supported by TPM TA */
> +#define TPM_QCOM_MAX_COMMAND_SIZE	SZ_4K
> +#define TPM_QCOM_MAX_RESPONSE_SIZE	SZ_4K
> +

I also mentioned it in V2, why using different naming convention across different macros.
Why not QCOMTEE_TPM_MAX_COMMAND_SIZE?

> +#define QCOMTEE_TPM_GET_TA_VERSION_ID	0x0001000

nipik: For constant either use 0x00001000 or 0x1000. not 28-bit.
Why not U like others just for consistency.

> +#define QCOMTEE_TPM_TA_VERSION_MAJOR	GENMASK(31, 16)
> +#define QCOMTEE_TPM_TA_VERSION_MINOR	GENMASK(15, 0)
> +
> +struct tpm_qcom_ta_version_req {
> +	u32 command_id;
> +} __packed;
> +
> +struct tpm_qcom_ta_version_resp {
> +	u32 status;
> +	u32 command_id;
> +	u32 version_num;
> +} __packed;
> +
> +#define QCOMTEE_TPM_TYPE_ID		0x0080000
> +#define QCOMTEE_TPM_TYPE_DTPM		0x6454504dU
> +#define QCOMTEE_TPM_TYPE_FTPM		0x6654504dU
> +#define QCOMTEE_TPM_TYPE_NONE		0x4e6f6e65U

This is an unused macro.

> +
> +struct tpm_qcom_type_req {
> +	u32 command_id;
> +} __packed;
> +
> +struct tpm_qcom_type_resp {
> +	u32 command_id;
> +	u32 status;
> +	u32 tpm_type;
> +} __packed;
> +
> +/*
> + * dTPM SPI transfer optimization:
> + * TRANSFER_START before a burst of commands, TRANSFER_END once done.
> + */
> +#define QCOMTEE_TPM_TRANSFER_ID		0x0000002
> +#define QCOMTEE_TPM_TRANSFER_END	0
> +#define QCOMTEE_TPM_TRANSFER_START	1
> +
> +struct tpm_qcom_transfer_req {
> +	u32 command_id;
> +	u32 transfer_state;
> +} __packed;
> +
> +struct tpm_qcom_transfer_resp {
> +	u32 command_id;
> +	u32 status;
> +} __packed;
> +
> +struct tpm_qcom_private {
> +	struct tpm_chip *chip;
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	struct tee_param_objref tpm_svc_obj;
> +	bool is_dtpm;
> +};
> +
> +/* UUID of the QTEE-bus device representing the TPM TA. */
> +static const uuid_t tpm_qcom_uuid =
> +	UUID_INIT(0xaabcb593, 0x7083, 0x5536,
> +		  0xac, 0x27, 0x3d, 0x2d, 0x89, 0x41, 0x9d, 0xdb);
> +
> +static void tpm_qcom_release_object(struct tee_context *ctx,
> +				    struct tee_param_objref object)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +
> +	inv_arg.id = object.id;
> +	inv_arg.op = QCOMTEE_MSG_OBJECT_OP_RELEASE;
> +	inv_arg.num_params = 0;
> +
> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
> +}
> +
> +static int tpm_qcom_get_client_env_obj(struct device *dev,
> +				       struct tee_context *ctx,
> +				       struct tee_param_objref *client_env_obj)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +	struct tee_param param[2] = {};
> +	int ret;
> +
> +	inv_arg.id = TEE_OBJREF_NULL;
> +	inv_arg.op = QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS;
> +	inv_arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT;
> +	param[0].u.objref.id = TEE_OBJREF_NULL;
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "get client env obj failed: ret=%d, invoke_ret=0x%x\n",
> +			ret, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	*client_env_obj = param[1].u.objref;
> +	return 0;
> +}
> +
> +static int tpm_qcom_get_svc_obj(struct device *dev,
> +				struct tee_context *ctx,
> +				struct tee_param_objref client_env_obj,
> +				struct tee_param_objref *tpm_svc_obj)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +	struct tee_param param[2] = {};
> +	u32 tpm_uid = QCOMTEE_TPM_UID;
> +	int ret;
> +
> +	inv_arg.id = client_env_obj.id;
> +	inv_arg.op = QCOMTEE_OP_CLIENT_ENV_OPEN;
> +	inv_arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &tpm_uid,
> +						    .size = sizeof(tpm_uid) };
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "get TPM service obj failed: ret=%d, invoke_ret=0x%x\n",
> +			ret, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	*tpm_svc_obj = param[1].u.objref;
> +	return 0;
> +}
> +
> +static int tpm_qcom_send_command(struct tpm_qcom_private *pvt_data,
> +				 void *req, size_t req_len, void *resp,
> +				 size_t *resp_len)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +	struct tee_param param[3] = {};
> +	u8 locality_arg = 0;
> +	int ret;
> +
> +	inv_arg.id = pvt_data->tpm_svc_obj.id;
> +	inv_arg.op = QCOMTEE_TPM_OP_SEND_COMMAND;
> +	inv_arg.num_params = 3;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &locality_arg,
> +						   .size = sizeof(locality_arg) };
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[1].u.ubuf = (struct tee_param_ubuf){ .addr = req, .size = req_len };
> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT;
> +	param[2].u.ubuf = (struct tee_param_ubuf){ .addr = resp, .size = *resp_len };
> +
> +	ret = tee_client_object_invoke_func(pvt_data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(pvt_data->dev,
> +			"send_command invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	*resp_len = param[2].u.ubuf.size;
> +
> +	return 0;
> +}
> +
> +static int tpm_qcom_get_ta_details(struct tpm_qcom_private *pvt_data)
> +{
> +	struct tpm_qcom_ta_version_req ver_req = {
> +		.command_id = QCOMTEE_TPM_GET_TA_VERSION_ID,
> +	};
> +	struct tpm_qcom_ta_version_resp ver_resp;
> +	size_t resp_len = sizeof(ver_resp);
> +	struct tpm_qcom_type_req type_req = {
> +		.command_id = QCOMTEE_TPM_TYPE_ID,
> +	};
> +	struct tpm_qcom_type_resp type_resp;
> +	int ret;
> +
> +	ret = tpm_qcom_send_command(pvt_data, &ver_req, sizeof(ver_req),
> +				    &ver_resp, &resp_len);
> +	if (ret < 0 || resp_len < sizeof(ver_resp) || ver_resp.status != 0)
> +		return ret ?: -EIO;
> +
> +	dev_info(pvt_data->dev, "TPM TA version %u.%u\n",
> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MAJOR, ver_resp.version_num),
> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MINOR, ver_resp.version_num));
> +

Just to confirm, Are you sure this does not produce compile time warning. Check it.
I belive GENMASK generate "unsigned long" and %u is not correct?

> +	resp_len = sizeof(type_resp);
> +	ret = tpm_qcom_send_command(pvt_data, &type_req, sizeof(type_req),
> +				    &type_resp, &resp_len);
> +	if (ret < 0 || resp_len < sizeof(type_resp) || type_resp.status != 0)
> +		return ret ?: -EIO;
> +
> +	switch (type_resp.tpm_type) {
> +	case QCOMTEE_TPM_TYPE_FTPM:
> +		dev_info(pvt_data->dev, "TPM type: fTPM\n");
> +		pvt_data->is_dtpm = false;
> +		break;
> +	case QCOMTEE_TPM_TYPE_DTPM:
> +		dev_info(pvt_data->dev, "TPM type: dTPM\n");
> +		pvt_data->is_dtpm = true;
> +		break;
> +	default:
> +		dev_err(pvt_data->dev, "unsupported TPM type: 0x%08x\n",
> +			type_resp.tpm_type);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/* fTPM does not implement this command and to be invoked via dtpm only. */
> +static void tpm_qcom_transfer(struct tpm_qcom_private *pvt_data,
> +			      u32 transfer_state)
> +{
> +	struct tpm_qcom_transfer_req req = {
> +		.command_id = QCOMTEE_TPM_TRANSFER_ID,
> +		.transfer_state = transfer_state,
> +	};
> +	struct tpm_qcom_transfer_resp resp;
> +	size_t resp_len = sizeof(resp);
> +
> +	tpm_qcom_send_command(pvt_data, &req, sizeof(req), &resp, &resp_len);
> +}
> +
> +static int tpm_qcom_cmd_ready(struct tpm_chip *chip)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +
> +	if (pvt_data->is_dtpm)
> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_START);
> +
> +	return 0;
> +}
> +
> +static int tpm_qcom_go_idle(struct tpm_chip *chip)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +
> +	if (pvt_data->is_dtpm)
> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_END);
> +
> +	return 0;
> +}
> +
> +/*
> + * The raw TPM2 command in @buf is sent directly as send_command's UBUF-in
> + * param and the raw TPM2 response is read back from its UBUF-out param.
> + */
> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> +			 size_t cmd_len)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +	struct tpm_header *header = (struct tpm_header *)buf;
> +	size_t resp_len = PAGE_ALIGN(TPM_QCOM_MAX_RESPONSE_SIZE);

Why PAGE_ALIGN? Why not using TPM_QCOM_MAX_RESPONSE_SIZE directly?
In 16K page, it increases the size to 16K, is it what you want?


> +	size_t copy_len;
> +	int ret;
> +
> +	if (cmd_len > TPM_QCOM_MAX_COMMAND_SIZE) {
> +		dev_err(&chip->dev, "len=%zd exceeds TPM_QCOM_MAX_COMMAND_SIZE\n",
> +			cmd_len);
> +		return -EIO;
> +	}
> +
> +	u8 *response __free(kfree) = kzalloc(resp_len, GFP_KERNEL);
> +	if (!response)
> +		return -ENOMEM;
> +
> +	ret = tpm_qcom_send_command(pvt_data, buf, cmd_len, response, &resp_len);
> +	if (ret < 0) {
> +		dev_err(&chip->dev, "TPM command failed: cmd_len=%zu, tpm_cc=0x%08x, ret:%d\n",
> +			cmd_len, be32_to_cpu(header->ordinal), ret);
> +		return ret;
> +	}
> +
> +	copy_len = min_t(size_t, bufsiz, resp_len);

Does this min_t means the result turncation and discarding is acceptable!?
Should not we do the min_t at the allocation time:

size_t resp_len = min_t(TPM_QCOM_MAX_RESPONSE_SIZE, bufsiz);


> +	memcpy(buf, response, copy_len);
> +
> +	return copy_len;
> +}
> +
> +static const struct tpm_class_ops tpm_qcom_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.send = tpm_qcom_send,
> +	.cmd_ready = tpm_qcom_cmd_ready,
> +	.go_idle = tpm_qcom_go_idle,
> +};
> +
> +static int tpm_qcom_ctx_match(struct tee_ioctl_version_data *ver,
> +			      const void *data)
> +{
> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
> +}
> +
> +static int tpm_qcom_probe(struct tee_client_device *tee_dev)
> +{
> +	struct device *dev = &tee_dev->dev;
> +	struct tpm_qcom_private *pvt_data;
> +	struct tee_param_objref client_env_obj;
> +	struct tee_param_objref tpm_svc_obj;
> +	struct tpm_chip *chip;
> +	int err;
> +
> +	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
> +	if (!pvt_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, pvt_data);

This line is duplicated!? It is also bellow.

- Amir

> +
> +	pvt_data->ctx = tee_client_open_context(NULL, tpm_qcom_ctx_match, NULL, NULL);
> +	if (IS_ERR(pvt_data->ctx))
> +		return -ENODEV;
> +
> +	err = tpm_qcom_get_client_env_obj(dev, pvt_data->ctx, &client_env_obj);
> +	if (err)
> +		goto out_ctx;
> +
> +	err = tpm_qcom_get_svc_obj(dev, pvt_data->ctx, client_env_obj, &tpm_svc_obj);
> +	/* Release client_env object irrespective of service obj return status */
> +	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
> +	if (err)
> +		goto out_ctx;
> +
> +	pvt_data->tpm_svc_obj = tpm_svc_obj;
> +	pvt_data->dev = dev;
> +
> +	err = tpm_qcom_get_ta_details(pvt_data);
> +	if (err)
> +		goto out_svc_obj;
> +
> +	chip = tpmm_chip_alloc(dev, &tpm_qcom_ops);
> +	if (IS_ERR(chip)) {
> +		dev_err(dev, "tpmm_chip_alloc failed\n");
> +		err = PTR_ERR(chip);
> +		goto out_svc_obj;
> +	}
> +
> +	pvt_data->chip = chip;
> +	dev_set_drvdata(dev, pvt_data);
> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
> +
> +	err = tpm_chip_register(pvt_data->chip);
> +	if (err) {
> +		dev_err(dev, "tpm_chip_register failed with rc=%d\n", err);
> +		goto out_svc_obj;
> +	}
> +
> +	return 0;
> +
> +out_svc_obj:
> +	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
> +
> +out_ctx:
> +	tee_client_close_context(pvt_data->ctx);
> +	return err;
> +}
> +
> +static void tpm_qcom_remove(struct tee_client_device *tee_dev)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(&tee_dev->dev);
> +
> +	tpm_chip_unregister(pvt_data->chip);
> +	tpm_qcom_release_object(pvt_data->ctx, pvt_data->tpm_svc_obj);
> +	tee_client_close_context(pvt_data->ctx);
> +}
> +
> +static const struct tee_client_device_id tpm_qcom_id_table[] = {
> +	{ tpm_qcom_uuid },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, tpm_qcom_id_table);
> +
> +static struct tee_client_driver tpm_qcom_driver = {
> +	.id_table	= tpm_qcom_id_table,
> +	.probe		= tpm_qcom_probe,
> +	.remove		= tpm_qcom_remove,
> +	.driver		= {
> +		.name	= "tpm_qcom",
> +	},
> +};
> +
> +module_tee_client_driver(tpm_qcom_driver);
> +
> +MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
> +MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
> +MODULE_LICENSE("GPL");
> 

