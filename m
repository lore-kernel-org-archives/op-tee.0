Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2B4C43602
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:44:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AB8E244E68
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782823469;
	bh=5NyZE/pdk1UUcfMYTWurDSt/bJg+fnkkgCBYJNkdRJ0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=iqwZTVnS/rNmKYvWNcuYRov8VjbxTTlTIZvnxH13ILyNyG+r6SRFG1YCnav2/Fifo
	 zY7KZbPx4M3ZrfUa4B1qUVzU/xHoghU6aLD6SMbypBtZlBzghau3quytzWOdySwHfX
	 84GwriBKrpWfUj/ZFEAfLh8rQwZoPacb4JjRgRoxox1x7Cpk30eW4ZZqbsv7WIpdQu
	 +4utRooXuU0icahQKOLAPT6mABFWnKwYukGcT99nX5CkvGEKxDGkAEZBjrWbyK/KPz
	 6VfNz3eyYlZAZ4hNIR06wWk2PddFL39rDJR/VpN3sp+5FnpMLr+sG7QDlG1iI/UPjh
	 PgAPR1xevkhkA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8E5EE44DD0
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:44:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b6o5P/f4;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bW6LrE4i;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n6dP1508827
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gD9g9o3wLVxWkvqZBA0nQ7MO4qU/Lgf8nSjItSG4AmU=; b=b6o5P/f4dub0N+sh
	VloUIC5/nznDnJpdi25/JuyuvwG2UEzSJKKvywHK0tZrtZT9KUZ/5rxDpzkAbK35
	dsnM/t9aZuxSxU2dRGIZe6jSc+AjUnNQpE9yweYJ2AHh3rx+0/GCQrqKHV9iLFJd
	l0GX/TT5eBf9LEmr4iI2JoKQon7GYA3eQBuKb73gMscfC3mX6KuyV7kA0Qrm0VgR
	Sx/9IGVhVELkU+ss5iFzAVhFhfcrFPin/yM2k3woV5wD5lCojLKYMgWCTLttw8p6
	JC+Z5uAr7lpj3dOpru9IIxbKchWQWwxRHb/JJjqzOKMn80zS9LHcEIdrMlIPnKRX
	7BmsvQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9j3jd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:44:19 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-738a934c5daso68191137.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823458; x=1783428258; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gD9g9o3wLVxWkvqZBA0nQ7MO4qU/Lgf8nSjItSG4AmU=;
        b=bW6LrE4iLBRvlWisEm6n0WuM819K3w7xe6vi4Bj6Ksq9lGGZPbd4ciqaiwyAPf9uWf
         HhMxoYB6SDax51TzWUXB8lV6cgQQD01yQWkcB9Jnzm8L4TVNiL13XWKHeUqBJzdlmV0B
         DdrQ9Au/zjMYVCq5K27Kow6B6EXaWgIAAOzQvCrYrbtw/VwDsPHbobIa5efx/PwE1SLc
         1LNjXVm6chKMHZQv96qsZKw5PlPG94QY2Pr9kCVLIMYeohxO5zhTslsjc/5Kalrd5plO
         Po3b59SdwgVrhdBTv5XWOggUmPSzeWYRtb4cEEyjIl5cejd7WyzIi7wXrJcyRgQCK+J/
         NZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823458; x=1783428258;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gD9g9o3wLVxWkvqZBA0nQ7MO4qU/Lgf8nSjItSG4AmU=;
        b=QwV8+BPYXFaR3VJF80gGM8RQWW1WAfrnczVWJfohPCUGwDz5crqIfq2SWH+w6WRFn/
         0QVILwBCoPA/aAcGDmyaOTpmuLZqtS10q+bXsitptPhIK5bqJ9QadFuXFGabouQB4BLn
         z7YCWUWhrFVVj7iZ+oZymcidQJCRIdaky3hpkAV9PHDhXcEM5i8xctYdUXAwApiVBxfK
         9pVrlaCBsiJnzpzw89wlIsnAJB/o65sx3GkEibWE42FS+YKqJrSsKe3k9n5yXIab8V6N
         4H2/Vb4liSZqbJg6LkE1JPKL9zAoFZD3iLwIpXUx6lZnh75SLeWB0g0FsJFnG4x/VBLs
         HS7A==
X-Forwarded-Encrypted: i=1; AHgh+RpQa37aErwSn9WX6Yf4huqQGhXzaCU7uBPDu+lUDlOxKnRYnhGmaqQI2SQ3+kszIsZPBQgTuoQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwmVQEe+HQ6wGxEw0fcBpCu0KtbpwScVF268P7TXBfhuj3hpwaG
	z8hA5kTDQPOHZph9n4+UzmMgDHgcBY5D32vPqcW2UwzvzR09jkHTyfclYAjLw5UrQ4drP7MZxrA
	XBfebr0/O0G3802/6qOBpx6rMcIXY4ObC8fqMW2PglopAsR09VCcNVe3i1OAkyHk4rlkNdD0g
