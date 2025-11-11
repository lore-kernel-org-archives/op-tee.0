Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D099BCCFA18
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 19:42:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 113B55004C
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1762890145;
	bh=M2sDWEeUR9wyYZdDuHzVdWOO7pOk0IfE9mNfrusgQ/U=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yVr9ApFhijiFTA/Fj6gSBf8Gg8UUzVQbzJ9wnhrdZH+uue+xj0eXfYimYfSTX3qz8
	 o07BM1QlUIXjw5XQsP3whKD0uqUcx+KDac4hn1+WrUk29WO6DPhuicLVvbwbIlGZdh
	 bVmiwdTyM0WzYBTmBMmbmVMZJcmUoQI29IUNZ6ZrJowtely6gO5BH1Kl/iSvaG0SR4
	 4h3B8S69LeTJwRtFZTy3eu3kPxiaLSmXd/1SQF28JFSesRW27zwe/HwTT50r8A7D7m
	 ObMGZfv2KZa0pcZyxfsmOVTF92aLEWAjyU0fmzvlVEmWhntSOMVQJ81upfaRJ8lGst
	 13uN0wBnhKmEg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A9B2A4317C
	for <op-tee@lists.trustedfirmware.org>; Tue, 11 Nov 2025 19:42:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dOGWTEhJ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SeNtGkYT;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGIZx2117330
	for <op-tee@lists.trustedfirmware.org>; Tue, 11 Nov 2025 19:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqnoVw51UCIsT26Oa4weRLY+7NAvoYQK7MEQUSq3sb4=; b=dOGWTEhJr5/jhzIH
	+FhylHABGhJ9Sp9IyfG2pgavk1/MZLBJEvj5y3515gXq/7kX4axiiNLHLDTUXw9i
	k8w4tmj95DulWiWDdcoJg4bYn3VuA+hVX7JotI2Awj1PiaWwy1ZJjJv3AVbGGicP
	d00J28g0FMRh3wZgTKcYymCcqFacCSPedxEaDLGSY48LPnndwet/lu0bl1CKhWvl
	H6TwuXZZ2Sz4k32sh0Ua2vU/3yLhSKaukKwJVu+tqR2J3+oKK8szpb9yYw/iFCBP
	fVz6SfOmRDzYWP5wM2zGMufkQb0xd5hyn7aVTAxK6fuAvbFl0aQSPE37DjzI8Uw4
	2LEM5A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abpy8kn49-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 11 Nov 2025 19:42:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958c80fcabso1626575ad.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 11 Nov 2025 11:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762890131; x=1763494931; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqnoVw51UCIsT26Oa4weRLY+7NAvoYQK7MEQUSq3sb4=;
        b=SeNtGkYTfug7sqIXiH8U34TD3izTtI4zPa7JALlo6t/yI07MDo+6gVjYsyy8lMwaOB
         1Tzycz/aznHB/Dti2hLj0yEmrbZ4/4ckFC2g6MVgpZIBsS1vpTEt8fmA0G27ogcyWR2U
         vQY+s2O6FUl17tPrmBu7guD10KvwQWvRadhLUaXQzBL0CqnZEvPtGuVovsjHfsm7WTk8
         PWFZpW6fOFaM7l/iDc9AL7njMuxpmzd5XSfOUwpPu8iKqjDvjBS++HuErGqDIwSJKWvI
         Zw8mg/CO0g+l8/CYj+bShSbbkM2wzY0yClAOMPmBWxPbMTQjtMUV1OQrNUWy42E3CP+r
         dVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890131; x=1763494931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqnoVw51UCIsT26Oa4weRLY+7NAvoYQK7MEQUSq3sb4=;
        b=eWrBhHujCyNP9aIJm44fu8NV3xsrhdQKAsLdROEcnXjT1PL3Lkj9VrQpq469WA1XDQ
         P9NXFtm0j4swXbgeYdpUEKy33IzbIwCNvjrqAy+cecjpRtL3yeYbqOwtetfVNFYKW4eS
         tszvGVzajV5MLJfqJ+bFZWVIFHZ0Z3GexLzoltegNEaUKTC4zaq+ZrJ1FmniyG6oCS0Q
         bLzngbB74qLOiS0dEwm2dASf2NL5Cq+NLa+0lSbpFp9Oy+vw07pikR4xO760XWxrEcDs
         5J2QvlHhd/MBgvedIrsJBx9rV690PXnVghSULIJ7VRyT8yOo2ROnwjKJ0hYSG4b2NM/N
         0peg==
