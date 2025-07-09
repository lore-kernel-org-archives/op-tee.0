Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ACDC83F09
	for <op-tee@archiver.kernel.org>; Wed,  9 Jul 2025 04:46:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3CA704FBAF
	for <op-tee@archiver.kernel.org>; Wed,  9 Jul 2025 04:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752036368;
	bh=2k5GdnjOtUpw+zp3QL9q6nZtwA65wl6meodGONwUfJ4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FTQa+8BOO5UrFaE79pAVAviHQdYXAsaUnXxOwKrJPKwN3bkUXpMh2Z5EmKambPbRh
	 xkI2et06Op0iIT2M1pU90D/fFiixo/zD6Rrp82C1LcGx0SqqhcilCMRqdw+cMJgMcN
	 6kPCEJYw+1rDS/0jetlkFAErL2hCJmhGaTzU1HqMTo5gq0Fy1yVFlE0zbQT9ZM1LbK
	 JmcbVa9MXYTyZgX74/h7WOW98AGgzG8DE+4Et4HYLnsvxSgrfQMW2GX5NQqusvOLER
	 sk6sHDzvMs+TeQCxbTyYsT06Z7yATTFvJItGv7c2wUSasYIFeemkRgq1EqHVXAPdse
	 7BTl3DvGoiGBw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A33F43F7D5
	for <op-tee@lists.trustedfirmware.org>; Wed,  9 Jul 2025 04:45:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E3C3nIRe;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568JqYbN031698
	for <op-tee@lists.trustedfirmware.org>; Wed, 9 Jul 2025 04:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XPrxvTCsAfotZoJ6zZy2RHMfrTXpC5/IItRHCTArQ8s=; b=E3C3nIRe/GOQY3Bw
	w6UXco3NfZFu+ndsWfXf1x5G+kborM/GTaLoyDa7+8Avs1nc3zHlGo+Gb+mEq1NY
	xSsEuhUhDglkwXTX/oQJRmvhGegubW2VP9pwPMIYME1LOYotCqhNzxdoRYMhI3/G
	qodfu1cMP5JuXQdgRglUD9pr1mmxFJsULiIROaA7TPN0Ne5P8E2ZU1f4x0jBauJi
	dWj8Snw7GrBl/5Kp/R7zKHdUrGha+hSErHba7Cq8mAJYZAVfIj7xJi9je0XfEoGK
	iqWXjgAEWIJB99J3mi4342ThuKnqn3jhMG0CDc9SVFWzeLM+SQjkEVtqnAFiyRhG
	xxNSEA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pw7qt8pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 09 Jul 2025 04:45:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313fab41f4bso7169242a91.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 08 Jul 2025 21:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752036352; x=1752641152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPrxvTCsAfotZoJ6zZy2RHMfrTXpC5/IItRHCTArQ8s=;
        b=h4onEAvueSg2oESQ3Qs5N79G1otQDPcykXrP51qboFNsPQfMV1R78OzWN1ltjNULPj
         47fHtUYcNPqiER9sf49wQrfkBnmmCto/1jpuufb1YVzp4yoyAhaFHC2pw+gkXKz/6p6/
         7RHpd5b8fKPs9Kyl6ImfjOA3HJJYed1IXKgG0tNZrWHA/s+rXSU4qvpeS9mgjzx1hp9k
         3mPgfqEnauWoMeWUEH5NMiZXw4P3xYUkLcggEZrENXoPYzvM1W8eG/50TpfLOuVEFXfD
         Fmh1ja9WLScEDKR/BZxrWemDInuPb03XGTjx86h5ouOkLqXAEJWdqz0o9Buhib7Ub7io
         dUYA==
X-Gm-Message-State: AOJu0YwvRlgeSnephxUhUBvx3jH6aIBwh5aAUdMyAsHduxQtLDaBODEB
	VW9Hd02JCCMLC/PUj6NnsrgCSyldzlcZ6Czo/P3/SrSTpkQknImiNFStgQtaO1DSVJQlcOgkBmF
	pwqyZ+F+H4TEMAKOx1uij9qcADOU6apHppdZCJr4U6eRhzpIYcL+20rX+Rd0W3QIqPG79iQ4qhj
	4vYQY=
