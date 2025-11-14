Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D968CCDB46B
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 01:55:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0EB984FF52
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 01:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1763085305;
	bh=X8rOT0PKkJnK4VBQiHh+gzsyPKCeu1eMxfyAU1g8qfc=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=TaQ/mLDskYasD9AiPYU6TqezlJUI+B5dbRfXNCOiaivHSALfBq1UCxS2ib4IgEsHh
	 wM78DNLBU69gj5bnTP/tleMgG7SCdyjNqTHISLsGZNHRBEwcq/1jiQ+MiBcoTXWSXi
	 fkPIqyOW0OzB0TJ6WJEyV7BVzne8D+iIuM3R1MYT9AVL6nWItZZ7yP5ol++aEW3EDX
	 ziCzjZkPex1dkrdscBJL0fv77fcg0wIJxA/67VVxyiDII8kVZOWFtA1UKYjdDn9l6X
	 GiD1CYZIoBYpKsZv964Hio3OZtfLLKhi/HmS4nmjYKeNoZ6YukRTjmT+ZIMhEFjNdq
	 H6+I5dSYZsyeQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A75F84312B
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 01:54:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dPwgoBfT;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bYPFu8Q3;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMaqAF1704009
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 01:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mWD8TIFdOldLEF27oBBWiMI748LNxu5l8xvR4gJbz+4=; b=dPwgoBfTgWUDSa9e
	JaQhkAEGqMTrRSUJIwl5erbTeFXGGqsGI0utuziA/8jVRk4zgxxFkob7JTZIL0nK
	9Hc1n7G5PXu/lGuthUpxEk/YQnyQMb0xGTK9BWl2xcmt0visMShBaryhjAsTmdvV
	jaNt7TlWwTrBF0Dkp3prc980dgXnS6q6KIcZJFo2fuY13OyV7wrSGKqagEFG8b/r
	ozk5yJ9SWcxfLh9oaJPbk1EkLpGNmTWsnhdiPxy2XgTxGOAhoJGXbrtNQLnlHo5D
	wdOD4yTJrWjFyzVdCu5UgjdDY1XFxhnEmeDyhkJVlBRIr+KI2Ssye6ayB4S0mdcd
	Ql+S3g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9e8e8a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 01:54:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b993eb2701bso1623996a12.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 13 Nov 2025 17:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763085293; x=1763690093; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWD8TIFdOldLEF27oBBWiMI748LNxu5l8xvR4gJbz+4=;
        b=bYPFu8Q3YttIXH4G50iVn8YknMLCq9byTAH/D+o6WcPtatrNyHVX6a1IGZPN+m/8rx
         KwXdb0gMy1eyHM+QKeG3EUWWhrrk0LWtxXgvZE7W+D+oIity6sfpe+/63Pm2jRtLUUl7
         X1wDSDjSjkOZfD1ybXM7ZXkMj/AF4T2LuCEFWhqEK5S3U63lMdXie1Nd4NGJ4myjP+Fv
         g5Dn/hzFwFlvLR8GCybcsutVhDf1wupCXXnCqBY8ylIhKKPSkfMBCLsEWNiJfX7f2Qpo
         P6yoJGPJx8h6XW7NVr9JXf+E1B77Ch1FDG29kUEzfIIGKq33BCYdw7qBtzUjKjufHqnU
         wLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763085293; x=1763690093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWD8TIFdOldLEF27oBBWiMI748LNxu5l8xvR4gJbz+4=;
        b=gAM2WKsVzsSa3T4IORntxRdw5SVyt8BfKh9pjR4oZDbT+76HeKzQoI6Fd5c/dlUnEj
         mNHLz017/3Z13ZXTlWa6ggu9bo8HMszco20leL22UjzHFeEbmq4KPpj6vz52G63gl+VM
         U5cKs3ekWQMHmMkIEWCsxJISb/sHZXtOKOcgYashTsJP17xuztpZ+WTt1lnaYIcqdUW1
         LTlBZ8Sb78FBW03bcaA3FtE++sH/O6Yokb0UBkA6sVWAB2yTM1nM7xsJGOhiznyBhcdq
         UFA1C5jdSXE4gOCLnPwIVDLDtMj8epsFVKg66FI7XvTYcYIRysIbWzUkUuDazHrddvn2
         n7uA==
