Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0CE10ED64A
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 12:10:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B8A7443956
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774613438;
	bh=7RB9EZqPtA0omj+QCweCs4rq3RGq8GMapB5Xh18U0eU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AJV7QxebkahWprWv8FfT7LnXp/87A247NWvdVl3ToZGrEm9dXmdam41fg9yJ4fyV0
	 wmywBlncylLFnssKl8w7MIqQtW6Hzp9wfhwDBxBU1aUuiHKdP5bcFlTWgzSxdrzzVS
	 rjMVK7ds+aYHXqbv8Ph19vhw5Tw7zO+d2mFx1w0zVcPdkEsDBUzC6vv0Ik9C1DtTA/
	 WCxOnxIgrXgpBsr3ppDTboaLkXPaoLQaXhaAqx7eXc+N9j/QCDW3ld6Ij7sqVOy81a
	 L4P8dfrWG6VJj+4j4oFG78uIzvaftPE5H9pudFAXGL1yel54MLa2RlFsnbug3WoRca
	 0viSv4ArlnmeA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6AC2643956
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 12:10:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Up21IAxv;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UVxIV0ua;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6vhYj2379049
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 12:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EE0yGsx0mvjT/GTmYnfC7r+2Fd45Q0DeobTk/gC7vvM=; b=Up21IAxvjvhnBku5
	1WEMR0plcKU/8LVRwfLOzTqQcWm/3I+FpNYWTAfJE0dN62SjCAwOLiTXkpyOBmi1
	F03PkTNDHh3WcdrldG8ULdMLmcQ/Oc1kjap8+L8KgAcO8jdGI2IPNhmq6/HEfpLN
	Hx1h95vFsrzsa8PP4bVyXCHqy6IdyUtoYOcjZ9fVYdltJ9tbzr/xQ7sFTf2LHYD/
	4rqENwzKnPuPHAvJD0+JtODzjxU2VRtX1Vdi6PlvOy8X1W+bHnHXA+pCGN1JHGBI
	j58bnigDIr+KkVbhN90OmOsKB0BKxod3uqxB7+n9v3z69FMEDlvgerGGDdh7lqqG
	2Kv71w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5jcx1s2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 12:10:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso2641795a91.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774613431; x=1775218231; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EE0yGsx0mvjT/GTmYnfC7r+2Fd45Q0DeobTk/gC7vvM=;
        b=UVxIV0uahT4zhovFxfzdTcmmoBOV6UAn6PKrLE5eUu0eUisH3PheBomQmjiPi4HNsT
         Ic25Qj1S16jMD/lvj8XL8vrvtXz4IDkI+xzss/PwXQNI0KVzBvKtgP1NvIH97M5ly3Zt
         xnY5ruNYAYZflKnEz3DiNtgEX4NELhYPbjORooFUlOexG9b7uNrXmhunk4KIXFgjvJHJ
         Gm3IimGqIhMf/NEk4tQuQfT1wJdK4x0SZd/e5EVgKajUFr7hXbnkM/gwpqWX/ipSW078
         iH5XLAqNXYJTAgkjIwzDArwtih+QD86+vmjcepMgmEWQ6u8za0hAYDPDnduV+W7gubtN
         ECEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613431; x=1775218231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EE0yGsx0mvjT/GTmYnfC7r+2Fd45Q0DeobTk/gC7vvM=;
        b=bQScpJm1VPdyf/ooFvxELM1KKQZuUQLkvGPbhbofRKY5wiPIeEFaIsMsNaOrH52LcX
         Dq9Yzf6X9Kt1elc5y9F26PO+m5BL23alfkH7o5munaTFv1t77de7thoshBqMZ2vmdikB
         UFs5/db2iO/1aLql8LB5TuDDPSXGxhtlS196F0qCtFOOKPPQPBiuYIdXS0dSDMJJ5a46
         4E4Hahhj/GljCN/4Y1hpXZDNN7ilwGOqFGHDu0XZgGEbGk3GCkWryKGd1/+HDXGLxD/V
         mctg5ZSlt02eBYcoU6cI9prcqXt86a9YshWzCZ75p0wamfm2G949Jhvfi3iCThSIEyaR
         xeOg==
X-Forwarded-Encrypted: i=1; AJvYcCX6FPerD904mxybWacBVV/2F4/mFbCr9/o8NtVJh5GsbqUztgmkvMjGhiUJZEBBvfVu9g+AY0o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwSSVTEPqmNfE+jXyQFf+qRmObVdt/AVQ8lDEDfmj/VLP7i+iUK
	U5eAZF7DKAjJeDSyXpTArzlMPbSKoN1EK5mGWxsYVcFSBznyt/TdpjxlaFy91rDI2Pb9MPPtQFX
	BXci6qOVVj3XZ/iePWNRnb8BgHzNSIseL+cdyTYE7yS98kqXjofAXep4V+8r3lnQv8mD998/G
