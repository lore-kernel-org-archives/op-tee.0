Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A2ED59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 11:21:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4AC144FEA8
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765797679;
	bh=SDWivY6SBdd/cubCaC6URpbogRtxd2pbYQ4nFyVhj3o=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JQ527zl6wOCzbj4gvu0iomuR4OVRBQPCL/oKQwNfEfw9CipY8xWdivyduHdBexj8I
	 bMxhckVnotpFuDuGjD/4LU9sNVjK3IJ2leyCfRIVWq/6JKOHpVU0BNA5Dm+sHEIa5p
	 Ybez0AX+VhPg5va9zmnk+KnvKfmO5GVbH2aR/STRudmdcqgypOUIHObHNDUHqxZprW
	 OEtTmNWBsdkhnyaN5YbCiRvEVYHQT4TdADYYbD3+PsvOt6cKc66o1sFVAoqZrGquDs
	 96IjP3IjbGUT2JXHt81Ag23CKEkynlt7hNKtxRlay2TRjxCFPagS9f1bNQ8D97Lz6F
	 rgOdKuGlehomw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D039E430AA
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 11:20:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h9Xh8+Vs;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e6JYN2Rr;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFAO2d2314723
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 11:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3GUwtPTD7pgS0FJUQOfGGk2o/7cX2hY9/PZpPqLYeA4=; b=h9Xh8+VscOSW/yL7
	Norz99U6zZ30GI5+qn1RaoGOnn38BI/FD0XU2MeQeuPhbxa5sZ85vBowpMz3e//7
	1gzgsDMFxpjwI04lHQiCCiEmOhSgjb83acyqiFGRU8Vj0aCQBDHTUfXcRosG5blc
	8UHNw/YRubduIiACvzGuXJR5UyVuDY+ie44bUvIv/ejfXeFOkFdfWiFklbpC88PH
	hqaGVxAsudqiGPTXmjOdTRBGh9roqCgQTVHkW0DLLtyG2Y6mDPy+5xJcqdnLLjpc
	3P6sbnLmvWubVUnxgnf+MhjAgJS2HVbLSUnNN1H4Bwu9ouOq5jErW/fzenRzSQgt
	xEBM1w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b119am9um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 11:20:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b80de683efso5579050b3a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 03:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765797645; x=1766402445; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3GUwtPTD7pgS0FJUQOfGGk2o/7cX2hY9/PZpPqLYeA4=;
        b=e6JYN2RrajwYLUphQrR7aF2y+ObBeu6hw+K4EPApz2rok1sD3uG5BzKrblFrSIOLWT
         zkcP/RXE7Vn1taDtMAGxGF/enyfOBaepwjRuNCrT5mIo6UbXDXPooC9LY6KnjSvqzJUx
         hL/3PWT5tZMbhrpGMOe8poTvGLNqaRZZgzrHqvSOBUi5xmC+qFsGPIU94wboqiLKv5OK
         JGOXS4ctaXWuYrAVSrdZZ4gv1JP6dfiG2ZyAxBsoCMX3FM1fp2gUrEQPwBbRtEut0bmj
         rOoHChcbWY3mmMBxa3WZNZOdAIYe4ASm7Ce1efG+/zqWLRrHPXxUZOyqY7HIH/Q6I40S
         WKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765797645; x=1766402445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GUwtPTD7pgS0FJUQOfGGk2o/7cX2hY9/PZpPqLYeA4=;
        b=hbVRKKJSyKXsnV1qplAykBG1mItpM+NoCMQGWynkMPoNxqjkVN9nLyKfaQ2g62o/iy
         nUNpQDCJHToz88hN/LK9aKhZfrqhxZRgPViDAz1wkDayq9xCkvCKMLNVfLCegVKF89OX
         agfTf6vxbgPjrHLCBR2JsJsk5lgYcgtEobHtEUOK9xNHWXxq1nfGEgneQC9aOOMgwpbV
         FRyHlHCktWKS96DqHYJDUpfFegGrNATDtt8+62imDyKBeWeJL11mLjC1Sbo8VOkWHPzA
         rnv65zABkfZ6o4+heRclmvUhqZ1icJ6CC/dOC/KhiqAa3NYYfsON0/6+y/82Fo16JsiK
         ow1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWy7Uip6lh5pGyKlKSYE+Ug1yEofwuqABjhNn6Svkrm8jT7oYGPk9VaFT9SYJaf0mrTRGN3/K8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw4sIe5FR9xuTerjT7iDSj0RXEw/45liGJFKdJBlcmcq7F2/zv+
	SqYQCbReXW3pi8s8Y9NFQNE3w5raOCd4JXz9B3zulk+pQpbqBHo4y0HVCmxOCrIW7FxHisEx2n2
	FSLfRg0In560w619OQtsNbt7D6RRLSBJEle8j5qVIwSGL8jeQBQ683T/0d2tXm1+MzoC2lAjE
