Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47AFF3026D
	for <op-tee@archiver.kernel.org>; Sun, 15 Mar 2026 16:33:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 07A244386D
	for <op-tee@archiver.kernel.org>; Sun, 15 Mar 2026 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773592436;
	bh=r4uSaf3GJ6Nw9d5yDC2HI1E6nLA+Zl0IQUZcyD++LuI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JSHLW1cHolFQXvaQmp1SgsEcHoUqNM8v2ZexYBbv1eRY7QYXb3lk7/NsxxbngZB+4
	 A9XVceEjaOo+Qoib2d6i6M8O1seeVNlCIeAkz88PFFON5hRP2besKyikDwQVymBtxA
	 FL3+vE+3dsDEShgIq3plPy9yHl9EMOo+V9laJHh+8GgDVRtxKP1EtFm/HVx+Gp+Yr2
	 rd23IwXm6EvO0jUy68zEs1qLDSL086KB+wjO7pItQoKWd4soFsWS5zo/ADyhW5F3Jb
	 OUxPn1s2SpUyeuMGbqsgXarBkyBZrQnuBlZLz0TvefNxaqoGGyX4ExhoY6c4uA+ijv
	 Q+ZuHOhzBE2TA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9D4D243229
	for <op-tee@lists.trustedfirmware.org>; Sun, 15 Mar 2026 16:33:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d3KrTd2l;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cxTugJo/;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FAJmEL2419071
	for <op-tee@lists.trustedfirmware.org>; Sun, 15 Mar 2026 16:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZHVVBOqvWkV6PGqXNXeV7xi7sRuPZCVVx0iquHvkQXI=; b=d3KrTd2lXCvm8XKV
	YED+aOp4qUy40HFnCngaM/qPWxOhHX8ucT3fLzHHAWk/fMgswL1U5CYrNyMTIhkS
	wwr+k8wZuFxVJTDYv+46tq4gAkBVPWhQIr4f9TDCJw11kzbosJCYqz4W4iwNsQgY
	sHMCVE4DtkFle0Vp15ou20kq0V5R9G+5+BMMbN7Yd1yFm6Jb7CvDa1bSlrnWnyQr
	io2VZSFluqMOOFgdmWWi1D1P28EaROtTtqnbO+SzJZw+zYCawYL6fgDCt7ucUDmB
	sLVtpkzrn5fMubXIG4kRwZlizWdO8ft6F3+iZwNhGX6QF0vnFYM1L3fXGIrwTYl3
	EYI5Gg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw043jwhf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sun, 15 Mar 2026 16:33:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so3397759b3a.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 15 Mar 2026 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773592413; x=1774197213; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHVVBOqvWkV6PGqXNXeV7xi7sRuPZCVVx0iquHvkQXI=;
        b=cxTugJo/5l1tl4QiCXuffSlpzvbmwe6gRfnWKOmIyFg/uIPaEugQANN3JA1XZYjcRn
         HCUcyAyfFv0WlGif2pLtgSozW+cHffMokErVqtpyuX4bIG+tOjuZ97imRqqpe/HxsMXG
         QkSlf8/PUKB98CbiiF56MTLORzeXtg+V1q9I/qEPm2Mn+oBqJFp1G8KvdNnwYNepIghY
         3KIIcfIazFOakmYMlBMRP0YnTD2xwFZWjCnm8BmuKbYnnJmUWomGlSD2vl/lo0UIxc7Y
         24LbQdSzsjxAb8oTwymbJr0rXkGLUzSKOfvSBFB5XvnQuU2CILvFmWVDaaptLJnSudTc
         lAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773592413; x=1774197213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHVVBOqvWkV6PGqXNXeV7xi7sRuPZCVVx0iquHvkQXI=;
        b=hVgSHiLMwHV2A72keQfVv0EEprdzDRuoa5V8BM6tnuJEm856P2RWF2Hltt23N2ioFv
         4IKp9M2Ks9WETBmmGXFBt9K5l7QJS+VljSC/OurI5pMeUtHkpl+g8s0eo+3+Mj2EVoVn
         jivnr5DoZ+Qoiym9c3USfZzwIU7vw36WkwpcLJHOBM64tcOEzTfUrIyL1M1Pb2c2yyJB
         Xnhn+d480QDwPeCSURRBLI5rOqjmbswuEvg0yL+UomReNNvENDSe5urFcsPREg9/FXPg
         +iLmDsDUmRfsB6+Flu8g3rHXKioQrgBOqyYXOfyh5Qf+7rrkSnFc7P/GJK7Y2PRal7mU
         NnNw==
