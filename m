Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229C8FA1FEC
	for <op-tee@archiver.kernel.org>; Wed, 22 Apr 2026 20:04:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5127644A47
	for <op-tee@archiver.kernel.org>; Wed, 22 Apr 2026 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1776888265;
	bh=Vw5lbIz93bfPivnPlgZTf922sy3wFpATm4HMbXkasxA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eqIHq/t3xlpUH5yq4mVmqn4aPSmF6EBSgh30teKhHssfx1dA30Xv042h9F6BFzklp
	 1x8e1FSUA3Yu7aQ7BV6g0mWUTexnbDmIXZEvevsgmiqqUxtIzFzFHB/ERYjNwknwXv
	 PPeF/Z8DaEp49VSyllHRFg3ofJz4VeJ2pSyZdXDEHgmNiSYYqu78DQsWnE7rLZCOwP
	 nDzZgtUvHp08Dm14het6EmWSf+b8mmVHFeJrdmjj3yKJABqD0MHzkarch0ykfCTRcm
	 F0ZwZzpBUnNPxVt3dno4qNY/NHA9svau8Gx1bkvzQuLv8M9Ddr/vnYOlip0wtBXQ4F
	 XU4NqTu4xrY4A==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 005DD434BC
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Apr 2026 20:04:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YtLDY9uF;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dns2iq6z;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGqWPk1218367
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Apr 2026 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TWNv/n77xtlQNACjJ3+8jJLY
	WYV7KxtU3j5KJIFZm9w=; b=YtLDY9uF5xOkCoR8E3Hapt6dWg8lw9y4CViURo4X
	3sj1xGiBYjfiOlGRP6eA/ix80qQtgSD5BDXQ3OUdZi2TY8vDwvtnHONVZG5N4Mtp
	Evjab88v4Ddg4qOo+pRr/xWx9Ns8qPgqG9+E9Y5FUY1c+m9NyDi490VZ+5rT9V3X
	rNy5DzOcpX3JpNZdLuhslsk3tCP+DLqiJIYsqlrsEn3PjEuWX87GqgAERsSGEPLs
	4Q9NPD4F4ixz33UAUspYkKvlTw16b6m5PgJ3Hig/XunesxrltP8r2sSMMsafu2is
	qNEkRl9ZPlkFePAbtM2xVw8xZtpC76DJp4eX5vb3NdhhPA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq282rp1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Apr 2026 20:04:17 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-956732444ffso8879126241.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 22 Apr 2026 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776888256; x=1777493056; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWNv/n77xtlQNACjJ3+8jJLYWYV7KxtU3j5KJIFZm9w=;
        b=Dns2iq6zitTygxXmvQD/X5nh9hQOVEbKdx0Tv4ZSog1RSGpy3tV2hypyQJviTQuPuX
         rmTW8FIKW8TbIXTtz1QBnJiDuSvHsSrJOE5iA9ysPIi37JL48JyuAOL7KrJUN7hPSh5P
         If14iLEH82NhVf00zldvvzeO0nwNyUZgZcFesoFGh2O+5laWKfxgRmdELHSUfhvLMsV8
         qXGJ3ahw6heRXDzAh21Z/2sq+No6TpKRaucKD4T74riOxqqoUUtO2FVRaoZLRJIDii7M
         ZUGONFBmkoeo31otEfRTvRidrt3hPfnISJcjcHap7VKe5NUH3X/puyL3me/BX6Y5ihjV
         BMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776888256; x=1777493056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWNv/n77xtlQNACjJ3+8jJLYWYV7KxtU3j5KJIFZm9w=;
        b=V/ydrJ4fFF2xi0djEAYcPvuvznCC3z5cNaB+IaEcHyt71p/+GOMkJDvs4ldsbM7H9p
         q+b5JNSQqE1QAa2aTD1VLbZJslzn1bMmaI7yPBBs8/EKu0BP6fBgkSW8Z3+RZ0uP9T9U
         X067ansK7eD7fZg3gWxvOPkRxsDf0ObrcFTZCk6ZcFaPgGKYqZ1DSoxOv/+Sewa7CqR8
         GZBs5xbD646UIFW6vu1BvkXT4IkIelfeb70bzAEkf+YHmlfGdpDNLHqEwcvUvJc/+NKj
         CUHBSHbWLxr2k/h66hP8Dtm9M98v65zIllS4kDLClvs3WhR83PWwEK2N2XQ171ZDTYsl
         ziYA==
X-Forwarded-Encrypted: i=1; AFNElJ8MUO7POYKm9XrH4lwvO6eOAyeZzxHvhHmnu3R6QbCFQHL2o/pQ5rzOvABNKzV62wKXWat5x7I=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzjttDmU6K42qLP+YPsguIX3pxtP/9EFzMy6Y9m5MmRsiwidPJ7
	B8LVR7AyYQlooMXlKw/XOoLC9oSGNXzg1GJKl7HXgR7++E3Jh3V76mO/6/EPtzuQSSi9ICqFtwp
	IHY4toKYpDVqG61zvOMXhpTOqN4ahMfqLDfMF2ufg2yMyVexC3wn30jpZ5YMNuXpjhidcNupr
