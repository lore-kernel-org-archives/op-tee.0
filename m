Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAA3D1CDC6
	for <op-tee@archiver.kernel.org>; Sun,  7 Dec 2025 07:50:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 040CE50098
	for <op-tee@archiver.kernel.org>; Sun,  7 Dec 2025 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765093852;
	bh=lR2XHjP45Tsp5fd5+x/EEratk7N46D2fz/PM0w7A9N8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=flDUB00743A0Dlx1VdxB/9ODIgibSNVOJuVjvV8HadV8ZrAwvp+VbBNqcyh55GOCA
	 jCCPp0ZNLYRl0ugtqmh0sknWVDmlQE+pYLVZbj+ZT1kt0TUD4Kk0F/ZAL7bfkJDtb2
	 B4NM7Zg+tukOOpkTRYOeZFVyZEksAcUbZrfxp49bmpNwtYZb95HCuUjwV0PMxoR1Oe
	 /BdfgEF+ClsWu5Tttyc6zJv8Y7Z/bfxdsBc3XCN0ztlPQudqOYResFKmQ9ZzcD8953
	 IV+a8kX9gD+dc5jpAQSBf8tWHeKJUI3bg+umf8rThch8gLkslsWS2nQFm9/BwEE3yC
	 i/TOOYQrcBqwg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9AC7242EF6
	for <op-tee@lists.trustedfirmware.org>; Sun,  7 Dec 2025 07:50:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LUQaYoID;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bm8P4GeW;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B76hthp1585307
	for <op-tee@lists.trustedfirmware.org>; Sun, 7 Dec 2025 07:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MzttGYYaYezC63L6aU8F+tDRvyhNUIysIPNry4BSqlE=; b=LUQaYoIDsr/u7+Cx
	48rWOTdMPUvyZu4KfWkF0YJ03flF89+spC97rOrvUytJIBV/YOYBX1lTCCzxpxi6
	NQbl0sEJYOVxpFppZtCXGIaFvR+J6qDDvl6OAjlsn8lt8Ep3OdfzFGXqSk8fysQ8
	Ai2/35FZ5sMuP97WXFhJ4EPR98eHyyAJwl6bllvzhP8+HjI48qcP5e0iGkJWlc4I
	GxMkK7K20uve0gVv5kgADWN0phx2TdHdydJzDefW1G55AlFsv94FBV2dWeOgyQSm
	6/puZNFhu1p34DUNAyqvTurKccWbrybOg1m9LzxiH1KpooB3SsmocYj0VhZ5UvZ5
	ISGvrA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avcjva4e9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sun, 07 Dec 2025 07:50:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b952a966d7so6738271b3a.3
        for <op-tee@lists.trustedfirmware.org>; Sat, 06 Dec 2025 23:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765093839; x=1765698639; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzttGYYaYezC63L6aU8F+tDRvyhNUIysIPNry4BSqlE=;
        b=bm8P4GeWUrNQx3rdD9dWfTESlKgWHo4s3eRt+4vQ9PEbWoIR1lCIWX/mOq0Kjo2pQ9
         QvjhAIHCEMGupS+FiKUmGpKT3OMXozQPWA6AQgbzTx7/yEZaT2NkjrYybE2SPeq9hKDD
         KXUkpnuSRSHhQgZZrBuyOrDZyZym/q8F3qwomaX3W6HaM1pj2ITWtoQugZe+ZvJfrpcl
         7+8II9Y2A4DKAaybNbypLyWhTdhpE/69H/EoOUw7P7yIgUQXfTYNGpkBgg5bywdZsIs+
         U40fP6IOQXhN0Hto2gOItfVurX58mRJrhmGS0zEt9yBVijJ74KI/oqyiyoMO20f5zWrA
         otzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765093839; x=1765698639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzttGYYaYezC63L6aU8F+tDRvyhNUIysIPNry4BSqlE=;
        b=u4fhGLUkpcAANDv9KbH5wFK/LnsYJzS3G+KaipRJoxywhQbnbYrsZ9wTqaEZZM9RlY
         Fzv3b23L+NGBkwV3BkrT0awGpGQyRAOwU1Xe47AiZHjPKg/mq/dnd/5RUGmmvX+nkkcr
         saQiHdp5Xd+cLPsHTIjg2KRLU+DcDk1JD5qpBOOWELcRP5MpG7+cQBeyox9n6+iYXmS/
         J9N6iKn0gDzoZZ1anO1FDHGKjk3STO9Kxh/tyJTHRWr6lpG57NV2BdKinVL0uNRJrTP0
         zUwgeUUOqINixLI1FvmCGHB/ndnYLXXgEQlkJzdGYDzPmbrkUWQMpdcrfDOrEEim7pK2
         QF9w==