X-Gm-Gg: ASbGnctCeyfBkhIGdD6trdjARnosOUNjIdYk3nkX7mP3WD7AZ8Tn9zZgIa2xdopVfHT
	DWfVOO/BYtDecGZsHR0UvW/XJ26tmo4PpQgbiKdNR5p1TurQCMpQrpCKLR09DvxjVqdpVy5dBRv
	E3fvOg5apbB25qrohPtmuBdda9lyS/cKnLrhlH9lqu2B52Ta0I3em7Ff7hx0A6ACU0bjCVP8VP1
	XiywWx9g46g/cIq1N6W5a4HS1NbkBiHeGa1khTJvqFifIRPhzq3E2Zcuo/SGNNCn3A5h2tBLh6R
	JV2CpDWPsvV8iZcmIdy0TSVG/DwsDRS5Mplx2WwodRfvuT432bye/uTYF9rbtTL7z8RmOuYYIY5
	dirB3LrRXcrDwZz2ipxlU
X-Received: by 2002:a17:90b:510a:b0:313:f883:5d36 with SMTP id 98e67ed59e1d1-31c2fcc389amr1619041a91.1.1752036352104;
        Tue, 08 Jul 2025 21:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGECZaKY6YsEDR6jedDHpIG7SK1eVVfoMFLBVe7wHn0Zq5R5EG5tvIusbp2e1t6uVVfjH+8YQ==
X-Received: by 2002:a17:90b:510a:b0:313:f883:5d36 with SMTP id 98e67ed59e1d1-31c2fcc389amr1618995a91.1.1752036351403;
        Tue, 08 Jul 2025 21:45:51 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c30038081sm808274a91.10.2025.07.08.21.45.49
        for <op-tee@lists.trustedfirmware.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 21:45:50 -0700 (PDT)
Message-ID: <73a7e179-7378-46a7-b1d2-62b760697666@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 14:45:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/9] tee: implement protected DMA-heap
To: op-tee@lists.trustedfirmware.org
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-4-jens.wiklander@linaro.org>
 <b1a71f06-901e-47fb-9e27-9d401d26f7fc@oss.qualcomm.com>
 <CAHUa44FV_maNF1Xx0hnqGT3=DnM3zEnLj6CLcz7pZvxEPmiGJw@mail.gmail.com>
 <99b4bc49-ce87-4340-a1ec-fd74499f5c73@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <99b4bc49-ce87-4340-a1ec-fd74499f5c73@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAzOSBTYWx0ZWRfX7DBYJ8x3tHwG
 PMPwlmNkQZM3gTaMwtjAMZfM9eeZSUJ7V0lVf7ydbFFLm7pzN2kiFRiaaLVZfo/0XhLIXCpAgGG
 4DjugxSPmEN9W98J2iYpYzJ7thKblZ35inauBhZHwB//iocbAfhww7boOqcyYYsNTNwRJLM3pho
 WPLThTERAiJrGa5c/OfalqHEI49Nvrh9H0+TvjzYK8bOSXyTONynmrwoX6RsAe7IJmdwazQQsHG
 cUHEtD+eiOS5pgv5RLvI6QV1ZTkeeTqwrf9t9oHpPNURcH9eoG9hx4lyk5c1+O8DYj+j8s+YX+l
 9iYmsH3NGcm1j6gePRJ7KEJBUz39Q4dttbeEPcKyTsTDJWZpasGEnKNgoN3W/EbYvZJpZnhow0J
 py6TuKy7PmIJwpaFVM3rZ6hP+jXJFxMKtg9Pjy0Z6guAG88VTO3DqKBIwYIm4S8canw//0Oa
