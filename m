Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EED4D3B9A9
	for <op-tee@archiver.kernel.org>; Wed, 10 Dec 2025 09:05:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6DFF7500D5
	for <op-tee@archiver.kernel.org>; Wed, 10 Dec 2025 09:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765357538;
	bh=KclyvZCRIcdQLG31BEHXYJzt71ni4740L2ahFLGE6tU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Ir1gWIaOLU/TA3lEiA+cU9ubXDJqskjKcCMDysKilM4H8YOpibU8/KALwRo8uGfYg
	 chWi+PKqovMKMTzkNr50jT1vCpLsCXXUXjERSb4hEkj6PCF6X1mTzd/VUA/E1r5JjT
	 GGHrOyxo55zY2iZd7JFeMRHjuy1KOH8sQisnCIz+I234J8CcQ69Fw0iumqGTNAsoBf
	 VDJsTtISmD2Z+8wH0GtoaukXzGLvcKfZRLEd18WKX+S7H5ELeyfRg01vkl5H++nsWt
	 7jbZZiuseuwWPrwKk+TaIdvScNWXw3Z0GlrEl6xmuEGmuMBeXbWKWtlVuBJkp3I2I3
	 Q2nN19KV41M1w==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 523AD46079
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Dec 2025 09:05:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MHkK0kWs;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NI9100B2;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA8e3vf1918146
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Dec 2025 09:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wqiA46dwUtdNEG3pj3Yg2uzx7d3+KbQKXu2IT3gW7Ek=; b=MHkK0kWsdTlYtPZT
	pw2i7g6xzT1r8OFyUFyDgWy0UAAz8nVp071Piv3qcf/i9HKjkYQU/KzvcG8yfTeW
	+pn6RRXAh3HSKHhRx2A9qdNq40svFFFHUuwY71ut/fu7zKLVqlLk/tNTeS6xFZgo
	qsyTRntjFxmSjBlZTOeLutZrNo9qOt0dy21EwteoqF+j6xHCjrMfPnIwNF6kktKy
	OvAOQiabGgLlMNAR4Mnq1CDoa4Q78cH474ZMpJDw0X2++cr/Nvb3MOpRp2yLnSTR
	hAXMAG01DZswLJOI1I6DXuonTs2R6aBMZb0ukxSJ0QB9UVfl2g5ICL7pubPBN3SY
	cyiQ7g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay1xp0rw9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Dec 2025 09:05:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3438744f12fso17190643a91.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 10 Dec 2025 01:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765357525; x=1765962325; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqiA46dwUtdNEG3pj3Yg2uzx7d3+KbQKXu2IT3gW7Ek=;
        b=NI9100B2OeKt3tqOkT+nZR5x4yXHCRqfLF1ucmtkVfMnX+a+iLHOj5h/OkbG6RMEry
         G0VaqpkjsCV7ZB7WWLrBG9yJrBsWvTBeV3F4ton847LXnVxP/+TumWeChwlYwxX7Hvy5
         oWYVMvRWXawW7yq8uXqAC3hO7BJEw4xC3JXQDqZO1rbKyO1iSliIuuwIsHuWuQcBDHES
         G4MQL+K3xdzp6S5wZrdO4udAx3iOmBM6wouvt/xCT/oBF0EueUlDl+UmbPE8XDqtdrFP
         2tnOHrdDiZEe0Du5/5rc06mevLNVRVaSw1lDZCaekid1uGnx8hUBcxhgliGTaYftmzrA
         fkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765357525; x=1765962325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqiA46dwUtdNEG3pj3Yg2uzx7d3+KbQKXu2IT3gW7Ek=;
        b=fdJOVbXqZiC2Nic1vL+INgdRLdbfB0hSrN4D77eh3bY/oVQjLrP8oOSMOw+2GE8t4z
         lqJzQsP2BPMiyN99u1+vKw/K6DIyHmymthCJZ1ttA1P/DwVs+HTa/hP9HjJ+g9wD5f1F
         GGXjMth4KsXvhgCNAMPI6+O1FGAjs3PSX4idLH2W22PKYP7Sfs2R4D2z0HhjVqTpU7PQ
         ifM/nCaw4x/6W6q+12XpcS6jEEUZ2iprqkXRS3ddOINordnmvPmGrPJ7KLL6suvKreoS
         9KYqzJSDYuzpBG6ItZ/OdEIRF1mY+W1UKP9ecUUOLy9pyq/ul1svB87slAJoXbgI6zrA
         pPNA==
