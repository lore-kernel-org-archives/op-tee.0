Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31D3C4452D
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 08:29:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0B6E543AAA
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 08:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784708966;
	bh=4JCPT8LjoquEP5sUWnwAWD9e43vT3tf2kuymJQBp/ME=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3/4ETIgzKPceHjzcVyfUq3Rj5wjnXuOWQq4gWRoTD2Ia6bF1L2jls3DQTucXMEi4U
	 BqXu0bGKegkjoFYAUDorkBEhf58idXZGNK7/y3WSmJoTI2/bhj9Qhus42wBfFuvJ2h
	 D919CC95q7Fha40GIUoruzblHtSn/50Qhwf4U09jk0Oa57txbu5QLzpORJ+bkzVrRF
	 XdhtyzhD3FECUhofw7C+gO3VjB5CcTN11R4l5W4nXJgHNbjN4OUqBtOgpd27l5CkGS
	 3RaEecNOx3NYNY93UTAFpmULnTKpPAs/gLAAeZKITRmwNbR4Uzhz6F37hMU1GvV+8V
	 ghow7hCC+/PYQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CB2EC43AAA
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 08:29:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KfWN7Iu7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UZH63Cta;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53im03787186
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 08:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mzFXdrmo76X20LWVaZuKiR/v
	bKcWyq5xd6iUFnb52dQ=; b=KfWN7Iu7fwbFQZvEjiz88AfvLvyzzTjEkhmsXl+W
	ZBMutJ7tS5UiUPwdMVzpmHmLTrnGhQCo/0NIfDLWGAdop6b1F123Gz9LYt4b/uR0
	q7jnqgBCMbFbdn38PzndzTQ5h4jH5pouS0aXScBW8vwids6Y2G95k/4EuLTMmZrt
	rqt66vlYWk6wjX09/gEhDDEjqifbpLeaDA1eGV3OTjULGsUnLV1F61kvAcFgEY20
	W3fzC6rzosUpxXHPdrHWaNpU/IHY2Mp7kyeBib3i986Hrz/i1q+YezREZCA4RR5P
	a0SlkhiBD97VFIK+C/OvrlI0sI6xFGaXwts9NlA2JVfjJQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9aecfuu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 08:29:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so166386151cf.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784708958; x=1785313758; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mzFXdrmo76X20LWVaZuKiR/vbKcWyq5xd6iUFnb52dQ=;
        b=UZH63CtamojyD6lauBDbiyGkcrS/Ox9vN0Tq0n/pVfSPPSAvOL+Qxdokm2n47lAOwp
         DyaLgHAmd0Pv+wy0uzex3KC8jBpykWWdX4tay5CUKwTTuQdXLFEWhtPnednYF2CoJT8z
         a1HsRdr/vzdrgQp4+tAaOzXoB1+UwJFuQBQq/udqsi2AngIinRlxzh92z7WIgE8N83tM
         BbvBuWNhpt83wwikc/fGUnrBRCJJShgj7G/HejmhhPGIt+z2KyW72Dk5QOZZx4Zr1BLD
         tZDd99al96sd09NmKvRGMMqL55NU7JZvlJrY/cjtC72V409K082REIgrQoxrXw9B6fDB
         +69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708958; x=1785313758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mzFXdrmo76X20LWVaZuKiR/vbKcWyq5xd6iUFnb52dQ=;
        b=QM8dtfeUUaTSv3mv0WfEQqhUgSft+IzemKiAX+44o3sCaQYO5k97uDTvIbgZoDEdxj
         ODiYzGRFjVTLVWK9dvd7PhLVehhX6p70po8eUkJxSQaVZgD8sGHVQCH6F/PDRhK/GhVx
         OfNe8QzZoo8re/fVi+3vOeBFkjvtuWarN7TFS4yyUQPvFM5TnKLTCb+H+msbjHFBT1k1
         kkE6x53XNAZKS55m0eI76sJXuX6VFYGABejgY4E6NGN3ZHaS73wl9Vv7M/3hKANvPsf5
         nlk1YdEPdKhk354x5/2toxkVG7yPmqNUN3teIADFTW0CLV7ur1iGnyhxfRDagwhuXgKJ
         j4aA==
X-Forwarded-Encrypted: i=1; AHgh+RrlKKezf9sBNARj8izQtKVqD50FNQc/HwYkcoNF9t7Bn3J6pcRjl5geJ73gV1ghuHBj5TO2aPE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzpQyKfV0IZK3e6jx/y9IRfGNXkzGTOPEuMfs2UpmbEcX5rQ+QQ
	hNW3i8JX9iGKD14ZFZQzjssiinW6GKNitnp+HJK9qr0hadWYgXkkFD7s8f4CqHyYeVMgxbYDdjV
	VV4uVnvAwGp9Cuq/IonLMVMPmdmtF2jQjAJGVPRBz7RpoxhglA7kkCz5K+f24iAvaMmXFfBM5