X-Forwarded-Encrypted: i=1; AJvYcCXvjugffRKmKxjcddURRM5ySuSyMbgi0UVsxdbBSTka3dj7EghzM532pADvsZlzwTPZf+QVjVs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyQNRlGEqcpXnqgsJotuLOGDJfkmIuB5UrQ27hcB6aFc9MhBfrr
	F2w+JY6O5uJHwQ1jzf0wmx0B1vhDzJ2OhgsMNyVu9gerteYw8ue50hpKuerYDArfVMiGuAiQqjc
	c14HJtAxKhkrg79B8IErDO/XikbXgR6BolHTvnbzdc24TDr/A51hMMrVKp2dcHTD50M0esCY=
X-Gm-Gg: ASbGncsO5ezHwwAtHu0Ul161GxVmFxksTTBVok37tpLZ2VNxCcwO/WNOo5V1S3AxfuJ
	b0fV1TPtairmpREBbvOBTZKpCvb8pu1s0b2OmqPqgtCCr1CaVX9iHut73aGJTc0eq0CdeJoCjn6
	OoTfPBX5mnCbfe/EeqNk2y6rVzmFpA7WsuFQIi49jFz6VkInMRcYRV3viQg77R66rMe999nhS2U
	lE9eQQX20Ngfj1F5ur9Z3k0+zbiYr7AooJlV9JacfrM1ZKFN3hA9XrvSNwgIZjL5kWfIfFmq/xB
	zqqodE8U0LWnlMyEW9RBsWCuVCH3e7XQTnsPrNJAE/ulzh9LpVqDlZVf1Y7l7evYmUp3pCIn0xf
	mkSaeuGrmQAzUtbEw7DLiaKAefJwoFYuZbpMs+yNwzftK1xy2KiunKlF855d69YB0D/UMmWZygi
	5a/isXWjw=
X-Received: by 2002:a05:6a20:a110:b0:358:dc7d:a2d4 with SMTP id adf61e73a8af0-35ba028d45fmr2063936637.20.1763085292848;
        Thu, 13 Nov 2025 17:54:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN0QOGen7XrcffVBF6IF/BbIHbMKCBKkzyUzn4Y/t7A4LnKCKyySfTvBnx+2OG9TIh8C1lvQ==
X-Received: by 2002:a05:6a20:a110:b0:358:dc7d:a2d4 with SMTP id adf61e73a8af0-35ba028d45fmr2063905637.20.1763085292316;
        Thu, 13 Nov 2025 17:54:52 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37731d21dsm3251803a12.34.2025.11.13.17.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 17:54:51 -0800 (PST)
Message-ID: <afba8148-b5a6-4f8e-a461-58cc62f37a7a@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 12:54:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: qcom: initialize result before use in release worker
To: Sumit Garg <sumit.garg@kernel.org>
References: <20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com>
 <aRLcO7dveqChPNb0@sumit-X1>
 <2ec200e4-cf28-4881-837b-4455da047619@oss.qualcomm.com>
 <aRQ7osB9rElutHuv@sumit-X1>
Content-Language: en-US
In-Reply-To: <aRQ7osB9rElutHuv@sumit-X1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ccPfb3DM c=1 sm=1 tr=0 ts=69168bed cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=5vM8NuAPPqwf9HD3eAwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 0SvPMwq7TbuCYGQfK9UGIi18lSgq5IiC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDAxMiBTYWx0ZWRfX46KkUcxg/wag
 ua6Wj37mHw50N1ch+PslpVVwzLIEh6BF5BtJmV7oNGDFVQae32+A/jngOxjW30b2LvI3jS1sB18
 S+XN3K8VLWG3WdGNwVLBSjWte0+nPvSRTHgxzfR/ubptW3hA01JFuIe4TRlOxCA8C+REoqlGs4W
 CRN3zGaWzmsg3A6qBAUl0nSaJCHYpv7gi7XlmnKUbzD8YQfGwU1nKMtidoUaoV1CRHk/Fav4yvS
 pkUBLNmtm4FdeOyb3DX0tbAEhN02tB+89duM45qAYsFT7FJq52PFuwdxziiayws3eXwq6epceaR
 sAldsUVOb6831Bs5RNObQfSuvx6mHsuehvktEOirWVk2xgvD40xXlVhKjlKj1iBqVbw+HRUGWlP
 wrENG3jGUz33tuale/EeR6BoFFOo5A==
