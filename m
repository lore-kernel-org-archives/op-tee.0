Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEC8D3B7EA
	for <op-tee@archiver.kernel.org>; Tue,  9 Dec 2025 03:54:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1682B50087
	for <op-tee@archiver.kernel.org>; Tue,  9 Dec 2025 03:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765252471;
	bh=vFOC1iCiGUxHdSL32u2jr3jRWVxlsxaqi6wbMLSr3G4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Wh0R++mpiOJJh2FQvIFPVkoCJ0ZZYvX8DFYyUidDzFGDgml8ZaQ/UYB0J256YJqp8
	 S09kR+97ONV/WA85pPMnimNKzwtEEK4kFJd0fUyjPDep5TUaYgtVt4gLgezBIkr4lh
	 r+xYSvhFwvg/6kxb5jTmjhKBSRG5XZUAgMK+lWvVj6kHbYCjX1Upvir9SqOzBYIaAZ
	 xOtaIryXzlu4GktoyouvXbQMx0lBPGwY3Ak7DGNfPDzBvnUW68YbOeHgGoLdFZzclN
	 mIwPbBrD3EQjM4mttaQHwFUavfgkS9ZbC+lD+20jsi3sgU+DA3DIMcVQxSPmxEo2iK
	 r4Qb9CCPmPCEQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0DAEB431C2
	for <op-tee@lists.trustedfirmware.org>; Tue,  9 Dec 2025 03:54:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QVIFV7jo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JxQQsUZW;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8NWwTe2618389
	for <op-tee@lists.trustedfirmware.org>; Tue, 9 Dec 2025 03:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nnR1xWyFVLfFlT3ZIJffxXiMjmUP6mdMumapN+NQlmA=; b=QVIFV7joPgay0TbZ
	oD4cJET1Go0l1Y8+OeGfQvBXa8WGPkK/z66uNrTiSCJNX0rC2ykidA4gvJB6vQcK
	UyOWr1xSMNLQnnAhadUOvejc0T/0+N0r/LDNOv9DZtl8hfCIU93G7o1YAGP76OrW
	Rsqcn3zoLtlfQ1NQKHHyMDgwqkHpJgjz0AeOa49FrJ1cs7hmn/UdL8mzyDPCOm6v
	hI0nTyRXa72hhEXaLvC9kxqrWc01ZXOBJWeMKURoO7+uk1zJ4jNm1ApQn2o+sPIx
	sNb3bPLroOwark0WZZyCOQfAguh8jOT72vMqiAc5y5BAbYMhBVhCsutxBUrvY0UL
	bj7okg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ax76u0tmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 09 Dec 2025 03:54:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343daf0f488so5167343a91.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 19:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765252458; x=1765857258; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnR1xWyFVLfFlT3ZIJffxXiMjmUP6mdMumapN+NQlmA=;
        b=JxQQsUZWh2lbLWYTwXZX4zVcHbAFeYIFzMBaxJpXxexYWK6HRou+77wKy4cRz6U8Er
         YwaKfuP2llyIUmOZsXyLwSaMwawzJ6GOjmTmTP5kwvlut7KoSNZn5oF3nZ84ONMIim30
         0eQtiPJNcxyMNSCKwGyIAd0hvH+1FK8usKhDKBCt6DfyXmU8vE/BP+Us7myDv229w4hQ
         BrIAqHagbnPSEQOWY+Gln9ohbj5EwAgLZ30OQ7VrXkj6UGjOT6klQ7XXSAjbrQ9RQ2DN
         cVhEVlfVTUxXNTDnbjeQodjEg2cWPFWt7hwZzEhte0g7CcLPbjRFRujnGDSnDguB/0cM
         oGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765252458; x=1765857258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnR1xWyFVLfFlT3ZIJffxXiMjmUP6mdMumapN+NQlmA=;
        b=a4nlN7pChFDnpJtdOkITTC4wdt5twjX2nWhMTtVqZW8FrnR7Gvi0gVkib/z6ioU+9o
         iUQfWww6cfLeRnlNk+HMUoUytyDLClYMOwPvNUOa+GCXLdqc4OlmzZsBAmNwEgtyAkpC
         1tgBtA9BHlifOhvlSS75ZguYK3Eoa1Z18JNEcvCmM69p4bhRmGGA8EA3uh+STuUhh3qi
         gXKDaWpjJEFzNv1DmMkxNUSfSWWgpJpYjdri365LeulbiI+4/hKNckeIkYpToarPvIo/
         Pdf4Mlj3u+2gc025PWo95HXFbttGWvI3B4DKsd98viECQuVcqcuQ63kWnW6lK52+DN+D
         lkPA==
