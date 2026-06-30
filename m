Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB3EC43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:14:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CF08944ECA
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782821685;
	bh=Vfq7tifQqkrQcDZiRviC31PSIJy8viYJL1W1oSt9PHQ=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=bHqOoRGHmGC4t82oV3nLoJ42kM3ZY7aGbWgm+GGzJyelap442dftJRGkR2JGzR35R
	 ++NqqIveclpJTuJ5a5Zdth70+IZMWxLabZnBKjRdtpRqSFmxmfbAEuMpErU6gFFk53
	 kPWZtjdTVnbDg38z60ryekCu6i9p45BFRny5wxr0lUv6Dz3pHxeMhIDlQgFieYl7hQ
	 u8J/4LYgcAap1GEVLR8iJiQBOaavQsqTMGZEPSAKCkl3UK3ZQ+dXuN02xrMyg+cx3E
	 oObSSGBeiiJmvk4s00QnkIwob2v/B6Lm0OiayTkmOrrEllMYp8xkjKjIf+/5pLLNFM
	 FRMsiDE5yEFOw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E8BB644DE5
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:14:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y1Rrhq5y;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VFqV/KmU;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nBmo1606238
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oBbce1WRUs3G2E0RY0k9esyoB3WwxEZLpDwnuzZhw+E=; b=Y1Rrhq5yt8TfNDWs
	EgLGPzpahCcr/ZfG0Sl64RZ5vc1iAyxEEkLH1gVw6YQ3d+itWHbU9H9bJAzAcXKR
	2/A+vh1LtOvqK7yf5qXmxGPN5wP6RNqQTW6KCTswuEgDz0nX8TYHu5pfcZpPeHup
	CbHdMu7jpW3GsAnLW8YjKvbzZDJ1rn867EzrtM4f7+vPrirw/3bfTvvPIzPMLQz8
	xSE6O3iF/rkQQq8UazZS2apXhMw9Q8sqNUmdOBUiGf3kKrUUD9ga2qbaEJb86ud1
	c/nDhl2v+J03zcyY/JVJF3+Hl7IPjvXeS0+icmcN1p/XJTSwqj/BuM4vw0fbh1fd
	W+wZiw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f45k5t92d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:14:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e6415f279so16979585a.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782821678; x=1783426478; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBbce1WRUs3G2E0RY0k9esyoB3WwxEZLpDwnuzZhw+E=;
        b=VFqV/KmUsjPP4YakOHiti0Dv5DI3nay/d90XKPD3dmOMHWI3nmQkXjkI4E0Ev/XgOP
         dH/uphgtEbKyJMCfJGmpDwgdRgtdu5Be6p4/dcpZcUtd+/IzDS1SG4ZSuq81023TzwCr
         mRBZ/f2wU5enb7wlnALpuw8UmLhEfUI9JhEcUMt4c1MAegNj61ymQCSo7VxHJ0lLUjlF
         04S5fa0J+oKtHniwl96zZN/JJQi0EMb3LhCvx917GmGCgZ6pE0Cz4Nx6Rd7hVbwRVgOm
         KvDMgKuAM/hYS24Hr5h9EtcZCy/ZPa6k5Njoi8zEe+xDbWBNIO08bIOVk1bsvEH7RAlq
         4muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782821678; x=1783426478;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBbce1WRUs3G2E0RY0k9esyoB3WwxEZLpDwnuzZhw+E=;
        b=NZZubj+He6rx17Bv5AsvJZYd8Rvhl8dO5aPvFF0Vqxb56ZQCyfVEKuS2tdaUsAdQyk
         zkREqChjXhs2XxT/skT+8w03h4G5stJoOgFHK5MTlh2iQCEsrleNEsuZqUS7hoSRmpMV
         cDtfF/r2zSlDKyQF2IUQorrcVrMokuLMAgeJLYHwyKL+84FuV855cKmEGf2E9eXZZE+b
         2jvPfm/ac4Zzh1azlMsst4zRd2s+Zf6Fu76jzmHyJIexztwJdi6Ltq4Mo4/NExQNJGTD
         lzMT+Pf459uu7ySW0g+1cGsSJ0/mB70XxUmdL1tH9U06C6LnIQa9fzTUw4qGDykXV/si
         8lkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XNXJO3XCrtKcC4penf3kFrYc467iFDszsIHgLCahEi6ZccAICsBMlTDGqCNtf6Q8ajr343fE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzNrUjKWS+ejsiq58R7EISU2evmSMQkoJOBOl7XqRGnUQcGYCyB
	6cE60kw5lXigMxtDuenoO1f4z46YHKqeJ3hMxeUCwoqsOPHNlyyL6LTDdA4x2MDReFydVWOgRPM
	Fm3wGaTDipeqzX34tJnf4E4Ahjpu0gtMIhtjgPVp9bPVriTPEHhWQIw4hJ28zj4miBT3WRKul
