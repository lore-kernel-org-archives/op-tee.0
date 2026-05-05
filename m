Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D92CD3427
	for <op-tee@archiver.kernel.org>; Tue,  5 May 2026 14:27:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A7A6F444A0
	for <op-tee@archiver.kernel.org>; Tue,  5 May 2026 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777991241;
	bh=g+7IKxhiX7ztjndPO88YYZeyrSmovrRfOEc4pWd9eqA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=VPYP+ZAV4GHVrqhDl0vBUGstnLolMAiJPdiO7b0XV6WWE56DHY8ntxgRTI2DbXhht
	 tzNKNWUqj39J7zgL9wv8jesUUmR8UKfW8FmvC+Wosk6zYcEcAZVYAWESm11dPiKGWf
	 WY904afAzluI2cmjYK1X+vinkZhUEEdfyRDAM9NfGrIzkhaIfiBR2sPyIXY90++7V9
	 f5PlEhttJ8NwqmMYSZQClGuQ0pe4j2YOxn/r4j/NZp1P6gzEWPTPS1o01Xq6UFeDJS
	 9I6nUrKugIBnXYLLWf7sFQuf+zr6cYUs0cr39eCujbV74dF3X6hUcr9Cd9hMOcaJcL
	 9fCoikaoPJzdg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3F29D43035
	for <op-tee@lists.trustedfirmware.org>; Tue,  5 May 2026 14:27:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VElEevCX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yk4hB67g;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EL3SJ152184
	for <op-tee@lists.trustedfirmware.org>; Tue, 5 May 2026 14:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pySiRqtx4zsZPi7B448XCfGRj+cLU/DeaDKDCajYXho=; b=VElEevCXAp/4eN7D
	j1foutEYx3Vr8neaXKIuICKqkE91uo573myvYqdDi3F5IXBbLooVoYNRod044YSw
	lR5mKzu4rIzdWRx2d/JbjvPxo63qQzGipzt1YBAOZDb5CwgrEeUBk9SQBK7yl7Op
	RnlGVj6RDVf2ezLny5rvOLp51ciXeHa568S8WVA1PeQpTaKKwley3XRb2f4jQskS
	Hmhv3KZWzdQeiQy5aE63//4swak+N6C1OmAAB5qmJA/QhPhJGZUGiWR296GpH8oC
	jGb+vyiCVHK5mJH+jvYSckZJgpYqawQ3A0oPr2XYkR5r+kxenrr5UZyU9vAXrI3h
	JzsaVQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj8080us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 05 May 2026 14:27:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f1383b7439so1925014eec.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 05 May 2026 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777991233; x=1778596033; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pySiRqtx4zsZPi7B448XCfGRj+cLU/DeaDKDCajYXho=;
        b=Yk4hB67gFBtySDJ/7TNVOwx3I4vVJ4lwyM9amwPrLHUQqawbqWVs98CeJdytq0fEPJ
         ZEEPyCSIDwstHgJ9ep7qfqNllgtvrAwIv2clxIAd5Ycewi8lgbRO8hyau1S3F2fuiG6V
         BziBi2ElnzuyeMYwVzUR+Sr8tCC2Qua15AVK4+twqH3ZvcfCXC6NFsToCgOPbcxrvW5L
         btlFuCT4SM3afqTGGgwz5uut2YaeRmwDT/SfqYJ/HwChcNXPWxMC8ywC7t+rwkd8r7NN
         TTmQv8yJoWq6Zds/5M7AWI7DLL5R4+cAm462MTWVeBRzWSR3h1l4qxgN6oaYrWPE+Aqh
         So7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777991233; x=1778596033;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pySiRqtx4zsZPi7B448XCfGRj+cLU/DeaDKDCajYXho=;
        b=qVInK6K9O0/PiQYP20P48fk/ObUwBPBWPn3ySkxr123ZPWXbxE5sSd8HgBodB+99jP
         5UH3PaEX2Pt9/SQzReCy2fHN2kk2uxKk61ft8jxDSJgXD0wxnTDRiJ6qhV30t7dvHFJi
         htfSjGr/CCW6X/dDRPZW3TxYebjPxke9O6WIxV43DkLe9vF147o+dqH0OCsZHHNXNSJB
         YJ/6VfAlf0pyaCzvAqKP1bRmCdWVsr6q+qVy48xNOmv6ZeZPcFWToHxUK/xStiZ+v7WP
         Lx5L9M5egKKODqi24RqeUZIIic0souhSegtjBkuTK1EVUJ0mIeyXx3ZDO0NuPBI7trSI
         HWQw==
