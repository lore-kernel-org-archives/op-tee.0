Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC64F36BAC
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 05:45:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9B26244A33
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 05:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775799929;
	bh=AV0PXoTnBBg3yBbPGnMTY6ehbCdLj7S9XjKubH6Ws9o=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=P4aCAwNvAN/LMB8uB3SGZgzTgQKPVOOI/EicB7bi6YOpJOxgF+y5Vk/XLUosY462U
	 wnNg1GB4XiVn66eL6Bj3DEuNuSqLlsMdCj/FN8Lm6kg6JIqPOxvd0uXrn7XTEy0OR6
	 GzWepuW3poDugVx4ydaXCguSkg8aro+Pi7hWtHp9ueuRLN/OEz87zkYkiKadluVznL
	 pwkJTMy+Xj1/sWJX67SsYWTp8nh45S1alONKnbpB/LGzXp4n+gwS21GRcng6nWLEPT
	 fDyfxrwsxO8vIFuKTtmY/Sklab9jc5OrL+t8OY1yA31OA43pJgzyBzonEN+AWhqTUF
	 0Wb95KQDmNXJw==
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B035143B5C
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Apr 2026 05:45:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=i2H1G+FX;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNQCmjRnXa741FobzBx8Q+0PnjwN+/LhGsyYDb5bhf2gTmPQTnQQhqg34ru20zPoHP+2WUHk3pjW+qEFaI5WwGCZYoj8NEPCHyDJ8u4i0+f8fgdUrmoyjgepTG92PGLkK7vcn8FW4caHXAoVA01nOAb7+XQMbVAjNdCbo3HWMT0M+DzfjgLrZ6K6alLl7jsOoAxK+H70NjqW/N/9SQHxF8zyaxGvTY1KFdiFPUQ7Nl0p/Zi3oeQbaiVusx3qXxv9yrqoFizPXK4tyMMR9p1jAqTOLwc5Ry+erIzfV2ipJTcLMugqzAegQP2UzhEp+TreeQEXqPIGHLdbcFWlao+/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTDlMWigHGJuWrk6Dl1q6OgcgsvF2wPAAoANZdajpLU=;
 b=beVbXl88MzBh/CeCjf3x+z+q/Ci854t25RArXSKT3eH0FPWkwgSSnHqIUDq+QXFSqs2F+h8tVjRrl4MdQztn4HB57OEueqvT9R+o0zxtH+zOBYYKVO5evDdEux8xuLYF8MvHTH/0NN8UCN95IzMLqKoenyls8FvqFU6IFQcxOoSU7sj6gBbucrjwHlr8LoYiRzFvh/72X/pYdV8c5XF3fBPTLg9L0sZ11LyfoVCyNLnr0+0E05fvvo65wQU1L8QhZFrDOtd+WstyIJQtzVYhYrb4Q9aS7yRYhRl5BU2bG3Q+pu40KR5w6ekgpWMWiknt8bnjr+nEkr25/gIppq1ajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTDlMWigHGJuWrk6Dl1q6OgcgsvF2wPAAoANZdajpLU=;
 b=i2H1G+FXqxBhMEOLB81aavbr5dYkj5ODXM6ic8VeE+3pcKTOrhpmEmdx3tfuuiA0vKaeSuSG0C+EMVbWASMBxxsm9OzRduMymkhUTyUviMZ8sCy9OoGXOtRmx9qkIF82pBIUQjB4FNDUXW9Bk/+uzsWkeZs89zCqpGrKMC0BdTg7lUdi28ujjnUlvz5TwnaGemRtwGaRdRvZ9lXJHnjPjMOY1GCftdvnP+xDJOwmF2mpPMUPNDP6zkmqXmwBHRQl6uYVGdx388EgQyVnWBhUjeMypN7LPHUMSocIswiUpIBhThGfMU/wt6eRche8OAvjKhnZbbV/f6g0WZWlqKsLFA==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB5241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 05:45:20 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9745.035; Fri, 10 Apr 2026
 05:45:20 +0000
