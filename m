Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ABF10BA452
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 09:02:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5E7E843E3E
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 09:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774602138;
	bh=RzydvDc15AtV6wa3fBxVrLi5cwuktB9QCjZxUL3yeg4=;
	h=To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=58N5SRwKoyZLMJP/aPUuxFgJF0GiZt3yhlxyZs0ilz30QgrQkJ6QcHDj73Ja+6oRj
	 PozjTue3QRaecfINorP8tUPdWi1Gvefn8uygySy5Wm/oZ1V9VThLctl3DJ5fwUJRwP
	 bap6igDN4T98LM1A5bSMyL6D9GVW1Mp3QkYDHKdDBZeI0O5HHdb5/yf5NgmJVv82uz
	 YCTLde3Pk7bO8OiogmeCvVAqukcQwz/+frac9XDCysrw7YmTEfkU4/0V9M35nAYKjV
	 /qybJwppUEl7DZfYoJsUg9/5uCcIjKOWYEYh16leA0RVXXUkvi/+x3K25wI9WaE5FA
	 rk5p6jArhgjbA==
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D306F43E3E
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 09:01:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=JOqmTxYe;
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=eXyJ6zUG;
	dkim-atps=neutral
X-UUID: 84b69c3229bb11f1ae70033691e9ac7d-20260327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:To:From; bh=RzydvDc15AtV6wa3fBxVrLi5cwuktB9QCjZxUL3yeg4=;
	b=JOqmTxYe236kLKU/JLYixN1TVGDq/L/Mhp6rPZolvRGcF1oq9CHo3Zpy/+4JMy+y2ZmhKEN3jlZQkeRbHRhbgioYudLUFfaZP2sH3reT2TqwMn4gFkVIFMqzIFR6sVi3y7hHoZLiQrJgBdDrKYPAqqmk6Rrxk5YsPKcPqkWZfzc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:079e63f5-a472-4338-a828-cebb54413fd8,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:2e98383f-41ee-42eb-90dd-1068410e1f48,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|110|111|836|888|898,TC:-5,Conten
	t:0|15|50,EDM:1,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 84b69c3229bb11f1ae70033691e9ac7d-20260327
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shf.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1816577837; Fri, 27 Mar 2026 17:01:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 27 Mar 2026 17:01:17 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 27 Mar 2026 17:01:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHVQWvRwWSU7n5CH3AyBqUlu5baZRJziosFYd1fimzrL70G8lyxSwAIEbc89EVE2tUzCzI5gl6hA9pNy77ITd39ilNUkCgkaX3YURU7wJB42dxGNJJIGu4Oya/KWZR7FZ7RndZ1bcYIekoQpukDKr25IuThlwWE7VpXJXbI39PUkwg5+zzlVQhl7uIVbPUPvwiJic5gJSQA7HdEw2z5vF9ONacQ5EASxbJl/eIcbVk6Xw+WisLoxReY0JJO5nicBwxCS52AvqXbzEuQKoDAp7Uv1wWGzdUTIbWPtnmCJ4eewtCWtwK1KBHIPny+UsbrbctXUu2FjZXjKDEzNh9iMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzydvDc15AtV6wa3fBxVrLi5cwuktB9QCjZxUL3yeg4=;
 b=w8Jx9KxWidJuzTro5ptlO40I4B76DY32vPT4O7y5VRAzDf+jfjCBsbD1ePl5jwpoPuFWgUikWC4zvFBYLxDGY0LmsncmeYKMdH5S9UVDHB/mc2PJrjxKln2La6vifb8XD3idxUhADpd8XR8wK1ZEjWjrEuT/P79xW4QnoovVcC85Np8BZEp2tmnraiGgfKfz28EQavm9Kdkb/Azu8gmCXKh2cHPvXBGYDInoxP8KAB3ALY9XPftkSmiT/ldOnbbN/AqnfPV6+bFt6PaWPfvJn4mTQgzYKx6lvTEgctFpRGO0LHmL/7eXu/jcDgy1FMhVdgT9G1LD/h/EH+Z0nTZmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzydvDc15AtV6wa3fBxVrLi5cwuktB9QCjZxUL3yeg4=;
 b=eXyJ6zUGcVb5H7HqZ+xjnng5XaVvzgPjr+lXbPqj5PuE+ATSjTFGYNjHg2XCu7OLANPZ80E8gJUwGwd9Owkxm6Khhr0llMdopfwgG7cq4NYF5jkJ6IjwG0gvD18lhge4K5APYDjfjzzNIjvhFpjWAKDlyweY9s9YftraIUiIYZE=
