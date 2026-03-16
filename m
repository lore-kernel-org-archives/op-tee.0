Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70754FB5E81
	for <op-tee@archiver.kernel.org>; Mon, 16 Mar 2026 23:03:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AC7DA4394D
	for <op-tee@archiver.kernel.org>; Mon, 16 Mar 2026 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773702179;
	bh=mfzcGstDrFyFY2Sl2/fGkhRvhr57tmO4LPQdDoY0lXY=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=b2cttsBnWRSPn+g6FA88JjbCAErtXO5GrBPzUhsB+6SG6lEbHe/hTyABQTil5piBc
	 6vJpYwNTwG6z8c81bxMEKqZgHdn0/eagJ0cIem8Ux9bZfWj0uJMaE0DR3d5HdGwQ1/
	 V3bUgnN8OxRf65DUb8TbO0PmR3TFP4TgiNYK3G/QMH0Oj8K55v8NKECwg6PWNqFTh9
	 1VPYYZAAdmHhkrncGNja+KlAsFkUeXacAZ2fdpu4DohBdJeSnVkImXWeMcLoNmvMG5
	 qOi7YJmUjTJ2paWNuuOZOyURETQdkEOu3nSFLWiaxpwIKmj/spG4Y0dKqoyLGDJ/Xi
	 9m1J5Wh4xHTQw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F1A574394D
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Mar 2026 23:02:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M9KT9F9e;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KEAHadeG;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GF2hr01534052
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Mar 2026 23:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mlchTDxr3z3qRdgb94yGA2QNfyjLI6qsy4bLeJPkpzo=; b=M9KT9F9ewLJ/9dch
	etaL+nfEl6Ie44a0dNC5UrgWkq/vzzUcnI2g7lXs6rShD5R8IQMxzZIfgk8RY0DT
	IPjTjn8inkoF61vGENpB/n08ate0ITMtWwRGjjsUS/0qKseDdwum2Cg8BYLjGM/F
	Nq6y2sJoXlA1OwPyS1HbRgUmhl8SOUSVtJSAzMjCGjdBRJmax5gnLMMtC2XYytuM
	7zc+F6Tby7aAbkJ6vPNWLYM59K4rvn69Q31Fxcxa+fYKyaqLoOSsOPb4rDDTG73V
	zZVM3UBFpN8WgSxgNn5x9QhdoxcV3wMfgLSk+RfM/vGGCMe+TDKykn47Yq7tgSMP
	gIH4jA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxm5k1gfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Mar 2026 23:02:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so4216099eec.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 16 Mar 2026 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773702155; x=1774306955; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlchTDxr3z3qRdgb94yGA2QNfyjLI6qsy4bLeJPkpzo=;
        b=KEAHadeGkcNyCwxdq5VsNs6iskmOwF4mOw8o2NSsPiewjCsSbUn+/eQSTU4OXIPUCT
         nWGoQVRgBSQbVJbGBtLO9wjcX1k7Gq8GP9TF6OTPuADyWJgNxN3dy/xZ54U7IEiRuWtO
         veLzX9VXHc8KoHzifCT/9xc7/y+Lr4y02WL1lKEcv6cmU9x6yu7wvq8FKMfQ/GGe/9Uh
         5sZ7/nRPX/qC2M7gkC5ie6L82fy47sti1KXR1dq+QbVGvQeVXlEd8d3s9qrs12gn8jQo
         ZCAxJkMBXkdUigYHHl1T226QSmZV211xcVRW6oMxVx7av88g8Fh5M3EtZJcu1ftsXIDg
         Fl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773702155; x=1774306955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlchTDxr3z3qRdgb94yGA2QNfyjLI6qsy4bLeJPkpzo=;
        b=EscqSDN44eiy9q0daO1CgSzexo94r7IOgSv2ANqws+L8cLapV/ibskkXz1mAwTE+P3
         UgpqaP9CfkfS4XT8riNSDbgdtNLQFXzEZ4CC7WCEXz3d6w3rKd7uTqip6doUeJH/a+D2
         lvfDRR3Q9o6yYIla5Wa7GEJCV7Ejf91YO2/kMHwkZVT+JF2MXszXyYf9b/Bpm63VnCpV
         l4WdogInJISwwNenBLAk+cBHNeaOYNjPcpi/657Hxphx1d0wij8qGukuvwd8F2XW9LSQ
         PcWPMS/uHXnQ6i9niEQ+g7RTWh+JYRxvjAhvpLqYgWz3/wtt60CGcd+B0Nuj1Z1eb3Br
         0veA==
