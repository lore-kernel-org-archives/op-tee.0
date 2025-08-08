Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA23C87FD3
	for <op-tee@archiver.kernel.org>; Fri,  8 Aug 2025 10:35:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 574D6430A2
	for <op-tee@archiver.kernel.org>; Fri,  8 Aug 2025 10:35:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iIgz3tqw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iIgz3tqw;
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A774442C3C
	for <op-tee@lists.trustedfirmware.org>; Fri,  8 Aug 2025 10:35:21 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KlNyft9P7+xRQ+HcHzu6F2k2PE17WibPzMrb0HuQwwNeTUelGiSfd6sPQegrQuTUPRWQdHG/mPQJuTDwoTSrHH5/rnH3MCNJplm0DCg9WFTLnom6EwB1Fmb9BtoVILXyGamVhN8FEaKQfPLNNipM+opEsEtEjNr7rRE95KHVtSjgqb/W+Rshih8p8jUlv15HsUf6Vd7JyfLc24TcNZPSW9VmUiGhceWB+tqDb4ydykaXucgLIxOP9CR2jDey4sgjHuiwW71kWN2y6DXhtQn0Lmi0PPwv0VRzRpkFFXFV0lt5z2197Sk5AfIhblVCUOM1atyy59JINtARMwTi95U5sQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkvpWrTegJgCHL65lQB/y+iQwcw7uUlUj0sw0F4PqxY=;
 b=PJfSove3zIsOU0MlefWDVdJuHcsYsY6KLQLHeEWjxzQm5RKA0PYQWcD0lH8HR3gJpdcI6ziHATwHJDlLiFDWpqlTwshjx4YI8DtmfLMogSO2V3cdMDn9vnwB9d7B2HGTnA9ssCA50y4tQB4j4K+zcYmJQjAzH4884KwnnG9nivJ5ZYfOTe/DYkJt5syHc69+55ws7iXUHVXqzq1LVgwlmalPuIo5GHLDtMRGJE1YEN30i0IFD+aD4fuLyP8UVJichEkx6Kha+mqOVqvh9Jy8xmFN0iH8ZeEQEhspVAq55umVPFIPsL0fQCGRAGJsPoj1AQklbD03JyAOC0648T+76A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=perle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkvpWrTegJgCHL65lQB/y+iQwcw7uUlUj0sw0F4PqxY=;
 b=iIgz3tqwBuZ0FGnNu9u9rO2wrNiVDJJeqAh+1nL5+VNz4WaezmBdGOUqEfrW8Foo4CY+qoP4LT7t3q/2DGim844eOJWcUOiEgf4JYBpYOFF9mcFL/6S3fCtOOukIpzzIF3gV83u7Pe5TzcTuMBla3Pzs9chghMtpRrkxGIMpq6Y=
