Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF356FF8873
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 14:15:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D390C43AD6
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777472130;
	bh=GTPA2YcB/zw30wy+DRHalzb/HWpk1KhTEVzAqq0pRq4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=KxNrSQ4JZI5qFF20fXjFzoctpt4zcrs6mJeykSXPbqFueNbcHStpt9dhm/3daeKBi
	 hk7moINRv+JFdyQftpvPHBjp7BlYJTRgUoVAC5cMAxNduVDjEQD0NbfxyYczAlBOSB
	 Jp1zj7X1M6YalA10VkPB34oCvK1kH4r/zZxHu8bcKC/gC0R9jzC/gmRcXRRvojGZdI
	 nar/V4o8mLH01Yn2P0+PfcYnF/g8oa5m3Ia8KQdqVqWwmCsGGfBUVTrtwpbJigMvIW
	 WAcp7M46oOAA8JNCqRY8kkO6IGi2tpktc+dKiWbAFjONmdQRFV162NssskCgffuXw2
	 qwfgk6vts2IBg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8B10243AD6
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:53:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=opyL4EBS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CfKRshyf;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qWIc2889801
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N9U0SUgWF2lcmbEYf0NBfn0l
	dEy8tcMY+YE7XgOzUV8=; b=opyL4EBS6uDORxigC+UcE9nHJcnx30GM4XkEiaKJ
	+EKqtzXUpLkVEyXvFEr+OwuSno+GiOYRHQD21jvxb2FquWGStamzVGChieH0Vz/Z
	tkD9WFYveNCeJLXqD89niR3bF1KWvJJqWDGIHTsM5zL2vgXim8F1CXJNrPLdIyE5
	jF+wZ40Obr0A7V0abVcLlwzHgr2W3AGwMYaPBKyX6wVizsjyIZA+knAKDfv8Pf9C
	Q+NWs/qQ2X+nP+ibrFzo9BzC8zWR2BbWcKjjxOek36vixHMAuF/9v8oCmSvRxohY
	wK0l9GILTkz0aGEXhyH5u9yBWIC+BbMaklBh3ow7gNashQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0wqc5k0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:53:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70dd30025fso16005552a12.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777470794; x=1778075594; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9U0SUgWF2lcmbEYf0NBfn0ldEy8tcMY+YE7XgOzUV8=;
        b=CfKRshyfUOh3q5X19f1vfvSQxf7UsD4bmW5kfk95v53GsdNEYj2ZRk6OJx409fWSKf
         rLJKfIEliOfPjPxWJ4u5H69a/8n4/roshggxviW+wpPe+gg/h9jWL4SbU2cKEVGnYvW6
         kdn9bQVpdsbg6ptZTlvmlLilKUioaOiaDBK0fgEYs+Bb1//vCPzEixUdFh+E4K7hiXG0
         LHXxI/HxY4G+o89wWmDj7tsbmJTSKQit+peETEwIbgakLaeXjaFKMJmfvDvQAYOV3f1o
         xLYehpUY1gOleU3qVx2WjqbDR2vZdqRHYuDqJgNPjSW4f6T7mWgEFLw0HCioDOqktvLT
         MA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470794; x=1778075594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9U0SUgWF2lcmbEYf0NBfn0ldEy8tcMY+YE7XgOzUV8=;
        b=dNHpP1mfp5rpFZJimWWwq7H3adxLT3A2eNQrmOyrO2eVRGsmYRbncua3OHuqdsb7Lh
         3m0viO+a2qQfGVsIt/eDYsEHQiMamSOEkM4urvMbTFy/g4coEOAiLTP6w0j6O3IK575I
         1drL/ltIrXwWTQD9HiMgDTxUqWod6SyyNF1cLg7s4IiSE1j9i8nwdx1Oin6167CbT3sT
         iHelyLiDjAMli1GXrTfyBJjf2D4+CbLTLjZH+NXWIsiP17icT2Is/ZGy486OtievC4Zj
         RmJNdQ1f4iRkGPstfw/Zuj1dLzaNUH8IlG8L/PzI09m0Qpy6EEiar+iQYoRa8K9J/3kN
         Rg4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+5AzgxoIUWT9wZ+hROwCNGK9M7SVmNgRDHyznC4DYlrtfjRsK+v9tXQb8Omq4i+sgRmKkB+RQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwpPAGtjjnE4MDKZkuR3sJg2XyKUa17h4YCu0VAu/1H4Qzf+aWn
	NpGs5eZSVQN454uPhyOdiKIYDOwrGc5HbuUpRCfmOu9EPbcJ/m+KglOI3Rh0/LOBZKqmnAYVWT4
	G3YD3yC67YGgVxDSIvYyn+DXZRI4t5wyJhDjKW/6B8BL9+sEeHolvE1XLbzqJ09K2traTqnr5
