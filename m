Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B456C5B543
	for <op-tee@archiver.kernel.org>; Fri,  6 Jun 2025 02:05:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CDFCC45A35
	for <op-tee@archiver.kernel.org>; Fri,  6 Jun 2025 02:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1749175511;
	bh=24XpH2Z9eYAfocdIgQhPO7Jqiqdi7JpNiPJBPEWj91g=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=CN0qzgmrt/VUC4F1vPZ+Itdt1i/Ks0rr7umYjwaUNXqOgER6xKzZXo5vU2ztbuQx9
	 TPEmQd/RY2ubA7UFI6VwyCkDTWQ2lKrIInGEnKonFt8FtfoJCyTptnipwYynjdKDEO
	 OUn6PGb4mqE6yyHzdIkw4/Om5s2IN7UJGoWrZMRMFxqU+GW+PQKLZnAj6ieuGaIM4L
	 XDfOshiMZtUcLfj52BdFR50PJjzDvEjqlsdzGQL82BjR3ghZuxdl/mbBDeHCfZW0U9
	 AicqBjFHgMhf5/2uF0R9e11g+zQFqsmI6pwlZKKwUa6KAj8VqmUw+yw544Qgx+oHNH
	 6+n42LdzZZfBg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5A0D93EFC3
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Jun 2025 02:04:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NmirKpLm;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555HjPRU002723
	for <op-tee@lists.trustedfirmware.org>; Fri, 6 Jun 2025 02:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z8n+pFlNZDySSEq/wvNmv0SqVWoMdu2RkbWN4lEa+2Y=; b=NmirKpLmsn/HFYdS
	LuPJOp3xBCxN3+zTfSPlBPtxG3Lmh/zGBymA0lQTizPJuvA3sHPp3w2i6cOHA+/r
	LxAa7YHGTPdtKpunmtEmA8pdTViVq5pl4eP1tYtQ9S8nMh51iMwQw4g1wZKQLtIo
	ctfpeXToS8S2E6GIxiU4C2PhrVLQ5u7KKZGMTvYZ4+2JMADFIXiljzDbZ5yXsxED
	0kmKjo00Qn8qGeV5NZWjBFpvmBPDRDL93PotLGmukaMImktaDS0NgZ8wsRPSHkDT
	mqUzb+sqd3g1wxrmIAbNBxAGfYeR8KPynY53+w1c6Bokdf3XHfIslftWoJ/6S2na
	BE/bMw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4737me2kpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 06 Jun 2025 02:04:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3122368d82bso2434289a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Jun 2025 19:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749175489; x=1749780289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8n+pFlNZDySSEq/wvNmv0SqVWoMdu2RkbWN4lEa+2Y=;
        b=iVH3fMQZApSP6htsjDqzFapWnzjs1KbptPgAQ6EprJ1YzjItiBRDPwrMbbme5HVaH9
         hXtHi/2LcYPPrcS9uflTX6oX8ShE23q/Fc/anAdk7g5Q7JLdfn0vasBEHdjlyR415cLX
         pfX4ws47+1/kSz9T48+uSZY4n06F2izI/7Jb/7iL9D6rbGjaQx9NBx8g0PWe4g419eKz
         JOkgFaqFQJ3c5R5imT7AmohcJj+J/7QdpwLB1qYz/kVwR+bkNlnq+I+lWUfR0PrPkUW8
         bYvsTZUtxplVMpEak0wWRabDGw6F2XX7PFHqHiVC8/Ikfh1+SdnTZ9SdSl4ox7cc8KOR
         coAg==
X-Forwarded-Encrypted: i=1; AJvYcCXVmo/icvy12yqdL4UhqOegGKq1JrUawt1XWt9BhEf6YDRr0JW/u9QILjTzD09fSroomMoMmcg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzB79UiZQOv8QplI/F14gKj825Y4gDcL3T2c3OmaIenQZZEOTvF
	ZDEs2Kgl8KnR2CbSRZyOYZ/BRaCGfVdMcDMsrHUp4UAfmIaKZR16T9PZRfXA2UjVyBBTbmwxB4X
	UKdszd0khxyPrIiXvvwcjL29mvna2YDFHsEje9Fa8FGzRGAIRn/T8cQWIK9AXFN/rk1gLJKi2xW
	NDqNFz/Q==