Received: from DUZPR01CA0176.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::12) by VE1PR08MB5598.eurprd08.prod.outlook.com
 (2603:10a6:800:1a2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 10:35:16 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::bd) by DUZPR01CA0176.outlook.office365.com
 (2603:10a6:10:4b3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 10:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Fri, 8 Aug 2025 10:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zl0HFzhCQMDDLglFDgGCFHuuZrdihqVpilmNP7i7O7YXGfBomPnS5A1Mse+0Fr4HVadzlGJIh0NbftdCiyJA/xNzAcenQP07d7z/MYqqPD66eqyE5NKj/zlVVEKN0dAS2RUL1lfwAkSSYJOttdj92t2SV18L6XNh1nn1qnPrQ6xEZGaIGgH90BTn0QuH06BoCBzGCl3aoV5+5gxtmW5XQPR5u8s/H+zhTVlhSb9+WGTOKXabE0lEQVJQ8MtXpl3mY3YsTNx61ibbebNFAuk+tbpCuPLZ3IEbAYjjBTpiCctG7IKx+fVVjUd9TFSrxnKGnG595Ybaeb8cfZ+QXlx2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkvpWrTegJgCHL65lQB/y+iQwcw7uUlUj0sw0F4PqxY=;
 b=CogJxLMuRrejpBrSy6y88nmlhIJwxXxfk7BR1dcWzJzTNtLuup2dHozxByePMTp53/ZX5bqgB0RcEPX9n3dRO8lIBd3I8j0cDsMHY1tkItBm39dga9QSI18kkB5RHt38/tRSD7UUSEL/mC8z8prJujckKggLFKmCSbVlhcsH4TPVwdGxlpmecv1m8TU2MvJUeUb8Ky1hc+DWP6aX7466SICZojEi6jqNlvMrqSohJG6pqdWkiQhZjfs5nEebw1BvagFaOAcMVx2mdcQwOvKY0vO5n5BvXyXI4F3QY5hZrP4gjw9VgHKvA75NGPmsfuYrP5NykwC8670YC62nCWiGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkvpWrTegJgCHL65lQB/y+iQwcw7uUlUj0sw0F4PqxY=;
 b=iIgz3tqwBuZ0FGnNu9u9rO2wrNiVDJJeqAh+1nL5+VNz4WaezmBdGOUqEfrW8Foo4CY+qoP4LT7t3q/2DGim844eOJWcUOiEgf4JYBpYOFF9mcFL/6S3fCtOOukIpzzIF3gV83u7Pe5TzcTuMBla3Pzs9chghMtpRrkxGIMpq6Y=
Received: from DB9PR08MB6796.eurprd08.prod.outlook.com (2603:10a6:10:2ad::16)
 by AS8PR08MB6599.eurprd08.prod.outlook.com (2603:10a6:20b:332::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 8 Aug
 2025 10:34:41 +0000
Received: from DB9PR08MB6796.eurprd08.prod.outlook.com
 ([fe80::87e5:1d30:18ad:6b84]) by DB9PR08MB6796.eurprd08.prod.outlook.com
 ([fe80::87e5:1d30:18ad:6b84%7]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 10:34:40 +0000
From: Olivier Deprez <Olivier.Deprez@arm.com>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: Re: optee_ftpm + ms-tpm-20-ref  support for RSA key sizes 3072 or
 4096 causes a panic
Thread-Topic: optee_ftpm + ms-tpm-20-ref  support for RSA key sizes 3072 or
 4096 causes a panic
Thread-Index: AQHcB+QVa4M3brSjHk+7uhFtK7MZDbRYj2or
Date: Fri, 8 Aug 2025 10:34:40 +0000
Message-ID: 
 <DB9PR08MB67965F30723919C815D16FE79B2FA@DB9PR08MB6796.eurprd08.prod.outlook.com>
References: 
 <DM6PR04MB6332AD1DC5D859D996A452E4B22CA@DM6PR04MB6332.namprd04.prod.outlook.com>
In-Reply-To: 
 <DM6PR04MB6332AD1DC5D859D996A452E4B22CA@DM6PR04MB6332.namprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	DB9PR08MB6796:EE_|AS8PR08MB6599:EE_|DB5PEPF00014B8E:EE_|VE1PR08MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ea8599-ad96-4e2c-e95e-08ddd6674200
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?us-ascii?Q?Hjc3p8gcVkxCux5EgTmKtEEjsdJYkRKT+LwEnjoKQdsweVBKfdkGTrfTxNpf?=
 =?us-ascii?Q?48SYn5FgwQq0OKdblgTWI6Ub65FjWbvtJm2VYolBpaQfg/S6vEDG6BUYADEE?=
 =?us-ascii?Q?X/laF7CoqsPdsFrPucxv0zTnoamC8AVJ6SUcm+BX5560aHCmrK4DmKckHQz/?=
 =?us-ascii?Q?HZ6MHpQq10gS6O8gdmXtPqFvCeJBIG+9G7+IVHz3jftul/EVkIj0OiO66eRr?=
 =?us-ascii?Q?HAfcIZaM9nxFFQ3b5wv3bI22rbi7/kqQyvf1bLF+zu0wka31LPm61Hw6XvV0?=
 =?us-ascii?Q?r0hUMWQDf5JYjJxNlBFXoixUnkhPZvWr20gfp2LtmWaS2RRGgCWdsvLpKOL9?=
 =?us-ascii?Q?zBC9+gMLAMfLcoIuZzeoreVpeT+xbA2pKnEQOY6r0aFpk0wJcNgeNEgaPGdg?=
 =?us-ascii?Q?QUxZ06FLYwebkRVFf0Vwl4/Fiey6erHvDGiY+jABUYOh8BRy6KO2h+lHiq8x?=
 =?us-ascii?Q?2UUjqyT0UJbgDPbTLurdjXKqPO2Ycs1VPJuytMs5NDcy5YC4GZG8nQX80v2j?=
 =?us-ascii?Q?z7/cvhr/jeXvpv4YB1ogHeceRp6BhEm51VswlKnTaX+XY07mcXx3+ZCEK+BY?=
 =?us-ascii?Q?S0mnM8QCd8Xm3M6qcSuZsItKn7YKm7ZlqvCYFSJh8WsZkmYSR5gPLW4ApH7j?=
 =?us-ascii?Q?RftTQyZ4JxoCw3PaI0oIUoyT5DgHHVNjeEgZie8Fu4rr+lgBG9B7tbO4Mq4j?=
 =?us-ascii?Q?A2HwekKAcVnhAfR2ERG4DIc2XrL6CF8DeGepMxeU9LnmiLsXzREkd3P6g5rD?=
 =?us-ascii?Q?WlXIE7yOXX34M007/+N9lNuNYckiyzuWa5i3Ri0JZO/UGszvxiPUwnxVDLDg?=
 =?us-ascii?Q?9oOmKvWC0VW2SWerQo6X+wSM/n57Vb7NVdaFhkntmkFEyRpY6cL/Z2kQFQ4N?=
 =?us-ascii?Q?/AsEuc1NXC42/5Ik+31GJv22HpF/84U7kngbNBcPfTyrYmA4X0OXO0X7UW2/?=
 =?us-ascii?Q?mE7UmuleEmYzAMG6R5bez2EIALWRZlv8g1yD5wNEJEdkRWqXBWj902a4f34J?=
 =?us-ascii?Q?xWrsLeMtO8ALUazKMmTUxSo5xE1y2LMPt0HYKlUCNZCuH1GtyZGjg9IJkMnx?=
 =?us-ascii?Q?iqNmDG2zIZothOLntqcr1wN0imYuTAIAmQIXiM9nhrhSNKgaxarzHfN+88lA?=
 =?us-ascii?Q?+voedF4l3/rtqk7OJKXCvXKAqH/dFJUCFMpUfguhbn/m/3gh03IooTG6lW9s?=
 =?us-ascii?Q?9B78GIhI8L4P2q7dOWZ+qHAZz0rAx5kefQq0aQ1TVygtN2OKdNRx+vMu57sO?=
 =?us-ascii?Q?aX8ttWDIebYQqDPtQCeDG6+B9rwbwzLq/0eMhIEWm5bhT2HHYswgDSbyNz8/?=
 =?us-ascii?Q?TCWZId2LZNFMw4fgK8WpIA+o5T7pituQIuWBZQm1KmSSCH/gaYoT8/wEfNSr?=
 =?us-ascii?Q?fWK+srL87Th2iY587RGf+Ug4WEuyyQkAAlCX3Od+5as6hbTpjGpDV6ZXF9LB?=
 =?us-ascii?Q?a8mG2qeB+juoZmuko3ROIgGfS5PoZCn9Ery9cQbTx7kYtR2DqnX+NA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6796.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018);DIR:OUT;SFP:1101;
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6599
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	21d9e179-c23b-40b3-28ef-08ddd6672ea3
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|35042699022|376014|36860700013|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?akk5N1lVTU0yakdsT1R0Y2JOOU1CL3ZaSGdIL3hRYVRha0JKRTR5V1QxaElP?=
 =?utf-8?B?UG1WQmJxb2F1c081Zzg0elg4U0FSVCtBT1g1NTZhRnZiN0ZQQlR3cW9YRjJw?=
 =?utf-8?B?NUpZMlEzbFMrZXBGVFRuQzREN1AwYVY3TE14OVR4QVUyZDNBWit0M2MzMVA3?=
 =?utf-8?B?N1NPQkowbDMvbDl0THdSblE1NGxWclZiOGhjRFV5UmVyemJYT1AwV3VmL1hV?=
 =?utf-8?B?bFJTMk1RdEhBTC9wK2RzTk9aV1crbm1qall1cUZUMVRTVTFidzM1ZzdVUDRw?=
 =?utf-8?B?eU1DRWFKVnlXQnN5MzhDRXJaQmxFby9NUzZVL2hraXpBMFdCamxsMWVRVFJQ?=
 =?utf-8?B?TitmMEY3aE9saTdlSFhiTFpmZGt2VlhySEk2S2ZRdWJLQVVQY0RqKzVTVUdZ?=
 =?utf-8?B?SXNKVzdRaHNYVm5oalYxVHE2QU1ySkdDeFJUajFGeTc2YWNpb05PN09jamdC?=
 =?utf-8?B?WHNvY3RnaVRxa1ZlR2htRDgraTN6SkhrRWxqcmlPcU8wR1JhVUlXdlhtUzY2?=
 =?utf-8?B?YTFxRzBOOUpoYitTSU9Ha3pwUFBQenR6bHg4MDBuTWJEWVJORUdnZ2k2RDBp?=
 =?utf-8?B?emVkcFFLNTN1QUdGOGo2RWtBNGlNREJLZ0dEeTQyMUZxVUJ4SzhMRHdBKzV6?=
 =?utf-8?B?Q0h0akg4bGpLeFRxZGg3eFFmWkFiSmhWYTFnVTdIMTU0UGNkNm5ueWNwUlVY?=
 =?utf-8?B?ek5RdmoxZURYZHorTzFEMHRBKyswa2FGVFNJemI0V2d4bTlOVnlFYzVKUDBE?=
 =?utf-8?B?cXhTQkpKN3I3c0svbCtwUWFQUEFyS2JSOTlJRFRqZkFrMm9XTUZWWmE1T0Y0?=
 =?utf-8?B?S0FIbjR6YUpDWG4rN3pLMUhhYm5Bd3NTQUJJTlFXcTNZeVlzempRTWliMVBJ?=
 =?utf-8?B?RXhub3BQSjFiMGk4d2NYeHYrT3pCRG5BNlZOK3BtT3Q1MENPMlZKUE9waG9B?=
 =?utf-8?B?dVNWbzNOaGJMV2RndHArNTBsVUgzdXdSYmlPbTFrbzdBeUJnclFVcXlUdUcr?=
 =?utf-8?B?dVppcVRHMi9YSlowYk9tdnR6UnN2RTNkYktrYnZBN0duYWxjRTN2SlJ5KzFZ?=
 =?utf-8?B?VmdqSUxOSHh2cVYyNldhbFp4Tk55MEZmVGVaNGhsTWVHR0s5YUg4ajdUMW4r?=
 =?utf-8?B?UEdqUHYxeUVKdEdXR3U4YjNOMkZoZWZ3M2tYRkZpRWR0cWU4bWdrc3VaNmdL?=
 =?utf-8?B?dEYvSFlNYWxrQWNMU1pDKzh2M1hzeUx1c0xsZDMrVFVnQ2lwZ0Q3SU13TFdZ?=
 =?utf-8?B?eEFGWGpwSWhWUC9SZHVlbXZyakpEMUtDcnFlbHZMcy9BRElEdzRNdCt4UnF2?=
 =?utf-8?B?OXh0WVJudGtvYVdRTHBqcHVkSFFpMWN6TFBHMkVhS3paUzZEOVZzWnZ1T2NK?=
 =?utf-8?B?ZFR5RXBvL2JDMUZkcCtsalJaalFSbkdMWDBod1J6Qnoxb1Evc2hhbzBQZDYx?=
 =?utf-8?B?Nkl4NkVIV2tnRWxxR0V6M29vcFoyYkVJak9EcExxRkRUZ1FWOU1GNnFyZGVT?=
 =?utf-8?B?ZUt2eEMyb3pjVHRtZWQ0dzN6NTBxT3VRcDdnbnUrN2dmb3piY2x5TWw5ZDNn?=
 =?utf-8?B?cnJ0em03Nm1UNFFLVlpPb1ZneFNnVzVHRm1yZVpwd0tMVTVPRFJBdE4xUGxn?=
 =?utf-8?B?ZDFCcjdxaGYvejFQdXlIQ1ErQm1TK05kV1NPaS9aUHExbkg0blNlbGo1V3Z3?=
 =?utf-8?B?UEk5alNuVncyM200V2FGRVkxN0Nmc0d6VS96SUdvU0s2LzQ4N2pFWTEzOFVX?=
 =?utf-8?B?MmhBQ3lDZWs3NGlrelFFRTJwSHRvYjNKRUYxTzN4cGF4OXIraWsxSHl5OVlT?=
 =?utf-8?B?R29WNkxUWlhjNFFaRWVIMENjUElGaGhBakw3Yy9PVFYxaE5vTkpGZzNGeExv?=
 =?utf-8?B?bTZJSjZBRmRab2Q0OHF0UFVPaFFYNkNsUlRaWTUyVWtOYkxlaVJzY1dKeXlS?=
 =?utf-8?B?bm43aDFJUzlWNzYyaDJrczdKdjFJc09PeTl0M1NtU1dORDVhWFpNNjNBOEpk?=
 =?utf-8?B?UGNlU3ZwbUp1YkZUTDlQV0E1UWh2QW95TnpBK01tb3JyVnFDZ1M0NElpdHg2?=
 =?utf-8?Q?t0aZVO?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(376014)(36860700013)(8096899003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:35:13.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ea8599-ad96-4e2c-e95e-08ddd6674200
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5598
X-Rspamd-Queue-Id: A774442C3C
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=2];
	DWL_DNSWL_LOW(-1.00)[arm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.84.15:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.84.15:from];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: EDSF6UI2CEG2C6GEBMR6TW4MDQW3WHK3
X-Message-ID-Hash: EDSF6UI2CEG2C6GEBMR6TW4MDQW3WHK3
X-MailFrom: Olivier.Deprez@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: Dennis Kong <dkong@perle.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5EMTEM4U3JV2XGTJC5QHG4VRMGBBW4CL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGksDQoNCkkgYmVsaWV2ZSB0aGUgb3B0ZWUgbWFpbGluZyBpcyBiZXR0ZXIgcGxhY2VkIHRvIHBy
b3ZpZGUgYW5zd2Vycy4NCg0KUmVnYXJkcywNCk9saXZpZXIuDQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQpGcm9tOiBEZW5uaXMgS29uZyB2aWEgVEYtQSA8dGYtYUBsaXN0cy50
cnVzdGVkZmlybXdhcmUub3JnPg0KU2VudDogMDcgQXVndXN0IDIwMjUgMjM6NDQNClRvOiB0Zi1h
QGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmcgPHRmLWFAbGlzdHMudHJ1c3RlZGZpcm13YXJlLm9y
Zz4NClN1YmplY3Q6IFtURi1BXSBvcHRlZV9mdHBtICsgbXMtdHBtLTIwLXJlZiBzdXBwb3J0IGZv
ciBSU0Ega2V5IHNpemVzIDMwNzIgb3IgNDA5NiBjYXVzZXMgYSBwYW5pYw0KDQpEZWFyIGNvbW11
bml0eToNCg0KSSBhcG9sb2dpemUgaW4gYWR2YW5jZSBpZiB0aGlzIGlzIHRoZSBpbmNvcnJlY3Qg
cGxhY2UgdG8gc29saWNpdCBmb3IgaW5wdXQgb24gYW4gaXNzdWUgSSBhbSBoYXZpbmcgd2hlbiBl
bmFibGluZyBzdXBwb3J0IG9mIFJTQSBrZXkgc2l6ZXMgPiAyMDQ4LiAgVGhlIGVudmlyb25tZW50
IGlzIGRlc2NyaWJlZCBiZWxvdzoNClRJIEFNNjQyLUVWTSBib2FyZA0KRGViaWFuIEJvb2t3b3Jt
IHJ1bm5pbmcga2VybmVsIDYuNi4xMDAsIHRwbV9mdHBtX3RlZS5rbyBrZXJuZWwgbW9kdWxlDQpV
Ym9vdCBib290aW5nIGZyb20gc2RjYXJkIFVFRkkgcGFydGl0aW9uIGFuZCByb290ZnMgcGFydGl0
aW9uDQpvcHRlZV9vcyB2ZXJzaW9uIDQuNS4wICwgNC42LjAsIDQuNy4wIChubyBkaWZmZXJlbmNl
IGluIGJlaGF2aW91cikNCm9wdGVlX2NsaWVudCB2ZXJzaW9uIDQuNS4wLCA0LjYuMCwgNC43LjAg
KG5vIGRpZmZlcmVuY2UgaW4gYmVoYXZpb3VyKQ0Kb3B0ZWVfZnRwbSB2ZXJzaW9uIDQuNS4wIG9y
IDQuNi4wLCA0LjcuMCAobm8gZGlmZmVyZW5jZSBpbiBiZWhhdmlvdXIpDQptcy10cG0tMjAtcmVm
IGNvbW1pdCBpZCA5OGI2MGE0NGFiYTc5YjE1ZmNjZTFjMGQxZTQ2Y2Y1OTE4NDAwZjZhIGFuZCBl
OWZjN2I4OWQ4NjU1MzZjNDZkZWI2M2Y5YzdkMDEyMWEzZGVkNDljDQoNCkR1ZSB0byBpc3N1ZXMg
d2l0aCBSUE1CLCB3ZSBkZWNpZGVkIHRvIHVzZSBSRUVfRlMgaW5zdGVhZC4gIEV2ZXJ5dGhpbmcg
d29ya3MgY29ycmVjdGx5IHdoZW4gSSBjcmVhdGUgUlNBIDIwNDgga2V5cyB1c2luZyB0cG0yLW9w
ZW5zc2wgYW5kIHJlbGF0ZWQgdG9vbHM6DQpzdWRvIHRwbTJfY3JlYXRlcHJpbWFyeSAtQyBvIC1H
IHJzYTIwNDggLWcgc2hhMjU2IC1jIHByaW1hcnkuY3R4LCAgV2hlbiBJIHRyeSByc2EzMDcyIG9y
IDQwOTYsIEkgZ2V0IGVycm9ycyBmcm9tIHRoZSBjb21tYW5kIGxpbmUgcmVzcG9uc2Ugc2F5aW5n
IGludmFsaWQgaW5wdXQgcGFyYW1ldGVycy4gICBJIGNoYW5nZWQgdGhlIG1zLXRwbS0yMC1yZWYg
aW5jbHVkZSBmaWxlIFRwbVByb2ZpbGUuaCB0byBzZXQgUlNBXzMwNzIgYW5kIFJTQV80MDk2IG1h
Y3JvcyBib3RoIHRvIChBTEdfUlNBICYmIFlFUykuICBBZnRlciByZWJ1aWxkaW5nIGFuZCBydW5u
aW5nLCBJIG5vdyBnZXQgYW4gb3B0ZWUgcGFuaWMgZm9yIEFOWSBSU0Ega2V5IHJlcXVlc3QgSU5D
TFVESU5HIHJzYTIwNDguICBJIHJlYWQgc3VnZ2VzdGlvbnMgdG8gaW5jcmVhc2UgdGhlIE1BWF9D
T01NQU5EX1NJWkUvTUFYX1JFU1BPTlNFX1NJWkUgb24gYm90aCB0aGUga2VybmVsIGRyaXZlciB0
cG1fZnRwbV90ZWUua28gYW5kIGFsc28gb3B0ZWVfb3Mvb3B0ZWVfZnRwbSwgYXMgd2VsbCB0byBp
bmNyZWFzZSByZWxldmFudCBUQV9TVEFDS19TSVpFIGFuZCBUQV9IRUFQX1NJWkUgYW5kIFRBX0RB
VEFfU0laRSwgYnV0IG5vdGhpbmcgc2VlbXMgdG8gY2hhbmdlIHRoZSBwYW5pYyBvdXRwdXQ6DQoN
CnN1ZG8gdHBtMl9jcmVhdGVwcmltYXJ5IC1DIG8gLUcgcnNhMjA0OCAtZyBzaGEyNTYgLWMgcHJp
bWFyeS5jdHjigIs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCkUvVEM6PyAwDQpFL1RDOj8gMCBUQSBwYW5pY2tlZCB3aXRoIGNvZGUg
MHhmZmZmMDAwNw0KRS9MRDogIFN0YXR1cyBvZiBUQSBiYzUwZDk3MS1kNGM5LTQyYzQtODJjYi0z
NDNmYjdmMzc4OTYNCkUvTEQ6ICAgYXJjaDogYWFyY2g2NA0KRS9MRDogIHJlZ2lvbiAgMDogdmEg
MHg0MDAwNTAwMCBwYSAweDllOGIwMDAwIHNpemUgMHgwMDIwMDAgZmxhZ3MgcnctcyAobGRlbGYp
DQpFL0xEOiAgcmVnaW9uICAxOiB2YSAweDQwMDA3MDAwIHBhIDB4OWU4YjIwMDAgc2l6ZSAweDAw
ODAwMCBmbGFncyByLXhzIChsZGVsZikNCkUvTEQ6ICByZWdpb24gIDI6IHZhIDB4NDAwMGYwMDAg
cGEgMHg5ZThiYTAwMCBzaXplIDB4MDAxMDAwIGZsYWdzIHJ3LXMgKGxkZWxmKQ0KRS9MRDogIHJl
Z2lvbiAgMzogdmEgMHg0MDAxMDAwMCBwYSAweDllOGJiMDAwIHNpemUgMHgwMDQwMDAgZmxhZ3Mg
cnctcyAobGRlbGYpDQpFL0xEOiAgcmVnaW9uICA0OiB2YSAweDQwMDE0MDAwIHBhIDB4OWU4YmYw
MDAgc2l6ZSAweDAwMTAwMCBmbGFncyByLS1zDQpFL0xEOiAgcmVnaW9uICA1OiB2YSAweDQwMDE1
MDAwIHBhIDB4OWU5MzQwMDAgc2l6ZSAweDAxMTAwMCBmbGFncyBydy1zIChzdGFjaykNCkUvTEQ6
ICByZWdpb24gIDY6IHZhIDB4NDAwMjYwMDAgcGEgMHg4ZWJmMDAwMCBzaXplIDB4MDAyMDAwIGZs
YWdzIHJ3LS0gKHBhcmFtKQ0KRS9MRDogIHJlZ2lvbiAgNzogdmEgMHg0MDA2ZTAwMCBwYSAweDll
OGMwMDAwIHNpemUgMHgwNTgwMDAgZmxhZ3Mgci14cyBbMF0NCkUvTEQ6ICByZWdpb24gIDg6IHZh
IDB4NDAwYzYwMDAgcGEgMHg5ZTkxODAwMCBzaXplIDB4MDFjMDAwIGZsYWdzIHJ3LXMgWzBdDQpF
L0xEOiAgIFswXSBiYzUwZDk3MS1kNGM5LTQyYzQtODJjYi0zNDNmYjdmMzc4OTYgQCAweDQwMDZl
MDAwDQpFL0xEOiAgQ2FsbCBzdGFjazoNCkUvTEQ6ICAgMHg0MDA2ZjM5NA0KRS9MRDogICAweDQw
MDk1ZWRjDQpFL0xEOiAgIDB4NDAwN2I1YTgNCkUvTEQ6ICAgMHg0MDA5ODVmYw0KRS9MRDogICAw
eDQwMDk4YTcwDQpFL0xEOiAgIDB4NDAwNmZhZTANCkUvTEQ6ICAgMHg0MDBhNTUwOA0KRS9MRDog
ICAweDQwMDk4YjljDQpEL1RDOj8gMCB1c2VyX3RhX2VudGVyOjE5NSB0ZWVfdXNlcl90YV9lbnRl
cjogVEEgcGFuaWNrZWQgd2l0aCBjb2RlIDB4ZmZmZjAwMDcNCkQvVEM6PyAwIHJlbGVhc2VfdGFf
Y3R4OjY3MCBSZWxlYXNpbmcgcGFuaWNrZWQgVEEgY3R4DQpEL1RDOj8gMCB0ZWVfdGFfaW52b2tl
X2NvbW1hbmQ6Nzk4IEVycm9yOiBmZmZmMzAyNCBvZiAzDQpbICAyMTguOTQ0NjgwXSB0cG0gdHBt
MDogZnRwbV90ZWVfdHBtX29wX3NlbmQ6IFNVQk1JVF9DT01NQU5EIGludm9rZSBlcnJvcjogMHhm
ZmZmMzAyNA0KWyAgMjE4Ljk1MjM3OV0gdHBtIHRwbTA6IHRwbV90cnlfdHJhbnNtaXQ6IHNlbmQo
KTogZXJyb3IgLTUzMjEyDQpEL1RDOj8gMCB0ZWVfdGFfaW52b2tlX2NvbW1hbmQ6Nzk4IEVycm9y
OiBmZmZmMzAyNCBvZiAzDQpbICAyMTguOTYzMzU5XSB0cG0gdHBtMDogZnRwbV90ZWVfdHBtX29w
X3NlbmQ6IFNVQk1JVF9DT01NQU5EIGludm9rZSBlcnJvcjogMHhmZmZmMzAyNA0KWyAgMjE4Ljk3
NDI0MV0gdHBtIHRwbTA6IHRwbV90cnlfdHJhbnNtaXQ6IHNlbmQoKTogZXJyb3IgLTUzMjEyDQpE
L1RDOj8gMCB0ZWVfdGFfaW52b2tlX2NvbW1hbmQ6Nzk4IEVycm9yOiBmZmZmMzAyNCBvZiAzDQpb
ICAyMTguOTg1Njc1XSB0cG0gdHBtMDogZnRwbV90ZWVfdHBtX29wX3NlbmQ6IFNVQk1JVF9DT01N
QU5EIGludm9rZSBlcnJvcjogMHhmZmZmMzAyNA0KWyAgMjE4Ljk5MzM2Nl0gdHBtIHRwbTA6IHRw
bV90cnlfdHJhbnNtaXQ6IHNlbmQoKTogZXJyb3IgLTUzMjEyDQpbICAyMTguOTk5MDQ0XSB0cG0g
dHBtMDogdHBtMl9jb21taXRfc3BhY2U6IGVycm9yIC0xNA0KRVJST1I6dGN0aTpzcmMvdHNzMi10
Y3RpL3RjdGktZGV2aWNlLmM6MTk4OnRjdGlfZGV2aWNlX3JlY2VpdmUoKUQvVEM6PyAwIHRlZV90
YV9pbnZva2VfY29tbWFuZDo3OTggRXJyb3I6IGZmZmYzMDI0IG9mIDMNCiBGYWlsZWQgdG8gZ2V0
IHJlc3BvbnNlIHNpemUgZmQgMywgZ290IGVycm5vIDE0OiBCYWQgYWRkcmVzcw0KRVsgIDIxOS4w
MTUzNTFdIHRwbSB0cG0wOiBmdHBtX3RlZV90cG1fb3Bfc2VuZDogU1VCTUlUX0NPTU1BTkQgaW52
b2tlIGVycm9yOiAweGZmZmYzMDI0DQpSUk9SOmVzeXM6c3JjL3RzczItZXN5cy9hcGkvRXN5c19D
cmVhdGVQcmltYXJ5LmM6NDA0OkVzeXNfQ3JlYXRlWyAgMjE5LjAyODM0OF0gdHBtIHRwbTA6IHRw
bV90cnlfdHJhbnNtaXQ6IHNlbmQoKTogZXJyb3IgLTUzMjEyDQpQcmltYXJ5X0ZpbmlzaCgpIFJl
Y2VpdmVkIGEgbm9uLVRQTSBFcnJvcg0KRVJST1I6ZXN5czpzcmMvdHNzMi1lc3lzL2FwaS9Fc3lz
X0NyZWF0ZVByaW1hcnkuYzoxMzU6RXN5c19DcmVhdGVQcmltYXJ5KCkgRXN5cyBGaW5pc2ggRXJy
b3JDb2RlICgweDAwMGEwMDBhKQ0KRVJST1I6IEVzeXNfQ3JlYXRlUHJpbWFyeSgweEEwMDBBKSAt
IHRjdGk6SU8gZmFpbHVyZQ0KRVJST1I6ZXN5czpzcmMvdHNzMi1lc3lzL2VzeXNfaXV0aWwuYzox
MTQ1Omllc3lzX2NoZWNrX3NlcXVlbmNlX2FzeW5jKCkgRXN5cyBjYWxsZWQgaW4gYmFkIHNlcXVl
bmNlLg0KRVJST1I6ZXN5czpzcmMvdHNzMi1lc3lzL2FwaS9Fc3lzX0ZsdXNoQ29udGV4dC5jOjY2
OkVzeXNfRmx1c2hDb250ZXh0KCkgRXJyb3IgaW4gYXN5bmMgZnVuY3Rpb24gRXJyb3JDb2RlICgw
eDAwMDcwMDA3KQ0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KVGhlIGxhc3Qgc3VnZ2VzdGlvbiBJ
IHNhdyB3YXMgdG8gY2hhbmdlIG15IGR0YiBmaWxlIHRvIGluY2x1ZGUgYSByZXNlcnZlZCBtZW1v
cnkgcmVnaW9uIGZvciBvcHRlZSBzaGFyZWQgbWVtb3J5IGFuZCBub3QgdXNlIHRoZSBkZWZhdWx0
IGR5bmFtaWMgc2hhcmVkIG1lbW9yeS4gIFRoZSBpc3N1ZSBJIGhhdmUgaXMga2VybmVsIDYuNi4x
MDAncyB0cG1fZnRwbV90ZWUgaWdub3JlcyB0aGUgIm1lbW9yeS1yZWdpb24iIGR0cyBzdGF0ZW1l
bnQgdGhhdCByZWZlcmVuY2VzIHRoZSBvcHRlZV9zaG0gcmVzZXJ2ZWQgbWVtb3J5IGF0IGF0IDB4
YTQwMDAwMDAgaW4gbXkgY2FzZS4gIEJlbG93IGlzIG15IHNuaXBwZXQgb2YgdGhlIGR0cyBmaWxl
LiAgSSBoZWFyZCB0aGVyZSBhcmUgcGF0Y2hlcyBpbiB0aGUga2VybmVsIGZ0cG0gZHJpdmVyIHRv
IHN1cHBvcnQgdGhlIHJlc2VydmVkIHNoYXJlZCBtZW1vcnksIGJ1dCBiZWZvcmUgSSB0cnkgdGhl
IHBhdGNoZXMsIGNhbiBhbnlvbmUgb3BpbmUgd2hldGhlciB0aGlzIGNvdWxkIGNhdXNlIHRoZSBw
YW5pYyB0aGF0IEkgYW0gc2VlaW5nPyAgVGhhbmtzIGluIGFkdmFuY2UgZm9yIGFueW9uZSB3aG8g
Y2FuIHNoYXJlIGFueSBpbmZvcm1hdGlvbg0KDQpvcHRlZV9zaG06IG9wdGVlLXNobUBhNDAwMDAw
MCB7DQogICAgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wiOw0KICAgIHJlZyA9IDwweDAg
MHhhNDAwMDAwMCAweDAgMHgwMTAwMDAwMD47DQogICAgbm8tbWFwOw0KICAgIHJldXNhYmxlOw0K
fTsNCg0KLi4uLg0KDQpmaXJtd2FyZSB7DQrigILigILigILigILigILigIJvcHRlZSB7DQrigILi
gILigILigILigILigILigILigILigILigILigILigIJjb21wYXRpYmxlID0gImxpbmFybyxvcHRl
ZS10eiI7DQrigILigILigILigILigILigILigILigILigILigILigILigIJtZXRob2QgPSAic21j
IjsNCuKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgm1lbW9yeS1yZWdpb24gPSA8
Jm9wdGVlX3NobT47DQrigILigILigILigILigILigIJ9Ow0KfQ0KDQoNCg0KDQpEZW5uaXMgS29u
ZywgUC5FbmcuDQpTdGFmZiBFbmdpbmVlcg0KUGVybGUgU3lzdGVtcyBMaW1pdGVkDQo2MCBSZW5m
cmV3IERyaXZlLA0KTWFya2hhbSwgT04gTDNSIDBFMQ0KKDkwNSkgNDc1LTYwNzAgZXh0LiAyMTI2
DQo=
