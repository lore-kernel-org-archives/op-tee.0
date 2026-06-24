Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC320CDB479
	for <op-tee@archiver.kernel.org>; Wed, 24 Jun 2026 03:39:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 19F5E4389A
	for <op-tee@archiver.kernel.org>; Wed, 24 Jun 2026 03:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782272381;
	bh=EnFpa/bGsAeGQjw+N/P5gG1c83gXD0UVAz4WD24fZ1M=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=hAwqMeZGbSH5Cd1Kv5Yagi65NjYUL7Xv1KZ+Ku3OxBYPYL6W2uPgx0ybuVipp1120
	 EaU1VsS5JB7KER5JEwV2J61xprYg4peQEI9uU94Hl+uG/2K5mfOIpIfDE95WjUBmNg
	 l48CVxL+IMH+lvCCbnglLsWoDkanBdy2HuoIekrS05rP0ti9KBaduJBA++Qj7D8RC8
	 g/Slj014yb9K8Y1PDVg3hEJQFwMaBGDyLibfacmq83gdKl168NLBLSrmpmby8fQjAc
	 WPBaKp/VMNKIdNg4nf0v6HcRp2cHMBhl+bRvk9MPhp2N+qIJ5w1uu6ytmwlSaG8aJH
	 GkurshuYnZk/w==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D596243829
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Jun 2026 03:39:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JYe5kdPK;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GH3VHtwh;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O1U27F1686410
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Jun 2026 03:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s0+XSenEQTH5fxmy4dSQBjH5RjWqklrxJNjZYQ6591Q=; b=JYe5kdPK6G8mYgg3
	8XP3zCeiGHkzuT0TcZJsrZCCjNMfbCw+ltwP+MS73WkQ8a7KmZl+jJqpfvTjVX//
	9tg0qomyMap6oIyo4Y2IpIhKihgY5QlkbLnZduJiw0gNGRyEPh+ZeGs6HSSoxPZ7
	yxRF9iBkK6gRgXH8zS9irH9UHh+gOswgMsKYUhVI88uAkeyFcM+4PYPbqm5H7X/j
	G8Yo7RbMFk+ZcIKovcY0JtLSudxsiBbEH4obpKOOjoTqVt78+PryOcTkdLi8F8Jn
	HD4+8i0edgzuaqlqrIrv6k/fpjF9pl+ldd/+iPT04E5yVYm1DPWQF7ZSg20smqEt
	n2C7UA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9yumvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Jun 2026 03:39:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37c6916c768so727659a91.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 20:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782272367; x=1782877167; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0+XSenEQTH5fxmy4dSQBjH5RjWqklrxJNjZYQ6591Q=;
        b=GH3VHtwhkbt4Fk0nwcidOYdoplphmYcN1LOG04WYyc5O/9NCtT8z7K8upXs/li6vAR
         uiVRyqofLwQtjVjNrbXyDg49N1UBIwKIUGWTB4Ui6OoApk6NT1v59fx+VbtXnbqxzpNt
         N8wj4YRkO+2mTXWexpX2c2bHHhsFUx+Gu+uTV5tkyR4NoxcCF/4BMVe3Xx/ur8Dr1P7o
         Jdz5C8+1KtPw1TlDMmZkSHrxRnFg0/Ed+na099QTSyLtajOeWR+c2avjSpC2XUWF5qQM
         HPbfONiz1gUMuYmKpshN60ngea5BvcEGTnDn8EZi2Oymydd6N7Jcb+ORwVHaQ/ufEhMe
         GVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782272367; x=1782877167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0+XSenEQTH5fxmy4dSQBjH5RjWqklrxJNjZYQ6591Q=;
        b=sBPJRHBch7nwneGsivlerHlysTp4U//xXiw76BiHCzAPrd1GjqA8EVL+H9oaUV0qh1
         oyc+k8hVebsBgrhuh63hdSP7HZ53RNUV+56OVuDqeZTJlMRRmXVIjUBWtX7Gghybhagt
         mWrBpacXqkKjWaELaJ3+NCtj6mUaVFhWnxIQm34bs+01c8bdb+YarbT95vZNrRSvDzcF
         EPwMwAm6Sz6Pdxkpqmz3Sk2dbv9BSRqzpJuF4N30L0OSEaA7mk6+buDWzuK8NXfJHwVW
         eRtumAbH5h2wIOHD6RkQZwBTL3kBbN4Bd+gDKrtQg7abv0OnuFhRFUCgCaZWBU4PHHIW
         YF9w==
