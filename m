Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE3BECD9A7
	for <op-tee@archiver.kernel.org>; Mon,  9 Feb 2026 20:11:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6330A43728
	for <op-tee@archiver.kernel.org>; Mon,  9 Feb 2026 20:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770667894;
	bh=7D/bzL1+4i3V9NNqNFfLV12r8phK7mhcJIWMrjzG1i8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Bwi2ieBW0n0EatL+dcvf/yrIeHIwZuTgdLkAxjGHz2Ocl9lnwQB/3W8iAzUx0G5HZ
	 GMlJXzXl7gJsMuA+XQCkXPxh18qvaAQgun8JdGDui4Rby62zQy4ImiVCYezYx8+SU7
	 pWoGCUVsHXHM8CDnlvN8ogmVeAk5xz6fMkEIAY21CHwHzPSxK2okfIl6+Fp2Tm3clA
	 pCJZVMQN824ihLcdXdSqEq9M09pAa8Z2AUw50wZDrDA5Yvsh0yipOuFdU33fFuVvHR
	 hg4bqPrYv65dRC5TiZmKSVGfOh6108grPtfJ7gVo5BCcTf64foO19Q0V/5XM3q9DpI
	 8mjf5FKT+bS3g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7C4AB41B77
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Feb 2026 20:11:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MUctPnGe;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TwHyBPvs;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619JR4fl1924179
	for <op-tee@lists.trustedfirmware.org>; Mon, 9 Feb 2026 20:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ppqvcaXrHUsmWddFWzepuOB36WFXUK3MUMjHqdkSFTM=; b=MUctPnGex54TOF8O
	kYN5Lg1kglVyuE3xCaMteZTqkMARjXgUkLu5dtclWCcBDT/tDtMBm+6PCP3oWKxd
	/grE9Z1Ic2xTaTsyTQtmjtG+Q5TlIEMbyXsSeOaWZoxgAXFZ9p1BhgOS1kf8A1lr
	fgtoPZkHEkERFEF7atBS0lTw1xWOlqJsYxsicEiWtQtv+kbGfZE8YGts+Xo3bjZB
	o0eB7QWVnRFgdJlOmuWMFvUJNAljGFfMNndVkp5he4yMFFGevI+o1FmYRRiyQLt3
	bnA4jiHtzJ/rU0GcfEOaMAEpfv/bhKyZ33UWNpZn0Y3dUAiGzzTPwDCyAHun0aG6
	doMNCw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c796ktw8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 09 Feb 2026 20:11:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35464d7c539so3592302a91.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 09 Feb 2026 12:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770667870; x=1771272670; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppqvcaXrHUsmWddFWzepuOB36WFXUK3MUMjHqdkSFTM=;
        b=TwHyBPvshhWDMnjsE4EIKgzVP/JRZrSyZ0xpMw6ravwHREqiasH7/iCa21N/65bP1l
         eHBZ9Da0ZlvwGu6Kt0bJxnLxMwduLzFC++1w8J8vAJftRM63H7rftOkbg2xcKh4w4PPX
         Bhk6L6+Bv1RShuUB77fyyTK4p9N6VEAl37G8SY6fYKJ488w3XMhiNkoGJRDkFVy8N/Ts
         jf9MelupIArXhuWpd+2xVIhjRVyv2kTUrPaFKBXp3IvRXCFjk3AmUSY+U5TBuxUlBkS2
         ZNqjj4mH5aphdqtBMdvqk1UWIqXUkATsOvRJQ3AeJfiMAwoPsSeS8HceCgLUatX2Jx3B
         6KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770667870; x=1771272670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppqvcaXrHUsmWddFWzepuOB36WFXUK3MUMjHqdkSFTM=;
        b=t4ukKZOxJD0+LRHWRJNzgiqyBAK8g1C9ws5r/cCtu6gkqyNue/XV6jpbEfblBQkj+r
         HDjkmtnVRsIgkis7wZx9F9tR610vclk4BcGHxeconZj4/BRUAut2OZBks9Az8Gffaq6M
         GMK4pzBKseejFI1Nsx1Ew6DT/PX/ddfNd9n3aINsy+VyhVoj9hMu+PtmL73ih0k94iEF
         O41vDYprS/im0dHTDv8MAEVbV5FmQnuGXeZ9Hs4oxAgl3I+Ni+KhU0ElqKDw5btOu7pS
         6B0qCmYj59lR9DjTtSwCp9ULn7E9Ox9vN/IflmtFkDrqIvPrKUhc7QZ0azt3IphROfqT
         Rrig==