X-Forwarded-Encrypted: i=1; AJvYcCX/CZ5xurIU6x1FVhx9kwOXeHBQow0ih1wF7gZHAtiay7foSJQnGfe34B48KFBst3s90EFFFio=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw79yX+3DOMR48Vil1dvgBSLh/Kp1MqKVrjsRqPhkVJ/AjKRrNB
	IycKpquQS1cCBDDhFQowTuAG/UJpFYYMgiEykRCgtrNFfcICkEzteIoc7U4sw2GqdBUYTO0vyHR
	EzxL0TTikE/TH0e4DNCSE2WUssGcWHHvZ1xuwi/CfYjHXFVNOaKGHXPV3/SDu6KUL/zngkq6R
X-Gm-Gg: ATEYQzycrqyzjvs5GWcSeqRgntq6MAPGAal4+vqN72OL0TeN+Xw97VwCl2NMggoIyB2
	ywMT4MOIuM0YAQhbmBIVt/6976rWgWIRa6UlVLii6VxkaPNFTDYkNkhbaEU72IIw12teIfyd1lo
	ArCp0ytH8txS9uNtnAzzV0DPKnJqLGucC9kXYWXJF94TkxVPlfqty/9kYkEgcxfMvoY+JqU5iv0
	xRBaeTywbxKXOgSPXvLIzp/hSdq2rxL/9zIZwk2rKt5GuMSZbByTvxmHcIPXBE8J8oO1DQaiQIO
	buCsAoTgU3gzCn+/fRgMQFqdMlg0sKNSDqV35R1pxsXsg16Jlpm2rZsl27k0ryqeE1+eKRr/Ipd
	AoLs5dY25Eqcik3pVTlQlPpmrr6Ujnx2yAkczSujN1dijaAGqt3QuXJEKqxFS0COhaV25ROWt5Y
	bG2P0S
X-Received: by 2002:a05:7300:6ca0:b0:2be:1779:3289 with SMTP id 5a478bee46e88-2bea573d146mr6203998eec.35.1773702154744;
        Mon, 16 Mar 2026 16:02:34 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca0:b0:2be:1779:3289 with SMTP id 5a478bee46e88-2bea573d146mr6203932eec.35.1773702153972;
        Mon, 16 Mar 2026 16:02:33 -0700 (PDT)
Received: from [10.134.65.116] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0bbe04304sm9795623eec.23.2026.03.16.16.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 16:02:33 -0700 (PDT)
Message-ID: <3934e17f-a2fa-423f-898b-a0d89e69f564@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 16:02:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
To: Krzysztof Kozlowski <krzk@kernel.org>, Sumit Garg
 <sumit.garg@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-3-sumit.garg@kernel.org>
 <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
Content-Language: en-US
In-Reply-To: <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fJ00HJae c=1 sm=1 tr=0 ts=69b88c0c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_eXaltnX1kRmSEBu75cA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE5MSBTYWx0ZWRfX5H2r/nHTp5dD
 zLGHA0WOBYg3qjtAP3zeQCDsLTXysGpxb5XPgMeKvzfpS2JtkQ4RMJlVlw4xwlRhoNYqM0QQmql
 FGbhzliEfNnFWpuNXySk8G7pdcdgQZuu8sYxp+0S8BaRHQjWUQEwzwcsjk2vS/az5fTneR+PXET
 BY26gRzgEjsfX2kqzBR/kstkq/xe5i5zc01ODj+A7/U7bIVwuxAfM8/VCG8U/tPAnmfjvzxqr9U
 02dNmGs7WC9coLwbHq/z2a/IOXynePEdQ9T+yWr0bdQrM2JnXf4UgHbcqckZbbhC0SirkECnuDz
 kJPVbq5tYI+KiQFaHj3wrf3WAAYQsZGhk4+4BKWIAmsNY8tJGoxLMTRv1p24xpH1+6kNG7G2vTU
 OrdvvLChiPBnmmRgm2VtPmvECuJWAo8kOd++zKibYwFmW0CAB7++kWCCr+XIu7/kZsz++zQ/jBP
 AfdXy6vi/OyCW/EYcZw==
