Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4FECAC582
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:16:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 243FE4FE20
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757650568;
	bh=BS/PhMvjYjw8EpPQ4bKNPyj0JOAez6vXXQ0DMEEkIM0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ai39N+yZBVyHVsKyAS1M7rRf9rmo0oFZCEn8MMt+QO9e98BvKwu4Gmx0y2q5BIbYg
	 3znyozW+m9/3JglVac373qvxqncrMScRQUR23VUoUCMNbQkwh3J0kzc9wqv28K4eQE
	 KDxig/21DzWzlVdKpaE7RY+GR0YWS0MrYXV0OVGGzx/rSsGKkY0C5Tj7m75DBW51Ha
	 vWv7vggrAp0YevuGTiAiExhyoHKxuFwXStEMt8DziY5SSgRicde1OpVfUV2sXbmtpz
	 8ZIgUeT8GsGFLPg/56OAAnyoyXCjXvyCLfzm/EUJC/Rc0VyMZPOK/a6hS6JI2h7gpG
	 Q6LJ2c9k85tFw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7340E4FE21
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:10:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TNkOHbJi;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BKJfOb025658
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KshnCh+SdyV/dCJ+ijsZgVdQUq4wg9HM9/HtdTEmuMI=; b=TNkOHbJixVcQOnfh
	AZOxdlwRhXQxWIhOXqJVpOwzmEMc1WQXIkrRAzlXzYas3JMyve3jBnXFFB2FEPZ/
	6A6BC4LlUnNg9B4U+k/0J27Hzt99BCU/JEAyojG8QvYicWvAYWTXBE5syg80kHcZ
	GmClmwlfWb3wMKbMlTkByAUL98QQmbY0HmciZ5ccchL7+LRu/uYyYHDJYOXRVzV+
	L0gtKmGiAapaAMUOfFbfSNv6fKBOgSfF9QfuQnXSYAkKjN4Tpb0XXXOtxpMW3gcZ
	ENfJqWQWi80cIrfqiiHu69A+wlqNf3EeZ9g3PWaSbLfNUKV6C385YhCSmWhClmTZ
	hr04lw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj124jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:10:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c928089fdso1903216a12.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 21:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650202; x=1758255002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KshnCh+SdyV/dCJ+ijsZgVdQUq4wg9HM9/HtdTEmuMI=;
        b=V60rs0JvuiuWGcHoDKhMMGg5v96i12bRBd3aEPr/9JdqRrKT+os1frmJUu8t3ftXFv
         OnNzJcOvWYmVPeKIiZiYYEYqcG1pQF/iCQtpyOrKJMjSYWzHjg1cveQAcQo06bAGX8Np
         kQW84Z8UCwgJIIAAp1W6Ri4uNmtmUuuTStX3bpnhL4LYVkZWTV7kSOxlxtKvTQsH4fC2
         ozdL+78yBygnZIfcm0vgRw89iDEumJbXzaCqYOmB7yaDdq7PUOyr9uLAQ/Rd/UptTXTV
         owWtevPfLnew+voDQoheOCwRnbdxJdK4S+tdfDepkPz8tCVpp1DmJSXMfgESbS6fkBfK
         8X6g==
X-Forwarded-Encrypted: i=1; AJvYcCUTGdgOClcr9bKovPQImKfwpmqrrqRRZ9qqS4cQZ/mOWw4n6Z9P0D4e+gJqP5723mIoDVoYTWQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxUANcpadtYXkLrbUIfTpIc151ObxADA1kCT0l6GzU3lSLywXmB
	job5cfRC+hTuTyT23zmRWN8WuyNeXxrxK2o6bWYzQJ0DpbetIWWKXB7mhB1jnlQcYNmzrR58cn/
	1PRpOjXdVkVugDR/mRfm0/cYLO1AsrGsq3Xn3T2rRlfD0EPiwiC/PdD5EJ8fsM34KAgMui88=
