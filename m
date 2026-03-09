Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E87EA854B
	for <op-tee@archiver.kernel.org>; Mon,  9 Mar 2026 09:12:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 68B97438AA
	for <op-tee@archiver.kernel.org>; Mon,  9 Mar 2026 09:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773047552;
	bh=Q2J+r2dSfTS2w9RcAxTqCjJw6if9TEPXLD0Hi1LfNcA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yS0zud9yp6SyjmZc4rLxWX9kiXeZ3dXLCXulmU1wbbkLKht7jDxM7l//zr42jlAn9
	 4KvhHYfgqviSxviU11DnW87W3m2/UR/LN1hOaQ/vdGpF6Vae5pZBRa9/4t5GQHdwQ5
	 qsO04rTzWllHEMQy1yIrEZYnxk313wdm0GnefQl/kAhqip+em68fJ27KZXzsEkYpbL
	 A9fTprnqzYAGtGo8zICMAVcQydJTfiA6athFvNG0qgmex4IplTHnqQKoCzX75oxTmV
	 MdkRk74zGi+/lrkvKoSUC/WM7t7q2Sibvom2bzQdtU3DAh27lxy4fx2/uk8DnDmcRI
	 rUJ3MxS91pimA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 32EF8431B3
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Mar 2026 09:12:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHru3esd;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dRx2Yfs4;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298WGsg3773410
	for <op-tee@lists.trustedfirmware.org>; Mon, 9 Mar 2026 09:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xbMtvtdOfLDdatvp+5lzCch6
	oMIueR07h2NcUioWpFw=; b=jHru3esdNzuncTNwyW211a+aJdCkYiYxILsoZN+3
	1GwgTcHiMn/ymHOV08WINAfoWlfYw32mmtmF+Seo9nDBKL/8faTBqtOibVjY8T1b
	dgaY0uA7GYpKzy2BlixGrj6mN62goEwdjRuKoxo3BmtDppXIOIRCT3W6eZFhNujG
	NUVHihFT8lC0N4D4b9D4sUu9vqiYV7661k24lzZtWboU4mtxwP07+llelKSKDhOL
	XCCcln8fcMYU0Dbq9i5aXPPkIr1kAbbwT4ojrN+2XxrTTpUirMmL8EjgT/DODPGl
	DyxQTsHS6r2QOpA4ooTD4DOGq2QorD2Gt3YNLkNIxsnfsg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa8583-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 09 Mar 2026 09:12:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd80bea54dso715452985a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 09 Mar 2026 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773047531; x=1773652331; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbMtvtdOfLDdatvp+5lzCch6oMIueR07h2NcUioWpFw=;
        b=dRx2Yfs4rfHZ59K2/MiyCHGm2Jok6MpTTW0JHZa75AObV/krnRUw4ixW1F9ai4FfA5
         jCJfhfBC6FI49FhqgEFQoi9H+WEP2QQdST75h4o4JxsSNi8UsCWzpyk9itvmSU/UZIOg
         8LJfKd9U3oxJPleV3ZQbsNFCvuQJE3AWMZDf39SWMVJaYN3j5oEQ1MCm17TxnNAy80CE
         xzVnY5fBNxWY3xE6IxM3Af4FcQ8YpERPGThZAbXfykMicuxBP1X67C+cxjcRiwTm+61Z
         QwrbYqGflvkckNWLZUKb52DWWya4PX5cTWvpXrwLAi3hoDfZ1KDJsW7/C7+4iIG833R6
         W/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773047531; x=1773652331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbMtvtdOfLDdatvp+5lzCch6oMIueR07h2NcUioWpFw=;
        b=PNl7LUO7MZmTuCo6RdI17zqDULkhHTf98lTnsIK153S6tYYj6tbdxyRNVpFXHtudLO
         WrmIppSULjwRRZla/+ed/HEOV40Q0dPwv6ZuTUf8LR+3FOMg5Co3VzTEktXOixwDQKqL
         5p39GnSrEZ+cIx2tTtZYChmNEte3EjEdHlBdp86OCglPjT5lFcZd40ofq4mAi+MxvnXB
         gSd9YpTC2lOSbB2zyYGzZ0vK0nYe9wem1/wX92OtiAwpyqIN7o77VckHXi+xOegXO3R4
         7q3w42Z+8+Qm/C7yHgCf1RO5kiJRNwyyVoPrhF9s8NoVuTHd6nqZUiwgbNBvJDRJqDCc
         C9LA==
X-Forwarded-Encrypted: i=1; AJvYcCWNgrOA/lPYnO3CtM0D6nDVrbvQ8vHguZS0w97Dt3uYtG4wz0XpfKycc+fb4qvPYiJhoERFd6s=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwUWvMSKOlyvNcnAeGiIKt7tf2NL1bS7DZRW4QVwnIlZZ3H02Vd
	TzuDkI55Q8cEuTsCbc7QauGGRKgDJp5fBoNogksjAWycOyFmwS58Ol8uKZBfH1VSqX84Iowd5h+
	roP/GJxriExGLXyFwyaGmS23YEuMk3NX/yTHKR/trqEX7amH3jd8pHnSVbv4Aa1Cw2ropfAGe
