Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF266C87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 21:40:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2E7604FB80
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755121214;
	bh=htivv+q2rHxHNhpwVBleUW9uFnt1kDkXzOJ0HJjv3IA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GWCpYez0DpEuJn57UfDUSXsGeYxdt9stvfbE3oo3PVBPKv0FzdPfVKv93Cahb8/1l
	 ik6vwvjCCUMZgwlfcNGhM2Y44E2sU/aFFN04lflmwvQhi1s/pzifdcdvW+BAXbXCZO
	 UxXSvAlOcmM+rg60K6wlbzurZQDpcB7A5UrmDlMFdCFKpHPzJ1s0D9tguvUNzyqUKZ
	 At42qM3cSvFw8bu1wQ8SQ1pOlP/umR/A82xQ2Vz5wm4xF0wiolOMcso51Wda0pxYNA
	 dYOtsNZh6zAU4YkV4cZokGWnjupfUKqP1UMSJ3bD4H4xsCmV5UtLPAMcX+LMaQfe9A
	 SDpUh7K2vbOfQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D43BD42E7A
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 21:40:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RcAurwXz;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLfip027030
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 21:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsHqObljI/QrkzM/zyszZAc8Qk56TEyRi+eNAb+o/hY=; b=RcAurwXzpAKXEdOG
	TRd+OlbzSSziHs0RursQXpp6noZ1157tRtAJB1a5hc9wHvfkGroPDG5dHp6Ljypn
	0aGqE0F1t/d4Dd/mfibRk26WeUDnSxgtKX7y79C0/MDYNtUcq3TDGcV16JO8hlh3
	EENDO3rjpsi6Fv4IkkzTUAbvjJFcSsf3esTAVx3EujYoEznwzY0vrFdvvyYIM3fF
	hp20v9KwXZodHbcdfQgLfrzVbfsHbsUYycnGxFau+RMrcBfutST5fj8gPHEt+BcQ
	c3KdObkbzELN7QXHZYBC1VwYb+avioqwBX3p7DKrFP7aFYobmjX3ivPskkahobja
	vmWFOQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjs5un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 21:40:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445823e49fso2146865ad.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 14:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121199; x=1755725999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsHqObljI/QrkzM/zyszZAc8Qk56TEyRi+eNAb+o/hY=;
        b=WGfnFAzF36qwhNW97OL9MpglFbc5bAIfFpISl6XyETUPXnmabiKLegAspZZBaKR2Fo
         mGvtiuxWqjnRN0IhSmvywmy+Sy6hcrX49u8wWGHr9FHigEs7duneiObkripASVhPiZDR
         QiDzLgU/TTvpybhumAkj+fixYWZEHC39T9+3i4qv/p+P2gr9JZjw6Iv7imNePSA03HSL
         aoDy4G2nwPTncJdIJPdozwj+Z7vwlaoe0cDE1DG2pwVwpXWHcYOZ1bIHEtpIkRfqHkAL
         ukI2FMUKdH+GYhtMKXDZqJi1QCDOeyD55+wn99r0BilixMvtoKTkLFRjP75pW2f6ZTHn
         ItdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzeiUD+hAsJ5nStN2vByWlPArlwjNg81G5jBGcFq3yGQXvGOjjAg3MtnPcK0hr0iuRLvkUxgc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyodN6NKhe9+t4uQK1DcqVScVqAWwDyFH9O6GjXIbatGEl6GNQn
	a8IhYPw5esZWcPPp1QreJXNbN4/KSvtttiFryefmZ++5t9n42YLo22s94vkJJKMrsBeH2P4C4vz
	WY2Z2Edn0qArYLfEv2Dw4Kgh5ObRcQUlUZerVIgLwVri5HJcia+nndrN1LFwwwLYkaufVBE0=
X-Gm-Gg: ASbGnctDCh7PPub7mrarYaoTH+6XCoBWaQfhduAkY6yRKEzZTtnaSRGXXxmIEnrOkNo
	8WPtgJaKJjXrq2aWScUslmHy4z+4KAJt5Gr7blcJLkhTuDaj2byomJTV/O74GVnoOCoNlqv1+bJ
	IYJsdKPpi2RAqh+yG0z7DskY//H1ZTa0ZcVqP+7yTCedGiRnKTDs4qn9rBUOgDK+w3uPZHIKCQ4
	NL8OF3Hl6By71cnmSP8tZrh7pOF21mPbEtF0bOE44cN/iD4r/FoFbU1x1jgbSCohz1lRy7LeY/+
	zKDcbsFXjamZrvalcN6Y1P0YKrCATeIEtJMPGUX64ipCh4nilTSQfgvH1OBPT5iFv21Yao6Iv4l
	X+KmsqtZ8QDA0rBdRc/LXM6nyVAmJI/c3DiQvQg==
X-Received: by 2002:a17:902:e5d1:b0:240:7181:8287 with SMTP id d9443c01a7336-2445867ec8emr8191355ad.26.1755121199162;
        Wed, 13 Aug 2025 14:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCxnQfRjpH03Kj/5q/5ynChdc9Gz8ERDFxOMx6F+r9zzLYTor/b2ISAK2vcBWx9FA/ouTeDg==
