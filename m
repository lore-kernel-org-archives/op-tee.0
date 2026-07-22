Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983FAC44533
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 08:27:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 95F8344F1A
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784708823;
	bh=NLQKFArajH94tZtPgTIE0gUJwL1+IPxwWTKo6HsqFwM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=4TZ2KS7wlqCItvlVA2p6so7GI9FZNLMFB9nawaGOJpoZawm948f/ScUw+z4YOwnoI
	 ia3xNAJJ18Tt9QC5D25t8AQ6p+WfgYA5vdWJXWzxg6vgIdNRgn7FwsvROOTGJ47K5v
	 voyFP2oenXanqEe1tAai8NprJHXUx3bvFm3yAiz29eEdIr9TbzAWYV+i2L157yQN2Y
	 jSRchGZMqP4GF00cz8PSmUNYxuDubGXxEPjQbx2u/pa287g23uKRzNfkzh9l4R0HtE
	 CKcsSlD3Y+BrqVA78BDLqsRFHMIMKasuReNMxRNWvT8RrINrnVKUQt1UYig6gAKyh2
	 V5C63at1SZ+eA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B76FE43818
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 08:26:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z5A7sXnh;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G8pMhKFT;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8GiKR302591
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 08:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=b8PrbCTjo875NEYFMM6d6TIP
	iQeoWqfr7uJWThGFKkY=; b=Z5A7sXnh/uGzj80jumYnX3bUbMVUs4CnL9WnmM8f
	Jwr9BYQi7FTCymzGV+yD08w4NsIBTF4pPwrFBWQrayM4NL0YrqTI4//WeQ6nz+3R
	flBAkcMUMiMSuCleSI4Z3yUcTCki7XJ3g5tnY1ruEj53qFyM6SHlw7EYk8MXEtSD
	jTDMjSkcLeg+KSFhGszblgmwAK5/tcxq1QNlhURpkP9J1mt2xhN4E/zbvtmoCu7A
	G6TDCVRTHwKkmbtWK/WR2ErOT1/cH+RaK7J+qWZYGXa6iBzVRreZExhi/ep8Rd7X
	1AEisWYnhAaOwzNdZ7CpD7VS80JcrVYLn6ou0QtL+hujKw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjt79818d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 08:26:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a87ef9713so85445521cf.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784708815; x=1785313615; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b8PrbCTjo875NEYFMM6d6TIPiQeoWqfr7uJWThGFKkY=;
        b=G8pMhKFTtLAYmVh39sUPIt+fsGpdWTvQnsmOSmWBTXSUWgY3aulMrcAc8uLrqK0kEm
         HEg8wl8KWaPZvmlE2rq1rrM6UH8L0fXGIS5wEWBDqB3g0piiDQ2/x/xy8YlQ4WzqRja3
         Cpz7tfp/SR2H75dRSiLhOGXMuzyaqu+Y/VlYezgt+uxJdp1HhXgPvE8vhUsCawEHkCL9
         YwYt8lHU04+daeC48cK+T7uxTzLu8vvMEZMqlLVTWNbkvgzbp/tZ+IOwhSxdSLRqQ12n
         EPQrorYArc6DOLdO11z3/RsUR4laL+6TYWAM+WgurrER3SP4u9HiBBM6g0IiPE1k6BmK
         Wufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708815; x=1785313615;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8PrbCTjo875NEYFMM6d6TIPiQeoWqfr7uJWThGFKkY=;
        b=VGkdTEr91fKBW4wWdd7+q9wH2sgNazOBaNNpR48c3o/Z0g/uMqAkuLJH8FPz/GIxpb
         nMqtS5z8VJAm0NmbneOYoIdBkUf41VrXvEn9kFui3/7uGLgjCSi9EMHXwenA1Fo2n5iC
         2Md4np8l+6QHNxLpDDf4/MUZyj2V4ue09YrONZ+/tlTQ8UpA5eczoalzFeSHK1JIN2FO
         JgO7m+VFrRTq1y+cVZFH0liOo1LvRpdNMejLw5c6M0vhtY9+cFEFDLx1Xf1YZugitK6o
         ogx0hGGz5ZkhnlSUQpHuxMQV2VNVuwtD9AQreqm32m1M60cbpNxsLOFH3x0EM+YxB3Za
         oDgQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvgGf/7nWom+pwQY7jJDW6CDLK2chCw3n4zyhpkfE2t6KN71qozOipaLnpTKIh+f4hLS2NOdI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzispbRXHx40HXVQsDJDuUGfOyHSLABjzRgzdnWwfRVRvk9dUpy
	Dm43cemq71PJz68vjMJlVXzIyT8e3++qSm03O74fXR/yfLmJtfgrsqIGUsfqOlBIUkg42GjxtKR
	65Gvld1GeKxo05cSJo/5LBmev3OKDIWA8GRP43ugBBlNBelVPVYgL6cj9i6YpXswhK0B3o64G