X-Forwarded-Encrypted: i=1; AJvYcCXrGMfQKH1m+17DyLsJ8NYhsHkn9dBEeR2JuOlPPMeHoj23YCsKPB8iyXwQP5lMBRXupaBGJ3M=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyJ1TPcss1O8RjJnxCbn9MlCMXu5i1/ZX9B90kHyP68soA7W5Jb
	OZFYR+VR/gwl8WK3irCsuBvhJLZzw5KvhtSn1z6aqqkeEHesGeASz5mW/i1LLFunbzQot07TDTa
	dyGKh6YiPh18NdSBS2+y/o3d8ohXjhbkHzRUZdcuaM3yLPr4ZHbANvsUe+JZCQEiKfSLv48k=
X-Gm-Gg: ASbGncuNT5VE7A8TPSem2E7Pdu62I67RbooprrTLCSElkZCy7ehjDB4qk+hhMVwryoc
	ZV5DnAkH6ya4FfK/GrmYHS7d/lbFqBL2fqnpONkG9Ip9PycANIZGhy2G/dhoHYKkb2Vw8+LI4Yd
	a1b11TF/28b1sFRlaPTtfz314fw0gdyOo+dkPLj1ZVHavYv4+WwjkflyaMFjYMAc34fM2e49/N5
	HKZWNgipt2ow7eNq4d1fO+HWr1WWnmJkV+LKJJAFmHucmZbMeZ1dG5DJY8wRX2cpV5WAYk+eOBn
	m31z8t1OBTrJVlHNf8IftpR8pTs0WF9rorT0JliddqYRGZf0TiHOsACPT2gRxGWYycRUbglz82/
	/na5yidvTFzNI0Z+S03teg8GKluhRKCnhxHrnED4b5TiqLP5utlFwzvJNaWvFYfWdlf4yh6CTCv
	OyNDJrXQU=
X-Received: by 2002:a17:90a:fc47:b0:343:d70e:bef0 with SMTP id 98e67ed59e1d1-349a267fbc8mr8392226a91.21.1765252458453;
        Mon, 08 Dec 2025 19:54:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBtCRRfRZPsiM51E+rJcLK4CAWy+MDqSOd14fLOVvOPDgFDBD4Poe8H4k0y2eRJlIFNllCOA==
X-Received: by 2002:a17:90a:fc47:b0:343:d70e:bef0 with SMTP id 98e67ed59e1d1-349a267fbc8mr8392201a91.21.1765252457977;
        Mon, 08 Dec 2025 19:54:17 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a48dd5229sm747017a91.0.2025.12.08.19.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 19:54:17 -0800 (PST)
Message-ID: <3aacf997-3a21-4e4b-b6bd-c55c36fb4c74@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 14:54:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20251204101730.1036671-1-arnd@kernel.org>
 <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
 <0b061075-ab71-4ac1-93ec-438ddaaec903@oss.qualcomm.com>
 <aTbCqyOuprPOyU4X@sumit-X1>
 <2c0d09b7-0d8c-4bf2-a1bd-1dc4b58cd0a8@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2c0d09b7-0d8c-4bf2-a1bd-1dc4b58cd0a8@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDAyNyBTYWx0ZWRfX70k1jBFTTEcf
 OY9Km+A73ideBMH7Nfa/4DcnDWE6KjM1fcHL2rtGO1CXDyKgnDyLsaxGEDbPMoIDiimd0MHThL4
 CxHbAO5La2gNLANw2QZ7aBSciGsyRMmj6xmymjkkRHb4qRradv9AQi3hLpUNH5ugK1CzQ6hbSBR
 d5YX5l28coWm27pmeK0QSVZVGj65ly1Kcc92UUa1COvqiyoB1kiFxcHjerxPPEQVaxk1u4VX7xq
 cnycL1lLaavoB1MBJsWzn3S9fNAPoXEIE9CfBliBGdptAKy1Yo82ruDpPtPO0rfApT7Zbc+tuKh
 qOu7/oWEiTMTbXoNPiF4NKt4O52GMxftrKFV8tZqMEmEWGQKBtMsRsvLRtF52Eu8U/rImExgKWA
 uJAhJ3Iq6TGhP/p8fA98e0BmLw6Gyw==
