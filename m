Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CD5FCC065
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 20:00:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6543C431F4
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1772827256;
	bh=pbGgSdTnpxkY+2PiBhxk8UbO864vHB/UN+E1PY8xpl0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=TxqycGgms+9G9VefZiXrVWCxBGEZ6BCUNrEt8faRp21ANnL5TbHrh/QPIBe0P58In
	 M6oqnNEIHs8EFkX7Mxu8jnWrMB27+pndFmqpYduPkkRXcJtpNOZhc860YjAxacMxj2
	 9MIxcxrfgZXhCqQAWVREJ5L1RD43LHmYlF6WkKdwJZS00DElw4/qiD95ty7WX/WVF8
	 eUqf8YMotK0lzoFDrfqOfG6iZQGRbKE+VuaQDWZottIt1dMUGtzqbqteEYp+gqJE2u
	 bXVDieaITUisudpzDShDO1KxpVKmqLCr2lbUR0CNhjiP2KeaMTZbs6lG3U9A1daSkS
	 E2/wYX7TdDZSQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7D135431F4
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Mar 2026 20:00:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iolXTHdg;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IBUtT0FI;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626H1n6B707421
	for <op-tee@lists.trustedfirmware.org>; Fri, 6 Mar 2026 20:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EiYJflmZS+8yawIrFdYuvTAy2GFP2luKLW8xrlAeVbY=; b=iolXTHdgTdjfeOyD
	ZD1CaIv9BfKoTip56GVafVAI2pWYzNyMQHZIxdjSM97kmc9JYu7asDOGkKqXqzrG
	D7A6EGYVAir86BPd0Fn5Q7raSMDJWV6EdF1O3A4hsajmSp3swGeGIcffEwCsft2n
	6APlbK6ZVqMBM6cG+C7pk5Kyz9Fnh30veQDKzcgTG1qjkwGPUVXTxVRF9i+aiQDC
	5JqWWkql44Xvn6k9P7HX6IFX1mIcJWe549u1vpndfMKiUifO7bDmCekNyqgD56xS
	T/BL//RE4mKtCpeGpFZaumI8aENVJTpmUafJihIs4uiLWyozER6TEuIr1RntP5wd
	ADUk7w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrukaubn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 20:00:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdff07d8f4so9464048eec.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772827236; x=1773432036; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EiYJflmZS+8yawIrFdYuvTAy2GFP2luKLW8xrlAeVbY=;
        b=IBUtT0FIEVgCWuIXia3gUw9mdTXAVLu26xvUtCKoEjolLENWxLeChCLu7Ki4GedXEt
         5isNYKbQbeGfDtPTQIjwpNDF0YQwOCtcyMuQSGqQfZ8+P1UvXG3x6a8KNKr7oGI4KNyb
         7SBXhitJLMuaYxxTisUXnzW6EsfEjODrT/pO6IYdlqHDEeHPNB2rNqDtwfJeJ2+Um1vt
         dAoxl6yyW39AD01AQZ7pz9m9dQuMe3qQ9JpFXPN7/xzeIa670ShH8OF9CCPDe/ACcd4X
         Q6O7V9ZUe99fBxWIrPKQYTPEfPHHDRAjz4XZVO/AY/yWeTF+GHAqlze+BzJA9eB08TpK
         6vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772827236; x=1773432036;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiYJflmZS+8yawIrFdYuvTAy2GFP2luKLW8xrlAeVbY=;
        b=A0VvqJKFHUnpWnADNjkCvOdygp8OAqucSLA/F+OT0S5oBoW4DdZUZ0TWo3sLS96a+G
         YJSTtDyBUoznWhsWvFYiG81HY/o7jD1AHtFVvLu/NtUC1dOM+lAXnCnzvWrqMzA/2y8Z
         mWf4Zvc81Zcct3wRejwKxKi8qY8GWwbJyc/38aXQqQ9byRmRTMXcxyCagIg6SEKEwCj5
         HOuwY6oRkJu2PomgKpanVwVFxNIyVrORLWdaFI7YsJEIAyRopNqH/U/NAcfjdKLSKY+D
         f6Ee8RdVkbvRO8WQT7yh2+PN+64P0nwZ1OcJ7FzYfM58vMMGGm1+HB7FRS2z1WEyWGKi
         xZWA==
X-Forwarded-Encrypted: i=1; AJvYcCWgpfO3tRkGGKt2CSdCy14HQuPo+t4EAcPN5kL8GFmlLZNyzF2xeoJnLmHm8V+LNuTFetSsg4c=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxnavRwusFUg21QBKgz38GKTpx1M+NlRLZNbNnK/PJMBEMapQTo
	KO6duV2GIQE3yrODUdaQaKti1jqjQrcrO7Rao/PhY6PoVEfv/d1k9/+B5oXiP6QI1fmuEL9vOZv
	Q8jfkqR+4eapQC4qHssShCsw28kB0ANVlRHQ4hh0jd3+SoSR8ZzwzfEWh8IgiYLpJP3j8Aq+u
