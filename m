Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA2BCD342C
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 07:26:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7AA054447D
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 07:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1778052386;
	bh=aUKHPlrnJnNotokaxv3k1ZWW+fZDS1iMzWovOktr38Y=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yzIg5hNbHogovUfejqcb2i44t/0Ibrk3SnxmHuX5DUo8VLtluhEteMOKX9sHu4d1m
	 fYWKX3Jf1aDP+qq6PYwYdR42rLiMJ4E3lXjkSrh/GL8yXFoDBPJYZmsjgThLiBstoy
	 g89BIzYFbfKwTPSWY2SJX8i4soVKYvq+QVMlz1P5gWz5t5P1EoZeFOElKgoP/Pgh4V
	 tJZvBS19kHWM5VQ/RReBFeZ5A2Qa9bwgTt9W+dlE3Xdc90FhivJ1x/IkzIrNvwo2eL
	 3UNu6DV35BNwpsiBW2+2DprtFNcCSW7FkmF8tOtXxCS+CtFrKUK6bwIadqT3VGZhMg
	 VKaBPb8ofgbiQ==
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0C9EE43710
	for <op-tee@lists.trustedfirmware.org>; Wed,  6 May 2026 07:26:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=jwX4JUBm;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiBFBEMnKz5w58Gm//SxembEkR2jv6UboOEYRmeNprmGf4q0SyX1+ovwF1WMw129kTJCnV7vWsnVnpAqj9DxKqMpI79199iy1/VWzULXG2Bcdq5x0LZi9vWANVDiYKL5aDWSOLz3mO0k+AIk1HJHlMHED1ZNKl9WRoJFJyZRhwLdWyQwnZGu80Tu35s9K6NWXHChekODZajjBjLai4E0Kg9zvsMeFXR07upfhSv2pw7sxcBIm7Sf+wiUXsZJOVOpvCJ9YZYBR2zJvsmY9fQoHj/5CcisFjz1MT02bix4m6k1a/i/7HfNABg64LBMX5SlOdcQZkIKTVnyY4Vk3rzogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaawbyNF1FXSKe85V4wapgLIJxKWeNKSp9NVLM5sjaE=;
 b=Ii8O14Jdae3djLidAnbHT+W9YyeHNbxialKwtOEutWcsqFYYNo4Lz2CP7qFblKwTU9opVNumqsFqtFxplOzdVQr1AEnnZanB3FeJ5UbOZNkA28vpciCRNgSYZpwqy/DjG8EPY/LYcWen331Xa2DlGgAWF4eoQqnBgOjJLKFW3FU23J0UySMa8QQXW8bIZkspOggombE+WHjXiIUO7gEV2OSnTmM1csBGrTTJItoPAZkdzyhSFjtDhfBg2zfi09deTUcNWYv4lKCKT2+H87i8ql+KPP3YE9alOPqLKQabFbgV5IwZFZ1fwHjA+Z/H4sDcbeqaxppSga6osMwuh6TKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaawbyNF1FXSKe85V4wapgLIJxKWeNKSp9NVLM5sjaE=;
 b=jwX4JUBmLCqS9Rk6jh5SytOo4mWh1RIAilEbGpP68sY2dlgFiSLqMqnX2Htkdt4mXY0p5/CppNlYZRIg/M0qRoB1nYlDo8xwxEAes3BKC6sMospZGMApwXof3tF3XHKYTfO293P4FNhPSUcOMY3E7ZMw1TrxzvncRyyyku+EPBedRELUGKhjg42YaWCteqy5HyXDKCYrrMpvRgLPugtcFBFBcsn3hFwzJkBUJ+RVNoRjtUSxjSh3BAMCosJsPdRf1ecMmVZhX2d5GmEKsK52jin1X5py0/9B5OsxYNWuW5gIznjJeSqF04fY4ZKRRMtme8BLHee8DCvcOU6+IRbG5g==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:26:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 07:26:15 +0000
Message-ID: <360012c0-ba15-4f64-970f-68db31a787cf@siemens.com>
Date: Wed, 6 May 2026 09:26:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: KLMBG4GEUF
To: =?UTF-8?B?xLBzYSBDb8Wfa3Vu?= <isacskn94@gmail.com>,
 "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