Received: from TYPPR03MB9423.apcprd03.prod.outlook.com (2603:1096:405:314::7)
 by TYZPR03MB8101.apcprd03.prod.outlook.com (2603:1096:400:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 09:01:15 +0000
Received: from TYPPR03MB9423.apcprd03.prod.outlook.com
 ([fe80::90f6:c8c9:ee6a:93fb]) by TYPPR03MB9423.apcprd03.prod.outlook.com
 ([fe80::90f6:c8c9:ee6a:93fb%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 09:01:15 +0000
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: Possible race during OP-TEE kernel module device probing
Thread-Topic: Possible race during OP-TEE kernel module device probing
Thread-Index: AQHcvchEft/xaq387kayy5B6QDQksQ==
Date: Fri, 27 Mar 2026 09:01:15 +0000
Message-ID: <d9bb3b058dcd0425b18c77120dae225506b079e2.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR03MB9423:EE_|TYZPR03MB8101:EE_
x-ms-office365-filtering-correlation-id: f3851045-7cd5-41ad-9c20-08de8bdf6703
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: H5IXsTGHiFk1Ir1Fb+I8zsIxRRE5Bmql1+XCZMcpwbXyRYrHiHWkK0hW57NDE8F0WCKYUe0JoLYXkIu4j48bf+4CQ+hWfoXDzVrtmtvewZ8CiPUThkUCmfo7OKtyg2lF7yT9nEahkltrlwkqFwfWSBYEtjE9ggMG/XO25YZHCARX3kuAmD8uDUV4jYMiKsw97O1TbgojDRislNgL05crvOfpeqahnbFlGs3yWscbb74TBUJWDc/6H2dN8kw21yXSrDtYLY9pgBi5dNDqC5ZXHtuE3G1QywkUr3tGlXJoaByBMuUjUnBVycCmJnDFAMoZFoF8UgVql6gA4j6Pr27fEI4HojHU0arF1pu7qMCQN5yKMf6ezTGxEhHlTuq6fnf75R/kQfnjQyB1tA1nJh227XBrS7xaHhlQsIqCT1PnptMr9rYUMdnWXM8ROppIu/+GTEJcOCq1sc5pgsY1kNa7mob7fV5mZYk3fgZ0LqrVZGURDJp9YgTAyts35j+WzmX7ApTH43elp/F9+guTQKuKsf0ZWlz7jyHuflJ5wmC/mkFbjaGR/+bNWRF7vqqBA2Fy8c77Sgdff5dPA4BcGuHEs6NVufKe8UMwyP2Ct1uGlditKAd4ZRRbAZ0omg1mETqoi8a1mWXh2iG5VyX7hc8C6+vZpgRJVE/7SpKJp2R5x9QaxxWCu8JreWNJnfCbvr53tlv8dNAcz8IcNk1IYbMU4GwSBwyDwstwnHZwA+FthMbO/y5Fm1o+SK1lOuyWXbT+QbPfqXZ6qj/2hCUhqAWRpq6+d93oi+L1Rjy1q/az1Po=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYPPR03MB9423.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUVhNjBCU0VycDVFZ091Y3RxYmJicXVheDlZUVkyd3RrRlRoR0lITkk0ei9H?=
 =?utf-8?B?TTVpV0hYWWZXYmtXRkplMGxRTnh4US8yaFIyQ0UrZ1p2WVl6RjloL1lCQnVH?=
 =?utf-8?B?eG83U3IzWXEreVN1d3c3Q0oyUnhuNU9PTmh0dk5EcFowNEU1Z0NtSVN1czky?=
 =?utf-8?B?TFhzNGJQQXJMNFU1VWNNa011OVo1VmpZNnhaemlnMlhjZXEwRGdlRGk4akJK?=
 =?utf-8?B?MjNXMnhoalI4bElnVGZwZXN2eENWdTZ6MEsyWGZ5ZjUzYlQ2ZEo5WVFEV1pR?=
 =?utf-8?B?QzhjRklHSGhYby81VkZONFlXZklZNXoxcUIydmJCeGhlbzNuZnRyU3phQlNP?=
 =?utf-8?B?dTU2UlYwMGpaVkFZeG56blg1ZDRtSDFqTGFtS21TbnV6eXFaVm9TQ2Y1d3Qr?=
 =?utf-8?B?OGNJMGRQOWQ5Y2JlNjNNdjBhTVFGekRsV1hqcEsyWDFxMC9RMTg2ZjdWWXkx?=
 =?utf-8?B?YXlLQU1nNUZoZUFNczM2cVYrSTBFOStQTmpBVmZVemNaNE5OK2NaamRNWDZi?=
 =?utf-8?B?cFBMYmxkeHJUNXpTeWFjNnRTOHU4N2VmdWVEUmEvRDdnWE9VNXJpQmwvbnJW?=
 =?utf-8?B?ckV2cFd3amUxeHhkbkdDNUFPeGNpTnE3eGVlZlJQL2pWNXpVVHVlSkNDNk53?=
 =?utf-8?B?UHFtQ0YrejlxOTR2b09mTDhoZ2NpMW54RWRWU2t3TUtwRklYcXlZdXhvWDBa?=
 =?utf-8?B?R0htQVgrRnpXSVlJeHBQTktTOCtsR2lLMDdLRTNtS1BNYzZYQUJhTXp2bUN5?=
 =?utf-8?B?N0puTkVubWV1QVJsTkdnSng3V0lVdmVwTmw4MEpXeFpoaUNqT0gyQXlSV3JJ?=
 =?utf-8?B?T01pOGdkejgyekhFYTNldHRvSGZrUDYzaG9DUXRNdmZjZ1ZxY2RBWXhDVUs0?=
 =?utf-8?B?eUpSb1l4dDlaWmNUSkNkVGR0alQzQjU4ZFg4bUswMDRIZDJEd2x5QmxxOVBz?=
 =?utf-8?B?V1V4S2VIWHhTZnFLU0pvbENvRjFjYThsZWNjZHI4b1NXUDFiQ1MvblE1Sm0x?=
 =?utf-8?B?SENZNnpPUjlMdWFaVXVYc25rc0F4QXVqTmRuSXV5bzRqci81dm5rZktYbVB5?=
 =?utf-8?B?OHVqTGRDZjhQMFU3aXZnZWRHWjJsRkU4TWw2RFM0b0lkbDEzUFpVRVNsc2F1?=
 =?utf-8?B?ZlppMGtCZFFtRlhBOGV0ZlF1VDMrMmhCSzR2elR0aHZaL1BGRzBqVUgrZG03?=
 =?utf-8?B?VWpLc0gxVDMzTmZMSWtROEpHbk9SRTZYZTI3bDBzOG1KRURjNDYzRm5hL2FL?=
 =?utf-8?B?NWhZN0tHdlpQRVFHQnZpQ2V3V3lDc0pSSmJ3SXYwbHlxOXRKVGpvRFF5dmI5?=
 =?utf-8?B?QTI1NHN4eGk3VnR2SzYxb1h6dU9VSWFvTlgxRU5wQzZVRUxrcmNlRkdXNzl5?=
 =?utf-8?B?aXVma2ZrWEpnYkk0b0tNdDlOczd1Q2ZmakNvTXV5THI0NXpRZlcyL3JSejEw?=
 =?utf-8?B?Z0RTSXBhdDV3RGl3RjVZL3pyMTY2RHBjc2NBdm56TDZ6TkdjVDZNTlhLVnJK?=
 =?utf-8?B?R2dyR3A2MDdlMy8xZE4wR2syY1liaUJLSVcycllKc2ZYVGV6Wm5JbXQ3dGpl?=
 =?utf-8?B?eTMwalVxeXp4TlYyZDNKZ1hFYjZIMXBXM0JLZWNMaWQrbEQxMk5jUzNyTDRE?=
 =?utf-8?B?ZlFNTUVsK0I4cDZibjNzVTBKZ2swYklaZnJLWTBOTzFYb2JrUUR5Z2xnWXFD?=
 =?utf-8?B?NllDRG91NllTbDBaV1A3SUlNeHVWTnMrUkVRSGZYZGVNOUxPUk5RUXFLMU5v?=
 =?utf-8?B?ZDRTOEM1SVpiYXlxWGkzK2QvNTROeVNWdlRvekI5QnpIU21xT3JUbVJIcXc5?=
 =?utf-8?B?UVRKOGErMGM3UGFMZGQvUHRtUUErcFd1RExUM3pjOWxnRUF4ZXRxV08xd3Vq?=
 =?utf-8?B?ZWJGeUhlekRnZGtWV2dPUnNsSlRJdlM2UXhJSHpCS0xRVlZLTHBYcDd4UlBO?=
 =?utf-8?B?WVdadEdrN2YwNjNSblZjS29vQ3B6TzdPK3phNzBvUXR1cllLSllvNmhnYlRV?=
 =?utf-8?B?R1gyK2pIWkV3UkRuMDdFOERTZytmMm9CeEp4VFVTQUdYNUg1QXVTcUZBa1Jh?=
 =?utf-8?B?cHJqQXZjN3YxMU9xbW8zdmJDQ3N0Vk5iRm42dE83SGJqV2Y1QXNoRTN6Zlpm?=
 =?utf-8?B?eldndmJXa3E2enZYaXlBSmlEZmI1TXlLeVlRU0VZZzRrMGZjM0JPQ0FybzR5?=
 =?utf-8?B?QmVzSFRuWkVzMWk2UzhKZElOREplNFczQkpkanBSVEpFN3VFMlhycnk1UWUx?=
 =?utf-8?B?aGJYaC9FQ1pLYU0zQmJLZ2xsNEpIamljZGtUaWltcDVCWEQ1QzN3ZktzSXlL?=
 =?utf-8?B?RjRiZ3dzNWFJcE1uN3N2bVlVbGlVT3R2MHNLTzBNRXBRT3lraGVaQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A58998CBAB40594990E038AB1C9B0309@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nBw6NjTlQA60Qzd4U9828UnzEIuywdUpuffYmPuatMX6yGPlu0kMVH9VH0QuMXxzCz7TSg/ecwDSRS5vs/jG7XAc3YXeZ+lvZSCRCFPl8mtqwyDb3ud01H11QyhVrecFGeU4cnao3aigkq8VUnT3onhd3sF7/iZFl2QRcUviCRchpXkoO6eKtl+NfhgNiKn5qfJQ+N3xrZji+eCGYab+X8qcR9yK76FIg0xiHg9utsk0EQUjctrFKeJc7hkKXrAeMXJo7qI8lp7DDe6StwzJ/duOUUK3q8xpUrBGbzMpVEiS39cmu/P6nREa3YWTVH3yUoDkBBnHk3QRoKA8EfLa8w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR03MB9423.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3851045-7cd5-41ad-9c20-08de8bdf6703
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 09:01:15.5391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqI7RbGyvmAlaA1Wpco3C2tc9pAMY88dzgTtX83uxgdzbNFS8galbyf7+a4OtMc4pQWENUtxxHyEj/wxXpcgKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8101
X-MTK: N
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:60.244.123.128/27];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	RWL_MAILSPIKE_GOOD(-0.10)[60.244.123.138:from];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[mediatek.com:dkim];
	ASN_FAIL(0.00)[138.123.244.60.asn.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:1096:405:314::7:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D306F43E3E
X-Spamd-Bar: ----
Message-ID-Hash: CPFT4NGVR5L4LJ3NR5R6X3GH3VQGNUJF
X-Message-ID-Hash: CPFT4NGVR5L4LJ3NR5R6X3GH3VQGNUJF
X-MailFrom: shf.chen@mediatek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CPFT4NGVR5L4LJ3NR5R6X3GH3VQGNUJF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: =?utf-8?b?U2hmIENoZW4gKOmZs+WwkeeUqykgdmlhIE9QLVRFRQ==?= <op-tee@lists.trustedfirmware.org>
Reply-To: =?utf-8?B?U2hmIENoZW4gKOmZs+WwkeeUqyk=?= <Shf.Chen@mediatek.com>

SGksDQoNCldlIGZvdW5kIGEgcG9zc2libGUgcmFjZSBjb25kaXRpb24gaXNzdWUgZHVyaW5nIE9Q
LVRFRSBrZXJuZWwgZHJpdmVyIHByb2JpbmcgdGhlIGRldmljZS4NCkEgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIGV4Y2VwdGlvbiBjYW4gaGFwcGVuIHdoZW4gYW5vdGhlciBrZXJuZWwgZHJpdmVy
IG9wZW4gT1AtVEVFIGNvbnRleHQNCndpdGggdGVlX2NsaWVudF9vcGVuX2NvbnRleHQoKSB0aGVu
IGRvIGEgU01DIGNhbGwgdG8gT1AtVEVFLg0KQmVsb3cgaXMgdGhlIGV4Y2VwdGlvbjoNCg0KVW5h
YmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwg
YWRkcmVzcyAwMDAwMDAwMDAwMDAwMDAwDQpNZW0gYWJvcnQgaW5mbzoNCsKgIEVTUiA9IDB4MDAw
MDAwMDA5NjAwMDAwNQ0KwqAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBi
aXRzDQrCoCBTRVQgPSAwLCBGblYgPSAwDQrCoCBFQSA9IDAsIFMxUFRXID0gMA0KwqAgRlNDID0g
MHgwNTogbGV2ZWwgMSB0cmFuc2xhdGlvbiBmYXVsdA0KRGF0YSBhYm9ydCBpbmZvOg0KwqAgSVNW
ID0gMCwgSVNTID0gMHgwMDAwMDAwNSwgSVNTMiA9IDB4MDAwMDAwMDANCsKgIENNID0gMCwgV25S
ID0gMCwgVG5EID0gMCwgVGFnQWNjZXNzID0gMA0KwqAgR0NTID0gMCwgT3ZlcmxheSA9IDAsIERp
cnR5Qml0ID0gMCwgWHMgPSAwDQp1c2VyIHBndGFibGU6IDRrIHBhZ2VzLCAzOS1iaXQgVkFzLCBw
Z2RwPTAwMDAwMDAxMDI2YmIwMDANClswMDAwMDAwMDAwMDAwMDAwXSBwZ2Q9MDAwMDAwMDAwMDAw
MDAwMCwgcDRkPTAwMDAwMDAwMDAwMDAwMDAsIHB1ZD0wMDAwMDAwMDAwMDAwMDAwDQpJbnRlcm5h
bCBlcnJvcjogT29wczogMDAwMDAwMDA5NjAwMDAwNSBbIzFdIFBSRUVNUFQgU01QDQpXb3JrcXVl
dWU6IGV2ZW50c191bmJvdW5kIGRlZmVycmVkX3Byb2JlX3dvcmtfZnVuYw0KcHN0YXRlOiAwMzQw
MDAwNSAobnpjdiBkYWlmICtQQU4gLVVBTyArVENPICtESVQgLVNTQlMgQlRZUEU9LS0pDQpwYyA6
IG9wdGVlX2NxX3dhaXRfaW5pdCsweDc4LzB4MTI0IFtvcHRlZV0NCmxyIDogb3B0ZWVfY3Ffd2Fp
dF9pbml0KzB4NjAvMHgxMjQgW29wdGVlXQ0Kc3AgOiBmZmZmZmZjMDgxZmNiN2YwDQp4Mjk6IGZm
ZmZmZmMwODFmY2I3ZjAgeDI4OiAwMDAwMDAwMDAwMDAwMDAwIHgyNzogMDAwMDAwMDAwMDAwMTAw
MA0KeDI2OiBmZmZmZmY4MDgwZTQyYzYwIHgyNTogZmZmZmZmODA4NGQ0NjA0MCB4MjQ6IDAwMDAw
MDAwMDAwMDAwMDANCngyMzogMDAwMDAwMDAwMDAwMDAwMCB4MjI6IGZmZmZmZmMwODFmY2I4YzAg
eDIxOiBmZmZmZmZjMDgxZmNiOGE4DQp4MjA6IDAwMDAwMDAwMDAwMDAwMDAgeDE5OiBmZmZmZmY4
MDgyNzQxNTcwIHgxODogZmZmZmZmZTU3MmY4Y2EwMA0KeDE3OiAwMDAwMDAwMGZhMjg2NTBmIHgx
NjogMDAwMDAwMDBmYTI4NjUwZiB4MTU6IGZmZmZmZjgwODRkNDcwMDANCngxNDogMDAwMDAwMDAw
MDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAwMDAwMDAgeDEyOiAwMDAwMDAwMDg0ZDQ3MDAwDQp4MTE6
IDAwMDAwMDAwMDAwMDAwMDAgeDEwOiAwMDAwMDAwMDMyMDAwMDEyIHg5IDogMDRkNDYwMDAwMDAw
MDAwMQ0KeDggOiBmZmZmZmZjMDgxZmNiOGM4IHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6IDAw
MDAwMDAwMDAwMDAwM2YNCng1IDogZmZmZmZmODNjODY2NDllMCB4NCA6IDAwMDAwMDAwMDAwMDAw
MDggeDMgOiAwMDAwMDAwMDAwMDAwMDAwDQp4MiA6IGZmZmZmZjgwODI3NDE1YTAgeDEgOiAwMDAw
MDAwMDAwMDAwMDAwIHgwIDogZmZmZmZmYzA4MWZjYjhjMA0KQ2FsbCB0cmFjZToNCsKgb3B0ZWVf
Y3Ffd2FpdF9pbml0KzB4NzgvMHgxMjQgW29wdGVlIGY2ZGJjMzVmOGQ5NmFjYmUxZjNjMzI5ZDcy
MDE4MTUxZDc5NjIwOGRdDQrCoG9wdGVlX3NtY19kb19jYWxsX3dpdGhfYXJnKzB4MTJjLzB4OTVj
IFtvcHRlZSBmNmRiYzM1ZjhkOTZhY2JlMWYzYzMyOWQ3MjAxODE1MWQ3OTYyMDhkXQ0KwqBvcHRl
ZV9zaG1fcmVnaXN0ZXIrMHgyODQvMHgzNjAgW29wdGVlIGY2ZGJjMzVmOGQ5NmFjYmUxZjNjMzI5
ZDcyMDE4MTUxZDc5NjIwOGRdDQrCoHJlZ2lzdGVyX3NobV9oZWxwZXIrMHgxYTQvMHgyZjQgW3Rl
ZSBjZGQ4YTBkMDc3ZDk4NGJkYTFmMzFmOWU4OTAzODM2ZWRiZTQ2NjAzXQ0KwqB0ZWVfc2htX3Jl
Z2lzdGVyX2tlcm5lbF9idWYrMHg2MC8weDkwIFt0ZWUgY2RkOGEwZDA3N2Q5ODRiZGExZjMxZjll
ODkwMzgzNmVkYmU0NjYwM10NCsKgY21kcV9zZWNfYWxsb2NhdGVfd3NtKzB4NTgvMHhjNCBbbXRr
X2NtZHFfc2VjX21ib3ggYWM4MmRjOTU4ZTMyMjUyYTIxYzZjZTU1YmI4ODM5ZWJiMjg4Mzg3YV0N
CsKgY21kcV9zZWNfcHJvYmUrMHg4MC8weDRhMCBbbXRrX2NtZHFfc2VjX21ib3ggYWM4MmRjOTU4
ZTMyMjUyYTIxYzZjZTU1YmI4ODM5ZWJiMjg4Mzg3YV0NCg0KV2UgZm91bmQgdGhlIG9wdGVlLT5j
YWxsX3F1ZXVlIGhhc24ndCBiZWVuIGluaXRpYWxpemVkIHdoZW4gb3VyIGRyaXZlciBjYWxsZWQg
T1AtVEVFLA0KYW5kIGl0IG1pZ2h0IGhhdmUgc29tZSBpc3N1ZXMgYWJvdXQgdGhlIGRldmljZSBk
YXRhIHN0cnVjdHVyZSBpbml0aWFsaXplIG9yZGVyIGluDQpvcHRlZV9wcm9iZSgpW2RyaXZlcnMv
dGVlL29wdGVlL3NtY19hYmkuY106DQoNCi0tLQ0KcmMgPSB0ZWVfZGV2aWNlX3JlZ2lzdGVyKG9w
dGVlLT50ZWVkZXYpO8KgIC8vIDwtLS0tLSBURUUgZGV2aWNlIHJlZ2lzdGVyIGhlcmUNCmlmIChy
YykNCsKgwqDCoCBnb3RvIGVycl91bnJlZ19zdXBwX3RlZWRldjsNCg0KcmMgPSB0ZWVfZGV2aWNl
X3JlZ2lzdGVyKG9wdGVlLT5zdXBwX3RlZWRldik7DQppZiAocmMpDQrCoMKgwqAgZ290byBlcnJf
dW5yZWdfc3VwcF90ZWVkZXY7DQoNCm9wdGVlX2NxX2luaXQoJm9wdGVlLT5jYWxsX3F1ZXVlLCB0
aHJlYWRfY291bnQpO8KgIC8vIDwtLS0tLSBTb21lIGRhdGEgc3RydWN0dXJlcyBhcmUgaW5pdGlh
bGl6ZWQgYWZ0ZXJ3YXJkcw0Kb3B0ZWVfc3VwcF9pbml0KCZvcHRlZS0+c3VwcCk7DQpvcHRlZS0+
c21jLm1lbXJlbWFwZWRfc2htID0gbWVtcmVtYXBlZF9zaG07DQpvcHRlZS0+cG9vbCA9IHBvb2w7
DQpvcHRlZV9zaG1fYXJnX2NhY2hlX2luaXQob3B0ZWUsIGFyZ19jYWNoZV9mbGFncyk7DQptdXRl
eF9pbml0KCZvcHRlZS0+cnBtYl9kZXZfbXV0ZXgpOw0KLS0tDQoNCldlIHdhbnQgdG8gYXNrIGlm
IHRoZSBkYXRhIHN0cnVjdHVyZSBpbml0aWFsaXphdGlvbiBzaG91bGQgYmUgZG9uZSBiZWZvcmUg
dGhlIHRlZSBkZXZpY2UgcmVnaXN0cmF0aW9uPw0KDQpCZXN0IHJlZ2FyZHMsDQpTaGFvLUZ1IENo
ZW4NCg0KDQo=
