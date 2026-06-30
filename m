Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7DEC44501
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:35:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0899A44ECA
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782822959;
	bh=vLLmYFCrj1ZpLwPqXPaPHpgTs7bbyh+LFs7PAoMXyh8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=v0rTZYHWnzWak30zwVW81RVuVt8Lrn3sShAo2ZxdkcubHK04T11+kM+jIzkkUFA9E
	 6EsRReA0m5ImWEZT3RU/sXl1jlJLFwH9owTfGByDK9XP0w2CgNaNOCJK8kQnSa9MFl
	 vxNhuJFzAagEtZHwfQ87/73fMp7Z1JQxHswCevVmA1uYNlWToMrSSAwSwpWhN++FBe
	 kth7pQrbOLyQ+YNOsOkaPT7RGzr4C82P7tJzoGpINwiPGjmu6o+Ijy0vHUpwi33DnX
	 1CsvRcCv/ytX+AXryYMevPsvPP+Hma7V7TzMxqw0rhELf9+vkzSnbvlkvgYej67hO0
	 x2QNJVXBOEoEA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2351944E68
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:35:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TGPyUaeI;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FvwW2hyS;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mwsc1604653
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=; b=TGPyUaeI7PD0l3ZD
	RXUKwjXocsLqVkkLw493t61d5m5eW5p+GjrblI3HaXwFRFAJyCt8ufcYOL5UMpRs
	ubYftG9AINmVA1xjbKA4MA4O8GENkvzEA/LJ66khEL8Q2SnIjCkWThxNI2Exinrx
	CwNBvO3PSUzn8cYCaTzD5Sl6TUsgjTLZsqkyo89x6+0b/eEMdkChPeMQPDfXxqtc
	xb8mu5qnGtm9zd5IB+jXQLsXM9qt5GxT54Fx/vfUVEYcCnYa9T7TQ6r+4ITYjvUP
	hEA3g2zC/RyAeRNdFTCngAhd1MZnNOYdxGSs2+9rKxnzRV74z1aCc8adLqc1zcet
	HODrGQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fj7c0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:35:50 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9691f63552fso155177241.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822950; x=1783427750; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=;
        b=FvwW2hySyUTysHdkMrCU5uF7OCRFIgNkL3h+BEVhJ3/g8Q5CkzlbPz8OU32PoPNcRy
         VE5pokRt+CAjMylwGGLxBKH9h1VXFzir9NyGzvb0KZ12ZjNUwzfYRRh3bhOgPkXITsxx
         zhmxQR+M0yCaqafM5legRoWthrAo9j3LsuTywuG06mHreFzOKePp/MAYd2JtgiubxJDV
         ZCnSOK8bDZrOMKhA+Af0nILzpsYV8SlVBcQM0rvNgSyWgz/YzlyBH82ne+FojdQu1ZYa
         4nHPd0Z4icclv7CfiI2IGcDudupaGtzmjgTZBBN764Q2qa2jQp9+hQV+9o470XMvdVqK
         1pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822950; x=1783427750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=;
        b=PJ7RQv6g76GaORXdC4vCkiwghyV6lRjP0HZWy41/PuxNYfFj6oJWAM1V0T42ddHaDA
         XMt/R1FnwON5nrffIVYUyQGz0H/0zbmIQQmHDZbJY+SCFce2VwbdceWq0xzBeQISYUpj
         SzoRwVXpi8QZjuyIvBoBizqqzA5Lwp1Q1+eJ05pUw6AS8VvRT4CXLnLjySxrz/Ym0iil
         WiOY5SbKVysEXt1HCi8nI9600KEsBbv9ECEcHQnZS1BI9Boo5zMAPztVTxjtszk7t7Wg
         9UVv/FnRw7cwVq9jztOd2B3LEKGoucZwcxg9yD4aNG90jogDwCG5mQlVy6VA0pBH7EYY
         ygew==
X-Forwarded-Encrypted: i=1; AHgh+RoZgbUYi7hFpJd9NsqVsQ7SarkQHmsNoQh/uXgjznbi52VMDPlTh7yXonsdrZm8oOadnXQtakc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxO2+w03g8lu6FA7DLerk5yTox5f/Lh4pik/mN4aNd8Lg/RZCsr
	/rl5F9HnTUR2+nwUA+wzXk96A2ycHUnqx9Vp9qmBunDe+5ZJSAAlVfdw4mxsFfk1dAOcrM5S5Er
	xn+L8BxciIMxfz7ze9qCEb4zKrHuWGxr3oxKZOQvmstOIOqkVFz5ofjBfo6q7iWg/emrhJdGF
