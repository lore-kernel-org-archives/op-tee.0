Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E9CC2A06C
	for <op-tee@archiver.kernel.org>; Sun,  4 Jan 2026 21:42:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9D8EB4FF25
	for <op-tee@archiver.kernel.org>; Sun,  4 Jan 2026 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767562953;
	bh=qiSfz+2BrLLjJ+2eYtNRwEsoD96ZvU45v0w2YKE+Ypg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uUlkgBmlzwgOlXYdek+FBIpqfYgqglAnH61BA1rWQSCt+woRyg4mzsmgyvt6qg3qh
	 4g4kDczsgDeSucTDQ/32bm3FqvVWLpJZIZ/JaM8FBDLY/JiaaDP7WOZQJV/NFxZsZ5
	 po7Gv3xD2O8SqUQt8hjKRIm/zTOJAu7EUilXcapO+WbnKaH5Q3AGaOaLc1rN2GTcHl
	 TXDQUkKKm8EF3hFv4AfPNSbpf5yGq9Le4FtWikICeFMYmZURXh1xtyYzahT6num0Hz
	 ejD0dBF6l176+jXeocIdoW3pXPjoGcFfse6q/xcmVHoIIZ7x5ja21CkO5w21JEp+7M
	 wKM3OaNb+Xl0A==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 09D0A41A35
	for <op-tee@lists.trustedfirmware.org>; Sun,  4 Jan 2026 21:42:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bcbTp/Yj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AgkM5pNj;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604LDXxe3676187
	for <op-tee@lists.trustedfirmware.org>; Sun, 4 Jan 2026 21:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rImH/2KlyvyZhocXv4tvAEkdDHKv39O59A2fFmYnOfE=; b=bcbTp/YjDkqO8Wub
	XcfrHgNSPDqCkudhNfT1jeejUvTPW2FRadXFWrpK22E6VO/cjWLU/dQtuEL5uLYG
	FeV/22K3iTwmkXxSQ3IyE7j24lfJUZqu3NGMQTpZ+Dd5IMN0l4k4cVQI3sby1FpJ
	VWOZqYOKoJtQNJg4D2+Mfc5mO2/QxARuipPKVyf8WXDZciyvOaJhCC3QnZRpsd+f
	Oee3UErhgEMN04n+jjRl0ucUW0r7mI++/ziL+D5c3TzvBfcudKnhvqamLakbC0RF
	Q0JoQrJ0+d5CP1ZcCWRpJSxikAaeuLZ3jwwHtB2AMf6vU6iXauyGiVQG/otGlKHV
	ChQSsw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bfyx0g0un-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sun, 04 Jan 2026 21:42:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0a0bad5dfso295409585ad.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 04 Jan 2026 13:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767562932; x=1768167732; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rImH/2KlyvyZhocXv4tvAEkdDHKv39O59A2fFmYnOfE=;
        b=AgkM5pNj1GJP7k6kcHRRW1ZjskJVv4j62lU2plsKJT8/6x7NLINJALsMaaCSpO5J5Z
         29Y6dUJwq8eyBW/c7s1t0kiv0z/M8o89rXDItezixrh7LceS2N40j0EvWy3H5UL+EyWO
         PikMen0JEJYtx5q9Gm7hNA3bTv77Tg9vW5wcjUzLLnvnHt1yUtYH2PSt/P+fC9hBAV+W
         4VRnBYwfnPoHAzAwqHVqgMOoLPzUacynocOuVb2o87W2CJmGr2Vs67hJqMaEqfadQ6C5
         wJuN4IuJr8P7Lp5dnXB9MyW2afXtRK+QO8Tea9154hwE3MSlrIGOQjNun8ex26hvOWrn
         0wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767562932; x=1768167732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rImH/2KlyvyZhocXv4tvAEkdDHKv39O59A2fFmYnOfE=;
        b=Ti0Kx6x4j57sPrwdjciRp6L8veajgH6oHOKWGqbW78H2wwNN7EnQuSoAzPpLD2JO7I
         UuR6FHde41QjDc4UAW8Sh0qAFJw4/PcKXU5j6oShsTwKlQVQIr4KEH3bciaBhTuoAoU8
         MZfkd2nZ51KSkSmBQtLxJO+o/kk5NxV+E8oa5Ngre65Wa/2MlB+1+bvPXa209NrJxr0b
         QO6LJm/lX8yK3s+UgrZyPTXeXZ34OXhdcIZ9Eu2P40J75RWvtgzXIvA5j/4B8kLmqJk1
         3CmMlGZxcgI2TcIfq6qIv+jrVMvjhya/ViwCn329P2Bmupd8zADuPZWuathmin1lBx1P
         N2/g==
