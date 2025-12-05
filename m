Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E9FD2E01F
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 07:38:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 84C2150074
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 07:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1764920338;
	bh=3nMk2A2zV3j5FIRKjzYHK3Za+QJ+Ib8dqD66eEE+wNE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=K8+IS3Y7uw74dO8jFTwZmmEwCWDw64Eg0mMw78xb/uKrudSPZ8YblRMC0HIk8uLUP
	 RNyF4t4H1QDp2+ke/psWeaBPmQIFmvNSF4byWGnLwab08dXBePjR+Rjrix/xqC9snw
	 iZ35m4jkL8/I5DqvfV1cXsjIPQ68KmrbQdhnsh281usXTrSDDx+/hCz0TBxhRFQ0Z/
	 5Y+CSxZTGMwqWZci43zfNIkcWWlXfyuYUOO0xpX4ULAQ6Jo8LPGMFPxrvcDUQM1eyl
	 evI0K+sJ158DFAO/uS76QBuh52/Dyz9oUnZgHwy81+SqhocLq8ATFrppsTi34b97MB
	 EeMH/p+Z1hLbQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BA50643075
	for <op-tee@lists.trustedfirmware.org>; Fri,  5 Dec 2025 07:38:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bh1WuXjP;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ObEEiIJe;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B525fxw3135920
	for <op-tee@lists.trustedfirmware.org>; Fri, 5 Dec 2025 07:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	THz5h+lWmvnvgTVCzsMhpf787HU9em/E4zlJ3KSL6M0=; b=Bh1WuXjPnqSG+hYe
	3RFI/fRVCY7ktTHdXkeholYg7x9m5hp6MxjIYsPVg3mSO19PX9U1FAgBG/dFMTcI
	q4sRZIcBJRMvLBTD/4Vo7ixTYuNYHGOg/hecKtjObrhyr75v8l3Bm2ueN3iHffpJ
	8wMDxLFQGB6k6Hmf/L4vmNc3Hg6/wy3DoHHZCGGK6cvOmtxRzZAmENBHPzH24jKG
	6dXsQA7Ih7WBHXXkqkyNBkjWCIcIkO9l6UbxiCIXbBRouGGz29X7mWuKoaB2ZZ2p
	ZID5xiXI7HxgpC4/wBCEhcj16Krkf16PwlSZBM7zt06UftL0BS3DlR6rHvGMwiOo
	5yY8sw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aupa8rrd7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 07:38:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2954d676f9dso15079445ad.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 04 Dec 2025 23:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764920326; x=1765525126; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THz5h+lWmvnvgTVCzsMhpf787HU9em/E4zlJ3KSL6M0=;
        b=ObEEiIJeFDiJFugAJTKLhHUipa76QnlXS2MqBc902/dYX6n87jnwKLMLhRr4WmFmKJ
         ijB4XA8/+ZgyToD9XWpa/tma1SWSh5bHT35AEcQGoyNBadr0gDzLT5RlznFZNWeCvBsP
         eUjssrzM+ZcmcISXSjUBgCRXgOFDPdVOTjZLR4gdvfBwpFFqqSzqWACvKfY3rxRwgpr2
         K/WqJwoOQHIdy1KP7DmVFin6ebv71BnY9Z2w9msSvueGcSNz2qX0jgiNVsxXdPNAx+XQ
         XRAjN6qVVcMg4Zwlcjbj81kkU9pxz3FgytLrHvBUCj0SsjATYB3rJ/7sA5Al9oY0dKAt
         RKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764920326; x=1765525126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THz5h+lWmvnvgTVCzsMhpf787HU9em/E4zlJ3KSL6M0=;
        b=GYjleogOeRTt8L9EvK/iW9toWBjf5qsIHVPsDUFCMkHZUp8lzoDlQ8696FdfGngWZA
         vcZsMWAGlFI+Wek0Bqp1gUjtWqTJraicQmmlKNFeDUAE4U4V74GydkJ8hzltseRLI6Qi
         vG3dLoTXcC+rdshArnkF93oiZIwD1cN2QskND4m7mIp6EoXGUP5wtWsMWgxZqJlBTqKB
         Cn7Oc6RwYvi27eNVkmfhGxwNzFLp1MLudsHtaOow7JWcaJnbaIYmb3XZqXxBYjQYrrkk
         XVq4sLmDJ7Z5h2UCpXydx4S0+6aYttQqBY5Btm2myFGeeTTvtost14kCC8DaD6lHwZIJ
         Nhaw==
X-Forwarded-Encrypted: i=1; AJvYcCV5a2WCkuGiEbmVtAxTK5Ccd2fdqgKN7Rxc6zTwfwRC+lsndpcDsP9ecgveeTo3N7IkjQr9tzg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx5wJ4u7L6x5oRYOfLmpv5720cxMF5NBUGnteYgmU4Oe3/t/4ZP
	R8KYaXIYUAUuk9gsUzQX7L8xQ5c2Tb8A7dleBWTe+omOdb9zGt0jeRaqZM/JAPVtNzsVWVC3mrR
	iyFQPjDj634hgI/i4LmWZIc491incDHpRgn0dZRwbNvHkoqzs8qVvVcG3cZ2JpklfW30xzR2/