X-Forwarded-Encrypted: i=1; AHgh+RqaL0VGzJcK1fifCWGnaGzsNbH/Wsh5Ya0X2+MGnmRxIhv2o5QyKVAObZYNNBiUKSma1siDDoo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxI481mwftQg1rBK1GwnB71RMGAPkulEaErJxj2OyFTiGe+m8C0
	rDuEF54kZN50C04uEFkdzLuzdGRXrmEU6yNxB+DYEB1Z7/XktNQMXYec/OZ6UOQM+LycnMrxjb1
	0KRNz2U442TjGLe0NvMWFKhH5FyUp4TKfofhnOMWjavkzCtMwRcmHdAPgpRrddrqYgA6xmaQ=
X-Gm-Gg: AfdE7clUIxY64umNBkVx+T6hwOornuvBR0GPbF4jXS3dYMlKoJ2I4A8lKQekA2fngoi
	9AIsM0bO6oTKim1MMFl1nTHmJOB45iveRkcHqFgDfj5jzCNbfH/mfRYaH83IPUn3N2IBcIWLUKE
	AI0pNlelmEw375WhY5ByFTPKZYXmMJO952QjR0PIsbvZwgfOcsB8tRFcBpftDVCcmerejWd7CAO
	KOSWYZ8+NhWuSFKQ3YVLUSYow6tXvkyjEQOUGd+4dksoeurF9wTRZLBZgPphrZox7P4KQ9mGQVX
	cUb2eVY7Bl3RLtFWoIkLL7v/O1gD7mHIZANVhaDYlA1N3dfjWUmUSqmnYilzoaqxtKYxZMVjnXi
	QMhMgoMKLeKf+UcHzBPYEsRr7Mvy0h1lUEmoxENgLbXc=
X-Received: by 2002:a17:90b:57cc:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-37de415329bmr1726672a91.3.1782272366903;
        Tue, 23 Jun 2026 20:39:26 -0700 (PDT)
X-Received: by 2002:a17:90b:57cc:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-37de415329bmr1726647a91.3.1782272366408;
        Tue, 23 Jun 2026 20:39:26 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.15.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3ca3eabsm862534a91.1.2026.06.23.20.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 20:39:25 -0700 (PDT)
