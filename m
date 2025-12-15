Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C7AD5B868
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 20:30:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7B24A4FEB0
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765830624;
	bh=HvzsNJPjWWvzAG1q9RU4IXwVi/ho44w9G3aSGvw4ShM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Kcbh9klTChHs4U1UnlVtBR2QIMVFE0YS3Vlp/cmcBF0ud4/1Rgc5nl/DQKc23EW/b
	 m0L1ZRoHXZVrH8MZ8CsDpg8XQFzOoIb7OcW8/JY06g+oGw8cSmjW+hfMD1AkTKnMo/
	 9dkwb6uCmARezkegJ3Aztip0+FNOiFjAQ9ugAR4RHEEJ3SaYkHs+gKn9Zh9U4WbLii
	 JkG0YZ67v/1lp2tr/sTur4VVVIqK0NCcZPVHeX9h+Sg2nW8CB5f7g2L4o/Sdk8JJNB
	 rBivf6z+r615jYPxoGRdOD9OM2TliWbJE64YkmIxKr9oAufSoj5UmC9fo3K7/1MtGR
	 Bf3xJo1IwWIVQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 059BF43227
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 20:29:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K62X/Rcq;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VQdVIQb1;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFBT30H189677
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 20:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AdHUrbzRU+2iOQL7jj1DnvC8e49pGzQ7IhirsARXhWA=; b=K62X/RcqXg48HTKd
	NfXkZJh6y8OXVD5fo15N5wGTcAiwLAmqk/cAdBhEv57UKaYTO5m7kOzoJxjOjrl/
	QLOKL0e684guMrdWApTkhXhskg80m6FEDSqYxOdJguMWq0iis9RPhoRhIjQwdyCZ
	D8OEmRX9AC4LhhFUSD9D4ELGQIGjGwrNM3m6dS+wsf7BXXy+IQQvZcuZY2lt/dNQ
	ytZOizpXmHZQI+DGHwgBZXb/ohZL+ckPLEWuU5JfVL+aXTgwFKaM3SQg11kFhkuF
	pBXqJ2sgJURn13TrS3PGVjpNq4Yhd3Esq2lBBtgbxdjIsU2V1Da/5fsme8umD540
	9pB01g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2hgasgke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 20:29:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0f4822f77so38585625ad.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 12:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765830598; x=1766435398; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdHUrbzRU+2iOQL7jj1DnvC8e49pGzQ7IhirsARXhWA=;
        b=VQdVIQb17FlRoPTsfNOFCcFFxDHoyF4+jVM5Vc06E42S8kFHMz+kaNoadinU5vwOMj
         wl7lb0KQ82bnuXlSFUYXdvb93+0BSkQoPN6g6Ho2YliF6FCaYzYXM1Wo3TTotySTdK5N
         nQLUJNLVKgNc1ij7XO5NXAodT+SKx4MN5dUg7IXw6hxcfbM4ek6E8bW+Kw5hUl5AqADK
         JFvEOhtDuwFiX/S71iv16tuWTZmqtPv9+YYOr2nsj03bT4/Zv3F6s/nf5+6w24ubJujI
         faIlr1PGPybDkO1PpM0FTlZvjHO3gf5eSw7tEx6uWf22tbVIBIt3hq1FiL3XLlJ8SSk3
         U32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765830598; x=1766435398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdHUrbzRU+2iOQL7jj1DnvC8e49pGzQ7IhirsARXhWA=;
        b=eVco8+bRcP9tMIjKgn9tAmtw5NpGUxBS7mcegpugvbGZto1LWDFxv4BHXQLzomLHiP
         8Xdw4k2zk/Cx7TvUoBSlSWVAublLdqsIt5K2gMpHDGFPXMTe45EKXxY+PCBK6iOrzPy9
         6Xl0LuQVP8+0/0fnEsaOcTzcnyTZvc2Go0J/+D9UkIJzv6bD58SnDeRhBvbDu/Metq2w
         AS0/6vzR/kNGMqWOaNT8MQJUThfN8eSCssBX5GHcwheoijiE3nwieV32aYx6RsqHZV1F
         vww+tvzHowGhOUxM30TDQiEocCQiDr8hdpSHI8IaDxGWeO4EGRtdMH9uVRceWHPcd+IJ
         0Vrw==