X-Gm-Gg: AR+sD10FpkwA688mKtCoZnrIuaTpxr6HLwNcJY8dvqMK8UG250N7DpUuk4hm5wCbo9O
	QYEy9cB3YgHtj8XAUuU/jY0uP9StcLV0yDwLqmNOhiht2Za4IB5ggTqLdGQWaYAFqtuc7KzqhoN
	oUMWkpGO2qZjGaU2Mriw8+dT443vdwZzi8LkoE0nwsy13LImarrSNrV7GHu16xa02C5EYca3l6R
	0pB+J8/QyavqahNb3vG1a6/5VpQCsJBoQAQlFLJrDXi6/l9Cblkx7wc8Ij/4sVKG20b81lCbPQR
	pvxwdSeURDLKzGCYNoKzKGIcauF8GivCdDFb7Tp8WH160Ir7/twbIG8tYTvpyJ/keI+L60WnFyh
	zczbkGDsK8iNiTrC1OORqKiAIcREayAovjOZizbYCnsJJK1Nv2RuxXu2EyRmPHx6e3xVAVjW8ad
	Pd+Llt/GW0MS6wDA==
X-Received: by 2002:a05:622a:1b8e:b0:527:7756:3ee9 with SMTP id d75a77b69052e-527a2cb3ca9mr31562851cf.0.1784708815396;
        Wed, 22 Jul 2026 01:26:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1b8e:b0:527:7756:3ee9 with SMTP id d75a77b69052e-527a2cb3ca9mr31562661cf.0.1784708814900;
        Wed, 22 Jul 2026 01:26:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9e4534fsm335621e87.63.2026.07.22.01.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:26:53 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:26:51 +0300
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/6] Add TEE based client driver for UEFI Secure
 Application
Message-ID: <nfijwr2ptpxqvdw625yedep7tmakwvkeavyeobrmig5hbkw77w@rcqyp7h4y327>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Sr6gLvO0 c=1 sm=1 tr=0 ts=6a607ed0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=EPKcpx9xAAAA:20 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=bb8mIWsUJEVNQjRnNgUA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=ZT_8zCgGubuJgGonBfBE:22
X-Proofpoint-ORIG-GUID: U3MiZ8S5kQLCThKShlcz0A0voyxudHzG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3OCBTYWx0ZWRfXzUThAGKe+UT/
 NUlDIgJ01faiz+q52U04u6aXUhi4XeRI8bcwinmbUAPbzAgaNp1Blh9Boii/U/ouZhWftHYYTNO
 phXLMs/GH4GxwGMmbBW5UkilkyC5V/GbWOF9yelZlJWlVpfttzoYX78ZY5pNDRe6Wy9ihjdHc+L
 o9g2CKPTYqZK9s8wyxOksQ4dixCThsi0CCe/JM8weUN/x47bDS2tjppVeaVRM/41NjV5jOl52lu
 D2EzUmLAHRyk0CeqxagICVSRCa3g/YNJnUunZtKhiD19bYHbjo5gadmEg9+jJ775a8irDXa5UQB
 1Ut70FEb2TOx8Hj05f0rkL/g13YmUU2BQOfTT5Q6tuMZ9oQ6jNKtXI1JeaZifELfhMPD/bTAr2n
 jY62Hn2kENgD3hTvjsM5BOV9AdcWDk60zoQ1BTrfgV9K/DIHTphAV5WtANjbSnKGesMfgS3m7ae
 RMXZuR+0lh+d+//Ci/w==
X-Proofpoint-GUID: U3MiZ8S5kQLCThKShlcz0A0voyxudHzG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3OCBTYWx0ZWRfX5BPUIo57IWzQ
 oAD6oiOcAxlOUarWoQjCxoiCDcRpE4xmx8f/0unw9v9l5AaD4VbM9MB7lax3Pswnv2zmGeQ5PY0
 QhUDMhQwjsFKai5p2YdqqINj12BKKjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[shorturl.at];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B76FE43818
X-Spamd-Bar: ---
Message-ID-Hash: OCTL64UO2CHZY5QQHRHLREKHOJXQOQTD
X-Message-ID-Hash: OCTL64UO2CHZY5QQHRHLREKHOJXQOQTD
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OCTL64UO2CHZY5QQHRHLREKHOJXQOQTD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Wed, Jul 22, 2026 at 12:29:11PM +0530, Harshal Dev wrote:
> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> Replay Protected Memory Block (RPMB) which is only accessible by the
> Qualcomm Trusted Execution Environment (QTEE).

Is it so? I think RPMB is accessible to Linux...

> For Qualcomm platforms without emulated RPMB support, specifically

What is emulated RPMB support? Why is it mentioned here? Which platforms
use emulated RPMB?