X-Gm-Gg: AfdE7cnjwbjuEQrvqO0JEtD0/gbuBfhoYHuc/LAKjPPc1sQUIbR+pOMPm4Zj34q9Jmq
	7DWT77lg3qOHF6lZKzEMZ4dqzDQf5OfSSqiYjU7gB6HcCrMh4WJj2cWLhCQ1UGYSqMiQ0YxMP98
	L2/hxtsiIhNQmmvXONQHWUZkc1uZ6VTJYRtCwLyhyu3r4EPqvSqP3yUxiGfItiS1ZcemHAZ6Bx4
	atwHFgOm6mOz12HIb6B9MtLvMy158Dw+WyqvDVeQ3qW3TgSaSj249POK7awkAHtFVaSEMwM0ilu
	EQa/k7qXJ8fasiTFX1cTfdC5WeYj5SrxvMX++H6GEcqew9Xp2rGht5jDUQpLmQ6zWaf2GElLP1w
	14hxETRtYr7wJHsoKMMMqK+gFIWi86+hrCNQ=
X-Received: by 2002:a05:620a:2589:b0:915:7c1a:1388 with SMTP id af79cd13be357-92e627e197cmr355400485a.5.1782821677737;
        Tue, 30 Jun 2026 05:14:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2589:b0:915:7c1a:1388 with SMTP id af79cd13be357-92e627e197cmr355395085a.5.1782821677127;
        Tue, 30 Jun 2026 05:14:37 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1296b1f9cesm21325366b.16.2026.06.30.05.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:14:36 -0700 (PDT)
Message-ID: <dc7e58d3-4383-4d93-a38e-699888bff903@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=6a43b32e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ltt3hjjT39zhUWiMmRAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 2t40GkCgf9yYOph_NECEW1JMStza1aed
X-Proofpoint-ORIG-GUID: 2t40GkCgf9yYOph_NECEW1JMStza1aed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExMyBTYWx0ZWRfX5IJjT5Rs6uVa
 ycf7sYDw2Na397tZYTcwC/wE01gXx4bOcvYHHCeEx2wFohY73HfzGl/wBigpetmAOdEVVIYEB2U
 3gDqbNw78ZxWM5In757bDS3+k897Zs0SfNoXmkkRH/tGjOPH308UHZXsTyUYfi4IhezA29zlh9y
 GRHNOXhAIqv1rEnejqX8GqYbo7vYpX76eB49jf/gxwKu6/Oy790cce69VNzJBrBVSnCCsKBlOsC
 l1JjemGSirD6lJdSNnwoTgp8WSGXLej2vw/vOzw1aqoi6MvxUCMbLUJJIi3TJ67qD/5gdvashP9
 LgEoJXoaxSSqEsrpfVRW5zBq9DxvCye8yiGOaFZ0ENRW3N0aeTSrhj8HnyHLuf+0nzlaN2O11+R
 rsFB8pD4uhUZCYSYYiexwGDsZjBeD/ZOUgG//g1Zervd4tw3SqmXoahNEpxZ27Kg0qcHc5v6+fH
 iVgOM2DnpJchH+uoj8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExMyBTYWx0ZWRfX/pZZ79A4iTC2
 EuocDEgMFGges+2m/4dAl2JS4mZIWqPHWys/bqVgOWi+Rez37DFn2oXT0BToev95+py8N1/U9gV
 xCaQ4j3D93kUuCMQEYTW3CsDm1JrwNI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[209.85.222.199:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E8BB644DE5
X-Spamd-Bar: ---
Message-ID-Hash: 67UYTB4E6V3NU6GLSN3UOKEEO3YL7N7G
X-Message-ID-Hash: 67UYTB4E6V3NU6GLSN3UOKEEO3YL7N7G
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/67UYTB4E6V3NU6GLSN3UOKEEO3YL7N7G/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.

[...]

> +bool qcom_pas_is_available(void)

This is the most important function, for which I would expect
kerneldoc be present. I think it also wouldn't hurt to add a
footnote in every other function's kerneldoc saying that this must
be called first

Konrad
