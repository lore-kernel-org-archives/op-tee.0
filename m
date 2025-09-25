Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1714CAC5A5
	for <op-tee@archiver.kernel.org>; Thu, 25 Sep 2025 01:46:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C3DE431BB
	for <op-tee@archiver.kernel.org>; Thu, 25 Sep 2025 01:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758764801;
	bh=lsa9m33blwafrYfwkLueGMRIhtxSFxZ8mpXk5tyXF48=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=lCmomS4OtVBszUhgFU2oJ1VRF+ZIsBu+KKOy1zulVhryvHLKfRsvIeduC2km4Mda0
	 Tn0Nzqh1ahwKASXYTxy1HJq76y7VQQHcqimsikC8k0kF+24LCr+0QDmMjfa/LfNvsf
	 kU4TCxnD4JRzkbh9SCtqj7zNyf6pWHQKoogtepM7tCekjBbnaTR3rRviTuKj6YIpoy
	 LectL4Z5kPJVRoRKBW1CRa+BdCo/O4zQuXWmo2r5ShlTeBmzQqxMU5RV3lT+iMY8jt
	 qABBpDhs7vpH6GKrcvv4cTbP/o9/rkh0TIDAwG6tCRH0SOC1+2jVV9Kgtz+XXk1ThG
	 RXGHaANNNEYJg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2238441828
	for <op-tee@lists.trustedfirmware.org>; Thu, 25 Sep 2025 01:46:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YPKwqz5I;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0FJwU025129
	for <op-tee@lists.trustedfirmware.org>; Thu, 25 Sep 2025 01:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z10OZLyPBneNQ93YhoH9EuyJNkxrj7NSBb0ueDONA9o=; b=YPKwqz5Is8V8m0Li
	ycZ6HnW5uOrnFV3/3ucxzdwRSOYy3kw90cEYCZ/WU3Oz+WQOJRaqoj7SmKdQDixH
	zOscYBeIJcCpipV7+0KhEhpoViCFId0kJPBcP5+eHyIil6Pac3OrxD7rSrGf6MIB
	VrmHDxa2lVzZS8sncR4evzL3u5s5b3NDFxJcjkVUrI35NkDhCQ/saPrEojr7mkFz
	OdH4Jkm3OyxxrVZ7p8D/XDZ1V0JVp+JkuFM4AqN7UOpskjVuuD+9LLqTtcOeZ1cP
	IZtezERVwahLGxTecBwvHqfTocJAqjMoSvDwL++oNdB+TTwXhMCUt+uzcwuL7spS
	JKH7TQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv16c1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 25 Sep 2025 01:46:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ae30bd2d0so3486575ad.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 18:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758764785; x=1759369585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z10OZLyPBneNQ93YhoH9EuyJNkxrj7NSBb0ueDONA9o=;
        b=h1kzJy2pkOnS1wM8SWU/jJP6/A2/AiKhu50AsHs9rE+eOC1cnAFeXpGkjvgxgKoj05
         rS/nTAJzWTxgOoJTIx6qFu3sFB7cF4NU9aNgtwkFxCjBX6hetqEKP3O5yS9f3PKesqVu
         aIGFKhcMN+tIFYVn+oShkOg62751ku36pS6YrqEG/jgG2sfw7Gjtv4Rm7AcJE/QE4GPT
         v6oF0lDtRA7Fy1xeMqIrMTNW7bV3iNpvxtiLQspWIDXCj7datlVZ63Bos6ugGJK7XWe4
         h0mL7Vy8Eom+hKlOWpIpzHR/1UgPgAqpWJoxDQt9o58L6xrG/mzLGdbOkwRKBag000vP
         EuxA==
X-Forwarded-Encrypted: i=1; AJvYcCVUhdF7Tyo68RBol958zWq3Rjn+EfLrpNBn1l9isUxaLEopqdzwz3LHvZKQRCPKtOIiZfRhtCw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxqh/3WSuKKPaZ8xNnjqnnhJZjvk3tqIIzj6YTTUx4vywxaGbve
	sXzbm+K8xE5OJEmwkH1IvR1JQultXhEzuxumyLbEb9g/j9AZuZj5b1u5V5L43CY8hd4GMXO7n0v
	RjwDdCLINW0WwZy8zo8zmjv58YLGJOod+gNAzpaEMdNfmH6Tu/2h6HufUFSG1yYD4kNnb1XM=