X-Gm-Gg: ASbGnctj/mGYtDnkQEjRSNaXYLiNI/Pe6j3O9QNvjdR66gf+OM/Rjr1vPfJ+cr5M1lj
	2medB6TAUa2WDuesvbglRcolwS8pq5+K+qC9soJjv8bVC7JxhjqI89ItFw6TvRavgcUdysRp2cm
	1vLh+uhaKUowGsna9E5fotfuwxZSyKghnruwHGnSY1kEwvg3n1vz5AD4Rlv/koImURjffu1oewb
	9FCcchidYuur/wuelG7zJMVIdY9dbsPHMlMcv36pMNzkQqzgZLs6ZWS0H5jNMqvyVi4GbqLkDoB
	xZQD/1+mvCQZRQoEfqLwcEVkpLLUG6VbGJwf1DiW8lZ3Riqn5Wx24A==
X-Received: by 2002:a17:90a:d88f:b0:311:ffe8:20e6 with SMTP id 98e67ed59e1d1-313472c4d1cmr2625516a91.3.1749175489120;
        Thu, 05 Jun 2025 19:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/d3L3X/Oqrl4OPWKU+zP4XRJ0N6+Xnnh/TcCJGKHh/RJKZaBy962HcCy8IJJxTe57SMOIdw==
X-Received: by 2002:a17:90a:d88f:b0:311:ffe8:20e6 with SMTP id 98e67ed59e1d1-313472c4d1cmr2625483a91.3.1749175488692;
        Thu, 05 Jun 2025 19:04:48 -0700 (PDT)
