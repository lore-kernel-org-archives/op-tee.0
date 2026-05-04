Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EC3FF885A
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 10:03:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2AD1844AE1
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777889009;
	bh=27a4ZBAh2T3+ZHmlpGLT6Yc8QyhrRE74iT7Nbf3wzro=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=M5spUoYaliCHTILtFMLJuTzmCRLjwZYvd86hjhgYJ70L4SDKZrKddJp8LZpbUu8kk
	 z+ICYmuWBszF2R7sIyeP0c2DcJt4fm5oBGzNOial2y6b0Z9ByjWiSDiLhPX7/2BgqX
	 rIJhHI21aT5H+GQzQx+oc9i5ZcsBbe15B4GWuyVcLHvtOzpaCl8aZ/wIQ06H6Ls1zT
	 xbTpAR5sj6S9/M5FK1jcaFsT3ZXuk2nmNFcJgPJ3Qtru2WFdjhWK+ESS5yD1hNpL5L
	 Tkf3CX9pW001rMdbobv5KmpqnxKob6cHDMa9U43MytSeaDj3RW4bSHRNR+NNP65Tv7
	 cEnVoPC4TQJ/Q==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EFF354437F
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 May 2026 10:03:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=blFGahv9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WbcsIevK;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448fQAK459403
	for <op-tee@lists.trustedfirmware.org>; Mon, 4 May 2026 10:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dIOaP3I+69NIYahYhn7ZP8dTcKbC+Rx4d1eqqv57oN4=; b=blFGahv92s0HUYjT
	Ihj7OOX/CnOH7LuU5MlrBldveiHSlAs8JLotz5yKAVYzJHzUZNj7s+B7yxCABZQr
	MIeuOap/tRS5v53jzGhONjBC3KV+HTbV+7D6vRW/eLiAunSL1Um+B/R9wppgekbr
	MEUqeXNAyibnAYw91s8LSCwst+PaDxQLLi/30M6EKIHKDEoyTMDNR1eh+c3v0CxB
	wFIh6v4C/U9MaZmtQffoPeagpZF0l4N3OH3roV/REe8FlXEloX5t8SMrJggV/FkQ
	3AgBiYK4NzS36r3ZDhDDQ7ItYyL7R5m9fW/5iHrSm0iYokJjo0HQnTlVPGvxZXrJ
	gYLCuw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaejn5ek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 04 May 2026 10:03:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3651991d0bcso3006912a91.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 04 May 2026 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777889001; x=1778493801; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dIOaP3I+69NIYahYhn7ZP8dTcKbC+Rx4d1eqqv57oN4=;
        b=WbcsIevKix5EVbVe8xcH2yCRZ7ybXAWXe5aInpL5DgWd3iRZMOLuk3Q5tPMD1R0+Uh
         LzUtWF8r8Qzqg+UK1ylHGw+Fr4zsNk/EjCXm0SsVTy9lUEQeFlxj2UPLsp45M8+2zPoT
         qP605qxkvzxvLSz/aK12kLwJtL1Bx4/qBKxx2RYjWyImeD0u5uDB2oElerhoruR2POv2
         bFXQiYkx0SoyQWoCfoCYrs9eqmGGQUuEJrP6IAOoEsofiQ3J2jEx0XHf4Fgi0ctylG6G
         8/l6tWzE+gytEGtTkFcfvfz2xXrl0LMk9XvKPpQNIZQYO7dhEmMizBkbFyb0ZpjWjllJ
         iJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889001; x=1778493801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIOaP3I+69NIYahYhn7ZP8dTcKbC+Rx4d1eqqv57oN4=;
        b=FqJAw5MVn3hWMR/wqRTXppeDhmiaJEBh4FSUjnmPYF4P+qK6z0ywozxrZdt1i6YQ1m
         X0yF+xlLtYBCxpxlNXhM3uCeV3vAtsjsRADqJr+KtFlUIy7argrMtmMWxasOsm0vWDaz
         JCxhuP7pgI7NFmPLZsFT7WUGY/dUBmnbMqWvEGTxN3tkZFZqMP/TN3btHvKroN7ojdjg
         qe6fW6zg8j0WCvXE3GpHYerINRdtDtdjd5g8mp41WBssOCEDC1Z4AhRuj0+f8gekdRvE
         jZPJA1/c6o32REZoHIPRePXKTpuud/BfuHwLoe6pMAmDKhkUoelCYb42S4CHd4GaRjZK
         9qsg==
X-Forwarded-Encrypted: i=1; AFNElJ8dgYEnZudjRGa7AxslfF3tHOf1OudwKOMf4CZk4RmU1vZJlUyR/N2a6ynMKtImYIaA/uNtBas=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzHseOm3f/sNUSP1UsF15KapqPjipLLuxZdK1D0ndtLhAO+jj4G
	4phnSKVZh3pWzj9uVwMjazN+/kyxsDyMvKsdQEWfTjuBzfL0orhNRJu07lXZfBA08ZUGJ8GkXUc
	5+MW/GNr9CSdPyua4GJ7GL0/3aFUnYaDKZXtgu6jTycWOBLuPSyKmIhCjvHRgViH6RpDMV/ma