X-Proofpoint-GUID: zHzIL30cV-uUky-XygN2nlF3sJnLFKTi
X-Proofpoint-ORIG-GUID: zHzIL30cV-uUky-XygN2nlF3sJnLFKTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160191
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[199.106.103.254:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_GT_50(0.00)[50];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F1A574394D
X-Spamd-Bar: -----
Message-ID-Hash: SAOJ3TKCJHKAAHC6BWREB7TDFG72K5BU
X-Message-ID-Hash: SAOJ3TKCJHKAAHC6BWREB7TDFG72K5BU
X-MailFrom: trilokkumar.soni@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SAOJ3TKCJHKAAHC6BWREB7TDFG72K5BU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Trilok Soni via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>

On 3/16/2026 12:51 AM, Krzysztof Kozlowski wrote:
> On 12/03/2026 07:27, Sumit Garg wrote:
>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>
>> Qcom platforms has the legacy of using non-standard SCM calls
>> splintered over the various kernel drivers. These SCM calls aren't
>> compliant with the standard SMC calling conventions which is a
>> prerequisite to enable migration to the FF-A specifications from Arm.
>>
>> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
>> support these non-standard SCM calls. And even for newer architectures
>> with S-EL2 and Hafnium support, QTEE won't be able to support SCM
>> calls either with FF-A requirements coming in. And with both OP-TEE
>> and QTEE drivers well integrated in the TEE subsystem, it makes further
>> sense to reuse the TEE bus client drivers infrastructure.
>>
>> The added benefit of TEE bus infrastructure is that there is support
>> for discoverable/enumerable services. With that client drivers don't
>> have to manually invoke a special SCM call to know the service status.
>>
>> So enable the generic Peripheral Authentication Service (PAS) provided
>> by the firmware. It acts as the common layer with different TZ
>> backends plugged in whether it's an SCM implementation or a proper
>> TEE bus based PAS service implementation.
>>
>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> ---
>>  drivers/firmware/qcom/Kconfig          |   8 +
>>  drivers/firmware/qcom/Makefile         |   1 +
>>  drivers/firmware/qcom/qcom_pas.c       | 298 +++++++++++++++++++++++++
>>  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
>>  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
>>  5 files changed, 401 insertions(+)
>>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
>>
>> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
>> index b477d54b495a..8653639d06db 100644
>> --- a/drivers/firmware/qcom/Kconfig
>> +++ b/drivers/firmware/qcom/Kconfig
>> @@ -6,6 +6,14 @@
>>  
>>  menu "Qualcomm firmware drivers"
>>  
>> +config QCOM_PAS
>> +	tristate
>> +	help
>> +	  Enable the generic Peripheral Authentication Service (PAS) provided
>> +	  by the firmware. It acts as the common layer with different TZ
>> +	  backends plugged in whether it's an SCM implementation or a proper
>> +	  TEE bus based PAS service implementation.
>> +
>>  config QCOM_SCM
>>  	select QCOM_TZMEM
>>  	tristate
>> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
>> index 0be40a1abc13..dc5ab45f906a 100644
>> --- a/drivers/firmware/qcom/Makefile
>> +++ b/drivers/firmware/qcom/Makefile
>> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>> +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
>> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
>> new file mode 100644
>> index 000000000000..beb1bae55546
>> --- /dev/null
>> +++ b/drivers/firmware/qcom/qcom_pas.c
>> @@ -0,0 +1,298 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/device/devres.h>
>> +#include <linux/firmware/qcom/qcom_pas.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +
>> +#include "qcom_pas.h"
>> +
>> +struct qcom_pas_ops *ops_ptr;
> 
> Same comment as before. Don't create singletons. And for sure not global
> ones.

I agree, no globals here please. 

> 
> Best regards,
> Krzysztof