X-Forwarded-Encrypted: i=1; AJvYcCV67yNDvU/RDw616kov7QxQpggP3ux/nM6LHwx/Or2RaNofESb/37udD/0Jqll57g4pYotuodE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx0e/6d/UEbyLlJvOv+66Az4ji85HiM3P+Nbi3MhB0thPCiSYC6
	Q+a+ypiCEhJn/i2Y1qxd8xMtybTzs8ScoUl190W9M1U2y+p/NTqzM2XW2QYdWkQTpJ5YxGqGPL4
	1CD2CZAhVzXJhyLnQRk1sN7EZOEsF0bTOwa/o7VkLP7dM23y1uh5o5Ve83ZXYdqndkA1cjPI=
X-Gm-Gg: AY/fxX4d8UDIzegTTPmgvWRzDRjbncIBCJFVzP0MJR8VeiSeh/h5N2ktxefOgpcEbn2
	j8kqsP+VDcJlVSPBqFjbPCnmLNLn/5tV/eZMLkdn/ai0ZiabU/oXFUwNqPT/WRtzc2NKwvZl3eS
	YiQSWHSwJRHSiWHLz/LItNRhmDohl5l9f1FGTIyppP7LfBReieedIXj/nbZjdNRFB2pEqPpXDkm
	pw5guF6P6P4wdPiEotdZIIpJR6/B4JHxsi2oTIRs0bRTA5NNLCHUAoGuHUGsakHz/WGbpsHYL3o
	PW4Ptzjh94AePBhR1hey1Iw15gi8LqdE15MzKvBc32MNimf0oNltJC2vfBOV+FGPklMA5eSM38s
	H+ADB6nIcU80r5Xpug6K+iKjQYetGBrra9jd0TVqHb4bW3INm6iix0f+WKeQJpKdHrLNTerzGsi
	UildeIvP8=
X-Received: by 2002:a17:903:1446:b0:29f:1bf:642a with SMTP id d9443c01a7336-29f23de65aamr119690935ad.12.1765830598364;
        Mon, 15 Dec 2025 12:29:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbLjkylsmyRwrHSNZTaMSJ6bc9jwOTTSizTr9ct6fx53bTXcMlO0MTyK687LScueoET+tS2A==
X-Received: by 2002:a17:903:1446:b0:29f:1bf:642a with SMTP id d9443c01a7336-29f23de65aamr119690685ad.12.1765830597859;
        Mon, 15 Dec 2025 12:29:57 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a090863c87sm79771515ad.47.2025.12.15.12.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 12:29:57 -0800 (PST)
Message-ID: <7b074ee0-4f10-4fba-9680-3d87dcf766c1@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 07:29:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
To: Sumit Garg <sumit.garg@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
 <aTtn-x0hh18V7n7J@sumit-X1>
 <b29c97cd-cade-40ef-8e6d-d164b1d16059@oss.qualcomm.com>
 <aTtyR5J3AqXoE7to@sumit-X1>