X-Gm-Gg: ASbGncvZ6xOU+Dluo3DFCGfUs76p+XW1nNnqK/+eILxZ/UZGF0vLQLuG53wg9zK894G
	5rLnrsIFmMqDzOelseNVHw1Fv61uYE4DCof74Cv10Fc0SPVYzI6KWt3q4w9VGWBXaji/D/J1DXD
	Mun4wz3DO+FQvfPP6xJpjS3r/K/aaWq1YlHMWariGLAmGp2fTyCvb1Svs0UmL+XeT2LZ7uUvv6x
	LQsxKI4MIhe6hiLWumgyso/A/U1nmRzbB82zoXGqQJnq1seMW4jZeEr5nCBJ3tXTRb9x/1GeRX6
	XryRpbxgmvVHEGdBF7gT32UFaWVbas+0Xl4Dxc/kWumgq8MAjceRVZB6kL6ZeUAYrGrl7aJrMa3
	Ckhbdeevk9dCMfPepzCxF8ChNuOObgdqv+5yE87QO
X-Received: by 2002:a17:903:228c:b0:295:24ab:fb06 with SMTP id d9443c01a7336-29d9fb7005dmr58776805ad.22.1764920326216;
        Thu, 04 Dec 2025 23:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ3tIlU5KLqQV1Rz/1j3r8zaooqfJ3BnbAql+Z4rhQK8yZI7K1DEF1OR5wOv3fuvp3XK3rKg==
X-Received: by 2002:a17:903:228c:b0:295:24ab:fb06 with SMTP id d9443c01a7336-29d9fb7005dmr58776545ad.22.1764920325673;
        Thu, 04 Dec 2025 23:38:45 -0800 (PST)
Received: from [192.168.29.116] ([49.37.148.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49cbdfsm39668865ad.1.2025.12.04.23.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 23:38:45 -0800 (PST)
Message-ID: <f20833a4-1571-41f8-875a-d27086be3090@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 13:08:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable QCOMTEE for Qualcomm SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20251202-qcom_qcomtee_defconfig-v1-1-11bfe40a8ea4@oss.qualcomm.com>
 <ba60f51f-7676-402d-b602-c327d7496f34@kernel.org>
Content-Language: en-US
In-Reply-To: <ba60f51f-7676-402d-b602-c327d7496f34@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZqDg6t7G c=1 sm=1 tr=0 ts=69328c07 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=v+kbWGyw1T97G6+vs1uYIQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=67QYI0K2Moa7ayTaINoA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA1MiBTYWx0ZWRfX8FIokrnTCiBZ
 5pMgOhIEby0/zLZOJVNBCtF9pEZeuzbBl62dQVksYRjuuohsUi5MYFa7EMJeXfCEXHrSJBxejuw
 IYydw3NIOSJeMjiWfFkGVW4vPN818ggCBKITND3FpALeBsHKz2NAyvxyTUNvtEKM8nLp0c1lXiW
 4XRIPBZCvszEGeJTuzd5iLcf1cqc2ATb7RDhiybuoPawfKaF/Bv8ccb6GxFULoEKZ2KpkHCbgL6
 1DVX0vqcB+2wDI8wSeEOpptR0TO0YEuItDP88vf6i6Bjnf4vcJ6A4nMmmppuCNjBMOuyP0db6XG
 pkj3nFbrq5aTRWZ5wDsIHYjirw4j/aTLftWVbJLBEaaoflc25vaSnv/Ulkb7WtPrHT+uYM+cmxY
 HuMQOfBR4JP4RMS+pLnTeomwH57rwg==
X-Proofpoint-ORIG-GUID: 3nG53kc_GNrO3hPXLGEZo3y60r9CcrIa
X-Proofpoint-GUID: 3nG53kc_GNrO3hPXLGEZo3y60r9CcrIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050052
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BA50643075
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	DNSWL_BLOCKED(0.00)[209.85.214.199:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: B73L2JIVZX2BVYRD34LOBABISRJHFQ3S
X-Message-ID-Hash: B73L2JIVZX2BVYRD34LOBABISRJHFQ3S
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B73L2JIVZX2BVYRD34LOBABISRJHFQ3S/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Krzysztof,

On 12/2/2025 3:13 PM, Krzysztof Kozlowski wrote:
> On 02/12/2025 10:37, Harshal Dev wrote:
>> Enable config for the QCOMTEE driver to facilitate communication with the
>> Qualcomm Trusted Execution Environment (QTEE) on Qualcomm platforms.
> 
> Which platforms use it?

The Qualcomm Trusted Execution Environment (QTEE) firmware is available on all
Qualcomm platforms. However, certain platforms like db410c (APQ8016), where QTEE
does not support Object-IPC (the communication protocol implemented by QCOMTEE driver)
a graceful -EIO is returned by qcom_scm_qtee_init() which is in-charge of dynamically
registering the QCOMTEE driver as a platform driver during qcom_scm_probe().
More details available here: https://lore.kernel.org/op-tee/20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com/T/#m1eba97cb921c958034ffe7e2bfb776177ba48eb6

And so, the QCOMTEE driver can be safely enabled on all Qualcomm platforms regardless
of QTEE firmware version.

> Why this cannot be a module?

Upon a bit of reflection, I have realized that it is completely fine to have this driver
built as an in-tree module. I have also validated that this presents no issues during
loading/unloading of the driver.

I will send a new patch and update the CONFIG_QCOMTEE flag to m.

Regards,
Harshal

>
>>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
> Best regards,
> Krzysztof