X-Gm-Gg: ASbGncsH9EZCc5Sg5axl+uWqCmhH0JRSCSrTAgqXbY52LCXT8+BPTIMPd3yhuUIGudZ
	UWVxBAYki6h/SzMTdd5k5+S84RGycyFm4fQz/gfVzXqLfGwXbfDOREb9iCA4soyhJbHhSdi0AOV
	piGpHIPfUJRwxOB2lcQ+OgKS9eRpXUSOhmJwGuG1JXMSUZDz8zlUGObTeLdrI7P7fwTgdFnbmL2
	8N1JlB/ruDZoKt+QXhpPo7j7f8Lh2bRoM0qoOr/Nt1RIhA5Ut5UtKv7hjiyVHpcIZZ5kqnI0asY
	vHB3QBadQ9h/Inne1b5gAQ0qgEpQCFBbKSXDUmjXCggP1mPac6Ceauuz7B0UfNvDKlkWi32q3As
	xHbmwkr/gnrtSRxBvhScJ0dnEWJTAByfW9I11aA==
X-Received: by 2002:a17:902:e806:b0:24d:9c86:5e53 with SMTP id d9443c01a7336-25d2528c33fmr25708345ad.2.1757650201531;
        Thu, 11 Sep 2025 21:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwp/HT+eze7OdmN0bL7uPSkHMToITqBrF5O2fzVOuInpFpVsUM/5RBxwa6aH5dJdICPsWOiw==
X-Received: by 2002:a17:902:e806:b0:24d:9c86:5e53 with SMTP id d9443c01a7336-25d2528c33fmr25707515ad.2.1757650200511;
        Thu, 11 Sep 2025 21:10:00 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84f72fsm33947645ad.72.2025.09.11.21.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 21:09:59 -0700 (PDT)
Message-ID: <8eb37181-09fb-4d5b-8cda-83777dd5ece0@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 14:09:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
 <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-5-520e867b3d74@oss.qualcomm.com>
 <CAHUa44EsGNuYzjZo_kBJfa6O6u0o14tfDNo2fhSeo+g0BpwX7Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44EsGNuYzjZo_kBJfa6O6u0o14tfDNo2fhSeo+g0BpwX7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Dk3Rt5ieOFjeJL430IGoFFoJuTd76P2w
