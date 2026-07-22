Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734D6C44533
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 08:37:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7CA30451A6
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784709465;
	bh=tFwCQkeZG7rd+dEXLx69Y65LPFna9EaL3Q9gAS/nNo4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=KvcbVNRTYN/ishaXEplTb/2hnWR5MM8ZVbwYpeUJj/IHV0O21nQdjbn4UI6Ddlmvn
	 HW/4cweXdyl74dTVPuQV2q+EhjG2rgZ61f+885hyLiG0H00uNss/gnjA2QZAngHF4i
	 yW5jS90AHto1E2YI8s7+53NyrYqn2ScVml8ZV2aMF3MHWtFBrQY3bEKO2stze/Doa2
	 LRx21bC6qw0jvZUR0XiYeYrYxc3TwAkhIQJ7T5joZYyOB1E9SXnPtKMX+qqszZItlM
	 Ph6HUWQPS4CmDoUJvnwIqXrvvj1SZX306V5JQYJR/1sr4ucvN78UneoqB/Fl646KUY
	 KnXgXHNqChJDg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C087543818
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 08:37:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AsMM0DWu;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=caQI4GsK;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M6fujQ200496
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 08:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QBgbeQa63G22sZojaUnX0f6C
	1ctoYWBtnWtNuCih+bs=; b=AsMM0DWuvL+3xfVIwlLF850rEIekmps1pPNf7chu
	DbpQMHKYVVvKxSMZK3rd83MsTBCAmxULYTxlOq4AfRFweGkgipX4zNEPB8aIGMtD
	pV3THyH6vU6U5jEdAZd29leZjivjeLRdTrgNilW42LMSV6qQGVeu9uY4QFxb9lFY
	Bfk4xxBtRFsPokK9Hj3b9WM59L/VgzHz8Y1XQw5yclX/HKvej49Bp0pcyiapzcmg
	ArP0beLIYSX6kQ0O/37MJWX7SPNSGAzZtUGScnlUakT8OT1j4IoQaeR+2sibxsgD
	uoeJKyj3c+FDpDOaxR8yZQ1jqn58ImuM5982N7MWxAka4w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt0fj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 08:37:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21c01cf3so195507301cf.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784709456; x=1785314256; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QBgbeQa63G22sZojaUnX0f6C1ctoYWBtnWtNuCih+bs=;
        b=caQI4GsKNydqUbc6kthzXQBzMP5QX6MXT5VQ/wQbUgGsllwZjsijI1XJDEJamElv5u
         24RVrm0r+S4iHHuprsg4WUTvpdIrUpqe7gKVjG20BikD/TqFtTunYzo/XEwYcvwG/nay
         EAo1iOddi8e0D8KLrkwg66STlIUeQv29B9QUpmG3hrikvgcofrYMmj+ADgbbN0wMp5Yx
         ghjnMu/Baz+ae3Sh87+30cmtYt+o7Kp/OKXfKwOBjygUCiP2eUb53QZYSfLEJFG7XvvP
         J3YIRIh5gqcERlaTJqmTIDwr2P1jAlSVOfspC0wufkpnEs/uUp8bwPOZ5YtO5MSgjwOz
         Bfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784709456; x=1785314256;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBgbeQa63G22sZojaUnX0f6C1ctoYWBtnWtNuCih+bs=;
        b=BtIo/NtsC7889jbWgynwsDGuTZYmtxTtd2SI0z8BE2fvEmAoaGOppt6alB28yoZpCv
         m+IkTf7bY2QhtE4gmTxkXXrbTAMYsMVH7OjHe5IVhzQPDMWdK101D6wbKmvF0mpmqDi1
         hGAZlybp1sAC0iOyokochM53LXHoLtYuuxo7kfavg2Mm9EHna2mTyciu8n6yQBFjTh2g
         5WtORw4SPg5ZnriCCjqrRvNXtPiRD+QOkf8yhm2VrkhEGSl+sdwEr//R4QiAf7Ow9NHi
         p/WyJj3mp04z9/DO5onz+t3WvVxxyLwhxBqaux+vA73NoQ3eMGpKlQ+3hVgWAIcEoXji
         cKyw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5SEx5zJfdqalJzgn/AeU76CUd9+zWWTDk+AtyjBr38TZThUNRoDo9lBejY7dM0vio1YPg3ps=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxqD+flGyQoL41RFs1lwcfH65/MfaL05BHk/tZSiuysppYmSAxy
	JyqcKnOIk/vIMstdBcXEaanosRleofKm144c1hUhjI+RLUwgpFMFOYKATXgND2dEpf56kpK52al
	3vb6pyb90jOhsk9X67jtJ5Ezdp+xj4KYCohkJRV5UMs3kPGbZ4PHKFS54pPWPccx4c88kBvjs
