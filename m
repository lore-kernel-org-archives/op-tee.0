Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4930ACCFA13
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 19:50:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7D18E4FEAF
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1762804241;
	bh=9KkS5qBcm7Og4hU8x56WxyYHAdz10pkN5QUaofKqJbU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zJrP+Q31yHNqMcFYseuq5HclXCIzWX4XiiHhRmd+8v2YtHz7O4Ub6WLu1FUrLNx1R
	 47DgZvNKkftW+BtImo9GndnklLSeKb2YEWUlcfJ6hbDB+DfglXhOEzt/892KLXTocq
	 XS3uUeobUpwtDI994HzYv11N2stLAREQW55Ai5qKr8GH70OaoEes4oaFysllB6GiJe
	 yUAV1adA02wqK/Uowtguw63HPR246AG8FnyN+opqjwtHQCa3DwphwEdhm5EF+1UuEg
	 P4e2d5VseU75Mhrr452qfRMkAELAkBr9Ebgu35b7/uv4/z8vr0YjIUvbRCESdcd0dV
	 wWn0a49BaITqw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 75D3F431B0
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 19:50:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lhf/Hlj0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dL3R2/cV;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFQ6Ne4071443
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 19:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mMy3xEpIJC4thPHLyeggrJ49IrKaEGXeIIixcyDiPk=; b=Lhf/Hlj0Af63lJAN
	eq3+kuvY8iblgIR9U8YvIosPFg1BD8VWtWBg9N39qHJeC8bF87DWw/be29dFyip4
	3QdxGBD1FsWRlQ4J6U9tpxQoKbedLjVFw88/rTF1xbAxuKcf3ynByYWu3DcZwVoV
	KVzcc1CLUJkgon60eUTu+jZTYgbGk+8BS46f6boY92mPkuqYP8myj3gWacsqnc2m
	AEAcCq/rgrcSzs/ggPtDTop6/3EOMGQczCyVaV3USFLZxJJNKnxgkkMsW1mVJDvT
	WYPt1mB89ChQ0Dj0V7okqzkqAvuceaWcKSqCHlPSGx7nZLBVWS0Z6xIraPVVsJvK
	7dSKiA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjpgruqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 19:50:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-341aec498fdso5506169a91.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 11:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762804229; x=1763409029; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mMy3xEpIJC4thPHLyeggrJ49IrKaEGXeIIixcyDiPk=;
        b=dL3R2/cVFtSv4PCoUtGqoRpnZnXoVJEACHaNBXXMUIQYivqXgeQzFZLO0vg8+yKOj5
         h7t1droDE3uVjVNdrHn4TY7/FT8HnEt8acMxt/Vhnfv64Xx99T2dgr6+a8nbRtfUJtEZ
         pv9LxAwEndOCCxHgFZrhtodAHZNPf55SJk+pDDkRbFCiYnNPG5fEEI9x7/zyCKy4suES
         zu/u7V7XkPunU55Xb2xQfKMjmIHnR7yF7sHUIyRGos1wqz0ODKa4u58RRZkuSSshltbF
         0yTm2yOqolO/6rHCe2mbpL8yc9iH7FLMAZNanBvDileYnTh2C9Ezxtym9yAsff5rGGfW
         UpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762804229; x=1763409029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mMy3xEpIJC4thPHLyeggrJ49IrKaEGXeIIixcyDiPk=;
        b=eb3OJ3KOuifJzD0vgVt29xnLEI9xc0v1QUGx0jQjULiLcpS1dIOL+fyrIIsW7bMCmh
         e9hgWoJG+x3y1tWl82N/DyG1pG1mmQIwqJx8wdGvqz3f2ZCH0VERwfe1A/8IMeSgcNsg
         avK/f6QxKkbb3wvif9aE+HSn7MgWnYXWG/Lkr3QHZs5g2ASG2sanp/NYy0cTD40jkmVU
         8Iu/w+4qAa2E84wTXep9eWbatl7fvn9TsvSTxusphK6ofh25Kx6WvULsxbqRpuVt2B//
         CzC7h6By6HZiTruUbw64Ie8SmGMhkkN+IW4LyLHLyOZZB0Y6WbExY6v31hPfB1j31WLe
         JHwQ==
X-Gm-Message-State: AOJu0YwBk8FxThygUS66pi4ZNYagsYTA51hWn28gaCBddo4ElOmdeC6J
	aVia3ni3KYmJvFstehz/jXMFfQSNv3q3XH7muxE5Fnj0LUoVsYL7HugexGiKHmlLgqs19fpnd9x
	wIijLBYuHMIuwbGRyeIVw7VXE9lyVf9tkk1up/kXDcPoe6BtaYMJFCZnZz0zWEvQAi02rb8g=
