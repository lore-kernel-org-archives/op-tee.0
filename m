Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7165CC61DC2
	for <op-tee@archiver.kernel.org>; Wed, 26 Aug 2026 06:38:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5EFEA45010
	for <op-tee@archiver.kernel.org>; Wed, 26 Aug 2026 06:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787726300;
	bh=BcXvvFdLu116b/wVINcwmFhC/dSknQh5qpNOb2/ByR4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=avxpYirVaKek4Y7FEuK/sW8T11X6D9AK8CcddCRcGRJath2cSXTYcdlG/r147zWFO
	 uzfBDHrAEUURC/9MUhTV38TIfN3S0AM2GbHYIfDC26kmsabtPY7sMS6T3z6/nW5yW3
	 O5XCqB/PJtebazdRTZL9t5+HbFfad6JOB5LsnvodSBnjQ8v/hN5aUGe+vd2IFI+S29
	 hBBssUx/fSbe26bo3o7M0dU5CZFavYOWFntwRPq1mR0kWI1yv9YXYXmZAVDsVDh7j6
	 24M6vxZYxuHCkKxNqyNxsteWXfMPUZuXv+oL8KXy0Fh7axYaPCwuIAPgahGtv4awRk
	 aTvFPQJMSwH2A==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3C77B44411
	for <op-tee@lists.trustedfirmware.org>; Wed, 26 Aug 2026 06:38:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MZisFG4G;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T8lM7wng;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6Rvsp1130601
	for <op-tee@lists.trustedfirmware.org>; Wed, 26 Aug 2026 06:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XtNntw48dBLPq+zL2C2VWvB0
	j9j6z3ilCpDtZPb8jQQ=; b=MZisFG4GSAijkSRPFA04LQS4mwUQAWddHj8GXVlM
	V+2SLb3ppJp2Y+jWpD5HTsplsoW1dhHfpTx4O0BsqEMo4clKH7ALla/bofXbjeO7
	jtyn+Cq7s9HSrE0/Zf4KRo3l9iYuuRqNqf9Z8foy0mNIobEuOUzm+LFX5TILVdgO
	BfoLt4OZRRRv4/HRVvk+8TSpDqpgTVYsWKxtUuw2gkRK8ih75mZ0uj0AgmvxAtc3
	eeSWtYluHuSolgpjPhMhhnZQUge3NbR9ZgKtD97lY99Pd+qdvN9UM1s9yLqnUNls
	6CepC+Sl1eSZWz1cT8Ehi/eZo+RoYNeNnDc/ZkSQFqW5uA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bnjbnhn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 26 Aug 2026 06:38:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e63df032bso153006385a.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 25 Aug 2026 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787726291; x=1788331091; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XtNntw48dBLPq+zL2C2VWvB0j9j6z3ilCpDtZPb8jQQ=;
        b=T8lM7wng26DqJABl0ES5dWJsSjo23A7tV1+KV95gDLpyGE8C6JuDjQQuGH5oavmN9G
         ZFRM01vd+ChLt3hB33IFf+OqO32W/JhbaxrBeBY/1p2m7LPa0OOK6A3Tut3YTooz9VVG
         lplQ2QeddN/IYZ1ZAS3Fj6aYta2WXJ/h/T5NZOYNY4foSin9cvOgCqSeZZaTixejRmfp
         sQDiAkolFHjcMIsRQnleoAlHRLaTXLrcxt2bWATwZmKm/q3V+6k4QOKuVXrv08Skp5l9
         JErqbHdbWUiAeM4Zc7z5DM5C1Q1ySk/86vKnxvG+sfyj34An3slqqlXEr6y7T76D7OMz
         ElrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787726291; x=1788331091;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XtNntw48dBLPq+zL2C2VWvB0j9j6z3ilCpDtZPb8jQQ=;
        b=ARTvnkaTmDy2MvpYnewfwiyh3Cgoc1Fbp1SPU8LtQ/jT1IW/Dx9gilsRwjw8iRHy4f
         oTC3hcFqcZ/77a2csyMoNxcGMe3CL5062kbvO9FCXfz6a6IR1LKVgAWgnBm2GCXqX6/n
         8NfZQ1qleV5kQ5u0jC18uc4XJk72djTMof63qTh+o8j8sOg0qywymtaNCp8xM8v1DQW6
         tWa/YAn0SjJMfz1dRBgfQFZ29zJnYlcluM1ehUMIKNyv/qvFqatCpiIs3Cow0uq7ITPn
         bNUcmTktOjAOUtyuLnhVl+dmna7SXkgHrhLNPOt+NCO0JxGionivL4k2lZRa+UwM7UsR
         6eBg==
