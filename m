Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB52D2F7D1
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 10:59:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E83A750041
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 10:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1764932341;
	bh=pY6THgycL0eTn3YQcbOaAEiqGwgOxdn3wlc8Fhj2ZbA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=oK2ogUvmVaAO1GPnJAkpAVbu8ArFlXqbJUdMam/gwOe+wvZqwMaEy46ARlgGeQtqe
	 /t01E7ZVLXgF1Ua+fYh0wDPny2uvIlrq+ml9swr1VSKu3I02EvdX0IhOrIZsKUXbap
	 K51PQDtKB1fRlqkDoJ71W1294s5SzHopOd9jqoQDcMi4xTY58KX7U9KUomNDCsw3GR
	 bc2pmP8uoHL351K9sXmjp604CNbpzMBojYOor2IgMKCpynlw/Cr1VqWu1v0datRBxh
	 QKM7YpdjTkdK8Pbd2+QAZuN6IsXnyHhksw6Qausv9M3MK5tOWZF/FApsg4BA6k6kla
	 c9MA6el/XjSEQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BF12B43075
	for <op-tee@lists.trustedfirmware.org>; Fri,  5 Dec 2025 10:58:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=phECR+PX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UWO7RfZx;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5AjHY33194945
	for <op-tee@lists.trustedfirmware.org>; Fri, 5 Dec 2025 10:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S1SI4s4kqnl0k6qvZRRGMN/zOHoHkpu5Ta0sLRhAlmU=; b=phECR+PXeCTMC2HZ
	D0gq3hIq+2e/I+amKaoKid+7vZjb2Jl1BU6dIAmfmAY3AjzkJu7Y2fpWZSrRDZb5
	zib5EAD0562Nf6LML/usSI+D/0p5nWaMTtb4W76KU1/Puj99mt8gogJ099UzAYeD
	k2CjU2QZC1+FabR7xspG40RajYDyTcsviZUQqplI4eiXF4JufOG4JPDKqgVj5m8h
	NIm7bUE548p3/xbuBEhn295b0dK1+C0Ln8/cu0zojWkWk8YQLrQ/b01xOdMHD06i
	CGxWF+u7QnQw+AQWR1qhpUjScu8SJE5q2jeIrqQoNWa3pDnYOxLvqT9SZkccgxRa
	Qm06iA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aupe7saa3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 10:58:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29845b18d1aso34715045ad.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 02:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764932328; x=1765537128; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1SI4s4kqnl0k6qvZRRGMN/zOHoHkpu5Ta0sLRhAlmU=;
        b=UWO7RfZxVN0UJr2D4jp/liVc4gD43LTBwVYBmOvSFhd84/ZNRtDfvO3r3gP2yr719d
         Og4PpfnYI3pXl1RzefHV4rJTKoqxBrVsYyT3hQDuHbcpwg52SH/4b7s/ATNHQvXlbviX
         BFugYMfDRXPvCZcHrClY0+BaxQKPhCMtll4e7O1DsGE98aFbMNSqn1PRIWhX6vtzgjFi
         ujMWtyNBXG7gq8CNoFY53Y7353gjRmUyyFxKLkV0jOOO9VsOYPq9wNmlIzJyJyOCH/ZF
         1TFMV1A3VUwskwxpvC5YPRGmX+4z2kXQBeKP8gVkoJsB8MNbNoDSHoNxUeBTwLGkJ5Nr
         UIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764932328; x=1765537128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1SI4s4kqnl0k6qvZRRGMN/zOHoHkpu5Ta0sLRhAlmU=;
        b=Fzk5FWekr5LmZ9rC/Mna9ld8rmtaxRjIK8FWtID7hXE8jJAfuMFKnr+XBAKCGw36Ou
         7NnJmxq8CVrhEwa+/lho9IipO/+RXfRPDS8ndmPbBZ+eZLj8+ejnqHCFO0yI3b4pEvKY
         DnvBALe7E6y7E40924S9VCvJfIuip+56ISxuE2M0gM3943Um+fWdX1n1xR4K+D87GKso
         bu+sX9RE4BONt3pU0gjAuwxWvj+lyxk5qWserBu2CxZK+Q/nqro3catMsGFqUm7SRL+Q
         irWgPUPaIkc97hHIpdhpYqf5Trgu7FgK69Tka4bSVyqjm3MhogBGqTEyT++nU7qib07z
         WVRw==
X-Forwarded-Encrypted: i=1; AJvYcCW9aZtKkkjO409B1gC5E0zCPNCZaQAm8VGOjVizqBBbHs1QFu0gkO17Lue3Rb3J1Kp1SZUAfww=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YypWkD4KLHY3t1SJ9oEXVx1cJrnJVmg2cplf12SfSi1yCZtWUHv
	+0ZZ+lSf1Ne5Myww7vANw745xV+oqGolmWIJnGNId+W8ElzTPZ2XCr0KH0gJ6jY/b5yJ8OTKH0I
	/VpOnj0KDYNAFjQtDgqPSAiLuHtWHbi9J/g1vCwPNCO0430LXhtS9i9dU1HO1Z7FxjdpHzpMa
