Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3354D2F7FA
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 14:11:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EF1C75008E
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1764943913;
	bh=PS6loR8S9zQqUVjxpUaqTYePXnFokDqyH3Z0AoSUuIE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=YweR0CRwSVsDbLIFNz3Z4clvNWF15SYAlPieRKyKP4paX+qlWAaX9/cgUY7hkkxLg
	 48gdVtE/s0xbekNlvUmIdVCeBSM050pgK0MtpF4nNS/MXMQ3NJnY0bf8h7txTga+Gy
	 ZucQVYic4m/jXdO3/CvzeUfjdgXdbLB5/PslIDCDNSsF3HfEzRwIpNSSkcRzBElTjz
	 opUXaqGh5jrmtYcMzokOswjw1jFO1ABo0pKyu0/dqB/TSeP8hD8wtOA3AHgoD4rjHt
	 JlXlGEIQwmLVUggc44TdIdvGCod2YwDfRsdtjKfuRwZMPMYU8YYkmUnGWXaQN9teU5
	 0/GBtvXBQbssg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 37D66431E4
	for <op-tee@lists.trustedfirmware.org>; Fri,  5 Dec 2025 14:11:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c1S72kir;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=adMJ5kgR;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B58XGSh2516887
	for <op-tee@lists.trustedfirmware.org>; Fri, 5 Dec 2025 14:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QU8RQH9lmiI1HiYYmsKFuuvMvSYQmCzAce1xUwg2TNI=; b=c1S72kirhAvVDQnc
	pRtQKH5eNiROWLzDlffYD2GeRYyv2yPIvTELQ6dweHVudlMDZZOF84A8rvriCM8V
	RqSTUFvAUyP1z9U9SX3uodCNL0biuJneVAhOBZkkrd4b6ATPUGxA71qCGRtF9Vly
	bava4ugsWKNXMX0JtqjTjYp9tGmL/ENdydTR1d50Lj8SQEvlC6evg6HhEL0Ww7AP
	Bu8lotolOnrePXsjoUMi2wwynBccOJzAwpquH/pcNx9POxUGzOy5cn6PNghi6Ihb
	01Ml18FCb6LtCL/3b2gyDwwejRTqexneVpTUk9gsbeGlm13OeROSKQFwwr/Glczf
	522kVQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auj7n2d7b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 14:11:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343823be748so2237197a91.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 06:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764943900; x=1765548700; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QU8RQH9lmiI1HiYYmsKFuuvMvSYQmCzAce1xUwg2TNI=;
        b=adMJ5kgRyxgETJ9ChaPo0Tc2pjtaiS2ptQiL/qGylt3ACWIYVVPOT6fueqQFs7iltp
         qCIsQlm33+qMx8VeNICavF4b8tRNM+E5tDyf3Qew/UBhdPY6/jd3860gtms/PNNWcjrA
         Lb33NP+GRwQM4n8V3bj4kRjF2PkTT7St8/gYz9/X+aL9C3woQGx17W4oPUoZBY3Q5DW7
         Sgc4MgUTtIAVsjTLOQQEbz9wxsj4z6fKIum4VZNAsLfoyOZkZrEjViW46eQ5HRodHNZT
         C2JOSuSMHX5BYZoomQD8r9FWPTrREDGOtkLnhfU/Gx7GhvT0ImjCLASKVWMc/OPxndmK
         pD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764943900; x=1765548700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QU8RQH9lmiI1HiYYmsKFuuvMvSYQmCzAce1xUwg2TNI=;
        b=b05Q21+pChdWM+HLn1H2YEKW09DBG7pDLN0OVTAnlkmWXS74ZVWdgVqq8F55eiN//m
         CgNmHvJT/KUy+AfJHL/UGfF4cE11/wDkldBNBrI8YbhiQpbMsnGQPmKhXcN7tslLg10W
         K6QYeOZbCEiZTglTBViSTBaEONKxE04OCzbgcnnEI7cpR2IMRE92eQgebhDDXaD4ksvo
         Q5R5FcnoXRH8RA27vBes7ZjPh4IcNZg6loOs3awGi0n4MU+xi4YwW6jk9HSi8NKJYI2S
         IM18Yupo/li8EVKML3ZQjwmle7uQikgqKMMFpv6DyB0T9dkHIc0hn80lDTHY2S0Gm8ru
         5icQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvmBOuruX/hc3+cVl25Uy+/aiTqKAWZkYWVuD1ARSag495xF3hNFvhz8pgzs8F4H0n26AU7eE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzcMj4mMYVEmtJC6fq3+JGTFbS/BNtzgPaiu9riRwHpVMsmgdKv
	hMr4lMzdHHldFuxyNjFKNlpIiYHxqW58+beghMom9YroBFheFmZEqmryqI8e8bc7o+fC2ieWpwy
	Xew9xC8JI59uJukZ+mZGJNjXszbG/QdKo04ce0wJFr9dBqfXevuUqCZMuOca+t8k+ppi8ztxY