Content-Language: en-US
In-Reply-To: <aTtyR5J3AqXoE7to@sumit-X1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 3ri9cF-5Vqq7N2AWKesC9Ny8aYZcNzBv
X-Proofpoint-ORIG-GUID: 3ri9cF-5Vqq7N2AWKesC9Ny8aYZcNzBv
X-Authority-Analysis: v=2.4 cv=GpxPO01C c=1 sm=1 tr=0 ts=69406fc7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=DitlKc5lTLw6aypijOUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDE3NiBTYWx0ZWRfXxVpm1+fBEU5W
 AKBhpmriXCs/lLMhkOntr+movl3bcMyX0iiWzq7ylBwgJhsbx0upC8DpVWerhCLpdcUT24oPZ3O
 suiaXKVBUyrSEw2Vyt9hqN88XK1T6FkkQ/2R5Z2jzyh5l3TGuvBY5F71Z+Kjq/tBEWcQZaPkevx
 sP5gntUxjY8/SbjoIijV4kDe7vDmHRIjZhRZTqdb3rfcklYWL2bk+Fhc8Fj7TanNdOr9UDGDDby
 RBf9m2RHAXFjwSi0g2zbtryLQ5++Ey+fsXPNdTxEGvB4QIJ2jjK5fevigREu0ZjhpT6q2bwMnEm
 rv/xnDXLoBkIQN5cE40nz28EMplgycBVmOFkO14oxI1bLSgDn3Gka5wKl8c1UuicOX2pwEBXYrs
 m+i9QgwzXcmDXRsn1Ja1rZEaKYWPGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150176
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	MIME_TRACE(0.00)[0:+];
	BLOCKLISTDE_FAIL(0.00)[205.220.180.131:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 059BF43227
X-Spamd-Bar: ------
Message-ID-Hash: WC2GZNGL2Z3RFHPU66YW4653236GO2R5
X-Message-ID-Hash: WC2GZNGL2Z3RFHPU66YW4653236GO2R5
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WC2GZNGL2Z3RFHPU66YW4653236GO2R5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGksDQoNCk9uIDEyLzEyLzIwMjUgMTI6MzkgUE0sIFN1bWl0IEdhcmcgd3JvdGU6DQo+IE9uIEZy
aSwgRGVjIDEyLCAyMDI1IGF0IDAyOjA3OjQwQU0gKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+PiBPbiAxMi8xMi8yMDI1IDAxOjU1LCBTdW1pdCBHYXJnIHdyb3RlOg0KPj4+IE9u
IE1vbiwgRGVjIDA4LCAyMDI1IGF0IDAzOjA4OjQ1QU0gKzAxMDAsIEtyenlzenRvZiBLb3psb3dz
a2kgd3JvdGU6DQo+Pj4+IEluaXRpYWxpemluZyBhdXRvbWF0aWMgX19mcmVlIHZhcmlhYmxlcyB0
byBOVUxMIHdpdGhvdXQgbmVlZCAoZS5nLg0KPj4+PiBicmFuY2hlcyB3aXRoIGRpZmZlcmVudCBh
bGxvY2F0aW9ucyksIGZvbGxvd2VkIGJ5IGFjdHVhbCBhbGxvY2F0aW9uIGlzDQo+Pj4+IGluIGNv
bnRyYXJ5IHRvIGV4cGxpY2l0IGNvZGluZyBydWxlcyBndWlkaW5nIGNsZWFudXAuaDoNCj4+Pj4N
Cj4+Pj4gIkdpdmVuIHRoYXQgdGhlICJfX2ZyZWUoLi4uKSA9IE5VTEwiIHBhdHRlcm4gZm9yIHZh
cmlhYmxlcyBkZWZpbmVkIGF0DQo+Pj4+IHRoZSB0b3Agb2YgdGhlIGZ1bmN0aW9uIHBvc2VzIHRo
aXMgcG90ZW50aWFsIGludGVyZGVwZW5kZW5jeSBwcm9ibGVtIHRoZQ0KPj4+PiByZWNvbW1lbmRh
dGlvbiBpcyB0byBhbHdheXMgZGVmaW5lIGFuZCBhc3NpZ24gdmFyaWFibGVzIGluIG9uZSBzdGF0
ZW1lbnQNCj4+Pj4gYW5kIG5vdCBncm91cCB2YXJpYWJsZSBkZWZpbml0aW9ucyBhdCB0aGUgdG9w
IG9mIHRoZSBmdW5jdGlvbiB3aGVuDQo+Pj4+IF9fZnJlZSgpIGlzIHVzZWQuIg0KPj4+Pg0KPj4+
PiBDb2RlIGRvZXMgbm90IGhhdmUgYSBidWcsIGJ1dCBpcyBsZXNzIHJlYWRhYmxlIGFuZCB1c2Vz
IGRpc2NvdXJhZ2VkDQo+Pj4+IGNvZGluZyBwcmFjdGljZSwgc28gZml4IHRoYXQgYnkgbW92aW5n
IGRlY2xhcmF0aW9uIHRvIHRoZSBwbGFjZSBvZg0KPj4+PiBhc3NpZ25tZW50Lg0KPj4+DQo+Pj4g
T2theSBJIHNlZSBidXQuLg0KPj4+DQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRv
ZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+ICBkcml2ZXJzL3RlZS9xY29tdGVlL2NhbGwuYyB8IDE3ICsrKysrKysrLS0tLS0t
LS0tDQo+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMgYi9k
cml2ZXJzL3RlZS9xY29tdGVlL2NhbGwuYw0KPj4+PiBpbmRleCA2NWY5MTQwZDRlMWYuLjhmODgz
MGYwZGYyNiAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMNCj4+
Pj4gKysrIGIvZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMNCj4+Pj4gQEAgLTM5NSw5ICszOTUs
NyBAQCBzdGF0aWMgaW50IHFjb210ZWVfb2JqZWN0X2ludm9rZShzdHJ1Y3QgdGVlX2NvbnRleHQg
KmN0eCwNCj4+Pj4gIAkJCQkgc3RydWN0IHRlZV9pb2N0bF9vYmplY3RfaW52b2tlX2FyZyAqYXJn
LA0KPj4+PiAgCQkJCSBzdHJ1Y3QgdGVlX3BhcmFtICpwYXJhbXMpDQo+Pj4+ICB7DQo+Pj4+IC0J
c3RydWN0IHFjb210ZWVfb2JqZWN0X2ludm9rZV9jdHggKm9pYyBfX2ZyZWUoa2ZyZWUpID0gTlVM
TDsNCj4+Pj4gIAlzdHJ1Y3QgcWNvbXRlZV9jb250ZXh0X2RhdGEgKmN0eGRhdGEgPSBjdHgtPmRh
dGE7DQo+Pj4+IC0Jc3RydWN0IHFjb210ZWVfYXJnICp1IF9fZnJlZShrZnJlZSkgPSBOVUxMOw0K
Pj4+PiAgCXN0cnVjdCBxY29tdGVlX29iamVjdCAqb2JqZWN0Ow0KPj4+PiAgCWludCBpLCByZXQs
IHJlc3VsdDsNCj4+Pj4gIA0KPj4+PiBAQCAtNDEyLDEyICs0MTAsMTQgQEAgc3RhdGljIGludCBx
Y29tdGVlX29iamVjdF9pbnZva2Uoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgsDQo+Pj4+ICAJfQ0K
Pj4+PiAgDQo+Pj4+ICAJLyogT3RoZXJ3aXNlLCBpbnZva2UgYSBRVEVFIG9iamVjdDogKi8NCj4+
Pj4gLQlvaWMgPSBxY29tdGVlX29iamVjdF9pbnZva2VfY3R4X2FsbG9jKGN0eCk7DQo+Pj4+ICsJ
c3RydWN0IHFjb210ZWVfb2JqZWN0X2ludm9rZV9jdHggKm9pYyBfX2ZyZWUoa2ZyZWUpID0NCj4+
Pj4gKwkJcWNvbXRlZV9vYmplY3RfaW52b2tlX2N0eF9hbGxvYyhjdHgpOw0KPj4+PiAgCWlmICgh
b2ljKQ0KPj4+PiAgCQlyZXR1cm4gLUVOT01FTTsNCj4+Pj4gIA0KPj4+PiAgCS8qICsxIGZvciBl
bmRpbmcgUUNPTVRFRV9BUkdfVFlQRV9JTlYuICovDQo+Pj4+IC0JdSA9IGtjYWxsb2MoYXJnLT5u
dW1fcGFyYW1zICsgMSwgc2l6ZW9mKCp1KSwgR0ZQX0tFUk5FTCk7DQo+Pj4+ICsJc3RydWN0IHFj
b210ZWVfYXJnICp1IF9fZnJlZShrZnJlZSkgPSBrY2FsbG9jKGFyZy0+bnVtX3BhcmFtcyArIDEs
IHNpemVvZigqdSksDQo+Pj4+ICsJCQkJCQkgICAgICBHRlBfS0VSTkVMKTsNCj4+Pg0KPj4+IC4u
dGhpcyBtYWtlcyB0aGUgY29kZSBsZXNzIHJlYWRhYmxlIHdpdGggdmFyaWFibGUgZGVjbGFyYXRp
b25zIGZsb2F0aW5nDQo+Pg0KPj4gV2hpY2ggaXMgaW50ZW50aW9uYWwuDQo+Pg0KPj4+IHdpdGhp
biB0aGUgZnVuY3Rpb24uIEkgd291bGQgcmF0aGVyIGZhdm9yIHRvIG5vdCB1c2UgdGhlIGNsZWFu
dXAuaCBjb25zdHJ1Y3QNCj4+PiBidXQgdXNlIGV4cGxpY2l0IGtmcmVlKCkgaW52b2NhdGlvbnMg
aW5zdGVhZCBsaWtlIGl0J3MgZG9uZSBpbiBhbGwgb3RoZXINCj4+PiBhbGxvY2F0aW9ucyBpbiB0
aGUgVEVFIHN1YnN5c3RlbS4NCj4+DQo+PiBTdXJlLCBmYWlyLiBJIGp1c3QgZG9uJ3QgZ2V0IHdo
eSBpbnRyb2R1Y2luZyBjbGVhbnVwLmggd2l0aG91dCBhY3R1YWxseQ0KPj4gYWNjZXB0aW5nIGl0
cyBleHBsaWNpdGx5IGRvY3VtZW50ZWQgc3R5bGUuLi4NCj4+DQo+IA0KPiBUQkgsIGl0IGlzIGxp
a2VseSBvdmVybG9va2VkIGR1cmluZyByZXZpZXcgb2YgdGhlIFFURUUgZHJpdmVyLiBIYXZpbmcg
YQ0KPiBidWlsdGluIHdhcm5pbmcgZm9yIHRoZSB1bmRlc2lyZWQgc3ludGF4IHdvdWxkIGhlbHAg
dGhlIHJldmlld2VycyBoZXJlLg0KPiANCj4gLVN1bWl0DQoNCldoaWxlIHRoZSBzdHlsZSBtYXkg
c2VlbSB1bnVzdWFsIC0tIGFzIHN0YXRlZCBpbiBjbGVhbnVwLmgsIHVzaW5nIGNsZWFudXAgaGVs
cGVycw0KbWFrZXMgdGhlIGNvZGUgbW9yZSByZWFkYWJsZSBvdmVyYWxsIGNvbXBhcmVkIHRvIHJl
bHlpbmcgb24gbXVsdGlwbGUgZ290byBzdGF0ZW1lbnRzLg0KQWxzbywgaXTigJlzIG5vdCBqdXN0
IGFib3V0IHRoZSAiX19mcmVlKC4uLikgPSBOVUxMIiB1c2UgY2FzZXMgLS0gdGhlcmUgYXJlIGxv
Y2tzDQppbnZvbHZlZCBhcyB3ZWxsLiBTd2l0Y2hpbmcgdG8gZGlyZWN0IGZyZWUoKSB3b3VsZCBy
ZXF1aXJlIHJldmVydGluZyB0aG9zZSBsb2NrcywNCnNpbmNlIG1peGluZyBjbGVhbnVwIGhlbHBl
cnMgd2l0aCBtYW51YWwgY2xlYW51cCBpcyBub3QgYWNjZXB0YWJsZS4NCg0KSWYgdGhpcyBiZWhh
dmlvciBpcyBleHBsaWNpdGx5IGRvY3VtZW50ZWQgaW4gY2xlYW51cC5oLCB0aGVyZSBpcyBubyBy
ZWFzb24gbm90DQp0byB1c2UgaXQgYXMgaW50ZW5kZWQuIEkgYWxzbyBzdXBwb3J0IEtyenlzenRv
ZuKAmXMgc3VnZ2VzdGlvbi4NCg0KQmVzdCByZWdhcmRzLA0KQW1pcg0KDQo=
