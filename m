Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DEEE7BD8C
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 10:37:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 158D34373C
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1771238229;
	bh=Jcrr0ell7ZjSC+hrrzufuSoAx2JpzY8PBvHSngyFezc=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=S0HLWS0wNxlqExcUgQD+uZ8nLwiCLzgTYU0B9cwvJm9z3usb23zcWJNUnXyFMxUGA
	 d8dNLIIbePzaVOwkWH2iOKFQIt6F8PLIPWxgWV4h15nOoca7Srac09ndi/12SoV/bA
	 2GXcYmvVgl/GQdfkaiFwyTEOYKsymD4CTcRteslXmVZ23xmynU71JGDaMK3kLqkwGs
	 U+hFBG3XqOj1UM3lYE3M+tMF1M6Kc00F/Ie3ACASz4hvii+yn6nhdOETn8/v7KSkTo
	 gQtIezHFH7MJ27CCcmZ/cbCEC1O18yGB9Rhe/XT71oj3BKyKsUN+WBrqNSfyHRKhBm
	 F/BNYEZZGQq5g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3FA0A4373C
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 10:36:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LXKtirxY;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JI72zqrC;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G2D9Sk3304890
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 10:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vUppZMG2kbHSluYOtVfh0HEqdUnanM8/Su/1nWgK+Xo=; b=LXKtirxY/38TDAtt
	6h0vGgHZkcITN8P0lnd52/AMkEQ2TGVsObFriy4EhxEjaxWynjiZXRpa/wQLVReO
	twjN8QZoQnpymvoug9I6QpY/t1t7hVADxIkSkOHulxO1091oLKgOfGsfJt8TrEQC
	m3sv3KCSoHDoBoBckm8/H8vAM/5iMPw1lmXEcqh/tMTep4dBJB1gc5MPGxlAEehz
	IkFq9NK/5+fpZUQbcMjdisG7MK9pMQ+7H0pQ8acJAEq61Zqyg3RHgedDTq0jO0rg
	zdi3Oouo4nPSBWgsuy3UE6njCMJxLc5P8ME7Utag+vxKvbTYKIdwa2mEtjUpUxSm
	Ho4sDA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cahtcm3v7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 10:36:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aadeb3dee4so171283675ad.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 02:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771238207; x=1771843007; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUppZMG2kbHSluYOtVfh0HEqdUnanM8/Su/1nWgK+Xo=;
        b=JI72zqrCGURLzcXTslNCCflCtHT2EtD7QfUyFM7BfVaJnkRpIBbar4gfvqHoxARNAE
         UPpIVQ0inqBzvNNaca8jvY1qk4JywA7gIm4ZqHHojL+RZyDwu7Y90vjqKMg+uxTRVtyq
         Pbz8H50/0AMheYcB6os9W2OTFngSbLtnrk12n5kzYnsex5/w5Qs+xyqkhSuskiTYNUf8
         WBLw1XeFVL7aOC8/T5JqIIy3dD7x8DYpH6a+P7PSKv5sbmPhcjnkTvvH54x/oVN7YrhP
         EHgjSydsXqG1HXxnQPcc/LzhvKQzRePxBHjARIMwuK6mrt2DGqQEJnyKF2xHKeZcRuei
         sVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771238207; x=1771843007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUppZMG2kbHSluYOtVfh0HEqdUnanM8/Su/1nWgK+Xo=;
        b=oCcmut3BXMP1HVgITRXf6Nl1bjgVPYJ0RoBjIHME+QGZEGILXTJr9ly0yTW2grXuEe
         DvSO29zI3dCK0FPf72EVp/trlZXGIAy4ff0npX0i1IRxWeqGNj+IzQ9WZcLtDzR03K09
         KkyNtpsD/UEWKaIqzaDjRSqaLtFGdTBH7CwIocLqrZsp+BT1YC4A22EXdjdopyYHpSkH
         XA2YhpqXxqFoBuUZBYlxhro+JRRyXkrl9Uwwb1ORbtLZllLIK4JGb1pZ1nVblfdz/Z3K
         +/5otBKUIIr8/2dvCmOPRgcAPaeCXCYbc9vkSukpocy2k2yYVDXNHiR3JZJs0ud79GUT
         czVA==
X-Forwarded-Encrypted: i=1; AJvYcCUIYe85IYCpdZalVpbP7dxsAFs8IuORNYrVuqC8gSljsqCpnrYSctJChH+jb2t0+kFYfUSPkl8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx4zSBsaNknOY6tamf2pWM/6JchcaH9nUlft4EEVd1epQAvCkxd
	dbFja9qkISjScqaZn6SySWqYXo2Hwy/qB9MuJAqSgl8sxM5dWBi7Vf3zEZpeGNaLn249INnjPs8
	Tr1dFReQxnakVmGgCLbBno7HIGYz+YNjjPYFxtyoEtZnVIPr+Xfs/MWXb7fXg6sS/7Y0cQ3bS
X-Gm-Gg: AZuq6aKLjfcgvrZa7c0i0Nf/cBW3z1ZsbLHNR8UsFEKzrgVPIMub/Vm/V3V3ZYMMVVI
	tpO2ROx/P6CNs0IAPz7QKzw3uGrUVDfOLyCNO/sqEdTU6y0spkle4iL6auqJxwPBYQClsRJVa/1
	AHMOiffzNYWCcsJGeMq4jLjHh5TOAcFLPnzzNU9UKx6z0yWG/ZmsKJRKpxwXXvehlBGH1EpROyj
	sy4QqBZZEL4bdmAtDYG0q1mgLlUQdgsTJQWHsoER5E1koktc/tCNkHeEW/HNcQAxZaC/zn/LxxP
	qTp0oskTZkb9YYu9AW+sKcq2yIKwcyevFpZ3+SuKxlTtCR7QOrUofWVHwry+k4j0rJjmKcAQaNK
	33TVx+zpU757MpZFALf/z5vhtYnAu0SomZyCQwh1WqYNo9z9w22I=
