Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BB4EDF148
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 10:57:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C7AED4374D
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770980228;
	bh=Aw8E39mtCHRNjN5qaMEUVcqXCOU0w1dL4yvuWv18EHM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JgvX9Fiw8hiyncSdW9sXsH+suhw6izYerA/W/n12qmlTW0TQ0fD6ijE4VaUgnV/y9
	 Q5kcXPgy67Dvif8kQRHZsKbRprKF7+Tgeqn1sff8gCrsA21PC+RWVzEuWMu+F/gtMa
	 ac3+F23Fw92N42Mwc1K1U4W3Va0v/1U+x6UD/DFJou06kxmd8Vj20CuvePpJ/KX7uq
	 wfWJr+/Ygh6Y2AiOFEPGrO2mo6y1Wl6XAFow4EHvPhOsBY7Ax3MzgPxhd0nc9gkxtm
	 wn492m+XvcN1gZJoxnhGwpLmQtwGgswD15XaDqiCnf10XQB3An2+580YzeAm1aDFSu
	 8pwlQ/f1JokJQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D0895436ED
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 10:56:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BkMrh4Qz;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C1VsqZ6s;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D7E4jL3043738
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 10:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GiyB6807wBrlpme0SqbesGsmjlyBbej8e4mtB4Wk21k=; b=BkMrh4QzM+3T3Y4s
	oGf7HFnMSQ3lhSyedS41Ay/zqwXvLE0nvm0ca5X5bwbTZrbExubRABxRhOaF5658
	3g85N1jZqep3PW/AcyhHf8MqmPBmwB6CW/UiS/som1SK2fJBytUTKOjqIZElfC9i
	ODc/x9WRO8HKjcj40C4eBO47Qa30TDk2Od/ZS0EXAclaGKf4g1dlv9wJn4azwDrh
	6R9MrE4RkJpCdeU7F2UaPOD252LZygx5i4ZSykjQAx7Mum/RjYbkLH9/VowWmlvM
	Qmyk3sQsoAfY/DIHjhRxwzAQQ/YVspYbrdbi0XNQJmve8GnZdXlaZl4NWSiju4GO
	+6JzKQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ps2tj0k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 10:56:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a7d7b87977so12488565ad.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 02:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770980208; x=1771585008; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GiyB6807wBrlpme0SqbesGsmjlyBbej8e4mtB4Wk21k=;
        b=C1VsqZ6sY8V/gpRKAz3q+tnSUKr6+zVQdtIMGXqxg3OZ7t5+mX2w1GtBHjgviFidhb
         k3APK4m/UmJ4/iM9elccvrQhpZCh4cX0LtIiYdvqomvM+OXxD5C/rYHCpeRsa0Ob2rnX
         3St2lreuBOF2t0I99O3FxxoGvanXk1V6va9+YE+6+ObhkKu8ZHQVcY0bt/I8jHW/cTO9
         b6mMQPIV/2xNwN5BaxMgRA8rQfJZcW5RENBvmRUhYyJ1+HIq0N3uoZfim2fWMwX+J1RZ
         3jQauW/eyIGyAj9Ojb7ft+6z9KETXQ0S4NfA+AKS7nKf8ai9tw/I8Kev8q2OcS07ath6
         nDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980208; x=1771585008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiyB6807wBrlpme0SqbesGsmjlyBbej8e4mtB4Wk21k=;
        b=c4qigBbvMeXKWozt2iKbwURuCAxs6RBgIXfKNXwfmkB++EOxr+LFeC3Ke2oS3GiyIg
         eaqk6R+OZzOoBmk/i/luJDYkrKxUJK1HjWIcIJS1RLXfso+7NFaTMcoRs50m4n94PRm8
         gk6/UfppvydacLlQRBi9/q2ffT1bzCFu3dEoTwmnTk/G0v779ZDWMQFS+4E346dWjYWe
         BzG3Fto8LnyaL0lki5NvqXO6T+UgUaROljypJeDLsZmt6+uJn8NOmp8foS840c+J+Zse
         ksHQhYA2R7UqtL2d9saEFd4YWhV2lbhw6p8S6PTzjSFwBbTW9TrzPKk47DvB5NNQFPUT
         Af1w==
X-Forwarded-Encrypted: i=1; AJvYcCVcljo55v2boktWatu2reXL+D/EyjEoMGeDD5/lDYFMetwKGhL+gKxocfiWGyK7cOYzT1eA14c=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyYhcSl+ohDVKFwKKI3bBQrClJSzBWwc6CIrdRwaWkOuEYPLj90
	SpObwHwSko349ODUmTZFTMlvt5IPL5FSqSryITG9C5FeNE3R5r2YZJhRKPAVouUjnAg91P0BRIK
	d81FdhuXHlDtgRKrsM5naNQmlZRTFr00kEVBa1p57jhEI7emkGekTOH4DFVt4EQFhKfzZ5kno
