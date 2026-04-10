Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD3AE99055
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 08:36:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id ABF2F43EA6
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775810187;
	bh=xSe08BQ1lBMfUmQKftmdF3yrZH0ad2jZO76sVtd+yAg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Chho9mmnLAbfJx/0YtQl8U+Rj1v2Z9spbESrNvXpGQpcMZZ+8zr5KrGI6rnVFOZXG
	 lzvVgkNE+cymFdCuwCLuYPr3KHtoT54XqkegR6S66OvnJL4kxPHeprUka1pWi+ub+8
	 WoRqos2zdHGyfcDcKJ9n5gdiNtzrIpMniUZ65APqO/BflSbWSLgTyy+6a/N9YV/Dq8
	 Ouos4lBnz9U5eE+zK0ixhQwGIZ3kjaAKROoy6MaTzqLUotaOIeF+hYpEtAHfV8iSk+
	 f6iRl1UiIN4jHQItZDqVvgwyJIp4YJ1mOLbLlN1H+3/YDK8uWaLhUauqUSGxzfAW/q
	 4h0mOMhGT83CA==
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5A2E043B5C
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Apr 2026 08:36:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pZqq/dU6;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6/AXJBmwVA92r/hdtrzn94cYORrGdkw3rm7527iPvPnCBVMNfr5Asz6YPCn8BiKKHxojDHj+td99L5MVv2sP0cPpL4LvDmecoLvppg7Oz2vX44+bvA6vukoV63R653XVSg0AFeMGmsCw5qbiUX1AVsJNhz0/mdw4dN/R/lx3f+h12ZYf3M9QtgYJIZwG8HSZDacudVnB83Hl/DVzSgveEGqEfhGse7s1B5+NiX0yXa+L6T7+l5VHB7y8/Bap5zLdquny+wiMj4HFIHL3V+pjlqjfQeyuajkLLJ1f/7UVc1+PmQKKR4W1VqSDwh5zjQKBHX2jtm5Hml4H+vsNclABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLyP+Ieod3HFcjY+77foOcKwbWG12mB2TjgDnMfYfiM=;
 b=v3AtMl6NkEujgZqv9PXGXjncc7O3MqFaUYkX3YubBIILrsIwgP0VvI1nG2srWe7JORtIsbCmDmgukjxGLQ8QllqWldtPXp8BIXg6F5M5J6VKtk3Akz8Ih/qgM4y+fSPCb0SQ9hrEbjSF6QglNT9R7Mcz8JSKR6kKrtC1lGvP6OEvr6fOW8d8NoNV0ZhosQlUjrthskhGFlCRH8LfZAWxD3D6guZVq77EnqabstptIc6Cm9fUT1XKpes4CRPRUB36//sbIMxB9vXLLvQ/Hveiv/T8neUk4n+xi3Hy2bqN6vceR2ktE+ELh5fULVZUGzIFciFIC5v8dlMZMio8DFaCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLyP+Ieod3HFcjY+77foOcKwbWG12mB2TjgDnMfYfiM=;
 b=pZqq/dU6sXn3nBvIz0Nz/aXM7oXOqzJNDq861+Pr0wJrjGAecR9UR0ImSAKxkTwA1WB7mWCZsrupqH8yyjMvIX0vcj4dt9rBHBc+BvBlhSUeGrfjP5VZOFQFoOnfZa92sUFwbqJrbDF+2BTt9BTeYEfznx3fZTrddc0ECl0sc8CcgC8PoHnEQJ2E62kARxJljZ1Grf04aI0ITqZ6KYZAV+2XF5LSDJvxlybiwVLwRzKwSFBUBnXxRlFno98g1AsqQqINdRrdpWkR+koSBm0nNG2gb+s9wprZ0qz3/f3AXSFGket209ydpCSJ0O0pJlCgljGOdU1DuLdYPd9fNHeEkA==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB5860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:397::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 08:36:16 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9745.035; Fri, 10 Apr 2026
 08:36:15 +0000
