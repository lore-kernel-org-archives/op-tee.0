Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48806CA6015
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 22:56:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6BD9A454EC
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 22:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791500184;
	bh=zf8FVWfqvwGR66QpW/6RgAF9Eqe9eWsEHJtbYqk7UE8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uMtuDG/mcz+7mNwCEYBpkVIXICm89up1ctRFsFaOvhFZ90edEl+BKY0LkCjap1Vyb
	 GgZLe2Oq6O7Jcy9TCzJ5zS2dBVcZ3TpYR3X5zO1/ziJu66uFBf203YaIv3SmjTqLA9
	 G/v1bDOS5WIAwdPn0v2tZWTj6vOPAiE9sDmhcft/8BrQ3mJ063WmVzKR0FA7H2g7CN
	 xL3p+JaX7Rmww5OsOBhlFCqfrcy3r2NPO7xy6eaKX4roKa8OmSyayDrD1vPojFNkbb
	 l+PTAsv/zm1jHsv+4NehKSHT/E7fw79f1c/twl5AvBBr0uGfWVS8GU5CzvFFEfomhg
	 ch6KoqCnY5m2w==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ACF5245081
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 22:56:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VjcnveP7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ivQ8XTnZ;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698KxwQ6921827
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 22:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x1R3a3lX7xBG1rH21ZiJOz8wd4EF5DgZhVhNu/UOfns=; b=VjcnveP7FcU+lCYS
	Ba/x4qVGtl4f31sLb2fJW9V93vtlaj1jvzXL0GZ60xmRCglZHFQWydv+f95h84j/
	h0fSeuKGvt3SdUE1GRItOYaLsRjsiUrvbdBSn7yOVT7WIl9Ck2vCeK39JV/fmhgk
	f6A1PDe4cvLV97WX9v6QYldbSRF8LkehVPwDZw7QOV7uIMTOQcVL2qgFjEHmr/Ze
	GtH8y9R1W2D6VqBck9isC7qpTqpsQCeICJcUJKoJWg4UeTl3Yq7JBlhFhh3NiBDi
	OeX4nAfMv3Npv+E2OuZNmBKoDPj5E0JhZydE/n/N878MUKtq3oDL8ClFO6E0rOnk
	JMyvDg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxw8xn2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 22:56:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7d2ff0087so4534281a12.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791500175; x=1792104975; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1R3a3lX7xBG1rH21ZiJOz8wd4EF5DgZhVhNu/UOfns=;
        b=ivQ8XTnZIq4QAOLtXqtAZffW2S0LSZ5xpk3r2zt7flIj8F3UePMl3QBxkbf8Ixbyf0
         ZUbVW5L5BxM/Nk/wKMw1vYb+dAd7uPvdz30bHakgk0oHtQRO4IkZC/8oxE8THqSpb8Km
         GblGnCDBXShjMK6I1SXxzfebPpEzRuvFC62TaFkIS3r4fXiO9oJDuOGOd0nsI+TVvlEm
         n4S6N2MbBRZLNPxBOp/7UssRMUcnMHf474dmrr7UgkUqBlpQQELc31xlJu2gfbA6XdxQ
         5bO8qH2dlkOtxDFwufKV4k/O+r0QJuIIc64MSfp2j36II/LTeoMrqf53JfqgYYtPYnqX
         LtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791500175; x=1792104975;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1R3a3lX7xBG1rH21ZiJOz8wd4EF5DgZhVhNu/UOfns=;
        b=PqnPz6xcP2JXkmG6DVGVzsUbelxshOjI/hjbalPj0tFc1Aw++blz00gaai6ygNqMvq
         GM7rSuso39/MGF2Xmd1TRUSLeyEkP4RoZMocJG4he0DLgwxfqBImWvsaWL9NZ4MMd/uU
         49gaG3SICb6zV2YoxvTptoAV7w1vrzYiSgT+2DyCoC6q9LCrVcYcLAM+BvKGNnvnME1y
         UWkT/a7OJOI8eTSKU+9nb1nfqx3TZcBkLEO2y1Nc0zOx+8BHHFuqBIAtNSJsZntTARPN
         2RXxz6Cpa1iaNt7a5s5WkzlLsc4Xcitizfbf9zyHgKNDz2EQ6XWC1Rw3VajUqR8iEArb
         6i4A==
