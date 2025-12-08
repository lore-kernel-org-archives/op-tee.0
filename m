Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE0DCEBF88
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 05:24:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BAE3D500AC
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 05:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765171476;
	bh=8mHF1dmjxZD7G4HS70//qV/o8scvHHAtIV1hPdXzGXY=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xpn51DMmWpBzBlSZH1x8v6lRZwXa1HWtmdruZWnKFe+rybvOd2KPZDtPwb9wHnE6y
	 O3tmxTg2KUnVqUAtH/z5Dw3IHSq6bZ7rWRQgVdnM7ln+8bDZbJDYxyBYQt6UHlsHor
	 60EelxRpN8dglDN5IzsfMT5jyWf5dsx2MTlDC5GDKn5ijcEcQFdz7HQVVQWWr9+t/o
	 uirUfW4y+j8wgbObjA/nLGmJ+NvXy1jr/Zyfv3rwuGjigNm5bfMpnEiStjOuS9b5mF
	 Za/1kRI42sFj8Asl/KvjHcdw4IP2bL/snRl11VEtxyDfU2g9XWaATi5qnlOIbVap10
	 JmWBUZokbuqLw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DFB42431B3
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Dec 2025 05:24:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ApOVx5ly;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UzeU1SIY;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7Mi5xv3401259
	for <op-tee@lists.trustedfirmware.org>; Mon, 8 Dec 2025 05:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CTFDaI0X2upqE8C3ur4iiWVf3TE03Gdd/FG9zE6s/AM=; b=ApOVx5lyNdoxDrd8
	Xi0d3GljU5ydMHmXVOdvIsNWuswRKmAi8ICo2Y0xNGnku/zlr9cRkD6grk0pdj1/
	uQ4IYNWOFf8RpAlBDCLBdhzmVOvb2dzLBEJyEKwJ3D0zJq4AUqwods99QHu9recL
	bdd6g6KVILVvFDVQ4f/jysJzUcVjTDspzVMIcBGhukLDE4gauWHVFedSLWeTHpHg
	80tVsBsZI6Jw087vT+6pa6PuORvs+6r0LRp6+7rlRl40fQj7ixOzsJoYpRTcD2L1
	Cn8dzbMKh1WPFFaFFxPqMxQdo5jbP7+1Z84OUu7xaoPhFqRBagjxrsCIJU1y0kPo
	HLDJ1Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avcv83msq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 05:24:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29845b18d1aso75790685ad.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 07 Dec 2025 21:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765171464; x=1765776264; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTFDaI0X2upqE8C3ur4iiWVf3TE03Gdd/FG9zE6s/AM=;
        b=UzeU1SIYRO4ms4hFLGQ8hPpvbR52JKwT+mMVIKudRBcPIRW3V5X9tZ8azTEi+0jsnO
         oUfeJ75ms2UKorP7D6HTb4wsnZ3P1nPyqDMd+ZdWeq2b1eFtjwIm7z2FbK9Ca0XrhZHj
         cx/SarpQZq8HTNq9V6T4JwrjQ1TI5SFgyBPoFBQ/cjpdus/55QA1x7woYAfId2bqUSO0
         5TEJcBfsGLWB9UufxevH7M8q8UXOJuh/MUq2IeFwWNFW6a8uKiY6YXq9Vkf3+UaP/6Sv
         4LsTbGheLoXB+n0jTYCbvGf0KRcd1dHaODotGAC7dttuBxzPUHmf5/j1HiG6itrwFFkA
         oZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765171464; x=1765776264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTFDaI0X2upqE8C3ur4iiWVf3TE03Gdd/FG9zE6s/AM=;
        b=dtdsahcg84uksfFTNoNUe5IIVTwrZm47b75j+8Po5tKlw7tfp14+J1saPqTQai3PGo
         CDxis1ikF2xRqaveipMsUZXGUQ79wBnQypkeaxNXVve3eX2qt9g1UVDx0OGp3u2ckZ6P
         qRlAcnxPA8xZo7TXdcEMhPqzxo+N11NIFFKgV+36rBxoXCGIMflnhkrdg5TUIb9dkEvR
         14rQS4gW3ICA4k+gLq/NA508feTKhDqrFAx62LVbeqFZj3H4fxaKdlsDPWREzhak9cRU
         kV8xPcDt+tWWqop9qWmUu9DIHE8WmFvv0kOq65kN27OhwnmQKDjN31r7/O0PmU7n+zPa
         M+EA==
X-Forwarded-Encrypted: i=1; AJvYcCXJk0/M99mYbIZDpnXPnQWpsTciMr/QBshLA6qlgzNpOaeqcVYaN/YOfawD5zGlGtceHvWnNxE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwCidoB1S+RtFpgjH4ouamsNhrPrtr/+f5kpjvJn67xJsB+Y47g
	zpDrV9vnsqofhd5kGxfuV27+u36CeqgAbsR4z286l4/4W352PUo6w0eF6gqQXuPJvrFevqLRypj
	W5eEuWh/Ej3fJRTe4NeD3t59WgiYhVNNdweMhF/dDnLhFl81fIeBGo5H5aSgwaYyBZfmRLxXM3I
	YgXTY=
