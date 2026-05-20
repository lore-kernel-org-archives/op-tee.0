Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB00DCD4F54
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 07:11:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C52A244DD0
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 07:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779261061;
	bh=xE/CKkBGw2IdpBqY4v5qnrEprflNzCmqvr2/33T6+lA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BKNt7Zc6+M+8rk2QLh5r1wxAZha2mQOTyUUErp7HRwxoB1Rmskd+4YdxMSRLS2khP
	 jqZWReFrTYMkOX4WzIfw82uj011n0oAWNbSauXiJnKSAC1iFsUk6EsB9+KJamSaTfn
	 c+jw1pubyl9K5yGLmDZm9oZnLo5TzN8td5BYW4oNUrht1YrdJexdGMQdQf2xxxOWzZ
	 B/xWrE3C8tkY27/LldbtYysVe1sG1XEJSDCoV4ZTHnsPjXM62MGy0fn6BKJheywmO4
	 4pLMBzLiTTmFXiQ4qehNGCAX0W+CNZtY3wQFOlLvlCtaUhJlJleC+uH/roy4pKwoy2
	 1/ceQaGGyweoQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 873B044391
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 07:10:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZwIEFtVT;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y879GiOj;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JMsCOO1963690
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 07:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Uhk1FUXura1rSt1HauAyKOQgYTBvg/GyUMJxhruQgw=; b=ZwIEFtVT3x9totRo
	r3JRZ/Tvt7iMsIhzf0SG4JqUymkw94heuC5JztcmxEsHWz7enzWRJRZ+qr5Rl+AQ
	w3yTIsf7+6nvJSJie+/6IRjGshHg/VUEBlwH/Ul2LKf0yRZMYER6VHQRVshI43nS
	96jUZDRZqQyNpzEpCPmRXWGrj7tGSgQjxz1KotivSajmkrjXFAxPzwYV4thoZnFN
	4kQhLALjrxkVbi81hoN1xGktHLGrMtStqZtoIZA3hZBEsSO1bcxd0Ye3sUyof6aw
	Fp4PL/1goA7rne91tcKB9DcLqwLYryaEacORzt+1TajGDE07Nq/ewNhJK0RrppxP
	ll0zZQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t3e8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 07:10:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba054e0304so42909655ad.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779261053; x=1779865853; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Uhk1FUXura1rSt1HauAyKOQgYTBvg/GyUMJxhruQgw=;
        b=Y879GiOjTYSeEBSOWQtq7+bd1ydAdQAO1100gvjjimik09jp7RKfJv8AkZ5rC0dj3V
         T435lDlSZ9ztNtXepXeDhQWz9ED3NiXPL+ZuJdVzfW6RcYUGsxn5LwR8TEhNfPfjMfK3
         snG89o/s39cruQH67qcFTnq4j3rGOBonNP3DGP5UFhKK+T/UtZPNKZGFlivcgDSL16L2
         YD212k2FNtN3QJVGngGrT6IN52PgKcmxAJVtLbIxyj3lQaFFqMgw0xC4LHGKScuLlUgF
         MuPM5oK5qfKSGVC2STIcysP7C5MKm7CggUW1vbSDnLskgA2ikLS2JrzzY/Z7tgkdfJ9W
         PQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779261053; x=1779865853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Uhk1FUXura1rSt1HauAyKOQgYTBvg/GyUMJxhruQgw=;
        b=bf+slGn3SVTvEkDP9I09IJchB5VDP+MuwljxuKXgJW+AqUys0Z4MYk7XWbo98+0JLZ
         6HxO3/Za4ju//+NhOYk6E3YpA/uXhPLe4psAUNKd/GyR+1cL+3uQbHQFPy8wS3N+I1ll
         SpEyUkqxawKC+WWhr+tFqtvKZfz3xkz6awAJNn0c446Drzt7ZEIwG3eKBhouSu0MYH+w
         acLfSrgqbqs14b4MAzg/l2ozwIuSGEtsP7DrHcyEICKTxYp9F4JgjMF910LGpQEl0Nn/
         kuj65eC6y4FR+TYezo5YuULf2aUxwjKA/2aG3jelVNSbOvqgbtaea/TKAa3h5anuhjZV
         EMfA==
X-Forwarded-Encrypted: i=1; AFNElJ9d+ECXp8znbqPOe1pnO1nnuOzOIXJl4YKYNIJXLinpAnMu4rxkUlpoUqlBKXjyw3dM3h67Cl4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz1mfMOoMFyAfKmECTVUeVYB8daQc6mJenRhVBp77vpkn9IANFl
	CVknAcX/I2gxjnYoVr6BKpdjEDjcYuxBRr18V8NeJBNshzGYC3AMwbemZHT2KdpvtEkl3gcyJG7
	yoggo5zIbO1+OEhs+NDo8LL4NqosZyyzch3fjujfyoqEWRSXEQM9JRLGTQzFY6r5ZEH6DJQQ=
X-Gm-Gg: Acq92OElGWAmPz/YuHhJLo8/WyTaSif7XNK1V6Eu8tniUFl5ecQJKhuTSsMmjXdWRuj
	PsxYQ0wCwiPKO7ZhfJVYk14zimW1urI2NOTZK3HDnzpClSieRKiSAVLG8gVbYQdKanaqig7uPk1
	//kslFbLAN39HkGgDLfpwMSQpfRCsM0r3oojrUG3++KwfDaYVNS64BDS/LJQPC7nRQo9gai35rT
	O4MGEIH/66Hf8pCvLDopIMgaTC9aJlpuN91F4JXWZEX1ZvEkC1Xxzgv+NFlFjRzmW8UF4MKMFiY
	oHVKO8zLyfEw0t3CsuPWquAko1umc+0YoErgkUV0SV+Nqu4+w10ONUGRz636sucf9Muqdr6gRZg
	C9V5uyXwbAQVsNXxaaBPClzeZ9GySsIHme+5aSY4Y1NXw+e5N1QiqzUZ9172fxhFUG8UTxBIx78
	jalwF5D7xncbdpjwggfDPBzv6WlU448w==
X-Received: by 2002:a17:903:46c7:b0:2bc:dca9:f0ed with SMTP id d9443c01a7336-2bd7e9249a5mr201903325ad.15.1779261052743;
        Wed, 20 May 2026 00:10:52 -0700 (PDT)
X-Received: by 2002:a17:903:46c7:b0:2bc:dca9:f0ed with SMTP id d9443c01a7336-2bd7e9249a5mr201903065ad.15.1779261052218;
        Wed, 20 May 2026 00:10:52 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb17sm204213085ad.1.2026.05.20.00.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:10:51 -0700 (PDT)
Message-ID: <cd6caaef-032e-4679-88b3-2f242c28b00f@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:10:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dma_heap and protected memory
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <75d61a22-7c36-434a-a9f2-80533090e072@oss.qualcomm.com>
 <CAHUa44EG8b74NgdHW=QhKBtKd7e0_xWqQTkZA9tZxEOHenY_AQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44EG8b74NgdHW=QhKBtKd7e0_xWqQTkZA9tZxEOHenY_AQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: pRHdR4LfsVZJN-YoBzZQtW08Mseqx59h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NyBTYWx0ZWRfX6nBjpmsZaHQt
 Av3D0zz0Q2ZTM6183d98BpiIXgK3Vnp72qQ7dZwxDvpJt+Nm+8inQ/bdcHNNZ7HixKf1JfDyXub
 +mPg8Ktjgj/1YIqCu0ghz7ruwLLG0ojyup2ux5QMCEQ3NQSvwRrZdW3YErcTjPMDvANseIl1Jsf
 FeXJRbIo50B3F7KFVZca3LjRU0nNcs0+umJiduA3Oz1QZ+X4Tl21hytXTqEID7AnksKMX7ESZKj
 3Z0XfIx9m22ARnYjPI8FjS9UhssWbG0d2gbWtxuZm/3j+gyVO8HLiw70ZKHv6TH+d00NyRKBE2t
 a/y6W92pp4uAvdhsezxSm2NCBKRAKpc1fDS4DicIyZvw4sr4Y5dGSQyKgxcn+jZX7oSwLG96JZD
 kB/J9KA63vrYUyAmqEe5hzqQ7CcuhoCxNWUfbHq1vjOik38rvQ5TAq0LuwmZ0udO9T4yU2yC4TX
 jzZVXmUjnd1GrF1PojQ==
