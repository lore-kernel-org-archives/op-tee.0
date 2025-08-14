Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57632CA0ED1
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 05:51:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 75E094FC64
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 05:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755150667;
	bh=goKy0LFnGsAFl3cb8Uy0aZElaO38Rwfs5td/AM/RGCY=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JRZXBxxfFy1uxnwMBa1VnHtrTwHUkUO3dyUFBcSw6tNBZtHxO/1wR+Nh3NZqDVkdh
	 axbgaca+nbPvz3eO8A2cWMwFilGPYD29AumnYT1C6HmpkSdHhALjB07nzlTNg3SyQ/
	 lRJ/nfvymBqYTeX0n8sar4CUY+jcI8X1dDw0VIMyYJhR/CmZn/y33Bf1Mr72+Opats
	 exc7SDxDe8qr3Y/rGaUschhEwxETNr1RMYtIMAPv1s4EvqRiUwlMltde5P4F+J8eYd
	 2sO8+t12pL6/6EzWdooxRk7bBlKgygKXEKZTj/JDwqarul5cMCvqZhlsJQK4qPpRug
	 ZrNe/fwQbQKCA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F35C341B47
	for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 05:50:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XvVOo5Xg;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DKm3Nw025180
	for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 05:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZOJ5RR3PqgCQNdZV6tHlQpMWfAVJArmZDw7MU6+DL7M=; b=XvVOo5XgoxdS+3Sf
	Bq2yXWJ0hiwSTa0MEuZoW4IjIJC86W8OrGPMHs40+cf+tOMSGGaYuKi7i2oPVGqe
	gSWw1VbakLMUewkEiRv1vIbQjopB4W4bdMf67x+MclV95o1iXuDkfsK1sau/aKQv
	VhIikW19P9Bevhi8z17Bu4IrPqlmDJJp4k9OK73+oqjS7XZt9u5HR6yfL8wFwz77
	0gV49EtbSLRjR1YvMPZeSDnV9uKscVy7QYe2Iot+qf+vee8/8A7pjLGkH4JCW5K/
	HorgUiylHUufqpREbDbZCaH+kbcZdkZg5+arxe1Kgc/kbYdf+Mo/szhMVvUp85zv
	DNaEqg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4jd1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 05:50:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458194d82so6432645ad.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755150651; x=1755755451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOJ5RR3PqgCQNdZV6tHlQpMWfAVJArmZDw7MU6+DL7M=;
        b=W2ChhrqMzO3IjBpjdq/r2JH6PA9qmGrpRoBGnIEqpbAUyFTVgYvNiqGZwY4fiJw/L2
         UfCLSRsFgnbwHpKuv8racd0FW0KeJkom/QjVXzg3XkjjTun0p48EXFQDS/vo++59brgt
         xwkkboKy42l8eMuMtMWQIDP0845p/L4fEcNBnygaLifj1Vog00teDb5ohzsMFA1Jpap6
         dMDpeTdtrM/jzzcD0XBxPbrtQ7FBE4opJ2dhnhs/q1wCa9+pjBrn1Ei8iTmRs8zH/mjH
         KIoOxYEL5trbGmtM7RL0wVCIPZJE0gm9Hl7UyC5ufWqOe98R/cq5Yp1pf482y3oK/uSe
         RGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Lky/wI0n6Ed5cw5k5lo6zi6jTMo6Aqna/bI4oSGza0GXOjtG2IS0R2yWNotTHqNe1Nj7itc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw7XtgTG25BR3sDBH+rfYfsl+Q7z9aB6TbvH8709gX9HMNvXIeV
	p+gMNGFoa3HoO1UnKjoR1zBuM6tbiuUbVHHlvY+djzcgHXL3Zu/5QFN3tnPbe4yKvn0shuLD0T2
	IG+Uicz3+2lnlhhFZcGKlD5gMj3cspofbk2JcHMQXnQg/fbU3isaDeW3kInmV684GZV9OMg0=
X-Gm-Gg: ASbGncsEx95aEB8oN5rsJshEFgRHwCddzDsWnzzGh/qjrquKIXTT46bxk+mWl9LlT5C
	8YQlQWSVOIDN7BVx7EbZwkvUgwAA+IDvlQ6JI0IzJCcSeKDC5+RZcfAWfNDk6qnTqbvWQfcceuS
	dVBEfhDtyKs4VlqIcuy12SDjQrCOdSUudd5NyO/lTf5A2GAhflfYGSTJGaipsL2TY21uFFnbnGW
	Nxf3IQ0Hs1FV/c8a6dX/LQEKDck8nS5Y5wLVGR4fGA771lkFtrzVxNJBJ/6RmWDuyKT8bY+Hk7V
	0UM0uIUvVyM5TGpRa9Q5D2v/B/hG/oyv6j6yg3o9wk1pvd9BWm1qEBAf/bRGIS6D4gy7kwHgcI2
	hHKl2PTztGXrVWDkv/cw/n7HplsoAQ+FjPullVA==