X-Gm-Gg: AY/fxX6VnoLwor8RE467PbxhuyHUlq9GSWR2+PaVeNbafMiO/na1WwGY5DeOUINpp3s
	O1rTOrxrT1L8D/Jgwzzp7woYpN0+xIP+TQH1CflAlN4HYdzV+x+Yf/ZdKOM32OwjsLna6AWhy9v
	u8IdsePT8EDHFuDDCYQdmgLKt7QWGDmwjt/4YiL7fSx/7cBwB6HzB+VZ6mloiRlr+r4Soxa1N26
	Jj6uCBW82CdvS+XB95YnORTW6EKvS9oKxOcr6DbwUg8z8KI0TkwwoehK39Nmv2Bau1MjXf7k/9Y
	gP7zaVpKuIeyRGsUjZTFP/ZSgN9tqB3PbgNOpHvQtoseAt7WjdFTzJFLDBQwDMnTjwwVeEceawl
	OWpImysq4IolSa8zUppLGrGqAcUn7rsq9017J5HM=
X-Received: by 2002:a05:6a00:8683:b0:7e8:450c:61b5 with SMTP id d2e1a72fcca58-7f67156b796mr5756151b3a.37.1765797644751;
        Mon, 15 Dec 2025 03:20:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAa6RaseztafsU6ZzwG5ohOvRVQ0hzB8/6C439lWKD+y8Q05aOqhKVyudkKjzVXkz3SgfaFg==
X-Received: by 2002:a05:6a00:8683:b0:7e8:450c:61b5 with SMTP id d2e1a72fcca58-7f67156b796mr5756131b3a.37.1765797644225;
        Mon, 15 Dec 2025 03:20:44 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa9b56sm12393296b3a.39.2025.12.15.03.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 03:20:43 -0800 (PST)
Message-ID: <0a4368bf-40a2-42bb-b538-6e64c11598e3@oss.qualcomm.com>
Date: Mon, 15 Dec 2025 16:50:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
To: Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
 <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
 <aTtvHYDOny33yeOD@sumit-X1>
Content-Language: en-US
In-Reply-To: <aTtvHYDOny33yeOD@sumit-X1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ftPRpV4f c=1 sm=1 tr=0 ts=693fef0d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=elEROV__wQne4N9O37AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA5NyBTYWx0ZWRfX0zp5eCEbssKs
 nBIrk5Fsqty1tPLzcNesx6bZT/54JCB0Ee7dI+CTX6tehTjBIXsSyFMk4ukYhq82/kE4DR8+PFC
 pIn8J4qD/aKqkX+C/hBvGH5o4PNOfBwSf+6I1RsK+RHgvLhX+JTyqbNQbv8HlVIMdMBjvEQMzX0
 1UNVlZeRUb5TIikE+K1Ca8/jUgZDs7AD4IMIVpo8XfoZxZucWjue69CxHLP/hir1hatnYr/zLHT
 xdoQvpDS99yvFPH10VlsrApbvX1/9LTT44o1Sdk4oIpzTstX2JmmszjAROTd2l346Or4bbUD2k/
 3/EJq8jzybYvxDxe6it9nB5xvsPjpL9rQNd6/cCg+bUZ1DkA8CMh1JhDsTpabqOc0hn2gzuvoJT
 oWmGgV8Z9SoSQ008h7ayQ0y18UTpKg==
X-Proofpoint-ORIG-GUID: wm9qHdJWR4B2EL9SCfpqyDlax0FeU2Pg
X-Proofpoint-GUID: wm9qHdJWR4B2EL9SCfpqyDlax0FeU2Pg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150097
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.210.198:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D039E430AA
X-Spamd-Bar: ----
Message-ID-Hash: FIILOM6R2EA2VLE3WBUYVLJC7FHZPH7V
X-Message-ID-Hash: FIILOM6R2EA2VLE3WBUYVLJC7FHZPH7V
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Konrad Dybcio <konradybcio@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FIILOM6R2EA2VLE3WBUYVLJC7FHZPH7V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