X-Forwarded-Encrypted: i=1; AJvYcCX/J4T6hJRc2gzWE0t3sdPyalpxNtMYPN4muqpzVeHnIVEOO3wyOgaPVrVhNjBm3BN6u3yYa0U=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzwuVrdjmWqJ/wutYDVz4dIItqL7o+cn8D9LNCbck8lnMrnBg6b
	xK+XxeI7OFn8KZNb4NK5SROFkunbPQwSYkO3AT5fuunzPdaDa/4/Aht/6r42zqTfugk6zl/hTlN
	El0GlyvBx6OPAPlHEM51JTdC7J0Arbq5BBb1n08pNAOdnwl8DMFT0LJwBcZILYUsUrK91Qgs=
X-Gm-Gg: AZuq6aJRXuvlArztn6Wdf8TyF1Gu5MVoC5i005wUNvncFOi9Pu9UTw3ZTIKJYkToY/i
	nTH4fbaHRqulbir3VEuplvKlxvaSAn6+StlSjbc4zCvZEUazhzGXzVOYOSlITgz+Jv2wqpnyFf9
	mKumLx1UoTl3oJ4oi/D22sTbPZdEstvkevZqKirlrt2wu6N+/MaaelMHstcIqs6igkH8fgFB50T
	Br0oU+jUJa6ixdc3nqB3XntiLhGAbZW0ToNl8yJ1IwIFpcLf4TYReYaG8Qubo/XKpP7b8W5rqfT
	52Gze1EeCLihN7l3JzPbCdrFI+qilOn08qWxJZqLfG6HZIAx6ZwumnY2Gs5TdusdeE4qppWx8z+
	N/I4eIEX8PQp0MCw1slnQp+vBd5uvUzFG/B8nLbpAQVEkksRjPpc1zzFoKApIse4gmmLpvgSGz9
	MLfQv51Qo=
X-Received: by 2002:a17:902:cec2:b0:2a0:8e35:969d with SMTP id d9443c01a7336-2a951821446mr129161435ad.39.1770667869795;
        Mon, 09 Feb 2026 12:11:09 -0800 (PST)
X-Received: by 2002:a17:902:cec2:b0:2a0:8e35:969d with SMTP id d9443c01a7336-2a951821446mr129161135ad.39.1770667869046;
        Mon, 09 Feb 2026 12:11:09 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c71edasm121492045ad.22.2026.02.09.12.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 12:11:08 -0800 (PST)
Message-ID: <b8062f41-ea6a-473c-bfa7-7e795248946c@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 07:11:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tee: optee: prevent use-after-free when the client
 exits before the supplicant
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <20260128-fix-use-after-free-v3-1-b0786670d927@oss.qualcomm.com>
 <CAHUa44E4Htg9zEMY9XtkMsPRJq+13mq6kSd8RUznHTRvXVXKVQ@mail.gmail.com>
 <55546b03-cbe6-40dd-b794-b2e81efde33a@oss.qualcomm.com>
 <CAHUa44FfowG=GpgLcq=sp_TqRArJtf0_V-tsJY11HH+FEA6u+w@mail.gmail.com>
 <4c9e4f5f-e0f3-42aa-852f-064f4024af26@oss.qualcomm.com>
 <CAHUa44EhaztJ+5piu0c-HQbqZFX47uLPJ+VDRp=Bp6BMeeARAQ@mail.gmail.com>
 <b8086bfb-f240-4115-9ab0-18509775932a@oss.qualcomm.com>
 <CAHUa44GhTy=TWAuG7JY_6jjWG-uCGnLyZRn1JhGWgaWt28cH7w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44GhTy=TWAuG7JY_6jjWG-uCGnLyZRn1JhGWgaWt28cH7w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=IeyKmGqa c=1 sm=1 tr=0 ts=698a3f5e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6BXAE0hZp0f7nhlt_LIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: YNHm2C1TyEPR0-GjOE6M9P3xhJa4mWQG