X-Gm-Gg: ATEYQzz98XPmSqNJlNPdlNYRDa9BJndf6apHEDjaIAyXgnIMApzISHzO0UScm1Pdfk/
	6dwdFNvZbgLefd2PL5TkbDM8TT9RE3s5+Bv/tM94dvvSrhO0GEdp7P+d/IneOj6rmYMZuFob6Dc
	AzUQCbqyTC4PLm1Rb2wwSQDxWHmavST20S5qbqkcGQ0J5iaW2h1Yq1pwc1WrCN1umjQdSR3+uHn
	E5Hpfd2OT9j7Ld++DgmU6lzno1ICXRK9+hnKK2q/Cs24YfmTLZA8iyH9wlFXVlaJGxIvJ+ZeOwj
	/o8C6HR3nGQ9vUkNp8oHAlHn32WulGFTCvNxVcSOtelLI4NprRAWH1BxPwxbhZbiHBRoYCyljaF
	Zzd/u3ykCFF207TClYEQbM76xE4Pn7ukU30Xa/hxDe6Lk9QhOY/8=
X-Received: by 2002:a17:90b:1e51:b0:35b:e51a:85af with SMTP id 98e67ed59e1d1-35c2fff2c76mr2299322a91.10.1774613430846;
        Fri, 27 Mar 2026 05:10:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1e51:b0:35b:e51a:85af with SMTP id 98e67ed59e1d1-35c2fff2c76mr2299260a91.10.1774613430257;
        Fri, 27 Mar 2026 05:10:30 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a81757sm6204402a91.6.2026.03.27.05.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 05:10:29 -0700 (PDT)
Message-ID: <bc7b116d-de41-4b9a-9c84-1010e226bac8@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 17:40:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-4-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260312062756.694390-4-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NfTrFmD4 c=1 sm=1 tr=0 ts=69c673b7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=j567PbXuXaTzagYqJJIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: sPBzdMOn3-5sRLXw3P6pKo879qB2Rt6k
X-Proofpoint-ORIG-GUID: sPBzdMOn3-5sRLXw3P6pKo879qB2Rt6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA4MiBTYWx0ZWRfXyqiBPMQn17th
 xKNAxd5axSQVoZy3QrcsYHjVpUMoGlskNuHjHQWoloM+LobByR9rb2A3hLQtfii91RxvHGiQ1lf
 1lNYWlgT0PicDFtiluuydR+393hoz7TsvBzgzE/5AKjtwD0T4CMvk+bw7M4xmFa//lfNAfNCqJC
 tGawuiqVgSp3DQRiAfxTm7RJChM2PispXGztTm7adON5cDinKrDuPOXXsXj5bIrAP64MT8BGBIK
 HgSVmB1rRdILqaVdO745MtYV+4bRkq44u+RjFGW1in6dqLwd5J6KtgybvJhzsw+RcPbmUP2qTgx
 p+ogZKL3Gclhb7+KioxpAP9zazBceS18FUZcUHM5PqUgaBQzX5RYuZJtnMSfSfGI/LWXQ2pa/KN
 8YTP67VFBiRQRPUlTZ7ZAjr+DCAWjYE6XdPHDuvH4hOev1aPLUjjmiM4vbw7NjsMq3Gd0Kyooy4
 BciLgrqM1dq0tsAjAeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270082
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6AC2643956
X-Spamd-Bar: --
Message-ID-Hash: VHNLSN4DCSMPUV3UWEY4ZU3NYARJAUCY
X-Message-ID-Hash: VHNLSN4DCSMPUV3UWEY4ZU3NYARJAUCY
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualco
 mm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VHNLSN4DCSMPUV3UWEY4ZU3NYARJAUCY/>
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
> With the availability of generic PAS service, let's add SCM calls as
> a backend to keep supporting legacy QTEE interfaces. The exported
> qcom_scm* wrappers will get dropped once all the client drivers get
> migrated as part of future patches.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig    |   1 +
>  drivers/firmware/qcom/qcom_scm.c | 336 ++++++++++++++-----------------
>  2 files changed, 156 insertions(+), 181 deletions(-)
>

[..]

> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 8fbc96693a55..2d7937ae7c8f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -13,6 +13,7 @@
>  #include <linux/dma-mapping.h>

[..]

>  
> -/**
> - * devm_qcom_scm_pas_context_alloc() - Allocate peripheral authentication service
> - *				       context for a given peripheral
> - *
> - * PAS context is device-resource managed, so the caller does not need
> - * to worry about freeing the context memory.
> - *
> - * @dev:	  PAS firmware device
> - * @pas_id:	  peripheral authentication service id
> - * @mem_phys:	  Subsystem reserve memory start address
> - * @mem_size:	  Subsystem reserve memory size
> - *
> - * Returns: The new PAS context, or ERR_PTR() on failure.
> - */

Shouldn't we drop the documentation for the exported functions in this file as part of
patch 14/15? After this patch is applied, the devm_qcom_scm_pas_context_alloc() function
still remains exported and available.

Regards,
Harshal