X-Gm-Gg: AR+sD11ii3DtMXmMHAj+EC43xeX9t6kX44CyanEswebEsFEtDHYaNIoV4eB5y75m2d3
	jGhkJ7ArQXyw18dToLqHxUmyvZ0p9NiZKGgMNneqL+N27/qwwyFud+djMx+Mh9SeNLcWWt/sSnS
	91rfdJuRMEI66Wk6wkbZkZiNKJTyog9M2gpdeFtonyZPfxNYKANX9K7//2X0Dmyo+O7k3bqFoXx
	FCbV1lP/D7NeyiuU9MxJ3zGNSvWMnwHiwIm5gYV+D0nk1EU5X9iE5u1wQpbgH+PJg3yvPFcJo3e
	qwFs4UGfKUduvqoZadtb0DlNZxMe373VqQbHp+0uS50pmCko4dxJZWeyIpy6e44il8t98rReUIA
	sjEOOk/nMQ6z90oG+NAf4Ns/W6WwpBAjO+08xkGbvTaWVwus+qZFEg3fu6U5HUl1k+U+jRq2si7
	YkV650ls1gu1IWsA==
X-Received: by 2002:ac8:5f4f:0:b0:51c:ace:de6a with SMTP id d75a77b69052e-5213d2b715cmr198048791cf.18.1784709456234;
        Wed, 22 Jul 2026 01:37:36 -0700 (PDT)
X-Received: by 2002:ac8:5f4f:0:b0:51c:ace:de6a with SMTP id d75a77b69052e-5213d2b715cmr198048571cf.18.1784709455717;
        Wed, 22 Jul 2026 01:37:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b8bfa3sm347571e87.12.2026.07.22.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:37:34 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:37:32 +0300
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/6] firmware: qcom: Add support for TEE based EFI-var
 client driver
Message-ID: <w3oebwhvheb6scbdv2dshhr6t4sx3nwalmlw4akqf4sj3n2nmm@s7e3xtr7cuev>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <20260722-qcom_uefisecapp_migrate_qcomtee-v2-6-b8a8fcbe4211@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-6-b8a8fcbe4211@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: y2XNzviuF5ZFdG7e1pwbk_RLJGvCVUDD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA4MCBTYWx0ZWRfXzLM3tSF+W13h
 Neo5A8fyF3Ht83TO5xixWEEomrCZehrFzMKi508ZyBVS5YZtL2qMDXhypxCUDku4l6oWuJdqD0x
 lAl6Q63Xm8T2LRX2p2aJTxwHFYJvQG9yaIFNpcgoxl6Lzt0DIBRwC4XzqVxs34NQPTYE4Jo06lM
 OVHKNH2yPK7UqKBkc37C0chtn47YsUPBuY3UuIutc2u9RTFrRxjwOMFkAzg8zBt9V/8PuuJ5Hgm
 1tkThHhe8bqOZcwhXvZ6XmorexVcShiBzZRXjwbOTOqtD2+El4tKn7WxpGfMj9MzldbLMF2hsJe
 kCriTKzilMOUh5cb3l9XogB5UZZRv5QnsGb6FUwArsTTrnN9YmJnn9L/3e82ZVflLzBjFdkx4Xd
 hh1LSKoop8CVFXi9cTa3vJ85FClwBWMn7OFqPT6BLDcy5wMAQ4cebdgQJLfHCtJLn4ZjeKu+bwg
 IXXkOQwmPnH/94cLSaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA4MCBTYWx0ZWRfX0NdGxWzeO1qL
 uWNpxESyMzHtFjPwycV8f2hJjqvjKm+bJfGtGbTFWdXtM5Pl3FqvSSbz4dx+x6kwe3diMpK1MpG
 o8JA5l+wNx6YKAdfga5yG1CsEGJJv7c=
