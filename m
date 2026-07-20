Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A013C4451B
	for <op-tee@archiver.kernel.org>; Mon, 20 Jul 2026 05:56:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5F40744FD4
	for <op-tee@archiver.kernel.org>; Mon, 20 Jul 2026 05:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784526965;
	bh=nNGfVQUSU1iNKLLLhDotYQPgoa0DUotLOny8szy38+U=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BIQikWe+AqIxuoh41TuVMBk2uMwE6rEmaZJjAAC6nDU+hmyyq0PEqTPKVBxjoyzgE
	 Sh2WgrV584nQMFAgIkJd+eRzoELueMXiz5zt1nZTn5nLklzKZBlmh2lw+4FNBn2nDG
	 65xk7su8SDPMH/DijsuTX6SNndsVPUa682RGnybsiANJO7OCA5SMLa0D1uTB4O72n6
	 hB3fr9Qheg+rxxHZuyZDZCjuEog8qSzqyiHHnkFqmtp8I+53ruwLN/HFEkICDxKA0w
	 OoQl6C6crXJ+MThmYvfCfdgv34XGKZ7OxdXcidF+wj+YIbhz2VLa+7l1YHXEOu9+Fn
	 KfWGYPt7ErJfw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5BA624422A
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 05:55:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PNPUy/8G;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CjhZ3qtp;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNu7Xl851933
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 05:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndWdbIk/tkNrHopztgJ4e8IGKG5hlFeD58XbJ1VwOtI=; b=PNPUy/8GuqIrlyuG
	My+hfYShtyW6z7MIIDQePhfVMZ96j3MGtmQL8cXjL318+4qV3ZpcH0f20Tt72EED
	1mrprNz/tw8GaurKxWt1DSDgXZ+GMhFtkblJzZUX3L05Oh7iYBgsqRlrRz20y6xb
	CT7rZuetZHa/Dh4obwGIdCBvBflXOTC+7Ad5kUVG2IHVN3lMU89eNzYNsgORku88
	LeU1KzrlARGq7diqp1BENuDcySpQ66p9q67oCGwNxQa1qkktjPUMuj08mz5aIowQ
	5dUa4YlZEFR9reCf5t/fWfBcWWncLJ6LM31sBI8Y3HKxw449ph3W90Wp5lP8TWeC
	PjXeKw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc4ky2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 05:55:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cce14a21faso57937835ad.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 19 Jul 2026 22:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784526957; x=1785131757; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndWdbIk/tkNrHopztgJ4e8IGKG5hlFeD58XbJ1VwOtI=;
        b=CjhZ3qtpZxqcqhD83ZismdloM4EzA3b/99Raz/XpwSUNfXTikVAlVUuRvavvHaTxbP
         kTCFbqau/7N/I7pB68ZvQ11TmpA7bNOLExxgQc7mWCe0fI2lWCLYZljtjirkx1sLPr9j
         q3E0TQYtf42Hl2WZ7BrRV4SyNKU6j5tNheYAU0NZDRy7kqOwi40wNWSLEf7alEvjUqua
         ruK1U8ES3M1x9V8ieA6MsTGshhaAuhACq962t3s4YK8IZhbfVg9hLUzIY4jQ6V9UFg10
         NpdFtmuR7HBqvEBL2mafOONpKtgSvEkv0VQudyB5oNL3lQ4aKYKmm1lEItAiRjVqkCY1
         gYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784526957; x=1785131757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndWdbIk/tkNrHopztgJ4e8IGKG5hlFeD58XbJ1VwOtI=;
        b=T5e0cAKG6qe/oyb881tyRC/M7kV73+o4WgI0sZ84vUPNiUJoqLUodsSrYpTgOpoVm9
         WLn6iVhW9nscHDcS6ujFOy1+ikBI7KvyAiA/khQTPZvUjSsXQES1bbzSzgkOeUNwMEqr
         q1D4ffMnDDN4W8flO39KLsFKMml2S8uzso5lwzsgvr/FeAjtwxE85qf/VJ/d7/2PxiWH
         /3mMP+56qUmN8xVwXCNCzkMGVPCtQC+K1E9Tg2X+5MlinvJfXuFd2AvfCPtiTZVv/FZx
         0CbBCu3gounj2geKw94BtZR5E5NnoX2FCOlZqtikABx/XjnjJ3mbl19icFckgbIlMOtm
         YUiA==