X-Forwarded-Encrypted: i=1; AJvYcCWR5AeMPs3rDr3OlZeXBic2eYphbjKtv+b6wNK5FYnuQey3Le9YkCjO8YlvBxy8L7iVc+HLhrM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw9j8BP1aOdkeTIuTpd+2UKMJuetLYpeSbnI9jSVq4VL7/bazMV
	NKmgSRXAwbbYrHcMnRmhF+a+2LGN2Dx/Du2oJ6BZOBPo+eb0XRpZ/q8yVFSZmhc1ib3fi3m8Kqs
	dUQZwy6UWajUroue1bRj8va0UC2UbzZ8lUsIf0xA7XaA35gde4DyLBrqi34NF7WpTra/4C1c=
X-Gm-Gg: ASbGncuKCS06hzGRuihUXpt4AJnFurf0d8eSjgjQFKAJzTkzLd9niU/Q/mXAudbvMWK
	5nBciVM5z9hhDQKaGnWH0P4hpnIrYNMzYFRzhTm96SQYIBcCx3YaLMIRs9MW83Hhp73z57xXo8N
	gHsZ92e+IwRiVUyIxteVWZfGrrXSDlyJ04jWPSIBJ82hnI3dCTGqXxRpZkx/1hQF8zdFQzxzyew
	nT+Uc+sCHO/shX7Y2rnnSRshZvduimVA//jL+apxLyM9baoLMNXC9g/KDnopfZovJlULbxo273S
	yvX5InPmZLm7dLfKmmmnLKJ75cgGUktuC1DmHsxAMni7x/m3lPmDCGuY3QWzotpXMbyG8qVoxjI
	B1qml+dl50WH4GwqQoGZ573pksJA2AGUiVHdFOHg1QaqC3l4pM4PdEWzXzO5nyMMugozBhPR3
X-Received: by 2002:a17:903:2f88:b0:298:250b:a547 with SMTP id d9443c01a7336-2984ee2c611mr5010365ad.56.1762890130936;
        Tue, 11 Nov 2025 11:42:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWfumxVDHLJVJniJ5/kUPbPPfATDyVpTigTkiqrDKAayaaoggxw+dyqtCM41ZXJhxvIUxbTA==
X-Received: by 2002:a17:903:2f88:b0:298:250b:a547 with SMTP id d9443c01a7336-2984ee2c611mr5010145ad.56.1762890130404;
        Tue, 11 Nov 2025 11:42:10 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9fc6fsm5313105ad.73.2025.11.11.11.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 11:42:09 -0800 (PST)
Message-ID: <2ec200e4-cf28-4881-837b-4455da047619@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 06:42:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: qcom: initialize result before use in release worker
To: Sumit Garg <sumit.garg@kernel.org>
References: <20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com>
 <aRLcO7dveqChPNb0@sumit-X1>
Content-Language: en-US
In-Reply-To: <aRLcO7dveqChPNb0@sumit-X1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: WmTeb9gwJioxHEy_NJ00LckikeM6VCh4
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=69139193 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=i4atl9h2owgdAyLMJb8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE2MCBTYWx0ZWRfX8rHBhCUGH9PT
 5lgwFb+t86UTQG8f3e/Wn+fQRPSNBapJ193y20j1B4kl4dJbD5DwXi+JUY9SGrNCqWYMv5tqXG1
 45/44BIcpEqmiYlrG22/Jnyn1G/MLPC5HdZaqRXrk6bt7lspLK2W6fJbuMzGxNRpiBOk6ierCYL
 wvDAN7TrOTugtUa844DilR5V+ow6yRTYvwqQf1zMV43UDP2tQSQBmN0y1H77CGR/RzdpIo3QLwb
 2RxY0x1zZ9knLVwjTwZR1kyR9A1Jl6XLk2Y0cOHx3taRspqtyGYPUYzI+Ts+ZiH8ekD2sRbHm9O
 Fd54LRB0k40w9m5ndY8IOG1qsfzFzF1zsdMV0xbFSQ+2FtTRCno8BxehEztxIZ2WlGBVnJ0dMMV
 G0G7184GxiW/Y0VYHzn/urT6ohYKoQ==