X-Forwarded-Encrypted: i=1; AFNElJ+2gHmud57FXJcBpXd9aVq02uCsxTC9Qfopt6sl1OaBXeAUFM505CvZc8ReEEIJkNV8Dy5cOsc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxF/xa0WKtZu8Yk/4vFN1VhPOZktVZ2cVEmcLev0yv+spcY7Lzg
	CKfIaCUsbLgaOpWlDQIQRMge5FwjU+bgDfGHDGnpD/X66BlLx6DanbGdQSCOpwkefwVMz04R61q
	eeWpUr5CZsE3Q3SrAFU4d5sDTlrEnamw5QWFwptxqfrkGF0XyZSxOreKDapesJuilIQCYRrwc
X-Gm-Gg: AeBDietZTrU3CJbeQ5mzWZkdpkK5WWqWsIJF2xjR19onRuBkIFrkT2UMy6JiTwiscn1
	sKA02d8Z9VUYc1mSRwi2bvAstVNwPKm/I350V6Y5tTVkuhrbli2surW/Tkz37Hr6L0Rqfg9TPvU
	1gqzrfsk57t9UcpKYr/M6wuL825NE8BQXdHXKHnStjud669A5x5VfkpKcTLNxuFhl2wnh+yx2fq
	aeCaZQC2oxNYwLpIqn9uL9ZAVVxW4u2yqwb/egh9ehokjSmKcXEtPPckkkYMn7OaJfi3l84OfJZ
	H7qhTX1l9P3mSUFYboDE9cIYQSh0NkvNPz68krTgZNlz0Dxd6fTkBmkNcXqQnvHldOob11Wxot6
	K7b7JzYrutOeb8BGGKEBgZ5Oj1Ii4A2X61i7byDRT4HtgwycNYCTueJZtq5w1kuPMpM+bcrmLiW
	Zpwbj/UBkTeEnYvhGm
X-Received: by 2002:a05:701b:2507:b0:12d:de3e:86b2 with SMTP id a92af1059eb24-130a9ffb6e3mr1020203c88.21.1777991233075;
        Tue, 05 May 2026 07:27:13 -0700 (PDT)
X-Received: by 2002:a05:701b:2507:b0:12d:de3e:86b2 with SMTP id a92af1059eb24-130a9ffb6e3mr1020185c88.21.1777991232530;
        Tue, 05 May 2026 07:27:12 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84252c0sm23637548c88.10.2026.05.05.07.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 07:27:11 -0700 (PDT)
Message-ID: <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
Date: Tue, 5 May 2026 07:27:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
 <20260504130603.1474043-15-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260504130603.1474043-15-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XvnK/1F9 c=1 sm=1 tr=0 ts=69f9fe42 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=_vM1m9lfSBLZ1nnPSXUA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: w9yJoRVhEj4DuRHMoIdbNBbmENmL-CxB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEzOCBTYWx0ZWRfX3IwUEj5yvytp
 DAL0f0ex+IvM5COR7DvdT5fIIdDha7cAlD6xHvPcwOSaIq/FNWVR1uHOSWCFddJZqVR9MAPSeRO
 oEffjXVIiQqC/4aB3Gah4e71DQ+LFn7Nau13Lqav9LTgA/yiIXvmTij1HO7QLSh6OzAe8xoQWIj
 /OnOAI5p4l55An9vxYzI4xcksMxwJ2ZN0BmIzMnev+dyz/iVny5eXq1KGD86Vex6ntnY/uC8HxZ
 EoRZUDdP30pDW0w/CjRATd6/T5OSOQ+Tr3NgCEkwvXBebcIsZ3aHerkmTMu8aDIK+FUqf/DdM0/
 QlbX/08g7yHIl2CFojVwddZTKpsfcztrceLYd1onepCygpb5AJ3sOqB6+ruJ6oyX5e1hTq4KnlA
 WI2RZvwDxtS476+oi6yyWDSm65du/nYt61JvlCi9NSW8cEj0aObp22pW65qXynIm2AjX9mctrN/
 h8Isq3oAEboJ8CVkU6A==
X-Proofpoint-GUID: w9yJoRVhEj4DuRHMoIdbNBbmENmL-CxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050138
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.88 / 15.00];
	BAYES_HAM(-2.58)[98.11%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_MED(-0.20)[199.106.103.254:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_GT_50(0.00)[50];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3F29D43035
X-Spamd-Bar: ----
Message-ID-Hash: V6DFO56TLC25RLVYFMSY26GBVZ5XN4RP
X-Message-ID-Hash: V6DFO56TLC25RLVYFMSY26GBVZ5XN4RP
X-MailFrom: jeff.johnson@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/V6DFO56TLC25RLVYFMSY26GBVZ5XN4RP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jeff Johnson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

On 5/4/2026 6:06 AM, Sumit Garg wrote:
> @@ -485,9 +485,9 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>  			 ATH12K_AHB_UPD_SWID;
>  		/* Release the firmware */
> -		ret = qcom_scm_pas_shutdown(pasid);
> +		ret = qcom_pas_shutdown(pasid);
>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
>  				   ab_ahb->userpd_id);

at some point the "ret" param was dropped, and this now generates build warnings

>  	}
>  }