Message-ID: <4dfd2e07-4627-4682-a8f2-bc13eafa1fe9@siemens.com>
Date: Fri, 10 Apr 2026 07:45:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: PKCS#11 TA needs userland supplicant?
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <020c35af-a58e-47dc-b445-841538e62f88@siemens.com>
 <CAHUa44HNAGSLV9onUmYKm8fbKvYGVBNNqCtWjZcEGXtoEfLwCg@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAHUa44HNAGSLV9onUmYKm8fbKvYGVBNNqCtWjZcEGXtoEfLwCg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec96ff2-08e5-4f8a-13f8-08de96c45a37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	aTM2oGxoMi+t0/VjuDSED6HHrVIOJ0OeD22kmxU862bcW0WJQhqOQgk8TN+gC2fbAJY46bPm2H2RXnmnVchAyq5T/DB4kliyGBbM9JwLQ0nuuH4mjtcnXytqkqRHVotKW3a1iaJIBlYsOAiC00E7DyXa9FdkccPmvIFghcGbmuKNCJL6os7m0VQcU8IhGx93RC9F1TMPWrS1u5oC3ypv5iUnF0v6ONS8w5f3SyLZPKsFZizjUn7kWHTrdf2/IKrnbG/9PzQkrOLyDu5lYfFaEe/pX43qopYQZPD9S+mBP1GPulFRIi6gT0/r6wZmdtUJLMWA2VgKXxHJcdaEmHZ5RImTo9rbMunwnK/d2vPYHYKtUGH0FJVa9W/X70GBB/kaKJw6q2ZP0TqRBO6qfB/xPLTm1JqhGdjpgsPftnhiHwrEoj1WtcQBd71hNgjtJxmso9UuxiNKH4ywmPXWGxvp/U5vR4qROs/2AJZBCq/glsORzpLYl2wVNGArlPvvKnmc5yauxjhfxZ5trvrfU7QPtcwv/vTHHqZtB9Gf6Ya6GZtZ3NlQcp48JJpf/LWYqdWagY20BLkt7HKVDkACUSCBB+8mgUCx0AKOwBSN6wuK2wI7YHnd//u03kMmlbB73UT7kT6ySLZB1gE93a4KYl50CXljyB0EhL4L1dvcPcCsf6FQdvigb9hRvFYQnBepBjWJd8+LB5QWoOaE4XDBhVmFXpj/NSS+mmKTDyQI3nt4n4o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0xSUkZ2ZUNFTWMreGEvNVUxM0ErY1BIU2ZUcDlNVnE4c1J4SGhSS3ZCRkhz?=
 =?utf-8?B?RDlNZXptc1JWeVJHVVpVWlc2b3ZhdmtsY1dpSzdRQXh3NFkzemFsVlV0Z3Ji?=
 =?utf-8?B?R0IvUDIvZ1lGS1Z2N1o2UWptOEtXdC9lRlBvK1NxVm4rYWVOeFdkVnFhcHBI?=
 =?utf-8?B?S0FvZUpGTllHeVQ0bTZzZzAzWXZzdUNIbVUvNXR5VkZ5ZC93b2pqcGtrTFRl?=
 =?utf-8?B?ek5RNEY4Ulp5QzlYVklPZU5lczE2N092Q3dpVHFMbmVEeHVOeUdUVFd3SkJY?=
 =?utf-8?B?Q1hLNmR3TjloWFoyRjUveGVzOW9RMHFYdGF6SVFTUUpvemdjckhNMGVjdlFs?=
 =?utf-8?B?RXJRR2hCM29TUitwRmFmZ0JTKzNseU9EZmJlWHZoU0NaNTBWY2k0bHBqbGsy?=
 =?utf-8?B?L3VmZWZCdkx4cTVSbng3dldGTjJ3SjF3OXpKbk94OTVzRVJyNlU0cURuRHE2?=
 =?utf-8?B?aklMMjNhb1pKREtlSkUyVGhWZ09STDF3eTVEQlVsV2pMNVp6anJ5K1JNS2hr?=
 =?utf-8?B?U3gxMmRqSGFYZkpKckJGWVBmVWtGTVlHbHBwNFR0S1NYWXgrWlBxTm9tcjg3?=
 =?utf-8?B?cVkzbVRDMS9QODlEM1dsWm1acVFYalFDS05BakFEZDJROHdzMG9WR3orSG9E?=
 =?utf-8?B?eWpPQ25xdGxKRTc2K3NsQVFGQUVQaVBUZE42cUdvZnZoQ01WN2h6MU1rUVEx?=
 =?utf-8?B?bG9hUkphalh4elB6UzN4RS94Wm1QdVFlbjU0cm1FK3lWRXhHMnlQT2Y3T0dN?=
 =?utf-8?B?YmdYbXc0d3YzWk52UmtGbHJHM3I2MVJyNW5MYlZsYzk0ZHR3UjVGQTdXNVlK?=
 =?utf-8?B?ZE9oZW83MzFYUjBOZS9OaXoyY0RubXM2Z3VKZzdiN1gzZEtsZHlzbmVkU1Er?=
 =?utf-8?B?MnI4VllhTGdiZ01wMS9YUS9uYWpHWUg5Nk9DdmZBT2ZOb21GcGFTSnEwYW1q?=
 =?utf-8?B?dnIwT1pZQjdyRDhHQzFEQ3RLSS9Kd25pZ01GcFZiZ1QxZnAyQVo5R2NmcFpT?=
 =?utf-8?B?ZGxTMXhkUGNVRWFyaUQ0ekliOWZuUFZkZlVRb2dMbUJzYXlwV0luNkdrMkpq?=
 =?utf-8?B?UC8xdVdOcE1iZDlRYW5NYVM0SnlWdkJPU1RqSnlNZktsSy83a1V0bUNITStV?=
 =?utf-8?B?QWsxcWRVOHdrYkZ6dlBnT0Q4SDBaaUovYkxEVk1OVzNNejhabkpXYWtYVzhh?=
 =?utf-8?B?QVRMaHQ4aUQ0cUpUVWJQYTk1VmE5akFzbWtXOHRqV3NTR2RDRGhDL2ZvanJP?=
 =?utf-8?B?SmVxbzdSNnFkOVV6NHJFK3Y0djBLdGdIczNrZDI1d1ZMS2tOQkkwbXQyam4z?=
 =?utf-8?B?ZHZOVVpiVVM3SXp0MUtwanpmQWJUWVNvbTM0SW9HN0NtUzY3RmczeUN3bFJj?=
 =?utf-8?B?VEdRNGV2OERCdW9GYXQzeVlBTmw3d1A0cm5iUmk0Y0dWT1hhSjV4c2RVcWlT?=
 =?utf-8?B?OGlZdXdvaCtSOEE0SG80dFdUc0huNjFnclNZZVgwSVhRSHlrM1ZEbTBpS05D?=
 =?utf-8?B?NHVoWGZBV1pzNThUUHhmUE1BNlFhRFd2eVJOeUdsNUtMNkszck44eVdza0RC?=
 =?utf-8?B?c0xUdFlnajdURHRtbkoveVNMTWpVRlAvNStsTFJDaXJGV2x0dkw5cEdkb2hH?=
 =?utf-8?B?TXcvUEJmcFdFYWxGVGNrQ3Rzd3lUUTdPUDdXWlczUU1ZWGVhdmFwMEhhSDMy?=
 =?utf-8?B?VVBlNFd6UTlwVW9sM2tLZllyV08yaFEvenVjY1pOekhGTmEvQmptR0xsTXMw?=
 =?utf-8?B?cUMvSGFPZVBSOTNOOVZVMWdTY0w1eDRIaW1MMnd3TmZ0b0JsN052WG55T24y?=
 =?utf-8?B?MEZicXlCRllHcjhlaHlSN241U25SaGtXKzFRTTVTRWJpc3Joak1MT1V1eHNM?=
 =?utf-8?B?bEYvMnRhblRTbGlKblF1ak83OVFRSDYyN0JXTWNzaUxScnBPRFBubzVFRGVT?=
 =?utf-8?B?MVB0L3lKY2N4TTNBdmpZU3FyYkc1YzQwVWhHWGMram93dTdHUjZSVVFNRTM0?=
 =?utf-8?B?NkYyK1piSDliY0gzdy8vM3VIWWhWbWVWSHJPNUhsTjR2M3l2OGNVS1JaVXdZ?=
 =?utf-8?B?RlNWZ1dzUnJPYy9YdjVwMk1uNkZOR29ONnAwQzlNVHVDMTRESVErazAzVXVS?=
 =?utf-8?B?L1hnaFVQNVBjdXFGNnhMcXJlVGZPby9TWFN0Y0dOL0ZWamVFVHl0aWUwOGdx?=
 =?utf-8?B?d0N5Q2lpWmk4aytUbHFOMXNQdFk5SlZZa3QxcmZ1LzZ6blBkcTk2RE5FbXNU?=
 =?utf-8?B?bU5ncnQzeURkVE9ILzhIVlVEYVdvOEV0WjU4V1dLTngxbmdDeGZUZnUrL3JC?=
 =?utf-8?B?ZDlsSEtLR21ZMjZFRWZubktpWnk5ZUlYZzN3ZzZDaDU4OE9ycEF6dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec96ff2-08e5-4f8a-13f8-08de96c45a37
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 05:45:20.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skOcNEX9NEi4KFd2GTdShl6utmlO1gH0Fi6e9EJvfYNtn8Dc9nY7NOF0n2nXV178jra3vvZ4roFfpbTdU3BMTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5241
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.55:from];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.159.55:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B035143B5C
X-Spamd-Bar: -----
Message-ID-Hash: 62EZY56N47RMIDLNPXBFRVUAHV5EQXYQ
X-Message-ID-Hash: 62EZY56N47RMIDLNPXBFRVUAHV5EQXYQ
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/62EZY56N47RMIDLNPXBFRVUAHV5EQXYQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