X-Forwarded-Encrypted: i=1; AJvYcCWVpYDxJqUxTnLlFKga0p/6LJbA7tixOKuR51MOK/np5G+DDcD+rcEprf/gHFYxgckc0BJFZZE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzVc7vCY67JX3Iz0bw0se1DB5bQl92N0ykBrhyN9tyXFuknY427
	7uVYc6mR9Rtn4fiy483EcmC6E6ERei9JLCUWlgrYecCjR2o/k+uApJiLptYD/enuentnwTIG4cq
	x3UIrGFC+eVYysfoRWsNSHIWOHb815vMdhDN/Vj2uoofGQCu0qltcUEvkoGaHT7dIUMEvP+H8
X-Gm-Gg: ATEYQzzJKQZ1ZHBw3YWA35bERvNTXZ43zy12QjF9ux+ClR3TWORinFdaJnGWTnh9QLk
	NP0oyhcXUEsTx1HuNkUhFaHqrfbWupC7Ee6U1r7PhZjOFrLZEcTCkyFkuM+xjQZK1lRvMHmOES2
	ytS2/W4LaAKU9AQshmAqMdKpOJjih9Kf+oKXbfKM1n3ZBIIGgi7VeODfQ1CmGzMUjDL+GLbXInS
	NkWytE3vRnszzJjcwf5r7kZL/X18dAv7VsknlHU9NHwe7KtmCotwpit6kNl0TGnmRQDGnxw1IEa
	OeloNd/9fyK/Wo4S7TgzblHGVba0fy0mqu+j8EF3jS8NjfAqBSt52FJCn7VcgfCXIhAyUIekQcf
	zUl2OA1W+HerUfAjbrsCehtY5KPvXiBJr26TPqGZn7n6XGcKjfg==
X-Received: by 2002:a05:6a21:4d91:b0:395:3b57:9541 with SMTP id adf61e73a8af0-398eaf95803mr8843147637.2.1773592413296;
        Sun, 15 Mar 2026 09:33:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d91:b0:395:3b57:9541 with SMTP id adf61e73a8af0-398eaf95803mr8843113637.2.1773592412565;
        Sun, 15 Mar 2026 09:33:32 -0700 (PDT)