X-Proofpoint-GUID: J-hHJwa953aYi1YO4Gw0CZjslXpH4iCw
X-Proofpoint-ORIG-GUID: J-hHJwa953aYi1YO4Gw0CZjslXpH4iCw
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686df401 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=b45o4kL6AAAA:8 a=KKAkSRfTAAAA:8
 a=1f3xeX7U1OgB4kCRFYUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=dhdsR-PFWuPJUldTnwXm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090039
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A33F43F7D5
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[1.41.240.65:received,209.85.216.72:received];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
Message-ID-Hash: 2MEEAHY5RZDIPLKYSMIR6PVIFNJ6BPKM
X-Message-ID-Hash: 2MEEAHY5RZDIPLKYSMIR6PVIFNJ6BPKM
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2MEEAHY5RZDIPLKYSMIR6PVIFNJ6BPKM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KU29ycnkgZm9yIG11bHRpcGxlIHJlcGxpZXMuDQoNCk9uIDcvOS8yMDI1IDEw
OjQwIEFNLCBBbWlycmV6YSBaYXJyYWJpIHZpYSBPUC1URUUgd3JvdGU6DQo+IEhpIEplbnMsDQo+
IA0KPiBPbiA3LzcvMjAyNSA5OjIyIFBNLCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4+IEhpIEFt
aXIsDQo+Pg0KPj4gT24gTW9uLCBKdWwgNywgMjAyNSBhdCA0OjIy4oCvQU0gQW1pcnJlemEgWmFy
cmFiaSB2aWEgT1AtVEVFDQo+PiA8b3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmc+IHdy
b3RlOg0KPj4+DQo+Pj4gSGkgSmVucywNCj4+Pg0KPj4+IE9uIDYvMTAvMjAyNSAxMToxMyBQTSwg
SmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+Pj4+IEltcGxlbWVudCBETUEgaGVhcCBmb3IgcHJvdGVj
dGVkIERNQS1idWYgYWxsb2NhdGlvbiBpbiB0aGUgVEVFDQo+Pj4+IHN1YnN5c3RlbS4NCj4+Pj4N
Cj4+Pj4gUHJvdGVjdGVkIG1lbW9yeSByZWZlcnMgdG8gbWVtb3J5IGJ1ZmZlcnMgYmVoaW5kIGEg
aGFyZHdhcmUgZW5mb3JjZWQNCj4+Pj4gZmlyZXdhbGwuIEl0IGlzIG5vdCBhY2Nlc3NpYmxlIHRv
IHRoZSBrZXJuZWwgZHVyaW5nIG5vcm1hbCBjaXJjdW1zdGFuY2VzDQo+Pj4+IGJ1dCByYXRoZXIg
b25seSBhY2Nlc3NpYmxlIHRvIGNlcnRhaW4gaGFyZHdhcmUgSVBzIG9yIENQVXMgZXhlY3V0aW5n
IGluDQo+Pj4+IGhpZ2hlciBvciBkaWZmZXJlbnRseSBwcml2aWxlZ2VkIG1vZGUgdGhhbiB0aGUg
a2VybmVsIGl0c2VsZi4gVGhpcw0KPj4+PiBpbnRlcmZhY2UgYWxsb3dzIHRvIGFsbG9jYXRlIGFu
ZCBtYW5hZ2Ugc3VjaCBwcm90ZWN0ZWQgbWVtb3J5IGJ1ZmZlcnMNCj4+Pj4gdmlhIGludGVyYWN0
aW9uIHdpdGggYSBURUUgaW1wbGVtZW50YXRpb24uDQo+Pj4+DQo+Pj4+IFRoZSBwcm90ZWN0ZWQg
bWVtb3J5IGlzIGFsbG9jYXRlZCBmb3IgYSBzcGVjaWZpYyB1c2UtY2FzZSwgbGlrZSBTZWN1cmUN
Cj4+Pj4gVmlkZW8gUGxheWJhY2ssIFRydXN0ZWQgVUksIG9yIFNlY3VyZSBWaWRlbyBSZWNvcmRp
bmcgd2hlcmUgY2VydGFpbg0KPj4+PiBoYXJkd2FyZSBkZXZpY2VzIGNhbiBhY2Nlc3MgdGhlIG1l
bW9yeS4NCj4+Pj4NCj4+Pj4gVGhlIERNQS1oZWFwcyBhcmUgZW5hYmxlZCBleHBsaWNpdGx5IGJ5
IHRoZSBURUUgYmFja2VuZCBkcml2ZXIuIFRoZSBURUUNCj4+Pj4gYmFja2VuZCBkcml2ZXJzIG5l
ZWRzIHRvIGltcGxlbWVudCBwcm90ZWN0ZWQgbWVtb3J5IHBvb2wgdG8gbWFuYWdlIHRoZQ0KPj4+
PiBwcm90ZWN0ZWQgbWVtb3J5Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKZW5zIFdpa2xh
bmRlciA8amVucy53aWtsYW5kZXJAbGluYXJvLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+ICBkcml2ZXJz
L3RlZS9LY29uZmlnICAgICAgIHwgICA1ICsNCj4+Pj4gIGRyaXZlcnMvdGVlL01ha2VmaWxlICAg
ICAgfCAgIDEgKw0KPj4+PiAgZHJpdmVycy90ZWUvdGVlX2hlYXAuYyAgICB8IDQ3MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgZHJpdmVycy90ZWUvdGVlX3By
aXZhdGUuaCB8ICAgNiArDQo+Pj4+ICBpbmNsdWRlL2xpbnV4L3RlZV9jb3JlLmggIHwgIDY1ICsr
KysrKw0KPj4+PiAgNSBmaWxlcyBjaGFuZ2VkLCA1NDkgaW5zZXJ0aW9ucygrKQ0KPj4+PiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGVlL3RlZV9oZWFwLmMNCj4+Pj4NCj4+IFtzbmlwXQ0K
Pj4+DQo+Pj4gSSdtIGhhdmluZyBhIGJpdCBvZiB0cm91YmxlIHVuZGVyc3RhbmRpbmcgdGhlIHJh
dGlvbmFsZSBiZWhpbmQNCj4+PiBzdXBwb3J0aW5nIHRlZV9kZXZpY2VfdW5yZWdpc3Rlcl9hbGxf
ZG1hX2hlYXBzKCkuIENvbnNpZGVyaW5nIHRoYXQNCj4+PiB0aGUgaGVhcCByZW1haW5zIGFjY2Vz
c2libGUgZnJvbSB1c2Vyc3BhY2UsIHdvdWxkbid0IHRoaXMgbGVhZA0KPj4+IHRvIHVuZGVmaW5l
ZCBiZWhhdmlvcj8gRm9yIGV4YW1wbGUsIHdoYXQgaGFwcGVucyBpZiBhIHVzZXIgaXMNCj4+PiBp
biB0aGUgbWlkZGxlIG9mIGEgdGVlX2RtYV9oZWFwX2FsbG9jKCkgLS0gc3BlY2lmaWNhbGx5IGJl
Zm9yZQ0KPj4+IHRlZV9kZXZpY2VfZ2V0KCkgLS0gd2hpbGUgdGhlIGJhY2tlbmQgY2FsbHMgdGVl
X2RldmljZV91bnJlZ2lzdGVyX2FsbF9kbWFfaGVhcHMoKT8NCj4+DQo+PiBUaGF0IGNhbid0IGhh
cHBlbiBzaW5jZSB0ZWVfZGV2aWNlX3VucmVnaXN0ZXIoKSBoYXMgYmVlbiBjYWxsZWQNCj4+IGJl
Zm9yZSwgZ3VhcmFudGVlaW5nIHRoYXQgbm8gZnVydGhlciBjYWxscyB0byB0ZWVfZGV2aWNlX2dl
dCgpIGNhbg0KPj4gc3VjY2VlZC4NCj4+DQo+IA0KPiBUaGUgaXNzdWUgbGllcyB3aXRoIHRlZV9k
ZXZpY2VfdW5yZWdpc3RlcigpLiBBZnRlciBpdCByZXR1cm5zLA0KPiB0ZWVkZXYgaXMgcmVsZWFz
ZWQgKEkgZG9uJ3Qgc2VlIGdldF9kZXZpY2UoKSBhbnl3aGVyZSksIHlldCB0aGUgZG1hIGhlYXAN
Cj4gaXMgc3RpbGwgaG9sZGluZyBhIHJlZmVyZW5jZSB0byBpdC4gSSBiZWxpZXZlIGl0IGNvdWxk
IGNhdXNlIG51bGwgZGVyZWYuDQo+IA0KDQpBZnRlciByZXZpZXdpbmcgaXQgYWdhaW4sIHlvdSdy
ZSByaWdodCAtLSBJIGRpZG7igJl0IG5vdGljZSB0aGF0IHRlZWRldg0KaXMgYmVpbmcgcmVhZCBm
cm9tIGgtPnRlZWRldi4gSG93ZXZlciwgc2luY2UgaC0+dGVlZGV2IGNvdWxkIGJlIG51bGwsDQp3
ZSBzaG91bGQgc3RpbGwgY2hlY2sgZm9yIG51bGwgYmVmb3JlIGNhbGxpbmcgdGVlX2RldmljZV9n
ZXQoKS4NCg0KPj4+DQo+Pj4gSSB1bmRlcnN0YW5kIHRoYXQgeW91IHdhbnQgdG8gdXNlIHRlZWRl
diByZWZjb3VudCB0byBwcm90ZWN0IGFnYWluc3QNCj4+PiB0aGUgVEVFIGRyaXZlciB1bmJpbmRp
bmcgaWYgdGhlcmUgaXMgYSBidWZmZXIgYWxsb2NhdGVkLiBCdXQgd2hhdCBhYm91dA0KPj4+IHRo
ZSBoZWFwIGRldmljZT8NCj4+Pg0KPj4+IEFkZGl0aW9uYWxseSwgd2hhdCBpZiB0aGUgdXNlciBk
ZWNpZGVzIHRvIHVuYmluZCB0aGUgVEVFIGJhY2tlbmQgZHJpdmVyPw0KPj4+IFdvdWxkIHRoZSBk
bWFfaGVhcCBkZXZpY2Ugc3RpbGwgcGVyc2lzdCB3aXRob3V0IGFueSBhbGxvYyBmdW5jdGlvbj8N
Cj4+DQo+PiBZZXMsIHRoZSBkZXZpY2Ugd291bGQgc3RpbGwgYmUgdGhlcmUsIGJ1dCBhbGxvYyB3
b3VsZCByZXR1cm4gLUVJTlZBTA0KPj4gdW50aWwgYSBuZXcgaGVhcCBoYXMgYmVlbiByZWdpc3Rl
cmVkLg0KPiANCj4gVGhhdOKAmXMgb25seSB2YWxpZCBpZiB0aGUgYmFjay1lbmQgaXMgYnVpbHQt
aW4uIFdoYXQgaGFwcGVucyBpZiBpdOKAmXMNCj4gYSBtb2R1bGUgYW5kIGdldHMgcmVtb3ZlZD8g
SW4gdGhhdCBjYXNlLCB0aGUgYWxsb2MgZnVuY3Rpb24gaXNu4oCZdCBwcmVzZW50DQo+IHRvIHJl
dHVybiAtRUlOVkFMLiBQZXJoYXBzIHVzaW5nIG1vZHVsZV9nZXQoKSBmb3IgZWFjaCBkbWEgaGVh
cCBjb3VsZA0KPiBiZSBhIHdvcmthcm91bmQgZm9yIG5vdz8NCj4gDQoNClRoaXMgcG9pbnQgcmVt
YWlucyB2YWxpZDogaWYgd2UncmUgdXNpbmcgdGhlIGRtYSBoZWFwLCB3ZSBzaG91bGQgZWl0aGVy
DQp1c2UgbW9kdWxlX2dldCgpIG9yIG1ha2UgdGhlIGRyaXZlciBidWlsdC1pbi4NCg0KUmVnYXJk
cywNCkFtaXINCg0KPj4gQnV0IEkgdGhpbmsgeW91J3JlIG9uIHRvIHNvbWV0aGluZywgd2Ugc2hv
dWxkIHBlcmhhcHMgaW5jcmVhc2UgdGhlIFRFRQ0KPj4gbW9kdWxlIHJlZmNvdW50IHdoZW4gY2Fs
bGluZyBkbWFfaGVhcF9hZGQoKS4gRG8geW91IGFncmVlPw0KPj4NCj4gDQo+IFNpbmNlIHRoZSBs
aWZldGltZSBvZiB0aGUgZG1hIGhlYXBzIGFmZmVjdHMgdGVlZGV2LCBpdCBzZWVtcyBtb3JlDQo+
IGFwcHJvcHJpYXRlIHRvIG1haW50YWluIGEgcmVmZXJlbmNlIGNvdW50IHBlciBkbWEgaGVhcCBh
bmQgcmVsZWFzZSBpdA0KPiBkdXJpbmcgdW5yZWdpc3Rlci4gVGhpcyBhbHNvIGFkZHJlc3NlcyB0
aGUgZmlyc3QgaXNzdWUuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbWlyDQo+IA0KPj4+DQo+Pj4gSW4g
dGhlIGNhc2Ugb2YgcWNvbXRlZSwgbXkgb3JpZ2luYWwgaWRlYSB3YXMgdG8gaGF2ZSB0d28gc2Vw
YXJhdGUNCj4+PiBkcml2ZXJzIGxvYWRlZCBhbG9uZ3NpZGUgZWFjaCBvdGhlci4gVGhpcyBzZXR1
cCB3b3VsZCBhbGxvdyB0aGUNCj4+PiBURUUgYmFja2VuZCBkcml2ZXIgdG8gc3VwcG9ydCB1bmJp
bmRpbmcsIHdoaWxlIHRoZSBwcm90ZWN0ZWQgbWVtb3J5DQo+Pj4gYmFja2VuZCBjb3VsZCByZW1h
aW4gbG9hZGVkLiBUaGlzIHNlcGFyYXRpb24gaXMgcGFydGljdWxhcmx5IHVzZWZ1bA0KPj4+IGZv
ciBGRkEsIG9yIHNjZW5hcmlvcyB3aGVyZSB0aGUgcHJvdGVjdGVkIGJ1ZmZlciBkb2VzIG5vdCBu
ZWVkIHRvIGJlDQo+Pj4gdHJhbnNmZXJlZCB0byBURUUuDQo+Pj4NCj4+PiBPcg0KPj4+DQo+Pj4g
QSByZWZlcmVuY2UgdG8gdGVlZGV2IGNvdWxkIGJlIG9idGFpbmVkIHdoZW4gdGhlIGhlYXAgaXMg
cmVnaXN0ZXJlZCwNCj4+PiByYXRoZXIgdGhhbiBmb3IgZWFjaCBidWZmZXIgYWxsb2NhdGlvbi4g
SW4gb3RoZXIgd29yZHMsIG9uY2UgdGhlIGhlYXANCj4+PiBpcyByZWdpc3RlcmVkLCB0aGUgYmFj
a2VuZCBtdXN0IHJlbWFpbiBhY3RpdmUgYW5kIGNhbm5vdCBiZSB1bmxvYWRlZC4NCj4+Pg0KPj4+
IE9yDQo+Pj4NCj4+PiBGaW5kIGEgd2F5IHRvIGhhdmUgc29tZXRoaW5nIGxpa2UgZG1hX2hlYXBf
cm0oKT8NCj4+DQo+PiBUaGF0IHdvdWxkIGJlIGhlbHBmdWwsIGJ1dCBJJ2QgcHJlZmVyIHRvIGtl
ZXAgaXQgb3V0IG9mIHRoZSBzY29wZSBvZg0KPj4gdGhlIHBhdGNoc2V0IGlmIHBvc3NpYmxlLg0K
Pj4NCj4+IFRoYW5rcywNCj4+IEplbnMNCj4+DQo+Pj4NCj4+PiBQbGVhc2UgbGV0IG1lIGtub3cg
aWYgSSBtaXMtdW5kZXJzdG9vZCBzb21ldGhpbmc/IG9yIG1pc3Npbmcgc29tZXRoaW5nIDopDQo+
Pj4NCj4+PiBSZWdhcmRzLA0KPj4+IEFtaXINCj4+Pg0KPj4+PiArdm9pZCB0ZWVfZGV2aWNlX3Vu
cmVnaXN0ZXJfYWxsX2RtYV9oZWFwcyhzdHJ1Y3QgdGVlX2RldmljZSAqdGVlZGV2KQ0KPj4+PiAr
ew0KPj4+PiArICAgICBzdHJ1Y3QgdGVlX3Byb3RtZW1fcG9vbCAqcG9vbDsNCj4+Pj4gKyAgICAg
c3RydWN0IHRlZV9kbWFfaGVhcCAqaDsNCj4+Pj4gKyAgICAgdV9sb25nIGk7DQo+Pj4+ICsNCj4+
Pj4gKyAgICAgeGFfZm9yX2VhY2goJnRlZV9kbWFfaGVhcCwgaSwgaCkgew0KPj4+PiArICAgICAg
ICAgICAgIGlmIChoKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBwb29sID0gTlVMTDsN
Cj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIG11dGV4X2xvY2soJmgtPm11KTsNCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgIGlmIChoLT50ZWVkZXYgPT0gdGVlZGV2KSB7DQo+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHBvb2wgPSBoLT5wb29sOw0KPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBoLT50ZWVkZXYgPSBOVUxMOw0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBoLT5wb29sID0gTlVMTDsNCj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgIH0NCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmaC0+bXUpOw0K
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgaWYgKHBvb2wpDQo+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBvb2wtPm9wcy0+ZGVzdHJveV9wb29sKHBvb2wpOw0KPj4+PiArICAg
ICAgICAgICAgIH0NCj4+Pj4gKyAgICAgfQ0KPj4+PiArfQ0KPj4+PiArRVhQT1JUX1NZTUJPTF9H
UEwodGVlX2RldmljZV91bnJlZ2lzdGVyX2FsbF9kbWFfaGVhcHMpOw0KPiANCg0K
