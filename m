Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A579EDF14F
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 10:24:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C309543811
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770978274;
	bh=RCRWaN4EseUjZG0/eyN2SoESXj9Yj3GYmJ6N800nYN4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tADiGOVrk6LxixAY+X8xzL1nITVxEOBEo903zphQebHXSw8VuSvyt0m/xJmRgJZvC
	 xjhVDRsyYMJ57f9YGU80r9JOupH1LJb06INmEsadRsAZs0FMeTxGilX/jMGHGoMcWz
	 gkzUoTCo5b6buE/QIOBmUoopH6b93Q1qn5obfw6J3295dIP1QwrNpskIPleDVAedpL
	 cOUu+AAOb56fOQQNTn3aecOS2NRXatQalOnPW4ROiXcUUL1c2LQC/KdoxJjEj4qTjy
	 m7fHKbvoTCQbWLbbrlZgKWpWOzvjJk3KV5XKSENk+9E2b6V+mzy+ZegH1G8nrZXrr6
	 bLbkemVEyhBKQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 54CB1436ED
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 10:24:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a5w3E2Ri;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gkWNAql4;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D54CH71827825
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 10:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vpfrOlwX+rt5aQIp0R3Z3w5WqiMLj34FTuFoyTFwc3Q=; b=a5w3E2Ri+/ycXFuJ
	LlNzhTDxj05ZqCh5Wtl2RiAIjRgLBiaQtZWe0TUgBj8vAAYgIe23pt5IaHvGc+Jf
	GYx6YpAydd/y0xAGnVLmfG+6egukwxEGXNCa1pG3ebj1iXGTi/NYsHqZlfzVBuU2
	rXcVNKf1s4UFa08C+2paHHXt5UNB5trnyM8nE4d5nBBG16pHUuyBUUXbnlBYs4kY
	nlftALdifQ9h+ymqPYFfci+Phj/YallPxDdReqW3CeOqbPQjg/eM/7h9TmCCkTGX
	FuiLbx8IAb5/12HbWq5u9sLNkxa3hAB1odU/KpQHpcFnDZhvASPi/Ia4tLSouEMH
	Nz8itw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9wg014q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 10:24:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-824ae2cac9dso521083b3a.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 02:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770978254; x=1771583054; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpfrOlwX+rt5aQIp0R3Z3w5WqiMLj34FTuFoyTFwc3Q=;
        b=gkWNAql4kYlV/REMgON3GommtfBC+edWOXD061V+wtaRLyt2IC4XU9cfIohCFrvcfR
         eZ6i0479/zrjyeobsC3O/hqUmefon87Ncqm4r77/Gvp4/Bln8HfMpnN6do64QDGvTrb7
         YHknXIRXC9vwtqkp1vlY68E/J3avlkvWMybkc7XJXVmkM6iWl9Fpff5hEGsDedGjILEV
         1tW0q3JC71I9amcs5ZoNW9pW+W9CwDoA35VOZs8jlMg1gOVxlpyQbQquTegPzE01Rcmq
         Do2e04EoRhFiziQg3IPg+UVuUhFXUiv6sdyL44YJ9zvrEuRTRGFf6lWf29r/5HFxzVs9
         nDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770978254; x=1771583054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpfrOlwX+rt5aQIp0R3Z3w5WqiMLj34FTuFoyTFwc3Q=;
        b=r6ZuOorzHeUkt+0xPJT7GFnepaKecmuGkx1/Dx9zOau21RXY84RGnKmpe5PkbO4yZX
         cUwKCoPjgwrcSkmLN/Hi5ml0Z/FLORl+TGgY6lIGCKXq73qS69i+W+CgyOmf9mYQYsqZ
         MLRkt4xbod6CYb6XKhcRM/tPI3zLtxOU4h+3XTTNbGX+uTjkgQNCsN5N7/499rciYjYp
         xq2qCTwEJMvV/m4+JMBSbEte6xjwELEj+N0zIdHVWLJTZWWojJ1tTa2QzEGTdRl+rh3+
         h+9SD4GrnC/Fn+w6ynkqdG6n7huy1HEXRzPR+QmZ4STCYqzBi9L5iVre2TWim/P0mlGB
         MbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF5ujJ3xkZF1pwjcXuOF1dODbuIHNcxfm6H6wRyC4P6TT4Yeb24dV9IYkTY+wx422l3VGXa/Y=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyfXAmn622gYySk0QPJFseY0xtL191qdmAQPEUcCnmZyCU7inhM
	+c+x/ZKjKFuNODXljID15NjmK+H+uS6n0W8ZmSJtj6eOc5hpY+ZJvPlPUeqL23lIbFQ0UIvvHMZ
	y9CA0RePtOFxDvL4IBF2pTPcGszIky84pJPsjCFC0Hi8LJ8za9uwqUv+1ZnX/aDW/irK1MnoJ8u
	NlZVTkmN4=