X-Forwarded-Encrypted: i=1; AHgh+RrA53bAyIipn6+eZV98wcPWVtDJsCM52pvR0uMluqd0XTQhoKq6JDq7DEZCiY6UWauA8gF/PJ8=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mynFgGiENILnt2uhuZF2Spr6ADqm3Z/cEwCbUUM1/8sjp9VqHj
	dEmSGmML2m6JHXVpIeA/UrJHaN/4oeFVtFJM4FtWtVEy4BTkJhq3EeQwDedUJiS0iIGTj9p6g0v
	/UX2QKZjwE0ZejHhNDoS2rzoPKfCpmMvy6gpqhVWbeHrBp5Vgs1HyHKNEDrCoQvlG9Y9JTQkF
X-Gm-Gg: AR+sD13xB2LRKyxxZ4cfWcDr42RY7H3G2A87XtfDJfcBvVNkp6ejcD8NtIvjBvLxHE2
	n1PAdDMgreckMEvY4XPwIcQ4H1dahfx0+b+WPB/p4sbd30HakjTDMHM9qCE7adpNNjC3gq8DYYg
	kaKRcinyNHHFGVLv3E1bxj3N3gEeKSR7f4MC+pnZaxAuR9pvSuavmEThmk82uPJ/fVniioycbcM
	CgDawf+7AvaSTQfmDuYi4Z/YZ/zcyxkV/dqq02MiSq5xDsEobBrym01azWEDce/UileFeQ6vztM
	o0VHgZNgHz1yvt2Di4N30a+G+QE5ZNPVcoC+DZ1Hu2vdtS2akoQaJnyVL4pA2EXmpL7Yq5ZNub+
	Zsd0tIkrD5V5Xiodi+LS046+y4TS59smG/w==
X-Received: by 2002:a05:622a:4118:b0:527:69ad:fceb with SMTP id d75a77b69052e-52e418f4777mr47129131cf.0.1787726290809;
        Tue, 25 Aug 2026 23:38:10 -0700 (PDT)
X-Received: by 2002:a05:622a:4118:b0:527:69ad:fceb with SMTP id d75a77b69052e-52e418f4777mr47129001cf.0.1787726290378;
        Tue, 25 Aug 2026 23:38:10 -0700 (PDT)