References: <CAPziTZO4gvmUUAKLL69-dhGkBADHYPUQ+FwTv98pCZ1sDJUC=w@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAPziTZO4gvmUUAKLL69-dhGkBADHYPUQ+FwTv98pCZ1sDJUC=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0c2b12-bb5e-49cc-66f8-08deab40c1a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	mmfdINCFoNX92mqPoXog1AGHsM37OnyUjGDaYvgTsZFi9IhfOglpYTC5LV80EaHzLX7EUVO+W327zKv60euCU3TwpVbtbkI858vRQEqmSc5FJBqfKpzTHPZ7BsCxMYJABql6kqak3VJI1E/nUXe1LwiJhDCuOS3sVR5mhZJrel9cLh6IaLobgHtWJBcJzsKBQpzIbYVBXAA3j3KWloyMVO4s8vx8RLKK/U5URA0mqHEd8aqdB0Z1ia8KxEM91/e1uJ4+mPlom9Yslz+wuygEF0ckO9CNV4vU6/hw76ga/1Zr1o/9pbXZ78W+UIbWcnH969XchwR5XdqU/xSVK1PBhKI+tyvpyD7cPe1H4Ge8Iycf27YlKY9MvxEoaeqmcgXCQhLfExomZuzW9QEhzDLlLvo5Hy9C3Z1+OKi6sdGTvBIPe9JQ61mtKBbNfkK0O1mswaPoQ8OYysDiDm3eZZJb5kyxRcpnFcRZLRHeQ+VG9yXaoqTJ6RALE74l2q1QRSAxDrAjJBNL0P5UauWFeyTnIZBOMDaXoib8rtw0QS2HBdmnEhivTnw20bCg3FKka091iHaFnj4Q6X8Yk3xRo+wsBoHMyLYBt0oBypcrtmU4HU9sPkF/tf/Wdlr0xoWbKimHLp/1Die3EpQJNW8lesZD9yE3ExUgdfhesVSswse316NlAaahyGrqJtPQl0u2Km6084FX9plJxtq+ZmFcY8Y44Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2crelZZR2sybE9vTGJjdW0wTlVGbWFsMTU1c1JMdUhZTjlETzJjSWl2a2p6?=
 =?utf-8?B?VHQrdzVTQ2YyVjBwNUN4ejBXS1NWRXlIWDBuSTd5MmN6UTRlbTNxTmtnSjVO?=
 =?utf-8?B?WjBialU2ajVzUjBNUE0yb2h4Nk9JVkhmbmtqTU8xcmdHWXdNWjI1YzdEKy9t?=
 =?utf-8?B?VEtrTi8xWjhLT3ZLaDBJcmN2cTVCQ2MrY1VHSWlWMmFydUJMZm41U2Z5cm9K?=
 =?utf-8?B?UmpUNnAvQTBEWmV2ZVMvYVB1QzRBQ2RHajNQNHJtZENVVm5tbk5qMm1TdmZq?=
 =?utf-8?B?aTRqQi8vZDdWclUwQlNwUnliajVnc1ZwMFdDYzB3RDF6U1lhNW1KNG1kcElI?=
 =?utf-8?B?Vno1RlIyMkFueFhKNG9Wc2dsek9UM2ZycXJHbk1US3VIeWwxVCtUbzRtekha?=
 =?utf-8?B?RWZZa1JqZXEydUN3Ykwxb2ZwSC9Hc0hqcEs3Z2ltSG5Hb1phdVJzYk1GME5k?=
 =?utf-8?B?RWlROWJQMEt1SzJQM0c5OUs0enNtUGEwQm9rR202SGkzRFhDY3IwUC9WM2J6?=
 =?utf-8?B?ajhLZWVGNllPbXhFL3E5QU1OTUhjSXNaUjNyVDVveFFqczFZUEZJREtRbE5z?=
 =?utf-8?B?b08yRFEzSWdSWUxhczJ3ZXRGb0d4cXNjUWJYc0JPdFVzOW1MZGcyVStuRElh?=
 =?utf-8?B?V2lJVGVVdFJKeUwyWDVrV09INWhjOVhjMzZMOHNVd01EKzY2NzVZbTROWklD?=
 =?utf-8?B?QWxWamo3RHpjK3NZYXI2WHNqL2RLdUl2d3VoLzhrUFRaenZobUJPRHNQUlBn?=
 =?utf-8?B?QlBMRWRmRk1kS1pNYWlZN2JKMk1sQlhYUGxEczNiU1phcFlUeG1xMncvNWJ3?=
 =?utf-8?B?MlpRNGY0WHNORjZJN1QzbmJONVpjZTdXKy9kVXR1dGhYcXVDK2p6L2ZBUUxj?=
 =?utf-8?B?T3NlamFaQy9QQ1A2MjVwM3VBS3VXblkwNDdESGxjK20vdFlsbGN6UTh4R1dX?=
 =?utf-8?B?MjJNOFEyMEMrQ25ZOW55OE12NGQzNlNGeWEyS1BDam9rZ3VmRGE4VUYzUVhL?=
 =?utf-8?B?MkZnQWFxeVQrYVhuVmh4eEhvRThLV2JPbnRsd0x1RkloOGpRdG5UdVhJWHhJ?=
 =?utf-8?B?MytPaXJ0UkFCQ1NZSzZ6ZzA5aDNvY05kSTBqaUM3RGtoOUlPOEU2aklhZmM0?=
 =?utf-8?B?Z1NBNDBqd3FCWmhJOXZsN2VKSjVOQS92ak5kczZ2ZjB1djl3N0tRMUYwYm5P?=
 =?utf-8?B?MGFmaWNYMzNicjljcXI3TVRqQ3BIMnk0NHVwZ0hYRTIweGxBN0pVNWhJUlV5?=
 =?utf-8?B?L29qbXBSVStjTzVwcUMwMC9OY3B2UERwS2pxU1lJSmtrTitFTUNtYnBpOFpn?=
 =?utf-8?B?M0hNRlRYL2taSkRPQWliWkxidHdub1ZqMDdvOFVjM2dic3dlbFFIaFJSaFBk?=
 =?utf-8?B?NVJsdWdSbTNaNnV1OHU1OG0xQUJSNlZsSHRnRDJ5UTBlZXBDRXZtZmVwTTJE?=
 =?utf-8?B?clZTdHk0VTh4TkpoQnQxQ1lsSnNKeXF1V2pONkkvUmNrUU5kZFdHbG1DaUZh?=
 =?utf-8?B?a0lyRmFJWjBtNGtQeE5MMkU2QklmcFlRRXREUGlNRGNoaWoyVGhtUUM0R3Bm?=
 =?utf-8?B?a0JIKzNXRFZVM00wdTh1cGNqY0FnSFJZOVkyb1VFdVlaTnNJNG43dlQyTWhH?=
 =?utf-8?B?b085SXBqWEp5LzdBYWFjZWFzOFgyQWU1S2VyS1dORGtCc01kZ3h3bGZlVTVF?=
 =?utf-8?B?NzZtMDQvOWFwMWVWVGNJN0I2NkplSzV6QjZuUWdQZU5KVit5U1JTM01JaDNi?=
 =?utf-8?B?bnk4TFRVQXBCaUM4ODBaWTlIbTVpblpFM0RYOW1kaDlSQ0FzcXNEN2FXZ2wx?=
 =?utf-8?B?NGhwWXYzaUpvR2NRZGdMZnY5VkYwMTdEMHV1NEs5NElFeCt5djZJZ3ZlUXRN?=
 =?utf-8?B?dFpxaGw4WnEvRW9VM01lcG40S1pEV0l3aFh3QkU4d1JHckcvZGhXTHVSYTNp?=
 =?utf-8?B?SFpVdnZBT3FOOHV3K1dISFBHTlRKUDc0cWZGNGhFRWVNU2p2YkE4TXhRT25L?=
 =?utf-8?B?ZnloN2JPMG12MzRFOGhTS0ZKZS9LT3oydnJ4WTQ2YVFUZTB0cUNvSmpEU2g2?=
 =?utf-8?B?akJZQ1B3R1M1ZTJPdmRGZVJkOW9QM2xYQjRpVFp0YUtJVzdyV2hpMmt4L2pa?=
 =?utf-8?B?cnVFTGpOWUxnRkFzbTI3dXdwcWovSllTZHNRTmh0MGtEZlVhdmpRWk4ySmRO?=
 =?utf-8?B?MC9CdzUyVXk5RVgrM3lkMWg5RjdpYUxFb291M0Rldnd0TkkwK1dvcEREY0ha?=
 =?utf-8?B?d1ZxM3NZa2FEclFRa1hWMHZpd2lXaWRxRmR6eUhTeC9lTWRIL3JzcGExT3ZE?=
 =?utf-8?B?WTAyTE9XNE9VbFdRYU1yMThySmkwMHVQMVRwVm1vZmMvdHZHQjZUUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0c2b12-bb5e-49cc-66f8-08deab40c1a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:26:15.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWLlK1rNM7Tz8LWULXBWvs4XAw2dfY/lfvmPt1Y0+Rq1L/OKuOG9bZbsYjx5Q8amhIMQfempDvZqAFmFzHemHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.77 / 15.00];
	BAYES_HAM(-2.52)[97.85%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	SUBJ_ALL_CAPS(0.75)[10];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.66.63:from];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.66.63:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:588::19:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0C9EE43710
