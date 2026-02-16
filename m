Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88C9E63F2A
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 05:19:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 14D8D4386E
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 05:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1771219151;
	bh=osguoDVxc8P3/XpDLwljqJ6yeacM7nhK7QOCdnb389g=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2WoXTCp+iYGGzBapY9r49MCG44qyC4D05D+hccCnRbtDUk9ND+0Vckphwxdzmpfgv
	 jz495hOBnQeiigu7VTq7ETZs1APjWa8wyPRe7jXlG3vAwXKe30orK4QptGlp36tpq0
	 NRgqO/o+SAV2wg0sJPYm0E5+oIe21WlsTtubRDyypj6FBHGJVGoLFC+EI6nSQMfxc7
	 PyYTVxy8ccRDy3i5rTAuNCpj/jbzq6Yz59AQVRsmUbn9AeE6a+wV83YLCRKsT/pm1W
	 JXGeN0+jD1PrTaCH97XuEj8ALt/Fm0+4S1XMXw1XSY4y9EZbF/F32zrIqB+5DJ9a2b
	 RXVgMJL2cHY/Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B759743862
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 05:18:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=An6wArRS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TQw0+RSN;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNkfJC3701304
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 05:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hKlRNn/J/g8d7B0SEHfDZ310NhsfOrKAigvA5TUQRk0=; b=An6wArRSpUv4SC+H
	0Uk6SPTaDYXDI13PNNCxIKAyKrwhSToWaqNpB4UFD5xrSa78VYApv5GtfLd7b9aA
	75zgIs/EeIF938SZo7T5anXwSZ0fpp2GG1/PVKh4Z1ioOhw3kE7/+w07E2dQCUS9
	oEwgeslo3mvXhMzUeqREH+mcDN9MAG8/n63sUTcnPJKTaS1bzKqtHsVs9Z9MCxU5
	ILGSVdxUdPP8uhxhI4bh77wTYBkRpObrjmyTm+bnkoNzVmnR5owELfDWqmmfAK0u
	3cgYgpJRe5HwYdy5KklWgKar4IOfNOIBVTsiBzAQzHnTvAPUL6WWtm0DStrBCOdw
	h+8KIg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cag24bjy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 05:18:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a7a98ba326so38337395ad.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 15 Feb 2026 21:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771219129; x=1771823929; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKlRNn/J/g8d7B0SEHfDZ310NhsfOrKAigvA5TUQRk0=;
        b=TQw0+RSN/rJ/24kqU1rlnrS/rbkCS7HgPePZH4vwHV+NC0pShjl3lLRUsg7/SSwvnJ
         jxUPxc/XwaTS/q82nbfEdlYKKVTeS4+y9/DXYT+sEEFYCdKdpSgbaRf3Ja0N0IgP3joF
         dY3NQ0Sedx2lObKeEySDDbkKF1r6i5sCGG23wOSDurOQXuZyfbLRhL+n2E6zmac5tWZd
         MMEgE38a07ebjLXChNRRTWGBdIjP34eO+kVenckOUXatpBKjJGq4CiFDu7xTRDSh7JZb
         EC9d1XPGy33JWkaNnDIyv3tzDf0LTaHPFra7mAhS9i3XxKaOIU5zqpgBACnhq17AcYPq
         pgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771219129; x=1771823929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKlRNn/J/g8d7B0SEHfDZ310NhsfOrKAigvA5TUQRk0=;
        b=PWHdJhjKru9M4tjrSX3wIdqnqfg0vWoagLhGohCDYfscNQlG5tc8oX8AEgpq2njGdt
         mG8Vp2ye9DQtB4vt739M6T9HTNjjqvrDdx5mBiHHfohF+WpxIUukerwBFMiE04oGkH/0
         u+kclums6Op4NcvEbiEbgXEqegK+f5c/coQeMhTozrW9qP8atIJHpSAK53yyukxDns0X
         xBCWv4zySeas4hQKiHzGNo/IIKDbcVCl7Rf4MDOOELK5Z0MUKT3wUcy7db+pSMa0gsY1
         +uWyT3gD3J8JyMA+QLOS5nNOkLJXQU5wdw+6XQLEvsnjGt8JyVYGa1vMuFxUajKHN5/g
         uVgA==
X-Forwarded-Encrypted: i=1; AJvYcCUwHhmmKKkL0hNbPXo3uNRSNjp56SmjRweHunbfVZCrGSCYKtwKJm/J2BfPcRsj1jclKrYmFbQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw2k7oDZJFQCfMcBmVPEJH7dyRuPEE09Zyr/zv7ElnRSFCY7rwI
	guMYm9zIlOVUL7VJHJ5njc/WC8i9/HSCSm5ao0BZVtkeDjlUEqBP4qDVLA5dzxU/STxwtMNznuC
	Wuxowqo7R+nNd0F8SneFnDsUbmZmFeGCWo4hySGfeDOc5El8LozRsJVuEZJvHAfdhhZrgc6DI