X-Forwarded-Encrypted: i=1; AKwUvByGQ1fVlkd+pZOTCRa3mXW463wfCpCvdXnunfOGD0Htxo+EwhXB9TF6R1uvXUVVWxQVCdSpH2s=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJy6OwYvDTdJ87/2raucF5LFAy0BRpeOMsJs0JfJnl+SsGI5atD
	ScL6aGD68r8Fk3KJjnd5u9SYnT5zeQrKsrexGM7hIe1ceULCCz4c2Y9p0Zot5an7etr8vNE8Tlg
	uyQm2rvP0/ef1J4/+4HsFA1v/2IhJHJQTP3Ii0eSVlpTIBC4kM3g10/otowMyAvuuZUub7c8=
X-Gm-Gg: AYBFou224M26FA85YLiVmD+LaW9mXqak0rkelG+iiWmX44iGqgK5OumO27jEtcEDzOA
	8M3KBDj/GFLl8Ld0qfNv8XnKccM+Z4bn/mM6f82kPbgI9gmBbaSe8Y+3Czg9zatPVxngN/wGRSy
	EFrWkERQnFSdMqBdbSxRP9WBS0eu/X1tlXvVbICDt8mcVqVh3qBmTnSAXwHp2z6M6o5HPqPK78T
	VUS47+LDo4BBTGKCfw3K1gRviBqfP02f6BHsQuwlv9ltTW4LIyh7gLcCBmFFQGgx+f5hoEZDh0P
	p7lPAjwcX5iZ0xCV3kocp4uGCVA2TFB8rPywJHyk1HloPVrHOXwjfxiMz/SjYlU7GlgNwv9etEK
	ZEkzudwXUGxPAlJvbQFgWOzKboNgUf9pD
X-Received: by 2002:a17:90b:3b48:b0:3a4:dc2c:be9e with SMTP id 98e67ed59e1d1-3ab3a8d5755mr217298a91.51.1791500174395;
        Thu, 08 Oct 2026 15:56:14 -0700 (PDT)
X-Received: by 2002:a17:90b:3b48:b0:3a4:dc2c:be9e with SMTP id 98e67ed59e1d1-3ab3a8d5755mr217285a91.51.1791500173870;
        Thu, 08 Oct 2026 15:56:13 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.12.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38ddac6dsm549161a91.7.2026.10.08.15.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 15:56:13 -0700 (PDT)
Message-ID: <f5682a0f-a0bf-46f2-a238-faeb1333c071@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 09:56:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 6/8] tee: optee: execute yielding RPMI calls
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
 <20261005-rpmi-tee-service-grp-dev-v2-6-72f222e23ec1@oss.qualcomm.com>
 <CAGgiveUzBk0Na13cqPRnQw8y2XdQ9LLktFK5eaJLTMiQZJPc_w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGgiveUzBk0Na13cqPRnQw8y2XdQ9LLktFK5eaJLTMiQZJPc_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA5MSBTYWx0ZWRfX/ncKCb/wM9rZ
 uIxPMjm8/ae80RgNYZ9+0p7mJHfLmQmQpgnVEQL4IbEhbeh2ZJT7/9VNB5vPtGlds6xIK2vOniI
 NhEVrEbURYnFKqmK7G9X8tiVIU/TUeumuO0QN5VMcOUHyc53YSml1Ykwq5HePWFaZYm4cZ94L9G
 hvp+Cg7Ra6q9yaT+tvr6N8me4z+1FlGxpBvddKtgryLHcM7ECSQIUFoA8OqlcQ2NOH5pmEp4mjs
 INcT2dA21w3ETXxBgX7ohLEO8GU6tTuqIhc6rWrN9Konj7Aek3cexS1AWDbQOXJ1rLpRheAZYRe
 GCLI4zZWZsD3cny0MnHVDyHOxVWki2Hh8J0qH8IonX+aZNpAJLOTwrzzXXMG/t/0zXNGswB2Uls
 R4MLgxpcbkix262EEV/c7aXNWK2BhvIm+OzBfOGiDtUNJWI2GXesbvRtOuzAotBnyQXhKfzB00c
 dZ7LGmQTS22ZPtbRd7Q==