X-Gm-Gg: ATEYQzwM8YFO9pNYlHflB+AiCHAwHrtQRxBMR3GrCrsxHc5s4fK4F5Wieu1ahOW1j00
	a+8NvZYcUTI5HrMINGcvDENHPpZmLkNs1HHlmFuJh9+SFPaAAofuDZEAlka2KtuQUrxpfOc75/b
	Q7Svd2TNHv84rTAwzUeIAjZIK6eoHyiqCrWP+auLZMp8xBeNUOEbHSzLNI3v4HvcCfA8yVF1/q9
	CXr4hbCoxDAfAmv/m+nmM08IC9riy8gdp0LT8eQ6abEM83xWVcu0fLjN650GKPTgmUWq0QWtjaq
	WH8NdChBYHu7xcsmF+JgIV4zR9bfsJpS7Y5h6RDsFj7rEHtlaqsfH6mLam6R3INrQ/hqShq8ru1
	b6FWgZ6nvtXaxlAWscIlI5NKx3AlK5BK4rrHWTpmNDL41gP77sHD05lo=
X-Received: by 2002:a05:7300:a887:b0:2ba:7069:686c with SMTP id 5a478bee46e88-2be4e01911emr1342887eec.17.1772827235512;
        Fri, 06 Mar 2026 12:00:35 -0800 (PST)
X-Received: by 2002:a05:7300:a887:b0:2ba:7069:686c with SMTP id 5a478bee46e88-2be4e01911emr1342841eec.17.1772827234438;
        Fri, 06 Mar 2026 12:00:34 -0800 (PST)
Received: from [192.168.86.165] ([76.176.48.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96aa3fsm1798784eec.24.2026.03.06.12.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 12:00:33 -0800 (PST)
Message-ID: <973acaab-f2fa-4e2a-81ea-9d7fbebd1ca4@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 12:00:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
 <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE4OSBTYWx0ZWRfX+ZVQxGGDzI6j
 pXl/wzPtjZHUv521NEUmI+T0ApXBrIfO4ilwXHwcFLqx5aybWB+KY/k0ad4fxRU7zYIyy+imEsE
 210N9nlMujy/C+j9CNwYu4yBgfFpjdulYJxpxmKbg/Gn7PTeW8v2szBXArcgXO3mj3+MetMa2E6
 CgvuU7UaHpMj2xMICBIZzr0Uj+55FhkLYDnPo0BKaxBPQZ6PVhiaPRRHeOkNo9i3ca74ixOKt6o
 8r6xwDt7d+kXhgPp2glhvyQ+7LiUJVuv3kTXHgXjaIUgNzfWXIfwZKhZ7Ir9v7Cl9FK+y96afcK
 KWKRrrjv8vJ7e6JlwaKI7X/nJBVBgFHXUIlEyM2mD+A3DK4CwaMy5zcHbLappVmhb5GpHK7F9n2
 jnpcIwK5tMbx6ohCryu4fE1/pDpeyqZ1k8APFz21LwhT1zWFYScY9JheLWZ6a/kHBRBhKv+QE8X
 HYJRV5VgHuxGwGmwu/w==
X-Proofpoint-ORIG-GUID: 8AXbyN-tNqbjNq-F_jjpNdpJLilsbCRS
X-Authority-Analysis: v=2.4 cv=DvZbOW/+ c=1 sm=1 tr=0 ts=69ab3264 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Dui5BcQmNnZPeg-S7-oA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 8AXbyN-tNqbjNq-F_jjpNdpJLilsbCRS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060189
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[74.125.82.198:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7D135431F4
X-Spamd-Bar: ----
Message-ID-Hash: 6OCRDBQ6BOGTEPX2HMOVIX2ZGAPRTHSO
X-Message-ID-Hash: 6OCRDBQ6BOGTEPX2HMOVIX2ZGAPRTHSO
X-MailFrom: trilokkumar.soni@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6OCRDBQ6BOGTEPX2HMOVIX2ZGAPRTHSO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Trilok Soni via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>

On 3/6/2026 11:47 AM, Trilok Soni wrote:
>> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
>> new file mode 100644
>> index 000000000000..dc04ff1b6be0
>> --- /dev/null
>> +++ b/drivers/firmware/qcom/qcom_pas.c
>> @@ -0,0 +1,295 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/device/devres.h>
>> +#include <linux/firmware/qcom/qcom_pas.h>
>> +#include <linux/of.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
> are you sure you are using functionalities from these header files?
> 
> I couldn't find slab.h usage quickly and also qcom_scm.h. Can you please confirm?


I scrolled this patch too fast. I can see slab.h usage, but not sure about qcom_scm.h. 