X-Forwarded-Encrypted: i=1; AJvYcCVX/FybdMW+/Rd5b9DTpY1QTTTkFCO05fyUzm2NDcIxty2p2V5OplTYKcdxtcbW7+ZrQWhVWA8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzoS66fDxiX5HebveyGru9tctMX9rZJuEUM1TnaViQnJ/GgAOKJ
	jHo7IY5sKyCSK/8JD8Or7QMgF96u6yqxHsaOO2+siCxTF47+lgdqjNYdFtvxlx8jNTXuf5HDv8i
	hzzcj3yYu3XE8GzC2xLZkIkDMjXHfOIb8eaFYnQt8KMvvE2pH29qQi5FXn879V5+vmg3rsa+s
X-Gm-Gg: ASbGncvGIW1LkHhChogv0+59ptzvFpylQnjYpIk8vks5J7z3lTjmKuOBC1qMEOiyeHc
	XbeJdfQBLw2soC+mwWb8p8EeOA+O4yH9y39/tP0dJ1UtehYjXYj23wLu/zTWtDXK6thcgpqUB21
	zw0fK5sCInIB5oN5s6W7AtjFE/dQsfQoxSx9X6dhdy7bxKggeNdiSe4oXbFLL9pbZKND0RlBlFJ
	0/LJ2TbBQXe+dYgESprzpALVAPGaQX0D8wQF9Io7LKGfjADXRxcj/AjijkcrLP12YWrzHfr5iQ9
	ZyNOaZcfthYQlxfSulKaZ0vF3Q8jJBhceVms8D9u6qlU9D7TaaYOLsWyBlNS00xotRUn7NafV9I
	3KU1VXjVkCRYX/HFRStPr6vfNFIguojk+eufH6wfY
X-Received: by 2002:a05:6a00:2e13:b0:7aa:a2a8:980f with SMTP id d2e1a72fcca58-7e8c109c67cmr4252493b3a.20.1765093839420;
        Sat, 06 Dec 2025 23:50:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmq5igauuj4gfG0V+L29Alx/C+aLgg5lZwDZY7VdpjpIMy2DUHIEo9/7YEYuxflwHiHG8HJQ==
X-Received: by 2002:a05:6a00:2e13:b0:7aa:a2a8:980f with SMTP id d2e1a72fcca58-7e8c109c67cmr4252481b3a.20.1765093838903;
        Sat, 06 Dec 2025 23:50:38 -0800 (PST)