X-Received: by 2002:a17:902:e784:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-244586efd7amr26911715ad.54.1755150650523;
        Wed, 13 Aug 2025 22:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg+3/0CB4U2pDNP5uuELEloHSNUMx8oZuD+AyTPJ8LiDQNxpnVIDTDJbE8IvvpsAU7Y3B2/w==
X-Received: by 2002:a17:902:e784:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-244586efd7amr26911215ad.54.1755150650056;
        Wed, 13 Aug 2025 22:50:50 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2430558a0b7sm52896745ad.85.2025.08.13.22.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 22:50:49 -0700 (PDT)
Message-ID: <22d6cbc1-90ad-44b0-80fa-c3c67abdae8d@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 15:50:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
 <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
 <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
 <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
 <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
 <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: sbOF4oX5o6CVpw4phtzd31yIi8EHoP39
X-Proofpoint-ORIG-GUID: sbOF4oX5o6CVpw4phtzd31yIi8EHoP39
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX5KOGO+dLaiGs
 xljiDNHUu0irxvb/H32VU2Ng/C1DoQ+FE9UzbZbS5+EFCmp7hj85naPBwKSxIjZ8QYLBq0/0e16
 CUuFPNG49Ya4Yw68uS7qYGacZFTr6tf0UncEFVrSRrLRFOephtP/U0UrmcPmsq4P+qIBVc56Pme
 HsB66mNjk03TZAREZZRItxzeEmyNuN7mY3xrlXActGoZohanazGyYjZU3Vw1KhnZxYsSr5quqqL
 /y2ACOTJTa1Y8HMriPvEOEWTTWy2c2rken7ON0XmcU7tj42yHR1PMqQZJL1shTnDKoyBndiOFVT
 GhAOdgwwIgFDvJsIuUUTjCUj2gJwrqHmCQ3LOYxPf2tAGBDTXK2iBzLlLHVZ7ikKiyTOe8iLrk2
 1fxXxIHK
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689d793c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=oZdMm6XVNGq0ThNLGeAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068
X-Rspamd-Queue-Id: F35C341B47
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.56 / 15.00];
	BAYES_HAM(-2.56)[98.04%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: GBWEYJT3PGK6GCOWJMABLZOMDQNCHDWO
X-Message-ID-Hash: GBWEYJT3PGK6GCOWJMABLZOMDQNCHDWO
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GBWEYJT3PGK6GCOWJMABLZOMDQNCHDWO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

DQoNCk9uIDgvMTQvMjAyNSA5OjIwIEFNLCBLb25yYWQgRHliY2lvIHdyb3RlOg0KPiBPbiA4LzE0
LzI1IDE6MTkgQU0sIEFtaXJyZXphIFphcnJhYmkgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDgvMTQv
MjAyNSA4OjQ5IEFNLCBLb25yYWQgRHliY2lvIHdyb3RlOg0KPj4+IE9uIDgvMTQvMjUgMTI6MjQg
QU0sIEFtaXJyZXphIFphcnJhYmkgd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDgvMTMvMjAy
NSA4OjAwIFBNLCBLb25yYWQgRHliY2lvIHdyb3RlOg0KPj4+Pj4gT24gOC8xMy8yNSAyOjM1IEFN
LCBBbWlycmV6YSBaYXJyYWJpIHdyb3RlOg0KPj4+Pj4+IEVuYWJsZSB1c2Vyc3BhY2UgdG8gYWxs
b2NhdGUgc2hhcmVkIG1lbW9yeSB3aXRoIFFURUUuIFNpbmNlDQo+Pj4+Pj4gUVRFRSBoYW5kbGVz
IHNoYXJlZCBtZW1vcnkgYXMgb2JqZWN0LCBhIHdyYXBwZXIgaXMgaW1wbGVtZW50ZWQNCj4+Pj4+
PiB0byByZXByZXNlbnQgdGVlX3NobSBhcyBhbiBvYmplY3QuIFRoZSBzaGFyZWQgbWVtb3J5IGlk
ZW50aWZpZXIsDQo+Pj4+Pj4gb2J0YWluZWQgdGhyb3VnaCBURUVfSU9DX1NITV9BTExPQywgaXMg
dHJhbnNmZXJyZWQgdG8gdGhlIGRyaXZlciB1c2luZw0KPj4+Pj4+IFRFRV9JT0NUTF9QQVJBTV9B
VFRSX1RZUEVfT0JKUkVGX0lOUFVUL09VVFBVVC4NCj4+Pj4+Pg0KPj4+Pj4+IFRlc3RlZC1ieTog
TmVpbCBBcm1zdHJvbmcgPG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc+DQo+Pj4+Pj4gQWNrZWQt
Ynk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNvbT4NCj4+Pj4+PiBUZXN0
ZWQtYnk6IEhhcnNoYWwgRGV2IDxxdWljX2hkZXZAcXVpY2luYy5jb20+DQo+Pj4+Pj4gU2lnbmVk
LW9mZi1ieTogQW1pcnJlemEgWmFycmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0u
Y29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4NCj4+Pj4+IFsuLi5dDQo+Pj4+Pg0KPj4+Pj4+ICsvKiBN
YXBwaW5nIGluZm9ybWF0aW9uIGZvcm1hdCBhcyBleHBlY3RlZCBieSBRVEVFLiAqLw0KPj4+Pj4+
ICtzdHJ1Y3QgcWNvbXRlZV9tYXBwaW5nX2luZm8gew0KPj4+Pj4+ICsJdTY0IHBhZGRyOw0KPj4+
Pj4+ICsJdTY0IGxlbjsNCj4+Pj4+PiArCXUzMiBwZXJtczsNCj4+Pj4+PiArfSBfX3BhY2tlZDsN
Cj4+Pj4+DQo+Pj4+PiBQbGVhc2UgdXNlIHR5cGVzIHdpdGggZXhwbGljaXQgZW5kaWFubmVzcywg
ZS5nLiBfX2xlMzIuIEknbSBhc3N1bWluZw0KPj4+Pj4gVFogd2lsbCBhbHdheXMgYmUgbGl0dGxl
LWVuZGlhbiwgcmVnYXJkbGVzcyBvZiB0aGUgaG9zdCBPUw0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSSdt
IG5vdCBlbnRpcmVseSBzdXJlIGhvdyB0aGlzIHBvaW50IGlzIHJlbGV2YW50LiBBcyBJIHVuZGVy
c3RhbmQgaXQsDQo+Pj4+IHRoZSBjb3JlIHRoYXQgcG9wdWxhdGVzIHRoaXMgc3RydWN0IGlzIHRo
ZSBzYW1lIG9uZSB0aGF0IGFjY2Vzc2VzIGl0IGluIFRaLg0KPj4+PiBZb3VyIGFyZ3VtZW50IHdv
dWxkIGFic29sdXRlbHkgbWFrZSBzZW5zZSBpZiB0aGUgaG9zdCBhbmQgVFogd2VyZSBvcGVyYXRp
bmcNCj4+Pj4gb24gZGlmZmVyZW50IGNvcmVzIHdpdGggZGlzdGluY3QgYXJjaGl0ZWN0dXJlcyAt
LSBzdWNoIGFzIG9uZSBiZWluZw0KPj4+PiBsaXR0bGUtZW5kaWFuIGFuZCB0aGUgb3RoZXIgYmln
LWVuZGlhbiwgd2hpY2ggaXMgbm90IHRoZSBjYXNlLg0KPj4+DQo+Pj4gQ09ORklHX0NQVV9CSUdf
RU5ESUFOPXkgZXhpc3RzIG9uIGFybTY0DQo+Pj4NCj4+DQo+PiBPciwgeW91IGFyZSBzYXlpbmcg
d2UgbWF5IGhhdmUgYSBjb25maWd1cmF0aW9uIHdoZXJlIGhvc3QgaXMgYmlnLWVuZGlhbg0KPj4g
YnV0IFRaIGlzIGxpdHRsZS1lbmRpYW4/DQo+IA0KPiBJIHdhcyBpbmRlZWQgYWJvdXQgdG8gc2F5
IHRoYXQuLiBJIGJlbGlldmUgb3VyIHR6IGlzIGFsd2F5cyBsaXR0bGUtZW5kaWFuDQo+IGJ1dCB5
b3UgY2FuIHJ1biB0aGUgSExPUyBvZiBlaXRoZXIgZW5kaWFubmVzcw0KPiANCg0KT2theSwgSeKA
mXZlIHRob3VnaHQgYWJvdXQgdGhpcyBwb2ludCBhbmQgYWxzbyBkaXNjdXNzZWQgaXQgaW50ZXJu
YWxseS4NCkkgY2FuIGFkZCBhbiBlbnRyeSB0byBLY29uZmlnIHRvIGVuc3VyZSB0aGUgZHJpdmVy
IGlzIHVuYXZhaWxhYmxlIHdoZW4NCkNPTkZJR19DUFVfQklHX0VORElBTiBpcyBzZWxlY3RlZCAt
LSBmb3Igbm93LiBIb3dldmVyLCB3aXRob3V0IGEgY2xlYXINCnVzZWNhc2UsIGFkZGluZyBhbGwg
dGhlIGxlMzJfdG9fY3B1L2NwdV90b19sZTMyIGNvbnZlcnNpb25zIGp1c3QgbWFrZXMNCnRoZSBk
cml2ZXIgbWVzc3kuDQoNClJlZ2FyZHMsDQpBbWlyDQoNCj4gS29ucmFkDQoNCg==
