Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E447BCA6017
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 23:21:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 02502454CD
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 23:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791501685;
	bh=gJSyT+MXC1dsieZdFRyILumyR2EIx0WXZP5xfYBv3GI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tKSnytq8pXSIgC5m2uJz+MIPlr2KX0FSGCQ/hTJARi+ICcd4XwZH1bAabcTjZgpNU
	 6VlMwc5wQrwTt0q/sDMc9MvjweYqcN7TPbneKi+bV/tGznKp2oTZUO+XFlkRjzaZ1d
	 7P+BP5HsQyd220DndevP1TwaJXX4dAxs7JNMPrZfvw21khftrZ502b1T3QCjoE6WJc
	 FYypRQSIgDwXuaRUkWE95Ljuv6aIKdccpfIkWZw6ezYRKODTcaIwb9MsnmXadOm76e
	 SgqxYaF1mozXCvmFqu3VjxhVpfGZfhRR/CooltpsJkhGjAqxSgHasz9waxUb1Xtx+S
	 8Za7W9fw/fifQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6BA08450A1
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 23:21:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SLjXGBrb;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QkLbMG7i;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698L0Nt13387021
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 23:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+FLWS/ZRP3JLphZpvTJtWhtqU29QF4WSDgFqxaK31HQ=; b=SLjXGBrbBBAi4t92
	w9IuXEF7bg+FSKwz4LD/g1g1A2x7E/F13/y98/gjLoyTsxflKTwylO1nHy1X6SOQ
	bp8QvVXgF3cOqj6whYo7QYAhr35HouczPYyI+RJAGDD8BAQ2TJ5yauTCPj+cL5Hw
	PZAYYHHG0MowVKN8CBKx3aczXFfL8qjBmKalqhOO4bJXh1uWCv65hYRQqteWNFBt
	jT2tbuRpR9SuAIhIXLskeXWOd6YJFEn0n84KIniTIL6Bolk5CWtNggP5Ri4whc2p
	v1rozX9bszMkCgFYDmhvrba5t4u0upcnlLmIjd1dvN+hn+nvomBBKsnt3Ibw2FTQ
	XmfJAQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrs1n2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 23:21:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df375fb9b2so61053995ad.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791501676; x=1792106476; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+FLWS/ZRP3JLphZpvTJtWhtqU29QF4WSDgFqxaK31HQ=;
        b=QkLbMG7ikBwHNHziX3yWSprycZTILtGckPw/POJJeSlv4fAjnh97skCbpiLLNsEZxN
         HaY2RAFxXgv16oxHC9GLjF3Yl5ERsXsPqE6oAqWNif8FPf0JF3YsAvDDZ78fG6TTBw1N
         Klg8h6ByxympoKSrm4daEArQi3bS8BUaHiWRjKf0cYGxt5VOcdLPslykDiZdXJKuVgJS
         /H1zqxXGuDC8/xGA151yO+TV2XN3plfYB0EWx08TE1uc0h1gF2Lpi7Uu4P2NL5b2/gY1
         8nctDT5mrkJscHkryA42+j1HZpxfsL3qLDN/4fbMEOy2j4qprhLN6h+z/aZYo/x3kNAC
         6TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791501676; x=1792106476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+FLWS/ZRP3JLphZpvTJtWhtqU29QF4WSDgFqxaK31HQ=;
        b=UhRxx94mLFrht7xXznn5EAJ5aWWdwyQEqPXZvWWNI4eEheH45CjZ8AaPPLbpudfJ8X
         2jBSYDCnudw2x3kHaD/4IvqSyme7R/7TiEuKDs/PtzM2Izcf1KxHdxf7WHZv1HdLZfaX
         KCtmm8HvgmNDIyTB0D1qLMc3RMHfj63DJj4HAjWlW/DhD82ACyz1jjFu0W2MMu9ZbFbm
         4yeav/SXahikdt8M1oa7kTFP/uhLgjQn4NdwUHgP+7xCxzmMl+i5I/W5V9487VwEUge8
         cDDM7UhIcUdhpskUDSnsle4JJFdwMfPBzfAxQJKK4fWGuhit6S+ZhfGpJE7Ei9ItDwC5
         PgNA==