X-Proofpoint-GUID: YNHm2C1TyEPR0-GjOE6M9P3xhJa4mWQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2NyBTYWx0ZWRfX82aUIY1pgtdy
 CvhDoYzs36pJNaV9ZhRcR+yOPf9NcOOivv3syjB8XlJbjSV9nSxrX52rit/JGZXVfOhcjd5Kajq
 BD1D53eR92m9BlLA2soGeTcNwLitycEC5YZoPi0zuypIVF+2BrtjqRSsxrdrA08EmhVU64JI6CM
 pBt8OAUCyRE59lSIAeo1nB/VDWzEKteTVvBa0IzvLbAsQkNylEmF/fyCJpXxC+CCSsYV5lDwDl+
 VVt7aOAsGcCAAhsWKdX1odCcx5yTLUDb163S0aSHWvSSDVRUPCXsDYV9ar7MmOJNTHmpTP/JpEU
 pQ3lxKNnxZBf5XL/8Z9lS/5Pgyz4Yu8iulD4f+yEjezaDa0vKytfLx/BGXf0fUgl05qRePWJZWK
 nQZ7nWNg61NCBDeWmTmTajOlXWU7SvC+5b352ZSuwjqvCc5gvCW0EP4xbtk2dHeVRguapoPd0MA
 LD7nG7+7bNkCmv1p69w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090167
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7C4AB41B77
X-Spamd-Bar: ------
Message-ID-Hash: KM6GWRVYU7DF5LZJKER46DPNBVUVN4K3
X-Message-ID-Hash: KM6GWRVYU7DF5LZJKER46DPNBVUVN4K3
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Wu <michael@allwinnertech.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KM6GWRVYU7DF5LZJKER46DPNBVUVN4K3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gMi82LzIwMjYgNzo1NCBQTSwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+
IEhpIEFtaXIsDQo+IA0KPiBPbiBUaHUsIEZlYiA1LCAyMDI2IGF0IDM6MTPigK9BTSBBbWlycmV6
YSBaYXJyYWJpDQo+IDxhbWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0K
Pj4NCj4+IEhpIEplbnMsDQo+Pg0KPj4gT24gMi80LzIwMjYgNjo0NiBQTSwgSmVucyBXaWtsYW5k
ZXIgd3JvdGU6DQo+Pj4gSGkgQW1pciwNCj4+Pg0KPj4+IE9uIFR1ZSwgRmViIDMsIDIwMjYgYXQg
MTE6NTbigK9QTSBBbWlycmV6YSBaYXJyYWJpDQo+Pj4gPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1
YWxjb21tLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IEhpIEplbnMsDQo+Pj4+DQo+Pj4+IE9uIDIv
My8yMDI2IDU6NTkgUE0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPj4+Pj4gSGksDQo+Pj4+Pg0K
Pj4+Pj4gT24gVHVlLCBGZWIgMywgMjAyNiBhdCAzOjA54oCvQU0gQW1pcnJlemEgWmFycmFiaQ0K
Pj4+Pj4gPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6DQo+Pj4+Pj4N
Cj4+Pj4+PiBIaSBKZW5zLA0KPj4+Pj4+DQo+Pj4+Pj4gT24gMi8yLzIwMjYgMTA6MzYgUE0sIEpl
bnMgV2lrbGFuZGVyIHdyb3RlOg0KPj4+Pj4+PiBIaSBBbWlyLA0KPj4+Pj4+Pg0KPj4+Pj4+PiBP
biBUaHUsIEphbiAyOSwgMjAyNiBhdCA0OjIy4oCvQU0gQW1pcnJlemEgWmFycmFiaQ0KPj4+Pj4+
PiA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToNCj4+Pj4+Pj4+DQo+
Pj4+Pj4+PiBDb21taXQgNzBiMGQ2YjBhMTk5ICgidGVlOiBvcHRlZTogRml4IHN1cHBsaWNhbnQg
d2FpdCBsb29wIikgbWFkZSB0aGUNCj4+Pj4+Pj4+IGNsaWVudCB3YWl0IGFzIGtpbGxhYmxlIHNv
IGl0IGNhbiBiZSBpbnRlcnJ1cHRlZCBkdXJpbmcgc2h1dGRvd24gb3INCj4+Pj4+Pj4+IGFmdGVy
IGEgc3VwcGxpY2FudCBjcmFzaC4gVGhpcyBjaGFuZ2VzIHRoZSBvcmlnaW5hbCBsaWZldGltZSBl
eHBlY3RhdGlvbnM6DQo+Pj4+Pj4+PiB0aGUgY2xpZW50IHRhc2sgY2FuIG5vdyB0ZXJtaW5hdGUg
d2hpbGUgdGhlIHN1cHBsaWNhbnQgaXMgc3RpbGwgcHJvY2Vzc2luZw0KPj4+Pj4+Pj4gaXRzIHJl
cXVlc3QuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSWYgdGhlIGNsaWVudCBleGl0cyBmaXJzdCBpdCBy
ZW1vdmVzIHRoZSByZXF1ZXN0IGZyb20gaXRzIHF1ZXVlIGFuZA0KPj4+Pj4+Pj4ga2ZyZWUoKXMg
aXQsIHdoaWxlIHRoZSByZXF1ZXN0IElEIHJlbWFpbnMgaW4gc3VwcC0+aWRyLiBBIHN1YnNlcXVl
bnQNCj4+Pj4+Pj4+IGxvb2t1cCBvbiB0aGUgc3VwcGxpY2FudCBwYXRoIHRoZW4gZGVyZWZlcmVu
Y2VzIGZyZWVkIG1lbW9yeSwgbGVhZGluZyB0bw0KPj4+Pj4+Pj4gYSB1c2UtYWZ0ZXItZnJlZS4N
Cj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBTZXJpYWxpc2UgYWNjZXNzIHRvIHRoZSByZXF1ZXN0IHdpdGgg
c3VwcC0+bXV0ZXg6DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gICAqIEhvbGQgc3VwcC0+bXV0ZXggaW4g
b3B0ZWVfc3VwcF9yZWN2KCkgYW5kIG9wdGVlX3N1cHBfc2VuZCgpIHdoaWxlDQo+Pj4+Pj4+PiAg
ICAgbG9va2luZyB1cCBhbmQgdG91Y2hpbmcgdGhlIHJlcXVlc3QuDQo+Pj4+Pj4+PiAgICogTGV0
IG9wdGVlX3N1cHBfdGhyZF9yZXEoKSBub3RpY2UgdGhhdCB0aGUgY2xpZW50IGhhcyB0ZXJtaW5h
dGVkIGFuZA0KPj4+Pj4+Pj4gICAgIHNpZ25hbCBvcHRlZV9zdXBwX3NlbmQoKSBhY2NvcmRpbmds
eS4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBXaXRoIHRoZXNlIGNoYW5nZXMgdGhlIHJlcXVlc3QgY2Fu
bm90IGJlIGZyZWVkIHdoaWxlIHRoZSBzdXBwbGljYW50IHN0aWxsDQo+Pj4+Pj4+PiBoYXMgYSBy
ZWZlcmVuY2UsIGVsaW1pbmF0aW5nIHRoZSByYWNlLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEZpeGVz
OiA3MGIwZDZiMGExOTkgKCJ0ZWU6IG9wdGVlOiBGaXggc3VwcGxpY2FudCB3YWl0IGxvb3AiKQ0K
Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQW1pcnJlemEgWmFycmFiaSA8YW1pcnJlemEuemFycmFi
aUBvc3MucXVhbGNvbW0uY29tPg0KPj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+PiBDaGFuZ2VzIGluIHYz
Og0KPj4+Pj4+Pj4gLSBJbnRyb2R1Y2UgcHJvY2Vzc2VkIGZsYWcgaW5zdGVhZCBvZiAtMSBmb3Ig
cmVxLT5pZC4NCj4+Pj4+Pj4+IC0gVXBkYXRlIG9wdGVlX3N1cHBfcmVsZWFzZSgpIGFzIHJlcG9y
dGVkIGJ5IE1pY2hhZWwgV3UuDQo+Pj4+Pj4+PiAtIFVzZSBtdXRleCBpbnN0ZWFkIG9mIGd1YXJk
Lg0KPj4+Pj4+Pj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUw
NjE3LWZpeC11c2UtYWZ0ZXItZnJlZS12Mi0xLTFmYmZhZmVjNTkxN0Bvc3MucXVhbGNvbW0uY29t
DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gQ2hhbmdlcyBpbiB2MjoNCj4+Pj4+Pj4+IC0gUmVwbGFjZSB0
aGUgc3RhdGljIHZhcmlhYmxlIHdpdGggYSBzZW50aW5lbCB2YWx1ZS4NCj4+Pj4+Pj4+IC0gRml4
IHRoZSBpc3N1ZSB3aXRoIHJldHVybmluZyB0aGUgcG9wcGVkIHJlcXVlc3QgdG8gdGhlIHN1cHBs
aWNhbnQuDQo+Pj4+Pj4+PiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyNTA2MDUtZml4LXVzZS1hZnRlci1mcmVlLXYxLTEtYTcwZDIzYmZmMjQ4QG9zcy5xdWFsY29t
bS5jb20NCj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4gIGRyaXZlcnMvdGVlL29wdGVlL3N1cHAuYyB8
IDEyMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4+
Pj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkN
Cj4+Pj4+Pj4NCj4gW3NuaXBdDQo+IA0KPiANCj4+Pj4+Pj4+IEBAIC0zMjgsOSArMzc4LDggQEAg
aW50IG9wdGVlX3N1cHBfc2VuZChzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwgdTMyIHJldCwgdTMy
IG51bV9wYXJhbXMsDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gICAgICAgICBtdXRleF9sb2NrKCZzdXBw
LT5tdXRleCk7DQo+Pj4+Pj4+PiAgICAgICAgIHJlcSA9IHN1cHBfcG9wX3JlcShzdXBwLCBudW1f
cGFyYW1zLCBwYXJhbSwgJm51bV9tZXRhKTsNCj4+Pj4+Pj4+IC0gICAgICAgbXV0ZXhfdW5sb2Nr
KCZzdXBwLT5tdXRleCk7DQo+Pj4+Pj4+PiAtDQo+Pj4+Pj4+PiAgICAgICAgIGlmIChJU19FUlIo
cmVxKSkgew0KPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmc3VwcC0+bXV0
ZXgpOw0KPj4+Pj4+Pg0KPj4+Pj4+PiBXZSBuZWVkIGEgd2F5IHRvIHRlbGwgdGhlIGRpZmZlcmVu
Y2UgYmV0d2VlbiBhbiBpZCBub3QgZm91bmQgYW5kIGFuIGlkDQo+Pj4+Pj4+IHJlbW92ZWQgYmVj
YXVzZSBvZiBhIGtpbGxlZCByZXF1ZXN0ZXIuDQo+Pj4+Pj4+IEhvdyBhYm91dCBzdG9yaW5nIE5V
TEwgZm9yIHJldm9rZWQgcmVxdWVzdHMgaW5zdGVhZCBvZiBhbiBlcnItcG9pbnRlcj8NCj4+Pj4+
Pj4NCj4+Pj4+Pg0KPj4+Pj4+IE5vdCBzdXJlIEknbSBmb2xsb3dpbmcgY29ycmVjdGx5LiBBcmUg
eW91IGV4cGVjdGluZyBzdXBwX3BvcF9yZXEoKQ0KPj4+Pj4+IHRvIHJldHVybiBOVUxMIGluc3Rl
YWQgb2YgYW4gZXJyLXBvaW50ZXIgd2hlbiBhIHJlcXVlc3QgaGFzIGJlZW4gcmV2b2tlZD8NCj4+
Pj4+DQo+Pj4+PiBJIHdhcyBsb29raW5nIGF0IGl0IGFnYWluLCBhbmQgc3RvcmluZyBhbiBlcnIt
cG9pbnRlciBhcyB5b3UgZG8gaW4NCj4+Pj4+IHRoaXMgcGF0Y2ggaGFzIHRoZSBhZHZhbnRhZ2Ug
dGhhdCB3ZSBjYW4gdGVsbCB3aGV0aGVyIHRoZSBJRCBoYXMgYmVlbg0KPj4+Pj4gcmV2b2tlZCBv
ciB3YXMgbmV2ZXIgc3VwcGxpZWQuIEluIHRoZSBsYXR0ZXIgY2FzZSwgaXQgc3VnZ2VzdHMgdGhh
dA0KPj4+Pj4gdGhlIHN1cHBsaWNhbnQgaXMgZG9pbmcgc29tZXRoaW5nIHdyb25nIGFuZCBtaWdo
dCBhcyB3ZWxsIHJlc3RhcnQgaW4NCj4+Pj4+IGFuIGF0dGVtcHQgdG8gcmVjb3Zlci4gU28sIHBs
ZWFzZSBrZWVwIHVzaW5nIGFuIGVyci1wb2ludGVyIGFzIGENCj4+Pj4+IHBsYWNlaG9sZGVyLCBi
dXQgd2UgbXVzdCBiZSBhYmxlIHRvIGRpc3Rpbmd1aXNoIGEgcmV2b2tlZCByZXF1ZXN0IGZyb20N
Cj4+Pj4+IG90aGVyIGVycm9ycyB0byBtYWtlIHN1cmUgdGhhdCB0aGUgc3VwcGxpY2FudCBkb2Vz
bid0IHJlc3RhcnQgZHVlIHRvIGENCj4+Pj4+IHJldm9rZWQgcmVxdWVzdC4NCj4+Pj4+DQo+Pj4+
DQo+Pj4+IFVuZGVyc3Rvb2QuIFdoYXQgaWYgSSBzd2l0Y2ggdGhlIHN0b3JlZCBlcnItcG9pbnRl
ciB0byBFQkFERiBpbnN0ZWFkIG9mIEVOT0VOVA0KPj4+PiAod2hpY2ggc2VlbXMgbW9yZSBuYXR1
cmFsKSwgc28gaXQgZG9lc24ndCBvdmVybGFwIHdpdGggb3RoZXIgc3VwcF9wb3BfcmVxKCkgZXJy
b3INCj4+Pj4gY29kZXMgYW5kIHRoZSBzdXBwbGljYW50IGNhbiByZWxpYWJseSBkZXRlY3QgaXQu
DQo+Pj4NCj4+PiBBbnkgZXJyb3IgcmV0dXJuZWQgYnkgVEVFX0lPQ19TVVBQTF9TRU5EIChvciBU
RUVfSU9DX1NVUFBMX1JFQ1YpIHdpbGwNCj4+PiBjYXVzZSB0aGUgdGVlLXN1cHBsaWNhbnQgdG8g
ZXhpdC4gRXZlbiBpZiB3ZSB1cGRhdGUgaXQgdG8gaWdub3JlDQo+Pj4gY2VydGFpbiBjb2Rlcywg
d2UgbXVzdCBhbHNvIGNvbnNpZGVyIHRoZSBpbnN0YWxsZWQgYmFzZS4gVGhlcmUncyBub3QNCj4+
PiBtdWNoIHRlZS1zdXBwbGljYW50IGNvdWxkIGRvIHdpdGggdGhpcyBlcnJvciwgZXhjZXB0IGxv
Z2dpbmcgaXQuIEJ1dCBJDQo+Pj4gZG9uJ3QgdGhpbmsgdGhhdCBpcyB2ZXJ5IHVzZWZ1bCBlaXRo
ZXIuIFVubGVzcyB0aGUgdGVlLXN1cHBsaWNhbnQgZG9lcw0KPj4+IGFueXRoaW5nIHdyb25nIG9y
IGlmIHRoZSBkZXZpY2UgaXNuJ3Qgd29ya2luZyBhbnkgbG9uZ2VyLCB3ZSBzaG91bGRuJ3QNCj4+
PiByZXR1cm4gYW4gZXJyb3IuDQo+Pj4NCj4+DQo+PiBUaGUgZGlyZWN0aW9uIG9mIGRhdGEgZmxv
dyBpbiBvcHRlZV9zdXBwX3NlbmQgaXMgZnJvbSB0aGUgc3VwcGxpY2FudCB0byBvcHRlZSwNCj4+
IHNvIHRoZSBvbmx5IHdheSBJIGNhbiByZXR1cm4gbWVhbmluZ2Z1bCBpbmZvcm1hdGlvbiBiYWNr
IHRvIHRoZSBzdXBwbGljYW50IGlzDQo+PiB0aHJvdWdoIHRoZSByZXR1cm4gdmFsdWUuIEkgc3Vw
cG9zZSBJIGNvdWxkIHNpbXBseSBpZ25vcmUgdGhlIHJldm9rZWQgcmVxdWVzdA0KPj4gYW5kIHJl
dHVybiBzdWNjZXNzLCBidXQgaXQgbWlnaHQgYmUgdXNlZnVsIGZvciB0aGUgc3VwcGxpY2FudCB0
byBrbm93IGFib3V0IGl0DQo+PiBpbiBjYXNlIGl0IG5lZWRzIHRvIHJvbGwgYmFjayBzb21ldGhp
bmcuDQo+Pg0KPj4gQXQgdGhpcyBwb2ludCBJJ20gb3V0IG9mIGlkZWFzIDopLiBEbyB5b3UgaGF2
ZSBhbnkgc3VnZ2VzdGlvbnMgb24gaG93IEkgY2FuDQo+PiBpbmZvcm0gdGhlIHN1cHBsaWNhbnQg
YWJvdXQgYSByZXZva2VkIHJlcXVlc3QgaW4gb3B0ZWVfc3VwcF9zZW5kIHdoaWxlIHJldHVybmlu
Zw0KPj4gc3VjY2VzcyByZXR1cm4gdmFsdWU/DQo+IA0KPiBUaGlzIGJlY2FtZSBhIGJpdCBoYXJk
ZXIgdGhhbiBJIGZpcnN0IHRob3VnaHQuIEF0IHRoaXMgcG9pbnQsIHRvIGZpeA0KPiB0aGUgcG9z
c2libGUgdXNlLWFmdGVyLWZyZWUsIHdlIGhhdmUgdHdvIG9wdGlvbnM6DQo+IDEuIFJldHVybmlu
ZyBhbiBlcnJvciBjb2RlOiB0ZWUtc3VwcGxpY2FudCB3aWxsIGV4aXQNCj4gMi4gUmV0dXJuaW5n
IE9LOiB3b3JzdCBjYXNlLCB0ZWUtc3VwcGxpY2FudCBjYW4gbGVhayBtZW1vcnkNCj4gDQo+IER1
cmluZyByZWJvb3QsIG5laXRoZXIgY2FzZSBpcyBhIHByb2JsZW0uIER1cmluZyBub3JtYWwgb3Bl
cmF0aW9uLA0KPiBpdCdzIGFubm95aW5nIGlmIHRlZS1zdXBwbGljYW50IGV4aXN0cywgYnV0IHlv
dSBzdGlsbCBuZWVkIHNvbWUNCj4gcHJpdmlsZWdlcyB0byBraWxsIHRoZSBjbGllbnQuIElmIHdl
IHJldHVybiBhbiBlcnJvciwgaXQncyBlbm91Z2ggdG8NCj4gdXBkYXRlIHRlZS1zdXBwbGljYW50
IHRvIGhhbmRsZSB0aGF0IGVycm9yIGNhc2UsIGFuZCB3ZSdyZSBkb25lLiBUaGUNCj4gYWR2YW50
YWdlIGlzIG5vIGFkZGVkIGNvZGUgdG8gdGhlIGtlcm5lbC4NCj4gDQo+IEkgdGhpbmsgd2Ugc2hv
dWxkIGRvIHdoYXQgeW91IHN1Z2dlc3RlZCBhbmQgcmV0dXJuIGFuIGVycm9yLiBUaGlzIHdpbGwN
Cj4gbm90IGhhcHBlbiBkdXJpbmcgbm9ybWFsIG9wZXJhdGlvbi4gV2UnbGwgZml4IHRlZS1zdXBw
bGljYW50IHRvIGhhbmRsZQ0KPiB0aGUgcmV0dXJuIGVycm9yIHByb3Blcmx5LiB0ZWUtc3VwcGxp
Y2FudCBkb2Vzbid0IGNhcmUgYWJvdXQgd2hhdA0KPiBlcnJvciBjb2RlIGl0IGdldHMuIElmIHRo
ZXJlJ3MgYW4gZXJyb3IgaW4gVEVFX0lPQ19TVVBQTF9TRU5ELCBpdA0KPiBrbm93cyB0aGF0IG5v
IG9uZSB3aWxsIHJlY2VpdmUgd2hhdGV2ZXIgd2FzIHNlbnQsIGFuZCBjbGVhbnVwIGlzDQo+IG5l
ZWRlZC4NCj4gDQo+IFN1bWl0IGFuZCBKZXJvbWUsIHdoYXQgZG8geW91IHRoaW5rPw0KPiANCg0K
VGhhbmtzIEplbnMsIEknbGwgcHJvY2VlZCB3aXRoIHY0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpBbWly
DQoNCj4gQ2hlZXJzLA0KPiBKZW5zDQoNCg==