X-Gm-Gg: ASbGnctAlvlc3c5vX8btQ+o+9UOmed++Svj/lZPlDLPpEuZGnrrfMNmi0Dz8Oz/6fVY
	MmOj7qP3xQ4oUy7P0zxdPeZHaJJIr6yiMDAntQcwWKOr1MmE9enIRxRY2E7zucw+YGpnUuo5vNZ
	dDP8kGlqCop3aQB5ml6lEZqUopG4beBg82IJk+jO/0Gv2r7LjfIFY2CowB3g2tjTIrS/GOitBOY
	w0szFZjiipWIy5JqvLhBj2RoVAY9xOdOyLcBgbO9Et+vn2//GOYjmXaWRgxptW2JFiCwnpMyfBL
	v8t8bF4HxJd6TCTYXqqlSOqXqH+IfNeUjZ1WcAvmccJC19I0gRYX37abt6aeS5iZDLPSTCBhjUH
	mPRvQfULwKEhQm6b420lctiTNWxnSlkSrOpQYyAWzJAbtxQHOaU01AEobo1dJXzDWDyGZz3rU
X-Received: by 2002:a17:90b:3904:b0:341:8c15:959e with SMTP id 98e67ed59e1d1-3436cb91af6mr14930424a91.17.1762804228619;
        Mon, 10 Nov 2025 11:50:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8Di1QwFAEnANF24ry2JSL1n4kVLVDLeCQ2jEeq3mcQ054KYX8DOMfjiXvwT95+5kdE2oMgA==
X-Received: by 2002:a17:90b:3904:b0:341:8c15:959e with SMTP id 98e67ed59e1d1-3436cb91af6mr14930393a91.17.1762804228080;
        Mon, 10 Nov 2025 11:50:28 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343c0348843sm91354a91.9.2025.11.10.11.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 11:50:27 -0800 (PST)
Message-ID: <7c1e0de2-7d42-4c6b-92fe-0e4fe5d650b5@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 06:50:22 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] tee: add Qualcomm TEE driver
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <aMvWAiMky0k4nHlh@stanley.mountain>
 <CAHUa44H2sdMdQ31dzgvnGDtP8A95pOVKew3nYGVEhYDXSm1Xig@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44H2sdMdQ31dzgvnGDtP8A95pOVKew3nYGVEhYDXSm1Xig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE2OCBTYWx0ZWRfX/8aHwuVIGPLp
 iofWYl/xabfGX216vFtJC3/LioNPBu7miLC7KHWpKCX1AKRsgVO7/lDwxv1JXC9XuTDD1ZDx7k9
 GjUqlwl6F/EZaRchrpzJitWz9hqg3tWJuFdyEYvBHPX/lI9C8/iL5w8I9b1QkSUUp20RfRIFcgU
 G/upDrTtumQfKvukrerqIQuSuFl3/oDaaMcEb5jzZ/C8Djz3TgeNEC3GWS7yuCws1sCDw8MFy2n
 MzH5YbOCvISu2GRzhCmnguiLlWYuuHBTAA9KqCFGwWOvRj6gJbTPJm/7ALX9c2UxYAsGjYGFZfi
 7vgn6xDx0yHX4Bgz2UXiQVvlD313wSce4Emih9V+PfgJb8FlOgm8Vsg1EWFoN9YBvn92KHcRlVL
 J+WZPq6D5G8zRClXlHd0gmiqhbN4eA==