X-Gm-Gg: ASbGncsbS8WHwHO63652Y0lQK3ggoesg/MdedbeZRmJbWZ+X5vybcHHK4Yi4L2RFIAc
	CejH9ttm+e92WdX0JVV9j7vujQyxy3Ppi67VvrTZpaqZVp0kIA+J1PcPk7dICHWCP8cIcGdNycj
	PUEzOHRtL7Xdjs70akwDW+n8hBFTlrsMzKkzMzltbMS1J5d6W/uLkBtC8t1pxlk53lTh/XF1Caq
	lZ2/zvnlIBZVxpd9ocRvaQHvJyM5xXcYCeIaCVD4sEWuw/MYBeQWo1z/LJFo6AJTVxJso9wgBa9
	js+RXCNoTVRJCxNJ+stci68Jmp7It4cGyykZQXhQnHfDqVHg/k4Yf/Y/NPyMOaxNdsAPQ7hs1lY
	rBVh+Lxi70+pL3F/hP8emCUy7aaqZuHMTRP2slGGF88fOXcKAYu8b+b/OsiKD2oKGBBQOTaHxP/
	NcbfGvICg=
X-Received: by 2002:a17:902:f693:b0:248:ff5a:b768 with SMTP id d9443c01a7336-29df5571f2dmr58562725ad.10.1765171463895;
        Sun, 07 Dec 2025 21:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTwo90BTgSEMEr4il9ifC75dGqZTYMnmBFNNwzpfJCfnl95G5gnFXZV8agR/+7hCFVjz8BVw==
X-Received: by 2002:a17:902:f693:b0:248:ff5a:b768 with SMTP id d9443c01a7336-29df5571f2dmr58562465ad.10.1765171463383;
        Sun, 07 Dec 2025 21:24:23 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaac16fsm109803545ad.87.2025.12.07.21.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 21:24:22 -0800 (PST)
Message-ID: <0b061075-ab71-4ac1-93ec-438ddaaec903@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 16:24:17 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>
References: <20251204101730.1036671-1-arnd@kernel.org>
 <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: K6pyHUN59PgUgNNvYqvZPyV61iYxSoHJ
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69366109 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=xFIYUFTxM1JpX5VCbgAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA0MyBTYWx0ZWRfXwGSKCUjnKqFp
 WnJmhoWp49czXZOR9DOvMFSqmgOPvQwviy1bQYHIa9ZGzctR4GWcddODGYOo3R3RH7pdt9nAnUr
 LYFv6DPVt3FVfpICmY0uT5+s2p1gJ1n75NtkHZ6VqAfgI76ePC5EJ45rnYjhyFUr/VsTBGsj67i
 NnO3zUMZrPREt8M2zMHPkDiXWVZKIwHa+KFsWZNiiwgx5FbredodINAhyujriTUiKml/NTUHsbU
 NzxxMKRM2pvHgzJzWX4MDu6GNIFdndzYDEo0hGCFOANcGrmr38GWHzkGU6R5cFIFhQgs/cOIwZY
 FU3LUwzIwF1u2mBrhhBq+JoBcYFSU5FEA4Cy4kw9CuVXm0rA2Gjowkw5UE/Aoo+TnbIacw23KSx
 FytMKBo8HARcPTuOlpT6gZYUUFtIIQ==