X-Gm-Gg: AfdE7cmvgNGUA77huoPlSltnoha4VFSPP3sdRHgPrs5a4NrSvu8CtpN8AIG3MvAC0XK
	ufO7nqcZ7o7uSD60NaKdT8iwg8nbXhXdZLlaQZV9eg5pEX63LstKIXUx1gUDHncZrSm0SUlSKu9
	W/vvQ8z5b//6J8URQ6+ufNhA0hnCyG/SGTLSuajmF3L4LtLDl1zoeobznKqp5U/cyO4GmrBsJbd
	eueikAuA9Cs87zRIhgXrZGXScgB3/hvIAm97d5V0ATme2OYzYOF9/10F/r/r1kBITJGhYAXXvbj
	2BqOrYDU5g3fmsjwbbbduWssVtDE4cMvUcGe4fj2wWo7Ez9389jEcchmBIatqaAriCiMb7762M2
	6OX9bi70f69szoYcJQVKEdyF8EBZ3TXwdaPo=
X-Received: by 2002:a05:6102:8082:b0:631:25ab:8bbe with SMTP id ada2fe7eead31-73a38a37b21mr524355137.5.1782823458306;
        Tue, 30 Jun 2026 05:44:18 -0700 (PDT)
X-Received: by 2002:a05:6102:8082:b0:631:25ab:8bbe with SMTP id ada2fe7eead31-73a38a37b21mr524326137.5.1782823457846;
        Tue, 30 Jun 2026 05:44:17 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c950732sm1117239a12.22.2026.06.30.05.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:44:17 -0700 (PDT)
Message-ID: <ae6518f8-bba9-41fe-a97f-de6001319c0d@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/14] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-13-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iISGvIQVfFRb7XTaQgdwjyVYIlc33iXJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX6izKepEFx8eB
 qUh5hAKqTKSrGsVkMJwJyoqcGx6XrsMohD3vqQVsfgWGpIk5oh+K2IUNfVp+pm88JB43yH9Abh5
 3GxUpiY0Hnw4j022HquNTr7AwLpJC+ha0suJqlaU0NYLnURsDubojlhxo65qQzwoLvpkxDTCC+A
 V5URniG7nl0HZlzdsH11ZBH7gJBX0erpnKnsKYXNzRRduRKI3ERRb02Atnu3WXBlNLv2H1i78T+
 cLuxgxPOyIQdYuj7qAClX+HSAFn4mbgQ0HMmwlRbaoRbKBdID6GFk4UNK+T+sjOKYGcbEO1pifR
 k3c4zugaar3OLk4sBvvDNHVJf23m92ifAmTD5bbpfZyhK3qGXfjrVz9uOQwVxbcsIlv8RKbys6s
 PXqUHibkXSoapCY6DL8O6uY/P4SM0Gq3HhErxRjH7yO57IYXqzvX+XArpv5YPH5OJ1DdaMe9okQ
 OnPLPB41GJomY5Z6m8A==
X-Proofpoint-GUID: iISGvIQVfFRb7XTaQgdwjyVYIlc33iXJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX8Qhqr8UkrcC2
 TD11WI6tsrqzRvHqNX0o3VBNUFU2EthYgwFDGF2VzUcOontAd2pUA/4DvQ0ORCDgqc1z4FdjLVb
 eRJq+rXmcxNA9wo6mD56ZtylmJ9Xxro=
X-Authority-Analysis: v=2.4 cv=SINykuvH c=1 sm=1 tr=0 ts=6a43ba23 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=AoAzlOJtnLSqI_VYGEMA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300118
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[178.235.128.140:received,209.85.217.69:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8E5EE44DD0
X-Spamd-Bar: --
Message-ID-Hash: 37C2CMTY2RTGHXD6S26Q4DXKI6DXNK3H
X-Message-ID-Hash: 37C2CMTY2RTGHXD6S26Q4DXKI6DXNK3H
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/37C2CMTY2RTGHXD6S26Q4DXKI6DXNK3H/>
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
> Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Jeff Johnson <jjohnson@kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
>  drivers/net/wireless/ath/ath12k/ahb.c   | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
> index 4a2b240f967a..0d5d1c55bfc1 100644
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -18,7 +18,7 @@ config ATH12K_AHB
>  	bool "Qualcomm ath12k AHB support"
>  	depends on ATH12K && REMOTEPROC
>  	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS

"eeh"

[...]

> -		ret = qcom_scm_pas_shutdown(pasid);
> +		ret = qcom_pas_shutdown(pasid);
>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> -				   ab_ahb->userpd_id);
> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",

"PAS" - it's an acronym

Konrad