X-Forwarded-Encrypted: i=1; AJvYcCWnWa3vkbM6y9hCQZQyCJ7uX+nKzRkH4ckueESDfYE5Ak3w3qnlwBEYXXBppl0agABWrhEoWSQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxWExmg3ZyZqEg7OkWvslh2w7iFg7gDUAFFq7wexYnxS6O4ikXD
	GiFPzbE2oVPWSd95YVPCVO2nJ3BiQopik9PajdmgY/VGmXVAMvaCwSjoOk/YIgT+l5uP4R2JYto
	/FTPxIgmYC5IAK7Vi5Vu6JO0ud7lMoBoiyUARsL0MYpIg1+rKWBrDqYzsXUOYs8Qne3xsYu8=
X-Gm-Gg: AY/fxX7RYHCl3htDTP7mISLoUZquwstYZZAV9E/qu1qa172ZYw5l+F5SDnY25KhSxbU
	XmzThvuo4HGq0VyjYOqmTG6SNlpYH51VJ/1PSP6InpZMuRIyGVQ6ekhfXFILLaseijFOmEJ0J2Y
	hITw3kju7y1W9TCm07J3AhHMayBjEyzA4riWcl1OH1MKKq5RgvGduQ4sd9/BnuYE5lu0jwNnqIE
	3maLLuONk/F70L5SiyrnsQ2y/7f4262Tam4cHv4/WKykW3Fnuf2txOrHWdTtmXHr81BXI+r9/z7
	1PuACBtnLeJ2e+yNz6Azpd+ODf4Y3EHopZMKNBYjt1djwtLMwemf+TImJRM+ncV8clymQSzakC4
	JKhzQFNTeKMUyOf+231L0H+iUjhMbufV6F9+aB21PSm3V5jeCfPUl0RjBxrW5qEnZVVCQ8sJxL5
	X2xLqKI+U=
X-Received: by 2002:a17:903:244f:b0:2a1:3ade:c351 with SMTP id d9443c01a7336-2a2f222bd48mr542175285ad.2.1767562932404;
        Sun, 04 Jan 2026 13:42:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6mzsu28xlvCSCcsYwKe8FITpxti/Q0k/fto0O4UNvWtGYcXQhJtAxHgDry153WPUw0oTW/w==
X-Received: by 2002:a17:903:244f:b0:2a1:3ade:c351 with SMTP id d9443c01a7336-2a2f222bd48mr542175165ad.2.1767562931937;
        Sun, 04 Jan 2026 13:42:11 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a322d76a19sm379338355ad.101.2026.01.04.13.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 13:42:11 -0800 (PST)