X-Proofpoint-ORIG-GUID: gMQggPt8q-rkz15j3VOj0V_xUGBK-Dbf
X-Authority-Analysis: v=2.4 cv=PYTyRyhd c=1 sm=1 tr=0 ts=69379d6b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=PgFiUajCvCRNKxe-32EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: gMQggPt8q-rkz15j3VOj0V_xUGBK-Dbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-08_07,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090027
X-Spamd-Bar: ------
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0DAEB431C2
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: HHZA3AWTBKX3HTN65HFOTQ6IWWE3BGWX
X-Message-ID-Hash: HHZA3AWTBKX3HTN65HFOTQ6IWWE3BGWX
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Arnd Bergmann <arnd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HHZA3AWTBKX3HTN65HFOTQ6IWWE3BGWX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGksDQoNCk9uIDEyLzgvMjAyNSAxMTo1NCBQTSwgSGFyc2hhbCBEZXYgd3JvdGU6DQo+IA0KPiAN
Cj4gT24gMTIvOC8yMDI1IDU6NTAgUE0sIFN1bWl0IEdhcmcgdmlhIE9QLVRFRSB3cm90ZToNCj4+
IE9uIE1vbiwgRGVjIDA4LCAyMDI1IGF0IDA0OjI0OjE3UE0gKzExMDAsIEFtaXJyZXphIFphcnJh
Ymkgd3JvdGU6DQo+Pj4gSGksDQo+Pj4NCj4+PiBPbiAxMi81LzIwMjUgMTI6MjcgQU0sIEplbnMg
V2lrbGFuZGVyIHdyb3RlOg0KPj4+PiBIaSwNCj4+Pj4NCj4+Pj4gT24gVGh1LCBEZWMgNCwgMjAy
NSBhdCAxMToxN+KAr0FNIEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4gd3JvdGU6DQo+
Pj4+Pg0KPj4+Pj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4+Pj4+DQo+
Pj4+PiBUaGUgdGVlX2lvY3RsX29iamVjdF9pbnZva2VfYXJnIHN0cnVjdHVyZSBoYXMgcGFkZGlu
ZyBvbiBzb21lDQo+Pj4+PiBhcmNoaXRlY3R1cmVzIGJ1dCBub3Qgb24geDg2LTMyIGFuZCBhIGZl
dyBvdGhlcnM6DQo+Pj4+Pg0KPj4+Pj4gaW5jbHVkZS9saW51eC90ZWUuaDo0NzQ6MzI6IGVycm9y
OiBwYWRkaW5nIHN0cnVjdCB0byBhbGlnbiAncGFyYW1zJyBbLVdlcnJvcj1wYWRkZWRdDQo+Pj4+
Pg0KPj4+Pj4gSSBleHBlY3QgdGhhdCBhbGwgY3VycmVudCB1c2VycyBvZiB0aGlzIGFyZSBvbiBh
cmNoaXRlY3R1cmVzIHRoYXQgZG8NCj4+Pj4+IGhhdmUgaW1wbGljaXQgcGFkZGluZyBoZXJlIChh
cm02NCwgYXJtLCB4ODYsIHJpc2N2KSwgc28gbWFrZSB0aGUgcGFkZGluZw0KPj4+Pj4gZXhwbGlj
aXQgaW4gb3JkZXIgdG8gYXZvaWQgc3VycHJpc2VzIGlmIHRoaXMgbGF0ZXIgZ2V0cyB1c2VkIGVs
c2V3aGVyZS4NCj4+Pj4+DQo+Pj4+PiBGaXhlczogZDViOGIwZmExNzc1ICgidGVlOiBhZGQgVEVF
X0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9PQkpSRUYiKQ0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gVGhlIG5ldyBpbnRl
cmZhY2Ugc2hvd2VkIHVwIGluIDYuMTgsIGJ1dCBJIG9ubHkgY2FtZSBhY3Jvc3MgdGhpcyBhZnRl
cg0KPj4+Pj4gdGhhdCB3YXMgcmVsZWFzZWQuIENoYW5naW5nIGl0IG5vdyBpcyB0ZWNobmljYWxs
eSBhbiBBQkkgY2hhbmdlIG9uDQo+Pj4+PiBhcmNoaXRlY3R1cmVzIHdpdGggdW51c3VhbCBwYWRk
aW5nIHJ1bGVzLCBzbyBwbGVhc2UgY29uc2lkZXIgY2FyZWZ1bGx5DQo+Pj4+PiB3aGV0aGVyIHdl
IHdhbnQgdG8gZG8gaXQgdGhpcyB3YXkgb3Igbm90Lg0KPj4+Pj4NCj4+Pj4+IFdvcmtpbmcgYXJv
dW5kIHRoZSBBQkkgZGlmZmVyZW5jZXMgd2l0aG91dCBhbiBBQkkgY2hhbmdlIGlzIHBvc3NpYmxl
LA0KPj4+Pj4gYnV0IGFkZHMgYSBsb3Qgb2YgY29tcGxleGl0eSBmb3IgY29tcGF0IGhhbmRsaW5n
Lg0KPj4+Pg0KPj4+PiBUaGlzIGlzIGN1cnJlbnRseSBvbmx5IHVzZWQgYnkgdGhlIHJlY2VudGx5
IGludHJvZHVjZWQgcWNvbXRlZSBiYWNrZW5kDQo+Pj4+IGRyaXZlci4gU28gaXQncyBvbmx5IHVz
ZWQgb24gYSBmZXcgYXJtNjQgUXVhbGNvbW0gcGxhdGZvcm1zIHJpZ2h0IG5vdy4NCj4+Pj4NCj4+
Pj4gSSB0aGluayB3ZSBzaG91bGQgdGFrZSB0aGlzIHBhdGNoLCBidXQgbGV0J3MgaGVhciB3aGF0
IG90aGVycyB0aGluay4NCj4+DQo+PiBZZWFoIHNpbmNlIGl0J3Mgbm90IGFuIEFCSSBpc3N1ZSBv
biBhcm02NCBwbGF0Zm9ybXMgd2hlcmUgUVRFRSBydW5zLCBzbzoNCj4+DQo+PiBSZXZpZXdlZC1i
eTogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29tPg0KPj4NCj4+Pj4NCj4+
Pj4gVGhhbmtzLA0KPj4+PiBKZW5zDQo+Pj4+DQo+Pj4NCj4+PiBJIGFncmVlLiBXZSBzaG91bGQg
dGFrZSB0aGlzIHBhdGNoLiBBcyBub3RlZCwgdGhlcmUgYXJlIG5vdCBtYW55DQo+Pj4gY2xpZW50
cyByZWx5aW5nIG9uIGl0IHlldCwgc28gdXBkYXRpbmcgdGhlIHVzZXJzcGFjZSBzaG91bGQNCj4+
PiBiZSBzdHJhaWdodGZvcndhcmQuDQo+Pg0KPj4gWW91IHNob3VsZCByYXRoZXIgdGVzdCB3aXRo
b3V0IGFueSB1c2Vyc3BhY2UgbGlicmFyeSB1cGRhdGUgdG8gdGVzdCBpdCdzDQo+PiBub3QgYW4g
QUJJIGlzc3VlLiBKdXN0IGZvciBjb3JyZWN0bmVzcyBzYWtlLCB5b3UgY2FuIHVwZGF0ZSB0aGUg
bGlicmFyeQ0KPj4gdG9vLg0KPj4NCj4gDQo+IEknbGwgdGFrZSB0aGUgdGltZSB0byB0ZXN0IGl0
IGF0IHNvbWUgcG9pbnQgdGhpcyB3ZWVrIGJvdGggd2l0aCBhbmQgd2l0aG91dCB1cGRhdGluZw0K
PiB0aGUgbGlicmFyeSBBQkkuDQo+IA0KDQpTdW1taXQsIHRoYXQgd2FzIHRoZSBwbGFuIGZyb20g
dGhlIGJlZ2lubmluZywgdGhhdCdzIHdoeSBJIGRpZCBub3QgYWRkICJSZXZpZXdlZC1ieToiDQpp
biB0aGUgZmlyc3QgcGxhY2UuIFRoYW5rcyBIYXJzaGFsIGZvciB2b2x1bnRlZXJpbmcuDQoNCkJl
c3QgcmVnYXJkcywNCkFtaXINCg0KPiBSZWdhcmRzLA0KPiBIYXJzaGFsDQo+IA0KPj4gLVN1bWl0
DQo+Pg0KPj4gWy4uLl0NCj4gDQoNCg==