X-Gm-Gg: AZuq6aK3IeQHldqGHffjn927M4x4dbi4YAYua9a+jfvtXiXzoTFTw7zB9vQfzFa6X1a
	Elqvu2zYX54Iq36i8byvdcBuz5s51XWHfkZNhzuACt8EdNXyvOadfSTJonJ9/I1SWnhPJFjq9Hz
	jj+JoRZN+rbahLadGrGhU0sjUztgMP5lXkVUcyo2KVaLp7d9wQD4pAmccYA7S4it+IiaxB53K8L
	vK/xXoUmre21mgKpFvXo7zL7ufAqF3QubX59UGMhySc9vfB2hsxkRc1uiYHxXwD+7r02Ri3bBoK
	+7eDLcQYQI2lmnJncak0PVIV1Q18y0cWgG3R+6vV/wco+6fISszaBZ2qO4I3k6iiNGf5CnO+iKo
	QoXLDUOFolhRRd94ai7S30cPgHNUnG0ojmxiL6gEI63TpQ/viAXRIcA==
X-Received: by 2002:a17:902:d58e:b0:2aa:f989:dc6b with SMTP id d9443c01a7336-2ac97413d94mr83880365ad.4.1771219128863;
        Sun, 15 Feb 2026 21:18:48 -0800 (PST)
X-Received: by 2002:a17:902:d58e:b0:2aa:f989:dc6b with SMTP id d9443c01a7336-2ac97413d94mr83880035ad.4.1771219128387;
        Sun, 15 Feb 2026 21:18:48 -0800 (PST)
Received: from [10.217.222.232] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d6134sm58832095ad.57.2026.02.15.21.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 21:18:47 -0800 (PST)
Message-ID: <91ccacf3-68cf-4bfe-879a-db515a6732ec@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 10:48:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for
 QTEE-enabled Qualcomm SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
 <b7985f86-1df7-439c-8c54-abcf693180d0@oss.qualcomm.com>
 <f8a0e9ab-2d11-4ac9-aa5a-f216b348f81f@kernel.org>
Content-Language: en-US
In-Reply-To: <f8a0e9ab-2d11-4ac9-aa5a-f216b348f81f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oujhRTU6F7HaF691fou2qo-sBsJn7OJI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA0MSBTYWx0ZWRfX80rfmUx7hExs
 TNjp5oaePQcAGvaiS3sP1OQweQ2rXevRxeOZTM7rSTFhwV2eKwZRiDcEkX7Oss4hrxJuuNKK42+
 MMY3IEfBvrQ0wYuH3G0oZTowc56W51hHo2TgvQBP8tj555K8cLOuPTLJ1fBz4C1neI5AkD7+pVf
 kxxr+yUB91X8Qfu5b06/ihcHNrWrQWHw1KDzm8se3J3CAT7mmw9g2edRYhShcMxSWY16i5Tu+9z
 w74QPhS/1hIYD4AakrOFqsd+uB6CBQTV372YIMfUa5CXi4ISxBuZMUZINego9TVsrjMafMbR6q/
 WLC65gL6ndBc2iUKAAZpZMzq5K1bfCxqx7tEux6nBUW5pwVC2YVtjudzGSBdF51H1s9ljLKNzmW
 yRoEWN/LykPbpUoyvyyWfYYupxUhhMbhsdHVNKQGQMHRFnVXHZ6IRoVHpZeE5mDH3mdsYSarCpk
 TYOoWumdVzbByoCUAOw==
X-Proofpoint-ORIG-GUID: oujhRTU6F7HaF691fou2qo-sBsJn7OJI
X-Authority-Analysis: v=2.4 cv=aetsXBot c=1 sm=1 tr=0 ts=6992a8b9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=R6zhTGt-_hrt1VAhaDYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160041
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.199:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B759743862
X-Spamd-Bar: ----
Message-ID-Hash: 26M4Y46T7VG2BLH3DXGP4EYC3Y5YKS5N
X-Message-ID-Hash: 26M4Y46T7VG2BLH3DXGP4EYC3Y5YKS5N
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/26M4Y46T7VG2BLH3DXGP4EYC3Y5YKS5N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>



On 2/13/2026 3:56 PM, Krzysztof Kozlowski wrote:
> On 13/02/2026 11:24, Kuldeep Singh wrote:
>>
>>
>> On 1/14/2026 1:49 PM, Harshal Dev via OP-TEE wrote:
>>> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
>>> Trusted Execution Environment (QTEE) through the SMCInvoke interface,
>>> implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
>>> on ARM64 CPUs and exposes secure services to Linux running in the Normal
>>> World domain.
>>>
>>> This change enables the QCOMTEE driver as a module to support
>>> communication with QTEE.
>>>
>>> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and
>>> executing a Trusted Application via tests hosted at
>>> github.com/qualcomm/minkipc.
>>>
>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>
>> Tested on rb3gen2 device and able to see driver load successfully.
> 
> What exactly did you test? That a module can be built?
> 
>>
>> root@qcom-armv8a:~# lsmod | grep qcomtee
>> qcomtee                32768  0
> 
> Sorry, but that's basic of kbuild and module system.

Yes, did a basic testing only.

> 
> 
>> root@qcom-armv8a:~# rmmod qcomtee
>> root@qcom-armv8a:~# insmod
> 
> Not a defconfig testing.
> 
>> /lib/modules/6.18.0-next-20251202-00002-ga8c3ce157925
>> -dirty/kernel/drivers/tee/qcomtee/qcomtee.ko
>> [  164.464598] qcomtee: QTEE version 5.2.0
>> root@qcom-armv8a:~# ls /dev/tee0
>> /dev/tee0
>> root@qcom-armv8a:~#
>>
>> With that,
>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> 
> You cannot test a defconfig.

Sure, we can drop tested-by tag.
Maybe patch author once send next rev can just add Reviewed-by tag only.
Hope this is fine.

-- 
Regards
Kuldeep