Message-ID: <d6c7b08a-0577-47d9-9a3c-5213a002af61@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 08:42:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
 <aTtn-x0hh18V7n7J@sumit-X1>
 <b29c97cd-cade-40ef-8e6d-d164b1d16059@oss.qualcomm.com>
 <aTtyR5J3AqXoE7to@sumit-X1>
 <7b074ee0-4f10-4fba-9680-3d87dcf766c1@oss.qualcomm.com>
 <CAHUa44EO8HYA=KgouSt902RJ63H-Vz24nOaaj7PATVT0n2fkeA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44EO8HYA=KgouSt902RJ63H-Vz24nOaaj7PATVT0n2fkeA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=CZYFJbrl c=1 sm=1 tr=0 ts=695adeb5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=QEsY0_0xN9MvHtGfP8gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDIwMCBTYWx0ZWRfX9PGuQz/yEFgr
 T50AYel1WEPOisDR3ezzt4Tm6z+FYFHrZz6FrUJ1lK9TK36WhmU/3rW4aXFFL6AePWLPBbtW6DN
 VDT1VY4RPMzJovy3STRn5cR8/JgDNrVnoWAtBi1WuHKMm8SssPdlz6cKbXhdXXYUx95tEgwayZc
 wUooDlbhSqV+v5KrGYlvJG7YSDpzcCedOZitJMV7pANKy7Iwmfy6zwb53jsK8+zhZNn3jpD5F3d
 acVJVtfPejWFrhHBmcWZi/e18vkM4U3oiDvffN283CEpu0mSGmooIMeWZQc2XwFgWzWyk2jX9tW
 Mq8Q3cMt6WSytkAAacCyFnCLvh3AKcFlpKTd0jj4k/wgmWuAONiP9ySlxfcasPdC47DZQ8h9fOG
 y/OFrhVOqD42EnkdhKjO14Y/iYVHwdIX8z1dROGohwRO9NGOS8n/lf7Kbzyq0evQy+3GV/aB5JY
 UD0m/qX5prZEgEVHWTQ==
