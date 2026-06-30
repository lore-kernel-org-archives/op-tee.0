Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38301C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:42:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 78B0C44ECA
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782823360;
	bh=yXo31lS3cpuo1i5+M8ce0VVveEoe0x91tJ+wogkxxl8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Dblk7PsKQi9MRLq4wqHwUA7MaBvEa3ZDswQet8UJaB2nWDy4Ylk0sYzbQwcDdJ9x3
	 Oq4Zozt062mbfb0HKnAA64deL0pbEEiPQk2WzsxdxZHKgXSNOYGSLQkjQKTWq+Lg7P
	 jOO6HQ/Slu9HfWIXuV4nAXjrPmsTQgnKN4nIo/28DVRauZsaSn7LNTl93kw/rNdN92
	 JU7x7yFO4AczZEL8cfq5x8Lko5TiEyCvxCRynAvEJmiApWqUlRPqE/RyMAwrFwN6h6
	 BK+pU0T8c7DZq1WJf6QHSczZVNFPoAcqK1Qbprj9f6dnS5mnxg8VEVK/KDvKfYi7yi
	 f4+S732I4MCXw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E7C8844AFF
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:42:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FDALlAFD;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NUGMsoGr;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mk5P1602525
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vqgiAyPpNCB0A0IntH53l4iOkxkfpMU8dkDpi4Z9XyI=; b=FDALlAFDR7huBxwd
	WpIQ6SpAtlJNosB/BjBaKCGSCxBr9UYGDgxAea5BPhA/iJxfpFmvJ7NPOpawWx90
	pSel/yL0Hy9QAJ85bUk+hw0x7kvr04y2alpgbaiqNd3LoZygWGn3rcAfEMyWuuQS
	AaPFT6C5b+WfoAzB2ITk9au9cNNvVTfsSpFdP+zhh9thg3RcFEqDJlKYgwufpqxO
	+44/GUDjNzNBntgDtsGCCSZe53+bCRnzDu2qDe+sLpFixkaqrd1yKCNbNQyysm/V
	Rtn5XnXLAFjqIECmh2rqZt1brTWzVH5CiDI1CUZi9idMKEpcEz8dvnZfx8DK6af4
	7fbMVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avprxa5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:42:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c15c77619so1153461cf.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823353; x=1783428153; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqgiAyPpNCB0A0IntH53l4iOkxkfpMU8dkDpi4Z9XyI=;
        b=NUGMsoGrRxxRMP1YcW2uvPmzvG6SpKDsygZT7vnceJJeP6sEHkjmzhRx3sj7kV3zVf
         4wDQTZa6PzSJLQSF2la+9gq9hpyFelyJl/63ZnUigozL9YJCAQN6QR3aIEvvRlV+dXu2
         6J9xU065aRNzW3ZSJvwVltnPDlzjI1ErH++MRvlWXKAtw9nkVh7EGierz5lJyJe5CTD/
         FBotaZ3UfQe0y7ZZ6ic1xB6OoUNFNZHqR6QLylyXVnUdGsKIcYH64lVcSVS0oPtozMJ1
         FIHbs0dYR4etyWtxx0TdFUIbNsXQmu7Zgl8XOc1ZQ66vC5s/+1/RJ2fEhTNMaQ8M9I2H
         l/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823353; x=1783428153;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vqgiAyPpNCB0A0IntH53l4iOkxkfpMU8dkDpi4Z9XyI=;
        b=IqS6yXLagAtGlyDWFuz7SGCmx5gxsta2h4s3nlkas5sLQW2rQVAuInDbjCeVO/zkqd
         SF7Bi6mz7MlsrhX6JgOF2hVx/F9nEFBKObUDDpIoJnIdHxuf853WF2G79ymvd+NaIh7r
         oV890S9Eyfu8miZjqs8wTFIRQ9kqPEGMmiREAoReYj72/xYhQmnbeUurM47XnrIfFjEZ
         wUaL0p1qeZ196+XnDGDGYsiY/gPS5GjfP9fKqb5pGvI2vbg6Oz14yzkhASl9LFhowKYw
         UZTpZTVl7UB8uCuSmwcMSqKq65qEQDrO+vF4c0SzlKMpbewiKDdj9+TE/We8t/j55T7p
         xdkw==
X-Forwarded-Encrypted: i=1; AFNElJ85iVKape5xLMkCprw2wPQm0TuAp5E9KUDLK3SjCdB9+GuQ58b/LdKbDHjdkLFt82JS0vg3XTc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz8hPVDOdOl7iKD9YFhVpg07P7Twb7XcuqAjnWcfHjjOpANK2le
	PFVwAlwGjlq2IPdNejyidExnht77scR0ivwMe3IKbBZDGNKjO7pNjGYgISqlfL7kBicWbpYYmM5
	5mPBC6XQ0WO267yrccClK4olwp/TSV9FopCsnz7AyN6g81fI5cDnD3GZTyqB44+L5hBcIsTTM
X-Gm-Gg: AfdE7cmcUXLwcYRUsGYnbg9If2Ay4PC1/S1crOtP7prxfYtkr3KVYYwJdoge5pGKHOP
	RVmrInTzVyWZ8+VIKQ+JpfFRMvEs3U6vZ5AT6tJ1BBPUDgnkkTRpvlgDKEbO8U+3e1KHedi1IkC
	BC+DXjlbvN28WSdAtQI6rWKFONpEuoSVQ6xCestTzcoorpjc1XjcCPeiV8kD6H8Dfu0eKtstDcF
	Owcq9w4TRmuwU1yUlOrGehSgMGbZcfbJIgBlDbAx50s0MHXvKOhmuQOf55/WILq/0NBlTmNatqB
	CzpTaFCM5CVUNYyjHFlbNRzPN14QoqzfzHbQTWC+QAg38Ws3HYhNgmHAVK9HXviTiHEG83PQenB
	EuBX5BG66axvG2vxNDcA7OD0HxN5WmlJ1J/Q=
X-Received: by 2002:ac8:7fc9:0:b0:51c:215:3e81 with SMTP id d75a77b69052e-51c10754ef1mr27550291cf.4.1782823352485;
        Tue, 30 Jun 2026 05:42:32 -0700 (PDT)
X-Received: by 2002:ac8:7fc9:0:b0:51c:215:3e81 with SMTP id d75a77b69052e-51c10754ef1mr27549891cf.4.1782823351774;
        Tue, 30 Jun 2026 05:42:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4c19esm118502566b.51.2026.06.30.05.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:42:30 -0700 (PDT)
Message-ID: <c251430d-2184-4ecc-8d05-9cb47533e5ec@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/14] media: qcom: Pass proper PAS ID to
 set_remote_state API
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-11-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-11-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0nDDLLeAMAnQHnHcoj6E_GkZpRf6RB9o
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a43b9b9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XI7qjyBPQyksM17I1wMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX0wYkLOsnh4He
 Rr4Q+BRpr6iy+5rqo6rikcwzsb/7O0Qk3rmYogHZMoS0u9j2VGVbFc46aPTdMTPA4XF4BF+qO92
 HLreB/15ECDAoYH/BvLKuibEgE9jZMg8fpGnENwuvDQOwrLeDY0xq3iQ9tz+BNTfXCF2e5HgZIr
 qbqh7KW9zESOoIp1HHx0P6WV5FMAGaWCZCPvZCCwIb4uazyVqpuCWKwZxqHAJyRjt7sJDprQNOY
 Pfml1aUFaGxBC2BsJCyB2SCnfizf1q/aMWdYSiGaN7fesiuGSwyJ3JMOVEli9pIPNLVduAu/8do
 zuR3LbQDU+jgo3J9ep9kerkvD2YgeVssEusfuT3lwkCfiHiNfXn+f1OvvkvJSRmPTTBQicEkKJb
 HtWveiTph6Jc9JTN6l4Ykq8TD6v/X4nGr6aFeHFRkYDzI3oNns5L44YhxVtL3x+Umo+dMUphvp7
 oAPLIHaKNJ2JEfVoMmg==
X-Proofpoint-ORIG-GUID: 0nDDLLeAMAnQHnHcoj6E_GkZpRf6RB9o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX6zJiTOs/bTPW
 NdJ4B9IQQ+VYsdGmtDwLbx6n0/6L8frMFeYks6iP/NIDmu8UJSGl7ySHobfvqjzBPHKW83YOKUA
 jvYBzPVEY6rMgJjWOEvxRhhCAvMSDmU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[48];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E7C8844AFF
X-Spamd-Bar: --
Message-ID-Hash: N7GK37ICB35F3H46KKQRK7HZYM3LIHGE
X-Message-ID-Hash: N7GK37ICB35F3H46KKQRK7HZYM3LIHGE
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/N7GK37ICB35F3H46KKQRK7HZYM3LIHGE/>
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
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
>  drivers/media/platform/qcom/venus/firmware.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index ea9654dd679e..d2e7ba4f37e3 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -110,5 +110,5 @@ int iris_fw_unload(struct iris_core *core)
>  
>  int iris_set_hw_state(struct iris_core *core, bool resume)
>  {
> -	return qcom_pas_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, IRIS_PAS_ID);
>  }
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 3a38ff985822..3c0727ea137d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -59,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	int ret;
>  
>  	if (core->use_tz) {
> -		ret = qcom_pas_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);

This should not be in the middle of a mildly related series..
The PAS IDs should be centralized into a single header. And the
name of the driver shouldn't be part of the define. I would guesstimate
that on the secure side it's probably called VPU or VIDEO

Konrad