X-Proofpoint-GUID: K6pyHUN59PgUgNNvYqvZPyV61iYxSoHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080043
X-Spamd-Bar: ------
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DFB42431B3
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: 225Z7OCJJWWZP26JMCRK4UV7YFQZHWXL
X-Message-ID-Hash: 225Z7OCJJWWZP26JMCRK4UV7YFQZHWXL
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Sumit Garg <sumit.garg@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/225Z7OCJJWWZP26JMCRK4UV7YFQZHWXL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGksDQoNCk9uIDEyLzUvMjAyNSAxMjoyNyBBTSwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+IEhp
LA0KPiANCj4gT24gVGh1LCBEZWMgNCwgMjAyNSBhdCAxMToxN+KAr0FNIEFybmQgQmVyZ21hbm4g
PGFybmRAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pg0KPj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJu
ZEBhcm5kYi5kZT4NCj4+DQo+PiBUaGUgdGVlX2lvY3RsX29iamVjdF9pbnZva2VfYXJnIHN0cnVj
dHVyZSBoYXMgcGFkZGluZyBvbiBzb21lDQo+PiBhcmNoaXRlY3R1cmVzIGJ1dCBub3Qgb24geDg2
LTMyIGFuZCBhIGZldyBvdGhlcnM6DQo+Pg0KPj4gaW5jbHVkZS9saW51eC90ZWUuaDo0NzQ6MzI6
IGVycm9yOiBwYWRkaW5nIHN0cnVjdCB0byBhbGlnbiAncGFyYW1zJyBbLVdlcnJvcj1wYWRkZWRd
DQo+Pg0KPj4gSSBleHBlY3QgdGhhdCBhbGwgY3VycmVudCB1c2VycyBvZiB0aGlzIGFyZSBvbiBh
cmNoaXRlY3R1cmVzIHRoYXQgZG8NCj4+IGhhdmUgaW1wbGljaXQgcGFkZGluZyBoZXJlIChhcm02
NCwgYXJtLCB4ODYsIHJpc2N2KSwgc28gbWFrZSB0aGUgcGFkZGluZw0KPj4gZXhwbGljaXQgaW4g
b3JkZXIgdG8gYXZvaWQgc3VycHJpc2VzIGlmIHRoaXMgbGF0ZXIgZ2V0cyB1c2VkIGVsc2V3aGVy
ZS4NCj4+DQo+PiBGaXhlczogZDViOGIwZmExNzc1ICgidGVlOiBhZGQgVEVFX0lPQ1RMX1BBUkFN
X0FUVFJfVFlQRV9PQkpSRUYiKQ0KPj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJu
ZEBhcm5kYi5kZT4NCj4+IC0tLQ0KPj4gVGhlIG5ldyBpbnRlcmZhY2Ugc2hvd2VkIHVwIGluIDYu
MTgsIGJ1dCBJIG9ubHkgY2FtZSBhY3Jvc3MgdGhpcyBhZnRlcg0KPj4gdGhhdCB3YXMgcmVsZWFz
ZWQuIENoYW5naW5nIGl0IG5vdyBpcyB0ZWNobmljYWxseSBhbiBBQkkgY2hhbmdlIG9uDQo+PiBh
cmNoaXRlY3R1cmVzIHdpdGggdW51c3VhbCBwYWRkaW5nIHJ1bGVzLCBzbyBwbGVhc2UgY29uc2lk
ZXIgY2FyZWZ1bGx5DQo+PiB3aGV0aGVyIHdlIHdhbnQgdG8gZG8gaXQgdGhpcyB3YXkgb3Igbm90
Lg0KPj4NCj4+IFdvcmtpbmcgYXJvdW5kIHRoZSBBQkkgZGlmZmVyZW5jZXMgd2l0aG91dCBhbiBB
QkkgY2hhbmdlIGlzIHBvc3NpYmxlLA0KPj4gYnV0IGFkZHMgYSBsb3Qgb2YgY29tcGxleGl0eSBm
b3IgY29tcGF0IGhhbmRsaW5nLg0KPiANCj4gVGhpcyBpcyBjdXJyZW50bHkgb25seSB1c2VkIGJ5
IHRoZSByZWNlbnRseSBpbnRyb2R1Y2VkIHFjb210ZWUgYmFja2VuZA0KPiBkcml2ZXIuIFNvIGl0
J3Mgb25seSB1c2VkIG9uIGEgZmV3IGFybTY0IFF1YWxjb21tIHBsYXRmb3JtcyByaWdodCBub3cu
DQo+IA0KPiBJIHRoaW5rIHdlIHNob3VsZCB0YWtlIHRoaXMgcGF0Y2gsIGJ1dCBsZXQncyBoZWFy
IHdoYXQgb3RoZXJzIHRoaW5rLg0KPiANCj4gVGhhbmtzLA0KPiBKZW5zDQo+IA0KDQpJIGFncmVl
LiBXZSBzaG91bGQgdGFrZSB0aGlzIHBhdGNoLiBBcyBub3RlZCwgdGhlcmUgYXJlIG5vdCBtYW55
DQpjbGllbnRzIHJlbHlpbmcgb24gaXQgeWV0LCBzbyB1cGRhdGluZyB0aGUgdXNlcnNwYWNlIHNo
b3VsZA0KYmUgc3RyYWlnaHRmb3J3YXJkLg0KDQpCZXN0IFJlZ2FyZHMsDQpBbWlyDQoNCj4+IC0t
LQ0KPj4gIGluY2x1ZGUvdWFwaS9saW51eC90ZWUuaCB8IDEgKw0KPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgv
dGVlLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdGVlLmgNCj4+IGluZGV4IGNhYjVjYWRjYThlZi4u
NTIwMzk3N2VkMzVkIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3RlZS5oDQo+
PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdGVlLmgNCj4+IEBAIC00NzAsNiArNDcwLDcgQEAg
c3RydWN0IHRlZV9pb2N0bF9vYmplY3RfaW52b2tlX2FyZyB7DQo+PiAgICAgICAgIF9fdTMyIG9w
Ow0KPj4gICAgICAgICBfX3UzMiByZXQ7DQo+PiAgICAgICAgIF9fdTMyIG51bV9wYXJhbXM7DQo+
PiArICAgICAgIF9fdTMyIDozMjsNCj4+ICAgICAgICAgLyogbnVtX3BhcmFtcyB0ZWxscyB0aGUg
YWN0dWFsIG51bWJlciBvZiBlbGVtZW50IGluIHBhcmFtcyAqLw0KPj4gICAgICAgICBzdHJ1Y3Qg
dGVlX2lvY3RsX3BhcmFtIHBhcmFtc1tdOw0KPj4gIH07DQo+PiAtLQ0KPj4gMi4zOS41DQo+Pg0K
DQo=