X-Proofpoint-GUID: s1O6aZE1BHRy8BcH-DlVh9kD-Dav9tgf
X-Authority-Analysis: v=2.4 cv=cMB1IVeN c=1 sm=1 tr=0 ts=6ac81f8f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9v5PfQ1E2GNzj2RibJmqVw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=AUF5Mc4sii5JqdCOvnQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA5MSBTYWx0ZWRfX92qcpgKq8Xlg
 P9zBv1fEKWhUEUbiel7u74IgH+MBmhSfokKsxeu4pzmrBFNbdMANgBnblggHOnfCSTMCjdnH0YH
 PNhuOfPYmDNnhIOaSvpftitdXhpqMXE=
X-Proofpoint-ORIG-GUID: s1O6aZE1BHRy8BcH-DlVh9kD-Dav9tgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080091
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[65.181.12.250:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ACF5245081
X-Spamd-Bar: ----
Message-ID-Hash: YA4MCB4PVF3GAHZVM4GR3MWHXGAIWMEF
X-Message-ID-Hash: YA4MCB4PVF3GAHZVM4GR3MWHXGAIWMEF
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marouene Boubakri <marouene.boubakri@oss.nxp.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YA4MCB4PVF3GAHZVM4GR3MWHXGAIWMEF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gMTAvOC8yMDI2IDc6MTEgUE0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0K
PiBPbiBUdWUsIE9jdCA2LCAyMDI2IGF0IDI6NDDigK9BTSBBbWlycmV6YSBaYXJyYWJpDQo+IDxh
bWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPj4NCj4+IE9QLVRFRSBj
b21tYW5kcyBjYW4gc3BhbiBtdWx0aXBsZSBleGNoYW5nZXMgd2l0aCBub3JtYWwgd29ybGQuIEEg
Y2FsbA0KPj4gbWF5IHlpZWxkIHRvIHJlcXVlc3QgYW4gUlBDIHNlcnZpY2Ugb3IgYWxsb3cgaW50
ZXJydXB0IHByb2Nlc3NpbmcNCj4+IGJlZm9yZSBjb250aW51aW5nIGV4ZWN1dGlvbiBpbiBzZWN1
cmUgd29ybGQuDQo+Pg0KPj4gQWRkIHRoZSBSUE1JIHlpZWxkaW5nLWNhbGwgcGF0aCB1c2VkIGJ5
IHRoZSBjb21tb24gT1AtVEVFIHNlc3Npb24NCj4+IG9wZXJhdGlvbnMuIFN1Ym1pdCB0aGUgY29t
bWFuZCBhbmQgUlBDIGFyZ3VtZW50IGJ1ZmZlcnMgYXMgcmFuZ2VzDQo+PiB3aXRoaW4gYSBzaGFy
ZWQgbWVtb3J5IHBhcmNlbC4NCj4+DQo+PiBIYW5kbGUgUlBDIHJlcXVlc3RzIHdoaWxlIHRoZSBj
YWxsIGlzIHN1c3BlbmRlZCBhbmQgcmVzdW1lIGV4ZWN1dGlvbg0KPj4gdXNpbmcgdGhlIHRva2Vu
IHJldHVybmVkIGJ5IE9QLVRFRSB1bnRpbCB0aGUgY29tbWFuZCBjb21wbGV0ZXMuDQo+Pg0KPj4g
VXNlIHRoZSBjb21tb24gT1AtVEVFIGNhbGwgcXVldWUgdG8gd2FpdCB3aGVuIGFuIGluaXRpYWwg
cmVxdWVzdCBpcw0KPj4gcmVqZWN0ZWQgd2l0aCBSUE1JX0VSUl9CVVNZLCBhbGxvd2luZyBhbm90
aGVyIGFjdGl2ZSBjYWxsIHRvIGNvbXBsZXRlDQo+PiBiZWZvcmUgcmV0cnlpbmcuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQW1pcnJlemEgWmFycmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3MucXVh
bGNvbW0uY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy90ZWUvb3B0ZWUvcnBtaV9hYmkuYyB8IDEy
NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDEyNCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dGVlL29wdGVlL3JwbWlfYWJpLmMgYi9kcml2ZXJzL3RlZS9vcHRlZS9ycG1pX2FiaS5jDQo+PiBp
bmRleCA1OGQ4MjY3OGJlOTguLjZlNzYzMTY3OTRjMSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
dGVlL29wdGVlL3JwbWlfYWJpLmMNCj4+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL3JwbWlfYWJp
LmMNCj4+IEBAIC05LDYgKzksNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51eC9tYWlsYm94L3Jpc2N2
LXJwbWktbWVzc2FnZS5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC9vdmVyZmxvdy5oPg0KPj4gICNp
bmNsdWRlIDxsaW51eC9ycG1pX3RlZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0K
Pj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L3VuYWxpZ25l
ZC5oPg0KPj4gICNpbmNsdWRlICJvcHRlZV9wcml2YXRlLmgiDQo+PiBAQCAtNTYwLDMgKzU2MSwx
MjYgQEAgc3RhdGljIHZvaWQgb3B0ZWVfcnBtaV9oYW5kbGVfcnBjX2NtZChzdHJ1Y3QgdGVlX2Nv
bnRleHQgKmN0eCwNCj4+ICAgICAgICAgICAgICAgICBvcHRlZV9ycGNfY21kKGN0eCwgb3B0ZWUs
IGFyZyk7DQo+PiAgICAgICAgIH0NCj4+ICB9DQo+PiArDQo+PiArLyogSGFuZGxlIFJQQyBjb21t
YW5kIG9yIGludGVycnVwdCByZXR1cm5zIGZyb20gYSB5aWVsZGluZyBjYWxsLiAqLw0KPj4gK3N0
YXRpYyB2b2lkIG9wdGVlX3JwbWlfaGFuZGxlX3JwYyhzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwg
c3RydWN0IG9wdGVlICpvcHRlZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1MzIgcmVzdWx0LCBzdHJ1Y3Qgb3B0ZWVfbXNnX2FyZyAqYXJnKQ0KPj4gK3sNCj4+ICsgICAg
ICAgc3dpdGNoIChyZXN1bHQpIHsNCj4+ICsgICAgICAgY2FzZSBPUFRFRV9SUE1JX1lJRUxESU5H
X0NBTExfUkVUVVJOX1JQQ19DTUQ6DQo+PiArICAgICAgICAgICAgICAgb3B0ZWVfcnBtaV9oYW5k
bGVfcnBjX2NtZChjdHgsIG9wdGVlLCBhcmcpOw0KPj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0K
Pj4gKyAgICAgICBjYXNlIE9QVEVFX1JQTUlfWUlFTERJTkdfQ0FMTF9SRVRVUk5fSU5URVJSVVBU
Og0KPj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICBkZWZhdWx0Og0KPj4gKyAg
ICAgICAgICAgICAgIHByX3dhcm4oIlVua25vd24gUlBDIGZ1bmMgMHgleFxuIiwgcmVzdWx0KTsN
Cj4+ICsgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgfQ0KPj4gK30NCj4+ICsNCj4+
ICsvKioNCj4+ICsgKiBvcHRlZV9ycG1pX3lpZWxkaW5nX2NhbGwoKSAtIHN1Ym1pdCBhbmQgcmVz
dW1lIGEgeWllbGRpbmcgUlBNSSBjb21tYW5kDQo+PiArICogQGN0eDogY2FsbGluZyBjb250ZXh0
DQo+PiArICogQHJlcTogaW5pdGlhbCBjb21tYW5kIHJlcXVlc3QNCj4+ICsgKiBAcnBjX2FyZzog
c2hhcmVkIFJQQyBhcmd1bWVudCBidWZmZXINCj4+ICsgKiBAc3lzdGVtX3RocmVhZDogY2FsbGVy
IHJlcXVlc3RzIFRFRSBzeXN0ZW0gdGhyZWFkIHN1cHBvcnQNCj4+ICsgKg0KPj4gKyAqIE9ubHkg
UlBNSV9FUlJfQlVTWSByZWplY3Rpb24gb2YgdGhlIGluaXRpYWwgY29tbWFuZCBwZXJtaXRzIHJl
dHJ5Lg0KPj4gKyAqDQo+PiArICogUmV0dXJuOiB6ZXJvIG9uIGNvbXBsZXRpb24sIG9yIGEgbmVn
YXRpdmUgZXJyb3IuDQo+PiArICovDQo+PiArc3RhdGljIGludCBvcHRlZV9ycG1pX3lpZWxkaW5n
X2NhbGwoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qgb3B0ZWVfcnBtaV9jYWxsX3JlcSAqcmVxLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG9wdGVlX21zZ19hcmcg
KnJwY19hcmcsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHN5
c3RlbV90aHJlYWQpDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3Qgb3B0ZWUgKm9wdGVlID0gdGVl
X2dldF9kcnZkYXRhKGN0eC0+dGVlZGV2KTsNCj4+ICsgICAgICAgc3RydWN0IG9wdGVlX3JwbWlf
cmVzdW1lX3JlcSByZXN1bWUgPSB7DQo+PiArICAgICAgICAgICAgICAgLm9wID0gY3B1X3RvX2xl
MzIoT1BURUVfUlBNSV9ZSUVMRElOR19DQUxMX1JFU1VNRSksDQo+PiArICAgICAgICAgICAgICAg
LyogcmVzdW1lX3Rva2VuIGlzIG5vbnplcm8gYWZ0ZXIgT1AtVEVFIHN1c3BlbmRzIHRoZSBjYWxs
LiAqLw0KPj4gKyAgICAgICAgICAgICAgIC5yZXN1bWVfdG9rZW4gPSAwLA0KPiANCj4gSSBtaXNz
ZWQgdGhpcyB3aGVuIHJldmlld2luZyAidGVlOiBvcHRlZTogZGVmaW5lIHRoZSBSUE1JIGNvbnRy
b2wgYW5kDQo+IHBhcmNlbC1yZWZlcmVuY2UgQUJJIi4gSSdkIHByZWZlciBpZiB0aGUgcmVzdW1l
X3Rva2VuIHdhcyBhIHRydWx5DQo+IG9wYXF1ZSB2YWx1ZSwganVzdCBhcyBmb3IgdGhlIFNNQyBh
bmQgRkYtQSBBQklzLiBBbnkgcmVhc29uIHdoeSBpdCdzIGENCj4gNjQtYml0IHZhbHVlIGluc3Rl
YWQgb2YgMzItYml0LCBhcyBpcyB1c2VkIGZvciB0aGUgb3RoZXIgQUJJPw0KPiANCg0KQWdyZWVk
LiBJIGN1cnJlbnRseSB1c2UgYSB6ZXJvIHRva2VuIHRvIGRpc3Rpbmd1aXNoIHRoZSBpbml0aWFs
IHJlcXVlc3QNCmZyb20gYSByZXN1bWUuIEknbGwgdHJhY2sgdGhhdCBzZXBhcmF0ZWx5IHdpdGgg
YSBib29sZWFuIGFuZCB0cmVhdCB0aGUgdG9rZW4NCmFzIG9wYXF1ZSwgb25seSBjb3B5aW5nIGl0
IGZyb20gdGhlIHJlc3BvbnNlIGludG8gdGhlIHJlc3VtZSByZXF1ZXN0Lg0KDQpUaGVyZSBpcyBu
byBzcGVjaWZpYyByZWFzb24gZm9yIGl0IHRvIGJlIDY0LWJpdDsgSSBvdmVybG9va2VkIHRoZQ0K
ZXhpc3RpbmcgQUJJIGNvbnZlbnRpb24uIEknbGwgY2hhbmdlIGl0IHRvIDMyLWJpdC4NCg0KPj4g
KyAgICAgICB9Ow0KPj4gKyAgICAgICBzdHJ1Y3Qgb3B0ZWVfcnBtaV9jYWxsX3Jlc3AgcmVzcDsN
Cj4+ICsgICAgICAgc3RydWN0IG9wdGVlX2NhbGxfd2FpdGVyIHdhaXRlcjsNCj4+ICsgICAgICAg
dTMyIHJlc3VsdDsNCj4+ICsgICAgICAgczMyIHN0YXR1czsNCj4+ICsgICAgICAgaW50IHJldDsN
Cj4+ICsNCj4+ICsgICAgICAgb3B0ZWVfY3Ffd2FpdF9pbml0KCZvcHRlZS0+Y2FsbF9xdWV1ZSwg
JndhaXRlciwgc3lzdGVtX3RocmVhZCk7DQo+PiArICAgICAgIHdoaWxlICh0cnVlKSB7DQo+PiAr
ICAgICAgICAgICAgICAgaWYgKHJlc3VtZS5yZXN1bWVfdG9rZW4pDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICByZXQgPSBvcHRlZV9ycG1pX2NhbGxfd2l0aF9zdGF0dXMob3B0ZWUsICZyZXN1
bWUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKHJlc3VtZSksICZyZXNwLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihyZXNwKSwgJnN0YXR1
cyk7DQo+PiArICAgICAgICAgICAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0ID0gb3B0ZWVfcnBtaV9jYWxsX3dpdGhfc3RhdHVzKG9wdGVlLCByZXEsIHNpemVvZigqcmVx
KSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmcmVzcCwgc2l6ZW9mKHJlc3ApLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzdGF0dXMpOw0KPiANCj4gUGxlYXNl
IGZpeCB0aGUgdG9vLWxvbmcgbGluZXMgYWJvdmUuDQo+IA0KDQpBY2suDQoNCj4+ICsgICAgICAg
ICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBkb25lOw0K
Pj4gKw0KPj4gKyAgICAgICAgICAgICAgIHN3aXRjaCAoc3RhdHVzKSB7DQo+PiArICAgICAgICAg
ICAgICAgY2FzZSBSUE1JX1NVQ0NFU1M6DQo+IA0KPiBBbnkgcGFydGljdWxhciByZWFzb24gd2h5
IHdlIGFyZW4ndCB1c2luZyBURUUgZXJyb3IgY29kZXMgaGVyZT8NCj4gDQoNCkkgZGVmaW5lZCBS
UE1JIGVycm9yIGNvZGVzIGNvbnNpc3RlbnRseSBmb3IgYWxsIGNvbnRyb2wgcmVzcG9uc2VzIGlu
IG9wdGVlX3JwbWkuaC4NCkhvd2V2ZXIsIHRoZXNlIHN0YXR1c2VzIGJlbG9uZyB0byB0aGUgT1At
VEVFIHNlcnZpY2UgQUJJIHJhdGhlciB0aGFuIHRoZSB0cmFuc3BvcnQuDQpJJ2xsIGNoYW5nZSB0
aGVtIHRvIFRFRSBlcnJvciBjb2RlcyBhbmQga2VlcCBSUE1JIGVycm9ycyBhdCB0aGUgdHJhbnNw
b3J0IGxheWVyLg0KDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAg
ICAgICAgICAgICBjYXNlIFJQTUlfRVJSX0JVU1k6DQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoIXJlc3VtZS5yZXN1bWVfdG9rZW4pIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgb3B0ZWVfY3Ffd2FpdF9mb3JfY29tcGxldGlvbigmb3B0ZWUtPmNhbGxfcXVldWUs
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJndhaXRlcik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bnRpbnVlOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZmFsbHRocm91Z2g7DQo+PiArICAgICAgICAgICAgICAgZGVmYXVsdDoN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHJwbWlfdG9fbGludXhfZXJyb3Ioc3Rh
dHVzKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZG9uZTsNCj4+ICsgICAgICAg
ICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICAgICAgICAgcmVzdWx0ID0gZ2V0X3VuYWxpZ25l
ZF9sZTMyKCZyZXNwLnJlc3VsdCk7DQo+IA0KPiBXaHkgbm90IGxlMzJfdG9fY3B1KHJlc3AucmVz
dWx0KT8NCg0KWW91IGFyZSByaWdodCwgdGhlcmUgYXJlIGEgY291cGxlIG9mIG1vcmUgb2YgdGhp
cyB0aGF0IEkgbWlzc2VkLg0KSSdsbCBmaXggYWxsIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNClRo
YW5rcyBKZW5zIGZvciB0aGUgcmV2aWV3Lg0KDQpCZXN0IFJlZ2FyZHMsDQpBbWlyDQoNCj4gDQo+
IENoZWVycywNCj4gSmVucw0KPiANCj4+ICsgICAgICAgICAgICAgICBpZiAocmVzdWx0ID09IE9Q
VEVFX1JQTUlfWUlFTERJTkdfQ0FMTF9SRVRVUk5fRE9ORSkNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gZG9uZTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICBjb25kX3Jlc2NoZWQo
KTsNCj4+ICsgICAgICAgICAgICAgICBvcHRlZV9ycG1pX2hhbmRsZV9ycGMoY3R4LCBvcHRlZSwg
cmVzdWx0LCBycGNfYXJnKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICByZXN1bWUucmVzdW1l
X3Rva2VuID0gcmVzcC5yZXN1bWVfdG9rZW47DQo+PiArICAgICAgIH0NCj4+ICtkb25lOg0KPj4g
KyAgICAgICBvcHRlZV9jcV93YWl0X2ZpbmFsKCZvcHRlZS0+Y2FsbF9xdWV1ZSwgJndhaXRlcik7
DQo+PiArDQo+PiArICAgICAgIHJldHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPj4gKy8qIFRoZSBj
YWxsZXIgc3VwcGxpZXMgU0hNIHdpdGggcm9vbSBmb3IgY29tbWFuZCBhbmQgUlBDIGFyZ3MuICov
DQo+PiArc3RhdGljIGludCBvcHRlZV9ycG1pX2RvX2NhbGxfd2l0aF9hcmcoc3RydWN0IHRlZV9j
b250ZXh0ICpjdHgsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgdGVlX3NobSAqc2htLCB1X2ludCBvZmZzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYm9vbCBzeXN0ZW1fdGhyZWFkKQ0KPj4gK3sNCj4+ICsgICAgICAg
c3RydWN0IG9wdGVlICpvcHRlZSA9IHRlZV9nZXRfZHJ2ZGF0YShjdHgtPnRlZWRldik7DQo+PiAr
ICAgICAgIHN0cnVjdCBvcHRlZV9tc2dfYXJnICphcmcsICpycGNfYXJnOw0KPj4gKyAgICAgICBz
dHJ1Y3Qgb3B0ZWVfcnBtaV9jYWxsX3JlcSByZXE7DQo+PiArICAgICAgIHNpemVfdCBhcmdfc2l6
ZSwgcnBjX3NpemUsIHJwY19vZmZzZXQ7DQo+PiArICAgICAgIHUzMiBwYXJjZWxfaWQsIG5vbmNl
Ow0KPj4gKw0KPj4gKyAgICAgICBhcmcgPSB0ZWVfc2htX2dldF92YShzaG0sIG9mZnMpOw0KPj4g
KyAgICAgICBpZiAoSVNfRVJSKGFyZykpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9F
UlIoYXJnKTsNCj4+ICsNCj4+ICsgICAgICAgYXJnX3NpemUgPSBPUFRFRV9NU0dfR0VUX0FSR19T
SVpFKGFyZy0+bnVtX3BhcmFtcyk7DQo+PiArICAgICAgIHJwY19zaXplID0gT1BURUVfTVNHX0dF
VF9BUkdfU0laRShvcHRlZS0+cnBjX3BhcmFtX2NvdW50KTsNCj4+ICsgICAgICAgcnBjX29mZnNl
dCA9IG9mZnMgKyBhcmdfc2l6ZTsNCj4+ICsgICAgICAgcnBjX2FyZyA9IHRlZV9zaG1fZ2V0X3Zh
KHNobSwgcnBjX29mZnNldCk7DQo+PiArICAgICAgIGlmIChJU19FUlIocnBjX2FyZykpDQo+PiAr
ICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIocnBjX2FyZyk7DQo+PiArDQo+PiArICAgICAg
IG9wdGVlX3JwbWlfc2htX2dldF9pZGVudGl0eShzaG0sICZwYXJjZWxfaWQsICZub25jZSk7DQo+
PiArDQo+PiArICAgICAgIHJlcS5vcCA9IGNwdV90b19sZTMyKE9QVEVFX1JQTUlfWUlFTERJTkdf
Q0FMTF9XSVRIX0FSRyk7DQo+PiArICAgICAgIHJlcS5wYXJjZWxfaWQgPSBjcHVfdG9fbGUzMihw
YXJjZWxfaWQpOw0KPj4gKyAgICAgICByZXEubm9uY2UgPSBjcHVfdG9fbGUzMihub25jZSk7DQo+
PiArICAgICAgIHJlcS5hcmdfb2Zmc2V0ID0gY3B1X3RvX2xlNjQoKHU2NClzaG0tPm9mZnNldCAr
IG9mZnMpOw0KPj4gKyAgICAgICByZXEucnBjX29mZnNldCA9IGNwdV90b19sZTY0KCh1NjQpc2ht
LT5vZmZzZXQgKyBycGNfb2Zmc2V0KTsNCj4+ICsgICAgICAgcmVxLmFyZ19zaXplID0gY3B1X3Rv
X2xlMzIoYXJnX3NpemUpOw0KPj4gKyAgICAgICByZXEucnBjX3NpemUgPSBjcHVfdG9fbGUzMihy
cGNfc2l6ZSk7DQo+PiArDQo+PiArICAgICAgIHJldHVybiBvcHRlZV9ycG1pX3lpZWxkaW5nX2Nh
bGwoY3R4LCAmcmVxLCBycGNfYXJnLCBzeXN0ZW1fdGhyZWFkKTsNCj4+ICt9DQo+Pg0KPj4gLS0N
Cj4+IDIuMzQuMQ0KPj4NCg0K