X-Forwarded-Encrypted: i=1; AHgh+Rqs/TjpgumLgP2HRzVdBQegai3bUdKuAjqR0hDupFUMWdGx7IfMs2Q1jHFuWS+vsvgEwTTCTgQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyxmFEIN5CKRfxkORi8f6NVnTE4w0sQaYUY/z/oYB14QgWXNmKI
	Yj2mjcsgebJGC+BwOxYG9hBo6xXIESGI4No/4BimrtjHyA+bvr1P1dIOmGXQxzzwlo3fq7KJWZL
	I5xnTOqDB25IeJgGUNn2MjlM7gH+IFYC5pLEQD4btezeS+RXkdN1LqYAjH6azZiNu4P0/zYcZ
X-Gm-Gg: AfdE7clsIhObJ8Z5M16VNSihpMyBvbOt5Qyv6TpSIN4yk9Bk2Q1eqTHlaXnGo/rXLcT
	06qVxKmqJ4vcsY0ultb+22Cm9/1A9TuwtnLmqvH4XezJVSr/EORYLeIEPRitYXbMqZrmJmOAEJT
	jvuVJZY4/xJa+Dblj+9YqJxiD5H4Y2F7RmD06C9zjSFL7DyExeGsPrIvYQpeNqQLpIH9vDHGK5o
	6eHJp8kn/x4U99eiyKOQuqtZKUTM5bJH2lGR5zJ8tTRxpfXXo3NjCsTZlD+mxI/bhxWNhl6d+OF
	Q59BVfoNpmB9ZdfrDapFsQ2Q9P0K5N6U+wCh/OR3IB+/BUZQIoK5K+YlRU5lQI+2ZoZTZmyPuD0
	Jy4/uTzxjvNWBGObznxrCcyUY0HNSRg==
X-Received: by 2002:a17:902:b082:b0:2cc:89ce:2f07 with SMTP id d9443c01a7336-2cf348444c7mr93121935ad.1.1784526956544;
        Sun, 19 Jul 2026 22:55:56 -0700 (PDT)
X-Received: by 2002:a17:902:b082:b0:2cc:89ce:2f07 with SMTP id d9443c01a7336-2cf348444c7mr93121715ad.1.1784526956087;
        Sun, 19 Jul 2026 22:55:56 -0700 (PDT)