X-Gm-Gg: ASbGncuWYlPFH7kakwHGVN/GF5QwNcwUQ4ppVhhTSj1YEk3zLaJIxk70QNwhOgo72L+
	bSbV2ePRBxUJHBIVMjGyXcfU/EJ51XEYTI1z2kIJ8oy+kypZpN0VnCqIxJbH37/xUYMRu6Llh+I
	Tkphcgf9SqpwdvFSIq5/eAKlTP8q6/+9u8grjuNxlOLEWra1qdUODRc4WyCG0SVa+PK3fudrx2z
	cxoXmYgDZP91Z/V0IkNub8qaNtVgTXeMktrv3oJwUxGM9EhsqW+noF4NAmEYS6MEYag1Lf/25dd
	f2whx7EK/SrmQ6n0qpFWZBm7Bx3CFw9cQqQvKWXpVBF5hNbhhxqBGNNSbrr72qbhSzajsh+U27q
	76SGO1KF/dzW4vXcnIIuN0jK0gPXhgBiN/aRW/sYu
X-Received: by 2002:a17:902:e943:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-29d68344bf3mr126376795ad.17.1764932327875;
        Fri, 05 Dec 2025 02:58:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEscoDWclD8lcxMMNh7A/c7X/KtKpWkerV+xIpxhaA4ymnMM2YdlNqmZ4xvWJKiTSP5tYLZ3Q==
X-Received: by 2002:a17:902:e943:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-29d68344bf3mr126376565ad.17.1764932327428;
        Fri, 05 Dec 2025 02:58:47 -0800 (PST)
Received: from [192.168.29.116] ([49.37.148.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f01csm45113855ad.48.2025.12.05.02.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 02:58:47 -0800 (PST)
Message-ID: <4d4a6614-9460-48b4-8e6a-77d3395abfbf@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 16:28:42 +0530
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
Content-Language: en-US
In-Reply-To: <7ffb61c8-465c-40f1-b794-4f573c8f96ec@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: m3veti15ejS97JlxhHOSpQEkmx1HrSCf
X-Authority-Analysis: v=2.4 cv=Uu1u9uwB c=1 sm=1 tr=0 ts=6932bae8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=v+kbWGyw1T97G6+vs1uYIQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=rSDoVwiHfUr7tCrRsAgA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: m3veti15ejS97JlxhHOSpQEkmx1HrSCf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA4MCBTYWx0ZWRfXzV6OCE4nisO5
 N885+fUXt48rpmhbF90H1uugp9mQUrYh5qErtH5OPGnEmLdRA+pXuuelpfP061swaeoHngkjss5
 hJB5HlBYIFmHs6hfm16DvLk0DaKMjRF/2YJ5WwKa4F3tOiD6Rn0WgNLLZ9Xxy+wncAIXFL2GVfO
 ffKj1kamKZVoQ7CueOw0ogjK6fxKblSH4yBJioudqtfMmx95Nh9bEkzTS1mNo5kH93sPxdfGFKC
 kdYdrYVlBY2CK/QbpCAhfX0+0N/caqz+bccJCXjC8gEv1Dgmdi9sOwVTZWUHyjWAQZIMZk1EPYK
 f3eHLpEaK9vYOxv8WT2N41uEJBtCmrgBUAzR4V62CNPtwGUkvllDehUGO6OMhHYsmOsayFq5O+z
 oXe8BFCAZDVlDnWF8dK51aS7+xSD3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050080
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BF12B43075
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: 2XQLOBG4YVKXB7QYNIDMRPSI3NOXGIOQ
X-Message-ID-Hash: 2XQLOBG4YVKXB7QYNIDMRPSI3NOXGIOQ
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2XQLOBG4YVKXB7QYNIDMRPSI3NOXGIOQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Krzysztof

On 12/5/2025 1:45 PM, Krzysztof Kozlowski wrote:
> On 05/12/2025 09:12, Harshal Dev wrote:
>> Enable config 'm' for the QCOMTEE driver to facilitate communication with
>> the Qualcomm Trusted Execution Environment (QTEE) on Qualcomm platforms.
> 
> I can do it forever, but next time I will just NAK.
> 
> Which platforms need this? Which platforms use this?

Looks like I misunderstood your comment on the last patch regarding Qualcomm
platform support for this driver as more of a generic question instead of being
a hard request to update the commit message. 
https://lore.kernel.org/all/f20833a4-1571-41f8-875a-d27086be3090@oss.qualcomm.com/

I will take care of this now, however I am still a bit confused regarding how many
platforms should I explicitly list out in the commit message. I took reference of
these below patches merged earlier in the defconfig for enabling the QCE crypto block driver,
Qualcomm Watchdog driver and Qualcomm RNG driver. And I did not see them listing out
any specific Qualcomm platforms which need/use these drivers. I understand that this is
because the drivers provide generic functionality applicable on all Qualcomm SoCs.
https://lore.kernel.org/all/20220921045602.1462007-5-bhupesh.sharma@linaro.org/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f27dbbda5900c20e07418c6893ca6e95b634f4ff
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2774e558151a6e325e1f9f278722479601319f78

Similarly, all Qualcomm SoCs have ARM TrustZone support with a QTEE firmware OS running.
The version of the firmware might differ, but it is always there, and so the QCOMTEE driver is
applicable to all Qualcomm SoCs just like the Watchdog or RNG driver.

Please do let me know however if we must provide an explicit list of applicable Qualcomm
platforms which benefit from this driver.

Thank you,
Harshal

> 
> Best regards,
> Krzysztof