X-Received: by 2002:a17:902:e74f:b0:2a8:2c4a:3570 with SMTP id d9443c01a7336-2ab4d080a3amr122792295ad.49.1771238207255;
        Mon, 16 Feb 2026 02:36:47 -0800 (PST)
X-Received: by 2002:a17:902:e74f:b0:2a8:2c4a:3570 with SMTP id d9443c01a7336-2ab4d080a3amr122792135ad.49.1771238206792;
        Mon, 16 Feb 2026 02:36:46 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a738220sm68420565ad.37.2026.02.16.02.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 02:36:46 -0800 (PST)
Message-ID: <804c0c03-d461-4fd9-ad0f-be123b3f1798@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 16:06:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for
 QTEE-enabled Qualcomm SoCs
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
 <b7985f86-1df7-439c-8c54-abcf693180d0@oss.qualcomm.com>
 <f8a0e9ab-2d11-4ac9-aa5a-f216b348f81f@kernel.org>
 <91ccacf3-68cf-4bfe-879a-db515a6732ec@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <91ccacf3-68cf-4bfe-879a-db515a6732ec@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4OSBTYWx0ZWRfX9+CMQZZvfZLi
 VxgYCg8g9yTJEh880qdyErL5ZB2jO27VdVxGtRfXVGSRwkNpWtcL8Z0EOMGsNr4v4BZYlo5Q13s
 /ess+Hd9B0pARvehGPf3TW9B+od/Xi1e8uxZ6XH9sApVtXDjbXaqLEODev+YExDE9YssV7ojoDz
 LcQigEOuUJVz6lVIUFhe3e7PiNIqycC75gmagjdnOB2f4SCAAnHNQNoziRgShj/ziIPVFMuzLWP
 IJrMPP5lIzUqUvgZkYiEl0ioL82S2cHL3a8Zj9LTIr12CNiVVfDgtxXEYBN2iIAUsfTwy5mce6E
 L+dMEeufnJRqNlLjwU2wCL6BNYx8w9cxQVjzmN3YoACdYVl5jBhRfq0akUhPuOHXAsPFROWiFY0
 lBm2QJIoPrcjC60LVhwus5TQJNVntL9PLL9n+hjt1Ms/DUJmDVh7zc8x7xvbnKvFJGBi8vaCJQQ
 iHjE/dSSRS2mA/eemmw==
X-Proofpoint-ORIG-GUID: YlxdP0eN3fV6ilSTQ_N7m_wDY6xKRWv4
X-Authority-Analysis: v=2.4 cv=DJOCIiNb c=1 sm=1 tr=0 ts=6992f33f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=2bK3ageBGbJzC1C7j9YA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: YlxdP0eN3fV6ilSTQ_N7m_wDY6xKRWv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3FA0A4373C
X-Spamd-Bar: ----
Message-ID-Hash: CH4HQPOBWSLWU4HNUS5YGZWXSPUM6SS2
X-Message-ID-Hash: CH4HQPOBWSLWU4HNUS5YGZWXSPUM6SS2
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CH4HQPOBWSLWU4HNUS5YGZWXSPUM6SS2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>



On 2/16/2026 10:48 AM, Kuldeep Singh wrote:
> 
> 
> On 2/13/2026 3:56 PM, Krzysztof Kozlowski wrote:
>> On 13/02/2026 11:24, Kuldeep Singh wrote:
>>>
>>>
>>> On 1/14/2026 1:49 PM, Harshal Dev via OP-TEE wrote:
>>>> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
>>>> Trusted Execution Environment (QTEE) through the SMCInvoke interface,
>>>> implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
>>>> on ARM64 CPUs and exposes secure services to Linux running in the Normal
>>>> World domain.
>>>>
>>>> This change enables the QCOMTEE driver as a module to support
>>>> communication with QTEE.
>>>>
>>>> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and
>>>> executing a Trusted Application via tests hosted at
>>>> github.com/qualcomm/minkipc.
>>>>
>>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>>
>>> Tested on rb3gen2 device and able to see driver load successfully.
>>
>> What exactly did you test? That a module can be built?
>>
>>>
>>> root@qcom-armv8a:~# lsmod | grep qcomtee
>>> qcomtee                32768  0
>>
>> Sorry, but that's basic of kbuild and module system.
> 
> Yes, did a basic testing only.
> 
>>
>>
>>> root@qcom-armv8a:~# rmmod qcomtee
>>> root@qcom-armv8a:~# insmod
>>
>> Not a defconfig testing.
>>
>>> /lib/modules/6.18.0-next-20251202-00002-ga8c3ce157925
>>> -dirty/kernel/drivers/tee/qcomtee/qcomtee.ko
>>> [  164.464598] qcomtee: QTEE version 5.2.0
>>> root@qcom-armv8a:~# ls /dev/tee0
>>> /dev/tee0
>>> root@qcom-armv8a:~#
>>>
>>> With that,
>>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>> Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>
>> You cannot test a defconfig.
> 
> Sure, we can drop tested-by tag.
> Maybe patch author once send next rev can just add Reviewed-by tag only.
> Hope this is fine.
> 

I am fine with us dropping this Tested-by tag. I thought it made sense to test that
the driver being built as a module is removed without encountering any issues.
I will not send another patch revision just to collect/drop tags.

Thanks,
Harshal