Received: from [192.168.29.116] ([49.37.145.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346daf66sm50655905ad.50.2026.07.19.22.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2026 22:55:55 -0700 (PDT)
Message-ID: <6600d003-709e-4186-98c4-a9ac263d7d6b@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:25:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: remove dead select from kconfig
To: Arnd Bergmann <arnd@arndb.de>, Julian Braha <julianbraha@gmail.com>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>
References: <20260715092539.18384-1-julianbraha@gmail.com>
 <a3b7a752-8cc4-492a-bb62-43121b852c41@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <a3b7a752-8cc4-492a-bb62-43121b852c41@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2MyBTYWx0ZWRfX1Zps0kwl6mEo
 7FDeikcRxAxELldRKkgRcxf1kDz7XGGRSSsGUgG09Y8hs1UxwDs64Am7wXSkEsVUosGRXGR2YoV
 llWEYPkEThpHQaXnXXoxWdilo2Y6qt8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2MyBTYWx0ZWRfXyYav9sLvxR4a
 XMVVtjKl/lhmP97mkDm3NvNkcnYdxehUHNL80U6TEdMwwHbDrVaQ2UJVkLXOt+lEegOLQEYBBqA
 F8zrfSzB6+CBuywwU84gj7wEK3E8i+QMLC6oM66d6KH6YNXov63zp0ns1nAHIGPDt5dkJ7BptfO
 8PECais4RlxUNJMEX8yF1xQlAlTcbJhDbSLyJ/AG+0VZIq/GGAfICbRaKAyGwMk+3mK5XecsF5X
 xokVc+fQlBtUASuyGTltxAm0cmTdc9rYEx9hq5Dk40fc1csSotITxFtSE12E51j6OXO3iHZ3DUN
 Yk3JL8cW8sjd2bGOpYGOWcyRgWPr4GGvuljCPKlhUydl9g3HeVHcFU8iSXOwmK0thN3JOb6ukUy
 yi7gbnqnqI7tU2AS/bm6Q0kQoHQkpp7GR4uV4jmijaXi+Bjk6VadvxaeGxh6Io3/efvOgw00eBH
 FBsdOy6pC+H8ag7FFuA==
X-Proofpoint-ORIG-GUID: bQQorKHCM3cvbu8Da82VVkgVNEL8hlT6
X-Proofpoint-GUID: bQQorKHCM3cvbu8Da82VVkgVNEL8hlT6
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5db86d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=aryqaONRTh07XXH6IkyVKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zWqAy90xs1Rb1aWM7kAA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200063
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[arndb.de,gmail.com,oss.qualcomm.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5BA624422A
X-Spamd-Bar: ----
Message-ID-Hash: MFGBIK4AKKXPPOXAKD2P4WOLV7IUGMJN
X-Message-ID-Hash: MFGBIK4AKKXPPOXAKD2P4WOLV7IUGMJN
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, jenswi@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MFGBIK4AKKXPPOXAKD2P4WOLV7IUGMJN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi,

On 7/15/2026 3:38 PM, Arnd Bergmann wrote:
> On Wed, Jul 15, 2026, at 11:25, Julian Braha wrote:
>> 'select' does not work on config options in a 'choice', so currently it is
>> possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE.
>>
>> This patch removes the select.
>>
>> I've compile-tested this and found that it builds fine without
>> QCOM_TZMEM_MODE_SHMBRIDGE, but I don't have the hardware to runtime test.
>> Please advise if it would be better to make QCOM_TZMEM_MODE_SHMBRIDGE a
>> dependency.
>>
>> This dead select was found by kconfirm, a static analysis tool for Kconfig.
> 
> Right, clearly something is wrong here.
> 
>> @@ -5,7 +5,6 @@ config QCOMTEE
>>  	depends on ARCH_QCOM || COMPILE_TEST
>>  	depends on !CPU_BIG_ENDIAN
>>  	select QCOM_SCM
>> -	select QCOM_TZMEM_MODE_SHMBRIDGE
>>  	help
> 
> From the implementation, my guess would be that QCOMTEE actually
> requires QCOM_TZMEM_MODE_SHMBRIDGE and it only links successfully
> because of the stub helpers added in 8aa1e3a6f0ff ("firmware:
> qcom: tzmem: export shm_bridge create/delete").

This is correct. QCOMTEE can build without TZMEM_MODE_SHMBRIDGE, but will not
work without this config. TrustZone will just refuse the memory shared without
this config enabled. So it is a hard dependency.

> 
> If that is the case, we probably need a 'depends on
> QCOM_TZMEM_MODE_SHMBRIDGE' here, and can remove the stub
> functions.
> 
> It is also possible that the 'choice' itself is wrong, and
> this should be detected at runtime. It is a rather odd Kconfig
> option, as it sounds like only one of the two is correct on
> a given hardware. The CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE variant
> contains runtime hardware detection, so it should actually
> be safe to enable that anywhere. If this is true, we could
> just turn the choice into a 'bool' symbol and remove the
> generic case.
>

So when TZMEM_MODE_SHMBRIDGE isn't enabled, and instead TZMEM_MODE_GENERIC
is used, the driver just becomes a generic memory allocator, so the clients
cannot share this memory with QTEE. I couldn't find any existing clients
of TZMEM that aren't using it in MODE_SHMBRIDGE, in other words it seems that
we don't have any users for MODE_GENERIC.

In that case, it appears to be a better choice to make this a bool.
Either MODE_SHMBRIDGE or not.
But since @Bartoz is the maintainer, I would let him provide his comments
on this.

Regards,
Harshal 
> I've added a few more people to Cc that may know the correct
> answer here.
> 
>      Arnd