X-Gm-Gg: ASbGncvSNzgpYidw85o39XJ/H087V+Kgu4thZ4LjngebJ4xGoCc4OOu7HU8JPWCrj7U
	H9OpVInKKyoFeNVNH/DW68D5BcFkDcZoFoIBPsfiBz/J8LHlxbAZkEAGiLABdnC26myEj0q+eMY
	+qI9r0q2SPxjL+K3APG8Hq47IMVXrIrejSYeHoi0iJqfcYRh0JtaBFajWyYjuUnb7m3RnAkJGog
	49o2gdSUYaPzTmcejdIUOmWQksLZty5eUTvjygYbTMwIhuF7OAqp0u2pCPb7R7PoM0gJK1cvQNZ
	tE4CYIy1Eie5hgvGQjD06PXyY+qmsm3Kw7a/i/OISNqMtL56nMOkqSirROHWAEccCAuPG7RDCxv
	7sNv9XoHosJU7ZWuxLO0IP/d/Rip8iHsOo2qFrw==
X-Received: by 2002:a17:902:d4c1:b0:26a:589b:cf11 with SMTP id d9443c01a7336-27ed4ab31e3mr21067175ad.43.1758764785090;
        Wed, 24 Sep 2025 18:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkWVGsBMaLTmduKHWETBWGp2jxTB4gwYRIKlo2+7MPdlsABDo1JV2x1OEc2s9kaTB1M7uB4A==
X-Received: by 2002:a17:902:d4c1:b0:26a:589b:cf11 with SMTP id d9443c01a7336-27ed4ab31e3mr21066865ad.43.1758764784645;
        Wed, 24 Sep 2025 18:46:24 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6adca51sm6355395ad.147.2025.09.24.18.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 18:46:24 -0700 (PDT)
Message-ID: <6a0477dc-2f4a-4a72-85b3-9de42759cdb5@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:46:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <aMvV4kK386Sni10i@stanley.mountain>
 <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
 <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>
 <aNOfXlG21HIBR18E@stanley.mountain>
 <CAHUa44G2yaB28sd0FjkjyCNJKXjx2Jg9j-9HXytyvsmiQ3ThAA@mail.gmail.com>
 <aNPAT_uf-JFvBvkV@stanley.mountain>
Content-Language: en-US
In-Reply-To: <aNPAT_uf-JFvBvkV@stanley.mountain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -lk4wFiwYq3SqY8hfZig6b8LWnECFN-N
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d49ef2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=BRsQPDxWgBvOXLHaTS8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX4Ed1OY1b+5YK
 0QRigtM5xoZ2PaU2HjEtrJdPv2GzcjAiisAm2jQamCCThRnbm/sFJxOa2MWwxk4GUGdVKnI2Pes
 /f9X+j3epOdVAPWhmGzoGOYTLKX9awbZWXQuYZ5wvZWPpL+VUTcQXextoU8FDotxatUB9Ake4Kv
 SM5SSiULUlMXOzcHIiEOAQcw9S7YFWUzQ8SurpXZHpTtqrxbX7UYJyccGA2s72YY1LAlKiOvxIb
 PQB8BWeW5sZsTrXrzN+bC3DP1luj1VPgifyNKLXFWnaa/EYz6XhdDTh5JfzaRMjj7Udy5ue7UGV
 gpjbkZIGKls2HEBbKNpv0wDQq0T6C50Vpt1vFIZXmtKqSKuf5CAUB+dVsxzFK6WRlwhnneduVZX
 M77PFxSm