X-Spamd-Bar: -----
Message-ID-Hash: LGTHDZWXZLENKFTRRHGJCL3VOOI3DOYB
X-Message-ID-Hash: LGTHDZWXZLENKFTRRHGJCL3VOOI3DOYB
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LGTHDZWXZLENKFTRRHGJCL3VOOI3DOYB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

T24gMDMuMDUuMjYgMTE6MjcsIMSwc2EgQ2/Fn2t1biB3cm90ZToNCj4gSGVsbG8sDQo+IA0KPiBJ
IGFtIHdvcmtpbmcgb24gZW1iZWRkZWQgYXV0b21vdGl2ZSBzeXN0ZW1zIHJlcGFpciBhbmQgaW52
ZXN0aWdhdGluZw0KPiBiZWhhdmlvciBvZiBTYW1zdW5nIGVNTUMgKEtMTUJHNEdFVUYpIGluIHN5
c3RlbXMgdGhhdCBhcHBlYXIgdG8gdXNlIE9QLVRFRQ0KPiBmb3Igc2VjdXJlIHN0b3JhZ2UuDQo+
IA0KPiBSZWFsIHNjZW5hcmlvOg0KPiANCj4gICAgLSBUd28gaWRlbnRpY2FsIGRldmljZXMgKHNh
bWUgaGFyZHdhcmUpDQo+ICAgIC0gT25lIHdvcmtpbmcsIG9uZSBub3QgYm9vdGluZw0KPiAgICAt
IEZ1bGwgZU1NQyBkdW1wIHRha2VuIGZyb20gd29ya2luZyBkZXZpY2U6DQo+ICAgICAgIC0gVVNF
Ug0KPiAgICAgICAtIEJPT1QxIC8gQk9PVDINCj4gICAgICAgLSBFWFRfQ1NEDQo+ICAgICAgIC0g
UlBNQiAocmVwb3J0ZWQgcmVhZGFibGUsIGJ1dCBjb250ZW50IGFwcGVhcnMgZW1wdHkgb3Igbm90
IHVzYWJsZSkNCj4gDQo+IFRlc3RzOg0KPiANCj4gICAgLSBXcml0aW5nIGZ1bGwgZHVtcCB0byBh
bm90aGVyIGRldmljZSDihpIgbm8gYm9vdA0KPiAgICAtIFN3YXBwaW5nIGVNTUMgYmV0d2VlbiBi
b2FyZHMg4oaSIGJvdGggZmFpbA0KPiAgICAtIFdyaXRpbmcgb25seSBVU0VSIOKGkiBubyBjaGFu
Z2UNCj4gDQo+IEZyb20gb2JzZXJ2YXRpb25zOg0KPiANCj4gICAgLSBSUE1CIGFwcGVhcnMgbm9u
LWNsb25hYmxlDQo+ICAgIC0gU2VjdXJlIHN0b3JhZ2UgbGlrZWx5IGJvdW5kIHRvIGhhcmR3YXJl
DQo+ICAgIC0gQm9vdCBzZWVtcyBkZXBlbmRlbnQgb24gdGhpcyBiaW5kaW5nDQo+IA0KPiBRdWVz
dGlvbnM6DQo+IA0KPiAgICAxLiBJbiBPUC1URUUsIGlzIFJQTUIgYWx3YXlzIHRpZWQgdG8gYSBo
YXJkd2FyZSB1bmlxdWUga2V5IChIVUspPw0KPiAgICAyLiBJcyBpdCBleHBlY3RlZCB0aGF0IFJQ
TUIgY29udGVudCBjYW5ub3QgYmUgcmV1c2VkIGFjcm9zcyBpZGVudGljYWwNCj4gICAgZGV2aWNl
cz8NCj4gICAgMy4gRG9lcyBPUC1URUUgZW5mb3JjZSBzZWN1cmUgc3RvcmFnZSBiaW5kaW5nIGlu
IGEgd2F5IHRoYXQgcHJldmVudHMNCj4gICAgY2xvbmluZz8NCj4gICAgNC4gSW4gY2FzZSBvZiBk
YW1hZ2VkIGVNTUMsIGlzIHRoZXJlIGFueSBzdXBwb3J0ZWQgd2F5IHRvIHJlaW5pdGlhbGl6ZQ0K
PiAgICBvciByZWNvdmVyIHNlY3VyZSBzdG9yYWdlPw0KPiANCj4gSSBhbSBub3QgdHJ5aW5nIHRv
IGJ5cGFzcyBzZWN1cml0eSwgYnV0IHRvIHVuZGVyc3RhbmQgdGhlIGFyY2hpdGVjdHVyYWwNCj4g
bGltaXRhdGlvbiBpbiByZWFsIHJlcGFpciBzY2VuYXJpb3MuDQo+IA0KPiBBbnkgY2xhcmlmaWNh
dGlvbiB3b3VsZCBiZSBoaWdobHkgYXBwcmVjaWF0ZWQuDQoNClRoaXMgYmluZGluZyBvZiB0aGUg
UlBNQiB0byBhIHVuaXF1ZSBrZXkgaXMgaW5kZWVkIGJ5IGRlc2lnbiBhbmQNCnRoZXJlZm9yZSBw
cmV2ZW50cyBzd2FwcGluZyBlTU1DcyBiZXR3ZWVuIGJvYXJkcyBvciByZXBsYWNpbmcgdGhlbSAt
IGF0DQpsZWFzdCB3aXRob3V0IGhhdmluZyBhbSBvZmZpY2lhbCB3YXkgdG8gcmUtZXN0YWJsaXNo
IHRoZSByZWxhdGlvbnNoaXANCmJldHdlZW4gU29DIGFuZCBlTU1DIChzaGFyZWQgc2VjcmV0IGtl
eSkgYW5kIHJlLWRlcGxveSBhbnkgZGF0YSB0aGF0DQpuZWVkcyB0byBiZSBzdG9yZWQgb24gdGhl
IFJQTUIuDQoNCkhvd2V2ZXIsIHRoaXMgb24tYm9hcmRpbmcgcHJvY2VzcyBoYXMgdG8gaGFwcGVu
IGluIGEgc2VjdXJlIGVudmlyb25tZW50DQphbmQgaXMgdGhlcmVmb3JlIG5vcm1hbGx5IHBhcnQg
b2YgdGhlIHByb2R1Y3Rpb24gcHJvY2VzcyBvZiBhIGJvYXJkLiBUaGUNCmNhcGFiaWxpdHkgdG8g
d3JpdGUgdGhlIHNlY3JldCBrZXkgdG8gdGhlIFJQTUIgbWF5IG5vdCBldmVuIGJlIHByZXNlbnQN
CmluIHRoZSBPUC1URUUgdmVyc2lvbiBvbiB5b3VyIGJvYXJkIG9yIGl0IGlzIGdhdGVkIGJ5IGEg
aGFyZHdhcmUgZnVzZQ0Kd2hpY2ggd2FzIGJ1cm5lZCBpbiB0aGUgZmFjdG9yeSBsb25nIGFnby4N
Cg0KQlRXLCBpZiB5b3Ugd2FudCB0byBzdHVkeSB0aGUgbG9naWMgb2YgdGhlIFJQTUIgZnJvbSBh
ICJoYXJkd2FyZSIgUE9WLA0KaXQncyBub3cgZmFpcmx5IGFjY3VyYXRlbHkgZW11bGF0ZWQgaW4g
cmVjZW50IFFFTVUuIFdlIGFsc28gaGF2ZSBhIGRlbW8NCmludGVncmF0aW9uIGF2YWlsYWJsZSBp
biBbMV0uDQoNCkphbg0KDQpbMV0gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1j
b3JlL2lzYXItY2lwLWNvcmUNCg0KLS0gDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5v
bG9naWVzDQpMaW51eCBFeHBlcnQgQ2VudGVyDQo=