X-Proofpoint-GUID: gy5yBtF_zxDo9onIzYHAMuaQ2zKtStTt
X-Proofpoint-ORIG-GUID: gy5yBtF_zxDo9onIzYHAMuaQ2zKtStTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_06,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601040200
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 09D0A41A35
X-Spamd-Bar: ------
Message-ID-Hash: TI6WGRWZB5VOJVVJ7EZNF3DMU6UAJO3M
X-Message-ID-Hash: TI6WGRWZB5VOJVVJ7EZNF3DMU6UAJO3M
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TI6WGRWZB5VOJVVJ7EZNF3DMU6UAJO3M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGksDQoNCk9uIDEyLzE2LzIwMjUgNjozMyBQTSwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+IEhp
LA0KPiANCj4gT24gTW9uLCBEZWMgMTUsIDIwMjUgYXQgOTozMOKAr1BNIEFtaXJyZXphIFphcnJh
YmkNCj4gPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6DQo+Pg0KPj4g
SGksDQo+Pg0KPj4gT24gMTIvMTIvMjAyNSAxMjozOSBQTSwgU3VtaXQgR2FyZyB3cm90ZToNCj4+
PiBPbiBGcmksIERlYyAxMiwgMjAyNSBhdCAwMjowNzo0MEFNICswMTAwLCBLcnp5c3p0b2YgS296
bG93c2tpIHdyb3RlOg0KPj4+PiBPbiAxMi8xMi8yMDI1IDAxOjU1LCBTdW1pdCBHYXJnIHdyb3Rl
Og0KPj4+Pj4gT24gTW9uLCBEZWMgMDgsIDIwMjUgYXQgMDM6MDg6NDVBTSArMDEwMCwgS3J6eXN6
dG9mIEtvemxvd3NraSB3cm90ZToNCj4+Pj4+PiBJbml0aWFsaXppbmcgYXV0b21hdGljIF9fZnJl
ZSB2YXJpYWJsZXMgdG8gTlVMTCB3aXRob3V0IG5lZWQgKGUuZy4NCj4+Pj4+PiBicmFuY2hlcyB3
aXRoIGRpZmZlcmVudCBhbGxvY2F0aW9ucyksIGZvbGxvd2VkIGJ5IGFjdHVhbCBhbGxvY2F0aW9u
IGlzDQo+Pj4+Pj4gaW4gY29udHJhcnkgdG8gZXhwbGljaXQgY29kaW5nIHJ1bGVzIGd1aWRpbmcg
Y2xlYW51cC5oOg0KPj4+Pj4+DQo+Pj4+Pj4gIkdpdmVuIHRoYXQgdGhlICJfX2ZyZWUoLi4uKSA9
IE5VTEwiIHBhdHRlcm4gZm9yIHZhcmlhYmxlcyBkZWZpbmVkIGF0DQo+Pj4+Pj4gdGhlIHRvcCBv
ZiB0aGUgZnVuY3Rpb24gcG9zZXMgdGhpcyBwb3RlbnRpYWwgaW50ZXJkZXBlbmRlbmN5IHByb2Js
ZW0gdGhlDQo+Pj4+Pj4gcmVjb21tZW5kYXRpb24gaXMgdG8gYWx3YXlzIGRlZmluZSBhbmQgYXNz
aWduIHZhcmlhYmxlcyBpbiBvbmUgc3RhdGVtZW50DQo+Pj4+Pj4gYW5kIG5vdCBncm91cCB2YXJp
YWJsZSBkZWZpbml0aW9ucyBhdCB0aGUgdG9wIG9mIHRoZSBmdW5jdGlvbiB3aGVuDQo+Pj4+Pj4g
X19mcmVlKCkgaXMgdXNlZC4iDQo+Pj4+Pj4NCj4+Pj4+PiBDb2RlIGRvZXMgbm90IGhhdmUgYSBi
dWcsIGJ1dCBpcyBsZXNzIHJlYWRhYmxlIGFuZCB1c2VzIGRpc2NvdXJhZ2VkDQo+Pj4+Pj4gY29k
aW5nIHByYWN0aWNlLCBzbyBmaXggdGhhdCBieSBtb3ZpbmcgZGVjbGFyYXRpb24gdG8gdGhlIHBs
YWNlIG9mDQo+Pj4+Pj4gYXNzaWdubWVudC4NCj4+Pj4+DQo+Pj4+PiBPa2F5IEkgc2VlIGJ1dC4u
DQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6eXN6dG9mLmtvemxvd3NraUBvc3MucXVhbGNvbW0uY29tPg0KPj4+Pj4+IC0tLQ0KPj4+
Pj4+ICBkcml2ZXJzL3RlZS9xY29tdGVlL2NhbGwuYyB8IDE3ICsrKysrKysrLS0tLS0tLS0tDQo+
Pj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+
Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMgYi9k
cml2ZXJzL3RlZS9xY29tdGVlL2NhbGwuYw0KPj4+Pj4+IGluZGV4IDY1ZjkxNDBkNGUxZi4uOGY4
ODMwZjBkZjI2IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMvdGVlL3Fjb210ZWUvY2FsbC5j
DQo+Pj4+Pj4gKysrIGIvZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMNCj4+Pj4+PiBAQCAtMzk1
LDkgKzM5NSw3IEBAIHN0YXRpYyBpbnQgcWNvbXRlZV9vYmplY3RfaW52b2tlKHN0cnVjdCB0ZWVf
Y29udGV4dCAqY3R4LA0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dGVlX2lvY3RsX29iamVjdF9pbnZva2VfYXJnICphcmcsDQo+Pj4+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCB0ZWVfcGFyYW0gKnBhcmFtcykNCj4+Pj4+PiAgew0KPj4+Pj4+
IC0gIHN0cnVjdCBxY29tdGVlX29iamVjdF9pbnZva2VfY3R4ICpvaWMgX19mcmVlKGtmcmVlKSA9
IE5VTEw7DQo+Pj4+Pj4gICAgc3RydWN0IHFjb210ZWVfY29udGV4dF9kYXRhICpjdHhkYXRhID0g
Y3R4LT5kYXRhOw0KPj4+Pj4+IC0gIHN0cnVjdCBxY29tdGVlX2FyZyAqdSBfX2ZyZWUoa2ZyZWUp
ID0gTlVMTDsNCj4+Pj4+PiAgICBzdHJ1Y3QgcWNvbXRlZV9vYmplY3QgKm9iamVjdDsNCj4+Pj4+
PiAgICBpbnQgaSwgcmV0LCByZXN1bHQ7DQo+Pj4+Pj4NCj4+Pj4+PiBAQCAtNDEyLDEyICs0MTAs
MTQgQEAgc3RhdGljIGludCBxY29tdGVlX29iamVjdF9pbnZva2Uoc3RydWN0IHRlZV9jb250ZXh0
ICpjdHgsDQo+Pj4+Pj4gICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gICAgLyogT3RoZXJ3aXNlLCBpbnZv
a2UgYSBRVEVFIG9iamVjdDogKi8NCj4+Pj4+PiAtICBvaWMgPSBxY29tdGVlX29iamVjdF9pbnZv
a2VfY3R4X2FsbG9jKGN0eCk7DQo+Pj4+Pj4gKyAgc3RydWN0IHFjb210ZWVfb2JqZWN0X2ludm9r
ZV9jdHggKm9pYyBfX2ZyZWUoa2ZyZWUpID0NCj4+Pj4+PiArICAgICAgICAgIHFjb210ZWVfb2Jq
ZWN0X2ludm9rZV9jdHhfYWxsb2MoY3R4KTsNCj4+Pj4+PiAgICBpZiAoIW9pYykNCj4+Pj4+PiAg
ICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPj4+Pj4+DQo+Pj4+Pj4gICAgLyogKzEgZm9yIGVu
ZGluZyBRQ09NVEVFX0FSR19UWVBFX0lOVi4gKi8NCj4+Pj4+PiAtICB1ID0ga2NhbGxvYyhhcmct
Pm51bV9wYXJhbXMgKyAxLCBzaXplb2YoKnUpLCBHRlBfS0VSTkVMKTsNCj4+Pj4+PiArICBzdHJ1
Y3QgcWNvbXRlZV9hcmcgKnUgX19mcmVlKGtmcmVlKSA9IGtjYWxsb2MoYXJnLT5udW1fcGFyYW1z
ICsgMSwgc2l6ZW9mKCp1KSwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCk7DQo+Pj4+Pg0KPj4+Pj4gLi50aGlzIG1ha2Vz
IHRoZSBjb2RlIGxlc3MgcmVhZGFibGUgd2l0aCB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgZmxvYXRp
bmcNCj4+Pj4NCj4+Pj4gV2hpY2ggaXMgaW50ZW50aW9uYWwuDQo+Pj4+DQo+Pj4+PiB3aXRoaW4g
dGhlIGZ1bmN0aW9uLiBJIHdvdWxkIHJhdGhlciBmYXZvciB0byBub3QgdXNlIHRoZSBjbGVhbnVw
LmggY29uc3RydWN0DQo+Pj4+PiBidXQgdXNlIGV4cGxpY2l0IGtmcmVlKCkgaW52b2NhdGlvbnMg
aW5zdGVhZCBsaWtlIGl0J3MgZG9uZSBpbiBhbGwgb3RoZXINCj4+Pj4+IGFsbG9jYXRpb25zIGlu
IHRoZSBURUUgc3Vic3lzdGVtLg0KPj4+Pg0KPj4+PiBTdXJlLCBmYWlyLiBJIGp1c3QgZG9uJ3Qg
Z2V0IHdoeSBpbnRyb2R1Y2luZyBjbGVhbnVwLmggd2l0aG91dCBhY3R1YWxseQ0KPj4+PiBhY2Nl
cHRpbmcgaXRzIGV4cGxpY2l0bHkgZG9jdW1lbnRlZCBzdHlsZS4uLg0KPj4+Pg0KPj4+DQo+Pj4g
VEJILCBpdCBpcyBsaWtlbHkgb3Zlcmxvb2tlZCBkdXJpbmcgcmV2aWV3IG9mIHRoZSBRVEVFIGRy
aXZlci4gSGF2aW5nIGENCj4+PiBidWlsdGluIHdhcm5pbmcgZm9yIHRoZSB1bmRlc2lyZWQgc3lu
dGF4IHdvdWxkIGhlbHAgdGhlIHJldmlld2VycyBoZXJlLg0KPj4+DQo+Pj4gLVN1bWl0DQo+Pg0K
Pj4gV2hpbGUgdGhlIHN0eWxlIG1heSBzZWVtIHVudXN1YWwgLS0gYXMgc3RhdGVkIGluIGNsZWFu
dXAuaCwgdXNpbmcgY2xlYW51cCBoZWxwZXJzDQo+PiBtYWtlcyB0aGUgY29kZSBtb3JlIHJlYWRh
YmxlIG92ZXJhbGwgY29tcGFyZWQgdG8gcmVseWluZyBvbiBtdWx0aXBsZSBnb3RvIHN0YXRlbWVu
dHMuDQo+PiBBbHNvLCBpdOKAmXMgbm90IGp1c3QgYWJvdXQgdGhlICJfX2ZyZWUoLi4uKSA9IE5V
TEwiIHVzZSBjYXNlcyAtLSB0aGVyZSBhcmUgbG9ja3MNCj4+IGludm9sdmVkIGFzIHdlbGwuIFN3
aXRjaGluZyB0byBkaXJlY3QgZnJlZSgpIHdvdWxkIHJlcXVpcmUgcmV2ZXJ0aW5nIHRob3NlIGxv
Y2tzLA0KPj4gc2luY2UgbWl4aW5nIGNsZWFudXAgaGVscGVycyB3aXRoIG1hbnVhbCBjbGVhbnVw
IGlzIG5vdCBhY2NlcHRhYmxlLg0KPj4NCj4+IElmIHRoaXMgYmVoYXZpb3IgaXMgZXhwbGljaXRs
eSBkb2N1bWVudGVkIGluIGNsZWFudXAuaCwgdGhlcmUgaXMgbm8gcmVhc29uIG5vdA0KPj4gdG8g
dXNlIGl0IGFzIGludGVuZGVkLiBJIGFsc28gc3VwcG9ydCBLcnp5c3p0b2bigJlzIHN1Z2dlc3Rp
b24uDQo+IA0KPiBJdCBsb29rcyBxdWl0ZSB1Z2x5LCBhbmQgaXQgY2FuJ3QgYmUgbWl4ZWQgd2l0
aCB0aGUgdXN1YWwgZ290bw0KPiBjbGVhbnVwcyAoSSBzdXNwZWN0IHNvbWUgY2FyZSBpcyBuZWVk
ZWQgd2l0aCBzd2l0Y2ggY2FzZXMgdG9vKSwgc28gd2UNCj4gbXVzdCBiZSBjYXJlZnVsIHdoZXJl
IHdlIHVzZSBpdC4gSXQncyBub3Qgb2J2aW91cyB0aGF0IHRoaXMgcGF0dGVybg0KPiBzaG91bGQg
YmUgdXNlZCBpbiBldmVyeSBmdW5jdGlvbi4gSG93ZXZlciwgd2hlcmUgaXQncyB1c2VkLCBpdCBz
aG91bGQsDQo+IG9mIGNvdXJzZSwgYmUgdXNlZCBjb3JyZWN0bHkuDQo+IA0KPiBUaGFua3MgZm9y
IHRoZSBmaXhlcywgS3J6eXN6dG9mLg0KPiANCj4gQW1pciwgaWYgeW91J3JlIGhhcHB5IHdpdGgg
dGhlIGZpeGVzLCBjYW4geW91IGdpdmUgeW91ciBSLUIgZm9yIGVhY2ggb2YgdGhlbT8NCj4gDQo+
IFRoYW5rcywNCj4gSmVucw0KDQpUaGFua3MgSmVucy4NCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJl
c3BvbnNlLCBJIHdhcyBvbiBsZWF2ZSA7KS4NCg0KSSdsbCBkby4NCg0KUmVnYXJkcywNCkFtaXIN
Cg0K