X-Proofpoint-GUID: y2XNzviuF5ZFdG7e1pwbk_RLJGvCVUDD
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a608151 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=BdpbYtui1GW-VTqxAS0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.197:received];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C087543818
X-Spamd-Bar: -----
Message-ID-Hash: B6XBULEMU2BDFTAGN7NLC5QZ777VKJXS
X-Message-ID-Hash: B6XBULEMU2BDFTAGN7NLC5QZ777VKJXS
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B6XBULEMU2BDFTAGN7NLC5QZ777VKJXS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Wed, Jul 22, 2026 at 12:29:17PM +0530, Harshal Dev wrote:
> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> Replay Protected Memory Block (RPMB) which is only accessible by the
> Qualcomm Trusted Execution Environment (QTEE).
> 
> For Qualcomm platforms without emulated RPMB support, specifically
> platforms where RPMB is not located within SPI-NOR storage and instead
> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
> a callback request from the UEFI Trusted Application (TA) to the RPMB
> service running in user-space (within the QTEE supplicant).
> 
> Unlike the QCOMTEE driver, the QSEECOM driver (used by the current
> uefisecapp client driver) does not support callback requests. And on
> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
> QSEECOM interface fail due to lack of support within QTEE.
> On all such platforms, a TEE based uefisecapp client driver must be used to
> access cached/volatile EFI variables within the uefisecapp TA and ensure
> persistence of writes to non-volatile EFI variables through the RPMB
> service hosted in the QTEE supplicant.
> 
> Add support for a TEE based uefisecapp client driver which installs efivar
> operations after obtaining an object reference to the uefisecapp service.
> This enables the kernel/user-space to access/modify both volatile EFI vars
> stored by the Secure Application (in-memory) and non-volatile ones stored
> within RPMB.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  MAINTAINERS                                 |   7 +
>  drivers/firmware/qcom/Kconfig               |  24 ++
>  drivers/firmware/qcom/Makefile              |   1 +
>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 525 ++++++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_tee_uefisecapp.h | 120 +++++++
>  5 files changed, 677 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10d12b51b1f6..e8316007370f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22018,6 +22018,13 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>  
> +QUALCOMM TEE UEFISECAPP DRIVER
> +M:	Harshal Dev <harshal.dev@oss.qualcomm.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.c
> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.h
> +
>  QUALCOMM RMNET DRIVER
>  M:	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
>  M:	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index b477d54b495a..20ce8b58e490 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -74,4 +74,28 @@ config QCOM_QSEECOM_UEFISECAPP
>  	  Select Y here to provide access to EFI variables on the aforementioned
>  	  platforms.
>  
> +config QCOM_TEE_UEFISECAPP
> +	tristate "Qualcomm TEE UEFI Secure App client driver"
> +	depends on QCOMTEE
> +	depends on EFI
> +	depends on !QCOM_QSEECOM_UEFISECAPP

Nope. The kernels can be built for multiple platforms. Implement a
runtime selection, which uefisecapp client is to be used.

> +	help
> +	  On Qualcomm SoC based platforms without emulated RPMB support,

What is emulated RPMB support? How does a user (or a distro maintainer)
understand if this needs to be enabled or not?

> +	  specifically platforms where RPMB is not present within SPI-NOR storage
> +	  and instead located on UFS/EMMC storage, non-volatile EFI variables can
> +	  only be set via a callback request from the UEFI Secure Application to
> +	  the RPMB service running in user-space (within the QTEE supplicant:
> +	  github.com/qualcomm/minkipc). Unlike the QCOMTEE driver, the QSEECOM
> +	  driver used by the QSEECOM based uefisecapp does not support callback
> +	  requests. And so on these platforms, the TEE based uefisecapp client
> +	  driver must be used to ensure persistence of non-volatile EFI variables
> +	  via writes through the RPMB service hosted in the QTEE supplicant.
> +
> +	  This module provides a TEE client driver for uefisecapp, installing efivar
> +	  operations to allow the kernel and user-space access to EFI variables.
> +
> +	  Select m here to provide access to EFI variables on the aforementioned
> +	  platforms if your Linux distribution has QTEE supplicant installed and
> +	  running.
> +
>  endmenu
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index 0be40a1abc13..d780490b2865 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> +obj-$(CONFIG_QCOM_TEE_UEFISECAPP) += qcom_tee_uefisecapp.o
> diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
> new file mode 100644
> index 000000000000..9a5a6f145a9f
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
> @@ -0,0 +1,525 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/ucs2_string.h>
> +#include "qcom_tee_uefisecapp.h"

You are the only user, inline the header here.

> +
> +static struct qcomtee_uefisec_app uefisec_app;

Do you need global data? Can it be obtained from other context variables
using container_of()?


-- 
With best wishes
Dmitry