Message-ID: <6971c4b5-d091-4fe2-b843-60da8b32d48b@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 13:39:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tee: qcomtee: Drop unused assignment of
 platform_device_id driver data
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <c21803b3f2ea1522bb930dc1dcab79c2627f2234.1781620559.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
In-Reply-To: <c21803b3f2ea1522bb930dc1dcab79c2627f2234.1781620559.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3b516f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=+1+sR1ZYQ3C5TUrBrcwr6g==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=zM1L8A4z-D6ZsxyLzxkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: Dw9PutxbIrlIe8pJ4xxGYc9EQI4y_oR6
X-Proofpoint-ORIG-GUID: Dw9PutxbIrlIe8pJ4xxGYc9EQI4y_oR6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDAyNiBTYWx0ZWRfX/eQ4/twDI2i7
 8o3V+3U2M4mQIUPYAePTj2r36OQ/QhONyrXTOHWE5jXtFlJ8hHwwD3I+tpaYMjZQ6gOHuXZl18P
 579O46wnglutCulNtIumNWodh0pH/7qZtjwpdNg/bGi0mnXWfy8VkW8kLEpE0RChNdYgnHoSi9L
 FEcwxeFBJTB8MdLC3UihhXNtbHQ1T76MNbgBE74973NJ1pEHOvDq7LduW/WrVbK/0/1FytStZ4Z
 GsdX2ESrasuM3XbUNGD6aA8wulKuwWjj6mgP2o7rle1ZBWn1oanH0umoCRu6TTFulqyoD2OM3Yq
 QzTwei8ZmizOAvSDXop2xAMfTLBBQR+06K38vga5VkIJxnLlJA+6t7fy8S/NzUaysVu/U/6liPf
 lu5GESKIyU+nxEztCBYB+fY2a/sheQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDAyNiBTYWx0ZWRfX9E8hgjdGSfNz
 Rieo4gQEQdE3FA/c/lO/3II+FRa379lPBud9ocJCH9mXysBaxQOdOgDavWeDoFes15tW+6IFIFX
 j4/FACJhWhu3Il1TQ0qm/ekJpw9Iapg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240026
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D596243829
X-Spamd-Bar: -----
Message-ID-Hash: ENIGZIXZCGJ5LXPOUUBXMGK2JFEVHVQ6
X-Message-ID-Hash: ENIGZIXZCGJ5LXPOUUBXMGK2JFEVHVQ6
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ENIGZIXZCGJ5LXPOUUBXMGK2JFEVHVQ6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGksIA0KDQpPbiA2LzE3LzIwMjYgMTI6MzggQU0sIFV3ZSBLbGVpbmUtS8O2bmlnIChUaGUgQ2Fw
YWJsZSBIdWIpIHdyb3RlOg0KPiBUaGUgZHJpdmVyIGV4cGxpY2l0bHkgc2V0cyB0aGUgLmRyaXZl
cl9kYXRhIG1lbWJlciBvZiBzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlX2lkIHRvIHplcm8gd2l0
aG91dCByZWx5aW5nIG9uIHRoYXQgdmFsdWUuIERyb3AgdGhpcw0KPiB1bnVzZWQgYXNzaWdubWVu
dC4NCj4gDQo+IFdoaWxlIHRvdWNoaW5nIHRoaXMgYXJyYXkgdW5pZnkgc3BhY2luZyBhbmQgdXNh
Z2Ugb2YgY29tbWFzIGFuZCB1c2UNCj4gYSBuYW1lZCBpbml0aWFsaXplciBmb3IgLm5hbWUgZm9y
IGltcHJvdmVkIHJlYWRhYmlsaXR5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1L
w7ZuaWcgKFRoZSBDYXBhYmxlIEh1YikgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQo+
IC0tLQ0KPiBIZWxsbywNCj4gDQo+IHdoaWxlIHRoaXMgaXMgYSBjbGVhbnVwIHRoYXQgY2FuIHN0
YW5kIG9uIGl0cyBvd24sIGl0IGlzIGFsc28gYQ0KPiBwcmVwYXJhdGlvbiBmb3IgYSBjaGFuZ2Ug
dG8gc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCB0aGF0IHJlcXVpcmVzIHRoYXQNCj4gLmRyaXZl
cl9kYXRhIGlzbid0IGFzc2lnbmVkIGJ5IGEgbGlzdCBpbml0aWFsaXplci4NCj4gDQo+IEJlc3Qg
cmVnYXJkcw0KPiBVd2UNCj4gDQo+ICBkcml2ZXJzL3RlZS9xY29tdGVlL2NhbGwuYyB8IDcgKysr
KysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL3Fjb210ZWUvY2FsbC5jIGIvZHJpdmVycy90
ZWUvcWNvbXRlZS9jYWxsLmMNCj4gaW5kZXggMGVmYzU2NDYyNDJhLi40YTU5N2VlYWYxNzQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGVlL3Fjb210ZWUvY2FsbC5jDQo+ICsrKyBiL2RyaXZlcnMv
dGVlL3Fjb210ZWUvY2FsbC5jDQo+IEBAIC03OTgsNyArNzk4LDEyIEBAIHN0YXRpYyB2b2lkIHFj
b210ZWVfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJa2ZyZWUocWNv
bXRlZSk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
X2lkIHFjb210ZWVfaWRzW10gPSB7IHsgInFjb210ZWUiLCAwIH0sIHt9IH07DQo+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCBxY29tdGVlX2lkc1tdID0gew0KPiArCXsN
Cj4gKwkJLm5hbWUgPSAicWNvbXRlZSIsDQo+ICsJfSwNCj4gKwl7IH0NCj4gK307DQo+ICBNT0RV
TEVfREVWSUNFX1RBQkxFKHBsYXRmb3JtLCBxY29tdGVlX2lkcyk7DQo+ICANCg0KTG9va3MgZ29v
ZCB0byBtZSwgdGhhbmtzLg0KDQpSZXZpZXdlZC1ieTogQW1pcnJlemEgWmFycmFiaSA8YW1pcnJl
emEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPg0KDQo+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3Jt
X2RyaXZlciBxY29tdGVlX3BsYXRmb3JtX2RyaXZlciA9IHsNCj4gDQo+IGJhc2UtY29tbWl0OiA4
ZDZkYmJiZTNiYTYyZGUwYTYzZTk2MmVlMDA0YWZiODQ4YzhlM2FjDQoNCg==
