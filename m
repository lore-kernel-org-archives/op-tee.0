Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E067C83F09
	for <op-tee@archiver.kernel.org>; Wed,  9 Jul 2025 00:41:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7B0FF43087
	for <op-tee@archiver.kernel.org>; Wed,  9 Jul 2025 00:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752021684;
	bh=u3ETzpgFwWz3jHvtDCZyRYjFT4puWGYPQDy7Wbi10ZM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=VK15GQTplOxGzvhU+QkQCYoPvCsikqjfqaOm5g0Ex70LGXN/0CKSOIo1HjUvIddda
	 E9wfKhYjR1rYUbXeQkKv/0/vZny66aLD+fHXc9UpOb1WhqDFaU6Y7fAp0GKP8j68Ai
	 F8HxkMs2hCpq1JnFxOZYNmnjTNOVLyLCvckbjSti2gLVXZunohhtEJ0fAejx/n3fEl
	 KEMc1L/1roHELgRuPCWMtIy3DX/x2mv+/EeRJD2ZTeepfjBDRL6UJr6+wm5zap0f03
	 9AM7WvHKZBVPGTZ8ZjZgTS51DthfF/ks7YLfvL8BGqEqsp7bBfKuEvFJV/IIuDnW/5
	 Eu04E4nxWnv1Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5D8834FBAE
	for <op-tee@lists.trustedfirmware.org>; Wed,  9 Jul 2025 00:41:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AiMVp+6h;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568MxP0j026193
	for <op-tee@lists.trustedfirmware.org>; Wed, 9 Jul 2025 00:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pi4EIWG/2yrlhMHP9uaXgOG+6m3E60UYeWOXIeop15I=; b=AiMVp+6hq1mR8LHk
	/AVVnDDIGYIIfIb9Y6a3lk2roiCYse1JxERbmUruRA2/AjhTAkaVdv002M9BsthM
	Ht0+Rxh4qxqpTfWvt6X3Td3dZSm/Wafu5UVrzb0E8He3UaOOgKdP7WpDmNgMf7fo
	6iaYnfkTPlayWfZbJGtOFFJU5Fo1+lCZrT5ISX3BNEcO1A13v/N0bv1nbMl3TbB9
	euA4zCYa/UW44THMAj7t6/j350MZsbYoQgE5FSTRZN9cGBklSTWZA5AKRlo37BAD
	V+RzHSChY9nsNouNQEph7Mec7Wr/p2ZZM/T7aMB7gfYmdFgvpAUCD8CG5Gme95Cl
	StLuYQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefjh59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 09 Jul 2025 00:40:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748e1e474f8so7506026b3a.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 08 Jul 2025 17:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752021658; x=1752626458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi4EIWG/2yrlhMHP9uaXgOG+6m3E60UYeWOXIeop15I=;
        b=u3u+gBJla+BFzCix8XqlUzeaegRRXNcNQ5nWIhZ/tWaw5YHNC6eQlKiFIsN5lXl6eE
         JpS1xL3XN1f2O3U7K63vSa9bOeAwxxbIV0/ZlfSEVN8E0nsNVks7TsSJz384b6Pt/jZb
         7Auj5SMrXgx7cZnJf6Jy8kM/gvRqnf32Y4cz5YyqzVTyuRzTQHne6Tj1nolVkO8ig5KW
         olXWUj51ZponXdSkZCKXAcgcezLLM6Jkuq+jPl71zV6u5hlXAhiW6hjIWZ27igkux8gw
         nu385cneELB8p7+G4yx5rzNM6dgA41x/mfcivTLRyDSoJ3t7ELXi0Hy7pH3IV9gyOVbO
         JMAw==
X-Gm-Message-State: AOJu0YxIoDdROwGPDK7aZn7fDMilQpkWCi7XxTAtt9ytElGkzWMEDxFd
	34aOpDttiL7f+epD30lRWsbznjdh3CnpySes+wYDijy6sV/neCDlO5keUlsBdzqsOlqUEbXm8V0
	shvpCxVvN4bCQHH2GvxraTLmqX5TuqTPfLQUlfY+qksDSpa/ZevN/WjGGSbRn3aZVsMoD68oWl/
	pbfbo=
X-Gm-Gg: ASbGncvi1B6GYpmAPHq4K+E/fQXpz13GKMHnn3/iLJUiv+ILI5jBMnuCLWQsiy+mIJI
	wXKYg79R7HuZHBOaRy5geKJaWMPZf8/2h/LGU4JDrG/EYFKt45VSZPUyah4H7BMcSIap7rft7BC
	qDzQqXNN570ztFji9D3RpQEYwHHFrO8GhTOZKis61SXsRd/6bQGFDLjazISIhzS3kkixRv+a/my
	m6hzuvFNrCRysTF6aQuoKqITfszzixigNrq/dCdXrwjdV/vI6GXZTjEc67cDBo4x09fb886GnxX
	08hhms/0k6dnwS4fIu9EY7qoduXs/ESMD6OUT/RfaT0lMdFE1mfCKJEu2AsjFtNKEhejR73yMAg
	lA2GMc9LKNpie57Gyy83H
X-Received: by 2002:a05:6a20:72a7:b0:225:a797:5628 with SMTP id adf61e73a8af0-22cdb0a6483mr508743637.42.1752021658194;
        Tue, 08 Jul 2025 17:40:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/G6GxCPKgGwOo3AwRAgVlS2ZCv8vyaTuMMfYxCCyqKvTUQiQI6l/iXeNzC+1VcaUHYlRvSg==
X-Received: by 2002:a05:6a20:72a7:b0:225:a797:5628 with SMTP id adf61e73a8af0-22cdb0a6483mr508711637.42.1752021657689;
        Tue, 08 Jul 2025 17:40:57 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3924868c3dsm4934967a12.23.2025.07.08.17.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 17:40:57 -0700 (PDT)
Message-ID: <99b4bc49-ce87-4340-a1ec-fd74499f5c73@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 10:40:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/9] tee: implement protected DMA-heap
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-4-jens.wiklander@linaro.org>
 <b1a71f06-901e-47fb-9e27-9d401d26f7fc@oss.qualcomm.com>
 <CAHUa44FV_maNF1Xx0hnqGT3=DnM3zEnLj6CLcz7pZvxEPmiGJw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44FV_maNF1Xx0hnqGT3=DnM3zEnLj6CLcz7pZvxEPmiGJw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAwNCBTYWx0ZWRfX6Kfkq4gyy8ii
 VtN8BvFRllUlC9PLnj0DY7BEjA7CYrlSODxuvdkHZB83OjKRmaTHr65ykspyIJK+KE8lHllDqXO
 np7xwArdGPomD3XNoOfAvcbExCIob7ATRJDehoEXFeAb7MuORLw0x2LKHwN+QEYi0kPDg5gzWUz
 FIVe42O0D3+6CBigss3uCN8wEYeNl25AYJEeST2/NMMTNS2Td3ksPD2bqQjenfJ8G3N2PjNxxgK
 gmqb9aFx3q5o06x4jC/StOR76Vq0PEA8YhC8IuTwbjHHLxPxpRiEAUQKSTX4HlywGdfPKSnIx4U
 LToq/XFpknUh9Ur8np6ksEJpOeG4k8eos4XJQ3PjUCmyhf+mShSWVC60AZkiv6gA61gC3kvwUoK
 vd3wxwmh7nH6th3JfUJapPBnI8ZI/IyceCuTF9tp9uMPLf1Ayt46QHRqw3U2qjemynVCNqGq
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686dba9b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=b45o4kL6AAAA:8 a=KKAkSRfTAAAA:8
 a=ImkcbI-tMrFl7dBUOjIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=dhdsR-PFWuPJUldTnwXm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4BRMOjoij1wfRRQhnwEq9Pair84Lp0Bn
X-Proofpoint-ORIG-GUID: 4BRMOjoij1wfRRQhnwEq9Pair84Lp0Bn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_07,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090004
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5D8834FBAE
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[205.220.180.131:from];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+]
Message-ID-Hash: UBPAPFXFEPSN4D4I3NU2U26LBHWW2R2O
X-Message-ID-Hash: UBPAPFXFEPSN4D4I3NU2U26LBHWW2R2O
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UBPAPFXFEPSN4D4I3NU2U26LBHWW2R2O/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gNy83LzIwMjUgOToyMiBQTSwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+
IEhpIEFtaXIsDQo+IA0KPiBPbiBNb24sIEp1bCA3LCAyMDI1IGF0IDQ6MjLigK9BTSBBbWlycmV6
YSBaYXJyYWJpIHZpYSBPUC1URUUNCj4gPG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3Jn
PiB3cm90ZToNCj4+DQo+PiBIaSBKZW5zLA0KPj4NCj4+IE9uIDYvMTAvMjAyNSAxMToxMyBQTSwg
SmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+Pj4gSW1wbGVtZW50IERNQSBoZWFwIGZvciBwcm90ZWN0
ZWQgRE1BLWJ1ZiBhbGxvY2F0aW9uIGluIHRoZSBURUUNCj4+PiBzdWJzeXN0ZW0uDQo+Pj4NCj4+
PiBQcm90ZWN0ZWQgbWVtb3J5IHJlZmVycyB0byBtZW1vcnkgYnVmZmVycyBiZWhpbmQgYSBoYXJk
d2FyZSBlbmZvcmNlZA0KPj4+IGZpcmV3YWxsLiBJdCBpcyBub3QgYWNjZXNzaWJsZSB0byB0aGUg
a2VybmVsIGR1cmluZyBub3JtYWwgY2lyY3Vtc3RhbmNlcw0KPj4+IGJ1dCByYXRoZXIgb25seSBh
Y2Nlc3NpYmxlIHRvIGNlcnRhaW4gaGFyZHdhcmUgSVBzIG9yIENQVXMgZXhlY3V0aW5nIGluDQo+
Pj4gaGlnaGVyIG9yIGRpZmZlcmVudGx5IHByaXZpbGVnZWQgbW9kZSB0aGFuIHRoZSBrZXJuZWwg
aXRzZWxmLiBUaGlzDQo+Pj4gaW50ZXJmYWNlIGFsbG93cyB0byBhbGxvY2F0ZSBhbmQgbWFuYWdl
IHN1Y2ggcHJvdGVjdGVkIG1lbW9yeSBidWZmZXJzDQo+Pj4gdmlhIGludGVyYWN0aW9uIHdpdGgg
YSBURUUgaW1wbGVtZW50YXRpb24uDQo+Pj4NCj4+PiBUaGUgcHJvdGVjdGVkIG1lbW9yeSBpcyBh
bGxvY2F0ZWQgZm9yIGEgc3BlY2lmaWMgdXNlLWNhc2UsIGxpa2UgU2VjdXJlDQo+Pj4gVmlkZW8g
UGxheWJhY2ssIFRydXN0ZWQgVUksIG9yIFNlY3VyZSBWaWRlbyBSZWNvcmRpbmcgd2hlcmUgY2Vy
dGFpbg0KPj4+IGhhcmR3YXJlIGRldmljZXMgY2FuIGFjY2VzcyB0aGUgbWVtb3J5Lg0KPj4+DQo+
Pj4gVGhlIERNQS1oZWFwcyBhcmUgZW5hYmxlZCBleHBsaWNpdGx5IGJ5IHRoZSBURUUgYmFja2Vu
ZCBkcml2ZXIuIFRoZSBURUUNCj4+PiBiYWNrZW5kIGRyaXZlcnMgbmVlZHMgdG8gaW1wbGVtZW50
IHByb3RlY3RlZCBtZW1vcnkgcG9vbCB0byBtYW5hZ2UgdGhlDQo+Pj4gcHJvdGVjdGVkIG1lbW9y
eS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRl
ckBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0KPj4+ICBkcml2ZXJzL3RlZS9LY29uZmlnICAgICAgIHwg
ICA1ICsNCj4+PiAgZHJpdmVycy90ZWUvTWFrZWZpbGUgICAgICB8ICAgMSArDQo+Pj4gIGRyaXZl
cnMvdGVlL3RlZV9oZWFwLmMgICAgfCA0NzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+PiAgZHJpdmVycy90ZWUvdGVlX3ByaXZhdGUuaCB8ICAgNiArDQo+Pj4gIGlu
Y2x1ZGUvbGludXgvdGVlX2NvcmUuaCAgfCAgNjUgKysrKysrDQo+Pj4gIDUgZmlsZXMgY2hhbmdl
ZCwgNTQ5IGluc2VydGlvbnMoKykNCj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGVl
L3RlZV9oZWFwLmMNCj4+Pg0KPiBbc25pcF0NCj4+DQo+PiBJJ20gaGF2aW5nIGEgYml0IG9mIHRy
b3VibGUgdW5kZXJzdGFuZGluZyB0aGUgcmF0aW9uYWxlIGJlaGluZA0KPj4gc3VwcG9ydGluZyB0
ZWVfZGV2aWNlX3VucmVnaXN0ZXJfYWxsX2RtYV9oZWFwcygpLiBDb25zaWRlcmluZyB0aGF0DQo+
PiB0aGUgaGVhcCByZW1haW5zIGFjY2Vzc2libGUgZnJvbSB1c2Vyc3BhY2UsIHdvdWxkbid0IHRo
aXMgbGVhZA0KPj4gdG8gdW5kZWZpbmVkIGJlaGF2aW9yPyBGb3IgZXhhbXBsZSwgd2hhdCBoYXBw
ZW5zIGlmIGEgdXNlciBpcw0KPj4gaW4gdGhlIG1pZGRsZSBvZiBhIHRlZV9kbWFfaGVhcF9hbGxv
YygpIC0tIHNwZWNpZmljYWxseSBiZWZvcmUNCj4+IHRlZV9kZXZpY2VfZ2V0KCkgLS0gd2hpbGUg
dGhlIGJhY2tlbmQgY2FsbHMgdGVlX2RldmljZV91bnJlZ2lzdGVyX2FsbF9kbWFfaGVhcHMoKT8N
Cj4gDQo+IFRoYXQgY2FuJ3QgaGFwcGVuIHNpbmNlIHRlZV9kZXZpY2VfdW5yZWdpc3RlcigpIGhh
cyBiZWVuIGNhbGxlZA0KPiBiZWZvcmUsIGd1YXJhbnRlZWluZyB0aGF0IG5vIGZ1cnRoZXIgY2Fs
bHMgdG8gdGVlX2RldmljZV9nZXQoKSBjYW4NCj4gc3VjY2VlZC4NCj4gDQoNClRoZSBpc3N1ZSBs
aWVzIHdpdGggdGVlX2RldmljZV91bnJlZ2lzdGVyKCkuIEFmdGVyIGl0IHJldHVybnMsDQp0ZWVk
ZXYgaXMgcmVsZWFzZWQgKEkgZG9uJ3Qgc2VlIGdldF9kZXZpY2UoKSBhbnl3aGVyZSksIHlldCB0
aGUgZG1hIGhlYXANCmlzIHN0aWxsIGhvbGRpbmcgYSByZWZlcmVuY2UgdG8gaXQuIEkgYmVsaWV2
ZSBpdCBjb3VsZCBjYXVzZSBudWxsIGRlcmVmLg0KDQo+Pg0KPj4gSSB1bmRlcnN0YW5kIHRoYXQg
eW91IHdhbnQgdG8gdXNlIHRlZWRldiByZWZjb3VudCB0byBwcm90ZWN0IGFnYWluc3QNCj4+IHRo
ZSBURUUgZHJpdmVyIHVuYmluZGluZyBpZiB0aGVyZSBpcyBhIGJ1ZmZlciBhbGxvY2F0ZWQuIEJ1
dCB3aGF0IGFib3V0DQo+PiB0aGUgaGVhcCBkZXZpY2U/DQo+Pg0KPj4gQWRkaXRpb25hbGx5LCB3
aGF0IGlmIHRoZSB1c2VyIGRlY2lkZXMgdG8gdW5iaW5kIHRoZSBURUUgYmFja2VuZCBkcml2ZXI/
DQo+PiBXb3VsZCB0aGUgZG1hX2hlYXAgZGV2aWNlIHN0aWxsIHBlcnNpc3Qgd2l0aG91dCBhbnkg
YWxsb2MgZnVuY3Rpb24/DQo+IA0KPiBZZXMsIHRoZSBkZXZpY2Ugd291bGQgc3RpbGwgYmUgdGhl
cmUsIGJ1dCBhbGxvYyB3b3VsZCByZXR1cm4gLUVJTlZBTA0KPiB1bnRpbCBhIG5ldyBoZWFwIGhh
cyBiZWVuIHJlZ2lzdGVyZWQuDQoNClRoYXTigJlzIG9ubHkgdmFsaWQgaWYgdGhlIGJhY2stZW5k
IGlzIGJ1aWx0LWluLiBXaGF0IGhhcHBlbnMgaWYgaXTigJlzDQphIG1vZHVsZSBhbmQgZ2V0cyBy
ZW1vdmVkPyBJbiB0aGF0IGNhc2UsIHRoZSBhbGxvYyBmdW5jdGlvbiBpc27igJl0IHByZXNlbnQN
CnRvIHJldHVybiAtRUlOVkFMLiBQZXJoYXBzIHVzaW5nIG1vZHVsZV9nZXQoKSBmb3IgZWFjaCBk
bWEgaGVhcCBjb3VsZA0KYmUgYSB3b3JrYXJvdW5kIGZvciBub3c/DQoNCj4gQnV0IEkgdGhpbmsg
eW91J3JlIG9uIHRvIHNvbWV0aGluZywgd2Ugc2hvdWxkIHBlcmhhcHMgaW5jcmVhc2UgdGhlIFRF
RQ0KPiBtb2R1bGUgcmVmY291bnQgd2hlbiBjYWxsaW5nIGRtYV9oZWFwX2FkZCgpLiBEbyB5b3Ug
YWdyZWU/DQo+DQoNClNpbmNlIHRoZSBsaWZldGltZSBvZiB0aGUgZG1hIGhlYXBzIGFmZmVjdHMg
dGVlZGV2LCBpdCBzZWVtcyBtb3JlDQphcHByb3ByaWF0ZSB0byBtYWludGFpbiBhIHJlZmVyZW5j
ZSBjb3VudCBwZXIgZG1hIGhlYXAgYW5kIHJlbGVhc2UgaXQNCmR1cmluZyB1bnJlZ2lzdGVyLiBU
aGlzIGFsc28gYWRkcmVzc2VzIHRoZSBmaXJzdCBpc3N1ZS4NCg0KUmVnYXJkcywNCkFtaXINCg0K
Pj4NCj4+IEluIHRoZSBjYXNlIG9mIHFjb210ZWUsIG15IG9yaWdpbmFsIGlkZWEgd2FzIHRvIGhh
dmUgdHdvIHNlcGFyYXRlDQo+PiBkcml2ZXJzIGxvYWRlZCBhbG9uZ3NpZGUgZWFjaCBvdGhlci4g
VGhpcyBzZXR1cCB3b3VsZCBhbGxvdyB0aGUNCj4+IFRFRSBiYWNrZW5kIGRyaXZlciB0byBzdXBw
b3J0IHVuYmluZGluZywgd2hpbGUgdGhlIHByb3RlY3RlZCBtZW1vcnkNCj4+IGJhY2tlbmQgY291
bGQgcmVtYWluIGxvYWRlZC4gVGhpcyBzZXBhcmF0aW9uIGlzIHBhcnRpY3VsYXJseSB1c2VmdWwN
Cj4+IGZvciBGRkEsIG9yIHNjZW5hcmlvcyB3aGVyZSB0aGUgcHJvdGVjdGVkIGJ1ZmZlciBkb2Vz
IG5vdCBuZWVkIHRvIGJlDQo+PiB0cmFuc2ZlcmVkIHRvIFRFRS4NCj4+DQo+PiBPcg0KPj4NCj4+
IEEgcmVmZXJlbmNlIHRvIHRlZWRldiBjb3VsZCBiZSBvYnRhaW5lZCB3aGVuIHRoZSBoZWFwIGlz
IHJlZ2lzdGVyZWQsDQo+PiByYXRoZXIgdGhhbiBmb3IgZWFjaCBidWZmZXIgYWxsb2NhdGlvbi4g
SW4gb3RoZXIgd29yZHMsIG9uY2UgdGhlIGhlYXANCj4+IGlzIHJlZ2lzdGVyZWQsIHRoZSBiYWNr
ZW5kIG11c3QgcmVtYWluIGFjdGl2ZSBhbmQgY2Fubm90IGJlIHVubG9hZGVkLg0KPj4NCj4+IE9y
DQo+Pg0KPj4gRmluZCBhIHdheSB0byBoYXZlIHNvbWV0aGluZyBsaWtlIGRtYV9oZWFwX3JtKCk/
DQo+IA0KPiBUaGF0IHdvdWxkIGJlIGhlbHBmdWwsIGJ1dCBJJ2QgcHJlZmVyIHRvIGtlZXAgaXQg
b3V0IG9mIHRoZSBzY29wZSBvZg0KPiB0aGUgcGF0Y2hzZXQgaWYgcG9zc2libGUuDQo+IA0KPiBU
aGFua3MsDQo+IEplbnMNCj4gDQo+Pg0KPj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgbWlzLXVu
ZGVyc3Rvb2Qgc29tZXRoaW5nPyBvciBtaXNzaW5nIHNvbWV0aGluZyA6KQ0KPj4NCj4+IFJlZ2Fy
ZHMsDQo+PiBBbWlyDQo+Pg0KPj4+ICt2b2lkIHRlZV9kZXZpY2VfdW5yZWdpc3Rlcl9hbGxfZG1h
X2hlYXBzKHN0cnVjdCB0ZWVfZGV2aWNlICp0ZWVkZXYpDQo+Pj4gK3sNCj4+PiArICAgICBzdHJ1
Y3QgdGVlX3Byb3RtZW1fcG9vbCAqcG9vbDsNCj4+PiArICAgICBzdHJ1Y3QgdGVlX2RtYV9oZWFw
ICpoOw0KPj4+ICsgICAgIHVfbG9uZyBpOw0KPj4+ICsNCj4+PiArICAgICB4YV9mb3JfZWFjaCgm
dGVlX2RtYV9oZWFwLCBpLCBoKSB7DQo+Pj4gKyAgICAgICAgICAgICBpZiAoaCkgew0KPj4+ICsg
ICAgICAgICAgICAgICAgICAgICBwb29sID0gTlVMTDsNCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgbXV0ZXhfbG9jaygmaC0+bXUpOw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoaC0+
dGVlZGV2ID09IHRlZWRldikgew0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBv
b2wgPSBoLT5wb29sOw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGgtPnRlZWRl
diA9IE5VTEw7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaC0+cG9vbCA9IE5V
TEw7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIH0NCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgbXV0ZXhfdW5sb2NrKCZoLT5tdSk7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChw
b29sKQ0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvb2wtPm9wcy0+ZGVzdHJv
eV9wb29sKHBvb2wpOw0KPj4+ICsgICAgICAgICAgICAgfQ0KPj4+ICsgICAgIH0NCj4+PiArfQ0K
Pj4+ICtFWFBPUlRfU1lNQk9MX0dQTCh0ZWVfZGV2aWNlX3VucmVnaXN0ZXJfYWxsX2RtYV9oZWFw
cyk7DQoNCg==
