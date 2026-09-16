Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD0BC982C1
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 21:16:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0BEC3451E5
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 21:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789593405;
	bh=Lx3rxuvPspC0004K1T3IskMvpe3JjwyF7MxwqKXjC/I=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=a4+w426n9RQsK5ITfjXPYxi/Aa1b/4WUezqXCFwbQlZqVwY3ecaLCDSeLb5SyYT3K
	 FEOq/LVartmAVjiBOJ+2jfJyQOQXR6hKYwMSZ1ROQht5CX/L+dRVVrN2hQcOgz/4Y1
	 22yvqyAugezZvia1jIjsBuzdkujpzvxPN2zu3NE8oWQcllONgpUIgW5Za3aYIhcvnO
	 DRqpBEFDuhKaXnphimL4V2tlhFrJY5vGVunWJzbfzdaxXoj6s72RK/8kmBIlohJpeM
	 2RelyI05lDtnnZdMgVspu11HSSgcYYu73EdOSBEm6eQhyy4zZe7dPBkqxgisZ2BzLP
	 B4RXhP35XJMag==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C12744397D
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 21:16:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GGyK/0zH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bcu9C1/X;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFeQF93107625
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 21:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bJ5ikrelPOxZxaf5C/PtGjFWO0wzJsRg+Use1Q/ipvM=; b=GGyK/0zHNxSER+y2
	LaQiDgbRKmox1nWm6jaUokUYLQp7Wle7RA2P9+sEAt0iAnLMR/5HNtMUZVIXqAC9
	gxpBU2pYo437aMdnbYROqvsqeFmXRBpcwYO9tKgCY4vwuYPDTEVLWvypG+CDihoz
	OQnrWld7Q9ZTRb8uiXz5DsDm61iz+vtuoi6Hcu3KUTBCBkEp00qO90XSl4YnHIah
	4cD0QOf86qmD3vibijpIY8nYM5wqP/9sEeCQ4UEtV+Ayqm7lvWv91/fCA9bSchKC
	r5VSz8aurAUmSVofu7dpEpGm6C04jj6YrSJldOGTNpcdkU8Dwq26FGPJ4u42rzZU
	zTd7tg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquw2t36x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 21:16:37 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-396901263b6so218198a91.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789593396; x=1790198196; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJ5ikrelPOxZxaf5C/PtGjFWO0wzJsRg+Use1Q/ipvM=;
        b=Bcu9C1/XNvbhnbP3aru9mMl7i79R1oe3HHF1YQVr/WXasXy0J3swjvV5WB5ITGLJ0g
         uuxX6yzwTdfoAe7tMbDS7ZI0uKfS0M37JvsW/qc8kgs+6Km4OSWf8RcPW8pouzKL2n7G
         P60cGRBOL+JR4p3n7OFGXyc2BecGWwqraAoX8dwLeCNhK78b0NTDCGq4XSXhWC7tFm7g
         R2ETiGBJ3XTyLHCRHnn9wy9I82SFET5OVhLg4arZVITb7k7rpyKk1BjGYdvGoP//eXa5
         LRO26dLuC0PyX6t5uJ1tS9WVw18EoGg2URGP5TRLHjkpKGSQGPAUsPC60XiF5XweEbXu
         VE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593396; x=1790198196;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJ5ikrelPOxZxaf5C/PtGjFWO0wzJsRg+Use1Q/ipvM=;
        b=wPCqHVe4Rg0/UHC9L/DCR5Zv+TW54CBXIB+yVFpq8AiMEUVlLuDoedXud5FDU8D43B
         Fc6LfbAKNyYtsoMFz7PZKTwvAmeMoFWmo8/z4SpM9MBZLgS/TIeVA+yd4pea7rC74kob
         23UaNSg6Ula++06CrOdRCu8I5WMY9cpKcFZKFjGOTOQFBpeXWMGH7ONiC7t4Kd/xKNj7
         1dYhy8XU70FmWoBii6LdavalOsiJsGCl7ZdtiuJ6B6GCj8St+rbTtYjDSQPFMx/LFern
         3fFnXmQWxelgAhezTUYCihZPdtSRdGYFAW6I63b78K70W/yHysvQoIt/M51sRkcJo84i
         i8bA==
