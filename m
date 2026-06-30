Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C19C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:46:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0928544EEF
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782823569;
	bh=chBZiGh7yrHmSBv8RUwYVeMHSTVTeDhaR08RhaJsvHU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=lDNBvI8qx2VlcJAOPHhwXtnUPwPnmGyLt0Htwzq6KROHro8m6zF8X/qU0FSsbHuHR
	 BNvGHS8816tLgH8hiywzMVloZPNqjYiuoLWbdyiZwYMINP0yCNFNU8PYg1DoiG8H/3
	 QJUQTBSnBsSug5EQhWW+ofQ4mxaUd7ss1VD92Rn2ct9TAe94R/5Qjff1FOcjm+8xdd
	 V6bsC7RRJkNT7Ub8ihAA0s8SZ7jvRgJuHikMokV7RmnCuPxUbKHXW33mMYUDrYfDNt
	 DLcU36fwdBRcrTaQwAmqTWhTGYLzlGTlH05CNtW08rEo/kBIZg+qtqSIVBZtK+cxXZ
	 cgSd5iNKHTp+w==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 574B342FCA
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:46:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UT9LN4wv;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PLnLh2T6;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mk3W1602532
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pY1T4mB/1x/HK2e6EPQsvZx0ZxpL5KScVB8u3NbiQqk=; b=UT9LN4wvBVpM64j3
	F2jAsfAILiZjYRi/KlD2eQ0MOKeqL67WC5X0+CrsUEriaIWFUiaGoLlo+n3Pwl9J
	uHDa0/8eFWFat/YWYLfcEJwEd5QF6bX9Z4OwXSJPbGg0GoMUjJkAUkQYMeCuapko
	T5OrkD9h97gJvlQSqmdsZWKCDQzeVfYFjItUkRfQjt7L4093O0XaIj8fw+CsdQzC
	6IzFQuULY5XFAu2s+/EvblbwfMuHoMlkrDqXKEflaNf/oL5S1uzyQqnYyoqrWkwx
	yTqAI/l1hiSsDIEpN5kwtUvgfTLuPIyzfTdhrgxG+nHg7+1/Cl2Pv2f0ACbtuBXG
	VvR2uQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avprxu9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:46:01 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-738be9df36fso137429137.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823561; x=1783428361; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pY1T4mB/1x/HK2e6EPQsvZx0ZxpL5KScVB8u3NbiQqk=;
        b=PLnLh2T689Dya9xPCTh06dqtZTOnwEuyKo3XaN9tsYSxIeH+pLPFFBCdRsLw5NrfV8
         nDRcLD6rVKA+g0CFE9M3YvodWdWkIU8Rt+0urWnkwNTnPaBFmJRfQN3ytOy/Jy53nMTJ
         XUgu6b0RsTeJ5k/RuaA3vPDvSCjwR1qavEF2WAnJwqxwugH88wa8ZFD00KUoL4/2k4sR
         /vTDhGIth0um8CHIx4G/uPBeeBmYUtDPySqGg8PSGD8WhQH0NeTLpS88H4aC/V1xl+Pv
         0swGS550tIvCt5a6SUmJCxBVAMu2dYlfy0aHqxF7nkb93iz/O9reEwtoNA45jkCU7Qjg
         i7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823561; x=1783428361;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pY1T4mB/1x/HK2e6EPQsvZx0ZxpL5KScVB8u3NbiQqk=;
        b=Rx8vGNdXCAKfvV1qVNvR8p8t6clj82zjcGq1gkqacDhXm7QIw4t6VUVSldyXKCWwoK
         iyDNZO872IaLgHuyV7gEqGfo9VIWQOs6doxJJ0RfKlFYkdh1Ss78TGtqpHQTT0Tr6MZj
         AlxrJE9XoRC5Dq/Zuz1iZxt1TsHzP66z9GtifLiijNXsTH9gtMA5uwuRVZhc841aU4zn
         LGvmcbDPjSRQDaEMj4nqQCmo3CWTCNd/nYkc1GX4bnmMHDXhErzbs1JWEGLSJVPZ6ZP0
         k6TL0lFqxrvvsP8rY8SET6Qg0g2HoUh5UNWVAJviTA7Vj/CvHVrdib60pOupZKr/BtJg
         xo5A==