Received: from [192.168.29.116] ([49.37.148.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a13a2f112sm10557482b3a.12.2026.03.15.09.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 09:33:32 -0700 (PDT)
Message-ID: <124f5a78-a3be-4906-bea0-a82bb74b2f96@oss.qualcomm.com>
Date: Sun, 15 Mar 2026 22:03:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-3-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260312062756.694390-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDEzMCBTYWx0ZWRfX28/KY66mTwun
 JTmLdUVxYul3CY1jsEkxAyxSW36HKfzt4rYQYKBIyVt1S0tNBuSsgjbCdRCgWmKgFhiyQKtSOxj
 Zj+7SngylePcioJTgCLlcjXF+MHkCYTMTCo1QhoMnMjZBGGBIIIbvqrgkQTx5HfhkZmPe7TRwgV
 cjK+ijjK2nKh5sOpNvFC8tP0e3MPz+tf+u4QNLig5/LlJMqHoIvQM3RiTp9OXd8CPHL+pNmwuCB
 yv166it2+VYMwtYHMAK5r+aXv89Sr3a8YgfyJBTv6T/BZVvQ/IytKQykAdSRmc+vbj1/QyOQ5AX
 W7FGtoqd/4pmITwx9t5SvH4vuSubKfdRYhgBzhdNg1kldz0MNi5WranQ1hWYcLkFuW4tpoxddJ0
 0zLOTVew0vpNOTFbZoZ+36X0M/5EGLmBG7fRUNRnhDlDT0U9RgW5P6reAmpmoIsSdMnGhDM9vjF
 PWQEUhUMHCvTrBqSG6w==
X-Proofpoint-GUID: FN_HubaiCcBmede3wwJ9lmq2RgBImC4Q
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69b6df5e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=lxqEWys9kfb/iFo5xnmj6A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=B9m6UvTZno2CEb395rQA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: FN_HubaiCcBmede3wwJ9lmq2RgBImC4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603150130
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[49.37.148.8:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9D4D243229
X-Spamd-Bar: ----
Message-ID-Hash: TCCXYCA55DQ7QDSKZXH5FUUN5OXHAT3Z
X-Message-ID-Hash: TCCXYCA55DQ7QDSKZXH5FUUN5OXHAT3Z
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualco
 mm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TCCXYCA55DQ7QDSKZXH5FUUN5OXHAT3Z/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>



On 3/12/2026 11:57 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> with S-EL2 and Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig          |   8 +
>  drivers/firmware/qcom/Makefile         |   1 +
>  drivers/firmware/qcom/qcom_pas.c       | 298 +++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
>  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
>  5 files changed, 401 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index b477d54b495a..8653639d06db 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -6,6 +6,14 @@
>  
>  menu "Qualcomm firmware drivers"
>  
> +config QCOM_PAS
> +	tristate
> +	help
> +	  Enable the generic Peripheral Authentication Service (PAS) provided
> +	  by the firmware. It acts as the common layer with different TZ
> +	  backends plugged in whether it's an SCM implementation or a proper
> +	  TEE bus based PAS service implementation.
> +
>  config QCOM_SCM
>  	select QCOM_TZMEM
>  	tristate
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index 0be40a1abc13..dc5ab45f906a 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
> new file mode 100644
> index 000000000000..beb1bae55546
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/device/devres.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "qcom_pas.h"
> +
> +struct qcom_pas_ops *ops_ptr;
> +
> +/**
> + * devm_qcom_pas_context_alloc() - Allocate peripheral authentication service
> + *				   context for a given peripheral
> + *
> + * PAS context is device-resource managed, so the caller does not need
> + * to worry about freeing the context memory.
> + *
> + * @dev:	  PAS firmware device
> + * @pas_id:	  peripheral authentication service id
> + * @mem_phys:	  Subsystem reserve memory start address
> + * @mem_size:	  Subsystem reserve memory size
> + *
> + * Return: The new PAS context, or ERR_PTR() on failure.
> + */
> +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> +						     u32 pas_id,
> +						     phys_addr_t mem_phys,
> +						     size_t mem_size)
> +{
> +	struct qcom_pas_context *ctx;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctx->dev = dev;
> +	ctx->pas_id = pas_id;
> +	ctx->mem_phys = mem_phys;
> +	ctx->mem_size = mem_size;
> +
> +	return ctx;
> +}
> +EXPORT_SYMBOL_GPL(devm_qcom_pas_context_alloc);
> +
> +/**
> + * qcom_pas_init_image() - Initialize peripheral authentication service state
> + *			   machine for a given peripheral, using the metadata
> + * @pas_id:	peripheral authentication service id
> + * @metadata:	pointer to memory containing ELF header, program header table
> + *		and optional blob of data used for authenticating the metadata
> + *		and the rest of the firmware
> + * @size:	size of the metadata
> + * @ctx:	optional pas context
> + *
> + * Return: 0 on success.
> + *
> + * Upon successful return, the PAS metadata context (@ctx) will be used to
> + * track the metadata allocation, this needs to be released by invoking
> + * qcom_pas_metadata_release() by the caller.
> + */
> +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> +			struct qcom_pas_context *ctx)
> +{

I think we should check for !ctx everywhere the way we are doing in qcom_pas_metadata_release().
!ctx->ptr may be checked conditionally based on whether the underlying implementation
uses it.

> +	if (ops_ptr)
> +		return ops_ptr->init_image(ops_ptr->dev, pas_id,
> +					   metadata, size, ctx);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_init_image);
> +
> +/**
> + * qcom_pas_metadata_release() - release metadata context
> + * @ctx:	pas context
> + */
> +void qcom_pas_metadata_release(struct qcom_pas_context *ctx)
> +{
> +	if (!ctx || !ctx->ptr)
> +		return;
> +
> +	if (ops_ptr)
> +		ops_ptr->metadata_release(ops_ptr->dev, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_metadata_release);
> +
> +/**
> + * qcom_pas_mem_setup() - Prepare the memory related to a given peripheral
> + *			  for firmware loading
> + * @pas_id:	peripheral authentication service id
> + * @addr:	start address of memory area to prepare
> + * @size:	size of the memory area to prepare
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->mem_setup(ops_ptr->dev, pas_id, addr, size);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_mem_setup);
> +
> +/**
> + * qcom_pas_get_rsc_table() - Retrieve the resource table in passed output buffer
> + *			      for a given peripheral.
> + *
> + * Qualcomm remote processor may rely on both static and dynamic resources for
> + * its functionality. Static resources typically refer to memory-mapped
> + * addresses required by the subsystem and are often embedded within the
> + * firmware binary and dynamic resources, such as shared memory in DDR etc.,
> + * are determined at runtime during the boot process.
> + *
> + * On Qualcomm Technologies devices, it's possible that static resources are
> + * not embedded in the firmware binary and instead are provided by TrustZone.
> + * However, dynamic resources are always expected to come from TrustZone. This
> + * indicates that for Qualcomm devices, all resources (static and dynamic) will
> + * be provided by TrustZone PAS service.
> + *
> + * If the remote processor firmware binary does contain static resources, they
> + * should be passed in input_rt. These will be forwarded to TrustZone for
> + * authentication. TrustZone will then append the dynamic resources and return
> + * the complete resource table in output_rt_tzm.
> + *
> + * If the remote processor firmware binary does not include a resource table,
> + * the caller of this function should set input_rt as NULL and input_rt_size
> + * as zero respectively.
> + *
> + * More about documentation on resource table data structures can be found in
> + * include/linux/remoteproc.h
> + *
> + * @ctx:	    PAS context
> + * @pas_id:	    peripheral authentication service id
> + * @input_rt:       resource table buffer which is present in firmware binary
> + * @input_rt_size:  size of the resource table present in firmware binary
> + * @output_rt_size: TrustZone expects caller should pass worst case size for
> + *		    the output_rt_tzm.
> + *
> + * Return:
> + *  On success, returns a pointer to the allocated buffer containing the final
> + *  resource table and output_rt_size will have actual resource table size from
> + *  TrustZone. The caller is responsible for freeing the buffer. On failure,
> + *  returns ERR_PTR(-errno).
> + */
> +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
> +					      void *input_rt,
> +					      size_t input_rt_size,
> +					      size_t *output_rt_size)
> +{

Check for !ctx here as well.

> +	if (ops_ptr)
> +		return ops_ptr->get_rsc_table(ops_ptr->dev, ctx, input_rt,
> +					      input_rt_size, output_rt_size);
> +
> +	return ERR_PTR(-ENODEV);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_get_rsc_table);
> +
> +/**
> + * qcom_pas_auth_and_reset() - Authenticate the given peripheral firmware
> + *			       and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
> +
> +/**
> + * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
> + *				       remote processor
> + *
> + * @ctx:	Context saved during call to qcom_scm_pas_context_init()
> + *
> + * This function performs the necessary steps to prepare a PAS subsystem,
> + * authenticate it using the provided metadata, and initiate a reset sequence.
> + *
> + * It should be used when Linux is in control setting up the IOMMU hardware
> + * for remote subsystem during secure firmware loading processes. The
> + * preparation step sets up a shmbridge over the firmware memory before
> + * TrustZone accesses the firmware memory region for authentication. The
> + * authentication step verifies the integrity and authenticity of the firmware
> + * or configuration using secure metadata. Finally, the reset step ensures the
> + * subsystem starts in a clean and sane state.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx)
> +{

Same here.

> +	if (ops_ptr)
> +		return ops_ptr->prepare_and_auth_reset(ops_ptr->dev, ctx);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_prepare_and_auth_reset);
> +
> +/**
> + * qcom_pas_set_remote_state() - Set the remote processor state
> + * @state:	peripheral state
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_set_remote_state(u32 state, u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->set_remote_state(ops_ptr->dev, state, pas_id);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_set_remote_state);
> +
> +/**
> + * qcom_pas_shutdown() - Shut down the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_shutdown(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->shutdown(ops_ptr->dev, pas_id);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_shutdown);
> +
> +/**
> + * qcom_pas_supported() - Check if the peripheral authentication service is
> + *			  available for the given peripheral
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: true if PAS is supported for this peripheral, otherwise false.
> + */
> +bool qcom_pas_supported(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->supported(ops_ptr->dev, pas_id);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_supported);
> +
> +/**
> + * qcom_pas_is_available() - Check for PAS service
> + *
> + * Return: true on success.
> + */
> +bool qcom_pas_is_available(void)
> +{
> +	/*
> +	 * The barrier for ops_ptr is intended to synchronize the data stores
> +	 * for the ops data structure when client drivers are in parallel
> +	 * checking for PAS service availability.
> +	 *
> +	 * Once the PAS backend becomes available, it is allowed for multiple
> +	 * threads to enter TZ for parallel bringup of co-processors during
> +	 * boot.
> +	 */
> +	return !!smp_load_acquire(&ops_ptr);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_is_available);
> +
> +/**
> + * qcom_pas_ops_register() - Register PAS service ops
> + * @ops:	PAS service ops pointer
> + */
> +void qcom_pas_ops_register(struct qcom_pas_ops *ops)
> +{
> +	if (!qcom_pas_is_available())
> +		/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +		smp_store_release(&ops_ptr, ops);
> +	else
> +		pr_err("qcom_pas: ops already registered\n");
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_register);
> +
> +/**
> + * qcom_pas_ops_unregister() - Unregister PAS service ops
> + */
> +void qcom_pas_ops_unregister(void)
> +{
> +	/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +	smp_store_release(&ops_ptr, NULL);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm common TZ PAS driver");
> diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
> new file mode 100644
> index 000000000000..4ebed22178f8
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QCOM_PAS_INT_H
> +#define __QCOM_PAS_INT_H
> +
> +struct device;
> +
> +/**
> + * struct qcom_pas_ops - Qcom Peripheral Authentication Service (PAS) ops
> + * @drv_name:			PAS driver name.
> + * @dev:			PAS device pointer.
> + * @supported:			Peripheral supported callback.
> + * @init_image:			Peripheral image initialization callback.
> + * @mem_setup:			Peripheral memory setup callback.
> + * @get_rsc_table:		Peripheral get resource table callback.
> + * @prepare_and_auth_reset:	Peripheral prepare firmware authentication and
> + *				reset callback.
> + * @auth_and_reset:		Peripheral firmware authentication and reset
> + *				callback.
> + * @set_remote_state:		Peripheral set remote state callback.
> + * @shutdown:			Peripheral shutdown callback.
> + * @metadata_release:		Image metadata release callback.
> + */
> +struct qcom_pas_ops {
> +	const char *drv_name;
> +	struct device *dev;
> +	bool (*supported)(struct device *dev, u32 pas_id);
> +	int (*init_image)(struct device *dev, u32 pas_id,
> +			  const void *metadata, size_t size,
> +			  struct qcom_pas_context *ctx);
> +	int (*mem_setup)(struct device *dev, u32 pas_id,
> +			 phys_addr_t addr, phys_addr_t size);
> +	void *(*get_rsc_table)(struct device *dev,
> +			       struct qcom_pas_context *ctx,
> +			       void *input_rt,
> +			       size_t input_rt_size,
> +			       size_t *output_rt_size);
> +	int (*prepare_and_auth_reset)(struct device *dev,
> +				      struct qcom_pas_context *ctx);
> +	int (*auth_and_reset)(struct device *dev, u32 pas_id);
> +	int (*set_remote_state)(struct device *dev, u32 state, u32 pas_id);
> +	int (*shutdown)(struct device *dev, u32 pas_id);
> +	void (*metadata_release)(struct device *dev,
> +				 struct qcom_pas_context *ctx);
> +};
> +
> +void qcom_pas_ops_register(struct qcom_pas_ops *ops);
> +void qcom_pas_ops_unregister(void);
> +
> +#endif /* __QCOM_PAS_INT_H */
> diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
> new file mode 100644
> index 000000000000..ef7328ecfa47
> --- /dev/null
> +++ b/include/linux/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QCOM_PAS_H
> +#define __QCOM_PAS_H
> +
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +struct qcom_pas_context {
> +	struct device *dev;
> +	u32 pas_id;
> +	phys_addr_t mem_phys;
> +	size_t mem_size;
> +	void *ptr;
> +	dma_addr_t phys;
> +	ssize_t size;
> +	bool use_tzmem;
> +};
> +
> +bool qcom_pas_is_available(void);
> +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> +						     u32 pas_id,
> +						     phys_addr_t mem_phys,
> +						     size_t mem_size);
> +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> +			struct qcom_pas_context *ctx);
> +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
> +					      void *input_rt, size_t input_rt_size,
> +					      size_t *output_rt_size);
> +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
> +int qcom_pas_auth_and_reset(u32 pas_id);
> +int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx);
> +int qcom_pas_set_remote_state(u32 state, u32 pas_id);
> +int qcom_pas_shutdown(u32 pas_id);
> +bool qcom_pas_supported(u32 pas_id);
> +void qcom_pas_metadata_release(struct qcom_pas_context *ctx);
> +
> +#endif /* __QCOM_PAS_H */

Regards,
Harshal