X-Forwarded-Encrypted: i=1; AKwUvBxC4kTzXKgO/wN932iMCHiz5E6F0lrXNr6CNoncA/3vzMvyTBbM6tzwJd8/e64pcdlBLLT3x3c=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lX3tzhYf0KiULk1mP+afdz76H6F1O0viNOEGD7Hb2jFWSJrguc
	Z8JV5orDBCn2+bfeEL47HLPSoMUEvr7bIhDWOv1DjXcLoXaA47u3V1e212gQ3Km/nYPNGqRfWaj
	lgyiub76U8Krm0DIH/c9tidfYGeHJd+qifPSGqBK68d1UHvp3WEYTKs8s3zbe4qVWJLAOmK8=
X-Gm-Gg: AYBFou0BMO7Jlm/NAMoNnjela7hB6b9gVk7ZmatWTlyDS1S7DUapbn/ZJkowGnMNy4A
	vbqi/kYFfJ383XHHEc74nkTaWWO0/SBJgUTwnSPHpy4TNkYd8D94mhyGGdCioEyMEb74OPhYvj4
	dYd05cxKYVw1grNSxDGO0qJ+CVnucNweCoavrQfRzJlml7ZvqlafhV/9Qo1PHWkUfCsEhODBLuP
	wGl7WekuVm1Zdw/XFMhWPUGgmf8RIhMNky8AGtfRp6bDBgTloLAdnHHu+vcpzqim2dNZU/tL4UX
	ZvDjMJdsCf8Hum+eXIaAMROa1Xug4FPqrc3Y0wOBU+bLOvQfUPwYY1UK73cGaOqnW/7R4cgSiU9
	RohMDp8FQVgWGj9hY6pwBLXnj6+lFtWcB
X-Received: by 2002:a17:90b:1811:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-39e1e250230mr11033519a91.5.1789593396036;
        Wed, 16 Sep 2026 14:16:36 -0700 (PDT)
X-Received: by 2002:a17:90b:1811:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-39e1e250230mr11033403a91.5.1789593395476;
        Wed, 16 Sep 2026 14:16:35 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.15.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35e532e4sm1147947a91.10.2026.09.16.14.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 14:16:34 -0700 (PDT)
Message-ID: <d7ba3e45-84fa-409d-bd43-23caa05587de@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 07:16:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/5] dt-bindings: tee: add RISC-V RPMI TEE transport
To: Anup Patel <anup@brainfault.org>
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
 <20260912-rpmi-tee-service-grp-dev-v1-5-1d1d35c2a859@oss.qualcomm.com>
 <CAAhSdy3Or_uDWuQniUGguc9AwL8smF6XHhJ0kizFOJKJ0N+9OA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAhSdy3Or_uDWuQniUGguc9AwL8smF6XHhJ0kizFOJKJ0N+9OA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI5NiBTYWx0ZWRfX4kvWQHJbLt7o
 /cnz6pjcDJ90/PASh4STR4FHi5thn3OaIaoAStYV8n4pi/j/DpDmFuSR/ylCZnn/tmKqAHwKXl7
 V9xbUS4TThtyUydoPeUJLmz2jB8ZWh0=