> platforms where RPMB is not located within SPI-NOR storage and instead
> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
> a callback request from the UEFI Secure Application to the RPMB service
> running in user-space (within the QTEE supplicant [1]).

Can it be moved to the kernel?

> 
> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
> QSEECOM based uefisecapp) does not support callback requests.

How did it work then? I think Windows has been perfectly using QSEECOM
rather than QTEE.

> And on
> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
> QSEECOM interface fail due to lack of support within Qualcomm TEE.

So, I assume, on RB3 Gen2 the QSEECOM doesn't report uefisecapp as
supported. Does it?

> On these platforms, a TEE based uefisecapp client driver is required to:
> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
> 2. Ensure persistence of non-volatile EFI variables via writes through
> the RPMB service hosted in the QTEE supplicant.
> 
> This series introduces such a uefisecapp TEE client driver for the
> aforementioned Qualcomm platforms which installs efi-var operations _if_
> the QCOMTEE driver registers support for an object-IPC based uefisecapp
> service on the TEE bus during its probe. Only new QTEE firmware versions
> available at [2] provide this support.

What about existing WoA devices?

> 
> Thus, QCOMTEE now maintains a static list of always-available object-IPC
> based secure services exposed by QTEE. These services are implemented either
> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
> usually loaded by the bootloader. The uefisecapp TA is an example of a
> preloaded TA loaded by UEFI. A static list is required since QTEE does not
> yet expose any way to dynamically query and enumerate the services exposed by
> it.

Can it be fixed instead of having static lists? In the end, we can't
guarantee that users update the firmware.

> 
> To facilitate object-IPC interactions from the kernel-space, this
> series also introduces a tee_client_object_invoke_func() to allow
> invocation of TEE objects similar to the existing tee_client_invoke_func()
> API exported by the TEE subsystem which allows invocation of TEE functions.
> Some suporting changes are also introduced to track and handle operations
> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
> driver.
> 
> Finally and as previously mentioned, access to the object-IPC based uefisecapp
> service is restricted on older QTEE firmware versions. A new QTEE firmware
> release must be picked up from QArtifactory [2] for all upstream supported
> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
> driver.

What about fused devices?

> 
> This patch series has been validated on Kodiak RB3Gen2 platform with UFS
> storage by attempting to read/write EFI variables via the efivar tool [3]
> after mounting the efivarfs filesystem. See [4] for an example.
> 
> Merge Strategy:
> 
> This patch series could either be taken from the OP-TEE tree or the
> QCOM soc tree. I would prefer it to be picked by the OP-TEE tree since
> all except the uefisecapp TEE client driver patch in this series make
> changes relevant to the TEE subsystem. It would be great if the QCOM soc
> tree maintainers can Ack the uefisecapp driver patch.
> 
> [1] https://github.com/qualcomm/minkipc
> [2] https://shorturl.at/zQU07
> [3] https://github.com/rhboot/efivar
> [4] https://docs.qualcomm.com/doc/80-70020-27/topic/manage_uefi_environment_variables_using_efivar_tool.html
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop using MSB of the object_id to distingush kernel and user object invoke contexts.
> - Introduce enum tee_object_invoke_origin to check the context of object invocation.
> - Link to v1: https://lore.kernel.org/r/20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com
> 
> ---
> Amirreza Zarrabi (2):
>       tee: Add kernel client object invoke helper
>       tee: qcomtee: Allow object invokes from kernel clients
> 
> Harshal Dev (4):
>       tee: qcomtee: Track the object invocation context
>       tee: Export uuidv5 generation for TEE backends
>       tee: qcomtee: Add support for registering QTEE services on TEE bus
>       firmware: qcom: Add support for TEE based EFI-var client driver
> 
>  MAINTAINERS                                 |   7 +
>  drivers/firmware/qcom/Kconfig               |  24 ++
>  drivers/firmware/qcom/Makefile              |   1 +
>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 525 ++++++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_tee_uefisecapp.h | 120 +++++++

I don't see any changes to the QSEECOM drivers. Is it allowed to use
QSEECOM and QTEE access to uefisecapp at the same time?

>  drivers/tee/qcomtee/call.c                  | 205 ++++++++++-
>  drivers/tee/qcomtee/core.c                  |   9 +-
>  drivers/tee/qcomtee/qcomtee.h               |  12 +
>  drivers/tee/qcomtee/qcomtee_msg.h           |   1 +
>  drivers/tee/qcomtee/qcomtee_object.h        |  16 +-
>  drivers/tee/tee_core.c                      |  24 +-
>  include/linux/tee_core.h                    |  23 +-
>  include/linux/tee_drv.h                     |  18 +-
>  13 files changed, 952 insertions(+), 33 deletions(-)
> ---
> base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
> change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014
> 
> Best regards,
> -- 
> Harshal Dev <harshal.dev@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry
