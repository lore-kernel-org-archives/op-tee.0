Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7C1C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:43:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7A2BA44AFF
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782823428;
	bh=BgY00mBvxWkHejgPkucyLWTBpsCWCY5fK1NqMPCqd+M=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=njDW56zgVyD6IDZW+aQpBQ9Cmq28QnphQJISnKhCaDx83BnG1oZvDa77H5y7YCpMk
	 0sU9/cnDw/QunkFB4fSHoWlJl8T0uO3gr+LFTzl+IpcJqc8gQLdgLv8vBpW4kSRr1F
	 A6eKOw1JW8ECSbSa9MmaVonKaOss8uq02mUAUUCnsdOJTynHGIQ8s7gG12tCeVClmb
	 jV5YboyQtGfusPwgEH0ueRuaXHYs/QITlzHptIYNa+xCZYR2BSg1UitA4pxxRJTHyT
	 nSRfHr5gShdhHyEcWOYrsBE67od2UG/Zb+Uvxqc6XRGXOgM1pwm+so+GptEodThrbh
	 ifsxAukVLMlxA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4E86544AFF
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:43:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F3n0sFhN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c4Y7UwEf;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n2fG1573524
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=; b=F3n0sFhNv4vOtoPY
	BXpZieU5OTwgT+HxAP0Ui+awldHBAbEr4vblIJ9IdeTx7g2gtRrx1GseILh+9/Zz
	aUmOUzW30aW1DfxX0b6aivoylCA8dyu5nTTHJxTXKFcXYQeJpUqRYcH+cRLQPY2L
	mgBawKtvZMT/4MLeuXXScRU9UDEzx2vtpgQNU524wiU4QVKVdS2TJuOs1bU1B4gY
	PP3d9nugzR1z9WpP3ZipFIsVzxeM8o5ivIptJ8TRF5ogVjGNk69Bk7kkhKrB4KZH
	SX87UJJTfzONkxOeiEhrA3XT5VKplB3UT3HP8JIyDOMh/eDIuUKMKAkX4IkMSFbr
	Mib4eA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f468627x1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:43:41 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bdcef50495so3962e0c.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823421; x=1783428221; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=;
        b=c4Y7UwEfM4d3zTKns2TBDgTJY5RLmRwtohn9plALfOxIU0IU3tHqj6uDxoUnpl2MbR
         PgBW/jUgiVAswtMkXxiEfmeSQnmHxRhAi3qwo1L8HvvcVnqzJvm03vs87pwt6kf5jqNU
         puoCLI9AeMhWd2OpzFL1rCOSYRNmlDotWvwL2ffraMs348L596HFHW96QtnceeD1rF9a
         5JZ9iD9fLihFQEWqFegNGhg9F/WTNoAVabpvNqWSfNX7XiEtJzzpu9Ot3t3lrYClsvLY
         RU0l+pd4MiKbrpcDCvBRsEquMSvYlmYrDSY+SU/7ZGfRJ7KOsH+dlXpxvEBd/OKBmbQf
         PDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823421; x=1783428221;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=;
        b=aCXLhv6NRcTe4mpxlburTv/yUV0FruQPagxSJ0HSOAnr5UtyIwInxvSV6qivIh0iAs
         rtSpY2lYew0qgdgoBqqrEs5PCkvUYF+epPiK/O47JQq5DSZLsZkQ7r8i6hjP/QiIHUd9
         Rveg3vfos7K7I6r0bLSa/GY1L00SWDYfX5MMC3P0da06GRitKUVY2psHO1kSF2LTupb0
         4IQAwSl5lpoWnqEgEVUeHXxft+vrubmgc2PZOuP/IPRWyHD2zp3Bha+OZCgYeUM06OYH
         aHBnE6+Ij7YpdQhissJ0dYD7l9ykNyrnGhFACMp8ByVL7tlSw0mGt4PHs6l38JBhC7dn
         9ODw==
X-Forwarded-Encrypted: i=1; AHgh+RrpwVhBvttJKNk2m0ZQa0qZvNJO7JsH1cB/N/4EwKklhLhu+2sJsm1Ccvu5Wa2MbN5qNfWzayE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyKQsMNE5zqo4CEPqyVOQ0ronv2QbidIOieONYvDQFZrJ0TqU6V
	UnS2p5P/JQ0BCBWT77SSZ/oIsbowgiNSvcmDLiC5YbnKNrwRqfJe3Hj52Nk/8xPq7Aqls6G6M9H
	WNF73hfOG2R4y8PaW3jiUAAE8SCdC8elx51y7+eq3f7pfsO8n17TivdhYaCc4s1H5DTJ8WoSL
X-Gm-Gg: AfdE7clZUi2Wo4Nhf0VklKSs28HocGI4e1Phmkrb5wtWsKGJqBZoS2ppgvd0QEFrwBC
	tLTKDzoq/sDxBTgwfo87o+0SCNxBOgyh4Wvxtrzrm218hyRFT/r/cvYjtPkGmJQ0UXrkLBp808o
	tm79w6TNU9AYTaggmMOu7O1QEMfYSH/38BM1L12Au9bIUiZo0Ls/fqYRgzXLRBa7C+EcxDc5tBq
	9nqXYszqOBfs1aIXfe/akP1CzQ/U34AdBc005o3KMyLdUU0w1l7UnX7QwMCQQqUMiDohD+sZjwz
	X0Vag2Xqvr19/Cy5k7UZUMQaASNuOESQG/2ptR9ygX4SJgkniPOxJZNyVbdDgkidGW+hN/UHTEh
	XmeHJK+Wau7ElIeSNhmZP6wCtVdkOnZiDuV0=
X-Received: by 2002:a05:6122:860e:b0:5bd:9cbc:93c6 with SMTP id 71dfb90a1353d-5bdbe9a7662mr493273e0c.0.1782823421055;
        Tue, 30 Jun 2026 05:43:41 -0700 (PDT)
X-Received: by 2002:a05:6122:860e:b0:5bd:9cbc:93c6 with SMTP id 71dfb90a1353d-5bdbe9a7662mr493224e0c.0.1782823420597;
        Tue, 30 Jun 2026 05:43:40 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c968400sm1127666a12.25.2026.06.30.05.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:43:39 -0700 (PDT)
Message-ID: <e05fdb45-0ebf-4dee-8d25-05dfc65042fd@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/14] net: ipa: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-12-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-12-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vXL56xlDQm6rfAu3g2nkefJKyuXRz5HB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX35tV7AxIl0KH
 pWVTeM4f5US4htVPJRiNJkEQFKsQPm7E/AEPgVHkaLp+FGmz+7IyKXtHiubJZsd7RMKBl+r4rNm
 vSkYHM/YH8fpEsR84TKZ+YJ7SHfs1qVHPm+Fk9b5tr5wQDQDS4cuV1Z+RKs3wzgLTX8qWr2HcbB
 GvFaIcKerCmKf5m2R53/HLIDhzBPrhIEK/z86Ag9oDujB++if+TMhK9Zeim+5oYaPq9DXvnMD8+
 XAZOuPgqv2FvGHAtYftwJF+4nzKUxEhHAd5Bii8YcDYGwtBFG1nrI6j6Ebxrr5cmZDoIPcKklS9
 xwrjz3dRIRYSfMUlO7PvtgpU8hdvaRvqdpTOOIQgR1EVHZ4wLGX1MRW3rUkDkmjObsKs7A2Jjg+
 b7tS78RDqMtzotU7HaIZllVLbKxWEhgi1+qJWxyy5frz2IiZHVbtaO/rHSCNEy8X8aLVZK9Lk23
 N79OfZsqhZe6lPtZV2g==
X-Proofpoint-GUID: vXL56xlDQm6rfAu3g2nkefJKyuXRz5HB
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a43b9fd cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=smRyAmGWe8i0dDVrb1gA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX+UPYOH3JFwGV
 apADeQuPlzdxKNZgeC2Cea2t1df30VXLMqEVN6s2x2nqKz17PGef+3J1WnMhP4ex/+nGf8vDtHJ
 4zMPc/8jygGdkJ+iJKl7aGXQdGyFxT8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300118
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,riscstar.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4E86544AFF
X-Spamd-Bar: --
Message-ID-Hash: NWKFDRZYUIMP25T5PLBB42JCAWLTJHSB
X-Message-ID-Hash: NWKFDRZYUIMP25T5PLBB42JCAWLTJHSB
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Alex Elder <elder@riscstar.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NWKFDRZYUIMP25T5PLBB42JCAWLTJHSB/>
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
> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/net/ipa/Kconfig    |  2 +-
>  drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index 01d219d3760c..a9aff1b7977d 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -6,7 +6,7 @@ config QCOM_IPA
>  	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>  	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>  	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS

"meh" for the reasons stated on rproc patches

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

