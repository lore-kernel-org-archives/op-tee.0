Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A57E7E35D
	for <op-tee@archiver.kernel.org>; Fri,  3 Apr 2026 09:37:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2E38643729
	for <op-tee@archiver.kernel.org>; Fri,  3 Apr 2026 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775209042;
	bh=SocuiM4ILZ9cYRA8mSWtuuuo4+IGmqWsxZXNi9/pB0E=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=1qkxWANmE8i69UPohdYcaK4lpnaQBHgwCaJaeJSaPoEYzA1gvS8Ab4dRseiX4buQO
	 6OagVeNj/t9POXZ9eGfnXxktaDa+IBRSXawKCApUYCdt+AFkmqObETQkxCvon9oQMa
	 4ZtxC6JP8sEVJUaAQ7FLK70eyZk8auch3QPHbu4AUDZRx4hVsNwHwhrEO1sgJAEPen
	 or8/PMkEbvpF426H7tVxoARcAr8tZ5UFXCyIS0pbtRDkja7QVqem+EYnWPzIYa2eOc
	 eD+lm3W+ygr1Ac9Ic8gYiW2wzDX9JDGzvrGKDlgnOK2v5YE7WqLW9Q//mEgTkgWGjn
	 u5/VRthW9xjIQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E86CC41B50
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Apr 2026 09:37:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=isxJvM2K;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gz0QNsD/;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6337d8Qq2707236
	for <op-tee@lists.trustedfirmware.org>; Fri, 3 Apr 2026 09:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=H0MsR4PHC7LRNEDJ02SXHtGh
	86o8LwWKhT/z44z5dSo=; b=isxJvM2K/Cv3Pm0NShfaaEwkY51/yH2P37+roCBv
	lYrCcgbdhQHUYJxt9ZaYRXWC20+urqqeQP2i3fq42SxtBdpAbOyHaIPnzRWp93qp
	QhAms5skdcgdocGbuW8EEkhEUxZ3sTcKnETvEuiyk1+Pm3OocQu1n8HzYcRw66t4
	536ts+kxzBAJIVeVFBFgH3T8x2hYC18mMhBZriiWcTHzQDNU9C8b+kQqmV4xadiD
	mTBOHSS2dOrTwiGXGNamY2DF5T1mQ/6TJ4GlxtarDcpWup0gReaWKh75SsJBMArq
	yJ0mRgfT8xA5wWGvPp4wQ33YQwu38eZi/2RiBGwkpqwHTg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9yfjhyeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 03 Apr 2026 09:37:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-509070bda13so29730151cf.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Apr 2026 02:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775209032; x=1775813832; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0MsR4PHC7LRNEDJ02SXHtGh86o8LwWKhT/z44z5dSo=;
        b=Gz0QNsD/VihfX5xHz39KOMUYIKRHaaZ7YsY2itu9dQplUSjoyXonKj3FiQuwp1O92O
         lbfwi5EbD+uw4uoI1j6Qe3KFjtHSrjMxMoELQeOwQHr5cNovMNert6AB3WZYgBVBIwl3
         9+vyLYg0Czy9IM9CbiUIeqeWy025h7KnjP/0d7tG8JmscIp9ebiWgfOd0V9TDMWp40nV
         FJndSlM4j0sSZnbGd/VFeEAcSjL9uz7FMgXWidM0CHy6FP5Ay8z/08H0zEZPfjByz1WW
         XH7O43yN4JuBvRo5Ss+JiMTdIPMlGvveu6UBmOS/zUf/6qEJUetTr8SjpruZ06uYuYDt
         oiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209032; x=1775813832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0MsR4PHC7LRNEDJ02SXHtGh86o8LwWKhT/z44z5dSo=;
        b=CbK8eHJ4ZRm9C7NIxmuzC1u/luuXkAwjEEDdz5LjIPyN7w8tqhMqC5gVTzlcmmYs9J
         gRtUN0S0jkr3kYv1um9jPxRuFmimiwazuWxDTGR58BcNwVrKYe9xnzICDZwqFNx66TNy
         uK1JnP6VqP3zrjaAQznGdP+2al0Qpq0qopK1zfCBcT8i96Dz4HvYCYBb9tkfy5mhDOiD
         dTEbpvmJTK6Xvs02n4jzeELtynFPkAezX8OQj00KEFr9cTCLqZ64VludA6kXJpeVbuAZ
         rNEN2QG6UPsUQN3uFXvN6QCwYsOw1yj7fTjx4W+pXLfsWh4/z+9d1igqgriI6W6sq6wc
         EtAw==
X-Forwarded-Encrypted: i=1; AJvYcCXiBUA3jlhz/n/t3E+2tqXDFlvXM/0ZVuSmY2szCbeKZ4zHTE7AIodOZfFQ43aZcnn5q2Bmqq4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy6F3WmbOsJ07SfCB9EcIK3XL/OyHw3kWlAZSHTlntxJiYVk00E
	D4Rhj3Rylq6Z4YphDK8nvUHncCEwUlJoZW4a4PDkwmvRsQxijjVNkfcOHOqFJLhOo7TW6oE+Hth
	MpCXQBbhV1FnySS1Zsvo95dGn1+wRStEjY/pz31IHAEPOpAwvykVXLjz+r8Zb2EM60Osxu4De