Message-ID: <30ddaa03-b2af-4c71-bd0e-b379cc4f2685@siemens.com>
Date: Fri, 10 Apr 2026 10:36:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: PKCS#11 TA needs userland supplicant?
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <020c35af-a58e-47dc-b445-841538e62f88@siemens.com>
 <CAHUa44HNAGSLV9onUmYKm8fbKvYGVBNNqCtWjZcEGXtoEfLwCg@mail.gmail.com>
 <4dfd2e07-4627-4682-a8f2-bc13eafa1fe9@siemens.com>
 <7a52b4ec-7e75-4332-b94c-726978a3a7b6@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7a52b4ec-7e75-4332-b94c-726978a3a7b6@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR4P281CA0339.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: f923853a-6f58-47d7-ff84-08de96dc3ace
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ltlmoRsQBnFoicnx+5Dt280IFw0cG0IDxGpHzb/IcrhFafZb8cYTx7qGzInz4uieXgNOvxd02DWoQMRCCjgeTKGIwLqgc8i+1cWkhPb82zeKHZk/YBilQp74gDboLJ0vVBB8c/d4NOf+kT3NI5og+iLIooqn0vFnCKRCyMe3vlPO6ltwXEFWbbSKJlZ25HgbkBzRO8+Uqm09VYiBrTYEI9Y4KLlKv5bfUuYMR9WbdSZRDsMISKCkuZj4Ac9iIhUZmN8TQ2H8CoBPK+PjzlNvMqoAtVuzFKnhn29DFHhf6KECGEKpCfr2I22jnqnygvdvxxumo6xaMgu4kQ+BmwW4Ych1Rcpms4F54YugEQg5dncpi6Co0nMaluF5mHdZq5x7xiGBn8WgH0RGnmA90ggvKGXvv9hLAHaYYJN0jQl6wkB2vVIMx7WnPbmjn3QWJEyd2PBn4ywcjLdlr+afPQEl6vIASjGeREANw6dHl/FeAqdKEQOKyW9dqeYYrcNFyQRYgTU6mYRVEGzsmQVH3GntDYdzlbv5BuuoFzdOSmGoNx+ERTIw1pPh1x0JiF0gJdxzhMbvw9klTNP4bOlx+RmizbQ6QRJqPKhi3F+vZqyoyTgQA8aKwAh/0bWvb3vuYEX6QJLuqqq88w+WNo9nvc/DoWebUtuttX+bAFR28aLTTVoI5gJFiMoqniOf5KUl/3vEfrS3bLNzqdV9gaBA9ZSg2qQXqfFngrpear4ahIIsl90=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUlHTkl0VEM0SEZMMy81SjdlcHczTkNJVWx4ZFlZVjNIdEtUZUg3MGVxUi9P?=
 =?utf-8?B?SWhmY0M5ejlyalRzU1haNk1KNm9JZkE2eW5GQ3ZSVys5ZTd0NnYrcjUyUnZE?=
 =?utf-8?B?ZmN4L0tLMm5kaGlTREw0Y2w4QW9HOTB0Qk1GZDBrRlBnWHYwSkhtQ2pwMlZq?=
 =?utf-8?B?c1VEYUtscSthRUZqYm5nUmlZUTB3N3Nqdm5zUGZlQWwzRWFORURRYnJSR0tV?=
 =?utf-8?B?dCtiODhpYnJSdHJjYzFMRTd2eTcxZTcwK0duTFpyalZOR0pmVFZOZS9rcXBT?=
 =?utf-8?B?ZXNMVmlIRjQ0Mk5aMnlyUFljSXovd0FKUVIydHNuMm9icFZKMk5WVlFyaUpa?=
 =?utf-8?B?ZkF6WCttdjBCd0ttWjE4TEE2VXBZeVJuc2x2aURDeGZBYnV5dXdJRW54ZUpJ?=
 =?utf-8?B?RHdOaVU1NUd4MzFkSmZUR0tTYzc4bHpaZVp5TkwxRnE1ck9zaWYyK1VUbWI1?=
 =?utf-8?B?QlBnWDFUOWV5K0FBRFNTWlBnRjFSMm9zMnJQdm5OU21QZmRReW9RU2dJTHlr?=
 =?utf-8?B?Q1NzeGhaclZNR08zSWNqUG9XMTBHekNVVlNndHptNVhwU2p1N1BuRExnK01H?=
 =?utf-8?B?NFR5UzlmUDJlM0wxZFlTWjI0SjVjMVJUVkMycytPYXpVbTNyZ1RZcktabmRv?=
 =?utf-8?B?OFo3S0tvWUJueGllM3k3OXpycW5LTXUwK3VTUGVWb0ZjN1lrRFhDaVRuUmJo?=
 =?utf-8?B?d2hJSUdHcGRGQjJyaHQyS08vWloySGZUTi9QelhsRjlOZHdhdnY0WCtOSy9a?=
 =?utf-8?B?OUJLNzdST2NHYktsbTByUUtXNkxSU3RsejViNm85UVlpY0JRNzYyK3F4R3Nq?=
 =?utf-8?B?bXhWVkhtU1YzK3pQL2g1WUphSXQrQjJlY1c0MTFlVUxDUkhIb0M2cHVMSzRp?=
 =?utf-8?B?Z013V1NIem5OSEIyOTdPWkhrd0Zpdm5DV3E3TDd1K3hYcFp4aFRlTEdsaFN2?=
 =?utf-8?B?dWMzbkM1dUtiQ1dIRHdzaEZ6TnFseUpGQjVJT0xOeDJCcnBZYkdRMmFUcmli?=
 =?utf-8?B?WlZNWiszVFNvTGpWaVVlVnZ4aTI3RXcxVXB1aFgwamRqb21UbTR2MzdCQUto?=
 =?utf-8?B?VmFSWGZiREc0dDdlRGFRNUNOVndxalNBVFk2dlpXTjZZV2VFU2hRT3VJczB0?=
 =?utf-8?B?UlJCdzBRWEhoclNJTnQ2QmdvNCs5eklrZ2dpWGt1cFVhWDN3dGtRdVRlaXRx?=
 =?utf-8?B?ZTRrTk9PVXY1OHJ2YmlYdVFxcnR6R1JqUEpNZDJMa1hxYi9KYUhidmxCVFBB?=
 =?utf-8?B?OTgzd255UjJrM0h6bkE2cmpDYmh3OVpjSmc3UTVpakhXRFpGV1owMGVZdlBi?=
 =?utf-8?B?a0FsTkc4SFFwcDRPQUxvWmhKcmhvdUJvQU5yeGhNa1ZUZFBnaUMzM3BldE9x?=
 =?utf-8?B?ZkZsa0tib1M5VmZKYnFLZjVVbjV5cU5CdXc5L2lCa0NlVkZsQ1dSdzVxOVY5?=
 =?utf-8?B?Q1FoSzNGWkozQXBYeEZEZGhSTEtNSHoxZW5xbjVWMFdvcmhmR0ZXSC9hOUFM?=
 =?utf-8?B?S2V0Sk1Nb1cyRFVmbUIwVmV4N3dwV0JTMnlUZFM3aUJFSmlPRVN3NlVDZHJl?=
 =?utf-8?B?SnNhSDlvUDJxOW14MCtQZVc4Q2xNazFjYWxwNUU1WSs1TFVwamhEU1lBaDJq?=
 =?utf-8?B?aHBjZGRCRjVmRnNQUkEva1dNcEpHWEY5L2lWVlpBSmlYVm5vMGJmdjJHbzFu?=
 =?utf-8?B?Wi9wbFV1RnI3REs2Yk5kNWxUS2FRWXFHV2QyMTRIT3BTS3E2S1ZtRmhVYzJw?=
 =?utf-8?B?V2h3NXVadVBQdUJURXJmeS8rbVpYYkVOalhqZThTcEM0Nmx5ZXk0VSs3YmxY?=
 =?utf-8?B?cGNERjBoN2FrUkJzMlJVZCtVVG9aWFhZN2ZiMWdGcnZibXArTVZlOVRBU0lF?=
 =?utf-8?B?V3RwbVdjZU5HMXY3QXpzZFdicTV4QlQrVTMrQ2NhUXZlOUtLK0F2dlNLREto?=
 =?utf-8?B?UFM2UmwxRElzTmYyTDUzOW5wbkdXclA1OG14Um1rVStReDNyV1ZVcml6a25P?=
 =?utf-8?B?YU9PWkI1Q05wb0RDdVR5alRYQkdwYUtiMDJ3WWZ5M1dCVm9ESThkeUpUUWg4?=
 =?utf-8?B?STIyLzgzM3dZc3RQU0oxV2F4UE10bHY2TytsV21laWZTTDVOYk43SFJRMUFB?=
 =?utf-8?B?SVBNeHMyTnBQR3BzYXNQa00xYVhWTS9pUDBDOER6VXNmUnZyV29YYkZjenIv?=
 =?utf-8?B?VmNtMS8wY2FiTHgvL1phdFYzZkd6d0lhNWNvdWV1OWVSb0VkNUw4c1BPTmdI?=
 =?utf-8?B?ZTJPMW12N21oV3lSRVFqY2lZQTl4Uk1kR0Y0TTNXQUN3ZlJxVlQ2VUdpdEUv?=
 =?utf-8?B?WmdpdEpTWStHUXVlM01JZENFQjhkNHJUeWFqSGhxc3I3Y1kzOXZLQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f923853a-6f58-47d7-ff84-08de96dc3ace
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:36:15.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmdKx3wDQOS21kJPvzGRdhmx8Ieki99af/le8DLxNj36ddXVspiA8LbhMjM24V/nom+ycgRBwdLQ/Sb+/Ih4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5860
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.83.36:from];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.83.36:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5A2E043B5C
X-Spamd-Bar: -----
Message-ID-Hash: AEI3MZSS6J3JEFTPQGQQLFLTBRC7PUKW
X-Message-ID-Hash: AEI3MZSS6J3JEFTPQGQQLFLTBRC7PUKW
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AEI3MZSS6J3JEFTPQGQQLFLTBRC7PUKW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

T24gMTAuMDQuMjYgMDk6NTksIEphbiBLaXN6a2Egd3JvdGU6DQo+IE9uIDEwLjA0LjI2IDA3OjQ1
LCBKYW4gS2lzemthIHdyb3RlOg0KPj4gT24gMTAuMDQuMjYgMDc6MzcsIEplbnMgV2lrbGFuZGVy
IHdyb3RlOg0KPj4+IEhpLA0KPj4+DQo+Pj4gT24gVGh1LCBBcHIgOSwgMjAyNiBhdCA3OjQx4oCv
UE0gSmFuIEtpc3prYSB2aWEgT1AtVEVFDQo+Pj4gPG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdh
cmUub3JnPiB3cm90ZToNCj4+Pj4NCj4+Pj4gSGkgYWxsLA0KPj4+Pg0KPj4+PiB0byBhdm9pZCB0
aGF0IEknbSBkZWJ1Z2dpbmcgZnVydGhlciB0aGlzIGVycm9yIEkgZ2V0IGR1cmluZyBib290IHdp
dGgNCj4+Pj4gQ09ORklHX1JQTUI9eSBpbiB0aGUga2VybmVsIGFuZCBDRkdfSU5fVFJFRV9FQVJM
WV9UQVM9cGtjczExL2ZkMDJjOWRhLi4uOg0KPj4+Pg0KPj4+PiBbICAgIDAuMzU5MzcyXSBtbWNi
bGswYm9vdDA6IG1tYzA6MDAwMSBRRU1VISEgNC4wMCBNaUINCj4+Pj4gWyAgICAwLjM2MTc3OV0g
bW1jYmxrMGJvb3QxOiBtbWMwOjAwMDEgUUVNVSEhIDQuMDAgTWlCDQo+Pj4+IFsgICAgMC4zNjM3
NjFdIG1tY2JsazBycG1iOiBtbWMwOjAwMDEgUUVNVSEhIDIuMDAgTWlCLCBjaGFyZGV2ICgyNDg6
MCkNCj4+Pj4gRC9UQzo/IDAgdGVlX3RhX2luaXRfc2Vzc2lvbl93aXRoX2NvbnRleHQ6NTY5IFJl
LW9wZW4gdHJ1c3RlZCBzZXJ2aWNlIDcwMTFhNjg4LWRkZGUtNDA1My1hNWE5LTdiM2M0ZGRmMTNi
OA0KPj4+PiBEL1RDOj8gMCBsZWdhY3lfcnBtYl9pbml0OjExNDMgVHJ5aW5nIGxlZ2FjeSBSUE1C
IGluaXQNCj4+Pg0KPj4+IFRoZSBpbi1rZXJuZWwgcm91dGluZyBkaWRuJ3QgaW5pdGlhbGl6ZSBh
cyBleHBlY3RlZCwgc28gT1AtVEVFIGlzDQo+Pj4gZmFsbGluZyBiYWNrIHRvIHRoZSB0ZWUtc3Vw
cGxpY2FudCBiYXNlZCBSUE1CIGNvbW11bmljYXRpb24uDQo+Pj4NCj4+Pg0KPj4+PiBFL1RDOj8g
MCBnZXRfcnBjX2FsbG9jX3Jlczo2NDYgUlBDIGFsbG9jYXRpb24gZmFpbGVkLiBOb24tc2VjdXJl
IHdvcmxkIHJlc3VsdDogcmV0PTB4ZmZmZjAwMGMgcmV0X29yaWdpbj0weDINCj4+Pj4gRC9UQzo/
IDAgdGVlX3RhX2ludm9rZV9jb21tYW5kOjgzMCBFcnJvcjogZjAxMDAwMDMgb2YgNA0KPj4+PiBE
L1RDOj8gMCB0ZWVfdGFfY2xvc2Vfc2Vzc2lvbjo0NjkgY3Nlc3MgMHhjMDIxMDkxMCBpZCAxDQo+
Pj4+IEQvVEM6PyAwIHRlZV90YV9jbG9zZV9zZXNzaW9uOjQ4OCBEZXN0cm95IHNlc3Npb24NCj4+
Pj4NCj4+Pj4gSXMgaXQgcG9zc2libGUgYXQgYWxsIHRvIHJ1biB0aGUgUEtDUyMxMSBUQSB3aXRo
b3V0IHVzZXJsYW5kIHRlZS0NCj4+Pj4gc3VwcGxpY2FudD8gSSB0aG91Z2h0IGl0IG9ubHkgbmVl
ZHMgdGhlIHN1cHBsaWNhbnQgZm9yIFJQTUIsIHRodXMgc2hvdWxkDQo+Pj4+IGJlIGZpbmUgd2l0
aCB0aGUgaW4ta2VybmVsIHJvdXRpbmcgKHdoaWNoIGlzIGFjdGl2ZSksIGJ1dCBtYXliZSB0aGF0
IGlzDQo+Pj4+IG5vdCB0cnVlLg0KPj4+DQo+Pj4gWWVzLCBJIHRoaW5rIHNvLiBJIGhhdmVuJ3Qg
dHJpZWQgaXQgbXlzZWxmLCB0aG91Z2guIEFueXdheSwgdGhlIGxvZw0KPj4+IHRlbGxzIHRoYXQg
T1AtVEVFIGlzbid0IHVzaW5nIGluLWtlcm5lbCByb3V0aW5nLiBZb3UgY2FuIGFsc28gY2hlY2sN
Cj4+PiAvc3lzL2NsYXNzL3RlZS90ZWVwcml2MC9ycG1iX3JvdXRpbmdfbW9kZWwgdG8gc2VlIHdo
YXQgdGhlIGRyaXZlciBoYXMNCj4+PiBuZWdvdGlhdGVkLg0KPj4+DQo+Pg0KPj4gIyBjYXQgL3N5
cy9jbGFzcy90ZWUvdGVlcHJpdjAvcnBtYl9yb3V0aW5nX21vZGVsDQo+PiBrZXJuZWwNCj4+DQo+
PiBBbmQgaWYgSSBidWlsZCBvcHRlZSBhcyBtb2R1bGUgYW5kIGxvYWQgaXQgbGF0ZXIsIHRoZW4g
Y2FsbCAicGtjczEtdG9vbA0KPj4gLS1tb2R1bGUgL3Vzci9saWIvbGliY2t0ZWVjLnNvLjAgLUki
LCBpdCBhbHNvIHdhaXRzIGZvciB1c2Vyc3BhY2UgdGVlIGhlcmU6DQo+Pg0KPj4gLi4uDQo+PiBG
L1RDOj8gMCB0cmFjZV9zeXNjYWxsOjE0NyBzeXNjYWxsICM4IChzeXNjYWxsX2NoZWNrX2FjY2Vz
c19yaWdodHMpDQo+PiBGL1RDOj8gMCB0cmFjZV9zeXNjYWxsOjE0NyBzeXNjYWxsICM0MSAoc3lz
Y2FsbF9zdG9yYWdlX29ial9vcGVuKQ0KPj4gRC9UQzo/IDAgbGVnYWN5X3JwbWJfaW5pdDoxMTQz
IFRyeWluZyBsZWdhY3kgUlBNQiBpbml0DQo+PiBJL1RDOiB0aHJlYWRfcnBjX2FsbG9jIDAsIGFy
Zy0+cmV0IGZmZmYwMDAwDQo+PiBJL1RDOiBnZXRfcnBjX2FsbG9jX3JlczogYnQgMCBzaXplIDgx
OTINCj4+DQo+IA0KPiBJIGluc3RydW1lbnRlZCBmdXJ0aGVyLCBhbmQgSSdtIGdldHRpbmcgYW4g
T1BURUVfUlBDX0NNRF9TSE1fQUxMT0Mgd2l0aA0KPiBPUFRFRV9SUENfU0hNX1RZUEVfQVBQTCwg
bm90IE9QVEVFX1JQQ19TSE1fVFlQRV9LRVJORUwgLSB0aGlzIGlzIHdoZXJlDQo+IHRoaW5ncyBh
cmUgZmFpbGluZyBvciBibG9ja2luZy4NCj4gDQoNCkkgdGhpbmsgSSdtIGdldHRpbmcgY2xvc2Vy
OiBXZSBoYXZlIGtleS13cml0aW5nIGVuYWJsZWQgZm9yIHRoZSBRRU1VDQp0YXJnZXQgKGtleSBp
cyBub3QgcGVyc2lzdGVkIHRoZXJlIHlldCksIGFuZCB0aGF0IHNlZW1zIHRvIGVuZm9yY2UNCmxl
Z2FjeSBpbml0IGFsbCB0aGUgdGltZToNCg0KaHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9vcHRl
ZV9vcy9ibG9iLzE1YmJhYTMzMWZiNmQ2OTQ2NmM0ODgwYTFhZjFlOGU5NTgwYzk1ZjEvY29yZS90
ZWUvdGVlX3JwbWJfZnMuYyNMMTI0OA0KDQpJZiBJIGdvdCBpdCByaWdodCwgbGVnYWN5X3JwbWJf
aW5pdCByZXF1aXJlcyBhIHVzZXJzcGFjZSBzdXBwbGljYW50LA0KZG9lc24ndCBpdD8NCg0KSmFu
DQoNCi0tIA0KU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KTGludXggRXhw
ZXJ0IENlbnRlcg0K