X-Gm-Gg: ASbGncvz23g95nhp1LTeJKXfTbAnguuxPdf8xgKHqlOLmGiV9CeT1nq8qbcLlPrhnfk
	icgjrO73Mf8B2qJLg5Qot0IocJqqGiD0ZNADkWLBJAaPN8TxPO9QW8FBM1TSgjgNsxsL2US9iZa
	Pta+MSJ7k/WHFH/HqahTxoQk4TShPP4wEqkTrKyFAGY2Obqx9zlkvmO/g6yUm+rsbR87v3AzF29
	9RXB4IdVXZ/WYne56oFO8pkYrkEUjdIRN8spFwW8oIhdh/jR1m52xquWv462FeMFDv6EoTatgZg
	V2KyVb1RCJFN/MXP5zSsGmIhnZS74xiQAgK7ICVEioSJHcmdWiMNHY8osCCjnkCjvMlJ1tTwydh
	7sstBpGFBUCrsoj+ki58DcxJLh0ld/AyMB5xA+FVO
X-Received: by 2002:a17:90b:4d84:b0:340:7b2e:64cc with SMTP id 98e67ed59e1d1-34947dbdb27mr7161692a91.15.1764943899449;
        Fri, 05 Dec 2025 06:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvIgH31sFc0fv/66qnhnm47zlrTrtPCxOOCtTotJgwqisCeo7VlZObp+bX3VPQSVYZkC+CVQ==
X-Received: by 2002:a17:90b:4d84:b0:340:7b2e:64cc with SMTP id 98e67ed59e1d1-34947dbdb27mr7161643a91.15.1764943898915;
        Fri, 05 Dec 2025 06:11:38 -0800 (PST)