X-Gm-Gg: AeBDieuZk5+2IgEIfKlZrsg8LNFgMtlGrlxgIg3l6exhxEyHmyKOpF73xV+dix/yPR9
	xpS8kygwaFz0iTc+MvIXOV0j7O3Ue5F+jlN0j/HhTdgflZqLCogmmYMFCHTR7h3ur6dBAUxrUBR
	hRce4xwrfGRZP3shdrs74AhwoT+JIHCaSWNiisf+6TThaBwcHss7hnSrO9FbBLBiXpxF9a/+nPH
	Nh6hvK7r5b6RgIlJVICr0+FUtYTOyL3h4vw2B//gtrjLMGOuSNLifseBqauWpwcBn5Z/B4jm940
	Vp2jBJ3BdXkmZCbM8fapYCa7lwr84RJY8nDtI6FTNZwTNauxqSh5yVQN4CLbQLKohwVpKTew705
	1SbWje68CsNwtTHMv0LUYKtVGTjojPTjje5fzrG61uD2Nmtz60TboTS5i+hh28VY5B1z8gCcjHK
	YISpQs5Q+V2KuQHySwipy7JwFC1wJ/nEZC6XEaInBJZA/spw==
X-Received: by 2002:a05:6102:f9e:b0:609:4d86:77b with SMTP id ada2fe7eead31-616f73fb077mr11984440137.24.1776888256339;
        Wed, 22 Apr 2026 13:04:16 -0700 (PDT)
X-Received: by 2002:a05:6102:f9e:b0:609:4d86:77b with SMTP id ada2fe7eead31-616f73fb077mr11984380137.24.1776888255894;
        Wed, 22 Apr 2026 13:04:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc25csm4689196e87.26.2026.04.22.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:04:14 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:04:12 +0300
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v3 10/15] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <fuypqlwseulyvlsgiq3dnh3kwhernjid2yqljiwmrxufzfuukq@mfy343uq5gs3>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-11-sumit.garg@kernel.org>
 <aeduRrAMOAW4f5TU@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeduRrAMOAW4f5TU@sumit-xelite>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE5NCBTYWx0ZWRfX4dyMQCMWAu5Y
 OAvzU41oIbh09BfRM8+bZfWAforfpSL6XwF7iH1oGaHfLI9ix8fpuCrvMf6NKNh//gcr+hzeSqY
 4ioMgnXQQmgH1e688SSP8PxLZxSz0eNCPawXyPmVkdzX1fga0Y2UFDuDnTiX+vTAuivTUswJuw1
 Ds0U2Xu19UZPWI0mVS81ULBNrjNchdMLHNcPChK9Y2B1ZzJdx7TuLjSMME0VQQoJyKFidhz8drd
 Z0q3fZoFoN/mchh2czYALnw+u0cF3T7SyLP1rnOrXmLxd1KM0C4bReyMHVPwLi+BzMRsgMZyv42
 xmOCxKEdGGjnPLNnG73dGffKuQ5YFkj+bJUwbgvMYN8DTyz+y4Kovmbda0zuhTl4u+KVSSUIy9A
 VlytkNK9kQAhbx12L9S+iWJtK4ImFAC/HMyJAFAniMRz35kqzAl7jw8SjpwyrwtXzTy3qOxQkFs
 4v7yqF+wUIyReXu+DQA==
X-Authority-Analysis: v=2.4 cv=Zond7d7G c=1 sm=1 tr=0 ts=69e929c1 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=dgZ2eqGgcVFd7X0fNysA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: Ckmv3YKFaFFAuqs3u2Mdw5yVQsh4PS1c
X-Proofpoint-ORIG-GUID: Ckmv3YKFaFFAuqs3u2Mdw5yVQsh4PS1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220194
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.71:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 005DD434BC
X-Spamd-Bar: ---
Message-ID-Hash: CFJX24DVXNFCHXA4ZIFYAKWUAMISHFHW
X-Message-ID-Hash: CFJX24DVXNFCHXA4ZIFYAKWUAMISHFHW
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: lumag@kernel.org, robin.clark@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, sean@poorly.run, akhilpo@oss.qualcomm.com, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.
 qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CFJX24DVXNFCHXA4ZIFYAKWUAMISHFHW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Tue, Apr 21, 2026 at 06:02:06PM +0530, Sumit Garg wrote:
> Hey Rob, Dmitry,
> 
> On Fri, Mar 27, 2026 at 06:40:38PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
> >  3 files changed, 9 insertions(+), 7 deletions(-)
> > 
> 
> Can I get an ack from you on this change? I expect this complete
> patch-set to land via Qcom SoC tree.
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