X-Authority-Analysis: v=2.4 cv=br5BxUai c=1 sm=1 tr=0 ts=69124205 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=MZ7Ds_omfgoUTP0e3NEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: vJSZtw8zximKYvZQ1e__Rao6ZO1ImUZl
X-Proofpoint-ORIG-GUID: vJSZtw8zximKYvZQ1e__Rao6ZO1ImUZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100168
X-Spamd-Bar: ------
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 75D3F431B0
X-Spamd-Result: default: False [-6.02 / 15.00];
	BAYES_HAM(-2.92)[99.66%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: DMILY7APCLXRFQCBBKUYJND42MOBNZ26
X-Message-ID-Hash: DMILY7APCLXRFQCBBKUYJND42MOBNZ26
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DMILY7APCLXRFQCBBKUYJND42MOBNZ26/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gMTEvMTAvMjAyNSA4OjAwIFBNLCBKZW5zIFdpa2xhbmRlciB3cm90ZToN
Cj4gSGksDQo+IA0KPiBPbiBUaHUsIFNlcCAxOCwgMjAyNSBhdCAxMTo1MeKAr0FNIERhbiBDYXJw
ZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+Pg0KPj4gSGVsbG8gQW1p
cnJlemEgWmFycmFiaSwNCj4+DQo+PiBDb21taXQgZDZlMjkwODM3ZTUwICgidGVlOiBhZGQgUXVh
bGNvbW0gVEVFIGRyaXZlciIpIGZyb20gU2VwIDExLA0KPj4gMjAyNSAobGludXgtbmV4dCksIGxl
YWRzIHRvIHRoZSBmb2xsb3dpbmcgU21hdGNoIHN0YXRpYyBjaGVja2VyDQo+PiB3YXJuaW5nOg0K
Pj4NCj4+ICAgICAgICAgZHJpdmVycy90ZWUvcWNvbXRlZS9jb3JlLmM6MTA0IHFjb210ZWVfZG9f
cmVsZWFzZV9xdGVlX29iamVjdCgpDQo+PiAgICAgICAgIGVycm9yOiB1bmluaXRpYWxpemVkIHN5
bWJvbCAncmVzdWx0Jy4NCj4+DQo+PiBkcml2ZXJzL3RlZS9xY29tdGVlL2NvcmUuYw0KPj4gICAg
IDgxIHN0YXRpYyB2b2lkIHFjb210ZWVfZG9fcmVsZWFzZV9xdGVlX29iamVjdChzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspDQo+PiAgICAgODIgew0KPj4gICAgIDgzICAgICAgICAgc3RydWN0IHFj
b210ZWVfb2JqZWN0ICpvYmplY3Q7DQo+PiAgICAgODQgICAgICAgICBzdHJ1Y3QgcWNvbXRlZSAq
cWNvbXRlZTsNCj4+ICAgICA4NSAgICAgICAgIGludCByZXQsIHJlc3VsdDsNCj4+ICAgICA4Ng0K
Pj4gICAgIDg3ICAgICAgICAgLyogUkVMRUFTRSBkb2VzIG5vdCByZXF1aXJlIGFueSBhcmd1bWVu
dC4gKi8NCj4+ICAgICA4OCAgICAgICAgIHN0cnVjdCBxY29tdGVlX2FyZyBhcmdzW10gPSB7IHsg
LnR5cGUgPSBRQ09NVEVFX0FSR19UWVBFX0lOViB9IH07DQo+PiAgICAgODkNCj4+ICAgICA5MCAg
ICAgICAgIG9iamVjdCA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgcWNvbXRlZV9vYmplY3Qs
IHdvcmspOw0KPj4gICAgIDkxICAgICAgICAgcWNvbXRlZSA9IHRlZV9nZXRfZHJ2ZGF0YShvYmpl
Y3QtPmluZm8ucWNvbXRlZV9hc3luY19jdHgtPnRlZWRldik7DQo+PiAgICAgOTIgICAgICAgICAv
KiBHZXQgdGhlIFRFRSBjb250ZXh0IHVzZWQgZm9yIGFzeW5jaHJvbm91cyBvcGVyYXRpb25zLiAq
Lw0KPj4gICAgIDkzICAgICAgICAgcWNvbXRlZS0+b2ljLmN0eCA9IG9iamVjdC0+aW5mby5xY29t
dGVlX2FzeW5jX2N0eDsNCj4+ICAgICA5NA0KPj4gICAgIDk1ICAgICAgICAgcmV0ID0gcWNvbXRl
ZV9vYmplY3RfZG9faW52b2tlX2ludGVybmFsKCZxY29tdGVlLT5vaWMsIG9iamVjdCwNCj4+ICAg
ICA5NiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRQ09N
VEVFX01TR19PQkpFQ1RfT1BfUkVMRUFTRSwNCj4+ICAgICA5NyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcmdzLCAmcmVzdWx0KTsNCj4+ICAgICA5OA0K
Pj4gICAgIDk5ICAgICAgICAgLyogSXMgaXQgc2FmZSB0byByZXRyeSB0aGUgcmVsZWFzZT8gKi8N
Cj4+ICAgICAxMDAgICAgICAgICBpZiAocmV0ICYmIHJldCAhPSAtRU5PREVWKSB7DQo+PiAgICAg
MTAxICAgICAgICAgICAgICAgICBxdWV1ZV93b3JrKHFjb210ZWUtPndxLCAmb2JqZWN0LT53b3Jr
KTsNCj4+ICAgICAxMDIgICAgICAgICB9IGVsc2Ugew0KPj4gICAgIDEwMyAgICAgICAgICAgICAg
ICAgaWYgKHJldCB8fCByZXN1bHQpDQo+PiAtLT4gMTA0ICAgICAgICAgICAgICAgICAgICAgICAg
IHByX2VycigiJXMgcmVsZWFzZSBmYWlsZWQsIHJldCA9ICVkICgleClcbiIsDQo+PiAgICAgMTA1
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxY29tdGVlX29iamVjdF9uYW1lKG9iamVj
dCksIHJldCwgcmVzdWx0KTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl4NCj4+IHJlc3VsdCBj
b3VsZCBiZSB1bmluaXRpYWxpemVkIGlmIHJldCBpcyBub24temVyby4NCj4gDQo+IEFtaXIsIHBs
ZWFzZSBhZGRyZXNzIHRoaXMgd2FybmluZy4NCj4gDQoNClllcy4gSSdsbCBkbyBpdC4NCg0KVGhh
bmtzLA0KQW1pcg0KDQo+IFRoYWtzLA0KPiBKZW5zDQo+IA0KPj4NCj4+ICAgICAxMDYgICAgICAg
ICAgICAgICAgIHFjb210ZWVfcXRlZV9vYmplY3RfZnJlZShvYmplY3QpOw0KPj4gICAgIDEwNyAg
ICAgICAgIH0NCj4+ICAgICAxMDggfQ0KPj4NCj4+IHJlZ2FyZHMsDQo+PiBkYW4gY2FycGVudGVy
DQoNCg==