Received: from [192.168.29.116] ([49.37.148.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34912d27040sm4502133a91.5.2025.12.05.06.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 06:11:38 -0800 (PST)
Message-ID: <dbd809fd-9d1e-435c-892b-4757f7edd9b7@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 19:41:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Arnd Bergmann <arnd@arndb.de>, Jens Wiklander
 <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>
References: <20251204101730.1036671-1-arnd@kernel.org>
 <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
 <45b5f14b-3746-4b05-a4b4-dc9f88e89e52@oss.qualcomm.com>
 <9e44024d-a649-49d6-825f-97f2a11e1691@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <9e44024d-a649-49d6-825f-97f2a11e1691@app.fastmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=DOSCIiNb c=1 sm=1 tr=0 ts=6932e81c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=v+kbWGyw1T97G6+vs1uYIQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=-jCBhvvmAAAA:20 a=VwQbUJbxAAAA:8
 a=u8VM9LE-TGAWi8YemUAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: EE4SytoDxm0E3GHHTHVngeADmv3xgPUw
X-Proofpoint-GUID: EE4SytoDxm0E3GHHTHVngeADmv3xgPUw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwMiBTYWx0ZWRfX1UYiWXIH36dd
 lTfDZmjPYrEdS/T9s/+CsFziAgR1J750TUlcwIhm/ewRqwkf0fEZD+I3G/F4L5K7pXZ4ViJM8Q+
 P162xLp4OlhMbMUzsZxpmECqfvUNZ+DFx7ghzFx1WtzrY3mti8SKFqYy32yEzgv7TcsLd1B9u3g
 CUtersH51Ypiyl0YgNywuLl2tQw2GW2mE1Da85twUdltVb1B4MwGY9jsSJC4tMs4w7fwWUDxS4+
 9/xM0C594Um5N/LaUz7gS4s8p8BzjeYrk0ouZ1MNzmcYzokJ5GjRvfJlcMqr9LnL9h1xqF/241x
 lsY0BdGFc41sOebMkr6VpSFOgp2Tnvojt0zoNhQxQvLtjy8YExM5vM3DygwsnTfbdW/t9R/q6DS
 m/8J7nSCYAwIe7mmXmIZerJnzXTkSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050102
X-Spamd-Bar: ------
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 37D66431E4
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[qualcomm.com:dkim,mx0b-0031df01.pphosted.com:helo,mx0b-0031df01.pphosted.com:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: ZMRO46HVXT5IRTMQMLNHXKEAZXRPSFLV
X-Message-ID-Hash: ZMRO46HVXT5IRTMQMLNHXKEAZXRPSFLV
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZMRO46HVXT5IRTMQMLNHXKEAZXRPSFLV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

DQoNCk9uIDEyLzUvMjAyNSA3OjI2IFBNLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiBPbiBGcmks
IERlYyA1LCAyMDI1LCBhdCAxNDo0NSwgSGFyc2hhbCBEZXYgd3JvdGU6DQo+PiBPbiAxMi80LzIw
MjUgNjo1NyBQTSwgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+Pj4gT24gVGh1LCBEZWMgNCwgMjAy
NSBhdCAxMToxN+KAr0FNIEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4gd3JvdGU6DQo+
Pj4NCj4+IFRoZSBvbmx5IHVzZXItc3BhY2UgY2xpZW50IHdoaWNoIGlzIGN1cnJlbnRseSB1c2lu
ZyB0aGlzIEFCSSAoYXMgcGVyIA0KPj4gb3VyIGtub3dsZWRnZSkNCj4+IGlzIHRoZSBsaWJxY29t
dGVlIGxpYnJhcnk6IA0KPj4gaHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcXVpYy10ZWVjL2Jsb2Iv
bWFpbi9saWJxY29tdGVlL3NyYy9saW51eC90ZWUuaCNMNDMyDQo+Pg0KPj4gSWYgSSB1bmRlcnN0
YW5kIEFybmQncyBjb25jZXJuIGNvcnJlY3RseSwgaWYgYSBjb21waWxlciB1c2VkIHRvIGJ1aWxk
IA0KPj4gdGhlIHVzZXItc3BhY2UNCj4+IGNsaWVudCBza2lwcyB0aGUgcGFkZGluZyBmb3IgdGVl
X2lvY3RsX29iamVjdF9pbnZva2VfYXJnLCBpdCBjb3VsZCBsZWFkIA0KPj4gdG8gaXNzdWVzLg0K
Pj4NCj4+IExldCdzIHdhaXQgZm9yIEFtaXIncyB2aWV3IGhlcmUgYXMgd2VsbCwgaG93ZXZlciBJ
IGRvIHRoaW5rIHRoZSANCj4+IGV4cGxpY2l0IHBhZGRpbmcgd291bGQNCj4+IGJlbmVmaXQgaGVy
ZS4NCj4+DQo+IA0KPiBUaGUgcHJvYmxlbSBpcyBtdWNoIG5hcnJvd2VyOiBhcyB0aGUgYW1vdW50
IG9mIHBhZGRpbmcgaXMgZGV0ZXJtaW5lZA0KPiBieSB0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmlj
IEFCSSwga2VybmVsIGFuZCB1c2Vyc3BhY2Ugb24gdGhlIHNhbWUNCj4gYXJjaGl0ZWN0dXJlIGFs
d2F5cyBhZ3JlZSwgYW5kIHNwZWNpZmljYWxseSAzMi1iaXQgQXJtIHVzZXJzcGFjZQ0KPiBhbmQg
NjQtYml0IEFybSB1c2Vyc3BhY2UgKGFhcmNoNjQpIGFsc28gaGF2ZSB0aGUgc2FtZSBydWxlcywg
c28gdGhlcmUNCj4gaXMgbm8gcHJvYmxlbSBvbiBRdWFsY29tbSdzIHBsYXRmb3JtcyBldmVuIHdp
dGggY29tcGF0IDMyLWJpdCB1c2Vyc3BhY2UuDQo+IA0KPiBUaGUgb25seSBhY3R1YWwgQUJJIHBy
b2JsZW0gd291bGQgaGFwcGVuIG9uIDMyLWJpdCB4ODYgKGkzODYpDQo+IHVzZXJzcGFjZSBydW5u
aW5nIG9uIGEgNjQtYml0IHg4NiBrZXJuZWwsIHNpbmNlIGkzODYtbGludXggY29tcGlsZXJzDQo+
IGhhdmUgZGlmZmVyZW50IGFsaWdubWVudCBydWxlcyBmcm9tIG1vc3Qgb3RoZXIgYXJjaGl0ZWN0
dXJlcy4NCj4gDQoNCldlbGwsIGFzIEplbnMgcG9pbnRlZCBvdXQsIHRoZSBURUVfSU9DX09CSkVD
VF9JTlZPS0UgQUJJIHdoaWNoIHN1cHBvcnRzDQpvYmplY3QtYmFzZWQgSVBDIGN1cnJlbnRseSBo
YXMgbm8gYmFjay1lbmQgZHJpdmVycyB0aGF0IGF0dGVtcHQgdG8gY29tbXVuaWNhdGUNCndpdGgg
YSBURUUgcnVubmluZyBvbiB4ODYgYW5kIGltcGxlbWVudGluZyB0aGVpciBlbmQgb2YgdGhlIG9i
amVjdC1JUEMgcHJvdG9jb2wNCmluIHRoZSBmaXJtd2FyZS4gU28gdGhpcyBvYnZpb3VzbHkgd29u
J3QgYmUgYW4gaW1tZWRpYXRlIGlzc3VlLg0KDQpCdXQgYXMgeW91IHBvaW50ZWQgb3V0LCB0aGUg
aXNzdWUgd291bGQgcG9wIHVwIGlmIHNvbWVvbmUgb24geDg2IGRlY2lkZXMgdG8gaW1wbGVtZW50
DQppdCBhdCBzb21lIHBvaW50IGluIHRoZSBmYXIgYXdheSBmdXR1cmUuDQoNCkkgZG8gbm90IHNl
ZSBhbnkgaGFybSB0aGlzIHBhdGNoIHdvdWxkIGRvIGZvciBvdXIgZXhpc3RpbmcgaW1wbGVtZW50
YXRpb24sIHdlJ2xsDQpqdXN0IHVwZGF0ZSBvdXIgdXNlci1zcGFjZSBsaWJyYXJ5IEFCSSBpbi1s
aW5lIHdpdGggdGhpcy4NCg0KVGhhbmtzLA0KSGFyc2hhbA0KDQo+ICAgICAgICAgQXJuZA0KDQo=