X-Proofpoint-GUID: WmTeb9gwJioxHEy_NJ00LckikeM6VCh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110160
X-Spamd-Bar: ------
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A9B2A4317C
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
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
Message-ID-Hash: WEZS4JEOZLU3QN6MG444FOR3APSFK6TW
X-Message-ID-Hash: WEZS4JEOZLU3QN6MG444FOR3APSFK6TW
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WEZS4JEOZLU3QN6MG444FOR3APSFK6TW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgU3VtaXQsDQoNCk9uIDExLzExLzIwMjUgNTo0OCBQTSwgU3VtaXQgR2FyZyB3cm90ZToNCj4g
T24gTW9uLCBOb3YgMTAsIDIwMjUgYXQgMDE6Mjg6MzJQTSAtMDgwMCwgQW1pcnJlemEgWmFycmFi
aSB3cm90ZToNCj4gDQo+IEZvciB0aGUgc3ViamVjdCBwcmVmaXggbGV0cyB0cnkgdG8gZm9sbG93
IHRoZSBkaXJlY3Rvcnkgc3RydWN0dXJlOg0KPiANCj4gdGVlOiBxY29tdGVlOiAuLi4NCj4gDQoN
CkkgYmVsaWV2ZSB3ZSBwcmV2aW91c2x5IGFncmVlZCBvbiB1c2luZyB0ZWU6IHFjb206IGJhc2Vk
IG9uIHRoZSByZXZpZXdlcuKAmXMNCmNvbW1lbnRzLiBDdXJyZW50bHksIHRoZXJl4oCZcyBubyBj
b21taXQgbWVzc2FnZSB3aXRoIHFjb210ZWU6Lg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9v
cC10ZWUvNHJiZnB1YnNheGd2MmJ1a3NvbmZpZ2Jka3c2Z2VhczZsN3B5Y3h1dWtkeW1xZm9oZ2FA
b2hkNGhxenZyYTN3Lw0KDQpCZXN0IFJlZ2FyZHMsDQpBbWlyDQoNCj4+IEluaXRpYWxpemUgcmVz
dWx0IHRvIDAgc28gdGhlIGVycm9yIHBhdGggZG9lc24ndCByZWFkIGl0DQo+PiB1bmluaXRpYWxp
emVkIHdoZW4gdGhlIGludm9rZSBmYWlscy4gRml4ZXMgYSBTbWF0Y2ggd2FybmluZy4NCj4+DQo+
PiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0K
Pj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vcC10ZWUvN2MxZTBkZTItN2Q0Mi00
YzZiLTkyZmUtMGU0ZmU1ZDY1MGI1QG9zcy5xdWFsY29tbS5jb20vDQo+PiBGaXhlczogZDZlMjkw
ODM3ZTUwICgidGVlOiBhZGQgUXVhbGNvbW0gVEVFIGRyaXZlciIpDQo+PiBTaWduZWQtb2ZmLWJ5
OiBBbWlycmV6YSBaYXJyYWJpIDxhbWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+DQo+
PiAtLS0NCj4+ICBkcml2ZXJzL3RlZS9xY29tdGVlL2NvcmUuYyB8IDIgKy0NCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy90ZWUvcWNvbXRlZS9jb3JlLmMgYi9kcml2ZXJzL3RlZS9xY29tdGVlL2NvcmUu
Yw0KPj4gaW5kZXggYjY3MTVhZGE3NzAwLi5lY2QwNDQwMzU5MWMgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL3RlZS9xY29tdGVlL2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy90ZWUvcWNvbXRlZS9j
b3JlLmMNCj4+IEBAIC04Miw3ICs4Miw3IEBAIHN0YXRpYyB2b2lkIHFjb210ZWVfZG9fcmVsZWFz
ZV9xdGVlX29iamVjdChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+PiAgew0KPj4gIAlzdHJ1
Y3QgcWNvbXRlZV9vYmplY3QgKm9iamVjdDsNCj4+ICAJc3RydWN0IHFjb210ZWUgKnFjb210ZWU7
DQo+PiAtCWludCByZXQsIHJlc3VsdDsNCj4+ICsJaW50IHJldCwgcmVzdWx0ID0gMDsNCj4+ICAN
Cj4gDQo+IFRoZSBjaGFuZ2UgbG9va3MgZmluZSB0byBtZS4NCj4gDQo+IC1TdW1pdA0KPiANCj4+
ICAJLyogUkVMRUFTRSBkb2VzIG5vdCByZXF1aXJlIGFueSBhcmd1bWVudC4gKi8NCj4+ICAJc3Ry
dWN0IHFjb210ZWVfYXJnIGFyZ3NbXSA9IHsgeyAudHlwZSA9IFFDT01URUVfQVJHX1RZUEVfSU5W
IH0gfTsNCj4+DQo+PiAtLS0NCj4+IGJhc2UtY29tbWl0OiBhYjQwYzkyYzc0YzZiMGM2MTFjODk1
MTY3OTQ1MDJiM2EzMTczOTY2DQo+PiBjaGFuZ2UtaWQ6IDIwMjUxMTEwLXFjb20tdGVlLWZpeC13
YXJuaW5nLTNkNThkNzRhMjJkOA0KPj4NCj4+IEJlc3QgcmVnYXJkcywNCj4+IC0tIA0KPj4gQW1p
cnJlemEgWmFycmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPg0KPj4NCg0K
