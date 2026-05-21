Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D923ECD343F
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 06:30:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 117ED44AF0
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 06:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779345034;
	bh=fq3D+X3q7ZbEaR+KGlXHcg5ZzcIxpXF+jpXKklId51Q=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mEQ6SDKejPDP0eqoJnFZTEQbCtdpE2sSwW4YIMlgjiwsrwLd7t+igU3pFCqH4/4be
	 M0tdsQqZ19Xu4e5L1hl+hsODpCz/e9b5zdOILMvetuhpr2TPgBlDi93vFqdMmXV2Vj
	 Oas65nIzhPdNcBsB+iN4tshrXKb0X4yd3IshbV5xuXiwpg1gnrzk+q2p1FAxeVTd3t
	 2y6VNy3dizrewyO/LsE/xblvez7K0ZLSAAL4yNVKSxQdjRaNxMrqYHKeIdZzpb15GK
	 VbH4WolpHpMTma+Ur+FFcQ21CGXhP4Lafyma0pRiQFMTqcX7GqQFGgi8TXQTZDb2rj
	 BXsC0yAY3w1kg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E4E7944392
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 06:30:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g7k0N3xx;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BiwCceY0;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L68qDJ3110772
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 06:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EcFnBmlGXUBnGQMannLvnZzhlvDc+81ZD8yCnd/foBU=; b=g7k0N3xxmtSzuTP5
	5D5t/X8ZeozBD6m1DF16BcKLvbd8VFULNoVRu3uRU43O+y7D1vZNfucCYlLcKJFc
	vl8fgFjDHUizBRQxRNmKP9rssOaKgSyHgpZh8HHzK+rTyzCjDzMwwK1kWDdqnGGr
	RZI7xXViQQI/bw1w8wH+Pm3wj8bhhdrR9zkLFFEE0g1Y3FXaID+SiKVJeDeihTsU
	n7YL2XKftFfGTCJSwgkijIzC05xOMpqTZr0mTHTaXR6UpEGEdecBbazHnwENBMoP
	qEe+rHKVfhZhbu85Ju9OiX5jOjVCKaDdoTrdDSJIggA/Mmr5UBtvw5l/STBp1VWl
	QsWIYQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9vhbg2ng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 06:30:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd1dbcccf6so94134505ad.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779345025; x=1779949825; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcFnBmlGXUBnGQMannLvnZzhlvDc+81ZD8yCnd/foBU=;
        b=BiwCceY05oN0l8w44+kT2IFdSQ7SxQ+BkLLL4vwdwsnDH6qDGs2xwJQ9f+OyMPOt65
         TLoT4EounasUVSnyxxwrCmrmZxNrmH2jSjN84udNUCcGkCqJ6TAoXKjyaZsGH1E/wyNL
         uibTxC3syJ0Ec6Omgu6xphvkpAJ7dcnTx55DZb9HitqDaWrqECEC/NnF1fKlJ+SR8HRn
         dPCt+xklI2tsJHNhZe43Qp4GX0dhDmhTzR032KPESI4Hq4on6+PwN8kicJ7sDY3FeR1R
         gvjYnUd3069uNKX2CdP6njD3hr1kCTGulLLx7Y0V3jdUjzLcTj8Xv0JhOG3OVDMSJBe+
         fLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779345025; x=1779949825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcFnBmlGXUBnGQMannLvnZzhlvDc+81ZD8yCnd/foBU=;
        b=JADVHQYds417xQogXT9BY2XShGf4/S66XFlCdfhznWmrjpAfgydfhUJcuSwWreRGMV
         jIGQ0ihExKH12NgRRtTffvQBFZZH6OoO9IGZIOTESyI4IOV7l1rYxODOo5V64j4KU2Yo
         1VMoiN5TlzCuAPjjZApREbCGDk5z9b2CT70I9LUOCE1aNovPCkpt6CFmfTY2gH+/5wvo
         HC/wKw4C0BofpjAtV6W8Qk18E6+WCuf/gQK7H6/jh+RYgVa866SrEZpPfq7yP+xmin48
         WSK224zF4O5gtlxvDUNb3aKlNu0WiMdlnC0CXkq3YqyzDsWb+qpaSf7Hyvl1Nhl5nTyq
         gBZA==
X-Forwarded-Encrypted: i=1; AFNElJ+n1nyKX/fxS7PGPRve+wIzGJWvD2JtUrPMguHclF7/ekTa6H4COwpFrohJWHyqA9R70gdugvg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw9WwKnVXzysFrUl7ChuJH/zQ+5pVHFb6ukSP1jFVGbRbjhbf7v
	5BkLEOHvTelhkYbQhJepSsExBoNV0WQSOq96J+yPon38k4K5RfmDGrVKt6iO4XYXoer0oj09khT
	7cSF1YPs1qheQcGa9WY2u2+dfVXe+rplN41c+gAay6PfO3eEuEM5tOvFVXzJqn/FQygqcTLun