T24gMTAuMDQuMjYgMDc6MzcsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9u
IFRodSwgQXByIDksIDIwMjYgYXQgNzo0MeKAr1BNIEphbiBLaXN6a2EgdmlhIE9QLVRFRQ0KPiA8
b3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmc+IHdyb3RlOg0KPj4NCj4+IEhpIGFsbCwN
Cj4+DQo+PiB0byBhdm9pZCB0aGF0IEknbSBkZWJ1Z2dpbmcgZnVydGhlciB0aGlzIGVycm9yIEkg
Z2V0IGR1cmluZyBib290IHdpdGgNCj4+IENPTkZJR19SUE1CPXkgaW4gdGhlIGtlcm5lbCBhbmQg
Q0ZHX0lOX1RSRUVfRUFSTFlfVEFTPXBrY3MxMS9mZDAyYzlkYS4uLjoNCj4+DQo+PiBbICAgIDAu
MzU5MzcyXSBtbWNibGswYm9vdDA6IG1tYzA6MDAwMSBRRU1VISEgNC4wMCBNaUINCj4+IFsgICAg
MC4zNjE3NzldIG1tY2JsazBib290MTogbW1jMDowMDAxIFFFTVUhISA0LjAwIE1pQg0KPj4gWyAg
ICAwLjM2Mzc2MV0gbW1jYmxrMHJwbWI6IG1tYzA6MDAwMSBRRU1VISEgMi4wMCBNaUIsIGNoYXJk
ZXYgKDI0ODowKQ0KPj4gRC9UQzo/IDAgdGVlX3RhX2luaXRfc2Vzc2lvbl93aXRoX2NvbnRleHQ6
NTY5IFJlLW9wZW4gdHJ1c3RlZCBzZXJ2aWNlIDcwMTFhNjg4LWRkZGUtNDA1My1hNWE5LTdiM2M0
ZGRmMTNiOA0KPj4gRC9UQzo/IDAgbGVnYWN5X3JwbWJfaW5pdDoxMTQzIFRyeWluZyBsZWdhY3kg
UlBNQiBpbml0DQo+IA0KPiBUaGUgaW4ta2VybmVsIHJvdXRpbmcgZGlkbid0IGluaXRpYWxpemUg
YXMgZXhwZWN0ZWQsIHNvIE9QLVRFRSBpcw0KPiBmYWxsaW5nIGJhY2sgdG8gdGhlIHRlZS1zdXBw
bGljYW50IGJhc2VkIFJQTUIgY29tbXVuaWNhdGlvbi4NCj4gDQo+IA0KPj4gRS9UQzo/IDAgZ2V0
X3JwY19hbGxvY19yZXM6NjQ2IFJQQyBhbGxvY2F0aW9uIGZhaWxlZC4gTm9uLXNlY3VyZSB3b3Js
ZCByZXN1bHQ6IHJldD0weGZmZmYwMDBjIHJldF9vcmlnaW49MHgyDQo+PiBEL1RDOj8gMCB0ZWVf
dGFfaW52b2tlX2NvbW1hbmQ6ODMwIEVycm9yOiBmMDEwMDAwMyBvZiA0DQo+PiBEL1RDOj8gMCB0
ZWVfdGFfY2xvc2Vfc2Vzc2lvbjo0NjkgY3Nlc3MgMHhjMDIxMDkxMCBpZCAxDQo+PiBEL1RDOj8g
MCB0ZWVfdGFfY2xvc2Vfc2Vzc2lvbjo0ODggRGVzdHJveSBzZXNzaW9uDQo+Pg0KPj4gSXMgaXQg
cG9zc2libGUgYXQgYWxsIHRvIHJ1biB0aGUgUEtDUyMxMSBUQSB3aXRob3V0IHVzZXJsYW5kIHRl
ZS0NCj4+IHN1cHBsaWNhbnQ/IEkgdGhvdWdodCBpdCBvbmx5IG5lZWRzIHRoZSBzdXBwbGljYW50
IGZvciBSUE1CLCB0aHVzIHNob3VsZA0KPj4gYmUgZmluZSB3aXRoIHRoZSBpbi1rZXJuZWwgcm91
dGluZyAod2hpY2ggaXMgYWN0aXZlKSwgYnV0IG1heWJlIHRoYXQgaXMNCj4+IG5vdCB0cnVlLg0K
PiANCj4gWWVzLCBJIHRoaW5rIHNvLiBJIGhhdmVuJ3QgdHJpZWQgaXQgbXlzZWxmLCB0aG91Z2gu
IEFueXdheSwgdGhlIGxvZw0KPiB0ZWxscyB0aGF0IE9QLVRFRSBpc24ndCB1c2luZyBpbi1rZXJu
ZWwgcm91dGluZy4gWW91IGNhbiBhbHNvIGNoZWNrDQo+IC9zeXMvY2xhc3MvdGVlL3RlZXByaXYw
L3JwbWJfcm91dGluZ19tb2RlbCB0byBzZWUgd2hhdCB0aGUgZHJpdmVyIGhhcw0KPiBuZWdvdGlh
dGVkLg0KPiANCg0KIyBjYXQgL3N5cy9jbGFzcy90ZWUvdGVlcHJpdjAvcnBtYl9yb3V0aW5nX21v
ZGVsDQprZXJuZWwNCg0KQW5kIGlmIEkgYnVpbGQgb3B0ZWUgYXMgbW9kdWxlIGFuZCBsb2FkIGl0
IGxhdGVyLCB0aGVuIGNhbGwgInBrY3MxLXRvb2wNCi0tbW9kdWxlIC91c3IvbGliL2xpYmNrdGVl
Yy5zby4wIC1JIiwgaXQgYWxzbyB3YWl0cyBmb3IgdXNlcnNwYWNlIHRlZSBoZXJlOg0KDQouLi4N
CkYvVEM6PyAwIHRyYWNlX3N5c2NhbGw6MTQ3IHN5c2NhbGwgIzggKHN5c2NhbGxfY2hlY2tfYWNj
ZXNzX3JpZ2h0cykNCkYvVEM6PyAwIHRyYWNlX3N5c2NhbGw6MTQ3IHN5c2NhbGwgIzQxIChzeXNj
YWxsX3N0b3JhZ2Vfb2JqX29wZW4pDQpEL1RDOj8gMCBsZWdhY3lfcnBtYl9pbml0OjExNDMgVHJ5
aW5nIGxlZ2FjeSBSUE1CIGluaXQNCkkvVEM6IHRocmVhZF9ycGNfYWxsb2MgMCwgYXJnLT5yZXQg
ZmZmZjAwMDANCkkvVEM6IGdldF9ycGNfYWxsb2NfcmVzOiBidCAwIHNpemUgODE5Mg0KDQpKYW4N
Cg0KLS0gDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBFeHBl
cnQgQ2VudGVyDQo=