X-Gm-Gg: AR+sD11fNupRFuZHGIjzl70xqQbGL1a7C/qb5UDsm1iahWV5sPsK6ReeLUeh7e7Fy85
	Qcg8lYW1oXtBaQnks1kV+YJlrvUY9PX83pJ++P7MEcH3wqjT7ATomZ9W8/oMCJJm1IWavEMM3Xa
	2ehvMX8NsxWWNiiw2TGdYJxG+il9F+nkFliovbdUA39dME9AyZpiPObo7v6GFiO43ZhI6E7dZ5K
	h/V1kKGyuY8xw6oBJfBoVmqHf5Zfl8Ba3Wj57/IEq4jgRHGoq7e+AgYo+/+WDVZIsGDeCjOul46
	R0GkNnIyK1tdr7CRkHv8hbRGln4SLU1wpGofevXwT6R96WZCDOgN91s7LsQVkSGaks5PTQYUVbe
	/+0WfMYHOEUliqcZw0VhA/DBRnrotKqDiqQuK6jvwabs1Jz+gZ0PIWh1Hbh9Dum1tbCQlYwK7pb
	e71DKEe7oCagw9qg==
X-Received: by 2002:ac8:5805:0:b0:51a:8c79:a2d with SMTP id d75a77b69052e-5213aa6d807mr204571551cf.1.1784708957694;
        Wed, 22 Jul 2026 01:29:17 -0700 (PDT)
X-Received: by 2002:ac8:5805:0:b0:51a:8c79:a2d with SMTP id d75a77b69052e-5213aa6d807mr204571461cf.1.1784708957293;
        Wed, 22 Jul 2026 01:29:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9e4611dsm353445e87.67.2026.07.22.01.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:29:16 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:29:12 +0300
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v2 5/6] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
Message-ID: <xyfoylxowewyyivw4qkwjhtmukbejusmcucfrs6jnmrihpx2ep@koluyh6bgbre>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <20260722-qcom_uefisecapp_migrate_qcomtee-v2-5-b8a8fcbe4211@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-5-b8a8fcbe4211@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: LFyB7bZiTyhmaf2QjPJTo22HLOqwBvkz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3OCBTYWx0ZWRfX1nk/s0Rh9/z9
 pqlAJxOhCYsEmz13lQzmODnOoSf3ZgjS6g81R2vYX85Q9rEnkDpWDOuLtYal/pQyFyi3IjKUTdd
 kQm/6fWmk7i+ZVs7josD4SmbCmzSx0A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3OCBTYWx0ZWRfX0sJQ8bLDM/UK
 V6KS6+Oiyf8KiwwKOKCMM2XCVwry+wk0cd8gtL837TR/HCSqo3remo+Wa7zW8+/JV725BY1SWAe
 LbbTXoIZzT1LB0TeXO9FnSwBSu6MegOrblVxoU1Zu8P9e4dpffFQculi1wuxgaottDLhGiKG8V0
 9K6CFEqNFMjJQDJ3NHYCzas8AtbRkMDIgHzX10VZT9oIQthiD4ESgc31UAtEq4+O5N1XB0uZx+5
 3W29Ifvvnye2So75ZHFPWY8lHxXj+Ps760Jq/WFgQ7A0TKkmEpXjOCvQ7tJ/We9R+ubMQZzu9Go
 EbtmISOvLfmRr5dVvh+P/Q2BySXkwcptDPLk5C0DQDm1nA+ZAeNbvhKc4QwrU6P6ZlxUg7mmIZC
 PgTgcmr+rrfntzsueP299/2Ma/wIUlOF+us2L3QtOs3u66GwZ/cnn3nCD7x37u6zLiPp5o2bFcO
 7EkiBY8PrXUEbIwZTMg==
X-Proofpoint-GUID: LFyB7bZiTyhmaf2QjPJTo22HLOqwBvkz
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a607f5e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=TFgC4XBF0NqNkrG4Fy4A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.59 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CB2EC43AAA
X-Spamd-Bar: ---
Message-ID-Hash: YT4RXDFWDQ2OZY4FWXDNDXT2WVA7RBVY
X-Message-ID-Hash: YT4RXDFWDQ2OZY4FWXDNDXT2WVA7RBVY
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YT4RXDFWDQ2OZY4FWXDNDXT2WVA7RBVY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Wed, Jul 22, 2026 at 12:29:16PM +0530, Harshal Dev wrote:
> QTEE exposes certain secure services implemented either within the QTEE
> kernel or via pre-loaded Trusted Applications (TAs). Such always-available
> services can be readily accessed by TEE client drivers via QTEE's
> object-IPC protocol if the service is registered as a device on the TEE
> bus.
> 
> One such service is the EFI-variables service, implemented by the
> uefisecapp TA which enables kernel clients to access EFI variables at
> runtime.
> 
> Maintain a static list of such always-available secure services and add
> support for the QCOMTEE driver to register these services as devices on
> the TEE bus during probe.

Is it always available on all platforms supporting QTEE?

> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/call.c           | 160 ++++++++++++++++++++++++++++++++++-
>  drivers/tee/qcomtee/core.c           |   9 +-
>  drivers/tee/qcomtee/qcomtee.h        |  12 +++
>  drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
>  drivers/tee/qcomtee/qcomtee_object.h |   3 +-
>  5 files changed, 177 insertions(+), 8 deletions(-)
> 

-- 
With best wishes
Dmitry