X-Proofpoint-ORIG-GUID: 0SvPMwq7TbuCYGQfK9UGIi18lSgq5IiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140012
X-Spamd-Bar: -----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A75F84312B
X-Spamd-Result: default: False [-5.76 / 15.00];
	BAYES_HAM(-2.66)[98.52%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received];
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
Message-ID-Hash: PYMBLNGV4E4BAN4E3ZGTTEDHRP4XZOHH
X-Message-ID-Hash: PYMBLNGV4E4BAN4E3ZGTTEDHRP4XZOHH
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PYMBLNGV4E4BAN4E3ZGTTEDHRP4XZOHH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgU3VtaXQsDQoNCk9uIDExLzEyLzIwMjUgNjo0NyBQTSwgU3VtaXQgR2FyZyB3cm90ZToNCj4g
T24gV2VkLCBOb3YgMTIsIDIwMjUgYXQgMDY6NDI6MDRBTSArMTEwMCwgQW1pcnJlemEgWmFycmFi
aSB3cm90ZToNCj4+IEhpIFN1bWl0LA0KPj4NCj4+IE9uIDExLzExLzIwMjUgNTo0OCBQTSwgU3Vt
aXQgR2FyZyB3cm90ZToNCj4+PiBPbiBNb24sIE5vdiAxMCwgMjAyNSBhdCAwMToyODozMlBNIC0w
ODAwLCBBbWlycmV6YSBaYXJyYWJpIHdyb3RlOg0KPj4+DQo+Pj4gRm9yIHRoZSBzdWJqZWN0IHBy
ZWZpeCBsZXRzIHRyeSB0byBmb2xsb3cgdGhlIGRpcmVjdG9yeSBzdHJ1Y3R1cmU6DQo+Pj4NCj4+
PiB0ZWU6IHFjb210ZWU6IC4uLg0KPj4+DQo+Pg0KPj4gSSBiZWxpZXZlIHdlIHByZXZpb3VzbHkg
YWdyZWVkIG9uIHVzaW5nIHRlZTogcWNvbTogYmFzZWQgb24gdGhlIHJldmlld2Vy4oCZcw0KPj4g
Y29tbWVudHMuIEN1cnJlbnRseSwgdGhlcmXigJlzIG5vIGNvbW1pdCBtZXNzYWdlIHdpdGggcWNv
bXRlZTouDQo+Pg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb3AtdGVlLzRyYmZwdWJzYXhn
djJidWtzb25maWdiZGt3NmdlYXM2bDdweWN4dXVrZHltcWZvaGdhQG9oZDRocXp2cmEzdy8NCj4+
DQo+IA0KPiBZZWFoIEkgYWdyZWUgSSBoYXZlbid0IGJlZW4gdG9vIHBpY2t5IGFib3V0IGl0IGVh
cmxpZXIgYnV0IGxldHMgZm9sbG93IGENCj4gY29tbW9uIHByYWN0aWNlIHdoaWNoIG90aGVyIFRF
RXMgYWxzbyB1c2VzIGJhc2VkIG9uIGRpcmVjdG9yeSBzdHJ1Y3R1cmUgbGlrZToNCj4gDQo+IC0g
dGVlOiBvcHRlZToNCj4gLSB0ZWU6IGFtZHRlZToNCj4gLSB0ZWU6IHRzdGVlOg0KPiAtIHRlZTog
cWNvbXRlZToNCj4gDQo+IC1TdW1pdA0KDQpTdXJlLiBJJ2xsIHVwZGF0ZS4NCg0KUmVnYXJkcywN
CkFtaXINCg0K