SGkgYWxsLA0KDQpPbiAxMi8xMi8yMDI1IDY6NTUgQU0sIFN1bWl0IEdhcmcgd3JvdGU6DQo+IE9u
IFdlZCwgRGVjIDEwLCAyMDI1IGF0IDAyOjM1OjE5UE0gKzA1MzAsIEhhcnNoYWwgRGV2IHdyb3Rl
Og0KPj4gSGkgQmpvcm4sDQo+Pg0KPj4gT24gMTIvMTAvMjAyNSA5OjIxIEFNLCBCam9ybiBBbmRl
cnNzb24gd3JvdGU6DQo+Pj4gT24gTW9uLCBEZWMgOCwgMjAyNSBhdCAxMDoxNOKAr1BNIERtaXRy
eSBCYXJ5c2hrb3YNCj4+PiA8ZG1pdHJ5LmJhcnlzaGtvdkBvc3MucXVhbGNvbW0uY29tPiB3cm90
ZToNCj4+Pj4gT24gVHVlLCA5IERlYyAyMDI1IGF0IDA3OjU4LCBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IE9uIDA4LzEyLzIwMjUgMTM6
MTgsIEhhcnNoYWwgRGV2IHdyb3RlOg0KPj4+Pj4+IEVuYWJsZSBRQ09NVEVFIGRyaXZlciBvbiBR
dWFsY29tbSBTTTg2NTArIFNvQ3MgdG8gZmFjaWxpdGF0ZSBjb21tdW5pY2F0aW9uDQo+Pj4+Pj4g
d2l0aCB0aGUgUXVhbGNvbW0gVHJ1c3RlZCBFeGVjdXRpb24gRW52aXJvbm1lbnQgKFFURUUpLg0K
Pj4+Pj4+IChObyBlbmFibGVtZW50IHJlcXVpcmVkIGluIERUUyBmaWxlcyBzaW5jZSBRQ09NVEVF
IGRldmljZSBpcyBkeW5hbWljYWxseQ0KPj4+Pj4+IHJlZ2lzdGVyZWQgYnkgdGhlIFFDT01fU0NN
IGZpcm13YXJlIGRyaXZlcikNCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEhhcnNoYWwg
RGV2IDxoYXJzaGFsLmRldkBvc3MucXVhbGNvbW0uY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IENo
YW5nZXMgaW4gdjM6DQo+Pj4+Pj4gLSBVcGRhdGVkIHRoZSBjb21taXQgbWVzc2FnZSB0byByZWZs
ZWN0IHRoZSBzdXBwb3J0ZWQgUXVhbGNvbW0gcGxhdGZvcm1zLg0KPj4+Pj4+IC0gTGluayB0byB2
MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MTIwNS1xY29tX3Fjb210ZWVfZGVmY29u
ZmlnLXYyLTEtYzkyNTYwYjAzNDZlQHF0aS5xdWFsY29tbS5jb20NCj4+Pj4+Pg0KPj4+Pj4NCj4+
Pj4+IEkgZ2F2ZSB5b3UgdGhlIGV4YWN0IGV4YW1wbGUgdG8gZm9sbG93LiBNYXliZSBpdCBpcyBu
b3QgdGhhdCBpbXBvcnRhbnQNCj4+Pj4+IGZvciBvdGhlcnMsIHNvIEkgd2lsbCBub3Qgb2JqZWN0
LCBidXQgT1RPSCBpdCBpcyBpbXBvcnRhbnQgZm9yIG1lLCB0aHVzDQo+Pj4+PiBJIHdpbGwgbm90
IGdpdmUgcmV2aWV3ZWQgYnkuIEkgZGFtbiBhc2tlZCBWRVJZIENMRUFSTFk6DQo+Pj4+Pg0KPj4+
Pj4gIkp1c3QgbWVudGlvbiB3aGljaCBVUFNUUkVBTSBib2FyZHMgKHdoaWNoIHlvdSBjYWxsZWQg
UXVhbGNvbW0NCj4+Pj4+IHBsYXRmb3JtcykgdXNlIHRoaXMgZHJpdmVyLiINCj4+Pj4NCj4+Pj4g
KzEgSGVyZS4gRGVmY29uZmlnIGNoYW5nZXMgbWVudGlvbiBkZXZpY2VzLCBub3QgU29DIGZhbWls
aWVzLg0KPj4+Pg0KPj4+DQo+Pj4gSSBkb24ndCBhZ3JlZSB0aGF0IHlvdSBoYXZlIHRvIG1lbnRp
b24gYSBzcGVjaWZpYyBib2FyZCwgaWYgdGhlDQo+Pj4gZmVhdHVyZSBpcyB1c2VkIGJ5IGFsbCBi
b2FyZHMuIEJ1dCBJIHRoaW5rIHRoZSBjb21taXQgbWVzc2FnZSBzaG91bGQNCj4+PiBtYWtlIF90
aGF0XyBjbGVhci4NCj4+Pg0KPj4NCj4+IFRoYW5rcyBmb3IgdGhpcyBpbnB1dCBCam9ybi4gSSBn
YXRoZXIgd2UgYXJlIG5vdyBhbGlnbmVkIHRoYXQgdGhlIGJvYXJkDQo+PiBpbmZvcm1hdGlvbiBp
cyBub3QgcmVxdWlyZWQuDQo+Pg0KPj4gVGhlbiB0aGUgb3RoZXIgcGFydCB0byB0aGlzIGlzIGhv
dyB0byBwcm92aWRlIGluZm9ybWF0aW9uIG9uIHRoZSBwYXJ0aWN1bGFyDQo+PiBTb0NzIHVzaW5n
IHRoaXMuDQo+Pg0KPj4+IE9uIHRoZSBjb250cmFyeSwgdGhlIGNvbW1pdCBtZXNzYWdlIHNheXMg
dGhhdCB3ZSdyZSBlbmFibGluZw0KPj4+IENPTkZJR19RQ09NVEVFIGJlY2F1c2UgaXQncyB1c2Vk
IG9uICJTTTg1NjArIi4gV2hhdCBkb2VzIHRoZSBwbHVzDQo+Pj4gbWVhbj8NCj4+DQo+PiBJIHRv
b2sgcmVmZXJlbmNlIGZyb20gc2ltaWxhciBjb21taXRzIG1lcmdlZCBlYXJsaWVyIHdoZXJlIHRo
ZSBwbHVzIHNlZW1lZA0KPj4gdG8gaW5kaWNhdGUgdGhhdCBhbGwgUXVhbGNvbW0gU29DcyBmcm9t
ICdTTTg2NTAnIG9uLXdhcmRzLCB0aGF0IGlzLCBTTTg3NTAsDQo+PiBTTTg4NTAgYW5kIHNvIG9u
LiBJdCBmZWx0IHRoYXQgdGhlIHBsdXMgc2lnbiBpcyBzZWxmLWV4cGxhbmF0b3J5IHNpbmNlIGl0
DQo+PiBoYXMgYmVlbiB1c2VkIGFscmVhZHkuIEJ1dCBzdXJlLCBtYXliZSB3ZSBjYW4gYmUgZXhw
bGljaXQgZnJvbSBub3cgb24gYW5kIHNheQ0KPj4gZnJvbSAnUXVhbGNvbW0gU004NjUwIG9ud2Fy
ZHMnLg0KPj4NCj4+IGNvbW1pdCBjNWQwMmJiYWEyMTdiMjQ1NGJhMWNlNzUyODExM2FhMmVjZjE0
ZjNjDQo+Pg0KPj4+IEFsc28sIHRoZSBkcml2ZXIgaXNuJ3QgZW5hYmxlZCAib24gUXVhbGNvbW0g
U004NjUwKyIsIGl0J3MgZW5hYmxlZCBpbg0KPj4+IHRoZSBBbTY0IGRlZmNvbmZpZywgaS5lLiBp
dCdzIGVuYWJsZWQgb24gYWxsIEFybTY0IGJvYXJkcyAtIHRoZQ0KPj4+IHF1ZXN0aW9uIHRoYXQg
c2hvdWxkIGJlIGFuc3dlcmVkIGJ5IHRoZSBjb21taXQgbWVzc2FnZSBpcyAid2h5PyIuDQo+Pj4N
Cj4+DQo+PiBFdmVuIHRob3VnaCB3ZSBhcmUgZW5hYmxpbmcgdGhpcyB2aWEgdGhlIGFybTY0IGRl
ZmNvbmZpZywgaXQgaXMgbm90IHRydWUgdGhhdA0KPj4gdGhlIGRyaXZlciBpcyBhcHBsaWNhYmxl
IGZvciBhbGwgYXJtNjQgYm9hcmRzLiBUaGUgc2ltcGxlIHJlYXNvbiBiZWluZyB0aGF0DQo+PiB0
aGUgUVRFRSBmaXJtd2FyZSBPUyB0aGF0IHRoZSBkcml2ZXIgY29tbXVuaWNhdGVzIHdpdGggcnVu
cyBvbmx5IG9uIFF1YWxjb21tDQo+PiBTb0NzIHVzaW5nIGFybTY0IENQVXMgd2l0aCBBUk0gVHJ1
c3Rab25lIHRlY2hub2xvZ3kuDQo+Pg0KPj4gVGhpcyBpcyB3aHkgSSB3b3VsZCB0cnkgdG8gYXZv
aWQgYSBjb21taXQgbWVzc2FnZSB3aGljaCBjbGFpbXMgdGhlIHRoZSBkcml2ZXINCj4+IGlzIGFw
cGxpY2FibGUgdG8gYWxsIGFybTY0IGJvYXJkcy4NCj4+DQo+PiBCYXNlZCBvbiBhbGwgdGhpcywg
SSBhbSB0aGlua2luZyBwZXJoYXBzIGl0IHdvdWxkIGJlIGJldHRlciB0byBzYXkgdGhhdCB0aGUN
Cj4+IHBhdGNoIGVuYWJsZXMgUUNPTVRFRSBkcml2ZXIgZm9yIFF1YWxjb21tIFNvQ3Mgd2l0aCBh
cm02NCBDUFVzPyBXZSBjb3VsZCBkcm9wDQo+PiBtZW50aW9ucyBvZiBzcGVjaWZpYyBTTTh4NTAg
bW9kZWxzIHdpdGggSERLL01UUCBib2FyZHMgc2luY2UgdGhlIGZlYXR1cmUgaXMNCj4+IGFnbm9z
dGljIHRvIHRob3NlPw0KPiANCj4gQUZBSUssIHRoZSBRQ09NVEVFIGRyaXZlciB3b3JrcyBvbiB0
aGUgUWNvbSBTb0NzIGJhc2VkIG9uIGFybTY0IHdoaWNoIHN1cHBvcnRzDQo+IHRoZSBTTUNJbnZv
a2UgcHJvdG9jb2wuIFNvIHdlIHNob3VsZCBiZSBleHBsaWNpdCBhYm91dCBpdC4gUmVnYXJkaW5n
DQo+IG1lbnRpb24gb2YgcmVmZXJlbmNlIHB1YmxpY2x5IGF2YWlsYWJsZSBib2FyZHMsIEkgY2Fu
IHNlZSBob3cgaXQgY2FuIGJlIHVzZWZ1bA0KPiBmb3IgdGhlIGNvbW11bml0eSB0byB0ZXN0IFFU
RUUgYmFzZWQgYXBwcy4gSWYgeW91IGNhbiBtZW50aW9uIHNheQ0KPiBleGFtcGxlIFJCM0dlbjIg
c3VwcG9ydHMgUVRFRSBkcml2ZXIgYXQgbGVhc3QgdGhlbiBpdCB3aWxsIGJlIGhlbHBmdWwuDQo+
IA0KDQpCYXNlZCBvbiBjb25zb2xpZGF0ZWQgZmVlZGJhY2sgb24gdGhpcyB0aHJlYWQsIEkgYW0g
dGhpbmtpbmcgb2YgdGhlIGZvbGxvd2luZw0KY29tbWl0IG1lc3NhZ2UsIGxldCBtZSBrbm93IGlm
IHRoaXMgaXMgYSBnbyBmcm9tIGV2ZXJ5b25lJ3MgcGVyc3BlY3RpdmU6DQoNCiINCmFybTY0OiBk
ZWZjb25maWc6IEVuYWJsZSBRQ09NVEVFIGZvciBRdWFsY29tbSBTb0NzIHVzaW5nIGFybTY0IENQ
VXMNCg0KRW5hYmxlIFFDT01URUUgZHJpdmVyIGFzIGEgbW9kdWxlIGZvciBRdWFsY29tbSBTb0Nz
IGJhc2VkIG9uIGFybTY0IENQVXMgYW5kDQpzdXBwb3J0aW5nIHRoZSBTTUNJbnZva2UgcHJvdG9j
b2wgZm9yIGNvbW11bmljYXRpb24gd2l0aCB0aGUgUXVhbGNvbW0gVHJ1c3RlZA0KRXhlY3V0aW9u
IEVudmlyb25tZW50IChRVEVFKS4NCg0KVGhlIGRyaXZlciBpcyB0ZXN0ZWQgb24gYSBRdWFsY29t
bSBSQjNHZW4yIGJvYXJkIGJ5IGxvYWRpbmcgYW5kIGV4ZWN1dGluZyBhDQpUcnVzdGVkIEFwcGxp
Y2F0aW9uIHZpYSB0ZXN0cyBob3N0ZWQgYXQgd3d3LmdpdGh1Yi5jb20vcXVhbGNvbW0vbWlua2lw
Yy4NCiINCg0KUmVnYXJkcywNCkhhcnNoYWwNCg0KPiAtU3VtaXQNCj4gDQo+IFsuLi5dDQoNCg==