X-Gm-Gg: AZuq6aJ6hHTNfwcLt58BJPIBlZifmLocW9v4VpV756rRAiTC2FToquAKILcl88391X2
	EJmJXLP4TcNtwY8af100VmsGdli+rHsr2RcU7zrnX6Aa/w42HwLzCTe4btTE7nls3mM9+UZGTGa
	/Y+ShiTu7KMGqv82h22EC9NMbn0m1vdzYUZJ0wGFH6g+g4ChtmoPP/I7S9DBXOOitNeLPcXz5da
	PLdn1DhyNvAB82etv7sd7fxYyByMxWvr0XmxxYXWJ3QpqoJOi5Dnj+pBFf4yxpH/KumVRt2FSaT
	KyxuVqJrYPGJrIVq0Mw5Qfi2Wj6cn8kyLcQscO4+LRbBmxWoZr82Sb9UH8/R2xr7oGglfH0l9Lz
	gOLfkJ/RZzKc/4VYcDlUPx1yIcTqXLTjc5vXqQxWByU7lhnaD+gs=
X-Received: by 2002:a17:903:298d:b0:2aa:d333:ce84 with SMTP id d9443c01a7336-2ab5051a197mr15933065ad.11.1770980207975;
        Fri, 13 Feb 2026 02:56:47 -0800 (PST)
X-Received: by 2002:a17:903:298d:b0:2aa:d333:ce84 with SMTP id d9443c01a7336-2ab5051a197mr15932795ad.11.1770980207488;
        Fri, 13 Feb 2026 02:56:47 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29966633sm77807725ad.58.2026.02.13.02.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 02:56:47 -0800 (PST)
Message-ID: <12582709-7dca-4f1a-99ab-8a21cd70f1c5@oss.qualcomm.com>
Date: Fri, 13 Feb 2026 16:26:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for
 QTEE-enabled Qualcomm SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
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
X-Proofpoint-ORIG-GUID: wQ_LFlDPbo44O4EEBuOrZZYpa--d0m43
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4MyBTYWx0ZWRfX2u5vnEAtYI82
 w4eT7sHHvPkUNvmO0nv0golnXIZxyz79r+/mD6T4rGXEpKCZCcphy/P2Xcq90344FODtgSjdg5v
 nNBV7SxxAzMJo781gyaWTNLbeMnci8pYtfEatew7CyGXHoeuYau038emcSliVuxxNsK9KADygX7
 qUNeatO496omXFUY9zKXnBdrVHlCUgEWTC1Sk7MknAqYE3JCoLTF6W9udq2F6n5y6vvVy2r5wc7
 ulC0drhD5DwTTHZcxyOSaGnJZPxqDfPTt8FJmTABwTdyw4NGIeeFGoN4wmnrgLcndyfGj/qDCee
 2tmMmeTjPgkYVF5/tCMeWrR/k6mSxLzFrcADmRrLW+uIr4+fQlAFQHUUJ/ThqS3pusZ2kJVvRwC
 lJJfYc4QQKRl6IFm2MtP0YxnSCPel917pmCQmNeyHVkLmALMoPFqOEs7YzOGlwK74O1DLgBCa3N
 6amNkHlI5LK833AgUlg==
X-Authority-Analysis: v=2.4 cv=LoOfC3dc c=1 sm=1 tr=0 ts=698f0370 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=8PXTMM9NJao95hONEFkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: wQ_LFlDPbo44O4EEBuOrZZYpa--d0m43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130083
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.199:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D0895436ED
X-Spamd-Bar: ----
Message-ID-Hash: PR2VVCDULWFALCBU7QVEST637KUA6DXW
X-Message-ID-Hash: PR2VVCDULWFALCBU7QVEST637KUA6DXW
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PR2VVCDULWFALCBU7QVEST637KUA6DXW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Krzysztof,

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

I think these logs didn't convey the full picture. QCOMTEE driver holds
references to objects and callback requests received from QTEE during invocations.

Being able to remove the driver without the the user thread being stuck helps
test that the close_context() callback which calls into QTEE to release all pending
objects and callback requests held in qcomtee_context_data is correctly implemented
by the driver.
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/tee/qcomtee/call.c#L600

Before this patch, I believe the driver was being compiled with CONFIG_QCOMTEE=y
so the qcomtee_remove() function path wasn't being exercised.

Perhaps we can provide more logs (rmmod attempted after running direct invocation
tests) to convey that this is what we are testing here on the RB3Gen2 board.

Thanks,
Harshal

> 
> 
> 
> Best regards,
> Krzysztof