X-Forwarded-Encrypted: i=1; AJvYcCU+K07UwgaX3ayTrnHTfT9Ki0c6bJ2fCup+MumfWpUy1bK7tKAwa/A8cii26RK6C32RaDyhHzc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyoqGld72EMp2NJBPVuZfAh+1xiF01iRnJb3TiMStIlE5AgRnEQ
	uxHpRCQ9YrruwPTN/zj5NaZowR2Pyj3XODyjBLOkZvxDe3J19Covphs6ZHzvwM3sJ32foB0pVxh
	vhkd23p/Qvh5tOcCSnfuNPT8K824WYsMoDlVrFJgQJ/p1cY7214iqh41yZ8rfBCtDUqIFyzuz
X-Gm-Gg: AY/fxX4qDvZNNDDB9xZDMuPdvoY2jvYjWfNPMqCw4EjPdgt8/YfFrgtat2Yfhw38Z24
	WCQnuROGGDKBpylfi0Nig0yZIF5YHlNvWZDisrrYnjaSGVtRsOAxLE90FdRtz7ZTXdpFAmNI+3J
	Dk/yn3nRBQSbpXgit/iq+8Qu0jh1bK+LqQ8D1tKBqqyqga3uyj7vFCCiHYl1eWLQFVnxX+OS8zG
	SeXywyTeGnd0w/RLdc3TO152kWVLJq2O7OIo6qkEzOtQ5cD4JQC6dGIN6Kcr0cO6PItm83k5PJm
	/ZBScJH3lxnc7bzZ4ZfCtz6JYUraGVlShFHD9e1d2zOaSU1S+gfhlqkNB2utb1K9s7mXitrEHLs
	JHnOPJIsXCy1oVWgaDd7VADAl4eRvUW57OGK2KwA=
X-Received: by 2002:a17:90b:5388:b0:340:d1a1:af6d with SMTP id 98e67ed59e1d1-34a72883621mr1523333a91.36.1765357525389;
        Wed, 10 Dec 2025 01:05:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE41gJN3yfndXfDh0Cw/GjZLd2NoFlvGIUFNVasqzCHoMkBAfdcn9k6a9O8IluhRLdFqv3daQ==
X-Received: by 2002:a17:90b:5388:b0:340:d1a1:af6d with SMTP id 98e67ed59e1d1-34a72883621mr1523307a91.36.1765357524793;
        Wed, 10 Dec 2025 01:05:24 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a7000c984sm1910606a91.6.2025.12.10.01.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 01:05:24 -0800 (PST)
Message-ID: <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
Date: Wed, 10 Dec 2025 14:35:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA3NyBTYWx0ZWRfX2DD4fjE7mA/B
 XCUiMjLk/zNYG/YDYeSyKgo4Vx7RI+OiqT/9aCS6+TP8LL/WF4IlH65A1W+IfJ7rnJjlSM0qTWo
 A76BrmqwEvXxn3Wrmg4Lj6bR2c4PkGfzvL9ikfWBl9PDWDsUzqJHVi38mjbienoKhv6KN43czzQ
 uJgHZMcVRWDE8tci9zgPNa9HRehsGlX7ry8NApwl6A61H5ICjIDBcTRl8JOgZrs7n3/at4cnGfx
 fVhkFJHMDL0iGoga6rDJ2t47DB35zb7wSd/JN66bDyMQI+IqZLCxaSw2uwxCFaQHmwqRLsckcdS
 3IfuWc1pNxGnj8/UNk8aDrJZA565sb6c2mT9UEnaRe8MrQ2ZnhqMi04uTxdS59WrpA0hI/qE2zb
 1QDOnQWV1dhYdvNXIan90MqMLnzpZA==