X-Gm-Gg: ATEYQzzIvqouasANB9XyrZIUDDx+kvphQAQh2Kgj9/8UPwausNFrrJVziyI0mHUx7zF
	zP0+FkodwPqfZMz9+OQd55kO7ZB1MkBSoKEipEAxSk0eg7gciZJvH+ET+YkVrfg8mvCL7k5PQbo
	fRe55+j6iymdDEDdz+FqfSn0zKX5tkWFOoVYQRu56ClzVOXFVJvokJAP4V5/+L6HAexwPZGZBla
	nXTWy37UlYglW8EJnauss6QvdRsOk/torX8eSB04U7Kww/qokQTkzSW5WUtX48chQaxcIepb4Sy
	VBSy0Q22ewadW0MI09SNtDhPzSw9FIxi+Oq1Xls5vHf2EqqHVemuQheb931FcbYuUIeNJsPJq9o
	V1QYs38Ahew0BRC4EkU9KeqhpkoQVKTgIr1YCr9n8FNEMk0w3ICkFZ+Kg
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id d75a77b69052e-50d4fd24b4dmr66234701cf.38.1775209031731;
        Fri, 03 Apr 2026 02:37:11 -0700 (PDT)
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id d75a77b69052e-50d4fd24b4dmr66234201cf.38.1775209031263;
        Fri, 03 Apr 2026 02:37:11 -0700 (PDT)
Received: from trex (187.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm15010561f8f.3.2026.04.03.02.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:37:10 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Fri, 3 Apr 2026 11:37:07 +0200
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <ac-KQ7e8-syph1Zl@trex>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327131043.627120-12-sumit.garg@kernel.org>
X-Proofpoint-GUID: odJVJvSVMISFylr5djJbKy_0JFBNbBIs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA4NSBTYWx0ZWRfX69Uov0pv+cRH
 oja/3N4GuDsDCh1+2eeu+ltW9x2FvBKH9oWiM/XnQAuOF7x/C8X2Vf9qAiSYuwakbBR5uXOnUaH
 acMeeNkFGUhzanAe2Vs2fWTi4xmGPSzCSrt59OB8t5B61dYYunpJveRSRu98Oq1P73q8VF8QlNY
 w84Shq1G0PIOyDoSEoRUXhnUA/fJb/xnLJ4Ip4bEcLivC6JtVPmOvfa+jCjQo3h7bnDLCWled5L
 JpnPLXmJ5Ojh2nI2r/6hHJ2MJFxhHLO0bUTcqzMuzrn+4ua2VzMmY3p8gBlNyYjBMneAqZGAkXk
 yCYM3qWWbyiOyyIPHk8OV/07DK1tO9Ilzm1Y9ql4jMmCWEbSQGpvNFiKNDGRZpvjv+pqE5n1g6C
 c1LVrzQqYh8ETqsNg3Qd3NFXVG3241/tnOLKKWYVALlr0ukRM0C6CH7Rr1b+H5kz8bk+O0YLyZR
 rwMuN+wRD5wfJzM/3hg==
X-Authority-Analysis: v=2.4 cv=OrpCCi/t c=1 sm=1 tr=0 ts=69cf8a4a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=VPdg2FrOqWfiVCzsz0q0YA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=vWT0tKtjkO2eN-vK3vkA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: odJVJvSVMISFylr5djJbKy_0JFBNbBIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030085
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.08 / 15.00];
	BAYES_HAM(-2.98)[99.93%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_GT_50(0.00)[51];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.200:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E86CC41B50
X-Spamd-Bar: --
Message-ID-Hash: LGIIOGE7YJFP4WUAOP7YGBJNKNFBZBE6
X-Message-ID-Hash: LGIIOGE7YJFP4WUAOP7YGBJNKNFBZBE6
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.
 qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LGIIOGE7YJFP4WUAOP7YGBJNKNFBZBE6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>

On 27/03/26 18:40:39, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.

OP-TEE based PAS service relies on the linux driver to configure the
iommu (just as it is done on the no_tz case). This generic patch does
not cover that requirement.

Because of that, it is probably better if the commit message doesnt
mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
implement the same restrictions that QTEE (ie, iommu configuration).

I can send an RFC for OP-TEE support based on the integration work being
carried out here [1]

[1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507

> 
> Along with that pass proper PAS ID to set_remote_state API. As per testing
> the SCM backend just ignores it while OP-TEE makes use of it to for proper
> book keeping purpose.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
>  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
>  drivers/media/platform/qcom/venus/Kconfig     |  1 +
>  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
>  4 files changed, 25 insertions(+), 21 deletions(-)
> 