Received: from trux (137.red-79-144-199.dynamicip.rima-tde.net. [79.144.199.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc9b82cdsm16544305e9.13.2026.08.25.23.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:38:09 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 26 Aug 2026 08:38:06 +0200
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
Message-ID: <ao6Jzn75ju1d5pfV@trux>
References: <20260821150612.3944782-1-jorge.ramirez@oss.qualcomm.com>
 <20260821150612.3944782-3-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821150612.3944782-3-jorge.ramirez@oss.qualcomm.com>
X-Proofpoint-GUID: 4ywxxpMLxJNhJUbhP22C4it8TzQ6OkR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA1MyBTYWx0ZWRfXz3WKmZ3c6alu
 pG4kX2il8dQKNylSDy6UurQ+37Em2q8z1f7KpE+QzgHx9BL1365QO81pIy0b8/2dPZVc9BUEkF0
 5vYUDH6aLTzr6ooR+gZqWSXABLa5UBT2y8j4EW/M8nDhV6ojceTO4zQGppv6BBVMMDa8JYis95d
 eWdfNaRaQRqPqhS+CkrbKC5PZOEu5T3PrQXdO4xYkjXb0RL6iD0qsSpDFbB0J4//FXzBhNAC5nD
 DhQoau1FvUADbUcCT+Occ9uzcp3uO7IVOMYZ7x6/WxSTq/WtoQxor7Kf2GJVISYTbSHZau4luM2
 vx7kYiWfknGcTLBIG97R8NhIL2mpoUqplR6D18zJtLzz1LCkRWjJ+KT77d+Mff4EqLNOg/5vbvp
 +UwOCX0d1jrQYEDeIKAVZviR89+H3NORtj6Odl/W/jM1hKO+CRVVcIhymeAQRDZp47RL++ZebvN
 mcxahryL0Kz+zSjaHEA==
X-Authority-Analysis: v=2.4 cv=ZuHd7d7G c=1 sm=1 tr=0 ts=6a8e89d3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=qBhfTSQT0jQfJ5OHMlDVQg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xHNurQw6US8NauEldhQA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA1MyBTYWx0ZWRfX8y85GQTw046q
 4GwZbnCvpGue1QglC4r/y11wfiyQuP3BAHYsWtNblFMVvheBdcATYhMsWd6N8P5UTuDteoRi7Kl
 LmIiYXzzdqMgaIu45SpjAEFrWN862gM=
X-Proofpoint-ORIG-GUID: 4ywxxpMLxJNhJUbhP22C4it8TzQ6OkR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[79.144.199.137:received,209.85.222.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3C77B44411
X-Spamd-Bar: ----
Message-ID-Hash: ARJTOVS35SO3QSTPZAQOCEGFED2IBX4Y
X-Message-ID-Hash: ARJTOVS35SO3QSTPZAQOCEGFED2IBX4Y
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, beanhuo@micron.com, beanhuo@iokpp.de, can.guo@oss.qualcomm.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ARJTOVS35SO3QSTPZAQOCEGFED2IBX4Y/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>

On 21/08/26 17:06:08, Jorge Ramirez-Ortiz wrote:
> The RPMB authentication key is derived from the dev_id handed to the
> RPMB subsystem. OP-TEE implements the eMMC RPMB flow, where the dev_id
> is the eMMC CID, a fixed 16-byte value, and it derives the key on that
> assumption.
>
> The UFS RPMB id built here is "<device_id>-R<region>", which is variable
> length and longer than 16 bytes. Passing it verbatim would tie the
> derived key to a length OP-TEE does not expect and diverge from the
> fixed-CID eMMC ABI, requiring OP-TEE to be taught about variable-length
> UFS ids.
>
> Hash the UFS id into a fixed 16-byte dev_id with blake2b instead. This
> keeps the derived key stable and unique per region while matching the
> eMMC CID layout OP-TEE relies on, so the key-derivation ABI stays
> identical and no OP-TEE change is needed. blake2b is used because it is
> already available in bootloaders such as U-Boot that must derive the
> same dev_id, avoiding the need to add a blake2s implementation there.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>  drivers/ufs/Kconfig         | 1 +
>  drivers/ufs/core/ufs-rpmb.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index f662e7ce71f1..b62c00e7ff06 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -7,6 +7,7 @@ menuconfig SCSI_UFSHCD
>  	tristate "Universal Flash Storage Controller"
>  	depends on SCSI && SCSI_DMA
>  	depends on RPMB || !RPMB
> +	select CRYPTO_LIB_BLAKE2B if RPMB
>  	select PM_DEVFREQ
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select NLS
> diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
> index d0c7ea7a36f4..a1e169ad3096 100644
> --- a/drivers/ufs/core/ufs-rpmb.c
> +++ b/drivers/ufs/core/ufs-rpmb.c
> @@ -10,6 +10,7 @@
>   *	Can Guo <can.guo@oss.qualcomm.com>
>   */
>
> +#include <crypto/blake2b.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -21,6 +22,7 @@
>  #include <linux/unaligned.h>
>  #include "ufshcd-priv.h"
>
> +#define UFS_RPMB_ID_LEN			16	/* Match eMMC CID Length */
>  #define UFS_RPMB_SEC_PROTOCOL		0xEC	/* JEDEC UFS application */
>  #define UFS_RPMB_SEC_PROTOCOL_ID	0x01	/* JEDEC UFS RPMB protocol ID, CDB byte3 */
>
> @@ -153,6 +155,7 @@ static void ufs_rpmb_device_release(struct device *dev)
>  int ufs_rpmb_probe(struct ufs_hba *hba)
>  {
>  	struct ufs_rpmb_dev *ufs_rpmb, *it, *tmp;
> +	u8 dev_id[UFS_RPMB_ID_LEN];
>  	struct rpmb_dev *rdev;
>  	char *cid = NULL;
>  	int region;
> @@ -213,8 +216,10 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
>  			goto err_out;
>  		}
>
> -		descr.dev_id = cid;
> -		descr.dev_id_len = strlen(cid);
> +		blake2b(NULL, 0, cid, strlen(cid), dev_id, UFS_RPMB_ID_LEN);
> +
> +		descr.dev_id = dev_id;
> +		descr.dev_id_len = UFS_RPMB_ID_LEN;
>  		descr.capacity = cap;
>
>  		/* Register RPMB device */
> --
> 2.54.0
>

just a keep alive, any issues to merge these?

TIA