X-Proofpoint-GUID: Dk3Rt5ieOFjeJL430IGoFFoJuTd76P2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX96buAYyOMBIT
 7R3NzPf4bzaJ4UmMwlZMtmx9wpL2zdI0Oqqu265LIGugmWItLSkt7eBnGj1u/HF6cdcPQUhs+vV
 tzfAkFvd6uXG29QCm9rYNd9UWOU3JkQgLvxQZ3WKSTdbBapf4y01nnqkgiVAqQ9/N07WR8Q5ZSD
 Z4L2kyZwFcnEGQJEHp9t2NAMmGMHrju/8hBanzNrWw1v8E0u53VXw7FuHkEzGSIf6jOLziZZYjh
 ADMlZSRWkb103fUVxy1I6pyZheYAErdw4e8lpvri0WPZJ+jaMzXtZ1rJ1hl62Rvn4/yKCGY4it8
 iy6U9Jz3BYsiTiMjtiWQWUF0i76yMMoj14R5Co8jXLW6xznBth68YujtS4Ns/il3s2+ooa4Rwrl
 hKvCWBY9
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c39d1b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=oB-xqKmB0luAZTjYqwwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024
X-Rspamd-Queue-Id: 7340E4FE21
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[1.41.240.65:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: E4IEDCRUGS2PVZ34LXDEPAHVOATPJQNH
X-Message-ID-Hash: E4IEDCRUGS2PVZ34LXDEPAHVOATPJQNH
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/E4IEDCRUGS2PVZ34LXDEPAHVOATPJQNH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gOS8xMS8yMDI1IDU6NTYgUE0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0K
PiBIaSBBbWlyLA0KPiANCj4gT24gVGh1LCBTZXAgMTEsIDIwMjUgYXQgNTo0MeKAr0FNIEFtaXJy
ZXphIFphcnJhYmkNCj4gPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gRm9yIGRyaXZlcnMgdGhhdCBjYW4gdHJhbnNmZXIgZGF0YSB0byB0aGUgVEVFIHdp
dGhvdXQgdXNpbmcgc2hhcmVkDQo+PiBtZW1vcnkgZnJvbSBjbGllbnQsIGl0IGlzIG5lY2Vzc2Fy
eSB0byByZWNlaXZlIHRoZSB1c2VyIGFkZHJlc3MNCj4+IGRpcmVjdGx5LCBieXBhc3NpbmcgYW55
IHByb2Nlc3NpbmcgYnkgdGhlIFRFRSBzdWJzeXN0ZW0uIEludHJvZHVjZQ0KPj4gVEVFX0lPQ1RM
X1BBUkFNX0FUVFJfVFlQRV9VQlVGX0lOUFVUL09VVFBVVC9JTk9VVCB0byByZXByZXNlbnQNCj4+
IHVzZXJzcGFjZSBidWZmZXJzLg0KPj4NCj4+IFJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1p
dC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQo+PiBUZXN0ZWQtYnk6IE5laWwgQXJtc3Ryb25nIDxu
ZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPg0KPj4gVGVzdGVkLWJ5OiBIYXJzaGFsIERldiA8cXVp
Y19oZGV2QHF1aWNpbmMuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQW1pcnJlemEgWmFycmFiaSA8
YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy90
ZWUvdGVlX2NvcmUuYyAgIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
PiAgaW5jbHVkZS9saW51eC90ZWVfZHJ2LmggIHwgIDYgKysrKysrDQo+PiAgaW5jbHVkZS91YXBp
L2xpbnV4L3RlZS5oIHwgMjIgKysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4gIDMgZmlsZXMgY2hh
bmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy90ZWUvdGVlX2NvcmUuYyBiL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMNCj4+IGlu
ZGV4IGY4NTM0YTAwYzU2Yy4uYmIyZTNhNmMyM2EzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy90
ZWUvdGVlX2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy90ZWUvdGVlX2NvcmUuYw0KPj4gQEAgLTQ1
Nyw2ICs0NTcsMTcgQEAgc3RhdGljIGludCBwYXJhbXNfZnJvbV91c2VyKHN0cnVjdCB0ZWVfY29u
dGV4dCAqY3R4LCBzdHJ1Y3QgdGVlX3BhcmFtICpwYXJhbXMsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICBwYXJhbXNbbl0udS52YWx1ZS5iID0gaXAuYjsNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHBhcmFtc1tuXS51LnZhbHVlLmMgPSBpcC5jOw0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQo+PiArICAgICAgICAgICAgICAgY2FzZSBURUVfSU9DVExfUEFSQU1fQVRU
Ul9UWVBFX1VCVUZfSU5QVVQ6DQo+PiArICAgICAgICAgICAgICAgY2FzZSBURUVfSU9DVExfUEFS
QU1fQVRUUl9UWVBFX1VCVUZfT1VUUFVUOg0KPj4gKyAgICAgICAgICAgICAgIGNhc2UgVEVFX0lP
Q1RMX1BBUkFNX0FUVFJfVFlQRV9VQlVGX0lOT1VUOg0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcGFyYW1zW25dLnUudWJ1Zi51YWRkciA9IHU2NF90b191c2VyX3B0cihpcC5hKTsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHBhcmFtc1tuXS51LnVidWYuc2l6ZSA9IGlwLmI7DQo+PiAr
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWFjY2Vzc19vayhwYXJhbXNbbl0udS51
YnVmLnVhZGRyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFy
YW1zW25dLnUudWJ1Zi5zaXplKSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FRkFVTFQ7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4+ICAgICAgICAgICAgICAgICBjYXNlIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfTUVNUkVG
X0lOUFVUOg0KPj4gICAgICAgICAgICAgICAgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQ
RV9NRU1SRUZfT1VUUFVUOg0KPj4gICAgICAgICAgICAgICAgIGNhc2UgVEVFX0lPQ1RMX1BBUkFN
X0FUVFJfVFlQRV9NRU1SRUZfSU5PVVQ6DQo+PiBAQCAtNDkwLDYgKzUwMSwxMSBAQCBzdGF0aWMg
aW50IHBhcmFtc190b191c2VyKHN0cnVjdCB0ZWVfaW9jdGxfcGFyYW0gX191c2VyICp1cGFyYW1z
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1dF91c2VyKHAtPnUudmFsdWUuYywg
JnVwLT5jKSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFV
TFQ7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgICAgICAg
ICBjYXNlIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfVUJVRl9PVVRQVVQ6DQo+PiArICAgICAg
ICAgICAgICAgY2FzZSBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX1VCVUZfSU5PVVQ6DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBpZiAocHV0X3VzZXIoKHU2NClwLT51LnVidWYuc2l6ZSwg
JnVwLT5iKSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFV
TFQ7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICAgICAgICAg
ICBjYXNlIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfTUVNUkVGX09VVFBVVDoNCj4+ICAgICAg
ICAgICAgICAgICBjYXNlIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfTUVNUkVGX0lOT1VUOg0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHB1dF91c2VyKCh1NjQpcC0+dS5tZW1yZWYu
c2l6ZSwgJnVwLT5iKSkNCj4+IEBAIC02OTAsNiArNzA2LDEzIEBAIHN0YXRpYyBpbnQgcGFyYW1z
X3RvX3N1cHAoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICBpcC5iID0gcC0+dS52YWx1ZS5iOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgaXAu
YyA9IHAtPnUudmFsdWUuYzsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4g
KyAgICAgICAgICAgICAgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9VQlVGX0lOUFVU
Og0KPj4gKyAgICAgICAgICAgICAgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9VQlVG
X09VVFBVVDoNCj4+ICsgICAgICAgICAgICAgICBjYXNlIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZ
UEVfVUJVRl9JTk9VVDoNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlwLmEgPSAoX19mb3Jj
ZSB1NjQpcC0+dS51YnVmLnVhZGRyOw0KPiANCj4gVGhlcmUncyBhIHdhcm5pbmcgb24gYXJtMzI6
DQo+IGRyaXZlcnMvdGVlL3RlZV9jb3JlLmM6IEluIGZ1bmN0aW9uICdwYXJhbXNfdG9fc3VwcCc6
DQo+IGRyaXZlcnMvdGVlL3RlZV9jb3JlLmM6ODIxOjMyOiB3YXJuaW5nOiBjYXN0IGZyb20gcG9p
bnRlciB0byBpbnRlZ2VyDQo+IG9mIGRpZmZlcmVudCBzaXplIFstV3BvaW50ZXItdG8taW50LWNh
c3RdDQo+ICAgODIxIHwgICAgICAgICAgICAgICAgICAgICAgICAgaXAuYSA9IChfX2ZvcmNlIHU2
NClwLT51LnVidWYudWFkZHI7DQo+IA0KPiBJIHRoaW5rIHlvdSBuZWVkIHRvIGNhc3QgdG8gdW5z
aWduZWQgbG9uZyBpbnN0ZWFkLg0KPiANCj4gQ2hlZXJzLA0KPiBKZW5zDQoNCllvdSBhcmUgcmln
aHQuIFVwZGF0ZWQuIFRoYW5rcy4NCg0KUmVnYXJkcywNCkFtaXINCg0KPiANCj4gDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICBpcC5iID0gcC0+dS51YnVmLnNpemU7DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICBpcC5jID0gMDsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPj4gICAgICAgICAgICAgICAgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9NRU1S
RUZfSU5QVVQ6DQo+PiAgICAgICAgICAgICAgICAgY2FzZSBURUVfSU9DVExfUEFSQU1fQVRUUl9U
WVBFX01FTVJFRl9PVVRQVVQ6DQo+PiAgICAgICAgICAgICAgICAgY2FzZSBURUVfSU9DVExfUEFS
QU1fQVRUUl9UWVBFX01FTVJFRl9JTk9VVDoNCj4+IEBAIC03OTIsNiArODE1LDE2IEBAIHN0YXRp
YyBpbnQgcGFyYW1zX2Zyb21fc3VwcChzdHJ1Y3QgdGVlX3BhcmFtICpwYXJhbXMsIHNpemVfdCBu
dW1fcGFyYW1zLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgcC0+dS52YWx1ZS5iID0gaXAu
YjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHAtPnUudmFsdWUuYyA9IGlwLmM7DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgICAgICAgICBjYXNlIFRF
RV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfVUJVRl9PVVRQVVQ6DQo+PiArICAgICAgICAgICAgICAg
Y2FzZSBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX1VCVUZfSU5PVVQ6DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICBwLT51LnVidWYudWFkZHIgPSB1NjRfdG9fdXNlcl9wdHIoaXAuYSk7DQo+
PiArICAgICAgICAgICAgICAgICAgICAgICBwLT51LnVidWYuc2l6ZSA9IGlwLmI7DQo+PiArDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWFjY2Vzc19vayhwYXJhbXNbbl0udS51YnVm
LnVhZGRyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1z
W25dLnUudWJ1Zi5zaXplKSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FRkFVTFQ7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+
ICAgICAgICAgICAgICAgICBjYXNlIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfTUVNUkVGX09V
VFBVVDoNCj4+ICAgICAgICAgICAgICAgICBjYXNlIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVf
TUVNUkVGX0lOT1VUOg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3RlZV9kcnYuaCBiL2luY2x1ZGUvbGludXgvdGVlX2Rydi5oDQo+
PiBpbmRleCA4MjRmMTI1MWRlNjAuLjc5MTVlODg2OWNiZCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1
ZGUvbGludXgvdGVlX2Rydi5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L3RlZV9kcnYuaA0KPj4g
QEAgLTgyLDYgKzgyLDExIEBAIHN0cnVjdCB0ZWVfcGFyYW1fbWVtcmVmIHsNCj4+ICAgICAgICAg
c3RydWN0IHRlZV9zaG0gKnNobTsNCj4+ICB9Ow0KPj4NCj4+ICtzdHJ1Y3QgdGVlX3BhcmFtX3Vi
dWYgew0KPj4gKyAgICAgICB2b2lkIF9fdXNlciAqdWFkZHI7DQo+PiArICAgICAgIHNpemVfdCBz
aXplOw0KPj4gK307DQo+PiArDQo+PiAgc3RydWN0IHRlZV9wYXJhbV92YWx1ZSB7DQo+PiAgICAg
ICAgIHU2NCBhOw0KPj4gICAgICAgICB1NjQgYjsNCj4+IEBAIC05Miw2ICs5Nyw3IEBAIHN0cnVj
dCB0ZWVfcGFyYW0gew0KPj4gICAgICAgICB1NjQgYXR0cjsNCj4+ICAgICAgICAgdW5pb24gew0K
Pj4gICAgICAgICAgICAgICAgIHN0cnVjdCB0ZWVfcGFyYW1fbWVtcmVmIG1lbXJlZjsNCj4+ICsg
ICAgICAgICAgICAgICBzdHJ1Y3QgdGVlX3BhcmFtX3VidWYgdWJ1ZjsNCj4+ICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgdGVlX3BhcmFtX3ZhbHVlIHZhbHVlOw0KPj4gICAgICAgICB9IHU7DQo+PiAg
fTsNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdGVlLmggYi9pbmNsdWRlL3Vh
cGkvbGludXgvdGVlLmgNCj4+IGluZGV4IGQ4NDNjZjk4MGQ5OC4uMGUzYjczNWRjZmNhIDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3RlZS5oDQo+PiArKysgYi9pbmNsdWRlL3Vh
cGkvbGludXgvdGVlLmgNCj4+IEBAIC0xNTEsNiArMTUxLDEzIEBAIHN0cnVjdCB0ZWVfaW9jdGxf
YnVmX2RhdGEgew0KPj4gICNkZWZpbmUgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9NRU1SRUZf
T1VUUFVUICAgICAgICA2DQo+PiAgI2RlZmluZSBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX01F
TVJFRl9JTk9VVCA3ICAgICAgIC8qIGlucHV0IGFuZCBvdXRwdXQgKi8NCj4+DQo+PiArLyoNCj4+
ICsgKiBUaGVzZSBkZWZpbmVzIHVzZXJzcGFjZSBidWZmZXIgcGFyYW1ldGVycy4NCj4+ICsgKi8N
Cj4+ICsjZGVmaW5lIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfVUJVRl9JTlBVVCAgIDgNCj4+
ICsjZGVmaW5lIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfVUJVRl9PVVRQVVQgIDkNCj4+ICsj
ZGVmaW5lIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfVUJVRl9JTk9VVCAgIDEwICAgICAgLyog
aW5wdXQgYW5kIG91dHB1dCAqLw0KPj4gKw0KPj4gIC8qDQo+PiAgICogTWFzayBmb3IgdGhlIHR5
cGUgcGFydCBvZiB0aGUgYXR0cmlidXRlLCBsZWF2ZXMgcm9vbSBmb3IgbW9yZSB0eXBlcw0KPj4g
ICAqLw0KPj4gQEAgLTE4NiwxNCArMTkzLDE3IEBAIHN0cnVjdCB0ZWVfaW9jdGxfYnVmX2RhdGEg
ew0KPj4gIC8qKg0KPj4gICAqIHN0cnVjdCB0ZWVfaW9jdGxfcGFyYW0gLSBwYXJhbWV0ZXINCj4+
ICAgKiBAYXR0cjogYXR0cmlidXRlcw0KPj4gLSAqIEBhOiBpZiBhIG1lbXJlZiwgb2Zmc2V0IGlu
dG8gdGhlIHNoYXJlZCBtZW1vcnkgb2JqZWN0LCBlbHNlIGEgdmFsdWUgcGFyYW1ldGVyDQo+PiAt
ICogQGI6IGlmIGEgbWVtcmVmLCBzaXplIG9mIHRoZSBidWZmZXIsIGVsc2UgYSB2YWx1ZSBwYXJh
bWV0ZXINCj4+ICsgKiBAYTogaWYgYSBtZW1yZWYsIG9mZnNldCBpbnRvIHRoZSBzaGFyZWQgbWVt
b3J5IG9iamVjdCwNCj4+ICsgKiAgICAgZWxzZSBpZiBhIHVidWYsIGFkZHJlc3Mgb2YgdGhlIHVz
ZXIgYnVmZmVyLA0KPj4gKyAqICAgICBlbHNlIGEgdmFsdWUgcGFyYW1ldGVyDQo+PiArICogQGI6
IGlmIGEgbWVtcmVmIG9yIHVidWYsIHNpemUgb2YgdGhlIGJ1ZmZlciwgZWxzZSBhIHZhbHVlIHBh
cmFtZXRlcg0KPj4gICAqIEBjOiBpZiBhIG1lbXJlZiwgc2hhcmVkIG1lbW9yeSBpZGVudGlmaWVy
LCBlbHNlIGEgdmFsdWUgcGFyYW1ldGVyDQo+PiAgICoNCj4+IC0gKiBAYXR0ciAmIFRFRV9QQVJB
TV9BVFRSX1RZUEVfTUFTSyBpbmRpY2F0ZXMgaWYgbWVtcmVmIG9yIHZhbHVlIGlzIHVzZWQgaW4N
Cj4+IC0gKiB0aGUgdW5pb24uIFRFRV9QQVJBTV9BVFRSX1RZUEVfVkFMVUVfKiBpbmRpY2F0ZXMg
dmFsdWUgYW5kDQo+PiAtICogVEVFX1BBUkFNX0FUVFJfVFlQRV9NRU1SRUZfKiBpbmRpY2F0ZXMg
bWVtcmVmLiBURUVfUEFSQU1fQVRUUl9UWVBFX05PTkUNCj4+IC0gKiBpbmRpY2F0ZXMgdGhhdCBu
b25lIG9mIHRoZSBtZW1iZXJzIGFyZSB1c2VkLg0KPj4gKyAqIEBhdHRyICYgVEVFX1BBUkFNX0FU
VFJfVFlQRV9NQVNLIGluZGljYXRlcyBpZiBtZW1yZWYsIHVidWYsIG9yIHZhbHVlIGlzDQo+PiAr
ICogdXNlZCBpbiB0aGUgdW5pb24uIFRFRV9QQVJBTV9BVFRSX1RZUEVfVkFMVUVfKiBpbmRpY2F0
ZXMgdmFsdWUsDQo+PiArICogVEVFX1BBUkFNX0FUVFJfVFlQRV9NRU1SRUZfKiBpbmRpY2F0ZXMg
bWVtcmVmLCBhbmQgVEVFX1BBUkFNX0FUVFJfVFlQRV9VQlVGXyoNCj4+ICsgKiBpbmRpY2F0ZXMg
dWJ1Zi4gVEVFX1BBUkFNX0FUVFJfVFlQRV9OT05FIGluZGljYXRlcyB0aGF0IG5vbmUgb2YgdGhl
IG1lbWJlcnMNCj4+ICsgKiBhcmUgdXNlZC4NCj4+ICAgKg0KPj4gICAqIFNoYXJlZCBtZW1vcnkg
aXMgYWxsb2NhdGVkIHdpdGggVEVFX0lPQ19TSE1fQUxMT0Mgd2hpY2ggcmV0dXJucyBhbg0KPj4g
ICAqIGlkZW50aWZpZXIgcmVwcmVzZW50aW5nIHRoZSBzaGFyZWQgbWVtb3J5IG9iamVjdC4gQSBt
ZW1yZWYgY2FuIHJlZmVyZW5jZQ0KPj4NCj4+IC0tDQo+PiAyLjM0LjENCj4+DQoNCg==