X-Proofpoint-GUID: CUf2ioj0NXqFFxkZ09qLhYFJHd9aWKEJ
X-Authority-Analysis: v=2.4 cv=N4m8hG9B c=1 sm=1 tr=0 ts=6aab0735 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=RYJI0oIToGyOemi2SthaJQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=b45o4kL6AAAA:8 a=oSFF6Vc5-LCmsOG0wpkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22 a=dhdsR-PFWuPJUldTnwXm:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: CUf2ioj0NXqFFxkZ09qLhYFJHd9aWKEJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI5NiBTYWx0ZWRfX75ln9o2cZRn/
 nMMraZ9mpHag55HTOMDnLf0DMSswBIM0I37GmbMVvL4Chgdc+pQ4rk0lNR7EqNxvSV9HnRrpFKK
 kAOxZuohP5oisSirdXrUHjDW0b2qAKng7pNz3wSQBJh48v0EeJK1imlWytEHmqIPyk1C52SQtuL
 n90vLJItdtCh1V0LkE17pd9w9WyHhdqsH2FwY7J214WiDMn2aXU/1BspkMV6N70nnOl7/6AzQZ/
 mboefNmvP6rGijGWWrK/MKrD3ZY6+mkb3zaUul6gaTT2aHVblQVdqFQhlPYmwF/OTJl0gEHbKVr
 JgooN25eWxGtgtq+SPQpjKxHf+vR78GyrDZSBEWDxVpxYrBgHoEqPYgVjGHtfEX0+mLbZrvTgEC
 wyKuD8PnHgM1uU1LYOCmkhxMEL9BksIT01C0Jdzf+OUGmBIR9Qz+Jc0Enwj2k8HpS54QMxhT0PS
 KzBk8+GHFe4wtNZhm2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160296
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C12744397D
X-Spamd-Bar: ----
Message-ID-Hash: HTUF42IZ4KOUBZGGCHJZOSVH7CKH4DZF
X-Message-ID-Hash: HTUF42IZ4KOUBZGGCHJZOSVH7CKH4DZF
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HTUF42IZ4KOUBZGGCHJZOSVH7CKH4DZF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgQW51cCwNCg0KT24gOS8xNi8yMDI2IDg6MTIgUE0sIEFudXAgUGF0ZWwgd3JvdGU6DQo+IE9u
IFNhdCwgU2VwIDEyLCAyMDI2IGF0IDM6NDXigK9QTSBBbWlycmV6YSBaYXJyYWJpDQo+IDxhbWly
cmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPj4NCj4+IEFkZCBhIGRldmlj
ZS10cmVlIGJpbmRpbmcgZm9yIHRoZSBPUC1URUUgUklTQy1WIHRyYW5zcG9ydCB1c2luZyB0aGUg
UlBNSQ0KPj4gVEVFIHNlcnZpY2UgZ3JvdXAgb3ZlciBTQkkgTVBYWS4NCj4+DQo+PiBEZXNjcmli
ZSBvbmUgbWFpbGJveCBjaGFubmVsIHBlciBoYXJ0IGFuZCBhbiBvcHRpb25hbCBpbnRlcnJ1cHQg
dXNlZCBhcw0KPj4gdGhlIGF2YWlsYWJpbGl0eSBkb29yYmVsbCBmb3IgYXN5bmNocm9ub3VzIG5v
dGlmaWNhdGlvbnMuDQo+Pg0KPj4gQWRkIHRoZSBiaW5kaW5nIHRvIHRoZSBleGlzdGluZyBPUC1U
RUUgTUFJTlRBSU5FUlMgZW50cnkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQW1pcnJlemEgWmFy
cmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPg0KPj4gLS0tDQo+PiAgLi4u
L2JpbmRpbmdzL3RlZS9yaXNjdixycG1pLW1weHktdGVlLnlhbWwgICAgICAgICAgfCA2NSArKysr
KysrKysrKysrKysrKysrKysrDQo+PiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy90ZWUvcmlzY3YscnBtaS1tcHh5LXRlZS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3RlZS9yaXNjdixycG1pLW1weHktdGVlLnlhbWwNCj4+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjhmNmZmMzEzZmQ0Mg0KPj4gLS0tIC9k
ZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RlZS9y
aXNjdixycG1pLW1weHktdGVlLnlhbWwNCj4+IEBAIC0wLDAgKzEsNjUgQEANCj4+ICsjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICsj
IENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vi
c2lkaWFyaWVzLg0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvdGVlL3Jpc2N2LHJwbWktbXB4eS10ZWUueWFtbCMNCj4+ICskc2No
ZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsN
Cj4+ICt0aXRsZTogUklTQy1WIFJQTUkgVEVFIHNlcnZpY2UgZ3JvdXAgYmFzZWQgbWVzc2FnZSBw
cm94eQ0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBBbWlycmV6YSBaYXJyYWJpIDxh
bWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+DQo+PiArDQo+PiArZGVzY3JpcHRpb246
IHwNCj4+ICsgIFRoZSBSSVNDLVYgUGxhdGZvcm0gTWFuYWdlbWVudCBJbnRlcmZhY2UgKFJQTUkp
IFsxXSBkZWZpbmVzIGEgbWVzc2FnaW5nDQo+PiArICBwcm90b2NvbCB3aGljaCBpcyBtb2R1bGFy
IGFuZCBleHRlbnNpYmxlLiBUaGUgc3VwZXJ2aXNvciBzb2Z0d2FyZSBjYW4NCj4+ICsgIHNlbmQv
cmVjZWl2ZSBSUE1JIG1lc3NhZ2VzIHZpYSB0aGUgU0JJIE1QWFkgZXh0ZW5zaW9uIFsyXSBvciBz
b21lIGRlZGljYXRlZA0KPj4gKyAgc3VwZXJ2aXNvci1tb2RlIFJQTUkgdHJhbnNwb3J0Lg0KPj4g
Kw0KPj4gKyAgVGhlIFJQTUkgc3BlY2lmaWNhdGlvbiBbMV0gZGVmaW5lcyBhIFRFRSBzZXJ2aWNl
IGdyb3VwIHdoaWNoIGlzIHRoZSBSSVNDLVYNCj4+ICsgIGFuYWxvZyBvZiBBcm0gRkYtQTogT1At
VEVFIGFuZCB0aGUgcmljaCBleGVjdXRpb24gZW52aXJvbm1lbnQgKFJFRSwgaS5lLg0KPj4gKyAg
TGludXgpIGFyZSBwZWVyIGVuZHBvaW50cyBhbmQgdGhlIFJQTUkgZnJhbWV3b3JrIChtYWNoaW5l
IG1vZGUgZmlybXdhcmUpDQo+PiArICBtZWRpYXRlcyBldmVyeSBtZXNzYWdlLiBFbnRlcmluZyBP
UC1URUUgb24gYSBoYXJ0IHJ1bnMgaXQgb24gdGhhdCBoYXJ0IHVudGlsDQo+PiArICBpdCByZXNw
b25kcywgc28gdGhlIFNCSSBpbXBsZW1lbnRhdGlvbiBwcm92aWRlcyBvbmUgU0JJIE1QWFkgY2hh
bm5lbCBwZXINCj4+ICsgIGhhcnQ7IGFsbCBvZiB0aGVtIGFyZSBsaXN0ZWQsIGluIGhhcnQgb3Jk
ZXIsIG9uIGEgc2luZ2xlIG5vZGUuDQo+PiArDQo+PiArICA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+PiArICBSZWZlcmVuY2VzDQo+PiArICA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+PiArDQo+PiArICBbMV0gUklTQy1W
IFBsYXRmb3JtIE1hbmFnZW1lbnQgSW50ZXJmYWNlIChSUE1JKSB2MS4wIChvciBoaWdoZXIpDQo+
PiArICAgICAgaHR0cHM6Ly9naXRodWIuY29tL3Jpc2N2LW5vbi1pc2EvcmlzY3YtcnBtaS9yZWxl
YXNlcw0KPj4gKw0KPj4gKyAgWzJdIFJJU0MtViBTdXBlcnZpc29yIEJpbmFyeSBJbnRlcmZhY2Ug
KFNCSSkgdjMuMCAob3IgaGlnaGVyKQ0KPj4gKyAgICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNj
di1ub24taXNhL3Jpc2N2LXNiaS1kb2MvcmVsZWFzZXMNCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0K
Pj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgY29uc3Q6IHJpc2N2LHJwbWktbXB4eS10ZWUNCj4+
ICsNCj4+ICsgIG1ib3hlczoNCj4+ICsgICAgbWluSXRlbXM6IDENCj4+ICsgICAgZGVzY3JpcHRp
b246DQo+PiArICAgICAgT25lIFNCSSBNUFhZIGNoYW5uZWwgaW1wbGVtZW50aW5nIHRoZSBSUE1J
IFRFRSBzZXJ2aWNlIGdyb3VwIHBlciBoYXJ0LA0KPj4gKyAgICAgIGxpc3RlZCBpbiB0aGUgc2Ft
ZSBvcmRlciBhcyB0aGUgQ1BVIG5vZGVzLg0KPiANCj4gSSBhbSBub3Qgc3VyZSB3aHkgeW91IG5l
ZWQgc2VwYXJhdGUgTVBYWSBjaGFubmVsIHBlciBoYXJ0LiBUaGUgTVBYWSBzaGFyZWQNCj4gbWVt
b3J5IGlzIGFscmVhZHkgcGVyLWhhcnQgd2hlcmVhcyB0aGUgTVBYWSBjaGFubmVsIHdpbGwgYmUg
ZG9tYW4gc3BlY2lmaWMNCj4gZm9yIFRFRS4NCg0KVHJ1ZS4gTXkgcmVhc29uaW5nIHdhcyB0aGF0
IFRFRV9DQUxMLCBhcyBJIHVuZGVyc3RhbmQgaXQsIGlzIGV4cGVjdGVkIHRvIGV4ZWN1dGUgb24N
CnRoZSBzYW1lIGhhcnQgdGhhdCBpc3N1ZWQgaXQuIEdpdmVuIHRoYXQsIHRoZSBtYWlsYm94IGNv
cmUgaG9sZHMgdGhlIHBlci1jaGFubmVsIHNwaW5sb2NrDQphY3Jvc3MgdGhlIGNhbGwgdG8gYHNl
bmRfZGF0YSgpYCwgd2hpbGUgdGhlIHVuZGVybHlpbmcgYHNiaV9lY2FsbCgpYCBpcyBzeW5jaHJv
bm91cw0KYW5kIGRvZXMgbm90IHJldHVybiB1bnRpbCB0aGUgVEVFIGNhbGwgY29tcGxldGVzLg0K
DQpTbywgaWYgdHdvIGhhcnRzIHNoYXJlZCB0aGUgc2FtZSBjaGFubmVsLCBhIGhhcnQgZXhlY3V0
aW5nIGEgbG9uZy1ydW5uaW5nIFRFRSBvcGVyYXRpb24NCndvdWxkIGhvbGQgdGhhdCBjaGFubmVs
J3MgbG9jayBmb3IgdGhlIGR1cmF0aW9uIG9mIHRoZSBjYWxsLCBhbmQgYW5vdGhlciBoYXJ0DQp0
cnlpbmcgdG8gZW5xdWV1ZSBvbiB0aGUgc2FtZSBjaGFubmVsIHdvdWxkIHNwaW4gd2FpdGluZyBm
b3IgaXQuDQoNClVzaW5nIHBlci1oYXJ0IGNoYW5uZWxzIGF2b2lkcyB0aGF0IGNyb3NzLWhhcnQg
Y29udGVudGlvbi4gSSBhZ3JlZSB0aGF0IHRoaXMgbWF5DQpub3QgYmUgdGhlIHJpZ2h0IGxheWVy
IGluIHdoaWNoIHRvIGFkZHJlc3MgdGhlIGlzc3VlLiBJIGRpZCBub3QgcHVsbCBpdCB0byB0aGUg
ZGlzY3Vzc2lvbiBpbiB0byB0aGlzIFJGQy4NCkknbSBoYXBweSB0byB1c2Ugc2luZ2xlIGNoYW5u
ZWwgZm9yIG5vdyBhbmQgZm9sbG93IHVwIG9uIGl0IHNlcGFyYXRlbHkgaWYgdXNlZnVsLg0KDQo+
IA0KPiBBbHNvLCBmb3IgdGhpcyBiaW5kaW5nIHJlZmVyZXJyaW5nIHRvIG9ubHkgbWFpbGJveCBj
aGFubmVsIGlzDQo+IHN1ZmZpY2llbnQuIFRoZSB1bmRlcmx5aW5nDQo+IG1lY2hhbmlzbSB0byBz
ZW5kIFJQTUkgbWVzc2FnZXMgaXMgYWJzdHJhY3RlZCBhd2F5IGJ5IHRoZSBtYWlsYm94IGNvbnRy
b2xsZXINCj4gZHJpdmVyLg0KDQpBY2suDQoNCkJlc3QgcmVnYXJkcywNCkFtaXINCg0KPiANCj4+
ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArICAgIGRlc2Ny
aXB0aW9uOg0KPj4gKyAgICAgIEF2YWlsYWJpbGl0eSBkb29yYmVsbCByYWlzZWQgYnkgT1AtVEVF
IHRvIHNpZ25hbCBhc3luY2hyb25vdXMNCj4+ICsgICAgICBub3RpZmljYXRpb25zIG92ZXIgdGhl
IFJQTUkgVEVFIHNpZ25hbCBidXMuIE9wdGlvbmFsOyB3aGVuIGFic2VudA0KPj4gKyAgICAgIGFz
eW5jaHJvbm91cyBub3RpZmljYXRpb24gaXMgZGlzYWJsZWQuDQo+PiArDQo+PiArcmVxdWlyZWQ6
DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gbWJveGVzDQo+PiArDQo+PiArYWRkaXRpb25h
bFByb3BlcnRpZXM6IGZhbHNlDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsg
ICAgdGVlIHsNCj4+ICsgICAgICAgIGNvbXBhdGlibGUgPSAicmlzY3YscnBtaS1tcHh5LXRlZSI7
DQo+IA0KPiBUaGlzIG11c3QgYmUgInJpc2N2LHJwbWktdGVlIiBiYXNlZCBvbiBhYm92ZSBjb21t
ZW50cy4NCj4gDQo+PiArICAgICAgICBtYm94ZXMgPSA8Jm1weHlfbWJveCAweDEwIDB4MD4sIDwm
bXB4eV9tYm94IDB4MTEgMHgwPjsNCj4gDQo+IExpa2UgbWVudGlvbmVkIGFib3ZlLCBvbmx5IG9u
ZSBtYWlsYm94IGNoYW5uZWwgaXMgc3VmZmljaWVudC4NCj4gDQo+PiArICAgIH07DQo+PiArLi4u
DQo+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4gaW5kZXggMjA3
YTZlMmRiNzBjLi43ZDBlNTUwMDg1YjIgMTAwNjQ0DQo+PiAtLS0gYS9NQUlOVEFJTkVSUw0KPj4g
KysrIGIvTUFJTlRBSU5FUlMNCj4+IEBAIC0yMDU3Nyw2ICsyMDU3Nyw3IEBAIE06ICAgICAgSmVu
cyBXaWtsYW5kZXIgPGplbnN3aUBrZXJuZWwub3JnPg0KPj4gIEw6ICAgICBvcC10ZWVAbGlzdHMu
dHJ1c3RlZGZpcm13YXJlLm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMpDQo+PiAg
UzogICAgIE1haW50YWluZWQNCj4+ICBGOiAgICAgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9z
eXNmcy1idXMtb3B0ZWUtZGV2aWNlcw0KPj4gK0Y6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdGVlL3Jpc2N2LHJwbWktbXB4eS10ZWUueWFtbA0KPj4gIEY6ICAgICBkcml2
ZXJzL3RlZS9vcHRlZS8NCj4+DQo+PiAgT1AtVEVFIFJBTkRPTSBOVU1CRVIgR0VORVJBVE9SIChS
TkcpIERSSVZFUg0KPj4NCj4+IC0tDQo+PiAyLjM0LjENCj4+DQo+IA0KPiBSZWdhcmRzLA0KPiBB
bnVwDQoNCg==
