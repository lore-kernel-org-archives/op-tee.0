Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DE6D1CDC6
	for <op-tee@archiver.kernel.org>; Tue,  9 Dec 2025 07:16:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D37224FFCE
	for <op-tee@archiver.kernel.org>; Tue,  9 Dec 2025 07:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765264576;
	bh=A04Dm35J/ouhM2AXSDKuw9rVITLOJ+KC4kTX3x/HT+o=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uHEp9OcDikkQYRUIw7r/VXNUtXf+NLDqAiInXIs5Hzj5cgqnmQ9UBf3+Qdr5YEtgo
	 zsZ37pE+4CVyWpEFSWXdrx1xuP25YhFE1M/mvdWhsZAc0g3OzZy/AZAHxarZyY+J5p
	 6e/liEhRzoq7zIHhWwfnNH2r4RIYwowBkR0axp+yGrHJmiaOkZvuDJF1+/vBx2ByyP
	 KpH8r5SbUJ2gvLq3ANAenGxqDat5U+2gt+gm1GOMbo1O1gMnHaSaZXDR6yVs2tIG1h
	 OxKJ4t/TEiAx3TA3s6jr7WPVtmDvvXaNiZVpGbAO5V5iD+gtqqKMjSFdqdTBgzNTkz
	 xl5nJ5NJChOtg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CD0D7431F7
	for <op-tee@lists.trustedfirmware.org>; Tue,  9 Dec 2025 07:16:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T+KyObhY;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qf+zyNZm;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8NXBQ21853424
	for <op-tee@lists.trustedfirmware.org>; Tue, 9 Dec 2025 07:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HdlTxruG2Q6LDeIGyDnAam6bU5rPAiaw06GvZMnJqkg=; b=T+KyObhYauaJR031
	O5w8H9hZ5xhGOC07O3pN3NIyKQQJj05vFkKOXGm4L8xUg1wavGnkesgMsbMnExyv
	WhqmgwOXHebs/SbIGOfo0u+7bO4BlqSBtwBxCC3mf7DWDHaRPEycLbaGg0d/2Dx6
	K9aJgLt3srE05o0uRBjC6siEMcYS+rbnerMrVUXJP5LuZpLbITY8EHsoJZ+3+Kho
	jkL4lnKu1972NMB3cKm6mSRmLPhtZwGPv/qCQeUnd5vHMbFyRP94EZqwxKVovuyQ
	Yanu8wbErdcUhI1sRkM1jxS5JXH9ynkSKarQ3R9nDZx2zkF15fbhTiXYQRDOSswy
	cb3Fcw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ax63v9er8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 09 Dec 2025 07:16:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3438b1220bcso5986764a91.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 23:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765264564; x=1765869364; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdlTxruG2Q6LDeIGyDnAam6bU5rPAiaw06GvZMnJqkg=;
        b=Qf+zyNZmw4N/Pdgy5j+VUj/bJPgDKMFEyW3gcDocyCyxWjZlpnwTfnqfD7HTQKwkGv
         ogSrrLOBnfZBdf741kM3E+K4XkiKf/Gw9q9QLrmP5ExZdHdPOvX3MEff12QaF1l78fHR
         xgOVqhENHaF5Z0Jt7h1mZd8zPkuuWUzvYzyp+ufZH26h9bAOmK7BqvhGIi91V9oeUfLN
         tmkgMEln9o9b51EQFsQkf15HsyRXHL569Si3dzMPgAVMF9RhBG8sT0tHsnz6+eDUF/zI
         8ZaTcVyiqQgxXw/0JwX4Eh2yb0QB3Ecw2YAml07C6tCmkNl6/1aLIFXCAFohn9clX703
         /EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765264564; x=1765869364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdlTxruG2Q6LDeIGyDnAam6bU5rPAiaw06GvZMnJqkg=;
        b=eS7o85Uo49Yzu43sO+JtWojb94445NV+asuNUmyfmvLyaacJjZWsXba0QqwZyrGHwc
         JJqIIqYuyHxfQWhQPgdw59DMzdYui0lsQSBq5LPxMLmzWJC5DcAsnXl6lehVX7IW2k9W
         VYC3Yk/YsvEgScNkAJezA3HL8AIrfKi8pGuq8xCxJ0hscQ5ZfcLYEMxcqKP+q1hXQfF3
         yPsVovaYLfDXBuKiX1UFDIvtHZ/mgzYw8NRE5cT8O9OBa+t7G+PAc30O+QTQl/JW9WMV
         hrLwyVoMTQd5QP1ohhOfdZQoioXAXKRagMnsyBy/vQ73fpmm/wV6iLIg95yP+FSy9K4x
         9Ahg==
X-Forwarded-Encrypted: i=1; AJvYcCWT6sqI16W6dvqOQ14YJm4PBniObyszT/m4pTi/XwVRm5Y6ZSM5xCspkG5+/xvuN3uOZiUocAE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx3xtjJQDpBUiwsepWaFFtunmPjqcvIIyfzUYBuIkITbqKJ+/QY
	KHN/CQUlKHFAMY7YWdjS3qhwG5GmLSZ2WnI+gS5j0Bfdc/Cmz5lnAVUsTlFYgGcpsuecid5SpUU
	YGbtrZb70QOABp2ZLFp9c9ndmWsYDiC6jwXx1+/86Q2HyJutJTrzDNd9ivsCdROJ75y6tB5rI