X-Gm-Gg: Acq92OH4KR9JP4l74zvZvc14etHV9VAs/UQbtiNnezFKCsg2vcM0z7nqNm4SlsxMvEx
	Tc/CH5dV37PvcSipOLosatKPiZ+7GyQ4H/kcXl9Cz4hMzeoVPGJBtpAtnRqKl2N6oL8B5IXHGS5
	5MRjU5ry88MlAqeSS3TcoG7UbE7vhz3FP3ZzBxhmZE2QvVCkfd9hzZesdKldOi2O5FE+5PjuP+H
	xxBvrMqxu+QUzjPP0ElXx28F5kwxna0q25YBq86jstItLh1vdYaNKwshbOgKk7npx1qSfTTYZ5/
	OkIv/dwa2GkmRl1hBFtu5vU4IC2GGyLbtsjiCDy7U4PrxzJMGAidErE7kiKlIIYDJ0vyMeqVqVO
	byO8O8gwyNqE7nLTsnAzKxHe1v0UhIRw3Brru3n2sosuKHq68SyylXaO7
X-Received: by 2002:a17:903:1a27:b0:2bd:ef12:14d6 with SMTP id d9443c01a7336-2bea33e5a0cmr16911315ad.34.1779345025352;
        Wed, 20 May 2026 23:30:25 -0700 (PDT)
X-Received: by 2002:a17:903:1a27:b0:2bd:ef12:14d6 with SMTP id d9443c01a7336-2bea33e5a0cmr16910625ad.34.1779345024887;
        Wed, 20 May 2026 23:30:24 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.250.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c263a0fsm241748305ad.37.2026.05.20.23.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 23:30:24 -0700 (PDT)
Message-ID: <b62c2a16-9e73-47a5-8bf7-3878e21c3da7@oss.qualcomm.com>
Date: Thu, 21 May 2026 12:00:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] media: qcom: Pass proper PAS ID to
 set_remote_state API
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260518072856.22790-1-sumit.garg@kernel.org>
 <20260518072856.22790-13-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260518072856.22790-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MCBTYWx0ZWRfXySmHlun+1V/R
 FTpDo89e6gFbbK4lLV2YGD1kq/oPoDKNj6hecLyWxy+Ml5n/3jez2wtkPpamcMp6GYKzcBtc2Jm
 fSCxYyQQcG3dJBud/epyc4TV39unHbjHnnPPPcDo0nup2Yle6rPxWAK6P8XUkm7rYLSJiWGwb8Z
 s2a6lJhwzn7GmIc4nK1YovXJs7tALBkzEJk25hNir1P9HwahGQBHG9vtFfLl7z2XTe4h/rzKKus
 goxN3kLciHttVWEqvrkeY7igERnkgBEUUqghpOesyIusyU1LFG8mekTKuyKFUec2t3XpGbTdyin
 Rq8SI2zyonpQidSxdZpyN5C9/QNdKvq69qK6X/N0QB5uMHmW08ZS1Gk5w3Q22o1WlDq55zb8CQD
 Vn61JgXs3PyEGIzeRrAB4fHGNo7Mc5kxAeO4Tum2zhHKwQi7CmtFQ19iyr4DatCu/vbDSWcShgT
 R0c2YwOLvOWUQz4rofA==
X-Authority-Analysis: v=2.4 cv=GYAnWwXL c=1 sm=1 tr=0 ts=6a0ea682 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=X+kW/DRse7pI7A4riirJBw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Reuo-bjlSNWgIop-ackA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: udWo6UZihFPB5_QWpYlMXcMtUpTrGtgR
X-Proofpoint-ORIG-GUID: udWo6UZihFPB5_QWpYlMXcMtUpTrGtgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.49 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E4E7944392
X-Spamd-Bar: ----
Message-ID-Hash: G2XSCEDWHLYJB6X47KX5HHT5SGPYR2K4
X-Message-ID-Hash: G2XSCEDWHLYJB6X47KX5HHT5SGPYR2K4
X-MailFrom: vikash.garodia@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, sri
 nivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G2XSCEDWHLYJB6X47KX5HHT5SGPYR2K4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vikash Garodia via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>


On 5/18/2026 12:58 PM, Sumit Garg wrote:
> From: Sumit Garg<sumit.garg@oss.qualcomm.com>
> 
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.
> 
> Reviewed-by: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg<sumit.garg@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
>   drivers/media/platform/qcom/venus/firmware.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