Received: from [192.168.0.74] ([1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fdf9a3sm377968a91.40.2025.06.05.19.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 19:04:48 -0700 (PDT)
Message-ID: <47dc6cb4-aaac-4fa3-8550-8f5bcbf96803@oss.qualcomm.com>
Date: Fri, 6 Jun 2025 12:04:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with optee fixing supplicant wait loop
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <11fff295-0e06-4865-9d7d-f8ed2876de87@oss.qualcomm.com>
 <CAHUa44FM9vEpn=3uwim2+tPHAyVn4TVjyRiHxZrWk3o-mpf6SQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44FM9vEpn=3uwim2+tPHAyVn4TVjyRiHxZrWk3o-mpf6SQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 0X6CR6sM2dSRel4SMSXRchBtIV4CQvFR
X-Authority-Analysis: v=2.4 cv=GPQIEvNK c=1 sm=1 tr=0 ts=68424cc2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=JFw2ELqIhdWigi7sc_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: 0X6CR6sM2dSRel4SMSXRchBtIV4CQvFR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAxOSBTYWx0ZWRfXxtXZ1fTMDVqL
 FhG0i+58nM0uDk7mUc5jAOf8WuhWWMhnb4el72VaIY6LH7u1n6rPM4acP9OH2sXrMUeDAJx/JjX
 U6NEWHjrNRzQOz+3Ksz7nWacFQLTbkBTRKvy+KFt4lZaRX5xxwlBj6WWAQUe1iehquM6f8LCHI2
 y7IONz7ZFRknXhR6CCNEEqhorBPgvx/7E+qwXBlhxCzeFzrcBJn+Dr9w1YW2F8mSdVjRh30pMAQ
 oy9/8DWFUXNLWBf6CopX4Cw2z70RvylJU11AxbjSEH78iNf4eKN+vwJVpLHUKdvDuZ5kg+xQN+F
 oPPUu6WFH/y3ngtgPaCVsuevNgYdKwxw4hABgA4iuYhnk9c1E90Ku8Bsby8SssI2WPbjvj4RoR2
 Yr2XPo8uUjx8Zhob2vfcGKZqdnZIIv5WTRrNN8RHCgDUj1LZzQR8Aov1SEpn/zVNjY0NcRzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_08,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060019
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[3];
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
X-Rspamd-Queue-Id: 5A0D93EFC3
Message-ID-Hash: W6DPITHTYSI5CKA66DF2Y2IAL3BB627E
X-Message-ID-Hash: W6DPITHTYSI5CKA66DF2Y2IAL3BB627E
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/W6DPITHTYSI5CKA66DF2Y2IAL3BB627E/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KVGhhbmtzLiBTZW50IGEgcGF0Y2guDQpOb3QgdGVzdGVkLCBqdXN0IHdhbnRl
ZCB0byBjb25maXJtIHlvdSBhcmUgb2sgd2l0aCBpdCA6KS4NCg0KUmVnYXJkcywNCkFtaXINCg0K
T24gNi8yLzIwMjUgMTE6MDcgUE0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiBIaSBBbWlyLA0K
PiANCj4gT24gVGh1LCBNYXkgMjksIDIwMjUgYXQgMTo0N+KAr0FNIEFtaXJyZXphIFphcnJhYmkN
Cj4gPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6DQo+Pg0KPj4gSGkg
SmVucywgU3VtaXQsDQo+Pg0KPj4gVGhlIGZvbGxvd2luZyBjaGFuZ2UgaGFzIHJlY2VudGx5IGJl
ZW4gbWVyZ2VkOiB0ZWU6IG9wdGVlOiBGaXggc3VwcGxpY2FudCB3YWl0IGxvb3ANCj4+IChodHRw
czovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0LzcwYjBkNmIwYTE5OWM1YTNlZTZj
NzJmNWU2MTY4MWVkNmY3NTk2MTIpLg0KPj4NCj4+IFRoaXMgZml4IGFkZHJlc3NlcyB0aGUgaXNz
dWUgd2hlcmUgdGhlIHN1cHBsaWNhbnQgbWF5IHRlcm1pbmF0ZSBiZWZvcmUgdGhlIGNsaWVudCBk
dWUgdG8NCj4+IHRoZSBzaHV0ZG93biBzZXF1ZW5jZSBvciBhIGNyYXNoLiBIb3dldmVyLCBpdCBp
bnRyb2R1Y2VzIGEgcG90ZW50aWFsIG5ldyBpc3N1ZSAtIG5vdyB0aGF0DQo+PiB0aGUgY2xpZW50
IGlzIGtpbGxhYmxlLCB3aGF0IGhhcHBlbnMgaWYgaXQgdGVybWluYXRlcyBiZWZvcmUgdGhlIHN1
cHBsaWNhbnQ/DQo+Pg0KPj4gRHVyaW5nIGNsZWFudXAsIHRoZSBjbGllbnQgd291bGQgcmVtb3Zl
L2ZyZWUgdGhlIHJlcXVlc3QsIHdoaWxlIHRoZSByZXF1ZXN0IHdvdWxkIHN0aWxsDQo+PiBiZSBh
dmFpbGFibGUgaW4gdGhlIHJlcXVlc3QgaWRyIGZvciB0aGUgc3VwcGxpY2FudC4gQWx0aG91Z2gg
SSBoYXZlIG5vdCBiZWVuIGFibGUgdG8NCj4+IHJlcHJvZHVjZSBpdCwgdGhpcyBjb3VsZCB0aGVv
cmV0aWNhbGx5IHJlc3VsdCBpbiBhIGtlcm5lbCBwYWdlIGZhdWx0Lg0KPiANCj4gWW91J3JlIHJp
Z2h0LCBhIHVzZS1hZnRlci1mcmVlIGlzIHBvc3NpYmxlLg0KPiANCj4+DQo+PiBUbyBhZGRyZXNz
IHRoaXMsIHRoZXJlIGFyZSBhIGZldyBvcHRpb25zOg0KPj4gICgxKSBVc2UgcmN1IGFuZCBhY2Nl
c3MgcmVxdWVzdCB1bmRlciBhIHJlYWQgbG9jayBpbiBvcHRlZV9zdXBwX3JlY3YgYW5kIG9wdGVl
X3N1cHBfc2VuZC4NCj4+ICAoMikgUmV1c2Ugc3VwcC0+bXV0ZXgsIGVuc3VyaW5nIHRoYXQgbW9z
dCBvZiB0aGVzZSBmdW5jdGlvbnMgcnVuIHdpdGhpbiB0aGUgbG9jaywNCj4+ICAgICAgZXZlbiB0
aG91Z2ggaXQgbWF5IG5vdCBhbHdheXMgYmUgbmVjZXNzYXJ5Lg0KPj4NCj4+IENvdWxkIHlvdSBj
b25maXJtIHdoZXRoZXIgdGhpcyBiZWhhdmlvciB3YXMgaW50ZW50aW9uYWw/IElmIG5vdCwgSSBh
bSBoYXBweSB0bw0KPj4gcHJlcGFyZSBhIHBhdGNoLiBBZGRpdGlvbmFsbHksIHBsZWFzZSBsZXQg
bWUga25vdyB3aGV0aGVyIHlvdSBwcmVmZXIgc29sdXRpb24NCj4+ICgxKSBvciAoMiksIG9yIGlm
IHlvdSBoYXZlIGFueSBvdGhlciBzdWdnZXN0aW9ucy4NCj4gDQo+IEEgcGF0Y2ggdG8gZml4IHRo
aXMgaXMgd2VsY29tZS4gSSBnZW5lcmFsbHkgcHJlZmVyIGEgbGVzcyBjb21wbGljYXRlZA0KPiBh
bHRlcm5hdGl2ZSwgc28gaWYgcG9zc2libGUsIHBsZWFzZSBhdm9pZCBSQ1UuDQo+IA0KPiBDaGVl
cnMsDQo+IEplbnMNCj4gDQo+Pg0KPj4gVGhhbmsgeW91IGZvciB5b3VyIHRpbWUuDQo+Pg0KPj4g
UmVnYXJkcywNCj4+IEFtaXINCj4+DQo+Pg0KDQo=