X-Gm-Gg: ASbGncs+MQ6aU3/z1WN/UzRPisyRLKT6DFozEjqycoHxp9seOhFnEjDPI6SjFhQqttI
	1s4NrRdui58ISJC+wesaf2Ygcx8imlxnUYo6pufCH0DL56RnssHQGIuIxVoX+cPReLi+Mu6qOup
	vU47Zv89t5HYTkoaPMLVcmCFpNFridaXORwbG+VBgvWdS0RhSXAeFkBlqeMtMTkVhleFLnpHrrO
	6m9jSnoSQx2baDuuzysuyZTLS55GFVgX+f2PpVzG7MwrPaKidJZ3o52ODpkTQF/pAJLVc+4Jhbd
	wymPXk3m61TRZMkULVrDACNQZyOw0uQ0NYlOl9ajKpDUcTTzaox0xc76vKUZPEeAWHlO7m4Gevr
	uBBmjTYZ+FDPj1Byjv3ORnE0a1MINDRrjom2A+Nw=
X-Received: by 2002:a17:90b:3890:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-349a26c2b62mr8411595a91.33.1765264563887;
        Mon, 08 Dec 2025 23:16:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyyMSpe1TQwbuvCZyk33iCTZfUm4J3QsMv/s/MILikc25JKzJVEmO27UhgfGE0pXu+KS1TBw==
X-Received: by 2002:a17:90b:3890:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-349a26c2b62mr8411571a91.33.1765264563392;
        Mon, 08 Dec 2025 23:16:03 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a49b2a2f5sm1317014a91.8.2025.12.08.23.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 23:16:02 -0800 (PST)
Message-ID: <948b35bc-8479-4d94-a5f7-e8893de8fbf1@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 12:45:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
Content-Language: en-US
In-Reply-To: <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKarWeZb c=1 sm=1 tr=0 ts=6937ccb4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=H55rNi7blMSzm76TLE4A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: zEZeqpUhhCFEGEYLcS749iHNMffRh_G2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA1MyBTYWx0ZWRfX24JPbRneBqG6
 Y3X0MqghbcabJwW5bJjpcCJZFOiiPIjRWaQuQlknaRG6XemzAv6p4rWzdUEN/MhiKe/0aG9Kuam
 cB99vaeMZ57gclAzLi3ByQ1iRvT3jQgOKP97TaBXInQOPG0X87hXiS/dWkJ1SODueRdpJyfjysF
 pz3aXANBlVc+xENl3ndYmpcFgGJx4NLTrvYGaBIYBXZuuvariY/eV6DNLww/7pmbTmh93F20kph
 gC1T0Sj50NYAM5aEGwYsVnxxcw6jIF+P7TvzaCSvNP4wP2F7JBFG5f7NrwePqf0zc7ZNDnRl/KX
 Q8QfSZoDDBvYnccxhxH3qJYGFv3NsmfIrOImUzxQFSv4jj+uNYQPwkXLxFjubiy9nrYxBAa257N
 t2WsF9Ac/jCc84Oo5JVx9YgXXw+FGw==
X-Proofpoint-GUID: zEZeqpUhhCFEGEYLcS749iHNMffRh_G2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090053
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CD0D7431F7
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: ZSINCGVPACWYFUMTMVEXM3WAENO422UH
X-Message-ID-Hash: ZSINCGVPACWYFUMTMVEXM3WAENO422UH
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZSINCGVPACWYFUMTMVEXM3WAENO422UH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Krzysztof,

On 12/9/2025 11:28 AM, Krzysztof Kozlowski wrote:
> On 08/12/2025 13:18, Harshal Dev wrote:
>> Enable QCOMTEE driver on Qualcomm SM8650+ SoCs to facilitate communication
>> with the Qualcomm Trusted Execution Environment (QTEE).
>> (No enablement required in DTS files since QCOMTEE device is dynamically
>> registered by the QCOM_SCM firmware driver)
>>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - Updated the commit message to reflect the supported Qualcomm platforms.
>> - Link to v2: https://lore.kernel.org/r/20251205-qcom_qcomtee_defconfig-v2-1-c92560b0346e@qti.qualcomm.com
>>
> 
> I gave you the exact example to follow. Maybe it is not that important
> for others, so I will not object, but OTOH it is important for me, thus
> I will not give reviewed by. I damn asked VERY CLEARLY:
> 
> "Just mention which UPSTREAM boards (which you called Qualcomm
> platforms) use this driver."
> 

I did highlight my reasons for wondering if a board needs to be mentioned, perhaps I should
take some more time before sending the next patch to ensure we've actually concluded the
discussion on the last one:

"since the driver is related to SoC firmware and
not on the board, I will mention SM8650+ as the supported SoCs since we began enabling
the driver from that chip on-wards. I hope this reasoning is fine."

> Usage of something on SoC is not a proof that it actually is used by
> upstream platforms and we absolutely do not care at all about downstream
> users. I spent way too much time on this and even very specific
> instructions were not working, so I don't know how else I can help.
> 

I understand the frustration. Let's take a breather, I will reflect and take a week off
before I try again or ask someone else to.

Thanks,
Harshal

> Best regards,
> Krzysztof