X-Proofpoint-ORIG-GUID: -lk4wFiwYq3SqY8hfZig6b8LWnECFN-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025
X-Rspamd-Queue-Id: 2238441828
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: ZAYEC3UFZI4N2VHPOEO4W5BQ72LTXKFM
X-Message-ID-Hash: ZAYEC3UFZI4N2VHPOEO4W5BQ72LTXKFM
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZAYEC3UFZI4N2VHPOEO4W5BQ72LTXKFM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

DQoNCk9uIDkvMjQvMjAyNSA3OjU2IFBNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBPbiBXZWQs
IFNlcCAyNCwgMjAyNSBhdCAxMToyMTozNEFNICswMjAwLCBKZW5zIFdpa2xhbmRlciB3cm90ZToN
Cj4+IE9uIFdlZCwgU2VwIDI0LCAyMDI1IGF0IDk6MzbigK9BTSBEYW4gQ2FycGVudGVyIDxkYW4u
Y2FycGVudGVyQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+DQo+Pj4gT24gV2VkLCBTZXAgMjQsIDIw
MjUgYXQgMDg6NTg6NDVBTSArMTAwMCwgQW1pcnJlemEgWmFycmFiaSB3cm90ZToNCj4+Pj4NCj4+
Pj4NCj4+Pj4gT24gOS8yNC8yMDI1IDg6NDggQU0sIEFtaXJyZXphIFphcnJhYmkgd3JvdGU6DQo+
Pj4+PiBPbiA5LzE4LzIwMjUgNzo1MCBQTSwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4+Pj4+PiBS
ZS1vcmRlciB0aGVzZSBjaGVja3MgdG8gY2hlY2sgaWYgImkiIGlzIGEgdmFsaWQgYXJyYXkgaW5k
ZXggYmVmb3JlIHVzaW5nDQo+Pj4+Pj4gaXQuICBUaGlzIHByZXZlbnRzIGEgcG90ZW50aWFsIG9m
ZiBieSBvbmUgcmVhZCBhY2Nlc3MuDQo+Pj4+Pj4NCj4+Pj4+PiBGaXhlczogZDZlMjkwODM3ZTUw
ICgidGVlOiBhZGQgUXVhbGNvbW0gVEVFIGRyaXZlciIpDQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
RGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPj4+Pj4+IC0tLQ0KPj4+
Pj4+ICBkcml2ZXJzL3RlZS9xY29tdGVlL2NhbGwuYyB8IDIgKy0NCj4+Pj4+PiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMgYi9kcml2ZXJzL3RlZS9xY29tdGVl
L2NhbGwuYw0KPj4+Pj4+IGluZGV4IGNjMTdhNDhkMGFiNy4uYWMxMzQ0NTJjYzljIDEwMDY0NA0K
Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdGVlL3Fjb210ZWUvY2FsbC5jDQo+Pj4+Pj4gKysrIGIvZHJp
dmVycy90ZWUvcWNvbXRlZS9jYWxsLmMNCj4+Pj4+PiBAQCAtMzA4LDcgKzMwOCw3IEBAIHN0YXRp
YyBpbnQgcWNvbXRlZV9wYXJhbXNfZnJvbV9hcmdzKHN0cnVjdCB0ZWVfcGFyYW0gKnBhcmFtcywN
Cj4+Pj4+PiAgICB9DQo+Pj4+Pj4NCj4+Pj4+PiAgICAvKiBSZWxlYXNlIGFueSBJTyBhbmQgT08g
b2JqZWN0cyBub3QgcHJvY2Vzc2VkLiAqLw0KPj4+Pj4+IC0gIGZvciAoOyB1W2ldLnR5cGUgJiYg
aSA8IG51bV9wYXJhbXM7IGkrKykgew0KPj4+Pj4+ICsgIGZvciAoOyBpIDwgbnVtX3BhcmFtcyAm
JiB1W2ldLnR5cGU7IGkrKykgew0KPj4+Pj4+ICAgICAgICAgICAgaWYgKHVbaV0udHlwZSA9PSBR
Q09NVEVFX0FSR19UWVBFX09PIHx8DQo+Pj4+Pj4gICAgICAgICAgICAgICAgdVtpXS50eXBlID09
IFFDT01URUVfQVJHX1RZUEVfSU8pDQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgIHFjb210ZWVf
b2JqZWN0X3B1dCh1W2ldLm8pOw0KPj4+Pj4NCj4+Pj4+IFRoaXMgaXMgbm90IHJlcXVpcmVkLCBj
b25zaWRlcmluZyB0aGUgc2VxdWVuY2Ugb2YgY2xlYW4gdXAsIHRoaXMNCj4+Pj4+IHdvdWxkIG5l
dmVyIGhhcHBlbi4gYGlgIGF0IGxlYXN0IGhhdmUgYmVlbiBhY2Nlc3NlZCBvbmNlIGluIHRoZQ0K
Pj4+Pj4gc3dpdGNoIGFib3ZlLg0KPj4+Pj4NCj4+Pj4+IFJlZ2FyZHMsDQo+Pj4+PiBBbWlyDQo+
Pj4+Pg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gQWxzbywgc2l6ZSBvZiB1IGlzIGFsd2F5cyBudW1fcGFy
YW1zICsgMSBmb3IgdGhlIGVuZGluZyAwLg0KPj4+PiAoYmFzaWNhbGx5IG1lYW5zIGBpIDwgbnVt
X3BhcmFtc2AgY2FuIGJlIHJlbW92ZWQpLg0KPj4+Pg0KPj4+DQo+Pj4gWWVzLiAgVGhpcyBpcyB0
cnVlLg0KPj4NCj4+IFNvIHRoaXMgcGF0Y2ggaXNuJ3QgbmVlZGVkLiBJJ2xsIGRyb3AgaXQgaWYg
bm8gb25lIG9iamVjdHMuDQo+IA0KPiBUaGUgcGF0Y2ggbWFrZXMgdGhlIGNvZGUgYmV0dGVyIHRo
b3VnaC4uLiAgSXQgbmV2ZXIgcmVhbGx5IG1ha2VzIHNlbnNlDQo+IHRvIHVzZSBhIHZhcmlhYmxl
IGZpcnN0IGFuZCB0aGVuIGNoZWNrIGlmIGl0J3MgdmFsaWQgbGF0ZXIuICBJbiB0aGlzDQo+IGNh
c2UgdGhlIGNoZWNrIGlzbid0IHJlcXVpcmVkLg0KPiANCj4gSWRlYWxseSB0aGUgY29kZSB3b3Vs
ZCBvbmx5IGhhdmUgb25lIGxpbWl0LiAgV2UgY291bGQgZWl0aGVyIGRvOg0KPiANCj4gCWZvciAo
OyBpIDwgbnVtX3BhcmFtczsgaSsrKSB7DQo+IE9yOg0KPiAJZm9yICg7IHVbaV0udHlwZSAhPSBR
Q09NVEVFX0FSR19UWVBFX0lOVjsgaSsrKSB7DQo+IA0KPiBFaXRoZXIgd2F5IHdvcmtzLi4uDQo+
IA0KPiByZWdhcmRzLA0KPiBkYW4gY2FycGVudGVyDQo+IA0KDQpPcmlnaW5hbGx5LCBpdCB3YXMg
d3JpdHRlbiBhcw0KDQoJZm9yICg7IHVbaV0udHlwZSAhPSBRQ09NVEVFX0FSR19UWVBFX0lOVjsg
aSsrKSB7IC4uLg0KDQpidXQgY2hhbmdlZCB0cm91Z2ggb3V0IHRoZSByZXZpZXcgcHJvY2Vzcy4J
DQpJIGRvIG5vdCBoYXZlIGFueSBwcmVmZXJlbmNlLiBCdXQgaWYgaGF2aW5nIGl0IGFzDQoNCglm
b3IgKDsgaSA8IG51bV9wYXJhbXMgJiYgdVtpXS50eXBlOyBpKyspIHsgLi4uDQoNCmlzIG1vcmUg
cmVhZGFibGUsIGxldCdzIGtlZXAgaXQuDQoNClJlZ2FyZHMsDQpBbWlyDQoNCg==