X-Authority-Analysis: v=2.4 cv=Y/bIdBeN c=1 sm=1 tr=0 ts=6a0d5e7d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ELuihP5lWmw3tGyuREIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: pRHdR4LfsVZJN-YoBzZQtW08Mseqx59h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200067
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 873B044391
X-Spamd-Bar: ------
Message-ID-Hash: 4B7K5ARQE5KJPRG7M22TOGXVSJPBK26J
X-Message-ID-Hash: 4B7K5ARQE5KJPRG7M22TOGXVSJPBK26J
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4B7K5ARQE5KJPRG7M22TOGXVSJPBK26J/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gNS8yMC8yMDI2IDE6MjkgQU0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0K
PiBIaSBBbWlyLA0KPiANCj4gT24gRnJpLCBNYXkgMTUsIDIwMjYgYXQgNToxMOKAr0FNIEFtaXJy
ZXphIFphcnJhYmkNCj4gPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gSGkgSmVucywNCj4+DQo+PiBSZWNlbnRseSBwcm90ZWN0ZWQgaGVhcCBzdXBwb3J0
IGhhcyBiZWVuIGFkZGVkIGZvciB0aGUgVEVFIHN1YnN5c3RlbS4NCj4+IFRoaXMgYWxsb3dzIGRt
YS1oZWFwcyB0byBiZSBtYW5hZ2VkIGJ5IHRoZSBURUUgc3Vic3lzdGVtIGl0c2VsZi4NCj4+DQo+
PiBGb3Igc3RhbmRhcmQsIG5vbi1wcm90ZWN0ZWQgaGVhcHMgc3VjaCBhcyB0aGUgc3lzdGVtIGhl
YXAgb3IgQ01BIGhlYXAsDQo+PiBJIGFtIHRyeWluZyB0byB1bmRlcnN0YW5kIHRoZSBleHBlY3Rl
ZCB1c2FnZSBtb2RlbC4gT25lIHBvc3NpYmxlIHdvcmthcm91bmQNCj4+IGFwcGVhcnMgdG8gYmUg
dG8gbW1hcCB0aGUgZG1hLWJ1ZiBmZCBpbiB1c2Vyc3BhY2UsIHRoZW4gcmVnaXN0ZXIgdGhlDQo+
PiByZXN1bHRpbmcgdXNlcnNwYWNlIFZBIHdpdGggdGhlIFRFRSBzdWJzeXN0ZW0gdG8gb2J0YWlu
IGEgVEVFIHNoYXJlZC1tZW1vcnkNCj4+IG9iamVjdCwgZm9yIGV4YW1wbGU6DQo+Pg0KPj4gZmQg
PSBkbWFfaGVhcF9hbGxvYyguLi4pOw0KPj4gdmEgPSBtbWFwKGZkLCAuLi4pOw0KPj4NCj4+IHNo
bV9mZCA9IHRlZV9zaG1fcmVnaXN0ZXIodmEsIHNpemUpOw0KPj4gdGVlX2ludm9rZShzaG1fZmQp
Ow0KPj4NCj4+IGNsb3NlKHNobV9mZCk7DQo+PiBtdW5tYXAodmEsIHNpemUpOw0KPj4gY2xvc2Uo
ZmQpOw0KPj4NCj4+IFRoaXMgc2VlbXMgcmVhc29uYWJsZSB3aGVuIHRoZSBsaWZldGltZSBvZiB0
aGUgcmVnaXN0ZXJlZCBzaGFyZWQgbWVtb3J5DQo+PiBpcyBsaW1pdGVkIHRvIGEgc2luZ2xlIGlu
dm9jYXRpb24gb3IgY2FsbGJhY2suIEhvd2V2ZXIsIEkgYW0gY29uY2VybmVkIGFib3V0DQo+PiBj
YXNlcyAobXVsdGlwbGUgZXhpdHMgaW4gcWNvbXRlZSkgd2hlcmUgdGhlIFRFRSBzaWRlIG5lZWRz
IHRvIHJldGFpbiBhY2Nlc3MNCj4+IHRvIHRoZSBtZW1vcnkgYWZ0ZXIgdGhlIGlvY3RsL2ludm9j
YXRpb24gcmV0dXJucy4NCj4+DQo+PiBJbiB0aGF0IGNhc2UsIHJlZ2lzdGVyaW5nIG9ubHkgdGhl
IHVzZXJzcGFjZSBWQSBkb2VzIG5vdCBhcHBlYXINCj4+IHRvIGtlZXAgdGhlIHVuZGVybHlpbmcg
ZG1hLWJ1ZiBvYmplY3QgYWxpdmUuIFRoZSBURUUgY29yZSBwaW5zIHRoZSBwYWdlcywNCj4+IGJ1
dCBpdCBkb2VzIG5vdCBob2xkIGEgZG1hLWJ1ZiByZWZlcmVuY2Ugb3IgYXR0YWNobWVudC4gSWYg
dXNlcnNwYWNlIGxhdGVyDQo+PiBjbG9zZXMgdGhlIGRtYS1idWYgZmQgYW5kIHVubWFwcyB0aGUg
VkEsIHRoZSBkbWEtYnVmIGV4cG9ydGVyIG1heSBjb25zaWRlcg0KPj4gdGhlIGJ1ZmZlciByZWxl
YXNlZCwgd2hpbGUgdGhlIFRFRSBzaWRlIG1heSBzdGlsbCBoYXZlIHRoZSBtZW1vcnkgcmVnaXN0
ZXJlZC4NCj4gDQo+IFRoYXQncyBzdXJwcmlzaW5nLiBBcmUgdGhlIHBhZ2VzIHJldHVybmVkIHRv
IHRoZSBoZWFwIGFsc28/IElmIHNvLA0KPiB0aGVyZSdzIGFuIGlzc3VlLg0KPg0KDQpZZXMsIHRo
YXQgaXMgbXkgdW5kZXJzdGFuZGluZy4gRm9yIGRtYS1oZWFwcywgYWZ0ZXIgdGhlIGZpbmFsIGRt
YS1idWYNCnJlZmVyZW5jZSBpcyByZWxlYXNlZCwgdGhlIGV4cG9ydGVyIGlzIGZyZWUgdG8gcmV0
dXJuIHRoZSBiYWNraW5nIHBhZ2VzIHRvDQp0aGUgaGVhcC4NCg0KPj4NCj4+IElzIHRoZXJlIGEg
cmVjb21tZW5kZWQgd2F5IHRvIHVzZSBzdGFuZGFyZCBoZWFwcywgc3VjaCBhcyB0aGUgc3lzdGVt
IG9yDQo+PiBDTUEgZG1hLWJ1ZiBoZWFwcywgd2hlbiB0aGUgc2hhcmluZyBsaWZldGltZSBpcyBs
b25nZXIgdGhhbiBhIHNpbmdsZSBURUUgY2FsbD8NCj4gDQo+IE5vLCBJIHRoaW5rIHlvdSdyZSBw
aW9uZWVyaW5nIHRoaXMuDQo+IA0KDQo7LSkuDQoNCj4+DQo+PiBXb3VsZCBpdCBtYWtlIHNlbnNl
IHRvIGV4dGVuZCB0ZWVfc2htX3JlZ2lzdGVyX2ZkKCkgc28gdGhhdCBpdCBjYW4gaGFuZGxlDQo+
PiBkbWEtYnVmIGZkcyBmcm9tIHJlZ3VsYXIgZG1hLWhlYXBzIGFzIHdlbGwsIG5vdCBvbmx5IGRt
YS1idWZzIG1hbmFnZWQgYnkNCj4+IHRoZSBURUUgc3Vic3lzdGVtPyBUaGF0IHdvdWxkIGFsbG93
IHRoZSBURUUgY29yZSBvciBiYWNrZW5kIGRyaXZlciB0byBrZWVwDQo+PiB0aGUgZG1hLWJ1ZiBy
ZWZlcmVuY2UgZm9yIHRoZSBsaWZldGltZSBvZiB0aGUgVEVFIHNoYXJlZC1tZW1vcnkgb2JqZWN0
Lg0KPiANCj4gSXQgc2VlbXMgbGlrZSBhIHdvcmthcm91bmQsIHNpbmNlIEkgYXNzdW1lIHRoYXQg
dGhlIHB1cnBvc2UgaXMgdG8NCj4gc2hhcmUgbWVtb3J5IGJldHdlZW4gdGhlIHVzZXIgc3BhY2Ug
cHJvY2VzcyBhbmQgdGhlIFRFRS4gSSB0aGluayB0aGlzDQo+IG1pZ2h0IGJlIGEgbGFzdCByZXNv
cnQgb3Igc29tZXRoaW5nLg0KPiANCg0KWWVzLCBJIGFncmVlLg0KDQpUaGUgc3BlY2lmaWMgY2Fz
ZSBJIGFtIGxvb2tpbmcgYXQgaXMgcWNvbXRlZSB3aXRob3V0IGFuIEZGLUEgYmFja2VuZC4gSW4N
CnRoYXQgY29uZmlndXJhdGlvbiwgcWNvbXRlZSBjdXJyZW50bHkgcmVxdWlyZXMgcGh5c2ljYWxs
eSBjb250aWd1b3VzIHNoYXJlZA0KbWVtb3J5LCBzbyByZWdpc3RlcmluZyBhbm9ueW1vdXMgdXNl
cnNwYWNlIG1lbW9yeSBpcyBub3QgdmVyeSBwcmFjdGljYWwuDQoNClRvZGF5IHRoZSBxY29tdGVl
IHNoYXJlZC1tZW1vcnkgcG9vbCBpcyBpbXBsZW1lbnRlZCBvbiB0b3Agb2YNCnRlZV9keW5fc2ht
X2FsbG9jX2hlbHBlcigpLCB3aGljaCBhbGxvY2F0ZXMgbWVtb3J5IGZyb20gdGhlIG5vcm1hbCBw
YWdlDQphbGxvY2F0b3IuIFRoaXMgbWFrZXMgbGFyZ2VyIGFsbG9jYXRpb25zIHN1YmplY3QgdG8g
dGhlIHVzdWFsIGhpZ2gtb3JkZXINCmFsbG9jYXRpb24gLyBNQVhfT1JERVIgbGltaXRhdGlvbnMu
DQoNCk9uZSBvcHRpb24gd291bGQgYmUgdG8gbW92ZSwgb3IgZXh0ZW5kLCB0aGUgcWNvbXRlZSBz
aGFyZWQtbWVtb3J5IHBvb2wgdG8gdXNlDQphIGNtYSBiYWNrZWQgYWxsb2NhdGlvbiBwYXRoLiBU
aGF0IHdvdWxkIGFkZHJlc3MgdGhlIGRlZmF1bHQgYWxsb2NhdGlvbiBjYXNlDQp0aHJvdWdoIFRF
RV9JT0NfU0hNX0FMTE9DICh3aXRob3V0IHJlc3RyaWN0aW9uKS4NCg0KSG93ZXZlciwgSSBhbSB3
b25kZXJpbmcgd2hldGhlciBpdCBpcyBiZXR0ZXIgdG8gYWxzbyBhbGxvdyB1c2Vyc3BhY2UgdG8g
Y2hvb3NlDQp0aGUgc291cmNlIG9mIHRoZSBtZW1vcnksIGZvciBleGFtcGxlIHdoZW4gdGhlIG1l
bW9yeSBtdXN0IGNvbWUgZnJvbSBhIHNwZWNpZmljDQpjYXJ2ZW91dCBvciBmcm9tIGEgY21hIGRt
YS1oZWFwIHNlbGVjdGVkIGJ5IHRoZSBjbGllbnQuDQoNCklmIHlvdSBmZWVsIGl0IGlzIG5vdCBh
IGNvcnJlY3QgZGlyZWN0aW9uLCBJIHRvdGFsbHkgdW5kZXJzdGFuZCBjb25zaWRlcmluZw0KaXQg
aXMgd29ya2Fyb3VuZCBmb3IgYSBsaW1pdGF0aW9uLg0KDQpUaGFua3MgSmVucy4NCg0KUmVnYXJk
cywNCkFtaXINCg0KPiBDaGVlcnMsDQo+IEplbnMNCg0K