X-Gm-Gg: AfdE7cnIA5PoMcXDSnlmJrxYa5RUaa1QRulNE9+4RiP8JvTx/iVPIFj7hWvG45mphfI
	2uS6QFFRtw/7hrqKf9UnuUs1Pr6LZio9hh42fq8NorsTDepyT285/y1ff9XUlD/In/D81atiBws
	nz0t2o3YKnSbgNnTRG2WkZHHe2WNd0jArbiZ58x4zX4opaZBRljt6sJTYO9UcR+GZc1mD6Mdrze
	a+6RoltJygmkBKVLDsqaW1Yq7gB2LaNT546TPSEndXwLdc1LddCDyaz/jxJX5rZqkRm+hOEFZYG
	1uvtskt0jOdI0wV+Tm+Cq69bKIwgw3eq9mOTIFIJJWkp6pCU5meIHOX+ZqD7Kk0+G2o9oQ6QRD9
	IQPaDyl0Tw2lZrbEocSjPv5PM/7BRY0MsiLc=
X-Received: by 2002:a05:6102:f89:b0:738:9abd:9ebc with SMTP id ada2fe7eead31-73a333cbc93mr634678137.0.1782822949900;
        Tue, 30 Jun 2026 05:35:49 -0700 (PDT)
X-Received: by 2002:a05:6102:f89:b0:738:9abd:9ebc with SMTP id ada2fe7eead31-73a333cbc93mr634672137.0.1782822949547;
        Tue, 30 Jun 2026 05:35:49 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69885c9e8e8sm441434a12.16.2026.06.30.05.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:35:47 -0700 (PDT)
Message-ID: <049a4aba-1c35-4a47-9a34-25e76ae8e72d@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/14] remoteproc: qcom_q6v5_mss: Switch to generic PAS
 TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-6-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-6-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX7p+v2umeE+Bx
 eLu2h+w94BoQ9FU+Of/W7piNzuCuD4wwdhLZA7O2wKUwTKE+ELR0YTgdYtNzTefIC6+DDJ/1U3m
 5GHWMReG7R3wjdpx3oasSnNUWjIETFUE4NmEX/7ktk9/xJbjFXXTF5IG86tEStppL9kmzOkHYk/
 dKz2dFSXEHes/Nozm+N7ketcnDuvzxo4zd4KJZMcA9z9JT38QWM44jLuN0nWZktdU1HMxg56vR/
 Av/hGo/J8yLcvdIAmUtVvAt/RGtRx+7ZG3Z+QbNF7eZToLQ1mWsNwzArBhmmw3mE88PsIzFgF1+
 7zaMnz/o9pRDwWyl46e4jq+TG5UD45jfwYNNGMg1i//jPzaTXv6O0T8w/RdGTW3fpSZDCNP03uR
 OD8QpfkdW5ypuuZk+CkhyTkt5LouA/XuattNFDoK+4o1XG9f8qQZSbTBI/+8UHOmXqu2s/RCDGR
 slndiU8BC/1zahDkM3g==
X-Proofpoint-ORIG-GUID: Q1E-8nZED4xyk_Pa2pxCkn9pz-KbYmvS
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a43b826 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Vkn3R3B67r5ClizzeDoA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: Q1E-8nZED4xyk_Pa2pxCkn9pz-KbYmvS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX1S8e7VdgDeO5
 Kk/Kj0zIaWCXKeQ3EUyGGd29YIeKGkPAH93dHtdIBZNb+Xk7yjTSJ+pmzZ9XwfQiTPw17+qstzY
 nrxxcXx2ChqvQUA3HvnjxpxLjc1P2Uc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.57 / 15.00];
	BAYES_HAM(-2.97)[99.89%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[178.235.128.140:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.70:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2351944E68
X-Spamd-Bar: ---
Message-ID-Hash: QAIDIAUYF3GXX5BGMQO3ONRMUJNQFTSD
X-Message-ID-Hash: QAIDIAUYF3GXX5BGMQO3ONRMUJNQFTSD
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QAIDIAUYF3GXX5BGMQO3ONRMUJNQFTSD/>
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
> Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