X-Gm-Gg: AZuq6aJsgO73Rp7aBmv2CYWNZf8sHqCrqRL5q9hgMl7cJaq6wJ3lQ65WadPrO84V1cv
	v5X6WyHl/EFRH4Hj9NrP3uy/QEU5/JQaPaOdzBBfJcydTqTD9Wmw6BlheZUoj4zEHxpmtJwh/5I
	UHtSm3ziT+uT4wTCvczGqkwHwNkYN2wIFdMPfC5Kyb6StL7t+xVz/z34dkwflDhIaYQl4h/IWjx
	qOaeETznJa2dWJlg2Z+3SGlsLdtgR9dcLIWbZpJ7j5atwsVUCvR+JirD4OZZTl72Apz/VHo64iN
	YThvh1Wx+MknFYFo7ytga0v5ve6/pfGMMeqKgGSGdMBsArjqvlWsH43egUyLPD+QMrtHxLRAMVz
	wXkJlVn2UNN4jjg66mQmQk66w4//ezffzXF6aG/nRJQPzcdBoLplV
X-Received: by 2002:a05:6a00:6c8a:b0:820:2f9b:fe31 with SMTP id d2e1a72fcca58-824c94efd3emr1533269b3a.30.1770978254234;
        Fri, 13 Feb 2026 02:24:14 -0800 (PST)
X-Received: by 2002:a05:6a00:6c8a:b0:820:2f9b:fe31 with SMTP id d2e1a72fcca58-824c94efd3emr1533245b3a.30.1770978253742;
        Fri, 13 Feb 2026 02:24:13 -0800 (PST)
Received: from [10.218.44.178] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9510esm1911934b3a.45.2026.02.13.02.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 02:24:13 -0800 (PST)
Message-ID: <b7985f86-1df7-439c-8c54-abcf693180d0@oss.qualcomm.com>
Date: Fri, 13 Feb 2026 15:54:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for
 QTEE-enabled Qualcomm SoCs
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4MCBTYWx0ZWRfXyPgZUp3wrn6y
 0jpBdy6Gc4Kqgn68BoC+1W8T7NAk0QZ/USUFZe3fA+bMSli6OoLY8oi7nmK8GBrvKKq1s823ET5
 bU8mXo7Jy082bW9tR2Ju4i992S8jpaCxlGaISkPQP2tWutYpLOXwgEXM4IaYTYO7RJW+AnEripr
 VoSA1/tqzSkvV6m5d6Amw/d8cf3objeldiwJWfhHNpVYmcYrYPC74CpUnFWPx0fa3uTs3JxnOmD
 awiuu8Ujv8Xt/X+GVFtNhwFKOAI8Zi4Z47NkTL/SL+aPSz4OXkEMH0ccRGDrqkDbh2sbQFu/Uvi
 b+FmUWTsbpqW/TtCbCiXUaYvDd7g7f1nEwK16GDiVHb3rDX2vLGpL0GDO40qaEmDZV3hRMIKq25
 fwnDKEhxJfZtbUgQiQDxnFIbVTpBpxgKwZuIcBimYTfwc/swXt24C6LBRAut9V63L8f9/BwLoEL
 QygvQzz30CbPrDmumfw==
X-Proofpoint-ORIG-GUID: 2NABOt0ZQbjDcxFFJHNuGRHUB73fGdXV
X-Proofpoint-GUID: 2NABOt0ZQbjDcxFFJHNuGRHUB73fGdXV
X-Authority-Analysis: v=2.4 cv=bo5BxUai c=1 sm=1 tr=0 ts=698efbcf cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=aiZkS487NaXKbYTir80A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 54CB1436ED
X-Spamd-Bar: ----
Message-ID-Hash: ANDYRY7MESD43PMM47UF5GQBG6GURT4V
X-Message-ID-Hash: ANDYRY7MESD43PMM47UF5GQBG6GURT4V
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ANDYRY7MESD43PMM47UF5GQBG6GURT4V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>



On 1/14/2026 1:49 PM, Harshal Dev via OP-TEE wrote:
> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
> Trusted Execution Environment (QTEE) through the SMCInvoke interface,
> implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
> on ARM64 CPUs and exposes secure services to Linux running in the Normal
> World domain.
> 
> This change enables the QCOMTEE driver as a module to support
> communication with QTEE.
> 
> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and
> executing a Trusted Application via tests hosted at
> github.com/qualcomm/minkipc.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Tested on rb3gen2 device and able to see driver load successfully.

root@qcom-armv8a:~# lsmod | grep qcomtee
qcomtee                32768  0
root@qcom-armv8a:~# rmmod qcomtee
root@qcom-armv8a:~# insmod
/lib/modules/6.18.0-next-20251202-00002-ga8c3ce157925
-dirty/kernel/drivers/tee/qcomtee/qcomtee.ko
[  164.464598] qcomtee: QTEE version 5.2.0
root@qcom-armv8a:~# ls /dev/tee0
/dev/tee0
root@qcom-armv8a:~#

With that,
Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
-- 
Regards
Kuldeep