X-Gm-Gg: AeBDieumDxdNuliQTFFyR9vULJv0DICwsqnOcafyHzd2POvxboyWAiABvn39MJ9hzdS
	QGF6+J+Iyi1nFR+yjDd+FU2GUVBfFlvXwUoCl9XZqD0QnKMV16alv+UcRLGCqdRFwW0SvSTNJDO
	pj3Ow3hnPFPLewjgTAZ/AOD2q1UYIA/VflgfjdfUJlqKkwgxPCbLCIvMpH+um0CZyLv1mQgC2kB
	L+9QZ79iOTHz0Uv1BAd+jVV4pxsufhyXJ5fsSsC/XqdT24Uza82NUbHwxpgcguTA7SV+UmBLt9O
	ONbPu3PT8AZ7ujE7A35V2XINVVTiNhK5xxxTg0HYtJcX6NWE/wnWtOGflqnx+kBDrEWQzTuZsGC
	lDO7JxxkLb1nsTPHFIjMf3r+MraBNY76RXFfhUKjey6E5BDKD6FcOiUnqfFo=
X-Received: by 2002:a05:6a00:bd0d:b0:82f:4628:4198 with SMTP id d2e1a72fcca58-834ddc2db4fmr7647891b3a.31.1777470793699;
        Wed, 29 Apr 2026 06:53:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd0d:b0:82f:4628:4198 with SMTP id d2e1a72fcca58-834ddc2db4fmr7647813b3a.31.1777470793036;
        Wed, 29 Apr 2026 06:53:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cccc4sm2190396b3a.14.2026.04.29.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:53:12 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:22:57 +0530
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 09/15] remoteproc: qcom: Select QCOM_PAS generic
 service
Message-ID: <20260429135257.utgighzczrbnl6cp@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-10-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-10-sumit.garg@kernel.org>
X-Proofpoint-GUID: _ANOzIbLsreuXak0CDK-I-x2q_lygjmJ
X-Proofpoint-ORIG-GUID: _ANOzIbLsreuXak0CDK-I-x2q_lygjmJ
X-Authority-Analysis: v=2.4 cv=BfDoFLt2 c=1 sm=1 tr=0 ts=69f20d4a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=L7XPiZuQ2t1DW7kJCHQA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MSBTYWx0ZWRfX5zMBrbJ6OLfJ
 X/zAHgJPBpoM6q3LuLD88bfqC3VFt/4XaFjCXgDfBki5PpCYJvv8R5rpMgIqWhplzLWaZIMRJm7
 VollZQnZ4YxgMXqP8q/7VegQcAcxs+0W70RKXIQMVxFnxQaYeVRssGrVLdlC6UoTu2mV88VNgaJ
 nm3YEluzBDQlm5wdD2EAfc0X55Y/zL/7ospQ/j3o+/1OglZ1idm4AVCMVtzLd/a460UgH1iEMny
 lbwO9gC6bL+OX7bZF+tQxJWAFJW7ZHYVoI6HsMPVvPOGLh3klXA2+6zu1xEnLVL6v+QhePoud+4
 T9dx5wIUl2DWy0XAlVhWp/NK/DciU3isXpV7rZEbY3xh0VuRJWrcv51DQ/U7TCA0zAfZVF/hBjH
 Zvy3pxSSYhu8eYIi6D4+iUILvhUs5Y31evOS/5PTc/sF072jwj5JHSUX3moVq9XmCNNAbCDMYzY
 pyfn1gddtIhKD7lRhIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290141
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.77 / 15.00];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.17)[88.87%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[209.85.215.197:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8B10243AD6
X-Spamd-Bar: --
Message-ID-Hash: PEWBOLYINUICYQRHUHI4TZYCFRRRTLIP
X-Message-ID-Hash: PEWBOLYINUICYQRHUHI4TZYCFRRRTLIP
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PEWBOLYINUICYQRHUHI4TZYCFRRRTLIP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mukesh Ojha via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 03:25:57PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Select PAS generic service driver to enable support for multiple PAS
> backends like OP-TEE in addition to SCM.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index ee54436fea5a..da3c5d9562ea 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -230,6 +230,7 @@ config QCOM_Q6V5_PAS
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM

Check do we really need SCM now ?
Why not the change for WCNSS, MSS ?

> +	select QCOM_PAS
>  	help
>  	  Say y here to support the TrustZone based Peripheral Image Loader for
>  	  the Qualcomm remote processors. This is commonly used to control


> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha
