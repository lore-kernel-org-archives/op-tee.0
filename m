Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1529CA0EEB
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 08:02:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 027814FC58
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 08:02:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=TPUuXH26;
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 16D7542D3C
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 12:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd9OwILDGVARQt1QTR+ax/s4TW2aw2rELbuR2RGk5sURsyUj2DrrV14GxAoBa2jhy5XYWv3sbps5Ped4C2AUOmT6AV8Cl1S10zLjoLMKgxCU8I4BbuYZeTS3fOEocey7ZlmTzBAIB+WRdBOcWygrrYenEOo/ifbrk0jt7fvWUReR33LPErMdiMGKDD5nVEdG1T1xyy4YMp7GeCESSEWHGdNpxU0n944JKTFPWLP3HLCvQ/1Le00CU/fs2+a1gEVffVzmryI78D4E1lcEmNsYoMWGmTn4BlsU4Ya1Cj2HxcnalzHCUXFJV9uAJk31CwF5BP89jqGykouDqw69r4Hx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgIuMMI+g7uOUwJfB4xvvNvAnry9KbVWDpi0Ylmu4Ww=;
 b=T+bGoS4Uv55J/Cyvn5ZZaQqKIE5Tfa2u7RttvonPSB6W2FycVwFbNVIJRcAx+tpAtJGT0+6rQU5ilLXAeil8X6EocSnNo/9T3MoRfqlEj7UDwPxsOpQ4iyGDLmv13dLjxXbLggRZC08tFYty3kWeJIHELvTDaPFRIdvZ1CVoODIgP6qPouH+ifXiji/VevBYKL0kBf4V3uRv7HJq3wrlVvnUK89GWPE5MIWWB+vfe/jbF5Nuryym6JuekUMlQMIqn2ghJyw97CZNDSLQGLHj4xxQ7veXf8ZdjJEFuwcY6LtjRCJ7qjnYz+G343bqmwh3GwrMDsyMEU70LsKF1yvajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgIuMMI+g7uOUwJfB4xvvNvAnry9KbVWDpi0Ylmu4Ww=;
 b=TPUuXH26eR4/GFA+hWfeWhC2dD7B0XV+JGCrHg69rLoKber4NRiz1Z0g04W1j1u7pJcQ+5qOlGLeH4OWp/7DvEL8ol4Buk7KNuKtY1tJz6HT3AI/KG+qeZL3L39Eu8QDdA2jJdQck4CLrKLO23v6dEeZJZT7808LoGouPOIAaxc=
Received: from AS4PR02MB10357.eurprd02.prod.outlook.com
 (2603:10a6:20b:4f3::21) by DB9PR02MB7243.eurprd02.prod.outlook.com
 (2603:10a6:10:25e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 12:39:21 +0000
Received: from AS4PR02MB10357.eurprd02.prod.outlook.com
 ([fe80::ed21:4e39:7d9f:e3da]) by AS4PR02MB10357.eurprd02.prod.outlook.com
 ([fe80::ed21:4e39:7d9f:e3da%4]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 12:39:21 +0000
From: Lars Persson <Lars.Persson@axis.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, Stauffer Thomas MTANA
	<Thomas.Stauffer@mt.com>, Sumit Garg <sumit.garg@kernel.org>
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
Thread-Topic: rcu_preempt detected stalls on CPUs/tasks
Thread-Index: AQHcBS4K3oYzgDiSm0e8XPckcFJ7qbRre5yAgAAXflM=
Date: Wed, 20 Aug 2025 12:39:20 +0000
Message-ID: 
 <AS4PR02MB10357C57036D58BA7E1878D1AF233A@AS4PR02MB10357.eurprd02.prod.outlook.com>
References: 
 <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
In-Reply-To: 
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR02MB10357:EE_|DB9PR02MB7243:EE_
x-ms-office365-filtering-correlation-id: ee64cfd1-266d-4156-952a-08dddfe69613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|8096899003|7053199007|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d2ZhODNXWGtueVdDZVE1WnNET0NrQi8xRVM4THQ4eU1tb1o3bHZoTHdzVGor?=
 =?utf-8?B?R2J1UjFEVmxIWUtsY0pvNHN1QStoYktUR2JCWUFwL2pjSWNiakorME1iNjEy?=
 =?utf-8?B?V2VQSE0ybzVPcWpoY2pXdGdiTlpzZUF6dVk3aHNjWVQ1OC9LeUs0RE13R241?=
 =?utf-8?B?OFdJR0l3RmI2QUJPMnVrMzdVWVZlVElkaFpOeGNXbXRxMklCb2VvdmUyZFhB?=
 =?utf-8?B?STZ2Q3lwbEhUbDN6b0xUQy9KbVhTMytudkpyYmpPNURkVHA0bmo0djhmT3JF?=
 =?utf-8?B?ZUpOeFpkdkNucGxCa281NEkzR1cvOFJ1MlBQN21ZdG9HeWVoZjhZRmhXcHpn?=
 =?utf-8?B?c0xlZytDRmdWMmJmVisxd3V6OWZYNHZxdWpCMi9PMjFORmxxMHJSMHRaR25T?=
 =?utf-8?B?SXhIckVwRHJ4dmVYQzIwTXpyVWRLSnFBWEcrZ3Qxby9FVk9CcXJJclZaN0RL?=
 =?utf-8?B?T3AzNW0yNVZKWm51bE0xZHZJY3JuZ3J5dmFsaUZsY1poekhaV0x2ekhFL0FJ?=
 =?utf-8?B?U0JYcFg1N0I4aXFkVTFidmMvZUh0aWZVTG45bFVIeHp6bEFlV1Y1eXE3Umg2?=
 =?utf-8?B?NlNEemVnczNrTEEvRk5uZzRUNzFUYURhT2lyUnYvQW5GYnpSNE1QRlVyVGdm?=
 =?utf-8?B?dkw1YjM3Z0tQdm84cDgycGl6d1BDWW90RkJkK015YjFIaWROUmpyWWw5dEJO?=
 =?utf-8?B?bWJxMGtHYTh3WkJqZDd6Vmx2TWpFUndwNGVPU2xZYTM5VnA4ZlJDaHlZaWY2?=
 =?utf-8?B?UnZ5LzY2bDJ0ZzIrc21sNW82U0JQaE1DbTlkTlEzRXhsRnNYZmFQLzVHaFRD?=
 =?utf-8?B?eUhtbGZMZUFEc3ZZelBaUUZKTE92NDBBcjlDcHBHUlhXcHNKYnB1Z1ptUXJm?=
 =?utf-8?B?Z0tiendwWG1RaEZTbEd6NzcwUWEwNnhUWFFXbnpHYkZKRG1HM3Q1WmtYTjh6?=
 =?utf-8?B?S1FoWVl6S3JDSlhGeEY2TWRZOUJGUzNrMk1ISnpCaEhlU1hLU2xuWUhzdnll?=
 =?utf-8?B?V1JYMDNqN0E5THNOaTNodmt0eE0wWUNRdSt4S2hsT1pqMWZibXV3MnZ5bmI1?=
 =?utf-8?B?LytFT1ZYQ3MvcHdEa2tZUG12d1E4Sm5LUHhXSklXM0p3OHoxV0VvZEVQRWdx?=
 =?utf-8?B?d2pkSlcxd1Q4d2RCT0tQbVBQVjdtLzlGaGdTSmlBN0xUdSsvZkhPbmhFdnQr?=
 =?utf-8?B?ZWVHVjV6cml1VSthamc4S2R6a1VORjdWWExmZDgrdTRoRHVNZWpTTGVURDVH?=
 =?utf-8?B?WlRoT1c0TENYTFFNRU52a2VLSnA3d3hRVVU4WjJlQ05nbXJiN2RoSlV4bS9l?=
 =?utf-8?B?OXFjdWRLcnZyTzlOQmtFYzF5MTJXc3orak1DN1BjUEl1TDhkazlXbHdOT0VS?=
 =?utf-8?B?djlHeVF1cGRJSXNybTdseEwvb2hmclV6V3lTdzdIWFBPMk00blI4VWt2dWUz?=
 =?utf-8?B?YkRNMlg1Qk1uR0E4Nk9aNU1MV2p3cjBSSjRuZVdBSCtPakV3Y2NmdmFtdy9w?=
 =?utf-8?B?WlJ4QmdOZXdON1hXbzZXbmRHby9yY25ubGlZK3Z5SkZKS21Qa0tkeGNXazhy?=
 =?utf-8?B?WlFpWXpuZUdJNHRZeE03bUg5NHd4dDlOMFh5YkdncjQ4WXNWUGZkdlZ6Mk9r?=
 =?utf-8?B?VzJpcWFSdUpEbE9Ma1o0QlFEOHlPUmVwdUMrM1FOd3M5d2UrOG91LzNnYU9J?=
 =?utf-8?B?M2RGQTBMNFZyMk0zZitDblprSGFVbE9vRUVodzc4TE1FYStMWHBkKzM2dXp4?=
 =?utf-8?B?c3ZxUGU5aVNhSjJyc3JRT0VHYzBiS3JOcUFBTnhyVG1UblZmc0FCQkRvZHdJ?=
 =?utf-8?B?U3MweGp6Ymx6WG11WHlDWWswYXdPRGcvcGtOZkNyQzhPQU1rSUlMZmhkUlNP?=
 =?utf-8?B?RGd3V1VuTUIvZjU5WEVHeHFaMzJnVVZrNFRRODZZWkZHOHZyNDJwV2gzSW5V?=
 =?utf-8?Q?G+dExExTKmc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR02MB10357.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UHd6YWN6M1lOUWo2YTVjZksvMWZhWDNvWm10QkF0eGgxWEIvOGkwRmpOQzBV?=
 =?utf-8?B?b0ppaEpQUlB2Q0M0OHB0RVRTaXRFcURGSmtSY3pPL0RORXZkdFdzTUJyZVBq?=
 =?utf-8?B?VWZoSXJFcUM4TVFqK2dOTk02b0pLRFAzT2V1b2xYRzIwaHI4czQ2K1EzOEIw?=
 =?utf-8?B?eVJsT1VFajhKUkpkc214S3ZLRVFTRldyRWg1V0lTV0M1RXNBK1hEVG0zVFlm?=
 =?utf-8?B?cWs2MUxrVS9XK1QyQXhraVBULzFleEJIY3hQd05GTjdyUEhtLzY5ajZVZ09v?=
 =?utf-8?B?QWhidERwdmVBbFhaQnFsd2xBTm53L3MxVlhxS3hXNlc5WEthOTNGRXFITWZj?=
 =?utf-8?B?cjJ2azZIWGZxMXNWbFA0ekQyOThBT1QxM01PYi9qR05qeURDS0NjeXAzMkox?=
 =?utf-8?B?bitodm1vNG9XZDRPdFZDSHBoZk1WUzlTNmt4NUkvMU5VaG9PaGtHVWlqRHZ1?=
 =?utf-8?B?THJXZE1RZ1ZPbk5Xby9YUUprNnpWSk5ZMlI4YUhnejlTbFZGV1Rpczh0aU85?=
 =?utf-8?B?WkhYL0ZYTGNQSGlVYjI4SGwwL25QNUI5Z3oxTERkWHp1Tjlpb05VR2lYTUlk?=
 =?utf-8?B?UGlFaXQ5cVRXNXBwK0JoQ2l3dHJXNFR0eDYzZ2d1VGJtZ1dpMDlQNk1LbkNK?=
 =?utf-8?B?UlJZVGZUSmZqSTBnbkxWL3ZGUjk4V1lHTzJpeDlhOGVlOCtMeHQxWnlCR1Np?=
 =?utf-8?B?MHBjVTY1L3hZS0pTOHI3UUhsVVpqQVFKd1JielVpUVY0TEF3clJ1NGcyRzMv?=
 =?utf-8?B?SVRRSFRJUldmRjFjWTZJa3JZZTh0OUlRMFpmeDcyTm5TTS93THFtZDB5RzM1?=
 =?utf-8?B?YjhSbDYxclI5dzZmU05QM3BXTHVpcUlhckZsTFRKUWFWVzI3VDZFNTFiN3dU?=
 =?utf-8?B?M0lZOFpHRThwZUFZeHo4ZzhCd1dta3UzV0JSNExtUnNENm9EWnYrMTRUSXhV?=
 =?utf-8?B?VkdVRmZxT2xRR2FjaGFUVEhkbzJRaUR0R2FYL1ZPUUtNa3puTG16MWUrazIv?=
 =?utf-8?B?c3oyZGE3YlZBRGtZbWdxaDhZaGpxTXJETzJUczkvSElRckFNSVVYdVZFZzhH?=
 =?utf-8?B?UHhDcHF0YUJrN1RhWFluNWVZWVhXazlHamdqQlVuSlVhejVkZ1RxMlFSZlZ6?=
 =?utf-8?B?Nm55S2VlUkUrcVc2M2pibTNRZ1J5WGdlc0NOZXlja1BmZCtONkRFcnZ0SWM5?=
 =?utf-8?B?ajVWSktWNEg1bG9icWR0c2RsRW9mL1h3eGFPVEljaENYMEwyZ00rYUtmMFl6?=
 =?utf-8?B?OHRvUEpLNXEweDRGVzRISTJ3dDhwWnVQVjMwNU84KzhqRE5zOVNKa1B5Ujh1?=
 =?utf-8?B?VXN4b3hZKzR5VnczM2ZCRlNrKy80cDJMbE5mbmNFNU9HcENsTmFqb2ZjdUZl?=
 =?utf-8?B?TWVMNjlDVmpzbXMwYzVlTjdFT3oya09kQ2QxVlo5NjBlQ0NQYmFZbTlkbDdR?=
 =?utf-8?B?Vm1oZ0orTGVtVnN2ZHJOR0wwei9QM1B6cHRwREVhOTZZSUZrdExqZjM1MTBz?=
 =?utf-8?B?MTJoUlJyTFg3R3BYTGIydXBoU2RmbWQ5alZJRlFCa0pXRHk4N1JLTDcxS0sr?=
 =?utf-8?B?OEwxMmZhSS9GdlJYVWpLbHpFWkRzWGFsUmk3UnJyOHZLdWR2NDVJeHZnbFMw?=
 =?utf-8?B?Rm9IVUtnV3FHMlBvTFVNQTNkaHpjYVkwQmtTazBBMFp3WUpYSDk5TERvMXoy?=
 =?utf-8?B?aHdjRHJFb0p0Z251ZFZDTlNNSzdRcXFoeUtlMEg1TVNPVTU0OStYZWU3ZWZE?=
 =?utf-8?B?ZHo0dk1RcklOd3NPbHNPeVhRc0I3cHpGT2Y3TE8xdE5aVFhuaHB4bStlQmdW?=
 =?utf-8?B?NVRMZ09admtkQXN2TzI1azVCZE1xckQxUGF2YSs3UmtMY1RJTGp5a2prMXdF?=
 =?utf-8?B?MjlIeGlXMnpKcklsVXdRRnBqcVlEeEI4Q0g5VXpiVlJhSUdJcWRJSGw2QzhF?=
 =?utf-8?B?TUlmZ0NFbDN0NlVEMit2UnRZMGhrWWNwWll0cDhEd0NDaWVTcFgrTlRaeVRj?=
 =?utf-8?B?RDhYOHZ5MFRrMm9xdkxxMGM5K3N1akxOa2U1T1k4SWp6MW1NZGplcnJiZ3px?=
 =?utf-8?B?WVFkNzg2dThCLzdkeFhjcUsyczhWaUkzNncxV0pPMyt2dldpWVVxWDF0RXQ2?=
 =?utf-8?Q?bvpQMFFElomp6ZaYvVEhSJvgK?=
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB10357.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee64cfd1-266d-4156-952a-08dddfe69613
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 12:39:20.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FKf/U6I4Qm3ZP0HNnFvitQoTilggA/kcSkNRZ/gyOkIUOgPMfxCNHRwDBvjUAk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7243
X-Rspamd-Queue-Id: 16D7542D3C
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[axis.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.5:from];
	DNSWL_BLOCKED(0.00)[40.107.159.5:from,2603:10a6:20b:4f3::21:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[axis.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: Lars.Persson@axis.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: ZAT2TRO5PEZ2OR2J2HZEASMNKI7ZX3LZ
X-Message-ID-Hash: ZAT2TRO5PEZ2OR2J2HZEASMNKI7ZX3LZ
X-Mailman-Approved-At: Thu, 21 Aug 2025 08:02:01 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Ferreira Joao MTANA <Joao.Ferreira@mt.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XYLXS4OZBI7IEZH4WHGEAYWC27NMVQ3K/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkNCg0KT25lIHJlYXNvbiBmb3Igbm90IHNlZWluZyB0aGlzIGlzc3VlIG1vcmUgaXMgdGhhdCB0
aGUgTlhQIFNESyBzaGlwcyB3aXRoIHRoZSBOU19USU1FUl9TV0lUQ0g9MSBwYXRjaCByZXZlcnRl
ZC4NCg0KVGhlIGN1cnJlbnQgU0RLIGZvciBleGFtcGxlIGhhcyB0aGlzIGNvbW1pdCAoaXQgd2Fz
IHRoZXJlIGFscmVhZHkgMjAyMCBvbiBvbGRlciBicmFuY2hlcyk6DQpodHRwczovL2dpdGh1Yi5j
b20vbnhwLWlteC9pbXgtYXRmL2NvbW1pdC9jNzNiMDUyYzRkNTdhMTBiOWJmY2Q5MDAyZTg3MzAw
ODhkODU0NTgzDQoNCi9MYXJzDQoNCkZyb206IEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRl
ckBsaW5hcm8ub3JnPg0KRGF0ZTogV2VkbmVzZGF5LCAyMCBBdWd1c3QgMjAyNSBhdCAxMzoxMA0K
VG86IFN0YXVmZmVyIFRob21hcyBNVEFOQSA8VGhvbWFzLlN0YXVmZmVyQG10LmNvbT4sIFN1bWl0
IEdhcmcgPHN1bWl0LmdhcmdAa2VybmVsLm9yZz4NCkNjOiBvcC10ZWVAbGlzdHMudHJ1c3RlZGZp
cm13YXJlLm9yZyA8b3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmc+LCBGZXJyZWlyYSBK
b2FvIE1UQU5BIDxKb2FvLkZlcnJlaXJhQG10LmNvbT4NClN1YmplY3Q6IFJlOiByY3VfcHJlZW1w
dCBkZXRlY3RlZCBzdGFsbHMgb24gQ1BVcy90YXNrcw0KSGkgVGhvbWFzLA0KDQpPbiBNb24sIEF1
ZyA0LCAyMDI1IGF0IDc6MDnigK9QTSBTdGF1ZmZlciBUaG9tYXMgTVRBTkEgdmlhIE9QLVRFRQ0K
PG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnPiB3cm90ZToNCj4NCj4gSGksDQo+DQo+
IEknbSBydW5uaW5nIE9QLVRFRSA0LjUgd2l0aCBQS0NTMTFUQSBhbmQgQVRGIGx0cy12Mi4xMi40
IG9uIGFuIGlNWDhNUC4gV2hlbiBJIGNyZWF0ZSBuZXcgcnNhIDQwOTYgYml0IGtleXBhaXIgd2l0
aCBPUC1URUUsIEkgb2Z0ZW4gZ2V0DQo+DQo+IHJjdV9wcmVlbXB0IGRldGVjdGVkIHN0YWxscyBv
biBDUFVzL3Rhc2tzDQo+DQo+IGZyb20gTGludXggNi42LjkwIChtYWlubGluZSkNCj4NCj4gQWxz
byBQSUQgMCBpcyBzb21ldGltZXMgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDMwIHNlY29uZHMuIFdo
ZW4gSSBjcmVhdGUgYSBSVCB0YXNrIHdpdGggZXZlbiBoaWdoZXIgcHJpb3JpdHksIHRoaXMgcHJv
Y2VzcyBpcyBhbHNvIGJsb2NrZWQgdXAgdG8gMiBzZWNvbmRzLiBGb3IgYSB0ZXN0IEkgZGlzYWJs
ZWQgc2F2aW5nL3Jlc3RvcmluZyB0aGUgTlMgdGltZXIgcmVnaXN0ZXIgaW4gQVRGIChhcm0tdHJ1
c3RlZC1maXJtd2FyZS9saWIvZWwzX3J1bnRpbWUvYWFyY2g2NC9jb250ZXh0X21nbXQuYyksIHRo
aXMgc2VlbXMgdG8gZ2V0IGNvbXBsZXRlbHkgcmlkIG9mIHRoZSBwcm9ibGVtLiBOZWl0aGVyIGNy
ZWF0aW5nIG5vciBzaWduaW5nIGxlYWRzIHRvIGFueSBpc3N1ZSBhbnltb3JlLiBUaGlzIGhhY2sg
bWF5IGxlYWQgdG8gb3RoZXIgcHJvYmxlbXMgSSBkbyBub3QgZnVsbHkgdW5kZXJzdGFuZCB5ZXQu
IEkgImJlbGlldmUiIHRoYXQgYXQgbGVhc3Qgc2luY2UgQVJNdjgsIHRoZSBDUFUgaGF2ZSB0aGVp
ciBvd24gdGltZXJzIGZvciBzZWN1cmUvbm9uLXNlY3VyZSB3b3JsZCwgYnV0IEkgd291bGQgYXNz
dW1lIHRoYXQgQVRGIGltcGxlbWVudHMgdGhpcyBjb3JyZWN0bHkgYWxyZWFkeS4NCg0KSSdtIHN0
YXJ0aW5nIHRvIHN1c3BlY3QgdGhhdCB3ZSdyZSBzZXR0aW5nIE5TX1RJTUVSX1NXSVRDSCB0byAx
IGluDQpzZXJ2aWNlcy9zcGQvb3B0ZWVkL29wdGVlZC5tayBiYXNlZCBvbiBhIG1pc3VuZGVyc3Rh
bmRpbmcuIE9QLVRFRSBjYW4NCnVzZSB0aW1lcnMsIGJ1dCB0aGVuIGl0J3MgdXNpbmcgdGhlIEVM
MyBwaHlzaWNhbCB0aW1lci4gU28gT1AtVEVFDQpzaG91bGQgc3RheSBvZmYgdGhlIEVMMSBwaHlz
aWNhbCB0aW1lci4gU3VtaXQsIHdoYXQncyB5b3VyIHZpZXc/DQoNCj4NCj4gTWF5YmUgSSdtIGNv
bXBsZXRlbHkgd3JvbmcgaGVyZSAoYXNzdW1pbmcgdGhhdCBpdCBjYW5ub3QgYmUgSSdtIHRoZSBm
aXJzdCBwZXJzb24gaGF2aW5nIHRoaXMgaXNzdWUgb24gdGhpcyBwbGF0Zm9ybSkuIEhpbnQgaW4g
YW55IGRpcmVjdGlvbiB3b3VsZCBiZSBoZWxwZnVsLg0KDQpJJ20gc3VycHJpc2VkIHdlIGhhdmVu
J3Qgc2VlbiBtb3JlIG9mIHRoaXMgaXNzdWUuDQoNCkNoZWVycywNCkplbnMNCg0KPg0KPiBSZWdh
cmRzDQo+DQo+IFRob21hcw0KPg0K