Received: from [192.168.29.116] ([49.37.148.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29fb94c05sm9714446b3a.16.2025.12.06.23.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 23:50:38 -0800 (PST)
Message-ID: <292a9bd4-1125-4bd8-912f-003df3e3d2e1@oss.qualcomm.com>
Date: Sun, 7 Dec 2025 13:20:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable QCOMTEE for Qualcomm SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20251205-qcom_qcomtee_defconfig-v2-1-c92560b0346e@qti.qualcomm.com>
 <7ffb61c8-465c-40f1-b794-4f573c8f96ec@kernel.org>
 <4d4a6614-9460-48b4-8e6a-77d3395abfbf@oss.qualcomm.com>
 <083ebd3c-6d19-44c4-9a46-f7fba01111bf@kernel.org>
Content-Language: en-US
In-Reply-To: <083ebd3c-6d19-44c4-9a46-f7fba01111bf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Dccaa/tW c=1 sm=1 tr=0 ts=693531d0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=v+kbWGyw1T97G6+vs1uYIQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=e7tGCk18dwv191QOjiwA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA3MDA2OSBTYWx0ZWRfX1zsjsO0pem1s
 f9qP3zPco0TXu0CYlE5M+BeLdE6Jfj3nljeX+huIB/ReqqIn6Syz0/PRZxPlbwK2d62yodT/hWQ
 9hbUY3v9Qon3r8jgDt+KZDjc6+MuHRT/kk9Qr2cpGRYD++FE5vw2XLlMDsN2LZ150h4W65Y+R7W
 npcTpy+sPV80FDdY2itMyzbCvHYCvPp2LL1lPRCeWM0W2zA5riMPSxS9yerQXDa4y4tXHavCDNK
 NPR/yZPes5yPQn5EsK8MWf+vlMlgccP6642d8oKT3Nj1Jn23b35Y10xXMhX6rM5747jjSGt0O/C
 9tWhAtHhLNnzGQw7VQCsntP6pNF5MLrq70fxJy6KJBjOrPQPoEzuj76SLC3BP12lVtBgv9QuVz5
 niKoZTlW0O4Cdpw46Esm0AQWmPXQnA==
X-Proofpoint-ORIG-GUID: j3A4uaTu8LAdY6gGtk1SA1M1hCFPyU-o
X-Proofpoint-GUID: j3A4uaTu8LAdY6gGtk1SA1M1hCFPyU-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512070069
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9AC7242EF6
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: DUBJ45VQITQDDS45RFTXUOGOIKSTKVAP
X-Message-ID-Hash: DUBJ45VQITQDDS45RFTXUOGOIKSTKVAP
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DUBJ45VQITQDDS45RFTXUOGOIKSTKVAP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Krzysztof,

On 12/5/2025 4:42 PM, Krzysztof Kozlowski wrote:
> On 05/12/2025 11:58, Harshal Dev wrote:
>> Hi Krzysztof
>>
>> On 12/5/2025 1:45 PM, Krzysztof Kozlowski wrote:
>>> On 05/12/2025 09:12, Harshal Dev wrote:
>>>> Enable config 'm' for the QCOMTEE driver to facilitate communication with
>>>> the Qualcomm Trusted Execution Environment (QTEE) on Qualcomm platforms.
>>>
>>> I can do it forever, but next time I will just NAK.
>>>
>>> Which platforms need this? Which platforms use this?
>>
>> Looks like I misunderstood your comment on the last patch regarding Qualcomm
>> platform support for this driver as more of a generic question instead of being
>> a hard request to update the commit message. 
>> https://lore.kernel.org/all/f20833a4-1571-41f8-875a-d27086be3090@oss.qualcomm.com/
>>
>> I will take care of this now, however I am still a bit confused regarding how many
>> platforms should I explicitly list out in the commit message. I took reference of
> 
> Just mention which UPSTREAM boards (which you called Qualcomm platforms)
> use this driver. It's enough to mention one, for justification of
> commit. You can mention two as well. Or three.
>

Thanks for this clarification Krzysztof, since the driver is related to SoC firmware and
not on the board, I will mention SM8650+ as the supported SoCs since we began enabling
the driver from that chip on-wards. I hope this reasoning is fine.

>> these below patches merged earlier in the defconfig for enabling the QCE crypto block driver,
>> Qualcomm Watchdog driver and Qualcomm RNG driver. And I did not see them listing out
>> any specific Qualcomm platforms which need/use these drivers. I understand that this is
>> because the drivers provide generic functionality applicable on all Qualcomm SoCs.
>> https://lore.kernel.org/all/20220921045602.1462007-5-bhupesh.sharma@linaro.org/
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f27dbbda5900c20e07418c6893ca6e95b634f4ff
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2774e558151a6e325e1f9f278722479601319f78
> 
> :) unfortunately all poor examples. And from 2019! You can find many
> poor examples in the kernel - in commit msgs or code. You can find many
> obsolete drivers written in old, not updated style. These are not
> examples to be based on.
> 
> Usually it is the best to take LATEST reviewed code, not something 6
> years old, so the process would be:
> 
> tig -- arch/arm64/configs/defconfig
> /Qualcomm
> (or whatever search query you want)
> Which would give you commit c5d02bbaa217b2454ba1ce7528113aa2ecf14f3c
> from June for example. It even caries two review tags.
>

I appreciate you taking the time to provide this advice. Acknowledged. :)

>>
>> Similarly, all Qualcomm SoCs have ARM TrustZone support with a QTEE firmware OS running.
>> The version of the firmware might differ, but it is always there, and so the QCOMTEE driver is
>> applicable to all Qualcomm SoCs just like the Watchdog or RNG driver.
> 
> You can say that all Qualcomm platforms use it... but I would challange
> it, because not all platforms use watchdog or RNG.
>

Sure, let's not do a 1-1 comparison between watchdog/RNG anc QCOMTEE.

Regards,
Harshal
 
> Best regards,
> Krzysztof