X-Gm-Gg: ATEYQzyZ0ilMVtJCw++yGOXATWrsBvTunGJ6D9zc62Ya51BAU+kYptHnXQqvQoBLYN4
	8hmzr3x3P9fEZccUmGgCPOsun5MPFBoxPX6uGaC7Q43ch6ei0ThGAlss/Krs5WYq+yYeQnCm3hI
	OyLujFA2VHhfNemH3X5KLynSPXin+gkRMPcwOugfi8GaKdTnzV/dG/OhUKCX/He1J9VYzwte9sw
	7IXS1i246iMPVGjTzz1x9g8xEfmewiWHrAPf27lZb5EtY54uqZDh8ayQvZ8jeHKOzc7v8Uegjl0
	/5s8PW5GHI8D2TZlvRzCTU+FZfGLLc2KVqc58lZjJBhRaHmn56ODotMq5TNz3TPF4fwwx65GRXq
	1YI3+npc5I3VAYLe91Gk7K8w9ffyBBRJ5+G/ZY1HGDkB1vSd+ADwOaA==
X-Received: by 2002:a05:620a:700a:b0:8c9:f9c1:5ed with SMTP id af79cd13be357-8cd6d4d541dmr1304571785a.63.1773047530923;
        Mon, 09 Mar 2026 02:12:10 -0700 (PDT)
X-Received: by 2002:a05:620a:700a:b0:8c9:f9c1:5ed with SMTP id af79cd13be357-8cd6d4d541dmr1304566385a.63.1773047530429;
        Mon, 09 Mar 2026 02:12:10 -0700 (PDT)
Received: from trex (110.red-81-38-138.dynamicip.rima-tde.net. [81.38.138.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae483desm23179497f8f.34.2026.03.09.02.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 02:12:09 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 9 Mar 2026 10:12:06 +0100
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH 11/14] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <aa6O5tir4kVIe0eZ@trex>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-12-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306105027.290375-12-sumit.garg@kernel.org>
X-Proofpoint-GUID: sHnfNTnGoa8VyumYyY7dftZK8MpI_hzQ
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69ae8eeb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=P2IcWdTxk7sEx2G8DnB30w==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zah51VvIpe4vvf6E17kA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA4NCBTYWx0ZWRfX67JhmKNxsoPA
 KmfjUwLfiN91AKhgQ6YRq0PzQ+2M2Ndj+s4qV7rHZb8VGYez8RJKhZ4jHzuPorXjOQPOtvdQoZk
 Hxfd0zLfAvzc+n29Uvf7SWgxn67vwfvGcY+BUuyNt/SZC8tasV/BK7Mk+M2wsQRKHBjyLJolD34
 m+++Q5MIUOJxqn1bd9z179SR8+B55TJqOVtNef0QtHJMrwB6IiiSOTOCA/qp8elk9HjkIAa3Kk+
 bo3m/S7LQQGS6rumCv7dHjAfNvJZSAWLL9EzCCn+VpMFsf1LlyF2z0mgO0heTPaQnXD8LP9heu5
 6klxuS8ZZ0PtBDO6bCNiHduMH9PbPsOU3ScCqmzRF7moMh6RbML1vlqX88WUBADMvYKTF+/okeh
 qKslnKha+lbRbC8VLcPEbT2mP4AbpkyJnyFR4F2+fiqgwL6EhOZCb0mEh20OrzZhxlstp6Gl4Z2
 ZNAdhovvnM+4RZ21CxA==
X-Proofpoint-ORIG-GUID: sHnfNTnGoa8VyumYyY7dftZK8MpI_hzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090084
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 32EF8431B3
X-Spamd-Bar: ----
Message-ID-Hash: M7VQHMZ6PYM7XDSZHWB5GQW2W6X6GVOG
X-Message-ID-Hash: M7VQHMZ6PYM7XDSZHWB5GQW2W6X6GVOG
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.
 qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/M7VQHMZ6PYM7XDSZHWB5GQW2W6X6GVOG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>

On 06/03/26 16:20:24, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_firmware.c |  9 +++++----
>  drivers/media/platform/qcom/venus/firmware.c     | 11 ++++++-----
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 5f408024e967..b3c5281aea91 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/of_address.h>
>  #include <linux/of_reserved_mem.h>
> @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
>  		return -ENOMEM;
>  	}
>  
> -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
>  	if (ret)  {
>  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>  		return ret;
> @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
>  						     cp_config->cp_nonpixel_size);
>  		if (ret) {
>  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
>  			return ret;
>  		}
>  	}
> @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
>  
>  int iris_fw_unload(struct iris_core *core)
>  {
> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
>  }
>

are the calls to set_remote_state required?
0 is not the IRIS/VENUS remote processor.

If it is legacy, maybe they can be phased out?


>  int iris_set_hw_state(struct iris_core *core, bool resume)
>  {
> -	return qcom_scm_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, 0);
>  }
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 1de7436713ed..3a38ff985822 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	int ret;
>  
>  	if (core->use_tz) {
> -		ret = qcom_scm_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, 0);
>  		if (resume && ret == -EINVAL)
>  			ret = 0;
>  		return ret;