X-Forwarded-Encrypted: i=1; AHgh+RpJzwPAuDjtJ+wuaDexWiw4a8uL+bUlY7huDS6RJLtbNNtP++eqzXq9j58Aw/KyjuLjdHIzExU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzpwxgMhz7hDry+472P8soLaLO7DPKKnG2JJWlv4CbHl3kE+pOk
	L3lqlL+Vks4eX7MPsmt0aFEYrZfLfFvODGdJVLqjfgE1T8TfyFxu4/v/QhxP98J6vc7NfSrBVIc
	xNjue7lFpyuQzhtVjLQ1hu+7W2ek9vHC/yW6fvl0qHpeR2IyUNAd7sJzX3QTD6PdZHEnMR1BF
X-Gm-Gg: AfdE7cnmc+xsEldNvyGgRgnoTmS07hv1w4kPTcxQzoBaMEn+wwctWKEmbTV9VmzZ9MQ
	GbyTrhZVTwZroQE0Kg0E+SpC34atvUEgE+TGSkioBj+ma+YO7YKvcL0EXP8fUuKPuY2z9w36+yV
	1DHigU26ul3r8VdhYYmTqYjJg/2uTLFlFsp0MO9Mq2fGKeusFBjlqc2p1qY8PLOLtUcvx54aVRm
	+WCDzTq4+QiRJ7IVJ4Y12e/992YHL5bmLe0FDEXlQgdBItiAxToer0nKt36GIMA+XYR7KZjEXI+
	9JzRdE7iWnQDvRUJ1ECOnZaySCOOo4lFtDO/tqv8ry+nIfrzdllqjnzsVHETwM/79nYgiD0pl7H
	RF4v8jDhJMCjyJy30441VDYjn4X2TeDRRMGk=
X-Received: by 2002:a05:6102:5802:b0:729:5cd5:8cc4 with SMTP id ada2fe7eead31-73a38839d2emr587863137.4.1782823560935;
        Tue, 30 Jun 2026 05:46:00 -0700 (PDT)
X-Received: by 2002:a05:6102:5802:b0:729:5cd5:8cc4 with SMTP id ada2fe7eead31-73a38839d2emr587855137.4.1782823560577;
        Tue, 30 Jun 2026 05:46:00 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c968400sm1131274a12.25.2026.06.30.05.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:45:59 -0700 (PDT)
Message-ID: <b14466a5-a064-4723-8ea0-98239cd50437@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/14] firmware: qcom_scm: Remove SCM PAS wrappers
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-14-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-14-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: H46bISCB2mtRWotZICdmYC21p-ROKTD9
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a43ba89 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=n1VOVlC_Xzu4QXtT9DgA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfXxeI/jMX+8psK
 EpT9VjfwVaSWVGG/p9S7b2lb0J8TrtNTEdj5+8bU7BeUaI8Izx41zBITwgJnaeLu0j0nfUs5beo
 CI8I0XGbGKajE5qmisZiDgzVCk1LP2z+6t/lFjJIYKaoqPit1ZKGbhtZj/nqK3NokQ9r2hyjz9X
 bhXy7vHuIV3H7ubJQboHRnDSMxlWpwB2Uppr4Pzm0rWG/qTSWPjNxcuhEv9GnA2I+EhiPuHNSws
 ok1GnXic15qQeb/+zMmKjvZMQ2fChGE3/vFmfHFRG+vPTXoaYaVDBwr2zZ4vH96qTKjMTM2c2xJ
 3We7sx17B6pN8+br91ridLmRA+0qIQaqqex1o2oadoz7g4SvHVhzEgbijZtJVdPZpjLZtBuwiCJ
 c/ziQ3nIBGT9n6xweKeSQpHu7/q3i3n/GXRypgQy84tTfUgbMv6R25kzxQMLNF5TZ8A4eu6qXWQ
 QxnPme7TJxs54kCDKCQ==
X-Proofpoint-ORIG-GUID: H46bISCB2mtRWotZICdmYC21p-ROKTD9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX0Njc5NItFWNu
 VrFOv6nl+neRexEKXB72U73TxA1mv8DfPdMD0a5opypQ75J+1gsiupYoFYsCtJecnvZdWPnPNjo
 xU5gFRqz1gNhJKmeDhI/Rrw9K1qAiio=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300118
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.97%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.217.69:received,178.235.128.140:received];
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
X-Rspamd-Queue-Id: 574B342FCA
X-Spamd-Bar: --
Message-ID-Hash: TM7AFWLN5MQU7DLXM4PP4RFPSPBZLD5N
X-Message-ID-Hash: TM7AFWLN5MQU7DLXM4PP4RFPSPBZLD5N
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TM7AFWLN5MQU7DLXM4PP4RFPSPBZLD5N/>
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
> Now since all the Qcom SCM client drivers have been migrated over to
> generic PAS TZ service, let's drop the exported SCM PAS wrappers.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