X-Forwarded-Encrypted: i=1; AKwUvBzcnCqHRgV7lJAC6viIN2aiFgcs6NZtmGgmKfhzhJszRlx2zFj8YN6fM+5TEqNbKmvo/vJiRS8=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJQO2UqFNPI6i7EcQ1rCNragyqi5KWKR/ykrda7WO+C9H9tTEAe
	oaOrbQ2AlQ531T/j5rlMrTRkIZJSPt9svmwxnKedQF3IThQxjTfE2BjbjayjXPzdH1AohN7qMzF
	9PBdQty5JMUFAQ2BeEcjGHFFdLSk/h7bwXWgDPi91TMLpNYU/F3offmCzlylMOdxqXFcP6Zo=
X-Gm-Gg: AYBFou3VT2r2yEJ9LF1CPi0aB2AXf42OU+ZJ7F0F8Y6B29u6VyhfBgaHjTYhzEYoAgG
	Zo3T/OQ08JrWzOqcPWnnsPK/Akjv3jCPJQdI3R0nCRpmv4TkAYZHPz6qFSzKllDFn3HnFcmsuYF
	xXCPBQtredur2xu0qJhBoJwXxnjk/PXhRJXS2wAGEGPLMiBGu8/9wZpynn+QmB8f8ARJtvP0A2F
	VhEieZiK08FYQbVPSrA5UvGvJ9sdgISbIqw2Xiw80pJVntwVw1m/sb8MzizSV101E8lfZGpJ5VM
	Eg6Bo409F2GtTZqtc1tFlzHI8Rii+4HOe/oPRwFIec5aRuvsHBQfswCZfvcPyHLsf9dT/jsB8lZ
	7J0qzVwGup9Qc8iGdY+yOe0dOY8dJWL7Y
X-Received: by 2002:a17:903:1b0e:b0:2e8:21a7:dd0a with SMTP id d9443c01a7336-2e842e0b04bmr1070245ad.63.1791501676132;
        Thu, 08 Oct 2026 16:21:16 -0700 (PDT)
X-Received: by 2002:a17:903:1b0e:b0:2e8:21a7:dd0a with SMTP id d9443c01a7336-2e842e0b04bmr1069975ad.63.1791501675602;
        Thu, 08 Oct 2026 16:21:15 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.12.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9d49af2sm145399a12.2.2026.10.08.16.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 16:21:14 -0700 (PDT)
Message-ID: <2a3b8bdb-0f75-40ca-a653-3e4d45c9d358@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 10:21:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/8] tee: optee: add RPMI backend support on RISC-V
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
 <CAGgiveXJXXaRNyfq6Gxk4moOHqM-vBuptugn5bHK5x9EeeGSQA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGgiveXJXXaRNyfq6Gxk4moOHqM-vBuptugn5bHK5x9EeeGSQA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8256c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9v5PfQ1E2GNzj2RibJmqVw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4N8_HuqegsxoWIsicYAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: anL7ymghq40pU6u-4ndbklVxWTVc8myK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA5MiBTYWx0ZWRfXxd26orlGwSYq
 wkfIWi1qGFhAEoiwikGAce/ETm7eSgT+bJwUlYJ8NCdWGXPuvSW4k5lowEmIfgYW3bhp1XvWAd5
 u1aXvf9dhM/EmKCa3rBWPHC/h1d16aogehqBHgBOapMllRhiopv/nTNTRpZZncCAk0g/bkHRwTf
 0w845UxRwjomvyF44ciMLugX9TkYQpXunVO6lB5gt9efv7DyhObKeBuz1x3BO3dqZ0rTOk7Eo82
 sDMY78S5yttP7ke3eodoS2WMw36xrAJDMIiYh/DqzfQTpkVbU4CdHUFlKZ/8hsfScbX0PQOIDu0
 WCIdF7ItIKZXoTYeVKR5YP0y22Z2snU9gN1jq45ZrJZK+ai8uxsdO53SSZWfd8A8pjekergDUsg
 mqqXlVLO7/3VH2vSsucdZTRdk4YbnGWEFVRDuzwdib0IDkLPS7C3RTcqA5sOEPNMHAjWsC5+h/i
 Utr4lC9XFJYm03VNDtg==