X-Received: by 2002:a17:902:e5d1:b0:240:7181:8287 with SMTP id d9443c01a7336-2445867ec8emr8190975ad.26.1755121198721;
        Wed, 13 Aug 2025 14:39:58 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa9055sm336495925ad.150.2025.08.13.14.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:39:58 -0700 (PDT)
Message-ID: <d1009d7a-b675-4af0-a149-4856bca29140@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 07:39:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <CAHUa44FJ9iRMyDHffRBwgxxX27vTwsAwNiCCEGQ8fMQPZS_D+g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44FJ9iRMyDHffRBwgxxX27vTwsAwNiCCEGQ8fMQPZS_D+g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX+RJVrK+CMBZZ
 CdcNsU4gFiM+/aIqQdpz7tfZLrekxf+vkdPq/4j2xk1Gqrvx92KjA/zVIlLddhvbcsrl5SZfIdY
 7nkqhahlDrbbkc9gGaVD5GnFrAGmsFMvb4XttJ1JwoVMf/qrwIipWI4xL26wCuK5WLb9Df/vrkB
 w7B5vOPSYSDFSINi4X+DsmQgjwPal12gKv0Sjms3T5xPeCtTWylf+jRltP79bRQEj6CXNtQNfZu
 pKYiKV4slVbCcR2OdjDRIRVGhuRvIrNC0nU2+sdnxdMmKCTjuSJdz5C2JeGq77dYlMLjUAhYQv1
 6XnQe0kGuFqj6JpsWHlIqyTWf7Pwe6ce556fUIO4Q86aMoXWo9ev680hUnFJRUOboJtgEd3h6E3
 qATsgqvS
X-Proofpoint-GUID: er7Ur88SoJsfgLmaskBUC76VExMGqpo1
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689d0630 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=21D8NHQQAAAA:8 a=EUspDBNiAAAA:8
 a=tfL3YIuboUik3C6ywHYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22 a=aE7_2WBlPvBBVsBbSUWX:22
X-Proofpoint-ORIG-GUID: er7Ur88SoJsfgLmaskBUC76VExMGqpo1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074
X-Rspamd-Queue-Id: D43BD42E7A
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.40 / 15.00];
	BAYES_HAM(-1.30)[90.04%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.214.198:received,1.41.240.65:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: CDMA2OWJVM3NXNTH3XKSI44QI36NIZEF
X-Message-ID-Hash: CDMA2OWJVM3NXNTH3XKSI44QI36NIZEF
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CDMA2OWJVM3NXNTH3XKSI44QI36NIZEF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gOC8xMy8yMDI1IDU6NDkgUE0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0K
PiBIaSBBbWlyLA0KPiANCj4gT24gV2VkLCBBdWcgMTMsIDIwMjUgYXQgMjozN+KAr0FNIEFtaXJy
ZXphIFphcnJhYmkNCj4gPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gVGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyBhIFRydXN0ZWQgRXhlY3V0aW9u
IEVudmlyb25tZW50IChURUUpDQo+PiBkcml2ZXIgZm9yIFF1YWxjb21tIFRFRSAoUVRFRSkuIFFU
RUUgZW5hYmxlcyBUcnVzdGVkIEFwcGxpY2F0aW9ucyAoVEFzKQ0KPj4gYW5kIHNlcnZpY2VzIHRv
IHJ1biBzZWN1cmVseS4gSXQgdXNlcyBhbiBvYmplY3QtYmFzZWQgaW50ZXJmYWNlLCB3aGVyZQ0K
Pj4gZWFjaCBzZXJ2aWNlIGlzIGFuIG9iamVjdCB3aXRoIHNldHMgb2Ygb3BlcmF0aW9ucy4gQ2xp
ZW50cyBjYW4gaW52b2tlDQo+PiB0aGVzZSBvcGVyYXRpb25zIG9uIG9iamVjdHMsIHdoaWNoIGNh
biBnZW5lcmF0ZSByZXN1bHRzLCBpbmNsdWRpbmcgb3RoZXINCj4+IG9iamVjdHMuIEZvciBleGFt
cGxlLCBhbiBvYmplY3QgY2FuIGxvYWQgYSBUQSBhbmQgcmV0dXJuIGFub3RoZXIgb2JqZWN0DQo+
PiB0aGF0IHJlcHJlc2VudHMgdGhlIGxvYWRlZCBUQSwgYWxsb3dpbmcgYWNjZXNzIHRvIGl0cyBz
ZXJ2aWNlcy4NCj4+DQo+IA0KPiBUaGVyZSBhcmUgc29tZSBidWlsZCBlcnJvcnMvd2FybmluZ3Mg
Zm9yIGFybSBhbmQgeDg2XzY0LCBzZWUNCj4gaHR0cHM6Ly90dXhhcGkudHV4c3VpdGUuY29tL3Yx
L2dyb3Vwcy9saW5hcm8vcHJvamVjdHMvamVucy9wbGFucy8zMURtQ09uMXBGMkpHVkRrM290Qk9Y
T0w2a1YNCj4gDQoNCkknbGwgZml4IGl0Lg0KDQpSZWdhcmRzLA0KQW1pcg0KDQo+IFRoYW5rcywN
Cj4gSmVucw0KDQo=