X-Proofpoint-ORIG-GUID: gpAd9qAPkCQ8hOl9m6VcIOXvC72WMCq2
X-Proofpoint-GUID: gpAd9qAPkCQ8hOl9m6VcIOXvC72WMCq2
X-Authority-Analysis: v=2.4 cv=A/Zh/qWG c=1 sm=1 tr=0 ts=693937d6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=brTnQUUJkzy-kVnKapkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100077
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 523AD46079
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: N4MDKDU4QHLSA6ZB5CQMJ3BWRQ3Z657S
X-Message-ID-Hash: N4MDKDU4QHLSA6ZB5CQMJ3BWRQ3Z657S
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/N4MDKDU4QHLSA6ZB5CQMJ3BWRQ3Z657S/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

SGkgQmpvcm4sDQoNCk9uIDEyLzEwLzIwMjUgOToyMSBBTSwgQmpvcm4gQW5kZXJzc29uIHdyb3Rl
Og0KPiBPbiBNb24sIERlYyA4LCAyMDI1IGF0IDEwOjE04oCvUE0gRG1pdHJ5IEJhcnlzaGtvdg0K
PiA8ZG1pdHJ5LmJhcnlzaGtvdkBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToNCj4+IE9uIFR1ZSwg
OSBEZWMgMjAyNSBhdCAwNzo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3Jn
PiB3cm90ZToNCj4+Pg0KPj4+IE9uIDA4LzEyLzIwMjUgMTM6MTgsIEhhcnNoYWwgRGV2IHdyb3Rl
Og0KPj4+PiBFbmFibGUgUUNPTVRFRSBkcml2ZXIgb24gUXVhbGNvbW0gU004NjUwKyBTb0NzIHRv
IGZhY2lsaXRhdGUgY29tbXVuaWNhdGlvbg0KPj4+PiB3aXRoIHRoZSBRdWFsY29tbSBUcnVzdGVk
IEV4ZWN1dGlvbiBFbnZpcm9ubWVudCAoUVRFRSkuDQo+Pj4+IChObyBlbmFibGVtZW50IHJlcXVp
cmVkIGluIERUUyBmaWxlcyBzaW5jZSBRQ09NVEVFIGRldmljZSBpcyBkeW5hbWljYWxseQ0KPj4+
PiByZWdpc3RlcmVkIGJ5IHRoZSBRQ09NX1NDTSBmaXJtd2FyZSBkcml2ZXIpDQo+Pj4+DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IEhhcnNoYWwgRGV2IDxoYXJzaGFsLmRldkBvc3MucXVhbGNvbW0uY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gQ2hhbmdlcyBpbiB2MzoNCj4+Pj4gLSBVcGRhdGVkIHRoZSBjb21t
aXQgbWVzc2FnZSB0byByZWZsZWN0IHRoZSBzdXBwb3J0ZWQgUXVhbGNvbW0gcGxhdGZvcm1zLg0K
Pj4+PiAtIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTEyMDUtcWNv
bV9xY29tdGVlX2RlZmNvbmZpZy12Mi0xLWM5MjU2MGIwMzQ2ZUBxdGkucXVhbGNvbW0uY29tDQo+
Pj4+DQo+Pj4NCj4+PiBJIGdhdmUgeW91IHRoZSBleGFjdCBleGFtcGxlIHRvIGZvbGxvdy4gTWF5
YmUgaXQgaXMgbm90IHRoYXQgaW1wb3J0YW50DQo+Pj4gZm9yIG90aGVycywgc28gSSB3aWxsIG5v
dCBvYmplY3QsIGJ1dCBPVE9IIGl0IGlzIGltcG9ydGFudCBmb3IgbWUsIHRodXMNCj4+PiBJIHdp
bGwgbm90IGdpdmUgcmV2aWV3ZWQgYnkuIEkgZGFtbiBhc2tlZCBWRVJZIENMRUFSTFk6DQo+Pj4N
Cj4+PiAiSnVzdCBtZW50aW9uIHdoaWNoIFVQU1RSRUFNIGJvYXJkcyAod2hpY2ggeW91IGNhbGxl
ZCBRdWFsY29tbQ0KPj4+IHBsYXRmb3JtcykgdXNlIHRoaXMgZHJpdmVyLiINCj4+DQo+PiArMSBI
ZXJlLiBEZWZjb25maWcgY2hhbmdlcyBtZW50aW9uIGRldmljZXMsIG5vdCBTb0MgZmFtaWxpZXMu
DQo+Pg0KPiANCj4gSSBkb24ndCBhZ3JlZSB0aGF0IHlvdSBoYXZlIHRvIG1lbnRpb24gYSBzcGVj
aWZpYyBib2FyZCwgaWYgdGhlDQo+IGZlYXR1cmUgaXMgdXNlZCBieSBhbGwgYm9hcmRzLiBCdXQg
SSB0aGluayB0aGUgY29tbWl0IG1lc3NhZ2Ugc2hvdWxkDQo+IG1ha2UgX3RoYXRfIGNsZWFyLg0K
PiANCg0KVGhhbmtzIGZvciB0aGlzIGlucHV0IEJqb3JuLiBJIGdhdGhlciB3ZSBhcmUgbm93IGFs
aWduZWQgdGhhdCB0aGUgYm9hcmQNCmluZm9ybWF0aW9uIGlzIG5vdCByZXF1aXJlZC4NCg0KVGhl
biB0aGUgb3RoZXIgcGFydCB0byB0aGlzIGlzIGhvdyB0byBwcm92aWRlIGluZm9ybWF0aW9uIG9u
IHRoZSBwYXJ0aWN1bGFyDQpTb0NzIHVzaW5nIHRoaXMuDQoNCj4gT24gdGhlIGNvbnRyYXJ5LCB0
aGUgY29tbWl0IG1lc3NhZ2Ugc2F5cyB0aGF0IHdlJ3JlIGVuYWJsaW5nDQo+IENPTkZJR19RQ09N
VEVFIGJlY2F1c2UgaXQncyB1c2VkIG9uICJTTTg1NjArIi4gV2hhdCBkb2VzIHRoZSBwbHVzDQo+
IG1lYW4/DQoNCkkgdG9vayByZWZlcmVuY2UgZnJvbSBzaW1pbGFyIGNvbW1pdHMgbWVyZ2VkIGVh
cmxpZXIgd2hlcmUgdGhlIHBsdXMgc2VlbWVkDQp0byBpbmRpY2F0ZSB0aGF0IGFsbCBRdWFsY29t
bSBTb0NzIGZyb20gJ1NNODY1MCcgb24td2FyZHMsIHRoYXQgaXMsIFNNODc1MCwNClNNODg1MCBh
bmQgc28gb24uIEl0IGZlbHQgdGhhdCB0aGUgcGx1cyBzaWduIGlzIHNlbGYtZXhwbGFuYXRvcnkg
c2luY2UgaXQNCmhhcyBiZWVuIHVzZWQgYWxyZWFkeS4gQnV0IHN1cmUsIG1heWJlIHdlIGNhbiBi
ZSBleHBsaWNpdCBmcm9tIG5vdyBvbiBhbmQgc2F5DQpmcm9tICdRdWFsY29tbSBTTTg2NTAgb253
YXJkcycuDQoNCmNvbW1pdCBjNWQwMmJiYWEyMTdiMjQ1NGJhMWNlNzUyODExM2FhMmVjZjE0ZjNj
DQoNCj4gQWxzbywgdGhlIGRyaXZlciBpc24ndCBlbmFibGVkICJvbiBRdWFsY29tbSBTTTg2NTAr
IiwgaXQncyBlbmFibGVkIGluDQo+IHRoZSBBbTY0IGRlZmNvbmZpZywgaS5lLiBpdCdzIGVuYWJs
ZWQgb24gYWxsIEFybTY0IGJvYXJkcyAtIHRoZQ0KPiBxdWVzdGlvbiB0aGF0IHNob3VsZCBiZSBh
bnN3ZXJlZCBieSB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgIndoeT8iLg0KPiANCg0KRXZlbiB0aG91
Z2ggd2UgYXJlIGVuYWJsaW5nIHRoaXMgdmlhIHRoZSBhcm02NCBkZWZjb25maWcsIGl0IGlzIG5v
dCB0cnVlIHRoYXQNCnRoZSBkcml2ZXIgaXMgYXBwbGljYWJsZSBmb3IgYWxsIGFybTY0IGJvYXJk
cy4gVGhlIHNpbXBsZSByZWFzb24gYmVpbmcgdGhhdA0KdGhlIFFURUUgZmlybXdhcmUgT1MgdGhh
dCB0aGUgZHJpdmVyIGNvbW11bmljYXRlcyB3aXRoIHJ1bnMgb25seSBvbiBRdWFsY29tbQ0KU29D
cyB1c2luZyBhcm02NCBDUFVzIHdpdGggQVJNIFRydXN0Wm9uZSB0ZWNobm9sb2d5Lg0KDQpUaGlz
IGlzIHdoeSBJIHdvdWxkIHRyeSB0byBhdm9pZCBhIGNvbW1pdCBtZXNzYWdlIHdoaWNoIGNsYWlt
cyB0aGUgdGhlIGRyaXZlcg0KaXMgYXBwbGljYWJsZSB0byBhbGwgYXJtNjQgYm9hcmRzLg0KDQpC
YXNlZCBvbiBhbGwgdGhpcywgSSBhbSB0aGlua2luZyBwZXJoYXBzIGl0IHdvdWxkIGJlIGJldHRl
ciB0byBzYXkgdGhhdCB0aGUNCnBhdGNoIGVuYWJsZXMgUUNPTVRFRSBkcml2ZXIgZm9yIFF1YWxj
b21tIFNvQ3Mgd2l0aCBhcm02NCBDUFVzPyBXZSBjb3VsZCBkcm9wDQptZW50aW9ucyBvZiBzcGVj
aWZpYyBTTTh4NTAgbW9kZWxzIHdpdGggSERLL01UUCBib2FyZHMgc2luY2UgdGhlIGZlYXR1cmUg
aXMNCmFnbm9zdGljIHRvIHRob3NlPw0KDQo+IA0KPiBQUy4gV2hlbiB5b3UgdGhlbiBydW4gImdp
dCBsb2cgYXJjaC9hcm02NC9jb25maWcvZGVmY29uZmlnIiwgdGhlDQo+IGluZm9ybWF0aW9uIHRo
YXQgZW5hYmxpbmcgUUNPTVRFRSBkb2Vzbid0IHJlcXVpcmUgRGV2aWNlVHJlZSBjaGFuZ2VzDQo+
IGlzIG5vdCB1c2VmdWwuDQo+IA0KDQpTdXJlLCBJIHdpbGwgZHJvcCB0aGUgaW5mbyBvbiBEVFMg
ZmlsZXMgSSBhZGRlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNClRoYW5rcywNCkhhcnNoYWwN
Cg0KPiBSZWdhcmRzLA0KPiBCam9ybg0KPiANCj4+Pg0KPj4+IFVzYWdlIG9mIHNvbWV0aGluZyBv
biBTb0MgaXMgbm90IGEgcHJvb2YgdGhhdCBpdCBhY3R1YWxseSBpcyB1c2VkIGJ5DQo+Pj4gdXBz
dHJlYW0gcGxhdGZvcm1zIGFuZCB3ZSBhYnNvbHV0ZWx5IGRvIG5vdCBjYXJlIGF0IGFsbCBhYm91
dCBkb3duc3RyZWFtDQo+Pj4gdXNlcnMuIEkgc3BlbnQgd2F5IHRvbyBtdWNoIHRpbWUgb24gdGhp
cyBhbmQgZXZlbiB2ZXJ5IHNwZWNpZmljDQo+Pj4gaW5zdHJ1Y3Rpb25zIHdlcmUgbm90IHdvcmtp
bmcsIHNvIEkgZG9uJ3Qga25vdyBob3cgZWxzZSBJIGNhbiBoZWxwLg0KPj4+DQo+Pj4gQmVzdCBy
ZWdhcmRzLA0KPj4+IEtyenlzenRvZg0KPj4NCj4+DQo+Pg0KPj4gLS0NCj4+IFdpdGggYmVzdCB3
aXNoZXMNCj4+IERtaXRyeQ0KDQo=