X-Proofpoint-ORIG-GUID: anL7ymghq40pU6u-4ndbklVxWTVc8myK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA5MiBTYWx0ZWRfX5yvS22p0jWD1
 bqRJgOZcm1bA823LhSp78Iu9HLBOdRRYDad7ZrM1ypmr3BZdQim3dUwaTqxS35c61GQuiEKtyJr
 WvDWlhaJwkNSpz2eaLmNUlXQhJ31OGA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080092
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6BA08450A1
X-Spamd-Bar: --
Message-ID-Hash: 6LJBLCV3FG2BCGSO457AG2M7UBV4EMZU
X-Message-ID-Hash: 6LJBLCV3FG2BCGSO457AG2M7UBV4EMZU
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marouene Boubakri <marouene.boubakri@oss.nxp.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6LJBLCV3FG2BCGSO457AG2M7UBV4EMZU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gMTAvOC8yMDI2IDU6MTUgUE0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0K
PiBIaSBBbWlyLA0KPiANCj4gT24gVHVlLCBPY3QgNiwgMjAyNiBhdCAyOjM54oCvQU0gQW1pcnJl
emEgWmFycmFiaQ0KPiA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToN
Cj4+DQo+PiBUaGlzIHNlcmllcyBhZGRzIGFuIFJQTUkgYmFja2VuZCB0byB0aGUgT1AtVEVFIGRy
aXZlciBmb3IgUklTQy1WLg0KPj4gSXQgYnVpbGRzIG9uIHRoZSBzZXBhcmF0ZWx5IHBvc3RlZCBS
UE1JIFRFRSB0cmFuc3BvcnQgc2VyaWVzIFsxXSwNCj4+IHdoaWNoIHByb3ZpZGVzIHNlcnZpY2Ug
ZGlzY292ZXJ5LCBzeW5jaHJvbm91cyBjYWxscywgbWVtb3J5IHBhcmNlbHMNCj4+IGFuZCBhc3lu
Y2hyb25vdXMgc2lnbmFscy4NCj4+DQo+PiBUaGlzIHJldmlzaW9uIGlzIGVmZmVjdGl2ZWx5IGEg
ZnVsbCByZXdyaXRlIG9mIHRoZSBvcmlnaW5hbCBSRkMuDQo+PiBUaGUgZ2VuZXJpYyBSUE1JIHRy
YW5zcG9ydCBoYXMgYmVlbiBzZXBhcmF0ZWQgZnJvbSB0aGUgT1AtVEVFIGJhY2tlbmQsDQo+PiBh
bmQgdGhlIGJhY2tlbmQgaGFzIGJlZW4gcmV3b3JrZWQgYXJvdW5kIHRoZSBzZXJ2aWNlIGJ1cyBh
bmQgYSBuZXcNCj4+IE9QLVRFRSBjb250cm9sIEFCSS4NCj4+DQo+PiBVbmxpa2UgdjEsIHRoZSBP
UC1URUUgYmFja2VuZCBubyBsb25nZXIgbWFuYWdlcyBTQkkgTVBYWSBtYWlsYm94DQo+PiBjaGFu
bmVscyBvciBpbXBsZW1lbnRzIFJQTUkgVEVFIHNlcnZpY2UtZ3JvdXAgb3BlcmF0aW9ucyBkaXJl
Y3RseS4NCj4+IEl0IGJpbmRzIHRvIHRoZSBPUC1URUUgc2VydmljZSBVVUlEIG9uIHRoZSBSUE1J
IFRFRSBidXMgYW5kIHVzZXMgdGhlDQo+PiB0cmFuc3BvcnQncyBwdWJsaWMgb3BlcmF0aW9ucy4g
Tm8gYWRkaXRpb25hbCBPUC1URUUgZGV2aWNlLXRyZWUgbm9kZQ0KPj4gaXMgcmVxdWlyZWQuDQo+
Pg0KPj4gVGhlIGJhY2tlbmQgcmV1c2VzIHRoZSBjb21tb24gT1AtVEVFIHNlc3Npb24sIHNoYXJl
ZC1tZW1vcnksIGFyZ3VtZW50DQo+PiBjYWNoZSwgY2FsbCBxdWV1ZSBhbmQgUlBDIGluZnJhc3Ry
dWN0dXJlLiBTaGFyZWQgbWVtb3J5IGlzIHJlcHJlc2VudGVkDQo+PiBieSBSUE1JIHBhcmNlbCBJ
RHMgYW5kIG5vbmNlcy4gWWllbGRpbmcgY2FsbHMgcGFzcyBjb21tYW5kIGFuZCBSUEMNCj4+IGJ1
ZmZlciByYW5nZXMgd2l0aGluIGEgcGFyY2VsIGFuZCByZXN1bWUgc3VzcGVuZGVkIGV4ZWN1dGlv
biB1c2luZw0KPj4gYW4gb3BhcXVlIHRva2VuIHJldHVybmVkIGJ5IE9QLVRFRS4NCj4+DQo+PiBU
aGUgT1AtVEVFIGNvbnRyb2wgQUJJIHVzZXMgZml4ZWQtd2lkdGggbGl0dGxlLWVuZGlhbiBtZXNz
YWdlcyBjYXJyaWVkDQo+PiBpbiBURUVfQ0FMTCBwYXlsb2FkcyByYXRoZXIgdGhhbiByZXByb2R1
Y2luZyBGRi1BJ3MgcmVnaXN0ZXItYmFzZWQNCj4+IG1lc3NhZ2UgbGF5b3V0LiBBc3luY2hyb25v
dXMgbm90aWZpY2F0aW9ucyB1c2UgYW4gYWxsb2NhdGVkIFRFRS10by1SRUUNCj4+IHNpZ25hbCBh
cyBhIGJvdHRvbS1oYWxmIGRvb3JiZWxsLCB3aGlsZSBvcmRpbmFyeSBsb2dpY2FsIG5vdGlmaWNh
dGlvbnMNCj4+IGNvbnRpbnVlIHRocm91Z2ggdGhlIGNvbW1vbiBSUEMgcGF0aC4NCj4+DQo+PiBN
YXRjaGluZyBPUC1URUUgT1Mgc3VwcG9ydCBmb3IgdGhpcyBBQkkgaGFzIG5vdCB5ZXQgYmVlbiBp
bXBsZW1lbnRlZC4NCj4+IFRoaXMgcmVtYWlucyBhbiBSRkMgZm9yIHJldmlldyBvZiB0aGUgYmFj
a2VuZCBpbnRlZ3JhdGlvbiBhbmQgdGhlDQo+PiBMaW51eC10by1PUC1URUUgcHJvdG9jb2wuDQo+
Pg0KPj4gWzFdIFJQTUkgVEVFIHRyYW5zcG9ydCBkZXBlbmRlbmN5Og0KPj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvb3AtdGVlLzIwMjYwOTI4LXJpc2N2LXJwbWktdGVlLWFiaS12MS0wLTA0OTA4
YjgxZDg4NUBvc3MucXVhbGNvbW0uY29tLw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFtaXJyZXph
IFphcnJhYmkgPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1YWxjb21tLmNvbT4NCj4+IC0tLQ0KPj4g
Q2hhbmdlcyBpbiB2MjoNCj4+IC0gRWZmZWN0aXZlbHkgcmV3cml0ZSB0aGUgYmFja2VuZCBhcm91
bmQgdGhlIHNlcGFyYXRlbHkgcG9zdGVkIFJQTUkNCj4+ICAgVEVFIHRyYW5zcG9ydCBhbmQgYSBu
ZXcgT1AtVEVFIGNvbnRyb2wgQUJJLg0KPj4gLSBSZW1vdmUgYmFja2VuZC1vd25lZCBwZXItaGFy
dCBtYWlsYm94IGNoYW5uZWxzIGFuZCB0aGUgT1AtVEVFLXNwZWNpZmljDQo+PiAgIGRldmljZS10
cmVlIGJpbmRpbmcuDQo+PiAtIFJlcGxhY2UgdGhlIHJlZ2lzdGVyLWxpa2UgY29udHJvbCBwYXls
b2FkIHdpdGggZml4ZWQtd2lkdGggbWVzc2FnZXMsDQo+PiAgIGV4cGxpY2l0IGNvbW1hbmQvUlBD
IGJ1ZmZlciByYW5nZXMgYW5kIG9wYXF1ZSByZXN1bWUgdG9rZW5zLg0KPj4gLSBBZGQgYSBwYXJj
ZWwtcmVmZXJlbmNlIHBhcmFtZXRlciBsYXlvdXQgY2FycnlpbmcgdGhlIHBhcmNlbCBJRCwNCj4+
ICAgbm9uY2UsIGFuZCA2NC1iaXQgb2Zmc2V0IGFuZCBzaXplIHdpdGhvdXQgY2hhbmdpbmcgcGFy
YW1ldGVyIHNpemUuDQo+PiAtIE1ha2UgYXJndW1lbnQtb2Zmc2V0IHN1cHBvcnQgcGFydCBvZiB0
aGUgYmFzZWxpbmUgQUJJIGFuZCByZXRhaW4NCj4+ICAgdGhlIGNvbW1vbiBzaGFyZWQgYXJndW1l
bnQgY2FjaGUuDQo+PiAtIFVzZSBhIHRyYW5zcG9ydC1hbGxvY2F0ZWQgc2lnbmFsIGZvciBhc3lu
Y2hyb25vdXMgYm90dG9tLWhhbGYNCj4+ICAgbm90aWZpY2F0aW9ucy4NCj4+IC0gTGluayB0byB2
MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDkxMi1ycG1pLXRlZS1zZXJ2aWNlLWdy
cC1kZXYtdjEtMC0xZDFkMzVjMmE4NTlAb3NzLnF1YWxjb21tLmNvbQ0KPj4NCj4+IC0tLQ0KPj4g
QW1pcnJlemEgWmFycmFiaSAoOCk6DQo+PiAgICAgICB0ZWU6IG9wdGVlOiBhbGxvdyBSUE1JIHRy
YW5zcG9ydCBidWlsZHMgb24gUklTQy1WDQo+PiAgICAgICB0ZWU6IG9wdGVlOiBkZWZpbmUgdGhl
IFJQTUkgY29udHJvbCBhbmQgcGFyY2VsLXJlZmVyZW5jZSBBQkkNCj4+ICAgICAgIHRlZTogb3B0
ZWU6IGFkZCBSUE1JIHNoYXJlZC1tZW1vcnkgYW5kIHBhcmFtZXRlciBzdXBwb3J0DQo+PiAgICAg
ICB0ZWU6IG9wdGVlOiBhZGQgUlBNSSBkeW5hbWljIHNoYXJlZC1tZW1vcnkgcG9vbA0KPj4gICAg
ICAgdGVlOiBvcHRlZTogYWRkIFJQTUkgUlBDIGhhbmRsaW5nDQo+PiAgICAgICB0ZWU6IG9wdGVl
OiBleGVjdXRlIHlpZWxkaW5nIFJQTUkgY2FsbHMNCj4+ICAgICAgIHRlZTogb3B0ZWU6IGJpbmQg
UlBNSSBzZXJ2aWNlcyBhbmQgbmVnb3RpYXRlIGJhY2tlbmQgY2FwYWJpbGl0aWVzDQo+PiAgICAg
ICB0ZWU6IG9wdGVlOiBzdXBwb3J0IFJQTUkgYXN5bmNocm9ub3VzIG5vdGlmaWNhdGlvbiBkb29y
YmVsbHMNCj4+DQo+PiAgZHJpdmVycy90ZWUvS2NvbmZpZyAgICAgICAgICAgICAgIHwgICAgMyAr
LQ0KPj4gIGRyaXZlcnMvdGVlL29wdGVlL0tjb25maWcgICAgICAgICB8ICAgIDMgKy0NCj4+ICBk
cml2ZXJzL3RlZS9vcHRlZS9NYWtlZmlsZSAgICAgICAgfCAgICAxICsNCj4+ICBkcml2ZXJzL3Rl
ZS9vcHRlZS9jYWxsLmMgICAgICAgICAgfCAgICAyICsNCj4+ICBkcml2ZXJzL3RlZS9vcHRlZS9j
b3JlLmMgICAgICAgICAgfCAgIDEwICstDQo+PiAgZHJpdmVycy90ZWUvb3B0ZWUvb3B0ZWVfbXNn
LmggICAgIHwgICAzOCArLQ0KPj4gIGRyaXZlcnMvdGVlL29wdGVlL29wdGVlX3ByaXZhdGUuaCB8
ICAgNTQgKy0NCj4+ICBkcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9ycG1pLmggICAgfCAgMjM0ICsr
KysrKysrDQo+PiAgZHJpdmVycy90ZWUvb3B0ZWUvcnBtaV9hYmkuYyAgICAgIHwgMTA1OSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgOSBmaWxlcyBjaGFuZ2VkLCAx
Mzg5IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCj4gVGhlIHJwbWkgY2hhbmdl
cyBpbiB0aGUgb3B0ZWUgZHJpdmVyIGhhcm1vbml6ZSBxdWl0ZSB3ZWxsIHdpdGggdGhlDQo+IHJl
c3Qgb2YgdGhlIGRyaXZlciwgYnV0IHRoZXJlIGFyZSB0d28gdGhpbmdzIEknZCBsaWtlIGZpeGVk
Og0KPiAtIGF2b2lkIDxsaW51eC9jbGVhbnVwLmg+IG1hY3Jvcy4gVGhleSBhcmUgZGlzdHJhY3Rp
bmcuDQo+IC0gdXNlIHJjIGZvciB0aGUgdHJpdmlhbCBpbnQgRVJSTk8gdmFsdWVzLg0KPiANCg0K
SSdsbCBtYWtlIHRoZXNlIGNoYW5nZXMuDQoNCj4gSSB3b3VsZCBiZSBncmVhdCB3aXRoIGEgUUVN
VS1iYXNlZCBlbmQtdG8tZW5kIHByb3RvdHlwZSB0byBkZW1vbnN0cmF0ZQ0KPiB0aGF0IHRoZSBB
Qkkgd29ya3MuDQo+IA0KDQpUaGUgT1AtVEVFIHNpZGUgaW1wbGVtZW50YXRpb24gaXMgbmVhcmx5
IGNvbXBsZXRlLiBJJ2xsIGluY29ycG9yYXRlIHlvdXINCmNvbW1lbnRzIGhlcmUgYW5kIHVwZGF0
ZSB0aGUgT1AtVEVFIGNvZGUgYWNjb3JkaW5nbHkuIEkgaGF2ZW4ndCBzdGFydGVkDQp0aGUgT3Bl
blNCSSBjaGFuZ2VzIHlldC4gR2V0dGluZyBhIFFFTVUtYmFzZWQgZW5kLXRvLWVuZCBwcm90b3R5
cGUgd29ya2luZw0KaXMgbXkgZmlyc3QgcHJpb3JpdHkgYmVmb3JlIG1vdmluZyB0aGUgc2VyaWVz
IG91dCBvZiBSRkMuDQoNCkFwb2xvZ2llcyBmb3IgdGhlIG9idmlvdXMgb3ZlcnNpZ2h0cyBhbmQg
YnVncyBpbiB0aGlzIHZlcnNpb24uIFNvIGZhciwNCkkndmUgb25seSBjb21waWxlLXRlc3RlZCB0
aGUgY29kZTsgaXQgc3RpbGwgbmVlZHMgZW5kLXRvLWVuZCB2YWxpZGF0aW9uLg0KDQo+IE1vcmUg
Y29tbWVudHMgdG8gY29tZSBpbiB0aGUgaW5kaXZpZHVhbCBwYXRjaGVzLg0KDQpUaGFua3MsIEpl
bnMsIGZvciB0aGUgZWFybHkgY29tbWVudHMgYW5kIGZlZWRiYWNrLiBUaGV5IGFyZSB2ZXJ5IGhl
bHBmdWwNCmluIHNoYXBpbmcgdGhlIGZpbmFsIGNvZGUgYW5kIGd1aWRpbmcgdGhlIGRpcmVjdGlv
biBvZiB0aGUgaW1wbGVtZW50YXRpb24uDQoNCkJlc3QgcmVnYXJkcywNCkFtaXINCg0KPiANCj4g
Q2hlZXJzLA0KPiBKZW5zDQoNCg==