X-Gm-Gg: AeBDiesxj8p4AWuMmz/9jI9o+qKRSxKpE84mbA6E2kW9MySYiAM9OTpfww6tUmytWaZ
	3LpaVD7ZdPRqXojwsi9LeyqeYBlP0UsmMgOiTJSGt8YiEs1X84kiYiAcM9o+15ZV6u/PCqp8pyk
	U0OvhoOy2BGrzofuBdot34rsHGcMRf9iCOuCfB+5V4uhq9mpBO3iIv8AEbGlctQT70b2X0T1W+W
	/dYmgRk4dCxZgod6OIKPYgwIXT2+HKinYyHaYjLC0ymSJ4KFSinAKq1te1+hwVhqfzP5aCQu4Ig
	GxI13Q1Htcsg8thEhzjKUOYpVzYlpI5h1eugpu+Xfr7uwQJ3IqI18ETKGUoyOhtV4PBJ6xY+33q
	f0y5ts+JLWPoAKDsLfnbYR5KjF2N8zghuP2W24XNEVewX9fJW2wy8TM2Yp4vhNQ==
X-Received: by 2002:a05:6a20:3d11:b0:3a1:76d3:c1b0 with SMTP id adf61e73a8af0-3a7f1cb3fc7mr9309002637.22.1777889000760;
        Mon, 04 May 2026 03:03:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d11:b0:3a1:76d3:c1b0 with SMTP id adf61e73a8af0-3a7f1cb3fc7mr9308931637.22.1777889000200;
        Mon, 04 May 2026 03:03:20 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbba8fefsm8933909a12.7.2026.05.04.03.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 03:03:19 -0700 (PDT)
Message-ID: <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
Date: Mon, 4 May 2026 15:33:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
To: Sumit Garg <sumit.garg@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260427095603.1157963-5-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwNSBTYWx0ZWRfX/cst5TyIKeuw
 Lc2BI1/+jVhvICFlLmPYOEYLP/RYB7zc7mG1CkXkPs64G1Qa+N/5a3pQ4wkK+ojzxk4bnttYR6C
 JWerlysVk1WsWA4aMDwbDO1psOvfDuWxRuNgeq8CAurKYNKdm747eT1fbgpm4yDwwIu0wDuWc+h
 kpqlOoZyXo9Ui7rCPdWpT4twmELncVf5dwS4dCCh8Y5WBHLnKmyuwXL4iq2eYXRv19q8LzEnpoX
 YajjSqzJEwAV9TcVz7cuXFobpzDHSzXpu2E4n8l1ARM3ApYz1k5p0rK/8d3ZMmQVCKYIfNbXDHf
 53+jj4QtPMz8bbVjHHf/sFDq3BcfLios6YMoGGFExki39l/u2nsVOROGgDZr0N5eFmNJh+njGit
 7WX1SkSyxMxxq/gfMq8ypIECntBDtgOlWwMsgdYn4ftfsLVVp+7qNMLA2xtNrpGSAikLKuEG77n
 Kgu8UM3GJYWwOSCpO/A==
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f86ee9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=6olnGIjaqZ5DSDVW89IA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: OnDVlPs3JAuhVx2Quq6FQA4TKqnEgtKD
X-Proofpoint-GUID: OnDVlPs3JAuhVx2Quq6FQA4TKqnEgtKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040105
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EFF354437F
X-Spamd-Bar: ----
Message-ID-Hash: ZQPUR4FRAVQANSTUFHRBMNLIZ5MUSEIH
X-Message-ID-Hash: ZQPUR4FRAVQANSTUFHRBMNLIZ5MUSEIH
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZQPUR4FRAVQANSTUFHRBMNLIZ5MUSEIH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Sumit,

On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for Peripheral Authentication Service (PAS) driver based
> on TEE bus with OP-TEE providing the backend PAS service implementation.
> 
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig        |  10 +
>  drivers/firmware/qcom/Makefile       |   1 +
>  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
>  3 files changed, 490 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c

[...]

> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c

> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> +				  phys_addr_t addr, phys_addr_t size)
> +{

[...]

> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return ret ?: -EINVAL;

Following the example from qcom_scm_pas_mem_setup() here:
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/firmware/qcom/qcom_scm.c#L778

I think it should be:
return ret ?: inv_arg.ret;

This way the client (say mdt_loader) knows what error OPTEE PAS service returned.
I can see that is tries to print this error:
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/soc/qcom/mdt_loader.c#L286

With that,
Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Regards,
Harshal
